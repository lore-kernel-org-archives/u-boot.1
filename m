Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E36606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Rzi6+Y/b;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XH76m7eL;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=DvOwn6Ae
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A5454057E;
	Tue, 27 Oct 2026 07:05:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uiQF0rvwnpHi; Tue, 27 Oct 2026 07:05:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A977404C8
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793084703;
	b=VVHtg296WOb2sEcu2y0NMg6SAkaz98OOIMEtiK5hmazPfjZxwzgXLWRmPN/71UOYnPjp
	 POYGYAv69/3wACYeBMjtJGRn6eHNpPfOLAl3bd3Sy76US8KiKeztUeFuPZgXRk9pYSlkv
	 Vl2fSGvs5HBt6vaD6b6ix0XDp96y8Zjv79llhnkElTPE4d16jkxNzY/dz+ZrBEteR2BoH
	 PEjLHgMS1sr/X3yhPSMEeIZzctn65FcETevHMgDFQXkDe8D+AQ/ABZ4wJU3ApHD8SXwli
	 KMBDI4iGP7RCzZJwl2E04pK0cSn/GwV9BR0e3/q5JSuRcH6kFx0L06/NKXiY5ydkbFw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793084703;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yR5JMEmJNOqHH1Ne/ZvPH6raiqBup1FQvCRxVOKCI18=;
	b=QjP5sRPmBSjoiiGtI3ktSC/UwU4I3JaTQBzezNRZjnjEa4SFJYzlYI7cTY98sQJtM9A1
	 NDzs3TJW2BA/U44Zwk0pLz24bg30t2tMzCDNSajq7XuZkZeFKZyxcycidOg8bMhEF+baz
	 JP9UC4tAsc3vb7x5cYDDrh9yrv45vE9FUbaG4ixEC2KGZeakgVBhOBfGBEEevYqUHNQVY
	 43dUdkLIzHNw42chY+92eE3MMvGb02Ajpuw4QvvgmuaJ33y9O38MoTaGR+XWDe0sXDRoM
	 iADgGsSPJ7TfF+GQe0q/HiH026rnrRBK+5jYsGR/zVFN3JZ8MZf8t04QcJSecudhuHw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793084703;
	bh=yR5JMEmJNOqHH1Ne/ZvPH6raiqBup1FQvCRxVOKCI18=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rzi6+Y/bX07aOyqFuickuDIeveq2zk/T0Q+dlVH5Nc9uc/Gwuz/ZK77ThxUS1wYzA
	 P7X1tTLJ8+/51s/Q5ShXyJtjNvgkam3DNijD+3LefD8VWwrJbFeY76CVkp04VIetWa
	 /RPyZHmP4WPjSw5HQKf+hVFrrQbjHdHTUHpPjciqrJ5nqHVOXbCOgBpa5KQRWeFQw3
	 T2nDuCeDjcbINanzuCDr1nGiAt1QA/oGsecNOMA+4kC8of4cciWRm63eyRfHplnyfz
	 CWP39V2u1UK4mmUvwG/o0LPDdTToi81bgLe1HqLjJCAun0cPrZ0WlZavw0RM5R0ZoV
	 ZrlzMsLcknejA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A977404C8;
	Tue, 27 Oct 2026 07:05:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 785D2356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DD71606A0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:05:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cBDfGGU4Wm0Q for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:05:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F3B8605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793084701;
 b=hmgjwTpoFG1iAYyHslbP00rD/I29Xm0tAhxiD5/1N1AGzpzgF2aTJmNbvADewIlvKG8I
 ZWJKuL3Dbi9td1K1v5v+sIcKt1xilU46ABlM0Yk6FJjVBkUrPch9RnQUKj5cAia/0WLXk
 iahcKOZgTTr6Ba93GoPbdu2iadt3sweGMLZ3GO6I3uku3H50hQSOCVcfu1zLGcyn4m136
 MH2dXwcLynhabhGkCWhdWsfFNeNA/x6OTqMreMMyJ6n6HbRsQt51tggOEAkqufGS3dt5+
 71TuvepyD4/lmFdCEx+9r9OUOOxUro0zTK92kinttTXOu/JYhE5hhK31KuxSZFC4zGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793084701;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yR5JMEmJNOqHH1Ne/ZvPH6raiqBup1FQvCRxVOKCI18=;
 b=pPTeQabApmr8LmQMe4w5+fCmbmO5YdMSltsh4aBsq4NRGgr5uS48RC+IPz0KjJ2LBNoU
 H2U+zru4tl5AzD2wtF8AnWyRdgSY0JyqfAsES+OzMoJ4nkkXfWJ+GQUaxMafOQxQMXVvU
 /VOEosVMwX2evuq42xo1wb6I5klgqmsXZKvCoJsKtlK1CW6pkqJmM1kWdXrctchHYKcVC
 X3+2h9tZJNFniVvNf7lGFN5Qx9uk7UjESGCfeMOLuByLkmSxE3ijYPxLa/4OOMg/PZOZ3
 8MhlOBgMnYYgDHe6mOGTLIYgEDSuransGHipKNfw88i7BuW1boj4HPdh3PLl152OZxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=XH76m7eL; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=DvOwn6Ae; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-jain1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XH76m7eL; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=DvOwn6Ae
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F3B8605EF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:04:59 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5Y3Kf4055718; Tue, 27 Oct 2026 02:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=yR5JMEmJNOqHH1Ne/ZvPH6raiqBup1FQvCRxVOKCI
 18=; b=XH76m7eLllPwidE6x/SgFLQWz66uRm4ecZluNLINdwiM9yclyaVkeGcBE
 ttO+Y95H9MUI/6emzEmkeWpChbcBbjaUWuXWS+oy7CZyF0kxCr1xrlc7Fj/UeUzJ
 nk48xsbOFnXrwMnnChsXhe9QxddakkDEPyFtxFXXp6tbNjIhWQNM0vynSXGzYBR6
 khQHaeXtzIdN2cN1B3ioaFRXmK4iKhJdbDlb4eNJVZsuWuhnmPTUOumC4DAOZ6f3
 PdeZyZgbyNTP6eOj7fyPnJYGwgXKudtmL+9UlXhzKDh4QH2IVU/eEiaQlwKXdJsV
 Y3lFETtwAXlkq3RFNWKFQd2b18XfQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hj9sgvsfc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 02:04:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8fOYqchLNHRMHsXuraJREDpb429FwpXOA1rnLYFe2C1VpnMFhcVCeMurRpHwQMBCRhJCf5kvJuT+EsJEhmXlgJmpxoiJa8P5BVqKW2+NOuTYfoI+5K8g28OcopSRonJJ3syRrV37z3/AXsSEPVDWjDATF5Szd7vJrl1d0otmxoMdy7iJV577JmslwlcwsQX73viIJjVn10hDXZc3gql2pWYtXwS1d1hpieKfaIA3SDTsSM5d4jVqv+SEmO1JSVKwgtEHMZ3vXNSA4hg2hrgmJBHLaYC/8GLfDuoEhZrUAezXmhhxnpthyDixmDmAXrRIYwearBGNyzXTz0sxcelDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR5JMEmJNOqHH1Ne/ZvPH6raiqBup1FQvCRxVOKCI18=;
 b=efI6E+RpQUZuzBIll60ix8rG76W5yd8jd4r7GPdzB9h5WYyp+JNGKQaNzQB81JkNuvVVCOkFmROXjjSvEHtOTN+LZymLGXx/l4RF8DBmawUNpc1RkMh1OoEpOZGFOWu5NDi18uMtUdMnqbbklRzTPbhmZ1ax8rC4L9fde0yYuHxE3EgPAg9bQIK2De9Ej7lRcobXslfiquRamglQDlWbYR3ccbOcQq2P5LY0NUwGCJZLu3OVRlMNI+k9PBiNYYcVB+oCSytnd2n4FxNGgxOeLC9NWaqUGCA4WNdBMfIwDfChSnhmuWSNa71MjNIYG0fyToRhGUO4HyCZBflBvV+SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR5JMEmJNOqHH1Ne/ZvPH6raiqBup1FQvCRxVOKCI18=;
 b=DvOwn6AeIiK3fgPgPIEGrZJL2sEVdE3zTLZ4jmnh9M8FmmKIXk0wwHu0Jpvu43l4ESdANbTb0OXm0FuADPrMgDPxZYfLQoqxY8qTzE6oPxDwe6Ny1TV7YBpKxcZRfZRJTZkOMJBtAnIj4KFH8nUvidzzdsX1AmNUG9+iaW0txvQ=
Received: from CH0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:610:cc::35)
 by SJ1PR10MB6002.namprd10.prod.outlook.com (2603:10b6:a03:45f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:04:55 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::41) by CH0PR03CA0090.outlook.office365.com
 (2603:10b6:610:cc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 07:04:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 07:04:54 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 02:04:53 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 02:04:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 02:04:53 -0500
Received: from [10.24.52.205] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69R74pnG2370452;
 Tue, 27 Oct 2026 02:04:52 -0500
Message-ID: <4d4a46e9-e75b-4bc2-a0c6-88a0bbc13b3b@ti.com>
Date: Tue, 27 Oct 2026 12:34:51 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Add i2c ignore NAK support
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
 <CAFLszTg_ob1mTz9=Nh0BHM-yZDDoyYTu4STzHgk5tWALyZ5yZw@mail.gmail.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <CAFLszTg_ob1mTz9=Nh0BHM-yZDDoyYTu4STzHgk5tWALyZ5yZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SJ1PR10MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 380ca74c-e5d4-4d72-8261-08df33f89a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|261026121527099003|18002099003|56012099006|4143699003|261022105027099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: Whl+LseFsfRMZt1cixYz/b/r4DGbfmqLsJ9a6h6IymoCk9Is8qn8GVFSuChmGqq71upSA3In15MCr+SglV7I6J5q2+UCX0A1j22CFE2XUvXN1cvVhobGjVmI2lQnXKVa2rF8tpHry0xdsPuVzIrx9ZFPRI4eWfzFC3txA0mAIKY24mj3Qk+l8SsKbrmlZDDCETund/0i+I9/Ys1ZTqZTOWiyKNFqm2/j9ceuJmSeLtYr9KAukPoYjHKuHYKmu6dJ6XjmX58LASlWcOgROPrNYCYYPHBnqKz87J5SMmYL18NGaN2FoCKt6gIRggyWs61YEispVm7MUey1jw4/La/RcxFWqvzXgeC+xHa1OyU7y3LF5ufHJGa49XLWTbNLzZIIwAJq4UwbSh9FZJ/MTTl3nXKKdxu1ZqwiOHYCIRqZN49RqtgV+ScbGNRs1cvX5oMTgDjvykPtSW/ygb2q/TDdj2P9Ys4jv7UPPtIs9qlIa0sB+cYKoM6HXQMfiyd3TGtuZgOKv7VQAlj1Wg27XfhXfVmQJHaCbYWLYCiu5jHeT2xu4ouN0zsKE/rNsThm9c+xpJv4aE+SsiC1xJaM8/yDDQd2xl3GiwvsqcbeNs1nskZ0nQ5K+MRdVYRAhnbIVlRE1QFGj1oY9qPG8StvQUtFVofYPhJXFZ2Brsll56WG+zzRyn2yWPKElQfoZM9o/3KyvtWVhtiANRZGtQ30OBCAzg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(261026121527099003)(18002099003)(56012099006)(4143699003)(261022105027099003)(10067099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NJ8lW0Ox+vWzuLU8W/Azw1PRXoaJNMSU7QDFxuYK7s7MD/LlKv6+sdMmyQnz6f+s3hHgD/hqrrqGHUQHCRsHyBlTc8yvX/ukN1yTdNfj+gZ5LJKp7BrxF9D5BwZg+Vzsg+cQSsPSMiRh0JV+BWPs7HdZtLYeEdkuHyzbVg/Xvv8M8nTChB170/g5BkqHODvzD9H5Jvll67Imuze+OYe+jteJ5JrmDxw9ovD/2rvJS5tua51WQ1C7Lgp1NW1cAhHdExsO3b4n6Gn/gMAY7+uTeVNI3ftglWhZNvYv2H0KXu4gHTGQrZHZLrCX5Am8pvICMeS1naa9zzM+BGJB//iblLscwhbtAgOm0BJt/X3R/uEbmbU5o4TwxNRAM7pQOQEteA7/MD9FPoJgc8hYj3vx4TQpnAxvvLDy3+yR3xQFCzuXxFw8lXOtgIDpzhBh7KIj
X-Exchange-RoutingPolicyChecked: A2AHLSf+wdr7gkl6yo2WrV0j0/NWKtUASMODN1QaWbv1cyFw6T7TqCgLpLOl7sKyCGOCeHQXcLkkffcO/d+9lYp9dg0sD1TiL4Wionr/cT2ze88M39oYwmuVZU0Xe6np/B1S/hNTE3ed0DFI8XmfrGWZn4h3BX0QDpn6VcZyd6Qe53niyWsJXc8LQAiqzvPwoizuoBGHXosbaj/qa1qSr0q1gC2HUI6rxFhTUEz28a5MMq2ajmLM6n2jlGrFbhybVT5z+Y3CG3ixnAGArfPdY40vQLQ8KKmwFjjbnGxjaMcwJU6HxmqdXW8WkkrPdOrRdJcNHOM0EFnyiXJLI2Q66Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:04:54.7584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380ca74c-e5d4-4d72-8261-08df33f89a9d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6002
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyNyBTYWx0ZWRfX9UqNwV/NMzlx
 XqSMJWm2z1AkQ8Uk5fmTMoFr+BGYBgEB+IgPAleSKaDGtnCDT918+cl6x6WpnGYlNZYMw64urBL
 YkLYLbAt5cYIBGRlhWSRoeZtCtExBys=
X-Proofpoint-ORIG-GUID: VPlI4qROaevUDVi8LWEk1t0wz5wpH9qq
X-Authority-Analysis: v=2.4 cv=O5GsLx9W c=1 sm=1 tr=0 ts=6ae04d19 cx=c_pps
 a=S19i2aQNi83ZBCZ28RB3Sw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=qurpHT5N9leOnAwc7IYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VPlI4qROaevUDVi8LWEk1t0wz5wpH9qq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyNyBTYWx0ZWRfXxgJcedCs640M
 /XXKVF+TvIo7AGWd6VYHfQt6njxvwCTm6C1G5ko5TBro4NvKAm+aEUdk77YQCrwf0AnAAgeYrjj
 LSJaRshclQ3+A/ql7NKUjHnl/6TDgBNUSgZHQGQr5Yh+Ktn/dTOWZ0l8VEddrpUUnXHTuU2lk7t
 WVjZgvRSNjforqSm4S73G8k2mP9OkxOcDKTtjQmb82DBAdvOuWddhiLHAnJJIt2bTXPLa4HNh6m
 0GCkjZG8GF+UZpeNMfBgXc71dsRMOVmUyZgd18B1VjWittddn4ktNa+G06ogrTLtEO/zMUQQwsa
 GW9RfZApJri5LodoKDyWRCVI9ZxNrvbYRseNmXjrZS8H/+HAMTMoDJNcxJMuUhdvVCumGsGSIha
 rqNYvroc9AVU4Tr/PGGVzSuypEqp2gV2KKQmB4LlbO7KRtD7h/1lNYbo1KxHEU5uadEUWEzRTcr
 hgtd78XYRsS1iQuVUFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270027
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On 10/26/26 21:40, Simon Glass wrote:
> Hi Swamil,
> 
> On 2026-10-26T07:16:33, Swamil Jain <s-jain1@ti.com> wrote:
> 
>> Some i2c peripherals do not require or wait for i2c ACK, so the series
>> adds a flag(DM_I2C_CHIP_IGNORE_NAK) to ignore negative acknowledgment
>> (NAK).
> 
>>
>> Our usecase is SII9022A[1] hdmi-bridge, while reading the EDID block
>> the bridge doesn't send ACK (mentioned in programmer's guide[2], pg 22).
> 
> Thanks for looking at this. Are you plannning to send a SII9022A driver?

Working on the sii9022a driver.

> 
> I've commented on the design on patch 1. It would also be worth
> checking how Linux handles this for sii902x, since that driver reads
> EDID through the bridge too.
> 

Tried following the programmer's guide but will check how linux handles
the EDID read for sii902x.

> If the generic flag does stay, please can you add a sandbox test in
> test/dm/i2c.c, like the existing tests for the DM_I2C_CHIP_RD_ADDRESS
> and DM_I2C_CHIP_WR_ADDRESS flags.

As per your feedback on the patches will try not to use the generic flag 
and handle the case within the driver itself. Will re-spin the series
with sii902x driver as well.

Regards,
Swamil.
> 
> Regards,
> Simon

