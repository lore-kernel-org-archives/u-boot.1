Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44B6F3D32A
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F9B83F75;
	Thu,  5 Mar 2026 18:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="L9Q11C7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AB283F7F; Thu,  5 Mar 2026 18:01:19 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7057F839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 18:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1772730064;
 bh=ngnpQ3xpycVvnl3RJYC3n4vfqAMbcZwY45s5AtqLzoY=;
 h=From:To:Cc:Subject:Date:From;
 b=L9Q11C7KT0ZvC/paQ0NOazpjPYq0w+FrjgU189EjbENftCNZVsxdgla7RKNHHRvM1
 t2br7cLWbO0lwhVqi1dw5mQqnUhbJwDf5OSH5pwL7bn/Iu5xctGp3wVbwCGGC6cHIv
 LVHqIW8j9HbsNQLaqifn24fePK9AE6N+ic4QQH2m0fHPJ81ttFd+59sXJP9tQm/AKq
 zk2P4JU1m//R1S9QuAEn8+0mIi11lcI7FJj6vqyf/AFaG24RTXih3CVLZhX+LyS4LG
 kZu+c8GYMuRigtQlcKD/zb4hhddVqArc00SqunYO1q/OqvGt5O/d6ONVcNr5YwMGju
 KInFaXfPByV+A==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 217BBB22024E;
 Thu,  5 Mar 2026 18:01:02 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [RESEND PATCH v4 0/3] Add upstream board Xunlong Orange Pi RV
Date: Thu,  5 Mar 2026 09:00:19 -0800
Message-ID: <20260305170043.33994-1-e@freeshell.de>
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

Xunlong Orange Pi RV patches are now in the Linux v6.19 release, so let's
introduce support for this board.

Note: The content of EEPROM is known to not be unique on this board, and
an (optional) invented "XOPIRV" identifier is implemented with this
series. Without, there are reports that the board is detected in U-Boot as
StarFive VisionFive 2 1.3b, and is then functional enough to load the
devicetree prior to booting Linux.

RESEND v4: has collected tags that were missing from v4 as sent to list

Changes since v3:
- Collect tags (no code changes) [n.b. this failed, see RESEND v4 instead]
- Cherry-picked dts subtree patches dropped as redundant:
  Drop patch 1/5 "dt-bindings: riscv: starfive: add xunlong,orangepi-rv"
  Drop patch 2/5 "riscv: dts: starfive: add Orange Pi RV"

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

 board/starfive/visionfive2/spl.c              |  3 ++
 .../visionfive2/starfive_visionfive2.c        |  2 ++
 configs/starfive_visionfive2_defconfig        |  2 +-
 doc/board/starfive/index.rst                  |  1 +
 doc/board/starfive/orangepi_rv.rst            | 35 +++++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/starfive/orangepi_rv.rst


base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
-- 
2.50.0

