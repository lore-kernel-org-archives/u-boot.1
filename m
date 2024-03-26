Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A845CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 10:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3831388047;
	Tue, 26 Mar 2024 11:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cUzMX9Yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C171183348; Tue, 26 Mar 2024 04:30:28 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5FCA870D2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 04:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTZcnsS5mXrni6wTYZBpb0umEK96sbYbCaoCwzhjbkETDtEwLnfK6JCXK+z5roUr73+orHC6bU2zrkOi3xzUKPeAJg6+BAK9dv8wL3vk1GEAKWSpoj81xoGKqOVFHYhtxgPvguSktf9EylOSe0ZGZ0pj7uv7mbY9etykHtH9cb+1ht2T2EddcMa/2PKuVZsiFFvrWKtuFVMNIeRaCIVRhm+Z930orSwaxAjsjE+ZnKvHYxKNTP2uCAAFVhTx1T3dW+jYqzCDuSwNSaOYUbQ2kPmTokFb5pSUWNs9hLhnkcxYh0qlHk+h5OQbWkgInmLHrGGPpvpf3VSqTmKqmItJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFr5lBUf7/UB60ZURFFgtBxrfSM4gh6AN+5Vkc3zMhU=;
 b=UUh+AHgYpc8E50+2UtlGS6khhwqcAJUX1+pBdzQYrtRWy3KM6OhDWa8I1x8C9dcku5tpdwYJQdU3X18MspnJOPESIlhEkm5ksOa9SLvKdPB5N/qidB+MRMgJtBBFb5q0kmNXmriqhXXcH/6oxtjOLTqvOyyQp2FmTMknymg7X4AOIBNApCpFli8xGDmqOEI2yl+6Sg2d4D9LpoIl8xHYHykQIsimQ0pGYEm5x11fY5EiRuFortWmSFMlEI5/of2rrvmC37t6ZLza8UhgpfCXhZnLEPS5Bl/vjd0HUg9geFyrS+751qRuxsEue9gGBFibBC3qoP29pKNZyy67fUpMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFr5lBUf7/UB60ZURFFgtBxrfSM4gh6AN+5Vkc3zMhU=;
 b=cUzMX9YnokdBNg/kVbuzeJPP08WbbVGZeAwB+/2jzUWYb8J5d+zx6byZsgDOIswNXrMjXnTmjaCs5WqUj0Rn9IkrLxFIdlI0UzLkmALhLcm2QTrOral/kIQudtlHPWwHOluTENyDi9ZMBd8rFhLgKHwwBNTsZ1xr6rMs/gX9b4w=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB7863.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 03:30:25 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 03:30:25 +0000
From: Joy Zou <joy.zou@nxp.com>
To: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de,
 festevam@gmail.com, sjg@chromium.org, saproj@gmail.com,
 judge.packham@gmail.com
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 1/3] drivers: rtc: add pcf2131 rtc driver
Date: Tue, 26 Mar 2024 11:37:59 +0800
Message-Id: <20240326033801.228419-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240326033801.228419-1-joy.zou@nxp.com>
References: <20240326033801.228419-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB7863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T26ee04hJIuainBcCPC/Hl30BOXs2vyaL2+It6MGQ4xVXa8U+DOMTmnAp7DqvP4MKBrY4qEDwwPvgfVGl7G7sQ/58cTxYeTyUbAJuhPnlW82fFPG9jxhzJHXs4ol3bSnde8JXs8wywQJCOVjL9aetkpPtjlCoSkxWkI5+nFY/nUMHxFn9LuHJ3/P+Cg6PR1gk6WYI4bVFuyNTFRBdnA3gVhyOYa/O1LQBUwk/2qJk2kb322BZNz0U6z4fiooO5MzG/pjtEq9PeKIdTIJsmP0DUQbCge1xz+RkauzC+OUBFFjCcduE15ECgUybRoIn2VnVtgE1QpZ9D2ZF3zvTBXE7zHl3D+HVt3wrK2TRLwrLEnMedheJ/uwAH/qwvqAiPMG0JOV/zviIgA0F363o8d0Jlk2haaJ9wPs6Fq1F1oEGxpScuEZDD6K7PETNRa+bCBsjBLd6m3P2WeJIe+obrmtwuxgtwkLHf5HMaR7jxL12Ts8FccgCvSm/G6X+hq7EwLYaeDqP4xzSOU/rmuSvO7PWT/hvBeX/kveTTgDJUTHWYr6eoq9MZlFTolw4Iwnf3XgQujFbctYRd5UqhsXxbb+phCi56nATEMc0cCKjgM1zt3fkVBtN8W6R5z/uidqFtWm1noQ16HKJ2vVQYndDTwsDV3W5wKNs1MrQTl8uiss6q3ccIPwNbtvmY+399E4L0RAGO/IdMWOKXqDGempaFzurQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SzxEBH5K8QVN/wbjHFQgrpiPZZxBsUIT3v9iZeZPPj5qYmQ6BYERJFBFgI1S?=
 =?us-ascii?Q?UA6AlnnogbeVorNR5NjTWpBKmI9mFOyje6wFVsXAe1KLeltAAVS+mQtoiOGG?=
 =?us-ascii?Q?OywqK8WADf1yFwFrZJBVvl4VvTzkih68kLOKO9CsQQqebW0jxxMAKdTVkpU7?=
 =?us-ascii?Q?V39+cyenfKjrDeYQT2FK7qrMcKmQeT5ClBAAnUPFnapvJp4V5T3preSvdExu?=
 =?us-ascii?Q?6Mn+rRR2UUkb/1k3UqXMX5obgB4K/LFZvKCceydZG4Nzb3tzBDkRqQ8dqYBP?=
 =?us-ascii?Q?sFQhVJcf5De8bPfY+6pFG1LloOpOUVSzif6crqWcltTAS8nJFsj5+tZ+IF8j?=
 =?us-ascii?Q?UbSCQkcrU9GXpdMevrF2kBoxSzbrWsu6D9n6y5Zf+fEuW9zcQrF4c89dJZ07?=
 =?us-ascii?Q?n/uCYNPIBjjpDEz9RnVHEw7oW77i2l7etujHQMPAi/qYlr5SNvvAU1pYV3e3?=
 =?us-ascii?Q?pU7uaUqJ6HmN0BTLoe7AFodAh42qxrfHmPytuJf7QLqyMnMSJ8Kzf6k2ZG6U?=
 =?us-ascii?Q?GevSIiBPKxEt0HjChwQtZYVGITcTB+DYVqWJ2ca+jR36EVrDZV7nWvn0RMUS?=
 =?us-ascii?Q?nRr6AZYGaIkZ4UVKJ9P19/zlg+W0ERM484pfNtynL+FNxtn2JBPaPDtm74Xw?=
 =?us-ascii?Q?qEvaUNIlZL52vO8CjN4xdlZTW9Er3Fl5IOepig/zqR+dj2fK3CdjsZDsoOJZ?=
 =?us-ascii?Q?EqS/i7/TJBNqr0Zq3J8qb1Tk7e1yo1h2HmLW+c5cwov3z/xTQ8d8c2EQD1sV?=
 =?us-ascii?Q?Pp6wUy2/vtyzaTzRRrYRCvpYMbFKJFjKeyV9Fri0kLLpePSV1V7X9Rx6MJIX?=
 =?us-ascii?Q?EvrIVV3QLJ6R0BDCR9xWNh5Xjz8HuWx6Oqr9C7pmwQAHxogNKfWGPT13u9qV?=
 =?us-ascii?Q?hDlvDY21cTsCo0L7QlcbXa8sktIfY8rV9E22CdoA03P2+oIx4HongwIjtTQs?=
 =?us-ascii?Q?zUIcBOw+XxjF+Mt0iwSgm6fOGKKEFfQY3d4UEOO0f/EgC5XpHtjHCrrgFkhE?=
 =?us-ascii?Q?50ApaJVbMgfOCiSCKPBVmhYMpSFSYs2r4teCaSAxR/XdP9pI0HutAQgZCqsm?=
 =?us-ascii?Q?wR8vdtnl/NWqlW91tLs4qznSsDh4gzXzm0k+H7scpNNqCoQ9sgXfSTsM5XgW?=
 =?us-ascii?Q?Heu6KE5GogSt2NqZroS1kSlNa467Gl8pO/ysScYNTzMKyzmNynlr5kSiLB1O?=
 =?us-ascii?Q?1jLdVAdMTepXdexHolIm7Op0T9ZK1VS2NNACZq44sxaJUE5siIAYPNCE3y9v?=
 =?us-ascii?Q?rC0uKuYPn2YWgJadri3/ENP9MKgUSM2Ql5cBTyx/PV66+Rygli4sS6tilCO1?=
 =?us-ascii?Q?fSoXzqwcRV3EkMj3M057zINn3Pz1JjSqq+W5s6PhFd2wBGDum7AFwSvo6kr4?=
 =?us-ascii?Q?hvsbMxeUJaApI65TRfwefYiDasASAPhEUW/Ynqv8ROKgLuLYJmSWGjyXGTjW?=
 =?us-ascii?Q?6FYxvVtze+do8vWnsg+af+MoEKCY0aCmiz8c8PC4tp1ivYQRe3giKp3o0Tto?=
 =?us-ascii?Q?tyr44ZwfB51aGO9XWhiGpldIJJs7/0A/OtgEXVfxE0WKMOdRO7iwztwqugJB?=
 =?us-ascii?Q?HL7jMpyvvLig2DWs3QEHMRdzODBgY3dVPqnetgU/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4468dbb-c118-4927-a5a7-08dc4d4513a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:30:25.8546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps4hT/an3VswysJaPqovntrhCelOrKmh5pVz+401sMLa2TMOZGJCbQ0VwQgzdWUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7863
X-Mailman-Approved-At: Tue, 26 Mar 2024 11:21:12 +0100
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
Changes in v3:
1.merge pcf2131 into pcf2127 in order to keep same with kernel.

Changes in v2:
1. delete the unnecessary initialization.
2. retrun directly function insteand of redundancy return ret.
3. delete the unnecessary comment line.
---
 drivers/rtc/pcf2127.c | 144 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/pcf2127.c b/drivers/rtc/pcf2127.c
index 2f3fafb496..58ab5a8601 100644
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
+bool is_pcf2131_type(struct udevice *dev)
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
+	int ret = 0;
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
+	int ret = 0;
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
+	int ret = 0;
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
@@ -68,7 +154,10 @@ static int pcf2127_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 	buf[i++] = bin2bcd(tm->tm_year % 100);
 
 	/* write register's data */
-	ret = dm_i2c_write(dev, PCF2127_REG_SC, buf, i);
+	if (is_pcf2131_type(dev))
+		ret = pcf2127_rtc_write(dev, PCF2131_REG_SC, buf, i);
+	else
+		ret = pcf2127_rtc_write(dev, PCF2127_REG_SC, buf, i);
 
 	return ret;
 }
@@ -76,7 +165,8 @@ static int pcf2127_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 static int pcf2127_rtc_get(struct udevice *dev, struct rtc_time *tm)
 {
 	int ret = 0;
-	uchar buf[10] = { PCF2127_REG_CTRL1 };
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

