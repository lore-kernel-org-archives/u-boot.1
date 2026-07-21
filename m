Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D50C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 10:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3369F4087D;
	Tue, 21 Jul 2026 10:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ys8eveoPeS2X; Tue, 21 Jul 2026 10:09:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 956014086F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784628599;
	bh=ntG2lZsVhFrxiLgmEkvZQp4ui409IeT/kNoV8OCoRQ0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=N+ndxwZrO6F0f2o1XXen5NdIaYrcdTTAQwj63r+W9hb9WRQoVBs3H645K6fqsYz12
	 N1sxXV2WVC1FDLD44r68hydpwitr5CJzk3DSEBrqGKqtTBUCBgxd2L1KYsiON2w6tj
	 KT1H0AS62TFOY6yYLeCIu3cxt5mLQTv6IDj6f9Us4qxbmt4IVuBjTtcc6/YkZNtlMx
	 RRMtij2Ib3CKmbr1scTS9UhR08/xxJqUbguNXS+uimSUm9MM1SNAsLY7ANySWNbmL4
	 b0R8dhNMFQsvjEkGqBNiM3dS5U5ZMDXrNcokYQcjUPeEmvGoysk+9aW0E5K1/Kw7iZ
	 vqddVckyyP1ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 956014086F;
	Tue, 21 Jul 2026 10:09:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBED696C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 10:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A99BB6072B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 10:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCdcGvCA7WUz for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 10:09:57 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B90DC60639
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B90DC60639
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B90DC60639
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 10:09:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE2D384659; Tue, 21 Jul 2026 12:09:54 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6D6803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 12:09:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eL9wc7xODSXgbJa57Shl3Zg6um/MMXSQJU0q+iImvV9jtHuoYuw9PLHeWnj/pj+2jc5gGCQ1eN96EiI0IANx1ZlpmDDuuNsSDWWU8jkOqiR7IJWU6Qq40QzZmGUUvKce1bjAAU3eXApxm3yK+IjcqN3XJG4JxQw0eL62xNd6UrGqwEDFGFMU07CQDu5MidWA6kKVN6mOVsNkNHo4wo48fCN/j7EOmQuywMK2tk2RTVae0qIaAc1kSyCva5GSk2HLbJ3kAH0DQzYscr1U2hEOYdE4C98/EjSWOlZ/xPgzw1eOFYSovtzH3RMe2nSbVoYtzuy1ECDgMWbNpxrck1YfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntG2lZsVhFrxiLgmEkvZQp4ui409IeT/kNoV8OCoRQ0=;
 b=WCZ591STZh6s6OMxYJCZ2cvqVwwrOKJXKzf1ys/0vSNHfDzjll1le2LsfafRGCjqcwi8h3hEx5tQrnVIOXckCEFYWWUncXIAug66NFuUngwku4Uk4Kf0y0jvVlpV/N1vyjV4dgshkhxtV8zacJUYp2+cSdcUFSJmlXzLdl/ABU1pHalFTJ1AD1zr5dFweWQ0xgoIcOsOwmPMSnLLrc3uZ5Fc/Hcw9erPTR4tPucIjKa135f8lunti35UNrUXfIocscd6qgNfb7ntKdjfXTSvkA1iB8GU0SKHRqnDXfaj63ICBttlf8X/zlk5/HvoORlcBYzH1rp4a0n7t5m/B3IpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8670.eurprd04.prod.outlook.com (2603:10a6:102:21d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:09:50 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 10:09:50 +0000
Message-ID: <41acd701-13aa-44cd-a1d4-caaaba646652@cherry.de>
Date: Tue, 21 Jul 2026 12:09:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] clk: rockchip: pll: drop misleading fout in
 rockchip_rk3588_pll_k_get()
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de,
 Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-1-cdf47f2ca0b8@flipper.net>
Content-Language: en-US
In-Reply-To: <20260713-rk3588-fracpll-v1-1-cdf47f2ca0b8@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0003.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: c79bb2ed-740e-4f53-df5b-08dee7103330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 0KlqvCWyV1+1jTjhAPFMelyxZkdPny7DF1F3QrFcO+oD+7zBbWxWzEagtP2iozi8Ft2yBWDfDrF/F5kg7yL1zMgARHTH9E44MsJDv+RDMyCfTC9XkiuFDzHpwi4yoKXWxlRZWVRZbgWXGwRr/rx56pLkxDqdG6AYk8worUrq9Fq16RI0z9m2s2hKRYNUX2cvD3kxTfiV6Y+AXoF6DMCf84XJcWG76+0/6rR3lxS4URqyzkJs9hmDq7b15N0zpMLrsQbCOxYDlUTY4fePMuK43g2ncWdFVMCKhvmqhivajOwNEEPVH+NiO0zOyG3sFN5TX8JJFtCIPa8QdAB6dVTmV1cistpZoAb9+dfjZKws7FQ09R4YBlqJ1CbyHvumpD0s1Gc6r9Oi8LWfokoiD4gzxWa+tGUtGj219hYHmFcrjXm+vtbhnzRJWYbSEx5A0EgNkktW1Z3iU6j41N8oeT9JkqnSezWnaF5BKqxk/F3LDuTFx/ltqAUz9ZJvgi/uTe7J32WooaO4JylltyRsCaSUkhE35G684xiN0IDoN2Ncy7//wfVIjykMR20angwdDgNNyhZzVHJDCIni2+sLEIz6XXZWcp/MacgjiKnPuP01Wj3GHTIvF1fklWal7r/SZDbnzulurwDVi6SU3i4D6YpjV5jIXW6pOwQ1hCsRYibAv2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFWNkt0aVNrNFhjOVljK2V5amxZdGJ3VUJGb2ozRVcrekR3bytaNTA0dkEz?=
 =?utf-8?B?SUs5ZVdtWmJYRVNZanF0TndWczI3WHZEVFJENWIwOUliSnVzWVkwdU9kU3dy?=
 =?utf-8?B?VW84U3U0MUhQZG1SM1pTR3lXQXlaaVdZYVJSNzZLWHRhTnYzSVZIZldtT2pH?=
 =?utf-8?B?ZENuUmlyMHc1UDVXK0hPTUxVYmtsdEJ0Y0Fzdm9uNkRCdmcxbHpCZ0JnMVg0?=
 =?utf-8?B?YzJMbjZEVTI3L0R5cmNmVDJBYlhrV3lPc3U0bE5OUlNBdVFXWEpVZEtZdVMv?=
 =?utf-8?B?YzErY3V3SDd0aHgwK2d3Y0FLYk43ZXhJSVdLSkNLRTBuNE5SdGxhTXhtRDQy?=
 =?utf-8?B?S0xWZG92cW15bUFSdmhMSHJPWk1BN3dseG9mSDNIdFY3YjRiRlFhUHlxOG1W?=
 =?utf-8?B?MENud2RTbU9FUDVMNUdzQUZtMlVQZ3pLQ2V5QzFBaEVDTkUycUpsL1hGRHJN?=
 =?utf-8?B?QTkxMHZmNFBDSno1cjZDMWZMYUswelRYWXRHRmdEQlRJa1FnOWNDZkgvZi9a?=
 =?utf-8?B?MU1uSGVwaG96WnVmL0YxK3p2elRmTkZ2M1N4ZDkxaVFqbFFNd1lYMlpWMlZs?=
 =?utf-8?B?YWhZQzJXM0NzN05VbnFWZ1FYOXVReGFOV2tITGNKZ0cwSVlORitpNEJ6Tms5?=
 =?utf-8?B?Z2VoSnBYWDd0aTJaT2JyWWFsY0w2QTljdnE5N2wzZU4xWTlxbVVydldqL1JL?=
 =?utf-8?B?aUtCYzNFdFVwTmI4TVF3UGJrUWdTM1VUTlhHcnFJQ3hvei9KT1BRSysycmhl?=
 =?utf-8?B?QjZGcVgrVklJNTNwR1g0QXBmSlhJYi9TTlRjMkZkL1l2ZS9oL0FIcVdoN2N1?=
 =?utf-8?B?ZDIvN0NlK2oyUytpNWpVaDJEWGFJS3NUYlZjN2kwYllhUDdYSGMzZDhDVXZE?=
 =?utf-8?B?OWFTdU1JUDFXS3QrRHhaOXk5YzF3eElFY2ZTV1U3WTZFZmVnbExuQWtiUjc4?=
 =?utf-8?B?TlVGR2ZDUTBwTlRmUXBrV1B0MGhVV1hGZUdldGJMb0sxUjdvM082aVg1Q2wx?=
 =?utf-8?B?STI4NmswMnFPeGdVWTh1VVBYTFpLMGVKN21xVDh3d1FvUDk0Mm5HRVlVZURp?=
 =?utf-8?B?Rm00bng0SEhpYVUwR0VyMGhGU0lqTnNCcWthN2FvZDNKNjVHM2o1dXYybnVU?=
 =?utf-8?B?eWpDRGJPQkM2eG9aQUltVWRFNkl6SHZJcHdrUTY0Rk4yZ0xoWW5FSklNWUtX?=
 =?utf-8?B?a25VeGV2aUZ5SDZxRTFqL1lZcU9VaDF6R0FZbkdUUUE2UkM0SzdpRTFPRlg5?=
 =?utf-8?B?R3Jhb2dXUC9wRkxzYURWRlQwNTlRL05kMDlycm1sMmhIRUFDQmRFQTc3cVh1?=
 =?utf-8?B?dEc5c1UrTlJhMlRjWCtyUS9vcVhRS0gvQ2JtVW5WcWZRRW00ZUs1VWJIeWdr?=
 =?utf-8?B?ZjAvcnM4Tjk2MklmbURhOFprMnA1NWc2WFRERlFEWllxWUdYUThFT3phNGVw?=
 =?utf-8?B?TFFxa3FNeHA0NDg5M1ZGVERnaXplbXVadGJCdzBnWHZMbGlIbDBwbHAwL2tK?=
 =?utf-8?B?WUR5YzRDQU41Skl3d0k5RGgycFZTd1dPbEhuYWVEWGFFb0VHTkRTSFRVbEg0?=
 =?utf-8?B?dXArRktXQ054SitMREVZODNDekxEWWNZMHVNa0htMDJTM2Z2NjF6aVlkOVRu?=
 =?utf-8?B?b1lOMGtTeWxSWFMwRGhtblFrZldpazRDQWhranJCK0xweDIxem5LR2ZkMXVl?=
 =?utf-8?B?MlJZTWU0Rm52Yk1kbHIwUnpwYnI4TUVkVFVrYW1KZEZJUEVkRCtwbkJ2L056?=
 =?utf-8?B?czNTSXZLQVVzaFRjRVo1T3ovWDVRc285ajVzUWdleXdKT0VUK3o3N1oxM2x6?=
 =?utf-8?B?YkREV2czVWt2VVJYcTFmVU5BVUUydlpxR0FUaXF5VWVnaFdpWGgrTVA4WVhy?=
 =?utf-8?B?Tkg3VjAydGFJczc0b1I3cmNONTYxSEt6Vll6cnpOaTBORE1QTFFMM2lJQzRR?=
 =?utf-8?B?VW84ZmM4cGQ4WE1yc0FUR0Q2WVFObWw3SHlVaWJvcWpBblJVK2wwclByaFZm?=
 =?utf-8?B?M2JTTFh3dENLUDlZdTRiMHhWQUxXazkvM3VOMGY0TFg3a2IrdWpObFVPRkRQ?=
 =?utf-8?B?cFZPUHpQNnhNV1p0Q0lReXR3dlQvRDB5Z2lmS3NCckZ0MXlNaDNxdVFOVW52?=
 =?utf-8?B?TEpId3YrLzhqblJ0UHdOR3ZoTFNhUjZmcitoVjVyUWNFa1Jnc1d3WFF2UHFQ?=
 =?utf-8?B?dFFWUmRGU3VxaFVWUUlmZ29hNE9ySDdLeXovYWV4VGZ6K0MyaG4rSDhtSzVO?=
 =?utf-8?B?UUZ0Q2ZrSXY1QmtTMk5Ib1ptbkc0ZXRIWk5yK3Y0T28rdU03eHBGNDNVd2hP?=
 =?utf-8?B?SFJtdWxSRWxJaVJud2swZnZ6NE5obGtnaGdqRy9jenczRXprL2t1dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c79bb2ed-740e-4f53-df5b-08dee7103330
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:09:49.9765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f75xg+94rUMRvTpUYVweuMY+uC9PDBQ8dT0L1iVmINEehAH/oS7qD0ac9fuwnbM3G7PMiDLBLkLMRnKdEE10m2oDTi4S4J9tNB5lb83Ur4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntG2lZsVhFrxiLgmEkvZQp4ui409IeT/kNoV8OCoRQ0=;
 b=ZsEYbmR3twVfvgfrUM5uDlK2etPT4mhyl1qmpm3kpu6mTBNJBMSYOXDlnEhGQiNMUhNJfOustPoPZTvsud9oXMY8U09D/1TmjPCqdHmMllYepNVohcQTVwTU4QAvmMZsXXKjbjS9sxkyoBDVajLhbr6WHqdmbDWdQc3DhQm/Yt0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ZsEYbmR3
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZsEYbmR3"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 7/13/26 8:35 PM, Alexey Charkov wrote:
> The calculation in rockchip_rk3588_pll_k_get() uses an intermediate
> variable misleadingly named fout, which is not the output frequency.
> 
> Drop it and inline its calculation into the k assignment, which also
> improves clarity. While at that, also drop the redundant reassignment of
> fref which doesn't change within this function.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
