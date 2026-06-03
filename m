Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D13CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51628486B;
	Wed,  3 Jun 2026 09:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="UPMa33Mk";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="fk7IYMmI";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="Gxqi/1ke";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="DnNEIojP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E254B848E3; Wed,  3 Jun 2026 09:08:08 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81F0848C0
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482516.ppops.net [127.0.0.1])
 by m0482516.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6532WSWN2715801
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 00:08:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=qlM
 jiio9/aRE57nari63Zs0tDRhqC3mj8fl20lvprRQ=; b=UPMa33MkyTrR+e1NXuO
 xhYOQ8LKYlnb4bcprag3fp73UacY3MwIa8yFVQujBNw95DzcHXoEvaPWibkE62pS
 d+r57sZgWYpSmWmbH+y19zX7pdfc7hMJMwxKARR/LvA/YNxEHbNyEo0iCA8fZNps
 COU72+/Kf30H41BPPuGXl2oln99f8/UD1WGbrl+g4zwRbke2l7BpJR8W/N+w8BkD
 HoHYOjjqZ6FzKpc7yUfwublPC1mvYUVR0mMpg5dwIIMCGup4mgOAcLRSwJ3BbOhO
 pjRTuN1oiRo1Zd/LoVohUtYbTIqK7129W36dGlcnf36DUddzhn7TWtvqDdhlL/H0
 +5Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by m0482516.ppops.net (PPS) with ESMTPS id 4ejbjws9g2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 00:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4le1FBCZKd944Gz8QGlwYsLcyMTSZs4NfE5xA2NmsfLNzuVrFXTRxKL8emHXmzL4GVxlWfqcZIqhwU4mh349SKOGKBjyIkOr//Aw5URxg5Stl+Pu6UeS7kSHxF2W4XbkVA6HiJATCAL/9AEEXePsJtKbABI2na3QzoqlL6Gi1bHzgBRrQCsPNW+aK4xRQ/wopLrJg+fKKScyVMQTYKZZTsfbsWxfb82YznCGy2GuBt0xPKEabI3XaA0mt+j5SeqoFIPLXS8jfLOJ5NpLjIGYrjWwvpWvOVPCzF6SJHmQbPU9239Uy4D13MdV+qvIRroEi21W87OWKenjR036fW+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlMjiio9/aRE57nari63Zs0tDRhqC3mj8fl20lvprRQ=;
 b=hexHRWlTPTcGluXtPFQqsxC2hfS+Z2nLKb15BH5B01sYqe1YrMsqKQlNP3BOzNWopIHX25yGaDk0U5GfSxu90MMqFIry0btip5Q5MZHbzeBo+yLabmOaSZnZpnNk+yTUYZ7pKMvhsFaUq6lRBwNNtg/AV8buk7R2JEKLIqqwMTM8qqc9956rJo3E/KPpJ4Bobxhp0NbpRi2WeetzGcKvT2Yqe0OU1c/DcLGneO2lNiwRKo0yTb1FOmJCpBOx8XKdS2Kq8wU9+dB85Wi4gCz+jtkNlXjcsfU/9zH49Na5jt70aKmS2paNotd6xoof0K5ZVbm8aUovzPCPG94fDfeoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlMjiio9/aRE57nari63Zs0tDRhqC3mj8fl20lvprRQ=;
 b=fk7IYMmIr213PFGCFGiCtWjokprrImS+c5UGwY9g+BM0tkkjHq4mldIoPuenTplUC2lfm6jmJAyMGaGURY919jfGv3Sn29LrdWFnflZiBdDHsgQ6RNEHCU6E5aMMNIgtUE103Oa89djZkmUQC/Vwf/dmO6hBJDoghA4idhp8duA=
Received: from MW4PR03CA0329.namprd03.prod.outlook.com (2603:10b6:303:dd::34)
 by CO6PR16MB4130.namprd16.prod.outlook.com (2603:10b6:303:aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:08:02 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::a2) by MW4PR03CA0329.outlook.office365.com
 (2603:10b6:303:dd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:08:00 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65337pIx913876
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 03:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=qlMjiio9/aRE57nari63Zs0tDRhqC3mj8fl20lvprRQ=; b=
 Gxqi/1keUzBJ33CU3LbP/BO9xDF1D4X/0eBq8AeJuyMKu093NxUr7bqM8tEI98EL
 pejQ+fEl/j/xulP7HE9eFTzHLsFavciCOdvWs4V14uR7i/svI5+gRE/PUoiykB7T
 tYTh40zCZ8GtLhh5kNRNHrLyUQzJejNjgUJINxY6MEtm7R186BkaOw2m9xSjg16g
 Opu5bQk7eWnsCNLRii8D8JVQkovLwwCODDj70pxfy84/gSFA7nSg5nlZjzZF7Uks
 4QNEQK5Go8qRBryK/6G2mJjR7fLYW1i4Me2L4+/oeS3MIhNfnsnyuSmGtHh7tYfQ
 dqOBRzwKM3mcYsJzuPEoFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=qlMjiio
 9/aRE57nari63Zs0tDRhqC3mj8fl20lvprRQ=; b=DnNEIojPcdnFeymeJ47s3E2
 CaVhH8ivxF55wHfY7FX1AMSKyrnIkwYe8JLJtNbp8kC6DQ6n+9HcMrQPB6+vgIOh
 F/+ToTQdyny2mnl1aTezQ5XgQk4cYWsz40OPIcoJQqyRnyysB0aG7N5kidVHxxC9
 gaRhz2C37BUbyhSmQPDGjs1koQF2ROmlm+jd6TeRByOaVnqNXYigdjigssGtNREK
 kbxwjMQwUCJNt8dFznTiv4Q2Y3sH0hCNdXZ/ANaE0mI3TUdAx+vMbO/zWcY2QPV4
 UQQQr5hp9+wuA4pPcjwL1e45VUQvIg9LaIINmVlyO5lr0pj5qhOX+WzR1XmdBNQ=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4eggrxvnmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:07:59 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id Ufhlwi4F8ntbrUfhmwADBB; Wed, 03 Jun 2026 07:07:59 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: Ufhlwi4F8ntbrUfhmwADBB
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 6/7] docs: reset: document cold reset option
Date: Wed,  3 Jun 2026 00:07:42 -0700
Message-ID: <20260603070743.1268544-7-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603070743.1268544-1-dmukhin@ford.com>
References: <20260603070743.1268544-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CO6PR16MB4130:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 14969496-2db8-4e21-421c-08dec13ed8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|3023799007|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZMOpOwgNQ7dBGKUUWH+GEUGkfXoiBdBzwgegP9kVTZ1dJ81bjJblcKTKPyZ+kz0uUcjNqBbXatEffCrt2ni/l3nur9dCOmpSn8FL/8Ez0MrUdtTO0umJx1iSAy46Ng6XIQZtsJVKff6IArK4xqjUR6KztTaFmErnfxIah54OE6Bwl1WGJvZGlIl2K/JH+6RukijgNa3bbX4t5f9zCuC9t8cueZKZ4forFu7vfLC0P0MEnCoQIdj8eUf40y6oedbuckQFiAoMXpTe65ToRSJT6H5Au/aAv2Ku/fpb8y+HsVGbl+YVyxIQTqIN5Ys/zIC0Q7twifkqPe8RuzN5aA8xgw00jT2TQTcAXTv9/B6TjS0txC79I5gQgZRz4FymJfdHB9Sc6PipOseVi/e3JQiKSeNbQDhiazF+cKVFlW22ICs2eTBTBaQhrrgQInDbdHZ03wn1WKLpXvIibl/Tj2FMvsW0xz4RbGrSGex6PArDeCADZxQLvgxjlIUynxiqdGSKXjNkwjLFyrHHLsQ6KnuVEMfbpszM5KGjDw8R57VNCP+yzT0zB49IFOP1pMNFbSugXsUUYYCl9zGvfKJzlf8fHpOIRUtdzN3qSD/8ysw3Q3js6UuNOZpth2Cc1g9Xh+zGnPL8TjXmi24k2vzfb7B+qlsZ72WAQIPfPhd0zQc7GRZm1EI0cTGlbpzhjUAE4qvCwM9RyT6KEREETy1/24qOxzEBTsuKFKXgq3gz1SjsMQ0=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(3023799007)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FE25SzLRWRWhzb/a1smG/tzBIN3naaoUDxswQwloREBHqzOy5prosOX6q3S4nLU6M6ZA1b69LV9tMfxy1iJh4tGETgja/4CJxVwFqADzJeqW3iJB0C5rBZBNeQGI1FTz6GQ2YZo56P2WqNYijkRT1qL0NOitEcsZGCTV+S0tDC1tCM7nwCT1Mq4j+F4/QM+naEZjSJAJdHDuoCdtKu/tVwXhUWkkX8JerCweF/ykbgyR2PVHE8nrQ2lhkZ9h+53WJjLZ0ewdrH9wVcEfHx7povGMSbFUwO1sRuI06EzaigWoq2ecmuhkbWoU60PD0aLyLLlJdePue5u88iJTQ5UVcQS1E/FW1HVP6NKf4c7nOpo/8Em1qWAre4p+GBopFKGsjQbhy5LjHdetjSwO3sqzByGu1oPbaLvliPMfAsI9s+tDdzgn4c9CorVzbYjvrrzv
X-Exchange-RoutingPolicyChecked: oYzsVUzJ5tbtTgimhlOg7XfaJxcJPxuBt/aI0CoQbIPz5K259mPex6DLStNv7BFSxsnOohLxRNEOEXvSQh/c/BJuQCkKI3cDVRflcC1x8BiIKlY3td53mXcMv3wDC3Np0vydCIL9Cz7EyT7GWTT8aCqKmpEE8ly/vPndl8D3vjqYcEhbN3jT+FxMCToIhd452GVO1FMCrfhkTrPu1EkEd/AFzEmEJ3TEHP6OMS24SC+YpY4uP4h6SIDDs1Q2nRgzMgblP+bEDLtR4oYQWkdO81+CkwRAK7g1DFn1PqjDAHuft3RizIt6SDHRGZfY+h5YNQWySI1C4nFlU8tAezj+5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vv6Ljom0sEmfMEVkAgYRbiVze7+kx9DgnbS1TWhXaEoH7limHY1DYJYiVxQmttHAD9Yre7tUdH3BxU2/d7S64GgUMNp5sMWxV8yQduxEOlWQED+5ydXTxW0NQASvJZLMMsaMzYeMe5j9mwhvY9TjAdhliIU06999KDjjDfIEfOPIC5q0CJV/8hzJqDM30R5QmSVMnSgpUIFAxI9TnAp1YRf+vdYBBgJawTMpOBcc+njrBhZ2lTeYrA4jVGoSPzy4pQWYUPiBj84eFGVQGSgtqWZmU7rWGj7evRHv9u/w7PtnK+B3OcIkTLhailMKkTOjBxuzBVEMVUadUyYaK01GrLc6N3oolbc8W1c0ZD9xnxBjRe104nAVocrLoci6+Qz/J51s6IJhyGCs8T5HsDLlXJZ/NUuujngMvfUX7osY1vdeam0mg66Vg6VNCpjaM2ca48RZOPKvJzH8laARlabKpGJm4QaTXSrmrxlG36ypjmHaj0zSuDRQUuWyB4vjSLxrU+dQer97UmGjoLzqPbwF/UYYvlRJl17e86MtF3cccW30jWNQ9eX4/ve78crnjJiNvsdyzdTJdNSnCdzCCpZY1WmTHMK7cVuOA6yt6gzPySqbysdNWg5ggfhyy578T6gi
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:08:00.3368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14969496-2db8-4e21-421c-08dec13ed8df
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4130
X-Proofpoint-GUID: FKAnxoR9Vd_gsnv7gr57tJYc2Ta3Sekg
X-Authority-Analysis: v=2.4 cv=H5TrBeYi c=1 sm=1 tr=0 ts=6a1fd2d4 cx=c_pps
 a=H8CAifLk0DAaaH9V+JapoA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=NvsXeTrgx-CJMFV-xl94:22 a=cbNQJ9GKAAAA:8
 a=sAash39LQVnVe-2busYA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NyBTYWx0ZWRfX+jJwzmg2xb+Z
 SoaWWb98hhlynGJkRvRrdva8PGWL8qUTltIMkeHpc1Whs62vIED4MKswa9QDM16KSRgqhUKECtA
 yrx8/CGjnIm0dxKtFUyeYrXoF5geWhJfkiYVj4RAQg4Qdw98JxJM7NtYP0b4qD/mvhAW/pFC/O2
 wj70fO+s0re9F6ANA5hATM7Xf8e2YlkGBVKLNS6Oa6FibmsRT9Zgg+ocDVlDPvAEUOjlw8t2Osz
 uQ8Si3Hfrd9+Ca34XCZxYStSM0Oo6xn26yeUmu4bPfhQvUhkvnyXtePwMq8Gua5QpgVK6dRP1A4
 60455VJSEhrV+CQwKyi+PcFkKQXEpR8mafPs5vKq4hWjhBX6WFjQ8UxqJ5BIK76U8nWV1kg3PQe
 oIAa+It/B0Rt9AgprPhmINYAaEj1Zysmpr7lXf+nm6l45HQQiG7zct+gT6DwT59vhkPEwdGFwiU
 4I/rosS8N9glMXJea1g==
X-Proofpoint-ORIG-GUID: FKAnxoR9Vd_gsnv7gr57tJYc2Ta3Sekg
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

Update the reset command documentation to cover 'reset -c' and explain
that the default reset type can be overridden through the relevant
Kconfig choice.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v3:
- corrected description for reset command
---
 doc/usage/cmd/reset.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 79bc8b9deca5..660527d0b8f9 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -11,15 +11,18 @@ Synopsis
 
 ::
 
-    reset
-    reset -w
+    reset [-c|-w]
     reset -edl
 
 Description
 -----------
 
-Perform reset of the CPU. By default does COLD reset, which resets CPU,
-DDR and peripherals, on some boards also resets external PMIC.
+Perform reset of the CPU. By default does COLD reset unless overridden via
+Kconfig CONFIG_SYSRESET_CMD_RESET_DEFAULT_{COLD,WARM,POWER}.
+
+-c
+    Do COLD reset: reset CPU and peripheral/DDR; on some boards also resets
+    external PMIC.
 
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
-- 
2.54.0

