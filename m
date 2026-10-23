Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF4606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uNoKojVp;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cZDkE/HQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BC5C8124D;
	Fri, 23 Oct 2026 10:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8sNn0S-gKyQm; Fri, 23 Oct 2026 10:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD8448121F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792752301;
	b=NLFwa5sAF+oAEV4916kO/srJ9aCt3tibORFAcraIqBs7g8TpWrDlD7qDovInNMgSM4aT
	 oStNfy3eE9iYU2Z7R+K3G8VFY2oNABEpB5ve2RtB/r4JN7lTZ0/DjuwknLpriPQO5l/cg
	 JOztfsrDG9oarM7a22Nc3XH3kwqvl70+GHj9yBkQvxndYlHUxM0N1LBYnsUiM5wDAFc+Z
	 6nhFqW/tsoy33wg7wkC6W7bqBVHDNf3agYcNZxzc8pdXA2mGZIkx6ueMbxOc6tAYX8hJt
	 BQaT+Rd/8b+sZQCDodXZIO+TK9NcpWUUGMVNRPKZne0EjUoeYuck9dGlWwOQvE5fsSQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792752301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=/jEbsnUVZgyhz/KkFS+tt8qDXI6EsRiaO0LfzLlsar8=;
	b=EChQt33NdgUbthyecG2H4+H/XzJFXwzUjIvtYgWUMhf3O+pLjzongwZW/jUuQlhyuSLy
	 voCOn/GgdCdUZo1LZ9BR6L2G30V1Rxy2tukaWAfy00B4/klT6wF7LV+MvT11DYMA388+g
	 mRGOp8kRcxoej9yhmnP3qmVw528KOTH539N09DbjYzvtEoM/1woD2diEt1fwSR4ZLErTm
	 TO6xMc+CHjb/niz3mxrG0OEfFF1igyB/zjz1OWhgNh8uxs7bHD0EsqNlkw28HuSGSL+Of
	 sNiBs1jO8UCwywNyP+fM7m138xW0WLkB1uqdC+fEwaYH4UlMXxQGTpR/I/Y/JJW+8yA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792752301;
	bh=/jEbsnUVZgyhz/KkFS+tt8qDXI6EsRiaO0LfzLlsar8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uNoKojVpYrFsBmQknsJMxsV4pd4r+kX9chsns+LXXyqX/diUXiRN22cP8+cF6fYCu
	 Tcn4BwexltiZ0VA+dcGhPBtBTeKfAfFWBppmGiTBljgSEc3AN0sz5L5+CUonXvFjv0
	 MFnZSDQXMMd0pj5DIUoje44ratqZB9AGVEsWlXDhHzpcEY2+MCBvbGhCapH7hxKMom
	 9VuMfnKDYvj9+SaaIXUVw9mly3q0C9dw0FTMSevbMQfIfE8njKstjXwhp1ioQiDOWe
	 nY53iLq6xOefiT7wXa3zsnJMr1W8z7t+Q5OeRj60pLvRgc2CQW7Mc33/702rYsR3xk
	 4QmrGVY8s0FeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD8448121F;
	Fri, 23 Oct 2026 10:45:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 616A23C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52EAC4072F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUBCbBRLN-gQ for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:44:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C29740722
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792752298;
 b=BIqnHW9b4Mh7e6RWoxTxopa/6dOuME6tQ70GQbZGW1pVdKoz2+gjo22IQwbnzBGZuDwG
 q6DUgCFGLyj9WqjeDMp5EHu5QavhBukeR7nO3xb0eiDsYZ+BRCiG4TJEwQvo4wR1eK0So
 pkfQCAB2KhdyZtFCF9os6r6lIdv1WYFuCNwDfvpcmqBDcKLB8LDmjC+Jc1m5371zXa5yP
 fMzXPyxQay0nFlLbgXyw3FzZ7bcQPqN8rl1PMooxXhEcg5ch60P0+5On2svbHspo28Ljq
 bELzLetrbmOkI+iFVah0bV+eCVGSbFSokX1JqthVZXNlXMD9FulJEwVNjxR+HEwkn6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792752298;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 bh=/jEbsnUVZgyhz/KkFS+tt8qDXI6EsRiaO0LfzLlsar8=;
 b=TI0LYB+HKSHQJb/WfWJRVQsJmiWkBSVGHyrTK7cyoz4Gp8z/okgHDdub9ATDON/L7YBW
 PDePW0SMm98uglfiXr51BFkARUJgRFxm9LLwBEVucY3rwZzwLIFB37XogUeupvtmQ9zaW
 2xC5vDbgCUEIRePvAjI6fz9NM6Q9oH7kbsfmR/x1tDSB72ib1Zptpf6oZW+FP1cMwcnyf
 4bIDqqjpfPy+cfhTq9NMYzLxCAcBAnXSWS+5CAVxRaCIxuPnsV0uKp9zlXjUr0xdo8MX6
 d6Dvl+08EBDtAm4YWR2yN9z1zBmxc+RXUqnM8FYDFMFirghnpfTxmK+8d/hom2D6biw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com
 header.b="cZDkE/HQ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cZDkE/HQ
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C29740722
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+fhr6IJBSLTQbexZ49TefAzDcX7iCtKREvHvub4jxDoHqwoxEHY16cwMGdEodf507/cRS89+GzknssL4OMw/DL8TxVGouQp3qPq7BLtL3dzk9Xb0tZdtdoe/20EKDYX+WUcnKQ0lpyYlGgvJBNRJx5cNwEt3UQr4cOUtIbZL8Mwl7es2KKsr/OX514+H7/sdaN7OZukJxlvp4JlU6m1zHrO30+2YRyfkUXtKCkAiQiDGyzye+s+z3WWfGAJtlR/OmtTJ0haoxdtc63SszSFN+LiTtFHAhr9WsAWwQHp1LdWUEWISUcFaAeeZPceyMgGl4AqLcSGlFKNwLE+sXCg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jEbsnUVZgyhz/KkFS+tt8qDXI6EsRiaO0LfzLlsar8=;
 b=wqg6vTEnmGJ0vaM6hBh6RuuW+mfOythUlskNEzO/bQN0Nq6c9K2fyTjd8wZA5CywJjqk2m7x1mZJGGY9LdGtf81EzYZmsTqLFvaeX2gFUGyrRewoaklL+YAgS+JgI+fMYWKTfOZhbsyuVMnCkLlgyoq1q7eyAgKmBEr3oQCAzZMExDXkzoGYcI6+cfzUJWe2wOX98nhTEQ5VAckFW4Lj1/bV3kEJybqAOSwm1wfBF+A1d4uUj5b16xaUmrLuB0+g4mEPoRbHBlQMIQcIby8USe3M6Nybxtoe3QiAfqe0ZJ+1sjrHKCsjf0N1C1g3nOGnzSNSCEIFcF3zrOZBkUEjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jEbsnUVZgyhz/KkFS+tt8qDXI6EsRiaO0LfzLlsar8=;
 b=cZDkE/HQqm22W4nObgubwH+0rlXWv0WPb9vE1VXK8lAdwh7COHUrRHBQYwqJkZnFAH5UPzeVIOAxw3g4ZBYRjNDLQ14QhHRBTdI6/Hh6/kDAkh9hRMhdLAvtbcnbqVN9cVpPXyVfjRkOteNpeUY/NBIc+MyNDm54ZERghISSXEVmJ2w9kXrSwfnCiCQ22t6EAHg+7GyfKsJN08VHFReBwjKE66ymK3pBycknx3iVo64q42wNNZzfGSoO/abvSxSh0SU7vsE3ZYA/oOKkIkWmXf9nC4tqq+bnFw3EIYwlFbxIYfLJc4babGWwFu8UqRNMo3EYudrOjjIstHlm2lddAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by GV2PR04MB11564.eurprd04.prod.outlook.com (2603:10a6:150:2b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 10:44:53 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%3]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 10:44:53 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.u-boot-project.org
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Subject: [PATCH] imx9: scmi: Remove useless scmi protocol devices probe
Date: Fri, 23 Oct 2026 18:49:21 +0800
Message-Id: <20261023104921.3477975-2-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023104921.3477975-1-ye.li@oss.nxp.com>
References: <20261023104921.3477975-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0238.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::11) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|GV2PR04MB11564:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d454e0-678a-45bf-e852-08df30f2ab5b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|23010399003|366016|22082099003|18002099003|3023799007|10067099003|11063799006|261009223027099003|261021123027099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info: wBybO6qFFMfIYcwPoaOhoS00vuwocuqSUKziIS4wdLRuM2EUjcN/yKcB48o+uOxXlnqAv2fRl032K1iafAejLMfNqyc1HrkHauWJzzK6r0I+7qUbX0QdDaOux1U8DesAiakBbacpRd1R2tcabFRGe+r8/MWo2WAsvtHYwUqBvUvOZPjfwFewVXsz2LK/3sRHMY7wbd7s+CHh5sIPAb55BLDfuxwLYuRCIDvsMV8+Ckj2tHuAueViRfDDZf3qgQiOJ5Mh3ESKDZsx/6b+cxYNpfZpL5S7o2hharmzbBTU923izGjDNBkNZTfQ4en60quzEBqWR2einKUtVx4PT+gTUoYqRdFo1EucoKH80fZE/c7Zjplg58fDkSQKUQFTOHh5WhtFxLHY2ik4YHUd4jL3lQ9koy+cNaUeey4ky8DVxwagpz5bINCJ5LRkitJuI5MQ7mJmZhsJtC1uKi9B0hPY6RdL9Gx7I2gGsinjxDuvrDG7ITHnxsDI9dVV3EWAHnLvBvogGjcNTBT8PgJ3m9BvqsqO2B8yJMfMFCMKXBmW1APfeD5G+nmO2lUw0yHa+jhZiJ3DoQKTHe8R0IXUJptg2FoUb44u/7oHmrtjmaZtPA/No2dy0IaFfMBv4qFYbJZNFb3NVjFcaNNzzLYl50cuDwXSMYurOY8CN73LPtq8jME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(261009223027099003)(261021123027099003)(261022105027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?woT+S/qyCRd7M1FU27KzNwQ65bOESVoAu8GoxZTAobownZKOqBx/8F8GsgZz?=
 =?us-ascii?Q?GlEukyKptVCzje0XlzbZlfqtI1ryB3P4hQpRI3ax8x6wkBvX/6QPuTwSrwSh?=
 =?us-ascii?Q?ep/UaFXQVSB8lt2ftb0Nbq1quUa71dkpbDR4pQy4D89179F2CVfOgP0q0slC?=
 =?us-ascii?Q?b5FjK+cJ/D0wLMSVpuKz0h4MRwN35ZvQ40skY8Yf11q74EzX42cyKchl/BTT?=
 =?us-ascii?Q?t49dha73UM5+GHBbEThFeevsq3b6ZLOIIWIaqAXWXYbVs1sIp95bfMSGiuDC?=
 =?us-ascii?Q?Mx8s3GRH9rf7zvOVZWWIUzuKi9lrzF3Ysc/ssFBlVjM1uROxTqK+6xl2prhP?=
 =?us-ascii?Q?UmiJeyJYYSKppfto5dETNzt/siyRb4xjioEK9tMG3KiCQDd99JNRJaqeUHji?=
 =?us-ascii?Q?pXGFFADvOFR/prHQzkGGv5DVgh0VOsY6OsFCJVa8xFcVp7A7IiMgQ+KzaJ61?=
 =?us-ascii?Q?m3QB5e2NdzKYSMPBG/YdiX8ighQSTkRF6W1oyma/W1rEwQ9olJWDk0NcjFcs?=
 =?us-ascii?Q?300Oy2SPc37WVtUD6w7myQZrFTWjVa07b09KYj9sZwz6DT3nn8PWmjRqUAEn?=
 =?us-ascii?Q?0d2oinmVG7PVtvQy8RgMKSxKPYdMtqd9J8O5oGgFKWbzSo5cUwHuab5NwdG5?=
 =?us-ascii?Q?K4OJc/6rnCvt53m25yMKWGvobtLc8GHOpM16wcA5KacYZjZhXUFTLyRlYk8y?=
 =?us-ascii?Q?ZrRO20M3uzyiRkVQehlF9QJrzyTh8KD34EFlL8ffuHsdpsFShFBWsgYm0Xfw?=
 =?us-ascii?Q?NlS5sLPJlFgxd+r6wqZbMUC31czCqt+UXIYYUWQq7i54zCX+YWma+V2yu07e?=
 =?us-ascii?Q?a4e7EihD7tLrZRDCC9wu164STQq3Cf8d9TqAoDmE2QA/IjcMryU0wEVtCMCW?=
 =?us-ascii?Q?F6E9cAU1ygdfFmbCiuS+fmiSpkL8+imu79TOb49e/0UCR/GTt8rBxuda0hHO?=
 =?us-ascii?Q?CNt7AOa//ap7rX26asnWr3kiZ8eV3iyMS2k3peIKphFIt7MYcAE7KQ10m6mJ?=
 =?us-ascii?Q?Do7LV8N4hWAge4NE6dLODsp5CTwdr769helsdRY/sIdu0FqQr88gyw+c7HEx?=
 =?us-ascii?Q?Strdjvwy64etYakdRhw5a5yzBuqZU72ZKXmHas96MNkyg2o7oeoT3bLtC+Bi?=
 =?us-ascii?Q?V78n5qPc+lOnthQowOXaX1QsmIcqd2NlJj1Py0Yd7TOXEnlQXR4z3LDSYTb8?=
 =?us-ascii?Q?HWYJollCCn/48cp8d8fhcM50cTzWc/ILvphlbblsHWJtUbhHfzQ7xuhHqyDa?=
 =?us-ascii?Q?NVp8R7gMwKgSzTOvaRLju4wC6NUWgzP69BSP5SUQpPr6iM8cM2nVzbtuhv4o?=
 =?us-ascii?Q?s5JbouDsWx3rEz9dpR2b8+B7Vd6K4dSN0Jq4mSF5UOxSyaX2HfVDSeQ8vOsC?=
 =?us-ascii?Q?XvxoHeiDF07lr99voS66KAa8/ecWTLbahIuriJXGxOAkPQzRKMYf/g+ca9Gj?=
 =?us-ascii?Q?ma3dCpRrDRn+S5hr+rvsTqBDcZ5x4mLsLQfblIzelkg1TLdTUCoDIG00RIgn?=
 =?us-ascii?Q?aYEyknSynB9BM1MBosHwiZRax4SnGHD7KbUU8QTqZbngsHamzVLre6of0A4Y?=
 =?us-ascii?Q?BC1WmAnmoxo1pkaToAY3SnC5ZRNM1znY7ImiF8Ndn/lfLVQ9ii6ZxmMgw+D2?=
 =?us-ascii?Q?LYoft02pHtAdifGhnvYRp3+aGLnOz5xZci1qET1b+g6jjvRKSSFAQq4BI5uC?=
 =?us-ascii?Q?JgxAbz9WSsUdP/iOuuVwkd0xigE3ufuE6QKjvKQ5m+62AroFzn5v+PU0Z1OH?=
 =?us-ascii?Q?toaf1IJ+1YSnODweYCzePbv3GJagBYI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d454e0-678a-45bf-e852-08df30f2ab5b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:44:53.7999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPsEY4i1Yxi+gZBvS6lOfeyFywGOw6p8ZsOpgxVoUMlx0rWCUSYkXvrfRilGQNxp/BRC5Fut81YFRvfTODE8T8nAM3uDivBlga+aIfU7TEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11564
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	T_SPF_PERMERROR,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ye Li <ye.li@nxp.com>

We have probed SCMI Agent device in imx9_probe_mu(), u-boot DM will
auto probe scmi protocol devices when calling clock and pinctrl. So
explicitly probing protocol devices is useless, remove the codes.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f6bb3733bd7..2f1a4c70fc7 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -1267,18 +1267,6 @@ int imx9_probe_mu(void)
 	if (ret)
 		return ret;
 
-	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
-	if (ret)
-		return ret;
-
-	ret = devm_scmi_of_get_channel(dev);
-	if (ret)
-		return ret;
-
-	ret = uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19", &dev);
-	if (ret)
-		return ret;
-
 #if defined(CONFIG_SPL_BUILD)
 	ret = uclass_get_device_by_name(UCLASS_MISC, "mailbox@47530000", &dev);
 #else
-- 
2.50.1

