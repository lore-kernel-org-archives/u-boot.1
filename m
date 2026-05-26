Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58B7CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 20:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10569846BD;
	Tue, 26 May 2026 22:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="LAwdnT3I";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="PrfzyU+N";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="bSPMx5cn";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="IKUpyI48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F41D84855; Tue, 26 May 2026 22:56:24 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63F184659
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64QGZgOZ1320870
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:56:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=EEsIiMEz4zMpoBdcr8epyL/XBV/
 Uw5Eyn9JGIW9poks=; b=LAwdnT3IjdwHBH7YMSUZ6JNffDSFWWgR9h5aKKps9q+
 eEs5QjQnlVWZo+61rdTX92OIw2r3GaYe/DnNEtzoJMpF3zhZ/ecrlNlMtrNE3tQH
 vX1koqwY/n2G9MbisX0qBFsUE9+rbH5xH33Mv7Lz6C9BkGtAjNFLZsz9Szzl+cOZ
 eBU6hIeWI8ssuWIIA0MepvAwsbtjcJ6ked/604scVBW+5DakV9f7EKVI0lWACm6j
 zuTf2lMowNp931bxF4YJV8PfCxrNsYTx5O2fd+pMkexmh1KK0TWAmx6dvIhTntDF
 k9TDiM6bi5vEwszJQX6wV85sMy2k92ZmYG6KKqDYkNA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by m0482517.ppops.net (PPS) with ESMTPS id 4edf672985-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StTRAiYR6geyGaJAZrIZoJpbXdeAqJz8pP+MOA0u5mf1BnyisSxSLrMkqcwknxrIHBz56i+e09/2EpA35n3eaGPrAK8pBDdy/2zACPO1h2ViWq+cE2nJV8Um/IANkNT5i2kvEAzDFznoJi6sgRJHZzR6+IZ4Acyd/10ik6VCbexFaL7cviCRtFz7Rphp7eWGft/5U/NasHp9wihncl2X6MnNs+AMSFgJ8i2ISfp5n1XLLVPVNqyNMzI97Va1e1nORoC5P0kNGfgWxQB7MQGs0xy9Glng7Ymy/z3WQiu/pWU1SiCRk0iyQSX80sbV7RYlrose8SgTePr20RSt1fwf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEsIiMEz4zMpoBdcr8epyL/XBV/Uw5Eyn9JGIW9poks=;
 b=CiegKPR5pacR/6bmwrS8Y/1131Ga0RtM7RmszdvcadIjTyzf/iCeolUN3qR0O2gl2e59VNHU/une6viCI+jBDnzMJmkz1NOl2ao0gkiw9iNarTN0x8rVg4U6b+xkpPxi5cIPIk3gz+F87dhZM4w+LzboUs0I2R+ow0jbgw2t+0KjFS3AUP/Ln1itIw/cIBODg2HnzNRdjgAFkLpQbhSWIZP8ADwCz1XA4otKvfI9rrmujGkqHH41UpgV6K2f7tzX/zKy2qItP7LbM9o/6plN7/Q78lkJlf4hyY9EcV+mxWV9nAm+qBFihsyqbY8N66vP1nDgL135WUN9Y2c2j+NVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEsIiMEz4zMpoBdcr8epyL/XBV/Uw5Eyn9JGIW9poks=;
 b=PrfzyU+NILaUwzdpOECnlHgLQzOHaMUM7BiwbEneWWNQBEWBypMh/wLobV0MRrfuiq7kBky5TDAJPXY8MnD0NSFNbC/nex8MDU1yeHlWhwMr3FyJfFmfCmYzcO9gDsfizbcDIqjF0MzR2Ibz+w9/qRv+WFTB7g+TqTNv+BCDoNQ=
Received: from CH0PR03CA0269.namprd03.prod.outlook.com (2603:10b6:610:e5::34)
 by SJ2PR16MB5872.namprd16.prod.outlook.com (2603:10b6:a03:575::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 20:56:12 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::1c) by CH0PR03CA0269.outlook.office365.com
 (2603:10b6:610:e5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 20:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Tue, 26 May 2026 20:56:11 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QIpAZl1602106
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=EEsIiMEz4zMpoBdcr8epyL/XBV/Uw5Eyn9JGIW9poks=; b=bSPMx5cnt219
 aP0si3+ukcBXWmgat3unCVruWGFtJTBEPaqU4Tg4L8X5s7htWw/yc0zGG4cMxa1b
 LNLEB+TKpHV7hHwlC/yhQi6C3kphSGRGzNMOtnrctvjy3DSj+bqba7+3sJvlTBgf
 nG1Wsn7CRAWchauB851cMQzZYwNkTUJ7mvqsAc+bpiIkoiU3Ko3Z3odXEnP7zxwI
 ic3ujaw89sK78ynZCJwDn4lpfi9ocOG71SOjZhP813ztyHlseN5dfPz9wAfMBSFr
 KHUD6+tluKYYcLRk0Ll9X1Ab9o6OAv21bDjyI3Hcl2ALJE3wJGBiR+0VuhEx3MV2
 BepbGzmp4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=EEsIiMEz4zMpoBdcr8ep
 yL/XBV/Uw5Eyn9JGIW9poks=; b=IKUpyI48+rFOwkZuuJhSC7XzeVHsvWBkfXlo
 Fy+bIKvqGFNfUTV/eSGsbtIVVHv4Hw8TGswFueBL0+wJdWzv6in3cnTStLk3xj+r
 W9PZ05T0UMarj2HbY2mPNZRwh4F68F2oCpRwR4LPv3NK8bk2B8zc+q+F7pGj0WJJ
 OtPKPmu5rSCaxIGBnr6owjiQtkQIeIBIFXUJxiiyhtpj1JgFnvs5sSFkuLE5+2wb
 0/IUQ4RciqNkzZmVZnrYHdldHGLKsn3ot2gkOWacQt7Gk0pMt72du5AkeIZ23DNz
 mfi4C0bl21pHSr9m2iUcNyUamkQpgnKmiTPU72bPw4PDIJf4XA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ebw3x38uq-8
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:56:10 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id RyoqwXPYThUj8RyorwLDpJ; Tue, 26 May 2026 20:56:10 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: RyoqwXPYThUj8RyorwLDpJ
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Tue, 26 May 2026 13:56:08 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH] .gitignore: exclude logo generated file
Message-ID: <ahYI6HY10Cbt0fAN@kraken>
References: <20260522024227.2950976-1-dmukhin@ford.com>
 <CAFLszTjpCKUj5pSAKn+0V2mmK67gtJ_9z5VwVC7ur_KWD-dYgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjpCKUj5pSAKn+0V2mmK67gtJ_9z5VwVC7ur_KWD-dYgw@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260184
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SJ2PR16MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: d76ff4a4-4e09-4196-853c-08debb693815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|22082099003|18002099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: xXD2eju2tHF7/0awCUzJ/e+scjojCPn/nXGsiP22WnQoKMEU/9wssU1scfNZoVcKCji/8+GWnP6zjfVQursXZ2GTGQjo8MjgOpYSnjQEKyLXc3aTrIf5BnWUienz2D4CzY3Mhn+x/hZNub6o8RBR07+cNSA8i8ptgI/0nuS2f1LdruVNwOlEgXNGUWBRnACTGPYBGqVb6FCs1xcxzBzJiQCXuTWMchAn9iQVIi9hf/tknlduQti9IsXadcevkGJ2pZ9OOWh7pviY8X401GBPsneXT0uetkfdY14WQx3XWucX4KkElQVA9cHGdEbA6ITkEOnNFXdvOklBsB+6jLQ5ZTZD9IrLGTJBOViNBPYbVe6r4W2+nYyP54IQ3HKBCzYNkqKD7qPgnt6MBHz4dGtiezYYOyXp/YEKMuJBtza/s736u9AxbF4KCbKmBjr9NkWiH7S/0/qs642wnUnR4lZgDX76nq8hMWufMi8PVZ723OWZccufLjj6UFOA22Wa9qJ7j2blbdrj3ggfdj3665pXX8rxB2J3MSCn7Pl41pJf8i2fbzT+YnvCYAmYRS8Id43ogLaWs5bFG7kuMfEd5OTHVsdKE/UKkMo/7aO/Rv3qfrT4cPr8WZDeW/qW7me62cu7vHfcuJLsSkGVpSYphzx5bVaISSS7hTowRAwuyXDxQNZTJ/sMe+tqXWMf1KuoZg+XUQk3tj++aftuZWbbx1i74zNXCIfmYZvxoERTUz9/9lM=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9HugtMjVtzxHshETckCMHcIVP6i28DugsrNeIen5MmPw9Z82aYlwp7GKNtZfUJ71TISH/O9USXy/LN8ktZ5WCXiw3o9lxey+9KN3qLJ4cRNVv/S8madUvoZk5fva5pJaeSlDcVcY76dBs1gQysKJy4hW+R1P8ce9HDsvwX2EFUllraEq1CzXpCyO/fbK4oTNhe6GBEgw5Ve67sVFVIXIGJC48MdS9UNChKgBDWll/Qz+odVidb3rHUJXsGUpDXXB/vFQBkrcnZcHaMcQD4qBK/SLctk53SpgA19mPA8nnj0uEF0baq6C7oNUV0BxorG+A0gkEpOK0C/L5nWSrdkK8Z11p3/SjoqWDFnHED0l+5x/y+pxoXps0GaLukIF3ykfxg8AUmysOPW8I4IOdVWFomYl1WDqY6uIlzDLp8/GIoKCRcLi/a67Le3CmdexDnuj
X-Exchange-RoutingPolicyChecked: lD11yFcf6OhJBBXaERU+2gOsDppJKwi/K0WJIxHsmTYM8GKdIOJ8bRJ9JpySZdtI27i5M03jsNARoZ0GYlYIoTZc60cT0/bWR4fqxdOM7ZdeySnDgk4X/ogY/iOz2peTKTdIKdobsf5vZs6p/u+rxOCaR8hdXAPqpeH22vRvStJzr1X2MnqZQohIyL2ou3o/ChkmVkjU+9P/igrYUuVhxZ8F9D2uOEDzsZL28DZ9ri2Zray5zenI8RMOH3uau1zqnPpJWL59uy9mOWgn+dwAB0C+0JNP0rE0Ml2GnVvzZmkacP0CnqTBjPNPCxu8cGIt8P1LUsUlK3JPrdn3Nh5IQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EBV8Sh3G8RinOS+V6GLNOlBbqI/uHHsYiDybuczpU5or5yk5feuiojztL33VPPLozs4C8sbDmgyf0PKNBximmP8wI47OO6IKmt7Ag+eaqz6Imkk+yvlvgapzhxeh5Ii3+YXuyJlR9XUJMNaZB1VklCcfzUfs7+g3I0HFf6gVDru2bW/8yq3GJKCFs3U70Q0uW7sHjvn6JlFG9CEYMXdzzjek8cY1YlS3+56IK4bHoIoh9jyuv8aTRr1llcH2IbApHJhjrvtsb/M88KMS19mdftcyQaSJJg5Q/sk4nScLd8CjsZhGVFe/5PMShx7IPREVrgOUubGsfFLldCee/IQCUuGBVcWUh57uVzHUoeFm0Me2F/S8aV/O2KspG2dDigOFsA61eWNAVOCiWVOPI8QYvGUc3I2cw7C3xxN1muNcQROHYDEiwHw/9DTPtRWs6acu7LFVhVveRoL7kjAMTgJRptrAsG6RQ2XhP7f3G43hXN6tF1jeC58zyGDq9gKuvV+k297YEs1ejv37eY35a2FlUO+bpW63mgnqMdJ+Sg+BD7iWrHBO0VIPY+4fO4sRRwPC+2s4CvjcySXhmSd1pIDMVHUkplM8Mei+UNxMGFlsiSeLcmX4+Pk/TY27twqb0sjSHFYH8be1Rr2rka2yBIhGLg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 20:56:11.8148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76ff4a4-4e09-4196-853c-08debb693815
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5872
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=6a1608f1 cx=c_pps
 a=utdtqqQbqC3rwi1NYZt6Rw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22
 a=cbNQJ9GKAAAA:8 a=cm27Pg_UAAAA:8 a=6GvJNG4tGP9q4DqbrToA:9 a=CjuIK1q_8ugA:10
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-ORIG-GUID: UcfTlN7FezUp1rr5ofi4XA7QE5-Q5BMz
X-Proofpoint-GUID: UcfTlN7FezUp1rr5ofi4XA7QE5-Q5BMz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE4NCBTYWx0ZWRfX6AdtXhK/JjxL
 eczgE/ksOdWuH1kdeKW99i1jhmSZ4NwAkm/1HST0id91qTAlBcjBI10v97iCwMkADqlOpIkNkYE
 NYIOBSBKEePcXSa6E7Q2aHRAM6620ZzZm79Lyf0hCSBUm+ZderwdlyGet6pCigHieFKm7cPrSL9
 ILfiNk8w7UoVU9/DzDvx2/U35dDC/3CpQj4PWb8nnrElBxU1adg3e3Ra+X5/l4vfy70y88b5Lr8
 qFXNyxnSN8jkN3NblETcsS+ABUsqwzHBKDfdIx7IMdC+GKEr0wxGFnNWkv/JztYqh+sd7BOGFr9
 i8j2mfEaQ7RznzUiw3t+lcQWLTmiFVgMMh0DsVdYuLjwT1zPzGTQO/KicehkF4LMvZpt5hXWt2r
 byrlXFTxw5L6d3ZVHan9whjUxcD7fD1pGn3TWVpJCl1mPtsl7DIZNMBj6XnSwU2JZ88gEkzBX+N
 d7qg2cX3Wtu7Py2LqVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260184
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

On Mon, May 25, 2026 at 09:13:37AM -0600, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-05-22T02:42:27, None <dmukhin@ford.com> wrote:
> > .gitignore: exclude logo generated file
> >
> > Correct the rule in .gitignore to skip generated u_boot_logo.bmp.S
> > artifact in sandbox_defconfig environment.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >
> > .gitignore | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/.gitignore b/.gitignore
> > @@ -80,7 +80,7 @@ fit-dtb.blob*
> >  /*imx8mimage*
> >  /*imx8mcst*
> >  /*rcar4-sa0*
> > -/drivers/video/u_boot_logo.S
> > +/drivers/video/u_boot_logo.*S
> 
> There is only one file, so you could spell it out:
> 
>     /drivers/video/u_boot_logo.bmp.S
> 
> While you are here, the top-level Makefile still lists the stale name
> in CLEAN_FILES:
> 
>     drivers/video/u_boot_logo.S
> 
> The commit message says "in sandbox_defconfig environment", but the
> file is generated by any board with CONFIG_VIDEO_LOGO enabled, not
> just sandbox.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks!
Will update and send out v2.
