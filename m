Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC59C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3A5D87AE6;
	Fri, 15 Dec 2023 05:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bpnyJ1AW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F11587B04; Fri, 15 Dec 2023 05:19:35 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CC7B87AD1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ba31cc0d77so255918b6e.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613971; x=1703218771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6UVAXUsB/jkEt5k8pMn6kgfGTvr3Kgv7g+ycaB38TQ=;
 b=bpnyJ1AWeEVwo7uWNzQXKvQxQafj4Im36V+Xm+96yO8kHcAy876Bh/oshxe6lZk0vd
 V2nx8lGKonYtlvYlLm4BPUaAlOBGqI8IYCfQWRbPtI4dHMyh1qtSy/JC1iSF2S+HPJtV
 +kG3NR46ezyWx/izR3NO94qKX9BXNt7Sqt9Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613971; x=1703218771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6UVAXUsB/jkEt5k8pMn6kgfGTvr3Kgv7g+ycaB38TQ=;
 b=X83uClvTY9w0585gVyhqFwcrBNL4VGhv4yv5OJyWzeh8FIib2TmSL2lPtaqKlq5jB0
 xUPHeD2LeQprezPSyE1LamuNuX4gCnuVmwuOSe48KSP+YbVqf+xw3QbBwXvFMhEQSsGb
 eh5Z/3ymb55wd7TEmZd1yzqB7/QnOTzyohWUObgn/iWdjS7/nnMDhfPEt+UwBT0wH0Oc
 1vtoFbYcP0C5x+qJNVV5F9Oh/yW8F1JvVpDYniePKp+1GtiZhbTRSB/ISp6k6ZIq/YVW
 YhuJhftZFO6TR31H6+nlc2bjV2bC0DoJU07vTi4v15qKVxwNgFL14TKKOABFXwTIRsgT
 Y4Zg==
X-Gm-Message-State: AOJu0Yzm5ce5ZZ6lsiKhwvq48nLqw6Vhs+j4KWStCMNX/+Qx+66ork28
 XZB+crxwaLBcCyj9dGcw2iu96zmquP0LeCNNY9fGWQ==
X-Google-Smtp-Source: AGHT+IEjYYexA+2RbC1bZZhPSdD4MZ01GmqxMVMoogp2nTAgNbtCafsj3A3/qtWGsUo1m7hPzGv7xg==
X-Received: by 2002:a05:6808:3991:b0:3b9:fd0a:247f with SMTP id
 gq17-20020a056808399100b003b9fd0a247fmr15733990oib.90.1702613971714; 
 Thu, 14 Dec 2023 20:19:31 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 05/16] boot: Update SYS_BOOTM_LEN to depend on BOOTM
Date: Thu, 14 Dec 2023 21:19:03 -0700
Message-ID: <20231215041919.2197788-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

Use the new CONFIG_BOOTM symbol to determine whether SYS_BOOT_LEN is
visible or not, since we want to support decompression when CMDLINE is
disabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9fa8789bc2b1..d83047acbd0d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -800,7 +800,7 @@ endif # MEASURED_BOOT
 
 config SYS_BOOTM_LEN
 	hex "Maximum size of a decompresed OS image"
-	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
+	depends on BOOTM || CMD_BOOTI || CMD_BOOTZ || \
 		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
 	default 0x4000000 if PPC || ARM64
 	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
-- 
2.43.0.472.g3155946c3a-goog

