Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BADDD7830E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 12:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF0C689009;
	Mon,  2 Dec 2024 13:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Z40F5uft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE1089023; Mon,  2 Dec 2024 13:04:12 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by phobos.denx.de (Postfix) with ESMTP id B77C889009
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 13:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=DEyz5
 MRX0M2979f3rOOMjF5KxZd60HQ1n5a1OSRqFPc=; b=Z40F5uft+D0ckl77Y32WC
 2zyQmSquXhy2mCkEWUNFCWw7Cd+5IxCvHP1plW7WRojOQfHEO7lcf7z3F7+hRJ3s
 nqAQLBV73b3BU+qdb7078gv/t42+Lkrt53ab9WDJ397UFOYnvMrZZc5NpNnzOiLt
 QvJqPEbsVh/LIxGh88j5OY=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzsmtp4 (Coremail) with SMTP id PygvCgBn+cAsok1nLcLRAw--.55772S2;
 Mon, 02 Dec 2024 20:04:00 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH] doc: coolpi: Fix document style
Date: Mon,  2 Dec 2024 20:03:53 +0800
Message-ID: <20241202120355.1132320-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgBn+cAsok1nLcLRAw--.55772S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWfZFWDZFW8GrW5uFW3KFg_yoW8Gw43pw
 4qkr1UKFykX3y3Xr4jk3WfZrW3Wa97ua4Uury8Ww47JF12vr1q9FZFgrW7t34UWFnFyFn7
 ZrWkKr18Gr4Uu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUeWlDUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwCpXmdNndJ+bAAAsz
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

Add a blank line after title "Specification:" to
make it render correctly html.

And also remove the useless > in bash code block.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 doc/board/coolpi/genbook_cm5_rk3588.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/board/coolpi/genbook_cm5_rk3588.rst b/doc/board/coolpi/genbook_cm5_rk3588.rst
index a02e561051a..cad2a28acbd 100644
--- a/doc/board/coolpi/genbook_cm5_rk3588.rst
+++ b/doc/board/coolpi/genbook_cm5_rk3588.rst
@@ -6,6 +6,7 @@ Cool Pi GenBook is a laptop powered by RK3588, it works with a
 carrier board connect with CM5.
 
 Specification:
+
 * Rockchip RK3588
 * LPDDR5X 8/32 GB
 * eMMC 64 GB
@@ -24,11 +25,11 @@ Get the TF-A and DDR init (TPL) binaries
 
 .. prompt:: bash
 
-   > cd u-boot
-   > export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.17.bin
-   > export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.46.elf
-   > make coolpi-genbook-cm5-rk3588_defconfig
-   > make CROSS_COMPILE=aarch64-linux-gnu-
+   cd u-boot
+   export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.17.bin
+   export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.46.elf
+   make coolpi-genbook-cm5-rk3588_defconfig
+   make CROSS_COMPILE=aarch64-linux-gnu-
 
 This will build ``u-boot-rockchip.bin`` for eMMC and ``u-boot-rockchip-spi.bin`` for SPI Nor.
 
-- 
2.34.1

