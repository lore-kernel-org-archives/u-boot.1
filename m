Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A84BCA5FA7
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D757580E84;
	Mon, 28 Sep 2026 15:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3T6UlXzgv11f; Mon, 28 Sep 2026 15:10:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D27880E4E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790608246;
	b=B4PhPoaayk7G0pW4RuLGNexs5w1xWr+Yqr6tgEh+dfvoYblaWYSrqgYHLvne02tpeXY0
	 yCFWE8QrfLlwxwYGBVwKWPc3Z6fNkaW7QNazIa7wBkkQxuP+E5AY+6Hnxhc59oaQv8BzD
	 mZQ5YvniVfjGwcLrMNOSBtCxnbgQFSfSHqWS7yIIwcwsiKw7MSve6tS90P6+OPE+1zuh1
	 Ed567ztQ6VZ3/ta4aTGZjdLv3WhOLPRCDJJE9voqjwPbtUsgKUN7BJQRUkJYB12uS4vuu
	 NHjmwWEuQ6a9c8PjQTY0t0s80qoaK7Cz4vp/3kJyLwSYVvvI4arbjYw6O5exeDn5RAA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608246;
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
	bh=ZIMwfLnGnMiN/Wc2P78/n25L4/9ikNlmBPwL5p6ZIWM=;
	b=GSqdMW9+et8V2LKFLUqqgYZHsxpFg0+1QDQOcGR5AMQRIWcNPidI/77QJa4Z9ip8rjz0
	 6rEf9fykYTKWaC3hpaGiBrpx1K0rfsL8uLjRrjpCABkrw0AZFlB/lon1NXCPIt6KjwsDg
	 TwBeTnG5Z49GrEAulGWnv0awgbXvUKyWPcQ9M2o//M9K5tsE8/fJKvOBEUH3qtZgGnRm7
	 kvjO4vtua8jdxI0EsphgBP5qDnNI6/z6pNcXnin8Yakt6DmtepWMeawN2/suayS59qcST
	 /i8GAPxqXuaZ2WpreTmtABSSjfpxVAijVKhd0MBFAJlUh7aH77N94qggQctszQUSBcw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608246;
	bh=ZIMwfLnGnMiN/Wc2P78/n25L4/9ikNlmBPwL5p6ZIWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MHOP/KlYsR53Q47WTKcBSGxdD4f94mZgBB9A73n6+b3ClPboHuZzOWBt6m4/UvzqI
	 4tMMjiCIi7m3GstsOq98vzt3L8mKY/BH25mfz0rWqDk6rg0tbmfzbxndIuWt/SIKGV
	 ixi/GG/cTD5W1azVHTHycdQxyvkYwaq7UCci3Kd4U79yDSlIPDxlXeMcOsVUMQqQB2
	 QYWLW2mGhh+qnBYLKmPcoo/gf2lhNyvbvzmJYyWMEwAHjOv8osz/jzgj/uhdo/n5pq
	 ymwLusDAsPenfshZ0kd65NKSq5jJnPkSodr8FA4d8F1HawyCozhO6k5Jhm464JCd4O
	 4WdXpYSQVS/0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D27880E4E;
	Mon, 28 Sep 2026 15:10:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 562A624E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 442D740055
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:10:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dHP90SEq63r for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:10:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5EA2740048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608243;
 b=pJMVp4qXSdg24yf1LGPHCMw+46DYIIfBLpNNJC2vGzgxlzc2X4ni79qPCQfosKAKTR8P
 EL1vfWDP1HOJOqv/ZWTdUPobovS47ejUx8Li3KO9ben1os9GwrWEYuI3NwjfbpCg9v0xb
 YazQOgErTbfW5Zyf6MDOHv24fdXKygj4a9K8lYcXeUTSlFt2fxrPfpIKPHjTDlMqfn8a6
 pfZTiW0/R7FYl8rWHEWgXRLpzpfCU0X7AyA67F5PG14o2AG3nhkY2/TcTw6K/XDAggEnz
 b84h6lFKegyh96ha3nd8+g/WQqTDDYXIx0obUHjI8OYGOh0PS1nWUZPe2q6GX69a1Mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608243;
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
 bh=ZIMwfLnGnMiN/Wc2P78/n25L4/9ikNlmBPwL5p6ZIWM=;
 b=iYIjFW3u0uAaklEi4PgkSDooA21GjmsXg2AOxNQuN5Ib9wONqyosyIzj9QIC7EsBH6Cg
 OYIt04Ir3YnTUh9RInIZrxDmQp/bzQppCxbepQr3qicChh3K05GVUCgN4H+b1bOMDRSXZ
 QCyIgyPIwnnNJsns7CtCM9HeCd+unbRNjXkoMYViDmhFnU7VE2ZSRWYfsqpfhSmEDtfCM
 ckEv+hJI1cWohvoF7XY1WybPIrR5RvH1O9L8SfEf3bZyBvI8WdwIEHP0JFq7KoAT83m/e
 eLUdoYUJWnxOQQF1XUOWaHcfNQpQ2TUPMhpZTLOTKXjSIsx8XSCnmM/gWj3D2zfJxPg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=bLiktCXg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=bLiktCXg
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EA2740048
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgMFIFyIufOUtJmaxZvrb7ejxr27piRVn/wmpWD6PypZQ33RBpUou9sLG8AnTjYxwm7GDaJWhVCesSY9Ie4reTjWSjXDyAAETbItdkKjoL/BHtvG9PwSJE3aFNpL8VT/dQ2kYBep5RfdG0dwEbNaedVvgdgRSt5NP30p/KAyGI4QhYuZ5v1nEr/aAvvuUF76eoaiLjuzwifO2OJQKdY45tEng4BGukeBjn2AEOGQKLAUCi7iJ18osUeXEHA/9oG1ewh7Ba12tMGVqfTG6ADoSI9LoA97MGgOEK9nrxzEf1cEr27D9cLRRc5cdVNpEOr278ZErPvKQrqI1eef3dXcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIMwfLnGnMiN/Wc2P78/n25L4/9ikNlmBPwL5p6ZIWM=;
 b=khl2SLm1PgsRl83SZvuLLjh+Alp3+c/Z/eolds7yOo38NwDqdRYU8KJm9ZvDWhrIh2zCn0xKRUTtaRD2TkDgFPjXCaUGZI+OMV3FFIOh+FyNjnjk6HLUIwmhjQ7RZUy62/Vcq1th03DKZJyi0BUTd1swelr6njhpE4dMuHnTAbwpBwk6JmkleOBvwNX6VBl0EIPsCeRPNM7l97Z9P0q4teBG1Hrff4CA49fT8/MVK8In/Lb4zE4QZ85VaP2yMuJptiHfUsVdo5tA/cfcl0jIJcVJlf+jw56bCsZuKElt1creLSqXbsedFWlNwAMJyFuB8Oq7libgYhY3AQNEk4asyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIMwfLnGnMiN/Wc2P78/n25L4/9ikNlmBPwL5p6ZIWM=;
 b=bLiktCXg+6yjZBDTlV6W68r8f2GLNEXQMuKST+dcalM60DFAbGzPjAcZ2jRHooE/fciqFiZR0gvrGfedPaE0KZ091JKbAaRPaNW2rgDWW7Pxl2/iVusFu1dbfTu7xCpJi+351rEHwDhPo/aP2awIwclUxDesm8GKbtGBa21TxRbPHmNizZYL1hqHRQ+JyYOTdsbeUzm4AwUqYm25TtgNQr2WrsRAHumvb7ZJTdMUbkpS+Z+SrbkzXBb5kcAc2agJX1UvMuViS0HIsVpC5h8naj5xENT68JLx5IwvFIRuM5hM7kQxgLNX2p03muYRsIhhKtE/AH05vuLba+rjbuqPQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11020.eurprd04.prod.outlook.com (2603:10a6:150:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 15:10:35 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:10:35 +0000
Date: Mon, 28 Sep 2026 18:10:32 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 09/10] doc: lx2160a: document the sd1 hwconfig option
Message-ID: <20260928151032.uwtmyj75xics6viz@skbuf>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-10-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-10-vjardin@free.fr>
X-ClientProxiedBy: WA2PEPF000008A1.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::64e) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB11020:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f72b1e-5412-4f20-b880-08df1d72a56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|19092799006|23010399003|10067099003|5023799004|11063799006|3023799007|56012099006|22082099003|18002099003|4143699003|41080700001;
X-Microsoft-Antispam-Message-Info: /y/rAr9TF0M2GOE3nmq6zEO9ty0Z5W+b5EMYppumUuzTm3hrr8Es0FgGaoio8brcfV8+3Mb8Rsm1Egd/8RdHbYkPltxaYruyZaqA2YBOwYdT1o0Ea8cH8rDSdUcU+U8Hf/DX1FgdHlnhkCpeo9gtdsFR0sMVixJeIBORaNxQi76e6wk5OQJTAIOL3AphhKSaeH3y8Z8+8BaHP8ZukWseG1o95XAVjfc9zNJzY0dx0F6uX7Wr+XrL4hLCXKHv0Ekwi5IO62PhSgnAoi6LatumVvfmJPgoZi97UeoXbzHSi4TBIhNnHP5V8cEltGbZ5UiVw9886JgYtjW3qIvfSsirdP0Ux/Cxoty+aDsUrV2102BBFN52AMmZs6GgjLys3WCX8/GVYiddezMxjlYHcvosXpFwrHPZvk7sTefPGvI97D94Lm/mEHzXVGSHgFj+T0Ecdj+7yCjASNT4PqeZXUwLeD9cq4h2E6Ht5akM1BDyjmtKVz0GISp2MbGGm0abhVwKP4lm+5amaV4fRF0hobpGmIMVkG6KfRi2pTE/BsMdrGp3DCIjNcn8HyemK8/g8QqhGeMjPInXuIn+GuaTWNNk77YmArKhDz52M54Ck2dEjXUTrVdcWvly6F644c9hl7jXkmGfje9qq38ZqDsAIULhB+TwX9f0GioELDpsXPFGjgl/gzBEceD+b55cMpgZmttxB2Sp0Lp9j7z4ZwD1YV7tybQ6sUQcYqFyKUlZZjk0wvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(19092799006)(23010399003)(10067099003)(5023799004)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003)(4143699003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jQGzbwRe8Vy6vpdijwmV7R4UKk9cl6fo6FyrtdGQ3QEGr/3+ITYiv7LZ1aRU?=
 =?us-ascii?Q?R5NRTKCnlQEvMp+5q70i8VCyamTygSAfCZ09qJ5VlKj0dRMJurniy0HQZeUo?=
 =?us-ascii?Q?YlaYJIHBn/US2e6Dq1kKtCcNUzQXF7XIU0f4GHIFklIaTz5gutxyx13MkDDg?=
 =?us-ascii?Q?lU+ODbZTKv0DbH9ypEMEp2h5S8g2e/9kd8q5MWN+cvB4ujZI3RcDuFFjkSKp?=
 =?us-ascii?Q?SpS85cG9CNWkSp3Vw19QFpBQ1kU7GnFS4tWtAYIHUfqgBkNtPeBr2ZJwxaR0?=
 =?us-ascii?Q?C+125nIxb3jmnoGtjf+S1JKEOzKTeDyOmvkHMzMHlnmkwnAbfns4IaRoUmkC?=
 =?us-ascii?Q?hORAenaHg7x5JNCCPCX2kubxC0iNZV1ChilzoCEOeplR/BioNW/AflWehQ+A?=
 =?us-ascii?Q?RAcf7YtgqdDvW9RG8TdQeonDyPuwplsZl7rWs8hV4y9fgJJczrCovhl33lvT?=
 =?us-ascii?Q?+rAIhQWYzY0cH8SpflzXU0YQtkBB3kACAWUgUdLE9MMVsQQ/Cu0ES+f3gl4m?=
 =?us-ascii?Q?3DCTa5pRyP0TQat+JaiPHBwl14WOMxGB0Bm0TTAK1lh6XqtmoeL4lLfYH+vy?=
 =?us-ascii?Q?KHJASTMTWT5yHZoyXqag7W2wli73OI9LaRNNkZXBV9XM9Ady/wrRtaIA0jDP?=
 =?us-ascii?Q?9pUUV3L+6XJzaYXREHWoEpc7WRVIjFm9eSTOctnojiNm22XQZYwzZjgxCRBW?=
 =?us-ascii?Q?YiUin2hXZscRBlONplwwBqu18WCQ+PG/UOx6inHYHd5ZML4YJvLHmLg883ea?=
 =?us-ascii?Q?OIc8oWZX2C6QoTbJKuP5PSuQ8HYccVvBGgDVojzhfWuJt+Wj7FWPJx61HGag?=
 =?us-ascii?Q?jh65hMbS9PQdrtl4qTW+23cYERwXjBXvs5CS5LpSov0Yynq3v8KMTmusT2HV?=
 =?us-ascii?Q?TsK/3Pw/qrtOkIPWN6hj8cURaq5cWtf4VPpP173y3OWZipo6ZOM2FwTC64r9?=
 =?us-ascii?Q?W1EpfwNQZyf9VMF5W62yPEfteUVna8DlxhtjxQCvOBG3zlVZ6GQJaFa5RDm3?=
 =?us-ascii?Q?bGM5802+P4cYUpRmYk8d7GGbsfRbY15rVKOsuGn3g5FpTi0MLPTLaccXcit5?=
 =?us-ascii?Q?YtdVI/Z36vFVzzyrk33QWElUpCH2t11AyG7hdD+w7jp6rUvPQKQUmn9SPbhN?=
 =?us-ascii?Q?CprnMovOqIhy8xTr2/W+nbmqmKBYOljrTNqpL91QhmkNfqnC3L5WsSbBPqL3?=
 =?us-ascii?Q?rkzV0fxul1WSNFRs8QscmvMtcPpJflLXu2/VMKcf1mGirv/cVUuUHWsSYG5s?=
 =?us-ascii?Q?LaHNn/UbzWqDgAVIiklSaRwgueQBKMa/PLN5498Z2MNKzU+2TqTz/xGMuyIj?=
 =?us-ascii?Q?2Ca1NeIylUQEORtnDLyaRkl20hSTEWd2BzBMzCXbUyjP27AnRls0K0n+zUf4?=
 =?us-ascii?Q?3dXBBVv7lzwRZdPdhaOP/qA9NxB6eaYimJ2H8WFZXo4Ma1+9dv33DYiktw1V?=
 =?us-ascii?Q?JsqlcHSBAtIEnPuVmr86dbr6tFTNVKZczIS72l9H9C+c5ex/Yghhmu6zYO2b?=
 =?us-ascii?Q?Z5VALQGWbBzxZn4liQgxzdm0LYYr5ZlFFwBPCTKBvkCZab0X0iTqWnPGj+hJ?=
 =?us-ascii?Q?eN4+KidLTFHrTkRVY38UTOa4JxjEAvhw7vmwRU7bJT0ktI9fu/UBmdY1HLAQ?=
 =?us-ascii?Q?OfeHZhLoKxpLJodZWnYzNxmGyKymHWVlyRJnFj6WSasBEIwcc2mSwWOE+4zN?=
 =?us-ascii?Q?Boiq4mW6BkIDncDML+2t+9Y9LR4ohwCFs64eyPK3op952KUXUQRt9XEZP5iw?=
 =?us-ascii?Q?U/yRc9kkZOveIThFMrerxxNQDGWKtc+60/4jUUjiqf2Ifuv5Bm9IUPJSO8mH?=
X-MS-Exchange-AntiSpam-MessageData-1: newVml0GUd7jNtHkxfm5oneyuTX0y9Ojynw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f72b1e-5412-4f20-b880-08df1d72a56e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:10:34.9913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNNN7qXHaRwPMaRwneL+geyqKXERWymzx90y4t16GlQMYYkOdXuPu/y7uF2lckjRGiPCoG/lcenQj5dHtSnkBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11020
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

On Mon, Sep 28, 2026 at 12:13:28PM +0200, Vincent Jardin wrote:
> +	Each mode starts from the one in the 'from' column, which is
> +	entered first when SD1 is not in it yet, and so on down to what
> +	SRDS_PRTCL_S1 built:
> +
> +		mode        from      SRDS_PRTCL_S1   lanes run on
> +		2x100g      -         13              PLLF
> +		100g4x25g   2x100g    13              PLLF
> +		2x40g       2x100g    13              PLLS
> +		40g4x10g    2x40g     13 or 20        PLLS
> +		100g4x10g   2x100g    13              PLLF and PLLS
> +
> +	What each mode makes of the two four-lane ports of protocol 13:
> +
> +		mode        dpmac.2 port   dpmac.1 port
> +		2x100g      100GE          100GE
> +		100g4x25g   100GE          4x 25G: dpmac.3 to dpmac.6
> +		2x40g       40GE           40GE
> +		40g4x10g    40GE           4x XFI: dpmac.3 to dpmac.6
> +		100g4x10g   100GE          4x XFI: dpmac.3 to dpmac.6

How much do you plan to extend this, really?

Do you ever plan to support a mode with multiple 'from' modes?

Like for example, 100g4x25g can come either from 2x100g, or from 100g4x10g.
The sd1_enter() recursion and graph traversal becomes quite a bit more
complicated.

But in principle, there's nothing saying you can transition to one
SerDes protocol just from a single source. In that sense, I think your
choices are rather arbitrary and may not suit everyone, so talking about
multiple sources now seems rather adequate.
