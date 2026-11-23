Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F1606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sFrASNd5;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Jf6GG3Tr;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Jf6GG3Tr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81CF580D48;
	Mon, 23 Nov 2026 13:23:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFb4aMS23Q62; Mon, 23 Nov 2026 13:23:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2A1E80D52
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795440230;
	b=agaUW7IJmv6uqwt71qYpa4MwTW8qAHUYCFObU4lknpdwYzb/AZyQq5NNCPaC+O157vyG
	 9voGHC+z/Ljb+jd89PJteYIAckYms4ig/V7Ws6qPYdO8JVB74ldEWkUTtJ6DA/arZsVj2
	 eKDedZGz3wpMEo48V5BP+IqMjUOLKicc5ntRElW0ZHYCh65BJ9l5WhbHr5T9y5HcNFU20
	 IYBpyWGLwka1XMaY8stSvhuq6vJbL+1EC76CF77VptiUP6fPPho6H7Ih0EbNDY+mOqciR
	 ahCtUAZjURC7vxIx059XJZ8nxbEl/HuOwC32gMZDIG6RLUA6jOVw9k4C8+YgaZPhr+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xow2wP8xClXW+UhB3IFnaYRUrS5S8b5Kaud4zcegF7g=;
	b=PJTLfZDRk3tY5SycaOXc092FqREO8lBRs40a7RkLwuzKvyWS5cf2Rd19qyb+e4AEMkw+
	 omNhz2yq2BOGAmFCBNVHHH/hMS/v3rWR4ESdnHBjb969go6t4jfN0Kde31pUfDy5zmxZp
	 0IdFfBHxXRO8XUHePekTL5k6UK0NbrPrmC4weZa9Xv/sLf6IkfEPcgUcMHiCLokvorj22
	 d0gz46yiGLgG8DhI0L8xCRyDXvHLabPxJ2CFnR89liQPr1Cy9a+zNS/u0mWW3HMrM08Do
	 GBWw3a1SZxQCtLzFV6b5xpjS/QnHANTvZdigiJIhiJbN6Sqsp/SQvbdbY7jj+r9c1ng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795440230;
	bh=Xow2wP8xClXW+UhB3IFnaYRUrS5S8b5Kaud4zcegF7g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFrASNd5lU1U560CqoAsi8A38z681JtfxLuivDQ+GAzFZWNk82/h7X7Ex0u6Kfpyu
	 33aw5PEQllrZvOvbFPMSindV8X970shJUUvTlFCj46NLM6gLx4aN0+pDBXce8E97ke
	 RiarwHuqRY/oB6VZnYUyB4Twmuxa7K9j0EcE0uH304/2eWm9VY6MaqKZi5clsGsgjG
	 HCP78wg2VWxJVN4mGH0kH7lGnfnKCMppX9JgiuHAmVMqsKHrVBiIV91EpCC12cGmvY
	 ZD+FUqJ4sWOrR1QYHPWMnGhXcQCOV2RQXfJxSH/69oTg7lT8tgRu2QYFFtRPxm6hGf
	 rpDVVy+m737tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2A1E80D52;
	Mon, 23 Nov 2026 13:23:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 27FC7759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A17A40718
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yCgF6m8UlnoY for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:23:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A620340712
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Jf6GG3Tr; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Jf6GG3Tr
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A620340712
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xow2wP8xClXW+UhB3IFnaYRUrS5S8b5Kaud4zcegF7g=;
 b=Jf6GG3TridRcTvPx01e0af3sGtz0H/G9zA9ENhpByzBx/QXOy5OZUsUvYFj/KvzExA1cbop1G5UOdhMVEUV5EpQoowoKsqsJZdhSFMpl6d8yIwXpz5CNsUf9aVEPhR5f9YCeit1IP4m6FvFyXVGm9yYyg0Na1M5DSeuDn1C3zoc=
Received: from AS4PR10CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::20)
 by DB9PR08MB11242.eurprd08.prod.outlook.com (2603:10a6:10:5de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 13:23:35 +0000
Received: from AMS1EPF00000093.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::ac) by AS4PR10CA0026.outlook.office365.com
 (2603:10a6:20b:5d8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 13:23:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000093.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 13:23:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xow2wP8xClXW+UhB3IFnaYRUrS5S8b5Kaud4zcegF7g=;
 b=Jf6GG3TridRcTvPx01e0af3sGtz0H/G9zA9ENhpByzBx/QXOy5OZUsUvYFj/KvzExA1cbop1G5UOdhMVEUV5EpQoowoKsqsJZdhSFMpl6d8yIwXpz5CNsUf9aVEPhR5f9YCeit1IP4m6FvFyXVGm9yYyg0Na1M5DSeuDn1C3zoc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DBBPR08MB10461.eurprd08.prod.outlook.com
 (2603:10a6:10:535::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:23:02 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:23:01 +0000
Message-ID: <131a7cc0-6a08-4c83-b134-c3e9549e87aa@arm.com>
Date: Mon, 23 Nov 2026 14:23:00 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 0/3] net: lwip: add wake-on-LAN command support
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, Simon Glass
 <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Mingtian Li <limingtian@email.szu.edu.cn>, nd@arm.com
References: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
Content-Language: en-US
In-Reply-To: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DBBPR08MB10461:EE_|AMS1EPF00000093:EE_|DB9PR08MB11242:EE_
X-MS-Office365-Filtering-Correlation-Id: 602d8dbb-5ad7-46d7-51fd-08df4964f9d2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|261009223027099003|22082099003|18002099003|261021123027099003|261021121427099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261028144727099003|56012099006|10067099003|261102130727099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: BQrk8HVblTBGZzjWBkNhow7Zzf2k5Jz6LRJZ6sCm87PtB+ozXigzqljkG3UPWG4wr6xGT7AC2zPy8HjbrqnsPiid+aYxoisng1SJiVPFtRq+H8dAjRb4hcrzFUitWtbLxyTKbp+wKJSmZSPAtHXJ3MjJ1etXz31pFtlcqZLtNIXDGLL16G+xWmERg/S0bF6lTekwatJV5PAPFdJQV5HolcRlqldnuBdw+qXwkpnz9fMdBn4GRcnK+73veQ1Q97dzB/tGuEB6OdMnBcRXFHjzRG4OCaxSJZpoyynAsrgPV7CrFhusqhH4zcMdZwv8qwpjsDTeBD3WQvZATB5fgymw329cMX/+SAKb0Dn+0Gpxtz5+Q8KBCn/JUXW/FwC3refe8/jo9ZkkgO9GGcVgbB55FEah9nG+QFBaiE0eDkOwmPzr5QgOtRJidGsF7AorsO6uAexcfgmEY5yCh0Wr7ooy97rt5yT/t5j5OO7khgLSu+DXkRIjk+QwzuZQvlr1vw21bp9jFBFkU0WmL0MnQ4enrvc40Hs4Vws5CyzWfOsBw6lXzo51x3XE1hYkc1q4KgnWkVxUBniw4u7bP53Vknd99DJkj2qvwqNJmGqs3vdASst7tg7+0KReiDV63JSOPg9j
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(261009223027099003)(22082099003)(18002099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(261102130727099003)(261102123227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Ry8GUGiD12FUnWiWjw3PHyyK8kZM0fxkc2x/Yd1+OqBrU5XEJQqzrnHDGb3duHULzeDhusGvsjKuVsmPKU/LHoFhTeYiecNn8xHSiMyRKiZdE8ycNVXDp50pc+4x9p7omXpnFNkWehBFxbzWMxwHi/NrsvJq5309tWlUuCpIFlskYfXyfNrTl5GGliMjIBN2rpoVP/3D/KusYCMALoRT/98ZUcbOAu+hbAun2H4gSVOBs21Fi6/S4fj5zJw83qVXirCfJE4GKdD0bxpJPSq89XDZeQRqnJvF9kVa8v4GOP/bVC53Sz/Yc37I3KOkES3gWJ/GCn0VlnmTerWzsCKsPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10461
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000093.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bda8b082-09b4-49e9-ae98-08df4964e5ef
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|7416014|36860700016|14060799003|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261022115727099003|261102130727099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cWFh2N3ALetRZTSk+QyE7sUXGPWfceza8jTOKt5Z1EkiZLsZL7DfCLosQwTh+4Dc3RTFIMZxcsTJq/MsKDp84MvdlfNPxSYHYUkHilHO4UWUrG3r5erwj1Z9SkAP0mYWQe8jvoTGSdFhCufGdSHTLZtnY8xRw/RBpeHHGD5R6JHccBwDSnKjvjqsqzChLE+0hp+gjEx2b6jEgqOLzjYsgzi2o3MxgbMPs7nV0VXyI6LhhJMQji/vDXsyN00H1t9pHUTG52DaQR/U+ziewHlbr+KLAgynfn1WEyXnJ7wlKP7uXOobdsg88AW0RmMNK86XhE1b5G5fyUK3MsDk/QVlsxLklvL5x7YbawHnjLISTuzj7IEDYtF4wOBTobfVd6OlvPNwVo4cCQJi+xA8g1BbCXVQOdHVH97QEzz0bKOHnBDSvH757tul+BoBFYYWNELAdpwll5QbOFNkPgYal0qkJUOzZ4lu1Mi+D1BSyK52fO0aEgKnOTsCuRL/5CshPjnJe6rXaYZtYRlEBAlt7Y7panvi6aYOREiWx3Bt0Z3QTnJKhtdn8dFy6sUJdxwkL1g2yWPXlcBmCgrSusq+jfB9xck/SVKgDxXvNpo8gXYvFXFf8aqrwxJSk99Fa0LxeLUHx6tAouGUC49stLEEAqChqvyuLxbWzuCM3uLXM3sJ9b0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(7416014)(36860700016)(14060799003)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261022115727099003)(261102130727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oxko/DvSbjUSThjiJ1LslQyv0WhCMdtgUoAKNRW2w4fH5295BMA2fH+ZDKuUVqApWRFj7JQrJ7thUEkaY7NBOnNUuXs5HNdCDGGVlF1fW5/PnTdAjMWsBtfUpN0sMfUoMfprWXGnH68Fp0Z71fPqFT3/6y9srDExkbTy7AjajnjaFeGGA3Wh4RIt6NCX1bs64LJIbnVrL99CXRncXnCz4adajCXgJQXXh9Ov63LxLLdoHu3zfiKWg0IQbZhL8wgXVgxTpOMHCRpGWj6pBRyllnaGbloa+cgn1p/PNNyOusujsZ9AvKvgBHelZAZKwjVtkoI1r5FeOfmjznjkKierhiZi8HX7SYkviKdVCdJo5eGj5XV+Gq0PJD+Q9rFRK6HG3sGcdb9myPgeGNoT3g2fFDtHiJhJzkTeWhHCBFoGsS72FeXjuo8z94duAD2paO5W
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:23:34.5826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602d8dbb-5ad7-46d7-51fd-08df4964f9d2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000093.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11242
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Make the existing wol command available with lwIP. It waits for an
> Ethernet magic packet or an unfragmented IPv4 UDP magic packet on port
> 0, 7 or 9, including when the interface has no configured IP address.
>
> Share magic-packet validation and Ethernet password export with the
> legacy stack. The lwIP listener uses the shared network runtime and
> leaves other clients active when the wait completes or is cancelled.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> James Hilliard (3):
>       net: wol: share magic-packet validation between network stacks
>       net: lwip: support the wol command
>       test: net: exercise lwIP wake-on-LAN reception
>
>  cmd/Kconfig                |  11 +-
>  cmd/wol.c                  |  20 +--
>  {net => include/net}/wol.h |  27 ++--
>  net/Makefile               |   1 +
>  net/lwip/Makefile          |   1 +
>  net/lwip/net-lwip.c        |   4 +
>  net/lwip/wol.c             | 129 +++++++++++++++++++
>  net/net.c                  |   2 +-
>  net/wol-common.c           |  46 +++++++
>  net/wol.c                  |  51 ++------
>  test/dm/Makefile           |   4 +
>  test/dm/lwip_wol.c         | 301 +++++++++++++++++++++++++++++++++++++++++++++
>  test/dm/wol.c              |  91 ++++++++++++++
>  13 files changed, 618 insertions(+), 70 deletions(-)
> ---
> base-commit: 1ed1749575f28b406c241218eb6a200574574a25
> change-id: 20260928-submit-lwip-wol-v1-2deb541b7456
>
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

Applied to u-boot-net branch for-next [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-next

[1/3] net: wol: share magic-packet validation between network stacks
      commit: 35e6dac3cc546fb27aa8d29c6454a815636e49ae

[2/3] net: lwip: support the wol command
      commit: b9189ba6ea9cb320b4c60bf8f16b7a3e059c9a26

[3/3] test: net: exercise lwIP wake-on-LAN reception
      commit: ae80d30f747f03c04210428052371fbfacafc8ce

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
