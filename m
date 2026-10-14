Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B705CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED30980CF1;
	Wed, 14 Oct 2026 12:18:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOUppRs4-qLZ; Wed, 14 Oct 2026 12:18:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 231BF80D84
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791980309;
	b=Ll8+YHn46z+284RpGX2iWee/c35cWEklDz1mqd3wsSNxa4knC5yEpZu+yIRivAgkILW1
	 /vfWTZI8ms/SrA09QYdRkM0Ke5DmH1L6Qo3d4iQWLJzovPRN6SaGvYxlJRZLm96DkJdFP
	 06WFcDBXpp4gizFLMSPojnoYmMnbYhcpFTk271I3kRtOSkiRxx1e5cCbWKSoZWd8jpNZM
	 PoTVQTNoW2dYt/fA2L+FlY0eWRNTroA9bF1Jxud2iKjjkgRixYfUgfOcyTMSUDYrwgLbS
	 pJOO8cQDA8KI1DzV+WwbLHqPjQqTgmqUIidDiSC3hMa5B61qLVQKSG84zOzPabR+adA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p9INS4jCkcCMohL3rf93/2AHbY0LMqWV2JBsmGdQS84=;
	b=IxYNoePwiPn8aHM9apo5Xue8hJNi74arKkAAPj6vlGrFO5Ml54PKTMbOKvdmiE6LEZdt
	 kle8sGohe8nPMzSOX9OzYYYtk9DQ2MfzAo41IJZaNMFbS4ZEJTo+V/L5bwrDUYmn4CONm
	 JC2s8NL3aueXuQ2zMWC6yitJFEXK9GieS8chH1zCjvk3PAG59h1rPznvfwjqhF/Az2Hdi
	 KnqdrrX3fKjVmbVwv0cuDBZU3sBT+1ofV6mL9pDBYyEBVYaeCjEzoaVjFArqmbXC7v9YF
	 ZqT2BzNUaLx2a0e+eMz7/MdIxrwlvfWE37fkHui9/NVnTSTz+/QImpm0iSLC5RGH+Iw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qn2v81vr;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980309;
	bh=p9INS4jCkcCMohL3rf93/2AHbY0LMqWV2JBsmGdQS84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bGTM64Hla0SS32qrT5tqhxs5QEZk295WIfRH8nvGUA5C4qJf4pulRy0zFsxChgLe+
	 CVNshZtGhLfN4jqenyfNO1nBaUo9ppScKLzSexjuJ2PV8Wi0sXKhM1Lt8lXQFxW87I
	 6fJcemPAYTlGX8c0aGUWmWysNOYla/Uov+7hOa0SgFotOveQ8qvMmb/S9tEZTYObxH
	 lyhnASjYuFcb5Lf/RrK41hFkNtYEI1LOeRAiJRBqtlbgk+/bBY6sSlAmQ/knjz1Xte
	 qf5Df+inLYoFfjaPulDC4/audZfVCS1011jgOJTP2TC1vv4zvC5e+ak0q25jzZ/dnQ
	 NLEBWJWuJC+Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 231BF80D84;
	Wed, 14 Oct 2026 12:18:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 821322E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6730980D84
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:18:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-kyOcBNa9Sf for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:18:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8597380CF1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c111::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980306;
 b=cyYJlKhWaQH81XpNl29qUmRX2gPBAYuBwJL4XTYDk8vENmCQVVxOluHmcnv2L85Dwk/w
 /+71vzkMYJJaSRoalxeLsD5jBMqrbK4zAkAw95ya4hvob66pomwO/u+y1RymlbtK1LYu0
 9BdZurrx7nrWE6oJHcZJEn3Sc/tR4KiZ7eEBjug7Y3N9ea5c7I7JwW52eD0q/IC9/VRWN
 WgrNDhN4EpQJkmHi9mpm/aBhAig8f5DgpdBhqFabYZNmUMM2ajR6m0NSX/c81hU8cKsKP
 Z2a8WedS8mWWyG/tHRKbHggtT7DY6b6B0L09J1txyc3z6uGmQkW5l/TE5X+9dt35HaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980306;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=p9INS4jCkcCMohL3rf93/2AHbY0LMqWV2JBsmGdQS84=;
 b=qqG+Fsh7MFX//Y1vO31ExLBdCquF/R2dz4uXroT1hK4xXfOK4B1d6ciWFbpNhh1Dc5La
 7Ozm9V8Te3A0IGL+kjfuLbNPiNiiEMLBN/OAKSe1ILo8hpAzP2fdnAmXHovpHr0btzLHs
 uPwSAs7eTyMYN1wb87LAy1dKgB7jYRmPBsdxFQPgypO+v8sg2NRR42G2m4RH9DDYeO9gY
 7SXQ/FRIUFPVsH4hlX7fFTJLzxbgXYUUl+8AJg7hfHpw9fcDKq0ajOiCfyoPb//yczJSK
 E/TfI+OHQRUIZPA+ccKMFemSyTc895T2HX4Tp8h9hy1RujJBrZlVir1gQD1nwtIiAEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Qn2v81vr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c111::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Qn2v81vr
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8597380CF1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uehXPUUxecBuznzrD27sqvf7gIG1fDusW4GpwU6xVeFUPAo22BTOrvNjwexe/MIKoK6T62tmGvnYM8X/TmAAarM1kkTytI3eKtgOV4YP2ozG6vkogRxS5RAUNGfCb+OGkzKVfsQt4te9gduXnphz8SZYlIzv6i6t6yyruPKsWzZSP6nhNnJanqMq3n+AMq3eeVHuF7nsE22zYhh7e38+wlkn+TO21OdT5cZL5/MzGY2y8Gir0IsD9k5Y6aHCmCQJHO+4VUDRRJ/OpN04/7IDCFAaieD3lpiYWS09wtyP1S0SFJKvZNetGCdi3KrmiPERWhqGN918r40NUjjhyZu2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9INS4jCkcCMohL3rf93/2AHbY0LMqWV2JBsmGdQS84=;
 b=sevBbz0NWwkoosrEEeYA4ZZ7apmy7PddtRmZqFI7Ft34sLCb6DRG59xDXink2JlRNpaUNBYCfxcU1N7RA1wtddMBRKeLRvUEAFxmZXymf5azxZWNfLvjpUNaQiD8gk39GSu0kce2vS8mMb5VJdgNtwZmaXbMUtQCrYaqNle2O/gn9KjhA77sXyx7TamCATtc0KC2Cy4AFplTdNOZOY5cCbiRb2NrLJ+eDZl/zQ1pirVcMKSk/tE1tGOIZ+4lkJqNf9bIucYnABBPNgwIYm3aa4Lhzb4GVBT8b5lEUfMlrzTBAUBT6a90T+cTxOF7R3XFbSDEAS7CTQXvZN4MF8ROiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9INS4jCkcCMohL3rf93/2AHbY0LMqWV2JBsmGdQS84=;
 b=Qn2v81vrdE3q81mkf4N4lcUN05DZOo+S4Fkh1ieBw7sgieaGwL/MG+tARCoimPpp6mKA1VHRrCFT9B1bEG/63qHpiYz5PguoV7ox+W8BDeBAulkgChzxWt4neLjvuZvmPYtAoobBwIyBZ/ye+8VN7eIE01SIAJgvoZTgWRdTO3A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 12:15:33 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 12:15:33 +0000
Message-ID: <cd00079f-7134-47dd-a41f-48218c5a867e@amd.com>
Date: Wed, 14 Oct 2026 14:15:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
To: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Paul Walmsley <pjw@kernel.org>, Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Conor Dooley <conor@kernel.org>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Charles Perry <charles.perry@microchip.com>, Michal Simek <monstr@monstr.eu>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
 <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
 <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
 <a83ccf7e-87ee-4c78-80d9-86dc0b246491@amd.com>
 <442ea702-451e-435a-8b04-543750e929e6@canonical.com>
 <99875a68-fe25-4fd6-b02a-7bb71c24fe0a@amd.com>
 <CAFR3w36KKkJioAmZPeXBwDEErn9kPPv9FQ8QUY7EthY1+KxdGQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFR3w36KKkJioAmZPeXBwDEErn9kPPv9FQ8QUY7EthY1+KxdGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000233.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ef) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: be6993eb-2934-4a8e-df2d-08df29ecd883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: E1FGREFLouQY2G1xmdHW25JTLOXCcpoPilHj3HEB9vYQ8zHFx9L9gYTJuVnQJxTWNm2cmNWA9agtuZE4VkFuVzDbIZjuqIT6yGALaz9JUl/byHwzMyqvsdvffko3osDXo32W99p8tV4SCvRbfeX2ESyb5NYy50vAipLKBgy96aBWYgoVaCFD4lfMkMM5ZeIhhcAWJLy/1D/2nyKtYcc2yeg8xkmxrvP4D7iiSwz01qqpaycCG3F6bS/mdTW+hxkz9oX9vBR3W9+jCcR8JmhkEEa3mFIXYQnNvL+Hk5Rh9UcUtqTmZEDk6FAbILI8GwOqcR2bUthzOccyV6XqlzAzMiB1S7nYm/YlbOH5gVNinh8vXPumglsM3vCtyhqGU9xSTz785hiRqEeJLQVp36w7X/nX1nAamo+rhiUZaR4zAmhunoIvkv/CR4Qgep0/RwGXoS30MTf5H7qKZKyW9C5Wma9Q1k3yMWsjAH5HH1UubObfzJx129EQtl1c3KNFlCvyD8HbY7NzEnbuJum324wnnx+N8b9nYMLl803pLZ56ExpTbmY9VSj0ikTgShoi1kZvKGl9CEzzV7l4BGvBZMoq56Kt0M1bgKtER8oJJLNbdjwvjC8I1vtlOoe33jYImmJZD3pbD7ICUiP+mm8+HTdGKTNH+P/Te1knigfuTwkNvbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VJVWlGdkFjOWxTVzk4MG16Q0pRZkN2bWc4bjl4emRoaUgyQWxmLzFGaEk4?=
 =?utf-8?B?UFc1YXdHc1N6VEEvOCtWZndLYzYvZUc0YlMzVUFGTjJhdWZjZVVZUFBYMjRS?=
 =?utf-8?B?bnZKTHA5eHdRUUV4dkh6SWFSdU04RjlNNk9MOUVYUEdTZkd6ODdkK05KQlRo?=
 =?utf-8?B?TElNZHRBVDNRTFkzRDc4RHB5Yis0ekpZWGtCc1A3UzRramhZYmR3QU5UUUVi?=
 =?utf-8?B?OThSdzh3Ti9zTGZ4NUwralZvMHVLZkF2cmNLcjIxTEppcTU5K3ZMV0Q2VER4?=
 =?utf-8?B?NGE1MEZoWk5teHdBazh3U0RDOEZ1eC90QkJkdWg3bXYrVUJhaWYzTS9UNlBY?=
 =?utf-8?B?L3V0RDE0dHBoY0lKOFVYNWlTc0w0Q2lrZURHZ1RwYmlGbkhvMlo2LzIwcEp5?=
 =?utf-8?B?UmFnU1BJeWl2UTJlOTlibXF4RFY2bytjRUJidzV4ckRGVlpkY0lUZkZvU0lE?=
 =?utf-8?B?WVVqbUlGK1BwWkxQdS9zZDBDVG9VSGpSTFgwRVRaS1ovdy9mVENrVHdIaEU1?=
 =?utf-8?B?WDNPZnJLM3YwSGNjUXA0enlYWU1NZldwdnpmMjRUaHRoQm50ZlI0UlgrbXVZ?=
 =?utf-8?B?RE0rNTE0K05xbDNpRWdmZi9WNlY3RTFOMmYvaWc4em1hOWZvL292NTVCdlls?=
 =?utf-8?B?WWFyelF3OGw0bGF2ZXUxUG85amFoTFUzcmF0SjNSODlsMmw3UlNnT1hOdzZB?=
 =?utf-8?B?N2pvOGNDcmlqM1U2L2dMSUY4L0haNGNOV3JvZG04cE41WUlvTmRWT0tKaFVk?=
 =?utf-8?B?YVp0Zlk3RlkyTUZwU01ObFAxM0xNZnNNR2NGVWdWbFYxUk9IZkYvdlZsT0Fs?=
 =?utf-8?B?dWpFODJqWTBtUG5LdkNaQUlFb2FzLzlvTmp2OGtwOXpqaDNvakE2b3A2V1VK?=
 =?utf-8?B?a0FMTjRXSGV4SWJCYXZFYVRzU25JMy9ncUxseGppMXBIRDRBTEU3aVUzMm1o?=
 =?utf-8?B?d0dOR0xUcmh6a2dmN2EvV2pvNmN4eHpVbUJNNk8yc0ZBUEpUbnYyTit1b2E5?=
 =?utf-8?B?V09lN3NKUEYyalZkZWpmeXNJcDBaMks0ZXdXdU51RnZtbWZrRWlkRVRNenVE?=
 =?utf-8?B?QVdLWklrcUN5Qjg0bzBPV2lrbW9FVnlxRDJqZi9NcGpLUTJEM2F0MVU1SnZP?=
 =?utf-8?B?VXFLS2tyY2ttVVV4dStUNUNvWXVzeWtidHlnVzNVaGI0REo3RlY1aVBlbjZ0?=
 =?utf-8?B?RzV5QmxzRDZQOFhkdE9mcDVwOVhNOElQbWRReXFlaFRTcGlwRDhQYSszTVJm?=
 =?utf-8?B?dTl0Ym9VeDJvcjdEZGZpQkJXTUoxVXFCMDc4aDZaRUl3RTVkRk1Ic1FOMllr?=
 =?utf-8?B?c1N5bThic3FVWjlSRm9FK3BVT1hERVBqWXpXeW1mUTQzRlQyZ3BUMGRPaU44?=
 =?utf-8?B?aVJoTVJnTGh1aUs3cG5wWHZKWFZxRHVYUnJVWW52RjNLWmtDTkJNOTNsbjhh?=
 =?utf-8?B?UTJtb20xWXFDclRpZ0RwSXh2ZWhtNVNHcVc4aUxjSjVOczFneFl2VDQ5enNS?=
 =?utf-8?B?S3dyZW5UQy9mRlBLR0RzUzgyUTcySm9oSnp0Mk92aEdjUmJqTUlyenVxeWF1?=
 =?utf-8?B?ZGJXNEQvenYrSjZXREtjQUV6MmRZRmE1Mms3SlhxYU9nS1JFTElXSVpMYTVH?=
 =?utf-8?B?bzNHZHRnMXJBbktSbXo0eE5HYi9qdzZZSTZrN3FueTZrQlNLcUxQdUlkbSta?=
 =?utf-8?B?d25YU2grRlArRnpwb3h5T0hnY0lKU0xycC9QUEJLRUJQZ2hEb0V3R29TYlpX?=
 =?utf-8?B?dFgwaGNsTk5RcmFLR1FWTUpEUm0vbGI0Kzh6M1VmeUMvRjNLc0l3RnZ6a29x?=
 =?utf-8?B?cFFIZkk3NFJ2OVB2SFhMMG1ya0dyclpMTmFLWEVCS01zeTBMK0xmZXZRdFda?=
 =?utf-8?B?TGpZcGczYnJhQ1l3QnNxTngzWEdiUzErdEo2QVExcGZGYStWMk5MY29NVzZz?=
 =?utf-8?B?QWZrVkdibDRURDR4UU8wTittQXF4R1UxcDBVbVZkcXRVOWpzSVhkNk1OT3N5?=
 =?utf-8?B?d05GSisrUDVzcjEvZ1FkREs2ZEZnK2RBZm5IYUZpQlpNazFENDlCZjVPQ1pj?=
 =?utf-8?B?NVRvMmRSV3VyVm1DTTZucE43SkpOOEZkSHR2NTN2cEJtZndyNGs3UWFZQzVr?=
 =?utf-8?B?VGIySlF4SlZxVGNUSW51M1lBTDVYbU5GaGpqYXBwdE5IUC9tMDhLM1hFVXFP?=
 =?utf-8?B?NnFWU3Vyb1lwVjB0czBIMlhaV0dsUHpMUE5NNVBrbDl5cTgxYU4rQVBMeE4r?=
 =?utf-8?B?enFjVHZnaEJvYzZ6Yk9raWdSTC8rNDRyemt5OHBmVGJ5ZCtRWXpMcWpwc0Jy?=
 =?utf-8?Q?QJk0R5W05P9WC8pstL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6993eb-2934-4a8e-df2d-08df29ecd883
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:15:33.3037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozBP0T/tR3ghweDiQTNoo+3AVBJ2l6PE6KofowSeDK8ICZSQkBjGAOpdQq/A8J0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
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

Hi,

On 10/14/26 10:12, Rahul Pathak wrote:
> Hi Michal,
> 
> It is not correct to say that SCMI already exists and so RPMI is not
> needed. If you read the RPMI specification you will find that the two
> differ significantly. I don't mean overlapping names, but how things
> are defined and implemented in the spec. Compare the transport,
> compare the defined messages.
> 
> RPMI defines many service groups that have no counterpart in SCMI like
> System MSI/System IRQ, TEE, RAS Agent, Management Mode, CPPC,
> Logging, Request Forward and others. Together they cover use cases
> ranging from typical systems to confidential computing and
> virtualization, all in one specification.
> 
> There is also a difference in governance, which is visible from the
> licences of the two specifications.
> 
> RPMI is under CC-BY 4 license which allows anyone to adapt it and share
> modified versions with attribution, and changes are developed in
> the open under RISC-V International. The development does not happen
> behind closed door but rather any indivudial/organization can also take part in
> the discussions.

I don't think license is an argument here because someone decided not to talk to 
ARM about it. Based on my information none really talked to ARM to change that 
license for SCMI (if that was an issue) or move it to neutral place.
I have already talked to ARM about it.

> I think open source projects always give users/vendors freedom
> to use any protocol which suits their platform. It must not be dictated
> that everyone must stick to one interface.  As Heinrich pointed out that U-Boot
> already supports alternatives for various things and
> Linux and OpenSBI already support RPMI. Adding RPMI support to U-Boot
> does not take anything away from SCMI.
> 
> Platforms that use SCMI can continue to do so, and platforms
> built on RPMI get the support they need.
> 
> So RPMI is not another interface that does the same thing. It is a
> broader specification, developed openly by the community that uses
> it in which you and anyone can also take part.

It wasn't my cover letter which described
"The goals and purpose of RPMI are similar to ARM's SCMI."

I am just saying that it looks like that you are creating parallel firmware 
interface instead of extending/reusing existing one without really even trying 
to talk to other vendors. I would prefer if we can work together on one spec and 
extend it to cover both architectures.

When you have heterogeneous systems where you have mix of ARM and RISC-V cores 
make no sense to have SCMI and RPMI servers both running to serve the same purpose.

Thanks,
Michal





