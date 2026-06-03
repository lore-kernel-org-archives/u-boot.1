Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7772CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 14:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0961C8467E;
	Wed,  3 Jun 2026 16:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hUek03J9";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hUek03J9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6996884868; Wed,  3 Jun 2026 16:48:29 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49FE8056B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 16:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pQkIl787jwuhLZjLaF7dF/IaOtiXefL6RN13BaXgRT86bmW+tPB3WywIWA1iqCUyNiRowNzH9M6wdYbPJeMFnlSP7fiIi7bw4fKqOPuxf2cFqY0+GpXJhGukz7T3nl1DmQ4xthRuMO42OuMqpEFcj3OhQsaXyr8ipMZBYvkIWxhXglHcLcHy8J34qrGYa67/EWZnBjSh8cKhGckcBd6AMDJmGqpa6JFq07RmpIHYkroxvKCqdjxOxnVzuT1EqB42OVHkvzLYSLKAU6DwXsLILm+vuWw6++yFtmmC1IuFy1xI6Path2j3U8n7WUC5dcq28nnlx2NZTYEy5E72bQEhJw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3BwrobdpwwS7TzmyvotQYd46GdzlsvEdNaSa80CymM=;
 b=NytlJirlzYTgUN8zvhZ6hfEVdlKc0OG7pQzl7pC37b/X35uN+cGb5OulHWXMZx3Fizh7IzSuxPzoz3X0WgXkqOke+4d6HluxlPCUdeuFn+Ol3tmREjnNKymvGj4JyC6t/i3JgA/7sbOhZdLLICU7E+C7QWxbnOwiTTB9QVqrLrhGl4bqzTgZm0rYWGf9QYsRQhIrWf0buoO3fU4tU+xO44cFFe7AgS0tF1zJ/BLEIQzznL4raiFyjSMMToq2KF5oBpEs+tAuB0V9dRpVMknQnU/uWcV5bRGkP89TF64JXZR7ChJemWavBux/4DzSGyXONxu3hdoYEXQpMH5j1migMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3BwrobdpwwS7TzmyvotQYd46GdzlsvEdNaSa80CymM=;
 b=hUek03J9KxDfsXk5a495c9epCMMmfps+KW/xaVaqBeRInMbvPUDpPCrD30g4i4uqt+h2jMmxwHQylvFN6G/h7xlGFCfbKzRjLpbnB9JXY6RicuXLD3nObNcEzzrcyJJLOyFZ7J+TVg0hD9jXtbohM7cq4qhLEVNBE/c3MShGUbk=
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by DU0PR08MB8810.eurprd08.prod.outlook.com
 (2603:10a6:10:472::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:48:19 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::85) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 14:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 14:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb43hJqktHYdlQp0/crpd7fj5rtc/3nj2OKGhoKyP8pOsMhGSU4De4TgHPwN02j3HGDNniaVGVOrjCMHbGbnSdTts7OdfNHvBDoU5D8g9iEAZ2V67fKiFQK26hXORvE1YAWVS5Ri+ddLVjWwvkmrgfLO5xa8FXiSpiBSdID6V89KAEp9YV0LgF67b5QqVm9CyrRNeRoiNCsEad0+tgsX5a6XxzgnoIqbUF/wXo5ifrfCh06Gk9PbxHq4Lr0w9Hj184kERybcntpXVjclQ6yMMZqyACYMlBR2QHQHhy6BMZ8nuMEI8LzN/jbrFHSp1ytxrL+myjJIs+MTsXoG2JPE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3BwrobdpwwS7TzmyvotQYd46GdzlsvEdNaSa80CymM=;
 b=cePiD4V5qW90tbyJSbBJ7d3QphUK27Rqm8WDa/bo3e64ecFrMyTRsF/8kkx+iSlSa2YPT+zF6/0fI1hMRayJ9S6JErd6jZZNDUqo6Eo+CFnAhMWtXH3tleJ4JjcEQqb8X/OdYgczJzAnLtoVU60V1ChjTV0K/SksPsuYSPnuJK526bY4krXrNm3OY34bGc/QEC29JFIjthaglDCTI45TZmeUMbK1yGsrzWj7eO3zs2iHBGrsk0dPlWW7cjBwZaqO2Z/qSJsdP45r3iBtl0FxgggrXx5uCTtUJ/pXzOGyUfZFg3GBqzoWY07Vy7Od1dWQoZLxe/tbsH1oFizDl/0zfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3BwrobdpwwS7TzmyvotQYd46GdzlsvEdNaSa80CymM=;
 b=hUek03J9KxDfsXk5a495c9epCMMmfps+KW/xaVaqBeRInMbvPUDpPCrD30g4i4uqt+h2jMmxwHQylvFN6G/h7xlGFCfbKzRjLpbnB9JXY6RicuXLD3nObNcEzzrcyJJLOyFZ7J+TVg0hD9jXtbohM7cq4qhLEVNBE/c3MShGUbk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22) by AS2PR08MB9786.eurprd08.prod.outlook.com
 (2603:10a6:20b:605::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:47:14 +0000
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c]) by GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:47:14 +0000
Message-ID: <11c4a560-3533-4860-80f5-7d1b37033d4f@arm.com>
Date: Wed, 3 Jun 2026 16:47:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] net: Use dev APIs
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>, nd@arm.com
References: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0467.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::17) To GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11741:EE_|AS2PR08MB9786:EE_|DU6PEPF0000B61D:EE_|DU0PR08MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5806e44e-6ff8-4e3a-cd06-08dec17f26db
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 2aPZgZs3ts9/B0l4hJXuhf+e3nJnpqOb7O3DUGiVecDm6qNmMGl1IfU4uxYr6X7UBIMVxYpsgTNT424ZZIa8tpWC1M5h7Pf5VAF9+/tyA85SGM8nnY0P6pZHbReF+TlJZ8iDyJkrDTXO+9y6fcH0mmVjpDJHhk2VWfeerO57qlPBtmC27X/h3Jv/1lTMNEZceEkVGFNvfQIJJ3y2WlDriPdUkfZMehAd44Osr5O7u6K0jnUCdwEoKLVAZluJpvV3i8A7iVZv5BGhPvO1PWCC5TvnvHLAQGuAq5txxHop/2wVBbfx5DZ19lEAAqLfiwJnMVJzOdRqvNcWJaG3fbYNSnqiYlVgtB6Jk979KAHS77Y2CJp0yQDpQTAwaQeUB5TU/y+jgZiwTCYMZ97P9gW6KdIBf5ZABFPftp1IZTb8CSN15O6clwozWHyBcRY83fC5tebY7T0Ett1+6N2miRrvckfS8WN2Wu6AF2zUHSK2PVV3eU7tYY1hLn+0V46LK1KZH3QMp9mza53tlFZAeq+2RBLxq7NIHIjtaadLvT7U7mMpSiQ8IRwnpkeJCaxO0WevuCIPegxnEuoC9iSUO/XJ3GLh96mhHR/Xn7mYJsbrMen+NtJdKuDR1rSYgn11ouvm62CSgZDLsIpQVn8alYg6kPuw0DiB98/wFZOb3NrCRKqRVxqveoAHrMixHJmkQnEaGKLJeq7pNS0nAMC505Wt4w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11741.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: F2BSX6pt+CrMU7T3morhDbwWEeRowvZqDh/IAUDfqevQ8EGRCBmPqWsxxpG9kKQME2zYVfa6bF4rIXSuaLdTYFNjCvmzk4IVrUrhjvAssLOA5OrowJhD4TKhQQR8K2pzsOvoOPcvyeDRBUlKJ8OENOrLSuUr5irojKbNh5XMkB3hxiAWtLN2K+Y4+M8SL0mPjwQuBOjW6jNDzXGjLTMBv+RDhnsiPWtNP/Q9juxoCeqd6AYpJoyjnxbbbeYqWxppeLElNXNmLqMFGJfI2R5LGjmEKOmg3f0/Iko1+RihIIJQE+N3MOr7COVRY8JPaA1hEnJMmzuJl6KjIBpd1SEc2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9786
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8eb1c9d3-af41-4778-2325-08dec17f0011
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|35042699022|82310400026|7416014|376014|14060799003|1800799024|13003099007|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qKTDYL2F5p6mRlWUvIi7lkIdVgpQtM5dN5eSIVlJDtCV0Uu+ewceYAMG55Xxp2fNjYigz7JrzIcEkOuxrv0ywXjOyozs91gTL6+9Kogebiteub89X7sKdEdbUzB44iOb8LFHTkGx/dzT4jSBf/V362gIq5n7ZL8LofbJIBpddEZgMw2pWZkeSsS6CjZV4b8+eH9+a4XnKJpvT8TScXf96UhY9YGuI3iCVPyjJvOcnSHwKYFsa1Yjd5c9uPDfOoEmVQn6KKvjoKcDVU21Hz35X0327e4n+GGT++Do8yBcOUt6MzqKzMGh/mwhHSimJEDNi7CJG9U5yCS+5Re5yYLEw5A2Rn9TyjAurNXuZz59D64G7AhpsEx1HMLCyLAaPSANYebFnbOl/UCaLhLAtF13miW3ApvjKE7BZb/k8DErtedIb+Chikq5LA1c9yCUZttWCpnjDNzRuVGLhHzeKWRiiT3wvCuVb6tuDItaHBPM3uAdIUx7GiNxmeUzBrgw0FV5R6YAC2G9fA+NNw0sgXfCL+AewZAK3oafyciktsJnAPk/0mjTtdiUypVkgENWLc993BWqzIlek7nbcD3K5y5zNP6nRfKZrrfyJDK64Sacfx8MZgOd101j059i0Gnk88s8dW/pnJ3kMWlCi5VZDhAqPcGN//sCkrSNnc2dPe6f5dA/RbKp54Ba1nkw202wFH0OG3BWMdbDMP02CdKHsY1/ngnibJtltBPGk98FqxPibZ8=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(35042699022)(82310400026)(7416014)(376014)(14060799003)(1800799024)(13003099007)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tf47XH32ndvJufc+vsUUPjYXrSaZThzx1CMOPx3B/uMw6GsINws/pmZnkB0US/HWcwOrqsibV1LvfTtvlgjMl+q+mR4K0rEKLLZxQZ9AgyE1ssxRri7LqKmGiGmMG2oJhGcud92pvqnl8IR1uG4FAYrNFvMInXPY1A74Kpi9Z3Z8fdgxVr8I1V6XzBDSfQhFzOlNQQDLKoUOm69eBJeeedCy1eIqmqsQrl8WOAavZOrISrTyt86d10HWZekwXgHKmXEvryYYxij6YNfFQGtMInAhzlGwsJYgH7jYnYs/UVR4kXoY6RqJO0MfUzFR8S90DGKUjlWWYXc9w1CXnvAuMnyVfJ81AmW+FAM4nYvM3rTI0U1azTNFeqo/LC59qv8RuM7d+FjOTd0Y3zpENcJu/9ZvGk3HauGk1xUcu3ahDXhzUAVdumvtzbCtrrdTzcMM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:48:18.8911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5806e44e-6ff8-4e3a-cd06-08dec17f26db
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8810
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

On 28/05/2026 10:00, Peng Fan (OSS) wrote:
> This series converts several Ethernet drivers to use the generic
> device model APIs for device tree access, replacing devfdt_* and
> fdtdec/fdt_* interfaces.
> 
> The goal is to improve compatibility with both live device tree
> and flat device tree backends, and to reduce direct dependencies
> on low-level FDT helpers.
> 
> Patches 1–5 perform straightforward replacements:
>   - devfdt_get_addr() → dev_read_addr()
>   - devfdt_get_addr_index() → dev_read_addr_index()
>   - devfdt_get_addr_index_ptr() → dev_read_addr_index_ptr()
>   - map_physmem(devfdt_get_addr()) → dev_remap_addr()
> 
> These changes are mechanical and introduce no functional change.
> 
> Patch 6 converts the mvpp2 driver from legacy fdtdec/fdt_* APIs
> to ofnode-based interfaces. This removes dependencies on
> gd->fdt_blob and updates phandle parsing, subnode iteration,
> property access, and device lookup.
> 
> No intended functional changes.
> 
> I not have the platforms to test, just best practice for this work.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
> - Add R-b from Simon
> - In patch 6:
>   - drop unused variables,
>   - drop error return code which not follows "No functional changes".
>     This patchset is mainly for API updating, not indended to do 
>     functional change.
> - Link to v1: https://lore.kernel.org/r/20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com
> 
> ---
> Peng Fan (6):
>       net: ethoc: Use dev_read_addr_index()
>       net: qe: dm_qe_uec: Use dev_read_addr()
>       net: calxedaxgmac: Use dev_read_addr()
>       net: dc2114x: Use dev_remap_addr()
>       net: mvpp2: Use dev_read_addr_index_ptr()
>       net: mvpp2: convert FDT access to ofnode API
> 
>  drivers/net/calxedaxgmac.c |  2 +-
>  drivers/net/dc2114x.c      |  2 +-
>  drivers/net/ethoc.c        |  2 +-
>  drivers/net/mvpp2.c        | 56 +++++++++++++++++++++-------------------------
>  drivers/net/qe/dm_qe_uec.c |  2 +-
>  5 files changed, 29 insertions(+), 35 deletions(-)
> ---
> base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
> change-id: 20260526-devfdt-net-a0fe75cd7f49
> 
> Best regards,

Series added to net-next, thanks!

-- 
Jerome
