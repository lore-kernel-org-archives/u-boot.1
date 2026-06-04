Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9F2CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 11:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84433848BF;
	Thu,  4 Jun 2026 13:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VW6IfGx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E350184940; Thu,  4 Jun 2026 13:04:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC77A848BF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOXwOAXk1zQxGn4e0dcBUIt7efJRZXPN3ljqtsSDVKjx6E5qaQ+gMXngV+zG1Wvsp5n5SU+eoUCabILvBwlgdcVCHjTumw/hcu5lmQyuDI4V0roI2IMu7EpzuobZxsCCn+UBZ/qQy6zvUbe8I4oDboVMeiSHajfrTpNbgkHvF/RpRaSldtF2gW//0rseNHoC+soA78Nguts90Mq9pz76j23wyPOlqxtOQJ0J6cKwaDmAarIrO5GdlIG3vc5arCp5zNNTh/rjMnHxl62cGqK1YbLV9XOHSqxKr97R2ypppaGaE+5dqNIES/UF5clEYr+YHVbQg0IqMKI+xC5pClJUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awr7ANPGm7WI6FCxROELLAOHCX8OUlwQJu1YHYoc5jI=;
 b=AYzjezDogRf3DNEv3+BhOMAMZSmQykD4VBuIKvNSg9ZcrZBf5SCtV7ujiopYaGhHh8KSVOTvJGnu6bD1Nj5gaD2oZXiKe/dMHA+lSBERZHKZ+zMMbHbWm6llCmq2DxVUE3lD2HaawAE0aATwVuGoPNHZAKwYljolRJutlUoksKqe9vq2/z+0Hnw+w+2z3jWtLxkPHLdB30EMfXFUyOYOmbNVhQFmGNAzDgvt8uKkQNKUTX4afc56jPESYD57uXCR/kym1Oapia5BVqHMGv1ZAfltfki6e83wSKGkBfX3sB+eSVhu1SalPwjQaI3Y7xHwi1lA0GXyuI2G82R0Y3cvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awr7ANPGm7WI6FCxROELLAOHCX8OUlwQJu1YHYoc5jI=;
 b=VW6IfGx+SFody+vDaR8okCou6dhdUMnvT+YP5twzlTwZ8g/wnAnltzJzQCMI8b7TB5Tp6zVLpS9PJBRJWzHetQ9CgdV/3r4xHudHX9HiW0EJkzNP03SChgycivf58VW+yctptaCMUzvnBYcO8mX6T9l0hyjcm/BiaRdO2u2vFf0aNNsEJWDo8g/oENYRZbaCUvud2rbau9/kemWolhEYHf0zt3INFRMSBEdLhpnYLCoj31U8LyH0ST8dkL3RijbImVkp/0umPqWB2aWgT9vosgthJl07jxn9uHYygdCdl0JQFgXo6t9kEw2V2Nd62tPNwWKt1MlyVoYYs1qlN1xHug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:04:47 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:04:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:34 +0800
Subject: [PATCH 11/11] power: regulator: scmi: convert ofnode API to
 dev_read API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-devapi-v1-11-961aded05ff4@nxp.com>
References: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
In-Reply-To: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot-amlogic@groups.io
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Yao Zi <me@ziyao.cc>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB10291:EE_
X-MS-Office365-Filtering-Correlation-Id: 0839a30f-4d89-47ca-f8d6-08dec2291613
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GonG42wxcjKuNO1fF3rgMn5Z82UuGQ2nB59Im6mL9wMHvFO9Og5Cyof1BZzrrPUv4qyJh8yS92J1d50XSHTpAVWgUT2EzmN5kCGf8s8LPj1awfAIbQOe+OCbOePNTRA+xOCtBmOUD500gBcLXyTKPnlggQB43zZXPHWOZw7xSbq3czu+siPirJrqmHk9ODwVgmQPOY2nUyary8A3BJp6tksGXxrkR/ZzNyTi5iyVVsUBdKPCJ23C8SPXB7fn/j8k95OgKfkexQ6FYIE/CVTpW4swDZAXuB/77ONNdAaAGgvuXLvXjxj9fC3Oa0v8d5Wiqc8dBW2ovpSyGWvvWnKZDURMiit9500zwo5HPXffkbANdpf1dD3Lab7B73FxpCE0pBmWTa5xKIEgk8aNKvQXj96JFkv5+vLQjqNgZ4L4/6ytDPg7kN4hFMKqO4JrVcAwl81lVnVxZP+5OSufvPKGfSviqzTo7Y39jdtIFsft9A6xORWqoGGapeLxxb6rWEo1I/h8Nd2YUtYdzoEkzTCYqzfVeiDDajJ+23OaNOXkQhmI/o0XWzIB0Jy4fGXdzUEoGNoReN1mvJg77HkQzySIoDAV4GTzM2o7QtuJaIN7l5q3FyPIBrMSQiY3eu1z2IBrnaBY+Zx4VVu58HcCw98iYf1QtAKBzGUqRdtVPY/VX1oQAn2FjP7W2NGR8lI9NAddAxCgai0RU3yBDNaX+8trIS0ffelODLRUuRSHEJJZP2RmOtcZwxIhZaAUjgU4JdUE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2tJYmI0L2NUalR6SDErdkl2cHN1bit3WTgvaVFxZzlmRmJrOXVMS1pXQS9I?=
 =?utf-8?B?cnZBMWxlVEFFV1VCc3FMNWQ1UCt0NUo0SnBYVUpoaElhQ2FickhzQUdpb0Qy?=
 =?utf-8?B?ZWF1MGJzb3dqbFZDdk9VS1dJSFpLZklhakVlZ1d2L3pPU3JjMXRsRnpzeWJF?=
 =?utf-8?B?T1pSSzZxNXQvZGFQZUt0K01scjdFaVpoRTRRWDlLM1pkU3JQQzJFUDFaWmZi?=
 =?utf-8?B?dWdSaDJ0QVZIWkJMbXpMeE1oOW15R0xvMjFvdXBwY28wVmRnSGwrUC9YMTla?=
 =?utf-8?B?Z2lNQ1B0Q0VZZVI5K3Ayc1hzMU1ZLytteGRPc1A2cGhVWkdCVUFWeENaakQ4?=
 =?utf-8?B?bUxXd1lPZk1UU0pkZ1YrNmFXOEU3bFAzQzlhSW9oVzJMSHFSeHBwSUtaWTJD?=
 =?utf-8?B?UVQyWkVBeUhxcUo3UjRyWTRKbjc3dU05SE5GWjZraWhOZFFiMEtmeU1aRjBJ?=
 =?utf-8?B?TzdwNjVhMU9WS2pZUmlnSFBUSlNzMjdZdGl2VDA2SXZ4bXFISjVSSGhwUEVt?=
 =?utf-8?B?WFBNYlRMWnZBQW9kdTFYc2JYelJoVWhBR1dBeXg2ZnAzQ3l0NGtKRURrQkVX?=
 =?utf-8?B?dTNHVEhsMXY0c1kxaUx5S2ZVNEpmbGJhc29vTnpLOEZlNUs0d1hybTFydlBj?=
 =?utf-8?B?Z203aHBFSXZwSnI1NVhDbk5zVG1XN1oyYTdtajZmRVdXR3VLdWlzejdOMTJ2?=
 =?utf-8?B?bG9vVnhJZ0VPSGYvbjZhWFlZVW5xejRmR25VMDljNGlXUURNMWJZSTh5dVNZ?=
 =?utf-8?B?elRPOWhsbE1NUXRiQ0lDTk5lRWlEdnhDeTRkVjlLa3lDZXgzdDEyc1JOVGpw?=
 =?utf-8?B?NCt3K3R0a29HVmxlTWZqKzl2bHc5cFdIQ0NIWWRMOWV1L2V3SnBjWjBqdjFa?=
 =?utf-8?B?WUc5ZkxXQTI2ZEE3K2VNeWJwSW01ZzM1OEg0eFE4OU5Wdm1FNTdBbnR2TWox?=
 =?utf-8?B?MFJEOTBZaTI4MVZLdC9VbHBuamg0bzl4QlN4VGF5MHdhNkRseWljRHd5TzV6?=
 =?utf-8?B?ZXN4NlFVY3NYSVBHSUV1aVRiWU5wU2tDRXJ3dUYwS0lWejd5VXJ0dTdjYzNY?=
 =?utf-8?B?ZGFBalA1Z2R2Vzh4S2wzaHJGWTJ4U2wyR2xsREVGQTQzbk9LTnlabDJMR0N2?=
 =?utf-8?B?emhuN2c0VHRSbVJLTDEzbUI5bkttV2hQc0VmZjh1MDJrdmdQTGpvSDgraG9s?=
 =?utf-8?B?OHpuQSs1NzNQZ1dxa3g5dkpsS3U4V3U1Mm12WGdRaWxRRnBuS25FQUN0T2lx?=
 =?utf-8?B?WWxUcEFIbk51WEMxNWxrSXQ4TGZ3QWc2aTdOeFVwakNXa3l1MTFpL1lSMFFh?=
 =?utf-8?B?WmtQcHd4L3ZIQ1RuWnhTZEdGQTdkOGFuUnJ3NlByWUdkblNLVC9iUXMxSldK?=
 =?utf-8?B?a2F1bDhuTlRDQisvUUZmVmJGM2hRQlNnSzRqeFdCdjAyemJTSlozbCtlTGgy?=
 =?utf-8?B?KzhkMjZyYjZ5cVBoaTAwTm82N29vc0JYV2VhaDIrWnVtbngyL044N092bloy?=
 =?utf-8?B?d2NvQ0taenorOXNFZVlXTzMwWWJzSEd0YnhtYWU5VGZldktmeEtlN0czczgz?=
 =?utf-8?B?czhvcXFyenU0VVd1KzIvclpGcVlMZk5oUU1EL2N5MGJ3UmUwb1pZbWZEaXFB?=
 =?utf-8?B?SnhJRFBJQy9PbGl3K25lV1kzMXh4Mjdrb21IMnhHOEZyejJPeHlQTVhyYmhH?=
 =?utf-8?B?T0ZoSjZmS3psWkRSVWtJT3hhcmpWckhCSjFwSVlmZE5rSVdkdFlDMER3bnZR?=
 =?utf-8?B?dW1GWTUzUkk3R2xzYWxvUjVoWHl4V29McHkvdzRqbVBZMEgxQVhLRFg2RmEx?=
 =?utf-8?B?c2d6WVZ5RHdVWHlLZHdLVFc2STVLWG1HTWVmR2U4WjZKdC9KK3BZeXJYSUd3?=
 =?utf-8?B?Ylg1STdQRE0waW52eExYYlVzKy9oR21NVXFLNjNTZEM1REtnZG9NZUtjSDN1?=
 =?utf-8?B?N0poS0RvRk5vVlptU09YS1owenJJLzdWaWloT3dtVk81MU8zUWp1M0FCVWFV?=
 =?utf-8?B?cE5yOUptZUpUMUxmaVpSRVA1ZzkzT3pMVnltcVZ4MEptYXltY2IzVXl2Y0JI?=
 =?utf-8?B?VllnTEtGNTRYMEdZQXZBeFJFSWJVeWlLWC96TmFhM2prakpDaEtjOFFFbXcy?=
 =?utf-8?B?MzlrUjhDVXBTRWVFeHlWWkU2UDBqQlFveFZQbWtxVWhiQWxUempKTm5SK2Nv?=
 =?utf-8?B?eEdjTlJCNDArWW9oMytuMzRzVnRWVkllT0UwdXQ1d3ZjSkZmVmNZcjZ6Z2li?=
 =?utf-8?B?dVlCVDJ4YWNBL29ldERKY01pbmVpbm5nY0p4SC9lc1RHVU5vVFM2dVkwdDBP?=
 =?utf-8?B?blI2MFMyaUlFYTFrM05FNFNVVmp0SzN4N1MycTYrZGdINjhzOXQvQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0839a30f-4d89-47ca-f8d6-08dec2291613
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:04:45.4037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQNB92EWpYTP6JIFumX29tr2wbcUHk+6XNM6TS/y+eC0VMn7bvdG3CvyWSqJzMwG9X6K9RMdWtZCVEsgKNIv7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291
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

Replace ofnode_find_subnode(dev_ofnode(dev), ...) with
dev_read_subnode(dev, ...).

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/scmi_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/regulator/scmi_regulator.c
index 7d2db1e2bee..aa7b4278260 100644
--- a/drivers/power/regulator/scmi_regulator.c
+++ b/drivers/power/regulator/scmi_regulator.c
@@ -180,7 +180,7 @@ static int scmi_regulator_bind(struct udevice *dev)
 	ofnode node;
 	int ret;
 
-	regul_node = ofnode_find_subnode(dev_ofnode(dev), "regulators");
+	regul_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regul_node)) {
 		dev_err(dev, "no regulators node\n");
 		return -ENXIO;

-- 
2.51.0

