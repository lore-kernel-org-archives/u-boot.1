Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E7CC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB1884DE3;
	Fri, 17 Jul 2026 00:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="DQFc2dC4";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="YgiM3P95";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="QScCMW4e";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="UeyAKri4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF0D84DE0; Fri, 17 Jul 2026 00:34:29 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8380C84DDB
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GKv9YI3264425
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=l9R
 1nMWvEUGX0Jl01fdiPIWyGw4az2lO5aeHj70aRrQ=; b=DQFc2dC4TTyzNFeWrD1
 N4yTgirfq6mHIAxuFob6uyyxTkPmtj2+NfehqapqhUcb7rCLDAdUZy8+mFU3fFK8
 FUrupRLtl3DgH7Zo73QdIOZDkY4X8fTFGu1BB3mlNm0el3hTgWwBymQVMzhjnZ37
 tz6kAwMpJh+hCeaOIZ233agVaDous4rgUDSlqUd0ERi4tzG7IyPmesTVufNV7/zV
 /CBn6X+qNdaC022+3pEBzGcxAlYXcA9UdCGuXr19EaOHRIRHvsyHUwM4PxDSaXUJ
 icZjdg27FnqROAobWRqZPg39e5QAqmGWSbRN5CrPFkBrHbkK0GZc2Y1/h+JDZySb
 OJA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ff6srrmy6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmlLwMjZJ7V6Gxp3bg4oiK8R5OREbFR44uojQ+qqiXxp5dsJB95ABa/Ex54u9yOLXkIBL5kNNxRhXs/kvLN1HyGPghOM0E9LTxb3QXek7+fd2fGQICnoe/xs7begWBz8hgsKbkb3sk94y54YmV3Gs0gOEefkLsii+/y1/maO7zgaVTaLRy1sExpil3x4wTE73di9XJknuseVKr+SgYS2FE7JpK8RsxWDXw79SemfgFJW0wtOLm80L8npxl7I9c/2O9hPr+W+wY66gpvHsvXqqf5i1bO6qOSOPThdQp1EDz5aO5ASXkWvDYpmo1V01G7wsCd6AVECacGq+aYtlpD6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9R1nMWvEUGX0Jl01fdiPIWyGw4az2lO5aeHj70aRrQ=;
 b=Tbdj2Xi8WyqiBUfjml/r1eYf1i0DMQU4PVrMwkhnwRvVazXJJqRAb3Rn5tyVg9MhUIl/A9/yYlh4kTa60zZUUItbk+Z07UQ2PHObW6zqww4EbB4+ZgGvSSTFMjl/Xq5CTTFUaIhFijRyp8p8R2xi/bOxwD4k9mNVXFssr8aGbTiE1E4b56ZfszJFhojHcjQ9DFosX6pIdKMxNzwHfy78bHgIZeZhQI9ILmVJejCDJBO4PG92ueRICISFAXAyEKwu7WfJvnZb3+KJ/YUlMMmCs47WXb4XJNMTrlde+hHn8rzIvpHIQQjqix8ppiG3yyvMKx/cHECwh0wFQjIhNE2c6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9R1nMWvEUGX0Jl01fdiPIWyGw4az2lO5aeHj70aRrQ=;
 b=YgiM3P95nCaLBZREWjBEH5cjBXIdmU3S/GUVeTdkXAN/FPr5JS6s4I3NAoaAFsKOf+RcAsOuZoPtI8YsPMUP8uywEZJfka8jxwVVH9dGowFxZCISvXUA3EQD1oL8/nxIbWCeViv8YNHbaieoZz958Q+x+6p9DihOOqtlcQkLh9Y=
Received: from PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::9)
 by BLAPR16MB3681.namprd16.prod.outlook.com (2603:10b6:208:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 22:34:22 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:348:cafe::11) by PH8P220CA0025.outlook.office365.com
 (2603:10b6:510:348::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 22:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.3
 via Frontend Transport; Thu, 16 Jul 2026 22:34:20 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwLow2637082
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=l9R1nMWvEUGX0Jl01fdiPIWyGw4az2lO5aeHj70aRrQ=; b=
 QScCMW4eviF1TPRhShxO7JdUNKBGbvMGiftXc/TmsJB7xLFt3YQvIlVXprKJRRR0
 6/T+Pomu89Jt4E+9LDxOoQQZ4KQxyjFlyLdq2V0tkilJ9vOJnyiHZhuTXz++72YS
 fcV0E2y1zjSW8+MbO4l0vZcSil0gAOBZd0ovf3QC2pMJHXWx6MUeZA5CkyNa/7kO
 Kyk+Q//kZa+lkJUIXn9RXfKqr7hZgf3pgMDQJ/ovdW1+GafA00itGzVlbgYybux9
 9BMleBpM3Wettkq+L1A0b7WBQLmGVQJ6jmcucG/tIJOKnqpfdgFmis4M0ACXtPdP
 gZYfZPaSsbKbsBC1Ss22hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=l9R1nMW
 vEUGX0Jl01fdiPIWyGw4az2lO5aeHj70aRrQ=; b=UeyAKri4/mpQ5HLNjvpPqaN
 tvssVSNxxi6Go2o8d1sq2KstsyyeWE2HpCLtOIGwPKRBJakYrpKchrvVRbFodB8E
 0+AF7BLETA2w6CjUgT+1y+zT9572AfqHAopsEfPAopoEUXkTdbFuLs141c8lMEXC
 aQvs3KzE++EFpR9RAigrf/ksDn/+B0n52ogQ8vEJ97oQH+QYPd+RcFwOf86QhGOf
 98Fo50XdFrhEYzIH/f0RFVZx8jlN/bkhJnRaAINMDVPhYOMp4iMim6iBTznQN8wm
 SRYt7BHGVH3yVHEBNMSx599QclibwuHGhtBbcpJX+wKuvg9cr30kKR0GCAz8FaA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fe3euacuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:19 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id kUenwVWE4ERZKkUeowDIBz; Thu, 16 Jul 2026 22:34:19 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUenwVWE4ERZKkUeowDIBz
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 6/7] docs: nvme: Update QEMU command for testing
Date: Thu, 16 Jul 2026 15:34:00 -0700
Message-ID: <20260716223401.378989-7-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
References: <20260716223401.378989-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|BLAPR16MB3681:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7b886f06-7d75-4685-088d-08dee38a6109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: RKQTdA+tq0fGtp3RuVL5GOPXyTMlNHLcVg7mQDqvvIl5DDCGzWSokzOthEIRV/aPSVLNWGMIrZVV0awcUs8B0iHHB6SSqQYVwPtlrdh7m5B2nHX4Vx7T2irb0Wx4ksjtou91FQOPTGbyIqONxE8iz0e6W35mUwlaQVH4ZscG9Az4DDrjUMEUjumhBw8OhqpCrdFFxuu74skf2/MNXDPshTJuZTD9B5A9IxonrJHTVbiU5AB1TeKP2vI5ZpPpr63BZTUFlmojiT1Y0r3hWaF2ar1Ue2W5jaoSLY3CJt37NcEm/FzVamwi8afYxiTGgemyKWlMpxRDXw6wsLxyQ6tQhXiPLkhP5/raGkijtc/xjPQz4+X1wvjCqlU7hVjKdzYKxVqcFk1xCIoV1hPzwL24MDd0sAiHlPGLg7wZarvBtlllJRPSlt9YlZL+7GUt/qSbq1XRcXmVN2JH1008PMpNTHFE5nW/2Go7jEA7A3tWqqUmDj9a3phCwtUGCu9dEJ+3th+x3EGVB+iASzRhsKt+r+qjv/8mGYcKyKlpH+6Q9ON+y1Q4fVta/Ac2Bqbvf+tGbPzkFbIbvoHBFmi1hs0mWa7C59um5BLjhoMTzfh/0vUQsjw1dKCbjPr/OIOr2QoRXo3dTvv5cvIkfrHC0FrSsLzAX1JSEERM8w+lLWWLDIQ=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SHLNsWWlpcH0fL4rIf0qpPjCy7JlY6uiQYRejvIq/AGDeA8ym7Qw8tKmB9eqTLYOPRkordKPCLlrfWyW5WG/V8MPNMrLAJK/4zNJcNYLSjm16lIAa6lgqcdbtvcnZVdFz5TGXx1ne+mpwpk37GoBJN+lJGGE8W3lTwu0qpnS8wetgRcAQ/BwujQM5m/NAaqlP/JiIUD8a3gUFL6lPm6AuedPNrIw05Z5RD7XMLsoxacXQi2DDFqguE017UJpIKZhQP3jXyL3lMG9QuZlzn09Dty49PlfArjvkwvxBhbQ6sEg+TmzpcKQXbJ/4xQK6zTPBhNUAUgTkziiXj3qNBE4KipgPgienRwBD0/WUF7MhSx9LOWSHshIg0Tx27S7N/bli9D5/fwuvRqdOG2xNcgxRKQzdQnz8Aybd5CHaE8ITjzfcx/FSO5+P63YXvuEq76R
X-Exchange-RoutingPolicyChecked: sD7InPecErjKjjbGMmv5b0EIyISWi0Ev62k10eUSdoHDOolHxSGmyxHh61PY8y1/oAAHvwrUbBL47RZ1u8v1sA2yI62Ieay2d169opIg0OwTZSfiLvfE0T3kg5YM42fDc+JcQU3aCYfXImMbydJf1v9AevdFVPeN4kFrfsgqBLLAcjY7GSzmkrCMlkc+3w3+Yos568QPNcHBi8uu7MZ1pvjD6IFf3FqWU4COF4MYJ888QWYP1htno1UERJofh+vOuxA0G8ynTe+HQnIeKGls0wz4+aHPxSBHGR6jJvgrqgSUMZV2lX12VGlXVAHs9cTgQOCaL7dma3sCEp67Ja0Eyw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BJ+JA3kNgmHMAGCT88FcI0PkZDDi57lCiFXNhmaVY7JkRUFQNdJBiYUPIiXx8a1WAIJ08wvoze1YlYGCrDalkQAep+8ybveXYd+xY8m29TUOKUK5OXLTpv6Ch1Z2SwhSWP0FQ5X1JYPg4P0lNZv8Wq4GE8OysYvcGwqPz0tu1mtkC6z9+a9JaOSxwf7w/uDpywgxL1XldjXXybDcfXSQe2u4727XDnkEY7p5kJXBDt2udb4y9zxHBinJckPLGwzo61OMrZkUiw6mRvv6pjBIFVjsRieRuetwxihx5cMGJ68ll2ByC5mc56qZ5Cn1CaUZHWjSYxMtu4bX6cn0oJeO061plFJUg954icual04up1SkNVQFKcR68vyS9WykZAH/pWufF/ew2Ce0Bug7ErdOopjvRlttEVnoO+wZ4vKbvZIvGrdb9/HMPVLGvE21kLZ8x504ip618Qhz+SOuNBo6IiSS3yAaKKfiIrQ4Lz5PjFPibot8E+7e2RKCkMmIRc/sLSJ/GFvFF5GaIMJxy1uKetcu+FogP0YYqhDpWa1sfciP65gbQrslujTVMcwlO2bVYGauJ0ydSceCrbR93Z9gIaCn7Ypg10At+v631+jowne45rMr8i2P9GS8SGBm8HEC3U3K/cJ0oIRs3aI7iLKIkA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:34:20.2949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b886f06-7d75-4685-088d-08dee38a6109
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3681
X-Proofpoint-GUID: 4KdfqU7wMnRFaHgp9Rec_HdZrPjDzj0W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX5fsJfKWqvVkL
 vkE7DTybtnmb17VQXxfbfia41mShoUINWT0PFhu0hPOcBPA013UOqsCDP8nAV2FjtmAIog7UX3j
 PwUORKn5ItfBZjkgqbPS9OaxoYWAuS/WxAzTcvFIwwsGHN1KXdr53qLb/Uc9AoSqHdPTrxsy2r4
 jZXjwFyj5HRumJtGvRGR3akbPx8leM1+cjhAkxcPIF2umnPgzcDa25S+znCv77w6T2yaHKhtKPd
 sUSmnSgUE3uH+r50YvbzfnywzEHA6GHzaE9A0BGprEuORvz7lrSBrKEIHrGsevNRp5x/vWOOFaP
 Sxox2siLp2o/lPlKOAoynM1ty9JFYRh8wB3hw8KsG2idAqBmO7TZgOuKcA4g2TgUHxDmjq3xBbh
 kWVmz+YAqfCOEFwA2e4T0GHl/TC263h24BGoNq94jiKmWvtFOyK125Yll7R58eUvaDjYPDQK8fp
 FZDjd4BTewFjuh2coHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX9PoZwidW0jtP
 ykpkg+lhTPmeklKfBcEvCsXkDHmVsDSd/jXLJMHtkftaromf2aAMJfb1EcW6BRDxPoUH3mVLW+W
 kI6OtNrFQa5bboyy6uMBX79sh/SLPrbV5/fzYADFd6XRBAzafy/5
X-Proofpoint-ORIG-GUID: 4KdfqU7wMnRFaHgp9Rec_HdZrPjDzj0W
X-Authority-Analysis: v=2.4 cv=GZInWwXL c=1 sm=1 tr=0 ts=6a595c71 cx=c_pps
 a=MBvOscNZ4ImqL1nQClNoCg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=cbNQJ9GKAAAA:8
 a=uDdc_uNfx6VTTYF4FfsA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160229
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

Switch to x86-64 QEMU machine for NVMe testing in the docs.
Add `format=raw` for empty NVMe disks QEMU command line.

Also, add -nographic for terminal based QEMU start.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- corrected commit message

Changes since v1:
- n/a
---
 doc/develop/driver-model/nvme.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/nvme.rst b/doc/develop/driver-model/nvme.rst
index 755181331213..0e0624925e0d 100644
--- a/doc/develop/driver-model/nvme.rst
+++ b/doc/develop/driver-model/nvme.rst
@@ -95,4 +95,4 @@ Example command line to call QEMU x86 below with emulated NVMe device:
 
 .. code-block:: bash
 
-  $ ./qemu-system-i386 -drive file=nvme.img,if=none,id=drv0 -device nvme,drive=drv0,serial=QEMUNVME0001 -bios u-boot.rom
+  $ qemu-system-x86_64 -nographic -drive file=nvme.img,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=QEMUNVME0001 -bios u-boot.rom
-- 
2.54.0

