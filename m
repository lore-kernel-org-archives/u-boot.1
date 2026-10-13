Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB99CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C542F404A8;
	Tue, 13 Oct 2026 11:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJZ5H_3pDu9c; Tue, 13 Oct 2026 11:08:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F903404F7
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791889688;
	b=KxC6EyuojlQssTvUP0Fx6V8nYun3+WIbxiAwEzcZsnYt+flaeJiUD8XJJ47pv2Edalh8
	 wsbV+3kownGuUZqkHVAU5y0blNKaDlIofQVSjiPToy9xF4ff71Yda+Oy7yTNXfs3Ke79K
	 Fp+rqO3VgoVc/jXBRp0QOjZf71+iD2O1XsnxX9rLwk+CbaUAW0eR1iwrRkcF16PcEsI9F
	 NcH1+X4E13oEBt0A+nXUNw4mqp9fYX92Ijia8Vvg+RXeg08vVY4jU/X8LckxynzwUdWRC
	 Q/dSp4xh/bLShPr904cNgJBGUFwGTBX234wkGD79hcAOFBgm1gASbatXmITAYwFbmig==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791889688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
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
	bh=jdRLgYMTXckLpdqCBYSTCCYkZbdurRK7uxtgcWU/YRg=;
	b=sX/gHrrGX/Hm9oQf2p6xRMCM9Hj+yNfL6ZCuCJ0ol4TbdA6gAdREljXKeXtcw2bRNwyJ
	 O0pTfDD0zSdZKDT/Nc98sghZy7fxwE2wvuKIrxO2VyzME6J7WQA46j+/nhY0FEWC+No0q
	 6IJUBDHdBlG7WvsO3TMc8XDy2qMnEqglCzCyB/0hDOcaRmC80sKBUEhw5AeZODGss/DRQ
	 0sFPdBX4xt87CTFz2cUBk1BZUYWfSMrFZnpYRENfv8rrJRd91osVQIjVIUnkOroG4Aj4z
	 nfAUoTauAX2akGhdcNuxe9XRmUNIhnYmKHVgJhtF0GSbyvJ4MMARUafiX6WwrUdiUPg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791889688;
	bh=jdRLgYMTXckLpdqCBYSTCCYkZbdurRK7uxtgcWU/YRg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mM9zsxopyjeWwa37LMfhzRpYLBH8nYEiEWOOBEHv/JboJcACXJG8RUeOryiKEkODF
	 /wfp9EUZbbP2ky/BUhtWfGUcxoalePdppCVYxvFJMO5fsDoqzAex4+4loATfobC56U
	 IV0Z9nySQ42qnzZy6LeXIQZj5+ZE/wM5IQp+CNsYZoSRvzySWBPx5+0CJz2hSJmWC9
	 Ibrk/mKCKMTTSw001McicDXvhpl/YE/bl/FHaAccWTyA9VpaZEavJNz8MzJA5Okx0r
	 oXlLv0QGURDGs/tkw2lO6si8eybqBO2mI54QM1oMrm0qC5aKnaa8rNd95FQEzXt+UK
	 VBVDRDmS1uNnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F903404F7;
	Tue, 13 Oct 2026 11:08:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 47F18DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 395BF60679
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:08:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wT1qUQvrymXH for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:08:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3FE686064D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791889685;
 b=FrOz9k8RTUz6Fq+ZiNIJDHmCi44+m2IUXqpS+P1HJjFHkcKzFIN828oJE53iL9G2D3ZL
 YR9ahn0l4dmk8CGN8eiCTXsozNnbG0gx9RK2FMKtt8sEL4OIWjVcWUDhZXUMzD/SNxlQy
 /BXJU55Rr6TVpZWE3GJFWP9tkAPB0lqiHJiPBU3r/Zr8taJqxDTDWzjuaTeRfnpCslxjI
 J82Px9UXN0+mZh1y2875sZom9mhXZe/tVmtRhKUPptZIaUq0IwyAP6I8JDb+n2XHyUzym
 58KPkncet7Iz3IJAbr4oUtjFDh9YOoDX23mSxcb6Q7fXhO5Ne4pd5RYYJMKfS0+9q7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791889685;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
 bh=jdRLgYMTXckLpdqCBYSTCCYkZbdurRK7uxtgcWU/YRg=;
 b=BjQKDrNko4zHltec9XjcwysA4i0D6xKFMOvjQuaijQahiKp3FOaxUB++NOUE1EB3/lsl
 zPSic1uMemm6//AXO+cJCLCairIap+8A35jk+H7HAAsNZVFOIuZRaoqfUv7CTlk8FXrPj
 3QCPsfxdxiCHhmC6/X/LV/nLETS8cFbghJzXe7LZfUAnh75sv10YjWp9hD+yFrULDtto1
 FKZLlKGmEN/k5Z6QGW7gWCsk/9Bd1JFrsAhjpADZVktIsx0+bTypXejhyW+p/5EUJ9Te8
 OfC/K+KUa7lgqPyMOggpyNpn3RqqGIwQvi8r94QRjLtK/gr2C+SkrplYZajyM5vaUhw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=PDmUwTvx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=PDmUwTvx
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FE686064D
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA9vOKNWjDRJoegQsHWGxhZOjlKMkJSgrmEd2X59/taCCgMrccm/KsK2htQaXrzKigxJAg5/lHEdfOXjRng5FIYpASL9dSlplOD026hbti2a1zzJ19Y1fHnMCzq6PrNzBARs2nwOz3V9D3oeV8D6Xq39lRr1Jtq28SW4X+RWQQzVwSeiqzZxLWjd2eHwW6tgcB+q7iu7F/3Kk72wXPC2QvkZwWtGpPFiJTote0nB72oDXaShRp7VIycLCeb1PeZP7TpYMZhSSXQ3vq0lIooT1NtMZtFrFA2krEvuGPhxryOBu5VjBrihrdOvRYhOoVO0YkjnWa6xS9BxidIWCRZ4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdRLgYMTXckLpdqCBYSTCCYkZbdurRK7uxtgcWU/YRg=;
 b=JYFy1irOcXQ+tgLIrWWn1/XcqL3ZHgmJSDXB9nO/ZQILPiiYwGK2xrXhp4/aXZNOPFf6jYOByP3AEJLiwTlCjHVo7jfUWNQ3k4CTwnYUjQR9F/b0KLsHVJVj0LHHH7VEX2NggxQE6L+c0zjaXD8oWaNcNabA3R8c+4u/1ZynFdZI4xigFsQr38i5otdp2sQMuDh2iUr7LYXXgZW9FxBdYkA0MsLinDXn7cE0zzZWoIjA4e2k00f/C8/4rnqIjIai9snUFSYmmVlp6SZp3a0wPTKbi8/Xm2XmjrZf0HK6KKk8lVDgZhXtRnL2X2HlW/WpxfwrMi0VOzIAicq+ZdCyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdRLgYMTXckLpdqCBYSTCCYkZbdurRK7uxtgcWU/YRg=;
 b=PDmUwTvx21+REJDudKvfpeDNQdE6P8r0QoscjgJ0Gx008OvaVDVYHWNWUKTqe1P1osnWRTMhgNiopP0dw46kQEfLV35ViZ/q7L7eX3m0qa9BtjPnRHcJyrgDzaCOHvHV5EVbFuc0cK9zac8rOwt+JuSYhwYbdhGbetAEBCKhl4dS2pYhiwXhfYTw+f1m0iNSlctlQMYJERqGb2hbwTuC6/XBxWqoJMz+cbGfYZGLsJASadC2MPXhd0RqOZhtNXk9wzDpF9xj0EkPQdkGBQJo4l/9t9gl/UOa+FBe3irt0HmdDTF+u41/crflQTJM+3+Tp4l3Ivl6P+wDBixnKn7T4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BL4PR03MB8050.namprd03.prod.outlook.com (2603:10b6:208:591::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Tue, 13 Oct
 2026 11:08:01 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 11:08:00 +0000
Message-ID: <22f40eb6-80b2-4a0e-9495-e5cd68e39a31@altera.com>
Date: Tue, 13 Oct 2026 16:37:53 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH] mmc: sdhci: do not time out a command that has completed
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20261011-upstream-mmc_sdhci_timeout_b4-v1-1-f33c02445924@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261011-upstream-mmc_sdhci_timeout_b4-v1-1-f33c02445924@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BL4PR03MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eda36d-5fa7-4834-d18c-08df291a3ea2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|261009223027099003|10067099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: tSQ7vhBVb893uTi84gdEez8RTJakNnyz47lTTVgtQGqUo+XQqQIianCPFXc9JJJB3DRGlP3dB/eRFM7rKjZm50+IcnGr29BPor2i6gBLwlR8bH/d3ryewy5qbMqxVy9SLniuQzsFIQ7Q6ZK8yDotbU5LFzjrr7dykekAjV3mBFbgT+SstFrt4wk5Dn7cfU5pBlj4YPOvh1ab9mA6f+84AWDvwkL6i3kH5Fwj4we7uycJzcXe33vZVxvyp7/udJ29P9EryroeeT3cVwefl18izngEpgYufEenCl4BN1JwcsKoR/RZTXy/XZbrUpvxoUUGAFV8Z7st4LffocU8xSon7Kuu1j/LDcrvl1nvSrz1/1S+W2q6ITs5oLjansnZGDy+rMnZAdFmEYMv098CX0E9kgbmIHscJ7wBXlG5MM9oHroHNxMFMYHyEPWyshZMN4dHM8gS/XQhsQsXBt7hkUKLYCIQFGLttcl8baUOiyM/3/WNIjdVQl+4dgrSFmDNJeSwXyBa/jLJ9ZlbuEzJiMnusX0getj32eMx+Gq3vNmXdnj9cd4aXzv6SYRiHujxXqUhzeGarv74bWPS7JrhobNaXiUVGQmFDRI8R8MyCMB5NN+NTLuuwAYTJ724fpWVw+nTZjsRfrAof1kJPlblAFN9LqmLTHpqZjo45s054Ssvty8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(55112099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlNtNDlmMlZNZW5JWHVnb3djN1pwbW5NMDFKM00vMnJsSFM5NXB4MDB5QlZQ?=
 =?utf-8?B?ekFFelNZSHJEajlCQ21MVDFmTGNaQVk0bkFhR3h5RWV2M2RZYXB2Q2NxeDY4?=
 =?utf-8?B?WlQ5VzhTWmwwNzZnWTBzUVcyUjl0TXpxK0dtYzA1emoxK1JzK2UvUXpVdG1k?=
 =?utf-8?B?OWE2c2Nhck53cDZYbTY4NWFxRHZRQnAyblRlNVowdlVaWDA5M29uc2F3RUo5?=
 =?utf-8?B?a1dpMmI0YUxtWlpweW9WUWRoNHhSZncrRktCaWFqU1l2dkxrQ0NiRmQwRENR?=
 =?utf-8?B?L29MOEloeGpOQ2huSmVnSG9uZ2JLMmgxemFacjV2aXk3TVVsYllwZGJiUmNh?=
 =?utf-8?B?UmUyeFVwSWRjVDN3VjNnL0pyakVJZ2xlVlI4bWdlbElHbTFSYkRsMER4VFZ4?=
 =?utf-8?B?RHhTQUdFM211NTZGV0RIeDdsTHkzZ2hHQTRFWGJpVlI3VkI4TmxZRHJFWmtm?=
 =?utf-8?B?WEoxWjEzMFZKMkd6MUc3aHFtNkVEcmhoK0ZCODMreFozRTFKcXhsT1ZUcGE4?=
 =?utf-8?B?YWJ4c3pZeGp2dEF0bmNTL2VrekZ0R1B4bUJFTFE5dkJsVmZnQ0VRMWwrU3ZE?=
 =?utf-8?B?Q0VjV1JOa1FXdFBNdmswRnpBdUt4OGg2NFBSTjV6SFRiVW05K2t2U3krNUFo?=
 =?utf-8?B?S2RqYVQ3anV0RHcxYkpvdHJpd1MwR3UrMDlJZDFsb2ZVRGFoTkZvZmdZUjIw?=
 =?utf-8?B?dkhNd0tsb0R2ekhmeFRWYytjeHg4K0ZkWEhrTklJajk2a2hmcERCYk1oTENj?=
 =?utf-8?B?YWpsM1BtMzE3TkgxQWlUNEErc0F1Z0h3QVNnRjBpQjExZ09FSVlFVldOazhB?=
 =?utf-8?B?QWo5aHJEMXQzUUxoWm9HVmdTQVQyR2d5aW42MnBHL2t3dW92VnlZSWlzRG1G?=
 =?utf-8?B?a0Jsenk0TG94eWU2QnA3WFlydGJKRFlNV3JqVy9UeEJ3R1IvbCs2UThySURD?=
 =?utf-8?B?dS8xMWZKbm1CcFYzencxV1YvdGc5WUtHTENXQ1Z6RnB0YmhuWGd0ZC8xQWp1?=
 =?utf-8?B?aTdpYWkyS3hhMzdjYXYyY1JKYUhiS3FWaU13aVBnZzJkKy80Wk15VlBCdVJa?=
 =?utf-8?B?S0lMZHV1RUk4aGdwQlJjTGI0ZnpYcjlJcnpZRHFodmQ5ZEx2Q1hleG4vb0RU?=
 =?utf-8?B?ZUZMb0V3bVYxT0dyaysxZVpuUnFRMWlvSVZwZWlXSGxBcFkxUEswdFpwd092?=
 =?utf-8?B?Wm9ScGs0bGluRXhkMW9WU0JtajZKdS9kWlcrVzZKV1pHdXF1T2doY2RZYjBh?=
 =?utf-8?B?YUlFNkNHd3dhUThHSU84YXl5clk2N3lhcytEb1pKRFY3dHFkNzNEY0FYMG5D?=
 =?utf-8?B?dzBqeUV0WHVobk4wZDlxUjF3Y2NBS2hjMTdHemt0R3RSc0R2MURPZjdLR0Vz?=
 =?utf-8?B?UGZZelg2TVByWWZleEFqV0JxWVdUVGVHdGoreWk5d25JTVQxTjlJWlZ3cHZP?=
 =?utf-8?B?dHdKV1g2Ry8yZmFkZHRKa29idWlyYS9pVm80RDhsWS8zNmg0TFhGODIxWjVk?=
 =?utf-8?B?TC9lUkpiWmV4WlYvQWNEVVpWTUpsK2VMT3NsYzhGUGE3dHNyRFZ2ZnR4NDJh?=
 =?utf-8?B?WDZicklsYWRtOFNYRloxY3gwOFRSYkQrNE9DaFNUblhFdlJlNTFNdE1yNnkr?=
 =?utf-8?B?bGxSYVdoTFBmL3dXd0p0MlkxWTMvQTlic3d2NkRjT2tidUdCbUF6ZEk5VndF?=
 =?utf-8?B?UU8yYS95T0hwQmMyWkNWZXU2K2pXMXp6RXNsZm5QR2RXMk9tdzNSeWJzZnZ5?=
 =?utf-8?B?czZXdFRoZ0l0Ty93WmU2SGdoY1FRdHkzRjJwaVJaYzBDZCs1Wk9HYVVacjUz?=
 =?utf-8?B?VkZRZHhNVVFKWmo5WEx1WUZOTlFZK2xSTHM5UXBYRDZxUDNTbFd0blZ1L1pF?=
 =?utf-8?B?elJJejQxRWNEN2xGeTRtZ2VFeWNYV3F1K1ZWYk1iRVhUeDNQQjVhbm1vOUpN?=
 =?utf-8?B?eFlNWmhNRE8wWjBSR3VWd2ZlbEhNWVZ3dG1ybU5uOHQvRFMzZ0dZdjdNc0FZ?=
 =?utf-8?B?QVMzT3JEaENVQ3VFeXJ1OGNzYnJlWE0zU2pJaFlCTGNWRGxCb2QweGs2S1R1?=
 =?utf-8?B?L3lVaVFpbmlrR0t0cmpJcTBWUUdqamVlemQxVXppbVk4STZZUk5UanduNEV2?=
 =?utf-8?B?RU9VZDNJOXVnS1dzTUEwWHpKQXQvNlBPenNuM3pWTVNNeTlzNFFSazdrYlFJ?=
 =?utf-8?B?Z1lERTlSaXB4T20wdmlwS2ZwYk5zZFltd1RuVVJHQWZIVE03OXFTUkJpNWdT?=
 =?utf-8?B?TFpjdDRNcFB2QzU4V0JTeGc5b3RmUlltN3dpS1VGYzQ5dDNJVzNDRTdQZUU0?=
 =?utf-8?B?di9JTXozalJqWE9EenFkdXByTG1BRmxUWkFJa1lQdGI4bkZiMFN3S2xXeXUy?=
 =?utf-8?Q?pd0KAMUS15zx38F0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eda36d-5fa7-4834-d18c-08df291a3ea2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:08:00.7783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OBcFCJy3r1pHUoDGnLAizF3lx9gZwetaORNRdNEvRcKlgIWGVSlfck1yqnbqOHRcXmHj6/lWK81pqIDsxYa2FKE1gsBIGOjKhlpiWhDu6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8050
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


On 11-10-2026 18:42, Igor Opaniuk wrote:
> sdhci_send_command() polls the interrupt status and gives up after
> SDHCI_READ_STATUS_TIMEOUT, but it evaluates the timeout before it looks at
> the status it has just read. When a single status read takes longer than
> the timeout, the command is reported as timed out although the response
> and transfer-complete bits are already set, and the caller aborts an
> otherwise successful transfer.
>
> This happens on QEMU's SDHCI/eMMC model under TCG: a large ADMA transfer
> runs in a timer callback while holding the big QEMU lock, so U-Boot's next
> MMIO read blocks for seconds and the subsequent command appears to have
> timed out ("Timeout for status update: 00000003 00000001").
>
> Check for completion first and only then for the timeout.
>
> Signed-off-by: Igor Opaniuk<igor.opaniuk@oss.qualcomm.com>
> ---
>   drivers/mmc/sdhci.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 962a99cd05a..916c7434bbc 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -306,6 +306,16 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>   		if (stat & SDHCI_INT_ERROR)
>   			break;
>   
> +		/*
> +		 * Check completion before the timeout: the status read itself
> +		 * may have taken longer than SDHCI_READ_STATUS_TIMEOUT (for
> +		 * example when an emulated controller performs a long DMA
> +		 * transfer while holding the guest's MMIO path), and a command
> +		 * that has completed must not be reported as timed out.
> +		 */
> +		if ((stat & mask) == mask)
> +			break;
> +

I think its better to move this below the BROKEN_R1B block. For a
no-data R1B command, this now breaks out and calls sdhci_cmd_done()
when RESPONSE|DATA_END are set. The quirk currently returns success
directly once DAT is idle, without reading the response.


>   		if (host->quirks & SDHCI_QUIRK_BROKEN_R1B &&
>   		    cmd->resp_type & MMC_RSP_BUSY && !data) {
>   			unsigned int state =
>
>
