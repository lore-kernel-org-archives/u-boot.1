Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA274CD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 01:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E03AF84957;
	Thu, 11 Jun 2026 03:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="ISE4ewuW";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="BX5O5m1y";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="gKbSQUwu";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="WXUj6TJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF550848F0; Thu, 11 Jun 2026 03:49:08 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55C8848BC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 03:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJYedR710983
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 01:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=Ig2
 6aQ9OmE8898PNx2GBiRySxRgMNzmHvu76mj2qTqE=; b=ISE4ewuWgHmJsOVCJkG
 raDQkhVhpnDg6oJz3BLshKBKZhQp+tfvyA4eyt2hawkpTBSYMWxWY6hY/nIpiy+t
 TzO6yzisuyRkSwkQmwXSF0Ckr3FlpfJk7f1vJJVASdkEMFK5zSQCKQaOAGRaGeev
 arH/Fl2y8E6T8VdeFaSw/KAlYSFV4L0gbH4zndCwyTwNIIi3oyrgg0vl8EWy8uaP
 3QPY/fV1fpZLCpyYJ5woNt9KyGUKz5/PDBC1ld3Wsrfw591/x5U0FatZbN30yA1v
 90p0BbWKkBeKGpCDC6kyrBT7BCMZdaGFAVYB7fxpzBpi/U1GA3V3l2QWLo32rmNU
 Few==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4eqe73trh1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 01:49:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjT+QAtE4sLvVJg2Vepp4tzTx9rgGWDcreCyDhxooFWgb60TOJYIaTFN8dYkI6U7CaEnqpRq1Z5qQ8xZ6qXWPJcRLGgMKpRhNk60IBq7PujvbOVXuRVuhQoM4v2ynTLKfgOA0d1o/7s17NlyaXaulrfX+HdgeRR4S8BoahD1tSKMqUsCA7xGJczko4pjLCmsLoOBgijWiocTSciqedFpNgkuLiAcK53kBJtWtb8CpjTCmeJTUl3eFcZL3hl5gk+yQlLSFgeImFxAxVIzHnqVf9K5mvgiII+DoOP3bR1apclxDk25LKh7ew4tpWYH12mKmyjwriE8/1DW1kfuRXJh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig26aQ9OmE8898PNx2GBiRySxRgMNzmHvu76mj2qTqE=;
 b=MJThv5h/RpaSABQ5vTY7Sg5xdBQh5LBoVjjzt7N2Nx4LDcN2h236NyFFHl/Hdr/00ChsbLEaJkipGFr8vx4awjcj9Et1+8jW3BOcumt3411kvUNJed7d9fqHzyo9grsh4qpsxii7rKRTIo5geuTe42dXILxVduxzCgEGOz3n7dr4EnbZTZciVl9zFJXBpEfXYU9b3tTP1aADaS4pM1TkfBxUdbOmd6DbMlyWYXODg39KBVLilPfovaRQudNJdg0lbZj33pVcRZ0jzZfti+1/DqRxzGSJu7yU4yS3I2D5x0Q/0HkVc4Hu2YXz/eVmLaW8hRJ70jAduRas7kFGmMu0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig26aQ9OmE8898PNx2GBiRySxRgMNzmHvu76mj2qTqE=;
 b=BX5O5m1y+EFD2vB/X4C0hsWLqceW0HG5qilJLVqlFqmmdvvt7oTDM5CcqN8KPU2KJqj2Wn4F2IWAzTNIA3haRWRhnRVJJXreNbkkmIkvr6CamApbYvzH6Eqkw/2AA3mAkzvLIDwKHtPwVPnBYHHpvsErUgxuWazdBYZbdX6oV4M=
Received: from BN9PR03CA0396.namprd03.prod.outlook.com (2603:10b6:408:111::11)
 by SJ0PR16MB4724.namprd16.prod.outlook.com (2603:10b6:a03:42c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 01:48:57 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::27) by BN9PR03CA0396.outlook.office365.com
 (2603:10b6:408:111::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 01:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 01:48:56 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0Rg43777149
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=Ig26aQ9OmE8898PNx2GBiRySxRgMNzmHvu76mj2qTqE=; b=
 gKbSQUwuTQIcfGLdxHMGwyXo+vgFsi9JfG/O1lq9OQY6vwr4n955IU8+1dpfeuY/
 R+2Nvbfqc2gXORUBvxRi4NPTvWRAIKoCgdV3FHY+tIstexg5+zO89fS0cwEb74vr
 4Lc4wylGYfy9Blrv9RwrrWtcypI82uh+Xv9nVtTkz6VOVmA2vO14mnf1tYSN2aFa
 CpE5ajMrfb1kv+agfw1nR3+2Dw+iR7pEFUKuIxtMDxYEfGBClqY1+INlRev3+9uQ
 rfhFWh6abSFT5Sghmd6vrneULFffC2u6S6VN/m9dh+kHz/fSqQOKJwf8B9PZt7AE
 vQZvuGUuzjdnW6VEZncO4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=Ig26aQ9
 OmE8898PNx2GBiRySxRgMNzmHvu76mj2qTqE=; b=WXUj6TJKCZ5Sw2sgSR3dGZg
 W2jR78zm5qUlup2WQhK58aH1x0lIdsS3unkaGMmcMcYAvTDQ2g4xD6RLJxU+QXjR
 PLo+3SkyE24dT5EH1RGLDqmm42G79IL4tq+/kRcZdJilhISBGbCm/UMJ+GGT2AzL
 Z3oFZsB0ZhdYN5gKMlPGfce3Xe9kQagxY56Z3Sj1C68Hl2+LmigDj9oQyEEh/q25
 k+udFe0Bs6BJPOS9lfKt55Qdz9/ae8GN1Ynd4YU3lGoIVyPDi/zJM8LiU5LPxDwh
 DEMTq9/iNyMDBVRsiv/fSfczCveV/xYhnTB1F9ImsAsK/le3QUPmFu6CpYOG0xg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4eqe77gary-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:48:55 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id XUXNw2Tmtpgi7XUXOw1QCx; Thu, 11 Jun 2026 01:48:54 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: XUXNw2Tmtpgi7XUXOw1QCx
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 1/2] bootdev: fix typos
Date: Wed, 10 Jun 2026 18:48:42 -0700
Message-ID: <20260611014843.3735672-2-dmukhin@ford.com>
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
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110015
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ0PR16MB4724:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e3563711-3547-4ed5-41ce-08dec75b99dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: F19G4//fXqtuFGWxGaD85XaVxuCprQoIu0Dl7DyBh4F7uvAFceK1tY3IaLZsZE0bdJaee9Qqni67+f8zp95aIQ8REY7mq4dyXvwsQYf3SdMI7vhhUWrqHwiFY14RH8wACLx7K67tLJkVc1rzY1GI1UgodEB7PpZ2p4Ttaa8nSSd48yvNWj+em275jmzqdE9JrQzc5hsq5sl1/FncmNqRCocn3U7kB4TP1VXy2VsZ9QZr7SfmhuActNfidLF/qFQn3SfsJ4oSEkz8BCu6oZ3xTwonGLFePua+JlfuzLgHTKFOtB1413dwHL3xI5s1D60c1zsQfQyBJCLezjxJmRitVDtmsfZUeV21S5PRGyNpdkQ+z9Se7D7DPgkP5yHkcVDlIstszJAhpZ9bXyzJMd4kG7K9vWWm8oTnPgcnP/Nm0BWA4wjROKaBiZJXY9UgYzMuASQr8YuzuYDapnoe9coSjQi9bxSO99MqMIK+HhQR+pU++DfNZD7BxWRISAYPBWw4T0HzGsPjLMEqXQ8g2TwDzSKNc8mtW39I5MGte3oIXQd1sfRhuM7pTkXeAagaEibDom2chkH1C5lowVFiNEysBtM2RjdqXYVuAV5iRBuXPmgnVyxcwsAwmuZUYCeIFwtPvCQmP33A7psAWP89+OD1O/pDeyGR24iyUux5Tpo9mstoEK/YfsGH9tz4XHJY4NoDycgfpXZe0IrFRGa9eM9jRCqrVfcCsd1LzRlgvvAqy+M=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S4El8xP1Qm05rNI+oZ4VMWjd08kHm1NtSFE7BL2dFC5/bBBpYb2qkWormtuyN8I9y5w3KwFTiRa1pYhWbcspv5nCuzoQOV39PO8lm+hBf4+rx2RVbJnQYWfYqh2aThGUlazsERBE49fGBWVnOitu44ej4HN9SXOAaSeI6W15l/99bBiBRgGxomVh5DH0bXFyvtdZ/gxjjRbwfY7w7otQtfM79dqbIPJ0+uj0Qa/JkPvvJbnTgP8+PSkCPbUf5Hd29D6fUXBcXbLoDDeXIs0Xntg7EPb6UmyLMNN2tFnq910LqD5HV1B6kXjhGJl5PEDkQypuEbM5AQuu5tKMOKHSLzeUAQMQqYAUlSpZF0PeAFyikJmCR6hgZ0JrwTVi62k1epK/8xtOInfIT/Z0FY6cEStn0FFIMnrRNCVnujvJXugeyQFZlVWQNKZEYlp1ANE8
X-Exchange-RoutingPolicyChecked: ESXDvv/SYo+La61SFTA0GAEUyw5kJGGMYECcQPMKfPHKKhSrfhduSMgGhPHaZyytWhT/NRNbmRqO25EZy9Gl8qc+rHoFtPZWINbY/GaOW4LrB5aWafOoGWy/bNsaT2566Vc4HoaF4LLg58Lg40lkw/mtba+HvERJehqH01H2RNsZGM0VfOcJNUMfxx6k3Dw/GCtHFt0IohOcFV0X5h+hzaBNyBQ4iIOcq2w8iCBuSZWNylxTVFEALqqhVgUqJC8uLwxlLHdv7SxFXTTEXzGE5gPcjNlsfffzf8lFrdR3HxoZSskJSG4ineXSz7c4eAC0xhCuSJb3u3zPdSM28+z4eg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 20WABS7o5+NoKmVdAOjn3/ijX0LaHpjWyt60YH+ZGk9s8hoxsfAo0oYIb+ZCTw6gNczPtaiM4Cwa/gReI/FawKClrGhiHkuahSJTPga9u3b0tensJUTzu9rZ2GbWpi5UlwR0Q8UG/YPIOZ198s0UnEuNa7LyoiitZzMy5MRyGQfLAJ/mfgmYiIoQn83DAOyEEa6efmtIn5PnTOLS1Ua2LRMBHzP+ZpKPPg4qRvx7O/EhG68o2ag3Zma/VBcn+vQG9IX/FmYngN0vVOqB1PW9Pa77evX+GmQqwSwKJVhgWHbpCjTdPtN52EILCDjehk8W804VSIySjDFe7p6Kj0CoFSLFYJse8ImV1g+31EjBxEjjMZBKIdXw0HlsnL36vYfuA2CcggJk+m9X3kedRwN0ZNqGic+cpkOG5BqkCQ30N2mLEvAs9/vouXD5cZ3qUdDM0NZ4NwcEXjY8pZoZCUUxpX1wX1MRxx8K/OgjIMGk6zmN7Ns5jao/q3NfSu8O+ahFdIsct4J+DbQ9MSkBr2sy+Dit+I5d/hYHhdWJ0GQOBI0MEFVdP1slQlzTKrw3OkwdX7QogV7LIP5LbDBpPyvSd+c5RIcRNzjbXPUlAreOS9Hzxsd/NeD8OFd6NhUNrAQcMIeVijFh6JMXJAGQt/nyKQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 01:48:56.7393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3563711-3547-4ed5-41ce-08dec75b99dc
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB4724
X-Authority-Analysis: v=2.4 cv=TLx1jVla c=1 sm=1 tr=0 ts=6a2a1410 cx=c_pps
 a=CnS1ju6qDdjTg6bRefQovg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=cbNQJ9GKAAAA:8
 a=8pUfwE4-Zr-z-6C-i9sA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-ORIG-GUID: H3OcxgLDJcq1HrQ4lDVLD9wfrLltCGWz
X-Proofpoint-GUID: H3OcxgLDJcq1HrQ4lDVLD9wfrLltCGWz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAxNSBTYWx0ZWRfX7dyrfOK9Cfi0
 t/bN1QH2RVLUfUV8qkKG5hZUTq8zZE3jMiATn6HwF891Pi2JeMm4Ob0jkHrf7g2Cop37kz5pI3t
 72v/4YLOXff1TJ/lzVSGHt0AyTXOuQMm2CzmYZidHckiNZXVE7yg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAxNSBTYWx0ZWRfX1YQlCDWy0Faj
 BI8Tv8qJg6RvSN6HJQK3MyH5d4hAEodp4R6kb3V9IS/mEp8NEiXl34LzvHxwS5UIZSYAaOMY12J
 6MWExjLy6wWLHXrqzBA61aohr9SpoLZ3VuatCbfEKaWd/RaUX5kfc37qc/Vz4/8Ytt+DrJYMmhW
 7NKUDFQyiyz/UOoHnAm5gEZas9oG/chDLEKuB/6uI0gzl6fcj4l2MmCjCiNXyoIGaT2K3yoOwLx
 6XKp0jUmW0iAPxtnbMwpANaHPtxlmrRfAGy3R231j/rCIE5WgEYUQAt+HEq8LSxW2KoSYY/VwFu
 amPMc4y+L5yUXxztHBCFgIFez3ykmbUHtu9oR1Uv/oVxsYzBt47w12rJfOnwC4A3QfmIigBNqSL
 9GlfSi2EnWH5K7k2E8fMqVBwmu/sWhgJemIUwTlwP5Pqd/DwY/xGU1aQfO59ix870oofOGHHOlz
 IsXznc01FSFbbxr28kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
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

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 include/bootdev.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/bootdev.h b/include/bootdev.h
index 12c90c4ec1ba..14f8a98633b3 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -30,10 +30,10 @@ struct udevice;
  * generally very quick to access, e.g. less than 100ms
  * @BOOTDEVP_3_INTERNAL_SLOW: Internal devices which don't need scanning but
  * take a significant fraction of a second to access
- * @BOOTDEVP_4_SCAN_FAST: Extenal devices which need scanning or bus
+ * @BOOTDEVP_4_SCAN_FAST: External devices which need scanning or bus
  * enumeration to find, but this enumeration happens quickly, typically under
  * 100ms
- * @BOOTDEVP_5_SCAN_SLOW: Extenal devices which need scanning or bus
+ * @BOOTDEVP_5_SCAN_SLOW: External devices which need scanning or bus
  * enumeration to find. The enumeration takes significant fraction of a second
  * to complete
  * @BOOTDEVP_6_NET_BASE: Basic network devices which are quickly and easily
@@ -327,7 +327,7 @@ int bootdev_hunt_and_find_by_label(const char *label, struct udevice **devp,
  * Bootdev scanners are used as needed. For example a label "mmc1" results in
  * running the "mmc" bootdrv.
  *
- * @iter: Interation info, containing iter->cur_label
+ * @iter: Iteration info, containing iter->cur_label
  * @devp: New bootdev found, if any was found
  * @method_flagsp: If non-NULL, returns any flags implied by the label
  * (enum bootflow_meth_flags_t), 0 if none
@@ -342,7 +342,7 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
  * This moves @devp to the next bootdev with the current priority. If there is
  * none, then it moves to the next priority and scans for new bootdevs there.
  *
- * @iter: Interation info, containing iter->cur_prio
+ * @iter: Iteration info, containing iter->cur_prio
  * @devp: On entry this is the previous bootdev that was considered. On exit
  *	this is the new bootdev, if any was found
  * Returns 0 on success (*devp is updated), -ENODEV if there are no more
-- 
2.54.0

