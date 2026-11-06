Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC4606D810
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IgR+hHzd;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=gpNBG4g2;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=gpNBG4g2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BD7040947;
	Fri,  6 Nov 2026 18:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FuoqbXA1_G5b; Fri,  6 Nov 2026 18:07:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 563CD40925
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988468;
	b=ho+WLFxo8sOD2JJa26jXBy+g6oUq6aAZPJzmgb2Skf3O061HbIHD31DqEWJglIDWqXGn
	 mEXlk/00K8rsvLXxMlKyuCudBPSLKe0iZ/14p2o2/Mwk6kNVRGSQWCpLE0vk/av/MHmda
	 wyC4x09BZxYGl2+kuWilHfROhvm2Hk0okN4pI2pX24KDWErvn9jKFvCI3fMP3jJGWrA17
	 ztv16w8E7kNTv4jljGkLSNBxBHVDSdDJ7xef0x88WZfha+rmCdqtgETyYTbUAkIbliOAn
	 +kwEheHeUfeFeUkBYqbvqWShQ15F3IzpWApuNe1k8eATwJdQY6wd7wzKSjmJN/q/C4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988468;
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
	bh=151YpJcDYp6CrxUI3eW7CdGwxXroWpgooyufsjI2e6g=;
	b=IsuLWh3JfUgJNYcrSZFekvHqDCNBtJ2oi9ok/x95OOnfDRDxN+52O08rI+o+lshdUlYK
	 /fbmpubOeJAcLPog6j54xWm1LPInyHTPo+MHMO0a0lkQvmy9/fcDZYyJ77WeEiGrMF+cH
	 2C0lTvNZxWO01HG7qNVnlM8LrnvXjJnFZrzIWb1G9dBPkrZLjQ+OjGoU6+Er8kKrqI9Gz
	 nB0yvP510TbHNgdnPigEd3wZbOJTL9s587dhgPhaTKljGKeB56/Cj7BoB2X6HlfLRaXNJ
	 aaQx0pOZKjs09648CTNv04Go4TVhAM6lVC6Vvp7qriq98SzgjzXPCqau+rLfQRCIrUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988468;
	bh=151YpJcDYp6CrxUI3eW7CdGwxXroWpgooyufsjI2e6g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IgR+hHzdl+RblxD7fi7q5o0QEZhLmUpUklgwY1WPPhVgb99O0Qu2ij9wyZ1cLXaT/
	 q7Gsy2aVw+/YoqeZMMG2fdPrjCfjffs/j4obGjoX/CtU49kYXinXe56dPujPJueJgD
	 313vhY4H/tcJfbnUwH+7LpT6zu/it7saXIAhpxBOEJiCKHlWCaDsmToiz7RwNFg/ML
	 IT6PlnQ9PtXl2EZRuKd47x7C7ZLLTNRskBj6A7vuNkeJ86ss720tzmFflQzTFvolzF
	 dZqBEGYL46XoE4k2Hne7wt7TBWc14k//kxFWLnk8uUT//9sYQVzugwY0+is+gCy0O8
	 oMYNaR1ciXUIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 563CD40925;
	Fri,  6 Nov 2026 18:07:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EC4B2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E99EF403D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tukQ141PwLJc for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A789401EC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=gpNBG4g2; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=gpNBG4g2
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A789401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=151YpJcDYp6CrxUI3eW7CdGwxXroWpgooyufsjI2e6g=;
 b=gpNBG4g250QbzmA4WVgNnwmxpnrvhoaRPawjUMoTyPTzOKQ31tXotyqxq8MhrOSRz3S8wmZqclWuYOsu4XRIMKjfCy8N++TV9O+GV/pUpE/5FseVmqmtLH4naPP99FTLWqoCp7PdoJjmS2gw7RUXzDBz2fJGi/Qzy9jYeKpe70o=
Received: from AM0PR02CA0126.eurprd02.prod.outlook.com (2603:10a6:20b:28c::23)
 by MMZPR08MB611009.eurprd08.prod.outlook.com (2603:10a6:190:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:38 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c:cafe::57) by AM0PR02CA0126.outlook.office365.com
 (2603:10a6:20b:28c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:07:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=151YpJcDYp6CrxUI3eW7CdGwxXroWpgooyufsjI2e6g=;
 b=gpNBG4g250QbzmA4WVgNnwmxpnrvhoaRPawjUMoTyPTzOKQ31tXotyqxq8MhrOSRz3S8wmZqclWuYOsu4XRIMKjfCy8N++TV9O+GV/pUpE/5FseVmqmtLH4naPP99FTLWqoCp7PdoJjmS2gw7RUXzDBz2fJGi/Qzy9jYeKpe70o=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB241936.eurprd08.prod.outlook.com
 (2603:10a6:250:104::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:05 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:07:05 +0000
Message-ID: <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
Date: Fri, 6 Nov 2026 19:07:05 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
To: iav@iav.lv
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 nd@arm.com
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
Content-Language: en-US
In-Reply-To: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB241936:EE_|DB1PEPF000509F9:EE_|MMZPR08MB611009:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b5dcfc-9860-4cd2-d60e-08df3c30d758
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|260925021311599003|260925021911599003|260925022911599003|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261022115727099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: GlnSw15D7fJ4t6/YkfYr1nNrsDb3ov0V+RyBRXRtIL7cwb8p4p87hMVVJ/6IWJMos/LUEbb7QnEIPoj06QGePqYEiwMLpALOfKjmghh2NiStz7dpy+UJZkVAq5Cy7BwHk3vuXmd3l3VIZS5A/XImU6RkZ8Tf0IL3F8dBcnzv39ueSRfQiWO2RnI+gPIK4Lnhbf5fokfQ1E3KJhUFsI9aC35Rn+ohFduhEk4U3BZ19to1tUX4tNHjs9NE/PmGNn4Dp+8OH4l6efTCASLi2qJfS6OonA82+YT8zZhS1Z7OmUF4dCEOOPlP6gDj9WWSY3fbcXav4Ulr0WRNop+dBPEjRd9H+G+42/plhYIZzp5n3K7O4pNd7y71cIWw08KOcJS+DNyNJTbwId9wOkh9PzVmbgnXyBKG6nqvMrio1nUN5WGF+vJ83ZvuFMzMSBbNT9BsMgslsRpRmlEi17ifbjKXp9FBji73ax0xmOz4TEDb6eAHmNqmWoJXz/xeyrNOscijAuknpq7GLv6yufmVEkYcYbrPf7WScLYgQWhzG21sh0irFRtc2O81kbT+UsSdf3FvwD+OL+hCtB45X636460RqO/f3YrY+hWLUTrilzsVT+k=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(260925021311599003)(260925021911599003)(260925022911599003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022115727099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: JewNwLKqWKPUTppfu4x/SMqiokClu/FtA7Df/pkB0dXUBvGReh+DonQLGsH7wIQRbV4F+84J6KK30z/l0q+gP3TdOyGvG5k5r7pA2hn5PBhUdknp+wca743bhIUfzX5oOHKyQLhBNd7UXw97sLYc/IXbsaQ1EDM9fVtlVxHVqvPTt/hRjkX8O+5CnnG2eBxihwygVA55sOALG9wuPjsl6bLYMFHTtp0W/ldF1z8yLx6rx5DSyB0KUYX3BE55OlNOcyHiUNUR/trx4MvFBEe1f+uYbDzr1XveMH7GbaQKfUkDqFLLwguBnuVHTkYl9Qq8Tfbq/tYXswd6tGfNgfgDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB241936
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d53648fd-f670-472c-02cd-08df3c30c40f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|14060799003|35042699022|13003099007|56012099006|5023799004|11063799006|260925022911599003|260925021311599003|260925021911599003|261009223027099003|261102123227099003|261022115727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xI0gzqPFz5dybe1gL4WkSj15Ak7iTE/58goYg2pa7iVcbuWOWwa4foCIpPY6VQtvdDY37JLrsTTNq1RPpVF5zcYjQ58CzIZ/aBsMhml/gxCXUp/BH1P1f4mvQvDjpedGu8FIAiG/guwapINuF1gXBmVhZrF9foPMj5LScbp41CUY3gNpLydcxC9nrVdIZEwFDqel7sbnBDxrl66ZpF0xVAbCTPe/0Bvn0v9vCcSYrXesSEd0yTRymoCuCXye/PqME19RIvTFaqhPJYOR+BSLxdbv7aHopcdVcDo9f25DedxANAbmj/T9sJx5I+/LMZgq1Jwh0V8yDIQ7ADlTGpIYW9RwNLHqsM2pCTgG0XUQmAg/UEK+9QT0L4lSQbWP3zPWMa/a8bU/y4xb86TBzMIkA527/geNv38W4fkpN0HBeUyIU2HfJQFGGW+45zoNLd7J2reA+vgZLxBoS690+W2EIHXY1KjSmfZLmjHdHwTeleZaAkbdjs91VWSAjvEDcjzd83cKF8bvQFMjI2HMK8TCusOOspw5koXglfW/hd7W+bcdlQplq+BXMyJ1vBLx+74deIluBsuaaXexsPV0pRXhGlqFBGT85Goqm+JGThG9Kv1g9Iuwq4PqJrq6+okoOQ9rPiw+Zwz7O9qbB8mCJHNhpg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(14060799003)(35042699022)(13003099007)(56012099006)(5023799004)(11063799006)(260925022911599003)(260925021311599003)(260925021911599003)(261009223027099003)(261102123227099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cYbECy6BQKRIdPaIkoSUbnSUmX5fqdzF+IdyBRkaEq/459qqcI/eGBfzbCBjnYoM1wkUx51fDE8v+XIa0RR7DkGtM8FJmTv8EH8eh71wsblvKNQUsgOPP2w+hEvpJhe18uesVt0Bpc+8RGTMrb+q0IGspfioouSTxI48g2sWT6mtvTzcryE+5oEUj8/SNo054JA1GzHJoV5GFe2x2JBo1Xsf+55F3Qx3W+MicYts/n0R7RyAH/VFXja5rhFqHyKrDrY70lDP6IHjLnkyr13RpDthcfg4d4NdMNK9qrQEho8Br29RVsOCW0fuD0xfaBz+2Us6zLzcmbJ6aa5hccGirdEJtl8OadqifMtqXwxad2jC3IUEVqMn5qDrFA6x/7a06h1t8SeFNhX76uZ8Nb/7UskOlJs69aFjxhPnkwounxV36MZkHJIsXJk2MjKq++n7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:07:37.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b5dcfc-9860-4cd2-d60e-08df3c30d758
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB611009
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SPF_PASS,T_SPF_HELO_TEMPERROR,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> wget can write a disk image only after the whole file is in RAM. This
> series lets lwIP wget write the download to a block device while it
> arrives:
>
>   => wget -o mmc 1 -b 400000 http://192.168.1.65/armbian.img
>
> The target is a whole device, a hardware partition, a partition by
> number or name, and an optional byte offset into it.
>
> Patch 1 fixes the buffer size check for a reply without Content-Length;
> patch 4 sets that check to the target size, and without the fix such a
> reply would be refused. Patch 2 lets a wget client take the data
> through a callback, patch 3 adds the block device writer, and patch 4
> adds the options to the command.
>
> Tested:
> - ROCK Pi 4A: a 1862270976-byte image to the SD card in 3 min 16 s to
>   3 min 35 s with a 4 MiB buffer; the first 1862270976 bytes of the
>   card have the sha256 of the image, and the card boots. A
>   2936012800-byte image, past the Content-Length limit below, took
>   4 min 18 s and checks and boots the same way.
> - QEMU arm64, virtio-blk: a 404 writes nothing; a file larger than the
>   target is refused before any write with Content-Length, and at the
>   end of the target without it.
> - sandbox: ut lib lib_test_sink_blk; every patch builds on sandbox and
>   sandbox64_lwip.
>
> Notes:
> - lwIP's http_client.c reads Content-Length through an int, so from
>   2 GiB on the length is unknown and a file that does not fit fails
>   only at the end of the target.
> - EFI HTTP, the other user of check_buffer_size, retries with the
>   reported length when it exceeds the buffer (efi_net.c:1715), so a
>   reply without Content-Length still ends in a 4 GiB allocation there;
>   patch 1 does not change that.
> - checkpatch asks for IS_ENABLED() at "#if defined(CONFIG_WGET_STREAM)"
>   in cmd/lwip/wget.c; that #if picks lines of the help string, as the
>   WGET_CACERT ones next to it do.
>
> gzip and zstd input follow in a separate series on top of this one.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Igor Velkov (4):
>       net: lwip: wget: accept a reply without Content-Length in the size check
>       net: lwip: wget: hand the payload to an optional sink
>       lib: add a stream sink for block devices
>       cmd: lwip: wget: write the download to a block device
>
>  cmd/Kconfig                      |   9 ++
>  cmd/lwip/wget.c                  | 107 +++++++++++++++++++++-
>  configs/sandbox64_lwip_defconfig |   1 +
>  configs/sandbox_defconfig        |   1 +
>  doc/usage/cmd/wget.rst           |  43 ++++++++-
>  include/net-common.h             |   6 ++
>  include/stream_sink.h            |  75 ++++++++++++++++
>  lib/Kconfig                      |   8 ++
>  lib/Makefile                     |   1 +
>  lib/stream_sink.c                | 189 +++++++++++++++++++++++++++++++++++++++
>  net/lwip/wget.c                  |  89 +++++++++++++++---
>  test/lib/Makefile                |   3 +
>  test/lib/stream_sink.c           | 137 ++++++++++++++++++++++++++++
>  13 files changed, 655 insertions(+), 14 deletions(-)
> ---
> base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
> change-id: 20261101-b4-wget-blk-r4-833f8a3d344e
>
> Best regards,

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/4] net: lwip: wget: accept a reply without Content-Length in the size check
      commit: 8498fbf8788eff07bc7fc59f9b15cf6c65025b10

[2/4] net: lwip: wget: hand the payload to an optional sink
      commit: 40611fe0277a7a8f9639aab02a6f1a1e0e897d57

[3/4] lib: add a stream sink for block devices
      commit: fdf4d9621c8b507f69fe0dd09fc53ebfe860fda5

[4/4] cmd: lwip: wget: write the download to a block device
      commit: f0870bb385cf923bfab0baddacc952151efa4c39

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
