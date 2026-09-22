Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D175AC982FD
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93C4660714;
	Tue, 22 Sep 2026 02:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nkTm20YlOhPv; Tue, 22 Sep 2026 02:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 88E1860703
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790043610;
	b=bOeZmqCWFMnMjHAZrd0yPj9IVmRXZ8fNIFp615igtEIF6nycjki8ULUVGsIkT0eGq4Jq
	 1Geov1827RquQ7SQmx4z7uJsr/uUm81oTBussfhTtmXG+NqW/sSGq6wBzVM09fnMtEPLY
	 LU1CMqNg4VmtV9fC+L6bWDD/dnRzZYmayaV63sf2CaUXGL0D0W9RTpZmICCDnGJPdVAPz
	 /QmfLGtfNK+8+mRtyhPl4CbfE4myJbe7gLIyGTxoGw8ozGyzXKlI6moWba2jQCnDLWJcX
	 rhK2lM9/KE2F2/fVx5StPjf0j+ZIJ7lK9mWvsBBlKp2zvu6f/tKIQ9vwHHDsfe/nrJA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790043610;
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
	bh=FaPyP7G8F51QWEiPKJxJQkkpY+E0KFf7GH8UveeUmz8=;
	b=jI9uB6h4/1Z72iu0FQFGVrIDRhxyDbsY2YWNIIKlBWZOeTZVTRKx5HxmmG0XkXBTsiGd
	 KsPdbtQq2fMPZqKfM0bcmKRY6zm7bMrkGHNOjz+JAHRL3pHzR7i3JN3mxmvshKwnliVn3
	 kLy4XHZ/lMClW8Uchu++c0VCVYRhnSNnermaLqKDWs7nhokmDojjPYBFkyWXmUxRa1kEm
	 hM5VF/FNkNyONvywyBFCtLLdmowRtTsCFf78zKeUlQHCqWiM7+RFvJVvc+CcKzqPLXnUg
	 BOuHriCS8qN9Bf8COp9ny3cstoCAV+lm4KtZcQa3GWdcy040hxcKCIfJ/IrxpHo/Aww==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790043610;
	bh=FaPyP7G8F51QWEiPKJxJQkkpY+E0KFf7GH8UveeUmz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NKHo6jmOn1D2iJFProjvLmZwIu4y4p+tGMEcCDwjyXTg7kRVHv7PnyYsVAC8y4JCa
	 jONnpL0abJaSghVgveHzDjACiSX0FNvGks2lXm2iW+ePuzLET95otDMUH4ryD1wz3m
	 SHQC5GDIYKucfmH8dxeEK9qCQcf51hO4kKZPORFbbBLYPmUdjVYQOjW9KSzl4fER0I
	 jByPFRh60hgzx0o3Yat6kohyX4j581Wkcc0ulpEn1dx3Yzc1WzDxx0tD2fs1dpXlMn
	 5Gg1XGJjU85ZQXPsxtzlqVMRye61qhJr9BHxQe527G2MrZSyExvJ1E6GC5a7Bx7chk
	 X9c3nuYNj+gvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88E1860703;
	Tue, 22 Sep 2026 02:20:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 965959D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C44E80DD3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1K_hzTzz0WpD for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:20:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F285E80DCC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790043608;
 b=FY6ikZY/YWdRt44P3cdgmSfuCuffTcUZJZreuMoSY9hcwlo9wM5bkkwgWn+mH+0r9Ihn
 1cMy9jiUHP1LxOBbc1MSj8L/OnvpWCXdWqQYdPlBtYDjiR6UoEQEJ4mWAsQnv/Xv+TBy0
 BMJM+RC/V2zQ+Qx3SQBL30SIYudQsMHdCNTUt1yTsHa1DJydWzn8O0UYpVYBdnp1YDby2
 m/Wzd6ZnJY6WCF1LCoQJYGTODQbY+ppk6IBO+IiBCrZDxvT/O9FWnHcRaVXIv9MaAexab
 l9eMtLJACYqymECMJxF1qKD2AZr5x7//ctF/3PM+xJsp+7rthjklllyZNb1v7QmLIbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790043608;
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
 bh=FaPyP7G8F51QWEiPKJxJQkkpY+E0KFf7GH8UveeUmz8=;
 b=ZCidK5LpsO28v8i/bryS3C16eqMaXvd3G4F65ogL141ut36MWmUl1vLJUnTsFwcEqquO
 XEnoyhCt4+y7M6CDEGUYBD78IANyDvTnD/RFwSIYorpn+9wSnhNzlJm085xELDQKzHn3y
 +5I7mAYKr7DGElN0Flq71R6r9qJZNdXwL0I/Qt5lqwc8K59h+LMGnuQmZIykXSZTLMdA8
 Az1klU2zWVzFV/lZl/OKTA6X/eTorGjbJYe7sce0nMAVL0DNHFL/QpAZJ7jUYa8JqW9Mb
 /raEU1AJTtOMZ43A8Xzv+47A0xZzo+E+NmJzApUGS4ZEXkFIU8D7k9bpm4E8EwMpdWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XeleE8M0;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XeleE8M0
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F285E80DCC
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNchPY/ZYm2+/kbRwcgsstvulI0T4Bo2uYg/VPkH9oWX8Q12LZCIZQ33D3OIWh1cQHh5xVJ9ihhZLGaZOOsbEGXcalrnj+6Unl5xjeYUYqsnX+Nv3BcMAfUJNSVKl0c8MO2eBWJ9J8HSMOA/2R5ujGRRslShrpuv0PIeZYcOznlUkjbUBgVIOiyT4qqS1PmJAaaPUGKiVZNPaiVBjf1ejd2X1NwZJmusAbyeE8yJ/BKxNi4z8GjZnjmM9ajf+SP9y5thLHGU5L4EwA6okpCLlb5ddl2FWGP9nKSiryzRYQdoIoABPFZAv5XNZG0rUg3G9cqbIxgqvNXKMnDA/dFBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaPyP7G8F51QWEiPKJxJQkkpY+E0KFf7GH8UveeUmz8=;
 b=agrS8pB7x4sUuOVCMjwnqls7U7xFKRfX03INtTFCeqNdVwPFUxpfvdUirMhbK5kiMtSOYRuVoJBSt9xhj+pxsVgk4k/IS+0oK1xhvjY5+FGktXAwcl9th0plVbSrG9O58AIUyPS0G6koQkEV9cPzub0HQyQr0TnDQRcu+pVkg94rnzx1ocVADH0NUpWSZ+FmLUMLktHvagEVtErM/ghI9KaJNxiOtY4o9Y5YoFv6Gk3dCBf/FKCx1K+PxML1i8HWmgEeU2tbMTkXRZnMl6WkPoq4cr/rq4Sro6ZEdsvWkntIkAyz9YFNA0sY7gGsmwrXc11pBt+DP/ZdVsPJM5xflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaPyP7G8F51QWEiPKJxJQkkpY+E0KFf7GH8UveeUmz8=;
 b=XeleE8M0SmffXK5uy12EdOiJVRhXzarfcOWw/q3lFI5aOKXb4mfyOdvBKc2D3qEXQKfTg6fYEkagke/ee1uvREHuPeWwCQH8+5KMr50Nkf8BNdeDGtN8Prj3R8Vh+rrbXrTbU/fWUsbCXhDIgrrIJynwCDLVuKZYcoMigqXuJrykWiLVufMfmd8AOlq9L4beD/JWADHDu8iRpx7PYQc/RgZhY7/G/FFDlDnd6zlkhtFn9AlD121oNsdyDWwyBA4LfBhDNzTiB8mUl7pzyuyOTfWwbQsjSi0tb02c8p3Yi5FPgLd/yOK7wdwgd13mEcYF3SldPjIm7KKO+HEkEOFQMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com (2603:10a6:10:14::32)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:20:02 +0000
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b]) by DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 02:20:02 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.u-boot-project.org,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, qijian.guo@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Subject: [PATCH 2/4] imx9: scmi: Support early caches enable in SPL and u-boot
Date: Tue, 22 Sep 2026 10:24:04 +0800
Message-Id: <20260922022406.1838737-3-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922022406.1838737-1-ye.li@oss.nxp.com>
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To DB7PR04MB5130.eurprd04.prod.outlook.com
 (2603:10a6:10:14::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5130:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 18de207c-e752-4f5f-80b8-08df18500241
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|3023799007|6133799003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /Ib+5lIoUtm9udO4YUecW+IzokLZlmmxNv4LuwTnclKLzL5bRVVNGdImSJwLwGcjCN55NK7llwwjEDvfhlWSbi2FzCyDrjVSFjOgNl4jp0bGMQeEcnzs5jrXS1ACuA6dhy/V96gMFXjyHzRstMjkvTFvRabwyZWIyY85rrJSPAU1kQzFuFgt3s1uTmH6iDk2AWj716qjQMQn/51HozNUkVingl1EnsbFpzPOiB+2nk7R+9ZzALe1nLtschLgCktTwzCl/+aTU6XnbSc+3yLWW6Atc7eMCAzuTdKyneFYuLMr/McRyyGIVfKaG01OgEGrXpa1PI0VQihyuBv0FaH9hWttzOtFkEnX3KUb+6Cb5WxRz9rSGrbUAmxe1EBd++Y9l902M1WxSCTyYM8NEcn+C/u6WDDHquuVQlxRf33vErs1CDVOb2GM36x5/hVM4se6eMoKarmVsSq2Z0duShp9HJ6nKQ53HHPFp7jd/8J/dtY/4unfqa3ESiX1GjYapvLNAVwboSEOuIdTEHE2g2vs3QCoKsr0IDWTvNWzhcnHgi4KCpW4bsri/zsn91ZM3eKAJ070wvJYfnxhYu5yuKu4EVfNcc82iSwTV/wN/75x4FhfQs8LKP4tGDbsLT8NdZd1Llyd7hiHsAtsLe/atk8dvPEBlIK7Q+dqynxf7UKWJLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB5130.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(3023799007)(6133799003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/cro/Z9F5K28m5bxNKtwasVIi/l65X7vfYzo/n7DBJHX/HGQ/XFLu6m11wF3?=
 =?us-ascii?Q?GU6GVmVilrZsCZJt1OoqnEngh59yi7ibr9lTaZoWF7Sk9KhELevUwib/fqZr?=
 =?us-ascii?Q?U7edx2PdQBjibjFL9zGyTrhwKXkTbOPyx7gvD+FoROTv13ECvNBm2qsOxfkE?=
 =?us-ascii?Q?DNTQ9bvza+pgt6i8Bhe2kwZT8OaRytfgp/qES3ExdffGrWBt+gzEVOM/8+Wh?=
 =?us-ascii?Q?ivwK5FLgbI6evhuDvUJXabwiBCFbU1e1t1TBXLneCYL3V5NuaBBRiNbGTVDf?=
 =?us-ascii?Q?BTKOZpWI8kZ4FLEgAWP3WZqAOXyzQm7ELoUvKpv7FQkinLz/r/ThJm2AA54l?=
 =?us-ascii?Q?IWfVeKmJxh+9blU8BSR3lWM1e1YnckeAdXPY8BmFV0WnS1ABd1bkFDbjqkBy?=
 =?us-ascii?Q?c8STNJVKqOaaX95e8cC8oi4PRdvZU9mq18TVsIUOmPNYs4iXrLdJpixlrX21?=
 =?us-ascii?Q?0iz7JlQvM0Hd7fO1SSHiN+IPu+bG4UEI1aQbsc86Vb/oBq5ulQTf4LlMP6Hy?=
 =?us-ascii?Q?b21w1rk9FpEwQQ1/8Y2zCADCVQCE4kfyct8UrHcsJONdr6pk4MRYVuNeMCP8?=
 =?us-ascii?Q?QiO7EbAlb9SiLzzxl6ZcTlVdbc0/T4Cuk8nP5hHBH4hwBVS11kFPNCVrVSw0?=
 =?us-ascii?Q?6ZEO2VDuoZ8JDAUFrxxzLqQInk0O6cXvOtMHXsJfmrTtfgu0MAMBGBcV5mM5?=
 =?us-ascii?Q?qyWZJwvV4uM8k6LnK/Ye5GW/5i2elhdRV1fYeDTJQ1/ZJkZi8n77Tuhs9tb7?=
 =?us-ascii?Q?NkDpnJ4A+OJJXAUuzV0YpLt7epKB1M15h9nsMa51jqaYp6MdXEop5YD/yTgX?=
 =?us-ascii?Q?nfNSEThoVwaTNPAn/9h4Z2VUfx/IKJUZX+ELuXR6W+me7e+1QPCM2ElwIE2E?=
 =?us-ascii?Q?7d6lFHkwogmfEQCM2LP3dyh7hlGOUwgYLhI6iU0bK+xUTzGioXU7VXTWKc/D?=
 =?us-ascii?Q?Ivl7UKRf0a870KRva3Gv+VeOCUERn3YnLtQpLKA3/pQPLyVfX5wjO/jLPEKu?=
 =?us-ascii?Q?TeUu5ws+vupln3edSnyTdMuwKU85SmAf+af4d3RMKpeF9E/grgtlXNRenc0f?=
 =?us-ascii?Q?22d7+YQmdIOWuOnrkEYBo3LaujMOV1C5rCvchvcFj3n1f7LFixiy0r//uJoJ?=
 =?us-ascii?Q?c1kpTzMnQJzThNJzKGeEFDUoafXLVGX7zbO7jAx7/9tP7hzCtz1vKVvZfIFv?=
 =?us-ascii?Q?KbtZgRfuDegODG7/qX6wG7WHLWgZO8s8kkm2q2uR0d4OHuRoI3uBIjnfBwPR?=
 =?us-ascii?Q?iaN9r4bqq48ctTqLosTVjPhiWD5GEnlIS09USkJnhuCerRKAbKS+DIznXFJp?=
 =?us-ascii?Q?PTf0vwfkg788pVSJ38/PzUwAoDP88OlcVtPDGZlMGbsJWhrs1XS4zrg/CxB4?=
 =?us-ascii?Q?y1O1bHGrgMFi3WJoHimccE8af/M/4HfbpU3646iY35ZcU9STqkYvKGhPEwSS?=
 =?us-ascii?Q?67Fs7erCIKRLLN1iK8NmnWA5cf6gsm5ij7JMatEUMqczA/ei7kiRB+L/ZwcH?=
 =?us-ascii?Q?vT1gWuJM2UDHb7vtl8F7YPBIrxNNFETOo1fWtoenSmQGsgh8v1r4q55WxoXr?=
 =?us-ascii?Q?D+nXbVBtKiY3joweOt8jFTDHiXLBGO5ohZU0Ac05zZj/99dbNUtKGKnSp/ex?=
 =?us-ascii?Q?DVhgQEOFZnb4UXevMO9pUUPKd0KtbJO1C45dzqAZbgp5xMEtpUqPlim0Sfo7?=
 =?us-ascii?Q?Sqoa9Wt1BN5BzjwOV5Oj0/Vjl/dHzQDVwj6nQTeq8VJtJSyiPFUJkAwjY16W?=
 =?us-ascii?Q?U1kE6+s+K5EZWJIAg2jDU451DpVMNqs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18de207c-e752-4f5f-80b8-08df18500241
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5130.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:20:02.8326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fElK7UW2y1DMtqJ+MprsNEKZDHx9dIms13wnUzWleDtqjtivweBZMb0mqv34ORbUkAHS7x54gP3gcWH4iCpkDMfWq2vq4QZGD6lU/9naYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
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

Enable the icache and dcache in SPL and u-boot early phase before
DM init to save boot time consumed in DTB parsing.
Since the DDR size is got from SM via SCMI, it is not unknown at
this early phase, to avoid speculative access and prefetch, only map
low address 64MB DDR as normal memory and map other DDR address to
device memory. After DM init completion, update the MMU table with
effective ddr size.

This early MMU page table addresses is provided by two APIs. Users
could override their default implementations to provide different
address:
board_spl_mmu_tlb_base   - SPL phase MMU table address
board_early_mmu_tlb_base - u-boot board_f phase MMU table address

u-boot early caches are default enabled in this patch. To enable
SPL early caches:

1. Define secure DDR regions available for A55 (CFG_SYS_SECURE_SDRAM_BASE
   and CFG_SYS_SECURE_SDRAM_SIZE). It should include the secure DDR
   address of the images loaded by SPL. Default board_spl_mmu_tlb_base
   uses low 2MB space at CFG_SYS_SECURE_SDRAM_BASE.

2. Calling arch_cpu_init before spl_early_init.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 148 +++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 00fb13ad65d..22f9c9d045b 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -12,6 +12,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
 #include <asm/setup.h>
+#include <asm/system.h>
 #include <dm/uclass.h>
 #include <dm/device.h>
 #include <dm/ofnode.h>
@@ -317,6 +318,8 @@ static struct mm_region imx9_mem_map[] = {
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	},
 #endif
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+	/* Avoid speculative access to OCRAM in u-boot */
 	{
 		/* OCRAM */
 		.virt = 0x20480000UL,
@@ -324,7 +327,9 @@ static struct mm_region imx9_mem_map[] = {
 		.size = 0xA0000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_OUTER_SHARE
-	}, {
+	},
+#endif
+	{
 		/* AIPS */
 		.virt = 0x40000000UL,
 		.phys = 0x40000000UL,
@@ -356,6 +361,15 @@ static struct mm_region imx9_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_OUTER_SHARE
 	}, {
+#endif
+#if defined(CFG_SYS_SECURE_SDRAM_SIZE) && IS_ENABLED(CONFIG_XPL_BUILD)
+		/* Secure DRAM */
+		.virt = CFG_SYS_SECURE_SDRAM_BASE,
+		.phys = CFG_SYS_SECURE_SDRAM_BASE,
+		.size = CFG_SYS_SECURE_SDRAM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
 #endif
 		/* PCIE2 ECAM */
 		.virt = 0x880000000UL,
@@ -388,7 +402,9 @@ static struct mm_region imx9_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_OUTER_SHARE
 	}, {
-		/* empty entry to split table entry 5 if needed when TEEs are used */
+		/* empty entry to split table entry of DRAM1 if needed when TEEs are used,
+		 * or use by early MMU in SPL or board_f phase
+		 */
 		0,
 	}, {
 		/* List terminator */
@@ -423,6 +439,9 @@ void enable_caches(void)
 	int entry = imx9_find_dram_entry_in_mem_map();
 	u64 attrs = imx9_mem_map[entry].attrs;
 
+	dcache_disable();
+	gd->arch.tlb_fillptr = 0;
+
 	while (i < CONFIG_NR_DRAM_BANKS &&
 	       entry < ARRAY_SIZE(imx9_mem_map)) {
 		if (gd->dram[i].start == 0)
@@ -584,6 +603,124 @@ phys_size_t get_effective_memsize(void)
 	}
 }
 
+/* Allow board to override for specific address */
+__weak unsigned long board_spl_mmu_tlb_base(void)
+{
+#if defined(CFG_SYS_SECURE_SDRAM_BASE)
+	return CFG_SYS_SECURE_SDRAM_BASE;
+#else
+	return 0;
+#endif
+}
+
+__weak unsigned long board_early_mmu_tlb_base(void)
+{
+	return CFG_SYS_SDRAM_BASE;
+}
+
+/*
+ * Initialize the MMU and activate dcache in early stage of u-boot or SPL
+ */
+static void early_enable_dcache(void)
+{
+	u64 pgtable_size;
+	unsigned long tlb_addr;
+	int i, e = -1;
+
+	if (CONFIG_IS_ENABLED(SYS_ICACHE_OFF) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		return;
+
+	/* Skip enable dcache if SPL early init is called.
+	 * User should move arch_cpu_init before spl_early_init
+	 */
+	if (gd->flags & GD_FLG_SPL_EARLY_INIT)
+		return;
+
+	pgtable_size = PGTABLE_SIZE;
+	if (pgtable_size > SZ_2M) /* Must fit within the 2MB */
+		return;
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		tlb_addr = board_spl_mmu_tlb_base();
+	else
+		tlb_addr = board_early_mmu_tlb_base();
+
+	if (!tlb_addr)
+		return;
+
+	/* Because DDR size is unknown at this phase, to avoid speculative access and prefetch,
+	 * set early MMU table to have DDR mapped as device memory, but with low 64MB set to normal
+	 * memory to cover u-boot, early malloc and stack (CFG_SYS_INIT_RAM_ADDR).
+	 */
+	for (i = 0; i < ARRAY_SIZE(imx9_mem_map) - 1; i++) {
+		if (imx9_mem_map[i].phys == CFG_SYS_SDRAM_BASE ||
+		    imx9_mem_map[i].phys == 0x100000000UL)
+			imx9_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE);
+		else if (imx9_mem_map[i].phys == 0 && imx9_mem_map[i].size == 0) {
+			/* Use the empty slot reserved in imx9_mem_map */
+			imx9_mem_map[i].phys = PHYS_SDRAM;
+			imx9_mem_map[i].virt = PHYS_SDRAM;
+			imx9_mem_map[i].size = SZ_64M;
+			imx9_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+						PTE_BLOCK_OUTER_SHARE;
+			e = i;
+		}
+	}
+
+	if (e == -1)
+		return;
+
+	gd->arch.tlb_size = pgtable_size;
+	gd->arch.tlb_addr = tlb_addr;
+
+	dcache_enable();
+
+	/* Recovery the imx9_mem_map which will be used by u-boot board_r phase */
+	imx9_mem_map[e].phys = 0;
+	imx9_mem_map[e].virt = 0;
+	imx9_mem_map[e].size = 0;
+	imx9_mem_map[e].attrs = 0;
+
+	for (i = 0; i < ARRAY_SIZE(imx9_mem_map) - 1; i++) {
+		if (imx9_mem_map[i].phys == CFG_SYS_SDRAM_BASE ||
+		    imx9_mem_map[i].phys == 0x100000000UL)
+			imx9_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+						PTE_BLOCK_OUTER_SHARE;
+	}
+}
+
+/* Update early MMU table with actual DDR got from SM via SCMI */
+static void update_early_mmu_table(void)
+{
+	phys_size_t effective_sz;
+
+	if (CONFIG_IS_ENABLED(SYS_ICACHE_OFF) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		return;
+
+	if (!gd->arch.tlb_addr)
+		return;
+
+	/* Remap u-boot effective size to normal memory */
+	effective_sz = get_effective_memsize();
+	if (effective_sz <= SZ_64M)
+		return;
+
+	mmu_change_region_attr(PHYS_SDRAM + SZ_64M, effective_sz - SZ_64M,
+			       PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
+			       PTE_BLOCK_OUTER_SHARE		|
+			       PTE_TYPE_VALID);
+}
+
+void spl_board_prepare_for_boot(void)
+{
+#if !CONFIG_IS_ENABLED(SYS_ICACHE_OFF)
+	icache_disable();
+	invalidate_icache_all();
+
+	dcache_disable();
+#endif
+}
+
 static inline u64 ether_addr_to_u64(const u8 *addr)
 {
 	u64 u = 0;
@@ -1078,6 +1215,10 @@ static int gpio_available(const char *nodes_path)
 
 int arch_cpu_init(void)
 {
+#if !CONFIG_IS_ENABLED(SYS_ICACHE_OFF)
+	icache_enable();
+	early_enable_dcache();
+#endif
 	return 0;
 }
 
@@ -1108,6 +1249,8 @@ static void arch_init_post_dm_f(void)
 		gpio_reset(GPIO7_BASE_ADDR);
 #endif
 	}
+
+	update_early_mmu_table();
 }
 
 int imx9_probe_mu(void)
@@ -1144,6 +1287,7 @@ int imx9_probe_mu(void)
 	if (gd->flags & GD_FLG_RELOC)
 		return 0;
 
+	flush_dcache_range((ulong)&info, (ulong)&info + sizeof(struct ele_get_info_data));
 	ret = ele_get_info(&info, &res);
 	if (ret)
 		return ret;
-- 
2.50.1

