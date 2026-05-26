Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A045CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 05:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D9C8404D;
	Tue, 26 May 2026 07:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GiCIn6SM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB8184671; Tue, 26 May 2026 07:22:36 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3571F83FF5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfqSrarUQ+LrAocswWE/lNG1Xa4CFrOWBPXZxVUbAEgPfQ2HEDocw2g0DoSo+MXO/SKBggTr+BTVikOXQDmrnf9zOHReqhauGbMNGIenMQao6hiYi0VfsYS9yYYhRYe1/BfMKK6Rqa5kYFX4cb+COVpghL6kT4lTKVNLVNQTUqWoEJiHw91yk3l7kD1suHZd/FmnMy2m6joP2IYChbJ8txO1GlCl9i48PtaB3ewDaBA8JFBFH2k4EjveVXmQCbse3UjdYgpJgQCfXaUqjhmHG4Q06zfoQn7aP9kYL0gWCRctmNYi8zQ0DxWWX1f0ueQEVjgw61xWyOMd5Fa1GS8cZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3C4CjjFnpIy8+n4eEq4QO8xMdZ9etQO4joNlyGgB6o=;
 b=GpPrHBhzVFQNIKbkuyxDiUcHWCv+zPoiAT13/VxIC0XJSjT5/gDX0+yZC1iVe6q0BZr/0wjhNAi0Zrqg5YH2RnpQsC2TL8ip/3XWB73txqYmpYcQ5F1mmAnhqwMXsfoohzIV9yeZ8NrYmYw214jswY5RPGdHdINfIj6edP2Ug6fEoB9WxheYJ4o8UtMit8kHngQBqB3r5DEe8Eu4c2OUxKTTUvJ1H4sYKWI91SGPaNhtvdpTdrDI3364Yv+R1tFpq5i0+SbNnk8OAcAq78cd8KCJbgHFOccKGu7IZWSBaoyPVEDe5G2nJ67MSTMMdBUKtR/4vuLfFM9v3cTdgTnGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3C4CjjFnpIy8+n4eEq4QO8xMdZ9etQO4joNlyGgB6o=;
 b=GiCIn6SMA6tLGHyXolsaeU1c2ZUDzNLRqHdW5Y0kEwOKAEDkjiLC3BM5gQU19cC0cKHeXnolmdbVG8hvK85cpqGK2Tify6xcj1tWYGd3I8EeqeIe5Zd7TMCjkc2C3MrRRRuGV8QIeiUVXFMiC/5uBMGkVJvfjcLjPchmFIN9nWtccMJrnacwqENKsFn/LE4pJcp7PZS6NxthFzMnF1EO1Hzbjm2ySNkN0W4+eFrH6UnU/kJPlvHq+WNlG9ojVanrO9xUusjgIS/PXTkXdaSBJ20Oz7OemzajggtuS3Sg6/oxZCBhICorPXNXRbdwkfjnj13S4iaSfY6nd4BdFu8+oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AMBPR04MB12287.eurprd04.prod.outlook.com (2603:10a6:20b:730::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:22:32 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:22:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 14:39:14 +0800
Subject: [PATCH 1/3] phy: ti-pipe3: Use device API for DT parsing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-phy-v1-1-908ff621dea4@nxp.com>
References: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
In-Reply-To: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 George McCollister <george.mccollister@konsulko.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AMBPR04MB12287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3acdd5-a8a0-42aa-d211-08debae6c9d9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: mHadQnnarqyFpGeWlq0rNblCrq7fVz0xiqtM+tIzaljiftkA5jFXAIF2cF51wquEdEe2smg3XDKSMRxiLictY7Fy34BqV6o8sX34KO2XaIFpWoua6F0a3BKA+erAvHW+6ntuVSzee1NpFQacv/MQZgj52z7AuAPt9/MOK0RRkZM++WrzgbrLF6/042rKIU1fUPNCNAn+76OMkB36l2WvyOjn8ExwPJaZb3NAPkSN3G2PLOvJQbj9vHxbb4a7P9XHE/Culg7VPCf7JvUYwSGe7XdTwll1LyU0I81xoKNDhCscKAJ68tEkkGtWgSNQeViHG0F507MXw6wdujsZ52hcLX1uFkgpbUrzGYUUhVDAnlzI/4PTy9sp0XkMxICi8INL5A+dIcxqbND5NRBAH5jB6a4ZgSChcvHQ9B3fRU8jR2e/qzzDrb7fPawAVB5mOUTsp+QsM4hs8TALTI74AejcSDGneLHDIvxenfLVcLT2BklqgS2n/toD56aYscfTJ7wL03eXopM7R9O07w7oLF3nYQa8FK+Cvs5Xn626x3gQF3YGUEVUWUJvkKlKvZKXt3mUYDNd6KUCXni2ukICjN/fiTEWLk1VjPc7M4o0WUxRgGr3QeCBqXge8G2Je9V0QYZeTf8eW6w7SXWsL8vVzeX8+OLd556CM2Sppl+9MJ1VIg2bsYtyGRyvX/tDsik+hyK8YhglSNBmbcA5qpgNr66HdAxVYTMz7W5vITQYhvTxVG3g/hkNGiv/6fGYiGZt4qQ+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdlL25yemJpRHAvamtYaGhGNStKY1Zoekdpck5uVjJTem9lNGUxcUc0czJh?=
 =?utf-8?B?MzJxRXNrSHdPK2lrWW5pWGJvUkZiQ0lmMy9vRnpBbDFmL3hLYnhXTTREbnlE?=
 =?utf-8?B?bDNoOFp0OXpJQWsyWkhEUDZIKy93NDVySkRWWHBNaUlyRnhyVjVlaWNqL1VU?=
 =?utf-8?B?WHpUWGQwU1N5cEd4L3pQdDVLVysyM0VhRjNhTWk0TUFDbkRPTERSZWN3d0lq?=
 =?utf-8?B?OXNWLzJpeFhTaTNSMlVpdlIrOGwzN0tzYVBoRkRvL2Nsd09aZTdQdWZEZXZQ?=
 =?utf-8?B?Z2p3VXVOZE1ydmJleTQ5QVdzNlNJcFg2dHBuWmhvVXZZYTZxSGVZU2NBUm1Z?=
 =?utf-8?B?WU9QS0xjNFUveWpycGZQc3VQYkV5ZGl0M3ZZN0ovYTBaenp3My9td1htSU42?=
 =?utf-8?B?ZTNMdThHV2wvYVgvMzB3aGsvUHBycGRvTG42MkN1eDIxc05saW12ZzVWclNW?=
 =?utf-8?B?ZjlEUFhVZFJaT2g2OUYvZGNuSk5wU3dwbTZxcW5hRnpzSGh0ajJhWHpjY05k?=
 =?utf-8?B?NVVkZENwcTUyNWpFWXdnM2VvcjE5a1krRXEzbG85MHFETDNuQWlFMEZhZkZi?=
 =?utf-8?B?UE92SjZxNlpad01CTWhRcUExcllqRURmSEcwWElPL2thZWNRSDF2N3NlaTk0?=
 =?utf-8?B?QnNrRlFRRUhQUFZ3TnI3b2dtamR4aU9tUUttVDVRVXhQYzF4SU9LNHVBcXhK?=
 =?utf-8?B?b2hvNGVKRjFoQmlnc05hWTd4QUdib1hsTzFlYjlaVFdnaXBZcDBleXhPMjhP?=
 =?utf-8?B?Yk1razJGdGNtczhrMEtVNzNxUXhMZFVNRXBMUCtUeWhBZFNYNXQxZGMvVEQx?=
 =?utf-8?B?WDQvdmgwSWQ0VjlVL216eEZrTWthaGkzNCtsOUNIaldTNDJjNHFuenhQL01J?=
 =?utf-8?B?eFJIM3gvQU1KZDZXQmNCZ3ZmdXErdk1pc3RwSE5wRG5acDhleUN2RzRwUXl6?=
 =?utf-8?B?K1ZnUlErVVJDOXVMcUk1SnZCb1ZFT01oMXdCaGpPZXZaQzZhdHhZT3RnekRB?=
 =?utf-8?B?R3RNUFg0czJ6S2k1eFo5cGdoTGswSjZqQ25pNWFzYlJYSlJUc1VkRGdmODd4?=
 =?utf-8?B?bmk4blVwL1JwOWhqa04yVnpmRzk1NWZoZkxERjFmSDRKSWpNZUdxYXRIeWZs?=
 =?utf-8?B?OEFhY1NpaEdOcytDaVVPbmdXQlVPdUw5SkEyWkFQNVUxcGFJUSs4MXdza1pW?=
 =?utf-8?B?OGMvMXBuODRBSlB1ci9WOVJWTHNuanJJQWNCZlNHL0pGU05Dcml5MVdKOGNl?=
 =?utf-8?B?Vy9UZ0E4L2RhT3NDRmNFSlRNSUc1aHQrbmtGem1GT2R1RWVWS2l0TVBHUkR5?=
 =?utf-8?B?bGNSZXZLQmlIRFhTZlNVUnhaRVlFUzR1OVpwbExEd3pTZEh1V2V1eFhDTCth?=
 =?utf-8?B?b0pNSEx0OGZrN3ZEYVcramcyRGdMRHM1TTUrbGVGNklwV2lLNGwxRmM0Sno1?=
 =?utf-8?B?QXRqcVJZVzZmcmcrYWlRR3RxZEsyeWt5REFicGhiT0sxL0FGaTh6ZDVOWVIy?=
 =?utf-8?B?SVo0SFBZdldneGFrWGFnb3FKY2RmR283cjlZbjF2RlFRQkUvQzArNkNZaUVZ?=
 =?utf-8?B?YTVxN0NEQytKUFFBWTRqQjdNMFFYa25TdXJPSFJNbzZtZHFaem03aFNHNW92?=
 =?utf-8?B?emNGQ21MaHRlQVVSUkpBamdpTG1HWWhQdGlkbDQxMEJRVWpXZUlGZ3FPdDlC?=
 =?utf-8?B?dHZ6TllJTEVMYytpSm9GeDFhMUF5S0RkVFlsOS8xSjg2TE8rUnlxMFV2L3RY?=
 =?utf-8?B?Y1o2Q2dKUFN4a1RSeEdCZm9OMXRFL0tUaGcrVUpXVkZQU0pheUh5LzJQMFgx?=
 =?utf-8?B?aExId3IxQjk0blJ3c2VJZWNuSTA5cHZQT2dHSmNud0VxNDdGMHN0SzJCamNU?=
 =?utf-8?B?SGp4YmllYlRzcThrOTdnck9LZU1SaVBoVkJCc1B2T215cDB2U3lWWnlTMll6?=
 =?utf-8?B?WnVSYUhCTlV4ZjJ6Ynlib2R1YkJDM2I0cWpPdVN1TzN0dFFIQmZ1ME5FUmtO?=
 =?utf-8?B?U0tJN3hzR2hERjNDQ2tHN3N4V1ZPdTc2bUROelJXTGdJNnpjbmZlVllnUFJK?=
 =?utf-8?B?Yy9BS1Z5RWh1bDVZYWdZVVhVS2lGMW9Zell6NU5LbUFweVpzUWV1WUFlM1NP?=
 =?utf-8?B?WmFPUmJRVjRiR2F4Z1R0clBmNjZDTWpycjlkUWIvUForWUoyaWhYYVljdGNl?=
 =?utf-8?B?SFZSa0hFSFFqRlFhUlVITkJUU2FOS3V6TnhGMnpuUWZtN0R3UHNJVDFVcjhZ?=
 =?utf-8?B?MG54TUtaams2dHFWeDJpTmo5WGUrOWM4VlBvaEFsQlRBaVN4bFBHL0FTQ2g4?=
 =?utf-8?B?V0FtRGYyOW1vbkpuRm9JbVYxYjlFd1MzSkVzMEVJaWtDOHRIQnpZUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3acdd5-a8a0-42aa-d211-08debae6c9d9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:22:32.6365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIy/NMOLD95GYYeuRx+bFneYuLhVQTRzeP7+tAxtXg33MhDrhy3wDtfiMr+PfYaFznpBua1BiYB6UMEFGAuSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12287
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

Replace legacy FDT parsing in get_reg() with the device API
dev_read_phandle_with_args() which removes direct access to gd->fdt_blob
and aligns the driver with modern U-Boot DT handling.

The offset is retrieved from the phandle argument instead of manually
parsing the property cells. Add validation for the argument
count to avoid out-of-bounds access on malformed DTs.

Also switch from devfdt_get_addr_size_index() to dev_read_addr_size_index()
for consistency with the DM API.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/ti-pipe3-phy.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/ti-pipe3-phy.c b/drivers/phy/ti-pipe3-phy.c
index 62f6cc2bfbf..080016ba417 100644
--- a/drivers/phy/ti-pipe3-phy.c
+++ b/drivers/phy/ti-pipe3-phy.c
@@ -6,6 +6,7 @@
 
 #include <dm.h>
 #include <dm/device.h>
+#include <dm/device_compat.h>
 #include <generic-phy.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -428,10 +429,10 @@ static int pipe3_exit(struct phy *phy)
 
 static void *get_reg(struct udevice *dev, const char *name)
 {
+	struct ofnode_phandle_args phandle;
 	struct udevice *syscon;
 	struct regmap *regmap;
-	const fdt32_t *cell;
-	int len, err;
+	int err;
 	void *base;
 
 	err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
@@ -449,10 +450,14 @@ static void *get_reg(struct udevice *dev, const char *name)
 		return NULL;
 	}
 
-	cell = fdt_getprop(gd->fdt_blob, dev_of_offset(dev), name,
-			   &len);
-	if (len < 2*sizeof(fdt32_t)) {
-		pr_err("offset not available for %s\n", name);
+	err = dev_read_phandle_with_args(dev, name, NULL, 0, 0, &phandle);
+	if (err) {
+		dev_err(dev, "parse %s failed: %d\n", name, err);
+		return NULL;
+	}
+
+	if (phandle.args_count < 1) {
+		dev_err(dev, "%s: missing args\n", name);
 		return NULL;
 	}
 
@@ -460,7 +465,7 @@ static void *get_reg(struct udevice *dev, const char *name)
 	if (!base)
 		return NULL;
 
-	return fdtdec_get_number(cell + 1, 1) + base;
+	return base + phandle.args[0];
 }
 
 static int pipe3_phy_probe(struct udevice *dev)
@@ -471,7 +476,7 @@ static int pipe3_phy_probe(struct udevice *dev)
 	struct pipe3_data *data;
 
 	/* PHY_RX */
-	addr = devfdt_get_addr_size_index(dev, 0, &sz);
+	addr = dev_read_addr_size_index(dev, 0, &sz);
 	if (addr == FDT_ADDR_T_NONE) {
 		pr_err("missing phy_rx address\n");
 		return -EINVAL;
@@ -484,7 +489,7 @@ static int pipe3_phy_probe(struct udevice *dev)
 	}
 
 	/* PLLCTRL */
-	addr = devfdt_get_addr_size_index(dev, 2, &sz);
+	addr = dev_read_addr_size_index(dev, 2, &sz);
 	if (addr == FDT_ADDR_T_NONE) {
 		pr_err("missing pll ctrl address\n");
 		return -EINVAL;

-- 
2.51.0

