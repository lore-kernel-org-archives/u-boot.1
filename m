Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA72606A32D
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H1saFrIe;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=C1v2K+U9;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=C1v2K+U9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53B3E805ED;
	Mon, 23 Nov 2026 13:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjdvWUkctmpI; Mon, 23 Nov 2026 13:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54FCB80795
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795438989;
	b=sVziU+iZyYrVXMHqTtkNQrlKVBnPYWpg0IfdV+Fhoq2+JSunvKilvx1YHALSV6t9R5J+
	 GG11IsEdwNValbMjQVzC6y8RnWp0lNDp1mC6ZQi19T/Vi5ZJqsAJ0PGcPXRFn30GftMN5
	 QrRMGoTiBjCO5dYu3Yb+Df8O98/6xRNmuOIwShXLe5uNWIyMx/yYpiPZkyuGEyJsIh6/1
	 9EIen211qsSv8ZWCQ+HbmB9xrY/GFnTuYlMhQs7zQQOxahfZzd2ZLvn78JS4K1Wl7P5sf
	 uODFAVCvlQL0/pl3e2v4T2H1bRuaD7QzJGB+OFLkFg0ZuwqKNlFqmoDNsd8SQr8f0KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795438989;
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
	bh=PnIj8XdLYoHSthTOu3XqOif7Gp/Aa8uKG9UEesZZ3L8=;
	b=MfWG6t3k1sKeCadMBELZp6XnUqUPpXUUQhA3OLGdUzv3YPkGu//om6NuQ1aYVbDIv6rS
	 b4LMuQg6ORVKhpm4H9i/695ab4zZKM/4lxm+aSlwE09pGS0vJOA4vVJBun8pVbtIaw2yM
	 qOe95tDGLpBmc0MRqDuuDwkHhmaQjU9B4krTk4nr3FXprxdGJiiqndAxIvbsFU+AGWaQk
	 Omp7h9RgIHzeTg2SpfgGT53ArT0O7VLwaQ5Yf3HjAaS0Dk3M0UyebdVO6NCFLKM17Gu9A
	 7bGMYLOfi2OoKNzTm3yQPyzXckMakL/ZKdbKZDjiKOKwI5yUxAO9vCBD0tryrbiWqjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795438989;
	bh=PnIj8XdLYoHSthTOu3XqOif7Gp/Aa8uKG9UEesZZ3L8=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H1saFrIewZ8KwZbilVnZSyPDh/Yl5Sl1PG2kaVoBIxzmylx5BpJvxx+4AAHenM4Z0
	 I3FopFfs2X82TJjbIHZc5y5H6ns8bJ1ESnmcPz32r1sWuUdMVxbyQ8Cj0A0pI1HyT2
	 MuR/qS6gCXA1moYLZ07cqI17R7i6z4ArsAIoZchX5mAFbaS7z6b1drO9uVYdkPomec
	 6VNi+uAdsbhxEJ9evEayNQf5K0jSxrhPlGrS4e/Bkzp6f/N3CgEm9pCFfuc4RUWSbU
	 e0SpCW1OQVqFtaYCFJ5fGhgwJwiSjvMkrM9YOJ2cUui4EZx6UlDM/Bk4irA42pNVBx
	 NWuxMcCazOPHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54FCB80795;
	Mon, 23 Nov 2026 13:03:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A64671AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 975D3405BF
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3zDnw4ImVNlw for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:03:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F04ED4057E
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
 header.a=rsa-sha256 header.s=selector1 header.b=C1v2K+U9; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=C1v2K+U9
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F04ED4057E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnIj8XdLYoHSthTOu3XqOif7Gp/Aa8uKG9UEesZZ3L8=;
 b=C1v2K+U9GxAQW7Z2w5JtYW0aMixZ6tHAOnli5am1ff8c4Xp4aUATpcceB9mEv6KEZ0F9CZL/zoxOX0qAKkjAVn3MAAKWE1Wb1OYbb2PRewO0QMxaPanE6ymKApar9QEsUSCkOqqDgf81RDKIzgTbK6MihKrc4Em4zQEsj+GVBmM=
Received: from AM8P189CA0029.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::34)
 by AM0PR08MB5490.eurprd08.prod.outlook.com (2603:10a6:208:184::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:03:00 +0000
Received: from AMS1EPF00000093.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::a3) by AM8P189CA0029.outlook.office365.com
 (2603:10a6:20b:218::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 13:03:00 +0000
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
 via Frontend Transport; Mon, 23 Nov 2026 13:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnIj8XdLYoHSthTOu3XqOif7Gp/Aa8uKG9UEesZZ3L8=;
 b=C1v2K+U9GxAQW7Z2w5JtYW0aMixZ6tHAOnli5am1ff8c4Xp4aUATpcceB9mEv6KEZ0F9CZL/zoxOX0qAKkjAVn3MAAKWE1Wb1OYbb2PRewO0QMxaPanE6ymKApar9QEsUSCkOqqDgf81RDKIzgTbK6MihKrc4Em4zQEsj+GVBmM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5804.eurprd08.prod.outlook.com
 (2603:10a6:102:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 12:31:41 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 12:31:41 +0000
Message-ID: <3fd86650-3058-4fd5-889e-099b56bdb37c@arm.com>
Date: Mon, 23 Nov 2026 13:31:34 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20261123
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CT2P275CA0131.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:21::21) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5804:EE_|AMS1EPF00000093:EE_|AM0PR08MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b975575-a75b-4cd1-3f7c-08df496219bb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021123027099003|261009223027099003|261021121427099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: VmrBtKzxWYUeXcYZxqxP2IaLJoZuoVM1pzekztPPJRvMt2UfGKrZwAGigZUVjfcBwjgM91+e5N2HwjL53TosMN546RTssdAlKbA0gpKdwjpLWevs1qmtI+CvcdkNnjjVGcBRodYibwh8cnxI5rO8Y9HNYoqzdUPQD0ffjh5eZQ66iRF3mz27npWJ4ttco5vylji65EzOpZ/yoMiPW0iFaK0FLgcC2qH81Zx398GVHKMmpzq0gZCiuUj3apCghzPBEG90LvHczNOpb8ocI9xregZGn/xh9R6IQg14cQ7G6t9/Rcn6eXzDGC3XhRcE8bNIzk60qZqIIWrsoIzfvydXROnJbGq71UFa/6Aggi7kaOLnf2c8R/UEHpfLEqE1k4x/TFQABx6Qjh2iHoMMmfIS2IHQ5FThC8ip6rDTSuWsb2BJlabjkIHGPt8lTz+SlFwOj+FDs44v521sgmbzN/uoXXHOrE2JrmPI7c815OxYmNSBXrReG9OcynlALQ7+RV8fx5UZ6IWBffCkHhKF93/QqIViiD2nD5zyfz550tk0GqV/30KszGvqCMfJ6OEqM6LYfks6/r5F8tbBYooP1jUWnTvrF/6bQLmIKHS24JpSBJWcD1U4vw/QaRTON1jOU5eC
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: L5hcQBDyd1BGXa6cB0EDMV7ISP6aZqdTGVIySxpRGrW1u7LyKCHFSpEE2mVNfMJi/H7jdHqRT5WhZ0znQs0x/PgeJiYCJRM0B2/YRnHcnnamPuodUdbkChZAT7TkFmRGdW75i0pLr9CXCcLDrA4I2rDIgU2T8lynxmSFM1PVrgsyLtJlVYSsO7xJdFF1Pi1lla+3xSGCWFpujTL3h8cGXsxXsDoIYI3BMWOm5X2YJuyGnPPoWsVh5AS921Wk8km3RRqul0Pm2fAoi5NPF3hA1ZAzVG5A7tSWv/ul+ENUxz0ZlKY4+piLigM9doIHRYCuOgLCaWnqxbcHJXbHwwFXxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5804
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000093.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b7bc5665-332f-4ba7-1a07-08df495db9da
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|14060799003|35042699022|82310400026|1800799024|376014|261028144727099003|261026121527099003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|11063799006|261021123027099003|56012099006|10067099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: dtIYewkQ0QCC4Q3FYdOm50mAIuQOZEBy++L2ADdxuG6Yl8zqsSkECrqEX3iu+pRMLjRy/SNB0e8xjcZSzww5+FWxs80n8tY4y+8LFwuuHIDD8UpsoNimmOnF8lYjF9VsYQ6HI7p0NAm1nMD4ceP+ZOcy8JG1pQWsibbPWUULjradSL2QY8Er02JRH+b/ftVzF/xjnMk2Z8se9eW/Z6fmrZMUfjUmrEAAxv6lh9i1WA5ecySLB7Wucz4ICn5OcLZbrV4fq7WUuDW226DH7H3o4U5csCCMakz/XHw61AmMxSRg0KV/KzzqS3PB2xzZRRPh3C9dINA/aXhRuFsBTThVbAMIRHZj2PLj7opytlf/yISksc88l7TmZ8wxHcWBEuA20qNRV/f2eaehVVL7zu1+Hfvr0ynjtjchg/Tg9b33JBByjqc6exB1YfV9yK9IggY1i+Kua3bxFpeI46ctOl1TeHyIxP2MAzUaNupoeMUSdPn38MCtxtZAnNfM3mldy6sWABFtVwF4RUBSUbBqJexR9qXZq9x0V9Y1N54+WH1RQOMGI+RzR8EFiFKjg1jO2/E+kT6NTI7waizu9eMD/3TSTiCZtxe+Y8fSf/5xPFDGYfmST6NaFVhMn7zmBiHEwffilZ1OsQ5uDsBYZg7m8EG64eZd9FBPriK90J2NrvneqoM=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(14060799003)(35042699022)(82310400026)(1800799024)(376014)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(11063799006)(261021123027099003)(56012099006)(10067099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /PeirmNx6vDKxZKdIwt5c76Vut9nYBHfWsRM+8ZNzw1nv8fGo3qAmV58eOQSG3JnxIBgpFn8dQg+W24MMkNdm4i9YqLI0WqlZicqEgMZLy3athP9RNem208Skq3V2IC4tpTOQMecDUNHHwLn0wN6ivNcnlm3aICcCCYRvIrYLDiVI3jckIqoGlgqXrQTsb1+YsYzxELLs6mGRmU9sXvoYFmnzqCm6c+sz4EHIeeLj/1hpOMZeNvmBmMoOcC024MDEb04llJtOzDC8ElDYGprWMGbNGQriL1MGA+AT5mhwbgn6Bw0iamuwnK9GRMlLXdpILqs0HlNLirjxZB9NIUh4sP6bxsqpo2H4p/6er6TV21hcz+/PV/C1tN/xbZEb3imPZDWYc8TEAQPlAUWG3VGOoKyG05lFDl6KQaXTkY+4l6QtzAtth4nn4DFSlfMrk39
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:02:59.6781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b975575-a75b-4cd1-3f7c-08df496219bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000093.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5490
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
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit e578056c766d653270b14557c2a9d8daec414c17:

  Merge branch 'main' of https://git.u-boot-project.org/u-boot/custodians/u-boot-sh (2026-11-21 13:03:34 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-20261123

for you to fetch changes up to ebda987c6ecfe1cd609ce37e036c2938bc3c98e9:

  net: tcp: account for SYN-ACK payload sequence numbers (2026-11-23 10:32:42 +0100)

----------------------------------------------------------------
Pull request net-20261123.

net:
- net: zynq_gem/eth-phy: fix resource leaks and shared MDIO bus teardown
  (1/4 patches)

net-legacy:
- net: tcp: fix CVE-2026-29007 and CVE-2026-29008 (2 patches)
- net: tcp: account for SYN-ACK payload sequence numbers

----------------------------------------------------------------
Graeme Smecher (1):
      net: eth-phy: release reset GPIO and reset control on device removal

Prasanth R (2):
      net: tcp: drop segments with an invalid data offset
      net: tcp: check option lengths in tcp_parse_options()

Shubham Antil (1):
      net: tcp: account for SYN-ACK payload sequence numbers

 drivers/net/eth-phy-uclass.c | 14 ++++++++++
 net/tcp.c                    | 65 ++++++++++++++++++++++++++++++--------------
 net/wget.c                   |  6 ++--
 3 files changed, 62 insertions(+), 23 deletions(-)

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/2136

Thanks,
-- 
Jerome

