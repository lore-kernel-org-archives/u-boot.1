Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51446CD5BC9
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12D9846D1;
	Thu, 28 May 2026 03:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="C57mnWOE";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="ZSa3c+Dj";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="ihee4GpB";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="mtvJyWj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F7F84903; Thu, 28 May 2026 03:21:20 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C112D848AA
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64RKiPjE1563853
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=yfn
 gkFPFq9wiigKV3QntxJFpLc4gx8PlBFV9SNg/1uc=; b=C57mnWOEcrQP/k6lQsX
 EBRUSpEaEs6VLCCTNMhKK4tc1AXjERQpQxAkQbk48iyZmRV3cbk7rt9JbGXtQxkX
 BPvcYSrUePczfV0cB/uKkFm6cybZsY7tIX6z6a6JYBR9qlUsFaB0sJZhdlvR6dQ1
 Z9oTKPn8rwxmFd2JkEM2fedSXFnMgHTyUO9ywWl49qwsdX2tcX4C1Dg/lIPJdLx1
 wonjQGtRIaI1PK64cWzvYSKB7Y8FtfMWWqxn4fB8Blzhbwg8uZPwhX+B+o9RvV+V
 nt6givhuP7tfp2YXMfpO+I3txUvd3LEdLFiV9HQYd76VRbe2eRguQZ9r33a8mA0T
 gzQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by m0482517.ppops.net (PPS) with ESMTPS id 4ee7ws9cgg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu05tATgvsaeqg27o88UHQUB8gbKIYojRaL7iAxK1H8YiWfpQWKeHJVEkfs2ND10i0phvfE8vnD9lS35eIGfmFXpUHliJ4gmq57CrKrjpjlVhsWY8+c1gB8+Q8muZmrArDZN163zxSEEhdVlBz5vnIyecIKBkEUTEKV28xnybzGYzSyc9t0kY32iy0OQBAZtiM6FNR+ijv+War+Rwba5JnWsoaMQ1ZqQ49BAixVcHl4AnUN3lgCAALk+WapH0XziFU3nqzyCa456qbbD1Lq8+0VkcHaReHM53GoDoctizfiAgy7Z5ov9jVboVuqJgmBR09IEW9/vPkA5wWauiNZjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfngkFPFq9wiigKV3QntxJFpLc4gx8PlBFV9SNg/1uc=;
 b=HWRFEzSpgajMqv8wgXfnhuA2tAzCoUZfe/sJjKIPl4O5oFyP3Oc/l6Z7YrEv3jMu62QTXMzWp9APJOuzqTDdE9YFwh6tvtkTHW6XD7x0JeJ5M/Ybtics4s6F9ll3tUdEO6naZNoxKT9qCLXdLXhsS6Sb7O+I3ktU8pJbc3HMlQqmT4ChJ1i3os9mXfgPYqbEQCj5wzRYtBAfqSd8QhMglvibtM9gUljbx0W2dCoa05Nj2l0SoN4XVGHQFU8uPf5jFIx9qIPerpMNyn9PZ3uctuoe7gd1ixZuRUxx7QKlyyLCK65G1PiSpBb1rBRK6S1BXi3nnwTdlCMTcZwjtm5ohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfngkFPFq9wiigKV3QntxJFpLc4gx8PlBFV9SNg/1uc=;
 b=ZSa3c+DjuDOU/uv2MJi8AGAwFdHN1lAtU8Sx+QdTEQSvZy9cDG/gFqrWHff9nATjK+HPL2oxtsTYQ+kFtJc4U3Kr9pzV1ptrSGl9PGBLjkSaPUcfkD6YKySf5O/pSqrRuRxhi8Qx+ejtf04K+5eXEv46+oG4bmZp/P5MXh8OI6w=
Received: from BYAPR21CA0030.namprd21.prod.outlook.com (2603:10b6:a03:114::40)
 by SA1PR16MB5517.namprd16.prod.outlook.com (2603:10b6:806:38a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 01:21:09 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::9c) by BYAPR21CA0030.outlook.office365.com
 (2603:10b6:a03:114::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 01:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 01:21:09 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjE4r2743665
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=yfngkFPFq9wiigKV3QntxJFpLc4gx8PlBFV9SNg/1uc=; b=
 ihee4GpBHZaylC3mkkFZKm0nkd8ACQ9Rcd/cJM1L/yRrWQb6Wt/e+moJPEf4AWSF
 jem1vE/jPIxAfbuWwfnb6K/OD8OuzUMJJPOpdbm5UA+m3OCe5i0dtt02PCq1bG4f
 JBW7mCVrBbOrq/xZvApuCWOCqONxeCtK753gfNY9bwdspIxIIm4Z/3BnS3/44+vY
 o60Q+znSWttmw71eQhEnrk5ULMif61+0/aY2Bj6fLojkFQLQwp1t5PW3mArz5t7C
 HE9koCvXQOG0KyzgwDJYQTAibmVzs2CdIXK19EoSUi6/uXdTGxDnmfQY2YVSgPAK
 T55pliXxw2NZbrl3ed+FvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=yfngkFP
 Fq9wiigKV3QntxJFpLc4gx8PlBFV9SNg/1uc=; b=mtvJyWj2HM2nlYtavBjo8Ql
 oOntLPGymo5InVRpP0IxwCGa/+eti4/kwhZkqsgetNFwWX3Kq3Ic4d/k8Xl3L3Yg
 fRSUhnY5PzbLodxjkVNPft0vn184NzjRyJprzZ1onywTXk/wGDFEs4HF0UNFjwNU
 uyElYKPDI8eFhwfSHBHmIfuUJx39vcX4aA2CEQDoz+45UfhOnIlPHW5BE7+/KWrn
 avZhohABAEINQAdQwCbDg9o8AAzA/xsvDEpxflkJPcYt/yTekSxT4Ads86JFIYoc
 iViOGdyoKswA9yKRh6P/C+xj0utina0PkouYyXDm1AU2d6ChrqLTCXftY3Gow9w=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x5r7a5-11
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:08 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SPQowyKpGhUj8SPQpwwC2Y; Thu, 28 May 2026 01:21:07 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SPQowyKpGhUj8SPQpwwC2Y
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 4/5] drivers: nvme: Export nvme_shutdown symbol
Date: Wed, 27 May 2026 18:20:55 -0700
Message-ID: <20260528012056.1744362-5-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528012056.1744362-1-dmukhin@ford.com>
References: <20260528012056.1744362-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280010
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|SA1PR16MB5517:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4e8017e-9031-4f11-e691-08debc5765e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0bqIXKFUOtR1X5q9kN91OVYd3d5iOZbHwyabAg1GfOGUJ10SulWrVBdG/7jQ014+Pg2xsYb+YrWu/xEpJk9PqYhSeboDXiOd9LKfB/idBT8DmlekbmK5w7JZ1fihXWcU6hBTtCT6lmb31apw0zQ8F7/oOx67+DxUdXkUdZ0UU6WlokTRvWna61S74FdUtYwt5W124MX/ADAb4gjyxqshJ27/s8lxthSSVrEi0f1Ae8huYwppPiDEnLMwDuHkFIeMPN/pR1jdhUK34O0vS/E+04SEwM0DX5w1anaVhhfK92clp0I0xwEmxclkA7OxjjHeMcglSI5efyFuGC50a19uDSnyuK1K6vbevlV6lDM4OL5eLaEWsOhUOiB+DnAIMN+fAae4oiZjgN9alTBTDvx0ewENGOwEF8fVDYeR65naRJfj8lWgKuCL3kh6CozD2mLLW81a4qD3y0e9XbdzMPDkrB9YV6Sb2ZsvbE7UV5AlfACYG42PdLMWiKr/slXfaz14kG9efyS9N7ZralxKJGbbaeeiVlwSUeKfFP18UBCZdcaFNitvCjuHcIowfh7kKE8a2HncPHFpQDHdLrlsAY2STYLhU/UCf2unRHVegxjbRSZlRKyqhFyMfkvq5r2c9PGIBL1LP0WvveNCWnnQ61nwtMEEjbmWfhJLeNr4UFU/ye+87tgaIYYOgb79/ybculk+6C9Jte3db5MAtRg2et9UAkAwUJkyZAmYSK5fVCwucbQ=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B8nLmm4njnxAXwf2u0rsuak/mBsD6gvfhAyvojVaxPdsBMRp5udfgktKYLMmUPoT+b14PT8Fi22LXsduvPURGZnCaGbrm0K/J0PPl6pvkUy/Hqfsz3b++KiEaqdRMbpQrcyz4NY3rHVJhPE1poHSYnxWoiXJvuKDvyGixjpGwfysuc/95vGT3tLBDBcTPYy0OoIGyDw9N+EpcBCfmndIJbc9wcMcuSicF/xOfKS2IbQ2UXdCH+IbtYjo81Kozl5rRV20mPsEePuIM4QRhcqHL/GwymWsJZ6D1cD0I7FmoUbADjM7gQzmBMLU3fZ8ALW97GoGB2+RHDQsH/htczGG9nTyK8V2h71YE++jToGTOjDON/6QtkwLXafTJFPPADYeVffWHqcwcc4JGWmo0r3CiaAZeU8vozE07ksft+7yYTrxeUqVLjg78bhbCR68PCrX
X-Exchange-RoutingPolicyChecked: OTH3rv5vzY3qBRQyLBMOjaX1rbM3mu+9J5JNyeND0Rcq//g3Xg1E6dzPFbuFKde6l25m6T7YdZKzzTiUTu4wN3CZrGDvy4s2eXTsJi7doSC1ej6kfS9CLo9POtlHVVNIvrxreN30VnipdXpxLlSUMMksevxGUOJIq4W3LERMzOUvceJMfsKUZoG6ye7ub8Po1o9MVha7ArqhqGaLvFm5e0AIK4ApuPFHfQSixsdiS0LagaS8Wubaw5WMFOpcTrES3WaeH1K/hTkAD314NH/Puu/DrzXb6rqojcKQtN0ENRb7kT/yuwyeMacTfJ8y7C3rQzAozCg1Zw2N7eMcUMLZBw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: czupslY86NN3hLIM+DS0XDiItbgQLKz015xXfg+l93y46brfuz+YsqH0waBVs7h2kpo+1lsL+AYJ4Rxp7CFrRDGBxNkGUWb2XFFt/ORxHeFAjsMxQk1Y8dEw6RCg+4LWGv+WCMGt/zTARlgP43+XMPGUJthUxldgMAL8hPF0FshtiNTGfZc5dTcaiW5XtJlYwEfNFan4HBxQsYIB/SEAOnk7tbObcGxRRloGl4ioEtpTxWM94fIvfiWd4DDZive3BD29kCJoqc62Y3V7HguthtvMdVvAX0A4cn1LGHhseb8Pr7dEemrFRCdM+dLUR13rpId6lZVsIuXIlOinn1Dyw0jTEV06bRUE7msaFn84iwiBPZ+Sy1wnRvbNR5pabFQru1zHza4WxF1LGPvXPdqh0CweieUc+1YBMqIMhD7IoKWqZKlRiXOevYsOtU/cNQQHnz7vLtX1GySbZTQoSpBfgFN8IhCQ7t7DaMlXDUoGoCZKiw91vsUKE6p6XfnM76TTMy74HxGS0hoG6WRzvX1sckJRs2Jve/rcTmXBAhLUV76Qrkv+z2BgJVbQDUndlp4ABB1/DQ4qmoQGAntjfNGppQ8n61SKouEBgCQKJTPznLMMUw6BRrAN2RA7PG4Ni/wl7TR1qzlDDfTIPhx8ysKijw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:21:09.0102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e8017e-9031-4f11-e691-08debc5765e9
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB5517
X-Proofpoint-ORIG-GUID: RCrZJVVLIJO4MLz944GDo_MIazqUCGo3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAxMCBTYWx0ZWRfX6Jh8kKMtt6rY
 yzTXdX162HI8pWUargeysbIxGhii0gbnkBfVSIkQX2dWCG/E3QI6gYbKzLN5/8SQHBJd6QwgeU8
 c7igNl+ZI+XIxQe/VK91vhtENzeNgkVzjAXPHl6hMmVnJOmTpS4rYPn9VJxom4nyRhM2VOd5IOw
 D5OHWKcC0tJoBHNmEiPzWhoKyHR79ymGbKo8p9XjA8kpL6AXfcVCi6OlVeYc2iy7ZVeduXJAA5q
 fxbs3aFGd3iLQFTxe6I/wJmI2k4rOa2mOBWVjtwk+fClCIvBrLEASswzWE+m/3TTg/dmFUqNS/l
 FkVzLEM7F1jcNGlmSA+nBW0lcM+LXA+GSAj7Ej5D9ZvTYTkA1MsqfEJXeKY+mCyiU6OByhM7J9i
 Q84k6wUbW9n3jVaA3g47twECpRU3Lji6jU0O3huQx7NYM0fJncT0munS1lGm8L2Pc6i1+Kq+XMe
 Au+naNEuNeTdMHm8IwA==
X-Authority-Analysis: v=2.4 cv=JpPBas4C c=1 sm=1 tr=0 ts=6a17988c cx=c_pps
 a=sAaYeWWHS4LdRs88aTULxQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=cbNQJ9GKAAAA:8
 a=Ien_xjyh686n1DXYAIcA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: RCrZJVVLIJO4MLz944GDo_MIazqUCGo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280010
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
 drivers/nvme/nvme.h |  7 -------
 include/nvme.h      | 11 +++++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
index bc1d612dde40..25a8b0b17772 100644
--- a/drivers/nvme/nvme.h
+++ b/drivers/nvme/nvme.h
@@ -698,11 +698,4 @@ struct nvme_ops {
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

