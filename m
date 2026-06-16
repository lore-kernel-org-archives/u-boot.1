Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C39CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 06:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F15684895;
	Tue, 16 Jun 2026 08:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="SajS1BOS";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="AH+0Sfz4";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="GYsuu8lM";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="k5NKzVqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3190F84894; Tue, 16 Jun 2026 08:36:27 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA00E84704
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 08:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G642ln1373116
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 06:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=eps
 eLoszfokC3lLOkJqUz6ko+bYGeY3mUHwZXngslVs=; b=SajS1BOSmQEGCZ+DLUd
 fu0HaBGA/0ri7EVyFRQEGr7sh/FBizxfUObCPDvj+kB1HSgp1LoKHrK0zizDk3xJ
 Kl7Ta8kPVhbxEBlBAUE910rAarZo4R3Z+KaUyXcS9QsDUDqeLagsPal4Os8hX3Uw
 P5NNvQE4E7Bx0kr72OcDDUw73ZaHlI0ykqqRatlol6FCZrwei8mA7hGjQawBw558
 fj1wbpgA/Du9czE+z1YzOZ8v6JksS+yrymjmQ/4UUA3gblvIOF/8J+v+lqjQY3zP
 Zzb/2aTm9eBqlYa7C+hHqVuJqbhg8cstOXI7vYMUUdCgMNeUn4ugc4Kh6joP5oU2
 bCg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4etqb8v5kf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 06:36:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0OkWmXTZ9DqB5stqWUN+SXx4GGVfaxAdW0ev2E9I8EWYWBWtuqUobXrCOCjGUYm3F9MjC1xDqlc1cn7Us9/dkJ+mAdRIKEEWKpz+pz0xfzNvxYwb9sfhbNIB6II2uGvy1/EthtkBy7GvwctKySZDDqkbVLdQi1cuhUqsbVyv7SnCTyzZiMpCydIfxYH3qCmUlaecmVAhYYemvilO9OULj8hqFXbOGxy7cJ2uQRJGQK64d0lutNi+bzhTCNdQ7Cj24qXoWAgkS6gaj98V5qE+VIM6Ku5QWpevY8C8CY+RA4fq+OKSFuwu41pOL2126ujujW5EdbI+yK2TA0dH1y1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epseLoszfokC3lLOkJqUz6ko+bYGeY3mUHwZXngslVs=;
 b=Qx/PBZMy2qEqvnw3kAWxwHAAT/cKdXlhwEcG+7GJI8ar3/bToJM7DcagvlDrK0Ruyb3jprgOt2xWHMvnE8lx/6OJBac9w86FYIryExbS/ZXVArXi0F2xAorlmCw4DGNA734EdXn6bLfPVk5y55RvVROhk3pEdYvD8sd1EyVcwMHFBesO5VEqruVXDcBl3kBLLoRkEepNCgiSHKQMPZozFLUnfL2HiviSALpesv32kWhDiq7Ol8vHOmD3KGkCpHGEcodaUSvFOMvoH2spxz7YxiRGQyM7XslHYx/960DWIXGnBBnt1WhHpxR4u2KebNKPc92u16A0DbE3WDusQsYjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epseLoszfokC3lLOkJqUz6ko+bYGeY3mUHwZXngslVs=;
 b=AH+0Sfz4gKgr+jCFs5s6lWEp5TD8OfTv9JupotRzUQWpSKkDsxebBx8L3EQYGtOSfHSPycRCX+cWcAnlbSx2aJLjOUfpDLbzjWNpykxmXhkiMwyt6/mLPX45KnJaWgfHI4P7eyKlGOzq/wfK7rTSxa8GBl6lQaNHkkB50j1ElMA=
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by LV8PR16MB6188.namprd16.prod.outlook.com (2603:10b6:408:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:36:18 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::85) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 06:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 06:36:18 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G67bbn2645290
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=epseLoszfokC3lLOkJqUz6ko+bYGeY3mUHwZXngslVs=; b=
 GYsuu8lMbqhOcxjdz76MGy6nuaVCyJaD1igQGZQkdBrdWKISjd/NwCVDixQPNrl3
 zOwgEd3/+5dalihVP3xEl+qLXo/Rnl7fdkcLrlzXz15XvOVe6wAMo+PDC8SfRNP0
 Ujw7J3GUnUzOkKD/rze/g3iQvBOfafjEg5Cx7M5vi2C+57/WR+23kFxrQHzQW4jQ
 aDuf0uXjWi/5QWVtyxusWYmK2h03gvarfMhYMaOikApBGkmsyQojRLkV0WCTCyxn
 tV6m++8z9h8GvKjWQv77UTGXWOAZji1Nc72sSJrLDkNMoy8R6qVxH2pyUGBQvJ7a
 QtpATAAor+9hd3VPVJMwbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=epseLos
 zfokC3lLOkJqUz6ko+bYGeY3mUHwZXngslVs=; b=k5NKzVqxCimSRI5wim1qlLv
 BCPGmEWfPyBqinpzv6tGBXoMdOy7U/CFZZl4HpLTv6uh03Dsep8N0oOsHq+9f3T3
 90x6/Ngs2X2zxwfbu2+5mwmRnZh9gghw/n69RCrAze5ZEs3bBgS1dBkdzvjnoyCa
 zRJ0RPwsGhHb4t3OL6D90stb9cRkxGGMEgS/Es+9gfJNgWzEKOz/hx0Zl2u/ZYl0
 BX0wNOA60QS/LYNcTB2t7oDOaiNmzBiG1hSrC+cTgQa6dsVkFIBI1cUD/dM78cMn
 b8pG+k+IYJXZ2/2zOPZOVEWZYMLpLnAT8iDXM+FYSn0PjqtPmBrbxp85bBnOavQ=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4esp9r2qys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:36:17 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id ZNPDwjTaSEF2CZNPEwmQi2; Tue, 16 Jun 2026 06:36:16 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ZNPDwjTaSEF2CZNPEwmQi2
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 3/3] test: bootdev: scan with a broken high-priority device
Date: Mon, 15 Jun 2026 23:36:06 -0700
Message-ID: <20260616063606.825688-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616063606.825688-1-dmukhin@ford.com>
References: <20260616063606.825688-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160063
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV8PR16MB6188:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 919cec61-656a-4c1d-ab0a-08decb7192d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YGY3svqpSzeLJg63XDZB1uLAAGLIe4OQ/vZLdjRAYpmNJSlieKpCXgwNyf41cGA2JmVMs1FmRhtWNORddgumC92l1vM3iEgYraPvxgFjsLk0zYCpMbQK5EL1u/MyHYmY0dfP/APE8K7pwwCfG/SJHHyJSecsK/RZhJ4EZyxBjGyzQtaCPDzEZAr1YvDE0xuwwjZIG/0ZSoJsj1W8ZTvtapOvx/A37aWa8XQw+iUzNC93isqS4GA96JF8rCFO806K8eaw+9hTK3iQderx/m6hf6/3UmMVjD6hlJJkbWQ2nvL+xF0ctzs6Jw9XhiyVCK2wqHwEGxYdqc+Z+g/WnDcY4qXpq6ADUkn8jH25rhPOnZ155gFmmAsb2GjUv1HPHqU0rna7ExJEm1yASuTAz1eR+OmXX884kq5d3lz/szzgSVX7hU9c5zAX9sYVC4UcK0ambM9Q/u6Q2qgjuSQtF+BovGhNVEMvBm9HSU/idB3EBLfkQLC3TilU/LUEjYMreZ4y1ogoSk5r412VwqbaotZY+TrwtD9QbBHvi7xH/7TLGs4dQy0HXezutKV6u4OIg1MTtljN1PUIlwFPVHi/vm+6S1BCqoKDoa8RjjE64m4v6gchL96rrjcfY7PJYX1qqdOkuNooWi2QrcHtHLkQDLMPotEV6JlZtcOeEYV9pgjz2rIgPa73yseo5QKTysL7Ijr1O1Wy2yz4Ww8aiqM9api8OEsI7XzvDf2jNhM+9/BmJ9U=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YMrGjLCcBKkrhm6T8sWzOTqarShXrtKlX4+xNRx3F0IDDW8wYgbwxccrU2xU1BNjtjlZf9CqF6Wi3GtutqtmSIP9cQ/SHrf2u/GpJT9SEDCUhev5xbJsBKulXfyCZ/XIopsPAvzJMTAZMKB/CLDBMB+KM3CRUyrPTnhuswRW8IVvTL+TXxdClbZVH/lx3MZnnvcOGfIY3n2tIfcPJHWa9Ljz114POn2WD4QSGaLTyCK+B9G2HBXY0BcVUtxrU6kDIgp+bQO4Ag/ZVOFmUUxRtIs8E9mmGDlloqf0SgStUnPs9SGE0jC5b8T0RTFzJnzAkwdf/4t5nPOgaMO6VaNRx3jr3vogHtcssjLNIuChON0c3AkLaY5S1Xv4vMp1AzONxp504ps6akwHN6jpv4GwWKAppyu4jrvWbFUF6GGHSGxqlA3dCXpDTITDI/nQJldA
X-Exchange-RoutingPolicyChecked: MCk/mlcUKns7KVOwyk+lCGuNsBycaasaY0Yv4fdg+l+OLQSHAb3PjLbYpFl/tsXHfFEMrPcXZvLP+lYGiuJ35+JHKSKHfp/0lcaloYIoqmn50YARh9QsADrEBUDyuweJObFP1zZ+RmxUC+UIGYYXubwAT5hCPMbeF3e2uqrnEyXoB++F/AB5cYSR1KBojrg31GGXzb2hkVcrnTJSghbaNqDY1drl9Y/eNO9COzrlPD3fs/Qpy4JAP/Ep1gfSTnSPyoV90TTSLApE+Uofte66Y/YfQWjgTqVojmPziUWIwmvBLQ3mhWp9ojGWXuS96yA7CI+w47WCCfQl5aIrzYj8UQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LMjoWhC0uKWSE5yPQPNvW3JCfwq33KCWWJOI4v5vb4qGJU0rejaX7UncL2YySDH27Y6pG3SosMlWC5qu/PmQKH7422RyWjzr5BCYUS3+3k7H03TkWIMKgAWjpHImzIQwvcUJMc1MCv1705HetNsQ9uHL2TRxzmxvofr7Wkf7LF3eoIPgSldLk7qORqcHwUnjSo07UmJ/0MfM27JXkyufQTVQ+XXXSKQr8fgvzoRuHtSJPP9RciAXOamm7dCAN3lFz2mHtpuVkhVp94bKqo1NqlqnkX/fH2P8yl4UKubrSftr0MzBG+nROnD8z0y8sRpz5ck8Ec99ntpdZFzN1oyFKg9RSkmSOfOVQsLcCL3qPOrp77GnE2Soj6kEicDHLJFfVQ5lE13IGCggvpqSfqWZWv26oXd/pjppJCz5kN6bLhj/Syq2uJqHeoHH43YhxyeyaaDKEChK+a0aukytUtohNRyc+cLBJgnU2tkCgOHMLycEaR/EtHxvd910nfV4MhnT0NzHhuNVzdxsqsOW0MFlCKNacDnkbnmQUtj8UopiH1FJXSB+nubX8hoOoUKojKFNeh6XD/Sx5Hm29TcNeFhFjftW5uOsa/Ug3PruD6Cj6Fki2nWSS02zXmB/TP5zvlY+B7biD3NhVS1j7qjDugGw6w==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:36:18.6121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 919cec61-656a-4c1d-ab0a-08decb7192d7
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6188
X-Proofpoint-GUID: j07BWKEMAxMy4--leK4wp7bI7q8Towc9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MyBTYWx0ZWRfX2dcgT52HxlSU
 /Ic/zDZFm1bhlpZL3mwG8pvBUuhXJLoMpK60KFx2NnzPvTXxF1xUfazUxRXdfpJLdrzY+FwUoiS
 HHMYfHFJ+yBGS/NpNGLNon8pS9uZk90ST0OKXUh1S2Z5YTrkMEX4
X-Authority-Analysis: v=2.4 cv=PerPQChd c=1 sm=1 tr=0 ts=6a30eee6 cx=c_pps
 a=QjrP5IPIVlaYm/X31SuGbg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22 a=cbNQJ9GKAAAA:8
 a=LAQJ8nXRT1C3RKJkp3QA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MyBTYWx0ZWRfX1djrE97feHeX
 e5So+2mDAdw04XyopF6gIHnvljZ4zJFSZn4YgK4RGL+O95xzHKUdYstylGhvTaD8CcWq3bOHLsI
 Y4/DftJaucsrJueyGGJKJBW8fkGj/OFcsT8m83OietVBBT7Il6JeTbpP3hJZyR+njw2K0/Glod2
 cHp3W+xZhfCCdnOiCSG8yfiFKuAsIZzwy6neFRunKiaJsX2KVoJZLZs3GUZiLTXY13hTMea8f5S
 dsgg3nLFaqLbcrqfRN5oJk6QGZF99w+SlguVhv2GNL2sDKcaniaD1DnQ2fnlPAt2/yIfbyKGvD4
 7tC1TmaX3EF60IU44mexflEsToxplPlO6LKLyQOEW3YaghQ4eBQfariTek3VfuL27iAD4fcKmal
 xfF4k2WbgSXiucaAcNuVeypvwJAfd2DtUrc1tXyQCAaWjZoYrE4aRtCK4E4rjh2gqLNR/Lrd9fW
 veqLt3Oxf+54jidHA/Q==
X-Proofpoint-ORIG-GUID: j07BWKEMAxMy4--leK4wp7bI7q8Towc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160063
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

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- new patch
---
 drivers/block/Makefile          |  2 +-
 drivers/block/host-uclass.c     | 18 ++++++++++
 drivers/block/sandbox-bootdev.c | 64 +++++++++++++++++++++++++++++++++
 include/sandbox_host.h          | 17 +++++++++
 test/boot/bootflow.c            | 51 ++++++++++++++++++++++++++
 5 files changed, 151 insertions(+), 1 deletion(-)
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
index cf42bd1e07ac..47d1ac6773b4 100644
--- a/drivers/block/host-uclass.c
+++ b/drivers/block/host-uclass.c
@@ -27,6 +27,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 struct host_priv {
 	struct udevice *cur_dev;
+	unsigned int flags;
 };
 
 int host_create_device(const char *label, bool removable, unsigned long blksz,
@@ -150,6 +151,23 @@ struct udevice *host_find_by_label(const char *label)
 	return NULL;
 }
 
+int host_set_flags_by_label(const char *label, unsigned int flags)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+
+	uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
+		struct host_sb_plat *plat = dev_get_plat(dev);
+
+		if (plat->label && !strcmp(label, plat->label)) {
+			plat->flags = flags;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 struct udevice *host_get_cur_dev(void)
 {
 	struct uclass *uc = uclass_find(UCLASS_HOST);
diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
new file mode 100644
index 000000000000..61384834e879
--- /dev/null
+++ b/drivers/block/sandbox-bootdev.c
@@ -0,0 +1,64 @@
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
+	ucp->prio = BOOTDEVP_4_SCAN_FAST; /* at least priority 4 */
+
+	return 0;
+}
+
+static int sandbox_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	int ret;
+
+	uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
+		struct host_sb_plat *plat = dev_get_plat(dev);
+
+		pr_debug("hunting %s\n", plat->label);
+
+		if (plat->flags & BLK_HOST_BROKEN) {
+			ret = -ETIME;
+			pr_err("cannot hunt sandbox device '%s': %d\n",
+			       plat->label, ret);
+			return ret;
+		}
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+struct bootdev_ops sandbox_bootdev_ops = {
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
index f7a5fc672300..b1417903aa41 100644
--- a/include/sandbox_host.h
+++ b/include/sandbox_host.h
@@ -8,6 +8,13 @@
 #ifndef __SANDBOX_HOST__
 #define __SANDBOX_HOST__
 
+/**
+ * Device flags.
+ */
+enum {
+	BLK_HOST_BROKEN			= BIT(0), /* Simulate broken device */
+};
+
 /**
  * struct host_sb_plat - platform data for a host device
  *
@@ -19,6 +26,7 @@ struct host_sb_plat {
 	char *label;
 	char *filename;
 	int fd;
+	unsigned int flags;
 };
 
 /**
@@ -122,4 +130,13 @@ struct udevice *host_get_cur_dev(void);
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
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 56ee1952357b..65ad72e0d6bf 100644
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
@@ -1532,3 +1534,52 @@ static int bootstd_images(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootstd_images, UTF_CONSOLE);
+
+#ifdef CONFIG_SANDBOX
+/*
+ * Check that bootdev scanning does not stop if higher-priority bootdevs
+ * are failed to be hunted.
+ */
+static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
+{
+	struct bootstd_priv *std;
+	struct udevice *dev;
+	const char **old_order;
+
+	test_set_skip_delays(true);
+	bootstd_reset_usb();
+	console_record_reset_enable();
+
+	/* Reset bootstd state */
+	ut_assertok(bootstd_get_priv(&std));
+	old_order = std->bootdev_order;
+	std->bootdev_order = NULL;
+	std->hunters_used = 0;
+
+	/*
+	 * Create a sandbox block device (BOOTDEVP_4_SCAN_FAST) and mark it as
+	 * broken so that bootdev_hunt_prio() returns an error.
+	 */
+	ut_asserteq(0, uclass_id_count(UCLASS_HOST));
+	ut_assertok(host_create_device("test", true, DEFAULT_BLKSZ, &dev));
+	ut_assertok(host_set_flags_by_label("test", BLK_HOST_BROKEN));
+	ut_asserteq(1, uclass_id_count(UCLASS_HOST));
+
+	/*
+	 * Scan with hunting.
+	 * The sandbox hunter at priority 4 must fail, but the USB hunter at
+	 * priority 5 must still be reached.
+	 */
+	ut_assertok(run_command("bootflow scan -l", 0));
+
+	/* USB was hunted despite the sandbox hunter failure */
+	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
+
+	/* Clean up */
+	std->bootdev_order = old_order;
+
+	return 0;
+}
+BOOTSTD_TEST(bootdev_hunt_fallthrough,
+             UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV | UTF_CONSOLE);
+#endif /* CONFIG_SANDBOX */
-- 
2.54.0

