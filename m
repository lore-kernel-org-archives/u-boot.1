Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B57C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 05:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A844D606B9;
	Tue,  8 Sep 2026 05:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tm4DIosULbrl; Tue,  8 Sep 2026 05:14:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EAC14606B1
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788844489;
	b=QvJ4GjCdwr8XKX1hi24O2uVZPh+I035lae4ios6X2WXrL2itMCKcR3LW+zWE9nVo10La
	 dm9H3OKhRomnsh3IVffkbAr1wMVYvR64xp7eZfPUyaT0bd1dbrH8xI51G39JHIyfbNERH
	 SlUPnxFw7B5wvVItK0/m5ukg4005cSAhtzmysv8f7J6tzwOTH1Wq4JSoSb4b9Bw78iWDA
	 Pj0KerqotSoS68/TREZ2sq9UBp0pCmqmEfUOdDp+Nx8+J8EbXuIyWdO1gtvGzcf157kN4
	 Gk+OPhrlwW3L5iR4lyfitPT94wDhIDZBxysynFS61FkCtJZNXOAHn21hiHbtGKumdow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788844489;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4JuYvVEHpRIQpv8iE/y8QNP+0gy3vtPjQrDT25GiiAU=;
	b=GjmkpyGNtzplOxTcAAes1iFRrs73LpXohKDkQ08EXfMsa/AwAmCUq62T5wXHC1pcaYxe
	 A7ES7wEsMMC/KcuAnL82SgM578W4/rqLm/SlzGxPC6OIZDzIk1iFDK7SljfZY8bVWRVeH
	 P2LwyWV5BMuG1OFnT7vub52daokmJ43pH7QIDeGBvHD+6M3Mb5WBupw0JZXbQload4R7m
	 qAH/toHsMBuDMWsw8TZP3sdJsd1ucs87oH0MMl3SnNAkwaL9ljCitT9tMIi/fPXdA5DZD
	 Smx3te2gkN6w5kv73WtBc62Jt7kZHITitY8PWpZCM49fYCpmOBPq+N8g2K692+CyNFA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b="DM/WkM4R";
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=VKEb5IFc;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788844489;
	bh=4JuYvVEHpRIQpv8iE/y8QNP+0gy3vtPjQrDT25GiiAU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VstCmh+tw5LN/PMljQgRoaUmV3I1kyklKYZQAPKJXR4nSZhDY5TaOhsTV0CwphtYS
	 g3Ypc0gY5yEeHe62JSjaym71jxdth7xVfZoELP/mUL9lVm5U9vU0KMSTHfI9q0pRE3
	 8D5ad84eP2UbOs4Kq16Efm0DkLLDEp+D3LRszlwLZKx5El04Vcs3MsegZ/VF5VhawV
	 Wh36c98GMWKs24mdBK45ElcJO39Gh99EeShYwSphVtWpAHEhWnzL5z1Q+OTPdFqMu5
	 VY/jttny4otmRMNAVVvpcv6nz4nb/SKfqVw5e03VFachOJk398FRlb7ZvFEHri28O1
	 jxyiuf6WRnvMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAC14606B1;
	Tue,  8 Sep 2026 05:14:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 763D549D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B631606B3
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TdoP1qD05RZM for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 05:14:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5A86A606B1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788844486;
 b=HLZZOU9+YOya0AjYxOUheHu7E2+TkNI2WezuXMojtK4QVlV89wrkx3u3HtWhayOCxuwA
 XA7jsYrw49zHVsNNfRz3cO0Zkc+GvKZmKeFYMcNU2hY/fWCu+22safF6E0lPResJcdEh9
 tSKymHK5EO5dwzonIiY6+ZrRzepm9mcWWQ66T5/7tD5fH9hC9naRWnHaOTgXjk5HVsmqZ
 FdO/c3oJA4M7pksYNE6FBnntcrN/gKoAE1wi0ix7whngDpBWAqbyEyaVY0mIysU1da1b5
 uUsXfMLnNYhO7ZcreQCQmukIG3Tdb4dBLbS0ySbCEYkU65N8O8O6uoop6+zvJlhvV4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788844486;
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=4JuYvVEHpRIQpv8iE/y8QNP+0gy3vtPjQrDT25GiiAU=;
 b=XpozXee6zhs4wn1Jw0tMsbXN/+QU4z1l2Ffcod2hPDSjLpkt4jVE/OzTR7visnkcaxLs
 9vmVUV00ooWGe0o1ox63Yv26JdLMa54z+FtAZxT5Gt5auY0mm2eHkMtV0WqAFf+sqFqwR
 njV2IcubSMYssOM1tZ9TTzPbHhee7zi/907M3ULOSkwWvWmExSzldad4S8aHe56eklL8b
 TuEUn/O+d4xqz8YTXUbnXg8pUKchIRnZIWDXpvOycK8lh8TVnF9H02rihpMxbshzTp7hr
 zYSU8/cVgryuqw3Xvrp1El9Yji6QODMt1jJ9Ew7vKJl4pXmrSwJ7/A0W2AqzgOoTJhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="DM/WkM4R"; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VKEb5IFc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=DM/WkM4R; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VKEb5IFc
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A86A606B1
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:46 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 687NnaVa299199;
 Tue, 8 Sep 2026 00:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4JuYvVEHpRIQpv8iE/y8QNP+0gy3vtPjQrDT25Gii
 AU=; b=DM/WkM4R7Nzx74CBRJVuA0WfJRIt3g2F9UIgJVOVDsdFGMzngS+GoWf9n
 F1H51YWhkGJdYPsVdqyw5o419XP19HysBd6aT0fncADTeeTfVdexblSFY+PNHs6d
 QhcSPq8SVL2hDB0ZB3oJp5BH/K2Y3pm7JyG2BYHT90YbqrcnrRJPFrzeW0ITWOni
 Sl7bNVWWYp9Rw6ScuMf+1RwK2g9F3Gyc1sAYalc2fA1QxBf/WHXW91OqtBiEW82O
 GCSE+e2oZBMnODJmV07OjlHcygGQf0nJGogiDdwTDILAauz+gvE4fvpeLbcpmKbg
 SWHfU1L739LEfJkEuJe61TcO7NxCg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ghth3d9te-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 00:14:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhXZ4x+zuKs86K0YEacS/ciEg3/k7/N77b5Ka8bOvjv8SuwtPcr829itowxC9MDv+ZLypRgsjtv2D1sCGioP1/AhcZWp+VdOJl1pEqs42+XBZP+Na+pum+EA5iTDwOw84DrJ+7Esrw4AoRlXk2yhspCewYNPqrZqNjqBgr5IGFE1uGYuXt+NRpE2bHXUgOaJW3mRkCVIWNmInOALeq86hMY9pYG+yvHAujkAJ7gOBcGd+3Zl1bccLSkXGr+C1oS8l/pC2oym4K+FA2jVQ35F3ArsUnO0XoaMLk1YGSuGJx7WGUqqnCpKTDYXjDFFB/uay/qBi7fakpVYIuUwxUhLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JuYvVEHpRIQpv8iE/y8QNP+0gy3vtPjQrDT25GiiAU=;
 b=vex39QnvS7tiN0jx8w6BimY15fjVVhOK5ymxO+OnWxd3gkvTS0QjALhSVc/tZsoVTlTwrt+TzizKY17Ji7rGgFwYSh2mlKlZ45K82d0MvOvdMZDaFnspVW8v1qHtD7x3IHrym77eaWmHAZW81WuaL43SGQ4zCXLvhDU7dy12qO32Mpf8mcJ4rUUMpo+su4HqQrSVWEI007vVLRXj5OraG0MHr2exXaTedtIy5ry4mUbGSd+cvLoY7S6EcHMZUDY54uVCyPCQJhqu+RxPvcCARmR6y14Eco+KuEuTlvM0XE0/mBSpidSUi3cNqkXON+WQx1X0Z/OdZQqKHiEeHHCj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JuYvVEHpRIQpv8iE/y8QNP+0gy3vtPjQrDT25GiiAU=;
 b=VKEb5IFcySLMKOpz/DXASgeTOTkWEnEipvUsMtcrSowSywRDJ6H0W2qnG3tE7Cz0bAwLl23ZP2Tx8Q+BelQ5LVStc5R7K+RaFzXAjmDd6yjDHqcllfAle0xFTT28+kkGptQByz+VP7iu770iAGYWIff0SI1N1iXaTw/O18ygx2k=
Received: from CYXPR03CA0079.namprd03.prod.outlook.com (2603:10b6:930:d3::22)
 by DS0PR10MB7150.namprd10.prod.outlook.com (2603:10b6:8:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 05:14:40 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::2d) by CYXPR03CA0079.outlook.office365.com
 (2603:10b6:930:d3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 05:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 05:14:39 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:13 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 00:14:12 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6885Dwd92811953;
 Tue, 8 Sep 2026 00:14:10 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 5/7] arm: dts: k3-am65x-binman: package overlay for
 PCI-USB2 daughtercard
Date: Tue, 8 Sep 2026 10:47:30 +0530
Message-ID: <20260908051741.868824-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260908051741.868824-1-s-vadapalli@ti.com>
References: <20260908051741.868824-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS0PR10MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b6e271-13fd-4ff3-1138-08df0d681579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bQocE3SjkQWzK5s2wiRxWygcEe9273pqiqEpOoOdyKORJ8+H9Piz03rPXZmbNCyKyFQP03suOkdD7EiqpuUF2CLVhpCOQB6MMsEhFALsVHCZfQZ/0OZCNmxCM96OtM+oOpBtlEjglnkEVYNazVS7yl0JAk+w8qQ4FR1/izfxbBtPQrDb8OOZyna8BgleWCuQ01Oj/pf4ANoj6wwRsCdhTJ+OxHP4LFOADufgk6FOivtuf5dd44WQGjtUfdrqk4hMME9/2KoFIVSjS3PfsUt3x9OXU6HA+v90hn1kxXtx4m5iCCGAaIcVBG/c1W2dFAz0gomXhzMQpvug6iJOp8JsmZ2yzyEfCYvxRwU1ZWfiS/NQLYAc6Ffvn5Lw728pmG80D4QlDsHg13WqIRNoqK34JxGKAVSm0Z5tIyAVBHqhpYXyGM9oAsNZXIZnDe+ChyUVtw204CkbfL+CkcBzTLEfa4Kc6wfwZLiPBXISJVllvYbk4TQvoD7BDI1QEhJ+2UgtcwXUMA27eGVdQu760kywaWF+GC+JsHhXJauCpiT7CGuhVPBTW9i0QzHPI5Bm5Fsv6IjNqOg831WDBvS6wKjr9nDHwGb73Zuk2tUDjXSaMjfYq3f9rMnaXc3a1fC5DjF0VWlnlXQOaQEpPtSVLXhsrCIowzh9UkPSndDcvQ5FFlsbcoRHZFhJUZClvdLbLQuBjLozzbkWu4d7f5DlpVW4mw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7nrAkBcxhOdq8o50G5biNbMS2Dxn21Od3S4hok0rlF4wkqB4hQIQcRepj+GuIBpnMp6yHobIthAbqnakBcNvGBbMeSk93X3nkC4ZW0aeGIlpVhHeDPfE2Ewd8QZGzf7r9YvPAwvNIkE0SB/ReDvtfj/rYdr4vPzjkuyfMnulta+Uykm/a5RVYlW0Bb4ALQXeUrkNwKz1FPxZYncl3GUiMRQ2jjQsuvEncWEKe1Prl0K7Pnej2jMrr3vKa3OUXR+2T409KN5BEbnGqQ6Y/yJ7Wnhmx7FFHOkQlAzSvVldjUgTiDKZ7xP6HjSd3d8quGFymNPuAxBng0jSJN78tJpMp3DfLzsHz8ysXlQpbQpwZuYxvvCF9hclm6pR85J+Bflk2kL8xzxMUyebnfr03bruezi8PmXrX+RTra8GvHbSyfRPW02g3e9YqQsn954flFPP
X-Exchange-RoutingPolicyChecked: l8F6K4ADS4UqJN/cN9Mq9mDAA1JIiept9FfsNCy0+y0djZm3GONRsdL4x8n0/WP64+KB53MIQlADT2Qw+P58hSKV2uup93D383QJbvIAUh6/7Gzrpo8SRJvjdIjpN0rfxPWrkmgBuxMeRYPKWntsShQFXUzSxH6hID2TVFAsXUgJopLTSCxTBygvRA9fKo86rPLkemeql90kgkpLwIUy/Qm1f564P9nw0YUx1lE6qvrkwxBdkXvu5E5sb/Wq8nUWQLzSOXOREng6WsSFMZhZJPEokvfwJVtTjy5wLn5hduatz2rvimoJMbgsmjg9Yd9vLvN3MrsNiCn6/zsxbZrN4A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:14:39.7013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b6e271-13fd-4ff3-1138-08df0d681579
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7150
X-Proofpoint-ORIG-GUID: q8KyGi_3_2Z6e1toUhCBROk1NElp7Ssy
X-Proofpoint-GUID: q8KyGi_3_2Z6e1toUhCBROk1NElp7Ssy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX7bVwoMhSlh/F
 yEsBkfCT6SAHyDi1Q+iQjNcTLDz+xyVnizNnW98csbmIwKPgizmhY3DFkLSitpquTiHrb8lUtKw
 KAo+W6t9/Tq1ghtUH5JPaBO3Lo1ce1tN0mgYfukNByR7XSTQ4T+yqEOkJC89RRt3nSTlc+KjjNq
 nhR9k3UTgUQaSd652arWJL6G6tV69N3CfPDV+DMPrRAPd3UvIjuYFEYYew+w7LMv3H0150cWPgI
 zQgvIfhUVWGyozW4PiyVmhdpgb+Z12pFwhAyEDKvEVvLKA/l0GuXcIH9tjSJwEmO/K2DVEVo+Kq
 uvPT67ZJgES0kWuCqsPylB9gTka674LCArF0sae/S6tX0B1LWABO/V6f2EaQWOX8Xn48My2xIpR
 Gc1NPtZ9qjoTGTAZJWISfCOdNrA/QrKaPhVw7nLpL8fTeNy/twa8KcKubHWe041p3COelArwwHL
 vf3/mt3ER3d/KcGVFcA==
X-Authority-Analysis: v=2.4 cv=Jd+Ma0KV c=1 sm=1 tr=0 ts=6a9f99c3 cx=c_pps
 a=8DpcgsHgAViCMqsLoRaOsQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=3aB4mLzFzoJxBdMkICkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX8BV6fp/2WDwi
 ou1+qnso5pc2lvsEEXiAIsBH5BZqbYT9cKojyfs/gEbucCakqvsD8xZKY2dToAtU482XYAh5NOu
 +cGe5UiTV9OSAbQRi0u1aSPjvz0GoVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080055
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

The PCI-USB2 daughtercard can be mounted on the AM654-Base-Board to
enable PCI in x2 Lane configuration along with USB2.0. Hence, package
the corresponding device-tree overlay.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

No changes since v1.

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
2.51.1

