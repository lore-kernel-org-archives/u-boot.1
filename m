Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59304CD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 10:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7CD08487C;
	Tue,  5 May 2026 12:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="R+4FPVeo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11129848A4; Tue,  5 May 2026 12:52:14 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12DCA8486B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6f8tzX1xIR4faC4ZbVXD0kuWsx48/CnLZ+nntoKNZ8fjtG46TMwCIv0zrYqdGURvZ1S1rB9g3nZmMvN91RSXXNI6QSlSJYr+QDqlxyoh+Y2A0MOY7ZtZLCAjukEIb88UUcQNLtbNVHBofNEXhlrtvdtmHH44B2FLdwrivRSe4SC5ucv5Y2TENbMIpEx05SmVuK5J0k3mUnnKW2YPDyHl6y+8Xzcdi9gCQKAFDFlXCy546xbHnnsRPg8VrsUA6QUPE8W6okpiPYigq2Bq15Rgz2wFKTURw92ktia36PlGpn0tFTDLOs0kgCi9kHoEOxnfA8bI+1OjJb1tbpJGQ3zDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7mQO9GXcM/rcVEP0rXPF4xne2xmSxeJv/4zgrGI9ws=;
 b=rst6V6uW3TjTZdBGoxZh1SiKvYra7j5YWGGg27g3984JC5bxcgz08UP1Z5g2rV2jh1joOcpSuQy5QEkQinbWIEJDKSF1ooyqQW1fEmY4iNU5vX4jCGwEWXG3scIQrjEx6NWn5IgPUt9gJ004d2HMzAqOQ1ktUlkwrMGwftsZav0gCm5BM/DyINj3ysACPPkV3w72Dx02Sd/LrzS8swogplhs85uI0PKjwVBf+Vq1QtEOXsFZMliVLUAQ5PrCBOG0071CqBwxcyKTzAKj6kBdFUETx06JIHDsVJldYwNMFbr1HsLPfOQH/bm31LkFu8Zqdx8u2xm8pIJj8vF9XxjMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7mQO9GXcM/rcVEP0rXPF4xne2xmSxeJv/4zgrGI9ws=;
 b=R+4FPVeobViNxpmGK5d/pRotZleNyfy/O/B/XuTjCdFH+BZwaQnXTGMquXCSDVA0mEwNzmQbHwNx9z1tjg3V0kHnhmpEqZfLaQeyUfS7bkusXMoTeN52itkWS8neE1p/nZp/eUrkouSg6EqeIUFERUCZCp7ED8kmDZg8li4BhIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8848.eurprd04.prod.outlook.com (2603:10a6:102:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:52:10 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:52:10 +0000
Message-ID: <2202b6b4-41d4-4bcc-be89-b50f4c18662d@cherry.de>
Date: Tue, 5 May 2026 12:52:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC next 15/18] kbuild: enable -Werror for hostprogs
To: Simon Glass <sjg@chromium.org>, foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-15-b19301d1948a@cherry.de>
 <CAFLszTiX7VJzT_mYS071Vb5jOBR4pqtpuM9LoqR=6m+qMNLsyw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTiX7VJzT_mYS071Vb5jOBR4pqtpuM9LoqR=6m+qMNLsyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: a6aee246-ab25-418a-81e7-08deaa945ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: EgDecFwgfSX/6LIBAPRUCNZu6gJOantO6qqoWmVStOL4bMy4T4e7ZQuStTnmNfkiHy9iE4Z3GciAVpgi/3KOH9ehieziiEDG6YEHOYpPuB8NfmYBluvLzGRShzok5AlLYur5kpgrG65l/agR2MBl3ykwjP7t5GxTWXwkZ1le1/wP/eJGMMA+vi2iXxVA/+5LhEpO4x2DvcTVD16+Xho4hd6Dm/VzY2bEBqNsy6AnAuoDeoU1/HS6Sn9qLYUxVBwTJpyDP3T34gr0hSptU+8lnW2hhORRRqGnaBEmYo1zoZHCA17phOwd/MrszxMB0+Obddmn3FPxScpupbdIJGuwqQS7oC9WYzclBJHVmD4OUb6nBgHcuE3IuYucNXoFOqPmGURe3U6Z6Q824F4nyHqs4DyyxNE2p8usCddIk5mnm0WKwzm11U4psu2g6YtQDAkSIjTbqqHhDIPJ+0b5YFIpPaISrkMjcaggkgoF5W+CksjipcmVVwK15bHuzHYMUB3Dca1YkK02UTNXLFXy8yQUKQNnIB6L75bfxa8+8XnVMuQ8Y6EoB4k3E0k1wATtdfWTQ5jy+6pcNc7Ew2fkpPyyTIpD+UNFLdPJo98ml8sq7Nbgw0wrMRtyZMqqcpqCO2ZAkNtn7PLimQ8Ji1f4PeymE93Op8TpuRiAQ+gy5L3cGmH3ASbqun4POvBCYpUNj7n3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmQycEJKRnpxaXltVXJTZXV1UzNoeUlBbTVnUTNtTlVDaVZWNGdBeEpFQmxz?=
 =?utf-8?B?K1lsUnY4WFBsbHFxdGJuRjlzWVFoK09ZRWRpWFdyK1NkOEgxSGVLZjdVT2lx?=
 =?utf-8?B?UTJoL2xtQ0JNenBQTzArZ0hscndhSmVEVVFSN0pMNFQ5dW9sYXp6d3dhQkZz?=
 =?utf-8?B?YmJML25NcTZKQ3hWMEh6emdrd0lQdWdFc05NekxVMFhqKzFMemhqTVJpSko2?=
 =?utf-8?B?dmM1VWNGNXRES01vUEtrN2FGMXBTbWdHb1UyUURJcGcvKzhmZ0J0bTZjMng0?=
 =?utf-8?B?L0VRK25XMjZ1YmhNV3NNNGFERlJqR1JVTit1TVNUeVVOUEdtamlHQlRHUzl6?=
 =?utf-8?B?Z0c0Ry9yN3BLaFlHdE5DelIraGsxallLRFgybm5WT1QzZDQvZVA1QXVTRUhO?=
 =?utf-8?B?V1UzL3ZuQkRuUnFZTjd4TEdpVTgzK3M3cVFFdnZhUVJjSW42aXFWb3VnL3dk?=
 =?utf-8?B?VlluVC9kREE1K0tEc1BHMzNGa1Rtb2NnVGNRKzRtcjJGeUYySm5uL0I5MEJo?=
 =?utf-8?B?YzFNcmg3WmI4cmJkdHZjak05WnBhb2FxcVJQNDErYkd2MmJaSTA3a1k2cE5I?=
 =?utf-8?B?Y3djUWp6eGQ0OS9DOHJQU3dXYlFaS1h1Ulc5R0htL1R1NDlPZ2VyWG1Xdmpi?=
 =?utf-8?B?K25xck9ITU0zL3FkSnRWMnVzcjByOWhGTnFmemtlcUFiN0dQT2Rac1hPTkVu?=
 =?utf-8?B?WHR5dzJ5cmZtMUNmdkVEWjdpL1RIZjRTY2hqekZXTUdOL3lGYkVRZG5IL1BJ?=
 =?utf-8?B?aWFsWUdIdWgxeisvaDBacmhXOGhTbFg1djlyMVpjcWNLd2xzSjZ4Y29ZTzRN?=
 =?utf-8?B?MmdDMjFFK3J4emhleVBJQ1ZlMGo5WU44YzBXSyt4bVJZaWM3UFpmckkzWTdL?=
 =?utf-8?B?TnZxaUtvRlYzMW4zSjV2MGhVbjlqbDZMRFhsS1ppN1FYSVdWR0t4Y0RsbS9Q?=
 =?utf-8?B?b0hXWmdsWWVBWjN0WjBrekthdzdVSW9EbUE2ektIRVJkQkRUTVMvY0dQRjJs?=
 =?utf-8?B?aFhPUEFlN25FbGY0VDR4UDg5WUppMzFUdjZiQmFnSGVCaE5KYkxpMHRrN0pI?=
 =?utf-8?B?R0VzbXNHZW1tZVRKWUFKTGpWWGFSYzN0enoyQnNLRmkxRDlDTmVxcS96RmZv?=
 =?utf-8?B?ZDY3N3p3Zk5GajdrRFdsTlFhRFhGVERaOHBNSThKdjIrbHNMaVBvSm9tVk95?=
 =?utf-8?B?UkE3UGl6bmJQR2p2aFBDRXA0R3d4YlgzYlp0dHhWdUdpeGpBRWlja2JGVkZq?=
 =?utf-8?B?QnpJbzMxQThJaTRHQ1oxb250QWNOK09OU3Uyc1lIQkd1RzRpSjc4MjBJZVkw?=
 =?utf-8?B?UzR5YTlaN1NaM2VubHRFRUlFR2FIZ0xGV3lxRDU1aGNCcWNEWi9mMmR6OVdI?=
 =?utf-8?B?ZExmTnRrcXBIcDlGOW1zcUdKT29JdFhFQ2FNeUdXNEhZd1ZnV0IwUGlVcW9h?=
 =?utf-8?B?Z20rem5YTi9ybGIzeGJkb1JWY1pBbG5CbTJwS0E3R1h5ZWtDQW9iNk1BQTI3?=
 =?utf-8?B?TTFTNE1SWjlpd2JzcXUxZDVSUVJMU2xXbmFFNUMzcGFZOGVVRUcxcnM0N0kz?=
 =?utf-8?B?aXlPWnJreHNGUG4weGZOVXlGdGUvaDdaWnBZV2ZEZVUvb0NTM0Q4ZlVmYm8z?=
 =?utf-8?B?U2FSZGhJS3dzQXRsOVZ1a0hFclN1TmVuU2hKU0d1ZXNmVGp4R1lIZy9JSlVD?=
 =?utf-8?B?Q1RpZnQzMzlJSVhOM1Vvc0ZWb1BvOHFydHo0azdNVU50SmRscDdIbnNpSnVZ?=
 =?utf-8?B?ZWhMV0U0U0UzbStnaGtXbG85OGJXTUtOcHdlU1Jkc0l1cU1hZlA4eXZOOG5Q?=
 =?utf-8?B?dUtxdDZPQ3lncDBEMi9rUDFtMzVDMFc0Y2JhZTVZaTV1bFdJSjB4bnlSM2Jh?=
 =?utf-8?B?L3hMS1V0ZUExV0tFNnUxTkJXSS9MQmRIeHJ4aDFvUU1kSk5Sd2ZORXVOZ0xj?=
 =?utf-8?B?MlczMXRKM3dsVHJia1JJOFYwSlVFZ3FZbjdrcGdISGErQTFRTElvMmlaMm9U?=
 =?utf-8?B?c0JjalEvTW1nQlBVbTJGUURwc1FMSEZ5Vkc5aWFmSm45M0g5S2lBWkpHQzkv?=
 =?utf-8?B?VGJRc2FGSHRGR3F0UDZMSU12NFhPSkRoT3pEeFpmZ3YwdEUxRm8xNDVBNkx5?=
 =?utf-8?B?MHJ0Um8zN3VyMzAxdC9rNnB0NXJIWkFhcjY5c2xTRG83L2lYRDl2Vm1HeGRn?=
 =?utf-8?B?TnBPQ3ZpeUxqbEtKVmRHNU9CZCtvY3N2MmQrTm54djYrUG5kU2plaHhWL2R4?=
 =?utf-8?B?MzJpVGpvSjB2ZU5mcVk0aVNId1k1YUtWd1FhclpuTGVER0llQWpzRWhjUGpa?=
 =?utf-8?B?QUVjK2trdHFLbWlUUHRtSEo2M3kxRmNQK09QZk5tZ1VaSytuMzZVdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aee246-ab25-418a-81e7-08deaa945ac2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:52:10.1989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYI634I0xH+kjOqzeiljrHWCsBGTWHj3mRkFJdI0XW5HauXu1YZizaOO7KzR1EN8o3FzAzujbJX+9SF66faSQtTUdtYV9JITtAXUaT23qD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8848
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

On 5/4/26 10:38 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
>> kbuild: enable -Werror for hostprogs
>>
>> [ Upstream commit 27758d8c2583d10472b745a43ff86fef96c11ef7 ]
>>
>> Original commit log:
>>
>>    The hostprog compilers and linkers do not share the regular compiler flags,
>>    so they are not affected by CONFIG_WERROR or W=e. As hostprogs are used
>>    during the bootstrap of the build, they can't depend on kconfig options.
>>
>>    Enable -Werror unconditionally.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> scripts/Makefile.extrawarn | 5 +++++
>>   1 file changed, 5 insertions(+)
> 
>> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
>> @@ -109,3 +109,8 @@ KBUILD_LDFLAGS            += --fatal-warnings
>>   KBUILD_RUSTFLAGS     += -Dwarnings
>>
>>   endif
>> +
>> +# Hostprog flags are used during build bootstrapping and can not rely on CONFIG_ symbols.
>> +KBUILD_HOSTCFLAGS    += -Werror
>> +KBUILD_HOSTLDFLAGS   += -Wl,--fatal-warnings
>> +KBUILD_HOSTRUSTFLAGS += -Dwarnings
> 
> Just to check, is there a reason to keep this and patch 16 separate?

Backports from Linux kernel where they already are separate.

> The next patch immediately undoes the 'unconditionally' claim made
> here. Anyone bisecting through this point gets host tools failing on
> any new compiler warning, with no way to opt out short of
> HOSTCFLAGS=-Wno-error - squashing would also let you drop the comment
> that patch 16 then has to rewrite.
> 

Fair enough.

> If you'd rather keep them split to preserve upstream history, you
> could mention in the commit message that the next patch makes it
> conditional.
> 

I would prefer to, it should make it easier to then see which patches 
were backported or not (git log --oneline). But I understand this 
unnecessarily breaks bisectability, so no strong opinion.

Cheers,
Quentin
