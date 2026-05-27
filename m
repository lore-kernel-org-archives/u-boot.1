Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03052CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA2D84886;
	Thu, 28 May 2026 01:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="a8Z3bNeu";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="DNhPoq75";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="V0wxKg9d";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="NsuF2Zng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46B6848A6; Thu, 28 May 2026 01:13:25 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32AA847C4
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKht7R3964395
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=BOYSpXWgBNptHtJqYn0YgraJu
 lpQOq0aa02Wy+UasSg=; b=a8Z3bNeub1Fob5Is23qjMBcfEvga8wdDpEbxCOMJY
 CnyyVCDyr90BKbPb07VDGr3Cy51QH85IlOHdPVSOjExpeH+crpGlai9K8quARp2c
 YFFxiAbP4d/5hXB8EoiHKLa8IgoBY4D36z2FrYP681FxA0QfrSZqAZs07W8lOzGQ
 6/UMUU35ZMQRcGG0hgtlgBeyEnv+I3vU7Hzm/+aAwz26L9D+oxXSScbobPso7reA
 6aevkUvQfgszUlqosX3dkL7IHuwCkS5Elo+4V8X/50C6idj0KluV5J391J8pUAj4
 qVuntLXh8o/6v4dA520NGk5OzLGAFdkEWM6xaOKLXtkgA==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7wj0v2e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:13:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoVBCnvxZAv3xM5MYF0Gy97RPPt8VS8GG1hsypyPQ0Em6ytyqPLQW5u660Zbqu8uBU1KsqYAXZem5hjKB9YiHLySIoQoJqGjfe+CpO6Hg9SmpKUtoKlXa3QtqfqMThb6DqMi5EJmDajXxFpNflMZH7AnQuVILiRc7sM7NnFsslHNJjHLuG6f+ZPajir459Kp85mfWe3xNUX50HZC1zEAf1gAU28LIyXXpuhX0eXLt0VQfGHQqbefHJkoO8jsnOR+jSRb6NvN8xNi8nf5Tz6AFKzrc/yqvdNysJ9y78UaxItCLI/13aC5iONS19v2SOq5iPy8Q5Ebdxr91vwN1GncFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOYSpXWgBNptHtJqYn0YgraJulpQOq0aa02Wy+UasSg=;
 b=rywoObWQqW1z0ZIfe06xdzEE4tjG9e+Rx4WSeXcHgYqFxrO+FX9Jxom5BYKKkXowz20KNPNTq0vNF3jc3D8WFigEky87FJjuRrH3OGU/2QdV1Gi1ifC3r3Ags4DDWEDvOlEKdUzSVmc1/n+i9L5XA5x7kL/sFrhTRhirFOgtnbo4k1EHDJRQqOv9BeHu4W261o76DcK0Mzxa8VwffmNH9xss5buZji9DE6VKzm2HyQ7P0N1wAc60btw4IdOvPJX9xj9fL6ES5VRZ8GCli7m3m9dKp94gvgVqN9mPav72pFv/kggnWl7i0/b2/FNOZhKBq7bAZEtLSEJc3BvCP2fdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOYSpXWgBNptHtJqYn0YgraJulpQOq0aa02Wy+UasSg=;
 b=DNhPoq75syQNvpyxTbYK5Xc0h7nYFuYYCI9UaErfXyKLm6MA7TfaVMQttcJL+7Z7E68e30SjNzQOvEHjenrk1F4J5Obb3IlmWaOmFeAz+oh+fZAIVeUdzIG7T+GhYMCElQN8/4qRPVTh4TAuyZ5e2QoJvWLs7PSG0SXpgV636mc=
Received: from SJ0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:2c0::11)
 by DM6PR16MB3942.namprd16.prod.outlook.com (2603:10b6:5:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 23:13:13 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::7) by SJ0PR13CA0006.outlook.office365.com
 (2603:10b6:a03:2c0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Wed, 27
 May 2026 23:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 23:13:12 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjTIn3452359
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=BOYSpXW
 gBNptHtJqYn0YgraJulpQOq0aa02Wy+UasSg=; b=V0wxKg9d7gC50kahZK9a3q3
 jdErPJ9ioWKcM4Ts7dEBNjm0DBo+y1dkxLNXP8jjJo+e69ryy6a6L3mi3XYUIMmu
 SXVcndVaoAG3+xdiLyiFVxXLl/0hpe/XIU/BffcbVOPbPZURIXd/J6XM9MaFCAb7
 nwUXYsHt8Mk8LdAJ3uhXhY9Ta0ytm7BA1yWnqPnNnZ4GnOusNnXnk5QVZ1LcUpR6
 JLkFPVZq9E3Y5zLfnoGqygNzwmUIgj3YRIETr1QMopO5Vg/1wHgq9N2A7DCToA7d
 PXWuLVr00of947BwHnPffWH/SOvSmoXksN6JWv1ZXbfqS+H2zkWavZIiEe012LA=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=BOYSpXWgBNptHtJqYn0YgraJulpQOq0
 aa02Wy+UasSg=; b=NsuF2ZngbXQvFgdRd0Ed9cCOKZy2WERDPRU7s0krNENop9D
 lvka6+4JLKwfmUdLmjY35V568AjSLUreKhLyhz3FtYdgFQug4JSkVVOCR4PN9XMT
 kFJrYwgUXJPgdCgKcIpwQp1Wl6N22PxZMaeFTu7CSgU9Y1jkzuqeySH6zTv4tq6W
 T+TCHHpYYFkvGdXc7L43pYUAQlhMeKWTZMO4ANk9fu97dbRixt7qmNEMdza2qygj
 TLa3IRIN51Stq6ZCJMc/137qHJYXJM9b8HysjEbXh1OS6RH+2Vp++fI0a76zzVIu
 vh1CUD0UGTYU2lJRLytWwumNv748URcsHYbiJmA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x88454-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:11 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id SNQywwXSyhUj8SNQzwttIF; Wed, 27 May 2026 23:13:10 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SNQywwXSyhUj8SNQzwttIF
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 0/6] reset: add board reset type
Date: Wed, 27 May 2026 16:13:00 -0700
Message-ID: <20260527231306.1714741-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605270231
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DM6PR16MB3942:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e26b5ea1-685b-4f0e-99d3-08debc458648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|3023799007|6133799003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5JE0+U6WEIcGPtjsiKlUu1quuBbEzdYwqvTJpETETrCgstbR8HzHPiQCAxfYJt1ET+STqEko8yd32xoWWd05xthN5prqd/fHdpEJL4XkA+3+uG7mJaknF10I8mB2lQjezsgtFy7RYmWKlX7eL/2q/kO3tQtsXfCfY+lD47jeB7tqo92g2Bj926jHzQTLa3HrPfMm8VtCip+jM0UTvfyyOYZf1yrfIucsBlYsNyep2lPjW2qe2FPGCR2BwoCfJIXWx+1ud1xWn6eck2uN7LdVRdroZjRCCMiiOgZFrGqv9EsY7ICEhmKBb9hRLtkZUxcpjhC5b3meD8xxLVDmC1kTyBREakhznsG0/SEyOx1XzXseHbPA6XeN3qugcqM6Y4HDwP7Bio8R79XmJ3vFuI7ywctS0F6SVeNPx+XpJJkmaoD+JO9dbhsyNSC9G2yzXRSqTz4a5wSYSaTHY4sj07il1tRMJVAbtceWJp+M6XIy3SldYoZ+3gzI+vJd7wo8x5p0iGW1ZkwjCBnVDfV+SVji1sjLKkntjpWzHyMfxdfLxQJ9cKc+PEW1PSfEdLet95JOFybMkde2LFrgNtv9QxO+1rTWqv36l1fnpauO+9CoGDUoIyCTsEkd9VuhCSkskzwh1NDLoTyH4Rv+pXgdmOFfjyDzT3O3W0HepKrwolUg0dEP2l86UAc9T1AigSCs92VoQKxQEGEmndSy9vZQ41NUmnDADd8cibRyYlzF0qIerrQ=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(6133799003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V0fkNpNqSKj1QBsxgPe0UEuLKv/x1mALGgJ3LMX06KiDkO+n3TD1Lg9oFbHtgcSn0PDsQ/YQP40523AIXfwanzq+B8aoCG2VgVspNW/k29ZsTt8H6m9DfKCPtLs9medf6It6vb3hjuwO4iGsMBSP8UdGC8qlfsT43myoDjpdWG9/SVinO+OJzIZt/maJKRwYk0Dyf0a+s2HjgHhiFowycrGL7uV0pjXKizQesrvizK6p2gw+DJLQJENCZm2wp7h3d8yBR7MKICMOg8GipTDqRPSBT4mIfqV9PPgJ7UaFXCLn4tDEcHmdd971ljRTXK5PD3As8h4nKh8yEO/2udmmUBLSRRYkpIsO3U4XXGCBHuUUZRI1yKots5NIo/pju0XtvZr0UI4el+ClYPdHztELeDtJKnG0Ge3cNAZRtNRFR0AWlKBLjUul/xCq4QJcQBMV
X-Exchange-RoutingPolicyChecked: istPCML8g2kaurMZ7LZ2yTfeb59qSWAXBkpADV21A146PAE0djAdNnVL62GfhXChMzYLavs4kosmAuA5mfaJJiUnR26ozU9hH+8Pfu0QxrzLljTUhmIihbmxloKFEfbHs8pQTsggd6NvTQEWfizPOLhjvGlvaSRSpriPe7actrUAFCNQDOjl7l6CSve7VjdBo3q6ahgYzWYqjdbp9SuVMiTSCnRCJQ8tOrZnzGsKyc2LoN9+WLIpgfe/PzUh5bgYMZ2eEsADtVTngojYK4KnBKMFvP5M7oPiXN1Em6t+ZUXCaxXeK56kf9WayAlImSF1chrQKiFGhl4I3dXnfdgPKg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rBzsCTlrdOCyPfmKgOx5idd9pV0yoBEd51N4icsX07u2syLtRw5UoBjMMjFAcDHtsnoaK10mVXgZWXBAUgBG+XYo2iqgFjzrn7v1kP2W0Bz2Z2WIOITg0T8ohw8PZVvNdFn2n9riAC8N25iHk1/maTWkhdYeZfIr7NNVwonHQ/D0EgAeYwVP1afIi7Am+ZZQiGgKKuZ/LX+X3iVZW+/EPRXt5lPe3vHSfUcCDCSoLUWhQ/llvokjUUiF743SxcnkomCkFt1C568T4y0ZbIpXaFImdiuy2mpi0ffIYijwrGltoUuO6Ae08FyJNmqNPNFLJl1sazn8lRfzBlVYSPYNvDlWChjGVjw7VlAwGM19ua9l+WrbEsM9AD02okJNrDkhh4PCH2MH5fgyOPXDRpCIDA7KLb900YvupLbzrn4+G3WdqGtswnS/nLcHufdDKWsxGnnPUK3uZi1uz34BAlZYDT5xWc+H5vhVW8Sd1zrgtZuq4EkT0t40Ddju3zkl2m0/ybH54GD48lNlNPjIe8p29Orqyrx42gWr91Pne+WNeAMiKNsqTp4hH0SXO3UiiOPMRG12Ll9o9kVHxAqX6fubYSq5b6a74RLf6X6Thv/P8qsNOIBtTKK7pRaF1D6otDzv++HJi4aZZkrRa1gexzmN9g==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:13:12.2619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e26b5ea1-685b-4f0e-99d3-08debc458648
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3942
X-Authority-Analysis: v=2.4 cv=VIntWdPX c=1 sm=1 tr=0 ts=6a177a91 cx=c_pps
 a=bo0f5OQ5EW/jR9k4kEC/jg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=uxji6CV_yUJ3bus-NR4A:9
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: EgmYnr60bCV15LxY3RZtPDee3Fuhcezx
X-Proofpoint-ORIG-GUID: EgmYnr60bCV15LxY3RZtPDee3Fuhcezx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIzMiBTYWx0ZWRfX3v9tIcszEKq8
 /jpFTDfG/j9zDLlyeeVzlJw6UqpI8wM39NsnLkeXDbHm7MkiGxvNlPQLuGpPVhVouf9DSkAq4xU
 ClRDqVNdLj+cCMbG22A2Am11vuWu8WpUDFVwdkHKF7+KpceQZxul5mSm+/Hjrci7oX8gY0wwNVS
 oG/x4P9LOd5fDMsjYGP4nHBpNs1KXknPmncafwvvi4V2qOixS1J9jInd+Bloa+WpZznhg0QmDgi
 rXfIKfPCr7jbeDJTdxyU3uGMjs1NeaoeWmJ3PGoJJ3Cykhu/HLmwC6SYs7/b84lwQLAsN78daPm
 oub9WbDeUKSnWyMamfeWDsiKQ9AbuXBvFQfcBb3+6QLjZdhiy5CLb3c4y/7zFbeis7x0SIYMfs9
 St19S+PmRL069j7XJVShrya8nQipoQiw2sYrsXZDGRGj9iA8deR1bpWW/wt3tAdqq4Tt6hY/8VN
 AyLex4RenW26nIjsKkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270232
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

This series introduces convenience functionality for prototype boards
where reset is not fully working - for example, where only warm reset is
functional, but cold reset must still be enabled for the production
variant.

Patch 1 allows per-board default reset override.
Patch 2 adds `reset -c` support to explicitly trigger cold reset.
Patch 3 adds reset type printout on the console.
Patch 4 introduces a small fixup for the x86 reset driver.
Patch 5 updates documentation for reset command.
Patch 6 updates reset command tests.

Denis Mukhin (6):
  reset: Allow per-board reset type
  reset: Add explicit cold reset support
  reset: Print reset type on diagnostic console
  reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
  docs: reset: document cold reset option
  tests: reset: add cold/warm reset types

 cmd/boot.c                         |  3 +-
 doc/usage/cmd/reset.rst            |  8 +++++
 drivers/sysreset/Kconfig           | 31 ++++++++++++++++++
 drivers/sysreset/sysreset-uclass.c | 50 +++++++++++++++++++++++++++---
 drivers/sysreset/sysreset_x86.c    |  5 +--
 test/py/tests/test_reset.py        |  8 ++---
 test/py/u_boot_boardenv_sandbox.py |  3 ++
 7 files changed, 97 insertions(+), 11 deletions(-)
 create mode 100644 test/py/u_boot_boardenv_sandbox.py

-- 
2.54.0

