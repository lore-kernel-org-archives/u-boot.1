Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F649C624D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 19:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D3FE80E71;
	Tue,  1 Sep 2026 19:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8BQ4QqsbQCV5; Tue,  1 Sep 2026 19:45:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788291922;
	bh=ENT2wPC/GwRGDwwhl9ZLjAw54CWWFvQh4I2gsjiC/HE=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sMickM/PoT/gUyINFo5ccaLUMvNFwH2vkmokndlYklm1RUDLiL7JT7mG08JUzY9Us
	 BWSIZobMUw98/HKKtZLA6Iz/BFw2j0fex1ov8Ne1iRd39VsId2WYFTr5xuUy4BFm8K
	 LqpFPLFm78j/u8CGSvA4J8DV9zZlt/q91JebDR/qCG1qMrOaJxz+/yo7WwXAfo2uSy
	 6cxFi4h/xhp/QT2gXlG1o4Wu3E4+fdvzjrjz75QkZywXiKuH8oLk3LWy/ozNOR32VR
	 CUwXK/Dqvv5C/9LwH/MX9ukD85DzVBgnmrrLy/5nBZOFDKSV607/Nw7KeC0ljEVMXH
	 hi6blFVYZp1Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7810180E52;
	Tue,  1 Sep 2026 19:45:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F137B1DE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D79AE407D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5bzIBRzy41r for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 19:45:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=H+9d0dEd; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=cGpqY+Sk
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBF22407CC
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:45:19 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 681He28c3051141;
 Tue, 1 Sep 2026 14:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=ENT2wPC/GwRGD
 wwhl9ZLjAw54CWWFvQh4I2gsjiC/HE=; b=H+9d0dEdLdp/mealCmPRlJ0nh/chN
 zqAG92lDnKkOaZJtpKDtgukjJUP0CoEnNUhqXQ+Zdq+PI2dSzIypdjTu84Gn+VYF
 BH1U+9C7N8tf/GHqWrljBFvH6aeYINJTEqUG3kwbyoTqAMa7Q8wy/u9DjXo8P67f
 SXbimOhvn8B6lquYGV2YWCafaPbccHOeCobtINkEIG9+FjbAHqO622NYl/kqXvLJ
 MhbR4MOcx5BB9e73Gz/JOJHPFKgpkJqwLcFZ29MWGdkeJKMdk0Mvx17hQ4KaDjFo
 /X7HPZxmJ0SEa3/z9Ow96Kd/A3NfODvFzwccpQMAO3NaPbCYEEbKFpVzQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gdmp2pqxg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 14:45:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU8uB752QP/neYi6eqNoJJQ7GVXS/mZBiSiLCA/li3zaVm4AZVceUdH9wYpXHsNLqt2II43TJrm69vzzhqr43kBtQVGRk3C1737eTuvEhH4vKL16jYadp/bM/tURWZXh8Dv7oV0BWOG++hAz3rcDSdriyVfW3O/XKtHm5iHq4Fl90Q7bVeTKFRn8igmgsuUbtE4Gucmxnve4ieDM3RPMNeAu+lXyxM0z0EC56v6LETeUxgf2MypiRWuBdIs4sh2tl8c6y3cQmaRagEaEzo4y+Dwk3tCW5mDIG6PD9am19inn1wa3R4wHK1A04z0ei3+7vLVLBPIweVfR0EF3S6eJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENT2wPC/GwRGDwwhl9ZLjAw54CWWFvQh4I2gsjiC/HE=;
 b=U/0RbH8lxFDSHNs9UOckkoleO7JHLqzKgPLANCXmnBwDvXmootmqJ+ZHO9q6f/HPhNsecTlC3QZtdLSlPMh0lNm6iE6dItaC0MylzAy1LNCsA5/vy3egFgvYOt1YnqN1UPxEUnpU3iRvAc/dlTRIbtPVtpbev9jlhThUWtwIW38Nt9o8QftqHOWjnMjMv7CHPXdUnYK/oDR4E6RZDsLFeeoNyR53d9az/FKxIw071xcjUCRnlndCO28wo1iECJhkhDRrSFICNCyn7psLxLC1WIjumAjunzQ054zCP64PCBQObisVTzR0FjrAgOeeo8JfCs8mfEVSuY3SnRfxKUPqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENT2wPC/GwRGDwwhl9ZLjAw54CWWFvQh4I2gsjiC/HE=;
 b=cGpqY+Skbm4uUZjRO38w3dx/e406aYysriUt2LVObXhxsCr1SLIvn4NTm6Sx3FPJSkMNZMiNGWnbEmSgnb5Qbh/+uWXV0ZQ5y/alPPptIkiEczNSv0958DcmPOhfqDHyYN7gE6Xe97zDN3bq4DCjsgzpKN9bqNEwyT1GDhsVSRo=
Received: from CH0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:610:119::31)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 19:45:15 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:119:cafe::70) by CH0PR03CA0377.outlook.office365.com
 (2603:10b6:610:119::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:45:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Tue, 1 Sep 2026 19:45:11 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 14:44:19 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 14:44:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 1 Sep 2026 14:44:19 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 681JiJGx3398457;
 Tue, 1 Sep 2026 14:44:19 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] doc: board: ti: openocd tcl script fixes
Date: Tue, 1 Sep 2026 14:44:17 -0500
Message-ID: <20260901-openocd-tcl-fixes-v1-0-bbde8ddfe425@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABIrl2oC/yXMQQqDMBCF4avIrB2IEVvjVcSFjtN2RBLJqAji3
 Zva5cfjfycoR2GFJjsh8i4qwScUeQb06f2bUcZksMY+jDMFhoV9oBFXmvElBys+bV2VFdXOlQO
 kbol8Dylru791Gyam9XcE1/UFrjuNHHUAAAA=
X-Change-ID: 20260901-openocd-tcl-fixes-728535c8993b
To: <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BLAPR10MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: a38e0856-6745-4c0f-25f1-08df08618959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: RrIq/Pa+jU/t7DyJss2wrjns/1P6Y0npOGnlOqQUhetz0BPIJKMAcnge5THQn7mvJcB2iDYSwh8EoH5kz028kCShOJq36bqFKoAPp6y1uTSEwkmZttweB8Xw/+UzV9k03n+bdJ+t/3S13CHSoay/oHFDlQaAZ79e25Mxv6gE77w8AzRB8xPC8RyWAnHqW/WxZGeSMzMQ94Els1EcJYLEzJPIcz48c55o1GVKpTjdP4CLUI8Epw2F06Y2xt5AT4utIEFMLV27DmipwGyO+tL6wnDlmAwLdv07VPG7/NzChB+24iudYhAKNWWDU3QKXUdzuFGWNxhfxKgwRf2Q72BtEpUPBrMrLAZnCAizTbln5SQB2gTxKuGNOIRJuYWEgFz9vLbEztquiCr2f4fBy/vXv/Bwsc2+/1vWHuQOldvRhTnNfLeOieqCKAMFkXARLwcAyX+/2eGDqD0PIye0AiwO00yoXS9yGiH/n773wTTTClGZsw8FZpMgPDkzkkf7FKCZhA+iYDmnbqEyqqMW8ZW9YugUQzYJFappEDvSg6v5xBmkoe543eLvbxafUg9vWAdTqZrbUUjxnetb60z0dFuUnuYFJLa4lBThSW+BalPy4YmmeSYEIeUw4gNf6cx1HZAM0AwHTrGR3e6No7er+Qoc31wfxzgg+Wypn05ISlv8O3nS97y0VRhVSbeblzc4k3DSM0GjJrXWj3E0SPBoYyfP7A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mnljL9UUkIoqt809D4n/Yuz7aqFhcSJEKPaWkjt+S99KAgVnHwl4pxmxztcYZkKpN6+Y5IKO1z3DPI52ZvqeMfp9YkgVufQlLtrZVzOrbC+8rTOre/TbxSrODVlcL+WwwtZx13TEXtmA7ET8s3ljBxLb6FJ0WizAiE3EH3gniJSreBW4UCLnl9BNUAU9Vqolggll+YHBPGM/6UeI1sI60YGRVaeHP6CfOWewiTJ57z2x+O/0ViCCfWciSo8PFCnxSoGUOqlDt+QsT3HOAv2wdBhAMvWp2POMZVYiFMDVBkxZWcQ1vjN5/3DbPLDId4Ojv1NoyV38+81uOPbZhy7hQyLTSVFED7OWt5mqAF5IFZf0whU6Z/l6nZrg4YmlU+sIJ3Swxq2Gm1BXH9vsC0A2gWMLkv9hscVgld6ZX3Izme0UkDXK+n5Gxeqg8MM+bNNL
X-Exchange-RoutingPolicyChecked: yUPQfYkb/zvO0Zjcv73AebGS7HSrgZuIOYAa4Gmz2Js6bHxBplUp+lMfIOobkFzc0PbdXewf5k6vNpaGhCCgkZEsKnj4BpggE5E6AkVFBccL88o7UUuPx6r0/+aFLcf4lHO/uI9sPcx4eQupckwk3gZ1dHCAc8PO2HfxI3kWbIFhC1OvlXH1aQeFkeMgwgIsUQhzLtIO9SNBAIRGDlfMxQJwijsm14cXAGHtlxTsidOWtDdqfLe2fz4jsMtiuG2TpwIK5qDI4fz8efvvO9i+KUAlLiXAt/0LdO8FjqX+0Oe8nc8lxUpUEIxqlhIvyVygYUQP5Xx4IP2/SCBXBbtpEQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:45:11.8166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38e0856-6745-4c0f-25f1-08df08618959
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-GUID: x3IvfuH52YLaSpuB7ra3EmbmsjObIyVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3MyBTYWx0ZWRfXxER7eNHwKNSP
 mqvttxTBAqX2vYuBq8t9LWwLceUfS7dEFZnRxK8cLdrAns+CtfMQe9F08nnJsbkgEUrL+VLjiO9
 9LQMhLLY8n56e9lMVfheq4JI/HHYkVN4bTOlGZayPB/Mw05Ai/bonHG2Q0ZqRkzRqZUN8BHZBy8
 M8rxFT14NXvKGx8C8rE9d8xO7LfFDX/lvz8I9CItPNSvIP3COcpZYnsHEkAdW1CTqNeJ39hLHV7
 raiOrB/Q7/CXm+V4VWmaYTAOGxfT1DseosjwSXR71uq5OsZPRCIumGLAmckAmcKeN8pw6lRDrul
 JFUfVHIVbrEsCiXgMuvxeeYTUroRS9LW7CnwXfaMYBp/m4p1uWhv+m73bfEUYIQopvdPLffVMFz
 8RFwt9AvG5b9SYjJ+RPM7bguTksZ/YmbPEq7GrR1eajhGWwRsDE49/ipHCElq+cU+DdLoTA+XgB
 r9Uvg3IGXVTgWxTOJhw==
X-Proofpoint-ORIG-GUID: x3IvfuH52YLaSpuB7ra3EmbmsjObIyVQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3MyBTYWx0ZWRfX/kN9QSZUQepP
 CF4QGOfP6S1GzlTXCc6M3D0HkohDfNNnQyuFtoD/q6qK3kMRfMLXPRCU3QLLBMAgOyGTasobFAm
 CpFnsl8gFxzUQ+vI0CmXcTTga0rAwX0=
X-Authority-Analysis: v=2.4 cv=QuVuG1yd c=1 sm=1 tr=0 ts=6a972b4d cx=c_pps
 a=zj1Wid/uFNkmIHgSYpofMA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=u4bN1PgiNzp30qKv1yAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010173
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

Hey Everyone!

When adding support for another one of TI's reference boards we noticed 
some of the OpenOCD docs are out of date or missing for a few boards 
which OpenOCD supports.

This small series is a subset of the documentation fixes from the 
AM62L-EVM support patches here[0] with the requested fixes.

Happy Hacking
~Bryan

[0] https://lore.kernel.org/u-boot/20260804-am62lx-v4-0-01746157643d@ti.com/

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      doc: board: ti: am64x: add missing debugging section
      doc: board: ti: correct path to tcl scripts

 doc/board/ti/am6254atl_sk.rst |  2 +-
 doc/board/ti/am62ax_sk.rst    |  2 +-
 doc/board/ti/am62dx_evm.rst   | 11 ++++++-----
 doc/board/ti/am62px_sk.rst    | 12 +++++-------
 doc/board/ti/am62x_sk.rst     |  2 +-
 doc/board/ti/am64x_evm.rst    | 24 ++++++++++++++++++++++++
 doc/board/ti/am65x_evm.rst    |  2 +-
 doc/board/ti/j7200_evm.rst    |  2 +-
 doc/board/ti/j721e_evm.rst    |  2 +-
 doc/board/ti/j722s_evm.rst    |  2 +-
 doc/board/ti/j784s4_evm.rst   |  2 +-
 11 files changed, 43 insertions(+), 20 deletions(-)
---
base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
change-id: 20260901-openocd-tcl-fixes-728535c8993b

Best regards,
--  
Bryan Brattlof <bb@ti.com>

