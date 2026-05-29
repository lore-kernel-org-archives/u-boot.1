Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55F9CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A95984875;
	Fri, 29 May 2026 05:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="B/d2yM+/";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="CMMlpZMV";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="AeSIu2qL";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="SK9oAqCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF50B847C4; Fri, 29 May 2026 05:49:03 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B7DA8486A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3UPSD2122733
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=z6K
 wnQQNenPbi649Tsqi0+SgisP100jtU973J/FrqI0=; b=B/d2yM+//JPkCZyuN3H
 349oufVXzCvzzH0r502DI9fi0UOsnZ/csebGvwreguqVse7pbns5x/P1mGm8M5nI
 FZdxMWPAEHK1e3T/lmN0fikx37Nc1mFd8Vch74KOJELSq2Zx0QsRFTE08CCa2AFh
 +pOeyqyvCrlXyd1lpD69cQwf9adgaWjQTs13Z0cmXcq1ZCBvPoxACMWLfNepBRlr
 Scvp3RBwhmOSqfZFfgrnOZLW4b1nsOSiBSeE1sbX5kSS6vrM2SS9dP66hVFj56K4
 Sh5afykerYBFO6KHKC7BRcmJVDXr2HicwT9asiWy6nIzwbvvglMjCmYCA7VKyiyf
 Fdg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef2xx82ke-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAFqT59ufsLp1NTDPGFGqGXOKmSbtwOPw7f089hOABwFM1FbJT1UqR5YNDP16m3tek374t8kdRQ0XFEZGiZtWO+SEVXjLI+/sljw7a5Tmrt8H6jdkc/xtJXVk51hBnD/NrPFZDHwFQ5x7F7l7wm9U9seykdqx44RkJ2PaUxuM4CyZGxrqWBJ6aua256xrDNdSzaRwijhZb+DPUcdcPKg/MGtGITqC8WVdGH8rLcRHv4qeYfRaISxTDak0wD5feL3FVTO+eujgaRHcE5DSfmktIEqcuLMhAscdZ5ii8dyo1fmJk655iXveRdLYS/QY6Mgsn5ZhHKLB6o2tYccibEnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6KwnQQNenPbi649Tsqi0+SgisP100jtU973J/FrqI0=;
 b=ZpAKmiuWcEEsZdukD1k7mxJ7i+ZZlAtTqUvA5+OrCtlq7MQELd1KrsSkQ/RP5ivA7acXVkaphyhBEpQLVDqqjY5+vJIm9QnrTzF/N2uLF22WuTBX0ccnT/kSdw75W6SppJUFijVHtLXSXtDldIdJQwiTAhUj8/D2u2SvJybGUHNLm4zzURPVJy8JKHqHdZ2fGHMIBorU6WUHm8gRsR0KJJzihONrFvUalcs/cMFn5oW160SMHymo2fDjNRAQW81hlYIFw2ri/miFIhnJIMBJ13kBPX+WbFdbTu0uokBW1ubutp4ddrVM45PjwqhBX0e7UszpH5IrNvI32Ii6eJMLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6KwnQQNenPbi649Tsqi0+SgisP100jtU973J/FrqI0=;
 b=CMMlpZMVKc4U8zuRWQgLnvgeND5j5MIYwbLm0rzKCnWntiwSu/0SE2/hjOfrF1wl8TvZu0VEbWTni8zis+X8LAQ9maSM77qFbCBURfPH9x62shw3X6aAwIep7L2nu/dYXI4i3SDHkZahm1oXmpX7Xx3oAg/+QTgRYX4zNoUaDx8=
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by SA1PR16MB4731.namprd16.prod.outlook.com (2603:10b6:806:238::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:48:55 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::76) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 03:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:48:55 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T0OexF3751409
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=z6KwnQQNenPbi649Tsqi0+SgisP100jtU973J/FrqI0=; b=
 AeSIu2qL5PA4BalnB3diwZVCZoOv+bMQ42cCj1N/uTfcriwdY6dHLoFyPSHMzvCk
 WbUS1oqzYl/a5nO8+izRympHA/GrAAxC2GNmqtVHOX7Z2+Nwszfbyy0JblL7ncF1
 J3ObMoM5cA4s3ar7MZ2BHZ40p6nJuqxjYXofTRR4OXJjWUoRaYD1LzqS8HgFXSHr
 zkvut5HpHRJbjny4NJhMXh3Zw3HMuuAteWIppjN10uQ6ZqgdaHBvFrMuIrRLOsFa
 ifHKClpwzp/+vYbXMNTse57u75TAMQq7df1J9rxtK2hE3+sTFbQEWysdc4OULRmo
 l8DE4+YXvyuIeaFN5vHH8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=z6KwnQQ
 NenPbi649Tsqi0+SgisP100jtU973J/FrqI0=; b=SK9oAqCMaVf/lnHkuE1Qv/W
 NoERn+S4gNwvdeJwtClK7intBNgbM4TX3Czu7bK9AzUSRQmnO3ALwn9zFr8YZ2R2
 nsxS7Bay/+gxAd0MLXJtGN+/xG/rnESrGTl/Gu2dY9apOaplxKtjnDz13HFZP6gs
 H0Ai8ajM/3Jyy5ZKuMkR2LDOJqAgGJQLWJ1gHDviKawzlYdapix3aDvmRA7ufLnu
 W/TI5Lak8jbq97ftr2KtBXwj6rawFR11vPVgLc7WB8PfWDP1ifexF0rtA3EGfM6b
 B+uF1+5rD5bnwi4YJTDe+laLHdKRK8j7DSQP5X0VnnIfxOOzHzFRtFnJSKMJm9A=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x81u0g-6
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:54 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id SoDMwZSE55kHRSoDNwEdRr; Fri, 29 May 2026 03:48:53 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SoDMwZSE55kHRSoDNwEdRr
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 5/6] docs: reset: document cold reset option
Date: Thu, 28 May 2026 20:48:38 -0700
Message-ID: <20260529034839.2075806-6-dmukhin@ford.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SA1PR16MB4731:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2baaeec-d667-4322-f343-08debd3534f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: md5zBTYN70eNM+auf5kx0nTvuDTXjNttzEkqTzvUkzMCI7FYxGpH2qiKFGwqGj6+hgicef1fMeiBQkFyccK3/GdgvKQMg1qtKy0jit+zmeEaWhnVCyvG/dnfSEr4iaZYTcDXF5bIjZOsaQe7enWtvAtauXKD8jDj8QgspvfhMVxrWgTd9y0PR+Z3aCfamWba0lSRybhLfuurBuaAuWXKUqFLaDWwbf8V75hpAiZ0DvI2xO+9ZeGwC0q6PspCdpnKOlCUGRW354ilSLbKitPU9A4j8nRPMyX6+d2QKRIzCLzmJKufuSBNW8H+8I0aQTay2vam92l4XhvfDy33yrZuhfpo+/+hsaShz3c+IOeVgafM9b25H5nJO6NJiRebutOYTsr3OZAJu1l57fnduoWUDjcNs+Pz67jDsLn4sjFt46GB3JeX4ZnatkV0JT1VoglSlAdjCoScdsgoftP04VF67TGKPjV6oZGC17G8Y56DP83aG0ZKRcL4KPbHDT76RUdFbzDn2IVhdOIuyWfaq3HJRXm64Eoauca0WYsACHb9xPJO4v1kn5Lp8xVVVgcPv8FyITfmJ0BvyRbCPfAOnOj1aSROy8LFGWwzNAYkM7TOTxqoovX9CGHXJZ112XEemDFo8wswwFIKu7hdlLhSOUX09XNDGT7t0+QmsaLpty5FOoHhP+zbLMl54tdVKwUZ8U6BaoSw81w4+qYMqqIsLX4s048izADSiFpihiMZzUBJadk=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LK4n4zvRZw/NLFkjd42G0MQVeo5UnV517xxGaQZkoUX1DAmfysjsBUOVughvPEHedTrViOxMo5oZkaj+sBIUNodOJBh9Hr9T5Qjpx7kfz/d8zq0juu7fh5q7RGf7BGxvAYIo+joPcdXdu3Z2LdXz75mdUppNn9XDLir6rh71IVxARYaZD7ziRU81Bsfb/uHI+D7zfzu5hwtkl8sOoRe0sQj0yZISeGgTkbjhWtvXDCM6ASjEWjFDFqr6AB856Q/8S4d+ubG2bB+N0GI1ZleiXIKuP5rrUlnlaKo2V9Y+J1AFO9eOb150j5lrFymK58ejeLmxI28t9sLmuiecQxtk7htCmBvdTdz19h7217wxhTxiLMVEUQjO+BX9wf3SRNKbIbZnNsfQeWtUFZdavxhK0+h+sTxlYaDcnF+Dszb52IZMccDV+yTN8bll4tcHGk3e
X-Exchange-RoutingPolicyChecked: DaI7E0bZgrFPtvWfdqHKLiL0UoY9aYnnv0wz3lbFyBXIkjzZAkdwge2SUBHRA5rk8ZsaixNSeWSia3zqgcK3/oYWmirPb7o/wx9cs6nDfrF2MVzJXKQVrL4VSm20Ws2QEWt+sUKJJ9VQ7FsgKDxzfwt78I+PNFNfirLLr1omE3inOw85ljSqghZCT2VhraXCsu2JYUo9Xzv2p19TS6WxAGQZbJdRLaDLHmoD5k3iROSShEfRn22psjzdSTW3qL74Yr1siVbHwKxCq8nMKV+Qoe+EtphckguhBzbSMSjornMIvjzirNXQ+10gO9RCgSrbsy7MlZQGJv37IGCRIpj3iQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S5PR9/8J4TvbsLG4hFAAHWOBS06+8yGvEulyvMnr4/RcLDbRTcNIkZAA5wpXiy9osKLVcKAitXBc4NUQsoi7WkEWXBWlASjiT1vN0z+vnLoUHsOXMTnHP5FsR8MP3600SuUIVjrRjLNL44jrswRweyGPQbdObHLxhgtASAHbLovaVFrTct6PhPKLJ0dUufEBq+Wn+IRwppGlC9cje1vm80yJBo21YWbPRB6zjnbQTaCNMDamgGhDh4Ubdwdx+J3HFpxU/Mag8aeLsfZaLu1iB2/F3biSADvxH4Mw2PAmcTAqgPx1YbqORdYLF2OBTReLDbszPh813BM6iWUrQrdXlihjxGk6+kqRhf/TPEo0lr8eciY3BvPEPi+vaGbYfNYMw8185ScETAPldjEB5XdWt6KXTpfTP4o7Eu4086/jbUucWYJrGv18mMC10ugz09J8ygCxN2pCPkXTYjG3BGwV+zp9mFJeFqHwccEE53IvGwzglVsViHi+aaOLrcKk9wploi8oIywbnisJuSibxEfvmIzGQrl1m0GmlwOB4A5OrwpYEytRFmVf2OxxGcY4CuvbnsjG8AmXhQW1DPoeOOQ2Uu9AiXXhab4uXRbBFfiTHi1iBKRWQpKIxdy3tOBGAFBVxdXz9B+nipzLOYy1TETKMQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:48:55.0147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2baaeec-d667-4322-f343-08debd3534f4
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB4731
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX/JGe1rbIMGvM
 ZQHka9c5kq4MyaEA6RoIrJRBHs0KNWhT6jPaddHD+d3sYN1onFGKFgOQP4T7OJqj5HUvvxUlASN
 J0nrmKadC+kEEg7qWHmO8jsdmE0gmxuY6Ws/i0ZsQhC/WVgG3HH1fI+zIDW6tYzwk6HJs8tTNTP
 TrMRKWfsHYH51qkJQLETdEwqSmQTJYXpBy7VOn49O6mekHQOzGqJZTvPba6aG2L8fIkH9eFSk+U
 lJ+Yc9o4JdZopZ6e4a+tsg5Ve7wn2REHuBmbCe50CzJLh7768iRGqQoh/2mgyK1pmz2SZzqKSNi
 tgdXzKIiXzWzGbuBRJuyOqMi9J6CjXJoxRWi27GSX7wDApQMeAEnIIbdqAfQDcfnmSPef9AvJHP
 UmV+5E+mX3TIg8x0BMVxXZWHeZ+NB8twwkjChasLE1bk87QjrNC9cXGPW5XAfL4l+hBJuHppAAc
 C2LVBETtrGkrv2v///Q==
X-Proofpoint-GUID: lp0hHkp14Y7ZhcKdP7zDsp1wJT0h29vl
X-Proofpoint-ORIG-GUID: lp0hHkp14Y7ZhcKdP7zDsp1wJT0h29vl
X-Authority-Analysis: v=2.4 cv=Pa3PQChd c=1 sm=1 tr=0 ts=6a190cab cx=c_pps
 a=x36oJTDjInEio3y4qvlK/w==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=wkF2nE8tNcg9G46RHpkA:9 a=G69WFyCBNqGPyalROSdv:22
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

Update the reset command documentation to cover `reset -c` and explain
that the default reset type can be overridden through the relevant
Kconfig choice.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- n/a

Changes since v1:
- new patch
---
 doc/usage/cmd/reset.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 79bc8b9deca5..e319d2146caa 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     reset
+    reset -c
     reset -w
     reset -edl
 
@@ -21,6 +22,13 @@ Description
 Perform reset of the CPU. By default does COLD reset, which resets CPU,
 DDR and peripherals, on some boards also resets external PMIC.
 
+The default behavior may be overridden via
+CONFIG_SYSRESET_CMD_RESET_DEFAULT_{COLD,WARM,POWER,POWER_OFF}.
+
+-c
+    Do COLD reset: reset CPU and peripheral/DDR; on some boards also resets
+    external PMIC.
+
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
-- 
2.54.0

