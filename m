Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD1EC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85464878B3;
	Mon,  4 Dec 2023 01:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nuXbuqgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB08878BD; Mon,  4 Dec 2023 01:30:33 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68ED6878B3
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d855efb920so2093426a34.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649830; x=1702254630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h47xfYy/I7WdlqDRjfa5GLDYkyDZ0PZVJ6fX2z4AhQY=;
 b=nuXbuqggGheu6crNsTKY+RGc1f6BTgiJj0Y7FiOni7dDLrez8pQQxfxBL7/hDSbZYi
 5EErkPW2L6c+cynSihgSQbpna5UPatatlKpmxbkY8HRIALnVQcKDhCiqEwbml+5enVIp
 v9NAgFTBwBFHED37GXSY4kHgZGw4V+pagg/Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649830; x=1702254630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h47xfYy/I7WdlqDRjfa5GLDYkyDZ0PZVJ6fX2z4AhQY=;
 b=RdZXNLOJaEjWMQVH+PMN2Oc6ZYD2BDrwOSp7UAY27zgaBuzjLnVZSXbZhqGhnIZyHX
 M7XtvNXo1UjWAyI+BI7DhreIjLh2e2WC8m5M5a88XUg8vT6uZX1AzjnmHc9Mq4fPoaaM
 ZrmngdOYt4QkmyHQ2/Rw0vKdl6AWeQBgmhc88hGbtNkL4QcfZFJIp4RZOKooX1iO6NO2
 vAZps8LiWB8uoiGHoTFpQX4/ZiK1sgbBZLSO8uIzkfGos2eV7Lb2VZ+UMrd0tD15J10l
 /x90rv53PD8f1xKsarLeqT4cEbmfeoqCT3FWG12mSK7vXcy0ekAOfFGr3bCSmp9eV8EF
 ozdw==
X-Gm-Message-State: AOJu0Ywk7tJEqIQ5m/7IklBHYSREVoMx+GL0qJQSJkjkNnyLJ+TK21Gq
 6uRq7Jqsh52shtWRjRGoNDgq6Yo3sYxaSBbCpwHCJg==
X-Google-Smtp-Source: AGHT+IH5Dvl9FWCdo7qN/8pSKoCKN9w5XEM3iB189d17AReYch2I3BKTjN0/cg9GBPWUk8WEIxQYqQ==
X-Received: by 2002:a05:6830:91b:b0:6d8:7820:aaf8 with SMTP id
 v27-20020a056830091b00b006d87820aaf8mr2815543ott.21.1701649830001; 
 Sun, 03 Dec 2023 16:30:30 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 10/13] x86: zboot: Rename zboot_start() to zboot_run()
Date: Sun,  3 Dec 2023 17:29:35 -0700
Message-ID: <20231204002944.897949-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
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

The term 'start' is used withint bootm and zboot to indicate the first
phase of booting an image.

Since zboot_start() does the whole boot, rename it to zboot_run() to
align with bootm_run() etc.

Fix a log message while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/zimage.c | 6 +++---
 boot/bootmeth_cros.c  | 6 +++---
 include/bootm.h       | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index b72e2f01bd57..e8a1849947e6 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -437,8 +437,8 @@ int zboot_go(void)
 	return ret;
 }
 
-int zboot_start(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-		ulong base, char *cmdline)
+int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+	      ulong base, char *cmdline)
 {
 	int ret;
 
@@ -463,7 +463,7 @@ int zboot_start(ulong addr, ulong size, ulong initrd, ulong initrd_size,
 		return log_msg_ret("set", ret);
 	ret = zboot_go();
 	if (ret)
-		return log_msg_ret("set", ret);
+		return log_msg_ret("go", ret);
 
 	return -EFAULT;
 }
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index cd72db8250ce..f015f2e1c75f 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -432,9 +432,9 @@ static int cros_boot(struct udevice *dev, struct bootflow *bflow)
 	}
 
 	if (IS_ENABLED(CONFIG_X86)) {
-		ret = zboot_start(map_to_sysmem(bflow->buf), bflow->size, 0, 0,
-				  map_to_sysmem(bflow->x86_setup),
-				  bflow->cmdline);
+		ret = zboot_run(map_to_sysmem(bflow->buf), bflow->size, 0, 0,
+				map_to_sysmem(bflow->x86_setup),
+				bflow->cmdline);
 	} else {
 		ret = bootm_boot_start(map_to_sysmem(bflow->buf),
 				       bflow->cmdline);
diff --git a/include/bootm.h b/include/bootm.h
index ce5298e4ed97..c815c40e3c4d 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -242,7 +242,7 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags);
 int bootm_process_cmdline_env(int flags);
 
 /**
- * zboot_start() - Boot a zimage
+ * zboot_run() - Run through the various steps to boot a zimage
  *
  * Boot a zimage, given the component parts
  *
@@ -255,8 +255,8 @@ int bootm_process_cmdline_env(int flags);
  * @cmdline: Command line to use for booting
  * Return: -EFAULT on error (normally it does not return)
  */
-int zboot_start(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-		ulong base, char *cmdline);
+int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+	      ulong base, char *cmdline);
 
 /*
  * zimage_get_kernel_version() - Get the version string from a kernel
-- 
2.43.0.rc2.451.g8631bc7472-goog

