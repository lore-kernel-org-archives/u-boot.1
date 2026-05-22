Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70518CD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 07:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0076184713;
	Fri, 22 May 2026 09:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MUbgjDBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6CF84713; Fri, 22 May 2026 09:12:13 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D757D80287
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OctCkak/VaKGW47a++H6iWdEueL3CbUUImq56DJH59+l9jBXt2Tn+PHo43ycqBr4FXutoWjfrniptNTOcA4lHs+7CeS4SYXSvtCpfpEZ2c4HEuP61c2W5ee6SIQAQvUzRwbCeI75jKy740VHt/5VAIIHfZQL4nKz0Pqrwp8YmWY3nZjM30y6pEwkNdmw0Ok10FJqNbqhzkyGBJX0VwufgpuNrX+HjJv6skKIDxn+uMMAVKIUwhSJplT0MjjBuAA0LdHdapF8kub7xJ66lJyEhXQ/NCeV+RpnpP9DcpbE4ZbNlF6UHgHmhgDiGWTqr9ewICeG0MdAdj4MJ+a/Se/7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruK5XXg51sqtqhqztCPGB9JaiWKT+Wj1tiryKfKxSKs=;
 b=IScJeQ+7QRPysZhVVGwv4HibmBYr6HxSgcvKaAs2SszYufotufadesCbmBunDHUuISms2qjwnOzuRZP4EvI1MU7L9RM1q4UexO/YvLRQLC3SjnqN46UgJ5Hyu9IauITiT+Kt1qBZDutx1Q6AiB8LISnT3K3X9UsADIw+DRyYxEtlWV36qj7e6U/7OfVWZwo4UI7TpmfYBut5ajvtqEmJ5Oqh+oqjfAHeRr60G5y2BkZnZPX7u8JW9KQVfDRvmvPmoQOWOFmMIGvOZqeirIzbWQqUimL+ZJwghVEuwroqupynjQThrjFt9rzwMZMrwknp1hX/gUYhNgT9tixgFA1Ddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruK5XXg51sqtqhqztCPGB9JaiWKT+Wj1tiryKfKxSKs=;
 b=MUbgjDBwODBmAhVCf1ybBsTxRoL+1p1ljE0eD/YDpuJOxBwKINl9KKA/1RBlyalUPGjEtsnPnVagjrF/0rBJJniifAX2R6elD27kJugcTIpQjK2EOQivwgADS5olA0ScxSl89lngZW162hTEQL7my1dtM1MtOWhpTqehNaPvvZA7F9b0fo5gL8lgvUMt6PsXZnB87dapnDpKk6CleisfMbQgOKtAYGwii9h8NhiM/iBbPbMwyQK+/9W212vqmgeF+TbRId2pwNZgxa/76xoeBrqIXxZxvm9vaI0z1GslRPY1dV0SxbYwbFYD4FvbYxuqskv/8VOSCjc2kpb/bUvQFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by PAXPR04MB9008.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 22 May
 2026 07:12:04 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 07:12:04 +0000
From: Ye Li <ye.li@nxp.com>
To: jh80.chung@samsung.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 jonas@kwiboo.se
Cc: festevam@gmail.com,
	uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH v2] power: regulator: Fix power on/off delay issue
Date: Fri, 22 May 2026 15:14:14 +0800
Message-Id: <20260522071414.1155344-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::11) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d70b80-3814-4af3-d50d-08deb7d16d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|42112799006|376014|1800799024|38350700014|56012099003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GN6pcZ0jMm96U2RHE6UrvA1f2rx/bF85qWJ4MDlr5RdlqZEAtADw0WDI5+mn8iJq/bAxdjhwM482jAxHXDdyNKqKBdpYeCYP0JnedSb86RLnt++5KR+XTkTjBProHcNzQF2CsbxMIhMXFaRSGSQrmlBDjmHHJ7m2Gg5MGkPF5gVL98FsKvcT5b8gIL+1x9exYFl0xXPx/6kP3RYeFwu1JNg/zvTlSi4BjhPTw0feg1Nw6VYNJGXVBZvG1TZBp45KbTT42nNMBfLQegwjEirkcA8bIHvDwgaue3LZiya2IIZN/pDMPNC8FAlPrRBxqB37+oNr/jsT8KDJxSH2G/c1dAvODPT7ZP4dZc+KS/yHLhCWrOe+reMHwfkgd4fYz29EJXYCgLCiJUQZiilWzq2jiu0jclToIjy5tJ7A0dDv5zZxCMIREj2P++T96NuxMHN7Cke/ufGI/rJ0HPl8PE28LpNY/WyBFA9tZker3x1aK9MG1uz9z3s7ElmMsMXN8qwPPgFeN6jPeufWGa8N1iACree89y9+RV5jWXqJwx4P6qjCJto1ANS0pRmCOCvGIuCcyV4ABe6LaKcoXar8yhgsmxsj/dT7cPr+LrFaRzsdL3T59X4ooPD9VhB34tj1x6K+UMdql9cERm9Uw5N835Yplv+OdI/WkBN876bGPx3peNX9MhlqEUSBqP1M8QhQzE/QxHeetC9eiC2uFkNKAzdZXdOVe/PMEntFruaUsBukKABn7z/Smg2lHAHrqpQfX/a9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(42112799006)(376014)(1800799024)(38350700014)(56012099003)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZRuLzeaNUPa1H3LQed4tMIe+JfUhmLJFfnwFCP1tNUFeAQ+/WxSJvRPU+Vw?=
 =?us-ascii?Q?szPBuLWfv5FsmwmSkHlhHnEOaCkEa4maKnJVx7mNEqcWJD70dM2RoRG4AQdO?=
 =?us-ascii?Q?NIE3UlnUOvLANleTaT6aFp7S+HS9+ZS7rZNY8NqJr8IXVglOthmkh90BdP6U?=
 =?us-ascii?Q?ljNoaUL9zL4kTySwDlcR7Y3JEDn8Qs1EkqnYZuITbzogAmMgaKRAj4pjnED6?=
 =?us-ascii?Q?3K6yQufZZPeA8dv997Pe9xM2haeh5+xxCOpAbNWkWqeaeF9oOVis+VWMp5ZV?=
 =?us-ascii?Q?2NLfjhnX+6aJ9a6brU7CbG3bbnkREkOzbJsZb/myQPNopQnPIW556/wb614r?=
 =?us-ascii?Q?Db5z63Jl8P1EeJibJn4cGAi4YWcr2SI999BuiCgKYj17GRz3HNpCyQYb3tF1?=
 =?us-ascii?Q?omewUcFD1UTItDnKqZiyDIX17q/b+XyxQcNOBDA9oKFSRP2mlQhn/35H/fCh?=
 =?us-ascii?Q?wFCfMbjl7gUZ002TgnysYpL2RsQS+35/FzxUKsN2h+opxdHcIgGLa8AVIuj5?=
 =?us-ascii?Q?ae0YfIYOpOhEdVyFsurzJA7k2eTcVtwV0eyQpH9pzCvtWdYHGMsnQBfTUiBG?=
 =?us-ascii?Q?80iBmRXAELn1RAXtgNLfuLSV0bCpvYDByfuMy7FIgG3RXPzaQbuDzNt7+UWi?=
 =?us-ascii?Q?pmmit7/uE0WwdOf6P27ef3gevOFLHHHQfCMkJjo3Ejwk1gb3+gRy8YmDCbOr?=
 =?us-ascii?Q?tuCFDGXlHaEjqFT45dIBckFPkckpuE+qM2gDoGWORGIlVG5G6km46Ta3enNe?=
 =?us-ascii?Q?0x0xkkvm5+aAPE8oPZUc5hBsyKgvA9S3lD36gEW9AYEd1pcmvxKAJOoD5Wz0?=
 =?us-ascii?Q?YBdeb2MARzEx6h3177s+uZMu8iW2caXpz1z49ZPYsUDGiBn/jbtV3fu5LrJO?=
 =?us-ascii?Q?0MfJSNsgYvjZkBY6rx6UtxV3SpfoAF6N+0GYcXqRiiX1RZwxdKrDOOjaDL/T?=
 =?us-ascii?Q?Cq0YnWZYxN/rG2wWIAQ2JkZkkRWuEf7FS5erfUC4GRtimY87FnYS9FbNHqXc?=
 =?us-ascii?Q?zm8O7OQS4NPO8ZF5y67UX2/G6lwkmvwGRSstr4AG+AAVR3uhlKeo1+2mfyXP?=
 =?us-ascii?Q?y7QXKiVtAC8qSAMjgwzDdvKa/yCIkjABmPHQ4hzxTVPH0DMoBRcJyv4zAQx9?=
 =?us-ascii?Q?Icj/Af1SPXVdzYwA6H5k6ToSG1XDJRLTn0hPS2FB9iN7xWWb9cGm40CPinDK?=
 =?us-ascii?Q?HKdEUlR3OXYnyiEN9seeaLrWaS1ljFUBcm37GFRTtKExkdSpg1VAO61U2hZI?=
 =?us-ascii?Q?ff83gtBkAExnvv2AzkpaKL/e6/xgCHF1cjS0buUjKEq2BWBZWdA7mJleuX1O?=
 =?us-ascii?Q?2Pu0g5/HQKJIcv3yrC1wuGyHdLl0s0TplH1QTemNZxoRdBabFeqgH1ZoRsRo?=
 =?us-ascii?Q?6UL7PKc+3MjBSzyGmkD0Pazj2pjqrTVfFlYkdDisvWtNxuZZDI3ydGzQXGZc?=
 =?us-ascii?Q?+hJz/jR9C166/26yrMUUBTaZ50jXz0xOeg15ahbh8sXxVoYMV3oc0wWY/TBL?=
 =?us-ascii?Q?mE4gFFZusOHwwf4xO13vLqywg3/+a9f9BHJVU2aeYoGSuKGjO8ay2UhjpGSX?=
 =?us-ascii?Q?s6DUZi5DAKpYaqWVLVNQBMUI58IL2u/HOhP/tQwF4A3YOrNB8Cts8Kzyd80X?=
 =?us-ascii?Q?6TuZ2MDTDfayaK4NInfSetx3IjZMWv1G0Ao9CQr7Y16WOG9/ybFvwRM7M01A?=
 =?us-ascii?Q?NHbJ7JWzCwPY2SV/AX/fCI3QhirzfGtUGU1apxjWqFKWB6Qm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d70b80-3814-4af3-d50d-08deb7d16d56
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:12:04.4563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5S2JByrtiaNNQlBZMfUFfU344laqPXdjaAozKUegTN8uOyIheyinx5AYvCEu1kGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
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

Move the off-on-delay-us delay before setting GPIO active to fix the issue.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
Changes in v2:
 - move the off-on-delay before enabling the GPIO

 drivers/power/regulator/regulator_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 85af8d599ad..c0387eff4fc 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -87,6 +87,9 @@ int regulator_common_set_enable(const struct udevice *dev,
 			}
 		}
 
+		if (enable && plat->off_on_delay_us)
+			udelay(plat->off_on_delay_us);
+
 		ret = dm_gpio_set_value(&plat->gpio, enable);
 		if (ret) {
 			pr_err("Can't set regulator : %s gpio to: %d\n", dev->name,
@@ -97,9 +100,6 @@ int regulator_common_set_enable(const struct udevice *dev,
 		if (enable && plat->startup_delay_us)
 			udelay(plat->startup_delay_us);
 
-		if (!enable && plat->off_on_delay_us)
-			udelay(plat->off_on_delay_us);
-
 		if (enable)
 			plat->enable_count++;
 		else
-- 
2.37.1

