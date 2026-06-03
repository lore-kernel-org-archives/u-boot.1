Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1175CCD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF5D848D8;
	Wed,  3 Jun 2026 09:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="MO+b6wV5";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="Z0vQpH3s";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="cls8IUK7";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="EkScFy4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D5D848C6; Wed,  3 Jun 2026 09:08:07 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCBB8488F
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482516.ppops.net [127.0.0.1])
 by m0482516.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6532WVjl2715874
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 00:08:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=04g
 HX8RbSnrg/aB1oQ+WYW7XkKh8hTYGY9zgiTDoroY=; b=MO+b6wV5O4qKCLFNmLO
 7JC3wk4gRJkEQvKO94kts/xYsphCFf6UiqlI7FEqfH/Tv9oxslgIC0ZyYWnZMGy+
 JQ2GLu+w75B68VUt0qB/3MulVB1z7gST/F9xjasn3My3Glm0Kz+xG/frAJ6zxuHM
 NMzdG4yGfc8XG584vwrgh3OPjs6juylaQOymBQDgmDmNSLk0nLuXJP6+dHj/8oR1
 B4VlzAM3g8TlIz8NfHFA224MOay3LID6vaL35WV/Sfd9E/P/dvN6Q+K8oMJkpzea
 PhcW4lutktcwm2/M2ChiR9NPmjrBvHiLqHQsA1kMJ7qPm4h63XXWngJCj0XDuvag
 wiw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by m0482516.ppops.net (PPS) with ESMTPS id 4ejbjws9ft-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 00:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r92HQVoCcUMhtAJ94JrYeBxcOTZ+fT7tY+VwKpZmOtyEttzUKYF9+mZrtOrwNl+xOu7JALI3+M8vCCMr/UG2aFRnnq5zCuo7dC0xunXcz6Uehi3altDfjVSvrB5X/TyaLjhDXEAVu1aB3GlW+dG83Up4xh2PUFi0DIVz6LzlPhZtidVV6Oh8bnj+5/Yu+2rKzpgRSuDDNSFqjTiJ2rGRAsz/kkygtFuYQYidO8YFlo1i9j5Swy0tbHorPhSbx9i298q0sw0FebqVnoDjMkXrIDyMT9qSF8T0/pW5/AMVwonzET3jY7qE/MexKWQfM4TwPjMohhJxgqxZKNaMCDLR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04gHX8RbSnrg/aB1oQ+WYW7XkKh8hTYGY9zgiTDoroY=;
 b=PSaWrb2SEhX7hc7Q1xv7gOhGqxcqaQrESjtH+TFVBa/ZvqkcES2ObFkzuT3YFc9h93mHWIEnimKAI6sfH0DhfaAeT4XWR1l2brGV5aHmNraFgIAqfAv/5ZhwM4aFaBXrLgvazPzVXO5X0qQZqgbl0hgORx3DhszxbHIMqo+OKNFEymTOeHtfIipSmXpUvTFhdprBd5xRR8WWfy1aYBETaN4GG2ryudyIWCJf5Y8Jp7Bc15xp+gjavDKG5GK0UnMLocCBVwpARx/8+dLUDkqRPUEIpEJztfyrkn9D1OdkQztyFYSKxVKzW13s/WRZYwbF/Mh1tRiVyn1ObYr64IGDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04gHX8RbSnrg/aB1oQ+WYW7XkKh8hTYGY9zgiTDoroY=;
 b=Z0vQpH3sbjeKEbp3QaOGC4+YiPHD/UvLaQEtBY3A+v/oS/HYBxUp/Ma6msorug46JNuW7Jfwjbseo2a+ezYnAuvzmbhEqfI1eHlt1j1xf/zNdAREJ3kwVXgEiNhbt4JfsCf+Dm+k7jFJP4BQm7wgIUupqoGnlTCiDjy3NBObO2I=
Received: from SJ0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:33b::25)
 by SJ2PR16MB5817.namprd16.prod.outlook.com (2603:10b6:a03:570::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 07:07:59 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::2f) by SJ0PR05CA0020.outlook.office365.com
 (2603:10b6:a03:33b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:07:58 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536RH6m1072902
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 03:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=04gHX8RbSnrg/aB1oQ+WYW7XkKh8hTYGY9zgiTDoroY=; b=
 cls8IUK73IQeVyAAX0R5uCG87ZlO1x5+fWeXDrR5igHMNtUnY2ayW0fXRLjysn9f
 Zdp9xC+z70/SfIjE82n+NMVXfiWNcQfREuNtdRIdvB6SOr4hT1vLgUGceWeX9nQL
 6UoBy5efYoToQfWhzt4QaxhP5JmGOfRVk0ErqI0wYGyR3V1b7/nKKcDatan4ulyQ
 Nuw1n+z5pygZw/8AC5lxCJytMgNgworHeYoG4n0XRbtlPtyyVD7UiHVuOTQqubgZ
 AKYAy1cF0O0Boh3ngfj/65O1oVy0YnRdraKw5/WLNzsbZXpU5mRWpurN1cwxYN3M
 uifgwbQp8UnfJC89ETWqSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=04gHX8R
 bSnrg/aB1oQ+WYW7XkKh8hTYGY9zgiTDoroY=; b=EkScFy4vf8vLxvAYpuPecSU
 dodzKf2XQcsSSi5oW7/tR67q5k4XHTKNoQ+YzS1iIfjlxZQU4x9/PCVDQA7aQLPD
 IiWpeSoDonrB2wd06rONKhJFwMkCziQVOgJBg/XuGjFZ06pILWsOnET0sFohfpSQ
 A2KyNumj+LRvfGyD/xlve1VClxheNsgrPIc04iyrvZ8XCv1IxAkBOqjsHkOLExlM
 E326fcQo/yM2fSCvqOZk20zQYS4X61nWDnbBo/DLuIpNBjXDAMfLJ7nTfia7AJ9R
 nSrzwlHkXZwPARi3KT2g7lhqXSQwSgVmYoz1+FmR4yiSAMM52LHvgwn3gjnxxjw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egexd4kn6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:07:57 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id UfhiwSzEsYPuRUfhjwQoWM; Wed, 03 Jun 2026 07:07:56 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: UfhiwSzEsYPuRUfhjwQoWM
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 5/7] reset: x86: Use cpu_hlt() in efi_reset_system()
Date: Wed,  3 Jun 2026 00:07:41 -0700
Message-ID: <20260603070743.1268544-6-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603070743.1268544-1-dmukhin@ford.com>
References: <20260603070743.1268544-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ2PR16MB5817:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 59710c94-091d-47da-93a7-08dec13ed813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: kk++s+oDvRnF04GohAVsrDOYFhdqoupxv4T6AFevpjr0V6HiWBjabMALpnHKzkK82Bb06AitIk+wBYnoavOl6GgksgBXHeBNLZxqdnB12ThYS1T9h7VlMyi2LXe9x/IunMvCgJkBHAhyeaweo5DYMH2+rrcIn4WvyLCuUxPQGBiUAZ9Ef+IDq2CQF/Qv2G5TI1xdbyn2h+UPUIt6GqMt5i5xhSVLFRUZ4DPHhhDpk/SEMt1CZxXRHuqjyCWGLSd3DtW7o6d+4c6CmlBs18RKPt//KfupVzzZHkEhT8U2Iy6psGXp0Wua1htzoe9FwIXFSxlj5z5p8deMK7tErN0B9AFswytFMbNj8QMBN6v/LtVHfWKJXW5oGact1OX788G47x+TMm9m1ZGn4UE3ZLKkWLHQcYrQjUeyTX3dIgVtwUMSE6Qn6eSaw4/ngpBFM60Q/3HxI+9G9OXtOFQHyc/FnQ6P63ZroQqMb4GqsEDTe3SMNGcgt8fRGFX9umBsdszRjY+YSc96Mf2gWbqo1UvoeAQOG9ogmctKxzcSuArZzSpLtzHzgIH7SBuzwB1M8RF97JlJtcRjVq5ymrgduMJFXmGnyfxBF03e2AHXc5bkLflKvGtdDob1VNWq5pIGZ5Z6GEU2D0/uX+eKztVV8YrcNXfsEhXvGdaiRFECQJBs/wQxDZz8IaWWW4TE7uSsTIaVT2YgcjEHwQMKtd4Z5U5cSbIWq+J1IBg16DD+gAEguyA=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TdwOL9aC2jzsWuTrFSXeai8JIQ6QKXkrSsK2Fu2s13eYctkpikOAkSEGTc1osgWiZrfdALm+u00o6fYQbanrVKEXoOzc2Q8b03s8LNafswLNK8QkEOSZ1txU7i1my512xZ8M3rpAJ/IdZUzxjbjpTMFzwZD1D9NAL8Kao6rWhpMrCY5vXajgkeBv94kybH5QhS+KRMbbesyNvEeDFTVjXuMv+j+QZITbih9mT69ycCGJRkiBS3DUaKntBqBjH29oktQK0IaKbcEn1F0gETpMzlU6UzG5zUJfSz7P6bXKEe3CpEXOYcyfvLryT581qVzIcPq719OoXzAj0mZF3GYjlnEq40/eEJ6l95le40Q5GoD2Jpb3V6CuERBrcH5o4NIdjh7WhuvXaweE0N+rgGZkUC2+0H0HShDHjraiPm7CUAxtZXB070nlo7vCF1It5xqH
X-Exchange-RoutingPolicyChecked: Lv0e860OooRhb6S68EG5UZujuK9P83OZ2c44OwNjazflqsSh+LEdXj3SbXl9U6H3FjzYc/3tYA30FYecO17MmnX81UThXMCwhagxrQREP1eb/Dg2RCncg9xsCmthPP8+GQKxFJroDV47v9rUDTrfse0ibikNYhIixfg+N9irSQNtgFRPfwN2mXL6Tke0a25PxHE/5n20q4jxTGyJUoYVUyllzxCJUZ8zufjb+3vK9WYNgIDkI5FqOsqy5REsRlEc6VutFFgrrSpl+BkG5IzrEr1nnuFQZbog9ZZ0i3/TgtuPGMNBEgw81pPFLTUatSQlBL5En5ohMhDnNvrNC1V/dg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MKxum48nA2f6KnZ5spDlNRC5FeyA49Ob+j4HZfwsvWss/qBaUWSMB52rK2b+lBGkqS/ck08adJua1nb6jbmBCM+5V/X9ot3nY/Z/pCR1vlpVBXDVQWFFNCwc3SFH+rR4VwFtXqlIbEgaTvainYjZiJfrwCkcPUMrXXNU1biUd/Hmat8xlcibhF66b/7BlnkptcCF2CUhvgiUTjfwJ5GTDgJ2/kbPck05bttcRjLFM9JFYy8IKKN3Tth+S41juLlWYUJfvIThEZ8nISfcHX1CoqV2kNyCK6LaPBbkfI+oEbEYBdiCftKhdkRSKGbhLvrT6E9LamPb4PSEVQWW6daGwsAClKcihxs/nsQw457zOYq0vpIw3+dN7IvHx1BEWRC3kJJiX9Q5x5wSwK0emrp3DdNoxmdSmkTV66dsVNaa6QKYHRWWgjkJq7m3MYJUA5QezMGerrhMLdU7gLcUX+KDhjbs873VUuLTNBGQrPtquADlVk7TpZQeTFPZ1hMKG4CO/y06/9Mz2gJc6K2GvAH8GJxEKjQ83YQNbRGBP/avuVnykBwuBQ2K/oTyl0qnueIW6ZkM/UdLEZPV9AdAo5zqjyz1el9o0luEmO2Lf4wgj0ixv95IpTOn62/q4k1LmMtM
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:07:58.8289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59710c94-091d-47da-93a7-08dec13ed813
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5817
X-Proofpoint-GUID: LOW8ArQ19BBSrAyhoM0oJ695qHMNPOFK
X-Authority-Analysis: v=2.4 cv=H5TrBeYi c=1 sm=1 tr=0 ts=6a1fd2d2 cx=c_pps
 a=Q/wuv1ctlB2aVCAjPXHW/g==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=NvsXeTrgx-CJMFV-xl94:22 a=cbNQJ9GKAAAA:8
 a=fxTP-d3fqvP9VAt8igsA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NyBTYWx0ZWRfXzSj5zK4dDo1r
 K/EqxHHXDETgIZshhJSZBbwxaR5/VdaQI7eY5JYBZre3FV/QQM1UfvGd/m0bxPzsgZGwF5GZitr
 eC9JcZlVKKLPkLv1QSqNSR4AjdrF7jwTmJc8LifnDr7jPER2LAc+jma4P/jUZOYXxfbybvZ2w1P
 YJnpWjKNf+p27IVThE5ZYQQSkLusRZNJDRMX9X4kVqsN50oE4sZRVmSio/j/fjTC1obdMVVgp/E
 jfWgLbCxGXd4lPuRd3eKSUO4i2hXiB1bo4XtZxpxXEVlEJiodkewytnsCZFEsTdDvARBBMN+VXk
 orMrIgzkPKpZu9BTmSWaaob3ttQCbGYzrK0amJ1UAvmbY5cl9QkXKPuGK5irQtpeARW2NnPJuxE
 fcA59vQKaDwNNkgl8f67SbA5R1aeYQkxoY7Vv3g1zerstZZ6XxqAKU/FqVh43k86/IiJN47f/xB
 LC7EGsqlPFd/s0kbNmw==
X-Proofpoint-ORIG-GUID: LOW8ArQ19BBSrAyhoM0oJ695qHMNPOFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030067
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

Use cpu_hlt() in busy loop in efi_reset_system() similarly to
pch_sysreset_power_off().

Note, this is safe for __efi_runtime-annotated efi_reset_system(),
because cpu_hlt() expands to a bare "hlt".

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v3:
- new patch
---
 drivers/sysreset/sysreset_x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
index 05a3ff9c8363..afb77d9c5c21 100644
--- a/drivers/sysreset/sysreset_x86.c
+++ b/drivers/sysreset/sysreset_x86.c
@@ -120,7 +120,8 @@ void __efi_runtime EFIAPI efi_reset_system(
 
 	/* TODO EFI_RESET_SHUTDOWN */
 
-	while (1) { }
+	for (;;)
+		cpu_hlt();
 }
 #endif
 
-- 
2.54.0

