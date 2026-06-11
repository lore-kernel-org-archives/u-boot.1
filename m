Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB05FCD98C5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 01:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4E6848DC;
	Thu, 11 Jun 2026 03:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="k+0nYsCh";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="MoJc/CHc";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="IsBSmvj1";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="uHbg+ag7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061CE84948; Thu, 11 Jun 2026 03:49:08 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F90848F0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 03:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B1hMZA837258
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 01:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=nHc
 H9Oj5ssSTDSY8XtFEuFAzrK8/Y+YSuEcU1EJox4E=; b=k+0nYsChQ8RJ/Mx7VgI
 qkA/1bYXrqsQ2hsRi43uW6BnbsXxBiDgzASPV0gr5ltftn3Gt6qUKyq9uPa6Gn5s
 4jOb/pbxhe/a/pXhSDQvescJjQ0oFREn3GXAz8hEYzJxPnAlPkhNJsnh5lqkLR+O
 LhiVMlAQwY6ivX2w8kyr5NiaOdWVaJCGmJty17EayiwcWMmttGdm9nkNehtxhmhw
 95yhvt+aNDEz4e8aFOhpCiet0L+43fSPpMnidKVYVH7f/dUn+LNTmJtkQVUPrlEP
 jzpiSqNe4yGFTISykPsCEO1DC/W2ocfMElLt7Kj/zcuzLKOiaxFNIo0/p9EERqCZ
 5BA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4eqe6q2pp1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 01:49:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl/7FW+L11X1Vx87/t1uAx7jDpMwmpmbmCz2X+Y/TEdnP42UAOHYJonVMPJB5khPyX3IO4gjdbx3j6cr0yRfXU69TagpAB+yH0mX0oXnyqw3/0Bu1R43Eqeuhr2eS3qoWR3aRhCZDTBmPvTxyxDd1ArOJnX05RY6QQgBUUsjhChNQmylMRDzGdhcdOM+iXfPAGDwuYwpl5dCDkpJDWDAlUrAamo0+SC1DS7dr9ZgiyNOTjlOLJqsKsX24VJ5yhpxjLjd7xtyyvQiOzjQeO4BHsHt6rcWcRT4gRwr91LATiWQm3XTVEqyr40XF9NI6F4Tv9dmmSH7M73xG+l2cwEYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHcH9Oj5ssSTDSY8XtFEuFAzrK8/Y+YSuEcU1EJox4E=;
 b=dWMdlJP3tmI9XgIJQuITL/RcJ9KM4tQhCEXW4H+9jURvvvtELHLMfll96MTQtQpohStDTudj4d1pfWA7QhSBCQjnNCsy7fJqvIIKPSScxozMJAy6WwqsaavH57NpQod0QLkXQTL6ljirTlzj/CJGTDbsk63OUkF6sGhq3uKgIgBgd3AORK2CHeYhSK+4UoQwLZUA0X4spKdM9p8K/YS+fH8isA/PnGI+Sae8dNv6NlFEO5c2ZEl8ym8yIkh4XatswYyIsDRnpeMmhKMxZhUyOjfpMmtiO1wawjkfV+udyahOcaQc+sr61wOnjrmUSZQZBA/yfhsLGl/neR8kwp0izw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHcH9Oj5ssSTDSY8XtFEuFAzrK8/Y+YSuEcU1EJox4E=;
 b=MoJc/CHcE7ISkiaKtXTV2X3vzfjHE2hHNY3mQqnW6JD3/Zwf1WXBs9h2vAab5aAOIZ2NmX3ha9Lqy3yooc4Jr2n1NVOuFX4hMZp760FdCDtwGXYavCuB9J1xejRs6BkqJ+3TidtVexKA6XH4afX7YDPQL4aEov7eV6phUzbwuQc=
Received: from CY5PR03CA0026.namprd03.prod.outlook.com (2603:10b6:930:8::21)
 by SJ2PR16MB5143.namprd16.prod.outlook.com (2603:10b6:a03:4ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 01:48:57 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:8:cafe::91) by CY5PR03CA0026.outlook.office365.com
 (2603:10b6:930:8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 01:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 01:48:57 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0Oj4x1579246
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=nHcH9Oj5ssSTDSY8XtFEuFAzrK8/Y+YSuEcU1EJox4E=; b=
 IsBSmvj13HKx6/Xa+lAEa0/6z7jZgmB9jRfL2vIp86M0VsNT70Y3X+3QMI9PAh2I
 Jfot2nfVP7wOdS4+cxccAtP8stcVVuA3wxWjGDgqReXg9Iwwy3d0wqDcQRuTbhib
 UfM0QB/1a6iQeIQcwMlkDtB9kZI61+AZrAtXalp7QTcmGtCOIzyegj0C5p5rZ0tW
 4rB1eFcEyKFFHUGqhp+lNjol+hgfvNiCdrUjJULS3GbYBVWpposRE/vk4qWgyOPT
 uz8bq5Mx99u1/k9cb2AWGHaszDkAr3xbvFiKgAHrWYgdZ2hOI8TylOc1tH7q96R7
 Qld5oPPttq5PLcCP+XfGng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=nHcH9Oj
 5ssSTDSY8XtFEuFAzrK8/Y+YSuEcU1EJox4E=; b=uHbg+ag7OiUEwI+/p1v1z1U
 DLCdHrzFNmpwgdyvaAF/BDho6OMCYmsJpFXeGtY0OblvEMngVvRYOO1KUwjiHrXE
 jWXp4wlLFqNZUluIEaGJz3h8K88WL0k33+Cti2n5UyQDKXGkwEhiKWK/QWpaM4C4
 3uTr8zsVkEiV0+/lq+fYNFcB5zra/ByZ/xNSzGlL7IX+FoRf19STzFgenXwRcY68
 0dTKKdJwp8EPU3C/aLExqirK8DqLFXrmugeB2YHczxClOokTxmBGoGW/yy+zlywL
 9Rgaoihy9AroBx7JvWH+Dx3zrI4inap9GMcMhzpCv5tMFLc6kdrmp2jfztiV7jA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eqe6pgaer-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:48:56 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id XUXPw93Cc8Hc9XUXPwQyqj; Thu, 11 Jun 2026 01:48:56 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: XUXPw93Cc8Hc9XUXPwQyqj
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 2/2] bootdev: scan boot devices at each priority level
Date: Wed, 10 Jun 2026 18:48:43 -0700
Message-ID: <20260611014843.3735672-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611014843.3735672-1-dmukhin@ford.com>
References: <20260611014843.3735672-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110015
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SJ2PR16MB5143:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27656e14-1617-4f0c-6f87-08dec75b9a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|13003099007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: USN1EY4d2RZy+fRCPW3E38lzS4tPdWN315PQgwLrF/KaqWjuBHgC0QqAqFeW2tJeX7aLkVQYBnzNAwxqHVORG2HZeEhSsqmrB0ce6H1kTr87d2beYHp96OHkHiOpU7tf0Z5PjjQW3mHIqizsDHzY/LSvlp5D4XvM2tgfCh1pu/0ez61BQbwof3jmnBhI1/VcOhGT28Y7UmEDWXn1DBNb9WWAoJzwax2b1FKidASAwfBx1Ad3S1IWXlcSN6ChFlRleXHf7RpnNfpnSjTeJD38nwc1046ri8s3EiXA8pN4muflZZQa7TDO6e+n6rmqcmycIWEWKW5wHol7cUj7jOVvf0QrbAsxHxGLHoRGEKnUPfsti2gVPZaBdluG4l2yNOV2LlPO9UkwzPQzstOeTWjVHYN6DPWYSpagLDiVvjt7ymqSG55pk/6Jp0rzbI5SIBcei1QHlruDL1b1T4i2SM17+q+3gE9hlENxDIWjr4rXd/qRiEAbZgQG2Wh2w0ENEPOyoMlq+Jwb9PytCqpa+W/7pgr5Bm+Sa1OvcxtLT2X0bUkd5XoGkG9Z+90RzQUpreKqhIayM96ZOZ22wUR13QvgO42VKZAuVqDmoBbDPFoAleObqdLzSkCxmDsWA9D1PqNsltwxt9ZaJGMScbiwr0AmSkLUo4E4w9gVBl4phO8Os4aQu+EZOx7CHcRRYiXJ5bMcbAZA0DECFjIetwRaauDT0l92BXb2Psq2MZApGvfDBxo=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y+lCx+07aqelxwWCpdvlslSx6dcBFwZT4MPYVrE2pJ5SS4gsuiv4sWj+g2XFz2H+KwPLsIQNelaDjnH271xGYHuO06gilaCob/uU0cNyFSx561qpo7Ano/hyBXZXnepMLHmfWtIGFDy5uGj60vfHs72oP/u4UzyRHzHJDpy7XAzXBR9i9ruHMwNpbDEQJgtMl+x2jx4wfJNRv2LqQIil4laP601HLPWG7bAccS8QUgPpCa1cisNBwjbtRVuVaU2Udg6lqIewUzRBm1kjQ6UFI3KkBXBftq1HRdUkYW/oH6Q7mF2r6b/0+u8Ij5AxwD9u5uirMsbtrPmmz1yWt3aaBODPpnPNYlsH9T+O7MKHpvGyR/KNd/mUBwIk+HQszzJ7nduiLCJMo1VhXidFDXA0zUu+DhSMEAS9dXGoRBwuy/SvJpRYJsw6EdELoGsGdBny
X-Exchange-RoutingPolicyChecked: btoaDa9Wjpy/hsoeGGr4bjQA5vt1UWrd5/sEGiYlkSCNwYVcIOIhzzPhRhohq7SjjmE2z8keIVVX27+cxJmKsj0Pb1Og1c1DuSo1XY6qAKjq2NDa4uJ4lISoT4wAv8Rn51HLdwmELkqk+21hl77R/R57tz46wis2p9l+0+9U6SQrDgwnGew7OFrAS65eZwUa0256ixVieXKrBgR4+ZdIS0it+5ZEaFfdvX/NQtTes6exnkG/3GVvx+wrDc5rZHw79l4EmnWBMlrN+np3OwsvazIkcocV7iEActYHM6pK+2At4Efqq0j2+l10zHBQKWolxGFyJiM0I9Shu258Et2y+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f4ScDccIi/JF5NijCVsXuPt/RmVyJDV6BOFwUQtcQXp9PB/T0n1c7FBStoMJBCCk+Itgo5TTMMKllKn9CvQev3AWFWGxjnUGe5frc/MojJZYk4jliwjvRSOtqIAQkB3hrUwWS/ZC9LFBfjruVe6yD7ni5QeVfJW0UgNmniDGmIjpwVZkMek9d3EMQJHBYMaGmE02SE5H9yMSoYhW67b+luC5YOro0s43rsia8XgjesrvGiF2UPeMX+TrN2PyccOXYk8L2J84aWEyHMPJjJfcA50pJQFYJHXelnY2yw/YYLnT5WqXbKz40pfYxa7ZrRtiRYw75jePhDPp/EEYkrkxoHsLXmiSLcxh++Qgy71x+N2XrWNjOWee/h3zRd0PY5sGSlZnb/TAYElVyfaW4wbXNImNi0gMs08WJ81MqlPUpaJMjCetLfuwWuvXyUaTzWmSo+sYFuJE7ndVvGUNpvXzkE37ZqlAi3JYbeFYWuLz18qyjS91dIQ2pOi43bVsaiQi/Wmrw+y860l7704VY7qa6WSdo0TKN3AfNMQAnnTEBgFfSZQ+gl5raULxu673XWEG7OkmIUyQrZ8U2ZcUIJytpP1SfWmTBe6TTVSeEffQ/veBwEy3yLcxsIx43qX3z7ZPLXFV6PX8WNngJZGKLH4WDg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 01:48:57.2995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27656e14-1617-4f0c-6f87-08dec75b9a20
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5143
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAxNSBTYWx0ZWRfX6hefWIcFTqQ7
 7y1z58ibUlnPO0hyhgXcvBSiM9koKAD6xcksTH+Sb29cWytMIdCEOyzgr4yFfnCzGi5emlXbboF
 LgBJ5cplYV9BEFDnSYSy6JW6ickEryc+U6DF/WsJA8BB8PR4fP83
X-Proofpoint-ORIG-GUID: o6W0xWJEGNG0kSXbe2x1yDEOkgEYfrgz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAxNSBTYWx0ZWRfX/4lZwMvFB1XM
 OYISjXjNjzsqEqXotDIeY+KiGD28tgtzSL/BmuRGK8/vIwjrG0WAmuhLrM6+fpKwxHCIK6npC0a
 nrmzPQGOoEhPrxeVWQuOQKxv4SaJnOU9d6ojjF/NMIf9stGLzIQeGz1PlDMph1wVcQ+QQ2J/1aV
 ktLVFUmsyDysYlVAZK3OZrDguVOCZpTDsB6YMwIUM3Ooad02fA+40t9/uc0NUvIso7vgClMG5V/
 0Ynz36Kd2PtYTTp4mKc03yLXmd4Tp7KRqIXRh/CjSvFkeqf77ara8RqAQrXC8dy+/ZH0Eljm0Od
 EgjfP1SBitbc6YPqnIZ9YoVcBGtSl+ZWUDIUFD/6vvmJzgoP1ZjS9sIaowdlaFQnVNHU6i/4qNC
 mAvh8l54IGxxKbSBbDwTCsvNU3EO0ivlxVejX4+YgeBnafy+u0m5QwnkpSPFS7eEJb0HLFEC35a
 5U7b0eoDcy81K5M2BMQ==
X-Proofpoint-GUID: o6W0xWJEGNG0kSXbe2x1yDEOkgEYfrgz
X-Authority-Analysis: v=2.4 cv=HLzz0Itv c=1 sm=1 tr=0 ts=6a2a140f cx=c_pps
 a=XYu8HXWfxIrayFrXgJv6cg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22 a=NEAV23lmAAAA:8
 a=cbNQJ9GKAAAA:8 a=SLEbmKfySqE-5pBniPIA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110015
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

Currently, default 'bootflow scan -lb' will stop booting the board
if any of high-level priority bootdevs cannot be hunted even if there
are bootdevs of lower priority.

For example, if board has both NVMe (priority 4) and USB MSD devices
(priority 5), and if NVMe bootdev hunt fails (in an event of bad NVMe
firmware update), USB (may be recovery bootdev) is never hunted
automatically, leaving the board in U-Boot prompt (user intervention
is needed, e.g. something like 'bootflow scan usb' to hunt USB).

Fix bootdev_next_prio() to scan bootdevs at the lower priority level
by not exiting the scan loop early.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
The following patch can be used for manual testing:
   https://github.com/dmkhn/u-boot/commit/486bf2eba295126c98fd88bce6889a59a9c9f507
---
 boot/bootdev-uclass.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 3f8dc2c3c4e6..73c3f050c225 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -664,8 +664,6 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 							BOOTFLOWIF_SHOW);
 				log_debug("- bootdev_hunt_prio() ret %d\n",
 					  ret);
-				if (ret)
-					return log_msg_ret("hun", ret);
 			}
 		} else {
 			ret = device_probe(dev);
-- 
2.54.0

