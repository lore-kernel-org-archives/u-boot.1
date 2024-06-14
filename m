Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE0AC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62561889BC;
	Fri, 14 Jun 2024 13:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978C4889AA; Fri, 14 Jun 2024 13:05:10 +0200 (CEST)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A6C889B3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W0xJL5Z3YzxkM;
 Fri, 14 Jun 2024 13:05:06 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W0xJL2Tr4zRFB; Fri, 14 Jun 2024 13:05:06 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 14 Jun 2024 13:04:54 +0200
Subject: [PATCH next 2/4] rockchip: ringneck-px30: enable FIT verification
 in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-ringneck-no-gadget-v1-2-d3bc6e5088de@cherry.de>
References: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
In-Reply-To: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This enables FIT verification in SPL for its payload (bl31, u-boot.itb,
...). This makes PX30 Ringneck match what happens on other Theobroma
boards.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/ringneck-px30_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 2ec5f72e47a..e7594b7a67b 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -17,8 +17,10 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_BOOTSTD_FULL=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -111,6 +113,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
+# CONFIG_RSA is not set
 CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
 # CONFIG_EFI_LOADER is not set

-- 
2.45.2

