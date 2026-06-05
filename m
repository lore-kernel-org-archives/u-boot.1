Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C53CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D0D849EA;
	Fri,  5 Jun 2026 05:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="tkTlQ8Lu";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="T22pabW0";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="VVGHPEKA";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="L2CeTAaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE3884931; Fri,  5 Jun 2026 05:39:33 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 081A5849F6
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Jq7wV982206
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=zDW
 MAygCC4lOgC595Nnc1MRNfKzUIot9m7J8dzj5hFk=; b=tkTlQ8LuiTyL4853k+X
 VyoUzTa4k9qLryDoSSJ5J8FLB85ZyXA2qAsk+sBqgOIpZHp4oX/sggfXgACwLY+Z
 suSIQDdyoFuXQ7/nfNhE4fYtkRW5z0u7ucJXGk7oMmUFL0cuoHv9xtAWFF66OMex
 uXLETrI+Bxj7/mUlpnzMEkhYxRoDJ23M0aAPbjGEvTtk3jAbj/v7alj4jEWesdAI
 KE9YJQ3YS0bY3kK6gAw3KrwOqfc977LiUfs0l6SyoDLIO7j9Ol/en7zSwALp4jII
 u0yD0bPydiFSwuYtrBxs/0OFXRhO/1yvmKNTFSj3uS1SE5XOn3wKO+EvGcruSXHM
 Fmw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ekfw6jgsg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDcWCeO3CeDJA5O3mQoBFeLcwTzx9kOU2p5Q0KCe5A1y6n+k4E/X3kmreLif2DTtanLGYIrSgYLpcR12gSSt3gEEjqjvgRXdHuUe4tWdTsQS6iURJm1QWpK80O2d754vcgwOhtxHRzQtC8taJ+1Q0Csa8e69S1tcQYmXZvjd6RF668w9e4Gio854SBg5sFO9nMHoJZ/VSl69ypjTSjXmuoCfx65UWcVL2z3cXlXH0S6dIZWZeFWrRJrpNKUrjfSWj1oywiMgNMBezn2N0ydZ1hrIYKjjzUycmM7G+J8IQdVwgppKq0g550n7gKCBWUKPNbeS/2KvSB+Qq0NP8SCTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDWMAygCC4lOgC595Nnc1MRNfKzUIot9m7J8dzj5hFk=;
 b=RCI7LpjvzHauP1Tr4Zr7dj6zbzFsyAw0h55DQGNX9ynbgjv3tkKCmu3qtDPH4A+EzoPpZzHNQaHaItXdGHB9t/3qzu5r87tEkHN/50EKJWyvu7Y0r3Ejxc99AGdQEMZEjWhPQnfMxPqUrye9aCpwxSmTHtVSj+DJTh+Do2GZD5iDv9oH9Rc2QoR4SQfi/9En1IjD/OeZjk2x/pRScbDii1TYlyL00Wi5Ar/QD7i9MnQyHOBdrL6c8kD3OXx2mDxz+e8IVNTuiRZFDgkVmDX7pAPdYulPXBZ2K9UrtGC5FV7f+cYc9MhA7JZH3zJivb8rKWJqYtY8NBebOaL3I22B4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDWMAygCC4lOgC595Nnc1MRNfKzUIot9m7J8dzj5hFk=;
 b=T22pabW0ejPafv+nwXQH0Y+8ky6xsZYmDF1gTu8bpczN0MbPfvFM/K4rtOhZS+/ptC6ZGqQQWVxQS0JkJoo4KsFjFsdasaBHaR7ySvDFxIFs6/HJZDQuPROXQz0TFfgPKRE8/yziobDy+KH0KHmgZ9KJFpfQub+rpma42acscuE=
Received: from MN2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:208:1a0::27)
 by BN7PPFFD8C30A59.namprd16.prod.outlook.com
 (2603:10b6:40f:fc02::72b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:39:22 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::34) by MN2PR07CA0017.outlook.office365.com
 (2603:10b6:208:1a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:22 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6552Z7rv096620
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=zDWMAygCC4lOgC595Nnc1MRNfKzUIot9m7J8dzj5hFk=; b=
 VVGHPEKAMxaGYUCNT4kA/eq4vAInnGA9G/iztibAKvkwIFlyXX+wZM1RKhGAkq9M
 2jBFTF7J3zDfl7JnqzHRrL17u9X7VGTdM4+rg4R59vnPBJ/0xJec5eXLCuXXLhx7
 UZRYHZAJMf1X/g+H9JOFN4ahItlvI+JQAHKP9m6Hnkcpw6HENTwrxWFCC9MMOdaz
 IIGBVNehjW0ovFv/eqG19BwR4tilWauWgF4k5yBSW/nX6LV5ZZk5nnFB4DBneXl5
 QDkp2H7RYy6Z3vDteVFIEfzaWJRsnjxmzVRjdvF9yPwdWU4SrPRcDVOKxDrLi3hG
 GVYAdgDUI60qH6ll7Sio5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=zDWMAyg
 CC4lOgC595Nnc1MRNfKzUIot9m7J8dzj5hFk=; b=L2CeTAaEB53G231pOn8zjWt
 BcOpX5hJOf0gXZuf9C9miGGFvv04tcm7HvYp6f5qoKh9fBwBtEJHnRaiErSEuiqo
 4tq+3AZ+QKyoM+hrggnBFup07TGs3wai/6UZwCHi3BPgUhZJmmy0mi7vV6b8sGc0
 Yg1gPw22aJm6GpXy4oDry5zEgsnQ70nvLD1cv5LrOE8lcw+4yTBM8NmicXJ5LDk5
 kk4+IwyfEdiCMjjTACPHLI4S3hCiSQfhj2xqWOodAy1LWtegIyVc8HhAjJxAbnGa
 QO7y3c83gyWoBVWVjPAxvwm8Mq65gYB4mXj1w8gRtQaROKSYEV+NH7AZP26y2Ig=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egeh8hcgw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:21 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id VLOxwmOaxpOFEVLOxwP8Gf; Fri, 05 Jun 2026 03:39:20 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLOxwmOaxpOFEVLOxwP8Gf
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 4/8] cmd: gpt: enable extension to manipulate GPT PTE
 attributes
Date: Thu,  4 Jun 2026 20:39:03 -0700
Message-ID: <20260605033907.1909319-5-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
References: <20260605033907.1909319-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050031
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|BN7PPFFD8C30A59:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c1736418-0936-4c23-bd0c-08dec2b40863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099006|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 2JEE48Y+7xWJ2vjvaNZyu5PkHDuXvlNeFf9AxHZQXTg79KERjPVfX6VAxW18uvEQlQv2dN1OuK8tXiQvADV+Gbsz7yPJGBAI7/5lP9AOgE/KOsG3DTJ8sA7bFqNkNeoEWlXdao0U1qV3R/ksCa91oQZHKjB1fOHVTAc96r158eWbMr85GD/blnR3Ko8shtB49eFVuCJTRdQ6rj/GPzwSKf9yXoJ51+TkZwrCc22lZ/sX0cmo1h3ToLGixhhxXE4P3ZK0ix6NQ1DdL/1OoHYH/VjnkFrjYUP3KYmrsUf7naOK4PPH0AfEzX1ag+Fg1KmoKr1jh1MW5iiYlKN82tzPqniHfNLTWfU+D37gE4XchgoH2kOyjr8RZ+ybHx2gSKMdH2v470/r+pC355bWCNgnbLU/uOPIVL1l9OfY3wnsgHzo33FjJKLPgOs0iJ7u8aw9/0euzWH2zLpNxnO3goibkJJpM1TTcI111VDItkKXJnIo9AFOiB4C9pP1zrdIHWtfusf+AWkCFGtFDvKNIAZDRP9Uqu6uQDx/7Im97WeSLFDTUihZaTGYq18uu1ulzFZey3Te7+x7a9I00lxglk+4GSxuBuvkzWZ7kZW2qSS+d4JHwhiz4pQUsxol2MeNqzEZEevxb0NzFGuItp8Ez6B9WFw7QvXfd7R9htpekRGcrOmQrrFAilFk0YJL7KDYTPtVflSXdhwxTkwl8REPlS3S/wybkAKhL+PtgjRI2xV4M60=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1qqkctBXIRiPhYG7ETpt9qMbd1/ZYBSuY3vL63Z3/4MJE/tUXiAYswCBs4rJe2T09MR/SSoVixnPZpjIn+5xstXrmCHTnj4q+lJcgyS5WPs4fBJxLQ/ejvrhtjD5Mv/US50mhZ7Sin6OtoQJ+Q2CPJyIzE/o6x/lf2YRkIZJxNttImmvBLG3ljjopB8ehuLU3QHkKKLBVbLa5XuqPetah539SPv/cFDB7vb6Si9lfskhu6wVLMoHhRlRFzN1HnQ4rLDqbq09W7qtlqnRh9byzqClwsiVuGf9LXsmSyCxIn1z7UPi2E+4lbzUeahpzDRKKmkGq7RGh688Hv4LeF2ZXv6z2vfAvqeYxTbIiSsiNlhXEvmhAIghAPbA2mYJS9Wc5wmgJXBhe4mqBgwa5mqb9sWagts3rbFDknayeN3tYgs1HplVNuP2EO/h7ELKtAXf
X-Exchange-RoutingPolicyChecked: o4QLZu+A3nNdL6slIdEfhCuCwjB6LE3SAzBiTqDBB4g53+3Z1Vt7ioCes34xSj2DL/tWUA0JWEXDkgrr9M0VfkzU1ipeO3jSwTDjGCDkUQpHLMeuMpc3ax6D03FBS6j5Ps57VosanzcIQOKlNIIxKvAzJCIYmOq74J/7My/IdmgDDZiqs5IFBBnX428nj+DbU53spy5E/MzI5pM2+X5nEUxL4OHdx+6G+D5fWg5Jnz6RAIFj15Bm27VKWW3Inwdb4nBGuV33S9KEATJGYK9UUahl5W0upu/aRXjD1J33veq5OsJpnvEJc+9mkoKZjwd3Q8Lm9zNJN0pmn3JTUlbArQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FpJF/VrLOZGM8qb9Pjf0/BgHzuNh1X87PJh7rNpjPIEAS/c5vpIqRNP9LHppAzj+X3gwH5lBfeKldrRXxMTm2fpkfmm0EodcLENJ+xgOFNYz5HFHkTXXuKhZn1Az70syg4fDCyF8Ptr2KBFk82s2euranU37DtvTziVJmS3NtTvcenwNWlxVPjBp8BBBvXzPIFcsSfKYErkYtjE5VxqHF8u/SMQE29PznWvEGA7AGxQHjoF3PQCl0qGNNMrPZNbs68WQhdgpNWu7Lnod3ZCklcanUzCsjPkvR29pxRxectvwuyXjkFcL06eq2D8krvTHLPH30296DNYsYj6vaBuiwuZGf6hyi/tK7tvnlUhfmTbTakIaRKGKF3aMnXeyRyAMPQPeOZMOB4fSksjyvUBL0zhALWwRechIjt8dtLicjRSkL97wy8aUMg2tscFdyxwSWIsG2bdxSNk0EFI+ITS5UHHn+5gm0YrItkppxOJmXJSaP+ba/eTvg3BntnJIN8WyQLcVaXwx3Os3xUchNI9x66lRoKEUrABzMr7jTg8Uyb/lU2pGl48CiDIuXOo7TGPEahjK9qliD99e6hGKco5Xs7mNDAB22Fq2JdjTRxN8+gz2Y6jd9yJDD4uExnv10ibD
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:22.2986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1736418-0936-4c23-bd0c-08dec2b40863
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFD8C30A59
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfX7SnvNccW9F49
 +GWoqgk9hWZxSMpenhydSVHIO1HG2MfIRYNpn3pIEInI/UMfGkWNU6P9wiSUGFiKsMy8Q9Yzwe3
 hUWxb2Vb8t9AeVudgCwfknK25iKO8b7EF6QJyHvbNeG6Ar+Gg9V5AzdCYhjUaRxdk0kY6Lw0RyY
 p5U67E+rbn/9ls4+ER3sZIl/F84DH2nG/iqt58mX4iFnWMD7npvzMStztWa6kY63bh+sB9R0Blq
 cqBRdvVjVhx6pqgzivw2YN67oNGRI/e4kQqpni/WCDr46xadPc+klq7UG58XWoMyn4EKpJFBDZi
 x7UThZ8r8yywvFSNpdXLGTBlE/5AfUPUbfqQ2actS7QWykGcexrJdEq1vLPDc4bG0zkmdPdCm/h
 SXubPy+IHxhTCIIgOHI6EBD35kEgcbtHA4IE7Jfrqx5RRW2lCx1fiJl5/hcVHGZjXo942WnEEdY
 5JhWfJnxJww7oyaCwCg==
X-Authority-Analysis: v=2.4 cv=A41c+aWG c=1 sm=1 tr=0 ts=6a2244f1 cx=c_pps
 a=yJkyEzHMNmsTB3XYPV+H7A==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=EcEMAzZVXQ8qeW8mSX8A:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-GUID: Y3XjIF6_5ioIomwhJqIh6i7TLOLONbkK
X-Proofpoint-ORIG-GUID: Y3XjIF6_5ioIomwhJqIh6i7TLOLONbkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606050031
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

Enable extension for existing 'gpt' command to manipulate top 16
bits of GPT PTE attributes to assist ChromiumOS-style boot counters.

Follow the existing syntax for specifying <interface, device, partition>
tuple.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 cmd/Kconfig |  8 +++++
 cmd/gpt.c   | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a196..83409e60da8b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1319,6 +1319,14 @@ config CMD_GPT
 	  Enable the 'gpt' command to ready and write GPT style partition
 	  tables.
 
+config CMD_GPT_FLAGS
+	bool "GPT partition flags commands"
+	depends on CMD_GPT
+	select PARTITION_TYPE_GUID
+	help
+	  Enables the GUID partition table attributes manipulation (bits 48:63)
+	  in a ChromiumOS-style manner.
+
 config CMD_GPT_RENAME
 	bool "GPT partition renaming commands"
 	depends on CMD_GPT
diff --git a/cmd/gpt.c b/cmd/gpt.c
index 205f696c8072..4d55cb588ac2 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -11,6 +11,9 @@
  */
 
 #include <blk.h>
+#ifdef CONFIG_CMD_GPT_FLAGS
+#include <cros_flags.h>
+#endif
 #include <env.h>
 #include <log.h>
 #include <malloc.h>
@@ -1116,6 +1119,64 @@ out:
 }
 #endif
 
+#ifdef CONFIG_CMD_GPT_FLAGS
+static int do_get_gpt_flags(struct blk_desc *desc, int partnum)
+{
+	u16 guid_flags;
+	int rc;
+
+	rc = read_disk_flags(desc, partnum, &guid_flags);
+	if (rc < 0) {
+		printf("ERROR: partnum %d: failed to read GPT flags: %d\n",
+		       partnum, rc);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("P=%d S=%d T=%d\n",
+	       cros_flags_get_priority(guid_flags),
+	       cros_flags_get_successful(guid_flags),
+	       cros_flags_get_tries(guid_flags));
+
+	return 0;
+}
+
+static int do_set_gpt_flags(struct blk_desc *desc, int partnum,
+                            const char *key, int value)
+{
+	u16 guid_flags;
+	int rc;
+
+	rc = read_disk_flags(desc, partnum, &guid_flags);
+	if (rc < 0) {
+		printf("ERROR: partnum %d: failed to read GPT flags: %d\n",
+		       partnum, rc);
+		return CMD_RET_FAILURE;
+	}
+
+	if (!strcmp(key, "set-flags")) {
+		guid_flags = (u16)(value & 0xffff);
+	} else if (!strcmp(key, "set-priority")) {
+		guid_flags = cros_flags_set_priority(guid_flags, value);
+	} else if (!strcmp(key, "set-successful")) {
+		guid_flags = cros_flags_set_successful(guid_flags, value);
+	} else if (!strcmp(key, "set-tries")) {
+		guid_flags = cros_flags_set_tries(guid_flags, value);
+	} else {
+		printf("ERROR: unsupported command '%s'\n", key);
+		return CMD_RET_FAILURE;
+	}
+
+	rc = write_disk_flags(desc, partnum, guid_flags);
+	if (rc < 0) {
+		pr_err("ERROR: partnum %d: failed to write GPT flags: %d\n",
+               partnum, rc);
+		return CMD_RET_FAILURE;
+    }
+
+	return 0;
+}
+#endif /* CONFIG_CMD_GPT_FLAGS */
+
 /**
  * do_gpt(): Perform GPT operations
  *
@@ -1176,6 +1237,23 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
 	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
 		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
+#endif
+#ifdef CONFIG_CMD_GPT_FLAGS
+	} else if (!strcmp(argv[1], "get-flags")) {
+		if (argc < 5)
+			return CMD_RET_FAILURE;
+		ret = do_get_gpt_flags(blk_dev_desc,
+		                       simple_strtol(argv[4], NULL, 0));
+	} else if (!strcmp(argv[1], "set-flags") ||
+		   !strcmp(argv[1], "set-priority") ||
+		   !strcmp(argv[1], "set-successful") ||
+		   !strcmp(argv[1], "set-tries")) {
+		if (argc < 6)
+			return CMD_RET_FAILURE;
+		ret = do_set_gpt_flags(blk_dev_desc, /* argv[2,3] */
+		                       simple_strtol(argv[4], NULL, 0),
+		                       argv[1],
+		                       simple_strtol(argv[5], NULL, 0));
 #endif
 	} else {
 		return CMD_RET_USAGE;
@@ -1237,4 +1315,23 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt set-bootable mmc 0 boot_a,boot_b\n"
 	" gpt transpose mmc 0 1 2\n"
 #endif
+#ifdef CONFIG_CMD_GPT_FLAGS
+	"gpt partition boot flag manipulation:\n"
+	" gpt get-flags <interface> <dev> <partid>\n"
+	"    - read top 16-bit of partition attributes (bits 48:63)\n"
+	" gpt set-flags <interface> <dev> <partid> <flags-in-hex>\n"
+	"    - write top 16-bit of partition attributes (bits 48:63)\n"
+	" gpt set-successful <interface> <dev> <partid> {0,1}\n"
+	"    - set 'boot successful' bit\n"
+	" gpt set-priority <interface> <dev> <partid> [0..15]\n"
+	"    - set priority; 0 - non-bootable\n"
+	" gpt set-tries <interface> <dev> <partid> [0..15]\n"
+	"    - set tries (boot counter)\n"
+	" Example usage:\n"
+	" gpt get-flags nvme 0 1\n"
+	" gpt set-flags nvme 0 1 0xff\n"
+	" gpt set-priority nvme 0 1 0\n"
+	" gpt set-successful nvme 0 1 1\n"
+	" gpt set-tries nvme 0 1 15\n"
+#endif
 );
-- 
2.54.0

