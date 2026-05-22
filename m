Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F21ECD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 02:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A22848F3;
	Fri, 22 May 2026 04:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="VfxkZdBK";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="WiAfF/EN";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="GgZXp7B+";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="rFjfyIbQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9F2847B0; Fri, 22 May 2026 03:23:37 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4845A846CA
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 03:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64LKjWkH922298
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:23:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=Q6qo4MQu2rujdgm1tEP3D2mQc
 MTyjLeVfTadMdBLZII=; b=VfxkZdBKa9QxyQczeCOoZtR0y9LYi1SBZobhwcOq0
 A32zPlmksfo18OoNMXQLTMcpHjnt4VjB5SSsUSCYfZL9/Vh1varIuLB40stpPJpy
 pY0CzjMrZCKFRdKhWDXX38gaI48oxgA5TrcHgukeXTz8hrFWnEFCMnDhfZ+Wa4Fw
 TjaBbp18jOEDL29dv7x0gW1QkBjNnrQ8E8OcQvDbXxFT8Sjd/qDx0gSsKTVeYmyl
 4gEOU13J162mSi0AbfirjYt8b3tFX7IaJ7HcYyocMfCw3mT6Pxz37B//CK3y4lLJ
 zH2SmHCwtfHP5pyqIc3G6tB3h69kwGHDUfox6HWZ7gBgA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by m0482517.ppops.net (PPS) with ESMTPS id 4ea9cahjvf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIYt7PbesU4kp7CAt9/uw/8d2iUHRaKdrVoEK0dzkY0TVRN9CjnotHCbyKH/Q9hB4sleCyT/eUaY/htditfketVlUYG+dmYCdGPw73Xv/TmCroN13dkI6Y3rQ9GG+T5ZDQnCFaV05E4kyQEOveQROB5FViiGwFT6GgWQnXMHysUnTLjJZ3Wy0SWjfGshQfzcE9PfZOEY9gHGTt7tHIcHEV4W2j877nadcQGDa2vpMZL/ju065UgJ9R0yngfMVor8Gq6QfgFbQsKFLykMxEL/CA0P0SyDid96fTtUnIwLtKy5XdfWSczUSN4HjqX1ajwvP9ZkjrrZ6rhSJQ5Cjj3BgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6qo4MQu2rujdgm1tEP3D2mQcMTyjLeVfTadMdBLZII=;
 b=MqzYE/98d0ZKmdXxNexehIKuz78Lvz4QOILcwGnuAmcelkhixi/PT2XAzbL8+PzWsm8DXjXLzLDsjnvG1sEYoScUgzniobXwZ7BpSCsFmOzsq2IwtdlsqQfzYra4BEtaivXdMhgZcdmuHTtCtaUUwzgMdwZ+DBmuyQs48Yu15D2ChIeW3cqFuRu+Kyqg3k2TQ5OpkhwwtVCIeekYneoxDA1pJrzVlmI/JjSqv3d8ip1cYoqzWC+yO0HzBQ503wc66HAKwNGEq6zLhgiaHpk3xQIZ/BlXDE0Ml1KPqjBu1xg0EIkHyJyX5jrM0uszKwnapWB7H6T1Z+x2wG0vr7LMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6qo4MQu2rujdgm1tEP3D2mQcMTyjLeVfTadMdBLZII=;
 b=WiAfF/ENFZASAObd1HLv+uGn8dTp4a2cgXBT0MN+bEntUmThhwfYDe5oy7C4inE6Kh2fn0RN1MvgwCbBJ0wEav86Fnfz8ZvwB6/aIlvBLXx0qdVM3fwzYvztjL0sYfgz3d+e0/LvAgBIVh9ZSWrQxfWYzSmU2YaMSb3HiXbN4vI=
Received: from BY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:a03:167::33)
 by DM6PR16MB3912.namprd16.prod.outlook.com (2603:10b6:5:2b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 01:23:26 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::d6) by BY5PR17CA0056.outlook.office365.com
 (2603:10b6:a03:167::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 01:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Fri, 22 May 2026 01:23:26 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M0eevB2947564
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=Q6qo4MQ
 u2rujdgm1tEP3D2mQcMTyjLeVfTadMdBLZII=; b=GgZXp7B+YM3lD7U8GWAkRdC
 mJO9Rcvx5DjZbrTGF720HKjkoS/Kt2T6+u/nJq0vpq6APJebT02K+hFeG98+WFZe
 0yaKDlL29m/Fg74BZUp5juHNjewpU3l1q5Vo2jyDJjenu4ceqAtMR3BuF5/bKwPn
 d7mlx/mcgjnxEhcRkZC0F3cViNe5Gkhp4SVqkTkEulKisgbJ7VY5jvMVXiUADFJ2
 wITuwGLMdVK0qBmeJAE6+Owb7HP2m6i+O9HPSVXNpVyx7iCrlQ3FMs2xyYO6/aeu
 Wq9ZxlLiwY9buD6ruETnR79lIqRWZMyXL1KiDmkCapuf4VgIL3s6Ob2B0YOKvWg=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=Q6qo4MQu2rujdgm1tEP3D2mQcMTyjLe
 VfTadMdBLZII=; b=rFjfyIbQO/OBU/B3LI1bAahPQ4vpTTPa+PK6uhy2pp2H7lr
 IGqfMTQze+XmNU4DJfgfGau1pRwz6caUM+9UP7CwkUtIIKNdz+PpvhFvWzbIuoaN
 +m9ZRxwiUzucFt2fFvN4ajYa6BAUH4F7KMOSX1HhsH5/MVbAZijNtOsFnlFuKevX
 EWIkL4SxNnLQV8Bug6HJxPVXdmfUbG+dXp8ag32U2cjou3wxiQ1l8O+hMg63XkCx
 a6xt7w3AYdtzOapFSIffXs5FjTf9BVVF3i1MnUa23XGewbSdQhpJlvWTHVpqEDlw
 MVfzxG7rRDZtTxMYRcxM5bO8FcmBvwx8ypUngMQ==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eacthr11t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:24 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id QEbjwtR1aFYU6QEbkwS84Q; Fri, 22 May 2026 01:23:24 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: QEbjwtR1aFYU6QEbkwS84Q
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 0/4] reset: add board reset type
Date: Thu, 21 May 2026 18:23:08 -0700
Message-ID: <20260522012312.860026-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220011
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DM6PR16MB3912:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 66efeec5-6f9d-414b-8c85-08deb7a0b93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|3023799007|18002099003|11063799006|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0JlxmEUGYGz1ncLhVh4z3V0nrLSGhp4VVjd/lKYx3Afd1LWcPqOzIk5l0zDR5AXg7odg6Wxwax15Ac+8AeNQXWaLXNnXBZOUMNDLWys4wmC7ixqcmoEtc5ZXs4kZ3FdPn7nmoc3d1VWk2peWBircpbZSWSE4jQ3VauKnvMcazdnaXTcr8scnKwSc9NvFYo+Sl5ILtXOcF+2lT8wiDc8y74yJFWPTGWoQrxue+sUt/vkXszU9QMRyTYy0l/H/cJfOBu3N+T2vr0k6GZDpyyjAxWqCOnt/4rGtw8ZlXUlnZrIevRxXVjvVA7Q/dAHW/QAn2LZp0NDwH6AIsUWAe8YjSZawdammhhgMb9lWfZuqHlzvEz4RYZL/xdoyN5Xax/TpUywnXl6VVJm9tMMaO1xxCPC2qfLvkR8MwnwVdIM+2Hh5ZowqhJfCzJx8wapFsmyaxlGfUgVlbEykuCwANAnCy2Cm9zXYWaJnxmpFM3cmncxgVvWZBdPNxq5jA4jie1bneLNC4bmuOxGhFbxckZuqugP3ZiXhnX9eyLbbnnvJrzj5J9//i3u+7PIBUdV7m2HccTEQpfK4sDeWvMQoreGSSrc13wF97Qfd18dg5Tb7Jk5P6sRZy8tO1+uBthj8ZwP9dW8tYKkQ9sKjPSCYjDArgjqV/l1yIlenOZ/oJEZNQ9z39iKtYxQqee4ICh3oJLM8QkB6TDHK23RnF+3YdDYxBq+WZkmnGBDRH2M7eBpIJ/M=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(3023799007)(18002099003)(11063799006)(56012099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ByZW5dqbxCj97Yjgos+eOdowcvLqNwscfFwopA+2QUSsVFHrFOek2aURhPW1V0M1z17j13ov3ZwZaj98gZTQZUWFnAdLsmT6xQeWNyxDeCDSfdgPeXJJhTgwwc67I0HHi4kMoWBCCBIaCcNKEc1NCy7Y9yhOJYJ79pvN6URVUFNxNMhf9pogBTipMJ8YyHI4IgJtnylbzidXTLsxXkNRPtzhPn29x21cHGASGHxpyQoc7nn5rOwo+SNvbrq7PbQ0n8ylqIazT62OS4tjtpRkVVbKO+qO0E4CQzOPxu/xq4dNedUa7wRaSPw8COkbFdpu6KNxNjGkPZOJ9REpiC2kodlLsCW2B4dS52I698eOr+3ee95D6oQaNxYdx1hibatDGKxpNeuR39TsgA1TOInOMj+qYUgFbqPbJX6y+NWhM0/RWix7H1GENH+OGLfRB+gp
X-Exchange-RoutingPolicyChecked: f/cV6cXIHQ8lr992MakDhSna+fvExYU+Yh2hfDdfQzjC1XRupL/tgmD2+3KILMYfwNf/yo+UF87F8XlUS1MsEVYnrqCMeEU4q5KPALSvOV+ft/FCC2C/CEMb9wNb85X3tISSy8ZilqkwHRnZHtcAOb1vb9TvH1P/p85W0gdoOIwZp+GmbS3zAmrUhVtYnan/kIYjgu8Xm/QN4G//IXbN9bXWUzD333YASwo9yX+9s9Vn8YAwYvbNQoEEtGpdNmf6ytr9LqnhgqqNQaNFRcHMBzf5l1t+mAhK0xq5pBYKIIPpWaIRghRpbKN6aBaZgzJlneYZifyapSRghIYhK3LMnQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1pC4ej6zNUeKYErSfxRuDmHH2vxAL/aYCpp01f5SbQDHwpgBP16lo+fRG0c2FgtlazCofXqMfbWmdHtw0jXt1YsSvP2ldkxjtIQay+IMQcR4dAGbLZFTUa+5RCa/VXMuXMmwGuJgBsrevT9DJdRbMXBU4NiQOhY5x2ubGaGmh1rVoRbMqGjWvbgOZw/2cTAt6Fr6BjDDinLR2sezrjLUoOe9X4Q9rx8+tVE7aPmWejOIug41hrUAoeGSDiO8Zwva0VeYbGgvhfu8/T8yJRxFcTu5g6Cg1v3OVo5/y66ZlZHM8UIR2ZCaE3CRMJtucAN9M5G1EMZxWw7RWuoO0io4CN6QKClE2JHDnsmfOcal8mrn+vRL4TOf5DrKvls32NCPmzRTu/Tl7o2wUvMm1gjx9Sa9FRItpB9Lu0PJuciFMHaZM4zvPmZ4tYsSCkkrAzuK98g0z2QVmPoULvL8bD5IQeClllTmZmHVwsnqrTYVSNIkGT+0Dr7o2pM2+Maju6Sxd8taLwjUlJG+2brGBLhy7jzvX3JVdVwV1VMV87EAp3G4824zjWMmYRlA7TeOsYlHXV7EW5i9wO1YEaeebUA59ABUg6W2Fo/sNYhfA3gO4WLSwwcnLdC1kBGPke3YkWhjkFfEpGuU7hoVaMIFbVk1pw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 01:23:26.1227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66efeec5-6f9d-414b-8c85-08deb7a0b93a
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3912
X-Proofpoint-GUID: sFDmkuEKqwTlr_yJ_pNxFVuKYIeU0Khb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAxMSBTYWx0ZWRfX2uWMf9BSNdJl
 6qMW9QODltQ5Op1LFgChqIvOcY38OSulfMNCD+JMeHN3IOz0KhmkaePOc+Z6Rwl1GrPogfp3Slu
 SicVGy7pucKdzVLaJvbGvnpDmLrIxkrLUUTou71X1U3RWyLyXZ8hM/FuPliFD/ANUNCWao/5j/g
 LfYiXNs31eRB3b3rVK4eerNaFe36wS5Nwm0D/th26x3FdAOidin2hXBFJzmLR6S6kPGMYhyqVb9
 MGlagOEfL9FQbYK84ARjxc1ZVj6rSJHbwZ5NB634sKhowt29+K1rcyKyV6WO+iJ+Gkvm/vYbyUE
 C5u7lYunV8lDUrqY8tTaCS57HAZ9gKvOr9ZJDiwma4FeWBS0OkfQMzgu0BIt9L2F+EeyHU/v+af
 mVabfYhBO+dIjBLzq3H+fzN+uHqaaXn2u2fyIZpBoW5JT4zCjaG1HUrc8riLHYnypb/PYLtdUWj
 cJgvDryoaT/+6DXSVIw==
X-Proofpoint-ORIG-GUID: sFDmkuEKqwTlr_yJ_pNxFVuKYIeU0Khb
X-Authority-Analysis: v=2.4 cv=B7aJFutM c=1 sm=1 tr=0 ts=6a0fb013 cx=c_pps
 a=YQq2SbcpNRFTj3qt8lmqwA==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=p8gGk65FnIptiktbs4cA:9
 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220011
X-Mailman-Approved-At: Fri, 22 May 2026 04:13:03 +0200
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

This series introduces convenience functionality for prototype boards
where reset is not fully working - for example, where only warm reset is
functional, but cold reset must still be enabled for the production
variant.

Patch 1 allows per-board default reset override.
Patch 2 adds `reset -c` support to explicitly trigger cold reset.
Patch 3 adds reset type printout on the console.
Patch 4 introduces a small fixup for the x86 reset driver.

Denis Mukhin (4):
  reset: allow per-board reset type
  reset: add explicit cold reset support
  reset: print reset type on diagnostic console
  reset: x86: use cpu_hlt() in pch_sysreset_power_off()

 drivers/sysreset/sysreset-uclass.c | 32 ++++++++++++++++++++++++++----
 drivers/sysreset/sysreset_x86.c    |  6 ++++--
 include/sysreset.h                 |  7 +++++++
 3 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.54.0

