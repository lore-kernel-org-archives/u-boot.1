Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44551D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE7F8931A;
	Sat, 19 Oct 2024 17:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MIJxYft+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66783892FD; Sat, 19 Oct 2024 17:22:55 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428A4892FA
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83abcfb9f37so58134539f.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351371; x=1729956171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xpABZGTIu+5TSQTMhZyOBge8DczwvVjHdW3BSOmyLrg=;
 b=MIJxYft+282RqYyHfX2ChqJs1ETkEECeeJUn3w65hUFmicv8gzbn8aAYgxxAPSfGJM
 JG2F3/SbZT+3GaqY3HjJ4E8q3DxIvvLvu6ICJR8eRM6BCTLG8w++WxdO8Xc76Me2G4Ok
 ppMlXCetzt8a97H9E8/Ryj1YlASNQkLl1QuuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351371; x=1729956171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpABZGTIu+5TSQTMhZyOBge8DczwvVjHdW3BSOmyLrg=;
 b=K0wxiFVVctj/KAN6YR149QXHj1v67H6WO+aMOkXULYUWXvHDzcjTeleIyz2+CxM4a4
 bP+ikw50j//pKKsZlMytYYGy3kOvMHt+9C52H4mK2MDWm9E1ZLHDv2pMYdSDFJN3aK17
 N+aBx/Zy4vE4O5iFTpnT5j5+o4Mz+Fk7f9A3gM68bkr8nJxPLt1esN8xgpFTeA8+gxNy
 F4JYqopwrkah/qW2Qbh+TLKKNYleITAJp6ceVn4vhrYETFtkyOObvlHBRCdLASt6G82h
 vwRV4O0ivdCJZycpXnpWuaFTZzr/FMiKs7D4OX6cXSBoqZSS+6YOEdzqxpj4rBI4wGKQ
 TS3Q==
X-Gm-Message-State: AOJu0YzV4BHr6KPr/HotnegQP+iUtC9K5iHCP9KSOcNUDGEWZs+v6+Vy
 e2z2J5G4JQSmyihuwrRAwimCZhJC18mPO/jkOVPwLCwf/+r+iifIcyLCISvn+DB2hLeeCLAmTwE
 =
X-Google-Smtp-Source: AGHT+IFk9wbS3bLSUTHIcfXurD8bbr5+Ew63mVHJPcCf9hkX9//jCjXeNo1jLO8YFcxkEies1jktUQ==
X-Received: by 2002:a05:6602:6d19:b0:82a:2a67:9429 with SMTP id
 ca18e2360f4ac-83aba5cb38amr582307139f.5.1729351370872; 
 Sat, 19 Oct 2024 08:22:50 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 19/31] bootstd: cros: Correct the x86-setup address
Date: Sat, 19 Oct 2024 09:21:59 -0600
Message-Id: <20241019152211.1014896-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

This should really use an address rather than the buffer. Update it in
the command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/bootflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 5f656814b29..3e9769e0d42 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -403,7 +403,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		puts("(none)");
 	putc('\n');
 	if (bflow->x86_setup)
-		printf("X86 setup: %p\n", bflow->x86_setup);
+		printf("X86 setup: %lx\n",
+		       (ulong)map_to_sysmem(bflow->x86_setup));
 	printf("Logo:      %s\n", bflow->logo ?
 	       simple_xtoa((ulong)map_to_sysmem(bflow->logo)) : "(none)");
 	if (bflow->logo) {
-- 
2.34.1

