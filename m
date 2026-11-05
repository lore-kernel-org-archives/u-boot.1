Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41B606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SMXN6SAb;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=dz3WqGNc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAEB76078E;
	Thu,  5 Nov 2026 08:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gWu7AjLj5Awh; Thu,  5 Nov 2026 08:56:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D9AC607D5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793868995;
	b=a5iZ0pmLYpn/lmALS9V/m8bQXK5UaJz4ZNrl+4YBlddLH4w7xhRsBZMYg0iDdyPOln9j
	 3W22nG36S1MOanLXzcoqHk4iQ2wJbwkAHHaTpUWxDuFgW3Vjw1oHONYWGXUpV6Iu7TsDx
	 /Toj3HGc08rGwbqZHIMzFbnLu6VBdaEJpS4J3z1RiLKhfDOurDfNArffwkxhDodFgEhqH
	 +mIRGTKsBnvpTUA2hLcILMugwi3APBtVRaCuMHt318YScrKxso/wuq26mAku9jS4DKg7t
	 DkgjNN8ELbP3JIHZpOoS68D7NEPG0lvC3VNJics8yVffAkJZ4U4d8YgfVSN39kL+ebA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793868995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wdRPeM+2NS0XDggqSy0D+Impsny8zPwGBPoGpiI0SEQ=;
	b=P1EZ+u8TVAJFUL+TuWlutfs1SqPglXzn1MzssB36kNd8OmSBHGr5rymQ1r+nruwN97Ew
	 M458hp75ID/bds7W0qY+RJ9TmFvF+ebr9Tj0tQcdVyO+jmTLPt7zPMg6728Y+pVeyAFc/
	 rAd61pu8EO2nuxEYkRMxuNnJX2lnMEEQU2bqQXr1O1Rn/UM0mCDLf/yDMOgQm0QPj8Uf+
	 Qipf72ILZ7/Cdpe2q2mpIjnx7UxrfZjPYdpm2YXmaMArrjY0PWO+H6p2hqXy5OdNKk6pC
	 MZthHowHZ0Cs2Ua5odeHihFGxsXz5SYGdtnEm8d8onpVRQ3lRxb/Q8a4NDoyauyDijA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793868995;
	bh=wdRPeM+2NS0XDggqSy0D+Impsny8zPwGBPoGpiI0SEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SMXN6SAbnmVAToyGGes79HKiw8+QVQVS1T5KXCKKvzgjWs7TCJQ99ucg7iQAgMbBi
	 CSDUhDoXOGIaWOaEOLeFpWxI1FpF0kWSMiQVY62bFAPx2cD5JpURns/rLov98Vd76s
	 5uYGDyy7H38flLiENklOq1AHbi/PYkkekeD/zWODSLLl+7Rs315MteXrrciIV1DL0U
	 nH+PreG/jJuWBjOxaOcnCmshHru/KFDIOC0osQjC/YB2/yPjwTF8XnlmoFOI+nvUZ4
	 4BJJdq6gihii0KtJiYOmxoR0nMCpstldGh2Obh8KmErLVjOkxA1lEf3R/C1qcXCPbD
	 NZs2PkIn9kjiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D9AC607D5;
	Thu,  5 Nov 2026 08:56:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 245F531F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 08:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15AD54008E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 08:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmm_7J5DR7kI for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 08:56:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B4284401E2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dz3WqGNc
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4284401E2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 08:56:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE8384823; Thu,  5 Nov 2026 09:56:27 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A89984820
 for <u-boot@lists.denx.de>; Thu,  5 Nov 2026 09:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdRPeM+2NS0XDggqSy0D+Impsny8zPwGBPoGpiI0SEQ=;
 b=dz3WqGNcRx9mQryhBW05BJ1euZaAfg2lbaffF76QARecJP4KVPgfuny2B2q0WpxhSJHuRE2j+OKRsXac9efhOcvRHJQLfjYtvsZR+McbkU1xhN4NTwzctZS9qUcwEULDqFhVd85gEOQ+MKqmb6Lf/wPzlbkyEZLIxfUHxBebgAsdgCCWYuyTbIx88teaIH0gRGSAoyerGQBuFDF+06SEoqaNnrLH6Cs08EfdNOSvbJNTfWaHSsaMdhMOGjPS7WBH53gKHiVbcCtBPLr0Y+7Ba9qdIDKJOKLfGOu94IKyJs8IZwxP/vSJZ0jQl8JQQ0Jt9mln7bpy8cFC9HzNR9igcg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by SJ0PR03MB5807.namprd03.prod.outlook.com
 (2603:10b6:a03:2ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 08:56:10 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 08:56:10 +0000
Message-ID: <925f8741-16f6-45e2-b61f-992877d50137@altera.com>
Date: Thu, 5 Nov 2026 16:56:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: socfpga: Add Terasic DE-25 Nano Board Support
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Markus Schneider-Pargmann <msp@baylibre.com>,
 Bitao Dai <btdai@terasic.com.cn>, Shi Lin Teoh <shi.lin.teoh@altera.com>
References: <20261027020843.20406-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261027020843.20406-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|SJ0PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fe281a-243c-4490-77ed-08df3b1aa316
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|10067099003|55112099003|11063799006|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261022115727099003|56012099006|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: +QKVUr1b0R+GR+HLQ45T4qnC+dm9B6RhT3ft9fW4PZrcHNouINv37kTWw7z1p073HOVeIPsWCR56J5PqFULKKnY9Ql74/8YY1LSgeJf+Lm88mGg1qfbjj6BENdMmqFn4T1CmDa95Xw71+vnDxXbRDebSCt1KAPNzMwMeqAHGnWhe9EkLjbWjmL2fL8p3z2OlIf5QZp58h2troyldksZSYNZzDcj37S0V+DQ0AfCkX4h0UVITEy4bl35EkYl/agFImGw3vkksoZEG+qycMACFO5JiPa5vRo05dSoQMae6gMWfWL1gQROsJCkAlrO2mkP1nMGwWzn39286VzL2DYbVwSMxyxEASAvytKbp+0DrSvjFLjgDaCq//pqmruFFKfTAFrVAu4U7a7EGyq0o8v1t6DNbj4/Pg7H/vEkOeO2u8pGWUNjp0/j2sfMEKVjseRvfHODimOwou9ujWZMfAIoXdahjLs6NCn2IHievrHtvFH5WTUMttTaCMHK90aIqY1Ko3HPUEZSQNJk4aiv5r49hNhDZ46ve2OMHA3jKw4iUWfVF1/O5UMNfngpkI79x35BW97ZyJDS/p7xiGNvUsj01HhbqByI94xjNUi+DX2iyVyY9DB+HTBczr0acWkZTtlb50xz0L29G5nxb7dLk4oBlWPZgNW7jnoH2HyWjrZJJA/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(55112099003)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261022115727099003)(56012099006)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MngwWm1tUit0dkdjNVFhV1U2N2pSZ2ZFNzBVODcrNkEzYXBhQ245RjI3Zkp5?=
 =?utf-8?B?VmsxSDRTUnQ2SWdFeFNRaWVwcTBINHJFeVhVR3dGYS90Qndwa3VuNmJiUjVs?=
 =?utf-8?B?b0E2dnZqQmNwRGRuMDcrODczbXliK2ZzUVRXV0tDdmsrek9MeStCdElQRytu?=
 =?utf-8?B?ZEd0T0hJbXdPbGY5dTFvL1A1Y3VnWHNvekNWNVRISHJoOVRPQi9hbnFQWFpw?=
 =?utf-8?B?SWk4aTN4bTVOc2N3YmtrM0M5eFNMSmFOWVR0SEkxZTJzbTIzWEJkYW5nRVgx?=
 =?utf-8?B?bUcrazFCYWh4OEJOc2w1UG1qMWh0d3paQ0RrU250ek5McXpCT1BDRU10VVNR?=
 =?utf-8?B?Mm05QlNFY2FnUE43Tk5BV25UcSt2ZExPMk1xSkFKYld2ZnJUb2Z3Q2RzcWx6?=
 =?utf-8?B?cEpMNWQyZ3FuY21OTGtzdXZMODNPZlozSGVJL3R0NWhWeGFraFp5Y3lCZ1A1?=
 =?utf-8?B?ZjRJVnZCQUUrd0xlYmpzZFcwUHA3TDVxbVRmcm9QUkZUNGh2RENIQjJKbmdN?=
 =?utf-8?B?eVlqNWd1VGdrdEc3ajJqZmIrdU1vY2s1UGVuRi9DTkZYQXdzaGZtRkJZQm02?=
 =?utf-8?B?MkYxamphSEhwTUZhMVQrWTg1QmhPQmR2cVU0OXplZDRvcVNjODVrc0tpSHVo?=
 =?utf-8?B?ejMyWk1OaGtlaFJuNVhYekRhY3FiSGFGWWFraUNhSjdIclArRXFoeTRVN01U?=
 =?utf-8?B?TSszUEN5UnFDTE51eXBwcTMwWExrVExqVERKRDQ3Z21tZTdsRlNIQ1JrWUtB?=
 =?utf-8?B?THVnUFg4aFkwS3A2ZWZudGpuSm1DZWJEMEV2R1ZMMWxYZjN1MVc0OUxCeG5X?=
 =?utf-8?B?MmVCSmhjTnhzUDZJU05MTlUwRnhsWVVqVVU5OWMwL3ZyV2srTktkN3BMdnpk?=
 =?utf-8?B?TW1Qazh4VFVjOGR6bDAxaHNYbGFPeWZKSElZUG1iMStYWHFWY2t6ckw0eDI1?=
 =?utf-8?B?Z2dPOXRzUkxhak0zdG5ocE9PL3pHZy9tUlhCaFNxNlovQkUzT3F0dXJHTG56?=
 =?utf-8?B?MThnQTRwUE91czAwVTY5bzE4T0Zmb29GWWpGRlM5V2ozUDY1U0ZDdHN5M1FI?=
 =?utf-8?B?MWo1blg2SFFSZStZOGN2L2hOcnVBVTNCa1RkNWRZODRCVFhKRUhGNlN5elBh?=
 =?utf-8?B?cHpDWjZ2MERnbExRcWRMSVFrSmF6Z1IwTnl4NjFlckZoNngxSFpxU3k5dXRF?=
 =?utf-8?B?dkI3ZExoSDJKZUkvUWxibnhCSXhPOE42WnF4Z2hrYVdQZ0JWa3hjOFZOTjFL?=
 =?utf-8?B?RGgwZW9XbW13MUNWNi9oRm1mNXJXYmVTRC94MlJZYkxMakJ5ZUY3QmVQZHl6?=
 =?utf-8?B?Q2Y4WGU2YnBWaVhGY1dubndFSXpOMVVPSXg2YlpKMEg5emV5c05JU0RzOXZP?=
 =?utf-8?B?czAzRk1wQWR0ZEwybUhXTW9YemtNK1RIQVZFTVM1WUpIR2FLVGdPZmdHZXho?=
 =?utf-8?B?cGNabUFoT1VoU0NNc0lQRGxFQktUUitTcE5tSVA1bFQvOEVjamFBUUFXdUJh?=
 =?utf-8?B?QXBDOEdBdlhOVFZUMWpIb1d4VzJaeUV0S0Ewd3Z1RnpTeWErRTkwMzFjbUhn?=
 =?utf-8?B?Z3NmM3pOb1JJWFpDa081WVVLUG1qQlBKSDAvN1pFb3NSaDYwRFlUdk9rUW15?=
 =?utf-8?B?UmtoMG5xQlAwRUFSaXNWeVVjaFlERFJWdzQ3enFjMUJLSlNjL3J3d1psN21a?=
 =?utf-8?B?VHpoTVBzWENtMnljMytsUTRYQUJwa2VHb2d3U1p3VXMxTEQ0UzlyWmlwZXAx?=
 =?utf-8?B?cG1lZ0JVL2NvdGJHNWFRNzl3eTN5N2ZkbFE4Y1REdHZQVm5vVVc4MUVhcjZI?=
 =?utf-8?B?d3hRbzB4NXc0SjR4Rm5RdkxWVXFDK3poa2p4TXc4ZUphSm9Zb3RBY2dlWWlu?=
 =?utf-8?B?K0RZejFUMDNoMlpsTUV0MEpSbzcvOFBjWm44TVpGUU9CMmFPMnczMzBJR0l0?=
 =?utf-8?B?OUlDZUllSlFpOThUYUJZejQ2RVkvM1Q2WC9Qcm84SVk0SThQQWdwbEsyOWxm?=
 =?utf-8?B?ekl3Rm5Fc3oyWHhOTGZON1JnTkVBejJHNC9VNlBRME03R1BzZVlaUnBjQjdJ?=
 =?utf-8?B?elo2WXJ3NmR3bnp3cmowcEhFMlVXS0NTZ0E2OXgrMGpHeklGSXZabmx6VVZO?=
 =?utf-8?B?MlI0czdlSHA1cUgrUDk5eVE3WVhnVFdVcExreXpRbGFhMkMvcGRrT0JHNHNv?=
 =?utf-8?B?Y3JDSUJvQXhJUnliZVJ3SnZaZUxUWHhRL0YvZGE0SkJYRDkwS2k2TTJrVlhq?=
 =?utf-8?B?UW00akkxNDZWc2pNZHJDb09IalRJNnJQUEhDbGpkeGg2Q2Rvd0liRTdPNTg2?=
 =?utf-8?B?Y3RJNnJ5VGJLZ01YS0M3c1plbGxtQzZSbGlUaytBQVZ1RzN3bUg2S1ZIZ0lj?=
 =?utf-8?Q?ISt/FKo7UYm7To7w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fe281a-243c-4490-77ed-08df3b1aa316
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 08:56:10.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAkEpoV9rNe8Z4WHJldCSYl/EG39cMVeG9MJ4r3ihma+WjZcfGT+C+nVR+rpHslzweXIUGLx7WAvtCZ/bck6oXVHRa4mwbkX32fWuULzwQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5807
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/2026 10:08 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Add dedicated device tree support for the Terasic DE-25 Nano board, which
> is based on Agilex5.
>
> Following Terasic's Linux device tree for DE-25 Nano configuration in which
> UART and MMC mode differs from Altera SoCDK boards - enable UART1 instead
> of UART0 and using SDR50 instead of SDR104 mode for MMC. The device tree
> is also tweaked to enable the 16MB QSPI flash to store U-Boot image in a
> single partition for QSPI boot.
>
> New files added:
> - socfpga_agilex5_de25_nano.dts: Main device tree
> - socfpga_agilex5_de25_nano-u-boot.dtsi: U-Boot specific additions
> - configs/socfpga_agilex5_de25_nano_defconfig: Board configurations
>
> Build system integration:
> - Add build target in Makefile for DE25 Nano device tree binary file
>
> Signed-off-by: Bitao Dai <btdai@terasic.com.cn>
> Signed-off-by: Shi Lin Teoh <shi.lin.teoh@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> ---
> Changes for v2:
> - Commit message spelling correction, updated SOB lines
> - Enable sd-uhs-sdr50 with matching Cadence PHY/ctrl timings, drop
>    defconfig UHS/IO-voltage disables so SDR50 can be selected
> - Align MMC sdhci-caps-mask with Agilex5 SoCDK (0x2000)
> - Keep SD regulator GPIO only in -u-boot.dtsi
> - Align QSPI compatible with MT25QU128 BOM (mt25qu128ab, 16 MiB)
> - Drop undefined CONFIG_TARGET_SOCFPGA_AGILEX5_DE25_NANO, follow
>    emmc_defconfig include pattern
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   .../dts/socfpga_agilex5_de25_nano-u-boot.dtsi | 158 ++++++++++++++++
>   arch/arm/dts/socfpga_agilex5_de25_nano.dts    | 175 ++++++++++++++++++
>   configs/socfpga_agilex5_de25_nano_defconfig   |   7 +
>   4 files changed, 341 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi
>   create mode 100644 arch/arm/dts/socfpga_agilex5_de25_nano.dts
>   create mode 100644 configs/socfpga_agilex5_de25_nano_defconfig

[...]


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

