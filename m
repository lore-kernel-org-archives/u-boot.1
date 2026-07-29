Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA9FC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBB5560760;
	Wed, 29 Jul 2026 05:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yEIU8aBOwyfs; Wed, 29 Jul 2026 05:48:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D041760762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785304116;
	bh=Dgo5J30N/5E/UarrWeKkU5sQA2ahajeTnorFuv6bIY8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NJsoX/CQtw7ytUJ9YAGj1yktokucx5DqctngFtU4KS5OsuIWA6xab47nilTFs6HdC
	 mdVUk4uydY90GXrP3sNjF0CAB8wwh6V1qtBz9Pf0GG5EODxLP9NuPXzqz+nc1LwJfB
	 J3PE5L6WpLZWGPx5jxlmsCi5Y3BYRegtVGaAOayh9KNCF7e+DEJldxQOCaoB1OZ60L
	 HO195MG9jVuxvOvPp1w2Q7RlNgDky1c21PHJbtupZrSN6AGq3a2pfhz7cn5rU1E5O2
	 MyKvt8n74yho0MAnyFfLLXQM47Wm6bYWk4khofATb7AalBpoaoLVcchKq8J0i28jQU
	 kp2wUwYwnAqVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D041760762;
	Wed, 29 Jul 2026 05:48:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C0E045B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7588460762
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:48:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3PEwAqP3L6g for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:48:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3349F6073D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3349F6073D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3349F6073D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:48:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A078494B; Wed, 29 Jul 2026 07:48:28 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0488404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:48:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3LaOaExK9jUAZuG03cwdOZX4s2MUzXXdvTVO02hjBspcWbH2fugGktZ1z2vJ0PhUrIfdBPs3LWbkfedJn6FBnTdtkqZwMjnwdTKuMIXID2r2VmDQDU48pTw9WV+DiYr8zs4V4KYdiRMcRNBgLZ0qr9IGfpsGjiR1XaKLtDiMxpykeDTN+Hs1PFMSTwa13vfaXnLHzMS6ux9BYZi0sd4T6vdSoRfyttMkEQmMcv47X1idoDaKDuTSi7swmBdB0zLcGIKDe7JtUybiGo2zM+Yg4zmlNG41LEIcmqDv+ae0KUBd0x2rpoFRWQEBDJQMuNFylwIB3mSQi3liswtzMVxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgo5J30N/5E/UarrWeKkU5sQA2ahajeTnorFuv6bIY8=;
 b=qMNw0ZYb8HMAwK7u4YXs/eiPFrRVe3rIP2VAKEw1h70YtgE9Glnzd7eeiAPDk8EnXU2OfjUBhhW2546/uNAmO/CQDNCfmgsQIQSOnR8rcyhvCJNMXJpGefVqoYjAwP6eRAVJQ2EChsZT1tpC/WiAKjUAFjmM7BpwjO7zMOO3zDQlijbRnMtHn36l3BSI9CK9DE7Hq7stFh4BJLf9lG3J809Jd+M8dZoCmLGlj+pKZZ+14eNxuC797pAM1p5VRV1gtesHNpcwuH047aiQTU4bhMJ8oeTr4RM9Vx7UENLrDHuVQpJE78cv/a27W97EBKIUS7x0R29b2V3hMC+h853+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA6PR03MB7806.namprd03.prod.outlook.com (2603:10b6:806:430::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:48:20 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 05:48:20 +0000
Message-ID: <88825616-6911-4762-8c5e-1133ded32694@altera.com>
Date: Wed, 29 Jul 2026 13:48:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Add fitImage for SPL programs periph RBF
 only
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260311050319.24941-1-dinesh.maniyam@altera.com>
 <b91b4abc-c060-44fb-b99e-a3ac6f12aed0@altera.com>
Content-Language: en-US
In-Reply-To: <b91b4abc-c060-44fb-b99e-a3ac6f12aed0@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA6PR03MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7910f8-d9a0-4d0c-5352-08deed34fe20
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|55112099003|6133799003|3023799007|56012099006|5023799004|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 7jYK4ldF4ojkiMIOkcjYM6BRq7/vVAbp+9Dbze7yrMyqrRn9a6dIHmR2J2KOWwo8nJ3xDneYtGjEHCtCjThSh87j9l2TmPAg8gjaFQMGcsyZZFWU80/VF+NZffS+y0qZmWwwMsRY0UMAPRTI9a5wUuQihajEFAlPFBqFsqh7CT9VTr33MpJ8ehpg2a13ArxrbSG+ZIlj3+fbCmjGcJniDW3yRG8v9XYTqtTie1lz/5uljiR+KWPAD3mcDB3mbiMxiVCsmTfqPq1tJv9xFr+ehtI53N3oGX7MVQ0GQRroS/5upKsd+dblGhhEW3FPonGfTrPv0TgSzFvgNb0X9H70x/M+nC/ErXVZY18/BBrYHeee6F7jcQylWTcLoHMnGz99PHWj1bbdrWwBNGTHPqhwd82Z5WCZw6EK1fc3cKOaZI0o6S9nPEHRHoQQw+QoAjVOITcF5/i0PK/Y9OrUGkjLEHlHgySDf82BfXk+v+4j4vh2j7mkLT27NhXRxgJXxsXLdV3nmLc2Kzp6ik5T1vSBZXm1FQj1r8OFjPxDpnqYaxeVnN8yVuSXAjPrRMl6Txu9wS3GieygGYPTs5DTuycVlW2gUOtUE3Bkg3MNMox6KtOREY3DDNTfuagsI0nPpBdX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(55112099003)(6133799003)(3023799007)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZCTlQ5anlQRkdkVTBzbG1GVnBuOVQxNXlCY3FEYXNlWTdzSkpkMEpFeW9S?=
 =?utf-8?B?RXl2eGtndnhTWnFIU25EanZUZklZWDdWbGJKdlE2UXJxR21LOUpONXVIakIz?=
 =?utf-8?B?MW1OTFVyb3BFSzhSOHBuNkVaMTg0YnZwWHJZS0dzRXNGNlhxSjBjZDR3STRL?=
 =?utf-8?B?TmRQSmF0TlEyNW9IZkw4dXNCa0JSNTVhcWNmSEFQTjhsVjM5UHRCeVFRajRv?=
 =?utf-8?B?TE54L2FJMnRVejF1MDdJT3FiODB4N043MU5ScUpUN2xOSTVxL0VYZTk0cEYr?=
 =?utf-8?B?MWRoK2Z6UzhQaHNIQ1ExVWdvZm1FRGZrWVlMNHN0ZjcycHV4b2k2UDVTSW82?=
 =?utf-8?B?NEZzdXZjK3VSaCtoSXg2RDE1MTZheXFTb3RUejRxc2piSmQ4YTJkWnpqMmpZ?=
 =?utf-8?B?ZnZYbXptbGxZK1ZTWnU1Z2kxQWpNR2NpU01BZ2VvSkFQNDFOblJSR3RydXdk?=
 =?utf-8?B?dllRZUJCcHAyNytmUUlMR0xLY1FMWlBQQi9yNGtpL2ZQcStDRDNkbC9SZzgw?=
 =?utf-8?B?Uyt1Y1NCSUlycVZPMmdMNUNidzhhSVdsTS93UThBVldFU1h2MXJmQld1cUlo?=
 =?utf-8?B?Q1BDZ2t5OVJsNU5lZ1poYzgzOUM3bXAxZFhBUDk3WXRuMVdtbVU2VVFiTTdx?=
 =?utf-8?B?UHl2dTJTQ2lVdTRPVGc2dHBGcjA2QjYzWndLelU1eGlMUFk0Z3VnTkRMN0lS?=
 =?utf-8?B?dXp5K3o1SUtZWVdlWFBWd1hlUVpsNEtreWlnbDM5SFprZ2tXMDJrNjJ6MXc3?=
 =?utf-8?B?RmF0VG0xYnR3aGJ0T1VodG9wT2tVZGw3dm9SbzdkZTdyM2JDbVExWUZYSkIy?=
 =?utf-8?B?SitneTJiTDZWV1M1TUp0UmhYMFUwUmttWEVpbHZ0cDEwMmoyQndlcGVFUXRj?=
 =?utf-8?B?Z2g1MXZiYnFFdnd2eVdSQldlKzB2Y3ZZNFdtc2tyajZlczJzVzBYTjFQSjRs?=
 =?utf-8?B?NCtJQkYwanluY283bzlGOWpxQzErMmgvb3ZhTlZUN1YxM1oxcnhYNjk3Z0dN?=
 =?utf-8?B?c0ZxNmo4b1RCRmNhNCs3amcrVElEVlhiS2JoamRwQWo3dlBWTG5TZDhZWURL?=
 =?utf-8?B?dW1HTWw0VFhkRFhoaGxMT2p2VHJacEhqK3o3VkhqcWhUKzFuaTIxMFRhRlZL?=
 =?utf-8?B?c3pya2dleEtGT2tQS0pHL3FoeHozQlJpT0llU05BVVFRZlZnRDJhcUEzWjBu?=
 =?utf-8?B?N3pyaFhPQTRTa2lPNjVOK0tQcjFGUGZEREszdWhKZm1JSlgwSzlDU2xOM1BT?=
 =?utf-8?B?b3FXaWdUaHgvZTN6allWN0ZJaGlhMUN5TldXSHMwZHN1RnlTckdYKzQ2LzQz?=
 =?utf-8?B?ZXlmdEFwSE5GOEdYRmdyUkFOS0NGWXBJeUxGZmpRaUVBNGNhSmFHYSsrU3B0?=
 =?utf-8?B?RnNZUTZTNHJhbExvRFZteW5xK2lFd09BL2xGVmpJSy80K2xORDZMS1BVRGJT?=
 =?utf-8?B?djZrZlJFTEtla05ESGcrUUlucnBEcGw5RDB6b3V1RVppNHZZQWM2MnV4WlFt?=
 =?utf-8?B?NG85U1NSWjBUMXpOaG1kY2p4aEN6cHBHaU9UV1JGcmdUQzY1Ukk2eXFrQkhS?=
 =?utf-8?B?RnJudGtmazF1Q2gzQktTaDVBKy94aUxjRUpEaDMveExJMWNyZW5kTGYrd3dQ?=
 =?utf-8?B?MFJibEp3akJzTkRXanp6emEyZHY0Ynh0azVhUFNPUDcwWDF2dTNzT1hMQ05h?=
 =?utf-8?B?UURXN2FSZ2lIeDRIT2dQNVIrQjBDR2wzamRKMUloMDhPMTZGemNuNjRzNDJs?=
 =?utf-8?B?UzNUaE9TZWViVVRvM2FKcjBkUm5GK3JuYmRwaVZTTTUzTFhic3UvWnZmUEFK?=
 =?utf-8?B?TWVnSFJzT2xtWStTTlRnV0k4a1ZCeTJRUEQxU2tubm9VMmdoSmNPNCtKWmRT?=
 =?utf-8?B?UHpxazJZSnBnaXRrL2R4dk1DY2hic1UvWDhVT1ZJaFhUcW9KdVppVWg5bHhP?=
 =?utf-8?B?czNJM0pyaFcyNTRIdGJIdnk5VTBwcVB3Sjd4Y0ZoeisyczlOTjZBcTBLNFlY?=
 =?utf-8?B?UDB1RXFnTmYwN25LWVRzWnBKUkJsQ3ExV1NOZmllL2c4NVlqbGRlZ0htZHVa?=
 =?utf-8?B?OHBlOFE2MFltN2FSSDBadno2MDRjRHZXTFJaS1lJTHlXeW9ZbGNjT1ZPbmp4?=
 =?utf-8?B?RW4rZHpWYWdJM3V6SEZrbDBBK1gyQUZMTVoxSHFacHZ1U28yRDZqVnZvcHVh?=
 =?utf-8?B?YXBHa1dBVlI0WFAvRGFRNk5vRVRNWXBmUm1VM3M1YzhHelBndVI0TVB5bzBN?=
 =?utf-8?B?YndWeWQzYlVtL0xtZGdlQTNwZXN1dytVNkltSTcyeGtOZE9NSUdIS1lIR1JW?=
 =?utf-8?B?cDF4V3YyK1NPQjNlTU5aVEhZTE5PVnpYaER3VzN4YXBJTjhhRnBuSEJRL0JR?=
 =?utf-8?Q?kg2Imq9R8TNvDmrw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7910f8-d9a0-4d0c-5352-08deed34fe20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:48:19.8029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00OOqDCR58C3EV6PK2b8nb1mx/ItG+VFgEh0mvdCvXn95VS4PwhCZoQuRZbhfnl6uGdc9U1cMqEBQe74gzbJX3wbDHmfG+ot9g3lLjexJ+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7806
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgo5J30N/5E/UarrWeKkU5sQA2ahajeTnorFuv6bIY8=;
 b=uTSFOeSfQLcbw/Dc9LqwIxHUbXljIxTp1e8KtM6n8F1Rz7yOTeRimKwdpSOlrfmOXjI1D40ihlibpMi2/B1KK1jytq9RBQSKGGsKEKkup8Pn8URluqWujNtWVbhopVjE6+h0BzDDeYVoNKpmmxyzgwfDzd8JF2VeXIk0fBPxT2ibYpzGflBPYxZqKfz0FBjhqy/ZcldmRSQRfDKnyTnhihw6+3d4HpQGdX45Vg5BzjGQ7JZEdAki2fIOTAzFVR7FvXyH7s7WEcme030gA97Ht8PN+s/+DdlrQN32hdA7GylTfvPszTQ9rNr9TmHcOzeGMqriCrop4VWvaa+4dAtr6Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=uTSFOeSf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="uTSFOeSf"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi TF,

On 17/4/2026 12:00 pm, Chee, Tien Fong wrote:
> Hi DInesh,
> 
> 
> On 11/3/2026 1:03 pm, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> This is fitImage for programming peripheral RBF only in SPL, so that user
>> has option to program core RBF in U-Boot proper. The advantage of
>> programming core RBF in U-Boot proper especially for SDMMC boot the
>> performance can be increased up to around 90%, because program core RBF
> 
> 
> Please clarify what “~90%” is relative to (e.g. core programming time, 
> total SPL time, etc.).

Will drop the percentage entirely, this is qualitative rather than a quantified
percentage.
> 
>> in SPL hitting penalty on alignment issue in common FAT driver.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   .../fit_spl_fpga_periph_only.its              | 38 +++++++++++++++++++
>>   configs/socfpga_arria10_defconfig             |  2 +-
>>   include/configs/socfpga_common.h              |  2 +
>>   3 files changed, 41 insertions(+), 1 deletion(-)
>>   create mode 100644 board/altera/arria10-socdk/fit_spl_fpga_periph_only.its
>>
>> diff --git a/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its b/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its
>> new file mode 100644
>> index 00000000000..06ba0328477
> 
> 
> Documentation: 
> https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/fpga/altera-socfpga-a10-fpga-mgr.txt
> 
> still describe a single fit_spl_fpga.itb built from fit_spl_fpga.its.
> 
> Please document the two-stage flow: which ITS produces which ITB,what 
> must be placed on the boot medium,
> 
> and what SPL vs U-Boot proper load.
> 

Two fixes: (1) wired altr,bitstream in the -u-boot.dtsi to the new
periph-only .itb -- without this SPL still finds a core node in the
old combined .itb and programs it, so v1 was a no-op in practice.
(2) Added the two-stage flow to the fpga-mgr binding doc: which .its
builds which .itb, and that both .itb files must stay on the boot
medium (prog_core loads the combined one for fpga-core-1).

> 
>> --- /dev/null
>> +++ b/board/altera/arria10-socdk/fit_spl_fpga_periph_only.its
>> @@ -0,0 +1,38 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> + /*
> 
>   Comment block formatting after the SPDX line: avoid the stray space 
> before /* for consistency with common U-Boot style
> 

will be updated!
> 
>> + * Copyright (C) 2020 Intel Corporation <www.intel.com>
> 
> Copyright year on the new file: align with current practice for new 
> contributions.
> 

will be updated!
> 
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/ {
>> +	description = "FIT image with FPGA bistream";
> 
> description = "FIT image with FPGA bistream"; — typo: bitstream (same 
> typo exists in fit_spl_fpga.its; fixing the new file at minimum would 
> help).
> 
> 
>> +	#address-cells = <1>;
>> +
>> +	images {
>> +		fpga-periph-1 {
>> +			description = "FPGA peripheral bitstream";
>> +			data = /incbin/("../../../ghrd_10as066n2.periph.rbf");
>> +			type = "fpga";
>> +			arch = "arm";
>> +			compression = "none";
>> +		};
>> +
>> +		fpga-core-1 {
>> +			description = "FPGA core bitstream";
>> +			data = /incbin/("../../../ghrd_10as066n2.core.rbf");
>> +			type = "fpga";
>> +			arch = "arm";
>> +			compression = "none";
>> +		};
>> +	};
>> +
>> +	configurations {
>> +		default = "config-1";
>> +		config-1 {
>> +			description = "Boot with FPGA early IO release config";
>> +			fpga = "fpga-periph-1";
>> +		};
>> +	};
>> +};
>> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
>> index b32f40ae408..1648e4bda4b 100644
>> --- a/configs/socfpga_arria10_defconfig
>> +++ b/configs/socfpga_arria10_defconfig
>> @@ -20,7 +20,7 @@ CONFIG_SPL_FIT=y
>>   CONFIG_DISTRO_DEFAULTS=y
>>   CONFIG_USE_BOOTARGS=y
>>   CONFIG_BOOTARGS="console=ttyS0,115200"
>> -# CONFIG_USE_BOOTCOMMAND is not set
>> +CONFIG_BOOTCOMMAND="run fatscript;run prog_core;bridge enable;run distro_bootcmd"
> 
> 
> Changing from “no default bootcommand” to run fatscript; run prog_core; 
> bridge enable; run distro_bootcmd
> is a strong default for all users of socfpga_arria10_defconfig.
> 
> It assumes MMC, FAT, optional u-boot.scr, fit_spl_fpga.itb on the card, 
> and a
> 
> sensible ordering with bridge enable after FPGA steps.
> 
> Users booting from QSPI/NAND or without those files may get surprising 
> behavior.
> 
> You can opt-in FPGA chain + clearer prog_core in 
> socfpga_arria10_socdk.h, see the example in next comment.
> 

Dropped the override. v2 only adds CONFIG_CMD_FPGA_LOADMK=y; default
bootcmd is untouched. Two-stage flow is opt-in via
"run bootcmd_fpga_mmc".
One deviation from your snippet: dropped "run fatscript;" -- it
doesn't exist in upstream mainline. Say the word if you want it added
as its own thing.

> 
>>   CONFIG_DEFAULT_FDT_FILE="socfpga_arria10_socdk_sdmmc.dtb"
>>   CONFIG_SYS_CONSOLE_IS_IN_ENV=y
>>   CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
>> diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
>> index 2acfdc7df4a..2c01bf9d9fa 100644
>> --- a/include/configs/socfpga_common.h
>> +++ b/include/configs/socfpga_common.h
>> @@ -154,6 +154,8 @@
>>   	"pxefile_addr_r=0x02200000\0" \
>>   	"ramdisk_addr_r=0x02300000\0" \
>>   	"socfpga_legacy_reset_compat=1\0" \
>> +	"prog_core=if load mmc 0:1 ${loadaddr} fit_spl_fpga.itb;" \
>> +		"then fpga loadmk 0 ${loadaddr}:fpga-core-1; fi\0" \
> 
> prog_core must not live in socfpga_common.h for all SoCFPGA boards. 
> Please move this to socfpga_arria10_socdk.h
> 
> You can replace above with macro SOCFPGA_BOARD_ENV_APPEND. And define 
> the macro in socfpga_arria10_socdk.h
> 

Done as specified: empty-by-default hook in socfpga_common.h, real
definition (same QSPI/NAND guard) in socfpga_arria10_socdk.h.
socfpga_common.h otherwise untouched.

> /*
>    * SD/MMC boot uses CFG_EXTRA_ENV_SETTINGS from socfpga_common.h; append
>    * Arria 10 SOCdk-only variables here so other SoCFPGA boards are 
> unaffected.
>    *
>    * Default CONFIG_BOOTCOMMAND stays "run distro_bootcmd" (no MMC/FAT/FIT
>    * assumptions at autoboot). For two-stage FPGA (script, core 
> bitstream, bridges,
>    * then distro), run: bootcmd_fpga_mmc
>    *   e.g. setenv bootcmd "run bootcmd_fpga_mmc"; saveenv
>    * or invoke that from u-boot.scr.
>    */
> #if !defined(CONFIG_QSPI_BOOT) && !defined(CONFIG_NAND_BOOT)
> #define SOCFPGA_BOARD_ENV_APPEND                        \
>      "prog_core=if load mmc 0:1 ${loadaddr} fit_spl_fpga.itb; then "    \
>          "if fpga loadmk 0 ${loadaddr}:fpga-core-1; then "        \
>          "echo prog_core: ok; "                        \
>          "else echo prog_core: fpga_loadmk_failed; fi; " \
>          "else echo prog_core: fit_load_failed; fi\0"            \
>      "bootcmd_fpga_mmc=run fatscript; run prog_core; bridge enable; "    \
>          "run distro_bootcmd\0"
> #endif
> 
> 
> Best regards,
> 
> Tien Fong
> 

please expect v2.

Regards,
Dinesh

