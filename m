Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544E1CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 020A960BCF;
	Fri,  2 Oct 2026 14:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6COs_4AJWLES; Fri,  2 Oct 2026 14:08:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5653C60A41
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790950115;
	b=jnymwlNr42YMrv8ItzStRMxTRMkbrruH/1rkVkl9rND/D3wru8OX2fjy771IArpgAnbb
	 MvJ7BzY9WKajsdP5JAXMem/7vDF858PwkmWFlRxG9C5OdNslTH2k50XvasQ1OjcSeswUT
	 +XL0PV/lGhs+YCvAgyT5W0m0UiSuABDOUVJuPzRBRkCpB722fK53veMe6aIz+mpnMlUZb
	 GTbhVdXVKoduPpzCiijoehrzevjKFrt0ZAUrdB+1vDEj9qvYTtoo5rWkHf63hDOrrOWae
	 bTAhCDm1C7o02IEihyPXE4QNG5fzSOkkGJYJhbbQbE2aNCLhePYOoglUnANV/EnkwGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790950115;
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
	bh=Vo0+35jXgF7ILxSYzG1CXMrMx2bnytZIGEjuaHPCm+4=;
	b=aqycV9S9Nzf1t70UEWh7b2FLboIJyUL8yYoL1dESZwL8NW7Y+jBIyHyjY2qHATZiWbHq
	 Qb2SbJc/3+sJTtRRK8m0fCNrLvRgtwNf9U+Fp8z8LUTnqO7YlH27JytRz0EwgokrroaFm
	 okcl1vG/WVMD0FhdzNyO3xppHYEAKraduWK2LsvhCX+BXKt4AguMG2VHqIIscwcs2YJ1o
	 +LC7pAjzGtt4f5UckzJAgndtg25wF+Ss3XJhOIpd0ZLLW2G2RYo7x088vkAZh8BpaNIga
	 hq02b8mgaktR2y8DwS8wqB7cfaPgQlfJRcu8/vaS2kbxc+TAfOs7r6alfSoI6z4ft0Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790950115;
	bh=Vo0+35jXgF7ILxSYzG1CXMrMx2bnytZIGEjuaHPCm+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EIPqJcJ6cIlrH2CTZDpenC7M/ETGLGHnn/lVat/rBqCAQpj72i6nWiBLKPHYR1kwQ
	 G5wPqEAFlhTYmEwZwYc/XCbO5/B8iMmRJMhQuX5obSaARvBWHKsZLv2ezAj3vNSvRy
	 gNaOxMH2o0WQcrn8JGYCgnoBydMbySAZUhbsMSsMgx9aVMTUoPSQWjLUSYsutmaDtw
	 Y4dCUdX0iRQqJhh+UvyWTqj1L/A9PYKMksq8tg+3erBYqq0U+2ItVCtNZR08wUvLPD
	 LteVZ4iH9EPuN8+8armjxj4Ix59Drdr5Fr/gBq8s/kDDUgCSg2rDcx+KlkNkHmYob1
	 q2ez1q5cX2Nkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5653C60A41;
	Fri,  2 Oct 2026 14:08:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70AEA2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56D4E404F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdGC8syLjmLO for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:08:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6F5F1400D1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790950095;
 b=PFK4MqufYoFukT+HyWT4eK0fsrx8vcTpazaNyztmn97r3+D/5RcCMg06nzED92hYKS97
 kHBj79+kJ9Ru0vgxjhiAcLAbPszSsqYToeL7UoAc6wmoPQmj/ZTe7aIX00Mz8qq8Gop7t
 GKs4XV+S1yVr4HXs1xjQedGGkY5oRuKaWLiRDloli94swC0LsCNF/uuIBp2VCXDXz9bhC
 A51l9Gpg1TjgU5DthMlLRDIdNFPaL3Z59m+mNha3Sot6w2TKYPCv8otPu1oAmXmOr+EBu
 xnUQxjWA0raKvEIHiqjjmPKNjpA2TyjbgLU9q/bep5wDmc5fuBrW+ggvdgapvfnXCXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790950095;
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
 bh=Vo0+35jXgF7ILxSYzG1CXMrMx2bnytZIGEjuaHPCm+4=;
 b=Y881dhTNbvjwyT4qFQJkNUhuhxMdTdaw3L9ef0kqONJn8LsG+47A96sjbM9fWiZkVlec
 EBq1qTgO1nbZAkuVkSRmhNMxSkdYr/ErArG5Fs7+/xEeQdwjwCU5kwkubapdItZJC8ixn
 XmG/MmL+/Dfk4Pa0iGAycSDiRi8bteC02HtVRsVhyNiWeABH+xlwrBtphKXX1JISZ+lrY
 HJqmQLyNMNCQ99pCZ0ZNbE7QQab3q2FNbMuTojg64F3Tgxrx7gL/8H+VMQ0knfwS/4Nhy
 wjcxCQx+QVU0a2F2g+ybPpLJnu5gda4YCTVWfgQhPQlYM4iOF9d+xSsk+2dG5ZPbAxQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=flSe1ET0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=flSe1ET0
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F5F1400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vc5cJ/nsorIgEMBEx0oW8+qNFyhSObSpydQqjrV+MzqsbREGbVOVmJfyt8y0nAcrv9hgOkIeg5PMg7SDr1DoRrhHsApZ9IUIT/hpaceLHeTzQXfQqCze6/q30p2xRPI0QLe9Ez0QbRkfna0LZ469FtLxyEH6zTKompgaIlvMEEPgwAmyBBsjPuEQ4YCsmR8ccWvhv28voxOl39jRoE+fg2xeyVGXd2P/n1Dl8jdu1ROTxHKorRe83ahUabXUX6RfhADcMsycc7lHJQt2VhfBe5B4M3AOQVaIeNOfHqKrzRxNwpFjHSInf1D1vyhRLoTahqJLLQpoaH8FQm7hMtGEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo0+35jXgF7ILxSYzG1CXMrMx2bnytZIGEjuaHPCm+4=;
 b=WEbsQWv2c/HglYBFLmGi2zk0eDRnjzSt+w2kwqVMtcX1DsDPEWCtFi/TYypK/7+OFbU9SGSyI88z6uybjSCPAipZ32hTGaA3HX/bJ5T/UHdPGmHNHaVjzXKXSS+aNxuw050npZRVoHibgdsnflqN2NjDwviXTBFee6HUKk5Vp0XnySfA+xKh+h0tFScknNOIfhSknVa1MBGRNvUypYDeq3GXna9ybJ118OV9b83RCSpb5oc9AzDtGd41R96iqD+pnlWYgdfyzrrJ0+l7yNtINfemPthvy473/Z/Q0/G7rfahxcMqjiuvjn8DhTeiOL8wp+v14WWmXZHArdVFap5UNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo0+35jXgF7ILxSYzG1CXMrMx2bnytZIGEjuaHPCm+4=;
 b=flSe1ET0mN2hLUdlDdCh8eSjoof0Dc9ZKGjF3dhomIH4FsTKmbFs+XE++ljOqp/T5ru4sNaq9RlXjrqOvFmJBI17Kdo/40/mkkilSp4w+S8y+OBH4LUdPc/SheDE2HcDGIPXCQfRZmBDwqnnhMKUZWbtW5c/M4uhL22KiH4W3tAcNoJkvEADSxEqQ5inxC+7ziVMMTeRJZoUnPxYHCsXAjs2EiQnuvuJ4gK82eaFcuO+StskuSkcYZZW6Y1xwuv5hP6syL+SVklZiI8oAR326ZI3NRG0h5QUILfQq0RgvMEgnn0oAQsqqFc7Tt1vpi1nf2IdGHHwsX7glXq/WAwlYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11045.eurprd04.prod.outlook.com (2603:10a6:800:25f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 14:08:09 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 14:08:07 +0000
Date: Fri, 2 Oct 2026 17:08:03 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v6 09/13] board: lx2160a: serdes: enter a SD1 mode
 through the mode it starts from
Message-ID: <20261002140803.rm7elfblljzo6ctv@skbuf>
References: <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-10-vjardin@free.fr>
 <20261001204731.1774613-10-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204731.1774613-10-vjardin@free.fr>
 <20261001204731.1774613-10-vjardin@free.fr>
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB11045:EE_
X-MS-Office365-Filtering-Correlation-Id: b61a9aa7-64df-44a7-2d1f-08df208e94ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|10070799003|376014|366016|18002099003|22082099003|10067099003|3023799007|4143699003|56012099006|11063799006|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: LtU76/L2f9OkhaAkP82Yicat0IHOqiI/F1STTXqfAjLTE8C7wHsOb+a2XGY9DjVpyLyok5WObY+aWvBioJ26azhurOoY3Gv+/rBEjOpIP2iqJP/WPd4V3Q76D4ZWYeErg4YSw9k8GeVCgRgfQpiLCB1+CLhOSytGQJrtjXCm2Y5oczXgunBUs3L542+05nzbCE9pj2JmatEHCMAShadJ040JY3hmCVrAMV7BwALqV6Eq5aftYOPJrpI2dEKodAWIT9l4YUuDrCiRuROPQMr6C+xWmEEY9M6U9hoCiz/UDbwQSOf6Z+mpYjj9qkruVAPsjpK1+UN+t1Xu+GZK0h8vry0fku+6gqqA5iXN1PyHUV6FT2RzrL1TGzbWBA14APtuNEOTOR4FpAai+6n3K5lNM+F8F0XdckRXnWj+KC91qi5HA4yvQYQisglRqg2Xyiwl7veNRsV25KZLle3bZWVbG5yhFAHpskCFAU18Ay3cfHh76ZUhZAxdws0jYOxitx8o7JPMROfjy7lEAPqcla9noLpz+wdRClcSAg3Um/OWLLEzM5/XkiTOz8/QN2idVVqh2gzBVzyrpiq5nz3PITP9qg8denhIQy4AtnFPqJ4UtRW5WwuFPBGTOf1SJjXigI/SzbrFpONl9h3ZulfWrnK2n4EEBKeJ/yo71MLMcSgzNY5EGhu7I2bECNoq43ZsXbmTKToQvm4ZZaWxUKjVEQZt10P75b8KyBZj7mFnVlG4BcdvP1HaaCdkG2RYDdvDdXGn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(10070799003)(376014)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(56012099006)(11063799006)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KD0nrYX4NDC49R5mQRmncj4CNwU2rUltjj4sORLF8KZvBhT3CKTvSTmcEg36?=
 =?us-ascii?Q?HTop38SZAa1fgeXba1sua8avStNtJcjZkHl+/YD+r3ca7nhCX4NLyuGUuJ7F?=
 =?us-ascii?Q?Xh/7m+2CKaJ21ojQqvxCzhIxUMxaUhQLNlSpKxyPYTjv+lYTbTER8myFvsDs?=
 =?us-ascii?Q?xRRanMls9zFkxQHqEw12S1+g7vfOyIy/bCmKNHsx36fP+L1EmY+xtsruTPxC?=
 =?us-ascii?Q?6H1YPL+QjzqUhxatEweXqK7UGSy6T+aljLvIuwFVVfsGzgXhu7mqVyGAj15Y?=
 =?us-ascii?Q?L5dSTLMW3zDkO/ZeszbV+kgZbRyhs9vy2YzKk81oXBU/d8cbDV7pa9tYfFyt?=
 =?us-ascii?Q?rWLtmX/h90XaxtSvB7rmoGIBYU1rNJyHq+JyeFm6yxWUTzMtA1EgtmA45/gu?=
 =?us-ascii?Q?MLX58IoZUEX8F9SZgCBtEvKO6zEkazqTWO/SoqmYfKNMxb98MySV+RPFB8cU?=
 =?us-ascii?Q?DHGhFFEKSuxN3wOPNDNFymkj6O6vFkrjUna/XVilo36+tjtMelmg5A2q45gc?=
 =?us-ascii?Q?N1SSKKJ75KLxL4cwMzOmXALX3Shd0Kf7CTpap5s/ptIKm0JQKoXpCLzXsuTQ?=
 =?us-ascii?Q?vM6of7atB8+ibyQsw3FX8yqKlF/fYu8nO5zrulkzyq/IO9YxcqFpjuOl4RUB?=
 =?us-ascii?Q?q2gqgLWC4JXDmXV/cIhKYmAMSab7t4iNHacQDQqggVO8O+geLXhOcv+d/tZA?=
 =?us-ascii?Q?gLzFJ3ubY+oK93NBFm6ECiyrFPf3xbhBuoEKeule0GoCZHpvFUY+00PQLoX6?=
 =?us-ascii?Q?ybNYkwusUsEjZwfdkGBYbPdesqj/R5SV3P8Us0MQ9ErKKUsgbCkkrGh5Uvv4?=
 =?us-ascii?Q?N/YqrlBw1EHmDeGu5+QlXkvSX2LzQG6oy4TxrdSEybZQbp6La5cJXUgdJkl0?=
 =?us-ascii?Q?4TFs9Mt3gjr+8KlEyWRhCZ7UMG8Ui3CAzrQwjy0AMbIYiBJLOHRPdVo5FL2j?=
 =?us-ascii?Q?mlCIDrMRBYTG4wfeFCvJkHdIr9R0kLAOZL2MVQKSE684X60tljx2i893a+os?=
 =?us-ascii?Q?t5apRgwVQOONTgUcnZAfzBCZMBPQcxyNiMg/NM/A1iDbyY/3VSiCHJ41UKKG?=
 =?us-ascii?Q?atHqUzH8oLykX/PMs0HIodSIDQeuAxGn6++GCCXtoIqEivTI9uen0gxXEGbL?=
 =?us-ascii?Q?NBsDREhravdgRaChQv8AZrLu8Ib0hEkoYRlXa7wqH5soPE0jJhrTSD7+cMvc?=
 =?us-ascii?Q?TvmUFTssAJYYrQiDxcMY52874YSlo+xoJI1DEzOHotZiYOK/utlzYJFNA+tL?=
 =?us-ascii?Q?04wrMuLSerCsNJGOlBL0usEvGNRiZNKtKp68ckuLtYRS9UqGvazwG1rpxGze?=
 =?us-ascii?Q?yxrlvNFLkBwnuzkbK/EjUinLCs5wLeolPOPMCQbLuzB0xefpfrbRhTUs/50W?=
 =?us-ascii?Q?x2AKxvTcR0H78qr4vchxhJZWg1trMg3y6tnqjuczj9Z8ztGwtdurIFJf6WIJ?=
 =?us-ascii?Q?Us6kxMiH+ArVE/OpVU4sTThM0v3sp5wV2vbwdh0OqRScYuwrfbXpPYJ52bux?=
 =?us-ascii?Q?ID5/IkshU7S1LKKX5hXL2u5HLdBsWan+W7afEF2peTMCL7uqndJwsJjPZQx+?=
 =?us-ascii?Q?/LQ5aizPi2Z/5fQD+i6YeVMORE2BxcWdjM2zZ2PO4iLW0vlpZU9H5mAM5CQm?=
 =?us-ascii?Q?YM3YX2UHmyQh8a0vGlwhViWFMooiIGs5mbfSdsNFWWC1YlHgUrUBVH9b/s03?=
 =?us-ascii?Q?Q8pe+h2zK5JUechCVoQ/DRuXApNOd59Q939qTbS2W/VbLsswUcnnE5+Gm4oj?=
 =?us-ascii?Q?9I6c4ejTNLUraTzTEKx/AU42gjmA6oclSr/KPfWb+jU18JfO1GwDIXQz3QBZ?=
X-MS-Exchange-AntiSpam-MessageData-1: X9vWsbFco8xDEg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61a9aa7-64df-44a7-2d1f-08df208e94ed
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:08:07.7581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWiCNJJZ8ocECi2dvMKYL59dxFHQrhFarxB1i4tcCUzu+0v8A5800QJHOlPYGYx/Tc3lJUwF61/ofgcePwen5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11045
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

On Thu, Oct 01, 2026 at 10:47:26PM +0200, Vincent Jardin wrote:
> So far a mode is entered only when SD1 already is in the mode it
> starts from.
> 
> The next mode, 40g4x10g, splits the second 40GE port into 4x XFI:
> it starts from 2x40g.
> 
> Protocol 20 boots in 2x40g, but protocol 13 boots in 2x100g, which has
> to be made 2x40g first.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
