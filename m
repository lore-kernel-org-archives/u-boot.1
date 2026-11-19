Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929F606A332
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0ZYX2SkD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sth/BCaL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79EF240ACD;
	Thu, 19 Nov 2026 13:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIJvtM5wmMf2; Thu, 19 Nov 2026 13:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B93A40AC6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095198;
	b=VmH1ZDZGvoW5HIpr2hPBOfmYkbdaOo/g48a/YjJATK5VotPLyxtteXiR/07WO43cJtdq
	 BGSTM8lLJcJG8tWMu0Cku4oS9x9YnwYM6zZ+HXcq8IntvlDj08kdbs6RDsLK2KlXpkQ9W
	 gSAE459R1r58EJlkxIByS2r2pw4T8Umh7Z4Gs5Pik5NgmO7hypa6WI8ofSgoiEfqB9/sn
	 ECT4oXcI5Vrj08KlMoDiBXyMYuVd8ujqJbAiI9756b+SzHtwrtXyXBNYylgR+wkCWAoGe
	 DLOs6gAsusrERlqxQWlY8m8QQnW0Ye9Y0O55ErE26osH8bLGwuRjX8t93z5waFTBlig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095198;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VAfU6uYTBGlN2dpYsk1uqHWqbmle6kAHCuJpyz8ov+0=;
	b=rG5DJab0L5d15SRNu1yDcNUYPTE23R5balQDzcPnkNDQlXlWFnfokdMGyTgvwUdKcaR6
	 KMkGaXqionpFetAKJQ9HH+BQvqqVrVlPvj6Pvoy7/9DMqu6OapEIuh/7pN3fwPKtqi7/L
	 UqfrU2q1OQwHDiO3Qua9gGpuBI+OgLFgvbyDKeiGjtRaJkBE2/sbVOOyFOv2YrPlxYIeG
	 Tgncy5I7FgHcQfRi61YU4ypiCkgLILbK/brkCKYpxYDcl60cKQBaCI/W17LGHqCAsP40m
	 2onrhpM3CVi9Wi454pkWjbFKpX8Cc5sWmV0FuRBHov/kPRq4mUgEcgw2fkyK1hwucnw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095198;
	bh=VAfU6uYTBGlN2dpYsk1uqHWqbmle6kAHCuJpyz8ov+0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0ZYX2SkD4vZ8ZdQTEP0mrXURc6U3JnV5xGVVRS/n6W0IXVN8rkDzJDsR/l4aXdqGP
	 IaemHlVJQXFNsDrUVKIkHNJc9bPHE7ad1z2+9lftirPFa1lRo3x04iayscJXYZQDEP
	 kCupHTca96o6Bis+8P0et3OFRA+r9sVIi5DG/8VKKD99pdskU0qvRuFFdUfF0iZP2J
	 P4eDt3DfGMpK2Arua7My1+imutFNz4F5x+jKmLKDWF6gDJRXEnxcn4xOaWFqrY7+7q
	 MhmSBWGaRaHlcbvg7+PsUXhjAf3FGDI0GQx0kMtU/TB17NcWneu99s6QXb0vIzR19m
	 GaDNYt444J0Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B93A40AC6;
	Thu, 19 Nov 2026 13:33:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CFB222B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F05480D63
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AtzrMAU0gcxT for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BA2A80D4A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=sth/BCaL
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BA2A80D4A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:15 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so1982833f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095194; x=1795699994;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VAfU6uYTBGlN2dpYsk1uqHWqbmle6kAHCuJpyz8ov+0=;
 b=sth/BCaLF8Dl9d+1CV89HTeq7Mvkq3bCeIo1p4US2obPyQrdKdW63pgjhQHl6gmEPe
 1hITJ37EaM6YOm1C3BUM7ouf4HnSWr4oPUF7R8+FG+VYEbq9qll4dN/Cc80xx7tIVmnu
 mL+sJK4KNYnP1v4s/nHua9Ck77tqVmMZ5o2PjXpaaU2HpNEc/E6HmU7rAa51XZ42KLic
 hF6Jaz5SblFM7re9PYAcemZyLGHVOhBPm9ZT6wOGrh3R1qI/m7rHv0KVzM3hDRCO9sV6
 vFIzogW/e8EoDS61qhouW2+xmJa4+LL6Huu//BAcbZpSSTGZzCK53gtaUEyhHLT79uYr
 q41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095194; x=1795699994;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VAfU6uYTBGlN2dpYsk1uqHWqbmle6kAHCuJpyz8ov+0=;
 b=WwapszQzFs4zx4CZz/d2espXtFdBRvbtc2qNNDNTFi4ASPhZH7pVb7IYLdLbLoMkht
 5003EHt5zEN1Tjtr/wVHFvk52XrKfztIKrKs5/gBVVf/V77CPd8KZ7QX1eyIAOEqYOaA
 Sy0Qe2e4IjhF/2y1oKZA36/Rs0zG3Y8fe76HBo0WxtEaZuT/qcn3/y6GoINzlMHTUwMD
 KOzTeRsgAyDhMt2DZrhqpEer3X3g4HB7fj7mb+W+Z4qSRHQZq6kCdy64siKutehr2Hs4
 xXqNU6S3qMgkh5/YA/2qfdRBzjXO9oapgVXz+DBIqdGrVBY/G0bM+fu+/hOFMR5m509H
 KRNQ==
X-Gm-Message-State: APuU4Z+7rbwIdBP8jlASx67FzonNPsuHWYHrMEVM/CVA9U1kF4mT7fTs
 TeJfzqQQpXnXMcp0Ur5PIhvTei8l1arqaEBawCNPzzqp46cvPZeGwosfg+JM6I1b
X-Gm-Gg: AZFdTZcqBfx1Cj9bxS8LD/Qd2hBPaGhOvlYquF3e/UV05i1FLDIuUKz7Bqn6Arx4yyL
 7di3UtJibbw4runahOfFmo2+xDlFoGkCUmIKz6WUR/B57+RJx6mzeU1SGU9QmhjdoyCCCIRKVWB
 5D8wFNykj/XjjU0ja5UfOqjnJ4XljjNtzi/RQNNlrSCbnlf+/PjwcGkbECF6M0Xlf87ntb/eEgS
 AKfyPYpow+5R7ZLLOskIAsLb4P32hj6N+2VWYv8wdlKpktfPXGg/4yWPyyLWSXHEu6gnb+zceuj
 85kxkwUBgHjd76mo+RZPTKngTpCksppvO0VRfb893O1qILNgDsONwU0oZc/EzIko9+nfNvcB1Iy
 GUoxMaS9o1JGKkV93d9uip4yi6wicnbY/9lonuAUj7DjLcEGagyrKv74R0/e+Fu9qbOzzOkETGf
 jsm6Iubn3MjdBrrypyYHfoQBlPEkliUHdKNu4ITnMFgpvvOQEVbYR5ahd/ypIDD0H7Q6kWRa0ff
 ijT5cOMPHhLAiYl4M11JNt6jr45xku22ef7bPecWBe/FxJxSYWDACdszRDFX9PHU+IScc6uwTtP
 y5BM6/aLEkKZKBoScogUM2iabTQOFYN3Vy+G3TbYg+fu95GPXPOymvkKUQL1FkBB5ro/fDo8YT+
 HqUJmiU2HW9FqPrBvS1G2gby9wzlV8CPFceF99bg40VIGq9tRf15iC1Aimdt9jb9B45quwUX9m2
 Et/MalNmq88O1edGGzP/ZpSQpUQgqKNgNtZX2/8ZzL0hwKtQhd1J1t
X-Received: by 2002:a5d:5888:0:b0:48e:5550:c64c with SMTP id
 ffacd0b85a97d-4a63a1e0271mr11471711f8f.14.1795095193338; 
 Thu, 19 Nov 2026 05:33:13 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:12 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 00/14] powerpc: Enable LTO on mpc85xx
Date: Thu, 19 Nov 2026 14:32:56 +0100
Message-ID: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series allows LTO on mpc85xx and enables it for the CZ.NIC
Turris 1.x. The Turris NOR image is limited to 768 KiB. LTO, together
with dropping NVMe and SCSI from the NOR build, makes room for the ubi
command and the BCH ECC code required by the NAND.

v3 is based on next, which has "Makefile: Set LTO_ENABLE before
including config.mk" [1], needed by patch 7. On u-boot-ppc next,
patch 2 conflicts in board/nxp/t104xrdb/spl.c, which that branch
removes. Dropping that hunk resolves it.

The series consists of:

1-2. PowerPC global data:
- Drop an unused SPL copy of gd.
- Make the global data pointer LTO-safe.

3-5. PowerPC private libgcc:
- Add GCC's out-of-line register save and restore routines from Linux.
- Add 64-bit division routines.
- Select the private libgcc for mpc85xx LTO builds, as the LTO link
  puts it inside --whole-archive, where a toolchain libgcc does not
  link.

6-9. mpc85xx LTO support:
- Discard the LTO keep-syms section and its fixups.
- Drop -ffunction-sections and -fdata-sections with LTO, as 32-bit ARM
  does.
- Allow CONFIG_LTO=y on mpc85xx.
- Pass the make jobserver to xPL links, as GCC 12's lto-wrapper
  requires.

10-14. Turris 1.x:
- Enable LTO.
- Select the BCH ECC code required by the NAND.
- Make the NVMe and SCSI boot targets conditional.
- Add the ubi command to the NOR build.
- Put the OTP MAC addresses and serial number into the kernel device
  tree also after the environment has been reset.

On next, the turris_1x_sdcard u-boot.bin is 1052227 bytes, 3651 bytes
more than the 1 MiB that its SPL loads from the card. The build does
not catch this. Patch 10 brings the image back below the limit. Patch
11 fixes a separate problem: without it, NAND probing hits BUG().

With Debian's GCC 14.2, turris_1x_nor's u-boot-nodtb.bin shrinks from
759880 to 752752 bytes while gaining LTO, BCH ECC and the ubi command
and dropping NVMe and SCSI. The turris_1x_sdcard u-boot.bin shrinks
from 1052227 to 998051 bytes.

All 83 PowerPC defconfigs build, and all 71 mpc85xx defconfigs link
with CONFIG_LTO=y. No .discard* section or zero fixup entry remains.
test.py on qemu-ppce500 gives the same results as on next, with and
without LTO. With the kernel.org GCC 14.2 used by CI, both Turris LTO
builds fit. With Debian's GCC 12.2 and make 4.3 in a Debian bookworm
container, the Turris SD card SPL links at -j8 only with patch 9.

v2 was boot-tested on a Turris 1.1 from NOR and SD card. Its NOR build
also booted OpenWrt from a kernel in a UBI volume on NAND, and Linux
received the OTP MAC addresses and serial number even after
"env default -a". With the SD card build, ethaddr and serial# values
set in the environment were preserved. Against v2, the code of v3
changes only in two comments of patch 4. v3 was rebased onto next and
build-tested only, as were the other boards.

Changes in v3:
- Based on next, which has the generic LTO fixes v2 depended on.
- Patch 4: name lib/div64.c as the source more clearly and explain why
  the high word is only divided first when the divisor fits into
  32 bits, as Bradley Morgan asked.
- Patch 7: compare with 32-bit ARM, as ARM64 keeps both flags with LTO.
- Collect Bradley's Reviewed-by tags.
- Measure the sizes again on next.

Changes in v2:
- Based on main.
- Replace "Makefile: Link a toolchain libgcc outside --whole-archive
  with LTO" with patches 3-5, which make the private libgcc work for
  mpc85xx LTO builds.
- Add patch 7 to drop -ffunction-sections and -fdata-sections with LTO.
- Send "Makefile: Skip undefined symbols in keep-syms-lto.c" and
  "Makefile: Pass -static to the LTO link" separately.
- Explain in patch 10 that the SD card image already exceeds 1 MiB
  without BCH ECC.
- Shorten the commit messages of patches 6 and 9.
- Keep Marek Mojík's Reviewed-by from v1. His Tested-by is not carried
  over because the images have changed.

[1] commit 5f3bcac3f7f9 ("Makefile: Set LTO_ENABLE before including config.mk")
v2: https://lore.kernel.org/u-boot/20261018083516.49229-1-pepe.schlehofer@gmail.com/
v1: https://lore.kernel.org/u-boot/20260928110434.70686-1-pepe.schlehofer@gmail.com/

Josef Schlehofer (14):
  board: nxp: p1_p2_rdb_pc, p1010rdb: Drop unused SPL gd copy
  powerpc: Make the global data pointer LTO safe
  powerpc: lib: Add GPR save and restore routines to the private libgcc
  powerpc: lib: Add 64-bit division to the private libgcc
  powerpc: mpc85xx: Use the private libgcc with LTO
  powerpc: mpc85xx: Discard LTO keep-syms sections
  powerpc: Drop -ffunction-sections and -fdata-sections with LTO
  powerpc: mpc85xx: Allow LTO
  xpl: Pass the make jobserver to the xPL link
  configs: turris_1x: Enable LTO
  mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH
  board: CZ.NIC: turris_1x: Make NVMe and SCSI boot targets conditional
  configs: turris_1x_nor: Enable CMD_UBI, drop NVMe and SCSI
  board: CZ.NIC: turris_1x: Fix up MACs and serial number from OTP

 arch/powerpc/Kconfig                      |   2 +
 arch/powerpc/config.mk                    |   8 +-
 arch/powerpc/cpu/mpc83xx/cpu_init.c       |   3 +-
 arch/powerpc/cpu/mpc83xx/spl_minimal.c    |   3 +-
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c |   3 +-
 arch/powerpc/cpu/mpc85xx/u-boot-spl.lds   |  11 +-
 arch/powerpc/cpu/mpc85xx/u-boot.lds       |  11 +-
 arch/powerpc/include/asm/global_data.h    |  30 +++
 arch/powerpc/lib/Makefile                 |   5 +-
 arch/powerpc/lib/crtsavres.S              | 213 ++++++++++++++++++++++
 arch/powerpc/lib/gd.c                     |  14 ++
 arch/powerpc/lib/udivdi3.c                |  85 +++++++++
 board/CZ.NIC/turris_1x/turris_1x.c        |  20 ++
 board/nxp/p1010rdb/spl.c                  |   9 +-
 board/nxp/p1010rdb/spl_minimal.c          |   2 +-
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c     |   3 +
 board/nxp/p1_p2_rdb_pc/spl.c              |   9 +-
 board/nxp/p1_p2_rdb_pc/spl_minimal.c      |   2 +-
 board/nxp/t102xrdb/spl.c                  |   4 +-
 board/nxp/t104xrdb/spl.c                  |   4 +-
 board/nxp/t208xqds/spl.c                  |   4 +-
 board/nxp/t208xrdb/spl.c                  |   4 +-
 board/nxp/t4rdb/spl.c                     |   4 +-
 common/board_r.c                          |   2 +-
 common/init/board_init.c                  |   9 +-
 common/spl/spl.c                          |   4 +-
 configs/kmcoge5ne_defconfig               |   1 -
 configs/turris_1x_nor_defconfig           |  10 +-
 configs/turris_1x_sdcard_defconfig        |   2 +-
 doc/build/gcc.rst                         |   6 +-
 drivers/mtd/nand/raw/Kconfig              |   2 +
 include/configs/turris_1x.h               |  20 +-
 scripts/Makefile.xpl                      |   2 +-
 33 files changed, 449 insertions(+), 62 deletions(-)
 create mode 100644 arch/powerpc/lib/crtsavres.S
 create mode 100644 arch/powerpc/lib/gd.c
 create mode 100644 arch/powerpc/lib/udivdi3.c


base-commit: e6fa1282975af50acf44be7aa678b89e187f0860
-- 
2.54.0 (Apple Git-157)

