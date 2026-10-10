Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2124CA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 07:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 559128146E;
	Sat, 10 Oct 2026 07:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDvtqsnaIw35; Sat, 10 Oct 2026 07:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64BDB813F6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791618946;
	b=BTr1FRaJ00jxDEwvTpEjFqNFnJXIX0DCHaAycLrcKTrkva3FmukNbDiFSIJ3dWup4UBr
	 r5XcC895Yc3ZqPBygx4E+9OoGt34YvZ93fOH7HGbnErfU5ezfcL7hPuJd/e7Df/RaCrrh
	 5ZAtJTLwkBWvzihA58YClyr6A+yeBMnKsMJw1rZf1t5ZyQHbwFwQvJBh0EHWRHgsvt7IO
	 dJUYfXW3+VmZGkxYv3u63eTmR5wUIvD+FFW2deENhZ7SAI6tyMWlEbCXZ2jkE2NwE3Yzf
	 gXfYd755G3tE8jkPgGcNVlBIHsAqjmdlnIjOhutJdfNoSsDvujxnwjgCRqwuFJ2DCrQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791618946;
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
	bh=o44j8VSBqdQqETeWHSbk6mgXj6u6ugtVMt8jP+BXqb0=;
	b=lC8oKKSR23MRz517sc5Ds/KtmiDg9BxWfg4KgP+3Y/aahmWjUPkOBRjFQetvRlQR2QOG
	 9a/OT24lAFeAsnp7rZeOlqelBFKstB+YIx7q0BuPufH1DOxPFEhavPv0A5eg2rosT1Jq2
	 bBYYB0b4G6SosTOLhfLxdQ9+en8kOxhBl8U/eIRGN9AX6cIBzP9sRAod+9cGu5aMx7VtN
	 rneLENcgRT+ngcTZUO0izBUQNJ1qBhVENohYqCqP2UiN01qipeC+Xjfog+os16vCV03D8
	 JFm42H6ItV3CdQXsyTmz2Ot94N0/4ctBqcBe/wY8Ka+L//1ZXlIjVVSqhVz9K+qMhuA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791618946;
	bh=o44j8VSBqdQqETeWHSbk6mgXj6u6ugtVMt8jP+BXqb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AiXpmFV2Q8CM/0Ll9stytH689M4zzYkJbIsJ5LrtXFbD7f5D1sZZXa1xgjTxA/j3O
	 E74Nzomyv4Z8ZSMN6WFe1ohgiCk1cVJuVH2j1Pf8gUk6sEdm3MJCnEbcWi0TM0F+hC
	 ALdZLJ+Wt/HBCeTh7/xjsHWJNdgQm3SHfycEIjJ5M5BBbQMhUmWGbJOfIJACoOvTHX
	 8zaqLTSM+HBObWzPRIcK/zEMmj/6NmS8ABkElMRXLo2YdadpUlbMr/XZbhNyDTvZUu
	 LjWZPZf+vckQSw4z1KL6aJwS4PCn9ol+TXos6NHEHXDYrGjFqQYroAlcphtkubIvnd
	 pkWIsirXW1eCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64BDB813F6;
	Sat, 10 Oct 2026 07:55:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F6F7235
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81272408F7
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uPggfDHYXNKP for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 07:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D691408F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791618944;
 b=gKGKXKqAAaF8ZFKpXVMr5c/Sv0+FZzPxW96groyU2ZLhie8vQLCIuDx86hr72KdSpx4e
 pyz7t37iLixJfhrIGwBNSX8wxKi+F94g39e/z302t7fVIaL4N7tDy+Ul3Nohfh1/xxuEe
 PazpvOzL2VaBqd9FUUDbZ1dtNrg80w8gxnDe/wLxTjThCgYuNFvD0TsOdCPeDHmkLgLmu
 lUK0B5MyLqghaE8YXPzPraU1FhCcThB2KgsKlUEZt7Gf6vydYZY0mMHkAajmXCP+tMBco
 MMDK1EKxAUDDae5nw4XyO+ZWi84yRT/DdAqKC9+jmQrfbL0zz1Vn7YqyeefG4uSIg2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791618944;
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
 bh=o44j8VSBqdQqETeWHSbk6mgXj6u6ugtVMt8jP+BXqb0=;
 b=DbPBwQHME/kSyVQdP1G2iTxeW7kUgjY4ShBiDSb8ZlBogMXjrEWJLcvvgN7RV3o8Qw7r
 GTc7ORtqF0Az0aElhLHzC27l+te6pIEYO74bjFYw1S1oklsM1BhoULswYTPvu6lktlJQ5
 wgZLvSFKBvrNMiLvriqoDi8jDH9QuNanTZoPs2hUbghPunjzxn01QjnBYP2SeBVBJ2UH1
 X9QnpXHQA2A9R75V1aTuq8Krve3OeZQUfepqaBM4gYXKQRwoFaV6u/FkitplQ2aZADLiu
 P/D9AzIxBAiiOYK9fi4+yYkvxPFdBzR1iKQFU/u6r0GY90OMtZL1E3592Du2l2HFzdg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GteD8685;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GteD8685
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D691408F4
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFifIqX4Wv/m8GZwKT1OOpAjGKc82O+mjYp5MF67GoBdiOEFrGMwHTZ2606wQ8ap5u/cXLm/dlJprNvTWWZ7510OltQbeRL5Jpry4QVfhAV9GHzennMvdVVtAnuAZJ/vJ/7gSQFc/8/u695f5tXSr/w9fmP2amPcQ5Z4Ms/7+bIBj6+n5WI2+Jelz5QzZfw6sMDmP9OqR355i4vJDj0TwGMHg3MEVnDefYLbojAHLO8LAnHxUNXCHnmLYETCjqrRBdS5LpbNr5RSmYLcnao0fuHZMS8tBzYuf/DidF+qwNPOkdOJ0jzbJOIenHrUJHUtX3lRJzGNI9ddoMD/g2M/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o44j8VSBqdQqETeWHSbk6mgXj6u6ugtVMt8jP+BXqb0=;
 b=HRycZeO+qgEypr8IC1KZbpx+6j9NmaB1PdnRTRGDy056q6VCxHcZ/AbZeH2nHMMnYdABhCxwiq9ocZkupz14+yd7Cg741RKLtkxwd0w4Ea0lZV4hFhpjKqFwA85/2nD2O2SYKhzsshFV78XOKqTV8NrDDyxmpk1gPdDOajAWPW1zh2eMt2IxF8Al2druq+aF0pRUT0l0O9PCWJhTEG38x+Ip00RWdItbKVYy3K58Xv8T8qvKq7VntlTpvkpIBY5M+9c1fe1ZxiLKf0lnSRqpks7iAcwL1fotQQpp/yOSJ7SHclkM+l/JlET9g3zzO8oamMgShXW7sdGzlyMqgq7pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o44j8VSBqdQqETeWHSbk6mgXj6u6ugtVMt8jP+BXqb0=;
 b=GteD8685PdDyRotieRUI/lPkZheizLqFElVzFho+p3o/KI930DVnivbTywCbwLCSxVMr+sJxCOtM+IzFOnHHn4MqwE2xnOZm37ku/+34zIxSZ7gly/VzElzn89vJMKyjV8AWH13a77bMh8U8Y0R6FWKAEfy3V+IsmR4qubIvSXx/2pvJAklbt24hqiUTROi2zqzvnIOCnQWybkN+jCuW6g9TdGNqzxoAKnFZ8ABC68QiHZwxC2Cas2vuBUfWVbNWyF49aMs0YyvBMFNFUgusNE5hXA9iaoqqPLo9wMUaqwv/oFFOcx+MDZeLplNB3E8GJ/umuVQgjaWZa+E183n22A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by AM9PR04MB8569.eurprd04.prod.outlook.com (2603:10a6:20b:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 07:55:39 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%3]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 07:55:39 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 2/2] toradex: {aquila, smarc,
 verdin}-imx95: Enable caches in SPL
Date: Sat, 10 Oct 2026 15:59:51 +0800
Message-Id: <20261010075951.3939861-2-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010075951.3939861-1-ye.li@oss.nxp.com>
References: <20261010075951.3939861-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0136.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::8) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|AM9PR04MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6a9a26-7ea9-4916-2a5e-08df26a3e05e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|261009223027099003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: UUyCsGbBig2SmcyqYD6+bcTBR/fu+qCOo2mjgQNe9e03lF6SGi8BaWQkKZwpL84NIxdCq4KH91r+5b7OQqKHqwbXznxtx4NCDr1SWi0Un/+Y7TGJc1acBzCvYnvOUZuv1CfW/wIg97kEFzIcYv8Enc4kIuMzrlpu3gUten6QRhkdCyVFkYApl7cgB57pLB6p0I7X3At5k577ylzuzlBqDpkPQZQzzg92QcbqWeInVkErXEbR1Lp//beuKVNWX9TheS4gzfPuHwVsJ1b+IF9moHKckx0GFINp1AsSrDXwMIYBJFeZsUMKzUPHbNQXAUnD/51ff+971zSSe7pYRzNzAV7PI17BX/8ScznhHorllAm5ftat+l0s7UhwpK3g+bHP6825zHTth/os8Gp0XsWKsII+s5mfUHbBRQNo37LkxtVn9G7SVr+KETEjTIC01JQ+aZK5CWX/7qrS/vFtqO0A8hrwWHjPnEAMRuxjg0VNdErJXqxMhuBuQ0dgtiLPvg20sK4Tel5aOUmH9jw0RA70LnrhJQ6XWymBhmgGzj9u/XOC/ZszOc42Pu6Sof154jXgcNK3OT7tBgAMZU5rxYJqFwKnT5VJp0xIZSF6YF+U00GwK4jcpP2Apo6NTU7gHp2hp+kAWfwAgFIpJheUdr7mRc5bKrQafipb5G9vJZUngQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(261009223027099003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLrLieAA4EAKZcItXRWSF2q6Ji4CgL2GRbN7RErPbyMpJF5JkttbIKAdJp43?=
 =?us-ascii?Q?UeFCrSi+WtW562oU879obc7aRypiKskZbXTRBCK3QTdfsakhG+mGlN9o3aen?=
 =?us-ascii?Q?rDxbPg0swEPhc94LZUfHEW+i8Z8MYZUAIRS5q7cg75z4aQlwFJdPRrLukiy2?=
 =?us-ascii?Q?hSkt5gjWXsJgj94nmot4ec1tX2cz2B6YLpQa7LwFq3Wk2Q38I/w3P8igOKzH?=
 =?us-ascii?Q?2Yxw9rz2sOZEvfhdfaRnfQJg0g43vElYV4ZROvJEp5CFSq5yaMYAyQiXHRCh?=
 =?us-ascii?Q?lIFWl87MDuC0XOf6FigwtXnafo0gCkvezpWroll6gnC+Lv87Zy7jSjC0DZG6?=
 =?us-ascii?Q?jtVzgp6j/ta559baHHLFy9m2Bpwdkq7aEKwfguECYiSq3oP85bmauZGwfPxa?=
 =?us-ascii?Q?JOq/xxHoMBGpbqnaS8aqZYUkmHHz8r+0VPc+UINoSJ4i/FduXh4LU4c2RVla?=
 =?us-ascii?Q?To0daZ5lePKg7tlDsIDErwQ04dnpF893n0hm3E7SiH+40IIk/bbWx67ewzxq?=
 =?us-ascii?Q?uE/rJFXt6NR3klwcQplz+BSM9LuYROtlw86IEkFhk0o4cgIwqNJvzfStOQ+n?=
 =?us-ascii?Q?BPbiVJVfg+vvUbjh7MU2imOx7PnxUPxMIZa1kd27hvT70Up4nErNymm9uhel?=
 =?us-ascii?Q?p1YgqCQF+d2jJzTlozr27UTv3a+Oo7qkslRxmy4DGgpcynNgUlJoEfB3F6dE?=
 =?us-ascii?Q?ygHzmStyAtX/l5FEdYqm3JV+URr8ZTmz52dXOnCPHzU6ZjDzpgU0PjwZCo2S?=
 =?us-ascii?Q?oIcimeTDxsQZl85nAQHkD4ii271AkY1qsr5yYmDheFArzRL2io3GitTuG2Wq?=
 =?us-ascii?Q?WLBNCNa7we8IVWkylO6/NGvpfZqUKTE6Z245lweIwDm9GEbiqDzshinDXqmS?=
 =?us-ascii?Q?MAyjcAkYTnWjoWPJdYBtPg+UXuFXgSUf9399rzRPfKL3aaB3wXm9ZgrYIOqz?=
 =?us-ascii?Q?GO/2i9ikay/Vgrb32vq0XFD6JhHAg8W13pRA9lsHNIM09Y48l9cY71B2h8T/?=
 =?us-ascii?Q?cHSJeWHjaUj+0ExIY5amsMk+SEu57Oc/ss3amF89PwOBojJMKtjmMpAir6Tc?=
 =?us-ascii?Q?9/2sN3n/ygIt7UlkgRCbEEoMIpKV7skJCAvctR5+NXNtEe2sNL2h8RrIjFwM?=
 =?us-ascii?Q?cRSj/IhVofLIu+2Jj7v0CSLcTXay3h6H2eXpOoWOtU0VtZS+XZfAJ1SUpxbL?=
 =?us-ascii?Q?dT2AaGlYMlGjeNzM7KeKT9kyk8p00NXXmqk/9bC/N2p9S+ikFLB7YNajBEY0?=
 =?us-ascii?Q?NWsR+ou7kx5ULoT0pF2TmXmGA7bPym+9cmLmxis3+tGMQR2Y4LMeSO2H1bNf?=
 =?us-ascii?Q?QBW1IzdTZAsQp6nONEECyuzn8ros6nxj9EDuUD2SbqMVR4op5Q0i/I1IQ3df?=
 =?us-ascii?Q?EHHyDVypnM4T3QbZ3gotGNVLOo3m7hdshjVmAyKylvZA+Y0p+qvtvCFJibqh?=
 =?us-ascii?Q?Ir3dX/dm3laCIUWgOwGbC4kTjSJm00NkL+MKcr1H+Qu+68D9FBJ2j4ADXufG?=
 =?us-ascii?Q?kkCJqjsJihhOsaJ+lgs6CK7ArWMJqZGoYcFhv02OSvbXfxgmvXbagLecyQ++?=
 =?us-ascii?Q?5SZDNxEHcwrOy+TM1/EsHHxiqN8Y1VlgN1CPGTXoBeVTRVqHm9jt/EZ461g7?=
 =?us-ascii?Q?NgNy8KdCkIdKGzB+lUDKRnGrGurnRwfUQsuBYm55a+QNo154QMfMLaAK9nSV?=
 =?us-ascii?Q?eexBGfQNm1qYdUZzm7OPeinK4ftB7GNpREEhNENF3vdZ1ooa6gGkagnvvaFw?=
 =?us-ascii?Q?+z+EB7g91PAx/QH12cpyvpkpppmYntw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6a9a26-7ea9-4916-2a5e-08df26a3e05e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 07:55:39.6894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0BNiKOQpTSMG4GrgjaNtaj8yA6BZZWnZNZlDlpIx33LkR7PZW3GdWTrQzaIzEg5NYvB0wW+CvV2msyCfophSfhYpUQEK5Wu18UXoQsNijw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8569
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

From: Ye Li <ye.li@nxp.com>

To enable icache and dcache in SPL, add the definition of secure DDR
space which could be accessed by SPL and move arch_cpu_init before
spl_early_init.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 board/toradex/aquila-imx95/spl.c      | 4 ++--
 board/toradex/smarc-imx95/spl.c       | 4 ++--
 board/toradex/verdin-imx95/spl.c      | 4 ++--
 include/configs/aquila-imx95.h        | 2 +-
 include/configs/toradex-smarc-imx95.h | 3 +++
 include/configs/verdin-imx95.h        | 3 +++
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/board/toradex/aquila-imx95/spl.c b/board/toradex/aquila-imx95/spl.c
index 93e76be6145..31730fc22c8 100644
--- a/board/toradex/aquila-imx95/spl.c
+++ b/board/toradex/aquila-imx95/spl.c
@@ -58,6 +58,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls */
 	spl_early_init();
 
@@ -66,8 +68,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* MU not probed, nothing can be outputed, hang */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/board/toradex/smarc-imx95/spl.c b/board/toradex/smarc-imx95/spl.c
index aebb4a2f0b6..a3fd11a50db 100644
--- a/board/toradex/smarc-imx95/spl.c
+++ b/board/toradex/smarc-imx95/spl.c
@@ -99,6 +99,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls */
 	spl_early_init();
 
@@ -107,8 +109,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* MU not probed, nothing can be outputed, hang */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/board/toradex/verdin-imx95/spl.c b/board/toradex/verdin-imx95/spl.c
index 93e76be6145..31730fc22c8 100644
--- a/board/toradex/verdin-imx95/spl.c
+++ b/board/toradex/verdin-imx95/spl.c
@@ -58,6 +58,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls */
 	spl_early_init();
 
@@ -66,8 +68,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* MU not probed, nothing can be outputed, hang */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/include/configs/aquila-imx95.h b/include/configs/aquila-imx95.h
index 96c11ff2d5b..9c48d2b2736 100644
--- a/include/configs/aquila-imx95.h
+++ b/include/configs/aquila-imx95.h
@@ -26,6 +26,6 @@
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
 #define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55, SPL could use first 2MB */
-#define CFG_SYS_SECURE_SDRAM_SIZE	0x06000000
+#define CFG_SYS_SECURE_SDRAM_SIZE	SZ_64M
 
 #endif
diff --git a/include/configs/toradex-smarc-imx95.h b/include/configs/toradex-smarc-imx95.h
index 97e3322ac28..5e23db7c9e5 100644
--- a/include/configs/toradex-smarc-imx95.h
+++ b/include/configs/toradex-smarc-imx95.h
@@ -22,4 +22,7 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
+#define CFG_SYS_SECURE_SDRAM_BASE      0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE      SZ_64M
+
 #endif
diff --git a/include/configs/verdin-imx95.h b/include/configs/verdin-imx95.h
index b6df4d48695..87085cc8719 100644
--- a/include/configs/verdin-imx95.h
+++ b/include/configs/verdin-imx95.h
@@ -22,4 +22,7 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
 #define PHYS_SDRAM_2_SIZE	SZ_30G
 
+#define CFG_SYS_SECURE_SDRAM_BASE      0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE      SZ_64M
+
 #endif
-- 
2.50.1

