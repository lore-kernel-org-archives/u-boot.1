Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C596EC5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6185A608F0;
	Tue, 18 Aug 2026 13:06:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 68HXoIjWhh7Y; Tue, 18 Aug 2026 13:06:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98879608ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058384;
	bh=zW+io1ds8jWrdUjehc6Ka/EIC5e2bejj74t+WcIJ7f4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bpjZkQcI/ljCuLqpjyWbhUg4JCazoc3OtPitYvbkV8g87fUVsjsHOEBenVFRGd9OK
	 PbtcKd0JA0/eoWVikc/mHkXr5211WUlCaOhaUJ3j4SpZDNOJSgZfsDkG27Nu9KNKhX
	 Xfnh9ihlYsjpCCQOUwF9XyGkLpxbHPp2jPxaM5fcZhRH0Fq7Hcev3wX8cwYDJst2DH
	 wRE8aLFZCvgAl5X4SQIeqKYVZv8+Cn3SknV9khKDFrk09BvBXqF6oswudpAdOZSxXG
	 /cQuIUHhFYKym0bA31MzL6BLegg66MlWiUKpdrYTsAzyQ60mHmmigZ/4UdYskecibY
	 etrfaBubzgnlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98879608ED;
	Tue, 18 Aug 2026 13:06:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DDFC230
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 044CD60878
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zTx6fUGlHA_9 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 11:54:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B9D58605CB
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9D58605CB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=f/PfJ881; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=oF1nuL1i
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9D58605CB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:04 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67IA6PVd3322543;
 Tue, 18 Aug 2026 06:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=zW+io1ds8jWrdUjehc6Ka/EIC5e2bejj74t+WcIJ7
 f4=; b=f/PfJ881BUVEpsauGwICVJ3Noq8gAi0dUhKk34VSnsa82YkBNnXrwAErn
 QWQ7bHyFV5s6zMbYAilI4zd0zQdyZJjLdar6xEZeQ/sos/oFCWtCfNf/ZRAxyHOS
 jjkLJWfXPWly+gIRAlbpncpL1WEzQhvh6xYU8nYrt1XlENCo2NGfj0NKOmCQlA5D
 uJX9WNAt9vLLE01Ei7nmsGls98PYjctfGXRyczALJEL00WZnLIg58c5zVpdHYgQF
 EK2bdGdGc3wbXN2HZ2tUNVG/ydVehqmbRxQt7h0Jrdyc0FGMCo67+QvzZe2vtEMk
 aEtij6RHEZTziO5Hd3Wo5FXQQ3pVw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g40dm7twq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:54:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plPZfhhyS+vvO/Lwu2vGdjFNBQ1XLqWMgTORatdAaPpnV7XuuHGqbuqVWKoUor2ph00HgABk+tLCP+7Pr3QKJdJrDBcxV4PTjpS2C0uu9dHj+TBE+MCBnVYNZmd85aZTBt5N0FgZo74Kgcs/p1+H5O67d2YBn0/GuA0LA+irnZazHLiHugj4xJFKLEH6uhPllIJWuznGyWX135w9k3SxoH1zNW6elC59Y7YAsjfsevrq3q0jAFor9RaBcw3xTmywg7Be9OJJlFjE+Xrgh004zaUJwzklEg7ejl/NA+7QUoaS7Pq7feffikVKP+hvdCysXi4RZb2RU7+0VvE+3GAdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW+io1ds8jWrdUjehc6Ka/EIC5e2bejj74t+WcIJ7f4=;
 b=vpXtUr8ep+0VnpLnAzig2D7Yfw76LC5HgxtDISbYN/sCIjyWNyeCBicP0riXgMQpq8sftZtCROiO94ov2K0P84ezJE3zVRDnGx3Cc3BSdkzjAkO5lVVPLywsbQF2xEWE7k0XpwhdC/qZIYyN3oVgeYP2R/P7MNZFqDVVMwGRkwTlAFu86p9/EfVItX1RvL21hL+mzTwYU16Xr9LADyh04ljXgHgnNi9qnxggPcFLDzuBSNZMXeQm/sVSFwXPHxhdymkaFvfE5N6xLS4u4PS44sZS9arrC/HX3hiyJqjTND8p9jzD9A5onpJA5wOoCfXc2rfVaNNhovsZYeVkiZ7XsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW+io1ds8jWrdUjehc6Ka/EIC5e2bejj74t+WcIJ7f4=;
 b=oF1nuL1iAxn9NoujDNQRsodEQWUbtCH9xrh6AH0n+cyXlP4PR8Doxx+0vQwUM8ouaFJMM1kpH0eEbml8PzS26lToVUGD9qYeQw9AkI+h2ePUXUsK3/8Zwi2HCR+rc5WKEdcDkFPgk++O1t7rKnAygehpMRmQuju+olEvb6+Tgss=
Received: from SJ0PR03CA0272.namprd03.prod.outlook.com (2603:10b6:a03:39e::7)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Tue, 18 Aug
 2026 11:54:00 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::7) by SJ0PR03CA0272.outlook.office365.com
 (2603:10b6:a03:39e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 11:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 11:53:58 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:53:51 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:53:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 06:53:51 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67IBrY3Q1372974;
 Tue, 18 Aug 2026 06:53:49 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v2 1/3] configs: add no-SPL mode fragment for k3 devices
Date: Tue, 18 Aug 2026 17:23:20 +0530
Message-ID: <20260818115322.101705-2-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818115322.101705-1-g-praveen@ti.com>
References: <20260818115322.101705-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CO1PR10MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: d575dab2-6620-4c2d-5641-08defd1f6325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: uaMzzQiEXbt8ayGHySX8R0z4O2cQ2nOBKet+emkcu0YqoVaE0x5hkutRT44zMUEvUpzIbtrTevpVpXzDDoeLewK5OItVwcNkH6wtyO/XTQj3Vo7G1fwRYMNgW8Mcw9efWiK+xDWcA7UDPBGqcXgvLS0Cb9ezF8g80XikGwaH99Oaz1JAuTJjv6Fp0Ix1LYMG7bQuE+WsNs0ICIWeft50feeFzL06sm5F+WILOKBLIpfYXNSHxb3U3P2uMG3Ib6aMmpL0Vr74l27SLkolCCS4lkfN3sk+RnprVhWg0QrmtX0LDHr0tV0ZJTcUTGLdWEW1Baj+KYXVAVccLT8dpV9jnjqB64bGFNpyiKZkvCWmflwpjeBWlGCH2pZtz0z/JApyswNKJIrh7AassPhCvbyXVMNIUwaFem7m139EKW/3NdFiCJ8DnXE3x7zjrexPuqQP14Xtfoy7Mh6r2OJwQmSFn40cq0ZGwB8pmYIKQi+hdim3mII4VmGv7RH/m+wyex/+lPaRlxSRqzqjfLTEvO/8S0P9h5n/RRa+uFUl/zpxuEP8h51MRd6YuAbTe4dGshNmltEgJQm3L2/+wPH+HanBZ0KBbWCt0fil8HfdSDJvgMAsQGeVw9DyobgCNTmUq2ALEutlR0v2G/40fnwnE2o16SwPxyGki5PiaG655YF9luqXa35XE0sQEWAurB8yf+7C3iO7xrUe/qsB2IGQrNj6RA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iGHJ7H7c4Rzv0IlRrUOTpaA3/AI/J2Hej2THNVF2X0OH0O1LjHfvpRW9Q96zrG5BDdi1/3KrqNFEaB8TYRr9y2bb7ftroXkb196k2Xw8n3hHxFYJNUREdCvOc1N2wsmsR6la61wKF8YaXCgL4FV+LOR4SO7/AVJgLvTrEhsuaMCDOyF4cC612M9m3EEklV35ytk6snsiJF2R0ISjH6EtkL9SR6FiHVIiPmbpomD8VHCVyU8inNz6ll367uqSQSEJ5f/emUGLThItr+7g/G3f0C+FAJ1rrlWrlDOmfT63dMWFYGh69wCnYaAvwSEy6gFwKOgyGcNqP0IAwU7I71qQXKuKguipeiBLYBzCqCjqcU01fan/RD4BK4QIxH/5yqhc/v+UiQTV6NGx5XrsHojoMYl6heXWwRrFPpCG8w8j74Z3mmYMb2kz1h0+vXbdiu1W
X-Exchange-RoutingPolicyChecked: MKsd+cgNlPvH5+CGe2Nu4LSCTogf83NYKcO33g1nM6lKZVhQs9sUYGM/EKcQQxN57dYLcWpILfxEgyfyioWHMWBbYqO99Utva+wbGICFgJ8EY6jxoV82SgMtk2aJnuSuURzi11Dv6DQDBHn3seDawU0YHZ3LoO131EoXWJDuTECXUbvPrEtsT1MPGief62ZQR4YRVQGgN4DnS7c8IqOpL5k1Z7y1ofbsFu9GcDuPSA8TFYrlKEzhqIV17sibxAK/brh11zup6YfhJtYflKq60hZhXYov6P/vrnONbdE339IaNi756wkHtaUL3JVHMksi5B+g9h4bLG7/5GFPpH39Og==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 11:53:58.1224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d575dab2-6620-4c2d-5641-08defd1f6325
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfXw4B3R9EjW/AF
 BEs03ni6VgfN3oCqBpl50N84ASqf9JtSSVQAIkJQ1ABgmYUNgHoCAoan+z9tb/V7DZhhcVzMcWE
 Sfkrgyhhn4VC2DygUCVqz9KejU3opfPkVSZWeHVb7Ged2Yq4PAHI+Tme57K5ZJkqIGTln+Ad0bx
 jVaRnl7n9qCm5WdePY+lvE7HmNsoOF8QN6Rt131TRDoJ0RfJ+s9Vem5jbXdHBq0oLAqAf/oLnbX
 pHO9wF45hw89NZkUhEvJHG+i8YqCDhNiYJZ6ijzSacEvIZxdSEJGl4wTj5kXQYoc4+GD/VTbP5T
 RbIeCCJLNoemhDSujL7/7knJLIvFTSUkk97r8MVadoEnScPkyTrhahkTSsfxpAsHL+k4fIFWVfF
 3D8E1yWCllAQKEf+BTYPpGPOvANOQLUY99LGAY2LZFbM+5s1tuUX24XphxXglH4pDp0RJi/pVtN
 Io4NfrDXnFhXWa8BmNQ==
X-Authority-Analysis: v=2.4 cv=S8bpBosP c=1 sm=1 tr=0 ts=6a8447db cx=c_pps
 a=CzkwbHv2eVnX1aWe+0O+5A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=TwlV235Zt6HhQwVfNlwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfX57zHwUo0I9yi
 aLe4pc7ZrdSabG70mHaGErUUkGdHasEHSg1ZYk9FFRUg6GvXtAO2+cy8/zp/QkgyNsy4AdDqrB1
 ThsBa1T87Xm62IJtD6Woer24zWQQ5E4=
X-Proofpoint-GUID: pdpm2A4aOkFyJhNT7E6RqJRo-dOOjhiP
X-Proofpoint-ORIG-GUID: pdpm2A4aOkFyJhNT7E6RqJRo-dOOjhiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180087
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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

This fragment enables a boot mode for K3 platforms where the R5 SPL
directly loads U-Boot proper, bypassing the A Core SPL stage

The R5 config modifies the payload filename to load tinospl.bin
instead of tispl.bin. The A Core config updates the U-Boot load
address to match the A Core SPL load address, allowing R5 SPL to
load U-Boot directly from that location since A Core SPL is not
present in this boot flow.

This reduces boot time by eliminating the A Core SPL stage.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
Reviewed-by Neha Malcom Francis <n-francis@ti.com>
---
 configs/k3_a72_nospl.config | 1 +
 configs/k3_r5_nospl.config  | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 configs/k3_a72_nospl.config
 create mode 100644 configs/k3_r5_nospl.config

diff --git a/configs/k3_a72_nospl.config b/configs/k3_a72_nospl.config
new file mode 100644
index 00000000000..7522acab950
--- /dev/null
+++ b/configs/k3_a72_nospl.config
@@ -0,0 +1 @@
+CONFIG_TEXT_BASE=0x80080000
diff --git a/configs/k3_r5_nospl.config b/configs/k3_r5_nospl.config
new file mode 100644
index 00000000000..94931bf8798
--- /dev/null
+++ b/configs/k3_r5_nospl.config
@@ -0,0 +1 @@
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="tinospl.bin"
-- 
2.34.1

