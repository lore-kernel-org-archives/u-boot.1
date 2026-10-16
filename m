Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C461ACCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 15:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 767A781695;
	Fri, 16 Oct 2026 15:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id noj-QCeiNm2v; Fri, 16 Oct 2026 15:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A57D781690
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792164680;
	b=WxXz6EnYgeHfGrGZSwr11hlR9BL9GI3qSjLJ+xuA19MsNn1YRXSiqqbAV+PpwBwobPA8
	 qebhxS0jLf88853717tglcs+FGW+fxR0AFJ2xvO+Vk9OMoEjxcsPutxsEV+qVCbBY1ih/
	 9tzT8Zqf4RM5QXb6y6Et8xRRPiS0ITpxWh29tdhkNmKeCA1Fxs+w7SV28n3WmsioBn5Ym
	 vqod50kHWAij9LVWdIOhJCtlX/LFsc0NefagJ+JQUVY8lB+BhDzSDyK+yXZwSWP3u7+yX
	 NeUGWmAHLoSuHUbcFTs+LboRLL+f3mWii5fkPv6IiYWV4kwpfPoQpPhhFn7n4L+C19Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792164680;
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
	bh=LWPuCToFX62wA61aio380eADeqWf/GQxehASiNTJs84=;
	b=ARFoO+8yY6/HAYldKBQpZNGMsL0QLpADOCba07VE3DO8uP8HbAtUWQNRdlX7b5trbhY6
	 foA5ibSedNJKKlYkB8cSAKEM9yW11s5haYYTOWumsfXQQXMpUaybMGgkq2Z75dxbBNufm
	 lLG7RA+H7ldpvfBHk+tGZ0EjPQAhki0mwajHAShCM5Ld/MGmfr7iEmHEW4rBVAimmIAny
	 QjVeNcyYEY2rDn+1Yx91ONRBomoDUqEA6ksRngpLtuvlkV9CcT6qWzJMWmJ9R0cwcnQv/
	 ei7Wy0eipfdWA0ValAGxFy1VzfGI0wwb6JLSjjMy9J4B+AtPFKs8UwPExU2YjidvIWQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792164680;
	bh=LWPuCToFX62wA61aio380eADeqWf/GQxehASiNTJs84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DVsAKrkOd47g4+0H8DvHoIU+tPgZoWV3jPW0tQzus6m4Kh65kdIbTqRzubXDO8W7q
	 hvzRmuyUvfoIjUr+AbpXzkBfdOtMch5pkCuoksHosrUU4a1CWG9lw+hS/9iNPzO4m5
	 JkKZsPKT3nXL/Sg5T3yEhCGd97jm/uzPiMa9GDq4lKrVZmNsL5vKVfKEJOg/4RT3Kb
	 q5iXLEAKM+1QNa4MzUcyeZzdZX0uHQL6Loatm40bDBSg0G7dBtFtVFimxGGeh9YLbv
	 suczn6avPKy2pKFzi0tJzaWxh0q6s3Lh4BegOR501mujUr4ONtROzbAq9xJZKoSQWu
	 z0CBmyw4LHQeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A57D781690;
	Fri, 16 Oct 2026 15:31:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 825D7769
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 15:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7426F40B07
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 15:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWuXV3uHQ7Gb for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 15:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A5DE40B11
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792164678;
 b=fWpaOYU4Bs6idvGjxen0oOgMaSoNkgKD4TZL2zPk9MhPjhom+pYDJ/AaQ2TReAmOSYSV
 ShcICQk7hIWXZOvdzG/anU4n2nlfb0sbmzO/OWTjhsEEl37/LOFenXide9oHCeH+N2Nbw
 dJyPkyMc1vobU818JS7vb8by0QE57yKI6O7Rh4DTMFhTey2t7zvpM0NLHTIaP/MvsVX1l
 OtbkoRUKD67Y3AsEE/khbgM+MmfSjlZf23gVO6KOhICuEl7utabZk4b6jr3nOk9eySfrc
 TCU0PxfYV6SnoS/yxVcFWKJv6uhctikWDYWGNtWRziK4L8mYPNUAdfTEJKfT3IDLO+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792164678;
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
 bh=LWPuCToFX62wA61aio380eADeqWf/GQxehASiNTJs84=;
 b=KcyxOPq7ei8etZohAi9u3HOfGIhb4IUcAtgKO5460HmNxLlzbMCO6izToGBs37zga4op
 9no+gl9nraNGmn4ypWOQoL07n3aBfQrAFLYmYOlEtXw7OpXvyqtI60B3d6ayxwVWWg9K7
 4ijXWCHI9r6ovwKdmlYcLMQ04YeyHWP7RoyN5wyQOlnqj1xsnMuqib/OkdOcBYGfz02L1
 BjrCU2s1QM0XB/CW5e6CwN2J5OPvnZN0rEWbCu8z0z1ihDD/o4ZhuFUS+1hJB4OOWcP4Z
 E/1SvXd9eAQ8bwHzlseXFQqob+A4eTZHkB1Ywh+w/1jDMoh5Br9Urj9bOX/XN2PVCGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=IQmbEcvS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=IQmbEcvS
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A5DE40B11
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 15:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVTku73uERBgHLW62NWcZWjoHun+blCAjE/HlKXN9e6V+/5LKP1JUd2wca869uWz9/HKVTGtqtA4fu020JWAifrF644uBSdASjpOwta2VtYSKLd+6hQ8Gd+/u9mZm++Fe4i9N01QPpkH50Ixj1gCn7lNQgN2hv7pH1D71dc3jXnT/tCActZgcn0TBxJNkE93B1cJb20WTnT1THyhrljoRol5XDtFBizKHz5FajsaECMjmi2RdQc5k6E7edCk3ZowYFduJCKaT+mO2CDkUF067sThjWyOgLTRnwbl/dVBaA+4TWESIG+3hXEVqQ57ZzWhIwzPtFXCoumaBJyRvAzp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWPuCToFX62wA61aio380eADeqWf/GQxehASiNTJs84=;
 b=uTxdEScZ0iIb0CaO4HNRH/h4OmwDL6lvjDMkxVDsEQz8GHXzF/6bQexBEe61Cp/hpaoq3UlOQf+cz/EMfzgEj7gV3u+cGHePDcrmXpYykc//rID8o/ZurmlqjiNN2VKGrOkkYjvxBlXEiFd8NjNdC+KMP/dDNMg3Qb/+3B6bEXrQ4VMKgiNmxBcmToPJ7SMrgc0vXgsCv9WJ8HYTHgzUFnnoU9GfjHe6vqfWsQVMaokvsBMQHW/nOuKGG6T1HqeKnthQUlZ0GflQoEJGn3VZvmpEoJ/D1yp3RdK0kP0xzpz2Uqoeb981biFo2uTxZrTul5TrLIDa97cI+ugFMfzx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWPuCToFX62wA61aio380eADeqWf/GQxehASiNTJs84=;
 b=IQmbEcvSPLqac/JExlKfFaglammVkcPUwbE8sW0Lc4/rXOSiu6pYi6bTelmedM3NNZv9FlQJ/vsZZw7ZC+8frzWm0TLI/ZBe1J4sfC0THn14J1ufiNF8pO+m0T5sMoy55SOtf2KoZgZT9+J13SeTmz7MYZuybZFnICeeTuRCUO0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA3PPF2847FEF80.eurprd04.prod.outlook.com (2603:10a6:108:1::a5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 15:31:11 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:31:11 +0000
Message-ID: <a9f9d0bb-6e9f-441f-8017-9f52146c03f5@cherry.de>
Date: Fri, 16 Oct 2026 17:31:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] board: rockchip: Add common NanoPi RK3528 board
 target
To: HystericalDragons@proton.me, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
 <20261012-nanopi-r28s-v2-2-3d162759dd3d@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261012-nanopi-r28s-v2-2-3d162759dd3d@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0123.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA3PPF2847FEF80:EE_
X-MS-Office365-Filtering-Correlation-Id: c12b9e6c-6da6-4e36-2e6b-08df2b9a81f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|10067099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ByNqrRmQYpADjoC+sG1p9CCmQKrdhXXVile28aLeXxOD39nx3HQv/ok3LFN2HsKH41XpGOveBgAKNXJPLNrf3z5cFkdiNuZjo5sFDNh13VCIM/RJHs7WkpWS4Z9Ainuo814nXCG22U6KcW2ev4rbPNUQnJS3Q/3w4t47Sr5TR4t7WrhIrJcPUrcoTtA0s6/0moJtDnSDLpe+ztTbwf6kFGKO8k1B/PVBUqshTeRo1+UdQFX68u+uVK7vTaG0tXmHh08bIV9GOMhHe7++i8hqlyUhUhbqd0iie3Pitl9Qb4n8G5vH2jNjHV1DWdtNwcg2UVDSemgQOdO+P+u0loL+aZAl1jIel+4wjEGVp/oJic10qN3HpsRUfrzasadItjcjFfkq0zlbD3xH3v3aqMwX/iWUAFDrC/ge8LkT0RoHvxsbqvDwfD53EnmJhZWEpM6W643FQrXxEKrn29Z+bbYrJSQNqEN3BZy7Z2MHr9irLIX23iFyTGfWm5i0gW5IxQQlkAyqHEo6Hkmuab3ykoBoX1AmRk13bgVsWpjXn8bAC53GtUm+aOpuMvvUESpAoztyg14TRXkrWDoxkKIqsF7b8veie567E671nrEux89CeNsNiMGkGxxQUSH2a3M/vmubcS2NGJIXQC+wzB0j80capLxIcaD9EzhsOP1qpFDp4eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpVeVBXdUVsOVBBY2JKUUdRWk5kc2d5aURMSjNlalJQeHo0UXNnd3NmdFQ2?=
 =?utf-8?B?bnRqNTJBQ3lJUG9RaFBLTXNSbEFDWDNud2pydjU4OEo4OHJsTncrUUljMGtm?=
 =?utf-8?B?OHRNTDFQUVdsQ1I5S1p0TGJQOE5BUVNHSkZUU05BRHZ4STN3T0Vzazd2UGMv?=
 =?utf-8?B?K2tSa1dRVG5TQUNFOW5CRWE5VFdveFRxdDg4S0FkTnFuOWx3SUcyRFFkQlJo?=
 =?utf-8?B?THBWM3dYNWpNNjJwem43VzF5ZWVGOU55TUlmV1I1KzFVQUlILzd3cHJGMDJv?=
 =?utf-8?B?TVZRd2pWbStZS1RrTkhxaHZjSzBLblhmbDNnWm9JMHMvd21JTHFwdjVxczN4?=
 =?utf-8?B?VEFlUC9zeUtVVEJiV283c01UU1hhTFRFU2VmS1FSZUtVR2ttYW9ISVJBMUxh?=
 =?utf-8?B?aElKQmdBOVVjbmNVQ253RzBmQ2QrajZGd3M5WGFGMFVyQlVoREdGSjdPMFcz?=
 =?utf-8?B?N2ZCSFh0VEQvZ3pQQi9Ecjl2OG5OZUdkSHFsQU9VQUJ6Z1VQSmtkQXFkUjZQ?=
 =?utf-8?B?MVRHSjF1VEFCVTdUM0hLLzhtMVV3UzVjaHk0a2NhMWMyYXZaUE1ldXNlL2k1?=
 =?utf-8?B?SlhpSDJLaTJmdlhIeFA2Zmw0clhHbVRBVWdRTEVUMmk1RFNaWWdvOUFLaSsz?=
 =?utf-8?B?azk4cUIvSTFWWm5mMGI5NDlpcFNHVEpWSFFwRDdGajJDbU9FYWY5V0hNQ1dG?=
 =?utf-8?B?d1ZmUHc1YzVrR2NXOEl1dUQ1SWVaZUx2KzdXdzZJYS9TbE9sczdmWXdvem9n?=
 =?utf-8?B?RGxNSjU5TG84cWZSNENLcERkRGxDNEJUY3hFWVl1SmpmUnpXMFJMNC9kMk9p?=
 =?utf-8?B?MHkrQW13cmhNYjVXSXN0RDZ1RldNbysrRWdaYUpYcXhUdHEvMVFlbU9OZWVa?=
 =?utf-8?B?N2Q0dVBnbHlJV05xQVhVQkxCaVNzc0Y4MzJ0dnZkSmZSREtxK1YvaDhmS0N0?=
 =?utf-8?B?dFh2ZWxwVFRwa3Fnc1Q3MVRuQSthZnNvbWprdkYxRVBGSFY1ckNBNjNoVXFx?=
 =?utf-8?B?azkzSm92QWxYRmRKd2ZmK3E5RjBaUkdUK3FtOXRuWVl5aGQrWTVFYURqekNr?=
 =?utf-8?B?TDNGbkZsdHFzVG4yanJjOXlTc2hBczJRVGhwTys2ZlRCWlFGOXc4aHc2cVV1?=
 =?utf-8?B?RVZWVlIvNmtSRWJaSkRzZE1lbkhSUGlrVnluRGhvMW00WTZGSnpIRUI5UTlp?=
 =?utf-8?B?VldieFYrSENPWU5PdXR2UnFiSFpqazgyVjNsTHJUUC9tUzh0aHArMkg3aGxt?=
 =?utf-8?B?aFFYN0k2SkxBQ2xHdU1ZMDh5ellya3kyNVFwTDZEWVlVRGNsenoxaGFDY2th?=
 =?utf-8?B?Z2FYUWF2TVUrN0dFTmFiSXBhMlRLREZ1SkxaM09pYkt5bCtUbWIwY0JnNU9p?=
 =?utf-8?B?TS93bUdvU2o4c2FzL0dmTU4rVkROTERYK21Uci9nNEJMQ29YNWkzdFI0U2Vi?=
 =?utf-8?B?Y296NVRuSkgrSUlOcGdrelpSa2svWVpzRjlnTTFMT3ZjQkZSUHd2RHc2WVdF?=
 =?utf-8?B?bVB0bmphcENVbTYxeTVIOXUwLzBCWm5PYkFybk0wVHV1RWZqYy9jVHQ1UDlQ?=
 =?utf-8?B?am5yWUJSRkQxQWZKVi8yUFFkaTBLMVpvUlUyUUhEY0lIMTRXaU8waTUwME9M?=
 =?utf-8?B?aW5lMEw5SHFQa1JTT3JIZmNwYzBIeHFtNnorNXAzTmxzM3ExMm1iZ0l5MVpW?=
 =?utf-8?B?K0w0MzlXRmEwb2FOdmovU3hUOFBhckZKZ2V2ejJmc2EyZWNFeE1peE1UQVFk?=
 =?utf-8?B?WE9OLzFDMFdOMHZhZjhKL0NnenJ2aVppSU1zL3J3STRwMHBkd0k0UXh3amx6?=
 =?utf-8?B?S2tWbit6NDYvRXJMZ2lpMXZyR1VodFVOZDBaRHhXaldnN2NVQllyVndicVYz?=
 =?utf-8?B?RGtaaGNFR20zaXljVERvNGxwZ2ppL2RGTUNDL1hvc0FuVjRGQUR2VUFtZm9j?=
 =?utf-8?B?LzJIRkM2eHBiMVpQS2E4YzlKSG1PbEc4UHF4SUN5TC9YcFRnRmQ1dUUwaUJr?=
 =?utf-8?B?Wk5TeENPWGJVbkZ3d3h3S01nVDZETmExZlNQQ2RlL3FDVGlwMHFuTElTOGgy?=
 =?utf-8?B?UjZIM1QyZGdwR0ZnbzhkaGJpRWo1aStmTDlTTFF6MkdMYjhqSFBXck1PMGt1?=
 =?utf-8?B?T1lmT0svS3N5bzI3YzdsNCs5SHAvVkxFcWMxazZNc05mT0FoWmVPMi9RWU02?=
 =?utf-8?B?dW1VQ2NuamdsZmlyVmo3WisxdjdQQlBmZ1p4d0tZbWVPNFFpWngzRHpxdDU1?=
 =?utf-8?B?NHhveXFWVXcvV2NYRkNEOUkrc0g4cUdnaUk4dlEvcHkwN3llWVZGVm5aeVpH?=
 =?utf-8?B?NjMxMXprOWVzV2NVOFcwTFV5R3VkdGxYd2QxWTlsMDExUDl5ZGZQUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c12b9e6c-6da6-4e36-2e6b-08df2b9a81f1
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:31:11.6336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdCR5hrXKweKv1vnTKlrLLynIOpHHjHTa20x5svwGk4mC1gRRBOrEMJfr9ba6JPXSGgO9fIFWJ5tilMhT+JQbgoXJXsDDa0kQETBwqxiVAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPF2847FEF80
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

Hi 安容,

On 10/12/26 3:22 PM, 安容 via B4 Relay wrote:
> From: 安容 <HystericalDragons@proton.me>
> 
> The board variant of the FriendlyElec NanoPi RK3528 family can be
> identified using the HW_ID voltage divider on SARADC channel 2.
> 
> Add a TARGET_NANOPI_RK3528 board target, based on the Radxa ROCK 2
> board target, that reads HW_ID to select the FDT in SPL and to set the
> fdtfile env var. This allows one defconfig to support multiple NanoPi
> RK3528 board variants.
> 
> Move the NanoPi Zero2 to the new board target, it is the only variant
> for now.
> 

Maybe we should have a slightly bigger range for the ADC (currently 
0.180V to 0.253V when the target is 0.216V with the voltage divider), 
but that looks fine to me otherwise:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
