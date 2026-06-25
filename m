Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0ADCDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 05:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD5348460E;
	Thu, 25 Jun 2026 07:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KuQ9+lQ6";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Joh6ZZHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9637984704; Thu, 25 Jun 2026 07:51:23 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0F280287
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 07:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3eIDP2237826; Thu, 25 Jun 2026 00:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=YaXdVNHF2sH49r/7X4nksbXeH0mbXYiO8UjrZLIua
 C8=; b=KuQ9+lQ6tgPOQkFv99Wc/7KgaHNw8CmOpOF0lBQVPTlWrjivSFqKVQoMm
 ad8xDCNSh81l26tmdpU8DvIE5UtVjvaYnzyoCOixAO2GY0RT9ZqFFdbThlO56+GQ
 oG7j1yPJ34xanq1aXmBmTJtq4AvQuMQy/Z3g5EjDo/sKDlHNAFE9fAkLtRaVdYgR
 8FNl5Cjo5sNmoOK+O16o5q1Ofoh2pJSMF0Xt/1FaadGCIaBtMmIMpK5TkmeS0i9i
 d78YpL2Y3Bn8E/zPjZgEeALl4KWRPU8dNsADJZNjxh4tCuMIwyKTK0uYB1Cuvhdj
 8JAzQV3z5EAzyg+/F7Pum2zmOChlA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f0aspf35x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 00:51:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHPxl3cbubU5hDGwmzWEBeLHX8qlnSvb7CV8O2CJNDAvYL4h0bqXl17u2zYGS2NVy48Kf5Xu2CgWeMTKOvD3kgdq06mWVASS+xVoVO994bkmcQo76JHiFtFBuLqGsuPiLK05Zf7cTNBLgJuOJvYuyRPLakwt2JTTaIRGTNW4b9KHyvmAS2iR0YdCQKd6X2Eg3lwPo01VqxepTouI79sHfBUKJpHh+qRWLC6nIUH9ausmxckV4XyCDD0hcVi6sBFcX1IQMig66lorwy633RkEl5Z3irWjSJ9r5j5ZzzlBYR/vxdKZ68uUKaHOMcK2LOucAF5HDg8QBzra28nZpathbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaXdVNHF2sH49r/7X4nksbXeH0mbXYiO8UjrZLIuaC8=;
 b=VGyqT8mzomsPnlDMwpyXtXljdxir0QJGBwpmXJd4kBSoRFs1O0B4sb1w908inD0ZK+XRXaqqZZO7e52Z6JgJsGqq2MSz/Et82mJzKhj9gn4YIMY89l36eIHpXOH2opzHD8QgG3uNCNi/Vxat/9C5NwkTzR1UyzgYosNwhfV73oFB3VlczQrG4JqINPG50SixjnMdxC4p/8Rz+JjcB6LHxzV6Qckyv3o+4zpyGHzlSs9+9wD43dm+QPaAiQAuIvlK2fL3Y5u8UQdbt+WrezS/Rzd2LQNOBKmMrX7e6XqwJJM4p/jT6kQk/5Un+cOIcxuV2NoR4WzB2ePA4IElz5G+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaXdVNHF2sH49r/7X4nksbXeH0mbXYiO8UjrZLIuaC8=;
 b=Joh6ZZHIPmY2/6vkCzx+13JPaof5fVgB0lXAMonNfg1+o4qnz5nko+AcepoT+ugK2sfuFJxWJ11j2OLpZqeIOIDKkcBuGz5rWFDwBjzM3lHvSVDZjVOYtgX7C/AwXFAkI+MN9E79CgMkIedjffjrIXUQCPr9YXd7rXKOWjD6EPw=
Received: from BN9PR03CA0699.namprd03.prod.outlook.com (2603:10b6:408:ef::14)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 05:51:10 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::f) by BN9PR03CA0699.outlook.office365.com
 (2603:10b6:408:ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 05:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 05:51:08 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 00:50:54 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 00:50:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 25 Jun 2026 00:50:51 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65P5oZ2l2055674;
 Thu, 25 Jun 2026 00:50:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 00/19] Introduce resume for J7xx SoCs
From: Anshul Dalal <anshuld@ti.com>
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
CC: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Markus
 Schneider-Pargmann" <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, "Udit Kumar" <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>, Thomas
 Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260624074459.873906-1-richard.genoud@bootlin.com>
References: <20260624074459.873906-1-richard.genoud@bootlin.com>
Date: Thu, 25 Jun 2026 11:20:33 +0530
Message-ID: <178236663369.80761.5454834032276538887.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782366635; l=548;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=FxktjRThe1eO4y8fIn9waeD3cofWZnbrs77KfFSvdec=;
 b=6u0IaCRqQN3yC8yu05XOtLViU57gkCaMD4pLydVgxMWgty5wc7K8TFjA4+AngVb9mLJbIqXaH
 WA3Ayb1CKLxDy2xw9LtPS9MaYHLdlNtxDnAlyuUfq+nepJvlo5b2ekV
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f0cf37-d51d-4c99-2c9e-08ded27dc14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: X/RysUGDDlE7GL60SGSmDbDucFK9pZEYvBARnlFsBnyqEUZ//4VHGHL+2jq5wb1XFpc5tzALxsY3j+CRx1DD/1oTHBt4kuXfjLthntBfg0C5PPkt6j6DrKT5faFi6hW9UQvpICcsDihuKBFF3zLvZk29L2RlGbFe7/eaLBH/ddKMyfnFccxClGFOlOvPrmjQWVPRUfkkagE8ZlAWckiHK78Cz890+5q7v5trK9mwvL1BIs1RsJVtymuiz0EUjbKLxiu7+zdIfj7D4kiRj3bRaLQljjIaDLmuO9Uq74BXDV4/LFPccoSlvT1pEwsyt/GZxPz4ZO5FDRle3A1oftqysyJgbESu2xeiLO79Kpyg7junRjX1ndC5jQsJ2aRMs1Yt8aBktmUWhwlj9a+Yq8RjhccPP2r94Ku0Viu8vtM9Iq8Sn3qOLhVZvHNGbVnOoQigMBeHYX4s6Vy0RaCPo2ptO53dWIIiULxwnd4ktv/Mevx6kxtutvzJ85q5Cr+xKmc2gEugMrOIaFRixqCkHCQT/vEZoaWxLvzrAWlch7WAEDy32RsUtu+vmyLr9ylTFywFsoiVR26Jwa8R128F/PxYNfkIrDi+4MMkbhHsfzNdl03OtxfDn1XNT4+PjybNCNtk+s8EdW/+RZGCF1Ug0NiSO4pO45pZNjOLyhZR7Fhap3PIhSVYy8D4nfRZkfU5hTUZSEum5wQYZMf3yTWmxOrcZw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(56012099006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gJDdXdEFzB8zeCMZ/BHkBFL+QMLwkj0BfJsU5W5eFCO3AGoBv62VNgBMcreE1795WlAuguc+Od9EpuJIN23EpLiW158kdFiO6xblkiSBlHEd4x/HM5MD8yCC/UWDgzxl2PtMfR1h5kbcHupkp7FMbKKrMzdyCD1Y9J6gu+oCBGECEC3WtC1qKt8W3qCgKBzDZCyd04vOdH1vxGiViSHwSJwhdpIEQYYnNAP8pj3Pv3aXYLMkWeNo9GTSPYf5mOfXSLpi1FWfX2/lvlf1+uYMWBeI6DkvvBIh7r90p1Ds0cW5yIhPj02BAo8V9pW7vX2AVc8FBAo7/PWG+PEaG8jc4j0v8CFzmZDvB745S0BTtziWwj19t80/0guH2ezZTtN9di8HcXEjHiqAGkV94r/noELIkmkHZnQ0L/kZF9nmSzFptzOcXBRzkE1VJz0NpeQz
X-Exchange-RoutingPolicyChecked: j2+C60y7PWPR+PaUoeVTqwRAE4Sw8aGX0jUntlUwf8t753H9up32BOVPaat7izEiQop6gPdI27oHTWHTPUTDn66b3xylMPJxKGuOtMQdZOv60VPEORlaJNVvojkW4fy2TI1k8NtL3x96K1eZo6+Ql1i7bA1sAupt4+B6DP+Uuz4BpvwduGctUNeur/yU/YNEXpXMyZM/YX71pMiRTsm3aAowFitHeGB/HtCYZzSXRd8zR9zN+wUZHyqccGOOST+MEEeILesOuESPAKpkPFjul3+Eb2/scnyJcSOYXQ8HE7kHQw3nUSxGSa8Tz6L4SV0/qsYWhjqrkrN887TcwIZQ+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 05:51:08.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f0cf37-d51d-4c99-2c9e-08ded27dc14b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0OCBTYWx0ZWRfX104CIF2B3fS+
 ZbZtfQ0h8z3F/vfpCoaCLWnkt607qUdgr5ZHMM9DEmbWZUD7d97gvdRPLBPZL6pqsGEbNhDSpTZ
 DW1lOvyl1dXMZBmXYvAAz1i3RxWLD3VfHH77L1tF3FC4acM0aAUtug5AbPC/+f9VmdWy454p9uR
 NvEDr4F0YpjLx1k1WX34S0gL5cWNzSl4o6eyQyhztctGFuduIcjh1ih4I3gJ0VxsJhS2IbgznLU
 sFAjo7qVB1socxxiB+9rjoDjh3RXXA6MkrguMA3WK4H9hhvHm3B4wuFIQnq3cDowQql1eHcTtwp
 TwMDinVyQ4VuGfoSRVRUDEWfM/ypEaS+MX77v+7whv99luNh3o4Vr4QXg9qWQEe6FJvf+Lyvmme
 LTw2p7wXbFDNhtqAB+H4tQ9alOIOgU3xahpsgnS81o8wdoMIgHUKo+1iCO+pgI1x5KnNyASB1Sq
 xgYneSPxhoNAIOq5NNw==
X-Proofpoint-ORIG-GUID: eilCnC2guMi-f9bP9taZy6qEtm_U0mgw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0OCBTYWx0ZWRfX9yCLn6CI7aBQ
 jN33xoTFNxCy2BIfT6JiqAIoVVdtU4WaojD+zUfnNAepveJl+lg4HFoqcZXg5WqhpZrRZWuNWqE
 9GlqOjCmiPrqx2DQEcq9zc5Hs/jQi2o=
X-Authority-Analysis: v=2.4 cv=RMCD2Yi+ c=1 sm=1 tr=0 ts=6a3cc1d2 cx=c_pps
 a=KmUIp0grITFNz0c0ipdWMg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=P-IC7800AAAA:8
 a=sozttTNsAAAA:8 a=k8V_TLQ5nVnUrP81DDQA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: eilCnC2guMi-f9bP9taZy6qEtm_U0mgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250048
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

On Wed, 24 Jun 2026 09:44:40 +0200, Richard Genoud (TI) <richard.genoud@bootlin.com> wrote:
> [...]
> 
> BEWARE: This series is based on v2026.04 + AM62 LPM series:
> https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/
> 
> It needs lpm_memory_regions described in DTS:
> https://lore.kernel.org/lkml/20260427160326.370415-1-richard.genoud@bootlin.com/

Hi Richard,

The series doesn't apply cleanly on next, could you rebase and resend.

Thanks

-- 
Anshul Dalal <anshuld@ti.com>
