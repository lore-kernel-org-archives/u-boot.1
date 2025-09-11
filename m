Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BBFCAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F1C8359F;
	Thu, 11 Sep 2025 14:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="k15dteh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A8E833AD; Thu, 11 Sep 2025 12:56:48 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9468833BF
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOrfIg1lYC+TuoDgxc9k5G7GK4FB/epprr4fHhVn7xazqscpfa5AVD0bLxVHQGG7WrU5mUtyC9e6UrSXNgTarDgxiycrMmX0vPSDhKg/zjjPiAPT/mBxDE3QuYxS9E8xqtI9aI/KYENz6OJ7rFheH3oa/x953ZV8CXEiNd5skffJEfKqIyDMVXTNTOh38csY9lpe41Y5yrp0Ck4GwR4DXJoc/Oo7YVpK23NAGBT+4afXCMkBULM13SyuUtFoZEUuLGwG8jRf0MvOZr9YzDDFSYb9xo6JRUuikQJBe/jvvnEzgT05LPyMvMHy4xBbkLNs1/bOa35seq1XDzrhVUnwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhY3qEfthSPU8xFbXX6SkKUWQbCyxcXhLFwwhA1bSRU=;
 b=fO0Wv7XHSAtt/P3Fp+HIInze/EO/Gl2Cz3ffQlE1URUPw6UYbGjOzuK9KPkZSs9MKeyq1l2+0yWZUqqGs3567gkK9dulXBs9nW/ROgT3AssAEWF4usWUYvlE3cedzfaKtVN9AToXdA+cMkVJUTkeSgO1JWohNK9o1AeuD379YX4oAv5gftLQx/X7eKxXT1ryl6zIBKdTdwv3sgpk3NnlkoiF+GHcDry4WOfBtfSBU7TgikuKJ/oh559XvgP/5b0v4BTx8qJkPWmTxxB7Vb4M7NpUtOybTxT/AW8e2AfXhtnJhWEKOk7bCW+Uruy4qcQAHEtb6CXSr7coXo/NT0FF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhY3qEfthSPU8xFbXX6SkKUWQbCyxcXhLFwwhA1bSRU=;
 b=k15dteh5SsW1MVHJakkCTZDLcIGzSzWO8lVEkn4zXYKy0zSO7d61HODI24n/kuEYOODgyccxvSuJhOFEDtOI23WSWDvOOKUnyJo/lhkM5rL6hPZivfWG0Yjl95TqIRnmCUnSweM8RXGflK3z+nwoQoYoarg5HOjKMGcYgXMbIxvZNTYwWdaYKb6WkypQmuyxP61rfX8MiOdQ/VwIzyaCiE2lbrblCLeTPQ7xyn1TuUHRE/btaU4EAsNN3nXkKgYHVZsVADk1qWKBVxWIDE4c47j0nzyAGuJIvjhzG9oGKFc5wUVLkgBcX1FE9SYtzvZ2HP1Efc1SwA+Xm/0g+7/r4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:45 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:45 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 4/8] power: regulator: Add vin-supply for GPIO and
 Fixed regulators
Date: Thu, 11 Sep 2025 18:56:07 +0800
Message-Id: <20250911105611.3664965-5-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911105611.3664965-1-ye.li@nxp.com>
References: <20250911105611.3664965-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV4PR04MB11752:EE_
X-MS-Office365-Filtering-Correlation-Id: 23160972-233e-41dd-b5bc-08ddf121e5c8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UNtZwi9Qgt4NSMXDUypjqggGGh9boMbhYG1HxPaQ2UjvS0ZI74SvAJyr3QYm?=
 =?us-ascii?Q?AKDy5qWJDAc3YlDMiSvTqwwcgEtEDTdYRrPatsZGInywf5WIccxDkZ19Pt0u?=
 =?us-ascii?Q?WY+iGMqUcgV6rF8bHzMPYUA9gBKmHEkXfHBaTnjmEdxr+HPXvgv5giYDOSFh?=
 =?us-ascii?Q?LMOZoeoYb+/27qZK096qbyQm/e0pb9YyRqduK1/SlxxxS6yovejQGazvi9PB?=
 =?us-ascii?Q?F8b/pbW6DfIZanDxWkThZi69+giXsEPFeJQpXNoDAZWOmH0FpPldBg9xZvoB?=
 =?us-ascii?Q?rvfQqgMNkBMkukX3tXlLP8oDm9RhlX2NUNzvRn1JkOhtqIbxnKD92XYAJNRN?=
 =?us-ascii?Q?JtqPdEdfGuQzCXMqh9Tn5TUe7d6v7TIo/NZ48r8hhfORLeEG51rXu7ZX6aL3?=
 =?us-ascii?Q?Uh8BXqqud5SNzBl6NpoBjx6nMupnn5czsbT7R66v+C9CnfFuphNBSZ+Yy2S/?=
 =?us-ascii?Q?/KzoIuLuzVbotnXBnJq/kNRdrnmGG7nLIk2AQtPYRnVenY7K68HylX0k2luR?=
 =?us-ascii?Q?fSCcRQedPXpJYQM9iSFSGGeWEgv4M7XA5aLURMvgpX9CQ7w0PI4WU2ZgNidk?=
 =?us-ascii?Q?DS1ws2qqRsfseqnuLFEz1u2OCJp5wJgN99aZM3wxybN+B/CqZXp2/ON1Srh8?=
 =?us-ascii?Q?VdraKW2r1xQSN9dvZ3n/5DUYYiaxD47CSZ2Ua9fjFTQzcAvVQrn+FC5YxlWA?=
 =?us-ascii?Q?r1hS5RiEvtuhMmPzJLFvP/XQ9WckE9nbVf89Qm5pN4Z6di1a6sWRvVHgkvJs?=
 =?us-ascii?Q?DvIzzTQ0JMidXOFlghf8tIkyUEdza6T6W5zSRcldMVNnta1woE4kh6q24Cjp?=
 =?us-ascii?Q?DsJG0r7QWYWfw0tH/vkxDEy3uBplMiSOBUcFDKViRJ0uWJDUO+gqph7n45Rd?=
 =?us-ascii?Q?U1FqycA4XfURowBA0mrfgA1aopB19S9c1SprzAq0oGDXD2ChIgazvUQtvhOZ?=
 =?us-ascii?Q?wGmMcQzor2gz4il9Z0eyHQ1N7tZck7dQbxUlUW+VV/X26Q6uABSzV3lmQGXm?=
 =?us-ascii?Q?kQSBEedhdxkK3L/Cj0CQftMDN8fTQLk+OQJaue0hacf8u7lkpiGUcXFtPX9i?=
 =?us-ascii?Q?BDYXg9gtD6oe4sfg0TzvXxBTShZm3J/TXjqB5cBLkV1T+Rtc+lCeqTRVwpbh?=
 =?us-ascii?Q?NQbnDJ9viRTSthprbNxeEWodfyfoYUrf3o711Wc02ZedzqwnRdChLICv0HPa?=
 =?us-ascii?Q?31RFnrpHyBdeC5UeWEv+y9e+EiJW2cSRo4r9A8DKBytSBv3g2s8s+1FvH1ug?=
 =?us-ascii?Q?ai/29yfaE6AHjOWDZs6C3TOz+TnXGxdwmqrUqbJKLdCaWf5+yJy5dIGqvESK?=
 =?us-ascii?Q?KjDf7ZcEfR7MeyHMjDwysYypx4Xyd/rNz7/haiAw1/INs4CYqIas7a0dXvUm?=
 =?us-ascii?Q?L/HZAu8JW5Tr+mXNMs37pr9NwCd8ZHRZPdmTwZ2A4RThlaGxHTLcOq4Dgsm9?=
 =?us-ascii?Q?550+PnrAzkNli2zpvIKeEHkrEtsbASS32AQV+RIdLTCaJ4KA4Wm64jRKKLoY?=
 =?us-ascii?Q?gt9s6zEwl0WJ6d0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S3p+0Nvf6QLXpRGx6+Q/8Iqg2csRyycuyV92lAxlRhzGwCvx96DEM2tpnQB0?=
 =?us-ascii?Q?7IGLVTRXgRjCnmJrUEGEDfmfb0CJrIgAc0wEFXzB3FRcMxMGxjk3J3ljRqxJ?=
 =?us-ascii?Q?CfWk9PYihbQapP5E+dL9ZGmQi/ukdRJfYKrpenkfPZLvrX4EXSVX7B3LrljS?=
 =?us-ascii?Q?GfbPm812+ITV4UxL6wLiykZ0XtOLhPkC7o2I45UfCWEXNxczuFl+Un+WR1jB?=
 =?us-ascii?Q?eecLUktv5J4Y1UHUZDW9PwcthJ9Y7j6Eb8b+6KlJFco8G6sg9uvliaoJsP6f?=
 =?us-ascii?Q?Mt6iOyE0mV/MKwrCo1n5tL4o/ecRNoc5hcfcslUahXfMIuztFigm7umCfgxG?=
 =?us-ascii?Q?RVFZg0qIOGn5judD47mGqxJ5AnCvutDTyccpXOM97n3UgmSgj/dJOSISV0DN?=
 =?us-ascii?Q?QxmdqjF493+a6ihL16Yw4576qTIyoM6J6GgZlyFNJUXNDW1CDo+cvdW8koKo?=
 =?us-ascii?Q?mUt4V7iEbOdOBAGCspSFUlONLc7XP4D4JQmvna6dbtR2HQSPqvLUrSnPWee0?=
 =?us-ascii?Q?dEgjyG4O+N4bfFsn0+r65E+aBD2QzR+MifGDhRfWijuyLDn9JlPw1S45kEgO?=
 =?us-ascii?Q?6eqvmYwt3Wj5OMv4kfDzAAYSw1XSFERTpQeD3lKjQtime5Y695p8uwWmTlbT?=
 =?us-ascii?Q?i6wlZP4IYvsVxBfezMLHpFw5qgFDKSEXe25IOm5fw0qKwUHXKZtYwoAfTa4q?=
 =?us-ascii?Q?FlQWUSBpPA62cYav0BNF/FVXF/rEJhKSMLLuG+x+3og/SIkDQDCVN1QBXAdJ?=
 =?us-ascii?Q?/vPOSitfGDfsL+CnCdovMGe7BbL1AchQ5F3KEJk7VOmp9LiRr5GCskbYPTAd?=
 =?us-ascii?Q?RJ/VWYhccoLrowN95YROJQ880WehXSxB/ujAsqKb0zGJdfMUje5wMR2DrSp3?=
 =?us-ascii?Q?ehonczmBQ35KH4UoooUixsGgvtEG4/6JBOQgUCCOI7G+EZYZfg79ddNZoAYD?=
 =?us-ascii?Q?isVqnfT4PTHzTihsWisilmWANxntOgpPKEMMeMLYaj5awBKwh25LBfflhjDC?=
 =?us-ascii?Q?5qoSjl+wnE6kHAngKoq2DRcQd84VVidYU36hBsx4RiYmZdqvAgbZnhftaHJU?=
 =?us-ascii?Q?sUs/6EYW1bc2vrqzQkky8Nj0tq5E/kNo1sB9ivxmBKNzYGjGZrli1g96PbAI?=
 =?us-ascii?Q?ArAw3DLowAa8cFKrK5bDQnVxe8zk4+6NY+kNXDQLTi38hLGLwkcBRgfd72NR?=
 =?us-ascii?Q?5931ctQM7koTc4nWrdFg4iu7M2txgxvF+VSQ9ZjzpsALTNuAMKF/ZdVTkRJI?=
 =?us-ascii?Q?/GliNswaUt+n04oQSrEhhviAIN91h9aW5Y2y+P0G8ZUKQV4pgePV/Q9AvHHv?=
 =?us-ascii?Q?y4eeuh7H9OrWhIYb2actjw2F9OCtwoLou6xE8EtkU2wiZuNh6qkkUkkwuapD?=
 =?us-ascii?Q?QZQ+pllcyUbNxfNjJlYmCP69aDxncxroMxgI4Iw7lRlxJ3umk6ebSrf8lwPb?=
 =?us-ascii?Q?xFE9jbiYdP857WzOrXNqaJhNmtjB8GlVeNbLh4l6oOjuSocyDHwu6/uwpNs/?=
 =?us-ascii?Q?blFPxTxgqtN2pimbGSS00q4t86EAB9U0lEoBHWRJ+F7GwYAK4hXohFSAWBWu?=
 =?us-ascii?Q?xpL/X0VrfqEKJsYuA5Xb7p/uBd2HwDrZj9TXFOT3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23160972-233e-41dd-b5bc-08ddf121e5c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:45.0144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djhutunwukJc10v+M23X5PJIvmC2piAwNRN/okeD73eu3h8nQ7qDYOurhoRCxonz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11752
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Enable the vin-supply when probing the regulator device.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/power/regulator/regulator_common.c | 10 ++++++++++
 drivers/power/regulator/regulator_common.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index e3565d32a01..c80f10c3aa3 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -45,6 +45,16 @@ int regulator_common_of_to_plat(struct udevice *dev,
 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
 	}
 
+	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
+	if (ret) {
+		debug("Regulator vin regulator not defined: %d\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	if (plat->vin_supply)
+		regulator_set_enable_if_allowed(plat->vin_supply, true);
+
 	return 0;
 }
 
diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
index d4962899d83..799c968d0b6 100644
--- a/drivers/power/regulator/regulator_common.h
+++ b/drivers/power/regulator/regulator_common.h
@@ -14,6 +14,7 @@ struct regulator_common_plat {
 	unsigned int startup_delay_us;
 	unsigned int off_on_delay_us;
 	unsigned int enable_count;
+	struct udevice *vin_supply;
 };
 
 int regulator_common_of_to_plat(struct udevice *dev,
-- 
2.37.1

