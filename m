Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ED8CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 07:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0638C8482E;
	Mon, 11 May 2026 09:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="nmajgAn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C5E84834; Mon, 11 May 2026 09:47:46 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4294484807
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVtaMX+AYfQuYf6GjGEBI5LrPCeK1ZanZZQgfz461tZmSXILBlIgQPzZMOZG01yN5kFkiNddcQdHcdvnp69QMbwrhJ8y7tiKObte4DDAxdHQUKDXLoPfvEoBSz2/eMkLzKOOsu2T2N9o2se8WFXSULdvH9CCJ85m1tYzm4LnVNXeOZQa2+PAhwYzXdVZx38aJ2HmZZT2wMtyqHmk14+/pI7EPNNkxtOe++8P7P/Je/bnE09537/G4k7ONyCD/OEkkOKcqfYoqzj1WufaBdyX3QOnBm3opIiJO9SweTPUOs88jllUEIZnzdleHv24akSZ104wSXc8BKnXVRF853Yp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLnojdTNWFFHexYIum4YkiOE20b7FNC6uHnrik4g+Ws=;
 b=dWlB41PRggQrMan+m4DSLPHLouUJMqvshT26WTXzwBblZ7W399V7lB+PnPVEqP1RlO1ysXVKBjQ7JrXBC6l0gbZdZi70qOc7QgQIFIiCZyBlaA4QQx5dbC5k143zhrgo9sAqkBg0KJ2TBkJL6Yt1Hb3kocrNqYdj2nwZJ9VrJ6x/EXgSsi+qqtw854MyxJZDx9z5eaJWiJGsbtBd87B6F2b1p0HlBfpEnRjdJJtOJ5orrdc3LWmmDbwahzKhyOIH0yYLDGghmbGnqdYFA8XqBMjm0w8Ci5uoFu3A4/6lRTUhOSCz2fPmWwaVcSu5IjCkCmhda2+/IJMb+Pi/1sWG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLnojdTNWFFHexYIum4YkiOE20b7FNC6uHnrik4g+Ws=;
 b=nmajgAn88qr8nPkf9LXzubR6cBrHqfM9RiPvxmkBW8n1sAd8MQPKf2j3mIUJUIxD/6bCWHEl88ihhKWr9H9cZhWO05Rs0Lve4DH5xd/ZTrHJav2IHcc4RCo20DLlub96EyT8ITLA9mpkNF7xer47NTRSRGwRQz6geUTmfaIpfejBE2K/NWhucOKJK9YQ3EoIKcj0CP6d4S7KR1KCmwN7Iyg9oWfVCGq7LIWDHVJblskL9YnR2hbee1hx3bEijZseyDN+AYhGyBOuBGObCOnG2toNqQJvan1FeKPxLYu6Gj5SA8EFAd8s483IDfbIGaqzdIinSUVbm5nAQrIqMQEccA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by AMDPR04MB11617.eurprd04.prod.outlook.com
 (2603:10a6:20b:71d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:47:42 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.20.9891.020; Mon, 11 May 2026
 07:47:42 +0000
From: Ye Li <ye.li@nxp.com>
To: jh80.chung@samsung.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: festevam@gmail.com,
	uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] power: regulator: Fix power on/off delay issue
Date: Mon, 11 May 2026 15:49:53 +0800
Message-Id: <20260511074953.3777767-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|AMDPR04MB11617:EE_
X-MS-Office365-Filtering-Correlation-Id: b89b1cd5-e153-45bd-1c94-08deaf31955a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|42112799006|376014|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info: bv94Kj6F6zrcz57xXP/eso1orfYaHgGtdpnp2wXiVXkTcJM5/WkNI0jjTyMC0TNLgIOQsM6fGWf5QPyKSGXTt370Hz5iFGKKRc469Gcl9l6GwT1B5sMwFfUsQdEb3bV7Qu1uwdmwmFS1ss9twoA2oEHx3z29e0haF0cHkzKQE9ePBoXR0U0ShL33nwtpfIdXT/0KwiI9onz2DdynbHppmRbmiUfzQRcsQYqOpaBvNtkCeqnCDsqwPTYHGS5OPobe4NslUQ7vdbvXT3g0OJO1F/0yUuiZkqr7KIOYMLnrboPPB5U3fwPAxNRZOwzkY0ctRraZOYXdCgtK97ZE4bQkhtpyFOVjuNzU4om/mUdFicGrcy6zPRSF+XnAtFC/sc6mcOGQzrIbEN0erEtRuM3t2OWeqnScIwvtMcz3y+t7Fr+ZIswTkNBI4VKhNLB5Gm0jMvZPDDRJYLcKTJmSJgzMafuWdoViJs+oy+l9CphQYAgzfOQ8seoaCoeWW5+os06QDjdtteA3QkRs9P2GdtD0Jr2zjdoIEymby974fSqovodyX9H+q/i4Vmshipvm81ZgBqm5ZN4Eqj8+R5wSVjJYjSJtLWcUL2+QD6Z1KtjXO4unJreznFjWv+uOAzUcZpe/Q5Ai7iwqCgqFhcjW81Y8D6UhmnVRumnPE+FkCBClopWgjYl9Ap6DSaROtZFfBtC/M0cbN50ovLlUrP93gEhhMNr38c1fVTNEnbku+azGF6WhEOR67Q57za/8RDzbRgEA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(42112799006)(376014)(18002099003)(38350700014)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2e9r4yn9QAfLOFGyq5Nyk85dquVSumhr4VnhstEIylTG8Sa4DMlAwXsB5axV?=
 =?us-ascii?Q?4BpTUAVJihBpx5mNgxkEvW5dPlDHYT6BQZHM5GH+Mk34CpazO4EI3341Jx/s?=
 =?us-ascii?Q?hVHAx0f1ckePF52xnVu6hTm0+cvMW2MZTVMuc9mktu2LlClKVjAsnSDWPiQ2?=
 =?us-ascii?Q?hmDirx7gM2WRn+ZtMY92ra0d2mITbySHxDutVNGaeaOtyjm3gGhrg5+JuztD?=
 =?us-ascii?Q?89tdNiEeJrXGUlJk8F+HfeopuYVDmI7CHeN+6r/5MWfkxVXts2w05w/wAYDs?=
 =?us-ascii?Q?9+5hrgSL7xfKkS38X92mYyL/+Fv1aL8qCXH9el3KPdOAJvqv7/4ppAwep0OR?=
 =?us-ascii?Q?nIaTH3pAw54BVC8tKc7G/kzy/Yg/QVYzJ5uMl6vYimxCwqk0B/B2s6Hpr3MV?=
 =?us-ascii?Q?DV8t+H6g0q2rPSGDIPZWAVm9Him3+DnifqH82uzx/JkFsfqPCUMucW4rVcrJ?=
 =?us-ascii?Q?u1XWKpo6bxJ/BpRHBh1IHjlDdbuP7z7rgEwAqAbE+z8/ZLpF+/tC8DBYg/8C?=
 =?us-ascii?Q?hxAX1q/2vKElLgaO+HQmseeKADElY4sci6AGIp6PD5+/OktNtXMYFYNemdC5?=
 =?us-ascii?Q?KN0xitsII7bElXFJOlBefUX+9jBWsbjfe/YvbbqULs2w9d3Ox0JrHXhwc3nq?=
 =?us-ascii?Q?p7HOrz5R2YDGk5cQODFZZ8iQXC1v33A+A38SINzLYJOV6s/UNYlaV1zRxqNF?=
 =?us-ascii?Q?+GEkpbtdMMSi6Fg7ds/W5ZNap21muLNQV0XQVpaAEF7ZDLiKcE7iUmz0P6b9?=
 =?us-ascii?Q?ohSAyfq5gOFcPU7bHZTlBPwbADgqE/qKIohpY2Ybg+gJngyUXxbmmRnW8n6H?=
 =?us-ascii?Q?0oaTVBVhQ6ZZ6Gb34jPpGeRTb1mbayB8mIUuxpRLODQeARM/IsCwctbT0ktn?=
 =?us-ascii?Q?L+UDabHTdeZyCTLLxGCjcAE1UQPxaPiP2z1o2dawNSKsjiKX6/GGhdhI3baO?=
 =?us-ascii?Q?QgalUaFot+ArtMSX+RmlSjWEfc3WrPQc8NDQNMxIL9ByuHM0mHIXXEGaD5DX?=
 =?us-ascii?Q?LxGH64+w4msoOFs9ejn0vFIY6MbtPjplNayE/PJyuBy5+WrN+Aw5tQO+YxL7?=
 =?us-ascii?Q?AqLwit1B1kY51I4zIKs9pCTy+KOkIJ7HitIrWQ7C5ZHKg8ZeYmfAkp3Db02k?=
 =?us-ascii?Q?dEobL3G+PsC0OIaQzgx6+l341vb8aimlyNa3IiDOYPoqhF/m2zsCZQHJJj3z?=
 =?us-ascii?Q?A8WR+BwF0V8hDKgGeHokhwKsQujU2qF9dJaQrzRjOVBMzcXo/gZZe3ZSFqN7?=
 =?us-ascii?Q?VMe3NIBJPL7zu4s322Kn846rEM9ygA0IwhJYlMa+YZqr7mMlVgy+w5vwU2BG?=
 =?us-ascii?Q?IH+xa5EhsP1HyqKc3g9UUqgD9sEWiQNd+Hbzq8CfFifEz1+3Foi3dGnNfBxp?=
 =?us-ascii?Q?cMnL6wex97KhjnKMAv5BjbNFBqj5eO77qDA55edQkhe30IqjIh57KhZPvUfe?=
 =?us-ascii?Q?qBzd2HyVeB+ORMg57AYfNth0YwzQIUhpAmH8zXXnRD8QZPCZkPmOuPPG9aX+?=
 =?us-ascii?Q?3wsBTj9uY5KDW/b4+Puaq/agzDrD6odzRjIOx9xn7tR44NCNWYb/H6A+UYLX?=
 =?us-ascii?Q?DvonBYVxC4lcyaVFBKM7KwjBq3cZ2L/sCZazcKAD8XoF5aXTqmUCRe2jVwub?=
 =?us-ascii?Q?DPEzWgLmUz6R4vaX9a8j6t+7Fmzb69IO8gQGL5UUbg8bCwMLJZxtShbVNKB8?=
 =?us-ascii?Q?KX00kMhZDfVMhvguhNfkGgEpcj1GNKjmOyjRY/Q2iDG8AWuV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89b1cd5-e153-45bd-1c94-08deaf31955a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:47:42.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JenZ4iDCPnTY7Lm7dQ6/AbulybOdW7IgN3QDRs+BtgJab6pvofY20uOt5zDdUlf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11617
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

SD initialization failure happens with some UHS-I SD cards on
iMX8MM/iMX93/iMX91 EVK after
commit 4fcba5d556b4 ("regulator: implement basic reference counter").
When sending operation condition to SD card, the OCR does not return
correct status. The root cause is regulator on/off delay is missed
in MMC power cycle with above commit, so SD card is not completely
power off.

When SD startup, the sequence of MMC power cycle is:
mmc_power_init(get vmmc_supply dev) -> mmc_power_off -> udelay(2000)
-> mmc_power_on

Before above commit, as a fixed regulator, the GPIO is set as:
  GPIO inactive (in mmc_power_init) ->
  GPIO inactive and delay off-on-delay-us (in mmc_power_off) ->
  udelay(2000) ->
  GPIO active (in mmc_power_on)

After the commit:
  GPIO inactive (in mmc_power_init) ->
  enable_count is 0, regulator_set_enable returns -EALREADY immediately,
      so GPIO is inactive but No off-on-delay-us (in mmc_power_off) ->
  udelay(2000) ->
  GPIO active (in mmc_power_on)

Add the on/off delay and startup delay after GPIO request in
regulator_common_of_to_plat which is called in regulator device probing.
So in mmc_power_init, after GPIO is set to default inactive, the
off-on-delay-us is applied.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/power/regulator/regulator_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 85af8d599ad..158284a3309 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -46,6 +46,12 @@ int regulator_common_of_to_plat(struct udevice *dev,
 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
 	}
 
+	if ((flags & GPIOD_IS_OUT_ACTIVE) && plat->startup_delay_us)
+		udelay(plat->startup_delay_us);
+
+	if (!(flags & GPIOD_IS_OUT_ACTIVE) && plat->off_on_delay_us)
+		udelay(plat->off_on_delay_us);
+
 	return 0;
 }
 
-- 
2.37.1

