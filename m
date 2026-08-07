Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB23C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3179581304;
	Fri,  7 Aug 2026 13:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6zdNrlRfS18T; Fri,  7 Aug 2026 13:04:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4553B812F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786107854;
	bh=7FUVlrlFqnp9JyF6Z8W9R8eIhY9R8zKo2iso7jyjCS4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lEYxLCyL6E4IiQyl1Uw7QjqzlUPeIEbYMcCG7iuDhqMIDNS4H9z8x1N86XOiknOe4
	 eG2k/jlEeQK9dS8Xo8cYjx2iIeXFzk7AsmQ8zljq0I6P57jIB57hPCPq4GP9ku20iM
	 k49wra9jK43jD5PLqfkqsxnjrNk4KiB1bjggjuaE69WxkbKAjA/M8LwMv+ZR+Z0z6i
	 I9wo0YS/eMGviIHJkcOZ9pz6h2uci2cbGhV9MiKLyZqLCL251jyGPccCaCo1oSEir1
	 u0AmZu3SuO7J0LezJHSXaBN2n+eOdXg1qaKkQ/AYuRNm7nkToTfePZ0oA2XPIfSkdD
	 a875QhjgL9vtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4553B812F1;
	Fri,  7 Aug 2026 13:04:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 28A20259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09005608DC
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:04:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oxxFWfvt9-d8 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:04:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3CE43608D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CE43608D2
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CE43608D2
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:04:11 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 677CeBJj2986394;
 Fri, 7 Aug 2026 08:04:10 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012069.outbound.protection.outlook.com
 [40.107.200.69])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fweqn8dpf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 08:04:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuYxMSv7OnzuAmGQgQiXIfWSRfCBMCEk41Ar+OgKjVfxtCgIGV/0yP5Geu4kYC/NaEhCC9X7g37rlZ9uCtG5QwpgegnMIh0gxz9dYq/CuxOMWBRnGvtbRvgu2sFEzEpzyOlXUtfR1dP/2oT6yQb/1u8HloP0BRGWG4CR5mGFdfOaXASr/fAfSfhTYoww66P/TIo5jaFZ0h2BaIS3ju1/PSMfrclVcNqFt3+JzYa0VlKNRoEEVwK1mqzt0xJxnvI83Jen0x4afqplmQ7V2+QCZYuA9DbyJIFzL7Xm+ej/+kYHRdXSIWNU731YN1WsW96p7w6kBzyiGVA/PQKjtEzaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FUVlrlFqnp9JyF6Z8W9R8eIhY9R8zKo2iso7jyjCS4=;
 b=MG/FJDStpglNkBNq7hPjCDIo5wyiOsG+C0s3VNDpbSqsz56XU9CWxgpiJQGTKqSYQ/Mzb+Wsgp2XyNdNGF9egdLPnO660TcaSGUSoVOCSwjgjUbw8+WRV8LB7SSlHIS53YYTZpTIGvcVubc8SUl2ILf6MO4iUWQ+p7SFPG/1iDGGt+gDPg8n5XgtVvAReEiJAWBaY7zqkix+bCj0FRpcS99Dyl9wwaMzoI/Tan3T1ZYGCd9agumvNnuj7CrvZXUQPWhRdTntMQdWNeEnunWZt4WvxFI54yDWpN956TZ0osAhHKKSehsaA6lh0Teia3p7nFyT/iiEW0LNzVY47GHHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR05CA0162.namprd05.prod.outlook.com (2603:10b6:a03:339::17)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 13:04:04 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::47) by SJ0PR05CA0162.outlook.office365.com
 (2603:10b6:a03:339::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.8 via Frontend Transport; Fri, 7
 Aug 2026 13:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 13:04:03 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 08:04:01 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 08:04:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 7 Aug 2026 08:04:00 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 677D406m1861361;
 Fri, 7 Aug 2026 08:04:00 -0500
Date: Fri, 7 Aug 2026 08:04:00 -0500
From: Bryan Brattlof <bb@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v4 09/11] doc: ti: k3: fix pygments warning parsing
 device-tree
Message-ID: <20260807130400.5jcf6vmv4wyblrws@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-9-01746157643d@ti.com>
 <CAFLszThV9-uA_z_Lbpduov9tmxVD6m1dZbQQqiRfHo-aSayYGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAFLszThV9-uA_z_Lbpduov9tmxVD6m1dZbQQqiRfHo-aSayYGA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcbcbfa-ec22-497e-75c9-08def4845b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|13003099007|6133799003|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jWuHtUNCsKlZrm6spadPqw4FTPQoki0paOK35ndMszY+KVmJ3Ka1VufCJrbTxM6s77GmA1h1LTowh8jJJqYUwQ7yYRFOTfbFwi5nC6K8F+FYs+k2y23Lsbt1nznbiCo5jFAyHSvdhE0BDEF+ZgRwkxLsCty3h06LerzJYbu7s+eEXjb77QCpTWw8A77B/L+xpGXHREnmIr9gA73lWTkjmdow8VWOLGgjZxHqeI+1ASx5LyMh6UxBht7a9PFQhXzIbAEqsCDNxtekDHZvtAdOsBTBTrjOP857wI7FgQcaSay8Usd9+d8eWi64A2L+yT+iv+jfQhaQ4ptCumjKpI9KdhqCER9nENeg0HPRu0r6JSuNMj//2ySYONNKOI2izZVe/HhKS/q5OTCTwpqD/iOkGPTXwDxowCZbiZdO669zlQpjjK1LtTWsZZOhGhc49GrhI0v3ym1btWTr2os//0J9eNKOU10dub0VL1S7POPMrFIN2p/EhJxubpEqAvO3eG1DPnhwE2YmVTNIbuiM5I0P+iOuHM8+qXyifSok20layAQu938xtb7SZPCTi6ACkzvmnmE8TCFOcGSbBqbDDhOKuUoD3TCtB7Ehk3gPEHFDnBHEzmt/IDwYCbqgtlDseaLFtYtW4VvDMssWS1Bfsj9Ly23MKzCzGBuZGlMgCuU+ANBC7fv6aoGOcY41cTF3pvphyM6iz+ruutf7dRi1NyxonQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(13003099007)(6133799003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wI6LFfm7LQ21nurkaDV2LJs7g3xh6u8oWo5zjZnMXH/bTzdWun8fMtf9xZIozjnisbqLF6Y1FsQ4hDU4csGt4h8bfA4w+ZG++gk7cMNSA75KGJDg69uYENb9ZdirwP8dbL4hgZr/xFnBaL6y1wnB/J0hNx2eTbXH9c0M6pKbcP5merQU5M+7HK7vTQ8sRjCu4wgvN9l+IvavSe2t0vBbduNJvx4J5RCPUDEDZoKnPVfogNtIeYvD50Q3k4X6yAnvSwW8xnSxbJViyDbJ/zXnRGsnYwfxPJrvpzOmHCGuW5lICvGe1pZpG2JfPyIDepgO8Fmd5zG26malNs7XsniJUz9nU5a+mTFmCqRhjV+roPanBgQya1PpXHkfCkDuU6tJTrNlF640C4jynH/koRhr5I8DiUsbvWoxHgwpT++1uc+Oz/9vN5i0sqiQDIPvE3r+
X-Exchange-RoutingPolicyChecked: oVk/Yc1HBvi++gL0j/eUwZb/ai5LCpbmJvWBGup1G8aKmQHfAhT9NbYAV2sXf7euDnhsqmHdfAcQ24rx9uDsVGPiLOiYM97gkqQzdl2ZAEqeYTgw9vlrMZitJcaG/BvaWb7LwaQL5/Iq4ZO31QF8q5WMSn0b2ef187f4e+pYzSWD3MtlxMgWQ29wEuevFk7kHyM/CmoDEcneUtXL5KD2+OlrKH+zMNaT4pbYiujG3JAlWZtAMSG1I/qwSifyUxJv2vq1tGkuBidXsUKqGlp8aVK7YVa4pDa8HF0lNEKovHQ9YbKyR3Wozb9zQ1nPfTBG8VZFPJ8MYQ0YT3MhPvB8iw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:04:03.5372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcbcbfa-ec22-497e-75c9-08def4845b3b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMSBTYWx0ZWRfX5xM6qDKOiimi
 m7eknYPi7uQB9+GI1boHksrnCu2FFCJJzHnhd4rtPOcsyqNlRUK3UjUiSdHCN5cjSXunaUkxp5L
 ahZc+XzfaIF+B8fqicBVAz4pcJvIUYQ=
X-Proofpoint-ORIG-GUID: FD2y3WNo-vBtA0FgGbURH63_UHo7WLHH
X-Authority-Analysis: v=2.4 cv=OZKoyBTY c=1 sm=1 tr=0 ts=6a75d7c9 cx=c_pps
 a=rnKATYkPCuOGZDe3J0X1vA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=KKFEwo-sAAAA:20
 a=sozttTNsAAAA:8 a=WXEffxYYdTYOkWummroA:9 a=QEXdDO2ut3YA:10
 a=bn7x_FpfJtc3yKQXRW3z:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: FD2y3WNo-vBtA0FgGbURH63_UHo7WLHH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMSBTYWx0ZWRfX+C9yDRQ9X5wM
 lYZLx/35Yz8s3ce8KXrhygu+4E2Xhy1rEjuyKxNtbI51AX139KoCix82DGGTWHGw53LbgtWSepU
 l6rBuZwxTo6QRkUeayYlifE4FluTo7lV01qARiaPlROSGuhqVKrBkE7GHcWWKT+RgEPfoWcDAxU
 EkQfmmsfAZ9V1Dazdlpzn7UuEGaXKbpmI43mJVosqWeAC4EdiyusOCpzC0tZx+67plrmM43pN+C
 xjOFHt8VVb4CHm71s0pmALP71lCJCjIgfRrevDn4HPfsiGCnSKMphvwAyCks6fwsUN1ubMv1te/
 6KVQsTZBeVR9uYF8hRHd5ziZkRJl4OepSFB8xA+/jHTfVi6MSg7GnWL1G5LO2jLiINU0E3AOpHQ
 oOb3dfGUtT2ijy70lGwUGJ2xojctyE1vTWIb8oEmsIHWwBurruvczk3c69sRMHZX8cKFBlt81Pa
 N7/aL8t9srdJ9QhRA8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070101
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=7FUVlrlFqnp9JyF
 6Z8W9R8eIhY9R8zKo2iso7jyjCS4=; b=YrmgsismvcgwNrm4PmQtOA8BOcCVzBn
 K23luCERc5pJ0csxXyHGH/2tLc2yoRLeuxEzjFm1X9B+QxBzyKdc5/glpyVZbmDd
 t+f1KI+LZELv1fKGmq03fRq1jFZ+EMQv2Q7wYiN91GQMIN3Ya9ID7KtDtw2hk/Pj
 VZvG7KUzNkaNxdpz0deDbZjDlcZH9vl+6oM6Z84hLaFJ1mXH27knLjBhZeHnbHb4
 ujJ84vwYKOJJtqrRVf+dcVbuEeL7WISdk7yMGARel1a/aagNOLht4y8Ef90+uK3O
 rc/3vHRyb0ua2cMlkBxiZIQPidOsYqsH4za4mrMAPiiOD5vvX+yEeYA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FUVlrlFqnp9JyF6Z8W9R8eIhY9R8zKo2iso7jyjCS4=;
 b=FAaHaeSjCLzQjVI54NlRVe+ecNxdd5LXUQzyTF5cvqCz4gFbMJlXpDOZm5tjkakgiEeyPRUoAsnnuc0etxCvPNhMJRwbqQ5lY2Ugnz7G2S16gqqC4N1MATjf2A7I2V3biig3tPdm05j31PXjKUvF5EjAMIDeX4aLl3yxY0Y2aac=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Yrmgsism; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=FAaHaeSj
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

On August  6, 2026 thus sayeth Simon Glass:
> Hi Bryan,
> 
> On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> > doc: ti: k3: fix pygments warning parsing device-tree
> >
> > A warning is emitted when generating the FIT image examples because of
> > white-space and invalid node names. Fix them
> 
> Please mention what the fix actually is (converting the placeholder
> brackets into valid DTS node syntax).

Sure

> 
> >
> > Tested-by: Anshul Dalal <anshuld@ti.com>
> > Reviewed-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> >
> > doc/board/ti/k3.rst | 42 +++++++++++++++++++++++-------------------
> >  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> > +       configurations {
> > +           default = <conf-1>
> > +           conf-1 {
> 
> This line is still not valid DTS - it is missing the trailing
> semicolon, and for FIT the 'default' property is a string, so it
> should be:
> 
>     default = 'conf-1';

Sure. My aim was to suppress the warnings emitted by the lexer. I don't 
think this snippet, even if completely syntactically correct, would 
produce anything meaningful other than being an illustration.

> 
> > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> > +           conf-2 {
> > +                image = "image-2";
> > +                fdt = "fdt-1";
> > +           };
> 
> The two properties inside conf-2 are indented one extra space compared
> with those in conf-1 above. Please make them consistent.

Sure

> 
> > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> > -    /dts-v1/;
> > -
> > -    / {
> 
> Any reason to drop the /dts-v1/; header? The block is tagged '..
> code-block:: dts' so keeping it makes the snippet a complete, valid
> DTS fragment. While you are here, the surrounding examples use 4-space
> indentation; changing this one to 3 spaces is a bit jarring.
>

The best I can tell the DT lexer in pygments doesn't support /dts-v1/;

    https://github.com/pygments/pygments/blob/master/pygments/lexers/devicetree.py

~Bryan
