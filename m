Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C8606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NsugigUc;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=nBwNdGBE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADA8840683;
	Sat, 31 Oct 2026 21:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTids0Zq9LMJ; Sat, 31 Oct 2026 21:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9652E40640
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793483709;
	b=TPIdjBCsfMguki7muxZaUFFfUDThkbozq/uKL2xruXivoNQ+x9p1+p8DVmII9Pg2oKmr
	 0uGq53ysLTsGvncL3Bppf6ME3lgtqh9hnrqUYDa52nX3zbCtx8JwsEd2KZG80Z/WYr7rm
	 PvXsp2ImoWauUVZr57OawCIsjOwR1VyRECiXkmDfGej+8xXyAUvo3fL07GcxaE3HTxVmg
	 Tpxf0Z+A29rp0TeqI7XBrvNBoY8CzPpEWBCYJlrvo140ev5ISVq+w+vNALzaxR1SbSLox
	 ZUC8xwOLWhZjlJnXBTri3zcQNpFNAeFRvsuDPpEZPg7oQBBpF5j3kKak4ai2LfuPyWA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793483709;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=/E/OdwVWTwqy5IcbB0jbYbeWKK9oXp/Q/y/87hpebek=;
	b=NHx/BtLvOSRGgfo8+m47rm5hAc8q2HR7Y1d3OiD3rVTGziPJbe+QEGiDS1EmpNwiFKwO
	 9HbPkSGvFLe8I2zqEhq4XcOjh3OoKXdH/TNKQ0ctpxB/CSHJfkbOhy3opIr2rV6WfYf0O
	 5L2HQZR21HCi++HxZ0AEWBHnnMNv0JFvkLJWwYF1CvzqTmw1gpcKU6i1FzOWFi4llH/uG
	 CYq15JffNjo0u0AR5vPDPggKlepfLi868glyHUE53exwbnzrp4xXAVdmyVWabr+qXIQht
	 y33Y3BZr2uGPp6u0iuJGsGroqX1AUMBIwCXIbETW3r5HWk5cCr71i+rjiF3cRo6/TRw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=nBwNdGBE;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793483709;
	bh=/E/OdwVWTwqy5IcbB0jbYbeWKK9oXp/Q/y/87hpebek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NsugigUcj8FWvqAwCuBt3sBDtfT6uRWZ1TbZaUSqjJjod58cTjCPe9B1tsNzGCZsJ
	 O3pRktFJ+6YQ0BJ9FTZirfjtRyKppAuR6lchlLnbeLM/WDbtBLxkC35qvPraafUF55
	 hv3pUq/D8zAXXp4zw6BwXw8URjEqzm+CFeB0/yqDi+gRVrzg6a4OFCvw3U5so1Zjvn
	 myPbzujbj8NjUszbc7lzxu3zrlaDrCeYFihO6qdr6fCJBOyG2iHYGKV9p86+8GM5QO
	 xsDD2U3tht5zqo26UYipOUa7IYD/cB+pFOmcMzmLGrnwIE9iCAgaV9IZ6CDd0hJl7F
	 oFlGtvoiAll/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9652E40640;
	Sat, 31 Oct 2026 21:55:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB9364E0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD6074059C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_Iv4X0ZPzqS for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 21:55:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A4474055F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793483707;
 b=crQUqv86UVtCW3ofirBmB+bcbXFox6HMcgJT8LmeMK5MbVYaxX4SQIkqaEUmPClArBAg
 a1bqQ18jmxaXmU8rBDFdl4VeFUG1/gjzQFF1vkMv3bufhsR9Sh1QE1Pq9I5CKOn2t91qf
 a0UhXiQscLV0wuRwi9Kwa5bewDpPcglZrNrw+1vd+r1njVpk7XZtSp8o8gzzqPJ/BBUl9
 enaXu7mQ57HbLb+K73kzcGYAgKUkzkv4BWS2eJ1BXC8l27IOzXznTa/xjkJi6Xmp7GEjt
 OwkyAeGqWM3tqA9sh36TLSmT0Ak3w0IhAA20qdQ8mKBpcJIOSEq1MJ6LA6WBCpObBtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793483707;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=/E/OdwVWTwqy5IcbB0jbYbeWKK9oXp/Q/y/87hpebek=;
 b=gKoHfZRvmxeavjzIpM/qlfwLWTsIh3ak0H68gMLN4FD5whMApgM1yV6D1M+I9GnsxFK7
 TdkbZMAZLPwRqkBpVRW73c3x/d75cEQmnl5iE564YxkNS+7EUr5bqtC2hUf0oEcDQYdei
 Ec7TMattsG0nqgX86olj+MVn4Z60OaFApJ2MSe5ZQTWBc10R1apsYHTv7vrJUnWAHhzF5
 2ZAEdayOSIfc2/OVlxLIgx4F0OcFWWRZnFbzLDoMW659QdhAJRFb3MpqfD2AgGCQhXnU+
 WwHJb23ULvatEe834KWqDMH++KasVA+9xzlWKCP/KsGuWcuZWClhSOOX5mU711c3G6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=nBwNdGBE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=nBwNdGBE
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A4474055F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0WsjkMh6ugLfXqkVJmxr+s9qV1yX1mWOTAOHDjtWMth3+OvgfK1rL75lQL2HjbU9PwzlIuep0M3wJ7o+TFUqvc8PQNA2txUs8FVVhDRsQIBKi1tetDD6pbi5PKA33qQTnQSihMVqTN6vfNHiHuMXwt0EB03nt06oW68K/KqF684VgMCE2G/Gy8yXhRSH0+NSt/gV11z9rQtXIeBPvkTm6gYncZongt9FrVU8SgDKDmnkXTtD5H8T8Gqu0Hmpkx+X4Aqd3yPqcIUAYPm20keQSKgooxf1eRj5RPrR1yG5WqlPMrMQdW2mZ/PN3GgVjttgbEXX5bweDUUzbtC4QUXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E/OdwVWTwqy5IcbB0jbYbeWKK9oXp/Q/y/87hpebek=;
 b=XIsOZ/AbYNye3zHvbsDLCrVwEMh3jYrcQXgZ9WrTIPjiICftZBU3cOTFNEXwOolevTaiZHPPJZrdt06Y3JTWeC7wPvxxpP+wr0/vl53WLbDcCr4/vtPPWFRGYx2xBJrfMOpAVpJ6CRtK4F+0KtA3p44lkfoz2Y+5hqzY69bxxqFgJAl4V5cB5gEAWqof0UsNRWCrlPSsq++21ftUmV2nHjaaWvPhIcIsFG/h4NbZw5kAQLS0Z3XpShf7b5/Rzt7tjlYa/4rEIqBuoWl1m5mnxYmehTHq6gXR+3V0ZpWxoN2Xey7xw9g3zQQnj2nqpkNy9XAgwEKqj+/Fd3djnT8fuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E/OdwVWTwqy5IcbB0jbYbeWKK9oXp/Q/y/87hpebek=;
 b=nBwNdGBEto6FJgm4gQ3s8vWPofHRcZlYLTwxbcBLPlxEpkJk/KcpZah71GvrsKjpEsJlWdkmF5Nyis6GssKns2+u7P3sdj8FgtMx+B2kpfoaTWKwYcsHbuAPCuRp8r4W2VYv2haHHN1rbNG+7YPbHsNG/Svd5ajLt4doUNQ7kV10yhOPotEYXyd8sisW/6UdIiHrsULIRFokg3YlWIbPnluGuuR6VnescRhcGQm0T5e4TiEQgxyGw3e7Iob+8A9tEQDW3ELUh7rfbBJEJTKfglGqP/7qg50kL+4hXzleFVhY716VEKkoO/wCYHlKo7EscnXTMd1Bw8/ILU+WggbQ9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB6481.namprd03.prod.outlook.com (2603:10b6:806:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 21:55:01 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 21:55:01 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 1/4] configs: k1: enable SPL_MMC_IO_VOLTAGE
Date: Sat, 31 Oct 2026 14:54:49 -0700
Message-Id: <20261031215452.16013-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca735f3-9d02-4d19-f3e4-08df37999cb0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|260925022911599003|260925021311599003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: LEPCW4+u7Iz8abMw2bdRIRhaAMGTOrRnp+RVi+X9msK9ihKjGu3J8hHnUzS+vHaLzrRZy8Av9ip+cyRGJKOGmAwd3P9fjlCdxqBbU0C0Y0bjkkMxyyTwUrlawsiAcJKY+dEs6bRCRmowXpXVbbGqVOo6aDhaNRdh8eUFqPnr/6lCxb9uAMgPkSVPdr62QnKy/4RL6GkRpNVGuYAsepj/QxPMI+QJVqljVKkgnCtCAz24VUbuQMFWPODoLcjyZxqLOKLXHKtCuHQccx3RndGS5moUZvGDhLgcVcWOKUBuY9NnAxi0RD1nYBpsp42jDGdUmf7XnCqazRqVOgd1LJYSRFpcPScHjAQ5VlENg3E3CBtSjf4IHO5v3asXZz+dwpXMNCt2e6t8iyuMVmvMGNOxHLiuZyyQbKSvvNywkogSzBghgyt3Wn3vPZhssJWlMvcwvt0AKVUOcsKVgnuqTz++SX5ygA0N1pKPtEehfyaPFnVWN48zq7rrjSWF0GeKYUtDPlgHPh96xbukpV34GevmHwRprfuHGyW7W1RE1gPRp/qoUmY+uXF8FmpX7m7XLHU3HuqrFguEkKsPV2mTgTtQ5rrGRhVqJdn14e4EaFhjBhTDGmDFh85r37OSdKWuULau
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(260925022911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vHuTsizoDCEKh5lzs3/M1TyaNXCatZ6ik/ngBKKXY269fcP9SB2HEARAQhCW?=
 =?us-ascii?Q?3uXjJuJidnxn33QZtbqPSSIXtfcxw5YowxgY+nval2iD7So13gi6PP/20uEX?=
 =?us-ascii?Q?U9gjz63TQ90zxSiJ/8TRppCbpw6NZppYZ0iJlLXNxd7LSjPWuzSj9lMvtPbH?=
 =?us-ascii?Q?z1wYb+2py2T7CbqVlYd4YFpc9RjZ85DkLKrs6hiVGMg+0N6AoKBYgVe/G2xf?=
 =?us-ascii?Q?jn+OyIP0ybx3VW9wO0SRZR3mTvNmEqpLe4rZg8ZOM7sXK22D6/K9MZrz3wuR?=
 =?us-ascii?Q?TMTECHOIUKUSsLMmyTPGYxtvVNWmiA77h/1zYYu0wMfuCngJ46cfk/XyXrAn?=
 =?us-ascii?Q?YKglyPfM3qxwR0fIRM+FqL6AyJ01zUlczcxGhgpWNn8hhUiDdzO0hNIoq1Iv?=
 =?us-ascii?Q?2wjLk+GblJQaknZSO7njTHTeOijk9DjxoILVbHsz17aILOYvminw1lDoKa1F?=
 =?us-ascii?Q?ZXqynzXuFejkMMn6UthgqiKk2XwLM7lyazzajVbAm+Vm2oUa9w2owO0Wby2M?=
 =?us-ascii?Q?Ut+9lCpCSgNLWHCFBM1MTdaVIlgFI7cO+B79O+KIXiiW2hTCdQ5FGOduMyry?=
 =?us-ascii?Q?g8HrlgM+kQitARK8Xhlt9Lf2vze2ofaYHphiD7cTYVF8Lu9I1qj/gW+UQ90v?=
 =?us-ascii?Q?Pyk17PPTEjMO4TuaN6F+pXeZUpB36eW9KvoJI8BO3b1BI3K//OR2VqaYOKMu?=
 =?us-ascii?Q?OOuyx3XUXm+roypkFuggnTnlEnytHhVJTv8nkA5gmXo3mFJuHxN4IRopuzY9?=
 =?us-ascii?Q?6m7gCzsZq2bGdWcTmPvEazt/3JF85+rUYcDTGKsylaqeEUgU6FRXSxo/2hUB?=
 =?us-ascii?Q?efZRPHVsfG8gWJpm3IsrsulaezqhadaddSHNpGvBP31hddJ1eSKr5gENFc2U?=
 =?us-ascii?Q?Qi/azn3h1bFRtfpaqFn/WvtUQwt1FFn9fTWI0d6rK6mHn6iJofcYfHhJGDcr?=
 =?us-ascii?Q?dqUmN4svEU7fLSzjVkl0ocy6d5V1SKfJzoA4lR+zk6kUW+OaWAzrzzzYxvPE?=
 =?us-ascii?Q?CXpvwpqbCsDgVIZ/dKXUnoU9teWOUJ9GQDEsH+M3/KlR7eblup5xs0OLfEzY?=
 =?us-ascii?Q?eXbaLO+nGyYBFfWa5tgFvx6fS4y/1uBwkZFOMEGmmk/lVQ474We3gso1SZZN?=
 =?us-ascii?Q?DP+Yq4M6IetLEbVF8vsfr60KRbJGyXo+0HL3x+2qREWxCXwx4UX2yaQRsJeh?=
 =?us-ascii?Q?DULRLsrYg2fxJqR8ENLqHxrz9DjMMgGL/n4bszgSMGC2AAhFtVsJIVGW5ipE?=
 =?us-ascii?Q?a0p/FD+kq5BHn1DkcWrU2y/UcJlbZDjLeye1gbIgNIqgJX6rWkdNfxplFCIq?=
 =?us-ascii?Q?HcnKJJzAudT2MMQrIANFmASFtcFIvi83sU4RPV9vjLx8IZxp/leXnXqmCf7S?=
 =?us-ascii?Q?HCEQqQs++6zf3udeDlEzEYQJ75FncICo8aNRrUrC75fXyBpEdjqPu+HP8BrH?=
 =?us-ascii?Q?ZokE/o23oTnnF/wdmMviA3JlA2OPuYX7NXVl7713yS+Fz5/nhb2cQqxjE7Nf?=
 =?us-ascii?Q?LTlccgH03XtNQJzQSY8fu+DCbBqaumdjfrXlJvZxMzO9nOec7Fx8JCvDKnzD?=
 =?us-ascii?Q?45GVVJSxPHOJ/RtA+Q5hnR/zvPoDr3HO1X51X/bTAa1SOsrJ8xYgFdhDOTbL?=
 =?us-ascii?Q?h9O/IesxPuq8fFDfpbol2sYr80lCi+P9F1oNElCfEsYzj/YVXbN2wPWNIZ5D?=
 =?us-ascii?Q?AUpX+5wf49Zs+WCiOqf4OgURL54lwx8ImMMt8qdaSCbgJyf41yhgSWqwRRv8?=
 =?us-ascii?Q?PRn+i25ERToppt6CsYd0TR2pqAWnjOo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca735f3-9d02-4d19-f3e4-08df37999cb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 21:55:01.2440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wztzgQSOQzET07ZALsXa3bUqC3hIi0feygXsvpo3O3rab8t+vhRuaGtHnbXYhc0cnlaDsPA9Pz4H2CtWxYtw/e5tX17b3rLNa4IgtzRQwjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6481
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SD I/O rail of the K1 boards (VCC1833_MMC1, PMIC aldo1, the
vqmmc-supply of sdhci0) can run at 1.8 V or 3.3 V. Without
SPL_MMC_IO_VOLTAGE the MMC core in the SPL never sets it:
mmc_set_signal_voltage() is an empty stub, so the card is driven at
whatever voltage the rail was left at, which is 1.8 V from
pmic_init(). SD Default and High Speed use 3.3 V signalling.

Single-block reads happen to work at 1.8 V, and the SPL reads SD cards
one block at a time, which hid this. With multi-block reads, a 32-block
read on a Banana Pi BPI-F3 aborted part-way with a Data End Bit error,
while U-Boot proper, which sets 3.3 V, read the same blocks without
error.

Enable SPL_MMC_IO_VOLTAGE so that the SPL sets the rail to 3.3 V
through vqmmc-supply before it talks to the card.

Reported-by: Zixian Zeng <sycamoremoon376@gmail.com>
Closes: https://lore.kernel.org/u-boot/20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com/
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Changes in v3:
- New patch
---
 configs/spacemit_k1_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 39c490438d3..b67b9f3058a 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -83,6 +83,7 @@ CONFIG_SPL_I2C_EEPROM=y
 CONFIG_MMC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
-- 
2.43.7

