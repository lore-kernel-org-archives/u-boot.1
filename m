Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82592CD37AC
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 05:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A54281E18;
	Tue, 12 May 2026 07:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="V10U4vKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E25A838BB; Tue, 12 May 2026 07:09:59 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2821D803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLKH3i+ECvgaa8gxfyuM0uoPukpc3/XeR8+o0Qb2SKeNLW7opX78/QFzoH6EElzD78xHDspMHpGP+0eGjq2XMZQMjA4OBIPrPR+schrKQBwNgjQjzeYtyEaSpNxoej/7Fy4MQA2eYpW0yONjaeRCXGdCUJyUGO3ejnnIS873kAAQ9d+ShvhRFYy8PXBvgFY2YtBPKMLjMPtqYyz6IF4u7+YqmuhgpCxwtkA+XqPuSZVFTFgmhlpTwv4bPS8kUIbbnTb2WX6eKbUfBjpU4DZMG+1aPmFmZM3mehSjs2g2bXAMDAUPP0fcg3N3fnwM0h+Xxbo2uKMxIOWU16tId80/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2dLeCi33OrtJr0v/xGnIuQNP55fOGhNlgpnHKmpnys=;
 b=Nh8bXnYSAK0Unbgwt8HaMqntX9wZc+zVKstgf9x0hxHmbY6XDrsIcmY1W1JaXSExlu97q1TmzjopThKDNZM1IKozys2amxVKzqRM2yPwyXvVlGalSoCLPPtAo6Vhwa60DOEpki+3wVCqaSlJ11aDunyiGuq+2cgE1YxkuXTNmkzF+QxyPm4HEym3eTBApVD8ZKOv/lt9Sxcd1i4loyp+6FUi/ZmdOMTOXkvyh5I39inDMul68kTjPzVG0C2S9qeOlxDKvST8PDCvd4WrUdvaJjcJVyQiio//ZyvQqFTo6P1PjFNQJ8wbER6PsGahUZ5kWaj5nVwJ1yiukr0VivZ+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2dLeCi33OrtJr0v/xGnIuQNP55fOGhNlgpnHKmpnys=;
 b=V10U4vKRDZYTlLvWnPqhySKyYrYFXWZhYEj0Q7JYosmBywprhMzomq6VaVClG1uX/iZf+kAs4E+eO8W2/UoLq0lVLr/M5t0Qrp2F274BmmdKxfzPfoZRlJcLgsRKfLOSofHgCgQ0ItTm9gH0v2v34knW6EZvHqEEcMNlCvNqusd44YLu08w66147tb1Ld+PhTS84U5s5aO0tKwxz+F7alAY89sP28mr6FAtK0963Iv/Aij1wVj20f6pVwr8PQZ2z5SU5PFdXVRch7/rwbpb7vP4Xw/TL1VYZvgKCh5EbiI2z2cWLkRap9PtW5Y92H06ODip242dT7/ue1wJ1zyRPBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7279.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 05:09:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 05:09:53 +0000
Message-ID: <a18ce5f1-6aa0-4aa4-bffa-2b07d5a1b01c@siemens.com>
Date: Tue, 12 May 2026 07:09:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] env: migrate static flags list to Kconfig
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de,
 "Li, Hua Qian" <huaqian.li@siemens.com>,
 "Su, Bao Cheng" <baocheng.su@siemens.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heiko Schocher <hs@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@denx.de>, Le Jin <le.jin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>
References: <20260511182036.50453-1-james.hilliard1@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260511182036.50453-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0349.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 1def1ea1-f6f4-4048-8dc7-08deafe4b37c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|55112099003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /XOliHek4R3M0mRP02gccx72DsdCPpPxlkI8gX5+H1i9Em+qlsQ0bHQ99vh4u32oY/Hq/PtL5v6MNetJUYAkhEfYymDTJm5/I3INfAxyW26TU3nA3dWEVA6oO4DC413bh5C9CAz2Q/sYAq50g2Tog9SfnDTUSPFcvQ4SgV1/lhDfSIompvGTN+a8BngzaINUt5s6oIIt1MlW7zEJ8wPoUCgxJRY5ADkGAhypD9W3MwQINfCpiF3sBzfRubyBmxgBKY56bv3rDnZl8hAhOVMnEINbuKeivfuUu53wmooHnRbCayCHboQIgu1oEu0LytmQRPeewDpJz6usu3HRKHr2orrrUgxbH6t5YmqXSqwCb2WGZgU7UkvgYBQx/tBpJ+IXys2A98ZZkn0iG3Mzbx5kZEbacIt3w99zt61mBmM3tVztMhPlVVgf1jfyyL0ygj3G6BQpyVjUa/TbpGLwae7fviC1ulAB0oJTA6T63bxvFYsKXVnnjg1jkO8I6HURC90FW6Orq4En9Ah9qlS93sv7xKj+r21O4gNp1UDWaoLZNS9gq6Hthlfc6QGWq8TdDKMdEIlzf49FLlXIgWVwNFN2pHbRynImi4GBYJHtNDd31puKxt7S5zWXKVk5T8b8IZt4raCGG2Upoj5mcVp3/1PbJJGCSBok9CwcmtmmwepDul8+CkTWi0yfHrmh2pnPDVq5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(55112099003)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGlMVkwxZVI2dWpDZ0l6MXZZamlhZE9IRktFditobVdxY0g2UzM0TEdBeGR2?=
 =?utf-8?B?TGF5eDU5VTh3YXl6eUQ1UzZRMXlCSVpLbW9RSzF1U1pVTUkwWW1yajJvandi?=
 =?utf-8?B?Y3Y4OFFnUHZ1bHVtQUk0c21PTVIydmZHMUFwSlZnMjFDeUZnYkpkaDBtRjhS?=
 =?utf-8?B?K0EyZHl4OVMxU28zYnBSN1M2N3pRYjNEQ1dGUW5NZHgvZDZVcjBMR1dydTdN?=
 =?utf-8?B?ZGZlbG1kYlY3NXJnd3RIRUVWYksraDYwNmNjQ2lHNlQ2N0ZLS3BidjhvaEJr?=
 =?utf-8?B?WVcvVEVmd0Z1cFVqZnJ5RmtDMzRuOVUxQjJYNk02SVlkNW9JZWQ5bTFCc2kx?=
 =?utf-8?B?aXAvMkE0bzZQWVN1eVphdVgydnprYUlCdm9kL2xBckk4SUNERmVUUEZNSmZD?=
 =?utf-8?B?VHcwcXcvMTlmWjBVQkhhZDg2dE1kMkdDa0x4QnlESmEvWlE5ZS9CcVlaUFV4?=
 =?utf-8?B?ZEZaK3diL2NRNmJFa1VYUFVyZm5zUnhkYVhSSlBMMzEvSUhNanoyUzNtRkZj?=
 =?utf-8?B?ZFlZeVREbVNPUFNsVnVyM0RNcXF1WGpWNXoxdTdLSk42bFRDTzFBd3Q2Vzd4?=
 =?utf-8?B?RVRVYWdxOGpUVU5GdEhqZHJoZHRQRE0xWW9SQmV4akh6RmhubWxKYVI1RkxB?=
 =?utf-8?B?aTBXOTRPVzRvamo3eGxOQ0F5UVRMZVVZZDVGVWxVcEE5dXExNk9Ja1Njdm5U?=
 =?utf-8?B?aDdkVXlmK1JKT0ZHa1llL24yNFlxUUh0a0IybEc2UjhSbit0Tk9OVXZnQlhB?=
 =?utf-8?B?OUx5L2E3S2JkcHJVYUZ3bGx5Y0h0Ykp4NWxNL3MyNXpZZllZcXJhZE93WFg0?=
 =?utf-8?B?NkNlS2V2M2xLMmlCQmZkNXFCUEVtcnEyVUNLcHZUMkt3SERLSXpyRzNJRmpO?=
 =?utf-8?B?WUhCazR6WjE3T2ZYN3ovaktQcm05VmFXbnNsWUo3T3Q1WURpWkpZcG9kSnh1?=
 =?utf-8?B?THNMc0U1OXlXZkRrZ1VJNlBSWmg4U0pIN2xKSHJab2Y1VzJ2OEFuNzlLMjZK?=
 =?utf-8?B?dTRjSGV3SmFQcVlMcVN4d0VPWGdzdDdReWZBOU1iZUhHTDJZeW9OejNQVlU4?=
 =?utf-8?B?ODVlZFJpQTRYYit1OFpoQ3dKTGZGb20vMEFvSk9EN0p3VCt1QVNTYzQ5UkIz?=
 =?utf-8?B?MEpkV1k5L05IeFg3TTZ2VUZsSi9XbFA4YzVKTGhmSks5ZHFOMm94SUFFNG9T?=
 =?utf-8?B?dHZRUUhTQk52YVVXeXptV0JCK1NwNXZNSFcxcDN6VlRqZmVzZEtBNFJCbTNs?=
 =?utf-8?B?MkJRMG5xYzZYdVVoUXZ4TVcyQjhqMDV3anVKTkJRZVVpSXdMTElsU2xpb0FW?=
 =?utf-8?B?dVY4OEh4U2laSE5IM3VPcjZjazBZZjlKNDE2ZURzbkpYV0xsaUxvT0tlTGwv?=
 =?utf-8?B?R1dOUTIwYUltRmU4eWRHd3NnUXRtWEZMMGF3RjUvbm9naVBTZ2JhZHJnQWc5?=
 =?utf-8?B?bDJCeXp0L20wazFnbjdjdm8xbU1ISXdNVy85eW4veENYTk9tWWFCcSthY2Iy?=
 =?utf-8?B?eGpXNmVJQVpPbTNsWEFqZ3Q1VE9ka2JKVDdrREF0ZDJWMjRlQ1dZZXo4WVlQ?=
 =?utf-8?B?OFM2c3Rhd0V0Z0hjVWlaWWdoZTY2TGlSdUFrdHY5ZmY4YXhmNjcwNVpleDFa?=
 =?utf-8?B?a2tqRHZSMWdaVS9wSW84aXVFbkFqQWhBYmNmZmE4eEpEdUdmYVZ3MnZVYjIw?=
 =?utf-8?B?R1JaODZJVEN5S0NLbW12RW5qcktPS0JEbHFLZlRmOFJWQlZ2N1Zxb2tJdmkz?=
 =?utf-8?B?d0M0WlN4eXk4Qm9nNWYyMDU3WlBlY1laaDB4eFpramFpZzJkbTBvcUVvRFlT?=
 =?utf-8?B?R09oMVhQZXFGLy9PRlVjMC8zdExvM1lEZjVMWWNsaDJEbEUyMnhTNHEzeXRQ?=
 =?utf-8?B?U2xUanBXMFc0bmlMVUErNFM5QjhuVm5SblZRN1JlU2t6RDRlMC9jT1diOGxp?=
 =?utf-8?B?SlRsc1liTmJnZVpLdVhWbTFkQVBteEZrYkJFMTlVcWgzeXBXNWtiZlJ3c2or?=
 =?utf-8?B?MmhNRXcvMXlGVnhvWGM1cHkrL2FpUHpnN1NiR2FESWxGSFNMSUlCS0llV0Q2?=
 =?utf-8?B?Ti9hTmU0NXhyc09ONksvTnlGcVdUVEZWaXo1MjJtZ0VaMG9hMHFyVGdlZ3Q2?=
 =?utf-8?B?cm02M2RzVmhLNlJPOVA1VnhIeUJQdUlmTlVmTXVMeVlUcFBpSklQUGxpTmhu?=
 =?utf-8?B?VG84cmp0NXdZSFg1ejBJMUVNS3FPYVkrbUJoUDVCbStucUVodDhWTDBnTS9S?=
 =?utf-8?B?SkcySWFZb0ZncWxXTjI5L1dNVE81ZExMUmRlZTR3TkJiMHRNOU5KRWM5WVEr?=
 =?utf-8?B?NzlyNUIxUEgxZ3p4VnlZbDNxTEF1am9kRjUzZmR5MkxGbDIrWk9jdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1def1ea1-f6f4-4048-8dc7-08deafe4b37c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:09:53.3939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ve0sP8KVvr/1lIQC8rN1IKxNc0ynvdquPFgJMWXGs40gsnBJMHnMrxTst9ieUDRpj0DdqJUXcL53PoVnjZ8s7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7279
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

On 11.05.26 20:20, James Hilliard wrote:
> Environment callbacks can already be configured from Kconfig with
> CONFIG_ENV_CALLBACK_LIST_STATIC, but static environment flags still
> require board headers to define CFG_ENV_FLAGS_LIST_STATIC.
> 
> Add CONFIG_ENV_FLAGS_LIST_STATIC and use it as the only board-provided
> static environment flags list. Convert the remaining default-config users
> from CFG_ENV_FLAGS_LIST_STATIC to defconfig settings and drop the legacy
> header macro from ENV_FLAGS_LIST_STATIC.
> 
> Move the environment flags format documentation out of README and into
> the developer environment documentation. Include the format in the
> Kconfig help as well.
> 
> This lets boards configure writeable-list policy and type validation
> from defconfig without adding a config header solely for env flags.
> 
> This preserves the behavior of default configs. Header-only cases that
> were inactive in upstream defconfigs are not converted into defconfig
> entries: iot2050 can add its list when enabling ENV_WRITEABLE_LIST, and
> smegw01 can add mmcdev:dw support if the unlocked SYS_BOOT_LOCKED=n
> configuration is needed.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes v2 -> v3:
>   - Note that inactive header-only iot2050 flags and the smegw01
>     SYS_BOOT_LOCKED=n mmcdev:dw flag are not converted into defconfigs.
> 

Colleagues, you want to have an eye on this because it could silently
unlock the (downstream) secure boot config profile [1] on next update.

This makes me wonder if U-Boot shouldn't carry such profiles as well,
either in form of a generic Kconfig switch or some defconfig variants.
It's a very common pattern to shoot yourself into the foot while trying
to lock down the typical try-out upstream defconfigs for secure boot.

Jan

[1]
https://github.com/siemens/meta-iot2050/blob/master/meta/recipes-bsp/u-boot/files/secure-boot.cfg

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
