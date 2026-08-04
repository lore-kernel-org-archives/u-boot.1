Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1CDC55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 483F1606BD;
	Tue,  4 Aug 2026 21:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2tWYVpcb2DyO; Tue,  4 Aug 2026 21:55:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 162E56077B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880543;
	bh=izI08opCimnRQiXVRLvZOVPwB1SwEFEmwK+Ak7Fj3ZM=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kPkNGiOdLIdFpRC//RwY/p9WSU2gEP/VhILjYY/UwSPsC6zYP/Jyt1SiZ6MKC4Iib
	 dTIDAk47iqW5wnN2fTAeveqo/aM43gCQTQxnw8Dcocs+t9x3wj47DpAtDSjsvzkFGE
	 EDnSiozDPRXSLhZoAzwhGdydl+aLAkJBbycrAZSnVEnRBm220lx8K4+8IdXFrFxRh0
	 guo7yHQ8325iAoxT3oPLNFzDc9BRvUMqs3NVpz+aJeJ99PuTdNqPx64dDw5aj5vg7z
	 qpuNCSh8FZR+b0okj/jHLRQ56MVUJIO3J5gG4VGaZqjMuuCYwumplE+d09bi9ZA/6y
	 H0ooZrpn4rHdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 162E56077B;
	Tue,  4 Aug 2026 21:55:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CD2A270
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3397405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KhEaKKp50p3 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E5B0C4060A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5B0C4060A
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5B0C4060A
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674JoGD63496970;
 Tue, 4 Aug 2026 16:55:28 -0500
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fud49dde8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdU4+fdlFd5TXXvusZXesZ0CCfOipDh20JD6Evx+TqNgZmW6sOHOgn3QO0asnZJ38Genx3rAS3PXSC+6hBeb92nwdsRHH5R7bdTFBjeN4e/Ums63zA+ptHNsJdjsiyW+f7WKktfVVZLlXgH6SwkHIXMZW0jqt1h5j4iYE6tTSfpRlS0bIBX3TKw8SaRhT7gfYrRwClAcv9nG7u2QaHVT09Vk7a9ZyWRIJFlDc43eg2P7oOpzt9R4QWMhtCet24t941CXtqx8AruZR1LNYm7u1emngaX16V9/IiDPkAwZM9qCByMi57sbGgfUp2hct72bXUDn9Xg9DaW+z+OhY94F4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izI08opCimnRQiXVRLvZOVPwB1SwEFEmwK+Ak7Fj3ZM=;
 b=wxShByB7w5XQvwPPwRWbSuAh3lm26n2QARvpd7fP4xZmgY8OD1xMirvgsiNeiIdlW9CsH2Yt9so83/4Is0q00J6dGvoCzlP2RBo9BOmLOflFA+GAlp0rknTR8sDIqI7UxXwiL2m6WF2Fhz0U1826WiuUnKN9i2LmWghKkbGmJktpR89GpAp5B0VAQ5ItxP3k/4aZ2UFmPO0lNjPYNY8VuRvp2OLO6AkZo2U7nTazyrgESh4cEsh4S9XyjFJ6BRMojCEVN1E1WqE81DYzqFLzD3UdgTk+QJKjUA8SFtSdKVUpVspqOBBnAcrzNSVWXPu9eFHacGw+OjUJaiguSu2Vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BYAPR21CA0001.namprd21.prod.outlook.com (2603:10b6:a03:114::11)
 by SA1PR10MB997558.namprd10.prod.outlook.com (2603:10b6:806:4ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 21:55:25 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::83) by BYAPR21CA0001.outlook.office365.com
 (2603:10b6:a03:114::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.4 via Frontend Transport; Tue, 4
 Aug 2026 21:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:55:23 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIXL222912;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v4 00/11] arm: mach-k3: introduce basic support for the AM62L
Date: Tue, 4 Aug 2026 16:54:59 -0500
Message-ID: <20260804-am62lx-v4-0-01746157643d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALNfcmoC/1XOwQ6CMAwG4FcxOzvTtWMMT76H8QBjkyUCBsiCI
 by7G4mox7/p97cLG+3g7cjOh4UNNvjR910M8nhgpim7u+W+jpkhoBSAGS9bhY+Z59oYq8hJcor
 F5edgnZ+3oust5saPUz+8tt4g0jRVKMhF/qkIggOvCk2giEpX6cvkT6ZvWfIBfwyK3WA0RM5lG
 gyqvP4z9DUaaDeU7sj4KmAFRSV3s67rGyjX2AMBAQAA
X-Change-ID: 20241025-am62lx-78cce63f43f6
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7902; i=bb@ti.com;
 h=from:subject:message-id; bh=xywNtgkwmDNk23EN1TKZ4JkQh9iEQyFSxrD7MfpM/kM=;
 b=owNCWmg5MUFZJlNZtdxmigAAan////f/O/Oz39z/tz7+/7vbl/SucWeHn/5f0j24+5/7zmewA
 Rq2qQ9TTQANA0AD1ABoAaGmgAAANBoAAA0A0NAaNAA0aGnlPKNB6nlM1DaTYkMhA0ZBppoNADEy
 GgAABoDTCaAyPUAaGgepoaZBoyGgyAMDUxBoGgNNHqGQ6HpPQhp6npBppppoGEAaBoMQaNNA000
 AyPUDQ0aAA0NMhpo0DIyGQAAaAGCaBYtjAowwVGI5BDHkKyY7RRYEaF3NyKyM5Qgf2JhhWX2PkQ
 IqXDEEJ9/OiWU3CcVLnjgLEs4F93MwwNOQfym7RqCuvUPvCSAeNcB4v0uzmiJOKgosc8GUwTDQA
 bFu4AZnXvSFw7XkPuQFIl9ueztRx2tCOGPRv4IBOc9X6/TNzBCSRHOO9FP36fSzAXL1y3WEQ3qb
 7B8CJBWZTXGJ159mxl2ZJ3RtQNWmyyIMN6rRZ5I0OzBLIeH1FGEsBYoSIsQxiStniFepzbgyAfk
 cfZvOquM93E2QCTzil0qrtuxIKYfh9cJL7OGqVYdtht5QANygYjlxWY7bf9KrcL7A1WwWcsRrmm
 DsUXlRXB/fGAEGI5EUlfrIdEOvIEZGAaZJxaSWoVTX4zBaL8rvUhRxRrsCWzVGZJpN4Wa8HQM0F
 FzST2lD/xdyRThQkLXcZoo=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|SA1PR10MB997558:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb8abe5-6dff-4af6-f6e0-08def2731609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|18002099003|3023799007|13003099007|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: vsYngvM6LYCth4MXXknMerI+zMVspSasgYgRo99KdAlvUPrO+3nDPSyetFRahyNBoVMU6tfJAxncWxllY1XPeSMW4Mo2HnwFVhbVE9HUYKxezhCkV9NdLwdU4jo/wl3NYQDeJyoA7nEy0i8DVqJ7+Z7ZolS5gzWtPtYVxK6BRK05jwmhG+166VDKmuZhITSY1cKZNxtebygKx/wiQFzSioi4yyRGsNRixDgVV0NkDKtIxZoHN7XLXv8nus4PE8IpXpG2RH/pBZAn+YM+lS/mLzInK3ZBJ4F5DF29NcqQlvV2otcp+fCyrdc0bmLPTsrEQtYhIMGzgx4UVMLtR+hfSpFl/fRQZps7kNuGliRPv1/WyNdNh3gQPy0SPEVlta2YK0N16kFMLBARrqznLs9HpBGjSYlftdT/1M31Wr0EiFDco5hki2WsPcxSforxS0KJvVAMeFmh/kq9xCn6OHtLgw+KKRvCejrcB7+YmmszZQeRy5lYSAsWp4l46I+fwHeysdqkZ6MQGoFQgDQ8tZW2BKT8bj1v9BTU6z1YXzSSRHitfWIMteDN2go5aIbWZtQV5xl9QjJ8jgQQd8CyY5bp7rQI//KQZQa7IoQVruNCOzI54aYLz14wZysW+M3i7GMd0BJ+vsI77dk2l+Hxzh3GpLLnm+vuSlmEx4E7sfft6S8=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(3023799007)(13003099007)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z5hKWyjBLdr+LSfgj7MgkFh7WkNSNUYrX67h8MF7QMDl71+fqHaz9fkUuDhGCk8LZDfzBbGS2ioSQvJVIMG90P0UnSqveiGnTOZKAKji70/ajjaDBZh58t1e7cQvfrj/pJLTYn+zkvw584kNbvprCquEzEBWmD7kk8oQ73Zdy78JT/UWLN4CEeWCtw+5tpHVuCOytWFmZAiIt4tkN3awX6mVBEg1/PtV4b2xDzVOZpKjVhTNKnHmjs46g2GAkdgzgft1BnRsieC21A05bexmlZSKnPb24lZyQV1wVymTs6gpPskwWotVvGwHaA0ntrXOsfIbOQN8+XTocSuQ16fDJZ8SV/EDTegpJRghSsszAmL6pSb/UFxu/PL8tKsstp2hvA+SJT8RZlEgR00UuBP6fCUNTRDWe9LndQQiVpAg0AlUTb1GxwnO005cpSQxH1HM
X-Exchange-RoutingPolicyChecked: qdRU2Gi3F7umyayuaVHD5/9V60Dh64tr0YM4aFZQ+shc/1aYBkCgS6g5/Gwn7fvwjCMH7EA+a7mOQvX/Fwt9Vcnclu/Nx9is+BWtep81sMqX7uhSTxY5hrpIOgDghQh2r9ccpaA6ANMATwMJvps4BgP6rMfaAJWmKxuEK3MDxOWddrs+v2VBeIpbo/FYVp3Q5pGI/q/xRJHLJZArxrnJdiZqN8N++IqYDoVc56cS0VTAAcFFcnzxU1cmFq/yvGvng3zQ9iUo9fjrtU4BXin36bNQ0slMf9rJT88S/8Sl7ZDJE11W1dzupRynlaMD2fz6VvOjxcn8UnPkv5xS1HvVnw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:23.6880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb8abe5-6dff-4af6-f6e0-08def2731609
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997558
X-Proofpoint-GUID: Q_Yj53rnB652siY8QPV1O1abX-mLIKJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX4MxzhUtYOycj
 r3ks2v4o//8u/Cdimrl1ZHs1mFqqZf0DGQJbajFienPn9pbCVjCOy8fyHUQ2j4fte0gpmEa9tUi
 dyGWXz7zvI2xao9jhMBqrbh2/4LJfDLdCww4BD0sQoT8OyhI5grA7PuTy/NxITMJD6xuOjtFt50
 F6r7O4VN/CZRgDTdGhWOVMLZ3EEqn/+WqG6WE4jlfudB1t+Cu4Q7x0rLIL3RjHng7B3Csby2Ctm
 8wyERbdGwP+v6CvP4eW02GQLKE4DW+BtkLZGwJ613jGIHg6/RihyWwqS0787KziwcTK9TqfbNqq
 v5KjkSCvq0m5SwYm6sYncRU6IaAlbBMPpHdZrnzT785Jpa3kTiHsmxR5PhPMWjZKTGfbj9wiOkD
 ERZZ4FlnIZcfmC/37Af7+HeUGYqr/0miy3dWqD4pA0x0tqtA9F6oFSIHbXcnYy4nDinCwb2GA3K
 8qzR3qQeulOJPj0lCFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX/pWqFstLegho
 7kcZ0/m9dWPi/eYKY/u2EJCyGTx8F/K4uVe96tw/EncB7wXBxpc6sZNmk+6NIoJy3sdeF4ChpfR
 o1rseiAGiC5o3IfaSGqE4pP7XBVPeys=
X-Authority-Analysis: v=2.4 cv=XKMAjwhE c=1 sm=1 tr=0 ts=6a725fcf cx=c_pps
 a=Y5aTAp+79vj4S64KMabfRQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=k-42gJp3AAAA:8 a=KKAkSRfTAAAA:8 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8
 a=DfNHnWVPAAAA:8 a=VT4XjZGOAAAA:8 a=m8ToADvmAAAA:8 a=b3CbU_ItAAAA:8
 a=1VxDqnHFAAAA:8 a=S6PgHPCMtElXQeZobLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=uCSXFHLys93vLW5PjgO_:22 a=cvBusfyB2V15izCimMoJ:22
 a=rjTVMONInIDnV1a_A2c_:22 a=6CpsfURP9XNmmWg3j1mJ:22 a=kCrBFHLFDAq2jDEeoMj9:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-ORIG-GUID: Q_Yj53rnB652siY8QPV1O1abX-mLIKJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=izI08opCimnRQ
 iXVRLvZOVPwB1SwEFEmwK+Ak7Fj3ZM=; b=gK9XWZQGcK+5cbCCCTD3Zf8Cfmc/v
 /PY1shM4kC17TE2wm34WeJSZPQmHAHd4oToMt5WCwlAjs4IvK5yjP9MQ2i/sBWY4
 +go328DvPes6SqHy3AYeWs05oeiO/CoArYDfvspMD/rGlEBpIpsfSWrzH1gija7s
 5NungWXMzEauzvYjaJwXFWor7jNiYLAWhRsE/+I7ORDtlf633CA7ce5RsIoP+SaD
 sMUXPnPXroiW/TxbVKwL/GgkhJSfMyEE/PEmRkYtTFXHRM7bvrCBE6DSjImKOoc6
 n/gcc+mGsYH7w2dT1tvs6FbfqGtqTiCZFjmfT9VO+KhTgs0ulHsF0k48w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izI08opCimnRQiXVRLvZOVPwB1SwEFEmwK+Ak7Fj3ZM=;
 b=Jj1a0sr61GPzcxxoZZS8NkIuoDX6Hc+aauJobW4GWx0Ktb7i1L74bBwoVe3SCR9zqRbPvkE8osgQ0P62rni0UDtcOuEKAlpA+hidluYYk/Jgoqz/aWzf6IefL9oFQKHfA83N6QjX8/jc4K09nNbB8tLZTbsTNcdFDYLgR/T58Qs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=gK9XWZQG; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Jj1a0sr6
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

Hello Everyone,

This series adds the initial support TI's AM62L SoC family along with
the AM62L-EVM reference board.

The AM62L is a lite, low power and performance optimized family of
application processors that are built for Linux application development.
AM62L is well suited for a wide range of general-purpose applications
with scalable ARM Cortex-A53 core performance and embedded features such
as: Multimedia DSI/DPI support, integrated ADC on chip, advanced lower
power management modes, and extensive security options for IP protection
with the built-in security features.

Additionally, the AM62Lx devices includes an extensive set of
peripherals that make it a well-suited for a broad range of industrial
applications while offering intelligent features and optimized power
architecture as well. In addition, the extensive set of peripherals
included in AM62Lx enables system-level connectivity, such as: USB,
MMC/SD, OSPI, CAN-FD and an ADC.

AM62L is a general purpose processor, however some of the applications
well suited for it include: Human Machine Interfaces (HMI), Medical
patient monitoring , Building automation, Smart secure gateways, Smart
Thermostats, EV charging stations, Smart Metering, Solar energy and
more.

Some highlights of AM62L SoC are:

- Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
  1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
  of two external

- 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.

- Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
  DPI (24-bit RGB LVCMOS)

- Multiple low power modes support, ex: Deep sleep and Standby

- Support for secure boot, Trusted Execution Environment (TEE) &
  Cryptographic Acceleration

For more information check out our Technical Reference Manual (TRM)
which is located here:

    https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf

Happy Hacking
~Bryan

---
Changes in v4:
- s/necissary/necessary/ in tcl script update
- Dropped CONFIG_SYS_BOOTM_LEN in defconfig
- Link to v3: https://lore.kernel.org/r/20260803-am62lx-v3-0-b4f4302b09b4@ti.com

Changes in v3:
- Added TI Copyright
- Used CROSS_COMPILE=$CC64 to align with other board docs
- Extended documentation and testing for ti-secure-rom etype
- Kept warning about which versions of OpenOCD have the tcl scripts
- Corrected TFA reserved memory size
- Removed 'emulated' from the board configuration file
- Capitalized 'Include' in commit message
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com

Changes in v2:
- Coalesced boot parameter table Kconfig address
- Removed signed u-boot fit image to align with older K3 devices
- Removed &smci{} bootph override in the u-boot.dtsi overlay
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com

Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Andrew Davis <afd@ti.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Paresh Bhagat <p-bhagat@ti.com>
Cc: Swamil Jain <s-jain1@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Shiva Tripathi <s-tripathi1@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>
Cc: Chintan Vankar <c-vankar@ti.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Hrushikesh Salunke <h-salunke@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
To: u-boot@lists.u-boot-project.org

---
Anshul Dalal (1):
      firmware: scmi: switch to dev_ofnode during bind

Bryan Brattlof (9):
      tools: binman: extend ti_secure_rom to handle op-tee
      soc: add data to identify the am62lx
      boot/Kconfig: disable fit post processing for AM62L
      arm: mach-k3: Add initial am62lx SoC support
      board: ti: am62lx: add initial board files
      configs: am62lx_evm: add initial defconfig
      doc: ti: k3: fix pygments warning parsing device-tree
      doc: board: ti: correct path to tcl scripts
      doc: board: ti: am62lx_evm: add initial docs for the AM62L-EVM

Vignesh Raghavendra (1):
      arm: dts: k3-am62lx: Add binman support

 arch/arm/dts/k3-am62l3-evm-binman.dtsi             | 218 +++++++++
 arch/arm/dts/k3-am62l3-evm-u-boot.dtsi             |  12 +
 arch/arm/mach-k3/Kconfig                           |  38 +-
 arch/arm/mach-k3/Makefile                          |   2 +
 arch/arm/mach-k3/am62lx/Kconfig                    |  23 +
 arch/arm/mach-k3/am62lx/Makefile                   |   7 +
 arch/arm/mach-k3/am62lx/am62l3_fdt.c               |  12 +
 arch/arm/mach-k3/am62lx/am62l3_init.c              |  58 +++
 arch/arm/mach-k3/am62lx/boot.c                     |  83 ++++
 arch/arm/mach-k3/am62lx/schema.yaml                | 427 +++++++++++++++++
 arch/arm/mach-k3/include/mach/am62l_hardware.h     |  48 ++
 arch/arm/mach-k3/include/mach/am62l_spl.h          |  41 ++
 arch/arm/mach-k3/include/mach/hardware.h           |   6 +
 arch/arm/mach-k3/include/mach/spl.h                |   4 +
 board/ti/am62lx/Kconfig                            |  19 +
 board/ti/am62lx/MAINTAINERS                        |   8 +
 board/ti/am62lx/Makefile                           |   7 +
 board/ti/am62lx/am62lx.env                         |   8 +
 board/ti/am62lx/board-cfg.yaml                     |  32 ++
 board/ti/am62lx/evm.c                              |  19 +
 board/ti/am62lx/sec-cfg.yaml                       | 380 +++++++++++++++
 boot/Kconfig                                       |   2 +-
 configs/am62lx_evm_defconfig                       | 138 ++++++
 doc/board/ti/am6254atl_sk.rst                      |   2 +-
 doc/board/ti/am62ax_sk.rst                         |   2 +-
 doc/board/ti/am62dx_evm.rst                        |  11 +-
 doc/board/ti/am62lx_evm.rst                        | 222 +++++++++
 doc/board/ti/am62px_sk.rst                         |  12 +-
 doc/board/ti/am62x_sk.rst                          |   2 +-
 doc/board/ti/am64x_evm.rst                         |  24 +
 doc/board/ti/am65x_evm.rst                         |   2 +-
 doc/board/ti/img/am62lx_boot_diagram_phase1.svg    | 450 ++++++++++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase2.svg    | 525 +++++++++++++++++++++
 doc/board/ti/img/am62lx_tiboot3.bin.svg            | 170 +++++++
 doc/board/ti/img/am62lx_tispl.bin.svg              | 222 +++++++++
 doc/board/ti/img/am62lx_u-boot.img.svg             | 143 ++++++
 doc/board/ti/j7200_evm.rst                         |   2 +-
 doc/board/ti/j721e_evm.rst                         |   2 +-
 doc/board/ti/j722s_evm.rst                         |   2 +-
 doc/board/ti/j784s4_evm.rst                        |   2 +-
 doc/board/ti/k3.rst                                |  39 +-
 drivers/firmware/scmi/scmi_agent-uclass.c          |   2 +-
 drivers/soc/soc_ti_k3.c                            |  11 +
 include/configs/am62l3_evm.h                       |  14 +
 tools/binman/btool/openssl.py                      |  11 +-
 tools/binman/etype/ti_secure_rom.py                |  34 +-
 tools/binman/etype/x509_cert.py                    |   4 +
 .../binman/test/vendor/ti_secure_rom_combined.dts  |   1 +
 48 files changed, 3455 insertions(+), 48 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20241025-am62lx-78cce63f43f6

Best regards,
--  
Bryan Brattlof <bb@ti.com>

