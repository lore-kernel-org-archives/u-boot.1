Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A544CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 20:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8418384E;
	Mon, 27 Oct 2025 21:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="emj0mMMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC819838F8; Mon, 27 Oct 2025 21:56:41 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A5C83710
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 21:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ben.wolsieffer@hefring.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4ed02d102e2so8775821cf.1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1761598598; x=1762203398;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aQ+o+avD12AAfVz9lFkdBlwed1wlh/Lma89oofaWIOw=;
 b=emj0mMMnozuH5ccBlaGRi2a1FYoOw5Ky1ikK5dkOuAdlMIis90BCQukV2XODn0x69b
 umbT2Vbh6AwA2ZgA+sa4+b3RF9qeMvQGlOsx4JU+gIGJAOV5CL8X6GDYnIcA1EakCpKc
 pngg88BFnQvUktkW/qtbkxXox9f9Bci4C3EVZ//SiS9GTfPMuipKPRN2uHXd2DH8dfKP
 8kH+NacntG19UDns3qDkZ7a1FT0/ImH9pe129Lo05ZQUvwDxCznfehMqo4ItLgUOuus+
 kcW2BuCEVUidAIt/4y2HWBLbJroqbid+1/6DHTBop3Ls36SpJJjJhCxq5Eh401+aZLoL
 H/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761598598; x=1762203398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQ+o+avD12AAfVz9lFkdBlwed1wlh/Lma89oofaWIOw=;
 b=DdBb1dzI6brBtWCGCCMbf5tTGpIcH8P8931tEK3vP5+4KLBcfzutw5Ar6CvBbUC7jd
 Q6PNDuBjL1m99kYoE7Xjke97N3SO+28+3UE+xNwqE42k/mEi6Z95yZgaJGf82WRAL+52
 iQMDPcZT4Z/Yitl7+Si71FcbpKWIR8wweCHpu+43nVlSR0ebxB8E+sXRpZuOPXir98WX
 WVjb8IOtbH0CIsOB6Umjs3GezAklv4NoShbVt68PTKmNYvY0MYWhfDhVA3G8GS+CpVuQ
 nA0h6S/paKjs8OWC6lIp/UviU+QQbz+AYfvrdT1a99/u49oBEn0Zt+gcWk+27ljPf8xu
 OlHA==
X-Gm-Message-State: AOJu0YyUXsxpXfHkuhOHvC26mIDTNn+Fm+3RccHOKM8USTGhcKDo8oZb
 /rFp19jj2fsGC4YBd+kIdWpx076npZaAbghnBZLyjBDES8Wb5gfk9LBKEy+12SZRhB234KAUW13
 1PV07
X-Gm-Gg: ASbGncs0aql9GGbIWzukmUjkm6P4GGatD/qGBqZcnO1mlxE+tewoaxCx4o6+hfGDrJ1
 dchp8+0CWlzwoF7AKvDJ4whCzGzMMeKyWasItrJvHVBwrWZU86h8hkoHCAUfWLKZNDsJAMPhlIf
 t5xBvPPPy2hXecXdMZwMW0Eh2HfiqedL9MvEJ3wBQQLfYKxCv7EEwTlLaY8LnWoIupENJR9QFNt
 TOVpCvLjYIoU4jVdw9U6VY5c/yaSRdtbvR9Pi9yOGkZGnoqpvJJ1K6sR7ARVQoxE/ZUJYY4oxSF
 qnpTrPqh3Z9RS14SywnEd0fgt9EoRuA2gN2E2TOtdWxzCFnpduQz3VMn4IyMjmZW+h7ryBS74mQ
 Bw3PP+FBnKXSN51c6X2mScQ1C1OLuPNDCsy5uqmqhtlY2AbGTegS57WA17VqKMvtTQyy0KzAdi4
 WeiLkHyu64li5J8JNBuiGXpD1f
X-Google-Smtp-Source: AGHT+IHS/RMc69BVCD6bp1M0nbSQyJWh566RJIDZ/yu03HpcF67Q24QNvpak3hQpCQWJnn7fglIOKA==
X-Received: by 2002:ac8:6f0e:0:b0:4ed:1cf:1335 with SMTP id
 d75a77b69052e-4ed07510f57mr19613951cf.36.1761598597778; 
 Mon, 27 Oct 2025 13:56:37 -0700 (PDT)
Received: from dell-xps-15-9500.lan ([2601:18c:8002:3d40:7967:4a6b:db27:675b])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f254a41cdsm670154085a.29.2025.10.27.13.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 13:56:36 -0700 (PDT)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] efi: video: fix mode info in payload mode
Date: Mon, 27 Oct 2025 16:56:27 -0400
Message-ID: <20251027205627.3742502-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Currently, the EFI framebuffer is non-functional in payload mode. It
always reports: "No video mode configured in EFI!"

This is caused by a copy-paste error that replaced
"struct efi_entry_gopmode" with "struct efi_gop_mode".

Fix the type and add a cast to avoid a warning because the "info" field
is declared as an anonymous struct rather than
"struct efi_gop_mode_info" (see the comment in efi.h).

Fixes: 88753816cf54 ("efi: video: Move payload code into a function")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/video/efi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/efi.c b/drivers/video/efi.c
index 78d123fad4be..60df4334f1ed 100644
--- a/drivers/video/efi.c
+++ b/drivers/video/efi.c
@@ -104,7 +104,7 @@ static int get_mode_info(struct vesa_mode_info *vesa, u64 *fbp,
 static int get_mode_from_entry(struct vesa_mode_info *vesa, u64 *fbp,
 			       struct efi_gop_mode_info **infop)
 {
-	struct efi_gop_mode *mode;
+	struct efi_entry_gopmode *mode;
 	int size;
 	int ret;
 
@@ -117,7 +117,7 @@ static int get_mode_from_entry(struct vesa_mode_info *vesa, u64 *fbp,
 	*fbp = mode->fb_base;
 	vesa->x_resolution = mode->info->width;
 	vesa->y_resolution = mode->info->height;
-	*infop = mode->info;
+	*infop = (struct efi_gop_mode_info *)mode->info;
 
 	return 0;
 }
-- 
2.51.1

