Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9BC606D802
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vkA05lRc;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iyzlZ4UJ;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iyzlZ4UJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4667D4091C;
	Fri,  6 Nov 2026 18:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lSPjGvrObYw6; Fri,  6 Nov 2026 18:09:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C34440925
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988581;
	b=EsBr9Nm+UleTgKwmGGyJvzhWRzZePow3kRXRPMzlakI3VHZGy3PA6W6VwwHDC44eLg45
	 z8cqS1ng8X1LB+7HOicGRtueT/wXAF0aSLN3VfZ/Uiy9KR4JOLoKcruW/hId2nK+j6+Sy
	 IvsgpnQe9o4eH/zQP4g+9gees7uydRr2ayN2XyBqdGwe2jj0UuJosBdIBsRhIaEEUCNvG
	 77rPsjU/xdingBTrOE9C48sb0S7SAAtsVH5pAE/z1hWcMZiS1o603mwmraWE6Lc+iogsR
	 YqncoB3ov2V0OWOJjjp8WPlmCg8Ae6sV/ard5V7sw5O2fiqQYtGa1+0/Lq2OuPKfjSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xj6bQMiz6s24prfZcg4IkSMRNDckTIEEDSQuwaU3rAo=;
	b=mp0xTA/zjIa24Cepl0yrTIYdDPZv4G3cl+Joyfolt/HZ4dBpsQK3FC2jD1Uma8wIXShB
	 XveLvFd3w2YoxsFDSwkRc8PHjX6K3Ju371EfPHykMkk+VqZSssCpI46oepIWfBSBZKjDG
	 qQf28ljAQzfiTF9A903ezdMnzQdGX0srCZvkfemBfH1vL5H5hTQxhjJo8LlcPUNEKXsZ2
	 cxbtkXodCeGPsIqkwDalJd0JQbV9p3+HAo0lJDqlZSe5m43QP6mdKkeROTaQvWccikM19
	 t7Li/ccIzSvmwJTtERtpholyuxn/x5iIumPUYLmKPxqjatONftVcT3VdbpHAF28XMrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iyzlZ4UJ;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iyzlZ4UJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988581;
	bh=xj6bQMiz6s24prfZcg4IkSMRNDckTIEEDSQuwaU3rAo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkA05lRcm9SZKMpihNNeG95BibEmxMytpKyTWj380GCezDpIMSlHiy2Y/Tm3Y8F9R
	 zd25VXUB5oLYLvB74+wgrOWTz34VtU+8ziYM9c8xjBM1BuHn0m6NkxiXJLttOEt/8p
	 XzJaiAB7TcpTMbQ0n70zEo+OexCsN7o3EY3bodKeM2Swwy5NDa7YdGwORnSFx9Am7T
	 P0a1cmlOFmkS0GB0qr4P9MqiH49WrRjrpbWCPmTdn8o/ea3DP7mWfjG+ZD6srgW7ix
	 ZNBpYft17mVl1CSHDPdg8bFIbpqiRVCXDlx+aIWPvG80ilw1bqAhJ2r4peWiiPEh2+
	 PN3271ii+mmDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C34440925;
	Fri,  6 Nov 2026 18:09:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF000235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A46984091C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2U3EmoEHPvT4 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:09:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4C6A40925
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=iyzlZ4UJ; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=iyzlZ4UJ
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4C6A40925
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 599768482A; Fri,  6 Nov 2026 19:09:35 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8882284820
 for <u-boot@lists.denx.de>; Fri,  6 Nov 2026 19:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj6bQMiz6s24prfZcg4IkSMRNDckTIEEDSQuwaU3rAo=;
 b=iyzlZ4UJPdw4NQv6Mw1XlL6VpZ1TaGbOHrbRFfSWTPYyKsZtJhosYS/21ff+X7lqJxBfldv0ALhPNg9EvadqfXTWp30A0rwYwhiPK9FF/AWlhKq5h5wB+LomvzR+nGBZW96+4ppH0hKgX/adJdAqsGflUrL6oaln27uvpmTo8bI=
Received: from PAZP264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:122::7)
 by GV1PR08MB10599.eurprd08.prod.outlook.com (2603:10a6:150:16c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 18:09:15 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:102:122:cafe::17) by PAZP264CA0020.outlook.office365.com
 (2603:10a6:102:122::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:09:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj6bQMiz6s24prfZcg4IkSMRNDckTIEEDSQuwaU3rAo=;
 b=iyzlZ4UJPdw4NQv6Mw1XlL6VpZ1TaGbOHrbRFfSWTPYyKsZtJhosYS/21ff+X7lqJxBfldv0ALhPNg9EvadqfXTWp30A0rwYwhiPK9FF/AWlhKq5h5wB+LomvzR+nGBZW96+4ppH0hKgX/adJdAqsGflUrL6oaln27uvpmTo8bI=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB241936.eurprd08.prod.outlook.com
 (2603:10a6:250:104::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:29 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:07:29 +0000
Message-ID: <0f9c7a79-a254-481d-be06-ce7f58cc9f7f@arm.com>
Date: Fri, 6 Nov 2026 19:07:28 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: fm: fix the FMan firmware load offset
To: Michael Walle <mwalle@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, York Sun <york.sun@nxp.com>,
 Pankit Garg <pankit.garg@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>,
 u-boot@lists.denx.de, nd@arm.com
References: <20261023074718.2979002-1-mwalle@kernel.org>
Content-Language: en-US
In-Reply-To: <20261023074718.2979002-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB241936:EE_|MAD0EPF000008C2:EE_|GV1PR08MB10599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a11cb15-388e-4131-a140-08df3c31113a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 4mGqin32eb+d8I1FvekU0yRqz4NFkiyzW+wpjyhIn2/hPvc+KIz6mMX95B4z+aJhyAdcsuoiQgPkho5jRs0zn4UVw7WZTYenpsasmh7rsnfIhcyTVPEjsRCjq0mpE7etel1AI6bTrsdPR6NQWHtHrE0coadzigpP320t24bHrYhynhRUa2dhkM8TRXJTgehgXHXEdKgYfDk8hoqS+0Pw0R+CmWdgzyIi38ZKVuh4jGUjZVZbD81C4jyUn4FUTgx8HFMu/bOy6T9QJRlBxXfxIi0yPVK8NLjeWZRaxDtLk47H+OTL3UN+ibqxr88upAF5wzVtMmZGL/Admxhqv+6iyzrDO1qIdEz7/t582TqDag+7a4bkQU8uQcExiFE/CGdAtiP7sNAuCWuanOBB3bTQ05O+Oo7clLpG7igKMk2kk6NUwb2+0KJ/lT/mabEdcWiK0Eqx3k9/HPvf4gcJp+icrb2W9jc9qLUy36FvePUo9a2JvyZOIZInYyQJHzU40aenfTjzGL3Vd1gFcKOYOL6RkIcTqeQdcjD6UfWVPjA5ZCye69uz39e6pLO9hNYyMl7RAdN1sQKjAoAl30ubIsqUgU8tQq6srdUevBjzn2JBRdVeq0kgI2/j1bEZLoviC6pm
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fItuc+FhKHN7CRNZpp/k/NDQdQWSeJxrnXDHn8eUgE2JioD8KZP62Ugnb9W9kxm1NTHV6w9JbWsL0VTGK9JDiOAVZD8dZsPURuOetdwLDyPdCHGw4ee0KsP2dpOl7xXM+1AXwmy8CsyF9u0vnycSViT/+710/fHlBlxIyqMbBJJmpwjFXXZYg6o9M+Lga+JYEq3qYTUENDj7EkBO+nNsTVU+8IkD6ltBofMhNV/TP89JfR9zPlgMI694IJ+gusHx8yu3xl2XI+8WzAFC2iqEgpGrEKH9p4D9Tmx+Ah0WB7OM33NySUbJ8cMFApOdoSKfA6DgFZjmXKhy1EYs8Oz9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB241936
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 10d885c9-6a61-48ab-5373-08df3c30d23b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|14060799003|35042699022|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261028144727099003|261026121527099003|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: E/duq+OzIlI2AoDBbiE72zOSI0U297mIEeUCZq5p2SFPniarxLEM5h7wXVORAArFaaoqKpDXfdFe8GSlQX1cU6jSK0GYiCjNL8WqGCIhXxXBg8PSBIfMVP2ZUGpdjErhxnWSbE1a2b4t8inguW+L+kwW/iZgZ4my4uy7NQTkCHB1cNGPkZ0d9WxlTtnT47AQ7PD9jBYg3eStYHbdUDNs47yfoDtr5ZZes0iN7IAoWBXI61jl5XYSPyXA3I1tCyuzUjMm0BxT55AV1KQiYGtRUXasgOyxK8+PSAGTpzm58HW2KM/zD7A7gyxbH5hfTEXC2S3ylqt7Il2uncfz1w8wi6sM3Ko5vo6b7Yu6XoNmw3NT91ZPnz+ZKpvDzGCZkmT3lKK8kX2rshOmi2xZ3evk02kJbTBK6lpkwPim5UM24fDKhYa1DQTvAAWSka40jWq4rVxPbG8iPlkB695q0xB15qItTHiT4dAlAkADhNUpHI+mKHS2z8pgXASfoxq60RDPVZx7504BOLNQob9r0R9M/ZYWxFtBe86YanzkZ62au6GEAfCCrVFiFCxJ2rS4wJG1cM1FB0QveWGYPYoiApBdaqm8ZuiW0P1a13Kqs+yC3xPrxOWdYDdRZqsZsK0GBiAAeB21+gSXlYRA6U5HJ/0zYY/sffMD2viNXLOmKPts3Uo=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(14060799003)(35042699022)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eoVJU/EY9RokCtM8rxK6Qdtagw3QS+bb+EJ0Rb/ln7Dx0Mm8fUUeC7GHGWrIrTIAla62y5nyYQwVITxBRAw0wLHuIy2n8bKCUhsoZQGYoeWW2Y0mPS5fd8uYMfAr3+hpriXsVHWFpmh5njOPXdTc9sbqdhXC5PwxbQeoNaMDrh8XIzjpgtxB9fRzkERZTygm7wrolHEss1HOjNTQzTLOW3dxhpu/w4Mz+2HZn7XglPDli+1ZIXyjX7COdL+zeOY9M5jFNYny+pfQIy4rFsPe00d5GJmZI5/oB9JsuPBS14mz816/84J4N3+LCAUHsKBTStmzybJBEuKwU28g+YOQRzECnCnoEWPM8Xvmdu03VQb8p9htccQa1dyahrbJnYCLvdrG2IBioDz+SYu44NoFWKqW0XIJz4C9p/m1XQJuv2oD7GPibwX/dImRNKvqNbV/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:09:14.8419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a11cb15-388e-4131-a140-08df3c31113a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10599
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

> When booting from QSPI with TF-A, the FMan firmware is read with
> spi_flash_read(). This only expects an offset into the flash, but
> instead a pointer (CFG_SYS_FSL_QSPI_BASE + offset) into the memory was
> passed.
>
> I'm not sure why this went unnoticed for so long. Maybe the offset is
> stripped with 3-byte addressing or a 4-byte flash just ignores the upper
> byte if CONFIG_FSL_QSPI_AHB_FULL_MAP is not set.
>
> Also the non-TFA boot version has the correct offset in
> spi_flash_read().
>
> Anyway, with CONFIG_FSL_QSPI_AHB_FULL_MAP (only set by default on iMX
> SoCs which doesn't have fm) set, on a LS1043A I get on a LS1043A:
>
>   Fman1: Data at 00000000f9d46630 is not a firmware
>
> because the firmware is read from 2xCFG_SYS_FSL_QSPI_BASE + offset.
>
> To fix it, pass only the flash offset.
>
> Fixes: 382c53f94631 ("net: fm: add TFABOOT support")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/net/fm/fm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: fm: fix the FMan firmware load offset
      commit: bf59c3a24ed3296dea57ecbb2ef0bda84dd25e97

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
