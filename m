Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897FFC0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2376980A0A;
	Sat,  8 Feb 2025 18:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EfU7Q97M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD0A80A35; Sat,  8 Feb 2025 18:12:31 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB9B80B98
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844e39439abso86259439f.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034746; x=1739639546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Mhri0bqy4yKz2vME8bBAgOZJET24BEik92FKjQfYKo=;
 b=EfU7Q97MIljwRD4ac34bJgHQOJDqN9/mmsNKhGr3Ylt4aFv4C1IdA9DENY9WWEkmnT
 MNBziFsDNHT/liVCA807DybCsDlVV/95ggmuaC0JYnmqp2WX0y+VTapKOKapgvXrKxQb
 CxmNSjYSBeqa6RsRJUaarXOpAGDtcq43wNP/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034746; x=1739639546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Mhri0bqy4yKz2vME8bBAgOZJET24BEik92FKjQfYKo=;
 b=R+PhjKwwp9/v2jr7w39tKXEc0GzyseiFNI4AF970IBcvRLDs4hNCA52OEHtCNph1Vf
 DL223eKe3UT3nmiTyzkEHWICBZ87iSHzsWTz6s0C+3csNSf2Vzih9SnYihz+ozVUJN2j
 OgC61DhO2Q7p13qX9FZS7xr5TfqA+KcbOBO4fxr8VNusgoTXkhV4xur6iVdktzRYrzuw
 ORoFWjKIcE1DWpX2nShAK3aVWbuQSvSp565TGpNBni+6tIRPadh4Z3fVYJ4Tic/zaNor
 u5tWE2vKe4mX7QWGWLEFsdf+7w1ymMAzEmepZdOBKmv8bwb09y9dvxGLV69HoebeQLjC
 Pn1Q==
X-Gm-Message-State: AOJu0YxIm7cM6sH0TXfw9OSoy+2RY2vIHZcNzcmkJXWLIwqKkHM8GSp/
 5MLWPLcL7xldWMmST0KCt2AVz1KKanzde3avK6CvqohhCN9nYY4Rh7yroYx7+lJCBQKw/YaCtOY
 =
X-Gm-Gg: ASbGncugKq2RFRkrhhh1VjpjMSzg8zMx8v14OCA8NPkBsQRj46609/wNxlRZ6ng8inM
 7tqIf6iTyUUOMumErmT3dic1+2hpwNCa+MJ64ny8IobGhqy9kXuNqP4sbh3DSXKiV9+/hCtVTdD
 lGEE2egwCIOWsZ+zMsdwwjXJKHLjH7307gAKza9psL6AfZJKQ/HleJQsQYryEHMmCFCa1UChs2R
 7O2NgJhlFlCIf3z2kPufMk7nKWB8RiMt82/7icriXL2q6pg3eqQV/doIWsO+q1tdSXoOgGeuiLa
 gEUqihL8pPQwJDZDmibZvf1K+6qyN4iP659odFfuWmxiMRnrgOp0
X-Google-Smtp-Source: AGHT+IGK0GRIbSvmyA9I3UhlLhtiVnSyK4vOdqkwvjdj6nVDckERkMbBUT7M+JvqN2znlnS6l15lmA==
X-Received: by 2002:a05:6602:4008:b0:851:f176:9827 with SMTP id
 ca18e2360f4ac-854fd89ba0bmr768924739f.5.1739034745902; 
 Sat, 08 Feb 2025 09:12:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:24 -0800 (PST)
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
Subject: [PATCH v2 09/29] efi: x86: Rework VENDOR_EFI option to permit other
 archs
Date: Sat,  8 Feb 2025 10:11:29 -0700
Message-ID: <20250208171154.1305761-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

