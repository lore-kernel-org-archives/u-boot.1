Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239A5CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1D0D80E2B;
	Mon, 28 Sep 2026 17:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BXJA2pp_29_0; Mon, 28 Sep 2026 17:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F0A6B80ECF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615099;
	b=l794BVZz4K1BfcDLFbByplVgNDoXH7URronxqnTvficThK9L4kQnqB6J52YTPQz0g0Pz
	 jcPqBdrwi+u0jb4RBYq4jGTdK7jdUyHs1F780Rqw4nd6K8svsJmV0WXpgbf+O4CFQJpbC
	 RQYE5OzOKIsfGoKHRMMohZDZ3Y67IsFcO1SYc0ohhqchl6LW6TZDWQK/gLgbYyiPxAnya
	 PhlHzerBVjVL8iFYWcgwSgpYhlCY2BxwMe5OrrEVvHWvPH/zIx1lv0Z/BkKa5br1EXR1m
	 gOwKS8qmp+/pSKxoBl1kgS3b6H92V4eHnKLY1DCWuuDRBCwF7AK9JghwbhW1qVJIjoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615099;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oWAPRlldcun+HTW13WcICtXbRpqwKelKKCic/3lAsho=;
	b=rh71HF6T0QcfjnRllMDS+IbSbEyAiEqUP1ykQSWyuMi+s6HctSfOoTKI2WptlUyZQHo+
	 2lkzNHoYOFawFuaHrb/mWA3Wx0aJVfUx1eaZPc9FWkpg6jITnpoFIApPVtCBVO2OuDXcP
	 9AxUU/Dh2hi/ns376A9mwMoI0SZVWaw1LCVPuVfSsjLjabye9aWE4IKacE9G1UdrrxdjW
	 G7HdBPqqhlwmfMicmaaZ/rpQ/r4wxfZ05vovjQbbCKUGVmwSknPy/37vElbI8+sS9y6yk
	 WWxl29qWAJ+UocTsmaqjzRFNRdGz1Orz4dltdzTG/O8oRYyaZnO9Hdpx3DcwyMvpgdA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615099;
	bh=oWAPRlldcun+HTW13WcICtXbRpqwKelKKCic/3lAsho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pt/CArkwwscIhyDYSE2ud6zvK/H7mkc/5v+8VJSvAUE5qOxctkSbk5q8b6irpP6zU
	 eYKeCL9Zii09mvAmu/ZXbFh73mOWw/UG7FmHJwnKH0iV1msnQe8rWiye8j+/xpQ0KQ
	 ruRi6BvPBs+cYFPFJRRjZmBZQUhTBLOzDrQFL6wsqXafHtPgRAtlqnVSAhWB+5Df5P
	 8Yo76eJwUINqH2mDQshUMRYkEszHxGZayPLPAWsKK+mJnvCv9yvURGREaiG5kakuZA
	 9NCW2ASo6RlixFCPVU1c4M1snfnLXgIRvCGEcGNjYpGqV3DexUrxRJt1bUZFNLT9DU
	 MPTRztZ1Eh3CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0A6B80ECF;
	Mon, 28 Sep 2026 17:04:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A07B33D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 866C2400D5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:23:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RW2NyIMYtH_b for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:23:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2D74A400CD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790609038;
 b=ewqxXA4TdEI5CPtyKuBwjislQAphnBvLyLTTn08jg+5O7L8g+s1QnyBuf8JcrR2akUnJ
 xS5U13xFbvdJs4BvZco8tMcNora0mAw5mIojyNoUfABrs9kzoChAe9+EP32CcqedjbWg7
 4NwqNSYQyOBMpITxqNUlqvdaIowDygVB3uAyTw4NpFrZF2bAa5y2UbOxvvBcinHdnl2oi
 6Kr5oVN+XioSGZBKgP7WdzTEaCHcJFZx1UleSS+RFbAaybP83vYHD1MXDX6FFYkdbyqhC
 WXH43W58vfe77PaLo+eDmee6/xng2rd47QKbLeZ+LacN1uqBx3wjcKd4m4+JBRTjCJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790609038;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=oWAPRlldcun+HTW13WcICtXbRpqwKelKKCic/3lAsho=;
 b=QUrzz3w0jqrkv+S/b6wCHwlsZYpiwJlqJqQD4JpPa45G+0DET59o/OfT0YOZd81Cy86w
 m+LptuHMwKSavxBa1b+k9gSKUGf9zmYi6hnGkYv2MgTvxIwFYTLsoEOm78b9phmsm/AQA
 e4GEBzxyj46zJ6hQsqnlfDpM1VqUah5YF3EgFiscIB05YUMQhAcM7+qcEm+OJanlEDMM0
 WxnLGgCGoRjezyTsBZ7lyadWjFfIZBpBmTIYFsaM0+lPe6MtvBFoegtL/VlAtfayh5qS5
 5TRc/N+nXJ3VSYrT08of0UQo96HqLv3ttJXdTxiFwBmlq/10rVrcIOKvxYRqCgfAoGg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=PDR7uHef; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=PDR7uHef
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D74A400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eao0W0ff+roKoLP18FsWIUVpa6ofgmgwUu3f09OQ7M4L+OdXrqIT2dimwogGXBVKcj7aP6VLR6xXa7FSle0SfWtOH0+Q13aT1hD3rvqfSmD0+OqssiPViQ3WvAQ/qseMS2FuqumGNziEVLHDUswFWYZRlVRtyuEW90mRCRkjyE508+/5Rmh0nqP4MWAxEKojRhxdVT7MfBxy1m6Bl7gkw7xfzkjUhCdb9IeCo+0/AU8b0bbvD+d4e2Om8tnjA/FQXN0lMdnQuE+EQ9d0otYLXw0C+edaZUuJpd2rmGcaI0s7fDJREKExvyOni/dUtLjAIi7sdbu53T1ws1R9YqOvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWAPRlldcun+HTW13WcICtXbRpqwKelKKCic/3lAsho=;
 b=eoZNr24EYolT1xGs05eoCBPsahTKQ0/E3kuvYEWYrlAgbuQ4Vfb7NiEhRz8iL2bvYjy4JX/snJuRUVp0LGqEpfZroh32vcgYEH/+5y6t1MjRkAj+yu+HbC/8ZImiCFea6uwHdJrjXQ1xHB9+wO3yyNHbEKl3dRQec1L/7t7FYjEZB0bv/NpNT/2f1Kqkp2RMEe88jJ2XBdbR4ykuxhzfGYzcNGKDBFmmd3un1yTTta+rJe/mBsBhc5g2I4wdBFGKuuZ/fTQjgM3vhzjo/4OKE6/X7L1GdB7MYmQ1cB/XmVRB1RpyHDabrmxlot+cUgMatnvHiK4OJqX3z0NZmojYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWAPRlldcun+HTW13WcICtXbRpqwKelKKCic/3lAsho=;
 b=PDR7uHefV7xr4x1KKFxdo74giN6gGyEKdUyzxh6KOM80G3gezD2Y33wFOGD4T97y5cvunPQKg6iSF2uhlK+iSMvd8dW8jMLw0NsINJT+QD1kwLIbcTu+Q5eIfx1Eige0ZgYgRyXtCEANTKWEObBEollP7gsryWt0lV6sY0Lkhdw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:23:50 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:23:50 +0000
Message-ID: <5b16c8f5-0696-4c40-bbd8-0475302361ba@cherry.de>
Date: Mon, 28 Sep 2026 17:23:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] spl: Decide about Falcon mode boot only once
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?=
 <joaomarcos.costa@bootlin.com>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-1-acb97c172993@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260731-atf-falcon-v2-1-acb97c172993@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0098.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 4decfa9f-bd05-443b-0e15-08df1d747f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|5023799004|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: +9afMKVxydrNjHqov+pd6zE+bghtQgHpyuAvRmvDe+XM8+I28t16fK5symKrlcdRHKGGtm73mf4rC57IdMjg9nrY0Jdz651tknnCBM0oVlVBFYb3Ms4Kug2lj1IE6D5WH2tT2jf7XV6GU4IRGjQmUNN33UbsCAgMRO8InkatNALUBpK1qSuv8dBW6dMyoFQEZ+PNKMi6pq5OAQMbRrSfRvzsIDR4N2Meg7R0SWEJC4Er4e/zOIOQPXN1gSUU3KceGJd7gBJhx2Kdygt1pU0KGpIBA/aErg+OS0PTJMthYrPLeweLJu7pB6JJ3H2Gg8Z0p50Y8+TX65emRNN3u/2PJXUpjJA5+ZJQibi2DIPn1XVGLGT+Ngq8ebbtAlpdozqNf31iG+rRvZC7WBxE1fg1SDdJmsZNKxwx0NYB/30suksEvkPUVZHRD0jw0waq3sV6A93Avv1CUWNmMS0SeNhcbb/52BGIqHA9gY+PeO83M3llzPMuwYUmQWqJuwUbJx9bnJ1OJoVLOtJCH5vyeVcT12LebKquHyNFZC3bbg/ZP/kpnbeouf8B7GhdnWnieNZlYrUnvuJQy6qtV3496X7NaZTpEOd2UeyADgh9ycCvQB/8T7viOhrCRhmBAaanW6T0rYY45EHAPUp6nCAyutUZCBLob4anJ7pogLRKna6TKgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGM2d3lEVE1Fd2VUUTBueDZLS1RwQU5IMVNObER1aXBRZ3NsUzFESktHYndJ?=
 =?utf-8?B?RTFXRFJaRHYzazZoTkM3L01nNSt2ZWZBMThlSGJNVCtyZHBxdGFCSWxxQ0pa?=
 =?utf-8?B?MTNUUEhkNnA0c3hUeUVYdEswZGxwVm9RVVRkSmZxckJvZ2tkcjdVc29UVndh?=
 =?utf-8?B?YXc4VXhiOVdvUjg1S0NudU41N21zVi91TFcrUFNYdFIyTTdVdEVwWmE0S0Uz?=
 =?utf-8?B?TmV4NE44ZDk5a0FJT3ROdjBJb2ZqQzZtdmt5aFhQRTEwTThxUDl6ckkxTFZZ?=
 =?utf-8?B?VEVZK0RiK0taWFJLV2w2TmtkbHZCeU9ZYWhJa2syTE5mSW4wUHUvcEVCVFhM?=
 =?utf-8?B?Y3pzamFmVXVXN0wrWEVmVlhBeDFERTlQVFVzNTRxRmQzN2cxb0NFQnFScDBC?=
 =?utf-8?B?UDlIL1BWQVVkbnE0bEdqZzVRaHh4aHQ3SFArRCsvem1ibjFjTEdHbGYwQ0pD?=
 =?utf-8?B?NlFjbk5RakdYeWEySW1pY2RUbXJFVkdCMlZ4Mi8xL2hEM3M4cnNadzhYS0hS?=
 =?utf-8?B?RzRYVmNFS3FhaHVnczlQUGRxaTV3S0Y1a1pERlA2VWRUblJaZ3I2enBjY0pv?=
 =?utf-8?B?N1pqYklIb1JUMXlZeEcyZEdtd2pud0JicXRXM3pqOFBpVDl6QSt4bU9SUitZ?=
 =?utf-8?B?K3Btc3dEWHpJVzRycUo2QnpoaFRMeTByckVYdnVTNE9wcHovMDhnRTNvNkQz?=
 =?utf-8?B?Z2QwblVvNG9kWGJQbkd1WVpVclRQTFNRSHV3VHFudzJTdGFURC9kQ3MzaGg3?=
 =?utf-8?B?eFRvY3ZhK2x4K09oMGxWSXUwTndvNnR2OG5ra3BWMEpNcktEYU9EVEsxSSs1?=
 =?utf-8?B?ZERIeU9sd0JjaXZCdGVkY0ZMZ2Ntd1ZxTUFlT1BqSDhsb1VUQUNIcHZGeEtM?=
 =?utf-8?B?Y0VEYmJzSE5Rb212dThZc2t6aFU2U0dHOXFKZTdrUW1hMXVBci9lLzFNZ2lz?=
 =?utf-8?B?RVczOUFoNE1OTHJpL2tGWnNzQjZ6Z3JWRENoKzcyblNTU2FlRWZyUEVJL1pm?=
 =?utf-8?B?TnNlU1g3aGI1a3AyM2dHeC9jVFhPMWRWeStSdk11WXdNOFR3SXAwcHF4TUtz?=
 =?utf-8?B?NjlOQ2E3cm9OamNWdU1ldDR2ZjZsWXpaU0E0K3RpVE5raEY3WmMwVDFKK3lJ?=
 =?utf-8?B?dVoxZkkwUWoxUm5PSzFFT0pqck1ZQkVuN3FVajRXMzIydS9ROWNDc0NZMnVy?=
 =?utf-8?B?TzYyME1mSmJub3JYTFBhck8zNnJLZ0pFYWVJaDhGeDhOVkVjczVPN1JCSk9I?=
 =?utf-8?B?ZlUyNUgxSy9QTXVaK01Dc1NnVWxPVVpwN1I4aitaQjJDM2JlVm1INGp2eFY2?=
 =?utf-8?B?bGx1ZXF0SXJ0Z0dZNWZxNnZkWHBiLzVYOFRoOXZqTGFiVmtZb1NQZnZFRVNS?=
 =?utf-8?B?c3JUYXFnbDNkMG1YZFdORlg1RkhUQ1Z3bVcvUEtiVEJ2U1lVZmp1Qm05VFlD?=
 =?utf-8?B?aGFZRHIrekVpa21EQWpoZUkyNUh5SFFyT2MrSExuem5RMHpLdDNadWpBRFNX?=
 =?utf-8?B?Z1F0UXMwb1JXU1ZSOGtoT3BUcnJxZ0s0TUlVMklSanIvd0Q3bjU1bzd5SGZr?=
 =?utf-8?B?MlNQSUxpOFFDV3pJMkVtWEFOSFdtSEJuUjBZUHU0Ukp5K0JsTVRJTWwwd2c5?=
 =?utf-8?B?N3IwaXN3UWEyQkUrZEMrM1RENE00M21Eb2VYSnNabUZTTFRyZERxVW4xdzVW?=
 =?utf-8?B?bWoxd00xZ0tlTERYWmY5ZjBXd21VMUJYZXMzT1FXbHNvTENvTXB4bnVRR09C?=
 =?utf-8?B?S0h1a3hjU29rcnE0MjVSZ2xJV0JvVTUwWmhDSEZGZmRmaU9hNGl4K1pNR0s3?=
 =?utf-8?B?L3I4VEtCcjdScTZackZUSmlCaklLV1R4Y1duaUNvQnRNMFEwSXRyNTJhTzgy?=
 =?utf-8?B?MDR3ci9xdXByTU9GM3Bkcm1NbHlUcHFGWWZQWXZZTTJ4cG1CeTZ0UDl2SU85?=
 =?utf-8?B?Y0dCeFJXQndxVEh2eGdxZWw2bUdTcDNtVnB1Y1hjUjJsSFNqWkFQSU9Mc1JT?=
 =?utf-8?B?aWhQMFFEV2hMaWs2OTRucTVIdWZDRllXK0JZS1NEa1FJVlZaYWhJVGFvNG04?=
 =?utf-8?B?L1FqYVBFU3QxSFJFdy9zZkVuZW5lUWRmYUhYVzY4UENtN3NQeTB3aVNsWE1Z?=
 =?utf-8?B?VkFjUElWUHJOUkMzTE5uNzVuMFdKVDlLWXVQNHJtaUVWZU1COXVuNzBZZEhC?=
 =?utf-8?B?S0lrOEh4bmp0Rk15UUxZenEyUmM1VUVxYjBVZUVDdWxpUFovYXZISWUrRW1y?=
 =?utf-8?B?cjU2dUJxckpvNzB5ZVNuZ01zOFhxTG1hL3lWdTlIdWZCaHh2bHRCRFUvTlpQ?=
 =?utf-8?B?K1F6cHZMbWl1OUhtOUk1ZEVtdEhYSnhkWDh4TEhaa21iMTB2NW4wQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4decfa9f-bd05-443b-0e15-08df1d747f7f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:23:50.4034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJiJiHsg7EKdf0gt81gAj9zpMI0vVcfx+u94imrbVGNgAJtehpRm4pPudO0QmW0948hclIesbtbnekJU0ULa8DrnhQ9jm4RoHPNFqRa8xPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 7/31/26 7:10 PM, Alexey Charkov wrote:
> Board implementations of spl_start_uboot() are not required to be
> idempotent - the documented examples sample a GPIO or read a character
> from the SPL console - so calling it more than once can yield different
> answers.
> 
> Add spl_falcon_boot(), which calls spl_start_uboot() at most once and
> caches the result.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   common/spl/spl.c | 18 ++++++++++++++++++
>   include/spl.h    | 11 +++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 722b18c98edc..abbd56ca2fa7 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -105,6 +105,24 @@ __weak int spl_start_uboot(void)
>   	return 1;
>   }
>   
> +/*
> + * Decide about Falcon mode boot exactly once per SPL run. Board
> + * implementations of spl_start_uboot() are not required to be idempotent -
> + * they may sample a button or read a character from the console - so asking
> + * twice can yield two different answers. That matters because both the loader
> + * and the code which finally enters the OS (e.g. spl_invoke_atf()) need the
> + * decision, and they must not disagree about it.
> + */
> +bool spl_falcon_boot(void)
> +{
> +	static int falcon = -1;
> +
> +	if (falcon < 0)
> +		falcon = !spl_start_uboot();
> +
> +	return falcon;
> +}
> +
>   /*
>    * Weak default function for arch specific zImage check. Return zero
>    * and fill start and end address if image is recognized.
> diff --git a/include/spl.h b/include/spl.h
> index 5078d7525abb..8da82e87aa3d 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -757,6 +757,17 @@ void __noreturn jump_to_image_optee(struct spl_image_info *spl_image);
>    */
>   int spl_start_uboot(void);
>   
> +/**
> + * spl_falcon_boot() - Check whether Falcon mode boot was requested
> + *
> + * Wrapper around spl_start_uboot() which calls it at most once and caches the
> + * answer, so that everything taking part in a single SPL run agrees on it.
> + * Prefer this over calling spl_start_uboot() directly.
> + *
> + * Return: true if SPL should start the OS, false if U-Boot must be started
> + */
> +bool spl_falcon_boot(void);
> +
>   /**
>    * spl_display_print() - Display a board-specific message in SPL
>    *
> 

Is there a way for us to have boards provide an implementation for 
spl_start_uboot() but have it no accessible anywhere outside of a .c 
file? The usecase would be to have all callers be forced to call 
spl_falcon_boot() and thus use the cached version and avoid side-effects 
of calling spl_start_uboot() 2+ and would make sure we can never have 
new callers of that function.

If possible, then please migrate existing code under this new 
logic/implementation.

Cheers,
Quentin
