Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C4CCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA6B3407CA;
	Mon, 19 Oct 2026 12:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAfQxupWa_lc; Mon, 19 Oct 2026 12:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE698407A3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792411357;
	b=qwKkw63QHm+A18Cge4VDJpFe2rG/ENdQAzzlrpHiqh+qxhLRXAdzoEa00aULStwUklms
	 zkwAIUZbfSmv/gfYJSUJqXcp5yFARd6zudWnUrfldtFIdLZt0S+N2JDOffTX22f2rjvEr
	 NYEKxzH+i+gbpNTKNzRYjd7XoiOwReTVSqsovJ4WvAgG83X/3qmbbqqCNPZFYMl5aLu9q
	 bHDET7QuhrgJNBp9am9vxlcu7YDZUoFZjiB8Qi9tyk86miCD6Z8NJdaFuWSWWz0VK3YDs
	 7ut0X0yUh1e3N5EPADGkPTujRJR79YVSPRcoyIGh/QSOiWuJinz97G7r1bRVMuLVZ1g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411357;
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
	bh=Euaqsbd4oiYtr/WchZICWK2rgks/JzgXRgIyd1FqmcA=;
	b=G0ChjGKh/53A7cWBRKoz+ilRwyZlnDh6R8KseK0B9cB9XenJDMtql8RVVo0yLN1BdQoH
	 1Lmrbttc9zBLkkiAymqtOtfBeCLed6EyjR7PAxqKtAbDQY2O2+w82ZtJjXLQ92tU2FuMd
	 37JojE5Bgj72pMpFliBJxl1rp/S+nB/ImwCjChAvPzrU3aY0NArzhFCe5eo6IOVc5tDQ5
	 k36UxCg5wHCyBG3pJ+Zr9+X7u89iuMXXy27CUs4SkfEdBx7U/2kb7LuBd7P49QTubNloC
	 kwsVpUoG25aCnpK4qcy7r9cEDiDDQGJ6LPAFKfWs34v5ZdhSSOzGQ4QytE8GwUfCnxw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411357;
	bh=Euaqsbd4oiYtr/WchZICWK2rgks/JzgXRgIyd1FqmcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kB4qoAOKdaSla6f+wYOHU7fPTnl8UXZXwCY8xAjurXMK8BUaW8u4HMJhACLIC3AlC
	 iAMkMXDLx7H3nb6NqK/PnaLrbk/DAjUh7/wlrRAUvW8LGMqdCf1rIdq7BgUwvxjcz2
	 7iommjiCuISC3Z04n5AXkpsfXemUVM+/qPatRsiOOpAB+a0tvk68Qfx/5tiCkQwWXs
	 VB3x9cP9bdAeopTDarZfLyuuH1DQsTZM7CjzMfS3lJZFxBlMon1yj1MPpkW2nUy3EO
	 Ufc3YGG//bVkUdiESmxF9X0AqOCWbwmP0Yg+jjr/rKPUq32r0c16gsOWCiRxxhUMkO
	 Z0IveD57gZ5tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE698407A3;
	Mon, 19 Oct 2026 12:02:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 006361E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6CB2401F0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3LW_BN81Qq4Q for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AFFA740079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411355;
 b=CUtL9+qtxuJkNFUETUXchPAE1Y0W5yJTzAmfv9TLbby+8mvBiDvQya3DDJYr37Dcixbj
 hhUtRldBE49DcGV2ME3YPxE5/YNgSgAou5K4pxjUn6xxhQdJg5Cis5CWkkcvIXNDJb1pa
 Kjhjc76ilwX9faY63kUyDgCZ4SflGKEDNi/ycd2b6psTibt2NXNMKO9ir2dVOQ50PeLyC
 ark2KxtRIF8OtllnW5u8rA3O1lcaV6WIg5zXKMResdF8+6m/WFrzZtAGRm2bGt0JlKqaa
 RqQgY1F2e/L6YilROqUwVUcZFNBaDQ+cdKYupVyLX5MrsJRurd2t3hHXrNuCsMZMW0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411355;
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
 bh=Euaqsbd4oiYtr/WchZICWK2rgks/JzgXRgIyd1FqmcA=;
 b=EUdkR2v5SBTixXUkeJhqJyyNVi+xJaJB/xX64VUP0KG0gyOo6kYUtFnZxQ2Lb/caRjEy
 tFJ6GnZtZslyuf3j3J6c8whXrBHhox9xi6ESNPiY65y602q1auvuAYwH42TlXCkV0s/ls
 dXTO0c1NhJr6jCOM4OndBy8lrm935zbwPLFbkbO6TaIt53zhUy0KKOZVz3iIBRSPz2RUO
 Cl56hFTpKS0Df3/AZCL1wCzLSapiqt8LQsNw+RMZBZaCfP0xlVJnuOneqS6H5oH84gExP
 m/d8Y06uCcW6/gc427pDEsWeVYzBHzl7em2E0ug0TrHFosBbJ0sGeXPPvAtVqc7qrjQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=LObvIu6h; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=LObvIu6h
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFFA740079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaYVENX5zQ6leJYJXZsv/41Ovfy2PC/YdyhPiXQgUfYIXc8J1SraLg4cTER0ei2u6QR7/ltIlOf34TUqswTBPekUFdmQcJraYoXtnEK6HqpLTnTC+AwZfN8Owv4/YfMIXe0+7n/kl7TJG8aF7d9h9so/7Dq/B6XkLWJd/V3QHsSYmZm9z0itlzTCkDPlbKc1qdRfZKQvP5NVqYIIz7WpgL8uvO/yeqUpb6N4KOhz4m2Lv6aqNuiiUfYoPEhI5Q/NYWlkWH09JiafEPTNRsaUsV2MhEyNG7xOaOQN3iz/IfwRgI4yhMbdUBZEbeZCyBDU9uuj6bv/TJPffUasq1yNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Euaqsbd4oiYtr/WchZICWK2rgks/JzgXRgIyd1FqmcA=;
 b=TViHDKdzIAPIZWHbYYvrgUVdxHHKNqDOiHpgGlhg+ubmDrBslPGB+jC092amF7ixKQU3CUPTwtfmIj1riHO5I11T1rPEakFa0J010Ge74+vSoVd2yjAzbnJTIpQHHhXbvi/9yw/FqzGMtwV8rLimEbcCfKUE4u5ZBaOaBJQPubH+aK21IWcgazRQ6eoIbqc82PShK4FKR24c07scRXQwv0Tc7I5nFfbYVXd7XfiJUvgrD8X6swgT/xwM2X7mDbXxs6qlw+1g4Q+q6wx4Id9eOJrvzGZZZHnHBz1cXb/opJQf6wO7Cqiy2kaMAjretjvIo0oqX9TUssl4hNEtX/4oCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Euaqsbd4oiYtr/WchZICWK2rgks/JzgXRgIyd1FqmcA=;
 b=LObvIu6h5Y4DK7TgNU8gEJYx2VVF8G7cYdJbpxlTCd81pVQbLB4K3be5hvboXpxb2V2hiZeGsnEToIg7g8lIrxhhO+V6mj3r+nIHrT/Ll1zrjhdhSyFJf4FRC9uyLjqmSy/NSQZmifWuLmSdkdTjOAL9cJUiYiiCQilfdK2TBsVlHQS2OT3a89UBpjJerlF/cOhJ6qk1QFlKdwFsiAy3M+OmnvGU+RHkX3ByaU8lUccEGHxs+wVlwpQW5waSZ2rPUWHTAZuyo5N9GK7sjVVN+Sm4nOssgQoKoF2oivvmqFozFLobdju9LFpYb/6J8q5Bp2gCBKvs6U4AjyrtqFHF5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AM0PR10MB3140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:02:27 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:02:27 +0000
Message-ID: <54fc1de2-ac78-4ab6-86ab-13779fd35286@siemens.com>
Date: Mon, 19 Oct 2026 14:02:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker
 <jbx6244@gmail.com>, Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
 <6f29a66d-1425-4229-a762-2dbc02fd0dd1@siemens.com>
 <20261015152041.GC259661@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20261015152041.GC259661@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|AM0PR10MB3140:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a9ead6-4315-4ab2-b8d9-08df2dd8d80e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|11063799006|4143699003|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: InNSxa+TWKzlEJ+AOJny0A9dB+7bSlvLkldD2PMITVuU++Dw4ch+pSMCoiHVRjVTjIpP6JNR3vbm2p4j8u87F6z1thYNU11gYFoJenSIijXpZZp0ELYv0c9KV/WYdmTTcQuWZF2Ze5Qb7rPN9xZ+zb3TLgOHYNA6PUYmd51PmOAfLFp+oMBaS1gwAqbCEuQidM1G1l9wy6s+T2grWkS+D2nJcFdLSHVyGGzaRfzwX8n/aVZMOB2+BkSI/l8nwU10NLS4eHI2idHcblu5m1PEbZyu0nzKxOhhl3RRSTo1w7swsfUX+GDyFzaswiPQ+1yyiA3OF7qYGVANfXhNZdkp6t5wcpR4Ov52jiNNY1PMzMw53pVGt0kRsAjBRcOXc6ASSCh/fi1W0/catOwelwF6Qte87TpyTC+exMt9nFyj5/n7Z12nVMWEqyOc25qmB0g8WDFN57VOiEMibQYdsAx2t3pskIwku5O/Ian5xnrp4xhW0Rylw7wD99KPzEyCKPkL8MxzqCmX/82R1ag1VgUbUJePtM3lwuZVHUM8kQo56v5PoqYStfS8845TiOazj1wIRF8Ghw6ggNPCnZbvisS8myvljPyYaG13wXZB8cC2gZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTNCMGd2N1Nvajg5MVRvS2ZDZTJHb0hpSEFkbER4QTdlZmtab3NwdFo3cFlZ?=
 =?utf-8?B?N3dJN2JJZ0Y2ZGhndERtZkVYdm4vY25wbXdpbkZIbUw0QW1CcWVVQzJrbDVK?=
 =?utf-8?B?OTZib0hCZVpTRHJxWFl5T2dxNlY1YUloVEFtR0l1T1FiMU5YSUlrY1EvMDdB?=
 =?utf-8?B?cmhiVzdmZk9NeWR6NFRjR1pmcERYSVhsdDlDZ2dzWXdKRU1uait0d0ExTHNY?=
 =?utf-8?B?TW1hZXJHQXU4RTEyd2lIcHdIM3JCaXNLTTRYMlI5Z01BZzQxZXFzYmRSUXBD?=
 =?utf-8?B?OVNManZ1djV4WDIwRUh6VUFXUzVlMjBSbXlhTFNvb0ZydlNDakpidGtQVWxQ?=
 =?utf-8?B?T3F0SU1MaW5YVkFyZkxlbW1KRm95K1hISHlHR2JTNEMrblNoWkRTL2c0NWFV?=
 =?utf-8?B?VVVzdG5TRWtPM1F6MlN3VzRLa0orYlk3Kyt4ZDUzM1RjWk5BVGhLVVlWdVdT?=
 =?utf-8?B?ZCtFeFZEK2E0Wk82QnZtRHhHMlhXbk02NDRvRmhBOVRrd1cvVWw3UWtncXln?=
 =?utf-8?B?R1NRYllMS1lzOFFGem1PUFhxdXlsemxEY2tLMzFTdUpaZkdla0ppZ2lGQXZY?=
 =?utf-8?B?TjVjT1hYWGN1MU81cU9XbkIxTXVrbHVMZmNwMi81cURzMGV3NC9rMmg1dVE4?=
 =?utf-8?B?dmVaQ2dOVGZIVlg4ZE9OZk5OUFJ1aytTQ2JJbTVYTVlreWh4TlY4QzVwbHI3?=
 =?utf-8?B?YU5Ua25IME9ZcTQwN01uR0NvZ2N2ekoyNTlTenROVDVRaVVIWUlWc0x5aHdW?=
 =?utf-8?B?YmFxVlZqdkFvbnpWT0M3d0F6dTRNcUx0SktqRmlBeWtvSm9lYllkQXZtcC8z?=
 =?utf-8?B?SjVUYTd1RG1EZ1RaZ2IzRDMzblo3cklzSjV0MXBkcGxYVUgweHBmMTFKOEhG?=
 =?utf-8?B?MmpmcEVEWE1KV2djaUJuY3BRWklENlpPMGpHamVoOTVtSUQ4TmY3VlU2T25T?=
 =?utf-8?B?OTMybGt2MnJRWmNJWmNCT2RkdTNHbEd2VTBDYnhQSk91MGczN1kzc2JmQW9K?=
 =?utf-8?B?aFhLNXYyMW52UzJIbzFZK2J0dUZCRkxaL2xzN24xb2FNbUxEaWplVDFIZWpz?=
 =?utf-8?B?MjFxWmhxRXNGNHV0aUpOTHZjN2pCZTAwV0dYQ3hxUkFTWHdvK2hmM1U4Nk90?=
 =?utf-8?B?dVVKWC92dDZMWDFSaVRUQmhOTnE5VUFUL2g1TDFGYS9CdEM2N2crQVIwbm1T?=
 =?utf-8?B?WnFUNG8rWWFReXdrQldOR0Z6d1RrVk8xSTNiZzNJUzV4UWhJR1FrUXo1UEQw?=
 =?utf-8?B?ZlU5aVRRaEt1VXExRStuVjdFWlFlVVFnSTIvWEExYkIrREVWbllpL3Z4d1Qv?=
 =?utf-8?B?MHAxVlRDSkJqTTJ6NEk2ZlFEWUxDMW5OOG1LcERDY2NoS2xkV21lU2xUUHB0?=
 =?utf-8?B?d3NnTW00YkowZU9PUVg3Q0NSS2RyazM5Vi9CNjNUSVdMTndzRGpNMVZhMjVQ?=
 =?utf-8?B?VlpvQmg5ak05bEpWTVJrdmFMSDF3bkdJc0twakpGUU9BdmRlRCs1UUhGRUhi?=
 =?utf-8?B?cEFBdFYvajFxR2k3N0FPRjJ0dUV0QnV1aVdjKzZ4NXJ6b2p2Y3pqVEMxU3RL?=
 =?utf-8?B?aWFCYWc4MGNLcEV5NW1FM3R6V3lVMGJ0V3RaNjlQWUJqeVpya2dlcS9Qb3Vw?=
 =?utf-8?B?Q0V1Q3ljZlQvUDNNdXc2N1lYdTV1K21HRDhRZEVYQ3JuQUlIdVlQcWgzdU95?=
 =?utf-8?B?MFloazZnTkVhUlJRS0J2eTNkOUY0NDgxR21Hbkh1ZFdFUTJjVTVTVWM2Sk9z?=
 =?utf-8?B?MFBXSmhxOENkU1A1QVVMMnJxTFkzcnJDa0U4UlRDYlIxbkMzUU0yeUVhZmJX?=
 =?utf-8?B?OTVnc0ZQQVMxQTV5UHVmMmlUOVowSkhqSkRCZWhLT0ZDOHB1N0FucTFTSzhU?=
 =?utf-8?B?OUtMVzFRdGhIYVV0N3dwL2FrMzVuV1k2UTBHWnFWVFRMaVBpVmExQTNleVVI?=
 =?utf-8?B?Z3hlSkR2RnFTbEVaRTVzaWZYdklETjN4bFlmR1FRZUJMQUl2ekVKTkp3em1w?=
 =?utf-8?B?Sm1JT0lkM2lwWXNHMUVXeDN4ZUZmNTE0QVlDbG1vRFhzRXVyMjkyMjhBWkV6?=
 =?utf-8?B?d3B3bWJFc3JWVmNmZXcvT3c2NWpoYTltYlNCNkxJYVBLaXhEL3gxYmF3Z1NT?=
 =?utf-8?B?OFNLZEFLYWx6dVNuYjI4c3g2NjhLQVZ0emRaWDVFUFFBS0xHTG9oZEJ1ZERS?=
 =?utf-8?B?aXVqcEl2dVFSeXZHSW40R0xMOUt0clJVM0xHenpuRk1hTE1DYkZONjgxUUV4?=
 =?utf-8?B?MTNOZlhtcTY5RW9xaHplOVA2a2FQY2F4aFpacnJpekg4eitQZ2tRSjZvL1RQ?=
 =?utf-8?B?V0pJaFJlM2ZWY1psSWFsdVZ6N1FKWnZncUF5aXdNWEhUWUo0MkxkVUlYaVhM?=
 =?utf-8?Q?PM6RzEi63WocJ82s=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a9ead6-4315-4ab2-b8d9-08df2dd8d80e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:02:27.2404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZQQZEoJunmwnt11IMqDkBMcCS5Pzq7x8DJuU9myFj5HjM74WYLNtFKmdtoLdgByCZjUBkxi/kb+8uzUXWubHSrxqQbAHsHqEaldvnNi/vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3140
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

On 10/15/26 17:20, Tom Rini wrote:
> On Thu, Oct 15, 2026 at 03:55:03PM +0200, Ludwig Nussel wrote:
>> On 10/13/26 17:01, Tom Rini wrote:
>>> On Tue, Oct 13, 2026 at 08:47:48AM +0200, Ludwig Nussel wrote:
>>>> On 10/12/26 16:44, Tom Rini wrote:
>>>>> On Mon, Oct 12, 2026 at 02:26:55PM +0200, Ludwig Nussel wrote:
>>>>>> [...]
>>>>>>
>>>>>> When I developed the patch OF_OMIT_DTB was "default". 68e65953400 changed it
>>>>>> to "def_bool". Would something like this make sense as a fix?
>>>>>>
>>>>>> --- a/dts/Kconfig
>>>>>> +++ b/dts/Kconfig
>>>>>> @@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
>>>>>>              disabled in the board's defconfig file.
>>>>>>
>>>>>>     config OF_OMIT_DTB
>>>>>> -       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
>>>>>> +       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_QEMU
>>>>>> +       def_bool n if ARCH_QEMU
>>>>>>            help
>>>>>>              As a special case, avoid writing a device tree file u-boot.dtb
>>>>>> when
>>>>>>              building. Also don't include that file in u-boot.bin
>>>>>
>>>>> No, because commit 68e65953400 was fixing how the symbol had been
>>>>> misused over time. I need to understand a bit better about what you're
>>>>> doing here next, so we can see the path forward. In commit 99df7f471551
>>>>> ("arm: Drop unused dts files") we dropped the empty dts file that was
>>>>> being used to generate the dtb OF_OMIT_DTB required.
>>>>
>>>> Qemu provides it's own dt at a known address. Normally u-boot would just use
>>>> that. The purpose of the series is to make u-boot check fit config
>>>> signatures though. In order to check signatures, u-boot needs the trusted
>>>> public keys in the dt. So in this scenario we need to merge u-boot's dt with
>>>> qemu's.
>>>>
>>>> Maybe a better fix would be to remove OF_HAS_PRIOR_STAGE from ARCH_QEMU?
>>>> Looks like this atm:
>>>>
>>>> config ARCH_QEMU:
>>>>          ...
>>>>          imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
>>>
>>> But then we would need to provide the whole device tree, yes? I think
>>> this ends up being a tricky case because we're on QEMU for this. We're
>>
>> I am not deep enough into the topic oversee all consequences. Something like
>> this maybe?
>>
>>       -  imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
>>
>>       +  imply OF_BOARD if !TARGET_QEMU_ARM_SBSA
>>
>> How does one get u-boot signkeys to work on real hardware that provides a
>> device tree? Or is this just not a thing?
> 
> It would either be in the device tree we're passed (OF_HAS_PRIOR_STAGE)
> or bundled. QEMU is in the funny spot where it comes from the prior
> stage.
> 
> So that I'm clearer on the use case, is this about testing, or about
> using QEMU with U-Boot in some other case?

I'm using qemu with u-boot for development of course but the main use 
case is testing the entire OS in pipelines. The less software layers 
need an actual hardware the better after all.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
