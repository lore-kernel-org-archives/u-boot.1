Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4ADD206A4
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A2088E39;
	Wed, 16 Oct 2024 09:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aitWq1mD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5C688E6F; Wed, 16 Oct 2024 09:19:41 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A811988E3A
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJChov8P2azx9Crl5g3BSGGZioT2r+JvB4QWZd+wnmcMjqlvEiUSv10IXvRX+HcZGl0T3o1IQAPNxjfXEokUFZHbnyPcA1fXgL9c72riH5qoIuhPHQrr3cwrGEJchQPRijdx0+pw+BkOEJ6EXZ2NJULPSbYo7xpAYl1sUGIwyUQHl5+sAFWpXg1V1qE/bc8/nnl5eiSQsN1naSNoAmqCk/avW4LPCbahbEUPV6axoapZ8otbWcetYHTxHtejp471YAD0QVceQk+cuRHh34OBz8Ec9jqtFZb+hHSnYlRVINy6QDX2BQTNLnILlxwwHkKNQIGzZGI/mtdTV0cwOSVvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHCGiJziqR4+LYca+SZs03/nNg4RSQLMlPaiT8+1k0Y=;
 b=OP/AVeN37GgUdYKPyCZWWJTtcH4UrlrPxbTDyL8SUU/vMKQjdv+Q2WzbOgyiszj2xpfqhYabjcbvPVPfGsw0+OjMlVT03gHRgEWuzj3o9X6Y9k7mtdqPqaSTnZ1+cpO4ConFfyXsdARVit1woTOUiVRxRFAFDfD4uJXR1wqGxVVPO2QAaOccLh6N759dcMJ2sRcSxiSuMjZbCJAqKDgZucBpIblSsnaGaLCI3we2kv2zWqRd9yt+5tnGDDlNLHoPgcZG5xYwIWFPnM0DLmPWCemomzHJ17T69/kFiiSP11s2zrVZANDHQbyyaqfOnDYFpYcjF4Zd1NaME6KmhuJp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHCGiJziqR4+LYca+SZs03/nNg4RSQLMlPaiT8+1k0Y=;
 b=aitWq1mDe2MlN+6dlxCHp6Bub6qwRMe/berZfMWwm8uuiVejpCn4j5XGr75YM9Wh7SdtrpApoWxNxNdpGdbIOb47j6+L36TXoIb5C+FKzgxKbP/VZ0hU7vaWQLWObN5YEBfHjlpemYfiKrx+gCbXSnYaFVUKfASOl/FFs9zRaHVwpgnbeL10kZNr9FxImlN4w98TmH3fyKhIlRdswxyd5i/thuy0yqE2BwBT8XeKyh2U20xOuETqailqZ4TxrJB7ahe53PVPxBBqFjnzbryQLm272i5lolvR1+SuuaeQmEo55YDtUOLy6GYHHwWq6lXL8kV1U0afHDoxf1P27lB9/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:19:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:36 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:03 +0800
Subject: [PATCH 10/17] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-10-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: ade90cfd-695b-4720-5c9b-08dcedb2e414
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkU4S05wdDIzMUlhYi9kdDRUNmtyZVZCdlpFM1RraStQeHhicG5kTVR1MzJ4?=
 =?utf-8?B?dTVGZnE2MUxqZEhBcDRCTS9nVWsrR2ZPbWNCdXZpem9EOGpGQUw0T1R3Smsw?=
 =?utf-8?B?WHVJQUpRZWc0SVNuYzF4K1ZDbWNFTjRIWEMwdm5rUXFlMzZmajNsWG1TOU5O?=
 =?utf-8?B?QWgyUTlVSWVVYWVtNHh1VjdBc1lpc2ZWQ21hVHVTb1Y3engwdDB2NEZVWjlp?=
 =?utf-8?B?MkNMUzQ3aFJpWTkwbkpZdGtFSy9QTzlJVngrYy9ZOHJkeUg5VTRheG8yRkFZ?=
 =?utf-8?B?dTNZc2RCNnkrU1B3dWNPSTNYRmtIOEtCZDlqOWZzNXpjYjNHMS9xR2dxSldx?=
 =?utf-8?B?WVIxOEh2TDZCVTZJMWZYUm0rcW80WitxVVRNZ0dLTHpYSmE2Y2V3OEFqZDlB?=
 =?utf-8?B?UHR6UDFJd2xURGtLRDBXRGRXaXRFa3VjUjJ0dmliN2U5VXFUMCtRclZyVVli?=
 =?utf-8?B?a1Y4SkR0R0QrM01XdWZHZzhqajM2T0dxaXkrK08xcmZyamFodVprMkFjTGZO?=
 =?utf-8?B?R2RZYTlMTGtmaE4wVnRsVTBudmpwdnBLdUNYcWFPRElzdTgxZmNsRi8rNnE1?=
 =?utf-8?B?aXp0QW1NQzdXVkVpVTJwYmVsUkRhRHRSWHUwdXBzRWQrWDFsK243OHRnY0tC?=
 =?utf-8?B?L0QyRnNKMXVIZUJOdXA5ZXB5Wjg3U0xVWmNHSkZIalZ1cFJ5MkJxODJTY01h?=
 =?utf-8?B?aFJLMkdmSkFEZUJaYUhMNlg3dHFpYXFNdUtNV1djUGxJTHY5NWcvY3JOMDhr?=
 =?utf-8?B?N3ZjeWkvMCtTUmJqK3hvMXI3UFJzRlhPR2hjcy9sY3lveWZ3bzAzbFlncXcw?=
 =?utf-8?B?VXd1MHhBU0p6bFNtQmlqOXM1V0IzNHZqUlQ1MG14MXBnRjE1ZXpqSDFtZkRB?=
 =?utf-8?B?aDdRZ0tMeTJoQmorUlNWQjlJRzYxaC84L1VtcVBzdnI4cnZmTHpqNmluVXFB?=
 =?utf-8?B?WENtdmhQR1ppRjhsQ0ZISUVoMHI5TUFOV2ZZSzNYYXBRVTlYQ0pyTml6SFBY?=
 =?utf-8?B?VDRIMlpmcWUwK0d3KzhISm8rT21RaGFHaUlVaEhUTzJOcmVLd241YmU5L1dt?=
 =?utf-8?B?M0t2RCtwaU1jbkR2SXgrSktiZVdPVFFCWnFFTUJIcUVybk5xdVhOQVc4d1FN?=
 =?utf-8?B?TTN6K3Z1MXVra0ZNd3Fkcm1DY1cyRnlOU1dZMkFSeWFoV05jeklQa3dqcFNR?=
 =?utf-8?B?ckRyckVqbjBXcjgzd3dKMXphVTZISStWTU81ZGdacUV1c2xEbUdKdDNqdU1X?=
 =?utf-8?B?dmdxSERqajd5UEl5RTljMk5HNEYzVlFvWGlsOFYzell5Zm42bGtWWkRoU1Qx?=
 =?utf-8?B?Q3grVDZzUUVQOXhKVHFZQmFOdlY4M2lRQjFiVVhLRS92aWFqdzk5ckMvamd4?=
 =?utf-8?B?OGNTWEZjY0ZvckhJdFh6TkJrWG80a1hnZk1ISDdiNXFnTUJJTGlOM09iYUdz?=
 =?utf-8?B?MDhmbm5XZk9tKzVtS0lyWnk0ZTFYeVAvZVhDanRqbmtxVXJjeVJweHhvbG4w?=
 =?utf-8?B?Mml6b0dNUCtORFowdnVwWUJaNTBXb1RHOExKeGViTnpCei9kcy9HeUNZbnJa?=
 =?utf-8?B?eTZ3V1dFZytkRnJGMnB2YXBMWVBGSlBxUDBucFEvTTBqUHhJV0ZMKzB2dlor?=
 =?utf-8?B?NXp1U2xCSnB5RDhuMWl3U3lBNUQyZm83bVN4VThlN25PNlhJY1A5V0dTd3dt?=
 =?utf-8?B?cEdTY05rbzBnWTI0dzVZUzEvL0plSzQ3UTFLTngwUVZ6QlpVVnQwNkxLL2xK?=
 =?utf-8?B?dHFZelowWjBZbnNEU29OcEN0RnV2SGxPNm1nT3pDcFhJV09zL0h6dXYxcjJn?=
 =?utf-8?B?eWNpVEJCSTZjSDBNMXpTQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHA3MnpHbmR2b1lBUDMyR1F1L1ZIeEczNkxCQ2Z2Y3ptRVhScUhXeEhFVFZy?=
 =?utf-8?B?VDdRMDZKWUwxWTNoWExVNlFxay9QZG1xZDljazYrN0xia0gyeU1remROTDFK?=
 =?utf-8?B?OFhqQ1NIMVJ5Rk1WS0xHMTFZQ2xETkRSQWluSzJRT0NWQllld3JhYU1JUkZS?=
 =?utf-8?B?RnFKTERKdUtoL1ovcEdBSVFhdXNKV2tTTWdlNWc3dVpSSGZ6aXlSNFU1Mk5i?=
 =?utf-8?B?ODExUUh1YWNlUFZXazJyM2VmL0JtL1VWcmtyR3dtWDczV1RESGNOejF3RFVK?=
 =?utf-8?B?VVk1TjU2VWYweFM0SlRUbGljUzVscGp1Sm5RSm1zUEduNjgrMUh6Q25FUmpV?=
 =?utf-8?B?MG5id0RoSFhzTnVDWjRGbm05UjJuMjM5SkFWb3NtYXA3VUcvWE1ENGZSMzRx?=
 =?utf-8?B?dzJKRVNVeWxYRlYvaGdETXJ4L1dhRzM4cU03bnN6SHh0RW5Bb0QzR0ExaEtl?=
 =?utf-8?B?anZHOWtIVDlxM3cxYkg0WXpSeFdBc2JEKzZmQzN1aW5QS3ZLcnFPRHVDU3Fn?=
 =?utf-8?B?WU9CcUpVZEp6Z2RLQ2h0L3R3RC9veWlDRjMvNStPTWdPQXhGNW9qNmx2c21l?=
 =?utf-8?B?cjhQaEEwUFk0OTlFMWlBU1dsWDV6M25hOUp0SEtsMHMrak1Hc2xYQ1ZuV2Vy?=
 =?utf-8?B?QSthWVdyemQ0aW9ReHF2bEVNNnZRY1RSZFNaVlkxaWVJcG41MjVDb3FPdktH?=
 =?utf-8?B?SjVEMFpjK0I0QkZVN3owOFgrOUlJR3FEZ3poNUdMdHdxZWdKdVRVS1RLZFpk?=
 =?utf-8?B?bUgxbC83cnA0TDgrUWxPL3EvcFAzYVJvYjBGTnpNMGRreWhRZm1XbC9QbVpF?=
 =?utf-8?B?WHJYN0xlR2l6NE1lcEUySFJMb09DdFNydUxMYjhuWXRmdUdTTU1tU3U1R3FN?=
 =?utf-8?B?RVc4SDNSd2JjNU1uanlqQm5UN0ZBRkxseUM0bEdvRVFQYXdqWU5Md0gxZ2xB?=
 =?utf-8?B?VnlzRU1aNnZSOHI0c1E4TDE3bWhvblpybWI2Y21RTlc4Nng0REFDNk5UT29h?=
 =?utf-8?B?VjR5dnRpME5NNkxkSlR4d1ZFbWM4a2ZoK2FtbVNTZVBBVW9GNjFaZkVZYVN4?=
 =?utf-8?B?dVROL0daYW9tNXRaOHhsRktTZTBXVldhWWw5UjdsNHhob1JuNG1Rd0pTSEh0?=
 =?utf-8?B?Tk50NHRVQ3h5cVV0SzJ1ajhhMmh6OXpjcGZ3SzQ2Z2d3SEs3aXREWnBvNmNv?=
 =?utf-8?B?YkhWa2QvemljWVdRZkFpeVU0aFBDdE9OdllYVjUwbERZZk80MG1nTHpuek1Q?=
 =?utf-8?B?QjFka1pDY3U5ckJDd1lodGg3VTZ2Z1FqRXkzZmQrTEZNK0U5NnNtKytKNjl0?=
 =?utf-8?B?TmNVMXc0SVJiRkllK3E1WEUwL0dKRUNpZll0Z3BnMkRJclBCYnhZZWJRQ1B5?=
 =?utf-8?B?V1plaTNpakRmbENBdGZoTlFwcEVsTUlsUTViQjk2VGdBZnNpekZRaTBuT1NH?=
 =?utf-8?B?TkZTTnRXOUI2NHVxRkRVUEl1d1M0bkFIdDM1dDViN1VnVzIwU2xZd2xJUXhV?=
 =?utf-8?B?Z0NSSFRJM1hxV3haREV3Yk1TWjJxV0xhSkxuV3lZQ1FYeGtUY1hiMnhtUGtn?=
 =?utf-8?B?YitxNTNRMVNxQis5SzczRXAyOTFRSEs1a2luS0wrdTlXc0ZDcjFtd2hYamRW?=
 =?utf-8?B?eGlSRGU5NUVzR1UrNk02ZzFxa2t1UTZUZEN5eUlueVRmWWNBNXNCUnY1bHJV?=
 =?utf-8?B?SElHNnhIckNTRE91VGJvZGl5czh5R3JVNTdOZGJraXlpSndlUmNJVDUyTjdI?=
 =?utf-8?B?TnB0Y1dPZnRrVHVONHRtbUZQZkx3OUlWZEZGaFYycStmSXdmUGpsa3AydGVz?=
 =?utf-8?B?N2dCanRKMFhsWE95SHR1WHNWM3ZZeUFtblMvTDBLS2JUdEE1b3JGWHllbmFp?=
 =?utf-8?B?cE9SMkNFajR2NWtnNGJabFRENDZkVTBtS1B0MmN0K292VitZY2oxdTVhV1NR?=
 =?utf-8?B?VnZnLy8xTG9kZm5paEhQeHlQQXZVUm1vWHhNUTdOZHhyN3ZTQ0dJbXlOemly?=
 =?utf-8?B?aW9Vb25iK3RGdzczaVJ3QXJJSGpZcFlRM0UxZmt5dzJpY1h3UHl6MVBHZFJ1?=
 =?utf-8?B?S3ZWbzUya29qUSt5OGk3UG13RFJzT1Q1U3R6QW9TUVhabWxqWlN2eFNxQmdl?=
 =?utf-8?Q?doPvt2nH/4tSNC1uvpfg8PrZU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade90cfd-695b-4720-5c9b-08dcedb2e414
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:36.7823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WsNfIVyc9zMD+Ai6tA/x8M8q9ieSjWZ/9VT9oMOy2nlKOEmGu5oNFog6LGh+SIC0/+/ixyUQW/U/+io1o+f0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  |  7 +++++++
 arch/arm/mach-imx/imx9/Makefile | 11 ++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 4d32c28670da3e2aab35f3cd009ff3c7cabd4edc..f594f998895b9578ea43e83ecb6579e1bce9c88e 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -16,6 +16,13 @@ config IMX93
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select IMX9
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select SCMI_FIRMWARE
+	select DM_MAILBOX
+
 config SYS_SOC
 	default "imx9"
 
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index e1b09ab53411d2e104ae795b909a32919e02ca6a..8d43ea2b267e2608df2e8f140c91b626dd969842 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -1,10 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2022 NXP
+# Copyright 2024 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_SPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.34.1

