Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5FCC8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8A2831E4;
	Wed, 27 Aug 2025 09:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="b62zWyn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E778831E4; Wed, 27 Aug 2025 09:46:50 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADF283192
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIEatuhD6zYpw9PnPcqIIlqYeI/STJtZxo/VCLFpgrqx1Bb3vdo9355gtW5qKZqN5xdCYEZzWjCI9U0fV2WG8U1FKGNx74zlIaPnFUKQ8SRGUZWTLmZiT6UcxGvg1uKcBVLs/YGvnRM6TnlVaJPUmeehvVLgpziCPk+iOZZlvm4Mhq9eM6bAkVVcTFU+pA6EOgSgv8XEb10/Fz/A6f4Ss/rZ0L3Xpm0yhbGUvhHa/G4d2svyey5cmwLriCHeKiFHOaPmvliC6ibUlUWfsASUFIhu1bUAp0BqUQcWkRdNpOLPaZkDuDASmqDyi1A9SCnUo747LEKtMYYZY1GwG/duvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e/zaJrO3y21Xmm7S1TjyVZSXdo3b7l/5NX476V32/M=;
 b=Qb64xSCtso0+qt1xli9X+tg0Gfx+pUGv4Cb24Q0ObJ3HjBy6hEmxncFNkT4bdpW/d2/WfzuSViBsB8In/H5GXlMH1MlRgj76KVtFDAYZN46P+z4hVi2fWlrpUeN8gH5aJRAr9SpSfCJ5YAaEjfK40Ji1V4LuMw7pq5vGbsON8EeFiGDACC+YyR68jN3iY7k1F02kiWY4ZGv0pNIy4RaIMbK5AuzgbpbmCZTdL//xWFKuL1Gj4Yec5n2PxERdpSB1VQqosFkE2CKa/Nw4bj3BxvfDu2cyhpH80poelAPx6nLux3uQzyzF0TAeN8f20c/MmoNLs8XJfv/H3ySMj0BinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e/zaJrO3y21Xmm7S1TjyVZSXdo3b7l/5NX476V32/M=;
 b=b62zWyn4ITxfGdyeAJaH5J02gmIiaExXi+HIpTkwQN90+efrur5N5RaLhwD+EyJGu8ZN3HHExmoI0ruzUfxo+iFNNMB2SrKn5nsuhl9s0RbUfz8GsN08hutXT6GLvtXb84XHFlNubFDwXvjjuFO+9LYFpaQ9bi7v6nA7gc+cOdsa5M0x83XyVI7uBLsVH7E1EpB830PCNREgWVFJYu7ZdQ7F80rSt7SbQKCX18OYz3IV4CKP9lfnVtnfzZ/FPp16qXewtWswC+/efvwHf7STF7e1cRjrKbwSTH96eYlisJT9RkN9t5UHdq8fUYo+Y6tbjPz375ILtee8TPRNt7zW5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB7578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 07:46:47 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 27 Aug 2025
 07:46:46 +0000
Message-ID: <1f9892f7-89bf-4503-bac5-beff1e1e14cd@kontron.de>
Date: Wed, 27 Aug 2025 09:46:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] power: regulator: rzg2l-usbphy: Add parenthesis to
 return expression
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-4-42a4105336ec@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250807-pwr_regulator-v1-4-42a4105336ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 16688c27-35e3-4b54-2c9e-08dde53ddfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmdKUStpZE0vZ2NVb2JkMTNlY1dsbWI3ZnNmcjcyaGNOMTh6NUlaT2htamNK?=
 =?utf-8?B?VEZiWlFHZG9HTC9sV1AyNncvd2ZtSHNUdTA1OTh6aTdSQ0pQc0owTzdIOEFi?=
 =?utf-8?B?UWhZcTQ5azV5cFNoMUxBek9rZ21XVUkyeit1azdZVFZ1NjhIam5ndGRadjJU?=
 =?utf-8?B?YVAzVWtIQTV3S0lSOW5CRWwrbUMyZ1h3YkpHRW12bXptQTVobnlESG5XUGov?=
 =?utf-8?B?QVBGVnU3aUR4cHVLK0N6aTE3cWRQcm13eGhqcmFvUmNUd0dwOGpCVkl4T1dL?=
 =?utf-8?B?bVV5YUI0RDcxeW9PNERzcUFjTGdMZ1Q5NzdTejBRSWNSWFkvT09HN2MxK2g1?=
 =?utf-8?B?c29qR0M4WVhhd2xNSHpjL2g4L1JmdURtWHZMcXJESnBVcFdMVE1ZcUc3cGxl?=
 =?utf-8?B?OEE3L05hK1FDUERVOHZFUThVVGd6TEZydEU3VWpoUVpZVDQ5WDZWTDZkTmcz?=
 =?utf-8?B?Tnh6NlBpbTdFQzVMclg5QXNUUk01eXVrQzlpVFd1N2NyUUxmOW03d1JxYlFZ?=
 =?utf-8?B?anNkRkZuWlJ4YzdmUmdXZkQzOWZKRUhDdUE5eDZzUXd1MXVsQXMrNkpKTGtF?=
 =?utf-8?B?T0t3T09ZZzRjaFJHbDRkL3MrTjgrZitCODZoaVhnbTh4ZnM5VENudFZxekpP?=
 =?utf-8?B?RituQTU2QlRaNlpWZkRZVVhwQnlULzVObUFZNlIxZ2IzbXo3OU9ReDI2WEp6?=
 =?utf-8?B?VDkvcTNxaXdJdmFuRWNxS1V1L09kcnZrZ0o2TzFXaFRMNXl1emNHeWRndTFi?=
 =?utf-8?B?RmhFUmxYR1N5Y1QrNXBWV2tXb1BTOWk3SU9UbWlzYjBndFc3REVSRTRxZFMy?=
 =?utf-8?B?WU1vWVk1ZGVSRVorZ0tQRUVCTnlDNDBjNDFnbXFQdkY3MEFrcUd6a1dPSmJu?=
 =?utf-8?B?aUcwOVpybVBaWFlhem5YdkpkcmlNRVZCN2pJWkRtWVByNjhsdDlsSC9ZY2xT?=
 =?utf-8?B?eTlpUitFamloQ1F4U0M0UnI2MllUMkdLbTEyWkV6UVFvRXJEcmpJY2FUbEZa?=
 =?utf-8?B?cWZmYmZudi9aeW9DZlVBb1c4L056Rzg1b2dNTytXTDl4b2EvcDdORnh0ekVj?=
 =?utf-8?B?VzRMN3FkZytRU1AvRlhRSmJKbzVORTYzRmRFSnIyWW9PY1lRa0ZTTnRTU2xK?=
 =?utf-8?B?U2tBZzdsVGt6eFBzc2c2UVFaLzdwbHptcjVxMkxtN0V4eURiUVI5a1R4MEpV?=
 =?utf-8?B?NFFSbjhWK2FMOWd3RW1hZmIrS0VMbUMvRnU1LzY0SjZuaTV4enFhQW9hZkJq?=
 =?utf-8?B?WHpSeC9YaVpjcFpMSG8yaEhkc2RVQThmeXYzdlpHd1lNQ2pzV0RPOXp3RkFM?=
 =?utf-8?B?WUhEMkpwRWFSdHNJVnlNMmd2VFN5cFY4Rm42Rit6SWJSb0VVZTZkWFZSVTJS?=
 =?utf-8?B?UnJ2eWNLMjBjMS96ejZHRUVDRGw5UVhFbnAvRzMyczR0ZmJhaDQ2bndUbFpG?=
 =?utf-8?B?bWxxVUswRnZGd0xhSjJ3TTR2bjZMbDVUak9wUFY5WFFXc2lQT1Vmb2JCWUoy?=
 =?utf-8?B?WWhid3QzV3hzcFUwTFBXVjIvN1BjeGRiUEw0M1NtSGJ5YWpFVm5qVUN5WHNZ?=
 =?utf-8?B?ckhZYnJHM1NxVXBQaWl6TlNRQkd4eXA5aGJHd25nR2FmTXZoUE41WVhKSDJW?=
 =?utf-8?B?ZTZ0bTJZQWUvd0RQY2VVd0Mxc2MwSEp6bVc3SnhsV0RiYzRubzJHbzhBMVlT?=
 =?utf-8?B?RGJZZ0t0Nmw2bFpHYVhNNkJKd0xyd1kyaWVjNHJCUkZnMHRaZUNNaTBpQkQ4?=
 =?utf-8?B?NGJobmloUUVVdjFBK0RsYnkvcXNhOFJiK00xcVBwV0RwQUtPOC9HOURYNVY1?=
 =?utf-8?B?VHRGd1dHYUt3ZlJabE1GcG9TckpGd0pLUlpuL0dldE1EUGdlN0pQR1NWRkZ3?=
 =?utf-8?B?a3RqOHNVK0FLN0p3WkEySDNCbVRJSnN5UFFuTWZKWkIycmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2RVcVdXKytoeHJlMzVGSUUvblozczMxSjhENUcwVlc4T25xRzB4WE9UTFNo?=
 =?utf-8?B?SHpuR0Uxd3duVklTdEN4cllXL3Y1K0k4ckt6SW9hWVA2YjJzY1lrdXk1cVZ6?=
 =?utf-8?B?NS9tblZaQUpCOVVpaUt5L0s1VzR0STJ2eDc1Y1RzcUdvQ3VvZUczOWwrT3Vl?=
 =?utf-8?B?eFBHVDV3U1ZNYkoxNHVOamR0NDlraCtKeW9zSUErdXJOUTJWUmpyWDBzS3hC?=
 =?utf-8?B?Nk9kdy9xU1A2UVdVYWpTMHRNV0o1WkhkVlFacm16bDM0TlovSjZxMWtOMnJD?=
 =?utf-8?B?eW5Ldm5ZRVFucURaaWxxcUcwSTdBeXBTWVhDUVpXcGQ2Z0MzODBIMzNWbC96?=
 =?utf-8?B?dGJsNEIyU2Y5QUxmaTZxWmk2K21uZmU1QU5IZVNucmhYRmxscDBZaDV4TXFj?=
 =?utf-8?B?cENZK3UyTkpLRW1JV051V2hmMk9KaFRRQXY3Qi9XOVh1aGZCa0JsaHNQN2ZT?=
 =?utf-8?B?azVxZVVqeWwyUEVaTnZ6MDVFeWlhWWFFRmFLZzIvUmFXQUk1c3BZbzNMQjEr?=
 =?utf-8?B?NGZ2NHRnYXFlRkErSEJKMXBrNnVHRjVYRW43UWhXaEgvY1ZESmZWUm5JS0ZG?=
 =?utf-8?B?eUthbm1xSlUrUmpBd3E5SGhVUEFnWTFCcTluZVhTaEhYZGpkWldqTnNxU0NC?=
 =?utf-8?B?YmlMa1VBMlRFQUEzbk1IL25XTE4vQlVuSGQ0eE16d3BHajJIWTNoditsQkYv?=
 =?utf-8?B?RTlJUU9JS1Zlc1RkcG9EMmZ2WG93eXFBWHh0ZFAyWEVBR3JlMmVubVJNV3dt?=
 =?utf-8?B?V1ova3lXRGw5MllVcHFsL2hVNTg2Wnp4TmJRWmRteXZZbHNrK2FVTnUybXIy?=
 =?utf-8?B?ZUFHVVZIdDZZUmFEeXk3dHZBcndWaU16bDZBS1JXU3pqMmNtSzIrbjBLZitx?=
 =?utf-8?B?QnpuSDJyRm8rUGtXMjNsOUQzNkc2Q3JFUGxFaDZ4UnpQL3paSndYbFFMZU5K?=
 =?utf-8?B?Vjk1c1NwVUtFMS9Zak9XdC9Iak1UaFlJNmIveE5SOFR5aVlPd21COFlsNG1W?=
 =?utf-8?B?SGlWeERkeWNsMWtTUkVyWWFsNTM5M2NEempuZjRialYxVFd3Tk9sS2FTVmI1?=
 =?utf-8?B?N2JPRGxyTDVKQzhST3ZHdENWZ2JWcVk1QS9SdFdIYlFhSmN4ZzZKTUFKUmZ4?=
 =?utf-8?B?NGl6VmZkVGpqcG4rcmlBTXJ2YkcyK1ZKT1lDWW5KWUg0YWkxSW5rOU1MN2NK?=
 =?utf-8?B?eW84SDhFaFc1L00yNm5neFBRSU5BdnMxREF1c2IzQlZFWEJrK29GclZBR0ha?=
 =?utf-8?B?dzhsRTJCT0k2K2g5b3FLMndFaVBvL0pXUGovZUhtQVNFaERLM0ZXek5reTJz?=
 =?utf-8?B?UFoxVkNxNW1CSGx4Q1N5QTR5cVQ5Mk5TQ21TOTlSNm56cnZIbGw3Nm1CUDhx?=
 =?utf-8?B?VnVqSFRRWUN6WWMrZVpYMWQvRTJUOUZUdWhVbHBoRWlIVmQ5eWRhTEo4Mlcz?=
 =?utf-8?B?OGhsSG9jOFBTYXQwbzVRWVFnWGUzV20yazgvR053WEx3MTFZVkNKMFhFRURB?=
 =?utf-8?B?cEJlNVlQT010RTlNWEVjNGNXUlh5cU8rZkpuaDRLOW0rYVFDTlFIUUlkV2R6?=
 =?utf-8?B?YjdJVE1jLzJ4RXhoaHV5bTIrZzhFRms4bWRnNWFYVmFwZnJDZXJOdXZHcjZx?=
 =?utf-8?B?bGJJcVpEYU9FWE94eDV3UTgzYzNNdk5Gb1dCL1hvbk1UbmMrZS9XbW82MURv?=
 =?utf-8?B?Szh5S1J4SzF0bDlvbjNVcUk4cEMzallsTTgwK21sdlRZcFIrcEtoalg0U1hQ?=
 =?utf-8?B?bHlwcW5CT2JPcExPazZIZGtUNjc1OFdHU042SGZJYXk4L25LU3lSSlNvd0tB?=
 =?utf-8?B?aHE1SHh4Wm5MUFNsMXhqMmF6S3VsNVdIeEl0YnlLcnlNViswam1kdTFqOFVG?=
 =?utf-8?B?bTA1V0Y4TXV2L1lKTVJkTU9ZL1o2RWRBdDR0MjRNelVpYTdoeWJrT3l1TkJh?=
 =?utf-8?B?NlkzRWdIb2Y3eDRjMDQxY0diVDQrY0lHc1J1a3Rtc000WmgzRlg4WWlkNm10?=
 =?utf-8?B?NlhXWFBGQ1RZUWdoNk05M2d4bjB0ekJnZnNUQ3A1bkVRWW5PTWZhVjFlUmtM?=
 =?utf-8?B?L0g4NXJxb3l4NWJlV04rR1pWdllZTFdmSkJ6Z244ak1UdGtWc3d1elJGSS9u?=
 =?utf-8?B?ZUY1NWZrbWxtdFBUN3RJWHRrRmd2RVU5Q01KNmt2YVNVckJlS1FSTFR3VWND?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 16688c27-35e3-4b54-2c9e-08dde53ddfdc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:46:46.9522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5sAd2mgR8vJeWgC6t1dfwCTUCEy0H79GBFIuqezGIczPLkVnQFlvWV4o8jyAI+VwISksfmi5BDsqNNis3Izz07+B7bC4fJzCAYMI589Od8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7578
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

Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
> In order to get the expected result from
> rzg2l_usbphy_regulator_get_enable the return expression needs
> parenthesis so that the binary and is performed before the double
> logical not.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
