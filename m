Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85060CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C356683A36;
	Tue, 28 Oct 2025 09:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KGmjN3nZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8361783968; Tue, 28 Oct 2025 03:48:32 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABAC838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmoRh3Bo0iIEcV7LEp3ek/HkZy7e8Hf4IUiQ0RsWCx5kCsduVOFSpHH062crEKBsDpEFK/3+3xYrX5O7emaTaN4wA49dmeFhW47I+DbMKtb7yDlBJW7pc+fICoE23s5gH29+oSerpnKQCzJsyDvMnnHmRWEE2h6uj8JWh3H0ROl6ZqhTlidUVZPOkBoJkyc3j++cu7Llh/7mPRx1CjhnvrlPb7Jl6LN/8BXwXbYncaCOgfILMp1149R7H6is3Z7RO2if2CpxlZF/ylBIz66//2B38qya+GdFuzN95CotL2fZ6LdHOtownsZCVHtrGCM13XWt8AP9u9SrcnqtvUl7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqRKicI4tclAkiqk3HnniMgZkOkhDJCVaixrUG7AHJA=;
 b=YrtX4aDhX4sFjRyMcNTFF0OKOVS0sd21m+o1ixbzrrYtehlQH75OTVEshY3zZyBlv1N2ShY7oXEf2/RfAOwfKHuDgQul1Ri8oMQZZKkUkEvVs7LBaDt/Vl8fKHjKicMILyZoPns1wVAtHeragK26FtxkKBPAG+M3+UFudNWIOwYsZI6guUbCBTQWvfZPo7ESyTZmLfQjewgLqsWKKBUaTEYA29OnqX11KDsNBpCyEeZJaKb80xnbxnUcLaiFr+ciNi5a66rCGgozW9dtWi92N+MiU6EQrNUle6CiAAjFfkwI+hdbGd8w9tyh4lj75Ocmp/BcRKA3SPrMHf9+PAvqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqRKicI4tclAkiqk3HnniMgZkOkhDJCVaixrUG7AHJA=;
 b=KGmjN3nZRA5qNmnRRBusWfaZFUeM1WPpQ8wLXYVRweaGxjkpgoBahgwKC8h72LQlLjU4+3Gapw78od/2bBUh+jXe2v6ryu8hZYS9rgVhfrqdSO1V9i3AtvylIIdF5bT5k5/ht8eAtlEb+BhBqUHBcTpGxUGsHyDjEga0LrX2BRlv5FmwcmmO28tAWL4semj1/rW/zbZ89BsQ+uCwrUhLATvIyrA0QMtjS2R571sUMDcaLiqSs7dgqsViSAHOPPlpK+YThZh/LxUEbnQBSCglnbptu7RoZ7ybmHwdTyxiMLawpWoxFK8h08cwIzuWlGhOYMDmiL+lf/NW311vdSWASw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:48:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:48:28 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:29 +0800
Subject: [PATCH v4 08/10] net: fsl_enetc: Add i.MX94 support to NETC block
 control driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-8-955b8370c685@nxp.com>
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db95f5c-406a-4b77-745c-08de15cc78e0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXVEMHFydlhRREpYZ3BPVGFWYUg3UzBUUThJN01NN0JmdytNbDZXbkhlQ1hy?=
 =?utf-8?B?K1padFUzSmtBRHdwcW43ZVp0eSt6WUUwdGg0RklocTVyaWRKcnV3aHJvT1Vs?=
 =?utf-8?B?UFZJSHJKdEcySUJyejdjOFNvcUhQVzIzRVZmTHllQUJtbVpvVmpVZkUvNXAw?=
 =?utf-8?B?WkxBSXF6OFZzY2xma3RRcCtFYmhweFpoMXZ2c2Z0MytMNFh4Y0p1bTM2dzBp?=
 =?utf-8?B?NnRzalRGUCtuOXcyOTZDVW5UV0ZXVFcyQmVUdkNxNnRtM2Z3ZVloQnNpOWQ2?=
 =?utf-8?B?NVhGR2VWQThRQTJwRWxOSEJqRlZhUkY4MlQwam5lSU5jbGsxZkdaQnFMMWFF?=
 =?utf-8?B?WWVzTFJjWDl3a3g3N3VQc29pYnFZYjBCZW5yb21iek1PZFU2NXpWOWNhVjdC?=
 =?utf-8?B?ekx1UEU0dXdmMGdZVDU1NFRETmNzaU5jdWVJSE82Vm5HVkJmLzlSYXVOUjhj?=
 =?utf-8?B?aE12UGpBYWZJMjZKbGhzMFp6N0VtWUx2KzROVzRpWFBhaVFOdCtPVEViTDIz?=
 =?utf-8?B?ak5wNFJ5TGY3ZEVuenUvY3Fja0VBZXZ3WFVsN2Yyd1dmOFRoVWR4TERacVNI?=
 =?utf-8?B?VXpqcloyVlB0R1dXMnZRdGpFQWN4NTJXUFBqL2pHVXdsaGJPNlArNXFYVjd1?=
 =?utf-8?B?QnBFZVFvU3ZnSmZkYnBkd0hwbFBRL3FhcGYyK0tkVW1UVXN3NHE1d2VkYWlI?=
 =?utf-8?B?VEpkUzJudkhlZjZyZUlvMHI2RFBQSk4zbytDNmpCczc0eCt3UWpXalpwc3Fq?=
 =?utf-8?B?bGlsUnYxa2tFYUZDOXF2dllFOVBjVzgxUnFpekR5WHc4bWIxOU5Fai8xVzJw?=
 =?utf-8?B?MjFtV3NlbmtJeUtYUkhBcVVpYTFDYm9KeTJwTVBJS0o4dHNpWXg3bmZub25v?=
 =?utf-8?B?RUlYTWlaMHNlY2pDQ1dZZi9taENNMWMzVm5ETFk0YitaWUxram1JOTJtTnE0?=
 =?utf-8?B?TnRkc2cxZlZzTitSbCtxUTA5M0ZRdnQ2REd4YnRlMUZYQkhQMDY4dFR6cFdT?=
 =?utf-8?B?WkhKYWtHck9XMmNFUUI0MlIrb3VGQVBRaFlVYUF6T1hrWUZLS21JdGtNRC95?=
 =?utf-8?B?d2s5a1o4c0xYeFN5aHdxVGQ0M3JnOW5EdU9CNkc3SlB5a3BNOG1FaDh2TXVs?=
 =?utf-8?B?UndzV1BIK29ROENoaDE4RktscTlzbWpOWlNqM1E0Zy84TWNZclgrVWxFUTRS?=
 =?utf-8?B?d3d4TTVyaVgvSXcxNzBBUW5KRHFWTERzeVAzdVZkTmVxNGtCVWRZdHFPSEVX?=
 =?utf-8?B?djNXMjVrdExCRjUwS08ya0hSWVdLZ29HRmx4aGtWeE1NUUt6a25YdmNRbllF?=
 =?utf-8?B?S0tlZzNLaXVOMHZzVmlXSDUxNnFxKzdmTU1UYUY2dm5DSWNPZ0loR0pXNzN5?=
 =?utf-8?B?V0ozUkxLNldVN0R4YUpVZyttR2lxMUxld25nN280UVBjNEdwajcyZk9KQTRk?=
 =?utf-8?B?bHFrTW5vdGxIaGRoOHZJN2ZBTDdjazhsei9wUGVtbzc5ZngxTjlMcTRoUkt2?=
 =?utf-8?B?L05NcG5Zckd3WTh6RHpFYkhKK1JXbUorbWhUNUFBMmlNOFpoTFhLNGxwa3lo?=
 =?utf-8?B?anVtVWp0OGFPOXpEcHJmVFlaaGREcHh4dXVKbm9YMit6U3NHUEVmZFVTLzI4?=
 =?utf-8?B?enJxNG1SWlN5VFh1bkxHSzd2MXV4QW5MRWZWY3pWWXRtQmR2OHVHZEMrTzNG?=
 =?utf-8?B?SHFHcFU0SU03QWV3bjdZaENpbmFUWm9hKzhzTTBXRERFQXgxbUx2b0NqYkFO?=
 =?utf-8?B?bmo4akZSeDJjazhlMVVZVjU0TGo3UkdEY3VpcWxXSGpXc3VPSzNrSE11bU9u?=
 =?utf-8?B?UE5obFJVQXVJdjVIekZKcWVxRHprb0dNMVVBdC8yR0d0bXEzQzJwUHhSY2Fy?=
 =?utf-8?B?QmpDTGdyYUxWL1FjK2VRWXdob0pGTXlxYUZtL3UvYS9IbGx0WTRJNmRGWVVS?=
 =?utf-8?B?NGVTWEpSaTI2K09uRk1aQzRObldTL3NKR1NHR2xjMGkzSzRMcnYrYklTRDZm?=
 =?utf-8?B?WU9OWDd0eGxpR2NFRnVIZXF6WDZFUDNEK29rRzdaZ2ZObGxJa3R4aGNnSGVl?=
 =?utf-8?Q?TruM3K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9UZ2lwRmVDS0d3ajdDbmNMbURGamp0c3RTTG9UazVBUUFNUHFjcUlVYXlO?=
 =?utf-8?B?TkFFLytDR2lMVk1NWk8wTGZHK2lndUdvckc4ZjVJNEtuZ1krWWpNMVZYS2NJ?=
 =?utf-8?B?WkJrcTJyblZ1ei8wdW5tNXNsclBoUHFrNUt0MERNTkhUSk5jV3RjcmtsQmtu?=
 =?utf-8?B?WHY5ZVpCOXFnTWsrdENTK2hjcW9tZmhjNVRUQ2w1Wm5GQVFCNVNmZFJKM01r?=
 =?utf-8?B?eFpHdkhscVlGVzZFMWVyR0hDZTJPb0NWU3pNdU0rcUdXVktqaGkwZmtGU2Vj?=
 =?utf-8?B?dFhidUo2SzdZNXVraFVtRXltT1Z3amUzYTZwV3E5YUorbGRPMHdhQlZnRWhR?=
 =?utf-8?B?dmgxbzBDWFV1VklmUXpGV2doR0w0aUlaQ0RtK0Z3NUoxVDZoYVdGZ0p3dW5y?=
 =?utf-8?B?dXJ6dmtyang2OVJoYjZXKzd4bXVBQVFERytNMzNNeTBIQVJhTlAyY2Jqc3gv?=
 =?utf-8?B?N25BeWFMVW5SRm1INVFJVzZxeEhrbTV0eVorUTQ0c0szdVkwQmN6WmFhcFJJ?=
 =?utf-8?B?WXFXNThwdUVJbDVESG5BYmNKWnl0aGNTK0lKVG9oMkNzOXBoMjlDd0c2UFdW?=
 =?utf-8?B?U3hBd1Z2RXdidFVTWksyYjdxUU1QVDFwYjY1MzFoY3p1TFdNSE9jZnhaQ2xi?=
 =?utf-8?B?R1F6eHB4aTZOaENNU2pVRThPRi9RTGVaVitIejR3czVOM1cxMDdVUHlVcXEr?=
 =?utf-8?B?aTB5SDk4Mk9KMGdYQlduMnZSdVVKRmwxYjBKSmtaSVBzYnVlVDVjOVRYVXpY?=
 =?utf-8?B?R2ZyOENLQllVa00vdVFnUDVrSEx5eUVJQ0JBUi9SSFRRdWd5MXZKaUE4YitW?=
 =?utf-8?B?aXhzYUI0WXRDQitjQ2k2M1hkbS9OSzJlbXpiNTNvYjZQM3BvOE1kNTNYb2Rp?=
 =?utf-8?B?K3Y5djNUWFlJbVVFQUVmTDZsNjBqYTNLbmFCVllDK1BvUTBsczlmWUZDbUU2?=
 =?utf-8?B?U1E5UDZRSDhVNjdxRDI5Q3FNWGYrdDVRQnMwU3FqdXBNUC9TV25EZjBvMmVv?=
 =?utf-8?B?b2VocmowakFOMGx1dFJ0OXA1ZXhuTWZ3UXhqOUdtOHlHVGtKTUI1R0lEaVpE?=
 =?utf-8?B?UnorcjU5NGVuZHZOWHVweVFaTzdjZ0ZKaTc1SGNIRXg1NVZWdUQ4YjdjVGgw?=
 =?utf-8?B?eXh2aXc0M0hKVmNTYTNmeEpPS3lOQ2JpS0RwelhPWjJyTVY2YjBrVGZwMHVC?=
 =?utf-8?B?VWxpOTl0SVY1a3VEZ2dSUXViOU1BSUtLb0wwUlY3dFFVYmxONTN3aVFEdVJq?=
 =?utf-8?B?OWl3NE01QjNESGVCeTlxUEFaUzJHbG5aR3JjaDdLYlpPMGdHeUU2QWlha1R4?=
 =?utf-8?B?MDZ3aWpSTzE1WWpVaDNNdThjTit3V0lKcjdlc0lhMkN5SndRQXdveGRnellY?=
 =?utf-8?B?MW1NazB0MTFzc2dzOTYxU0pYZkYvUmdmeXNIanp3TG5EWnQ3QnNxMk03SVd2?=
 =?utf-8?B?cFNvSmM2WnN3RTd2aXhFR0Vyd05VdE02aGdLcHd1TExEbGxJMmdFUXNWMzd6?=
 =?utf-8?B?QXhBdlI2N0tKTmg5WFBmdkZHWjRmUGtZaEhGR0c1NzZWa0xCSjBGQjFwWTZw?=
 =?utf-8?B?aURDaldoMjNtcndrTWk1Mjc3WE5pK2xRWkw4aVl0elUrWGNGUERrN3E1Umhw?=
 =?utf-8?B?R2Nxa2d2THhxcXdBcUJWMUloMVBDTTB0TzdhVTVlYmZkMDMxcXliTSsvNVpQ?=
 =?utf-8?B?eDkxU1hIWmExeXkyS1g2Uy9DTUFtRTRPQUFUcHpXRVZRNll5bGR3ZHdLbmFU?=
 =?utf-8?B?OExMSFI3UFg4cE8vRWdvd3JyZ0MyNXRXYjkxaVgwV3hZRVZ3N0hqbzJMS21Z?=
 =?utf-8?B?ZkRlc2VjeTdRRXBESk1OelpLVnBEK2M5MGxja2NLODRnbjNDbGdLdng0MlM0?=
 =?utf-8?B?UWRoV1FielIreXczblcvejgrT2NZU2hzZDhXREJhVlVPK2xDNHFOMGc0bVds?=
 =?utf-8?B?cWtIclg3SmVqNTkzek0vM1BUNTRkWFpxUy9HbXlRUmFqSnRqMExoMTdkckxU?=
 =?utf-8?B?VTZkU3FjbzYzdThEMWNUdWhPMnR2MDl4cTNJUFppdXBxT1ZtSEtsOXNXdlJN?=
 =?utf-8?B?Vy9vWXVFbkt2YjUvS0Z4TlRtMWxNTDlHaGhHL043cVJBUHQ0Nmt6QXJUYisv?=
 =?utf-8?Q?RL/0mrnEOPo66oN5g2VVBFbM4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db95f5c-406a-4b77-745c-08de15cc78e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:48:28.0671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrVSktQ9EGCpR1pa3ODYGcFSnKSJzyAE/k2WV1q7M39H2FiqbORbIb6y15peXgagBQ9dqGe1EfNjDhPDhz2+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

Extend the NETC block control driver to support the i.MX94 SoC.

Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/Kconfig                   |   5 +-
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 329 +++++++++++++++++++++++++++++++++-
 2 files changed, 324 insertions(+), 10 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c9b35b5a2ff..913670ce412 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1006,8 +1006,9 @@ config FSL_ENETC
 
 config FSL_ENETC_NETC_BLK_CTRL
 	bool "NXP ENETC NETC blocks control driver"
-	depends on FSL_ENETC && IMX95
-	default y if IMX95
+	depends on FSL_ENETC
+	depends on IMX95 || IMX94
+	default y if IMX95 || IMX94
 	help
 	  This driver configures Integrated Endpoint Register Block (IERB) and
 	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
index fecd66eb15a..8577bb75632 100644
--- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -43,6 +43,18 @@
 #define PCS_PROT_SFI			BIT(4)
 #define PCS_PROT_10G_SXGMII		BIT(6)
 
+#define IMX94_MISC_SOC_CONTROL		0x0
+#define SEL_XPCS_1			BIT(1)
+#define IMX94_XPCS_PORT_0		0x0
+#define IMX94_XPCS_PORT_1		0x1
+
+#define IMX94_EXT_PIN_CONTROL		0x10
+#define MAC2_MAC3_SEL			BIT(1)
+
+#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
+#define NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
+#define NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
+
 /* NETC privileged register block register */
 #define PRB_NETCRR			0x100
 #define  NETCRR_SR			BIT(0)
@@ -55,6 +67,7 @@
 /* NETC integrated endpoint register block register */
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
+#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -64,6 +77,26 @@
 #define IMX95_ENETC1_BUS_DEVFN		0x40
 #define IMX95_ENETC2_BUS_DEVFN		0x80
 
+#define IMX94_ENETC3_BUS_DEVFN		0x0
+#define IMX94_TIMER0_BUS_DEVFN		0x1
+#define IMX94_SWITCH_BUS_DEVFN		0x2
+#define IMX94_ENETC0_BUS_DEVFN		0x100
+#define IMX94_TIMER1_BUS_DEVFN		0x101
+#define IMX94_ENETC1_BUS_DEVFN		0x140
+#define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_TIMER2_BUS_DEVFN		0x181
+#define IMX94_ENETC0_LINK		3
+#define IMX94_ENETC1_LINK		4
+#define IMX94_ENETC2_LINK		5
+#define IMX94_ENETC0_OFFSET		0
+#define IMX94_ENETC1_OFFSET		1
+#define IMX94_ENETC2_OFFSET		2
+#define IMX94_SWITCH_PORT2		2
+#define IMX94_SWITCH_CPU_PORT		3
+#define IMX94_TIMER0_ID			0
+#define IMX94_TIMER1_ID			1
+#define IMX94_TIMER2_ID			2
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -73,6 +106,15 @@ struct netc_blk_ctrl {
 	void __iomem *netcmix;
 };
 
+struct netc_devinfo {
+	int (*netcmix_init)(struct udevice *dev);
+	int (*ierb_init)(struct udevice *dev);
+	void (*xpcs_port_init)(struct netc_blk_ctrl *priv, int port);
+};
+
+static struct netc_blk_ctrl *netc_bc;
+static struct netc_devinfo *netc_di;
+
 static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
 {
 	writel(val, base + offset);
@@ -183,6 +225,142 @@ static int imx95_netcmix_init(struct udevice *dev)
 	return 0;
 }
 
+static int imx94_enetc_get_link_num(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC link number */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_LINK;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_LINK;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_link_config(struct netc_blk_ctrl *priv,
+			     ofnode np, int link_id)
+{
+	phy_interface_t interface;
+	int mii_proto;
+	u32 val;
+
+	interface = ofnode_read_phy_mode(np);
+	if (interface == -1)
+		return -EINVAL;
+
+	mii_proto = netc_get_link_mii_protocol(interface);
+	if (mii_proto < 0)
+		return -EINVAL;
+
+	val = mii_proto & NETC_LINK_CFG_MII_PROT;
+	if (mii_proto == MII_PROT_SERIAL)
+		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
+				       NETC_LINK_CFG_IO_VAR);
+
+	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
+
+	if (link_id == IMX94_ENETC0_LINK) {
+		val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
+		val |= MAC2_MAC3_SEL;
+		netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
+	}
+
+	return 0;
+}
+
+static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
+				   ofnode np, bool *enetc0_en)
+{
+	int link_id;
+
+	link_id = imx94_enetc_get_link_num(np);
+	if (link_id < 0)
+		return -EINVAL;
+
+	if (link_id == IMX94_ENETC0_LINK)
+		*enetc0_en = true;
+
+	return imx94_link_config(priv, np, link_id);
+}
+
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    ofnode np, bool *swp2_en)
+{
+	ofnode ports, child;
+	int port_id, err = 0;
+
+	ports = ofnode_find_subnode(np, "ports");
+	if (!ofnode_valid(ports))
+		ports = ofnode_find_subnode(np, "ethernet-ports");
+	if (!ofnode_valid(ports))
+		return -ENODEV;
+
+	ofnode_for_each_subnode(child, ports) {
+		if (ofnode_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		if (port_id == IMX94_SWITCH_CPU_PORT)
+			continue;
+
+		if (port_id == IMX94_SWITCH_PORT2)
+			*swp2_en = true;
+
+		err = imx94_link_config(priv, child, port_id);
+		if (err)
+			goto end;
+	}
+
+end:
+	return err;
+}
+
+static int imx94_netcmix_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode child, gchild;
+	bool enetc0_en = false, swp2_en = false;
+	int err;
+
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		ofnode_for_each_subnode(gchild, child) {
+			if (!ofnode_is_enabled(gchild))
+				continue;
+
+			if (ofnode_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild, &enetc0_en);
+				if (err)
+					return err;
+			} else if (ofnode_device_is_compatible(gchild, "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild, &swp2_en);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	if (enetc0_en && swp2_en) {
+		dev_err(dev, "Cannot enable swp2 and enetc0 at the same time\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -238,9 +416,99 @@ static int imx95_ierb_init(struct udevice *dev)
 	return 0;
 }
 
+static int imx94_enetc_get_enetc_offset(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC offset */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_OFFSET;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_OFFSET;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_OFFSET;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_get_timer_id(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC PTP timer ID */
+	switch (bus_devfn) {
+	case IMX94_TIMER0_BUS_DEVFN:
+		return IMX94_TIMER0_ID;
+	case IMX94_TIMER1_BUS_DEVFN:
+		return IMX94_TIMER1_ID;
+	case IMX94_TIMER2_BUS_DEVFN:
+		return IMX94_TIMER2_ID;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv, ofnode pf_np)
+{
+	ofnode timer_np;
+	int offset, tid;
+
+	offset = imx94_enetc_get_enetc_offset(pf_np);
+	if (offset < 0) {
+		printf("Find unknown PF node.\n");
+		return offset;
+	}
+
+	timer_np = ofnode_parse_phandle(pf_np, "nxp,ptp-timer", 0);
+	if (!ofnode_valid(timer_np)) {
+		/*
+		 * If nxp,ptp-timer is not set, the first timer of the bus
+		 * where enetc is located will be used as the default timer.
+		 */
+		tid = IMX94_TIMER1_ID;
+		goto update_reg;
+	}
+
+	tid = imx94_enetc_get_timer_id(timer_np);
+	if (tid < 0) {
+		printf("Incorrect bus/devfn of ptp-timer.\n");
+		return tid;
+	}
+
+update_reg:
+	netc_reg_write(priv->ierb, IERB_ETBCR(offset), tid);
+
+	return 0;
+}
+
+static int imx94_ierb_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode bus_np, pf_np;
+	int ret = 0;
+
+	dev_for_each_subnode(bus_np, dev)
+		ofnode_for_each_subnode(pf_np, bus_np)
+			if (ofnode_device_is_compatible(pf_np, "pci1131,e101"))
+				ret = imx94_enetc_update_tid(priv, pf_np);
+
+	return ret;
+}
+
 static int netc_ierb_init(struct udevice *dev)
 {
 	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
 	int err;
 
 	if (netc_ierb_is_locked(priv)) {
@@ -251,9 +519,11 @@ static int netc_ierb_init(struct udevice *dev)
 		}
 	}
 
-	err = imx95_ierb_init(dev);
-	if (err)
-		return err;
+	if (devinfo->ierb_init) {
+		err = devinfo->ierb_init(dev);
+		if (err)
+			return err;
+	}
 
 	err = netc_lock_ierb(priv);
 	if (err) {
@@ -264,6 +534,31 @@ static int netc_ierb_init(struct udevice *dev)
 	return 0;
 }
 
+static void imx94_netc_xpcs_port_init(struct netc_blk_ctrl *priv, int port)
+{
+	u32 val;
+
+	val = netc_reg_read(priv->netcmix, IMX94_MISC_SOC_CONTROL);
+	if (port == IMX94_XPCS_PORT_1)
+		val |= SEL_XPCS_1;
+	else
+		val &= ~SEL_XPCS_1;
+	netc_reg_write(priv->netcmix, IMX94_MISC_SOC_CONTROL, val);
+}
+
+void netc_xpcs_port_init(int port)
+{
+	struct netc_blk_ctrl *priv = netc_bc;
+	struct netc_devinfo *devinfo;
+
+	if (!priv)
+		return;
+
+	devinfo = netc_di;
+	if (devinfo->xpcs_port_init)
+		devinfo->xpcs_port_init(priv, port);
+}
+
 static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 {
 	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
@@ -272,14 +567,27 @@ static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 	return 0;
 }
 
+static const struct netc_devinfo imx95_devinfo = {
+	.netcmix_init = imx95_netcmix_init,
+	.ierb_init = imx95_ierb_init,
+};
+
+static const struct netc_devinfo imx94_devinfo = {
+	.netcmix_init = imx94_netcmix_init,
+	.ierb_init = imx94_ierb_init,
+	.xpcs_port_init = imx94_netc_xpcs_port_init,
+};
+
 static const struct udevice_id netc_blk_ctrl_match[] = {
-	{ .compatible = "nxp,imx95-netc-blk-ctrl" },
+	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = (ulong)&imx95_devinfo },
+	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = (ulong)&imx94_devinfo },
 	{},
 };
 
 static int netc_blk_ctrl_probe(struct udevice *dev)
 {
 	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
 	struct clk *ipg_clk;
 	fdt_addr_t regs;
 	int err;
@@ -318,10 +626,12 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 
 	priv->netcmix = (void __iomem *)regs;
 
-	err = imx95_netcmix_init(dev);
-	if (err) {
-		dev_err(dev, "Initializing NETCMIX failed\n");
-		return err;
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(dev);
+		if (err) {
+			dev_err(dev, "Initializing NETCMIX failed\n");
+			return err;
+		}
 	}
 
 	err = netc_ierb_init(dev);
@@ -333,6 +643,9 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 	if (netc_prb_check_error(priv) < 0)
 		dev_warn(dev, "The current IERB configuration is invalid\n");
 
+	netc_bc = priv;
+	netc_di = devinfo;
+
 	return 0;
 }
 

-- 
2.43.0

