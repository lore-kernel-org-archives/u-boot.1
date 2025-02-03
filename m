Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E97CC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA00805E2;
	Mon,  3 Feb 2025 18:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GkWIyppr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9371180763; Mon,  3 Feb 2025 18:43:42 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6588180137
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb8accbde3so2982092b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604617; x=1739209417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNCVUxzc7+qWBT/JmQkRPV135xV3aQDw1qLzVFwG0F0=;
 b=GkWIypprZQNBibDLc6COUtT1DnNC+t9YllRar8m3hiAYVK8h4L3Xo7H9fyhpOH42BI
 5VyTYcayUdA8qjE+c/nV2u5FmdrjgmltDIKaQ2TRF2AguRPrjSQf8zttda9sShHKRCQ7
 WB4HhgMWxw8GecxYqksGPZgxu6PgRt1TrYByI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604617; x=1739209417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNCVUxzc7+qWBT/JmQkRPV135xV3aQDw1qLzVFwG0F0=;
 b=Mki4nOJuQrl9H33vlLlst30cF8FPqFffoz2yvx7xcBqIOjRX9g2/gmfGc46OGeR8yV
 u7AtZuUTLEhEfSuEjEgdVZZypeDXv7TlirCF+Kg4o+u+Z8ODe6BW5bYCDveh022d7Gv/
 0VgfAalyK9t0jMoIgBJZbq0wUVay/5ZjO9O62pbcFRRrrBpcHw8MuXBwajwUUBpfpMp1
 PYBVIfbqBjVYyT4WboKVe9vZmN7OsaBcVmY5LVWfnB+hxl+wpdggD/uFgNgtquRLj0t7
 cfb4i2Ps1EuxmVFwtqulpfqd4K5P2053En3TG92T3Sqk7juxSDz/DcbaJCOYLYJQNN+2
 aXPA==
X-Gm-Message-State: AOJu0Yzyi9/ArXheQGE6/08oRRWrVJyqlpMZ0VAKFqRG2Gr45Y213VgU
 CnnkA61N1s8ehEcmusXtMZV9kO12qZsQhq+tAW1WsLm1E3EIycXAReNd3kcnx4aqoQJB9o7HBuA
 =
X-Gm-Gg: ASbGncsR9EV9PQUNesNyZsGScEP2VLGtydtzvsNOwJjvm1XxMP0DkdQvwz18QLRmH5Y
 d1lnAVh7I9Gd8aH6Xnh6czmVLeqn6E1w8p7b7CxfWUpgF5mmiKGAt9Kn1MRELXeAMwAH+IQDTwq
 tinPmeeJNDVcYi7NYD7kpnVmXdMwrFq/BG+uh3v5LwBaer+CgFapJ1K7e9iLiY0Qo8P0R4vOtPz
 iEKXgceuBLLvn1q2pt7VSqE9x8tukYT4aSfyzlVq5WTW5acGHM4fHUOEEjbgl8NJSI9PITNjHzy
 kB4moAqO+ZXUjKcwJZbrPf1Ia09mu74jaJGbsgCGk3k30pVtyRXj
X-Google-Smtp-Source: AGHT+IEt33NC9qog0yqHDxRqLNpmYzzfZCbVwZkiflFANbcprLLSWSAdE+StFOnQrVVOnj9L3bJxOw==
X-Received: by 2002:a05:6808:1b21:b0:3eb:4acb:a86b with SMTP id
 5614622812f47-3f36dd929eamr138823b6e.16.1738604617552; 
 Mon, 03 Feb 2025 09:43:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:36 -0800 (PST)
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
Subject: [PATCH 11/32] efi: x86: Rework VENDOR_EFI option to permit other archs
Date: Mon,  3 Feb 2025 10:42:04 -0700
Message-ID: <20250203174245.1331464-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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
payload. In preparation for supporting ARM more generally, rename the
existing VENDOR_EFI option to VENDOR_EFI_X86, using that to define a
generic VENDOR_EFI which will be enabled for all architectures.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/Kconfig                    | 4 ++++
 arch/x86/Kconfig                    | 3 ++-
 board/efi/Kconfig                   | 9 +++++++--
 configs/efi-x86_app32_defconfig     | 2 +-
 configs/efi-x86_app64_defconfig     | 2 +-
 configs/efi-x86_payload32_defconfig | 2 +-
 configs/efi-x86_payload64_defconfig | 2 +-
 7 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01cb27aa1d7..b032aac4caa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2157,6 +2157,10 @@ config ARCH_GXP
 	select OF_CONTROL
 	imply CMD_DM
 
+config VENDOR_EFI_ARM
+	bool "efi"
+	select VENDOR_EFI
+
 endchoice
 
 config SUPPORT_PASSING_ATAGS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80396a3a2d5..69e624ae26c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -65,8 +65,9 @@ config VENDOR_COREBOOT
 config VENDOR_DFI
 	bool "dfi"
 
-config VENDOR_EFI
+config VENDOR_EFI_X86
 	bool "efi"
+	select VENDOR_EFI
 
 config VENDOR_EMULATION
 	bool "emulation"
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 7545f808585..33bc364861a 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -1,3 +1,8 @@
+config VENDOR_EFI
+	bool
+	select OF_CONTROL
+	select DM_SERIAL
+
 if VENDOR_EFI
 
 if X86
@@ -38,6 +43,6 @@ endchoice
 source "board/efi/efi-x86_app/Kconfig"
 source "board/efi/efi-x86_payload/Kconfig"
 
-endif
+endif  # X86
 
-endif
+endif  # VENDOR_EFI
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index bfcef9afa88..633b1b6c532 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -4,7 +4,7 @@ CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_app"
 CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
-CONFIG_VENDOR_EFI=y
+CONFIG_VENDOR_EFI_X86=y
 CONFIG_TARGET_EFI_X86_APP32=y
 CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 8f1319c0b4c..b3d1df42777 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -5,7 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_app"
 CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_X86_RUN_64BIT=y
-CONFIG_VENDOR_EFI=y
+CONFIG_VENDOR_EFI_X86=y
 CONFIG_TARGET_EFI_X86_APP64=y
 CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 48e757f629d..00f27109860 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -3,7 +3,7 @@ CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
-CONFIG_VENDOR_EFI=y
+CONFIG_VENDOR_EFI_X86=y
 CONFIG_TARGET_EFI_X86_PAYLOAD=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 2606ac261c1..a22d180a591 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -3,7 +3,7 @@ CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
-CONFIG_VENDOR_EFI=y
+CONFIG_VENDOR_EFI_X86=y
 CONFIG_TARGET_EFI_X86_PAYLOAD=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
-- 
2.43.0

