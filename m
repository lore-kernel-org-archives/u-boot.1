Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353ABCD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0D00848A1;
	Wed,  6 May 2026 14:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YBIEOgLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75BCD848A1; Wed,  6 May 2026 14:36:39 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AEC28495B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 98B4A60180;
 Wed,  6 May 2026 12:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A29DC2BCB8;
 Wed,  6 May 2026 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070996;
 bh=/8kxnCfYMmeO6bsvt0JYV8lUah7jgxnPA4/Jd2WU9EE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YBIEOgLqEJQ2e13gi2VO43VuowDlrEMMeCXLVkA41YBLVw8mntkCDyacmfKM69X6V
 zK3ox4eGmU0aYahJfbDSJF7/kol0amrAudSkWcbMHmwXfXdGhHnPG4rrWObu+weuuA
 2OOd8hHZ99wQ7RhAABxPVpY6YgCt3gI8WA5ZGtaNf0ytnJfnloNS2qMCfeQ8h9evkx
 WADXRdmPyyH9TGGMJqo5fLPawg5XMU7pAFpkTQfZ2HpJ6maVta9WG0levxc3+DDiEP
 RUbM+e3XzE3+Zj6ZocZQ5c7OsC9rxHq9ghq9GaCfJALKv6vNwV9wBdZJM6SurDvqMN
 vN+6z2svRlhhA==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 09/11] p2041rdb: update README and fix typos
Date: Wed,  6 May 2026 14:34:18 +0200
Message-ID: <20260506123507.2081751-10-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
References: <20260506123507.2081751-1-mwalle@kernel.org>
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

Nowadays, u-boot can build the pbl image itself. Refer to that image in
the documentation. Also fix some typos.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/nxp/p2041rdb/README | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/board/nxp/p2041rdb/README b/board/nxp/p2041rdb/README
index ae770277372..c2a2f0ed9e5 100644
--- a/board/nxp/p2041rdb/README
+++ b/board/nxp/p2041rdb/README
@@ -43,20 +43,16 @@ Boot from SDCard
 	make P2041RDB_SDCARD_config
 	make all
 
-2. Generate PBL imge
-   Use PE tool to produce a image used to be programed to
-   SDCard which contains RCW and U-Boot image.
-
-3. Program the PBL image to SDCard
-	=> tftp 1000000 pbl_sd.bin
-	=> mmcinfo
+2. Program the PBL image to SDCard
+	=> tftp 1000000 u-boot.pbl
+	=> mmc info
 	=> mmc write 1000000 8 672
 
-4. Program FMAN Firmware ucode
+3. Program FMAN Firmware ucode
 	=> tftp 1000000 ucode.bin
 	=> mmc write 1000000 690 10
 
-5. Change DIP-switch
+4. Change DIP-switch
 	SW1[1-5] = 01100
 	Note: 1 stands for 'on', 0 stands for 'off'
 
@@ -66,22 +62,16 @@ Boot from SPI flash
 	make P2041RDB_SPIFLASH_config
 	make all
 
-2. Generate PBL imge
-   Use PE tool to produce a image used to be programed to
-   SPI flash which contains RCW and U-Boot image.
+2. Program the PBL image to SPI flash
+	=> tftp 1000000 u-boot.pbl
+	=> sf probe 0
+	=> sf update $fileaddr 0 $filesize
 
-3. Program the PBL image to SPI flash
-	=> tftp 1000000 pbl_spi.bin
-	=> spi probe 0
-	=> sf erase 0 100000
-	=> sf write 1000000 0 $filesize
-
-4. Program FMAN Firmware ucode
+3. Program FMAN Firmware ucode
 	=> tftp 1000000 ucode.bin
-	=> sf erase 110000 10000
-	=> sf write 1000000 110000 $filesize
+	=> sf update $fileaddr 110000 $filesize
 
-5. Change DIP-switch
+4. Change DIP-switch
 	SW1[1-5] = 10100
 	Note: 1 stands for 'on', 0 stands for 'off'
 
-- 
2.47.3

