Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F85C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 15:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0BF780E02;
	Wed,  9 Sep 2026 15:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mS_n-niei2Yu; Wed,  9 Sep 2026 15:14:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD64880E0A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788966894;
	b=Z5qxcNRD0LD5CBpPvqnzTKHvwnWLk37iMsvBO5dJSnJ8kGRbJ8L/Yo6gMw4LedE19U7T
	 v/SrChXkRoqEUQQvhUrmBTJnPDaIgaI9fw/3fNS54zPo0KLLy07jmLHhm1g3cgPLEw1wj
	 ZJ3f3/mucVmDT5l3EMC34S0jJ8n83ALgHj8N4b4oH7tlQyi92LjyHdkV6jp7Jn+perRYo
	 YdyQOWH/IVN8C4beRm2iqoX+31w7M+JJU+LhWiw27A9Evi2lv+V/A8P/hS7mva4RztUe9
	 zPNmqFWUYPJeaiIYhzm5ykXT7h1IrmJBLFzhPNXmiMgq/J+huTHveCBpVgCt3o/1cLg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788966894;
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
	bh=Hb9eZKjOEkc94p3DhrgFdYNViFK8bV0n9qEJfBB7gVw=;
	b=Rqix48iPnvZlpgj9EtEqlbsBAl7IKQhELfjRBZ88sZGYt9o6EIMEfYWGPSvRdufUYNyz
	 IbqZ+Im0mNVXhxwh9SrbRph5gwpYFv1Bmqr0UwuYwv03IIH7/of0B7aU3cVhs2Y3oxVt8
	 zZhTqzhxhgeG5pAEIN2NAIJlIeMs6P9eCk8BwZdO9I3UrL4Nq7FQTR0WFT/FfZCnt/i20
	 9kvjAUAqKZ3IV4pxPS/JWYtGbMdLAhQ+Ejt8jBL56hlh0NlEX+LDNq8dkPBzqjlgh87IF
	 CZExzAWij4pF+syMnd6YOmgzMow2Q792lk1XlHIdOvkIuq2ebu0Qwd1fbeyb7uAbAEg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788966894;
	bh=Hb9eZKjOEkc94p3DhrgFdYNViFK8bV0n9qEJfBB7gVw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V4N+NUGIIqz7/kJXGeRAZBfSy3ja5Gy970VhQ+qfD565TVcLheRhNoBzQ9mmXSrn5
	 crcSa89CbLuVL2vTVuuOLB98yfqmsclKmXz4VghUzdTM1StBLSlD8p8/VDBjtuLNIC
	 1WdqQ2BnozrWpN+n7Hz6waU3X0Bn7+36BRREfHkYr0J+YB7eg7cztcU1MtG3R3lbyf
	 7BNtAt/4e/2zN0CZuwjSqaSVPTv9LrBYszccIovgoTVw6E5BikkBe1upbcmTVVQ0aJ
	 SCjbHyna0xL56yHvrJ8KjSJi7vh0YPVfrHz/DRu+P6ac7j3eYtbaXeahCl/jd3kb6k
	 nDOrRwCH3JxRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD64880E0A;
	Wed,  9 Sep 2026 15:14:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 94BB929C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86730607B6
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:14:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XPOP5tLeQ42 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 15:14:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0757C605C9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788966890;
 b=pVJcx1A3+moZT9ZV5b2nPaWOiRgFOzyqEj1U2fSpMCWhVUjQWS4cSFJQ8h52QIIOjgk9
 bj1cmGg+uI+bIHc42faGj9nMgaiWxazL4hcnw2YTt30BiqTqb/XZFeqa+j4BjTOqNRQP9
 0yFWR85VcZCs+EfH51FPtQ6UvfgxI33fUHiF1U6biH02JmKKi+3U4e2U6hgZVL8I2WmZy
 WCDagyvEWn4aIvUpuTNvwxsPc0BFOfLkl0CzBjW6smdwCKKH2sOdvH/38/i/kGUJ9kc2M
 YfnF6cyhC/u5ExnUs2ymYpGHDOvRmzqtzfdfA+R4ap151tIlLlNC2hIHcZ0Ano0DHOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788966890;
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
 bh=Hb9eZKjOEkc94p3DhrgFdYNViFK8bV0n9qEJfBB7gVw=;
 b=TmFRYZH7JKDbkVx7FcxBV2uMIcreSM4oVC01Teo06rAML+IJd2encvZQle1+YK97Nlrr
 G77UBxl1eIKzmjJQ0oHBPOqNfJLY8lmhaLGdOsZTWhfbIOh21XTJLQWXdzTVIb52mscr0
 IXJj3JJHKzrzD9A6m9ur60gDWEGFQG74Cu0JcQ1hBT8EY4Dxjws5CDzPPqn0s7oQoz8N2
 x6UPK40jn3jxCSpCXOxGDZpAzMc6W2Fsrn3plVFiemys6bMxlQf0lvWB3+5ZMlMZ9hKLb
 Nq8mFJgnVJGWqOdRCjEvfhfusxHI95mSt5uKE45rSCPzqlMKMWk9UFg/ayfAV2tNXDQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=JzymcOJB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=JzymcOJB
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0757C605C9
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4vy4bAAaw1Ry5xhWmGtfwdCniZcBGLQGq5HirxDHdFANCpiKjfVXtUPoodSLI0/1SUzRI+syEtZQPacw4ENIqcZfqi23r0wnHDyAQhTw/w5VjrJQKB/NmqPp6sTSzFsLjCUGGYz6aH5K/DTu2jRxHCaFZUk4KUE+nqalGeSJDbSmkIvKLr9o0I/U2yfEIArJa0yViE+dDlwVe1Q+YH5b5TLRPcr6Pq/d/xRZ9mUY5cbpM4p+nqencQUuQ5WSLyL5sxv3pQv8R50y3tMlUMm8WdA3IAAjFNs6y3VuI9n5Y85WI5rG3aGZZqIT/bugict8VvHaiqLGlL5HEANiNGv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb9eZKjOEkc94p3DhrgFdYNViFK8bV0n9qEJfBB7gVw=;
 b=pgEhQSbsrns9udF7KiK6RPNL+qEJBLcbvBtsNeXQhYiFqfWwkvhkuv+R9SKhmKeVFcakzs6B1NcJavM7k4xe14Yd+2mLpWEwLLZrtEzwXOSNxuBDnv0VKAXATaqrkLTOKW5DAyC+NFUo9QEWcFmQiweM3q71W+tPWgMpxnmpbCvWwwtjFAAdGsl6lh8Nrxm27KoyABTAGRcOVQAgFqUZVkDbLiLKLHG0ZkYeHkNg3MRoiPaU8rp8OzU02V2VzV8srwlkNY7Cu4oyBdai9I0D9pKE4M59Fzvxp3sB3lt0cB8Ic7yJERaCUr11uE8SETwhQ4kavYCOZ+CzhRE4rZv/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb9eZKjOEkc94p3DhrgFdYNViFK8bV0n9qEJfBB7gVw=;
 b=JzymcOJBmWE4pJIwgnqz5qtTsjBbeiGO11DCkMkrynjSL/H6AITUPUTVBVdIqLLPebpnu1MbyR53Mvi00w0pDIKEkxGDYH05WWTEK3jsCgsHOfXx3Kl5azoEYbOBCuTLzoknH5E47q0s0UfUw2MEzESZUKFMmedOadQmhqg3+eejcyCfWVn0lbekkLUTSAIlcfOp6EgRemRNr+/lCL6b8otcC+nZlJFtjTJCFDrt5bmRR+LOXBjsoNjhz0ZaURKwcRWGzhI4+TKZd0XIiqTepccnO8kEXwAVbEvAq7mrcWoa1Btwtvuu8nUT5exwAraVpqCD6i2pY84imYa2m3xY4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9717.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:33c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 9 Sep
 2026 15:14:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 15:14:42 +0000
Message-ID: <a7544672-3379-4fad-9e39-033ca7a93918@siemens.com>
Date: Wed, 9 Sep 2026 17:14:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] mmc: Call back to optee after a successful mmc_init
From: Jan Kiszka <jan.kiszka@siemens.com>
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
 <f78cecea-5651-44b8-a817-18c084001354@siemens.com>
 <CAC_iWjKsyfFQA+ASq4WQvQf1t2uKqsa0CTCdLvXP7MuuRuTYrw@mail.gmail.com>
 <7eacb72e-e147-4ca6-a704-25a7753f02fa@siemens.com>
 <b8a8ee0b-17e0-4353-a3c0-3baab12e95af@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b8a8ee0b-17e0-4353-a3c0-3baab12e95af@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a892d8-ba13-4a0c-ee01-08df0e85131a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|4143699003|6133799003|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: txKPBS0dJlSa2UO2gJjxtZEXk06GC2LnR8/20pfRMO7tRiOOtOsWsgRaVGNtYspu2PzxGnwOKKSp0AMGrBSBDihDvZDHQTMsWLHajqNou/WaozQxzTnw0s7FOUSqxu0B8uwQbsgZpQ0YmrcRlrMFvNJWR+xdu/37WfoIpQBeYqjLr90DC+zkP2VKHOujcq1DJ7H2f0Wl5Lc1CKlWmg5zuviu0KqkJQuFmmkzvUP7nxLB1ZsqLFqT+TD7y8rziwhtDrkKvUCzjjZTFdMUHkuUf/olGd7wgL7lYOZVGcjgoWw6iew5Nqadmm0V5ZTP8kES/PjfUlBB9rptSasAH9giqdfqewtzhDSTfDyheWW0U05iOsL3Jzc8YHC/lOMBuVZfGbGf8sYjUdeuj5ScV1gWzf1IAo147JmG7HPAfFQV9pNMOFgXoiV8xNsQOh7iAVsftsP+jdtCinfRKYimbwLAjcCxVBxPoBe/NmRMx8go9fGlCvE8er2nK14uWIF0aBV0KNpbgzZa3QP+lb593U+KZqTsrMVkrL7hhp8UBrKywor5+6fvg8DVFCvD1yLvYOCIghZJtchvWEY3FeoxftLD2SjajQy0ZPhz1071o80HUfIJAHA8dxcprAL/w7RcoSRtw3glZ9lvVytCNJNNn+lp4z4+xIy5s4+nSUbfYRyZw8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhrNzk1TU1pTFRvVDFvSmhvSTNsZVVRVk1wM3RkWGdubnNWdG1mQ090ZkVs?=
 =?utf-8?B?U08vVDVMaklmbDd0bHlDN1JON0pKYjZaNVl2a29FaHRaR1pSdmk2aU1GaHV3?=
 =?utf-8?B?V0dtVTMrOGJDZnAvYmY3aG95cG1aQVRxK09VUzF5RG1lb1FpYUtCQ0ZZblZ3?=
 =?utf-8?B?NFArVk9BbmZ4eHM0c1NvN2hyU1hNTldhclR3M1I5L3hwNnlrVkxVRTBIc3o4?=
 =?utf-8?B?V21rMkRtRVpQanQ3em1xdVZhWmZ4TGVQQlkrZDJWVDI3ZEpmcjh1VG5GWlBt?=
 =?utf-8?B?VWRyWTdlZmVBdGV4TTg3RkJFcHR6eFhrbVBkbVVnVWR1KzJoTXVzYmdIeEJY?=
 =?utf-8?B?eHR6Ri9XN1doZ1hKT0ZIeTN4MXBaanNlQXRWK0FKQ3E1MlA1OU9TN0N2bzlo?=
 =?utf-8?B?TDNFU3hKZ2xvZkJYaUNyVmduWFErdmFBQ1pOVnRlL2xINWZncXpTUEJyb2Q1?=
 =?utf-8?B?ZXBVd0pNdTlkT1BOVzdnVy9xQ3YvNUcwbU0vWE4wcDhLWEhOd3JLSDN1TnJR?=
 =?utf-8?B?T1QzNCt0MXJHQXRBTFZXNnpIUmQ4aXJUSTI3QnpuQTZWbXN5eDBET3NWSUZT?=
 =?utf-8?B?RTlGSmxYZXIvQXFObmdlbFdTek0reGhmR2YyOXBHRUVOZzY1YmNFOVVzeTRo?=
 =?utf-8?B?ZGRhR1h5ckRza0ZUZkNTUS9adUxteit4WFJrKzJOOEhZNzUxbGdGS3JpcHdy?=
 =?utf-8?B?cnBUVGRaSU1ldGgxcnJYSUJhY01uTUVQKzJGQTJldmdzZG5xT3pNbnJrYTB4?=
 =?utf-8?B?a1l5V3hDTmNYYlArVWtCZ3FTTUEvOGlud05MU1RPMWhtVDI5cE1zK3VhdzJ3?=
 =?utf-8?B?ZEVMdkwvRllleUhXNEF1UXA4M25jVlp5T1ZxWjVNOVZtckhObGpwQldub08x?=
 =?utf-8?B?VVByeWY2UkFtM2xtKzlJS2pRcS9zOVphenhIMjJpcHhPVGlFeFFPZjZYMDdE?=
 =?utf-8?B?cGY3L2xSTnZrL0dhK1ZrMzZ6MmRXRzVnelJMRzVXd204QTFvN0IzWGZOSFN6?=
 =?utf-8?B?WlhrR3Y1UmloK0tZTVdPTWhYNEZvVVRiK3JEMUUwdFlrK0NQSm1SVzJsWkht?=
 =?utf-8?B?ajVpMHdZWTZxRjVRTTBIblRZWHYvMlIybGFCNndpV0FaelhNTTRZRllNcmFt?=
 =?utf-8?B?YWppWU8xWUczb3VreGdrUGo2YTNCUXlBZ3RGNjBXZW4vcUhLWVN0WWR0SFBV?=
 =?utf-8?B?NnE1cWwwendEUWNzRTFtcFczQnR1dGlNS05DNnNYVmpscVdjRDNLMzBaSmRw?=
 =?utf-8?B?M3VSUkJ2NFJtL3cxMjJGN1RIM1BpRnB0eHpkSkl1K25hZzcrNXpjSmZsOHZU?=
 =?utf-8?B?a0ZNTEZkamtJb2FCMTYwM1dkdGg3MVJXRmtMVURwWVJteDIram1kVk85dVFs?=
 =?utf-8?B?VmtJOTJVTHF6aUtKK3Y4dnBvSk5ack96MGxpaTlMRk9qKzFyWHdjVmZJL2lr?=
 =?utf-8?B?TEpFYzhoZjRqZVlydUJoeFdGT3gvNy94YzFXSWl3SEVMdXgwL3MyL3NUa0Fu?=
 =?utf-8?B?aUc5c1VqL0RBcHZManV2ZzV5UUthVzZzUzFtbGJvVDByWWFNYzVtRlZrOXBP?=
 =?utf-8?B?S1IvOXVWejRzNGJCSjMwSFV2NzNlY0k1MTJ5dG1MNVZZQ2dKZFJxaTBXNnBT?=
 =?utf-8?B?YndOVTRJbU8zOHBqa2ZwektQOGludm5CQWVJM3VTTUY0TVlnNWxiOGIyOTBk?=
 =?utf-8?B?T3VQMmVoYm1yd0xBTzJnNHVtZzJzZk9QWmtrZWlRREljMi85d2tHYUc5KzJx?=
 =?utf-8?B?UWh0bGVVbzArTG54MmxQV0pHMTZyMDE2b0ptUlc4TzVYZGlFY1BFVXZEdk0w?=
 =?utf-8?B?MG5vdjhoRVpIWUhTQjBQQ0RvSkVvWmRpQnJwSjhtTVR6RDhCdGdmc0FWMGp5?=
 =?utf-8?B?UVgrTk5kbDVpb1pyUE9tTmMyOTRFcnpxanVJUm9STVdrVE1pdWk1WWFyUGVw?=
 =?utf-8?B?WXBIdnBJZExzUWtyOTdxbDc5Zk4xY2JpQU5LeWpkVXYxMC9MblorYkhUeEF6?=
 =?utf-8?B?eDJYYmhWanRSeTRCNEpjbHorQTZjYS8yb2VqNXZLam9NUEdPQTRSVkVGVjBu?=
 =?utf-8?B?MjRGR0dNa2pwNXdvRGM0NGd2d2VNd1d3T09hVStMVmZIcDQ1NHBqY201OHo5?=
 =?utf-8?B?YWx4Ykdlb2x4OExkUzhsUFNBYTlOcG5tcVM1ZTk0U0p3YW9kSk9FTjRhR3Qw?=
 =?utf-8?B?V3ltS0tXYW9vWGpYVlJlb3BicmJTYXhpT2MwUi9MOUZVbzlHWUJWcUlFSEZn?=
 =?utf-8?B?c3ZKNmU2K0U5QjBnSUdackJWS096NXdoN21qWml0enZVT0xsVThHUWl2QjFs?=
 =?utf-8?B?M010MnR6U3Y0THN1NFR4aWsrYWdxN3R5L3NWWnVieFQ2TkJXL2FTdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a892d8-ba13-4a0c-ee01-08df0e85131a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 15:14:42.5150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfNpenq3jio5SmMUuZ04THC69lKf75f2A6ASCCOXgecbwlnuVkT1kWovXK76PVJjJAYscLT2xJ2W7sZgzaDhuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9717
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

On 09.09.26 16:35, Jan Kiszka wrote:
> On 09.09.26 13:46, Jan Kiszka wrote:
>> On 09.09.26 12:04, Ilias Apalodimas wrote:
>>> On Wed, 9 Sept 2026 at 12:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 09.09.26 09:50, Ilias Apalodimas wrote:
>>>>> Hi Jan
>>>>>
>>>>> [...]
>>>>>
>>>>>> --- a/drivers/mmc/mmc.c
>>>>>> +++ b/drivers/mmc/mmc.c
>>>>>> @@ -27,6 +27,7 @@
>>>>>>  #include <linux/list.h>
>>>>>>  #include <linux/printk.h>
>>>>>>  #include <div64.h>
>>>>>> +#include <tee/optee.h>
>>>>>>  #include "mmc_private.h"
>>>>>>
>>>>>>  #define DEFAULT_CMD6_TIMEOUT_MS  500
>>>>>> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
>>>>>>                                 mmc->cfg->name);
>>>>>>         }
>>>>>>
>>>>>> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
>>>>>> +               optee_rpmb_available();
>>>>>
>>>>> With this we'll end up calling the optee bind methods again for
>>>>> discovered devices calling bind_service_list(). I haven't tested this
>>>>> locally yet, but is there any chance this ends up binding the devices
>>>>> that depend on an RPMB twice?
>>>>
>>>> I don't think we will have an issue here: Either OP-TEE isn't ready yet,
>>>> or RPMB wasn't yet when we called it first. So I do not see yet who
>>>> actual successful listing could be done twice.
>>>
>>> The question is what happens if OP-TEE & the RPMB is ready and you
>>> issue an mmc rescan. That will force optee_rpmb_available() to re-run
>>> and rediscover all the devices no?
>>
>> Hmm, let me check...
>>
> 
> It's a problem. Is there a helper/service to check the binding state, or
> should we track that via a static flag in optee_rpmb_available?
> 

Didn't find anything, would go with something like this:

diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index 7ae6045511b..bcad14a7251 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -194,9 +194,14 @@ void optee_suppl_rpmb_release(struct udevice *dev)
 
 void optee_rpmb_available(void)
 {
+	static bool rpmb_services_bound;
 	struct udevice *dev;
 	struct uclass *uc;
 	u32 tee_sess;
+	int ret;
+
+	if (rpmb_services_bound)
+		return;
 
 	uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
 		if (strcmp(dev->driver->name, "optee") != 0 ||
@@ -206,8 +211,13 @@ void optee_rpmb_available(void)
 		if (optee_open_enum_session(dev, &tee_sess) != 0)
 			continue;
 
-		optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
+		ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
 
 		tee_close_session(dev, tee_sess);
+
+		if (!ret) {
+			rpmb_services_bound = true;
+			break;
+		}
 	}
 }

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
