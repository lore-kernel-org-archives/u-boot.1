Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EB1CD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 13:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEAA287EDC;
	Sun,  7 Apr 2024 15:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Io1NZ4FX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC2A87E3D; Sun,  7 Apr 2024 10:57:20 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E9888047
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 10:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea3uxwP66HxIUfg0qy3tQ5wfqpxpjfuIzjEACCQ3wzUsgE6qefZKEuuAekNzy7JoFCS2pAs7VULiMi8L8Xl5S1KQzuBYcp/S61vnILzo9Nl1rLGMO3+LKhQwaiaDj6UI88RKam40Nus2IJ84m7xgF7kYvJ0xDMNFEX0K6oLiO3TDRjo1euaSvRn88iTl4fevlGHG7CDNplqIKcBCq4oXC7SnwOae7CGSxB3EcvOuV9mWcyAEggO1jpl/YIkK5vEapFv65ampc17aBrDkf5ud3e3bF58AVpn/DFj1ekWaNF2GJ5DvmhC1xUMuH+wcQJjSPZZf1wd1xdLj6LxJRwwTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYSKb/YwOkR2fkcT1ZXp5jPWEDUx0RXmXzkdnTZ38ec=;
 b=iVYVmjOOveBzHceF9SI4S3BRtoNc5nx7zx9lS+wTsyM+RmgXMU7ONphWxrwgYrAkATJxqjmB/V33fkV0+qEiFeNNx1rbnJ13S5MWNzfrJpsqxSNmY/Mle5isPOFQwF/cShmJiK0a+02zGLQE133TFUa7Bc19S0bI+TONuPGQV5wW4sIzoL2HOE/un8wmXsOrylUlDHMkLqpMXZvopzJX0hmpR8RRc04CzRjWh31QRROq/3uWqvYciaVVm67JVWYo786WWbF9ARiTKoujdGhj57z5UXvhvATH8DooHUPcjXKZzVYvvpVKblxxdmwW6rxrcok7KpNbJJmh6mew7EmxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYSKb/YwOkR2fkcT1ZXp5jPWEDUx0RXmXzkdnTZ38ec=;
 b=Io1NZ4FXTXP2nPB/Nm3k4hwgHZLih0JgIjRn5KYTS/kfE5l2oC0Vo9Q+dJDHcSZECdBvV4rdHbWyNE37qyftyUd5Yy2skNk+2n/Eu9QAiQibtdzbreinlNAm7ZcRVhFATkgBckpn7K6CE1lz+KLrstFe8TiZTanQj4Q4/tqPmqc=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU2PR04MB9177.eurprd04.prod.outlook.com (2603:10a6:10:2f4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 08:57:17 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 08:57:17 +0000
From: Joy Zou <joy.zou@nxp.com>
To: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de,
 festevam@gmail.com, sjg@chromium.org, saproj@gmail.com,
 judge.packham@gmail.com
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH v4 1/3] drivers: rtc: add pcf2131 rtc driver
Date: Sun,  7 Apr 2024 17:05:01 +0800
Message-Id: <20240407090503.2312483-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240407090503.2312483-1-joy.zou@nxp.com>
References: <20240407090503.2312483-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU2PR04MB9177:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRikOP/zwL+URZPj13YenoQdYExFcKtKm828MgafZxB6tTJ3Ipk6H2KTFJyhVVP0iZDtI3jnPjJs1oGQ8/Cf+MaCPa2ZAGhDijfYCPeILnsXiT0VFDreNvlh3K9Yi5DEiuw7/sO/jBjEhQLmLfg1C3NIzjDK8brf2KRUKyFq9BKtZwROih96Ygkxneo+LP58fL9LmsF/ETd3dSGXkOqJ70+e0n9aga/DhvkOBGRZCny6+1+ac6Z9hpZngqqZ7oM++jgmV+dyOlGW/xHQCdHGRx9b8J+gub41OadVt7PKNZD9I3tpGiOaEdjhi+qOqLBlZ7jmralbiC16XgsEuD/O11UCUxRLUUx+MelZTxgSbYc3wHRayhEmdHFz3UIJ/1V8mp5ITrS0hL20nwNGtq5e5z93n7OYQ3qIGqK+l9MM4TzZtJevmncLmWhYygcFEQK2IXU2wXtYNcyUEM/UtctKmsIJd08b5MEH86D02ambYhspeoPJipZYfg3ajui6KKHoMZB8aLV6D3yEn3dHL7izuZ7oC5T4SLwB+hkldUxCBinsIjRCCzyWIQn+VyOp7HXzGo/lMwbk0AoxUSVGbUagrzfothrBtt3WdvNy6SlhtSHse5tBj282tyi52XbzfWRBAnPYmN2mN/i4Tsyu6hnFwTN2FtKAvdDajPGOh06fzo+3ydIo8v5vLfdQQY/J16SW1ZhlGE2F/iRuBUTsjDaF5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mR3lF14fwZWRUFpp4IQUeejPrXhVQvf4rggiH7VhCWPnEJDgqUDGxlZELSQ?=
 =?us-ascii?Q?fknmeXRpSk1iJO51G87y7OKmMU68zP5Cgg9Q6R2imKkJxUNREFK5MvmRkbAT?=
 =?us-ascii?Q?Oi5A1k+cwkYDLhd4hAZP1rPs6c9WLaFe5TVXAxJXD/KbPcfBfuEK3/ghBEWB?=
 =?us-ascii?Q?ZTDodvwWP/JRFJOC0qUpKiLiQi6ePKeSflJPIeCRm6W1njKOtg5ehNG0US3p?=
 =?us-ascii?Q?ouOugr4T0QndhlEnb8BsDFKR24WouBipH860codvq8KxGmqTomnyrHh4oCaA?=
 =?us-ascii?Q?Wx9n2jea25n1ZLhFYI/lsXWqjRn4sFd1Y8Ny04xj+s7umNbuhxAfLFUKfJgE?=
 =?us-ascii?Q?tGpG0mBkBxJP0mvZRbB7VwHHtLfrS1xEyW9dk8N5LbrHRmupB1TJTZpFIOAV?=
 =?us-ascii?Q?eq03FvNLwzK5s/1yr51PwBpskr2iUwHtJpWYBDyt3hY7ExJWFTOrmaKck16R?=
 =?us-ascii?Q?DPRrIdZIzi/s5Ayad0in6XJ8RSPtXDgCfbngykAHcGKAmQCO75Wo4N8dcxJq?=
 =?us-ascii?Q?372Y5EM9aE/5iI/+iIZHEtYZdNQZGYt8STrmF+SNC8onHrw4FAJ2RUArHfLm?=
 =?us-ascii?Q?ExaTmtu06KY2er/RKVc6e7D5rmglPcvKFd66kjez4rpUUtGxFQFrJ9yOkf18?=
 =?us-ascii?Q?HnaqUZ0BvdyrVN9uOwUVJxy4U2N27aiUHM1r65XPnHhn0bqB2jqjyNYunegq?=
 =?us-ascii?Q?NKIoh+1in7p/G9OA5gQpSzSicLfMHXNimKE9CCprQdUxEY9QjiEfOqzRb3KQ?=
 =?us-ascii?Q?l0pGIEG/De5pCS2kiIz8VfgZx/Pzlv5LW5WgYsctB2BH6gmEja4zSV+iWJ0O?=
 =?us-ascii?Q?GAzxjCTxMWb6xh1IcZBaeY6PKLsRxAx1cCRaSesEf8Nq+pPT/2aqKnFTNlwe?=
 =?us-ascii?Q?PoOS9fNHE1mR1R0nAsPd1f138i5aDCW8+Z7l1xgnJQFGpWRVRbBFbYKDCZjP?=
 =?us-ascii?Q?n7AkeVwjjKIpadGqIsi+0Y0AetzT9u7xSctf0f267C3QLWFXnsXv09Z+tXfI?=
 =?us-ascii?Q?A2aP9SHS0hwK17Ny/9RuXrwyj1UYpcnSP4or97ZYP9LPldaY6EkZo7esCwnj?=
 =?us-ascii?Q?Pt5E7DQk1cx4xoOqAPC5H9+QgYU1dmwCLBkSKW+0LC3rkl5gW2gZkBLH5b71?=
 =?us-ascii?Q?QWDfyiZ3VUlM7nSSxxRKidURCC6I7y+E/wa7LRNgdbrTqs1uPyb8BQhNfxrS?=
 =?us-ascii?Q?ZMWXPD1U1ckM5b0fDziY1OKRo/Pde+rBQYoX7gbfSdHIWeLLWKFJb4zoslOP?=
 =?us-ascii?Q?GO8wyRg+5BSRPdWNMbxEIbMUsRkY9uopmsiqeWqXPBzYW2eXaLkX5BtCVZo+?=
 =?us-ascii?Q?tMBvRtSiUGFlpd+vco9RxLJUnBmQrCrGyvLyvrpJ3tWJ1nhLeeaHTskLerOQ?=
 =?us-ascii?Q?WFfpKWGYFQYRyfyylKqNkLwOumLk/Cwbl8vx71fyO0B+RSg+eL2qK1DrDptI?=
 =?us-ascii?Q?/sXPagCjMJTshBObiqjS55m9X1B/YZ5jivaFpi8UiRySRe7l5QuSW7y3FTOZ?=
 =?us-ascii?Q?T8d3j0g2z97nFcssPQxo545hKECDQieV/uOs5wxwlc2UCkmFxshMUW49EKdy?=
 =?us-ascii?Q?eLMXuBusFnyNqbbvEKaRLnphwiyw8zkiZaH+Z/Zy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa270c9-26e6-477d-35b8-08dc56e0b9b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 08:57:16.9913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHdoiKt11Bs/NPoTR0JVEy8C2PkBcHLmE9krlZfH01O/iXqw+iounQDIzpLvKsQ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9177
X-Mailman-Approved-At: Sun, 07 Apr 2024 15:03:39 +0200
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

Adding support for pcf2131 RTC chip.

The pcf2131 is similar to the pcf2127. The driver support rtc register
read/write by using rtc cmd and rtc date set/get by using date cmd.

The pcf2131 is special when write access to time registers. it requires
setting the STOP and CPR bits. STOP bit needs to be cleared after time
registers are updated.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v4:
1. Add static keyword for the is_pcf2131_type function.
2. remove unnecessary ret initialization.

Changes in v3:
1.merge pcf2131 into pcf2127 in order to keep same with kernel.

Changes in v2:
1. delete the unnecessary initialization.
2. retrun directly function insteand of redundancy return ret.
3. delete the unnecessary comment line.
---
 drivers/rtc/pcf2127.c | 146 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 132 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/pcf2127.c b/drivers/rtc/pcf2127.c
index 2f3fafb496..2b000347f8 100644
--- a/drivers/rtc/pcf2127.c
+++ b/drivers/rtc/pcf2127.c
@@ -23,6 +23,38 @@
 #define PCF2127_REG_MO		0x08
 #define PCF2127_REG_YR		0x09
 
+#define PCF2131_REG_CTRL1               0x00
+#define PCF2131_BIT_CTRL1_STOP          BIT(5)
+#define PCF2131_REG_SR_RESET            0x05
+#define PCF2131_SR_VAL_Clr_Pres         0xa4
+#define PCF2131_REG_SC                  0x07
+#define PCF2131_REG_MN                  0x08
+#define PCF2131_REG_HR                  0x09
+#define PCF2131_REG_DM                  0x0a
+#define PCF2131_REG_DW                  0x0b
+#define PCF2131_REG_MO                  0x0c
+#define PCF2131_REG_YR                  0x0d
+
+enum {
+	NXP_CHIP_TYPE_PCF2127 = 0,
+	NXP_CHIP_TYPE_PCF2129,
+	NXP_CHIP_TYPE_PCA2129,
+	NXP_CHIP_TYPE_PCF2131,
+	NXP_CHIP_TYPE_AMOUNT
+};
+
+static bool is_pcf2131_type(struct udevice *dev)
+{
+	int type;
+
+	type = dev_get_driver_data(dev);
+
+	if (type == NXP_CHIP_TYPE_PCF2131)
+		return true;
+	else
+		return false;
+}
+
 static int pcf2127_rtc_read(struct udevice *dev, uint offset, u8 *buffer, uint len)
 {
 	struct dm_i2c_chip *chip = dev_get_parent_plat(dev);
@@ -43,10 +75,64 @@ static int pcf2127_rtc_read(struct udevice *dev, uint offset, u8 *buffer, uint l
 	return dm_i2c_xfer(dev, &msg, 1);
 }
 
+static int pcf2131_rtc_lock(struct udevice *dev)
+{
+	int ret;
+	uchar buf[6] = { PCF2131_REG_CTRL1 };
+
+	ret = pcf2127_rtc_read(dev, PCF2131_REG_CTRL1, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	buf[PCF2131_REG_CTRL1] |= PCF2131_BIT_CTRL1_STOP;
+	ret = dm_i2c_write(dev, PCF2131_REG_CTRL1, &buf[PCF2131_REG_CTRL1], 1);
+	if (ret < 0)
+		return ret;
+
+	buf[PCF2131_REG_SR_RESET] = PCF2131_SR_VAL_Clr_Pres;
+
+	return dm_i2c_write(dev, PCF2131_REG_SR_RESET, &buf[PCF2131_REG_SR_RESET], 1);
+}
+
+static int pcf2131_rtc_unlock(struct udevice *dev)
+{
+	int ret;
+	uchar buf[6] = { PCF2131_REG_CTRL1 };
+
+	ret = pcf2127_rtc_read(dev, PCF2131_REG_CTRL1, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	buf[PCF2131_REG_CTRL1] &= ~PCF2131_BIT_CTRL1_STOP;
+	return dm_i2c_write(dev, PCF2131_REG_CTRL1, &buf[PCF2131_REG_CTRL1], 1);
+}
+
 static int pcf2127_rtc_write(struct udevice *dev, uint offset,
 			     const u8 *buffer, uint len)
 {
-	return dm_i2c_write(dev, offset, buffer, len);
+	int ret;
+	bool flag;
+
+	flag = is_pcf2131_type(dev);
+	if (flag) {
+		ret = pcf2131_rtc_lock(dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = dm_i2c_write(dev, offset, buffer, len);
+	if (ret < 0) {
+		if (flag)
+			pcf2131_rtc_unlock(dev);
+		return ret;
+	}
+
+	if (flag) {
+		ret = pcf2131_rtc_unlock(dev);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
 }
 
 static int pcf2127_rtc_set(struct udevice *dev, const struct rtc_time *tm)
@@ -68,15 +154,19 @@ static int pcf2127_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 	buf[i++] = bin2bcd(tm->tm_year % 100);
 
 	/* write register's data */
-	ret = dm_i2c_write(dev, PCF2127_REG_SC, buf, i);
+	if (is_pcf2131_type(dev))
+		ret = pcf2127_rtc_write(dev, PCF2131_REG_SC, buf, i);
+	else
+		ret = pcf2127_rtc_write(dev, PCF2127_REG_SC, buf, i);
 
 	return ret;
 }
 
 static int pcf2127_rtc_get(struct udevice *dev, struct rtc_time *tm)
 {
-	int ret = 0;
-	uchar buf[10] = { PCF2127_REG_CTRL1 };
+	int ret;
+	bool flag;
+	uchar buf[14] = { PCF2127_REG_CTRL1 };
 
 	ret = pcf2127_rtc_read(dev, PCF2127_REG_CTRL1, buf, sizeof(buf));
 	if (ret < 0)
@@ -85,15 +175,28 @@ static int pcf2127_rtc_get(struct udevice *dev, struct rtc_time *tm)
 	if (buf[PCF2127_REG_CTRL3] & 0x04)
 		puts("### Warning: RTC Low Voltage - date/time not reliable\n");
 
-	tm->tm_sec  = bcd2bin(buf[PCF2127_REG_SC] & 0x7F);
-	tm->tm_min  = bcd2bin(buf[PCF2127_REG_MN] & 0x7F);
-	tm->tm_hour = bcd2bin(buf[PCF2127_REG_HR] & 0x3F);
-	tm->tm_mday = bcd2bin(buf[PCF2127_REG_DM] & 0x3F);
-	tm->tm_mon  = bcd2bin(buf[PCF2127_REG_MO] & 0x1F);
-	tm->tm_year = bcd2bin(buf[PCF2127_REG_YR]) + 1900;
+	flag = is_pcf2131_type(dev);
+	if (flag) {
+		tm->tm_sec  = bcd2bin(buf[PCF2131_REG_SC] & 0x7F);
+		tm->tm_min  = bcd2bin(buf[PCF2131_REG_MN] & 0x7F);
+		tm->tm_hour = bcd2bin(buf[PCF2131_REG_HR] & 0x3F);
+		tm->tm_mday = bcd2bin(buf[PCF2131_REG_DM] & 0x3F);
+		tm->tm_mon  = bcd2bin(buf[PCF2131_REG_MO] & 0x1F);
+		tm->tm_year = bcd2bin(buf[PCF2131_REG_YR]) + 1900;
+	} else {
+		tm->tm_sec  = bcd2bin(buf[PCF2127_REG_SC] & 0x7F);
+		tm->tm_min  = bcd2bin(buf[PCF2127_REG_MN] & 0x7F);
+		tm->tm_hour = bcd2bin(buf[PCF2127_REG_HR] & 0x3F);
+		tm->tm_mday = bcd2bin(buf[PCF2127_REG_DM] & 0x3F);
+		tm->tm_mon  = bcd2bin(buf[PCF2127_REG_MO] & 0x1F);
+		tm->tm_year = bcd2bin(buf[PCF2127_REG_YR]) + 1900;
+	}
 	if (tm->tm_year < 1970)
 		tm->tm_year += 100;	/* assume we are in 1970...2069 */
-	tm->tm_wday = buf[PCF2127_REG_DW] & 0x07;
+	if (flag)
+		tm->tm_wday = buf[PCF2131_REG_DW] & 0x07;
+	else
+		tm->tm_wday = buf[PCF2127_REG_DW] & 0x07;
 	tm->tm_yday = 0;
 	tm->tm_isdst = 0;
 
@@ -111,6 +214,19 @@ static int pcf2127_rtc_reset(struct udevice *dev)
 	return 0;
 }
 
+static int pcf2127_probe(struct udevice *dev)
+{
+	struct udevice *bus, *udev;
+	struct dm_i2c_chip *chip = dev_get_parent_plat(dev);
+
+	if (is_pcf2131_type(dev)) {
+		bus = dev_get_parent(dev);
+		return dm_i2c_probe(bus, chip->chip_addr, 0, &udev);
+	}
+
+	return 0;
+}
+
 static const struct rtc_ops pcf2127_rtc_ops = {
 	.get = pcf2127_rtc_get,
 	.set = pcf2127_rtc_set,
@@ -120,9 +236,10 @@ static const struct rtc_ops pcf2127_rtc_ops = {
 };
 
 static const struct udevice_id pcf2127_rtc_ids[] = {
-	{ .compatible = "nxp,pcf2127" },
-	{ .compatible = "nxp,pcf2129" },
-	{ .compatible = "nxp,pca2129" },
+	{ .compatible = "nxp,pcf2127", .data = NXP_CHIP_TYPE_PCF2127, },
+	{ .compatible = "nxp,pcf2129", .data = NXP_CHIP_TYPE_PCF2129, },
+	{ .compatible = "nxp,pca2129", .data = NXP_CHIP_TYPE_PCA2129, },
+	{ .compatible = "nxp,pcf2131", .data = NXP_CHIP_TYPE_PCF2131, },
 	{ }
 };
 
@@ -131,4 +248,5 @@ U_BOOT_DRIVER(rtc_pcf2127) = {
 	.id	= UCLASS_RTC,
 	.of_match = pcf2127_rtc_ids,
 	.ops	= &pcf2127_rtc_ops,
+	.probe  = pcf2127_probe,
 };
-- 
2.37.1

