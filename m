Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BD1C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 22:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D049682C4D;
	Sat, 14 Jun 2025 00:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BRshu/R7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2100D82D2E; Sat, 14 Jun 2025 00:43:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A656D82B70
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 00:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f90d=Y5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1749854633;
 bh=37aSyhHy7Tsrjve48vbnMnERdxQQv360zMBWmpdBzQk=;
 b=BRshu/R7DuTFrJcsGqsofOPkCijRwiFMmsind/jOo0RsSqm75tNXXhWQZZAIwFgScAZ8UrtYj
 aD3vj/tKfneRhuWYnbG3e91Fr0xzLjGRf2JJD4vs3UzM1tEgh4AISQ9yawZJAPAjTH39WHwYiBS
 lMp/rhPHRwaUL3qShh0X9QAivtlmgNfi5TlYDi9tQEI1w16fmWUDX/sIx1bXW89c/WAlnPCUy6g
 NebGMFtgA0uYUlDVyJnHQOEh3jQWlEcMSHW2YehGdTWxKlNZKt3iBUxumfDgvim1dHqBqsVMFqB
 X6HU0EufxOQ5HcU8PhEIUqXINlZisknb3VvEnE9Y82zQ==
X-Forward-Email-ID: 684ca9a53a79291f7f4464b9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
Subject: [PATCH] arm: dts: rockchip: Fix eMMC write on RK3528
Date: Fri, 13 Jun 2025 22:43:40 +0000
Message-ID: <20250613224343.3521820-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

Writing to eMMC on RK3528 is affected with the same or a similar issue
as on RK3588, where eMMC must init to HS200 at least once to fully work.

Trying to write u-boot-rockchip.bin to eMMC fails with:

  => mmc write $fileaddr 40 5000
  MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
  0 blocks written: ERROR

For U-Boot to enable HS200 mode the mmc-hs200-1_8v prop must be defined
in the device tree. Linux does not seem to be affected and is able to
detect and use HS200 without this prop.

Enable use of HS200 and fix eMMC write on RK3528 by adding the missing
mmc-hs200-1_8v prop for affected boards:

  => mmc write $fileaddr 40 5000
  MMC write: dev # 0, block # 64, count 20480 ... 20480 blocks written: OK

Fixes: b112a44531cb ("board: rockchip: Add minimal generic RK3528 board")
Fixes: ccbddf645310 ("board: rockchip: Add Radxa E20C")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Kever, Tom: Please consider this for the v2025.07 release as support for
RK3528 was added in v2025.07-rc1.
---
 arch/arm/dts/rk3528-generic.dts            | 1 +
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
index 792d3e04a4cb..3f6f0bed108d 100644
--- a/arch/arm/dts/rk3528-generic.dts
+++ b/arch/arm/dts/rk3528-generic.dts
@@ -18,6 +18,7 @@
 &sdhci {
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
 	no-sd;
 	no-sdio;
 	non-removable;
diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
index 9c2f03a786cf..1372d8f1e38a 100644
--- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
@@ -2,6 +2,10 @@
 
 #include "rk3528-u-boot.dtsi"
 
+&sdhci {
+	mmc-hs200-1_8v;
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.49.0

