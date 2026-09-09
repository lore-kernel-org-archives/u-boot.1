Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D38C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 09:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45604406DD;
	Wed,  9 Sep 2026 09:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9gAnWX1mIyO; Wed,  9 Sep 2026 09:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 916E2406D0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788945182;
	b=AJoWedKhnVT6pC6PsnxYYy+RlYnchi5aygXaZkyK5/KbnJOIm8J7yGVLrSzm9+YZWoE6
	 NRKOCI5wWTwsiJHvoou4GHU17hwbxxAqgdbDEpnPB5t9Lix/CKT2ymE+S8uGrlROIGJ0f
	 PipdJEpXdJl0zAKJjPqxUGUrnjP3yEbvEq5xtPtI+bDzmRr1vBHNzMAVevCE6oHwI7Yt6
	 QBn1Uq/+d4lNWgniNTA62ZB+3MremmAIXZREbfA0kKIzO+VbRuXdqX8Lu2rfigmru+Qt1
	 XkQe2rOrtqfcw+y/Uelv4PWQCs/kDWIqaEhGv9AtovkXmptp+HNC6DiAv1nXYIz4Igw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788945182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hfEodh3XFS05ZdEdHcDxJeQLRiEH8TOfdytOWnkIey4=;
	b=FGub9vGbV907TI+HY0joGMJAAA7RXA3OFHpCaU98HxU4+jPID/xb2lEQNjHDnyYydagD
	 YU9fL4vPCzTpEsOa0D3UaXfKwKwc/GYTPPy0W28CDgrfs1u5msA+RWslBIzFCLtXinOg0
	 JgC5KvCnbcZdVx2Iz6Hm/oinZJvPNeDzw8BqSh1WzXCXV/xn4PD0d4xHus/OVJKxbJFIH
	 vHp7C1N1tZNJDBhD5v2c34hPOUZZH+TlEDy62NNuB8qhq0rlYV5O+hOHMXwdwXyl7KryV
	 v9N7995X5G8OFDfwc3tBE/d9FXuSdgt/R1mc0DLt6krRx8qn3SyYHXmO/ICZCY6h1hQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788945182;
	bh=hfEodh3XFS05ZdEdHcDxJeQLRiEH8TOfdytOWnkIey4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CFna/kXiusMZ+4TQd6uB1SAju6vVBBrp++ejpjlRn1kAt5ldAbMMjXSuh3sFAe4Ax
	 7yYc+0IpQKYMtZMPotVx5Rg2QQfpWzxfSAimcoQ6BRdWlIE2O+s3nKVDQ/PQAxpiIK
	 LHSkQ29ZVoHCoSRpV8R/f+Eptj+vIVTTSEolBbOHSqrAvBoW4dZdw5j5m8PMgQH5ay
	 emuHoUxhOzvjMwaOfqfwBk936vSwWOriFqYUriHIAtgDI0dGhVpn/N6eb3YwOJfkL2
	 NEBV5JPTKk1Y1Hq9D8wZ31a0N1r9f6UURQAvRYpX1g0wJWeLtXQgsTVCuu4dHJkwoe
	 mRzimbiqsdSeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 916E2406D0;
	Wed,  9 Sep 2026 09:13:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79CF22D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AFDF606CE
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bXympy5FqGjz for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 09:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 174E660626
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788945180;
 b=HWq1AfqUJLN7LwRar8bONPq1qtyL0v7xpN6JkV98W2/IT2oql+v98etrkSOG7yaPz03k
 nQJXDzVvuj6RRq9joZPqG5GrFfDMuwUn8e2Qb5DlfwVMENbqerfRsDLCvMBcz2+ezwax9
 HXmFep2lP22wYk1GUq3QxA2x2lX3NkYqSNjALI6Ov34W6/gzQbeqqpW2BaVrd3Wuk8He+
 qBMFXd7c8kkA+eF10OyXqSvq4B/KpCNI8xHhvV4r8H4B6NODymeeFgF/mIW5WwaZKJHQ+
 dLuRYtWb7FTLIHkD6UrXbmgk3CD5XtgZm2bhPuN8he5CTLB+t6RLd94kqPgQp4697nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788945180;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=hfEodh3XFS05ZdEdHcDxJeQLRiEH8TOfdytOWnkIey4=;
 b=alO/TfWFiq6CpIT19l8w9CHjXeQiSBkWJ4hg0I+QjtaWPbWFJA07MGoSNxiorfmfYg0C
 8xfen6gzQGTb82lfKrgIkKjgSgmSijW427u8Ar2HRwTRVhiC/ujcEOyOwd4HQR1o7lJAq
 xPP1Of0yCFwW7EWq7LBbTLtwyjSwb5nlNTm1PudDqUn1MCoBkvurTcmp632SW9yWwEPEl
 /PNz/5iYpMNUWx/Di1b0q4ntau8fKfcueUw4XUykksv18CXtUsLQmtECJ0Cx+JO7RUeuY
 ZQ78/KXaMoMmBkcVXj5VJGQP0OE0x83mAtwDf5mfCkOtHhwYB45B5J4VurFxzAkV5Mg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=C4GdloFc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=C4GdloFc
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 174E660626
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7xnFAtqU6mlfid+WBqpZDjpHSobOEHmGIM5N7yLTqFTy3IRyzVLAzBfuffWbLe6ifV1jXekvSxRzemLB6GEoUTEyQVFSeiFY4mMLQ+rC7GLUDtehuMHKTpqLORhFezn8tX0OWkjpOPQ4QoTAca1wVGlLVFSMDxK7vEj9ecjZ2k25esTQEG5t2pU1bp5fYiojE7z5JknbP8TS/dX4P+7sCHh8YM7pKr9+QYLeOs0MDG1K4FXaig6u+a0NcEx9MlbgugFky6zX2Frm3GytSEGxB86G5f8XEnvrP7dKsLB8MVWgKSt+By6IgAPLsVDSNFGZyoMTJdsJfrV2GmySJbbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfEodh3XFS05ZdEdHcDxJeQLRiEH8TOfdytOWnkIey4=;
 b=NwkprT0sNNds/0M0DhOUpJ84BRKgajsOXi36dsBgqGWiHFr4mi5u0eOWbUJlozRi+DIzmIVkhip+4zQKlLZXWjWT6a0bzO8zukh1QnP+iCv0FulRlS7xN6coFcU4buoYlvL1BTP7m9PDS5fZhdnN5xqUi0B1Yhhq79rx/vIxB0BFJBQxVK8D10BoUsHosAFI9JY1PAiimw7c3lPD0T/fKOiukXrcVzW78TdHibZ7qE+awiHO4yyOaP+0x3ButCHSzgPe/QXZBUSBnV5tQdkgKynVbSPBFJJ6nbtHE6juP69pGfa1mezFooMSqk1z7kgZqAa43nDryIGAmQltQ3tJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfEodh3XFS05ZdEdHcDxJeQLRiEH8TOfdytOWnkIey4=;
 b=C4GdloFcjG78GZPwJrZUebPe9nioMGrx+RGH4DOeBhtVA4E+GQ/X5iGFvqg7YXqjM0O6E4huLiZmj2L8SnqeoIwbs+nBIFeA0Y0TVBsunkvKrZXzqoCYyK3Av0dXquHKt87fyH/gKCUZlXaQXSAEq9pYF7iogd6SF9tVhM6Yk4pWYPFnXgt8VlOx+SOxj9+abclgxjlAZltvr41eksyVNrJbD1UQq2ZAmOp9OWGDN/eWif3GnwOzDM4oaPZrEvlE+rNH5sTkfXB4A7Fn8kNP1JKmna1isIC3mUt5SzriOJsZtlUcy0g8Pp2cZqDnUrK7dfcagwoKnETSXHCxaNplaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 09:12:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 09:12:51 +0000
Message-ID: <f78cecea-5651-44b8-a817-18c084001354@siemens.com>
Date: Wed, 9 Sep 2026 11:12:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] mmc: Call back to optee after a successful mmc_init
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <598cd2523e3b2a8b7a613468747fe740b1f35fbd.1788879818.git.jan.kiszka@siemens.com>
 <CAC_iWjL9fOYDdyfHRh+LHAeAh_AjNA6tajAFsjb59V6PccLwPg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAC_iWjL9fOYDdyfHRh+LHAeAh_AjNA6tajAFsjb59V6PccLwPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f812964-03de-428d-c6e5-08df0e52865e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: UK+zdB1KmflHTpaDDUW8R8dCVhBPWWzAinHaC36Z8F/Uahz+C2AaAonSzY0on4SpJ6kn2lTzSHT8kwP7KrwvtvLeYYaM+2PPSy9KpjjpzFYHro40b15ynR1bWbK1MPIbEX2yrRgN0CieIi0YslGdv1HBpScY87AdNq3wzF1O2SkrHUhAoq4ECR4yvxHkRqnEquAx3lQCaIC1U3UQrX9PqxPpLO7UJUz0V+KAjAqHEdSeNkhRS9sHe1zCG4h556EvVNmomvN6AZDaLHRZa380pXOZrkXq2eGKUW1EaG7iLwL1CLY2ofAlJy2GXm8IECjHRuTRhq3FsyYBhUBhXjR2jXwQ8tHP6cawrVqdPzcnG6nozR4vZ/bwO9GrJK4gWelECCB3R1cBCGheYbKqUzdzaeCrvyRrsfC9urbFJdwzAmel0trnWHKA9vtfnrT13ZQkQTI2Lzj27TQThSOnaLgGKssrC1MmwfyczAd/WbpGPRY88dz66U53l82ZXLt7/Sicu8f9rbNuqC6HH4BIo+zaqBSxj59/dDnkU93xPSJsTNh4IJmOloFkYYRaFc7IKYZdRbKSrk0dVD7zzI3Mtvi5pDTEKggLl629+Ocblj8mIwOItowt39ID8TT3UccmRkfTRg/45mTetsNCuyA68DWgC7t7T9znkAYHplqjGPBvScE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9GR3lxeXM5bHMvWk93YlhMSThSU3ZBZVBYMTM0Qlp4ZkdVazFDNkFDZ2Er?=
 =?utf-8?B?V1BiaEZTVjBzUWhkUkt5ZXpYaUlraVBPeDNINnZORTM4cDJzQit6dVFSMlNk?=
 =?utf-8?B?VVRHN1NlY1lKdUVxMUR1N2w0c0Z5QVoyTmJ2cE1mZW1EYVNJTVRVZG1DWmlQ?=
 =?utf-8?B?YjFWcWhkTitiMzBycmNpVGIzcmpnZUpRRlYzU3lsV21RY2ZUb0JxYUJYbEsx?=
 =?utf-8?B?RHlqMU94cEVoTDBKWkx2d01JY0FwVDFZOFBOTEZDemNEa1hPbnZjOEtRejF2?=
 =?utf-8?B?ZGpjZGJ3UFM0c2k1U0ZaazB3RzB5OGFTcGcrWUxnOURSRXF2cGNMYVM4ZXJX?=
 =?utf-8?B?MGV3c3dVT01Pb0NKcUgzWW1IdEtuYmtFKzdsRWkzUmU2UDY3Z2I3UWxaMVhp?=
 =?utf-8?B?aXBWYUVuVHhJajE3Z1l3bXhYOHYxd1huM1V1TnJJT3h3MXhIQUFIT0VySzJB?=
 =?utf-8?B?SXpmRkpsOUFUeTk4YkVuNnR0aG16QmtPUFZSNURPcW13Y2o1enQ2N0doUnNU?=
 =?utf-8?B?ZHZZeUV2UklqSTFGK3ZuaU1LUHRJZmlURTFyc3dlMk1zaTMwT0dmOVMwWnBD?=
 =?utf-8?B?K0dQK1FUek51V2dGQVJIOXhXSmdSZUVOY25JSGRqNk1PQUc1WkJwMHBWdnRS?=
 =?utf-8?B?b2s0ZWtkTzAwS05NeGdNMHlsc25kM0E1dGkwTDF3VGN5UERid25HeEhwUjFN?=
 =?utf-8?B?SVFTcmVwSFd4QTBpL1M1dHpuSnZXbHRxeTQxRXBWenM3T2tYMmowYUpGUGJG?=
 =?utf-8?B?Z09xWWlDaVdyRVliVDJZSEYzWUxwdkRnQ1FETzRkRmxDaXBNSnBveEZWN1Fl?=
 =?utf-8?B?WHFqN1VHZlN4MEJVYXJDL081ejRPRGprM0djY3V4R0NJU0JWZjBwY0RtOXpI?=
 =?utf-8?B?YTl3a0Jlb0xlc1lFUmtacW5naGZOUkQ5dkovd1grRGNwUWRVS2hSdXk0NnZS?=
 =?utf-8?B?R3NSNGpLL3hvVTBEekI5ZDlUdklUdzBXYWNwdTJyR3VJM09qUmlBWTNUeTN6?=
 =?utf-8?B?TnBMUk9CcHpUM09yZ1dEZU4yTUxEWldNWDR5U3BHQkJwaUNzQzI3Q2NWcTFJ?=
 =?utf-8?B?aFhsMXRldU5oYk5uZnBoYkpkK1BGaFEwdU1CM1VZNEgrZ2dtSmpram1Lei9T?=
 =?utf-8?B?aHA4WGhtUnlWdDVOMFQ5VVdCdEkvRVE4aXZiY2ZZN2hOeE9HSy9objlsYkYz?=
 =?utf-8?B?R2ZTVVc3MERTclFEREtHaGRvK3B5ajJTZHhBSVFkRVU4aXh3VkZzaXI5UzZT?=
 =?utf-8?B?dEF6WGRSZmExV2xTSFlrQ2FBUXZrSmdYZ1lEZStXQm9YbTRQTFA0M1IzUnND?=
 =?utf-8?B?eXFTcXJkWU90MTNtSEhWRWxDUENzMnIwTFRyTGxLdjdjUWluQnN4QXZGdHBC?=
 =?utf-8?B?WjhwUWxMNUFIem9rMVR1NkZsWGpvS2daYkRIMzMrMFZDZ0VRSzE4cGFPNUls?=
 =?utf-8?B?bk05VGNMUlpBOHI1MFRUdThnMFVDemZFZWdoUWdKbTVySTdaRFJXc3dSOWJk?=
 =?utf-8?B?aHNFUmk4ZSt6ZDMzcGhQaTNjamhTVWtGNnJ1a2xzdVBFTDdXWjZyZUtvRnJK?=
 =?utf-8?B?cHAvUExoZExtWnQ0VFNnVTR3NjcyUzJaTitoT2w1K2tRV0YzZEtCYU9VWUVy?=
 =?utf-8?B?Zk82dEp2LzVMUDNaRktBbkxZaHlIUkNJTEVwaTZuOWtEbHpyQ0c5d29TMzQv?=
 =?utf-8?B?VURmQy8rSTMwREd4TDB0M2dTSnNzdmc0UFFrcDJBaFJRVjZYeVlwSUFjVkR5?=
 =?utf-8?B?MnhadXZycjVQK2EwY1lQRzdRRUtXU1pPdXRwc21INzFqK0wyTjJBanZRNkJQ?=
 =?utf-8?B?Z05aUzJ3YXlOZm01MzVnRTNwSlFIeEFWaXo3RHYwTVR5cElzS0ZkSVpseXdx?=
 =?utf-8?B?SHFoRHRCUmMzd0dhei9OMGsrK3NDckdtZ3hIUWpuSmtvRVpwQjJnOU8yZzU5?=
 =?utf-8?B?MXdtQjJ3MmxPcEdmbDUvQUl0LzN2QkJ2NVpnSldOVUhZeHdQUThyeDJ6Y2dJ?=
 =?utf-8?B?c1pTMVZrSXpHZUtMb1BxVjJwd2xiRFBobHhLL2M5aXl5MHlvdFhITDh2T29N?=
 =?utf-8?B?TzFlODhJeDEvSmd3amtsdmFFdnI2ZzYyam5qb3o0QUV2RWN6K0VQMkx5a05L?=
 =?utf-8?B?dzliT09wSWZYaG1HeW5ETE41YVVxcFI3aEtJU0h5UkFpRngxczJ3SldUcmJs?=
 =?utf-8?B?dFp0UzAxUVZ3VnZ5OXBmdnVWaFh1WTVHeWRvQWdJS2VocU5PWGM5ajcrMW5C?=
 =?utf-8?B?RGw0eTBaRkdEUDNJWnVHR2xxNUlsenhMYkpZV0Fxai9xbDJVSnVWaTVzRmF3?=
 =?utf-8?B?VUxlSit6ZzdsakRPU01ocUhaaE9VcDhvNUdqTzlpSms5U2hrR3hpQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f812964-03de-428d-c6e5-08df0e52865e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 09:12:51.5523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1IDE3Z8ayjvPaPPpXy1iUETxP0LWtlFUSg7RmFVvdNT99Hv2h4Klm5nxvb4Ymf26KFXtja0c0KY+cSEYYj6BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9257
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

On 09.09.26 09:50, Ilias Apalodimas wrote:
> Hi Jan
> 
> [...]
> 
>> --- a/drivers/mmc/mmc.c
>> +++ b/drivers/mmc/mmc.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/list.h>
>>  #include <linux/printk.h>
>>  #include <div64.h>
>> +#include <tee/optee.h>
>>  #include "mmc_private.h"
>>
>>  #define DEFAULT_CMD6_TIMEOUT_MS  500
>> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
>>                                 mmc->cfg->name);
>>         }
>>
>> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
>> +               optee_rpmb_available();
> 
> With this we'll end up calling the optee bind methods again for
> discovered devices calling bind_service_list(). I haven't tested this
> locally yet, but is there any chance this ends up binding the devices
> that depend on an RPMB twice?

I don't think we will have an issue here: Either OP-TEE isn't ready yet,
or RPMB wasn't yet when we called it first. So I do not see yet who
actual successful listing could be done twice.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
