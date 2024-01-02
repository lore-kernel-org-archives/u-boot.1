Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33892C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 12:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B603876BF;
	Tue,  2 Jan 2024 13:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC61876D7; Tue,  2 Jan 2024 13:12:15 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C60F8764D
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 13:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 68ED2201C5;
 Tue,  2 Jan 2024 13:12:12 +0100 (CET)
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1] verdin-imx8mm: Remove stale fdt_addr env variable
Date: Tue,  2 Jan 2024 13:12:07 +0100
Message-Id: <20240102121207.3963-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

fdt_addr variable is the location in flash of the device tree blob [1], it
does not exist for verdin-imx8mm.

Because of this the bootefi command fails unless the optional
`[fdt address]` parameter is passed on the command line,
bootefi.c:efi_install_fdt() assumes that `fdt_addr` is valid when
present.

Fix this removing fdt_addr from the U-Boot environment.

[1] doc/usage/environment.rst

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/verdin-imx8mm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index 8072d5d503f2..a7ea02807ddf 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -40,7 +40,6 @@
 	"boot_file=Image\0" \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc0\0" \
-	"fdt_addr=0x43000000\0" \
 	"fdt_board=dev\0" \
 	"initrd_addr=0x43800000\0" \
 	"initrd_high=0xffffffffffffffff\0" \
-- 
2.39.2

