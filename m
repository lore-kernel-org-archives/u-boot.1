Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEA606A329
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ek80mLZC;
	dkim=pass (2048-bit key, unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=JqHkcV9A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05B05607A8;
	Wed, 21 Oct 2026 05:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBcNKz0nPdw6; Wed, 21 Oct 2026 05:45:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA58F605FC
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792561500;
	b=Ug743QuSxkH2mOwgQzsQLgbw475b+8gxtPAjjq0VpvU2Nvs/xNehjRrnYtntmh3G9Bl8
	 xQITXAGGBW1/lrmksnChqistRBXFX4DJ/nrALlAWg6Ws5qzwheo4ktD27obLJIp7uW9hE
	 L+qh7TbhrihsSg10SIdUBuWoK0ngZ4682oYdHarUAptxTF59T18w0qqjIZ8/aBdJn0/uo
	 Duqg08gyGbCcgNHlsjg7aacPFHFdzq/zdZPc2LK2CVUYc61PIxnQPuLRHcDpG93uPJmrg
	 ZXLLevJrbf0eRDmW3AmEDL9BC8kQfxs0fZylmoriBTRgSLJ4BnU05TTz1AcSHtpgISQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792561500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 Content-Language:From:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
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
	bh=0lXa2nc43yK2rNNbCaYkCxFNnbmXdZn2FmOA5Dl9WxA=;
	b=DxwXRM1/9fgbigfX+09Vk8mMQIQUJ/W+8aPYPyj2fhhGXo+jsT16ewRRt1IJVdUmfft9
	 53S5TQq+Vx0vC/K+D1eqRTZnvQRF5qmQzMfmVYjxt3miHat8WWKOgH4W4Zi1icR4pGneu
	 wFFVaGhjHPGJ6r0hH1aZEHq42x2HoBoD+9lAnwBvVSiPLtw5GHkEZoxU1K00CwmsrhXV4
	 iNRBRExQ6X2ojzMETGPlZCRp9u5xgkHvxOjO+GyXldy0eCYGN/BqRQRJkwDOMMajSbfpF
	 0abDrjpJUe+tG6Zi2PCUVMNG3lbonT1znsEmnpS09t6/dwW9u1ffw2yUksuxa1tYa4g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792561500;
	bh=0lXa2nc43yK2rNNbCaYkCxFNnbmXdZn2FmOA5Dl9WxA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ek80mLZC2LiZcRpHuRG1Ez3vjggqrM0MzPvF/TisIgx1enBQbTPTuamG/vZnU7Hr3
	 wFO/kPkXIl7cdtMvs9UUSayJeqvbDmPXa70zvFqF6YRv4y7eHPPBZY5/VhTe8nxGMa
	 IdmWIw0OZTmWrbQqa+5DDYDrxTtcXWkfJCyq/UfNMedDind9a4bpCWUI1RpmBPSchU
	 GiplpR2tlmpoezz3t7XXxjJYumGTcSP41oqFoXx4/UpnpilPOjclZoGeRw4hDN7mIW
	 A1IKUByyxwm8Upoj4feBy267+UnkvnOdTsSrvxpw76+Cm4VdNGIilx4BaU6DeWxocF
	 XlIp6sNiwR69A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA58F605FC;
	Wed, 21 Oct 2026 05:44:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD9BA2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF0738100D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9mGltdRybVF for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 05:44:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B70848101D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792561497;
 b=T30bnHeiquO5aGrKiJDFzQ0em/JuaXJ4hfPtySuLiT3H/mGSO9cV/n8QauO5CbCPHkKG
 raCDZ3f7PEuz/Y3PHNpcMGzTBSIS5T2vxjx4P+nhMpqFWelIotf0g0Zhsxx2XFGB/N/ol
 xn7mGJbGQdVocVhR0SStOipEhA6dvBjnpFm9LJsfLGPgEPf1nlOG4NHpURqml3KuYDK3C
 gBaeZ+SqgiN7nUUWQPsbA0gS2BRMiqlymvx3Yy+gqGF93QAkj44Rv/49zgtiswzP+2Q9L
 f8Mxr6oT2DyOX+MBVh9341w7pLZOY6Cskoy3BN0S9Chkpw8w7+bK32sSQOQaoYV/JHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792561497;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Authentication-Results-Original:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:Organization:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
 X-CodeTwoProcessed:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=0lXa2nc43yK2rNNbCaYkCxFNnbmXdZn2FmOA5Dl9WxA=;
 b=MCcA8bVYmNfOkzaMdJ6lGoED5AFTc2lff3MGQorRbLFAVt/mfI0IyDFQpC0i752z2mWX
 ZC+a4B+bYQulxI5BFyQ4ol11ufISWTlWbjm0roIjHF11J4/N7YtHmrU/ppOxTCB/Tc2ya
 QxHx0OtCGds7JyioNi/ZV0emBHRrJX8QQ2uDWpMJ/ERdQ8bVEsE+JhucBt32R9WTSRVJJ
 85wwriykEh8P3Tnng0gFB7FyziPLDg2uKGOSKeZGL6+RfvsWTnu/o0SBuX63L5/KrIfPn
 h6Wky1ZX0bej33PhmZt1CbHUSotgnfx2Xe8YwdNj3Doa8jg+EIAC929RWf7sGsqbMQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=topic.nl;
 dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=JqHkcV9A; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=mike.looijmans@topic.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=JqHkcV9A
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B70848101D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uakJgaiQaDmRwWVblDSMPY3MKMlMd/t2F2Tmzr5/oosdn12QOLDPJ0oFIpqjLbTwD28FX82ZnF6MiWw9lTov2tSZkXYeRxllCSewd4UExuAPDp2qdU0070LZDLyDYxckRikjxcF5mgKl4mhzB0r3N2oYKUG/UUe/6t3aynZqHBNjHi+J3dxlnVL/byMvN55/L5J724mp+C4tVQnTyce5EHndDk41f29e80j/Ggkr1/dY2rq282OcYX0UE6Kw1oE7Y8GVM6jcMwPMbEgwh5o9urtc87KsYB9kLgfcypudXGIQG79BM1jKedisWKgtAT/FlOyTc6mVvu0lEQKZ2xqL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lXa2nc43yK2rNNbCaYkCxFNnbmXdZn2FmOA5Dl9WxA=;
 b=H8UmqhDXmc+JMi0wbqi3EyF89eEyKWFl9ZABZV4RTyKHfouJxZId0Bv3Cc983Owjkjh0KRwys1p0g36yc3hoTp5xRtwA64sXao1V4JGjoHL7xnXC125O7ls4ROR2Oe51CDDkjuq0G6R9ptaqjLkQDVMzrHNmzzD3eHDD32zIOKpfLoGt6E7pQUyfUl8UZbNa34XwyKwk9llBM+t2GVP1zT1rZfUNgHUo7Wr+dMFFmpstAh45N9nkeMApLazq0ztUptqvvsq8jssE2qdmISlgMaXHpc9kheoYFYoDXlM6BMDD6MevZlOK1RPiDDvBIUcRXrBpAosCH1zAXS0WxbBwng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=topic.nl; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=topic.nl; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lXa2nc43yK2rNNbCaYkCxFNnbmXdZn2FmOA5Dl9WxA=;
 b=JqHkcV9A6wQP61nsDzOypMZxdjovaM9ivRZQ93M4BQBiIcxgBQrQ5h1zi0EQVV2nHx+yU3+Xn2PMagAJydVXTPjRcuKlCS+k5IHDSdbO+Jd21sNnh9jUz8XOHVr0jHv3wMziym0/EbPKd+lYtEGt3yfF8LP0lRmlLVFGj53ZoVgwj2rKLDacHm7eSLrpNPcLpG8c/5vGXLkGwRB3IxJUR0n+dCFmtSS6vV2dAXF0kLfsBc/VTiHeR03QSGx8iBtwnTpwrPukmui3Po8RB6J2sOru/OCawEpZpgmZ3jYY4dz7hFbfdOhRD1xBkOE2+3Ws8WvseheHpoUXEHjxV+QNFQ==
Received: from GV3PEPF0001DC28.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::111) by VI0PR04MB10292.eurprd04.prod.outlook.com
 (2603:10a6:800:243::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:44:47 +0000
Received: from WA1PEPF000099D1.eurprd04.prod.outlook.com (2603:10a6:1d8::169)
 by GV3PEPF0001DC28.outlook.office365.com (2603:10a6:158:400::111)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.12 via Frontend Transport; Wed, 21 Oct 2026 05:44:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 WA1PEPF000099D1.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 05:44:46 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.71) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Wed, 21 Oct 2026 05:44:45 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by GV4PR04MB11426.eurprd04.prod.outlook.com
 (2603:10a6:150:29b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:44:40 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 05:44:40 +0000
Message-ID: <7fe6a107-21ce-4259-aca8-5d6deed091e8@topic.nl>
Date: Wed, 21 Oct 2026 07:44:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: xilinx: drop bias-high-impedance on SDIO
 CD/WP pins
To: u-boot@lists.u-boot-project.org
References: <15d2705e0807fef7567df21ebcfe48aa7f1466dc.1792505922.git.michal.simek@amd.com>
Content-Language: nl, en-US
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <15d2705e0807fef7567df21ebcfe48aa7f1466dc.1792505922.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR09CA0006.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::16) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR04MB12030:EE_|GV4PR04MB11426:EE_|WA1PEPF000099D1:EE_|VI0PR04MB10292:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d90455-bcc9-45a9-421d-08df2f366a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|261009223027099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: +damtiwNXhlnRlctmXyNUQbgcVRoYLdgfoMamIRSqpSvND7DkTdt30Qfno01PfWVmnnmwMddojrRbpLpiu5zVYeGNXv8gmRMWbGyqja67SxXnXqKLgzzFtWyveHRPQD54LceA2lLkpF3S6WAEKHvsrVcIT/Cog15ohl1S+hngFrGaWgESNkvkGfJD5T4QGEY4Sx8QPTm35bkxX7el9H3cdTFgBDkkFUjx12YX+znUpFUbqBIuAhrrNV5wrSE3n/ErwyYEbdhgp3BFq9bv7wf3mxqyiMqbtJZZ2onpV5yTBYtWqysj+sSwTRfvjcTJXaNafTCnT+30baeCsqkUo1tSQ5N2uTX21Kea6CphYUA1Rwr41vokDjFzFSRi5N5hCDSsYO5LVFQwvZgqN80dyM9RvMwvK+AHhjytrBCV4GOsNTyvOQ6/Fj47UAMKCk4AojOm/xNX8UKYYtgKpG0jyZDfQgaXkkNI1bHjA/ov0CdvKg7VjcayIApM5nP09X7LDrRq6MYF7g9qenECqiyZYubU+zCIGQQjBo4yzGr8oSuQS/HxdNRQhZNlP/xGpXF6EcbW0giXDB2yOX1zWVbRdXPpPmjXRJ1U+mAEkgNf8kKBOM0dmzENFHAK6e50M/b2KbRjuyH37RbnF85dEe5DBgUzkDnr3YiTZUvVrfAGnYWc8E=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR04MB12030.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(261009223027099003)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: icci/81gu+L4nW0fGzAfg3mnp5iA6iw57BtWdduvIE8eM+NEYp3+jQ07FRiAWCHEEIFJe8U6T/uQ94t3GK3ZtCXfNPfM1IbUcq6f9fKAx/qLGeUhQ8emXxr4rCYenHHtZW8cHsP7P0FtQvKCcpiptNAPFRdMAWblx2v9+PJHLDCNKIqwgotZgjlRc2UMDKXZ54ttMefYkcJLW8f2pRam0uqD5JVvVcNJZBqlqowuEHi2D8hbIA7karcrDNBD2GlFVg3qjlgPJq5s1/3uTi3+lbo+mapC4sS5nuF0lm+b3j2ykzFiIbgej8SjWrzfnMFA8XRkgSYSt7eifDMi1llAqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11426
X-CodeTwo-MessageID: 6624051e-dc9f-4f0e-9fb9-2181668819c9.20261021054445@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099D1.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c0b2fc10-f5b8-4a88-8819-08df2f36662c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|82310400026|36860700016|1800799024|376014|35042699022|6133799003|22082099003|18002099003|3023799007|261009223027099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: jL13kpdLN/obEOA0+9uJb2+jeY6VAeyVLsXU13m7682rPsBmvqDqudVAnuGMD7CrgjHCmjkR8fllvkQ5pX64qEz45o6QowELa5YViCRyZqU1Wq6n5gdEcApJ8kFrMhGX1Ju+QahYiishfRsfjAClIm3e1VVVvGCd34aRz0eIRtIsRwwJAIdlTxIccvODTQTvB895loO8luxoCdhritaw14N7ILSCgdaN0BpY15q2HDVCYp96eJp4EFDDZnycb7qHNhtE5NV7RoLj4mNKkadVPy0vjuNcui7g8N/mby1rcL9WMF0saV2aMo7imSnUifWe2KLcZQzlUxhhvLz4OryYMVuwTi+Dy6dTbWcd8IXuyHUn+YG7DOWOHD7p2SPAd/obIrBMqqTfuCkSwMFjkXjxIjm9i3vbFEXU8HSXvPp5tt6UvLwSoMkZ+QOkVlcxyy9cAnxgX4/0+LgmbJC4r59sg9lbtA2FAXJOr383PrJhVpl8jOhQPdLvVLbrvJ9IAFRAUd8lPVlc2nqGMcCXZBDVAtAPSQxCHd03BVDdN5SfTz/GQjjgGgmvnhvVUIbjSX+frTKGckYraZPtERU4vTc20FCZsEpYUigaCCDMJjwu+5SYc7eFmBaj3eAg9o/dFa9RqqIv6X8yrAdUja4ihjDHr1jQKKuOUBnDH0pSarg+awyLhIzNn4K7513ZKQRoKZw7yTPXIT7SwnELvWoiXQMRnA==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(82310400026)(36860700016)(1800799024)(376014)(35042699022)(6133799003)(22082099003)(18002099003)(3023799007)(261009223027099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o0SHbdUabgm/zyCTvgnN99LrToCCgOKYB5SDwSp4kViTWelJqbWvQMFTyydmnrpnJ3/l2L7tl2In5c5B509QX7Tuotkkq7Y88PQBlZgZOfkNp0MSJBDOtbsjc31Fhit45pFKvewnSpmKXPjK2i3vyMtNO4cAryj1adbP4nc61aQwvCNjWeTVNv7KLq2qHLqCNS4zG+mplsSZ+N8esKZ7ujk3hMler5iTFUqllJNaWENgbS10CmBr/XVjGIiLz1ufWdV/uj83dnxX/Jw7vZ7BiOUIwqVXfFKmxbu4t9JEBhw80TJ04AkVLF+4riCTvJJv1KeYU06k7H6E/d2WHzFyOA96F8i+pfzSDiji8gPISJViKPJ56mAA3GUMqMkh5RLwH3HrnmTnU15OuL798CweW9ppCdrRVzC9tX6n0UP5zSSzqR5fr6js9qg/iZjlbARn
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:44:46.2731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d90455-bcc9-45a9-421d-08df2f366a09
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10292
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 16:18, Michal Simek wrote:
> Since commit 9c105255108b ("pinctrl: pinconf-generic: perform basic
> checks on pincfg properties"), the generic pinconf parser logs an error
> when a pin configuration node specifies more than one bias mode.
> Several ZynqMP boards described SDIO card-detect and write-protect pins
> with both bias-high-impedance and bias-pull-up, which triggers at
> pinctrl probe:
>
>    generic pinconfig core: /firmware/zynqmp-firmware/pinctrl/.../conf-cd:
>      cannot have multiple bias configurations
>
> On ZynqMP, bias-high-impedance enables tri-state while bias-pull-up
> enables the internal pull resistor; these are mutually exclusive bias
> settings and only pull-up is needed for CD/WP inputs. Drop the redundant
> bias-high-impedance property and keep bias-pull-up.

But AFAIK that's not true, bias-high-impedance disables the output driver o=
n=20
that pin, while bias-pull-up enables the pull-up resistor.

"bias-high-impedance" is just misnamed, it might have been called=20
"output-disable" instead.

If the pin is being used for input anyway, "bias-high-impedance" doesn't ha=
ve=20
any effect whatsoever. If you set "bias-high-impedance" on a GPIO pin, sett=
ing=20
the GPIO to output mode will not actually work.


>
> Reported-by: Mikko Rapeli (Linaro) <mikko.rapeli@linaro.org>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso   | 1 -
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso   | 1 -
>   arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts | 4 ----
>   arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts | 2 --
>   arch/arm/dts/zynqmp-zcu100-revC.dts      | 1 -
>   arch/arm/dts/zynqmp-zcu102-revA.dts      | 2 --
>   arch/arm/dts/zynqmp-zcu104-revA.dts      | 1 -
>   arch/arm/dts/zynqmp-zcu104-revC.dts      | 1 -
>   arch/arm/dts/zynqmp-zcu106-revA.dts      | 2 --
>   arch/arm/dts/zynqmp-zcu111-revA.dts      | 1 -
>   10 files changed, 16 deletions(-)
>
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp=
-sck-kv-g-revA.dtso
> index 45396e420433..fc8d3467198d 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -403,7 +403,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp=
-sck-kv-g-revB.dtso
> index 22faec35f793..80d1577c92bd 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -394,7 +394,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynq=
mp-zc1751-xm015-dc1.dts
> index 2897c423f82e..7942e632d047 100644
> --- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
> @@ -285,7 +285,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio0_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> @@ -298,7 +297,6 @@
>  =20
>   		conf-wp {
>   			groups =3D "sdio0_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> @@ -325,7 +323,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> @@ -338,7 +335,6 @@
>  =20
>   		conf-wp {
>   			groups =3D "sdio1_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts b/arch/arm/dts/zynq=
mp-zc1751-xm019-dc5.dts
> index 722b2e833b44..34b68cbc1e9e 100644
> --- a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
> +++ b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
> @@ -285,7 +285,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio0_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> @@ -298,7 +297,6 @@
>  =20
>   		conf-wp {
>   			groups =3D "sdio0_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zc=
u100-revC.dts
> index 81353b60b38b..2ebba269d208 100644
> --- a/arch/arm/dts/zynqmp-zcu100-revC.dts
> +++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
> @@ -337,7 +337,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio0_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zc=
u102-revA.dts
> index 4d5f4754171f..1af7b889cbf5 100644
> --- a/arch/arm/dts/zynqmp-zcu102-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
> @@ -947,7 +947,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> @@ -960,7 +959,6 @@
>  =20
>   		conf-wp {
>   			groups =3D "sdio1_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zc=
u104-revA.dts
> index 4479ff735145..b03774bba937 100644
> --- a/arch/arm/dts/zynqmp-zcu104-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
> @@ -373,7 +373,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zc=
u104-revC.dts
> index 0f1b1fd92a70..ec1b9168a1c1 100644
> --- a/arch/arm/dts/zynqmp-zcu104-revC.dts
> +++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
> @@ -386,7 +386,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zc=
u106-revA.dts
> index ad76159084ef..5a5d3884821c 100644
> --- a/arch/arm/dts/zynqmp-zcu106-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
> @@ -946,7 +946,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> @@ -959,7 +958,6 @@
>  =20
>   		conf-wp {
>   			groups =3D "sdio1_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zc=
u111-revA.dts
> index a9a473602374..e13e93847bd8 100644
> --- a/arch/arm/dts/zynqmp-zcu111-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
> @@ -778,7 +778,6 @@
>  =20
>   		conf-cd {
>   			groups =3D "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate =3D <SLEW_RATE_SLOW>;
>   			power-source =3D <IO_STANDARD_LVCMOS18>;
> ---
>
--

Mike.



