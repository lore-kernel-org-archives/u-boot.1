Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A6BC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 17:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244EE8744B;
	Thu, 16 Nov 2023 18:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Cifbswcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED8DD87443; Thu, 16 Nov 2023 18:16:41 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C628744B
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 18:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso8581785ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700154990; x=1700759790; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mpZ9e1aVXX4q4NnFwjC++Lw9ISR5yZZ1RuzRes+CN7Q=;
 b=CifbswcleVDW86/Vq7Yhd6191NjoZ3ABGvhYDmSO/SZf8NJjD1RDI7OIcnOqH8YvL9
 dKTBJ7OGvsm3gz4tQPumF8ETpgj0ATuU+GGCtRVrTj3d5A/ZZ6e0HhRBxZMEvV133VWc
 v+vraweZJSQ4aThhxzqwDBjz2xDMMq1ydEjekDmkHKh13oOYfb24aE7U3Cj03avjLvfm
 ct6mDOs6GwvOtmCbCWJnidozCX0swNLy/cQ5yvdI2roPxpGS3IunLijfXMdjASy9rUZ5
 CwuyA7Ul/N6Tw/lUb3b13JdH1TE5N4aohcA5/mFbIyxR7WqgrjMdRqKR7e1jItrN2ZUQ
 Avaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700154990; x=1700759790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mpZ9e1aVXX4q4NnFwjC++Lw9ISR5yZZ1RuzRes+CN7Q=;
 b=c/TxHahiXhR5FBFASL+4gm+YVPcrwmaa0BsR7FLbkY6XnAuvuNynpAEiWrf2kivhTA
 dU/iOGwfvWO/KEibHrzMtaItIghNNYY1qd3RrL5bInSuMG+ijj/BnLQ7NZf4VQGwn5EF
 I8xx3DYt0vQzSEv4zRw+yppAw1NjEI2eMAn8uB3Gxx6rc1zSE38rupBF4fba6bcfC/mK
 O/GEMcQp+iHOJDqqCF7tYbcV2deYDr130k784JfGZRmIJTnreT9XICrRpL4Ia/t6oWg9
 ulSY5E1KB191sZcBtF1zaRppbDB1d686FlMllcZUemyPfMnycGSoS3heM5s15+h1MJ9o
 tRvA==
X-Gm-Message-State: AOJu0YzAH7CaEoz87BAnaxdJH9J7itqV8ijjDD50vMDiMCmohwesafvZ
 eZC7Rr/A5P51ql4C9Q7dqqbuNA==
X-Google-Smtp-Source: AGHT+IESxRDzVW9h0JiMZbS65UwWw133C+IgZ2lKBVUoQd35cgStlqMVxUIX0cJIqd8pZoVLrLrvNA==
X-Received: by 2002:a17:903:2346:b0:1cc:5920:1d1c with SMTP id
 c6-20020a170903234600b001cc59201d1cmr3629119plh.48.1700154990143; 
 Thu, 16 Nov 2023 09:16:30 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:5040:ffd6:fb0a:3850])
 by smtp.googlemail.com with ESMTPSA id
 a2-20020a170902ee8200b001c737950e4dsm9541337pld.2.2023.11.16.09.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 09:16:29 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>, Sean Anderson <seanga2@gmail.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] fs: Fix SPL build if FS_LOADER is enabled
Date: Thu, 16 Nov 2023 22:46:12 +0530
Message-Id: <20231116171612.143910-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

If FS_LOADER is enabled for the SPL then the build fails with the error:

fs/fs.o:(.data.rel.fstypes+0x128):
undefined reference to `smh_fs_set_blk_dev'
fs/fs.o:(.data.rel.fstypes+0x140):
undefined reference to `smh_fs_size'
fs/fs.o:(.data.rel.fstypes+0x148):
undefined reference to `smh_fs_read'
fs/fs.o:(.data.rel.fstypes+0x150):
undefined reference to `smh_fs_write'

Fix the error by populating the semihosting entry in the fs_types array
only for non-SPL builds.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
Changes in v2:
- Use CONFIG_IS_ENABLED instead of CONFIG_SPL_BUILD

 fs/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs.c b/fs/fs.c
index 4cb4310c9c..5c27ae2fe1 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -256,7 +256,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 	},
 #endif
-#ifdef CONFIG_SEMIHOSTING
+#if CONFIG_IS_ENABLED(SEMIHOSTING)
 	{
 		.fstype = FS_TYPE_SEMIHOSTING,
 		.name = "semihosting",
-- 
2.34.1

