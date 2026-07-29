Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D86C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21CF5810C4;
	Wed, 29 Jul 2026 09:17:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Xc3hyVvXr2F; Wed, 29 Jul 2026 09:17:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13D65810D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785316660;
	bh=HC8bcrR2d9G0BdXt50N04xrooqQwX0JwEVOIoHQNsVY=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=vyWbPsDtCbStvosPNY8wqPOkTfrfS37iMvPFB3of2HxfXivXJLgmGewBb1/cl7DkZ
	 QOtOs5tOTJasARiULjoypU7zIe/xSJW+2dTbJ0Kjl8eEUObBspGR/+O6zEt+0ScpjY
	 DVW4koYCzxbGCVTIuXXGwnCuVz9g4VBK678tGBKYBoG91I1aYSGgUoWe8E8rIJpCFN
	 NXv7XE/uQdhR/5OtpAz9j8xt9/ICctZ96F8JQ678CTG+n6UPgkvQLyedWgOF/93oc6
	 B9KpRI7sTmEFU059vl5VbgVf2+2vzLsTS9KlHQqNQMp0+1ufKG4d8fadkqGTrtxvfJ
	 qsacf2pef7cbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13D65810D3;
	Wed, 29 Jul 2026 09:17:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B41C03B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D569608B6
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQ0dEq0fUM7J for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:17:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.143.241;
 helo=mx0b-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4B4236083A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B4236083A
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B4236083A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:17:31 +0000 (UTC)
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66T7pZAt577708
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 01:25:41 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010002.outbound.protection.outlook.com
 [52.101.193.2])
 by m0482515.ppops.net (PPS) with ESMTPS id 4fq9f29rx6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 01:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvWOLTBN0eZf1pS6MJT6evP3xFQDVRUp8+OZ7SpfqxDJsoTY4gZusPDiCudQzdWzUdPA0C1bisap+F1GbwTftepIe7G4jShTCwhpn5kZXvX8/bU9hNYf/NQTwADxDmUj9wR6lu9ydUsJ7NGo/UdIbIpkGPFfu6L/Dr6qRKDhGP7tMKNadrU7Y/BANT65cybts+KCFbN+3I24f5yfktWfLPFiy5RG4HBHznrJFngqGqsfd6Yx/NR1Y7GxzMTtXkknTc5G2l7j0CaBB6HE0H+z2rGeqaouZvM4M/DlelFEdJ6nRUvtTVt6HswRY0mUmNIvnkd1/XzKsA+uonfcawZcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC8bcrR2d9G0BdXt50N04xrooqQwX0JwEVOIoHQNsVY=;
 b=RYv+UmzHDav1cy0GCnXi0iKKCvMZqpBA/NFUyyqkK073WvKfYhr9auZR82tRHZWDA161mGwJ3da2vFCZ7NUOCamLtNR/ym/65sUl5VqIZbGY99zurUQuYCyMz7hia5nFeNweYY2gWFzH94ZbqV50W0p5I5sjpe7JNfgtWx6rNMyulKfyeH16C0Vr3PKULn8oa8wcMp60Jz1dAE+AN9Ekkj6AfGIY0n0QaY/jw22onk50m0wPqqGGS8COeyfcjuV6C/qq10AYXx1rwNcE7VizHuo5Uqn9RnwoJTOTzEVme6XUngvLxR4Tjx95uQU3nbkyYDlpP55zLWNhSL9ExpTUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from DM6PR07CA0105.namprd07.prod.outlook.com (2603:10b6:5:330::8) by
 SA5PPF570C55403.namprd16.prod.outlook.com (2603:10b6:80f:fc04::90c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:25:38 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::4d) by DM6PR07CA0105.outlook.office365.com
 (2603:10b6:5:330::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 08:25:37 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7dTxC3597049
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:25:36 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fnbk4mccc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:25:36 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id ozbawzpfajJj0ozbbwo7bT; Wed, 29 Jul 2026 08:25:36 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ozbawzpfajJj0ozbbwo7bT
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH] pytest: fix out of bounds access to bad_pattern_ids
Date: Wed, 29 Jul 2026 01:23:51 -0700
Message-ID: <20260729082350.2276234-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290067
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA5PPF570C55403:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85a4e690-5eea-45f0-8fdf-08deed4af812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|18002099003|13003099007|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: ATNrpKkp3C6PXPUJeHPhDDquxfh5HVpnjDE73SN5w5FPSnS1c5deYGGX3uxeBJD735/OL2G6BWPg1TsGEV0Ai53UR7KU/YbydQX3xkg3OQfV0+OeWm9gGjmHGDCpCCdCf3jGVaY5VSLbEcgPMFmWXOloAQjqY3E0wzsm6Y9amRUMmFvV6KRysKA/OisWbu3kHyQHxdQTi9oTUwli+4QJ2GEjabxI8swztKuenG8w9xMG/lQV2/HOd8BkSdOXk1Jg/NJr1klJvkbXjed252Ab0OUtQ2NRwk0iuvdOMknYBe7NCwExZoh5kxLBBU3vkHUCK1E1TTgrSEYxrzsxS9OVmiTwJliJPC83NMt17w5PBiMTbGyKVarKyzuuX8A6m2EKmk9ZCPiCvQCllpsgYF6L3Me2+guZyJF4+sFJHb+Li6BnvaWzdjwJoNWoYmk/jTjmIPDvdWFpDMZZsTGzEQ1E4uOVcJgzquAsA+uHcJCDfrbfp21JJ0fhlz+8B3NbnrsMz69b4Jj9CxRR9CydMhlxn6Yw+8vlvXt/k0zB6zXJ+ilUHmY5Fjz4AKXfQwYFatrj4+bwqrTTVInULvyJtw/ygTpCMzyJDNYgKYikpt1d8wUJUwr7TMdckZCWf13+71FMsYqDnu/EX5I14T3wRIeJDd6Gi5q7FiDczxjAT5ZfxxnhqjMHMOfeyUvoYvELsEJCgAApeaNZVRsync0UVYoLcQ==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(13003099007)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: efzisOL82xFVNh+f1beqcb4LYg9IChVT4IgEpj+bGQAQOPoKaLdPcTW4KDgU8RyuWwlw817j3kls2WJfee/K7cd7vMQvPxgOSRMxp8zL3pbLueTLXCGDfIv2B1x0YwPfZx59jdO+5L6dUwBBg64kErXfOhEaUGS8ykuXK3Wb1HtGTEgSI+G2Eiyi1IqzDH4M2QhBnvremMp+jEOwgmA5/yB+sZuBVwhZ0A3Jfs7lKK7Rukx0MoNF8Uj5ouDCpo6bOuzNBLIlH5ERJS2hJDwuACEwbpVp1BtvmdTIetAQ3krIVrTpjucguTcs6JxKedewX+gUEwkK/4C2A15O+w8UzBmX6T6xaKyKjKyU+PMf5hdXM3tM+YwcB6pg1QOhJjgrmwLAuk0YDYJqZoB+0g2qoxWBZu/iH6c1tZDKjfWESWy2sDsyG6yVJ6xB3OB+DvJb
X-Exchange-RoutingPolicyChecked: EdNAB360tUXYZOAto3ZHd/thkrVi4wyddLGFPgVBwVLQJ6YORtI/H9HfRdUBhxtD/YHa6lQZolwKqBRE3P2DltqbrND/l+d/RseRS9Lcr5otWTDgsFWyj4Xl5ObmlFApmYJYp+zJ+k9hRA+bwujVdZt8Ze5Z09pPT5sO/Q3Fw5ElF2snZut7aYXMAqcAnuZ6lVDF1wIzCPjLAVWdZKz72xCfG2UGxASQEJoi7ApllWjomqyMYc6iUwETKi5Xl8wZVYicGDEaypd+xVkFNEnvdanZcGJEDNCcMPJlLkULfySEpucfQKPP3Dt3MCUlQ5GFzkIUmpQHFK//KEdewjfTVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BjnWCkh7IDAZBwwRDYTm6Pr0ajFrfD0ClMLFBpwtNtvlzfNlL3ONnRDmp0iXoRvwv9BVubFhjRnVMiQ2FTNeE9qUbJ98Qn6odeiispejL/4Fnkv+EdxBEX/nj4lldVeTO1NikeIsBFQgm9UISiXAUrnUN+di3nBcGPQxqDy31l/HKkZBCO79BbQsPu31afr/j1RxkDCS3Ctck17DeGm3c5hCMGJvWk+KoUFn3DiT8HIUZfwykdIuAUQpQmzdJwQcUEAW6U+10NZ/EU+CV06zxf27usV/Wg9u7hR0Y1Trd4/JwbcpOsYIybBEB87O5poGGlWKiya/PGj4xFv1nshARAeQRuwdY8QFedqX5zqBgnBkqXQqBb7wYXZDjz6PkoYiBc/DMcbWf3PPE2qWuCBjdoU5hX04XDIs9um72AzbF1k86+xIKO0FAkDsFb+KL/U1LeATzLFipXkDSMUe0vo4GPBjPHH3Z6VEzSBOJWcZ9P0bHxTEAkTUoi/55dodn5Akz4H+Lb/GQjQGLaeheUXyrG7sj4jShGaMuSx82wCFzSMGpKnxf7nDVR93fyHdassmkZyZImR0tV2cudXNaLI0AJmuaRYjCdjh3RxSrU93AMIQbwJ60xfyckPnLEkgsRDF+lU616TI0b++iPyo/qnWjA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:25:37.6817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a4e690-5eea-45f0-8fdf-08deed4af812
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF570C55403
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2OCBTYWx0ZWRfXyZKnYix4KwA6
 g+LuwYhPgORhmPN1JD6QUPKmKK2nmru5LNtNcI7gxUpHdn/3t0u0C/uQpX0/5PHbl8WJAEvpJPv
 VmBV3hwmy9P6qU/HBpzHJMS0cCU05J3GQBv0VS/NOYbvY80Z4ThX
X-Authority-Analysis: v=2.4 cv=IJwyzAvG c=1 sm=1 tr=0 ts=6a69b905 cx=c_pps
 a=NtDnjKqRhcbz7rYDj/0C3A==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22 a=NEAV23lmAAAA:8
 a=cbNQJ9GKAAAA:8 a=rW_cjJN1LNT4rYeMDFEA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: iT-3gV0Ld24cteRJfz7jxYHkI_WTc9_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2OCBTYWx0ZWRfX1l5F5yTplUJM
 RbTIQQ9KgFrfp98kmdvk4iN7ivitGmW343+eYMuIf1pGOWzBNGUHrXJmwwYD6BJcKBjWEKjO8kU
 PmV2aAIN17n5k8GI2vcVTjYW2P2b1oKjT75vO9TNEgyjhiBAE2b+x35RUndw8YTLvgT7izlfIch
 tZz/RyLIWqSwxABG7bmpNSdQIir55xC2AI/9CvF517XFxT75CCXQBISDyswMMqFKDJ9amoqinwD
 UMPdB6pHGXM+2KLyj/ln/xgYkM+ih/4Nfh736NrWuqswdQNwNhi4JDOCYn1aSyhWHvT+MRwEt2m
 V6pY78eVN3ND6sB/2y+C2k7moIvOtmmLgYHDioMlMN5RTsQitMg8h9IuqN0sH4ute6OYBzSGzeo
 9eIJCLzHE7AMu3CjospCizOYMLlWm0FgQImTyNVDCaWZ/dNc5J7NR5VjMjWFVd1pThiBlqQjLT6
 YiMe8gSd9DBvAdF7spQ==
X-Proofpoint-ORIG-GUID: iT-3gV0Ld24cteRJfz7jxYHkI_WTc9_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290068
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=HC8bcrR2d9G0BdXt50N04xroo
 qQwX0JwEVOIoHQNsVY=; b=nhJMKBTMKVKW9rE3f4mb81QN0ci3XIwxukOaWJePx
 66NSBMECyV/1asxlTxjHfj+e/sE0Y0myUCjSlYVKIpHs+LdQGEowId0eyafS7V9P
 pXMO+DuuyS8uvDrwmjEQB/E7rz564J67DCgOqcs9Ifa/0rPgQHJx5RIKeTyAuLE1
 3SZHpCNjP0byiJfUs/ytSHXc9wyp158xf0ez7s2XTq20xvneTAMnBNVwwKJx0N6F
 Dl0mp0ylIeQOCY3ANLUp1oawuvTkpY8zP0GjHjlsDwry7u5+OOV5tTgQ6gZ0BvFP
 ghh6BwCkiGZOuJoj4ktYo6uImgvuVERpf6cQprYM8hLOA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC8bcrR2d9G0BdXt50N04xrooqQwX0JwEVOIoHQNsVY=;
 b=lIwgGlAgvpkN9L7lOWeS4NoEEXsZYyfoP8MnDIEWgBMAVQ3NO2kPD2RK3BEd/CtEcMbsJW5rnFHtBCmoKUd/LiPVOS6Vo5Jf/MqAfRETj7JGJsg55sFZ0P5pk/npmq1KSvYY6RBN1vvGF4sA4exm1a+FyecnYTMawH84WaU6ZNU=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=HC8bcrR
 2d9G0BdXt50N04xrooqQwX0JwEVOIoHQNsVY=; b=JTesEMsmk/EAR/EunKAeBwn
 kId819LORVmbZ+on8FkxIPifRt0G8aEWT4gYis7XtrW++e3lo3oFlEdsxpx/gAUs
 1eBqLdcj8OTfiwI1aHps2G4Aw2C02AgHBiH58smyzeV6stQ+bWzfqz6CPOb8VaWF
 1NeIHBRZ00qk8wmSiVFLLUesvAONzvGvs3nzG+NppXlu61G7nobY8JdRolTcOTxI
 UcN97c4kc2tIB5eKaYQuLlVvW1jVt0ELT5N3SZ8p+cyShPkADK8iWGwzaJKZ0F39
 Ab0kRidG1o3Hcc6K23Jfcoyj2tEcH1+eZDJvdim8l9gu2lAO8WPHRIGI7y0+wzQ=
 =
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=HC8bcrR2d9G0BdXt50N04xrooqQwX0J
 wEVOIoHQNsVY=; b=XEGr5xDwbQYoYRxVZA9HqD+Aa4FEUTHLk4XQ13riZqLAVTL
 0EFFGl2lWjWzLY4w9I5uCDa7/BWu3qF2pwRW67bvm6qIrffVm6eh1gb5GgEpHDzI
 +y9fZZy+keFlhd4aBodAF6IrV6FkiVfolWODlDcrf4eYmhVgrJR/1J0UF0k8f1nC
 eyubA4pmGrRzbBerQl1CuNjiUyhMNFr0s/5yP3/hMDFq2zcXxYpMJQbptWqD38Gv
 1IllX3kPuub+xqTg5AayJssE9SDWZ2+2hIw2ruK32IZsJt2HM24HtTcZMpeWSTKh
 Y0QSWz6/OFxdzuDZBUxSoc1ZFKm/e8mlyav9L9g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=nhJMKBTM; 
 dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=lIwgGlAg; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=JTesEMsm; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=XEGr5xDw
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Denis Mukhin <dmukhin@ford.com> 

Current logic in ConsoleBase() mislabels every bad pattern and walks
pattern past the end when the last one matches.

Ensure out of bound access to bad_pattern_ids is handled correctly
while processing test console output.

Fixes: 8308a5eed6e6 ("test: Introduce lab mode")
Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
I hit that while testing reset v5 series in the CI:
  https://github.com/dmkhn/u-boot/commits/u/x86-reset-v5/
---
 test/py/console_base.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/py/console_base.py b/test/py/console_base.py
index 88d444b44b88..8b373fd4d95f 100644
--- a/test/py/console_base.py
+++ b/test/py/console_base.py
@@ -212,24 +212,24 @@ class ConsoleBase(object):
             while not self.lab_mode and loop_num > 0:
                 loop_num -= 1
                 while config_spl_serial and not env_spl_skipped and env_spl_banner_times > 0:
-                    m = self.p.expect([pattern_u_boot_spl_signon,
-                                       pattern_lab_mode] + self.bad_patterns)
+                    extra_patterns = [pattern_u_boot_spl_signon, pattern_lab_mode]
+                    m = self.p.expect(extra_patterns + self.bad_patterns)
                     if m == 1:
                         self.set_lab_mode()
                         break
                     elif m != 0:
                         raise BootFail('Bad pattern found on SPL console: ' +
-                                       self.bad_pattern_ids[m - 1])
+                                       self.bad_pattern_ids[m - len(extra_patterns)])
                     env_spl_banner_times -= 1
 
                 if not self.lab_mode:
-                    m = self.p.expect([pattern_u_boot_main_signon,
-                                       pattern_lab_mode] + self.bad_patterns)
+                    extra_patterns = [pattern_u_boot_main_signon, pattern_lab_mode]
+                    m = self.p.expect(extra_patterns + self.bad_patterns)
                     if m == 1:
                         self.set_lab_mode()
                     elif m != 0:
                         raise BootFail('Bad pattern found on console: ' +
-                                       self.bad_pattern_ids[m - 1])
+                                       self.bad_pattern_ids[m - len(extra_patterns)])
             if not self.lab_mode:
                 self.u_boot_version_string = self.p.after
             while True:
-- 
2.54.0

