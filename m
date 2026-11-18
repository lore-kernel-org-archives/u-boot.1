Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE660A260A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MptJfHk4;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ORjotIAO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60B276085E;
	Wed, 18 Nov 2026 14:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHICFy4m3CGr; Wed, 18 Nov 2026 14:28:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1DA4260A7C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795012115;
	b=LTkxnWeiNJZjOENPde6he3CpqoLUutMWPVVvH2QQEOBP9+27yIESrdj1flyI9IFoKMez
	 sz/1ahB0PB06DReHy1GEPDCG76JIV33KFhNsJr89qVY6dbsCurmawdR05DQSbLFkX50eO
	 PNdoKw3lfPP5FxOjZJ66JNFgcshclJSf32z7wcWnLj3DhDvSbFs4ACDKRfShmi5F3/lk5
	 ja5Osx30SvKme4cKV0An0MSUytpeQ/IL4R67i1HKFYUA5ijqAzzg+gBGEy6VhRJe6wo3n
	 ALMZ+6T3arc/rXwiwCPUXGM/l5n5bv8R+0BnLHZJq/S3IK99ri3XS+hSkoJom0w6WSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795012115;
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
	bh=BO+RW+9U5Bs26TDA1u/4tvjpXMX5rvO6Idei1UJdHnU=;
	b=PFGf5Y+eKAt7549mz0XBkYljokfvEswcLJqBJAvgHwQMHkMvtxG7cVyPjJ69TliAizQF
	 ve43Mmd/lmSkoZkuQDu1wXRFlKHKJR2iNyRIpi2Z0bLlsFie6rtlTWGOw/YlfSwsvdRWo
	 XKVneDdVO1EZ8RrAGYDI/TgDL7uG6SalsdjjZF08r2yQL2wbrDVDxd1Jgvjxt+RkEozN7
	 eIwkXiJvNvh419qJDZnsaZjF3XZuwlOUAspvZzPubsVdojqw2FGZ7HDNCX9/a+UKJXmkF
	 LDdxmuea3gnot/S2NWn0ouVEgdR0cuzLoil7+dFx0iC5OAAg8SlhaZuabdutnuVTKMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795012115;
	bh=BO+RW+9U5Bs26TDA1u/4tvjpXMX5rvO6Idei1UJdHnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MptJfHk4H6VUmZUaiWb4VRmWuAvUdXKpUWRpTYyelrOwpaMcAeZbYhvvpX3YubjEy
	 hHKuZ2r8pEgzy9zbCA1oIVffUfhl4w6852puJEwHrx3GMvK10PdOLW3UZQ9+6pbVO8
	 eiYx9cTEp6eFCEjqE6Ii3Ucl0uus3cVQPi6eSGXGpG9UplDi8nbBZETDneuNJjfYKh
	 iryLs0EYlwHqgDZ69DdDHHkorJqS1dmawV/3XmyahgGFgeF4RSQRSOo6IUXs3lWwLr
	 P30uMMXZuKu8Whdmu/7U9l+ZdZoQkOEpfi1ODSROKKA838VAzYxjR0aQeA4pwSc5Ug
	 Yb7uE/YXibkMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DA4260A7C;
	Wed, 18 Nov 2026 14:28:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B8913C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14695401E9
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oza_VlAsb_0s for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 14:28:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F36CF400D8
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ORjotIAO
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F36CF400D8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO+RW+9U5Bs26TDA1u/4tvjpXMX5rvO6Idei1UJdHnU=;
 b=ORjotIAOs9r9ncqMKXMCl8ns00UfEtESwFy4saV/LzzCB4VlV9AWGDjXfao0De61ROPTYJZGaBbT4zmYrTe1I0Wu+W6MB+Qeshcn4W8YW21VH75UuAmUtAACM1br6XjdiP+Y8kaDBtW/wbpigjcExcUodWQqJS7QAQ+9mQCpGao=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB10853.eurprd04.prod.outlook.com (2603:10a6:800:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:28:24 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:28:22 +0000
Message-ID: <8bc1e86b-7a42-40ca-8439-c134b991acf6@cherry.de>
Date: Wed, 18 Nov 2026 15:28:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <d9ca273d-7e2c-4c77-9b98-1e877ad5e147@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d9ca273d-7e2c-4c77-9b98-1e877ad5e147@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0003.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::9) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB10853:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fc4bbd-5e5a-4126-2f89-08df458032ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|4143699003|11063799006|56012099006|261021121427099003|10067099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261022115727099003|261028144727099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 42p6HNrb+mA/Cv/OoGt3/1fcrBeqcOMQClQG7v/rGwPJpSNT1rSAXMvw9HhCzFJiB2PWWCur7XYb9uBzHI65ebQA7Gqh0P3y7SbFIEwZTENx0c241TVCwyTG6pJ6wsQQgqOa0wPXG60FpA7ZwVvUu7wsEjyqiPG1CGVQhKBa0SDiSUeyx3Fp1WfSzySGGTu2mv7X7l8IR8pcDbs9C19fdwrak7hvB5OszjT2kC4UXAzuXXDk5UcBzFEeV6ANFzUzEGns5Oim53jSao2Ui6SMRkKcsfVd6zFrgMy1VNpXzFxOJw158vEUIDzFzsQBFBlwTRTxTspqa1XB2QJIxUTFEU2MDr8sIPcSTquRGhkRqCOK5g6BNTeAAWHxv64VM3HU0J8rRjCNneUuu5vNtlosr6jQKzNq4HiliiONB5oIl8UeTN+vDXXZtAhdmln/xyZhtrTbuOMqvxJY6ph1gkjn1z9q3a4c/FUnPIrxB67fRX+HIF2obhR4QxNR9j6QnU62R15SOwdzz25JFUxQs4wnzf6sHEnPD7QuCfi5gND8Ie2pR9dgfde1mJOqdabvKNdW4L1sjyzl0XSd8bW7/1uw6nHFhAFbwk0v3VtNyA+H2vnS/qc/mnt7t/i79dIgBg6elif7pAPWEhhE3Y4RI4Dc/BGpDu2PByDgNd5PofpL2Zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022115727099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNyNnRXMUpISXZFdlVzZklXWlZSaG9nMy8zR0xEcjNFeEIyWVpvc0F5NVUv?=
 =?utf-8?B?YS9qRFdXb0k2RjlHTWIrZGU5bzVpRURNTUJrZEJ4YklraGszUE5rMS9NYVo2?=
 =?utf-8?B?NDVRT0VibzRxV3A4QjRYdWxrUURPMzVISWZFVnVXaVJUcks0bjBRTDBuQXdO?=
 =?utf-8?B?bVAyWU45YUdUTThMWlNiZ1Zvb3AvUG5sajJid0Y0TVVtRUIrWU9qZ2NOMStw?=
 =?utf-8?B?b1pzY0NwYTJYdEdYMWdCTjBPRlg1cmg2VTdYVno0ajNhRThqbnJoWUo0bEFL?=
 =?utf-8?B?SjZvQmxQL2xlVDJQYUMzeDN4dTU3NWdZZkdQM004Y3VUSXpCclFjUjZKN0ZO?=
 =?utf-8?B?L0hSazAyMXdsOTVDeE9hWjQ5STg5bURiZkJNMFRUZmZDVGpOMUJFWTl0SVRN?=
 =?utf-8?B?Skd4ZzdHc29EZkxzb0FFME5ab2Q5OUx5cGJJdXJaSndrY01FSlJ2OVIwbGZR?=
 =?utf-8?B?MVlhVjU2SGZqVy9QZzRSS3pBbnV0cEkvWHpnTnBBTmRJN2FNNU1ValRuaVFw?=
 =?utf-8?B?MUZHdlJRc0NlNklUUEQrQ01PcjJybGNZY29EQy9hZVY3R3lWcDFiRVZPbGx5?=
 =?utf-8?B?dW5MRjVrd0FHZVNVdEZ6VkxNNEhleTV3THd0ejJKdHJwcFBDd1RKQWZNUFlU?=
 =?utf-8?B?U2lSSlhheGdDanZ3S3REK3ZXaDNaeWkrL3hVMHJvanBldXlsR2svTlY0TTFz?=
 =?utf-8?B?NnlBb3ZhM0hPTFQ3a3p6YUliRExnUjIwWVhSSGZrcWpZSkx1UmMrczhoUlhY?=
 =?utf-8?B?c1ArRVJjaFcxc1MzNmZENHJCVVRwNVZiVUhBMWYrYU5RMUl3cjZ1OWpNSG9j?=
 =?utf-8?B?dXkwc1ZXUDY1VnNhc0xDQVlZMFBJTTNhQjh1ZmpQOHpqNDB1cGJDYVpQU05s?=
 =?utf-8?B?TmRlR1V1dG9nUHRUT3VCc1NIRDJtNVRwQlhuRXo1VzU4N3FlUTlPazVpNjIw?=
 =?utf-8?B?d1lTMmJyZjlSTFlMaC96M1YxUm13eTE0YVNXdEF4L2Z5djdLekNhQXFLRE9C?=
 =?utf-8?B?dVJlL2kxbDNTaXE2ekdzcVFPb1pvaGFzdUJqUlRybWpPaVlxU29nVUlJU3Yv?=
 =?utf-8?B?ZXdyUEFIS3JKUlRtOFNxWVhMK1pQb28yU0J3cnZ1QmowRlhUVG5WUlE4bVhZ?=
 =?utf-8?B?dUdoZ2h2cGxkeTJFSzJnWmRPT0F4T1QzM3NhVzh0Y1J3VCtxOTFJNlZUUHc2?=
 =?utf-8?B?SWg5OGxDMnJRL3BNczlpV3pLZ3FjR3VFSGxvOVFXNlo5U3A3UmxKU2RqeUlH?=
 =?utf-8?B?ZUN3OXNMNUFNY0JDTnBHM29BZlkxV2RPWjhGU3JrbnZmaVFXWnBobHRqNndN?=
 =?utf-8?B?Q2ZJQWVvbHNMUGJ3cUV2MlhSdWJCNkpkeHk2d3NyVTJ0TkJZS1VaMW1FZ0Vm?=
 =?utf-8?B?Mzl5QjZ2T1o3TUh5ejVPSVV6cGVMV0ZETC9YY0dGdWE1T0pPMU5oRGw3SkVt?=
 =?utf-8?B?WXpjUWUwRjFkVW5mTTJwTlJpRU5sT3VCRis4TCs3cnJuVUMxQW15TXgxTXBM?=
 =?utf-8?B?VEU4empXRUVhRUhVU0N2U045aFIrS1A3Tlo1dGJISXJOdnM2VGZneEJpb3ll?=
 =?utf-8?B?T2hrU1ZCM2pwb0E3a0FMWEhoUStma0hqcHM0WFpmaittaC9PSzI4WFRmd1VH?=
 =?utf-8?B?WUFaRkh1VjBQc05vVHJUMEZLMTZDanNISEgwWkFsMCt1b2hMZkxNK2lUK0J0?=
 =?utf-8?B?aWwvQzM0OTdsZTFHTEhrbFIxKzFsZ1BVWndVc1BBbWdmaDB1MFR5VmhKemxT?=
 =?utf-8?B?RVErVG9YaGx5Q3IyY2UwZVp1Z2l1YlNPM2liRk5jcGFsbzZDNW90dXRhZjlP?=
 =?utf-8?B?V1BaS3BPRFJQdmhiNzdiWm1FdVNXV1p5bEVVOE1XOEgza3JYRGZOK1R4azVm?=
 =?utf-8?B?K2VER1VPalZTbmVHOEVTaGlpcTFaaFpET2FqMU96M0lDczhSb3JtOTJNZXRE?=
 =?utf-8?B?S2ZnaThvZkh6TmtqbENya2pDVDdlNWsyUGJoaDlLK3c3bXNmbW1XbkJ4eUs2?=
 =?utf-8?B?M1NxTnhZM1FZbGN5RlJXdndGYjNraUxvZ3FtZFFveHY4amY0ODF5Ti83cjJN?=
 =?utf-8?B?SXNObjd6S0ZtZ21hOU43TnlydE5VbnVnWjRLa3B0RXN1cUZBd1gzdlpha0JP?=
 =?utf-8?B?em5LSk5NUTNtT3VscXdzSFhuMXhVem0wMGRzUEY4dHdxMktBZHlSRVU2Mkdp?=
 =?utf-8?B?eXlFbFg4clJhOThtNyt2NXJJWkVoRVdJTlZHZzhacjVTZkQvLzJ5R1pNd2R1?=
 =?utf-8?B?VUI1bjRPK0g1L0o0dWlpMWJuYTZ2YkxJQXFTdnVYMGNVWWxxcUpySkxVMklr?=
 =?utf-8?B?S1RReGpxeUhoSU5HWE83TU42M3BGeUUxdFMyTEJoV04rRXBNaEZUZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fc4bbd-5e5a-4126-2f89-08df458032ae
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:28:22.0226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDko0m8JNxCq1FEfxv8twU+V0qiKJCgROWHCgK9pr1XRZE45BqLAQVB2RHIpXPk6ekHb+uTbkNKLqKKbdXEY+EYUB6RToLHoNhhiG8yNPLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10853
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alper,

On 11/18/26 2:21 PM, Alper Nebi Yasak wrote:
> Hi,
> 
> On 2026-11-13 20:48 +03:00, Tom Rini wrote:
>> On Thu, Nov 12, 2026 at 03:14:55PM -0600, David Lechner wrote:
>>
>>> Anyone who has worked on hardware that uses a devicetree for the
>>> hardware description should know the mantra "the devicetree describes
>>> the hardware, not the configuration".
>>>
>>> Binman is describing configuration and not the hardware itself,
>>> therefore it doesn't belong in the control devicetree that describes
>>> the hardware. So we propose encouraging the separation of these two
>>> descriptions into separate devicetree files. In most cases, binman
>>> info is not needed at runtime anyway, so combining it with the control
>>> devicetree is unnecessary, takes up space, and causes DTS validation
>>> to fail because binman is not part of any standard devicetree schema.
>>>
>>> Currently, only Xilinx is doing this kind of separation. This series
>>> makes it possible for more platforms to adopt this separation. The first
>>> patches fix binman so that the image gets the U-Boot control devicetree
>>> rather than the binman one when the two are separate binaries. And they
>>> make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
>>> The remaining patches update the MediaTek Genio targets to make use of
>>> all of this.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>
>> My more direct concern with this series is, who has some review cycles
>> to step up and co-maintain this tool? It's already been privately
>> suggested to me that we could drop the lofty "one tool for every project
>> to rely on" goal since most projects continued to develop their own tool
>> for assembling binaries anyhow. And that in turn reduces the scope. But
>> it's still an important part of the project and so needs some people
>> looking after it with a more global eye.
> Sorry for my absence here. I've been burnt out for a long time, then had
> a lot of IRL problems, I am slowly getting productive again. Currently
> busy with backlog in another project I have, but after that I want to
> continue my firmware work on the many Chromebooks and other boards I
> have, including more binman work (assuming it survives a bit more here)
> because the general "how to format and parse data in arbitrary shapes"
> problem it tries to solve is bugging me in other contexts as well.
> 
> OTOH, I don't think I've ever been as productive as an ordinary person,
> and the reasons for that are still unresolved, so it's really not right
> for me to promise anything.

It's good to read you again, I hope you can recover as much as possible. 
When I sprinkled your name here and there, it was not to try to shame 
you on being unresponsive, just that the fact there are multiple names 
in the MAINTAINERS entry can give a false sense of "one fewer maintainer 
won't hurt too much".

It's well known in the Open Source circles that contributors and 
maintainers come and go, sometimes out of the blue. Taking 
maintainership however long is appreciated and you don't owe the project 
or any of its contributors anything. If we cannot go on without your 
presence, then the project failed to find a stable and reliable 
structure (I wager most Open Source projects fail at that). You didn't 
fail the project. It's easier said than believed, I know.

Please don't burn yourself out (again). If there's no time for U-Boot, 
then so be it. If that time is years from now and sporadically, then 
that's that.

Wishing you all the best.
Quentin
