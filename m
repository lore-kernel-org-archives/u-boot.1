Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262E0C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8D6808A2;
	Thu,  6 Mar 2025 01:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Km6BC7gF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9218A80FE2; Thu,  6 Mar 2025 01:26:32 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B238680805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85aec8c95c4so9431139f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220787; x=1741825587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyuX5hWJaJbae1lAGpdGttZkjd1FnMz88ulYyngA4tA=;
 b=Km6BC7gFoa18+vgkDTLIBWLK90TxiCbxV+4tV4haXYxgvPvCMVwBxhEqQ/wf1ejbiy
 xTq3wfg6UbMwvSSzdPDAXnvq2uVADxq8iceML3xVasTIeDOHVrEUhgbpuloVP8VxAdx/
 TyL8GTFgGU52P/efhFP2f1PTqLs8XBQdVIklg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220787; x=1741825587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyuX5hWJaJbae1lAGpdGttZkjd1FnMz88ulYyngA4tA=;
 b=d6YAKMD+flTIB9mjHp63As7HWLvgci5qY5Fhjtu95XBGKbHmDVBrPCxXcuK3BipqW0
 61uTN/ZlYqEVuz+EBDIXX6XmYeSildxrx1zBkYsxfjZ6te6ITvqgdmDl+YToTtqzs/ND
 jMSvfWJkOPjqR+S4GbVVkX2jc3ifGrXxuTPda1taB32CxTHYUTBgPfKULYjb/3/cEskL
 oELez5nYiwp46WvxgtJVjUMizVSTrsmGF2rszPejqhjwIk9K09WPMHWvdwt/rWFdJQRt
 VTF0tKC09+tim5pkbKp7JbQBLXg3ydHL6CHYtNHN1LPQ1TilgO1GmfwaX0290LVJ1p4N
 N2rQ==
X-Gm-Message-State: AOJu0YwdpTy34RJHjQnmMBE6PKc3r9non/vCwXj6ukWzsNx+TdA4zIwV
 eFZ+wnydeLXWg6qc5MCwmcMmNbt4ky6yK5fDXhDa+QUJl1uOWQNnVEWFih0bj0dlhue6MLnOIjI
 =
X-Gm-Gg: ASbGncvJOGss/KCUQBAxmsdpQqi0FcpdhhXljqEtaAtS+NJ0WDqBSBpPXOWYecw4VjP
 HgEWr7NulaxYGQS2Cjf6UX5cB4Mm5bdQzAV0Qtr8pA21A1W23F5ZKl4HuSCyccR+UhjOoWzauR4
 O/ycBitbNdVCFaMATnVOyRmK2C6QiHm4tZe5QFaK/EuBbeL0XtJHa/W5aqq37+UFaJEJvCUxzQh
 tVF5w/uk/3h4sVcsJ74uGr5loimPMAqdPy9Lvix8YxDJnwRu+Xa5k4FdPrmMXsSd3jX6oh5pK5D
 mV6x+QOZ0UC9ZP4Y/m2V+8gsY+FhHhJfKht93ER59hZNrGQ9F2kQiG5SG8IdEDmWhqRhwB8l5xg
 e7WgLAw==
X-Google-Smtp-Source: AGHT+IH7NLs8D+qFrVvJysSZncFsxTSRA/d4OZ+fWBX24pGTKk3KLnam4lfyxvY83v37RmHYS+DfEQ==
X-Received: by 2002:a05:6602:4a06:b0:85a:e24f:2b60 with SMTP id
 ca18e2360f4ac-85aff89b196mr846681839f.4.1741220786888; 
 Wed, 05 Mar 2025 16:26:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 02/29] x86: Rename zboot_run() to zboot_run_args()
Date: Wed,  5 Mar 2025 17:24:56 -0700
Message-ID: <20250306002533.2380866-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

(no changes since v1)

 arch/x86/lib/zimage.c | 4 ++--
 boot/bootmeth_cros.c  | 6 +++---
 include/bootm.h       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 2eece34a073..8d791416066 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -435,8 +435,8 @@ int zboot_go(void)
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
2.43.0

