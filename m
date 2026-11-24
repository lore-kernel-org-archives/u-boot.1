Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE9606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MbEY/lnm;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FwLmAe+b;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FwLmAe+b
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F30E040500;
	Tue, 24 Nov 2026 08:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z88Hua4aDnhs; Tue, 24 Nov 2026 08:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 59C64405A9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795509580;
	b=M8VQjdp6H+0KzCoYx5wClhRuUFhEneJm6HjsGlb9daPL3xYFRwBGVD33z9YnV8cpz/Zj
	 Ock75Ss9UK+WGg9IIpnjn6UmSko6GWfhVd7vwpb24T6NmDIt/ocjTZyWnll/Ife7L2lTS
	 W9pH2rRqAmWkOqwuUlraAAiORBNYNOHdmy+jVJUsbwDIVzeX5hREg0HKWWW+MD4ropxkN
	 vHZd/LPZ3duyanLf7vXdCB7bcyD27H5Rk3/pJZg6ycUXw9lt6Vp5pYOf9n3zWGKJD0hiC
	 s0IpZ4GBeVjLgmwvRquNOScNWYvim3Z38gdBPeM/70Uoo/fUxwjlmFg9MpwMzJ4oS3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795509580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 Content-Language:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
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
	bh=VGBkoKUxFyI8LP4CYTnOgUdVu+nFMAPlad1gaDq2Ft4=;
	b=kjruRkpTLW3+gKdlrqSyoeo7WIOEK6BeVszXJBMwdoAjQ7joK7bDTdNKyzdpic84HVyW
	 ovXJNtXvnxPRTgCATNjvLaixSB/foHBU6vVS8wNwPss+76wc1TXbioyRDYTyNh55j3Jfd
	 t5qAn5q+2sYlKGPr/9re5sHRwG9u0bVXiNbWafSmvfraf+YpU26TiumrF+cCe2HcaKqRT
	 bDXpGQ2ig/1A3hgig5vs/6sk34qOlTbQBBkffnS+S4DqeUpXnKPfsyvg1FpJMF4Ig54DM
	 AOCnJnspERsyH+108H5saZI1X0oaA8vPZFeFnR5SBGjUOxYQIQHZbXkLLIYzQKsCOuQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795509580;
	bh=VGBkoKUxFyI8LP4CYTnOgUdVu+nFMAPlad1gaDq2Ft4=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MbEY/lnm6WOlPSyXJKyfUdUNUoRPthxMkLVDe3BkwAP41J8k0n+eEVkZvLnpfm0aT
	 fDmvGfDG1wSl3wBK6PWsQHmLG2qukOuX8mIcMrEkTYkShIQZxt8+AHK138340nWZcc
	 qPqYs2YuF8/GUxNttbtrDEq7oeiCqJtetrwxRn61Wev8fmD7BxnhVt0lQLG+12Vlgt
	 7C6no/e6rjFtECxFo0D5HWG0M0EyE+5b6U/nUCBxk1LZxkOTPNLyeZhFR9t0AMcyfT
	 2ixSKPSkNJ0MN4BQBz+mJpxbrCWF+bLQQ7cYDli8TcfXYHzapKB3y2PhvwCdCYfChv
	 ASWWZCkJOx1ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59C64405A9;
	Tue, 24 Nov 2026 08:39:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18AA33A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09F32400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ROXA6JFy1duI for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:39:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C7DF540068
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
 header.a=rsa-sha256 header.s=selector1 header.b=FwLmAe+b; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=FwLmAe+b
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7DF540068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGBkoKUxFyI8LP4CYTnOgUdVu+nFMAPlad1gaDq2Ft4=;
 b=FwLmAe+bsEwznV8K/ETuoNChmcAku5yLpJrUt+VF1R9REPSntSnXud4tgnUBOWxFbXTEs8ixU6xgY4AHI1VjBmprObWgbWehHW1f1OGIyzB9PNqr82ei4Rhsdpd+7BBZFFN28wMr1Gaf0rOymgn1m5DjUlBPwjSChgAl3ciO5ew=
Received: from PR3P189CA0086.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::31)
 by WA4PR08MB178339.eurprd08.prod.outlook.com (2603:10a6:1d0:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:39:25 +0000
Received: from MI3PEPF00008491.eurprd03.prod.outlook.com
 (2603:10a6:102:b4:cafe::96) by PR3P189CA0086.outlook.office365.com
 (2603:10a6:102:b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 08:39:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008491.mail.protection.outlook.com (10.167.240.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 08:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGBkoKUxFyI8LP4CYTnOgUdVu+nFMAPlad1gaDq2Ft4=;
 b=FwLmAe+bsEwznV8K/ETuoNChmcAku5yLpJrUt+VF1R9REPSntSnXud4tgnUBOWxFbXTEs8ixU6xgY4AHI1VjBmprObWgbWehHW1f1OGIyzB9PNqr82ei4Rhsdpd+7BBZFFN28wMr1Gaf0rOymgn1m5DjUlBPwjSChgAl3ciO5ew=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by BESPR08MB999873.eurprd08.prod.outlook.com
 (2603:10a6:b10:146::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:37:40 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:37:40 +0000
Message-ID: <d0f3436a-f97b-4ed4-a53a-4263dd3fb1b8@arm.com>
Date: Tue, 24 Nov 2026 09:37:39 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-next-20261123
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0022.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|BESPR08MB999873:EE_|MI3PEPF00008491:EE_|WA4PR08MB178339:EE_
X-MS-Office365-Filtering-Correlation-Id: 53256da1-cc1f-4419-ad08-08df4a067195
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|6133799003|56012099006|11063799006|261021133027099003|261102123227099003|261028144727099003|261009223027099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261021135927099003|261021130227099003|261026135527099003|261022115727099003|261026130827099003|261022113327099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: ZASV9AcGuSUOPEsLOsQ5jCSgiC9E765x28gS3zIUmiCQYhyR+RhBXQ8+7deSDiJYAw7bbiKriV3GNPBzYriy4qgP++CG+8S9EReEpi039PiTUsG0zqkmvxcj1rO7eYYcB7Bl4ru+JSFymmg4NrWZpEbVDPGZItiAhudulvtxsU5R7bgDX/rGIF/dT6NgU5kABq11D9Mb4nee33q4sYb11CGnYsS7VncQjH/oGnrmktr2sxsbTZuWCcD0QUU7NE24QyY4Ie2NlRuPBrDdYwnD00Sd0GbdOM5gdEutZo2Nn0YQ4xVjiFfN+XQnDiiCycCQmFQXnTv9lrsEgnlRcJ0JUdPKynESKA3suzOH6aZzPMx5k+NQuegZhDwnqFwczR389n8I9upga1MKikUXHBLG4e+QhOIXWlRjV7dEEaGG0hHH6oTSEuKvsD6jpdfecKH4w/HzGnWHpV8CBxEVRqP/coQ8auMUiRXps0vVQzrNE66QngWDArYslYBxw9wVOtCUYzjRljWWpV+3f5RYpZGOi3/fVI2v+3YM2ga0Fxl1yV+RmpvTil3MUXS4NnziHZx/XZAKpeW4SToLtxRS1SkiyZPEL+uzi9u8QBYEEgWdW84ckkUAfnLXQlFKudfRtWes
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(56012099006)(11063799006)(261021133027099003)(261102123227099003)(261028144727099003)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021135927099003)(261021130227099003)(261026135527099003)(261022115727099003)(261026130827099003)(261022113327099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Lk/cjzRryBm+tg4Lhz0RcidAKiTJc9KaIZEo0xXjtnEddQ4RFrqTQBYQQYdbceMN3OlCHeWIuFCkCMSzgIqRz0fnoUmUQkh59ZSgVFwDkicgZPQATcAHOj+WuSu3eyox4Dtds+owS3xdhcbIXDovrNS7EYaY07pJRuzjNF++A2ZVjlOACaQxD/oijVK01Hk849weO+KPTZBCEUj2lN43M1EHMaC/FINSlC3BOWiv/2MsjuXuDhsOWNM4GusfSlQr72Fq7TPawmTqbXDzr/b15w4O+MR4MCnsMIPEjo775RDpkzX6Ed9NZ6WwmIxYXcuqiRvckux/UpGUFd++f5hplw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR08MB999873
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 525ce127-eb39-4a19-aa2a-08df4a06333a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|35042699022|1800799024|36860700016|14060799003|23010399003|6133799003|18002099003|13003099007|261009223027099003|56012099006|261028144727099003|11063799006|261021121427099003|261026140227099003|261026121527099003|261022115727099003|261026135527099003|261102123227099003|261021130227099003|261021133027099003|261021123027099003|261021135927099003|261022113327099003|261022105027099003|261022075727099003|261026130827099003|10067099003;
X-Microsoft-Antispam-Message-Info: G96COdy6JbdUrblHMlkq1X57W0iexEI7r7DSlCIEW53F4q2bAFQWevqei2kQzt602QJj3/iOP/TM+PMg+lN5i9e4npwjX6KtLrf+Gg+WpAdctoHPTIlPY/2OrpL/cRD4XLThWGZHRnUoVQjdAmwfyVAHtH6dkyMFYFUCE1HnNYHAUjdd8A5Y84gXy8l6bCxzGlfiN3LpSZnryMGy63NqJKV9NSN2dul9lljNxSD3vXL1pvZgOUzN5FbcTSoMl8XXtsxVLBWuIBN+uLBe5y6b0VJ+FAxThXF5b1bGt9+OJBdG1EcJ6x1iRnfeGwZ/QYeHP4tkxdslnGXVsU5ArhmtMF45Qp3ZXDdLfixqkZO6Ku8tpLF78mrhme7p/4eR6GYWgI4O59m+ZBIR7KDErVESJtWM72KbDnNyCKqyg6rsuDLe+oI6RYIPMlVM1apOh9aoojarg9pM3EgI5OGgQTOg+SNSGdlrRRgZaf0r03CjjqxqQ1EZZDcw5E9sgQlZ2tNRqRAbAYndPzOZVVrby80YtfZsXlvLYbud+SRpxHQlh0g0LiFjjcy5GF2FLP0oyPGB+a7ro210UKImiz64nT4mel0ok2KdHcQiYZ5iwQMHrMSFo7BQraW9wXyXzPRmGS0GpBpMmV8+nhd3ydLuJ4uqgOnXmEupbzU1lCJCMoFDtwc=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(35042699022)(1800799024)(36860700016)(14060799003)(23010399003)(6133799003)(18002099003)(13003099007)(261009223027099003)(56012099006)(261028144727099003)(11063799006)(261021121427099003)(261026140227099003)(261026121527099003)(261022115727099003)(261026135527099003)(261102123227099003)(261021130227099003)(261021133027099003)(261021123027099003)(261021135927099003)(261022113327099003)(261022105027099003)(261022075727099003)(261026130827099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zdZLtpJbDVkr3h1O9yF4k49wSG4aBFEZ5CbkGbymUZO0HgvmCb7c/fjIiCYDUAMJTdzBSl2eUw7e5BhP7Lsf8g7RPm+FSambz17YI6nXCB62++oigEZ6A71djyiKCt0kPZIQzuQyAM9lxu7WESBUeKxIXBwP+49oYthkDEN11+Mkp/DWJdIiUsGsH8u0UQC5MGEWRRCHCnxmdHRKp1snqmuZoGSL9rg1hSDaMuGg1nOAJ+DlBZUVErm5+Ej5GsLbFgS+gqgStYPDQcEFuiwxVCu643+LkNi7wc9uMHCPCt1ard/Sf6dG7VLnfNnCLHwUcdPKikt4qwqMMkkAue2dmwYlEvgvruaiNE9NIaxup3hc1luhgpiWcL+YCNCjLaeOZdO+szIj9byHLD4S+RJnqEApAg4XX61FpSguuZw8pKUke9m9WqZmGuan3fEL+Dzb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:39:24.4372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53256da1-cc1f-4419-ad08-08df4a067195
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR08MB178339
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
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit d22f61a39fb68bc697e67df45f2e3103378bc7cd:

  Merge patch series "Prepare devicetrees from FIT configurations with fdt fit" (2026-11-20 11:47:13 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-next-20261123

for you to fetch changes up to d778970a189b977c14f93961d7009f404d895b5b:

  test: net: exercise lwIP DHCPv6 lease and boot lifecycles (2026-11-23 16:39:33 +0100)

----------------------------------------------------------------
Pull request net-next-20261123.

net-common:
- net: ksz9477: Constify driver ops

net-lwip:
- net: lwip: add wake-on-LAN command support (3 patches)
- net: lwip: enable IPv6 networking and boot clients (19 patches)

----------------------------------------------------------------
James Hilliard (22):
      net: wol: share magic-packet validation between network stacks
      net: lwip: support the wol command
      test: net: exercise lwIP wake-on-LAN reception
      net: lwip: handle TFTP headers spanning receive buffers
      net: sandbox: bind raw packets to the selected interface
      cmd: wget: map CA certificate buffers before copying
      net: lwip: recognize wget URL schemes only at the beginning
      net: lwip: prepare address users for dual-stack builds
      net: lwip: configure IPv6 on the shared network interface
      net: lwip: add the ping6 command
      net: lwip: support IPv6 TFTP clients
      net: lwip: resolve hostnames on IPv6 networks
      net: lwip: support IPv6 TFTP listeners and server names
      net: lwip: report IPv6 TFTP port-unreachable errors
      net: lwip: support IPv6 NFS and SNTP servers
      net: lwip: support IPv6 HTTP and HTTPS transfers
      net: lwip: support IPv6 netconsole peers
      net: lwip: acquire and maintain DHCPv6 boot configuration
      net: lwip: load DHCPv6 HTTP and HTTPS boot URLs
      test: net: exercise lwIP IPv6 addressing and DNS
      test: net: exercise lwIP IPv6 application transfers
      test: net: exercise lwIP DHCPv6 lease and boot lifecycles

Marek Vasut (1):
      net: ksz9477: Constify driver ops

 arch/sandbox/cpu/eth-raw-os.c                     |   12 +-
 cmd/Kconfig                                       |   26 +-
 cmd/lwip/Makefile                                 |    4 +-
 cmd/lwip/dns.c                                    |    4 +-
 cmd/lwip/nfs.c                                    |    5 +-
 cmd/lwip/ping.c                                   |  127 +-
 cmd/lwip/sntp.c                                   |   38 +-
 cmd/lwip/tftp.c                                   |    8 +-
 cmd/lwip/tftpput.c                                |    8 +-
 cmd/lwip/tftpsrv.c                                |    4 +-
 cmd/lwip/wget.c                                   |   17 +-
 cmd/wol.c                                         |   20 +-
 drivers/net/ksz9477.c                             |   22 +-
 drivers/net/netconsole-lwip.c                     |   86 +-
 drivers/net/netconsole.c                          |   18 +-
 drivers/net/netconsole.h                          |    8 +
 include/net-lwip.h                                |   28 +-
 {net => include/net}/wol.h                        |   27 +-
 lib/lwip/lwip/src/apps/http/http_client.c         |   27 +-
 lib/lwip/lwip/src/apps/tftp/tftp.c                |   12 +-
 lib/lwip/lwip/src/core/dns.c                      |   28 +-
 lib/lwip/lwip/src/core/ipv6/icmp6.c               |    9 +
 lib/lwip/lwip/src/core/ipv6/ip6.c                 |   14 +-
 lib/lwip/lwip/src/core/ipv6/nd6.c                 |  339 ++-
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |    3 +
 lib/lwip/lwip/src/include/lwip/ip6_addr.h         |    2 +-
 lib/lwip/lwip/src/include/lwip/nd6.h              |    4 +
 lib/lwip/u-boot/lwip-hooks.h                      |   41 +
 lib/lwip/u-boot/lwipopts.h                        |   12 +-
 net/Kconfig                                       |    4 +-
 net/Makefile                                      |    1 +
 net/lwip/Makefile                                 |    2 +
 net/lwip/dhcp6.c                                  |  999 +++++++
 net/lwip/dns.c                                    |  241 +-
 net/lwip/icmp_unreach.c                           |   33 +
 net/lwip/net-lwip.c                               |  491 +++-
 net/lwip/nfs.c                                    |   48 +-
 net/lwip/tftp.c                                   |  167 +-
 net/lwip/wget.c                                   |   84 +-
 net/lwip/wol.c                                    |  129 +
 net/net.c                                         |    2 +-
 net/nfs-common.c                                  |   73 +-
 net/nfs-common.h                                  |    2 +
 net/wol-common.c                                  |   46 +
 net/wol.c                                         |   51 +-
 test/dm/Makefile                                  |    7 +
 test/dm/eth.c                                     |    4 +-
 test/dm/lwip.c                                    |   49 +
 test/dm/lwip_dhcp_policy.c                        |    2 +-
 test/dm/lwip_ipv6.c                               | 3115 +++++++++++++++++++++
 test/dm/lwip_wol.c                                |  301 ++
 test/dm/wol.c                                     |   91 +
 52 files changed, 6329 insertions(+), 566 deletions(-)
 rename {net => include/net}/wol.h (67%)
 create mode 100644 lib/lwip/u-boot/lwip-hooks.h
 create mode 100644 net/lwip/dhcp6.c
 create mode 100644 net/lwip/wol.c
 create mode 100644 net/wol-common.c
 create mode 100644 test/dm/lwip_ipv6.c
 create mode 100644 test/dm/lwip_wol.c
 create mode 100644 test/dm/wol.c

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/2143

Thanks,
-- 
Jerome

