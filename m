Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964A8C5CFDB
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 21:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 591C3408E4;
	Wed, 12 Aug 2026 21:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ovD2l-LH37Bh; Wed, 12 Aug 2026 21:15:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72BC8408DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786569317;
	bh=Q/8+cyeSxtt/z1hCyD6Nj4ItkLRZVyJzp+f8spzcl0U=;
	h=Date:To:CC:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mV/mp9lcG3O5mG4I6Hdk1fqLUFfUR9UqZfGpKisEOuNal1IiaUfm7IorQpDPJMjRM
	 oJtdfcgoZk2OtpMlsMEIinyS9aDtjsxtN1BEEfHZk9NwDhFq6KD6t/eRqDPwudI5FN
	 qj/k8pFJuLRamgnC2Zm1oxtPWP6iGUD+gORaWfYcN5dKuEnTJqPcTn9qZzpLctzmqi
	 uUInGetay/LSNzaPocvU3eFl6IESJ5nkFlw8imWcKFoama9trga9XXvahTUqMcfOpE
	 QAGZ3uhswGKm3DVP1xxyAPSawhjS3b7YOvHYhIffx8N4rM/BfpnVK7tpENamz4EJDO
	 dh5BnsYL6HtkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72BC8408DB;
	Wed, 12 Aug 2026 21:15:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08B7D2B2
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF2AA606B8
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5HSH9rogxuu for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 21:15:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3DA7660618
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DA7660618
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DA7660618
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:15:15 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67CJxrhE1398872;
 Wed, 12 Aug 2026 16:15:04 -0500
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g0musck41-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 16:15:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTUia7e6UiMs5jPDk0JJVkm+jb764K5Iqwkf8pSkr7gkS3WFH8I7hjVE/iJfbVemmXi2dZchQD//3aLv2Baul/CuLaFeC+Tcb6qYNU1GWa/vzF7Tbb7x3VnZ4eGPLWk8ultK0sSZcNpvU1Mrnpw6U6NIaP0EE7ZwrmEhG4b0ZAYzJ6uEF36DcZ1hj6uBBJ6auUTv9xxt8AYjFlM5pStwlQ5CWaYEs26Y1ndXo/9KoHjuw+G1Lf423SLftzbq6/qmxBrI3BmK75Bb80NcIc2aEMDdypmAeuhmjtJaBekpmiDJ/GAmWrbyWw1wUSUdmXKSP3LG8/DLePtTsR55WjBHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/8+cyeSxtt/z1hCyD6Nj4ItkLRZVyJzp+f8spzcl0U=;
 b=iUvI16S5+nqHilaNAwu7wiq/SwzH2r+q20DGWzm8uC2gX9Q4j5hiAttzwEtHmkA/zhD9KSSj6DrY9GeQrbZ6D++jubiz4pGiHmHQ0Y0YLt781/j6YepsLsLtJbKPvCw23ipfOiDncsgbvxfj0MjK92BF3dsu8heEetvyA6wD8KA6pgyzcXSXR9YXSsK6qKGMcf7yn9r0WfaKXT70FdtDCbXtn7t9Cpai+dJrkzZ0Yn7I5Uhg4uNnfSMOuS7UXHxNwN7wa5Nd+9dJzV6O+SlZu4uaKheFqWImBvvDL6LEX18Clu4dR7GERyq9ojdrcs/lqR5grQgdGdTwGdg9LnIg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by CH3PR10MB7212.namprd10.prod.outlook.com (2603:10b6:610:120::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 21:14:59 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::84) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 21:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 21:14:55 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:14:47 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:14:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 12 Aug 2026 16:14:46 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67CLEkc93807488;
 Wed, 12 Aug 2026 16:14:46 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Aug 2026 16:14:46 -0500
Message-ID: <DKN9YFX3DA9W.2SKRYR2CRPP9N@ti.com>
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>, "Randolph
 Sapp" <rs@ti.com>, Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: Joseph Guo <qijian.guo@nxp.com>, Emanuele Ghidoli
 <ghidoliemanuele@gmail.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v2 3/3] boot: image-fdt: Restore suppression of
 irrelevant ERROR message
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260811231650.3150771-1-jonas@kwiboo.se>
 <20260811231650.3150771-4-jonas@kwiboo.se>
In-Reply-To: <20260811231650.3150771-4-jonas@kwiboo.se>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CH3PR10MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 6feac74b-7875-4a90-335f-08def8b6c200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fD/OULdF0zpCrbH5Y9i6kWrSeYBcJS4sh5eKDZrnwXKho+ZcPcG/UL5aeKxwPciE8wUhnGRden+Ou+ZrT2qMlPOGCUJ0Z7CP8FGKjcHzcLXau0ESCLk3WqYIMsbe6hT7ZbCL+l8chTgf5khAsBOPyUJwPrOINsdlRzNZCuoyGE2qugQOTbtMqsAbh1x5L6QM0GpX/7HVpQg4StHx8ubaWJJZN0vdoZ69PcGf3DHykRN0pwDfge5bgGrE0E68hVxktas0c+Lh8dxika8hpUKew6nJVnomSb9k+PY1Wo208kmSwLt+UPS/y3qNkZU1aNu/83utOCFTE1MD7yj5LJSTvilSfZ421Rb6uw1DloCYq83RygkiS2HUdAja3VALXXhmJOCqRfp1yFycGSXbpAkn0H7yWSi1vn28sAZopdIFPu3zkhCJhvf5HEJaFMgdLbP/NfCQmiPNUkLk75W3S72GgfssQDXxwZdCl/tUVbw7t51XFHQv7aZDm9MAeoyCcF6TnAX4C0Z4ItTE4007dOtJJ/a0Alh7FdRBvWI1EmDh4h6zv3QcAFGWgs3THhQx9BETbmwXiwdy32H0etxubnraU20EbhsC5DJAIgFHfW9AMJW/lERgx07vLMYzKOxkNvkyxRqYftnVevt8D2fo+yxH9jn4rm9lKr86kMWwCLFqXEfr41XV0audUCr2CIW0oC/n40YdxtsiTUucSQ1fJMhrgw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dNK81NaZP2J8H6C63DawxZc52kY8GY+ZnliPZWf3bpIynT4N+dBwFWYM1fLqmHNb+07RURLRkCfUE/N4rXbxxbebhfJ6+vvxJOQNRYYS6YvwLOXNZqIEztvCaM/LBbkii7kKCiNwg5EZksmWPumRtZ9A617qI3wU8JspH0Vb9hEyxMM4kxjxuFF9m5y0qnq12GufjhGyNb0pz8gYD+jjZKPOR24/vwqJ2/O9YAyEBW3ZvnF2xngsgJDeWu0DI2en79gCEaHLNyxfGR2tj620k45/IcORU3iU/4M7YPC1H9pED0ZqOmS7/8RhTvC3uo5Wk3j7i0l4ppcMEsSIIHMyptQrHZ9iNkEn8h9sYMZctlJWrh274GEZNrhIn6VKPEq8jKjRHlnbNPPyk8FxH1zmugLfinfS85FXR9Jl+/ZjFa+dUBjV3Wkl+Hibs+Y+iFkS
X-Exchange-RoutingPolicyChecked: U+5DP6VDokB8tKz5VnUIswIJf1R3/j8ioVCDVSuZ7GJbBxZ5X8P2vDqKKSWR0lPCQy1HcNSLRVfavlWHEQgJUpPCcetVv0W+6EYhyaI+n68TMWO5sVSOHnqule3+oIxFZTJUn0nGfU2R/JEIrm211KZ07OlUP2BdNcZ0JCuUA6WgTQbSjCeAjFiSzRkczbl4cj+x/QI76G8JpeiiPANhBr+c7mdV2ZQF9RqA+uH1rXFx8KYycTVbmUSxJ5mWUJdD+ARKbfuC+/Mo9NtNjD1nLawPyfXgRskRaVXSCK7NM4BiNeO7Lfth0k7k7BOz3dybXZqWUx5GKynhOauGAy1ttw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:14:55.4490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6feac74b-7875-4a90-335f-08def8b6c200
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7212
X-Authority-Analysis: v=2.4 cv=cY3iaHDM c=1 sm=1 tr=0 ts=6a7ce258 cx=c_pps
 a=2E9rO6gqkamS8B1JEYjvvA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=fxzwj9CpkjbmYyY698gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mjd4eI_wn8GlGTnXSCDLTJRKv3A37S2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MCBTYWx0ZWRfX5r7XreCiG4dg
 2RqwbP3b/BTiXoHP1HlzHW+mseW4rvM8E+7pkub8+at7MSs0alwtWyGckXNNp7YgXf/TvilLGXB
 WEYZwHIMzqx4TSBP47yWHvK3LhSX/kT6bI+pT8OzOS/eOd4zSEnysff5BLxilRETedbfC6Yje1J
 0JyWWAACiFmDt87ZRNfOHqFkRsFuC2HGle3xeqC2d10TUd79g4Fu9tUwpv57oCqSU7XAH/uxL00
 ggJLT5rDXaQt/xbN23/8xaIYdHirT4WVJhoN5rrLZemk4vLYB8N+OenwEXbQoG6nl+t599dloIZ
 Nf4Kr65vzr8UvsJQ1Gsgd03h03In6Eco+MbAiJFXWYK+iWYXAA8TWlRmwerKRJt5FNRvoaFsK0s
 55Hlqp55xXJ4V5A0+ufSHgneA+rdiPd+Xqvz62oLjoFB20wDVsLSt+KICVyblIhdSKiBY9H8tWJ
 q9OuBrk8lyAb4qu4a4A==
X-Proofpoint-ORIG-GUID: mjd4eI_wn8GlGTnXSCDLTJRKv3A37S2q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MCBTYWx0ZWRfX+FNFYxhJXtxg
 71OzZSeXkoMggpOvkpcIL3hBwUGbudsvuu6MJKZmxiACsktstLfFzKBpRmBpUoqWr+pOIFQgoO4
 8c7G8KPdVDwPKN8Ax95FgvjF7JA7UIU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120170
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Q/8+cyeSxtt/z1hCyD6Nj4ItkLRZVyJzp+f8spzcl
 0U=; b=leWMvg9QpVMVTZskYGpC4dbQ4fupULiEckLZlUQ2YlbPGMs0sIZ0kmF++
 7o63f7UzuKdHcgw7IOqY8PYRWTBNg6Acz5z8YuaomKG4d19SHcTHKxfCLzQZUS3v
 DbF5f0vV9CEVN3lkcvVAmDKFoWa7oEPJKpWXU/xdFunzrSxvqIBA/90eOeildjIj
 dMymocdT0qB+QDhTWLyHbGoJkc055HX0ys1HyfbA9bGRLkk0GdbGCGda04k0Adtv
 ruOSTWU0beVL5TsSHJMTnELNRBdPx2aVPfLRK8b67TRpI3ZqWVkWN6wGo3HKBMsP
 WG8BTH2oJ7c0Exhb6c1dAgNh6xtOg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/8+cyeSxtt/z1hCyD6Nj4ItkLRZVyJzp+f8spzcl0U=;
 b=PKI8XL54TNn/KSlD1J435lF5g7moV6VcgriEYQmPe/2Zny+VubbzoIb+Rqd5PQXYlz04Tm5zVmQASVwiA1X89K2vH33EWBCwrUF8icLF/rkc7k79hF+3ckef+mWIb0Th0p8MLcch+YgcmbNB9gAdvf0WKntK1NP+oxBeh3gjSbc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=leWMvg9Q; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=PKI8XL54
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue Aug 11, 2026 at 6:16 PM CDT, Jonas Karlman wrote:
> The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> removed the suppression of ERROR messages when -EINVAL was returned due
> to the memory region not being part of the LMB memory map.
>
> This causes an irrelevant ERROR message during boot, e.g.:
>
>   Model: Radxa ROCK 3B
>   [...]
>   ERROR: reserving fdt memory region failed (addr=3D10f000 size=3D100 fla=
gs=3D2): -22
>
> or
>
>   Model: Rockchip RK3288 Asus Tinker Board S
>   [...]
>   ERROR: reserving fdt memory region failed (addr=3Dfe000000 size=3D10000=
00 flags=3D4): -22
>
> FDT correctly contains reserved-memory for 10f000 or fe000000 and U-Boot
> correctly does not make these regions available in the LMB memory map:
>
>   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
>   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags: non=
e
>
> or
>
>   memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>
> With lmb_alloc_mem() and lmb_free() both returning -EFAULT when the
> requested memory region is not part of the LMB memory map it should be
> safe to ignore these errors when FDT memreserve and reserved-memory is
> being processed.
>
> Print -EFAULT errors using a debug message to restore suppression of
> this irrelevant ERROR message when memory region is not part of the LMB
> memory map.
>
> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  boot/image-fdt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looked this series over and ran it locally to verify. It resolves the issue=
s I
raised about error verbosity well. Thanks Jonas.

Reviewed-by: Randolph Sapp <rs@ti.com>
