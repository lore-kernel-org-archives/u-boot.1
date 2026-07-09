Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B93C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 23:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A60B884BFC;
	Fri, 10 Jul 2026 01:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nwWk9nfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9554084B20; Fri, 10 Jul 2026 01:02:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B4A84B20
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 01:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1783638170;
 bh=c++Ih0TNoZOCn7KSnIEHgxbE8//Dc8NCbTvqmjR9NWU=;
 b=nwWk9nfi0fWgyMJD0VISD+wXs3pnhxOhgM74q8MYM6KY4hwGggcFQLyIhN136kbD4Ql1dtF19
 nNue61qhs8cRu9xLDo87GPl7AeBGUpsrj6sscas1ikj2nl1wiisU4JTMM3BKJaFyoL12zEviIl1
 lODVj6CUnYp6935O9wleSWksIdg5jLzGnruT5J6jFQ4CfjZVEu50E/CQyx9zXCIrzswf1ZQjGXF
 ZpHB8dtKxyX+jPDSEW/9jW6Ty7A0Uk9yHulPFYNo3yZw2W+01RTOO+1adMy0AWgyIWbM9eogrJT
 I9OAYFwhANpjZWLxIwAJomDCHSZ+oZm2v3y+5G+VBPvA==
X-Forward-Email-ID: 6a502898145c9a471a72e250
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] mmc: dw_mmc: Allow use of in-spec voltage range for
 vqmmc-supply
Date: Thu,  9 Jul 2026 23:02:38 +0000
Message-ID: <20260709230244.3516247-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
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

The Rockchip RK3399 SoC SDMMC IO domain supports 1.8V and 3.0V mode, so
vqmmc-supply for SD-cards is typically limited to max 3.0V to avoid
damage to the SoC.

The SD Standards allow for an operating voltage range of 1.70V-1.95V and
2.7V-3.6V, meaning the 3.0V mode follows spec.

The commit 0b75109b6aaf ("mmc: dw_mmc: return error for invalid voltage
setting") help enforce strict 1.8V and 3.3V when setting vqmmc-supply
making mmc_set_signal_voltage() possible fail for MMC_SIGNAL_VOLTAGE_330
and can lead to an improper switch to MMC_SIGNAL_VOLTAGE_180.

This series adds a regulator_set_value_clamp() helper set voltage value
within a requested voltage range instead of an exact value, and changes
dw_mmc to use this helper to set a voltage within in-spec range to fix
use of SD-cards with 3.3V signal voltage on Rockchip RK3399 boards using
MMC_IO_VOLTAGE=y.

Changes in v2:
- Add static inline variant to #else block
- Collect r-b tags

Jonas Karlman (4):
  power: regulator: Add helper to set voltage within an acceptable range
  test: dm: regulator: Add regulator_set_value_clamp() tests
  mmc: dw_mmc: Allow use of in-spec voltage range for vqmmc-supply
  mmc: sdhci: Use CONFIG_IS_ENABLED for MMC_IO_VOLTAGE

 arch/sandbox/dts/sandbox_pmic.dtsi         |  6 ++++
 doc/usage/cmd/dm.rst                       |  3 +-
 drivers/mmc/dw_mmc.c                       |  6 ++--
 drivers/mmc/sdhci.c                        |  2 +-
 drivers/power/regulator/regulator-uclass.c | 27 +++++++++++++++
 drivers/power/regulator/sandbox.c          | 11 ++++---
 include/power/regulator.h                  | 18 ++++++++++
 include/power/sandbox_pmic.h               | 15 +++++++--
 test/dm/regulator.c                        | 38 ++++++++++++++++++++++
 9 files changed, 115 insertions(+), 11 deletions(-)

-- 
2.54.0

