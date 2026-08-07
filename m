Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E4DC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 12:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8340B812D4;
	Fri,  7 Aug 2026 12:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bUNObb4Ot1yn; Fri,  7 Aug 2026 12:50:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77480812D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786107026;
	bh=KJts/mRxVHKhWo5wgi92YN1lI1aN1aKBGshas5e0jpo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UI44mnqgL67oTZT2KE1LMmLRZ9GUTQmFUzBmF3h3rQMYAOJQfbE+Q0mex3PhdX/YU
	 Zj+EYIzUUxbZOVWbJijVpyGNFj3Rcq21PcUtOA/Aj1NUjv0OV0fMkXsvY8F310ur5s
	 Eo577Y8JZh5gnMsAv+oKqHSvl9EO5F7r2o7D2azSMtxDM1bHhYmjEq+dGy8LWQdZbv
	 7DzdfbzdUJCX5Kx28amseiup3oM1EDte8AjfpCyYcZXdKjgYw+GbwGgOv1LcXu9sUr
	 IMlT9vOgHZy81aeTNTV7ZWQ7XygmcJVudV8CskgBpCHEZvq1NywrhGhCnrbzTArQBn
	 sVJO1CtUvBQyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77480812D5;
	Fri,  7 Aug 2026 12:50:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B1AD282
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31D7860690
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:50:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dbkQ7EYlRh-E for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 12:50:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 32A2E60623
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32A2E60623
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32A2E60623
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:50:23 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 677CeBHm2986391;
 Fri, 7 Aug 2026 07:50:22 -0500
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010068.outbound.protection.outlook.com
 [52.101.193.68])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fweqn8ajn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 07:50:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdP0HsiN3cz5TxOuH0dKjy9aO09zccVvvZXfvDe78NM7D4Fs6BjynQCvkSss951k6yPEzkKrwWq7RPnSLsAZ+cwtK/5tVhwLT9KcNbSZYctvf2sexQNS1pnFR6QYNHGW18BbdUVn4i8CpVpz2PjXf8Vc5+XAQPxJgcMLFlihqsDCS7eK0NNs5F8E+jtbuvlqJpucymbwwsRxHLRNTIOq9Lj+v4IV3MSeHR2ThFKYXYrjfhTLUbozdMBNYNiQtUNYgPib0m8/JBW22NCgofXdYHxJnFotNo2WL9GRiQjcSo6gPg2NKwH7GZK/NJOwx509qtRvduqlnRfo2piC/oEzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJts/mRxVHKhWo5wgi92YN1lI1aN1aKBGshas5e0jpo=;
 b=vDWOcqY6iOIA+boduaz7KN5xtI8WG3WFGmEwWbAehu3xGQe7nadzcT5A7/xaXREMzaVWUieCQPuNmJ75twXXeQ0Wuv+fydsXHWvAj2e5d9N5ykLdf9Y+UM5dWmHZo6lJ1+WHBPEFlvLV8qtb9o5hREvswd8j/g8tBcEniKV33ST/mh9yQS3ddVpC4bT4CtsXFesM9Eie9RqbowWLe2aeRiYXjAVAan4pweDsophqnEe8p0SxCqnYPG/EkYyOUO+zshvROJLIUpan3DPCvh1RxQWnUzAlMw7SSsHe+AE1sT/z/ZvLdYBmKvdAw+udNV9UDakxGlJvjcGqmfENgkgNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from BY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:1d0::11)
 by LV0PR10MB997566.namprd10.prod.outlook.com (2603:10b6:408:346::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 12:50:19 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a) by BY5PR04CA0001.outlook.office365.com
 (2603:10b6:a03:1d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 12:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 12:50:18 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 07:50:15 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 07:50:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 7 Aug 2026 07:50:15 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 677CoFIe1842275;
 Fri, 7 Aug 2026 07:50:15 -0500
Date: Fri, 7 Aug 2026 07:50:15 -0500
From: Bryan Brattlof <bb@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v4 10/11] doc: board: ti: correct path to tcl scripts
Message-ID: <20260807125015.g5osny3e3jf5t2ck@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-10-01746157643d@ti.com>
 <CAFLszTg1PyOeBhJ9C_Cf4gkM51LDdfL8VpwWg-W7=3KCBioa8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAFLszTg1PyOeBhJ9C_Cf4gkM51LDdfL8VpwWg-W7=3KCBioa8w@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|LV0PR10MB997566:EE_
X-MS-Office365-Filtering-Correlation-Id: 96336ef2-4ebf-43bd-46e7-08def4826f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|13003099007|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EDRFT0aSx3Mrb1JwKgvQIakroZfCsDR7hth2a1UgmLYHuP6XbeqPwPEwhuV2o99omcBGRLs+TSKv7krkpAxBnqILg12VcoThBHj64Wo0aI5Al2YQVBAXO+/y/KSShyZeGldwktZein817wni5XXg6GnFFciaj+oxqgnMqp2/T6kLA3pZ2cyBmPjrTLYADbXTJ9TeGOcydnqq/ZRFs8zESUYa8WH+pvWXbU7W3vIqvQrLxDh6EapHpcOZAcWcIDLmy2mYXghEm1DnV1ERIITyj6AHSlTusgbGd+B5WQ13e24EZ8iTAytnv7/diAU1ayR16FwCnnNPwYpIbtn4iHJV07yAA0pNgkEzgV9V+dPbrPzsXKwpuTFBaQbyh2iDlT8/bP8pc4vOqfPuhQ4PYsY12qbdXk5cxXuAh8P7zxGt/KBJVkt69pL+TejKBG5SVihDcuXMUsXXKGWgAv+aZvAa6u/TaSpCPk+NR9DrVzlDuedOTkD3GyXL0V5fT9kx7Oug7yhbErYD5ZCtiZuysgrraPxT28QkYsqpIlt/tTz9XSyq0/f6WC0deQU/nBExtbcu8Y4NWEfWpDGoqTpKQP4PpygJj0j8d8WVV+u2dnHl1nMjNDADot64e1RHowUZiip/To1nmQBCc5fVj+x3L44r8rBvod/I/krcVGN0C6Reb0TecpdncsvnhgwZndKfxBf7kH/ULIB5kjb0qTPxCfNU6A==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(13003099007)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L5zPsSmfssIKZ4652rXrn5RkLJLTMWl5uE3Ed6A39ivcyZo48t8YOvlV6kv75rMx/3HCtsX7LHmXgPf7INoAZYzqSdoamZgeGayK1hRdwGOeNWDd7g+GvspsJyV74n4r2oWh447hZ+DC0HPxMVPnAp/EJgAwPjvxDHcBBkkHOvmY+dxUa+msa9Kde9y4h72Qh/Wz/tmr3CKZd2u6VZnadFu9PNsc6T9Qf/tiXURtIXZjOCjIJKIMsYCMRSYKquPgSJRIHE5SaEeRzAeNonXd3BfheupOj+/WVLf1ShSXI/YWeR9ynPeJnVeBRB7Hz5gFqboDxepS5ZRU4YkwKv4n7OFlu4IV1GxpD5WBRoxJ3TZMtI6OnzJIt/DW3RNrcW/Wedc/6jIDAjXGlJycAJCCBxQRNDd15ZwUzOwE/K6NRIQOjws1wf/sDuQtWTV9/wVZ
X-Exchange-RoutingPolicyChecked: FLkxjS5zeDDXhda3Pht3IQbVXctdlYOEVp+x6YZlJikjfncb0RKNzsAUas0LeUA/dExa2UDYwmxSB0O8AEV7ytQ+F/bsRxdVBAJ2WbMGWK5hDtaMqpQanPFNr0F6Ac6kESf8RIPOGNSOWsk7bkjmlgesg7uKeYBmaPqRoKAB4Y3O9pFLdbOyfKrfXku6H6DAOeh7OCz8Zv1XHQ3U2I2wSVqDPikiNrWG0t/HbkjvGr4OMY69mGaOVcPs1V/1f7j2mDbLL2/L25FZPzM/C5pNEDrY/4aBqeZw9HJ36O/2EK2M2LbgK2VRjlEINESF6UDnj5v57TqyWR0LT1/dbummQg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:50:18.0587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96336ef2-4ebf-43bd-46e7-08def4826f35
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997566
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfX9IKt2ZHZoCak
 d8HzCNuVr1ammPexWGDv2Wg52wj/vBaSE8+7RTAXhFktLvAg7ZQiJzSj6cbYEt8j/QrGMkcQNLX
 1cgjhUghn522DP1CZg+IYnJDwQLRjR8=
X-Proofpoint-ORIG-GUID: 9ENQ8yEtHYpnqenqaP0VtD70a9SZCb2O
X-Authority-Analysis: v=2.4 cv=OZKoyBTY c=1 sm=1 tr=0 ts=6a75d48e cx=c_pps
 a=k/S6D1Pxv1bk3xTbD0KMJg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=TgPwAHA6AAAA:20 a=gnAhIxJGitkUmwlNVYEA:9 a=QEXdDO2ut3YA:10
 a=bn7x_FpfJtc3yKQXRW3z:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 9ENQ8yEtHYpnqenqaP0VtD70a9SZCb2O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfXxqRycyQVExke
 8rGTl0R9WIkIpJAzZEHDQzsOSfPJeH8JGASG0mOm7WGlls5iZp6yXILMX9+BFsuPaR1HM2GmLUb
 N9YlWbsRR3NAv8sLhYx3/HluR/zX0gNWzurrFWgPxAdtNRNDwr9MmcISIwBRYnshMmjA/OaUcXi
 urUnhvGZfgtkw7Nl+sh6DjHR2mA9ENtUr/kg64pXUWKhiGuubrTcp0Z6gY9CacUpNMb75tSuB3I
 taWyY993D46luxXS1XNsx9ur+++ByDb+Bwk/3v58WZmTwQcIjd451GcxcnCA1L7UttMD9w3DPM0
 7gKsfZtkfA2kzjVNGNc+uDc7uHqGipUICwVC70Wm+/RzCH5bI1VBSatb24xVWKisbxevXa4VVCG
 KgpuBToEmGxhRbf8q5Ww8Pp92tZ0J/f9WH7/jWks9ji/GIlJWQKDEp1iyWay9rllWhW2+CoHy8w
 eLfH2dSkn5c1DvyT+Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070100
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=KJts/mRxVHKhWo5
 wgi92YN1lI1aN1aKBGshas5e0jpo=; b=e6BLqMFES8eu0ATX82gPzL/n3Vx+gsT
 tKarDvecsUSeTaSsNRYBeyKBCJiK1uFitydkDWfPVb8YEvv1QqSr2ferZCKFRi/3
 e0NyA+KCZyHekXL7JK2Q0LwNHapRRz/wNovBexToFsaf0OShR/4wMMVcH2gFAwcG
 idpIbvF3xSKWhZGQmRE5NXRPJGVsAgU0MznIxxbz6iqYDjqAiDJHUEwCADPYZutF
 RrMAtJqoCn9Cw984KM04HUGcO1XbGreZUsWsB6dzduyZvxwlNMuImjp/BavbTAF8
 r4Au5Khn/isq4aLxaz/CIMo4jNi+sGQBGm3Ubj6R2p7WnXUiyI7qs1A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJts/mRxVHKhWo5wgi92YN1lI1aN1aKBGshas5e0jpo=;
 b=co5OySq9SGMm8+Gz8SUeI9V9lq5UZxDIgdGqWJWcXUnIJ1Y9+mMGTpu8XTxXpPxwwWYTouQMLMDgO3uNEKftE1vdDworSGdEDyr6QyXH9gFDUTfomfOkYZ/kHFXbaKQZ5vdPddtuUigAhtC4xH9YOmS2wNxygeQXi8mqSpj43Jk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=e6BLqMFE; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=co5OySq9
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

On August  6, 2026 thus sayeth Simon Glass:
> Hi Bryan,
> 
> On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> > doc: board: ti: correct path to tcl scripts
> >
> > OpenOCD has moved where it has placed the tcl scripts for TI's reference
> > boards. Update their paths to the new locations.
> 
> Minor: 'has moved where it has placed' reads awkwardly. Something like
> 'OpenOCD has reorganised the tcl scripts for TI's reference boards
> into a ti/ subdirectory' would be clearer, and it would be worth
> naming the OpenOCD release/commit that made the move so readers know
> which version they need.

Sure.

> 
> >
> > Acked-by: Andrew Davis <afd@ti.com>
> > Reviewed-by: Anshul Dalal <anshuld@ti.com>
> > Tested-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> >
> > doc/board/ti/am6254atl_sk.rst |  2 +-
> >  doc/board/ti/am62ax_sk.rst    |  2 +-
> >  doc/board/ti/am62dx_evm.rst   | 11 ++++++-----
> >  doc/board/ti/am62px_sk.rst    | 12 +++++-------
> >  doc/board/ti/am62x_sk.rst     |  2 +-
> >  doc/board/ti/am64x_evm.rst    | 24 ++++++++++++++++++++++++
> >  doc/board/ti/am65x_evm.rst    |  2 +-
> >  doc/board/ti/j7200_evm.rst    |  2 +-
> >  doc/board/ti/j721e_evm.rst    |  2 +-
> >  doc/board/ti/j722s_evm.rst    |  2 +-
> >  doc/board/ti/j784s4_evm.rst   |  2 +-
> >  11 files changed, 43 insertions(+), 20 deletions(-)
> 
> > diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> > @@ -331,13 +331,11 @@ detailed setup information.
> > +   Until the next stable release of OpenOCD is available in your development
> > +   environment's distribution, it might be necessary to build OpenOCD `from the
> > +   source <https://github.com/openocd-org/open ocd>`_.
> 
> The URL has a stray space - 'openocd-org/open ocd' should be
> 'openocd-org/openocd'. This will render as a broken link.

Thanks. 

> 
> > diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> > @@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
> > +   Until the next stable release of OpenOCD is available in your development
> > +   environment's distribution, it might be necissary to build OpenOCD `from the
> > +   source <https://github.com/openocd-org/open ocd>`_.
> 
> Two issues on these lines: 'necissary' should be 'necessary' (the v4
> changelog claims this was fixed, but it is still here), and the URL
> again has a stray space.

Apparently I misspelled it multiple times. 

> 
> > diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> > @@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
> > +Debugging U-Boot
> > +----------------
> 
> This whole new section is adding OpenOCD debugging documentation for
> AM64x, not correcting a tcl path. Please split it into a separate
> patch so the subject matches the change.

Sure

> 
> > diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
> > @@ -261,4 +261,4 @@ To start OpenOCD and connect to the board
> > -  openocd -f board/ti_j721eevm.cfg
> > +   openocd -f board/ti/j721evm.cfg
> 
> Just to check - every other file in this patch keeps the trailing name
> identical (e.g. ti_am625evm.cfg -> ti/am625evm.cfg), but here the
> second 'e' is dropped (j721eevm -> j721evm). Is that really what
> OpenOCD ships, or is this a typo?

Yes this has been a bug no one has noticed for a while.

   https://github.com/openocd-org/openocd/blob/master/tcl/board/ti/j721evm.cfg

Previously named:

   https://github.com/openocd-org/openocd/blob/v0.12.0/tcl/board/ti_j721evm.cfg

~Bryan
