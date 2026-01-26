Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007CDCF65E2
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 11:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23F8883B32;
	Mon, 26 Jan 2026 12:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gp1aQ82J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BBB83B5E; Mon, 26 Jan 2026 12:43:30 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C20F83A5A
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 12:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxwoti5B3AmjX8c/Wz78xbztNZsvjpjsXE/GLojEZ7B32PIfBuobvj+eBRZxTa43U1dYwDxGwmnmUiDZIy9llBogrBwtfqaEmrXcDvsNQFrGmYOUvHMjrzuW6L+UnFXF2DP0DY0S7DzI+1lOofDZ00LSXPG8tNLXDnN8BTvdHR0mNdYdi2ZWbmSMJqhvaOpL42ckhy1B2Iij+mRcBAJfNpSsWKoLQNgqh0Fd1YcJYn3J+mi6KoE94VfNyvnfOIHdCK4yfiWnTfcx1TtwYhh4T1CiKZacxhMweLqe/SLsnfqL/HUG+j04OkWt/U6YZgch6RRVgY7CmgKO0DHM2qNlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR6rFMD6DiG/O0TFhcCzVR7CMAJr71EErlCfTEEIZoY=;
 b=dvB3uRsVGShcpE3+j9AFGYjD3eLYHShGrXgCUNB2QKVmWUmD5yIHnuKizFfhVXY0RISIlWZzAqGaEf1nMm8qQZfVEpAYdXR/zIM/RUlB9McRt2CXgfDa8sbuoCmf3BkrFtw3mXtJFOV2QmRi1C7tB2FLAp/a1MGsF6YePZTU1KufYvnHDw3P2GvwozQXFM0YKdHfUFtBmC0C8N64zdMWMRIhl3JGSGmB+FYKURX4KzJ0t1W9wXkWdvkc6oaNxVOPeTSOn6dDTb6kj/y7ymKD5o+Z/J8/WNpXawLypoAPS8b/2N/YSYidLywXpxnlgYHld6G8y0xquR6sfnQZK/o7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR6rFMD6DiG/O0TFhcCzVR7CMAJr71EErlCfTEEIZoY=;
 b=gp1aQ82JzIvxeAtI9WFv6V0fg6f6I5Is34pTKYLiD02SzoTWR+ugjRi28GVUzh9W1MuTAVswBbSrE7oOWPmD/O3A4O8HJdkhl7ls1tcgjC6tmpXcj+mN5ywhnbr2l+0RGKCqiuoUq95qJFMNHHMku5QEKU0bipvvrvgMShEtkPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB11335.eurprd04.prod.outlook.com (2603:10a6:102:4f6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 11:43:26 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 11:43:26 +0000
Message-ID: <74ead874-927c-4ece-aafa-808cd054ef3a@cherry.de>
Date: Mon, 26 Jan 2026 12:42:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
To: Simon Glass <simon.glass@canonical.com>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de,
 trini@konsulko.com, Simon Glass <sjg@chromium.org>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de> <aXDJ4PrbO2eL63B-@mt.com>
 <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
 <CAL6eLbp5DjRMenAkYMH6zU=4NOakhk_7W+aYDeB8MjLtGXgsfg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAL6eLbp5DjRMenAkYMH6zU=4NOakhk_7W+aYDeB8MjLtGXgsfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB11335:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5cc964-de8e-4a6a-379f-08de5cd01e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWdKN1FuRUVaSEs1NmZ0NjlhSmF3SWpUcnN3dmtmVithTGZERnFQTWRFVzZh?=
 =?utf-8?B?OUMzeDRNR0tNYTdyeE95Q1FNZHdTOERldXlmZlkvMTdEWk1vTnh4U3J1bWM2?=
 =?utf-8?B?a0thM1R3RUg0Vk5SRHN6Q015eHFEcWRyU2pBSDB4ZDNZTVRBMjZuNjk1UVdT?=
 =?utf-8?B?Mmd3QVQxOS9KbVpTOWtJd2g1ZklUK3JQbTBZUG0rS2ozLzhSOXFnYm1rL2dO?=
 =?utf-8?B?YWh1RndtSWlCejM1V2FrUXBBU2llT3dTM2xPUkRjR3dtWThZZ0w3OXdONTRS?=
 =?utf-8?B?YjUzUGRBZWtUSGNERlFyZDNnb2xweGpPMlJ6NXQ0QkJQSFVoQ3VSc1FyWitk?=
 =?utf-8?B?MGQrQmJqM0ZLazV0Y25qSTJnQVI1YnpQc2ZVQ2tIeGxlRC9oTWZwanpuOEx4?=
 =?utf-8?B?YnN4VzlpY2hPSkx1N216S2hpSVkzaHpjVHJ3aE4zUk96emtTWTlsc3pmbWNk?=
 =?utf-8?B?K1Z6MDVWUTE2Nm90c2ZrVTBWS0JSMDlrZTdPd0oyMWFGekdrdUI2Ti9lZjFi?=
 =?utf-8?B?VDdyWnFtZ2M4K0JGSmtJSW5RalVMOUpHR3lFaVkxY29JY1RDTnlmclVBR05T?=
 =?utf-8?B?aFA0ZEdkczhBRXZsdTJKUEVmQ29oNDN3WEhwK3NwMWNrd1I3T0JPa0Jtenlt?=
 =?utf-8?B?U2c0SVNVR2lpSkJqTW1JOWRON1RQNGNMMW16UkorSG9hSnVoekZ4RzE5WHNG?=
 =?utf-8?B?LzBOQmpNWTNQc3Vic0t1OUlvcm9obVptNWV2aVlwazhJNENLNWFYZzNXQ3V6?=
 =?utf-8?B?T2JxS3V6bExmRzFlS1N5VERNODNUSExoWk5YNUU3RXN1eGRHUE1RQ2lKVS91?=
 =?utf-8?B?SmU2YWlQS3ZHWWlMR3psSUhJQlQvKzZGOTJoUEQ0eEpnY2QrbDd6eXo2VTNs?=
 =?utf-8?B?M0pidnZ3eUxsdXFXanZ3akpCaFNIdXJLbkxicEx1S3N2a3JVZ2RETzhvV0lS?=
 =?utf-8?B?VGdIZkpWbnB6Y3A0Q1dLVDVQQzMyZHZySW5GQXZidkhRamZqY2NZTjF4UzAy?=
 =?utf-8?B?cFB2NDc1UzFtMHFZUlZoMERtMXNQNnJIaE12NlEwblBrU0lsTkpqVGc3QnVQ?=
 =?utf-8?B?bTNHb0N0YzV2enJyYUhaa1pwaWk4b2pyd0RrMEdxRlo2S0Zoem83ZmJUOG42?=
 =?utf-8?B?NitnRldpNngyTCtPclY2SmdTVGErNG04QmUwNTVFUTR2eTlwYjVTWmJzamVq?=
 =?utf-8?B?UkkzNUNaKzVTTWliU2tBVDJxYmhZNS9NM3BzZjRnbS8xK1Vvd1Q0VG9BcHVZ?=
 =?utf-8?B?azVISk1YaVpxS0lZbnZrQXEvM2p3RlZET00rOGtxTVd0RHBPTXA3aDJxVlhj?=
 =?utf-8?B?QkQyVlBnOG9XZzUxVTJ5QW1tODMraWp0cDA4YjZsRnMyWkt3ZVhUR0gzUkdp?=
 =?utf-8?B?WHlRMFVwcnBtN2tZTHFzQ3hzdFowMUVwdGF1N0FQTDRWYXZGVGRPZHNQbnpq?=
 =?utf-8?B?L3B6aXRLSEdtMVhOcGh5Qld4Y1ZKTzlRb2NmRVpOK1F4d2c3REg1bW9MZVY3?=
 =?utf-8?B?WnZPM1IwczllT01qQVlSM2tCeDhsQXRBTm9qeEl6WlpQOFFyN3I5K3RGVkpY?=
 =?utf-8?B?UER0OG95VzNJQ3NWR082UVR4TlJiQnRoQzM3ME9pRWd5ODRCWFlVKzBuUitj?=
 =?utf-8?B?dDFRQmlqazd6dHZwTTF5bWgrK3ZCek5Tdjh4VGtyOW1XTnVaV245a2wvcVZL?=
 =?utf-8?B?bUZvVFBjUVB4OXBOZEpTMkJzZzNaWUNCYnJjR2ZOWS8xaUZSWGxIczJmVlB4?=
 =?utf-8?B?VU1id25jREpPYi9MT3hSblNXRWRCcGR4dmNLWmM4VTUrclY5VlNybDRaUita?=
 =?utf-8?B?YWNobmE4T3JMNXVsbGlyUlllM2FPdndlNFRQS2x5NTJIYXpKQzl4RWhkcnc5?=
 =?utf-8?B?YzdrM2J1T0xnQjJydVNYR0RoYzgrenp4dEhtK2N4OGV2VkNWTDNPazdWdjZQ?=
 =?utf-8?B?RVV2amoxZWlSM1ZhQzcrOTc5LzVuKzRzNEUvb3hHR1czV3QvN2UreG95Y3hl?=
 =?utf-8?B?UTlaTy8wMXJsc1pkVTdmaTJTV2dNM09lVlorTFBibURwRkY2SjlNeWppNkFl?=
 =?utf-8?B?cG81cmFHR2tiR3dIYUJyM2s1ZVhlMWxXek1WWnY0cFh6bW5DYjRXY05tUHFs?=
 =?utf-8?Q?o6XQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmxyUTE0d0pPdWNwbCtxZzBvMlBTWmpzNDZlcmlUWU5UVmNObzQwaUplSVUv?=
 =?utf-8?B?NDZCY2RFWDY2TkVqcFhKVzJXOTJMc1MrT0hPTngvSEw0NmZpU09UcTZ3ZXpX?=
 =?utf-8?B?SmtUbmpna3poWkhFUEhsckRRSjNic3JRNXNvZnNJR0pHVk4vK0hVYkhDV0Vw?=
 =?utf-8?B?YXNLd3RxWlAzUDdDcmlmUDJTYVZJTmx5RXdyMWsxVk8rdVlKank2RldOcXBB?=
 =?utf-8?B?SjA3aDNGL3JndVBXd0R4MXFRYVZxMGR6SnViaG9ESlhCaU1rb3VJbUcvb0FE?=
 =?utf-8?B?c2VKbXJqcGUrWldnVTl0bmtaVU5INmVtbFFOejYzZnJmV3R0OFpIWnNWQ1RW?=
 =?utf-8?B?em5WNm4wZUVmZEJnd0ZhMmdFb0VmMmRadnhTUWNEY0R6YmJHemM0ZW9CRGRX?=
 =?utf-8?B?UEdoREQzVldNVmdGVE1icnRneWh6M0l1WGhSYzJRNlROaGF5eHFJbHh1cWtr?=
 =?utf-8?B?MzBiV2hOMmlEak1OUlYzQjJvakIwN0hIVWVpdHlrYTM3bGIvYWFFNVhVSW5Z?=
 =?utf-8?B?QzRNV3dBTTMyTlVuWUtIS1pkWWFucTE3TGJJTjc4RkdkejRFdnN5YytqS015?=
 =?utf-8?B?a3hZY3gyTHEwaytRc2ZRS0pKdUtMNnJMa1Nqb0FRTFM0MERscngvc1VNNFp0?=
 =?utf-8?B?REJDa09UWFlDTGtFZjZ4ZlIxMCtpd2tOZEtTM0tqOGdhU0xYRzlwS3BuNTdj?=
 =?utf-8?B?cXJHZCtiVlpUQ3Z1anpFdDZ0SGJxcmg0emtWeVNGNytUTUFUZGFYNGd6bXYy?=
 =?utf-8?B?LzBKWW5lNEFJdzRLemhxTDgyRlJoMThsUnkxM2J4OEFTYUs4d0kwN1BlMmF2?=
 =?utf-8?B?NkxPUjBSbzlMVlo0R09LQVVnaFZMTzFTN054QitEbklMeVEvSjVpZ3Y2cjJx?=
 =?utf-8?B?NUM4TGorS0FwU3FXa2RER0NLcmgxUFZtdWgyY29iYXc3UnBYYzZ0QW05d2Ji?=
 =?utf-8?B?Uk1PcjJ4NXdjOUxXVUZyT2F4bHFIYnBzcW5ZU2QyVUVDY1NQODJhdHVhdnd0?=
 =?utf-8?B?SUpNWStqTndYN3pvTmFsTjZSa1FmTExXdkY5YXh2TXptRFZwNllrUnpleFJT?=
 =?utf-8?B?MDZtaFFzR3hITVErVk9UM2J1NHFRUkcvMldaYXBOOUlLdnRpUHBabHErbWxM?=
 =?utf-8?B?Q04xMHhpTjY4Rmt0SG40WXFsdmUvcDV5UnNXajE0SHByb0N3L1cycm5lMkZH?=
 =?utf-8?B?aGFqdHo4T0x3b1RVSjMrUHdJL3NlTHZEM1l2OGliMERoMUhTcGlKTkJKUkZw?=
 =?utf-8?B?V243MldJbUxmclFDY05Mb1BVSUJaK0lEc2JYd0pOSFp2MFpLNVBtMW5LZnpr?=
 =?utf-8?B?SFdvT2NITmZveEViU1pPUmZKUXBSZStaa1I0ejRNUWlCTXFLSi8ya09XQnMr?=
 =?utf-8?B?ZFNPblV3N3NTNXNibEFKQ3E1UlZnZ0V5UWlzM05uSkQvaDZnRWl4TDcvaFRk?=
 =?utf-8?B?dHJhU0FtbjFheCtCSTgrUGFGT0FSRW83Y0RRUG1idkFlekpmSThzT09XSVJn?=
 =?utf-8?B?MFhkMDBrVmRXTS9jMEczQ0Z0QXRRbUdTTDhZWW84MjYwekh2S3pueU45R3pm?=
 =?utf-8?B?MDhKYkZPa01vWmptUFNOOTZ5NVpGUG0yMmpmREk3YVh4NllWWi9BZ09jeFJ4?=
 =?utf-8?B?NHNldFk0NTJPVi9yTVcvTzR2U0pTanRUZGlTczJRdUY2dFlsMW90SlQ0WUM3?=
 =?utf-8?B?dzQ5aXVzN2ZtWWJPMG8zdUp0WXdvR3ZGZG9VN1pKeFZoVUlpNmVzYzRmUnEv?=
 =?utf-8?B?SFIyZXV3UVpkbXpRQnJYR3E1NnhhSzRjTG1iSlpFZ0RSRnB2dTdJSmZNdEU4?=
 =?utf-8?B?VmNBVGJMYlpTelJCRHRCQ0prNXd3dVhGT2ZOa292QUo5ZFRkLzdMdG1tblFZ?=
 =?utf-8?B?ZzhoL3VNMGhrakd2NWI2dElWcllMajhoYzJCMzJUdjI0aXM5MG5OM1NoVk5k?=
 =?utf-8?B?aWZhR2FqNHZJQzgxWmJUUU1YWVRhUTNZK0xnT1dQTml4NDQxTjFSRW5kbHdG?=
 =?utf-8?B?YitpWmVFRzdNSFhkOWI2bTY2M25rNVowa09nN0JLYkVXSDVXUWo4bUpPdWtj?=
 =?utf-8?B?ZEd1SlQ2K1YrSTBQcmdRaUsxbklkaStWN1NOZGdtUzB3UkpKQytnc3pJaGds?=
 =?utf-8?B?VHpiMWRlNkI4cHY4cGhsUW0wV09JK1M5a0pJVFBQRVhXNEUyT2RtZ2FLYWE3?=
 =?utf-8?B?QzFObVdoVUd1K0JZMzN0S0tITkdTSVFrbGFvYWFwTVIwS05FaVJ0emloMUdo?=
 =?utf-8?B?S28xcFdrZ21HUE9EemhPbnRCQXN5OWltMGNjRllYdU1HejhPODBGa3hBUlhi?=
 =?utf-8?B?MWZrczlObmJEZHV2blR2QUx5TW8rMmQ0NXlMR2RqTVJSTkVTZUhRSjRXaU5Q?=
 =?utf-8?Q?M5pcuuDz/YMBccG9uF401lGE5ONsxhmuhSMth?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5cc964-de8e-4a6a-379f-08de5cd01e45
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:43:26.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NHriJJktcM9wNXcSKBFMIbLcbHWn9NXlg7LLg9VuSFbARyXBWAPSrkx6XaG9PAalOwDP7jUicyAwo3uQlvlLlNf9g5NZBs7D0oQnI32alY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11335
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

Hi Simon,

On 1/22/26 11:46 PM, Simon Glass wrote:
> Hi,
> 
> On Thu, 22 Jan 2026 at 02:06, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Wojciech,
>>
>> On 1/21/26 1:43 PM, Wojciech Dubowik wrote:
>>> On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
>>> Hello Quentin,
>>>> Hi Wojciech,
>>>>
>>>> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
>> [...]
>>>>> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
>>>>
>>>> This is wrong, you'll be messing up with the environment of all tests being
>>>> run in the same thread. You must use the "with
>>>> unittest.mock.patch.dict('os.environ'," implementation I used in
>>>> testFitSignPKCS11Simple.
>>>
>>> Well, I have done so in my V2 but has been commented as wrong by the
>>> first reviewer. I will restore it back.
>>>
>>
>> Indeed, I see Simon asked you to do this in v2 and I missed it. It isn't
>> how we should be doing it.
>>
>> This is likely fine on its own because there's only one test that is now
>> modifying os.environ's SOFTHSM2_CONF but this will be a problem next
>> time a test wants to modify it. I actually hit this issue when
>> developing the PKCS11 fit signing tests as I had two tests modifying the
>> environment.
>>
>> The only trace of it left is the changelog in
>> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/
>>
>> """
>> - fixed issues due to modification of the environment in tests failing
>>     other tests, by using unittest.mock.patch.dict() on os.environ as
>>     suggested by the unittest.mock doc,
>> """
>>
>> and you can check the diff between the v2 and v3 to check I used to
>> modify the env directly but now mock it instead.
>>
>> Sorry for not catching this, should have answered to Simon in the v2.
> 
> In practice we try to set values for various which are important, so
> future tests should explicitly delete the var if needed. But I am OK

This is not working. See this very simple example (too lazy to use 
threading.Lock so synchronization done via time.sleep instead):

"""
#!/usr/bin/env python3

import os
import time
import threading


def thread_func(n):
     if n == 1:
         time.sleep(1)
     print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
     if n == 1:
         time.sleep(1)
     print(f'Thread {n} set environ var FOO to foo{n}')
     os.environ['FOO'] = f'foo{n}'
     if n == 0:
         time.sleep(5)
     print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
     if n == 0:
         print(f'Thread {n} removes environ var FOO')
         del os.environ["FOO"]
     else:
         time.sleep(10)
         print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')


threads = []

os.environ["FOO"] = "foo"

for i in range(0, 2):
     t = threading.Thread(target=thread_func, args=(i,))
     threads.append(t)

for t in threads:
     t.start()

for t in threads:
     t.join()

"""

This results in:

"""
Thread 0 read environ var FOO=foo
Thread 0 set environ var FOO to foo0
Thread 1 read environ var FOO=foo0
Thread 1 set environ var FOO to foo1
Thread 1 read environ var FOO=foo1
Thread 0 read environ var FOO=foo1
Thread 0 removes environ var FOO
Thread 1 read environ var FOO=None
"""

You see that modification made to os.environ in a different thread 
impacts the other threads. A test should definitely NOT modify anything 
for another test, especially not when it's already running.

So now, I implemented mocking instead (like in my tests for PKCS11 in 
tools/binman/ftest.py) because I know it works.

See:

"""
#!/usr/bin/env python3

import os
import time
import threading
import unittest.mock


def thread_func(n):
     if n == 1:
         time.sleep(1)
     print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
     if n == 1:
         time.sleep(1)
     with unittest.mock.patch.dict('os.environ',
                                   {'FOO': f'foo{n}'}):
         print(f'Thread {n} set environ var FOO to foo{n}')
         if n == 0:
             time.sleep(5)
         print(f'Thread {n} read mocked environ var 
FOO={os.environ.get("FOO")}')
         if n == 1:
             time.sleep(6)
     print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')


threads = []

for i in range(0, 2):
     t = threading.Thread(target=thread_func, args=(i,))
     threads.append(t)

for t in threads:
     t.start()

for t in threads:
     t.join()
"""

Lo and behold, it.... does NOT work???????

I get:

"""
Thread 0 read environ var FOO=None
Thread 0 set environ var FOO to foo0
Thread 1 read environ var FOO=foo0
Thread 1 set environ var FOO to foo1
Thread 1 read mocked environ var FOO=foo1
Thread 0 read mocked environ var FOO=foo1
Thread 0 read environ var FOO=None
Thread 1 read environ var FOO=foo0
"""

I've read that os.environ isn't thread-safe, due to setenv() in glibc 
not being thread-safe: 
https://sourceware.org/glibc/manual/latest/html_node/Environment-Access.html#Environment-Access-1

"""
Modifications of environment variables are not allowed in multi-threaded 
programs.
"""

I'm not sure if this applies to any other Python implementation than 
CPython? But that is likely the one that most people are using.

So... In short, I'm at a loss, no clue how to fix this (if it is even 
fixable). The obvious answer is "spawn multiple processes instead of 
multiple threads" but I can guarantee you, you don't want to be going 
this route as multiprocessing is a lot of headaches in Python. We could 
have the Python thread spawn a subprocess which has a different 
environment if we wanted to (via the `env` command for example), but 
that means not using binman Python API, rather its CLI. We could have 
bintools accept an environment dict that needs to be passed via the 
`env` command or the `env` kwargs of subprocess.Popen().

Headaches, headaches.

Quentin
