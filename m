Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE87C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 10:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2896680F4F;
	Wed,  2 Sep 2026 10:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEEJgIpxdgnV; Wed,  2 Sep 2026 10:31:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788345117;
	bh=hV9nF6Ugu9kcyHd9ousaVaqAABJVwCCtXIhir6z6mtA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qZ0zt+hWG69g4m5PB58QO313wWdGbD88RcXmWohEn5yvObGWT+5cGyOnuZJ4VYc9Z
	 Es93sAUe0pTsgpVcxFvh3A10T86U1g4rTpd8hRBLDdMbl3SipYhKDeWTpuYSwKA7of
	 P7g2/mAjkR/wJhMxumrqflfGm/3pvwj+fLbgGfxN5LFQwlFQg5BpN/9MAXtiMQA2PV
	 HsuZNdK3RUJ5fX90GNf978hrnLFcO8rovoABNpJJAOkv5UR9eWzqGrYm0D1dmuOYES
	 PEs/rPAaayd9Qy+sH7cyrUJ5k/i3lUkCTElkFSdB8g987iHCP5UvVDwhl6/O8VrEy/
	 PcXqzdPDlJzhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C907680F2F;
	Wed,  2 Sep 2026 10:31:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E174C2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C61E74077C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVj79TlHRgyG for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 06:38:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ei7+eum3; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=iNOCUvk1
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA7FA4077B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:38:33 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6826Txvc1625764;
 Wed, 2 Sep 2026 01:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=hV9nF6Ugu9kcyHd9ousaVaqAABJVwCCtXIhir6z6m
 tA=; b=Ei7+eum3pwLXOkY6bCDQAVSw5hMTGHUAi5Jgc7Z9sLtOLGJYjo+AoGhWZ
 oHzV0F/ZCjFFEyLUt6qphyJzNyiRQbrjFz8xtz0mypisOnARs28jYFvNy2uJ2DPL
 4fC+FeTXCBBiBg1/synnjoa2qyk4W6E4BJqyWbEGDyJ4/4cA/A3SNs/NoPqfqPvX
 5k8F2djOhypadoDiZsmzMjyEr69geEYIRnUnyX9tU4HlPoLp+BaEA0gxnNO5OFX4
 zJaAPUmoiyZAh86KpXCaKj6lFMxZOM8uWdtOEeF8E6uxKuC0Q8JgpPMwMp7iByzo
 1B+inPIy8mXG9CgOkaC6gUjVCLDuQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ge7gqa4x5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 01:38:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA6Tkcmoidk2ewg+RtMtmDmGCRneV696Y32Tv14IL5SsgcuOVb4o37LlNbqmwXX7t+OtLzi+hNUJzA5OptVDZvADtUQ0qQmQscVVWKUPFUyDywWie4ZRwgf5ddFx6qElLoZPAWcVGZuf8mld9HhoMoQ1QiEpWT8wBY5drhFlyniY0Qf7k5xPLrd7IIfVyGDTg40951Yv/SErn9sEC5GEQPQOvNDc1rgyau02M+znnH5zSQi0PmUM4ps145rb1er+tVd88pcHxaCstpV69ABG3hd6fYPQc8zyo362g7UOJZqSpfmAuMGl1/9LM4KM4S7WuvRMCnNSKDCJtP1ddSp79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV9nF6Ugu9kcyHd9ousaVaqAABJVwCCtXIhir6z6mtA=;
 b=M2K4cLOLtSG9DMcFplNQTDjxtSis27IE9/DiMZa1QiJ2umZWbcSTxzSt1YjpvdEtvTsO5v6yGQS219YPKhFYJxltcjbaJi6IOHNl6N42DWIDmfv26z36MujOEfOrFi5nY9oSz62Bv5fLkfSo4Fyc22/z4UFMdUPncRtE29A7u29u5Q2hii+llt4kvidcaJ42A/dpqrS2iJWkgyWkM1xw007MXzEgx9thFILyv+KekGMFFSi2v/TmOAMOcsR9fvPNxM1AGih4JW0pNVagOmsZalKX9+nVXJgba3hBs7HUfjh0mQve+yXO5QC9IWvaaroV9nff2vlxfnytul2/4n75UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV9nF6Ugu9kcyHd9ousaVaqAABJVwCCtXIhir6z6mtA=;
 b=iNOCUvk1umpoxbdH5HeCgg0rzagyHRzqbDRu/v46+POIVdzxjdcajorAuysCHxpr2BBz1dc5aPfr3sfqwZRryVfg0UiwxMNruoeLsqQNz59toAt/xG9AdVndm8rKOtlmJitxl/6SvfjafON39UPBD+seGKxLPcgODkyDwRGOncs=
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 06:38:24 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:510:348:cafe::2a) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 06:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 06:38:24 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 01:38:07 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 01:38:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 2 Sep 2026 01:38:07 -0500
Received: from [10.24.51.66]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.51.66])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6826c5An3250980;
 Wed, 2 Sep 2026 01:38:05 -0500
Message-ID: <5b0bbcca-cef5-4b8a-86d4-03658e73707a@ti.com>
Date: Wed, 2 Sep 2026 12:08:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] doc: ti: document A Core no-SPL boot mode for
 J784S4 EVM
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <a-nandan@ti.com>,
 <u-boot@lists.u-boot-project.org>
References: <20260819101910.39192-1-g-praveen@ti.com>
 <20260819101910.39192-4-g-praveen@ti.com>
 <20260901162036.6jzuqt2qn4tdxxqf@bryanbrattlof.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260901162036.6jzuqt2qn4tdxxqf@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: c980f037-b265-4a5e-8a63-08df08bcc9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: +sRHJvun37O0XR4VAJ5ea7aVsF032PcdpZvjKbvPUEWWoAN6ia0ZH1YqebD2C3R3eh2mpcXBdC0SsATlCfkU5+EJ/OjzG4FfPR87+S7bkb64NsBk9J3SrFOm44s+AqD27hWRYfvjDisz5qDu3mIv+Jlk7Jb/lvgnKQTvFi6tUWMx7Ku/OEJTCtiJ8nCxbqlzbxjDVNRNXl4hDVElCTi66q4acgG4gqNd2YYAnsyvQVGIlDRZY37kLR9VvaQIecZF3hOpo9r3jKbMwsSpNLCwqEi9jFmmX9RBYLiyQ6z8vDsWiDNUAZ5TOLHielob/czQOaBKUsga7mHUT1fcK4GQCJWL8YZirESfaTTW7R9tmjs9K2zyBSdAncte8vtIf7x4A7G28jKuekMNWzzJhKPG0xtyxOAo/oHtCkHpa/ce18Q4DhjdYxknQOTrfU/bgy1pCabWaTvHgtgXmKi3rLMB7ipBmjbrd1jt6woFF2eR8w5XWUg7fgaeSs2WX+/sl6+vgQAwXZyiBdxyGhDPrRKfJ/QvzdaMb0+MHyRJA4f3Cu9eRSzXeKnC9X2UqkhClKoM+AoR3+QJlF5MXvfJ52QGf1pIqjQwCH6DDn37qr6BGdlHkC7KxjyGIt2zvhLG1DYELv4I4sajpESWzsCZQ6Nwf3pE4HsTf99BziX03l03Wuc=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SGpuptHdhNfP1p2ciLqlLI9iK8eQzBQjrXQG8hGcaep+Z1NkBljDl31NP8CkMGLR6+UxlRfsM2DJ1cFUxcfazRJ/0R6kFpFtHEqoI8pwU88mLLnNAd+GHyJWIuCmWhKAkixJPYe4CaO1JmMeMRlUJeCxb29iWp53wopuu4wWFrjw43PORsuvs3rvIIVduNq50PJUmGWgKh1ZYvmOQGLX+rYS1P/QUumk8W2NJQ98SraeBfY3becMfXfLdD7U2v4iKM9K4y+9+PyFdfJVGb1oYBgK3wLOeIV+VhuONF8VUHRfI03YpexoplpWjT5JWwl2jb5wPnt37SY1A3zh5FQLRPa6M1eUYdjI4oZzqIxt8q4aE3vnzu0UBiMMYhvCW9VwMbrXMmzEe3XI9BTAYA/fTiO2oIjm3n+H6cFprnfBexgrjY2hjiZzNjP2oJ7NXZg5
X-Exchange-RoutingPolicyChecked: uL6PT/qGWcsRppMBKkGT9s/l2/SRVl9kxQ6k8r5mIlFxv+cxLr1TlXfk4Hwv2D/AeYOoydxN0qpPnN3tK2W02k4C/1foO33/Az2H41WlW1aE523YXXTd2QU8E+1OEfa8TmJtdUnMj/p5idSllJwTcVGkbU9yI/egW3xi6CbUmMPjW+N4aimpoQ+emeFCYF2Mzbuyn+MA2k4aGsKDqe+egrTP+20Gagy3QdC8JFkjvT/po4EwLZjXDHZcBYvaG4/nY2MMZ2dDy3VAPvTRiDMlHWiNXDN1FPqbItglUKbth8QgiGM6CJmQdB+0HQQFREppnwLkmBSaeDYTT+rw8CaryA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 06:38:24.0568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c980f037-b265-4a5e-8a63-08df08bcc9bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Authority-Analysis: v=2.4 cv=fZ6dDUQF c=1 sm=1 tr=0 ts=6a97c466 cx=c_pps
 a=56tib/hgGBcemyuyLZC9AQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=1VxDqnHFAAAA:8
 a=sozttTNsAAAA:8 a=OGwOVZWeX5wcxmvJYR4A:9 a=QEXdDO2ut3YA:10
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-GUID: 1TqN2I_F0pWpkVzBAV6RXPBwLAqm7SbS
X-Proofpoint-ORIG-GUID: 1TqN2I_F0pWpkVzBAV6RXPBwLAqm7SbS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA1NiBTYWx0ZWRfX24a6ZxAyMPqU
 tvD00GKnLR/j6qhdB8RTlGmIHtCvDaNAT5/eEcjUJrTu9UDq89DQCrmO5vt7g7knThHGEZ7mDW/
 GRgYFAcIz1WOOJA7mPyZ5NykrtLcfhI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA1NiBTYWx0ZWRfX7ahUvB6uDuxk
 yaXWtyQQpR3waf+/GtrP8tsRpffLoMNaW6D+Zsu28VDxPUM6Bl3FPdojop41yEHVdi496CTtW5Q
 gPZQc+RvnVD9p9cDXZU0y0GnMnXivGZQ3MmtJIGqwjSTUppbHLp+8ZJ91m4sSkDWkLHfzfj3UA+
 rg+O/YztlykD57JXye8aurqj51VtX0hO0lf14yJApx3XPwYUKkChFznILR8EYw2Klc1ZwIqfWwt
 1qDOWs4lUqFdPz1GJsI9xI4DDJQELfNvPOrGFeHykGt7FWiNJDDMHdxBSlQhKN/Q1kgdB1QuYCu
 IJii4kSclFB+T5KxyYZ3TVAnDNKtS9R+3yKI285DCKmZO8+E2RD5/cdInrDOMvXvsdRjybK2Y4s
 Qmf3FpNqBJRbG7bVRg32h/22EYXdlI/CjFjaUYUW9tHsV2ieWg1Fk/nqqqtQBRjB0m2OZvjhcJG
 Jm99mb2/cjEE7ZO1Z5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020056
X-Mailman-Approved-At: Wed, 02 Sep 2026 10:31:56 +0000
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

Hi Bryan,

On 01/09/26 21:50, Bryan Brattlof wrote:
> On August 19, 2026 thus sayeth Gokul Praveen:
>> This patch adds user documentation for the A Core no-SPL boot mode
>> on J784S4 EVM, where R5 SPL directly loads U-Boot proper, bypassing
>> the A Core SPL stage.
>>
>> The documentation covers the boot flow, build steps, and usage
>> instructions for this boot mode using tinospl.bin.
>>
>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> ---
>>   doc/board/ti/j784s4_evm.rst | 143 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 143 insertions(+)
>>
>> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
>> index ec82228ab90..cf870066291 100644
>> --- a/doc/board/ti/j784s4_evm.rst
>> +++ b/doc/board/ti/j784s4_evm.rst
>> @@ -637,6 +637,149 @@ to the J784S4 endpoint:
>>   This program copies the boot image to the PCIe endpoint's memory region and
>>   writes the necessary control words to signal image transfer completion.
>>   
>> +A-Core No-SPL Boot Mode
>> +----------------
>> +
>> +A-Core No-SPL Boot Mode on J784S4 platforms is a boot approach that bypasses
>> +the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
>> +boot times compared to normal boot while maintaining U-Boot's flexibility for
>> +kernel loading and system configuration.
>> +
>> +**Key differences from Normal Boot:**
>> +
>> +* Skips A72 SPL execution
>> +* U-Boot binary included in tinospl.bin alongside TFA, OP-TEE, and DM
>> +* U-Boot loads at CONFIG_TEXT_BASE=0x80080000 (A72 SPL's earlier load location)
>> +
>> +Boot Flow
>> +^^^^^^^^^
>> +
>> +**Normal boot flow:**
>> +
>> +.. code-block::
>> +
>> +             | tiboot3.bin |         tispl.bin          | u-boot.img |  Image  |
>> +             |-------------+----------------------------+------------+---------|
>> +    R5 Core  |    SPL      |                            |            |         |
>> +    ---------|       \     |                            |            |         |
>> +    A72 Core |        ------> TFA -> OP-TEE -> A72 SPL -->  U-Boot  --> Kernel |
>> +
>> +**With  A-Core no-SPL boot mode:**
>> +
>> +.. code-block::
>> +
>> +             | tiboot3.bin |        tinospl.bin          |  Image  |
>> +             |-------------+-----------------------------+---------|
>> +    R5 Core  |    SPL      |                             |         |
>> +    ---------|       \     |                             |         |
>> +    A72 Core |        ------> TFA -> OP-TEE -> DM -> U-Boot --> Kernel |
> Why would DM need to run on any of the Cortex-A cores in this boot mode?
Appologies for that, it was a mistake in the documentation. I will 
update that.
>> +
>> +Build Process
>> +^^^^^^^^^^^^^
>> +
>> +Enabling A-Core no-SPL boot mode requires re-building U-Boot as follows:
>> +
>> +0. Setup environment variables:
>> +"""""""""""""""""""""""""""""""
>> +
>> +Refer to the build procedure above for setting up the environment variables.
>> +
>> +1. U-Boot:
>> +""""""""""
>> +
>> +* **1.1 R5:**
>> +
>> +.. prompt:: bash $
>> +
>> + # use the no-SPL config fragment for K3 platforms
>> + export UBOOT_NOSPL_CFG_FRAGMENTR="k3_r5_nospl.config"
>> + export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_NOSPL_CFG_FRAGMENTR}"
>> +
>> +.. include::  k3.rst
>> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
>> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
>> +
>> +* **1.2 A72:**
>> +
>> +.. prompt:: bash $
>> +
>> + # use the no-SPL config fragment for A72
>> + export UBOOT_NOSPL_CFG_FRAGMENTA="k3_a72_nospl.config"
>> + export UBOOT_CFG_CORTEXA="${UBOOT_CFG_CORTEXA} ${UBOOT_NOSPL_CFG_FRAGMENTA}"
>> +
>> +.. include::  k3.rst
>> +    :start-after: .. k3_rst_include_start_build_steps_uboot
>> +    :end-before: .. k3_rst_include_end_build_steps_uboot
>> +
>> +.. note::
>> +
>> +    The ``tinospl.bin`` file is automatically generated by binman during
>> +    the A72 U-Boot build process. This binary contains TFA, OP-TEE, DM, and
>> +    the U-Boot binary with its device tree.
>> +
>> +Usage
>> +^^^^^
>> +
>> +A-Core No-SPL Boot Mode uses a specialized binary called ``tinospl.bin`` which
>> +contains all necessary components to boot directly to U-Boot without loading
>> +the A72 SPL.
>> +
>> +**tinospl.bin structure:**
>> +
>> +The tinospl.bin is a FIT image containing:
>> +
>> +* **ATF (ARM Trusted Firmware)** - loaded at CONFIG_K3_ATF_LOAD_ADDR
>> +* **OP-TEE** - loaded at CONFIG_K3_OPTEE_LOAD_ADDR
>> +* **DM (Device Manager)** - loaded at 0x89000000
>> +* **U-Boot** - loaded at CONFIG_TEXT_BASE (0x80080000)
>> +* **DTB (Device Tree Blob)** - U-Boot device tree
>> +
>> +The R5 SPL requires both ``tiboot3.bin`` and ``tinospl.bin`` to be present
>> +in the boot partition (first partition) of the MMC device. By default, the SD
>> +card boot partition is used (``mmcdev=1``). The ``bootpart`` environment variable
>> +defaults to 1:2, specifying the second partition of the SD card.
>> +
>> +To use eMMC instead of SD as the boot media, rebuild the R5 SPL with the
>> +following diff:
>> +
>> +.. code-block:: diff
>> +
>> +    diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
>> +    index 82b9f0741bb..73d59ac425c 100644
>> +    --- a/board/ti/j784s4/j784s4.env
>> +    +++ b/board/ti/j784s4/j784s4.env
>> +    @@ -17,8 +17,8 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
>> +
>> +     boot_targets=mmc1 mmc0 usb pxe dhcp
>> +     boot=mmc
>> +    -mmcdev=1
>> +    -bootpart=1:2
>> +    +mmcdev=0
>> +    +bootpart=0:2
>> +     bootdir=/boot
>> +     rd_spec=-
>> +
> Does this still work? Long ago we moved all of TI's reference boards to
> use the stdboot flow[0].

Yes, this still works, Bryan.

Regards

Gokul Praveen

> ~Bryan
>
> [0] https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/configs/j784s4_evm_a72_defconfig?ref_type=heads#L34
