Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613DDCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00CF83A9F;
	Fri, 28 Nov 2025 17:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NoBfPZN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89BF583AAE; Fri, 28 Nov 2025 17:27:26 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A49883A8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNAQEnMwkRu8C63Mw+s/2WkWGlHAku4rGUmf7n4TVRv5Jyy4T4fNKESrDtnrA3HSdIK7LyFY+D99FF7RRUwYX0fnzkmrn090hCsr3Ojo3MaeB+AkOgtd5ZpnJc+mogn6Yt/1l2IejM/McraS2O1Z3GKgWXXEltvotEyyCw0uqq6tr3FADTB+A6TSR85eLuPTg+PUWx0OzJk0pJO5RB3BpdNAlS/E6EtdaQrGm1HAsVlsOCF2WWSOJWriRY7Jz1108arkhf/REn8GJ0LlLB4ZxMuYXQetUDOrQf0l8zUy4cVUGfGbmgdk/BQtr2c2NSxPd4suIhpIO01ejWIG9E5ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FKSS6csYSCsjaAQRHiobwhQ6w6XX3r5xc/tYjpFenc=;
 b=ar/iqfKdbwbhJgGXDxeEfpz2qZHxsYXR/LbQmXc+knpUEsSlZE4UgDb1oc7Icu0YVvvd9h98czAjZ4y6GBsDvuWUaIFkY/zDhUs6rqWY8HaYKuRDEqCB9ScvsSf+0frjCcBgQzeElXGosGPUmiv/Our1El75bvW3anCAHbDkmi4ipNF18mQDKRY6SaTbuAzMgEb0HC+ly3K4h6PJoYCOr6FMHirXF8j2dXJfs9QE5hSBXY+Ra5xE7HJFRilHYKIWEl9iSvBlswxtbmW4lfCJzFaLblTYXANXvxb67XU8xssuSeL+Lg0snUz5Crku9Gs9Cfl/2zm7Hti1njF6JSmLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FKSS6csYSCsjaAQRHiobwhQ6w6XX3r5xc/tYjpFenc=;
 b=NoBfPZN16cIjtJUDIjXutCyzffpLw9yBfS00DF5ackCdUvA9tKuvsGzROa5FJ/X+6bHQmExHgn65Skw05YuZu4ytlf7ZABc6Uf5U5r0oz//57mFWCzcDbvOK6PYW/jLdzRBZDWk6bcHE9GO/r/dgM8aLsnY9xUHPmqNHbbly6xQXsSbvZxCLfcsLtlwI8Ra6bgKdodvy/wns51XsgUbyirs1YpKK6q/VIECtYosBWnokCjmD6+yU09aRmFXurTpD4I2t3yxTq6ffbs9bNRnXNIkHxMnliD7AdZy+JDMjEh70IoeXXa30yhdm8qQ4tq463wTK1sR6accvhyW47cq19Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21)
 by GV1PR04MB10679.eurprd04.prod.outlook.com (2603:10a6:150:204::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 16:27:20 +0000
Received: from DB9PR04MB9427.eurprd04.prod.outlook.com
 ([fe80::34e6:ceed:e6d1:184e]) by DB9PR04MB9427.eurprd04.prod.outlook.com
 ([fe80::34e6:ceed:e6d1:184e%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 16:27:20 +0000
Message-ID: <6907aa94-a1cb-4188-88e1-90260c0d6646@oss.nxp.com>
Date: Sat, 29 Nov 2025 00:27:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] imx95_evk: Initialize the ELE RNG context
To: Francesco Dolcini <francesco@dolcini.it>,
 Fabio Estevam <festevam@gmail.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, "sbabic@nabladev.com"
 <sbabic@nabladev.com>, "trini@konsulko.com" <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
References: <20251113082145.898431-1-alice.guo@oss.nxp.com>
 <DU0PR04MB96367EBECA5951D3B9B7925BE2DCA@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <CAOMZO5BH+=tDCCE4sJtHwQyyu5_+tOJTQi+=+o1A1QT7ML3pkw@mail.gmail.com>
 <20251128114212.GC32259@francesco-nb>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20251128114212.GC32259@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To DB9PR04MB9427.eurprd04.prod.outlook.com
 (2603:10a6:10:369::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_|GV1PR04MB10679:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7a546b-f3a3-4eff-26ea-08de2e9b00b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmF5VUU3TERHNGUzaW5BVTJvM1VsbjQ3NjQ1aDEzcEVySEhJY2ZiUHBsR2hY?=
 =?utf-8?B?MkllUGFnYXlsYmtMWHZnNHdHUmNLZUhtYnFGZlZCM2o0eCt5S200d2F5Yzht?=
 =?utf-8?B?UVZDMkMvK0tDK3VlcEFZRDNJZWp1dTRRbU1IOU04VWV5QU9BRWxHcURndjNh?=
 =?utf-8?B?cG94djU5QzFyemtERHFmUGh6M3BjZll5ZktDQjZTZEVVb2I0UFBtd2l5TC83?=
 =?utf-8?B?YVdPcFg3Z0pmbWZzWDJtNDQyeks3WDJiL0VUQy9VTEVHeHJXKzMvaWJTM0pt?=
 =?utf-8?B?VWlDQTRxN25vbmloNVFQTDhkbTkyUStKcVdKZ3dPa2JWS25OZUx0OVB4SW95?=
 =?utf-8?B?ZjRRRk4yUkkxejVuSjRqdWdRRDdENGFQVHNaMlVUbjc1VUgzZ2ZMOTM1OWwv?=
 =?utf-8?B?VFkyWFdoSDM5dVdkam5ZVHQySm5YZmFzUVVrVEJlRHZqNmUwYmNtaVpBWEpt?=
 =?utf-8?B?UUFOaDBjbG1xcTVPQnNOZHFqRld4TTh3M2tORjRGUno0Ti9TcC9yUk1pYmdF?=
 =?utf-8?B?dXZidWF3U21MRVN4UVBHRmIwbnpXVDFzWWRmYVRNMDNWSmFZSFA1S01EL1oz?=
 =?utf-8?B?dzkxeXhaZXdoQnRMNnVqWjl5cDJPb01TdHI4bGl5dFBjVis3MkFrNWZDTzU1?=
 =?utf-8?B?WkFqUUpBQjNzc3ZDWC9DMktTSVRqVm4vdEJNL0tYc0IrbGtjdVcwVlA4RjBW?=
 =?utf-8?B?K1Z5RFRyaWRoTHBhVllZMlhJdmpDMkcyakMzQ3g5RWg2dFNaa0MwSVZxL1ZC?=
 =?utf-8?B?WVZnSWttOVhHS3N1VWpBdmFmZlppdkpiTjlmMlltS001bHMwbXQrRk1CbTha?=
 =?utf-8?B?YldIbk9icXpIZzM5VHJGbXJZTXNlWEZBTUZxQ1VEM3IvdDZGWFJZVUFEVjUv?=
 =?utf-8?B?emZNU29acldtSldDYTJPK2FqRHYzVm56SFZmUzR2MWJMSzJtdTZubEU2Z082?=
 =?utf-8?B?M2puMzJUSW41dWhuY0dDWjdHcXJnWmhqanFNd3YxM1FRNkNmSEFqQ3FSRjBn?=
 =?utf-8?B?SHFsZ2ZTOU9PQkNmT0cxWXNiMGt2TTlyUS9RUFpYUzY1ZmdHenUzbmc5UHEw?=
 =?utf-8?B?K2FySzc0RnFIWWlNRVgvaFFPZkpzZTJDWm1PL20xbG9Mb0tBT1dvWStKZVlp?=
 =?utf-8?B?SXlFcVRxL0JSWmpwYnFMRnN5SzlFaU15WXU0cWQvTkNhNUQ3NC9NeFBkRFR4?=
 =?utf-8?B?MnR0cXZKdERQNnUvcHhuZmp0NGpBTDArcEM4UlVNZm8zSnI3M2VQTGZYSS9Z?=
 =?utf-8?B?V2QrMDI2TUpKYUtoMFNsVnZXVDBlczdJSXVGVDBibEk5K0ZHZkE5TjE1a0dr?=
 =?utf-8?B?dExmbGFnSkl4aFNZcWgxdnd6Wm4xcVVLNzhQaHhIdW1wZDZ1WVhjalRkUVpi?=
 =?utf-8?B?QjhGajdxVXlPYm5POEhvcTM2K01QZWlRSEQzT3Zsb3ZkOWFPZUVVRHllbTNZ?=
 =?utf-8?B?ekJaa1Z0ZUFNdUNWZjNyOCtGT3FTUWw3UG1kNTZYVWpjbUxySEc1NFlHY2po?=
 =?utf-8?B?ak9JbSszcVBWc3FyelR3V1d2eXBTeVJhemJ5QTkrdTlMMkh5dy9ka3oyRnJO?=
 =?utf-8?B?K0FvVDI0Uk85dXpNVy9CK2ZmZFhRQnJCN2dpQ2EraGgrMWVpTXF5QlFaMHE1?=
 =?utf-8?B?RjlBdlRKSy9aWlk5Y0RQV25YVGpuY1M0azIveUdQU25PUXFsUEVGNU1qU1h2?=
 =?utf-8?B?VVpHSy8zSUFVcWJKdE14ckFKbTdaaXhyMUZ5Mm00dzdwMjNMaVJhaFJ0N01F?=
 =?utf-8?B?SDcrRStVZnFjQ3h3MmNQWCtSZWxDb1kwVmZEa012Z2Z0TTBTTklPT2VBN2JM?=
 =?utf-8?B?SXFDemw3L0tKTFJKbERxbG5aQksva2NFWDFuejBiYndzWWVyYWV4dmJaR0NU?=
 =?utf-8?B?Wm1HdUJ3Sms5NnNidVlpVndJK3JxaVdrek85OFVBQVZOVjFGMks1dUcrWFU4?=
 =?utf-8?Q?nAxTyb8t8Hd45ng5HSZqcYdZra2t4Jjg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9427.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFmcTlGY1BhMUdxSTJ4dHV5VmRKR1JNUS94aHBsZFlEcHdwRWhDb3VaZEF6?=
 =?utf-8?B?ZXNlK1Z6OHVKVCtrSmRTS2JaN2ZOU1NqTG5LQmF2YmNxWUppUXI4bGhrRzh1?=
 =?utf-8?B?OWtmbWx0ZFUyMFhpdlRwUUtFWTg3MkorMnE5UkFDZkNyT1E2dVBzbjlMSjlk?=
 =?utf-8?B?ZHNnbmxwU0ZjbzAxeUV4THlvMjd5TWtXWEFzUE41WmZZd1RXQzUvOGtJblpJ?=
 =?utf-8?B?bkJmNHFVVk16NWJYSEZlZ2NVS09taU11QWpZMml2Y2FjMzNZRys3RFY0VzlJ?=
 =?utf-8?B?aW9kLy9SS0hNYUtUQzVaWGgya0R1RGk5WHVtR3BWTGpMV05DV0NndlZNRFZD?=
 =?utf-8?B?SWpuMkUvWDByL1RYUkxvd2FvbXFsL1J6N1NIaW9XaW1PSENXSXpWRVpiRDZD?=
 =?utf-8?B?d0Z0RXJ2dTdWUlJqMDZSOWpYdmo0a0QzK1RmZEVvb0h6YVY3Z1RWdXFGdE41?=
 =?utf-8?B?Vzd1dHBVUDA2dGVRbmhoK3FzWHl4eUxjb3ovdCtnZEJXem1PQWpXNUl1OS9z?=
 =?utf-8?B?MEdjVUtsNUJXRStzV1hIaTlZUk1MRTA4SXRDQW0vek5aRUFValJPQ29LVVk2?=
 =?utf-8?B?RHdlTk5COWdicFJBYS9mc0djc0sySmdsOW1kQ05MUXVQZ3Rtc0huVTFEM1dN?=
 =?utf-8?B?bXhra09WNEU1a2I0dmRzaEI2cXFHMXViWDNidFNqeGhndFpKL3JOZTVCNjZt?=
 =?utf-8?B?dkNYdXpNSWRFc0x0TFRZYjBtRWNjR0tZZlduVFNxZ0E3dFZ6UVdhSEd0RXQ3?=
 =?utf-8?B?YzZsNlJOWDhqMGYvdyt0aHgvSVo2TVo3K2VOZ0V0OFpCUS9vWkFCczR6bEdw?=
 =?utf-8?B?KzhNUEVXLzdIWjVkaEN6Rkh3dVVML2wrcHNhZTNCRUNXOHpGUkhSbmdpa2d4?=
 =?utf-8?B?VHFGb3BOWnpqZDlSSkZvZkZYWUZuMzZDWXI1OTRQc2prV1QzamtjRVBlSHY4?=
 =?utf-8?B?UktiTlkvVlgwVEx2RkZRZFlpR2tPdm9hVGpUbDFGejcxckoyVm5SdlhJWnRk?=
 =?utf-8?B?STFDWFNyMEFZdWRqUXhVWUJYN1lsUHAwbGFkYmVaNjg3eWY0ZDI1eXlQa1VO?=
 =?utf-8?B?R3A5TGN1RHhXMEFjNVRzK1ZBaG1DWEVkbHZyR2IzK2psMGtmbVFiODZ6YzVm?=
 =?utf-8?B?ZWVwWlpmalBMUWJ6RDk0TUg5dzl4SjBoUHcvNWZoM1dLajJGNmFSY3ZpazJC?=
 =?utf-8?B?dlgvY0NjS1V2RUVMcElMeUEzSi9CYy8zQWh2TWYwT3M1UzB1dnRiK054WDU3?=
 =?utf-8?B?RDhmVG9vTnFOMmZuajRoVTFXWmRFSnBtdUloRVZSRm5Sam90RitTbjQvVURV?=
 =?utf-8?B?N3MyMy81b1ZiVThwU1VRcXI0Wmk3dHV2K2F4ODJQY2dWMmoxNFp5UkhCQmF2?=
 =?utf-8?B?L1JsWWZlR1gwb09lVnNpT1NzdnVpYkREbUQrSmFUVi9MZFZVNWxZWEZ2dm8y?=
 =?utf-8?B?WkIvSUFWTWlaZUtsYzdJRm84dzk5N2xzRWlkV0xXRkZiV01kWkMxZWVTRFly?=
 =?utf-8?B?dlk2M0NpKzBNU1I4Z0ZRaDBlYWZvY0RvMldhYWdDMUx6U0RiQ29uUnFaZTdV?=
 =?utf-8?B?cWxjUU40LzhrZm0wMllwU3FuaVdnT2ZYZXg2Wm05Z1FJSlRQSWdjcXhEeXkr?=
 =?utf-8?B?NFlPMFNKa25DM2EyNUhBdFFBVGhLaUdPVEEybEhsYWpNV3I2d3JqOENQZlNn?=
 =?utf-8?B?aklkczRadDVtZE1qUDVKOS9mUUtleGhuY3lYb1JrS1R1K21UdVBzc3BlcjZT?=
 =?utf-8?B?WXVicm9IUythVCtQbkhsQ2VKVVBVVTBGUzJJdFIvc3dXV1NuNGNZWXlpMDNl?=
 =?utf-8?B?QlhPQ214czNnT1NCTVdUcVpjNVkwZUpmSGo1aW5KZ0Z4M05zN0NnUTlUN1NF?=
 =?utf-8?B?eDROZ1d3Nnd0b0h0WUZzc3NjRm8ybHM0V2VpQ3F3RXBDYkthbFFicWxVaWNO?=
 =?utf-8?B?OEJMYjk1MFQ4OG1zNlZOOW5NSjNwNnIwRzZLS2ViRzBQZ2J5M05hUzVuNHhq?=
 =?utf-8?B?aTQzUm9ESlVqRU13NzNGU3V5VWZwSzFUOXpsVWlzUzVDZmJ2aEJEcmVyWmJz?=
 =?utf-8?B?M0Nmb2QvUkREbTY3VmM2dmZGRUM2WTRIclhVVGlQbEJIemNEeW1NbC9jOE95?=
 =?utf-8?Q?iF7huSbWpA6iHg64rS13ewBL1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7a546b-f3a3-4eff-26ea-08de2e9b00b3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9427.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:27:20.3129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDskJnvr0rldRU6PwRxfHYqYq86j94G5xY6k7xzvs371KAo51E8vxl1lcRS7cqsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10679
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


On 11/28/2025 7:42 PM, Francesco Dolcini wrote:
> On Fri, Nov 28, 2025 at 08:00:16AM -0300, Fabio Estevam wrote:
>> Hi Alice,
>>
>> On Fri, Nov 28, 2025 at 6:08 AM Alice Guo (OSS) <alice.guo@oss.nxp.com> wrote:
>>
>>> Gentle ping: Any comments on this patch?
>>
>> It looks good to me.
>>
>> I plan to queue it for u-boot-imx/next soon.
> 
> Fabio, Alice,
> 
> Is this something that should be more generic? I assume every i.MX95
> board should have the same.
> 
> I was looking at this and thinking that we should do the same on our
> SMARC i.MX95 board, but at the same time having this code duplicated in
> all the different board files does not seem that a good idea.
> 
> Francesco
> 
> 
Hi Francesco,

start rng depends on use case like when and which SW component to use 
rng. It could be placed in OEI, SM, M7 image, not must in A55 SPL.

Best regards,
Ye Li

