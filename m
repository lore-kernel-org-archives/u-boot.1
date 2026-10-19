Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A388CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EB1580C6F;
	Mon, 19 Oct 2026 11:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpAJ-mdipK1K; Mon, 19 Oct 2026 11:16:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7703E80E3D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792408590;
	b=jMpxDtaNum57QfB2ZPHH18mdxSSvuobCxlHXpEW76lfvGYaZTmQknCW8xer0ccFW/+wJ
	 m2H+cmpVUh/1P4/M/xY9Qh5fBLPbJAvne/xV6gVNjc9QB9yyJ+VghZcKlLHcq32jBhLuj
	 qLGX/G5lwouQI8UdwapRn2T3E9ZK/+d9AVSDeL8cBn+YauzXPvxxvqmx3MFzcLUVet3R0
	 9qvdT7xXZQHOFqgVr+eTCnXsjophEGNsBSPJT9i0RwZmqF9By64NVcuLRZ4jYo45GpNUm
	 3HHRafFTEPnm771WBZzq4ivaaVla1ucjo5maxWEYwNcbo4C8tfRxaBgcwnx55h0rTJw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792408590;
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
	bh=/+Vy9QcHyArTy1/WSDmcY+8eEn1+2/cPWorUzFO7qBg=;
	b=XlRicKUAx8JmQDzAfXJBLzRUjJ797eMrbZIV64tYJy627FFVpEM94r4RVq04zVkwKaQv
	 QuwZTki7M1qDck4SimEm0ucIzxLXzHcqjVz6m8GVwclWtiayiH5QvZg3tSv4SxyKe81sz
	 66UGZ79Nvf077UH7QBhrCgetwmfmSm9gqTodM3Oo6Ua4EnG+OFL/Et3HtQDE0CpkGrLRx
	 FZaGmybP94uwN5yjisWumFWWiKLV3cpU0KKD/5m7ByIcVM8IDGXLOfWF0v+g4hZ54IzKQ
	 gg7DpScNzqv4ct/RzQJ8boCDpLrIS4fhchj1tG1qXNM0QKGNXKCPAVpilZuRXU7gPFQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792408590;
	bh=/+Vy9QcHyArTy1/WSDmcY+8eEn1+2/cPWorUzFO7qBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YhGoJWtKEAvS19vHdekhUF/ltOQhBaHM2xP1d5PKptazFUbjjYD9C58Ys8IFs6dxp
	 lKYTlUUvtBvkNqI5qqrBK34esf7UbFPk2XPIfqX5K77hP4N8PBhgjWelmuLRbCgBU8
	 7sRXWUgn5Q1xJqyMarlmO9Qf3lSFRhCYXy5SJ1s5QW0cHsOYabuW/iqN1bqSIYsPUh
	 F9UeqqLXDPVWorA+pHW3Vcc3jnXbiTt1LJeBfkP8f0MF7DODkaOiUDzXqfYr9tA+Uy
	 Y1hvUnP48u6JcYBTwr6EYEn1qtuFHztsICiGAWGT3tBOPftMZ0xipoe4cdDp/zaguH
	 rF0dvSAL7E0cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7703E80E3D;
	Mon, 19 Oct 2026 11:16:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 19F00263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3D9F60603
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5WCIWiMcX5E8 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2052760600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408588;
 b=DzkYIZZm/k+4x/sk8i+/AgWe65eXWwUMo0eob98/QS8p4YVbvL8FR4/sVFSiG2Kfoek+
 H84h4mj614ndQiwShZUEE8axL2Os3LEbG4t3fps8/Np7yelxjptX570K/azYSCucR9Qoz
 ZGRyH++qc97NHNqDSkKWGdxwy0QpjLERmOV08+aAaQ8hNLMhxIbHwGQT26X877+d7j/Bz
 R9MBkG8zRvbmqDGsro+MR4J+4i2lLvYijhIPICQhEoVY6RFAXZyHR7ihhrrI1XjpA27MM
 pE+sxOcCSfr7QfuNy+ocwj/su/VLzfO+GcEwwQv339dpaSmneYkosP31fZMq/iyR9Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792408588;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=/+Vy9QcHyArTy1/WSDmcY+8eEn1+2/cPWorUzFO7qBg=;
 b=MTmMKwBdU/yuokh2ay6wzyvuxlFoduexk4nS8qaDRPokt67FqT0s1ZYXfPaUYu8T4WoD
 qiy2lyGmXiKvH0kuYvxLJkFIv7hCRBtMOzjhJV2Byea8H/mTxjlaVfCGjDqO+DVhOtdcw
 oGiLlxYrB80fBJygxy7hXy/lhbS+7nK53DQQWHNOWmRq47Vs8AabAa3z6rDfRcSnsjuuo
 IxYef2qLqYtK3jVR8MgrC/q/dzBKcRVZgxTtqxACcaFqtxSeZDO3XKGCxiJ8dfWV2fZ/D
 Kqv9TQC9okt7s+3StTOzJzA38jipM8OjzOYK20HdbhQ1FsQdsYSzRu11Yj5m9P1ad+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=Ki9RknIa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=Ki9RknIa
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2052760600
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMbe+E9esJHaDHdj7xs5nHq40DLw7vfJm+SqYDSDfoyR+QmittqUA6a5akeJsaBOV4eSxCN9nEPhtr328j5Q65kF9QQdvDsOSZvr3VWwtfppAPJkuHtT6zzuPHEFYbNWCIHQmVFp5V8Vl+42A0OIXioZ0GQmkFl/diw/A631ZfdXsNFHjrVQSHcLiq/sDGLRwmwCK1eaKnZGP4FcIHZgsUkkOj0WiEC0F/uhp/k3hw520rY5rzOSFihGt9SutX0OR6jeQbf74KYdZxb+iTMCo9o3cmPP2InsRCw9Yg0qu9wn8Nnca+U/EybQU+Ngf2B5WzBU3EbeUSPQKm1TsM/xLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+Vy9QcHyArTy1/WSDmcY+8eEn1+2/cPWorUzFO7qBg=;
 b=EiUz+g55WsenJhaDLEYkPavKSB0cHAO0TlrhdDVALZQ7lv3dGNh7wlkQx9Hy7TLukv5wVDfxfR5bth/7/+jjrCPJ4/UpdhjzAXy/ARrluVp42UZxAm3OKF42sCAuck48A82yhcoUiZBGHtZznEto3ZovZUx9mtnzpAy2Lhoqsq87LEJvijXJ4iH9Q3MTtI28aGdAixcKthrDqC3UQjPHoj065iLVBMbeCjfQ1qPGjx+ZhjmhjhoL/3lmIguwgXZpp45QFQH/DTn7Qr1K7Ppo2upCU4oIoqV2jVomJGXYHSJ/130xq2oUAUGV3rnFVMyLmReh2HVcl/do2lGFyF/KEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+Vy9QcHyArTy1/WSDmcY+8eEn1+2/cPWorUzFO7qBg=;
 b=Ki9RknIalQuegMyQ3z3ljVc8ZamKD4I2b9uOoDS04xMhN0/FoeD+umCfZqwdNHRrijD1aRiO4fpkn4LrLVTYg+buWbYdkGmTkyTHl+f0IBuWUlK4JiG+E1wiwsubSgg+PGg9zJT9eNilTppzGecZ1ovVAIqn3bLr9xPkjNRxm56x5zeQ5MTZO1BO5XwkFchn8Y+W5unVv4XCZSDaPkKfHbYiFXNNVyifF/62shR/x7J0QdGe5XUFOsAF8D8V6iGLd/JrH/KacCmjNXUaoJH1A4IN1KtpfzmCMLTmftgmulYQ/dK3uaBrEcrsTqWXUXPL8XH23Gfh2QEM4+W53HtNbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PAXPR04MB8352.eurprd04.prod.outlook.com (2603:10a6:102:1cd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:16:20 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:16:20 +0000
Date: Mon, 19 Oct 2026 14:16:16 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, 
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v7 11/13] board: lx2160a: serdes: add serdes1:100g4x10g
Message-ID: <a3colfxxqekqdiylccutuspxn63tl42gsdlktmooz7rw4t36yr@2ojhh3q323dy>
References: <20261008224228.512353-1-vjardin@free.fr>
 <20261008224228.512353-1-vjardin@free.fr>
 <20261008224228.512353-12-vjardin@free.fr>
 <20261008224228.512353-12-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008224228.512353-12-vjardin@free.fr>
 <20261008224228.512353-12-vjardin@free.fr>
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PAXPR04MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5b0da9-6e8a-4f98-fefd-08df2dd2669d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|1800799024|376014|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: LlVAv27y4j5/NqN25t/klUvE4XbenKcWfEjzGFqtWBq7XxMYN9ETk4e4ZfkfML1RQQWsIh5rRM4tGFYOiRqPh79T3C73DQb7lMGV1ia7iSNi20fwP+FrCwMMTckmgJXxHJ5/3YHIMyBWXvi5H/mHJOwJfk9rfAOhG5F0h5BPp3IY97KoFvOSmvbNlHwGjLQHkvmWaa3d4a+OlzOGEPqQRE5g2okQ2zXsZL2dEiw7K1f6qp7mn7sIpLk8r8qpqC6BukJ7yZbRGedg7nATasFktSFLG+LyFvfpeAY8Lz8SUlIb+ACzEmvbgMpf48qpKD7nId/VISIlVkvaFGCLOABDc/mDL4+wQd1oaGdnwTPoiRIZaUXd4pkZpgD4xV0c7H7lck2D+yNMWwK6cVVNxN/AVA96hxAD5dBxirLWPDM6NgDrV9kIi3T6jK0o5rSt1TIr5VZ1159hXDvYC7FDLuL2qDltbhgGyscALovRW7pD7kejPx96sjZWs3fsdzbUJyxj17i2YryQKgam45SwHzfxXefPzmNykiX2nAzkKQLZN9+p6var+VKTsBLZEZQuyaZj9jotWIk61Gda6Vtj/snzWG9laKH8qE/AxeiDRbCjwbFaBjInnmltypDy2xHM7M143wgmGpvAyIciHJmpAlv3exMHxLna1yvRmDky9pUS7n8/NJIHE5eEPa7TAQAKChJA69aOzhhQQyNd8fUDDvzske/BrQqwwbR3qVUZVHaeNpdiZIN7YtBxiOUmIzPmbTqL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KWSTuKkIpm7/SlpN1aWhZ1CxBoJ3LN94L8LljvIpzc1FR2GhBMwkQaIJyKrX?=
 =?us-ascii?Q?SvOaoqjpgt3WyatsfNUztxjgevV7EhWBZY8n77pDR41p9uOb1tW3dVSJdT3Y?=
 =?us-ascii?Q?3aeKaxKrwfGi6H2KRxXTX0pcp/2lHnZhf2rt7oFOUB9YaTXGnm90ryf4svvS?=
 =?us-ascii?Q?GEJNjlrkJI5x0rrkfnNbJQjPDPPCldD75vwwTEdahattIGWQyPc6qxtBcQBW?=
 =?us-ascii?Q?LfZrUB7Zuee8KcSJiK2FVuGAMoXgQRc01C8w+RUMY3vNCIJ2LxTvwAB5bxUk?=
 =?us-ascii?Q?5J3FCzkxfvmx2gJvPnwvJ7X7ZSP7F/a6mSeNMAS++oaXnZjYQ1PSK+otPx7s?=
 =?us-ascii?Q?GeeONFqZkpmnWuD6JtyuxT/x8FB+uO8GwOrd6qqYjMQjqtqdMqjMuUda49qJ?=
 =?us-ascii?Q?uV/XEi4VJcNJVY4le3WKndZ14KMm46G5fn0gm4l6IgY4aLyxvZ5vYnShX3T9?=
 =?us-ascii?Q?DUTR1MPFpkQeksW1Au+4VVcPc6Ab1j+MSchwJbrirzhHpfKYOzvItiOjRRQ7?=
 =?us-ascii?Q?aLlYk2Q6Cplw17AWcx56kkRBE2mPRVj5ll2badhe6rauFMn4dgC5SlCcbJbx?=
 =?us-ascii?Q?4ydcCbbrwwCAYd4PDpbUQ7jjiWTRcRM7jvlMBhcj5jSDxxC3kTX0k2Lr3M5H?=
 =?us-ascii?Q?tUQB4fmAStIscpY0FJGRQVQDPuA5H/JnJaJBmV3F/yOlkhNkqXAdaAPCuUwO?=
 =?us-ascii?Q?TpZfU2i6+18ElSf7D+sz+kySqYzTOGQaO3/wAVb7QsvwS1zNgfsLUDWCFk/O?=
 =?us-ascii?Q?W1Einw/CZTHxsIOzrUwrs8BpXyFXonB41dNTAQ4/1OmUR0JvWAZxTo07zaBm?=
 =?us-ascii?Q?ILs+CpjUYleLEVxC2AFn2wH/y38S7iHMaLOveiv8T8Ksu/Ugoohc7UA7bmfh?=
 =?us-ascii?Q?JYW3YAmcyeXX6EmFpJcQ4FWhB634BHQgmNXl/3MxcWgOfL8VWGTwVRv3GcU5?=
 =?us-ascii?Q?gHkBZVqxlkddsvZ4LupyLBwobC1/+iuN2RVcTRKY4dss6z1G+u9DToKlx6rw?=
 =?us-ascii?Q?YdStntFDaZGYF41wcMQLXbsa9fukrHIWkTqB8r2IXo2gjK0NhcctxD3NCHPA?=
 =?us-ascii?Q?buf0nx3T8Yf3SUexOlI0v9uO/Uc9kDX3yeWI6c8r/TSaeLDHRnJhMaPgWu6K?=
 =?us-ascii?Q?cLnnqMqwHPNH+nilD25trqEZJZLVVt+KKkwa6fyqdFT5TzRhZmDTVixHNMma?=
 =?us-ascii?Q?wp0V6kaWjh9Pbk2xuRx1B4N+JLXzvcI8gsFgZ0ijPdBcOMyzcZIGkZ2jV3m3?=
 =?us-ascii?Q?Wk3L5kBttzX021zx4SqYygBhTwt5VlGj1fJY1tb9g2COFohLb5N1xjukRjsG?=
 =?us-ascii?Q?9NFsRv/UvjCqnZVf5Gzr5inwUWuV7lGW0m4i4g4XU0Rgem2GdpHdQjn3oCxj?=
 =?us-ascii?Q?QaaJy8m1HaEPdF7hQuJHtcQUZmFy7HTYeRv0BXjFDM33phgSTETb1veMlBcx?=
 =?us-ascii?Q?/2PZG/Wk1PjlwZGkHYVfKxkBKkjMB/1CZqVOlp24cuA6PcOQk+BjdtmgYnON?=
 =?us-ascii?Q?7V22FLaDLfCgyPc4A9yd63EokhAGtyv+1yioip1+NDfrHQb5a0kWqSYCjSGd?=
 =?us-ascii?Q?7QWYlTSg5TuChbKyuHPNBxqGae9zrET6Bp4i8/VmTfUuixUGiWJlGxtEju+e?=
 =?us-ascii?Q?A6eYWWrgqzhVs+k0W5YSxkSN3uSzZ6uGiemG6f6KNXI2IKVmESGA9l0ko10I?=
 =?us-ascii?Q?UHr5LM4Q2G1qLw7uhrk919DvV4Ws6AQSCweGhsTWZYqwxtWGw+vYASveWzqG?=
 =?us-ascii?Q?3n3KMRhulQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5b0da9-6e8a-4f98-fefd-08df2dd2669d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:16:19.9626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sgu3oMNtBVdCgZ6rYw2mgLTisDw+wB+s5SvrrBr4ofhNL+EvmhWxqlOxnQyfeHncaiGYIi74hJF1FUjep6U3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8352
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

On Fri, Oct 09, 2026 at 12:42:24AM +0200, Vincent Jardin wrote:
> Add the SD1 mode that keeps dpmac.2 as 100GE on LNA-LND and makes
> LNE-LNH four XFI ports, dpmac.3-6.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
