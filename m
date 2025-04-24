Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A94C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F7882169;
	Thu, 24 Apr 2025 08:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d6zMVYPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89AF482153; Thu, 24 Apr 2025 08:35:10 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68D0A81E14
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o782uzIbrgzmrBQ/yyW56wB0ayr+h/XbKwWurC5kXAsFk9RNCgnftmbl1eW2zyvbEjRjnhaJ4PgKZxwZUxCdGKTcPJJY2zbg0BQUZZBy2xbD/ydIJE+Rf0jaSLOe+Vk1RV+HHfw0Yc51AmWB4yO1lfzsquWTiU89qM+RqTbsdg72UQsSRgcdkH6KigjiMygJHjaGa/ekg0H+e0hegh15II+XuILukvs9ihfWUx/cMGkvK9S6fcfA/BiyRYIaBeuBCoRgmFNNbEPi2XfkymdYf0F6BfsoI55RdqdnAKwFZPHailw/B92Vokjx4rUIniY6VtSM9PxnRfCtwDWsrYRtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HslbAn+srlVzbEZSM//zoDicGH9XSnmA4V586C6hE6o=;
 b=JRkQ6jt/4qXr98tXSHO43yEDX0zwop36eZ+ditD7Lhw2Hqe8GJEL1scwB+BHjrZG0Yx23umICHdLH4ieteYC//PMd/WeteJjz2cq7JRh9NIVVIJf95eV5t+mJ63aiXUJl3FfoyejcziNnscvjTTgYmgv+P80++S3LakD9U1THyiYUXWQK2Lypm4BCSZDtYhubMSKfLYknHsU21scDsH9nkRTan/PA94lSNAp2ZslkgplorHXJxNszTB2N+D5v5GlmbAN5Fe8xlM95NfMgpMBRvxdQ/jxOD8DGLiINoWeugY+4kV3WibyOk4nnX9MYs3z5lyJ9aKZ8+LZNh6Rx0WHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HslbAn+srlVzbEZSM//zoDicGH9XSnmA4V586C6hE6o=;
 b=d6zMVYPJ089zmrCAOKB/GxlzY3ZPB+CqYbOmyVxX4eQXe/T2AyPl866W1QBZ4i9AxpwaiHhrmnuk9e6HZFKUAUEpcoCK7b2PLqoJeKtuKYhSXIzmaOuoA+DoaPCnrai+5IbQkG2wZde/es6MnEcuYCQjlP0phxfpKrQAz2Q6iTWsvya2NUt7b1b1K7dMIKa3SD7RaAdQ0ICh0oc13hiagCgCghe0haVdU3YoulLtDY9LR/SLh2UV7FYT9QVpLVODOKk1o+Z5H7iuqldKnnOtGZmNlqHbhFK3Cl47aSikQ+eJ/cAd0FEljolJKOyr8uMCFCpBo658IqdfTJh3xAueoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10661.eurprd04.prod.outlook.com (2603:10a6:800:265::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:35:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:35:06 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:15 +0800
Subject: [PATCH v10 19/21] doc: imx: add document for i.MX95 Image
 Container Format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250424-imx95-v1-19-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fe77e7-45f3-44a0-fefa-08dd82fa26d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkJzd0tJbm1ENnBZY3FoSytERkxDVlZJK3dzSzZxb2RaR3hjQzVRUlBGdElv?=
 =?utf-8?B?NTRoeG5VVm9iMVZjN2lKdXdUQjJBR1h4OUs5VlpwOTdxbUF3M0JHTU9lL1Zo?=
 =?utf-8?B?Q1hpYmxCQzZHVlduL0JMaHNxcEhrS0JPMnh6YXd2T3pJMnZDWnZ4YjBUemFu?=
 =?utf-8?B?eTllRWNtbVE2Rzdob0V5T1NucVFLZDAxZnBieE5UOFJmQXJySjRVZW45b2xn?=
 =?utf-8?B?R0FCTkxVSFoyNEtZMDlzR2YyTWZDWUVRVmpVckpLQWZlUUp1UU1ZaDRzcGgx?=
 =?utf-8?B?T1pxUW9iRytyUk5mSDFyd0NlWkxHNEZjSjZCZm5mcW9yZkhRM3RKOHA1VUU2?=
 =?utf-8?B?S3N3YVBDMUdYN0M0MWd0M1B0V1YzTTFlL0pJTjB1NDlQbWNmNHNkbENGNTR4?=
 =?utf-8?B?S2xmTFpwMnY2cHFDOXBJdlU3SlFabHhTUVBTcjV4QVJjT0NValZYRTMvZEo2?=
 =?utf-8?B?ZGU1enZHMUJ0VitzdHFjMUZqbnMrbG1rOUZkQk5UUCtQVmgxN041SGJLY1l2?=
 =?utf-8?B?Wk05cEFTb0ozUVNJR3M2amxMdDFWUXdFOHVsQXQ1cGVuUWVqSlNVdTRUQ05Y?=
 =?utf-8?B?MkFqNWYvb3d5cVV6RnVpaWVZc2ZKUThIUlpKczRsUm9WVHZYQ3c2WGRVU1lH?=
 =?utf-8?B?V0JSZXg0ditJT3g4TmF0T1ZLUkVJaFlIRklaWHdZcTVqUHVYSnU4OUYxa0VR?=
 =?utf-8?B?b3pmM2VFMkVGREx6aDU4MVpBL2E1NUZIV01zWFNwRTAySmFreUhOdEsralpP?=
 =?utf-8?B?UEE2empDVTU1aytmUXEzVGtHdFlwViszTjhwMnJpNVp5YklPV0pwRGZIdm5q?=
 =?utf-8?B?VzMrQnY4TXY4QTlNYUxLT0hDSDFKbTE3cDZkeVVhZGNMZDl3aFBkNHRZQ1Vw?=
 =?utf-8?B?UWsxZnVjOXN5Um5oNElsSzNsbW9JRmdqZldQVEdOUE56TWhTSGsrc0IzNTB5?=
 =?utf-8?B?U3YrSkNQREgyeDdjdmxnVCs4aUFGZ1dmUjZ1K1ZqRXF0L2h0ZHk1QlhMWVZD?=
 =?utf-8?B?Z0lwekVRMlJUQURjazRkRjBSZWF1S0pGKzRhTllSYm9vbUFYMjc2VnFTVTV1?=
 =?utf-8?B?dW1sRnExSWtGb2NPTnYxY1BaUHB3UEpCOUpYcHVlMENhT01waUl1V1RKZXp1?=
 =?utf-8?B?OHJ4WnNQTnhXR284MmFkYW5PWUZLa3ZiNlBHZEtsS0dXU3VnWmlrRWFHSzVh?=
 =?utf-8?B?OUhuVUxrbStORC9oRytkVGE0ZjVSZFVXUVNSM21QakU2M21lL3Qwa0ZqUVRI?=
 =?utf-8?B?MVJNVXhCcE5ZR3l1blR2dElyVXNyVkpIQTRFM3UxZ3BnTWR3b1orbHZVVDFi?=
 =?utf-8?B?Q2VWdmMyL3JoQng2ZDZPY3JwS0FxQXZTRnRvWmhwdWxuanlIbEZVdFdsSW44?=
 =?utf-8?B?aTVOZUtrRUxVWVpBV2FKQzVkanBuTU5OOVVlbno2V0hUcy9tNmZQa0NpREky?=
 =?utf-8?B?dHYvZWM2RDRyRGZ6Z0RNMFlDN3pSL2pnVk4rWldpc0hPVG5MVHpBR1FybU8z?=
 =?utf-8?B?MlQ5R0pNaFd0N3F6eU4vbWdsUFhuM2lvdHludUUwekJlOWwwbWx6Tzg1eTdu?=
 =?utf-8?B?TWFwbWlnZ2tMaVBwVy9xb0RvSVJsTCtoZFdEd1FxVlJaekhaeUVacVZhemNt?=
 =?utf-8?B?ekJ6NndFdHpTZDBHcGwvTmdvbkpGZVZVbEQzQ0JpbE5JcEN0ZXZGREVlVmNo?=
 =?utf-8?B?cm5WVkZQTlEzb1V3VTQvUSs5cnIxN3l3Nkk4aW9tMzlHUGxBNm9BR3U3a3pa?=
 =?utf-8?B?eUxxVjI5QzhIYUJ4bVdJTDNld1dlMzZoUmRqa0R4OVcyWWZPejVvWXVNczI3?=
 =?utf-8?B?NHE4OEpzeEtNMzh4cEpPTHhtc1dyek1mSldBSGpZbmtTQ0pvcVN1TVRKMVMr?=
 =?utf-8?B?NlZjZG5jZU8yTVYwa05yL3pwNWNnWU0vZ1Vob0cyZkhBeVVzUzFSeUNobDNq?=
 =?utf-8?B?RDVWWFUwMENTMGRVMlVCOUhsMERWUUs0d0QxZTU5MWJWUExEOFozMU9RVU1x?=
 =?utf-8?B?dG1HVjArUXV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hUaEN4citBYklLN2d0NWhsVUgvZEpxdGtRNGV6Rzl1NGE0VmZORXVVZStT?=
 =?utf-8?B?c3VTbFZEVDM5Y0hDQTFhemlaT25FTi9xNVM4RW1zQzFrVDFVOUNFdWhhMmJa?=
 =?utf-8?B?K1NieXBydnc5YWpWR1hCc0JxVDJVcGlYNnBOdkpscTQ2alBtWU5lNndLV2xm?=
 =?utf-8?B?SFRscnUzVDdVY2RlcnhOLzNaS0djeGpwL3IxZ0xGRkxnWHNERHlGWkVOSTFk?=
 =?utf-8?B?V2JvWTNGSW9BakFTbzN1L05LS0N3ZXdGd0tkenJ5ZVF6dldGSXVoTTg0RTdv?=
 =?utf-8?B?cWtWaUdJeTBuU2VWSWFhTkhhcXloS1lLM1k2bUsrM0lzZ0l5UkFPcE9Ud1VE?=
 =?utf-8?B?cXdhYjhNVUg3RU5FWXdvbTZ6aU9wald5MWZTeVprOU9IMm5kcVprQ21ZWHV4?=
 =?utf-8?B?VkJMLzF2QkVGL2d1Q3VwVlB1QndGTjQwUnpNZisxQWhGaXZMUCtXNnZRL2Zv?=
 =?utf-8?B?TUpxYmNwVnBrTFNxNk13TnloYjR0My9Ydi9GTEkvU2wzeVlEclh5T2JTMC9t?=
 =?utf-8?B?VnkvaE0xT0paZ0NSLzExZjd5N0FZODJEWlE3Y3NpbkZqTGVsaVRVdFJwUVZQ?=
 =?utf-8?B?ZTJic25sVlc1d000ZUVuL2IranpwQkxvb1FYZW9nbGhaazhsTFljUmZDeTgy?=
 =?utf-8?B?S1J6UE9GU1R0NkgzSW5teXJxbGtDbmxCTHczV0ZtSnd1YVhYcUtDNDdMQ3d1?=
 =?utf-8?B?Q21FY2w5RkRzUkJ0Q2xva0ViVHlXZVdIdUlNMHFNdElneGxaWjNtams2TjJv?=
 =?utf-8?B?K3c3QmpESXRoSHZIYjhjU2NLeURxOHBsaVRqdnNYd3ZsWUVXQWNhb3JmaC83?=
 =?utf-8?B?b2NXY2R3SitwRnU0KzA2U0ZvWnQ2WGJmSWJvUzRlZzBZWXJTWU9BSDQ1TC9V?=
 =?utf-8?B?UENmcHpuUjZiQ2hBb0ptOEtwdmN2V2kxSlc4MHRDakZBK1IrTXNEQU5kc0tQ?=
 =?utf-8?B?d3lRNTc3SVdHRDZUMjBNNmIxY2IxbmY5S0xwTmM0WFpxODdRV2VHN1AzbThx?=
 =?utf-8?B?MHI3ZG1vZXViZkpCakFOSHdVNit3Slk1TDlXOWlqK0IyRHV5M1pGT3VYWGI4?=
 =?utf-8?B?cFYxUHJ6RnQweWNhQ1dIYXlnYldCNVZCaytKaXFGZEthaDZuQ0FYcytvK0N2?=
 =?utf-8?B?bDluZGZyN0F5cnVxTTZFRVkzbE5GSmo1WkpvL3lmbDJxZGRpNlNBbVpmZTFt?=
 =?utf-8?B?RnRxSStZYytyZEpUVGwvWEhkQnlXM0tHYTBjRHIxZjBVNFdZb1VXRVFhOE1m?=
 =?utf-8?B?eUhKRjFFV0UvdFlWck1iZXdTQzcvTVRWQ09jQUVyanZFZ0FkcEVPYVFvT1lR?=
 =?utf-8?B?dnJXRThJZXVTck0xcUxnUlFrK1UwM1hoMEo0UTYxb05Wclk1ZjArcUZOOEtR?=
 =?utf-8?B?eUNlMnJxU0E5THBkQXF3dXFGa0tqbUZBR0JIaDNjWWl5YWljOGhmKzNLcVhJ?=
 =?utf-8?B?bHhmTGsrZzIxek52bUc3K2QyMjNrSGRTZnFxTysrWEE1enVNQW9LQnNuUmtj?=
 =?utf-8?B?UTVMR1kwdEY1VEJjb3FyQXdpb2tSMkt2OUVxZ2FvM1pYNjl2Q2l6QTEzYitC?=
 =?utf-8?B?d1I1YWk0YTVtYktGazhsQ1dNeW9ObWdVTmZvYmpHbFdneDRiOWwySDdaRXBH?=
 =?utf-8?B?N0ViZUkzNEJGNk9mVEhhVXZhM1VXUFMwbHUzckNTR3FLNEcxYmlGSGZ1QXAx?=
 =?utf-8?B?cjlrLzYvNE5JbklIUTBENHZXN1ZYR2JESTFIbm40VW03eGU0bXZHSkpZMUZr?=
 =?utf-8?B?ZFhkdTBWd2tsMWgrN3I2WURPR1BHU0pkWkllYkUzc3JTZi9PcjYzdENsZzVt?=
 =?utf-8?B?OXNZQ1d2WnJSMXJkM245SHpqbFBPWHZYMU1CM1NvYkwrV3RBWU81VDRvQ3R5?=
 =?utf-8?B?amNmck5sZU53aUp3MTRTL2xobHFjOVFFck1SOElkcXRkb29MUER5TXQxUncr?=
 =?utf-8?B?bTRiUUFCdysvc2VOV3YzMUJFaEFWZ2xTQ3dnTWwxbGhjd3hrajZoeXFDWFRK?=
 =?utf-8?B?cFJESU9xYS9NL3Bic1lDbjBSNTNwcUxVRmpoTnJiMVJQenNUYmtVWkJ5RzZx?=
 =?utf-8?B?c1dEdm1GaDF4czh3RlRQdEcxUkFnTDhzYU9TQlJKRXhSaFhVRVdqNkdwSm8r?=
 =?utf-8?Q?i6mw8TfIesaGPeN8BkVnDwhDS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fe77e7-45f3-44a0-fefa-08dd82fa26d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:35:06.5255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAA5D0KJLsS2tWKctCRb5lRYC8ZpjrhUPsKJKwaMNJZYEH+BF/aig6KiLvsDbxzkNepGpzIa6A3dcFcUCMpzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10661
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

This patch add a document for i.MX95 Image Container Format.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 doc/imx/imx95_container.txt | 136 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/doc/imx/imx95_container.txt b/doc/imx/imx95_container.txt
new file mode 100644
index 00000000000..05f223d962a
--- /dev/null
+++ b/doc/imx/imx95_container.txt
@@ -0,0 +1,136 @@
+i.MX95 Image Container Format
+-----------------------------
+
+The image container set consists of some image containers, and image container
+contains boot images. Each image container has its own container header which is
+defined in Figure 1. All container headers are placed together in a continuous
+8KB space at the beginning of the image container set - image container set header.
+
+ROM code addresses image containers in image container set one by one based on
+their headers’ order in image container set header.
+
+If ELE container exists, its container header must be the 1st one in the image
+container set header.
+
+If V2X container exists, its container header must be the 2nd one in the image
+container set header. V2X must be combined with ELE container.
+
+The information of boot images are recorded in image container header. System
+ROM code needs to retrieve the information from the image container header, like
+the offset on boot source, the target address in RAM, the length of boot image.
+The order of ROM code handling these boot images is based on the order of each
+boot image information present in image container header.
+
+Figure 1:
+------------------- +--------------+--------------+--------------+--------------+
+          ^         |Tag           |Length        |Length        |Version       |
+          |         +--------------+--------------+--------------+--------------+
+          |         |                           Flags                           |
+          |         +--------------+--------------+--------------+--------------+
+          |         |# of Images   |Fuse version  |SW version                   |
+Image     |         +--------------+--------------+--------------+--------------+
+Container |         |Reserved                     |Signature Block Offset       |
+Header    | ------- +--------------+--------------+--------------+--------------+
+          |       ^ |Image0: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          |       | +--------------+--------------+--------------+--------------+
+          | Image | |Image1: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          | Array | +--------------+--------------+--------------+--------------+
+          |       | |                            ...                            |
+          |       | +--------------+--------------+--------------+--------------+
+          v       v |ImageN: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+        ----------- +--------------+--------------+--------------+--------------+ <-- SignOffset
+                  ^ |Tag           |Length        |Length        |Version       |
+                  | +--------------+--------------+--------------+--------------+
+                  | |SRK table offset             |Certificate Offset           |
+                  | +--------------+--------------+--------------+--------------+
+                  | |Blob Offset                  |Signature Offset             |
+                  | +--------------+--------------+--------------+--------------+
+        Signature | |                         SRK Table                         |
+        Block     | +--------------+--------------+--------------+--------------+
+                  | |                         Signature                         |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                   Certificate (optional)                  |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                      Blob (optional)                      |
+        ----------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- Image0Offset
+                    |                           Image0                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- ImageNOffset
+                    |                           ImageN                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+i.MX95 Low Power Boot Image Sets Layout
+---------------------------------------
+
+    Image container sets are handled by M33 ROM.
+
+    --------------- +--------------+--------------+--------------+--------------+
+                  ^ |                    1st Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+    ELE +         | |                 Padding for 1KB alignment                 |
+    OEM           | +--------------+--------------+--------------+--------------+
+    Container     | |                    2nd Container Header                   |
+    Set           | +--------------+--------------+--------------+--------------+
+    Header        | |                 Padding for 1KB alignment                 |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                    3rd Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                 mx95a0-ahab-container.img                 |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+------------------- +--------------+--------------+--------------+--------------+
+                  ^ |                      oei-m33-ddr.bin                      |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                      ddrfw-header.bin                     |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                  lpddr5_imem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+m33-oei-ddrfw.bin | |                  lpddr5_dmem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                     ddrfw-qb-header.bin                   |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                 lpddr5_imem_qb_v202311.bin                |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 lpddr5_dmem_qb_v202311.bin                |
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      oei-m33-tcm.bin                      |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                       m33_image.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      u-boot-spl.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+    --------------- +--------------+--------------+--------------+--------------+
+    u-boot-atf    ^ |                    1st Container Header                   |
+    Container     | +--------------+--------------+--------------+--------------+
+    Header        v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                          bl31.bin                         |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                         u-boot.bin                        |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+

-- 
2.43.0

