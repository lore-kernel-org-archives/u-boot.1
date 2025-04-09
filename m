Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A590DC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE50838A7;
	Wed,  9 Apr 2025 19:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Eiy6Y0Ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07AB5838EC; Wed,  9 Apr 2025 19:02:43 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C7D829F9
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9w4VublISpfJG8T1k9IVP0t3XnnGYZk9ldCu/xZdWAVX2e7adwK4dp5E5k76l4Gp90li1BwGRWEV+O52aov7WrRJtjthPSE4byxU4e6ryipVFr8bcqqQLz5qidwwE9RsFKmSeF8mChYZTgHtcuQbv1c5f4YxVuPQt9ww4snNuTKiqbnt0eeR4MmnPUgRVmB/cBNM6c+yAi0eDlsgUjAc3JdzCR2EojlCXrwawYmwxuJxd9qgP405z3jLpp5i1LSJSy2DPKs6i55uEDG3CJeVOzoSVICCKzA7WPBZPtvOox0oi4TRACGxWHuMZQqNiAc31UtYE9p6sO6hWbP+xYZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyzTcNIj+pOk6z+Px0d2+q/zvgehIAJ9FtBEShxtLlo=;
 b=nYNV3wWHeDRbMnVkefTy4fckfX79GJO4yuSPe7CRTYVm8QeCwYMD02MWPwHB16x8Y4iiJ1zVjQP9bBSJJ1dcp3bvgtDltH7qCGv7PZK6rdITMDFNRPq8chK8l9MMljFa3l9eJSKreo3fdLxfKE0uaB7WJR1rFnGGLW0sLExi59ipS2AatzeHxluB9+Cue/n7oTwZEIdrWRTJOlfnRaHNe0ku2Oe5vWykK8VDIbi5JbhofPrIpieonQsuHBkzPamqUU8xC97X4xT7L8g8mM7Is6S3qhO/lDi0kGBzRgbmM9EirJRQrwjXqPl1NghltVhEsMrf33ZJcxNTRbAmEiy4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyzTcNIj+pOk6z+Px0d2+q/zvgehIAJ9FtBEShxtLlo=;
 b=Eiy6Y0OuBWrTBpEEMlu1ZHyWHm087FNCVmfv0ih3l1dwf6GMvz3XYxpIdsi4v1dV2V7te1Il+59Nm+Naf9ahLag02WQSQOBZURFwf6QctWpB4tfhMVPY+cWQHiYf+GigtasT8jYpftt0gx7a74ZngZ9vzgtculMoqrslynimjt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 17:02:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 17:02:38 +0000
Message-ID: <2e74ea86-31c8-4ac6-9fa7-07fc622628ae@cherry.de>
Date: Wed, 9 Apr 2025 19:02:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] rockchip: binman: Support use of crc32 for
 SPL_FIT_SIGNATURE
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-10-jonas@kwiboo.se>
 <5d3c9e7f-336b-4b67-a7f4-a25a61b0908e@cherry.de>
 <ac68b883-021c-43ac-b834-bafa54e7182b@kwiboo.se>
 <887d7a5c-0ba7-4e62-bee2-8e5c159710c8@cherry.de>
 <CAFLszThQQdU2v0TjkmdhFNC8mNKNmOWhZyZS6VtwYG_z6fFypw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThQQdU2v0TjkmdhFNC8mNKNmOWhZyZS6VtwYG_z6fFypw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5e0cf3-d39b-4bde-94bc-08dd778854db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTBpazVOZksyWWFGSlhVTVVkVFpPY0RrS2cxT1cwakd5dkl6WVRseVhVZ3ZR?=
 =?utf-8?B?M29MaWw4MUl0T0lEYlFuMStXRlhaTGwwNGlxSHRQdlpuR2dEMHJQMW1iTFht?=
 =?utf-8?B?T0Ftb3hTWS9LY2NjaGF5MWF1UFl0OExaZ08xanQwdGF4U0RIN2x6TEp3bnly?=
 =?utf-8?B?NHJtdFh0VGZKUDIxM0V2UWVqRExJandFM0dINVdGdlV5aDRTZFhYaFcxcFht?=
 =?utf-8?B?MkxWcFIyc0NVT0djL25CVzEwUVAvUzZRK1ZBbWJnbEhlaVZ1SjBFS3hTOGF4?=
 =?utf-8?B?Z1Roa3ZaQnA4SlEyalBIemJTRWZRdHJGMTFTNmxzbUxLbGkrWElYR2NCNGJ4?=
 =?utf-8?B?emxXS0JBcDlSL1k2cnlGUFZsTkp5NDMwcDdWeTRLRXNTVHlOMm1pT0N2ejZz?=
 =?utf-8?B?U3V1OFJEV1dmNE8xY1ZjZUdpVkJDTWJsVGo0TVJ2ZlRRMXBqYnRtc2szK3pP?=
 =?utf-8?B?K2FKMWJleHNEWG80eTFaMlhxZ3ZvOWdCelA1azExSkFrbzFYamRHTDFFMnZy?=
 =?utf-8?B?cnMwYnhHMEgxL1l0ek9zZkNQSXgyeGtNeExDL3dpdUtoRDVTRmR6Q2crYzk1?=
 =?utf-8?B?OURrVXQydlVSUTJtVy9UUzdyWFY0Mlg5OVFnNEZTUW9PV1ZaeTY2TUJJVVlH?=
 =?utf-8?B?Z0c2RGlGSFB2cjl0bDIwSDRlQmpFVUw1NDdIeDN6U3R1N0tqOWVQdld4c1RO?=
 =?utf-8?B?UmRKRWJKUWgxeW9ucHhWRWVQaFZCMkNOZkx6VkpkNnJ1Z200Zk9valJna2hw?=
 =?utf-8?B?NHJCUXV3cEtZTzJMSkxTQjBBSlYxeTNKR2R6ZHlBdjdQSnVsNlZ1M3RjTEM5?=
 =?utf-8?B?N1NOanpPTytqT3NVdEZsa0ZOMnEvbHBNY2NoY2wyeTRTT3plWGVEdWJ0cWN3?=
 =?utf-8?B?akRRZzk4MGNSZURxRW1pcEtCK29ZeU5UempDNm45Z3VhYmlNdWhVdFhqbWEr?=
 =?utf-8?B?M1pHY1JsUTNzcWM5Q1lzKzNBTnIrR3BVSlgzV01mTS84WHdpYkp1M0wzU0VP?=
 =?utf-8?B?Z21DcE5mQW9Ba1RrL2NZcFpiSHhXVmtRNFlFUzkzU0F1bm1EZWJJNC9NUytw?=
 =?utf-8?B?NGE2Y05VaFNaVGNadHd5Y0gzNnpKV1JVOXRiMlQ1Uk5kN3dVVk5PWTVxK3h0?=
 =?utf-8?B?WHpIYksvRFlnS21EODVBcmhYcE1jK3hUNnRaZm9tMFNVWnQxd211S0hLREdP?=
 =?utf-8?B?Z24rUmNBS0FrZlByNHNjSkdMZWNxcnlZV04zTUswOHNlY1pvbVhVMURTS1VB?=
 =?utf-8?B?MEVLKzZSeFZoc2U2UFM1eGlrVXBNcFJZTjIvUEpLWktFUnBuZ0JPU2VSSFFi?=
 =?utf-8?B?b3VtdXFzb2FhdU13T2I3QXpHdlF1dHZLWE9MVFdwVFpQbzA5azVjQ0FsWmhZ?=
 =?utf-8?B?RlhDdFB3NU53SllLYit3Ty9VZUF6ZU1tY0dySFhDNmswYkFKdFJ2Q2Fwa2NH?=
 =?utf-8?B?TExoNFVzQ0czUmd6NEs2ZWVwNzA5YzYwb0pjVDgxRUk0Z3lDWjNSd3hZSVV3?=
 =?utf-8?B?QmNHNGtJR1VkWGt6VzhCSHZUbmY4ckhETHRnbXBVVUVRZzFZOHo2YzFSQVFz?=
 =?utf-8?B?ZlZ6L0hrTjZNZFR3TlczVkxQdGo0UFh5Y0FsUG5BbzVOaldGUUZvbFVrdWty?=
 =?utf-8?B?WGY5a2tHME1SRzRBNXJiOTBMYmFYYlJzcWNGNFdsQ3RvaVRGMU95dXhoK3Qw?=
 =?utf-8?B?U3BLVWV6U0wrSC9sM3pRbDZyWXIyWGJkZTA5UGlxWkprUkw1c2hLNU5JNlU3?=
 =?utf-8?B?TWxtWWlZaUs3Vk8zaXAvYjhKRThlRWJpNTN5bUt3c2VBejgyZTBiZzdVYjdl?=
 =?utf-8?B?SXczeFJLOUEwdXVrdEtaUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVMzeFRtaXA4Y0RWc3BLT1FOTm1ZeU1WcmdHaTEwODhHdGhReVdZSlVCRjhX?=
 =?utf-8?B?eUdqbWVVZG9VT3Z3aVNpYnkxWmh2Zm5lUjJiZjFtbXFlZlNRSDF2S1JLdW9M?=
 =?utf-8?B?alBhVmg5V2dDNTloOXZEOVRKR0pDVkhoa2F0NkNOK2dOVUltem5JbUhhSEJE?=
 =?utf-8?B?Rk51cHAxNVcvblRXT2tuU251SUFtVTQvN2dka25QQ2ZaUU91bURxYzdXMWdz?=
 =?utf-8?B?a3hYVk9mYlp2K3BUWTVINDhyWUNMZFc2b1hLZG90WjJLRDhIbitRNWZYVFgy?=
 =?utf-8?B?RWNxaU9Oa0hiczIzZEJjMVpxOGNIUEtBbmEvRDA2enZVUUlLdktrKzZyOVpo?=
 =?utf-8?B?SWJ5QUF6WVlWOTdWY2F2MW50cFlzL2RtNHA5QWxjbjVyZkdLZEhiR2lUZ3ln?=
 =?utf-8?B?aTROdkM3bHpzbW5nRi84V0RDT3pueng4ejRzY0MrRlVuaW5wL3dGSnZob2Nt?=
 =?utf-8?B?VUNYTmhSSnBFaVNrMXg0OVIyZGc1V0VHaVNja0FZUXl6L1ZuVkZIdmdITGR6?=
 =?utf-8?B?dUxSVXR2RHVjcU41WjlZY2hmTjF4MFY5bS83dzhTMk44TDM3NHNoWkFXajJy?=
 =?utf-8?B?L3VCZ1MwaitNdmZsc3ZaL1AyOEpjc0pUVS9DZHgzaDFaTVZlZUViUi90YVNy?=
 =?utf-8?B?SjJxc2JZNDVaWFJuNXlwbDZKTCtDeXoxYXp6NDBoUCtCa0V0c0VQTnpjcXRx?=
 =?utf-8?B?dzIybUI4WlZtVmdxOCtFcEU3WGRFc0RBNm9LLys1Mi8vSFg3Yk5PaGtRcXRq?=
 =?utf-8?B?T0tQSTNVS0RmRDFrdnFZTWl4SFQ3SU1hb2dkNm5pc3FQLy9iVXJWYkhmbno0?=
 =?utf-8?B?ajBMZzBLTElENUNGOFpSMjRnWUhYSmp5aHZqb3ZoSG5oNWNFU0dKNXJHVyty?=
 =?utf-8?B?MzIrWTdvb1pSRlVLYVN6bXY0eHl5TU5hSTViUFhjcmhOK0pHSUp2NCtzdkxr?=
 =?utf-8?B?RlJUaVpZVTBML1YzUy9mVE1zNkdzZ0dkUEV1aTRieUxKUGZWTzEwVnMwTiti?=
 =?utf-8?B?WjUzQkVybTRVZVk4RmREVk4wbFlVUDR6eWRJa0o5WWc2b2pDNWdEK2diV3px?=
 =?utf-8?B?dndocXlvOWlMcVdKL0s0SWVtODZBOERueE4yV2NLK25xcU15dlo2SklUbGNi?=
 =?utf-8?B?d3Y1MzdrYmdqS0pNWXdaeHpyQnJmSDR2SzM5SXZXVU1wUFFBd3orU0R2aEts?=
 =?utf-8?B?UmU4RlhIZ0pOZUFjSUkvemRZKzlkMXhHaDVJUjhkZWNCWnRvSWZvQ09jcE1X?=
 =?utf-8?B?OXpVS1d0VjF3dzZNTmVpbnlMSTV3OW1YbGlra3pmK2tNNWJmeDlBM0NrK0Ix?=
 =?utf-8?B?WG1KbHc5dlJJTlNaOFlKNnFPdm9oNzJIYVZNV0MyKzZZdkhzV1hOQmROc3BE?=
 =?utf-8?B?TDdjZDJ4ZnZxSHlIdFM5Si84NldvdE9vaFAydVhrMXgrb3pmek1HcGlRNmN6?=
 =?utf-8?B?aUlUWk05TTJOaEVMandaSnlFRjNqaDVwNDFsYVRMRHF2N29sdnhuclZreVZr?=
 =?utf-8?B?K1BJaUNmZHExUW41M0s3TTBYT2lMYy9jS0JsZGJiMnUxZDcrcnBSYmhrOHVu?=
 =?utf-8?B?MDMrcUIzczhPUjU0cWwySVFVUGlnMXlNREFWc2tXTEpPR2lncVFHL1Z3WDZY?=
 =?utf-8?B?WWw3bTlvT0o2VDV3N0Y4d2FleGNIdHV2ZnVQUlAxVnpBYmVzbkQ5S1h4YlRv?=
 =?utf-8?B?WGxvRkxOYWpzcUFPeGdMZHA1RmdreG9MYkRwbU51NEd1VkFWOTBmZ3hrQXd1?=
 =?utf-8?B?N2dQK1AyY0ZLZm8va0lxU1lNMUpmV1NsUExXTk1FR2RwaFNZQXNwU2xzVGg5?=
 =?utf-8?B?NzdSSlY3YTR2TXJPTkFpZmRRSlA1NnNKWU9KeC9ac1JkenkyTm9DNzZkSGFW?=
 =?utf-8?B?WFNxN29DNFd6ck1KclQ5akNpcFBNd1ZtNVRHc2xCdGdyVFJ6V2tDbDRSV3RX?=
 =?utf-8?B?NVJtUEl1VWM0a3hlaFR0MGFZZC9RVE1taGQrdlJBMkVFaUhaRDNPL3NRSjNs?=
 =?utf-8?B?SzhyY2oyQXFVbjlZUmFtWTBRT2E2bk81T3pZcUZYUEFvOVRzTi9ET1g4TXJi?=
 =?utf-8?B?NzBJaTYyRVR1clAzczRPMnJaOTAxRTBqTFMwMy9xbVRnWTVjNGxaNW03cjFi?=
 =?utf-8?B?dXVveVlMWTJGQ2lFeGQvMkNHOVQzK1RSZ3N0RDh2dFdtTWp6a3BEeS9aUyts?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5e0cf3-d39b-4bde-94bc-08dd778854db
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 17:02:38.1376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: najCeh27zjRa6s7/P+slQgyhftd7MQLUWT/IZnjxLA49HyX2xcqTMYsQYtPryBqvAqoWTeLENKPdjXHvbrg2Bb2Jro6vz7jq5zX+NBF4PGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
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

On 4/9/25 6:35 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 9 Apr 2025 at 10:11, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Jonas,
>>
>> On 4/9/25 5:38 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 2025-04-09 13:06, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>>>> Use of SHA256 checksum validation on ARMv7 SoCs can be very time
>>>>> consuming compared to ARMv8 SoCs with Crypto Extensions.
>>>>>
>>>>> Add support for use of the crc32 hash algo when SHA256 is not supported.
>>>>> Also use a HAS_HASH to simplify the ifdefs when no known hash algo is
>>>>> compiled.
>>>>>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>
>>>> I don't know enough about general security but this very much looks like
>>>> a bad idea to me.
>>>>
>>>> https://web.archive.org/web/20170210173741/http://www.derkeiler.com/Newsgroups/sci.crypt/2003-07/1451.html
>>>>
>>>> """
>>>> While properly designed CRC's are good at detecting random errors in
>>>> the data (due to e.g. line noise), the CRC is useless as a secure
>>>> indicator of intentional manipulation of the data. And this is
>>>> because it's not hard at all to modify the data to produce any CRC
>>>> you desire (e.g. the same CRC as the original data, to try to
>>>> disguise your data manipulation).
>>>> """
>>>>
>>>> (yes I took the "first" link my web search engine returned me, thanks
>>>> confirmation bias!).
>>>
>>> I am fully aware, and the fallback to use crc32, and current primarily
>>> use of sha256, should not be considered a security feature. It is
>>> intended purely for a checksum validation of the binary blob after it
>>> has been loaded into memory and before U-Boot otherwise unconditionally
>>> jumps to and execute the loaded blob of binary code.
>>>
>>>>
>>>> I don't want to give people a false sense of security. If it really
>>>> comes down to it, I'd rather have an explicit Kconfig symbol to set this
>>>> value (maybe have a `choice` even) and be very clear about security
>>>> implications.
>>>
>>> Prior to the addition of the hash { algo=sha256 }, there was no checksum
>>> test and U-Boot SPL would unconditionally jump to the loaded data, even
>>> if it had been corrupted, was only halfway written or otherwise
>>> overwritten.
>>>
>>> The addition of crc32 instead of sha256 is just to allow older board
>>> variants with weaker SoCs to at least have some sort of checksum
>>> validation in use without affecting the boot time too much.
>>>
>>> On my rk3228 board, validation using sha256 could take a few seconds,
>>> and with crc32 it could be measured in ms.
>>>
>>> To me, having at least some default checksum validation is preferred
>>> over none at all.
>>>
>>
>> Except if this confuses people into thinking they have a secure system
>> except they use CRC32 instead of something more appropriate like SHA256.
>>
>> It seems like the "hash" node presence doesn't mean a FIT conf or image
>> node is signed. I also don't see many device trees with a signature
>> node... which is kinda odd. Looking a bit into the signature node in the
>> spec and binman tests, it's not clear to me if the hash node is reused
>> by the signature node if if exists and if their algo should match and
>> what exactly is checked by the signature node (like signing the hash
>> string contained in the hash node(s) listed in sign-images property, or
>> (re-)generating a hash of those and signing it at build time?
>>
>> If
>> a) it is not possible to have a hash node's algo differ from a signature
>> node's algo, then I'm fine with this as crc32 won't be allowed
>> b) the signature node regenerates a hash regardless of the hash in the
>> hash node, meaning the signature will be "appropriately secure"
>> regardless of the algorithm listed in the hash node, then I'm fine with
>> it too,
>> c) it is possible to sign a crc32 hash, don't want it :)
>>
>> @Simon, do you have some hints about this?
> 
> In fit.py :
>                  # The hash subnodes here are for mkimage, not binman.
>                  entry.SetUpdateHash(False)
> 
> so yes they are independent, so far as Binman is concerned.
> 
> But of course, configuration signing relies on hashes in the image
> nodes, so at least one strong hash is needed.
> 

Would/Could/Should those image node hash subnodes be autogenerated 
during signing based on the selected algo? In which case, only the algo 
in the signature subnode would actually matter from security PoV.

Cheers,
Quentin
