Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E45606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UScn1JWB;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=rAB7/d7R;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=rAB7/d7R
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6A6D40844;
	Wed, 18 Nov 2026 08:55:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWmbKE8Zm_8s; Wed, 18 Nov 2026 08:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CCBBC40849
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794992155;
	b=JzDK6vfY4UAvIPH3C05J/ow+vCwQb9q/alU3SvPYipKS7UP0xYMQrIwROow04J/L3BaJ
	 1k2z1DpVmzdpuP5zKku39fJ9kYaQVt2MxvO/7+ljmTPuH9y4+45p1GsBS1WpgzvbBymTG
	 zW5a4uAFTAAwftPDIGRNub6smolKVngJ7jWFzvaPYCSdwxkhKyYvEI9OEXx9i3H7BxCEG
	 2/ZjoyuCrssG4xe6JOA5Nb21DY+zlAj02ZVJs+5qS1pfWDgPXHUivlCgpCl4pwWisAV/Y
	 Av2PC/YoAbSI2t77T00c251MdoxkAPT3vKj6+mllagyMyn+gMpPx8zRCBZeVBYlihyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794992155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=HFsMtSU8nw0q0iRiCDMSlQg7+Dng1H+TZlRyEgs1sPY=;
	b=OsFdwR43oAUzBQBUz312rI6g6PImqHAvU4yhYrM/ETKJlvKW6KtQMwkBKAPZHO8gCcBI
	 MDYx0zNRstok+kA7AfdavIDAFZLeArum/M7XoBUWUVLcbnwOmddsgZ6qACu9lOGvfqhhv
	 mf+LtkCCUnsbboLefSbnS5HTs5HY+lC8issf++1ODt1F8Z5ocWEo4PjvSSHI/mITCeLOF
	 ynTOwkrLbGKhavWowp4Z9gK13lrUSbb/HIILqY5+dLWs+Mlnwls1c3iBTPs4ayTmwAOk5
	 64qOuIq6aSvGNy50/o6I5IQK9Fs8F5ReWsy3qwhyICurbu2I7A13AHHyYhme/rqL3WA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794992155;
	bh=HFsMtSU8nw0q0iRiCDMSlQg7+Dng1H+TZlRyEgs1sPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UScn1JWB/UJeIVf8VooN1bEmk5kR1iYwOQqqhf7HeeD3RmE44PKok6xH9qa/QCeUC
	 Hjaqi9b+UQPEt0frlVrgmlvcUxDopU/G0cdAXGKV61j5lRwt9Lotuq4GsqebsUuMbu
	 VACONOI+CWAW5AjeHnMN4PYbush9vk/yAFP3VAodJMpSKBECuHftH9+iZD36R5t2/6
	 WsSemcQ1E1GD16yXd0hAt6u2uLsTEUhiN5FFwrMXQ+SW2k0N9zleQvz0ZQd9fq6j+m
	 X9NUILXod9MD2kgzSRzQrswOOKAPAHM+I2t6/TAWSTDI52NlGriPMaGS5TzG2h1Meu
	 9hg5cxCsidteg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCBBC40849;
	Wed, 18 Nov 2026 08:55:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AAEDCA32
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90FE280F20
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:55:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2bfciJPRC2H for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 08:55:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA9F980E72
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=rAB7/d7R; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=rAB7/d7R
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA9F980E72
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFsMtSU8nw0q0iRiCDMSlQg7+Dng1H+TZlRyEgs1sPY=;
 b=rAB7/d7RWeZLZlYN3TFCQ729FBTh/NIu51XAzRXHjCCGwhs2kNnkO+ZfXt10l4wgaACaAq6Aut9lvGNc2qlxoxEQvi6AxL9jxIQEUqYzjhXtwCs0or4dAkqyf9qlYu+2RlPOKj2bN/sEjQBWteUo1tDPBnqSEoDwT2lFmI/U7LE=
Received: from DU7PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::15) by GV2PR08MB176137.eurprd08.prod.outlook.com
 (2603:10a6:150:385::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:55:43 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::7c) by DU7PR01CA0012.outlook.office365.com
 (2603:10a6:10:50f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 08:55:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 08:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFsMtSU8nw0q0iRiCDMSlQg7+Dng1H+TZlRyEgs1sPY=;
 b=rAB7/d7RWeZLZlYN3TFCQ729FBTh/NIu51XAzRXHjCCGwhs2kNnkO+ZfXt10l4wgaACaAq6Aut9lvGNc2qlxoxEQvi6AxL9jxIQEUqYzjhXtwCs0or4dAkqyf9qlYu+2RlPOKj2bN/sEjQBWteUo1tDPBnqSEoDwT2lFmI/U7LE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB8971.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 08:55:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 08:55:07 +0000
Message-ID: <cba28d5a-d574-4948-ae4d-4c6f93353441@arm.com>
Date: Wed, 18 Nov 2026 09:55:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] common: update: Port DFU TFTP to LwIP
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20261109032700.2839970-1-marek.vasut+renesas@mailbox.org>
 <20261109032700.2839970-3-marek.vasut+renesas@mailbox.org>
 <xhkdb7bibqyh6.fsf@mkorpers-koolstof.csb>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <xhkdb7bibqyh6.fsf@mkorpers-koolstof.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0543.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB8971:EE_|DB1PEPF000509E7:EE_|GV2PR08MB176137:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5f513c-b0d9-4c9d-4866-08df4551ba34
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261026121527099003|22082099003|18002099003|6133799003|4143699003|11063799006|10067099003|56012099006|261028144727099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: MBoV1HxZfOH50A1c9FAIRAS0iWSXYqhvolyz53SPBtY0dP4+jlMgbyAbY2CPksh/4+UyEG0odOQTlkiULO2HIQ6D7gFc20EU00Yr+nbOLdCyWzqA1ieMapKQ0amVldqDpPGLZm+rAffW1Ypa5DgVPjiMsk1XFdcmu/QN/BAUlrHNyyRmZV6KFvITc6CFy/jSTls3JPHeTu8JXwQzDCeRcv6AUEtCT+PKYCBKAt/NmoHE591nT/TwjfZwUAhQYLgAyAR008Aub+yqo7AbWdNmFSb/3jruEzBkk1Y5AX+42ibCsY1dsof233UGFMpTprGqnWf7Ttj/I6SCUoj8vwjFxowKvDp+iUQjk/L0CE5zs7A2zNn4/MgqH9sbj7jBVxFTg6LwGIepgrH+/7Daucfks4Y7E1z29ZqbCNs7H5w+5xfMUg6Oza8hDoYB6PLKUeLCvRj/Be77Cvrs4imRtwt+GQgiufQ8VM60GPdcma2nEML4Bq/BsUysFCwChOEAl4bCnyvPCtvISMVkkwZTQX0ppm5nDU9THuNgiqqypgSO4eeA5AU+GhmqkdiYzNrY+fqeaXgZyFv+Ygjr0WvwUaB7kdL4DJwMUtmFrOekvfrhqJBFbMA66qwJLdqq2rWuu/bZ2yHj9V+Hd2ZLzZpp8dll9h7jeL1guwtSuGZUuWOFA9Y=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261026121527099003)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006)(261028144727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: vrhcsH1WAjdJQ5cWHOh20NcwHNOVn9ee+v6lr1NRzVnkDNt2sDu2ZHr+5cucPIURNQHYlYVuJjtJwiPForZsvs/9TxPwTQYC4Tgw0NbeAHkFvHtiSx07OamJfIoRWvjAnvLiOezeRD+lN6+LmnhfqOAp3WMTKJeKfuQnA6biPuLTxZX6DIgHVqBBqi+fKuGDFkIy5IzrYvc6C4bAQ+rfezVss9ziHb0QlkOL+4g46b7MgQvpBTG4eyrfCG7DDgQAQyy01X9x9fzhLtZmR6Nd8c7ssN5rntTVuqiNSl035LKkxNM+d3fYpiEPqA8k6goduS0xblFWIrlCp40Gqc/g7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8971
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 40a482de-f782-4b58-831c-08df4551a537
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|14060799003|35042699022|18002099003|6133799003|22082099003|261009223027099003|11063799006|4143699003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: UiWwuLQGbgkmHSWap9osWCZf7VvNAnrIlRLttKHjSp3pTZRR7CBgLkfafYkBuW37MvKszr/mDd8Oak08BiyR2ioKujy7wX8tIXwFJomHa3RmWkfJfEd0vnfP5hare1DizVm+Cj80Gfr72StmPiNiYOwYoV2IJ1Vdjp8p53eoQ90TZqacBtQI2WfkblBV5T63bTnoLwr9FAeGnf7bc0FoBkbIZoaZgIPPgen9Oqb7RjkK5ffhLkGcj/6/McfdgvGb9i6QUnPTSA+2KOx43aOoS3Gu4W30TX7/f7GgOiY4a7weDqX8tWp9yeAEd0ZbWPGuaEoSF+xucYV59WJ4O2c2CfqmlXQ9gqGj616XbZowUgywSSe9Kvl7Orkp3UES/2aeZtqCMIdfymK+Y9McHGHdV+p3eHrJ3zf1b9I0EZ35N5a3kWWjhKbZHJ6usHc+a/m/TyWDOhmw9yrFr/qUX6TCHDRIPswNpZzv4ZMmQ/r3FQmQMsxGg3pPsDPuJ5dASvo8dxEung/gNvygGU+9rJNJa/onx5TEmZGvz2/Rbqm3eENFn8uwnTS1wFA+8WLaVe3SQdcIsFb0AGFvXIRZcvc2TJBA8IzzEB/eRXqSbV3pjvjsGCQ7WfqHdFXvf+DkEQc7r7pNWbTtL6E844g/r4ePJPLsNtfXfGEa1yQi1KiZJacXyhe2iEClS4+cEiZecROGSV5aiPuyVEeAF7Nf3Ktvxg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(14060799003)(35042699022)(18002099003)(6133799003)(22082099003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8y7yD3MCiqzV8ztLvip7xQvKK/zFz42nbaJwgVR+HCsqdxyXCD5aXD1EQQgO9Uw+yQG9V88T45ArYNol1cwdi6PX5EsAaTFzH+yIJ6TsbLgEtC17v+cBcIsHa/XclGYqn6GrDbkhDzc+RFIJWVMYc6hbjiunkM2g9obaNq5CfAInexxwPJLHHSMN2zFZtlstjfnDMaNCRL5oCxWX3fF9aw1w0oNk0iS65B6btONQeHYQeQLrWOBHISu3DkjeN8qsEUAor5v4hsDXoXGiX2ihVzmgSooq4hE94X+5SzMC0wOnnobmBZdjBencW9azMdR7oVniQeXiEL/UbvpucGrCz5tUbdVAWHrXCSN4iXEnDDToRWOq0lgdcWrTVUuD13jb01bZZSFVMHy8ZRO1iR1XSsA6wNDKrksVV3gpTnkfpqluCd9IUHmOFRpGio+WK3+G
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:55:42.7487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5f513c-b0d9-4c9d-4866-08df4551ba34
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB176137
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs/Marek,

On 17/11/2026 16:17, Mattijs Korpershoek wrote:
> Hi Marek,
>
> Thank you for the patch.
>
> On Mon, Nov 09, 2026 at 04:26, Marek Vasut <marek.vasut+renesas@mailbox.o=
rg> wrote:
>
>> Make DFU TFTP compatible with LwIP by implementing a slightly different
>> and simpler TFTP loading using do_tftpb_raw(). The loader supports all
>> the functionality that was supported by legacy network stack, but has
>> to implement CONFIG_UPDATE_TFTP_CNT_MAX manually.
>>
>> Tested on Renesas R-Car H3 Salvator-X(S) board using both:
>> =3D> env set updatefile update.itb ; env set loadaddr 0x50000000 ; dfu t=
ftp
>> =3D> tftp 0x50000000 update.itb && dfu tftp 0x50000000
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
> Jerome, since this is series is network related, will you pick it up?

There is a small conflict with commit 6ffb52e10071 ("dfu: enable TFTP trans=
port
with lwIP"), which seems to be doing the same thing slightly differently. W=
hat
do we want to do?

Thanks,
--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
