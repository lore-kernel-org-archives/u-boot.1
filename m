Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45209606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=icYwlOg0;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=ij7+IZuw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67DD980EBE;
	Wed, 28 Oct 2026 09:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3NqeOcWTs0C; Wed, 28 Oct 2026 09:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF04880E4C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793178119;
	b=KzqKhqsdmfbKcnZ4g48r7iqliwvA+lpZnAWMlZ5K59sef4OAJwoL+J7kRe39ntNSJONG
	 Qr4abT8hll261vnU224f920MesvfxOuN5VFjAZeSu2IXrcczbnZtAM81CRPqdpj2fOSwc
	 Oe6Icc/W/fufZcS4oPtjO1t9dogZl9D7G1iMEIt8tEMMvu+U+EC+bif8IQmEkdrAzpRMj
	 /as2d19G0UIS4gjlEBieOpi/uuLWEkkIQ6/eO/sFfdSntgTuH2tZcNnsb5DRB9IjdHx3q
	 hx8HSgoLMvXdoylXTi98u6wDmaUSVpowTQx9RxfS3NWeQHKm8Mk5h/0O3QpIhrN6NiA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793178119;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dDCYjFbJncUfTZK1Ly9VLNBrO8MGOEQM/VhYPFsU62s=;
	b=L8xWyVo8HaOj+qVIojpC9+9toNONWKQvNrQ0IkKj+S+GCyPIuhu4WjZPPVaj7LlMSkdl
	 GrakdhALnb1SnrLd/9MGpmqK8eOpEZDH8vT2zKs4Vxas4IzxfflguwNXe39KCrDCuXExY
	 9PlhldwFakSbO04uvCWFBzAHeaYDQp/fNCJO2LE2LHwtZvihhgqzl+fENq/g/hTkMib3o
	 TEKUTwjhaWv0p81KXyBV7oRBNpn0wGtURTrXzAV6Pj7X7MOgyR/HwF9BDeqRyPgzWWxLE
	 0wTsRm8uk8uzOaObqUh2e9qgNfkGDimjXlbWP5OVGJukulajsti6KqQUrsMVRgqU+LQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793178119;
	bh=dDCYjFbJncUfTZK1Ly9VLNBrO8MGOEQM/VhYPFsU62s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=icYwlOg01AXAHjtE2Gn2C6GySDL4bD/l1uebNXLn+Ym+zO0/p5j7UB5DoU34tZgs6
	 h4Y/xfimmH9z5+3G0hmiFOVDlnhN9xddIpzpS5SoW3wyCKXXzdv61Q4JSjN8aFbN57
	 E5g8kcM3ZH5jQEt1Ynz1IhVrfM3aOLgQjNLMSk6E4EzJcpGs0YanwIlTEf8Q2k/W5B
	 pY6aDPlvmZgtj1RZgBzk0mh7InQMx+mXBL9RcECIJtaM/QknWZOqSQp7mTOuj+CXP2
	 1ll8VfIEU9TmpLXddBb8ccaoLTb+oIIzwr4YUpsIaxH3ZhKa/pVN7QgLhL7qTTyZWg
	 hjE3B7Pn4To1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF04880E4C;
	Wed, 28 Oct 2026 09:01:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 899FF235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F75E4060C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WA57nebUAi0W for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 09:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AFD0405E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793178117;
 b=LCu4HaiieQtM8P36ugPkdQ8gbACAevmsfQ1VbBN/3p6lLCYoEtQmKEmBmEfCTzUmphq/
 yC6GPnodOAHoBIMR3NG951rjk1/rBOsdU5MUqd+g1qxBLr/PkAWGMTAk6GGN4At4FMXC7
 dyVUYOieDUU3SDT5dJ1mtC9/LaXFET9555lrI1a8q/zJYpwkceEHZ64OtkQdF317F9yuW
 XwWOc9QFAhn8J3upnj3jBo6JH76FDlVye+cAWeGsA8aGXDJVHFI09PrFDpXAbPx7bI+Dv
 fmhHLuJbkAx0bzymMdXRP0fkMnqwThNkUErvnJYoMdub9SStOHlwU0J/wIJKpQCIxIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793178117;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dDCYjFbJncUfTZK1Ly9VLNBrO8MGOEQM/VhYPFsU62s=;
 b=bu2BpxYVaCRiUY9ntRpk1lvpo/YsJO9VH9rXVIma4cQF7v/OLbRjVgAwUSr7vsQEhT/M
 icF9uMcHYoFbNPn1NADtHlrxraEqnKZrzyS6IfEZk9So+MMOx2NrhtySf7IsM/+SmkXtp
 T1ekQtgw9LndCeGVpnJ3glxpRTcF0EYDJOlXbQcLpm+Pi3wiIl1/pJtika8ItdAdj0X13
 mj2uhtY2KksKsdPr9CzWyhmqf7BF2o0jLOJfj4vDTZnCa04KV4JRdqHagjXkliqzGB75G
 o2KtjF85EO+UoUa/UILKFDtxqMr4TcHGw9i9AaT5RRYCtlG8MZjekQ1muv/mfCUYpGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=ij7+IZuw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=ij7+IZuw
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AFD0405E8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcYuDlRw6dWVcF2CxvZK7vpt5mUCHFd2JJ/ojWeeq0W2ftPSbRPSvPukXf6gzNhETtZ6lBFsroJ2VOACGfJYBsxqf5iUNJ8EnssOt7FmVdFxmfXeDM7P9mQ+BONZC9xXQ0kOjkfNzx3tEGUOR4FBkwfLUMeW9+CzvOjOG2FsHAhBe/VaAVhKwYc51/BfPIBOJ8f4GDMtI3Q8lNJb4I2UryFBRwv+wqYV+BZlyr64nZXQHYjVTasgHSOwX2YhQFcdAKoVrUehJS4bULbG0PMoS7InCGsIzNdU6j+6GhNiZQIbtyg9SmXCrOBEN8JKH1qsBUjPkbIcigMf4t0YJlLdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDCYjFbJncUfTZK1Ly9VLNBrO8MGOEQM/VhYPFsU62s=;
 b=zCFsKqetBUuU/UiJmtlha0N2q8mOKXGYHjFPiBB6AIEuY6g1Z7OPeS9Fv/3bxHfSRCor2Q0pz0wcl9GATMGqeES3VjpZUf0MQ/qR0Hay05mx3aIiKtDbHQhZ4eB06ki/EvSOEjtfSShVF2/5ZDyKpN55VE2mBn5Sen/5/YkgSixH7ulxFwoXNa4Y4qvyESPshww2xwdlQNZZhMO/ZlkZBHlfX8bVhuR/IjTnRik7+KwhXyBmj9h842anxBAeu/7wrjBEVy81zzgM/C0UBWA3ExdLGGVZxdtt1rJC0XXP5NMsk6BpoHEae0nyDY5P/PDtIQ6IknuAmf5erSyVYXVTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDCYjFbJncUfTZK1Ly9VLNBrO8MGOEQM/VhYPFsU62s=;
 b=ij7+IZuw+YwKrBv8TUQ0B9YA3rFp37YQ1hHQT8nDCr26AaM+DwuqujR6QqgcP4ukbtkng8jWnqsxBSRZGqTKz3axm6pZaNk46R0fmk/JdEXjMiMzh03R3C0N14mfci28Y9igoTNa1LdUKLZFD/j3lxm7K+7LFmjBvmHJU+Fnkf+ndBZxN1IOmxRgRHFjS7rDX/cNaOLEXrNTe3kpEqqFRdK7XTB4P0P+JVCwVIZEdNjzmkegE3kNOLRmW5lm4Q0irYvu/7sbc/E2Ft10B0XA98jgzLoRkcvBnfg9q0oZJma9IXtzubH0gG45NwLyJXkc+8qbqGSVi7a0q3EPSv72Ew==
Received: from PR3P250CA0028.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:57::33)
 by AMBPR07MB11323.eurprd07.prod.outlook.com (2603:10a6:20b:6ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:01:51 +0000
Received: from MI3PEPF0000855D.eurprd05.prod.outlook.com
 (2603:10a6:102:57:cafe::a9) by PR3P250CA0028.outlook.office365.com
 (2603:10a6:102:57::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 09:01:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 MI3PEPF0000855D.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Wed, 28 Oct 2026 09:01:51 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 0F204200AF;
 Wed, 28 Oct 2026 11:01:51 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
To: sjg@chromium.org
Cc: jonas@kwiboo.se, jonathan@joggee.fr, juuso.rinta@nokia.com,
 stefan.roese@mailbox.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, yuriz@vodafonemail.de
Subject: Re: [PATCH 6/7] watchdog: sandbox_wdt: add get_timeout operation
Date: Wed, 28 Oct 2026 11:01:50 +0200
Message-Id: <20261028090150.2461390-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszTg2Z6jS9BH09ZM5zaDsCB1j0MU6nO_Jb1eC=0wBamafXg@mail.gmail.com>
References: <CAFLszTg2Z6jS9BH09ZM5zaDsCB1j0MU6nO_Jb1eC=0wBamafXg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855D:EE_|AMBPR07MB11323:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7aca9220-a1b6-4717-f6f6-08df34d21b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: wc7c5CDXFgCxIBktVSHZCJohR0DJVNFWIYYuvfnO/qz3pFJijaJuZ/r55Gh/pAdbLQLrF4pVj/k9g/WTa9ZTCT28Rlsv5GIcJvIfUh2NCnyYoTBj7utdV/wKCnzj6ClYerbERsLdPhUaFDZuTsqbh4TcQKY5GDtdakZE2L1+cMK663BZlNbr1EU/m0Ld5iMdmlIuz3d+vhY7P5Yh1wu2TsFDuCXO8Nj9xNZTQY3u9hefo6x8XSVUCoCiIoiVHL6+hRW/uyQ+sHKju0uq1i0u9ZNOgYjh9q63pt4hA6auKTM2brvuSHOatxBQqkWfixibn1kbzJ//wAxiOgUjkHy0N1u4HZJxBjwZQWXa+jiY6b4nrwGAHUA1aX8DfUrKQP5/HCw/ZWcZKH7SWSjL9rf/bypL5ViDU05FhFxQa1Zkb2U+1uerHGAAGTP/0rv0w7VlN3YRjDVC2QTGDZkCq9wZ0izbUeOf1v4TtPBPDK4H9rHH2xoW89qobm5KarrDps+XtvYN4sjhKqjKVulSGrDX7oIXXqd+HVz5QmXBXHuXGXWaOX8PhG5cVHHKwZ/fICrw3gA4ZIejGNTTn3sl4AnXNLmSmr7/+n3+WP3WFFdaAJpOXHhOjRr9+DOS5YsYG12yAtqVCSks/C+hWFH+6zo8cNpwOqkHPsqFVMKmg0M9czLxpk3E7/0fwzQ6KZf8sXsu+mG3TdD+qargEwvDDeAIug==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZoW4/3mxQFwcXB3KBxZIC8c+T7Vhpu7Kp2a6GzKJ0ZiPzy7JGYVfcaEoUgtWIQLfGPUirAlBIxt92XR0mXZvvqLNQsMh8MTgCFztasIJ8HAtStC9vQ/ScnDtAkHkVFznoi5l5/SAWNPqAD1FRvY+G/U3TSFlccP/Y8ah5XdeCZ0HPi57t/WZtEFSxsIlsNxkawcSNljgVmTp1gjCfrd7Wua6zy9Fyl+f5cSqhNRCpV1jdCv5bpZlp6032R/n726QbCsNicR70ow/lxbz4zDv27JWBCoM8A7nD7CdvDZSj9i781hNFJ0vfGknjPcZ2tpPxKzV6he7QqtZV5Q0pE+CzHKpiY9Elz5Glh3gHulgcp3qwfRWHW349Zq3ik6OMbFyr/jFEQR3bkVxOMtORtUoYaKfWIFViwioHV8i6bpOZ6QQ5I0xaFcyFAztQmWd2YFg
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:01:51.6312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aca9220-a1b6-4717-f6f6-08df34d21b66
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MI3PEPF0000855D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11323
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This returns exactly the value that start() stored, so sandbox never
> reports a timeout different from the one requested, which is the case
> the series is for. The test in patch 7 therefore cannot reach the ',
> requested %ds' path through wdt_get_timeout(); the clamping test only
> covers it because the uclass clamps to max_timeout_ms first, and
> passes with or without get_timeout(). It would be worth having the
> emulated hardware adjust the value in sandbox_wdt_start(), e.g.
> rounding up to a whole second or a power of two, or to fixed steps as
> max6370 does. A test could then check that wdt_get_timeout() returns
> the adjusted value and that the start message reports both values.
> What do you think?

Agreed, I will make the sandbox driver round up to a whole second and
adjust the tests accordignly.

Regards,
Juuso
