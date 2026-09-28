Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF72CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00F254061A;
	Mon, 28 Sep 2026 14:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQ9251IK32ay; Mon, 28 Sep 2026 14:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 48F634068B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790605768;
	b=eNibmInuY9SBDJhm7K4aQCYY9eCsFdaWNK8OKUYIX37Ca5TTKugI6xKN0J+MJrrOG7wH
	 UnKQ4OwbCrSyFQ0tHVSMlkMvXhSAwY1cG1GxR/rtiZ1oiWOe8qeqNuvG1MG70coWzoT32
	 dSah6k2PY8Nd9zl5qGkY5+ED07XJTo7WREndvs9wAsphY39ynMNVwJ24G2Iqa74OHvXu0
	 mQmqDtP4BRMqgHzkc261xMJBaS5VJbK286apTAVqyxZIpcOOBWqnTkTOclsipY9hyxtRQ
	 4CjAeH1A80UpI+JWv4OTffvgGXjhUJ5X6iDLIdRvADWC6MfboWqP74hIeVbAvQQvUkw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790605768;
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
	bh=5ZZUY3qSYgPwIv1WxVz7bEicwU8PlsU7hmNai9rmfRE=;
	b=HPXhDZyrOlV4Cfx868xFDvz5A5lZK5CgJPGBASFQgushsPxBBlDVv20rKoM8wvjXvKJp
	 zOIoiObSa8JIrQRZDHBt3lqmvL3bEBcF750FlFJpGAu5OZvFdkkR6dghuRs5OROAkIoep
	 +5HUlSQn2geoUa/tyIcIwDIFbiwxF7Q12bQxDz82truaftbsAhdngoKZ0Mwdq2MUjk/Fp
	 c4d4I+JkEYpCqTSiBCgLw10ZOffmnwu2xblVw9DZm1hD0RlFBXM5AGXB+1H3P0xP15V6J
	 prXtHHOBk846wfndAu2IQRSUcuwsjNWR5OT5PJQLUaNFCp2Z6jODto0sUIugqez4bBA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MHCxJR+c;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790605768;
	bh=5ZZUY3qSYgPwIv1WxVz7bEicwU8PlsU7hmNai9rmfRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rViLH74IyIC+nz5UqX/kZwBxwN86lvHydIJkk6z0VbSyX0y6HVtReHRtsQNHcFv9g
	 BK2CosWdG1rC8kazo1Q04sR4ZxICmHm8vRIkHJZ2wRaaVrZxXPgxVc2D+9X41CikQy
	 /nPlDxeqh4zHBRYGKwq9kiNDVqEIUxYu8gHumrleRCOVGTbe3plMqScM0hN+jLRPUV
	 raG2Er4mTRZZgOkPy8e+0vaCQLZ83qcRxkAhSte5H4sTpbfcDZnmMRpsJsOrVSERib
	 krjTPFD3/owrfbz7mAEflNaW5A7KVV9WHp1Uw3/unM2KeefBYgU66f/3SlS/FtbAu4
	 nk7XIM4ViSdwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48F634068B;
	Mon, 28 Sep 2026 14:29:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D2813D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42B144068B
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:29:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ngNpYarEMgQ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:29:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F08654061A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790605766;
 b=rx/LSmE+rWGS15wZkc2J1LfLgN5IwyOMMtKmDUFGorQHBq+uB+30FHDWhp6MYJi0cmJk
 QymofuJ2s8gTO8U499jC+TXp2pIFJYMYKXrrggxecBSn+yI92FmgP1AFqC9aHF22RZ0jp
 MTxxC20dxrD+3wYK21j7x7Bx+4XUu9LPXd0p5D6wnPqF/FQNFPo//KZB83s2tillM0efd
 0elmtdFK4EHxjQij7h0luI0R0ImsXoFoq8dJb5CbguBiPK+QLGMbJoKVnKZmW2F1MO9Ue
 flJ112wNamzzdQ3FRnQXJkINfhGtr8Cy3bNATv59mtZqeWMAjQgsMpZsfKX3klQP75w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790605766;
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
 bh=5ZZUY3qSYgPwIv1WxVz7bEicwU8PlsU7hmNai9rmfRE=;
 b=TkN8jpvSDO4wlXoCGmPaCPQHF3PLYkJ5w61SaXNf/owob0sJSPUuxCt2I+PqMofC5LVv
 r3huTZaThJPVQt1OAA/5A18HcrxRwsdYFjn1AFsFEadJ41LD+un8ZEnsa40JDHkl/5DKv
 nO7f3ZovcAr0EfJznczThV4FRh8HvrHIOSwhnUSpbo4OpwXQADy/bg7FmIWKlFsfJgZ5A
 C0SvAjYYay2D3h7SJ/y4tw+s3PPCnpG0OOUEtc8nojAtfwIDpATECBD7UrTjPw7Vyzoa0
 CRQtJn8pajkUSOSyJFOcM9P0KpVc8vb595qB8/qUfOwXkdyajX8PzXKmZb48hlec+Qw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=MHCxJR+c; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=MHCxJR+c
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F08654061A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD7BliyJdI+xTwCsGS4KW66mIn2ZX7Vv3oGctT37PSmKi3CcqPTnl6jvbjO0M+MvTqzhV/qG9q6YkMTdtQs8ZJlNI44jH5zokgedKh0oWaWk2zis5mA3dzpaSp8IDAHAF69t6oXtaE7zrrPvHDM0giTd9vfQ0y8Pir8TDGPP94ifh4dTW92OTB2aXlVG4QCvoF93g+maGC8oGzTSiT3bgXLukmQWDUvs7nm9tIlX85BwOgGTrVGk4vCx9JH3i1sb/pA6dIObXT0wKggaqQq6/V8AnVpXUqvKgsu8XDnhX0iRRsH+FjlXZXQ49qQKdd4B8wUnple4DOkTKlp3AwBkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZZUY3qSYgPwIv1WxVz7bEicwU8PlsU7hmNai9rmfRE=;
 b=go9So45XwGmGlRoMrlp+UeHzmYgNOizN6RmrrJj+eNt+zO+Ot3ToWKbHFi2DvI2m/HfUestVa/iXiKx66EyMj/YJ13G1MvcIysKLAh1ZJc39SR2qBjLE00wbxKw+O0Q2o2jX7bWWjuPq7kDyu5nt6UF8x6/96yYR6qpS2n3Mx1+lnjFXsLwjR/rW+33NJvKTE4146ggmaR6u9V2rOgJiM+LT9gI3dALFu3qGdARiMHgmY9SfuIW8HfmEmlRP8BqGtkZgf2woRFjRa6W5oVegON7sdpfMi6f7zVMjj4GR+6U4RMAbygEc3nVePX52/RTgRPn5oo3hUyjZGKA4zXo6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZZUY3qSYgPwIv1WxVz7bEicwU8PlsU7hmNai9rmfRE=;
 b=MHCxJR+cCbxBixTygZfZmKRxBy6sLD+GxOw02pKnpUKlQPnhTYYhplZYlRqG8l3v/8ckvXgdLvVNQXZunaaX+k800waWAwBSGKO5DpUmWN8q8wBIM+2DNOQqWiLx8H7rRDKsQ24//ABeSFf0wBKJZuE6+WaEn6UaxdrEPYmZrIvMzbS+tmbXillrKsf7gYvUpiRM0PAI5p1Fq80OPeSPWazZeIKUSfX9tNfRY7ECYnQq7kXIzjXdYkQqJ85rmcrpDpeVt8+Ao2OtdfjJO8NETfx6lSAfrycNb4mMX1y4QmX7GjUry0ogpMZH5xHvIxRpiCD7qz89KTfwdOzvOOmjTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AMBPR04MB915227.eurprd04.prod.outlook.com (2603:10a6:20b:786::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 14:29:20 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 14:29:20 +0000
Date: Mon, 28 Sep 2026 17:29:17 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 04/10] board: lx2160a: serdes: report unknown SD1 cases
Message-ID: <20260928142917.aabvby64k4e3tfpc@skbuf>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-5-vjardin@free.fr>
 <20260928101330.881662-5-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-5-vjardin@free.fr>
 <20260928101330.881662-5-vjardin@free.fr>
X-ClientProxiedBy: WA1PEPF00005B90.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::627) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AMBPR04MB915227:EE_
X-MS-Office365-Filtering-Correlation-Id: a4509447-c0f4-4b76-f9a3-08df1d6ce260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|10070799003|3023799007|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: pxl/s3R2yh1TzjYObo5125I88olayflitTX1QyUA7/5gm2yCs++2ldMn+EDHPrURo3vJGKVvaxtuyqSbktSw7F1xhvqPQNmgAOsK9qrKLaZ6kzZvmXfCwXGb/Ur6qGGQCY/+1+cYNa4MB8+8DONuLGyccQWpiH6aa57iUXrbEPiuwEeR036CFVh3iMFzSehTjf+2FEiUU+l/RU55ki+3IbHxg86gBS8XbLLeIk9ja29o0BiuNPDUZaf/A7whN0qL4C1Zt/9f+zhaPqsQUtUzGKezPr64+oAlkKcbaGUXdjUZW8NMPg5u89zvzr0aC8Y8lwQ0/vGWguxscty4Gcg8Oij0aA6thMY0cCSzQfjA/0+akMTtKvSL8MLiopAkMgYMtBj3yCgS7g29JZEWWMH0sbbmogHHTo524D7u4Qn0R3AQ+LixRdeh7b9orMtjjn3hbbqU7eMKuZD8h7LmoeDQ1VvqIphZjd6qdHEM8aLcx+UQ+sKR9o06aC0/DuRp3jP2jJit/sCOfdEDuCVV3l9u2gnt9pBd+KBl905m0YPQuJD+ZGSb2qbEqyWJcYyMMk1VSMejLkyVDn0bkFSle06hP8DZH+9JDr1Ihve6zlV+IeX5KYp/BAhWq3laXORb84l2eBx3rJcSYmKZnLf/v19M3THvfIuWUJoIUswZq+o39deQltgXkZpavT6UjmPumULrEGjT+T5GzmBIGUsRcRLmyFIat0qHZTDDdqYtawdgz9xMR0ykVsRkuJ5SSLkJUnO7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(10070799003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tv4iMtO71ZRmqkYkk0rfBFq3uab4Ei0GBSOsJ4GfqN04Vv7yk+CzGeJtj8o9?=
 =?us-ascii?Q?l93XnTZbKejhKsbomG6ZUHVvaOH7dX5arZgecqj4stNnkEXsI7v/CFi3Mfze?=
 =?us-ascii?Q?GYAsuYTkBJbS4gZBmy81opDERbZpWUfH5vrqxi67juaqed6ElwhaauFlhcTr?=
 =?us-ascii?Q?+jmOIPKv+VSbhi7+7vjoPe/TzxtFUdU7I6AVVTR0WXs9iRPVQZNoibmQofQD?=
 =?us-ascii?Q?iHzDqTOs/CDlOqnPCZHGBu4GH9JLV7XMv37GH5UlWSvXv+BsAEyAz1U/en6s?=
 =?us-ascii?Q?4gE4Ti0eSFrDjdoXJZcrAvo2aJEiNUbw7VN2WkZZSivzkqbTEmq1Ux1/zj0m?=
 =?us-ascii?Q?lq/MMfgHkfhBspcy129TAaks7omF74sLxkf9H99xaF6NSvzQs6BLVr+YDrHr?=
 =?us-ascii?Q?H2firZ0KTRPdVbhLvf2yd7UuSZEoF/c/gZLMwqxiEtm9lBRPy6SHBruh3J/v?=
 =?us-ascii?Q?FaBw5GcXLB2GBevGSVO9/QIBoevj6cj92cgMdB0pXSeCtWj6ZThyYjxuTYRq?=
 =?us-ascii?Q?/N4VHr3WpA9FSo5ky1PiZDY9K3bXMAfWQgPYpkd0FH0xcimo1nF+LHtiWI5G?=
 =?us-ascii?Q?5AcIizUimGoynt2e6csz6+FUjyk19En1OBYXn4DIv/QggIdr54MCLdBZ8Bt1?=
 =?us-ascii?Q?iVtTLyi1E+EEoTYczYCAhtTvMEpcRXVLAmFYpXciNn75En1K82CS2cnnMar7?=
 =?us-ascii?Q?q9OCIwTiCZqxi7piiwzM7mxZhS684p/FsrEax1UdZtwdmt9sjNcjzys31h6t?=
 =?us-ascii?Q?3DkqbQ8ow1Sd867DCh4dFwoNFovtpq82yPPV1stZZUcVOpTRj3N+6rvIW3o0?=
 =?us-ascii?Q?ZFr9gU3zaL/gRB3a0663p7T4wBWSrfVGtLpWM6HWYA40p8ksWNVCdMWomurO?=
 =?us-ascii?Q?0y+4OuT73PQuuP18FBdgjkzGz8Shpr2mnZig/jFMITtJJOInPW+UryeSIpXG?=
 =?us-ascii?Q?VZn2TR+vErgpO2nPeS9a2BakjzsdAMnQonVX2PM1Hj3+FN2B7iV8zFI+AACy?=
 =?us-ascii?Q?3T39tOljJ+IbiUaayL61md+AqwQis9GDQjWtDzRUozUXU6rHIWVRT7sHC/Uj?=
 =?us-ascii?Q?TRpMBHk6iJQOletG/VMJRc4qHCmcyXVEF1Np2+wfcZ1wk8x3oP0s8Fvl4ie/?=
 =?us-ascii?Q?KsoS75fAD74DtPP86ePuDfu0HBwWqZKYNC3HvSk4CCEC5gm92akdPLVbgunR?=
 =?us-ascii?Q?ssPSgVfndFif0VxlQ/PPd8CL/b7vMjDYr32NuQw5B5shb5k/7ChqMGR/zji9?=
 =?us-ascii?Q?qG4vmESX8VJ/2yBsFTQuVDpqX9nye5NcO2kuljWAQf+0u9orVIeL/k0A+QJu?=
 =?us-ascii?Q?mdUMH2lSvxEwbmCULRQ4lfzwPRPfWAYYz4kZUvnznqeyRB+h1PUmgY3QCzdA?=
 =?us-ascii?Q?SJTcc2JlkeV41r340qp5cYxRnKCU1Ed63b1ZX7TWlbF4Nzsxks2593XWPLG1?=
 =?us-ascii?Q?zqnkMl/pFkF/jG1pHha8HA2jlq224vY+gRHYP2J9j88fl+p1HnYay9PUQ6vT?=
 =?us-ascii?Q?cTLIAYm0imvs3beC3YqZk33W1iSMbktrymBiYCEiFBrR0To06pbesXTzTP+K?=
 =?us-ascii?Q?cgh6Md3u2HB9yL7bZ1abdlB0YNXAvxLfLdhtAm/zAerrVSWaIrWNmBF0QySj?=
 =?us-ascii?Q?yq6pIHAaWZDzBQDzdG53Negxween2gkNNWPnWOEr6hLCg/A87ZwvZgxKnGzH?=
 =?us-ascii?Q?y1ai9eGcdDzhqUYu0N5MKQZjoiBqlL+wbanrWaIbQ7nGTe2sb6g4TAdahE45?=
 =?us-ascii?Q?msGY5H1A3bYx2k5wac8fcdrbGK24JZM60dn2zqhNBhi04VJ1DZwbX93Wywxg?=
X-MS-Exchange-AntiSpam-MessageData-1: 4PlodCrLYK35QvzoRze3sVNCW3vKE8tzVBY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4509447-c0f4-4b76-f9a3-08df1d6ce260
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 14:29:20.3147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lspqDbsW+HHjIOGtZ5TxUSEwKAf2TDFGsQdUpS/paucjXkkyGG4i3TUz5UomtNbG3VCR7nAfhHbtWT33QvPGTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB915227
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

On Mon, Sep 28, 2026 at 12:13:23PM +0200, Vincent Jardin wrote:
> Check and if unknown display:
>   lx2160a serdes: unknown hwconfig serdes1:split, ignored
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---
> 
> Changes in v4:
> - New patch
> 
>  board/nxp/lx2160a/serdes_split.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
> index 11bec35fd22..a8fbb278b3a 100644
> --- a/board/nxp/lx2160a/serdes_split.c
> +++ b/board/nxp/lx2160a/serdes_split.c
> @@ -443,17 +443,23 @@ static const struct sd1_mode sd1_modes[] = {
>  	},
>  };
>  
> -static const struct sd1_mode *sd1_mode_find(const char *name)
> +static const struct sd1_mode *sd1_mode_findn(const char *name, size_t n)
>  {
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(sd1_modes); i++)
> -		if (!strcmp(sd1_modes[i].name, name))
> +		if (strlen(sd1_modes[i].name) == n &&
> +		    !strncmp(sd1_modes[i].name, name, n))
>  			return &sd1_modes[i];
>  
>  	return NULL;
>  }
>  
> +static const struct sd1_mode *sd1_mode_find(const char *name)
> +{
> +	return sd1_mode_findn(name, strlen(name));
> +}

Hmm, there's a single other caller of sd1_mode_find(), from sd1_enter().
Is it really worth it to implement a shim over sd1_mode_findn()?
I don't think so.

Can you please plan accordingly and modify sd1_mode_find() to take the
function prototype of sd1_mode_find() from the get go?

> +
>  static void sd1_print_pcc(unsigned long base)
>  {
>  	printf("PCCC=%08x PCCD=%08x PCCE=%08x",
> @@ -503,6 +509,26 @@ static int sd1_enter(const struct sd1_mode *mode,
>  	return 0;
>  }
>  
> +static void sd1_report_unknown(void)
> +{
> +	const char *arg, *comma, *eq;
> +	size_t len, n;
> +
> +	arg = hwconfig_arg("serdes1", &len);
> +	while (arg && len) {
> +		comma = memchr(arg, ',', len);
> +		n = comma ? comma - arg : len;
> +		eq = memchr(arg, '=', n);
> +		if (n && !sd1_mode_findn(arg, eq ? eq - arg : n))
> +			printf("lx2160a serdes: unknown hwconfig serdes1:%.*s, ignored\n",
> +			       (int)n, arg);
> +		if (!comma)
> +			break;
> +		len -= n + 1;
> +		arg = comma + 1;

What is the point of this manual hand-rolling of sub-options?

As far as I can read from doc/README.fsl-hwconfig, the serdes1 syntax is
A: 'serdes1:2x100g[;other-options:other-values]', not
B: 'serdes1:suboption=value,suboption2=other_value[;other-options:other-values]'.

To parse syntax A, you don't need any comma or equal detection.
The 'len' provided by hwconfig_arg() should end at the next semicolon
separator already, or at the end of the string. You should be able to
print that directly. Or if not, you haven't explained the need for all
this complexity.

> +	}
> +}
> +
>  /*
>   *   setenv hwconfig serdes1:<mode>
>   *
> @@ -517,6 +543,8 @@ void lx2160a_serdes_apply_hwconfig(void)
>  	const struct sd1_mode *mode = NULL;
>  	int i;
>  
> +	sd1_report_unknown();
> +
>  	for (i = 0; i < ARRAY_SIZE(sd1_modes); i++) {
>  		if (!hwconfig_sub("serdes1", sd1_modes[i].name))
>  			continue;
> -- 
> 2.43.0
>
