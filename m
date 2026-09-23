Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DECC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 16:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 596F6805EA;
	Wed, 23 Sep 2026 16:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_COriXS9WAG; Wed, 23 Sep 2026 16:15:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8EFC780F61
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790180150;
	b=ikNo7XX4AnStubFKtN/SkS+dLkoGUANkkkAzBVB5UbrixeVPmygTN31unbUB9rNcczi8
	 CkVbN7etccD4dvBvXb778FnB2rr1oA+9fnSJq0Q1h1PtwWCEEY47V9qP0HDUqCMiF5Qaa
	 q3+vP9ZMnSCIjIxKPK1We2fakp6874CItl4GVXMPWwSLMvc/W1lF3rL0bRB1D3rhHHE0s
	 TPWD7pPOcQsHIXKLclAhq3UydPf9M2MSAQSnQHYSEw9RPyLBNZnHj/fzFDy+PoasZYhyJ
	 ajQbE6ucJDjmsuZ0bVzJVxLoWFIefJf8UIyd+A9tSqgZYFk7SPJuYX6fGrhyZ/d4SUg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790180150;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=3RbUwL675fQL2EM89bdZWZHPY9TKF61yQZEed1usicY=;
	b=VTe19pvfdaGKGM1Omm1EYXaGhq3fzt3/EzbQYEwyqfdfqjPtUHpCpqauUVes0C+IjFQc
	 j19sL7lXm+UUeyMN3Is58g3FUspCXbSdrszoH0BU2OpqW7plTtMpjBR/WOTlyYJTSB1s6
	 6geD9ykV3CyG/BpBWuVbPv12FjG9FCSqie+zzNZ53blj2fNzysne+9DwP+FX5OIGvWWft
	 TXKsJn77CkDdHetel/5bixaJo3XK3W6ax1Wy/U1TwSJUaYTsiNfcsAotAkHW5sc1K1wbO
	 BVMuScuuVqBjzNYZfK4H7D+NlXnR15ReL2yyiRqg95vkPxt5BxHmEBX60NoDOc2crGA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790180150;
	bh=3RbUwL675fQL2EM89bdZWZHPY9TKF61yQZEed1usicY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RRMzHbI2nmV901G+6nI82BDgdymIGJFxgV7dVvJaMGaJWyN7vO9Hg++dW+WFTrjB5
	 zFqSILozQNFOl1sohyijKnoD9wouS9YeIereCq+s2FA9SB+ffgEbxAdjj1c/fN2wjW
	 rzyZwQ1T5OYwkt2iAJsBEFqkmI0m4ZK8C+xICqBRP18qtJ1DgToUeJqZ8QksPGOpYQ
	 hU3oojFT/r0/MAyttWJ9wduTmesD3zGozJxvAwhYysJtTG4fWbaf1nwRQGU0P4lHIg
	 TYBqq2Lx0iHZ3gQmt/jjhUyxQuFJPXHEWKKytRXk3eND+kMpKOGP86cIaZVMwAx612
	 yCAik6/S/U9Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EFC780F61;
	Wed, 23 Sep 2026 16:15:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2ACA813B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BE91606D3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cc_cEVbhRqiS for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 16:15:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 62ADC606BE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790180148;
 b=BSJsvULO3pd60WAIweNAPSfmdr8oKau3eto2SJSIVx6nqAPExQNXB3jolMAtYYjrXtb3
 TX7wLE9JO3x/1xkpU/34m6zSBVLqo5lWSwrJ5knaUb3uvWHZfbAE0wI3PkUG12f3ihKVj
 r/H6YX2sKh2LiX1AXPPZodPPv2keleBixMC+4xhJqAzv7EjXBdtWqZ+U95HkIZswvDcTl
 OTKk7lzDY7rRrPbAWwWFtRYsOUTVEkpz0OqyfBO/YGLICAS8VUL/+rC8e3DNruHJ2Bh4V
 qcgH/Y91pImH5xSdOSwPaKQGhYHpzFAVorqE/ywyPE3bX+/rzMWTG2yQ3ZRWhYj+m6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790180148;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=3RbUwL675fQL2EM89bdZWZHPY9TKF61yQZEed1usicY=;
 b=CbdZfDmN+6Swv46yrPzWWFkox0FoO4pslrsrioC0jghd68/ZVMDl2E8iJgoO+Crak6qr
 ginUJYxzHym33gjDjXUO5atIIC55PNzzQQ0XS3I9i8Qts/w8ItHfWkIO/Snp+W1qd5xuc
 goK7N7elp1csBCVLgXDiFsnTz38qkNX1oXPmEbTud73EkTXu1UaBWBtwWQEPJnG5uIFpO
 is0jnv24lL0ij8fkGIf2ZAS0X2ne0oDmX3qCWACsV/W9sJW2oDcMzN3cBFpk503t4q19X
 bHmy60BocE9BXNyEtziKyVBWqix/dEN8di96XU9N6NVXKy0SCI6+IkUQpv7NmdSPhvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="S//rAgib"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=S//rAgib
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62ADC606BE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2Dk9SECci/+cgWemmaZlyMGn+nwF5zFYwdKFiGzbjLUDIoBEN+fUNDx2w9hXin5lxsLew1u+6Vk9eF2OKtHs6MSGIuk/dmM6yJqs1jk/bFzm9zAH2474QG6U2Z8qtCO562P73SVqlfPn4FOJ/KOJxv39r4zZD81pLglKEylQvg3jIvgPs91sOeFjD8m2DXTSs2bVlDgg7Z7PxTo88PURQE3NE1B2HOhxj/Oql2jDkaqd3ENd+Jwrp4iSEW68/G7fkt/NB3LRoJpV+hjCbquTFtl60yLo2q0qT4TYW9jBVOLmm9PxqHJ9giUqQfH6G83ay/JO9lBFemBe5cue5GOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RbUwL675fQL2EM89bdZWZHPY9TKF61yQZEed1usicY=;
 b=divj/rBOf1gbeAjlqqZa6IYpgjm9U9Wvc1gE0NPlBy419hc6dw1teQNj8OcQYAuiM7EN25zx/qdFFJcsXw63woAsuVu3HGGLL9ibE6q5POJpQ8s8xTqvAanu9eFIv6fW3ONi9cxHOj64AIEH59r8aQMnGSOeNVXLGbAUGBrwBOsObia8GZsGY7WkaNQXh+MvxhSBgIjceUin7HXOUd4ePZpcvAFRO8Ldqm/B9Se1+ACO0Xfbozvu5chptUQrKFYQXJtRcMh8Jkbtgi94cSr/tU+z3bcTeFhEZbUmyikonF04L3nRdY1ZsDlJoUtoQHavUjUAx28oF0ZeOEao/LC8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RbUwL675fQL2EM89bdZWZHPY9TKF61yQZEed1usicY=;
 b=S//rAgiblQXTQBMXJKA7jiK7ckhXN+2cWTZ3+ueEQChIdLg916zONLJDuxA3NYrbs0gUc3tmBTjPDO137ogIJIW+pccNpIkwfSTE/tgTA+gyi6N7UmF2bTbnq+VBqWA95buYj4BMlF6qoEnoKtx3dM47dJ43UzUvkGnAaPsLAo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS5PR04MB9969.eurprd04.prod.outlook.com (2603:10a6:20b:67c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:15:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:15:39 +0000
Message-ID: <8b24cb33-c427-4082-b59f-0473a232d227@cherry.de>
Date: Wed, 23 Sep 2026 18:15:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260920161930.1880133-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260920161930.1880133-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000150.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::868) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS5PR04MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0d5dd3-9311-4db7-2e48-08df198de8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 631kQ0t5FasYr9l18c0hiKiQUvoli/F45O1DACDq+cE2eaiVPE+U0nezwVYYfvbYPscfrWmV9kCQss2zvfnIvuSJ/hVMOtkZT8XA0MXC3O4a/uswRff0rLIDNmm+9FYNgaFvZb8cfKlVgaq9Vxk7So2n6OcconW3nzUBJ5Z4mMJZ5w+W3f6e+qVPc9fLlIgXcqWyzcmCP/E8HWBOAAY1HSxFJOL+ULyhlo1If2TD/oK9WuXZOfr3CAWgIFOFlu62KkgRdfKkyd1lq7D7Ll+NjMur8ueFz97L9oh00iEWBoXxRWbh/RBQXasy4bnRGFZUdDxTr6TSc9+nb0BqMWvr6pwKn/Rp+P/F88LtzAU4tCiXyK7PQoe9F94Co5BRLr7x9dhYBTf8JmPDaz8RBVEok4b35GVLC3s7v0Jd9OKYEwkALm1lNkVYcUPUgqqG2wa6DNBGwxIn/xIJVqGNgjT5uVJXubo1CnjmjkW+KGMhPjgOFhXBp3vEE1s9GNcqHFVOp5Ljkcrscpr8qJwUfPUNEpFENd8euTx7XNAHU7ClGrZvq3J8Vhyf8w3WO27S7kp6FEn5Tao81ZCTBY2hguiMSbpfDyxFDm1tI7rEW5hGTbUo0VRDUvM7zmxzdIUzObC+S0gARKnE8j0S+a+sfYJx8faefxFKtXod8sC+vIUtu6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlkwaHROLzBjdUhWSDVLNUhmSUR1bDFxQlhZbHFReGs0RnhRRm84WGtEZ1Bs?=
 =?utf-8?B?SUVTMjhVSEowQXlYaytGeW91d1IyZXVHWStHNDJ1cTRGRmRDbWovdzRoa2tz?=
 =?utf-8?B?YkJKUE9rWHZJcUkzSC9pNEhvQUloc1QyVnA1T2tJTE5GUHZoTjdwbkpwMG1R?=
 =?utf-8?B?alN3MkZzRmF4TWdoZVdIWGw4WDRSTjVLTjVQTlNnQmFWc2g5UzduTUZiWXp0?=
 =?utf-8?B?ME43YmttRXMxZTlVbUJOU2Rkcm5Id00rbFR6THExWjR0aHo5SHJ4UFkrR1Uy?=
 =?utf-8?B?dThQcEc0YkdlSjhpSHB1SGpqOEl2MktDeXhwR0lWRDh0alRmaTZyb0wvZU14?=
 =?utf-8?B?d2hkbjRFRWtheTJONlRiTW52ZmRSMjFUM2JKV3JWUkJMdWVMdC9GMkI4dlNk?=
 =?utf-8?B?Ujd1cGY1Ky9wUDFWc0Z2NjhDd1paczBPMjRhaTN5VjdsZTlXSVNhVEg4bzVP?=
 =?utf-8?B?SEUyZ08vRnFwZEYyOVlGK3VINXZrL2p1aUJkdEZEWElVcktLOEM4REtTc0Rq?=
 =?utf-8?B?NFh2VGZEQUFXTlhOMU44ZHhtKzdoMXRXMkhOdUNmTjhOYlRBcmtBSFBxaFJU?=
 =?utf-8?B?SEhZQVVNM3JqdDZGS21USk5JSkdmSmU3TFFVTkpSdDN0K3VLSUtrSWFDeU1N?=
 =?utf-8?B?M3pLRFdjblFycmdGc3IwUW5zN1BGZXpXY2dMVEhXcmVadEhuNGc3TUZhOWxh?=
 =?utf-8?B?azhER0RQYUNHTDBzcjFDWGw1YTcyNU56LzNHMjJZZXhyU250UDZHVll3SUZG?=
 =?utf-8?B?Y0VpbDlTVEZtZFdUUkZ1YnZUb0NmcmFYdUc4OE1nVHRXVEhlRGNQUWRldDFY?=
 =?utf-8?B?K0I3ZVNzSTcrVld6a0hOeC9NSFVNZHNrTG0ybHVmRlEyQTBXaW4vS2xYMVZ5?=
 =?utf-8?B?OG5oV21sSGtVc0poS0RhN0hrTlNXQXBNQUl5NE9CeUhuVWw2U2VaYWYzNTdl?=
 =?utf-8?B?a04yZ0VaN25jbXUxcXRod3ZrZm5mTFhBVGg5VElDMEFFaFhqMVZiSzNkR1Rn?=
 =?utf-8?B?QVBqaVh3eHZ3SjNjTi9lWkFVVVJyYXZ5RVgxaUo0VXdkYUtuOWVyS2M0QUx3?=
 =?utf-8?B?UUs3RUlmNVEreE5XTFVGWUo3dkV0dEo3bXR6enNpOC8rSXZ3RFZwNW1aZHJS?=
 =?utf-8?B?UlZjL00vQU9wdDM1anFnbzBFdFZGeXRKcjNENGpRR0g1d1pvWko0QkFDNkdx?=
 =?utf-8?B?bWs5Q1Rtb2RjZlpLSnQ5UU9NRW0xd1ZuajVzck1OMDlOcVo4YktBUGtaaUhi?=
 =?utf-8?B?SFhzS0N0MitHaDVkbkp5SXdtMkc4dHhBckVPV1M4ODlGZWZmV0ZmWlNHeGRJ?=
 =?utf-8?B?UHVlU3VCUDVxaWR5b3Z0b0daaUdRYjhVSnpQemJNUDFPQmo4dzFWaE5xMlFE?=
 =?utf-8?B?TStRWnpYanRwUWNUZk5ocG5MTENtanBRdmZrQUxvVG5KbGdhVk0yV1NYMzhu?=
 =?utf-8?B?Y3ArQUVDODBLVWFuaGpaQnk0MDYvT1B5S0VHcXEzNGczT1VlNVBDN01yVndy?=
 =?utf-8?B?SWcrVGJjN3dGNTZnNk9Mb2o3TWIyaE0zN3hodnZ5MmFRVzYydjdUaW5xdFU0?=
 =?utf-8?B?RXVha3I2U1paNjFCSjRrQnBYeVI0TTdRTDFZeHhhNFd4UFk0eG1RbkR5eVBk?=
 =?utf-8?B?bmZLWVhWNEZtb29oZHFaMjRwMkovTExzNUY3bE1iNDljVEo1cHZaS21IdWpa?=
 =?utf-8?B?SzBpb1VoQjZLMnJ0NFdJdGZZS0JycVVxb25BTGVYTGkxQnJUenZJTWJuK25K?=
 =?utf-8?B?ckN0bUo5UE4yd29HZGQrZ2c5c2ZkcFZ6M0dnYzIrb28vWWc1NXpLbXZYR0NY?=
 =?utf-8?B?c0RZbm9XcEY0Mm0zZ1FXQmhuTmtXeEF2S2pHNEpaMTZGa0JGMkFieE1rZWZO?=
 =?utf-8?B?b1cyUHpIVXllaXNLSTJYQnBoSlpzcUJ3WCtIVTBySlhrMFc0MzJuM2dOQjJ5?=
 =?utf-8?B?b0d0T0xMWDJwWUJYdDh4NWxIY1hKOUF2NjcycnpneURMUWJLcy9WelYzRUdC?=
 =?utf-8?B?SmxSTlNqZGhrK2tsWW5yVElDckdlaEpLNEx3akdWSGUwY2RCd3JmR1RnSWNq?=
 =?utf-8?B?Um1UcnA1elRaaWdpWEFobFp0dTIzQTR3WStwS3pUVDU5N1MyZ3FpNkI3NHJQ?=
 =?utf-8?B?T2M5RGJBQ0NNRGVUUWNFckYrN3NqM01SREt4NEdyMjdOT0d5djlUa09xRzF5?=
 =?utf-8?B?VzBXei9paTI4UGNIRkp5M0EzeU9yTlMyY0JJM1dCcFUva1J3ZmRxa1dmOS9u?=
 =?utf-8?B?MkxxTy9DUVZhWC9pKzdSTnU0MUpaSnk3VzhkQm11a2ExcTQ4Q2lNc3I1aVFG?=
 =?utf-8?B?d0NxVmZteUc4WTFxMXlEbllMWTZ2bHp1MTN0YnJDSWsyQzNNZU5rUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0d5dd3-9311-4db7-2e48-08df198de8b0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:15:39.6312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wAufT58djdo8e79o4BYdq/NLWd/ZYdO2DLr9c0sFvFGPCPcb7aTDjwBUz8Ixfc7sGpz8+hY56xpgMA1hWnjeOLybqNw6GPhn60ICyTOY6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9969
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

Hi Jonas,

On 9/20/26 6:19 PM, Jonas Karlman wrote:
> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
> 
> SRAM addressing only seems to use 14 bits, meaning that reading from
> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
> 
> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> reserved region for its global data, malloc area and runtime stack.
> 
> TPL on PX30/RK3326 does not have any use for the malloc area, the
> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
> 
> Current memory layout possibly looks something like:
> 
>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>        [..., 0xff0e08c0)                       stack area
>          [0xff0e08c0]                           stack pointer
>        [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
>        [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>        [0xff0e1000, 0xff0e3800)      10 KiB    code
>        [0xff0e3800, 0xff0e3848)      72 bytes  BSS
> 
> TPL currently does not touch the malloc area, instead the reserved
> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
> the TPL stack addresses deeper into the BootROM reserved area.
> 
> Using current offsets for global data and stack does not seem to cause
> any known issue for BootROM after TPL returns to BootROM to load SPL
> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
> could theoretically change this and cause issues for BootROM.
> 
> Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
> to 0x200 to avoid overflowing global data, malloc area and stack into
> the BootROM reserved region.
> 
> With these changes the memory layout looks something like:
> 
>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>        [0xff0e1000, 0xff0e3800)      10 KiB    code
>        [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>        [0xff0e3848, 0xff0e3cd0)    1160 bytes  stack area
>          [0xff0e3cd0]                           stack pointer
>        [0xff0e3cd0, 0xff0e3e00)     304 bytes  global data
>        [0xff0e3e00, 0xff0e4000)     512 bytes  malloc area (unused)
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I intend to take this for 2027.01. We've lived with this mistake since 
forever and I would like to avoid changes with potentially big 
consequences like this one here so late in the development cycle.

Looking forward for what was split from v2 into other patches 
(specifically bumping TPL_MAX_SIZE to the one used in downstream).

Thanks!
Quentin
