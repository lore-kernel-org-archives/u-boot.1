Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DC3C79F9E
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 05:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31AAA606DF;
	Tue,  8 Sep 2026 05:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4Tmyo-6eHJN; Tue,  8 Sep 2026 05:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C940606CE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788844510;
	b=CgOJnPgo1Yj6KUQRyivOPtNrQA5IWnS4FVFwlQWMoUgnx8osDe/6xd/x7eG6FFCdS/1S
	 avcWRK6r+ixpQZxI0Kce/9mmzLrsCA5R9IQqBnrpEUcuqxb2mJP6gL12aaHYHxO7hm5pg
	 QQlUJxS8XsaimrzxYxK/o85B8p1BUQN3BlbUMIoyPFgwrfoMXgPL2h+cGW3YG3LrAvNPZ
	 dxrcDCwsI+yROp1TKL4gcSygvTwfL0hOUoPGYWQVOubIK2rCiuSOrb8iJY5ZUfBdMO5Zo
	 GOOOW9i7PIn2o4LWStCpRez0acOgLMo2sxUQ0BxxGjkK+/WES/FZT2SYFNiwcwI42Ew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788844510;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kpK9tVt/RRD9/vj8K3g9JgZQjc7bohHzTl2bvV+52dc=;
	b=HP9przYae1hTuGgfzTetIQhpNqA3RPmdzHFfRldwNAXOs5okXVr/pi+PZCcmI+8kbpsS
	 xVrSf8HnNFuiooBfhQTXTx24uEqY7nE678Y0EmysY0jDQVYLD1k/7YUoV6HJLrtWC9lST
	 AkQsNBxUc9dXM9P6r+p8bUA0r3pIWsN4MnaNxctpJAJVph0E8oq3HIaK/0u9yZJxI54MK
	 aHc89wodcTbmm6JlHBW862YKonPqpxwk7FZWYgoc0g753orrrKWQNvVkWn9rnzGInhVs7
	 pUkNhq6KVzlWQvkXG/ETHuVTNq6fLc4L+j+zJeLsz8aKpt8Q5kqomi/eIfpfu2vOz1A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788844510;
	bh=kpK9tVt/RRD9/vj8K3g9JgZQjc7bohHzTl2bvV+52dc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EecqAZ8kJ3YdCJwlR9U8gsyJJoM85E0vqyxr+zw+uG0Kn13C+uKG3phoVfevUUaGe
	 4bj0LyI85gXRT2ixhzdkQYixT0rklKPxqRnNcNeTwzEfiWDOK4C29CqDcrC/xdyVB/
	 6lpKb8SSH34hlUU+LqEcTLZSFQ4NFxE8cMhwdn7r7X1Ss5C/MnX8qkis7JhhwRCw5E
	 74/2dZgHNvtX3jTTrydwQqOwZGETEfiQAskgpRm58Li7nR8pSxnN8Zip+tnZcNnqsi
	 ZStJv34uNJC0xMCZsqqgKIHHlXTmCMLN7yMdtloKDBP/pRyxzzO93a/9jTEbQYOCbF
	 rtpJAzgabXJgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C940606CE;
	Tue,  8 Sep 2026 05:15:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 832C549D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68DD2808A6
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SETXQjaqI52l for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 05:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AC44D808A2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788844508;
 b=tQZEnmUi+cV9yTsUl9u8ffjME45zgAp6IZrGBNGKUaPT0gJnTz+2L85E2aqAh5WKMqvn
 6TXPIPSyg+CLcM36hdNmyHKh7IBTyhWNVCktUaBzpKlklOljshyNN0I6FPk18n5FS93hS
 i4CSXWSNvlXzrO4ZlucpjyBXTxKk458tRw14jllU4rBcoJ9KdFH0/d/ZseE3tTwcaA3Kp
 DBQiQbWIdCRHMw9AmJtg53SuvkHcMMpYLSn6I7ma3xIo+rIOyCb0QabbfTsgCLjOVQNTL
 HXw84Dgd81LEFFrSWK9cb0JTgzUZE3cr5pw5sT2XYdrTCl8QqMEkuaoH5he4xyku64Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788844508;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=kpK9tVt/RRD9/vj8K3g9JgZQjc7bohHzTl2bvV+52dc=;
 b=bnaWoMwnjiOz5Ch14rwkiiu56u+XuoTuiOh52ZPUltJ4rMo48UiO6IXAaVaotvHkMH7b
 JOXnUzq/u5voNuqIbvTuIMIZ6Vq03Ib4Cqpg1kxxTvNXMupHTn6QiTkVjVvgKb7cfat2M
 iqGXX4pLqOxEy5aa/Gn2GUAKEJGGTlIu1v0uMESfOXS4m4L9Ms9w7SB63ZFXQI72P88nF
 pMTdRtbhESdt5SqdKxjy+4F+ioPwZ8hvULig8aqp1+nPSaUK/Ar6Y/AzK3rajr+el65wN
 AQuC3OjfKnRsOobh/BWvw+3OPA66eQvQlqOERvZGH89mXF5JWCbxU1Wu5UR2VyPatFg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=PM1z5494; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=UZ05JYhK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=PM1z5494; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=UZ05JYhK
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC44D808A2
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:08 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 687Nnlxb2679351;
 Tue, 8 Sep 2026 00:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=kpK9tVt/RRD9/vj8K3g9JgZQjc7bohHzTl2bvV+52
 dc=; b=PM1z5494yJ0zNKCzCj8OgTesDecqJ0q6YnJamjxJX+Io4HzCfSRIwdtrI
 7b8u9apnz1howZcitG1tF8NqeFKPauq7luLFiT3YDEDhSPJQMw3/fz60jlO6GxO1
 0VCAU+AN93Vt1LsT2uYYteyzh+M4s1caIb3HFskpP5JjFAgc3Z3r1Nw9fPSeK8oU
 WzrYJ1TxM8ZXfJdWFTUsdUMELLrjMH+FpucbPjI0N00OUZrR6KxqzTruKuql7fFz
 DnuWTzMSfoAXzPoQAQhF3+YyPZRUJfIiokzAzT5duBPDxzXvHRhf1EbXbusdSlSM
 jvVAzBD31exrmUYwa0MVTTX8XRBsQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ght65nd31-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 00:15:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmr0ZPFhwosjqhr9DVrkeUfE4dH3qytYb+kWtoXoHpfMnj1gEtllMgBJZbRbR4XNiqEyj459nUAo50CQw1E/XIVGTgAg2QCW2Xrmitx4IVSX/EdaQxwW3pQO5sSwM14iqp1/C/IcazyhGovY0tUb0/MAIw+9dZi35WejvhQWBytlL1LMZBTx34Q05b/oqEs+k8ZOXRfToPM2f7tLeiTnoPZNFm5+D2b6cscDv+c9PSCBZ2rkQCwKHibrNEj/OOEwVsltmZxda2t+Un9YnaFIldIpJ1M5DB37Hbs9Qlyv7VLh4K1T6yEDe1oDgRTCF6GSPvX2BQ6epBs/MoYnLWg26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpK9tVt/RRD9/vj8K3g9JgZQjc7bohHzTl2bvV+52dc=;
 b=x7JN1xrAKc3Uq4Wg43F4E9m8uAyfQ15le8tllppTE6K6JqM5GMKPYmNGT0NBWIBr4MSMTcdkTn/FGBDHD9nQoW9PbT74cFpnXOHUTFYH4Mh4W5uNj9ZRXjJOeb0qfK/bvU6qhWTxF4vOdPl0hQFKOIAgo/N2i2wVx3Utju8cxaaZTAddV3zBb6v5YAJ+vj+lvI43BogwnmMuPlxB3t29xrk5HN8CWV1bGUnrgQY7m8x/iSE1b1NmBRDGkQMv/qH/Nd/Ylfc+Jo5G8y4qbxJHI91SOuPzTa/tC8B6qb1h4Ngx/LPAhjkOF8UGwPv9Kr5MMMqomSEqspDVVi3+mlMNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpK9tVt/RRD9/vj8K3g9JgZQjc7bohHzTl2bvV+52dc=;
 b=UZ05JYhKtETQS6rFc01geU38e5CCyu6x6GrrhhKIRzMXS9PKVVXDUbWc/dfKrooO5MA54rMw/XuFGFylZfTAt4x1j1d2tjduL9dsO7o0Qfci1WfYUQ9zhK5tr61OBgm3Tv8jLiaJGNKYfyimzLV6dv8yqgNTiYBe5ePuM6jUSaY=
Received: from BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6)
 by DM3PPF612E8E8B0.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.5; Tue, 8 Sep 2026
 05:15:01 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::48) by BN1PR10CA0001.outlook.office365.com
 (2603:10b6:408:e0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 05:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 05:14:59 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:15 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 00:14:15 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6885DwdA2811953;
 Tue, 8 Sep 2026 00:14:13 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 6/7] arm: dts: k3-am654: add bootph-all to gpio@38 for
 daughtercard detection
Date: Tue, 8 Sep 2026 10:47:31 +0530
Message-ID: <20260908051741.868824-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260908051741.868824-1-s-vadapalli@ti.com>
References: <20260908051741.868824-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM3PPF612E8E8B0:EE_
X-MS-Office365-Filtering-Correlation-Id: b81e322d-09f0-4a0f-d68a-08df0d682154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|10063799003;
X-Microsoft-Antispam-Message-Info: iRnxsQyrhgcqxzZc8PtRH+t4JomoM01r/Ll9CPthZZrK/E9j2uX1FIwSlzZpySZmxTbayqUjXdGWFie3s8ExAcJm5385cZOD/wG5qJ7mt0zutZjbZjEGWlqm/E2KVwWx7S1/REOXUE0ysn5CgtzB9h+gjkrUnpoyIaGitSLpobDkB7TPsDsWnXlmUnH78Ijw8SF4llkyS1kWteRwyWo63Gg3wh3TErcVLX6Q7c/IkfCtcSl5VhkRjNY9iefItz9gOtGRkwKkKPyyzWH485EuHdtH6uUxee16aPT0ozIb7GGbAHRIDcrf+FKEdvIxW+rO7vOQqTM+X9RpRAy3GP7B99y/uTZUFBaj+NZ/gAxRlYkwjUKSx1/B6UXJTNbGcmPMCTbbcp/rkfGzCMVqNTDbL/upzQ/cMd993uBnxzihJhRGEkBXrB42vnetRSUmknZS1qAfZqBYGBaPAimyYvwekDsV9Qd4V7zsiqNXjn0ay2zYLXVCmqE55GBz8ZKv+pdQsxr7JDI6aqMm0yPvw5avLp0W404ghGlyTxL0XBngwDU8kWcgHUiZEn9aizCu/DJ8quEJsAssNYpc4jbK9I/DHi5Q/k+4VsbMSmA+cg08mPt/GGAAxbfhvp4FvLENtMiKr8NRugncsV3Zkwxiaw9KY/ycnSLd9Os04khDu80vz3xwn5oOGAqFdfQD0ZHZ49ytgBFmGpvHcU/9LandNKj5RA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(10063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q2JgfYoblCl6IHPv/E70Kr8QLfsnRaJb97aTHT7bTUEn0qyywtkorZy06Ckxd3aJD1SkdJg2oborbio3zA3iSOtpeKM6bE8KmYSdyXJuNWNRvpvpCahWgEPL2QGCB/J2tmO/f+gn/NO8VBogF806WqUt5pJsyo0uS8J0kR88GGFfEh8qhR9IWmVVmD9uMIdKhKvQu1od5jkdeWr7W5fYtyvvxxkRqj/z7Lb2MVtityfmaQeXJ++EZiafTKjOHD4UXp/V+CnJx/kVmB5gjpB/eRtTLuQjii/mcLCwdblCda9J1opiR5QCgwxbOflSVsUrc+kjx0wCcEoV9Pal+xuDh9DntxAsWCXi+a9bpyq8KqqWYoQ1zST0kUEdPJQdP5Y73pBh++91jYLmXP9ULUFno/SapS1FQ12D7ZrZEdmBO357siJuG2368OZ7TJP4CKv/
X-Exchange-RoutingPolicyChecked: BlMCF0lsIh9DKjwl088aqy7UVEMUBIp+OraCu4GPuySKzQRNAIZaDXsuURY6xYCalBa/BRhHbKRhNr9FYL9AEO0d42R9N/O9PFjtj0InOtXJJlWA9d2xJ+1cBmuFOwnRI+HASZKgKuYlndEGhrheZEWyXO/EtUK0VIVf1eWtohV17AgdoEcrb2wLAFfLGQWr+OYDZ5l3zwEy6jQuTw4V3ZC1kGNv0CPdAfxL7b960Tqu2oTlDYoFhTxqSTrSY+Hbf9BEo3XXWm+vL5npE+SRmhqsaeLL53YEUsuoBhT7oEPXfgpgQusRoDytGjnVUw+GrpQp5j25qsiy3LtND6FbOw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:14:59.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81e322d-09f0-4a0f-d68a-08df0d682154
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF612E8E8B0
X-Proofpoint-GUID: nRXIJTrX1A0F_HKm1l7STlhfoMBpq-Xv
X-Authority-Analysis: v=2.4 cv=I95Vgtgg c=1 sm=1 tr=0 ts=6a9f99d9 cx=c_pps
 a=J0RhwYao4za//xiv/28V8w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=VsGSjbAOC_8i-f7ynrYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfXwN3pAjt/vo3u
 g5LVEJyn1n7fCv26FseNoP8+O6DhRzwcKLXpZBzqt/FaEGPKrBEExnSA6GkfuR6lGRmzch2Wgsq
 IFq+b+yCNZ9LumuhCjoGVgm1mbLcpEfVj2Oui0lZtrnqo3v++bc1M3qfduMykaHAHsWXGQQk6T9
 LQykwWSAc15akHGrphVVX0hFjMI5AjhTC5MC3yftRT0UklF9N0B+TTZYFP8aQA7KX0dcrduSRJ2
 ErSeN+RyzUg4BVWs72U35ZDiiCopdTqgwmoZemM3IVomYKNu3ymJ5voHyIPSYF4bamEL/a+5xow
 YZrz7LX6EHYnvuLk49pnzDDhDC8GT/uY1zXX78KeMhY4W5MnlCyGYHciwV6GlY/Af5GDriTFbgT
 0kJWeBoycDltr2tuJnCZIf0CxVEmF0/4e6j+8sg/ghTaeaxXuMimfZUT460nJB4laVN5LkgYeci
 mCkwKmMF5zBmaRoMEuQ==
X-Proofpoint-ORIG-GUID: nRXIJTrX1A0F_HKm1l7STlhfoMBpq-Xv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX+NmotjHesAWy
 lc4cdE/nH0VCEE4hiEIyOU7E5t5aluR0nR43SuHof7atV2yEn06Ssn0W5lh3JsNeYFEZ6WGuIqS
 cBF6PsLcLsbofONYCaYOjVGlD6rSOfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080055
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

The GPIO Pin 38 accessible via WKUP I2C0 is used to detect the
daughtercards mounted on the AM654 Base Board. For the daughtercards to be
detected at the SPL stage, add 'bootph-all' property to gpio@38. This is
required for the PCI-USB2 daughtercard to be detected at the A53 SPL
stage followed by A53 SPL updating A53 U-Boot's device-tree by applying the
device-tree overlay corresponding to the PCI-USB2 daughtercard.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

No changes since v1.

 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index baf5dd562f9..9e5f4b6da10 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -146,7 +146,9 @@
 };
 
 &wkup_i2c0 {
-	bootph-all;
+	gpio@38 {
+		bootph-all;
+	};
 };
 
 &vdd_mpu {
-- 
2.51.1

