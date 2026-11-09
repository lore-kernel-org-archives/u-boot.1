Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DA606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zY0PXWGl;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=B827z4ZI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4773607CA;
	Mon,  9 Nov 2026 14:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lE8XFTYJsFWI; Mon,  9 Nov 2026 14:54:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7C15607B3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794236046;
	b=PSVZVXFVfvs5oG9Fl/SiNU8/NWTEc6m0CLRKKTRv/JKY5Ntcf7IIwJonU5RHoe7JDlex
	 cUG4LRcVz25kqppn1NfBiiQpBvsAhTA9sOFQLagJL0OxsTH1HZddW1PeDsK5ipscFePYs
	 XswsVsuRb7pOlbbpCQ2kN2uFFgYHq2oUNf3fqqKz8PNWZkKI5p8dTIgpRB01lQ0/9I/kX
	 1jszrQnJR6RbwoHEByAHprMmp+atqJcPOi2zqHhVAavFlYTI789hbxVUWxWCN2bEbY54L
	 gKBNyudT0bch5e7l+7o8R1TLSluLGAGyx0Yd9BB2GU5DGu0IN++dDqmpyDstiETg49g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794236046;
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
	bh=BBaS+hAduFaBAwicnrFmt1Tnk0ChBUcglLiMklu4RX0=;
	b=B0XogYcQKyOoOTHQ36EhoGxXlgyZFJNm+dXJPNYT6nZGGlmG0X4R0NUFfomYEOobwFR7
	 ydjDPBC8SFKCV8CEJi6oxISiTkN4xVXQO7QWnvj8b09C38evX8NXLjI8XIKfIrmkXTlVU
	 Y16dY5rE6dxOO5X3/nCBT4M+ez5E0hOJUyQusZe6J5hllX/UjikbCQnIM6bEzMmJ6Z39R
	 fDtBT6t/fzsyWHu/CuKO3Rhjg5+dzZLxcdDTsbU70D5BHo1Jrc+s1sMn5q9wwgh4CFWJw
	 STS8JUSLnoyo/AcyoMwGoI0+0SA/AoGx6SC/HQv7CLC5qB8+29zIBnCnfkeNeMZFyGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=B827z4ZI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794236045;
	bh=BBaS+hAduFaBAwicnrFmt1Tnk0ChBUcglLiMklu4RX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zY0PXWGlYR82DFDIMZg2FUliZjoG7StxJraNiclhEZIEiPYUqTdJZuR5iwte4Us+O
	 kL2hv6SS4EEH87MDVH05Lz3skawrVn71EiMBl3q7jvsqsaENZ2biK8UxiRm/UHrvkJ
	 3xY9U6tDMsVJafjadLal+XM1t9cbyBxAFE9/X97EiD/y0o5TG4O97vpiiADSknT6ha
	 lgiYrAnBwRPuxg1rqbnE4E6q1uZg6v8EVe7rMQ7a3CBtzuOSJJr0s4SBKoXN5acPBX
	 sb8fPFcadsLGtoXv2CiKKxixlUWyu6tM3/d1Bx/AvbORxDFZ+F9vA5md7J+d3tWxAs
	 2aswb79FFfqfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7C15607B3;
	Mon,  9 Nov 2026 14:54:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E7EA235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 342C8607B3
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McHi79KQMIcb for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:54:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C41A16074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=B827z4ZI
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C41A16074D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBaS+hAduFaBAwicnrFmt1Tnk0ChBUcglLiMklu4RX0=;
 b=B827z4ZIBrgTPSYtAvI+RnwEFuR1MUZzePJ3ShLTJ43kfY2xdF39jY3t5SJx85iyYCKmRDVpxbZopQ9bR26Fc2dyeLU6kdJo0+JDcBFxBDhbxQVTZpSDMHz3AHPECLXV5DBtscNpwc3LYvozuATq+Gc+wPom6ZaqNhhA4Arv9IA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:53:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 14:53:58 +0000
Message-ID: <a6f38e2b-9af6-4457-9704-8d2355f173dc@cherry.de>
Date: Mon, 9 Nov 2026 15:53:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 19/45] doc: develop/coccinelle: update links
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-19-ee7573fe3a4a@cherry.de>
 <96de4f8c-f686-4e93-8dc0-babe27adcad3@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <96de4f8c-f686-4e93-8dc0-babe27adcad3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0171.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::28) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 34821c9f-2923-4e2f-0f31-08df3e714890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|7416014|366016|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261028144727099003|261026135527099003|261102123227099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|56012099006|261021135927099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261026140227099003|261026130827099003|261026121527099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: P2WezTW+5imX2HLmvG8Q1sb8KfH3beZXgNBBxuvaguc4gjbz6m6sbHAY13udHb/gB3mwPwgxWGDpRkvhReSbgcHCipH/hMjzI5gSWxk8muOgMiWfSLN6LYAfgfU3MEcWqsYmzcsTzcmm/d/hzkbWUjCeAsvjiaYkb81SQmxJBrulKaFh+yJwkQEG3oORUzcAXp+YGWc2RnbLtIaBWaKBfk3nFcTfCi9c/jZhZj4ErYKwCKuQDk/2wjq7wRhxD+usVUvBDutLdM6/aHCfDHY4gKwDVtXJbdIHiICeTQBpv3S7MEjR/Zyd/iwqPT5Hq5jbaNGt7GC+rCoD73Z2s6zy4gsgS1njrhLUv5opIm6HoyvNE7RC7n31HrjXDuUrHxb2qkE7x+95vMPUZ4UYJxmVOVI+AWlFDY9/dq/Cb+rv4dfqnWpfIE6e6xT9gGSYA1a4XHhq7EWV/icKEQjALbiqBMxVxS3586bXc8PmlDhmEnGL1YkSyOXCXkzEVKoW+sm7wcfrUdZ2nW7mirtaABoTmtIzjSfKPAm7QTFtacObvG+y89Oip8ZH0MrZ/PZUzNynHTM6BNu7O1rpjzqaX2+7Cap11pdRh3AEbcrFJLDoQaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261026135527099003)(261102123227099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(56012099006)(261021135927099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261026140227099003)(261026130827099003)(261026121527099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xFc29lclo1ZXJFQldVdjVzVzU4K1JWQ0gyUUxPaGpHOURxOFdkNGVkMnFW?=
 =?utf-8?B?WGpqU3dxUm1VYzFFNXY5SG5UMHJpWFF1andRM1d4K3crN01LR3R5N0RZR1E3?=
 =?utf-8?B?RmdLWEtBdnJrUzlhb3FmS2NwLzJmdThSTlFmOXZzanAxQTBjZmVFWXZkaWsy?=
 =?utf-8?B?NEVhaEdSVktWbjFMc0FnelNkS2F2S054V1p3SkVBOFp4NnY5UDBBejc1b3p1?=
 =?utf-8?B?cnlJbUNFTDh5ZkxKY0NkclY2QkVRWmFSV2pWZDdyK2wxSjdMdldHSFo1R1By?=
 =?utf-8?B?ZkZJVlVVT3o3L1Z4a2pkdWtxeXlVckxBSUhmNUFXa255cWRNM1B0cE04SElF?=
 =?utf-8?B?ZXVtK0E3b3hUU3hwTWQ4dkVseXdtU3V3UUMyVHQ0eXg3Tm56VDlxbWZ5K1ow?=
 =?utf-8?B?UlZnVG5jaENqWS9mVkl6OUlzamo5Zi9TK1NsZ3M2VnNKSnhqVnc3cUNZdmpa?=
 =?utf-8?B?NFlOMzNXaUJhdHRQY1NtUXE0aEw2a1JRbmhUN01Kais3SWdhandOa1hyWjJ3?=
 =?utf-8?B?ZjVPRlg4SlJWUjcxc3lXMXZWZldTUHA5NVlaWW93N0E2RTBCS0duN1hzZnF3?=
 =?utf-8?B?L1JvYlQxelIxUFh0cXpySy9OUU01aDFmT0tBZGVmclhnNENETHJxYXlZOW1v?=
 =?utf-8?B?UFBoNXgzOXlvNitiaUFxUnRNdk0zS2Q3RGZZYndVdThza2tTbURRT2p5b3lK?=
 =?utf-8?B?VXNrUzRmclJkUEd5Zm5xU3pKWitqMm5PbUx0aHBwQm1jSzJWTW5hRHBmRmI0?=
 =?utf-8?B?MGY0TlRSL0JucG5za0tBVjZjNFp1eEpPV29NUFJuMDJ4c2lsYk95K2hWR2hU?=
 =?utf-8?B?OVlrQzNtcXVHcjlyN21RbXJFM0NFd3oxQXJMQnFkTCsxcmhDRGE5NlVHaDBL?=
 =?utf-8?B?eG5BOFNtcmdhMDArMnhWZEFRSm1QcFFXdjQ4eFExZE9sekx5UWhZUTdGMDRN?=
 =?utf-8?B?cjZ5ZXlZTXpRVDZnb1NxV0lhaEwzN0dFT0Z0ajc4em4xbHZuR1k0M2phb3p0?=
 =?utf-8?B?Y1czQmV6V05DY1FwdUFORVBHbElXUDZpWTljeWVzYm9oRldNd3FORnBUU05V?=
 =?utf-8?B?cUwrSG1hWTVQRFY4dStMK0pIUWNVSXdhOVNFalI0dkhqZUJBdGVXZkU2UEZF?=
 =?utf-8?B?T3MzSUVPbkxFSkpiYTZMaWlVV3hCczE4cU9WNjhMYmh1WCtoRnZ4VEEvczRu?=
 =?utf-8?B?WlpncCtzNE5LWkI1REtPL2JZQVFycUVQL0k4SDZWUkFVT0pCNHdoMWhsZlBX?=
 =?utf-8?B?a25UTjlvK3h3YzllcUVXdUdpcFFKY0tZeHNtZ2ZVMGpSdjhLY1JXQm5Valpp?=
 =?utf-8?B?MnFjVUFBZzQzK3JVamF6ZnZGUWlIcjhITGd0S2RkOCtJS2pLU0orVmQrSVhr?=
 =?utf-8?B?SGlOZ2I5UjZSd05iK0dHc0Vqb0tBajhQcDY0NnBtVzFpaVI5ejhrellncTI3?=
 =?utf-8?B?SFV6bVVzd1hDMHAzdkhYdTB6Sk05OWJuaW1JN1ZjSnFpcDhqbDZDWktJbXh6?=
 =?utf-8?B?U2FUSER5WmZKNmZhUUVwT1B4UTE4YXRkQmdQN0dLNXltM0lhYjlwR05HZXlx?=
 =?utf-8?B?azM3MUVhMThYRzc4ZTE5alVtd3lVR0NuNm92dEh4WFVybndCTDQ5bFB1UGxT?=
 =?utf-8?B?TktrNkFsZzU0N3BqSFlFUWJFTzc5RlArY0NZZXRpU09tbHMzd3EvNDhQOENN?=
 =?utf-8?B?ZHVqelA3MFFEYmVwL0pKWkNuT1JGOTMwVXlqVW4ramxwckMrVW9YOUFlK05Q?=
 =?utf-8?B?cmp4QTg5b25aR2JsWHI1RWlhVTJlM0FNMWV0a0xGaGJ2VmRobUhLWktIa0ZE?=
 =?utf-8?B?YlZNQ2k2Y29wUms1c0QwSEZpTUJKbDJKcS9sV1VOYWZQV1FOLzZjY0hKMytL?=
 =?utf-8?B?WmZyTUNrVWpKZFhKSTZXMkJjTHNqMDJ1MHh6aDBNdUFnbzA1QWNvdHAzOTls?=
 =?utf-8?B?U1RWZ1FuaklwUTJsRHEyOGVTaks2MDJOSzNXNHVzekdYTW90dnM5UHZGRklR?=
 =?utf-8?B?VGVtbmR2MGZ6Z1MrNitCQTc4RCtGOEdBOGVWTHhHRkxnUGh0Nlk4Z1JCMWJj?=
 =?utf-8?B?MnFBZGgwRDhMZUNxZ3p2cTQzUlUwYTZJMXMxT1VZRnpEN21nQlU5aGQ5MmNm?=
 =?utf-8?B?UWZKLzNnL3VCREJXdEVPc2tsd3o3Y25zbkVPTDdJeU9FcUNUc3Z2cm1qckxw?=
 =?utf-8?B?SHNuUDIvSmg2Wk5aU1A5Y0tmd0R3NHpCblQyeEpnS0VINFBlZUNwdWgwV05V?=
 =?utf-8?B?enVlSDdrelA2VGh5NVczazZjWGxSSHorUGovL1djeUZrei9YVWI3WXdLRDE5?=
 =?utf-8?B?R09CZjQycFZ6R212OTRNNHEzeXZvM0RJZDBaMzdVR2trVEhjcTAzdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 34821c9f-2923-4e2f-0f31-08df3e714890
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:53:58.1262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mIYp3Z2WwTUEZi2sLyEkdR9ZcEGkoUtf8ko4IomntRE9fHf/n7M0oXFU4UR8LgF6z6qIZ7ZSbp9a6MsQkZu+D96LIO+9wZ3eZXa7/fUhHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237
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

Hi Heinrich,

On 8/29/26 6:48 AM, Heinrich Schuchardt wrote:
> On 8/25/26 18:49, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The original links often time out. On the Wayback Machine[1], the root
>> URL is redirected to https://coccinelle.gitlabpages.inria.fr so use that
>> link directly.
>>
>> [1] https://web.archive.org/web/20251028230912/http://coccinelle.lip6.fr/
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   doc/develop/coccinelle.rst | 4 ++--
>>
>> diff --git a/doc/develop/coccinelle.rst b/doc/develop/coccinelle.rst
>> index 70274c3f5f5a..54ea8eee0e9c 100644
>> --- a/doc/develop/coccinelle.rst
>> +++ b/doc/develop/coccinelle.rst
>> @@ -34,7 +34,7 @@ of many distributions, e.g. :
>>   Some distribution packages are obsolete and it is recommended
>>   to use the latest version released from the Coccinelle homepage at
>> -http://coccinelle.lip6.fr/
>> +https://coccinelle.gitlabpages.inria.fr/website/
>>   Or from Github at:
>> @@ -66,7 +66,7 @@ The wiki documentation always refers to the linux- 
>> next version of the script.
>>   For Semantic Patch Language(SmPL) grammar documentation refer to:
>> -http://coccinelle.lip6.fr/documentation.php
>> +https://coccinelle.gitlabpages.inria.fr/website/documentation.html
>>   Using Coccinelle on the Linux kernel
>>   ------------------------------------
>>
> 
> Hello Quentin,
> 
> The page was copied from Linux.
> 
> Maybe you want to add your fixes there too to avoid loosing the 
> corrections when re-syncing.
> 

First link was changed in 117376394061 ("coccinelle: update Coccinelle 
URL"), second link was changed in 87444fdce5bb ("docs: dev-tools: modify 
SPL reference URL to actual SPL doc entry") to a different link 
(https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html). 
Do you want me to send a follow-up patch to fix this, or do we just wait 
for the next sync?

For patch 20 where I remove some text, Linux fixed the link instead in 
4fe1e1dcca07 ("docs/dev-tools: fix a broken URL in 
dev-tools/coccinelle.rst"). DO you want me to revert the commit and 
re-add the proper URL or do we just wait for the next sync?

Cheers,
Quentin
