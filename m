Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4438DCCF2DD
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F3983AB8;
	Tue, 20 Jan 2026 16:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="ZxJT4pkY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0243283AEE; Tue, 20 Jan 2026 16:55:15 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED09183A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768924466;
 bh=4liMj9hM7ZRWGZz53MsMxwCHfKg96sr0mqMnSV1jSYg=;
 h=From:To:Cc:Subject:Date:From;
 b=ZxJT4pkY2fEUZBIz2awRB39wopG381zasWE5ijkPMJIlSsjWvcyMKiXT5tOn1854U
 exm2ohK3pkxM9oqi8TIFKGwtkfcMjyXPcBzCJknNuo7wdyS5i9lNjNC8N4EkFrp4lx
 Dj9WkC+MzR3+NLfU4jZRY43sKEPuq7LSb70PK6uk5xjlww+HzAb3zeWbiInSapbIgY
 5gSA0U0ArWVj2hWjCB/I6g2LpoJE0s00dUPyh5Pltk9xPd5+Yj8IPh5vEs41CMHwXc
 v5zhrNjH9e7i8Tn+jlG1U5qGwaZPrrVWhtrneArDJeeUT2MqmSctuBH3U0CI/Wjq+g
 qqTfXBzZI1NwQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 01711B22042C;
 Tue, 20 Jan 2026 16:54:24 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v3 0/5] Add upstream board Xunlong Orange Pi RV
Date: Tue, 20 Jan 2026 07:53:33 -0800
Message-ID: <20260120155406.34916-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Xunlong Orange Pi RV patches are now in the Linux v6.19 release candidate,
so let's introduce support for this board.

Note: The content of EEPROM is known to not be unique on this board, and
an (optional) invented "XOPIRV" identifier is implemented with this
series. Without, there are reports that the board is detected in U-Boot as
StarFive VisionFive 2 1.3b, and is then functional enough to load the
devicetree prior to booting Linux.

Changes since v2:
- Collect tags (no code changes)
- Adjust missing S-o-by tag to first of tags list order for patch 4
  "configs: starfive: Add Orange Pi RV to visionfive2".

Changes since RFC v1:
- Cherrypick from devicetree-rebasing instead of importing upstream dts
  as -u-boot.dtsi overrides.
- Add basic documentation
- Mention invented "XOPIRV" identifier in commit messages
- Rebase on origin/next

E Shattow (3):
  board: starfive: visionfive2: Add Orange Pi RV selection by product_id
  configs: starfive: Add Orange Pi RV to visionfive2
  doc: board: starfive: Add Xunlong OrangePi RV

Icenowy Zheng (2):
  dt-bindings: riscv: starfive: add xunlong,orangepi-rv
  riscv: dts: starfive: add Orange Pi RV

 board/starfive/visionfive2/spl.c              |  3 +
 .../visionfive2/starfive_visionfive2.c        |  2 +
 configs/starfive_visionfive2_defconfig        |  2 +-
 doc/board/starfive/index.rst                  |  1 +
 doc/board/starfive/orangepi_rv.rst            | 35 +++++++++
 dts/upstream/Bindings/riscv/starfive.yaml     |  1 +
 .../src/riscv/starfive/jh7110-orangepi-rv.dts | 76 +++++++++++++++++++
 7 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/starfive/orangepi_rv.rst
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts


base-commit: 55ca2110d74f8e5a594aecc11ce4103dc73e9e02
-- 
2.50.0

