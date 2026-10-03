Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE11CA5FE6
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 18:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FF17812FE;
	Sat,  3 Oct 2026 18:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Hu2Y6XjBDmS; Sat,  3 Oct 2026 18:53:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D2AC281316
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791053622;
	b=TD0KlyO6+oIGznm/mb8PeWboAbrysNAekbzISeD2TDlQkxFXNk//Uc25l75SyTyXPvML
	 nn5l6a7YVLjZ6R4EP+Q2ZVnpMvZuCWk8D08Q+oIKwjBT7GGNNATmpccWrNs43zCfg+6+c
	 VMpVwT+0Zr9+601sGMhzbH5aovd/By0PWb16kmMNCXUk0DmE7X1KSXru7I0O8zZPJEZQJ
	 3EBrEmFAJOzHKcKezjEj2shBs0Mt2JgVa5SrPrcaNNypRAg4d723xKw9J6UbTbxqcGnQT
	 ZC44WXznMeXQ4ZzGjQRr6pfwI50lIJj1XuW5TTkb3EU7DS2tXpJjM7/6lMbJmFbRU3g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791053622;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
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
	bh=36a4W2IxhiAs/whWKH7G8YgTyTfm3PtgaNKgYdnZIas=;
	b=gobW0kvfOdrTVpAOJz76FkDdfWPfxUv8/YZbmNfC6hFzNLTwfEdw4o8PeG4euZP1nKhm
	 bo6gaKggBoTvCEJp5bKD8bPr9KHAYdr4hTWkATTBPUqioh0/sZVNa81WGRkqsELfh29Ns
	 0yyQ3W1Wco0O3s/XGRgfsrVnrX+YDp+QgZHREyBY8S7xp7evLOUhkzt+Y7fwjvjtDYWdu
	 6H24GkvHDzvwksP8XeyNs3HLT4NHwJMwa2g/20RUqqhU9GH3C35ptskKp3EY+xdCqXnbf
	 9RhMVFVV5mGAOyFq40Mq3igy/W1Wg7Jydz/gOMzOZLp+3inzZJPacxEw78nKSIpU/OQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ucP2Vva9;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791053622;
	bh=36a4W2IxhiAs/whWKH7G8YgTyTfm3PtgaNKgYdnZIas=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bUXOsE9Kp+XT5/wWPp3al0sH2JVbUXkKp0kwyn6238IpBnAcoQcOOvcI0Zdg6z1v2
	 nyE2KbFdzc8Cy2tVdmNcgMSR5zrS1EifE0ODZUZTRl/qLHlF0pcsFTRDWan5+DmsZz
	 b6H/U4RwKN0vWdrwmcGEHpFphG8JZP4rKAcfjTMaUa4JfL+U72PKyVRQ1gajEx0imn
	 9ttQf335do/N78sHOFlcTKnb/DzlewWD/P1uGFYAgrgHkaVJ+Z3thB6KYVsOrwh+s1
	 w83wrecVu9f7an7xesYUbmm+Cg3HpknIOrHfDLJLnIjVWNjSvCDYsjvaelK9R8Q1Qs
	 yqQOYVccktiig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2AC281316;
	Sat,  3 Oct 2026 18:53:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 848061A6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A5F081326
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:53:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVVI2yFDS-sQ for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 18:53:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4876E812FE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791053619;
 b=UYgAwqTWN0jZaGf9QsS2VFnmcHKj9pektB8bGIyug8cQhwnwN128yKqpcY5/7OqkBmsu
 1WlVKjGEc56mjM+y4z+w7ggDoAh3bHZ/63E6AK+i0wY3iCHyphqUQLTPQywjRBzhf4AG4
 m4PzvN+fNQADibdz1uOCumq1rc6By8sft3NHw3Ca220WCQO48VhZt2foiM28K+X4bmXzV
 arzLDy1YS8HCZaZobla+UwOsBK+IeZIcVDvwfLMexiRQO+6+Eu5/3NqrvrpG3zg0k4j6S
 zqACggKHdubuJeq2GYKDIM99hg0oUVvVgUIZ8tTjnowCc90t0yM7BTrIE79C8lULxyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791053619;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
 bh=36a4W2IxhiAs/whWKH7G8YgTyTfm3PtgaNKgYdnZIas=;
 b=OofanElQnA4YIEX3IcPCO0SRdkVqgR1+55naw4aL3Qt60qKivi6qBAEWAdd6iH47miBL
 KpNssGQKK7i7vF6pn6AmPXC/z35/GLucFFIX84Vz0h73dFfoJLno1qp73u9AC7b5V2BOZ
 Akhuk68lNsAsc1Jy++VCKIwOKlhCTqxoX3PQ/IoRfYTs8O46yRewwJwpSff7VeRsCftzl
 D0RlzvLBqLgZAf84rJZyvWe81PRF7ayD8vtpNEIawtB3aNQGRCmzmoHpFlmtD3uQ6ZPT/
 5f6fZx/33dAvccQiJ6y+9f+FznOWiFQ+WhyNlGMhlADPe1bKjVUDmpBgIjNUubVqcUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ucP2Vva9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ucP2Vva9
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4876E812FE
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh3tC0UQBWwhVmPLDN/vKgyuJFC1J4DEqp4SgpJROAGwN9TUj+/ubr/qCEgchjn3gPaPs7c1OdzmgFNwLnzKkNHXusUaUQq0zRv0+p3t68XZScTd0dFlhT+sm5mTqOYM92sV6bfXb1jX4pTbXmWL5q8CFYr56Ne2HdZ2tF89eAuWJOVqxv2SYKZmxzIOfhEOU1Bou5pR9kJ8vTth5CQBZQK7ZlKJgJFw0Ne2nr/jNYUknN1rpAswPxIt9tC9Yoi1bsnzup5DNns9/jGovQXPWCufSQXpMP6fyMKbbff+7TOuww2au2npPd46gEXEeh6TxHS2mQly7dzVXmpoxht49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36a4W2IxhiAs/whWKH7G8YgTyTfm3PtgaNKgYdnZIas=;
 b=mC9TvGCsIzG12+iPzNZSmYSDIe2sM/oLmpntiLhrIov8H4SzyquiFjGlmaLdLG1O3siYOAxW0ggxbHfSvJThOO+hLdK4b7ghQATbeQ0C36GuFH3zyNoTekxpnaefq/eZiTEW2fXkYbrMlcyKN8eTYw7Rxw+CifPYcUnvavGa6kqRcwTo1wsMBXM6p1zpZ2oQ/sFyc09TzBGFY8as+n0ueRIhjVcHYb8pCzLMj+pCvzajXZaO1fTopvKzNbWM2h6m9VBCGGCvLvbdQpSzO2ybZZ97zAkCn5xypIvLPpwvddKDaYLH/R8hGveYuzJc8FeGOAZMM4pf8NGgvsonFJSUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36a4W2IxhiAs/whWKH7G8YgTyTfm3PtgaNKgYdnZIas=;
 b=ucP2Vva9+nyJ4j7Ut9BcYE7IDxja6BpKSf2kjfpYi+phO528BsO2KcZfg1juDEG3X6m32gYvaQn1sXXjBy2CtJF+mMINApZkANP6qT1wSNOSOTx43zGcXiH/ywONy7jywApijCdtb0n3oSxn8r8AT6+l53LD5SINdIx0knpBH+yehSU1iXzdy8f7GgLwZmErfaBI4OitTIxP50zfw1lniKx7CnH6h47CxVYML3d+KgACYaxsdc4eCVjP5EFKy/B+ZcLoTzD5+kcQhGJea7UaqZ+GM2qVebsrYuS6xtTgabbkOu2qtGHiZt9OZfrFVtIio+qfbsb3Rew00FWXa/MYFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6199.namprd03.prod.outlook.com (2603:10b6:208:315::18)
 by SA0PR03MB5580.namprd03.prod.outlook.com (2603:10b6:806:b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sat, 3 Oct
 2026 18:53:34 +0000
Received: from BL1PR03MB6199.namprd03.prod.outlook.com
 ([fe80::e36a:e873:e394:f6e]) by BL1PR03MB6199.namprd03.prod.outlook.com
 ([fe80::e36a:e873:e394:f6e%2]) with mapi id 15.21.0451.026; Sat, 3 Oct 2026
 18:53:34 +0000
Message-ID: <081f83da-8d7c-4cdf-8c6c-151e0372a5a1@altera.com>
Date: Sun, 4 Oct 2026 00:23:24 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 3/4] mmc: sdhci-cadence6: configure PHY control register
 per speed mode
To: "NG, TZE YEE" <tze.yee.ng@altera.com>, u-boot@lists.denx.de
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
 <15e724cc7260e5f280ccced5b453b2978490df79.1787710268.git.tze.yee.ng@altera.com>
 <ec129b92-3fb2-4f1b-bc9d-2a901163fd76@altera.com>
 <c97dd7b2-4375-4352-86ab-8870a1dfea4d@altera.com>
Content-Language: en-US
In-Reply-To: <c97dd7b2-4375-4352-86ab-8870a1dfea4d@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To BL1PR03MB6199.namprd03.prod.outlook.com
 (2603:10b6:208:315::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6199:EE_|SA0PR03MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec2a0b3-954e-41fd-1399-08df217f9fd8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|10067099003|55112099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 0i1V3kp6xHXVZ+RqWWL0XJPyaxAVAnviBRO3JITbFAIp4C2eDI6MXzRXatNxrIi/hxji4OvHt1JG+YhyVP7F4TJ2PPq+ZKdjRB4BXPgc14Lb4Dte+XFB791uZTnt+w3nqD3b/IFAVephHgALoLKISdMWOQJ/HOAwsXkFJkcEk4azpHeRz1IDTQ3bq3a1gvvxHLU1A8N7acC05hBts8UdwWHCLmMW4Tfwrj9q+2itAYOAREbF9OUXy0KsRPMVBOqPC4I2uO9iw4REePTgACXeajbijnlmAx7U5HrjOdjw4/8qBNEUWXLw/US8siX9D/4/cVzJTCU8u/bDel5FfXemZhpkPqykLhgNE9e0xbOr7eGWmcQQz4PjDR8Iuq+op8abL7HJLlMEZGMw9MRI1g1dc/liD7TMlUu9Fn+eOELrsupJW2lrj6fZ7UvZK4Eo3RFauQthNNRH3K5B8YUzuudOZr2z7B2eYw1vs3WAxX9v/Rja5lqGho0U6JJ1jp/X/+tBS4Yq7VmfOBJvtunSyJV7//oio5U1sHOmzREpWrpzbdEu4wSotuNv2ysPwyR9AYn/RgQq2+anALeR7npziGLNX0riJ/j09XdVS/n1HhU/TKIA4lJ+xG10ZhbhpZHZhBx3huxdu6EPhgTh9JaZRm75k7zZTOI369ZUPiV1w1VYDdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR03MB6199.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(55112099003)(3023799007)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2U5eCt6Rk4zOCt2a2VRdzNBdVQ1czEvTTVESmo4Mi9tWmNmd1dwSG44ZDg0?=
 =?utf-8?B?VUNWK2piRUhuNHJWaXFyMEJ4c2J3MXlDZFI2VWZORElEQ2Nkcm1YeWpXcjdM?=
 =?utf-8?B?KzY3WTlQWGZXd2txM2lId2xseTRqS0lHQVRUR2xnS3Evam94N2wwNGlSU0E0?=
 =?utf-8?B?Qk9yZmt3OWw3Q2RhTFoxWG5lV21pdmZESWpFTDhUV0xnT1JxaUtZRnZXS2RI?=
 =?utf-8?B?V0tiaGRueWs5MDJ4RzN4eXZveDZmcGkya2xOUUk5T2N4b1NFUjF3VFRqOG5q?=
 =?utf-8?B?Tmw0MU93RWZvaTEwM2hqa1RtS0F3cS9FSFlMNTNwTzNoUnVtbm1QaDZyb1hI?=
 =?utf-8?B?aElXSkhlSXZBWGVrNXQ2WkRoNVNwcGtaT0JKTTdtSjFFclVpS2gzbys0Wkd6?=
 =?utf-8?B?MGI5T2xReU1aeVJUOWlkTFN0bTk4Q1NWc3I0WVB2TnFaUU1qVHVRdU5qck5L?=
 =?utf-8?B?dHNJV1dRNngvUTNYRVU5ZG5CV093L2FqVmsvK3NicTBvQ0JLUkIwSGZ6c1Mv?=
 =?utf-8?B?VTh3dkdQZTlWdElTMDFNaTBOQXBRRUNuZEsvaUdldjhmQTlFaEhRdlNTNkEy?=
 =?utf-8?B?ck4zU3pSTWxvcnhXQ0dxa1Y3anVQN1YrbFpybGk0TUpHTm1ybzRDbHFZaUoz?=
 =?utf-8?B?MlZaaDZlbVlma3BTYy8wclZGNWlrZ1JXSEZZR3NQT0tsTnJaVkF5SnJzRnJq?=
 =?utf-8?B?RVRXRmVFNzFiL0FsMU95RHJ5MTc5TWhCMmtaU1kyWW1YMUN0SmVScW1sOWhN?=
 =?utf-8?B?L2ZLS1NiZHQ4dFdGK3YyTE9wZ3RhcTVFN0dlR2x0UUowNDdQMFJaU1dIc25R?=
 =?utf-8?B?L1JJUzgxY292TXNzQ2w0RU10cWdwUDMzZVBodkMxNENUZEp0YWR2OHdxSXlY?=
 =?utf-8?B?Y3cwdmIwSXJwZmVqUzE5amthQWN3REdmVTN3MlR2ci9GNnUyQlFPSFJHcjd1?=
 =?utf-8?B?L2N0WGtlUmpKNGJkVHFVU3JXczdvcjlmOWFPZUJlQnIvWGJORmU0NFB2RS9t?=
 =?utf-8?B?NlVHeGRLeGhybFUxRG1BMzFJdWYxSjU1a2ZPTEEzRTkycmMyNHZBTm05a1E4?=
 =?utf-8?B?Y1ZycE45eWVXLzZ6clBXenk0MHJUZmRHTVVkdGV6dVRROGU2KzdNeHR1dTJl?=
 =?utf-8?B?WklhcC9iN1RjeWtWMzJTVmNvelJ5SlV0SWVkV01OaVVtVldnSU9TSjJMTDgy?=
 =?utf-8?B?bzYrUVFsSU9Ca3JFOUJjNkFjTUZuaUNKTDAxSklzMjBTSUNGUW5PUzIxK2dM?=
 =?utf-8?B?eTRhQjZwSExqNkNudFpabUhzUDFIWUNjR1IvS3JsKzNSblY4bFJhbTI0L1hF?=
 =?utf-8?B?S1BoVGk0dmU4L0dnanFGb21YU0RkSGlERWtSZ0J6bE0wVXY3RlhFbWJ4Y2Nt?=
 =?utf-8?B?a1gvQVlnR2dPWklvc3RZelFJdWlJTmFJengvQlNSYXN3dXBpd2lsRGRLdUVo?=
 =?utf-8?B?Smg1Z3hEWmwwTXAyVVhVczZTM0tqQkU5ajc5cW9teTBDZjVUZlBrQlA5WElO?=
 =?utf-8?B?SFZTS3RrL3l2TjNKZjIya21EYitBSzNGdU1HVk1OVVY4U0puelFxbmhzU3d3?=
 =?utf-8?B?VjFxa3hGRk1FajFISzdiVWVjWis2dlJNZ01qWjZXWTdnL2ZPeS81MGd4Q09s?=
 =?utf-8?B?UFVLOVQ5N1F1OVRVWmt3VEhHbkF4eXRGQkRuVlM1eE5NVlFZUXhpb3RtMnlv?=
 =?utf-8?B?WWVnSHRzaDYra1h0UXVyK20wZURsNmhQWTlyWTBRZUFud1dUZ0o5ZE8raFJH?=
 =?utf-8?B?QnlvWmhDVU1xQ0pYRmx2YmUzdlJxV0NwQm1oMWJrU1ZGTWtwaGN1K3hFLzJw?=
 =?utf-8?B?c2xHaXpPUFErSVMxZXVPbmc1OVZ5L0NUKy95K0x0WlRab3g4K1dFS2xFRlVS?=
 =?utf-8?B?MEMvOXVoQzBXR1BTT1YyNjc1OVB2dFpLOU1ZS0FzQWtqWjMxKytoSWEwZTdJ?=
 =?utf-8?B?em1PdVR2R0UzbFNqNjFCTDlzNUQvUlR6Vi9zRzgxemtpcFR3b0hJK3Nla29o?=
 =?utf-8?B?WFQyMTlkanJ2emFwNFNXZGNlaFlrK1QwWG1EbktaL2VQQ081bUdzeWtnb3o2?=
 =?utf-8?B?TDZwcVkydy9JQmgvcUV4aEE2WDBJcEh3ZVRqNGRjaUVua0trZ05nWitsNEcw?=
 =?utf-8?B?QjRQcnNQb05weEJUSGF6bzBhSlVhRVFNS2V4Y09XQXN5STFPc0IrVWVWTTVH?=
 =?utf-8?B?U3FjZi9EK0VqekJRaHF2NG1OR1I2UkxkVnI3VUFpd21FTTY0K3pVNDN1Q1hW?=
 =?utf-8?B?V21PZlZYWnIyVjdvaVhwZ0tKcjdwMnFtQk56SU9Sb24yRHRFMUNsNkR1RFVO?=
 =?utf-8?B?UjkzSHFvTWZ1c3NxQVF2SWdjbUppYjBFM1ZiSElPNmNiRFFOV0c1eWhLTFcw?=
 =?utf-8?Q?+lsc9dbDhaT1bOUg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec2a0b3-954e-41fd-1399-08df217f9fd8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 18:53:33.8199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nH0cWnsRPYDDseXHwh+TusEPU6m5HQi5v3qqdcL6Q535p6UHIhAM/suW9FI7DQcX9aGyM35WlbmQnU4mSmrmNbrBD2PNpDbSuMjxqHbfHoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5580
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


On 21-09-2026 09:20, NG, TZE YEE wrote:
>
>
> On 13/9/2026 5:06 am, Kathpalia, Tanmay wrote:
>> Hi Tze,
>>
>> On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
>>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>>
>>> The PHY control register (0x2080) holds phony_dqs_timing (bits [9:4]),
>>> which shifts the read-capture strobe relative to the data slices.
>>>
>>> Extend the per-mode PHY configuration arrays with a "cdns,phy-ctrl-*"
>>> entry (default 0x41F0) and program register 0x2080 during PHY
>>> adjustment. This lets each speed mode - and each board via device 
>>> tree -
>>> select an appropriate value.
>>>
>>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>>> ---
>>
>> The PHY_CTRL default needs to be corrected. All six tables also use the
>> same 0x41F0, so this is not actually per-mode.
>>
>> Please fix the defaults.
>>
>> Regards,
>> Tanmay
>
> Hi Tanmay,
>
> 0x41F0 is the PHY_CTRL (0x2080) reset value from the PHY spec. The 
> driver never wrote this register before, so the PHY already ran at 
> 0x41F0 in every mode. Using it as the default in all six tables just 
> preserves that (the write is a no-op unless overridden), while making 
> the register tunable per mode/board via cdns,phy-ctrl-<mode> in DT, 
> e.g. on Agilex5:
>
>   013b:    cdns,phy-ctrl-emmc-ddr = <0x4010>; (phony_dqs_timing = 1)
>   modular: cdns,phy-ctrl-emmc-ddr = <0x4000>; (phony_dqs_timing = 0)
>
>
> So the defaults match only because the reset value is mode-independent;
> the real tuning lives in DT. You're right that six bare 0x41F0 
> literals are misleading. For v3 I'll add a named constant 
> (SDHCI_CDNS6_PHY_CTRL_REG_DEFAULT = 0x000041F0) for the default and 
> reword the commit to say the register is made programmable with the 
> reset value as default (no functional change), overridable per 
> mode/board via DT.
>
> Does that work for you, or did you expect distinct per-mode defaults? I
> don't have validated per-mode values, that tuning is meant to live in DT.
>
>

I expect mode-specific, validated defaults, consistent with the other
PHY configuration values in each mode table.
Please determine the appropriate default for each speed mode rather
than using 0x41F0 universally. Board-specific DT values may still
override those defaults where required.

