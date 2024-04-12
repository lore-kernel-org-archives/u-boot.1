Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C173DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3EE881C9;
	Fri, 12 Apr 2024 15:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XR9eKwJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA123881C8; Fri, 12 Apr 2024 15:24:56 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C328801E
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 15:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeggG2eTdUl1VQzRP8QeXysQ61GABwFP5bylwOqXFKsy3dHJ+avTNvOhLHDUB3390vrMB3gKs4e/0sqHVCH5l5DtXGeNk2cYvIyd4V3DUwe4YxfiwIs3HQcboVnBLCSwdcixTWN/UOJnt7X5N0sHqGslm+qkAkY6LCFd+/Sh5IEwexxX/AjSHtW20ETBwlO1W0NABGat0THtV/mOA38yiSa2jGratrYlrEIUCKUduSQQJrbFy9Vs4Ylr2nNWF2qCEANYty+0YQp18srcwPymvK1L9UjqGPG7u9pi0B00tif8Q1jhMhs8L9hvWl/wg/t/gnNQpJCwXz1tyIvCXqfVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OIPyvSGT8TY7bo3Vi15vbmAe6q/5uy6bXX/kgo8CjA=;
 b=CI6Oj/2iOa7O6pGHVZhSQfepCwaiNUe2phIa8aNEXzixlXhwITBqfpfIa31I5ke37GtYMFASS7AkOLf+tVc2DZ88gNcEDK5N0dWBzo4z6sLa21D4cNm6GM5dGdbhZt8742uaotWvHnEWbJesGCA7w+iDjZvQ52Acf4p8EKr6YWfNgob6KLclE/gZU5uF71B83+aUoJ0gbVXw1NLo4TyvBZecrnyg7A+tMo19b8UMXSWeGl5vYsO0+AknMN7W3n9Gj0saSqD5Ezd6mOpa9fnpPvqwF/H30IhxyhQq948+xxTV2axDElAkVGL9KPnfqXOkDoF+Nm2xW2zukSt6KKWhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OIPyvSGT8TY7bo3Vi15vbmAe6q/5uy6bXX/kgo8CjA=;
 b=XR9eKwJcBjNupwIMWEzaHNmeZCCx2m1HhQQcTyfJu6SaL0DuWaYys0EiUy7gpHvPs5dyZdcm+yRRkPfOchLQpNIfopn7Y7IznxjZeFqg5MYwKV7C3y5kt2jylqUuggdp+iCO6xW1mjhXVZPlR+G75GCV2PGFF4fwElP+tUrm60s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:24:53 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 13:24:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 22:24:52 +0800
Subject: [PATCH v6 2/5] serial: lpuart: use ipg clk for i.MX7ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx93-of-v2-v6-2-c2ad48e46eca@nxp.com>
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
In-Reply-To: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 232ee97f-91b9-4770-8b34-08dc5af3f00b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vujx7tSVTymDYwFb4BBsC8k1ogrAFQb4tZFgpmOORlGGz3likl7aAxcY61MHxU8N9enzSC3Z6WugaKtvmnNEREi+NA6iW6W1/hykfaqytc5HQyz7Hu0+KFeMTfmPj3MptrrHNmSO4xiukb1oqatZJ1UuXYI+DGTNiUzyXzamWyxfpbUGaR8OUFju4dCKAFtYbscb4KUI3Jft5Aa6MOanRaNGwsyI0PI5N3HaMtd+3H+XPZW+S/0k4wvcVwpftXjdqwEe9/XiV3PfXMDTQQZcmJu012FdXqfPVJAGayIQgnVJreCisJMIGW/9Ss8acXKmU4OB8WP8HHargbJUE07Lvj99Jm7K2T9CnaX2hRy+54rnoYMMYGygod13/bEpM3nqz8UqU9AHBjocx66nYcjj3qybQ7YKQ9zbfpLmH6ILzULdflqqd/BOC1oyS7HMXyIDjOYmwUXEEemgFfIeIBpBJFgBwFL8nkpelFfeSjx5fGejkvGY8kEUDCkYw0k/+vYzq/gwowf1ZPI4zdjWF16GwRMzH/CQXVra9/oUKCWEVce1VfexAxzY/J/1O2kKyiMiOJgpRWK2eqN4Ca3Yzo3jFfwMyGfPaC6fJLzh7mgR34ijU+ValmlcvdHcMHd0/2LctwJmV+iW/VkRp2mq0SevD49ylfwn8yTwuLH5BwnbgcWlA33phD3lZrjW5Ag9Qo51gLCiJLJ9eN3OtWGZBeY4O5Eb36WmNB2FG7uEdcr/En0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9416.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJHcmc4MVBOeWNDbUFQTkhvb05CREpyTDAwSUNCL0wreEk5VWQraW9JUm0x?=
 =?utf-8?B?SC81YlpMZTJqbmNIU3E1aElrVDRLL3B1eEE4bVVvM1RScHJWSXdXSjhQdE9i?=
 =?utf-8?B?eFM5Uzg4ZHZTaHl1bk9qZGk4RE95WHhXY3lidHpZYmVLb25GV3c5Nlg0VFpt?=
 =?utf-8?B?UnpBeEZ0MElnaHFCNlM2YUlCaHZpdFRkM05ZZStNMTl5Y0RHbDdkbDl4ZWNt?=
 =?utf-8?B?dG1mN0tVWWQvM3RlUUJLVmI2QmhUR0dNeEVCQldFam41WTJSWUxKMkhKSFpH?=
 =?utf-8?B?a1ZsdytYOE1UcWxTWG9UcFdBOVBFUE1naFZKUUN4dFI4b0pUVGtjOXJMMnRt?=
 =?utf-8?B?N1FsS2pXVWpobVNBYnpLOUpQdUtFUGdxdVpDMHIvL1hCZGdaanNZSzN0eGJn?=
 =?utf-8?B?cDZ5NnkwN2xIVUk5RnBPQ0o5TC9ub3pZdlkrY1FscUQvbEcyMzBwRXBrSDdY?=
 =?utf-8?B?U296dTY0WTBpN1FFMmNER3c4RmJucmMxdnUwSExKMlRRQXBJSjFuK1k5OUw4?=
 =?utf-8?B?dVdiS0RkY1NNNEF2ZlpxN1FnNllMUjZSbWkzK1BkVTNLVnhSclM3MmQyeDBy?=
 =?utf-8?B?cUtDRDlFTTZseFFLY0I3NVVZWDhPaGVOOTZHWVdBcTNPU2pCU0k2eld0Y09h?=
 =?utf-8?B?ak41aDhuM2dlczcvVmdmWVNQdEYwaGEvY0pjbzVhQ3BUOUNyZXRIN29hZUdB?=
 =?utf-8?B?ZHQwaVkvZzV6c1NZRUNDWjhOY0RON1gxaUpsckVYeFpOekNNeE5PUEJvcnAz?=
 =?utf-8?B?OUErbVA5Tjdxc3dYSTVweHk0cnIva3RxM3NqaFRqUGZJMVhPVDlpMlNHNHBW?=
 =?utf-8?B?RTJ2ZTVGL0padHJpR2F1cXBEbEZSVWl6T2dzQ203bXJrVVNxYnVrWENxTld2?=
 =?utf-8?B?TlJReGg4dzlwWEdsejdsbGFjVkx3dXZOQy92QjI5WVAvbVF0YUNMZWhISzU1?=
 =?utf-8?B?U3A5N1N5ODZyUWxYcTEvWjZmZjNaY3NBTlJoakVUWTdSRHlldVI1bWIxQ1d4?=
 =?utf-8?B?OE1YZU5aQXdacDBTSXBIaVlqajJPQnZBeWlXZis3d0RLd2Y5V2RKT3dSbEF3?=
 =?utf-8?B?b0RvQzNBME1kRSs0d2V1MmlWWnJzV0Zmc3d1UUgvMlRQQU14UTZ4NEprR2Z5?=
 =?utf-8?B?Z3hLZWp6ZytKQ3hzM0pJMXM2M2ZTNUV5MjhqY0hEMXJwWGQyZittamNvRWF0?=
 =?utf-8?B?OVM3eCtSY3hhcG1RaEVsYUlIUHIvbnBZYUtJR0x5MGNpN2NVTFhWVWVBcWZL?=
 =?utf-8?B?Q3UzcnFQeHBNT2dwNk1ZNmxTc1lHSGs3dVExUE5tK1l6aE5mRHBjcmlsWTVW?=
 =?utf-8?B?NlhTRUlDYjV4Sks0MHNEU3o5WTREZXh6b1g1OFVQSElCKzV4eUs1amlGdlFD?=
 =?utf-8?B?RmYraithSWk5WDNFWTlGc1FZWnBMMWRSWlBPdFYva3lKWnZkaU9OcUlaMUE1?=
 =?utf-8?B?NXBSaHgrd1BkS1ZVTlRZeUEwcW1aR3I4QXZ0ZVJDOVh5ckVGRDZ4dkJHNUcx?=
 =?utf-8?B?Y0Q1UFYvT3FJRWZWVUk0YWQ3NS9QMmlBdVByOWtUbXhSVld1MXJLMldPWHpv?=
 =?utf-8?B?cUlsMXlaRGdJSjlsU1FlZmJERjE5ekJvdzJGU21naUUwaUhkRFl6WE1Fa0lq?=
 =?utf-8?B?bm00d2p6TVB2SG1JMXVXZW90ZzIxSTl5R1FSN0tXa1oydzRvc29xVlRRQW1L?=
 =?utf-8?B?ckFYa0tDUStyT3hocnNCZCtOTkdWL1I2MjFJcVAvR0VVUlFtd1lVNVFBd3JB?=
 =?utf-8?B?elVMSmJIZTM3ZHZwVW8yNEI4YzI5Vy9nYUsyY2FaRnpEbVBwNFNwVHhyazJ5?=
 =?utf-8?B?cUdEY1Q3MUMwMHB1dE5wdzNnUkNhcjkvLzVScjlycXQ0N1pDY0lEUEhDeWtS?=
 =?utf-8?B?SzJ0SVMyTzdVZlJRdnVQTFBTcU9YcmJ1TDRSNlFiY1lVWTNzY2oyR1p3cVFo?=
 =?utf-8?B?cE5qbXU4NUM2dit5bWl6KzlvdHduY3NETXFKc1hpSnkzQkUrNVg0N2dHNU55?=
 =?utf-8?B?c1BheDFUV0I0amRBanFmd0gxOUx5YXVlNkhoWGYreU0zZ05td1VlL3BjQ0Fk?=
 =?utf-8?B?aFdSRENqd21CREFlRjNUYnFJbi80T1QzU0pzR1JDR1Q0V3F6Ymh2aEZNSTVE?=
 =?utf-8?Q?8Sdfl/Vw0J24rjr0jPfO//UUV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232ee97f-91b9-4770-8b34-08dc5af3f00b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:24:53.1736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZpWgBUW4cXfhWJWmGglGxxgCGmwxutiTs3kVbHvWEWRVfb/fI246luEFE++y7AEIAamhpeZfepqRf6QAe6ELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966
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

From: Peng Fan <peng.fan@nxp.com>

To i.MX7ULP compatible lpuart, there is only ipg clk, no per clk.
So add a devtype check for i.MX7ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/serial/serial_lpuart.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index ce08a6b4486..3f2be72b830 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -109,28 +109,35 @@ u32 __weak get_lpuart_clk(void)
 }
 
 #if CONFIG_IS_ENABLED(CLK)
-static int get_lpuart_clk_rate(struct udevice *dev, u32 *clk)
+static int get_lpuart_clk_rate(struct udevice *dev, u32 *clk_rate)
 {
-	struct clk per_clk;
+	struct lpuart_serial_plat *plat = dev_get_plat(dev);
+	struct clk clk;
 	ulong rate;
 	int ret;
+	char *name;
 
-	ret = clk_get_by_name(dev, "per", &per_clk);
+	if (plat->devtype == DEV_MX7ULP)
+		name = "ipg";
+	else
+		name = "per";
+
+	ret = clk_get_by_name(dev, name, &clk);
 	if (ret) {
-		dev_err(dev, "Failed to get per clk: %d\n", ret);
+		dev_err(dev, "Failed to get clk: %d\n", ret);
 		return ret;
 	}
 
-	rate = clk_get_rate(&per_clk);
+	rate = clk_get_rate(&clk);
 	if ((long)rate <= 0) {
-		dev_err(dev, "Failed to get per clk rate: %ld\n", (long)rate);
+		dev_err(dev, "Failed to get clk rate: %ld\n", (long)rate);
 		return ret;
 	}
-	*clk = rate;
+	*clk_rate = rate;
 	return 0;
 }
 #else
-static inline int get_lpuart_clk_rate(struct udevice *dev, u32 *clk)
+static inline int get_lpuart_clk_rate(struct udevice *dev, u32 *clk_rate)
 { return -ENOSYS; }
 #endif
 
@@ -479,19 +486,22 @@ static int lpuart_serial_pending(struct udevice *dev, bool input)
 static int lpuart_serial_probe(struct udevice *dev)
 {
 #if CONFIG_IS_ENABLED(CLK)
+	struct lpuart_serial_plat *plat = dev_get_plat(dev);
 	struct clk per_clk;
 	struct clk ipg_clk;
 	int ret;
 
-	ret = clk_get_by_name(dev, "per", &per_clk);
-	if (!ret) {
-		ret = clk_enable(&per_clk);
-		if (ret) {
-			dev_err(dev, "Failed to enable per clk: %d\n", ret);
-			return ret;
+	if (plat->devtype != DEV_MX7ULP) {
+		ret = clk_get_by_name(dev, "per", &per_clk);
+		if (!ret) {
+			ret = clk_enable(&per_clk);
+			if (ret) {
+				dev_err(dev, "Failed to enable per clk: %d\n", ret);
+				return ret;
+			}
+		} else {
+			debug("%s: Failed to get per clk: %d\n", __func__, ret);
 		}
-	} else {
-		debug("%s: Failed to get per clk: %d\n", __func__, ret);
 	}
 
 	ret = clk_get_by_name(dev, "ipg", &ipg_clk);

-- 
2.35.3

