Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15A4CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528CF84936;
	Fri,  5 Jun 2026 05:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="cCTIACpX";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="cYkStiI5";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="cgejt+yW";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="ZyGvIueJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258888489D; Fri,  5 Jun 2026 05:54:05 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C57984878
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 654JnePU440537
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 20:54:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=is+ysgdqNDezlqQyW0y0JyP4xhP
 F2blfEqZAjHIW8zI=; b=cCTIACpXMsOaV3VASwvzBU37eBy85ZfqhQLDDmB+KtX
 qGUaKvvXIF2lEoXbQzqPRECQ2DGb1aMCWYWoL84DDsFKc0WR04nuEQDrA50UUZl6
 uRzSEuTxEHjrnU3IbBEUDTYjPAAUwS99mpaZsHhAvp3acvd0iJK4T2jg/2QuTNuC
 kKfsDDlZPNk5Z+/uOY3ATrDdMBuRAhiBxuaFcX3ocM4uAMebgFvpXQLhuIYCJeBz
 hGC77wnBM7DSvbwA5ROlNzfa0JRn3UYEwHs/g8TXamE/glClpRZsnjko8zRUbdrk
 tYFISwvOim6jBPJXLusJ0MB5jq1qpzmk77uoK31jBoA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by m0482515.ppops.net (PPS) with ESMTPS id 4ekfv1tkun-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 20:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9XelUqYXJK94TlHEzHjwnySOkLw/ecMxYwPI4+O9Z+7mKVdxYpqM7MKSX8UBBbAscyG/LcD+W0r7ZfV/bIHCC1+jNm4f9l/KQS1UkKAdriBrJCp/KOzOhDLySUGpeBuhVNnSW20U3FPOnmkT4pFcsb1WhkbgWgzGdULlvNkgB2z4UB7ziXN+8U1OwxTulgq2m6LVQhzPSjFRVbufcjDigaV4dR5KDF0v4BEzt+FpUqthvXU/YhAL5hGjKkeqV+yg6/bs+Dmdul5eco0Whg6ax/BNJzOgSVISZ7ESCMk1/k0tgENobQ0O52wJ3bkMsXbM22dlPqEoehQht9JaMsy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is+ysgdqNDezlqQyW0y0JyP4xhPF2blfEqZAjHIW8zI=;
 b=UTjxenGlSoyEfjHCxB+r2gc5gv1EeCe81z7NhtNMf3cqUDhcyyrDRzGs1QPqJB4z3CJBvFwYu4WP9I3Iz07LRCKDmxZ5LGyx3/OxSu6gQ67cLBVkS3updXp0MeM73RDpuNVsQbGt67k/Wvg3aGMDIWH83Ism2100J985xp4NHK4XhWIi8jZ+uH6IsgYkDujFZ/EUIDg7IosD9ffqBp2q5XXklT9KuoBTdQreYXzFUD7acCaVO1dNA/kNNksJ0adBjz42fQnw5K2jHMzPgqxjC55ThYk2K8U6Ccs/7PAJo4a8NAuudVTEMd16E9v2qjWjtac176N8Sr8TrGfNzSQd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is+ysgdqNDezlqQyW0y0JyP4xhPF2blfEqZAjHIW8zI=;
 b=cYkStiI5GKPNESc7EtGEeFJaXXJFpU+Hb/BPk3FK4RRaJgcqClPs993dg6ti/tKnXhV1TRF69zzx93oz41OUP3GxmyaRMlXu6mFbcy1KUmjJxgL4pRlRZ/XfLkj6qj9utjoZutxFR1AN1GPkSJguRv183YE8AJISrYKNCHZawxQ=
Received: from CY5PR19CA0116.namprd19.prod.outlook.com (2603:10b6:930:64::8)
 by CH3PR16MB6087.namprd16.prod.outlook.com (2603:10b6:610:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 03:53:57 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::a5) by CY5PR19CA0116.outlook.office365.com
 (2603:10b6:930:64::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:53:57 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6550mi1o3761574
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=is+ysgdqNDezlqQyW0y0JyP4xhPF2blfEqZAjHIW8zI=; b=cgejt+yWKdKd
 3g9PNRzZqawbiIbqO/10/OZHdZD7/Gc02K9IRHBTU12U6BrEhQmOIgRauKyh+6PT
 6nIGQvLeig2oUiE9GjRfH7w+u6OGPSPB1ao+rKwH+apVKWWRvurS23mKq7JdHqOH
 F1SwyXsiMX8N1YnuZHvIPsnAvNFNu+8ccHXbHA12ldwb4qOTj/r7idI9IKwgklqB
 ru9QJqEjERK5qDWq01l1IBTCKCeF6n9SuPOX8ntDl0mmuFe8lz3xNATAuMTIF7uS
 ruff/e8BbQz6jbK+ss9GwV7StopqxpcywOEMncbidtCNs2oUpjAaIMcmwscYuRhT
 uAwJ8kvREQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=is+ysgdqNDezlqQyW0y0
 JyP4xhPF2blfEqZAjHIW8zI=; b=ZyGvIueJCQfnhJHLoxhQ09WViWUoI5KbXbyZ
 5BNSxPAChj24RAzWA20GjSatkFfsYicpPzq32VG+GwS3z4+E9vj41YuBQ7Isrd0k
 QRioyfWR4AXfN9EmUPrUulaSIXUHGSbxXuZgiIGKg5CVNwr8Jx7T+Fa7VVVHI+CG
 1+VoRPyYs1YIhzAXi2LtFEDCnXeRlx1LmAPTcMwZerCLLIUQz5ihmHanitv7qxYQ
 9d6g5tiHKLtA8zgbuavf0EoyRMX6AnB8gpSL1l7gUQ5PuFGWPLJ4wVWEHTBv4slq
 uzT41FiZchRMhtUxpT1h9ldnUR+NQwCI2t3diuDbSuaaR8JiiA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4egeypsdrc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:53:56 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id VLd4wtCKCba3bVLd4w8GVE; Fri, 05 Jun 2026 03:53:55 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLd4wtCKCba3bVLd4w8GVE
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 4 Jun 2026 20:53:53 -0700
To: Sean Anderson <seanga2@gmail.com>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, neil.armstrong@linaro.org,
 sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v2 4/6] cmd: Add flush support for all blk devices
Message-ID: <aiJIUajDdCz3tnkc@kraken>
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-5-dmukhin@ford.com>
 <757cf33e-0a87-45d1-29f5-aac6fd5282c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757cf33e-0a87-45d1-29f5-aac6fd5282c3@gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CH3PR16MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 89626bbf-065a-4cf8-e1c1-08dec2b611ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 5MS1PSavOCTPecdcT4TM1UiQ5NBewHucJj477SxyPjqB2MdeJsF69srWgnAWwEvpZwtHs0qdggZVZ908jWEUreFiZWc5oL5BgUUNsfzaDlwd11X9Mjj7zixF9eAESkX77looCf7HHb7gwfgnYQIiBHa+m12lH5Ca/zkoEtfOI8SyPysCM+5lTu2JJpHM4cPHSeXs3DW0LCvmIl0oJOM/D5XCHkPEDPIAqlnGxxCeiTF2hSEWM3OaZyENQ8eYolTEosz7rzl4ZifaHiI/DlW609KDBMpVTuPU5UfIs3NnhY+IciMuu83oNB7hWym2t/MuRkDJ6waMzsecIoUUK/6+0DAFGOzJl9TENfbrn97Eh3c+0TL5lv9/ZVdzyqtudHcw57X8qQul1Zwtbn9e2K2UzttCFJHJhmK1W6755tZIIH/MVdwJ7un4X5a0wuVhMYG9aOrGELjkcx0T+MRMwD2/d90pLa7rwhpowsYmcfL7/ERGZHy9FDTWYaGZomK+TuG/XKyFn/ff4cYvH8Pk6pZLlL93JtKRFiKnTXPHElCpT98Vtm1ZpAgzeCFtg0+2RoEix7TP60dp8smbtfoDESSEL+u/WNlVMSK3m5Ps9FetYl5zwGPx35geiIE1qiZZqnQiXl1HJOY2ePkjc4hNVSQpZyZ+mcJ/xdHsjMwyDiCl5I3jmALMJ/6BxAPwSlE7jLN0kPnukJio1rlW3yKJATQCpg4yXdu9zPp7WZ5Iq/8SJJw=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qYbR2pTamLJRrccj6HdlXrEWrF8W6TGUkL2EL0jFMCRgwsOQ7eh0W+Wfxhe6Y9VRoNPmmKhzUnS++KFwHopH7f0/TyO8RIJo7ktLbA4VCOCcSrFN3R76r6K6tqASpzYk2fRc+3ooeNHtDIngtKQ9uff4WqT3K/gjuQ5m20mOGIfJVTI9jfnhybhZV8R7R+JHyjPfrSPmek33s9+YAIJj5FQ7in8Nz6Ci1r/+kxjxOoyu2JYN0Vn3VxGbWfgStkCf4t2CymZkguMMBaNsJ2N/h2RnjEwIkfMvVroA+L4NnuBwkCWEt7gHNhTKQmnFApjiUvAnlm9J42R3wduqafAZ9MKqiz7SVlEWsDTg5mgjsdd+qnQ67EuTj72PbK0ySJM/9c2YwkqaWjYT7VtRruGzP5Zxh2CIi+5Q4DzvIMHGnch2M6sCSK4jdo8TR5ie/Wf3
X-Exchange-RoutingPolicyChecked: rarWwtwS4XSqkKnIGrLA1K1z6nk4RdO++lLdwOX6s9zijhRJbsKtGDZyq/T3ekIId2hc36n7cDzLadEzxdBkRN6de0xWo8wht7g1bRWgfkn5WiKI94r2oyFpqdkBWUlh1tDZZIXpzM0eb8JA7JsZbrKWN3lfPUsNFvS9gVDp+G9E8ZrQUKIFp4jGfCCEvBU7sN3X6GDte83XyFdnDdDDb0kWOzFdh/0YV3rXflgdvAw5dpgGOZBIuFOpWpbdR9akdGgNBWVEGDvl66Ru0Uwc6nswwoV/CJIjtC8IdRc5b6uDEDThXZ7HeayfgtQWDPQHm0s6tjVQUh3AM3LxsyYJFg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ofYPYVhkjlk7lkR10tzV16ntt8q1+UYNC4EyFfxSumLzQeNv7yDHhancjRavkNOllGZpWEfuGfaBDEo/iJEzGLp6BwjMAjcir7i0KlPnO1WIHMolWgH8Mu753CM0wv7tHY7399QKAXmq0unk81l8aynuDYQr84nJ7wJl4j4oFQNwUAVwqNMBYDKubFv8zfTM2FPqUM+FXDPEgGg8lhPcOu5LMslADSgq9/ZLyHlrFD8WiJo1Ms0Nv6lzt61/PXW/ejMaAlcMEwVTztqJLRBYiTpczPxBfO0Y7dLcJxH2WIzAWWDqygI8UyqQSOup/5rf9S9QU7JqiRZTBq6qQOLz6Ur7c6OPnhTm77wZFmsGJTLaglrEZwFHqaFWWuDsA6egb6Xs4mkXfZoowuNwp15k39NgBq2VE0vwRq8c3jh+6mMzPllhIMRyNenQazx2v2/bSOSfCSnHsOIdq6TEtIgorATC0ZtxfKBoWrgQccZkVeOgUR3UfmAOag7PZiDh4cGkRUM1txdPHYFoNi1kmino9KQ+Zq5p1gJTAYTyXDWkMsJjOpwZMVOowDYJVJKDuB6G68rXn+lY0vA5FdWmF/2pVBw0RMLBmx1bHGIV3SQOZ0/gRpN0CfOvlUHhmdgs9I0R
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:53:57.1743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89626bbf-065a-4cf8-e1c1-08dec2b611ec
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMyBTYWx0ZWRfX9gh/EfjeoWHc
 Gz4f1DxhMzT/vnKPvTVLIas0/baTtkR+utrqQVXaKtNo85em3Kk/mROEax8aqLN5AkJdm/Us21a
 i3Vk4ZviP7cm4Q2Ix8lIHfiSm9CnLLyuJ2E0BP59gxRx6V4U6Pij80mXYUJMBvk1DM9Y6ElR3zN
 86CK0DZP0NBlR4JRSeeIgXKT06Cz0XlhMwYQTgDZ8wW9ypX1EY00sprvwb3cPyclQz1aYCznGFL
 kmbaN4ZmzJ8rOdvBVhCbk+6JeycMJskqTlEB3tnSVHdjUHgO7I5LjIBf4t9oCo0A18e6R6Uxai8
 eHg7814KQctGetlrlTvS09cc9SysqAd0mPwhNL1PtA4TDh2YlEB2Q68D0JD/Z82UU9LQIGuexb6
 r9VV7PWTHrJZEGkNljsRWjw31FoTsoabysTnjaQnzEfYClmr7I+1e0bmFR3aD4HDsVTEX67wmrv
 HfdCwPDtIjM/PWMo3qA==
X-Proofpoint-GUID: UlE_f0pVgUR4Uax4QC4XJEaXd0sWRBhQ
X-Authority-Analysis: v=2.4 cv=Ify3n2qa c=1 sm=1 tr=0 ts=6a224859 cx=c_pps
 a=lBUCPINxFTLumcbCLOYEQA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22
 a=cbNQJ9GKAAAA:8 a=x7Qpv9Ok_amiFVCXgNMA:9 a=CjuIK1q_8ugA:10
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-ORIG-GUID: UlE_f0pVgUR4Uax4QC4XJEaXd0sWRBhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050033
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

Hi Sean,

Thanks for the feedback!

On Wed, Jun 03, 2026 at 01:43:10PM -0400, Sean Anderson wrote:
> On 5/28/26 23:44, dmukhin@ford.com wrote:
> > From: Denis Mukhin <dmukhin@ford.com>
> > 
> > Introduce `flush` subcommand for all blk devices to allow committing
> > dirty data explicitly to the given block device.
> 
> Shouldn't this be done automatically as part of blk_write? Similar to
> how all FS operations in U-Boot look like
> 
> - Mount FS
> - Perform operation
> - Unmount FS
> 
> so the FS is never in an inconsistent state once an operation completes.
> 
> Is the performance impact too much? I'm just concerned that a lot of
> existing code assumes that blk_write is persistent and that it's OK
> to e.g. immediately reset after blk_write returns.

In my case I need to update the GPT-backed boot counter; there are two
GPT headers, primary and backup, so I used blk_dflush() to guarantee that
both headers are updated before jumping into the OS.

So in my scenario I need to ensure that those 2 writes will land to the
NVMe.

I think FUA suggested by Neil in v1 feedback should be a robust solution
for NVMe, but I went with a 'flush' solution first.

> 
> --Sean
