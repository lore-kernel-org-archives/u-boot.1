Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC8DC88E66
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 20:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED42280E79;
	Sat, 12 Sep 2026 20:36:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7HG-3zTHf_c; Sat, 12 Sep 2026 20:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D8F9880E58
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789245383;
	b=ijNJnnoLmGBBZLz9NKwexMi3JQ9cBBwYB1J80s0f3ysa70ygHdpYI1k/5ppFIVTOG5mF
	 J9lT6Q4bEq7d5/YeqcQMYLgDGgZfTahKNT0dGU5ZB6wUAsyiQ1dSHr00MPWjhNQ8xPJto
	 zkRLg8mb9h1OPrpHmMZctdSwz7ne4AajCsgLbe3IoqWRAYHQ+L466hUnYqyBNGfirNcLf
	 QZfXnr6PpfZ8waa5s+/ZuXv7blXSv2e70FjWUTZeo137bX0yhHgltRjqFZV5C3+6z3IAW
	 S0bxFLPok28FbcLzCGBvlZv9/7W24MNluhIM/qOci41PcZWZ4mLoWI0zN0c/2C4JBGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789245383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rLPKaccTX9CnLu93G1AJDvZHXsFKIf7+g6XaJMmZbMc=;
	b=KP2PzI/t9F4yFE2zYufQhXqJBcMNjfnZj4wWntABfvWGg1BoPYPusogIt/XDuccnDaao
	 F/GhqWMjGIJPoTh3K8o8+JQx1KjL4cy+7hB9cq4DSs281RAyF5krGnAD1ncXBgQrFuS0z
	 FiSJTH49YSJoIVa3CB/wZ3k2sPaOcmrbO3DsU3zMJaFSpzYzMg2tIL+34PPFnN84h1fZG
	 k7DNMuQUdBsFEjibVlGvteen1VTQlWtJcjEF4CgKt2aJauNNv7RgJ7xCgL35j/YJRX51d
	 rXCom/IF1AzyEtowNGAF9vcdGWoBH4tfoqDsMwf0KNTB+hLlC+0gbUNpJlZV8JkaFRw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="b78TZD2/";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789245383;
	bh=rLPKaccTX9CnLu93G1AJDvZHXsFKIf7+g6XaJMmZbMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GxEWP8lrftW/h9IE94X1Wg0Axz91f9pfBjAUUDNvgAqS3f2/cZ6Y4GoGmOmjmnI3V
	 TbK5E0kIC4DLQ0P+G9ObcNuvgFnB+R7hWNquGQgR1pXQEJy1yvgWEC76Csxtf8cOI4
	 gUpW9gCUZMi7lvB99MZB090KNDIjtxEYSwljt5LvsVhiRFNjFsTlWCuM1k9KqWpFGL
	 1YioiN5Rvd/Eo6mWeMbrK67hbkwrpkZQkQaF6YnssWB1bn0RyDq4najZgDJXJhHbJl
	 cuc3T9j4TJ8Bz/VmtCg+VpQcjBgf7DFGvQUFY9vqaSwlFPhbfBj71154oyOI6qa0/k
	 3S09mh6zjrgFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8F9880E58;
	Sat, 12 Sep 2026 20:36:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED0702D0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 20:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCF2580E58
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 20:36:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JCQ0FqKFAXLp for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 20:36:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CBFDD80DE1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789245381;
 b=gAt0se+9cWoup8kc97kv6wbSo+SbXobaZtnhtS/kxyEinBWKqK3ChV+eS/AjT4gEMgK2
 maLdoFh8oSqLbAxUrLIsQkmy1c3ROPHqIKeNzPKs7m6ZwDCveupgTPTiyarzwZhOUyG9I
 xKxMuvfeoG8RY8u/9nE+63Vc0zH69nSu82Q0AQRP8g9TqtVSPmIeeCVAZ6oEj0BGMW1gN
 FxfEbYJeOpvxVHins4ygfgNzW7jsrdWEcBiYx/SOcTPALhmsOgRwPiJ/Ni5pH8muK9Dt2
 d8syL2ih3tEdVEJ2afTH+afML3BIIEqgVHTc+OEat8xp5wEp2Sbi9JmiXVqQs48jyjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789245381;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=rLPKaccTX9CnLu93G1AJDvZHXsFKIf7+g6XaJMmZbMc=;
 b=VhruJ0/Y6+ldCvQ71ZIpUQCjSl+ZL3Un9PHig2SHUt70ffDDevXqLaiziBHj4PAhXn5v
 tbXxAGUsZR4XKmy+NyRRIK6ufpmwcJeLEX2WY6M6KIwpPBblRRMGTu5IoYbSszlFeI/z/
 VhytpnnZBTXJdP/V1sQ4gkl3OtQwHfWHg7iZdu0Ams4GAC16w0n0FZNea4LPMK6tKta96
 MycrD+p8ptQOW/zS81uN9xEDYL4TxJ0pWpnOUL8khRBxrC5Pn145waFmTOawz1X3jHJqJ
 XvehAPZUo04dVHRw/XcbJ+a+qxPDOchHkL9OYkXNqBqX+0wjmbZcFAJoJlUd7gmmnYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="b78TZD2/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=b78TZD2/
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBFDD80DE1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 20:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9LiUofV9HZnZ3RqkllHI3ySwHIrkiBYKh+UFeSTe0yd00NNJcf4v02fimhj4xFd0WpaVrVLPsmGhJpS/HjPaBDKjT4HlRZ6brXucvUxcsBpcukwgmNDrmdjzgzuWetPGhxK/2qCIPm3O9ImzDBKserMr/lWpMVhgRjTtP7oWL8wzW81J9MrKT8b8hDtXxicBqXoW+2XHvs1hs1jgqx7c9bPzu/Qd7htQOGCyRx0Ym2lG6AKvjpVNqSWQi3tjqDv8j2omwHB82GZW4qXAWkY0akotLPNaJmGQT6rLVHuOXHS1yG9/IG86RdqbnM7E/4RIhoshszo0/KKH4mWfoLMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLPKaccTX9CnLu93G1AJDvZHXsFKIf7+g6XaJMmZbMc=;
 b=INJgszNT2XT/sp8kbVU0kP4leis50+fj0d6E/fjiyduHPX/eyfzjMNWLxtthxTdgc3nMPCUMVJcDLjO/kMiDXotQt5znO3f5RsXWwqEl5yQxYGXCyjjtgr+RWWLnSg5lptI2Va6aoKI9heO3vpPlGFmyIgEpstJIG0jm5HRwkQivEQEKSmggpRKE2xHXFNZTzgu6KbBRZaKygFDwdL3CNkZZA0grNyNm6VyQSItfpa0AuDyM/Uzklrz7khAFP6KQvAmd3b88nU0Gmp+vxZXCLhthnkJgzdQpW9C1X4XPQVmjJ/uXj8Jyy1NlZ/JwQysECVVe4Fw/oTEVoe+MDZVo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLPKaccTX9CnLu93G1AJDvZHXsFKIf7+g6XaJMmZbMc=;
 b=b78TZD2/4LpwRhOAcKmXsJ6TAhylOgYi6OWg7a/t/fFwdUcAMdwl98BIJsq1bJ7/e5wcPxsnet+wp3CeZLTHu/FSZzt+fUwd52ntAoJSODpCF4Ag1eGRIY/FeXIZDHDVAtLIag43Qf69o50qE+AwWksVis/tY1c4kQuKMFYKLlOFDp3A97v10E9fNQkArUCH64toDXDCfVg+cVnFJhx9xn6cH/NE7AkdzmE0uoOCWhuDppOl+gp+/dpc1yCXgOrM4UAJBGjlqfqpZT++MNgFvJctC5Jm84PHEHPcQAGeey1vCO4ggyQsy1r4MBSdlvRnBefyFiiqh/Tmm7GBkWgn3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA2PR03MB5740.namprd03.prod.outlook.com (2603:10b6:806:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 20:36:15 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 20:36:15 +0000
Message-ID: <327b821c-3f0b-4f1f-8784-5f53c4afabe5@altera.com>
Date: Sun, 13 Sep 2026 02:06:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mmc: sdhci-cadence6: name PHY and controller config
 table slots
To: tze.yee.ng@altera.com, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <ee6570ba9e857ecca961c72aaa82e4cf4533491c.1787710268.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <ee6570ba9e857ecca961c72aaa82e4cf4533491c.1787710268.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::19) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA2PR03MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: c946e132-87bf-4a1a-1a07-08df110d7daa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|55112099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gwxPEtjCa34I1wmp+IfNi5NAb8tFSG7cVk+gQAsJmO0ubxRkbyJIXP9sIum5Hh+e0mis4wZeDWgqrtrBknc1re4Mh0I8wRqGhxxiJEssVKUzLmCp2SkVPbMHJWYyhaWJ3yGMtMAQH/dIkWFc65LRTUTOrr+kCKI0y2QF0TSTOEwV3tFlUbfWHOv0xjqMJMx6+N2nc0sjSSzGdk6B/0jiZc0G41XILdN6qFzEL1gEavEEdnYwZqlTxGQadZMRP2zmPXuwm+JeRyxPtxAIiolIB5lBNsCZZdkaBBN0FXA3zCWyWMoexeRD1cyzmNYLwmOLopC8fpzsyfmlcyhn8imnMMO3QY79TCH4zZpUa+undF0eDGX6uyBCmObDcYDSMXjYYSKrb9Zjil858Q9Ya7T9Sf/LXDtZWUdA0taIBfZ78dKh2ZViiUpWEDHgQ6Pnel4cG+ft6pwepe86iABjEWNi++W6HmE9rbVFHM/DDsdoRiD6CmCn8rfbAqmc5BueF4Ay26TsCXsoI+Oj5TAij2TyOBtAQlVtwmrL+VPbrrCBTLv0S9Np267wN7Zny+ofe037M5vgNTkm0lXb7/bZtA2LUazevrmNi5ZUlwyNfOYCqTMuHmofWcdHkUQmafZPWbC2RysUuPvtKmkcnrLZy2Y4lFC3/AtCFLAFwGCuf4SZJx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(55112099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRvOU1MNldTZDhqMU5QUFhtWCtiUUpuU0d2WHpjYVhZYVZ2c2tPYmZYSWht?=
 =?utf-8?B?NUc2MGdzRnRLYUlyT2N6MFluTUUyOW5HQUwvejJhYS9YbVRlWHcvWXBVYUFP?=
 =?utf-8?B?QW5pcmVUZE5TbXVoLzNEbDJxTjV3dmZ0NzZiRlNmNTdkYngrcmc2aTlxNmZ3?=
 =?utf-8?B?M1Faak1ndlZCZ1pUelhtRGJxaVJyVUl4NXdaWXZRL2lXS0szOFFQZk1zcjBP?=
 =?utf-8?B?bmdqUzJ4ZHZwTkFtdGgycm1MQ0VBcUZxcjhBaDF2OEVnVnJqWG1zZlNrRFR4?=
 =?utf-8?B?cTl1ZHNwVXNJWHFMMzVqWUlrS3dYd1lkYVpKZ1QzYjJqdWNtUTRaVzBZYUQv?=
 =?utf-8?B?SlZBNi83Mk9hald5TVJyM0tNMTBZa3RqL1JQRjNSWUtCalJ0V3owT25ZRkJ0?=
 =?utf-8?B?QUVxYit5K1VVMHdIdGZCQllDSWFweXhyWWNQZXdNN204L2FlanArYjk3M0tP?=
 =?utf-8?B?RFNjWitJSGpOdlBhZStNaFNvMEdkMDgwS05sSldmRWFFaHEwSmFZNXdOQXl3?=
 =?utf-8?B?VlJteitKS2ExTGNwa3l6YzJEcFZOZmdGdEp0SEpyQStRbVNrVUVPNSt4OUx3?=
 =?utf-8?B?VFQ3UmVxbTBsalBVazE2YlpYbjM5MCsrQ21XR2g2OGZhK1BaQ2dGUGFodnJm?=
 =?utf-8?B?a0dTTWc5cXpZRUdVTUE4c0VrVnJjMjl5ZzRuTG9hVjJOK0FEM3d6VXBXc0hy?=
 =?utf-8?B?UVVuMEQrWU1TSTBZeWVBWWVSeTM0dmxuSjE5Mi9UbFJBVStaSktOb3VyVUxr?=
 =?utf-8?B?bjk4ZkZpZ2U5UWM2c3k5YTZsc2xKV05nUHFFcGZjdnBLcTBqNTRHNFRLblJ0?=
 =?utf-8?B?ZXR1Qy9xRU5YdzYrTTNkSytNTkd2TDEvWlNsVFNodGV3ZUNvQWlsQ3ZOMWVx?=
 =?utf-8?B?WldkVnM0UzZqNzNwZlp1Ym01dlQzWjJ1eWwzb3ZCNVRpZ2lDTlBmcW5NbUl5?=
 =?utf-8?B?VDgrVUp6cTYySVFPdExWd3lKRXZEci9yUjNsdUF5ZDJaaStoRVhCNTIyUURp?=
 =?utf-8?B?VGZneTNnR1J0Zm1NbWl2SklSUlBiS0ZRYmJUaVRZN3l5d1BSejZXeGJCc0Fr?=
 =?utf-8?B?REJmbFF4OVdpQk5wY1hSUTVyVVFBVkF6RWxpNWxwMjZ1YlFCZFI2Um95VG9B?=
 =?utf-8?B?azZ3MmZnUVpndEw3SUJZVmdXaHFNdVVVcXIwakI3UGNCdy90WS95MGU1dkEw?=
 =?utf-8?B?bmpGUEcwZDJlZXhtTmV1U29qMmdpSjlGZnU0b0pETU9SNHl4M3EvQXdkV1N2?=
 =?utf-8?B?QTdGQ0tUejdLUDk0U3A3TzRaQW1IMFlXYzlLQWJYVnVwTkNZamI0dzl2QnY2?=
 =?utf-8?B?S3NtME4raUduaXlxY3ZUSGw4bEVvSlhkamNldXNxNzd1L1FZVlFBcjNxL2xw?=
 =?utf-8?B?TFVPYlRDeTlWZVc4NDRYL0kxQ09lSDhaNGM4SXFxbmwwdlZJRXpaVVI4bzlT?=
 =?utf-8?B?WkhEclhtcmxxOTZzbFNCc2FiMTg4TDBYenpyUkN0TWcranN2VW1YYjE5VnE0?=
 =?utf-8?B?ek91UlZFaEhpT1pUVmxWL1FFMytuSzZqSnhqQ0pZNUZGZldqQ2djanZBL0Fx?=
 =?utf-8?B?WmkxWGR1OHd6anA4Nk1YU2lGR0NDTUNiU1VmVkhoOGwyV0hBU1NDMEFiQ09D?=
 =?utf-8?B?ZUlUSStDb1ZhME0reWRIb1hsaHdnOGRGSithRXhRcVUrZnJmb1VwMmNScklS?=
 =?utf-8?B?YUdmejVHdHlKb3o1d2FmVWRqSlZ6N0w5MWI2RkZ2RkRNM3hacHdwbzVkNkFT?=
 =?utf-8?B?b0YyOTNoSDlhRFQ3cncvYXFjMHBVUFNScGplb3NQZWN5dng0WHlBVlNmUGpI?=
 =?utf-8?B?SU1paHFaKzJQWUFsSVRPUTVFMlhNOTlidlFyZFdtaGpDZzR6dzFoOFR0czBB?=
 =?utf-8?B?RS9tTVFwVCtlbzFUSEZjVVFnOGtXSnZQYXhkUTBibXFvcHg5ZW1iR1A2ajJD?=
 =?utf-8?B?SkpyeWRIN1BlUkFrSEwrcVJuNjVCRkhUdFZmTWhMTTBjWVlDVTd4c1VrdU50?=
 =?utf-8?B?QTJmM3hMcEZMdTQ3WGhnUTVROHM2b3YxU3Z5czBNei9IdklEMzliNk1NeEV4?=
 =?utf-8?B?Y0dpY2hyYXIyQUJSL2cvWms3dEZtdEhVZWY4cUg4endpU0V6d2JVNmx2bHlj?=
 =?utf-8?B?U1ErbjFEMjN4ZHlZME02aWFrUnBWd1piM2F1RDdtVjBNMDhUb1Z4cFZEd0d4?=
 =?utf-8?B?SUQ4bWcvZVc2azZmSDJ6QVV6RENmQSszbTREZTJka1BrSnBCZytKd0xILzdG?=
 =?utf-8?B?WE1ZdkRRNlEvNVExYXZEQWhFQ2l1dlVlZGRYT2xoRThlUTBVSGhPSFlGU0Nh?=
 =?utf-8?B?cFU5bWQ5L3dSNGpGNEhLQklPMEw1SWgrdzZFbzUwbTBIalJNMW1MN3FuU01i?=
 =?utf-8?Q?KUeOsWl0Bxz5xVrE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c946e132-87bf-4a1a-1a07-08df110d7daa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 20:36:15.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKTGwrGjH2thJ0RX0Rx+KyrqYF6HhvOQMwxo58fAXfG6PTIr5vOaU1HRR2TWS3ZFLIZko8XaWQYQtbor4NPq1Zh1EthLXrKtYpjPoRXOaO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5740
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


On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> sdhci_cdns6_phy_adj() programs the PHY and HRS controller registers by
> indexing the *_phy_cfgs[] and *_ctrl_cfgs[] tables with bare positional
> constants. This is fragile: reordering or inserting a table entry
> silently changes which register each slot programs.
>
> Introduce enums that name every PHY and controller configuration slot,
> whose terminators double as the table sizes (SDHCI_CDNS6_PHY_CFG_NUM and
> SDHCI_CDNS6_CTRL_CFG_NUM), and use those names when programming the
> registers. No functional change.
>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
>   drivers/mmc/sdhci-cadence6.c | 54 ++++++++++++++++++++++++++++--------
>   1 file changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
> index 1ff974ecd44..7bd47b462a4 100644
> --- a/drivers/mmc/sdhci-cadence6.c
> +++ b/drivers/mmc/sdhci-cadence6.c
> @@ -59,8 +59,6 @@
>   #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
>   #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
>   
> -#define SDHCI_CDNS6_PHY_CFG_NUM		5
> -#define SDHCI_CDNS6_CTRL_CFG_NUM	4
>   

Dropping the two size macros leaves a double blank line.

>   struct sdhci_cdns6_phy_cfg {
>   	const char *property;
> @@ -72,6 +70,33 @@ struct sdhci_cdns6_ctrl_cfg {
>   	u32 val;
>   };
>   
> +/*
> + * PHY configuration slots. The enumeration order must match the entry
> + * order in every *_phy_cfgs[] table; SDHCI_CDNS6_PHY_CFG_NUM tracks the
> + * table size so the two never drift out of sync.
> + */
> +enum {
> +	SDHCI_CDNS6_PHY_CFG_DQS_TIMING,
> +	SDHCI_CDNS6_PHY_CFG_GATE_LPBK_CTRL,
> +	SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL,
> +	SDHCI_CDNS6_PHY_CFG_DQ_TIMING,
> +	SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL,
> +	SDHCI_CDNS6_PHY_CFG_NUM,
> +};
> +
> +/*
> + * Controller (HRS) configuration slots. The enumeration order must match
> + * the entry order in every *_ctrl_cfgs[] table; SDHCI_CDNS6_CTRL_CFG_NUM
> + * tracks the table size so the two never drift out of sync.
> + */
> +enum {
> +	SDHCI_CDNS6_CTRL_CFG_HRS09,
> +	SDHCI_CDNS6_CTRL_CFG_HRS10,
> +	SDHCI_CDNS6_CTRL_CFG_HRS16,
> +	SDHCI_CDNS6_CTRL_CFG_HRS07,
> +	SDHCI_CDNS6_CTRL_CFG_NUM,
> +};
> +
>   static const struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
>   	{ "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
>   	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
> @@ -277,10 +302,14 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
>   	/* Switch On the DLL Reset */
>   	sdhci_cdns6_reset_phy_dll(plat, true);
>   
> -	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, phy_cfgs[0].val);
> -	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, phy_cfgs[1].val);
> -	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, phy_cfgs[4].val);
> -	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, phy_cfgs[2].val);
> +	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR,
> +				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DQS_TIMING].val);
> +	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR,
> +				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_GATE_LPBK_CTRL].val);
> +	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR,
> +				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL].val);
> +	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
> +				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL].val);
>   
>   	/* Switch Off the DLL Reset */
>   	ret = sdhci_cdns6_reset_phy_dll(plat, false);
> @@ -290,7 +319,8 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
>   	}
>   
>   	/* Set PHY DQ TIMING control register */
> -	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, phy_cfgs[3].val);
> +	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR,
> +				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DQ_TIMING].val);
>   
>   	/* Set HRS09 register */
>   	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS09);
> @@ -298,20 +328,22 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
>   		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
>   		 SDHCI_CDNS_HRS09_RDDATA_EN |
>   		 SDHCI_CDNS_HRS09_RDCMD_EN);
> -	tmp |= ctrl_cfgs[0].val;
> +	tmp |= ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS09].val;
>   	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS09);
>   
>   	/* Set HRS10 register */
>   	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS10);
>   	tmp &= ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
> -	tmp |= ctrl_cfgs[1].val;
> +	tmp |= ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS10].val;
>   	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS10);
>   
>   	/* Set HRS16 register */
> -	writel(ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16);
> +	writel(ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS16].val,
> +	       plat->hrs_addr + SDHCI_CDNS_HRS16);
>   
>   	/* Set HRS07 register */
> -	writel(ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07);
> +	writel(ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS07].val,
> +	       plat->hrs_addr + SDHCI_CDNS_HRS07);
>   
>   	/*
>   	 * Wait for the PHY/DLL to settle before the first data transfer.
