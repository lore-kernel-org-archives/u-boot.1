Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF3BCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9945181160;
	Fri,  2 Oct 2026 14:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZjZXXV0VrMd; Fri,  2 Oct 2026 14:23:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3FDA810AE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790951036;
	b=LXnv/n8rYnlI8/MMsYDcSJD+ouKzHyC5oGzSzxn956Gf9Js4/nlIpXFdNxbJGlVwUsJL
	 /uYS5TplFV0LJqhxa7SUwALQdFeAaztiPXvHU7Ye27ZfLMNpDN+sjHyEzFQDo4C53bFlk
	 zuUZV+aIfe8jEMbZ0pqU5vMGXUaOVQgVIfBOljpI2hC6Xp/oi+MpHoYOJOpU1DGF/z75p
	 Vc5Zk5gCNVRflMCgxJghT8/brq3OgEivrMAjGLgHws8MHAJCwAaVDVcbmrehX/zXIITo8
	 EIG33o81Aq2H7T0y+qTE6UPo+U1uTe4W0vfwdgPaZFIHlHtm3azmPiaKFdX8zTAJvBg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790951036;
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
	bh=UkIh0V+qlso2klnXyjFy6RTAkqFV8V37B/PEJCyT/n8=;
	b=oC6n19pR6erDrIGSPys56FZwvgXLKgp8mFlud1PPfvF+r5fMKlWi/qxdVMpATl21YTi+
	 HQM6o9DteJT4z5SADBunrTuczxcxSYaTeIBqRI5KQ2Q5F0thTTHYA5wdARzHdNDQtapQ+
	 payUqawO2DLCByqdQ5/zazXUUJW+hIXDZYgZsPj/FKIFknH3c11vUq3aAFPgiXhleTna3
	 ORdZFj3LuEgwB61SOaxxN0IhFDr/i2dfe8kIxWStrs6QLOa6ND+7onE3dODSk8a5P096v
	 lwt0m+nK5+mWUwNqjFVgYYAV1yWJCTtMT+YZBZhgZ7fUC2nbGdVh13YgbLA6oE+QyFA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=XV0IcQw0;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790951036;
	bh=UkIh0V+qlso2klnXyjFy6RTAkqFV8V37B/PEJCyT/n8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZvMPaqfy/tzsMFiBTC4x3YZBN103W3CsCIGENFxbqvN7rtSQtx5lbZZmIu9T23ny3
	 iEtgDxyhZWFSvpdOfskYdLovoXG5mqb9Kmn1cmq40mg2JKNwpTkuiOqHQbAgbEXAeW
	 daHnRbek67rxu9vnzSne5lOmb6c4V9Fs0AWpAYOw7iwsB/HTO3mAd34km6pn3Y0myo
	 +ilPIY5zXLWRkgqtou34fcM/g0mFZkm9TY+paa5XvEt+LGFD183NyLHf3PRkLekkif
	 kVAjHCIqnZz0jwyUsZTIHmTlbpS7GgGjBqd44+ATywnDzyYE+Nk3Msneo18FRaEh2z
	 QUA7tK45UevYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3FDA810AE;
	Fri,  2 Oct 2026 14:23:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E82B534D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5816810AE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1auVEJhtv3ts for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C1A298101D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790951035;
 b=c9/n+q5LHDpRZhmJh/qeR0AErzuBt2bh3CBzvZTJGOgzxs6splj2ow7QTryPsfP81FYd
 1cALHf9HMPsKKwj8HVRVEqTrB4tEbXNGQqvDD8gpVF1KoZ5ZQTo1Ey4WH936MUkK8m5b8
 zRshhUR8buky/OXQS7EKNhyqag5s5IWocybFs6cr6+Yre+x522G5zhltyNx6LTNUvnU5U
 WOvPAIm+1zbp5aZZsLvJH8NaAkcwG5xx7QSMBbDqGYUoO3Nwyyk7FexGzAZjQVf/tC88j
 ro+/jAvm6yzkBSnYiUWzJSQBTk4RZfxJfuVEaVFfrazceRjxPs/q4cT9YyvPHlpl9FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790951035;
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
 bh=UkIh0V+qlso2klnXyjFy6RTAkqFV8V37B/PEJCyT/n8=;
 b=rxA9HVRWcVsqPfVnqsvSihfWOdG+bZ2p75Pan7iIMKkO2g5PUNexn9iCWnhV6AkQijrw
 jEZQOAdwZIFMQjORwZujRbzjIxF7FGe/MsNvUy4/0+fw7J+eiJzisag9d3jAnv2yjIBYc
 Qrw1Va3F7pcmciWTrRy+SYugXVQg7mxdsU1jw+l8tbucybPPUBI5ld35joKxtN1Mfffoj
 8Epxrq0ZxaUe4jRgjjI4xoxURw67BEsHL1H/Y9Nb57olLJsyZuv/hMOVsrd+V1Euwx1Uw
 U+/B/bUxa5yKuNAnDKeixrqxl48HD2oxGki1paDhNjsy9fi/yW5nExPGuqI/oaOXEoQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=XV0IcQw0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=XV0IcQw0
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1A298101D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPUppCcjebSkzRfdNUmiU+kUfbLzg3I86lQD5rL3OwCujeWBNYqo8oV8KhEaj39bIfzrbmrw5FGBaz6sWP/10k0kKGZftR18lILzP/FB7bSimbRbatWhHYI1xE7vN2nKZl9YGLD0O+SSVjgU2ojo0OY+cjm4Zz/qD46nrWvS41TDPsBLEwa0MtFBcTY0L1ExmLbm/CRbR2WzagHdgRyO8QS7oCyshkQ1tQuym0pFXQfARiI2T9kkZdfIOeSx4ZYSKwe14UZ04/p0xEllCJf+5yAIEpD6tC7XDQ2Q6VR7PvWrbcYMJkXlnevCH2EgJoTFE1q/pXQDbTDLCk6v2FfvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkIh0V+qlso2klnXyjFy6RTAkqFV8V37B/PEJCyT/n8=;
 b=I6L9t9Ty+F/x3M+FUHkgZMc47YChqWxjs1siOwZNn5J1gBY+JnZ+0UMTsrYWhZ20yF5TZ/Ey8K/gNOUH9NffFdQOsUhZt7RTw5cVSQT2JY84nOdHfUIhFaNXbDFiQ5JqTbLAoKWX0/f5Ce9lQkVfEzM3bexmQQjnu2cdIjinhmxsY65Kq5eGRnQTb0mK4DjvBaDRCcrQTMw+5cc4DEjkNuqMj6qydiEhpx5imvMNfsFuLZlnS/Nh1uR7DmvRkxHy8ChoZuYW2mEHfAkZgqjDR8nBj6tSWeFJytNyZlse6vEgO3Jnc7BZ8qLRXn2YzL6gxs9aMPxe/DAHa6y9vvkmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkIh0V+qlso2klnXyjFy6RTAkqFV8V37B/PEJCyT/n8=;
 b=XV0IcQw048DnUnBeh5TGZwfj1yMyBs+nGtpctUX+sZe54bXscep6uxmGvz1BhzKbkyIOvg6ThpbZTVXbAYLOxL9ZwnBFikgJfumt1xZDtVuFrMe18OQ9995e/Mlynn9aqfRBXWxgbcpnVExfeaGbdY0cOVfbifxD7yHe616huWo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 14:23:48 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 14:23:48 +0000
Message-ID: <82665e67-f364-4c7a-906a-729f1c99f903@cherry.de>
Date: Fri, 2 Oct 2026 16:23:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: rockchip: Add Orange Pi 5 Pro
To: Dennis Gilmore <dennis@ausil.us>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20261002031334.3285687-1-dennis@ausil.us>
 <20261002031334.3285687-2-dennis@ausil.us>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261002031334.3285687-2-dennis@ausil.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::8) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff18d89-f010-4f7e-ec75-08df2090c5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r2KzYTf8SfcYrRBUSdQEaAcw02C7vC4cRjslmIKXo0NfNnfgB0dvYbujw6OKzj3SJQBfdSRqEsD8yPYOjJt1yWbeMb5CfGeavACBVb30C19tUjlWgbxdDY5zN6QEHzydh7Q0MI+VLdkrb3EzD9dU+QjZM/qEdk5N4T78W80dUYoq6UKdwcwmuF/IuadbCk1SbsOa6XcNd8cUoNLSaput6aw4zm43r4me6tBcEr+HuKnPOyJZqHtWDEJjaWeEOJ8OJs2BMjRReEWK2Xq4HAYZr4zYRDwBv0keF4ElYTcXhYDM74xo5Vn2NvkTSzJTXVQ6AdyxwvSMES5oqd9Cwk7oHep7VI06eLhPNJxC8wYH+yHl2Pyw/NHuw+BtZX8Oo1JDBzxwHwbXr9wcX4UzlLWbhzpWbvD4lqb1X/cr8GTmwn2Gu8dHpGqPqWiA+rhZdps6Wf6GKp4peL5o9DWm+/jNHwD7ap/khYitZPsPu9VeJLdJUsIwZIX7ubzXQVi6UuJKfzV0Yj6tYLaZuO9gZ/4nnjm7iQCGM4XDun99d+is9A+YCUBx8URm5jvq2Xs+jouoQTdXUvg0Afecb3w2xCuBUWU0+ykZ2BNHZ1r04L21/hFN6hUjYP3jncS9ZZf2kcns
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVNUR1RhSzhNa25CNWp3VGF4K2FVUU1wWmczMG13cHZxeXNwWjZMdWNuZDBW?=
 =?utf-8?B?eVF4MTBuai9peW5HQ0toQ2RUUVJqSGZ2QUdZdFpmaUZzNnlzVEszd2tMQlVK?=
 =?utf-8?B?dEVVcXdKR1dyaUlnVzN2ZWo4d3I0Q3VkNnVTTjJRR053RkoxR1RRSTFQdlR1?=
 =?utf-8?B?dCtKbDZJNW9mNWo0L096bVNPcmpUK3VWQU5LTzloM0xQd0FJWWNUcEtKODJs?=
 =?utf-8?B?RGxnZkIvdzh3UU14UFRtbWpiMEdoNFdrRHc3SEpBM3Nib0RWYmZVSi9OVHdV?=
 =?utf-8?B?cHRLYytId2tSTUkrYm5TVkhWQnZ4TEtpY2tEQ25qZGRKcWdqZUtoYUJMRThw?=
 =?utf-8?B?b1pFTk83U3ZMNktuVFdkWnhuc0lhbHBhTmdDdzZvSnc2TUVEckFwMVNkZ2pR?=
 =?utf-8?B?aDBBNGJ3N3pVTS9YcVVLREduNFhlYmZEaDdxaDkrQTRHZFc1OWFHNTBqbnpK?=
 =?utf-8?B?WFNaSXl5M09CMmN3bkRlNW1aSnE4bkZqTFBObm1vcDkvY21QUTg5UEs5Nkt4?=
 =?utf-8?B?MCsreGlYOGh5TmFRZk10amdsdEwvMGJ0N0hweElHdFU5TzNOSmp1TXNTUFRQ?=
 =?utf-8?B?ckRjVGdpNktma2R6RmxaakQ3bGg5RGZEM1BZdmNrL2NiRityL29YV2tlMXVD?=
 =?utf-8?B?SXZTOW5UMkpNN1R3U2luVjg1N2VTWUVzYnkyRkFZdlpnVUk1MzFoWm15bE9r?=
 =?utf-8?B?Y1NwcldHWnppMUhpTkxVcjdRR3lWZHJvOEQ2b1BtWlJIdmtmNEdXWlFLT3Rw?=
 =?utf-8?B?NGZVWEZuNHR1VHhON21Rc1pMWmREUzhFalhDdEwwVkRDNWdiL05taWYzc3Vs?=
 =?utf-8?B?a2E1VUE1ZEJvWWNhUW5oSHIrZklHT3ZHbGN1SjhLVmJZRk15dnY3SFdUUnFC?=
 =?utf-8?B?ZDFEOW5obVR2cHZ5VnVXSFhoVzlHZVZUNURxRHUvQ3lTbjViTlpHWkQ2dkdr?=
 =?utf-8?B?QzNnaUxZMkQ4ZTl5aFhhQ2xtMTYycTB6MTBPVU94bWtwUWhoQ2Z4TUVaOUdm?=
 =?utf-8?B?R2IvbEdNT2NFMDVIUjFxYWtFYW10MjJKTEZXcHpxRnF5QTVCOGZXRnpiOXdj?=
 =?utf-8?B?VnRSaGM4SVl2UDJFcWlWRzVDSjBjd3AyRDhMci9LQk41cUxSYk5qWWdtSDgv?=
 =?utf-8?B?ZEs4Ukc3L0EwVnM5NytqN2lMWm9NTVRBZUxCeTRBOXNERW1xQ1JzMVpKMmF6?=
 =?utf-8?B?c0YwdldWSk5UWWNRd2cyUExWMFdGa2lBcVg5UWhVM1N4SGFEMmxBTEFpaXBj?=
 =?utf-8?B?eVdpeW1oWlFDdU1NS0VPa2VOTlhDWmRNVi9RQm5xTkNYcVVVamdNbVJBS0Ir?=
 =?utf-8?B?QXlTdUU1MnRRTmN6ZFlDZkJQS1l2OTRxWCtQOTBCWHhIeHJCZnNnWEZjRHpQ?=
 =?utf-8?B?WEljMmRHSk1wcHpCdEQ4cXJYQXVSL1ZmK3RsdmhraDFDR1dUR3k2Vk9XNWto?=
 =?utf-8?B?R2RudTVwWE9iVCtJcHNmWVBsOWpTNVp4UkhiS2xqTko4c21VSEtzVGpLeXgz?=
 =?utf-8?B?ZTUrVlJuS2M3eFQwekx0ZkVXaXFuZjErb1dXbWNhVDJuaDVzQVFpK3ZUN0Jp?=
 =?utf-8?B?M2VEdStQZFRjUGdnMkY3eWNudDY3TEtQTkxUVW9OMWQ4WGRIZjZRL0VRekYy?=
 =?utf-8?B?RUYvbldpcFFmbkVlQWk0TDdQejlwZStOOGtTbGdibXlHaGhCYUg4WENlbDFT?=
 =?utf-8?B?dUhrN2VnZENsb0VGV0kza3RtTFFiaFNWNzdlYWNSWnAwL2ZjWTVzUDdPUGpP?=
 =?utf-8?B?UlhkQXh1UWpYK3I5L2JseXF6WGNBalA3dWwxVlZZVytLdDJ4MHkyNWphcnVF?=
 =?utf-8?B?VmxISUVwbGNGQ2QxOGd1MkNNbDE4SnQ5Y3JFZWIvbDR3cWNmNDhzcDNZZjhS?=
 =?utf-8?B?WWhVMW92WXQ3a2NuOS8rUFprZXlNQjMrYVBvZnRQR0FaeFl4TW8wR0FtSHpI?=
 =?utf-8?B?MmE4V2hiKzVyZUQ5TUhGbTFTRDFURDZRSGFFM3llaEVaazBCa2duZDVjSUZN?=
 =?utf-8?B?eElLSzhDdmpoelZEaHdYSEFIM0xmZ2lMMVg5ODJFMUE2ZzBmeUZJZEpvUmJk?=
 =?utf-8?B?cFpjbmM2VFRDMitHMk13aEZwanBxamNLVEpFVFpPbDA5b25XREt6QUFqTjdU?=
 =?utf-8?B?S3A4Q3FKbjh2Uzg2UWk0eDF4Sk43c2dTUFZSQ3RUSEZZZlBVd1NRa2Q4VlFz?=
 =?utf-8?B?Z2lpdTZHTXBCOW00b04yTjBmdTRSTXlaV0VFQmZscWc5TXlOOVFFR2p0dWJS?=
 =?utf-8?B?N3ZoNmtURWtUVkpPTHF4aS9qb0lHdDQ4QTltQnBsY2ZFTElkUUpCRkg4OGQz?=
 =?utf-8?B?TEROZzJrUEw3dEdaZS9TT2dIMUhKRS9yMEdMUSt6ejZSUXRPMS9tZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff18d89-f010-4f7e-ec75-08df2090c5f4
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:23:48.0484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd+MyS8IElxoeOXHFYdlmLFQa9Trgiw52u1WLRkveL24lp9zTQ+NFz7yWy0K7fcnpsrb9Xxmco3EgduR04w9k774R6pjNU0ENP06WN+iyqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
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

Hi Dennis,

On 10/2/26 5:13 AM, Dennis Gilmore wrote:
> Add compatible string for the Orange Pi 5 Pro.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> Link: https://patch.msgid.link/20260511025352.106126-2-dennis@ausil.us
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: 03b1c32f54bae3a4e73f82e1ccb322cfead24a2c ]
> 
> (cherry picked from commit 77c77cf4f0f1a9387720d9052673cdb9a01645ed)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
