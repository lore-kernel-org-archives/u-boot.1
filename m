Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F3FCA100F
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 19:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D84834D4;
	Mon, 22 Sep 2025 21:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 004B883443; Mon, 22 Sep 2025 21:21:06 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEAE83423
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 21:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
X-QQ-mid: zesmtpsz5t1758568825tb397f317
X-QQ-Originating-IP: w9++T59L9WrXuvrqXC5wAwTSxqPA0yzIfHhs5sg++8Q=
Received: from debian.. ( [218.1.219.45]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Sep 2025 03:20:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2756362489016207141
EX-QQ-RecipientCnt: 12
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 weijie.gao@mediatek.com
Subject: [PATCH 0/4] net: phy: aquantia: Switch to generic firmware loader
Date: Tue, 23 Sep 2025 03:20:07 +0800
Message-ID: <FC37593FA94A297B+20250922192021.268592-1-root@infi.wang>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:infi.wang:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MMWFPVmLnCWqnRRq9B1kmTWPc98AhI4Seos3uUbJpzg/iN+mnbDEPJkR
 ZjHv/4iZGLreC/57uoKRvZ8ad85WM8SrKbtq/cPzlCnmSnTRLWgvpbP95osiYKWLjgP/gbe
 rnSqN5chTX4xQuVVUjEhtgOjSnMgqONWI0FBrbCqmSRuLg9pdhs7Pw2QGqQ4PJBCFJLF4P2
 rp1x3YsBXsUmcDPQcjLSYyZKogA5ytZ8tCzs5HyX2sLMcSlHwgeHx8UI+6fF0J5d/MtAVv/
 LbhLKFuOMHn9nhElJeIBur/giJUVSfHFUQ6EvxHu8lkYI1i7MIjc5M8DtSiz+C5H4qfhuM+
 Iqx8lRd4J8Jxe+OS3yZWUf10ideEi0RBCAJI/PPS9dW2l301YEFx9aa5bPtcOdo5YYyRynq
 611/96J2cPDBUklEN+wAxEfrlP7UvHXGXmKDsIYyHQtQaeSH7lPOivWU+X6Ykl6gQCJlKQL
 8xJx8Daq3lrfYp6u0rAlFJf++iX1NGAlkf4OTVMg2mI9QbKJ0LepBOhLJnMub4UYhAfcHgJ
 zpgrYU53986HEPSN/133uMKNFlw/dCP5GNeEIIRwYJ4Z9LsEvzhzDhhETOL7EQFoVSR8GPN
 9hqa9SsVBMK9ZHrvjA/5GOSvhSBlGHPsN969g2L11xJ41lWEDe9DaU6u0mxdE+ducKMoeq2
 JNzv/HQrsojphnONN14QyD8f1wDaZs63k9yPCN48cAL4BXjQf8ihW/LeF0cbFiFbWPjrETT
 NUbJKdcHzj8Wr08Y5hbh7yPxyRaUoJrtoTVnsRfy1/BFd9YH7JXicip9Y3IAjdJ4tJLZv6E
 F8fF2sPLmUGm1D5Ns399RKx0O4/eD0RmcsG2kELCknb5Lgh2vMiHJt9mp4giwhs1VhP8aES
 IkGI6zt0X1JGPk+FC7voKcljBIDvLX2dCF7c3PdVQwWYVfi7eEvZ0JKgDLpWPZfcv736iTx
 ZThGSsx5AGxb+zx4pZvuCy4MqflwK262vI/Yv5yNxTFJnqHV8tbeAHwOMv3YrgqfSIYa1IK
 MCax1JhPBZ81lqzrn0kVybLgFKcQI=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 22 Sep 2025 21:42:39 +0200
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


Hi,

This patch series refactors the Aquantia PHY firmware loader to use
the generic fsloader framework.

The existing loader is limited to loading firmware from an MMC device,
which restricts its use on many devices (e.g., routers) that may use
other storage like USB or have a UBIFS root filesystem. Migrating to the
generic firmware loader allows firmware to be sourced from any backend
supported by the fsloader framework.

The series is structured as follows:
- The first patch is a minor cleanup, switching to the phy_get_ofnode()
  helper.
- The second patch fixes a small typo in the binding document.
- The third and main patch replaces the custom loader with generic one.
- The final patch updates the device tree binding documentation to
  introduce the firmware-name property and provide usage examples.

This change has been tested on a Buffalo WXR18000BE10P router, loading
firmware from a UBIFS volume for Marvell CUX3410.


Beiyan Yun (4):
  net: phy: aquantia: switch to use phy_get_ofnode()
  doc: bindings: fix aquantia-phy.txt typo
  net: phy: aquantia: use generic firmware loader
  doc: bindings: add Aquantia PHY node's "firmware-name" binding

 doc/device-tree-bindings/net/aquantia-phy.txt |  32 ++++-
 drivers/net/phy/Kconfig                       |  19 ++-
 drivers/net/phy/aquantia.c                    | 124 +++++++++---------
 3 files changed, 103 insertions(+), 72 deletions(-)

-- 
2.47.3

base-commit: d33b21b7e261691e8d6613a24cc9b0ececba3b01
branch: aquantia-fsloader
