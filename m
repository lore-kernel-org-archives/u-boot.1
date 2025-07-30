Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293F4C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538C883102;
	Wed, 30 Jul 2025 14:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8195A830B4; Wed, 30 Jul 2025 14:47:09 +0200 (CEST)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD6682EB8
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bsX6L4Xz3zgQC;
 Wed, 30 Jul 2025 14:47:06 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bsX6L1N02zkmX; Wed, 30 Jul 2025 14:47:06 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 30 Jul 2025 14:46:35 +0200
Subject: [PATCH 3/3] board: theobroma-systems: jaguar_rk3588: explicit UART
 IOMUX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-tsd-readme-update-v1-3-5a96672d2211@cherry.de>
References: <20250730-tsd-readme-update-v1-0-5a96672d2211@cherry.de>
In-Reply-To: <20250730-tsd-readme-update-v1-0-5a96672d2211@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

When one attempts to build Tiger and Jaguar from the same directory,
because Tiger will set the IOMUX to 2 but Jaguar doesn't reset it,
Jaguar will have IOMUX set to 2 if built after Tiger.

This isn't an issue if in separate directories or building Tiger after
Jaguar because the default if missing from the configuration file is 0.

Let's make it explicit that the iomux is 0 for Jaguar.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/theobroma-systems/jaguar_rk3588.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/board/theobroma-systems/jaguar_rk3588.rst b/doc/board/theobroma-systems/jaguar_rk3588.rst
index eff0ee7347c7d0e810d9dba542ce3aaf28ef359d..d09cfaa88ff81b679421dc941984d47f3b3a2f67 100644
--- a/doc/board/theobroma-systems/jaguar_rk3588.rst
+++ b/doc/board/theobroma-systems/jaguar_rk3588.rst
@@ -41,6 +41,7 @@ Get DDR init (TPL) binary
    cd rkbin
    export ROCKCHIP_TPL=$(readlink -f bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin | head -1)
    sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
+   sed -i 's/^uart iomux=.*$/uart iomux=0/' tools/ddrbin_param.txt
    python3 ./tools/ddrbin_tool.py rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
    ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
    export RKDB=$(readlink -f rk3588_spl_loader_v*.bin | head -1)

-- 
2.50.1

