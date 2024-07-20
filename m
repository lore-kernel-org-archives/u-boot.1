Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28FEC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B1D88C42;
	Sat, 20 Jul 2024 08:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bqjb96oy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4EE88C30; Sat, 20 Jul 2024 08:20:48 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E488888AAA
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36799fb93baso1234707f8f.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456446; x=1722061246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeX4KNIlBiOsx8/AyincKX+aLnttLUVUCpjMsTiVBaA=;
 b=bqjb96oy/I/lC/6MuQCcs67GqjZ66Besolp0/pFAZCeZfD5imrbjIlssWSCNgHm/sG
 ETPMZ+q9I9Sv3fqhqjMqh28Fx7lrDE6dPQx2xQM5JY9DhhZ/aVNEyU8bJMF20AP7zvl3
 zMdD8RhIb/absOH90OL63slnHwSYRLIFtj3O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456446; x=1722061246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeX4KNIlBiOsx8/AyincKX+aLnttLUVUCpjMsTiVBaA=;
 b=WaTLBXSblZob7ai7zh3BUDMv7/cHc+73p13nyWMOhhpnif0YDEXn5IaiznXVIIjhkY
 NNNoBSoIni17oUel2Vgx9P4TCW8kE35uIpC//BVsl92nj53gizVYf1d+f4sR40KddGrH
 Sv9pS5dChBFzzg4vtDRKRfZba3RdvK4EoGsDuPTq0QwL5BdMChafO5y8sEhKaabKmdZH
 llg8JKjT+bj6CyFgszDhOVMDWVVrnMg75mVS3caIggwz5bXqum7cuGH/17nI3l1CCBv/
 +jSfIM5r6s1/eoa+RMvnY0SRxRWXfNR1Q4jdF+CkZa8//+qQ9MC5xAcUjGIB3gtzJY8r
 DOOw==
X-Gm-Message-State: AOJu0YwQGPchhf0HR+jSekRsHQLJxzbPAfZ6JgC/MPSo+Ow/tsPq5Za/
 ddGNpiFaOLw3BU5lloDKkicLC7dgY4ayGE8fjmvS7/V0giAODYGeO3NR0TqNahDVFUOumGsM/Vk
 =
X-Google-Smtp-Source: AGHT+IEDn0sIcsmn77sHmXe3Z04v4oVef5vz/WqlTsdaJ/fd67qlpjXDSElXrI27mg24G4uEz20bSQ==
X-Received: by 2002:adf:ead2:0:b0:367:9988:84a0 with SMTP id
 ffacd0b85a97d-369bb3319d7mr401590f8f.58.1721456446319; 
 Fri, 19 Jul 2024 23:20:46 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/14] spl: Remove remaining #ifdef in spl_parse_image_header()
Date: Sat, 20 Jul 2024 07:16:56 +0100
Message-Id: <20240720061706.2644229-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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

Define spl_set_header_raw_uboot() always so we can drop the last #ifdef
in this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 02567e766f1..745efdd9b28 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -245,7 +245,6 @@ __weak struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 	return map_sysmem(CONFIG_TEXT_BASE + offset, 0);
 }
 
-#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
 void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 {
 	ulong u_boot_pos = spl_get_image_pos();
@@ -273,7 +272,6 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 	spl_image->os = IH_OS_U_BOOT;
 	spl_image->name = "U-Boot";
 }
-#endif
 
 __weak int spl_parse_board_header(struct spl_image_info *spl_image,
 				  const struct spl_boot_device *bootdev,
@@ -357,16 +355,19 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 				    sizeof(*header)))
 		return 0;
 
-#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
+	if (IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT)) {
 		/* Signature not found - assume u-boot.bin */
 		debug("mkimage signature not found - ih_magic = %x\n",
-			header->ih_magic);
+		      header->ih_magic);
 		spl_set_header_raw_uboot(spl_image);
-#else
-		/* RAW image not supported, proceed to other boot methods. */
+	} else {
+		/*
+		 * RAW image not supported, proceed to other boot
+		 * methods
+		 */
 		debug("Raw boot image support not enabled, proceeding to other boot methods\n");
 		return -EINVAL;
-#endif
+	}
 
 	return 0;
 }
-- 
2.34.1

