Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A3606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E62kG9Va;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A+7G3l0c
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6303580960;
	Wed, 25 Nov 2026 06:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ouJOKhga7onU; Wed, 25 Nov 2026 06:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4BBA808C4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795589298;
	b=rVgcG9XNTCZHs1XaDODyn/P/lFOAnFW7WnJhHdtI/+QKLZkftwjUdyoui44T6Tr9Es8+
	 gKsYLS1xHPTFRdBuSWcDpLFz4lZaRX4wMU7Rbw5XgSf+eLEB5T4OuefbiLkhTwGQYbUtQ
	 oI8PULBcyTID0q2FkmLTgOeyiCk7vX4BtXZ2HdqY7xzWhp2ILCtbQgUKkinQGZkOeZYsJ
	 aRhp0/uKGJxGzO1D/FG4gCWqSHusFQKKMahy559UL0mHaBfvAFmrBznxWoZ3QuBADen71
	 LsKS5YhYyW+UBuQ7URwkgut6L+PqZ3H4jP0i6EqL5a9jp22CTCfLJ9raeP1ZV0sJSeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795589298;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vr1OGPVmScWhDQjSHJWIgiiCqYZwJ74bbKmSenNBfG0=;
	b=YSeuittGeZ4UMAYr6f3Tmbgn0FfSwiKkAXzfb1AHcfEd4WplQMoi0alOEItfvlXbnGLy
	 3e+ZuiO1e3Swzt+v9WS6YlCJVyCDTG3yr0y6iD8vTcKasSBCCC5VJcEjC3X3M5H4FmKkq
	 mHzyPviTSvwTEAIifv8DLyDC7LAl9pbSUGwhGoccv7Glix8VcAOWYzUqVV3yNIAj2Ihks
	 gha+49FZnCpwMhu3ndWV025mtTPnM4Hm38PVlPtYLprO1edB2Mvf45UvffvMUKHEG6RQV
	 0NPAI36uYzP2sJf4FZB4qVJ1tTZx5xld4fxSLHEBjCTyMbVUyCwxg22DdJkysQhQvxg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795589298;
	bh=vr1OGPVmScWhDQjSHJWIgiiCqYZwJ74bbKmSenNBfG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E62kG9VaGfX7bgMJ3Aj+Sij9SgitR1MeU1ajQsBxqkqY4ODHSwSUvziH3uUZHDuzF
	 jc637XhPnlwjWKJ6sWRqiu4N1NYVOsHy/RerNRSuVeGTo//ckGPJf9CaGmNFtLl1Cq
	 hjNJIOoAEuQ8czmCrnJLemvmTnIeQiEPCKzP0TUY4Nw2V7Xd36Di3GfsJ9+juP23xm
	 gtsKbPEPy1OadSprlm1mQyGtLN99mrOFzP7bqnTnEghMgz1zU7MKKn2d8W42odgJQb
	 D2qL7Yov1tHdGc5ILrEsuDTTm12WUs3nB6nIsSix+PyrZDZqZMVmhA3j4i8wV9JdUa
	 iy4QakmK+g4gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4BBA808C4;
	Wed, 25 Nov 2026 06:48:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A16E710B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93A136069B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Pe86Roh_P6e for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 06:48:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D61960664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A+7G3l0c
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D61960664
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr1OGPVmScWhDQjSHJWIgiiCqYZwJ74bbKmSenNBfG0=;
 b=A+7G3l0cifpyzQkT07T3D0PKY7OPSYc2O1j5Llexi9+3+qYC9a8Xay+p1snYyoZ+SJCKD4ZhdZ8PxEUDHMT9ptzxGUq+mperUh7pShLDfh6cdYM6nwd2ROHu04IxvgcQJjWdvYdpk4e+s3RQ1JAHFl5ZMs1jqa0ttf3GEcD46pDQFn7f2LAfM5D2CLjGj7SYlNrikY78W6xphs1K1j+Rgbkrx//U2MZaBjf0blV8c2oFBfpRKP/VeKDoxP+iyQ2Yxzil1k39MN4XNtxvxIersj5h5jMq7a22adJUnuwnbWqxUZ7jsNooO5AWeDVZFBI60HjlS93MjymKVgtuv8tAXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 06:48:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 06:48:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sean Anderson <seanga2@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org, u-boot@ew.tq-group.com,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] spl_imx_romapi: fix typo in output of
 spl_romapi_load_image_seekable
Date: Wed, 25 Nov 2026 14:45:07 +0800
Message-ID: <20261125064510.26998-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261120080017.2762904-2-Max.Merchel@ew.tq-group.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: d35aadfa-72ef-4517-2152-08df4ac01152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|1800799024|376014|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: D5S/BJeCQK/B21QBweIZjD7ofUEa7JV2aaKsqgDoJK07dy6IA3M1MzdYF9YSHl0oMXW7076kFY+A/ICDk7+XCNvPyqGf0WQlBpD3RJ3KidWJ0ieku1GtIT45AEP6jGGkAeS8G9m6KyT9pzgFpcO4J4MbBxKSFHoDEPql+Sn/Y3wugXNNMQWYKrCJNj3ceFvi64a/2W+NTnVgzbH5Vhz9t1J5Utz1yXeouJrkRU9z+uyRLQQBsJR7343GDAPPBdEo1CS2I0HgRoziC5NxuLVZx0L9xdjvJBkHqki0/UvkEyBPV1UujA0XjhamiYorTc+/BbMzhRA02giz0336mLyOxfY478gGFjlWmNrkJ20P3L4CwK9oKN2fix5I3/rQDbTzKRJZk++8F7IoLRfbv/uykkeZHWCArBiCsYoviy1OJgHppIx93S6Gpn4U0fx69tuiyqwmlllOhh37BPl4o5TKLCudDjxgzwOkgeMteP56XNWsQMysSM3GoVbdK3rSHr4sR/5DjOObHILj7Lr+/oV6cEZb0aCzDeEPR8nHF2JT/9utvxCMPxSZLWI7wqIHCbIMNn73VR+BFz3ptrqYasJBRoL/Yew94JUiPewZuCrOjxwWEOFjkDUN/8ytqv/KeJte2o3JdyZLywH9dUbxNXbbDziCcEOvlFLDR3rSF6rYJKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CR/BF0009/EEBUFsc2MzjhifXTtjULvzLx2o2hXLpFjDJLYgCKCPVO89E1gG?=
 =?us-ascii?Q?oL3T4vItBaJRv9ku8fRpaVqTlrO2NkpySPxcNwIvBqMZRm7vqns7NnxBc8ny?=
 =?us-ascii?Q?zCycBz+hBxXOkJyyh1XxfM/bua5dExnvJV9/LsM3tw0831TMZtrx7P2/QNXP?=
 =?us-ascii?Q?fxNcCZ8WiUsFszQqmvv9o8A0wBK9VsM6ddEtbQq1UDMrVSKdXUj7HmvxqI/C?=
 =?us-ascii?Q?RK6Vi9JSpmJqLSJSNnjDI1byedJAvfB2QfXn0JPos1ejjEUi2HtZ6/MeJj8v?=
 =?us-ascii?Q?k8yA73rfxyaVh3cAhiPcQVjoMFG2071OeYgXYZQfr1PbQe3poS5udrn9vBzP?=
 =?us-ascii?Q?LuLr4oi7KyE7f7FD6JgQ/80a2ZnpnXaEqm86RPw4cuZa2wNriLeDHrGs2UNS?=
 =?us-ascii?Q?UlGXTgeS73mfeKeppYB+b39ukKDWD8SN83enN7zZar41KLZhGDuB1GSeJeYe?=
 =?us-ascii?Q?sU/kECcXA1/ObEahDR8jGjw2RNEVKIIulBZk+iCYoEE5QUaVIBsZpr0Aef6B?=
 =?us-ascii?Q?oQGV44f6q48sKyiPWgiEJz5bt32R3iF4mNI5I0kxccs0LuYp/oY5BCQxhYHC?=
 =?us-ascii?Q?NrMvabGg4thjKQhGhnbSUSpMlzecsuiikh8EFt8NfZEV+YWtgMNi1/KChi10?=
 =?us-ascii?Q?pZnnaIC9UWwem3vN1/zf5CmflLvesb6GRC86yekKV+VyYmCGotG2174/gBe6?=
 =?us-ascii?Q?zv8FrDTV/lPTC/RP6Pk4o59lUKq+YkL2HQlzEt5PoDtGsHXXCUt7rT6JkFST?=
 =?us-ascii?Q?ksm6YihXZ9RwHYi3YJ0KjUN7ffZhzLNm8aMEbDf+CM4pAjgTW9CH+07wHQHx?=
 =?us-ascii?Q?Nsy03HUv+KHcXMHxnX/5XYSZXEHG9Y8iE34AGx+28NQ19OcIccyYz4iN3YDo?=
 =?us-ascii?Q?CoIs3gfq1OPBXlUiDk8el0bPdCdMMSnyF9/q/PtCwgcVNblC4ha+Hgr3CFIC?=
 =?us-ascii?Q?b462sSheVw2qLd/6CuZjYnVJXPoRpfspRUEi0mZGDJFkOSsXRgIdQfl5lJN2?=
 =?us-ascii?Q?xs5hvubr98hR6eVNwDNci2DjC9wleKpeLI9EZqDS3bZyO8KltlKl2W9/C2hn?=
 =?us-ascii?Q?B6AilOrzzaHtffHVFsNrQsUY1/9323BYrTFUjmip4rslrWItcl/v6U7JoWSk?=
 =?us-ascii?Q?dBJMomKrG3khLat4RgWwcr0Tw1IpxYNs9jfOzCQFL7NERsxAEcHSz3whOcMk?=
 =?us-ascii?Q?togfoZLmSPWe2SNP/EnBlVM1Xn3OThOgPH+MeXBnIiEjzz2pfD2yX8e9Xf7G?=
 =?us-ascii?Q?+83c4W+iYkeYCT2Mdip1xbN4Tw2DxgB0U17PJTNBd/Z8LkT/jyoRdMxhIWbS?=
 =?us-ascii?Q?K61wacU85neJsOUeWdJuUUiL3Bntb6yE7PgysvKDrU4EAdku8DrHMBjJoxVk?=
 =?us-ascii?Q?VB5a8rcDy5PnG3VKJohVgUCcznl41M+w0t+uq6TQ9UD8KCtvSkwKbrFlSXAs?=
 =?us-ascii?Q?rXCAKox8vD14jncqeOP80rSXqa3jWjTTyS75KpoEO6Qu38hqGbvvBcPP6cdT?=
 =?us-ascii?Q?6XWzhcwD1wPR0glz3o/3bGzRXENY9b74y4p4PrugDvAYNFZtWGMQEzbcf8Th?=
 =?us-ascii?Q?iB+TP74NlUiPsll4jygXQIApxPv1joLoAAenVNUjrTGNEqO30wYa/Sb2vp7h?=
 =?us-ascii?Q?Vyx4nHkScWApiCUb+8Uo/4USM6CrBTZ+Yrq4mS4aE5ibqL/4OCQx65bQZ9iU?=
 =?us-ascii?Q?IboM3qTAWkgHQYQbF+Bp5mLo9Lefl6g5oli/mFRwjQBFm1Y9zjDaz5d2JoKP?=
 =?us-ascii?Q?l+lCzXwcso4wwjdD14CCPtFuFSJYF6Fkm2zK/DgeorvTyIbKc42X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35aadfa-72ef-4517-2152-08df4ac01152
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:48:09.6253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn5+Ghq6SrqLI2RDlI9aBVhrUVicfMIMcmwktik2qujmxs/s6pOj/IwQVhZaesxxPyKcU5kyNKrHLuX8xnhMmcOTNkylvmMFaYo2alPfPbaOMaIMxbf9hBRO2Q07g86T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 09:00:13 +0100 Max Merchel <Max.Merchel@ew.tq-group.com> wrote:

> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> Use 'info' instead of 'infor'.
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

