Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03057EEB58B
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 12:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD47E86997;
	Sat,  9 Sep 2023 14:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t5/Macdc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X3u+pxFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8D8869A4; Sat,  9 Sep 2023 14:15:35 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C043D86433
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 14:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RjX4N3RqBz9sqL;
 Sat,  9 Sep 2023 14:15:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694261732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KyNEdLN0toPH2jSYYnE8KL1d1c0q5Pj2Rg6kb7ki/FQ=;
 b=t5/Macdc/H4XvVE08e4gYVRn4o+xvFsG9sk/MxCr36FdyFOVBXzHCpxrnLAWD9kCilRjgs
 TppOOArwJNkbvvN9hJiu1c2hQNzmuKiyTshB0xpYXgTx8XLjp4Jjj8biUz5b2ZzsKf5UiF
 5FAtS+qUPDSDjv3txYTV2BQbq5IV/OsLBtws8E8YVKv97aoSEkSIvk0pXjjFKRc4uVDvLJ
 eDMTOgJUOlYZzvIeQSD2F+aLjLqyHuq6BWjCZYmyNCMsKP4VToIYI1bxlf+BM2K6u377At
 4UVQ/ihukidKMbw+npi/QZCRcpdRf16hal3RYBeghcLPtTxHKe3ho9l44ln2SA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694261729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KyNEdLN0toPH2jSYYnE8KL1d1c0q5Pj2Rg6kb7ki/FQ=;
 b=X3u+pxFhKsWMnT66ukWCxnxNbRhcYzDPFfdcsnk+rjpuaFt60C2Tquo45dWv3/LLYbYrRR
 nDTgZyahAGQNYIr1kZUGKes3jtfQfcCOJxfHhT32QUMUmqc7k1Lf1u/NyGrtwTPY33EWef
 /OdeZvMT9UrIOoBfzF1ouVe2g4Hw2KJysGT3jk6+CYxbF6JTmCwbcv9AGBicr8Nu33/0oQ
 sQFQWmNYELSDZ4MTJYyNqiQ+FXON4nOikPjGxDhEbBdyWCbI2XlY4ezkIQVv2vPTmh0Zf0
 GN7AO2F8rkbCeZG/PM8i6nC+1/n194jUi6Orc49xoBHv356P6evWC4OmKDDoEw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next_ufs
Date: Sat,  9 Sep 2023 14:14:59 +0200
Message-Id: <20230909121459.5143-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0dd746f30019f00d589
X-MBO-RS-META: he79tqswkbn3dxb67gdtmq3pjankwrfc
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

The following changes since commit 515e0af77b25fba24ef6a3c72afee6ae3c739825:

  Merge branch '2023-09-06-assorted-CI-updates' into next (2023-09-06 18:47:18 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next_ufs

for you to fetch changes up to fad9d9b70113bda05b5339d0193adc4edd3ca0e9:

  ufs: ufs-renesas: Drop include common.h (2023-09-09 04:56:50 +0200)

----------------------------------------------------------------
Marek Vasut (4):
      clk: Add GPIO-controlled clock gate driver
      ufs: ufs-renesas: Add support for Renesas R-Car UFS controller
      ARM: renesas: Enable UFS on R8A779F0 S4 Spider
      ufs: ufs-renesas: Drop include common.h

 configs/r8a779f0_spider_defconfig |  11 +
 drivers/clk/Kconfig               |  13 ++
 drivers/clk/Makefile              |   1 +
 drivers/clk/clk-gpio.c            |  66 ++++++
 drivers/ufs/Kconfig               |   9 +
 drivers/ufs/Makefile              |   1 +
 drivers/ufs/ufs-renesas.c         | 412 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 513 insertions(+)
 create mode 100644 drivers/clk/clk-gpio.c
 create mode 100644 drivers/ufs/ufs-renesas.c
