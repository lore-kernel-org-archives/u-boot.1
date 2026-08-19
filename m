Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C713C5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FA6380D9C;
	Wed, 19 Aug 2026 13:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_xkLBX0lafi; Wed, 19 Aug 2026 13:42:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146927;
	bh=uygAMLjIBkXQ/RmkVKw/GCpWGNd4EKMunQRbYSl10AI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sR1eSvxuTUn8RXJP8gn8Zdxr1Hb41RjAyQCTJ4PvKSCdPn740kWbIeFNwB4LPZocz
	 BzwxQvGENwyL42YE+NUm4m3UPiWs3zA5ziLGyoXgiNFtY3Yx949mapJ9hUhRNqSs6v
	 P8ll0u6GtSvZSzT98m4hv599f9+VXXYZ1CZiP0sN9zL2XXEgYbsuFBzLS8IasIDrSs
	 8rBWH6/qtvw+NxbfcYTwnQTrJB7cWYZWd/6B52RGP2Yhc+MTD24/77uhsE3un+E4Rk
	 nLXxcQbRbPtLV6XE42vd4Aor4GXNB4kmb2A0csc+VUw2uNDMyYbAsLlu0Zf2E7iTwt
	 0wrV4bc8+qmMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 271AE80DC9;
	Wed, 19 Aug 2026 13:42:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12E3F334
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04B4840077
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iodxC2TDtA9g for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 10:19:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=T85t12oJ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=PMjlkPFK
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEDEF40042
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:32 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67JA67jf2020592;
 Wed, 19 Aug 2026 05:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=uygAMLjIBkXQ/RmkVKw/GCpWGNd4EKMunQRbYSl10
 AI=; b=T85t12oJG5a5zBEwWsUpiie5+Nehr4J8Sm/2c+v9Cq3KabLqKa5mFlJjw
 4Sz9RfmNcZ9akwwiu6VgbWSYQopGYOwkJVdtfhVSL+Kj7KAFvXGPyKksT1x/AGQd
 6ljL4MwJZydj0tXyy7fD71O9kSrZ5ojX7iuoG+VZOWmYonZjNqPz4yEYZnFQCgd9
 EfxQdsDpu8qXR6AyaJCfoiF/Xs24FjNvnl6X1Dam6ivuXdCAdj1N2u4Fe0pI7qUH
 P12QouUqhkN0PyDATbeaCj65wyTqzkz1jzTf0u2MFjbUfm6xHXf4XQtqQ1dm6gTN
 /wiDvnIzOOIiESlNNuGXNWzkdf2Bg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by m0380145.ppops.net (PPS) with ESMTPS id 4g4yejkua7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 05:19:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFxHmXbpFkt07c3YgauKcLl/WGaOSvkmLoX8Fqonaue41VONUTbhrN9U/OGmv10jG/gTpEN41Ogb7i0/GEQanEin0MvJpFcRqiKGpFnuaKFAA/3YBiTd8LzQq9hksv7668N1nq2HdYjd7zejDdsXJZ+lxbM4xLVO0NBoJn9BvwixiaYu/kdrQlpT4n6vyHbjjIe6QzhRdA6fftsnAWDeBNQX7smd+4d3/P7V6JZ0KuKRgRkv+eJxVNpk3o/R5OWt7d9HOtzv/OMTYyDgRstmrsNxO2Yx9GkmDnGIDqCj7eXIS1yad2swIsmX0pf5u2iT/ddzNdpEW1TR3aGbD2aTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uygAMLjIBkXQ/RmkVKw/GCpWGNd4EKMunQRbYSl10AI=;
 b=pd4kjnxMlsyiIzNFqkne7srEB2hqNKiZCi8+cwHLpniFoPctpy/aPVOh0ChdVIwMg5rvmNrPsbqxr1EtBYp5TfURa87QWF3gWwzRCP8sko3aP2eJH9vHDWrt7tn33+t7TAl4KkdmkZq+atMMRnxfaNrCNBRyktEKyY4D24CXTloqvDtTGvU1wA0hLPo021H5icLVXWnrbKZ8oY3OUzLznx+Fd4OtLYIdkNaM5sn6q4TlMENsPLUEZ+6F1GrRT3KoAPWZwSnkyocYwsbPe5dUjRrzSY0U69yWO6gLgesTfue0fwqGeAkflKy/I2kFgbeEKJ50cP4ynX+cYwNZ0Tkisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uygAMLjIBkXQ/RmkVKw/GCpWGNd4EKMunQRbYSl10AI=;
 b=PMjlkPFKOUJCq1BW6lKDyBNjjN6DkQ1ImL6g2iUN7CvrwJUkN2+tukdCy0BS91+7N5WYwBHSDdB9KgMGj5Zkvay9vsWiiuoIV52OUkBSLOxYvTVMpEaro65F0PmqFMJdwbXD8j8Yz4lm1hFHj28QZtwIGYbwMHO2MCLgP/ILSks=
Received: from BN9PR03CA0340.namprd03.prod.outlook.com (2603:10b6:408:f6::15)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:19:27 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::38) by BN9PR03CA0340.outlook.office365.com
 (2603:10b6:408:f6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 10:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 10:19:26 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:19:24 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:19:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 05:19:24 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67JAJCip2149110;
 Wed, 19 Aug 2026 05:19:23 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v3 3/3] doc: ti: document A Core no-SPL boot mode for J784S4
 EVM
Date: Wed, 19 Aug 2026 15:49:10 +0530
Message-ID: <20260819101910.39192-4-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819101910.39192-1-g-praveen@ti.com>
References: <20260819101910.39192-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SA2PR10MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: 61238948-ed39-43a4-fbc7-08defddb58dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: abGdTBf+NCsO0RHh7vWr9MIOqhRVac4dj6pxL34XVKATsaPx+v+OKyg+bHhXCpwx1qOXxWW7VP1BObcr+PSvaIYr4Dwn4/ZPFzXN1qHeecWjEXESKgu6odkWXsZg/rBM6SlMjdLxTCn6+B4b61lQc1c7IlIP3tKGeio5ycD8An8Q6YJwFrFWSFV5//bllL1xn8RiGe5eLhqTN3M90j1oxd2ebn12UhgVQo5MXXggbIBb9+uLR4w9K11MGu1SHWqdcFkhEUMkFwASERpkaP1EoTfz7ZZQRQCYcs0thw9YzZo4YcMfm2eK92EHVInMaJ/dAn2DXNbrP8TitFQrchpEHAP+VsE+RAkTypD07sUp8Ondme9J9CyLVy2OAZW7oPjt5Nm5jvOuwmvAczcfMHA9djMJjon/+x9xpW9kM8q2EEdjRjLt5bfj5i9w4lcmem1b+htxneTANiiglKoI8PUx8dx/RurHZ88kNoWny89V3jpwOj/1B2K+k2dYkkIXgARRuPC8nDzlCWBjWeL+MlNNMssr5qYw1MpnIN/vcZ9oWFNjB8Z+/5JjwboHHefcrfLw9lB8BNk6CYFtQONOKWfdniq7S5Rt0EYoEhS3lWxcOhC0tieeGBAykrHyKG0HTduLrQwjQZZ7sHK9LJ2zQLN98LiIsjjnL+5mpr0VDVMZBGPFMeAJeai6moxwiAmKhn6wJGTamGlpjQ1GE0VWlRiVSw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1fWQ6vcr07hqxL59L6aLnr/AE2vpBN+Z+xW5nX2CNyYpaT27gg7mrTBHOGhrwrZuj4pDOZe5xRZrN2DVEOt6ylkB6iCQz3L+SsIEsnbgSMB5ykUS8KawQSo2Ib6LXnb5ay7DVzI0szIWF6qrsV5bUjh498aujt98kwvOfXArwJXsR35BPAWAOW1Q8MixqBkKH9Sx1hBDIre8AAAeEXcq7N07eyvHeI1TI0p9K4QKENeLeSkyghuJg+pWbQAO1Dpfkixxblv0opY5jxWkWqSZKJaA10sJXccUUAcETv6Yk2xtWghI7cReU0x/i65i87MmN0ZWYcVtfYyFKsgytO9bef2PB4DeEtjk2q3NJ5xmiVBlDI/YRsurf1Tg/3zu/n3YAK5s/0xnE6UwjGAohmcUYYoxUWfavF/jMjuvi380n2DIZE2HvTwc3/6gIc0pbsrj
X-Exchange-RoutingPolicyChecked: Bi84esvZpUjROQSYSxTQov4Esm1SZLtbw6vIqG7ohuNYlQazlfnJCNqR5lXw06D1b9+xQJtEjgIDT1oeb0J/OGDEpb7yWy/CoB+gaVCFtIq+JHUwJgbr75hw1Jy6TILy2zUjS0SqkAtgoE+H2j4b04K4tjpRTq18nBkDQiYaRNQwmCAbfazRuAWQovWBXgRAWuWYS1ANfz6N37kC7E+PyiefyJ0Y+Jy3S/WUUEpu4+hB8tOeYcfJzqCnNTGPsrR/nol5+HX/eRRgV1ozQO3UNySe9zFr01sp0dftaCrrAnJzKKTkTJBC1+SuXavAXIq7vVREHXg+KfiOVxfflJ7ssA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:19:26.2570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61238948-ed39-43a4-fbc7-08defddb58dc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3OSBTYWx0ZWRfX4pQr1Vbc99sq
 +3UGFIApu+ThPI7bto92SOWAtgKpN2ItcVmXWKEbwLbNineK/DGbwXm0JTBRoTWOZzePEMu3p46
 fq5OCm3lYMD0IDFHlZfvlzdMfzte4UQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3OSBTYWx0ZWRfX2ajOxAZiOR3P
 ovHarIr+qFxKbmm6h4zktalcIQ3v36jF2c0pRVVRDUlgyH9oM67tqbaB9BUw/JDzD0+G/bOoXQv
 mKZmnPPvshcD7N0EXN4/yoTyRSUMrojE3QcqPqmjhrGQ2n/9kT08GtIw689MCVc5/hdweoiduzB
 HIavzmbXqV27nuIA2ibzBxsfcfY+hsUaDKd34gypkR5izrqjGRCHq1UYl1lIdbrgeaQqQE3qby5
 LWIWswZNIK/3LzP4jYvzP1ajRkYmXdGOakgRxqWYQ1LO32mgHIv4WZVCQBRzUwy/aJQnCeBU3Ws
 vKU/l9oIyhGvoyCX8tubU7mu8XrBXy4pBudcgJGhG8N74m4Oj484MQPtD0kwZxsXPJmHeskJhWo
 09bWgHb4bAUeRu5rnFKQFDVX9sZDsGsKAfO3NbyovYAGalprtn4ssaAh58KeBxV8JsYqx4rBCWE
 b3RlmF3KVckqLnH6SlA==
X-Authority-Analysis: v=2.4 cv=PbLPQChd c=1 sm=1 tr=0 ts=6a858333 cx=c_pps
 a=eGdyP8VkvOZnUY1FLHxo4w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=tlSJXLxGV86A4UsorCoA:9
X-Proofpoint-GUID: IAanXiGUrW_qIHZIYDzoCA3BpM6pVocO
X-Proofpoint-ORIG-GUID: IAanXiGUrW_qIHZIYDzoCA3BpM6pVocO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190079
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
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

This patch adds user documentation for the A Core no-SPL boot mode
on J784S4 EVM, where R5 SPL directly loads U-Boot proper, bypassing
the A Core SPL stage.

The documentation covers the boot flow, build steps, and usage
instructions for this boot mode using tinospl.bin.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 doc/board/ti/j784s4_evm.rst | 143 ++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab90..cf870066291 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -637,6 +637,149 @@ to the J784S4 endpoint:
 This program copies the boot image to the PCIe endpoint's memory region and
 writes the necessary control words to signal image transfer completion.
 
+A-Core No-SPL Boot Mode
+----------------
+
+A-Core No-SPL Boot Mode on J784S4 platforms is a boot approach that bypasses
+the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
+boot times compared to normal boot while maintaining U-Boot's flexibility for
+kernel loading and system configuration.
+
+**Key differences from Normal Boot:**
+
+* Skips A72 SPL execution
+* U-Boot binary included in tinospl.bin alongside TFA, OP-TEE, and DM
+* U-Boot loads at CONFIG_TEXT_BASE=0x80080000 (A72 SPL's earlier load location)
+
+Boot Flow
+^^^^^^^^^
+
+**Normal boot flow:**
+
+.. code-block::
+
+             | tiboot3.bin |         tispl.bin          | u-boot.img |  Image  |
+             |-------------+----------------------------+------------+---------|
+    R5 Core  |    SPL      |                            |            |         |
+    ---------|       \     |                            |            |         |
+    A72 Core |        ------> TFA -> OP-TEE -> A72 SPL -->  U-Boot  --> Kernel |
+
+**With  A-Core no-SPL boot mode:**
+
+.. code-block::
+
+             | tiboot3.bin |        tinospl.bin          |  Image  |
+             |-------------+-----------------------------+---------|
+    R5 Core  |    SPL      |                             |         |
+    ---------|       \     |                             |         |
+    A72 Core |        ------> TFA -> OP-TEE -> DM -> U-Boot --> Kernel |
+
+Build Process
+^^^^^^^^^^^^^
+
+Enabling A-Core no-SPL boot mode requires re-building U-Boot as follows:
+
+0. Setup environment variables:
+"""""""""""""""""""""""""""""""
+
+Refer to the build procedure above for setting up the environment variables.
+
+1. U-Boot:
+""""""""""
+
+* **1.1 R5:**
+
+.. prompt:: bash $
+
+ # use the no-SPL config fragment for K3 platforms
+ export UBOOT_NOSPL_CFG_FRAGMENTR="k3_r5_nospl.config"
+ export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_NOSPL_CFG_FRAGMENTR}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* **1.2 A72:**
+
+.. prompt:: bash $
+
+ # use the no-SPL config fragment for A72
+ export UBOOT_NOSPL_CFG_FRAGMENTA="k3_a72_nospl.config"
+ export UBOOT_CFG_CORTEXA="${UBOOT_CFG_CORTEXA} ${UBOOT_NOSPL_CFG_FRAGMENTA}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+.. note::
+
+    The ``tinospl.bin`` file is automatically generated by binman during
+    the A72 U-Boot build process. This binary contains TFA, OP-TEE, DM, and
+    the U-Boot binary with its device tree.
+
+Usage
+^^^^^
+
+A-Core No-SPL Boot Mode uses a specialized binary called ``tinospl.bin`` which
+contains all necessary components to boot directly to U-Boot without loading
+the A72 SPL.
+
+**tinospl.bin structure:**
+
+The tinospl.bin is a FIT image containing:
+
+* **ATF (ARM Trusted Firmware)** - loaded at CONFIG_K3_ATF_LOAD_ADDR
+* **OP-TEE** - loaded at CONFIG_K3_OPTEE_LOAD_ADDR
+* **DM (Device Manager)** - loaded at 0x89000000
+* **U-Boot** - loaded at CONFIG_TEXT_BASE (0x80080000)
+* **DTB (Device Tree Blob)** - U-Boot device tree
+
+The R5 SPL requires both ``tiboot3.bin`` and ``tinospl.bin`` to be present
+in the boot partition (first partition) of the MMC device. By default, the SD
+card boot partition is used (``mmcdev=1``). The ``bootpart`` environment variable
+defaults to 1:2, specifying the second partition of the SD card.
+
+To use eMMC instead of SD as the boot media, rebuild the R5 SPL with the
+following diff:
+
+.. code-block:: diff
+
+    diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
+    index 82b9f0741bb..73d59ac425c 100644
+    --- a/board/ti/j784s4/j784s4.env
+    +++ b/board/ti/j784s4/j784s4.env
+    @@ -17,8 +17,8 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+     boot_targets=mmc1 mmc0 usb pxe dhcp
+     boot=mmc
+    -mmcdev=1
+    -bootpart=1:2
+    +mmcdev=0
+    +bootpart=0:2
+     bootdir=/boot
+     rd_spec=-
+
+**List of files required on SD/eMMC for A-Core No-SPL Boot Mode:**
+
+.. list-table::
+   :widths: 10 15 10 25
+   :header-rows: 1
+
+   * - File
+     - Copy path on SD/eMMC
+     - Partition
+     - Description
+
+   * - ``tiboot3.bin``
+     - Boot partition (raw)
+     - 1st partition (FAT32)
+     - R5 SPL binary
+
+   * - ``tinospl.bin``
+     - Boot partition (raw)
+     - 1st partition (FAT32)
+     - Combined binary with TFA, OP-TEE, DM, and U-Boot
+
 Debugging U-Boot
 ----------------
 
-- 
2.34.1

