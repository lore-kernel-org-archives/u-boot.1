Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1386CC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A996C81DF6;
	Fri, 28 Mar 2025 16:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J+s9AVuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E78881DCC; Fri, 28 Mar 2025 16:35:41 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D71181DB4
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85b4277d0fbso73533139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176133; x=1743780933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQFP2M+hSI0/F4RqhZR9nvNeaybgPUUpM5wZ+Fusg6U=;
 b=J+s9AVuSViOleO3p1WGN+5D5yky9hB92gTh/d4F3rLP99l0alS96197Vhtns0l04QR
 ByNwkq7QL/YYDNCVO+quBS9d2r4E2D2NuVDsPhnmGRUPQDJMLytr7ZVKrkJydvt13FpB
 MuVvKA3VTXz2R+zU0WRnFBT13xYWbXJV4xnOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176133; x=1743780933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQFP2M+hSI0/F4RqhZR9nvNeaybgPUUpM5wZ+Fusg6U=;
 b=elf+ezEv39r0/Emu8Das1IhY6mABSpnsKssQNjSETdrZlKODcb3Mkoy5h1Kkh52mnp
 pDSl3YBZrYsmYVP3AplGd54JEafu7lW32HrCxIZs1JAI5fqInN51JwXeQZrS2kjLmA7U
 9UlaspsEwLBXIrLnKaqv8FMlHnB0c6FaATLUrr6VD4jPJlQ6X/S7ZwBfSmA+GJ/2fESB
 nnduT9pdgHA4HBSyUEdAIODt6Q0Ca0XQheaHtXMXsjb8pmWPdTR7RgkqFUs5q5bFAWjd
 g9mb3X+ZecU3YFgeUefA/ZkR7Ts1XmbECCNv1bnhvn0K+hnC4DaWtJgu0u6E4NkY4h5U
 vLZQ==
X-Gm-Message-State: AOJu0YzJuXRfqzrnyYkh/EnZO0/f5SGs5DylRI1+OYYzGgofjsN8tAAB
 QeCXsN5M8sJiMBHFLalQtDHvfzOEYWIKFf8xHGtoA8RVyW6TZjrFc+Yh+3jdC1rGFDpm7HmlXDU
 =
X-Gm-Gg: ASbGnctvBx/VL4+T/T8m+rcGlGF71/RVZN8MV7ZwBx4e+0SLU8/yV5/heYtUlSc7vms
 AxSW1nNcUozV3K/NqPHYCdR6A6rJIIt4bWqSPN6KB1SBJLfis5I3Ru2meVW6kxfzNsVslFvWPfC
 umcJ6wYyhFQQE3IMToX/HPYC5a1hN1C6DOStwKeJ8kEWfDpXrJALRVQ7aDfBv0TYdbqx3PYvhLE
 Xr4f4e92wE+GyW03srL572iI+0TGvUEwzY/G1bbPcXOH+Roxu5aYbh4kCO6GnDw+jNvXjEqZDf1
 3leUCMNyAekXyDtJzwSOISfDk9Cu+XmY5vHOOTM//Ol1CAbMF57ctEqgDwdQw/Sh74IKk2CVhMb
 e3I7mZA==
X-Google-Smtp-Source: AGHT+IFfuxqGYDqX5ZEkxP++UdZ/joClLJ+ydZ7AKo/GLZYynm0aoL6iLOLu+XgrAS9neAspzHdgXQ==
X-Received: by 2002:a05:6602:3897:b0:85c:c7f9:9a23 with SMTP id
 ca18e2360f4ac-85e8217f462mr1178985739f.14.1743176133452; 
 Fri, 28 Mar 2025 08:35:33 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/31] spl: Adjust xPL symbols
Date: Fri, 28 Mar 2025 09:34:41 -0600
Message-ID: <20250328153522.3555472-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Update for the new xPL naming, which was missed in a previous patch
which purported to do this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/spl/spl_reloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
index 324b98eaf98..216c0f36623 100644
--- a/common/spl/spl_reloc.c
+++ b/common/spl/spl_reloc.c
@@ -59,7 +59,7 @@ static int setup_layout(struct spl_image_info *image, ulong *addrp)
 	uint need_size = image->size + image->fdt_size;
 	margin = buf_size - need_size;
 	log_debug("spl_reloc %s->%s: margin%s%lx limit %lx fdt_size %lx base %lx avail %x image %x fdt %lx need %x\n",
-		  spl_phase_name(spl_phase()), spl_phase_name(spl_phase() + 1),
+		  xpl_name(xpl_phase()), xpl_name(xpl_phase() + 1),
 		  margin >= 0 ? " " : " -", abs(margin), limit, fdt_size, base,
 		  buf_size, image->size, image->fdt_size, need_size);
 	if (margin < 0) {
-- 
2.43.0

