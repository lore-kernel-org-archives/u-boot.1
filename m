Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91201C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 13:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2168A88638;
	Thu, 18 Apr 2024 15:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="VLjr5L0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8323488639; Thu, 18 Apr 2024 15:13:14 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFAB88609
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 15:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C8CE51F9B6;
 Thu, 18 Apr 2024 15:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1713445990;
 bh=7B6NE4/j9SwUE8N7ChKvyd2PiEzEWftR46r/KhGBb+0=; h=From:To:Subject;
 b=VLjr5L0vo75IOE+4Hl1fZ68FDbnwNC+/W6DsypyIRXLAulUAklPMZflZPx9YbwLJO
 fOstnG4FUq27E4FFGtmHLLjDgi8ZNiL5trt/YnmHdUGovO265W25yJPDYjVvd/CeFm
 OkYRUQMSw9kyZyZ49JpfsaOc6wu/8/vVT6mUpdNOw8i1l/16Ob8+DnoUUSwVRaFp73
 BGDkZkTMw4Au1ILeUbARUIv3HTJNQCDiXNaRHR/CSJImvR5Rmm9sjGD4ScpqYCw6Cn
 lGsUgjdqHGOsSjZ8HmXE4UcgWYci97KNUWhjhjImzElG+cqDp3bv5ZirkP+KfoHUWt
 i6wy8iXORnjCA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] board: toradex: verdin-am62: Remove not needed env
 variables
Date: Thu, 18 Apr 2024 15:13:02 +0200
Message-Id: <20240418131302.19693-1-francesco@dolcini.it>
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

Remove not needed variables from environment.

 - boot_scripts is not needed, the default value is just fine and
   already includes boot.scr
 - setup variable used to be executed from some bootscript, however
   it's not required and there is no point on having this small helper
   here

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/verdin-am62.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/configs/verdin-am62.h b/include/configs/verdin-am62.h
index 9d2e37f2d96d..ac44809fdfa5 100644
--- a/include/configs/verdin-am62.h
+++ b/include/configs/verdin-am62.h
@@ -39,12 +39,9 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
 	MEM_LAYOUT_ENV_SETTINGS \
-	"boot_scripts=boot.scr\0" \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttyS2\0" \
 	"fdt_board=dev\0" \
-	"setup=setenv setupargs console=tty1 console=${console},${baudrate} " \
-		"consoleblank=0 earlycon=ns16550a,mmio32,0x02800000\0" \
 	"update_tiboot3=askenv confirm Did you load tiboot3.bin (y/N)?; " \
 		"if test \"$confirm\" = \"y\"; then " \
 		"setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt " \
-- 
2.39.2

