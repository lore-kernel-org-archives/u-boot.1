Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04047CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C728491D;
	Wed, 27 May 2026 03:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DgOvD8Li";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2F78494B; Wed, 27 May 2026 03:19:04 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2D3848AA
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8ZbuVlT08h4iOA1jW/he+XAFg4QctH17CdPvokgkeJFATKV4BGlYv/cNV+iZdDA8L8o40LzqAsM3S+wF3a801PHCnkypq8a1j0puBZQwCoyTnQOJxz9hk4NFTZkEd/27xBJDA7TeNGsv83r4L55OTkS0wzdFNl5OxOO5pAGH30xfWXPXqs/d0VWtojsUnPFPtKHIwTGQzAbw5RiAA2H0t9sVG5zJeBVbHdPwtSpbrtjMpNk7l/c8WA7+Sp1RPIjlXZh0n/RL/VMPvSR/I6NGSAysEwVUCesbtNy4VxySDCKfjdGzJRgXbBDVGj6DLbE5Zbu1tyTb4WJ9S0J9FUMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diXKnunJyP1Luj3KHnm+LDIzeUXMs0gTeQ/zRTobB5g=;
 b=eYzwd88CVBXzQFchWf4FxEXQtADj7R3J0GAbK9/EYJWcl5hV5epkLq52OinDGqFA2+HorXjQFhQrqdcGrtGe0tLhG7eA+UFDMPa+BKB7JacqM5/qYpuKCTWG0+9RqpdZzRUodejUCy9k+t63bc4C2tUjgWg75NrMcASskIFF4zvYLsVsTeHLkDLYcG2oNfJPLMjnokn6tLgPYbYMSQDMiqNGQpSUKPqCAGdIk+xGEsRlEokQ/IAl5+lYn2XH6HZ+bPAN4Va5EIGOCtOMa7tyRvWbsJ4cedWhrlz9JdRrK45fZjKjCXbCqM/lFHD+iifEaFcW6aPmX3OvzLgiQuOesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diXKnunJyP1Luj3KHnm+LDIzeUXMs0gTeQ/zRTobB5g=;
 b=DgOvD8LiHREbSFv24pJNBT7wd0mHwShL4LRDoK9jx1iOJecyJgJVbNomaE060By+O1PDOsvbhUZDtELO8d5rmHQJHdm6DziSr0oGKMMSQtLH3S3cggLrqfM2ZHqS8o5AlYoF6nXJnVoq8Qqem4aDtDiojy3hTYVWvaaYSTLAunpjoL70nfs6dsy8RWePd3HuJvmemm8YSMdQJ0cban5x3TY6Zzqr9rmBNYCUKyQUwUygAfTWHzXbwp2pIFMXstj1589U01n+BCltjy5GsrTMl1wXaa2pF0YXqZkv0gRyXNcB/xwd7zCZ0e+sCx3uO5VAFe098zm7t9Cs+YaOTzDDnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10208.eurprd04.prod.outlook.com (2603:10a6:102:454::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:19:00 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 01:19:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 May 2026 10:35:25 +0800
Subject: [PATCH 2/5] spi: cadence_qspi: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-devfdt-spi-v1-2-37db1f6c168a@nxp.com>
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
In-Reply-To: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa11384-555e-42bf-1c3a-08debb8dee97
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3tnXdEm8WcC+Y5bh36MwMQxjlgOjS2xWK0lcmHpTSHQORd1Tv1uWDSFkQicZfvWuakq7rqZOar4fxsh1uN/L0RXaohw0Q8ejgr3mdptSDbDuZLkOeeotG0Z0GT+QMiXi26Yrayk8NX2kpauEgobelX6tQ8p220k63viyLSnkACk9+Spi2YL69DP+PFYIyNo/cpaIgSziSdJUe2Ki2lXtsVbM30Glx8OPL6AP4/cNlQ+jEpLO9KN2g0mV+Ia27q+Epp7fVPfDIBnr1Hsrj8Eu09nJ0U8L+u6BDuD4Qgc1bpjvVhnw9RMXs+c635uMcBNHAusunaLLV+yfOozTeN8IIWJb+X9itCosht1hrTE8doyK2/QrRpgPpefCnGWWOWyO/cdS4cfjc0TBkCq8cVUbky1k4k0u0QCwdmeY6e9pgfjBLW2RzIZ4vhaDv2s8ZzoizKPu019Hb+acqX5a519b3a2Di49ABr4RZ1+z7C8p8mZGX05gVMQVlvIyzmJh+FX3wfYL3AxeLTOQK4S/NlGZsZLBVQmvqTnxqYsF2JqwMp+DMZQLX5qGQZF0ABjd86r8L6P9fxTvZu4egqn540c/sq2INpGgsRCRNWMcKf4iK6R9216hXaFpGmMYCJQX4sEqaoag6Lf3gcaa5BBCXjRU7ZaghU+QZfSXT7Ru3ECS9eMIEajmupFuCprMsOwk9vjtt18BcP79gQI/HcunQGPBEO74HRN0MsGDZ94M0F0hAMMNiWAQIhG1kHFOGBVdqkXk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU5URUViQWZ4SjVNT2NIQnMzSm5PNWRWdGV3ajEvK3IxbVNqeXRQQU5KNGZM?=
 =?utf-8?B?dlUvamwzclA2alhHS0F5ZEVFcDg2NTlOY3owdDg4M0pXbXQya2V0T3VtRGM3?=
 =?utf-8?B?Nkthanl4QStqR0hocXJuRU1mR1VZTXhFbi9FRzg3QW5SZ2Q3RWZkN3V5c3hO?=
 =?utf-8?B?V3ZXSE1pdHhXVStpRkhjYVhvTm9KT2x4cSt1N1Rqb1o3NkRRSWxKc0g5WHFr?=
 =?utf-8?B?d0IwU0REZDFyYmZZSjJZdlo3c0FmUWZmeTZZUmE3cklUU2dBQ1pTTG9Sb1lF?=
 =?utf-8?B?d0ROUXdMSlJwM2xweUZzWWhvWXN2MHFjVjYyaFAvZTNBZm1FWjdwMHdVbG5v?=
 =?utf-8?B?SWRPQTR0WGt2d1g2c3JRSVpQMk1CK2ROaEtrME0yMm1LZklWdzVsWTRKdm85?=
 =?utf-8?B?MFVqeU1HOFlSVDlSLzZLSllpeU1TdU5SVllVMmRQVDFLQktHMU9MYWF6QS9r?=
 =?utf-8?B?VGtKR0lLMnhTbVJHa25mSmdNd1BpZXlQR2pVSmgxOU4rRXBvN3NBdFNHYWFp?=
 =?utf-8?B?R1NzdUtUMzFDTDJFWjJuYlhwZ3VKdmRzd0x6TTk1TVZqZG9WMjdsd1BoYXRu?=
 =?utf-8?B?L1Mxb2NWeVRxVzQwRmNwMHJXMXRJNXd3UVJoL0JGYjdCQzNrUldrT2VESzV5?=
 =?utf-8?B?b2p2NENGVE4weThUSWdCOGREQWhvNjFNQk41U1dwOTg5alQ3QkJCaHdmRFpr?=
 =?utf-8?B?ZGd0SFdaOStOdUloZmxwdSs2R3R0VkpYRW1MejhJVnU0SlBPTTJPNDRiQjZv?=
 =?utf-8?B?eU5waWFSM1A5SjhkTTBMakRZVkpxRUYwdjdqaG8vTm55ZHVVRWI3Wldicm5J?=
 =?utf-8?B?S1kzK0ZDZGJvVGhWQTYydVAwdTZ4U01iMStVd1hITzZmb0Z6NkNMcHgzd2F2?=
 =?utf-8?B?NmovY0xtNE5qTkJrTzBXaDVzWmVEMXpCQThHV0NjU3RIckFsejN0c3pBYkRh?=
 =?utf-8?B?SVR1TmZMdlU3NDlwdWlLTWw5T2JuTnJxWG5qUXJ0bjVEeHpJeXJlbFZSalli?=
 =?utf-8?B?Q2V0TlA0bU1aOTBWKytRakFHNEh6MkhUbGxleG5CelZKOFU2S2lpM2JzV29U?=
 =?utf-8?B?TXZidWwrZFFucGdueXhyUDN5Z284eHZFcStBWnk3dlJhWXpMQUlrZlg5WURk?=
 =?utf-8?B?QmlSMm9qNUlSRlFWL080WThJRUJOMU9GTW1uQnlPTmRDSnhmR2FwaHlEMzdO?=
 =?utf-8?B?aFlnWDNCaTdsUkFyZ2l2SEkxais1cDlodWxxNjNrK29WWU5qdjN5c0NwaHNG?=
 =?utf-8?B?cEc4TXZjbTdLeU8vaG93UWo0YlA2Qy9iVDg1RERTUDExWWpOWXBRbW1WN3NN?=
 =?utf-8?B?TXNqbWNyQlZUTnJoQkVQQ29GSTJ0NmtBZTcxRHBVVzFCQmxCeEh1YmRHQTZL?=
 =?utf-8?B?QnIzTFlzNGNoaUg1bG8xek9tb3UrNndFZmRXeGdsTy9YMTRlSDZwZ2xkNUtH?=
 =?utf-8?B?ZHJrM3ZHSkc4WXJ3MWVheFlTOUwvZnJObWoyOTZVOUl3eEZMTzlOMVQrRGMz?=
 =?utf-8?B?VlZXeTNQVFhVSEJURHpCMXZwSjl0SFAzMTN1dVNWbWFodTdOWVdrOFdhZGd2?=
 =?utf-8?B?dFlEdWNLbnFGRVJQeUZCVHNqNUxoVXMzT29NWmZLM0lyc05nSU9oNmxIZXRJ?=
 =?utf-8?B?dEs4UEFIVlowaVFDWGpZSjNjVUdTZmNYTEVuanJ0R2dCK21xUkhUWDBxMDlF?=
 =?utf-8?B?QXpzNFZpbm12Y1NDQ2tPMkVRdTllTktudmlpcEFJcjZQcHJSU3JSRW53bUsv?=
 =?utf-8?B?YlJBcndzK3JTeWNZdDcrNW4vUFYxU3FNbTd1cncycTdOUDBTUU0vTmpVeXRN?=
 =?utf-8?B?UFU0NlhETytUMFVqVENKUWhrL1Y3OU9ldlkzOVIrSjZVL2tFNmdxWlROb0Fu?=
 =?utf-8?B?U2dzTWordzFXSTRhSDNVR2xVcFRzR2VYU0JJZ3RnNzRQbnYrdE90cWdpcW9W?=
 =?utf-8?B?QnpkMjVsWUIrNWE3dkhlajR5TlpIS21nQU10U3BKN2VBTlJQS09MOG9UV09O?=
 =?utf-8?B?bXVTblluYXpPN1hVSk5lczgxTjVrdlMzckZFZXdNYW14THlXZmJzcFVlcWZo?=
 =?utf-8?B?dThCWEUvUG1MYkp6bCtTZXRWSmRvcWdNSE51QktjYjBjZVh4UVZHSmdXbGp2?=
 =?utf-8?B?a0QvdjNCQVExVVFGM21KQWNVMEgvdzBnUllBRmM2Rmp6eHA2KzE2akNhTVEw?=
 =?utf-8?B?TGZmdG9peTg2Z0JUK0tzOGdKY0F3bkhZWjhzUFk4OVRnVlZ5Tm1ScldKR2NF?=
 =?utf-8?B?NjYyY3Y4d2VUbTROM21PYnMrOXpWK2U5VUQ2QlErbUNlNEg3RjNaQ09TK0Jj?=
 =?utf-8?B?Vzl0UnZTQTFCclozSFA0SWVMZzhubCtyY3lLRzBFSlVhbTRMOWV1QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa11384-555e-42bf-1c3a-08debb8dee97
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:19:00.2165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4/kH3J67/bB9QOCU6yxfTUT91db9uPxM5hAAAaqfcqIRGZR45LhkoiZpV93MHt92usfgjMlVfgO1C3FjbqgKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10208
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

Use dev_read_addr_index_ptr() and dev_read_addr_size_index_ptr() which
support both live device tree and flat DT backends, avoiding direct
dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/cadence_qspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 2a4a49c5f1c..20983fb7814 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -418,8 +418,11 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
 	ofnode subnode;
 
-	plat->regbase = devfdt_get_addr_index_ptr(bus, 0);
-	plat->ahbbase = devfdt_get_addr_size_index_ptr(bus, 1, &plat->ahbsize);
+	plat->regbase = dev_read_addr_index_ptr(bus, 0);
+	plat->ahbbase = dev_read_addr_size_index_ptr(bus, 1, &plat->ahbsize);
+	if (!plat->regbase || !plat->ahbbase)
+		return -EINVAL;
+
 	plat->is_decoded_cs = dev_read_bool(bus, "cdns,is-decoded-cs");
 	plat->fifo_depth = dev_read_u32_default(bus, "cdns,fifo-depth", 128);
 	plat->fifo_width = dev_read_u32_default(bus, "cdns,fifo-width", 4);

-- 
2.51.0

