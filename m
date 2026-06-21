Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB92CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 05:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E22849AE;
	Sun, 21 Jun 2026 07:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="F0OnlEeo";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="MZVfiylv";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="G+C7o9Bq";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="mjwNK8Vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822FC849BA; Sun, 21 Jun 2026 07:15:05 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C4D83FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 07:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384718.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L3iopW1688411
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 05:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=CLK
 paIFhgczGSp/S/C+HHnClgAWrnNfmKL+LpQgdc5w=; b=F0OnlEeofMSuwjkbkQ/
 kmRg4epxVhklj0sAoPNwtNvH2Po0XKO4mi+yBJxhVnJzFkrey1MlPFB5bL8DTkae
 Cq0gWrhA27cvPJbAl44iWD1OywCC2FkFOaDQP7XgxAhYObWoMAcPJ3EO5tQQ+aHJ
 syct/Y45UxlbfWfm0i/B296sDI2PwlWG/lfIwgns+s7Zggb5ZSEi23Ub7v9n5m2a
 UYmaNd+5BQvJuI7nU1TqAM16ru6Pi4BWtuBNOLMLLAD8HbC7dhLb5BfvrVSrfc5o
 tfm0L5vmsSAqTc6zGkzE1ITnDFS0AWZlhigtEO5uiHSHOWhxnw79Trk2ykC36PQV
 hWQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ex6es0jdt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 05:14:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj3HijS7a48PsETKwEphCqqlc4UUEozCXe43pyPAQXAedFE8m8BoXGqUCSsjlT624QMY1ZmGNOMBAKengGSZ37rL7lztpIcdwLwroBMQpYN2FZvhG2TDhsAPwLrhCY+sjXiJEEGjpIp4DHBRvkfYdmNAtmkefq5Lnqn9btKh21cUuHZub4i1m+nl+N4pFmANdAwn4TR73cHQ3WEa+PICYIxxcEytOIkuoHj95vda6FLMOHvQjn3RYKWEE212HvcN+wlCXVk2tTLRa12knQh75A1xZq1I1nghczIwc/QJYQvhLoH8hlEFy6+Dc8VNamh2o9QhNHKZ4phG5Z0zb/2Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLKpaIFhgczGSp/S/C+HHnClgAWrnNfmKL+LpQgdc5w=;
 b=YgNS8qIn2WQ2yRV5uQR5womhHQFTDCnH1s/4znmhwgWQ0v/amXC8m6edBGBnHwm1APyVD70MNqpzIwgm/TuEO+xd8q7eGwNhj3nZmkZVUZk0GeMtOaGq/XzlffNBy9a4UsFIMt4IISKctGmwoa3fO+P+HKDp8OEIX3j9fdnYY2wYNOsZMyL1QJOLRCJc5KopABbGPkQa0KRsCQ7GhMPA1DQ3tJqS1GsrrBQ5LCYxNmEqn1YDC4uYmGoti3UNCspLxZZTng/lYv5d4JZt6JARs3ORFd9BvGvXVhLhyjcbWXxbJHLHP00Nu4B4QZSY7pCGAWcU0R+DLyaE83DPT1R0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLKpaIFhgczGSp/S/C+HHnClgAWrnNfmKL+LpQgdc5w=;
 b=MZVfiylv256PJ2LRnifPY82tOHNeCDVtR3meEhcfT+XOi05+j7utauemrnF3xji+WpXRVOsUom/JJAXjLBBUoIMQwJrSSOSZc24Sp/Tq/W7Kj7urPtFOLMIQJvaYkvQwprKX9xJScCoZKbIgutg/LxRr3zR/vk/QrJbOzwWFGww=
Received: from MN2PR07CA0025.namprd07.prod.outlook.com (2603:10b6:208:1a0::35)
 by SJ0PR16MB5128.namprd16.prod.outlook.com (2603:10b6:a03:4e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 05:14:56 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::80) by MN2PR07CA0025.outlook.office365.com
 (2603:10b6:208:1a0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.18 via Frontend Transport; Sun,
 21 Jun 2026 05:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Sun, 21 Jun 2026 05:14:55 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L54VBU585688
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=CLKpaIFhgczGSp/S/C+HHnClgAWrnNfmKL+LpQgdc5w=; b=
 G+C7o9BqFyK/a/CVrYtK6rXsLzEoCouOVSQP5du3koCwdVi7gEci0SjEsQK5BdJS
 ivlS3pZLzQt+XSyBMrYlyJ3yFtL8Lv7ZI7GxGp7rpQXaH0Lxv/0w7ToIUx+o3HZT
 fVSdw+TNDQPpFvlcLE4wpnEUUr+ROw6tzzz7Z10P3jLxfNP6FiMStY+Gc1De1hD8
 J0/x/ucQ9OcNd/i0erqBaH24jgdGXoGPvpYbxp7RkWjUJTC3709st4F/YK+P4QDe
 sqA3s9+TpBsK7A/DJvviJnMYHcBV0c3Jr7Xe4iaaFDYtFCeKrWyRC5n7hBYkwMno
 tJ0Pyjw4SixVHJ7+3tf79Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=CLKpaIF
 hgczGSp/S/C+HHnClgAWrnNfmKL+LpQgdc5w=; b=mjwNK8VqdItxhT0GRP2VpqV
 zfJsxMp9oOzJqGCX7IkvumiIv+XCAn10DdJja3FdxbgQDJ6az/whicbaajlnxLHE
 GauAVqbb9Go+O2dsY26R1X+ru16GTHnhw2Vh0Zsx9nG+tEaYTqgok2SEFTgedjPm
 50MN2/+Xm8Oip2p9Eu3vOkCH5fixtwHqkjMZpTIsv4oBBVJhw0TumA/jCJy+O6s2
 +bJshgkQ6/1cWCJlytAs6ZGOjQUPEAexr6zg86UfMLv6Gq8i+Pi65SS1reB9thFJ
 QP1142wxvI5+Adp3CheTTTXUNoCv8OOC+FcoeDT6QC9F0Ob78uaKGgBsGwCCESA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9g7g07c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:14:54 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id bAWCwem9PFhvFbAWDwl71A; Sun, 21 Jun 2026 05:14:54 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: bAWCwem9PFhvFbAWDwl71A
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 2/3] bootdev: scan boot devices at each priority level
Date: Sat, 20 Jun 2026 22:14:44 -0700
Message-ID: <20260621051445.1763952-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621051445.1763952-1-dmukhin@ford.com>
References: <20260621051445.1763952-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606210049
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SJ0PR16MB5128:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f98dd4bd-1411-4662-2ab3-08decf54083a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /Rs8kMIclGwDX2JViEsS4YADXtaLn/u94JmS369iG/0CbU8Ek4tcfSi/VLuvi+AlpyzLW/1eredemCt9eLNuBoIlBn3E/uTuEKsJ86nZtIM+8AutB1hBKpwolyGb7WkQMPi2Tz0T2to+IUgWGqRT22X3fngTCgcXaMUiSZyf9mRYXCqb3AkkqOjrr7Vvp0izKWNvXLSN5NjEMmE8bgqVTMPjXFSLv2yYXLOE5/oUFwFYM6HPvDH3CsmWZP75MHx7v7hWztCftP4Sy/+Q4q4lD+k3hsB1Wy0WAhfwLFQqbpYEdrdQDXLr3eGE59iglxAJyR+NgR3UYqZdR174R6q6G5GQczwi5FIc1CoNLbMwxI88nuYPiQOFSBMPvs+qAGtMr/xE0c8CQSgggEk0nEUQdYV/eEbVNKRZp0tZnKJshpws68f3ntYsoYEuKv1ARE6g+FfHLrKnrJBnRr8pQ6thBVqTzfTBrpn4KdPuU1ZcNqnk9tUiXicBKuSyxmIFET75N+84ZaNFTD7Q5g5BYZA2vjuT6y30TXyrRyy9yhDSE/c5DmZ0zuv1ido8DZi/8ah3MIsS35vzFJW+qav1EfepfQUol4lBPFOnJaZ1odVYcGwhwaXIQPGKrarwzL0Q/vzv7E8fQsb+ZoHG3Z49+ZS/2tKxvUULjJXuN+bP5dgN7qL0VgP58w9D3/hrKwkHmF3CEBndKmwUZTTsuLD8WAfINQ==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nLbiTWT2MSFhz/atgg6qpn8wUVjuOP1d/K3xQO78YsXA0gCTPfQhhURqYhV8H1f8oPnRP+h7tqZJdyqqW6fb18W6sxNK+xzqFlKKF6hTyLInwXrfFpCxTQPRWsBVKzv+BjghhWkkKp55wWDZzh75/lkeDv6HIx0ptKoRj5uMKtyRjcwbvx54vCdpeUBxssJMwPcwD3P4IGiOBz/2LsmxdcxiJlpz4lZ1K7oUcvROrWYmLOMbhQjsKaInoOanVOPjALKKKGvj7DkyTPkz4FFbLgjhFIJJaai8Yr+R418GeJ10X9sD4yferoYbSIHn/D5VegGgcVtoVQzLojgQcwJBd1QaEuRTrOVKT0l3oRaAFSIKSViVe64kOFhki8Lpo4fvxUOy1yheJ5WTBspFwYF31y2OrDeitzZfUoPW1L4enuFxx22ObXDUv3yPnb/BZBkk
X-Exchange-RoutingPolicyChecked: XVNW528s5NCiYWLm/wgjVtGphhEGOeGn94Q/eC8grXgl1IMjWPeFPaSbtsupqnQoUk/TgXbiMBibXSGtctv2QT22bV/2Sp8TIISffoATRs/AhmBqBJpEI+AvdJiwmV2NBo0LrGOueZw/duOSat2MPYogCse6J9B7LPkW6YD0FWJMk1f1FcpZMRsr5uZRcHwnuCR8meHyz8WquaeNXUOqR3ETQV1hgW51aIYiVxUoAmt8B1TRqsmXbp2u9AKepCbOhME0qNUG/g/T3vo9p10bOTqwwZMNqKNQB6XocTV3wio27yf2UVb+6dmfuksBw8vysSuG8ayVQdZfY5nhAIcKfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OGkam7epwAv006815mBNOngJPLbdtXs5Qa9/nofoScH+Yd10VqHoTgf0DUJU7HqdgRb083At24Uz3VkKOr1fox9yyu0ERmb8PtCX1AoPjnvd+S8AUmdyhnC1J7VPimo14DO+I7t0UhDiwvsku1e1NRX990XN4s4gJfTvVs0oo73ivc1Rhzr12QZUi5VYCXutq5eBXJaGwWyBU1nk26XA/kQ7O4BvUDZ2lSjy5FBzsSRmRg+Iizkn7GFvP3rsVvJLFBmPN59otvN4RDM896JJNpnP4mpcOHi3hNCbRDeI43IkmJldwcvwv8IZzSZPtjAuBkm7zaNFiR7ZkMM7Oyw+f/9JcDQNrZLJ4KnBDFkV2SWF0PUT6+8bCyHm0IY04QUcbPaWXl0Q/3jiv2fp7kIHNNZGHfuS23p57v3ywQVdpXIb54owyqy/vTSbvi3IwYLEqt9h0Fswh2aR/TwHnEV4Q3/kWqdxmKFAoTYUTmZFIP27nfTIkJzdTf0RdnSx7rCieIk+5bnlw6sSdyydQgo1my7M4hrC+h6xf98JF6Zl3npJXZS3orwbxaXKR6C/3BNhGCXcP1OahH2CxPV7bnsuNe1fsahwT+wen/R7E5NNuLoizh4evBuIooxlbavMXr4XsIWmnw3x6W8Fp2cInhp66w==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 05:14:55.4393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98dd4bd-1411-4662-2ab3-08decf54083a
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB5128
X-Proofpoint-GUID: m1l2n5Se0PDaYqgVqRswZIPz9ftPQEM9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDA0OSBTYWx0ZWRfX8H686vw20q6L
 G57fOQ+rJkVYx7rYqrSGErzl3Al9dP12DCSTqtUZQGtA+W2t5Zsk8N6kKpKOmbtJoVF7pU8qKd6
 vA7JZ+h5c+3v/TsCy/MPhs08rtZzrKELGwIZl+/iLNnCR1fS61t3
X-Proofpoint-ORIG-GUID: m1l2n5Se0PDaYqgVqRswZIPz9ftPQEM9
X-Authority-Analysis: v=2.4 cv=NLrlPU6g c=1 sm=1 tr=0 ts=6a377353 cx=c_pps
 a=vEsArsaSdKs0mJrCYyxDvw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=ARvDHhclS48edyKYUbLB:22 a=cbNQJ9GKAAAA:8
 a=cm27Pg_UAAAA:8 a=WioVj99LH3wGi_Uw6w4A:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDA0OSBTYWx0ZWRfX9t50PRpwBEvk
 1/9C2QHRlb0xoIAB92rpFCZ3pWG9NsKjyZuOrDdit/nUn3iqMEcDtARrF9FjbCcefaF+kWc5PqO
 pvHhLYFOPNTuu0Vwg836Rf/tX4KDc5Af4CM9tXupRSTKA1RKXfUOigqMyCiwfg/1IhOO4frUo4p
 mLG9zff3xZgngYEVgmL6v8bB0+FkBcTa+tibUhR3h2/GUBMmhZ7AcRQcF0rRau97oxjeDvYpJNu
 dO+ayNg08xcrQyRw6KOFGesKuvQsolHp99LvLfdelATyEBOjPLYR8rQLpboUtGZqIFtRLjy+r2Y
 didolQNPFmwpuAUnquCw4qGPrLGyVOGr6OsZ8pcABCY/34BL7g3gisr0XIq/OdpfCDxsoDEPOi8
 iUWaxIYpHOtwNlaVttiO/WqrWFuh24+XRAKQ8T4dwai+mV1qZfwLDeC4wLsDeak2A4kO13Xmpy2
 cFBj2NtM+j4TSLQdlYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606210049
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

Currently, default 'bootflow scan -lb' will stop booting the board if
any of higher-priority bootdevs fail to be hunted even if there are
bootdevs of lower priority.

For example, if the board has both NVMe (priority 4) and USB MSD devices
(priority 5), and if NVMe bootdev hunt fails (in the event of a bad NVMe
firmware update), USB (which may be a recovery bootdev) is never hunted
automatically, leaving the board at the U-Boot prompt (user intervention
is needed, e.g. something like 'bootflow scan usb' to hunt USB).

Fix bootdev_next_prio() to scan bootdevs at the lower priority level by
not exiting the scan loop early.

Keep the existing logging verbosity unchanged and rely on the failing
subsystem to provide a suitable diagnostic message.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v2:
- added Simon's R-b

Changes since v1:
- corrected the commit message
---
 boot/bootdev-uclass.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 3f8dc2c3c4e6..73c3f050c225 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -664,8 +664,6 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 							BOOTFLOWIF_SHOW);
 				log_debug("- bootdev_hunt_prio() ret %d\n",
 					  ret);
-				if (ret)
-					return log_msg_ret("hun", ret);
 			}
 		} else {
 			ret = device_probe(dev);
-- 
2.54.0

