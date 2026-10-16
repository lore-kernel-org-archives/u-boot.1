Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAAACCF2C4
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 20:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 327CC812E3;
	Fri, 16 Oct 2026 20:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pAhDV_vcltVC; Fri, 16 Oct 2026 20:52:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 267D081293
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792183938;
	b=EHBb7uVOj7H8RnXmdrs+FHt9tt/QuhmUuUXknG75h+4/M3RLpI2vYuOB4KTl/KnXReNg
	 8K48fwLtLfw1fC+he+Czfyz0rtpxDTwEKmy9qIyIuJ6axd4iC5U40zVjPF+m0MGGHndFS
	 swaSDlBoaKICrzoaPayk7PV4LpZyZIXQp2X3As76R6DfuaLLyCAfFjdidjm85rUtm75b8
	 OX4sHnAT2YoCq+uA7Fa4e63LFzF0j72jEXk/TlteKWRqu3IKVGQrcNnOcjJ4rTUAdGnn3
	 BOuAtwj968EKnjra83dbc/WHQGrZuAWhQO2f+ZDNroDnt9NHG+3tyK5HBBm5A6WpFuw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792183938;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xC9tXJi8hfpEfsuCsajWKoGS6H5xHLM+lRKgbgj0+bg=;
	b=jqmfUm/e45QaXjwH0MXNb1Y9Yff7jZL3pr8zgx/XFkTHciCW3K8V6JUfviqrj1VHYB3j
	 cvgHMokO2SlvMFZZdOINLlrz2z8uKVrzkKAYG7amf44QewFLixoz365B8w6eq9fsxBXgq
	 R0U8gEVeN/H8/JXOvWRpsEYmWNogb9CmoubznKK8FW2TAEdAUC/Qo+2tvwtmK/Zne1WcA
	 NduP9zMfqN/kw2GQFIhdgYdJaWlY5K7GjtSwjciXShzrMBhlKSHB063LTHLtU1ExcSGdc
	 /5khtJ2OIwOFnUKxd+B2e2KiRwqYVgPyQ5bwDRrolMbkV937xEToWWUoKFQd6cYo56w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792183938;
	bh=xC9tXJi8hfpEfsuCsajWKoGS6H5xHLM+lRKgbgj0+bg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fgsI7IwWZrCUwF+Yo2Ouo3m5iGCY57Uv9eh2OUwmJ+sJfbxtgzE9++Q43qerftdhs
	 G6t/9rLxXIRxiNJW9jpCD218yAdaebgN3kINyU2kofP5TY0kel1TFbDBb6amnh7usx
	 QDDbjgvNjJqoei8VM2D4QK3V0b8rH+znzStMpjgg+TyVu1mCg0YjF2NSz5Xfhv6h+C
	 IEvUaCGJLJv4eZe2/3IRMICt5VQGuIR++uzTn/cY78c/EOSpU6i+0chi6vdFJzBjtU
	 yq1r4KiKcnCRJ7TS4yawvK/cN/DGafOAGNbNFRj2kpsgSHbtip59MMWNVyr1p/WCmA
	 NR9ZeHWotB0cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 267D081293;
	Fri, 16 Oct 2026 20:52:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F406D362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F15FE40862
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rHuM8fHvXYGX for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 20:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70A2740856
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792183936;
 b=MpYa3e8T2RppT1LsiOpfk/2Xd8n5tbP9o/pxgc9m1futtSzugAPJLjyGHt6cu0QoIWNy
 99Ou/+9xgPxQhHUq2wfinmPlV9NPqqDS0dlCNXhPfSxyGmtQM/eI2RWxiaVEEqFcxDaBv
 QwSulk5QiXxOm7BeohZgzUPfJmf4n6/OLB9kMBRaR2ZxSSpoUriFx5opCCn5W/bR26FWQ
 gDIUXYuRxU7pzJiPyHZTlv7LR/2vfcxdF/NOQFk6o+AtF64OVZWym9u17gGCpiiKLgL8U
 QDLu69UYitYIaAfwRAAJBJzdS2Qeg22dX/YDP+iHFoL0EVJyKT9TqMMN2mhlaKxzrWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792183936;
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
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=xC9tXJi8hfpEfsuCsajWKoGS6H5xHLM+lRKgbgj0+bg=;
 b=WEMU0ZqFhuADdgS52lVrdPGB5m52mZlNAjsrQEEN0b3dMi/tGVFTO7qvD9FzgSdX3zy0
 X8EyM69C13OJWlYdOlJtYeEr/LaC3EuK2al/Q0RPlA+OvMctAVS7bFNtUP6c9vQVJTs+z
 +c45aGac0x6GgxxQfkwPBvDWmQbp0vI3RpMYFWCkzF6CZyMhcBgxB6W8DbRIOx4NjnBuK
 SXiQS9A2/0HepprqDLpgR+Uqls4pR+85KeUH0jF+UQg3VYgVNrhFqTu+bSKGFs+2zqu68
 YRTLlohs6AhUWiQFJ2QpQLdR38XcI2XCkhGQOzUkv2b7rwDBeI2JlVGJBsBE9IjYTWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Xi2OEvUj; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=n1Q3dmtt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=jm@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Xi2OEvUj; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=n1Q3dmtt
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70A2740856
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:52:14 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69GJgqpe556385;
 Fri, 16 Oct 2026 15:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xC9tXJi8hfpEfsuCsajWKoGS6H5xHLM+lRKgbgj0+
 bg=; b=Xi2OEvUjaGJceBkFt+S3Ed9/pVev1hMbSL0dXSY7If7JPqZaawV83y3pb
 w2N+TS8gRYnLhZNHhGD+3kS+aNQQz2ChTiMut/DKvG71/UnhasXJJDF5Ox1SOboq
 BLeudJpsS/aW2anq5Q/2WjnMpw5umX+G8QWz+otDmnEP6L8P4HXrb6SN/Um+XGsE
 qBeY1U2+TwkkGX8tgOLIfsFEXryv9Fk/ljylIQ0JnaQoiEYMq67464DhNopXPFow
 Dk7yxTygt1XYjpg+l/fEY2DpvVPSUwkGcCUGmvm0r8w4b6YU2kjNTbX3z4Bh4/Ko
 srPjJMJX/MWbXXE7hyIsD+DAlYcsw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hbn5024yg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 15:52:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee+hRCC/iJAtfFxHNit4+4KKDn7DiIzOtvC69P1uwYJUlB4PHV/VKL6+Yq3SaffxugUf0iEghrSHfp4W2pd5E/IYwm6eeAQ2oj0ao0rLjwzvl2TFWJueyvPb7mjjT3cTZrRDwMehgasAaZFdTq/ECFne9zWJubPvkdgRzk4d8ALY8jbR5fh2rXJyQgXxi/32FTlx1VZbM5J30RZlKJl0bpPULZUd3ucgSrD127kqRDSEt3RVKmbdOKky16xWtaMAX2ZgeEUo7JCM7ypTWuXTZmN4sN8aTf566b1mXZub4qzeaYUKe9z8NcFym4xPKi1qgW2DZz31QfCkx0ovs4LtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC9tXJi8hfpEfsuCsajWKoGS6H5xHLM+lRKgbgj0+bg=;
 b=yR+c+o2KG2RFwzWn3wn20C+r917PYplP/WQ9NFO1b5HQKEPvhUWZM96VXTh5gsz8GNdBww+UgpLiMO+rAEWtmjli2TDy0UHxTrTDI3AS7G48B3wi1KqK/eYS4SbVKqbX3hgLqqYDY9AqIDqa5IQJk5PSaFnUNec3JU99PFebaw8uCxOtAGezO+gdcGteUyq0xaIbv0e4WGM8HnPF3g9tTW+KpMLPRvAAq9A05an4iZSb8j2qBkrovhIyyCqJkzJi4YTzYm7Civ55Kh/JSViktRv8DluUlJuZGHApEjZYH8l9cPFUvnG1MrBa9nhY8HqUukGnQEdcDOiQKFmttey46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC9tXJi8hfpEfsuCsajWKoGS6H5xHLM+lRKgbgj0+bg=;
 b=n1Q3dmttzn+ZGxn6ZpzUWR5OdFg8NsLJZRh5Yc6m7KQMKXNM6GGm9lFGcZZArdLbDMEHF25Q3r8WPud8qAUikFrY2Rl7saCC0VtvHFCh0AmWcirAKi7ojAaGvW0S7YS1wQ4GLiC6ZkB3FsjFoC89GjnesdJOP3aXsJ2rYTIa1rk=
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.11; Fri, 16 Oct
 2026 20:52:02 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::5b) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 20:52:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 20:52:00 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 15:51:14 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 15:51:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 16 Oct 2026 15:51:13 -0500
Received: from [128.247.81.105] (hpz2.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69GKpDcv3203733;
 Fri, 16 Oct 2026 15:51:13 -0500
Message-ID: <4c846989-d5e2-4091-bbde-4d2de7a8c3d9@ti.com>
Date: Fri, 16 Oct 2026 15:51:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm: dts: am43xx: Switch to OF_UPSTREAM
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 "Andrew F. Davis" <afd@ti.com>,
 Nikita Kiryanov <nikita@compulab.co.il>, "Peng Fan" <peng.fan@nxp.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
References: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CO6PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 001576e6-217d-4cf1-3993-08df2bc7538e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|22082099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: oVbvidT0wYGg2/n1pu7i/xVdM4Roj0GikCJsTWZkYvYGzNm/GLMgB6dEgzAejGged4VzEutDlFILkxC5+gUWxtp6DqUoZj8+JOjf0jZ0Yl7uB9GlMnCcENcZLjvS/A9HMrWjv2DuDDGXrax6qsTNnm4JY2YoW06nrB4KZqcx8ooKFEMvncJ+PJRpGDXTxuGYWpqoR6dB2LiLNEaZSQWs3JpcisNYvQPrCELoZ6Hx0CodLA11onoL2ujVuv+msg0+sdeyKyM1cD90ADkQaVVkf0UzIDeQIxtlJZGrsMCpvMnIBpydaINjxrJRIVB/W4pIVK+J3b6edGia62hV5k6IXPzkSy7MbXDLRkhCpvN2ZnXkeaz8+DXdqBSA1upOMcwPM5rpRXba+8pBtnjw71ENMAucv3hDJCOju+ayJ2nOAJLoeXgA1dKogGRg3OdrcWdgDiXXUGmnUBmVxFaDt0mPbrul73mDGJ+y8UxkyjsFynp94mYikRX/kkezHzU+rBEKB6gjjBZ9JzdUhufmx9hyxBuXy4rukjLBnK2Db4/OMhkwhtWH7gQOD8ibiY9qJNq5rcLefBOTXFrpS8wgvfSiFdEIReN7t9ZlrssBiESfw86k4QQhtNL/WR7yI1uW9Ps5Zjm9M5S5/yMry3TwNa7fjA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hija74RXxEVHhujNSOoU9IJdiM5z0CDPw3OL8UpLV7+PVSwNAQ4rpbtWhy2xx5ENUX6Aw6ZiRJKYo40BLLOMQ0qlzdkgy0/sdgFuG55/C+e/BJEn0+PmIs9/D1kz840dTIo85nQCrDDmlMv74PMZHfndfTIFJpJKqq9ZcpKgeAzLPAEFhs3tPRKyBZvGrSt/iNMyFs7I5lE9FlaP/buaG4U6BhCk9UTfTIksyx3praZ4TYvbWLJ/h9plyScyaJNVv3HTnYcP/s0MmGAxzdn+GwZNsL7NfXoYfY9pL/M0ZQWWvO0o8lhz1n3NbEhGN6ukgwjCdvBAnu40yHzB49sWKJaCzVwY+5t/OOtPIG8qxRcy+SJ8MUgKCqVy5mFQ6sRhWmI978f01Rd3wKlQ7H27fgyMrKMpFEdUPbyHQkAO7s0iJrfoRLtFcAP0XmUSp7Pn
X-Exchange-RoutingPolicyChecked: lIUBcTCcBm3Br0s3V1bOhc2T5OFYgOeE/CsOAHjSe7Si7KJWWa3wad1WYDVQzBpBxMYEjJhAV0gBSXphOfvOlucWWVVpH7P+WyKAsVJ9eWQHHjlmxdSdlxGwYYi5m187OiRQREBRNS578wwNof6qfIjalpn7RRzMlYTF+ffKIlb1yzz2Y2D94TK1PTN2hC7ESICpd2yrF69+bGzez5qoM0CUwxsSatt4oMWwutQYpsgdHjJut2G5ebi1b7sueLuW/OZjqi89UwFxR4p+ns+s5lWe6jSvAAn3X0R/oQa7AoAXUKPRALNAdhU7bDnh96xxUzFW7718YhDAlfU6jCZDJA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 20:52:00.9323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001576e6-217d-4cf1-3993-08df2bc7538e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MiBTYWx0ZWRfXzqfSlU0se+/2
 ZRqNNN7Uuhda7diA8Ig+vkxxy+WjOGETXKSEUve0jYZ3ZUShBFoQK7c4hXp40tcv1t/gFVKZvJN
 jIZNJUmAOTzCaXzIcAHrgOkEk+hNDZY=
X-Proofpoint-ORIG-GUID: OnhJA0HKxhoUYv0hlwflrmKN_fm8agqF
X-Proofpoint-GUID: OnhJA0HKxhoUYv0hlwflrmKN_fm8agqF
X-Authority-Analysis: v=2.4 cv=IuOL47/g c=1 sm=1 tr=0 ts=6ad28e76 cx=c_pps
 a=XX75RHJXRTy/mnnqXKIK7Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=bC-a23v3AAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8
 a=htUr5R5SYCvxQ-Gf73IA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MiBTYWx0ZWRfXw9s/yXdM3NBI
 z2rNavjr4IV91VWLxcQ6GkBCz0lqOonafbUH8tDDvSUERoopZMnQ1npp00WOt8l+qkWnjar6xQm
 5/VWzrNBNO68gmkK87mBAFRE5NATKImDzzuPEletmDBdOkYjjvpuIyLWXZcRVEW9SLB2CuhiU1m
 v9jCjgOhozh9pI8pZuJBW7ApxkS1etT/K7B7dDuy/QOFqPSgPA6iKk1yM6Ss4aesBDZBg4Yerkk
 1Jbr+aXU2Iy0E+6HEnyiNNk0o3xfT/U8GhHQhY77ja/r/Y993PA9RdY+aNjs9ybFW5eCpHEtToz
 EZMBK0aRO9WTU1o6xoXpQaN+8+EogLIKo52Set5U7XFqMw/uiKGJUtHNX2OQxJoDOG8BrBa46H8
 xjq873D3pGlBonE+ZKn9Q1ME/W3CN8ivbaaTU+iz64JpB+iiMsLmjTEFcRGBiYMfrMvUN79hnzK
 Ba6jtKgAjDkWHwRTvcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160082
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

Hi Markus,

On 9/3/26 8:43 AM, Markus Schneider-Pargmann (TI) wrote:
> Hi,
> 
> this series does the final changes to switch on OF_UPSTREAM on am43xx.
> Mainly it adds some -u-boot.dtsi files to define tick-timer and other
> necessary pieces. It changes the defconfigs and removes the old
> devicetrees.
> 
> This series depends on these other series:
> 
> - clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates():
>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com
> - net: ti: cpsw: Skip disabled ports in switch binding:
>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-cpsw-fix-ports-v1-1-764e97251ef9@baylibre.com
> - mmc: omap_hsmmc: Add "ti,am437-sdhci" compatible:
>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-v1-1-24299cefb42a@baylibre.com
> - simple-pm-bus: Fix clk -ENOSYS check:
>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-simple-pm-bus-v1-1-1b16c8f95051@baylibre.com
> - bus: ti-sysc: Prepare for use with am43 and OF_UPSTREAM:
>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com
> 
> It was tested on am437x industrial EVM with mmc. Help testing is
> appreciated.


I was trying to test this series, but ran into this build error:

   DTC     dts/upstream/src/arm/ti/omap/am437x-gp-evm.dtb
   DTC     dts/upstream/src/arm/ti/omap/am437x-sk-evm.dtb
   DTC     dts/upstream/src/arm/ti/omap/am43x-epos-evm.dtb
make[3]: *** No rule to make target 
'dts/upstream/src/arm/ti/omap/am4372-generic.dtb', needed by 'dtbs'.  Stop.
make[3]: *** Waiting for unfinished jobs....
   DTC     dts/upstream/src/arm/ti/omap/am437x-idk-evm.dtb
make[2]: *** [/home/jmende27/src/uboot/upstream-next/dts/Makefile:64: 
arch-dtbs] Error 2
make[1]: *** [/home/jmende27/src/uboot/upstream-next/Makefile:1442: 
dts/dt.dtb] Error 2
make[1]: Leaving directory 
'/home/jmende27/src/uboot/upstream-next/out/am437/'
make: *** [Makefile:189: __sub-make] Error 2


Did we introduce a new am4372-generic.dts? If so, cannot find patch 
series in lore.kernel.org.

~ Judith

