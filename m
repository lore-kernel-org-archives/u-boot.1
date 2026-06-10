Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B238FCD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BB88494B;
	Wed, 10 Jun 2026 16:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fp+Lw//h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C5484951; Wed, 10 Jun 2026 16:37:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B579E84949
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-beb128ef0e9so69902266b.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102265; x=1781707065; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+pZqyqEQ+T5hZrv0CVhOSnxzo3GL8hQcqREAPnkwEd8=;
 b=Fp+Lw//h0ZiTVlhwrjUcQOyM77hU5qi2ljJSn6KqAkj0aLodvGUNI3+0fTR+MeoKq2
 XxokUD7PDV0hutE8/Ge7u0Wr4iVkmZ49gCwCcJZjuJJJQJFHp2DqdyHE+BFXQ1TwMVUx
 b+uVAeKSD8WfjKUIuraMmPVe1VVLWsBMCAuSwVyovYoKH5O2j/UrCGnjhFqW6FcZ+OOW
 gWptjdtEo2MvIotesA2t5zEq4tTzzU0/ozN1p+EXXDtBs5hIXpqzkXTs2yxg3HTYZOmE
 4MGfj2tMPEboQZetEMq1052vqr1KHp8+HTcN2XtsUlpgGdo2ixpH23qQ+DPyB8kbm+j1
 +V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102265; x=1781707065;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+pZqyqEQ+T5hZrv0CVhOSnxzo3GL8hQcqREAPnkwEd8=;
 b=bkbz4uKgzRoNxxPLuvsxtkRpz4+sdY8PW+ARh8Ay0Bzw+uinBxkF2DLLSBnr+Illvh
 gElWgXxYEvZsJXB1i5oPwgDLMNGkcFrEdBQbHjQwBKeXt1xKMynB8UNZUwHIxCsczD+r
 i0WIGTn4ajMwRZmukd9FllplF8/t1cNAUyFpx2eIPz6CB592qw3fKbBSmPB32xr9zuBr
 MV0IxqRroEG5CGOV0javXhshq+9W+lEJGJiebRPjuA/DJ+PSLSTQ9ubBqKA8YLL+Jzvg
 Ko8iD8386i5EQhRa/efXpDoEiVycCm4FimCNr4E1ygjuMFZc0LZpKRoSwGJHJaxU4bbe
 4F0Q==
X-Gm-Message-State: AOJu0Yw+2rNMmJr8nT083gcFodXjyARu+qHk/4MQSipggQ7T9w4n62t4
 PyIv66A31MSTqVNFMJAkO/dnTc3grMFNa0JmcNdtDZuFoflqPmb68MewEsGHnQ==
X-Gm-Gg: Acq92OHQcW0MAdJplDIdNqA6qxx7n8q49pLDpIZiRE2fv4S5O2uQUaEAevQ/6CyqfwP
 8Mbb8UpeVX6es4vqRkyL08h8F6E9Rkn+z26Ws9/84KXmtvF5spUCPbI8++CSpB15XEb/8Ih8tXx
 YNvvpA3HbBlzWoZe+V1yEcfremqo56aNQPuAA+vI6tLZRrsJiaPafAHNbpGWhUrHsy3BIQNX6W+
 4ea8MUsE5/VhqVG1ExNrpB9s3HzzMsFNE1xjkwae23HTNFhzUNB/ifOwaf5/kfveAlPRqFKJfOM
 Zm4TehIn7CQa5YqBNnscVcuksc9Ae8dn4zrCAJ+UIx+7kAOcpwluc+w60vLnnEXRaFyzbrJbkd2
 v0VSgzqyh6FDjgTRXU9buU2c2fPgtUFy88xTt6hVnet4zMcb0jEdhX1Tb2nACWqoHhrg+UlN2tM
 +63tl0NNp7AgCi5khNmAgsKnviTKG91T/M3L+1wBzxwwajZxvp+IStaSakFr9siZ7PsDAYS+1u
X-Received: by 2002:a17:907:986:b0:bec:ef4e:28e5 with SMTP id
 a640c23a62f3a-bf36ff90cd1mr619300066b.1.1781102264768; 
 Wed, 10 Jun 2026 07:37:44 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfb0416d0fbsm87024366b.14.2026.06.10.07.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:37:44 -0700 (PDT)
Message-ID: <0a32b207-ab76-4c27-b17f-08c5d8df32e4@gmail.com>
Date: Wed, 10 Jun 2026 16:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 03/18] Kconfig: common: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "common":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 common/Kconfig     |  8 ++++----
 common/spl/Kconfig | 34 +++++++++++++++++-----------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 8e8c733aa295..345be4b8ca14 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -78,7 +78,7 @@ config SYS_PBSIZE
 config DISABLE_CONSOLE
 	bool "Add functionality to disable console completely"
 	help
-		Disable console (in & out).
+	  Disable console (in & out).

 config IDENT_STRING
 	string "Board specific string to be added to uboot version string"
@@ -884,9 +884,9 @@ config AVB_VERIFY
 	help
 	  This option enables compilation of bootloader-dependent operations,
 	  used by Android Verified Boot 2.0 library (libavb). Includes:
-	    * Helpers to process strings in order to build OS bootargs.
-	    * Helpers to access MMC, similar to drivers/fastboot/fb_mmc.c.
-	    * Helpers to alloc/init/free avb ops.
+	  * Helpers to process strings in order to build OS bootargs.
+	  * Helpers to access MMC, similar to drivers/fastboot/fb_mmc.c.
+	  * Helpers to alloc/init/free avb ops.

 if AVB_VERIFY

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e498..726e9c7e9491 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1321,10 +1321,10 @@ config SPL_PCI
 config SPL_PCI_ENDPOINT
 	bool "Support for PCI endpoint drivers"
 	help
-	   Enable this configuration option to support configurable PCI
-	   endpoints at SPL. This should be enabled if the platform has
-	   a PCI controllers that can operate in endpoint mode (as a device
-	   connected to PCI host or bridge).
+	  Enable this configuration option to support configurable PCI
+	  endpoints at SPL. This should be enabled if the platform has
+	  a PCI controllers that can operate in endpoint mode (as a device
+	  connected to PCI host or bridge).

 config SPL_PCH
 	bool "Support PCH drivers"
@@ -1552,18 +1552,18 @@ config SPL_SPI_FLASH_TINY
 	depends on !SPI_FLASH_BAR
 	default y if SPI_FLASH
 	help
-	 Enable lightweight SPL SPI Flash support that supports just reading
-	 data/images from flash. No support to write/erase flash. Enable
-	 this if you have SPL size limitations and don't need full
-	 fledged SPI flash support.
+	  Enable lightweight SPL SPI Flash support that supports just reading
+	  data/images from flash. No support to write/erase flash. Enable
+	  this if you have SPL size limitations and don't need full
+	  fledged SPI flash support.

 config SPL_SPI_FLASH_SFDP_SUPPORT
 	bool "SFDP table parsing support for SPI NOR flashes"
 	depends on !SPI_FLASH_BAR && !SPL_SPI_FLASH_TINY
 	help
-	 Enable support for parsing and auto discovery of parameters for
-	 SPI NOR flashes using Serial Flash Discoverable Parameters (SFDP)
-	 tables as per JESD216 standard in SPL.
+	  Enable support for parsing and auto discovery of parameters for
+	  SPI NOR flashes using Serial Flash Discoverable Parameters (SFDP)
+	  tables as per JESD216 standard in SPL.

 config SPL_SPI_FLASH_MTD
 	bool "Support for SPI flash MTD drivers in SPL"
@@ -1584,22 +1584,22 @@ config SYS_SPI_U_BOOT_OFFS
 	default 0x0
 	depends on SPL_SPI_LOAD || SPL_SPI_SUNXI
 	help
-	 Address within SPI-Flash from where the u-boot payload is fetched
-	 from.
+	  Address within SPI-Flash from where the u-boot payload is fetched
+	  from.

 config SYS_SPI_KERNEL_OFFS
 	hex "Falcon mode: address of kernel payload in SPI flash"
 	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
 	help
-	 Address within SPI-Flash from where the kernel payload is fetched
-	 in falcon boot.
+	  Address within SPI-Flash from where the kernel payload is fetched
+	  in falcon boot.

 config SYS_SPI_ARGS_OFFS
 	hex "Falcon mode: address of args payload in SPI flash"
 	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT_ARGS
 	help
-	 Address within SPI-Flash from where the args payload (usually the
-	 dtb) is fetched in falcon boot.
+	  Address within SPI-Flash from where the args payload (usually the
+	  dtb) is fetched in falcon boot.

 config SYS_SPI_ARGS_SIZE
 	hex "Falcon mode: size of args payload in SPI flash"
--
2.39.5

