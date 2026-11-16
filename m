Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E2606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lIXgtxHA;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bxUp1PZa;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ikVBVFyz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8473660611;
	Mon, 16 Nov 2026 05:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qSrnwdmv5eOe; Mon, 16 Nov 2026 05:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C14A660672
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794808333;
	b=f+FHAh8OYAmW+23rfB97zJCM3FfCqRpXnRr3xju5/GoJuKw+woL3QEmw0N8xfX12cWS6
	 S8udrTJL2Zj7giwdBJrP5HYN5ItaifUZe6cbMA7L61Q5uBDjhbrFRPRy2F1Wf6oV4Qi1B
	 VpJqsZP7459ypbZeQn0HfAD1DSdHm8a3IJ9Ym1E3v6t1bcoXt+d2i+AiWi3eUl8yd5SJd
	 T8xdXWZudGYDkJHM583d5ETRmDfBpKExG5Z30NvXTj1FjeOsr035IYIu6b8TLUbQTCeNC
	 oDKb79217PGvE+sv1JhxHrijcLwNQYDOOEhIggkqXZRsXQPVbkcP8qf6NoFObFE+E2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808333;
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lr4H+WNbdkA37mwJbhjbFsQlBF/chHc3hsLaNUbI3Zk=;
	b=JLPsQJr5UgzhcvTJshgqhxGPrvEJkaCPTPvdLhiwQ8ox+mh6rIWnXNjthsVKNPNpWzKD
	 KXaZxbyimKk3M0OhnJj3muYlb5DWQUcrhtUkXxFa1fRrWr/eH+A5LKkq3vZvLrn9qpEUx
	 09vfBKOo4j0qi5Pqs2sjsLKRf6I8BAzKjwaN8i6kICBn6zr8Mab3MzQcrnv2e4jJddIiv
	 je5ZsijJUT5IXbwzko7OhNWu62yU3Bebc/GMuf44TjNAnVfn1kfLbEYYpMjqM0YIFf2Yv
	 teFcPT86/gOMf/vrTg6xF6/zjk5UPQmjuyt6Kl0PCUZe4uyo9mqAwjKxJy1bb+Ib/ng==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794808332;
	bh=lr4H+WNbdkA37mwJbhjbFsQlBF/chHc3hsLaNUbI3Zk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lIXgtxHAHlXMDTFE3ZF/dqtRjaJTur/Q1YYlK9dEd65R8rI8eSdPkRv9+lIUra/Ni
	 gNyzIFATGMjI7YvAGjrpp5LuS9M5BtPIlPVmcbuDoXDp/UfQRYEq2l7Q0VPBi4EWKJ
	 rfxuxXBdeEXDPR6kCODGpfqsKKJ+5vnYubPjuiZi5M5Pxl5qoyB7oY9Dxs0uPGidr7
	 nTty2G2QESWtEyKSpbTCGTDLrNlmtL9KSONphKGIeK+2glgK2sagoUM/J2RX/C5mpw
	 WhYwx2TKbbykI2yTcdmasYiKq6BXktu+6WXV+oxrXGEHoLR8AAa5fCBloaWskWznsf
	 czgOKSFhwKe5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C14A660672;
	Mon, 16 Nov 2026 05:52:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B2A9C28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98C1C80E04
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dvPgPiyINxSV for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F237580DF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=bxUp1PZa; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=ikVBVFyz
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F237580DF4
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:09 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AG4RNiw1154219;
 Sun, 15 Nov 2026 23:52:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=lr4H+WNbdkA37mwJbhjbFsQlBF/chHc3hsLaNUbI3
 Zk=; b=bxUp1PZa3Clmjafd8xLFgeQ9q+CRw59CqgrpmQ3uQNdn6ssfzppjI276h
 PotNEkRNj15jN3XTwGr184tmjEIIo3DTzm+MkOVBcuhbc6+i4I/pVqtDHYA/GdNp
 X1zS7Y9Lv5hdhUalRXwIvRR1cGaR/QALyWEtE8swErHup/1fFgj+KRGp0ur/TYXl
 v0lbFEXT2dXayWEFjUsZMdn2RoeVRmLXXJyiMoDSiDBj8ttj9iof4ULdWWtRK2ZA
 KaBSJsDG8F0P45zGyGrOs/y6E79Ud8Ebi3hVOXa3veOM5NE5hH1sn0s6P8BLnp1H
 0L4FqNmvvjSCKaVJLgkQkY52AaNEA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hyafsbmg1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 15 Nov 2026 23:52:07 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr4H+WNbdkA37mwJbhjbFsQlBF/chHc3hsLaNUbI3Zk=;
 b=ikVBVFyzmLKASe4AmNSgj4xZEtflOB2zvxbRq4/B0syTug26sDpQaCFCzxLNcCqcyXac829fmC9iKJNfsjblAHv9CpdhGUWAwYHtThiyJNLXWyUFnuKJoBAaDQF0TntxTr2a/mC/b1lGdF7CVhPelGLGFKfrkN59qwIFzXYZgqE=
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by BY5PR10MB4289.namprd10.prod.outlook.com (2603:10b6:a03:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 05:51:02 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::12) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 05:51:02 +0000
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
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 05:51:02 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:46 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 15 Nov 2026 23:50:46 -0600
Received: from toolbx.dhcp.ti.com (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG5oTbq091724;
 Sun, 15 Nov 2026 23:50:44 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 5/7] arm: dts: k3-am65x-binman: package overlay for
 PCI-USB2 daughtercard
Date: Mon, 16 Nov 2026 11:20:05 +0530
Message-ID: <20261116055029.3493551-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116055029.3493551-1-s-vadapalli@ti.com>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|BY5PR10MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fc9b43-59b8-475c-e558-08df43a598da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: sttC8je1x/81r30hXPO11b4Jc9ufxEDUQ5eRrfIqff+SxcXJDX6Hr/uL4VN20gNZEtFuprK3yUJurgBoJLYklDFGHPF1F/8FWGofeYEOkq8Wour6OEsGfD8CACOen9TigO0IyLKzNPpgckM1Z2qeKxrXiwZZB61yoCGyHpB5JwI/2nddnuqWCXySDuyoeoCb3/PUMC6d5vwzKFZkJv+ZEif7Ey8HpMql0uEPPHoOtgYpvysgyGGWfG9ip4JvxiuvSGSEsDRFhvTVZs7bLg+GY9srB1p4P34z2FiHuWDRd8/VF7IWWqNmS85517G/Mm/h9XBhD7TDaHNtywgLB1WYOHCGdwXwXzTMyKGd/XLfnGgUXrpBlD0jZvGQX1BcbBTCoIfzvx3X0pcbLCIZsZXXp+7LG9rwHb5FYBeobDpaQazRm1GvD7aF/S9O5SA1NGEyRQpz9gTsMCLXtfHv01A/w8Zk6ZxuDqmgk+VTUOxyuBo1L64XUzbKHbUGMbdF4mumGcGPeVkcT/yBDPDDXg17YRx6UXscFgcagjbkL1kH/ZEX1geT8iQDtevdD1nF1kNQ93o4z69gqwkXMWmTI/Jc6hPeHxDoAp6I576HyuBk48ZuxXqUZyo9vHX8LstrwQdIcgH3lEb4csehOGdSVJZkkF0C62sWx8kYQWG6jPacXZgZ9mhv4DxyU/p3GSuKDxGcqr/cPWhCOpFW+M7oZ0rQAA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j+HPy8ogjZMRAfnWCJlzUhaQTe9gLRfSYEqE9jYYfL64mtg2S9NYHs216S5ZNVZVjYWZlDfwvsvAsSzH+s1glRE8IacmU/7OnLHHdLdqjU/14u+SoO4FHsgA71y8nwdCsBnPFQbryTkj5LJiWFKez86Ha8spuwsXCYvQX+wDNXwoouveyrsSdpxiI0oEfpSoC24O7irnMKq1/IIdFvbPwBZVyjQWcdZ4SEOcNYeT9t1FFBiZtDSBDdhKUzvDzAId7pDLbFqsbIUgzongYEnKlUe0r475bvGKmE6CDyn5gwtZWutoO4eNw9CCVVtn6tOVos6lvlZji//+XcBC4B/TQWrG0cbti/tNJCEOBv7NTm/ouUiEMSHwUH8kbPrPEyVErlxW2KKmL3xNg+J6Bt2jL9qJ4bGX6q/3Q9aJPBX2n2K8dvD+CmX4Bj78QCok4gmq
X-Exchange-RoutingPolicyChecked: RDNMixWZpfENsZ9M0LxwCCPrzZwlE3se+vs+oMVM9eGDPvymQ1D6iQJYuRN8aM+iw2lm9G+ORgwHgWRTMEF99LBKcLU8hZBMWi/F4No9JKTjQDjtcP55lE97sh6utW2HxAPvoa3RrkB4am7Ef7MD7owEWeXB8DI7m70cPKXOpckgM/ahbho6dG19iRwhr2sCTHMOqU37OPXInTJFE3VrIDP42eI1xnK9m9PP4kbWdRrUZC33P8zcSFpscYLDD7SsNZK1kwESh7oueIt8cPiOEkUTS9vUUbVFbmWECe5GJzCbMwVcAyxcoMvYfGE43gg6grwoJnjp/GPdDXeEMmhroA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:51:02.1810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fc9b43-59b8-475c-e558-08df43a598da
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4289
X-Proofpoint-ORIG-GUID: xsxvXrJ2I3ObOkCghC6-YOMYAfdyH0h8
X-Authority-Analysis: v=2.4 cv=UanE26SN c=1 sm=1 tr=0 ts=6afa9a07 cx=c_pps
 a=wCygq6uL5kGpubmeL3zaNA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=3aB4mLzFzoJxBdMkICkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX72nL7u57ZK6o
 vn8TCjkhca3XpAi8seARxvR4zNj170G4pMny02K6Vx/cujmICWfdCbhPnuz61NuEpaOL34UF897
 3ExMzWiXpb/Jh6f9A470hu2p1fdnvwE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX9E+p1KNO1LVk
 EEkeXfJDQGnU3nPoVeipmlk0qRGoPUHR+sw+bNHIwUeW8ffREJ9tUYuCN2HCNRFGElumtM7ueNe
 K7UkxcjBmwJuiGjStKGcySJHjWum5quQGl5RXR0KXMxMJ7aI/3yw8D6klQhqSveuvaL79KxKTXw
 1M5x6lPWtzFx7q1/e6QUTI9FXPb+dqiRFiB2JeXyuBs2h7cwMZvZPZAmufJUtIbtMO0574IhxCt
 EELVN3KEFhdMe3Q7m5LHQMPGV1WACrm4MZN3QHIPEkRuHKEsZy/TrBFyZY+6LMC4AOnAbA2EKsh
 LKQ9ask+KCWBpRxpf82NeD40h1aaYSm0Dha/pJ5fPdcAe8dnJDHeu65kwUKcbwrXSzZPtNDorrb
 f3oGXkU7UsWpSgrT9vDRIJ1dHQhyY2Cjy2+qOVSA79pdNP40dYtPgkX0BJS+R+RWVtUO4mUiHhZ
 vo1g7AtwgeF/3ujjyxA==
X-Proofpoint-GUID: xsxvXrJ2I3ObOkCghC6-YOMYAfdyH0h8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PCI-USB2 daughtercard can be mounted on the AM654-Base-Board to
enable PCI in x2 Lane configuration along with USB2.0. Hence, package
the corresponding device-tree overlay.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm/dts/k3-am65x-binman.dtsi | 35 +++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index cc82c8b5768..47b0986e65c 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -96,6 +96,7 @@
 #define AM654_EVM_DTB "u-boot.dtb"
 
 #define AM654_EVM_ICSSG2_DTBO "ti/k3-am654-icssg2.dtbo"
+#define AM654_EVM_PCIE_USB2_DTBO "ti/k3-am654-pcie-usb2.dtbo"
 
 &binman {
 	ti-spl {
@@ -199,6 +200,23 @@
 					};
 				};
 
+				fdt-am654-pcie-usb2 {
+					description = "k3-am654-pcie-usb2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&am65x_evm_pcie_usb2_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					am65x_evm_pcie_usb2_dtb: blob-ext {
+						filename = AM654_EVM_PCIE_USB2_DTBO;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
 			};
 
 			configurations {
@@ -208,7 +226,7 @@
 					description = "k3-am654-base-board";
 					firmware = "uboot";
 					loadables = "uboot";
-					fdt = "fdt-0", "fdt-1";
+					fdt = "fdt-0", "fdt-1", "fdt-am654-pcie-usb2";
 				};
 			};
 		};
@@ -297,6 +315,19 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-am654-pcie-usb2 {
+					description = "k3-am654-pcie-usb2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = AM654_EVM_PCIE_USB2_DTBO;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
 			};
 
 			configurations {
@@ -306,7 +337,7 @@
 					description = "k3-am654-base-board";
 					firmware = "uboot";
 					loadables = "uboot";
-					fdt = "fdt-0", "fdt-1";
+					fdt = "fdt-0", "fdt-1", "fdt-am654-pcie-usb2";
 				};
 			};
 		};
-- 
2.56.0

