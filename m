Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A42C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1CE980AC6;
	Tue,  4 Aug 2026 21:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JD4EmxbIzD7I; Tue,  4 Aug 2026 21:55:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C934A80D1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880537;
	bh=RCFn60ZNZG6Q6OboABi0KHCE+WDyaGZ0iPxr6n2aEpg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J2X29n95kCvwi5QRwdBe3N67k01EPBY/kpWCE6VgnIpueL8WZGW9G+6kggI4SG0fe
	 gXXpz6sRGE8LMYbs4K6erlglgJaoFhFJDyLKylanMtBUxr+zxz/eTRg9rW4DkuZhtR
	 K+wglXUwj0ZGHqeROfOnmw7siRPSWmipAWwdGeIuC92A3bgSsil4ZIrRqatsA1JoJJ
	 DN3ru6ILq6GIBZgTg/W32dLv6rHie5gNDFGdkBCsQ7HbBg5S9tSPUrEmldgMlkvPG7
	 +dghq0aWUbz4by+W5ZAZp4c74jLe0zm2wD454rWYWcift0WjsOEB3bf7byqRHPimMr
	 21pjzzTAlcm3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C934A80D1D;
	Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 189FF296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A0F84060E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_qSm5meHtZh for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2AC84405D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AC84405D0
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AC84405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674JoLO7333413;
 Tue, 4 Aug 2026 16:55:27 -0500
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fubus5yag-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXQCH00lRZAT15EnL872WpoXSMiQBKtK0Hkc87dm9gtZiHTpXAlO2+svN9eeA22m2yArNPatXM+Oy+YwwlG6Th8Q9zZjc2PYYwN7Dd28F6w4I1LcbyA85PtS66zezPLEI9lv8lkC28F8npKvGLXzFhXNhfHUu88NkEoto3ZoNwgaCWP15Dmu3ct+USD3WP5H/aAgfksF+pk0oaUkwDOD7KlXCMGGIzXbM6BF/efWw9/duLEjyFuQnI+V2igDKtIV6WgYRPNlqDTqK6X+SZ514GcJvvMqrQ8LgIVz8GnYaCttHX4bWIAqTc7IGJYdbnJPldDkl02ezN0Go0WOO8WI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCFn60ZNZG6Q6OboABi0KHCE+WDyaGZ0iPxr6n2aEpg=;
 b=t3avHUktZQQxKC17jtvI6Q15sVPqYc+7HFlHIG1Y3VZ3Z82Yf69BRQXKTaULN2fd3ElaLz2SmZRxiaMLw4x0l9eqNsH1vWYQkikygx0BMpsSNnVpDsWCj5EQmNAP+veE1HzrapbINf5ec0rnspWHvmuhB3UJFUJ/u+/lmvngA58EVhXIXOlcL2rO68DvZ9d+rCfmIjtCOb3EAH/CTx5lsp6SC2JMAGPB0DEvtnOcV5gpGnfNhN4BaNlMJ3XpHx8OT7vKJm6lHV85gRYcSeOp4Ty35avqUsy87zChb+zjnCSviE2bPucYH5GHMM7+dYw7O+ZM1dcYPsdbYuWOjR1MMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from PH7PR17CA0044.namprd17.prod.outlook.com (2603:10b6:510:323::15)
 by PH8PR10MB6573.namprd10.prod.outlook.com (2603:10b6:510:227::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 21:55:21 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::87) by PH7PR17CA0044.outlook.office365.com
 (2603:10b6:510:323::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 21:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Tue, 4 Aug 2026 21:55:21 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:19 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIhw222932;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:07 -0500
Subject: [PATCH v4 08/11] configs: am62lx_evm: add initial defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-8-01746157643d@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4710; i=bb@ti.com;
 h=from:subject:message-id; bh=C8/JA3Af1FSheIljUzhsMIvX/jWuySR79Bcvk8vyk4o=;
 b=owNCWmg5MUFZJlNZj0ExOwAAYH////5/j7trzXPurLjVvddy/dv6cT+Zflff639v/fbU1/+wA
 RtqBigA0aADQGmgAZMgBo0ABoaAAaB6QNGhkAPSaaMmjTENBo0aM0CGmmJ5NRA000aDI9TQZGgA
 aA00NMjJpoAAGQAManqepoYQxA0GmmRk0aAPUPUA0BgmgwcJpoZA000AaaMmQDQaGEyGjRkGI0D
 RkZDEyMQYgxDJoADARoGTRoBo0aAIE3g5oOdjnGUFESXkJqYg0KhewYJ/V39aUmxIDbJ9QE1ocQ
 2E0mPADuH434r+STDA47w8Y2jQNWdAyLJDoidzVW1kcXXGToUqZg1yfxxgg56khLhYhtl4SOtkE
 qCNC5RzU58EMpsaqeMYQMR5pV4QzqICUEVSnsdUBXXJn0wAVu1YevavM0uscbLZf2oRq4GLvmUA
 3yQ3k+n0hOIUMGwh4Zaz9zJjo3gHg0UkAzpeR31YjJLzDGseOzQo/As5TLdSRuV1E77kiKbGBss
 VZ/DnX3OOvmP5u0jghWlB2hI/4mxFc8MIhYkw8wNYvZCAMC6dOgY/ZiGDdv+MccNq42KwVkbxt+
 glukv9PPkEsA04OL8AcEDArli8FzZ0G/RPahG3nzwqoqyFmTx4lBolA710qRpbHBXe71aPsAt4s
 yzKJdpSP/i7kinChIR6CYnY
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|PH8PR10MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 7445d3ae-40cc-41de-30ad-08def27314b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|13003099007|10067099003|56012099006|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: +bnAWjvNG8kgwXur8T1v/143lgyi5cmFsdo8c7tB7i1+ExzsQson73aWHyHnCnrBgauaG0eKBFl3l/SWnnLGmvgpyjV3GBBJDUHi++DqcqMDeqGykjkHdDxpW2N8CmzdqUH0oYkWcf5AwivoianseJ9hTAYW+4KZ68JPXtsBv0OUlTxCZGFulvWRJVWMXtMjUdbUwnM4YHtBsy6FQFCZHyoom5FK/J9wZLqQyDNoiOkf9z9WhHkSs/gVNQC9nlxy3AFzCOWjzj0D4psKL0oFH5QfabCeJB1x4l7yCjKD4uIiS5jvj06ev69N+MumRX8nhHH3RL0jFoF1+Y1x/X1NpNKmLO6zsQWp3cnMPFij8ZrgElK1tKX3PBFvvfR+ohb4ABNA7claZdKV0FYlFYX1YQ12ExUBOpyqN6Nn4S1ZgkmReJFRnbPko11Eobp+rZgZ+bZget2jDQtHkqg/nUv9Zd5FGROqROBB328N04x405NUFO3ICcreZjotpkomHSVxKCjn+ADg/c4FxQyiqlUAJCZiHLVX6daSRwp48Kq2iWjAVEwEatvGGVsMEAA0xp8o65Cv8R+e4h6/WdH0ELpNDV7Y15GwqA3Hy9KK3KtWQ0K/LcqBgQBb/ehRQMa7z1oOio9ccacfFwByk1yDZURjFXveFG7FBwTdOa7IG6TkEX2JkrNhU04m7FRs4mXRfyRTMBq1GtKWW1+9Ixn+bcYDnQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(13003099007)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f8hAm6zaXQqo3HtOjgzLOC3jrBidI5SdodfGkj1LbKIXiOXxgQvW71g8IS+M3GbUIFzF02mk1bHqR1pambiJX0fR5qvbAlDKdFlPmqe9YMNubg38x9wXbq3C/DJmtK8IIPDL5M7A2oiS5ng+mCSGkvU58OU+alWRGP/uuvb4+5Sqir6Q0vlxQ9/rZCP0QPLul4o4R/uw9FupbqKhTtRglMnUUcZk/rtmpuUd7l3GaDJ4Ic5K07ZK06iQnbLpO2C156TMuAyDKKOcH05VCWY5FSMJzl7ZfVvJTkNvjRttA+9LtJv0/MvB7OTzeYV9qdCkbcNpJ5bafuhcga54NLqX/p/pip6s6sGA6DyEbP9JQ+KsuO+9lRNsZmPaRaAFo85ZY3VwNQ2EiNJXjy58WGoW/w4a9BLiNyMyV7ffOgIFI8DBt0cJW/k0mXt6C3jlOFH7
X-Exchange-RoutingPolicyChecked: Ri60UPSEJY/kJrApARegWRIf6h/5WoNXUYc4DncjusdeCUfS31giSa7ro1iFHGSdEqLfW6I7JLKsYJeAspGgSNtzBz0KYCOteQMCOJx7L1IxjAXNJMecAl5AZ8OEZj1njxvM3506laM4v2cCKB8Zj8MnMHUxOqKiR2VQtA4pWFKJgFLVDmfbvOvjuImEheyuq+30a4S+i6ZJqIP4tK7fsq6He8LknvYFyDwqd0gQESH5ld6rg4KGdnbQf8uXl9W6NOe/UitlyiISczbfb6P80zQJCK0G5jkKK/3nFu53dMfbr4p/A3XjMzGEcKR/i9oNO77X304T4MSWbcwLYHAFkQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:21.4194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7445d3ae-40cc-41de-30ad-08def27314b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6573
X-Authority-Analysis: v=2.4 cv=RaagzVtv c=1 sm=1 tr=0 ts=6a725fcf cx=c_pps
 a=pqTWcw9xC4/AVWcamW/T+Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=mgJN0jjOy1CJ0z1pLmQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XcO0iLp7EHcNunGaSazu3iYMhQP-y6q4
X-Proofpoint-GUID: XcO0iLp7EHcNunGaSazu3iYMhQP-y6q4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfXw7i1V/bRt0jv
 xIkP1f5cfFn5bZs/E0S5kO4maAMHTqv3ZMIsUAVDqH3dZB5O78yDbeiZiz2o8wyZ7jJ9dHjzWUw
 KH2j1NZQf94lCcK+UaoOPDmGboXG8Vr0cg/iEc1GzZQYfPDut9P5of/kgHyDTX072Vy+5g6cGlZ
 V2PGH94DrZlOIX1F6oOgIxUKF2pHwhsfL56adGK76sZu2lczir6b6PTGZ6SZmPfDSq3604tn1Px
 IZxRXocJGHO95Zu6dtbFwlGcSS0ORwigrc+MeKIFajz/avzZjhO0juwGWIDui6unPBlEN/G1Wwn
 K4k/mFQq9kxC2gEgpiQow8yQG3m3XHskckScrwhmw3R7YCP9kmRPXq5M0wdksNV/91MkGT+Toi1
 W6YPtr4vnWwZeDhC2hP0LYlnI30LnDHSlVoRt7iN/EYnMTdzw5O3XNvsnaeQ1hMzBs8OA3cbJS4
 wdOKWwoDjAnHobcwo8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX/xGIAHPe0nz2
 K9xRfs8iDDPN5GjAQatu8mI+7uJelOLv4ohw7h/cEGkRquAKRl5DP59lOdG9Z/10PcFhwtxTkIi
 AvySI4yAOOLLASKUd4A2EDeYinmhfrw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=RCFn60ZNZG6Q6OboABi0KHCE+WDyaGZ0iPxr6n2aE
 pg=; b=nRry4UbSwOdJ6Y6YxskZhqtTMEzaeYnUF5Ywu6CR9XtiM/2URCOBehfjH
 LoW+5S2vb/PAd7kEMlV4H02hMEKPvu1mCti/5rbCmQL0Ol+qTa1jEXQjXbqG0sLM
 cofO4TKPM9bcWJW8ZjKaPRnOUiOiFJ+eqswokAa+eAw/LMhA4qeFZpIfyPq45BxL
 Kb55xGCO6kXJFhJDL+brRm549SuB5y1nuUMf5iaaLayGPcbhiYMgEY5M+Ni+6Ohu
 Ai4UD4oh/wjzkkBlUCkAPpLY564LHKShOUrsziQU4PTJQWrdDgAZ5x1uRB0oYDoC
 H/Y1y6/DjULOx2wB1YGepBQ9s3NLw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCFn60ZNZG6Q6OboABi0KHCE+WDyaGZ0iPxr6n2aEpg=;
 b=RVn2YgCvSJfT+KMVSe4eTccD+UAIoWxhViOjvPwhHW9lygXm+laTxz5oMh6I4K1bgu9aEm2HLMQvtRL4xS377U+P86XaKxJiJ6T2Tk+XUErh0vwfaW6/Thj5B8rFdvwkSYeW/ryjl26ebT3qjtKaezXp/2P8UaF5ytd4D8/s15o=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=nRry4UbS; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=RVn2YgCv
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add the initial minimum configuration needed to boot the AM62L3-SK
reference boards.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v4:
- Dropped CONFIG_SYS_BOOTM_LEN in defconfig
- Link to v3: https://lore.kernel.org/r/20260803-am62lx-v3-0-b4f4302b09b4@ti.com

Changes in v2:
- removed options used for fit image signing
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
---
 configs/am62lx_evm_defconfig | 138 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
new file mode 100644
index 000000000000..c73e4af9158f
--- /dev/null
+++ b/configs/am62lx_evm_defconfig
@@ -0,0 +1,138 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_TEXT_BASE=0x84000000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SOC_K3_AM62L3=y
+CONFIG_TARGET_AM62L3_EVM=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b80000
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62l3-evm"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x85000000
+CONFIG_SPL_TEXT_BASE=0x82000000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x82c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_STACK_R=y
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_SPL_SIZE_LIMIT=0x50000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_EFI_SET_TIME=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x83000000
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x58000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+# CONFIG_SCMI_AGENT_OPTEE is not set
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_FIXED=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+# CONFIG_TOOLS_MKEFICAPSULE is not set

-- 
2.54.0

