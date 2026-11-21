Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B58606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FWlpTz1O;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=JbORxzn0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B1EC81205;
	Sat, 21 Nov 2026 12:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMA17_VuGOrg; Sat, 21 Nov 2026 12:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB7A980F78
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795262718;
	b=K/fAO8D0wkhOKLEXlVrhW2Bczex7hfrd8KX/+DRVQqAwsbu9ar8FWj0kn1dUpkrm7ECp
	 m0Hs/BgPO+t4+Z0iJ1/yBqNsNHfMrCwv3jIg4Vk8kqUnbibgXcO3Ueqa3xagds+H35Eks
	 F+dONxzD915vCKnpiheOJ5nn0mdeasmKTEMOcC5i33qj2QEDDTxnp8XAKBqeMBuZFxJ9v
	 RyM4zkcYJOQ1+uxJT0dqcuH7c5OQkm2ZXSDEHE2GA83B/QQImE6kfx7W/PJmZuG6XwLCW
	 C/+Qch7xnPqNADypC4fOO2hKsBhFAqYkB2BjizqKoBdP2Mpg0BPjnuNaa+NmnsHh6QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795262718;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Yc/hAK2t6KC3ZhTAFvV/GjRy2J3Mb3Q0qjczd5s4nTA=;
	b=N3pf8zkVkJFjrQqFAwm+kMcox+tah3QWndCCI5PBRAq+VG4qvq7lhcgSV9T6HDzmFi1W
	 hZ2B4I/VYzy/OBoNbDBUg7Bzfs7kW+Ri8oVxx/sm1W37dDZkdNP8EblaKV6TAOyowUlEJ
	 Xh3/j+UqnOOFOOG1ZisucxXJZx6ERblxpQi3wqaqjqsk256fFgJx6wCMSlZwwmu407GKt
	 l7D/wtZRgPTuBcI6tfseFY2I74MaKcnn/tp3jSTABWW79djupAQlYHVQoxzPDv8Yzt8dQ
	 p7HmbZRlOox7+olgKzE0sUBQX1/3+1AgJFwg097dOFoasX1wKOxYZR3fD9OfwIq2LJA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=JbORxzn0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795262718;
	bh=Yc/hAK2t6KC3ZhTAFvV/GjRy2J3Mb3Q0qjczd5s4nTA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FWlpTz1O7HObSP2sg+QqpS2JjAonNvCrdoC1607SjHNbv3otyIym/RFnuFHyg5jmT
	 gDNaOs21skwdkPHFidz70wt0sBQicwP9Ue+7qB+0FHcMPoqf0VO4CXNhLSN5eKH4v+
	 Up/kTotWqtWCBStQHw0n4hgvv0KfGKqX5YLN+QieOJYYgNMMUUnvYvmF8J4Xp0yIwz
	 1dlfcz9l0NXMQMfc0pAjCCmtfj0MRs4oQVyTaz0Q61ysouyGOaNxksc89dONsOsA5/
	 9jaTDjFogjRf8/m33BKFElMkGI2MIC0J44eBYq0xxxOZYh+sFJUHilSTsr3aVITrB7
	 gLYofQJVJMCfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB7A980F78;
	Sat, 21 Nov 2026 12:05:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AC135310
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9254A80F78
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LGqoRHhPSk7t for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:05:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CDD280E47
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=JbORxzn0
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CDD280E47
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 03B42B0054E;
 Sat, 21 Nov 2026 13:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1795262709;
 bh=hh4ySlY3w9snuDjDku4hxO0f11IbaPJXG8jj4//FZ74=;
 h=From:To:Cc:Subject:Date:From;
 b=JbORxzn0qqRE3mye5WMMCoxXux8qMFxPaNaWjzbVyAaIeUZ1zZ8pLbOnLDJu+CzkI
 hUfB/peYHlIgP98RlVnIDurqh8PSq0NtEhdh9HRQSBKEILbyRQPxn2YC/AcbGboChP
 vuoahyh5SEw9CF23nOJXIydniMDgSYeE4HeOG/d5WUuqRAkw0i38DWjzdWP7PJGC6r
 PBgdDKtddJDvG+kgZ9m3lV38tPvF0xVFa794j1BmF6/5o4XkRMqPToxLDZ/AlzSz6j
 lYBN8APXECw1T+dWgbn7/GHf4Cknm8TdhC3xbbCfKkEG/Nh9UVmyvd5WJNkclpoIJ3
 gciVoOR7n1JSA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Simon Glass <sjg@chromium.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Vincent Jardin <vjardin@free.fr>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes=20=28Schneider=20Electric=29?=
 <jeremie.dautheribes@bootlin.com>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v3 0/4] dts: build the DTS from a directory outside the tree
Date: Sat, 21 Nov 2026 13:04:40 +0100
Message-ID: <20261121120445.3795725-1-vjardin@free.fr>
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

Patch 1 drops the dtbs rule that dts/upstream/src/mips/Makefile repeats,
which makes the boston builds warn. Patch 2 makes "make DEVICE_TREE=<name>"
build that device tree in the directories built through
scripts/Makefile.dts, which listed Kconfig's only (the VisionFive 2
report [7]). Patch 3 looks for <name>-u-boot.dtsi next to the .dts before
arch/<arch>/dts. Patch 4 adds EXT_DTS_DIR.

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

Changes in v3:
- New patch. The boston builds already warned about the dtbs rule that
  the MIPS Makefile repeats; "scripts: Makefile.dts: build the device
  tree with DEVICE_TREE= too" (Tom Rini)
- Patches 2 to 4 are the patches 1 to 3 of v2, not changed

Changes in v2:
- Rebase on next, v2027.01-rc2
- control.rst: for a WIP board that (Tom Rini)
- 3/3 log: wording: directories, not folders (Marek Vasut)

Vincent Jardin (4):
  dts/upstream: mips: no repeat of the dtbs rule of scripts/Makefile.dts
  scripts: Makefile.dts: build the device tree with DEVICE_TREE= too
  scripts: Makefile.lib: add check of -u-boot.dtsi in the device tree
    source
  dts: build the device tree from a directory outside the tree,
    EXT_DTS_DIR

 .gitignore                         |  1 +
 Makefile                           |  9 +++++-
 doc/develop/devicetree/control.rst | 49 ++++++++++++++++++++++++++++--
 dts/Makefile                       | 20 ++++++++++--
 dts/upstream/src/mips/Makefile     |  6 ----
 scripts/Makefile.build             | 11 ++++++-
 scripts/Makefile.dts               | 12 +++++++-
 scripts/Makefile.lib               | 14 +++++++--
 8 files changed, 105 insertions(+), 17 deletions(-)

---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
branch: for-upstream/ext-dts-dir-v3

-- 
2.43.0

