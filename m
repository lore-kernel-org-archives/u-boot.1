Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19025C677C4
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 22:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A78382B07;
	Wed, 11 Jun 2025 00:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BbDO54Zm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w2oGN7ix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F3F82B18; Wed, 11 Jun 2025 00:04:46 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6198482AE9
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 00:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bH2rr1DFwz9spj;
 Wed, 11 Jun 2025 00:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749593084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7k4yI6lCmnXztGgsQC0OnZEBzI7p0yzZT7Sxctgh3Rc=;
 b=BbDO54Zm+Kjt2yAEK/j70/jYlo4S9jNRaRg/O1uRdBihMk/k1Gsw6sTb0z0jZtSucLGoLb
 86HYTUU4K7G03qI4WKPBVeGk9nyhUEjVHLisQz3MdIyOspIKMPmVr3mha6dAiKZpUrUvIc
 bNMM/BOcU3mQTnpn1e+3blNAtwriOEfceUM807JPwX75DL3jAxRIDzmYuOhKR/iGH0S3L2
 iKJUoGQkV8plJFgF+AxH6Y27FVx2ib+SieqmH4nDWztavvVV1xjSo73MJPY4fZJwhEbni4
 FLJDsTNdcl7C5pHkoEXp+Op5wcMlY3SEMrSyI8/A8SUPmAvUqxG2rARn6zo+WA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749593082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7k4yI6lCmnXztGgsQC0OnZEBzI7p0yzZT7Sxctgh3Rc=;
 b=w2oGN7ix74StjL9JQsfwTyJgH41O/k/5+t52jGqFaDRftYDmt3eEotY3nr6K/dw/10OlwI
 GVUuQwY66Yc2vYK9rCGZtvOQ7vJoDrePH7qLpk6UihkO1wHtz88wkcm2v0jEmqTLUDw9hu
 z/5X21ES26PCltPtgh13kGf0MVfFNcdQleEyMgXjN6GkCAhLiELKI/OghqBER7Xz2AhXdW
 c/0RZimqRvBYjKCCaIz8gIIG4mflmIJnYTD/FPK5DgfGTXgUQAYtUUEHfurvur8LI84Ki3
 zRmbs0yuW9yi4ZgqSiZgbump7z+1WY8zNbZ0DBiCukZVrR+f2tdb/po+lvOsaA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Wed, 11 Jun 2025 00:02:52 +0200
Message-ID: <20250610220432.166527-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e7dc7bca629821c4644
X-MBO-RS-META: aztkw6nm6maarr43rqashcg16p9u3381
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

One more board to support, this time Retronix Sparrow Hawk
based on Renesas R-Car V4H SoC . This is board support, so
master branch should be fine. The DT in dts/upstream/ is a
backport from Linux, and will disappear on next DT sync.

The following changes since commit d7c449c3d83a986d61e38d1762433c0607caf5c5:

  Prepare v2025.07-rc4 (2025-06-09 15:54:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 55c4a6db549cdad3f185e33f439d130cec7a6bc8:

  arm64: dts: renesas: r8a779g3: Add Retronix R-Car V4H Sparrow Hawk board support (2025-06-10 20:50:50 +0200)

----------------------------------------------------------------
Marek Vasut (2):
      arm64: renesas: Introduce renesas_dram_init_banksize()
      arm64: dts: renesas: r8a779g3: Add Retronix R-Car V4H Sparrow Hawk board support

 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi     |  50 ++
 arch/arm/mach-renesas/Kconfig.rcar4                |   7 +
 board/renesas/common/rcar64-common.c               |   4 +
 board/renesas/sparrowhawk/Kconfig                  |  15 +
 board/renesas/sparrowhawk/MAINTAINERS              |   7 +
 board/renesas/sparrowhawk/Makefile                 |   9 +
 board/renesas/sparrowhawk/sparrowhawk.c            | 143 +++++
 configs/r8a779g3_sparrowhawk_defconfig             |  69 +++
 doc/board/renesas/renesas.rst                      |   6 +
 .../src/arm64/renesas/r8a779g3-sparrow-hawk.dts    | 666 +++++++++++++++++++++
 include/configs/sparrowhawk.h                      |  14 +
 11 files changed, 990 insertions(+)
 create mode 100644 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
 create mode 100644 board/renesas/sparrowhawk/Kconfig
 create mode 100644 board/renesas/sparrowhawk/MAINTAINERS
 create mode 100644 board/renesas/sparrowhawk/Makefile
 create mode 100644 board/renesas/sparrowhawk/sparrowhawk.c
 create mode 100644 configs/r8a779g3_sparrowhawk_defconfig
 create mode 100644 dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
 create mode 100644 include/configs/sparrowhawk.h
