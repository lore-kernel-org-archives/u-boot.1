Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85B606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hTBrQHKC;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Rxvd4SPd;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Rxvd4SPd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F35B480DC1;
	Fri,  6 Nov 2026 18:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dAVnybRzcVL4; Fri,  6 Nov 2026 18:07:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0615980AF3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988455;
	b=LSVlZnKi+Vc2LjeyRk/O/+EbuktPYl7fDpfwEMpjR4xrQTE39Uvr3Cz1exVZAlRfTBn7
	 QHpoxMZMeAcaixtzC1EHwu62NzQjVsPFazvT+C1F19KkH2anuhWw7cUdJ9szzxTDcXKKh
	 /9BqUE2U+K/Xhc7yPbf1grn+l2eXoipH77VJsIMUacQUTnvbTgWUp5oFr+Pt1r9nEyYpW
	 0Qw5EN6akARyNof5ixJVDRA/dE9NSCLY7Bpt//zNVLrcf4mWFvU+AKNlA0cpJmhD23KqL
	 KtxD0P4ARxHksk29IOyorrHJTQy3Yu+zy525wnkJtJZgKk8L0pm4gA4c2K+Ehf3vqyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988455;
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
	bh=3tqdqs4S/o42deKoyns4kZiTcR0QuPgcClTtjGAtzBQ=;
	b=OObCX90+H+Wootnar/7ToP2VKiIbTUWRUp71LDx+5x6KZtcMh5c1Q/qFY5AqNuPUJXNR
	 FIKHtDzw7ruAaTQXSNsucHCvVZBp+D2qT7ixRUJ7I6g8QKKg7SbqmLtNQEYO+yrrh8WJ4
	 7EInDuEomim5v94fy30klxJeI+jueK73JTMktHzKPNXPpqlfHOiY/QdDeXjfFgkkszr6x
	 F5C3+jNJ5DMND3ZF9A3joGWka5iMqNgnmyHoovdOCGyKoUeP0WbAbyBmdKhX2wqSOtyTv
	 W7eaQfGYyfRBeSRssNPtWyocxlUV7xXS7qrQVekpwIWgj+aMBEyOmbSRy/VYJGL2lHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Rxvd4SPd;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Rxvd4SPd;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988455;
	bh=3tqdqs4S/o42deKoyns4kZiTcR0QuPgcClTtjGAtzBQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hTBrQHKCPTwJLSK56Az+O8h++KC7V143L0R0R7TBcaQ7jh//9Sy3mgguULnyS0tDR
	 mQ1JaDTT1YGPMv/6T8PzldHl+olLXTb+OEuQzz/p2OoYQYAKw+9Q7eqeXqxWZV7lJ8
	 kDJoShQEHdZ3oiUoCTcsllYkFrUi+55H5o0abtl6OctyF/BWYpl6K7XWa3jTiM3hnv
	 Y1MZLTTn5hCZUGv8KGuVNRFgChXU0Kz5/iY8IdK5+iS/yNOoHs8ZD9FZ8s4nFPTOW5
	 ANMWbwEgdZ7cwVmSoJQiPEWUAK+ghRaqP+o3FsvdpEEP33b5x/JUp5YNoKGT2fEZgR
	 LgEmiNEQGDQsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0615980AF3;
	Fri,  6 Nov 2026 18:07:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FB5E2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0009F806B5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kpYVtjaToEwN for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:07:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E51C80AF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Rxvd4SPd; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Rxvd4SPd
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E51C80AF3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tqdqs4S/o42deKoyns4kZiTcR0QuPgcClTtjGAtzBQ=;
 b=Rxvd4SPdVplreceTASH0SsMMjrTfwnfcNk98iBUgijCOsdvAF6ZPL2jp/XDnymNeG6HO/7CzyMbeKYPaNkaxdSeyc7HeYzqW5wZKcVi6uv63XS7vswceaBTXIAEyLNtHL0HMX16vUqr2VZU5oWNJPTRg7ezscc0uI8N4Sroloa8=
Received: from MA2P292CA0013.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::6) by
 GV2PR08MB9301.eurprd08.prod.outlook.com (2603:10a6:150:d4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.9; Fri, 6 Nov 2026 18:07:22 +0000
Received: from MAD0EPF000008BB.eurprd04.prod.outlook.com
 (2603:10a6:250:1:cafe::94) by MA2P292CA0013.outlook.office365.com
 (2603:10a6:250:1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:07:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008BB.mail.protection.outlook.com (10.167.241.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:07:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tqdqs4S/o42deKoyns4kZiTcR0QuPgcClTtjGAtzBQ=;
 b=Rxvd4SPdVplreceTASH0SsMMjrTfwnfcNk98iBUgijCOsdvAF6ZPL2jp/XDnymNeG6HO/7CzyMbeKYPaNkaxdSeyc7HeYzqW5wZKcVi6uv63XS7vswceaBTXIAEyLNtHL0HMX16vUqr2VZU5oWNJPTRg7ezscc0uI8N4Sroloa8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB241936.eurprd08.prod.outlook.com
 (2603:10a6:250:104::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:06:49 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:06:48 +0000
Message-ID: <f0da336b-86f0-4d37-b920-6a3b2889def6@arm.com>
Date: Fri, 6 Nov 2026 19:06:48 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: designware: Release the clocks if the PHY supply
 fails
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michael Chang <zhang971090220@gmail.com>, Stanley Chu <yschu@nuvoton.com>,
 Sean Anderson <sanderson@brivo.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, nd@arm.com
References: <20261103190537.1096121-1-oss.patchbox@gmail.com>
Content-Language: en-US
In-Reply-To: <20261103190537.1096121-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB241936:EE_|MAD0EPF000008BB:EE_|GV2PR08MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: d16f0f1c-2712-4818-1024-08df3c30cdeb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|10067099003|56012099006|5023799004|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: fDhViL+yuA2wXfq0BgvotJm4HcvfftdoMIjrkB5oQ5JtJiaKp4br9YbuOSvK/7YKnAUPZoTxQel3PkEXhAhIvnGciIM0h2xwzdEIuSwTza00BYVoROe/PExRqZJ1/66sMgKWF05ua7jSxaOiWo9Jg+r5I9L9kuzMI7+WWv4yPWqBKDN6fsCOV+JCVwfqqO3GJu0xX6O4B2emSIWHEES+qKDH3ofMlpdHtu5hh8hJ9zWPWP4qyaEAbk8VAQ9DCqnHQPJLwFRFrlEGtcZoDl1tAN1AtwUDGsO63E9HPojclvAeht2WbOQnZpobNFi3Z+yblHiad4hexjdilR9LOQGY414Y2UNbBiBcvtal3JedLJO1Do07//SIIGzUCt76YzWhnbp/8/lymBYJgCp4+IF1y2HrQPcaBo8J14WXQmDj7YJncZVYrcOrO2m5YnQ+Szj5topVzYW56EYzqFq+iXmuui3Abv3ndoNVAfnP+VD2VhTdsUDDaK/UwdP1Sq/fQAdi88YXr/dgdxoLVJCYx+IXW/UvRxP/uc8tO99zDXEcg3dvZ83zE8q8N/7KeRmL5V+fiLxay8YrzgIxzMOWn6yfCQzQeiixrkY3k2JqMs00jCvGfEBpkYIFGjJTBHLeMhxT
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fqD0EK71vPRTMYSsn5EZ7MP6AZSbo3F7Q9/nzhVHjHY/Au12Hlp1ZY6/5Q8JH9jBPmiClefLBzQ7TJXJ1FRb1ARZP0w4b0Zfre7ltWaN7BP2nAiGral80riaubCwaPn3mlLqep754pW3vgiT6CN+kPEMG79hk9p2w95IJwlNAMCd/3oA4FnvYrnzGOM8fzRfKbudgKt36dk8KWn7nF5DVbF564SH3BmnbHH+Q0EtYyehq9mzwXkQDZ54PqmhApYDqxO/8IXJ5qKyQj5CzZqAgO7JMqIr7Z+/kei8vb5Qu2xZVwlh5mC2750lyuCGiY7MYVFFtlr51D475uf7JVhBXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB241936
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008BB.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 36b9d07e-89eb-4f7a-7cf9-08df3c30ba09
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|35042699022|1800799024|14060799003|36860700016|82310400026|5023799004|11063799006|261026140227099003|56012099006|261021123027099003|261022105027099003|261009223027099003|261102123227099003|261026121527099003|261028144727099003|261021121427099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: nhmPB7aHJ3VBvBGTYbVY8a5lWLrhbNFT0QcByQxv5t1jDJuO1SBXJh9l3pET7HeusaPcRaeeVVzbsAMAKne0tC/mKd+EDIhADUOIcIRmBR9Gy7cWIZeVdQ+wUaIB3jmYNXSNM9yVV/NGBX281B2V3IPF2Rd5ZoTKBJCOepaWDF+OSPv2Hmjf19U+3aYR98WjJki1FIM9RpW5x2H4eWbnn++0YoqEfsjZD8KKvcaTEDV145LAYFsFJFXyp+ncr8nbtpRjpcSPuCmHaGVE/ceXRuavgrujS27T0JuR0PvTKKOVZpGX5JPVsTvzqF4K8fBnbU1kBbf5ekycFGeu5aGSrK1f/Rj9+qlr1Xbv4WgZ/bqnAGeTnqsbRDwr4Ewz2wrKYWASd/wtSdhm3U6yU+cvwQtA0KYM3ijD27gz3lzVtM/S/uNcLPn8aKsvUgMVsnNmCDhb+C0RrTAkbW8ODnavYbibwBPNkTASmsBruPZzoRqcBP1ol6+8+Ltk7BxJQtJUArSTt0EIYE7dmLuV+kLD9MtIL2rg/DNgOvWLVW+CIiCJqpK/2l78kbTg+UehxmBS5o1pqev6hmwvRbxhPZjlW6JmDqoOBaFJwSEsPm4ttZgMOn4XYVmMmRT5TZr7ec3KSrlO9zZnjAJNcG3sBr5fRQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(35042699022)(1800799024)(14060799003)(36860700016)(82310400026)(5023799004)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261021121427099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oEII7ATS88BeOOFzl9SBoTkHO+R/n6bDijwTg2XG6otmw9jIQt2C8V+lIbGRSHjOj1WVG73Uk/wGuTF2sLH9vO8fNHlVqqOqBJRZUHTGrgzhjxg3CTih8ZYce78UIKrCnvlLWCpgbJTfmEH5j5zl3Ga1A54Q2p35t4k2u+2M5ZTk3kpeRxg9Y2edvU/tV6y0mnICtLpeLNTQHCmXqWdYr6jI+qADNlZrMFhznUMyK21xRNgNpu7ZZ8CGG/ojm8R1ch2RuMUcariFvmLmv6n+60eWqjfc8ubxo+QAO2pqez6wqHnCumdRNc26mLfrY63D+5m7ZEjvr3Ho/5J48EuTOTZ2oQ6q7MH8Mw6HHYNfoDqNCYGuZDeqA0LA8b5m8AuQMHaEGbJd4yvVb3N4rw8ruMCpkosBzXytrSZk0MHxXT/clBA+OKgcM8JdfvjBZjGN
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:07:21.9097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f0f1c-2712-4818-1024-08df3c30cdeb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9301
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

> designware_eth_probe() enables the clocks of the MAC before it enables
> the PHY supply. If regulator_set_enable_if_allowed() fails, or on
> NPCM8xx if setting "phy-supply-microvolt" fails, the probe returns
> directly and skips the clk_release_all() at the end of the function. A
> failed probe does not call designware_eth_remove(), so the clocks are
> left enabled.
>
> Go to the error path instead, as the later failures in the probe do.
> This uses the mdio_err label, because clk_err only exists with
> CONFIG_CLK; nothing between the two labels has been set up yet. The
> PHY supply itself is still left enabled, as on the other error paths
> and in designware_eth_remove().
>
> Fixes: ba1f96672522 ("net: designware: add clock support")
> Fixes: 8897f91a5397 ("net: designware: support phy io micro voltage setting.")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Build-tested only, on nanopi-r2s-rk3328 and A20-OLinuXino-Lime2
> (CLK=y, DM_REGULATOR=y), arbel_evb (NPCM8XX) and socfpga_arria10
> (DM_REGULATOR=n), with no new warnings in designware.c at W=1. I also
> compiled designware.c with CONFIG_CLK undefined, since CLK is selected
> on all these boards. Not tested at runtime: I have no board where the
> PHY supply fails.
>
>  drivers/net/designware.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: designware: Release the clocks if the PHY supply fails
      commit: db5a66481335850a00e74932c8993fb5561b83cc

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
