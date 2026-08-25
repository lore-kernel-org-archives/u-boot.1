Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45306C61DB6
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 09:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E97A360619;
	Tue, 25 Aug 2026 09:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bExaONIKzLEY; Tue, 25 Aug 2026 09:43:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787651029;
	bh=QCF7v8BgYXJ8AmT+DixWpuWufMfYOzBKtrzHj79GJyQ=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=05tDI52WJTs3aoxA+71uGSB9kTeB21EaHIlLoaFG/DTBidlMM2FENPe+41affALwf
	 QG48Sg2Y2afQQy6zL7LsSYqd3nPZZK2WbPcWjV+DdubA9HGD1l0D0frbQ3PQ1R+OZx
	 T7mtFVZhYumW3FQ82TPzn+epNjHHdCNQ51PAVR1ulYHOBzzUe8x9yj5Q478/dfge2n
	 SoE1llcommo08q8CifOakNOCjtGfrSwNX7Bo08pbLvGTQ1TMx1+Jfqu/VmjUJs2r5N
	 PgwiNtt97x7zlax3jkQdqItjWJ0sbTOEaE7J7pQGpoJqmu2sdzZZ0QiQRoxhNS7Tig
	 f9lcWiH+Gh4BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D02076060B;
	Tue, 25 Aug 2026 09:43:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4CD31465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 825D080C70
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIVazh3_zB-B for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 09:43:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=o/rpelf+; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=SG5chzYz
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6571180C66
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:43:46 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67P89mLj453891;
 Tue, 25 Aug 2026 04:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=QCF7v8BgYXJ8AmT+DixWpuWufMfYOzBKtrzHj79GJ
 yQ=; b=o/rpelf+6kwjJ20ccDLgKpLFEEWm1EXItjXAEe1pPDJRG4lF/QVtwq7Is
 jNnq3ivr3uRMUGZXmDwy53ZKoIGfx9JpJzupcs/wlEaihuMA7Yd7z23hfw2DJAVi
 U5kBlhOZrj2etOgqwO5nKN38Vuj+OH5CqiZS6ujrNWySNCBFiTCiwp4A/w5/txzA
 SIItfROQk2h60MKiFQM0ec5FdPxsl9vkeXTvB9xAlt30l3NBXoue4Q7mTmUGfg7r
 YF22ra+QCd190rKrSloFOfb5qXStbTmp9QkNvauGSE5ebX7kNvmD0b6225WhuNPW
 WIhlY3AMYC8idUoBD3SxEjY0KHoDQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxj55k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 04:43:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhItQni1ACCOZ3L4sHrIFj9/AAlkjX9NIyP3iBf/kvbS+WhLL0GZWNGG/6ugjJ8KwOMBhvrOsfCAhAcimlV9mA0tXhJGw52cHVBqMjEwVW8POZ9WJKsn1RGIQWDckRHiD5konR+on7P4T3rLl/6YMgL9TrICwjHAJQx1XiBYZW91FSOXu/b8BoJHMVvsj+Bvprdtmnmc3RjlzEo0mn02thKJbS6CBADyLNcT0SYt9ukiFuGTCU/xBh2gldxBLCgCf9aOa0Slhua/xANmFksXE2DVo1E78TobC9p0t9M6jjmbVz29GLEpIrdu0QG/ZcHzhHbUmTp0fiBFYgffNdeL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCF7v8BgYXJ8AmT+DixWpuWufMfYOzBKtrzHj79GJyQ=;
 b=paSHOg9sbRVDeFHb5jxSGfSfXaWHg90qEHHyq6W6cFe1c7N4gqqJX1MYmmIfoAz95RS9ygvZKq/HI4VG0MNmzBMCk36VOS0iSaKF3g1Y0hKEHvB63hQBr8yHJMIHzE/GbFK1Rr43nlS6fPxGhCJbzk4cAHx6NTjU+ZT01qUliRnwpuLhpmxAbzBEQymTlpgwJ9TtYp0OBCStMBVEQC1XTtkLbzFB9B7tQ1wO2ucvAtIlbs+Hop7qZnymaEI0m9/b1T+U9rBGNcaFFL/JNr12Woz/ipvjP7bxSzXjEcmk46+cRWP0TCKWzm0QdhokXzCxd168ybvgYtja2V4CPlKGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCF7v8BgYXJ8AmT+DixWpuWufMfYOzBKtrzHj79GJyQ=;
 b=SG5chzYz28uyPfMrktlljvGcmQ9UNJo6021cqhqM2wV2emll0jJa6L646I0F97Ow0uGI2dpTWg6gHl674KDGOdm2yUOZ2aHoaXltoUo/qeWualvSZrrQap8uRID0qFsNZFx+VzBNpREyn8sonhc8LW5C0ZdyN6DV+LWDabwnzv0=
Received: from BN9PR03CA0421.namprd03.prod.outlook.com (2603:10b6:408:113::6)
 by SA1PR10MB997607.namprd10.prod.outlook.com (2603:10b6:806:4b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 09:43:05 +0000
Received: from BN1PEPF00018070.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::96) by BN9PR03CA0421.outlook.office365.com
 (2603:10b6:408:113::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 09:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00018070.mail.protection.outlook.com (10.167.245.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 09:43:04 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 04:43:03 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 04:43:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 04:43:03 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67P9h1u3749248;
 Tue, 25 Aug 2026 04:43:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 00/24] usb: dwc3: part 2, make the resynced code
 work
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: <marek.vasut@mailbox.org>, <trini@konsulko.com>,
 <ilias.apalodimas@linaro.org>, <michal.simek@amd.com>, <lukma@denx.de>,
 <alchark@flipper.net>, <jerome.forissier@arm.com>,
 <dlechner@baylibre.com>, <anshuld@ti.com>, <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Chintan Vankar <c-vankar@ti.com>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
Date: Tue, 25 Aug 2026 15:12:59 +0530
Message-ID: <178765097973.1498018.5668901885485543636.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787650981; l=1762;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=bqUIJ5v4s1ewvAzOavpv6AJ8KwXUoXiv/GP8ZzHWUoI=;
 b=2GEjhoDzoMzJSn/dCv/VR7Csf9j0WF8KBN5/8X9JSVSw+VWMf0ELZdpgWs/ks+N0apjP0zr3j
 AiZhAxaCpfKAyWjbZAK856hIDE7hGkDTZ874jQ4dHjeYmHDtYK+jMG9
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018070:EE_|SA1PR10MB997607:EE_
X-MS-Office365-Filtering-Correlation-Id: e74679d9-595a-4b01-3c4d-08df028d432e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o7hTuWmaH+8B157j6EtKRPOkvfjGpvnIM6o5RtTfdCjxuMdLgSroxhy03Hxxo6GMMHGdlVhXhGws3NBCYbCmPE2AXmZ638HL5h0ORp07+Y6ReaCZH4C8hjOQeoIymlIYTJ7UQzE/97YgfRX3P7fL8I1oqRU7UIAQ2E55C6jZHrNyXY5W+eTt7mVRJMbUB3z+nhL4N/WzZsQVJbmMZwo4p47ZvlCmlsdMGscw1Sq1FGU/+iUGuiYGZ7QRqomVWPU6VBRsjuPVIlEmMFMdmfAui3xBI1QOPAi2ebYnw8elZyAgc6n5PjNserfWCIV98n1X8qZWvb995+vUAP29jyzBH2WDYtrxcSZOyNo6EF/vCSIBKiJKpJAc1IDJDrSM/RCgD9j3yP0IBLV9arjp6oX/TcvoRBd8D9N5C+yIS5tEnX5W2tLMZ0uZB9+v6jpeUJt6ekU+pi3/1FjNCMZgQLB6pVVoThqUfb54aDbokkVJP0Tj8F0cea2HXPsvGKZlAhufsPH9u//SVT6jEgwU+4bv/gYaYldKtTDb8W0hM0VIwQsTHdAS3L1RHzZ+k/gUYOnn9BQS+sJ3WseQ0ijWPLDYN0+LK8Eqo+SrpaS3er+1Qkr3GtKPMiD/HieWz/F+FNp1aVjYm5yW9+v4hC0Ae12giAkcxexgjyUefmxNPiHi/CP30O8AjOvvmPMlBckENbzEjv/JJ0xi2GAx3jH4Ql8jOw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YlzxRZPZPyvq+TrI+og9Lij/KTo7iXXBp02LPg8KONoDKaiyeUsdH5N26tNnKvLwHlnh+T7N1y5gsUFvKbC5xF2Js4jDwQPoGquIkMJAzX46wjdqU047l7tWrZsdNPNAN5P+I+g89fPHmtSkJi5Oe7RWGzzs9/JpbG2NBkzBMpoRYrKN5hC5fQqr/qwi21QkRii7DfpVhUydDwxrSee3xEsGypIuLkMNXVuMuVMi6Xo++VvFsqFENGJ262meIT+UGNL4D6sbhhC/iLkB0OtHsd+dB+mO9S2gQ9RV551rFSjr2RLHX9sujotyX66KEzKhQFeFSjFHoqtBNoQcg/KMIeXlEJFqgOSwuRVUiyHOS9D6j2C7DQMhEYhRV9eqtlxXJFGdley4UIfMAEo6a33g5frpkChefas8yRMLbNaAsAv/r03up37z0LC5ET9O75xy
X-Exchange-RoutingPolicyChecked: ecB+wPStuIJgj7DDe5FahBN8Q68ty7sconc0/OyEIG377Js63oo3HLph9CwGbGAwIv4DulANf+XjNFArOrj6t9cyQgSDNyC7vRghx/XJDwv0b3W2GPt70m+waUYAnwiGE9B5pYRXJSsuY72PSd5G3tdQNpviBqNfjx7GoB53vfEilGdP0L3q0gM7cQvwsCup+uiauW80oH4Gf8U6hM1NEUyRqi4Sj1BRiT18uT2ZWqd0GXT6A0LMx+pqzfpdmFCp4i1gdT1lCBGbI0cwEsBGLc70hT67duj9OuKjbxX6hN+tMG4Tetrj/Ym5vdH04Q80IxYvDFptzfNhdzzQXDCtVA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 09:43:04.9319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74679d9-595a-4b01-3c4d-08df028d432e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018070.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997607
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4MSBTYWx0ZWRfX6nzekXnIYesz
 DpEwEhkcWlX24xVX2Hs96QxKLoeONmKodZLR7H/S0Mgb2Iqb+bgWAcbqUDIh7CbUiQHbpB0i8iY
 OXY+5ULaefqTFUlgljkL5UoaaQc1NMI=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8d63ac cx=c_pps
 a=vzv6YJZFwQv9rWyERtU3yg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=KKAkSRfTAAAA:8
 a=sozttTNsAAAA:8 a=PlQIMhXYkE4724H6QBQA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: s8N_-HZAprKx0RR8XtqCwGixI_qGoBYm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4MSBTYWx0ZWRfX3BuLQfICMw4L
 Iq2kIYb+fYc2No0MbpubPzNCwXjM3WPJuxCgSo3iD27RwTPcKRD3Y89WOVisFJ6u2t0JpEMrsKK
 zo7k4xKem6jBRq4n7Jiz2fENJC6lmg3p/row8khTLZMLyfhVn8zTh99KueCAHQFkIwMmY1JfAbH
 kD+p/UO/9bgX7z0atgSNswbtLtPiE/qcxTJCafTsFHhYmXxLKfMWTPPiAZQKtg4xoM7LxnLsv6m
 xLfvOcWxuS06SYmSK2hg1jEQFE9G3YKG0Xwu0B77OfgOJkxQ6OK9jz2meB6KakfviRE4Gl3jdbn
 tZzPqZyKErpWeRXOtFESJfPO+euhnkF8kmmCioyHCIsc70mi7mwbhjIDWeF/bhAPruun9vDFH9G
 JkBCFxPlCM+9TdO/hOdK5G6SfFBCGEDa/yRAu6sqGE1aAKVEdENV5ojvUR4XdpJQtdBQ5cAPIu+
 E97QSknZqp/3B3R+ufA==
X-Proofpoint-ORIG-GUID: s8N_-HZAprKx0RR8XtqCwGixI_qGoBYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250081
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

On Mon, 24 Aug 2026 17:41:09 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
> [...]
> dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
> musb-new and mtu3. 17 boards in total.
> 
> DFU is tested on hardware on BeagleBoard-X15, and on BeaglePlay by
> Anshul. ci_udc is tested on an i.MX93 board with ums. The rest is build
> tested only.

Hi Anders,

Thanks for reworking the series, I was able to get DFU boot to work properly
and the usb devices are being discovered properly too.

Though I ran into an issue while using ums with your patches as the host isn't
able to detect the connected device. With default logs I only see a
'\dwc3-generic-peripheral usb@31000000: unknown endpoint event 0'.

Further debug logs are below on TI's AM62p EVM:

@    => ums mmc 1
@    UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3b72400
@    g_dnl_register: g_dnl_driver.name = usb_dnl_ums
@    g_dnl_bind: gadget: 0x00000000fde7fb68 cdev: 0x00000000fde5cdd0
@    usb_add_config: adding config #1 'usb_dnload'/00000000fde83cc0
@    g_dnl_do_config: configuration: 0x00000000fde83cc0 composite dev: 0x00000000fde5cdd0
@    adding 'Mass Storage Function'/00000000fde5c110 to config 'usb_dnload'/00000000fde83cc0
@    cfg 1/00000000fde83cc0 speeds: high full
@    usb_add_config: interface 0 = Mass Storage Function/00000000fde5c110
@    g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
@    usb_dnl_ums: ready
@    -dwc3-generic-peripheral usb@31000000: unknown endpoint event 0
@    |set_config: high speed config #1: usb_dnload
@    \non-core control reqa1.fe v0000 i0000 l1

I observed a similar issue on the beagleplay too. Regards!

Anshul

-- 
Anshul Dalal <anshuld@ti.com>
