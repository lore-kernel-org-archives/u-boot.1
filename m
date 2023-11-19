Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A486C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 16:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9243487005;
	Sun, 19 Nov 2023 17:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="mJkhsU4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1A687257; Sun, 19 Nov 2023 17:56:27 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66183870EB
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 17:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso10050635e9.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700412975; x=1701017775;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5frSlkL+IltF040NhQeirpIbSXW3cB2vGlIt4tvu3Cs=;
 b=mJkhsU4pm5J1OVLOehZuhpkdu+JwMhRxLDz0BTW/Mk/XtwWd69FQWJIToFNNuLZRzf
 PPCb9kyPAF0lD92SUkQejO4sWFam9BzMWXbgRVeJdEkYldsfcr5XfHBm3NbkEx2zNKUZ
 kHHER62Axhmi+eNu9EUOvrZC8FDqIDvWliiHH3QWjGhA2IpcG55KZrsaXS+7RcyG7iFB
 VsOuKBTyKGP8n1WaIU0HExRJlTJxL9dF0ILPTSSaZjpkR3MoDvj4hxj4iDxWeybtksFE
 5O32J7CoXHDBKYs3EuH93OOGVOqKfk6XayK8/JWB8Jhimxxee7/6Qhf9+uG36qckh9gJ
 428w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700412975; x=1701017775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5frSlkL+IltF040NhQeirpIbSXW3cB2vGlIt4tvu3Cs=;
 b=tsz7JyM4nT7cgRKNffiM2zBDs2h3Cufe4zOfbCJC5cXDL3+fVq+rYY58ATLSmMFJiz
 8veQ/SxKZWT6MjqaPsOqE70SBk9XGvgLBKUa811h4M6+zDzgtkdqqoqAamXl13o00B+/
 wCCQZSW94Jre6FVt1GS6V3+JJSrt74s8rJQdHOi0ng1bJVvPByK+rg7CYIHNQrJV1kkx
 Zsb2Llk6+p2wbNfr6YvEavLuzikRKcDra1/so3Gc7eOXOFdISyXhPcr+hSmc6PyADT9h
 bPRH5FUQqRNzNPPlo/SftCpfUgpDj6xvAWKUM97FzG+9U823mqzi+8jP2vJPTbhBOK/X
 A15Q==
X-Gm-Message-State: AOJu0YyW+vdAYS0ajv9ERC1lefltg2QHn15y/pox1CrqqTUJwWcUUyt3
 LKL24lbOeOyaYVYVNhljLA9N1Mqc97oDMCylqKHr4VxG
X-Google-Smtp-Source: AGHT+IH5MHtoWTWrX7HsbskfmDPXa5LKTYt94FZVdHa4UFOlMGxC1vMWn/bCB+wOBciVy1VTbA2Miw==
X-Received: by 2002:a05:600c:21c2:b0:406:53c0:3c71 with SMTP id
 x2-20020a05600c21c200b0040653c03c71mr3809581wmj.37.1700412975523; 
 Sun, 19 Nov 2023 08:56:15 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b0040684abb623sm14483754wmc.24.2023.11.19.08.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 08:56:15 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Shantur Rathore <i@shantur.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 3/4] bootflow: bootmeth_efi: Handle fdt not available.
Date: Sun, 19 Nov 2023 16:55:00 +0000
Message-Id: <20231119165501.1305136-4-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231119165501.1305136-1-i@shantur.com>
References: <20231119165501.1305136-1-i@shantur.com>
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

Reviewed-by: Simon Glass <sjg@chromium.org>

Signed-off-by: Shantur Rathore <i@shantur.com>
---

Changes in v4:
- Update code to use BUILT_IN_FDT flag as suggested

 boot/bootmeth_efi.c | 19 +++++++++++++------
 include/bootflow.h  |  2 ++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index fd224f7c91..e884dc6293 100644
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

