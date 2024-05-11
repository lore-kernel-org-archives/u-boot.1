Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DCEC04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 23:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A531287DEF;
	Sun, 12 May 2024 01:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pMYfE3VB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dQlFN/zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30EC187E1D; Sun, 12 May 2024 01:13:34 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C3387DC7
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 01:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VcM4W0FTxz9sTD;
 Sun, 12 May 2024 01:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1715469211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WHzBgdk0ucFaDBYuTIsyN9zkZjcCzGsa+exDI39wiP4=;
 b=pMYfE3VB0Cg9UY1Yyled7192Wi7XwQp5Z5u0foVu5JptJXE/7BxY7Os8pvx0avPEN47inc
 HGpJQR/Xfa9KrBnL6ZeYQKhGcITXjfTy7aMR94Spgp5RKFKNJmPutUjo5o2eiqXh5fG2Ga
 Fp3Hhd31JPOiFAezAInC2SIM4cVJTPJwoPSB+Ev/W8amVxfGIXxiuvLnpLG8M+WJYJTPJR
 XiB8Up92sinqgWlTaBdIo7ZTCjC0A8aNXUT43HYySQtzKtjVTP3axcvnTrhR/+Ts8pwz2h
 KqZNMIK7mqfxsv5UMnm3LaaQLOUv7I7dMgGBkvErNaVqxoaJ96PM4oZL/o/JzA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1715469208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WHzBgdk0ucFaDBYuTIsyN9zkZjcCzGsa+exDI39wiP4=;
 b=dQlFN/zi6zmWghf9AQjX35xCXxSJ7PPb/F/keRr19VRIMC60IZj5v51b+0bEEBUZNKtCAN
 3gcw0BtX3ujZTs9P7CnUYTVLLaz1VPLWJJlCggFCmsZDIX1IojL2mnGGp6SQj+wvJH/nBX
 ERUBZS9VXwXqQECwKyKsu+jOaxXbwEY1gQBMNTen4Fhyozy1CKJpuI/N0OhAz7uDZ7v+hZ
 X6W+GYnZA3ABUtXX9gdmEzKjRnTdIOa42k5CaofnZ8IEeSiR6mf+1l0G+wG/zWGclZhtqb
 t5nGaJp4QC2ixBA4hfJHaD40rqVmkhZL0Hm07vVRCTecZCgqjsLEyv71Xw+k+g==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master-cleanup
Date: Sun, 12 May 2024 01:12:27 +0200
Message-ID: <20240511231302.74263-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uqirtfkm79thczsnqxswgh1wej88oh61
X-MBO-RS-ID: ec7534184bae9a6f3db
X-Rspamd-Queue-Id: 4VcM4W0FTxz9sTD
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

The following changes since commit 5c5565cfec92eb7377ff7fe197612c6a813bb6c7:

  Merge patch series "arm: davinci: Migrate da850-evm to OF_UPSTREAM" (2024-05-07 11:59:26 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-cleanup

for you to fetch changes up to 2d10e76547b896fb002cb3f946ac6f9b628e9fb7:

  ARM: dts: renesas: Drop DTs with OF_UPSTREAM counterparts (2024-05-12 01:12:00 +0200)

----------------------------------------------------------------
Marek Vasut (1):
      ARM: dts: renesas: Drop DTs with OF_UPSTREAM counterparts

 arch/arm/dts/Makefile                          |   34 -
 arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts     |   60 -
 arch/arm/dts/r8a774a1-hihope-rzg2m-ex.dts      |   21 -
 arch/arm/dts/r8a774a1-hihope-rzg2m.dts         |   37 -
 arch/arm/dts/r8a774a1.dtsi                     | 2865 -------------------
 arch/arm/dts/r8a774b1-beacon-rzg2n-kit.dts     |   56 -
 arch/arm/dts/r8a774b1-hihope-rzg2n-ex.dts      |   21 -
 arch/arm/dts/r8a774b1-hihope-rzg2n.dts         |   41 -
 arch/arm/dts/r8a774b1.dtsi                     | 2716 ------------------
 arch/arm/dts/r8a774c0-cat874.dts               |  455 ----
 arch/arm/dts/r8a774c0-ek874.dts                |   14 -
 arch/arm/dts/r8a774c0.dtsi                     | 2000 --------------
 arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts     |   61 -
 arch/arm/dts/r8a774e1-hihope-rzg2h-ex.dts      |   20 -
 arch/arm/dts/r8a774e1-hihope-rzg2h.dts         |   41 -
 arch/arm/dts/r8a774e1.dtsi                     | 2997 --------------------
 arch/arm/dts/r8a7790-lager.dts                 |  947 -------
 arch/arm/dts/r8a7790-stout.dts                 |  382 ---
 arch/arm/dts/r8a7790.dtsi                      | 1965 -------------
 arch/arm/dts/r8a7791-koelsch.dts               |  912 -------
 arch/arm/dts/r8a7791-porter.dts                |  523 ----
 arch/arm/dts/r8a7791.dtsi                      | 1891 -------------
 arch/arm/dts/r8a7792-blanche.dts               |  364 ---
 arch/arm/dts/r8a7792.dtsi                      |  928 -------
 arch/arm/dts/r8a7793-gose.dts                  |  818 ------
 arch/arm/dts/r8a7793.dtsi                      | 1470 ----------
 arch/arm/dts/r8a7794-alt.dts                   |  533 ----
 arch/arm/dts/r8a7794-silk.dts                  |  578 ----
 arch/arm/dts/r8a7794.dtsi                      | 1437 ----------
 arch/arm/dts/r8a77950-salvator-x.dts           |   49 -
 arch/arm/dts/r8a77950-ulcb.dts                 |   37 -
 arch/arm/dts/r8a77950.dtsi                     |  330 ---
 arch/arm/dts/r8a77951.dtsi                     | 3485 ------------------------
 arch/arm/dts/r8a77960-salvator-x.dts           |   37 -
 arch/arm/dts/r8a77960-ulcb.dts                 |   38 -
 arch/arm/dts/r8a77960.dtsi                     | 3080 ---------------------
 arch/arm/dts/r8a77965-salvator-x.dts           |   32 -
 arch/arm/dts/r8a77965-ulcb.dts                 |   33 -
 arch/arm/dts/r8a77965.dtsi                     | 2889 --------------------
 arch/arm/dts/r8a77970-eagle.dts                |  405 ---
 arch/arm/dts/r8a77970-v3msk.dts                |  303 --
 arch/arm/dts/r8a77970.dtsi                     | 1220 ---------
 arch/arm/dts/r8a77980-condor.dts               |   24 -
 arch/arm/dts/r8a77980-v3hsk.dts                |  293 --
 arch/arm/dts/r8a77980.dtsi                     | 1625 -----------
 arch/arm/dts/r8a77990-ebisu.dts                |   15 -
 arch/arm/dts/r8a77990.dtsi                     | 2154 ---------------
 arch/arm/dts/r8a77995-draak.dts                |   16 -
 arch/arm/dts/r8a77995.dtsi                     | 1473 ----------
 arch/arm/dts/r8a779a0-falcon-cpu.dtsi          |  359 ---
 arch/arm/dts/r8a779a0-falcon-csi-dsi.dtsi      |  270 --
 arch/arm/dts/r8a779a0-falcon-ethernet.dtsi     |   15 -
 arch/arm/dts/r8a779a0-falcon.dts               |  101 -
 arch/arm/dts/r8a779a0.dtsi                     | 2915 --------------------
 arch/arm/dts/r8a779f0-spider-cpu.dtsi          |  210 --
 arch/arm/dts/r8a779f0-spider-ethernet.dtsi     |  105 -
 arch/arm/dts/r8a779f0-spider.dts               |   24 -
 arch/arm/dts/r8a779f0.dtsi                     | 1193 --------
 arch/arm/dts/r8a779g0-white-hawk-cpu.dtsi      |  375 ---
 arch/arm/dts/r8a779g0-white-hawk-csi-dsi.dtsi  |  187 --
 arch/arm/dts/r8a779g0-white-hawk-ethernet.dtsi |   16 -
 arch/arm/dts/r8a779g0-white-hawk.dts           |   69 -
 arch/arm/dts/r8a779g0.dtsi                     | 2349 ----------------
 63 files changed, 49913 deletions(-)
 delete mode 100644 arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
 delete mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-ex.dts
 delete mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m.dts
 delete mode 100644 arch/arm/dts/r8a774a1.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-beacon-rzg2n-kit.dts
 delete mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-ex.dts
 delete mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n.dts
 delete mode 100644 arch/arm/dts/r8a774b1.dtsi
 delete mode 100644 arch/arm/dts/r8a774c0-cat874.dts
 delete mode 100644 arch/arm/dts/r8a774c0-ek874.dts
 delete mode 100644 arch/arm/dts/r8a774c0.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts
 delete mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-ex.dts
 delete mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h.dts
 delete mode 100644 arch/arm/dts/r8a774e1.dtsi
 delete mode 100644 arch/arm/dts/r8a7790-lager.dts
 delete mode 100644 arch/arm/dts/r8a7790-stout.dts
 delete mode 100644 arch/arm/dts/r8a7790.dtsi
 delete mode 100644 arch/arm/dts/r8a7791-koelsch.dts
 delete mode 100644 arch/arm/dts/r8a7791-porter.dts
 delete mode 100644 arch/arm/dts/r8a7791.dtsi
 delete mode 100644 arch/arm/dts/r8a7792-blanche.dts
 delete mode 100644 arch/arm/dts/r8a7792.dtsi
 delete mode 100644 arch/arm/dts/r8a7793-gose.dts
 delete mode 100644 arch/arm/dts/r8a7793.dtsi
 delete mode 100644 arch/arm/dts/r8a7794-alt.dts
 delete mode 100644 arch/arm/dts/r8a7794-silk.dts
 delete mode 100644 arch/arm/dts/r8a7794.dtsi
 delete mode 100644 arch/arm/dts/r8a77950-salvator-x.dts
 delete mode 100644 arch/arm/dts/r8a77950-ulcb.dts
 delete mode 100644 arch/arm/dts/r8a77950.dtsi
 delete mode 100644 arch/arm/dts/r8a77951.dtsi
 delete mode 100644 arch/arm/dts/r8a77960-salvator-x.dts
 delete mode 100644 arch/arm/dts/r8a77960-ulcb.dts
 delete mode 100644 arch/arm/dts/r8a77960.dtsi
 delete mode 100644 arch/arm/dts/r8a77965-salvator-x.dts
 delete mode 100644 arch/arm/dts/r8a77965-ulcb.dts
 delete mode 100644 arch/arm/dts/r8a77965.dtsi
 delete mode 100644 arch/arm/dts/r8a77970-eagle.dts
 delete mode 100644 arch/arm/dts/r8a77970-v3msk.dts
 delete mode 100644 arch/arm/dts/r8a77970.dtsi
 delete mode 100644 arch/arm/dts/r8a77980-condor.dts
 delete mode 100644 arch/arm/dts/r8a77980-v3hsk.dts
 delete mode 100644 arch/arm/dts/r8a77980.dtsi
 delete mode 100644 arch/arm/dts/r8a77990-ebisu.dts
 delete mode 100644 arch/arm/dts/r8a77990.dtsi
 delete mode 100644 arch/arm/dts/r8a77995-draak.dts
 delete mode 100644 arch/arm/dts/r8a77995.dtsi
 delete mode 100644 arch/arm/dts/r8a779a0-falcon-cpu.dtsi
 delete mode 100644 arch/arm/dts/r8a779a0-falcon-csi-dsi.dtsi
 delete mode 100644 arch/arm/dts/r8a779a0-falcon-ethernet.dtsi
 delete mode 100644 arch/arm/dts/r8a779a0-falcon.dts
 delete mode 100644 arch/arm/dts/r8a779a0.dtsi
 delete mode 100644 arch/arm/dts/r8a779f0-spider-cpu.dtsi
 delete mode 100644 arch/arm/dts/r8a779f0-spider-ethernet.dtsi
 delete mode 100644 arch/arm/dts/r8a779f0-spider.dts
 delete mode 100644 arch/arm/dts/r8a779f0.dtsi
 delete mode 100644 arch/arm/dts/r8a779g0-white-hawk-cpu.dtsi
 delete mode 100644 arch/arm/dts/r8a779g0-white-hawk-csi-dsi.dtsi
 delete mode 100644 arch/arm/dts/r8a779g0-white-hawk-ethernet.dtsi
 delete mode 100644 arch/arm/dts/r8a779g0-white-hawk.dts
 delete mode 100644 arch/arm/dts/r8a779g0.dtsi
