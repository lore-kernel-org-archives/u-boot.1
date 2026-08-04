Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A855C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45ACA6071D;
	Tue,  4 Aug 2026 00:10:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TwTOxxqoUho; Tue,  4 Aug 2026 00:10:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A6FA606F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802236;
	bh=BEs7cZGUVF7Dfvg7qfF8R178b2Q8fJ/xjlF/h5a7ChU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dMajoIHh+B8RIMgovrSWAmify55gU4g9fBv+FkQjtjQ6JSP+jJZmrYpmmR+M2/YnM
	 9ZNzxwpQfvjKAlaj5cerYMvgU2ocoRcfgm7BtA91GS60Gni7gKui7+czJesgDrmhQG
	 99FWQzHKt0y8woFEybab++YgZ81HAu1uS1rM7t+QCytdt29h45UbVQsCMjVNvBCEEu
	 6+LNUreVoIUDfhfTPr25hvj3ydPvicK2/3d0KnUtj5rJW/fs1TDxofH+U1vbQQx5oJ
	 DjkPWhiOAIJpNWsz0ufIYIYuMmlbtMUnU5FHsKbUfFfSBRkQr2SxA9sKz/JvIbDrwq
	 WDz9S3mbouJ4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A6FA606F6;
	Tue,  4 Aug 2026 00:10:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CB0C218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 643C0400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PE1DeydWbytP for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C75F6400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C75F6400A5
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C75F6400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:31 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673JjBwA565260;
 Mon, 3 Aug 2026 19:10:25 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ftsxpnvud-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:10:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRDfn6hBWv1hO9p7tQQNiunvjICxKGMYsocC1fROQqF4k03ZiLhvKa3wxBok7gryk8TfXUFqWj5VZ8TLnp7R230Zso7ttE+3kwCMkckJZNeDJ4K0F1jbKYwLG9fXefA6DsMB6vrQv/UavhCYPOAGO69yXefu7JlMEpQ9OKr66zs1Ih0gPTYXe9jvPQ9CCbYVXfNFvk0FpDMFp/UMHg/ogMLpks+AWxs0PKVUZ+D4v2SP6dWZ+KctpZKZjKbZDwvTl59YX89dmsVqgRkMBskJgy3nI69VSrDAhyqUstb7koGR72fhyk1nFabPWqHD7/zO1Dw1SQto7vB877Kr8nBJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEs7cZGUVF7Dfvg7qfF8R178b2Q8fJ/xjlF/h5a7ChU=;
 b=TpZCjyhdelrtXatLNyDPxQ6SU3POBEo0R5rz2vDdYoZ/TB4lTaCvr00pJkDa0rY3Mg+snkkTot9CODZQzs2SeFnuCUulymXig2Y3tgkT5DqOw+Me4VtIBMwepGvE3vu62Qx0KI2y+J1kWiA3Vg7/NmRYTC9Oyw50lIE26u4HPNHQSPsmNxnKUUtslZs+qb0q/3Sul2mbFnsvf5rUUbTuMhzd3gFRu+roDzpnFOazvqv972h4rVtIiJwF4mfbSygV0odF598A2f9L49QdOY87iB29jlj+4uSVvfAOXB2KIQzZU/IHWqNOzFE4WpAyzag0XIU15Qt53Kku7KgD3LQzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from CH3P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::10)
 by DS7PR10MB4990.namprd10.prod.outlook.com (2603:10b6:5:3a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 00:10:20 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::5e) by CH3P221CA0021.outlook.office365.com
 (2603:10b6:610:1e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 00:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:10:19 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:52 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:52 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409qLI3381252;
 Mon, 3 Aug 2026 19:09:52 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:36 -0500
Subject: [PATCH v3 11/11] doc: board: ti: am62lx_evm: add initial docs for
 the AM62L-EVM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260803-am62lx-v3-11-b4f4302b09b4@ti.com>
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=76198; i=bb@ti.com;
 h=from:subject:message-id; bh=0tPd35jib7q7/dOFHN/pvMf3aDejibpng7/dLzoRnTw=;
 b=owNCWmg5MUFZJlNZA7cvkAAAZv///7fvin1/7+nuD2q9f/331kom7a7sjVPxX3ufpxX772+wA
 RsZpDRiDCZDTR6QxAyaDTIADTQAGIBo0MmTCaGhiGIBkAAAGQ0DYp5TynqGUB6gZANDIDaJoaaa
 aMI0NAxA0NAAB6hppoY9UZA0NDIHoENANAB5R6g09Q7Q0JiYQxA0aMjCNGhoGIDCNDE0yDIaA0M
 jJgjQYEDQAANANNGgaYAg8Ay7PicwEeMaoRxliXJNDxga0eQSE7NhOsJ23QZq2G11hSrr9a6cQw
 P1D0pT4FeBAOGeIlPFuFTRh8h4ynnBRBqxcgqHAEqEKkfImjPIrGfYuS65iXUvhbzvW/WXWOnAM
 zQxWrfs+Gu95ljAvdgnXMwZyvZ8mfzpNmVA8ZKlIOQdPREBFQUxtnn9Nch60I4a0I+dWNxgn+sN
 61q7NITr0Qa8aZ2T0fSOh2Yk5NtFjwcj0FRBnBjzc/czEfzddEDlaN9ygBLYQ3Qq+ORcUGZvvpi
 uSQy8JqSEEvABgU8rE8VrGDErzXYnN7xzfNwSNWjchCihYfqTKz7LG+4wsAZq4Ac9+Bjg/pIzrS
 nOyA26iB9GfymPAFGKyQmjvTfhB/h6WvKww0ALKlBZEWjtY68dUpePewQJmhniOqnHREEJDH+Lu
 SKcKEgB25fIAA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS7PR10MB4990:EE_
X-MS-Office365-Filtering-Correlation-Id: 42423f47-11df-4e26-4431-08def1bcc54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|1800799024|376014|23010399003|6133799003|3023799007|56012099006|18002099003|22082099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: Jar/4MKnS/D74jFTgV32Lzj/NVZysVx/HK7Iy2dGF3JTwxsUkvCdQ2sNiuKyPUp+JSMKY9wmwETmOIBcQwhz0XKR8U2nm8Ba4y0KfNCV7wEPWLVrl88I2K9CSTR+7h9yMYTQIH8TVbXzFnDTImQ1OD0F4OT3fzLXTVs/DuGCN/16HmCPRb/dNKUb0z157Wgz/ckD3LTdRfiNqXSP2FeUIxi9SZ4D1mD4HxTjbjScyM68sAcTjEhhG6rC+KSozj78Mk4LWiI8yIGwVZc67eElrCqvdsU8jm4Iq+hLS0lolBKO3NE9OnoxAUnXyxm/o9pHXt+AkvhKJKgEiyvkWGUOE1AeW4NvEqyOSQLj7RoOuHVYR99zOKOBYhWGB8RES/+zOvQQjbvN3GWf4KfaBfdpbV1gkv0lGOAApa9Coj2KI1j09J3d21iKlrAI9REi2C7cXpeNavOxV6DFFhQsFDe2odEwW86ELeU/ApTi2KZrjTWAYQ37WFUFXr0OfzEbaKghcyj9DgfvCHHmGczWfk2O71FUTO0UpLVH1udBBO79YfrllTM7e4UfBdtvxF72S8FkTDR739qBYqycu8pxyxPQ0rzFouZMSy0dqBYe9XuxcDDxmNGxkDjd7f/IefyPYqwteGeszJneOsGowpFza00C1w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(1800799024)(376014)(23010399003)(6133799003)(3023799007)(56012099006)(18002099003)(22082099003)(10067099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bjNP/GDHqbcKmjckn/+0hvAXqashDNxf6JbDpEMg0WOvXbXa8Q2D8KMQUEwPpUiKuy0isYBggrYNQGybvpedNFBsQJzXqe2LGAZ0nNUkEEVGn2blGNtgdK3H1wCHMZ1ecGNglRxmp627aIHZTzIMHhomAQNuw+5wyq9yFTcIZks/KBL/j6HxfQ5UvE7oszeYqcd9TMhmX2g0T7jk3pReQZPotwaNs4K6h/WNUcT9e2LA6Bxdp3aDYgOWJcTnfOcshypH2LbW0VCdcNvDSRH5gmQfbSWn2fJ4THOOctpr63baXprS+hJ4X4r7olCE+LQJzbocuLQOIf0w/3HkjwmaGeKP+AFMsrVETeApGCE+4vMPD6RVv0CedYsRnBRguURbS6TznxI55+k7LfHCZ2XqzlNlybJSbL7ic+hj6CXBXPRy7avSlVOh7llOXrx0ZXyL
X-Exchange-RoutingPolicyChecked: g/s2cHKmLoemVOsm0hGJOQedRLR4tzDrlscxnR06UaG+1aMUEoI7HgDW2r8XSgsWROaA7Kciqy9TZaekGPpp8b0PzzMBb9fCN9TBQE9nJfoT3I5kXLsLVYuvVryfGrdHHx5+0giK8MaMmhhX5kKz9ue/0woM3AUxyKgiMdtTkCwEHE1bcQteFZnK7/QIBcC4UYt6nX/Qg/kkBLyFHnQ/Sl6RBMaz+hioU40MZ0uVV4MtpfJnodzuSwphHDyJ7Kcnv35u7uYFLGLpbMketPCQ/AWunEicdW2wgWTMaKeo375Lm534wo5afV19BqbyFeSrGW9XX2sV7K3+UlOf6YtHOQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:10:19.8317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42423f47-11df-4e26-4431-08def1bcc54a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4990
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX8+pAaQXRjyJn
 dckDD1uurSVo3aergyEGD2DyOVDNgdlmVo3Z3Q0aGFnciYytRDEkXJdkfVrtautuuChuBXcApqe
 1tdM9GQ8DcCZei5vKlaXxKZCk4qVoFbQ8NEBSkmcvvbTUoHg+Yx2APWKg74dtxhBWuHidWaS+Wk
 rbpDDj79LVqVy63ZclFY0JLd7CfzpeE0nbVzDGLa/IrkC/gml2ZPN7X7knDI/ACM5nXN6tQLTCc
 /hWW/m8Ty71bP0wOezy7FtJljlcKFMJrfWM/gc39KjvJA0vo0oeaq4gbV1BpA+75/X7u2YYIPJT
 MoxssrYrFnLzBQZz99uQ+ktqkqn/Ub5dZX3vKz0jgtZcG72eybxa5zybaFRfRyAFKFgxqDszjCg
 lLWn0q3TEv2EoiybPL6oabmX+AYqVc90ZF9EiM2XSpXvfSpx298tfCmBSIdAZWMoRjLqNHCltE1
 JEqdhjn65wULE5LnKDA==
X-Authority-Analysis: v=2.4 cv=YaaNIQRf c=1 sm=1 tr=0 ts=6a712df1 cx=c_pps
 a=FzHw5hv2FvkecWl+Aalm1A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=UXIAUNObAAAA:8
 a=VQ9ene8lAAAA:8 a=SSmOFEACAAAA:8 a=-sroTuYGUVUSb1OqqHcA:9
 a=3xtlNZgm3yEXo+T05C31pup2r18=:19 a=AxTp5yq5_KvQ3e5F:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a1s67YnXd6TbAZZNj1wK:22 a=5kMfGx23w8a0v5ansn-_:22
X-Proofpoint-ORIG-GUID: AwWWFVmTGQF3w2c2FeQ3ZBFYphfbDgAs
X-Proofpoint-GUID: AwWWFVmTGQF3w2c2FeQ3ZBFYphfbDgAs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfXyGe8sCYdqn91
 kvJff92T38zxoih7/v3iYfpbLumrTTJZOMDF/1hwx/bbwZNEKWG8x2bbH1kxm4b2Yt8yOOYWoKh
 IU98sGO32n9Aw+hn15tHqGSDJqqNA5s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=BEs7cZGUVF7Dfvg7qfF8R178b2Q8fJ/xjlF/h5a7C
 hU=; b=GM+Tlcrx8F3QIMecBCbI17UEgkbZyX/r5yCdFGHn/6OuEsB71ONCbjgec
 kvFR+u4o49fS2QaXOzsa3C2AcUOhGHn+JJOxoHXu6NURkGf1Uxv9AHVy7tO8Tts3
 2g5+aQuQh0V73dW12AUS5OWjot9u373HGl9MLi8BpHpQCCP4Lpi3mdhEUBHZXEyO
 BySNzQjrJuNStqE+JD4NRs3N1JXLUaJURhkKz3jMLD68Jjo7OXkSV3Ip/eoJxjwX
 s4Yb9BhTWnb1LTpqqjuAU3XQgzwAzJabVQykNZMpa2bXe8LKK+o/BCV2GexKG3VA
 wcGbk+sEb6aYWIKirzJU2fWhTi5UQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEs7cZGUVF7Dfvg7qfF8R178b2Q8fJ/xjlF/h5a7ChU=;
 b=qViVKTlJyHl0I6lmxx1gVZN5UJ6Gif77VwaXcqau+4c2SZSdxM/qzEmyXz2L72fUs5bTMqbNR1bFDYd6sPL3Ruv01L0FCrc31P5VsYndR1LwmrPm4RNWYDuYUCVc64+kkEFGaHoBI2qJfsBiSAYuY9suWufM5OwpZVdrqSZxl0c=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=GM+Tlcrx; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=qViVKTlJ
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

Add the initial documentation on the bootflow, build, and deubgging
procedures along with the relevant links to more information about the
AM62Lx processor and the reference board.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Used CROSS_COMPILE=$CC64 to align with other board docs
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 doc/board/ti/am62lx_evm.rst                     | 222 ++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase1.svg | 450 ++++++++++++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase2.svg | 525 ++++++++++++++++++++++++
 doc/board/ti/img/am62lx_tiboot3.bin.svg         | 170 ++++++++
 doc/board/ti/img/am62lx_tispl.bin.svg           | 222 ++++++++++
 doc/board/ti/img/am62lx_u-boot.img.svg          | 143 +++++++
 doc/board/ti/k3.rst                             |   1 +
 7 files changed, 1733 insertions(+)

diff --git a/doc/board/ti/am62lx_evm.rst b/doc/board/ti/am62lx_evm.rst
new file mode 100644
index 000000000000..84fdc1e710e1
--- /dev/null
+++ b/doc/board/ti/am62lx_evm.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Bryan Brattlof <bb@ti.com>
+
+AM62Lx Platforms
+================
+
+The AM62L is a lite, low power and performance optimized family
+of application processors that are built for Linux application
+development. The AM62L is well suited for a wide range of
+general-purpose applications with scalable ARM Cortex-A53 core
+performance and embedded features such as: Multimedia DSI/DPI support,
+integrated ADC on chip, advanced lower power management modes, and
+extensive security options for IP protection with the built-in security
+features.
+
+The AM62L is a general purpose processor, however some of the
+applications well suited for it include: Human Machine Interfaces (HMI),
+Medical patient monitoring , Building automation, Smart secure gateways,
+Smart Thermostats, EV charging stations, Smart Metering, Solar energy
+and more.
+
+Some highlights of AM62L SoC are:
+
+- Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
+  1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
+  of two external ports
+
+- 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
+
+- Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
+  DPI (24-bit RGB LVCMOS)
+
+- Multiple low power modes support, ex: Deep sleep and Standby
+
+- Support for secure boot, Trusted Execution Environment (TEE) &
+  Cryptographic Acceleration
+
+For more information check out our `Technical Reference Manual (TRM)`_.
+
+.. _Technical Reference Manual (TRM): https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
+
+
+Boot Flow:
+----------
+
+The AM62Lx SoCs deviate significantly from the typical boot-flow of the
+other Sitara or Jacinto class of SoCs.
+
+The first CPU released on power on will be the Security Management
+Subsystem (SMS) MCU to first secure the device like all other K3 SoCs.
+However because the lack of any MCU cores the boot ROM is located on one
+of the A53 cores which is responsible for loading TI's root-of-trust
+firmware (TIFS) along with a BL1 image generated from the
+ARM-Trusted-Firmware repository. The BL1 image is responsible for
+initializing the debug console, the DDR controller, and speeding up the
+A53 to it's maximum allowable.
+
+Once the BL1 is done, it will send a message back to the SMS core to
+reset and begin the second boot phase.
+
+.. image:: img/am62lx_boot_diagram_phase1.svg
+   :alt: First phase of the AM62L boot flow
+
+For the second boot phase, with DDR active ROM can now load the larger
+images contained in the tispl.bin (or whatever filename or offset was
+configured during the BL1 boot phase) which contains TI's root-of-trust
+firmware (TIFS) along with OP-TEE, TF-A's BL31 and U-Boot SPL images to
+initialize the root-of-trust, and the TrustZone and normal world for the
+A53s.
+
+From there the U-Boot SPL will load and authenticate U-Boot proper.
+
+.. image:: img/am62lx_boot_diagram_phase2.svg
+   :alt: Second phase of the AM62L boot flow
+
+Sources:
+--------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+Build procedure:
+----------------
+
+0. Setup the environment variables:
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_common_env_vars_desc
+       :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_board_env_vars_desc
+       :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+   Set the variables corresponding to this platform:
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_common_env_vars_defn
+       :end-before: .. k3_rst_include_end_common_env_vars_defn
+
+   .. prompt:: bash $
+
+      export UBOOT_CFG_CORTEXA=am62lx_evm_defconfig
+      export TFA_BOARD=am62lx-evm
+      export OPTEE_PLATFORM=k3-am62lx
+
+1. Build Trusted Firmware-A:
+
+   More detailed porting and build guide can be found in the `TF-A
+   documentation`_ for all AM62L based platforms. For the AM62L-EVM the
+   build command will be:
+
+   .. prompt:: bash $
+
+      make CROSS_COMPILE=$CC64 \
+            ARCH=aarch64 \
+            PLAT=k3low \
+            TARGET_BOARD=$TFA_BOARD
+
+.. _TF-A documentation: https://trustedfirmware-a.readthedocs.io/en/latest/plat/ti-k3low-am62lx.html
+
+#. Build OP-TEE:
+
+   Depending on the application more build arguments may be needed. The
+   `OP-TEE documentation`_ has more information on this. The basic build
+   commands for the AM62L-EVM are:
+
+   .. prompt:: bash $
+
+      make CROSS_COMPILE=$CC32 \
+            CROSS_COMPILE64=$CC64 \
+            CFG_ARM64_core=y \
+            $OPTEE_EXTRA_ARGS \
+            PLATFORM=$OPTEE_PLATFORM
+
+.. _OP-TEE documentation: https://optee.readthedocs.io/en/latest/
+
+#. Build U-Boot:
+
+   .. prompt:: bash $
+
+      make $UBOOT_CFG_CORTEXA
+      make CROSS_COMPILE=$CC64 \
+            BINMAN_INDIRS="$LNX_FW_PATH" \
+            TEE="$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin" \
+            BL1="$TFA_PATH/build/k3low/$TFA_BOARD/release/bl1.bin" \
+            BL31="$TFA_PATH/build/k3low/$TFA_BOARD/release/bl31.bin"
+
+Image formats:
+--------------
+
+The final images generated and needed for booting the AM62L are:
+
+- tiboot3.bin
+
+.. image:: img/am62lx_tiboot3.bin.svg
+   :alt: tiboot3.bin image format
+
+- tispl.bin
+
+.. image:: img/am62lx_tispl.bin.svg
+   :alt: tispl.bin image format
+
+- u-boot.img
+
+.. image:: img/am62lx_u-boot.img.svg
+   :alt: u-boot.img image format
+
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+The following table shows some common boot modes used on AM62L-EVM
+
+.. list-table::
+   :widths: 16 16 8 8
+   :header-rows: 1
+
+   * - Switch Label
+     - SW4: 12345678
+     - SW2: 1234
+     - SW3: 1234
+
+   * - EMMC
+     - 11010010
+     - 0000
+     - 0000
+
+   * - SD
+     - 11000010
+     - 0100
+     - 0000
+
+   * - UART
+     - 11011100
+     - 0000
+     - 0000
+
+   * - USB DFU
+     - 11001010
+     - 0000
+     - 0000
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash
+
+   openocd -f board/ti/am62levm.cfg
diff --git a/doc/board/ti/img/am62lx_boot_diagram_phase1.svg b/doc/board/ti/img/am62lx_boot_diagram_phase1.svg
new file mode 100644
index 000000000000..fe10d1a253d8
--- /dev/null
+++ b/doc/board/ti/img/am62lx_boot_diagram_phase1.svg
@@ -0,0 +1,450 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="123.04372mm"
+   height="102.41046mm"
+   viewBox="0 0 123.04372 102.41046"
+   version="1.1"
+   id="svg1"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs1">
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="82.705078"
+       height="34.694588"
+       id="rect9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9" />
+  </defs>
+  <g
+     id="layer1"
+     transform="translate(-3.2156586,-61.395067)"
+     style="display:inline">
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9"
+       width="1.9329573"
+       height="85.898857"
+       x="41.939594"
+       y="77.774384" />
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9-2"
+       width="1.9329573"
+       height="25.09384"
+       x="84.430481"
+       y="86.003517" />
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9-2-7"
+       width="1.9329573"
+       height="38.677994"
+       x="84.382317"
+       y="124.9362" />
+    <path
+       d="M 14.252899,77.754344 H 41.775385"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 42.840209,71.544151 0.04093,6.233026"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 85.45604,71.406464 0.0087,14.680898"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 85.443487,111.04287 0.0036,13.97812"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6-8"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 122.1225,64.792094 0.056,98.568876"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6-4"
+       style="display:inline;fill:#d40000;stroke-width:0.264584;stroke-dasharray:0.264584, 0.529165;stroke-dashoffset:0" />
+    <g
+       id="g17"
+       transform="translate(-0.20732502,0.70490506)">
+      <rect
+         style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1"
+         width="16.069794"
+         height="8.8927412"
+         x="26.988451"
+         y="78.507072" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261"
+         id="text1"><tspan
+           id="tspan1"
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="34.991573"
+           y="84.456261">ROM</tspan></text>
+    </g>
+    <g
+       id="g17-1"
+       transform="translate(58.456195,8.5590037)">
+      <rect
+         style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1"
+         width="16.069794"
+         height="8.8927412"
+         x="26.988451"
+         y="78.507072" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261"
+         id="text1-5"><tspan
+           id="tspan1-98"
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="34.991573"
+           y="84.456261">ROM</tspan></text>
+    </g>
+    <g
+       id="g21"
+       transform="translate(0.30297529,12.998616)">
+      <g
+         id="g20"
+         transform="translate(-13.448192,1.681024)">
+        <rect
+           style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+           id="rect1-1-0"
+           width="16.069794"
+           height="8.8927412"
+           x="98.597946"
+           y="111.78242" />
+      </g>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="text1-5-4"><tspan
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="93.599792"
+           y="119.41312"
+           id="tspan19">BL1</tspan></text>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="20.957556"
+       y="76.900803"
+       id="text1-8"><tspan
+         id="tspan1-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="20.957556"
+         y="76.900803">H/W Reset Release</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="64.100334"
+       y="85.26165"
+       id="text1-8-2"><tspan
+         id="tspan1-9-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.100334"
+         y="85.26165">Release A53 ROM</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="64.140884"
+       y="104.34003"
+       id="text1-8-2-6"><tspan
+         id="tspan1-9-9-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.140884"
+         y="104.34003">Authenticate</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.140884"
+         y="108.15002"
+         id="tspan10">tiboot3.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="63.962883"
+       y="119.40052"
+       id="text1-8-2-6-0"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.962883"
+         y="119.40052"
+         id="tspan10-1">Reset A53 to</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.962883"
+         y="123.21052"
+         id="tspan16">BL1 Entry</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="63.822987"
+       y="155.86008"
+       id="text1-8-2-6-0-9"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.822987"
+         y="155.86008"
+         id="tspan10-1-6">BL1 Done</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.822987"
+         y="159.67007"
+         id="tspan15">Message</tspan></text>
+    <path
+       d="M 43.79186,86.012678 H 84.529679"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292"
+       style="stroke-width:0.264582" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8"
+       width="29.836563"
+       height="9.8913136"
+       x="88.656013"
+       y="97.899971"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-7"
+       width="29.836563"
+       height="9.8913136"
+       x="70.63903"
+       y="61.527359"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-7-9"
+       width="29.836563"
+       height="9.8913136"
+       x="27.875254"
+       y="61.689301"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-31"
+       width="29.836563"
+       height="9.8913136"
+       x="88.697792"
+       y="137.6286"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+       id="rect8-3"
+       width="29.756132"
+       height="9.9170303"
+       x="10.461226"
+       y="112.1797"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,55.945023,75.710672)"
+       id="text8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+       x="0"
+       y="0"><tspan
+         x="162.65117"
+         y="101.24414"
+         id="tspan3">Load </tspan><tspan
+         x="143.97914"
+         y="115.64414"
+         id="tspan4">tiboot3.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-22.357201,90.009926)"
+       id="text8-6"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+       x="0"
+       y="0"><tspan
+         x="152.34912"
+         y="101.24414"
+         id="tspan5">Validate </tspan><tspan
+         x="144.39711"
+         y="115.64414"
+         id="tspan6">tiboot3.bin</tspan></text>
+    <path
+       d="m 41.982847,77.762613 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 84.45369,86.024357 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-4"
+       style="stroke-width:0.264583" />
+    <g
+       id="g18"
+       transform="matrix(1.3039736,0,0,1,-13.367223,6.910834)"
+       style="stroke-width:0.875721">
+      <path
+         d="m 43.895114,102.59059 h 31.14238"
+         fill="none"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="stroke"
+         id="path292-5"
+         style="stroke-width:0.231701" />
+      <path
+         d="m 44.052705,102.59467 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+         fill="#000000"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="all"
+         id="path294-8"
+         style="stroke-width:0.231701" />
+    </g>
+    <path
+       d="M 43.737375,124.94556 H 83.348064"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292-5-4"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 84.175686,124.95576 -2.115358,0.92604 0.52884,-0.92604 -0.52884,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8-8"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 122.19619,163.47482 -0.92604,-2.11535 0.92604,0.52884 0.92604,-0.52884 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8-8-9"
+       style="display:inline;stroke-width:0.264583" />
+    <g
+       id="g25"
+       transform="translate(0,-5.2916669)">
+      <path
+         d="M 43.847715,167.18481 H 84.499402"
+         fill="none"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="stroke"
+         id="path292-5-4-1"
+         style="stroke-width:0.264583" />
+      <path
+         d="m 44.02991,167.15364 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+         fill="#000000"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="all"
+         id="path294-8-8-0"
+         style="stroke-width:0.264583" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="103.49282"
+       y="142.27876"
+       id="text12"><tspan
+         id="tspan12"
+         style="font-size:4.23333px;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="103.49282"
+         y="142.27876">Debug Console</tspan><tspan
+         style="font-size:4.23333px;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="103.49282"
+         y="146.08876"
+         id="tspan13">Init</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-2"
+       width="29.836563"
+       height="9.8913136"
+       x="88.51506"
+       y="149.61092"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="103.45767"
+       y="156.1178"
+       id="text14"><tspan
+         id="tspan14"
+         style="font-size:4.23333px;stroke-width:0.264583"
+         x="103.45767"
+         y="156.1178">DRAM Init</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="85.482224"
+       y="68.033394"
+       id="text26"><tspan
+         id="tspan26"
+         style="fill:#000000;stroke:none;stroke-width:0.264583"
+         x="85.482224"
+         y="68.033394">Cortex A53</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="42.888348"
+       y="67.920227"
+       id="text26-8"><tspan
+         id="tspan26-3"
+         style="fill:#000000;stroke:none;stroke-width:0.264583"
+         x="42.888348"
+         y="67.920227">SMS M4</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:vertical-lr;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529167;stroke-dashoffset:0;stroke-opacity:1"
+       x="124.44329"
+       y="115.65893"
+       id="text28"><tspan
+         id="tspan28"
+         style="writing-mode:vertical-lr;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="124.44329"
+         y="115.65893">Time</tspan></text>
+  </g>
+</svg>
diff --git a/doc/board/ti/img/am62lx_boot_diagram_phase2.svg b/doc/board/ti/img/am62lx_boot_diagram_phase2.svg
new file mode 100644
index 000000000000..bac900ebd3eb
--- /dev/null
+++ b/doc/board/ti/img/am62lx_boot_diagram_phase2.svg
@@ -0,0 +1,525 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="115.94852mm"
+   height="145.69476mm"
+   viewBox="0 0 115.94853 145.69477"
+   version="1.1"
+   id="svg1"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs1">
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="82.705078"
+       height="34.694588"
+       id="rect9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9-6" />
+  </defs>
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9"
+     width="1.9329573"
+     height="60.20092"
+     x="31.628733"
+     y="16.379316" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-6"
+     width="1.9329573"
+     height="64.373627"
+     x="31.569685"
+     y="81.187851" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2"
+     width="1.9329573"
+     height="25.09384"
+     x="74.106453"
+     y="24.60845" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7"
+     width="1.9329573"
+     height="24.820444"
+     x="74.071457"
+     y="63.541138" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6"
+     width="1.9329573"
+     height="14.440828"
+     x="74.120178"
+     y="93.028458" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6-2"
+     width="1.9329573"
+     height="14.440828"
+     x="74.067307"
+     y="112.07141" />
+  <path
+     d="m 32.529347,10.149084 0.04093,6.233026"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.145178,10.011397 0.0087,14.680898"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.04042,49.654389 0.0036,13.97812"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 32.555322,76.438013 0.0036,4.872016"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.042581,88.228681 0.0036,4.872016"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.031791,107.33222 0.0036,4.87201"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4-5"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6-2-7"
+     width="1.9329573"
+     height="14.440828"
+     x="74.062813"
+     y="131.12164" />
+  <path
+     d="m 75.027294,126.38245 0.0036,4.87201"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4-5-0"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 111.81164,3.3957745 0.056,138.2673655"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-4"
+     style="display:inline;fill:#d40000;stroke-width:0.264584;stroke-dasharray:0.264584, 0.529166;stroke-dashoffset:0" />
+  <g
+     id="g17"
+     transform="translate(-10.518186,-60.69016)">
+    <rect
+       style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+       id="rect1"
+       width="16.069794"
+       height="8.8927412"
+       x="26.988451"
+       y="78.507072" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="34.991573"
+       y="84.456261"
+       id="text1"><tspan
+         id="tspan1"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261">ROM</tspan></text>
+  </g>
+  <g
+     id="g17-1"
+     transform="translate(48.145333,-52.83606)">
+    <rect
+       style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+       id="rect1-1"
+       width="16.069794"
+       height="8.8927412"
+       x="26.988451"
+       y="78.507072" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="34.991573"
+       y="84.456261"
+       id="text1-5"><tspan
+         id="tspan1-98"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261">ROM</tspan></text>
+  </g>
+  <g
+     id="g21"
+     transform="translate(-10.007886,-48.39645)">
+    <g
+       id="g20"
+       transform="translate(-13.448192,1.681024)">
+      <rect
+         style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1-0"
+         width="16.069794"
+         height="8.8927412"
+         x="98.597946"
+         y="111.78242" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="93.599792"
+       y="119.41312"
+       id="text1-5-4"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="tspan19">BL31</tspan></text>
+  </g>
+  <rect
+     style="fill:#dbe4f4;fill-opacity:1;stroke:#8166b3;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2"
+     width="16.069794"
+     height="8.8927412"
+     x="74.944"
+     y="94.379715" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="82.984222"
+     y="100.36663"
+     id="text1-5-4-28"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="82.984222"
+       y="100.36663"
+       id="tspan19-9">TEE</tspan></text>
+  <rect
+     style="fill:#f8cecc;fill-opacity:1;stroke:#b85450;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2-9"
+     width="16.069794"
+     height="8.8927412"
+     x="75.009903"
+     y="113.30912" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="83.459938"
+     y="119.2588"
+     id="text1-5-4-28-3"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="83.459938"
+       y="119.2588"
+       id="tspan19-9-1">SPL</tspan></text>
+  <rect
+     style="fill:#f8cecc;fill-opacity:1;stroke:#b85450;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2-9-5"
+     width="16.069794"
+     height="8.8927412"
+     x="75.03476"
+     y="132.62766" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="82.852531"
+     y="138.55098"
+     id="text1-5-4-28-3-0"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="82.852531"
+       y="138.55098"
+       id="tspan19-9-1-3">U-Boot</tspan></text>
+  <g
+     id="g21-8"
+     transform="translate(-68.661248,-30.96516)">
+    <g
+       id="g20-7"
+       transform="translate(-13.448192,1.681024)">
+      <rect
+         style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1-0-9"
+         width="16.069794"
+         height="8.8927412"
+         x="98.597946"
+         y="111.78242" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="93.599792"
+       y="119.41312"
+       id="text1-5-4-2"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="tspan19-0">TI-FS</tspan></text>
+  </g>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.789471"
+     y="23.866583"
+     id="text1-8-2"><tspan
+       id="tspan1-9-9"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.789471"
+       y="23.866583">Release A53 ROM</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.830021"
+     y="42.944962"
+     id="text1-8-2-6"><tspan
+       id="tspan1-9-9-9"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.830021"
+       y="42.944962">Authenticate</tspan><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.830021"
+       y="46.754951"
+       id="tspan10">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.65202"
+     y="58.005455"
+     id="text1-8-2-6-0"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.65202"
+       y="58.005455"
+       id="tspan10-1">Reset A53 to</tspan><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.65202"
+       y="61.815453"
+       id="tspan16">BL31 Entry</tspan></text>
+  <path
+     d="M 33.480998,24.617611 H 74.218817"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="stroke"
+     id="path292"
+     style="stroke-width:0.264582" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8"
+     width="29.836563"
+     height="9.8913136"
+     x="78.345154"
+     y="36.504906"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-7"
+     width="29.836563"
+     height="9.8913136"
+     x="60.328167"
+     y="0.132292"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-7-9"
+     width="29.836563"
+     height="9.8913136"
+     x="17.564394"
+     y="0.29423353"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-31"
+     width="29.836563"
+     height="9.8913136"
+     x="78.386932"
+     y="76.233536"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+     id="rect8-3"
+     width="29.756132"
+     height="9.9170303"
+     x="0.15036553"
+     y="50.784637"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+     id="rect8-3-5"
+     width="29.756132"
+     height="9.9170303"
+     x="0.1322915"
+     y="65.710831"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,45.634161,14.315605)"
+     id="text8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="162.65117"
+       y="101.24414"
+       id="tspan3">Load </tspan><tspan
+       x="153.55515"
+       y="115.64414"
+       id="tspan4">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-32.668058,28.614859)"
+     id="text8-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="152.34912"
+       y="101.24414"
+       id="tspan5">Validate </tspan><tspan
+       x="153.97311"
+       y="115.64414"
+       id="tspan6">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-34.238568,43.502747)"
+     id="text8-6-9"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9-6);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="145.15712"
+       y="101.24414"
+       id="tspan7">Boot TIFS </tspan><tspan
+       x="147.90111"
+       y="115.64414"
+       id="tspan8">Firmware</tspan></text>
+  <path
+     d="m 74.142828,24.62929 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-4"
+     style="stroke-width:0.264583" />
+  <g
+     id="g18"
+     transform="matrix(1.3039736,0,0,1,-23.678085,-54.48423)"
+     style="stroke-width:0.875721">
+    <path
+       d="m 43.895114,102.59059 h 31.14238"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292-5"
+       style="stroke-width:0.231701" />
+    <path
+       d="m 44.052705,102.59467 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8"
+       style="stroke-width:0.231701" />
+  </g>
+  <path
+     d="M 33.426513,63.550493 H 73.037202"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="stroke"
+     id="path292-5-4"
+     style="stroke-width:0.264583" />
+  <path
+     d="m 73.864824,63.560693 -2.115358,0.92604 0.52884,-0.92604 -0.52884,-0.92604 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-8-8"
+     style="stroke-width:0.264583" />
+  <path
+     d="m 111.88533,142.46714 -0.92604,-2.11535 0.92604,0.52884 0.92604,-0.52884 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-8-8-9"
+     style="display:inline;stroke-width:0.264583" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="93.181946"
+     y="82.699966"
+     id="text12">SCMI Init</text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="75.171364"
+     y="6.6383266"
+     id="text26"><tspan
+       id="tspan26"
+       style="fill:#000000;stroke:none;stroke-width:0.264583"
+       x="75.171364"
+       y="6.6383266">Cortex A53</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="32.577484"
+     y="6.5251598"
+     id="text26-8"><tspan
+       id="tspan26-3"
+       style="fill:#000000;stroke:none;stroke-width:0.264583"
+       x="32.577484"
+       y="6.5251598">SMS M4</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:vertical-lr;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529167;stroke-dashoffset:0;stroke-opacity:1"
+     x="114.13243"
+     y="68.022209"
+     id="text28"><tspan
+       id="tspan28"
+       style="writing-mode:vertical-lr;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="114.13243"
+       y="68.022209">Time</tspan></text>
+</svg>
diff --git a/doc/board/ti/img/am62lx_tiboot3.bin.svg b/doc/board/ti/img/am62lx_tiboot3.bin.svg
new file mode 100644
index 000000000000..17b9a8538881
--- /dev/null
+++ b/doc/board/ti/img/am62lx_tiboot3.bin.svg
@@ -0,0 +1,170 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236633mm"
+   height="85.065804mm"
+   viewBox="0 0 62.236632 85.065803"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+  </defs>
+  <rect
+     style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.22289;stroke-opacity:1"
+     id="rect51238"
+     width="62.013744"
+     height="84.842911"
+     x="0.11144508"
+     y="0.11144508"
+     ry="9.4566326" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406042"
+     y="25.645016"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-8"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406042"
+     y="12.612378"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="38.677654"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9-1"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="51.705704"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9-1-2"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="64.733757"
+     ry="0" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+     x="20.600019"
+     y="7.8484602"
+     id="text53682"><tspan
+       id="tspan53680"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+       x="20.600019"
+       y="7.8484602">tiboot3.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.52916667,17.991672)"
+     id="text79829"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831)"
+     x="56.255871"
+     y="0"><tspan
+       x="83.140137"
+       y="60.311719"
+       id="tspan1">TF-A BL1</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.17044751,5.285958)"
+     id="text79829-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6)"
+     x="56.255871"
+     y="0"><tspan
+       x="43.948105"
+       y="60.311719"
+       id="tspan2">x509 User Certificate</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.0933935,30.897375)"
+     id="text79829-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2)"
+     x="56.255871"
+     y="0"><tspan
+       x="38.292099"
+       y="60.311719"
+       id="tspan3">Encrypted TIFS Binary</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.06460892,41.158058)"
+     id="text79829-6-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2)"
+     x="56.255871"
+     y="0"><tspan
+       x="35.4673"
+       y="60.311719"
+       id="tspan4">TIFS Board &amp; Security
+</tspan><tspan
+       x="52.220093"
+       y="80.311719"
+       id="tspan5">Configuration Files</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.08028719,57.131985)"
+     id="text79829-6-8-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8)"
+     x="56.255871"
+     y="0"><tspan
+       x="35.196075"
+       y="60.311719"
+       id="tspan6">TIFS Vendor Certificate</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.98430343,17.372352)"
+     id="text79829-2"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4)"
+     x="56.255871"
+     y="0" />
+</svg>
diff --git a/doc/board/ti/img/am62lx_tispl.bin.svg b/doc/board/ti/img/am62lx_tispl.bin.svg
new file mode 100644
index 000000000000..d2c9d7d56951
--- /dev/null
+++ b/doc/board/ti/img/am62lx_tispl.bin.svg
@@ -0,0 +1,222 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236744mm"
+   height="111.84308mm"
+   viewBox="0 0 62.236743 111.84308"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3-9" />
+  </defs>
+  <g
+     id="layer1"
+     transform="translate(5.4851174e-5,5.4851174e-5)">
+    <rect
+       style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.255676;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51238"
+       width="61.981068"
+       height="111.5874"
+       x="0.12778315"
+       y="0.12778315"
+       ry="8.4550943" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478"
+       width="48.173313"
+       height="13.032638"
+       x="6.9406042"
+       y="25.645016"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-8"
+       width="48.173313"
+       height="13.032638"
+       x="6.9406042"
+       y="12.612378"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="38.677654"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="51.705704"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="64.733757"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2-3"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="77.76181"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2-3-7"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="90.789864"
+       ry="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+       x="23.345928"
+       y="7.5099988"
+       id="text53682"><tspan
+         id="tspan53680"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+         x="23.345928"
+         y="7.5099988">tispl.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.52916667,17.991672)"
+       id="text79829"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831)"
+       x="56.255871"
+       y="0"><tspan
+         x="78.844223"
+         y="59.175719"
+         id="tspan129104">TF-A BL31</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.17044751,5.285958)"
+       id="text79829-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6)"
+       x="56.255871"
+       y="0"><tspan
+         x="42.572357"
+         y="59.175719"
+         id="tspan129106">x509 User Certificate</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.0933935,30.897375)"
+       id="text79829-6"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2)"
+       x="56.255871"
+       y="0"><tspan
+         x="36.972336"
+         y="59.175719"
+         id="tspan129108">Encrypted TIFS Binary</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.06460892,41.158058)"
+       id="text79829-6-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2)"
+       x="56.255871"
+       y="0"><tspan
+         x="37.980316"
+         y="59.175719"
+         id="tspan129110">TIFS Board &amp; Security
+</tspan><tspan
+         x="50.868347"
+         y="79.175719"
+         id="tspan129112">Configuration Files</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.08028719,57.131985)"
+       id="text79829-6-8-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8)"
+       x="56.255871"
+       y="0"><tspan
+         x="34.524368"
+         y="59.175719"
+         id="tspan129114">TIFS Vendor Certificate</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.12491591,70.050492)"
+       id="text79829-6-8-8-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8-3)"
+       x="56.255871"
+       y="0"><tspan
+         x="88.596207"
+         y="59.175719"
+         id="tspan129116">OP-TEE</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.31574226,83.33275)"
+       id="text79829-6-8-8-8-3"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8-3-9)"
+       x="56.255871"
+       y="0"><tspan
+         x="75.300201"
+         y="59.175719"
+         id="tspan129118">U-Boot SPL</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.98430343,17.372352)"
+       id="text79829-2"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4)"
+       x="56.255871"
+       y="0" />
+  </g>
+</svg>
diff --git a/doc/board/ti/img/am62lx_u-boot.img.svg b/doc/board/ti/img/am62lx_u-boot.img.svg
new file mode 100644
index 000000000000..b20ab1a491ed
--- /dev/null
+++ b/doc/board/ti/img/am62lx_u-boot.img.svg
@@ -0,0 +1,143 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236744mm"
+   height="59.627434mm"
+   viewBox="0 0 62.236744 59.627435"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3-9" />
+  </defs>
+  <rect
+     style="fill:#dbe4f4;fill-opacity:1;stroke:#8166b3;stroke-width:0.255676;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51238"
+     width="61.981068"
+     height="59.371758"
+     x="0.127838"
+     y="0.127838"
+     ry="8.4550943"
+     rx="8.4550943" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406586"
+     y="25.645071"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-8"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406586"
+     y="12.612433"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406586"
+     y="38.677708"
+     ry="0" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+     x="20.700148"
+     y="8.0392199"
+     id="text53682"><tspan
+       id="tspan53680"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+       x="20.700148"
+       y="8.0392199">u-boot.img</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.52922115,17.991727)"
+     id="text79829"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="92.724136"
+       y="60.311719"
+       id="tspan1">U-Boot</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.17050215,5.2860127)"
+     id="text79829-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="77.404114"
+       y="60.311719"
+       id="tspan2">FIT Header</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.09333885,30.89743)"
+     id="text79829-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="74.772141"
+       y="60.311719"
+       id="tspan3">U-Boot DTB</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.98424885,17.372407)"
+     id="text79829-2"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4);display:inline"
+     x="56.255871"
+     y="0" />
+</svg>
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index b7b69949af16..56df72b656bd 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -33,6 +33,7 @@ K3 Based SoCs
    am62ax_sk
    am62dx_evm
    am62x_sk
+   am62lx_evm
    am62px_sk
    am6254atl_sk
    am64x_evm

-- 
2.54.0

