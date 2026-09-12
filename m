Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CD9C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 21:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6765D80E4F;
	Sat, 12 Sep 2026 21:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0JmSC1SAR87t; Sat, 12 Sep 2026 21:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9C14A80E52
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789247229;
	b=oQTFlgz7PBAD98ve/ttqeFVnuRUahsdlN1dGF0BPvaclUw8CEyDCqQikVGz+L3G/1N6o
	 yKSAmH9+EMx4kNHmmXSymmAgA6StOnjNLTDQ4WgVoPqFz17ovqb4cJqorwe1TK3uiX6zZ
	 x90x2wRPvGhLzuwkpz8UrgT/O6cJ/YVR8oKb6d9OAeA9M/WnHEQaRg1hfMYTz6fIgONb9
	 jtMYxwzZnpTikAe/7PMneNaNQB4Kh9YJeDiiwRQCfBZlMHt4aFiPuA6bVVcDIKv5sFFuj
	 9yIVngjMGduJXYBGHFyx/OQQGp0iafmS0CuVvSsj+/ZhDrU2JcYttkznjMiQyJzFKOQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789247229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=p0JLAIdfnlgbAhq0a1vKeqCUNLJ675O+5ylQz/mO/qQ=;
	b=SOXKxm6SKRte4jlIAFuTUV0hUV2mx0k4jDaqetFgQ6Ty8jxbk2dz0oqCXZ0tAj5BJWaV
	 uUz3V++Vi9ooxzpI2GImaCaFK9HFc4SGctvNERbDEerzONZD0W7nCCgYOT4Ok4Yj0G5/7
	 Tb7Hpdzi+Hf9SAxlD66W2AOFuUAWiqrdte/F0Y6sWU3CcMThO6y5XuzuSo+IpLxqlsT06
	 jRZvsnlffxl9M6O3Dy2fjdUPT2Y0k5qiWnJI/zkalh5Ne39w9bffseMFv+ylHzsuv59Oo
	 u1QYJlwT7Q4+rSc1ag9LDCT6Mr6Ug7YeIztNkiIFt4G5MUPe3oVjrpKuL4peXKT6v1Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789247229;
	bh=p0JLAIdfnlgbAhq0a1vKeqCUNLJ675O+5ylQz/mO/qQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XwTolbOItBqzHl5186ZneTp8+xsR77rT2F+emgBiF6bVMhmCwZ3agxsPbbdV1FfML
	 8Dh6lR0nZSRdp70rBNSrq6b2VSmVbYyw8HspFGwe2p2xo9qoXYR0jmKuYA9MS1DO4P
	 FXTp7TStZT4yKpiuC+sXWlFFfRFYVnJvr1SO3nmwTJJgRIqOky+nojmOEEXfr68sQh
	 H4yCDV24fzLz2wR7yZm/JJAuSgYOF3WGIV4CUpQ6GaDmXsa+DsJCz66KNT5nlr5LGL
	 UV6ZAsf42vOZcEmTsIvThRFpIY7es8Kbz+2ybiF6WVtMUZ4UuIJdiIOi2utaotNbar
	 M+uZVbAvqq1tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C14A80E52;
	Sat, 12 Sep 2026 21:07:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE74E2E3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 21:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFF9B40698
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 21:07:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z94CI__rIYYJ for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 21:07:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3CDFF4068E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789247227;
 b=YADrr96e/yJNTPrCBOfYoWGEp2prBxh689zjykMcF2O6HoMy7xP89IO7xe/v7ppFWmlP
 iFzGF/9CXg6JrEXs2yfBNWLZu4PnEu250RrobjyzODvG7OZswQpXXQFvi/t0wsRhUz6Co
 jNNvgAap2hIztpgFjnc0ZL9ZUhscjc9kPb6JcaT+vnfFTYNSm3XJSUQHdU9+Tu/zyEdl4
 +y1F7rPIdFKFPc9ZeoIR+0SVZkN4Nuu9/ZLS8tVJJotpWZVUmzK7LWo4DUaP9cKzC1r1o
 OD03BWUHphGJHYgy49C4b6KtPdGqKQOdpsIsp1rOGYlKZ4KbdRRlJ8LLx342uqAPknQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789247227;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=p0JLAIdfnlgbAhq0a1vKeqCUNLJ675O+5ylQz/mO/qQ=;
 b=eN1kwFQGaH22fckuPewBlkut+/GGDsA/HwEIhLGtdEEunzP2oLLwQbl5jGaIgOLXwOE0
 emV8Cmz6oFUQYz+cncS2d6ROTSXCSHjvCJ1qTgrZmGRbs3gQekdwwaqCdeITYQ9KhD7/o
 sp88a5CIf2guR4b2X/jVzHRQsbtIDa3f0A/5/nTgpSmaF6EEX7GKyoUX6V2dRpEC0qG8J
 u7uydGpU9Mqi53Qs12x1ZYVE++wmFn6dV5l/I9X+pSB40SR9Mq8TW6/tpscqzDDdGrAmh
 xCpACxgZmVynCCfuMAY9fguFboBsJs1jT/jH4Su3GWWL/f1NS4r4xzKuM0KIKmEhteg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=kATKqGuV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=kATKqGuV
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CDFF4068E
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 21:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSG3zC2D92fhyvL94bwVCSv9q6trmpKHJ6OJa89dtM7R8gWBDDbq4mpNzWKXOF55KFaWIn46RHDNi83crKdVmN/CPuyABxK31kJLusz+tnlYhfaA0bkBZHO/kU+GqgUFyioR+dle9oMraeJcu93zpIeNWFYxrPVwSgLppTOv+co+aK/hl/ihN7UmxQ3hbcoY9NYWNNIF8jIxnd7yrY6jOvYE3BTVEFitapLgf8tMI14rrzcp2PyhEQ6xAOkKptfQSssCtz6GAyP9EmI4ytjP3kJq5Ltzyex28w1CdMRZKafyj2TWldWECFVhbR09+zL6X5h0acB17nCZcb4ceRaSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0JLAIdfnlgbAhq0a1vKeqCUNLJ675O+5ylQz/mO/qQ=;
 b=npbTLYho+4IewPKfPxiSn9QkIvMiN+HM73eztKfa1okqVgylY85U6oGbBNMrsSHzzgtS9Sg3D859lxVuLIOocVBF5Der5tOpgcccNMJOi/jXfyRNd1D5dQgzDcve79+7XRzPzE1XlrJnGRxfjhAvMG5TfyKNblwWrWOEsAQfMtNPzYZvaWS7KGTDUSObOCh8ozCllzWiqPszmKap5EaqbrNqhu4tdQN+HKASEPLhOFYV7FIR6BxM+zxKsphqnKlSTmlToUeGrcy2Ob6N0lticZmJ4L6YOyiKrFJlqDyes1AWrq9tdSpa3sxlh/EhFTM1PZqi6Uxf106noSz6Xdsy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0JLAIdfnlgbAhq0a1vKeqCUNLJ675O+5ylQz/mO/qQ=;
 b=kATKqGuVSYbwwIZHLU3zy6bwqANKyBXbjbAMZCOl0SI6C7AXWlNf6DwdVpKxMgX3RCJz/ft1ZvB+qIuYog/YEdPmP1fb0emdQvLP51J8QmBXw1YoWOzmCcUkSmqbbDnQyHeNipYSn7EOA1yDemwqlN8kXZ82WyXqgJY2LuLJbntvvbZt65MAlkdJdxp7ECTRxWTChLyLvVRsVPIrrmBj4spnmbxaT1D8f6Fyu+FGA9xkqWSeOXJI7zGQyA8ZctsupzsItrjqCwpZD40RWvrwTl9irlTqFlPuMPOznWzetBrSSCYmq8aPuwJaI8CERn57jiCSvfXe4XW5GmelTulHRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH0PR03MB7018.namprd03.prod.outlook.com (2603:10b6:510:171::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 21:07:02 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 21:07:02 +0000
Message-ID: <ec129b92-3fb2-4f1b-bc9d-2a901163fd76@altera.com>
Date: Sun, 13 Sep 2026 02:36:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mmc: sdhci-cadence6: configure PHY control register
 per speed mode
To: tze.yee.ng@altera.com, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <15e724cc7260e5f280ccced5b453b2978490df79.1787710268.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <15e724cc7260e5f280ccced5b453b2978490df79.1787710268.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0290.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::15) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH0PR03MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b782166-05b3-43f6-dc7d-08df1111ca4f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|55112099003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hwTgsik7zazpMoQFzLRkkfMONJKhdFS7CToraqI9/ejFs1FAYHn+cEhmBwpgDMBqVcbRpchSy/2ZMHs3eNHw3XL9fNBO6UO1D+SzmfYVTOQFPxB3JLHLkZTTP9R0Wii0GrU8QxaSdVwTXTpWVDHE++nYi62EuPURXz2k25j/DdfjPzSkidVRXcHLYvyAp3Ld1mmRFViRWGhBZex/SiVqxH3RU8rRlxZy3ms+ELYGOq4qbOvwlAU0S83ee3W0EdYpsldoKdDod3Ex5N7sRMIGtdciBzWRjl5sfBMoFy/J2iR4Sv4OJXwkpaqUdlhZ343o+xjZ8FM3j56BGvNriXaI4awriEIpjborVB80p3E3mJm9nZHPJADL5xXJEbnIqkMmiM5Lc9I0WXLpG8o4ywdHL48qWYDVRhS+pbYsEcUPBGldGltOStUJPT8oJWoXmNDTH+dzLoQ1QIpxc2Hy1RZbYOO8BB47J+13kst1zO8kSJZdVUKilpQlnEgSUTwqIpcsJZ5hk2THc3AMcpTNOxSlh4RbDxIKxr4E1FqzN7krnSGIXM1lcv2/43/5rSEi2+X3Ts92UaqGIiEzI7Ma6uS7Cn6X4xVS/q9WZmE4pPfoPvvagH+cN0O+aWLcIMYZPcuvz3ztDJl/li08MqidqwC3ZG7I2r4LC4HdvOCfR7X5N3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(55112099003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNYb2xTSUJSOVJmMktxdWNzR2gzYlRHajkvaUlJeHFjN3YyZVVSK3QrL3F6?=
 =?utf-8?B?ZGw2bEJpV0NiWjFIdGJ2ZmExcnlFWkE5K254OGdnd0R2UFR2ZHV2WWlxMEF0?=
 =?utf-8?B?OTBCTG1KeVVET3RtV2xNZWM3L0p2OEFzTFlMZk0xOUgxcXl0dUVaUGQ4ZzRj?=
 =?utf-8?B?VHFyOTNmL29QUjFwS2JxQjZEWUFYQzVuUkNCbDdrMkRmUjdyUmxiTUlScy9W?=
 =?utf-8?B?MkJnWGYvV1ozeithV2VxRTEzenM3TEVjSWRaMVhXTk5aT3RDRkVhcktwSlFT?=
 =?utf-8?B?WlFNOVUxMGtXdkVaS3Q2MnhsL1hHR0JVMG1rUlNiSkRrZW9wTmRrMVVrcHEw?=
 =?utf-8?B?REd4RVUwN241NkRXcDZWSlRVWnBCWU1CRGQvMDF6UHVweloxTGhLbEtsbDd2?=
 =?utf-8?B?YkdhRDFRNGdWT0dKS2pJMyt3M0JkS2ZnM291bWE1UkIvL3BxR2dMWGVwT3Fa?=
 =?utf-8?B?cmJram42MFNtMVhDY0VlY2FMYVVwaDFDQU9udCtJS3MzdmI4Q3ZlZ1Bia2NU?=
 =?utf-8?B?Z2xVUWFtdG9ZUDZZQ2EzRmpyaW9MUkJzRVZtVHBXR2dyS1RLZTB3VWEydEJx?=
 =?utf-8?B?REVWUk5oOFZETzArRVhCWHNTeXJvMFVzeTgwY3ZiSmZSTU92V2p5VHZrL2w2?=
 =?utf-8?B?bWZudUcxQlVqb1ZHYmpVb0xMRzAyNW4vSlVldGlvMm4yYUpDUFh2U05LRnRo?=
 =?utf-8?B?cVdENldqVGRXQW5ZbHhkcFdBN1BERmNJL3lWTVBhVVBwYm1aYzB6NzBiU1cv?=
 =?utf-8?B?dmF5Unh4ejA1TG9id2pCTEdaN3JRazFyVTJ6Q3J0ODRRVVB2N1BuSXJrY0ly?=
 =?utf-8?B?blFPRGQ2ckM5YUZkMWdBWndSeTkvUUVSUXJiRXVOK09MZllRUXV5d3JJb1lO?=
 =?utf-8?B?Y0xZamF3bExzUVpvRnVMRHpvWXBwNHJuMVFXN3lPdThZMythNjF3NFpzOUhK?=
 =?utf-8?B?Zm56Tkx6U01TQjQxS1NuZDI3dnpudGd2VjB1UklaYkFweUEwcEJKRGltSXRq?=
 =?utf-8?B?SnpHT0FJQ1gzbkhROFhneDBXTkFaSk9USmhjN1FabXlHc3FQRVZGVndmMjlO?=
 =?utf-8?B?cmZ2bmxxSFMrNXVGWTZMaEZWMGZ2NlRtOWJNU1NaTUhPc05EcnRnK2lBajFn?=
 =?utf-8?B?cDlUZXJLdDVQVklMcFoxVkdTcTF2Wnp0d0l6QUViT2xQa2ZsVk94NklwQ1lN?=
 =?utf-8?B?VVF1VVpkRnE0aGJwMWJob2hIM2JlTjhqbjhmN1k2Smo0Z0lKSDMwaU1hQ3BV?=
 =?utf-8?B?eFhkbzBZMDE1VGFlenIwODhRUHpuRUpQdG1BUEhSQjdpN3BpN0ZhMHBHZVdD?=
 =?utf-8?B?ZGxRNDNualM2c0R6MzRtalkwODRLWnlNYVA4N2NZSFNnSUo0UGh5b3JlNmNs?=
 =?utf-8?B?WjN1N1hUTVVvbWZFRDA2Tk5mbjFZcVpsREQ0RzNQeEFXMUV5ZjEvaSswVy8z?=
 =?utf-8?B?MFNZT3FaaVFJaU5TWjdxTWI5cm9jRm53VkhwUCtQaThMSENwSjJDODIxaUs5?=
 =?utf-8?B?SE9Mck4zNE90YlBXU0YySkRmb1VxS29mQVpCT2lyM04yL0JWTXdlUUNRcHZF?=
 =?utf-8?B?WndHMk1IbGtVK1dVdVpOYVIyZnppdGxzNk9PV0JLcGxXZ1ZKWk1YUEZmNWxY?=
 =?utf-8?B?Nmw4elI3alA1bjBKRXVvdFl5cWxkZU9TcUdtRDBzM2dodno1NXRMaXdUUGFP?=
 =?utf-8?B?NVJKMlBkQUprY2ZBaU55S21KSC83NnUvQ0hURDBVZUlwcG0vQzZXMnplNHlI?=
 =?utf-8?B?L2d3c1RVaHNWWWV1SzBaT3ZzWktpT1lIcnlvd2g2S1cwK2pER3NqTUJGWnVS?=
 =?utf-8?B?N05XdDlpWXVha3E3Vkc2Si81SXYvc0xYR1k4MmVsYmxFU0h0eFFGMEdRV3NZ?=
 =?utf-8?B?Yy8xRGptVXc3TnJlaFM4LzF2SExmSUZWelZVM0pTcEM2aThQaFZSWFhOL080?=
 =?utf-8?B?d0xKbmJlUHBrMi9IY1hMMkN0THk0eFZzV3RmbjMwSzgxWHg0bUdPRkw3RFRj?=
 =?utf-8?B?S1lTZDJmazVXYUplYThKRzBoNUxQVmNMdExHeFV2VzdkamMwb2wzWVhxdTNr?=
 =?utf-8?B?WTc4VmNsbnlIR1A3L1M2dm9FaFBCdXIrMGdGTlIrVEtzTFkyOWJacjlEMndn?=
 =?utf-8?B?YXVMMGNvREpSME1qNE5KbWl0amw4aHQrMFlnWlZqTVl5Wmxkd2FnV053OVor?=
 =?utf-8?B?eFZEYnY2Vlk4NWozZWpzNi9qU0Q5MXFSeWtqYmR0eGk0UDd3R0NZMmRPS29y?=
 =?utf-8?B?ZUlCeTdtZUJxcmtZbmJrZUx0MHExaG91ZS9NRE9YeGtLNVZaOUlvVW8xSk80?=
 =?utf-8?B?ZXp3eGhBL2NkTGRoUEdrT1pUQ1dLeXpZK3NnR3ZhT1VNdFVOWFpYanplQUtB?=
 =?utf-8?Q?FDCSlFHowIZC6ZW4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b782166-05b3-43f6-dc7d-08df1111ca4f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 21:07:02.0481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbflFvMISoC0RxngY/ZCqYiFCcg+a8TgORnhLuZsV+sP2sKbHvyiBJlyY3+xwkyDVUbEicYMq9NHXuPSLvosyRiS4+M92bWBVlaD6hiLreU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7018
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

Hi Tze,

On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> The PHY control register (0x2080) holds phony_dqs_timing (bits [9:4]),
> which shifts the read-capture strobe relative to the data slices.
>
> Extend the per-mode PHY configuration arrays with a "cdns,phy-ctrl-*"
> entry (default 0x41F0) and program register 0x2080 during PHY
> adjustment. This lets each speed mode - and each board via device tree -
> select an appropriate value.
>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---

The PHY_CTRL default needs to be corrected. All six tables also use the
same 0x41F0, so this is not actually per-mode.

Please fix the defaults.

Regards,
Tanmay
