Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA05C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 08:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04DD74052E;
	Tue, 15 Sep 2026 08:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdsBBVglqzyH; Tue, 15 Sep 2026 08:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 14CCB403E0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789460605;
	b=MLJ0HllvOkovTe2JicTUEICd13EyvaxWF78DuzuG1Ev5fT3YSNqnOK0ThsqxrUVvIhqp
	 gZSR943QxBxZHZSDxPzkNWFgjbJvfGgoUOeFonJD2pZxEqkKEoFyi0l5066/UErBDRiOu
	 Mhu1c1uwgIWEMPnhdcLjggXzA5KDYAl66MmcATBs3Jso26QGgx4x7YndJ1jkZUYrJ+RGB
	 sslUtGYLXcG5SBLomjNF/y7VJX2MRAlzntBPe9N3sAUbKHnxx7NVnFiym2HJ6S7QiJDPW
	 DD4uSf56/fXLblVOP4oh8/PGm1/2HQYLC/psttUMUBYM+ym3HXsu9MIFAZzJXLM4xeA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789460605;
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
	bh=m3GvKfpBZ06TZyRuDbTHfRnwX80z59XPZKUtIDxij/k=;
	b=TUhw3tjl2+H/hLgCDk+Xitcm/w67ojLbi62woC2cXpW1pYf/BFn4gpnEFiUGtxUtOlOt
	 M61WgyNVv4saiFp9YACGZFBDblK/9ttKXhT/BNmi6DT5cRtCgcjUhBhbVcXhWUeMwX9+I
	 N+Uz43bosVo2jPMJ4QbLRAOrxPRoLK823rwP0cwy5KoUXIa/fBnEd/uGg1x0/fU5ONtTH
	 kyLh4qcSWsxGU/lo0IKqIPNw4dXkRCbRwYjkV8JqiRLxsBGjtrLqAERyXBBqZqWyINchz
	 mstit48bn3O6KcwoEM3ZVUu0HN2uGU53OwhacK5LEXeDH+w221mDTz3nIfVA7zqlM7Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789460605;
	bh=m3GvKfpBZ06TZyRuDbTHfRnwX80z59XPZKUtIDxij/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qDm/iaRrz26y6ZoVO9Aw18s74XuKMdsaJr0hCix8OJIuLTES3yB1PWkbXKhaqktaG
	 PdxUIlL5TFrvyoL/oFtu2RF/bkW8Ehl2O0oSSV6/mW3JDrwqyqH6vlmn/orvWdRAxW
	 zeRIPd1Be1kKR/3X0S12gkQ3I7WRp5ZwfQ9AOyrZ7LYFtB43jC8gXvkYAb7Oq52K+M
	 yV4s2N6bSXcO0N0/1IYzKfqbehEELtJg4GJZ+gh7SBuZapUv2J2m+OAJt0KYCBM2IA
	 DGZ1uyTEwbxckFQt4kjP1bTrhOEriJKa/tk2xJbzZQvgKSN+g1VI8SX0YoBwjUO1E4
	 9hFRDKR8Y2fog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14CCB403E0;
	Tue, 15 Sep 2026 08:23:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8190C493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 675E880AAE
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:23:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ylHoCXJoQLOT for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 08:23:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D246D80AAA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789460602;
 b=I6vZrzTEDLRnptID+RTzUTNwLAGbEPmooXwaUVOAiMbR5ub7a1hm1ZCDsP9d9jFFYCX3
 1GxKWoahG9IO75vwJQKNPCgefV3ZFsWfbgcHFI3edRUFKakNM1jWxFChloFW51EK5TJ7t
 4ofxiGAKwNL2XLDDJA4J2b+Dv16MhjaaCZzrsUaceE9/cntmmfRqJhHgbIeWRd1ExJO5n
 WC9IpNmwGGzcuG2hW409ZW3cdOLauLLGjl/q8rvqJpmkH8Jxl8VWxk66vbQLM5Di+ZiH6
 XuAZZnBZ/tiOWsKvl052kiP8Q3/3RR/a7S7TfnxR5vo6P2ziQmtghnPCLStagL54d2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460602;
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
 bh=m3GvKfpBZ06TZyRuDbTHfRnwX80z59XPZKUtIDxij/k=;
 b=BNFa73JqRa4FCvO0SyAki1L+5ODqIrVeGLnBCI1iy8B9xgC1cMR8+bczluV4DN78FgcL
 slejyEGPMB6Ahvjr/WA2tmVUPAt7+Go3xOGF2QY9rUQcFUkWIMHV7i9YdP+5PinYOymwa
 H0JI8oCFXvPQGKbyQn2EvWwnJG8F3qeRzveJE7Yrmye3gkeE/cP5HkfmoQnwJqzY+EwCb
 ldvKYGu1McZVNFZxd7sxSP261uGMIxkEmP0T6849PjI2Ow5G+3tZc40tz1Ca0gG7ZqkO5
 DBn+NP7lgzHzUU3/EmuP+K0APxRtXCLvq1M0pNqvavWP3RDEQg+FfEqxJWMqT6W4EQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=dX+Cgy2z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=dX+Cgy2z
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D246D80AAA
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXfRBDhOFlfWqPcTYzbG4srjuSthm3EHgm7PMHNZFtJVpu87BSVGx52icflo2LlNU+LLPZsLKxzvpggDwqWUJCspGlQwzcky01l7bvkQ6HeqlsFX3eWLFcIz7NhNNtd3ZzIl8w+pi2iPLC8FCP0vN9tZTAG/bSR0N9D18XCpD5aWGni9VshRy0GQfS+RSwM2v2bR/n7SyMz7fo5LQIdqYpC+CV5X8C3a753HMzI7pk/59Ce4SrYQKX390rCm6BcyqsousYKWePz9XkSY5Jx/HH4EOek2AOrmwYgFnHWYzAnGQWcQ+I7M9zRAXJ5Ussc3v0qMI0aVuZzY12gIoPYKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3GvKfpBZ06TZyRuDbTHfRnwX80z59XPZKUtIDxij/k=;
 b=kd8Eb1miH8BPwrJG0VpxymDSs6v5GmiYtYxILp61/AZncm0deS+cFa+yafCAy5GDLZWXW3C/iBJGddot0/871lwTzG7L4ewpAKKXn/ywjMmi7mNaQzM8chygYM+iH9iZ92wRECN8D2yKrsQyqS33etoPA1zJ1UDH9xJraqibhFexRzx8KqhR+EuI9iBYPuC8LcjRUu0UKuzyn7wkrEJcJ+O1bQesc3EB17ymhMWaU3kcZ4bF0Tm9hMbt+glG8+NqR5ytfec10B9vElKLgpaI1mHDSMHyMb4AiexyOerN0XzT3QkYKTq+ipJtTXSlPxzz8Hq4ink1iSTFczUNb/AfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3GvKfpBZ06TZyRuDbTHfRnwX80z59XPZKUtIDxij/k=;
 b=dX+Cgy2ziz0EoEWC/zvLxV23yNnKPaLmG3hRkFhrZ5CrL1JJEATXptx/29TCB0h0ucg45Xn6gQiTKuiIrMsk3DYkf/PaqsF/5ymq0Z47/0DucXAKOLGODR1q30BZaCUzArCVFkxe5oysCDmu/T7oNt/V69SBMvrExk/jWZO6EcWtCVe+S0ati+CLyY2a/pEKUewg5H2bpKzmmNktahBVIPQvDSn6UKdrPwVriBz+Adlpb0p1NO9HoCPwFb4A7ChoFSV/F1be4Yx+nk86PvX/GFLLV19EWYPPF7CU+2KBR7hIrVOoF+dc02oFp4gN8ZqqHgBYDRr5O1ETK1Fbb0Slxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by VI0PR10MB9032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:215::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:23:13 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 08:23:13 +0000
Message-ID: <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
Date: Tue, 15 Sep 2026 10:23:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
To: Tom Rini <trini@konsulko.com>, Eva Crystal <0xiviel@gmail.com>
Cc: u-boot@lists.u-boot-project.org
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
 <20260914173412.GD1764417@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20260914173412.GD1764417@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|VI0PR10MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a75f81-0c2e-4c23-0c6c-08df130295db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: F7giXMQEj4d03gP6TbUq9Z7Yj9j+mkc7hs4hKl9vG0jxhZMUR4bFg/+yP1MbFlvAMXoMpXOWfeOjTjVF9Qtz6oP9fp9LSLInW6u6HYUT9dfc9ZueBljc4OctSLU73URUgl284uYuPeJ5Eif1wTpYCJ6LSMjMxB4Z7yhwwi3Khag9wSjJFiXLVVUXrsQjMIWuiGV1dTpc9qheKIHOkx8KsOWrPmTgSvqdetx5JguSCL8aE0pgKRUpQTDnlu3q1dVXkP1gZE0e7XCAqepYnaN71e/eITo1bIhC8EXptG44KiBNrsbA6TYp9/jGH98LvmUHEUVguA18ZUTGHD40oUK9pis3pZT4HzmrV0ynTLlVFShOBDPI0Y/J5qhmqIkJoHEtBmOQgQn5TUFSXc+fa9mJsIeIctq/yb92diywo900oxl7u0HUJ1YOyiRBdVFp5MNHaqwdiGRoQdleFt71LpDJ/DZ7eAOfTKbjoo1yW/FC1AdONwtlHkP7AONyeTNtDZGO2y/OR3MbqltcQbP5NVsfm8MFNsZD3mPvaZj4JwB76Xi9E11/QKl7P60iYerOCQfWilP3maRGfohl7q5haknpgGtEieiLe+FJqoUhPKSWeY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(55112099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZSt6REk5T2prWk93cXZQNGx5TmN4N2tXZ0RrMmlzTUhyalArbng2d3pMNHVx?=
 =?utf-8?B?UHIzTENxcy9qTWtrRk9xYnhkQU1sWHd0ZExEa1poQ09Sdy9sVWJXWEFrelZt?=
 =?utf-8?B?VUJ4aUpnKzdyaTVBVEdOa2JBWFM2cHoyNTdGSDQ3SlB5eVZONEhXbkdZK3Jq?=
 =?utf-8?B?bXU1cWJ2aFJxNDl5ZWtYTzEvQzNpZERRN1ZCYWFIaWdUY2E3NWdQL1pHbmtk?=
 =?utf-8?B?NVFlb3FSSDJndVRMcURndWU3SHFRaEZRalRoRlBUVk54N0g0eGZvM20vZklj?=
 =?utf-8?B?dFZKS3NEWTh5NFJaQjhtSlJzc1J5ckcxUkhLV3ZZbmMwaGU2eGpTNldnSEVq?=
 =?utf-8?B?MmpHWTZ1emswblRHMUNEMDFDd0kzYlJmT2JkZkdpRG5oNGZMY1VTdnhQRC9t?=
 =?utf-8?B?NTBIMzNkOGxPYVdzMyswSDFDcll6SExlbmRKQlN3dGRGT05HT2prcHU0S2th?=
 =?utf-8?B?NXNWSlhoWWZjblJiYThWOTB5VG1XODhBYUhtMHJIVlAvYXNQanE2aUd6U2V4?=
 =?utf-8?B?M2dWSDhBa0lMQjdnUVptK2tYcXZaS0VJdnZHOTRxN2FxV2lMMG9tMWVBOUwy?=
 =?utf-8?B?aFFieHJxOGFYbzdHZkZvRmtnbGp2Y1FsZ01NNFl4UTVyZmFPR1BxMGJoV2hz?=
 =?utf-8?B?MURaTWpVdFJ1dnU0QUM0UWZLRi9mWHVKZnhNYmhSNW93MXFnem9jQzluaW4r?=
 =?utf-8?B?UzgyM3RwZjJVZElkL2pOTGcrTTVnbjNKUWp2OUQrektRRnhMWTlqQXVzNnl1?=
 =?utf-8?B?K1BLVHhxREFYcXE5SGNHM0NJd21TWGVHdURTSmpIdnZlL2ZHdDFvNGZRYjk2?=
 =?utf-8?B?Qy83N280UFUxRDRXRG1CSGs2YzVhKytXVFpEVXZQNmdxY2piZXlLV1VocGhL?=
 =?utf-8?B?eCtQZ2pmMFNQcGNwbjJkeEN0aVdKR09FMkFRWjY0NUkwbWF5dzBUVXMzb3Jh?=
 =?utf-8?B?SnMwVmF6ZkZQQjBGSDdLdHNBSS8zZHlOOFY3d1ZGTFJpUENUVDh3VXIvbC81?=
 =?utf-8?B?TTlqODlzTyt3bXY4MEp4UFVoOGI5eUcrdXZtVnR4bjNUeE0vWWJlSFJKQ0Nx?=
 =?utf-8?B?YWRnaVRIQWJPQlVYTzJJc2x0SHlLQmw2Y2RWdGI4TUZBWGtReFVjaWdGZVQ4?=
 =?utf-8?B?U2hpU2RiSjY2YkJRWnl6RHREQWJ3bFVUNUtIY203ZFVhRGdkMTlqTTFJcG55?=
 =?utf-8?B?OFc5VWZRdFZiTTB1VVZrRVVOdGh6cC93bFpVOGRJZHB3dy9OTnRISlovV25T?=
 =?utf-8?B?Yi8zM1ZhZXVhUUFqTDYxdGUzb3RGbFc5QUQrd05IbENwQ2tzOU9RQ21naHhL?=
 =?utf-8?B?ZmtYZW5HSlVOakJ5UFQvZHBnanhudnRPbmVEc2Mxc0VSWEFkdGV6aDROcWNz?=
 =?utf-8?B?Qm5XcXd1cXZuN1Q5RVl6SCtvM3ZRR0w1QmFZZC9aTFJsWmlYeG8waHBrck5z?=
 =?utf-8?B?UUdqU2krc2pHV1RBemw4bmNZRkNFSUhEUmFPa0dhcWpCMVhRbENjMkd0VEZ2?=
 =?utf-8?B?M2VNUm1aQksrNXdScFdrS1Frc0pGUGVwUXIxNzhoN0tUZWc5emoxYTN4Z1hB?=
 =?utf-8?B?dUwwZW90WDlhc3NVbGNTSUdLdktVcnMrNjVGcnM3ZW5WTTBPcnJ4cU53VE5p?=
 =?utf-8?B?TEhMakQyWk4zYkRhUkFONDdhQWZrTlNEaURWS0ZtTk91MkZ1RHI3TE9ienR0?=
 =?utf-8?B?TDVaM3J5QzBOUFA4akpjM0FBSlVLQVhIWU9kaVE0aHkwaUJnM2hPMHBFY2pu?=
 =?utf-8?B?MDNzdDVob2JwZVlvRkJVWkhUSEU0L2tGWVFaMFpqTEplM2I4SzJiUUM4RlIy?=
 =?utf-8?B?RitUUHFhd1hxT1JyWjRPM2hVcVZzMlpTNTBqRXZWWXhpSS9iNHhJOE5UOFIx?=
 =?utf-8?B?eExBcG1GcktTTnhLZ001NnZpeEdKZENrYlJPVHBJR1hXOXFicFVDM3I3Tmpt?=
 =?utf-8?B?QkdJVjhzOEJTQ0lRb3VWamNFSEt4ckREVGNYbnlRMVIvOXkrWTVoUTREbXM2?=
 =?utf-8?B?SHh0VzdQQzA0YktqRTVYOWFmY1N5OGd0V2MxdFhwTUw5cGF6NmFOZ1MrRGxx?=
 =?utf-8?B?L2RjZVZZWFBBWkE0K2V3Nzc5UFVwUWZIQWM5LzllY1NtYkYxdU5WU213OERu?=
 =?utf-8?B?eFh6YnBTNG5qcTJpT1c5cUtSaTF5L3E4cVZCM0dObVNDaFVMV2FXOUpvMS9V?=
 =?utf-8?B?U0VGaDdKMVBTWE1YTUZjK21JbXo4N2RjQ2o4QlF5RWNQVXU5QzRTZkNwMnZn?=
 =?utf-8?B?bEhDdGZ3MlZiSmRVK2tjbjV0c2R1cnZkWVlOUWIxQlRkRVZmNmt2NElWMTdZ?=
 =?utf-8?B?Y0Nxb2NldktPbGQzUTRBQmFxc1JiSmM4R2NoT05ZaW1CUDdYUStXaUtKN3Az?=
 =?utf-8?Q?5atd4ojx5yTYOfNA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a75f81-0c2e-4c23-0c6c-08df130295db
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:23:13.6920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Io69KXLoHFEqpzmJS5+o4DGsORv0Y4lknpStIKOqFX6+cdBdeqz1VQ2mdxSt4N8O+YySuhO0XYd2npVbeVNHn/ROZ1qUlNq6ISVM1Xmt0uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9032
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

On 9/14/26 19:34, Tom Rini wrote:
> On Tue, Sep 08, 2026 at 09:27:03AM +1200, Eva Crystal wrote:
>>
>> Reporting a fail-open condition in FIT signature enforcement.
> [...]
> Hello. Yes, please follow
> https://docs.u-boot-project.org/en/latest/develop/sending_patches.html
> and provide a fix and test for this issue, thanks!

https://patchwork.ozlabs.org/project/uboot/patch/20260813080943.v8.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid/

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com

