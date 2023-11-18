Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0241FC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3ACD87134;
	Sat, 18 Nov 2023 23:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="AC1qloxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E849186FE4; Sat, 18 Nov 2023 23:08:00 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3478874A3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40859c464daso5992005e9.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 14:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700345271; x=1700950071;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4oHWkqzNfUJFbTuMhrOMq3JyS2SbNuT/X+zIxPo4ZY=;
 b=AC1qloxNzWzgTclzM48o/yuTLDNxS+l43/RBlzSKwwK6GzZDbLXrnUrdJ8rMvWk65L
 I8NBNj8W9wyIzlsYJLrLDdSjS+LxwhJW1f0tyWHfJWfBEscnWLBj+PlczPPB7pnR09YP
 gdao3QE6q97zX7tXDeeMhZQ5I1rwU8IXyoSXFV0DqAPRMOdUrRF+8H78oz9YRGnlHNKt
 2WewfBNIwdVb0nAbvI+7/w+nlalwPh4RyuJmwFlouO8fjzePqVWqazaRWL1OQpOeCGnp
 UnCG5jrNLq9sauS6NFILJ6GS7tuAQ1dpa8iLoASicvd0tG8wm1huco4/Ja56NU46qYjk
 nepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700345271; x=1700950071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4oHWkqzNfUJFbTuMhrOMq3JyS2SbNuT/X+zIxPo4ZY=;
 b=F7Pk59WdmMYA2feKq2Gf4YuiM6q0Hwg1PNvhDJU9jrpDjyws76gwpkZAtLrp+RDQOP
 jKV7DP2XYq0GfAhgruPBAQYcUFSyRiCjxN+NkbdTxTdYDPf2aLlfm/z2pqykRpyMKPoJ
 DUFHobmJjH8R0f7CixMLLvteNscJkDkh7b6zY2xm1H5Ouuc9X6QZKuj/s6er+JHlld13
 Vm0ICNQ4TLDChpS/uVVeZw3NnQnSt95bjuNj3HQM+Is+JbBkK7/5B/xnGQtaL4dMRcxO
 J0m+/9jykyWLr9xzcd5id4g7Puq7dnAd+b0X0eiH3ra+nkkAdHab9sxT7ALFCBrRS18r
 WY/w==
X-Gm-Message-State: AOJu0YzeHNSrhYFMrXnivqMF7hX2DinEK7JK15aKOvz/saXUg/eHNRvn
 YDiwokxH9KZ59Tc5GMRBrP7qE4S5SFCap7vFtvPiMqIg
X-Google-Smtp-Source: AGHT+IGsoQCQ97Nps7Xq4RyQP9NsuFnWkjsdDD/nVdPIdt9nuPnpmESzZPMh2gv0FHVwN0+4eX25Pg==
X-Received: by 2002:a05:600c:154b:b0:409:c1e:7fe8 with SMTP id
 f11-20020a05600c154b00b004090c1e7fe8mr2492515wmg.19.1700345271030; 
 Sat, 18 Nov 2023 14:07:51 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b00407752bd834sm7791581wmq.1.2023.11.18.14.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 14:07:50 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v3 3/4] bootflow: bootmeth_efi: Handle fdt not available.
Date: Sat, 18 Nov 2023 22:06:33 +0000
Message-Id: <20231118220634.1271886-2-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118220634.1271886-1-i@shantur.com>
References: <20231118220313.1271556-1-i@shantur.com>
 <20231118220634.1271886-1-i@shantur.com>
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

While booting with efi, if fdt isn't available externally,
just use the built-in one.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 19 +++++++++++++------
 include/bootflow.h  |  2 ++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 183daad8f1..370d6fba9f 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -313,6 +313,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 		 */
 	} else {
 		log_debug("No device tree available\n");
+		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
 	}
 
 	return 0;
@@ -391,6 +392,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		bflow->fdt_addr = fdt_addr;
 	} else {
 		log_debug("No device tree available\n");
+		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
 	}
 
 	bflow->state = BOOTFLOWST_READY;
@@ -429,13 +431,11 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 			return log_msg_ret("read", ret);
 
 		/*
-		 * use the provided device tree if available, else fall back to
-		 * the control FDT
+		 * use the provided device tree if not using the built-in fdt
 		 */
-		if (bflow->fdt_fname)
+		if (bflow->flags & ~BOOTFLOWF_USE_BUILTIN_FDT)
 			fdt = bflow->fdt_addr;
-		else
-			fdt = (ulong)map_to_sysmem(gd->fdt_blob);
+
 	} else {
 		/*
 		 * This doesn't actually work for network devices:
@@ -452,7 +452,14 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 	 * At some point we can add a real interface to bootefi so we can call
 	 * this directly. For now, go through the CLI, like distro boot.
 	 */
-	snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
+	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
+		log_debug("Booting with built-in fdt\n");
+		snprintf(cmd, sizeof(cmd), "bootefi %lx", kernel);
+	} else {
+		log_debug("Booting with external fdt\n");
+		snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
+	}
+
 	if (run_command(cmd, 0))
 		return log_msg_ret("run", -EINVAL);
 
diff --git a/include/bootflow.h b/include/bootflow.h
index fede8f22a2..42112874f6 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -45,10 +45,12 @@ enum bootflow_state_t {
  *	CONFIG_OF_HAS_PRIOR_STAGE is enabled
  * @BOOTFLOWF_STATIC_BUF: Indicates that @bflow->buf is statically set, rather
  *	than being allocated by malloc().
+ * @BOOTFLOWF_USE_BUILTIN_FDT : Indicates that current bootflow uses built-in FDT
  */
 enum bootflow_flags_t {
 	BOOTFLOWF_USE_PRIOR_FDT	= 1 << 0,
 	BOOTFLOWF_STATIC_BUF	= 1 << 1,
+	BOOTFLOWF_USE_BUILTIN_FDT	= 1 << 2,
 };
 
 /**
-- 
2.40.1

