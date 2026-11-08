Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B95606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l2Y+TOET;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=gIlzs7Nx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7370280BCD;
	Sun,  8 Nov 2026 15:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mmL5UWuDbinX; Sun,  8 Nov 2026 15:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 357F580B08
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794153042;
	b=UxeoJQ9Ltm3Ypprqxk4P5iGiI0oVDC0KhfgcSc0PpzJ/hTygxR+Y0D+cWKQ6ia6X4PNq
	 1QC3OeNJb+aTDCllPp4zHLT6AAv498/1OroM2IrPcZy0xjICPMRSCPvWbPFtvSO+DCT5r
	 +nKzjyw9khCYwi9VvKi96dZgJLHTOYxG++mnuDxhE5PlhZ9lZyGPFHF4JE4Rvv/TI9qim
	 lweGpUpS4hxjMmxJJ9f2P8FA0GSo+z/jOgR7H7k72/Tlu+9SHNugD8eq7yYq6R3mE4TtV
	 oFBhllxFnoasnHK3/EC1Va4qjdpa+mwSIj5iE43v5H2N9zFi7o83+bWekSqBfcJjEHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794153042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fVIxW0f8ZGFY8h6wCyX5eE3Tj7Th1iRG9pDm54fhUZY=;
	b=oLf/TtyMLhQQnwbSFIhtc3+GjSXeSrRMyajtftg2cA5/5gdzd2hnmX0VYnW53xCCmztO
	 YDLuJDlqt6McSwzg6Xojfa8pyd/titajcd2A+ayCW7mpAjcS1Z/Gy/oUV1BlStYMyV34d
	 hFmLw/JA5fZD+fI/KGIdfILdKLlapugqmm552JPHzO2z1Ljx2uGJ+0KxIliraLdDSOo2E
	 rwQOdEgJnjs4Vq0C6T+SLhcga/47RTZ8FdFEryx29TsBbGaMlo7tj8yywsrGw59qbO8Ax
	 1wfqAAwCvr+idCouO693GnBIKy5ZlOrY7kksPHX4L3cZNj6VQJ/wKUAlMfkdUqRPNAw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794153042;
	bh=fVIxW0f8ZGFY8h6wCyX5eE3Tj7Th1iRG9pDm54fhUZY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l2Y+TOETFjMQk+Zmzn1VfngqzjV8tJmmCgnj5QqxZU+yNaQSpOv2JhX/xkGdLnJHG
	 1xmIJdg+b7vwIEzSmFZTPQPMSpTf1FTeIWwIjve7bC5C2YEivikM+kXzhXZXFmSFeN
	 Q1mbMcVLvITqMHI7+qD/wh522XILwxQiwqqf1eYZiCGIjsscuTGOXB4WzxbI+KzlF9
	 ZUuorB+bSw8Gvu0WZv3IUARMNhvOg3EdoYTU9IlWo6EwakePIeTV4iYc0mmv3Iq2Ez
	 7nqq3FOpzk8g+GFzfOss2uBF5OkbL+dQloJQMGzflKA0ZBXsB+mZrHFufpDyvO4vb1
	 eHoXiXjmi+cYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 357F580B08;
	Sun,  8 Nov 2026 15:50:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80239235
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7193740604
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qnnwKQ4Ymaiz for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B1EBF405DF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=gIlzs7Nx
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1EBF405DF
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 34A06B0053D;
 Sun,  8 Nov 2026 16:50:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794153037;
 bh=RCnrILiiHDpANgwNGeOprQPj0QQjU9q3ibKxEToJVpY=;
 h=From:To:Cc:Subject:Date:From;
 b=gIlzs7NxFMQnMdPmpE+EnVXMM5dlEGduhqbBStboPCql6aNx+AKvwtKy6v86lFj3C
 P6cPIc7war8kS8P2aw2l42X3i6LCmVnTNhBVwEhbV8iEI9/vPFCai9pAoy/4lMD+MK
 Jub+ttIbGXpOq4HLdyjk+i+87MRQTkWMonMHBeetB2fPhjCTQhgfJWAUGeczd1/tmB
 PX/aKq3INf+5Jxu9UMpnMcLPE9oEwbG/Mrr0Y8/28nUMxkOs6qjUDpiOLYuNZGWQ92
 Z73ARcHEnnIcBbktUYUGTe4vwQf1KcbARq1oJJ5fB4ATDfghHSCGxwFvlQAmmN/xn1
 1C1/bxs7lYegA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 0/3] dts: build the DTS from a directory outside the tree
Date: Sun,  8 Nov 2026 16:50:16 +0100
Message-ID: <20261108155019.1485598-1-vjardin@free.fr>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

It was tested on main at 2515b39e3f1 using:

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


Vincent Jardin (3):
  scripts: Makefile.dts: build the device tree with DEVICE_TREE= too
  scripts: Makefile.lib: add check of -u-boot.dtsi in the device tree
    source
  dts: build the device tree from a directory outside the tree,
    EXT_DTS_DIR

 .gitignore                         |  1 +
 Makefile                           |  9 ++++++-
 doc/develop/devicetree/control.rst | 42 +++++++++++++++++++++++++++---
 dts/Makefile                       | 20 ++++++++++++--
 scripts/Makefile.build             | 11 +++++++-
 scripts/Makefile.dts               | 12 ++++++++-
 scripts/Makefile.lib               | 14 +++++++---
 7 files changed, 98 insertions(+), 11 deletions(-)

---
base-commit: 2515b39e3f1ca1ea341f80b6ad3cbd747341263f
branch: for-upstream/ext-dts-dir

-- 
2.43.0

