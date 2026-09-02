Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED658C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFB8840835;
	Wed,  2 Sep 2026 13:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nyqPsUJoAHI1; Wed,  2 Sep 2026 13:45:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356737;
	bh=x0IwqNEY2dJlgqyZKyCwZ+td3Q+VmVXZohwj7RIw+Ds=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1G6Fis7aaDImFzi0oFs5sSbBKDrZmXsIhp2kqH3m1IyqXS0/L9ABW5KxyWGT32acX
	 91EyqVShf9rYZaS46iefMmh9XK92PjtbdcFInjjBIlGXRyd0+vxA3DWOvK9+VPJv7C
	 iUFDq01KA+RLft/ritgeLjhVEb0Y9DXJEGBwbeAEryP5//PuTHH1aNdnlIpZJhzu2Y
	 8hTZO2OyfZuHSkNosJVCuHXkd6Lf2JBar+XSNdTxbPgGSJoZ+N2CQfoLjs2lwJd1H7
	 0eA0SeSvJv4EIQ+le8C/MIC8hTk5HAXkTtVDTQj6LpZvV3itgKn6mDnb+aRRg0J8Fe
	 WJnrGRzh6lR+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C48FA40836;
	Wed,  2 Sep 2026 13:45:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DAFE31D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCC58400A6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iyvpoippLTTi for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:45:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=CTdNYId+; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=PG+4o3+q
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA5CC4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:45:33 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 682CV4EG974154;
 Wed, 2 Sep 2026 08:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=x0IwqNEY2dJlgqyZKyCwZ+td3Q+VmVXZohwj7RIw+
 Ds=; b=CTdNYId+R6JCkJPPDLu1DLClvOd37nbXHvBekv9Un73LwMTryfERM/3Us
 69+OCXHW0Uf+CSLfc0Z9sxNj4pW488FywaEFNpWpO5lSTgBw0UxvYs9Tvzg7t7ca
 M2sZMUkLbvpkdA4Ck51BOOmRzLAVGDBvnAAfrahcshpEzcU83X2aObe2nXSVkcRd
 Izg7zPTnftHNm/Z+y3e84eiqsUveG5N/Q467ctokX5P9rAvfJ1tmdxzqFMZne7bh
 A82kj2H9qtdAbgkBHZYfjtYrP5ZuyVTdorJYdWc82/vGwpT+OKaqX6/hTeubf0Iz
 nYW/4LWioCS5ymenbgXX9F6cgxdWw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ge7cgcdvn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 08:45:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZYBVDMpJuvBLfuc/UYS2g0lyYrT9ip4HuSLPwbPFzb2A1u+yfC1963q7MqnFZsWLT3jdY7l2h8R3ICXAlYvuDS0P5ek1ieHpSGdiek7HrjWtSn0TfEJ5u/Z0NdkTEmlv5G8AskX0lBGysXi5LLqh/AM78CxmJ/F0raZgSGU+8bPCb74R4pIPGcbz22TM62v3dTr952VU20i/ZgDmbnGMEWWme0+XJ/ypHoHxCmvCRlVeh1SlbQ1fRyUOr5luJseTzcRL5I9Md//9XFqZvZvtNuEcz76NMK3XHe9jFV9pFtobsDOrteOqMEQQ/FIqwdaq97D12LYvc1lmIGMGvl10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0IwqNEY2dJlgqyZKyCwZ+td3Q+VmVXZohwj7RIw+Ds=;
 b=DKsjXrqACqG19v3CK/ieosReyRdhMmWvvIqKSCU9oD6Wqs89M9I9zsoJ9gj955LNR3FhI+aHQEeoEWEuoCPxI37MLlqcukr+M7VEO+MdO7bhl+LM3Ux1u5pUc+8sa2bHAKdRzmWet6rYps9Lw4LYOMkbxqv46HMaqXNIhX7R12i28irjGJrJios0Yz27V8r4Nb6a1jCKtsd8baZ3u7jMtlgiNI7Ket5mAMV3KvqYC60bSaftOBpfxoRuPWTgBb6E+6j+B4bDXLyUoVetoaKWYEJLwdJLAHqADFUWjgUqOg9X9cPE338K265tTVanBfUNQx0fCK95AnON3rrBh0Mkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0IwqNEY2dJlgqyZKyCwZ+td3Q+VmVXZohwj7RIw+Ds=;
 b=PG+4o3+qu2zi8K8DXQGTQVQD/tfP/uwBzKjcWIx6idSFTW3h+YTI7mVeLLqL1VLf0V7ZXc6WQnAycAnNoOlyoB9NQjTj9cvTsMJoEByEwDmZ9mTEtVNSazpTfReXbHK/kMEac7qqpaslyrJa0MU4rQYExXuIK7Gi4jMZvhxxhFQ=
Received: from PH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::14)
 by CH2PR10MB4311.namprd10.prod.outlook.com (2603:10b6:610:79::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 13:45:29 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:34b:cafe::29) by PH5P222CA0009.outlook.office365.com
 (2603:10b6:510:34b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:45:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Wed, 2 Sep 2026 13:45:29 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 08:45:04 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 08:45:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 2 Sep 2026 08:45:04 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 682Dj4Nj703224;
 Wed, 2 Sep 2026 08:45:04 -0500
Date: Wed, 2 Sep 2026 08:45:04 -0500
From: Bryan Brattlof <bb@ti.com>
To: Gokul Praveen <g-praveen@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <a-nandan@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v3 0/3] A-core no-SPL Boot Support
Message-ID: <20260902134504.wayifwb3liu3d7pl@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260819101910.39192-1-g-praveen@ti.com>
 <20260901162303.ccuk2gvcoogftjmy@bryanbrattlof.com>
 <a53e3b29-8025-4067-8233-385ec3295696@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a53e3b29-8025-4067-8233-385ec3295696@ti.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CH2PR10MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: b11474e5-d1ed-41ce-b81a-08df08f8737f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: cj+DN1nA9+XbvfOZIBHw80ucCm4GB0AvRXCiKdv+y24wKSJFZb/uWHkkPPengLCBXUzokRTAkSpN3yQANM0Kq9Nh4Xw5BVt4AWClDakhQWbObhAPkWUbMA3YcBTtDTyg1COpo+C0E9xYneT9is4U0Msmvv1Qu2jz6O8ZjE934OI4yuHsq00k5qjXN6XeaHxiD2XoJ/cw/pSJWnGy1WusmgGebZZoNuYyA9NWJ4B/gPZVIdaUDWCjnr6ingFo5Mp0oHDibJIXFrvqMj56h5wmqlJZ10bJGd6qPn/ghSDo36yOVN8fdIug6/2kNUVU4FxRXQeAqCmCdngmvI0bfz5uDjkcQdHzeKSeQR84RgLrmJijlQwKq6PWVH7FH3STwShAhTdCxVae2omiQfUgxrWjNC34e5MST+NPhE3MQVr1M42Bqsh6ym8mBnmcolO2Q5+aImw82vjhREQRTp9ltGATLlI4VbpEYxSOQvbgk1tm76N93sV0/1ajfrPrQedFSlFg5Z5SNqbrvxDxD3RQzhntR1TMyILPsYPx7feQR29d2qV4n4ekrp5B+3THaCW9KyBr8tDQOo+aUoMiSZW23fSd7l8qJGAyPvERSQ9EJUGsov/AFsmK+r6O3D6SOESNtjWhNmC3suXET85gKzEDgzTG/oqBjumtWPJcOezE7UhKDXkamdNotE19SXdgh5Qe5A4zz8r7IVXEDf0PYow6ChwrLw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PfCDLKtOFLfWc3FfF+84feTFEc8pcOBmO1A6q/WtM6LwDXFYjSAVI93mHdORbToSxFPKIPPvbdZJ/gyRkXJoCTVmkLtxHil/Olme7Lv4gbhVohLKJNC/XT/IifqaS3mt9NhLHl4M1AUG6yxmDdSLdEW6K1DKP+lchcs5qc25+DdnRPXCHu0yqwIR1fBeYbaPuXaWwSMNVsa3ZiOfm7/n3B2t3HHpxDcNijZ1gNOZcOvg5IHtemhy9OStYB51Lmfd8dIGK+gGIo70O72oy2FqaMoRzex5bA+AzIPWp2xtBXNf7jM+Yc1OoTP+8slicIq7OZmgJiUFShSP2AyeeeE8CnHadXeps5gM6JdT6Qf7AvnrjXGoEQ6X10nYmsf+mD4zq9cDvrHZ/hFCoR4zR0Ue0h1XuCgBbCrG2AA/2xTNUAZQ74qCokD+jcVrl0bMjOZe
X-Exchange-RoutingPolicyChecked: rgR+4sl+qoo4D/BOS2nF1obsBg4RocpLdR0WbTps9W3I1FU0ixj7D2/VHqmjb2NFtG559SyvP/dMwvObMB/s84G8b15PWmVl2GUeVFuCMd9MXZvGZwpQd5jT7qE8hwVsUKHZnZTU2fOblFri8dIkIHd/OR2O40A/ol/jJZxRZeK+KkazynSMD/FsVQsiK+jntTgFOOwiTc5T5N/QNE5xYqjX+vjmHe73B3g3bsFCuUespzIIv9nQdcPUp9R7EO9/gXMkiAXzq1AIqYjTAFq3IE3dmwP6MCfJayZ8B9QTojuablyfYhUtHB+orklhkv2AESvNzUevgXhlGnDYRn4F+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:45:29.1269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11474e5-d1ed-41ce-b81a-08df08f8737f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4311
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyMiBTYWx0ZWRfX20kottBB0x52
 VzwJ1QJDpE7AQfiIp9A6agk76yOJHJcI1oOA/Dg04BdhY2E5RX1cuChU4/4lYRh0Y/7yDov7vry
 zgYxRBFMF61DdycKp5RXGz+hx0m7kM4=
X-Authority-Analysis: v=2.4 cv=Ka3idwYD c=1 sm=1 tr=0 ts=6a98287c cx=c_pps
 a=E0F994Awt23I4DNeuEdoUA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=aJfKY83o_sdTyMZB2ZUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XRTFcxAw5IYTfmgwZGFB2TrHt5GveE1l
X-Proofpoint-GUID: XRTFcxAw5IYTfmgwZGFB2TrHt5GveE1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyMiBTYWx0ZWRfXxHxr8hVfkjAs
 9C7WOZXo5d9fhX5m6j/9e+riYEQYrnWeWWz9qdUcD0MaPT90nNywmPFBzRvyD05gNnJx52BDqi9
 j0QXssVhEGfuh63N0raVRlGHbdmHu4NHmV07R0oMmwVNRz0nxiZmcpFlkWVH8wXBv4EiLFcXT54
 SIP4sHpMuMXpSBm91ojyw9qkrs9XD7E9cf760Y1J5De+ulEIUFRU5phHnLAH+d9WkH/lRmqZ1XS
 MoMmkp0V2YaJ3j/hF+4l6XUuHf6O2XPS0nAGh74tiDU0CuXjdLc7DcDv3dL9NtVa69LUBIqQB78
 5VKGRwfoV3WLhoTENW9JYNCo63iROZrNajpjF8W6w7e6mmEb2nLiPVzB9TMzSHqKfGFtkxlbp1y
 T6SimVlnUWtSHzD/DdNoV8gl5AsnRcJFWJvE+bI4o8i3BId1sCGsGWjcR9camQ3oX3uOZJkvRUC
 BctrZoMV25cIxgNHWrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020122
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

On September  2, 2026 thus sayeth Gokul Praveen:
> Hi Bryan,
> 
> On 01/09/26 21:53, Bryan Brattlof wrote:
> > On August 19, 2026 thus sayeth Gokul Praveen:
> > > A-Core no-SPL Mode is a boot approach that bypasses
> > > the A Core SPL while retaining U-Boot in the boot flow.
> > > This mode provides faster boot times compared to normal boot
> > > while maintaining U-Boot's flexibility for kernel loading
> > > and system configuration..
> > > 
> > > v3<==> v2
> > > ===========
> > > * Updated the naming convention used from "no-spl" to "A-core no-spl" to
> > > * make it more specific and clear..
> > > * Link to v2:https://lore.kernel.org/all/20260818115322.101705-1-g-praveen@ti.com/
> > > 
> > > v2<==> v1
> > > ===========
> > > * Updated the naming convention used from "semi-falcon" to "no-spl".
> > > * Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/
> > > 
> > > Boot logs link :
> > > https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
> > > 
> > > Gokul Praveen (3):
> > >    configs: add A-core no-SPL mode fragment for k3 devices
> > >    arm: k3-binman: add tinospl.bin for direct U-Boot boot
> > >    doc: ti: document A Core no-SPL boot mode for J784S4 EVM
> > > 
> > >   Makefile                               |   2 +-
> > >   arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
> > >   arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
> > >   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
> > >   configs/k3_a72_nospl.config            |   1 +
> > >   configs/k3_r5_nospl.config             |   1 +
> > Please make sure to update the board/ti/*/MAINTAINERS entries for these
> > config fragments.
> 
> Got it, do you recommend creating a separate MAINTAINERS folder
> 
> in the board/ti folder and adding my name under some TI BOOTFLOWS heading
> with subheading as
> 
> A-Core no-SPL mode or do you instead  recommend adding TI BOOTFLOWS heading
> with subheading as
> 
> A-Core no-SPL mode inside all the board/ti/*/MAINTAINERS files.

As long as one board has it covered we should be good. Because this 
looks to only be for the J784S4-EVM I would suggest adding them to the 
EVM block inside board/ti/j784s4/MAINTAINERS

~Bryan
