Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F12CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 13:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AC9846B4;
	Wed, 27 May 2026 15:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="P23JoJRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104A8846DE; Wed, 27 May 2026 15:28:54 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61008469D
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irn+XAvwh6co/hy+9WzuRUSezCWo9QfNfwFSfj9zlYhFruhkd70R2sJw0j8Zb7bNno+ijdUxZx73BILaS/kRJDHEkZu1EOOtdwPc2L360RCc4GWGUDEmZUrBFOcPMknlM1JlVpRdO1ErXdGLtFRU8yIIsxbnHUqgyVvIytR+DRAZiTCvbL1HBv8JcUFptudrKxe+zuZb6hghiHmjMh5NGxOGsadezcHwwBAlbPI20DZK3s6kLFbrGOzZTa9FoGRJ7/aYak7HHsxWCquXUdif+ZlGNhx9NFuV4iPSNVQ0aykECTROV4LScLBUW6gsMWBQoqM3bMqFdyRQQ9+10lRWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQDgGDToVn+qnxEcAlia9Z8mf8vNnuNWyMyCOyCUr9Q=;
 b=V8BxjL1wR4klKDZkZo9ctTF60U2g3oKy2aslBshl4p5WnWg2jE7MeHauq1itYckrN0bSuS2NtY5AppfUxSW9VRPXnmE1B3gZGvxqxaLZ1J3Qx6v1aaqVQ/mjG+oesXUyhqgG+MW+K4ZZT6a5iPd7wWXgYMl/KGy/FdTn7hUtTBM6DW56FGzSfdtIye/bQHLTrCDjJQFzxqCRGduCPZTMfSN1NRXxL88KTyOgWL1l0ludb5P0XzyV3CLm7+xRENNegZA/98kgnd0mJmM2UfZvJpSUXzqiAEDsBwPWj+q0SfX18SviXHBMZ4lyrpwV0ejHONPBnlpocdwVYs9m+55vcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQDgGDToVn+qnxEcAlia9Z8mf8vNnuNWyMyCOyCUr9Q=;
 b=P23JoJRLZ+wGNj9aSSpXgSWiv3lVV9Fj0wBdFadftrtfPN9hI4HlcqRfYsDIRWLHZywcI8QhyZ5hFj9t0nPB8pA9C0KdmznjUcPf9Cb/yqopzFBLnJHUAWluszOZJmbeU+7GR8oQxWS+0LTvEw7s96Fx2vtRMzzEWcWWvLd0owKO8d+iKyYCSgcyJUqKaognt40DsPEdMwpaoMS1MEoTezYohrzNtCGGGQxUs2svjPeRFC1WwkyhsEPu/1MzHZSMsqvWexrHGhUkVRjRPY6Y8v8NOdXXi0YjikInsPWrc664bPxhB8aiTu3T8mQuzTlo7qCEGWtsyK22FvqGR12rUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ2PR03MB7043.namprd03.prod.outlook.com (2603:10b6:a03:4fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 13:28:47 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 13:28:47 +0000
Message-ID: <b31b7e54-375a-4d83-826c-2518d12ae44e@altera.com>
Date: Wed, 27 May 2026 18:58:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] mtd: spi: select SPL_SPI_FLASH_TINY in SPL stage
To: Guodong Xu <guodong@riscstar.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de,
 u-boot-spacemit@groups.io
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
 <20260520-b4-k1-spl-pinctrl-spinor-v2-1-8d25db98ac8e@riscstar.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-1-8d25db98ac8e@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ2PR03MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 95026409-3123-4278-7f0e-08debbf3e19f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: fctV3ue4Y2k6/m7e3sRVW+X44/LqInaMuk29E6rvI/t7g/ywmeRkXwGsPhnv9RxPUol+wwSjmAWTlLfqUnVQUiL9yvMPfI+HvKAdavjH5kEnE7ukVzhD1KoKTLDMvxu7s+ZkH5UNaNVytlYMMA49R5Qr/Jlt3MCeSeMghmpyravHO169pW2kze7+QXUQkqIvo+AMlRzz0b2rio9gH8rq0ORubqI9VJQnjE8Cfgk3kDkz9BkukEd3J2L4KcdZiVC9vjfre3mTiyDz20STxGJQRlkgizJGYkVg1H/7DZV7/1E3rfj7POPVRYatV45/jFKb30ISTd0YcLeyrdPYqYJhipPYiPZGkjIsG2hfEXr3v5LeLgmPVrxSlsQ/Eq0pJeFZcF/DISRXGp8vpDOV2yIcl01rswIxMJmFauGiQ5rph0iJeH3W7FxRRfhm3AYOamjx911ARQbSvNi1dHBir/PqW38Zvfl0XqQtHFJ50ljJLLbVMvhoUHkU7HKqXU/78K3UunL3X/xJPFSkJw7oV3MdySj0/VY3HT0oHP9lNmYViDSK/0dH6M3Uvtl+xpPPBWXWx0tUUOjgFCXnLZpA/gacsBJ+4vhQjmgGbcDH8thXriNH6iJqWXF2dmAFaNhhkSc1M75wEW1aiR/6xen+T5ohiRz0W+fJ5bmRxlWW8NKrF4dHyH1YKx3jt4XjiRuiuRL1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhHQktFQlljL0dFcE5lUXpCQkM2UktmQmFxQ25keGlsdVozSjdmSUFlNTl1?=
 =?utf-8?B?aUFzZmdqeFp2Ym5pKzRaaG10cmNqL2Y0c1pIVDR3c2lkRndQYjVKTCttTmxF?=
 =?utf-8?B?Mnk0aHNRSWZUa2ZiUjdQdGJBYlc4dDVMZmozZHpXWEFSRFZmYzNRTFJsUGFX?=
 =?utf-8?B?SUxQT3hFUS9FZU5JcWVJTjdGRGxJWEdlM0d6ZTFleUlvUXpKRWVDdUVaLzlC?=
 =?utf-8?B?TDBHRHlybmhEY1E1UzJYZklXMFpHK2JpZzRFYlk2S2w1OHRBY1VwQVVvOUdF?=
 =?utf-8?B?SkZsUThxYTdpRnArbjNwSXlGU1JjUm5qcVpLQzdha3JsSUNmNy9NdjkvYkpC?=
 =?utf-8?B?QXo4WkxEN2lkdjVWTHRWaGd6Z29uZWNhRE9IUXpsQ1lDdXRtU0RHcnVqZEJo?=
 =?utf-8?B?UktmaGdXbzNNSzhKNitrOG8xMHArNm9pZXhTWUY5NzRiK0k2NWhjTWdUTTNn?=
 =?utf-8?B?eVlzdHNXVDcxZUpac3ZVVTdXZjJHb2V5ZjJEUC9TRmhNWncwdERQYUVOQ0NN?=
 =?utf-8?B?SldnUVlDL0pJejhPSDBTL1VveEZLL0orYW5sNTVZWHI5bjRDbHJsaTQ1N0tC?=
 =?utf-8?B?UDNvem9JZy9DbFpzemE0VlpOQWtlOXlZbjlxYVlEY0Q4eEpRQThvZGFVcHhR?=
 =?utf-8?B?aWVyS0FoYm1iSW5vTWd0UXM4cnVjcW1YTGo0ZlNnZnRTRVVLVGg3UHBlNGlV?=
 =?utf-8?B?TUdKbWJndURwRzExb2hQUnYxalJCdHJtcWJFa2dhZFdOTG4xQ1V3aW5BVG83?=
 =?utf-8?B?cVZEcy9NdEs1NWZxeXVrWWhhaVkyOEtGcmJIQUk2SmcyVzlJWThJcHNncHFq?=
 =?utf-8?B?MEIweUpYK0o0NUhHQ3lzQVl0OTI5ZklTbXd3M2szMlRFdzZ5K24xb3VIUENS?=
 =?utf-8?B?eWZsVElUR0RHQnFZT2VDd0VDYm8ycmhKNk15SG9qYVFTMkc0UkdINlBkSmQ3?=
 =?utf-8?B?N1ZYemdCNkNaQVNBZ2lyamFWeVdhSjQ0SFRod0s2TWVPeTNPaURnY3BON3Zv?=
 =?utf-8?B?YlBDckpQa2hKSnRlYm5saXQ0eHA1TnFHTGNDNHhvOGYvcHBYZkFXQjdEUFhW?=
 =?utf-8?B?MU5PTGREa1lBdWcwRC8yck8ydlBVNW5wbEpRSlV3Sm0xek5TQ1kyT1N2U1R0?=
 =?utf-8?B?NDBtMHl5VnlIWEJpOGxTQktWa1ZTc3J6TDk0YTRrZ2N2RkJkd2RIQnpma0N3?=
 =?utf-8?B?Zm5PZExRbTk0eGErQUREcnpTRFNzUHYveHJaaGs3RzFkbDVMSjhKcXovUng5?=
 =?utf-8?B?TytwS25ON0xWRFhnbnp5WS9hS1VQL21nYTA5ajVjdzZicDA5eUsveEVpUUtC?=
 =?utf-8?B?aWtsVnpxeWNoQzRmTDZKblRBU3ByaU4ra2dwZjR5WDBlMERkVENtVDQ3K2Rm?=
 =?utf-8?B?WnVPeWE2YzUxRHJJVVVDVDRXMW5NdWN5OGxKS0hoMGxUVndNblE2ZEx0TVlU?=
 =?utf-8?B?c1JkaCtzVk1GaERKSGtvV2Y2UHVqK2xtVDhkYytrRDV2cEZwdHJvSXdNVnhR?=
 =?utf-8?B?KzlJS3ZQU3V0Q0pveGxVdWtWNUUxZlZwRlA5SEhYa00wTzgwVHlPdkp4ck1N?=
 =?utf-8?B?bTRhQk92R25nQ3oyY0o2UkhYcUJlM3hLUVRUMWVCK2dkcTU2Q3YvcEYzZGgy?=
 =?utf-8?B?NWR2MTRUTmJoWkNRTzB6WktZZFNwdlZnR09jQXNhR0RsLy9KRG1Vb0diU1c3?=
 =?utf-8?B?TklYZkxQRTlYdDdlMUU2Y093L0oyVmE5eGE3Z3dkTTYzQ1NMRmxMRG02cFR2?=
 =?utf-8?B?Z2FrWkJvN0hHcWlQUEZTWFlObXRBVHphUUM3OG0raEkxOCt1RGZYUkdnd09S?=
 =?utf-8?B?ZUk3Qy9UdlBTTjVINDRhcnZnVWg5RFRrRWF6SU1Cc3hjZmNUdit3M1l3THVv?=
 =?utf-8?B?bEYxblE1RkNidDRaNXJmcC9qOCtjVjJZaXRlU1V3U3lMbUd2RklCUFhXcVRv?=
 =?utf-8?B?S3JtR0lIOHlJUTN3WG80T2NXZzRaUUhqNFFIUE1zaHhQT3JrRzNqUjh5US9Y?=
 =?utf-8?B?dXU3NHRVQTlkMmNZb1REZ0dQNkczREtuVmN4L1FMWnppdGwxZHJNbVRJcEta?=
 =?utf-8?B?MVdEZVgxd1JqdEg0ZXJyQTRQSkRHVnVQTmdwYW1WRzVCV3pwcSs5U01DcmpP?=
 =?utf-8?B?WHVsMkRnMWlkN0s0R0dOYzBldHd2YWpsM3RHeXJFakRGWVRzVlhrOVJhOS9z?=
 =?utf-8?B?UlR0VmFFOUpxMUpCSkJCbnN0VDhPOXhwSzNHRHVVejlKSmFYcWNPRmJReS93?=
 =?utf-8?B?TUpqZUlVem1sZGxIZEFWbDlJRGhuY05jY3lTVk9KUUgyaSt1V1BnNmE0RWRw?=
 =?utf-8?B?ZHh3UzAvQjBnaHNBZzZQVEtWSHlzUldOTG5iaDI2ZjZNVTIrSUFNeW9PQjEr?=
 =?utf-8?Q?DyNraOquANuRjs+g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95026409-3123-4278-7f0e-08debbf3e19f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:28:47.4940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIz+TA7fQK7u0FKBm15eVqRFOHdO0lvGOog96yPos3pydnnfyiAiomI9wLMIR4i/m1SSc0y7NuQPi6Y7Y3F1RLkBYCBXG52GFCGd90zVBr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7043
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


On 5/20/2026 4:15 PM, Guodong Xu wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
>
> Fix to select CONFIG_SPL_SPI_FLASH_TINY in SPL_BUILD stage.
>
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>

Acked-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>


