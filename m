Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B03DC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 12:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB488774E;
	Thu,  2 Nov 2023 13:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sberdevices.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sberdevices.ru header.i=@sberdevices.ru header.b="ohGnonhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F40587778; Thu,  2 Nov 2023 13:20:36 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37FD1876CA
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 13:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sberdevices.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6390C120033;
 Thu,  2 Nov 2023 15:20:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6390C120033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
 s=mail; t=1698927631;
 bh=8dIka+qHrd1CSkysAkEa7DHk13+QlazzKEnhrY6bODU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ohGnonhPCg+7rHPJQBN3gKFLo+8mS6gzYvx9QjHCwtZeQ9yy+Vm8VkFFZlX/g56XR
 RelQN+l+hOtOwSNZdPaPJmzagfcxiurr6h9r6aVWixWEgDjyWtowbACnPFFs+xTm7P
 X/7or6L05xOVtSBs7TbY05irXAF6Mma2rSOoLAkKZsEMOC4cE0Jucn86jQMNdMSCXz
 nAlG4ydkbA4txT5NFNvjS4gnGFV+Sh2wDhs3PBVbno5bB8Y3XlEPv1UQ5QMlboymDh
 D9uc+tiQylTi6vGveuxqOwhjCjrOLpOOM9JQe/Zhd4HIba9yz+tmGF265XMZFoPVqy
 qKg4LCaeNkI0A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  2 Nov 2023 15:20:31 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 2 Nov 2023 15:20:30 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: Michal Simek <michal.simek@amd.com>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei
 Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, 
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 0/8] clk: Switch from soc_clk_dump to clk_ops function
Date: Thu, 2 Nov 2023 15:20:09 +0300
Message-ID: <20231102122017.56995-1-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181076 [Nov 02 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from},
 {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch},
 {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/02 06:57:00 #22385341
X-KSMG-AntiVirus-Status: Clean, skipped
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

Currently clock providers may override default implementation of
soc_clk_dump function to replace clk dump command output. This causes
confusing behaviour when u-boot is built with one of such drivers
enabled but still has clocks defined using CCF. For example, enabling
CMD_CLK and using clk dump on sandbox target will not show CCF clocks
because k210 driver overrides common soc_clk_dump.

Changelog:
 v1 -> v2:
 - Add missing static to dump functions

 v2 -> v3:
 - Make soc_clk_dump in cmd/clk.c static instead of removing __weak

 v3 -> v4:
 - Rebase and refactor dump for new Amlogic A1 clock controller driver

 v4 -> v5:
 - Add docs for dump() function in clk_ops
 - Print driver and device names before calling corresponding dump()

Igor Prusov (8):
  clk: zynq: Move soc_clk_dump to Zynq clock driver
  clk: ast2600: Move soc_clk_dump function
  clk: k210: Move soc_clk_dump function
  clk: amlogic: Move driver and ops structs
  clk: Add dump operation to clk_ops
  cmd: clk: Use dump function from clk_ops
  clk: treewide: switch to clock dump from clk_ops
  cmd: clk: Make soc_clk_dump static

 arch/arm/mach-zynq/clk.c               |  57 --------------
 arch/mips/mach-pic32/cpu.c             |  23 ------
 cmd/clk.c                              |  13 +++-
 drivers/clk/aspeed/clk_ast2600.c       |  83 ++++++++++----------
 drivers/clk/clk_k210.c                 | 103 ++++++++++++-------------
 drivers/clk/clk_pic32.c                |  39 ++++++++++
 drivers/clk/clk_versal.c               |   7 +-
 drivers/clk/clk_zynq.c                 |  51 ++++++++++++
 drivers/clk/clk_zynqmp.c               |  13 ++--
 drivers/clk/imx/clk-imx8.c             |  11 +--
 drivers/clk/meson/a1.c                 |  54 +++++--------
 drivers/clk/mvebu/armada-37xx-periph.c |   5 +-
 drivers/clk/stm32/clk-stm32mp1.c       |  29 ++-----
 include/clk-uclass.h                   |  15 ++++
 include/clk.h                          |   2 -
 15 files changed, 256 insertions(+), 249 deletions(-)

-- 
2.34.1

