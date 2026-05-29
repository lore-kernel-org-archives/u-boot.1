Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FBACD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C542846D0;
	Fri, 29 May 2026 05:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="dcaA5+LR";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="iWEwOsMU";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="U6PHuOM9";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="l7GkNLzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F61584671; Fri, 29 May 2026 05:44:57 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7746A8341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T1Cg7Q377486
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=TCz
 V8PEpvGnLgux+b78BbgAwghKSg/dapPxN4I0xk1w=; b=dcaA5+LR88jOlhxvo6f
 Sdutb97kibVXW1cLwusc/qE138TO1ByI9qf8G+IzYIY+fdllSr1GuviOfGJPAwku
 iRcEtyddVgQr9+4qFYuCgaWJgvD99a5y1RkcthX9KxcRdziUD6sPEFwRLJ97eKkH
 o+JcIpoF0uNvP4kv7jL1EcK1yUbL/leJiyzDohwjwRtWzjNDsfqTLPpC3KK0VXaB
 7zEB5IXHyvx0kFfdiliFf85ExnKVnD89Pj6FQEDv412ean4OPYHZGAM5DJBybtxr
 OJIVCfJ8N/860l8VzfokmIDBEecRKQxMUHlGfem4A85f///ve7PqXQWtUM1SH8dR
 TiA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef0x88myx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:44:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1Opdu5+us7McY5iJ7CbShbPBIUiPrt0OgQWCouXW4SIuEWgW+ft4MGjtSjFhTKobadEDetpVQl4H/+LKTOjXTqxYxRmWfSjcLJxtRsP9MgQLbsyetfkD52nAyFoabQ66f+xvWKIAcpz/OjnKNnGddDiAO8GfLPCuhf5Wfu03mdhIB1y8xN2EQPXDI7xpRgEaZt9HXH7yPj2Cgvbx3Cii8LSvdZXxUs3UCIl/0nHLS4avZ2Q+eOnbsPrchdmtDRpauRPqnV1W8TZZjn7o7/DeZ4wmPiMLaJV/iUe/ASY4DTQEiNX5O5o3A0imft0VtWEeTCsz1Bi2ZUxcS29aKg6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCzV8PEpvGnLgux+b78BbgAwghKSg/dapPxN4I0xk1w=;
 b=lYDSXLmUsSsmLQ0LCkrv3V13Pk/dfh+AwSPZVxV38HSI96pNP80Pylytun6LCYCQfBlRiLZkwNtHQKdg1cMBp5JckEh97mBDxCd0qK8xfbLRJbCnqzIGBCHbl/G4hSo1Jeh0GrmLy/MFnUIvMt10l1WFJG2E4IRi3fEz0Q8Icdhf/PPvsQmJP+m1h7KqJsbyv6VXV5gX40qRKYU3T6ER0/BqlI8mS9OZyb4mJ9ci9KDPme3xEZtQaoHfXSEsiGYFq3FQjnz+FpZ+eiPsqhqLOsOjv1Tef2k/m+CYk9tIlJ1CDqfkRFDXNm9vyAlr+eR1WJ2Qyr4+0xdoXPyX19hKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCzV8PEpvGnLgux+b78BbgAwghKSg/dapPxN4I0xk1w=;
 b=iWEwOsMU1l0Rjd2nsMdWlmJe2uGKrmZiu+mA1oK+OTJcsVexnykB90w7J63aTHt1Eq4GrpcHzwC9F8u6O7DptWkfnRwvRTDh4aE/T2OV5YbmJIBDmiSUoKAxtOb6824WAlp5zu7mAR7Zia4paq7zTgKEGyBOjptwrAz2HGDxU3Q=
Received: from SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21)
 by LV0PR16MB7036.namprd16.prod.outlook.com (2603:10b6:408:343::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:44:48 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::e) by SJ0PR03CA0166.outlook.office365.com
 (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:44:47 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T1bXiT3408081
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=TCzV8PEpvGnLgux+b78BbgAwghKSg/dapPxN4I0xk1w=; b=
 U6PHuOM9jyN9PfG00LdH4BtNVTmEmwklLV306hrRQwdVYdQ1XYTEh/qxY2sgUnBD
 XcnaHu7vKnEs4JrLrphid5r9cerRuo2lplL7wKXKWwwAxJSXR/qbnazO719OBLEH
 IIn35I6eWow7LliKDERnytUBtN2333KG2+E6Swak02eQJ37wkET8x5MCC1D0YA2k
 GFDf8U204kZL9wohnR4MrKovNxuXFaU8FxwwPB8zc4IskVJNVcrThPWthEevsz7p
 EWCDcH9Eq18KRqtUL1WIVspVe8/nqPfSfAF3qgac07QyIG4Bg0JU+wWW1FluEYEC
 n14j7HuLy0cqlnUYb9XHXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=TCzV8PE
 pvGnLgux+b78BbgAwghKSg/dapPxN4I0xk1w=; b=l7GkNLzWVCcw4wTR1Gq2exD
 RkWeA53ktQ0wmAiHKRzXzpXQ4RyG6iCJNHMbzK83q1wlZKC/pJVNaNUbgtngV4gQ
 Pg5ab9uM6I6hFjHHOM71zzXp1Cjb9KFj6N1VRL56fcraDxVQ3+4s6m0Ucdp8DNLn
 Bu2TK4ucBp8SB8zBomHmFi56mISCCkPpFxWgoh2+eqrmxvrpckZ7Yb3go7CrJ7Of
 6Xl8xgYhxzeoSDz7BKaY7m9BPqOpPOABEnARSFIie7bRmAcjkiYUWigQGIV+JR7x
 4c/xeEPsdKE3hk0mdEKl+vI1LGAq5AehwPSwvr+fW2nPxVLG281i6DORb84ouBw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x9hudk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:46 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id So9MwZRcrpOFESo9NwdJPQ; Fri, 29 May 2026 03:44:46 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So9MwZRcrpOFESo9NwdJPQ
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, sjg@chromium.org, trini@konsulko.com,
 dmukhin@ford.com
Subject: [PATCH v2 1/6] drivers: nvme: Log I/O timeouts
Date: Thu, 28 May 2026 20:44:36 -0700
Message-ID: <20260529034441.2075305-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
References: <20260529034441.2075305-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|LV0PR16MB7036:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7547d7fd-030f-404b-1ca1-08debd34a136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QdHsLp5slpn13sSpdFQ4ElYv8r7I8rkP6Qk+T8siyXJ29LV3HLro+b0kio+4j1aNgMMDuAWWE6x8x36tB0p7aknbRR4IDd8ym7C7wqDZZal3Nh29KcmvY3ftTkBV07LCLq4oG8xIBRpu+s2AedEovRaRMw2hVRZ3rGeBk2wSsQJJdycXkifI9qwyFMr+CT6pqX1SZg8i96uf6wrCMhrOR3HOOacGAKz75LfnVFgI5ptp3KCsyLlrN5kahhxQbC2OHLuCPCaVSLzBTDLVspty0x8LEWpKhMd6FMDmmFsq7TzUYlPxRuApQwgk68z9VU1pCJH/ax6vpto2ZQ9H8KMhJZpNJWKdxs2YbPeX5UUh7DGC4pWcngndew7NB3m+HbN1mHYNdaauhkYZul1N7p8zujz0DcudMAwMAd2EAIugWV6vtyZJesXszgk3vpDTlwnDNqhCLpkzANKjtcBTL6Ql6InLPbQxaRwwoPy1+jTtly+TpFWj+g2Tb58zsT6QaxVJ71bhHfsZZ9swxRSnA43eP0OYELHdNauz/RMyFNnGCEHdZ7RfFql0D8EiLG1RIbKbMX2JIs4wv2oaGrrHjrSTHdoBGKMJIvEKVy3+Xw6NJ+Ku1wn1h341vfRQ5T8smGnGWHcgdc617TJvV75YBWn0HhQUnO/YkCm2L1ibn/cDpZokoXCrBzxf9Lx0/iov+1oXCZpi/Sg89z7lzwxZag3E36jkgnLTzoHN7iOYT4MnTh0=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DCMjfEHW4/BE9v6a34O6eO+c5t+uG6MDFUd+jCrexe7rt46Kpz6P9y95vwsNazIPGVEvdhfZaRGUuo8Wun7xu5wTlP0v9E3Hx71hErfAlRPgdP9cK0Ird4Xnh2YEfWnuyjv+AY7t6aI8XSPsDi2vjt+1TjJ+hM4659TN1+O+NY5IfScREZyJGd2/+JWoaUzgOothE9IP5Sgyu6PJk2S5HCQe2oFUianHHkfSk3zvrDfsxqImB0VquoKNhGklCutQNYdjgEK7HGDELAUh2Lx//4Xv0I915uKFo8prvT4es1vKHNfh03voHpa1iT2JkNdKDGq+lbvbgECgqxpn2qmowM+cxR+TZLlN8rhpUoDcgXBEdD5UCg1TO+6r/Hlk353hReN3ABj1ZZHmjSjITpwR/wq0bP6UJdPU8e+2pEUb9k6n+fwiAKrbvcta86lozsJ/
X-Exchange-RoutingPolicyChecked: Gqwx1u2HN/3FODj1yxAVMYkSZYB44orm4Lqr18NtZkxdwbSy3uqPaD6CJreU+MpQFa9BINqPlfutPp7vC74mG/6RpTjsUdK9D0zJp3TdLmocDdVjT13ywjTnWxHgcm2k9aREW8Ui3v5DiaUcpWNz9TAc66I+sOcU5d2bTplxLUozrZKM0ZD/8HL1mwwuy1QQh/oUjOEOahgs9APHsnn1PS1qO79g+kLvI6rhDLDCqKFzGTdrCiTHYr7E03myV+UFmm09z2PDS2kKVvfFP6zWUWFICIpqvjKpNiAwa9IqdUpXsAQGq0zo5gNU2XBc9X+7u7Il6t80fVLzcWrA6CrNJA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IhzCIrObTDho8CNhImrbl6ozLo0wxzLkKACv3xOed2T5uDuUx20AYguPs8fTjvO/enrF8HY9rigHQhZSfYcS9tuFzS6wKHw1QJw0VbzHM9VguDxtOGkIHC9bv6kEnoldeF0g/wDI679kXJ3jTJi7LnLrsMASs2ZbHo9Q3tl91SXQSI8le9Gzt7pZMeZ+fbxr7TyuTw0cIPAcDKwpxIsNh6CXsNNT0Z4W8RX0m3QYk11agx9G2ht3Qgbd0Pm3Aw7Ewc7JTR6SKxIgeWW4rOZrmegxTtCE3A1TyZLjqFwmwfBvO/TE+cqMrFKYirPCjYpNe3ULa5619OoqTN+rE/a7/SXMaedDGuq2gKkJOv0Ex2CrA+sDEOTPihR7Vb7zF2PpLvd4mzpT5PmqaLdBHN/mRXcRgLimlSToNnhRN7exulVZt570fo6zo1ORN1sk6zt7QWZIt8OlVZKidYzvcpxTdBE8HN8s87gln3BYsrz4tW0n5l21kkv2do1CU8LZRoK9QWyeBThf2TYwH/w/1sJqL6p/OAQ7AY/JbnUcRwyBJeiR4fpblQ5pyk/mFfNB6bnUCQ0KETLf4aFJfhhXpNz9hsTUZ/g+fpAh3P1KFKOPJQVjNASaO6ONo7frp4WblxHJAuqKHB5iXACTY4eXCNfF8A==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:44:47.3321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7547d7fd-030f-404b-1ca1-08debd34a136
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR16MB7036
X-Authority-Analysis: v=2.4 cv=coSrVV4i c=1 sm=1 tr=0 ts=6a190bb3 cx=c_pps
 a=xtX6lszn+wSwJ/mzueWfcw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=cbNQJ9GKAAAA:8
 a=KKAkSRfTAAAA:8 a=FM2k6mJJSBvnV0fzvkIA:9 a=P0bj-C3X3jJDpopQwM1U:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yG6XzOV8pISEHWWyUvV4hNz8LhNkXOEX
X-Proofpoint-ORIG-GUID: yG6XzOV8pISEHWWyUvV4hNz8LhNkXOEX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX0HsFY+42uxXw
 8KhTw0tkyf24nzRSe+2aB4J2apUvIF11hmvOnWwtppWtuwNwH0xikeT88QDFW0ZG9MAVe+6NBA0
 sps+d95fRs4uIZZzsaFEUvobNrUh42W/M6m7Q2bnB4iSFG6uYpH3PB2/yCRz7qguBmU/gJVdNG+
 FALdU3uujRKTxbdQSshCrL2JRMLbv05vBWVHASX9xli8rOztp5xOIngHbABDaklbYCkN8eAvYxf
 HaFDAokef8kgy2qRIN6i4J8pPzoLV7l2XsFhlLb2JcGeY3rmxXU1T8kdMT78cmETFbOHcFslOjT
 GbXgWddadSXnI8dtVOYpJmKvXyihBn+zKnj1cbo4Hbs//lBc614BcBvRkI6J7nMXcVUYlsMhrOP
 zf2/Qvv2QhbcYXhfBMQlP0co/JLH+nTeD+Dp9mNLtzoxgNSSzZDa0YUDFGcGC121j+aj/FGDXF0
 jb92K5oK7fjrYzl/jwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290033
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

Current code silently swallows any timed-out commands scheduled
to NVMe. Log those to be able to debug any potential problems with
the NVMe hardware/firmware.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes since v1:
- added Neil's R-b
---
 drivers/nvme/nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 0631b190b978..c3c44e50f19a 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -182,8 +182,10 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
 		if ((status & 0x01) == phase)
 			break;
 		if (timeout_us > 0 && (timer_get_us() - start_time)
-		    >= timeout_us)
+		    >= timeout_us) {
+			pr_warn("nvme: cmd %#x timed out\n", cmd->common.command_id);
 			return -ETIMEDOUT;
+		}
 	}
 
 	ops = (struct nvme_ops *)nvmeq->dev->udev->driver->ops;
-- 
2.54.0

