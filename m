Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA14CC79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74D68605AC;
	Tue,  8 Sep 2026 09:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYZnos5aefQj; Tue,  8 Sep 2026 09:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8AF7A60640
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788861210;
	b=LV9zTBHGmYQ0P7+DlaoJfHn8lJp/IOBRH5TtEegVkXE9VEAJzmZ8QtS2dTbkPjwsxgDK
	 TY0nMFPzQEaxc9ZJaXAk5b0fR3D1xHP1WjySG+PBUy09ymAEfvHlyprMD3oQ+/8HvC2Fc
	 j9nxeaIiFjo7V06GPf0zCXktYn08WcWdtfbaTEolBpA3EzPtbHTZJPtGaEBXGXlzu8N8l
	 g2xEDf6b/g4sMDj6s/If3JjzoqthAlclzGlbiRSqsjUGFtAp/K9k8Rln/xq4jExIFjC4Z
	 WNpjTbbhm5k/MqbbcpqytWBjsljPs8c8U6OynXMMVsOVNd2spfdCCFu3+0DHJOgpCcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788861210;
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
	bh=vf77iuMUJxOy9YWlXyCEfDNmxStXncCvXCVv/KvXr5M=;
	b=tBuYPg14HAzd+k1RBejwpo5ms27WGVLE2X0QiqLOy/Pg7piVjchsD3YOQaSAZcguaGZX
	 fCNOyFpErVOy5mxoHUQ2n8kKq0Kd0xoNDYshKIqRgf+dx020k5LBj0mgPQ2LZ6LZpjxpv
	 6j/3fBSE0GTgxbblUGXqemaWdcI8b38yrR9EhY075HZSFrm+9x5cbkZEISOLBN42YUpDo
	 plymICNf1XTydpbQ7EFqQHDvf4CUbNe1vBGay5mH+dwvZGGoP2n9Agz5uQnDdz3DzxA3X
	 T1ypZ2duaNFBlc8RZjps1k9WwXf/cCZeYWrYhWvds/ITR9xLJs+JYQFRpe7bGSAS9TQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788861210;
	bh=vf77iuMUJxOy9YWlXyCEfDNmxStXncCvXCVv/KvXr5M=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xljMMUCAoc8+P8OLFcnxJWlJOTrmZLKFTp0bIRK45IIwyXcgpQSovnASJNl1M4jbC
	 l61S9pdYBURe1iKP2ynz4jDc81Po+E2feyR4Tk4avdGN7T75edOdDD7FK3KprQLOeH
	 LAnJf1u2WuYbY8C2EZ471HIZDBaXJOMSnXr7ClRUeBNCvYE7HNQhO5ZgRMD1AjQFwd
	 oKq7vsTjURmLTQ+smUeQjcr3TOZC7UppaY7sSWiPD+TSz1E7FRr6QmHJNFmRHDgDKr
	 rIsK9YnvGXPprSNMe35VWHT66KnMsac4/NbppBA12tj6Z3QbR0DXlAWVUGj59b+lyw
	 7mtVOl8HQL89g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AF7A60640;
	Tue,  8 Sep 2026 09:53:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 837D5372
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7533D400AB
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKKlJnGUx2Dw for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 09:53:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2A8A440063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788861207;
 b=R7FXenCaancljhs+dwbfbOCNzeF+rSiyY/lXScZqky3IzkltjmYM5Ecnjr1SRFaUnf9F
 uiPQUlfwA0+r62PM1I4nsZgrLc+/ueFa4fXjwPPRUM4okv/JoZiaicFV400G51lXy1uP5
 OPf2NrcezzieeBfZF1Dy4bKef7whWtKWXWI8lhRodKaYcLBbQyJBwEXdsI4ksGrC03hfR
 l0z2LG5pTd2zMIZF1SsyCX4IROzREPOFOFNFYRETK2ar6B0IRl+6pzvNtAnxPU/1neMBK
 CSO3mzmT9qSU9HR+QcmErdcZi6AoZ1sm/TuaJoy60dph/3vpiyStGGWc8LlQuLWRlxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788861207;
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
 bh=vf77iuMUJxOy9YWlXyCEfDNmxStXncCvXCVv/KvXr5M=;
 b=A+p/HvX5UoCs0+VQ2pY+WGJehz7lP3PuLRo4kQXUZS3oH3sQnIH/8n5ltC5KdINCe3Tv
 B2SofiO3eME4nHJt9zWw60yw8c6GshtjrQSin1P3MRZqUgi4dOKwd0QNx09RX6YEubCqp
 NkhNU1pzf9CzKd3qjePhWjUtdTtzAa4bRsMzD1rtZ2KfdsQZQjOjhRV7f24S3CKaqZbed
 znKeCW8v1VMnNXLFRlxgfKREHpLjZtOKri1GuPv1dViP8UwRT+hBApDXKg8vKqj2T35eE
 awETfK1TklQw8x8ykxFxwqfD7VM1/FFzdQaPMI0sHrYJHkB2dmlYs4PI2sqzrW3YXNA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=Dan2zQx0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=Dan2zQx0
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A8A440063
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6uDF2QmjLREd1yiy8arBS+EsegR0SKt6U4GMXs/feWQOJiFppS/ZAxvxO7KYTXU+qOAlQXWrq9hE5WSWDeQSb9lIpjW1xb07kMxpdZ/+l8xjYgqg13Iqxj6vHB7P5XXJ9p/4nDKGaj3YN6cRLmclYbCaDtKaRx7sYPXnje8DEg4pKFMTo/Hg0f7l3KtzRuDmzBt/ZDO0BozGpEnGPfqxrwH7AFwaoG5izJGBwMk9VRIqWO4frVNLRcLSuUagepvuwUojh2JLQW8v7pzXqAQU3iXs93kXPkw7YoGjNZvXoe6ZBIYls8ZnmCwE1STat2YS/ZTQM3hiODXun1HTlpoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf77iuMUJxOy9YWlXyCEfDNmxStXncCvXCVv/KvXr5M=;
 b=iaDRDEq2bCaz4q8bBxmdCwNnUlRy8EIDpQBEiDUW0/AU3Fll4Mds1IJi6TysYZ1ICX8qqEUX+ZenBiHiTumYz7XZeyOMrmeTPmyz0Jb9niMsrJb27h5iScVReW9s+UR0nH52BdOf1oxCrT146zZbGLtOegGTiG5VoiRgI87WDbVCZQ8ckoeiHo2bc1dNPR4sZl+jpK4Z66FAsYz4P7ICcgGEjF2aZW0uWCLudwpzjVWATuT0tY8qBD0rroRC9V4m8L2Lm1+kKaTa42zSvjcHn1znNnyxP19KkmNyQF87c39u8iZAROajA5Wj2iaq/Z4eOqvnAwnSRXs12+PrSl+m9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf77iuMUJxOy9YWlXyCEfDNmxStXncCvXCVv/KvXr5M=;
 b=Dan2zQx08uPIvdCEYbpPPrbQTQq81lERySSniE8LDOjzPWGmLZoP24gn9hfkfDHZyEJG6Z6GgPNsPpfAFQ9mygNvjypiR2GladWJfTVhPB+H6Wi+lsKU0bLdL50tazPxOzb7bPxeKHRxx+3rnLW+gq9kE33cxMXOX32MdQCTdd71G9bgLKIX3z21WIy2Pa16wzksUAI/CLHfDbk4yUyhekPj1avqBCRLrLkmN9OnVV/Xhahi1ynX9FwyzcioZq/IOSFoDNwQ4riPOWqAR683gl08aS19HklSN07iu7IhE+4FCnCjxL5QDg8gocLCIMVuts9bM3wh+38ZnKZBiR2atQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:338::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 09:53:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 09:53:16 +0000
Message-ID: <6fb3ec9b-eebe-486a-9d62-bce5c7be0f57@siemens.com>
Date: Tue, 8 Sep 2026 11:53:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] tee: optee: Factor out service enumeration and
 binding functions
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <70c9bcf676e253ed8c86699237c74e41c86eb34a.1787514446.git.jan.kiszka@siemens.com>
 <DL9QV3I7AB7A.3R0777LUCF562@linaro.org>
 <1084fdb7-2750-4aae-9d5b-d7102691101c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1084fdb7-2750-4aae-9d5b-d7102691101c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b44fbe-f81f-400c-0d42-08df0d8f012a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|18002099003|55112099003|22082099003|3023799007|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: +O6zsbT4ekoKAFxFPW8cFuJD3ZlydxALHpr8b0KGVLdH2EFXbkJ5mCC7OY2sSA2M7b/d3y7/9di1IVGSeeOwAWFZOE4NPUsUTSyOuCBBswGSUDd7no5FRDZ0JGo829zQWc2tDw9YcUeGs2CEQBtnqQr5MiOvhOtiNAmS2abvO2r83IZ7D/A+a6pYrLcadxSXx6Cfi7oHEffQp/yARIzktlb64stflH7TPrRWM59xU5vZhKPsvEOxSMZ0faL6IJlUmyPf3b+atBhiJRUtJ0/kFHdYxCws53W4CWQia8M0ZFKvzSLSiCL46WkER5ZgIkhEy/uOghjCajVCNWkmFbqYi+yhR/izNlHjvswahwwn7QUitsQDychPcGGwfNNSIPOGL5U/hhaDCxzwA5egruR7KcBb8+1eMtvZAiqB1yn7gx0Sx48yypnNfg52EVfRQ7LAQnGOw+dAfNc8RoSWGtXuxLU7+AiMnY9/VIi119aNMiAGcZlcN7ZrWJ0eBww70Xt5Mm84ilxN85XQyBhIctPnsehL3iQxGJWHsJ0i8vcpdOEBz8y8GpP8PqBQlw0cnUVqxCsgPB3Bgv6KyCzJQn9lQEyAQFRQ5Cz9cT+RDzwcFMaMtQh6FyjZrNvPeApxdhcb+OicQ+WucyCVxQz6Dtknc7DMzNyx317W0mvgkE3SDj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(55112099003)(22082099003)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlhXd0Q1aXRoaE95NVpFTzVaTG9rN3NhTDRtOWU2THAxSlV4emhySGlKaHd4?=
 =?utf-8?B?RTk2NGs2bUZ6UDJ0NUJwdGxtYmw2STZucXFiV0NKZzA0d1BYTE9xUVdGOUhJ?=
 =?utf-8?B?Y2t4ajgyY3E5M3pMOC9wSHNBQUZrMEhVbysrTlRkeS8rZDlMMzZXcnZSNHRR?=
 =?utf-8?B?aUZjRkVJOTZjTjVjWHlyS0NJSHVKd0NOY0dKNHBjS0trQVp2eHY5VEhCNkhD?=
 =?utf-8?B?RmR3Nm1lNWRWUUwyMDRkOGVTN2ZXVFhud3ZVNzlmWlBqSkNDcGVIZ2pPUEov?=
 =?utf-8?B?YTFQcC95eDhIK3lYTmF3VnZZN25vaUt0VnIraUlQbjAxeXFueWlQU0dzdWg3?=
 =?utf-8?B?NFIyQk1ialZJY1h5VlJwejBCMzhKUE5VYlEyRlNaN0lCSWx6T2hxSWxXUERo?=
 =?utf-8?B?Skh2RVhVVXZsaTRsNGJlNlFFRE82ZFk4clhmTG5vdStlZ3ZpRlB6cDhvVkFw?=
 =?utf-8?B?dkdoQ2pJYXdrSU4zT2VZbkoyZGlDa3JMaVU0TStsMythbXROaHppUTVKVVRu?=
 =?utf-8?B?bUdwanJidWt2YzQwMXNPbjVac0NaT0xJRDBHTmJtUnJXNUwrZWwzUVowU25y?=
 =?utf-8?B?aUJJRkJtT2JFZ01McUFDbm5IdDZOY1pIb2YvV1dSR29mWGw5UHdVdFJqMytG?=
 =?utf-8?B?bERpeWJPNmljc3BIeHhUTE1PUWVUNFJtRE1BOGxzWDVpMTExUlB5ZFNqL2pM?=
 =?utf-8?B?SVd6SUNJcVpPK091NEcxSmQvTDF2bEc4OFRQazgxZks3N1Z6QVJpajVQNnFZ?=
 =?utf-8?B?SHRCS0VwTU9PSURUNnRKU3NCVk93QldZSURkSzdMOTZMMm1oK050ckpnZURZ?=
 =?utf-8?B?cThSOFZZcVRGQkVEUVpwcUttUzdrNUkxVTBiZmtYNEFjU3BqcUNyOStoZlZ4?=
 =?utf-8?B?dVN5YlU3NFZpVFM5RlJjSERaNkhvTG9wVldMRmgrbjFSTjFpN1FzcnJ3SlNx?=
 =?utf-8?B?Ykw2WWZ2MnRjZHU5K2RnU2dyZS9iSVlYaTMxZU1wUGg5TUF2L0Ftck9pUGt3?=
 =?utf-8?B?MnZldHBOSTR2Z0VlS3hPOWJPZkhDZUFHYnl1UGdtRGVOejlsRjVYUldaRi8v?=
 =?utf-8?B?WjlrY3hDNTN4dlByRk5QVmcwNzJMc0h2T2VMdXF0QS9kOEN2TFlObitHTzZm?=
 =?utf-8?B?RFlkaG1KM3gwdVlxa3dHSWo2SXluS1ZUL0ZSeWt5Ukk4eDdyVGVsZ2pIOE44?=
 =?utf-8?B?ZjZXcXNIclRUYkhjMEViWTBsNWRSWmVmS2NyUHBGREhJSGRmQTAxRCt4ck43?=
 =?utf-8?B?MW0vUE9KZ1dId1NJVzhuVmJyWGhYSnA5MGNzRmtaTGw3Wk1tVU9EeCt3UUMv?=
 =?utf-8?B?ZW5mUExxKzVSQXNhR0FoWGdDUjZlT0NEVkowaERZNGo3a0hxNFdXZy9LUjUw?=
 =?utf-8?B?ZFlPcXVwM3dqNzlTV0Y0ODVORm5tVngzVlV3VjF0dXNkb3B5Rm9NQVl4QXU4?=
 =?utf-8?B?YkdzRlQrMVdmUG1WR3ErSnVuQXdORzJPaCtzK1pMM0t6REpscWlYTC9aMmZj?=
 =?utf-8?B?V0MzWUJQRXI2Mkd5TXk3NGlESTZUQTQ5dEl2d1AxQzE4eGtyMjN1MTZWZVRp?=
 =?utf-8?B?dnNFU25lWkNqQ05weGxlSHBTZHNsUWxpUkZTRWpTUnRWbFpXMFI2Z3poQ3FX?=
 =?utf-8?B?QVJRWXV5WEgvVEpXRjMzWG9aSDdjL1oyNzVMZ3lNNzFRT2FsenNzSzB5OVJ2?=
 =?utf-8?B?Mjh2bUZieVkza1RpdE1aVlhtbVdwVVVsaDN2SkNydiszS1grMTFlZGpnVmpE?=
 =?utf-8?B?RmRkeGxRSUI4MVdxcHBoK1ZLUmhka0hnYTZ4VHFoVXJidTdiZTZBQVVqN0dt?=
 =?utf-8?B?Z1kzazAyZlJiU3djK2lhdWZPZGs2NVg0UVBmVVZVWnU3bFJKalZrVFVhTjkr?=
 =?utf-8?B?OG42MGg2UE5QeFFEb1VvSE9SVjcvQkhmNXdidmVBMjFCRWtER3l5bndvczRR?=
 =?utf-8?B?NDN6TU50UzltR1FNZnQ4TE5DNG1Ub0JGWlZxOXBjN2EweGoxQTI3SkZpayt6?=
 =?utf-8?B?aTQrZ3A2U0pFcjR6bHZueHlXYkZnZ2xLU0dvdVl3blpnMW5laDJDeUd4T3hK?=
 =?utf-8?B?US9pRHcxZzNSOUdFM2xtQVBqS1FabWpGem1GMERqdGc0MGUrMm9oQ2hOc2ZF?=
 =?utf-8?B?cTIvK0o4UkE5SkNIaHRpSFhSMlg1ampkSmhTaTEvdUZnQzlXQmozY2dubXd1?=
 =?utf-8?B?bFNWdXdoVmNOMXpUNTJSZnVmc0hhSE1jek03WVdZdytRbE9aNUZ0VlNWVmpp?=
 =?utf-8?B?N3NYNWJVOWlBbExEQTl5dkl4OFFjaW1ENEJad05mOVNNQWlwcWtWVjd0a3Jy?=
 =?utf-8?B?OTRyN3JieGZsTTMxTmhrVnhpazdLWWl0MFFzdXpqWU1TaFJWN2V3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b44fbe-f81f-400c-0d42-08df0d8f012a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:53:16.2427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNZhSdwAj/p48exhRmaAVull/AcVQ7xh08pK1lQqkjFMG8IzVknpmrfMA0NH6j46SwEOM0TPbVcK9a7slybQpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7625
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

On 08.09.26 11:47, Jan Kiszka wrote:
> On 08.09.26 09:08, Ilias Apalodimas wrote:
>> Hi Jan
>>
>>
>> On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This already avoids code duplication between the different enumeration
>>> commands. It will furthermore allow to implement a third one for
>>> services with RPMB needs.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  drivers/tee/optee/core.c          | 33 +++++++++++++++++--------------
>>>  drivers/tee/optee/optee_private.h |  3 +++
>>>  2 files changed, 21 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>>> index 4d67c948ec1..2871760a7b7 100644
>>> --- a/drivers/tee/optee/core.c
>>> +++ b/drivers/tee/optee/core.c
>>> @@ -156,7 +156,7 @@ static int enum_services(struct udevice *dev, struct tee_shm **shm, size_t *coun
>>>  	return ret;
>>>  }
>>>
>>> -static int open_enum_session(struct udevice *dev, u32 *tee_sess)
>>> +int optee_open_enum_session(struct udevice *dev, u32 *tee_sess)
>>>  {
>>>  	const struct tee_optee_ta_uuid pta_uuid = PTA_DEVICE_ENUM;
>>>  	struct tee_open_session_arg arg = { };
>>> @@ -176,31 +176,34 @@ static int open_enum_session(struct udevice *dev, u32 *tee_sess)
>>>  	return 0;
>>>  }
>>>
>>> -static int bind_service_drivers(struct udevice *dev)
>>> +int optee_bind_services(struct udevice *dev, u32 tee_sess,
>>> +			unsigned int pta_cmd)
>>>  {
>>>  	struct tee_shm *service_list = NULL;
>>>  	size_t service_count;
>>> -	u32 tee_sess;
>>> -	int ret, ret2;
>>> -
>>> -	ret = open_enum_session(dev, &tee_sess);
>>> -	if (ret)
>>> -		return ret;
>>> +	int ret;
>>>
>>>  	ret = enum_services(dev, &service_list, &service_count, tee_sess,
>>> -			    PTA_CMD_GET_DEVICES);
>>> +			    pta_cmd);
>>>  	if (!ret && service_count)
>>>  		ret = bind_service_list(dev, service_list, service_count);
>>>
>>>  	tee_shm_free(service_list);
>>> -	service_list = NULL;
>>>
>>> -	ret2 = enum_services(dev, &service_list, &service_count, tee_sess,
>>> -			     PTA_CMD_GET_DEVICES_SUPP);
>>> -	if (!ret2 && service_count)
>>> -		ret2 = bind_service_list(dev, service_list, service_count);
>>> +	return ret;
>>> +}
>>> +
>>> +static int bind_service_drivers(struct udevice *dev)
>>> +{
>>> +	u32 tee_sess;
>>> +	int ret, ret2;
>>>
>>> -	tee_shm_free(service_list);
>>> +	ret = optee_open_enum_session(dev, &tee_sess);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
>>
>> Any reason we aren't exiting immediately here?
>>
> 
> Just maintained the pre-existing behavior. But I could do this as well:
> 
> 	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
> 	if (ret == 0)
> 		ret = optee_bind_services(dev, tee_sess,
> 					  PTA_CMD_GET_DEVICES_SUPP);
> 
> Simpler, in fact...
> 

... but logically different: We only warn if any binding attempt fails,
now we would not even attempt the other.

Key question is whether such an error scenario is possible at all, thus
only PTA_CMD_GET_DEVICES fails but not PTA_CMD_GET_DEVICES_SUPP.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
