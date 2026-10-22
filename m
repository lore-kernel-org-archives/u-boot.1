Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9350606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y9fk8/6g;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=scSTYDTf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85A6E40782;
	Thu, 22 Oct 2026 13:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-eGGFCwWm4z; Thu, 22 Oct 2026 13:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6EDD4074F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792677486;
	b=AMT11zUlI1nyAYqi3glIjqofD6Em9tlN8RJUew+kagqwuDuYxmDEB/MWTlrPjCqV7KZH
	 y3MJAGYAR0xtybg1liX5tj0LyJ9JG11eHY49E6VVV5gnA6ir0QBLbh54He9pDClPV9N7d
	 6wsU3G8zgWXlgb1+Vxvf79cccY6u70JYS53VX4fun79LK8jYM35l8AqyGeXFaJVFQbqW/
	 NiYTtNucthrJ/lkqn+FRlSRsRIf3K/z1HZ5fuUZR3HVyHXFkQa6j7oXteT4gE0JhPUu5G
	 PxaLPSI/cZHVGAAvkGIAvqk6RupkSy31lL1SACDgnBQeeEZrPAA5OCE2+lFBxCGbvQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JheB2tD54L+jlLiTjwYE37XMzIrKyeSNFgKF90ZqmqY=;
	b=rMshRDzZK6vxdJh7kstMqqcKfbtAsgvSXbg7tDWlPA+MWily4V8vyq9VdQgjhL6EEqfD
	 KriT56Dm2c6/DXZh1LFZWyZR58gPxX2D6zc0c0JNzliZLcE7uhCPAf/UI68FPSHdUbSeO
	 6BjR4JO/CiTE+Dq0hrJwJ6Auh2umKIdLz9eJ/MArl+3t1siljtZeCEcY+FKaAa+BtD8aa
	 COfuMJdUvj8DxhGpfEEmLxw38wUc4n35WGQ28rGo1ZEfebv8rYrkWXaAoNMEgwEYiN/YT
	 fCO56bAsGsSN/jSqtA2Y2ThUr2fdEvZdTdRAc+T/xpzv3dwYYs0IoKH3LpVYu4P3WrQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677486;
	bh=JheB2tD54L+jlLiTjwYE37XMzIrKyeSNFgKF90ZqmqY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y9fk8/6gkEJESpXGigPtpxBj1sQqEEOHKAxATD1U6nOw+oDw12n9whJec+aKkp1Az
	 LNKwJ11PexFaBxlyPw/1QmwfrEEFyi/iVBNqUoXbCX92gXnF0VwselKzONwRhKJXeg
	 xNTSgbXdSDatNvgRX16JYKcMBvWtxvPo3YVCgr6fl0IzQl0sg1iQ0rSCSLJItf/EjY
	 rBTElfpfBtZ2mTRr8jtEE6thp7MHMRopTNNPn2eDZQLwoVCkc025vCZWW2r4nH6AWh
	 p4CVMtQUtA24FQ7a3iRo5tJWC7m0uOOKYHKYQd2cunFrnzjrtKk8Xx0SweItZpPkTc
	 NR/scrBRmGiwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6EDD4074F;
	Thu, 22 Oct 2026 13:58:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E398223A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9B11400E9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id axn6zB-5rXeI for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D51A140086
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677484;
 b=LGGOCB7GWSQQJrocMH7VunvNrq6SdwSQdWYV2HUseb4DWrhKNs8YNU+gUjmI/npRb6vP
 oA9qqR2kDAiUq5R9pGxCkS1mCNOXnTlmJ7+PjDgpllOSQT6ggcp7kUCP359J+FU/MXe/M
 6YoNFha6fHWbrO4j0HTTBCcHSAp0Ulrzn1ruy9KpGJD7HQmMJdcYizeDlkxzlBUB/zc2z
 klQErOCSOJlYNDCLjDogBhzPFmA8oHLDrnpTzHjWllOHpNjKuIu8QyXWndcKXvuuXx/4V
 abXOJ+7+Bdkdk8GZ7emLVklBxjfuDExnNgOwCcfbuQsyRFsGR+0zWUXX+xwWOgEK29w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677484;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=JheB2tD54L+jlLiTjwYE37XMzIrKyeSNFgKF90ZqmqY=;
 b=njd1/mtDtszX3uxmtI/MR71N8LDEVcMBd/StlT4JrDx9mJzFke0gaDr1BZoMsqGqcLKt
 P1vbu0ASBp+5zAffWMrAAVKZkgFwPBaxjoMBtl5AvBTs5AhYCKZaAxMha0BJ3a6fhMODT
 hmHaAbFtFL+c8cXqqsjsUIxIvp40A7W1T4l6QrJh6lSXFTFaxYL0C1pxN6PrYBDebrJwB
 cUNUiGxSjRZDNpurQLT5ctcN+nnDqSouI3RskB8KMDTHaB4s3PUYnPNLu+PuxKhjGo724
 8I8SRBW80eQ3K1Gz/fMt/valJz+acxr0MLYNpzX2YRbPrY1ZDHd/Ko0sIaWj/+Zjd1g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=scSTYDTf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=scSTYDTf
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D51A140086
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sESryda4ZoSPC0ASwQ2bebPmcHMIp+2+EBGrY6iQrX9zp3qLYl3X0VFpefyLeWxSyXzlqtGdis94H24tWr+m+CiPhM1kv3xO/4PPaLids+HhcEUZcN3wjkKODJsaVHbZsJxHH+H8Z+S830qsPz/ppKmz5KUyW6KOMCgMvfamOub7pOMIGOJDPhJGDBkUPDr8kPSy4iBqBiLNhqn7R1PxKzlyUVuV+KoErJr1DvkNXWNP9EzpDAfISRMi9xXGee9C+p5q/dom0t/vEHhkwm2ZzuAQbBhnHOMsrLONslz3aEKIIF5WxYSHE+1elw3lszUVtgU4aNxpEWD4zMxjbB84zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JheB2tD54L+jlLiTjwYE37XMzIrKyeSNFgKF90ZqmqY=;
 b=zB5ZQot94H4WuIs7KSZqDVMU7/apQWKHYS/XXAOGxBsGo+M0rayvf+Al0VzGnxBFQFXpY0Bi9+g2lN8xoQPZT2wUR3umLCY+wvfHj6FM9HKO0nwHWjn1NXloc09762E1pGCQGzMhVTnZWBvpFg23dU9v8WDIA4/dPURGaeoixCSwsB3qLCx6FIDBZDuacHMp99g5QUyk8jpBTaJIAutTfiauoD+1lBwSA/Nh/hWKMI1oQzzp0G2fv1Q+msxPUNE226IFOqt2bn69YlltkQtIhsP5zZg3EA+tAlh75OjUO8pLFWE8fGfjQu53idH5VSGmOr8WSWwIIYursz0vdqSTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JheB2tD54L+jlLiTjwYE37XMzIrKyeSNFgKF90ZqmqY=;
 b=scSTYDTfFv4NsA/I3VQ7lRjtaJECF6H1zvk9rtmoV6OUqoe8yG2+sbgIYJHnRpl7LfwSFe1mENVq1zToKzU6oPp1zUO6hfERTigWUowKiCcltZQud9Kx0jQZ7JikaZ7YYb5ziok+rPeZbPWxDJTZGY9mJTkoelmwH1021PgZcyc=
Received: from SJ0PR05CA0177.namprd05.prod.outlook.com (2603:10b6:a03:339::32)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 13:57:58 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:339::4) by SJ0PR05CA0177.outlook.office365.com
 (2603:10b6:a03:339::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Thu,
 22 Oct 2026 13:57:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 13:57:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 08:57:55 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 22 Oct 2026 08:57:54 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Amit Kumar Mahapatra
 <amit.kumar-mahapatra@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] mtd: Move struct mtd_concat definition to header file
Date: Thu, 22 Oct 2026 19:27:04 +0530
Message-ID: <20261022135740.3869144-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022135740.3869144-1-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 80177731-1d7f-4b02-97c0-08df30447a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DrlGVSvCcPuLp7GVxP2VWbeE9nNIwKHhLhg94/qbmXRp2WRHreAdhUg3ZpfEDJKHYMSamCZRMDRlomlD3ff9FG6Ig/RQs7anGa/Ve8+b00Si3UjZlCV56ncEzBym1Xyz7ugNDsLq7M1Nsx03//7snkprE+bhDTv7WVG04H9BrcPDn7HXUr1Lz9BWkWEe0SYvHEYxTTAVWqONqvOLGvvPCOjPgnVoLLw48b/dwskCBQylMLQrlMdWG3b1ToZx6CPeAPU23xDTvoiOx8Be6kV4EVPRmY411OI1jROSl907QbEOy0bVlrU+ndHsIT1XYQQ9/SMGtaYVy84fmtMzu1kDlxEsDijT5Zjx6HN/v/LfaLoJ+TgrmYq/wCeCtehSwHRjdiODKOSw3s8xb1rjIctHBrLS/VNiuXb7A9admpPVBd9AaPlneAq1gurHvQYmMMefrj4sb5A4OQgkwueNqPEJfY2C0B/qm6fuyxDTPjX9ZWNwkWYMvP0tVvA4l53/fcKWhjiVkWeVuIMTJxGVgeFRfZZOp/KJ07DXAFUhhcvXlTc+gUZtOGTNR5dFzAWaOiCU+QggqKioiQbjTDf2Fc9gZJO1mUL/go/a2EAgCJA/l5nfaGtrwaa8t2KL0D0FIGniIQy7vS2pHr8eG4kWgfOUAyp8NGLX0N7mSyJs/IUqnDtcSFG8oIU+Vod57QKmQ+FYbUB829JK9Z2Jxg6XaIy20w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k3qAY9Uwk2GrsiQk/pXVMwKrcjhz/batoXycSOZjWQZEd2XuBuRFhDMQFuLTY9Pde6BmhCc49LQ1ZioWq9+FjDoCleSBup481RC28rp/vM5Y2Jqwp1iSZiJwQpo3NkLOFDVY1cjhCcACcXWokEuIuBEwuBjsv2VaVAlGTslR++k03Xi0DwVyvtIA5i78lOpE0bJjRDifolvSQA9blTDFUHn1rTAKpnPcfWPKXA8LG3ztUhnYfK270adFFeyj7rAD9ggazc6QHVvjwPhOX4ASlHfJzwhxjHWOxc/tPs7c0LtbhraVW8qQW5zc/CN/4IbH06fk2sKVnDkwdQP6pe/tkYC69yOHZnBR7ZOdDVGP10Cq0aftt6iZEfplRqcPi2mWqxaAfeuXrtwmDYJ0Jt/+x1IoGZjTVYDEzqJ5yOyMtmDrWkrI6qkeQmAGx7GxWPzj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:57:57.2749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80177731-1d7f-4b02-97c0-08df30447a14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the struct mtd_concat definition from mtdconcat.c to
include/linux/mtd/concat.h, so that code outside the mtdconcat driver,
such as the upcoming virtual concat support, can access it.

Co-developed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mtd/mtdconcat.c    | 15 +--------------
 include/linux/mtd/concat.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 51232581d96..94902af4f57 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -26,25 +26,12 @@
 #include <linux/printk.h>
 #endif
 
-#include <linux/mtd/mtd.h>
 #include <linux/mtd/concat.h>
 
 #include <ubi_uboot.h>
 
 /*
- * Our storage structure:
- * Subdev points to an array of pointers to struct mtd_info objects
- * which is allocated along with this structure
- *
- */
-struct mtd_concat {
-	struct mtd_info mtd;
-	int num_subdev;
-	struct mtd_info **subdev;
-};
-
-/*
- * how to calculate the size required for the above structure,
+ * how to calculate the size required for struct mtd_concat,
  * including the pointer array subdev points to:
  */
 #define SIZEOF_STRUCT_MTD_CONCAT(num_subdev)	\
diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
index c57e973775d..d46ba8e1689 100644
--- a/include/linux/mtd/concat.h
+++ b/include/linux/mtd/concat.h
@@ -9,6 +9,19 @@
 #ifndef MTD_CONCAT_H
 #define MTD_CONCAT_H
 
+#include <linux/mtd/mtd.h>
+
+/*
+ * Our storage structure:
+ * Subdev points to an array of pointers to struct mtd_info objects
+ * which is allocated along with this structure
+ */
+struct mtd_concat {
+	struct mtd_info mtd;
+	int num_subdev;
+	struct mtd_info **subdev;
+};
+
 struct mtd_info *mtd_concat_create(
     struct mtd_info *subdev[],  /* subdevices to concatenate */
     int num_devs,               /* number of subdevices      */
-- 
2.34.1

