Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C916C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 09:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B9B8861A;
	Mon, 12 Aug 2024 11:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KcR2GdEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E1C88680; Mon, 12 Aug 2024 11:05:31 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A04608860B
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9fs9Bpylr5NkHXZGA8X0biyeeOBfimL8ng4xaeVZz8V/ctFUJjmTcpowYGoJlI1oWU9sVn+dh4nO6qmNn/wSLZMYUPRdl1WIeFkay8fsrkxP6P4MixeAhuqS6Uerp0NWzkOjsdkMEmY0NWEtwEgvXF9qkNvso/SUEJjduQXnUIzqcYqwiayNgxnqB9QdG68Z99R5ISt56FsYPZs49JAvWe9cCBxLso8a11Uz9vTDuaw2iMsBn6BSSZ7KetMO+/b/K0r3ZsxqEIFAlh78E+urnc/K3qd2SH1wY0FhXreoxsu9tbdviazt8ULWYHT/emHY5s4u0yk+KsPQh5mSNvUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmhcDWBWmnfD0Fk1tC6/bmKMHGJc37/GiCObgwAs8QU=;
 b=CHAXzBxLK4UNs/5cYwLBRLUR0rlEgEWf2PYrf2nAmErslvuhzLd9nlsDcGJ9wq4dQU1PTR5oA05w0bXZmvDKH5JbuZwiI2ocWURQoXO6jcW6ebhFWBhrSRtpkB9O6BRoSf5hiGWydAf7wFP25a8DhnRmiGrNZ+HQlz71H4VuWuIMlQTBxD9MO2f7zhbMtfjVKNpR6PLRr7y2UWtxh0Fy6E3Ta0P3E9VIEXZJlOIsygjL+E0xlAJ5m1u0LY1dS1Tb7we3xCdgGze6LIjvBLnE2ZLAIVd/alvKtXMCWQEdMCp9qdehOunJ8dW2eKdQMpUrPhROAkQwORRsj3PYQx1LnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmhcDWBWmnfD0Fk1tC6/bmKMHGJc37/GiCObgwAs8QU=;
 b=KcR2GdEiR67kpAYTBVusdhZqozn+u8ePc2fOp16Zrm2cTWgdkhQFJT2co2DC5HIBTsLVUHhNcxFYYdyx24E1lu1ddMapOZWHGfW0FFoLpJKpxQHQrvex3gEWd5//CEER+ah0xzFT2lTG5Gv6ylLA0m+TiPimxPQlkvrTOmws7bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:05:27 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:05:27 +0000
Message-ID: <350b4bdb-4b78-48a1-9c21-b4d968f60500@cherry.de>
Date: Mon, 12 Aug 2024 11:05:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] configs: Resync with savedefconfig
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-2-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240811122924.4035982-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0204.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::25) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: ca41f0cd-09ce-4332-e6db-08dcbaade86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFlQanNTVVBWK29pYnJsSWNLbDlPRGNQTm5QKzZ5ZlhrQjNSS2xnQWEwaEZl?=
 =?utf-8?B?akN6Rlg5WTZYNGNSVTFMTGVyUXA4VUhIcjJVZDh2UG1qc0ZoNnhOV2F1QVdv?=
 =?utf-8?B?NS9qK1MwYzcwUlhkbmhNVTFNVURjaU52eVI1MXlKWlBSQmRtb0F3NHEzYVMw?=
 =?utf-8?B?QjBYZmRma2VBOHo1a0NpandwTm0xZHdrK2cxZno2RXBMbVBBcEZycW52ZjMw?=
 =?utf-8?B?djI3eE9JZ3hlUTRzU3R6NlRjK2VXeWpTVEZtL3pIZml5YjRDUzZoWWladFZ4?=
 =?utf-8?B?L0dQbS9HbTBkeFZtMW5UenNKRit5M3FHOWZET2Y2M0d1VktmNEpobHpXYUl5?=
 =?utf-8?B?QUMwY2h6VDZtTExZY2tCNGh4engvdWFWaGZwSm93eFpoOEdIZHlFV0tYQitZ?=
 =?utf-8?B?c2pDSUdwZy9rYjRHVkNQaVJUZXRyTmVxZ3BuRGkzQkxSV0F4cnJSYXJlbU5W?=
 =?utf-8?B?WWxVSHVIN2hzQVFkMnhzdHVncHZFSUdCWVhJNjZ5ZDhVOEV6T1lKUzNnSTFZ?=
 =?utf-8?B?YUFqQWxTMDBVRFk0NkhyVEhWOHdHUU9KU3M5Y0dPQllRSjZScy9yQndpd3Rh?=
 =?utf-8?B?eGNYMHlGN1phTjVkZDFKbmZOMFl5NzN1YlVjdUtDV2Nqb1JiRUtJZjMwMzFY?=
 =?utf-8?B?MnBJdkEvN1pORHVCVkJOMzRxdS80R3RaSzhEUHJlMHBPbG8xa3ZXYmNQUDNw?=
 =?utf-8?B?K1FjVGhoR29EYW9MSzJkQUdVZ3I3YVBlcUhJTWxoa25DS1NxRXc2Q2pxSTZH?=
 =?utf-8?B?NnAzYmliLzdLaGFyUnUvV2l6UktQM0FhZnNlS0VyejJ5S2JvWW5CT0VpbEFG?=
 =?utf-8?B?SkpVQ3ZpdUJJbFdYcmwzV2lIVzBWS2J4RmlUZWhoNEZNZTZqdkNUSlhqenJw?=
 =?utf-8?B?TkxiM0NPZWs1aWRqNzEwSEJObUsyMTRoMk80b011NkMyUWQvb0I2K1EzZC9U?=
 =?utf-8?B?Q3d3WDAzcjNtdE1iaE1vbDRvUE9SVWtpdUxVUms4STZxbk9DcVhGd2xjdTAy?=
 =?utf-8?B?OTdNTFFodER1TTBzcmxUZzIra2F0SmQ5UmZTZ1BIZ0xSUVZBc1NlcUszVThF?=
 =?utf-8?B?Z0xDNzc1VS84Y3NoalpIeDBNNjlRMmVYQTRPMU0zQTc3Tjk0RXJiL1NiMncx?=
 =?utf-8?B?S3ZtUGd6SDgvZmpmcHI5bWpTemt5S1Mxa0VLSkVRR0pUc0RqcHk2OU1qbHNm?=
 =?utf-8?B?bU80cmdDUXpvV0VWWWp4YUJjdEo1T3BORFNMUUVzaUNYYWppVU9kZHhSSmly?=
 =?utf-8?B?QkRhSHhDaUpiUmg2WjNlZm9wS1A0d29lNDlSbkljSWk0emxHbGNrZDJ1MGNr?=
 =?utf-8?B?a0sxZ1Z5ZEgrejZDU0xMZXB0blhZbkN4UWRFeFMwa2p5U2k3OFBRc3NJM0pD?=
 =?utf-8?B?NzZkbHJhOWwxaTZQZWdwZ2h1blc5a3VIZzlsc242S3FWeEhWdmRWbXhpdzR5?=
 =?utf-8?B?YUhpTEVQNUVGcGRXR2VUcWZPL2NudFB0ZnpnczRLT3hkZHNKbkhKRW9hZGg4?=
 =?utf-8?B?cDVwaTArWnhRY2FBcDdDd3dmYldtRjVjemFhdFZHS1ZsT0I5R29OZU9oN285?=
 =?utf-8?B?Ryt2RzQxVTFEQ25qWjBsZlJmMEVWNmpCTGhwdlJsRnR0NVRrQTBFdG9UZElS?=
 =?utf-8?B?VzJkd09CSzRBdUcvc1dRUDhLMVFCV1hDWk1GL0oyLy9VVWw4Zk1qeDJXTG8x?=
 =?utf-8?B?WkY0eFRZYzRnRkpXWDBaTVVwVzArK3lDbklMOUtTMFpjdjRDZURxcDhWN3hC?=
 =?utf-8?B?dkFxdUQ0SUU0WGpBOHN3YXhIZE10VFBXZUNkOTdUZUVNWDhxMVJVZ01PUVo3?=
 =?utf-8?B?cVIydmxzNUFFNVpQSDAyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU9lS2lNWEpWMHo1QXBtWm0vbkRpbGZ0N2tLbUs0SHRuQjBFSVdRd3Q4UCtt?=
 =?utf-8?B?Y0lrMDZ5R2JlVFpUaUE1dER2dkRuMVNZRXVSTGlsanYxakdBZW52SUxoUTZz?=
 =?utf-8?B?bjNDMllud0FpT1dJZTFNSk1ZejU2MWtCdCtMREJ6SThoeXh4VFZlaWdXRE42?=
 =?utf-8?B?U3Y2d3pFQmVKV1JNVmF2a3BYMGUrVEw5NjlQaW5MbThKcUlCOUtjUWNleWhW?=
 =?utf-8?B?SkNMVFBHZkx0S2JUY1VqVmc5TUIxN0ZCdW5kUk9tUHV6LytFakNUWDU2amJQ?=
 =?utf-8?B?c2Y5Vkc5bkxUZEVod2RNT2dSSXRKV1h4V3dUbDRpeFYrd3N4amN6SDg3QWpC?=
 =?utf-8?B?UHc0aVNra0dIU2pldnIraXQ4YXpoRlMvUGZmTEYrUVM1NGorWG15VjljYUpr?=
 =?utf-8?B?ZVByOWdEUXg3QUdtUEErNnZjZVJ2YzB5VWp0WWJTWWNJRnd2QTJ0NnQxbndO?=
 =?utf-8?B?WGlCMG1STjRTMThPdDJSWFpjVlBvMGloVVBCd0VPd1o2bFhCMzV4SEpkZUdP?=
 =?utf-8?B?TDNtRjgwR0dKQ0N6THVQZ1dJa290Mng4VGI3alBJOVg3RGhQTVp4UHBJT2lu?=
 =?utf-8?B?K3VxZGtHSGt5ZDNLdDV4MkZ6a00rdEEyNHNDNFQ4M0gvYkxHN0ZpajRMYk45?=
 =?utf-8?B?Tys3Z1UvZi95d3p1dnI0Vis2clY4dTNUeGV1dVRkck1DSGJJVi8vTlFySjh1?=
 =?utf-8?B?YWhTYys4bzNoNkYyMEtmTktYa01tcWcwc1d3VnFZUHpaNWYwT3R6TXVINDc3?=
 =?utf-8?B?UnlLYUQreEVBVEcwSmtpVkJUUFoyK2xpRXVzYWdhY3BEN1FXbmVISStINEJn?=
 =?utf-8?B?Q2Z4eENXTHM4a0hrNjZSRGpIZTBMTkZHNVZCcGFPdFgwR2hZUjFUanJ2MlI2?=
 =?utf-8?B?Wjl1aGs1M3RXYnRLOENHQXBwRGV3REw5Mzk3VGllOVVodWpJLzJ0ZjJLbU1Q?=
 =?utf-8?B?VDkrUDRnWGUyaFIxZ0JVMWFzU1NSMi9uQnNYRGo1SS9iNkRRSks3bE50UzJH?=
 =?utf-8?B?ZS9zT0FYVXh2WnpodEpCMTB2aEI4ZDVHZFo2TlVNVWd3VUVpR3NqOFJFSG91?=
 =?utf-8?B?UkZsa2ZkUjkxbE1qeldBZjVxWHFQcWllNTZnTGtWZEwvaWVqTG04TnpPK3JF?=
 =?utf-8?B?Nkw0Zk9JWmVjcFZ5eXRWWDAvOW1LVGlmU1FmNHdjb0RsY0YvS3BiWEhJK1Qr?=
 =?utf-8?B?VE5VcDdNUGpOY3ZTaVFKaVl3UXJaVWtNaWZSYkQwWjJFSmNqamdBQmlJY2VQ?=
 =?utf-8?B?VVcrUWVKRml6T0ttWGJiQ1dwK0RrM1VtZ3lrY2ZRdndDSTBYU3FWVzRTd3Q3?=
 =?utf-8?B?VWFxNGQvR0J3c1V6dUluMGNETWY2ZHRXd1ROUWhtTVpUa1grbFNha3FObGhn?=
 =?utf-8?B?WnZtVzJ0Vndxd0JNaENsVCtjSjNsU2lKaENoTEM0SWJtMWF0WGZhNm9pMHpq?=
 =?utf-8?B?Q3pGa0R1ajZLaUdjd3ZCTC9qRHV0M2Rwc3BPRk0rRUxNY3FyeWRJZEdjN0xR?=
 =?utf-8?B?NmVkWVVDNU4zR0xtZU5jVmliUDVDT3VXTWtmVTUwek1mL3YvZ085OWxMUDc1?=
 =?utf-8?B?aVk3M0NDVlZydXBSWFp4UytTMTNLdWZuSGdHdGlKdkdqanZsTnZWcC9oQUFO?=
 =?utf-8?B?YURINHh0N1ZrbEluV2Z4S3c4Y1hDSUpMQkErUTR0UmZFem5qZWlaeGdSVG5S?=
 =?utf-8?B?REdvQlhmL1lPM3VYVjhRVHJnaUd0MUdBQjA5VTBycGtLa204Tld6VGNrVnJV?=
 =?utf-8?B?cHBPZ0UwQXdVUGJsZmNvaDZFeDkydUV5UUhjM1hqc2VNMXJIYkw0RDhhanhD?=
 =?utf-8?B?cjNIWXUxck4zNVlZYnVGY3duc3hYSjcvM080Nk92dkxvOWlad1UwZ0ppaC9s?=
 =?utf-8?B?V2tCRTNGYmk4ZWpRcUV1MmU4YVlZQkY2VTBkU3ZEcTRFeVdGcUl6a2ZleFVl?=
 =?utf-8?B?MFNSTDdvMC91TE5vYlZGa2YrbHcvL0NFK1VyajJrdi9ZQml2bnl1Y0lTYUp5?=
 =?utf-8?B?djRwR0Y5Mm1xT2ZYZGxDVU16bGlpeFNtWnJoYUh0WmRoZk1sQlRWRS9nOHda?=
 =?utf-8?B?OWVUV1JFMElmayszLys1eTNGbHIvOTczOUxHUU5ZTGlnMDlIUjNvWldKOGpo?=
 =?utf-8?B?aXVlbFVOSVVSdlhmVTBVYXE2cFNCUGh5d0ZNK0FBNTRCYkIxditkL3FzVW5h?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ca41f0cd-09ce-4332-e6db-08dcbaade86a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:05:27.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTfU97O9ubKpMMT67H7K3pjovkUPbj2emJjSXdTzW6o1yQKCRVUsHL27TGildI8VkmZKuJIVVqYF1zLx9vUZBUs6BaOs0uEEXuy/H2hnjGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355
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

On 8/11/24 2:29 PM, Simon Glass wrote:
> Rsync all defconfig files using moveconfig.py
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   configs/am62px_evm_a53_defconfig           | 4 ++--
>   configs/am64x_evm_a53_defconfig            | 6 +++---
>   configs/j721e_beagleboneai64_a72_defconfig | 4 ++--
>   configs/j721e_evm_a72_defconfig            | 7 +++----
>   configs/j784s4_evm_a72_defconfig           | 4 ++--
>   configs/kmcent2_defconfig                  | 1 -
>   configs/kmcoge5ne_defconfig                | 1 -
>   configs/kmeter1_defconfig                  | 1 -
>   configs/kmopti2_defconfig                  | 1 -
>   configs/kmsupx5_defconfig                  | 1 -
>   configs/kmtepr2_defconfig                  | 1 -
>   configs/pg_wcom_expu1_defconfig            | 1 -
>   configs/pg_wcom_expu1_update_defconfig     | 1 -
>   configs/pg_wcom_seli8_defconfig            | 1 -
>   configs/pg_wcom_seli8_update_defconfig     | 1 -
>   configs/qemu-xtensa-dc233c_defconfig       | 1 -
>   configs/socfpga_secu1_defconfig            | 1 -
>   configs/tuge1_defconfig                    | 1 -
>   configs/tuxx1_defconfig                    | 1 -
>   19 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
> index 87005d03dee..30d48340249 100644
> --- a/configs/am62px_evm_a53_defconfig
> +++ b/configs/am62px_evm_a53_defconfig
> @@ -180,5 +180,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
>   CONFIG_SPL_DFU=y
>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>   CONFIG_EFI_SET_TIME=y
> -
> -#include <configs/k3_efi_capsule.config>
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Not sure this is desired?

> diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
> index 5b01002dfc4..66792595711 100644
> --- a/configs/am64x_evm_a53_defconfig
> +++ b/configs/am64x_evm_a53_defconfig
> @@ -70,6 +70,7 @@ CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_REMOTEPROC=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> @@ -150,7 +151,6 @@ CONFIG_DM_REGULATOR_TPS65219=y
>   CONFIG_K3_SYSTEM_CONTROLLER=y
>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
>   CONFIG_REMOTEPROC_TI_PRU=y
> -CONFIG_CMD_REMOTEPROC=y
>   CONFIG_RESET_TI_SCI=y
>   CONFIG_DM_RTC=y
>   CONFIG_RTC_EMULATION=y
> @@ -187,5 +187,5 @@ CONFIG_USB_FUNCTION_MASS_STORAGE=y
>   CONFIG_SPL_DFU=y
>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>   CONFIG_EFI_SET_TIME=y
> -
> -#include <configs/k3_efi_capsule.config>
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Ditto.

> diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
> index 86c565a9211..ead1d8389c6 100644
> --- a/configs/j721e_beagleboneai64_a72_defconfig
> +++ b/configs/j721e_beagleboneai64_a72_defconfig
> @@ -172,5 +172,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6163
>   CONFIG_SPL_DFU=y
>   CONFIG_LZO=y
>   CONFIG_EFI_SET_TIME=y
> -
> -#include <configs/k3_efi_capsule.config>
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Ditto.

> diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
> index f99315789c7..acb6e9c556e 100644
> --- a/configs/j721e_evm_a72_defconfig
> +++ b/configs/j721e_evm_a72_defconfig
> @@ -88,7 +88,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_OF_CONTROL=y
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_LIST="ti/k3-j721e-common-proc-board"
> +CONFIG_OF_UPSTREAM=y
>   CONFIG_MULTI_DTB_FIT=y
>   CONFIG_SPL_MULTI_DTB_FIT=y
>   CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> @@ -101,7 +101,6 @@ CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_OF_TRANSLATE=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_CLK=y
>   CONFIG_SPL_CLK=y
>   CONFIG_CLK_TI_SCI=y
> @@ -211,5 +210,5 @@ CONFIG_UFS=y
>   CONFIG_CADENCE_UFS=y
>   CONFIG_TI_J721E_UFS=y
>   CONFIG_EFI_SET_TIME=y
> -
> -#include <configs/k3_efi_capsule.config>
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Ditto.

> diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
> index 520a53b12f6..d6505f60c57 100644
> --- a/configs/j784s4_evm_a72_defconfig
> +++ b/configs/j784s4_evm_a72_defconfig
> @@ -162,5 +162,5 @@ CONFIG_SPL_SYSRESET=y
>   CONFIG_SYSRESET_TI_SCI=y
>   CONFIG_DM_THERMAL=y
>   CONFIG_EFI_SET_TIME=y
> -
> -#include <configs/k3_efi_capsule.config>
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Ditto.

c.f.
f29f6f1262b3b8418ad0640df90a7cea01d9b9a3
25e171c5a07f837f2a3178566e879894f9631b6b
81ab0f0fe0c792a412ae7fa1a1b60d99dec4b7ac
0040f07e5a563f64f60915a6cefdf7b1be7bfee8
8e117372c28a62b36875e9c9337ad87551a4c93c
40abc84b1df8cf4b6f3701519f8fc701eef398bc
86c6dd74913af0b39c06b58396d3fabe2d129815

Cheers,
Quentin
