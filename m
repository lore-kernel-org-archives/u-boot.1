Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F1BCD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E925F848E7;
	Sat, 23 May 2026 14:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UFsLQBKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5588490A; Sat, 23 May 2026 14:23:27 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2ECF84881
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOZxqtpUukQFzkLF1lR2BrlTrfrWWKlIiEPv791F4abAuq1+ylrsxwWIcUuozlK/N7SztEH8uk+lAcN1K/V/cu2FHxkWljuh5sAro89Ndd1dw758YAKGzZf+22JTG0MPZgUobFvhgbySFaEelNE3+YqgEIdtUImRcqmM/Ax5E1OJkyrsMDluOiVTKRuZoQKMTeIG5JgI8GmXIePc7pkAutjBoGyOUdw/Xo7M07H6F5W7w3Rg8mbOz+PgZK6A6cPcSKBvYjnGTLIevGyrQSc5higlpoqySKVtUWzbTuc0yj2IE4xHgeXRkVYneNKPX+dVHadda5sJ4jbk9xzyjcbwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ofQDjIo01Qx7wJtaxiXkYfRooaGmywZPag0NXHA5zA=;
 b=conj8UbtIvlHikoHSeEVcXkb1S/FKBfgZ7SCcJgzaRwDkG+L8GKJTSLc4utJMEpZo1e0CKTp8+yWymIFZaIvoB1TqHdb6sCNPeldXQdFRaqlapRW2uempuRHuGzMGwJzwIibp2O5eFIpE5IPzP4y6zH0YpNjRNEdJdp4jvMRMwBraV2F7gjIqJFIsVdXWwjfFuB1L0Uxfojor84Rt/NfuOhWXDXBIZykqRw1LAtr/TLwzXGglDoxZjHACYlPPVH/m1LchRJj8RNM4+f/jxwnpOwR61M4Taaab3P1jTvFHtddfj+HsVpj7w+3Z1uz8hLukAASY6bfYLmwa/tzXHMG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ofQDjIo01Qx7wJtaxiXkYfRooaGmywZPag0NXHA5zA=;
 b=UFsLQBKLiWqrV0l8sIooCbB9KV1fly8GMWkgeLkiEEWmUenT9TioxxvtLJY6TKWAWWreYk0a4WVjjbz56xHI7LsCNxjsgGUCBtT/ybj2rRIZCnXyajNgjGEh4AvYOP1Z5wTN2FQBmMzhdfjfRb9VyU0gmYL9LeOJnI0DpccNHJ21Gjeljf8oS1sOMGlyH1BQ0FuvvjdjeTAvYvxFdIfd914TZxfaM4xbPHvQC6ISzeyltn2GLolAOJn9t8ekwj2H/WhRKgjZ9ZVnQ7rWoEobVpHBVWPWdNMMf2GRkAEQupK1PyzLNGw+1Z9FjwFOsMAtPyIIk3IXC4xQTh5rqbLZFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GVXPR04MB10851.eurprd04.prod.outlook.com (2603:10a6:150:21e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:23 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:53 +0800
Subject: [PATCH 10/13] misc: ele: Use dev_read_addr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-10-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GVXPR04MB10851:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d5a96b-9f43-4b0c-debb-08deb8c61569
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: fintDkxU/vUolEsVDmdzuBSkzrFBZyUcxOzI+kqVHOsw807+sSMJn89HLXH6BNO1Gii5zD5kfdlCjsfPnjNwlfWMEVm8cvWq40RcJzHuMB/nodDVg2qb/2TtFYyuYQ3iO5/Eg/WR4tCWuk04TcFJnMbM7JqYwwb4bBZxZt/v2aqV/TT2etvNqGEkVYOrCLLfWrwlhehipUMH3WJJfzx8q3+LUitflQs4CT5flSfkyT5MGqMxViQK9NLI96xZns7ruaQ7HdOchm2Bi6Wzzg3mCe+5rbBG1CuAsf547blcFL4cMkBVhFY54YfQxcjDsRHN4SjC5gu9VWt4m+V1MCQfaHdhrztrXTX+It1u/hr7ZG6+B5fK+Oh0gdUO/QHLfOlGBZs/3Ew0cGNKQ0noyPVfW0xAQttzgiv/6KF0n/jhC8wcW+4vOAbQnklw/FeXLF0vqdC+AJp2ai7KKTXylvdW3+ECOPNeW9ewfsGAhabioFIIOGH5fDYWtqqlf8kkBWx8b2adfQgOZzIECHPl9y0yXBOD2BcF41Pz7TGIMB4WsYWYtaiR93JtKKBFmuz/LoSuHt1R4ckJ/uw+QRjNTc+h78YtfUMNj/+slbszSA/EEbMSp/Ahp29c4kRDejN/C8MNNaQ40MTusaOGnQQien9Ak0ubJgeB3i2PoFnjQEg99Xd8B5zbaSTsxRSvWJ34idcbl+yES7VfrXc3/7avnoDGJ7yhuqvd3ggZQ3ySWFeHdV2OLWBicvaqHJYsEiVa1wkW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNYcThGZ1VVSjJac0dQTGJ6REd2cElFUzlJSEJiZVZvd29YSHRCaUZZdmd2?=
 =?utf-8?B?ZUlSTHIwWndYRXRTb0h2blJrbjdYZEEwWkZMY2lBcmYwUkI0eCs0MVRVRkhv?=
 =?utf-8?B?U0o5RFlGNGZCYWw3eFduU3FvRWhqaUxXZGJsUDhIM25xaWxmSW1pYWQwMS9z?=
 =?utf-8?B?dktYVitQbDd6QjJTVmdUUVZIWGZFMFY3RGVTQjNWVGh1TmdZa2FEUkRreVM4?=
 =?utf-8?B?UXJnUnBXQ1ZWa1N2K2haNFRLRFA4NlpCM3kwdS9xcmxwbDlCQlFiS3NVQ2Fp?=
 =?utf-8?B?akJFMDhzNWUwdUU5UklkT3FlNE8wZjhhaEN5REVmSnlxNGRxQWo2cjVVYk1s?=
 =?utf-8?B?eEdoZE5WRm5FdFVPU3lFaTU2L09hMGVGSU1RckY4aVFJaWxvdmk1SzJ4cC90?=
 =?utf-8?B?SDhmdzIzeXlXUjd5MTNXVWtsOFZtQThZcXpmcndiSnRLd2dsV0tpOCt0Y1VY?=
 =?utf-8?B?TjZMMUhhL1ZBUG9CUGFPVHZ6dk5sYjU3UkprcWdhK3NkQStDSjBWdVpTQnhn?=
 =?utf-8?B?M3doTnFtL25jZEl4NEFneUFPdHljb1hRNmRzZS9rZ2lzNWxHOFM3RDQ5Z2dG?=
 =?utf-8?B?S2l0bkkwMHV3Q3BQOW5BMWNkNkZxVDFFczJoNzRRbUVsbUhCb0tsUFc1L2VL?=
 =?utf-8?B?MmU2SDIwemdPM3pySERydkJnazBMQXI0TlZzeTg3TjdESFNpZ05PR2NuT0dt?=
 =?utf-8?B?TUw3YVNLWDdVakpOQ3BtZllGa1M3cVRUTzJ5MThLaWZXM0FzSzJvZ0NlMFJz?=
 =?utf-8?B?SzY2QmlTZGZ4WXVoS2NZdXZRSGFDNDBrR3pwQkV1RTFTRm9UNGpMbk1lSFN5?=
 =?utf-8?B?Tzl5R2tHOGZyMEs0Smd0cjdkdEV1RHNGK2VSRFlyZFJYK3FORkNnanBlUkJ1?=
 =?utf-8?B?cTZmZU4zVGRyVks2L0xNZUc2UHQ4Q3hzUit4VjIwbGo0NFRNbFRTMjdVQUtV?=
 =?utf-8?B?QkwxTjdFdlIvWTBnZ3FUck16eE1aakdGTFdnRzNRVG5PRWswSFR1c2Z5WnJ2?=
 =?utf-8?B?dmVrNERvQ1NOQU5PVFN2eWNveW5GUmFWVUJVT09PS1ZjTEVvNXBmWlRPTDI4?=
 =?utf-8?B?TXZoaVllaVhPR0pZRHM1QjVET05UQ0RGL1BqdGovc3cxZkhBalZmTmorSGFP?=
 =?utf-8?B?cUUwVG4xZ01DU3lCQ2FwamVYUnJFNkExUkNMTk55M1BtazBTdjBPOUVCOUw1?=
 =?utf-8?B?TnBKRUk5a0pWUWhHdktvc2F3VVgzcWxGbWhKZmtSdDUycFdNem9WV3lCVDli?=
 =?utf-8?B?TEx0YVdSQ3ZFWmxUc2RVY0ZCaldYbEpLYW8xMXphdTh5bC84UU1HKzVlRWNr?=
 =?utf-8?B?NVhEcmIyb2RuQy9mWkQ3VVd0ZGpvc3I5c3NZV0hEbGJLR3o4eE5JdHZDWWVh?=
 =?utf-8?B?dGdBNG9mNy9kbGxXTzZmcDFuTTVGeDZlaVJIdEdCK3R2ZndBRnF5b3RQdS9H?=
 =?utf-8?B?WmlDeEFqUVhGbnM5VlgrdjVDWGtIVlAxNzZlclpLM3V4dFNDemhoRFVNMEpN?=
 =?utf-8?B?R1VPaWdMMnordXZtUG9iamNCZElmb204bzRnL2dsWTYyR2I3UTgrRmhwUndV?=
 =?utf-8?B?MXhGeVVmUSs0QzE3dmV2N2NMUTRhWkdtRndKZnBEbzFkZ2NRVnpXZTVUQXJK?=
 =?utf-8?B?U0EwYWEzSjFJU2c3Skt0VGVrS2pGSHZtdnB6dnZtWU5HeEJKQ2YvdnBMUHZk?=
 =?utf-8?B?Sk81NXJ4dWtNcXhwN2t0RVFZczl5OGN3bXdVMVRZeDBIWDhyaVVSR0pWUlBx?=
 =?utf-8?B?Z2VQMW53QjJnbFR0THR0NlIwb1Q1RFdOdUhWcHBLR2pDRHRpcjFVOC9tZzFV?=
 =?utf-8?B?SzFEN2Z2dE5yUG5ZRUJudFQwOENWVTV4Q1ZjV210SkEva2huZklKWVUzYnpL?=
 =?utf-8?B?d3phU0ZFWEVOeXpSMDhTYy9HTnZta1M4dEhrQXo1N2pxOVdISHAwWnhlWHpZ?=
 =?utf-8?B?Y2h6Y1lNVzNQZk1YdnVxUzN1djNoQjJYanNiT3lJemdOa1RmR1Baa3lNMnNx?=
 =?utf-8?B?d0dFV01mNWdyeENubUlsUEtZT2s4YW1uaDFIVWNBSFIwVU9ld0hMVWJWZmhR?=
 =?utf-8?B?SHg1VXBaTXlSelFNMVRmeVZrT3RlQlJhajdPL1k1eXhheG9mK0U1R2l6KzNz?=
 =?utf-8?B?WVNKL1NDejQwVlFCcm5EOXhXbDZieDFST1VMS0Z0bUtTNDRIVlRLSFpSa0RE?=
 =?utf-8?B?QjFPSmRHT3dEMktKM0FDcE5EVmNLZGZKdWt0cktqU1pOZ25UYVdDdlQ5aGx3?=
 =?utf-8?B?bUw0UkF0RG5zWWQ3L2FYYm4rN0xhYk50bTgvUXpJL2xTV0x1OUw1TU1GZ0dD?=
 =?utf-8?B?a0JUcTZTQXFoaFVMLzJjTG90dmx0RWlqNUhIYW9ROG9QTW4zMXFjUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d5a96b-9f43-4b0c-debb-08deb8c61569
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:23.6036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4K6cxcS5/vG7ODkpD5OpV+l/6WKXRHH+zjIZRDXf5tTnZ4hGInPtOZQaeKfd9bnxRH9C9f7a0Ugkp3Bto6XVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10851
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

Use dev_read_addr which supports livetree API, otherwise driver
will fail to get addr when OF_LIVE is enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/imx_ele/ele_mu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/imx_ele/ele_mu.c b/drivers/misc/imx_ele/ele_mu.c
index cdb85b999db..65a4779c041 100644
--- a/drivers/misc/imx_ele/ele_mu.c
+++ b/drivers/misc/imx_ele/ele_mu.c
@@ -209,7 +209,7 @@ static int imx8ulp_mu_probe(struct udevice *dev)
 
 	debug("%s(dev=%p) (priv=%p)\n", __func__, dev, priv);
 
-	addr = devfdt_get_addr(dev);
+	addr = dev_read_addr(dev);
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 

-- 
2.51.0

