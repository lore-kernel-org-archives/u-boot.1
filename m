Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB99CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263E5839D9;
	Tue, 28 Oct 2025 09:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xiEhooyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B647883968; Tue, 28 Oct 2025 03:47:48 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE08A838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVhKWDHilOPtQu75L96dQkJa1H8IIBtxdm084IHo1mlutC8ts7FLeVEttFdSTJ7gQXNqZbMsiDVCqAn+poH137o4mZq4Obo1IQpKY7UnmlMm4KWeJlKhaS6NkGMMG5LpZ4nAcchQPg7lVZ5c3IKUr6keMLG5g3yNR2Gp4cydO66cR26UGUxyikmcvdsRYSBuXNEnrHQt4ekyODO/YFzZt0JAIxy+sCcbD7/BtFoBKeRM5Vad/uE62g2OFv+oHEMqjYXSTC3axiCgleW/3ZDFxhGRSkFIk2lgEkxP4k8K0vLxoNvunjf1armFHTT4pbFPtlDYpb0dF9dGCSMKRuZ8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2fHi31JAPlN12Io1Dbb7K6qhFfn87ZJCPTZM4+h5Ws=;
 b=MejSOOQMBdaTyX6LFiQVRt0ns7n5c98uiCdlKDBhb7S38eIAvXgIBBYed9ps/hAnW3HFMRpS5zwytrxgIWk0nmvAL9kWGvAgDVldyZuYFecsNk0PYeoT0G2THWEwl+B7PUDcoBfZbUkpcl7k017K++bZQUHJJCYh3ZnSPvBZG2P+3+l/ex/jK4u8dfU44zYoIbKKT1oF15r5sYN6nP6J/GClqw6J9JceXJwXoFsYT2jV1AhWMEstLpbluGTQCcR0kVxYYXkQF7CiSl796bFHNv+KTiC/JPFmeEwzU6Rje0TI5kngW7eejXHCSQwgTWE6tiIqxc6I2wEVbolMInQFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2fHi31JAPlN12Io1Dbb7K6qhFfn87ZJCPTZM4+h5Ws=;
 b=xiEhooyFqPTm61ZNmrRqJSuuCbO14p3YghG/WE10Ry9BQCDK+C2Oj9YzGmsrjmEeJrDRvAiv8mms9fu1EnOA/Rzw5wLtyQuUtr8mq5lvqJuBeNjVEH0rZ4oMyk4tfxkUq3ulpQw0IJdTQe7u7sdhWFBO8oovjkSt5Hvj3738TtKK80/DVwERbNr53X6W8P9/omxkt54SwDnn/4/q4iXvL/4ejr9gj/O7S7es1KUtH/zjcICUaO5GUN/Mq39PvkkOq6YAegRoKKE0dxoEgQvCsdTE6RMX9ARtBq2LqXkqIxOw56qaEDzmtvYTNBPsa9eAE0RNKTFDs4kvzYdRNysJSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:47:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:47:39 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:23 +0800
Subject: [PATCH v4 02/10] arm: arch-imx9: Add USB2.0 and USB3.0 base
 address definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-2-955b8370c685@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0310facf-4535-4298-2496-08de15cc5bb7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXBIRkJ6QUo5cER0ZWdXSTZwUWh5TWhxNlp4Q29DK3orRmE0MlpsRTNIUFpk?=
 =?utf-8?B?Z0F6aVF0V1N5TkVkSDVCbkM4VEo2NWJmeTdHK3dtaEJoZ2JaTXp6Z05CT1ZC?=
 =?utf-8?B?MlFsWGROYk80Q21HSEJSTVBWb25kMUczdkNFdlVpWDNsV25sRjBVOVpVVXN5?=
 =?utf-8?B?b3JsTWhFU1FRd3QzVmE5cVBUbHhUQU0yaHZpNDhCa2JRbUh1RkxEYzgyM1dR?=
 =?utf-8?B?b2VUTllCano0MWtkWkQ1YkU3TEw5M0ZLdDlBMFpkY3RhWmphd2pxQStGeDJG?=
 =?utf-8?B?OGFValFqbk1ucThWUlJBT2ZsdG8zN1Q1QnpwZ05zZHVGNUdkNGVBSWIwOC9m?=
 =?utf-8?B?NVFhMm1WaDZrQlJ6SnQzODVOT3NPeGlTcjNEcjk0aUVzTjRtUTFqWExoUksx?=
 =?utf-8?B?WVllQVhhMzZlaXV2RDQ5MFN6am9UZ0Ntck90UlZEd1h1R1d3SnMvUzBESGlP?=
 =?utf-8?B?YmxHYVRMRlhnNGFOVzd4S1dYUzBTMDg3VnBrVWszWTRUUHovMmVKZXZZSkFD?=
 =?utf-8?B?QmR6RFovRTBiNHgvUE9CdnBjYTN6anZWRzBMMSt4dW5YNXJsK28yVDRqYWpo?=
 =?utf-8?B?anpRS3A1eUwrSkFqbVUxa0prL0w4WUlSamdLVSt5OWt4SkFHRVAreU5WK0Jt?=
 =?utf-8?B?RkJ3dWhHTjNNZzhhajc2eStKNmc1T2RmNGpRWWIwVGR6S2JKdmF6Z1dHcjlE?=
 =?utf-8?B?YW5XL2h0My9qQzliL3hlSG5RQlhlL2JGeThvQkVRRjR1K1IwWllJekFEbTNx?=
 =?utf-8?B?cVRmdm9PR3NSNUpYL3FidzNtMFREUkJqeHRsSm5RUUF2THhuYVNZaDBJYkpz?=
 =?utf-8?B?RnE5UElOMU9UaTBremdXWWxQbnM0U00yZVU2YU5BQ3RWaDhlV2wyTitZSG80?=
 =?utf-8?B?K1hjcDFURzVVejIvSEhmTWpzTDlLd0Qyc1E1YUpiaDBjNGxYT2JaY0p2cnpa?=
 =?utf-8?B?ZmNOLy8zanluWGo3elovSlp5bCtYTVhKMDBiOXdZQUVEMUdTeU92QUNqekZU?=
 =?utf-8?B?SXNYc3dKcjNIaWRVbGlHQjNOSGl0UHVMV1FzUEhDa3FqU0xJZlV0TnBVVXZw?=
 =?utf-8?B?eVZMRk5MRmljUk1sZlRsdmd2S05SWlNtMlB3cGI1ek4wMXRoYVlkbzg3cEE0?=
 =?utf-8?B?ajhoWjRZOXlaUUZ0ZXZUM1MrZ2ErNFJZa0dlS2tLTzNhcnAyZ09LU3VJczc3?=
 =?utf-8?B?YXBpRTVTcnNTMy96RjQ5b3dvM1Nuajkyby9hMW9YaXczclF6eFIwS1ppdCsz?=
 =?utf-8?B?VThMNmFkTS8za0xaSEpkT1M5YUxYczRjVDdMd05NTVdJQnNRTkxTRnZaT2pL?=
 =?utf-8?B?eStQTkkrVHdYVzdNYVVPLzdBdEMydTUvbzMvQ0dWRndoNkZZcnhqei9rR0Nn?=
 =?utf-8?B?OFd4aDBiZEpxM1JSWDNVZE42MjRGYy9YbllJcmN6aHVEbDU4NnRGVUpubjMr?=
 =?utf-8?B?cXpSWFpZZEtIdkcxMDhzV1ZsVU9FZ2ExUkpyaFNnOE1CR3dSNnBydDUxRGRa?=
 =?utf-8?B?ejY4cDZKSjRuU0RXUWtPdm5IOEJXL2cyU1REY2VieFhvZ2MzcWF6eDRialJn?=
 =?utf-8?B?OWJ6citHZ2JQNTkra3h6UWdsUzNjUDVHSmk2TzFPeEYzaGE1VHE3ZE1YVm1E?=
 =?utf-8?B?bW5VUGY5U1JudERGNS96clRic3prdTk1ZXZQV0VwYU1ieG9GUEhoaTFtTjZj?=
 =?utf-8?B?MTZtcWNlVThhVmM3Tmt4YkNLSnhGb3UzUzRoNlZVdlFOb0lOUTRUTXlNQ2ZW?=
 =?utf-8?B?NUlybVl6TjR0NjBZS2ltVmJadzRhVThvb1NmSW5uZm9YQitKd1dqaGVmZTdT?=
 =?utf-8?B?ZjRWaVpBbkhaNWVYRFY0UWZyVzBjQk5HTDJXTit0QmFoZ3ZzZDdHV29MZy81?=
 =?utf-8?B?aGhPT01IeVhIaDRsTU0rTkZLbE5TTTdjTzJ0WllPOEJmQnZDN1hVMDVRaGFl?=
 =?utf-8?B?Y05qQXd1cHZHUEZKdkFjOUhITy9PZFJPbUprcDN5WkJuNkVmaVc5Z3pmWTZq?=
 =?utf-8?B?b3luRllXWWtBRk5yd3U2K1Z2ZlB3ekd3KzVZRS9VeGZQeUdIditSOGNrQW9x?=
 =?utf-8?Q?n98b6A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxMQnJudy80cDFNQVg2WVVPK1NqK1Y5T0RRSXlIaFJEdEo2WDB4VDZneVRs?=
 =?utf-8?B?Q25Td0xtc0dxNTVzK3c1MnlIVjA1NkxFTkdQSjduWmhLQXRLMzhmekJZRkRR?=
 =?utf-8?B?aHJzVmlmeFVhdHBtR1NPdVZxTTlrZHIvdXhqenRPbXRqQlVsMmloUzFmODEw?=
 =?utf-8?B?aFFlbWNKVHlxa3JuTVFmUXdzbW45STQ4Ync2akRKdzdWWlhVcGpkR09HRUdO?=
 =?utf-8?B?WmRnUzJjbEFmb2dRNDhFcE9qU0pjdzZTWlRWbXplUno3ZTR0d3VJNHFmZk5v?=
 =?utf-8?B?UnFiVklXU25uUEdpUlE4aU5kV2plcUtpMDdraXBadUhyc0ZodzErMjIvWHlY?=
 =?utf-8?B?VFlDN3NxSW55dnVlQUp4RUM1cmlJZk5XVFd5eUFRY2ZFY0FDN3A4RW84NzNj?=
 =?utf-8?B?RGJ1Mm9FYklNZWdMQk5IMC8rTGhTaUs4cHg2V0ZDQitiVGxZSnA2V01GNDNy?=
 =?utf-8?B?U1RSR1pVb0FoK25iMzVIWG02aUZUNVU4c3diWGFLZHA2SWFGUkJLblMrdXEw?=
 =?utf-8?B?ZkVzb2h5eHhySkFaYkc5cGtreHVIM3hKNytqL1cxQmh6VUFqTng1MG0vMTlq?=
 =?utf-8?B?MldMVlVIT0twV1hUOTMwQ1dMbFdwYzZYWmJKczNGelBJV2VrU3gvckxIa1FG?=
 =?utf-8?B?TFpjMHFQVm5wMUgrUUV5SjA5bThHSDZjK2tmTGlmM1p6ak56NnZHNUJVUXFU?=
 =?utf-8?B?b3p0VHVQckJBVmU2ZHJnM1Y2cW9DOUhyNkJJL0xnUi84TGl0QlN6NnZWbTlS?=
 =?utf-8?B?cWY5eXhhazVNb0RRZEEzZmNGMjF0VVdaV2VpcGtUaER5SnhKUWpSbWsrbmJC?=
 =?utf-8?B?TWNDRkc1T3dYQ20ydVVhbmtSSXVsQy9xQ2lhM3BLTVZXa2tjdmlMT3JUcHg0?=
 =?utf-8?B?SSt6aEVSeVVqUCtxYzV5ZjdERGQzdWdkZFYvOXUwbUpoakVJTHAxVW9QMVpx?=
 =?utf-8?B?Mk9mazN2aHlBMVpoU0l2V1VFMld0SlNkNUlualdWYmhCSUVabDlUUlFrdlZi?=
 =?utf-8?B?TTJWdGQybk1vVTVhb3BaS3k4YWJvWlE1MUxsYlpFdEZlb0t4VEZWUURERERw?=
 =?utf-8?B?UUJibG1PMUQ5YmZPd0x3TGNYNlJuSEN3YlZuOWJQNHViY3RuRWlpaS8zWS9u?=
 =?utf-8?B?MzZsb25VeGZlQlZZOWJZY0h1MmpWRDRPdWg4Q1JmRWRZRFUvS3RwK2RZcXIv?=
 =?utf-8?B?Z0hCT092RGVaMXFOT0RKZ3NDamlueTA4N0I4dUIvdlBrTW9ScEtZdUV2Z3Nv?=
 =?utf-8?B?R0Q5Wlp1SlA3UUlQZWRSbnBlbUxaQThDR0ZteFVjNDdVeThxUDcwaU1YTE9O?=
 =?utf-8?B?N2lyQmo1dEhXWisrQ3VUOUt4SWIzeW9XbkFTOWZzMXBsRWNmUEZhUnpERTV6?=
 =?utf-8?B?bkJ5bXczcGdCa0hoMzBXTVhFRXNYR1lVZlhFM24rOENldkdyREtYUFl5STIv?=
 =?utf-8?B?eGhCcjI5dGFUSDRzSEJncXBYNGRIaGRhQ2lmVEdCcmJUUUZ2NWtjTUYxaU1T?=
 =?utf-8?B?MUVVTzFOTHY4N3U0aVJjYmFiZDhFMHFOV3JLVmlDaVNNL1MvWDZqZFJCd0s1?=
 =?utf-8?B?MkRrQjJ6d0RSdjh1czgwbjFJZkQ2Z2NkTnlZbWQzQk9CM2U3Rmx3QkRacVhR?=
 =?utf-8?B?b3U0UGpzUGxRY1h0Q1lacE9OVExjcEQrTG14WU94WWtZdE1VdlBTYXlxa2lB?=
 =?utf-8?B?OFJTSFlsVjJFQ0swdGdTZ3NDNnA5L2c0MHAybWNMRGNpUVFlbzljMkwvS2lj?=
 =?utf-8?B?bGJORkR2TUZkY2pYK08wZzhpTkZ6Y2d3TFJvVlY5ZDdMQzVJWGFIYXBEK1Mw?=
 =?utf-8?B?NzJGajhpZ0pQaXhkQmRUMm9DMk1tVEpVaW0zTGVVekJVNndzV1BYbHhESUxO?=
 =?utf-8?B?c2RlbllpMTYxK2dwdFp1ZzhTd2ZzcHBRSkp1TkJSY1BjeFh5TTlzbWs1VXBv?=
 =?utf-8?B?ajZZUEhSZ3JiS1JkTTVOY2tYbUM3Y2pkY1BjZkJ3V1NxbHVtY1hNSEJ1eEZQ?=
 =?utf-8?B?YTdTbE1BaTVzU0xnZnJqYU1MYVl4OGsvaFVtcUQzRXhySHIrLyt2RGZ5cHhw?=
 =?utf-8?B?WjB1SGduUDRCRTFhSk1WUUtFRnhWallPQk9BMktVTlpDN1FXVWN5R1hlVmxI?=
 =?utf-8?Q?dgKnRkfe5gvbL9gErRP6JnfL8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0310facf-4535-4298-2496-08de15cc5bb7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:47:39.0895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsh7e0W+wvoaAuP3O/8cIbe/KJk/Yk05S97u3FSoQmKRbrP39XhIJXM4fHM5qqhx3vgqTb+jw/ZaS3Z2RuTApg==
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

From: Alice Guo <alice.guo@nxp.com>

Add USB1_BASE_ADDR and USB2_BASE_ADDR for i.MX9 platform, and define
USB_BASE_ADDR as an alias to USB2_BASE_ADDR.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index e641ed299c0..2d084e5227a 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -39,6 +39,11 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#define USB1_BASE_ADDR         0x4c100000
+#define USB2_BASE_ADDR         0x4c200000
+
+#define USB_BASE_ADDR          USB2_BASE_ADDR
+
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
 #define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000

-- 
2.43.0

