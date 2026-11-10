Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4E606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0x2BWe6B;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qpZXthS3;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qpZXthS3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21BC980E1F;
	Tue, 10 Nov 2026 12:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DIemmq_iLGz; Tue, 10 Nov 2026 12:34:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA6E48121E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794314074;
	b=EbAtFQjOTEy0E4oSe4LrxVr7bDIGuxA/zbKVHOw3qHbLtb14MsWRnJqWZyusuVmbTcS/
	 VBtgdhas1jm107MmvN0ZV+irTGif60t6ca3qwB6UTy4NLJXMNKucmLUq6UZbtz+XELoOj
	 hPuRkZ5LEu0+3VMi5GlqdKkDzAiX5tYV89wFNBi1CTWT9TPOwLM7SfV7+lhrrVtDGCgo5
	 halgRHtdku+xe/bjU7+vve6JAEHcGARMGOumI5f6re/iM6XotjJvCTvfRuCACiTWUijYZ
	 mLZP0phrbnJ+gI6dvJTtFGtwxTHJzJuaYrbTFwe8STi0TqFZzeWFedbHfS23JDaU8PQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794314074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
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
	bh=9MaRLMdo36QDbZtTj6x9f1UGfehtrlykz1s16vsMSc4=;
	b=jr9J0m1dOwHXha6E3Gw4j5VvCWZtDoMtm35JgE3khpX8AprQVJ6zFcS87rm3QyhAsybk
	 ymf6pLhJuexMXsLjBY7f+ehOjdmEXDJdebIguQDngvfLrRqxL0yvhCSd/XZQmNt0CPUry
	 inO7mqWkHRHCFmx5+sPe4G58YHHcXRuOGPvg3MeAv2+iAG1r0EaSrVkh5eCB++OnUHRxI
	 j71iG5AIgkz4teIW2nGoHg8+5kA4V3Nv3u0gy/R9X/Riri+A8pKsPgvSo7nvBEt2Tq9nS
	 /AkToEQyMFURv0pvzwx0H6k4m+rIB736F37x2F5+5cIeXnTHEAqUjFwRLLiPC+SZ+4g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794314074;
	bh=9MaRLMdo36QDbZtTj6x9f1UGfehtrlykz1s16vsMSc4=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0x2BWe6BWtveaCzc0+Xs9aWXCtDNBWPzzEB9C//s/zZCzSUyEzne6E9zzlOYm0Koy
	 zWDujpgIqTsY7fN3BmOsKKEASPwnALZv+byDygvxTp6Tc9ZnmiI8QF8yduP5Ubt7fg
	 z2OfwUA1Fo38BppLx7BkC3nbdeE2d2BegD1o/ttonrD9h6PT6O0EYXg3vXhUHzvBR5
	 W7CqoeRISGNFNu5gbJAf94mc0iweo159xP3hHIL+BCC13qX7017s0KRjxWj5UyAKyY
	 nnteq2atTXlotbkCGVUAtjvoTijxW3y2FYyd07/dqIaZ77j3RXpluHUr7T+Ogt2aAG
	 vdi1qDsYlSgwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA6E48121E;
	Tue, 10 Nov 2026 12:34:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 84A1C4B8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 759DF408C0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kufHLCbTQyLz for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:34:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7969A40896
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qpZXthS3; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qpZXthS3
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7969A40896
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MaRLMdo36QDbZtTj6x9f1UGfehtrlykz1s16vsMSc4=;
 b=qpZXthS3cLG/GnEoxRCcXe4QE1tknQ5BIGo/IfbMZXKjMP395rpNo9cAc5bXuySjmGwL8kACqgfiPFA0sseHTBUOMu7g2lsAAGcJ2Vh3GcYU9aJKDxBOWwUoJmuyhzit6XPKF/YZ7y6U8tlgAU5sMwV9acGbGuAHpEL8jPl1tOE=
Received: from AS4P190CA0038.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::17)
 by DU5PR08MB10735.eurprd08.prod.outlook.com (2603:10a6:10:525::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 12:34:21 +0000
Received: from CPH1EPF0000051D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::3d) by AS4P190CA0038.outlook.office365.com
 (2603:10a6:20b:5d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 12:34:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000051D.mail.protection.outlook.com (10.167.241.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 12:34:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MaRLMdo36QDbZtTj6x9f1UGfehtrlykz1s16vsMSc4=;
 b=qpZXthS3cLG/GnEoxRCcXe4QE1tknQ5BIGo/IfbMZXKjMP395rpNo9cAc5bXuySjmGwL8kACqgfiPFA0sseHTBUOMu7g2lsAAGcJ2Vh3GcYU9aJKDxBOWwUoJmuyhzit6XPKF/YZ7y6U8tlgAU5sMwV9acGbGuAHpEL8jPl1tOE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MI9PR08MB877911.eurprd08.prod.outlook.com
 (2603:10a6:290:b6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 12:33:46 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 12:33:46 +0000
Message-ID: <7fdbefa1-fcc0-47a1-a332-4bd6d3bcd6c1@arm.com>
Date: Tue, 10 Nov 2026 13:33:45 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20261110
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0259.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MI9PR08MB877911:EE_|CPH1EPF0000051D:EE_|DU5PR08MB10735:EE_
X-MS-Office365-Filtering-Correlation-Id: c99d696a-eeca-40f2-123a-08df3f26f1ed
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original: s3oYlgzsu6VQ/E+inuo+QGAbjg5fu0khG+kyf6GCOZIwtTdNN8hPb2jJhlvanTGSBttfy5BPvuw0oVdWYQ5FzMILCAFCedXY76JhxQdumpQX8yUner6f3S/cbrJ+CkRW+Kn11y0HtCGfRT10g0IyjweXK9dAHIHeMkPoPkSqyldvELxW/3b3jZIMX4AnMLLKsuYjjCtX4lKdP/I/h4k3wyt4aWb+lPQTMPLcU7oVqD5u2KcfWAkDl2UOOl1I2vPyZWYxbsu0loIzSZOPWWRJ5BQ+tBI1ifcwwL6FVAFa5JHMy7xfcAEVWOw6QxB+ZsI8MdeCwyvcQN+xds/8Vj8NTDmcH/1FUWFvAp8xylqatxSbHF5KVvXuZxAIvvBfCBk+p6sA01bYxllUTkN27wmlf8e9WYK4AWCbb7BUIuwir8VRAve3Kqy/HDU0OI+C4RXUDq0BjeTt8qBQlN5hkSyQYOm5OtVDSe0EsaY9RLgbWw6n1I00R2Wt7FKiitzJJJ9csrhy4up2dg5KbPesebiGy9IYn7EvYpgjxvw7KHZAhfIC20bbGn38+Vsxt7CYAMtx+/90OPuSBNXdtVLkPnvmqXYOz5pR76T1Ja9l5YBQJjnP5IyM5sa/kGtCC8/M8pxU
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: VVw+KApif7dkqktS3Sxx18MW9pDZd1i+JDOF1YHXwLD+1qWaiOTSoGwWCA++g5Lhpnq+LKqvrvCy+LmkUnf9OXvn8aOwjm4WtATssPFqdI0NpFsKmpuHdh8EpUyuqSH3T0/ZHhaZ/g3bVPRbwikhe4pEp1auuABIz7HzkNqP20U3aQjWpGDB3r/9utThXc4geQojEZrpu3F01JK29zHsGOzMYsikg7nBVE/oSl5yllE1nR6P2erIbym3e3b5XNBcwzRKrJ4YafzVxDrJDcVfOJ2WZMfPyP2AapHycKC762DsDZLvUKqs8tiQ6ZAlJ0B4CwX0PifQ4w0NZORdCIBXuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB877911
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000051D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f949860-8046-444a-2cab-08df3f26dd76
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|35042699022|82310400026|1800799024|36860700016|14060799003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261026121527099003|261022105027099003|261102123227099003|261028144727099003|261026140227099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: oKRZA2eweXX7Qo3RQrFV6kJVqbsodfjTr/j8wvaXcMdUWNvMWroP3ob6ZBV5kOECv/MFrLFmCePnMZUjgNibecY/oOXYJHkkMIIcFXeRxzfu0PiAQC4P8anLMqLYcDD/qd5psC4npk776xhwqleamNivQk5kWih019wzXOliL8LevbDOBb1npvTj95wou971QLwUFgayxrfvfCrgnoRrutveGmnA9hr9BWMnImbiDpK/+UtP/A+lzUGJ0/7iHHKnmEaIyTIVRPFSNCUCdoH9qjINgSqLM4JOATblQ2fuDBmRPELDM6GS5Idj/dQqrv9NMly9XK0Cmc1Q/rXji9AtZXf0F2ei5fP6kItIyty1atsKjQiwaDp7RrBZ0LQiFfK5ft4qF4aUBAh+hMx1yYA023SeF0Fka/GlJaGA+bsDtiba3b5kG6/kBCInrneFGwtHXQkPNUwyU1MWKbczHJGUFv/nEG7clsp3GWIPR07iGEeGfeKIbEBseBo8Vz52cv5hy//m710EIaodCGmSijhmBYrFd9q0u/bLLccjQMnxxaMGgiLsjBQT7xgtlTebbNNiQ8dORh5PDPxg+e/HAvw9s/z1rfedBeKnAe77669szFyS4RM0oSvtJ94ESjuO0GXsYt/RwV6+PqQrTggfzBGjrQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(35042699022)(82310400026)(1800799024)(36860700016)(14060799003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I7WVXYgYQEE6NB9893qIEQAcOxbMtIN7wGp8bXKIrskSB8b5zF1CR3DIdi05cS7QBCJGwgnS61P+LCp/UuHYYRAKQ/GA+4xtwLhA+duszxUEObuhTM+oT4stsluwcBug+Nrull4XiVauqcPs60eB59smeRm4ITXJHfG++IPmUyT3WcGxXWGqzjCTxyhYbj/VchjU04rvqA4MGtPyc6bL9g6nxY5PV9Q5ncmkxOMMp+V82c27jThdngaJZ3bgbyspxJ5Iby29mSXVfi4a2aM4MQ0dJHqwRPgFkW2vlLG5gSPcmqcGTOE5rdtEcfMjs1djCPD9zIdBQoCep5xGGP5Jg+aG1DsXG7QqH9/l0YmcKDUEqMWqbL6PaQrAFFgXvqJUOjswPbyrxtLDTqKptzRfOkRybzPr36UhPte2Jzm+YNID+ltCc5Vxlvty9XBsEW5D
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:34:20.8963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99d696a-eeca-40f2-123a-08df3f26f1ed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10735
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

The following changes since commit ecdcf9e365df6249a57cd8cc946e7026804ff4ae:

  Prepare v2027.01-rc2 (2026-11-09 15:52:36 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-20261110

for you to fetch changes up to 4b4a9c5f6dbe0a1095c9cec21aa0c553a50e1a67:

  net: lwip: Resync with upstream 2.2.1 (2026-11-10 11:20:43 +0100)

----------------------------------------------------------------
Pull request net-20261110.10000:

net-lwip:
- net: lwip: Resync with upstream 2.2.1

----------------------------------------------------------------
Jerome Forissier (2):
      Squashed 'lib/lwip/lwip/' changes from 0a0452b2c39b..77dcd25a7250
      net: lwip: Resync with upstream 2.2.1

 lib/lwip/lwip/.github/workflows/ci-linux.yml       |   4 +-
 .../lwip/.github/workflows/codeql-buildscript.sh   |   6 +
 lib/lwip/lwip/.github/workflows/codeql.yml         | 124 ++++++
 lib/lwip/lwip/.github/workflows/fail_on_error.py   |  34 ++
 lib/lwip/lwip/.gitignore                           |   7 +
 lib/lwip/lwip/CHANGELOG                            |  52 +++
 lib/lwip/lwip/CMakeLists.txt                       |  10 +-
 lib/lwip/lwip/UPGRADING                            |   1 +
 lib/lwip/lwip/codespell_check.sh                   |   4 +-
 lib/lwip/lwip/contrib/apps/ping/ping.c             |  40 +-
 lib/lwip/lwip/contrib/apps/ping/ping.h             |   1 +
 .../lwip/contrib/examples/example_app/lwipopts.h   |   4 +-
 lib/lwip/lwip/contrib/examples/mqtt/mqtt_example.c |   1 +
 lib/lwip/lwip/contrib/examples/tftp/tftp_example.c |   1 +
 lib/lwip/lwip/contrib/ports/unix/lib/lwipopts.h    |  11 +-
 .../lwip/contrib/ports/unix/port/include/arch/cc.h |  10 +
 .../contrib/ports/unix/port/include/arch/perf.h    |   8 +
 .../ports/unix/port/include/arch/sys_arch.h        |   8 +
 .../contrib/ports/unix/port/include/netif/fifo.h   |   8 +
 .../contrib/ports/unix/port/include/netif/list.h   |   8 +
 .../contrib/ports/unix/port/include/netif/pcapif.h |   8 +
 .../contrib/ports/unix/port/include/netif/sio.h    |   8 +
 .../contrib/ports/unix/port/include/netif/tapif.h  |   8 +
 .../contrib/ports/unix/port/include/netif/vdeif.h  |   8 +
 lib/lwip/lwip/contrib/ports/unix/port/netif/sio.c  |   7 +-
 .../contrib/ports/unix/posixlib/CMakeLists.txt     |   2 +-
 .../ports/unix/posixlib/include/posix/sockets.h    |   2 +-
 .../lwip/contrib/ports/win32/include/arch/cc.h     |   4 +
 .../lwip/contrib/ports/win32/msvc/libcheck.vcxproj |  57 +++
 .../lwip/contrib/ports/win32/msvc/lwIP.vcxproj     | 447 +++++++++++++++++++
 .../lwip/contrib/ports/win32/msvc/lwIP_Test.sln    |  24 +-
 .../contrib/ports/win32/msvc/lwIP_Test.vcxproj     | 116 ++++-
 .../lwip/contrib/ports/win32/msvc/lwIP_fuzz.sln    |  78 ++++
 .../contrib/ports/win32/msvc/lwIP_pcapif.vcxproj   |  81 +++-
 .../contrib/ports/win32/msvc/lwIP_unittests.sln    |  23 +-
 .../contrib/ports/win32/msvc/lwip_fuzz.vcxproj     | 476 +++++++++++++++++++++
 .../ports/win32/msvc/lwip_unittests.vcxproj        |  72 ++++
 .../contrib/ports/win32/msvc/makefsdata.vcxproj    |  76 +++-
 lib/lwip/lwip/contrib/ports/win32/pcapif.c         |   9 +-
 lib/lwip/lwip/contrib/ports/win32/pcapif_helper.c  |   2 +-
 lib/lwip/lwip/doc/doxygen/lwip.Doxyfile            |   2 +-
 lib/lwip/lwip/src/Filelists.cmake                  |   2 +-
 lib/lwip/lwip/src/api/netdb.c                      |   7 +-
 lib/lwip/lwip/src/api/sockets.c                    | 135 +++---
 lib/lwip/lwip/src/api/tcpip.c                      |  23 +-
 .../lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c    |   2 +-
 lib/lwip/lwip/src/apps/http/http_client.c          |  56 ++-
 lib/lwip/lwip/src/apps/http/httpd.c                |  50 ++-
 lib/lwip/lwip/src/apps/http/makefsdata/makefsdata  |   2 +-
 .../lwip/src/apps/http/makefsdata/makefsdata.c     |   6 +-
 lib/lwip/lwip/src/apps/http/makefsdata/tinydir.h   |  15 +-
 lib/lwip/lwip/src/apps/lwiperf/lwiperf.c           |   2 +-
 lib/lwip/lwip/src/apps/mdns/mdns.c                 |   2 +-
 lib/lwip/lwip/src/apps/mqtt/mqtt.c                 |  15 +-
 lib/lwip/lwip/src/apps/netbiosns/netbiosns.c       |   2 +-
 lib/lwip/lwip/src/apps/smtp/smtp.c                 |   2 +-
 lib/lwip/lwip/src/apps/snmp/snmp_core.c            |   2 +-
 lib/lwip/lwip/src/apps/snmp/snmp_msg.c             |   3 +-
 lib/lwip/lwip/src/apps/snmp/snmp_traps.c           |  24 +-
 lib/lwip/lwip/src/apps/sntp/sntp.c                 |   3 +-
 lib/lwip/lwip/src/apps/tftp/tftp.c                 |   2 +-
 lib/lwip/lwip/src/core/def.c                       |  23 +
 lib/lwip/lwip/src/core/init.c                      |   7 +-
 lib/lwip/lwip/src/core/ipv4/acd.c                  |   2 +-
 lib/lwip/lwip/src/core/ipv4/dhcp.c                 |   2 +-
 lib/lwip/lwip/src/core/ipv4/icmp.c                 |   1 +
 lib/lwip/lwip/src/core/ipv6/ip6.c                  |   3 +-
 lib/lwip/lwip/src/core/ipv6/ip6_frag.c             |  16 +-
 lib/lwip/lwip/src/core/ipv6/nd6.c                  |   6 +-
 lib/lwip/lwip/src/core/mem.c                       |  35 +-
 lib/lwip/lwip/src/core/netif.c                     |   2 +-
 lib/lwip/lwip/src/core/pbuf.c                      |  23 +-
 lib/lwip/lwip/src/core/tcp_in.c                    |  14 +-
 lib/lwip/lwip/src/core/tcp_out.c                   |   5 +-
 lib/lwip/lwip/src/core/udp.c                       |   2 +-
 lib/lwip/lwip/src/include/lwip/apps/http_client.h  |   4 +-
 lib/lwip/lwip/src/include/lwip/apps/mqtt.h         |   2 +
 lib/lwip/lwip/src/include/lwip/apps/snmp.h         |   2 -
 lib/lwip/lwip/src/include/lwip/apps/sntp_opts.h    |   4 +-
 lib/lwip/lwip/src/include/lwip/arch.h              |   2 +-
 lib/lwip/lwip/src/include/lwip/def.h               |  10 +
 lib/lwip/lwip/src/include/lwip/init.h              |   2 +-
 lib/lwip/lwip/src/include/lwip/mem.h               |   2 +-
 lib/lwip/lwip/src/include/lwip/opt.h               |  40 +-
 lib/lwip/lwip/src/include/lwip/prot/nd6.h          |   1 +
 lib/lwip/lwip/src/include/lwip/snmp.h              |   2 +-
 lib/lwip/lwip/src/include/lwip/stats.h             |   5 +-
 lib/lwip/lwip/src/include/netif/ppp/pppoe.h        |   2 +-
 lib/lwip/lwip/src/include/netif/ppp/vj.h           |   2 +-
 lib/lwip/lwip/src/netif/ppp/auth.c                 |   4 +-
 lib/lwip/lwip/src/netif/ppp/fsm.c                  |   5 +-
 lib/lwip/lwip/src/netif/ppp/lcp.c                  |   2 +-
 lib/lwip/lwip/test/fuzz/fuzz_common.c              |  10 +-
 lib/lwip/lwip/test/unit/api/test_sockets.c         |   2 +-
 lib/lwip/lwip/test/unit/core/test_pbuf.c           |  22 +-
 lib/lwip/lwip/test/unit/dhcp/test_dhcp.c           |  15 +-
 lib/lwip/lwip/test/unit/ip4/test_ip4.c             |   1 +
 lib/lwip/lwip/test/unit/ip6/test_ip6.c             |  91 +++-
 lib/lwip/lwip/test/unit/lwip_unittests.c           |   6 +
 lib/lwip/lwip/test/unit/lwipopts.h                 |  25 +-
 lib/lwip/lwip/test/unit/mqtt/test_mqtt.c           |   2 +-
 lib/lwip/lwip/test/unit/tcp/test_tcp.c             |   2 +-
 lib/lwip/lwip/test/unit/tcp/test_tcp_oos.c         |   4 +-
 103 files changed, 2355 insertions(+), 264 deletions(-)
 create mode 100644 lib/lwip/lwip/.github/workflows/codeql-buildscript.sh
 create mode 100644 lib/lwip/lwip/.github/workflows/codeql.yml
 create mode 100755 lib/lwip/lwip/.github/workflows/fail_on_error.py
 create mode 100644 lib/lwip/lwip/contrib/ports/win32/msvc/lwIP_fuzz.sln
 create mode 100644 lib/lwip/lwip/contrib/ports/win32/msvc/lwip_fuzz.vcxproj

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1984

Thanks,
-- 
Jerome
