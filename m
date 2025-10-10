Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830BCCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 17:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2D5838E7;
	Fri, 10 Oct 2025 19:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nfUUXYb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9045583906; Fri, 10 Oct 2025 19:40:06 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E314838E5
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 19:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0dzzpDMqts2eo2M8/XNmGvxfwqnVFe5HJDt9hCV+Nh9RfFvIMwtet5VLdr/x7AZvw8/es50p4fUyUNxl9Q1oB12JXQaH6QXjXl/iElUiFNWHF3SaGnYFBNMkLg0uoFhHv8yfT7NvyIvXopLTMnEBhWQctBbQXSlTJL2ykK30YpphALHCzuNOdxgSjOZRKjhuCj7CrjDzwqYL6uYr1zwD3J6rARS+wjiRJreKGwxO+4SE+zBW3VV+Iyznk/ns4DtyEu4IuIIweUoKPyF2pOWhA9XjQmUJbeGQ5TyHm302uy9SRxwb7IxW7IF+uIrqx3V2af0Z3G5bJpCYy/AqDW/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbuRnDj8zhImyiTPjt0Nxs8CWo9ogxL/+uGSH8rEA5Y=;
 b=eXYzaWTz6YTnQ3YqB78d5hkfU3ikbwbJBL7EWExOAQE24j3fjDaTVNEcaeJ90C5Hbrjw8IcAX07bTikhSKoSCfLt1J8YOPnpP49VHfhPxF+kbVgVkEYhTpIRIriOGbQVeQwS8pLw60RO2HOlmYrE4s3kWzfHufoOlKrUbOCKOlhSsAs4O/+4ry2o2UhtK9AuUTMDrks6bFnpfTd3OpFv8+x5MVQZ+oQ8WqyIMLJHBcobLsz3bEfBxVCxukeVzemb/gTnVJJbsxNAMXfVLeOFesc9bRLEKDvip/HQ5q4wU7T5PPpoqcJSlbg+kJ9cLDeIzZjfLjvgmJcIt6GVvv3Sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbuRnDj8zhImyiTPjt0Nxs8CWo9ogxL/+uGSH8rEA5Y=;
 b=nfUUXYb6iKANdeIVHE2O+q0+760DCsbi7t7wp2h435fh3nBeLwyB0eEaNT05HgDWVX1KNRZXR5p4RhJs1jHUF8nB7TziDAKvIv+C2ohnrNkVP7/N+sRfZovvqAvqm0whc+PglTUTWofrVtWsKslCq7teE3dmAWFwOnljQetn0kP8rRcz/LdN+qvJUXZIjEQxhPIhikLhZ8d96cuBVhi7N2lSAlm9U+dotnPUKo8c8Ew85sS+Ahos9AQo9HAseLM1upgQrhwHF1IWpspFb0D4luJwuODCit40yR1VeXsp9zRdw1HGP4lMPE86h8VT/JSWQ3X+W0rbcq131VTQ/yUqxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5823.eurprd08.prod.outlook.com (2603:10a6:800:1a5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 17:39:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 17:39:59 +0000
Message-ID: <47feb61e-88dd-4708-82ad-7f736f45087d@iopsys.eu>
Date: Fri, 10 Oct 2025 20:39:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: benchmark: use lldiv() instead of 64-bit
 division
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20251010165103.1572444-1-mikhail.kshevetskiy@iopsys.eu>
 <d5cc0678-5d8a-4ff4-973d-6b5a41f2fa4e@gmx.de>
 <CAOf5uwk_PmCfPiDTkXQWVJajT4KtgoXKvFgCTtapjc4_PycaPA@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAOf5uwk_PmCfPiDTkXQWVJajT4KtgoXKvFgCTtapjc4_PycaPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0000383A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:a) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 511f2677-d9ae-4538-d2b3-08de082408dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXBVUUt2dTZsS3liZXJaaFpVSGhoS0J1UUxXOVp4bzZpcmwvd2w1L0hkbnVJ?=
 =?utf-8?B?QlE4VUNoQTBIS2ZEYkhzdGhicWZqamV4aVRXUGtoV3Vsck1mRDBod3FTdXZp?=
 =?utf-8?B?UFAvMnNSRkRFZG1zTTFDTWNhNWQ1Rm1BTHRiNkZxd2Z1MkxEWDdWRkdWekt3?=
 =?utf-8?B?MHFkQnF1Nlhhd2dHSy9NZTdNUkI3SzZEZWw5U1h2THFsUWlNTzFEOFkyM0ts?=
 =?utf-8?B?djJGekVYeHBZRVplN2VjMzg3cDNYVTk4Z3E4RVJnd2NqSUw5WnNtQzlxSXU4?=
 =?utf-8?B?eFFwYU4zZElITEw2NnpVTjlta3FQT1JmZFl1aS9sOFhBaUJKZnM2SlhSRmdH?=
 =?utf-8?B?VzlGZzZZRmxhYW5NUjVjK1Vvb2NOVlZBLzY2VTRBalU4TUpXU3FBWUhlMFZ0?=
 =?utf-8?B?eDFqaUoybDJBVWV6anNPcTQ5bVl3TlVDRzA2MGJlajk4QVVzRWFtREZobUkv?=
 =?utf-8?B?amR4NklmQ0ZJdnVuYlNCYWN4SElZbDl4T3hKM1hjTlBScTNTclhjSk9QTFdh?=
 =?utf-8?B?dWJQZlowcEF2RlJ1akFXay84ckNpT2FvSGRySHZMcjFOQ3V3UkN2S2t1aVhQ?=
 =?utf-8?B?SXcvckg5ZjhwYVpvdFNSTW5DY1pDc0F3TUhmUHZsSkwrblVPTGtGaXhBZGsv?=
 =?utf-8?B?TVg1MVFGNVpEbWR3djhQeThRYXpnNk4wczNJTTdTdE1VWEpLTnN6UGJkcnB2?=
 =?utf-8?B?ZXR3Qzh4YkR6VzZ3djg2bmlrb083SkRoTkVqa2lFaDFLYnZwTjB6a3lvRktF?=
 =?utf-8?B?RElabHM1eStVR081N240TndCZnBOSmRKQVpnTFR2RHFseEFPYk9XbnVOaVcv?=
 =?utf-8?B?emRLQ0RSaGRncjdaTGxLNTRROXF2MWhYems2OGp2V3ZpTWJBenNpZ0UvMGti?=
 =?utf-8?B?d1lMVGh0alJyQVU5R3YyZUhlemFWcHVkZ0tNL20yV2phRXhPbGpvT2VBUDRZ?=
 =?utf-8?B?Q25vKzduVDg5WmxicmdoZkk1aGZ0R1Z2cGZGYXVzNytxYzRoM1I0eHBCU2Mx?=
 =?utf-8?B?TTN4dUJqNWZ6VHpTd2xIMkVmRWdoNDNYeWFXZFhLKzVmZHlKa3pOZlhFSkVW?=
 =?utf-8?B?VUVMcEVZVnpUdHZncUhoRG83NkN0emJPR08wTmlkamJMSC9wbDhGNmhpa29Z?=
 =?utf-8?B?SkQ2V1dwcUdKbHd1MC9HMnVZVVF4a2NMU01rVW02REhhbDJKSzA0NGtoWFJT?=
 =?utf-8?B?bVc4ME9hUEhlWUgwQUNQQmxzdGppU3RDNm8yQXM3ZysyY0hodVNYSVdKK0Rx?=
 =?utf-8?B?NmFOemZHanRRcngveU1PL1FyRHdEeDZDd3lFVXVPUk02Vmd3amNOdnZ1QklX?=
 =?utf-8?B?eExlVWdVdlExY01GV3dGcExmQSszaXN4UVQ5NWdtQXYzSHJRZVp5USt1UmFG?=
 =?utf-8?B?b1NKM1M0OWZhOGRkTzJ5NXRMa0x5Vk12NXFKUC8xYzVlOUtPNmZyeVN0SFh4?=
 =?utf-8?B?OFdwQTllNXMybEkyWjNNQUVjOHVBb0xNNkJEbGZSSmt2bE1TK3JSWFNsWEQx?=
 =?utf-8?B?SzZ4VmQyZ1d2SWN6TEhtbHNSVTF4dlB2STFIc1NLUjJ3Z1VQeWZKRUxhaEpL?=
 =?utf-8?B?UkU0Ump1OTU4eUJIOExIV3RCYitZOWZHeE5rQm41ZkEvbkQxMm1yYURQOEhH?=
 =?utf-8?B?SngrZTBSbFFhTEJDb2tXWGRIQkNuNVlqMjFoQnVNYzR2TjZmUGFqb1N2dGg2?=
 =?utf-8?B?VnFxQTNybGQwNkN4T3Q2YnM4Qm55bDFOS28xMHNPUnI5SHZKczh5ZVlxeW4z?=
 =?utf-8?B?KzliSXh2Ry8vMHpIdUFxV0w3ZDZGWXdYUWk5Z3IrK3NaaFZMOVN3UzJrQXkr?=
 =?utf-8?B?OXRzTUJUdkJIRWd3cEI1bk5GRkhyZEhxSjJhRjM3NlppNm5uZE1IV3kwcW1j?=
 =?utf-8?B?STBaR3VzVHJUa3pHckw5Y1VrQ2M3TkNVcUxEMUFVVHFhSWp4ZFE2TkdTb01t?=
 =?utf-8?B?U2l6NUEyNE9aeEIvbmhZWWhTd3hKa0ZmelBqUzlieVByQStBTUx1Z3hyNlVC?=
 =?utf-8?B?anphcGg5R3ZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulh6dVNPR0pNQkxOMU00WjFoazJVUE9WVURRV3hKRWphQ21tK2M3aHk0dWpX?=
 =?utf-8?B?dnhjZGZoWVA2N0xrWE9sS3VYUGRVVnJITEI2QXludWJ0VjBObDVxdytwRWNU?=
 =?utf-8?B?UUVlNUhZSGFCYlRZdURGVERZS2Q2dG5ZNWxKalhhME85S0JEdkxERExuN0hZ?=
 =?utf-8?B?bWJJZFJCZFVyRDBLTjA2RVIyMUh3dWN0YzNEZGhCUm1uRk5idHFJUGw2NXFM?=
 =?utf-8?B?R25SYWh2YWtzaW5ORnQyalBqWHlRclo0YTd4dEgvS3F4cjl5Nmsyb0l2eUpm?=
 =?utf-8?B?V1FxWW9UNG1KM1lTK0c2WnNHTmpxTTVsTUFRTEhlTEVaUTdLMVc3NTN2Q0o4?=
 =?utf-8?B?SExodGZRZDlBT3lyUFRJU0t1WkhyNktJME83T0lUdEpUdlgra09hWm5ERVAv?=
 =?utf-8?B?b3crRGplWUtzL2JzVlVmSTZ1MGYrME9kT0t3ZS9aZEN4NHNZb0xBQ01DMDQ3?=
 =?utf-8?B?S3FIYXV6RGREcFpQdW9CT0pTSXpIeUlDV245OUQ5MmdWd2tUcWJqQTJ2NHpl?=
 =?utf-8?B?b09GYndGRWgvV1lZL0ZEQXBCOUg5NFhDYW9rRnV0Y0tScFpnZ0JqTkVDWFJz?=
 =?utf-8?B?ZU84bTlDeDJ3WXV3NEJNeVRsNWt0K0xVNFIyeFdQZ0Y1QUM5eWFxM2V6bWcr?=
 =?utf-8?B?cHhqanEvVjRWM1k4cGlhUEFrZEFLa0dTS3lHcnAvVmxKek4vNDhPWVYvckMw?=
 =?utf-8?B?ZktqUk9VZHhna1NCeWlKVzMxeG45cGg3NXgyRDRrQ093cG5MNUtha201Zmdn?=
 =?utf-8?B?SUQwZjREa21tV0tVbXVZK1Ntb29JZEYyVDF4aENCNTZkM0hUOVZsNEFQcFE3?=
 =?utf-8?B?QmZudVprVit3bXM4NzhDRm1waGZrSW1RaDYzZjM4dzR2OWxpV2U4MlNKOGdR?=
 =?utf-8?B?UWMvN2xyK2o1QXU0dzRFcm9qd2tIWXplSVpPS3FtSS9QK2FCVTAySUtjK1RE?=
 =?utf-8?B?L3ZrNHM3ajJXeXM2TlBRL2pLYWE1WVZPMWtlTnRoTC9hRmF6Mkw4YVVxTnhU?=
 =?utf-8?B?b1RwMHY5ZTRFVXdJSFFDc3BRc3FHdU9FNnFYMkw3TGU1eFZleXhhdWNYZFNF?=
 =?utf-8?B?VHBSYkNuZXNQSXdyallpVzNHRnN3dmg4MnA3bW1QMXhGaEI2R1BUYWhMOTRZ?=
 =?utf-8?B?Rjd5bXhhZGZFYlI2R2o4dTQzbTBnN29aZDQ1MDZWMHJSOURPeXdEdGdUMVFk?=
 =?utf-8?B?a3pFWGl0b3BxT2FvUTJUUlphc3V6ODlMN0pZRFJhY051RzUxNnJuTlpVY3k1?=
 =?utf-8?B?K1dHZWJOQi9MaVdhZWpCUVJVNDlLajZ1cFd6bHF4SVlCR213VVFJbkFERXdS?=
 =?utf-8?B?N1RGTytxNGdwM05MRWF5akRMeU9oclQwOEVhampYRFJQMzBkbXlpRlVabVNs?=
 =?utf-8?B?bW1IRlFwYXNINHVSZGtHRjUrMDVXNkhDZ2hLUU9mNG5YdkdCclRuMlA2cWh5?=
 =?utf-8?B?T0dNcmQyd1hXandzQlhac0l5Mmd0Y1dCVzdhUzdIejNOMWJQd3NyTFcyN0gw?=
 =?utf-8?B?ODhLSDBubnRIdTdrU2VMUHBPM0tWQXNqQzBJbnRYYXJIdnpUbUc3bC9mQjJC?=
 =?utf-8?B?QmdIeStRWVhmRENReVozQ3NYRFIwdWthZ0FGVmZDYWs4TEduR1hRTkIzdXNY?=
 =?utf-8?B?QXZJeFd0U0dLL3VybXluTzl6RVBBUlJxMC9nMUhoSkJiZUhhdnRzSFFIMzRy?=
 =?utf-8?B?NWlQRDcwdWEvRjFydVdIMEJXamQrY1F0VE9RNG94WVZpY3Y1cHRNQllBb3VH?=
 =?utf-8?B?UkRaSWxIaHBhUWNERzhhR09mUFkwTUZackpYakdrL3pFQlhIZTBPMjFoZEFB?=
 =?utf-8?B?NWIrd2VqR1UvR0x5ZzNlMlZic0JKVTZpSno4Q2xOSDVJK2s0dGpwQXZlOFRi?=
 =?utf-8?B?cERyYWI3ZXRRWnllVnhUOGIxbXF0NnBoNnUweHFxS2tVcTlzRldOWFlUYW9Z?=
 =?utf-8?B?Vk9uR2lOWFQ5MjhPU2NSanhjZ1YxejJMNmxVRzJJYlFDc0lvRTBhSC9kMjRH?=
 =?utf-8?B?R1l0dkFYMTIrOXJiSVJkMTlCSklOSXNiRGIwVmd5bFRWRWdCOHQxMFZONk8z?=
 =?utf-8?B?QmwrT1hYZnB1REl5Z2RER05QWmtVcVNKeFdzQ3UrdHdEVUVWSGlLYVMycEZ5?=
 =?utf-8?B?WkJhRDFGeWJJRjQydW5uRUptenQyOHBESXN6RVRZUWl2V3lzQ3UyeFh3bjdt?=
 =?utf-8?Q?OfNZOYATozCBAHtll4+DAGc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 511f2677-d9ae-4538-d2b3-08de082408dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:39:59.5103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKcWAoayv+vCuvvvhOORZ/XtZxs78o8s3MfJA25yNkq5pjmbQSvgqhxlOKwXlb/f7/jwKOT1cDzLvkbQj8k1ctRxzWUn2S50LakX5kF+zt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5823
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

yes, it's already rebased in top

On 10.10.2025 20:38, Michael Nazzareno Trimarchi wrote:
> Hi
>
> On Fri, Oct 10, 2025 at 7:28 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>> On 10/10/25 18:51, Mikhail Kshevetskiy wrote:
>>> As was noted by Heinrich Schuchardt, some SoCs may not support 64-bit
>>> divisions. Fix an issue by using lldiv() instead.
>> Thank you for the patch.
>>
>> It is on top of
>> cmd: mtd: fix speed measurement in the speed benchmark
>> https://patchwork.ozlabs.org/project/uboot/patch/20251010124115.1545865-5-mikhail.kshevetskiy@iopsys.eu/
>>
>> Adding it to the series might make Tom's life easier.
>>
>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>> ---
>>>   cmd/mtd.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/cmd/mtd.c b/cmd/mtd.c
>>> index acd886da6da..2bc9fea697c 100644
>>> --- a/cmd/mtd.c
>>> +++ b/cmd/mtd.c
>>> @@ -10,6 +10,7 @@
>>>
>>>   #include <command.h>
>>>   #include <console.h>
>>> +#include <div64.h>
>>>   #include <led.h>
>>>   #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
>>>   #include <hexdump.h>
>>> @@ -595,7 +596,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
>>>
>>>       if (benchmark && bench_start) {
>>>               bench_end = timer_get_us();
>>> -             speed = (len * 1000000) / (bench_end - bench_start);
>>> +             speed = lldiv(len * 1000000, bench_end - bench_start);
>> Here you assume that the benchmark never takes more than 4294 seconds
>> and thus the difference will be less than U32_MAX. This looks reasonable
>> to me.
>>
>>>               printf("%s speed: %lukiB/s\n",
>>>                      read ? "Read" : "Write",
>>>                      (unsigned long)(speed / 1024));
>> You further assume that the compiler implements this u64 division
>> as >> 10. You could be explicit about this.
> The series is taken already, so it means apply now on top of tom tree
>
> Michael
>
>> Best regards
>>
>> Heinrich
>
>
