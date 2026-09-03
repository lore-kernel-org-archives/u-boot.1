Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02A8C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 697D840B1A;
	Thu,  3 Sep 2026 22:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0saxhADYq_iG; Thu,  3 Sep 2026 22:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E03640B79
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788473608;
	b=XETf5dkyv8eCzqzuG0pEGvYAMzKG8LeKp9AmgAEPHFhhpCO6ZFTreWHom/Yd408vjK5j
	 1b6SpL8E6yloChMn9+0t5hq1Sd0M1oN4ZMPbkEFmoeQwpXAHH1zKmv3u9j0x3DNKmkNd+
	 q34LLcmQZeisTiNLlXtzc26LO6laIlCUD43mOt4dIjnUG1LohjQ8zTjsj/4YmSy4q+fum
	 rQ0DYUtcG3tpXBLQ/E2PGL/2JudzfenxTmusbg9OznHoJ60e7G+Bf1bfKLhmto25N4aO5
	 8QuFlLtZVZO0mas3kkgpKKxlMAMzaPGQMWEB9t/NHFPVZumFDmhA+kYHU3BfIGxTWuA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
	b=gnCdlP+VkqXDKVi3QYqiOjWaVtmHqqRwLtQGjNM+6q1dbENgtVTqhRIUwSAffzhIX9Yx
	 Kt3un2UtswQVomKOPz2Mwfh+hui779Sboto4xQkcSxTIHBe+8XhHjtY55cg6S3xMSJUzx
	 r69uNTpgRh0J1ta6x7+uVSAk/YHuoxjHodfCs7fvl8E3lD7FM//QnnazQpTOlncBiNhK9
	 C9Djnmzv2GbZluvGusyx9noWDb5N4l16jHlvE0JI0oA/5a0uU3qnMKNb1VJ2FtE4DkLIP
	 Isu/dWCbi5fPY6HlrnDsXWFaCIzVGVLcoOM1mvvGrOiGXn6jrtF4K7kXQh+cwDVjB8g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473608;
	bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H0luaSpAbjXrVUTEUMZwaCIA7d0cuPdENgl8RRkS+HZmyItAyjcKjQb2ur5KwLpxm
	 rbP6/01NaS+h9jft5p9qUrtYo8wKrPaEkPG4NQi1MwimN4aCdBICRs5Nqvyxz/bWHC
	 iML+YPdl7LkTpN+v8zHWlEUU8EtHQtkiyRSOPujmcammiayzMVID0yOd57M4Jny+qE
	 fCFzgalddcbWFXE1aiXGC9iE4bDX1cnw+uNHUFwm9UB71W8mBdV78ySd/gwr5WTyD7
	 SsB1SKkHCaJwoUfywghzzDzaQhneciq0hmFf8Mv1L1VqeTfLAw64OiGPP11YBZxV8U
	 XYK2epAKxK06g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E03640B79;
	Thu,  3 Sep 2026 22:13:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 646A7422
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5613A40469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6bvlTuRrrYE3 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:22:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0F3C240029
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788470546;
 b=FvFnbZTEaUj4KGyLMeJe+pLBv+MTlEKk93YWAULq8ipC6HvFJOsQyOwR36MtAe1ZdM6n
 5HimXaL18NJzOJ9YnRORuCJMKRZT36I6SDMm8ZhrxlZEAAThS+o4kPasl5Lxm67YClC5X
 hICoITbfuFba08RHM07zrhxpPCi8opIib6B7WUm1fRjrXDFHDjeTo0F+zDmIVvvUIdLmB
 cgvoRhkKEBtCGaSmLDKdNpLh80aOkV760d+C7fus1lwTDObinEYgMUHUy2C+eeploJtmd
 cfQ3cKCWUlFSJqkRU77mCNkGfrX03dweIcnjUj0gRAuA2YpvOJT+aaXSRQwKV4+5c1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788470546;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
 b=QvFHNHjhTp9lP1ztSuW+kaO1i6bZu2znKHzAvceyawFuV5Wm0PR7QuP8FnijOAnTxLMC
 Ei4uKbHQ03eq8cAH4L9gUTz4BWHtNBSGnvb0PvHyw4zlmACAZ0R0ZbgPxg2AwiKY8oljs
 FxUzxGAovyDsYdBySAhAPMYKF6zkWrkgkS4wxojsu2hl5p0mG7LfhrthZMM3x3Qmh8FUk
 vW8Yvr2KclHtCn2rswzburYN2Jfjyjaph0ysz37JkGfKWGpGWfOXd9pKRpJrFFum2r7SX
 gtdnvboyI98K0MdQlhmfk84ji9+PE9tYt/MoLFiXDgi3BejYBXWWO9hQT202kdTy+fg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=PcrqSpiJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=PcrqSpiJ
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F3C240029
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5v4a8RWxp04Q3Mx5J9mDwloONOf+FlpwYgWxPFO+g1rqcRd7qVebTtik5RbjHqHxymYTzusiLgiBJNNcOiYQfBTgSXDN/EotdAgGOFyPlmWL1P3zPRqw9INCz2K1+SUhDHCX0y8l+iw+SM569YMzqNImbqDxklboFsHeOG74xyIxVMI6k+2YBsAYbZmqHMIhn2sv8mh/HnVEUQMsFsEfjTppOWFF/kNLP9L1G9WY2aA/QSbPyKEJP9+2FXnFk/Nuu7W1iLovXy0opOB/Nmd6BP5BbmGNQ3uWhj/1EitROb1eSYQB4V55amSkutpmrlHL6REqANhTox3eBBrO5RYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
 b=U4+Red5ydxqmhAGiiWF8FaJUgg5XoBhgGXkBgsAPAk+bDywzh8pq7iGeKJJvHYN9fvJPA2ZNwWpFbJxiwvKwZoV2SsqOSSq7CjPOVuagILdsz8cX0M8CHq6fv1bHYzGSpfeNB71fpBoJsTtIDZ/LMPFUD3J5GehfGI7cPx8v4Z6s8kViWj+A1y6NwNADyz5JHccjCTyClffOmftb/HB7HZxD/ev3nQZ1Ie31hIwArhzIgAhfZQPxZoKgnWDmssU08rsv3M3NkTMgTHTOBOguY5DPgc678XZP/QtCqxsLEQF6NSOkyRdxmOpOeyaHcS6QGm8tpI3xBs8EWjNHyUEx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
 b=PcrqSpiJSfmXjYTAN4FT7wtcS36l8rxw4IEmVwA6eomat3l76O+wwtkyI+pZF8OwTkCqQZE2bsBeybUjcC2kFuCmqddvl5Xc9DxhjOYiAdKo57/5cEwwGeOuqZvbtjEXhpCnC2RoFjXnRAcn/bWYz+MENpiNRfHcV3ZyKeXc5uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 21:22:19 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 21:22:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/4] cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
Date: Thu,  3 Sep 2026 23:22:12 +0200
Message-ID: <20260903212215.2331118-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903212215.2331118-1-ravi@prevas.dk>
References: <20260903212215.2331118-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0009.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: bc901b0c-bd1c-480a-c4f1-08df0a016f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|11063799006|5023799004|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: OV3T6faUCTbRF8tju0NR3HZOC723rzSDmXUhrC7VKg4qGnk7QKLzBJ8JMOC2yfF+0tJQGaa1riF9PMKxsZLtfI/wbrcPjpEnHJGA+ksoqAMWvlRJUuoO0zYaqIhtdBXRxCzLZyU3S+EYeG/PhIuGNyOfSdoZeaOCACcBFdwyRxtv8neN4nSmJTeuTxclytIbugQDPvMxvf+MRYR7DaR3e8cyRSy5VN49CPksg19xSMklXt1tmF9haGAdVE5laQHxdcVEERs8UdMLTVJt3BJ3VEI5ARh0ZCGpxWzw7UlxazlvpSD6+WvLnCcWmBV1+wN0KEbB8iRHri6sjsehrrGhToLTw/uQxmpA86aVkkGjJZHNCm5cAJ/CcSba2esODXV2IJoRZKUsED2hGTHc7tidL2W8zSkXMWfZKhCvYwpm3H4Ho2A3qkrjUn2nsNzADSynTUlZFqpvljmr1S5/HMKJj0w6oww7gm00IrSM56WSk/TDiLCKNxoJzTLCSUPQrc12zmhHfcGsCJku9ErAbACfJk62ckgCddxZtNpvL9FG5u8gaVFjrmLh6DfjRBehVb2YADogA9tFM+M/gSxtFZQem5AixOuIfS0678H3AgioLWmUHIfOsfTi65WPkQ5tGy4zMprGaAKYMkEEJBVMDtXtUaYEmuesRSL7h00KWUIVnBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(5023799004)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rs7VhnQu1CwK7lIT1H1I0LDwYAvak8sGnFMJxJO7owpaiGtuxKObu+KHNOIm?=
 =?us-ascii?Q?hWGBWIKUX0jXPE4sADdV+oJKL75Sn6M7nBIGFRxvyTSPtqfonqKwmJJCrjJ6?=
 =?us-ascii?Q?LVkQUrWn94wujSNXuBu3z7gJeufv/UHJr/x5svu1fLXM0AGiUG6b1uq9bbdt?=
 =?us-ascii?Q?DF7BYZJjd2tbsxDRMXkpjQU0lM4mhNvd5IN1YNDNxQLsn9O1Vd3synEvCoxd?=
 =?us-ascii?Q?Jq3UVjkqYHv7hKQzfSd7PsHerg32QLYUfsxGod/cFs91l0NhemkBikTIZ0tG?=
 =?us-ascii?Q?AJZhEwuEVZbJsQ8/Esca2RFbPLNuNQ1TteaG5l/zjnfnUQiaJf9h3NMg9wcf?=
 =?us-ascii?Q?fnciKy0DsQtRuRbrKId1QgI1V2jYTuY0LbzaPQgggjW44XsDLREQryhtp0PW?=
 =?us-ascii?Q?NLNhQwaUjG2uXhGNrspBFQ5uOI/9uILrAoZ60acxZz6LRk1WJiyjWtRWyww/?=
 =?us-ascii?Q?7oMfDf/UQ9yPuevnenc03iWCLREeADAF6Sec7DBjhRwszbqQEIdGyMDq+Ux9?=
 =?us-ascii?Q?wTXDvmadLb4vwV0+Gy4EsFc/bA0blYQwjstK34nJg8JLGNekPeTPqman6Ahs?=
 =?us-ascii?Q?oJBRYP9YQ6dcnHAnlEfbQa0HRa+B1TtbU9RyVkrF2E9hWaQSTYuWNoy6kpqv?=
 =?us-ascii?Q?yZiFyxJzWBxNAa0avABHo2tqY4Izp75cLMgLvogNBt3mnbNdXh2zwXo9gx04?=
 =?us-ascii?Q?2ktIMOJTIQQxoqbQib3soqdaMdVr5VFpguLWFvdIfnlpXldaVMFpnPmB9afZ?=
 =?us-ascii?Q?wx71VsAgBOVwH7LnqZnVuM1i473OXICbSwk8GkVP0xfEcsRTalidSgQuq3d1?=
 =?us-ascii?Q?ZnwrFALHRHtlZd0MeHvBye9IwlwWnFgoQyQd5YMhRAREBjKwAIhLdGHTgADM?=
 =?us-ascii?Q?8bT8U9RKFiCvPBmxZ7F0h2NbhIOhMYu4fL7TJp41HdruWfM5n2QsKPlueiO9?=
 =?us-ascii?Q?hOYlg5lnrknlDQCrGCAXqtE0kb9nGsKW8uxaNH21rVXxMLJK0kSxwIrpSeSQ?=
 =?us-ascii?Q?3hfvRUTjRSJDz3ST3hl2Na2JCitCppFuOMK6rg63t/MOWTJf8vy3BIGpUnKy?=
 =?us-ascii?Q?fn47QWTYTk99ZJzBBZ2eutUqpArZfSaKmqSSA8dXrsFnWYl0P22bC/MF1C7A?=
 =?us-ascii?Q?jJKdyKW4yP9QqlAZUrqbTEXbA5Sf8wL/q/nlNaOlSzzOZ3GIku+APb5Lgg56?=
 =?us-ascii?Q?aU942aSCrybD424tPfhdEc4WdRqbd0MmoPKUjXWJaSsNNhu9NF2Qk9krurmQ?=
 =?us-ascii?Q?pr7se8H2sETFvy+Fh2CGjN0lDBSter6OvJluq2l2urfQjkLbIJbZ0EvK6Rl5?=
 =?us-ascii?Q?ZtM40lhZgvXMcFz+J67NRFQhSkTxuPPJCPWLsag2bnPdh4f+u9vwV1SEZqq7?=
 =?us-ascii?Q?5jmKEW63Qo85DDn/illIYx+lICSVmsgeoC9eWCyRTQ2M70IvReM+UjCX1r3o?=
 =?us-ascii?Q?SjyDRWGLzax5xbJTOh+xQWMIfUV0/x5KPg/8UKEu0xhUJ+IaMe6YZgiLpHFT?=
 =?us-ascii?Q?xg9/CAZhNXRT6/Mo4rI9uPWNPqqPIuYaXWywYfcFQFYUD4y1TZ/XXWdOY8+n?=
 =?us-ascii?Q?rJKzyWPiC5coiyXNz03+OmUJcDF27WYsk2h3VrOuiX0P2vMScDuTwYA+DQYx?=
 =?us-ascii?Q?ZAMs1ugFGhzZOML92dAd4wcivgcVptuoj0Nk5kBTMqd/v9xpcQAjucRh6tZW?=
 =?us-ascii?Q?h6zUYzLjlCATtijS5ixWgo0AstIfxeY+IUE5CAX24lGrvHEbkdJihLPUTjwv?=
 =?us-ascii?Q?KrOmuauXpJ8s5ldNeDsTcxK/JPa87aE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bc901b0c-bd1c-480a-c4f1-08df0a016f4f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:22:18.9629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9bbVamGCZtt0xxnWpwlP76zomk/eQqiRgVNea4ecVuYmBSkqWQADov9n9UwCep4iVkuWPzpMz7ZC5BHjabLpOmYMbhTng2ITduc4OAAMTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8445
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:19 +0000
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

Do not translate both OUT_OF_MEMORY and STORAGE_NO_SPACE to -ENOSPC;
we have -ENOMEM which is more fitting for the former. OTOH, a new
addition to op-tee returns TEE_ERROR_SHORT_BUFFER in case the provided
buffer is too small to hold the result, so also use -ENOSPC for that.

Similarly, -ENOENT is a better match for ITEM_NOT_FOUND than "some IO
went wrong".

None of the callers currently care about the actual error code, so
this makes no functional change, but we will add special handling of
the -ENOSPC in a later patch.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/optee_rpmb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index b155278ee2a..9a3274c4332 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -52,10 +52,12 @@ static int invoke_func(u32 func, ulong num_param, struct tee_param *param)
 	case TEE_SUCCESS:
 		return 0;
 	case TEE_ERROR_OUT_OF_MEMORY:
+		return -ENOMEM;
 	case TEE_ERROR_STORAGE_NO_SPACE:
+	case TEE_ERROR_SHORT_BUFFER:
 		return -ENOSPC;
 	case TEE_ERROR_ITEM_NOT_FOUND:
-		return -EIO;
+		return -ENOENT;
 	case TEE_ERROR_TARGET_DEAD:
 		/*
 		 * The TA has paniced, close the session to reload the TA
-- 
2.55.0

