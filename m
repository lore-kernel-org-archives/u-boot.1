Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37A8CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140C588449;
	Thu,  4 Apr 2024 13:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Op0iBGrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A806488449; Thu,  4 Apr 2024 13:48:40 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D435188408
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4D92D424A1
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712231299;
 bh=ZsNrXEjzH9d/q1bW5jchAdJPqRzvHFF54iiL4NLWtc8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Op0iBGrAf3BEeWbo9AIbzK8FOFOulJp9SYNCfIzZ9X8Z8QRMcdSp2gT8UlIfj4n2/
 HlMZi8jottLjVgg3ygPO9lcBxaoGkP8DNxuM0eOVG3Wh1ITfqnjdQFDzIgi1NQC0KV
 fYM2XLrHVcO06jhPQdEr0mOldx1EbkwymjidM0uL32EqGjWNhiLzWLNUX4vO+K3Y1g
 Ek7QW8e/n2KMFIThSrFIooqa9a8KfmUODH5y9g6fVlYAZdbXuHw+gl9tOIntFQDzCU
 QwQdJjlwTgcnJmnmlvwM9iH0oOxV1TKuakJ8iO8d+jkA61xMpTq91Mgt8yCEZGdSlH
 EYi+lUHdnmiGw==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d85b9e7504so3405191fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712231275; x=1712836075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsNrXEjzH9d/q1bW5jchAdJPqRzvHFF54iiL4NLWtc8=;
 b=CUUJaU3j+kVsilV3vkid4EE6NuKf7Tgcp9qyQdsL07gIHTawatNDjL3irFiSNeX9Xv
 eMC4Rp+FzzZjQna22O3EpvNYY1lBbHDWuWl4+dkvHXYllzkBMe5Tmu8s38SaYqGlnlPb
 9PxE7Ptmcu6ffCxGqRM8HNTMo4N9q2Z/pqXuLCncBuBfP4oyT7GrtA0+DYJzxkKlqkGx
 l2gOFFZVPcGXVXhpIbmq6EOwmOx8xgKtcUSg8cPc+RHjC5Uhs0mfAOC5exMkpyKin2Bl
 btv8ysESRcuAU+aX5qm7++OyCEjGfh/M4njyQbTSQ9PKYK5wdV/Bs3MPzQikGM0IFDSB
 oL6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFAHrtZn4xChvtvNDSrcVSPsWJN3QCMvqpwfIDQbwhD8R6yLfAXFIyyiHZoZ+nwh48y995IQnmzPViLOhBO48ueX+4ww==
X-Gm-Message-State: AOJu0YwpQlcnvddGAh5VgndXVX/68Y/di/38AjZ0J5UncGE3uy/it5yo
 Lr22PFGmx0pgj1VzHXgLaaVW97qhEULMrGSjKVIMce1uKgU8u4UgUR259VW/uh/W+gM5nWUlOgz
 wPFGuDV09uQX0flzuaIrDgfl9NNA5RqWh8lSiga9WoXnxa68hjxsLEmiDidr3NULO19g=
X-Received: by 2002:a2e:8509:0:b0:2d8:3e60:b9c9 with SMTP id
 j9-20020a2e8509000000b002d83e60b9c9mr1726143lji.33.1712231275437; 
 Thu, 04 Apr 2024 04:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRWlyNelr7+wShMv/Jo7A/lEGZy0mDYZf191xb7lkDVipGMbC9eBhct+DXwmc87IIt41s1cw==
X-Received: by 2002:a2e:8509:0:b0:2d8:3e60:b9c9 with SMTP id
 j9-20020a2e8509000000b002d83e60b9c9mr1726122lji.33.1712231275039; 
 Thu, 04 Apr 2024 04:47:55 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a05600c350200b00414906f1ea1sm2422134wmq.17.2024.04.04.04.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 04:47:54 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>,
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/4] boot: enable booting via EFI boot manager by default
Date: Thu,  4 Apr 2024 13:47:40 +0200
Message-ID: <20240404114742.81187-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
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

If UEFI is enabled in U-Boot, we want it to conform to the UEFI
specification. This requires enabling the boot manager boot method.

Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	fix building with EFI_BOOT_MGR but w/o BOOTSTD
---
 boot/Kconfig           | 10 ++++++++++
 boot/Makefile          |  2 +-
 lib/efi_loader/Kconfig |  1 -
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 3d7aabd27d6..d9a6c270059 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -558,6 +558,16 @@ config BOOTMETH_EFILOADER
 
 	  This provides a way to try out standard boot on an existing boot flow.
 
+config BOOTMETH_EFI_BOOTMGR
+	bool "Bootdev support for EFI boot manager"
+	depends on EFI_BOOTMGR
+	select BOOTMETH_GLOBAL
+	default y
+	help
+	  Enable booting via the UEFI boot manager. Based on the EFI variables
+	  the EFI binary to be launched is determined. To set the EFI variables
+	  use the eficonfig command.
+
 config BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded"
 	depends on FIT
diff --git a/boot/Makefile b/boot/Makefile
index f0a279cde16..84ccfeaecec 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -34,8 +34,8 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
+obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFI_BOOTMGR) += bootmeth_efi_mgr.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-obj-$(CONFIG_EFI_BOOTMGR) += bootmeth_efi_mgr.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 endif
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index a7c3e05c13a..e13a6f9f4c3 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -44,7 +44,6 @@ config EFI_BINARY_EXEC
 config EFI_BOOTMGR
 	bool "UEFI Boot Manager"
 	default y
-	select BOOTMETH_GLOBAL if BOOTSTD
 	help
 	  Select this option if you want to select the UEFI binary to be booted
 	  via UEFI variables Boot####, BootOrder, and BootNext. You should also
-- 
2.43.0

