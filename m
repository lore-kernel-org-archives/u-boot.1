Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49561C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D918D84A0A;
	Fri, 10 Jul 2026 12:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FlRLtGko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B3A84A29; Fri, 10 Jul 2026 12:24:05 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA87783EEF
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPNHyDK7ss1p9SynweSp87so9W/cbAQycc+QXhgWdJmYSa3F/eAN3S5UI/Hjg64SpPMtq968KRSFHosGPkZr5XKT/h2uM2VE/G5JX/thVTk9Odwoi71967+KdYeT9qrPQaikoq6jQ6U2YS5JkIal85du0zGMlFRnQS601lISFU3vMQU8EbBLBRQR3u7nLehvOM5VUu3kn7nJohvD1Dlg3UTbmuK/Jncql+rl2Jso6nJIEk04YD59oLsTwp+9nHMgpX84JwhnmFz50QQ0rxuVN4R8XUmu8FWE/Bb0ze9JOdXG9/lGqrQv2QmZ0MmRHU+XnSyN9Oeb1F7dx2/q8iwrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5v+RfLV8AkT7cW6mkbvR13TdHH5+lWljzDBxmJDerQ=;
 b=ah19yuXB69kkd4s3JeKv4FtU5vRKYUz6jl0KTDDwG6dYAIbbnIUrKSUIB5YKNjVqHU1bjesFHmcnxlXbSW2VGD/3MaqZeLnWZ03iNDm35w3+hTZ2ZX+7kneTSGjga7ZNSOTu/bdj6FetPq6hGyEQYDsE44AHcTZLrs3gTyuc78xzlX0erpFHaBxH2v6R2W7TfXr50sr2n+R28EyGGjQC9s4/hqn5Z6JjYrhw+elpIsrPGcoUpcpMphUdx3KCd4s0/ixcV2B6EbVygB6ozFzkuvBm+EGelTMXpLKkE+azyC2FLxJcbneKjbWOd4QNenS7/xUj3DHBWxCzgd3wyoP0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5v+RfLV8AkT7cW6mkbvR13TdHH5+lWljzDBxmJDerQ=;
 b=FlRLtGkoVwpCzzRLVAz0EOlHCiShNUVNqzoo2NZt5YLLgqWshjLJjfW6B36BkjpHuMXFuTfaTL+goKRqNRIqjfuKnyBaYrat0dIfFCgc7ns6zXszzxRiP50VER3nNaoQBPgRx9YSJPOZuyoG1h2oDaAlzf/YBNphB3NhQkxBATHqXeFRoi65thuDQwxZQhUryLdkndj9/2GzERunA/yBA0Ck4JCQZZuVlWXSU8lmnlZf/wmTTFXcuxIncPXW/OWiz3CuSr+9Mb1apV0BrIIv+3FJ3HsMJSrehPGUP34yGQ+6Zra54tAhn+J8sMhgBp+qbS/vuE+WP/UHaMR0BUsKpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by AS8PR04MB8770.eurprd04.prod.outlook.com (2603:10a6:20b:42d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 10:24:02 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0181.012; Fri, 10 Jul 2026
 10:24:01 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	alice.guo@nxp.com
Subject: [PATCH] imx9: scmi: Update get mac from fuse for iMX952
Date: Fri, 10 Jul 2026 18:27:21 +0800
Message-Id: <20260710102721.3341086-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::12) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|AS8PR04MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b94d423-9b0b-4b3c-3da7-08dede6d5b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|23010399003|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SEBimLP2yFpJGi/EE98oF65LcqXK2SEjSZogKRjkAjCI5AfW1RjMKd4HTBOYETAF1R/sqewvOkuWu1WoEZiyfMPccT2wi9n96WoY1VEQujJwkq3oXNdR3ZHB5BcAcDE7hdBGXI3Nbjtp1rTYLyPT4LxVjSdmS0CvKNSpmBMCBJZinNkj64NxJxZ/hKZbFmNFgnptGH9Bgln22DPtWHZqUnajqmghRSmOgYIakGPZ/HMgpCMckZtSuiF2DdqPLBvA3xcEnNPuaHrQV/mTLXYa2WINL7F+cF6jbriSkMdi9jpxL6NnSkZ2ao/wUdC2Y4IOL/0QWf8/UEiLJ9zbRNDoqSa2LToH4wzchJx77quvbwzGLOtxUPxBFtAWdi40c/1rcjkeeCgkIQDJ9FLxH2HFG2cHIvCiQAdAV9rFRkh/jh1/LE+1uhwLIofI9D9yt7jIo/3tjfNPgZ++nifDSAvEgPBIKLQzzPheRhnYPZeSAv9YejGQmdlfPBaLnS+m+anvv5xImwNBmLn3upmIneWK81oKLZwbXExj8eEJHrtyGUJv/wKbpDeVFAkolHmAIu6ZIrhws5pESdLpDP/mH2EmKzEZN5zR4q/013uwDzL1f97uDTeb3R45kwMRyWw/QieWdWncWisIcRT8vtBTIDgUFQTxCdaxNu2Gf17dCqgxgM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hugMkiKF1PAdgt52qNjMUgVP9mf3kYSsZJPXZrMXpeZlsxTo4EtHHY1cuu+o?=
 =?us-ascii?Q?xS/FHIDToEBwOfS4LVoKn8XUdu2i0qUrWHRVR/481XYK6grlAsu6yzsX6yzB?=
 =?us-ascii?Q?LJ+7kUiR4idbF6Pqo5UFXVf/jskYdSopyWm8doFi3fPGFQYsDzASROcL/y4z?=
 =?us-ascii?Q?Tuu1zPT4hTDjeryzxoBtTLf9wR2L5WCMhiW9JpXuSxVnECxuZ9s87ZS7e570?=
 =?us-ascii?Q?79toJTo52VHFRU92yf8v/O2UVoFHCA/ytrvFEXZyy3LMbSO2FhIHT7T+xS9t?=
 =?us-ascii?Q?y4YqMW+5oq0CnDY5OqDThuTCiZAG0+0wPzvPZAWTsDQDUCwTXQHsIbelX4iu?=
 =?us-ascii?Q?6p9ZqVuhnUxfUb+gCZW/+BmxNilx+t5KZ/Z30tWBpToeZbjq/Gzcp0v9Z2De?=
 =?us-ascii?Q?gumk/svG4fq88ZCrvbUA4HXX/3VvchzAN68Bp6IqQ8bbkQQDioLXU6ALR2WL?=
 =?us-ascii?Q?PiaqcElpW18I+zHAbJsM2oZSu1DWTujy/6Wa3bnnI/ocuX3Omy7vClTrEUe7?=
 =?us-ascii?Q?pBut/jrK/bl/kQEpSVvso4UrltmHDM6sUnyK4wE70WxWET7L7+RnTsq/zktI?=
 =?us-ascii?Q?hTv+u2H9BsWi4HCSgSUxx39kWSCf88dxa9Mq2PJ2tOUU2iVUMYGwxfaI/TSn?=
 =?us-ascii?Q?0W4I6y5jl2YtnhkEc4QMeumVUGznJqtZCxMZlZ9HvNDFdOGP3wgimixa6grr?=
 =?us-ascii?Q?n/sO79rCDxpakSupsKhhcEHPByHSNl+ZZqY7GWeVDpeTZRdE3uYmhXLfo7gM?=
 =?us-ascii?Q?YwpCGzLLMKattpSsOzQ5tw+PcNy4rYThYKVwfN6ao3sZ2y0Yc7w9bs92xu74?=
 =?us-ascii?Q?WNjMBDj2um6SnkPsGKluTJecsoes2AMZgKhetQ0B6iLEWmNOqEWWy3yUvNgS?=
 =?us-ascii?Q?SL8Ya+QElLN/vHVbFtbCMZy9UNwwkAO01a9FJeC0LR3yuUzcOi1YA4fH1gNy?=
 =?us-ascii?Q?KPb+q2eHBhnEkMZDl4PUMWa0XHm1k5AeinletBkqyuCAJanrkbr5hSt8VoAa?=
 =?us-ascii?Q?2KxQtz2K3U+x6DqSeeQZEuDXX8StzW20g+Q20XcFspdVwEU8XhbZRKu/dgTV?=
 =?us-ascii?Q?w3WPqNQhZOD7NMLCYgrJzmHc8bgxGTVVd4dSBWkispJV6nAl/5Ww24KicRCG?=
 =?us-ascii?Q?KNhcSDiFxOPY19qdV25wJ76qIaxMUPSLxEiQEnHlHTH3OW0o7sUUqV/TDnBZ?=
 =?us-ascii?Q?PYybIP0n0y0rE4x1cvLK4w4ubtZSXIB66w4WpJsY/K8wP/Ut9DKqlVL9UDWA?=
 =?us-ascii?Q?fnCeZLMvl6lXoSmNtidAhuoLxGcSOb1d8+OY1X00WSKTfLpC6vIdrXQCcay4?=
 =?us-ascii?Q?RwsEPXKXvBDjge7mDYOk5PMGz0wmNGnyxAA1mHyGfcoWa6EWg8PzubYdx+rv?=
 =?us-ascii?Q?QQVmFzkwRdJElGZUUCgp28r0JjMgThomLVPT0iqmFaib0CN4+sR2IXamJ4vE?=
 =?us-ascii?Q?8lJnIEYdYoLggl1DW0Srt7KplGHx1qUVgv2By20yQHoYAe5tC1OuUBnDT3Jg?=
 =?us-ascii?Q?nPmwvAtoEFO5QRIL4igHCD0cdJr/DOj2mOLgwJKkvwNPXCZ5OND5o5UlSJKQ?=
 =?us-ascii?Q?ak2ZrEJeSQ/izdN6fv67lb7KEX+QRjBuG5iRnQ4SCFeW3LiPqTqgTrnnGvCj?=
 =?us-ascii?Q?8NAz8XxpMZOmQAjHweUrz0N/qznbP8AfS8/u5RcLsp3dLlRh4yN/+spr7r+K?=
 =?us-ascii?Q?ZM+mYOM41NDD14fL1KayiLFbNKZYtPW8PX+C2q8OGxM3cZPDQQzM5GT2hQ3V?=
 =?us-ascii?Q?t2QuqrfOP4CcA5VlvSvTHRQbzvoOhsI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b94d423-9b0b-4b3c-3da7-08dede6d5b7f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:24:01.5325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEsQSAR/E9viDviXohVPhB8Y/rMfoxY1IiU32uMEyv4Ms8nDCp18erCEzARKO2zVOC243gkDYhiYJ5dsaGRg0dgjCmOAyY/oyZ2ql4fQBng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8770
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

From: Ye Li <ye.li@nxp.com>

Since iMX952 only has 2 pf and 2 vf, update the imx_get_mac_from_fuse
to adapt this layout.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 18d00355999..796c9e8b18d 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -593,6 +593,18 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 			eth_addr_add(mac, 8); /* enetc1 */
 		if (dev_id == 2)
 			eth_addr_add(mac, 9); /* enetc2 */
+	} else if (is_imx952()) {
+		/*
+		 * i.MX952 uses the following mac address offset list:
+		 * | No. | Mac address user     |
+		 * |-----|----------------------|
+		 * | 0   | enetc mac pf0        |
+		 * | 1   | enetc mac vf0        |
+		 * | 2   | enetc mac pf1        |
+		 * | 3   | enetc mac vf1        |
+		 */
+		if (dev_id == 1)
+			eth_addr_add(mac, 2);
 	} else {
 		if (dev_id == 1)
 			eth_addr_add(mac, 3);
-- 
2.50.1

