Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47976C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 09:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A35830C0;
	Mon,  7 Jul 2025 11:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IWffg+NL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB88830C0; Mon,  7 Jul 2025 11:53:34 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B958304D
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 11:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so1495851f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751882012; x=1752486812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NI5h90YNeyT7dtAbdp1h2y8iCr5oz/raqGXVFLiwQmc=;
 b=IWffg+NLTKXuUPQJiqMCcny4LfAjO0hs57pwJBI8rNs42u7cYJB4jtub8k6Yyn1oQ5
 FO55SFhbkb2QhAlxmdcrHmn0btpry3ErW+R1U6zaA/JDP57YjcxW76KncSz8WCy0WJ8u
 e5hq8m2lPdHmxHbgaTVzseszCvVCHWndg90rpyIXm4GCCMemmxE4XjnR5tob0bhNuDsR
 bnrRQJgq0Up8xQyl1Mxzh42KDPAGPsan7dvMfc2L2HUZqXzcCs8TTEtnLd5ahiTfavmm
 w5EseArM4OcPSY04IwV0yMErPrt2Yyt+e/MrU6/IyiNwIn0TQl41RzaHejsCV6Xu5a3b
 hLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882012; x=1752486812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NI5h90YNeyT7dtAbdp1h2y8iCr5oz/raqGXVFLiwQmc=;
 b=IPsWEPMjk1DnFcA2p/8iST5cbd0/OXv84HmxbW4KOPCCqGYLT1W0wxXaajC1IIaCgA
 sXDcCaI/gcYIP7/GNrUNcsupgVb6jMYnS33zSGhStnaiMiZEJHv3WiSb3w/0BuNvpXDX
 JC9kAE0p1Wi/j4hSKR32b9Si6B4hVnIIDcSGoZSBmL6s/Kh56mQA7RKZkvOQA5zupNn6
 /CoEQtVVrobfXErZNwJh1xYmW+tbCtRRIBMF8P5GDX6mJXDOyeHwDtEclQuqQhPYlJXp
 hhqJ4NFCEDBCEbbSyH01zNnWhfacmhdynQIsW6U2Cgoz0AZEAYXFaKAUtqlp7XInf3cJ
 wytA==
X-Gm-Message-State: AOJu0YxFT41z/uSQZCXYWgmZHbnQv3wUFb6CxMvtIYBet3HisS8dpnF7
 dZ6va1F/B8Hn+ipzgHJC/jGDHNngo7BOsg+rr7o3cY9Lti7Uf+zE78nzyK6kfZiU
X-Gm-Gg: ASbGncsDpzOvI9gbdCB9WaWgAQahNm+3HopAjfK8B1C4y0eACtkls5yUlPdPbLV994R
 PKzHEwH5EhSWBkpVxTJwftEcYuOGV3k9EefHFGEARtQG7klSElCNpKhSXkpdpN3Utf43SJqzo2a
 01Sp2UMZaEtwrLmRJzyEP2LAOTJPZ1y5BMLvF9Fl2Q4GIK95WoRfq5u0A1T0t8UOBat6bcQiEgK
 /0r4ysVwTGeUtgQTm8H+/9/sLzC7ZKgcYb9pu2nzzHM6dhH2HjtWUNeOj5AMXLkN7MYsWG1wiCY
 HMp8UYzPm3AhuzB5rVv4sLnD13vjxFXSn0DTBgqph/I8lWE/9muz/fVSjQNAaQ==
X-Google-Smtp-Source: AGHT+IHN4tMB1aZgPjLpoYxjnXJj3/uPlIk05axGIHzPFfbIXeikUK/cQvC7bgK3eaqdXs+9p2IfVg==
X-Received: by 2002:a5d:5846:0:b0:3a4:e231:8632 with SMTP id
 ffacd0b85a97d-3b495b94922mr12044558f8f.12.1751882011483; 
 Mon, 07 Jul 2025 02:53:31 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afd4sm9489719f8f.83.2025.07.07.02.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 02:53:31 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] efi: turn on EFI_DEBUG_SUPPORT for qemu arm and arm64
 target
Date: Mon,  7 Jul 2025 10:53:22 +0100
Message-Id: <20250707095322.30222-2-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707095322.30222-1-paulliu@debian.org>
References: <20250707095322.30222-1-paulliu@debian.org>
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

Previously, EFI_DEBUG_SUPPORT was enabled across all platforms for
CI build testing. With this commit, we are limiting its activation
to qemu_arm64_defconfig and qemu_arm_defconfig only, which is
sufficient for our current needs.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/qemu_arm64_defconfig | 1 +
 configs/qemu_arm_defconfig   | 1 +
 lib/efi_loader/Kconfig       | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 39afb837e41..54bf4646382 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -15,6 +15,7 @@ CONFIG_ENV_ADDR=0x4000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
+CONFIG_EFI_DEBUG_SUPPORT=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index 92ba48f6af9..b1c277a86c0 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -18,6 +18,7 @@ CONFIG_ENV_ADDR=0x4000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
+CONFIG_EFI_DEBUG_SUPPORT=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 077466f01f0..fdabe9cc278 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -73,7 +73,6 @@ config EFI_SIGNATURE_SUPPORT
 
 config EFI_DEBUG_SUPPORT
 	bool "EFI Debug Support"
-	default y if !HAS_BOARD_SIZE_LIMIT
 	help
 	  Select this option if you want to setup the EFI Debug Support
 	  Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
-- 
2.39.5

