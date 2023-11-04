Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A39C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 14:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9F28706B;
	Sat,  4 Nov 2023 14:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mupuf.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFAC187084; Sat,  4 Nov 2023 14:05:15 +0100 (CET)
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com
 [IPv6:2a0c:5a00:149::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDA587060
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 14:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mupuf.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin.roukala@mupuf.org
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
 by mailtransmit04.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <martin.roukala@mupuf.org>)
 id 1qzGKt-005cxN-3r; Sat, 04 Nov 2023 14:05:11 +0100
Received: from [10.9.9.72] (helo=submission01.runbox)
 by mailtransmit02.runbox with esmtp (Exim 4.86_2)
 (envelope-from <martin.roukala@mupuf.org>)
 id 1qzGKs-0001Yr-2u; Sat, 04 Nov 2023 14:05:10 +0100
Received: by submission01.runbox with esmtpsa [Authenticated ID (1057822)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.93) id 1qzGKh-005xRY-Hs; Sat, 04 Nov 2023 14:04:59 +0100
From: =?UTF-8?q?Martin=20Roukala=20=28n=C3=A9=20Peres=29?=
 <martin.roukala@mupuf.org>
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Martin=20Roukala=20=28n=C3=A9=20Peres=29?=
 <martin.roukala@mupuf.org>
Subject: [PATCH] rockchip: rk3588-rock-5b: Enable CONFIG_PCI_INIT_R to support
 EFI networking
Date: Sat,  4 Nov 2023 15:04:51 +0200
Message-ID: <20231104130451.111020-1-martin.roukala@mupuf.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 04 Nov 2023 14:58:47 +0100
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

When u-boot chainloads an EFI bootloader such as iPXE, we want to have
already initialized the PCI subsystem so that network driver is loaded
and ready to use by the bootloader.

Fixes: 191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA cards")
Signed-off-by: Martin Roukala (né Peres) <martin.roukala@mupuf.org>
---
 configs/rock5b-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 0595325e81..938137c851 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -36,6 +36,7 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-- 
2.42.0

