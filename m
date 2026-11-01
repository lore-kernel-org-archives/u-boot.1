Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4123606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aH3ExKva;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwDBgUMI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88C09405AB;
	Sun,  1 Nov 2026 21:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XpHE2AVxEVtm; Sun,  1 Nov 2026 21:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5374C4053C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567122;
	b=KJ1CQkRdub7uYnqt0UFX90DBFSOeyQFbYHaVSNXHCMqShsCLQ3QXT36AtpFo27pD7oh8
	 crTYUlDUn1V2lW3wZcdTs55cMSsHwGF6OvPUBNEUzSM74v86IXru8P6onn7QphOOsTrkW
	 r1UWMt6RhYIqC2CxJ7sJ5w3Dk9715ndFLLfZX7fTEpYDgJovFLv+bzfLpgIUsevg4kFFz
	 dhVDvPSxGxwc/tqvvzsIIrWWYbx1F4/+KWXg5pVpF9Ef5K/fn4vBe2ptdZN5ZMkO3/vUc
	 h1xqbv2RIzexRmfFMKPG77kMaU2z7EVo8LOaQuK7BbLxrKLmm7Gx9nu0MT+h4O7czdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567122;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zrxInYZQCy+8ml9niUGKKSK9xagOCjzwDhBCA/3T7nU=;
	b=l861flh1scsGW5g1/S4tTAT+FBIolu36YZgj7y1aGqNlUdCO/HC56yA/X7OoP2hdtrQ9
	 k2MwE+WJfGaMCNV5U8K/d1nl9kpjjtGPIEbIVhYc5oqpWkluIpcggxuHFTsDAvc2vpbln
	 IYkqp1saNxR0QuVO7ff9zbFo5mLsBpsdWw6ZVk2nm+rACO3Btb9Gg4xZ3LAJ/no8Fxunq
	 Q/rEGZXTAPhDAe61BW3PrfI0IARMLUuWWonzrH3BmF2W8OeZslg2RB+N4td+/CCVBXL5u
	 4V+UvOAzj7l0FNHXnEyHHOhnkIbd9MeJaQHtY7vGL7c/vduCx3MDI8SJ+HxyvHja8+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567122;
	bh=zrxInYZQCy+8ml9niUGKKSK9xagOCjzwDhBCA/3T7nU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aH3ExKvaUJhNa9hKMzwiN+hkNqPgSPZXoXRhUW2F7LVvdx8KE/ZEEU0XoA6eKHspk
	 nODjD7nYU2h989EMlwr50KyPpb3R/hpbJISyReAcAM5WMqIeDrkpSP91jclBBGTsrv
	 iNLPjwGuBQMgUSYzg53TkKPlt11K4ZY+fm6sWcHI/cSc+ZjzeZMEN1/fC5iMyAH4M5
	 sqNKlDMJ1Lg5ITGEsGt+wbZca2L+5Fwpo9h4n8F4pj97XQzgXM5+JasmT0tvXoIo8H
	 LzsRYwF2EvFRKTImcct1DS6UPAQ5AfusZd6D0TDbgtfDgy8VjYE5MYe6BnH6dw3U0b
	 UeHTz5DsCs0IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5374C4053C;
	Sun,  1 Nov 2026 21:05:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 536E1323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4581C400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rDZJzEjs5fRM for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C80D240042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::229"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567120;
 b=HrnQF6H6JPK+yQjs11TqYwjEhGS9u7pq0Hvf5K5zPNmmo0VuFy8nmo3IKB5EnWVecJOr
 CXw6z74eRl8uPvuvhCa96QVgx/4TceuMjH1s2oG9uMjWmBtb5mKk2ruBox/UdeGZPmpGH
 pIdpa/WBhSJd/+DsXTLgs6FK3/rsQh8ZO3wL35aw5i9kbLvgn26pRgl5pVisPeetws0hb
 lZ0mtpd2p8u5+o0PVqriY9/bEOtFpyxJS6MczfxZ+UtaAzIs4gm3ass0xTOcdsaNeSzPc
 fePBYv8Lr0ozDb28tH4mHKuEHKfRSytYmMORxNh8Qs7/dZOV7DctbdcbOpos0wxfFsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567120;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=zrxInYZQCy+8ml9niUGKKSK9xagOCjzwDhBCA/3T7nU=;
 b=mzKaSsaUSa78KuKujKS6zO7q5BuRanD7D0Kj3QZcI24Tej0iUTyscZQRmVONiqaAruHl
 qPaXMCJUkMoVpY0i86ytcSrcHZYeE/lw8FVAi44k4eSdqoG/w5/N/RbDnXJPVN7UTCfxE
 zuEk0znciSBNca17kDL2QPa8aZ04PFPPSGppUVn+LLW6eQZT9VH8SRSNpNEqCNnbWvBJQ
 aIn8t53dJ14SRkdA81XjoFosiUPieI3hl1WX3memz34Aihws1vxPdjUkGcA1Q7DfENF05
 PfNuNRDBqDcP4o/tekrmez+kF55FnDXEtI8zZo7dAoMtMNz3RIOcnOU2dg1bZvRgyOg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=CwDBgUMI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=CwDBgUMI
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C80D240042
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:19 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3a9e87ba696so17212421fa.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567117; x=1794171917;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zrxInYZQCy+8ml9niUGKKSK9xagOCjzwDhBCA/3T7nU=;
 b=CwDBgUMI6P3t0Et46Osw34rotD8vTN1YfulpNiPkcVw65olBMgQSnfX3iKjPpfcb1Y
 lWaI6WGQToQkAyCgiuTJlJ9dMuUChjSgkZQO0DmP/zlZVClnoJ5pZOB50JPX1P49VRp9
 OYIMUmjWCOMP2y96n/M9UTwhBOr4R3b99EmQ8orRm50C06IbkvKqWRcIu3/K4lLcfRU+
 beVfmE676Ncn1q/LdvGXx/yEXJAr+i19281iXSrymGiZcq1bGn2KmU0XXfFb6vSvHIub
 8UFH3OQ3By+n0FoaJkKr4g+wUJSuz6o/Y6nYNwOuQhs4Xq+E4FQYsbP08AYFUMH2ahiR
 AZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567117; x=1794171917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zrxInYZQCy+8ml9niUGKKSK9xagOCjzwDhBCA/3T7nU=;
 b=MuOSqL9yGK7hLZdyqUyUC1+9+LEvYBX/hruaViBh6vuW5qjVKCZTeAgejnNmTCu+R3
 Up3WC406bmueS2etS1xYfxueTX+1SZ3g07x0ZYHNkQVEvVkxBUlP2NmmTIfxRsv6V8lX
 xYIprTTspXlz+yFvWFY+EtFOVh8nbLRDSdqf5ZAjAO4/YAOvwAyHepJzMOMlGUa8UHmq
 KoP5V7Jozr51uEW5TJALoJLjQU3IirKiKB4NwV12UXllbqTCGokRbn5qatkGgNI+ZGvL
 t0wac52278UahNUBvnu7Ugz7rr68rHcs/F1dqcnmSWOJcrxr6q7jA9wgRpXNi/8IVodX
 6P0Q==
X-Gm-Message-State: APuU4Z+zK1k1ILWoMDeSGU866NFLqG6nuEx08fr6ZjnaTczolTUZd5Gi
 rhp/XnurBO9CI82S3wPsSIFLpU4e3N7rsyVB7KxC0fLUjTrWPAQOn37x7jlC1zXY
X-Gm-Gg: AYBFou3Jivh9RNBF5v1E2qpIuUHE3QSVi7CbIt+3VKC1N8wmhRx3In+Jz8fsBEo5YB+
 8pINYQpaXyiBHRfiESY87jz/eg/07PNfSJ7YMbGnQMkxOcTT3ZOVujoy+1eY/IfmMFxCWMtW/3V
 h7MYKc/Ksa8WUgDB8aPykYCtuZ3lc3y5bYfWGPQ2jLsv3k+RSKVImmJTi1BPo1RQD51z04dHEDP
 FlOxl+X5GXVs4J7R2IYR7fvOrqfgbC/V5caNDZQtwFNsNjfGUOH9RGC9iu9Kd2/1cyGQvOOaCBO
 uaTcYITFOnt9AafnDnWoiSO/vda3d7l2QBPO+UTaSlok0s5OAlJ7TZpkocpMaGlorYP4wU0R6Z9
 5rSP7uuokqtxohZ5OX42DXRL8qvdT5WsvFd9GADK1FCLiAKYaY1emFCWrw4o1LiAkZfFmJEC9gM
 eQFyuH5oAUYJWbQvmy9i3XwJJVuRcU7ZOW+mcFep2uw9iy627rG9b3PFY1u4oBpx3pfJgYj3fSq
 cXZ5TH/pz7Vu3WVICMG7fp2d16W/OnQayjohbrn9itr0pRHHtjrCqcjNW45Lai97+lWr8vPHN8v
 K4gazt2dY0+S9c8EOJbCu0GfFZsdHDcnbIed+2xqU4dca2xHJzcc/3h+V7NCZUMUcjw=
X-Received: by 2002:a05:651c:2122:b0:3ac:974c:64f3 with SMTP id
 38308e7fff4ca-3acb7b20239mr21128711fa.22.1793567116512; 
 Sun, 01 Nov 2026 13:05:16 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:14 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 00/10] riscv: sun20i: add support for the Allwinner
 D1/D1s(F133) SoCs and boards
Date: Sun,  1 Nov 2026 23:04:39 +0200
Message-ID: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Building upon the work of Samuel Holland [1], this series introduces support
for the Allwinner D1/D1s(F133) RISC-V SoCs and two development boards:

- Sipeed Lichee RV Dock (D1 SoC)
- MangoPi MQ (RISC-V version with D1s/F133-A SoC)

The main difference from Samuel's work is how the boards are wired into the
tree. The original design aimed at one cross-architecture configuration which
covers ARM sun8i and RISC-V sun20i parts from Allwinner. This series does not
do that. The D1/D1s get their own configuration instead:

  - arch/riscv/cpu/sun20i/ and board/sun20i/ hold the RISC-V side
  - SUN20I is a SoC-family symbol, TARGET_SUN20I the board target
  - the shared sunxi drivers accept SUN20I next to ARCH_SUNXI, so they are
    shared as before -- only the Kconfig condition changes

Keeping the two sides apart has a cost: a few things exist twice.
SUNXI_GEN_NCAT2 is declared in both arch trees, because the shared drivers
test it and no Kconfig file is sourced by both. clock_get_pll6() is a C
function for ARM (clock_sun50i_h6.c) and an inline for RISC-V
(arch-sun20i/clock.h), decoding the same NCAT2 registers. The MMC mod-clock
bits, the CCU offsets and parts of board/sunxi/board.c are repeated the same
way.

For the sake of simplicity the image names stay "sunxi"
(u-boot-sunxi-with-spl.bin, inner sunxi-spl.bin) because that is the shared
Allwinner eGON boot format.

Both defconfigs build, and both boards boot from the SD card to a userspace
login. The images were built with custom Buildroot configuration, using
gcc 16.2.0, binutils 2.46.1 and Linux 7.3.0.

One caveat -- reboot does not work yet; it needs fixes outside U-Boot, on the
firmware/OS side.

AI/LLM tools were used as development assistants throughout this work.
Their use included debugging DRAM initialization and probing issues,
assisting with code development, reviewing code, helping with testing and
validation, and reviewing and refining commit messages.

PS. The boards use CONFIG_NS16550_CLK_ENABLE, which comes from a patch
originally posted by khaliforce <kforce@gmail.com> and merged as commit
70f51e1e2ea5 ("serial: ns16550: make probe clock enabling optional") by
Samuel Holland; v2027.01-rc1 already contains it.

[1] https://github.com/smaeul/u-boot/tree/d1-wip


The patches (on tag v2027.01-rc1)
---------------------------------

1/10 riscv: cpu: add Allwinner D1/D1s(F133) CPU support
     Add the C906 support for the D1/D1s(F133) SoCs:

     - T-Head cache operations from the custom cache instructions
     - harts_early_init() programming MXSTATUS, MHCR and MHINT
     - cleanup_before_linux() disabling interrupts and flushing the caches
     - dram_init() from the device tree memory nodes
     - the T-Head CSR, CCU clock and memory map headers
     - SUN20I Kconfig (cache line size, T-Head CMO support)

2/10 sunxi: allow the sunxi drivers to be built for sun20i
     Accept SUN20I next to ARCH_SUNXI for the RAM, clock, pinctrl, GPIO, MMC,
     reset and watchdog drivers, and keep WATCHDOG_AUTOSTART off for it.

     Declare SUNXI_GEN_NCAT2 here as well - the ARM sunxi Kconfig is not read
     by a RISC-V build - and add the MMC base addresses to arch-sun20i/cpu.h
     so sunxi_mmc.c builds.

3/10 board: sun20i: add common support for the D1/D1s boards
     Add the board code used by all D1/D1s(F133) boards:

     - TARGET_SUN20I, board init and CPU probing
     - sunxi eGON/TOC0 SPL header: boot source, FEL mode, SPL size
     - SPL DRAM probing and the /memory fixup
     - FIT DT name matching
     - environment placement for MMC/SPI boot media
     - the u-boot-sunxi-with-spl.bin image
     - a MAINTAINERS section for the new board and CPU files

     CONFIG_ARCH_SUNXI is never set on these RISC-V parts, so extend the SPL
     image rule in scripts/Makefile.xpl to match TARGET_SUN20I as well.

     The board code, the devicetree overlay and include/configs/sun20i.h come
     from Samuel Holland's d1-wip tree [1]. The board code in turn derives from
     the ARM sunxi board code, so its copyright notices are kept.

     [1] https://github.com/smaeul/u-boot/tree/d1-wip

4/10 sunxi: dram: fix integer-pointer conversions in the D1 DRAM driver
     Fix readl()/writel() address types for GCC 15+

     Use typed base address macros and cast remaining register addresses
     to void __iomem * to satisfy GCC 15's stricter type checking.

     No functional change.

5/10 sunxi: dram: count the banks on address bit 11, not A22
     The bank test looks for the BA2 alias at address bit 22, but in the mode
     the probe programs BA2 is bit 11. A four bank part therefore always
     reports eight banks, turning 64MB into 128MB.

     On a MangoPi MQ with F133-A the probe now reports 4 banks, 13 rows and 2KB
     pages - the vendor's dram_para1 = 0xd2. Boot tested on a Lichee RV Dock
     too, where a D1 with external 512MB DDR3 is detected correctly.

6/10 sunxi: dram: no AC remapping on the co-packaged DRAM parts
     The PHY AC remapping tables compensate for the drive strength of the
     DRAM chips connected to the SoC. This compensation must be skipped
     when the DRAM is integrated on-die.

7/10 sunxi: dram: let the board set the MR1 mode register
     The DRAM mode register 1 value belongs to the DRAM part, and the parts in
     use differ: 0x02 for the DDR2 die co-packaged with the D1s and F133-A,
     against the 0x42 that the boards with external DDR3 have booted with so
     far.

     Expose it next to the other vendor DRAM settings, keeping 0x42 as the
     default so nothing changes for the existing users.

8/10 sunxi: mmc: handle D1 PLL6 clock rate correctly
     Apply the existing MMC clock /2 compensation to SUN20I,
     as already done for SUN8I_R528.

9/10 configs: add the Lichee RV Dock defconfig
     Sipeed Lichee RV Dock: D1, 512 MB DDR3.

10/10 configs: add the MangoPi MQ D1s(F133) defconfig
     MangoPi MQ D1s(F133), 64 MB co-packaged DDR2.


 MAINTAINERS                                   |  10 +
 arch/riscv/Kconfig                            |  14 +
 arch/riscv/cpu/sun20i/Kconfig                 |  17 +
 arch/riscv/cpu/sun20i/Makefile                |   5 +
 arch/riscv/cpu/sun20i/cache.c                 |  88 ++++
 arch/riscv/cpu/sun20i/cpu.c                   |  44 ++
 arch/riscv/cpu/sun20i/dram.c                  |  21 +
 arch/riscv/dts/sun20i-u-boot.dtsi             |  86 ++++
 arch/riscv/include/asm/arch-sun20i/clock.h    |  71 +++
 arch/riscv/include/asm/arch-sun20i/cpu.h      |  22 +
 .../riscv/include/asm/arch-sun20i/thead_csr.h |  29 ++
 board/sun20i/Kconfig                          | 173 ++++++++
 board/sun20i/Makefile                         |   4 +
 board/sun20i/board.c                          | 309 +++++++++++++
 board/sun20i/spl.c                            | 142 ++++++
 configs/lichee_rv_dock_defconfig              |  14 +
 configs/mangopi_mq_d1s_defconfig              |  20 +
 drivers/clk/sunxi/Kconfig                     |   2 +-
 drivers/gpio/Kconfig                          |   2 +-
 drivers/mmc/Kconfig                           |   2 +-
 drivers/mmc/sunxi_mmc.c                       |   3 +-
 drivers/pinctrl/sunxi/Kconfig                 |   2 +-
 drivers/ram/sunxi/Kconfig                     |   8 +-
 drivers/ram/sunxi/dram_sun20i_d1.c            | 417 ++++++++++--------
 drivers/reset/Kconfig                         |   2 +-
 drivers/watchdog/Kconfig                      |   3 +-
 include/configs/sun20i.h                      |  11 +
 scripts/Makefile.xpl                          |   2 +-
 28 files changed, 1329 insertions(+), 194 deletions(-)
 create mode 100644 arch/riscv/cpu/sun20i/Kconfig
 create mode 100644 arch/riscv/cpu/sun20i/Makefile
 create mode 100644 arch/riscv/cpu/sun20i/cache.c
 create mode 100644 arch/riscv/cpu/sun20i/cpu.c
 create mode 100644 arch/riscv/cpu/sun20i/dram.c
 create mode 100644 arch/riscv/dts/sun20i-u-boot.dtsi
 create mode 100644 arch/riscv/include/asm/arch-sun20i/clock.h
 create mode 100644 arch/riscv/include/asm/arch-sun20i/cpu.h
 create mode 100644 arch/riscv/include/asm/arch-sun20i/thead_csr.h
 create mode 100644 board/sun20i/Kconfig
 create mode 100644 board/sun20i/Makefile
 create mode 100644 board/sun20i/board.c
 create mode 100644 board/sun20i/spl.c
 create mode 100644 configs/lichee_rv_dock_defconfig
 create mode 100644 configs/mangopi_mq_d1s_defconfig
 create mode 100644 include/configs/sun20i.h

Cc
--

  Tom Rini <trini@konsulko.com>               (U-Boot maintainer)
  Andre Przywara <andre.przywara@arm.com>     (sunxi custodian)
  Tim Ouyang <tim609@andestech.com>           (RISC-V)
  Leo Liang <leo.liang@sifive.com>            (RISC-V)
  Yao Zi <me@ziyao.cc>                        (RISC-V reviewer)
  Peng Fan <peng.fan@nxp.com>                 (MMC)
  Jaehoon Chung <jh80.chung@samsung.com>      (MMC)
  Lukasz Majewski <lukma@nabladev.com>        (CLOCK)
  Stefan Roese <stefan.roese@mailbox.org>     (WATCHDOG)
  Samuel Holland <samuel@sholland.org>        (original d1-wip author)

-- 
2.51.0

