Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1A606A332
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fYsIevH0;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=V74Cwhal
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FF2B4088D;
	Tue, 10 Nov 2026 15:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEQDyfB4ahjk; Tue, 10 Nov 2026 15:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 560F640946
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794325444;
	b=ZGDHXy3sTzVn3vTGJtjNZDX0dF6uRbHhIiDAqp9nqpMipqFw+CZSPFWnddJlWNVJJEQy
	 ER3gLg1fN6mH4c7GNy+6VjaJbiRsSJbj8qoOhWIjDlpU1IedIABeHOEBwz+/fFng+mFOc
	 ITqc9bMhkoaoGD1lwpuP+d2lUzOYyLpBVSPGkQqHFRERbSQ7cfXPlOtTejqwmMcg3NNJH
	 gM5+hluBKXxAqyjR1ZV4tBUX1tGbuuAqIuKTlH9De8ola3uQ9wvVTjKnk1jIb+u8DZ/YI
	 wb8eEmnpBxnoe+1Usb/yW1QK7J40kCihD/f3S6RhZfP7x9yYrl52lccbGyAVmVwlsFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794325444;
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
	bh=lMzi8bRSMkvHGxgRlhlzONRrp6ekT3652oqDRyfg2m0=;
	b=p9By83n+MBAK/qSS8E7Vqg4FpBxG51RlJsk4hV6xxDE6XOd1Ecn10K1MVvl55iSKDXdb
	 XuzLzTc4xqsKAy9jmb4hvYbAS4KJMLMqEloE3rTDPlT8zyT7sIsvRRhQfPniPD4+pHN8h
	 4bJT6a+r45NDOJoCc9S1QTDl4D3rcErV4CFamVagrQxzByrb0YcehlfRY5J2bNn+1L8u4
	 KmH07pvyHrHmZqPTfR7bBnCEPhpdXwMPDsyf+Bivr6F9AAQmXa+Dn5w/BTtek+iBO08tF
	 YPIJEVhFLqtuBUxEtT0M97q7f0ZF4TYDfWZW568pDborKQLMGm5bT9xNdTj6zLX596g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794325444;
	bh=lMzi8bRSMkvHGxgRlhlzONRrp6ekT3652oqDRyfg2m0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fYsIevH0WetpwosPF5AeQ3OCgEuboUPgxqm4/CDUh15qdJxJ6GpdYkV9FxmV90gHf
	 Fh5tX4b/c77dL4zBjmFrZnt/xN8LhELKVXTn//NK2nDgL/eZFko+8zh/fvY0cHsAIn
	 4R+JLSuhZmD3tNCbC4bw5o7fUtHy0vUJNH+5e2BsQdVICbWCOtQq3rzCmUP+D0S/aj
	 TvNWTaZvMTAYQwHmsiGbqvINRpBUNY1EV22tAD9v+7dYppr63tD0yu/CU7mxcD+tGB
	 DOQZsnw8RHMeGF5lySWKP0sNDBzv0EIbMsQUQWQmzLAOc8hwNecLUVbn1+c85R7hGc
	 5isFZfbh1oD6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 560F640946;
	Tue, 10 Nov 2026 15:44:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71253731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62559400B4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:44:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bP02_rou4a5r for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:44:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7FFC44008E
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
 header.s=selector1 header.b=V74Cwhal
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FFC44008E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMzi8bRSMkvHGxgRlhlzONRrp6ekT3652oqDRyfg2m0=;
 b=V74CwhalQp38FBTF030FPi6qYCqYBfKUjVhYLpuyZXJirqI28/GpN9zoWMJdAo8qKYUEHp5hZeYT0pJOehVZrKQ1L71oF8/3iuORTz3UGddO2HHjrGreSDEYq9zCssy3MvEeyhYbl2VFYxzGcOfdcelGWS4KhLN3FalGApz2+RI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:43:56 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:43:56 +0000
Message-ID: <2007518e-6729-4eb4-b6fe-9e93779e1807@cherry.de>
Date: Tue, 10 Nov 2026 16:43:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: arm: rockchip: Add FriendlyElec
 NanoPi R28S
To: HystericalDragons@proton.me, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
 <20261103-nanopi-r28s-v3-1-ae8664fd168f@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261103-nanopi-r28s-v3-1-ae8664fd168f@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0060.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::14) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0495a0da-48d2-411a-1029-08df3f416dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|261102123227099003|11063799006|261021121427099003|261022075727099003|261009223027099003|56012099006|261026121527099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: dxaTF346QhXvz4rx1AR0+5ObZxKJ0axlty7V9f3mQQwQ4N4jWuthmc7qJvtNTx4x1U/ahOVKJjqgpsjtIbGv3ImYXQy1FVth3J5dUdyBPp64om89UfO1Zwm8CgfXumP2gmE4Iq7krBABUXubd60NQ0fhGYLamG0gSo1Zrx+AHc5MVWvJWw74JOO3iMqbNIblofU9nano28d6S6Nwe5nYrm4z+ByzA7OWj6zZkTWyCw6Hc9jXoGNo8GQb3OnuNAI1fPWcan3p23/633hQtsuUmjLgDkG3DYiNfNtIJpcariaXJKGMKovm0BxfK8mSPkODvkEMtA07OA7Tm8VWLkr/nn4t4ag8RiLAQhyxP5H6ZCwwGO4gxEFiCSne5QVfiTpPhPq3qKmkzwyL147lU+b8mA4+7b88EgZZB9Yrwfar3nS7UgmtmnnkHC935JQjlGFgB7EJklVUsiP/+QHB6DZrj5Jp0BWWbrdPFPJ4EsYAvxplSICk8oCCNv4Bio5cAkT+D9kUCi70VVerE/I+x9w4qjHi81jiGlIMC4y9P/t95PN/kPk86OeheBY1Dz7YDgNqoRUrnF2Y8Fuc3l7AF/V5sB56UA6Nhnkf+b0OCVof360=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(261102123227099003)(11063799006)(261021121427099003)(261022075727099003)(261009223027099003)(56012099006)(261026121527099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0V4SlNOdkZRaEUzd3NKRGgzeG5lYzQxYnBXcml4ei9DbUNYNkw3WlB5QXVu?=
 =?utf-8?B?cUhCTnhUTUlIM1N5Z2ZVV0dpaWQ4b3BmU1gxWkJTbEJzOUQvbzZGZ0tQL2dZ?=
 =?utf-8?B?SG9JWkVMaWJveGwyM1hzdGhSR3JjaXVSanZJRDhvMzVNdkV1ejdMTWxoSlM1?=
 =?utf-8?B?ZHV2TFlBREl6dlR1emdKZThBWVh4V0hObEQ0Q2NFbURxV2pVeXlwYmhCWXIv?=
 =?utf-8?B?VW00eTQwOWx1RU02ZnFtUTNpelVRTElKTEhBVXlCUG5xTXRTQW5nSm5ENHFC?=
 =?utf-8?B?RElaNDFUdWV0TGErZVpBZUtJWFFkNWpubCtnZzBCVWpPK0k0dUZXSE4vR3ky?=
 =?utf-8?B?NGd4eFBYdkhvUWRkbFFmazV6VmIycFZZQUFZSDJKV3UwTEJOTWh0SGR4ZmFG?=
 =?utf-8?B?UTN6QUFBWXBQOFJsVkRMMTNIKytYckpIeFlHRmpFdCtWYjRaZm5jbHBuZ2Z5?=
 =?utf-8?B?c3FhRXF3Y3dFMEpIZGRuQ0hubjNDNjk0eEttcVN0Um92dFZsc250amtRQmZ6?=
 =?utf-8?B?Ylpkb2pVbzdWNFJMaGRYWkhEbk8wdEViSDg2YkJvRUNUWTdWSlJoNkRnWDFn?=
 =?utf-8?B?SVBXZllpV29RWCs1UGFJeDhYTG1NZ1F3RzVxT1ZCWmNVS2FCRUFPMnNyS2JF?=
 =?utf-8?B?SzBWUW83aHM1ZVlEZW5jMkI0NFhBZ0luVU1TWUlFakdPMUV2TUk4bG9UaUNJ?=
 =?utf-8?B?cFczUGMrWHVxQXhScktmcGtGMGpNVE1BLzY1YndzZzZtOGU2OWFKb1BRZTg5?=
 =?utf-8?B?L05pYVBaamR0dWkzTk1lNVlPYU1UWGxVTWhnQXlKVnhvVmNpc29oV0E0MGxs?=
 =?utf-8?B?TERObHpiSkhxa0oybGRSZWFadlY0aUtxRXZ4eXNLU2ExY3F3N3BnYlI4eCtR?=
 =?utf-8?B?R1NYN2gyeUhFN2I3bVk5NkJ5c3l5V3lPUVBIWW00U3UzVmFGcXFRdndYdmJG?=
 =?utf-8?B?ekZKVmlhU1I4VEs0NXcrOGQ0RTBiMnhhR2MrZWxuY0dwSHdOSnNteGdjVjJq?=
 =?utf-8?B?TFY3dXVNbU14NzZQZFBuNkdaVlptaVBvdHBjbVpldFVSVEZrRnBvWVJsa2p6?=
 =?utf-8?B?aTA2VjcxblE1bldOQndFNGVuLy9iVlk1MnJSVHJBVHY1eVhPaVgySDdTZ2dJ?=
 =?utf-8?B?TTI2NjNpTjRiTCtzaXNrai9jWDhncHByaG1ZaHc1QkRqM2RDMU9FbGUvVVRw?=
 =?utf-8?B?aVhBNnoyUGRBRVdaV2orMnllRGhtbVFpemRqeGZCMTdYYnhzRHRVRUJWUHNk?=
 =?utf-8?B?UEV0RHJWVmErSWVsSlp2MzFGYVluL2tOejRNQ3RudVBiNTJpT2FFZStWOTFT?=
 =?utf-8?B?TUY0cmwzL1JYN2JNSnVBZjRMczFXNE55T2w2SVF0YmV0ZEpwS1RlTGQwQ1V3?=
 =?utf-8?B?bWhrKzU2aVRRZDZLdFJmNW1UQzJJdjF5ME56cjhVZ24zeWM5TUFEQ0h3QXNm?=
 =?utf-8?B?OFFwdjNMOGdKUXA4OTVObEZQSVBDME9tNmRKanhtdW84cGdRd0g3dVFZU1Rn?=
 =?utf-8?B?K3VSOHVNQU4xd1BubmNUWER5S2EyRlpkRWlyUzVsY2k3RUdEWWdzY3FncW1y?=
 =?utf-8?B?d2krMzRLWDZ3TkVqbGxrSlA2eDlpdVBEeFE5RHcrUlBxTy9aeG9hdDF0cFFh?=
 =?utf-8?B?TldtMHN3UmZENGJJMHNIQnUrRE1EZjVBN3Q3T3cxbTVNRzY2eFJwRWJOTnlo?=
 =?utf-8?B?RVhobE45TG1RTzRTRkdlODQraTBsLysvM0RNak5zTHB2aFBoeFJ3ejR6YXl2?=
 =?utf-8?B?bFhmUVFqUU8xUUNlMVNkbUpOaStWYlNOQ0QrdmdoVWZGM1NjcmxySWVNcFZz?=
 =?utf-8?B?YVZSTVcxRDIvQmorVmI2M3FGak9vSERVWEdWK2EzQndpZ3R3c3BFbGc3ZFEz?=
 =?utf-8?B?bEJEendEQlgyTmxGV2xJa1J2YzZZamhyaTBha3lIbU0zMmcwOGdwQ050QXBN?=
 =?utf-8?B?bHJVUlc4LzFEMXVnZm82SVNzRTBvd05uZkVqMTNXZHA5dVM1NTBhSmU5bmFw?=
 =?utf-8?B?VUN1bWYrQjRvM1gxeCtyRGZad3pDRU1BQysrN3g4ckQ4UkxtZ2VEcWhHTEVl?=
 =?utf-8?B?SVV1dXdRc0N6b2swb1pmSi9ZcmdOdWJhRXM2aWlVdEUrT3lxRWRNNTQ5am1h?=
 =?utf-8?B?ZnBRbGw0T0s3bXcrL0tXN3B0TGJOZ0V0bHFTQ01MNGVOMkNkcEJxWEcvTTQ4?=
 =?utf-8?B?cmhEZ2oyUlExanFCbDkwRUwzWDQ2UFpLY2crQnFvclhFVW9sbzVMYlF2dEFR?=
 =?utf-8?B?cmdqcTFrSkFsZTRXSWMzUlRvSWVLRi9mM3hlNXd1N1NlQTFSaHdkcXp3Y3g4?=
 =?utf-8?B?QVp3aXVvSStKcldDczZ0QzFkdEJwVi9GNTNNSS9Ec01NeDFadTdBQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0495a0da-48d2-411a-1029-08df3f416dfc
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:43:56.2329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TuQaHol9GL2O/XbUxftY04SUhYB6TOEup8nNaUuMFnfGnJLo8QN3XxxY+uJX2tTBJziM5f3OQS2epY9V+/ZKcJ2+T6UwUgo0bm+lfUSIYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi 安容,

On 11/3/26 11:37 AM, 安容 via B4 Relay wrote:
> From: 安容 <HystericalDragons@proton.me>
> 
> The NanoPi R28S is a dual gigabit Ethernet router board based on the
> Rockchip RK3528 SoC. It shares its base devicetree with the NanoPi
> Zero2, so fold both boards into a single RK3528 series entry, which
> further RK3528 based NanoPi boards can join without renaming it.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: 安容 <HystericalDragons@proton.me>
> Link: https://patch.msgid.link/20260919-r28s-upstream-v7-1-e80a6f8ef521@proton.me
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: bdcf29a379afecc02c3e99c0d1745363ad7a7407 ]
> 
> (cherry picked from commit e9eafc0ca521c8d12e1a65b43f899e336ef28eba)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
