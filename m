Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278D3C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F65E84DD8;
	Fri, 17 Jul 2026 00:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="utQ0CtHa";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="i7BAktMe";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="k7qY7mva";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="ZNICSvdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8831284DBB; Fri, 17 Jul 2026 00:34:27 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC6884DD1
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GK9JpQ3224813
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=53W
 9Xi+tHUiW012xcZ9Mb27jaTf9gamhdlK9ZaIKR9A=; b=utQ0CtHaAiMy0bPKPDk
 A0JISLQw3+kaeWBiYwhO60Q4y7N6SjJryt4X6kqDmPytGcUfFlkRxbkIms9SZx0i
 EM8GMQ+93itQ63I8eUo6tdBdtwAvmOxd/zKpNR2AkfU+ju3tsAGZUrILB1K5CivX
 Tfrv31/6OAwVdMerKAyaFnC0PWNLYBn7QuS7QsNBNVjVOdGammEzCeGFY3Oli5CS
 bW/NG3PYpDg+DpVeWpjqhp+TmBoyB5SKHXp02QSKr9iXzoe/qnW8pWyjFGagBfOv
 DisIowEUcirtA4db8I47dDWFv2tCcSyg/vMDzevij6scV/HqTki2m8pxQsXSjv6D
 bqw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ff5bcsm07-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTGWQ550F0N8Ypjm8mVmdFJ6rrZNZjh8N6MF0QCpD1rZWTQvIoFqkHoNTtHDpBr9Cro956/7umrT8lbF351PTPwZ7f8AXqUsyWUqq/NCPXcbxJ+MHWEcfKoOU8awEyv94LGOl3/sNZqbzOWUGbjOcd5ASKbDepOa9OEcwvmsAx+Kae6BUBeg6E1Uqx+4B509LWH8k1mjI7WDLObVxPCOjT5/kEhF9+to6gWot0kT5aiDA28scDuHyGb2h75uPcaDIQG+8ONU56JOtXI6exvhsDrxySsZJaeVFGXrEiMGKN7wnBkTSgQOmMAoA23ANejkaB2D8ytUw/9oS9rYMlptZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53W9Xi+tHUiW012xcZ9Mb27jaTf9gamhdlK9ZaIKR9A=;
 b=RmTokCfX2k310nX7Esa0EhB4n3oG6alWTp9QkiFxSMDBj7phUr8UeJeJ91gJwf8slHpWSTddv0DiIHVGs1Ms5/RSUW05mOQUmgoLEO6IbKswKZKZi+FXnhYp0vSOMxjkwPERM1sf6uHuSJwJxQSWNBSlOszP6cON3Pd3RlJ6BK4kxdiRXnDFFVpEISL/1JDoqD1gW0STBbtMJcqXDPD8QGEl4FZnqVJ+aeyFywAW37BQn0k5cVA5G+q6c5jZlO6irauPoWAQyvwIqKbJL/pb8TjbQbwtu34UOIeDuXMMvttmgCKt4AzksDWaO6SEX2fdywJtUxyqEdifRyY7o4DizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53W9Xi+tHUiW012xcZ9Mb27jaTf9gamhdlK9ZaIKR9A=;
 b=i7BAktMeMTZu/gCb8nPyGy9D1ZzI3V8LdxP7TkEvXOm1lWI/dW9QWN39Zttsc88kG69O20EXVtkTUUmawGl+3H3oTEWePDVwCUTRzQ34Kmr79j6wHcaqThk9rqbyFM5/HDwiXHDcp65pp00eJn5YwZONh41bMKkPsMalg7ZIJSw=
Received: from SJ2P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::6)
 by SA2PR16MB4138.namprd16.prod.outlook.com (2603:10b6:806:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 22:34:19 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::53) by SJ2P221CA0006.outlook.office365.com
 (2603:10b6:a03:5db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 22:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 22:34:19 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwJC8114262
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=53W9Xi+tHUiW012xcZ9Mb27jaTf9gamhdlK9ZaIKR9A=; b=
 k7qY7mvad6Rij3wKeaK/FnK03LK16/BAaLGNi6bovomFLKrlim+UnooYBKyS7zS/
 7zF9JAPtoRUwAVbsnxNxYyl194h1oHAzbZgnQa5TdQWcqJq/9twX7foe0KXAalC0
 PFAqeqZsM5ipqCVw2bofP0XWH/W6Rx/cshYJLEL1EIPb1CX45EhnEmIkoiQkhheG
 vtc/DJJqz+NyXF6NCzHbuqExPZ/ffpP9fUhqM1EREyz/f/7in0PjmyCyctBtUixn
 +vieBym6WkQZEKfSC9UvgzYT1CBpC5qwhjc9+ht3+ew1FXF/4J5lclCihIOL4epw
 ppYjGu/VcaSMGOHRChkszQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=53W9Xi+
 tHUiW012xcZ9Mb27jaTf9gamhdlK9ZaIKR9A=; b=ZNICSvdwG+2Q4fsKTLwjwF2
 0vefcTnij4uv/hPf+pVyYEnIiVfUPiHrQdH5URQrWzuWSuTzxsUv54vqdmZlJ/h/
 GvxC/gi4FebAH88c400roNUxGKwbTk5/9qnyHm1f8IwP+PqY9rWskHUxsNdEFrxR
 NeetCZFNTLOF89/wTQmY4kZwiNhoXsMHR2l7PCVu5bsMlEO5yfe9pfjde8N3lMsr
 /+A2rIOFmSVARDSi6af8Ygii2BQWT4YaTrLqxE4dvo9pp/l/VdBAz9E7ZKdpJ8IN
 N0tCrJxGQP5/WhnIacwLRUSiHIUN5Dr4w7PHAykPrWLhp/reaUlKuYgYo9hT+OQ=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fc4f7xcvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:17 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id kUemwEjTB4QlWkUemwq6QH; Thu, 16 Jul 2026 22:34:17 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUemwEjTB4QlWkUemwq6QH
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 5/7] drivers: nvme: Export nvme_shutdown()
Date: Thu, 16 Jul 2026 15:33:59 -0700
Message-ID: <20260716223401.378989-6-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
References: <20260716223401.378989-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|SA2PR16MB4138:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f96548e-913a-437d-4d4e-08dee38a603e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IKnvg7lPRMVVBBAjNuepRubSiAYZYAeNqJHd+KMW0rKU8JzSoups0yPPsYow4O5HbPS5QW3yNA6B6vhfFO5SlHV/vAy8xBaHYgr4OYsJMgw64HW//8/0INVRkm6m9mZtC/BqXz9CFv+Z63EgyuWaZvTgeuYoRHpqma0GnsNE5pSy5jiXJb7Aq9zps+9QFYyq+eofsvCM4ZZ3LP59y8WivSf2PGJiEix06d+6Fd6ImCTJQo4Ccswt9akWP/aKV6jQG5cWheUsCRBSfYzJNc168Dw7JFe/sIBB5r8tCsNwlJhr9OMpyxsOAll0HfY0tyPtBMuCaxix23FUNQCoCghSU7JirApyInzo7kzobsTL1QeQ/wQGkhH61i4Fxx6Ij3QpPHuGTXbX5b+kElrrsg/OpNu7PXK9FQcpPji/YbRcBunM3nFdqO5g7PkquXPk2sVi3ghO1aXCORN7zb6pcTCOl+YZadT/Z9CuygZKsSNqkFeVUJHeGqDkdNgXb8eIU/7ImmSy5p/4vdXq55ykhA5taLO0kyJEOhZRZMqr87+3zCwcAIjeCPIL6eoBcrFZwjPIwXmaoI8UL+6avJPWbOub6QPrnM9QBZv9vNNoFm2EGu3FoGCSSC4IJPKnwbIlSpAS7fE7b1dMZmU1LeDpdrnKX7otoX33J48eBxMcLUWKHXx8Ww7KXY7J3juKkTfqld4OgcGMpdOH+c2bCaBq9ntWTA==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NyyW3D1eROVSwH8LexNG1TenS3ukv0iayNmf2affPdL5P2gw8GA41EIoSKL7UcYKhQWg30YRJ0xXgHzXv3bW2liI7xoNebbqLbGPne8JNi1n/kpKzXgtH/rfBU4KyVTLhc0B3oiOzfTnI9p5AGz9kH5jXRNqbeP0fEo7SQKRrd30BEDYUHlhYh63ECQFd4rf3XmVECaAPe9xsHwJTm8GFQ3uJ4V5fvhPWVhHo45oKVXK171XPpnxaHHttTlcUmtRDO/VOUVAlKzaTW0x+FakPkrpPaKJ/okV2epIwa7Qs8EmkOpGQK8DJ3K441GuQa4ojDH8BuujzrOvnm3zNn7AZDmF7D9ae4iAYz5lLc9eiY2p8AF/Cu7qkAShP+7FO1fZzszFt1JZ0EcIS2A8PjQAYXc+N1SISUbyIZ7rMljxjFS7jFHd+ZYmLpt4MylRHgFv
X-Exchange-RoutingPolicyChecked: qBzc271g+VdhRsJHGQgAKa9IE+JXM8NNkvQ6xzLz45LxdAn0bNo2az28Yrl3HhHup+lD0W0uGcLGEhiTUqKG1m3kgtIMEErEZjsRbKR171Nuxjw6HeN+aEbISDyCx3t5t7h5WG98ObMhIHR04fonOtXu7VVgo+lKgWbjzkgG1Gc9uowTC4Ymw9MXj8U+irkq6hqMNJo1zAUAoIC6qAdjqs5d0+TegsMYXmfs3FqbykTgIw7vWWSWwoZMk62uiCKZsdFujqbo84XV549kAcNg7rlJJkgsfXRYLVBzGjP+BzsYl1kPMxEeA33qh/J5EMabWd3pegA2OQMT52Y3nvRGvw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vbbaCD7V0cCOcSvBcPO6+r/cHpbylF64MXpuGR5L2HnsUX48paLGqFMDLePUG7bsxYhnRQYi8XMM5Xv5mHzmpfB+8oc187QEq9eMSEYkxGqSI9ufV3h7R+7ATToc5IcB8fYNexLFktFZRSVTNo+C8iY4nyDnX0cGdLQb6+EWBdq/g3jfVwbwXAlXWiRswfoWGMTWZ6+H/9hDjP1Mg4Hj2qGAGUjqDTa2UZDaiC0GJbpEH4cpbiMyKDjzspdUTBzWkiLodWYaNFDVXMBaKzCtiIfIkwmdqs+CV53FdMROSlm1GohHxBorwg4qc8Dc18rtBU2ysWqjlSX+y9US3weou2xQTIIzkneoDuo7JGyp4M6qAjUt3nWcKVKsCS+cOGJFkABEvIUxlJUVjp0Fx1ex40sessrlNbxKPhCbcT7tYwDpWYRAGg9MgHEJgM8I1YQFSdwmOdZ1AW2fiJKskIYNibMQmRkpTAel9fDxRL5jYDxqjAmErZFq0dmIDSdQtZf0c1DD6CARYARK0xaKkUafqs4ylB378i2nWdSoE4WrXJZXkeNmGBg4ict4o3+KS/qWwazF05G2+c0gFyJBtQFc94ak/6ibpGGdurBilVkedaNP++05UBJohm3HT1kVKOOh5498fRt52dTakr4x1vJ+Nw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:34:19.0081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f96548e-913a-437d-4d4e-08dee38a603e
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR16MB4138
X-Proofpoint-GUID: u581rfylKjJ1wWqBuRUcHykLjLtTzwjQ
X-Authority-Analysis: v=2.4 cv=fLIJG5ae c=1 sm=1 tr=0 ts=6a595c6f cx=c_pps
 a=IFr6uxAXmWssV7p2N+XdEg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22 a=cbNQJ9GKAAAA:8
 a=Ien_xjyh686n1DXYAIcA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX+JoEktwv0Zw1
 XTKyhv8kuAgO3YwEaKUaHWHMqrX46NYFKCNAbIxEpAsPcnJtKE6X0650Kh1W0GoyuWF2v9f0vqb
 KN3KhuJXhlq+6/gGoQZnXBWK/PpiTE3OrfT+DU4xtV8+3AhLm59e7yvqKgMAeSnsG8rvg8H05OW
 cU9kcMiaJiWFIUJic6HhatBXSBMpuWes3AA4YFF/ZpKf8nz9ayV5F74XfnS+zNpafm6TOqSIKJI
 53sf4njweRNwOrIe4ilR84tIDQpwCsFqyOC9qgxbUEB+E5twI11he+NIrgEIJga9ulih6S24zEn
 5o23f+gtyzrcBSpvKFLiY5zAmEeIGXc/HpGr9vAUY3C56IqvTu7jBIMhbqbhiXQAo+1UIvkhHhd
 Vqd8XJeld6hZgE6+PezWQGCdWI7RaJhJkbpA/PRiyppMRrh94O5BGdoEUNxqMfWKeW1XEsY6ylS
 xquH9Jy+L81B/+FBJYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfXxnsrLdDo0Fja
 pWh8Ic9kt2NsOKBhc5fLmCHwHQO16HjE1f9zEl1ZfKEoJtwPER9ebrGKHL/kn2EKGVwDbkfTPuS
 EOkyy6Oa6GdYom5Z9RYfZ8UM1oyufS3BpzGjRowcKVYZRroPKo0L
X-Proofpoint-ORIG-GUID: u581rfylKjJ1wWqBuRUcHykLjLtTzwjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
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

Make nvme_shutdown() public so that it can be re-used in
board-specific board_quiesce_devices() before OS hand-off.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- fixup for apple device

Changes since v1:
- n/a
---
 drivers/nvme/nvme.h       |  7 -------
 drivers/nvme/nvme_apple.c |  1 +
 include/nvme.h            | 11 +++++++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
index a938da728506..cc1477717391 100644
--- a/drivers/nvme/nvme.h
+++ b/drivers/nvme/nvme.h
@@ -703,11 +703,4 @@ struct nvme_ops {
  */
 int nvme_init(struct udevice *udev);
 
-/**
- * nvme_shutdown() - Shutdown NVM Express device
- * @udev:	The NVM Express device
- * Return: 0 if OK, -ve on error
- */
-int nvme_shutdown(struct udevice *udev);
-
 #endif /* __DRIVER_NVME_H__ */
diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index 7e7538553e3f..a36f15a3ff4e 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <mailbox.h>
 #include <mapmem.h>
+#include <nvme.h>
 #include "nvme.h"
 #include <reset.h>
 
diff --git a/include/nvme.h b/include/nvme.h
index 2cdf8ce320c1..c7b301300097 100644
--- a/include/nvme.h
+++ b/include/nvme.h
@@ -90,4 +90,15 @@ int nvme_print_info(struct udevice *udev);
  */
 int nvme_get_namespace_id(struct udevice *udev, u32 *ns_id, u8 *eui64);
 
+/**
+ * nvme_shutdown() - Shutdown NVM Express device
+ *
+ * Must be called before booting an OS to ensure cache is flushed
+ * and the controller is in a clean state for OS to re-initialize.
+ *
+ * @udev:	The NVM Express device
+ * Return: 0 if OK, -ve on error
+ */
+int nvme_shutdown(struct udevice *udev);
+
 #endif /* __NVME_H__ */
-- 
2.54.0

