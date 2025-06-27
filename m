Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7759C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 17:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF6B80C83;
	Fri, 27 Jun 2025 19:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GcMa7d7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8203F81D5D; Fri, 27 Jun 2025 19:29:55 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9524A806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2eb6c422828so1862988fac.1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751045389; x=1751650189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bQEDpixjU/9w10TsQ6wmF5tlmM84MjsEkpUVjmkH6yM=;
 b=GcMa7d7C2kR6yQZtmQKHNqYfni6c9NqNsGvx3Zejq1apcIZM7wVGL5bPgc8KGwTvCt
 hNe9zKOiY6J5AbYhapoFWFjj3n+j/riyuSwp3CF/wltDgCsrfoJBRsATbF+Ftx0pJhi2
 uaUWP7zn64y6DuagE7kHDFdcKYK805VzKmPdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751045389; x=1751650189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bQEDpixjU/9w10TsQ6wmF5tlmM84MjsEkpUVjmkH6yM=;
 b=plugaemvU9vRZsZcGgqusZtWIfmUDg9aViPIB4Yl5SSDFbP8tS4Gpm3CiTQrlOO5fA
 TEJEo3fT569Pf3CqRUZHIEE3vRLbAEBswn3LEtx2u3aXUBD/wpLHZzY6nMK2WNDnGdEI
 CXuPwRdRW1kMh+hF95Iq+xWHhipO8nAmgDMI+7VJlUz01xL24/mwOQoVc6rBJ2ej97lc
 NmP8e0PykIcb/gJlF2DdsCZ3/aY/3S+G7IG5T/COGNLLGLiVLi3PVioNOYk3yRcIX0XD
 AM3yA3g28oShKSVAbrLevEXWzgj6uDjP2eZlhR3Jmcn9Z/ve5f/uk3XY6jvXH0e9donG
 Vuag==
X-Gm-Message-State: AOJu0YyOxfa69hxqI9erR7vAmKvTaGGVWHpHaOKJfNwNLgaETmkIB1dH
 PgcUuZn1MzxBcq27tXMZgQzegWeZGT75OVIpt+AWmiYlyDJrkr3IgSPw1Qrk+eg78OhoGkeidNm
 SwPwLj58=
X-Gm-Gg: ASbGncu9ugopgl6/kiPOj+1Om986zQR51pUlmaB/2DapvR8gzohmWp3Yrc+ahZW/hOZ
 ZTk20yIHULDFKy3rilfb7IzD2Dhjgho/T4iV+PU3U7mN3HrovVc8AhQMDP8ocQjuGElEqRBdJG1
 c1nH6TNxir8F+dsz5+C844TUY3aUKNOKOzYQu0PtFy1QxyMu4wTP6JhkcQ1ffwnGPzLR4gM6ACl
 mPY3Ym5nkmWPbyYxHSIv7sbmAZ7ZE/a+F7t8GEjQUYkKUpLxuqj5ZHYGE4JmC1BcDzSx1TI+p2E
 0SMLIW2+m7Jgt2l/gGd+/Bw/P6Ang49LxB1CJIc5tgAsD2tkU9uytMXmQ7r8bAfG2HSErGhd+/J
 jRzCXlvctJoohn/CwMzA5xhK/WQ==
X-Google-Smtp-Source: AGHT+IFXnXOoQdfBjDuI15r8RMzfYAbLr0ZAl/lsCwIhchChFT+kD6TzjAMeK3W8+u9Pxgf2nIhYZw==
X-Received: by 2002:a05:6870:e3cb:b0:2eb:a2ef:901b with SMTP id
 586e51a60fabf-2efed676191mr2804104fac.14.1751045389124; 
 Fri, 27 Jun 2025 10:29:49 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f852bsm973213fac.33.2025.06.27.10.29.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 10:29:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] fit-dtb.blob.gz: Pass "-n" to gzip
Date: Fri, 27 Jun 2025 11:29:47 -0600
Message-ID: <20250627172947.3876739-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Sometimes when building a platform such as imx28_btt3 we can get an
error such as:

gzip: fit-dtb.blob: warning: file timestamp out of range for gzip format
make[1]: *** [Makefile:1219: fit-dtb.blob.gz] Error 2
make[1]: *** Deleting file 'fit-dtb.blob.gz'
make: *** [Makefile:186: sub-make] Error 2

This is typically resolved by telling gzip to ignore the timestamp.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e60bbb01a004..5a238ab9b5da 100644
--- a/Makefile
+++ b/Makefile
@@ -1216,7 +1216,7 @@ FINAL_DTB_CONTAINER = fit-dtb.blob
 endif
 
 fit-dtb.blob.gz: fit-dtb.blob
-	@gzip -kf9 $< > $@
+	@gzip -nkf9 $< > $@
 
 fit-dtb.blob.lzo: fit-dtb.blob
 	@lzop -f9 $< > $@
-- 
2.43.0

