Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82567ECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889AC83E88;
	Wed, 11 Feb 2026 19:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JDw50R4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D0783E88; Wed, 11 Feb 2026 19:23:43 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B7183E70
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScaUesaPJMipscXDvtioD71mXUmCdT6aIOcll28BWNcJDU22xayOkib/hDQMtQ05zr8upfcWbXImppXMcwTs6wvwsuvOd5xVM24YicqAocJ6nXsIf+EyOJegpeceZtJZe77ZADm9+mgfehGcrzX0qfDXTGaPUkXdkwKVftoq23yu8V3j6VnCT9Y/2887pFS7dsItfpcZwA37EhVuP95QE8+tgDuNF9/m2sw+zs1Ek1Sr2SYipS62kQ+VEB/UEpXZPUdaJzEVbkIz3KhKkMhu2GhvVG/eFymUJUMSiR+ll88Rjt4GNoD9MAyh7lldwAqzqK94BPqf5sXrf8c+kUTuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD5c/fz5wOU3akTs5C39QXjHvjqDNahtfWaGr6RfdNA=;
 b=NovHmnx+2UMo43OuaIJe5nvCQBeKAZ2gLdlOv0oZWYou+feLqANb6P6Lv4725XzChZCQ6IBqSHf2byfdMVsIIkTBfwtK4JYiKD0jT6jkbb31ZNVSAY3ackuPnVvvs2HJ5cvRPXeRPkQvSxcB28Wq7Dg1eeQSi17vQlsED2AtgX5ENKroc1W6cRv+VtqfThWWfMfjxS7qsF8IkD96GsjJJaSfrs6a1qbeSPlc4b9NWkL6BsK9a4PJnyqf5hCEEwE6X6VTCPf4sNrjQsBTqBSMvsvUxTFltWYiqUlqRFYjsFWymE5iAH2n+szF7wImIGfZdgzTupJosPr8mcwqwnXmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD5c/fz5wOU3akTs5C39QXjHvjqDNahtfWaGr6RfdNA=;
 b=JDw50R4tmnHQOCgz9DhTEjD41ojbYunK0qvuRu9C9FgOdAmGdiqXwif9YhGKsV/xTMdScJc4K4p6fxx/C420uINTYi3mWM184m04xk+grxXSfySQIoSk3LOrUL/qDoElH8cZEwTrIUnQxnz8HtMUqQZ1lqoYlIRvrGcrmHJWQS3wVbfArHH/XlKxhWH69c3UgVqL0pf2ZlhPUvr2XYtFARvMhpLyzKbCx98owQe0LcjyIarQ2nf37ft9mEgdWXZfdlk4+lVl1Ptpu4kJOqMfLFnMi47VqP9ZfBH1T/qfTey9rLa9FJvrKMb1N7ANbb5M53fq/3YNSmH8jQr6Wyj6EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB11040.eurprd08.prod.outlook.com (2603:10a6:102:46f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 15/16] net: airoha: makes PCS support optional
Date: Wed, 11 Feb 2026 21:22:29 +0300
Message-ID: <20260211182230.968921-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB11040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a71e070-3dbc-47ef-e5a7-08de699aae50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U2F7N0ExGnsYu06NWVRcIZAluULE9B5+woalfFtMUsGwB47z6c8zU80Hx4No?=
 =?us-ascii?Q?lihQn8ybFyucAIs2NqqhGMwkz3CWe6Arb+Nm44trTRd9LqaCWgRoVy1i4C7Y?=
 =?us-ascii?Q?nrHzgvKofAOLU80Lw001EIDqbkhGWijwbM8pYq9Ir7Di8pnyFaS7wN7FiCaA?=
 =?us-ascii?Q?iI9kJwcU0JbkLZyMuOY7utyaVG2JEak9/314igcWeyqWyTgZOHR0Joke3WWh?=
 =?us-ascii?Q?jRlqBd5lUJvwKac+8sebWPPct+4V1wn5ZEGl2wt8d3s18ThJDnn9VqZU3QR6?=
 =?us-ascii?Q?+DbTyZe75FpuIrQAxQUSrNQkg4+/08ENrS8GzQzRCZoXY9rK2TjU38msoLV5?=
 =?us-ascii?Q?QVRiVWREOT9+Tnm5bTSnZbUVfd3e5zBvS4v01iN+8lo6xOkx7eo0yyxvWY1D?=
 =?us-ascii?Q?ONVe7uAp8klF9H/nqMEKfxT7V7PXjfj82B4aMf0c8wd/AzsTVO19fGpbvnkN?=
 =?us-ascii?Q?/9sEQkr+IaeVO1kawmntxKahrVAj+xOU/YjErPE5Jcd9Wj1YPsXiS8Ro5Pcp?=
 =?us-ascii?Q?1xiIx4VQOTMrLOt5yuFJSWHEOicPqDqNmTXR9UdmklO34YZIx2VbP/qkzrEh?=
 =?us-ascii?Q?97Hyx3VXq2TFGj6XfdMixCVEcww2wyK2bq0jYhzS8rKdu6Xa231y1VbPH6N/?=
 =?us-ascii?Q?1K0PvC7LbwbHeTIy3RUyu8iSzL4CRfSC2dfRTBLdQhZjXW7FWVQ0WhsgyfKK?=
 =?us-ascii?Q?HPF8bwxA6tzytllf/HLh7KGPWNS30t3izm66P9ag8RvvU1jmdmt2mEzQuz09?=
 =?us-ascii?Q?WpV0QE+wRnVGtczGHxNr1mIvd2XLWhvSeKuIXqpuK3XWcpXJufCQCgNDtEGz?=
 =?us-ascii?Q?7iM/DYwdOALS23oM/9QGzxI94wspniwmfgktmMM6DW634DKhKkRoqi6HGP7A?=
 =?us-ascii?Q?hK2aCGIZTwo6TgG7I7HsXp67Or/YBC6MNh0vcE+SpuGxeWwJ3ko5Nr9nenK3?=
 =?us-ascii?Q?EDsnNiw6OoOhu5ge7vFAXUpp+tjOYB9AfuG2n5Jd5Fo6nA7ehFAD6yUpno9x?=
 =?us-ascii?Q?mxAYq13j87xePzzE46fvzISA1KQXj4BpuYyMBVPqVX25QirS2w4hcb34rj68?=
 =?us-ascii?Q?QitLd1iXgEOtE3Ergz5pTsYcKE/lNI1Px2cxVat0+rjwLMo2Bq7bEQC3NfOi?=
 =?us-ascii?Q?ov0oMX0KAFy0+V2cUxOMwvTgu5VLo8vI4Xs+1WBszAe52nfzCfM+Mb4ZW7uN?=
 =?us-ascii?Q?1R61JYp/6KcerLKzp1Y/gyAo9alm4ULliJZNqFfE1cncxUckT/qDFkAcLK2t?=
 =?us-ascii?Q?2ek7nTdIS3N64/xzHBSnmhwNrUXH9kL+E9Lq4PlvvaAm56VllqXK17ODXhho?=
 =?us-ascii?Q?cNLGZeSt0HBUEB4nHNF3pHzQ8vE6un/p1AO2pFamUCytiS6JxbMqqes3XpHO?=
 =?us-ascii?Q?6nJfTQzU1cJWG2OxgZzbEQtHuOLQHTfxPN3OU01Xc7uDOUZ+DV0FF8XMHqyy?=
 =?us-ascii?Q?meIy2fk4baFIbzaz/qSuFmcdZxL2gPP7FrJaAeZmwGyfZQ91Wc7Lc4GKp3bs?=
 =?us-ascii?Q?AWuYn3sMgFOSOWepSy7KITpd3+CMFzb6dwV+/o8QsrwDF++Ob3xvePoVFx/O?=
 =?us-ascii?Q?bgU5WNAWobGz9x3TpDvX1kGS1FsrHMsCAUUY6C6tXLpPcHduq1eEf1y+DYAV?=
 =?us-ascii?Q?a61wUKGNxbd9puUkSMzQEKE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKY9Npx1/ryaQW35y3aXcBukSo99C9H6v1SF5MGHq9yesvOA4stxXERZfymX?=
 =?us-ascii?Q?b99TIpHUbPKEFPqtCi/CyWs+QCLwxDmBJicT7SiXikOJYQBUC1Cp+dvukRvh?=
 =?us-ascii?Q?YZQpbBo++R4iSR8tb04Us7V4OzNhNRWYCTs/ybegHL+xgjK55MSvexm+f/W6?=
 =?us-ascii?Q?x1jGSH/GmuAmBt1M2KvOSo+7Jf0elnMbdSRzDPlSALJftegm59TrhhDQrOQq?=
 =?us-ascii?Q?yfcnCxlF2fHri0TGoHu2jivrww4MpygDRf5ExEZBkwP1wyDk6/tkemvYFGVa?=
 =?us-ascii?Q?+vnHVOqEUY6xp5kFFwbahz2mxGvMw1QG+OuwmWmKOsHjbAj5633T2j4674EB?=
 =?us-ascii?Q?CeKQmtUC6hkThsZfWbdeLXcHB8d3jola0gRlX7kQRT7Nx0pUgtM1x6l0FoCD?=
 =?us-ascii?Q?VXA5SNVDfpzfHRrzlV7ZeSLbkkJTgizBwS/uWRlY18UvIB4uOue/v/bK+Esk?=
 =?us-ascii?Q?HKHw0Fj44iOOpl7JOlclmMtkehbks5T2FcE9soG1cMUMSrfe/ztCpOTE3ujm?=
 =?us-ascii?Q?SuCRxy0nk0l8Q/TQT+wNIFtWN0IdfMwWMyjcIjjqwSHfmhlP3nbIGqSs6Bnb?=
 =?us-ascii?Q?rGokO1MJPm79z5dRhDHnB/OxIsqU2qQbxsA1MmTKKmodO6zS8Qhwe4L+ACsf?=
 =?us-ascii?Q?lsCeHBhRMZ0VURSDym14BYSvaJfPV1bwJWgMN6+c+FjDaCIcWU4IEeAvWsS2?=
 =?us-ascii?Q?HKc+MDIJEXBBLaZi07P2lKicGKzYa86MlXsAlEC+1pKMsiczYPaDuUMwFdje?=
 =?us-ascii?Q?TN/7LuiElwtrV/roPgSNgUOgeR3CTOfUJbT1k2dpRHim+sVodtJhZ3Z6ByO+?=
 =?us-ascii?Q?EYffep3HPqzMcsgMw0x14R4s1ssDJcDKQJSXp4B8rit6eVZsSVKjxeYdP6cw?=
 =?us-ascii?Q?cBwwZUkXKX85tMBJ+1Vww4/nWjRdcGCGG78XVtBeoov2EHV/DaTJzWMLYfVv?=
 =?us-ascii?Q?VyEBONtyCJPOt5SXX44x0l4wv8mFVIRmUcCHzkwYai+fxkQQliw10ASjT+n2?=
 =?us-ascii?Q?4vLN9GOfDCFzQ6v5nk5wGfQ3C3d/0cvohH9/tsNka2C73bFQYk47T/9MVT6U?=
 =?us-ascii?Q?os+MnUx0p6BF3VxssM9vGzucIDYO1OTuKXmvk6PT6Ca2FLgVsS9WMC34fL8k?=
 =?us-ascii?Q?m6FjW7QpS+HWkEQhoifICkUB/EC0xsjMcOQ0GHQ70LkuZ0WhGXvsnwj9yrdl?=
 =?us-ascii?Q?fAYJPWmAh/S4TEy+zaRVd+ETzAJLDv/20v+mchZdxt6fsOwT/VkJC10EhwR1?=
 =?us-ascii?Q?vedHlzmZdBHHGz858UjpVklepMPpYh+HhvldsXcgUY9jFW0W3LrywwrJMV5d?=
 =?us-ascii?Q?KYDCnI8jSNmHTRjBbeF0MYO0bwX432m50tJmLzsYF5QHFaltahtt/Bm5DxGD?=
 =?us-ascii?Q?cF4b6NaHUkxA22b7HXCHxkv3DGYz/p+/xyloCS/i5zILdvVLo2EpUamxUnwQ?=
 =?us-ascii?Q?YpViulOpYaf5ds3LnN43IEICtkM7faZxMD9vL7JTUXC0qWG5uBATm1TpIv3V?=
 =?us-ascii?Q?7tNM3Z8cTkPw0vKOUtLXMRlml5mH2DfaiSEuDiHHK7/04WqDVETqpRYlV53R?=
 =?us-ascii?Q?0a6YiWqu1R3wrUejiWlFjt2my2v4GW3fAOzhHPBJnqFh9RzyPgkGiZtZadMV?=
 =?us-ascii?Q?wOYJcsZOGG+Jfs9uW3FFpIgU1ZTQHfKR6h1QK/Qm40GSGsnrDX9IQtEdFnni?=
 =?us-ascii?Q?VA9PKYWYR2Jfk1xYi143iaXEuLttV+draTlWp7v+/2kxpjYX7VXeOKtQq3xh?=
 =?us-ascii?Q?atc0mSVIeExtlcUUbzkt3yvuofLp0O0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a71e070-3dbc-47ef-e5a7-08de699aae50
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:40.5808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fFfMhtLHQhvJ9kbj5EvLq8nBv3KcDpdxq1Vd74zHDvrnMg9I9pn14Vm5HUh/dBHTwDsfhNwTzmMpCL6wkHMX2SszJINf2YcAsxjLFibIs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11040
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

It's not possible to disable PCS support just now, an7581 u-boot will not
compile. This patch fixes an issue.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 27c6a61de39..2fd8dd0e102 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -126,6 +126,7 @@ source "drivers/net/airoha/Kconfig"
 config AIROHA_ETH
 	bool "Airoha Ethernet QDMA Driver"
 	depends on ARCH_AIROHA
+	select MISC
 	select PHYLIB
 	select DEVRES
 	select DM_ETH_PHY
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index d5b9da6bc18..a0c1786c628 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -704,6 +704,7 @@ static int airoha_qdma_init(struct udevice *dev,
 	return airoha_qdma_hw_init(qdma);
 }
 
+#if defined(CONFIG_PCS_AIROHA)
 static int airoha_pcs_init(struct udevice *dev)
 {
 	struct airoha_gdm_port *port = dev_get_priv(dev);
@@ -731,6 +732,7 @@ static int airoha_pcs_init(struct udevice *dev)
 	return airoha_pcs_config(pcs_dev, port->neg_mode,
 				 port->mode, NULL, true);
 }
+#endif
 
 static int airoha_hw_init(struct udevice *dev,
 			  struct airoha_eth *eth)
@@ -829,6 +831,11 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 	if (id > AIROHA_MAX_NUM_GDM_PORTS)
 		return -EINVAL;
 
+#if !defined(CONFIG_PCS_AIROHA)
+	if (id != 1)
+		return -ENOTSUPP;
+#endif
+
 	str = eth->gdm_port_str[id];
 	snprintf(str, AIROHA_GDM_PORT_STRING_LEN,
 		 "airoha-gdm%d", id);
@@ -908,7 +915,7 @@ static int airoha_eth_probe(struct udevice *dev)
 			continue;
 
 		ret = airoha_alloc_gdm_port(dev, node);
-		if (ret)
+		if (ret && ret != -ENOTSUPP)
 			return ret;
 	}
 
@@ -935,11 +942,15 @@ static int airoha_eth_port_probe(struct udevice *dev)
 		return ret;
 
 	if (port->id > 1) {
+#if defined(CONFIG_PCS_AIROHA)
 		ret = airoha_pcs_init(dev);
 		if (ret)
 			return ret;
 
 		port->phydev = dm_eth_phy_connect(dev);
+#else
+		return -EINVAL;
+#endif
 	}
 
 	return 0;
@@ -961,6 +972,7 @@ static int airoha_eth_init(struct udevice *dev)
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 
+#if defined(CONFIG_PCS_AIROHA)
 	if (port->id > 1) {
 		struct phy_device *phydev = port->phydev;
 		int speed, duplex;
@@ -1001,6 +1013,7 @@ static int airoha_eth_init(struct udevice *dev)
 		airoha_pcs_link_up(port->pcs_dev, port->neg_mode, port->mode,
 				   speed, duplex);
 	}
+#endif
 
 	return 0;
 }
@@ -1010,12 +1023,14 @@ static void airoha_eth_stop(struct udevice *dev)
 	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+#if defined(CONFIG_PCS_AIROHA)
 	if (port->id > 1) {
 		if (port->phydev)
 			phy_shutdown(port->phydev);
 
 		airoha_pcs_link_down(port->pcs_dev);
 	}
+#endif
 
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
-- 
2.51.0

