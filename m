Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B17BD4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB163895AB;
	Tue, 19 Nov 2024 14:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QY9ooJnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0037B895AA; Tue, 19 Nov 2024 14:19:00 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30B989596
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a76fd74099so3571145ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022337; x=1732627137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdtXUPrsunB7heYatcKGttPGveS09uVu7sUrBfDim3g=;
 b=QY9ooJnbdBGwqCDHnENXV2Z9+bw/xL5pBVTY8YVH5o+MymoJ78kK+oc5YgGYvCyqjV
 aD0aJyCuS8LKpI60sYg1tJtR5RkI+cUmgg63wg+n+qp9IwG4CmjYIPSHPXOS6QcO5KLO
 PtbF7HlCyr4EQLKTXryTGejDAMsV+YijC3lqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022337; x=1732627137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdtXUPrsunB7heYatcKGttPGveS09uVu7sUrBfDim3g=;
 b=gZIgLQ4gy4BMK0ZcHOGGhHg/iUw8Qn6ms/0PFpSVM7ZuWB/v02aq62CyuoIgzXYUDF
 /PUqBCwj7mVUEot7IS07UlzS7VhT0oAIfSuR9fKf4ehbSZh9s0Ga1F4ziXuUY7ftYw7T
 It0udWQ1TPPLrE1H53TWR+kofITybhuiChSCYxzrp4BMgG5fOf3zrY7SNIWs4TTyz82A
 HDYh1IQdqbQlaib5o2jDHx9R82TYAZ1ap//Sn1O5XwTSRSXigWL5IZJlhg2cBoAiB/Mg
 eoJFobc4EoROb/y0haE2OD0cdQfyJ3PHrc7FIcgmF9B+8XF/7yVs24Tr36rpXd1bW0RB
 rmUA==
X-Gm-Message-State: AOJu0YzX3noSVYXfbVm5GVBm3+EZH+35oGKye9VqzlC2EE9fuRPNNMPz
 SLoENXpTsmNW4z/RXiDEfABER5LTibJIf3HsBmr6aUKgfkfoIsEV0PNlhrZuUdA0tbfWx50Xthk
 =
X-Google-Smtp-Source: AGHT+IFi2zeRgbayeTTayyt2ay/6xATzHm1+/Lbtu1MVWfowEVUXELpbtZCfTa2hBO/G3L5cBAJn+Q==
X-Received: by 2002:a05:6e02:20c6:b0:3a7:6e72:fbb5 with SMTP id
 e9e14a558f8ab-3a76e7301abmr66694955ab.8.1732022336971; 
 Tue, 19 Nov 2024 05:18:56 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:18:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 02/39] x86: Rename zboot_run() to zboot_run_args()
Date: Tue, 19 Nov 2024 06:18:07 -0700
Message-Id: <20241119131844.4078144-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Rename this function so we can (later) create a zboot_run() function
which looks the same as bootm_run()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/zimage.c | 4 ++--
 boot/bootmeth_cros.c  | 6 +++---
 include/bootm.h       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 73a21bc8f03..53fc81f57a2 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -436,8 +436,8 @@ int zboot_go(void)
 	return ret;
 }
 
-int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-	      ulong base, char *cmdline)
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline)
 {
 	int ret;
 
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index c7b862e512a..ea4c9ed830f 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -446,9 +446,9 @@ static int cros_boot(struct udevice *dev, struct bootflow *bflow)
 	}
 
 	if (IS_ENABLED(CONFIG_X86)) {
-		ret = zboot_run(map_to_sysmem(bflow->buf), bflow->size, 0, 0,
-				map_to_sysmem(bflow->x86_setup),
-				bflow->cmdline);
+		ret = zboot_run_args(map_to_sysmem(bflow->buf), bflow->size, 0,
+				     0, map_to_sysmem(bflow->x86_setup),
+				     bflow->cmdline);
 	} else {
 		ret = bootm_boot_start(map_to_sysmem(bflow->buf),
 				       bflow->cmdline);
diff --git a/include/bootm.h b/include/bootm.h
index 61160705215..154fb98cfcd 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -273,7 +273,7 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags);
 int bootm_process_cmdline_env(int flags);
 
 /**
- * zboot_run() - Run through the various steps to boot a zimage
+ * zboot_run_args() - Run through the various steps to boot a zimage
  *
  * Boot a zimage, given the component parts
  *
@@ -289,8 +289,8 @@ int bootm_process_cmdline_env(int flags);
  *	to use for booting
  * Return: -EFAULT on error (normally it does not return)
  */
-int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-	      ulong base, char *cmdline);
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline);
 
 /*
  * zimage_get_kernel_version() - Get the version string from a kernel
-- 
2.34.1

