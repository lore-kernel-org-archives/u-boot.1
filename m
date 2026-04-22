Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC54F94CD8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 07:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A278352B;
	Wed, 22 Apr 2026 09:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gQTLkOCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9336683AC5; Wed, 22 Apr 2026 09:26:05 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E14801A9
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxj3PpZ3ukVM5YDorM6ykdGgo3w80RtPtZtV82ofsP3c93Af5MW9ajJKDbk6tzcvj+k/0fM5hxzlQ+nbQmThdOzjlPo/PY9QGVra0RsrP1Wh3RCJpPCC/QNNcysStXRBlSAiYUpyn2jz+Wp8D32ceKt0OsZ27LWEt3L/D2O49O2ct5IpV57jurqwEFKdzZ9mE+Vq68u0oYavIVzixGqVF7jZPfPxHVfWGNLmvb+J4vZuJOHEItZ+bAzp/2BQ1R8CyP31A02Z843EbpdH7OVpjid209fwVyYZjqqYLDwonmoqSep35HKOM5DZ5nJ1SjNSMmb7uXCPAkV/0O8ZJXUckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osyBMlFKJNGkD2R4PUA2QsibpeFksCVUvj01/q6VFSw=;
 b=dtKJVSmAJjv0aEYM/6Qjx87jJ5zPUBaSCLGzNmdPS54ujEAix41aNEFz90vpw+FIncJsMgAhPdgCV3zYefVV1xdm8tHfqylb1fHPnxHbyROBSNCDgpG/enYkvSEgctb+OaCUuB2sLwc0hMqgs/tpIdlQNL80RopFK9PDh6TtmITjUgPWSrkVgcWi1BImVwCZwNsREB8DRSwFYUJEyppKKRyBvwJu+zXXelv0CdzIAjwrj0zH6hzA0v37N8wiUeKsVupSCnEBnnkYGLpMg8mebcdnd4hJoEzY4lkQhHi1g/NdkNRFMDhkjLEVDiGjrIY/MXAwKXH4BjiKkqEU2ytcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osyBMlFKJNGkD2R4PUA2QsibpeFksCVUvj01/q6VFSw=;
 b=gQTLkOCG4aSz0pYRYPCxS4ZA81bonhS360IcfiW5BEoZvtq9ETWfnSfdmrUa08Ne5YcGWHFmmCJqMEBM/cqTwi8nuaJL9zMOvfKHjRmEm5PNxBThSG+Hv1hH/VxHnwik3OfVBHAeQUkQTc7U/fW/KBB2oGYArO3n+jx827TGftLKxm7JQLPLKXwkulf5yt+d6pes3Y9xU9mRRmgXjzKj0x66Y4Tw3iKLQH4bJ8xpz0zTim46Yqvj5MSkOsDDI2mwP7AzPf0lkKUARy1ZhCNCw++9r/zYACqsvIIxAmhExD5HrJW7QhygPkT3e7HsvwQuVYWj9fVOOrze+Ofr3ro/Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA2PR03MB5673.namprd03.prod.outlook.com (2603:10b6:806:fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 07:25:58 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 07:25:58 +0000
Message-ID: <09fc62bb-d01c-45c1-925f-5f1b666484e9@altera.com>
Date: Wed, 22 Apr 2026 15:25:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule tool
 build
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 "LOK, CHEN HUEI" <chen.huei.lok@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
References: <20260319112717.7805-1-boon.khai.ng@altera.com>
 <20260319134809.GR502704@bill-the-cat>
 <SA3PR03MB7187764E2EBF3FACEF2619DDB44FA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20260319161609.GU502704@bill-the-cat>
 <SA3PR03MB71873A4FC785BA33DA3FA714B45AA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20260413202314.GH41863@bill-the-cat>
 <SA3PR03MB718767C602268BA968642A71B4252@SA3PR03MB7187.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <SA3PR03MB718767C602268BA968642A71B4252@SA3PR03MB7187.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA2PR03MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: db97485d-deb5-43c9-30db-08dea04065ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 2EyE6W8QvNXif/eG4kpV20y29bdBXy4/0Bwlt93VG7lD06vkqat9tjIkfmipg6r6FYq8fxWP8zCJPnVjzJCZjs+OHNMfQ5V99dI5NfbERCDJ83JsrtXg/YciSbBh8suWnpPIf3ClP65UJCXPUX85Fxe4SsYs9A3DnWYDX0tNyy3bAlyXcIKE9SnVmT9M1+67s6Envg9YTP7Xec4gvSmFF5v1RDdG2xjR5d6YqaOMae8qkVuqkNe5oaW1PU5wNRB70qXZNTzJZxLyH1/j0aSC+hxwHKbjqhri1UDnqlumL19CHlLW+J2ohQjDjwm9EDWnRUZpvcb/lGpj+wue55eaBo0X07VkD9HNhARRUAcaOQgC0gkig0QRnS5VhM9zgH3V0q/tueZOfd0ET3xBxPEovAlh8JqnwGTRHlR3CQbzBRskF+oLVQ7vAhmc30PUfkFfv1lyoHaE1U5UzGtd1Y+HsLX1QEqufN4XGH9DBLHhCRLVU67y+BgVN2ioTEod3g1J2SE/EoFVohE0uppHcy1pAmYtt/yY8++tuejgxNBf1TWL2S7Z8Jq7MBbCBb4ZGg3YO9mdAU07G2uXx5+OtS0042mqwyp1qAgAL3u1PCz2slfWZmVBVlgKxPzZdJ/VjBX+mkYK81xHdhtZFRrQLJ5jhplDgBq1wznuazO/VIWc5Je12rcPVSONBsN8VcLwWzXmvCgIS8+QaMgIpb6dBxoqa0jiFxtUGv0nn9s6MoBfxK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzV5TXdGU2cxS3dBU3Rpak15OHliUGVLOHVqQ1pDNjZyb0Qzczc5RFJzSEZR?=
 =?utf-8?B?RzVmTGJwMkVYMit5SzlTOE1BZXM4L2ZJVFJmRERIdlJPeW1BUDhqclAwTmlq?=
 =?utf-8?B?cWdNN3FmTUhaR3VaTm9CbWEwelFlTTJpNnNLMnJmNStmUTBqQXpYcjZVaFBC?=
 =?utf-8?B?aDlxZEJQODlSMUVIdTF1aWhvc3Vnc3hDMWJVYnloWFBBQzh2ZGJjSzI2bzc5?=
 =?utf-8?B?anIzQkZFdkthTmlzQWcrNGlndUdnUXU4eGI0M0hRbEQrSHlTVnFROEpvVXNq?=
 =?utf-8?B?Z2pvMUpQZkNJUlkxbytBdXBxMEYyMHlSTVBjdWoyeGs0QjErYmpwWlpLRHpY?=
 =?utf-8?B?NUlYa24xRFl2eVBFb3JUYUVrUC8xM0FsT0ZpOVg0Z1d0R2dHbitYU3oza1RM?=
 =?utf-8?B?REtxWmxSK0J6Uk0xVlJ2d21PUEJONUFGTDJTQTNYMEljcUErZitzckVyU1Jj?=
 =?utf-8?B?YnRRYUs0L3Z3OGtpU3lOY3JOYVJFM05oNzZCNURmRENPbGJKTUpHelFrMng3?=
 =?utf-8?B?R0VkM0hRc2MyNnRYTm9xc0dTTGRJSkdDNzZSSjNyRTBwbVllM21WeTNaSFY0?=
 =?utf-8?B?MTN2ZUE1TVJKaUhRSEhFenFXRUFwYStwSWIyYTdBRmFyNDMySlpnV2Uya0tE?=
 =?utf-8?B?V2g4R0ZaeElFMVZJeWZ2RjdoWjgxNEpKTnhRQnVGVzhMWDI0WG4vNGxnRER6?=
 =?utf-8?B?WTRDUnBEanc1VmdFaG8rUk1RQ3IyOGswditCNVFDUDFUcjhWSWYxM045eUI2?=
 =?utf-8?B?NmRpcmFWZGFxdXBQQ1lFY2xxTlo1OTl4QVV1Y0ZkWEZWYXVFMWdKc0g0cWF1?=
 =?utf-8?B?Y3R1ZkpQR3BZRkNhRXZ0KzloZ0dRNmFXUTJMZHRLTWlGZ1hxK1NNZ1NkdzhF?=
 =?utf-8?B?RzJ5Smh5K2hyMXVSTmxlTmlWczJpZXU2RGxBaHFUdHdmSkM0dWo0TjFhK3p3?=
 =?utf-8?B?MVYxeHl1U29LM2kwRFlYU2tQRXFPZDAvRWdGMmlYUHRrRlU5SytjSjlUc2Fa?=
 =?utf-8?B?cEFCOEFJTGs5YXpFSDNJT3BzbVhxK1p2UjRFNHVib2w0RCtpd2ROeVBSTHZC?=
 =?utf-8?B?V3RQVVNUWGxkaHNCU2RZUHdDSmdOSHpWTk5sc2RyUDNtenRCR3ZiUjAwR2pF?=
 =?utf-8?B?TW81TnExSXBPd0xZaVlSY01vS0g2cVBWQ2pNRGJPaXd6OVJaU01uL1cyTGJy?=
 =?utf-8?B?dDVNdmhwbTd4U2RJNEtXdGFOazVFTk55eVM3c0ExemZYeXI5U2dEWXorVVRN?=
 =?utf-8?B?MkxSc3VXa1pwRkVGd1c3Wk9KZ1JPZVZkbjNKRVUrS3liVmxHQzhjU0t0RWtq?=
 =?utf-8?B?ZU1hL1p1V0RwS2tCTUUxRmFocjRHUDJyYTJUSWRzeGphUDlUaUhBMHFLdkxC?=
 =?utf-8?B?R054TG5nT1RObkUyMEZlNUtrRnZiUTd4blZYUUZudEdDL1BKN25XUmVuRWl5?=
 =?utf-8?B?c2tEN1BVZHpqbndMU1FMaThaZnFNN0VKOHRHWVhwVHFneHczK3NmWWFuejYy?=
 =?utf-8?B?NExUeUJ5cTRnTkZXaWMxYXJCTXdUNi93amNxY1gzWUN6RDk2ZFVRSTZ3dzhD?=
 =?utf-8?B?dXYwUzFHeUdjb3ErQy95NSsrcWJZV3poalEyRzdpajhuYmdEc25ldWlIRm1U?=
 =?utf-8?B?NU9kUFc3eVJXMWxrWVVPY0pobWpPTWpoK1hROTZmRlpvZGlkN0NoQWZMV2tV?=
 =?utf-8?B?UlJYTkFvNHRNWE9UdHlmOTdBbmlNTElNeS9LQU1lUlRJcjI4RmloNWJ0cUxH?=
 =?utf-8?B?OCtYeHRtLzc2NDJBV2k0ZXlRQnR0TnBLR3NDUHMvelFFOHIydTQzbi9lSlBr?=
 =?utf-8?B?TVdpeDhaOURLUXhGWTN2ZHJEaFNKTU1tOWRMVnd4RktkRkFyZ1JVTGlpWSs2?=
 =?utf-8?B?azQxaTNUNUNURll3SFpIUENmL3lEMmJXeHpCcTE0eDNoRk9aSE80QnNyQkNk?=
 =?utf-8?B?eUx3MHJGZHNTOGRNV2haRU9CMC9MdmkrdlhsVWNNa3BoY1BjVUlJUzZFOVBw?=
 =?utf-8?B?TU8vYjhydCtIUnh5bjdTZk0reE11T3dIK0xJS3BQeDJCTkF1V3Bhc3lOcUhh?=
 =?utf-8?B?cC9WdnVReW1EdmlNOXRLa0pCOGVqUWRaRjJXWWN4MWVPK3lFRWxMZVh1bGxx?=
 =?utf-8?B?dUg1SVdGUlRjNER1VFZXdms1bUFadVFFbW9PVVBMemdnYlVqV1FiMVRTZmJP?=
 =?utf-8?B?VVBBdXhVeno5dDQ1aE9ZMVdyK20xZHlLSFVVWi96V2FXVUszZDhCRUJyMDhJ?=
 =?utf-8?B?aGh1dWxPdWJJOXF3UkpISDhsalptdUZ4RUJOSU4weVE1Y2Z3WGp5ZmtJRmhi?=
 =?utf-8?B?ZHN6bUxieEdlV25QZHRTRUVFd3ZsQXBzYkNNRHUxVzNPZGw0WFE0QmljS1NC?=
 =?utf-8?Q?qhETKcmBUHT/UjVY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db97485d-deb5-43c9-30db-08dea04065ba
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:25:58.0666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m3VMJoWuuRdBRYgJdqxsZ1xDfxA8EFyBj91TXycsNan037N95BPkWbbqoSQiHyQL3w74Qv413XLbjpRIpBLciImg+aqS/sfMU4Iz3JIfVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5673
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

Hi Boon Khai,


On 14/4/2026 11:34 am, NG, BOON KHAI wrote:
> Hi Tom,
>
> Thank you for the clarification and for looping in the EFI Loader custodians.
>
> I'm okay with the implementation to improve the Kconfig logic to only enable
> `CONFIG_TOOLS_MKEFICAPSULE` by default on platforms that actually support
> EFI capsule updates would be the best long-term solution.
> This would prevent misleading configurations and avoid unnecessary
> build failures on platforms that do not use the tool.
>
> I'm happy to help test or review any proposed changes in this area.
>
> In the meantime, could we set the setting
>
> +# CONFIG_TOOLS_MKEFICAPSULE is not set
>
> at the defonfig first? as I believe disabling the tool
> explicitly in the SoCFPGA defconfig remains the most
> accurate way to reflect the board's capabilities and
> avoid confusion for users.

I agree with the rationale discussed in this thread: Stratix10 SoCFPGA
platforms are not using UEFI capsule update flows today, so defaulting
CONFIG_TOOLS_MKEFICAPSULE on solely via CONFIG_EFI_LOADER does not reflect
what we ship or test, and it pulls in a GNUTLS host dependency that is
easy to hit in minimal build environments.


Disabling CONFIG_TOOLS_MKEFICAPSULE explicitly in the Stratix10 defconfigs
is therefore an accurate representation of the board feature set, not
only a workaround for missing host packages.


I'm fine with this going in as an interim measure while the broader
Kconfig/default discussion (default y only when capsule update is actually
in use) is handled separately with the EFI custodians as Tom suggested.


Please post a v2 with an updated commit message that briefly states:
   (1) the observed failure (missing gnutls/gnutls.h when building the 
tool),
   (2) that SoCFPGA Stratix10 does not use EFI capsule updates, and
   (3) that this explicitly disables the host tool to match that.


Thanks.


Best regards,

Tien Fong


