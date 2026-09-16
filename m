Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240FFC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AE1F40688;
	Wed, 16 Sep 2026 09:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKWMEfYFZo0E; Wed, 16 Sep 2026 09:12:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 562B6405A7
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789549944;
	b=M0b72Sh7IEKz6aQDgRHuwxi2SkPEWSuXcUPBgZucro5E3RsPdocgjHuBDoYxyXAzXA4a
	 3i+TkatAodVPyOHvx3mRAfIcTH6rVrljVR0H3mBgMUP1r4cN3ABdOPv4Lqwl+li50rjYz
	 8WuBgt6w7K4c6dTPXQCcf2zxR2+h4YegIekCxDGIDh2ZgAy2F4fOeXxlnKd+RyTBKBVv7
	 8BP32Q8lDbaFLXxS490+n4QtMIEK0qPuuk5bgIV7jSzghIhQ+ytp51k8xvK7iPGdzlPVN
	 Wbtk039q+EX/tcxsQh23vPaoF134L6tYUmAZvRrpLqnrt5EroUZBnLJaBXTZrdk7j8g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789549944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
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
	bh=xGlMUEBMXfJgBEctg65YkYVR0x3tU2i3KUaabxzu8kM=;
	b=pyOpVt5P16XHUXKEIpbLasVsnX64SZK+vAs/P1BHFigZ3mbBin5yYF76GXVFg9l6pkef
	 1OyUPWG3Cn034q2YrOFs059otT8S/XAqdVxtAxK3S7iaIYdz/GutQ6SwwhnzWJdHnL19K
	 /9ysEhnZYdZ43MbqRTqE21aPEsxd9uPhS8fkCcynCnGkY1QNmShryd3Z0fiso5jwJz76F
	 vlhqOL3gII3zMYZDDAON8gjwCa8ldFCtewB0Pmc93uLLKiHhtcPfcXyFoZqJrXVoh0z5E
	 jyO4Speg2k71tozj0MNmjsLSkvppHHBcE3uEavEutkBxFwPTkwrCqXpT6EscyLwZCVA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789549944;
	bh=xGlMUEBMXfJgBEctg65YkYVR0x3tU2i3KUaabxzu8kM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n6g8BpvwzpPgDcFmU+o8/Q42y5fm1w+anoukoNESKI8G9K00xxKNV3B4+9AkbZRiS
	 8CGhM2KIFt/T/DuTwE7Xw+3Lrj574qqGO7/knuC7k/CjDuivs/HgnJUbeHu41hC+W+
	 BavaQdgBQyNgiF7AFMf9Ul9MB4WqLREtC3G1f3WhnZW1gOt5SJHQEpnrPNNOvt6Lku
	 ffiLk7kHkD8T/cGFOj7l7TNMR13cka0mXVK7sznGqPmVFpvU5XgtmOkX5sP9KO6X8B
	 H+ik4NfNiExlG02VjhEqVpuRUiMfm1O86bRXZ+Z4vF195OtzgOa1Ma3xxPCpbWYM2v
	 HeBxKDMU/+baQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 562B6405A7;
	Wed, 16 Sep 2026 09:12:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9157724D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AA698068F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sz3uedL51lJo for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 94B918064A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789549939;
 b=Bp8t9poBhLRK2IKcMZHdre+VHzzzT3qxbUxk49jOqXbpKO33u3xd416mgmWy8Rp31AhI
 e8i1U5B4N4rJ0BEXctJygepq45DGU31EE1xaiN3erFbGqbrlRfooHjpnS24vsupIncQPz
 CpE4WzOxt5fNY2SXARNgjb0YCJqEcm5NmrEuA1Vuupsnlgt+BIQI/ZlYXlxkVW9Q7y9Xj
 SAqlO94Nbs3hIxn3JN0Pbg2TXxpmrUg2gVjPeG5keMS3TVqaRlX93K+0XYDqKsciz4LId
 VGnev0lntweblPWZ8HQNoyS1GiZbmXNGXJRJoAPFOj1sCEJmxTKTNJ23NIfII11M/xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789549939;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
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
 bh=xGlMUEBMXfJgBEctg65YkYVR0x3tU2i3KUaabxzu8kM=;
 b=FY4RHuXfqa9v7mTRD2OSgKPvbAlE35MFe6lZXkvz68WC9IcdzkV17d/wbQbUZ2iG+xAa
 IHrneKWKjQe3KPVy/LQlqCQAClBy0AysIPohCnkYg2s9F8BCDhaU6EF672bBDojjjOmyB
 +3gbwcz6SjKUo/zN/invOK16gzD47M0KV+2s3JcCnNYGiGgph3ATyxocOTNnJwPckm14I
 Trf8Fh4bE0oJ+kjMMhGz/We7e1zXzhSn3unv8h1nEY+5J250Af3N3StIot1pT8Ill9kqo
 s7mmerqO7o0vqe0PInAXBajyiQIBT1ycZ0F0MCf4j4WZvNLCvfxwwitoVOaN/Wf35IQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=P2bioXrw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=P2bioXrw
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94B918064A
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhLXDQn9GEy8Ef/aLabKUkej98m9fQkBSaPR69VKcSlVBrLLaA6JM3Kehdv7mzwUVVkk4ljAv45ZtTHIgCEtb+PIwB+dlOIAJLBmcYZN9/Cw35E/NabQrjiAmaVK1jwfop40Opy6+4+e3702scrUorltB4f/CkLnzc92DGRjvwGf9kRpFQhUsDMMsR3fGSaEVt4PvI7ohi+3Q1ONvVLec+MnXIwM+tI5FpbKc4vgGbBu3yaOi5vKyq8naZtMj6jczGXHmHUHYjjGYGQelui2yS4zLLWCFV0bzHmXDof5WreL2NBPzY6Cm5qm/fmR3ST3lmbz75IMZr7jpcUdiSyYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGlMUEBMXfJgBEctg65YkYVR0x3tU2i3KUaabxzu8kM=;
 b=vJ9OGiVW74PcYdq+FCIxYZGfz+Ehvf98BCkOqFnaoxtotTrXXEVRvyFpcurn7qR0IRxLNtbh3lIHlf1oEOapVdmKVNIUvgY3INOYZaZfdkXv9Pu9uaYEcgP3YWLq5IBCgUkQKRfLAuzuskrPRo6hocUNh19Xm0XTT7yzNmlnDrF0CKFeePkq7tDZW8hMvI8g36OtHEqeFT5S0fMhzVexnLhB2yyKoJN/ym8ilwqKkH4VWMd42Sk1QSd3nR/k1x6tOfHavGncKeb1Iizszh5mY30S6ktpkf3Lz+tpeVMWtm9RtRUmGMTNTdPXLWvB1cqO75neK+uhqNGG2bGSI8nekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGlMUEBMXfJgBEctg65YkYVR0x3tU2i3KUaabxzu8kM=;
 b=P2bioXrwoIeLpKdpicjPoXq32JFEA0J3kc2utABIr+xHp+nL5oFnOXA/G5I5VExQiG6974jqq4V33C9i0aLb+eH8tXX93T4AoBVPAFdmsbEnHPBc7C4rQtIFuYtKBcEUTbN96FKTLMg6Lfhlk6B7Ayl20+aGzVor4TwQrxdYw0w7Oq+tnIoJ4ZBphSTQ33dMihFfNsaNft8KwBlDOtn0cztwJBnn2ZO/uTRt6ntphbc+791tepYilGXpAZJ/XxgW4782tMIQ0f10RuTi5eBPlLhpYHBV1HaCM245tD9xrbl0eofYFZX9XKFw5RjHn/lW21USpUoaIEyHks30w6p6/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:12:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 09:12:12 +0000
Message-ID: <2230d6d0-df47-43bf-8f68-947869743d3c@siemens.com>
Date: Wed, 16 Sep 2026 11:12:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] optee: Add support for enumerating RPMB-dependent
 services
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1789023381.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf92a58-0e24-43fb-7e6d-08df13d297a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|55112099003|6133799003|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info: wyjV47hozdn/RywpbHG+ZOSaLxyg7z7vBQf3+9AfVllFIO6QyOnowtZT1LndTQ6YAor6uHUgZdqMfM2eeWrs0DrbinsZBdnnGZ2UAI+fXDUYQfM/qmcQTSXpCY/F5hdhkzqLrt582+DfvXcBcEmWi85G9CZonAX1oHKIuJ1eNy5edoEr1SEQQTcmXTW7pqKeY4xr3AH6wsqeVOyOo6zr24hXtbdfg3C9T7amEAwpGYTpQ5Wre7xFWMh321Bl6Lj3nTeAbyrrCi/GIOSnqa2Ag5p/9kIrom7Wy08TBVm6cmiMdGesu6CMR1pE4Gj2kZILogczm8trP0x1o5LM782csz7zYa9QoupXkMVu+8Ke0kuJiQqtzXfSDVu/dsc4njGoLQqU/fspK64SepQ23K/FQYlYFiBX/ql0Osqv1E4qdUnaQ7BqjbvR6MGLdSJeEYnogOXOeCQkl1nUtz9XwUlz0Sw5IykdUik5fcG3d4VhOHMJtKDUMZPdutdSrgDLBuPcUNDDQu67KcrzKvTNWhBlVY0TfdnLZUsd/t4zE8KlHyT4X1IA7crOV+ZLR0Fg2Ae1irwUt39nsr+78blDHd+vjPmJsKzaGIrGM6hGJRyklcIGgBGzXHE7u/nW7KEVZF1lGCuin9QAh6y94Rj6GrG/Xe+LA7kiGRTp1GrSXYpx5VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNGU3pSeHNHNkdxVTNhMjZWVXJ4VmplVkRTWE9GdXp4WGR2RU1rSTdmWlVt?=
 =?utf-8?B?SldWa1BlZE1ua2c0OGlNcDZ5TlQvQ2RlMGQwd0xTdzJWV2ZjT0RlWVVUamVv?=
 =?utf-8?B?TUZFd05jWlFucnhMM2xoRnh0emQzWVNBNnJDNEZkZmxKbG9tMWo5ckx6czNO?=
 =?utf-8?B?SzBlbkd5emJGWitWVnRCZGdkMVJLLzZPRjg2L2JNS1FvOVNLTkJRS2xScDQr?=
 =?utf-8?B?QnJSMk1uZVBnaHUwZzZiKy90K2R3amVNTEptT0NqRHQ1NVZUMlpUVTB6YXBq?=
 =?utf-8?B?SDZoblZvcGNCNVE1MTYvcWhyRG1xNGJGV2xleTEzdlBDMjRPN2ttY25UbDhW?=
 =?utf-8?B?NWpES3R3UHYvWXdFai84eTgyUjZGb005RzA1KysvQmhuQUFVS3NoOEZ6Wk1X?=
 =?utf-8?B?N3lDVXhlbnhrakZSZEJKT0ppRnV6dDBURFRGSDdqaG1mNHExSU0zcU94U2RG?=
 =?utf-8?B?K3ZaSU5BaXJjNHdRL0lnZ2ZQVitKcmN4K1R5WlFVSXBXWDZCdHRTOFdDV0lk?=
 =?utf-8?B?Zm1vN3hvc2RTWWRsMVcwOVhqOEwrUjlZRngyeFpXL2hPTUdHVW9jRHJKMUdD?=
 =?utf-8?B?d3FxWTVTeHlwM0s5eEdUcnVpQ1k4WWsveXNCclUwbHFHOU55QkpwRVNDbEJ0?=
 =?utf-8?B?Uzc2K1NUTzJqdmxEc2JIa04vRHB1dk9KVlNtOFNxekJZa2NmdGY4Z2haU1VZ?=
 =?utf-8?B?K2JFajZ1UkZPMU13RkVHaDIrL2JjUFBRSHFPWC9INDd3MjJDeDM5Q05PUHQ1?=
 =?utf-8?B?eWZtb1NHNDMrN2tuc3gyMng4dnZCcmNYeEVLbmNvQU9NUDlZK24vM3Z5bGk0?=
 =?utf-8?B?RzU0cHdVREhkWU4rSDhBbFN6aUpJVXZHa2pRM0xzTTJWcm5teGd2Q3E5QnJW?=
 =?utf-8?B?U3IyQUh3cDU4a2ZiZ2I1djdUeWxnNFBoOEt6S1dEYUxrWnQzMkVjWmRiQXhT?=
 =?utf-8?B?b2c2RXJMQjJEWVlaNVNWaEhlTWN0bWhIVW1ZbGIzUC95OHlZcEt0ZVJvMzNQ?=
 =?utf-8?B?cGo3V2RianU0OHkxeEt4M01IY2ovQ3NVR2x1NzZ2eHh0R3BNeW9IYmhENW1X?=
 =?utf-8?B?ekJRekkwSERVNU8ybjJKN1ROWEJreE4vN0RING5aallScUpvTEF2UzBLYzE5?=
 =?utf-8?B?WlR6eFExeURnMFJKaTYzaWlSQThIVHJseU1GNmpDQnk2OHFSMlZZZGVjYXZX?=
 =?utf-8?B?L1A4aG84QWxUTkZVZkFqdzhXb2xQRzRqT0R5S1Y4bDNvcmczb3I4MlJoY29x?=
 =?utf-8?B?T0FZakVUbGd5YjhLMzN1TFU0N1VnQWhwVU5qeVJGZEp3VlJwTGMwdjV5Qlhh?=
 =?utf-8?B?d21ldXZFQTc5VDF6L1dqeVJDbEJXa0dCN0pOa3RrS0diRlVsejY2UDZzNEcy?=
 =?utf-8?B?L1hsb1BqK1dWZXdRdkdSWU8zSlptUG9Jc3VuVHZqMUk1TkxjU3loaDlXTnl4?=
 =?utf-8?B?cVFoc1BwT0U3bElvZ2Exb1FjWm14WjF0Wnc4a2ZnSytiVUZHMGhUcXN2czY5?=
 =?utf-8?B?cFJkaDBpZXlBNlJqZEZPRTY5dk43Mk1zN2dhemxSOTlqbk9DUjJ2RTVRNGEw?=
 =?utf-8?B?RFhZanBrS1lFQ05kV1M5UFJpaGZnZUNUZW1vWWdlRGdlWjZXTjNOZS9Bb2tz?=
 =?utf-8?B?clZIUHQ2Wmc0aGd4czJKT210YXdEdWtmdmV3WjZDZmsyRnZZNE9GTU5xckhQ?=
 =?utf-8?B?bXpxUlBpSHN1MWxSQXRtc3YxbHV0QU44SUh5Z2dpYTZuQzVuWXQwakl6WkJp?=
 =?utf-8?B?ZzR3bVhLTS9Ya2RtZGd4SXJRQWNGR09KeFhnZ2N2UnZEeTBnM3YybGFvZTR4?=
 =?utf-8?B?SGFLUE54TUp3UmFRejdwd2M5TEI5L0pzZGkwWXFFK25JdWJlRjlXR3JnYnJI?=
 =?utf-8?B?SUluZmRwUTlQaVliWm84MzhDM0xlSnVQZmdPSWtiVmtNZ1IxRTlTNnlIb1By?=
 =?utf-8?B?Vk5Dd2F6blRTMzBReEFQOElGMFpWdHBxVWZvRDBaWFJGQ1VQREQ3WGVaYy9v?=
 =?utf-8?B?ODVCOE8rRFNGZVNhejFJMUpzT3F0amJ1S2F1L0tSNmFRSmlsOUkrc2FEc052?=
 =?utf-8?B?U3R2WTc4STI1b3RmOVNBL3lXcDE3ay8zOFdKMFJCNi9sS1RSc05iZzlVd0RU?=
 =?utf-8?B?amYzcllXVm5xZzY2ZWM0TytFbjhRVkFkci95U3l6bUt5T2pXY2RqRzBUZnV3?=
 =?utf-8?B?aDdjZyt1RTRyQXJGcWhqR2JjdjZLV215Z3lBam9UTHN5R3kwSGxFZVd0L2du?=
 =?utf-8?B?cXZSRjhIMTltdG9HVVEwbldrdGVlcTdJQ28yRUtJemtucGllTE5HRHhCbFc5?=
 =?utf-8?B?ODR3b2ZSaTMrRnlKZVlTTVhPaUR1ZDVzL2M5RTg3NE85MkllemtjZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf92a58-0e24-43fb-7e6d-08df13d297a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:12:12.0044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KOM5MU2b91ZpBk5dMXVjDbSBkws0AxpbztLKy7V8d900KQj/PvfZz5SdZGgcKAB1T9I+b8oJWxKfur4UWJrAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4097
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

On 10.09.26 08:56, Jan Kiszka wrote:
> This allows to find firmware TPM again with recent OP-TEE versions,
> possibly also other services. The StMM service was not affected because
> it is directly invoked by efi_variable_tee when needed, and that is late
> enough so that all dependencies are available by then.
> 
> See patches for further details.
> 
> Changes in v4:
>  - avoid multiple binds on same optee service
> 
> Changes in v3:
>  - don't use dev_dev if there is no valid dev
>  - add device_active check to optee_rpmb_available
> 
> Changes in v2:
>  - fix build breakages with disabled CONFIGs
>  - structure code differently between optee core and rpmb
>  - debug() -> dev_dbg()
> 
> Jan
> 
> Jan Kiszka (6):
>   tee: optee: Factor out service enumeration and binding functions
>   tee: optee: Avoid binding a service twice
>   tee: optee: Add support for enumerating services that only need RPMB
>   tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE
>   mmc: Call back to optee after a successful mmc_init
>   mmc: Make "MMC Device not found" a debug output
> 
>  drivers/mmc/mmc-uclass.c          |  2 +-
>  drivers/mmc/mmc.c                 |  4 ++
>  drivers/mmc/mmc_legacy.c          |  2 +-
>  drivers/tee/optee/core.c          | 64 ++++++++++++++++---------------
>  drivers/tee/optee/optee_private.h | 24 ++++++++++++
>  drivers/tee/optee/rpmb.c          | 20 ++++++++++
>  include/tee/optee.h               |  6 +++
>  7 files changed, 90 insertions(+), 32 deletions(-)
> 

Any further comments? And do we have a chance to still include it into
the next release?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
