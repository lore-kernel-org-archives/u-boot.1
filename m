Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E14606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y33Ufsxt;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=VlMso7ie
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 181FE811E6;
	Tue, 17 Nov 2026 18:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4oc3Qn3PRPk3; Tue, 17 Nov 2026 18:06:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C7E7811DB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794938776;
	b=bnJrNTf55L5cn10puyF7TtFlDFatt6g3ZbLENLUo+K4AbIt/zTpCYOpuaKV9jZOAfdAf
	 xEy6GKKqOBDhKsSCGilKMOE7WDojhmhghgaHG/kfZQz3Zzo+BWcuvHHVVQJ1gQnNZCsN+
	 og3NllbQ9h3wGXi3pkbn8vzrbPKMwZc5vp9/DVd/254z8dYRN4TAQZCCjOsTDgVP9gIBW
	 tUmt/lw/+oajqoKJb/SIzNmqdyflQzoQqnoVfERdWVxpjfUj5t6cfC1YUJt/G+Gr96Qwx
	 lkXJO8+GRkUpdbwcGXF3A88EZ6JkYePUsCOPWXTmG/nqTUnmkbjCC372SYhcdeRvZIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nLJDI6vjsj5s5b40d697FuD/2yPKKGl2pBmnND4GmfQ=;
	b=c+KpiowvE3a9hF5dSLyc8P4QctmPC4qgIliTQR68WUn32RyCkiADhApnVdl9cZIGl9jH
	 +B3o9w2/bSO+wDZz/JJp6kcU674Cj/xgkArXOR5jE7VkWl/pl5cKfvBOGjuVckOWW0WnK
	 L87tyVM7qwSkQQT16N7ewuL+BMSTwp4fcVCwCaECFLK0LpcaiNU0ch/Tk4HnnPFGW2z/H
	 Pc72bzOfhoJmnSCbn6UeYAHs+gZyLONvhlywv1hnQbvXr9Ph9WzkG8hpQRJTv1wvHNKPb
	 mK2CZ6zLme1h/bN+fpnuGzbPyu0vmGctpuXzx2xWOwTOkf//SmbQ9LuKXhOkH+UMIWg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794938776;
	bh=nLJDI6vjsj5s5b40d697FuD/2yPKKGl2pBmnND4GmfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y33Ufsxtu3jl+gP75R9xxvARHHAaZdiQGVJwW0a/2SSDhmP6fmc6Wwt3/IW89Uf/h
	 hWL77VCYox0XrMSd2dGWbqoPW5INdCdGbRqjBLnDIoXHqFwHa6sy8NOSkobeT/ooRd
	 sQOYpbL/SBQgE7PUxZAQW8277ULAaKp9HoZ6atJDDHEtxi93os7rS0Y5wZfHtcqkOY
	 /BF2+LaQqqcxZQDf3rO9Mcn9oXyd81By3jRqr6lc2+PhcIXIvELOFdC8/b/oxqfxDc
	 /zcLOOSLqKPBKSQ29JekAlfZU4la+X7MKC78+ZK/aGMiOiTXex/kyTIZdt95mpiMAW
	 hdIQcQuBK206g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C7E7811DB;
	Tue, 17 Nov 2026 18:06:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D0F29F8
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04B9640217
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:06:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDwhkQY2u0f6 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 18:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AA87F400B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=VlMso7ie
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA87F400B0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLJDI6vjsj5s5b40d697FuD/2yPKKGl2pBmnND4GmfQ=;
 b=VlMso7ie+ChmqCx2nz2M/IwyCFp3eInztuLJuB7TObtS65P4BoehyzfVBJdsU0TB/a8BRbYZRRFT+io8SqlU2I11ATV+j3JnvZFt5bdBiYUiBpMjPkskSKDGTuXBFCn7+LvzbFV2zTH6SoVqolDPC2WFFNE3g12C/cDpcM1d56o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7992.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:06:09 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 18:06:09 +0000
Message-ID: <d4467ddf-13e3-405e-9c89-93bdeb02a5e1@cherry.de>
Date: Tue, 17 Nov 2026 19:06:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/8] clk: rockchip: rk3506: improve PLL_CON() user
 friendliness
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
 <20261117-rk-clk-better-con-names-v1-3-25521d4e37c3@cherry.de>
 <94e836e4-fe65-4891-839b-1998c02c2b77@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <94e836e4-fe65-4891-839b-1998c02c2b77@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0091.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::6) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5b8435-9aef-40ff-fb49-08df44d574c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|261021123027099003|261021121427099003|261026121527099003|56012099006|11063799006|10067099003|261102123227099003|4143699003;
X-Microsoft-Antispam-Message-Info: l/LikIacbMM7f8OizGZo7vT++59IuTCqrrk5Duqtmu4J6ZvRelAB23nL7UucrD5UaS95kYm6oaZR+7+TmnBd2ZIbr4Qr+HH24+7L9ZFK0qonbrP719FJYLeHwgt6hcrn/3cdrtpgOyncoTDmdbcrEKCe7JNUKhyKw71KNtnvmq12l04oGMjCwV7wLYsdzyGxEjUN/kmmC3eCrAAVTiPRG0pBxdGI46OpwWPcmcsS7tGT6S42pf3N/CfQZK44o+TWVfQqMdUu3NorXWC1JLfznuhCxKrc4iXxDzbs2oPzg+UXb4IkWA2ToYcjRnd9bv2Pw7bP9tjt2iNUThO+eOdeGL8lfV+YbW7kg5+OWnJ7+LXk+WxucSizhDWDisHcgeyEnbYe5R3m4/gUeQOpzk9m24oiuJrkGAcrQ6LRH+NcoqkR1eWbIsk00WOPpYnXHGdySL88cwtH7pMzwwqECHnnU+IcOz/nYCqiDuPJHy9Sd1zdIUWq2uUfew8rB6yUhsoHYY2HzsMnRT6rJ75LC3GMnRjT6jhUtUxwrxW9nKCkwmUmTzywiXbrGpnLuMb3tQpQ+e/rMtPsRAkOgB36ORM884Nqru3ibvcOkiKM0kjS0sxODYdddE46O1HDunwTCBuLoCoSfWVVRLdQZ9pynzy9f/DSnecLh5vlZtaXyIBlPhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261021123027099003)(261021121427099003)(261026121527099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9YMkRJdzZYT3A0N01CMkdTNXdCY0twdVE5TUozc05rQUNBTzFLbGdnRVFn?=
 =?utf-8?B?dzhhRGk0dGpTRXM2Vk8yV3g3K1Y3bUU4UTcrd3N3ejEyeXpqdDZVdUlreVo0?=
 =?utf-8?B?SnVQemU1VVBrcDJITU9iSnc0OTY2bmd1Y2dPNHl4T0pIUk41c1g0MjNyaVVv?=
 =?utf-8?B?cXpBc0R6T21BY2RzbU1jeWZGWllxdEdhOGRtS2hDZ0x3aXpmcnk4N3ZPT25U?=
 =?utf-8?B?Vks5N1A1UVBJT3lxclJ3TzRySmVTNXRocDJRamtUVGZXMkFnOTVHV2NySW4x?=
 =?utf-8?B?a0huY0hib1dxbHZHcWlBbmFMU1NHbi9nMGY1V0FuKzhhTHdPWXpwL2dYSkU2?=
 =?utf-8?B?RDFyWnNrMzdvMHdFVkN6dDZ2cFNlMEE5Tk5uUElLZmt0MTk3QjZxdFJHaDNE?=
 =?utf-8?B?dmoxczZOMzBtQWRES2hVdElsaXJIS3dVR2pSQ0FCa21KQlJRUldTM1VZWE5r?=
 =?utf-8?B?eG1aRFBBc2ZLZ3I2bHhnZUxPTW5aYWtWWDZQWFdRZktXVFVoRGs4UFRiNWlq?=
 =?utf-8?B?NzVTNnlSSlpxOVlaaldOYzBQRjdEV1hsVldlaTdGZVErTlpJV1NyM1FHTktL?=
 =?utf-8?B?MTR6c1NkVDRHT2pWTzJpQm5ReHhKN1R1YTM3UDNQWncwN3NrRHVXMFBOSTZr?=
 =?utf-8?B?OVBGS3g3OTdtaWpVZGJpZG83V1ZWT0FpaytHc1NUMDBhTlE2akZhYjJQMGRG?=
 =?utf-8?B?VUhuRUozaWVDVWJqbTBGT291eWVMMjk4YXJUdCtzUkFYNElwVjJLYzBpaFpT?=
 =?utf-8?B?RjBOcTZlbWdYQjlQUGZPMy9nTGZCYjhINHozWXRFVDQ4cWlSWEFaQmdHZi83?=
 =?utf-8?B?dndXNTVkT3VqdUxhMzVmYU5rQWE0V0dEcXJvdFZ5NHdsSjJxVW1nYmFESVd4?=
 =?utf-8?B?TkFFbUF3cmttbm04MWRUMXVSV0lkZklDTEhBZlZPbHlxcVZoRU1DZG1RUzR4?=
 =?utf-8?B?ZUw2TWhWajZBeE1KdHVjY0dKOG5ydlNQTUpWNDUzUW1zMWxqbmVGSXRKL0xZ?=
 =?utf-8?B?QkZJb2lrR3VjWFdCMkNoTmIwcWJXeVRMOFJrQVgyOURYOUcyZ21ReW9ZZ0Iy?=
 =?utf-8?B?MlcrOHlaMzFhMmdLbzBMUms5R2ZwU0xOTm5HRjRHNjZLVCtEblMvWFBSdUY2?=
 =?utf-8?B?dlhiMkJrT21yMlM2dHFqTDVnMEkxM0l2dS9IUUkyaHZpSWxiVFFMaURVOHNE?=
 =?utf-8?B?cnVuNnB1bXA5eWxidmxaMHVyYmk2MlJ5LzllNTFka0d6em5OS0FXWDZLcG9p?=
 =?utf-8?B?ZjdMVEZZR2hzSmVYUm5hVWkyODdBRk9tS3NralhocmlSTDNRTHArcXhtZkk4?=
 =?utf-8?B?cmhpN3VZbEhzYU9LcDNRODM3VUl4R2pZRWpXMDQ2N3ZOaGZoOEUzYlk5VEMr?=
 =?utf-8?B?TmF1VnM3azB2Vm5QMVM1M0FLUGFnR25XQUdWNXczYXJmT3gxdWo1dkFIQXpG?=
 =?utf-8?B?OG5vYlo3bDVhcmhZN2QyWkh2R0FIRUM5aDFVWFo5WU8xWTBqODRjdWJYUFZW?=
 =?utf-8?B?b1dULysrbDE1OXBhelFYaW1yR0JrUDBQMzhLdndTWk9UVGNSWVpNMGcwVnE0?=
 =?utf-8?B?OWc2KzkzNG9hVjE2TnMrR1NqQlhXRFJPNndIcTc0Y2czR2hXTlBRVEM2VDFB?=
 =?utf-8?B?dU16b1VpSVlXU3RlV2FNT2hLeWJoVDNsQWFWVGVRTWpQZ1Z0dHZCbjVCWTBa?=
 =?utf-8?B?QlVqYkYxbUROQmt6UlF3U3FuN2NTUXNyd0drRXNyQUFwRVlqVk9GV3lmNUl2?=
 =?utf-8?B?TUVSb1FXYkE3MDJQcTg2dFA0eFpYNitJdWVlV2V4bldGN3ByOFFZSjFHOXF1?=
 =?utf-8?B?YVlkbzdXSnYvQ2haUituU1hmdC91UjRtMFZJbFNDWkk5K09ZU05mYnlmUnM1?=
 =?utf-8?B?aHdQaEhGK2x2b1djT2RFTmJ3MStBL2tMMHVXVFcyWXNCWmdKandIek1zb3ls?=
 =?utf-8?B?MzBPWjk4cVMwV3ZGS1Awc285TzBZREFPVWh2VGF0V1JRK1hsbENLOTE3TU8z?=
 =?utf-8?B?eWo0cENkcU03d0R1dS9tRFl2TjZKUVdpU2VnRWdGM2N4SlMxRGtrcHAyZnlh?=
 =?utf-8?B?S2tSQzRCa0k3eGk2MldkZllWY1Nwb0lwc2ZXYUZRUWp6M3l5TVpvdk50Sm5C?=
 =?utf-8?B?NzZCVWVlMVNBd3kxR1Q5dFJZbkQ1SThXSWYxZklhc3ByN2pkTHBKMHpuZ0hK?=
 =?utf-8?B?bktYQldHbWNpcTY4bHF0YkhheGx0L1BXRlNTU2ZMMW1HVG1vSUU5cXA0TjZr?=
 =?utf-8?B?VUcrRHZWbUtVcW1ZcE5GSGlPeUpvajlmdjlFQ3FPY2JxWVg3S2FjNS9sWnFt?=
 =?utf-8?B?bTZPbDg0Ylcva292dVdBUk5vREcrYzFFcFB5K2pIWXRjRFpRMnM3QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5b8435-9aef-40ff-fb49-08df44d574c7
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:06:09.0030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXbP23LKUzWCn9vcTwwznisczz5Y71Gfo/FyGl7MydEZGbtvb2QbK+DH3WD035ZCl8e1kHn8QDKPkPSIN2z8Q6h4bAjDwc4G55Qhq5wgXhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7992
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/17/26 6:59 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 11/17/2026 12:37 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> There's no PLL_CON8/16/24 in the TRM so one needs to do an additional
>> lookup the header file to know what exactly this refers to.
>>
>> Use new macros that reflect the names used in the TRM.
>>
>> No intended change in behavior.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   arch/arm/include/asm/arch-rockchip/cru_rk3506.h | 4 +++-
>>   drivers/clk/rockchip/clk_rk3506.c               | 6 +++---
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>> index 9ddd6215fc53..331b100ced54 100644
>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>> @@ -48,7 +48,9 @@ struct pll_rate_table {
>>   #define RK3506_SOFTRST_CON0		0x0a00
>>   #define RK3506_GLB_SRST_FST		0x0c08
>>   #define RK3506_GLB_SRST_SND		0x0c0c
>> -#define RK3506_PLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
>> +#define RK3506_PMU_GPLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
>> +#define RK3506_PMU_VPLL0_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0020 + (x) * 0x4)
>> +#define RK3506_PMU_VPLL1_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0040 + (x) * 0x4)
> 
> Please consider something like following:
> 
>    #define RK3506_PMU_CRU_OFFSET		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE)
>    #define RK3506_PMU_GPLL_CON(x)	(RK3506_PMU_CRU_OFFSET + (x) * 0x4)
>    #define RK3506_PMU_VPLL0_CON(x)	(RK3506_PMU_CRU_OFFSET + 0x0020 + (x) * 0x4)
>    #define RK3506_PMU_VPLL1_CON(x)	(RK3506_PMU_CRU_OFFSET + 0x0040 + (x) * 0x4)
> 
> That would closer match what I had prepared for existing and have
> prepared for new SoCs, i.e. RK3562 [1] or RV1126B [2] ;-)
> 

Yeah, I wasn't too happy with what I came up with.

So, I'm actually wondering if this is just wrong? Shouldn't we rather 
have a pmucru driver, separate from the cru one? Then we don't need an 
offset relative to CRU_BASE, only from PMUCRU_BASE (so the hardcoded 
RK3506_PMU_CRU_BASE - RK3506_CRU_BASE, or currently 0x10000, can be 
entirely removed). I briefly looked on linux-rockchip ML for an RK3506 
base DTSI but didn't find any (but maybe I'm bad at searching :) ). I 
think this would align better with other SoCs like PX30, RK3399, RK3568, 
RK3588 and RV1126? What do you think?

Cheers,
Quentin
