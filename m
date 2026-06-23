Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD13DCDB466
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEC0849EF;
	Tue, 23 Jun 2026 03:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="nxn1jjoT";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="AernSNwF";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="mJoRIS/G";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="h+LYL+Gz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A010F849BD; Tue, 23 Jun 2026 03:49:49 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B664B849BD
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0i6De3892759
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 01:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=yR1
 afZ2d6M3rSo6zFgAjVSddu/um8MYG3vMXkRyo0wc=; b=nxn1jjoThNZn8Uwm7BS
 jPj8Js6pM1uLqBHH2EaXapI8pI8RXgADTZzuBMD8GrzCKPVXX3pPLWOn/6/o9MPd
 qxz0eOAri/eVMpXlvHm8QmQNkV2bavwFivVxYkHmJX5Mbdk8Q+L/uWAWWqWyCdrX
 n3WO7eVqSfoW8eD4Q/zo481eht/S6sH0t2feS97bmtc1USktZYadxGopfNRWCC6a
 URkBhnTPcE5fFhc/NA4QIEGjGrHrEB876y5R/V8SIKciYMFmAPe3vkTZXhwvLNh3
 ncJVdbhEmbrljlJGIhnsoRVjUawaGm1nKk/jI01RYjEi4r93Yeba3zUtYKdXbvve
 xSA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4eyd2nserw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 01:49:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRw76N5LTzG3gPY4x+G5ojixv1cjxNaAkfFNdZhOMlATHJ0qLI3+QXburCxNpw5sjVyiHhbhbEIBU2NtMVC9usZfK/5dAsfSdNe+XX1YHkeQmkWBFjKeLu4BVpIHIQKJ7RZnWr74/cY3WAaNz8oc1DzoY851Xx1jUZi+A8iFo9+KC74Yd6QN2fbm0t74hdbNtpYBmqWV2ZgAkClluQ/ES8Y/1hgRxg+deThXUcz+qW2KtNdYB4DRPAq6LDViEgt9++SWrrRe4iDu63fB6byXE5j0btLe+J8PuCip6CowdlFtyuifMpauYIR8WchKot1uPey2fuX/lqICQWKdPtBoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR1afZ2d6M3rSo6zFgAjVSddu/um8MYG3vMXkRyo0wc=;
 b=TiSZniVCo/NJ8TLJUN0G0pXZLpQSAhWSswYgSTr8lfr8cG9zxFXiOkaM98HuoweIRR4yZZoykn1M9SeEElX690JB2Q5BsaNqkSd2dCwt0Wi+sdQwBB87+nTOCAUgTuAzQ9cZASfwzxvisVlevGI32RDR+seswT3OdyY0fPGm+SxWJSCdA0Ydggl2WushrKdlEsjO0s3BEi7GiP5PKUy/QkefRQdbNYcSKB/asqFqnqXFZFAExqpAmEubw+YwM2Bc9XoVvC+IbKHob06PaQDxelQHu8Sr/N/hDbRvR1ix8oUeHZidR/Bwr7VYKXzx0Nj77BUCv4MVSUc3QpXut8shGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR1afZ2d6M3rSo6zFgAjVSddu/um8MYG3vMXkRyo0wc=;
 b=AernSNwF0OJNsDgfCie9MaXo7PZNoc/DBjWGGEoKLUqd/iURM4nfE6p83ByMv6gLQpy4zu8siyZJF6ecvFCoqEJpqPrM/2M3XjjKTYP9a6OAGnz/b7er3c6gXIJNtzy0e5uNdhVtK0a5JhilPwWwhju6l54r6Gvv1ifQKnA7onI=
Received: from CH0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:610:e7::30)
 by CH3PR16MB5876.namprd16.prod.outlook.com (2603:10b6:610:1b0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 01:49:38 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::4b) by CH0PR03CA0235.outlook.office365.com
 (2603:10b6:610:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Tue,
 23 Jun 2026 01:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 01:49:38 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0hhca3820128
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 21:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=yR1afZ2d6M3rSo6zFgAjVSddu/um8MYG3vMXkRyo0wc=; b=
 mJoRIS/Gvdjt5x6n46vEgVfN/n1ZFykqDObt5vjgy1sLZWiMukHScwPv1UaRMa6l
 +XE0w76f/YmYCuk9A/xPZrS0PdoZiVthgPjfwIYP/jVgK9s8N5zgdkin6g8/08CZ
 gd0ZwjH7pJNp+AjFkQh1Ko4+q3YUJViY7s48ODXciqUVKPqhMiDm0XYWtDovO9TH
 FrT4JfEQ8+Cu3MytVT5PhHcjxYQ/PCFo32OLqo6jd/ATRRBMbK8JxLVg4BcRGluu
 faJB4fqntKt9J2ymrt73a/epNOo+Z8nIQZKB1c7/gXku86ibY32oHbtvoB5tvgHp
 C5tcmcE7gNnHazs+V8CZlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=yR1afZ2
 d6M3rSo6zFgAjVSddu/um8MYG3vMXkRyo0wc=; b=h+LYL+GzXmx1EGKp5Q7YutW
 W76W86MsyeiLasgn88OnrDgTQWmkH6xcuhoiAg60BJKJGwXEirK44CYw4m6GOJWH
 pTYWao23fK+VcLnJnffXPWI++jFPlPsajC2DipoGCfUK8YHbUGC/giSqxL3IgogW
 f9mxzi+BswLZj+Ej2NPipCXutLovVD2uAnmgEhPyBJUPQ0++gGbnqfD/R4pNuwGv
 1RxX+TZjtqMHZruoOzhZ/EGqX2LIJYPs6ZUQOq/GP1UsUqolItD2FW87+yLSDtlP
 4YmwbFUBLgAZgHYBHs7V8paVTznI1IGR0WGvVbB4qSrpeG+fjZCtRjW0uPMJ8NA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9wc2a8q-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 21:49:38 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id bqGewV3fdftKQbqGfwdCTu; Tue, 23 Jun 2026 01:49:37 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: bqGewV3fdftKQbqGfwdCTu
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 2/2] test: bootdev: scan with a broken high-priority device
Date: Mon, 22 Jun 2026 18:49:30 -0700
Message-ID: <20260623014930.2741494-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623014930.2741494-1-dmukhin@ford.com>
References: <20260623014930.2741494-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230012
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CH3PR16MB5876:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ccf753f3-9a71-4e62-c2a0-08ded0c9afc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: CphOq3W+H6ohqQA2sWBT04kbitpTBBTVZrJlzFAq0dOknIYzyD1i3RIRyr+d8H83fsHDj/OjRYZIsfiS9+EW/C7b26pFiwAsmJXOZW/9w/4C6LTdPnPsPkPDxIeNrmNxTyJ+B1uy82XEO7rH9HNnVGJC3VHenKtLBYtsiv6u7Bk6w4QDgkeJdm/iO9yEU0kqgtA0TxS7W6b3L/YF21uP9Smh6xpoQWwreqjvNYLfsyURRqR+ZAjeiFym1LNdweLyysV8li+6Ry1yCFNsGX+nD8WJmDthwJWgJ6FHYNLNZQfXncMR433XRJU7Wm25czMlvMvrKtra9O2Aaetbu0FqzC+tAPZ5KHosuoqDrnd0ZeSkhooSo0rsLr/fTFfu+u/D7r15LAG7EOPjiYb88y1cnaQxP1TYTO+5y/gp0cjP3T8qZFmSmb3p61Dt47vNwY17YATDv1jC5J5it/cxNlE1K/22jIty7Vz2fAEF2Hdj0YTvrmFx2/AI+XMM842OnSvbtbKp2Cz+aCUTCIqjDjK9QA1+cpD/xv0b1FC19AWkxuy6Xk2w5Z8db8sXekXa5+/3ivdzqRFXwLV9+UtENb+ZBJfwaVMwvfAv+/ac0TRB162YKGUfmwbsO6/HkxtqIJMrPzH+aFPP1arhUYgVLyXC8jd+AdYVcGmS832c8Yba1tbHq4eijo9pTJY3jycxBqECVTbJlZSmWr1xwfRwhts2zQ==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HACq8301GDudQ9sxdjAzJD3UPZCIPtWtOfwM3awu2s3Hrj6eXVdKIvbNLUWk6noztb4gp5j8gRdYBwxe5aqBGoG8qxheoSF2+gjwJpBFcVHkEej5VIfqFBo1avFLAEI7Q5Hz/rr6scXFB+iorLMuIXKHmNi4fzVJqGRCdDpWWzidECvm7HJbPLFM/iVGkv+MVeTWhFVK5XAm+w+I2jPqygQ+o2kRje749lrD/QrfsAAzZ30DIGfE9MEX5BLclPjHmR1EYEsKHnChahvjzIMYZMx+/iBHVmbRPAIW7aiGjnt/om9+mE076+mgPoQVT05C5KWIqND9hXJnZ70CWNvmpvnSSd+7GmtpOn9vZJbWSLir6GzUMmBIYQ59w1IVzI4z/VWpZRc8CalMrknPhQqDqbOL0pfsxIUM5qB0SrT3dmk40fvUzCYONKZ5uUkwf32k
X-Exchange-RoutingPolicyChecked: AYty9rM3nLtFTN2HFhxO3/IbmGaghIF/6vlsblMsdXEZSlhB2lFNiEyzH8dt3b2eD4AOV41FR2zNJY+IzYFCZCpdyY3pTME/8Jd9HgvRL4h+3WxYdnqNnZFDiIKwtU9pKpCk34sZ2B8APqwiBSOSlT3C40Tt3EgncuLhG1rSQeX5t545WoWNJ4Yxk3H6G7BQX/91BZe/S7cQ+0P5cBUKmUTQlzx4L1TquU2gq4krgPMoAVh8iehcVo+TJx0FLcPhKFpnl5E1VLiLDxdR3UOC0Zv0fiPH3ukrFO5F7WPulDq8s9gB37ptYScmN4yJuH7Y8LCWdMHiwFUS3fycZzFj+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1Ky+H/zrvktdeiNki6JgNYxaOZghCxpZLKC9SmK7zaTobf/DgIUbkcuoEULGa3CfAJTTT6poF/cvdwVNHybxRtVqTwgpjPstsF1Z4xJHdtEe9E0/54mJAm3aNRHXUgsYOYwXizRQy8VbUlYCEcPn6ibJrJzRlFv0TI1MNGUGPl57op94UWfYMNYtGTJOqIeY72dXVG+3eLnY+h1tRANRD2MpeVixQgiZYLwefFIgNaVrGhTRdaCeyEp78tyhxqG7ykOyJqbQN6b1VDNfjNf+DD4BXR/K8MUjPRPNunTf4JiBMqESo0pZk6SG+sCadRmJ8grirvgZwD8p56s863cF5bfpJbkycxjGoMQh1JY6tUCYgaM9T1X62/xHl/FPofaVlAQDmMG8bC6sgX+sE7gNd61/qkQ7ji2z0dZG4aeSuE47f6ZhNVsjV/ZIN9UKfa0g/BBLQLB4bzN82mmkizrOCtMIdodb6Kh6g4b8RZxx/5O2eF8afzjeUxgyY99kEsNuRHzRdL7EgWdOPgOHXBpjZUOzUdr9z2btHlfaBWQDqM7xwL5VnXefigy6vbzdzyXvzieOewLytiNEPef7iqsU9nYuxKmTTBTTofVWLtKm08hV8wmBLgwvgQL73KjWTscv+wpDRybmDY3UfpIzJr4O+A==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 01:49:38.7793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf753f3-9a71-4e62-c2a0-08ded0c9afc6
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB5876
X-Proofpoint-ORIG-GUID: PzNmRI9MEcJdoUr_aAUvFi-OfkZBE_T0
X-Authority-Analysis: v=2.4 cv=BcLoFLt2 c=1 sm=1 tr=0 ts=6a39e638 cx=c_pps
 a=KRP2IWdqZ9jDnyY58Ngf7Q==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=cbNQJ9GKAAAA:8 a=i1MxBqhcqyiCWgHNAf4A:9
 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: PzNmRI9MEcJdoUr_aAUvFi-OfkZBE_T0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAxMiBTYWx0ZWRfX+6p6KfIVaJ1s
 mRSAwRwuOVq4K6HXFLw0h0yyUtnFM8VJ8Swple5LArmhEpoCwLnyUR70m42GhluJN7ClYNXjfDP
 VlklkMtJ1OY36YG1ZxEbRZ+VkV8qbsttiNoFH4PuxP8/dAtMmooTc76CtcDl5UAnxLsGxWBhdz+
 OO1T2NzrLE6Oh7U+zlT44a44+MM99qfFM0QGFT8wlMUgaf5fDOwhUwgb13+yCBI/2K6ev/1SUFr
 VPv9pqhdAH+D8GdOKhoV76sSdxjoWBc1CgzWISIx8pvAJF7u0Ku6JH8sYNPAUJQSbpYmASMGWVT
 Nipr3xvTKE9lyHqtZmRT1Xgy1YSEUER4wx4brH0mB6NA4xccYdwCQortuWmfP5DkgmpHHEg/atx
 1NMS39bxzynl36KmPNxIYwPtf/rBylMmFqX48eZNfVXyshWgc6rxGzf4nXzc3mXtpnZTz3nl2kx
 SHIbvN0LK9tH4YTG4wQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAxMiBTYWx0ZWRfX6nyRFFhn0YBV
 vyrgH0TShLqrnU1Q2T8n4PsqlMQPCkOV3P2JkPfIu1y8ShVTCTl7qEfn3f1jC9013rCRea3vLjN
 OXJBkDcbMVwe0gwUN15ZwM7z17MUAZupODxkmv6fOvqbPTCO7pPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230012
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Denis Mukhin <dmukhin@ford.com> 

Add bootdev_hunt_fallthrough() test to verify that 'bootflow scan -l'
falls back to a lower-priority bootdev when a higher-priority hunter
fails.

Introduce a simple 'sandbox-bootdev' device for the test. The new
bootdev can be configured to produce an error at the hunting stage.

Introduce new host_set_flags_by_label() API and a flags field to
'host_sb_plat' to simulate a bootdev hunter failure for the test.

Adjust boot{dev,flow} tests which depend on bootdev hunters.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v3:
- addressed feedback from Simon:
  https://lore.kernel.org/u-boot/CAFLszTgU3X2GUTny3oG3+HxAuuKrGu9di7-oGBM3xaP8ZRVA6w@mail.gmail.com/

Changes since v2:
- dropped 'flags' from 'host_priv'
- added description for 'flags' in host_sb_plat
- switched to log_xxx() calls in sandbox-bootdev.c
- corrected sandbox_bootdev_hunt()
- updated boot{dev,flow} tests which depend on bootdev hunters

Changes since v1:
- new patch
---
 drivers/block/Makefile          |  2 +-
 drivers/block/host-uclass.c     | 15 +++++++
 drivers/block/sandbox-bootdev.c | 73 +++++++++++++++++++++++++++++++++
 include/sandbox_host.h          | 18 ++++++++
 test/boot/bootdev.c             | 23 ++++++-----
 test/boot/bootflow.c            | 46 +++++++++++++++++++++
 test/boot/bootstd_common.h      |  5 ++-
 7 files changed, 169 insertions(+), 13 deletions(-)
 create mode 100644 drivers/block/sandbox-bootdev.c

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index f5a9d8637a3c..c827fa81a2d8 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -13,7 +13,7 @@ ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_IDE) += ide.o
 obj-$(CONFIG_RKMTD) += rkmtd.o
 endif
-obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
+obj-$(CONFIG_SANDBOX) += sandbox.o sandbox-bootdev.o host-uclass.o host_dev.o
 obj-$(CONFIG_$(PHASE_)BLOCK_CACHE) += blkcache.o
 obj-$(CONFIG_$(PHASE_)BLKMAP) += blkmap.o
 obj-$(CONFIG_$(PHASE_)BLKMAP) += blkmap_helper.o
diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
index cf42bd1e07ac..95b0b0b2ffea 100644
--- a/drivers/block/host-uclass.c
+++ b/drivers/block/host-uclass.c
@@ -150,6 +150,21 @@ struct udevice *host_find_by_label(const char *label)
 	return NULL;
 }
 
+int host_set_flags_by_label(const char *label, unsigned int flags)
+{
+	struct udevice *dev;
+	struct host_sb_plat *plat;
+
+	dev = host_find_by_label(label);
+	if (!dev)
+		return -ENODEV;
+
+	plat = dev_get_plat(dev);
+	plat->flags = flags;
+
+	return 0;
+}
+
 struct udevice *host_get_cur_dev(void)
 {
 	struct uclass *uc = uclass_find(UCLASS_HOST);
diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
new file mode 100644
index 000000000000..acc1f7bd9f7c
--- /dev/null
+++ b/drivers/block/sandbox-bootdev.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define LOG_CATEGORY	UCLASS_HOST
+
+#include <bootdev.h>
+#include <dm.h>
+#include <log.h>
+#include <sandbox_host.h>
+
+static int sandbox_bootdev_bind(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	ucp->prio = BOOTDEVP_4_SCAN_FAST;
+
+	return 0;
+}
+
+/**
+ * sandbox_bootdev_hunt() - Hunt host bootdev.
+ *
+ * Note, this hunter exists for bootdev testing to simulate a fail
+ * mode.  Do not use as an example of a real hunter.
+ *
+ * @info: Hunder details.
+ * @show: Enable extra printouts.
+ *
+ * Returns: 0 if OK, -ve on error (expected by the test)
+ */
+static int sandbox_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	int ret;
+
+	uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
+		struct host_sb_plat *plat = dev_get_plat(dev);
+
+		log_debug("hunting %s\n", plat->label);
+
+		if (plat->flags & HOST_FLAG_BROKEN) {
+			ret = -ETIME;
+			log_debug("cannot hunt sandbox device '%s': %d\n",
+					plat->label, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct bootdev_ops sandbox_bootdev_ops = {
+};
+
+static const struct udevice_id sandbox_bootdev_ids[] = {
+	{ .compatible = "u-boot,bootdev-sandbox" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_bootdev) = {
+	.name		= "sandbox_bootdev",
+	.id		= UCLASS_BOOTDEV,
+	.ops		= &sandbox_bootdev_ops,
+	.bind		= sandbox_bootdev_bind,
+	.of_match	= sandbox_bootdev_ids,
+};
+
+BOOTDEV_HUNTER(sandbox_bootdev_hunter) = {
+	.prio		= BOOTDEVP_4_SCAN_FAST,
+	.uclass		= UCLASS_HOST,
+	.hunt		= sandbox_bootdev_hunt,
+	.drv		= DM_DRIVER_REF(sandbox_bootdev),
+};
diff --git a/include/sandbox_host.h b/include/sandbox_host.h
index f7a5fc672300..1330358ef7ab 100644
--- a/include/sandbox_host.h
+++ b/include/sandbox_host.h
@@ -8,17 +8,26 @@
 #ifndef __SANDBOX_HOST__
 #define __SANDBOX_HOST__
 
+/**
+ * Device flags.
+ */
+enum host_platform_flags {
+	HOST_FLAG_BROKEN		= BIT(0), /** Simulate broken device */
+};
+
 /**
  * struct host_sb_plat - platform data for a host device
  *
  * @label: Label for this device (allocated)
  * @filename: Name of file this is attached to, or NULL (allocated)
  * @fd: File descriptor of file, or 0 for none (file is not open)
+ * @flags: Device flags (e.g. for unit tests).
  */
 struct host_sb_plat {
 	char *label;
 	char *filename;
 	int fd;
+	unsigned int flags;
 };
 
 /**
@@ -122,4 +131,13 @@ struct udevice *host_get_cur_dev(void);
  */
 void host_set_cur_dev(struct udevice *dev);
 
+/**
+ * host_set_flags_by_label() - Set the host device test flags
+ *
+ * @label: Label of the attachment, e.g. "test1"
+ * @flags: Device flags
+ * Returns: 0 if OK, -ve on error
+ */
+int host_set_flags_by_label(const char *label, unsigned int flags);
+
 #endif /* __SANDBOX_HOST__ */
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 0820bf10ee08..c2eaf0b2c559 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -384,19 +384,19 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 	ut_assert_nextline("   2        mmc              mmc_bootdev");
 	ut_assert_nextline("   4        nvme             nvme_bootdev");
 	ut_assert_nextline("   4        qfw              qfw_bootdev");
+	ut_assert_nextline("   4        host             sandbox_bootdev");
 	ut_assert_nextline("   4        scsi             scsi_bootdev");
 	ut_assert_nextline("   4        spi_flash        sf_bootdev");
 	ut_assert_nextline("   5        usb              usb_bootdev");
 	ut_assert_nextline("   4        virtio           virtio_bootdev");
-	ut_assert_nextline("(total hunters: 9)");
+	ut_assert_nextline("(total hunters: 10)");
 	ut_assert_console_end();
 
 	ut_assertok(bootdev_hunt("usb1", false));
 	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
-	/* USB is 8th in the list, so bit 7 */
-	ut_asserteq(BIT(7), std->hunters_used);
+	ut_asserteq(BIT(USB_HUNTER), std->hunters_used);
 
 	return 0;
 }
@@ -417,7 +417,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("Prio  Used  Uclass           Hunter");
 	ut_assert_nextlinen("----");
 	ut_assert_nextline("   6        ethernet         eth_bootdev");
-	ut_assert_skip_to_line("(total hunters: 9)");
+	ut_assert_skip_to_line("(total hunters: 10)");
 	ut_assert_console_end();
 
 	/* Use the MMC hunter and see that it updates */
@@ -425,7 +425,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assertok(run_command("bootdev hunt -l", 0));
 	ut_assert_skip_to_line("   5        ide              ide_bootdev");
 	ut_assert_nextline("   2     *  mmc              mmc_bootdev");
-	ut_assert_skip_to_line("(total hunters: 9)");
+	ut_assert_skip_to_line("(total hunters: 10)");
 	ut_assert_console_end();
 
 	/* Scan all hunters */
@@ -441,6 +441,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 
 	ut_assert_nextline("Hunting with: nvme");
 	ut_assert_nextline("Hunting with: qfw");
+	ut_assert_nextline("Hunting with: host");
 	ut_assert_nextline("Hunting with: scsi");
 	ut_assert_nextline("scanning bus for devices...");
 	ut_assert_skip_to_line("Hunting with: spi_flash");
@@ -458,11 +459,12 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("   2     *  mmc              mmc_bootdev");
 	ut_assert_nextline("   4     *  nvme             nvme_bootdev");
 	ut_assert_nextline("   4     *  qfw              qfw_bootdev");
+	ut_assert_nextline("   4     *  host             sandbox_bootdev");
 	ut_assert_nextline("   4     *  scsi             scsi_bootdev");
 	ut_assert_nextline("   4     *  spi_flash        sf_bootdev");
 	ut_assert_nextline("   5     *  usb              usb_bootdev");
 	ut_assert_nextline("   4     *  virtio           virtio_bootdev");
-	ut_assert_nextline("(total hunters: 9)");
+	ut_assert_nextline("(total hunters: 10)");
 	ut_assert_console_end();
 
 	ut_asserteq(GENMASK(MAX_HUNTER, 0), std->hunters_used);
@@ -646,8 +648,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	ut_asserteq_str("scsi.id0lun0.bootdev", dev->name);
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_UCLASS, mflags);
 
-	/* SCSI is 6th in the list, so bit 5 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(SCSI_HUNTER), std->hunters_used);
 
 	ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
 	ut_assert_console_end();
@@ -657,7 +658,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 		    mflags);
 
 	/* dhcp: Ethernet is first so bit 0 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(SCSI_HUNTER) | BIT(0), std->hunters_used);
 
 	ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
 	ut_assert_console_end();
@@ -667,7 +668,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 		    mflags);
 
 	/* pxe: Ethernet is first so bit 0 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(SCSI_HUNTER) | BIT(0), std->hunters_used);
 
 	mflags = 123;
 	ut_asserteq(-ENODEV, bootdev_next_label(&iter, &dev, &mflags));
@@ -675,7 +676,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* no change */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(SCSI_HUNTER) | BIT(0), std->hunters_used);
 
 	return 0;
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 56ee1952357b..b67cf67d5d44 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -19,6 +19,8 @@
 #include <mapmem.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
+#include <sandbox_host.h>
+#include <os.h>
 #endif
 #include <dm/device-internal.h>
 #include <dm/lists.h>
@@ -1532,3 +1534,47 @@ static int bootstd_images(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootstd_images, UTF_CONSOLE);
+
+#if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
+/*
+ * Check that bootdev scanning does not stop if higher-priority bootdevs
+ * are failed to be hunted.
+ */
+static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
+{
+	struct bootstd_priv *std;
+	struct udevice *dev;
+
+	ut_assertok(bootstd_get_priv(&std));
+	bootstd_test_drop_bootdev_order(uts);
+	test_set_skip_delays(true);
+	bootstd_reset_usb();
+	console_record_reset_enable();
+
+	/*
+	 * Create a sandbox block device (BOOTDEVP_4_SCAN_FAST) and mark it as
+	 * broken so that bootdev_hunt_prio() returns an error.
+	 */
+	ut_asserteq(0, uclass_id_count(UCLASS_HOST));
+	ut_assertok(host_create_device("test", true, DEFAULT_BLKSZ, &dev));
+	ut_assertok(host_set_flags_by_label("test", HOST_FLAG_BROKEN));
+	ut_asserteq(1, uclass_id_count(UCLASS_HOST));
+
+	/*
+	 * Scan with hunting.
+	 * The sandbox hunter at priority 4 must fail, but the USB hunter at
+	 * priority 5 must still be reached.
+	 */
+	ut_assertok(run_command("bootflow scan -l", 0));
+
+	ut_assert(!(std->hunters_used & BIT(HOST_HUNTER)));
+
+	/* USB was hunted despite the sandbox hunter failure */
+	ut_assert(std->hunters_used & BIT(USB_HUNTER));
+	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
+
+	return 0;
+}
+BOOTSTD_TEST(bootdev_hunt_fallthrough,
+             UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV | UTF_CONSOLE);
+#endif /* CONFIG_SANDBOX */
diff --git a/test/boot/bootstd_common.h b/test/boot/bootstd_common.h
index dd769313a842..672917454a31 100644
--- a/test/boot/bootstd_common.h
+++ b/test/boot/bootstd_common.h
@@ -21,8 +21,11 @@
 #define TEST_VERNUM		0x00010002
 
 enum {
-	MAX_HUNTER	= 8,
 	MMC_HUNTER	= 2,	/* ID of MMC hunter */
+	HOST_HUNTER	= 5,
+	SCSI_HUNTER	= 6,
+	USB_HUNTER	= 8,
+	MAX_HUNTER	= 9,
 };
 
 struct unit_test_state;
-- 
2.54.0

