Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7813C106ACCD
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 17:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C476A8427F;
	Thu, 12 Mar 2026 18:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="T3nawlNJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T3nawlNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A356A842BC; Thu, 12 Mar 2026 18:06:59 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E6084238
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 18:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mkKa1BFZeVr7K0wFKGQx8O54JyxCWX1rO9NPlYaUgHNq1RJ82GwNSqrHu3bj2ze3ZFVUcsC3Gn4ZzrhhdGPq2zVx8sUqvs8ESYNPph1D99NbRYwwi72QizWzlZjAkhN/qwM/wia5uBXbi02dy774EgN8i3551x1Y25SDbP87yNox+Vq9AJh97inLy/G24+CclzEmV74h+QQ2jcadLRWaxIf7wwagKqFkItegVBQt8W7TXS6HP2OzE6Kc4cuLAy88E72J/AJfBX8NSR87TYIASPnskqjSSDx1uHIyTft2S1CBV774XTtNdHYiI25cvs61d+oY3a6ot+16+/EyLniM3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJk/2GyT2ecaY0beQRzSi6u/pCXNuVUUVM4uYpBKUhM=;
 b=e7inooO2ijmEb+ApQ+mL/OravNDSPv0S0FGXT+K7/5i2NNHJj7H+FLiFlPsxfGE6rjbPfcOpD5VEO0j2A6K3yVcc8AlK/CPe0nwdjLjJuu9CPoj9LkzeuwyvdFqOZVAl+VfQ/0au5Zy2qbbOb25okgjD8uBhdrz6pP9GHBV9HvelgfolPAmsR45bHxNvq2+Qcs+JU91ArVu2PfiP2Q1MihjWt6rFFngl925HzuTdQUc2BjhpSsP2/X8u24TZqmPg+a8QZqruhmaY2lLSeqjGBeTs6WC0x5J43TavcRwepYH/+p0pTvqKs9fEYOzZ3Od90nlU8LfKZJEK+sUL8KoKNw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iopsys.eu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJk/2GyT2ecaY0beQRzSi6u/pCXNuVUUVM4uYpBKUhM=;
 b=T3nawlNJ5qWxgATJEqv02dUh6DazM0Ibo1jKpDXbJykHzI097pAfYaMBJpsO5Id8dbgSfDl7AiuNUYtCvqmUN3KhK9eopxIMvJ1GghLUsT4gXRB1s4jac3mGInGfwWT0leUhHN6/CTlusHHy7GLzfufKfaXsDDW3UP2P7VsuaJM=
Received: from DU2PR04CA0360.eurprd04.prod.outlook.com (2603:10a6:10:2b4::28)
 by AS4PR08MB7431.eurprd08.prod.outlook.com (2603:10a6:20b:4e3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 17:06:50 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::99) by DU2PR04CA0360.outlook.office365.com
 (2603:10a6:10:2b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 17:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Thu, 12 Mar 2026 17:06:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmI/eABcjRe5UMid1sz595UoSaE5rPdqwgaiHwGKQXhO5bz8BShUzGc2OgP4YwGAgS0TYfENP+vsOwmXqnolNeU5mj2VQtaIWkWwttpu0chTeDYIgGAxq0Buo17KY1aP4RtDqSeNNzbUfXqIolaz2lngaPfw84WmHMh8Et+k0cGVWsOXBshtkg7c9fsHZD5ztzPcUyknTrBwgwNo1xXsEqZse8Vw0CVTjrRIiyluiRPSerrqtFSUsNkC3Tn50WMPmmxcInJmqU5R6dtVOnOwGMg3gN9WCyow1CR7jd7N7+aXFK9KU1lCdUnbKumPsVn7pW5zMRR7ExZV7pXg1gzLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJk/2GyT2ecaY0beQRzSi6u/pCXNuVUUVM4uYpBKUhM=;
 b=LJnbL0G9QmMo5cUmzzNvISuxXmJW394wybGpQ/qLbEg8BafPru/O/LGJ7oQ84Dv60A7id0y3pSkFPEjEc9Y93lziT67Ysxm3F0IKl4TmJfVl3iZwfjRObu+e/umy+tcTBIQD4zrQuRhjKzT2lF7E6Bz35J7Y7QyB+jLedO8pgiMudV7N51dD1W9DHIQEpRv605miyhpGp60ZlvRNL8uUcr5dQn+7cnnxN7NugNi6+ub64jGrMyxirW+5oXZM/HzdPO5ZIDFvq02xV0Htm1h9Gco28ssCmp0p0AnHUiGMmWG7RytjE/SmruAsVnNP/zOzdhOL+Z1E2kblrk/jfZ0zWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJk/2GyT2ecaY0beQRzSi6u/pCXNuVUUVM4uYpBKUhM=;
 b=T3nawlNJ5qWxgATJEqv02dUh6DazM0Ibo1jKpDXbJykHzI097pAfYaMBJpsO5Id8dbgSfDl7AiuNUYtCvqmUN3KhK9eopxIMvJ1GghLUsT4gXRB1s4jac3mGInGfwWT0leUhHN6/CTlusHHy7GLzfufKfaXsDDW3UP2P7VsuaJM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB9055.eurprd08.prod.outlook.com
 (2603:10a6:102:343::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 17:05:45 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 17:05:45 +0000
Message-ID: <08774e1a-b7fe-4f2f-8922-e6e766dc8c5d@arm.com>
Date: Thu, 12 Mar 2026 18:05:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] net: pcs-airoha: unify code using SCU regmap
 helper
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: nd@arm.com
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
 <20260211182230.968921-10-mikhail.kshevetskiy@iopsys.eu>
 <49412867-f5cc-4f80-bd41-3cf0f027479a@arm.com>
 <f2780969-05e4-41b6-abd1-1e09aea706dc@iopsys.eu>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <f2780969-05e4-41b6-abd1-1e09aea706dc@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB9055:EE_|DB5PEPF00014B8C:EE_|AS4PR08MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d801fd-a8a4-479e-09ef-08de8059c087
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: TQMy6LJPiFmL4IHhlEE/bqj7Riay2v4SKhdrJ8WO3Zx3qQ98HGoyftoV+QlM+1pBFIXgON1JyaLw4IkMw66CP2Al2giqi+GXMjWdWndrVVjJ8dmIE5LQD3d0nH6G8x7BYVPdtGOZKTuHGYypHuEzf6ffTpAU/RvqoCV4s2tJBfo34kMesGL5x4Mu1UjXP/Y3V1OM8tyW5QW66sUVVvFEKoDak3tBLTQyH+XHZcK/L+RrBSYe+UnmtKBja+2l8wE1GyTyNb++unmG70XX9W/clIifws/woTYfqN9oMRiU6U0on57+xyJkbJnKEFGj3A5D+Qokux+m5+A/R6n+Pf6doXfPc5+pFaBRi0PCopXyZf0KnA/uaaiUjLeW2Plrb5qCU/XM7BGB7Grqo3SopF98c3PJ0o79MRilFnpPmH4AhirA5k5os311QdnQWY1VwRL7Dx7xpcomUAHCEzGWJQTptmRjVjC9FaHKY1ybyEm4yDMAPbRzQowfWF4yJeRE+FBtiLyAfof8U7lzLUXFvDHz+ep8in6dp3UpJSYcNw5Z0/A4KFyZB7sR2Y9+0e+5aFiPm3DTSMccb+zUKtWovFKeajQyHtfysX1j9pnz3fE9L6imhjMQ6vASTmn+dBVab7kcEYX32qDZtIKWQ7Vj+d4S1sCHUU5VhjfzCc+O3DJ6ibFVQEUXVJCk1/jPkWTV6xG5CPmAmSl0qTBOTlrRkUIcD5+Bw58y38QQMK/nBgV883SNDVr5prrPa52DugdjKhWf
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: jys8oUyuFH8ggefqXrq2rrXric+Mj2haMJLnzq0UV4YIHcrK1v3Fo8EKGjBuAaLTCDZmOW7Jt65hclbLYFFLEsD5cnFQ8fGHfKw4Jl7cE6IGAv41nW5I3ZcRU9wNt3Yj2iBWnkgw56Q5muut59w2ZFZIqCv9px1UkEqyPSKAoBdYA7z1RvbTkPJYFfnucOPKcWPOIm0vZBrPSv9rDmOUKJWUnQBxzvwZFwgfwn2liZpAS56NfQVqlVaFPMj7vr7Fkn3XQbq82IbDwg/O/GzsEfbqQkTOzTSvlLaVWKZiAt6K5A3GvykKdOjcB6VSH9B5Nnk2XTtKO+QwhEbBAY8bTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9055
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b35eea4f-b5be-4a2d-d5e2-08de805999e4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|35042699022|7416014|376014|1800799024|82310400026|14060799003|921020|13003099007|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: oAjA0pRkpoiF14wyoQzFJhq+egpxybW/pzRo74L/4TiKTjiri65m9DJ7iV4T0mb1O7QLbRFL1cS6G2FVSgknr1OQN+TylkrZHNJOpS/a/vudxNX3xGsglZzOPvx0ZJjP9u6JcFCfhdMOBqXcSIXFPMS2FzinPkjDM+LLbwQ9leJGYTjVl+SmqNJPxbo6Z5BFjHNuqITr/NbP0cho1MMhUwqpx5wGGnsXJGg/rq5jMrnyNoWTYKVwOcio3HNuoiOfDHkQhwSmiqMWvgcupNwBHei6/YERQVQge7nenslDd0ss1HRXPSEl4XSA5GSH9HNzNAhZU/k9b22xW7ea0mNjKvAggbqCMBq9clwLlVS9Mxu9DpoRySwNsv7X2ZQ3q6YG+3CdAtcuRhHNbR4+NMwN84A8z3NRlSAdXlv2r+7EGj9nuySxaJCpwugVCBicd4u8lMwPAt0ShJ66ei+nkjGg86G/s38I8PFND3SeEVEA3kyJoOb0l+soU65ISZyIabk8je2Wd1kUwr/rTD2a928Jsj4zZ9A4I0A8R39pqB2YCIfBLR7PggGO1dEKIjQOjg1E6IcpROVKLqYq+sOCBaBmP9ftWMddBNbRzTdO7fwaNmFLG/k9DGri+Y5b5IQo1ebqHgxzbXSvluh8NBGpe67g9ByuaDCaUJusK/+8yKlWS0lHOnYhP/ulu+T1zOrze3XVpg2lE2D957NFFq+80xe/j82UyfTsYiW98z7IpsGQPeoS5YP4bYb0aCn5m3mpSYTZY3XaqB0CGc1ZjTIScwkL5Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(35042699022)(7416014)(376014)(1800799024)(82310400026)(14060799003)(921020)(13003099007)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4jKn/zczb9+PM49ojiXl5FLfthTTtcrtA0IzVc/+Y2YFYjZLu8L3YWz+Rrtej3TfvN7aJRD9M1fzESXMLZWmJTMD0qeIjv7shkFz9U+Zx4W6ZNP9B7T+rraGbNzbJxgp5xr0At1aTe8YyouRa8MYizQ7nA1clCgy3B3XbOkbxqDqcF7SZYmHS5oCTaGSKITYYrfG5bJfHPGsRa7hdpSp+HRYAtpOxX3tYo2T8W6qDHY4YavatC2RdHW6znUy1YTLb4oKx4nQJIwblyyguastEisPhiDfo/dY0gF1CdiZEfuCPWAQOgH0psrsUGK0XmjeQRPL1j4lmgj5rUeAyvQaUiDi3Lqzwya5nSMK56jgJrWePuH8ihL9+PQfcqA8CIm9XR5eUXZZ0B8vSu18ZOKyIdRoeJazLXq/X1yyno6Jomdz/7J/ou4Pi1WP0HXbpJs0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 17:06:50.2635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d801fd-a8a4-479e-09ef-08de8059c087
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7431
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 12/03/2026 17:11, Mikhail Kshevetskiy wrote:
> Hi Jerome,
> 
> This is quite significant patch. If it possible, could you delay pushing
> of all the series a bit.

Oh I'm sorry if I misunderstood that change. As I said I have already sent
out the pull request. Well I suppose worst case the feature is not yet
working but the series without this patch is not breaking anything, right?
If so then I suggest we merge the series as it is (without this patch of
course) then apply one or more followup patches. Tom?

Thanks, 

> I'll look on this patch (and maybe update a little other) tomorrow and
> sent an update.
> 
> On 3/12/26 19:05, Jerome Forissier wrote:
>> Hi Mikhail,
>>
>> On 11/02/2026 19:22, Mikhail Kshevetskiy wrote:
>>> Use common code to get CHIP_SCU registers instead of driver one.
>>>
>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>> ---
>>>  drivers/net/airoha/pcs-airoha-common.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> FYI, I had to left this patch out of my pull request to Tom [1] due to
>> a CI error [2]. The root cause is not obvious to me, and since it is
>> just some code cleanup I decided to take all the other patches and defer
>> that one.
>>
>> [1] https://lore.kernel.org/u-boot/91fa5175-5eb1-4991-9467-fc3fe4f52105@arm.com/T/#u
>> [2] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1396757#L1193
>>
>>
>> Thanks,

