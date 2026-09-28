Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41630CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07746405BB;
	Mon, 28 Sep 2026 14:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCxFd0TaRfMA; Mon, 28 Sep 2026 14:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 620D34063A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790607028;
	b=jM2LUVdychtUto9jS82SmckuS1FuzSCCTuD2xjZtbenMMZgClIDReftxipbf3VZIEQ8e
	 JUJEDeasrmXqSRv1FL+FumrheRf9Y1tgyTAODRds460ashkdnQvb5pphjxdO6sWALDIWr
	 uqSE5iksrovdvaCxpVN2yTmreQJIZCJHRzJz7N+SfvIUYHpwgI1XogkNqZIEwKuUguUH7
	 ExSrQTuYE7+e8IFWWyCaymGIyHnZVA+oRUYcgXAEyTakR55CEAL0Z1ZOAOhaakJzE27Dh
	 GZIgRjgfYd5F6N6jwCEZ5GiMMS9rmeyM4p8yy7XKLlI1YbN36FjIl+Zy3jgGIQJDKCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790607028;
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
	bh=NId/ut4ZaiHlXRRa+4gvTQg4t4mkjdx8Yb7VFWojPN8=;
	b=cb10arRrjz7gXXtRh+z3S+wrPVqq0oFmZXvuXUp4YG1FPX46uVmM/RpyASWj1YdVLT+S
	 +CyI55B9aKTcwUvRUlTo4aWjLzgoYF8PLZGM6z+QpwsFmZARRvmItFDa3NQuHR3mkyvQM
	 FevxxEQGQKAX1dDMZ096+Cpz8Q2MO1FBo8i4Z61abdkPCmbwx2zny3uOS4wKV7F92kxnS
	 u9SmHoPZfLa5UtoVbaY8Fl2MSMVlRSLvx8NUayX1Gysc1vSY6yU1CBtl8QYkOy7BB0HAX
	 lJzmxjEOsjeTMQ6HRWfNqbMleO/6wCNv2C+7iRLlxqTmdvaJqHcP1UwUePRyX8N9OBQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GV0dLi1x;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790607028;
	bh=NId/ut4ZaiHlXRRa+4gvTQg4t4mkjdx8Yb7VFWojPN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFYeAomAWk4Nql0LLjVNkvSCfRI2ceU+gXNJdkmFlpG2HIzNPFGuzG0aqyMA3PeRr
	 GJYZEfcAi2dBBwJAu8GqO8wGyFJwf7OFOVJnFdzU5vdfzqZjOz5+VE2yk+AMSxC5Fq
	 hc/CtUWRojIcL61LoZmZ07sPS2E7rtwvo3elHiasHOx1l/lyBW5CzBIAaZ3MEmyQPr
	 bdh/2POhIEd/BAzF2mabjy+i0aXow/fJQzJSPxyYIWI68KhL4Rc8Ok54yL65V3jrfi
	 2POA2AqepXaOYOnMpvoH4cXfF6X+Y3FyLFem8C87t1KA6tEOr+eRJmM7RI3FHQhnvq
	 b7XpxsIaeS64g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 620D34063A;
	Mon, 28 Sep 2026 14:50:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BA91D32F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC7E4405BB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LaHZuru-fLKK for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:50:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7FF694063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790607025;
 b=ojNg5Y771+1yearb1alnTtL5FJMxDmZnnjP3e0OZQN6Y6IzzlmCpuXQjMJWjNwsZD0BQ
 v2wiSQ9r/IVdGN0u3VLkvDaA3de9LXb2rgJhj3nYEdBewhR7foAamiffmJCgZ06Nxi/Ut
 8vatNhKuAo8OJ//9H4fOgGha1ywmi/kzPDP5UUVO9iJxxkCKV65yq6GxIt4+vUbOkVg5B
 Jf1gNoUEo24z5BHfbOnSsgBQsPEkSUsZ5OaMSIzF0tDZWoPtqpcxLVJUNeaUrTlmfzdZp
 PmiWyEDf8xhbdZGJt7MTfdBvpHhfFIE+4iWtPWZHFoct1EfPE3h0d39jslPrsrGjlvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790607025;
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
 bh=NId/ut4ZaiHlXRRa+4gvTQg4t4mkjdx8Yb7VFWojPN8=;
 b=eKwnV0DK/UJ03el0naO+GuXZN2M0YFk1tw+oGn1OgZuEVFNnL5AxRbdmsNmAUXVCTqBe
 LLhX6F8n6PAIyhXGj4CcaHvcjKzNP3HoQTdkA1OtHC4BQcL8N1VgQXyiiwoyTzpdDzFxg
 g9eE2gAmM0zEaTC5C+jODXPNITu8LS16bxbXRQRW/sHLb5iimMEse1lI4kdpX3dyuHhg5
 pAKoFJt0Sdud1vNtEGGC2ynYrMgSKbJQuXKwni8aALI/LdtDg74OMwcuSGErA9h7ChRNP
 x4OMhlF1B3/gWvwXjwEgeYvzAhPcPDzVGzn81kzaTwmufyddiklRwVBOuOHAQEMSxkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=GV0dLi1x; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=GV0dLi1x
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FF694063A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apWLylx7SLPFM4dpJSIxHYgIlDwjFsve/HypFpqPEL20P5rVmvkLdd2ala2FdoP3wHiZhyYstQhjCHrAces6SK7PZUsRBB0lwMcn6IUw+bEvaTRMiwhoQ+SMt4YDrQgy++bbOiSnlsB6b7DO+stuRFapg63SQdLZF5Q4HJfPndJVx0dosUh2PJ+jOmMQK1RLcnSsqSWcoQVNO2MWigNOnGPclOtLM1DNpGqqM5RRyQ/H5Gt02Fr3uWOGFTih0+vjzmPyyEa5aTT5LgRfCUL1q1A9uVSc2f+pHoYY7OVZMvdzq7ad7GOm8lymVcvkyOtCf755WhFPfr2HnRkMbW/Unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NId/ut4ZaiHlXRRa+4gvTQg4t4mkjdx8Yb7VFWojPN8=;
 b=FHSfB0jR7JRV5CivjoDLgrMRqAxTuuodseLeLrqcRGomrqf3m6WHzC5t/9FeK+6hD1qIh1yjBexoF58hTLCka6oPLr6mNl5lxrX53d4UPeUuWHU1n3h9RW8zPFGQz0A0yNjAzKir+6CVYC4aoyLKCrUxEb6kSm+d/NEae18Mmj8amdkduSTQ+fZXjbJVMOKUB5zPLhrgGV8fpUDBAAySX3Ar0CP4XQLUM36kfZefoMlqlQcZ0Q1uigPaHUczz+pfeZjeNWbHmZiB1MT1BBiUsGtVfy3UNo5Y8eYyye1EoRu8oLCcyVur6DJyjikO5vqJdsD0Z06VZ8NQqTZamrbfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NId/ut4ZaiHlXRRa+4gvTQg4t4mkjdx8Yb7VFWojPN8=;
 b=GV0dLi1xFEm2ii33VAHMFvAU2saf3qdDXYEO8+coXVrHsQIap9kiAZr2enYxy3Uf08az+epyJ5eitzxL2bBDB1mPDY45fE19ykIKCQ9Hboso3LW9Fk/qP32c7dloQVHUWQuJmU+XZeTKU1wdNwjBqBOurIYH0dUDs9n3zMrGUd7s+zTc6gedknJ6oTdGE1rQxREJ8knI05a8WmrHXThxgra0/2QRkTb+hTxXi8xfvtNrpmONk6+jrkO3aoHqFI3i6jaEr8arjMDYZGlrDvwdxmlzYe7XYzPlveS+0h2pMBVniTd2S/k/lFcrUGnyTGbv2uW+GQTiAv3XEFAtJZKV6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 14:50:19 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 14:50:19 +0000
Date: Mon, 28 Sep 2026 17:50:16 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 05/10] board: lx2160a: serdes: no SD1 config once MC
 runs
Message-ID: <20260928145016.45732fnlk5hxzosk@skbuf>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-6-vjardin@free.fr>
 <20260928101330.881662-6-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-6-vjardin@free.fr>
 <20260928101330.881662-6-vjardin@free.fr>
X-ClientProxiedBy: VI5PEPF00000922.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::831) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: fca7b8e3-ba45-420f-9d70-08df1d6fd0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|376014|1800799024|19092799006|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: rbTN7g4S1w3s23O3vLshNuLtppaeC5myG8CNp0hWCijO059yJwWxyXFBptJmB5p/VKsaIKbqTllOzJMU9T5VIMXBz/hiMgm1uxCQT6D3eeI2dvkNSV7ZWZJsmi38MLNj7RdhyRYmr/9ZR+hobLTN+LECUwBFYEu1vEG6CK4B5bf63UOFEh4gcTastPoGowxXz9ZpNWikjJv9yNm2E+JcGhMFhmQsvwzJ69i3irLktkyzCtxgzKo0yiwfTsyiUIWPx8oY9QDdom37H9O+3NYYZUCHKS4VLhydvAKvYnHmI0LYefCarEBGKoxv4ewFMv3vKK3RTL5vgjyB4Yxzx0/N5Ansd0svQ/3x8j0qwHoSt9oU8DlsH4KRPX0mMbkaYIsXr/Kq09Vn6O88zl2iEoisvk21hYtB0X6QeL1eLghd6+uEp7iq/rQrUZSPYII2k8L3UDv/JLLW8ntkMJxv5/xJLnWtgNFscRtyevK8s/4R5i8OvM2wDnc21FjOwB1mAw2PaKx658N/0C6v9OsMdoX4qcFeniMG9QPRYsAJz7P6qLB08Zi1sV1zsZZtRapsqrjkejkAParV6wxsTEs1obi1hsTHnAXwvBwLpA6ljPd77wcK3ynTTwo8QPKZZo2FUQOpp1LYrmPUX7n2tjnO427TkDPxCW1UCIquYBs7WcOKNJFC5qRWKOU7sPieEpN7dICZiK0uYI+TN3DI7SmEq1fmVxO5rIkOJqIkMJ3gn584BgXdXE5zvnwXfxJCU5jf0CdJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(1800799024)(19092799006)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOFsgv3Nrl1XhZPRkzM05hjX5zmpclcQ4dmfef9ER3elBGTqlJgeO1zqmUQR?=
 =?us-ascii?Q?8lzSOyV0kMmGSX9F3+HK6hzbs6/GlolsKT3HMAsaGP5mFDzci8zLDA+viCgW?=
 =?us-ascii?Q?MwB2A9PHXz6NXPFrOybuHK0stDlz9ZPTUffBRV1uejhEvShxzIr/785HQra4?=
 =?us-ascii?Q?VctP+982iDubyowd2uYQeDicadOiat0HyeOlUhQ0vtoaCiSumpMgwJT65138?=
 =?us-ascii?Q?HpCyzB+QHqok9OxNLZx4d3qVJ/vm4EY72t1doyXoR/cILMoZ3XCJm61kwKTN?=
 =?us-ascii?Q?s6HSxWEiiyrY2hnjIPw7C2Y3wsTAxy4jFhPY9QrP9SlHPOALTgYkbcokplrj?=
 =?us-ascii?Q?AOX0HyiT4DpA+9ytL2weuUaNTddDBKXOj1blah0VAdcdK8KZvAN6tjPrmjFT?=
 =?us-ascii?Q?uUeRT7N1OprpoBnmG1R5WBmH/ZqUJcCRI+1l7Z3NfVlWXKXUKbScNivPJRWX?=
 =?us-ascii?Q?esfkOao1ivmLA6SgpQfnABzMKc4ynHAfFRiGLpfhrtdNsp20Db02wnufk+1n?=
 =?us-ascii?Q?dWuzzAmPi/zs3m/RCo0vk5Yzl0Sqbe+8Y2+RG0VdFbqax3SdGgO17qnKXuq3?=
 =?us-ascii?Q?rYfBwEq6F/w+SNy/OZz8x7U/5BPuN9eN7WwfiJQygzHTIm5uAWTXGHcbTP+V?=
 =?us-ascii?Q?wrnFjqwG22YCdvkJP0oiejXu9cM5F2DDv+I43l9NhHBRPS1b2eAB7KdJtNym?=
 =?us-ascii?Q?UYzW0JMo9dNLeqRKDPngZSAnTkoR+9dnB8aI/6FmaQSaEusFNRAeIUZOgGj+?=
 =?us-ascii?Q?526Lezr58GngD5y516RqxDNC2mHCPbOCiW7y5ZrJ6T5JyRCdKAGMfsXzcRmP?=
 =?us-ascii?Q?4xqRPwbsg0Dvr0PkiUcXJ43AHIqINoSz9n90LSU+HF0WtLxbc6K/HTBiWP16?=
 =?us-ascii?Q?YJeknXaIAD3CsYDe22xb0GE0ymg47IyyF+FJCsWXRitxaX7yZI/Ejo+W5NoX?=
 =?us-ascii?Q?kPTbCwL85swgvVqQ5wD4+f2Sq+kbiqMhjm/j+dr4pNv8YLyRi/DG/6qA1jqM?=
 =?us-ascii?Q?PDX4h7mgwhVfSp6/IihCLquIEVLkF36cA+KCrMR4H74dJXsgyUI1P6B6U6KF?=
 =?us-ascii?Q?ohE3jaxcuyod6TUvQ0fHq//O9j/ZIXt0v2iwfaN++W1y2S9NvfnV3ZKxFsL+?=
 =?us-ascii?Q?5e2KMhJ1t1EQWMlqv0wFd5J3yQ/kaVtaOcFjWuLBnSazsHNTKCP653HyGH6T?=
 =?us-ascii?Q?srjnxWVqTupM0kaIRk9m56aFIcxQ9SWafV9qwhwOZRiahNtybqDjDSuyS3W9?=
 =?us-ascii?Q?qLUEum/eM2wuWvwbK3eePZaTtkH0qQ6HVYXLWiTKlm+dFzHJQGArtthQ4ZcA?=
 =?us-ascii?Q?yqAuVRUzdr+37LQQL1JmSp/ijUCCVECymJbqvkRe8y/Fm9vhW6gs9LQND0Ir?=
 =?us-ascii?Q?sXiJBTrZwjOA7UAj/PvAFwYGCSxvpRc/9KGcEcRsnVIlbrVi1vQvVhjd3UwS?=
 =?us-ascii?Q?iq7svt/DYOY/mW1ssjC2psI/FcajsMdx9RComhjY6tnqMygxzU8dhFpzfMo1?=
 =?us-ascii?Q?F7yOvvIDgkELetP8Afdd+pE1erXNACTw2x22Fno0rDf4+rOW6hVHs0+J6a1b?=
 =?us-ascii?Q?nZJfG7isapnVR8A8zEzvLeZhzHgf+E1BIgU7+++LlaYqWS82pTa7fNz/hhBH?=
 =?us-ascii?Q?G7I18COt94JmaHhcvC5yqaaVx4IT8eA1I+gLKwrPtV4sLzvRxhEmLgD3Q5Xl?=
 =?us-ascii?Q?F4LTjBzOr0nD0aWlzbEbXZLwHL5TxgYljWa7gNP6D6xe5mzpixKzrx2qjYOm?=
 =?us-ascii?Q?8X+CctVfIw1PQgs0oFEGxNYDrDnUfOXPW9MajSCqG7avgQWi5D8773GTI8ic?=
X-MS-Exchange-AntiSpam-MessageData-1: t51p9OzwxFkztIE7WDAFyru6gtkkARFUIMY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca7b8e3-ba45-420f-9d70-08df1d6fd0c3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 14:50:19.2228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icMklnCEWqabnWiVziYKh3CUWYXuADesjJ1KAvobau1g30quHVXEYxJQIirbtCJdmNfDrjDx2K49UJIFdjbhaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
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

On Mon, Sep 28, 2026 at 12:13:24PM +0200, Vincent Jardin wrote:
> The MC reads the SD1 lane grouping once, when it boots.
> lx2160a_serdes_apply_hwconfig() has to run before.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
