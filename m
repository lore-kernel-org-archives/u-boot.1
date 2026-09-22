Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32C3C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FA2580DDA;
	Tue, 22 Sep 2026 02:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njXcBbHjZf_l; Tue, 22 Sep 2026 02:20:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 941BF80DD2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790043623;
	b=G0FTZqrry82Tp28DaO8YPaUZ28j8IwfpWxobIYsASOOAZCTLZpEoQLeVzkAImKsq6smf
	 oOvHCpyylNkCcojx71xn709X/+ZD9ELjLfEbcj5x6bJOFaqHqReyPbJQan6UNmbVIo5mp
	 +4LeWqLllY4VWPCUVmaj8u+QibW5iGidX0yqGIKrRlBPFbjAkw67P276GK+2NDM4lgVPW
	 KlvK8zTFr8m9RH/VUHJtRw3Hg3IVpOcdIVF1i3u/z4JmgEF0eQ1jonWYgO+iHIvvJ2yCJ
	 gO2hXWNnyBhNu93J0bsopbHy11O7SZKyhdt8SC12G8D5SV7ytHW5nGnxVqcaOPQ/2QQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790043623;
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
	bh=q49meVNcRU7VpetuiXPJE+mDDxHdURdu6z9mHkZlA8U=;
	b=YeLw9r48ffOGHgxuivPsjXcDJxg7FsizaujUlc7j29FGRzmT0J68Bkhw3ovC+p+mRcoi
	 G8Pq6nmW+et8BjQM+tsniQnxBH0p1+fFnmpajekooaiittvvCsr649lxxVNDAnULRC7QT
	 momIf1zokFdL6McteoubfzQyMJ+FPZTt11Y7M2xKFr//Enw4nc27bUKeu+iiu4IvuhTIZ
	 9S7HVVwyuWjz8YAWhtkBUjejdgesHmo0sBpi4sISSMAziRpCkQWLP8u/zHNBkjnpbmkqb
	 8lnBV1lHV+AeYBMQgkS9R1CSxgR6rTwtXf5mUqA8hwDLjFtDf6YfjIFXLZW+lcniY5w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790043623;
	bh=q49meVNcRU7VpetuiXPJE+mDDxHdURdu6z9mHkZlA8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LG8rgJPBuaciJoVmmqeSIvHfr0zbpCpu4F270SykNGZN1NcU6obD+725kTB+K+zTO
	 2FQXtuwGLbH3+SpO8MteVyNFsBWlYwlWpjmAoiKL6vCK5qSqhkOtRN75mGeIp3cR95
	 uTKitDDaL6ClL05jvZb5cpHiAaZvRl+zV8Hf2SMSVMgsoyQQtOoVM3I0kItsBd3Oy8
	 WdYEc8RJ0QnFrtJGmpYXqJUvVAacAj8lQjfhw5mfzVCvQFf6oHTqQllBCNqbE/JiP7
	 /+nXXbg74vnphVE/9n7fKpFDM/Yy/regu9C9ALn+mOiY5X4XczciCM+MPS81Y6ORFM
	 UsVg4eAJg82tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 941BF80DD2;
	Tue, 22 Sep 2026 02:20:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B362D13B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A55F440792
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ko_yvLA-Ai1v for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:20:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 62DC5407B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790043621;
 b=f+TwxMOqMr9l1f8+zGrg3+btXRtOp2llb1H/5KISqXV0cADyc81yd8qUKxCTvr5/t8Qw
 2GKd/RZcR1AnGt6gZOsaa1xCSdg9I74TouckV8Wu0V9oDUKs/lS46Ky5XfEEXJWTFbMGY
 OalJ40CfJ6I4RWxpajALyJKLuv6yHMS2W5VfsMsBIt3EzyT6f1vUNvfGk+mWSLPVJcSfr
 cxETbFsziSkgyZRNx5tEOKW8WOZApJoX/IpL4Uw2Pb1M97NFgNBAWhCj7gnq6tJtXXMqG
 RpWzaWNvAxei8Y5n+0CogyHf4TDL4GA+PySHoIA/M0dnXoQAcxs68foLm1zmVlb/B/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790043621;
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
 bh=q49meVNcRU7VpetuiXPJE+mDDxHdURdu6z9mHkZlA8U=;
 b=N+6OkwtycmU+TyDKH9swbERJQBSXOHu2NSY0fB7CavTmKXF4qJnAr+0ZRO50hh6GvtP/
 pagnQD5Se2qafZIw24k7vgbCiDkjoPk4aUjFO9dNjVe+lnj6w9UHbSadYKqbHeXJA+9qp
 B4+Q9xgdDH9O/3MZ6tkWdkXQG70RzF2BZhhhRWhDS6X2TVUVc6qCIp/WhJ/cv2Ij0+9Hv
 RxyDsh6TLhZ0Ii+46Z6mRosNTRR6dVwNarXSsboruu9hB6oVgRYxUIb+7pxcABoGlIcV+
 YFi48IgnDFd5GwBE4eVEJl+9/IuOlMAzjDxJ5/g9Yeod8tnrh7/tSHPWPcQzoNTioMw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TGbdQYWi;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TGbdQYWi
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62DC5407B9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVq1mleBWgFHgFO8j6mdAbc9zM3lRhrzVt1sti2DTPrdUVw33OvneoPO58Mkgcgt3l6fg1ROZUx9wg9R7srmb/iVlRO6wIXScHTaOOKU550OnTwqcBTF+wnz0RZsLZV2ktb4piByxGVj/cdCuO7bY6C9O+HsaDT7aBA9/QeeMWlmfNR9CUFvht2/wLEnj6RxNsg+qXUouVW2sEk/i+DYs17hY31wfFyZrRraImZqaSuRIimZ4BPljrCHwZL72UOYYphMMECYSKGp3kVJG+qbEm9MFEjt6SUehwGmEBqOjSf5UDXQv3O9i4fNtCMKRxAOoDBwzrEEdpp6nZOqvSDqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q49meVNcRU7VpetuiXPJE+mDDxHdURdu6z9mHkZlA8U=;
 b=e08GhNQsLojg0gJEe6oG7EVTBQRG9JY6ngItuopCqJoOPJICK5W5pmXfGsQT9ZFqgCpe3BLTEL9eKmGGPYhXnlKSLJvJT3zUggIF4uhWt/y/zPnSuFezU3ZQ5CVCB2YzleTuOp4J7OPJ+2vbqEScMGwBnCBVQM4NjZCMib4++n1IGzLtx2K8mOB3dK1Mq5u4nDITuKTp1fgocUMUWdQLeNKXJY0gMDqOMHVKJCO0fRMT0IErR7aIK25DAfuGoAgPHqkki0o/ECndDiaWUen086ycH24TMarGteHX5eY3FN0msi9hDqEdnpCWXAEzbS2A0gUNj7fiY4VbGs6IqzLqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q49meVNcRU7VpetuiXPJE+mDDxHdURdu6z9mHkZlA8U=;
 b=TGbdQYWiT/8oMW8yz2BLlIL2BDoH1j1XWTIEUS6+RlKK+Ipfo1C0st/0AlPYU6IDii1mQF2Hzsk6D8z1vyvgX80B3O/Fbf6FQ5DNzN817ufyPt3BcHzIg7o4+HK5/s2abHeXv/qdmstYkrQNBtlMymJk0OJ1g95gCzluiGlWURGq4sjdAufsxfjxvLAgCQm+ajh5iFxo/oq96Z+VjS+mE3H1fqDOKL5fMjEZwM/YesK1xgVdtYJecxRgqRv74ecq1ArVhakE19PFpMjZdyxKnRceRWkMXMXt862UWfx1sGqwBsQznI66dneNxzuc6CIku4VE6sOM1OidVOvRlNIXHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com (2603:10a6:10:14::32)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:20:16 +0000
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b]) by DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 02:20:16 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.u-boot-project.org,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, qijian.guo@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Subject: [PATCH 4/4] nxp: imx9{5,4,52} evk/frdm : Enable caches in SPL
Date: Tue, 22 Sep 2026 10:24:06 +0800
Message-Id: <20260922022406.1838737-5-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922022406.1838737-1-ye.li@oss.nxp.com>
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To DB7PR04MB5130.eurprd04.prod.outlook.com
 (2603:10a6:10:14::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5130:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f558b11-065d-4eca-2674-08df185009fd
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|3023799007|11063799006|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZPKPXWJvBOw+NgvR9spiqkhdrqLj7j6Y7RKHlvJrRhFXwDr4aidx2UBEqlcEDjh5TedHerP9bOEu2XCQG3uzmAYVLrSd8uFzFczl1vc6oFfmEiR8Re71TIQTpA4jlcJkgoAYSFEpFg5pgDlMojh7XojXjaoDakzXg7QkD5/DC2NaiOScdUmolIft7JFqaV3GNBHPaQho7d2PD8yCbrz+ygRXXZtZwzETo84OcMF9HSYOt3vMCszKHW3QPpS6Hv4dOpVXNzxVPxn68d4HzJQCW1oB7EWOVDS8wuW43q4N1kcEg2bmoI+j7CE5dKE3HI9lSom89n+2+h0ynD0fOHQJLSe3sDMZMIl617dEhFo5CQ71CXcM98U2UJ0O/kn1OFxM9Yhu3MRKxxpV5GbD7jzeDDZpyHI1Kc42TzD++Jb1FjiONZifaDV/z65bWAhRZwSglvF6bageR+XuYHMMcjpa8Hyg16EQMOCElkz//bLN8r7B5YjMm/obmO83LQ7kc1+KK5TJGNua+xrGRq6LuPK4xnNxalGYuxiiBZAs8OtH5/4NlfHq6fy3Zj8qsLexqRL9RlcYZ5lQm0mcw5fmdDGJD1eD611QcEvsLaz6063ZmoqiJoLGlC535vEXGpe5wC9oXa92/3doQ5kSadBQJPnPnyKAAv9WtIiO3dRHk9Dj82M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB5130.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(3023799007)(11063799006)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PlMzE6HEb7tn1rhMf//S9vhzcrBl/DHyORNbIYMZqxkCaZkie/F9peack1xZ?=
 =?us-ascii?Q?4fTbhYF+NFRnCASLft1d57m4ZdIl5/Zq3kK8RTGX21+sJKFsV8ku06LiIguI?=
 =?us-ascii?Q?0c0UuZ/YSykRDmHYhHxbCa59oTPx817Ik/2k4RIx8qdr4xG8NMh3Fhn7vhcN?=
 =?us-ascii?Q?V/1d+aRcpTGJYVCMFLI/xrEIcBMeNCDRG8ohKcq4BZfOVzkeT5iz0LYHHK4N?=
 =?us-ascii?Q?tdBMWe16TfEq8BnS/4hTZSR4brVOYpO5JOroBINAvqbgzvVF/idtVOdDWdF+?=
 =?us-ascii?Q?3zW+X9gimvf5NHuMzg5zeg3QI/TqgX/fCcPcZXdyt2bfDj8bJkSXLetwiBju?=
 =?us-ascii?Q?3iSTLuOn/AsAhO24kx+KoAKQ4TAYlYU/p1++72NqxEev3ftN9SQBy0/TDKFV?=
 =?us-ascii?Q?/Us6hU/RjmJrYbcH6wAOY8XkM83DWTnrA1mVWi+Qk3wJoNYCMVuQxsfIlOLF?=
 =?us-ascii?Q?pJ7yEnGPo5kVjZoKRn67agkj5p3dOGCBlj2ZRDY/6+IgYvRI/RWMbyx/sE4o?=
 =?us-ascii?Q?hyq16JnINlYfK21IyVQdx/MLwHCn/97ekGZODDMkr3sfIu2KW9dNVYugFb0J?=
 =?us-ascii?Q?fizgE6p599OIz+0lvwGLVA5xCrFt+pFq/JIYePZokospqbZv7TXWfH2TiYv0?=
 =?us-ascii?Q?b2jPyJH/SA1W/AmrEYjm5BkjYsxY1Lb6f4U8q6exdl3u2CC7OJVFgZG4QHFc?=
 =?us-ascii?Q?QtebzC7Cba9ccX0lgkwT1OXeUOWZC7asDcvFzhgR/Cjv6bTLt21smrQ4J7wT?=
 =?us-ascii?Q?ysx1E2wSVWzV3tbbLATWTWpmidutXxR0jVENFwYy0u/Gg+huNq6fUI2uwVDN?=
 =?us-ascii?Q?znH0Z0woaATPNlu/KEa97n8hZfryR1wfQ0m98bjKv9C0hGPFHtZoZn1pM133?=
 =?us-ascii?Q?WxYMmolxG6uN9hbbxHHovElddUFIDaFtzDcMyjl8C1Ufkwsd41Yys7DF8Sse?=
 =?us-ascii?Q?kHJ5XPWaAksB6oZ296JgruVxcJMOIIMYpOyeEpOIFysxnwRiGcc/syJCGbHI?=
 =?us-ascii?Q?5nBTiUhK2H3r5lxlYXp8CVJ9T26mF814B0ZlLhWyiZIgJZX0Mw63PQ6VvQOG?=
 =?us-ascii?Q?5Pvnth43YmmzfSHZrwUXcNA1KoKKHobl1LU0A5PTmK8Sb0RdVa/gKNivNV7R?=
 =?us-ascii?Q?nawZ4OGJIFbzlM/yStmz2RD85M5XtWrin80JQHSNjhzT+gsi1cLIy2noNSqH?=
 =?us-ascii?Q?Eb+vOEuw5sh0ps6EZNPFfXiWLaJduqnxLaxKRg/kRvltZvOAPReYyFdBuHdZ?=
 =?us-ascii?Q?R7PI5bGNQyeQDqgI1961YsKlenZ32exvHzwntRBkYm4hhASA6lH3ro28R2Uj?=
 =?us-ascii?Q?l2CzEh45cqKcXNfsinKsMKX4291u1XmoyUNM0sXb/YiqDQwjnG0iJuxhwhgl?=
 =?us-ascii?Q?8FAx+opUiz6a+mDOQFi9nHGHLvNUmEM0kjwdi3LAtevVDRXIKzDBCPFL1LhC?=
 =?us-ascii?Q?V3BbX/Qaw2eKqJVrBDIm96yUHKfErqE5lqIXzIvwbqUvLdlQnYauahWHjXfF?=
 =?us-ascii?Q?cBWmqMtXeaiPhHNWLTqAyPkpAjkHfJbBdD1UwewnCrrNFqRqY7cJU15awIsG?=
 =?us-ascii?Q?DfrBg+ChrOzQK0A6HFAi7ZiifXVH7hwXf0lC5cHsdWnpesrSZzYBTQ3IW2lG?=
 =?us-ascii?Q?WYo1UiZbx4C36S+nW1fVC3WCHIRLKOdlET4L3YGwvvPbTG1pCIhF/F+q3Apn?=
 =?us-ascii?Q?kAGUT/sayaopMwm7AuwoX11324jVzv2wmmXFzk8W6kARU5Lyq2Hp6bffBJ1D?=
 =?us-ascii?Q?Hf3bPWgjVytoAmTeg3/WxaagPa+ap4o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f558b11-065d-4eca-2674-08df185009fd
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5130.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:20:15.9378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4s+xp9X/0UnvFut3mbXJMyApNeWSJyB77oLBCmcb0nuXW5i4coSaXCEl9xlfhpxYq72Mp+lqosQU63DSShWQyzR37uOHtimGxBBW58Ei0gE=
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

To enable icache and dcache in SPL, add the definition of secure DDR
space could be accessed by SPL and move arch_cpu_init before
spl_early_init

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 board/nxp/imx94_evk/spl.c    | 4 ++--
 board/nxp/imx952_evk/spl.c   | 4 ++--
 board/nxp/imx95_evk/spl.c    | 4 ++--
 board/nxp/imx95_frdm/spl.c   | 4 ++--
 include/configs/imx94_evk.h  | 3 +++
 include/configs/imx952_evk.h | 2 +-
 include/configs/imx95_evk.h  | 3 +++
 include/configs/imx95_frdm.h | 3 +++
 8 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
index 739a5f1f559..713b531de0f 100644
--- a/board/nxp/imx94_evk/spl.c
+++ b/board/nxp/imx94_evk/spl.c
@@ -74,6 +74,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	spl_early_init();
 
 	/* Need enable SCMI drivers and ELE driver before enabling console */
@@ -81,8 +83,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* if MU not probed, nothing can output, just hang here */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/board/nxp/imx952_evk/spl.c b/board/nxp/imx952_evk/spl.c
index 615c3b67fb6..447f43bf2f5 100644
--- a/board/nxp/imx952_evk/spl.c
+++ b/board/nxp/imx952_evk/spl.c
@@ -87,6 +87,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls can be made. */
 	spl_early_init();
 
@@ -95,8 +97,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* if MU not probed, nothing can output, just hang here */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
index 2fd69447e1e..f47a75eaf5b 100644
--- a/board/nxp/imx95_evk/spl.c
+++ b/board/nxp/imx95_evk/spl.c
@@ -61,6 +61,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls can be made. */
 	spl_early_init();
 
@@ -69,8 +71,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* if MU not probed, nothing can output, just hang here */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/board/nxp/imx95_frdm/spl.c b/board/nxp/imx95_frdm/spl.c
index c8a5b4f9d41..2e899b63061 100644
--- a/board/nxp/imx95_frdm/spl.c
+++ b/board/nxp/imx95_frdm/spl.c
@@ -61,6 +61,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls can be made. */
 	spl_early_init();
 
@@ -69,8 +71,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* if MU not probed, nothing can output, just hang here */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/include/configs/imx94_evk.h b/include/configs/imx94_evk.h
index 2623c13db06..64150245d26 100644
--- a/include/configs/imx94_evk.h
+++ b/include/configs/imx94_evk.h
@@ -18,4 +18,7 @@
 #define PHYS_SDRAM_SIZE			     0x70000000UL /* 2GB  - 256MB DDR */
 #define PHYS_SDRAM_2_SIZE	             0x180000000 /* 8GB */
 
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE	0x04000000
+
 #endif
diff --git a/include/configs/imx952_evk.h b/include/configs/imx952_evk.h
index 4ff56eb8adf..689fe9b4dc4 100644
--- a/include/configs/imx952_evk.h
+++ b/include/configs/imx952_evk.h
@@ -20,6 +20,6 @@
 #define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
 
 #define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55, SPL could use first 2MB */
-#define CFG_SYS_SECURE_SDRAM_SIZE	0x06000000
+#define CFG_SYS_SECURE_SDRAM_SIZE	0x04000000
 
 #endif
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
index 1fdc9ce21ef..57658d438a7 100644
--- a/include/configs/imx95_evk.h
+++ b/include/configs/imx95_evk.h
@@ -23,4 +23,7 @@
 #define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB (Totally 16GB) */
 #endif
 
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE	0x04000000
+
 #endif
diff --git a/include/configs/imx95_frdm.h b/include/configs/imx95_frdm.h
index 132eea28643..e64294a2bb1 100644
--- a/include/configs/imx95_frdm.h
+++ b/include/configs/imx95_frdm.h
@@ -20,4 +20,7 @@
 
 #define PHYS_SDRAM_2_SIZE		0x180000000 /* 6GB (Totally 8GB) */
 
+#define CFG_SYS_SECURE_SDRAM_BASE   0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE   0x04000000
+
 #endif
-- 
2.50.1

