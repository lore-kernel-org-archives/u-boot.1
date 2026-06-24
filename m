Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6ACCDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC91F849EF;
	Wed, 24 Jun 2026 17:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jtKr0q2u";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lHiouO6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 680C3849EF; Wed, 24 Jun 2026 17:36:08 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9996847C3
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OF2cJd703704; Wed, 24 Jun 2026 10:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=qil6t8aB0XMqe
 Az1HgbTFDvsNBW02OEVgacR1lSLHOM=; b=jtKr0q2uku55VFIFg/nGNX8jxHuDR
 vpznXd7V00pQBhv41nHDnI1lmFfNjE52oLH6WNNB8YOHGTGFSH2Q/I6d+K/eB7tf
 RiCAL8NbJF1BDTW1wHnY7gPziqLNf5y+ce9GdNEPAx8Hr/pB/YSrrVQD21rVKouf
 fzNteex+qu7lBsoOL7rWMFHv7U9B0p57uEIzb0yoEi+yBKclIr79k+sSgqODYpsN
 54FHAOy9XHcv4HfPj/l3R2BAGqtd0TMDTCVlK+Sr6LcuhbwReUJGrALiP5+S+cKq
 WqJZ65v4K6X8dkRY7hAJZlokae7fCLjh434JPzhvisfS+ybROT4x1yR/w==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f0e5m1jmv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 10:35:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uISwt8rO/3AkqD3cGa5m6wbxfv14qhikTUpA+W+YDh5LtlXF3S/eA1LMvrYo5h7uez8tZGj5kGlgnznRPqUI2DBVusrchpNQ/dJR15Ip18TPc2LvdlqHGaBfP0sUNTRcvEgOMZSBOPDk55Opk4ifTg3L2qJYAwrCG1xoUV3JlNYL+Dqsq4bKwQgLg247pVvvwQgdBsOsrSZtYggSz+YGyDO/D2vr7OSnkq2CaNVzSErN6nm3t1LNOBVihr5CoZLLDRLiS7ewj4ofxLrCe7kKrY5HHl2qS+LBa/XODBWXBWhsHj++pA5PFnY0B0LQ6chGv3kS4Wk96Ojz4E20HE5lFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qil6t8aB0XMqeAz1HgbTFDvsNBW02OEVgacR1lSLHOM=;
 b=tcQuwfS4WMnT0W17AJRcjLvoXLz30lP+UY3ddcXxG6/YF+smbXgeks9oAzTwuGpYN5j+LkN+aW6sT2eo3hkoIlI24bmKoy8/es8RQACy2rPmpMEDqhyjcvOXhc6GQ+CkAfub7VQbNx/GWVcEPiaklQnQROdqPm0jnmPOXzVIRDkqA/1oxfgpwzdvDOq/rYu5TeaUN1CinV3gt38myvqTuqhchlsV0jTxkHfWYOgw/GAi5V4wbqJMi+P6SZYDi13tj2/7sZ2/DWrJZUpG1Qn2CU9Uo4pxczgKnGKxPSriehlixw6bZm5NnKukyqmHfYcyCW1yuqnxI9Uju8cAa4aZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qil6t8aB0XMqeAz1HgbTFDvsNBW02OEVgacR1lSLHOM=;
 b=lHiouO6qsJPKjp/rElB0jYt9MIiqA6s/FAAyEyiCoIC4PDVeYTlK9pS7hE0Oi4x7aVS9x75xeqUtYM7kzVGHZR2NzK9f0o5VqflXpZne0EZCNK0kE7LfP7W186UX+6NBCy88nz6WHr2xNLsxIqegVY2+o5PH9A9ZN5Bg2YlreO0=
Received: from BY5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:1e0::27)
 by DS7PR10MB5183.namprd10.prod.outlook.com (2603:10b6:5:3a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 15:35:56 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::39) by BY5PR03CA0017.outlook.office365.com
 (2603:10b6:a03:1e0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 15:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 15:35:54 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 10:35:13 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 10:35:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 10:35:13 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OFZDsW725342;
 Wed, 24 Jun 2026 10:35:13 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] mach-omap2: am33xx: ddr JEDEC spec fixups
Date: Wed, 24 Jun 2026 10:35:06 -0500
Message-ID: <20260624-335-ddr-cke-delay-v1-0-21d65d40a83f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACv5O2oC/22NywrCMBBFf6XM2pE8LDGu/A/pomZGO6hNSUqxl
 P67seDO5Tlwz10gcxLOcKoWSDxJltgX0LsKQtf2d0ahwmCUqbUyR7S2RqKE4cFI/Gxn9OSsN9a
 ScwxlNyS+yXtrXprCneQxpnm7mPTX/mr+T23SqNBf+RCUrR2ROo+yD/EFzbquH44AT8KvAAAA
X-Change-ID: 20251028-335-ddr-cke-delay-9d739233d77e
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=bb@ti.com;
 h=from:subject:message-id; bh=TFLljGNrw8lIoDNo/CVprgJ55lrw/0IynV0O93/75Lc=;
 b=owNCWmg5MUFZJlNZW4uqTwAAZ/////7/m/+z+M2l1f/j873//e//f117X3ah5Tl5/pv59X+wA
 RmxpDQAaD1ANAAPUaABpoABoAAAA0ADQGgA000BpkGg9RtQ0HqGQMjRptTxPUiAyGmTTQDIaDRk
 aAZMhkNDTEGQGgZBkaZGmjQAYmgAYT1Gg00A0AZGI0GgDCpQ9IGjQADQGm1P1QDQAAAaGgD1ADa
 mgAGgGgGgPUADQAANPUGj1DQBtJoKKE2iNXJ0VpNtWtIIDzD4FhIQrd45aFuLaCVOqFImKN04hJ
 +gVwQ8mYWJQurkUMopgdjQjc/l42iZ17q5EuNSj6JXiqUh6Fb5yrAGrybTYaCHOaFSLhA9uGLW4
 DD1SKVH5/7GcyCjs0BdXV56IAV0HMc+3ajET+GyGU94xOAXJyuXY58gu8qTHpkSjvzE4EKu9Rd3
 mamkn2pZBA4+B4xhYpOjnkz6YwXJTYqgxR6sj0cRvG0CuLPtCHSGm8lcKwQmyl8i04SA2MprCPx
 KVUqD5lU0AstBAEId2TBNccLLPpQudCM9fJ/J5XciOw/wA+Sm8Jkr1Rl+kElYReUsL9S08GD9YO
 5L2WMrSx0qVYsUInrGMKRkRiEIUS/uGP3ePzENmYSeb1X8uTbCUMx9/ueUsKEGMAYfTrki0HKBL
 SsTlJ/i7kinChILcXVJ4A==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS7PR10MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 1370852c-7baa-42dc-e991-08ded2064792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: TLGVOQ+F2K7SWBC/MkS+Urqa+XnvnNusmzhLEuhWA/MJO188CjllqElg/9JyL8cwIK2umuiJjxKYgf9BcpWRa5vdX7qqRttKhWsfLL4o0ivUIO5+io313ckMLhmT4Cj6MXUTh+ATTyPYKkMoRdBYwaEqI9tL0nPdCteuHA4Bsx5PetMa1vuxs2cdWXEcdNJNxxzukVvMVwYVhn88HzR59K+ge3Ua7SGpfu4Bc8QeWtnSkGCCt/NWu8AE1eKMtuhvYydKn3YdODGbKVN+BxqsYCU1PBQ8USdEwdxAzK/72ZjT7MZZX2sZN1yKCX9PRHOdnlq2COUQKjwl9gJORQaLdjtqN/9EhSX3s1m3LmPa4oMMTn1XGsbZskaYVKr/QZ/xuh5KTpHVYqIkrMEPNdntMdYO4fMoItWoFoC/0Yov39tLTGqxsBPj0tbVbJsOhrlpTOjo6YZhjw1C3FudYjThcB30hgN2EOwVFxt+gQA7aIDMyFOjbdhBVxzIBJhtL0PWOx8mTzmPzZxIi3UwInKwVa8OvIhl8/EOggABPMmtISPr7g8TxgCWpxNvYXJfqlw2a6fKUwdu7dr6px/gP948Xq8BzN1wqPxwWvBKYpGb1i1A9fOMwQ/nB1dDEibonYQoyhng+hHyNezSq6T6h4LuCYCGAwH0jzYnjQ2F9luHw55b34XS53SZAoFgv9u6WpWLU349pe1tfm42wJo6ERqZ6A==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sxXi77Si625r1O1HlVQhKNah/FabJdyDxmV5vBVDlm5hS9Z464STI4s2Abk3BeNyFxCCNA0ARO5dtO6i9b49zqb6LnUi0kgaDcHM5XtdJaa15JcPg38RD9b53+Ckp9U+2BeaU5j1V+t9GqrVgKwGLMefl1A7bVB/wIFo3f7sl69alrioL4ppwl+sUPeQWzZyzrdl+dHz/Pj5ji6ay1GRhWL0pQ0xKdolm3oUEJO8yYHvCP8HIPWeyXSI2RFY01l5Src5y3EQkFfwENt+tWLGvSC5oXgjrMG10m3NRg0gIX2QubaX2c3OHYbmIM54W3guzOTjB2MDDLdRAD1S6LhWswk0yRuJ5aITE1qHKIVvssXa/OF+HJ2fJP8iTBPgKh49TXxOsMAk0T4mbPTKlgNnFP5p6ItyJ8sQOEet5lXhaOLCkZfGuOObQRWLT1orEpSw
X-Exchange-RoutingPolicyChecked: mK8bLJVOY8FanwAG8w+48IUZJsKaoShulfvavgDQ0ap4lXcNR0cbbRcUVcxUUK1CdBAqnyErTxLEYH6vK4nMNVkNbz3FYRf4xtcbGkAuLSYzmxH5gNJoIT2ojYgZWdUWPe9u5WdTbl+TkaDMbm6awg2dEyFRdb8xRwf83uGKjeZpcxixgs0PPwjjsppR905ZQxBMg7x8o/vbQ0hFXXvppMxx2DCG/gLR6/OibzOZ4UzuAao6Td6mswdIHdIKrv3oK2OIad19lIc/vhSqHiKiJ53gvSrJ7LiADjvNQNtcy3J3L+VUvtm6qqtwoNYsuYoKp9vjHuX/fbRrefub21m60A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:35:54.4358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1370852c-7baa-42dc-e991-08ded2064792
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5183
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a3bf95e cx=c_pps
 a=bOzAxYZ/tHfqF28wl7V57Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=lH_lhkfiCbOUVKAuWlUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DcQtu98_2RLqpdp7wKAUsvZzVPJLaFzj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzMSBTYWx0ZWRfX3j2KxiPejqWb
 J9/tc0ja2gUW+izFWGpAasueMN2qBizQrcoaknZYmwOcUGMZKFLnkxP7dCIc4fcju3m3L55eEQe
 n3zBPVR6RTgAAavLELRbVymy06lTDEJ1365yGndvZz4GmB05dwqes44r1q7Lz0Hkrny4jb7tyaO
 CtKuQWD1Dd09lNbcGKYvVKVnapfg4YwFYg4yZKWRUX8GYDvZ1+I4i+XQDn5MKQlietnbNfM8p8M
 xIeJZdFdlPn+rbCvTLkVDkylx5bfzYiX6IKGDoBGtQHHvi2DhoaRvxr/TAQvnDH3KFHJX/yzxzo
 A4wUkOBDXarNK8O0yPwpS6i9nBX7IUFn8LsfaWwdVkT/XgS1WtS8Xv9KEUqIwY3xzaKgockIO9H
 qNjnUpDKd5MT95Ts7qAe5qKa++1nVw==
X-Proofpoint-ORIG-GUID: DcQtu98_2RLqpdp7wKAUsvZzVPJLaFzj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzMSBTYWx0ZWRfX3S1MC5bYsPs1
 DA83Odc57O36CDcs3W67uG95Zi8VOGgNbcz7WbDrF0Dc4GVpVjF2ZxVSUUO5s7VjJRDmgj9lBrH
 6uIC53oGxN9HvsT2EroE7RgeZwxjYXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240131
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

Hello Everyone.

Someone figured out that we do not wait long enough for the DDR chip to 
be ready during initializing. During that debug it was also discovered 
we don't handle warm resets correctly. These 2 patches should fix this.

I don't have a scope fast enough to prove these patches have fixed the 
reported issues but I am boot testing (cold and warm resets) with a BBB 
at my desk which seems to be OK with these applied.

With how old these platforms are I doubt we will see any issue on our 
current devices and probably need a different DDR part to see any 
stability improvements but these should help stabilize board wakeups 
with different DDR parts. 

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      arm: mach-omap2: am33xx: ddr: ensure proper reset->cke delay
      arm: mach-omap2: am33xx: check VTP before reinitalizing

 arch/arm/mach-omap2/am33xx/ddr.c   |  2 +-
 arch/arm/mach-omap2/am33xx/emif4.c | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)
---
base-commit: fcda974e36033ad5331a9b4a4a551af4e141ad7d
change-id: 20251028-335-ddr-cke-delay-9d739233d77e

Best regards,
--  
Bryan Brattlof <bb@ti.com>

