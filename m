Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C3606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xn+5hNmN;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YiRlESgp;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=V749VU38
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4528F607BA;
	Tue, 24 Nov 2026 04:56:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tRbNMjINFRbn; Tue, 24 Nov 2026 04:56:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7876060689
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795496201;
	b=IWRLa7YT/3antOzskuP+1YSg/sN4LuxNYvACtOWGoKInZPK7oPHuQSA5OLoAhVrTTX2k
	 O26+9Q3wHjvXNFjlLUBDb81rea1729HNHmPXk+9/VFY+f0qpJaYI+tVw0v/hVXm4U510O
	 3ptzktm/Cn9NvbfxvgNAiKN3xcpcrZVcfCADJyMUBgop6PaYjX2DcgtcJu5TnV6w2Bfwr
	 s8XeoE5FELUmtBEvoZzMQRQBt1B3tUIjLxCd2+tj6Eh1eOqriUat/cwX+BOzHMk/OohaX
	 o0PNBfGdG8TfCQmspRdPxn0IzgBizXnbfSvsBPO9kBnPgGUrh1b/bK0V+oVjWTh0gDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795496201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xkb5dgrs0unsEgIKqsHmvgW/UNpLV7enYXkOrJWjoKs=;
	b=CmOttNZ/N+y8lObuZfHAWmJbxph9voSGX/AoHWuC3stCdvilr0ltW9jTLuSvlMuLaTRR
	 cUUIa24D1k8BJl56ErK+ECiEqOfanjFT8WpldAzGLSqZLQ+OtNtxHRf2I2BQdLEtbXOHG
	 Vl4TBzk4V+SZr+4UpZ7BCBbnn+Lg4tyJCqQQJelc2MG66ns6OceE0+TGROuryInAFPI0W
	 JVYQfrwQlqP5Ns8VDZKydtxB69CqB31bXrxeLTO2hO8vNn9sSkzLLteIlsHItDwvL3yzy
	 k7NeJMYQOWoG52OSIl8VyL18YrvNDLn4bIF9fKNfIx/+lWDSAKzhD3/XDTeuKxSbe1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795496201;
	bh=xkb5dgrs0unsEgIKqsHmvgW/UNpLV7enYXkOrJWjoKs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xn+5hNmNeBl1UYNVe1vDjCj5Zv6qZ951dZ9QZeiDUR8W0LiYkNbtdpNAFABOoxGQX
	 brQ6e4BJuoAAd9KAr4w0wyDf4ft1mppkKLTOzozQvfLUwj+93Oz2r31nM7uu/2X5so
	 Osl2H+v0Ygn9kClrT9z6DxHyo5H8RzhNNefnm/8kJo/LEJTqrjLoSp725kaoT1v+sT
	 T9EOn+YXHlPZmcOGPXjUVOYrtE7aUaESVMk03+Smr08EX7ywckOiHkKEC3i7xOxiL5
	 c3GWv+LBsIOLPHI/+OV/kzWJJOpdPuxFPpUVRh8zSA93LPnX73WOzcluXCVIAgPS/9
	 ekLGvF+LLo9Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7876060689;
	Tue, 24 Nov 2026 04:56:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28606D43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 04:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D79640654
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 04:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Y5oWuNJhjoF for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 04:56:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5BB7C40653
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YiRlESgp; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=V749VU38
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BB7C40653
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 04:56:37 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k6hM1087264;
 Mon, 23 Nov 2026 22:56:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xkb5dgrs0unsEgIKqsHmvgW/UNpLV7enYXkOrJWjo
 Ks=; b=YiRlESgp8PqX+dnQNtBwg1rqrnZFIOAijBpMdNNm5t6+ekMQ6Zd3Qn7Mx
 vaxkHNJntHYyCw58Cb0mTTX6vIbNqDRUQqpQgqwpI58rLE+P9UF555zk/AODj9Oy
 c/x11rUsZpSpzvg1Qn/gSj9PkOouH1qLJp6RqN3GG0Zg0+bVMEY98VoEs6umZn8N
 0/LRN58pFRbBzzpktR78azPTr9GP2L+PbjcRWHiylbSEcWnJNna+eE6rKLsjmUZH
 KTqVueg84FAn7MUtH8bjrENgStEMxzbg6WOmYpx0xRjPR81irJx/MnfdXYlja/11
 80vK7ryBbYeQogma5doGRSe5jKfmw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
 by m0380145.ppops.net (PPS) with ESMTPS id 4j4wx5stnh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 22:56:34 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkb5dgrs0unsEgIKqsHmvgW/UNpLV7enYXkOrJWjoKs=;
 b=V749VU38pUlAS2ECYXf7dhXvK4zg1PEklPSAAimV9d+GLoAUlVk/g1Gl85Nr3coExzVROwjtoDZOT1M2+ker8NJ1ArM0wD+Kn+DihxNL+Z9Wbxt7OJhIwBnIinemvfU3LWPjZMCucu+Tq2I4eNRHklU/GhYSpTQwfM92f9s0k/U=
Received: from CY3P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:fb::7) by
 PH8PR10MB6504.namprd10.prod.outlook.com (2603:10b6:510:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 04:56:32 +0000
Received: from CY5PEPF00000E79.namprd02.prod.outlook.com
 (2603:10b6:930:fb:cafe::af) by CY3P220CA0011.outlook.office365.com
 (2603:10b6:930:fb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 24
 Nov 2026 04:56:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY5PEPF00000E79.mail.protection.outlook.com (10.167.247.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 24 Nov 2026 04:56:31 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 22:55:56 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 22:55:56 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 22:55:56 -0600
Received: from [172.24.21.188] (lt5cg60819vj.dhcp.ti.com [172.24.21.188])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AO4tqdi884226;
 Mon, 23 Nov 2026 22:55:53 -0600
Message-ID: <d366a2a5-d2d8-4981-80e5-d8efde854878@ti.com>
Date: Tue, 24 Nov 2026 10:25:51 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-j722s-r5: Move DMA access configuration
 to generic dtsi
To: Francesco Valla <francesco@valla.it>, Nishanth Menon <nm@ti.com>, "Robert
 Nelson" <robertcnelson@gmail.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Vaishnav Achath <vaishnav.a@ti.com>, "Jayesh
 Choudhary" <j-choudhary@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Anshul
 Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>, <u-kumar1@ti.com>
References: <20261124-am67a-j722s-unify-v1-0-19a83f16d38a@valla.it>
 <20261124-am67a-j722s-unify-v1-2-19a83f16d38a@valla.it>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261124-am67a-j722s-unify-v1-2-19a83f16d38a@valla.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E79:EE_|PH8PR10MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 205f4665-cbff-40cd-5e4d-08df49e74e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261102123227099003|56012099006|10067099003|4143699003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 7UhAba0p++iJQbzNFspNwR/yZzh7i0HuinAZKvDegeH5qc3/WJngRS9YUfOiqbvT2XxHta2HPOJhTGEJxXKPzbnyS+Po2EaiSbJPybnEsb7c+sd+NAMHizQz+YF0Ql74Z8a9ifx+fz+A6xzPiCxt8x4ZjCsgAOxN6E6wES8vAGv2uM9PEVINVaIpRWM3Nexd0XVuDw1zEixNm+Mw+x1MtGt+7Bj6YVD4P3CTUe4upNlKg4svShUn7tz4rmJ1+Qx/Hl7CVOyfNfwBsA8HQlSs65yMnOQS19b1bd++aXzC7QiaWz91n52xeTsNFMXXToJIp0iV7tqht4QNtGZAmmYwFy826PyA6oy4CgsQv0EJY1e6kmlwXnXbOUbiZkFYIHKuzOA0L55K1ytdVooS9If16fM6d6I2f8zZoibtYnjctvxGfNMQsbYZsCZQQ86eIWF1jv/IEB7rL5MsMsgYBVXrizPmNNAjML4kTYp6TzUZ9e1FD1YzggdtslhAo7Kehe5tLXKz6LXQHArOzG/4KmfvNRwmthNDx/q8rd+Fx+D/W3BmDgOl8iscZ8JUspB4FBicpp8nOa1CXnQ5aDmzeUkJNAgV1UJ9CXUhN/VU0gHmwZBH4Tr70XDHGeyzYiAiD2LYnYQSmePiFULyMjlZqIf2nE85aWAmjiv+JaaHWmxRBQ2TyPC/02/NzTdMUf7c8zZGIVyrjXzyYEpNuv3G7eu35w==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261102123227099003)(56012099006)(10067099003)(4143699003)(261009223027099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qJAzIxH+gHMZoEHjZz3DsEtvHjRcTCSYHl9rBusHUTFIJ85BICRIeAFxz3Pn6mI9YXeH88/zOT8fqlqu8v2xbQHRcFKsrA1cvW9EcanOZuX8gxJu8HWMt4+fHlAdhu+3YAf4y7Aamc8hQGFAV0BgkpblW1uRsEjX2FNBUgmu5mIEebPiOzZsuCdoVfcBgw9OGDRZvoLGQ4FZUUJ4gODAYzOJxXiaS34e1LUiXejD94yyQ61qW5TbEbaswOAbWaYuQkbo94VRuWunXaQocUIsJBdCl1lLSusdvBnSpZaIjdKd5WF8oJVNg3LLsDd4iUDuBg43eGqIVrIAR2Nk61iAl6QSNL729RtINRYoXrTWM6oOALRNVco6eXSxbr/qXxbCFzShHYHD1ScuqDE9N0kD1A2fDaV3csUqRVcvrcSyQnsapYrN9Fk5H6GNn91dOUtR
X-Exchange-RoutingPolicyChecked: TyKQ99y8xjo8pDXDMOlVRSw8z6oRsp5iPwLPAhLVzQeIN2bkScE2lJoeMrf+a3BRvxMGvjaDt7WqYDn4sN8jS82dax0hPNn4DxJYWXvML8mFcnPbPoi1akSV5Baw9IsAf7/XTRwHwxfY711mavVxSFasAgP4hwT1n21nR27WgfkzwncCsm8jp+E9fCKsuffoLCy2UJ642UJTPcM1tsaHSaXuRfjjNyfjd3W8qOUxMIBlRCLXhIHoInXp+a97rYW7JKTVPpEoxeJkVDVSoxIlwV9dYzzlkAQu1YCaPAs3Auf+nd0w4ElCzqFlscDCnXirYe+X5VkmiRU9vcYRacY9XQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 04:56:31.0377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205f4665-cbff-40cd-5e4d-08df49e74e61
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E79.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6504
X-Proofpoint-GUID: rIhptYecne2PHehW32nBDLYiIL5seAD1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxOSBTYWx0ZWRfX3KiaBsihFxxB
 yCOOCWzUKuhlzNfxRPoSkSlY8+XwMFrgTVKaMt/nhbdy0VusxGHk122tZP+NKfSgY2MSDZFju1a
 CYltn0TyPDPADGXm3MUTA2cj4TKsloc=
X-Authority-Analysis: v=2.4 cv=Ht3jiETS c=1 sm=1 tr=0 ts=6b051902 cx=c_pps
 a=N6jWaT6qAb3kxWP2Z7atcw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=i0Pfx58KtHBuGekza6QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rIhptYecne2PHehW32nBDLYiIL5seAD1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxOSBTYWx0ZWRfXygL8jr0i0++c
 EuhTWMxGRiNo6fsX3QJf32SrXAA8ym+ZO0sND2N2v2htgNHJP6CU73twwDc9SJ3Vn1kifhca4uA
 ua0gjAWL5oYsLW3U4YfdQXbsmQ7XYubdVDDuOrthf+bGfwfNx1u//Hi9vbLIKRiBOJHTNECKyJ6
 +1HJKZPG1b9Rpe3PbYh9rVE1jIi2HiE6bnKFtnQvAvO80sGNV1Buuq46UrkGw0+Yb4vbWgBkhhl
 cIYTjvQFlsu+Mm1miabMiORveWmC2RZb37owsY9joQc8RKAwfoprHzue5A3BUPB5ftd3wmmfGIh
 IEUllG5m+lBNsgJDalDeIYyK2IrvDrpSWRGevvdXn3mniFNPVithcwf84PNiNsXdDetXO1S3pje
 oLxitTCKUab1XA6xgl/2ltBfjdd6ir54a8eA/uM0Pvhabek+n30V12qI6LTIIUFUx2Bvb0TDkNQ
 kXcNYJgxOW7jx7KmBCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240019
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/2026 5:14 AM, Francesco Valla wrote:
> In R5 SPL, the UDMA ring and channel configuration requests must
> always go through the DM2TIFS channel (dm_tifs) rather than the default
> dmsc node; this is not board-dependent, but applies at SoC level.
> 
> Move the configuration from the EVM dts to the generic dtsi; in this
> way, the BeagleY-AI (the only other user of the dtsi) can benefit as
> well.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>

Thanks for avoiding duplication of code in board specific files.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> ---
>  arch/arm/dts/k3-j722s-r5-evm.dts | 8 --------
>  arch/arm/dts/k3-j722s-r5.dtsi    | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
> index e1ef5d181ed7..62c44d33e186 100644
> --- a/arch/arm/dts/k3-j722s-r5-evm.dts
> +++ b/arch/arm/dts/k3-j722s-r5-evm.dts
> @@ -15,11 +15,3 @@
>  &wkup_uart0 {
>  	status = "okay";
>  };
> -
> -&main_bcdma {
> -	ti,sci = <&dm_tifs>;
> -};
> -
> -&main_pktdma {
> -	ti,sci = <&dm_tifs>;
> -};
> diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
> index 9ddb951e078c..cc1efa5e20c1 100644
> --- a/arch/arm/dts/k3-j722s-r5.dtsi
> +++ b/arch/arm/dts/k3-j722s-r5.dtsi
> @@ -76,6 +76,14 @@
>  	};
>  };
>  
> +&main_bcdma {
> +	ti,sci = <&dm_tifs>;
> +};
> +
> +&main_pktdma {
> +	ti,sci = <&dm_tifs>;
> +};
> +
>  &main_timer0 {
>  	/delete-property/ clocks;
>  	/delete-property/ clocks-names;
> 

