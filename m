Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC0606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gu7uAYmt;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bRmp0A9f;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=E37SnfQS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27DBE80F46;
	Wed,  4 Nov 2026 12:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Ibg6IW0pnH7; Wed,  4 Nov 2026 12:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 682AE80FFE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793797064;
	b=SieZFnY+Jb7kArR2lH3+w6fsI1iH6pGz9qyxUFBs1p9nV2eC4mMLzMOe587upmMOfYM8
	 Qx2CgvycvmJWi5QedbtweTIHtQnHpRzlGUfGkjloaQgtNIerPljyha8wPnRqfDppsJcs+
	 zOkrdjjJ0+zJfRz10E3vJfB17FCYSI8ApsZ/fCEEUd+m4Ry6LuA7RoCyKPiv7+cf0WZDK
	 X10L6rF4CSKNS+S2ZzI9dXF58w2p5DPwf1hFjOVpJNHNvMMN06KDuuk2xQ3YK+WKDxVnk
	 XMV+J6zfu7LrdjITup4zRu0j9vWoNUQshyGvM7LJu23vuxvBPvGzTxAlQZ+AgeCQrTQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793797064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V22rI6FCh/9COxOTJtLP/fHfRpWu2kyK2YWK9n++dQo=;
	b=AJ1AxkHoBHMtBA82DF06E5WCNx0b8z71P94gvgoDZFbxm2QrU6IKXCGaAIbuDwjgBbAq
	 5ga04cYBW/9bjsplBsvTvu3LRDid+tttRUbYw9kjWUvML0VnkFjjF5Vtd5PlftSuRCy5W
	 mKZQVnFhRchCVXILhn7ScLKvShkKsYuAMNvp9FUnAxpmtIgybG6WUEDui4nqlQO4YHSbC
	 Lf4pT8JnHaslnsebosHQPbKrHG2m8Sn5TBJU7U6jiZH7cIWoQtDjreHt7/OoYKtVdOoDY
	 jJkEZ8jV4qJzwvPa8kyRRA4JPANgGiex/fVDxJFiwut2GVqlo5j1K5juc24cmKu7MTg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793797064;
	bh=V22rI6FCh/9COxOTJtLP/fHfRpWu2kyK2YWK9n++dQo=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gu7uAYmtTfLNmpx9UriFUiovL0bCK63JviE/jc2CNn6z7+Mx/4RZYnWGcXDgz0U3h
	 YjF0ywis/eou/xfv6jG0zpxQAZC12eeseCrF/IFE1kKETmvO5dLb0WvEiMvGfxEnkp
	 68sDvcF2NxlI4+FEWRDDjNfwGAkAU9bY6ddjaAHVHHAHlrPdb39KGuGO7MjrrXo5h5
	 OD/8hrhPsE0J1cYkOKmLt7HU4rJI7vrLt92lLeqzl+cZop9ZA2BWpbk8LAqcX1ZeSO
	 aHbTRR+fzmYwqskYN1vIPX5CiOT+6J5ytdnYwxP0MnogzMAeLLBh/kvI3XFQvt2FYU
	 pwjIfgmwjrO6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 682AE80FFE;
	Wed,  4 Nov 2026 12:57:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6051C341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51FE540068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MLUciAmeT77W for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 86E8B40063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793797062;
 b=rNV0AJ3kCTW55Wx9VRGQ6tLZw6VaA10Tj9k55pZpSUE9KADgjhql4ducAp67CbPk5wYY
 uYXtlvnxDv2sFRNj1/WRci4DI6WejN5QVfq8LgZaj/PY3jJOWOiZ1hTvpaS2p4f/+OiMq
 pvUzAGKHrxaLRhOK4lz8UaAQ2j77u0BRdh/DlY+AedRfEacMXh0aenHXKnU+bmCn4oet3
 C/FqoiPJ8Wd/+WHfzWNPatxh31jJYrwEas0jxkuH19mK4g6yEtZ9hiSb0Iq+B2VI2zvvs
 NVaiqUvQvKonYFLe9V/o83NKTJDCka8kNtf/uwPW86hIQ8AfWn/+QcByuRjFaKratBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793797062;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=V22rI6FCh/9COxOTJtLP/fHfRpWu2kyK2YWK9n++dQo=;
 b=KzjM8smW/mLPSEtDZGkjkCFupk4BPhKwwumgSIF/WrXsZQaVkIJ49fIb9pt9o7MuMNfv
 nVPuJ1OSrpAABAEJHSXSyMP86rNlks5ifUkV9/lUiLrL/imn2U4VcrvxTEMANnk+7UcIg
 Ry86KD9z8i3kGQYgL9RjimXiBwc29A4VIQogA/SRb1Mn1nkL1T8PE55XdJqvSFLFp77LB
 dVJT9yVVWVCjO2ctsrDf+8luZ2Z3zujtqXH7uSTszFV59UeNeVuJRkFRNl4sERp5QuBn/
 V+/NL5mmmJ6oQ/ivJovGXrfSj9FNSOxhSO5tEP1xskJglijqml9an10ftirhAx9MwUg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=bRmp0A9f; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=E37SnfQS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=n-francis@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=bRmp0A9f; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=E37SnfQS
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86E8B40063
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:42 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4BbphE2350529; Wed, 4 Nov 2026 06:57:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=V22rI6FCh/9COxOTJtLP/fHfRpWu2kyK2YWK9n++d
 Qo=; b=bRmp0A9fKl5KmZgsZawn3KrY0KJhe5iCwvtRvhTCw8NOm8gy1CG0goM0f
 bEUzuKqjRi+JjIENV0akalfpxZ+9vqa8S45P3qSHCBXmQhAXdL34+P18OnRYq0Ub
 C03BqV5NyD+mcU3aClL0LcUgAZUPJMQcyZ0BMje5qa3HDNL05nJfXUQfwxDk6WsE
 gIhooYsctQrztcxEbv5+j3v6PSryv0dx0heT6a6/CEk7tE8XJi+RZL2aGxBciMCT
 oJyCyEhR2M34sVEj7VkzfUBFubRV9s61k9R4iiEZb+KnIxYwP59DYiEjb+oZtGDq
 l8zJPjIxcOd6mL8uNVveRUvsusqIA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hqu7ek8uv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 06:57:33 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh6sP+hc6R/ZaFajqQr4L4oTqqD/FapxNA8nPgjjnpNt6aUMsM3Qbua7t+tjD58LBEceILlw2b02ucVIx9436FvZ8dSvB5qdI4cDR2HjnM8P43QHf8wldLFE3Hm9Oo85c3wbqgy56fue4e73s1QTt0P0lJ+Ab0RJmPkLQ31wruadNeGkhJdHOZVZKwbKJx9xjtIOumIRSl6e6oligXQ8DkuQUx2uMwFPrPYMHWJ89AI4fWa7kKQD78aM3btekbSPqMQNX5oz5W8RTPl+2XDuq4rhUVPwStqL2lo5ZdlZsEoz/jdAzw62njaYWFd/GvloP6kDiR28L/cu4QjC/JRoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V22rI6FCh/9COxOTJtLP/fHfRpWu2kyK2YWK9n++dQo=;
 b=wx+dxNARnsCH/9tYwK3VI3AEgfr6CLKSOccjRNycrvAcG6QdB4SZdy3tqZDA4BNYr25xgJ3o26mE9BOmDxTK+WX+UQpUf+V7EtYa7epmuWie9rSOx8SPqZJPgxfqnURFWGqoapvwXAk6S2s5izlBUN/AZxqytL2kKws7nVyVrwUczWZKu3VGjNWHBrWH+BNEFw3rYDrj1zQ0eRuUUQ8goiYMPIz/ueBUtG1U+VlHy6F14qdOwRfJYmzwKqV6wN+ETnCeULZWj9seuNPhyGp+fNl8UzjLn6Ji9VaxUqtrzI0Rrt/RYcCV1Cs7QtjHTM1K7chyL0BG3mnlA5ZFHo/xrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=basepowercompany.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V22rI6FCh/9COxOTJtLP/fHfRpWu2kyK2YWK9n++dQo=;
 b=E37SnfQSOIk2IK9dknK76DbxV+36SSiza8Xe0KsbfSd9NzLmX7bWJxSeVSKMPvm3v++10pVScH+oU/7J0jJsKdOoLK5PEICnUIublT8Aq/INlYBW0SeXetOYrKIkyyzA+7gRBRyb5AcuD5JOrvy414SBp3mj8oAdZwI2s6U5GQ0=
Received: from DS7P220CA0038.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::29) by
 IA1PR10MB7386.namprd10.prod.outlook.com (2603:10b6:208:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 12:56:28 +0000
Received: from CY7PEPF000000F4.namprd05.prod.outlook.com
 (2603:10b6:8:223:cafe::2d) by DS7P220CA0038.outlook.office365.com
 (2603:10b6:8:223::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 12:56:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY7PEPF000000F4.mail.protection.outlook.com (10.167.247.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 12:56:28 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 06:56:17 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 06:56:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 4 Nov 2026 06:56:17 -0600
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A4CuCdo2180519;
 Wed, 4 Nov 2026 06:56:13 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/7] event: Split EVENT and SPL_EVENT sections
From: Neha Malcom Francis <n-francis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Daniel Schultz
 <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, Aristo Chen
 <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, Julien Panis
 <jpanis@baylibre.com>, Jacob Parker <jparker@basepowercompany.com>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-1-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
 <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-1-e211cba9f3ea@baylibre.com>
Date: Wed, 4 Nov 2026 18:26:02 +0530
Message-ID: <179379696262.3643704.10177847535987060269.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793796972; l=475;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=XhqRlrHx14s6i6VkPZko/ElJOQtGaTF0j5MD2Zlog14=;
 b=MeLqhZAf7tgK1CmSLz7CIkUAt0aBV/JwFevABaOpAeLou9Xdenyfv4xoxyDcYoXfS75Rjsl/1
 qzQHLqvtjgSBhegtW9meE1vk2aywcWybctMYaR+75UAwV+559fGq2Qb
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F4:EE_|IA1PR10MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f5d23d-a8b6-4c8b-7ab0-08df3a730ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|4143699003|56012099006|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SaCqNcgY66gtGRexxYgdiko2qPLM+jtlGb8wviv648/ssIoSJFcPcGtit5gvY9N/PUO+J7aOE8YL3nJBppzFgyb4yV+T0AWCkOfTb2ej2WhRmV5eWOCg+9vS3IshusEzqk+8PsYk9kx7eMtWvAm46C0wtiy2UEt5ZpkXcevMUh5JZs3ajBh14p5uuZRjPR4RyBolOiYMeLRrAKbEJ8TKA7f0CK0ynGFFz6G9cghnDgF1XbxxU7SIXRag7pbYy5l9gGjQJ3MlU0OV9/McJwmes7PIBzLdKQkpGHEg8plaV0FBdM49eSBiVEwUUKcTQfjGC37jDlAXbj8w8HrvdYs12amTfhu6d5gemGeN9lrTAjGVyK4e5hYUWdaDX1mpeN/IbOx0tONUMw9LQ17b6wTA1jH1qoXuT8ymmeJKburxocjWm/RFAPkYRmm9pkE/vWcDhTyhttgcxJmtQxrG+IR84htjrn2XlfVbHUOvyzy4/LrwBE/yP5TSzU9R2Tu/PtvEIohtLwULeDCMMGBbuxw5j4X3Fvp6Fp/OHVsjHwKBUhwRJmTwytNLgZp22oPRmL1HYE1agNRQNn8vW3XWQSuU4oHg9q/sfkmigB/+Bi6BaXchYlzjweoSuflYO/JQ5JuH7ltESG5OQacBFqH4Sf82RT2GL2kp/sIEx5B5jkeedivnpqg/JIREyeVAFgNukTsIbWiKbmUgiYJBI+Ut94uYCw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(4143699003)(56012099006)(261026121527099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dPV4A0ygR7YZ1iKu4srUnBO+28tJ03c9+nNAJGiafXGti0kgWBwDcfJLot958qZXG9BrqCKynQL0UIbTYSAsyO3Sd6D1H0FGxNa4f84hvICiUvh0ASGAmR4HgimXeW7iSMN8zRRBOHnNkSwO1zngQZmXVpuzps4IEyjBE8DJL2HeZMKJAPjeQFlSx0mt4aTbkqlYReMNh0wyWUW+bFNXyn5exnj2DtoXo2n2sbw0rXKPiQQdgTiTjXj9Ty5/92WHKQkLJwrpnDsVX95m6XO5YL+9arWg526+gXt2we2DA2IfFp/7dcblaGlm4K+YafHR3ZY177Uf6noh2xcCUmHkyAlLdhYTzvvX8UZEAYCSZqgl+DptCPbh8X92DWudqtYf9qTv/gcUAlGIZh6Hjqc9W3Rz0O0IzAhE4uJVHRkOcbWye1KnCVWI0eupsbFN1ANj
X-Exchange-RoutingPolicyChecked: FCJS8xUgewMD9jBWL83aNYzDzYj0Z0A/0wBcMUR43OngZS/fuuP4CPQeTiv8G8Pvb4HysuUD4WrUs7WlTGa1++846GGZurZyWD2ThFTDPdQTG3EwLVFyAs/HxS7I0nA9EMdvHeCPEQuZuggJaOd8ewg2q0PMvCK4MWu4GRTSwSNwXC6/2xMbb5c7JWZUuQRsPDJPEt17FMsAZvMo4X8jUkeAFaNL9ddzb1cPmUgv+0gXoFKfnDEYyi9juC/0lf9uGMZ2QT8MyCrWw27pia9TatG8hZTsFUS0nbgo5yfcDXka/cpt+NWHXo9uv6q2VrZ7aavNGO212zHpWZiZMo9K6Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:56:28.4550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f5d23d-a8b6-4c8b-7ab0-08df3a730ab8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7386
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfXxDJMs1cKXD8x
 Lz35gfW+NKPwitJwnU95Sw8E9ekHK4FDIjn5unuRt6UYCl3eGMeo3+KehzmVe1YFkYDaCzS2Yir
 2ymRim06XeQtw8ZcCjXCOnpszHfp4Qs=
X-Authority-Analysis: v=2.4 cv=fPusTpae c=1 sm=1 tr=0 ts=6aeb2bbd cx=c_pps
 a=MBvOscNZ4ImqL1nQClNoCg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=IpJZQVW2AAAA:8
 a=sozttTNsAAAA:8 a=NKcL0onuHov5uJsqtTEA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 7OTk6JuBqE2Ea9Rnj1v9j5d6pETGthnU
X-Proofpoint-ORIG-GUID: 7OTk6JuBqE2Ea9Rnj1v9j5d6pETGthnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfX62WsrWlq0G1Q
 FEbqm3od8d0v7fjbjBG92SrrYyywGQLxZjQ7kpY6pXwWNuwx6IAHPDdvH+pvoTMJHcsU9OUgGfU
 Cjo9fmtGFda8fXXiV/KOJO0rEOUVN+omvkxLFOFJf6Smilmz4dwUGgqj9gzKiBb4j8EH8thdm9Q
 1QrUEcf9YBh4cRKKBTpZyUXfM9ND4wrDTxl98U+hsScd5ZuefJMuMneByDLVu3Wjyubxa5GTeg6
 vyCmmT9vuKaDo6yhcWv+RL6NQAlQI5ENUvapdS99Arl0UjsWgo53HtawYFfKYj+zS7o+DwkUTfy
 sLSWZ2yBrv+XyDV3iH6hqs0WeIv/LWTBPfdDKTaH8SrICsy0Z3S/KeX9OvHNBdwKbOQdbFmj/LT
 BOeWqvfkpj1iz6FdG80rIXC+ULEx/tM6p/oShTA5xFPjlThJvr68qA/H9XVkoXOxUFZDsG/vVXn
 i2zGAZITJKpPPxK37bQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 11:58:19 +0100, Markus Schneider-Pargmann <msp@baylibre.com> wrote:
> Logically it doesn't make sense to require EVENT if SPL_EVENT should be
> selected. But this is what currently happens since SPL_EVENT is within
> the EVENT section.
> 
> Split SPL_EVENT and EVENT into different sections, so they can be
> selected independently.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
