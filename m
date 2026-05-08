Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6664FCD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05C184CBF;
	Fri,  8 May 2026 14:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ci54Zl7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9411684C92; Fri,  8 May 2026 14:25:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8273084C92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUCxqBmDOCTi8UH60pNwe37vcdH/n3fd23Lbm3Kdz8ifj/ofcnTdX4TWyclMaNabATqlLRbgMrojkUj2IF1dujy/q+wdq0lMhQegk4GF81T+tqlVlFSps/65MZHT2BBpQWB0Fn3BMrTtnSgrHLbV/Qca3lF4qwYEYvuIuEVVYtKGPdczZGogsg7hAe2iAme3vTzq0HdbLirkZhX3MSJSAquyGELHTx3wjIpQCDJCeVZFTSus2XF7t0bGFYK/VWTE81vWR8FN/k4Gwo9aJNOGihwBaLXILM78AKRffaH23vTadg3Pw2x0CpT9rrO4gtLTm1m9JszqCydH82HZJgVVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgucRFzchTqB2uzxamwqeZcRQRRSMaYfrdRlQtZUry8=;
 b=PkmTC19b5yaR9bSqlB/Pd8PKJCnmp8OFwU61kmjMyUsO1XAdoiTY4jbdUkcs8+4p3345ZTq/DQHHPp1twyeXo9o11YL/rCN9xrarKhrodiliK8jrbOPaGxJg4/QVUKy3u8GKAhjLYiPLh469iHiFT7xuzQjYjz7T+QO2XUVv8xhDJoq4tA1kzCep594kgb/BPgfpi/CutTC1ZWBrOMnDEPdbtb+r2QidYbun46SPYjBbbeFX+ky1TjYgkgOFHBlRvKoG+pF3iZwpRGejIQ3SsPK4EN+ZAH2OJoPZ8Lf5rFZDN2OcNBxMlWV/X8GGH1LU6hoNS6jhlt3E1i8ICp6lTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgucRFzchTqB2uzxamwqeZcRQRRSMaYfrdRlQtZUry8=;
 b=ci54Zl7X5zO7uWEJgP8RBUrhG1TxDrP83sLw0azfYP7+K1H+sF4FnAIA3W+VcFkn3W2K7wLJEr2W1Ul8tVIuDraeewoyNlM0vtg1Yn+NQu/3X4VvkUn3T7kGSTWy885yLdGddWAzwqiICrHg4gXqFKk9jslSaEy3VXtY7Dzoyr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 12:25:24 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 12:25:24 +0000
Message-ID: <e299a3fd-902a-41b1-b092-63f18e22f248@cherry.de>
Date: Fri, 8 May 2026 14:25:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] p2041rdb: convert README to rst
To: Michael Walle <mwalle@kernel.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Tom Rini <trini@konsulko.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
 Alison Wang <alison.wang@nxp.com>, Tang Yuantian <andy.tang@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
References: <20260506123507.2081751-1-mwalle@kernel.org>
 <20260506123507.2081751-12-mwalle@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260506123507.2081751-12-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0074.eurprd02.prod.outlook.com
 (2603:10a6:802:14::45) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5a301b-5af3-4ecd-7ecf-08deacfce117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZtyBIorCYZgjHH11WwGzsAORoCGWnSKT1Rut/XdyWtS5rYATodUkhBOHqatgJsKrn9WVqcGShiLTSCywh+6yoQT4DMnXMyojbFT1A4ahEymMbUqjy3h51mY6qoXdXINbDr60A1pOOEmAa8qKM2jxPYd+Iof++xvY+77BxUPy5t7yXksjcKrci1DfsXZd7xjCTNucZyN1S8b3+R1uTMWX4UoD9PCPDRyCjVl0M3u3eV1+R5D363gIGMDe4BNazTQQFGI2ASjlfgozlAj8aoKdO8kN35NvUCPz/EyTmLttvqjD53vN6ibJN5IxByRivvRdlNyc+MJcGkY0Yvjaj6RUu/KRRvE4K8Bk4n6EsR6QclsD/UnLzuuHe/dvugm3XTysSvNSQpa6qQc3x2aN1WKEy/RD3XclF1zrlvmU6kiJGrAt4pOHbhE1/dJStCPfp88apZuT2zRq19R3Z9mdmKyDqHh5q4E8tSrVrhLYj//6vBErGZRKrKa2BZ7Ej3FBESXdaCSxR1uJRvWw9qPG3kw29FFjcdp8Zs9mkGBOdCB5/d6biOR4PcUaMqei8lhZnPcSNyn9LHUySUC5Abh17A830a42Y1hN1Mpsy6IWHdvV7X8iWXoM24oiQSKVzLV+SOLm11WTiMnvDS+t03vfkxhs9Fy4NGIl9D6v1EJZsS79ZvD+BlnpUUUpw+FiSU4RtTr1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejFKTTZTWndvRkxjVEppdTNNUkVSMStLU2tRVDRrOUJuWjVlaHA4ZHlOYi9l?=
 =?utf-8?B?L1Mvek4zVEJ0eTI4a01zbHFDbUJIMTlVbnF5bS84bUc2cndqZkl6cm45VFpm?=
 =?utf-8?B?ZTRDMWNqOUVvTFlLZWR0UWVLYm5ST0ZXU3ZJM3B4UlhsUTd2SjVMOCtLUk1J?=
 =?utf-8?B?eWthbzIzelEyR0FhdU1aMGU3ZUZRM2Vta0NadXJEOUc5aTJ2dktiRUZxZ3Nt?=
 =?utf-8?B?WnZCbkZTMC84T2NEYjc4dUVlQWlCd0xQZHdld0ZLOFczWUt5Smp1dkdBS3c0?=
 =?utf-8?B?NkdCV2pkVGxRMkhzeENVY0RVSEllR2NTWG9LdGVTZUsxQlNCOXUrNCtBditI?=
 =?utf-8?B?blpDaklHMzd2NUpBbDJyQlRuUklyMDhZT0xFNGNOQVdVNXFCR1NEMUZmeEt5?=
 =?utf-8?B?ZkdpeDJ6T3hLNy94TFBManZPSXVGSTFkMS9vdkJRVGQzTkVFLzZDNE9RRUhH?=
 =?utf-8?B?K01NcDFiT3U4WklOdDB4YkxTYVdSQmpPVmdOZnhnRjM3RFQ5RG1WK1JQei9r?=
 =?utf-8?B?OVVHQUl5M0liZXBiN0Z5eEFQS0UybVZrSUZlUFFUTTZpdFd3YWF6emtzU1Zl?=
 =?utf-8?B?TFZHNWhwU0Z2ajBISWQwVklxakZ3bGErK1ZjWU1tRWJuQzJNMDlPVHFOeHV5?=
 =?utf-8?B?NmZEa0J2b1R3YkFuekNpNElDclRVd0VscitTaFZUMlRITGFabndwVU9lNUVZ?=
 =?utf-8?B?VXVrMm96OHg5djl0VzFEbUIvdzJ5UUszY29hT1preHlwSE1ueC9LMmlYVUJM?=
 =?utf-8?B?aGNRSnBSbExmZTNpNTVxcEpvN1M5MVVsUjdHWVpBSEkwYUxjeTFaWWx5MFQ2?=
 =?utf-8?B?eVVQU2l2cC8xNXpBVXZJdG1OaVFPc29KdGJoWkN3TzVGZW8vOGJsdGNUdmlj?=
 =?utf-8?B?L0RvZlA5SzlKakN5QXZldzBUTURyQkl1ZFl2R1JkUHM1REJwaDZXM2FBM2dD?=
 =?utf-8?B?allvVVF1TGwyRHNCbVNjU3dKNWw4VGxER3NwUzJaUVlUOTExNitkN2U0eXhq?=
 =?utf-8?B?MWp0TTlnL3Q5bkFwQnp2OTdGZnh3cUs4K045ZFFFZnJIc205eElmazB5ZFhK?=
 =?utf-8?B?aXBlRFIvaGZLY3lCdTg3U0RMeHlwQ05MWnhLUjcweVdkd2dDWDhXSGVBRWZv?=
 =?utf-8?B?SHY5eFpTRGlQdEQwdlJxRFJXdlBubTNpTFhRZ28wYzJEb2RpazZrVmVnS2Zy?=
 =?utf-8?B?Z2JNZkNLdmZqZStqUzl4Z1RDRUZDSDVFcGxyRkdhVk5XTG85NHI1MG96dHVQ?=
 =?utf-8?B?MUwvNExxckFCWlZHdDV3bk50RGNpN0hKWHpkWG5EZWZxYVp1bW5OSEpPc2sz?=
 =?utf-8?B?cEJlZnlkNCtLMVdIUFlMNHRyQStvOEJLMDY2cmNwUUNoblRKYXBEK2k4VWp1?=
 =?utf-8?B?SWFlMWFsUDBDcWdzU0hSclB4YUhCVlBLcjJMWVAvblhmN3NWQnVId1FPNmxw?=
 =?utf-8?B?bHV1QUhsSWQ1OVZNQnZQenByS1lUdi9EN2VDdDFSaFd3by9JOFl0azNLQzBP?=
 =?utf-8?B?QUhQdzdoV3ZqbzNRNEY1cnIyMmNscXFGT0pOMXRteXdZT25EcVlySkZUWXpT?=
 =?utf-8?B?dEdsV2tvbnkxZkEzanRWSndsSXhNVmN4VTJGbkFVWHJ4QU5nL3lYaVJlTHg4?=
 =?utf-8?B?VVM1dWplY2l6aTVlYzJRWEsxeENVYmtLTzVCVmpBTGVJbWVwcy9WODJPV0sr?=
 =?utf-8?B?QVVqQW5BY1BLRU4xTFluZ1hqSmtycWVnNjJUMEY0S1cxOEFCRGJMS0I1dU4v?=
 =?utf-8?B?bzgxNm9OUFI3Uk1OejFSYno5YUlzVE9IRFNpTHJHamtZMkJhVHpURkhEZGNs?=
 =?utf-8?B?R2xHcndsYnJMbFhlV0wzWkg4MVpSKy9kUUdqSGFMd242Nkc4TWN5R2dJU2N2?=
 =?utf-8?B?Yis2Z1gwRHl5MFRxbmNWNExJYi96dUFNRmQwSEdXa1Btc3dJTkpGZ1p3K0Nn?=
 =?utf-8?B?NytEZkIza21VNFdMS0RIeXlyVG9SSjBuWkdjRHRjOHFCM3YrcjROdHJ3Wk5j?=
 =?utf-8?B?V1lPTXI2dUx4b2Y5Z2x6Wm1YcVdnM3RKdUhzWTR3S1IxZEk5UGFwTHpWY01W?=
 =?utf-8?B?eE9HVG5Rak9CMjE1UkNlOVVRaDc1K0ZZUDF5b2ZubXNBQXpDck1EWlRtZ24r?=
 =?utf-8?B?VXJyTzJJVGhwY0lyc3NyZzRLZFYyL29xTDc0VFZYZUFMVXRLM0MzbjFjSGVj?=
 =?utf-8?B?QjFYMGpvM3RRN094bjRlZjdnQjFVWHFqWGxYOE9zNklCc2JTNXpoeGNtNEli?=
 =?utf-8?B?VDNkZC9XL2NIR2pnQmFETHNPaER4Q3RldW9tSnhHaG9VcmIyamlZa1dFMDBv?=
 =?utf-8?B?elZqZW82bGJJV0JlMm4zOUFlQnFRaXd5L2JKMmhjN2x4YjB3QXJrdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5a301b-5af3-4ecd-7ecf-08deacfce117
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 12:25:24.2886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyTFJjRVtI6JHTESeuX89SrXMOWXTm92+Yj2lJ+TU10s6qiNvvQso/ibOioSY/cdjPPISKl9XNvfWufJJ0Vo7J0i4N+0asc3KZCdEmG2DE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972
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

Hi Michael,

On 5/6/26 2:34 PM, Michael Walle wrote:
> Convert the README to reST format.
> 

Any reason we can't have it in doc/board/nxp/ (with an update to 
index.rst there)? That way it would be available at 
https://docs.u-boot.org/en/latest/board/nxp/index.html.

Cheers,
Quentin
