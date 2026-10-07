Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62809CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 11:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 004804064E;
	Wed,  7 Oct 2026 11:45:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j4aw0g2vKl6s; Wed,  7 Oct 2026 11:45:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 465E940655
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791373525;
	b=OQ2pqOsul3RYjNJzAuaNGEZBl3ak90sAiyWtvMVs5j9rKg1WAZ+Nznq7djCEYfhuSiBY
	 7SK+wSoKBb9aaslBNQj0ENm24qT0zs5Gb40hYPIaaNvfgxYvVqVc8lRHBVfI/w5SGIwZh
	 japJtZqHqNtqLMmq2dBp2sj3pBDagJP/amzTnFnu5xnZj38TuOxkUvVDeHNy9stuvRJue
	 s6+aD43FZG9jC0W6d9qVs6FFe4HKnfqQLXM5hjTeYm6Nj3lV//F8GPa94Zq3yC19oOYSq
	 8HXEGyhvvpBTlx4L8OQT7QThvNn+WVuQZa2Sa5EIf+xgKnPpsMlkrzJTYXDTT/TDw8A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791373525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=glJ500MWjBLNtLiA1Ki43vvJ2zyoXr3t5I6xVrylZos=;
	b=Am94aMVTDHGdBxNM5pkC5TrLRUzsOhJZMwqGtFh8p9QgJb/MuxkId2NFRFT2NHz6kRCg
	 6/Yjcl99KeNJX4KRNAU50DjF8qkFxfzNnZdk/ihTLx/Tq/Y+dTHl4ciWtbYfAsw3+wH4k
	 dl3MThl3wsk6UYjvPKGHTSU75//SScmE52YyNfM6tGoug6b+7Oqa/3q90boGZ9L7+spfU
	 v3KdB6su5ueHc+d4R3PPVHXQxWKkCm+bGPxpsrVG9TmAsH8rn3Znb1QlMU7fBVPPELypV
	 1MwVJbh0ZP8wxbkt5erOgTiXcZZxHxXm5aonh8r/pf2JUe3WR9ttSJ79fIujQEfswQg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791373525;
	bh=glJ500MWjBLNtLiA1Ki43vvJ2zyoXr3t5I6xVrylZos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xE1qz7l137HEN/Gh6XmLwaXSHOH+FpfN0QS7rYuYj4fhUeG5zK46PoGXDXqaRwMG/
	 LMRTWUwrRftZz9vNOCVSh0fSF6x9/Ez5MqvCMqIk1iaIE4/8iF5Lb23bbEFwQddyUR
	 K3ezK+sSe77vbZH6XkedMgtLWfWDLKNSUn23O7ETijeWPSIEU85bdqllRgPL4oG0Mq
	 0bhk12kwATMgAaLJvJm41X8XoMij+L7CtqnT4hO0+nXvnVhpgEMjiYxYz4R+jE7z8O
	 t5a1StgWV2kybtHFx9V8xCvSfUZppNtDxQBHWzDX8w/o3qNn45dk9kYab8Zb9kWSka
	 XadcNmj3RUNbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 465E940655;
	Wed,  7 Oct 2026 11:45:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F55832F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6562A6064C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ksadAsJDa-wC for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 11:28:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8C7EE60685
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791372487;
 b=a7HeRVMFuU3XYXDsEFZu7gsBBrCzwmh+5/pfpHUTV7gVpJurs0tBSk4npEXi9sx5pJjq
 8UWDEBu1/ozyxnL45Z+QqS4pXTPHdaIMS511c807gb9XVgm2CpzgLqixGLKts63uDLBKx
 at/zeNUVZKj0xkHpXYxXCRtD51KH3nS9LCWowImudLXgLnuE5wm9bBwt596gLso03vgdH
 Kt6+niaRIjBn+Qtd/EeEeAqXuT0uIvmSTwsEXvW6EANYJSG/q72Y8T7NAJ/5XnUkK/keb
 Palf6/H/2fwLXkDWkc+d/YRkALaWXh+pFyD71n5p+pw5Nt2a3Xi+hHUVCZaSAb0ZKLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791372487;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=glJ500MWjBLNtLiA1Ki43vvJ2zyoXr3t5I6xVrylZos=;
 b=PPcYGVF15p9nUeDJUvIrrhhKaXPPe7WpG1pimYY2kJfxPfU476ealRWIxbGuunh432cZ
 CwKmbRw2jMJ7nGwRxMzzgCV4K+wkKtn0YeCqb0ggTKBKPVWCpTSf17U/UPTrnjZnDhKmN
 afcSaKXawYB4dJD6gB8rqg+aVmU2j12Tm8mOcDEhMnlW3cOQ9EYH2G51UmhQxClrgEM5y
 SowXyXbSrNlVp0iPnerhZKrRnNQ/3j9HeKc7YXVIjjEvgop5IALmC4fW81dMp4BzfOGAW
 nLlyQ2GYpCRFzvKTdZ52FxyieSc6yLfJkjtR023zyqbqir/M5l7pIlzVK0aK2iZvQjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=axavUl+h; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=axavUl+h
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C7EE60685
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buQNEMBcRT4xJIKBTPmMpQ8adBr8ARn12ysRc21FwOLupU5gBvLdz8s4yRuJunuXPyp6gY2eFmLqWODboA8KPX0/UteyECHzkno8mdZetraTYJuvi1lcM4JfoMZgUM2HU3itb1yF//NAdTsgmlpe3RN2wWvUsnUk4GZ4fhyC10uypbjfADvbJc1m3A9VWrXrRLos51jyyxg7nXjjszEeWHV50xTxrIDSQVDbyknUxaeZa6tDcVuwMwTh8EShXILtjnnahQgNZ5YJvtfsKOcnNk3zhADw0AtKf5M/0v6pIt/oxKP2baylmE3f9oYJDImdrnZklxUP15mmb96kHcQshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glJ500MWjBLNtLiA1Ki43vvJ2zyoXr3t5I6xVrylZos=;
 b=Mv4bBlioKeX6QtXLDdXDtJTyleEk6wXWXDlFav+FIW21IvB0zZsH+LCYCmQeCC2jDLX1EYhg3G9+MgAAY/IN2E1n7Pf1s0JcxVWasMHEHrqNODghCJGZKxaKO53XWt+lybvSeg7D3HyjSkWRZBrygy+M0Gx7Spq3pXQwoCRsx60ZIejUvGPsu87C1m+uqQSmQA/GU7eM4bHQuH4NGYN6M1WVjddvIq8wImFKPc/HllXNsTy05if0P+cM8LV3iQCq2+k3fqCPH+hyLokdCE7LoShOdYdNqyf4Z4pIM2oTkHM3P6Kq2cV1dY3e49GUQMZdj0uWu7P5CXBMwHgb4hiNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glJ500MWjBLNtLiA1Ki43vvJ2zyoXr3t5I6xVrylZos=;
 b=axavUl+hEgZA4oWA+RxHAGiRufsSsAko4IYNs3Vyo+ruLkJz0c0FJwMtz3deX3Qv8h52MbFP0ZSMIHr8lCpCZ1fFD1yuv64pSxG0lrzioaP4IHLhrMUbF333NsAnm9ImIZXSSi9LoQ06N5GkK28Vf/5f9ayO4JUUdLNT8movyjlmsoqbPWF+KPmgFewamwwm2VZEHYZQ4TSt+Ghwc4hTNm9Lk3YE4L11ZsF96NsNZE2Yf+m0hVwNru3YWIJs3LNnAKf0pOmlgh+JS7A+DqY+zoqTkoWvpPh4MX+jkL2cQz2C7Hzlo64SU55VTG4Vsclg+BpX8j5qskrU1xrjNW0pSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU2PR04MB8598.eurprd04.prod.outlook.com (2603:10a6:10:2d9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:28:02 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 11:28:02 +0000
Date: Wed, 7 Oct 2026 14:27:58 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v6 10/13] board: lx2160a: serdes: add serdes1:40g4x10g
Message-ID: <20261007112758.jgxe2xhkrxmgof5u@skbuf>
References: <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-11-vjardin@free.fr>
 <20261001204731.1774613-11-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204731.1774613-11-vjardin@free.fr>
 <20261001204731.1774613-11-vjardin@free.fr>
X-ClientProxiedBy: WA1PEPF00005B98.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::62d) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU2PR04MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fda7ef4-d8c7-4818-3d8d-08df24660c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|366016|10070799003|376014|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info: u9S5Ll7POj5THf1aJZ+9jSOqY49Z4tB4xrkUObt+g8Y81BCyNNpF+BQT5zIZ9PMjRaVnCVbR4lBXpByJQczprqoI8OltOb8x4nHUA39lRCUcv4cUR955nGojUVHTIUGSO5+kR9U0QUxsIMo76gLGWuNfRnlGDypE5yic7G8T1d4EWjHuKf0nOxYQvqV2DVkVaQbvJKgzpRDVmVxqdUza+pZjoKNVCSidfR3FSq1S2g8ppNrnWPAmfay5ef8UKMa9bS8eM05B6q+bO8LrY1dh2wfLamrn2x7SvH3KEYniP+2hdAzA+S/AaD0RYZHWUkkc7th2/HowAopx5KO7qUELonz0f4Gv4Oj4M+0bEfLEk8euDXbLI6EFLdzpvYgDe3Zzj0JmoA8eSJtknH7AgmXMaqidSFK5BlMxQiK+CrRdOpopT/nnSudvn5SacwQ1Wdvqr9fvEfcv+++48GSTVDOunOPEQYUyLjaME8nXLmd0h0KIL6ICXeIXWnYYLlFpyr+iZu2KAW7VfECZhgWPKsXgOkA61znm5lI7GFo6zEbS1JUD/dxSY9OOwBJfbjZft6OeEET6LiEeunBJ7R++aELdfPxw3sC3byADRaH4Kxefm+Ao1iLQgA9wmzYAk7dhhxYyHl5WX8yPB3d8ELZgu2mfx5+yIJOTq45qAkOmc9Wvk/mlGHFMj9sM3UCDezTTXPzTIiA36hLZspv4GmbD391rq/SrvlyMksBd4ypzxaOQXII=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(10070799003)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+huAAy/5m0vZTMStoIj8brOu/Sk5qOXiJvPYxeso5MIN8lpoui5E0oymVoSY?=
 =?us-ascii?Q?BCmrM1TkrrrcI50S1q7XvUnBb4mCbVLdnOSf7z8/M0RY+INoxGh3qSWM9qUd?=
 =?us-ascii?Q?6Jnudhg0wUFG04uY53dg4SajEVXnQgjd9XWb16HfI3O8bHSo5FTtVMqUHiYR?=
 =?us-ascii?Q?urxP0vyq0z1wiOwHivc5PWgrvLF62xhIloAImyf7WNNdRcxe7CqCOpOCW1ik?=
 =?us-ascii?Q?ByB8EgB6IhUpCKUR40rCGypmsENPF8b5BWg6e18Qj5EDzfeptgGgz42GPq87?=
 =?us-ascii?Q?oqWwAUhJ0bB3hOf+hiroO8kVvkpLTfb82AL/gqi7tRwHKre1VKI4H2T8IeRi?=
 =?us-ascii?Q?i6w5AeibgjA6lCf+3jpHkx+aO3by5QKRrP8jEVDnUMPbF7snhRseZZ9M3xmy?=
 =?us-ascii?Q?0hVQXhlPQupOUrvrts+L6nINtKg3PzAkW906gcnSd2kqK7Ma6erkckTxcfFy?=
 =?us-ascii?Q?iULMLryd94uz6/DkS+Z3isEuwJOHsh+x4f+NtPrAXckZPdtzuE+hz3/ke7xh?=
 =?us-ascii?Q?r+p/sX/QZZ25IqmDiF5meO+FaJ6Ej3EP2ViRFshQ2ypSh5Jc4iXh0mjp8ho+?=
 =?us-ascii?Q?GLOZYEKtYf0kp7lK0i3AMje64YfGyaIyi6xSFCip7LmjgbWp/UL/M00lT4PI?=
 =?us-ascii?Q?QvfNwZ0i+ddcVCLGdrbyEAWM+dOaqE1jKwW98pAtwMbIp+NpZYDsmFMaJytd?=
 =?us-ascii?Q?jDE2TANfnZ8uzq6JyyQVlq5Z+K9ZNdIKdL4WHrm8g9dz/2tWoqgXDSq3uwB+?=
 =?us-ascii?Q?+o33wr0WVzZ+SH60uObg10MJ1c3kmdqWcBhghFwHMCGHvcW9mrNfcyI6jKQb?=
 =?us-ascii?Q?7Qg/Qbno8aD39df27OhR0CI26iuADzHcbVVN5BUOWhXKhhsPt3e2ELvJ53g/?=
 =?us-ascii?Q?XAosFGqd/2z8B6ErMY1H/MpilF3Q7hkRjxqedZgF5OwQvITsN6gKXRImtMhv?=
 =?us-ascii?Q?ygGRU9+W+WctHvm9LVA+TJt4ADPZhl5G65rhMBHc/Tu22bWMrdFJZppregbo?=
 =?us-ascii?Q?6ah2IaEXnr/MLN7iWyihhCm3ATrsqEa8EeMwlLl6c9C9JUfnayCf/3LCdp9H?=
 =?us-ascii?Q?6tDVuJ1JfdHdc7BqmE5ZCQ/PdeR6OB6WIRRNfGIkst87Xcx0O1xpG7KG8+Ua?=
 =?us-ascii?Q?OreGjqLx9WlTAjeQehkBR1TU2Lpd5WQC1mvZ6wQ6b+aWtQvpk7TmQ93z8I6K?=
 =?us-ascii?Q?Pe+4NUQOtBx/xvnXW4Feang4WTlmHZPtNFMMDnFxH0QLBvj6l7jnEe7EkiIB?=
 =?us-ascii?Q?PhXP8713Sd1+bpfURmw/K5sk3Qs4u666KSJVsgL8QZ6RBz6Tpfqs2URXbmdH?=
 =?us-ascii?Q?fyj5J4KDGvwxMv/T+GElkh5PU2hskKkn0Z1IxSMANdFrQfVSoDirQ3xiiQ1d?=
 =?us-ascii?Q?Uv1xWmzrF7+Pxk0aBMTUcfqToN3WE7kIRCtT47nJx+McgFTBTv6/+fJZLY0g?=
 =?us-ascii?Q?sKQadiLvTzqhDaqu6F03tibYp2V3zRKS24mNOxdzBlA3ZuO9Gg8dTWaNj7In?=
 =?us-ascii?Q?TlFCQ2yLBK+1WNxrma0CgHoHsoSMx0lCTVP0GdJVyHTOzPZ6jRpPK51nqFsd?=
 =?us-ascii?Q?y0muNl+6ObOs1RAT+deb2vB6E1E7CuDZ21vYzlPy/muZHkB9tKPvq7v2sBzD?=
 =?us-ascii?Q?jjXBp4u7M4OBBq08gvwy79hZKWDiuojxTd4DKEnTEQ8UrQ5EfC1smi7xMlg6?=
 =?us-ascii?Q?g0UpQ2PoGiPGDrRhhD8jhVtrgktk7gQLoG0frCDWcV2U8B2eqHmk81P4HWEF?=
 =?us-ascii?Q?IKc16OnFe7OM61PEAk5csG+dciLfef11rEQY23iMi+1rrsKcwJ2oZz80L04i?=
X-MS-Exchange-AntiSpam-MessageData-1: sNs0l2qU6/83toDm0JI7gQSvCqZA/35P6uo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fda7ef4-d8c7-4818-3d8d-08df24660c31
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:28:02.1897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Buam20NFbZx+gQfstNqjdpXr0WmW+oQwP48JwaDuLA65iVG8hRCUBQaySNe0bld4JJjTPtM3GHaxCPC/WXP8Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8598
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

On Thu, Oct 01, 2026 at 10:47:27PM +0200, Vincent Jardin wrote:
> +static int sd1_enter_40g4x10g(unsigned long base)
> +{
> +	unsigned long lanes = SD1_LNE_LNH;
> +	int m, keep, ret, err;
> +
> +	keep = sd1_port_master(base, SD1_LNA_LND);
> +	if (keep < 0)
> +		return -EINVAL;
> +
> +	ret = sd1_halt_port(base, lanes);
> +	if (ret == -EINVAL)
> +		return ret;
> +
> +	for_each_set_bit(m, &lanes, SRDS_LANES)
> +		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
> +
> +	out_le32((void __iomem *)SRDS_PCCE(base), X10G_PCCE);
> +	out_le32((void __iomem *)SRDS_PCCC(base), XFI_PCCC);
> +
> +	err = sd1_reset_both(base, keep);

When entering 40g4x10g from 2x40g, why do you need to reset both lane
groups rather than just lanes E-H?

> +
> +	return err ? err : ret;
> +}
