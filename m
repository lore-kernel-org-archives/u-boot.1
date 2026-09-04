Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1030CC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B96C360C1C;
	Fri,  4 Sep 2026 12:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GFbO4eytfwgU; Fri,  4 Sep 2026 12:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 79C7660BB4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788523392;
	b=SKklZBTEVn7sshlRJc1eBIwJpFSpMkV0SF1ZiBD9v8dBIiFUOiXOhysChBVQf38uTEIq
	 ND16iCsHwDCgnb4dHCtOoufB1FqmRluC61yivIHRJmHCRcscQFKVvrU9CU2nj2XHnevD0
	 tFZsJvD9voFsFbNBIW1Xch1uvOJQuLRvWTgpIWoZ4CkQUHJdO/mJOsTjD5AmowKFUNgFN
	 r75kJ0w26xE9cmiAwExO7JFH8ZaKhs/o2IY44tx75OiaTQ9ZDBzaLiarTP8PSfxjpJ68Q
	 z5GX5j4qtBxQUR36ucJhDSIpQkTFuzuELrdFrF62ZaXFk+T0rDGz/+rrSIjst9TvW5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788523392;
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=enROkBNy2RyojE+lilC9ATjkjdmWHfX/klfNN9Z3bMo=;
	b=MezosC7nqjkTMlOrr9puCZjB+ZKOpsCxrpzCU3RHPVRXB9lUvpoVtQWtroPLyzXiFfUX
	 BYZmAGARgjuUO4KoB47le/qY3h2zAiUaOHQBYtIdC53Ddm7jMn6cNWwQdxamRK/CbRrYN
	 mMGTGDQ1XCRfGCzgTHcDlBZBcQVfFC31h9g4p84atQEYBcARA+eGaA+n25n4TeweGYnsP
	 d0OLdZzxRrySc/ZVrJyVdTy6VbILATzrEgnlfNkd7zVc2d2aXFVmdRthCCC2hkLRxaEXK
	 +MZtt45CmojAq4X4WcHlhOBX+Mgnjas1ySFVwkuTDnY4+qvbHNmZHcyBGlIGLtMafcw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788523392;
	bh=enROkBNy2RyojE+lilC9ATjkjdmWHfX/klfNN9Z3bMo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Aea+0d+BcL//Z/4IxtXfCmKZsqN7Cf4MUDTt5yiJsgnN4CoA4xXktRcABeNyLVXHH
	 3AOGPjodb7iCjR6U6iilkbAkiEw7qwRqBqls5NQcpnH8CWApfGIqOnIUtvRSIbjZ0y
	 uyQxA1NxyZF1hmnRpex2w3uF/wN7z0C/RHnzeq3zQmk2/QPmnkqMbczShJWaBLPVnW
	 V1ddF7p685TgSot9ReK8x9+Lu3rpuGkgIvKZux7Qk46evpV+P68TwBpEzaa5xXtrNa
	 JCyZ60T5mkELuxqPOhX4CxdDz9YkkMmhTt+EaPwBoNIP9mDhrVJ0mfSolduHFTyLnF
	 HHZgFB7P/sGsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79C7660BB4;
	Fri,  4 Sep 2026 12:03:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F9EA77F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35DCF40B7F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2FtcqFH14tFT for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:03:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 48C9640B28
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788523390;
 b=OrEurPm0NnF1ufvv3UNA8LkeLG6xnXT+AyfAIC94UoPid6u6Y7GBPX3eTezHnkbLifzt
 IL4Jap5t8HmcXtpztfIqhAtO9N/gJ758ALdiiDd2gn6o1j4IZJkbq7ZOuwKetSTi0xDa/
 FRG3L+92NNYc0FO2r3JvkIEr4yQOfRgWMw8y8K9MCt3v9JUcfpQKQuOAGWicpRGvyoUcQ
 JpXKUS3vmAM3Y4f4Bz3YoER94drRpWhU5Hfl+hy6QPGoXcZTHLDEBtsJuqR2xGy+qG6dd
 33fVx04Dnp8hynVmU+4SZO9gjs94xbVYBpQROP8fS9LPFZG1O8IzvNeDa2cwKJAWUQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788523390;
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
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=enROkBNy2RyojE+lilC9ATjkjdmWHfX/klfNN9Z3bMo=;
 b=CsmlhAW+0O8d8MePZxZo7WfmDINRU8j5TDumBFnIiGGSgO7WypDLS7xLM7ybKm4ys8ej
 vQO9bmUJHpCEJCNsUSc01MXAxuxO4wIcNizpRwDY2yYp3jUFlGM/OGylz8+3vZ0tEzVwo
 1vZqlGD9kscQ9FootyEcjjB4SawQnc577VA8jYuvgjmd5IvOuu72sXpu08QQmLpB3v5Kl
 n5ZID2IqmYY7TSxWG3/duHyJISkQWMdt9LPaOBYYux9/8rzF4DUZMI8CTfv93dXHTO1BS
 ai6bSd1F1e6G9c60YUIAYp561xylw5Ln74g+CQDRZrp+lqZqmSbaID/X4Z/dZ3Jireg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cKBDBh+V; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=OSB6Hk1w; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cKBDBh+V; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=OSB6Hk1w
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48C9640B28
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:09 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AHoCi3238091; Fri, 4 Sep 2026 07:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=enROkBNy2RyojE+lilC9ATjkjdmWHfX/klfNN9Z3b
 Mo=; b=cKBDBh+V6SXYmV86Sq80QT8b28L7rgS1HkDtQnWrb/u3cR3jjgNn8PuJH
 RWJd+X9a+Yz6jQt0zQ5u3+Orr+wK83mlidKyOlaW4M9nNM9YJ3w++YMPq+yEJvaP
 WNZV1+oXRieMVZR/uxLfyJ/nN7u0qJOlt4AAT25woj9GNOgno2UNGQoJA4dh0R+d
 rrlIPl2TJRWtGCvflZm3iuRE1Hn2PtJkmSjtgrYzjXE0hx0+AVGNoElAMIqCCd2Z
 WjWdMrkYvShA6cFlvejSfd96SvimDTzca5ByVHseoVTAYKr+KJ7ELvYAeBSI7Q3N
 DiyGo/rgBzK2spkeZlpbwEsVCyzOw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfu6w8sye-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 04 Sep 2026 07:03:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhhJFXcdZ4v2Vqf/s5kP9I9fTDjvWtAoq1OmPhugm/5ba8swZzsrGZRhmpP8n0Pk8qbDj8MtTjnukFdDnrhAbCq40/nAHRLJmy/OVNyHqhGtTIvzLPVmlCujWmfBVPqGoV4eacurpLALddYkijvAAwgUXEQ6nebx61JBtI32jbzsmlFci1wuIN4Ou+ZG6fhO2x5qsfBP5yTm9k7n6g8oG2K1w4Z/K0aW9+PSs6AXk5CkmVZEqT5GiVQ5Ej3xw7VuO8P3aQGADKy1ly5xF5RWK01mRKpFF9N+xJYTIbhd7Ibrpiaw8xg2K0EKwLWnpxZPFc6QtKJejmKTPd+i/YAilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enROkBNy2RyojE+lilC9ATjkjdmWHfX/klfNN9Z3bMo=;
 b=bvqhqVHXySwvHvABBMncOdzBpWplZ8964j9rdgBrYS79j0KwhtPLJzEhlQLekac8Z/1vyWH2J3AKVlqviUFhTAKqVXSW1AtCfbyzvKSPijrstCaJY73VFi1o0dR8krLIs76/D5tSN35z269FXZoZbvW17yo3enNt76cor4a55z/DluDl/jvzce6SEt9Zj/MoZzbArCUOjCLEF19jvH+QSejJ26ENb0+XbFNYDO2XDZf435EAOubwKmIOh43tL4zv37FPLB8g4h7Y9lrduec64GI/81lCrFlbbsJdoWqPB1oYFgMel7TpIYrQM/U6MTokOfrGlAvamzkBomuvmAFR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enROkBNy2RyojE+lilC9ATjkjdmWHfX/klfNN9Z3bMo=;
 b=OSB6Hk1w7+246EXXEKc/DFlVgm9J2Rzj1XqfX64OI2j7xmBAAajUVoxUExGFVzQFhVeVNrtuUpF2LZYipStGdUhyYGbZ6YsJWCg5esVVy/MpLIflDj4xXucDiTjWMf7PrN8497gdEzx1a+Bfhj7LBIS0sXpl0cv1og2niZ/8VwE=
Received: from CH0PR08CA0022.namprd08.prod.outlook.com (2603:10b6:610:33::27)
 by SABPR10MB997943.namprd10.prod.outlook.com (2603:10b6:806:50b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 12:03:05 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::59) by CH0PR08CA0022.outlook.office365.com
 (2603:10b6:610:33::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 12:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 12:03:04 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:43 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 07:02:43 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684C2NcM3456269;
 Fri, 4 Sep 2026 07:02:41 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 7/7] configs: am65x_evm_a53_defconfig: enable support for
 PCI-USB2 daughtercard
Date: Fri, 4 Sep 2026 17:35:56 +0530
Message-ID: <20260904120604.3612484-8-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904120604.3612484-1-s-vadapalli@ti.com>
References: <20260904120604.3612484-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SABPR10MB997943:EE_
X-MS-Office365-Filtering-Correlation-Id: d274bf30-c8bc-4073-deab-08df0a7c799d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|3023799007|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: GyhkkgnHUnpUAwoC4d5qRZVhYOX1QNTON6ZvpVFKM/US2BxQpBQy7AtaR7P8SJ6oyjWa0DLDJBeQNR66cMrURcVtD721n25QY1Cz1HVxu1jufO2dIwdMJZJwWMtVH3351ttWleNB/dabLjJPm0FSxOPGjJG+wqO+0yYm3sW3lJhU1DqMTVqKNJBfyoWcHLMYFLh61hIiKEZVidDlZMJFRJZ9vL3LN07krZE+83OhQpQK82wD45tYpTAK92xGHjBO9Vdvyqp3zVAzEcFTpdDYsoiFuN79O/EOOP28L/BVU+dNEEZtil8hjUIt511cFlAX89AGA5MaJJtfFX9Z1RkqsLQV9L72PNu6ygnswmaXQleAUmwOPml0/R4QPh1hxCH9J7Kr3oxZIyrcj3bOKN4S5tKhzuOmR4hIP7++Ja0QDaAAxvinSTgdVY/YKNyGYqpVy7cwpodhVQLv8zlQSQ8Bw4hv/MNhDS2/SF0ZHTdN2mmdpywbMhbA0zEZo9+Wsklf2xK9hBDITvyiy7BgA5/IMgBeZUP/ppFC2QYwV+T5k5AML88kY3nbfKx4G7LC0xsLmiaS+0TOdTz0fa/tQ+LoJ8lXg75ZMaRR2WLblrnUwAI1IZktzvdM64c6PiVdaGBJDaWRxPMOoE/xIHyimix1SXRBoZvKB+Ao1+7/wAKaBMjaLSdOQ+TCB2AFfTBY/3c/GO1pO21cnTs1cCHE9fxcCQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(3023799007)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3MSqitmgUmOtVAhq4bLPmAybaDGqkwc3zzxy/YtZ8tJWmwZy1lghVVhJpJcE0/CjFqxKUHbxMvJDwF+t+DK/w0xv7t4j+P+m/SeeQpFk1EpqmiZSs/WXQaaLBlNa7liUlfXKyp40JrHWaGY2WVW71LIu0jETpZfmFIgqb5lmzeETu1u2thGBeZB7lrzfY4p9T4aho/bvd97+SES9BK1Rmt50RH1PR/X4B34yKvdPJHvr7/UzaK++Z/CfU6Cm/LAMEyYLooRCgiG88thZ8k6xrBU21x8n0r/pViDYnoG4Ee6X++b+E+qsVXA5scHYAezrJTIaof6Sao0mkIXDCWXM30ykRFLwfAOCmxwxbPOoe3F2gkbtO1N8o8kD8RG6GzFNTjPjpn3qmsj6BhhojeWCdpHfh1k+fly3Dt+kX5Usm99VZ3BMoMagbppTl+Zv3/yK
X-Exchange-RoutingPolicyChecked: uPndKggnQfINhB1H6n4igOWB7waFDk5W0R22kwAIrmbs70VpCFR5qmbHWzwNL0uNMFt/tUQ/JZcMAGNrwvrdxfoxPq7Q4HDhy68DYFUud0zHL1pyt4uSo+Jzp9Ge3lx/fgLv6j41ZivUnbcpobNAQV02W3G9T4VPEfbT+gurkwWy0QOb1nSAduuhXy87SHXotcepB9K1lWXkYI7HCTPZDoweixA1wYdTB5OP9m87Hm+t1ka33sacOylHl/1zzFdOVODXvoUaGfO/7/5rGHyVfGZp9BiD5/TaNDvPqg/cwv8Ls2i/qRFDgbbxbCk9jLTyYh0AbcNg3MIEvBQlwl6IHQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:03:04.1397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d274bf30-c8bc-4073-deab-08df0a7c799d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR10MB997943
X-Authority-Analysis: v=2.4 cv=XLoAjwhE c=1 sm=1 tr=0 ts=6a9ab37b cx=c_pps
 a=+UayH2mdqs80qU9+PBkj6w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=viOXP6cfK7h9U6r7EzwA:9
X-Proofpoint-ORIG-GUID: 3ODoeO05_Bo9_jgeXlJb3mdIzeDoipz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX/2PvoPHa7L2w
 4jRMvOf6uX4On42dcsCQ1vyqWJ29Ki/bpyvtF2DsSaZM9ANkWbkcx7nmg84fCs4AO2V9YF2GRd7
 hgebtMTcPc0zsvR4mGeWLp2p1C4NJIXj8j4Vm7cYjoaiqJM4Y9AhvsEzKATBkcul1zXJkIm/k20
 RWn1YZF/NDig94RrnZ10EhwxO6kRK6YbL2RTgB335SWmUKcwkQqmUSvXrV9az948nQsppLFZF4z
 iIwieASPFxHd6Vq0a4bU4PjjD3PZNLJPtpU4qNwr60XehlNlOwSdnAFMON0YlAk0Bw9MkmOQgBm
 br6EEHuqYq96BgRDeQSb6FqC0ZLulFxiVAb5IvCp13bjqMRxN6updTPLXF4TRXRkGW2jvt95btM
 zAT9I3Ewr/IGK9l/OCR4IuuDElIStEuLzKG7C36QE+XY511r7PsGS2oIOTDIYC7F5nKcfW3VWax
 xbxwIkHcq2/U74qkuVA==
X-Proofpoint-GUID: 3ODoeO05_Bo9_jgeXlJb3mdIzeDoipz-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX01z5qSY3tLsq
 dQM2EDLMUA3Ye6AKRR7p95ZVi2JiPQDv87lhNNz0eGo4n+8zvWsnNUwbZob5caGGQlmA3deQLHR
 5MJtB+IztRNwFXecl4kyauehwoQDvJY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
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

The PCI-USB2 daughtercard can be mounted on the AM654 Base-Board (EVM)
to enable PCI x2 Lane and USB2.0 functionality. Adding support for this
involves:
1. Detecting the daughtercard at A53 SPL stage
   => CONFIG_SPL_BOARD_INIT (to probe daughtercards)
2. Packaging the device-tree overlay for A53 SPL to modify U-Boot
   proper's device-tree at runtime
   => CONFIG_OF_OVERLAY_LIST (updated to include k3-am654-pcie-usb2")
3. GPIO support at A53 SPL stage for detecting the daughtercard using
   GPIO pin 38 on WKUP I2C0
   => CONFIG_SPL_GPIO
   => CONFIG_SPL_DM_GPIO
   => CONFIG_SPL_DM_PCA953X

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/am65x_evm_a53_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 5878816f63b..036efbb0e35 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -11,6 +11,8 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
 CONFIG_DM_GPIO=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am654-base-board"
 CONFIG_DM_RESET=y
@@ -31,6 +33,7 @@ CONFIG_SPL_SPI=y
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
 CONFIG_DISTRO_DEFAULTS=y
@@ -64,7 +67,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_OVERLAY_LIST="ti/k3-am654-icssg2"
+CONFIG_OF_OVERLAY_LIST="ti/k3-am654-icssg2 ti/k3-am654-pcie-usb2"
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
@@ -89,6 +92,7 @@ CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
 CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_DM_I2C_GPIO=y
-- 
2.51.1

