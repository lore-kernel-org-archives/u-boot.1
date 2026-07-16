Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182F4C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20EC084D9D;
	Fri, 17 Jul 2026 00:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="LvHYQMBl";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="SZN/kjZT";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="dlzHB4bz";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="qRcbAl6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDCD84DA2; Fri, 17 Jul 2026 00:34:17 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082D184D68
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66GK9SAT3110488
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:34:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=maVchqnrOuZ/k7KYLXtEPMfav
 l8J2N5Fwm2YItUX75c=; b=LvHYQMBlj+X05AU1BENURXxtLCpaBOLFCYs3HNXHi
 G/UYnUEk1mf6iGF7EGCcStW+ZpipZOezK/1yWzaTUIlSTjeQ8GKXcfINuYlYRxm6
 /3roNN3gOK5AIJldwiZpwCyonU83P4XVR8DJIGLQuGOWuURxOP8NiRw+tmDke1N0
 ExHeaFp4ZHGlUD11gdrTaMKY+6OoJZfmda/Hij7ShXhZRRmYd2MrswqlRhF5odpw
 WShYDpSRx2pWXt1oXMLolyll06n42MJX7OVzVEVLUE56K4iX8miCVQGOUR+X5o2h
 rjsAxBzR6nXARAeyWi4dk4FjOpElutH+GlfXLxU05DVig==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012024.outbound.protection.outlook.com
 [40.107.200.24])
 by m0482517.ppops.net (PPS) with ESMTPS id 4ff5r5sawf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I62DbErORh2+b3LHm2sroitHchPRlEPuhalfe2cnaFseCJyB48tR7NUxGnRyzSgV7oHQoR5mEI8XYRC28Ulm8cXEvyrNe0vLKixha62TIZ5CVJD47k5c0GKXOpdY1rBMAuf38N/2+ZysFyIbTVDanM6eOGiFtdVAJOIfqP7CpSHiI2aOEIn2FF6hZ5Z5g/vmCqkMjGOoB9VQvI5VIQ4aIQ0BaksmWv8mZL+NSpL5RuLBCpZJleeQLzXljp1UJyPM0gl59xvskjmCn63KyokhHWQmk7ZotrBCE4u/RW7xShW4zEeNSIoF+dt3FFofuyK9GcAiB4mWStuQBnP/6mSVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maVchqnrOuZ/k7KYLXtEPMfavl8J2N5Fwm2YItUX75c=;
 b=G934IqHuQW9fkMab0bzhuqz7SpnPasJL8V2IPmSIJQIb9DYXaONgT9PkEET64kPke8YOKPF8f1SEAbnPX6qEG//r2ogGd3fA+MGqkDs1yQSqXE4pmT9lPoJLlyvVdVgYuQJRkaKZnE9eMF2UkdTh3lyi+dmobndyebiehhllb/mrjvcJk4RpATr8yGCe7xwaZo+DKUIfo3+nAqmcezOXXJedhuX9/v36tVYeN5H1TZVFIEBA2pqp57CwdwfUn8Soa4Yix5eA4AaoYuqJmfXHL3RCSiXRbu4qX91GyoU2uRod7h+jUFjs+ykc6yXOXdKyMSQF0fOSK80dMdkFVrUtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maVchqnrOuZ/k7KYLXtEPMfavl8J2N5Fwm2YItUX75c=;
 b=SZN/kjZTD9oc4PB85eRnsh9AeiFMSALgGptCZ+zXG0K+hn89ZzNQIcLPfgwXWLbjyg7lzxLHSEMFTO9/jocAd0bqrQqvi8b1vGp3YD3geQ6RPlfwY5wZUHBLPvSb+nOTbugdtLXMWhGxiImD7ni1/rRmFPZJrWGxADDvtYZdz0s=
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by SA1PR16MB6314.namprd16.prod.outlook.com (2603:10b6:806:3cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 22:34:08 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::97) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend
 Transport; Thu, 16 Jul 2026 22:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 22:34:07 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwScF148353
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=maVchqn
 rOuZ/k7KYLXtEPMfavl8J2N5Fwm2YItUX75c=; b=dlzHB4bzIfqtnn3nr2U6fU3
 tr/tdBzWJuVidO4T2wZ/cp/VSmp5rBt8eAnP+1Uj8wtAQ0VW7ypY7mXnykay6CgN
 o+uBfTQzWM4fJ2+soXDc2SgLnOCxnqX34QpVchuLxhtfFZkhr/iMx7WdRfrphgHL
 j6UkZHf7AHHceE44MZf4ok17mF0wXFAm9g9tVQ80N1faEUwozHly9CdOAQ/bBtpT
 7kMvPyBltXbPj0YbjKqnX6Lg4BPiFcJxlwihtcB+mjZKxXardHpq7Z5Duo0vhGSL
 GziMN1q7FF+L1HUP4EewWccwqK9alJDszFsiqmY+Y+6tTvrz8W2ElLlfFjmpZcg=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=maVchqnrOuZ/k7KYLXtEPMfavl8J2N5
 Fwm2YItUX75c=; b=qRcbAl6sPM0FqHOjtTNdTMvdinJl199Q7cPHBEu0JQMxzcA
 BMacLyJ6fb0ryFRyISvbxp4SSbFmPK3Mx87VWL1Por+q+2z1vjhl1Nb6S5VSAImw
 37KaeAIh6X6qoKooSV/hCw3efIdXxOuhgLuRenD0JnTm1RIkqPkc5Op9l1dKB8Cq
 Nc5vDGf/C9H5bRqsO0b9SrIB5I7fqDYwP2PwIjQh+LLvKgpw7wqaPi+3aQwAOOXm
 Mmfa0RVAZR18bPOuKtybYhYbLdTctP0aVYj/vZodYO0Z0yVXvi7qEw1bOFSrxLd5
 WF1gtAMrc356iJf2FJlp2INs+EOfDt+8RZnoVow==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fc6pxxhmd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:06 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id kUeawhFG4JrM7kUebwnfXk; Thu, 16 Jul 2026 22:34:06 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUeawhFG4JrM7kUebwnfXk
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 0/7] few fixes for NVMe and block devices
Date: Thu, 16 Jul 2026 15:33:54 -0700
Message-ID: <20260716223401.378989-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SA1PR16MB6314:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26fc9ddd-48b3-46e3-b046-08dee38a5945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|13003099007|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 9gRCo9NJYrZnnzJxBHm/O5FWFlad1j3qBAlUWnbACUkhqKP0v6Okn/yD/wB1f/MRed5iWEB9yC3NELChVPRWaRU9MmTIKBPEsYO7rV5OyGFhQDKJbYHnG+eWKIh3nIwHOHl7T734tcnTpNHMn18UVxSCzHlEiS0Egmc+7F/y0q4BYAkzbe5XK8lmkYi67Urj1DgWMzfnEa7t6Ew/7xdI/G9p1eDV2sU5l0KGwP87G8kq2G8Hiiuq/6+zhhiqp7Jh0yJ73rT0R6rbyPRvmSJDu/hcp6uPPXck1xyvpwpNLOgVKoVmeuTy1ynKq+tq1608Kc4HGBMtSKR9ETjr6iMO6UbPpWhqQ8Ip9lzic+U4tPtps6soe4Rw8amuWg0Sn71bbhoyFH7atkDFKTcsbbyinrK8WRuAqUHQifwVDhWQc9+DBII3rcuzozDQlN6gbsKOldfNfBZQK4ql/rNn1iAtOrqsIqfLDchXHG88441kGVFww5LQoZyneh2VE54F1YUHmbhHfkwMBcg/HU0oDtji8bM/uT9qts0Hg/q7hjdKj0uJWzM9L9VZ67jbjKrxPnXRmCQU6at+NDz/NJL0j+rbM17LqvQtqb1xgIB+ccZ3E8HprF9xNWxDW5Y8Opu/yOac9P7OsTpqNx12q1UYTSGEqxWdBsjRUBuiXmS+pRqEvHQSYwr/QDYK/a9JZWEkM2ji6zlHCvvewt1XR1mn64FtoQ==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EUS7Q+zRSjomSQnw4y2s0XLXBqsjZrlAKJFvDbfb4hn9UndeCPG7vLGdn4IFko4a6jntzmNi4PMrckcFejH3IUqNwKWb3A7ynOiNA4YVgHk2h1KG0kZw6jBtYdKLecLB20L9LSuyJNf7rYRISw86mS9tX3DTKigKd7TSdXfdyzez5uz7EVnENZaAXMhAfY5vuNR5rGE4qxwKWpLCI7V7WRL+/ujzZ+I3SxC2/RwAmJo84L9nheGrvPF0V48gHPzAbJ60Oqt/zJw4cBS+Hgc0zU31lxDkDcPXkdWFw2YY1/10+RNMnZS5K+/hggdwKsrd2kgN3HLBDwqIvQqsojEifqf2ht7UAUztr5phC9jN6ZVbMRImZqxiL5DTVRZS8QkmqVh/WsxQR3FAv6wMFNVxryQcU5+cSF4c2tgflWicmmGw6JWMW5G7w0NZfxemQ7LL
X-Exchange-RoutingPolicyChecked: S8csjiBz8c8TUmFZi+NpHWpxOyclsajSSM/1StEnckl0fqROJUcJh0Yt9w+pIXi1Q0SG2ff9zn/09x/xz6+S7FIdFXhJky5fL6liaYhBUgeamlKosYjN89TIwS15rJbw8hd6riGACpR1Lz3kU/kcC/uh78PeBwvURVEoojUMX6XlYBW3VZacIFcXb84OsPph88Eh+AWgOhQtZYUDSDDZIQTeGHyUVh7EV+R254jmYHOjOfSsdjCh0dmSCyag0WqhFOr/bABHJXuP8Tfwyk9c/5hoYro8PuXAmi3GuJ7TpVCGw6H4FC2cLYFYLWL23EYX6LkL6v9XLuiGHFMu7iKlwg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d1JqtxNXCPoidsRh1UG240aajlTsLmatIzWKK1kSa16b10neuvrNAPqXlGFHf2f+m4uRMGdt4fH6ilK2espf8nAWW0d0ojor8zrURfGCqvVF5Z28TNPTv88eavjLS+AC1Et4bGfXRqy1pgciML30C6evxmL7apethW9xcJP1Ie3SmFeMyu7f0BIrROgOJHqwFpZ8Px4FyX3gx2oQtdQ0XvEHmHMY0/deHYPJ1/7oj+CZ/REBxdEscmYkQhXkZ6nxItjP/CpF6UKfaQqIUY5YSklWi51Y8k6oSg6yElqMI5sRGkIwZWHA5I8qAyx/xcFDXb5OWSX8y3WN+1Lm1bMg46WswUcSKpkTILt9ckYCsq049j+KWq7SnM0mVofBwO5w09EYwx/1WdA4Rlcpti2ZEWeMo5XynUA6e1PDWVNYXgDZrcGPpz3Sfzi28lMJ3tAIoIuhvaaHhwqtgt7cpVgkj/5bF9fuqzxKRu1hu00BcjRrn6Zc0h5srR0pPKBFvE4MRs8pZodXQTlMUVLw4O3ad+L6CEePr/8ZFsETsYCj7IlRxXD2ezfAfXLhjCSgqD1PBotpnSAnPPLMSMpRYrzHwGpY741AMCuRW5VwBFea5HNQuuGfidY0dCL6ZGv/vY7GKhhoU46xM2YY+ThGRhm40w==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:34:07.4103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fc9ddd-48b3-46e3-b046-08dee38a5945
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6314
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX3ans6SSd0bFD
 U2ei3Oi9FcrUClVhdTv79fcNmxxCKsjAr4VR2QPWCPPZEIl6d/Cn0SOj5r6d2TZ8kDiVIFJsqNQ
 sNeduV0O8DOXOjwNMOeVpXDuguvjLCqSTFm0nAZ4CZ3TNvd5N512
X-Proofpoint-ORIG-GUID: oTVgpG-kRr5hepfNnvkzdiS4UxY-mD8W
X-Proofpoint-GUID: oTVgpG-kRr5hepfNnvkzdiS4UxY-mD8W
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=6a595c64 cx=c_pps
 a=sWRNDn+RSbH+kxTJv0thDg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=NEAV23lmAAAA:8 a=0ofrjXTaBkO8tG2pAlwA:9
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfXwtwRpvXERTY9
 o7+EDKOIcagvUzyfpqQuuwmsn2q6xrrDX/++XNU6U1Ba+vLP3M9e5uikdI4de4HZc7lxk3/vaBr
 og2OYW+SFwEyUnyDfS3xLW0D1odR/9cg1f27SkDvXQzDJQJyjA4g3ujYNjy/ATcVFAuPcPWlO+8
 I6d5NGx9ukDPj2XJCYbfViKxj1gos305Cg2J4ov5ss0W574jNTw/ksz9dQhn8dAXS8s8H6RnaRB
 O0gGsxBcgfhsAaoOYqj8pu1RUQkm62xn+MDtLHT4W6E/LPw8QZQ19DJgf9yIbr8e/OZpN/enrAO
 6FYfjbPiA/TdGqV5y+PGsSoWrdnzHCdn77IkyKOLUR3+ELmX3/D3JUglp0HjBEd2+qD1hgiYcNF
 EHksSlY67Iq2bGt6cmhZb5AEu0py0VVIjaP0wKTCiQOT75OtPh4pAZCSwG5DbWpFRqBvY7L3Z08
 neDhmQjkHbxnA7P5pTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160229
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

The series adds few fixes for NVMe subsystem and block device management.

Patch 1 adds FUA support for NVMe devices (original effort in [1]).
Patch 2 adds plumbing for blk_flush()/blk_dflush().
Patch 3 introduces NVMe flush command.
Patch 4 enables `flush` subcommand to all the block-uclass front-end
        commands (ide, nvme, pvblock, sata, scsi, usb, virtio) in one go.
Patch 5 makes nvme_shutdown() symbol public to enable use of it from
        board_quiesce_devices()
Patch 6 tiny fixup for QEMU command for manual NVMe tests.
Patch 7 updates tests for flushing block devices.

[1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/
[2] Link to v2: https://lore.kernel.org/u-boot/20260529034441.2075305-1-dmukhin@ford.com/
[3] Link to CI: https://github.com/u-boot/u-boot/pull/995

Denis Mukhin (7):
  drivers: nvme: Enable Force Unit Access (FUA)
  drivers: block: Introduce blk_flush()/blk_dflush()
  drivers: nvme: Implement flush command
  cmd: Add flush support for all blk devices
  drivers: nvme: Export nvme_shutdown()
  docs: nvme: Update QEMU command for testing
  tests: add blk_dflush() coverage

 arch/sandbox/cpu/os.c             |  5 ++++
 cmd/blk_common.c                  | 17 +++++++++++++
 cmd/blkmap.c                      |  2 ++
 cmd/ide.c                         |  1 +
 cmd/nvme.c                        |  1 +
 cmd/pvblock.c                     |  1 +
 cmd/sata.c                        |  1 +
 cmd/scsi.c                        |  1 +
 cmd/usb.c                         |  1 +
 cmd/virtio.c                      |  1 +
 disk/disk-uclass.c                |  6 +++++
 doc/develop/driver-model/nvme.rst |  2 +-
 drivers/block/blk-uclass.c        | 15 +++++++++++
 drivers/block/sandbox.c           |  9 +++++++
 drivers/nvme/nvme.c               | 42 +++++++++++++++++++++++++++++++
 drivers/nvme/nvme.h               | 12 ++++-----
 drivers/nvme/nvme_apple.c         |  1 +
 include/blk.h                     | 26 +++++++++++++++++++
 include/nvme.h                    | 11 ++++++++
 include/os.h                      |  8 ++++++
 include/part.h                    |  8 ++++++
 test/dm/host.c                    |  2 ++
 test/dm/mmc.c                     |  2 ++
 23 files changed, 167 insertions(+), 8 deletions(-)

-- 
2.54.0

