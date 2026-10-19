Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097E2CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2CD760722;
	Mon, 19 Oct 2026 10:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6RtSGz7KCbc; Mon, 19 Oct 2026 10:41:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 85C5C606CF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792406492;
	b=HxONcDzoD2KjYDUpsnwNw5nqiEq74vQdPp57xryykAy3bMObNNBiP/A30wGhUfe2oRXD
	 bb4xAHLjjS0HVgsqQ7JsrtGaWjIByOg0kwf6fQwIFljE76GIpN/qrZvbfCDxhojV2pL1l
	 Kdr5hGrOIplk71IoeM/s7umky4d442RnCNGCM06ZjgAbmmEsn/z2z+S/2qbmfg3aOhISS
	 SsIkpVglIPY51ZoNxgPlksBFwuTAY7EsLIZ4DuVrtBkAKJbgu70JjuYdMtjPQs6wRd7SC
	 Ww31joDDITqb2j7OS7mYesBe30tIShMGp2LYPC1J4koOKcRSAnrRLxjtbzOL9qZ/Gmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MNy3BVQZIMy+wL9KzWpFREIYaTY3J9F/1aeTpfaxDec=;
	b=oxnEnmF9VG5C8ww61KUdISP2ZnUFjxtra5dACGq98EjAnWQiblm2O8rvcUqWHGMEjtYj
	 SWN8Ww0/OAXq9ptM1shZH5J7nZ5Fyfra5gVPioCbAXLxIoK9w7J1pi3Jy1+wAmzNdZAqo
	 1Lq5fw5UcvHbZN3Ydym3t+o5VnDFL+wEVvrBzVaF/xb1rLNWhBcO45asDlqEtD00TLa+V
	 GKHVtyAnT7EgiG/mzWc93+Hw325DVq6IZEv8dNQUdtqf1xoTv2fNhizPRrj/Ddhah8G5c
	 aWbOn4P8GN7U9MHksR9hCbFtAgcFEzNj9fPQDKoPeW6r65GtRbrO1S+l5PgRAhCgOug==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406492;
	bh=MNy3BVQZIMy+wL9KzWpFREIYaTY3J9F/1aeTpfaxDec=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CHCk2q85H/PLmrDro9qs5CSMwL0NagvbC23NCofosfml0l/QFX9ilJOmTRnG3PqLu
	 JUBZ0I497+t7k0cIW30h0Dl7elo23P53Kf4p/PSgOsDxmoGpUSe1ghfZjcqKMjbPwm
	 LUIg0mmqfx1FbIUOM1yXhf/oZtyZdpuXla+ThMrBRH3zvBC4fvWAEXh8o5FPORN9o1
	 o05W4scztPSlHEZnnPdG7wWQWTEFuGZSd34IzCwKeStNbFKijuMB3WetjDNiRBSGAG
	 oKnARYBqVXUZOWVovV6F6Za/DY67WL/Y3PHQL5jBCfJrmSFZBvVpDjawylQ4ILER2U
	 mdXooZPu/9DPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85C5C606CF;
	Mon, 19 Oct 2026 10:41:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 118E0D7E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F3AD406FC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8NphuxTNSrE for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:41:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D177F406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406490;
 b=ghoOpeWoWu8ZJnglmCFin+wxytSWmpGVTiDkIgLmgVgkXtBl/7rwIQvUmUdbMb7ovFAm
 rrWf8zZzCQ0cnrKAAxx8VNwEb++gcHdFc8w9nccnOca7Mqvnozj+nAofkKUSlQcrHc+BS
 vymRlctRN7i/AItr4sSl7D/8733v38WfekewCEHrCDYEAM92p5kPPjtzBo0s5hPblCJsi
 g/ObmNl/fz0WYxVs1Ucll6Uw2xU5sFTuQP0A+PnRCmaGggXjFSloLjHYbzaJ9mwZN0/rC
 NzCHm2O4uiXwlXddwf7JYmuDU+jimo9BGy7BhoXP3zXeg1OVEgRO6E62p9iWdwMSYsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406490;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MNy3BVQZIMy+wL9KzWpFREIYaTY3J9F/1aeTpfaxDec=;
 b=LhfMqhJ9tWLprNc8SEyFDEttYK3RH1fqNdXsC3JTF5ej3+rakY2QsnYpci1y6QzlKFZG
 nzahYnnjntUPOOOxoGhMBPZzputmlsZgxKjEJZqqEmhtvArMJCbD9a8eEbBRgZDTtPlKS
 urmVemkdAVFSnIZw/hfkh9TwbYcXdKs0OHtD09FVpyNJq29p2+vCZO45DG9BMRB9Sg7gP
 b9muLkNIFxd7Nn4fe4T2V3uF2T35ozWcC8+LSN+MJTAx3s4hQHLi09kOdm+zKdiJpfL4o
 /ROV6IWO++4rg1oCKanii0/euzHVPdM59aWPfG4IWTPkNlV9Es5KdHwnmiTKC0fitYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cAxoDg6x; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=Dg1mH7iN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cAxoDg6x; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=Dg1mH7iN
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D177F406A0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:29 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69J8MxXh3814258;
 Mon, 19 Oct 2026 05:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=MNy3BVQZIMy+wL9KzWpFREIYaTY3J9F/1aeTpfaxD
 ec=; b=cAxoDg6xJorexGAW8VOUCie/AFeyLZIcqSMZLuLh57a6DJXX3vX2BiDYE
 dec2xh/OvyFfYMOudAP6Me6V8vs9fx9mWLbSkKu3DibUoxkL/8qMlnWTpOQTmi2U
 Qqb649Cc+M4dyhWBObXBUtcusZn/0i9R9/wSiAP0TrwovoNQ3fWbNw8POc6UMwbs
 ZHob3JB9ZzAuwYwfyqgxq+K5rdhuu2V4EkcZDvIdRHIARg2iTqO5YGOkKoUermZv
 natfCM0eIgVxQTyAwFgxyflqsDzwc7A/7NIwt4EcgLyP5GjbxBxoylZ6D4J8LQ30
 ZEbWkIlwjyK4bW1iP/YqpW7z/Ia3Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hct1jn5k5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:41:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm4pkB8Mkm4zaE6xonScS8+J9T8drneOi83TMphe683CwIWx70UyvKU959ioJ//OLYioNHQYR5B0JwyDpbNAO+GufJ+m4zK/JRQ2AIWtnmtkHvbKzb9RFjsmvWedyCo7HuIkJcl3ZEIe3G95+wqCV99G4YsSBldAcLdu20wZqk4lsHdNdsnRKLJsDtCr90SzwAzIj+GgPyJoRmy7De7j+O3F7mFJ02tEzqPuVY/NAD3oMwDVzwiGdNnHmVm/zT/ctsK+FLcuo5VCAnJ+Vu/LS5F7HDjpw4+R+J7QomicLHTaf07w+NxUcMInu+2hDRp4eYnTkASgc59m1hpAx255wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNy3BVQZIMy+wL9KzWpFREIYaTY3J9F/1aeTpfaxDec=;
 b=xLOgxJtqJABjSv5qSBXWMX+pCdCpvOWzvA0P3Wu9dWqMrs9U9G9/WRlzEbMHTV3MM6C5uj/3D7g3+RQ7bqM+R86kByvj0h4+tD+3ftNynjlFKXkAXk/cIi3jG+w+Js470+o7AE+gK57q6WoAsIjEjNCAp8d+F3xo7EG5cBe63XnJ3XUbm89zt+Fqu745B9ZnBGPC7TBAUoz3nHZgAnbUIsEBPHTbD60ffV3Y+yrfdU7a4GeH2oTQOAvNvY330uNaBt5O5vCXkhTExHYnHnCVDEc3QbvlyIJyDlYK2lOm8V35S+s9bJOhWAwEsh5QqeBGXpMJuAuUi9ZHZSH/a3mMeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNy3BVQZIMy+wL9KzWpFREIYaTY3J9F/1aeTpfaxDec=;
 b=Dg1mH7iNYSSD+cxtU3HU5eegvRkRkHGMIM63Ixj6hPWShc0asxL5qAt2oMelnFxtU/0sMK52Zt8cennS7aVVRUJDXxQzU8b0E1yVm1t38T/oiHhyEYOgTXVOg3tHGUHiIJV6uYan8CkIG67mjKmwXjROXy1RhTYubkgOiqwUgvQ=
Received: from PH0PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:e::19)
 by IA1PR10MB7142.namprd10.prod.outlook.com (2603:10b6:208:3f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 10:40:23 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::4f) by PH0PR07CA0044.outlook.office365.com
 (2603:10b6:510:e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 10:40:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 10:40:23 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:40:05 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:40:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 05:40:05 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69JAdgTl2629975; Mon, 19 Oct 2026 05:40:02 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v8 5/7] remoteproc: k3-hsm: Introduce a remoteproc driver for
 K3 HSM core
Date: Mon, 19 Oct 2026 16:09:40 +0530
Message-ID: <20261019103942.2497201-6-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019103942.2497201-1-b-padhi@ti.com>
References: <20261019103942.2497201-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|IA1PR10MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a25f1a-c3ac-4e30-c7a1-08df2dcd6153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|10067099003|3023799007|13003099007|260925021911599003|260925022911599003|260925021311599003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2TS3G1A/ppKt+KnHwhNCnJiVB///N1KkQ7jxQ1D2DpPSIZW4QMF9cZnQJ6eBDL6YUhbQOaGbCJCXa4rHqZmNujmYmQSP4BqqgeZs1YMJ/FXIkoB6Vl7cd2sxBQHkpKtKYVEc4qHEd50GVPyXPD1aJ0t+ED8Xca+jY/hc6rUiyv5oz/2JRIrJ5OTCRS8/FuXOp/67jrqhcny/t4fkRnpbp9fRuxBkSZRFFiY/XdMHNl4IC33Q8QQo9HHcwYA9bbbNTdT5M1q9wXLHrTRYKRuk0n8hG/yHj23Ls33bbk9fqtKLQASuEK0dz3lRO8lzNkrpohWDgsJXnI42CmoArArEv99HS7NL1oW3HSfSqzKIHaJDSFW1x+cfAvDXSmCeLzn0RzTHzHAJpEA1Ae8emSmVA8FnQexGQFbkcLwTehayLHzuKuLdn2U5A7pgtIe+I3MOqnwnM0zTB7Le+CssopmUXpnL7d2ly2eiTT8Qwagu5GHPdOcmdYujlcAfv+gRadN8XozvRZI85HZ3RmomSS0leXhV/Uoe3932jYQeMQMY4j68BzD56lNP3otbRwspa5Vj2SngOhVyZ6cs14NQfsLTpfkdA/y+CPEt9NLGjxBAzwFj1hy6cwwPTGOIou4GVGmFFUGZp7fp3B6xwJ4vK9QTtw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(13003099007)(260925021911599003)(260925022911599003)(260925021311599003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vGont1VAYJwTor8CGffB9m5MLniGNlNTtSQG4L1wb+v9f9d4Pl9RTHCFRns3Ye3s8CoX29WK/toZDBPtg4W9lgHHyl2LQQJROLquAWXGCfGekVJ9qsjaoPSC2a7q2E6qEEFX/BP5+JtlpmvgrrZRHbAgwr3zf0R//EWK67jvXDr6kmesQdBCwaR9fKiuKBanN2DFTFayx2CpGCpk1+Z+FwGwolRIZGpy+V4g/idFX7oFJZByosmp4HkMxsSJ9r6VRQVe6wEtUITIn5955phAocmFiYTDmeYTf8En+it2KVB3dHeH2iDl0qlfFfY2P47tt1viC9wdphQ3e3sSU091IHWq663uGQGcZKE7PPJFphjIHSrCUA77Y7fa7xDsNsj9PJ/m1eseomzz2ev7WqqHBwqZxkn3a8oVrvQykJCMSnEv9tFLnSvTv20iMUPUdhEv
X-Exchange-RoutingPolicyChecked: cENnzCfg20oyBmk5o7JRyqdvXXOPTl97/VKOMjy5eq2CUWXFgRMtRuUoWKD824hSEHe+iGffEAPggwFxW3njZOoM8Bbf0VdonCcy+4KLd2jaX8ZNJvYhTzKBvSkooZ6r0rkMN77YVLFtC3cQYzsYc/X9BlLyMOr0ZZtTHwnpfWWlSjkghYcUbtdGL1+qxpwBavq3syf/kfENn3KCC8oQjnD06EQV1x1ggVfU/5kREIz8O3M9d4GZUF7yaCfvWIfJvRuKSaL6GtPePWG9mxWUMG6zPK6oKhRuq6d890RMULXStk7EsPdWYeejo2aGA/ABiMeRZnxHgdLbceu/U4Aq+A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:40:23.2977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a25f1a-c3ac-4e30-c7a1-08df2dcd6153
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7142
X-Proofpoint-ORIG-GUID: Jfnt2dUvTs_HSrlxMXzMRIe5EjVknng9
X-Authority-Analysis: v=2.4 cv=ZN9CCn7b c=1 sm=1 tr=0 ts=6ad5f3d7 cx=c_pps
 a=E1AkXC+xFF28g4y6WI75Xg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=voM4FWlXAAAA:8
 a=cm27Pg_UAAAA:8 a=7Uu7czuuXSSy5kTXNsoA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX7m/FIMgJ4JCy
 z6aRAVpyQpV1rypz6SeYr56pwtnPBscaBOYjClym8XGgCJNpFrXOw3ds6E88GsF/bQ994Uds8Fq
 7l2LiPfP57KkuSakatPtLXRMS52NsmdKAs3dvbPXfLHOnoaUkB6/pv2BxqyB9Md/SFEY0Anilx7
 rdlfHTwCwo4aybUaskFLD6NlFuPI5EHguss4a2hR0Q9VsSxSDiCN80qa4jDl51b9rP6mIlyRwKh
 GTE4tYmIjgUCP8MVi4leXiknkZxFeJNIMpo7exBtIdwH30BWbzaUVM8vx418941IxXtbIS2EOGf
 u8qTODZFZk5CLG1bfC1PCeuJ2ozygJgVJcTOPFs3ZaTaelC6F2ModmuhGgGfr6L8IfdRjoFgbdZ
 4MPxNk8D9+o/dgsF4gi9BeNcVN3LUrIPNBFR/YsKduAtv3tw4UbcXsARbJi+yxcw3+pjY7h6UNE
 bviPo2NFleEGdl8bhEA==
X-Proofpoint-GUID: Jfnt2dUvTs_HSrlxMXzMRIe5EjVknng9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX+eEn+wJ7cTC9
 WfN22+Rd7dAHWDCsYB5+OdjGZlPH4EI4dBaJLzctAxNO063QwNlIJATG8puZOZWhTNNmq8vLS6U
 L5nF+O3aYMGuJR3Ofct1arIht5+XAgA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190042
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

Some K3 SoCs like J721S2, J784S4, J722S, AM62X and AM62PX have a HSM
(High Security Module) M4F core in the Wakeup Voltage Domain which could
be used to run secure services like Authentication. Boot flow for HSM M4
core is different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. For HS devices, Request Secure Entity to Authenticate and Load HSM
   firmware into core's internal SRAM memory region. For GP devices,
   load the unsigned firmware manually.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

Add a new remoteproc driver to support this boot flow for HSM M4F core.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v8: Changelog:
1. None to this patch.

Link to v7:
https://lore.kernel.org/all/20260922084536.2477291-6-b-padhi@ti.com/

v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-6-b-padhi@ti.com/

v6: Changelog:
1. Add a call to ti_secure_image_check_binary() to strip off the
   certificate for GP firmware. (needed after rebasing to main)

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-7-b-padhi@ti.com/

v5: Changelog:
1. Use get_device_type() to detect device type (GP, HS-FS, HS-SE).
2. Avoid typecasting at certain places.
3. Check buffer size before doing memcpy() for overruns.
4. Add R/B tag.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-11-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-10-b-padhi@ti.com/

v3: Changelog:
1. New patch. Add a dedicated remoteproc driver to boot HSM core.

 MAINTAINERS                          |   1 +
 drivers/remoteproc/Kconfig           |  10 +
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c | 268 +++++++++++++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c36..9182389363c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -741,6 +741,7 @@ F:	drivers/phy/ti-pipe3-phy.c
 F:	drivers/ram/k3*
 F:	drivers/ram/k3*/
 F:	drivers/remoteproc/ipu_rproc.c
+F:	drivers/remoteproc/ti_k3_hsm_rproc.c
 F:	drivers/remoteproc/k3_system_controller.c
 F:	drivers/remoteproc/ti*
 F:	drivers/reset/reset-dra7.c
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 7f9e35283f9..f1e586584f3 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -108,6 +108,16 @@ config REMOTEPROC_TI_K3_M4F
 	  on various TI K3 family of SoCs through the remote processor
 	  framework.
 
+config REMOTEPROC_TI_K3_HSM_M4F
+	bool "TI K3 HSM M4F remoteproc support"
+	select REMOTEPROC
+	depends on ARCH_K3
+	depends on TI_SCI_PROTOCOL
+	help
+	  Say y here to support TI's HSM M4F remote processor subsystems
+	  on various TI K3 family of SoCs through the remote processor
+	  framework.
+
 config REMOTEPROC_TI_K3_R5F
 	bool "TI K3 R5F remoteproc support"
 	select REMOTEPROC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 250915d0de4..5f2127fcb05 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_REMOTEPROC_STM32_COPRO) += stm32_copro.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_ARM64) += ti_k3_arm64_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_DSP) += ti_k3_dsp_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_M4F) += ti_k3_m4_rproc.o
+obj-$(CONFIG_REMOTEPROC_TI_K3_HSM_M4F) += ti_k3_hsm_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_R5F) += ti_k3_r5f_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_POWER) += ti_power_proc.o
 obj-$(CONFIG_REMOTEPROC_TI_PRU) += pru_rproc.o
diff --git a/drivers/remoteproc/ti_k3_hsm_rproc.c b/drivers/remoteproc/ti_k3_hsm_rproc.c
new file mode 100644
index 00000000000..70240ab4aaf
--- /dev/null
+++ b/drivers/remoteproc/ti_k3_hsm_rproc.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments' K3 HSM M4 Remoteproc driver
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - http://www.ti.com/
+ *	Beleswar Padhi <b-padhi@ti.com>
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <remoteproc.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/err.h>
+#include <linux/sizes.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include "ti_sci_proc.h"
+#include <mach/security.h>
+#include "../../arch/arm/mach-k3/common.h"
+
+#define PROC_BOOT_CTRL_RESET_FLAG_HSM_M4 0x00000001
+
+/**
+ * struct k3_hsm_mem - internal memory structure
+ * @cpu_addr: MPU virtual address of the memory region
+ * @bus_addr: Bus address used to access the memory region
+ * @dev_addr: Device address from remoteproc view
+ * @size: Size of the memory region
+ */
+struct k3_hsm_mem {
+	void __iomem *cpu_addr;
+	phys_addr_t bus_addr;
+	phys_addr_t dev_addr;
+	size_t size;
+};
+
+/**
+ * struct k3_hsm_mem_data - memory definitions for hsm remote core
+ * @name: name for this memory entry
+ * @dev_addr: device address for the memory entry
+ */
+struct k3_hsm_mem_data {
+	const char *name;
+	const u32 dev_addr;
+};
+
+/**
+ * struct k3_hsm_privdata - Structure representing Remote processor data.
+ * @tsp:		Pointer to TISCI proc control handle
+ * @mem:		Array of available memories
+ * @num_mems:		Number of available memories
+ * @total_sram_size:	Total size of available memories
+ */
+struct k3_hsm_privdata {
+	struct ti_sci_proc tsp;
+	struct k3_hsm_mem *mem;
+	int num_mems;
+	size_t total_sram_size;
+};
+
+/**
+ * k3_hsm_load() - Load up the Remote processor image
+ * @dev:	rproc device pointer
+ * @addr:	Address at which image is available
+ * @size:	size of the image
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_hsm_load(struct udevice *dev, ulong addr, ulong size)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	void *image_addr = (void *)addr;
+	size_t image_size = size;
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
+	if (ret)
+		goto proc_release;
+
+	ti_secure_image_check_binary(&image_addr, &image_size);
+	ti_secure_image_post_process(&image_addr, &image_size);
+
+	if (get_device_type() == K3_DEVICE_TYPE_GP) {
+		/* Ensure firmware fits within total HSM SRAM bounds */
+		if (size > hsm->total_sram_size) {
+			dev_err(dev, "Firmware size (%lu) exceeds total SRAM size (%zu)\n",
+				size, hsm->total_sram_size);
+			ret = -EINVAL;
+			goto proc_release;
+		}
+
+		debug("Loading HSM GP binary into SRAM0_0\n");
+		memcpy((void *)hsm->mem[0].cpu_addr, image_addr, size);
+		flush_dcache_range((unsigned long)hsm->mem[0].cpu_addr,
+				   (unsigned long)(hsm->mem[0].cpu_addr + size));
+	}
+
+proc_release:
+	ti_sci_proc_release(&hsm->tsp);
+	return ret;
+}
+
+/**
+ * k3_hsm_start() - Start the remote processor
+ * @dev:	rproc device pointer
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+static int k3_hsm_start(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp, 0,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4);
+
+	ti_sci_proc_release(&hsm->tsp);
+
+	return ret;
+}
+
+static int k3_hsm_stop(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
+
+	ti_sci_proc_release(&hsm->tsp);
+
+	return ret;
+}
+
+static const struct dm_rproc_ops k3_hsm_ops = {
+	.load = k3_hsm_load,
+	.start = k3_hsm_start,
+	.stop = k3_hsm_stop,
+};
+
+static int ti_sci_proc_of_to_priv(struct udevice *dev, struct ti_sci_proc *tsp)
+{
+	u32 ids[2];
+	int ret;
+
+	tsp->sci = ti_sci_get_by_phandle(dev, "ti,sci");
+	if (IS_ERR(tsp->sci)) {
+		dev_err(dev, "ti_sci get failed: %ld\n", PTR_ERR(tsp->sci));
+		return PTR_ERR(tsp->sci);
+	}
+
+	ret = dev_read_u32_array(dev, "ti,sci-proc-ids", ids, 2);
+	if (ret) {
+		dev_err(dev, "Proc IDs not populated %d\n", ret);
+		return ret;
+	}
+
+	tsp->ops = &tsp->sci->ops.proc_ops;
+	tsp->proc_id = ids[0];
+	tsp->host_id = ids[1];
+	tsp->dev_id = dev_read_u32_default(dev, "ti,sci-dev-id",
+					   TI_SCI_RESOURCE_NULL);
+	if (tsp->dev_id == TI_SCI_RESOURCE_NULL) {
+		dev_err(dev, "Device ID not populated\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct k3_hsm_mem_data hsm_mems[] = {
+	{ .name = "sram0_0", .dev_addr = 0x0 },
+	{ .name = "sram0_1", .dev_addr = 0x20000 },
+	{ .name = "sram1",   .dev_addr = 0x30000 },
+};
+
+static int k3_hsm_of_get_memories(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int i;
+
+	hsm->num_mems = ARRAY_SIZE(hsm_mems);
+	hsm->mem = calloc(hsm->num_mems, sizeof(*hsm->mem));
+	if (!hsm->mem)
+		return -ENOMEM;
+
+	for (i = 0; i < hsm->num_mems; i++) {
+		hsm->mem[i].bus_addr = dev_read_addr_size_name(dev,
+							       hsm_mems[i].name,
+							       (fdt_addr_t *)&hsm->mem[i].size);
+		if (hsm->mem[i].bus_addr == FDT_ADDR_T_NONE) {
+			dev_err(dev, "%s bus address not found\n",
+				hsm_mems[i].name);
+			return -EINVAL;
+		}
+		hsm->mem[i].cpu_addr = map_physmem(hsm->mem[i].bus_addr,
+						   hsm->mem[i].size,
+						   MAP_NOCACHE);
+		hsm->mem[i].dev_addr = hsm_mems[i].dev_addr;
+		hsm->total_sram_size += hsm->mem[i].size;
+	}
+
+	return 0;
+}
+
+/**
+ * k3_hsm_probe() - Basic probe
+ * @dev:	corresponding k3 remote processor device
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_hsm_probe(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm;
+	int ret;
+
+	hsm = dev_get_priv(dev);
+
+	ret = ti_sci_proc_of_to_priv(dev, &hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = k3_hsm_of_get_memories(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int k3_hsm_remove(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+
+	free(hsm->mem);
+
+	return 0;
+}
+
+static const struct udevice_id k3_hsm_ids[] = {
+	{ .compatible = "ti,hsm-m4fss" },
+	{}
+};
+
+U_BOOT_DRIVER(k3_hsm) = {
+	.name = "k3_hsm",
+	.of_match = k3_hsm_ids,
+	.id = UCLASS_REMOTEPROC,
+	.ops = &k3_hsm_ops,
+	.probe = k3_hsm_probe,
+	.remove = k3_hsm_remove,
+	.priv_auto = sizeof(struct k3_hsm_privdata),
+};
-- 
2.34.1

