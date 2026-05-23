Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28C2CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 469528490E;
	Sat, 23 May 2026 14:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cM4Lgai6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C48084926; Sat, 23 May 2026 14:23:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0C484915
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T27qZEx4tF9+ObYA/Wnlo7BKK+qNX3O9jcdN3YYA8BpUMu3I4SbxVMpZZ0nBBrQlf5fRV2pi7h8RF9pVjR7AhHNrvSF36xI1IFeZ+Ha3gYW5awZ/3ZUiIwcvJGVXVGBdk4hUtNokw5brpnSzLtLc1Lfq2iPFLhhH/AS+CE0Jtq4sVLZVI655/5rnX46ARqw5iBYdfZ1Y07x/SIyTH2N3HCIcrouEftcxzAv+MbDLUF+Af0ysQWWWYulfG3wCs6/TSVV7gYwIbqgKtYgWrRi2pMzwcy+/swly5Dtxhw6koJE3X++4RyjV0QO7h/xxX91TvqCbaKAsi+h63aDNtEjS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/UXQNrQWDyBM2O6QWJERgZKtICsbc7ifRafAcF00Pw=;
 b=V8XXP4zkT5QHs7mBivj2gdaQ97e7sYiJg/UzvNj0LHqndh58p24sUo5rPogIgRcjApWKEhJSpjwTxhZw8v5Pciy55nZm3EH+cgTUmHXcBaOeJFY+4v+qDJJOh5CEELXwj8OBLTAFr75bC8M5YrIuOGE4LoM/oB66S8EoxVOLty9JnYPyz1uBJ2bEu6yLVy5OFCBMDcX8XWEBAELfGqAgam8yLYHQ8BzgtL8YPbQwmeYqptep+277cKjVDDqU7O6KAE9LwkDcUMGdD/7yrWkP4QbOobjVJpiWJjvlZWlCcFhVFNk1IWPxS4BQXsWdCKLDTnAGGr/CvEVHCKfaeB6UOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/UXQNrQWDyBM2O6QWJERgZKtICsbc7ifRafAcF00Pw=;
 b=cM4Lgai6H7ErC0pwIGVMBzz1GRkQZCKrRMJF889Rlon5fWBWpfqUYjgEuknMa31D3dGXz0Ph8sYzcDi+y6xZKuw6OtxxyQ47ZtnLIToMghaC27WDEqT8LtxX7EImd7NTZHQkyMgLEBJw3eveQmNHEW2ad8oQnpp2L7lF+96suuLljFh49rxK7BBnDVpMq+2nqTxHQOPp6P1dG7/UbCif+W2O9VBvnE0ktAJLhtue3OZWgqsciZc8OOCX86FYYy0MJ/NpjMjb6yoeM0kAFpoebXqxWG1ms+6GYOe7wuY5BTxnIAm0RTXzUSTIN5QV/Eg/d9KKIrR8E3Yc+m6pKAG5cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAWPR04MB11708.eurprd04.prod.outlook.com (2603:10a6:102:50c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:29 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:56 +0800
Subject: [PATCH 13/13] imx9: Select OF_LIVE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-13-2898c9eca9f8@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAWPR04MB11708:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e442baa-3c26-4126-5468-08deb8c61908
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: qaqrAlR8k2YINvBoVjw6UwxZS/zro2zvFA4OPqa9xtXO5M6Pk4gvN/3bltpITH1Sn+1x9ZLfK4Mpw0n4gwXapJBbfTmnSzP7CX87NlMfit4w0at37imxRwYAaO+L3MFGoYKzq/6t1E3Dz6mfN56ogOqN+GH3WPA2BRjXLeeNxFTe1jdq2ZQHq4MKGbFG9k6QnKqvId5k0T4Ma/IbKN9uVktv1ExXHMf1J2p82U2PrGH63KA+LFP5X+pz9U6yckPhv1TePlMFGQhcBS5heP4gZqyK1SGeJVEzqaSP3gI2XyFCWe0TWRww5ldL6qpwXJZcYRX0T7qBZJb9rkNMtUK/p+B8BcQiH3m+iyLwQxXh05OVb/DWa9CuuC2Hdd9Nolmxrs2FRch24iXwVdlX6tmuvlK3/UflRZjoT+GdDkjyKdXbTHP2l/Ql37C4hrkQ3SEPgDLntl3xj7UN9oUghN5X+Fl0B7V3t94vkkIkSjFCzjvfrWAtu1hure3poltujpRt811ZjRxwIPLbIujVErHU9EEHDRS+2JT8q/kw9ClQlXxaANFnkvMhrFR0n5gDGtd9x8wC/pDz6JPIyO3C1fahuc6Pi8UJv7RDQsohiiYgUZ54HrN2Jgyfr6pMIkmS7/LiX2CEn455WhtL1jEV/4wcYVcW5xZ47JwlrqCF8adH8wBGis623JMEsgg+y8Sx2UVqmLRHRfpB04DBQPG52aHAbE1+/chNowHSAaoO4PpsnwDlxsiML4ln72Cp6DpXGtbp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBhaEdxNzFyUW0xM2hjWXNVNUpoSUF4TUFoUGh3ZS9SZ1A0QVdCcHcvakQ5?=
 =?utf-8?B?TmJXc0dITVBCZjdGYTlRcncrRnlhTER1NVNKUkMvOHpvVEtIaFNHU29CbmRQ?=
 =?utf-8?B?NllsWXVDQUlITEVzMmNBM2dtOWM3a215ckdUWFZZZEdEZ1FzNVBLZmdncTNi?=
 =?utf-8?B?Qlo3OGMxWnVlVVVwYnMyQ3kwQUloNE1RdVNTUkJKeFdCNDJyZElQOWNxUnc1?=
 =?utf-8?B?RTdMSDJudExmTFIxaGQxMk1OdGFzdXh1UzI3dnB2YXJCYS9QWWhMTnRyMUFX?=
 =?utf-8?B?aVlrRFlOOUpiUFBEVFMwRWFxVkxJallKS1Jzd2o2cUtLeEFLVVVhUmZoWElC?=
 =?utf-8?B?anFrK3k5V2NqY1lpTTRtNDNPY2MzRDk5RGY5Vk1kSUxPaDVUeUZFZ0VqdjNz?=
 =?utf-8?B?NzkxS0MzY0xBbVRObmVHVmNhZ3dZYTJqelJhejlwK285aTduUEYwUUV1UEZU?=
 =?utf-8?B?aVQ2dzdzc3F5VFBzTDNmK20yTnM4K2tDUk4rOWNReTI4RXgxTXRySkJPYUh2?=
 =?utf-8?B?bTY5c3U4SCtza01mM2pDYWlhTHdxVllRcHZ5SEcvRm16OExlV0E2VjFrMzNQ?=
 =?utf-8?B?a2tVOFV0UFZQZmFpSkJkVDFydWhwUkhYVUFjdUV1K3VNUWJZUmhqVFN1M3dH?=
 =?utf-8?B?cGxjTDFjZkJBbnMrem9VQVBrcUtMVFBPNk1mWU1QdUkzMUhLU2s0c1B3RjRv?=
 =?utf-8?B?WUFkT0duM0JLYTkxM00xK294SEFndmo1TThFUm04cUk5S2dkSFhseklZbE1k?=
 =?utf-8?B?RktYUUh2U2NWWDFkY25FMDNoeEJxK3J2SzNEeWVRK0NSamc1ZnU3cW1OQVlF?=
 =?utf-8?B?a1JRbzVrdEd0ODNjWW1tbytxSmQyQ2dKUXFGNXN3VzBnMjVGbjBjUllzVGtY?=
 =?utf-8?B?ZTEzQzZQcm5BNkJLOEZCb0UxWUt1M01tQlBqV09PelE5OHJDSkZtNzlORnB6?=
 =?utf-8?B?eEl2TlBsU2c0NUlQQmIvZ0QvdEM1SFpXb2Z3akFPZjROUzRNOVF5MEJiLzBO?=
 =?utf-8?B?TXlqVjg2clZSaGdxMnhMNXM1bVEvdm40TWlIaFd0dG8xcVpabzI2SnBYR01x?=
 =?utf-8?B?RUFDazRVaVI4K2Joa3Q1RnVGVVdSR1g3LzNJQzJGejZvSWlQdmU2QWsxRENI?=
 =?utf-8?B?c1diTHVtc3g5Um1wRldma2lLMUE5MDlVNkw2T0VZamhzcjJ2TVZMYUszbFQv?=
 =?utf-8?B?M01rWjcxV3pvZmo2cTdscmZHWnNhckNKOURNbVlNVkp5eWh6dTRENFBncmtR?=
 =?utf-8?B?clVYbGZSNTFYVzlBOEx5TjdBb3FCbGI3WHc5M01SNU1uNVlRSldnZEk4aGVo?=
 =?utf-8?B?Z3Mzek5oSzhxdG1DdzBGcGdwOWdaRGpsWnNzTEJ1Sm92d1FuNXdaK2JWcGpp?=
 =?utf-8?B?ZzB4NFJJSGZUbXZ6VWNJZHg3d205Y3VZeWtweVE2QlJxRWI5N1NyZksxMGpF?=
 =?utf-8?B?UFZ4VjhrM01odFRXZHh6dFkyWmZZWWMvZGx3d2JLMXZyS1pQbTVSMzEyRk1B?=
 =?utf-8?B?NkZuVTZDNVptOGdSZkxGWElMbkNiYzMvK1BIOVpLWnZwdmxNZkE2L1JTeHRl?=
 =?utf-8?B?eXNEc1orSkJYWTF1Z21oa1NLOFhCUTRWcVRGbCtCbTNETmIzeEVSdXRTdGUr?=
 =?utf-8?B?ZUhDcmNNcjY0RjdVVGRuSjQ3YWJvTWJiVnY0aSsxdThCdC8ybm9zaDI1SWdG?=
 =?utf-8?B?OXlOMHNGSVJpc01WVms0cU5wTzFlZFYxSGRsV01KVjA3MEw0WCt6Tmh3cHdK?=
 =?utf-8?B?NVJlSG5wR25VYkhYU1FsL296ZE5VMlMxS2pGSHRGNDEvWThSaitnVndzM1FC?=
 =?utf-8?B?bXNmN1c5MkhIZ0t0VTkrYkp0a2FUWTM5Vmx6bENyUGtaaUF2RTJNT1pUdldw?=
 =?utf-8?B?RGo4SHdocXBCZG5oeWhoNkxqYjZaaHBwaDZzVktJYVAzaEtLN3RHb0J1RDZE?=
 =?utf-8?B?RUtGUUVmWFZpd3pSUU9NZ0IzSWxJcmRTdVRLUzVDaWF5NzlOTGJ4QUtybXNk?=
 =?utf-8?B?QnhzNm1WMFhOZXpFbVNzNmMxejRPcTcxR3VXYWpIUEVmWEMwQUNzb0o4ODhG?=
 =?utf-8?B?RkdpaFp0T1BLTFF1M1owMVNFa2szTVEzam9vSlhsNmRxSnYzNTFENHJ3Z0dB?=
 =?utf-8?B?Q3dISkVyNm1DSzlUREhOaGxGTTkvMEZzdlV2T0FYazZxeTZCVnNEaXFJQjdB?=
 =?utf-8?B?aUNkczBob0x5SHdsZWY0SlQ2eW9GMXQ5WWFhc3c3NmZHYUtGS2xZWExmK1JX?=
 =?utf-8?B?NG8rVnVWOE4xd3ZLdkVGVUJ3U01FNEpZa1prc2hKTVArREkycjJSdnFObEVH?=
 =?utf-8?B?TlZBVTJsWDlyaG5LcEJyWDZ6aUMzMDYwVy8zOGtEQ1UyRFY2WjJiZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e442baa-3c26-4126-5468-08deb8c61908
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:29.7433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qf8L8kvnzzwu+1TxnxdSug2sOnGvrUBLDkFBdQugr3/NDGZhVyRoY2zBhGhnyjytvQNP8VI/Nw1m0na3wE54Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11708
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

Enable the live DT to reduce the DT parsing time.
Test data on i.MX95-EVK:

Before:
Accumulated time:
                26,205  dm_spl
               483,991  dm_f
                22,977  dm_r
After:
Accumulated time:
                26,229  dm_spl
               484,772  dm_f
                 2,667  of_live
                 1,003  dm_r

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f072e6a9e3d..a7f05e7f8f2 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -14,6 +14,7 @@ config IMX9
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
 	imply IMX_TMU
+	imply OF_LIVE
 
 config IMX93
 	bool

-- 
2.51.0

