Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA864C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7D080EFB;
	Sat, 15 Feb 2025 04:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Go5Uahcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C46480756; Sat, 15 Feb 2025 04:23:36 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC9A80F3F
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d191bfeafbso9433145ab.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589812; x=1740194612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tE4g276JeFn8OrVJeEnN/1eliB/GAB3FDjRSH5WW3Ys=;
 b=Go5UahcufgutnQnkf6oOuN6xFcek9hlhHCJNikmO0g1KV5Yi/pgl6hpONWKEZYSATI
 jdySjJ+lloZtGDYxJFwDGoAGKfVYbxcxdpKVrDhCqGqTVVsFaA2qz1b4xvlqJ6T9/cMh
 Vi3E45cPJ1QC5Fw/yzA4PesaZNGMDkjUrSHS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589812; x=1740194612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tE4g276JeFn8OrVJeEnN/1eliB/GAB3FDjRSH5WW3Ys=;
 b=osCJvOnIcP0RiEO49SEfNfKydniJqdhumT00f/k1QcMMomAIdtXk6M+1vvIl1BhGxZ
 2bOvJQhxpwaU+KOoKtR7UurgMdvSzy4MJK3sS0vN0kKE0kDznczvAK+U9Cf4wsQ2DCNr
 W95JO3NKRVz+DeTK/w5o0QhDayFKVlVvcJoF0+W5VJsSJEajbJndkN0/+b0mhzf129VA
 tMO3a7bicTgpP8UevWRqWTjq5QZ+3jCPp5JySJQ6/SfgfTNw8D4iRR5LWtSfSSRiLB5n
 juGbz6JB6GbbjEFbaejmwU7WZzHN34GsEGL9NATTUi9YislHbG5SkY4TI/eXbp8t4LBS
 ZuYQ==
X-Gm-Message-State: AOJu0YwS34bAX+gmy/gbnBwj9E9pgjSx2w5t9WYuE4HCqXHQJJZIprY0
 Ma+q2tbzsmfU6EZF+XmqpVpJhPwd3v9SBPdQsksFA017AkBhvtz4vssQLu6V2PTRKQE+WEN/cm8
 =
X-Gm-Gg: ASbGncv9T9POtVQuwemzroFuxGLRJ1O7FEluPqxuPlLGLgzh6JLSw5H2rZxO3hzYVav
 4QiHMupeOH5JcXPOmNcaKG03ocn2asvYNP/+7ubSa1wyVtrz34iaHf67FfakKTn7yZK0PCkgt+F
 FB4u8ICAAeaIVLbebdcOkSF96Dnjg1PmxpwMWZ7+NCwEuzAkbLNsh+/N7BibZA8RJUqudqvB2mK
 BERV2H5YF5OIVVerPOmnlxpUxsfxhWd8i6mDyw8Jv/Tk6TEXhYWEeJLFdKQr20XJZYqtK8rqGBj
 NFhFSmiLiBogxG9/ymd3O5HtYKKh9p/tWVxRJPV4vzeolMkhDG5h
X-Google-Smtp-Source: AGHT+IGeEKI26HLzgL8U4m5FVBfLaFqueautJrLytR15EJJvd41JjJ8Tjmz+bJJjpprrCYuWiA+9hA==
X-Received: by 2002:a05:6602:1509:b0:855:3965:f056 with SMTP id
 ca18e2360f4ac-8557a0b87b8mr154345339f.2.1739589812280; 
 Fri, 14 Feb 2025 19:23:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:30 -0800 (PST)
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
Subject: [PATCH v4 09/29] efi: x86: Rework VENDOR_EFI option to permit other
 archs
Date: Fri, 14 Feb 2025 20:22:30 -0700
Message-ID: <20250215032254.4121030-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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
index 1c068a33e4e..c654a94f795 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2158,6 +2158,10 @@ config ARCH_GXP
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

