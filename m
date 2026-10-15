Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D51CCC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3079C60A8E;
	Thu, 15 Oct 2026 13:15:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2jFkRbOBGhcT; Thu, 15 Oct 2026 13:15:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96C1A60B0F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070123;
	b=KQOI6yFtq3L/fhvFYa8CW9CaYJ7U2wkrhExbNZJpRJXIW/M38HiKm19YFouvQ4IuiK2x
	 QyqMMnARkh2FgWcibenSrfgUPBku8WTP1SwC7UlAfz5jor0AuAFOBpDi7f1VPzOjaN8tp
	 xi4UjLmxfvQkBttcCQq4DkTYDv0WVMzHUNMZ31RVJj5b9+4uii1KS6BXNxaBDogavKgDk
	 IyrY3wJfTEp6kpqUvBV2Snli6fI0AuoOyFhLRj7blJ+qoE8c3FuPcyByTlaD2oHiUne2/
	 BDYlMqvWq1a0QGMXlYOxSg1h/huq44R/y9UE+B0gbccdr7OrY5sxCmDW9hXFmdfQGRA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070123;
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
	bh=5JYgdCYyntLTcg5jXul3RDvUVz20ZwDW+QfSXSyfQn0=;
	b=hqRCKRcVLPoVL5lfzJfbMfHzwjnrMxVYh5IJI6b+kTa7Tfxf16PFT4re6/c64Tblol2A
	 PTq6hV1NcjpUvEUrYRm9wNH2c+glQSXUo8Yi3D6ZGvi9Z3eZMQ2GR7Fv8meNnZtf8RwUv
	 RLnpF+5L0B7WuzQeXDwyUNX9Tc7sCdLxlUC74DyUjryT4XeT2DzfO5PMk8Efytn5MeIjR
	 uQQaWVRwpAFC4joeqDtezzzoF35u1sEECRyiwkDvLmfQtw6jUpBAzgFxWaRo9SeV0lBvZ
	 yRNIYG9LZrZbbXoeGN2tFf7+i3cRpwXpZacKIa8XEfRoXsZyVQ1jLLi+qXcQr1UCYVA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070123;
	bh=5JYgdCYyntLTcg5jXul3RDvUVz20ZwDW+QfSXSyfQn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xzwY3XMi8KbxrjEtsKAsnEiOautcM4sGbo13YPE50XR4f4nI6Q8aKuZC/lRPDMLNR
	 SP73/RFfANQ6etBkl94mIyMsbwyEIh/x1feFP4lmfC5hyZ1MpNI4G+HyzydneP6c79
	 oZ4x8hKNhijCQHyYgZA1crlQQ5+Mp0Tg6nylaLDbW2i3xXGlvTn6iczufIy5N0BmiY
	 Kca5a9B7EwDEfRf7EeQvQE6b6vpxEAeb9b8YYzMetR2/rjuIw++9DbJdHbU0pIUDWk
	 IWJIT68n3yJShQWFFGk9KkMXxgBLmnCaOjTgeYdk+NE5Sek8IbYzm1fXS4JWK89cbU
	 Tq2EbyN54Md8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96C1A60B0F;
	Thu, 15 Oct 2026 13:15:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91FEEA58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83E854080C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWyHpQOwwlNr for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B545F4080D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062846;
 b=UNtrc0jMBDrE6K/wpAp6/7ZVZ6OsyQSo1DGmzkc/4+5hE5S7G3jdT9T4ZPscbne+MnLP
 3GgVFsS71O8syQnbBsvHdqwnWZzo/lJ30o9EbvPKluogYMWFon3HUrUk9FMFfi6xEaO2f
 AEkW7HSjGOFG1uvUHS0ZzU98uVjiHk/+OWrY0r0496oXuY9tFDVnN/5ovPQBco+IkfJb6
 y/YjQDVBLBDZpEfnTOqOGE03lVG0aquc9M+vGRf22eTCAhQgv6SVgBpt5gSKWwper8e8f
 OrWOndtyZIbcTishp11u04PtcnakuayzvPOW/6GBrdAcAWgDcAmXLcL+jGBcEPnfhbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062846;
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
 bh=5JYgdCYyntLTcg5jXul3RDvUVz20ZwDW+QfSXSyfQn0=;
 b=sSZB4LAHxVy4IkI5H/jNI+VqEG3e4QsjFtADyOcXZDW5x85/G/LE24JSi2WNfdXZqxiE
 j/bu87o0+suBc4A8414zxQ5/ySG/lv6nuWuhOtbqs2ev+V6pHcaSB0aPMK4a3Ue7tlwzJ
 nG8wXyfA5hgNzutlGUOb8om+GOPYm/unhN9Sg6XXMkWcB4doqOZInxGJaHxb7RWOrv7pm
 /0uZpSWrG4Q0HQzy0eRkboLq3k/+cWL/6x3mEyeIulzb8Hf9FkH85jGapeRaVM/MlVRPx
 h8bGy6dY0I8fjfxYDRZ8V+Y7cq4XdRdWmdOVnJIl4eFuh0hM5NlGPTaF8uoRz6KMJhQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=GDrsTWv0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=GDrsTWv0
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B545F4080D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ke3ecRCziyHOaXMBn7T6BCZzXbqC+AwhEpXcrqNFitG1vSxs2SZB//iGvk1lCbTs8tkaa6r+LtEpCjyKmc37IcLNZd0XOQQ1RDm84KL2zHjuIhzqJDKSMPRPlCO/v0wwVLg00q/o4QeSmvt9vL4Fa7BITjAC5070Ok7a4scFkoE73ialhjmJThd+BHJvQglpzEO49AESUeh3d5cvQwEmhCNdMz3yIdWYxTa8Td8m7pZA/uv8hvOhltr0DZnYd/BHfk9VMZ132Nl0vmtFF10CG0p2yjXc8o2ehG3VjQD6XJ7xr7QEluPNgmrMjlAFT9lGsyMPVBvwDZiYjlhVjDdJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JYgdCYyntLTcg5jXul3RDvUVz20ZwDW+QfSXSyfQn0=;
 b=Im+xbGJsSMf7kMxqCfTNQCwiS9rq/7VMUmrcomJ5s/fgng9CfOCUaqsQb1GdHnI8I+1qNAtKiPfy+1Uv275tO77qrYYZoB3S+AGSAV5gPBNsd8jVjeObncNYxsGj/EZ9h/ubDJICjB6+/FN1c2fG8irg/J+VHLmiLPiUgQcINnUPlfsd3rCpAYkfjAGrRnBFrh7QDrvwHgt7UCCd0k9N7mRQByTcG8hoIFZZ0HSQmcf9+ilVj7OoChLG4nYsFiXZhOOxPY+g9fwQk/cBczQa0QfVkE1/jdzNEF/ul1l4Kk8+DVECHsV04XB6qnx8iq6WkB5uw84ok08xURCSDv8aUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JYgdCYyntLTcg5jXul3RDvUVz20ZwDW+QfSXSyfQn0=;
 b=GDrsTWv05/vlq3H3wCqqLRMQ8e9qSf7a56VwI/G0X65jODAAtmmnvp5YzveP+kAnSo1Ogw7DhWb2aNfxnyn2AGsohl2JY7uEhScf5Zyi8G7fpoQ7rMGy1dlBYle+y+zrK5sdL5tRltvaoDizeAkL4NBeAHGSO8CH6YyOXx8SagYVnWJ/fasCE5uTgr5FepFP9Vvtt2sdp0sVp2D38dqPWwORj2ZpQVacq2DCqbnfd48TmtOsna9G2tNK5SmMy9ycVFpZe+gNIkc/BjenZBUGfSLOequP5JmSjXQAe80LhpDNQIfGy/JicY3GmSoYiwq7FGlcfgDw2FpJFqrgJpdYcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:14:04 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:14:03 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] test: dm: Check virtio queue cleanup on device removal
Date: Thu, 15 Oct 2026 19:13:23 +0800
Message-ID: <20261015111328.1269775-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015111328.1269775-1-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: c5020e4a-b6f6-4bca-5fe4-08df2aad6bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ar9Og9tyvLsTJgD6qtJsdfXSCOSVvb67ok87TH4rDMyi14oPMOX6XWXLwfeSZhfsjKcwtKBiWPeRwkQRr2KJWC03r5w1X9BSFHYZWAeENQfqlXpno0D0pNn2o48BUa38mTMsCxErRG3rzDbjR05B10RwzN9pvdSzqf5dIC/ujSphJfqycGEqR1TIUBX1wOhAnEiBQCWbgJW/1t1Lvj+sKAtBFKtcIJuNfU3rAlIZxgcLMlylmGrxp+PFknjbROYtfnemhQNt3Z2EZNppRcaO3q1osPZ+524S4hcjTwFdfMUsXoe4lQreF7qNI0c97AcoajTwjk4FMhb1zsB8SOoyNMTZM0iacNHy2I1PzWes2cWT26LXzJDavWI8CGDqSr2tHWV/5gSUu7nUdFnGsrmzm9lFKNz75z3jDVW8AlqYP0gdgov3v+8ZioIWSVQR3ZpfMFfqOpzRXZfV96nYpH4qdEXXgZoPH0B57RVXQlsDOmPCuDG99k78tbAudS3v+SKFM9ohU/2dXXNbPaPn8fr/XOyMwe5XMLBMDTctC2rIXayELqUaytVibj4CFW+N32bf3LX3slr9SiKsNGXM2F7s26Qk390LWxDG5cVYIJTX1UX702LE7q/XF+25h1KnGTp2+iwVlP5kiSZTIruoR3hByhv4m1KkzI2pbO7sNMkRc6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e+1J3Gy2o1h/iT5uqbt179abrQ8bVcDp3LNl1H/vohChm821TJ0qk8FJ7hoj?=
 =?us-ascii?Q?0Nno5DvOKKnxEbt8iXuDTJnjjTShQnmK3TLIbYbMZA5LeJaP73kSoV8nxu4B?=
 =?us-ascii?Q?VkMeoPsDza6mZ1Ks2O2DYc6EOaMw0Ljy0BIUYgBlExIbmZJ70jq/U7aJBiHd?=
 =?us-ascii?Q?Xsz+QiUDnG4JQaGVhbcwNgcogEDDJWMrNuMyl7S9f6CmcTlpN5SRPimwJcUa?=
 =?us-ascii?Q?TlY2lTyYJx/AYBfsW4IUOEpAsLvjYdexA8F1I545e//aGIeUxUK2yT/iaRO/?=
 =?us-ascii?Q?Ae5D2bS6AORPFedr9QE8a4HLzxA+I02TGI7sxVXNdIw7KsAdo2ygymdyMW01?=
 =?us-ascii?Q?i98kyJjbfLliEIhbJLXAzONnYvDs2iRH5H6KQzINqhehkr7l3jjnDtylSS47?=
 =?us-ascii?Q?bzG4D/TjmWXJKUjghBGH7n6vOLeg0V3H/Z24/ZwSJVwXxDgYIRypzCGGtpMI?=
 =?us-ascii?Q?lN+ZboIoueB4saJGusJ5ETicmSFfKWkdFg11ER1elhDo1xB3mhUV43buZTb2?=
 =?us-ascii?Q?kNu40dH8x5J5wf1x8Ib3QmXkjBARqZK5YMGHCuw9g2hP2dGy02cKiTF+slt1?=
 =?us-ascii?Q?tnAdV//PWMn6FzmorjYh9oasxD7M8giajXwlDmTCMYNmzjmBjezv9DxVrhet?=
 =?us-ascii?Q?FAIK+bgmDl1uxzRLEqU39GpOA8JUZLZEh/1rkiAiZG2sYriI4gvW1VgEdVnf?=
 =?us-ascii?Q?dEM1j2kfjtA+UWQ/HWCEvARt5aRtkXRKBGmCNIhVhu6zFy1xWOkUonqQ911c?=
 =?us-ascii?Q?sXt1Q5aEB5DklSHPT/qNv6bhXJuwCXfHEdKV50T1MJC1bHpnGJzTS5CX5P2a?=
 =?us-ascii?Q?ObPwkaGfMqX9zgDbusxcQzz6rU5OdrpkuWvgZIl4RfbhVFld98faRgYO4eJx?=
 =?us-ascii?Q?xEZu1Cl3vxobKXRLstX44E2+Hy5qssFGUqb62NnoFa5fvuhmjS1qzcnfRERq?=
 =?us-ascii?Q?gSvmBGfNOk3LvacoTPzkPp4HGj5cq/bodnhxRX1gSO8HkmZ2tQrxqeoWHTZj?=
 =?us-ascii?Q?ERrXhNbfWgh314GWbogFYa8qVKG5plXzbHtGtpXMGDuJDv0SNe8T6ZEieWSO?=
 =?us-ascii?Q?EIEc7+zn+gvwUIyih3h77Az2E5gccnLVDa3y6YJ8hCTLi5U5WsSb20P0kWB9?=
 =?us-ascii?Q?vS/jRc6U1/obW/wjFbFc20idnNbsB7UPomuNTSq9U7ZeLdjtS2BAGQiE6ti4?=
 =?us-ascii?Q?1Yct8xj30PfKLg/KKVpuG8NXof2c1JlfgqR6DByFf+robChpLVUD5WpTkGiP?=
 =?us-ascii?Q?v5R2T/Fpuj7C6bYPQBlwuup9Sh9ZJLq3zMejiQyE5BphCPPWmR9F7O89FMYN?=
 =?us-ascii?Q?8nxL1wEKDskrsD/pyAuq9CZd2g8ouDIiyYZfLApd3mcT/QeIIBr9fcQX7WP3?=
 =?us-ascii?Q?chZkBLvpcEqrCncsJoFK8jjBFPzFINldGS7YGOewXBxwpQoDaXlY1s4HsiCh?=
 =?us-ascii?Q?JW0DsdF315okyW8J7EnDL7e1MOgAD7C1Ldz3ypi5ugrYKKGO0+bGAc0ECsm3?=
 =?us-ascii?Q?xy2GNZpozT61Esnv78XryV7sARHw1n0LvEgiMmxWw7pfwofXSyEhg5KzvLjt?=
 =?us-ascii?Q?RBv2UXJCWK9d87gY9A2zsy2v5j97C8HL8jjuNLlYHivejdElZuhNbUPtr3VY?=
 =?us-ascii?Q?vqBAfQC2sWz5leLsH1i8cbQT41t2FetSkVpnYbquiilcw1nUIL0sTLqQD/S6?=
 =?us-ascii?Q?kntRxGjuTIkwG3oel63LZZO7PtgGIEq7h/5AIur/Vh5da9Xh2FsvuDS8BR4e?=
 =?us-ascii?Q?f8+BcWzGdLMUgVq2NORVJb+SQg2wtEQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5020e4a-b6f6-4bca-5fe4-08df2aad6bdc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:14:03.8625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 107GcY+NLzO5Zxa7joI/krnM2fa77x1/AxOpEABGebnRXJgKs0H2sCUO9GAiKh9ew/8eCyaW0twKAgb+SXhgw6VBGSnXiMHqJ2o+/1d1tuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6237
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
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

Checking device status alone does not detect queues left allocated when
a virtio device is removed.

Probe the virtio child before removal so that it owns a real queue.
Verify that removal for DMA shutdown resets the child and releases its
queue. Reprobe it and check that the old queue is not retained, then
verify cleanup on normal removal.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 test/dm/virtio_device.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/test/dm/virtio_device.c b/test/dm/virtio_device.c
index c2cd0630d97..64e09049ded 100644
--- a/test/dm/virtio_device.c
+++ b/test/dm/virtio_device.c
@@ -100,6 +100,7 @@ DM_TEST(dm_test_virtio_all_ops, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 static int dm_test_virtio_remove(struct unit_test_state *uts)
 {
 	struct udevice *bus, *dev;
+	struct virtio_dev_priv *uc_priv;
 	u8 status;
 
 	/* check probe success */
@@ -110,16 +111,24 @@ static int dm_test_virtio_remove(struct unit_test_state *uts)
 	ut_assertok(device_find_first_child(bus, &dev));
 	ut_assertnonnull(dev);
 
-	/* set driver status to VIRTIO_CONFIG_S_DRIVER_OK */
-	ut_assertok(virtio_set_status(dev, VIRTIO_CONFIG_S_DRIVER_OK));
+	/* Probe the driver so removal must release a real queue */
+	ut_assertok(device_probe(dev));
+	uc_priv = dev_get_uclass_priv(bus);
+	ut_asserteq(1, list_count_nodes(&uc_priv->vqs));
 
 	/* check the device can be successfully removed */
-	dev_or_flags(dev, DM_FLAG_ACTIVATED);
 	ut_asserteq(-EKEYREJECTED, device_remove(bus, DM_REMOVE_ACTIVE_ALL));
 
 	ut_asserteq(false, device_active(dev));
-	virtio_get_status(dev, &status);
-	ut_assertok(status);
+	ut_assertok(virtio_get_status(dev, &status));
+	ut_asserteq(0, status);
+	ut_assert(list_empty(&uc_priv->vqs));
+
+	/* Reprobing must not accumulate queues from the previous instance */
+	ut_assertok(device_probe(dev));
+	ut_asserteq(1, list_count_nodes(&uc_priv->vqs));
+	ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+	ut_assert(list_empty(&uc_priv->vqs));
 
 	return 0;
 }
-- 
2.53.0

