Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C0FC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9520D874F3;
	Sun, 19 Nov 2023 20:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q/eiS+33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C62283414; Sun, 19 Nov 2023 20:12:33 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28A4874BD
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35742cbb670so12497925ab.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421140; x=1701025940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlzxbuFUP7QW4TT0pdxCJ6X/eeyD6MGzZq4uglCvKSY=;
 b=Q/eiS+33MRirIHYJHMLZ5zVElvHvkv6HaxbyRhcbagTnLSQKLykCXl7ZRSDKauMXNF
 ZuaNWFMfY/LFx8CofJQBkxpADDlIkrpKxcfftW0ozDmRfcFaTsN/Rod8/+eWrptllUNl
 uDRXUxi2vh/73Wv4T2YMIMSlnfNWbSrTdy57E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421140; x=1701025940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlzxbuFUP7QW4TT0pdxCJ6X/eeyD6MGzZq4uglCvKSY=;
 b=sTZMKNXKGy8nRZOp/mO3pInA+fzbBv0rc6JL3/ycF8BAHojogweUbQdmF1M6MUcZ0T
 OOqlOMSwF4Icgo1/P6mBK5sGoDbps1pIb6rWDhua3VeLYUPOtYW0QMTC0y/nEyu58vGd
 7ZAUQ6trFNuSMEPn5Hf52kEAld3oGe6pEgvk9NdaGabpR8bDamfGpXcNquOzjlzUURK0
 hVJj57pNimMuye+zwI0TYf8blOJH0RI3G1rs53LOYa0NSLFMSNnOfduP3TXZd0cIwfOB
 SlFSEF9pGMq3KKYptnE5V9mCDOzmXHFPt2vnWgwjzIoFIalWaRCwIL1CyPY5C7buGmZB
 EC8g==
X-Gm-Message-State: AOJu0YzzJTyvXr+ttd1q0O7mj/u6MB+AMM1U7JspuaBgdenbGSQMK+ro
 6Ba46glXYf6LDeO1wTIcp2yUnuaMj5o7tLMrRFqfhw==
X-Google-Smtp-Source: AGHT+IG5g79GvGxQ9XPcIBcwH3cQW9jbKaTl4Ay6FhmRhb5mOWezLVCOb9hEejD8ONnvh5cs2ITFLA==
X-Received: by 2002:a05:6e02:1141:b0:35a:d052:da48 with SMTP id
 o1-20020a056e02114100b0035ad052da48mr6104071ill.29.1700421140486; 
 Sun, 19 Nov 2023 11:12:20 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 12/12] x86: qemu: Enable truetype fonts
Date: Sun, 19 Nov 2023 12:11:47 -0700
Message-ID: <20231119191202.667180-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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

Enable this feature to provide a larger font choice and more attractive
menus. Expand the ROM for x86_64 to 2MB to make space for the font.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index a71111697e38..99855df64442 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -82,6 +82,7 @@ CONFIG_SPL_DM_RTC=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 246ac6b6b8ad..65bb5f9bd83d 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -59,6 +59,7 @@ CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
-- 
2.43.0.rc0.421.g78406f8d94-goog

