Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE866D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3E9891E3;
	Tue,  5 Nov 2024 17:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZGnnKWzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18145891E0; Tue,  5 Nov 2024 17:01:33 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C1D891E3
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822480; bh=2/vo3C9yPQPsY7QBOf42eMizsXQ9HSOzAJEupnrrV10=;
 b=ZGnnKWzl4odmS3OIj/mvy/zU8D7yPiSc5rWHryB9wr+pIS4SXOs5XcYEJh5j8dNbRCCNd1y1+
 2ILldGTGOie2/1BumaElx0Y8XMXeJAPaY/eNY3C54l9eBTPQ2EZNiavtxmq5m2EY21RzlsgZI+W
 dlx5Sww48l4nND41K6xqi0Pc9FLaq1rH/ZjXSS/DTQlX2L8vO41lfsDUk3wukr9QNxpRfB1hN74
 RW27DuY7YiqAM5/SCUgpQXzaV4uJu25tnS9Tp7g3d2deCB5K3Y8GrGIPU6gm07RIhhz70a38KHO
 2XDEc2Xlrkb4QYSRdiSYes9VZWquLq7pJ9owULT1UTqQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 05/13] rockchip: rk3288-tinker: Include mmc nodes in pre-reloc
 for env load
Date: Tue,  5 Nov 2024 16:00:28 +0000
Message-ID: <20241105160054.1373319-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a414fff3e144e4725e0ea
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

Include mmc related nodes in U-Boot proper pre-reloc phase to ensure
environment can be loaded from mmc devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-tinker-s-u-boot.dtsi | 5 +++++
 arch/arm/dts/rk3288-tinker-u-boot.dtsi   | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
index a782f2f9804a..614d47ce1801 100644
--- a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
@@ -15,20 +15,25 @@
 
 &emmc {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_bus8 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_cmd {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_pwr {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
index 4f230739f1c3..7568b1495341 100644
--- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
@@ -33,6 +33,7 @@
 
 &pcfg_pull_none_drv_8ma {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pcfg_pull_up {
@@ -41,26 +42,32 @@
 
 &pcfg_pull_up_drv_8ma {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_bus4 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_cd {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_cmd {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &uart2 {
-- 
2.46.2

