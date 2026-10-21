Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9D606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DzsMzNOq;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=EYr0mbqw;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=06WIoWWq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B056608DE;
	Wed, 21 Oct 2026 16:16:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5v51VeaRYCa; Wed, 21 Oct 2026 16:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1DDE6083B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599370;
	b=lyoaIJokLL4T1XQ4EGh780c6lCpSEnKG3ZWtK1H5Z0eRhserJqgKb3MPiN5KZoSwqnS3
	 2MEmBRZcerJfV3XlaqII6Q40WTj41J32yFelogqHeTP8LOgpLSiYZ+2kXXERut1h4G+ko
	 4di32p2iktwwoO4bn3FFiMof7lyZsnbpRHRTgzV/wPY02o3z5LSVXIWxLse7Bxa2VX3Ax
	 0ZBj28uhB/99ky0d4ovOH5b476mdqjlyh0gieuIM96jzBfLpPGGyQpwt8CwQzzbfwZjVx
	 f6KnomMvE2Y/GdRCw+fsVK2ebWERr7NEw0fFHyyVdnxe7KoisIYYBNPWuy3yJssRO6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YPO1lmGy/qwuXqHPiVzjXfSeTRm3eWg/1GiqAUvOHmE=;
	b=YYGlUhQsNoa8bwM1ED1Ymw2+0QD0aWG3yptrmwFwrRxiS1Ih292gw7ZZ6gy5SHSUX7nz
	 foagaBm7rMKzfRngiFLNXnR9BL1udodDBR1hb/pV17JUUou7l8vFvWGvODxKF1Bhsktzr
	 0PzzveS2ogeSPQ/LKXTx8/VQ2nDq4WYkSuh+7fE/OrgWT/BQnZ4zJWCUzxVcW7QBITVJO
	 U0K5Fj6C08D9lGhGMGqYc2mBgdMbzbQxEutbo1WeNdj4KCeA+JeV4adKVicB/m61et5aA
	 BoSbzrIa5spmpWWrvmZJjTnykVuLZodjYk+ureZYJobZ/q95+rp7ROpA9RekBwn+5HA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599370;
	bh=YPO1lmGy/qwuXqHPiVzjXfSeTRm3eWg/1GiqAUvOHmE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DzsMzNOq9LxnagpovL5u70hKDmFMpJfHdGj7ZzH3+QH79G3H010U5PNo/crQYC/bn
	 kgHVwKOQinCcZEvC6nU7a7mWn5Ue2oKsrTcI8zYeN0eE7NpvYOoNrB2TjjI84hYXRW
	 CUEf/LvMcoFXSqdy59VQK3k5U7d9nhAC6bFs1IXQDlKhpSEsKur4CEHaiiHJKjnYpZ
	 JdccLoaMQC3QIz+SYiQ4UnuBgTyQ5WHYWqcGACyWa4XoN9i/JGPKZL7hiblFDbz3Rf
	 BeOzBA2vW0OxP/lwDNQbXu37EWzFq61dHb2PkplRDMb/Tun1LaBYsddpCEsUaKVJBm
	 wIuDuXFrKYvqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1DDE6083B;
	Wed, 21 Oct 2026 16:16:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 24C253A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 0A3A140879
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id lpeHsumy3DvQ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50E254084B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598509;
 b=OZi6rlPCtAY6YiNIIOWE7Hv250O+jbbMJZNPOotLxNXulehd0HktUqrtcCLIY9d7KKOP
 ujx4QqZysQ7Bru4aXH5s7L6S+pLeEWZvSA1wx1EkQbjibcartR67szbJusC0Dl8YJnvO4
 3oFMylAoFB8d8r3v9xHu/R7reEw8gE85LbgQZyBixNx3VbidwjOn5K3yjzTDaTIKo+iAU
 nqgJAy4WQd1P6No4UJEbWvL3bhtxzwWYb3rkvLmo1ChEDqeEY1eFeETlfgc0GZNVvaEDz
 cJ+Tj/emgl1O3tdIIidJovc1NzfvCf6WE10LZKcqEHcIMvLmjGdM7hEcpYLoOUw9D8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598509;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=YPO1lmGy/qwuXqHPiVzjXfSeTRm3eWg/1GiqAUvOHmE=;
 b=jrM2HWiyjES/jrC8dEAuPC4cCrEDM6YiorXJoUIubLH03mHtzsvug+u2jZgBkVkZRtPc
 NkmttNxcCnbWzBbCak3AUFZz5rDq6/HNnZfw+dNojpjEFFskgvBTe4r/ojfNL+17z/5Nh
 zK9kLR2u1lz2UJLa+dYalezfaEyvJgzN42oQDlOOxbsgHs3Wz+LqwpGYUdAus7UgACGv6
 9P4/ytFRO8wgA4k5TlXWNaTfK6Nq0JQhgWlZ2nsVVchHXTcP0xRzdvPKK2pqNTT5MkCBV
 hZLRMYnMlpto4HdpJPBamOyug8iVN+cORQhKtqAYY7cazvLtEbwVP9xEINBY3qIBqSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=EYr0mbqw; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=06WIoWWq; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=EYr0mbqw; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=06WIoWWq
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 50E254084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598504; bh=YPO1lmGy/qwuXqHPiVzjXfS
 eTRm3eWg/1GiqAUvOHmE=; b=EYr0mbqwbKdm1pCZleCss9KapCXcpbsZ6rsAWonzLwDp3LLX8X
 ziu4QiV9OhSGBQWRnmKoRZgtGMtxq67LDQLVgqqKxkZJd14kl9G8AyQf0UA7Afuc/jGLZzyWVhh
 DxoxIU/ahwjOq7dKljebvtyOeXA0nVjitXYX+UGhmv7TDDx6xaTlmey63eambLDb7wW/BNnfIzk
 pi4fmSga/CdkidfsRiVx6G1pnR49vEmD+CnVIK56/NqGpEhqZsL9OtnIdA8BjNZCLX5tNjwzJTq
 pMOg52fPGv8kVa2UkPfCAdpo/CvEmzV9wO/q4bIctqlgqx0Rm9CV5flsHU56uPDFNfw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598504; bh=YPO1lmGy/qwuXqHPiVzjXfS
 eTRm3eWg/1GiqAUvOHmE=; b=06WIoWWqVP/38hw9ke1387v5I+zR2l59G50E31WL9OvCr1mqNu
 h9YdajdrTIHuX1tHpQCf9bvOApX9qLux40Cw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
Subject: [PATCH v3 00/26] powerpc: drop unmaintained boards and SoCs,
 take over maintenance
Date: Wed, 21 Oct 2026 16:00:56 +0000
Message-ID: <20261021160145.10430-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 16:16:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC in U-Boot has been orphaned since October 2022. Several boards
and SoC targets in arch/powerpc appear to have had no active community
maintenance or testing for some time.

This series proposes removing the targets that are currently unmaintained,
to help reduce maintenance overhead and ease treewide work. If any board
maintainers or users are still actively testing or relying on a specific
board, those removals can easily be skipped.

Pick structure:
None of the removal patches conflict with one another. Each board removal
is self contained, so pickers can take individual removals as desired
without needing to accept the full series. The SoC cleanups follow the
board removals or cover SoCs that already have no boards in the tree.

=== Board Removals (Independent) ===
Patch  Target       Listed Maintainer
01/26  MPC8548CDS   Priyanka Jain <priyanka.jain@nxp.com>
02/26  MPC837XERDB  Sinan Akman <sinan@writeme.com>
03/26  P2020RDB-PC  Priyanka Jain <priyanka.jain@nxp.com>
04/26  P3041DS      Priyanka Jain <priyanka.jain@nxp.com>
05/26  P4080DS      Priyanka Jain <priyanka.jain@nxp.com>
06/26  P5040DS      Priyanka Jain <priyanka.jain@nxp.com>
07/26  T1042D4RDB   Priyanka Jain <priyanka.jain@nxp.com>

=== SoC and Architecture Removals ===
Patch  SoC / Arch   Notes
08/26  P3041        No remaining consumers once P3041DS is dropped
09/26  P4080        No remaining consumers once P4080DS is dropped
10/26  P5040        No remaining consumers once P5040DS is dropped
11/26  MPC837x      No remaining consumers once MPC837XERDB is dropped
12/26  C29x         No in tree boards
13/26  P1011        No in tree boards
14/26  P1023        No in tree boards
15/26  P1025        No in tree boards
16/26  MPC8536      No in tree boards
17/26  MPC8540      No in tree boards
18/26  MPC8560      No in tree boards
19/26  BSC9132      No in tree boards
20/26  MPC831x      No in tree boards
21/26  MPC834x      No in tree boards
22/26  P1024        No in tree boards
23/26  BSC9131      No in tree boards
24/26  MPC8309      No in tree boards
25/26  MPC86xx      No in tree boards

=== Maintainer Update ===
Patch  Area         Notes
26/26  MAINTAINERS  Add Bradley Morgan as PowerPC maintainer

Changes since v2:
- Fixed build breakage on qemu-ppce500 reported by Peng Fan.
- Removed dangling C291, C292, and C293 CPU table entries from
  arch/powerpc/cpu/mpc8xxx/cpu.c, squashed into patch 12/26.
- Verified build of all sixty seven remaining PowerPC defconfigs
  without error.

Changes since v1:
- Switched all commit descriptions to neutral rationale based on
  community maintenance and testing status.
- Added Pick structure section with tables showing each removal.
- Pruned CC lists on individual patches to relevant board and
  subsystem maintainers.

Bradley Morgan (26):
  board: powerpc: Remove MPC8548CDS support
  board: powerpc: Remove MPC837XERDB support
  board: powerpc: Remove P2020RDB-PC support
  board: powerpc: Remove P3041DS support
  board: powerpc: Remove P4080DS support
  board: powerpc: Remove P5040DS support
  board: powerpc: Remove T1042D4RDB support
  powerpc: mpc85xx: Remove P3041 support
  powerpc: mpc85xx: Remove P4080 support
  powerpc: mpc85xx: Remove P5040 support
  powerpc: mpc83xx: Remove MPC837x support
  powerpc: mpc85xx: Remove C29x support
  powerpc: mpc85xx: Remove P1011 support
  powerpc: mpc85xx: Remove P1023 support
  powerpc: mpc85xx: Remove P1025 support
  powerpc: mpc85xx: Remove MPC8536 support
  powerpc: mpc85xx: Remove MPC8540 support
  powerpc: mpc85xx: Remove MPC8560 support
  powerpc: mpc85xx: Remove BSC9132 support
  powerpc: mpc83xx: Remove MPC831x support
  powerpc: mpc83xx: Remove MPC834x support
  powerpc: mpc85xx: Remove P1024 support
  powerpc: mpc85xx: Remove BSC9131 support
  powerpc: mpc83xx: Remove MPC8309 support
  powerpc: Remove MPC86xx support
  MAINTAINERS: powerpc: Add me as PowerPC maintainer

 MAINTAINERS                                   |   3 +-
 README                                        |   2 +-
 api/api_platform-powerpc.c                    |   2 +-
 arch/Kconfig                                  |   7 +-
 arch/Kconfig.nxp                              |   9 +-
 arch/powerpc/cpu/Makefile                     |   1 -
 arch/powerpc/cpu/mpc83xx/Kconfig              |  44 --
 arch/powerpc/cpu/mpc83xx/cpu.c                |  17 +-
 arch/powerpc/cpu/mpc83xx/cpu_init.c           |  24 -
 arch/powerpc/cpu/mpc83xx/fdt.c                |  47 +-
 arch/powerpc/cpu/mpc83xx/hid/Kconfig          |   4 +-
 arch/powerpc/cpu/mpc83xx/hid/hid.h            |   5 -
 arch/powerpc/cpu/mpc83xx/hrcw/Kconfig         |  82 +--
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr |   6 +-
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr |   2 +-
 arch/powerpc/cpu/mpc83xx/pci.c                |   2 -
 arch/powerpc/cpu/mpc83xx/spd_sdram.c          |   4 +-
 arch/powerpc/cpu/mpc83xx/speed.c              | 112 +--
 arch/powerpc/cpu/mpc83xx/traps.c              |   1 -
 arch/powerpc/cpu/mpc85xx/Kconfig              | 443 +-----------
 arch/powerpc/cpu/mpc85xx/Makefile             |  14 -
 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c     | 101 ---
 arch/powerpc/cpu/mpc85xx/c29x_serdes.c        |  70 --
 arch/powerpc/cpu/mpc85xx/cmd_errata.c         |  43 +-
 arch/powerpc/cpu/mpc85xx/cpu.c                |  17 -
 arch/powerpc/cpu/mpc85xx/cpu_init.c           |  49 +-
 arch/powerpc/cpu/mpc85xx/fdt.c                |  28 +-
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c | 665 ------------------
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h |   4 -
 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c     | 250 -------
 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c     |  57 --
 arch/powerpc/cpu/mpc85xx/p1023_serdes.c       |  59 --
 arch/powerpc/cpu/mpc85xx/p3041_ids.c          | 112 ---
 arch/powerpc/cpu/mpc85xx/p3041_serdes.c       | 133 ----
 arch/powerpc/cpu/mpc85xx/p4080_ids.c          | 112 ---
 arch/powerpc/cpu/mpc85xx/p4080_serdes.c       |  80 ---
 arch/powerpc/cpu/mpc85xx/p5040_ids.c          | 111 ---
 arch/powerpc/cpu/mpc85xx/p5040_serdes.c       |  99 ---
 arch/powerpc/cpu/mpc85xx/release.S            |  23 +-
 arch/powerpc/cpu/mpc85xx/speed.c              |   6 +-
 arch/powerpc/cpu/mpc8xxx/Makefile             |   1 -
 arch/powerpc/cpu/mpc8xxx/cpu.c                |  23 +-
 arch/powerpc/cpu/mpc8xxx/fdt.c                |   8 +-
 arch/powerpc/cpu/mpc8xxx/srio.c               |   6 -
 arch/powerpc/dts/Makefile                     |   7 -
 arch/powerpc/dts/mpc8379erdb.dts              | 153 ----
 arch/powerpc/dts/mpc8548-post.dtsi            |  36 -
 arch/powerpc/dts/mpc8548.dtsi                 |  27 -
 arch/powerpc/dts/mpc8548cds.dts               |  29 -
 arch/powerpc/dts/mpc8548cds_36b.dts           |  29 -
 arch/powerpc/dts/p2020rdb-pc.dts              |  59 --
 arch/powerpc/dts/p2020rdb-pc.dtsi             |  50 --
 arch/powerpc/dts/p2020rdb-pc_36b.dts          |  59 --
 arch/powerpc/dts/p3041.dtsi                   | 149 ----
 arch/powerpc/dts/p3041ds.dts                  | 158 -----
 arch/powerpc/dts/p3041si-post.dtsi            |  43 --
 arch/powerpc/dts/p4080.dtsi                   | 148 ----
 arch/powerpc/dts/p4080ds.dts                  | 220 ------
 arch/powerpc/dts/p4080si-post.dtsi            |  62 --
 arch/powerpc/dts/p5040.dtsi                   | 137 ----
 arch/powerpc/dts/p5040ds.dts                  | 281 --------
 arch/powerpc/dts/p5040si-post.dtsi            |  70 --
 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi       |  12 -
 arch/powerpc/dts/t1042d4rdb.dts               |  89 ---
 arch/powerpc/dts/t104x.dtsi                   | 148 ----
 arch/powerpc/include/asm/arch-mpc83xx/gpio.h  |   4 +-
 arch/powerpc/include/asm/arch-mpc83xx/soc.h   |  37 +-
 arch/powerpc/include/asm/config.h             |   1 -
 arch/powerpc/include/asm/config_mpc85xx.h     |  56 +-
 arch/powerpc/include/asm/fsl_law.h            |   8 -
 arch/powerpc/include/asm/fsl_lbc.h            |  15 +-
 arch/powerpc/include/asm/fsl_pci.h            |   7 -
 arch/powerpc/include/asm/fsl_secure_boot.h    |   1 -
 arch/powerpc/include/asm/fsl_serdes.h         |   3 -
 arch/powerpc/include/asm/global_data.h        |  19 +-
 arch/powerpc/include/asm/immap_83xx.h         | 123 +---
 arch/powerpc/include/asm/immap_85xx.h         | 253 +------
 arch/powerpc/include/asm/mpc8349_pci.h        | 165 -----
 arch/powerpc/include/asm/mpc8xxx_spi.h        |   5 +-
 arch/powerpc/include/asm/ppc.h                |  14 +-
 arch/powerpc/include/asm/processor.h          |  36 +-
 arch/powerpc/lib/bdinfo.c                     |   2 +-
 arch/powerpc/lib/bootm.c                      |   7 -
 arch/powerpc/lib/ppccache.S                   |   4 +-
 arch/powerpc/lib/stack.c                      |   2 +-
 board/nxp/common/Makefile                     |  11 -
 board/nxp/common/cds_pci_ft.c                 |  17 -
 board/nxp/common/cds_via.c                    |  95 ---
 board/nxp/common/ics307_clk.c                 | 149 ----
 board/nxp/common/ics307_clk.h                 |  14 -
 board/nxp/common/ngpixis.c                    | 247 -------
 board/nxp/common/ngpixis.h                    |  60 --
 board/nxp/common/sdhc_boot.c                  |   2 +-
 board/nxp/mpc837xerdb/Kconfig                 |  15 -
 board/nxp/mpc837xerdb/MAINTAINERS             |   6 -
 board/nxp/mpc837xerdb/Makefile                |   6 -
 board/nxp/mpc837xerdb/README                  |  97 ---
 board/nxp/mpc837xerdb/mpc837xerdb.c           | 242 -------
 board/nxp/mpc8548cds/Kconfig                  |  24 -
 board/nxp/mpc8548cds/MAINTAINERS              |   8 -
 board/nxp/mpc8548cds/Makefile                 |  10 -
 board/nxp/mpc8548cds/ddr.c                    |  51 --
 board/nxp/mpc8548cds/law.c                    |  18 -
 board/nxp/mpc8548cds/mpc8548cds.c             | 170 -----
 board/nxp/mpc8548cds/tlb.c                    |  87 ---
 board/nxp/p1_p2_rdb_pc/Kconfig                |   3 +-
 board/nxp/p1_p2_rdb_pc/MAINTAINERS            |   8 -
 board/nxp/p1_p2_rdb_pc/README                 |   7 +-
 board/nxp/p1_p2_rdb_pc/ddr.c                  |  68 --
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c         |   2 -
 board/nxp/t104xrdb/Kconfig                    |  12 -
 board/nxp/t104xrdb/MAINTAINERS                |  13 -
 board/nxp/t104xrdb/Makefile                   |  13 -
 board/nxp/t104xrdb/README                     | 386 ----------
 board/nxp/t104xrdb/cpld.c                     | 116 ---
 board/nxp/t104xrdb/cpld.h                     |  45 --
 board/nxp/t104xrdb/ddr.c                      | 148 ----
 board/nxp/t104xrdb/ddr.h                      |  56 --
 board/nxp/t104xrdb/law.c                      |  31 -
 board/nxp/t104xrdb/spl.c                      | 131 ----
 board/nxp/t104xrdb/t1040_nand_rcw.cfg         |   7 -
 board/nxp/t104xrdb/t1040_sd_rcw.cfg           |   7 -
 board/nxp/t104xrdb/t1040_spi_rcw.cfg          |   7 -
 board/nxp/t104xrdb/t1040d4_nand_rcw.cfg       |   7 -
 board/nxp/t104xrdb/t1040d4_sd_rcw.cfg         |   7 -
 board/nxp/t104xrdb/t1040d4_spi_rcw.cfg        |   7 -
 board/nxp/t104xrdb/t1042_nand_rcw.cfg         |   7 -
 board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg      |   7 -
 board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg        |   7 -
 board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg       |   7 -
 board/nxp/t104xrdb/t1042_sd_rcw.cfg           |   7 -
 board/nxp/t104xrdb/t1042_spi_rcw.cfg          |   7 -
 board/nxp/t104xrdb/t1042d4_nand_rcw.cfg       |   7 -
 board/nxp/t104xrdb/t1042d4_sd_rcw.cfg         |   7 -
 board/nxp/t104xrdb/t1042d4_spi_rcw.cfg        |   7 -
 board/nxp/t104xrdb/t104x_pbi.cfg              |  36 -
 board/nxp/t104xrdb/t104x_pbi_sb.cfg           |  38 -
 board/nxp/t104xrdb/t104xrdb.c                 | 159 -----
 board/nxp/t104xrdb/t104xrdb.h                 |  11 -
 board/nxp/t104xrdb/tlb.c                      | 132 ----
 boot/Kconfig                                  |   4 +-
 common/board_r.c                              |   2 +-
 configs/MPC837XERDB_defconfig                 | 193 -----
 configs/MPC8548CDS_36BIT_defconfig            | 108 ---
 configs/MPC8548CDS_defconfig                  | 106 ---
 configs/MPC8548CDS_legacy_defconfig           | 106 ---
 configs/P2020RDB-PC_36BIT_NAND_defconfig      | 164 -----
 configs/P2020RDB-PC_36BIT_SDCARD_defconfig    | 145 ----
 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig  | 147 ----
 configs/P2020RDB-PC_36BIT_defconfig           | 125 ----
 configs/P2020RDB-PC_NAND_defconfig            | 162 -----
 configs/P2020RDB-PC_SDCARD_defconfig          | 142 ----
 configs/P2020RDB-PC_SPIFLASH_defconfig        | 145 ----
 configs/P2020RDB-PC_defconfig                 | 123 ----
 configs/T1042D4RDB_NAND_defconfig             | 144 ----
 configs/T1042D4RDB_SDCARD_defconfig           | 138 ----
 configs/T1042D4RDB_SPIFLASH_defconfig         | 141 ----
 configs/T1042D4RDB_defconfig                  | 114 ---
 doc/README.mpc83xxads                         |  97 ---
 doc/README.mpc85xx-sd-spi-boot                |   8 -
 doc/README.mpc85xxcds                         | 225 ------
 doc/README.pblimage                           |   6 +-
 doc/README.sata                               |  68 --
 doc/README.srio-pcie-boot-corenet             | 118 ----
 .../clock/fsl,mpc83xx-clk.txt                 |   7 +-
 doc/device-tree-bindings/cpu/fsl,mpc83xx.txt  |  13 +-
 .../gpio/fsl,mpc83xx-spisel-boot.txt          |   4 +-
 drivers/clk/mpc83xx_clk.c                     |  19 +-
 drivers/clk/mpc83xx_clk.h                     |  30 +-
 drivers/cpu/mpc83xx_cpu.c                     |  62 +-
 drivers/cpu/mpc83xx_cpu.h                     |  44 --
 drivers/crypto/fsl/jr.c                       |  14 +-
 drivers/ddr/fsl/Kconfig                       |   8 +-
 drivers/ddr/fsl/ctrl_regs.c                   |   1 -
 drivers/dma/fsl_dma.c                         |   4 -
 drivers/gpio/mpc83xx_spisel_boot.c            |   1 -
 drivers/gpio/mpc8xxx_gpio.c                   |   1 -
 drivers/mmc/Kconfig                           |   3 +-
 drivers/net/Kconfig                           |   4 -
 drivers/net/fm/Makefile                       |   6 +-
 drivers/net/fm/fm.h                           |   4 -
 drivers/net/fm/p1023.c                        |  72 --
 drivers/net/fm/p4080.c                        |  98 ---
 drivers/net/fm/p5040.c                        | 106 ---
 drivers/pci/Kconfig                           |   2 +-
 drivers/pci/pci_auto.c                        |  14 -
 drivers/pci/pcie_fsl.c                        |  23 -
 drivers/qe/Kconfig                            |   3 +-
 drivers/qe/qe.c                               |   1 -
 drivers/ram/mpc83xx_sdram.c                   |  14 +-
 drivers/usb/common/fsl-errata.c               |  15 -
 drivers/usb/host/Kconfig                      |   2 +-
 env/Kconfig                                   |   3 +-
 include/asm-generic/u-boot.h                  |   2 +-
 include/configs/MPC837XERDB.h                 | 218 ------
 include/configs/MPC8548CDS.h                  | 312 --------
 include/configs/T104xRDB.h                    | 397 -----------
 include/configs/p1_p2_rdb_pc.h                |  21 -
 include/dt-bindings/clk/mpc83xx-clk.h         |   1 -
 include/fsl_immap.h                           |   2 +-
 include/fsl_sec.h                             |   3 -
 include/mpc83xx.h                             | 319 +--------
 include/pci_ids.h                             |   4 -
 include/serial.h                              |   1 -
 204 files changed, 178 insertions(+), 12876 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/c29x_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p1023_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_serdes.c
 delete mode 100644 arch/powerpc/dts/mpc8379erdb.dts
 delete mode 100644 arch/powerpc/dts/mpc8548-post.dtsi
 delete mode 100644 arch/powerpc/dts/mpc8548.dtsi
 delete mode 100644 arch/powerpc/dts/mpc8548cds.dts
 delete mode 100644 arch/powerpc/dts/mpc8548cds_36b.dts
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dts
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dtsi
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc_36b.dts
 delete mode 100644 arch/powerpc/dts/p3041.dtsi
 delete mode 100644 arch/powerpc/dts/p3041ds.dts
 delete mode 100644 arch/powerpc/dts/p3041si-post.dtsi
 delete mode 100644 arch/powerpc/dts/p4080.dtsi
 delete mode 100644 arch/powerpc/dts/p4080ds.dts
 delete mode 100644 arch/powerpc/dts/p4080si-post.dtsi
 delete mode 100644 arch/powerpc/dts/p5040.dtsi
 delete mode 100644 arch/powerpc/dts/p5040ds.dts
 delete mode 100644 arch/powerpc/dts/p5040si-post.dtsi
 delete mode 100644 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi
 delete mode 100644 arch/powerpc/dts/t1042d4rdb.dts
 delete mode 100644 arch/powerpc/dts/t104x.dtsi
 delete mode 100644 arch/powerpc/include/asm/mpc8349_pci.h
 delete mode 100644 board/nxp/common/cds_pci_ft.c
 delete mode 100644 board/nxp/common/cds_via.c
 delete mode 100644 board/nxp/common/ics307_clk.c
 delete mode 100644 board/nxp/common/ics307_clk.h
 delete mode 100644 board/nxp/common/ngpixis.c
 delete mode 100644 board/nxp/common/ngpixis.h
 delete mode 100644 board/nxp/mpc837xerdb/Kconfig
 delete mode 100644 board/nxp/mpc837xerdb/MAINTAINERS
 delete mode 100644 board/nxp/mpc837xerdb/Makefile
 delete mode 100644 board/nxp/mpc837xerdb/README
 delete mode 100644 board/nxp/mpc837xerdb/mpc837xerdb.c
 delete mode 100644 board/nxp/mpc8548cds/Kconfig
 delete mode 100644 board/nxp/mpc8548cds/MAINTAINERS
 delete mode 100644 board/nxp/mpc8548cds/Makefile
 delete mode 100644 board/nxp/mpc8548cds/ddr.c
 delete mode 100644 board/nxp/mpc8548cds/law.c
 delete mode 100644 board/nxp/mpc8548cds/mpc8548cds.c
 delete mode 100644 board/nxp/mpc8548cds/tlb.c
 delete mode 100644 board/nxp/t104xrdb/Kconfig
 delete mode 100644 board/nxp/t104xrdb/MAINTAINERS
 delete mode 100644 board/nxp/t104xrdb/Makefile
 delete mode 100644 board/nxp/t104xrdb/README
 delete mode 100644 board/nxp/t104xrdb/cpld.c
 delete mode 100644 board/nxp/t104xrdb/cpld.h
 delete mode 100644 board/nxp/t104xrdb/ddr.c
 delete mode 100644 board/nxp/t104xrdb/ddr.h
 delete mode 100644 board/nxp/t104xrdb/law.c
 delete mode 100644 board/nxp/t104xrdb/spl.c
 delete mode 100644 board/nxp/t104xrdb/t1040_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t104x_pbi.cfg
 delete mode 100644 board/nxp/t104xrdb/t104x_pbi_sb.cfg
 delete mode 100644 board/nxp/t104xrdb/t104xrdb.c
 delete mode 100644 board/nxp/t104xrdb/t104xrdb.h
 delete mode 100644 board/nxp/t104xrdb/tlb.c
 delete mode 100644 configs/MPC837XERDB_defconfig
 delete mode 100644 configs/MPC8548CDS_36BIT_defconfig
 delete mode 100644 configs/MPC8548CDS_defconfig
 delete mode 100644 configs/MPC8548CDS_legacy_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_NAND_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_SDCARD_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_defconfig
 delete mode 100644 configs/P2020RDB-PC_NAND_defconfig
 delete mode 100644 configs/P2020RDB-PC_SDCARD_defconfig
 delete mode 100644 configs/P2020RDB-PC_SPIFLASH_defconfig
 delete mode 100644 configs/P2020RDB-PC_defconfig
 delete mode 100644 configs/T1042D4RDB_NAND_defconfig
 delete mode 100644 configs/T1042D4RDB_SDCARD_defconfig
 delete mode 100644 configs/T1042D4RDB_SPIFLASH_defconfig
 delete mode 100644 configs/T1042D4RDB_defconfig
 delete mode 100644 doc/README.mpc83xxads
 delete mode 100644 doc/README.mpc85xxcds
 delete mode 100644 doc/README.sata
 delete mode 100644 doc/README.srio-pcie-boot-corenet
 delete mode 100644 drivers/net/fm/p1023.c
 delete mode 100644 drivers/net/fm/p4080.c
 delete mode 100644 drivers/net/fm/p5040.c
 delete mode 100644 include/configs/MPC837XERDB.h
 delete mode 100644 include/configs/MPC8548CDS.h
 delete mode 100644 include/configs/T104xRDB.h

-- 
2.47.3

