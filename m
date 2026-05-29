Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF09CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FC084867;
	Fri, 29 May 2026 05:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="M2PLyFJD";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="f9C26/S4";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="gar3Z9BV";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="bGCVUaFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC4584837; Fri, 29 May 2026 05:48:59 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66388846D0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3U4422121829
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=SF5
 EP9XROMj4zVTokcRLq+k3FV68aOiD5U/SJEPoQ8k=; b=M2PLyFJDQHnjsmxoERg
 qRGPWY0cJWS0DQevrYNIGPyMMiBbIPe1MZLkS91kBzZuf0WuGHIGN6kv5mftxFhm
 Yx7Enuoood5uIvrZt94jBbJzw4ieSdVircKqOVFf93EAk9+DXvgFCQxN6osQDsCE
 B0uRz+1XGUUsw0m6stNZGEnBQuszT5+wc5QQnAJBAlC9a9uydY/A3Oa14hWcGnZu
 JcqDsxbJQ4e0afmAJw98dYoTwfdoP2WdJRrEBQ0yr782aqmgYSI0FOpdpiMnCxtk
 vEYKDoawdxCUjJ/GULblOq479vYM+kAhAeXRez3E8BwrhiNKEMIQu2eBVAqYdrZi
 cZw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef2xx82k9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XauIAOKLPiz3mHgF+2oiCO797gqHjIBGVARlYdF6ibUpeyiFY3ctiALEtVLnBZXjZNwg2UAM6Q1dytUC52gEZCzNGmlses7Ca96BAmVzpH4i3R30mVzErRAMajHlZLSu35E0oxwhqeNBD2i/BtP2VVz47OOst5YRXTrqK2lFm7qgp6C6t5aAu0dDW2YJ/GEX3JL4WxCFVEpnh4Tf4Cmiwo52Fq/mstBLTiVdJs+V+GlSLeyvJyUC1waIft2a38SDJsBlNe/D+QhboEs8J33ZnEqCFDnI/wDgbZiZS14Aecb2nJHnGKEPxnrP8+xmZVlZhupk1Du7fJVTf75ly4TBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF5EP9XROMj4zVTokcRLq+k3FV68aOiD5U/SJEPoQ8k=;
 b=AQwfkiQzSuyxNi2oO5Q6XqCveWfC8HrHmx4MdFYU4huJ9vbcsQRTmdqSjhhOKvTEWwMRm8XpDQDmAi1b1pEB0wVwPdPsgP4jwf5wGDQlkH1PXGOQz5zAhmcevrrBMOf4EwyWaxZK0aEdTDGuGMXuneeOqNTr2HXGsPEWAtFSuv5/jpB4u4+neL+w8MVCEh0yyQzEAvNc4xjHaOQ0EK5kcmvsqhCBcTqF7SejMT3BagwMdbJhoJkSHe3g8iluA969hakG4Y4IIqhJIbT4nZ/SdY4u9ThkQzIpv+v6zbHRbZ3w2QrRSeiqeGp5/panwfFyrGnusg7389I/ylOGud5YEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF5EP9XROMj4zVTokcRLq+k3FV68aOiD5U/SJEPoQ8k=;
 b=f9C26/S4LZhSHruBOTM1zRlnv5ucv150MU/qdSpqWzzdf1W7quo6+Apqi2ZcH08jiYMG1tCim1hi17q8JzofSTkB6a595IJiGlUauRHTeY/WH1AzwmcRGyUKa4RpVCE1AHgZlBDiX723Fwepb99Es0QuOzAhqbzah5XP+JvK/7U=
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by SJ0PR16MB4159.namprd16.prod.outlook.com (2603:10b6:a03:323::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:48:51 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::8b) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:48:50 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T0OexA3751409
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=SF5EP9XROMj4zVTokcRLq+k3FV68aOiD5U/SJEPoQ8k=; b=
 gar3Z9BVHYfAD8H07aGaEf2K1kZHga9xU0wSmYnCBM/2rsTIj98y1TvtX2U/rJwR
 YEmU0Ogx9UdVFsu5GSxUNNTYW6hMQk4jmSIOCg9kvVvhQ5+mbeM0fsZGeuQPc06d
 CV3XI8ElASZlpmM3eUev/PVsUMs+aS6J6wxkpS1jiHkIKjuH7fhM7RdPGMiRVGeI
 vQAVu5gycdLNZeciU8AckxGmVuVQ38R/WYLY8t1R/0H2B8n8B12pQxx9g4+FAY/z
 n1flRweQ44oe8hCbQzxziPW09c+D/HkQ3n9xkPimeSrnwGpErlgMiXLUpqynlvy5
 eXQpTLpJ0eVw5cVGIvG4Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=SF5EP9X
 ROMj4zVTokcRLq+k3FV68aOiD5U/SJEPoQ8k=; b=bGCVUaFbt1dpuvCL8VuhoAt
 cMKBTctklR/QEpnRp22JqFSnK61bvJTW6fJcIL5i4O1+PoXbxo9IObbYsz7Yroq2
 VgmdRF+Nq8JO4CCOfP/qHh6h8pKcppAO5rJo1mO68ihy1+8FLAjzb9eTydd6eVsv
 +z0WiBQD1WJyK3ohbiO44WCPmFlfHlhprklu9937vWS9eBVH7LdKDC5ydg5C5irs
 EzQJ0roZHt8Q1PXJRc9N8GICIURUH893VnJktghP7ZfxHLU2Bz7/rh0kQK/FYd39
 J1NkddUWjsDOLj5rs9h+m6hBAL/XmlZk2ZjQIkyxk7NH6n/ZBQfivcmqdHCXznw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x81u0g-3
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:49 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SoDIwZSAI5kHRSoDIwEdLL; Fri, 29 May 2026 03:48:49 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SoDIwZSAI5kHRSoDIwEdLL
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 2/6] reset: Add explicit cold reset support
Date: Thu, 28 May 2026 20:48:35 -0700
Message-ID: <20260529034839.2075806-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034839.2075806-1-dmukhin@ford.com>
References: <20260529034839.2075806-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SJ0PR16MB4159:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4a31056-d503-4790-5141-08debd353281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8MHcxT+1xitu98QcoeHhkqGlYnRhwmUKIg0ZPFsPBaa1oxYSVbb+ftBjz2wOckUv08J5ELJkGI8UTPYjDpmWTAs2XknXtEQX9adOP8bLYyLVCEEQuMocMhaq4V+lMt8Gq9By9n+lQ5KzCkBell++41QC8UozI+FuGc2CM/2hRXDWIo/N3NjY5mHVOS8eZ5I+E9FQa3VVSNiRW+8i7n2JALFK6Uurzdb/2W3PvQ6kz//3UQ8HW6ZW6I/aISSPxvkDTZmb0U59MXNMqGsPbDYHJ3na7yTK7c+i2Q5tNExPs5xd2b/LhFt0C8TZyn4YBK1DUXIRf4S/77SFDKDIlnNz+6q6IIju2JvjBi+cGEZfGXp6GB3EtD4adpbrKKXQe3Wou1/zY1JsKXyAxu70phjXdLBWDuiTdK5XGKEcNqfVJSoF5R2kGwgHcRkdeLrwzgeBakFNtFXeiH99Hehqi4ZdbtSESwgrGiXK1SVcLY0k/4/7Wc8CCsUYtEAxism6/XZYvV6XyejAGH+wmplZ3aRdJgUngz28/uE6pU+w6uYKaXmxQRFnyWcVQ7fA3UGADs7+dfKioB99YtcIJKyq56BK/R0D5wrrMeeAOefJs7hDYUJ7lsNnw/uLTpoo8KG8uZvk+MH1fYHQjhKa3NpjF3Yxf6WXZ2D9KG0OKSya4pI2kvSIpGLaki4TU765g5tR2XzN9WO2A779QSWjFOsQKsNn7fFgzAyvuCknWqCuwdFGovo=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BctSYapWiHwuQZb7PM4OnKI8vwvuhV0ZrxgGaKRZo/tuh4r5FBA/B7VSJsgGNRgQaYWqXZxWT/ymg6e4gsFdCQRWlvAHkyys8uMwoIt9QjDzxv9/qdNYs0d06vl0c3gqbS8ELcemEOcTGerbvW1NNyyjyb7xyQNhCSELxKSEuk3oTCPEIUYE9fU5TIjrHmDh7OcRPkzvvVYVoUJZlAdBYfO5VRmc9/Ge/3FPklowP2iLeWXPsmdjpqsa4+4vlagFHbq9fq94xlbWxpEDj+5HFbwb+pK8lunV54mYTe4rgaD0SWS0OBaQlO3ISRtjbwSi0ED0dL84mmxm7YB+hKm7Lsnu4fz8+/+ToDnMuEFj3b7Kn3RMkqG9+3dGdUmbr5L93S/Fk+vbKmhmADPbh50jaVM9t5Ig5ZDFS6UERn9xxJLD13vTiGEmPD2z6trADphM
X-Exchange-RoutingPolicyChecked: jAqdp4htiuzpotpqZMKMkuN1l/L4rKPrOurzxbJUQEqQRXVxzW6SKzX/xTV3IYET6thK2eZmi8+rIqz6Z3Uoagm18KGOhl72iP7t+O3IiBZgjhcLhDCUlLAvpJScNTdSs2GZ06ZV0na6SUMoJ3tDNVjS/t7lkAL7cNxdLW81MAqzwWJ1qU3E7o7rJcMW4yl2NwFqUHCDzatL0Xt2gqo70o0/uP2oZYVogyOWMSmrO1NggdSSkbwEUBfraWQ2UWjhQDIXnBWtEd3D89ud3zcf1tTfiJupVO40ztaoU2LdBbGPgitu2Qo94ZXLWoihtDB17gaPnhrXCqheJXnPuzWr8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +QiEXZKJgw5vnLQZrY0LCqMwi5t4LBPDtA5J/bGeCHle6dbFhdS3xsMSH5LDWEC0/VzpoCHDdrKiurzkBw7E04RXH0nbzBYQG1Vvu9bCNTvEPY/idwGB/hycXtKa70+Ku3Nkf8FMA9pCxYcEjVmp8kaqG94PA5lXYPbTFGzwFN6QaJvLoAvGPEWSEykS/Sh5DmmSTA6mzLIcYNbA4SR9vMOrMhSgnu+q7Ufu8ifDrui3rpT83/oKT3kLV/ahMQE0JkANADC0+3RaklhbWIBpn9v7DAEQxojBKQ7wGVEfnLg0c6S+tZik9lld/fuIqbMN0Qum5Lq+BALXsRB+7O9ogbHhNz7/W2CpxA8CVh91NXrSnz+YwaFBWje3KV0+l4R3/sGB7lyB13c3m9ivhtAEXwcIJj3otBYmGtSTdYKcKreyk/nU4miVCC0pO8AybQMGbHfyyRNRE8q+xV5G3VGr1RPK87wpACHcH58bhxt4lzqMjf0lM/PBAtwVMxVKPEctulwDMQLrVLOe/4NanHKHqso7QjMNLF9N44vg3HjiceykNTyQ0WzitW7kMbjdWIuk+0UKBXyCGxvLua8+6vVkB96F5oEMeD5sIELhHmVQNWwgOxFi+VBRoCcSS2N6Y/YSHBWsv2rOwU8h2TDxXWadHg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:48:50.8968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a31056-d503-4790-5141-08debd353281
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB4159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX8A8fDuRbW1sg
 1QgRqiy4ar3JtrbdRaKlyA5ePwa/u5ZS2zhGNhd65r3nx9LGFgfeUUpok+wFC1h9rjuVVn4S+hm
 /+dfXkBNLbabW5BIKGkusUHV1Qg9YIr274hlbh9xTVXcvvmHHEWT4ET5mxpArjx6QunV+6imWvp
 AflynKC/ghGctBOnbDkzzZz/N8MPPor4uOHonxMJPXZnxy2K7tTDbc0PfPvQrwhnQK1Vx4QrGcZ
 G9sbl8HwiLHTRgu3QTEMNfR6ygRPJvNC7PDWORPEJ5DjiL8OZr5PjhNv/VyTgcb2HgB58HNn8w0
 uAlnWEoDDeJ3vGeGaHt2yh+mRVwCum7MEy6Ipx8AhUm4yHgtm6sqJjzaF6TRwQun4zzdkR4BnUs
 oKMuJoN2l2TCXb+pDaNeTMGkgIJbALBjVvZz4A8japXcXPyKrD/2oWrdc9o0aaVya4HDgq1fbGJ
 oP3Cy6glkCrBvPUqbyQ==
X-Proofpoint-GUID: sbcZ3HZRXsqKV1wNp65uueSm1-M9upIF
X-Proofpoint-ORIG-GUID: sbcZ3HZRXsqKV1wNp65uueSm1-M9upIF
X-Authority-Analysis: v=2.4 cv=Pa3PQChd c=1 sm=1 tr=0 ts=6a190ca6 cx=c_pps
 a=BToDjy1G2hQwEUS1Uhc31g==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=RPcLDelSkFZS0uLvm74A:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
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

Some prototype boards default to a non-cold reset type, e.g. warm reset.

Add `reset -c` so users can excplicitly request a cold reset when needed.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- n/a

Changes since v1:
- corrected args parsing in do_reset()
- updated commit message
- fixup reset command description
---
 cmd/boot.c                         |  3 ++-
 drivers/sysreset/sysreset-uclass.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/cmd/boot.c b/cmd/boot.c
index 29cdf4a9a81a..2cef907e291e 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -59,13 +59,14 @@ U_BOOT_CMD(
 U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
-	"- cold boot without level specifier\n"
+	"- reset without level specifier\n"
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
 // All options handled by sysreset drivers via their sysreset_ops.request_arg callback
 #ifdef CONFIG_SYSRESET_QCOM_PSCI
 	"reset -edl - Boot to Emergency DownLoad mode\n"
 #endif
 #endif
+	"reset -c - cold reset if implemented\n"
 	"reset -w - warm reset if implemented"
 );
 
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index d2fddb470bf1..df68b5c3f9eb 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -174,8 +174,17 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc > 2)
 		return CMD_RET_USAGE;
 
-	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
-		reset_type = SYSRESET_WARM;
+	if (argc == 2 && argv[1][0] == '-') {
+		switch (argv[1][1]) {
+		case 'c':
+			reset_type = SYSRESET_COLD;
+			break;
+		case 'w':
+			reset_type = SYSRESET_WARM;
+			break;
+		default:
+			return CMD_RET_USAGE;
+		}
 	}
 
 	printf("resetting ...\n");
-- 
2.54.0

