Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E283C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 18:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3C1740756;
	Tue,  1 Sep 2026 18:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ea1TmF0LgNiT; Tue,  1 Sep 2026 18:48:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788288536;
	bh=oW+UGQzp/OkRrCI4wQIpYRb8jjkYQm+NJrxtgzQXUS0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GQX5hoyyj/PDTJk/zpq/RkZhWro8dREd2TsbWOpFHp61OIWahC0T35mtld+JOrxfH
	 iDSHSW5/78KsjyO2suEQkxbheIP+zCuoF7FbngZN7WQlqq2w/y/lzJoJs+N1t009tp
	 O8deGeLTow/RlQydb97yTy++hpLYqoRACt8rB6Icsy7zQD6h9/IkN2yC9+/4HZCwKw
	 LTzREu3bHU4rTyUmu+CZG7iscnhJOJEIlZVSxP4TvdMLwCHX1j7+n68JW69QCTlktu
	 ODnkt7822Za/gbnDHi2JUd4mxSyfzOKwYIDzpc1snimSdT190Al1NlyheFyAL2q8ee
	 zyqYUswWtZ9zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F87240755;
	Tue,  1 Sep 2026 18:48:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1143C1D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB44960749
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4SEKNAP_0Ed for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 18:48:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=p3gNz9Sf; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=saNhctQj
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FB0D607AB
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:48:52 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 681He1jg3051065;
 Tue, 1 Sep 2026 13:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=oW+UGQzp/OkRrCI
 4wQIpYRb8jjkYQm+NJrxtgzQXUS0=; b=p3gNz9SfvvesuS1hBMTLxExA5Iia6cW
 ErV2YZBPD5yUcbp1FSol/dgUUnTTnpwxBO651pxWJQgxZdyJHSA1DKbjB1dBV4+G
 WcNccIvEpwU/aKNF/Y9f+Nzw/ckaRjoFa0iCxbEiEFyDZRgsRdqPdsbA0hJpJJB0
 cGH/EcnoGNwADMD3IxxxkALZLRnn7gdDoOn5+cbgbmne/dStNifA/9XeENz4D8mB
 oQ1CbVB+YEKmuzDzA6hIBOcSUhii4qePT3ezpIt/mkpRzNblESCk6lBU3e61lCuL
 ilL9bl6dV7Ygcg79oESBWDe3edXIPcN0wTrYIqxr5blAr3j96SJhcjA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gdmp2pch9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 13:48:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMqtYxPsb4KMGs3tgjCuofpDzDCCU6vAx0OInarLrxrkjgMrpn3Ol8g5oP8gNED4di//pHLp1qr1sJMDVzDRZMgUi72foo9k6jPVFaHJ5d2Z7ZnkekLw5Eeppy2HVvA7i8A2j9tA+LhJN5Pjl9xrr9vVfA6q+Avcr2kK0NGtSM8nsLcZ29761QHuhQ/RqPny54WmkATN+6KJvsqAbGHpl4g9S4i+agb5dcfdMTF88tthhwVkGuM7MtlI396XvEVGSK6Wr4uA+zxtOY04+9c9feLmb6IUAUAeIHKuTDzT3p1X3ZHaFeA+j2gMc4d2Xv9j2+fodmMXGAbjH1FlcRyTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW+UGQzp/OkRrCI4wQIpYRb8jjkYQm+NJrxtgzQXUS0=;
 b=o5iF7035THK/hJ3JV5uAYAlOoOHw3Tpo+D5ft5rv2RYDgYXcKOhe0JZFclnIV+LjPlHJ/hYwmERyWSv9sM87CMOyyPDhSfvAvnmcz2gAfuNi4BHS23Vif8Udz+n4sljnqitOBfpiw+MWAawgy3C41rpCSQ0+E748cyPN3ATZia8F4EpzXVvvUTtKM2w1X4TI3oX08qCEvznkG80SXdtFm/taTf6Ly4U9cEVFrF3etsVqWnFpAbOLkzbs/D/zYokujucVLPqBNg1gCIaPRUzZukXZStk3cfv5OPwzSLt+iFcZwllz4L2SD11riR+9rZhNxBidtVjNOVzyasW/Gp5ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW+UGQzp/OkRrCI4wQIpYRb8jjkYQm+NJrxtgzQXUS0=;
 b=saNhctQjiHLXR5pJe/R9RUp0EuThdJYOcdo0fuGj2wC2cW7IXmsWsC3ky5dyVp4ZySiBBqgtVSMDta+0nLcW0JN9nu5ebEpAHYoQT/NW434YP4VSSywkO+v42EUh/tke992OqXYqWq6KXtdOJTO3DV4fuqxq7L2wbnj8uGv8FLY=
Received: from SA9PR13CA0042.namprd13.prod.outlook.com (2603:10b6:806:22::17)
 by MW5PR10MB5827.namprd10.prod.outlook.com (2603:10b6:303:19c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 18:48:42 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::a8) by SA9PR13CA0042.outlook.office365.com
 (2603:10b6:806:22::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 18:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 18:48:42 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 13:48:22 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 13:48:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 1 Sep 2026 13:48:21 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 681ImLeD3327683;
 Tue, 1 Sep 2026 13:48:21 -0500
Date: Tue, 1 Sep 2026 13:48:21 -0500
From: Bryan Brattlof <bb@ti.com>
To: Patryk Biel <pbiel7@gmail.com>
CC: <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] arm: mach-k3: j721e: make get_boot_device() available
 outside xPL
Message-ID: <20260901184821.lq2n53ucpymfidbv@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260813-up-j721e-get-boot-device-v1-1-fb50a5a328d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260813-up-j721e-get-boot-device-v1-1-fb50a5a328d0@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MW5PR10MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc9340b-e60e-4148-513a-08df0859a4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zWOXiaDjeRQM6qqEK2qlD1afL59wXpBRAkcrzJtSScp+eL7QirWtnwbeFd7k4XnFOdW+6RsK+Tf2KxGf7B1lP1+fIeCz9tem17zqWF07BVkDhg8Vob/KhIUontRd9SccYfiZYgEp4g1pBODAh4x6subyvmgQgDH6KmNYZSAaez8xfPb9iHJCdGCMiOf4pyVARfa6rBLOioZdAh6GuggjPApQ94RE0Sc9RTpkrt/0VSeYusVoSxOt7y0NjCoy+2k1vkomhAfMMx+NVGqadMBWmKy1GVfZhn6JPe0KMr4sk4BNf5Gs9KTrB+wgVyoOu4TA+wj1piSMPr6XMsGy3apjLQHVtfDEg8CjQv5ijgJQmaSmPf+0o1Ubi5pUneq+aBAk2edj/LZpgQ4UpmO1Uw9LDsdYikQ251NoEy0bbCcU0m3SHbtZC1A7hLj7OfbGNMZyWV4ke9hx46OBZci08CaOBN30L8Ns8XcIhpGMwwpKb+kt5Oa7bnSMckWb0GzUiynXFS6Nk337QQ/29IR+AUeLuPovmgETeN0LIQ5iOlCLYJ9wXiV2ZhMyokk7nxAJ9CyglrJ348dQTgdj4qgUzfBYkwRItAVa2paMUGPTpzPuHPPkjJLI3tfSFsJ3nBnSlVvEB4bXtK2zy3BlbAMjQ7RikNgchLwnW9d610WJvG3aZhxXUkOAAVyQsxmbmZ6aYvjMxJLA6AC6nuM9aGkpv+HMVA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VJ7O+HX098TI4phrt08L/oFXzpkMixN00nPpU7lynMTv4E6rZuGG9dCqlzrGOE3cUUt/LvSNZBcUTl9gmK5pcQ+uXap7Fmq3xCCSrdeTzj6Z0XhGoTYonGiZEXv4PVhhB1nj95xcDwXLwICp//WgZWMsayT+EcvfxA1/WlQ98fykMV3dCsOgyfEP+Cs5eeqn+r8zX3nOfSEOAGS5RLEi5GuXOulWiasBHSHW53a+z/skciKHaR5XrcIqm35vI94ig2BVY8Jtr5yNh/ftwZXWDxNrxGLB9JCfftUigaGKp6vcdCXTcGli6qty9h+QKlakxKIP5dDvxtreCkv/tdG0UhxHqZJK04AbISWwdrRqszV1fKgTSCFIpnXxBPHYtlb9HC4Ha0og0sfPH+Yk0/v3HBOIvlkR7GKIpUFKF4FfK7Vm2e1dBbkf+orS47Hbh/7u
X-Exchange-RoutingPolicyChecked: tHuJAr/SFw5Ztod7BBrHkjqWPpSjHFEBEduqDCKxXIEpSwrX5miqsfaxhtCvAJ07KqAthQKoOS/kOWYmdZibTbrkVnPQb8W9Diu0CcQaIje16cP8qJUvsoVZpTCPDTRMDlgcA+i0RtAlK6uhNzFvAkF9SqVrhaEbaGMNc1gIiZNW27VhzDRt0ljYImasjBXLylwDUmAw3PJgJ4EELVDhJLOGdlNMKQVIKOP+midAo0bupP9jydPYugIE1FVRDDLr8LcYBf4RqKkpr07lu8B8MCqC5jU1U+B1op19zRhC9jz8vk+ssJtcZjwJ8nXVgFtzatOjtwwl9a7CuXkGVTUwSA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:48:42.1259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc9340b-e60e-4148-513a-08df0859a4ed
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
X-Proofpoint-GUID: 7niFrBKe09gjGFdk6AC8sRA-TIi3HnnC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE2NSBTYWx0ZWRfX/ZVpFDrSHVSJ
 Lx3xdHHXmZs863bJLujpYRqxOEWa2/fYdwqIn9nEkopDHrEshN0Hm0Qy86qpU2xPqms7Tha5Y1Z
 p+oFO0msfwkGozPm3miUme2Ca9q6bhJZF7Ca7hXXdVWKslIS43xEiBnYPmRmgbDvMTZv37mclgJ
 xYN6er8PeVdz8GQDsv7EqUBMOUjCuqbOZREA6wu1fTHQDhgsqMA3DzKNLNyaI0PO5tJNdRCrOQe
 rRN38URTatSl0l3ViCmP5WpM1zIawiW+K77yxSlcJ3cSrRJ8J0a1prWkFnwawKtmLpvblujF4Kj
 Qsdn88CD4ZVGAvLXOFBIiLTDJ4demv6jv3KsKXfrZLvJiduecHREjP9DKdcZoTg7/B9SC2IYQ3p
 JvvHwj+mshnsHl3k+etwP8f5KV/cIKM2g2lkBDHTklfThP6ju+yCMitLvq3S42kVc17oIBEgTt0
 k/otPvmzo6r3QPs3ogA==
X-Proofpoint-ORIG-GUID: 7niFrBKe09gjGFdk6AC8sRA-TIi3HnnC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE2NSBTYWx0ZWRfXwYKvRLDjZG7V
 +vJNHYS6iT3y8XghSaIH5d4CFSQC/aiw581ArdIXwgvj43xVF818Tppg7p1EzmRWGWKDSpSCEwz
 ZoMtJWYHyGme1c3lL9ITp2dNVb1p/58=
X-Authority-Analysis: v=2.4 cv=QuVuG1yd c=1 sm=1 tr=0 ts=6a971e12 cx=c_pps
 a=iBoLJ+TzW6OYwHE2Vh/RVw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=pGLkceISAAAA:8
 a=sozttTNsAAAA:8 a=gfP1nKcL_8yzX_w0lbEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010165
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

On August 13, 2026 thus sayeth Patryk Biel:
> J721E/J7200 decodes the ROM-selected boot media in j721e_init.c,
> which is built only for xPL. This keeps spl_boot_device() working, but
> leaves U-Boot proper without the get_boot_device() implementation
> declared by the common K3 hardware header. Board code that uses the
> helper to select the environment or boot targets therefore cannot link.
> 
> Move the existing primary and backup boot-media decoding into a new
> boot.c and build it unconditionally for J721E and J7200. Keep
> spl_boot_device() as a wrapper around get_boot_device(), preserving the
> existing xPL result while making the same decode available outside xPL.
> 
> Tested on: J7200X-PM2-SOM rev E8
> 
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---
> This follows the existing J721S2 layout and only moves the existing
> J721E/J7200 boot-media decoding out of the xPL-only init file.
> ---
>  arch/arm/mach-k3/j7200/Makefile     |  1 +
>  arch/arm/mach-k3/j721e/Makefile     |  1 +
>  arch/arm/mach-k3/j721e/boot.c       | 76 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-k3/j721e/j721e_init.c | 69 +--------------------------------
>  4 files changed, 79 insertions(+), 68 deletions(-)


Thanks Patryk.

Looks like we have a few SoCs like this left. I'll send a patch to 
convert those in a few days :)

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
