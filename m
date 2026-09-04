Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A99C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6315D607FF;
	Fri,  4 Sep 2026 12:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pVtojbFAXEo; Fri,  4 Sep 2026 12:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8FBEE60BB4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788523385;
	b=ZEeG0Lds9/BIWU3MH6OVyC0idgJ9Gz6aUcCxH9guDIb2crXvF+k5rP+D9PME4SY7XOV+
	 mSMaVvCHgail3UeQyNr3Mgs26BcDC5VfGmVfHn0UEJzqO1oqoIuaYjDR6BmTd8QM0jXf9
	 6HZ0xVE7WgpOwPUNDbO4ypdeI+Chn4UX5mcsmpcC1Avna/Mfq7qzDheHMcd4f2KRVqPSb
	 pR3dNEoBZr8siMiplwesS+6xk1Apkp9YTN8+uSfbAYbhj14X1inufp5fFaXR6h1qxxH2s
	 3n2sl8gnQpse07CwZRhtcV90xV1STJBPcnTZJV129UDM6Jh1KsiA6OC7dfCaZT6LuYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788523385;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aaKHRsB+G/FHlA5S9wcT5HTlIO+zp6EzKIEcBnkfvhg=;
	b=YtLRpAgKde0+bk86YffPWcRHTkkw0pRMa+QD9Pi/KARCRqd82idZA2RrZs+rPoGzzia7
	 WPEBq4Ss0u23Fna/BvEJ11fqYWV65AdDBzOrfuVGa/mxCqD0N5izJBcbPJW+t0vzkQiAP
	 hOkH5N0/DyWwPOtfEdb3JTde7c7L4ExYr/sHSRcPB4ounAya5WIF/HJFFwoR+Az5I2D78
	 csxUalxufUFf8seo3+Cnf4HxGXxfN1ep8doePg6LTIlQUgm6+jmgNLH6Ny3kF+0rGyISA
	 3DEGkPC6B1/q3Csqa6fWGO62sbE+22B6SQAwVqe/2Te86ydIay3o/921zDIYtmnIXzg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788523385;
	bh=aaKHRsB+G/FHlA5S9wcT5HTlIO+zp6EzKIEcBnkfvhg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bqX65tq1ZCFOJW1XI5QxNONyzvdQ040rQMWFjH0t9aeZux2PGbLlmNBkSH+1fNMvz
	 3U5Ufi2aHQrZa+j++0XfcFqdjtUXd33LnW9xUG36ZSF8l++pa5nnKW+tMf31WLqdRY
	 Ks1RJnU52W4VGq+OJFUS++P9tN+tdBOE5AdoDVfMSnRz/OhwAWy+Rkd1WGT9jwTnnN
	 hZMw9nMF6vngziVODfT3eHmiULgCrEhSoN4nyfvWQic6tHUcIISfnlvxFM/mSCWIvz
	 7OgZ0XtH0qN3QoWrUnB29dsO04+P6DTlhZZ3vPo2iqgxlzdGhi6zclwJDcugUM+IQq
	 cffSYYwv9PzDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FBEE60BB4;
	Fri,  4 Sep 2026 12:03:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51C0F10E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42A9280B04
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zik9DkVMNtY2 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 57D8C80AAE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788523383;
 b=ihR7jQJCeFlZTwJji95dmcG6r/PCn+iYR1xFkijYlkQHoPDlnGdBlksQsVwxjNPKcL5T
 iUPJFQida/k5GdfBy/h0edTvFtu3mEISWCEtLmSs+/ZOXgOsORo7e4Ta+lpJt9swNn348
 0aHaUj6KU0C2NMmSzTE0aPqR5eb1Ef83DK4I90pexwWKwZwagSolUZ/v5nQpdHijzRZAj
 jofUIObfLcvG0O+3K/CWANgffiayJ0w59SMPGzdSWGLEXFzACg29qXyUgCyO7UcaAcdNb
 es/8t3oBBTRFfUKaqncwqIK43ptSu/gxmEWHfFGSLpkX8/amrb/lDSaxKkciH7yo9Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788523383;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=aaKHRsB+G/FHlA5S9wcT5HTlIO+zp6EzKIEcBnkfvhg=;
 b=JC8exqyUKv2cPmIR+uWV0lgMKHFnMtN6Y+tt9HLadTJrrK+RK8cRsBSd6bgmYDCU/P3T
 r/qOS5KBcjaZJhZScv7zuFVzpczdwzMUcIxoc/ybmdDbkTgkcTBD1BQAjaMt6MFmgsfQf
 TPsFXJnAjoVPjgYcov+tZFio4gZXPz2NdkSsUqp93ThbBCiSgb3zKNXIVlTM8winVgHMQ
 cDiz2cwgBOdV1Asom0o/yEwesm3sLZcvUsfbujvzoDf7OS7RaiYFmayWP9Y1xl/IzvFt+
 prNEmUPWbtsVPN5TE+tmgXM84vE6hIU6tS2wqvQ8wRxz9JLWvW6D2VUYbAtSXw+cCVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Gx1Arf+m; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=dOBPR6Mh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Gx1Arf+m; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=dOBPR6Mh
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57D8C80AAE
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:02 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AHbsq3603163; Fri, 4 Sep 2026 07:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=aaKHRsB+G/FHlA5S9wcT5HTlIO+zp6EzKIEcBnkfv
 hg=; b=Gx1Arf+m5m3E9PHLb8YHaifHZ0u4Q5+Kj5F9bWeAjg2CDyGh2G8ssQu8C
 22qhKGgY7AZ06spBbs0jsGYZfPrYFDXOx0GNU+YlgpnKX4tFLdsdVLNajQIk3Kmo
 WXSV+hdW9Izx3T0CBnFYb/b1h/61Avp81luLN5G+RKJOtG8eAArKrBEp5fQ3cXKA
 ObYqrcxT1MekCgJbPNzZRdHe/KVKf/TgzZdC7M/aZn3WopDeP01KgffUHDM8y5ZG
 m2GoLx3u7mVI0N6MI77IURcIO5/9PiH2ew9iHp92bX2jNQ58/v9cJ36KVNWRtggl
 EGxEeSjjUpLMb83/DTwe8AQifGxcw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq5ww5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 04 Sep 2026 07:02:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svjtPyjYEpUM6FMNVjEmTa2G7oMFB7Ctgi1aN/TIN7hzCYIsCq6J1HW5jR4LH80RYDWlJ+mBBRAoWLzqU1ZjzdV/ryFfPFq5eRW4VXdEPz1Ru89uQm+3Z1imaXwXVnm/EP7/us2ARe/tvPhXDyJYTFpjeEECPuCydF/SpYFaXur+QHCp5A/lNdTmGgnIxsFwAyE+vwwB1V/FkGlvKq2iysyZE6TisktsKNaWg/WJiPefrNm7pZ2iF1kYLgd8o2L4hThGVgzJWmzdpl6TxhrgBJP0BtPrwMTIFzhXHetLL6SUb0WG8gISypsyC7ay3eUWYnBM++8jopZAxpxMeD3vnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaKHRsB+G/FHlA5S9wcT5HTlIO+zp6EzKIEcBnkfvhg=;
 b=NR5VikNANJSVZuyM9/YFeOOURn7gKQ+e34AL/Z3gW2eLOi/zVn9kOG6TCEyfjm0GlCJzecPb3Av8YBgG7R8RYOYPPSIadtIPG9/9cB0f99DgWKVTSvQL+uimVWSWNaZ15VOfnTntJCi5ZFFlZa3MzO1Serp2O7j4A5IsQqrVnamrLFdHoJx4PMLruXEZb/uMMrZnwz5rzDQ5XainyZHf6CjQ6VX/IFOKTwuOPc8tt0UF5rTHL7r+Z5sHTCQFJ+nwT+Scn8TNGUi0jb58Emir4AdftaY7QGj14xyo4CVt8dUC4NHTdpHdCvrOY/sTEjYQ1ZM9Aihu71MYJgbh1WpNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaKHRsB+G/FHlA5S9wcT5HTlIO+zp6EzKIEcBnkfvhg=;
 b=dOBPR6MhG/kGjRJOqzLP/ONOq6d376spYcGrW00p+boBJTpUzXTV8UTPMNp6mPJsNJOi37mXh/wofUTpaVmpNl7oPMHAzJ6sJ4gpA7R7RlVodj9/u3HnBLjF5C/PbD9PWE1CSrjHXBxcgxAOix/wtSHwLpJjPyKDYrsue7NHiUI=
Received: from BN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:ee::20)
 by LV3PR10MB8106.namprd10.prod.outlook.com (2603:10b6:408:27f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 12:02:58 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::a4) by BN0PR04CA0015.outlook.office365.com
 (2603:10b6:408:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 12:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 12:02:56 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:33 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 07:02:33 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684C2NcI3456269;
 Fri, 4 Sep 2026 07:02:31 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 3/7] pci: pcie_dw_ti: fetch reset-gpios from the device-tree
 and use it
Date: Fri, 4 Sep 2026 17:35:52 +0530
Message-ID: <20260904120604.3612484-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904120604.3612484-1-s-vadapalli@ti.com>
References: <20260904120604.3612484-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|LV3PR10MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: b04fbbf4-03e8-4cba-8ca1-08df0a7c7556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 86uEgNgJJt0QaK5RL42E3gyi/imb2RwyHqaMcdIPr23bCIY931ty8NUQ9/9C0ULj/8VUBk8O9/lmGE8V0PbFZ3wa9Ur72uq6aJ1fQr/C+4ruZ85QC1Kt6kvtAnn3WKzL6NEKHlItF6cco3AvNBG4sneNwv95TWVakG/Io25g5+ZB9ED/D2CJwPQyvELWE/gvIGjBo87YG8N1o34KNil2vZ/BepIoJ5KkU4CDn3sbWweItiu53xxdIpIPLponQQOhypaN3/eXTBCFcsp+xf4BW59j/192d186kQ6mPlpUv6f3WimBf1gO0G5qdiuXN1CgVMlbv/7d3KnXKwl7TQGGc4389ZXYJR7JvQBIwiW8BUisqxpGuOg6iIepBeMCZbt2aq1gVA/z7MqKgZe4TI9YPSf7ehtxZ9PXXscOwOZg99gONXv1CHo8LIxSiZtaVnOmUNhq031jCK4OA1FB4A8kJk93VYIDUFyx/OLPjNVutOkcIXxjFWdRgXFS+fFtletw1jjhSVnFd8HYCu5XP3bHwEfcgP4aVzuWdUZKvtEvqNk6+ZYxtXXKgkJ8ETWngvm57VJgtMi6OkXuwGbGDox56+UhAh3pRYfLwXhP+mQnyJLpt1K8YNFS4bjSNCYLJQLIP2f8YwcvOrIvcQqaalWXs6Cknogm7PxYJ5zkQ7rYPdTk9aVACmydRvtXCfII8mvkhuG7Fytn+npbeg7p62+T9g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4rRgb/F9ReJYw53gXvhomt7Qo5D4aYucg951a1xoTmM8H/wemiM9PfEPuAZIQGeAJ6e/km62RVhquEDIvnJbG83NLTQ7ZldGyUboYbLththooRBZyzXt2siVSJYwhxg0Jq8dTEDYZcvDYLDN1X4YqOemRO/QpMIPMnveA/JQKHB4qC2XDbfm/rnZhCgc5nhWloi78XbuZkFqIQWzFAeGauHk/peUu82T5N77TwNTLjeBPK+LjaJJErut7F3gY2rBwBnMlGjoK84fKTxrV4/UyanUAB1Hn49LynP6lmGqydb2PYcF3IECmOzOFGldbXo0PKN6gBKsBCv8Euex6E0EcKlKY18GiC14xDqkNLv6/lVkem3QdjVPvnpxls3+dOAr/010f6M+M2hHQS8mckFuhh6acR1ngcVBmGXxJS/oDZr1SNSUoDB1f1Fqegs8s3RX
X-Exchange-RoutingPolicyChecked: NAAUGNEZBj2sQHBII7iQyrR4GhobZttHeh8fzJnwwRRJH9joJoenUTsPHSsBn3eNqRJtclKPBpEw6ZdPGXg56v2AAO9iFISE1jKr5RAo5eB7pCEyVIKaUFEIRe73uNaCcngedfFBoXgi5zrUQ7L11jI6uycTD8FMSs3ISo0iR8Uy9WI+f6Vj/8/5bVHjklaaiZcijktu6ALzyOyVkygcUHs81RqS3MMo6X8JnoHZmkh/eSoBE/F+FL0wY6mlvNOMJ8yKRSYanRtC9kkmTa9yTwDJGe96WliTxq2KSkmxQfCSBmMqJJX/93K2nLQjRxDTGlizdEyXaY7Yn6VgYqz0nQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:02:56.9493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04fbbf4-03e8-4cba-8ca1-08df0a7c7556
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8106
X-Proofpoint-GUID: cVKbgtX717yClbAN5JiFUwKlb7KuchFm
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9ab373 cx=c_pps
 a=yBkm4pfunKk/gSODirLGag==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=vHqIwxMly1Rm0O3ZSAIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX8ZknIQg+pzC4
 YhjcNAQD4D5vJJhNjUFH3C5uh5py7OqBe0VD/i8B1Heo2gTTjQwDZSqIYbNT5Po4oRMtEGY+5cW
 cmoScVahTPUFoi/3dXg6jmayUnfYIKF4xVN0ZDOzFbhIFuYpeuIw86O4ZywGJeqSpzRQWs19xq/
 vwT3545dbyWQXYgsO1zV3fa1K1Ft/DZPUgj5+eJXup7VE59C2EsCPIu0iG8FkwfQ49kKQBnL/8z
 omWQnmYq7ai2ynVcil/nMNEd6BcGGVVQFVy+A2fwecqlm1DrFy1pCafiZFzlH97qusBy8feOJBL
 zcttYVJeUMzH7Oa1mvLQ3U5EAiz/DyPG31K8VUpCTIr3tR2pjLBYyrBZLH7bKvRFESL10RxurW9
 QjpKTlCQaNniyMEeXlcp8vUDKPHOppvn311EQH9koJw3rBTQkBk5sBIeazBmILAk7nFkWYO38Cs
 Ok9imzgqvaQA7sBgFQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX5OP9r6jYwXEA
 x/aaQk36ly+SRJkbGFprAKV3MPjS1czSGugRe9kXFH8vc7t+iGWCe8lUtNUU+QyXRO/868sXV4Q
 kad/aFpuKcuKzU+EI3yEFqO0VMxZkvs=
X-Proofpoint-ORIG-GUID: cVKbgtX717yClbAN5JiFUwKlb7KuchFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040107
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

The 'reset-gpios' property specified in the device-tree corresponds to
the PCI PERST# signal that is used to reset a PCI Endpoint. Since the
on-board circuitry may not reset the PCI Endpoint, fetch the 'reset-gpios'
device-tree property and toggle the GPIO line corresponding to the PERST#
signal to enable the PCI Endpoint. In the absence of the 'reset-gpios'
property in the device-tree, existing behavior is retained rather than
returning an error.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/pcie_dw_ti.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index fb39132f7c1..a34b142bbfb 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -58,6 +58,7 @@ struct pcie_dw_ti {
 	/* Must be first member of the struct */
 	struct pcie_dw dw;
 	void *app_base;
+	struct gpio_desc rst_gpio;
 	u32 num_lanes;
 };
 
@@ -252,6 +253,17 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 		return ret;
 	}
 
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &pci->rst_gpio,
+				   GPIOD_IS_OUT);
+	if (ret && ret != -ENOENT) {
+		dev_err(dev, "failed to get reset-gpios\n");
+		return ret;
+	}
+
+	/* Keep the reset-line asserted until the PCI Controller is ready */
+	if (dm_gpio_is_valid(&pci->rst_gpio))
+		dm_gpio_set_value(&pci->rst_gpio, 1);
+
 	ret = generic_phy_get_by_name(dev,  "pcie-phy0", &phy0);
 	if (ret) {
 		dev_err(dev, "Unable to get phy0");
@@ -281,6 +293,15 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 
 	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
 
+	/*
+	 * The reset-gpio (PERST#) should be held deasserted for at-least 100 ms
+	 * before the link is brought up.
+	 */
+	if (dm_gpio_is_valid(&pci->rst_gpio)) {
+		dm_gpio_set_value(&pci->rst_gpio, 0);
+		mdelay(100);
+	}
+
 	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		return -ENODEV;
-- 
2.51.1

