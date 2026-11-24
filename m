Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7F606A33A
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L26nH+Cf;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=q5/uKuEh;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=q5/uKuEh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 887F3607FC;
	Tue, 24 Nov 2026 12:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QN_4q0n0B0O2; Tue, 24 Nov 2026 12:51:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8ECF4607CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795524698;
	b=tPwuh9rlhb+/2PwGMvXEr5HnpNY0N5vrzMGjnlk7OweT/LjCNhacH4mPcm6Z9Fw+47jf
	 GZYGRop+nHc/LlzhDNx6fEPoKWqO6pXFTTpsVrLdW0ROYetgJ43WWYw2Zb0Vrmhe1kc3x
	 TF3y+OW9b5eXvMN8UdyA/HxOvPlnpLY8DiskGg/OvfXQUXQHyhXaBeTSnXvCdKRBYMpb2
	 ps6ZfX3mEUWpCU2db1q9cp4aLr9guEdO72bt7DHAuqQRzu8pirLcdjG07+upPB3u5sXDe
	 7KpSL6/K+BTru8EuL0xtmenmzPvKB545TXhK6Y8HsA1Oq5ZqqVZM6O3Sj8pdVaSPM+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795524698;
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
	bh=gZO338gQtY4CXZ5SOfk4hJ8akn5prvi96SwWpoG89Uc=;
	b=FziqkEXh5YXIsTHaxO193FnO2E+/7E+jioAVI3mH+WX7CA038WN3/Le3d2DNrPfjtZVx
	 Qs80RjTHH4giFh4z5IaXUEB80+3Ul8VyZigPvjJCf/HmZuWrZXDqzuZ5CALB5k2BIQupc
	 E+2ON48O5zSaKeFwlPy01CQbDL9b5zrWQF0NmwQsz6ev+rP/52jtNvO0Oj7Hxwf641sTF
	 ozJ4C5JeOKQoaVSIbq3kXlvhNgtYcsLM0oy2HMiU7n/q2o/dXG9ClBwBs9+aGmMSXpYW9
	 0U5XvBXk3HdmQq0ZRM/VuGugGnJIRcp0NSwNp5DxTk6yehT0DnzcDLzvnqbgS9b7OdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795524698;
	bh=gZO338gQtY4CXZ5SOfk4hJ8akn5prvi96SwWpoG89Uc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L26nH+CfooHAk4ZWRWyIzaXzcOZAornSJpT/rinEtyZuO99TqaAL8YqJXT5YvgcYx
	 gGISLZkHszPm/6EZHWZcpOJ/ZFPIU2pQfT3IVFQVdmFW6X/YL+byVqX5EUgj/huLq8
	 PC7SyKhf6rSGFVnjX88GT5e61Iyu8cDsesP/rWToGOb/+VEmUlmS23zyx6vJ62U0Me
	 y86HrDlauFkgjQuYkE/RY4a4RgU/az3GfkNmfmoOeQyM5kq9wEbiUv3UXOr50Lpsk9
	 gfDEtNb14zNWYB8UAnhMzC0sC+cBeVZ14gt2ezOPz6G+nf4+omMss871CU0/k69tAa
	 S/oQF/lzvhN3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ECF4607CE;
	Tue, 24 Nov 2026 12:51:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05A73371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFBDF40707
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iyeSiIp-6v_8 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 12:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8BD5740682
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=q5/uKuEh; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=q5/uKuEh
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BD5740682
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZO338gQtY4CXZ5SOfk4hJ8akn5prvi96SwWpoG89Uc=;
 b=q5/uKuEhKnkLNIql4uoHo4mapM/nxKjq4cxdM283nbS+Xcs/YEYhLy6XWsvezaOtg1iCcrc0KHiOUnIEahwp2mgW2X/o7qC8Qk41lDf3BiQ2pB66S0I0N7u5W14TltwcTczr6AYTUzL2uG0b882b/kKsZgpUeB556xs0l9vVZNU=
Received: from VI6PEPF00000218.AUTP296.PROD.OUTLOOK.COM (2603:10a6:808:1::8c8)
 by DB9PR08MB7697.eurprd08.prod.outlook.com (2603:10a6:10:390::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:51:24 +0000
Received: from MI3PEPF00008482.eurprd02.prod.outlook.com (2603:10a6:298:1::69)
 by VI6PEPF00000218.outlook.office365.com (2603:10a6:808:1::8c8) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.21.662.5 via Frontend Transport; Tue, 24 Nov 2026 12:51:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008482.mail.protection.outlook.com (10.167.240.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 12:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZO338gQtY4CXZ5SOfk4hJ8akn5prvi96SwWpoG89Uc=;
 b=q5/uKuEhKnkLNIql4uoHo4mapM/nxKjq4cxdM283nbS+Xcs/YEYhLy6XWsvezaOtg1iCcrc0KHiOUnIEahwp2mgW2X/o7qC8Qk41lDf3BiQ2pB66S0I0N7u5W14TltwcTczr6AYTUzL2uG0b882b/kKsZgpUeB556xs0l9vVZNU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB8834.eurprd08.prod.outlook.com
 (2603:10a6:10:47b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:50:47 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:50:47 +0000
Message-ID: <4ba1fa84-08bb-4454-8b43-d84c450c1e5e@arm.com>
Date: Tue, 24 Nov 2026 13:50:46 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: lwip: Fix net_lwip_tx typo in net_lwip_rx() function
 debug print
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 nd@arm.com
References: <20261121165249.941705-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
In-Reply-To: <20261121165249.941705-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB8834:EE_|MI3PEPF00008482:EE_|DB9PR08MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 6022c39a-11ef-40d4-2f00-08df4a29a54f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261102123227099003|261022105027099003|261028144727099003|261026121527099003|261022075727099003|261021121427099003|261026140227099003|261021123027099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: UEKHsDIJCfbpNllBE9VSdsAN5uvUAC5ACUA3H3QHQKjVFIbn9uJN40EOpk9AVj5h8oHiy3FFAVNs9Yy0HSL/dFPnXVK9ZP1OGNIEmIrN/E8bwOuUIGSsUXyCWyJQJuWuGPrwh+ZW19QAseE9tbR/mZPVYieDEw4eJHCkvQK6TthN3rjPnF6deIJcLPT//Wu33kArR2KJE1RQ/Y90LRud4j9ZZkdgsbg79r+JtB92hQJi4d6pGb+R4nz2s953SpdhqEHGirb0NqnqAlk29bsSYNSV77ViMhcz8gRSfH9a8e6vIFoKggPo0goSmauSCS0LSaCHixleBV5kLHMU07Rq6XG6XEJDAY6s09OWFS/BmA9KZ1JLEz3lXoWeiV8V1xRs2pRvjrTThtz5TgpkYWADkBYfF2bIRXnp4B7i07g/9jrqVJluv4dSavEgKjhYhPYd7vC+n3a7Gh/vDTWN8YjoTBz1fqvjkaVIDU7GUgJVFQAocEeDXujlz1eU+2037h9zTZw3s9PCQDnhDd9oa9O8rz3K1oTonohEPjB6IomVZi9x2t22jzqeBhnTY1xufwSqbKy2sauasmD2tSSYaFGvtHgGfBG85ioj5efzX9jNofwukS5MKMna5CtvssXkgdma
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261022075727099003)(261021121427099003)(261026140227099003)(261021123027099003)(261009223027099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: FqA5Smk81xlUabd6AzMM/59cFx/Bb+HrC3s60fWrkhebxEoAugv+nCsfqhooWovW3dqB3q+sfDA8pY7+OQNDRgSyX/1UyGEcYHzT31QsWKhsa0wqkORivUjwLU75YkYIOVkQ++i2ANZJZRcxlSiHRdAYxefXhEtMUAL26pEyzYS9kygSw47Ul3PxNam9MHpHHO3Cuq84GKS5ctoGvGdyOoXeOGlXt5Mdxm43bgnN9jN1G0HlQX5CjSK0cVGxTP7ECSodTvtzRJHIlzbOC7RWmVDqEmhImftu1mygTgx8AvZ3rl2CaFrr9b5ahPw38s6/61kM4peNo0hsRunZ2rB5Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8834
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7475d0e4-c103-4de5-f783-08df4a298fcd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|36860700016|23010399003|82310400026|1800799024|376014|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|22082099003|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 5Cxn9Nv/2DFwca4l62Qgoy6GfH9dAoFAaOPRMa38TJlTirQDfTbc3k7Jw2m8HqmkU6HMp8eCJldDJ4jvUlftxeTyN62BR7CMofSG9KWpDXBTDKvCWp7/A3bzuD929KijdZrOYOjmwGdaDOtbvTR6wntdQ+NKNuvDjm8+v3dxPz43wbph45eHb4nxQeZMsXv/3uoFy/AH/oI/746TgSsrLMIqI7cNB3MZWl4spdEAh956Xwi3d8n03ChNrJBbakryaDDkfuP5Aj4+cXijVDM4pDKFt3YInZnSCaXxgh21Egiu89kgM1ATNrVE3S0pkUSiPsDCKQd8e783k7xrOQHA9Cs9/4sGoWmdhJVkT7qoQGvPW70rW568AAkkR4+c1tJ0MSzVvZZ6i8QFl9p6AaIhG/0c/EbC/QrlU5g4vGsz/55XD3rJMo9m+6Dgvzc6Xh0VtiVw1oewIPUjyxeWCiX8BeDj6mNJU9HuIj1D041fQ9QT/6xMj5t0imPkwTuilJc32PTcnKJ3OIBEW8StbkNk1p1Vmtt5X5b9QcWRzTnT5QHOQtMl55pHThn2Rzem/50i5UOL+akH02FL1bgkGRddKFP3PNGwFpMbhyZfvr2iApLBc0dkFs7DtcJSS7PpkUbtSS/Fw9Op0Iafh8tRBGI7dE7oQNSyS71pXA4H+p2okHU=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(6133799003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oax38jzqvQ1i9PjqHwZLc6j4FEzD56vDwFTY28INkVWum2OKzpYcDswJiWBu5TSGDf6h9TIskGDLmO0gimSh5lNu/NmtusGG4rzTg9F0jPWLnlb161V2ZiO8Qs3gRaXM9WUGBMDmYE6RzeVfT3Step1V2ffdKbQjlXcmF7fO0thHWob2Rj8qK/dARdIdUSaCs3u/VdWndeRVNQZcAVRjzdO6opAzWTjiwjNx5Q4lpyo1hKpWMmle4TYq/qe1AMEbjy0TVCzVnf3GPUa4X39GOufHta/8bjIM6U3Pz8qsQygdMUNsR6jhhT+ZnjgjcSprpe0GQegblX2muk7QSrS+7vefhftHy4npzVKgYQvqigidlHDTf+3lptXm+P7ZQILSt5oA+YEN0VEMB2IBUmSPqTp4ECz/d66PCyxedafVDnFAkASK+DGEHmj+YFx5r7hz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:51:23.5135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6022c39a-11ef-40d4-2f00-08df4a29a54f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7697
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Fix "net_lwip_tx" typo in net_lwip_rx() function debug print.
> While doing so, replace the hard-coded function name with __func__
> in printf() and with RX: and TX: prefix in print_hex_dump() calls.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: James Hilliard <james.hilliard1@gmail.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  net/lwip/net-lwip.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: lwip: Fix net_lwip_tx typo in net_lwip_rx() function debug print
      commit: f55a3de9b8d3d6601f3766eca1f11205c560cffd

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
