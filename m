Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE79C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 08:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F51E80C7B;
	Tue, 15 Sep 2026 08:42:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrNFU46vwNcE; Tue, 15 Sep 2026 08:42:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BB0E80C74
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789461726;
	b=GsHjD7Ytg1/XySG5zqI0zF/yuCUyX2VmDhZFNuLn7SbYo4R/8v221mTDlffaIvdYUtkX
	 4OEFBa1xe0ZBp77pBrnfaS4yX7snWGPwzvlXHzG30b/ZG9EGcZ6RDLgZKuNjiwOY9DYLW
	 fIK/jylBw2CWoflxuehsbidLK7r0/M5TbP1EeBAtb8GaFFPPBsbAsMnO5oW1yCfmre/cd
	 yLKF0+QAV9WDVuWE8L7sI0dQQ+RB3eXbmJDbwpcPPIFIA5p3W+YdCtgFO4lwaws+veBH/
	 cZTgRdDK/lD3zUiosyPWoaafx3+pp7odihZv4zh3kukEKVOAYNjsVapqHf+gm3MDegw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789461726;
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
	bh=DAy0B/uXIWbEYJixMHzzC8NK+RoU9IkLG27CM+IWYtU=;
	b=WAT8oYOJl806WQB/BsCS9hjgnyAO9/JBggwUeXwR+9VQy16iePugpIdJx+qlBo/FkAEm
	 6FNrjAoYH7vRH6I4Hpd4pLZP3RLKcG0xRpFuWXWQNyin67BEVoXO5Ahx82zHbp3ZVslN/
	 dy+Ud0uvP8+3VapIrH2yyLiZpp/GGB3xkptkoMnP9VdQhoBr6GPFx0fqafQ2huHCnF6Ci
	 wgQAYy8dpJ0lk15sK2w+P40bNrXXTJkdXG3iwLTiuDaizGn11B1oW8k5gppPJNoB9Wjdf
	 afndZ+yyAVUeveLwaeUgKcTuslBxJUiZ1NqTOnNhihJrIRBJXnVDVulApVqKtj/8qxg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789461726;
	bh=DAy0B/uXIWbEYJixMHzzC8NK+RoU9IkLG27CM+IWYtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+LvI+oZ54aOW0VKF+GwVRaXn++0sSB+kxSwU90x/SMRCx9hNUchendOiaiyfk1mY
	 JB+uLqbYWDG7KWloAGEhEuh3GOpFfLD8mimBAVkmESzVH1jreYJG4C1L1SV73XVLKC
	 Nt2lhXTsh7BX7oTkcWeX/+5EAFZyX8M8jo3P+CRWmTOIO6BRAGm/Nsb94HTgW3YqCp
	 CmXMuipnGYL5dYyzpQ7Nqz9EZphxk0Js0Q7nEjw+1u8qbyfqE5dPxnvc3QcWV8cnPN
	 +PIM4nzsKljgv65ce2uJ7KhI3qbO8jRD7lQ/IJLqu9WfhyApngR5znHdzPkOdWJVJ/
	 xai0Fg+ToYp3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BB0E80C74;
	Tue, 15 Sep 2026 08:42:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C4E1493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D5A260721
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YFOnbmTgE87 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 08:42:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D4CE3605D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789461724;
 b=VGTTh3r9P15DKwPmLysS0n3ezTUDbm3ySJoAO1hlwEn0gK5nbIdMoYU+XCzzsIyYApvG
 uQqJsrif8RmqazdPhgyxaZqXresjvxPu5ORbsXNKXhGgoDKBQAFm5elWsv0gvbd+CXVHY
 1hlt47DisbWxtHKrI6UeM6FfLWEFb8ZeSdnj8yIxgWiX4/xqqQ+j6NSzmDaMSZyjHO/Df
 ezdMQpDdHMO6I0WIO5kyHJxp/TMg4izvYy718OLbDQt5ecQsQksnyh+NaLSJxS8inUqrv
 2wiAccdVeXStmsIenjVxA8yGo3fBcbjdWCMlFfPlJOF569xAkCvBhSn2GL6FFwUEY7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789461724;
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
 bh=DAy0B/uXIWbEYJixMHzzC8NK+RoU9IkLG27CM+IWYtU=;
 b=aTZuQ3VfWQIs1IK4K2PPKj7iTJsch9PaNf2b++gDqS0xx93PZ+bfhcH5DncRP6u+T3ef
 XufnFQpyXzLOBRtlea57WikK1l6jW3C6/U5PRB8kjXGw0WaQSBeY7eRRXwxfaHXMoSmno
 C5J1iZDacgriqPYgig5XOH+nBl3QadJanUz8lBfQL2W6pNvnxw1WgFMKjnVfx3iGIBdOB
 kR6TgRjblQY/lqqanLjTQu0SYaQjlVtefb7tESnunTSDg/G227oy1O/+mDmPJod5zvXnT
 JFHbJmw+eoYFLHS7lYtI4CLWinSwAAd5qQC8TRnaZdBu8kDBtX9tw849U02KFwSezaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Ra5QhlJI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Ra5QhlJI
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4CE3605D7
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDVIACdpoZcf2Puuoi4xtR3TALMxTvob3eDGqqzvoyPDBx4bYWjfu1EXPkpBGKh5vlhbP3gLU6+78swKOr5JkohSOWe6y3AJu00Nt6fQWURij7iuS8kJPVRho+P2cXlbbrZ3ExvNnYSx7iWc55rLdoulvo6tJYtBYlhSaw7I4qTrCR6r9SHhu3xo58ctxGJt3b6/qxgmxillCeqHkcH6gK+vCu4DILiztVmQeipQ3cAhewpUCKtcNBXfToqwXURKYix/6NEkP7SAD3vq9P2nOJyzb+omL+MZp5XVjXPXA60Q6WYWEAlIszL2NBhCD03+urcSFr6FuyPDMgAOYVVLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAy0B/uXIWbEYJixMHzzC8NK+RoU9IkLG27CM+IWYtU=;
 b=O6XiHH9D7E4k+JH8S7RfS8YVLDOyhe0Ho37S7FtTXh5RoB+WAKzeTY2pj6TzhwCW/VcZjcPp+MU5bkwPlrDIYZNjA5LYbyv8M+JWLMEQbSSoTyFpCYWxmWX8oLQ4WDSgfH5MLwzsQ9wO/MztvR+fxkmjB0c6p5P4IU6zoYdkJsvcFtHVMHXF2QuTMeuJGddYCALqS9zE7I77Bp+O3gAnDIx2L7PEEPXbDBf+FR7o2+FQMrhB5hWlmjR22vdN/umg9z+rZMPEyxcpt9Fy31hpbsUmYaVeQqs4ZRgTITM4Dt4J99/00iMiCzic30gU5l4ZLcFfHx4QdfGnn7OJMz+B1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAy0B/uXIWbEYJixMHzzC8NK+RoU9IkLG27CM+IWYtU=;
 b=Ra5QhlJIZNSHcglaYYsx/WiMS04Q4DNA0VUSoKxrfJtV5rfCWD9R410nbyqoO/v4aI3m1m61Tj+CRcpVLjX/LluWmhSziKDDfxG+IErXxp55lNe3gPcDn3huEXCZgm/CK9AmzybIyQr1KBOpHVNIGPJt4rDJnU7pqTSL7GsDHqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI2PR04MB10834.eurprd04.prod.outlook.com (2603:10a6:800:275::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:41:50 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 08:41:50 +0000
Message-ID: <625bdf26-f7a4-42d1-a2e0-433d8ed2cbb0@cherry.de>
Date: Tue, 15 Sep 2026 10:41:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: anbernic: Fix the RG-DS Kconfig target guard
To: Pengpeng Hou <hppiscas@163.com>, u-boot@lists.u-boot-project.org
Cc: Chris Morgan <macromorgan@hotmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
References: <20260906044845.27801-1-hppiscas@163.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260906044845.27801-1-hppiscas@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::38) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI2PR04MB10834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6faa61d8-4ba1-4951-d661-08df13052f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: HECsn21eVuE/fO/HSQwv8dXB3gFGVfISw/CCfGxaTJygqt985MceWF4tRqLTqnrVCA39kb58lr5+br6RtYyqqAOclPrgQtQI+Fzq3A1xlpvjxzO/H/hbqHpJJldLav6ZKsOp7G0u8Svr0hYgBklZUDBaDASQDcynIovMWDEXl/v6RtByguWjUPT43QbGZcrnpW2057qbQnA2nBTzbn0jxl2D2KQdFWgrZ5qithR8b/Z7eu93nSFFn9u9fSEHEgJDXwidrBf1wxPLs9jIh2wSEw1mIA5zFBE2NqlSl37ErJ5+e2xYkKghmUHwmTr/eYNQJf4xLzR0vejDJAXFThXscJypjS+Keides43AkW6WAJ2tLPVDlw5hf0mbGhKaoPGbCPUU+j5JZbycBCCkHI7pvCjJuiLucmVebLpgId19UbxqqhyfeLUeQWizZngGuF2jDbhvpcL3RSK3OHsySpz0NZCRqUk2et/j77Ypus6YZIFF9kXglhEyFWYaSxvABk0HzocXWv6y1xOX+zchR1QkAQKC6meuxnaT66JFCy/RJ5XlUoADQvOiUJ+mvNG5eQw6iS61/jCZNO5fjgawAZ7ePYry0MGZSH+6UP2R5HxqykrPKsIdkgO96l4fsaCou6Sbm7ht21mAe4K4wS2IJ091IjJN54/ZsB3z1iB9uS8f+4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmo1clJGdldja25TeEFRLzI5d0tqMS9tejZQTG9xL1FMN3R0di9ZQlF4cndL?=
 =?utf-8?B?UnRydTZNWXdTZEIvZFNEaGp5aWU2cjZmVjVod2lyK1FoVmRPRHgzeitNUzhp?=
 =?utf-8?B?enBkVGpEZmhwb0VGaDFoRStadHU1dzdWam83Z0pDZUxEWW53T0x4bk50S3BU?=
 =?utf-8?B?QjN4YzYzNGFVY1E1N1M0azhnWTduVWVuZXVwOTRkWXczQnFlMS9IeVVSdktw?=
 =?utf-8?B?UUpRQTJCQVQ1UythbURwckhLYklWRFZ1Y0dkTTF2aGVrRStUTXQrVys2eUtG?=
 =?utf-8?B?RklLbEdWTStlcExKMzk3V2dHaXp3dnNYMERxS2lSN3ZkRTZpcHNzV3Y5eEFr?=
 =?utf-8?B?VmYxaWovd2QzQmJ0RmFnU1Q0ZW1PdDRZbWk5T0h1MERtTEFQK1U3dGIyUE12?=
 =?utf-8?B?djB5SnVlU3RSdUFOU05HWkxFdEpSU0ZSRlVvWFJRU0Qxay9TbGhIWk9NTVlQ?=
 =?utf-8?B?QTZZbkdrOE1IMGcrRkQ4UUNlK2RVUUpBRy93TTFENnhJQ09kRldaN2R3ajlR?=
 =?utf-8?B?ZVlMc3hzS1p4L1ErK0hBU0JvcmtCS3VocjRNajIyQlJ5R1ZEVStiZ09ocGs5?=
 =?utf-8?B?N2g0TldQWVREOC9iNlkxdWQxYVJTUGdnKzBiNzVjQXp1aTgzbnc1cE90NktC?=
 =?utf-8?B?UzhFMlhDQVhJNVZ4a013eEdRM0UwdFRYeVFaM2Q5ZTFRTVlHQ1YvRXcrdVdv?=
 =?utf-8?B?K0NtYkIyNHViM0pab29MdlpXVWFLd09kWUVad1QxRjlDY3Y4SHpOK1E1MFd0?=
 =?utf-8?B?VVhoeFYzQmdCSGE0VU8yL28rRXdOWStEclhqL1NqZm5PK0kvNW9lZUhBZ1Aw?=
 =?utf-8?B?a21SbE9nRXRWNFFaOVgzclFNSkh5MjFmbjJROWZVekVXeTdXSHNnSC91aVJL?=
 =?utf-8?B?NllIa3dMSk5maVZOdkZWYjZ4aVZrS2NzUGdSVnBmWm9scXpaa3NJSkM5UDFt?=
 =?utf-8?B?aGxidzl6RFJZUk1VZXlWQStXTzQ4RzJGMGZKV2dlVUdZY3NJc3R4MUhDNnFp?=
 =?utf-8?B?WFVxUC96aFVlSG5ib29uWGhqT2p6VEl1VDlNb0RwSEJPS294MXpDZ2xjNUlV?=
 =?utf-8?B?dm5BdGVVVys4UGVVMDh0WWxVRXR4WEJBaXFMNVc1L2RKK01Mcmk1Z3QxUHMz?=
 =?utf-8?B?RWtPcnJPdzUrV3VBYlVvTS93MDI0ZE5jWkRLZTVPSDg1bXdRMmMvcG9MZjFh?=
 =?utf-8?B?aklESlY4SURMaGlIR2ZnbU1oRC9MU2Y3TlpWWTUvaGtOZmdiTjhRV2FOdzJr?=
 =?utf-8?B?Y1dtZHpkSWtPUmFVWE4rb2p3cHAzb1ZoUUhSMDdBYU1Db080NkZoMzVrQWlw?=
 =?utf-8?B?Z2w0Y05CK2JHdTZ1aDZBMlVKTHV1NE80RDVoT3U2ZTZTR1dMUlZ2VFV0MEx6?=
 =?utf-8?B?cEo5YlIvTXQ1V3RhWHlNQnBBYkNzUmV3Y0dhRHVhcWdsbXh4SjVHd2xlelJM?=
 =?utf-8?B?MU16bmFneXM3bzk4SmlQMmxiOG9mK2w2Nm51RHNhdHhoaTZPRXNib1lvQnFQ?=
 =?utf-8?B?MUJIOG4xS3IxZEJDTGpmbDdEUVJDZ2JCV0tISUhRNTBUbTA3VXZuV0hwcDlY?=
 =?utf-8?B?eVI2aTVGS29TeXJkeEo1S2xUTitZS2VyaEFIWXM1UCthMks3WGdkay9ubW1q?=
 =?utf-8?B?cE1xV3dxY1ZnUG9YbDZxa3NIZ01vWXEwQk9aQitQdENMZFdtYytzaE4vTUEy?=
 =?utf-8?B?OGtmNnlMTk1yREh1ZU9oWUc5NC9LMWZRM2pLZTEyZFdoaS9CSnlFeHJBUFhF?=
 =?utf-8?B?Nk81QThTdXE0RXQ1QVdVbXIzSU5XLzJveUFwU2pqeVdXREhjTmxqeWZDM21X?=
 =?utf-8?B?NkhqSFlocTRlRnhYaThMTEduSmljUERSQzBwY04wa3RjN2ZuWFRsTGxQSzNq?=
 =?utf-8?B?TDU1RnVBZVpxdGpST25JWlBSRnErTks1UkNEUXZvK20wOW1NZndmeklwTDJz?=
 =?utf-8?B?ZFlqeVdFNGhCbHNndTlkajZPWXVqNExEVmJFbHBwN013MlJXNFg2TWpPdkI2?=
 =?utf-8?B?b093VXpDMmg3cUVXQ09UVHptbUx5UWxHMWVRVng0SzhCaHJ0REpaMkJXdW1q?=
 =?utf-8?B?V1RBMDAweXhubmRtbDlqMEttdVhRdlhJSUx4RTJ1WEsyL3J2STVPNHRqdjF0?=
 =?utf-8?B?WFFNSHMzak8rY1ZkaTJEL1BCM1llSXdTWUFIbWJraU41YlcrcytReWhqbU5k?=
 =?utf-8?B?dWxMQmxLRGtPdG9CZVY4b1FLbllnNHlxcTZGOTFaU2wvczdQcTNpcUxDZ3pP?=
 =?utf-8?B?cTY2c2VGR1NUODRJV1BDQnJ2b2QrYy8vOHpabElmWVpUNi9RTGVRRWFldWpn?=
 =?utf-8?B?Q2RvQUIvUDFKOHNnRi9FZmpKck1EVDZ3cXlRQTYxZ2xDdWhpYTBBQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faa61d8-4ba1-4951-d661-08df13052f2e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:41:49.9419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIby9+IIIwZpbyKcOlpCKSotNokZebtRWDo1BGAs+8DV+ha8OR96wSl2hV+iViNztvG3xiZsLrYT8wC4RSuWeqcyXl3idKTAiOh1zHZL2+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10834
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

Hi Pengpeng Hou,

On 9/6/26 6:48 AM, Pengpeng Hou wrote:
> The RG-DS target is named TARGET_ANBERNIC_RG_DS_RK3568, but the board
> Kconfig tests the undefined TARGET_RG_DS_RK3568 symbol.  The board
> specific defaults therefore never apply.
> 
> In particular, SYS_CONFIG_NAME falls back to rk3568_common instead of
> selecting anbernic-rg-ds-rk3568.  This omits the board header which adds
> the serial and video console settings.
> 
> Use the actual RG-DS target symbol.  Keep it distinct from the RGXX3
> target as discussed during review of the original board support.
> 
> Fixes: 1998fe69f7e1 ("board: rockchip: add Anbernic RG-DS")
> Link: https://lore.kernel.org/u-boot/3C0B9EB8-A40C-4EFF-9057-F4216ACE5665@rock-chips.com/
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
