Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69666C021A0
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E17EB80050;
	Sun,  9 Feb 2025 03:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c/z4DcWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7664A80934; Sun,  9 Feb 2025 03:02:14 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA1E80834
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3cf82bd380bso27288125ab.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066529; x=1739671329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79sbnbYfUr2pNe+dhSgXICIgo8YSG808rydeYIRLA5o=;
 b=c/z4DcWJbq38pnQiXE9e5e34dPNyBcSAjnHXQbY2CiniR1mcMdoW4zBFo2KQdftQKS
 vsA7cPOmaObafxbMlm55lC/DsHwWrQFZsQinpwPEwa2Ee+bc+0O6Xpjl3owyMJZbMLme
 G36+gvgRFk3GkohJMCUe0xpDsQSt0GJ0mKhSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066529; x=1739671329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79sbnbYfUr2pNe+dhSgXICIgo8YSG808rydeYIRLA5o=;
 b=BUD8FxP5xgrOjVUj7ojiIqHoeI3b1lBjg6HSw3WKJ0i+zwvxpWB/SMQ7oAjfRTmPMf
 STgVutQFNtZ+FK4XDiITMuTyDdEZy13113WZyNYupab7ynRj4g3Mr/9QIvfCgJe0cjrQ
 DyOCTTG+k/rk5f4ygLrk72Eh+vEB3EfXsxZscalmlISO7Z15gO3jy4kxPwtbDCtiLhFz
 e0jAEAEMLfoCBzg/yXPrKTXndx7qMGZzL1yPj5OW3kaQvZsovtCvyyWOKz8ZWEix4Jae
 q9QNnzgLJo1H30FlH6hwOMyQzXw5n+Ocpddd/qLDOPh/VIWDncMPClCf3SZm5VeOZD7t
 qU/g==
X-Gm-Message-State: AOJu0Yw5nvQMK7Q0SKVPv17vSIkK8f+Vp6cjeoXMYqmXp0jWyfKUCr+y
 VjgZf4dvcEPK8+x+rzaJ1ZOheJjL5zPc6nsSg9U5YlMyXbsyMcOaqLlJyfZ2VA/FahfCP7yw8Xw
 =
X-Gm-Gg: ASbGnct+Jl+0isl8dXAWVGpakq/Mp8QMqLZ2KK4pzuRKhV5I9oHyOSFP2CjfnGU99kg
 LXqj1pcBvguFz8vZh18unz/HEqeym6Wz4yduBbsIxnZ4L+0Oq2jXrCf0FyRzStp3+a1QgvZPvVR
 oVlsX99r54UfhqQXpm3y48DS2P1xwEdkMRxorYrrBljtMm0TU4iTivkv1ax486AyInvkn2rPqmq
 JnYct1Gkht7I2MezgJ/xevA/v9ZXpVRFP564kJPk5E/nWLc+Qs8Qr0VRqA+lktOOrMYcXBi3j2a
 uNzKCzHJDe1svxz2EdWzYKa6Zhtm46WtFobwo9i/5OiZSHDUOwcu
X-Google-Smtp-Source: AGHT+IHw+lO6aOWpa4nvPkjmfbZZG14HWc4XeGkOiMGUBxM/zCpNnObRYUKMIvsJ1ncW2nco3oW3cg==
X-Received: by 2002:a05:6e02:3421:b0:3cf:bb3e:884c with SMTP id
 e9e14a558f8ab-3d13df2bf5amr78309465ab.16.1739066528843; 
 Sat, 08 Feb 2025 18:02:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 09/29] efi: x86: Rework VENDOR_EFI option to permit other
 archs
Date: Sat,  8 Feb 2025 19:01:08 -0700
Message-ID: <20250209020136.4108987-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

At present only x86 supports the EFI app and (apart from Qualcomm) the
payload. In preparation for supporting 64-bit ARM more generally, rename
the existing ARCH_EFI option to ARCH_EFI_X86, using that to define a
generic ARCH_EFI which will be enabled for all architectures.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Update to use ARCH_EFI instead of VENDOR_EFI
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/arm/Kconfig                    | 4 ++++
 arch/x86/Kconfig                    | 3 ++-
 board/efi/Kconfig                   | 9 +++++++--
 configs/efi-x86_app32_defconfig     | 2 +-
 configs/efi-x86_app64_defconfig     | 2 +-
 configs/efi-x86_payload32_defconfig | 2 +-
 configs/efi-x86_payload64_defconfig | 2 +-
 7 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01cb27aa1d7..a55ba6b7f09 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2157,6 +2157,10 @@ config ARCH_GXP
 	select OF_CONTROL
 	imply CMD_DM
 
+config ARCH_EFI_ARM
+	bool "efi"
+	select ARCH_EFI
+
 endchoice
 
 config SUPPORT_PASSING_ATAGS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8c225f314ff..c43180e1537 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -65,8 +65,9 @@ config VENDOR_COREBOOT
 config VENDOR_DFI
 	bool "dfi"
 
-config ARCH_EFI
+config ARCH_EFI_X86
 	bool "efi"
+	select ARCH_EFI
 
 config VENDOR_EMULATION
 	bool "emulation"
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 05ac8d15d49..4c68d85a076 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -1,3 +1,8 @@
+config ARCH_EFI
+	bool
+	select OF_CONTROL
+	select DM_SERIAL
+
 if ARCH_EFI
 
 if X86
@@ -38,6 +43,6 @@ endchoice
 source "board/efi/efi-x86_app/Kconfig"
 source "board/efi/efi-x86_payload/Kconfig"
 
-endif
+endif  # X86
 
-endif
+endif  # ARCH_EFI
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 0cdfe467f53..c9346da7d47 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -4,7 +4,7 @@ CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_app"
 CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
-CONFIG_ARCH_EFI=y
+CONFIG_ARCH_EFI_X86=y
 CONFIG_TARGET_EFI_X86_APP32=y
 CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index ca3f084ef4c..5bc1e9e5cd9 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -5,7 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_app"
 CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_X86_RUN_64BIT=y
-CONFIG_ARCH_EFI=y
+CONFIG_ARCH_EFI_X86=y
 CONFIG_TARGET_EFI_X86_APP64=y
 CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index d96228c0694..65e562e1bc8 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -3,7 +3,7 @@ CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
-CONFIG_ARCH_EFI=y
+CONFIG_ARCH_EFI_X86=y
 CONFIG_TARGET_EFI_X86_PAYLOAD=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 9e055da297c..4f341f43ed9 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -3,7 +3,7 @@ CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
-CONFIG_ARCH_EFI=y
+CONFIG_ARCH_EFI_X86=y
 CONFIG_TARGET_EFI_X86_PAYLOAD=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
-- 
2.43.0

