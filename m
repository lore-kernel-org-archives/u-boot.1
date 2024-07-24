Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F8EC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92F3E88847;
	Wed, 24 Jul 2024 08:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="e+rxFUpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADA188881; Wed, 24 Jul 2024 08:58:33 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D074A88829
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=SRS0=3f2b=OY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1721804304;
 bh=VLGZgadPratNQutp/fr/e1wMUxOAGJO/2H/9ZAh0sGE=;
 b=e+rxFUpdaeaC26kDiMlYB8Ct06ITw2OP0g6nrdRUTG7ROy6RQA18vfEyVQ/4UImp4xPGitAi3
 Urkv39JXUHFxYHFjqG2vR7AtTR1IlzypPQR4lTSM+3nesnFBCqO60mfwKI+CAdc5Qp2ZJ6Pe9Pm
 X0/n8EDZE0EQX/DojAJFAMjb6h5tK1EkjiWNBj05j3UPG9Ob5nL7k8Z1ot+KnWqPiEBtEXZxdlO
 DI6qdbPb9ZhTwQ/O/1NH6J3xONKSX9YKoaQGPAjlZoKb87IQzQWHzmA4FIsFNKs4q+OPwcOQJEk
 2Gug+tooq2iM3u39b1dl/u81iTBvXTRMxemWPAiYSZyQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] rockchip: io-domain: Add support for RK3308
Date: Wed, 24 Jul 2024 06:58:15 +0000
Message-ID: <20240724065817.2736062-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a0a60e78718bd2bf1d3d38
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

Port the RK3308 part of the Rockchip IO Domain driver from linux.

This differs from linux version in that vccio3 iodomain bit is enabled
in the write ops instead of in an init ops as in linux, this way we can
avoid keeping a full state of all supply that have been configured.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3308/syscon_rk3308.c |  3 ++
 drivers/misc/rockchip-io-domain.c             | 37 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c b/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
index 2d7e97110152..e77189eef6cf 100644
--- a/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
@@ -16,4 +16,7 @@ U_BOOT_DRIVER(syscon_rk3308) = {
 	.name = "rk3308_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3308_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 };
diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
index cf4f7c3984c7..025b6049a9f7 100644
--- a/drivers/misc/rockchip-io-domain.c
+++ b/drivers/misc/rockchip-io-domain.c
@@ -31,6 +31,10 @@
 #define PX30_IO_VSEL_VCCIO6_SRC		BIT(0)
 #define PX30_IO_VSEL_VCCIO6_SUPPLY_NUM	1
 
+#define RK3308_SOC_CON0			0x300
+#define RK3308_SOC_CON0_VCCIO3		BIT(8)
+#define RK3308_SOC_VCCIO3_SUPPLY_NUM	3
+
 #define RK3328_SOC_CON4			0x410
 #define RK3328_SOC_CON4_VCCIO2		BIT(7)
 #define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
@@ -119,6 +123,22 @@ static int px30_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
 	return ret;
 }
 
+static int rk3308_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
+{
+	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
+
+	if (!ret && idx == RK3308_SOC_VCCIO3_SUPPLY_NUM) {
+		/*
+		 * set vccio3 iodomain to also use this framework
+		 * instead of a special gpio.
+		 */
+		u32 val = RK3308_SOC_CON0_VCCIO3 | (RK3308_SOC_CON0_VCCIO3 << 16);
+		ret = regmap_write(grf, RK3308_SOC_CON0, val);
+	}
+
+	return ret;
+}
+
 static int rk3328_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
 {
 	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
@@ -189,6 +209,19 @@ static const struct rockchip_iodomain_soc_data soc_data_px30_pmu = {
 	.write = rockchip_iodomain_write,
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rk3308 = {
+	.grf_offset = 0x300,
+	.supply_names = {
+		"vccio0-supply",
+		"vccio1-supply",
+		"vccio2-supply",
+		"vccio3-supply",
+		"vccio4-supply",
+		"vccio5-supply",
+	},
+	.write = rk3308_iodomain_write,
+};
+
 static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
 	.grf_offset = 0x410,
 	.supply_names = {
@@ -256,6 +289,10 @@ static const struct udevice_id rockchip_iodomain_ids[] = {
 		.compatible = "rockchip,px30-pmu-io-voltage-domain",
 		.data = (ulong)&soc_data_px30_pmu,
 	},
+	{
+		.compatible = "rockchip,rk3308-io-voltage-domain",
+		.data = (ulong)&soc_data_rk3308,
+	},
 	{
 		.compatible = "rockchip,rk3328-io-voltage-domain",
 		.data = (ulong)&soc_data_rk3328,
-- 
2.45.2

