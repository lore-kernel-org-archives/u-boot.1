Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C611C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 513B980DEC;
	Thu,  6 Aug 2026 11:00:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLVFseZEsysf; Thu,  6 Aug 2026 11:00:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3296E80DE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014039;
	bh=du7LwR1103zltWMshEMWXgQCnXGUTGvE1FJ8+vKv+XE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TvQSpLNHFXZQ3vzCq+jbANJy1LrF/xmoOVUn4SfEXkxSOl9MDDFo6xk3gSZ4QtSyS
	 AobZvKh6qBA2hhdKuGgEe0Sy0x+6W3eZbEtRlq5PCVHZpjH0zmHRjMq1sPmqrLi0Lg
	 99vhPePeW7p8zxKyHg7r9WEPbkMzncai74DKTmSF17zq3GNuFx18s26nNPreUOAHbz
	 2ShXjQ1QUHjQpANyvLIAIWf8cTgJ+Szp7x2whgFG9TJqa3waO8oqIwTkJRRY9MrNwl
	 La0TkIN5dmSuqvBjVA4LQ/L0lKPSSJzaJnZZcOJS0Q9m3n9jUSt8AxeQ7Wop8OQtNG
	 lk55SPYTS8ULQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3296E80DE5;
	Thu,  6 Aug 2026 11:00:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C2924397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B49E740207
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JJDFJ_k6DzcW for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:44:00 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9B46540167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B46540167
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B46540167
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBNrf9AAgNusg6k2Vgytzml9J9EC5aLDKZdNqZC9mY7c1Cgh1s34kNu/cbgwzS8EHZqLfL+sMpLQtr5fQFiu0uThpbdAYuzHU+GPAXPoNSCr8U3rfi2rslF7tKZ1m+KXFVPbnu+ziwLNvNzMyjospK3IsVaGLEJ3YcrTMpDqeC3NO7uWggJL8qSVOPu/znAJNlcL1EvrQaOVI0gt23cIyxegsjP+1rhiagGNwq2oNv1HWMrFY+EeHdRjgkqqRkYfsK6Fj8+2+xfiz+VicbFfKv1lktlJeDRCSc4ASGvZF1Ze/V08Q55emX8HoVcGkyqX66oFYxzyjvAo1q++rfLDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du7LwR1103zltWMshEMWXgQCnXGUTGvE1FJ8+vKv+XE=;
 b=BosE7C7LAPHrAcMiQjla6Tsc/LOTiVPB+ECXiU1So+t0bbc+E7Mp/bPWRhpBT2+FhMla4VmiTMDjZBS22gv1t+cLcVqwiEZBA3ocpTs7f2L4p71MqPrAvewyikYBMo82z+GxVse6TtdY+0Cr6VgrbrSNVytrs8Ddh858Jkt8+qYh8KvmZj+POE/SdQS/UN49QkpPg4qboLFTwG6w0VKnfigXeoZj4FyKMC7ccXb4CfBJoIf/wfkWvjebqfLnD4e9YbDYL9ldYhp/jRGBvD9XQRqukfBAbdaSpXGtjXFzXBcVxUjrPlfRYEypd0jFZ6E7IdTtcVwjYKX88ppSp5hgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by GVXPR04MB10850.eurprd04.prod.outlook.com (2603:10a6:150:216::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 09:43:53 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 09:43:53 +0000
Message-ID: <e11a94e7-b0d7-4570-bce7-8dce51d426e9@nxp.com>
Date: Thu, 6 Aug 2026 17:43:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3] imx: Add FRDM-IMX95 initial support
To: Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lei Xu <lei.xu@nxp.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
 <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
 <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
 <CAOMZO5CqTuXdG+uXZfiS5WjDD9QoNmreYd=JT2Rb48n19qRKkA@mail.gmail.com>
 <b362330e-c919-46c0-a1ca-b000f9c89be4@nxp.com>
 <CAOMZO5AhOZcsAc6DThNDcXudk5fWrm1gxgzwvETWX3hQ+Pj6=w@mail.gmail.com>
 <4024d372-29c2-4c6d-8185-9b97fe27f91d@nxp.com>
 <CAOMZO5AuKP+DQfSCWNRxuzPJJpK2vz9DJFHxf5J2FQi0u18=2Q@mail.gmail.com>
Content-Language: en-US
From: Joseph Guo <qijian.guo@nxp.com>
In-Reply-To: <CAOMZO5AuKP+DQfSCWNRxuzPJJpK2vz9DJFHxf5J2FQi0u18=2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|GVXPR04MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: 67eefecf-3ecf-44f4-ece5-08def39f39ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|19092799006|11063799006|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: PFhvM36mLAc9Gmo5EyGA7GWveAqIvMtFAKlQ7cpUhRdVeIvNbgbxgsZMRXGHFfL9g4bYSyYMEqBRRipHj/nuXOJLSwbhKp5B7jPq+zfEtGQVet7WoGbuRjA7gvOxogxbrHI7YOgkVsJReSLttPzgokenJLXPUaI5w79xPqeUaAKcJ8vhzEFqRwjPL/WU36rhyX6qW7msJzVW/1+vlw2z+Py/j98ukYZh+SPPr+5jYcikgDf5CtKAcoE5tAArZzBzKIakuVGwp9jw2HO6qTxDsXZDjGhJpLBqB8sSxeFgSZaAAD7PQt5rCjnWcsANRyL2AEQLLoXwT3vDw30zA+P5VuOmB+ZHSEe0yU2TO0oVZZwlaBAKptVSfQxAxNTsVNYYrRuN9XV2Agoqd73lggLuqdzTI7/5JGZ2qAQ1WT1J4esEV1VtPPVR4spTAhMCFQKBY1KlQBPZfSppx9JfG/mZKAwVucEKqjPJTJXGXTLKuTIVGwCWz/LsefpjzXGbZJV5mcKinFC6HXEjemyJP4aA0nXAAYKnMC1Ui0q1/0/We5/fwAOd8Nedg0TS/g5FZfmLGUriogO+zOS0mEpAHeD3VnJ51uqLPrql3dTtj+Bs9Hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEc0cE5jekxtNTJJWlExUnhETWg4b1NyME0rci9XazN4RmMvWmp0WmVkM2VG?=
 =?utf-8?B?STVRN1R1V2QvR2Jnc3VwU1dBUVJQeGY0dm8wNnNGNVdnRS9kbEs0Sk9hQVBW?=
 =?utf-8?B?R2JWcy9QQkdQdHRzNTFqRGp3Rk9pZnFTMVJmWlhabGJ0T3NrQ1VIN3poUzJm?=
 =?utf-8?B?WFpqenVtUlV3MGFjNEk3MXBqSCtaM05ONDF2K0RocTdHM3oxdXVRbC9tTjJK?=
 =?utf-8?B?S0x1M2xaN1JkWUcyMHlxQ0NHYU5wVWlsUTBjcEZTcWtjK2dFSHRsMU4rTFlr?=
 =?utf-8?B?TTlwN0M5MklYVGh3Ymp0ZDh0cGpmNGFSd2JBVFJyNXF4VkdXYzJLY1lSQjJv?=
 =?utf-8?B?S3FpU3BEZHNxc0NtbnptMTZEY3J6WnBCNlA4WkFtb28rZ3JhbnNJRVBhV2Ir?=
 =?utf-8?B?ZnB0Q2JIamE5Z3dqOEJtbFNjSkk5SEptOVFVa3haK3RWU0k5M0pCdk02QVVq?=
 =?utf-8?B?dUFRc2NyWmZUWU9yQlZCYldsRkNRMmQyM1E2MEdaUlA4bkVxbWlPU0FLT2Fh?=
 =?utf-8?B?Um1EZW5KdzM1MklGNlEwMVd3UEZYMElHSC8zNS9Idk9NMzk0d0syWXBNamZC?=
 =?utf-8?B?MjNFQnE5Uk9vc3MyV2NhZjhLbnBqRm85QWttWE41V1hUcGkxSXIxZ2VhQnNU?=
 =?utf-8?B?QitGQ3VCd2tNYTZURlQ1cTlNZ0RTUzdISExJdmpXZkUxYklaUklleE5vay85?=
 =?utf-8?B?T0RtQ1M3MDMrV1E3VzZHMmlVSHpEd0RSZlAyM3FQbnlDM2hZNVVVNFE5QVdU?=
 =?utf-8?B?M0VtOCs4VVpWQXFEVUJQY1VJK3dHajVjYnNVbGtnVWZ3OHFzUFV3QnZyejZB?=
 =?utf-8?B?clZSeCsvQkMwbi9hZjBkZjNBVFRxMHcva1lxbC9Va0swUkRibWU5bE4zK2ZB?=
 =?utf-8?B?UHB0dmtxY1hRNmhtVWMxbEtPSlNvVEk4bG51ZWRydUtlUmloVW1oRGdRUVNT?=
 =?utf-8?B?WFhwQmtWelJYRllKUWkzYThzRjAxdFltWCtyMmZTUktvbFVlUGNFVHdyeWVK?=
 =?utf-8?B?c0p5dVd0cXVMSFdlV2pTWE83bzMwaUF2ZmZFQ0lpaEtpWVZ4anQweDhKWnVh?=
 =?utf-8?B?blMyaWJMaEpBQXRvN0J6Wk5XNnRFQ2RhNnZ5N2dseGxoRnRYNjVqUGpSTmpm?=
 =?utf-8?B?TXVnbGpGdVVFeENWT3BWOU1SQWhVTW1kOUdManNkVlZTbUFaaXNXdjhvWW1p?=
 =?utf-8?B?VjNmUnEzNld6Z3pRUEtXQW5XUGR2TkdQVm1OM2FxcHpCeFM3QkZRSUp0L09v?=
 =?utf-8?B?M1pKV1VpeTU3QVlJZ1NqTys5eGZEcEZ4RE9hb2xPQ1JwWUpjd1ZDVzBmL0FP?=
 =?utf-8?B?NnZzd1poQnhJM05LVnVPdWxiczZkU0JWWWRrRjNFMXlmSVNRVkxGM2gxNFF2?=
 =?utf-8?B?eUpmTytVcTFRbWVKM0lZRloybTc4WCtnQWFEQ2l6OWZLNTNtNHhmdC9lMHcz?=
 =?utf-8?B?U2xaampWbXF6djFXK0p4K1RXL3dRejBkdld6dDJ6QTVCb291M1lFSHJYdUlj?=
 =?utf-8?B?NFA2NWIrNDRIdU85ZExJeVRJKzBQWjlSWkVCRHlLRmM0QloveGtyM1oyTGVa?=
 =?utf-8?B?RjVxRXpOdmliOTkxdzRBaHlTRDA4L1F1Mld0TVV3SVc3eHdDVDJUM3dpL1ht?=
 =?utf-8?B?dTZZdmdDNnlGSVovSkF1ZlJiL3o3eGVFWStWNzQ3UTdISkx5RUE3NXhQaG11?=
 =?utf-8?B?R0ZxYi9zRlN1MnMvaitJMUNOK1oreTlMT20xcExiOVQ3OUZyZGdwTEFrUlc3?=
 =?utf-8?B?TTl4TGkzSDdIbmVmVDlYK1JWcFpHVmlKL1FKNU1QZUdqTXpJeVNtbVdjSlQ2?=
 =?utf-8?B?NUF2SmNGck9sd2xOVGVwbVdlVi9wSDdpYzdHTTVCZnk2SGRabEx1cUpyWFpS?=
 =?utf-8?B?YWUyby9pV3FGTGJKQi91eXlIa21QSmtxeDZDRDExSnE0RUpZc1YzaUVlcU9C?=
 =?utf-8?B?MWtBSm5GcG53eUpvRXRKNlRvVU95M3pCUGNBU201cXR1VDh5OTVETngrdmRQ?=
 =?utf-8?B?ZnBmVmwvYlBTUmxkd1ZSWDZ2bU9FZmIvUzZHbVBRUE8yVmNLZHpCL0hmeHFM?=
 =?utf-8?B?VG4weG9HcUIrclJnVU4rRnN4cUlxMEN4MWNHQ0hQaFhsc1VYRTBJclJ5aTQ2?=
 =?utf-8?B?WWpGdkFmbFRpSTk5THd6ZWlKSjdsMFd6SkV0YlgveW9haXhpK3ZtYzEwaVJp?=
 =?utf-8?B?S1hQaWpTTWg4aEZHT0V5Q0s4eHBOUFFvRm9JcjZ2OHc1azZ1TnprMVd0K3Ur?=
 =?utf-8?B?b1NrNERldFRXdWlYSUlNS0R0bi9aWmgxSTh3VDdHTzZKOTlIdjVlK1k4MU1D?=
 =?utf-8?B?aGxvUWV6TzJXUHJTTmRIejB3N2FEMWg1VTh2ei9udFZZbHJuWlRnUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eefecf-3ecf-44f4-ece5-08def39f39ce
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 09:43:53.1480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPF7A0srGpcsbmVsLwPPRuQs/R4O0fV2j8Poc+A+jrdkYK5KBYpNYMCr3c3Tn9kv8O4dt5l35nEzj3t3x0KVFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10850
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du7LwR1103zltWMshEMWXgQCnXGUTGvE1FJ8+vKv+XE=;
 b=B9rMUHnr2b1enwd9Du6wqaGuwBKZA2CCOvJpRH4JDpyD+q+yPKX5BhRNidtMzsdJqZcQ58wEuU2jZvxc53Em7WzKADBp9VNr9ti6YkyAPJG1vqBE0Cw1iU7Uu/0oW3ujuyhZH0ccSRIwV7oY7WS26vgQchdKSXxQNXhDg2zD685CI6o6fKeeSM/8b1ljQKlBKtSA6Jpb9gYowacypMUrkt+zSB/vlSxChu3BIP6vZ1j4WjikfAV6vnpVr7hQNuFJGJXO6eOgNFIcB601iyyb91mNoZkidAqQSJpC95cEj09mqHxcvaQtfXCHETwVRBXhMST2Ker4z8dDx/ti06F3mQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=nxp.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=B9rMUHnr
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/4/2026 10:10 PM, Fabio Estevam wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> Hi Joseph,
> 
> On Mon, Aug 3, 2026 at 11:42 PM Joseph Guo <qijian.guo@nxp.com> wrote:
> 
>> This is difference of general pcie driver in u-boot and kernel. Sorry I can't answer why U-boot didn't use the property.
> 
> Please try to make the U-Boot driver understand 'linux,pci-domain =
> <0>;' as Linux does.
Hi Fabio,

Thanks for the suggestion to make the U-Boot driver honor `linux,pci-domain = <N>;` the way Linux does.

I looked into implementing this, but I don't think it is the right fit for U-Boot, for the following reasons:

1. `linux,pci-domain` and U-Boot bus numbering solve different problems. In Linux, `linux,pci-domain` assigns a *PCI domain* (segment) number; it does not control the order in which host bridges are probed or the Linux bus numbers. U-Boot's driver model has no concept of PCI domains/segments — a PCI controller is identified only by its DM sequence number, which doubles as the root bus number. So there is no existing field to map `linux,pci-domain` onto; honoring it would mean overloading the DM sequence number with domain semantics.

2. Making U-Boot consume `linux,pci-domain` requires overriding the DM sequence number in a non-obvious way. The DM sequence number is normally assigned during the bind phase (from `/aliases`), and the only way to make a controller pick up the domain value is to overwrite `dev->seq_` later in `of_to_plat()`. This is fragile: it silently reinterprets a Linux-specific property as a U-Boot core-behavior knob, it interacts with the `pci` alias mechanism in ways that are easy to get wrong, and it changes the enumeration/listing order for *every* PCI platform, not just i.MX95. The regression surface (e.g. the `pci` command's bus-walk stopping at the first link-down root complex) is larger than the problem being solved.

3. The pci aliases are the documented [1], portable U-Boot mechanism for exactly this. U-Boot already defines pci<N> aliases as the canonical way to fix PCI controller sequence numbers (DM_UC_FLAG_SEQ_ALIAS), and other boards use them for the same purpose. Keeping the aliases in the board -u-boot.dtsi is consistent with U-Boot conventions and does not touch the upstream kernel DTS.

If you main concern is keeping the U-boot DTS sync with the upstream. I can upstream the pci aliases. These aliases only influence U-Boot's DM sequence numbering; Linux ignores `pci` aliases for PCI enumeration and bus numbering, so adding them upstream is functionally a no-op for the kernel.

[1] https://docs.u-boot.org/en/latest/develop/driver-model/design.html#device-sequence-numbers

-- 
Best Regards,
Joseph
