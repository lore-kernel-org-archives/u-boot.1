Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2A606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G84W9xQO;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fo0hPSAp;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NGJGrubB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D128405E2;
	Mon, 16 Nov 2026 05:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CH_ikgvhTl_b; Mon, 16 Nov 2026 05:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A230840600
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794808262;
	b=WQdjaq78FdBPOXaNz7LEtScVioCoFTi+FApPefdfTwi2qO9x9dZgXpWfvts1pKdqppXY
	 l2pYELTFC4+fiRJzaAuecz+fHhzZ3Sqo68P4L5bL9n38GGYHgJspQCygvP1mdm+5dvmAQ
	 kl4wUAKnbce+5yursgWYc6zWxXbZM7ehzERfZfzjmJLCNgTgO2lekv1dVhu4jGMecyy6v
	 Gb2Xx1wb/SoIX+kquKfNxXxlL6X03u/lRKKPDndXMqv5IeOwraH/+sdClPkbNdtVJ2ar4
	 ZhSmC4fY/37aCzifqgNKtbXCnEC5l47cqsQ9ANr36SjXzhsJICa4J8W5doS9S+4Ujrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808262;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VR5lCBhEJFMuDAWbrCiBj25MewDfgGvZK4mNJsI5fzM=;
	b=Shuqx+jErfpLtJ/prPpIbNLUcBpe9iR5+D9XDL2DMiKZXyVb3D7tfbh/dHzojqg1gUCY
	 Gnf9RGo2GtzeBs4JM7llBKPe96VsBrNwugGvC7533xbdKxnHuVWRNhckDiKDgxrQ/6WOq
	 LsAUHY73C6kUwhDWtS80PMPzIBF5nalMqIlOMhTwxdo6jy/Q1bhODNzim4y8B8pOWw5fI
	 XwjPjmaN5MV/hCTJLO3eUzn86M85DWwSD7jtCX8zJDK6gttnAjdhTBqb5YtC8s7zXSJTQ
	 qCx5Ucy8ST4jJNU9jsgPdsZ5cwCD7GFhJWnOICzIVpbfh4o5K8HoKgXoufBcQTWfHhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794808262;
	bh=VR5lCBhEJFMuDAWbrCiBj25MewDfgGvZK4mNJsI5fzM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G84W9xQO6dueyjwNvPxRvh5w7EtWy1B6xyLWC+eLNpkxt/MfTO71IROb2+kvIUa0o
	 p31Qs2rYbTIJric9ZRV7BOkgWnSZ2prkKXhQcymrQepFOd4B4R+KoposEuGG2tIHzD
	 QjXsr7RItamPOnHBjU4cn9wSulHKXNC26EBekVAWF1ol6sRP8RYywLsEgp9eg+gYeU
	 uRfCCelyy91P6owO04cS2zYdSs0HZ5BKswwlNOpp6ySIFwqXmqud/5twsrDMUoTT2/
	 Dks/9pnS8cDEE4k5wNRM38ScdL+uSccFq1XDlJ2IpPzCd6DOp4/SK0qgOV+aJCzMU6
	 WBseKGVDZs7dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A230840600;
	Mon, 16 Nov 2026 05:51:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A7D32FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC73E60603
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2e93d4aHl4W for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EEE1F6065A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fo0hPSAp; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=NGJGrubB
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEE1F6065A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:50:59 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AG4QrBg318942;
 Sun, 15 Nov 2026 23:50:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=VR5lCBhEJFMuDAWbrCiBj25MewDfgGvZK4mNJsI5f
 zM=; b=fo0hPSAp9mtphJ9mNuuI38kybBu4V/qND+2JqNkz3eDmrzra8m9bypxVI
 PNEFUptW+lHKmKlotFnJ3L7u0+HCBesjkgGrRFPpNeiWXNmMUDfRm9SfzPf9CcB1
 WScjsmXkdEonIiriwaN/9MK1RRGfQmIbQ8sNp8alcB4kzj+rHNBAe7NZ/bLYvjyR
 yUZQ2hA7fgDWEKDE7kchnYbfIgpVkVrQIIOaaRFSozDi8ATpYXeXemzml2iw+0h/
 XXucKXSbABSkvu7Vdb5lX0esrJTe3p8/dnqOHpbxQ2hQT9TgOyPTtISNB6ocApbb
 wOLTchNT406p8sjVjikj3K4ENvBVg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hy9j5kp9e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 15 Nov 2026 23:50:56 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR5lCBhEJFMuDAWbrCiBj25MewDfgGvZK4mNJsI5fzM=;
 b=NGJGrubBm1owF8V3KNV239fbQ/MFw1JAqnLUrM4HL4elCDJ9r3ND5L5wcz5LEc0b5RRNLO6UU0hJhrIEUOZIb/t0zg3OhrBDoF8NQUGX14J7m7pviQ25/Vc2K1D1+7SHadwCGoloWufeDewKfS2Njcykeb4nu+qgpMLh3659ySc=
Received: from BN9PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:fb::14)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 05:50:55 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::76) by BN9PR03CA0039.outlook.office365.com
 (2603:10b6:408:fb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Mon, 16
 Nov 2026 05:50:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 05:50:54 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:38 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:37 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 15 Nov 2026 23:50:37 -0600
Received: from toolbx.dhcp.ti.com (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG5oTbn091724;
 Sun, 15 Nov 2026 23:50:35 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 2/7] pci: pcie_dw_ti: fetch num-lanes from the device-tree
 and use it
Date: Mon, 16 Nov 2026 11:20:02 +0530
Message-ID: <20261116055029.3493551-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116055029.3493551-1-s-vadapalli@ti.com>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|LV8PR10MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: b17d6340-af73-4e1e-21b8-08df43a59403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: iWQbPBH5R2tmKP6wjvGUHt8ggtKdL+LYreAGE754WLGnVrhRaM789hNEvNfApjAHb3JbYUsjDE50bsc/zXSMOzV5FUOVwO3GCk/qClklMxRelRPi+6YovdSd/Bl3ogLT4QbSiIgfG1KcCPsP8z87DyqngE4s40Wzw0JKqvjdaUPLj88wvCgx5Mm1SwRQ2ybOoGPtDsatsQTb9NC5wEo6+80+Ig+3qowhBwGPr3jEmKicBOK2IP+wG83zPFhnAUIy9SJu9TsBbXhKVxtF3SjeXx0Xha9B8XUEIOIkx4iV16DHuCo+ExB05jiVNSNdgfHRHN0ZrgvVJlHYS2jf+ciqzDRjmCknEIo8CuztQneQpcwYj9zkZS7MAILUyPg1KoO09bpr1Fxt4BcwVw9NLEuKHg/fN6ZRVxzN/s9iIvheOPWZJr6o/Uox+h5nVelMVi+MMz+ktJmbd9GeQO68WUG7/k2fKOt1qFimBw3gorOKLEz6qjnLWaYWpoyJCUHWWBDbNAj9MFT4tRKFj9pH+8Te+k7sVNwn8K6JoxdDYMkMBX/p4RuC5ObbX20TjG8CmKut85URAD15O/7h75P/6EE7aauTUwx7HHakPyEqZSMakt8g4NOItetYsUSu5YXenGMfEaE3G3wKWI9iCjL3JoE7PMg9aGBE1fex3DXvLbhTS6kxdfLg7i2AEMhtuXGJKNuBhHw08K5O8OrL0Ecf77YQYw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M3tK9vNLLUi7W3bZmTYXVtq62xf4M0UdPB/dBx6Cw1WxpWfiCpZU1G+FUDaDGQptOKapd0oAFf4yNCDXxnOXxkbfyFDxzLRBgB/TEh/2zWv6kcurG91ccyn+IWZzl4/PnBuPmA+Pl9GWLUmCJ9HqtPTh3xrBBwIlMZbuF75A3zxVYqKk3S+IwS7621pwSVgw8pzQP0aWJNaR7ATpc/sirUZ4qOy+BbWIzYLJXiHwWrO6d9bGgeQ3Y/u5Y0RTny4/lBu/hKS048NtxUz0xRobhUv57VtVec7dmQrBB5lb52y3pxvackNCfI7uDh9s0Ipw3SXvndbdLhSPdspRxbR8CNT0fa2Ai6Ukhy+1dex1cdLD7zQ7IQsTvYrV0i8LWByhnxa6DNE4texiM6LvPhwH+PXKyMkDxwY/Ue7nmSGAaNxB3lGJYcdmAnLdtDfq5IbR
X-Exchange-RoutingPolicyChecked: W+mJZeol2HoPiKMW+rw6w7dWZfR52bMopnKVZQE+Kh4ayYG7l6if33T/nuRiI4flOAVuCdyV8Yv8D1mgdHuQCISsCnqhvbWLq5TRZWXy3bsKpCozIBKyZmTKaDCPEN5r73e7ydWU9cNMrofXXEIa+gxHyvklqzjhAdc1GtUpVbf53zOtue2VLsgS9wntPLJ8CIIT3+uz76VyLtBXnEfZJ7pYn2mJmMHG61yNvXrg+BFiA33P0jPio6dsOeF91bs3ZyHC/9bzBi/W4toBc1L995KWEHM4ypv/TMWpgp7FWCWtRusq1JXhxfhjZ/fr4CFnurCi11d4KlJ2/+P19Er7Rw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:50:54.0612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17d6340-af73-4e1e-21b8-08df43a59403
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX0R6LKJwprVq5
 ay36kwRQR9novAj/7zVcX0LQBJV6FSTh5HTcTl3qkYf6FhYZbtiiKouMnPBgwFuC31lffKJ04hf
 nUv7X6GRB42yOP8khpYPvgRFc7NKuKM=
X-Proofpoint-ORIG-GUID: XDm_fYWpVj8w28BOj2j4pxJ3XqQMoBjS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX3SdikfS41vQp
 2JOYQvuI8SGO+6cmiFGI0/6+dlyZXuS/c0caqgtyQI0Ada6ol2cxvMO/CR8p5r1H1LTFN2OlYuH
 1OXHgg6aXGHoHpnT/bYMDxohrSKNR6nxEeSPZy8c4sQ3OTaBpLS0A4vbw92p5Z5pmmG9NZBfNxi
 vue6KorJBz1XWOd1T1gOcbvVX0w0UNJTxDx7YMlzFLtst+W1RHvjTIRCoQfBtRIci+C0khIUJn9
 +N5TZiurFRKBwn0RTmx79B3AkY6ZtTkgK4TRn+bzFEq9kzJrk3VUyJ6BucTNHpGMG1Zj5KsBqP3
 YrJF+HX31p0OPnLw9Yucf2uqlfx5sYr02R7gC1BJUhhtNoxjwu12NgGY9RV4HR+KFBnOGbf+WZC
 4tWhYjH/5M4qMe8+zMq4KDptxOxv5gXKBjRj5yEJG1Tm6hxpvvXbzh8hspyl+8eJdouh2STsS3+
 g5mPiDnNy1s/efs1gTw==
X-Authority-Analysis: v=2.4 cv=TplzFzXh c=1 sm=1 tr=0 ts=6afa99c0 cx=c_pps
 a=ffjDj9JMBHEDizK9ymob3w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=KKAkSRfTAAAA:8 a=sozttTNsAAAA:8
 a=gzyk6xmW-C9wgJ78c1wA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: XDm_fYWpVj8w28BOj2j4pxJ3XqQMoBjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160023
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, the PCI Controller is programmed in a '1 lane' configuration
unconditionally. As an improvement, fetch the 'num-lanes' property from the
device-tree and use the specified value. Fallback to the existing  '1 lane'
configuration in the absence of the 'num-lanes' device-tree property.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/pcie_dw_ti.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index 37c295fdd38..fb39132f7c1 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -58,6 +58,7 @@ struct pcie_dw_ti {
 	/* Must be first member of the struct */
 	struct pcie_dw dw;
 	void *app_base;
+	u32 num_lanes;
 };
 
 enum dw_pcie_device_mode {
@@ -278,6 +279,8 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 	if (device_is_compatible(dev, "ti,am654-pcie-rc"))
 		pcie_am654_set_mode(pci, DW_PCIE_RC_TYPE);
 
+	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
+
 	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		return -ENODEV;
@@ -332,6 +335,9 @@ static int pcie_dw_ti_of_to_plat(struct udevice *dev)
 	if ((fdt_addr_t)pcie->app_base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
+	/* Get the link-width (number of lanes) */
+	pcie->num_lanes = dev_read_u32_default(dev, "num-lanes", 1);
+
 	return 0;
 }
 
-- 
2.56.0

