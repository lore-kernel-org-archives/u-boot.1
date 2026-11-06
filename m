Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4B9606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q41ZWv2/;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=kI8nPF31;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=kI8nPF31
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 910A381426;
	Fri,  6 Nov 2026 18:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5m_1PcGoki72; Fri,  6 Nov 2026 18:09:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B60EB813F2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988578;
	b=XQJn9R7iq18k3vA1liGmOcst0HGBZTL5U/tjG9+xm5SS86Cc3YJKH+m9rvYiJ36zVyeR
	 dZ/g195WJWpjMyyMsVJ0gLDHbwHSgTDm6xOrjPQepC+wE9nwI6Kl3Q/4XCNI98qJxIxr+
	 jRxmKdtw3I42NimXksmTX2vN1EeN/C4YM7m3bubcKa4Q2FyN4WHzFmYjt8gvZpz/TkFUH
	 xoZDoiHc/SEWhJUhe0BRcvR4IbfkLerSRBiF4S7Sj9gQxU809uGldp69N6PVUT1RoQE1v
	 6FWugXvDnsaHkOXu95voERpmIdadRjpckwA264Eb/nSpFFJr7dWZwKhACYZxPrsdkUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988578;
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
	bh=mDPe/VC+ubA86CaNKdx7e7JIIyIqRhygksSbq2qpkEg=;
	b=GyQAfrjmGs229rgtwAT+msbEuzWffBLddIJSrbujcQuGb2rrftJ79sG6ENusYuXZbGPi
	 vOdcNrUEqlVbf9Q4rsX6bhl1fTQDXgTd8NDO4K3AISOCFBN6auxKRWPz+5aKNFkjmOMGl
	 URKt8braluQY4twFY6yZjj5HET+QRXd2KuOyyFrBaS0YoLcAsAnlbErkkqZDlwprQ1W6u
	 w4ieFGBVvkzIwkXItgVdZRcl4aPzwERq5ZtsFDjQsFVXf7yDc25sIZLagk74bfb+YYcka
	 7p3iE9EUwhBNpJ84/ZoDqyAcU14ZRY/jntB6r9QczhAMh8cfV3PBOOihvGm8jRNCgUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=kI8nPF31;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=kI8nPF31;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988578;
	bh=mDPe/VC+ubA86CaNKdx7e7JIIyIqRhygksSbq2qpkEg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q41ZWv2/J+/ninEjFwUMGUZmQiBTTXjadm2lAea2X/drZHl08LOBxaIRglZREX1rx
	 2HTAZWV1oOQpqdo6uo40LpHfTa1129mX3FXutZTaVg+JOlYTsuCJ6/196XSCTyMmgN
	 WyX+Pyn/dCsVHsN5/0TaE4ZhqU9eS5wrQMDSQ9EQG9cTeJAf4aKz7baKNnPzjRwv23
	 HSkfMb5LgsAsOs5S6IhF47mNqq7Q6QhOv+P81zmSXKwnwnw2t64NPlqVzpkBq2WLEo
	 UgvOFaU3Edp6PrCjtaamUOEaYJI6NawHz9Iqu5bCWADpDGQ/e62rc/L9R/hoX+ErMK
	 p9odfEV2v05kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B60EB813F2;
	Fri,  6 Nov 2026 18:09:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 327432E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24003813F2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kC3tkEuLBGhP for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07098813EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=kI8nPF31; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=kI8nPF31
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07098813EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDPe/VC+ubA86CaNKdx7e7JIIyIqRhygksSbq2qpkEg=;
 b=kI8nPF31WzJzwZiMvkEPjpM6M3Z8rmQMud7l2QGqdv8n8AW+N92ezYK48ruttJfF1Y7qJ+27oET5ShkaFxvrhWTqbnaFhbV6E37RSWurkWymJBEFazrs+HMkBkbHm182pY4JDrJiDfBnt9HGvRRipn9ZVjvbg87UUpNKZkAm+bo=
Received: from PR1P264CA0071.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cc::8)
 by MI9PR08MB350618.eurprd08.prod.outlook.com (2603:10a6:290:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 18:09:27 +0000
Received: from MI3PEPF0000849B.eurprd03.prod.outlook.com
 (2603:10a6:102:2cc:cafe::67) by PR1P264CA0071.outlook.office365.com
 (2603:10a6:102:2cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:09:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000849B.mail.protection.outlook.com (10.167.240.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDPe/VC+ubA86CaNKdx7e7JIIyIqRhygksSbq2qpkEg=;
 b=kI8nPF31WzJzwZiMvkEPjpM6M3Z8rmQMud7l2QGqdv8n8AW+N92ezYK48ruttJfF1Y7qJ+27oET5ShkaFxvrhWTqbnaFhbV6E37RSWurkWymJBEFazrs+HMkBkbHm182pY4JDrJiDfBnt9HGvRRipn9ZVjvbg87UUpNKZkAm+bo=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB4PR08MB7935.eurprd08.prod.outlook.com
 (2603:10a6:10:379::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 18:07:32 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:07:32 +0000
Message-ID: <d2adbe10-b90f-4877-bd16-84767b2c6cb8@arm.com>
Date: Fri, 6 Nov 2026 19:07:32 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: fastboot_tcp: act on a command that succeeded, not
 on one that failed
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, nd@arm.com
References: <20261022-upstream-fastboot_tcp_fix_b4-v1-1-df51bb9e972c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022-upstream-fastboot_tcp_fix_b4-v1-1-df51bb9e972c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB4PR08MB7935:EE_|MI3PEPF0000849B:EE_|MI9PR08MB350618:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f363cef-5b66-4f33-30d7-08df3c3117da
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261026140227099003|260925021311599003|56012099006|260925021911599003|260925022911599003|261102123227099003|5023799004|11063799006|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261022115727099003|261022075727099003|261028144727099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: LA3+T7qLeZGOQa6ksTcg9RpSV9zE2OpPFNBj7zAnMKRv7BJXz2UfCU9gsd72M/z+zf36E/kPbnykchFIy+hfd22y/qPdjivkgBgPimQWAbjwqeYSwjj3EdIeplH4ZdAS5KxLoUBendQ6R6rA6gRxR9w2CIZf47fCohfdrxr18V/SflpbNALh7vczZYoxUfasC0Tp8ApMfgx2E4TxH2TJGIzmnDa81XTpeb37CSFYeKEfGiAoTh0fFEbsqDTUb6E8uMLgWGIBV8Vk+Z0N/CMzqMbkKMTRQnIjgNB6fn/x+ghxKn+DsZ2ib2h2VSKz1IDk9CU+dEDEuCnYObSSWwhWxO8yYsaZCTRtuG5xxlDeS5F5M2OgT3sjrRBMqOtoyFQ6+nde7gBfch6efAAKIIl2UvGW00F8SMhyhq1srFdubKSQfWfGpbgx/+yVmWZe89mfvJ+r7GBLq1t7lJ6TIDkUn/eyS8JcqfI755Sy1x/j6KHGP+QDEOWMkjBk4IKnHGQn15dsxbWBUm+WOQSB1HauBPvUHVbvlL0IWThA3/TxKCHRPzXENA5RR+yvoew0W87z+hgps+Yk0Z3xQUMK7XybANm8Tqq5EMmCRqx02m8p4FI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026140227099003)(260925021311599003)(56012099006)(260925021911599003)(260925022911599003)(261102123227099003)(5023799004)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261022115727099003)(261022075727099003)(261028144727099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: f9sV59sDRf/CH4tm0QlndafBKAYmt1s+5HjWfXB/XVRNZEpGdmmmDyFFe571rK8SKzZKBwcKUeiRFKccyhHOUwFjAM2GeIIfCHCWMybRadLO/eE3CpfQ0/S64AxqSxdRfRnZNrY1Sf542sRj2XLRMgFZXysBqidDaTFym5GZ2z8com3VZftEOZcjRoc7V/lshWKG3SyTRPPFEcalzdJTqJFwKvg/LpXlmaThnyhRMCGOtj6I8sz7xHzdCUmP03qv2UhewoLHAn+G0SMHOVLfxtPuthA8Dqpmuf8jyUeO8GyZNZRmAlvK4i6NSooFNRNJluSKZYGiu1wuAyNIzOZJaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7935
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e4c36d53-9ba4-457b-f9a4-08df3c30d43e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|35042699022|23010399003|1800799024|14060799003|18002099003|22082099003|10067099003|13003099007|56012099006|5023799004|261026121527099003|11063799006|261102123227099003|261021123027099003|261028144727099003|261021121427099003|261009223027099003|261022075727099003|261022105027099003|261022115727099003|261026140227099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: XJscgLQYXxl/upKaeJCLmPJxLAaKWJdjYm6Y5G/c79sCydRFuoUskZ/CCLUC/vjjBoptr70mojctbK8zjdU7hDInSOpBhjOq/aBAHqD4OcBskZtGICf9ABrnxmGEj2GhQ1ESxRxR63Mfr/IZnBmvBEJHTPoHdzpxqtGf7cvW4dr/nftFSn7RxeXUdQIhnqJ9bplX8WsuDjT2eQvJbqD+elpbtM+p2ateGNnKoTKDyWmlAuAazRzKNIduYoi741resuTVyi3b/Mn1AZrjw/BuwRaELiIv6SatPq14KebfIBDwULchWl8sw1ouVDs5Xn1wu0gpvjgy0VHC1RIUFQ8UOLJbSrQYn6PRfEF/RCJyuJGVt19omR3g+dJvLAVERcNhGNs5jhGnmwlrJZHa01W6DuY9hy3tzQ6pjs/s5zy463x5W4nOEtuEjgqV3miFPhDzXs/isvcMAg00GByv/hq0nhEdK0z4sX8DA1u1anGs+XO8mnSek3JP0mGs9e8KnpgL4A8Gu39Bfksr0VnK9fKWgSywAIXtkTYXjXxC5LX0ItlbnE1MOVs4pxcWhK+eP3EeDLuOaT8cCMXqDl28bnG4Ct0IbatN/mrDyFCTv+xd71xtJ4QjQLOaLgIemVy+reUezKSSZpqe8PWG9KuhtHBYYA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(35042699022)(23010399003)(1800799024)(14060799003)(18002099003)(22082099003)(10067099003)(13003099007)(56012099006)(5023799004)(261026121527099003)(11063799006)(261102123227099003)(261021123027099003)(261028144727099003)(261021121427099003)(261009223027099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jHfd+h7bOCnHPoL1XuKH3+FfN1kdJVV4gDskjklaYoWmLhxPEtpGI1Ite9tvL1h5WZJCUIHkPgTKGdv/FDhw+4Hiei8nwaAO6CvRLeP5dfZMwMnNtdLEpZiuWPN0ers3STm6IiFE5i7SnfuXs1h753Zs29f4iO6nhvz4t0cPIdIKe299VB5T/zEbCth8iRqzPn0FvRhYEscY574lUwyS/+W1bx5OvlR1ZKvy9dqd78EBpysV0J6ZaBr5OlupAUp75jWBrikITOVGXIRHqrNgUkux8pMtlutNyYDLlTfo3DVM6QZjLL0fLgQ3TcX9n8jauM7M89oSOTfQzA5dGLe7JWRhD32v7UOkCKmPRw7l62UgEWz0xqV/u2dEmLJAMOgVQXEucxR0GF1RCzf9EzlRqvCtOlFOKTpOdAlNIdlqLhicXJhr5aRGYSAnZRVPMTNp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:09:25.9433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f363cef-5b66-4f33-30d7-08df3c3117da
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB350618
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

> fastboot_handle_boot() takes a "success" flag and boots the downloaded
> image, leaves fastboot or reboots only when it is set. The TCP transport
> passes strncmp("OKAY", ...) != 0, which is true when the command failed:
> since the TCP rework, "boot", "continue" and "reboot*" over TCP do nothing
> after their OKAY reply and would act after a FAIL. Pass the comparison
> result like the UDP transport does.
>
> Fixes: bf962de97c37 ("net/tcp: improve tcp framework, use better state machine")
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  net/fastboot_tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: fastboot_tcp: act on a command that succeeded, not on one that failed
      commit: ce18369dd0620f51f10fe0dcba3d2a0586898290

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
