Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8E606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z/NlxM3s;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E48Jh0e3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07C1A407BC;
	Wed,  4 Nov 2026 09:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYn6uFQalo4M; Wed,  4 Nov 2026 09:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2AB734078E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793784717;
	b=gCZNAs7709JJscRiURyJE8ylSzggkC9NuEACO3klRMmiO9TYJtq0kB1Gb8ebSzvi38Rp
	 tePrYs9EBMvd90pT50+Ols8LY7n+ufR0XKgoDWpcThSVGSxxWmBrXU57YQAcr4WAT0pNH
	 aQJnoshfYhXDsg66QfipJ3G/SHfPN4Ulu47grYkh7KwCplwwz67Vgiis34mGYGeoG/eSm
	 UYTZSmEoqaUHREVcRCFZwNBpr6T0L57BLjDW03Z5P3BgKkMRyLiZxUZuZagB2OXClpMX2
	 moTXV/fleE5Gr2Q2wbjJEhpYtWyESCvT8xS3RjOlzk95UajQFXHx30gT1/9GMROlvsw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793784717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=3rO2n/GQiZOAFemwcUl8BE5uafAYoVXBuBvEVY3KtpE=;
	b=X1nYDWzfriP+hqJ4s2GghEZZrX5o427lLq9JWNxHUJ7znRgNXcUJE300rBLxZNrIuotK
	 tzNF9mJb1qeJrxO6Gxg3yNlQkQZxALUKh1c+xTN/pASqZoyDCMsaTcC81qUExF7LV8BoG
	 JBhWELSmwMo+c6SoCltNr+zgz3kaPxu5VNG88Hijw4r1ZsVZWo+Y+wFdtFkmbe++TJqKt
	 jvJpftiKQEl/Ha2DzSqZo7cLQL1gj6uyXAJfZ+R6B6N7gbC1oU8bV6rGqvuhn6nWZaVby
	 wBPjqY/jAWaKrb58tKoHDbV3ydT+0aTnfMc+rE6QLRmIZNLHgRCStTNy/BslP3pXR6A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793784717;
	bh=3rO2n/GQiZOAFemwcUl8BE5uafAYoVXBuBvEVY3KtpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z/NlxM3sD3lH9Xrr7rT2c0hbn18I8ReTTZFsbkuw6JTGLAcnsnlOCVPwsspHf8Juh
	 A6V94T8i7w0rvlu9dUnIIcr1boBk+suAD9t31NQaGZg1o/ZGan2uua1z+toHrqcmkZ
	 WSfkb3Z4Z6zTQcfIi0xHJxg4BcQu607GDtL3h22XyRknlQzORT/9dRhRKlUtqBZBvC
	 lR4QEDYE6humopt5YxyGhDEaB1iNPe1cTfLq92zPgNBeTcKyMoxjz9fyC0+vYiVY3G
	 07MwPAXpJOo5+FnDSlua6RaWvv8CBvLHi/ymhwVRfnQkgDsb67yJnOrdlK5ET6TZoP
	 3Va8+YpILUrDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AB734078E;
	Wed,  4 Nov 2026 09:31:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0B382B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 968784004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tbIvFFB7zCel for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:31:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BB555402B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793784715;
 b=VoSUmMxteJtXRvVQNFsa6tlA/nB2/h51x6KbVo7LlPz0JkVo8iRybCy+jW385FmEFyD6
 JbkW1lKEtM1MKQawytxz04GL4iTcKWQA8vCsR7rSE6+a+u5t2SPD0WSgkfmtRYeIXs/TF
 XgNUmEfUKO3IP/d4XZbCbcb99Gb65TwhlBFSU+ojzSCN6E8qJSlYFHRYIIOQ+b2RtEIYI
 kTBRj43tNdGIRO0w1BGg4/DDyDWDoqFQThB55M2C8LPYRZyYSjuLmMYYAgb6wNFJ8maqU
 r05KM9Rp5CwN0yElhz3OnUcJAKMRkZfpL7rFNrCMnR6TN4XkZi/o0HJETVOVZPC7FPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784715;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=3rO2n/GQiZOAFemwcUl8BE5uafAYoVXBuBvEVY3KtpE=;
 b=FV6lxeDlDrAxK6Qd/KA9Ph+IIvMbFciIhgOJyBLv+XdX3XQOCYN01gMyjdQEVi2daJt/
 c+nY/UlSy7ba8iDsJ67ml+rAEJqQRBEQ4+oSJYEa21MpEhX7AW8Ybw0QHwTPKFG+g/4fk
 h6oiW0DOJqBhY7eoXHRoiL0P1rVM6W8ij0wWK0VdBuqCOxs35/wLsSMjP5HXFei5WkzRM
 5FaJgNKBnqDXEzUG01HUZ4V6FU22dccCkvyfrjyXEKGXIbGMvY+04rlyOlBjbgaLr29+W
 lHIgYeLO5IfnNNWBYcbY/7sQAF0v2rWdL5i/UyuZj16OMYH0kB9XOwEyzZDIUrvp+Kw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=E48Jh0e3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=E48Jh0e3
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB555402B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frL48fw8l3iOtfKKfo8MFfzt2xaQyguG00PJJ6lVq2H4C9vDYxStrJfxeIpiHYQD2JuQica/eYQCeJtpqeOZs8x0eTje2zxjXw5dRaFZWcZC5ewRgBWca72J9PCvukp9tfa+uxASGJ0x9YWYdTdDnqU7sTRsGPYGOoVG/1Wz1tZRTkbKysFaLOABLJ9jbDel2S7ySYYuiKr763OCQPFId3FND387fi5ca7CBpoBhjv8KlNhy+cNugAHSXQt3kRJv1Tz/9mqHgCANjzyzfTafRWeOh/G7tqSgDU9YezxCvdlhcR4aOvZQ82xyqPp9yUiCLJRJQ07XKiv4oshLAh/Oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rO2n/GQiZOAFemwcUl8BE5uafAYoVXBuBvEVY3KtpE=;
 b=Gy875Mb6jjI2420DN6SLfhvp0nqENd5j6ySFqUN2maRtvMFB0/Gmx+Q5/nC0Z9h6evKRk5AQJqNsIgQ4PQ8Lb/c/fhfwgYL9a7y74PCshYqUDJPxetJgfsdbRZtbBEmwtA9byaBpl6nhc0xhgHVKeuRGm/CxFoplr2+Egf93zm1g1SYdiWochG8E1/VqmoauOKaFOGVrYIal12oiUlB4hHfjXG2jtvGgxPMP8K+xMlEdpwRx5cn1mPo6Dfzq8sT/yb1yIeeAeP71/9mBDlza1AUMnz2GUIByNFgIE20R0YELX1fulY4G4apHD2kmgd+3nRS73jDki8Flc+GLXzHupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rO2n/GQiZOAFemwcUl8BE5uafAYoVXBuBvEVY3KtpE=;
 b=E48Jh0e3O7+uu/kgEbjMznmdtFkLQy044GBa4CMyYTz8CNPD23KQGw5QHWzn5RAHi2lObW5Ab1ygocKHOv6CyAmIyiIB8Yw+8RUmHLwfcZv4BF1m3Y0DgnpprdTHnne9RfVxAf1uQw/tAfbTy7o5S8nRmW2T4DxlPT7N6AczDrU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA4PR12MB390589.namprd12.prod.outlook.com (2603:10b6:207:13e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:31:50 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:31:50 +0000
Message-ID: <4b8a2f71-725e-4b87-a343-c0ad22f4a957@amd.com>
Date: Wed, 4 Nov 2026 10:31:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] net: zynq_gem/eth-phy: fix resource leaks and
 shared MDIO bus teardown
To: Graeme Smecher <gsmecher@t0.technology>, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::28) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA4PR12MB390589:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fd782e-9fe5-49c9-7060-08df3a567478
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261021121427099003|261026121527099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SC3pIQjbZ1pNGR2jvT3CsQcWZdhGKdPpMrq9tc0Gtx6aLgHU++tapTnEMkxhwCXkMyBO7Tfa/v5c9Jm9RfzpI9NgpGPLtfdiDLCvhp6q+rBisvdkS4NvOadmLa6l5zpQcH7VqaBleUeBCGz7p6+WRH3PW962L/Rr6WvYIEzf5TOxyV20g7c9HeTmzbbxk9hTrOVBZe3Kd4cRgQz7xO68qVkDvh9SWW6rdoOEiAxQANixfAMFo2c0N9lcL/lr9ct/P+CXZjbSbsBG4wH6mr0kHw6zBEaFftpQPlUJq1JRQFEWhcy4Kcvp18kWnzfCMG1vT9AaS0KwL+xUeI506owowcqHP2wGxz7Ia/3uWmuBoiPXPELt4PHudY+9vv/rLGEZ4ne28IK6XlzwB5AN/gq02wwdki8OCAyx43JOUPArgN/CY8a3NLnQlqWDnA3pWg+ZOKTuyuhaOIHHygNE3YFavEwYoEQZ4mBq2oQM3GKFP1m+QsTuTCj/KOZYGsKQJhih9IH1BwhDWuytTIgcJJJS0cUUG5VkLpsOU3/lIQKeiLSDG0BXTYGj4SihKtwRs15iP3L4J0rHWbIADWDb3T7ViTriHljmIPNIsUdSVOZP2fBpqGXtqaoXUdzZDjsj87uWtYaPn/Di1Xyfjl3g4S/wh6XRPeYzHV1wh+Gw5PI9dbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9NeXNHcE5jR3BaUXBQUjZhaFQyNGJNYWxyeVpiVkY1RzRIUFJ1a08rU0xM?=
 =?utf-8?B?bGNhNXZtMlMzcUpFQm00cUgwZk1XOTZMdTg2eVNPdHZ0cXA1ZnJtQ1MrMXJk?=
 =?utf-8?B?c3krNG5weXhoLzhLTlBoaVRFQ3ZyK3d5SjZWc0lHRjB1VWhTZHh1SjFWNTVR?=
 =?utf-8?B?a3EwaDFaMEFxdmNUeVRiMmYxWHp3L1NVa1BKdXgzeS9xZ0xEOXdyYW16TFFB?=
 =?utf-8?B?U2FFUEhkSWNPWmNpRXlDeGt5Q2Nmb3FKMmFsdEtWUDNyeGpNcW1QaVBodTVF?=
 =?utf-8?B?bVhkNDhmT2l0ZktXdmdVNnNVTmlNczlpRHVycFZjSW9pZ1MzM0VSUS9yS1Uy?=
 =?utf-8?B?Uk5TK1NmZGxkY24xZitka1pqNVhsZUJITnkxQmJtb2ZxemcwSFMxZzdjZGZF?=
 =?utf-8?B?OTdCdzMyc3pyZ3JzaHBuL3UxcXozaGk1UjIwNjZ3dG5LU2xIejhSREFrVFBE?=
 =?utf-8?B?TUhjRWxEcUwvcWh1NUdJK2s2RldFWGh1SHY5ZFZDQzMwaVBCK2V1UTlZdHRW?=
 =?utf-8?B?VUhWQkhqZ21HckJNcTB0U0RuSk1lRUhzblVEV1hzQ1pJSmxFMnhGZjZpNG44?=
 =?utf-8?B?MU9hTTNDODd3K2ZGb0Z2QUpIa0NuZ1ptaXBkNG9ZeFhEYWNHNm42cWdwM244?=
 =?utf-8?B?ZVZ6TlF4bUFqZHM5Yk9rUXdjeVNlZ1hibUtxdXZ5N0VwcWlIRlpQK21yVnZI?=
 =?utf-8?B?NmRod1RMOWpvSmkvOVpPd2VMQS9aUnZSZ2FhTXVwK3pxM0FtMVVnZTNTYkdp?=
 =?utf-8?B?RFErTXpFWEhlK0F3Q2Z2MmZrZkZUMGhFMlJjeHE2RzVTUE9ySHBtbDl6R25C?=
 =?utf-8?B?am5yTFhFR08zK29tZWJmNnpNVGZmZDB1WWc0OHpON1lwMXQyYnBKYjYwakVt?=
 =?utf-8?B?TDdYM3lFc21DOCtNZDZpSS9teCtWNFc3UERaRjZZaDJmNm0weTF3YVFXQ3dC?=
 =?utf-8?B?NFBxUEQ3NDRkQy94RFBJTmVJVnhsdURPOTVQbkNBc0tTaDFQaGp3WXcwb3ZW?=
 =?utf-8?B?ZnhxMXIwL0NiVjhtemtoTjF4SzJTQzl2L3JzQnI0aUEvaEs3VVBYaXB2bU14?=
 =?utf-8?B?TW9rR2NmMWhPMWhMWno1ZTlvbnUzemRIelNjZFhjWEs5TnlwM1NyMy9Cc1pP?=
 =?utf-8?B?dEVZb1dJWERFUmxCNXZDNlZuWmQzc2RPQ1E2K0E5S1ZCc2Z6UXM4ZmFFaXh2?=
 =?utf-8?B?SDJwQ0JTbE5JSURUTk1HT2pyY0cyUzRpbEliL2dvdEQ4TG5Td2plMnpJai9W?=
 =?utf-8?B?bHZJQUtGbjJyQ1FCRFdRa2NPL0VEZUpWRDFmZUJhQW4zMHRMNGxpd1cxc0o2?=
 =?utf-8?B?M0FQWGRaVlJ0aHdtRzNwODVueHREbW95QzBrRy96clJHQnl3Z1d5c0UwdGU0?=
 =?utf-8?B?cDhPQkczNmFaaWFRc2R3SUZ3UGZaYy9oeDhGWlBsWVFZVFpUVWQzdTRob2pR?=
 =?utf-8?B?dEpER0VtVlFiTkljdWRwUmxDS2dDdjBtQVpqeUd4ZTJMdkdPSDhzanBrc01U?=
 =?utf-8?B?MnhMWnBFdytTajdSMmlUbUtJYUR5YjZ1azUwcWJidlRVQkU5TTFCN1ZTV00r?=
 =?utf-8?B?MTVzc1I5UmRmYzNISXR0STRqdzNSSllSTzI4KzlTamNnWlhuOWpDUVY2eVp2?=
 =?utf-8?B?dzRqNVlTWFk3M3craGg5TjFtekhONFVjeWZtcmpaSnljanE4OHpjUlJvVlJn?=
 =?utf-8?B?WFhzbmRXMW5DTWRhNzNpaWRYSCtkSjFNUUo5dWMzSWk4Q0tqK0N3TnRGR2J4?=
 =?utf-8?B?QzVmM3g3UTdldVk0Q1V6cXdzd2NIUUQ3YVl5VjhKSmhLRWtWNDR3RXFPdmp0?=
 =?utf-8?B?ckdnZGlka2pudFdqSU9KNFVqZ2xFUHBYZ3kyOFh2SjM1Y3lidWM5YTFTbWU5?=
 =?utf-8?B?YlBwSVcxZHUzTVJMNmNrNDEzYW9kVjRGdktJZG1meUFjb2pncmF2dnF0ZU9y?=
 =?utf-8?B?dmoyWWxkaSs5bWtzcXBzZjBvdEpXM21leVZINXNhNi9GQkhuQlN6dnNsVHdu?=
 =?utf-8?B?dmFYbU1OQkNveTEybGZhM0M5Y0FBeTQxVEk4anNYS1NrZ1BtU2pqdGg0SFVK?=
 =?utf-8?B?YTBlajM2bVhybUFYUjQyU3BtZTQ5TVRGSEs0cHErWFhPakhLNjk5cWd6b3VX?=
 =?utf-8?B?UGcrRVhja3c0eTA1RS82NEFDZnowQlZMNXBCMzRHbGx1QXFtL2s5ZDlzVng5?=
 =?utf-8?B?QWZXWGpjUmh5UTdvVzJPekZwS1BWK0p5cWhCUkgrZnVna0lmMWtmem4zelNO?=
 =?utf-8?B?M1pxVTcwSG1Pb1JlbXk4R2RoMXFZM1lFTjdLRXpXcDVER3c3c0NDVFlxOW03?=
 =?utf-8?B?b0daOTdaOENzSkQrcDhHNU4rRXd5dXhTWGY3VUcyQVhHQnB0YTB0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fd782e-9fe5-49c9-7060-08df3a567478
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:31:50.6792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jt7eMiXr9kNJGSi9XRFozgWJImZl003UHn35HGXY0EWA7MkDugMlIG14iliDqu/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB390589
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/26 19:43, Graeme Smecher wrote:
> This series fixes resource leaks in the zynq_gem probe error path and
> remove(), and makes the eth-phy uclass release the reset GPIO and reset
> control it claims.
> 
> Patch 1 stops zynq_gem from unregistering/freeing an MDIO bus (and the
> phy_device on it) borrowed from another controller via
> eth_phy_get_mdio_bus(). Patches 2 and 3 plug the probe error path and
> remove() leaks. Patch 4 releases the eth-phy reset GPIO and reset
> control on removal, so that the PHY can be probed again after unbind.
> 
> Tested on QEMU (xilinx-zynq-a9, xilinx_zynq_virt) with a DT in which
> gem1 shares gem0's MDIO bus and PHY, and the PHY has reset-gpios and a
> (syscon-reset) resets property:
> 
> - repeated unbind/bind of gem0: heap usage is stable, and the eth-phy
>    device re-probes. Without the series the remove() leak eventually
>    exhausts the heap, and the eth-phy device fails to re-probe because
>    its reset GPIO is still claimed;
> - unbind of gem1 (shared bus): gem0 keeps working. Without the series,
>    gem0's MDIO bus is freed and its next use data-aborts;
> - injected failures at each probe step (except the SGMII-only ones)
>    for both gem0 and gem1, followed by a successful re-probe, without
>    leaks.
> 
> The SGMII/generic PHY error paths are build-tested only.
> 
> Changes in v3:
> - Rebased onto current main
> - Split v2 1/2 into three patches: shared-bus handling (1/4), probe
>    error path (2/4) and .remove buffers (3/4) (Michal Simek)
> - 1/4: also only free priv->phydev when the bus is our own
> - 2/4: free priv->phydev on failures after zynq_phy_init(), again only
>    when the MDIO bus is ours
> - 2/4: call generic_phy_exit() on every error path after
>    generic_phy_init(), including the early returns after
>    zynq_gem_reset_init() and the rxbuffers allocation, and
>    zero-initialise struct phy
> - 2/4: use descriptive error labels
> - 4/4: rebased onto the eth-phy reset control support; also release
>    the reset control with reset_free(). Use per-feature DM_GPIO/DM_RESET
>    guards, and reword the subject accordingly
> 
> Changes in v2:
> - Move mdio_free() out of the mdio_register_seq() failure branch and
>    into the error label ladder
> - With CONFIG_DM_ETH_PHY, priv->bus may be a shared bus obtained from
>    eth_phy_get_mdio_bus(). Track whether we allocated it and only
>    unregister/free it in that case, in both probe and remove
> 
> Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
> ---
> Graeme Smecher (4):
>        net: zynq_gem: don't tear down a shared MDIO bus
>        net: zynq_gem: plug resource leaks in .probe error path
>        net: zynq_gem: free buffers in .remove
>        net: eth-phy: release reset GPIO and reset control on device removal
> 
>   drivers/net/eth-phy-uclass.c | 14 +++++++++++
>   drivers/net/zynq_gem.c       | 59 ++++++++++++++++++++++++++++++--------------
>   2 files changed, 54 insertions(+), 19 deletions(-)
> ---
> base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
> change-id: 20261103-zynq-gem-remove-leak-b2b5afccebcb
> 
> Best regards,

1/4 and 3/4 looks good to me.

Thanks,
Michal

