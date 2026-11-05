Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099C606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fpc57dv+;
	dkim=pass (2048-bit key, unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=AnyaP0xI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B7B140718;
	Thu,  5 Nov 2026 09:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytJq9WmX53gQ; Thu,  5 Nov 2026 09:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 075EC406C9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793869623;
	b=auqFA7tkeJmSKr798FBF0JX1751OryL0LFi4tBquYruOzx5gwjBPp2+zWvM3VOOABwRH
	 ibe1NEkltXz6yF8eydnzXCc4FvKR6B6euCbGj3D4JM9o2bJ1TbxoqCgwh6BLaydBDF862
	 tzyaSNXC8r0J/Nd0t20aBuXX94LuxBEyLgFP1f+Mga7eC60LwqLgAF48qn3YtqxGhIYGY
	 0xC1hvXGPYCL2RrDvr6uiSIKkDK5mErXkH/PDyoYa+dab88Nb2G8krFotOsLiqOFKHysa
	 ctVeESvqRcl5pZ/llLj2TbIDlzwAMIo6FYvFOJ4Fom7RRdblSx7kZxXSgmWPuKfSFXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793869623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:CC:
	 References:Content-Language:Organization:In-Reply-To:Content-Type:
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
	bh=vmv5TWbMn0gFMgGzw3SsJ7MZsHHNvziNZCY1j7BByng=;
	b=LLmRZRMZYXKMMaLM0v9bZQuvDSfg9FLwmnDn0fUAV0MJ7TJq8bWihSlgjcn6qW1Jf6Zj
	 oEbQF7SzUVE/+LD+q/OnN1mhbmEscDCY/qrsHhpGPOxku1lacbF90ktPfYHrJUAOF5dIE
	 alynB5Fa/B2KQbHEATGDWOA7+Nh7DzGUmE3zC7fLxo7bJHGZYH4aeSatNS4XH97WEvz1N
	 Em/MUDd2B+QW97WcGGnyu/jdn5L+t8OZf/tC/q0Ds5R1+fqPGMBDlAKfIS5KSGpoTG0KX
	 eRgZtwSUIMP/q7f/QoQvg85ch6H/wbes6DCdmtha5n4zY32qnpWNyzxVohSFYnQ7q9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=topic.nl;
	dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=AnyaP0xI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793869623;
	bh=vmv5TWbMn0gFMgGzw3SsJ7MZsHHNvziNZCY1j7BByng=;
	h=Date:From:Subject:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fpc57dv+eqCwqNpb0m2/NdYVKzuUfhsDQisnfeT9xcg26NSMNAVwon5R5RFdYYnrF
	 e82n6XQVvreO+x4lm1x1HouJLPxhnaUKO96kv+YWhw1vL0nQ8UWSeoHso3A0u6dcL0
	 QEjyqRKUMfPcq97toDITNcIHFBooRXvB4DKfWsR3fbzzSqHQ9Z3G2lQ5qxcKqDs5IU
	 mqXuSjqX+nAePcSLIJefo+HWt2woV2WYvH16kpghkpBfL08RLttF34Pknlrdg1nf8b
	 GwQv4bdgxjsRR46tLYlIKSqsCAC/TWfLKmyUZ4SZ1m6F8jJEaKxtM/6Lz6vgaWjI/z
	 4xZ/AbiXJjtmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 075EC406C9;
	Thu,  5 Nov 2026 09:07:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C2F0362
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41516406C9
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:07:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dy4h1io3lfnO for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E68F405F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=mike.looijmans@topic.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=AnyaP0xI
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E68F405F4
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmv5TWbMn0gFMgGzw3SsJ7MZsHHNvziNZCY1j7BByng=;
 b=AnyaP0xIqwGnCI9VqyzGun7A5qnRR2yc4G0yjaW2vvePsHg7wK6lk7l+5UVpmaxELwrBT4GAKGm88XvGOgd1BNj1btxsIusB7XC9/ZZTmF4oUUl94j/Shntowgl6MAENibBINWDgMaqZ5gsiMDiQmdwGkFUZnfyhfE3VlOCHM/tw/xnuEXM2hRMoJb+Mav4NlNcGj/mOdepGAWIxXU1G2S3htkdEcCFHJHxeqZPbvg0Cv280lvGOnUaeMoLSZbxaQ22+YJdXFz1WYFgkxFWBiLRU6W0J3w0ayJTYB3BRTj/YjJ7VltR2+92Oemz0Pd98gEHpBK31nGdbuqvHbyZzMQ==
Received: from DU6P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::11)
 by AM9PR04MB7492.eurprd04.prod.outlook.com (2603:10a6:20b:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 09:06:53 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::93) by DU6P191CA0001.outlook.office365.com
 (2603:10a6:10:540::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 09:06:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 5 Nov 2026 09:06:52 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.90) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 05 Nov 2026 09:06:52 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by AMZPR04MB972805.eurprd04.prod.outlook.com
 (2603:10a6:20b:7c8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 09:06:49 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 09:06:49 +0000
Message-ID: <e9797580-39dc-4787-960e-6b616d27924c@topic.nl>
Date: Thu, 5 Nov 2026 10:06:47 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4] mach-zynq: Support SPL boot from QSPI in memory-mapped
 mode
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org
CC: Alexey Charkov <alchark@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Debbie Horsfall <debbie.horsfall@arm.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Shiva Tripathi <s-tripathi1@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.aae8b8df-34c8-4e23-a939-42c96d62f8b7@emailsignatures365.codetwo.com>
 <20260915134726.117834-1-mike.looijmans@topic.nl>
 <311320fe-253c-4ad0-a221-fa7c2c6e4295@amd.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <311320fe-253c-4ad0-a221-fa7c2c6e4295@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS8PR04CA0106.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::21) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR04MB12030:EE_|AMZPR04MB972805:EE_|DB1PEPF000509F0:EE_|AM9PR04MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da823e8-fea6-4cc2-7450-08df3b1c226d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|260925022911599003|260925021311599003|260925021911599003|261022113327099003|4143699003|56012099006|261009223027099003|5023799004|261021133027099003|261021123027099003|261021130227099003|261021135927099003|261026140227099003|261102123227099003|261028144727099003|261022115727099003|261022105027099003|261026130827099003|261026121527099003|261026135527099003|261022075727099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: CJG4MH7B8yBuYmUKxvU3BgDtTJvdzMZrs9L+s0hREjtjgWO/n/sENqjYIBwgbEPpWM5SdsdgY7qwS/vWzd05RYfzhEWuz2pxNx1j98ePw8X2sqAHLmplfbvrGzun9K+LVkWmQAIfUCm+GzVeLwlClCq5BKQV4V/wXqhfsuqJlPWQPAoAhKvBcZX7ocqcSXepeLTFoFr+UyWrYbrp0T1ls32b0n2ItiSAk7CH2aLTzRD3u/TnaSZg+Ui1S1LAoEUuEXIrh8R9rONPYD2RlFAHEEXZ38+9/M8azgeBbCOMuu+GlxXA0cFK/bwL1Dd+/j7jPzzcBiYw8CsfB1L2mUaJ2/OiwyDidZsD2T+nZij4OR3TEZIMuoa5AKA98lr5WFopRswvfjrKfVHkAnWSKVY2veU5slxAcfJpWjt1Dj0j71sVwdUwu0vHPquFaPID9dhHCDSpdbSMf4Ky8F8e8bsz+625g/PXV19tRRvwFKNnxMcaCdtZq8U1jXiRD4mBtpCNBEDknCClrP9yEV0xQ/zm5Xm5M6wIWYGO/6QRLA6P3TKJiJKXoqZChy2YsZ5/Od9OIbEkeN2WaY9bfe+ZtvTwDGFZ/Mzb1grjkKCCpb8V+wMzvUCGXJsb4rQt9mhwpDBvvk7RDlJVsWp5faOo1dljhBuyX3XCqATdONHJ+86fXKY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR04MB12030.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(260925022911599003)(260925021311599003)(260925021911599003)(261022113327099003)(4143699003)(56012099006)(261009223027099003)(5023799004)(261021133027099003)(261021123027099003)(261021130227099003)(261021135927099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022115727099003)(261022105027099003)(261026130827099003)(261026121527099003)(261026135527099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: UQnOPsDjgkB4H7DZ4J/PyccAl61GQsRu/wFcyZRWtsLjD4obTgAWenvfYUNtwWOoIVoCibfrsWpuJet5jcqbNROUaUtqjabOS1TsbwaLwrF7R3O4UPhjsrw+z+oy6bfRlypYDX8OzRIU7XMA2zZw+AQ0UPi0m1u2qhAxmUHsVE5r1++6ZCuIK0uethyEc/oeO1gqfWcQBsMSB3IPdmfzomcvZl4BwGxGeE3KKkI9Q8CJWu+Th5aVkOvALAP72eSWp47rAi/j0xAoAHEjTpTiH3hC5nEnaLDEnD4zLa0fWB6i0/Yn5MdW6rYYxAGGZGouG6gAQAaoPCI37Qe04ZDZQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMZPR04MB972805
X-CodeTwo-MessageID: e00923d6-b682-467e-b895-9d3e3597619a.20261105090652@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 69d93b13-af80-4ae3-a225-08df3b1c1fe0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|35042699022|14060799003|36860700016|82310400026|260925021311599003|260925021911599003|260925022911599003|5023799004|4143699003|56012099006|261022105027099003|261022075727099003|261022113327099003|261021135927099003|261022115727099003|261021133027099003|261021123027099003|261021121427099003|261009223027099003|261021130227099003|261102123227099003|261026121527099003|261026140227099003|261026135527099003|261026130827099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: v6IujDvnbqfh+V9RoO2bSsXt1OZUr8sB5vgt0bnkrWZI7oRrZKjJ/oGfJz3R6GyO83UtE0Bw+sYLn7KVSBD2UlfcNQgq5EuO4Fu8uDL3PfMWnRu8U/TAkz22sP1CUKUGlqAuL1c/6TnIb5niOu9elupFQBkHCbkTCQN2Qp623Cnvy/8kzkbzi5+x4JmTU1fgyZPdS8NX2q2u3zjvRt6uqUPTpYyOBROyIA/CS9hPZScPIP2eZvukKqVC2KXosr+y+RKdHGszFh0fRTFqHoqfzAtE3tNfdkxc50iE14e1V9lhMULPoiugC4wjjCvvDrbS6LScsBvzSYhqkxtT9e/bv/NLOcG1v3lkdSzmBvYTl6ldlPM+iP+TGds3XvodZcNivHplYaxfF3I5pw3YVOPYieOGJF2Wyg0PMaVG1HqOMIC87uoK4yFBqP1RwvZVnbM11kJDJ+fgd3GZDw0StCwltEk840JILYoLNMqUas+pjiJgpWuCeMJmFdAG48r/KphecfGnnQFxjbUoX0rrSEhc0wLx230WnxgFvVKioc26oo3niEkChz63U+oVtorU79Q/sCFuwwvFTL3RPqGz9BDJkMZ9YfjZo1aa8J2KCuuj6KiYzRhuwgSe13V4v3QJBsSlj8T/b8KQ2d7EwabibPBtAw==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(35042699022)(14060799003)(36860700016)(82310400026)(260925021311599003)(260925021911599003)(260925022911599003)(5023799004)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261022113327099003)(261021135927099003)(261022115727099003)(261021133027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261021130227099003)(261102123227099003)(261026121527099003)(261026140227099003)(261026135527099003)(261026130827099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nFzShsZVUcAG/IFl6ADeK09PJY/g1vAFRQ0XkAMhxpEmRGaAGLewjzapGsYrg2Q+i/hFAEZUT6jOWrpwT7UHfa92swAVLSKREr7b6i0UJMQQJCmImcBDnc3Jf7HQxamThVCK6g7qrYkbXqzC3fxHz6v4zL6nD08euomphfVs2GHmPijdwxnkV+zxIrMj7nDy+hebrS1O+Nx3rIAUJDLNjSXYzLBmT8arvIGhrF4iHH19phoGKtqEkS5t7RiObTyrE9ySe1AZwdhKY/yNBOtugbxYcHPVTNgipHYhmIdslP9Huhl2ahDa+thXxwnCiA6yBvbaNjpHfWlFy+7tHLdjwwKhqvIe9ZoowjlVAXT6IuCLaXWKllyJ4aUaZ9beivKwnBPhXpdUQilZ+88XCWWRW8NV7K/HiGcLPPp5cesQldzzcKbWahKKPB6csrWRkFix
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:06:52.9067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da823e8-fea6-4cc2-7450-08df3b1c226d
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7492
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

On 11/4/26 14:54, Michal Simek wrote:
>
>
> On 9/15/26 15:47, Mike Looijmans wrote:
>> When the Zynq boots from QSPI NOR flash, the ROM will have set up the
>> QSPI NOR in linear mode, and the contents are now memory mapped (the fir=
st
>> 16MB/32MB at least). All that needs to be done at this stage is to memcp=
y
>> the u-boot code into DDR RAM. This is not only extremely simple, it's al=
so
>> the fastest method to read QSPI flash on this platform.
>> This corresponds to a standard NOR boot, hence this mode is selected as
>> SPL_NOR_SUPPORT.
>>
>> Add a menu choice to select which method to use.
>>
>> To boot from QSPI NOR, write "boot.bin" to offset 0 and write "u-boot.im=
g"
>> to offset SYS_SPI_U_BOOT_OFFS in the flash. Usually SYS_SPI_U_BOOT_OFFS =
will
>> be 0x20000 as the SPL code easily fits in 128k. The offset must fit in t=
he
>> accessible range for linear mode, which is 16MB for single and 32MB for
>> the dual chip modes. This limitation is not checked explicitly in code.
>>
>> Tested on topic_miami boards.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>> Changes in v4:
>> Disable SPL_SPI drivers when in memory-mapped mode
>> Use SYS_SPI_U_BOOT_OFFS as payload offset default
>> Explain why XIP mode is not feasible
>> Don't touch ARCH_ZYNQMP=C2=A0 (yet)
>>
>> Changes in v3:
>> Make the QSPI NOR mode a menu choice as suggested by Michal Simek
>> Obtain payload offset from device-tree config in spl_nor_get_uboot_base(=
)
>>
>> Changes in v2:
>> Reworded and amended commit text
>> Add #define for magic QSPI linear mode address
>> Use old method by default, use SPL_NOR_SUPPORT to switch to mmap
>>
>> =C2=A0 arch/arm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 --
>> =C2=A0 arch/arm/mach-zynq/Kconfig=C2=A0=C2=A0=C2=A0 | 34 +++++++++++++++=
+++++++++++++++----
>> =C2=A0 arch/arm/mach-zynq/spl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 +++++=
+++++++++++++++
>> =C2=A0 common/spl/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++++-
>> =C2=A0 include/configs/zynq-common.h |=C2=A0 8 ++++++++
>> =C2=A0 5 files changed, 62 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 514bf2000b4..9473cbbb28b 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1346,8 +1346,6 @@ config ARCH_ZYNQ
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_SOC_INIT if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_CLK if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_DM if SPL
>> -=C2=A0=C2=A0=C2=A0 select SPL_DM_SPI if SPL
>> -=C2=A0=C2=A0=C2=A0 select SPL_DM_SPI_FLASH if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_OF_CONTROL if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_SEPARATE_BSS if SPL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPL_TIMER if SPL
>> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
>> index c3f505fa15c..17514761530 100644
>> --- a/arch/arm/mach-zynq/Kconfig
>> +++ b/arch/arm/mach-zynq/Kconfig
>> @@ -18,11 +18,37 @@ config SPL_MMC
>> =C2=A0 config SPL_SERIAL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>> =C2=A0 -config SPL_SPI_FLASH_SUPPORT
>> -=C2=A0=C2=A0=C2=A0 default y if ZYNQ_QSPI
>> +choice
>> +=C2=A0=C2=A0=C2=A0 prompt "SPL QSPI boot access method"
>> +=C2=A0=C2=A0=C2=A0 depends on SPL && ZYNQ_QSPI
>> +=C2=A0=C2=A0=C2=A0 default ZYNQ_SPL_QSPI_DM_SPI
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select how to load u-boot.img (U-Boot pr=
oper) into memory from the SPL
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loader when QSPI is the boot device.
>> +
>> +config ZYNQ_SPL_QSPI_DM_SPI
>> +=C2=A0=C2=A0=C2=A0 bool "DM SPI-NOR framework"
>> +=C2=A0=C2=A0=C2=A0 select SPL_DM_SPI
>> +=C2=A0=C2=A0=C2=A0 select SPL_DM_SPI_FLASH
>> +=C2=A0=C2=A0=C2=A0 select SPL_SPI
>> +=C2=A0=C2=A0=C2=A0 select SPL_SPI_FLASH_SUPPORT
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Use the SPI-NOR drivers to transfer U-Bo=
ot proper into main memory
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the QSPI flash.
>> +
>> +config ZYNQ_SPL_QSPI_MMAP
>> +=C2=A0=C2=A0=C2=A0 bool "Memory-mapped linear (NOR) mode"
>> +=C2=A0=C2=A0=C2=A0 select SPL_NOR_SUPPORT
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When the Zynq boots from QSPI NOR flash,=
 the ROM will have set up the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSPI NOR in linear mode. This option jus=
t uses memcpy to transfer
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U-Boot proper into main memory. This red=
uces the SPL size by about 12k
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and is the fastest boot method. For this=
 to work, u-boot.img must be
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 within the first 16MB at offset SYS_SPI_=
U_BOOT_OFFS, or config value
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "u-boot,spl-payload-offset" in the devic=
e-tree.
>> +
>> +endchoice
>
> I don't like this and it seems to me overengineered.
>
> At the end of day it is between SPL_SPI_FLASH_SUPPORT and SPL_NOR_SUPPORT=
=20
> supports.
> If both are selected SPI_FLASH wins because it it in the tree for longer =
time.
>
> It means this patch should be about enabling SPL_NOR_SUPPORT and to get i=
t=20
> work you need to disable SPL_SPI_FLASH_SUPPORT first. Obviously make sens=
e=20
> to also disable drivers, etc.
>
> I hope that doing it in this way will end up not having soc changes in=20
> common/spl/Kconfig which are visible below.

I hoped that too, but it doesn't work that way. This is the smallest change=
 I=20
could come up with to remain compatible and support a clear choice.

The cause of all the complexity is that the image to be loaded resides in a=
=20
SPI flash, but it gets fetched using the memory mapped NOR method.

If you disable=C2=A0SPI_FLASH, this also removes the code and defines that=
=20
calculate the position of the second stage, using the=20
"u-boot,spl-payload-offset" property or the CONFIG_SYS_SPI_U_BOOT_OFFS valu=
e.


If you run menuconfig and select=C2=A0ZYNQ_SPL_QSPI_MMAP, all the "overengi=
neered"=20
stuff is about disabling the SPI controller in a way that it can still find=
=20
the location of the second stage.


>
>> =C2=A0 -config SPL_SPI
>> -=C2=A0=C2=A0=C2=A0 default y if ZYNQ_QSPI
>> =C2=A0 =C2=A0 config ZYNQ_DDRC_INIT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Zynq DDRC initialization"
>> diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
>> index dc964dc2f9f..0a536c6d98b 100644
>> --- a/arch/arm/mach-zynq/spl.c
>> +++ b/arch/arm/mach-zynq/spl.c
>> @@ -15,6 +15,8 @@
>> =C2=A0 #include <asm/arch/sys_proto.h>
>> =C2=A0 #include <asm/arch/ps7_init_gpl.h>
>> =C2=A0 +#include <dm/ofnode.h>
>
> not following u-boot rules about location.
>
>> +
>> =C2=A0 #if defined(CONFIG_DEBUG_UART_BOARD_INIT)
>> =C2=A0 void board_debug_uart_init(void)
>> =C2=A0 {
>> @@ -42,6 +44,20 @@ void spl_soc_init(void)
>> =C2=A0 }
>> =C2=A0 #endif
>> =C2=A0 +#ifdef CONFIG_SPL_NOR_SUPPORT
>> +unsigned long spl_nor_get_uboot_base(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int payload_offs =3D CONFIG_SYS_SPI_U_BOOT_OFFS;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (CONFIG_IS_ENABLED(OF_REAL)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 payload_offs =3D ofnode_conf=
_read_int("u-boot,spl-payload-offset",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 payload_offs);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return ZYNQ_QSPI0_LINEAR_ADDR + payload_offs;
>> +}
>> +#endif
>> +
>> =C2=A0 u32 spl_boot_device(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 mode;
>> @@ -51,6 +67,10 @@ u32 spl_boot_device(void)
>
> I think here there should be a change that insetad of SPL_SPI it actually=
=20
> depends on SPL_SPI_LOAD which enables that functions which calls SPI.
>
> -#ifdef CONFIG_SPL_SPI
> +#if defined(CONFIG_SPL_SPI_LOAD)
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ZYNQ_BM_QSPI:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D BOOT_DEV=
ICE_SPI;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +#elif CONFIG_SPL_NOR_SUPPORT
>> +=C2=A0=C2=A0=C2=A0 case ZYNQ_BM_QSPI:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D BOOT_DEVICE_NOR;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 #endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ZYNQ_BM_NAND:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D BOOT_DEV=
ICE_NAND;
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 5fa94098e49..fb179325f5f 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1140,6 +1140,7 @@ endmenu
>> =C2=A0 config SPL_DM_SPI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Support SPI DM drivers in SPL"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPL_DM
>> +=C2=A0=C2=A0=C2=A0 depends on !ZYNQ_SPL_QSPI_MMAP
>
> I don't like this in generic file.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable support for SPI DM dri=
vers in SPL.
>> =C2=A0 @@ -1526,6 +1527,7 @@ config SPL_SERIAL
>> =C2=A0 =C2=A0 config SPL_SPI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Support SPI drivers"
>> +=C2=A0=C2=A0=C2=A0 depends on !ZYNQ_SPL_QSPI_MMAP
>
> I don't like this in generic file.

Without this, the=C2=A0SPL_SPI option will end up getting selected anyway,=
=20
selecting=C2=A0ZYNQ_SPL_QSPI_MMAP is incapable of turning it off.


>
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable support for using SPI =
in SPL. This is used for connecting
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to SPI flash for loading U-Bo=
ot. See SPL_SPI_FLASH_SUPPORT for
>> @@ -1581,8 +1583,9 @@ endif # SPL_SPI_FLASH_SUPPORT
>> =C2=A0 config SYS_SPI_U_BOOT_OFFS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hex "address of u-boot payload in SPI fla=
sh"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default 0x8000 if ARCH_SUNXI
>> +=C2=A0=C2=A0=C2=A0 default 0x20000 if ARCH_ZYNQ
>
> I don't think this is really necessary. Map will cover the first 16MB and=
=20
> you can place it whereever you like that's why make no sense to enforce a=
ny=20
> offset.
> Just define it in your board defconfig.

This just provides a sensible default, it doesn't enforce it. Without this,=
 it=20
will default to "0" which is guaranteed to fail.


>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default 0x0
>> -=C2=A0=C2=A0=C2=A0 depends on SPL_SPI_LOAD || SPL_SPI_SUNXI
>> +=C2=A0=C2=A0=C2=A0 depends on SPL_SPI_LOAD || SPL_SPI_SUNXI || ZYNQ_SPL=
_QSPI_MMAP
>
> This is wrong and likely break image creation for brcp1 board.
>
> arch/arm/dts/zynq-binman-brcp1.dtsi:23:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D=
=20
> <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>
> =C2=A037 unsigned int __weak spl_spi_get_uboot_offs(struct spi_flash *fla=
sh)
> =C2=A038 {
> =C2=A039=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return CONFIG_SY=
S_SPI_U_BOOT_OFFS;
> =C2=A040 }
>
>
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Address within SPI-Flash from where=
 the u-boot payload is fetched
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from.
>> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common=
.h
>> index 94273d0deb9..f59af92f3ae 100644
>> --- a/include/configs/zynq-common.h
>> +++ b/include/configs/zynq-common.h
>> @@ -35,6 +35,14 @@
>> =C2=A0 /* Ethernet driver */
>> =C2=A0 =C2=A0 /* NOR */
>
> #ifdef CONFIG_SPL_NOR_SUPPORT
>
>> +/*
>> + * Memory-mapped address of QSPI flash when in SPL "NOR" mode. The meth=
od=20
>> used
>> + * is "NOR" boot, but the data is on SPI media, hence using the SPI off=
set.
>> + * Access to the QSPI controller will break XIP mode, so this cannot be=
=20
>> used for
>> + * XIP mode when using the QSPI controller in its regular mode.
>> + */
>> +#define ZYNQ_QSPI0_LINEAR_ADDR 0xfc000000
>> +#define CFG_SYS_UBOOT_BASE (ZYNQ_QSPI0_LINEAR_ADDR +=20
>> CONFIG_SYS_SPI_U_BOOT_OFFS)
>
> #endif
>
>
>> =C2=A0 #ifdef CONFIG_USB_EHCI_ZYNQ
>> =C2=A0 # define DFU_DEFAULT_POLL_TIMEOUT=C2=A0=C2=A0=C2=A0 300
>> ---
>> base-commit: f7fac14ea6c885eef319f0b97bc4fa6ae462f150
>> branch: upstream-topic-miami
>>
> M



Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
