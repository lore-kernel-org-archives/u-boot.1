Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C7606A327
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=idY6u/qR;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=HZ9IWLix;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=HZ9IWLix
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB34180A96;
	Mon, 23 Nov 2026 09:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJ8scsAz8scR; Mon, 23 Nov 2026 09:38:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6B0880982
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795426718;
	b=mWc5wTMglGogFLd1ZLt81pZpl6bMwb4hLAfT2AmQl4v9oLNN+LO3Swum9XpSrM6B0GQX
	 66CQkAw25AJc6QysD81A6OqJ5T+Sw6z4mNIDyDMKQH5x9Bs7OjpybNYvr8d8zgvVnT84u
	 mzHe3fbhqrZgmsdpegBU8RSyUS0F+aOSYk96Dv6nPtjxu/z6lvFMIkHYb5dLZYynMwSVx
	 4qkicKxIdr2C0Insry6oy/wbm6zMO3TzxTmG2/XGQYG/M3BZtdqivc4OeEHrJKyi5QoH8
	 8jsEce1vNRooda+dwYqoMRJLgDylEJ0+ldvQcCEjKn7AEVeYKCE9e+h1nAKl8OCo14w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795426718;
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
	bh=hYosjPwQDSxXz8RimoiH5Id9p3PMuqc4nt2LNSMPsgc=;
	b=kyuzG30Lx/MU1U6fqK9OmKr7mbByNFWL5WwTm36Ng+PBRsuZ5IZSAipqAFoiD03wVOMv
	 qWSHD02fWUj23xtV9qAyLV/+Ms/KffckPqr8eDKz3d13Rmc/VTGQCbx3cwdcxC+IEZlp5
	 TSaTu8a16SGTg9O0X3kZa9oxl0vfPXsW10OiFs6iDCOnNmx+dkyrcGeK35I0XIzQOqfFt
	 6NmNcqaH6f7RmDjP3z7qxCwLL55k/p7NjiidA4DoJsUJ+8B25D8B97cvY+uHK8PoKR+X5
	 SfbkTBzlx2i7C6D0nBRPPSaBdVwu9ij6w+yuW7vcs9cjOrzZfg3L440uAwKsB24kKqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795426718;
	bh=hYosjPwQDSxXz8RimoiH5Id9p3PMuqc4nt2LNSMPsgc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=idY6u/qRi46ZGxkRPR9q0EY/b9sKMfm7B7GZh+l0s7Pr5CRfyePKhNJf2mQgU2xY1
	 2X4Smm8H2puTn1BuDDW4VMoNN1ChKdK9MaIGo465QG8ewSPnAYLpC/2MnqypMo37Rv
	 RY0TJnDokVOe9I8YYFwJiS8fahaNB5r0WsuF4JJe/lBwcoChlE0R01OZFns3Q2JgjS
	 J2GJ9XUds7MXMZGv5CQDp3yL84rk1BSniuq8LQRR+5ODTr24qNDhNaOGcNVO+V9c4L
	 Mwjs9mQFEPqxUPamnfCPcFpGAFg7mREPzA1DwqKRhMIFBxrrCBBRgbXfRrVAoFMAS+
	 fMXL7iJtaCWaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6B0880982;
	Mon, 23 Nov 2026 09:38:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 609DD22B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46E2140098
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWM3ChOnTm67 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:38:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 05EAC4005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HZ9IWLix; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HZ9IWLix
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05EAC4005D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYosjPwQDSxXz8RimoiH5Id9p3PMuqc4nt2LNSMPsgc=;
 b=HZ9IWLixXcx4RDodGLhVdG+hTBFeKCyuIkewfL1lQbUtLmAAyZp/QMtLZEBvJYl6zXH/dl/yX20i8DtQOOeHcSSvIMPRw33a8NV8rRot9BpbfyIXbyyOb4I9GbuT8C56hJobgbhin9lyIeIAnTZhgxQjI//AzrtFtNA6iKjcfzo=
Received: from LO4P123CA0332.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18c::13)
 by GVXPR08MB11225.eurprd08.prod.outlook.com (2603:10a6:150:286::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 09:38:25 +0000
Received: from MI3PEPF0000855D.eurprd05.prod.outlook.com
 (2603:10a6:600:18c:cafe::2e) by LO4P123CA0332.outlook.office365.com
 (2603:10a6:600:18c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 09:38:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000855D.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 09:38:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYosjPwQDSxXz8RimoiH5Id9p3PMuqc4nt2LNSMPsgc=;
 b=HZ9IWLixXcx4RDodGLhVdG+hTBFeKCyuIkewfL1lQbUtLmAAyZp/QMtLZEBvJYl6zXH/dl/yX20i8DtQOOeHcSSvIMPRw33a8NV8rRot9BpbfyIXbyyOb4I9GbuT8C56hJobgbhin9lyIeIAnTZhgxQjI//AzrtFtNA6iKjcfzo=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM9PR08MB6131.eurprd08.prod.outlook.com
 (2603:10a6:20b:2de::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:37:49 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:37:49 +0000
Message-ID: <21942fbc-f591-4202-ab5b-3c9c41a05787@arm.com>
Date: Mon, 23 Nov 2026 10:37:48 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: tcp: account for SYN-ACK payload sequence numbers
To: Shubham Antil <shubham@octane.security>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, gio@octane.security,
 nd@arm.com
References: <20261102110508.76420-1-shubham@octane.security>
Content-Language: en-US
In-Reply-To: <20261102110508.76420-1-shubham@octane.security>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CW1P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:29e::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM9PR08MB6131:EE_|MI3PEPF0000855D:EE_|GVXPR08MB11225:EE_
X-MS-Office365-Filtering-Correlation-Id: ce403c47-9de0-4453-7107-08df494585a9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|261102123227099003|261102124527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: r0yOZ/GfikMgNQTfWW/wmaHlxR5b8OrLAI9kYvD4tYC9ix/mQHsvwYphUze27rFy1kZayidFFKGsQBzGcN64RVkjeHeXob4Ts5r3BNLkhCQtLbI58N6h0BUjw5tXRAPP5iLJI8bVKk+Sg8S4FwIkfQKnpnkpDtyuAJmzr8HRDWCNebQUuZLLtR8GuWRdfn4MJMC8PSMxQkKiBNLLleEFivRGVpGU8vigmBDXEUsEqnn2Gv7g2gsFGxZRZHDEa2vSvn01f3WZ51ryDPZooI8wpjXal/JVKsMx0D1oDbeiVKT5a7IJWQJ4gMb1eX2mGE29pN2IpHTSGFTBQkbZSS4evzF+xxaXzbsxbgImvXCUDZ25rd3myWKpwWanE01hrSTPXc9UcyX6+TeMT3flg8zb+p6KAjac3DfS0JkTCwNyx37dPfh30Sep8AGv9kW6sJC2xp6VbWSxQL7tY6yd5CC4qV/IY1Xdcs2wYcrmd88bA4HK7vsmKbbrrrwwmbZOn0tHAjnYP3lor1bwvy8Ip4p3iGir3bC8I5H0HTND1UubJPeB++TcT0eIOJsqNsFDM6AHUIet0/K/+zjd6rNk3SmqJrup3gKTHavsQcJCEsX3wtgB2ZR7jfXrHwsNtgrx1pTd
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261102123227099003)(261102124527099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: E3ewbkhrCQjX8SOl1oH00mW4cFuYKeUzvog8Grvox/c1EjjTvwI5C+lypvLsbeAdXLdzd2fCXuN1L7Vz7mU5eXm1NtfKzaSc1DQp3ER/opbBL4+Ax/Fu4/odhLwmwS/YtUW0tiG59c4ovtfrHC+L19VKad1NCAd6vjqkIfvO6dPbepT9GX0y5kasa5EmED6ixeKD6WaEwReSxKOPV1Oy0sGuWPql3tDhrqJXWdzLWDSF831TDW+kiwIzF4L5mGxHyDqChOL3ylEfJR7fkBI5yDBfYD4MUwD+dsOiemn9al1qXVF4nd6MEU6DpyEQKszB1P37CarY5MV7wPLCgraYmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6131
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000855D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8ae6f940-4698-445a-7009-08df49457011
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|14060799003|35042699022|82310400026|1800799024|376014|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102124527099003|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: YgQx2q3XdjSBoIFHItZqJ7pYCZVxC1ehMk8Iq6pog5xd1wyUJw5OBrQRzrMG+MZZmFzNxuOXpPJBYXNSvExyYAEaXVKFsWr3yhr7Xh8ulg+xwCr6w8g6VA71Ch+GF43rMBxo3pBViDZUqTRyUYq8EY5UFrsuCgOcgZMzcJ3jRKAlhOAmlOoPtbt1ZwIMah8vZDVwUCy3ukY7H0erKWjQzAkWk4roPckBxIAo0xOQmvYmTx4BlFkoVMrl2JYje1NTYyIQutjTA692kAUDtpdZuBcAwSQOLMUOkCsnCJQBLxS9DDUHTmbSWBSMD1VKDERzHh1vKLahFz9b7dP+eRu0teY1gnHCLSmjPwFFBG6tr01t50t+9+TQqQrWr0ioEsIKQMTcyu5v0Guzov3xXVvMXkL+St4Y/ORgTEbXV8h61vy2T7SGMkP89m80NKDzH+8URpKG11ZhxTQZu6ohrpGDV9tbl5A64wLyI5BDSX53sREo7ifJs09MVWHRkXPMQchDmvKFqvi55dLiTjIToPo6kOl/fDL4G8ZUkBxON853dSm8+93ncOg0U4GcoTssyVJ0gB+TIJzZrCo4gZQH0Octf4AKSDw371+Z83dPm6PGqfiqOlB5XYiAztk7GBlqBP9R1KW/IuCONQZ+OgpRniKdxUSMN/G4hVOr+E+Dj+u2BJk=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(14060799003)(35042699022)(82310400026)(1800799024)(376014)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102124527099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ehRlEWj7XfjHISfjYh0vzQljONj+sbFKg463drPYXiVZE1NOrGh37hphMIDzjUDOaAeQBgevERaJMben50y8F/uozXYUJtmgi2QyxslhtK8EF9Gdxfg0LpSTZ9798/nvbdMjy61KalQEE/zZWUWCLYjCxXdaB0uflLD8nybk+yPoZhDonhJW2RNXN5RHAUoerHBZysCREhNqyVljL3VnOq7MXosbOigqJFle0opfp/nESw+bpwLeCYbFenwe2EklaHUEWK5A7KwA63yNyfmAOeofcPAOuOCPvG0Y9ip4ol4f4b5B4g+dIf5FmVEgagXeP5c/SArZHH804uvthjPAhQRA+qPvJwubsrTk8AUeFUQvd2cTv+THYoOytp+o3bAJY5a7CnbuBeOXV7hbGz6bnZX/PIB+nuc3H2jUG3MvPQqkQ6YC0GWEv31tANOeNot
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:38:25.2030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce403c47-9de0-4453-7107-08df494585a9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11225
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> A SYN consumes one sequence number. Passing a SYN-ACK's sequence number
> to tcp_rx_user_data() for its payload underflows the receive offset to
> 0xffffffff. On 64-bit systems, wget can then write the payload almost
> 4 GiB past its requested destination.
>
> Start SYN-ACK payloads at the first data sequence and drop data before
> that sequence. Validate the TCP header length before deriving the
> payload length. For wget callers that set buffer_size, compare offset
> and length without overflowing their sum. The normal wget command
> relies on the TCP sequence correction since its buffer_size is zero.
>
> Fixes: bf962de97c37 ("net/tcp: improve tcp framework, use better state machine")
> Signed-off-by: Shubham Antil <shubham@octane.security>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Cc: gio@octane.security
> ---
> Tested on qemu_arm64 with CONFIG_CMD_WGET and on sandbox. A SYN-ACK
> with payload is now stored at the wget load address instead of
> wrapping nearly 4 GiB past it. A follow-up HTTP wget of a 622-byte
> file completed, and the bytes read back matched the file. The previous
> wrap-write sandbox check no longer observes a store at
> loadaddr+0xffffffff.
>
>  net/tcp.c  | 9 ++++++++-
>  net/wget.c | 6 ++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: tcp: account for SYN-ACK payload sequence numbers
      commit: ebda987c6ecfe1cd609ce37e036c2938bc3c98e9

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
