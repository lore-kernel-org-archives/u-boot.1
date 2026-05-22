Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14FACD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 02:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5369E848FD;
	Fri, 22 May 2026 04:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="H+dfIqbp";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="bEX/0e75";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="mrvYSl2Z";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="NebwqFZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7566F84852; Fri, 22 May 2026 03:23:39 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EC58486A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 03:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LKEene3341712
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=T6y
 8b0aq/WwxODEZ7NfsUpFDy9mYqRD5OlYTDjGMmuM=; b=H+dfIqbpVb9duqQUI4z
 Skr4RtFR3kKf3mnT7z0E7pgH8zrMO5oW1UVF09EKeIac5MMdPLFh0tXzeGhHt5mp
 e8e+fK+aPzin+dlyVIn+CFJmOIhPsNPqOvnP+XbudyyKIMarV+J9KLZzfNg3Kt1L
 LHwjdZILBoFkALhA51CbcqhGjLmd4fMGUnJV1HksrkwZcQoYDqmzwz0Mn3Y2F06J
 QcRQxD5a4l9jgwnLcT1FJUTW8ccw+ZnwFqysJXj+7rqHFkco3CeLHNgDGOHb8Tct
 pbRtj2WpYnpBg/1p0JtKxJJEZ6Mj/E3bJQly4CngDw0SQHpuR16hgz4tf8hhLCys
 HAQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ea5t3ut45-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:23:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/BcHeELwkv2ghzoxumwdoZXr67yf5G0rFo5IRKT4pvaPgbHb+A1NmM9+Wx/ZBsqa7K5TUYabGr/YAUZbZ2a0jC0r5TFot7GAzh9C9UvhFMRZPx3PwSQxn9vLHERUITNYzmgeLi9uJ4j1yUEaNSrIohH9+GBjx++mLPpxUo8rzGYM8wBTX33Gvu7b7US4Ertdrs0HybvrhFGuSN1X4h2NFifSLx5/XQCTP2fiIfSdG39Mhtit9NOhSr3qadYDoXdcdznPUaxDByN2tiQPVaV9GLi4RDav2ccUZypvKiSkheh7efdryFnuirP65cxvXmkCq7YOyE94LmIorO8SImj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6y8b0aq/WwxODEZ7NfsUpFDy9mYqRD5OlYTDjGMmuM=;
 b=Ho68dY8S2S+qcLxdc5/P24BUa5jgxPhB5pUHUS3T4QS3vu6i9xsoSj/eNEUiSsGE5FyDonXSZ/u8iwYmzlXmHBl0TjYfAEoG9jApSN33HaXyA3A1q4QplDX8DtT5knqrqo4xRI4E+i5Gtd6WzAgNReY+cT9c9lx300ywiD0+V5o4qfDnuytar4T61cWZKVKU6doKCWmtjbB+UrZSQHBEtDInpk3KWuX1gIqyjWbMoUv1c+CsFU0WB2Bjt8nKAHYePpk7dzvHen6Pt6qgvNsHzaUvhY/J2VpYSl8znxeJ6Q+FuA+F5goqmSYRkSO2O43JXIjAi7PDHr72Y76TH/ZM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6y8b0aq/WwxODEZ7NfsUpFDy9mYqRD5OlYTDjGMmuM=;
 b=bEX/0e75TGMZ3pJammL5zfXytDNBMC4ecipi8nEeThsRwvPQwYE8v1Pwp6OEnhlcXwIeIcUSG8iZ1Ehh1UK5Qf13BRwl6MP/rVBHwjkp18qB8onPDj/mYKdv6hYWYHCiliv6cg+OhPOwCLkINpFOnsjb3MnIDBXGaGee/ht28ls=
Received: from MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21)
 by BLAPR16MB3666.namprd16.prod.outlook.com (2603:10b6:208:27f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 01:23:30 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::96) by MN2PR03CA0016.outlook.office365.com
 (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 01:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Fri, 22 May 2026 01:23:30 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M0fbME726296
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=T6y8b0aq/WwxODEZ7NfsUpFDy9mYqRD5OlYTDjGMmuM=; b=
 mrvYSl2ZjHEAF4xf3cF9o5ChL2hxbYGQ9LMp9Xq/QhsKaRhn4MeIXrfInmybmnrC
 TaPDAe8enuWefu9NelP6O+4W+2Ec/MY4aCXg1Opx+IgxIjKTnhF9DooVteIRbdjl
 SQRayKm/FxjekAdopDVhRaTbkoa+IsZB6NCC3MAo4WIIAXhJK/YcbaxRMFACggCC
 xK62qZgJov1LCBuCXri6lUyx4O/c0SuPQpHpdtUwzMfZvSaPJ+71R1FSXxdp602R
 EdOgHs+iXWBiDdaUAEXYzRD5qi8AC8PwzvZ5XM214r/wZBWs3lnOGsERa/6d1SFu
 4qeUyMZK/vredb6XRn2vvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=T6y8b0a
 q/WwxODEZ7NfsUpFDy9mYqRD5OlYTDjGMmuM=; b=NebwqFZl75YUGyNWNMJ9r8V
 LUD70hVYWFrUc7rmG8swGyeuMGDfQymth/Lzd16VObvpMUPl9XOX/jeKySe/4Jsb
 gstmUft6C3+GzbtKheBcMQxyuyIJBdk1VjO22QCs/0/u+3iKrJj0nNojkcioYc/a
 hYiwcwy4zv8DW/fsRRuRn177oUZOFNAw0WGcLAdP02Yex9j7xWEIuwSL8uQaq0fB
 /anx5zGzFfTFKa9pOmEYkbsHwg5h0KbCFkqX6YO5GZetROiqGt20m2FmX+3PN2Al
 BcaHPm2/dQyYpIQ7QDIqpA/07brp1kP2N+DcHYVuyY6bbCOkBYOVjgyhjsuAjcw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eactrg10k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:29 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id QEbmweV9lxj2GQEbnw67VO; Fri, 22 May 2026 01:23:28 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: QEbmweV9lxj2GQEbnw67VO
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 2/4] reset: Add explicit cold reset support
Date: Thu, 21 May 2026 18:23:10 -0700
Message-ID: <20260522012312.860026-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522012312.860026-1-dmukhin@ford.com>
References: <20260522012312.860026-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605130000 definitions=main-2605220011
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|BLAPR16MB3666:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f90ef708-e106-47f1-1d23-08deb7a0bb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C4/+Zxagfs+YTwlVGhOutTptFNL89Sq3CgfdiYfYY9yJHiljwGxBkpUNRRHYK37CbNbP8N1kRgKH2hx5OEGIKLSedM/4NCH75NW+G1hwyY/LGtK1GOxTFkjGq/Amsk9u8Rh2q5udYHDNotdefKr19EVE9lJr9854steVib6sUPzstcSQOL0g9cYgALQUCXPGLS6tNp+dWQb34A5A7oemRs9wIL8U6/ZzL9zrtJUYnBz/fBYHCzH/VQstJpY1EAYV3gllcaSKcSe0v/6kHMd+gfKKXZxwCpN0FIAYYDsIvA+9tvo5OfASn6bKK3U6igphKXLoHI1Cpw7Sg3ICnhR1s1G1IzrmFP1s3D1RI+8SSdEmGeYYyvTeQmknlpsb4Ti3QN0CA0X8WMYZ4fGjcGkoNJ/gq0iGxLVby8VtIMWqxbpXv0qnjqH8Kkaa7pPALt0OMkHHjvqOn/wqrVfkMZ8J7B85Q1ciIjt9AqvRVYV7v47fVSEyAV2OcHT5wQeEXPbCsXi23Y31EO06INhRFgEBPCpGY77mJ+vURMaFxDhYKYBCAEjjdh5lDz6dLs0sVhBY3zWi71tt7/Ju7ppcteXOcPB0PF3wODH9k7CHtzalxXtPnW9tPc+do+fwK9D68laASaaP/bF8/LHj1hB/S5KKdWE69mars3w9L7XGsa32IDPtXsnBdRDHtrhRUQU1BivCsj0hcswVmYJCB+aN1an5ejxA/nsc+OlzxQVXWovh+mk=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fDQtBiZ08XtP2rATYYgRKZP0BeWe6wYHxKfNlfMMThhMecayYKXZj2rDXDNjDNqFS7Lg1hcZyvkV+QZ86Oj8dKNz3IFujF7hA4kMMYOKQYYrW2O/W2/hO96BpNmbpjJMSeoPtgqRuaZU+o7VySMWuSKhkCnXSnMcE3LYwWaDc6CZpH1mg1oqz9JViP1NfxShhlKmkyCKYeAhubULtv5cabtgHZQ6wMCDayKC9Y9hLdyot0GoUHj0pZ/nM/vkET+gJ4NVEPc+CE9O9M4XOO8GdEaGsP8WGM9+xOysaKKd+E/WgwQl07bZdAoqWhEeGrQZBoeyWNC9Ph+OWumUNB6OVHotxYxGfp8+iyaSzDOQqFqu+stbt2+6huFGHdOM8ysTLr/ec6sq7y0b+DJxg6rGGu32QqCSfWGoytFo99OwS1rO4K4d7iXUmhhW585lOPyG
X-Exchange-RoutingPolicyChecked: q01BWu1EB4YYhJrH5UGoxK0IngXMvo+GCsGW4emBE7DpeQMdiUxHXYptpWhkdqteRRJmN0flOusYaj1O2X+oLJMgt4RlZWHZzxs5FQ1ckx38VryHP/iSlOBOUASk/Pilkse/v/o2cGZu7wVOm4zyA3UCWAyTMzq5FtFHkYQ8pMuL0DOf3JW2Uu5K8KQ+eKON05GNrsjMQwnz2y+/KQcb7cIU0MWDRejebao8P7Wf+LWOkXNoWhh7ia85EegH5VD9gNwtC2+zP7aH8guPXmTLhONDmSLUzMoKpzKugphquPevCJp7bkeXWTgQ52tJFLQdWjIBXdwtdVGiyD8P79tyVQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8Mi9rk0nNib+893oQYn6eojp2+pOdJN+wGueX8JM3Yxgrw9tv4HhTieey47Pa0bN9Hjg1jSos48RtdqSEij8gMmaY6QUeYlkDlIACz1P+pn3ndzgHQItB7monJMBy3CpnQeYHC24yVbgMO4qG7uoDN6e8dzTxHZIc0Tjj3fZEzwh6+m5hLKDPcCHO8dmg0RczHpiRzNUjo+JQXDx7mOEzLRIh0GioghOaRTNKeVKAQHY07dclZToPlbJlv9WDc5T7/fxx1KabCfT+0eewIZO1c6iHvDcrGqiIfoOSTPJdkvh9SDb9PtVpPYT3A1UmkiEH/ymfVEajyC9ocuuEw2/3xjuHcUioaKnle0cExNPGN7Izc0dcWeC5zFNw1s4sBZPZrEB2gQHmCVI7mWnIA62BVWN3cW899ICIEsXVKk0swPoWL5Hq1LYX0divA+77ok5C6ATjgZOZtEjm5DgVD3iKT32dQDO0EqEU0zyEpDUXbh9MCoIoWI049mTsCOzQL6d7FdYREfmzgJrp0Dw5ou0HZIdRXx7aMQBE727Gjr86dJh+sFi/pR9zDjdp7kBIZv92mqhKOrczrksS398Pe/1eLK7nexJTRe4bfcIFqAEnHSGWchgT7tVBiIAiZKpcyoq9/N0OJSgYS4N/Afs2BmIFA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 01:23:30.1229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90ef708-e106-47f1-1d23-08deb7a0bb88
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3666
X-Authority-Analysis: v=2.4 cv=YNuvDxGx c=1 sm=1 tr=0 ts=6a0fb015 cx=c_pps
 a=91TlPzG7kPfjcj/W1M6+cg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22 a=cbNQJ9GKAAAA:8
 a=LdR4nO0DR2EzdatjeqQA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: ogF98vZ44dbUCIR74y_9sBzMJtnu-3ez
X-Proofpoint-ORIG-GUID: ogF98vZ44dbUCIR74y_9sBzMJtnu-3ez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAxMSBTYWx0ZWRfX4EYvdqUvD4rX
 NfKxHXauOJ7Jade32J8D1y4nFUr2dBcQZg888G4eDNrXa9+MJ2Rg7u3Dg4Fde0mTrENdmKu/RIh
 pFCnq0AHXcC0VADikc9HvaM1dC5lt9IWMLK+F4BNt/XhdEKn5y0ZE50koOufnwTjU9tuuZ6VNVY
 KqwbR7aFQr78qc/SuyckimvC09V4ur24G77TLFfRm4d9wStpclVJ9hYNnf3zmSvK9oTZADJGxfx
 TvCrHboVdI0vjK/+1nz3D3fKqYPGZrWh3OB3RzRhAhehHGtPTuZPHI9DTxLh/x8EtJinfOnFSTn
 xZMipbMHlK77hPlvwoEQCY1Gv2lYJRCZRGMyNlVJC0UcFLlQv160nNc7P7oH4E1T7FqNHolVvh6
 VfHuDe6AldDyuMcu/CA7v6dKm9Rwo8OoaFG+38bPGvg0Ce5HgEyHOZWhtdwTk7AZSQ0KfD+lva4
 RSVy50YlksCRjNCbP+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220011
X-Mailman-Approved-At: Fri, 22 May 2026 04:13:03 +0200
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

Add `reset -c` to allow explicit cold reset.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 drivers/sysreset/sysreset-uclass.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index dc569a6b8ade..d893c74e9121 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -162,8 +162,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc > 2)
 		return CMD_RET_USAGE;
 
-	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
-		reset_type = SYSRESET_WARM;
+	if (argc == 2 && argv[1][0] == '-') {
+		if (argv[1][1] == 'w')
+			reset_type = SYSRESET_WARM;
+		else if (argv[1][1] == 'c')
+			reset_type = SYSRESET_COLD;
 	}
 
 	printf("resetting ...\n");
-- 
2.54.0

