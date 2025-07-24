Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B624DC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 07:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437BA83653;
	Thu, 24 Jul 2025 09:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dh8JlyJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88C583666; Thu, 24 Jul 2025 09:38:44 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CACD83616
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu7sjEXYMZ0a7C4BgnlAkwm9ALOMoFxY3cj+QnmTh0pMZZoYVGNxY3pBNeepZ6+3Ey4Y2ca/Y1Uogn6bAHRPGlwX8Dr0HC2X4N6SJxglMczmvidVSGylKSTJp4Euzc65ZTPhDXeWM7xd4L1qd0xNfOBbIJ/oQ2Ky48swlnstDaaSqp1bAPihjV46DvyMnrSbXot9E9xnNb88rxNXDdv6sP9Nh2DYnYjusaCsKi3WGJzzU4PxIYwKekGd10/q9OpWfIXFuO1V48zxCXV0BiqYNZWx1SDBp0PQQ1P+Gl7vp4C21L/itSpPC8udtNe1hzXR8o5lxsbWrGf8rUWh5RAARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF4wP1fX2ZelMQcht3UF7JobFyiGxqIFnfBwWcgARDU=;
 b=amoZTs4mi7iHmCURBRpOaTUlK2D6575fP1WzFWTFwf56ntVzIp++TOyIA5zsqBNMdTDUAqB1YR0Up2BVwpXPtkCUlVra+5G3IfnhQxKgBKj9zI6HmEXQqRjjgd495OqyWFVGDbnI5v6SkRn7Cow5Oufw8+WULA1k9dP3OoODgiBMeMB6NgxSEsA/HydpIrAwWbGl3E0poAhtFJHY8RL0JZ3qXcHrGbLnp8wYsXpfqNwou+NfNcE2h74ViwLBZ+2IvIvYOEbRclWB17zuVFWlCxqAerR5isHJe8EgxtWwRzy2OBAMSrJqIhVXeU1BKh3CuGSZV3vkU31/0BY61NGsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF4wP1fX2ZelMQcht3UF7JobFyiGxqIFnfBwWcgARDU=;
 b=Dh8JlyJ/WSwSQsh//URlGYno5gL+Iyjl647IqDTlI3nBGvkatanJVLT5P3IJkC++4oIiKUPaiCDcZNBL8pp38olYXuHygUiHuNe6/XI0upstYSlSTIFaNNkiBg1+tXc4m8K02YpTKYms8f6Y0ijOxPchVIYyQQQjWFA2qYzkPtHIZvzf/bhFu0KQ7HuRgyGPoEseSN4rmFTjF4EYjwTY5eMvnFBhuf9FCtRj6mW1V+jc8qTi4U9VqVYkfTH1TnVrHdKcgFvku/uz68xckyZfRQSh8/Cwyqi8aQDzQt54ZglVCC2FtbaDGf8klWlrTfhFwjpJCYE5gCswzS5enX+4Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8109.eurprd04.prod.outlook.com (2603:10a6:102:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 07:38:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:38:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Henrik Grimler <henrik@grimler.se>
Cc: Peng Fan <peng.fan@nxp.com>, ~postmarketos/upstreaming@lists.sr.ht,
 replicant@osuosl.org
Subject: Re: [PATCH 0/3] mmc: add more exynos compatibles and fix cd-gpio
 handling in s5p_sdhci
Date: Thu, 24 Jul 2025 16:49:06 +0800
Message-Id: <175334692063.31128.5357922505751980022.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: eb09529e-ce42-47e8-b039-08ddca851bc2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWlzTnh5RW9EOHJFdmJlYWZlYzR6dkRwT2ZJVjF0S0ZrRE9WVWJnU2hqbnZO?=
 =?utf-8?B?U3AwZjZnSk5ia2hjN21JYzdYNXA2OGswOElNUVVDdXVQVk95V2xHQlZqcSt0?=
 =?utf-8?B?RGdBTHdZWG1JUE4rK3oyd3h5NkVjWE5qMi81SEdWdk1URld6Tjdta0NIbnBj?=
 =?utf-8?B?MzVVMElieU5MejB5RTdZYWo0UTNyZS8zNWg4NCtZOHJuZnowcGNqOGNPeHZ5?=
 =?utf-8?B?YXZvbmtxRStpNGRCTDVPa2VFZTFLY2tIUFdnS1RUeUNXNTBxbVQ4cXFiOC9w?=
 =?utf-8?B?ZWwwa1ZJc3gzZWFvUFpxeGNsTm9RaHNxZnVNd1l3cmpGZFJIRGdLZzkwZ2Jy?=
 =?utf-8?B?ZVZhOW9Zb3dKTFhZS05VYlpqaUNVTnVOc1NxSklRZVVGdU40V2crOUpxWGlM?=
 =?utf-8?B?ajZyY2thbEdzc0dsNGF2TDc2RFBzZ0lrQ2w2T2JlR0pBTk1KNFhvN2pjRjB4?=
 =?utf-8?B?RmpyZGhpVXlubmZnMS8xUmpJQ200MXhlZlVDQWx4bVk3ZzdTUUYra1ROUUlt?=
 =?utf-8?B?YkRCNzVzQXR5QnNRcFp4ZmVtZWV6eUUva09Jc3A4a2pmU2FKZkpmMzlYWFM1?=
 =?utf-8?B?c3lJclR2V09HS1pQM0xTcWY5VjBHd2F3N0VJVzNkVGxWR29sakt0Q050RTVm?=
 =?utf-8?B?bmQwZkRNSFN6dFpBY0w1bXBlMW11OFZXRzBLTVU4YmVlQ1hZMlVyd1V4djR5?=
 =?utf-8?B?dGhlejFqRXRWSWNvQ2JOdFAxSUJSQ3luNTlNdStpY01qSUJPUkhZYVlka0Zw?=
 =?utf-8?B?WS9kRG9vYzNsTS96WFRDRmJscFlaYVpCRHMvdUg1ak5WM0RMRFZ3aVN2ZDFY?=
 =?utf-8?B?eWE1NURIdkFHb1dUY2F2cHlXTlRCVGlidVlLRytSYzBnSmVNOW9oN2NkWlFy?=
 =?utf-8?B?dUpRZlFnQkRQQXZ3VDJaZng0TjJZWExOdXRXREtHbTBMenFkWDcyd0liM001?=
 =?utf-8?B?bGE1VmNlZUJ0aVM2RHFiaTc4WnRsNW5UU2NwMzVFWXJodnVSYlZ4cyt2VUlj?=
 =?utf-8?B?VWp0OHVrV24weGlDakFkZFVESUQrOTJWSWYyRlpHaUU4WlZ3Um50cVRhQkd5?=
 =?utf-8?B?QVY5RG9tL2VEWDQrbWRQYzBwYW9VSHpmQWdPa2h3M25wR21zbDhhNlJMdUQx?=
 =?utf-8?B?NHEvNGpNYmJ0MldkZnJTSXA4Nk9ucUtrcTBQK2YzcDZNa2FiemdrRDY2V2I5?=
 =?utf-8?B?c0c2THo4Mms1KzV0clFVR0NIV2J6TkFoTjdnNzdBOElxcWhyTERtTjBteVYr?=
 =?utf-8?B?dmY5bWlQUXlpczZsWFpHZVk5ZGJnRUxWK1RLWlFpMXZZa1ZXOXZsZHg3cXhH?=
 =?utf-8?B?TFI2N1lxcSsyWi9TZ0ZwNEZjdENnTmtxdmMzM05NenQvZXlicmptQUF4R2JT?=
 =?utf-8?B?UVJDMDlWSUFuRDhaZG1PYjB0QzFLYmpWMEQzTkJqU3VaVHNpbFI5RFN2NWx0?=
 =?utf-8?B?aWU3MGR2TU5Gb2ZyWkgyM2M3RFQ4cW92dHNPbnlVL1N3Zm9zTG9SS0J6ckxC?=
 =?utf-8?B?MGFVKytneTJXbXpDM0lOYS9hL2ZCcGRTSGZqaVp3UEJ2b1lxc2pGVUY5ajJq?=
 =?utf-8?B?RTZkK2ZSWEU1RXRKeVpla09kN08xUWdsSlU2ejd0VktFUUhBbEl6UjNCTldy?=
 =?utf-8?B?b0lGa01HaHIrTjRVQTZLdUsyaXpwVlU1TDEwTDMycnh2Yml6ZHpybVNtSUZm?=
 =?utf-8?B?NXNwWWh0UTdJRFZIaGhGaFhUdU95WVVySDU3dHdCaytmLy9sYktUSjRFeUlh?=
 =?utf-8?B?ZEtZMGFLSVBOVnhGVG1KWGd2a2NNU2U5aG1CTXJudy9oQVhxa2MvL3hLZCtZ?=
 =?utf-8?B?ZDVMcjNXcCt0YVpTcm5NaXFMNUd3d1U1L05uVXVsbCsrVzNOdW8xR2RMN09C?=
 =?utf-8?B?RlB1dzVWbS9nOHZ0K2IxUVVMOXpjbWl5bTMyZUZQRnpGeHNqNDBSeU5UUGhD?=
 =?utf-8?B?cnpkOEhudUREbHlwUUV2VVd2WjRQWUpqMWZHNnJDY0J1eVdheFpELy9wZERC?=
 =?utf-8?Q?nyWA9iEYwLV2dYlPR0W8JcCowIEAhM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHhBakdmUktiUUZEUFNTUU5WdGpPeXpTV1FNWE0zMDN4QVg2NVl5aFBrV0xS?=
 =?utf-8?B?bStaMFk4YzZBb2swWjUwcUpTNG1hWnJtd2crUUlVUzgzT2JSa1E5QngyMUR5?=
 =?utf-8?B?UlUwaFM0ams0UUVDQ3A5cmNZNkdOQkwrR1NDaWY0M2Y5YXRwQ1YrRjRVeGM5?=
 =?utf-8?B?OUY1c1dtTGFidTlsNi9CSjZOV0JtUUh2cUY0THRhTXJGa3MxbHZiZ01vMmQw?=
 =?utf-8?B?cG5YVm05aDBtanNzSThUSVFFNFdhT3k1Ui95QkdiOWZIYWtQZkg4MHlaRith?=
 =?utf-8?B?Q0s0L1RrMGc2ejBQamRDbkJxWCtHZk5WT1BOZjVXckdUTkd3bElvVkMzNTBE?=
 =?utf-8?B?QjRtZkJqQU1qNWpXanNjbG0vTHRqdy9kNXQwdkZwcnM0L0Fyb1NxdnowdlFM?=
 =?utf-8?B?Zk5yOVgrMWgxa25JZ0RHVkthMlA0MzZoTFFtT3hwWW1UaFBZR2FFT0F1M24z?=
 =?utf-8?B?Qzd2bXhkYlVvQWltbFB4bnJ0V25VMDliVUZjS29ud0dBcnhwbDg4VFFUbE5N?=
 =?utf-8?B?OXBIL0dEWDlRbEJEcUlRUHlaMW02M2pnaWhLb3JqVzI4aHZobVJtSEM3UkYw?=
 =?utf-8?B?SExKSUJOQ1I0WmdnbnZ4SmpDR3NPaFg4V3BmUm5CdlpWZlFNWjVaa1hhK1Q4?=
 =?utf-8?B?OTRPN1VLcG5iT1VQczRJdnEvb1FUKzJ5VHJUYnAzaEgwcG9LZ29Ocmh2VEkz?=
 =?utf-8?B?VStlQWpPSTkvcjAwaW56UXJsOXBFNEFlRmdodE1HbWZicy9JSmtVU3dHM0tr?=
 =?utf-8?B?ZElJdVdva21ScVEvMzhSeG8yTytJZXlkT0dmZHFibEd1OUQxZGY2QzVWZjlS?=
 =?utf-8?B?ZDNMdXIwcUxsWlZ4WUNhZExrVHlaRkg4S1h3Y1pLRWVSQVBDN05zMk4rY3FF?=
 =?utf-8?B?dFBTQXI5RGZFSUVyenBWMVg3RTN0NkthSUtpMXlPeVpYV2hsVllPUnpsWlRF?=
 =?utf-8?B?eVZ2MkdDbWE1aUR0UWRCNmFpYVc1dHBtWTB4bWpmTzJsYVpiUTV4SHdQVGpU?=
 =?utf-8?B?N2dGREdGNXBBYytXeUhnWHZUQUZJTlQ3Vk9lTGNCcm0zbGJpV0ZkK3NNQlR3?=
 =?utf-8?B?UzJFZ1M3WGtIa29MNzZZZ1ZiVGdLYW9VcklqSml5Q0V0cGlMeXlBcmw5MW8y?=
 =?utf-8?B?L3hSSHFpZVRsS1VkMm5IdFdDcUVFd2NQczYyRGtKcG9JL09XclE5Tnc1MUlo?=
 =?utf-8?B?YVFsY1VxYUlwYUhNcnFiWllHUEZDb2J5UFNjQ1RTelVaOHhYWWxvUURsTVNZ?=
 =?utf-8?B?NXZyMG1vbjYwVDVYdkFEUGtMZEhlWG1YYXZheVJyOFBrSUdLdjNYUzdpOG1v?=
 =?utf-8?B?ZUpoT2N3cDc4Qm9HeUhHblMrTHZwclBySi9BS2REa2ErS0hRVzZjYTVoT2xL?=
 =?utf-8?B?UENzdzM3R2oxdVJ1MVVJRjc5VkRDaG0ydXRBQlFhNE0vZE5tYnljMWRTcFQv?=
 =?utf-8?B?M2RxNEsxQ1Y0Z24xQ1gySHJvS0hiSDN3MkpmbGJXNStSSGhLQUtEa1gyY2FI?=
 =?utf-8?B?bVBoZ1FlS2pMeVFZeGRDQUV0aXBTWmxQTnQ4SXZ3R01KQ1dETEMyYStpK1JU?=
 =?utf-8?B?dDNlVWx3ZzNTWG1NRDNVckJHY0hUTXpOZzFEVFVYRGNCOFRlMFRxWkRFVWRX?=
 =?utf-8?B?N3N5U2tFUXpOdEd6UHo2WkJ2UGwyZ2hwYWcveGRpTTMzZTJKdWdsTFk1UHAz?=
 =?utf-8?B?ejJqWDNuZnlvK1FLWUowU1dPMDBkaUh6M0lCcEJpd28ybksvMXU5UmdXckV1?=
 =?utf-8?B?SDJiM1BRUFZHY0syM0FmNkl3TStDYXR6cWZLbWlpRVN3UHMvdy9YdFRWRnkr?=
 =?utf-8?B?Vk40REZLVHJCT3E4U1YxcE5SK2REVlR2VU41U1NUZnpqVk1Rb0dLN1RJTzBV?=
 =?utf-8?B?TS9jS29PS0xPOFo5UEpjUEM4dThkSmkyM3RHYTc4eUhSeTdSWnlFV28wckJT?=
 =?utf-8?B?L014bTBOUTIwak45OEtYVUNTMU5WaFlLZmJqN0lld1VnbmJSWTloL3pmSGNQ?=
 =?utf-8?B?K08vSjdrMFlTeFpuaXRQZlYyMzI2Qnp5VXJWRU0zckxmMTZYSmpCL21udVVQ?=
 =?utf-8?B?UTZaODFNcXpoZ3lVTVlDY21UZmRQdDF1YWRYWGpITkROSDVxam81SVRHL2hX?=
 =?utf-8?Q?NpJga38p3fewqov54CzuOdjTU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb09529e-ce42-47e8-b039-08ddca851bc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:38:40.5492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChPjM5mgXF5N9+rOWoFhfE05AIPVy6VvcD/zja74m90/ZtOo4KstMSKn7ou++p6ULFUCsfzwRuOY7GEA7MTrPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8109
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


On Sun, 20 Jul 2025 19:00:25 +0200, Henrik Grimler wrote:
> This series does some preparatory work to s5p_sdhci and exynos_dw_mmc
> drivers to make it possible to move some exynos devices over to
> OF_UPSTREAM. I am planning to send additional patches for other
> subsystems as well, with the end goal of moving over
> exynos4412-odroid-u2 and exynos5422-odroid-xu4 to use OF_UPSTREAM.
> 
> Patch 1, "mmc: s5p_sdhci: remove duplicated card detect code", was
> originally authored by Simon Shields:
> https://github.com/fourkbomb/u-boot/commit/2eac9dea7903, but I have
> not been able to get in contact with them and have therefore changed
> to set me as author instead.
> 
> [...]

Applied, thanks!

[1/3] mmc: s5p_sdhci: remove duplicated card detect code
      commit: 4381d7bb3327938373dafe6b96cb98fbc5c26a49
[2/3] mmc: s5p_sdhci: add samsung,exynos4210-sdhci compatible
      commit: 95f8a22e2a8aec2844ed48721e2ec676221fc3d3
[3/3] mmc: exynos_dw_mmc: add exynos5420 compatibles
      commit: bda1e3f0e7d85ece6bddaed3024e3ef6593482cf

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
