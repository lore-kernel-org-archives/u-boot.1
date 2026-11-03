Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E4606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cgk27s7m;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=uaQQHvQX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 423D4405A6;
	Tue,  3 Nov 2026 01:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCnEkumjyOR4; Tue,  3 Nov 2026 01:40:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 896A140501
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793670056;
	b=sRCqArzHsSrVt7NwUNVGR67vkJ9T2ofE6Ov3LVFHWFWTl1z8sHyJ80TiOoq0dud9n5uh
	 gtPGSGd0dnXmH15scoRJatNoAM6R1lwMDSKeHp2sJNPQbGNEmaCSndn9JrS65Eg0m5oZf
	 wTrwCr7ItSNE9MyB79LKl2DCs4aL8YQFFDlU70JNf2FdNlPunRCPX7LTL248qLdNeNOny
	 gLuye3DHZLpw/EVs3hN838qjgXGGcye/yQSPDBErg0TmkCnD/QDZavewSF18yAN0GjmUr
	 lxwXVR5NarvqJ44rMN3t613aB+M4HaSnF8mQ+ZkhECEkGyAeVPClc7RVoNT9ZVgsnOg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793670056;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=91jQvLQIw5krPNyBIJjd5Ny1ljnTzp0ZB7pFmGFpmWw=;
	b=B8VHqorbyTf16GQzRPtzZYrGng7O5GZdTDmjg5fXgKHcI2LhosOg5ZEJhvh+Aqlhz8f1
	 2jgZtzc3BIYcdr3bzw43U8/dAPv2T+R5DuSziSZPKP3uFdycCPJFj2xnfmPQitUkqCiA4
	 hLD4TVU+5TvfNiaCcoWr+VPrinLUa5LHLqc4Fs7qosU9o21dIKVqqkNCca6s6/Nwx2M1E
	 OR8TsF0hsH6JgTOCbNQSCGCtOpeklRq2rJExJQQN0wJww5B5PoiL/7kAREJMpgnM00SKy
	 HTSuwa6LAcUGDIRK1LNpjcNZo6NYvZR3hK6RpIjjdyqSrpgIfJeDHLcc9yZ6lpNITcw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=iopsys.eu;
	dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=uaQQHvQX;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793670056;
	bh=91jQvLQIw5krPNyBIJjd5Ny1ljnTzp0ZB7pFmGFpmWw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cgk27s7mp3LBBXJEHEY5tNc/FPXUPCBmQF5DofC0OBNi3IB78gzji/1PX7elvMIki
	 IUBYxvjWhc8uXX0r3w3AVCfd8hYMgAOb3DsDA3+1QcPBsrVD6Brh/gxWKbkYxzIw+I
	 lcVHWedQD18eTujk2/hvxE8lAlcYy/jzVtVAvuy0DgaPXJFuTeORnE/xMUOAYO4vuE
	 J8J4wUwlncd3WnA1lKDaAbfQlU8v+VOatlPJBWi1N2J2Ls6BU9dcWd5KN41xUnxw4b
	 /ZVrf/9tCVYAzKLnLNatF9x9JIAx2N/OaBhslPiIi91GQ+laj9CADVWciw8zUsgDl5
	 suYiYNY1X4qgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 896A140501;
	Tue,  3 Nov 2026 01:40:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0997B356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 01:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E34B040501
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 01:40:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dcO0um2Wnvgx for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 01:40:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5165F4048D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793670050;
 b=PFQvRncRgmfPvMQz29F3OWrJuNUiO694UfIQiQH3U99gPuklp6qedyy+U0OmIqJ1gbjf
 /TS/bTR4T28n6N3U8ZKHVsmmXATZq4N/7kyVsY3sQvVAi9mwWXPcbpo1xYgWrqUhHxuDY
 qjsHePROopjHPjR/akHirpc8BLIS8qJiKam2iw9BYi2miwW/6Nh7xZh7ZGeLw62CEAw0U
 Iq2Th316xOr9MLLpXo2WfkZVcNsr8zrtUvRTTnJBB7tfunJj1NhcEyDprazrpw42l8+iF
 1mirWJ1iAmLlXuUohp/TLZ9Xzv5cbDLkt+Mvt+Qa70Gt8jSas3+sZZxgSDTr66IqywQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793670050;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=91jQvLQIw5krPNyBIJjd5Ny1ljnTzp0ZB7pFmGFpmWw=;
 b=WRnY5jVy4s5KpuFgfq9knn3TzxTorJugUlVooVGP/ErKx34+dc9WEf7LnezB/6Y/E/AR
 cY7aQAablCHNgmfD+qBMW+Hg8/5xKY9q5TQUh5QKJ7HgiTek2CABAbYrhOTsdhj9TB/60
 dyiyp9S+QGXUgewkYu1M34mliSmbm71PFQOHw+e5wq1bZe5K3b0RLJlLjJ4bM6saqQrvw
 r7nXruo7Cyhe1oXw8gVn5Jxhs9Av/V/Nh/RatyteyH8WryoAt/CCYH9FfMsjLMNKuyyi2
 KGppD9JiRR0dkxOHCmnInBlwKVcHqxpeKN41w23jIpJY2sThkoSe7AMVWcvZv6CSh6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=uaQQHvQX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=uaQQHvQX
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5165F4048D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 01:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu2g50UyfKeK0upnT1J0H7CcLKnEDq85s1AJqXMszfGaxDsE5OApKU3jhK/vxl46CONvrBislvPGkKbTmejgN/wWuSMP/FNqg1gyhzyWIJAE8WwmDBJdmXwEDK+qxPlxy4ZXD5WzOsiQk+wWQLu4ULTCMBgyDxnZClvGggTTGUd2x3QP+j/NNmHb0jv2ht4GGnG/Nrp227wK1Bw8muHWb3zKIWwxcaT+XcO3jdQEwjTZNwampvSiTHCaLA4WC2khrvbJs6aJhEuxK+uxiBrUO/A2Zssz2lM5oTWVsNdHMgeFUWBvoygCAvA8tFzFYWmbdlayHR5rMOFNysewQZEykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91jQvLQIw5krPNyBIJjd5Ny1ljnTzp0ZB7pFmGFpmWw=;
 b=SS+b60etBW06IsbvcmAt2cIQUPd8CuzsOf+AqGv/3Fzox+z8IDUIk1hVBPV+wRhPK9DUALdJ70Z0m2HkXFvBvFy4+lWCvbLPURtOePc7SobH85YYigsVFdbbltBzGP9ZGL58xpvleKaR8dFJnunfajY0liYIRY0/ooN2vQAdZScgGFT5kN9jXP/3s9zY+tpgr8twXCHNGPquLynSLvxiIDW7xUuCMUGpBauduTM+1mMzsJd/V6GkBdQ8AXR2kPFXRyw4gYtmh71yXiNa01ftSNYtrTIx+1w0AbzbrxcbzDscdmgXYRGUXJLQqah8e4CrQsWgvPnBqfUaLO84HN15lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91jQvLQIw5krPNyBIJjd5Ny1ljnTzp0ZB7pFmGFpmWw=;
 b=uaQQHvQXSJI0peocUfgpD2J/NTcoJ5J4rG/FHNpWdN4nEHtoWyVZEexrmG8GBpFpftaC7cpV0eyOAZjdqmFVSJOwOVGvE6DfmfQ45rfCAdF1UXZVX9gikrLNvIl4xfCpxPpDO3StCwUlj2C9Uc5WY2/qy5XeLkz/OTLMYqjN5zKht3YqV9mh/0TdTTom5k0dp2hzDObI1nhGf2dYOfp2+ic4WsElg8LvA78ZgiVbIf/AtdOafKxbAhp74PD0nLLaUQJwKdh+8OS3iGT17mBGTTbV6Zwhy0EZlyMU/08AAPGZ5pVF0GYnKFQdp89fRk25b32uFFIx+RNn1z25W4ScBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AM5PR08MB813850.eurprd08.prod.outlook.com (2603:10a6:20b:7d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 01:40:39 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 01:40:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] airoha: an7583: add missed definition of CFG_MAX_MEM_MAPPED
Date: Tue,  3 Nov 2026 04:40:31 +0300
Message-ID: <20261103014031.683345-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::34) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AM5PR08MB813850:EE_
X-MS-Office365-Filtering-Correlation-Id: 3172ce2d-ac1f-4ce4-a5d9-08df394b76de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|376014|1800799024|10067099003|261102123227099003|18002099003|38350700014|56012099006|11063799006|261022105027099003|261021121427099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 7t8pRvnMH6MeNlPX65w71vg7Nydh+Z/1jwnhIRBKKzOsw1Ngo9VNAZxr+Xdj1t8tLNUKa7rqdfjI9/3viVYCKufHVeLO8HXQKymbi6ctz3o2temRo7hBiX2YhtHuph9HdKeiARNb8NddzP2ztT2GXznL6p+hsOQ4PEk3ZK470tV4V+8GCmvLL8fODQrCZ3GqbXv4jD0Bv83TESXgS8PZFlKK+KFiZBE7M4XA/krjmEh6jxCyqe01lcUvRil0vL6yEzCT0T4gMvwldFGiOKF4ScVsTOybyDUxSr5GC9bk6oMtWg4wmQaB3go5YQbaJX/h36Lu0pYNodZtFONMk0nOdQSIhXckcMvm3z98ETyVSvmM5LmV2H3hJPDL+nfZN6KZMKbAASyWpxawcxBDcFZjpaoO675ez3b63NgzyIvYcGLL43RrCXnwNUXycBvq26yNPF0e70Hs7pTsBx/4bxgHa4UJlXst+1l/pvn8mgFHznjgxQ5ccP/hKznMkorZyQ5CTnf66w1G6z4BL/e8uFSKyw6dSl6QOcup6c18SiiTGhcHDg9JWoMLQsbDKV+P8SK/2YMOwLUjbaAdaJZe4RPbFb3fBHCnmo1/Qg6h52k+BL+WJ+OHx4lUrbFCCXF3Ja+UGBSpL2vqLpGsSrXWJiP16wTNEhe8NlmTwMxf3sLpC36uevID66WwEu5AhvoMTSagQD+ojPcysiOyXqhn54SsFvxdVTFD88ymWIo+f+FzjGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(376014)(1800799024)(10067099003)(261102123227099003)(18002099003)(38350700014)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MV0qZwVuwMew25uTaDMWY8TvIDaxKcvkBk4HDLeztam9HGIEiFgSXBMBo8F?=
 =?us-ascii?Q?h9vsCqlVFSNmR0x7uKTBTzmlVXRKumZ1qvDHcqHhW7ere/o3KRRh1cNBD5dP?=
 =?us-ascii?Q?RoV3AK+mYLZ1U71TCG8kvODghWtUgLzIIZm6rgBCPvd0XSDPf352XV7ic8DN?=
 =?us-ascii?Q?jvQTvxZflKUyNzPx+ON91YuHfULx8PqPerDWuRbYSb+KgViOoQyBcpfqSytC?=
 =?us-ascii?Q?9Nv+ViXGHWkNXr3vt8HWgGaBVizqCO2K4KYBkdCsWYfV17HRxVdMxmzC3Tvr?=
 =?us-ascii?Q?XcmoN+nFTRjAC2Lv5thSWtpvb2P5EmTY9D6PQMkPDZ2rdZWuJng7zIACYBs4?=
 =?us-ascii?Q?YfGypfgjZDMMzS3+YTFssGbRjustrh02Y7/h3MMsp/34PCTasn3Ox05XDyPQ?=
 =?us-ascii?Q?xY4oicy6jTdjxpV2YY/azOsHJXjCIhi+xpl/oGWDkQB/zRQ1hdAEpPVQGcBQ?=
 =?us-ascii?Q?2kfbZEwjOEaV5KSOBWhNwQU6bjAz/nOaazQ3awn/Y7fBuHIS17InFkhTGxBV?=
 =?us-ascii?Q?MubU3XZPzgYIeOONb+wEfbCZ4CbgUtJxoaGktFcLI2Ezm4LiYzJNVz+C2ySZ?=
 =?us-ascii?Q?P9pRrJMc0G98iELl7HSKuN5dwxGdyG1Zoy1IGOjJtuPfUzlH2kPnxlwlt7yV?=
 =?us-ascii?Q?6DC/NZCg1lpID4ZS792Me6iQXrg7XvMSR+8mGBGYVDJnn2ukaAfO83KK4a84?=
 =?us-ascii?Q?f5B0+0IrsKWMSXqMSxqLGonxcECGx9jbsDLbblW2y5MonJsdJ8pZJUubDWqV?=
 =?us-ascii?Q?xkzQ1o1k/SBpeP+8HT4GFhUuqTGgQ1HW2nJS8jGXXg0oQ5Xz0ijbPTr4/pgs?=
 =?us-ascii?Q?Bo/IFosDPX4hqncOMK5lqZoXrwzuw4Y3axAOG1YCo7a1ICW1fdzKF2yXy/QI?=
 =?us-ascii?Q?Yn8+3qHW7VKu+0y3b5p+qG17+t+mmCtF+DeBcNk5TbYFQcoLCm5XMp8N2Hqq?=
 =?us-ascii?Q?zqMUyziDLmTYE5e0nZoPKTXE1yucMyqdoj8XG+APN2JZi5EjOob7+dU4TAWX?=
 =?us-ascii?Q?OX9qwxYw13cCdnIxxUUMA1WHEk7vdhTBSAZY8NgzQtwBxA97aMsOD0PbZyWE?=
 =?us-ascii?Q?fGJk/cnVna8yLV3vgfXju+nMU2acLI0Z/fdQ+IOxgntaVwTL/W528/IHevSE?=
 =?us-ascii?Q?RoXdDmqHRlTa4tOd+VJzTiQviEFUZWq6y0H+AiN3GYTeEgOezQrv7nk/V3k0?=
 =?us-ascii?Q?N4chUkmw2FgRIxycDDF2EQDME1jO56ml7BW0csiAlFHSpQX9cJs17uMtVXA7?=
 =?us-ascii?Q?5bvncQVMzcz0TWG5kCwxBoLK5DRoLAEsgQKYwAfokxO67Auqq1wgGDFOPXBj?=
 =?us-ascii?Q?WUCyMH7Vtyavo2TTBonIJSra8THYmVy8WLrvlKGalV69Gb/LPrQvuwzN5ta7?=
 =?us-ascii?Q?q3qRQJ8fTKYY97u+RsW4n+Ibx+yOIpWvPJH8+sj/kAnxN90f27XgzSQWxcD+?=
 =?us-ascii?Q?Vuf5+cbQVifb1kV4Yv0Cvvq8P5MYZJ/1lqIBdPapmh5cPG3rulm0QDMPa8KP?=
 =?us-ascii?Q?b1hLOSFoTQ3JsOVC5v7bzrty7YDf9es11E2UcONGyca/mddQJ+qu0nTDxCH4?=
 =?us-ascii?Q?vFMqShPntnINtXTzDyAXGDTffBtLHb8lq3wdrZXZqrOpcb8n03+EJYy0lNuZ?=
 =?us-ascii?Q?5nVDbB4Q+ht+e4/QL7WxrZ8dsfACZGZXSo2HKiPgydTPgaooaPYi6/mG4zXP?=
 =?us-ascii?Q?P+V5kOJIhpdWDuQFmUH3DMuAYtxD4hPtPtMimMxEbR2I6Uay76VgiFgmY01+?=
 =?us-ascii?Q?5bgYxbZseh+2iXa+8O57yqaFdNQBi2M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3172ce2d-ac1f-4ce4-a5d9-08df394b76de
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 01:40:39.1779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv5RiOIWIV1qoXfY/Z6de50diQqvFgoeLIE0aLh5YUe37nRSUeaUjE1nA3EPhEa1og1UkV8Vpm6KOe46Xx/D5qzvmBf0M/TA4GaI4zF0sMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR08MB813850
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Due to a bug addresses above 4Gb limit can be used for 32bit DMA.
Add missed definition of CFG_MAX_MEM_MAPPED to fix an issue.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 include/configs/an7583.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/an7583.h b/include/configs/an7583.h
index c865afea1a2..d610d3235b5 100644
--- a/include/configs/an7583.h
+++ b/include/configs/an7583.h
@@ -15,5 +15,6 @@
 
 /* DRAM */
 #define CFG_SYS_SDRAM_BASE		0x80000000
+#define CFG_MAX_MEM_MAPPED		SZ_2G
 
 #endif
-- 
2.53.0

