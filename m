Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B069C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 12:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94568386F;
	Tue, 22 Jul 2025 14:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="E5jK1J3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11EF98384C; Tue, 22 Jul 2025 14:42:41 +0200 (CEST)
Received: from outbound-ip24a.ess.barracuda.com
 (outbound-ip24a.ess.barracuda.com [209.222.82.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD72E8339C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 14:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46]) by
 mx-outbound43-124.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 22 Jul 2025 12:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czqOFuZql5a5y95HQS4WEFfhMMy00jfMXYq/YhFYIdSY5Qut/d/3EHPe9PWzHrWvudc+u5tA2twKKJjx6tRI3Wp/+UDGn8YnRnD7g+CNiCTVr1KIdsmgQhUKa3yJXopHQCvT8TYIk6mBrS+6Nh2IdClzOoqIRwD0jtJl5UwyHpOv1kZYXfJpn1g82adq4jcg9Gw0Oead4h1fRUoZ64Z1oDaotyqG5AD0iVqsz905++0TAKnO33H9tmdFQ7F4ZnjYVYoDDd3yJaKcan//XWghQ8pojJDWi9tyhImqiCYOJm2Rj2P39ft03n51Mx2Zv+RqfEcHdisJqeS2ZOafB9iAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBDirPk0cdGGZrAwioj4b8tv8OxUj1HkhAOXGm+/Xzc=;
 b=XT7dl9WYcByU6UBRtTQf5WWx0htJPt4Ct78/1+zkKCz3BFbT3sIEN89+bAmX0XpgmXgBG2UHD/FJuUGM5/M2v+uyZP7OzLlCE4+M6Ags5uX+6vQE8y4MvTYB6rEyjA3F64KXyCoaWw/bdR7oT7P6Jdwaa4cbYWAI5jCWZvMjIyIOJQsSmc5NJYsr3Oy/YD/j59dHcasD+bYXaaMjpNIFQWJwpyRe688chvT9q2D1Ow8TQRztl9ibYRKv8a5pTutjsWnc7ZQbfBDHAjjlNK5L/8BhBhbqHhbAIKQM6E/PjypfovhGlOVngbKogwNyL239K7tfz77O29oh/6m2tiDlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBDirPk0cdGGZrAwioj4b8tv8OxUj1HkhAOXGm+/Xzc=;
 b=E5jK1J3WJ2WRKgu/gbY0F+3818JzrX4jP9cXEeRi3TiH6weccwHd+hl7Xn/iTqEv3lQ1ZE+LJRgOP/VTQnq2Ph0Y289Quw6SezxERxyXbAA9cADB2/wFUYfPZHel3anJchIx+dHgPp3Z0vSPrsll5Yzks/6opT7AB3fe8Zvo5Ke1xtOj1wbxM564vm6Jnfr0Ou8cILRTbJKr90u1uBDu0I6Zn2TgJzGA1gtu4t01UVwY93QDDkp8GRBRWU15J+5QlWf5I4MEsqxaE4ywUsbs7UBYbHN9oR3hQBZxwV1z8xCEoady+MYgEER2zeBh1LYCELp+26a/mliqwuUMNvFdeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 by PH7PR10MB6603.namprd10.prod.outlook.com (2603:10b6:510:207::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 12:42:21 +0000
Received: from BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::e024:9e13:d386:d19e]) by BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::e024:9e13:d386:d19e%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 12:42:21 +0000
Message-ID: <f419bddf-b939-4aae-9281-2c13c586248b@digi.com>
Date: Tue, 22 Jul 2025 14:42:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Uninitialised variable in common/spl/spl_imx_container.c
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <82b344b0-3b26-4e4a-a5f7-dc7e45f2191e@linaro.org>
Content-Language: en-US
From: Javier Viguera <javier.viguera@digi.com>
In-Reply-To: <82b344b0-3b26-4e4a-a5f7-dc7e45f2191e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0045.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::34) To BLAPR10MB5156.namprd10.prod.outlook.com
 (2603:10b6:208:321::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_|PH7PR10MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 814addf6-3c8f-4027-e34d-08ddc91d3373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eitoZlZleXVMaytTRTVLWTd6YUZlZ3VHNTRMWU56RWVVeGJUREFTajF1SE01?=
 =?utf-8?B?TjkrVHN2MjN0YmpLeW5XK1czNmlaMlJ2bGtPdS9JWnZRazdBSnRQNDA1VzJ2?=
 =?utf-8?B?dUZma1dKdnNiL09rQ0h0VkU1OXJqTHpQeVpVMEY2b21FMG0ybDRmamJTeXNj?=
 =?utf-8?B?NnZNeWJtKzQxZmhZSUwyTUlXM0x6aGxWMSs4UC8wWEpRQkQzQ3h1OGxkV3Fs?=
 =?utf-8?B?SHZHWWlFYk4rd3ZMVmppbCtNVFlXNEtQS1djeld2dXFZV0Rrd2tVVkZRSnNa?=
 =?utf-8?B?WkkwMzF1UHhCVkpZZm02RTZadHc2STlIcXVRYzZ6N0Z3bnJzUFM3bTlMNUJh?=
 =?utf-8?B?bkp6TWZidllVS0dBQ1prcExwQjlLMHhlT216WDFkNlMxNFk4ZkFkL2pUcXRw?=
 =?utf-8?B?WEdFNW84WnMyMmhUYlFyY1NaaVdSUVd2clJFSkJLdlNtUmY4VExrc1FtTEYv?=
 =?utf-8?B?MkxGOU5XYVJqdHlaQU9ZK2xGUmRGRndHYmxjNG9KR3cxUXZBVHNVVTJZK0Zz?=
 =?utf-8?B?ZlBmUDNOZm9DS2JSSUM2bmFYeVhxbGV1TGw4NGVrZ2F0Sm1rSTBydEwvb083?=
 =?utf-8?B?ZmExVnQwUlJzZjU3S2wyeUdud0pNVDcwd1pHOWtncFFZTG8wWnNzaVhwTHZR?=
 =?utf-8?B?Zlo5SGZVMzNla0FXMUlESkhwYVJ0TFdMSmU5NmxwTzNpN2VQT3VLeldER0RO?=
 =?utf-8?B?a2lPYmswZmRQbmRBWjEwTUJ1U0FvU3RCRExndjZxS2UybzZLM3YxV29HaUJM?=
 =?utf-8?B?UXRoQzVRMi83S05SQTlKbTlRTUtOQU51U1VvazdOOVNmRno3TkJTSWZVMk9F?=
 =?utf-8?B?N3lYN3ZkcEMrRUZDclQrRmNZWVlIUUNTQ0NMNzhaVXp2SDdqcmFnVWRoVW5T?=
 =?utf-8?B?ZWFLbWhZamk1SEdYMm81K0lPaDAwdXRvSkpHV0FENUljTE8zR2tjWk4zUDNV?=
 =?utf-8?B?V1VabmNBSEFTRU8rMU04eXB3eVM1T3Y3cWYxOWFnSjVCZ1VtcXREYjQ4WU9m?=
 =?utf-8?B?Sk1tcjhVNW9UTU0rTXNzT0JVRnZWMUhUdG1BZ2lKcEN4Vi9sTnNMZ29HcEd0?=
 =?utf-8?B?aUkyc1VTYm9qYjdxSXBNWWdMOEt4T1lYQkFKamhzRzVpWHNnZUZKemFrWEl2?=
 =?utf-8?B?V0tUUDZncVpCNGx6Z1RiQ05zNFMzcUJtTkRtcTYyNUFhS2lXK2xMeXFiTk9P?=
 =?utf-8?B?WDlaQTFFQlhNZGFNNXJsS1k4WlQ0a2RtUmp6a2sybGNBQTV6SHZJSWV3M1Nr?=
 =?utf-8?B?MktCODFTWVlnazNTR2ZZSWx3bm9CTW5TakJHMkNtM0s5WGNuTFRLOWdkWnQr?=
 =?utf-8?B?NFIyUFdIajZDU2JnMjJCVW9URXZOQTM4cmlsbUlRWjM3aW9VYmdJbFQ0S1JM?=
 =?utf-8?B?VTAwcDFXVlhkRkpOYzhkeVpzVFp4ditYSUFldThiQ3h5S09CQ3lLNW9tUDBC?=
 =?utf-8?B?QkFZVU1pTWY4S1BhekJvL21kTUNTV3hjeUU0M2REck1SWFhscmtPU0JXaXVJ?=
 =?utf-8?B?SEdHbjdlYmJJMG9IemQ0ZlVKWTRSUUwxT1VPZEd2OWY3cUUzSzYyL3RHb3hv?=
 =?utf-8?B?ckdaYWUyYkIwVHBaYWhIZjRndVhINlpiMHd2L1k2UitCVnhsV3lPdjZsOU9Y?=
 =?utf-8?B?dnV4T09KK3dLM29HdlhuREgwWHRxRDE2Nm91QWtOODNzbnFIMllkbDFOa0RP?=
 =?utf-8?B?bk95VW5YVnZDNU0wb0wwQmNjem02dlo1bHk4ckNzbW1sUHBBTERpemx1VHZ1?=
 =?utf-8?B?VHJQYWxocnNxMTFVZFh6dEdxNVVyQUFvQWdvTGJZT3VPaFF6OGQxZEQ5bUtC?=
 =?utf-8?B?d2Y1UjNUVDhZOE1uRWxsckM4Yi83b2dyS3NqSXoxbWxQZ0NHV083bVlvVnRU?=
 =?utf-8?B?Ynl4TjlTQ29lWUEveGxNNVZYdktEdTV5MWpaZTV0eWwwVmVjZWJwUWhPbEUx?=
 =?utf-8?B?TW8wRzV4dnJKaEYvdjI0WjRPRUJIODRPR0JhNHV4bzdmL2ZCTjB1eURoWkpJ?=
 =?utf-8?Q?SiQnfKnbye//dhZo28wsHDQbp1Vu6s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5156.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUlpTFpKVVlUa3BtS3FvczFDc3MzajNBUS9TV3BYaGw1N3o2bFFPdEd2YzdE?=
 =?utf-8?B?bFJ2MlhqK2F4Tm9zaEp3YXc1dnlOMGhMbHNEYkF4c0QxSWtnK3BzRlVkeG41?=
 =?utf-8?B?RHFWU2RXSWdKWE5hTlNGN21LUDI5Y0taSk83MDVhR1lObFJ1bGFIcU1XZlVC?=
 =?utf-8?B?NGxURUNiUkdvSWEySVgySGNxZGR0eFNwZUJPL2dPd21KTGd6aHpEbmhpc3N2?=
 =?utf-8?B?Q1VscWdpeW9EMDVodUcvMHFrRzk3eHZUVVZsWDBTMDNSYVhZUytNd3JOMHBU?=
 =?utf-8?B?TmpWTzY3Rk1SQVR5UFRneGtBdkdCcW9Ya1YvWU8rbzBNUm1JdDcrS0tlcWJ2?=
 =?utf-8?B?RC9udmtOY295ZS9RZWJmMWZTUjBVSmdSejFBVnMvNnRVekRSRTMrMVB2d0NT?=
 =?utf-8?B?cklha283ZHVkNGdWL0JFODh5TkYxdEZtK29RcW1lRFlnNktUQzliaitnTXZq?=
 =?utf-8?B?RXNCYm95b0Z5MEJ1d05pNllLNkdSeTYrSTVVSVQvcldXWkx3MnVQOWMwTTVm?=
 =?utf-8?B?K1NJL3JNK2xURlFndlZKSDBISjM3eHlCcFVvN1U2RUgvZFVvcmRmaSs2OHFQ?=
 =?utf-8?B?ZWdSRFdXbDZLdy9FWjJWeVkwMk9kakQ4K1BZTWNacE1kWndQNWNmcTQ0b1I2?=
 =?utf-8?B?TXJ0a0k0T1JsM01Jc085NjVMSWhaeU1VdW5wQ1NzUFl1RHBleW9yV2tIQ2ho?=
 =?utf-8?B?dWxTeGhrRlAvMDk2S2xSbWt5RndEaGp4LzZqajRBQWZ3WUNtYUk1a25QSWxR?=
 =?utf-8?B?d3BlMDBEaTZUOCtKVDFWcG1sVXV0Vk9pbnVaOE5JVHIvcExFK3FweWlVeTRG?=
 =?utf-8?B?QzgvOC81VjVNSWVveUJBWW5WdTZCOTNvakNhL0M4MnNGS2Nyb3owd1JjVk1r?=
 =?utf-8?B?U0U0c3lEaFNtUTFJckdJUVdmVXNwUnBjSlQycnAwZGJRc2xNQWhFN0IxM1Bk?=
 =?utf-8?B?ZzA3SXBOdXVMZnJqYVI2dEVRWFREdVFxVUxhVnpwL1lwTzV2SzRSdVZBOE5Q?=
 =?utf-8?B?bi9NWGh0OG5temxaWEovVWtybm5heHVSUTkraWFiaVUyWGRZakdEYnE3RTRC?=
 =?utf-8?B?dHZYS3RSd3o0anpnSUJaclhOUjd1azJGUUhKVDRiSDlNa0hLdzRXdE90TDJ2?=
 =?utf-8?B?VCtJTW5uZTMyREVoKzJqYWFSVk1wVEtVQloxZ09jcUlETzlPRTFmR3pJNytx?=
 =?utf-8?B?T3FHb0l1N3NnL2JuWTlWSXVuVzNQWHp6WktMNTRURFRIVktWTkp2USszRWx2?=
 =?utf-8?B?R2xXOGJEWDNoTEtieDNqT1Bnay9sRUJlbGtVbEc1L3c4U3dCb09UVzNxSXp5?=
 =?utf-8?B?VkxCRDBscGhlaXJpUGpaMnBNQy9ocm1tUzl4QUxLMlpBQWNIZ0dneHRQbzUw?=
 =?utf-8?B?aVV2TVR3ZzN2WmxUYStHK3BsdjR0SHl4RUlMNTlZMXMvanBLNTIvdnF2OEJF?=
 =?utf-8?B?QWc1UFhtUVJ5OEVKTHYweGdNczc2V21zbXZpNWIzR2gxNGUyUVlieW4yVDF4?=
 =?utf-8?B?allhMDFydVgrYWpKc3hNWnZXZnE4N1dnNnhLNS9jWlp4NDdtWnlwYXl5YXVZ?=
 =?utf-8?B?SjFOVUorT2p4d3dmaTNZczNwZHFrWXd4UVRxZDUxbHhjRDc3OHBoa0JmanQ2?=
 =?utf-8?B?ZCthSW8zbEVodktIV21XdEJyYnAyR2xSUWpjNGZCTVdYd2EzNkJxQ0NpZFgx?=
 =?utf-8?B?OHdTZ0JrbXkzUC82WTYrM1dzYjNsSFVSMzhkMHBtRWdWQmFST2s5K3FmRzdo?=
 =?utf-8?B?UXl1NnNOeDM0TUhFbHRGSEtUNjJCYk9DektRbmttMUN1NC9mMmprZXluYXNG?=
 =?utf-8?B?U3RmaTBjekd0NllSKzdwK3NES1BSSFJ1ZW91R05WN0thM2l2VWVxQm5QRjhy?=
 =?utf-8?B?QmVrMzlQWW1LbC9WT1hQRDlmZzhBdjNETmNKbEVGQTE0SUlQZVlhbC9tQi93?=
 =?utf-8?B?MEJCMmZSZURTNU1KRFl2QlYzQmtOeE9zU01wbHJ5TlpRdFBwcDJqWWcrTUtF?=
 =?utf-8?B?clVEZ2dub1JreFRvSUhINXQxN1VVbThHZ1F6ZHE5NmJHV25QbGdmQzhBY0Zh?=
 =?utf-8?B?SkJqNllYNVByNm5oVk5NSkVmUzVEQXMrYnRLNWhDUXFKVEhvM3BVS0FCMmZW?=
 =?utf-8?Q?IuWte/4q7Z6EOgq6qh4pfFgog?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814addf6-3c8f-4027-e34d-08ddc91d3373
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5156.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:42:21.4964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyTVy98Sx1dxwzirfoHO2RQEgZNUCsmRsk5lN8pwlFzH5EGQUqYPa2Qp8utdiY2hnri+y/i+8fbswkVlVtNy7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6603
X-BESS-ID: 1753188144-111132-7669-5058-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.243.46
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaG5kBGBlDMzNLEwNDCyNDCPM
 0wOckgMdHQ0tTQ1CDVIBXET0lSqo0FAD9NUgJAAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.266227 [from 
 cloudscan14-215.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Tue, 22 Jul 2025 14:43:43 +0200
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

Hi Andrew,

On 22/7/25 14:02, Andrew Goodbody wrote:
> The resolution to this error is not immediately obvious to me so if 
> anyone would like to take a look please?
> 

NXP downstream u-boot commit:

https://github.com/nxp-imx/uboot-imx/commit/5293b935e26a4fc5343f416f80086984c4c9b408

--
Regards,

Javier Viguera

