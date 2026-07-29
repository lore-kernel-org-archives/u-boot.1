Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E61C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 10:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE80340A79;
	Wed, 29 Jul 2026 10:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jp5D6upCAxmL; Wed, 29 Jul 2026 10:46:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 976D840902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785321971;
	bh=kNhOp70X1FRvqI8nkGvDwQvycHSU/gkE7XigC4dWoXY=;
	h=Date:Subject:From:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFF4cCkgoVzgskgHCfBOQBdFmxBPLhJQlLZIMVsDPK4iBlRK47c7W24mm0xRG/atl
	 JnSBzEcGZrTiUAJiV/76gFCC4I60XPmAKKVJXDAxJ8rsQzqBTOie34Jem1WOW+XK2q
	 FBtpCwexweJNqdyx22PUwKuDZwOD+R8cMqAS0VfF8krLxc0mtnw+lb8nEslJ4qUt4C
	 A9YnExybX+INDWvm/K26uuaO4XyFrPyGIxHaKVxHSuFgPRoZCQcMKFnzZ0mlZ6jV1M
	 GmN8AodmryUymIABPQJjrMtXhDbBoqgITG0z0AZb9skOscb2lGHw5CYIUNzOXIUo7V
	 9Uvo/1t17HG5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 976D840902;
	Wed, 29 Jul 2026 10:46:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08AE53B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0655940260
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 471dehQCd3m1 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:46:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anshuld@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2CCA7401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CCA7401A3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CCA7401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:46:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4EA08493F; Wed, 29 Jul 2026 12:46:06 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079A6803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 12:46:02 +0200 (CEST)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7eb282161968; Wed, 29 Jul 2026 05:46:00 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fqcwv10ss-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 05:46:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4kUExFwgnSdbq/hb0Zj+V3zvo9HLYZ7Ac1/xadqhXM3tOmfkYrRy8DCxfidkhWDeJthNA80ifRqEoNOFi+XgeHjAVGpJMm6UDOMHYfoVZFyNVa8LhVpJaUAcwIc66GsSSRC6G8ikL+XXymFfvCRKOf33Cj6JnifmRLi53FVhtewqyiDSCzHk/49oqcNW71vY9PKr3WQ77SnG3n7FrjclZYf87pdd+M63CarFuRo436TrfBsORhFoOYyeQLMRKq5vtu92u8sAFrP8ZOKzQQ1WCuxZAsw3UKIv31OXC10nWUGRuYSiWgEEVgRj1tifWcqnxN3wgxJH3viz7q9GFrhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNhOp70X1FRvqI8nkGvDwQvycHSU/gkE7XigC4dWoXY=;
 b=ZvvrRH335/yVlRFAb7sbeNawkCNOp1g/9Bq0eJWk5PmydEc0Vfeqg3p2I680KL9AeLH6jxK7dQx9QpIp+nAWr3Vz+TKf6zHUIHvn9KHzH5t4tc0On9lqKORUdf7nZYNE5LE9a0ghhbw7750Fs1g9TJerpPkisiic5ySHv0lpSeWBV4A8MQRB9ZFp6yaP0sqFopSLC/iMlBSJ2vh9Owwg5kh/km36DLkrQ+WMJMhF5QCOEjh83yYIr9qMuUD/n4sl5nVSnraGygJMntlng+OibOpKmdRH9j+ixQSuGPygyakapC9nIUSUJ4gvfsDguxNiURTqNKli+VxuWlibutSVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.phytec.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from SA1PR02CA0004.namprd02.prod.outlook.com (2603:10b6:806:2cf::8)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:45:57 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::14) by SA1PR02CA0004.outlook.office365.com
 (2603:10b6:806:2cf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 10:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 10:45:56 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:45:56 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:45:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 05:45:55 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TAjtVv1133207;
 Wed, 29 Jul 2026 05:45:55 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jul 2026 16:15:54 +0530
Message-ID: <DKAZTBHXURMI.Y3HM2XDFOEGA@ti.com>
Subject: Re: [PATCH 2/2] arm: dts: k3-am625: add template for tispl.bin
From: Anshul Dalal <anshuld@ti.com>
To: Simon Glass <sjg@chromium.org>, <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
 <20260717-k3_binman_refactor-v1-2-4089220b4fd4@ti.com>
 <CAFLszTi2Rc52TKKoGOicXEHF25GUm09gcyuZz0Y5zTjBw1W+pQ@mail.gmail.com>
In-Reply-To: <CAFLszTi2Rc52TKKoGOicXEHF25GUm09gcyuZz0Y5zTjBw1W+pQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: a675bc2b-8d64-4acb-eb3c-08deed5e9201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: C7R9iHEDFQYNfVdVB8X+6+NVQOfMcy7K+uFhCX/JVsn3DJBEgYS5TuMfXVDNty/RiOD7vl0GD4wU8PruO2jAhMhKjAwNzzKcWzI/MRiv61l8vci6RDgrs143hAOqfK4uOPdn6CPVoGe2hZlumxAPIfnAJC4ZsY5m2Yl3aAfgYn5xUGqjlEdPCIEK3WF+0VrG1X2XwgCrxBW6JwdDyB7i3G2Nd0dt+q3Em+a8jSGQxXghkjvqS2N2EFmVC7z2twW2M1PV6W9vFAsCLsK9wTorg8nLPY+5eZ2GqENhD9+h8TaU/7sFiFZAg/tsmZfGOUhRUu1ndsc+h1ZQKdHUmZDn4shBc52r/CNByKCqFPIOmhk8W1rtiwMKu4MEesNmMWEwIZFNQoM5PnDdh+FSXElQwHOEWGinwgy9bvxd+sWXmBBhMbhlcaY7aacxzuE7t4iXEsQBb3aoT2RpXOxATFo4Caay1/5jn1DDhFOUq8vBoL+MT10edUQVA+C9zyH24E1PlqPD5aaQsr1423DYt1s1w1ar88xY0CQpQCIuw7D19TI6bCmn+EhjbT1oK4Ywuvw0TF7aDYwx37gSjeI7hxMgRkoNnNMnjKoWYLWNyuoa+n+1rlcWlQXyGL1wOw3HS5TVxf6efulhMfxs2fgMj9qPONV3TMcMr5aJEgJWqGOPRxG/qqqWykKXqU1jJkLqMjcADr0AlFUCG1bEh9nTY7LDXw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cZdQR6rXP6/LK6iopzZjMp9tjFmtPrUTMRkt5M1XcWtjvnuU155iICNwm6VQuIyD1gEAmKJJg3PsjWn4N3jz7aMIcstaS69V5ZfEpGb2PBeiuEjAl3L9t5FumyarBe0g5BAhV9kE3nqT0PaiMRu4zDGAQeUCK2yWDhlcFdAdxHzO0Fl2jHp5s1O/Xc6dXA5mvTv3iqGQPoYLWXcMaTLVVQxO4kpmuzkWJN8XN2suDMXwgJzW36i/1fLh7oMy4/YHVrgP2sCfWqQzGrHqttbMYORl4CY0BFZfr0j0Oks9WX+9GxQhozriKmhH3RsDOjz5zT69iJENwhajyY8D4g7GkoYMOe4y9jzC3XORiwUwQWgy5nnWyT2H3tzI2tpZEMw3a8DHpY1BcOkcy6F3nIKMr8fAF+yXutjnWu+Iszwe+CSj+eTspvHq0deDenrlwUUm
X-Exchange-RoutingPolicyChecked: gazSr+41VKovKwagoQ6obbRc/04LuD11FLdgt7VvSPPcUGplb/w4pWo/X50MVzjzVCGvdpCiksOfYCTUb57dOXGE7d8aBgr6RppEIeal/vZwgRRv9YUKCIem/ZrIlVSfsNg8Znk8E928DMt0DvYZPZoqBboelF2bTtt8uhLFfkvs8u+fA3MYCJyjZq4ASDnTy57f8uM32INc9LIeBfRSXbK40BcKMUW+YlxEOUCNYfWKx//WV4Rv3/RtkSQugaJKV9suset9lUICbEuPxhOI34injP86CfmdrrIW3386xN/H1zTSYEq6GgQrpkFGIsmR/P54KmZ54PXJebrPjWioqQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:45:56.4764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a675bc2b-8d64-4acb-eb3c-08deed5e9201
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-ORIG-GUID: XNUcDsw_S7VmCRlPctFbHcWUK40HG3LY
X-Proofpoint-GUID: XNUcDsw_S7VmCRlPctFbHcWUK40HG3LY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4OCBTYWx0ZWRfXyU00tVHx4me/
 9Bp1Be8K5TFrQr/67znZwvYEABUkq8TrwtzApBuUJGz0lCoKQXucz6pWY58fsaaHov0kJ2diRLv
 3kc1l1GCEO7omVWDoMrGzbvTnJyqclw=
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a69d9e8 cx=c_pps
 a=aSTqfDprWv2neSIyXEkWYQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=3-jCkAf422D3If6zWRsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4OCBTYWx0ZWRfXyVM0RoFN473Y
 y5B4A9tK7Rb4f69uVArl6k88VLk6C+9bgI05LY818CorOfGMVxdW5C+Ub+Q3aTwo2FOg8iv5FIS
 KJ5OLzbkhSvh+blAl9jefnrSxJ/8pybFKQ+8FpM7yGxsEiuzetJgjlZdVNMdlMhnmw3gCGNQAQn
 M276/pX312xDqdbWsmRTg6XDCChaliiR+RaKzX8+KamUAvPbmAXrJiq9lMoFxkYUmv9jUeEk8WP
 prx/aTn2vmixG8dqOj/kD6kxgaoljIok+9i0RPd+c3Mu1JYlezL129aBs1iMkZnWNVKjKPJ2HRI
 cAVpzh2KbiGyyCsQ4Xa64g2FJvUrVnntP2MgXvAeW75AIcTdIv82MlZUSd0v26RZZC5U4DgxSBQ
 2kNLJ6lHKLggFVeGr/QSBaXJk6IOFKKxhvUpRlZBb4pZrNyDsLbw5lQT+oWAw7kZdlEGTvWGYWt
 r9CJ/vWUUN97f/g2/+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290088
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=kNhOp70X1FRvqI8nkGvDwQvycHSU/gkE7XigC4dWo
 XY=; b=TtUV13CB92hoPPAAHs+fUQndjt71+/2UzS70rNCK0TQqKGCFNjukCeCtV
 ygCf3ebsLIuHl2RHirJX60MhpcM2qVUE72m6rTz9fqeFdbzmz7vydpZ2rBY0uCPA
 uUrI2vZjcE6WnwoOrl0ll724zeRtd6nQdnPUKfiNKxvdW4KEUthgzO3y7Ge4b3IN
 8OVBS/btAh4awZk3DCo04yy/9q7kN2SjMcez4vy4If7flo0ZhDkxvyIUUAC44K0p
 ivqWzfgnndtNKtCN0Wsr7NMFMTqEFClSlNQL+HC+Ky/j3IooOagW2vo8o3uanYeR
 x+qUrDahg9WFYCQLglxPJxMTyhheg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNhOp70X1FRvqI8nkGvDwQvycHSU/gkE7XigC4dWoXY=;
 b=H86D5L5GKLlJbdLBlwkiYxJvfz6YaL22Nh1y0xaCo513sRxTgyttDgmYeTpQv7/UUlGAcbd02U+CF+ne2MBnzpA6GUTS5UYQh8HPHCmzMGKM2YLhpHCJJD8tJ8iH5WdH7t6RsRBscUuj/FrIjMTkwQ3NqpPPB/jjACdoGvivdqw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=TtUV13CB; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=H86D5L5G
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anshuld@ti.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="TtUV13CB"; 
 dkim=pass (1024-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="H86D5L5G"; 
 dkim-atps=neutral
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

On Tue Jul 28, 2026 at 4:46 PM IST, Simon Glass wrote:
> On 2026-07-17T10:42:51, Anshul Dalal <anshuld@ti.com> wrote:
>> arm: dts: k3-am625: add template for tispl.bin
>>
>> This patch addresses the duplication of the binman nodes responsible for
>> generating tispl.bin and tispl.bin_unsigned for TI's AM625 SoC based
>> boards.
>>
>> The common nodes are factored out into a template in the SoC level
>> k3-am625-binman.dtsi that each board in-turn includes.
>>
>> No functional change is intended from the patch asides from the addition
>> of tifsstub-hs and tifsstub-fs nodes in beagleplay's tispl.bin which
>> should have no consequence asides from growing the binary size by few
>> kilo bytes.
>>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>
>> arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |  92 +------
>>  arch/arm/dts/k3-am625-binman.dtsi                 | 240 +++++++++++++++=
+++
>>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 241 +--------------=
---
>>  arch/arm/dts/k3-am625-sk-binman.dtsi              | 288 ++-------------=
-------
>>  arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 185 +-------------
>>  5 files changed, 270 insertions(+), 776 deletions(-)
>
>> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts=
/k3-am625-beagleplay-u-boot.dtsi
>> @@ -63,99 +63,11 @@
>>       ti-spl_unsigned {
>> -             filename =3D "tispl.bin_unsigned";
>> +             insert-template =3D <&ti_spl_unsigned_am625_template>;
>>               symlink =3D "tispl.bin";
>> -             pad-byte =3D <0xff>;
>> -
>>               fit {
>> -                     description =3D "Configuration to load ATF and SPL=
";
>> -                     #address-cells =3D <1>;
>> -
>>                       images {
>
> Just to check: the FIT for beagleplay now also contains tifsstub-hs /
> tifsstub-fs entries even though conf-0's loadables only references
> tifsstub-gp. Have you confirmed that the resulting tispl.bin still
> parses cleanly and SPL does not try to load the unused entries? Please
> note the beagleplay boot test in the commit message.
>
> I was unable to try this in my lab:
>
>        arm:  +   am62x_beagleplay_r5
> +binman: Node '/binman/tiboot3-am62x-gp-evm.bin/ti-secure-rom': Cannot
> find node for phandle 100
> +make[1]: *** [Makefile:1410: .binman_stamp] Error 1
> +make: *** [Makefile:189: __sub-make] Error 2

This is due to this[1] missing fix which is mentioned as a dependency in
the cover-letter. I have verified the patch series on the beagleplay
with the delta to tispl being the addition of tifsstub-hs and
tifsstub-fs which add a total of ~60KiB to the totalling 1MiB file.

The runtime correctly only loads the tifsstub-gp binary.

[1]: https://lore.kernel.org/u-boot/20260709-binman_template_phandle_copy_f=
ix-v2-1-6c4017eec04d@ti.com/

>
>> diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-b=
inman.dtsi
>> @@ -121,3 +121,243 @@
>> +#ifdef CONFIG_ARM64
>> +
>> +&binman {
>> +     tifsstub-hs {
>
> The three tifsstub-{hs,fs,gp} nodes are unconditional within the
> CONFIG_ARM64 block, so every A53 board including this dtsi will
> produce tifsstub.bin_hs / _fs / _gp regardless of variant. That is
> fine since the blobs are optional, but please confirm this is intended
> and does not regress packaging scripts that consume these artefacts.
>

It was only beagleplay that did not have these binaries included and the
build/boot works just fine with the addition.

I will make the requested changes in the v2, thanks for the review.
Anshul
