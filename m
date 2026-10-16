Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C63CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 10:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74402409F4;
	Fri, 16 Oct 2026 10:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tU8qDRqO3b9M; Fri, 16 Oct 2026 10:25:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6EEC1409DE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792146348;
	b=VshzRTozYfsJEYa+X3ik8fBsp2IYbANqvdn3AFvmBH57DGw+N97+3Kxy9i5OwsW2IHCc
	 Lak6rNaoGww/G85NvJruhR2C1/QlqGFDYpYOrVf4tLDo1ciU5zUGqB2tIsi+92IAdF9li
	 c6xk9yBo9IH3DbwS7R2PRC55X6OQ9vWo7LW/FgSTs3DQhvdL1cYkFHDDg4H01zzbGWcZD
	 i571H+APiLquGdpdPyB3J4IsHhdLUV0qvyc7SKScAhuWgmTag7+oJwS8Q2JmrdtRGnQ8n
	 /cAaalhHhgV9V+JMBqKzOiUkiyzXx9Qeit5cyVisaa57Be8QkmlsYs1J3YDxEuJPKhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792146348;
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
	bh=sH3ac7zNedkOkG4cJWifZo5wUjihPhP1cg7nGWUS0pQ=;
	b=B1mH71IehICE1qCj3boUEtwWCRd1xHerLUK3k3oSB2VTbMoczfbEHfsFw1RTUaXycxyX
	 16uukG7uSyj0C3SXjNYINy/qjfUx/fqfNpkCCfe8XmL1WhnfXVdSccXJACcs/ppA/fB+V
	 1A2HM5UOvFBVoqYW7PNpSwQ7Q+73puvNvgHZM0//0OFvNsqsKbsNPparIWuwhEfOCkKW2
	 1zOwc0ZVq9DSPmk/LEQ/IyN9Qtmc3KbOHdUE7KJ3glegwGPc+qFaWdU7/iKw+XVMBvxD0
	 d6Rdqqd11sz8nkhWJtzdU15GbOqnsUXiRo4EXFRqQ98G3U6xgdREHKk/CsXC+xmKC3g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792146348;
	bh=sH3ac7zNedkOkG4cJWifZo5wUjihPhP1cg7nGWUS0pQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOhYOo/d8v3dow5Fh3IeNppGpREG9qpNHd+SEPJCYfNKpmXlVL2886EYj/YFRLb5I
	 pbv5+biuX/Y1CgodmKVJoTNOLkGyBNEMq0+yJDI8AbZPngGPqqXNE8xl3o/ZDU1b1x
	 gKqq4XRg8WeejVcApkRu5pV1otEmHZHR+SFyETX5DDhV0rIP/CAkN5uAdJLphREJYC
	 qdx9el7RsN9uV8NG3dg3DFxeatYXeGIUDFfkL+t4pNMkNp34LpP6LJ+qPbutPtiJPx
	 WulrVrMK3jeyU4Vt0XRlCn9kEZ+xa2bd0nAK/9CBwWgjx8GH3fZuVSWblwZI2e5D2Q
	 V9gKUr7QxqhgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EEC1409DE;
	Fri, 16 Oct 2026 10:25:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 36E15109
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 344568144C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rILjw-2n7ssa for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 10:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 860138142A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792146345;
 b=buMAjjnUQ2hxmLxvYZsra8BYWD7Oyi4s5P3kvrAMIiXfXvQvs8par1s20Yc5kgrAyKaA
 YhY46CkfEP+asZe5PGCSDKPvYr6b/GzJSUe11gqBPV6VPchXFY0jp9yZTQzyGYGVRwXJ1
 WeVwwEWKtqMjDTSmvXV8LtQwmEYiRuiGZOjKSDGVBabFGXUpj4ywN9k4NCyzgKGTKAy1T
 6mWT3R7z1rqkNCwwgTWxzsGxa2IaJPE9B4SY4M9En2M16KlMA/6KwbZn1gRq95OfGeYBk
 BkE3QxL0Cu1oskMdfidve2POXJ2ewwJf1K/YOo8SKY8AXKkpNMUjAhJyfFNz+bgBQVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792146345;
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
 bh=sH3ac7zNedkOkG4cJWifZo5wUjihPhP1cg7nGWUS0pQ=;
 b=BRM5kBBCTdy3ZGfM0XnLNMfowNljOac3jUSKU+IfKUHeCsDD/UVSlz6ZwlCipOu7f7Mr
 oMguvr2GDAbSx6koIMRbm4V4DEOxmUN58Z7LR9zG/gXzqAV5fqHNEZWZFTxY32ZRwBpRn
 MoxwbOueFa3Enfw5xDxRgCJ98lyGniwE+n3HftyShmIVjyOOEDnI1w9udfiOGGDV8JcNS
 pOPrH16ZyRwGI6wExDHPKmieiuHeCliScqDAg+OJtD0Q8T7qYogamccLFP2+CYoixt0sS
 FlWAXyvAhxb5zwJ54WX8JIYVlt0ovVprpmbvx/4PyQFGkNki0OiqXnVIkgSal+HlLgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=JPQ7obHZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=JPQ7obHZ
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 860138142A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdvWugATRt8dkRbaS/azA/WAFXuNPDqi4UczekKuQ6MAb+q1b11T6IqM5u7cJO2O6ZNVGXDqQMf59/4w4AtHeolPouVW/HLTTTDziT4gsTCUUYRK+1l3n8QK+ZtXEzGkR6xgwSVLC6Ubg6qeP2UAhNOw7SGBWyEsfLSs6udTgv3S6Efy1zMN3AZL1415BQ7BewZX+2dfxWC1UTDfeHiGmuVuD7FpdDb8CVT31GR4drFGmapt3lvHmC2wmy6Woq7ci2Ty1C9ELvkqGNT2GhQivZqyFC0OhEC7MrBEOBNRJTOyjLXQZwd4E6iSAJcWjSPS+aXo3anQMR5r5SroGYDW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH3ac7zNedkOkG4cJWifZo5wUjihPhP1cg7nGWUS0pQ=;
 b=EvYs+SQRQtG9AHdvO0E/umYP0dKNE5igIIL0CQzJCxQQlv9e4CyZgahIkUIOD9hT9jBYsJ4IaDefVTUliU+zBaXVcYk2/mIT/ztSTYcQgcQc1HQzervK5exX82XvVVzvGryxXyHoQ2+n1Nt6+Iy5kUygHtadMsB7olUyFK98BH7EkLEruQ+qYNfGAxTy8aN/B1ljanv5vxK7hfPUq96t20TD2aNjY3oYmRrpeGayj3+LoYDFJ5Swu3QwudykQb9bC+A6MmLhksE8E0Q3pH7OQG8uLjttbf2lm5A879FSpcVxC8bSR0946HrJMd6IPI/BupiYfNc8gPXmBw7hrT+taA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH3ac7zNedkOkG4cJWifZo5wUjihPhP1cg7nGWUS0pQ=;
 b=JPQ7obHZQ9MYtwMY5mzn7I/xb7dJPlQ9r4pkgRT7pQRzkQBLFwqbSoPlFjhmjUOiu34iyIkVjdzLyDB4RJYH+pfXNw9aVUhwNEIXR1jeF7rcrNShGurBUiZFO0HfxYP8PTqVD8qRjmzPB6vM1QkLYxULekTjGaDI5idCC3WVA7c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB619844.eurprd04.prod.outlook.com (2603:10a6:190:54::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 10:25:36 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 10:25:35 +0000
Message-ID: <c2fd7dc9-3549-4ad1-bbf8-5635155e42a8@cherry.de>
Date: Fri, 16 Oct 2026 12:25:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: mkimage: Update init code size limit for
 PX30/RK3326
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <20261004195853.59863-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261004195853.59863-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::23) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB619844:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f97c70b-9c4a-47f2-9f4f-08df2b6fd0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: SdrWp5D5lga6+C7H0QABCdTXe9pIo4C6P3+g4kgm3d2AQZeGgGgEDSpu/8HDMniJtv0OZi4wUle109AUMQYB7b/hp6kR2Fv5aTw6iH09bzQU4gygSRr2rKJ2GDysQqGdiTB8JOuVXHr3nInZpnikk3ZZ4GjaKvdob477ojxp5v7u2UO8sG/83Zq8Wk6cXbjI7Uw5QuO1YnHmx00kjxwMkYM7wm98gfUA9kWM0rAX1KEYxiCX12h62QOThuYMOFQ5BEIlNmq+JFrFYuOyQDA98nA4k8tCtmohVTUm8GI46Gcln1oZvjT0rkZvGtHc/eBJvjsbnufqdHlo+B7mrxQKg3qzMkdAG57iIFsfENwsZiOMmTxebIJR6D5fJ2wKjfEHd6XF8+zJI+WFVaFAvljU3oX/AbUZoDQsJmIzZBmzHNq2FRnHaDsNMW9+yEHQTbNZOeyuGPWwC9iX5+uIi7sgIZUGraD+3ay36tVgOvigfhZgFu/ZD7utd9V1oMh3RfDTfRPE9SNq7XSv8o0257Y6FpsgJ2C4UPffTBJB1/1LoIDXGjz0vwNXYcp1bo1Y5p7Nf1zRH7LHgVeivrlnE8PA7g1D12w4FMkV2iQESQjf2xxiPwQkpriYh9wtI3PaTQO21ziaOwbpxRqyb/wuMjrQ25ZuF7uNLRr5UsmeC+FXv6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pCQVk2QzhUWFV2RXo4aXRkUGVUbUtNemVRMmpxczUwNVF6dHFDRTdialIz?=
 =?utf-8?B?akdhMnA4QzdtT3dSdjg1ZlVjR1BmOS91cFprQzFoWElZbm40ZUN3eGFxZlZY?=
 =?utf-8?B?cGpHYTBFOUZ4RDZRbktaTm1CYWppd0EzT2JydDJBY2VTdDgxY2dpR0l0U3dy?=
 =?utf-8?B?YmlpZ0pyYnMzdVJhQk5TK0l6NS9iczZiUUVHQjhiSW1VMWlPVWMyRjZ4QUly?=
 =?utf-8?B?RFU2RmR2cSt6TVlaNXV0NkhXMkJnRXJ6d0JsZEs0Y0M3eHJuSVlaejdOMU5t?=
 =?utf-8?B?WFV1Qy9wNmZaTzlBOW1QV05zQ2Q3RE5DNklQRlRPT3ZDc1RibStNN2pPMDVH?=
 =?utf-8?B?c2VNbXBRR0VkdTJzN0xRZm10TlJDeXFBUVVPT3o3bWVDQVQrcllKNXY2NEdv?=
 =?utf-8?B?ZFY0QnpkMW42MW9FbERUVWtKQ0E0dnNmUDVJRFlQZU0wNDhWcVdrYk9xQXBG?=
 =?utf-8?B?NlM1elFqbkxuckpRdmJQemxWSmxrSllxRFRWM0h1OWxBQk5ROUxXdVczN1dO?=
 =?utf-8?B?S3YxS3EraGFSV3hMMXpHQWhQVGxLTlQvdHdEV3pVKzhkTG1qazI4L2t0eVRF?=
 =?utf-8?B?VVBsc0JPNXZiTGpwWXlhbGtzajd5YXdsVUdJRFQyeXVsZU82U3dudXRBeWVx?=
 =?utf-8?B?a1dSSjIrRldGUEV1OEUwb2lnM0ZDa3N6WU94Y2FBbi82ZGJZYVZOM2hBcUJX?=
 =?utf-8?B?T2ZnbFZrbWxHT21LRHlaNTc3RUFXVnFNbmhzc2dGZ1JOT3BQNk1yYkZUcGE4?=
 =?utf-8?B?UkNvbWNWbDllNEtYbGpkaEV2a3RNQzNQU2RTOEwrdEpHMlhkTG5WWk1Ib01v?=
 =?utf-8?B?bVE3VlBiRU1venVFS2wyNWRMeUY3MHBrQzFia3NLWGRmNlg0RkovcEViYTZz?=
 =?utf-8?B?YVNGRUl3QlhRNDI2T09wK1RrNEQrd1NCZzB6N3h4c1FLc2hVNktFRHJ0M1Nu?=
 =?utf-8?B?c0xCTStqTlFmMUVWcnk4emsreGFlSkpZd3FHYkhOb1RXekxLbE5kSkZCaHZK?=
 =?utf-8?B?OVBONHpMZUoyUGJueUpMNmNjbmpXWmVIdHp1a1hzandsQzV6RVB3Wklyclk3?=
 =?utf-8?B?RmtnczNvc2dWcWd6bzFWZm5TckpDQ2IzOW9UTm9ZbU40ZUZlMUhFV0d3WmYx?=
 =?utf-8?B?NElob1EwWW42YVZjQXhuc1kxTWhSRlNadUN6amhJM0JWdHE3cVZXZk5MK0ZS?=
 =?utf-8?B?TTN5dXUzSmpYYlBuRjdYaDI3Y1B3TW5nbXVxRUw5MEJwd1RBNG9TcGc1ZHRE?=
 =?utf-8?B?YVRkQWRpN3hlUkh0TnorZzlvYk5mUzdlUVNVRCtZS1JHMTZCdTdBYSthdDdl?=
 =?utf-8?B?bkxmbG0vWURsN2VlVXpGS25wWUovcDFvTW9CVUYxMkR2cUVBcDJ4WU5iS0ZR?=
 =?utf-8?B?ZmZDdk51S2I3bkdmSnBkME5NdVJCQVkwVTdHUC9NUjM4ZVRkTjhQZ1NOd21K?=
 =?utf-8?B?NFh4VGR5MjZPSVQ0TXhmaldjQ3VTTTRkUVdTWS8ra3dIbDBVcXMvb015UmRo?=
 =?utf-8?B?Vi9UWW1VNmZtR2FaeUlSTHFVUFFYNHFIeHJXd2lVbDhFcjFMQS8wdytzVWZm?=
 =?utf-8?B?cW1jdGxqSDRQWlZ0bHJLY2Fpamt0MWd5L0lTdkVsY1BGU2paK3NoK3cxbSti?=
 =?utf-8?B?R013dE96M3pLa2RwbGYyY2hyUlE5SVoyQjBHb2hxa3UyN1czbktFYnJCeUg3?=
 =?utf-8?B?d0RhK2FsNStnNmQrQ0NWVVRWZVptVm9FalJmeHNtV2NKbW1XWmZtbFZ2NDhl?=
 =?utf-8?B?SDlZOFpxUVZhU2pIMWp6SW04alB6Mjc0azV5S3BEcVhnOGE2WnY0RlRNV2dr?=
 =?utf-8?B?aUI0cTcxdXFZKzVuOFFJamJIOEhaYy9Nd3hNUkVPaVhvUUZFTFRVWDk2aDVw?=
 =?utf-8?B?bmxhR3Y0VWcwY29LUngxTWk0anZySEhXQVJTYzJ6RTdoOTc1K3piQlNrVzhG?=
 =?utf-8?B?QktoTnNrTzMzT0h1bEIwN0hIOHZ1dzh4S1JETUVOTC9CZThaZndIdEg1SFJt?=
 =?utf-8?B?Y0xLRkFoSVZRSlppNnhlQzdCbFRWWHN3ZUZ5aXNsbTA1a3VIVXZFMTZsdmdY?=
 =?utf-8?B?a2pZQVVjTCtwOGJuemRTRFcvVTRMRjNkVTlrQ3A1SHZCaHFBcDRQNUkvSkQr?=
 =?utf-8?B?VjllQ2hHN0pyNU90TDcrOTNxeFhuM2VJQkcyQUlmZDJEQk5vZHE0UmlSWEI2?=
 =?utf-8?B?VUJ0NmxnY0wzZ1pmN3VzbGZiNlNOSy9xaVc3dVV1bm4wUWQ3YWFVMytDaE5p?=
 =?utf-8?B?YlAzM1dRb01RbDdnZnJlWnpJOWwxaTdSSFl2QVdzTmRWbzNqWkQ2QlNsck1Y?=
 =?utf-8?B?RmpJcEZEUUVFL2NtbnNWcCtBaU1oS1N0RzA4ODcwQ1gxYndsRlZWZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f97c70b-9c4a-47f2-9f4f-08df2b6fd0f3
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 10:25:35.8415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuBb81aBL4mEoxYp++UlHrgNaHaIWWFALeG2rt9732W/jta7eOw4ADKTDkxumEdZGxEu84taZb64YxZLS2FMHU6ESeaPFDJe5iXdSkAyWkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB619844
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

On 10/4/26 9:58 PM, Jonas Karlman wrote:
> The PX30/RK3326 has 16 KiB SYSTEM SRAM at [0xff0e0000, 0xff0e4000) and
> 8 KiB PMU SRAM at [0xff020000, 0xff022000). With 4 KiB of the initial
> SYSTEM SRAM typically reserved for BootROM during early boot.
> 
> BootROM will load init code of up to 12 KiB (0x3000 bytes) to address
> 0xff0e1000 in SYSTEM SRAM, before jumping to it.
> 
> BootROM of RK3326 typically jumps to init code with following registers:
> 
>    x0: 00000000 00000000
>    x1: 00000000 a000414c
>    x2: 00000000 00000000
>    x3: 00000000 00000000
> 
>    sp: 00000000 ff0e0f50
> 
> mkimage is enforcing a 10 KiB init code size limit for PX30/RK3326.
> However, the BootRAM can load up to 12 KiB of init code.
> > Change the init code size limit to 12 KiB using the <size> - <reserved>
> pattern to closer match the actual limit of BootROM on PX30/RK3326.
> 

This matches the current value in Rockchip's downstream fork, c.f. 
https://github.com/rockchip-linux/u-boot/blob/next-dev/tools/rkcommon.c 
and specifically 
https://github.com/rockchip-linux/u-boot/commit/3bbe0d2f9129303e9f36d3ddfa3485653e188ecd. 
I will add this to the commit log when merging.

Fixes: c6e66b12e4cd ("rockchip: mkimage: add support for px30")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
