Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC14606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dIpO0tGF;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PXwdZ7k9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 753A240642;
	Wed, 25 Nov 2026 07:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPmFUTYylQie; Wed, 25 Nov 2026 07:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 851C44061A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795592641;
	b=afAona7ncH6yFIejgCU94yyOgiR/L0bLotInNI7FN6/85J/RVSxwgnAwoQ5of+/n3rlt
	 HIgkleKSaMbxT8OEu1r5RJg2taxKkJfSskjG+Csjum0uVgZrApBkJJFJc9B7J6rKA2uGo
	 pZM/3O+FR6q8Srqtlk+Lc55syZkSg/2IlZ5mcQ0DyYZbJxoGzdxyXK+Ga66OhHL8yXJLn
	 BNDjx6ArNKOUmVpoKxQH9ZboJSwQyNvOvAZeG8jb14Ptwda6XMc8rcp/HxUs2cNJevcqs
	 V4qQdK1x34xq5hReY6d7+aYjHTTKkEr2d329fPs+KUjqLv1xmPpF339kzdDPz8P5DWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795592641;
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
	bh=H0Xr4WbKmZr/1Zhr3ShwnUUFjNCU8w8IL+kJ+oANIao=;
	b=h3ySt79dXfpUWQJkFTMqgpwuR8xp4+QiI14D++zpkI1+cTysonriB7SCE2JsfD/oAocx
	 lwYpMllZ1YjODujsi36fwwMLJDmLgkCFTRxJpUgtPEzELLrmnZkToaf3AEh04bwTRUwIj
	 so8/9xkihWoBLzsWIJBCTzFYmMqkxxO/nmZ4d3TGhw3Qo0wC1Ecrh3FQ+jZrobswrSo7P
	 MVkubk8zwygaGVoPNN2G1O81NW8XUMNnRGewzpL+1ohUuS9vfAq0w3hn5hSBAaRYpSU8h
	 67302PQWNDJ8J4YOBeJ/EQQKLnpVORZXxwx+/8uvY++y6JmSb8/zWy7lZt4uLw3u0Ng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795592641;
	bh=H0Xr4WbKmZr/1Zhr3ShwnUUFjNCU8w8IL+kJ+oANIao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIpO0tGF534A2YKnIYiDjiibPVppiW8XnaDYoHtm15+PdtV3Ub9tpSJRiK5uX8Bf9
	 a94mDfdnhKLrH0R7Wp8KVbE5+7GUBWZ+2zGYldHwqMZcZsUD6KsnkSJYs/ONJaT0yF
	 IxAvrwyPKvhv7yk8a3z0TCkuFA8bhvmugHuwoR5ZkwxR8r0+kE5ZE+qZobd2HEUou0
	 3KbP0CA55p+QJ0kGKpq2ESIUiFQ2ZkOkK+yumYERPCOgcod9f/rCEM+JxU/XDYorqs
	 AdBwjjX4GP2UX18u67plEQovmsQi3KS+KzTgk93Cx5kH8wrAON8UYMQCeoaiaru4et
	 fSBhkyRFhq33Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 851C44061A;
	Wed, 25 Nov 2026 07:44:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F36F71C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9510605DA
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3go2OOLXd2S for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 07:43:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D2D6B605D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=PXwdZ7k9
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2D6B605D1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0Xr4WbKmZr/1Zhr3ShwnUUFjNCU8w8IL+kJ+oANIao=;
 b=PXwdZ7k9ktlkBN73SoV40wVfCl4VBPVBg1irhBXgVz/th3J/d/ZPrxS5RiIXu3i8DXrQOq4T7CGBGGZa5m8Urnb7x40ytJzZWrx5dnwkITvMVOXQJalExrrhU0Oa3uYcZ4gMkj8c8TvqLUIvXrFE5AQrQ4UPVnwvZFDg6Te8IEN0/AXnagMYGEZYH6RmaBPe5CXnr4Vg9EkyPc71CpIXvIloTItyXckm2P1Br+GuZ3orhar0Hd2i+kXA4zKTMKpLkbCdCaKpN4uvXxenxpb7sP8D31zxt34xWkA0MqYSQ9Az3Yy4R0iRxoAm1piZskr3pR0zA2mxa1Ht34XN3CopJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by CPHPR04MB803254.eurprd04.prod.outlook.com (2603:10a6:380:105::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 07:43:53 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 07:43:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Xuechao Han <fragrantorchid@foxmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, u-boot@lists.u-boot-project.org,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] mmc: dw_mmc: support the cd-gpios card detect pin
Date: Wed, 25 Nov 2026 15:40:54 +0800
Message-ID: <20261125074055.27624-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <tencent_EDB869F35E344CE2610E36EDFD771EA82408@qq.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|CPHPR04MB803254:EE_
X-MS-Office365-Filtering-Correlation-Id: b665b6bb-3a21-4307-2db1-08df4ac7da87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|23010399003|376014|261022105027099003|10067099003|261026140227099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: VVTcukuH+XDPvxK5awNEyNjYwpcF10sUrYUCZ07JVNhoPFwWhnfL5vF+oD0LA3xKqNAPv5VuIhSiaEKPb1VhLXNzOrk/JtVId923dyi4FDsASn+6n6tA12mc2nm107NGoPnjc6pi9EF4wnwJc5oF5G3c5D4zaWS2HVfMDY3RhEWHZ17Bt2jJetaoPuyimoowc70SMntFDPZeiloDYYbkV/4dLCHi+KG/4bBAsPwsm39Ijbet9YwwjvitY46i4Huasv4WXN64Hyfjxpjr+ry27rg0WtqE27CldmfwoMztzQS6sRZv2F7dHWLp5qYEu5IBudc6HElNQ4krgHruSJyGKgjcSf9JM9tgTGuYJvDq1OkPACHOvvlWQH3EdNCTzLcBwbZt7ym1QQQwuPO6V6+GzCQHbzxryjtJ3Ya6SU+WSOsoC3lioZzc4wErOcn6yEg63R7NoZdX1qiFOQsYfDOSuV2oGWqCbGhAYAet9E8069UOcuwxJuvpkfeKabV8rWuImT6yXyIm57C/6JVkCX2yYbw6vv1ZN4o6dHM9ktuZ8pKzKT7IhANVGUtUUyuLzgkES96x1zjX1MN9i9WH0QbFstJFn9hc5v76RsdsRRLTVmwnS7lK9DEcxxs+9mXNdS+Q+vMswKuuC5+TV030XMiP/t1GBSk0155s0PAIc1vpYRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(261022105027099003)(10067099003)(261026140227099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkdRZnggF/tWZLTL2+vt/K8jc4jFCWQNJ7kinFY2t7yUcPZXM3AYp3px0XiT?=
 =?us-ascii?Q?tNHgYta7r4Vuk60H0RM5kjwHXis6Ig/2C1cEvT9drp/yTavGgro8idKS7rnj?=
 =?us-ascii?Q?ZcRHGod19AE/YnXi51d7U4GChTKNDjoW93PxooiILgyQ+8sY0t7MDAoc9ZB+?=
 =?us-ascii?Q?EcHpJ6wwsuP/uBN+jejyIlC2tJvqD+ujD39QPr6C9E465yYRKqKI7OeTBRR7?=
 =?us-ascii?Q?p34LyG/89Wy5xOTRkN/ONWWp7WHzY/CsXnxVK2YxjSz1A8ifiCno2XcH1d9y?=
 =?us-ascii?Q?NlS8f7S9Pf8v36NXrZNvPlieMGE3kVRflzswZ6pryaEOJFldAkU5BMth3ds6?=
 =?us-ascii?Q?ij5NmTGFqx54Akd1hxD8EYiB+aH/BQKrX4QWNA0StCp2Kt5UDa3rtyaJNava?=
 =?us-ascii?Q?pwXgFu+NJ5qIwlOeebUzsrFPecoRC4Ge39U6YPiEYngJafW2o6UlwnyPoObh?=
 =?us-ascii?Q?uBIGXEV6ODPuw/hJvzVWZXxd7/MEu9a2AGgi02ZoZ/Vnfktlk+H8Ah0tobb1?=
 =?us-ascii?Q?H0XznF6QQuiSdtjlPMYkmlefdkwiXsyjfv8Xesg2+gHjktJOA2lqNdN/RizM?=
 =?us-ascii?Q?Z5JopO2riGsuT93g6YqAuVJhuCYwk86mzR28ywRxRFlAEV9i2Nu4Wsej20yX?=
 =?us-ascii?Q?4O8syaFLaKnsvDS4WXohJOQfajzlVys5j7zSFOljHOQMSGrNXoU+M0ia2c3B?=
 =?us-ascii?Q?pD0uwN6wxv99ipE49TnKptKdsSJgyErIlUU7nLh4uvLc9JfX08C3ovkpw74z?=
 =?us-ascii?Q?e2n22RCA6stsyueWyZFECBGgI6WmnysKHiV8WMLDh/6g4fERG6Fz5W9MjcdC?=
 =?us-ascii?Q?fuLxJwzxbwJAxmg8oCedWaQiPLQukyHpvcn7UMfP8sWuQ+iwHZIO31Vrz+W2?=
 =?us-ascii?Q?dFST1b//6pMnqkidQFogoQk4gRHYZYAJu3cNkVTbCsFCi/bCAyDhFpjLaQ/K?=
 =?us-ascii?Q?87giuyIwLGMYsDMOAOd7OLbsVmUtfs8lqxWNgUcWCSMjTXtiY99EotwDzX4I?=
 =?us-ascii?Q?O3ydlmDiIdesKRqC8wplzocblVCDGyYb/LRXVIwCb+0ypaBpSSiOTSTh1qrn?=
 =?us-ascii?Q?0Pi18g1yWGbNXBdR3kdrkTxx9xHy35X6rF604OcIZb+w1BRRd0vchSSK4E4T?=
 =?us-ascii?Q?Z0SbPxbhibnmg6mbazebEd5CBSGnkEhmBgrsCI819Xn9FMskssyqCgzP/HBY?=
 =?us-ascii?Q?XJt2SbQzxaMoU1sr5ZqHQrM9HBbMU5JSxJys+WbWdYMhCQtQECYtu+X6VFKi?=
 =?us-ascii?Q?axwcbtCxcBVD6b60PwAmXlYTE9Jd2eQwh3Mpc739v1tD2iEbm+K9OxzNLcxR?=
 =?us-ascii?Q?s2/m53sXo7EXBOthomcdrDqM1Fow8u0usecy9DguPzx2V6aCTDClRnKNkubs?=
 =?us-ascii?Q?J3H/a0WYPdwpqmHkjJ51IiNHc76U7G4cS6l+gmKzvMHv9uHmzERDYWptn1Bd?=
 =?us-ascii?Q?n4kLA4cXJe1q09cUbw6LMsOtkxDEB8tUDiNJ+h/LO0L1ah51v/INhpTG0Yzc?=
 =?us-ascii?Q?ALo/QHXe+UZ0GylD6bUOcE2JEg3zq5q/BjtvFZB6QuxSfLbMsBEjh+no+/lh?=
 =?us-ascii?Q?FR3q1h/mPPOxi39ivcLJcd0qBkqm+1qsyYpNfBubTts8NOqnAash1k1XOYFd?=
 =?us-ascii?Q?jwgr+1KEdGMS+zCuGKfkmyzEWuLFXUAfsMZMFWIzXj1EfTiI2Eq+wbywdrQC?=
 =?us-ascii?Q?2G9lKygAEgiFJzbJUp0A76HJu/UgRApEzrR45i0ZQh8hDFSKh7IHuVRfcMpo?=
 =?us-ascii?Q?oV4dTIJ/SCHMz7NjhzUWUnt8nj2d0SBsFuHxVvfsT6/uZ6HtIyDq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b665b6bb-3a21-4307-2db1-08df4ac7da87
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:43:53.8357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOo9k0uOxhaGGuMuvCsqetXjQiO5gu6ak6PzZE4Qx0bWYm2+cfR9KuoD9RH730u/RdSy7qJHLAhq1WXjR/uPv4I/ilIV/5ylnNNEbrUK6yI5lrVx5qMyOIM0HEuoit2p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB803254
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

On Tue, 24 Nov 2026 14:57:15 +0800 Xuechao Han <fragrantorchid@foxmail.com> wrote:

> Rockchip boards route SD card detection to a GPIO rather than to the
> SDMMC controller's native CD input, so that the controller can be
> clock-gated while no card is inserted.  The board device trees mux the
> detect pin as a plain GPIO and describe it with a cd-gpios property, but
> the DesignWare driver never looked at it, so U-Boot always assumed that
> a card was present.
> 
> Add an optional get_cd() callback to struct dwmci_host, implement it in
> the Rockchip glue by requesting cd-gpios in probe(), and report the GPIO
> state to the MMC core.  When no callback is provided the hook returns
> -ENOSYS, which the core treats as "card present", so existing users are
> unaffected.  Failing to get the GPIO is not fatal either: SPL device
> trees only contain GPIO controllers marked bootph-pre-ram, and in that
> case the driver keeps reporting the card as present, as before.
> 
> This is not required for booting: without it U-Boot simply assumes that
> a card is present and the SD card still works, so the change only makes
> card detection follow the device tree, avoids probing an empty slot
> until it times out, and keeps the behaviour consistent with the
> operating system.
> 
> Signed-off-by: Xuechao Han <fragrantorchid@foxmail.com>
> ---
>  drivers/mmc/dw_mmc.c          | 12 ++++++++++++
>  drivers/mmc/rockchip_dw_mmc.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/dwmmc.h               | 13 +++++++++++++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index c2424d7875ca504dad1698f1d4ecca343d7cc77e..732a60c8f43739f5026fbb41ec70ff1f9fe188e0 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -740,9 +740,21 @@ int dwmci_probe(struct udevice *dev)
>  	return dwmci_init(mmc);
>  }
>  
> +static int dwmci_get_cd(struct udevice *dev)
> +{
> +	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +	struct dwmci_host *host = mmc->priv;
> +
> +	if (!host->get_cd)
> +		return -ENOSYS;
> +
> +	return host->get_cd(host);
> +}
> +
>  const struct dm_mmc_ops dm_dwmci_ops = {
>  	.send_cmd	= dwmci_send_cmd,
>  	.set_ios	= dwmci_set_ios,
> +	.get_cd		= dwmci_get_cd,
>  };
>  
>  #else
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 7a72abaa38a14a454cb27095fae40aa877b8050a..fba1be4971c9095519aa4acddf5805e065f71410 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -29,6 +29,7 @@ struct rockchip_mmc_plat {
>  struct rockchip_dwmmc_priv {
>  	struct clk clk;
>  	struct dwmci_host host;
> +	struct gpio_desc cd_gpio;
>  	int fifo_depth;
>  	bool fifo_mode;
>  	u32 minmax[2];
> @@ -57,6 +58,31 @@ static uint rockchip_dwmmc_get_mmc_clk(struct dwmci_host *host, uint freq)
>  	return freq;
>  }
>  
> +/*
> + * Rockchip boards route card detection to a GPIO rather than to the
> + * controller's native CD input, so that the controller can be clock-gated
> + * while no card is inserted.  The controller cannot see insertion through its
> + * native input in that state, but the GPIO can.
> + *
> + * The pinmux for the detect pin is part of the controller's 'pinctrl-0', which
> + * the driver model applies before probe(), so no pinctrl handling is needed
> + * here.  The active-low wiring is expressed by the GPIO flags in the device
> + * tree and handled by the GPIO uclass.
> + */
> +static int rockchip_dwmmc_get_cd(struct dwmci_host *host)
> +{
> +#if CONFIG_IS_ENABLED(DM_GPIO)
> +	struct udevice *dev = host->priv;
> +	struct rockchip_dwmmc_priv *priv = dev_get_priv(dev);
> +
> +	if (dm_gpio_is_valid(&priv->cd_gpio))
> +		return dm_gpio_get_value(&priv->cd_gpio);
> +#endif
> +
> +	/* No card-detect GPIO: keep assuming that a card is present */
> +	return 1;

1. provide an message, not sliently return 1
or
2. return -ENOTSUPP 

> +}
> +
>  static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
>  {
>  	struct rockchip_dwmmc_priv *priv = dev_get_priv(dev);
> @@ -69,6 +95,7 @@ static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
>  	host->ioaddr = dev_read_addr_ptr(dev);
>  	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
>  	host->get_mmc_clk = rockchip_dwmmc_get_mmc_clk;
> +	host->get_cd = rockchip_dwmmc_get_cd;
>  	host->priv = dev;
>  
>  	/* use non-removeable as sdcard and emmc as judgement */
> @@ -139,6 +166,17 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
>  	host->fifo_depth = priv->fifo_depth;
>  	host->fifo_mode = priv->fifo_mode;
>  
> +#if CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(OF_REAL)
> +	/*
> +	 * Card detection is a GPIO on most Rockchip boards.  Failure to get it
> +	 * is not fatal: SPL device trees only contain GPIO controllers marked
> +	 * bootph-pre-ram, and in that case get_cd() falls back to reporting the
> +	 * card as present, as before.
> +	 */
> +	gpio_request_by_name(dev, "cd-gpios", 0, &priv->cd_gpio,
> +			     GPIOD_IS_IN);

Exceeding 80 is fine. Use oneline.

> +#endif
> +
>  #if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  	/* Enable power if needed */
>  	ret = mmc_pwrseq_get_power(dev, &plat->cfg);
> diff --git a/include/dwmmc.h b/include/dwmmc.h
> index 7e1a664651816872c87024208fc78cbe9ae7b1dc..11a7a78e26f77a9bb344dd7224790b2600e4e275 100644
> --- a/include/dwmmc.h
> +++ b/include/dwmmc.h
> @@ -226,6 +226,19 @@ struct dwmci_host {
>  	 */
>  	unsigned int (*get_mmc_clk)(struct dwmci_host *host, uint freq);
>  
> +	/**
> +	 * @get_cd: (Optional) Platform function to check for card presence
> +	 *
> +	 * @host:	DWMMC host
> +	 *
> +	 * This is used by platforms which route card detection to a GPIO
> +	 * rather than to the controller's native CD input.

> + If not provided,
> +	 * the MMC core assumes that a card is present.

Drop this line.

Regards
Peng.

