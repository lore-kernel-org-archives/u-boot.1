Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E0606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oVWCeBbq;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=gYP4x51W;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=XP24tT0u
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82260407A2;
	Thu, 29 Oct 2026 06:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhpZkug2YQ5F; Thu, 29 Oct 2026 06:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A15044076A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793254037;
	b=da1TLG7MbbX/QmKD3M+/xPweI23YmrkWdWPKZlwLDt7Pl+PnzUZa88AYzahAptcsOel0
	 FeyKK72qHf0pQr0SaMRJCorofuzvAaVKHVnx+KQD2oReQVzJyVC3jxK9UVXXpaVXzhCp9
	 7LAysoC81hYhFI8+aGUwCIeTkcm84y+DtcgeLxr4orJyNeZN6E8flwTEV3NvtGK6RikGB
	 2b2T7nAVBzPnWtc1NMHh61JP+LtFJhgkAkhXfz2nD/sMOmtHjdG/8J0oGIP0d7sLsEmI5
	 m4aAMYaI6Z3VihBLPTUpCOSCizascUohiJZK7ANB1XqJUZZpmK1nEaUyWq1XJ9AoNyw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793254037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xAnjEavPaGEqqNG3+MINemnc5Issjt1Sh/157HBTtCE=;
	b=W9IoH0fK9SYI2FaO7fHXjmg4ewqj1hfNbx/sjMTOPPmG37Gm/iWBJiv638p+OnAIW2+m
	 BOEVp5OWlkdZe9nuSUDqlgTcuxkHGAMs5UlJI/MTj6k/zQJ1TbMSLgHukko2++1eBM8Bx
	 U//l5tRErz0+XWSyLf0QhM1UyDb9GnXZDHx4hfkXcy6BrlsGmv50XR0+/c0D75WUrdE8v
	 JCLwuZEkf0PCvPwM5E2IUsevGbUwK71G8r59BhIJSJQ5nWo4XAPJvaWvMAv8Gs5Rhq7Yx
	 PrNxIPqN3s5CUVTAJNiVfcc7z31WHMc6LOhHflnFt5JWBt/UVsWFvRLQ2LH39yn5B9Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793254037;
	bh=xAnjEavPaGEqqNG3+MINemnc5Issjt1Sh/157HBTtCE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oVWCeBbqYmKHkS1gkB7tZbe3r2TWGyedHnsjXqZxLewnD8ZIMEWqFOLMsl0wSk+/N
	 IumNkPAmCKBRgw0Ke9MQGfUn/50MeSRAJ91qR6Qu+XcuhcVUC8q40PmM+o+vhcQLn1
	 a9HPlZ9OME7ojJmcHyaN1fdurky0ZZnO0Tq11HpjlbRvFIxSMFKouab2UJYDi7sxaY
	 VvaekHNvgzlqaNam425xzG+DKSWmOhz09aFqaZC7ILsoV18Oo7EE9FL+EFWe2sxmCa
	 DJ88NoIHocTKESIIz/vBDitrGBw2I0/+qyNg2DMdH7MpSHBs49zx7ZrQ/lUxcCn1h1
	 UK54MAQ+4vtcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A15044076A;
	Thu, 29 Oct 2026 06:07:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFAF0120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C169F4032C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 81tEnByhufpv for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6681040176
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793254035;
 b=DbhAN3aSRHLMshxnyOWuYzkuUJ/5CJYjpIBXVrcx1+hi4hj8rhXcHZj63YXPAQTF5IRm
 Erp/lOakZVOq+Fn13SX/9ifJSTN6mTHSvA+/g+U+nNChpPvKnZ+5/1z+nch4gZVMUP9mg
 KITz6LmZxCL+mQTK7NkPcAVvmfFvbZYiCoKKNi7ypMgwDLXR6q2kPotbZNnHy/J+EMoYV
 O5NUs9ABmcF5cnEitGPZWpJJrG5NTGg8E8zr2wQLd+JR4DCTsvr3aDBebvzejH/0Fc9mn
 41oiFpWE/HomnUfEiiBqdYFZMtGwS50MSeCMEzT5eDZrlJQucHqFqnVbI3QH+f8VS8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793254035;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=xAnjEavPaGEqqNG3+MINemnc5Issjt1Sh/157HBTtCE=;
 b=QwxL/ORZrJf1Gf5yFLJ+tMeFC1walQfGLyVzANYyN4tx7yFnZajjKeW76zWDasAjA/MB
 QZpWcjpCnEOZWqTJq5fHQKNrXdEqpcGO13O7wfP6/7zFqKNg6LDuDZAckj59h9/Jy+QCR
 V039Cyv6siaFuKpk8q/v3bzAPDMNcB+t1CS/W3hPf3bco1dYokWGGeqHr3XMh2t5MkCH1
 csk8SqhloXqh3r9zo3wWvEB1NLBpKB8gFsaHOvJ2JwJK3d08ebmePoFHSUYSX/vFOPzMp
 aF4MXTgMFHCq4QwUi07Z0g0hCFQVi1jvmdHS9MFj9bgyP4DSL4Uj8TrPOjBs5hvGZdg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=gYP4x51W; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=XP24tT0u; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-jain1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=gYP4x51W; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=XP24tT0u
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6681040176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:10 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69T5HsNM1716506;
 Thu, 29 Oct 2026 01:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xAnjEavPaGEqqNG3+MINemnc5Issjt1Sh/157HBTt
 CE=; b=gYP4x51Wym5h++u5g1YmOBp1WEkkTRb7XZzUMRncmpGSZ14RMIJqqLiOC
 JKXvDyHhJFFWHfT5JCvfT/O0KurHnSL9FaDf74rcFPfEVypmRgdCfmPin5Sgyrd4
 Fh0xOFv/yBqZ0Lzncea8aUHyu5q7m9J3J/xu4suUd2szbogZDUB9OOVZdjx4fJ+V
 zbEQE7AKs9v6ytrxdIqPNytmXNEG+5+vYyx0bdR+nDse9xhVEm3FfBj0ZxMOh6Et
 GZds2ay+5YqJWCEzrIeSIv2hDC1ckAwmTLpJDFpHmD5Q7SmXCrfrxfrIlN0t8aTn
 +0oi7HEKw2QF+cUmaN1se2+bno0bg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hkurv1yj8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 01:07:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T88E0AJE1KGjwATDdhy9XVwtUCvYY4yOY5f//ynGeD5ZljocHtIhwaseXoxWlqcgGDHw8Ob2loAev4S+udyKZdE3n8u8T9FGm7M7i5GCXD2+w5ZX9M+Ix2R+NXgvze2Ox8iIY8fZDp3cbxFbz3J5Vt+zq2WD1sz1/ef08feUr8x8mN18GVrP3VM+Qj2WnKMiSWMeF3N8fDF6RWPuvOfN38O6z6jzlZCT7dRYV0GKdxlqLnFrKDro6Ss6D01spjHFNVwS0K+IbsvLbuu+pfh1fkVYu28Pv07jneS6jJno6xL5IIBs0KY8FzRX/J4Ek7VsFFr9GJV8DHZGyUzQ2Ye1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAnjEavPaGEqqNG3+MINemnc5Issjt1Sh/157HBTtCE=;
 b=Nrua7gefR+QS4gzH0OcpUt6EOPZYRK/yQ9LJ7mbKiRz9f4wel5HGRSrsMFuPcSopO8UJcvZHNrsUJqT7FG/XnPloPQrztyxl7h+w7qEU2SD4YndhW8cySue7u68Qt2q/38Bb/npAGT0ya5Ap+yrDn2OuVQ5So/OtjzLZhpeaQLYFGXSPqjygY5e1eHG5k8THofzAsPeLOjnyzqhsWR9Q9Ae1pGDr5ovQbL14267a5SpNrVxLHW9AjeA1E4+bTdxBagVmXdlDaxhOqvGo1AHIxXjPt12dIE+Ezj5UQ5L5Ht054yLdYEGmY1MzuBwfUYDV7s/EmfrfvpdQ2idPMySwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAnjEavPaGEqqNG3+MINemnc5Issjt1Sh/157HBTtCE=;
 b=XP24tT0uRZsYh51jWLDrK6acPTENS68BCCvSeuqGZHq27l0Uza6Tq/vrLIHFk6ScT0+L+oYE+zBN9P3HI4VfZvSUsji3ct6fTzCDZkYqJbVMdoU/hvXLSiSPdSO8BGXkfmW7WA4R4OpslhXOG+vZkN/Q2TlqY+krcApWwP+6KR0=
Received: from CH2PR18CA0044.namprd18.prod.outlook.com (2603:10b6:610:55::24)
 by DS0PR10MB8032.namprd10.prod.outlook.com (2603:10b6:8:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 06:06:30 +0000
Received: from CH01EPF000BE948.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::f) by CH2PR18CA0044.outlook.office365.com
 (2603:10b6:610:55::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Thu,
 29 Oct 2026 06:06:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH01EPF000BE948.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 06:06:28 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 29 Oct
 2026 01:05:49 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 29 Oct
 2026 01:05:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 29 Oct 2026 01:05:49 -0500
Received: from [172.24.17.19] (ltpw0bk3xf.dhcp.ti.com [172.24.17.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69T65lme1334950;
 Thu, 29 Oct 2026 01:05:47 -0500
Message-ID: <4eec69a0-a2b3-417e-9cf9-2dbcfbdc8ffd@ti.com>
Date: Thu, 29 Oct 2026 11:35:46 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Add i2c ignore NAK support
To: Heiko Schocher <hs@nabladev.com>
CC: <u-boot@lists.u-boot-project.org>, Simon Glass <sjg@chromium.org>
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
 <CAFLszTg_ob1mTz9=Nh0BHM-yZDDoyYTu4STzHgk5tWALyZ5yZw@mail.gmail.com>
 <4d4a46e9-e75b-4bc2-a0c6-88a0bbc13b3b@ti.com>
 <d8a62180-3baa-27b9-d98e-08665b00ec1c@nabladev.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <d8a62180-3baa-27b9-d98e-08665b00ec1c@nabladev.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE948:EE_|DS0PR10MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6ffba7-a044-4ac1-0c8b-08df3582c585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|261028144727099003|261026140227099003|261022105027099003|4143699003|261026121527099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rnpLG33HsoSCGbXkpeuCrMklHDRhIxOY1/qxRvNwvYH9iWjD8nVwpCw6aAMkjKsN7MZVrwY7RVc23El88sqgyM+NIZPIhbwTeTAySfPqyJeYEMwlHLjCHLjOKeZIVfamtqjfJ0tI7ClPWW6YWuczF3YHmGwAXgK3LfbRDFgbV/gjDphDUdobCLS1sBwYdb7c+AVBhcqUyojc8u5NvAlqfAUzi8Yymqkp6MYY2iv0sSgWC4PkE+FWe/Z26b2byR7oVwGXBt5Vx2SdOdPtyF7OIdrfzmaT88eEzN07OpIBztbx9JgbCs9WjE/kB7C55tZVWnv7gBIPRNcvkQziN+ZMFRVE2YJLGCFj3MX/ltotCBB08cJieNNedEvN8FRgilshHQH5QuoMVp5uRh1WQqLdKmRa7ZhEwU4cDF6XEO52gsGCvqTLOKJkvEsUID6qSthtKVT7WC3imJXrDwBYougq0g5yHoq9cAgopMLAJHF4jB0XDaQxVJBIijDk6u4k7ZGGcX+n+COZ6kN7Eevrwa8uRtUTWc6/1nq3PzbaP0iKd1x2QsGM7lSqx+eT2e2PGLvcJdNwegn4LqgDxtpNBx2d3Vtkfojg7o5OZQ7wjNqyhUl9Mje8k8ZjSiuvewWqz5af0b1c93VnymX2bTNqOI8sWOp/GjT8Xj8WQs5vFe3yQrQxmDOoLCrAqpAbhdqxqJOxVKjpnL5uIuzVdbaxaWcsrQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(261028144727099003)(261026140227099003)(261022105027099003)(4143699003)(261026121527099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SuO4f5n8E/gq9dZmBExcUcIdoY2tu77LyZFjMxE1EiDMOkF4H7EjPT/GwFj80F6T9BEwO0P+rTEjv21OciZBjErAF/kGIBrljKjjRV6lva1aUnc22tbevG6fb8J7ydB4fvrHGz2yO/iXvjBlFcOyJi5pyEZmMKpAWbHp8gmdr79Um7oC7wS/zbJFm/HFdz6QQf8Mig+Ut+2VLbm01OCx3ktMRGaTTj3fUqd03+c5O+yFfjRpk/fkgtzFuzuJ+GodpfjAeEky2n7A80/zXkyKb8DQqc9zwIDb9YjhBwlE1C1UaWbm7D11lGT+woepFwsh3byi4ud+uGQCqg4HLV91H5fqSaSROEtUm3Fs2Bs7AJz6ka4ALoLvXkyQSJV2IjOxBYd8vM/+O/onvSeYVAyFJVxERDb1zzDhh/JdkrwLinsvYI8DX1clZfU80qo0H6e4
X-Exchange-RoutingPolicyChecked: PU9I9rc3x0/YdJhEuSNuLy2OB1vmb8MMvj2tjvPpBo/aONqGLcSlYEktEoPISbd+AkOxtUbJRUQtdFtgm0k/mFQeuSLQQ1F+hqhX7P3prZUYs+AL2VfI4On3SzLMuI1uxc98qnSXdnfH8OWovlH2wyIjaUdc0aLZTB3waCmh7ykllRA+cUwPLTe4xhYEXsPdwN4lk29ucx50lRLe9ZuAmvotKKME9qo89wYP+LwXsrFVzzUuIWAsQldhg+g+Xqr+FTOVhDQ7C/UP0eVRItasplagQTsMa03MgtBR7ZLLVhUZHlhVZgsidmTtS68DLEPcfGWEiYQASusu8wDX7QH2JA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 06:06:28.4801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6ffba7-a044-4ac1-0c8b-08df3582c585
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE948.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8032
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMiBTYWx0ZWRfX0K9x8EPoFF3U
 Z2+eCRri5R3Bb1PNXX0sfY63Bpoaq5GEBb03h6mt5Q5hPYYpU0eYm0ImG4HKD65mHPZGxQwUPGj
 GAee5/BlTikywGomckHZ7R0M5t9rPhaMaPWpr62rs1EWJvHElZGCL8XwQbGNc6vQRi0FbuiXgCA
 xp9RFnafL+YkAscAo1XCLEtPG1N1NcQ0bWJJPcJUW1/nEImQlo+H0sRo82o+70BdPBx3s9UKd5e
 j9qDkgwdUhahSyMd0i9UABTSKXs69zoG4EqkNiV9JD4YeFmJNI5/O7MeVYszkJxiYyEdNtH4HSm
 FUdiWO3gVCGQ+OTHz3MYaN3zXlJ8haiDiVi05MZjZUVdd5+Qf6MPKC561WvKUe5v+4Hj/LyY8QN
 kfhmMyB2K7DbwJy/eMGCYC04mEBca2thdS1wRN8jCuZw9Qx1S8Krmr/CJnFrO2iyiWnYU4962bP
 6gsmrXbEDkyeY+yTCVg==
X-Proofpoint-ORIG-GUID: kC31D_53JPngvCMQYlYIecV0Wd0-f36W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMiBTYWx0ZWRfX6ahIiDLFS2oa
 w5IcP9ofaPUAQ6hxNylI8u6q9nH1Z0gysqaLBLUFsTrvToyjQYLezmOavNs+TeDyErhMjuqxbPI
 Kt1oiauNQwocd0TaLfLvCKdtBazK0Yw=
X-Proofpoint-GUID: kC31D_53JPngvCMQYlYIecV0Wd0-f36W
X-Authority-Analysis: v=2.4 cv=epNKXYpX c=1 sm=1 tr=0 ts=6ae2e28d cx=c_pps
 a=h5F5dVrtafxD4HcxutFXpg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=u0YkFWZAeWwYbTr9klsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290022
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27-10-2026 13:15, Heiko Schocher wrote:
> Hello Swamil,
> 
> On 27.10.26 08:04, Swamil Jain wrote:
>> Hi Simon,
>>
>> On 10/26/26 21:40, Simon Glass wrote:
>>> Hi Swamil,
>>>
>>> On 2026-10-26T07:16:33, Swamil Jain <s-jain1@ti.com> wrote:
>>>
>>>> Some i2c peripherals do not require or wait for i2c ACK, so the series
>>>> adds a flag(DM_I2C_CHIP_IGNORE_NAK) to ignore negative acknowledgment
>>>> (NAK).
>>>
>>>>
>>>> Our usecase is SII9022A[1] hdmi-bridge, while reading the EDID block
>>>> the bridge doesn't send ACK (mentioned in programmer's guide[2], pg 
>>>> 22).
>>>
>>> Thanks for looking at this. Are you plannning to send a SII9022A driver?
>>
>> Working on the sii9022a driver.
>>
>>>
>>> I've commented on the design on patch 1. It would also be worth
>>> checking how Linux handles this for sii902x, since that driver reads
>>> EDID through the bridge too.
>>>
>>
>> Tried following the programmer's guide but will check how linux handles
>> the EDID read for sii902x.
>>
>>> If the generic flag does stay, please can you add a sandbox test in
>>> test/dm/i2c.c, like the existing tests for the DM_I2C_CHIP_RD_ADDRESS
>>> and DM_I2C_CHIP_WR_ADDRESS flags.
>>
>> As per your feedback on the patches will try not to use the generic 
>> flag and handle the case within the driver itself. Will re-spin the 
>> series
>> with sii902x driver as well.
> 
> @Simon: Thanks for the review!
> 
> please try to not drop me from cc, thanks!

Sorry Heiko, will keep you in loop for future discussions.

Regards,
Swamil.

> 
> bye,
> Heiko
>>
>> Regards,
>> Swamil.
>>>
>>> Regards,
>>> Simon
>>
> 

