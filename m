Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D332CC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C4E81727;
	Wed, 29 Jan 2025 11:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87D581727; Wed, 29 Jan 2025 11:43:53 +0100 (CET)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75D981101
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yjf064245znxq;
 Wed, 29 Jan 2025 11:43:50 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Yjf056dnNz105v; Wed, 29 Jan 2025 11:43:49 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Jan 2025 11:43:33 +0100
Subject: [PATCH next 2/3] rockchip: px30: add fdtoverlay_addr_r default
 value to support FDTO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-px30-overlay-v1-2-4729b3fcb4c0@cherry.de>
References: <20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de>
In-Reply-To: <20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>
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

In order to be able to use Device Tree Overlays, the fdtoverlay_addr_r
needs to be specified.

Follow what's been done for other Rockchip SoCs and leave 1MiB for the
base DTB before the address for the overlay.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 include/configs/px30_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/px30_common.h b/include/configs/px30_common.h
index 13ed9011764b90068ca0a13499271f31c76f4c81..d0539003fd596334d07eee36e03da616cf69ee67 100644
--- a/include/configs/px30_common.h
+++ b/include/configs/px30_common.h
@@ -20,6 +20,7 @@
 	"scriptaddr=0x00500000\0" \
 	"pxefile_addr_r=0x00600000\0" \
 	"fdt_addr_r=0x08300000\0" \
+	"fdtoverlay_addr_r=0x08400000\0" \
 	"kernel_addr_r=0x00280000\0" \
 	"ramdisk_addr_r=0x0a200000\0" \
 	"kernel_comp_addr_r=0x03e80000\0" \

-- 
2.48.1

