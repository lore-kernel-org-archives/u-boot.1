Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D9606A330
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gf1Y9dfE;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=TbL7DYvQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 865B78105B;
	Tue, 10 Nov 2026 07:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jt4bcUs5QPxh; Tue, 10 Nov 2026 07:53:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4141F80E10
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794297206;
	b=eoLFjqdkKiXzrhL/OkFUy3f8di4Lvv6gkRfumpqe/d/AAZ53zT8PMirSwPanZBuI68ac
	 BG0D9yhAPzS05AHNPen/S12yVBiDuA8qsY9K0aO03dASwe8LLo+LtYX+MVQekvK37bFXd
	 Sb7RMZmc0kV5LvFdxh7IxwmOpa9VicXhPqPmmp93GY5roacmcuUleYWbrsnH8ngoi8gGd
	 hIPi1Kp3UWbv+Po6jJuWnQTHMy07P/QaSlZQpZiOnUAXlPEv++vODFHqwF4bECmoVZAnG
	 iuPg2eDlujoVugft4dsWuUg7ef4OkeoPFx6KWdnxiU/Taty98Y3QWzwxmiw4ExbM9WA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794297206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ug+6bFE7K9xtI/WMSL+aE5XecyUPb/naE4J2lhlU3fA=;
	b=ORora+MiZPAIf2koBGIg5iVbHqlL9OOBQ3frHRRlJLNMdyvWNjYV3wxeaNKuiW5K7imy
	 Czzqa9LI/ajimiyboeNvDCBWHXy+ji2uOdsuGQGJmsZ8kSKj945nAtLdFAq6sZqKSdb8n
	 BFueXQ+9g6Guy1Afr6n7HzK7jhm2sM8qOcM9kEaI7jCAYdHWmooOBfrj3BbHGMMou5LcN
	 xURfa9JcuiCh79x/TQXNEc3B9Nqyt/MKLoDRjRQTVtvCPmOxXSp+0DnCXIk6LdERh/XX7
	 RWYvMO2AZ2ccgDVxfYDM2Qi078rtuG317+7RxMHDtj9QTPvyE7X6eWvDW9Dkt+175lg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794297206;
	bh=ug+6bFE7K9xtI/WMSL+aE5XecyUPb/naE4J2lhlU3fA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gf1Y9dfEC4KfgdhCrD72oKIAo4af0q4cUCTuluDC+oMqzgBSQloYEzP11/hqDkX4D
	 asL/d6mRsFI4qLnHPwTk5VQwFnRKUlvInEmOKRYnrfRh/LB2DtZYd4jhzUtsUA9g3x
	 /ip+Kv0XyeNh9ts08EEjZhKso/CU50Y9HLJw4wn3CaixA6x6421YzOIuDw5CB5Hun+
	 wDj3CXBIdvEUn2J4aSNMNMnobrJBp2RkT/ClzBc7fZb+qkOfIiKjMnfAm0wmC2nfPS
	 HcDVnH3BQjFhlm6emDRFKr9s4ufWlmFN4KbI47KOcZHon7K195ozynbjpyGXICxCHX
	 WpNDvvPGIFCFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4141F80E10;
	Tue, 10 Nov 2026 07:53:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D6FE0D7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8ACF60760
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQtTnbeFm_1G for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:53:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 15F536074A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=TbL7DYvQ
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15F536074A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id E7904B0056A;
 Tue, 10 Nov 2026 08:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794297197;
 bh=700g7U8VVAMFQzabqep3zLGaZx5RP2/cQiFKVZp7FoM=;
 h=From:To:Cc:Subject:Date:From;
 b=TbL7DYvQVREcNN3wrNroAJbrt3BkvJcXWU2PdiMuCQDGFnrRi9g3KZCedvgiYV8HL
 cLrD6pm1bLRNIx1i/xC29wZVoTK8OdPNh38W4PwwyFsBurIco4M5FuHyUEoDZCQzX/
 oStuwZlunMcGYtQqfjTr32mOiGlqZhNsa5/iPJOU2mDrsCdemJwlsnwRCSXv7X9x2e
 d4a8H2Ka1aajGYDntzcoyTW/S/yqebwrnlkM389EvSVQFJipE28fOKUrpiXg2GAr2z
 L7T9LFcrry4D7yUdRiQT7vHi0/d7/EZmqwYsqg3qJWjkBS6x27jcU74n3twHBXFUlR
 x7XJMadz1IwDg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, E Shattow <e@freeshell.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes=20=28Schneider=20Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2 0/3] dts: build the DTS from a directory outside the tree
Date: Tue, 10 Nov 2026 08:52:53 +0100
Message-ID: <20261110075256.1800130-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A board whose DTS is not in U-Boot does not have a clean way to build it.

Today the build systems copy the sources into the tree and follow its
layout: Buildroot has copied BR2_TARGET_UBOOT_CUSTOM_DTS_PATH into
arch/<arch>/dts since 2017 [1][2], and had to learn
dts/upstream/src/<arch>/<vendor> for OF_UPSTREAM boards this September [3];
Yocto layers copy their .dts into arch/<arch>/dts and sed a dtb-y line
into its Makefile [4], copy their -u-boot.dtsi there [5], or tell the user
to patch the dts into the U-Boot source [6].

This series adds a way to build it from a directory outside the tree:

    make EXT_DTS_DIR=/path/to/dts DEVICE_TREE=myboard

The benefits for the build systems:

- Buildroot: BR2_TARGET_UBOOT_CUSTOM_DTS_PATH could become a make option,
  EXT_DTS_DIR=<dir> in UBOOT_MAKE_OPTS, for every U-Boot layout at once,
  without the copy, the sed, or the question of where the -u-boot.dtsi
  goes: next to the .dts. A U-Boot upgrade no longer moves the files.

- Yocto: a BSP layer adds EXTRA_OEMAKE += "EXT_DTS_DIR=${UNPACKDIR}/dts"
  and keeps its device trees in the layer, versioned with the board, not
  with the U-Boot recipe; a UBOOT_CONFIG with several configurations
  passes its DEVICE_TREE per configuration as before.

- A bring-up, or a board whose device tree is maintained with the
  kernel's, keeps one device tree repository for both; nothing is copied
  into U-Boot until the board goes upstream.

Patch 1 makes "make DEVICE_TREE=<name>" build that device tree in the
directories built through scripts/Makefile.dts, which listed Kconfig's
only (the VisionFive 2 report [7]). Patch 2 looks for <name>-u-boot.dtsi
next to the .dts before arch/<arch>/dts. Patch 3 adds EXT_DTS_DIR.

It was tested on next at ecdcf9e365d (v2027.01-rc2) using:

- imx8mp_evk (OF_UPSTREAM, SPL, binman): with its .dts copied out of the
  tree, the external build gives dt.dtb, u-boot.dtb, u-boot.itb,
  spl/u-boot-spl.bin and flash.bin identical to the in-tree build,
  in the <vendor>/ layout. A *-u-boot.dtsi next to the source is taken
  first. Touching the source rebuilds, nothing else does.

[1] https://lists.buildroot.org/pipermail/buildroot/2017-April/553477.html
[2] https://gitlab.com/buildroot.org/buildroot/-/blob/master/boot/uboot/uboot.mk
[3] https://lists.buildroot.org/pipermail/buildroot/2026-September/809302.html
[4] https://github.com/karo-electronics/meta-karo/blob/85984e583a110855586938454964a259a323054f/recipes-bsp/u-boot/u-boot-karo.inc
[5] https://github.com/toradex/meta-toradex-tezi/blob/b53871a3df70e8a1d960523d9a4f186e2e1e2bd1/recipes-bsp/u-boot/u-boot-toradex-tezi.inc
[6] https://github.com/Xilinx/meta-xilinx/blob/f55a2890a9fdca73e14253d2383823eff513ba9b/meta-xilinx-core/recipes-bsp/u-boot/u-boot-xlnx.inc
[7] https://lore.kernel.org/u-boot/034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me/

Changes in v2:
- Rebase on next, v2027.01-rc2
- control.rst: for a WIP board that (Tom Rini)
- 3/3 log: wording: directories, not folders (Marek Vasut)

Vincent Jardin (3):
  scripts: Makefile.dts: build the device tree with DEVICE_TREE= too
  scripts: Makefile.lib: add check of -u-boot.dtsi in the device tree
    source
  dts: build the device tree from a directory outside the tree,
    EXT_DTS_DIR

 .gitignore                         |  1 +
 Makefile                           |  9 +++++-
 doc/develop/devicetree/control.rst | 49 ++++++++++++++++++++++++++++--
 dts/Makefile                       | 20 ++++++++++--
 scripts/Makefile.build             | 11 ++++++-
 scripts/Makefile.dts               | 12 +++++++-
 scripts/Makefile.lib               | 14 +++++++--
 7 files changed, 105 insertions(+), 11 deletions(-)

---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
branch: for-upstream/ext-dts-dir-v2

-- 
2.43.0

