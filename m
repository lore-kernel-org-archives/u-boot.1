Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4C1C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 05:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40ADE6067E;
	Tue,  8 Sep 2026 05:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a__6WW83Udd8; Tue,  8 Sep 2026 05:14:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5A94E60609
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788844480;
	b=r4o7WVaGXP4D/K+zSNJLm4mJLfiX3+KLzdEvg5Qb4Uq7qrbFuzk9QQppb+WEq9q7GeT4
	 9O3grjq41B/VRN8wnR1P5d213Ddm6BLokBsXbR7mNGOMo7CdgTO2i8ABZ22VEZUSBNTzT
	 xvL+5Ge/pdNe1yeqhk+b3BTpb2QG21QRQdSxY8mZf9cOOCU2Or5BY8rUJsIk2YKKcGmRB
	 JV3yMqFJh/FJMIgcyGRSWnkR/epmSJebmRbyhdrxNhGPm9Zkl5Y35vL39QPetf1RFpEKJ
	 4mUYbQuEGowGIrRsMzYY2/MoJNKF2ArCowJz/Q4NDg/u66CXedYUzNKsVFEK/OuJ4mg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788844480;
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VIJz0ZX1aMXrY4IH5/wTPWUh9pAOFBEgrJbVuWq92SI=;
	b=FwPdKGwEjW+V3RIhJlsbZIs/pMz/9BEVQ2QBSUtdZ+Ar3Lt4mZUUGoBtKen6m2geQrPn
	 dC6693LfMsslOSrwS4WohlH7936tD9J6fdpl2BM5f14+Mtjtt9oe09LPym6uROa9c16mQ
	 STI547kIauu+OUNGK490+vQNi/V32EWopHHehYmfC+vYNXHW6Hiy4ZpN8NcFtq43pOETQ
	 CFZKlWu6+wPJ0W0uj9+PLfhOQX+sUUqEkKXDSjU5tGF2ETEFuSaBvGO1toUvCOUX6A27P
	 I5Kudgmb5+nYVooquHKOWdtxaXKXZL9hm2+2RfVLkVwtqAev1F2frlRUp+uoy1vX+sg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788844480;
	bh=VIJz0ZX1aMXrY4IH5/wTPWUh9pAOFBEgrJbVuWq92SI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hp8n/KwAlIwedu+ZyBsju2FVlr7Ol+Awk2ltKXjDvQT1dslIROCadPbcoYUOMzLse
	 dPpum6X2p9s4vAZXpsyuiq38gk7FGnh//bGyr19nNb3DEiWsyf9EJ7zyK1Rz+Zl8WV
	 K/DpqvtQuU9v0F5f4F3+GinlyLl2x4hUB0N8PPbtS+wmLWlQHeN4eohZJAQ+t41jo8
	 5NASVfxKXPQMc0LOphiP3MLaE6siujx6SxbRzMfZoGRZdpApR9OyseB3c2f1robrJo
	 XR9FdNPJ7rzTXYpXlVOKVvD1SsYm5fJfdn0CNbOyesl57RzpEKVpNnvDL1dTOg7sz+
	 ue5m5FKAFM6Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A94E60609;
	Tue,  8 Sep 2026 05:14:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 32121A48
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23AA980815
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRcTkU2GBViG for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 05:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3597880807
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788844476;
 b=HqcDrwLvwbRB19k/MfUH34H5XQH5WKXJRvm1MxrQildeAVJziWf7f0KnDWZC9DrMhdIK
 741d9nWzY5finV6yWymEwmDzxI8u5HFubi6R9pzB2S2sS6EjvFZKJDXch6a7AIh9WLvqB
 qu3NsjLDElHI2ITX+XIH4LwZEcZz1KTyV/yW6UoWVRSB2ua0xE89seV3zwCj652aLST5w
 833xJztcm6g//YTVujgdyDQk6siLwAE+6acQ2oN3KGW3vcqTHDwDc8/ppBCzXbGz5rbjF
 Ky5SlnHk7xdilUmcCTzfAfuwnMpu1IC5jKM0iraYX8RTakAaBSz7+XEj2zi0jL2X2Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788844476;
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
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VIJz0ZX1aMXrY4IH5/wTPWUh9pAOFBEgrJbVuWq92SI=;
 b=J2q42uFb9nelAiYxd4ezNg4BzCGg90YUsuJYWMqyWgWKGksyO7s+du7nX4lQjvD5Genr
 NbDFdNrmSbY4bSIeKiMh//6xTU5df5d5BEy7rEdcmxfEVopJVe3KSsHYeyKWomTHAJ4OC
 VH9fQLe2VGZGaapItufoaW35IDslAJTzRBor7VDzEb1I+VCvBoAo+QH8j92NrxDtLzBzf
 ekmdaQpZrYtXTXgT+Ba0NRwGj4wewQkEW+XN72H9W7EZ5JezcJbxA6NISIJucUbuAy1g0
 bVIVHRnTnAjzCLs3aAEQd22yKKHH0hG5nYk5NczuAPGaVlb6EZc4JoZQWOEplsD3LJA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=q3P7Gwee; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mPs8ohbu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=q3P7Gwee; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mPs8ohbu
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3597880807
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:35 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6881rf6d714707; Tue, 8 Sep 2026 00:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=VIJz0ZX1aMXrY4IH5/wTPWUh9pAOFBEgrJbVuWq92
 SI=; b=q3P7GweeebafBxyrEJI5WVpZI6Lp/S/426xXg/vGRCa8JspNOcLLRsOPO
 a9Vo248gqB64vvPIP2jB0m/VwegMY8Ng6EI8KkEWOM7BTNnvH5ZrowrFO2txzha9
 wEEepo17o8ZmqMpvYeACYQ6R/OHfQDXPuJ6LMqXiSHjDG1VoTAn2yQQj5yXv9r5d
 6eNXXyreHdiGfEWdaR7UFlm/amttdPEZmH2/Ct/4Tm3IFpkwdPa9ZOsg3cGcrurt
 GiulTLYMs44KYLAVY+cWLSmW52ZyH0QYx5Be0d2kSxGTheKpC2L4Qub/YbxMIkKe
 kJ4ghTrhozqA+uHmlkmioIfxMKk/w==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj93q8spf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 00:14:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Loq3kedGtRdLAnro8ajrNU9V9m9A7ydSHXPHNXq5VZmJmQXoRVhjlVwwURLowDFX1+1QS6APSE9NOdTi/REY+AbSmeES8wfl5fOfZa/rfApltL3xkOzL8in8dNrzCPjWPHnSVIjmo2bsmLdAz2LDVCZEor7aAoPdeIEstt2Yo2ZCxDJMKvKe8uSkTy0ouvwmeeGi8q3LOnct7AWsFnFDQVHygejWCHCVSxVq/XH31Npebr2lS6mt5CfwhGKkdI5E418itmPNWttwmIUzSNV1B9qE2mTCF5gnZkYQWRtofXPduzeUPbtZiooA545jtevJh5YnDNxuLANG2I8nI47jWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIJz0ZX1aMXrY4IH5/wTPWUh9pAOFBEgrJbVuWq92SI=;
 b=P2OUYsVfJuJ4Mz4d70pCZzTt0ifztJiEUoF+LkjhpL8Qi2elW+P5h/4nQmZAp1MwHiaIylJUKZmoLKtnc82iQoR/b8vxUK8lg/+q41q4eokr+31t/VdkRmpYMd5u2Es7G0K2X7pcKfZGPB+kchcy/U7IUwfgFkLrq4xtpaZiEGbpSGJHi1hyYv1oj4EiLwnuKYDBtLm2CaqYOPMXLHE3hMm1VzRjc1dRXn+EZl8lxjWFBFCmFA4rxqEzyYcAA0zaX/Xz6MCaa+nEP67hOq6bXwdDlYDF5DoU7QN8HABRV4utvK3uQfG43tHMA8wmERDCP/p/tANsC5qHf8m/VhIVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIJz0ZX1aMXrY4IH5/wTPWUh9pAOFBEgrJbVuWq92SI=;
 b=mPs8ohbu+Lolk+22TvAas2qKuE2qgDzvntYgGA/6AOQX+2JHsRXFcqeJrOxYYSwI1292wdY+ar1oE9xOMqAF7BwEna1HwvkcWv110881O/PR8P445WVv5EN5UCszkHfoxWKqAk3OQx110SXnTEvlPQ6HyF5SlDV5ZaZ8Z+h6+QY=
Received: from CYXPR03CA0094.namprd03.prod.outlook.com (2603:10b6:930:d3::16)
 by SA1PR10MB997583.namprd10.prod.outlook.com (2603:10b6:806:4b7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 05:14:31 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::18) by CYXPR03CA0094.outlook.office365.com
 (2603:10b6:930:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 05:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 05:14:29 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:06 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 00:14:05 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6885Dwd62811953;
 Tue, 8 Sep 2026 00:14:04 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 2/7] pci: pcie_dw_ti: fetch num-lanes from the device-tree
 and use it
Date: Tue, 8 Sep 2026 10:47:27 +0530
Message-ID: <20260908051741.868824-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260908051741.868824-1-s-vadapalli@ti.com>
References: <20260908051741.868824-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA1PR10MB997583:EE_
X-MS-Office365-Filtering-Correlation-Id: afe371f3-7c67-4925-44d6-08df0d680f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: zyTGlKHRKA44PQUPiCmbY0xk3qvKweyXWLxdP3cm4E7kUNjb28B9b/96ZfXsHe1GT5fvDMmjzGRDOmKIfUk8U/9rMu29xlxF3LmWtinjg9ubl7DbhE0qWBKhrBXsU9W8DXiaP2yIWYk7abX6+bjUGDimI582Q89Mf1rZKB75m8pv1JaYvfQm0Q5w/EdW9ZICYQY03Oc11biadb4UxRqUd824MKjQAfUs0GTVMHUarDrG8Dt7trAJz8otZMCfRQjWZDKwPixkoqFR1IadJcwTuR8t2Fsl7xbpUjnmYu2Pf2bRAZaaZHbeJEeY8hfPLrtRu1xDgpK2td1Fk5wLzuCG8DOZbe16frofOhG+EQ+waY8ZRjo9Vq+RWRPipvFb1WSxN8/utxPPp+HmseBggX5mQ4KDA09gArg1/3TFE2L6MgB4E8pQkhgqu7VmCmJntS5hSTQTdc5fuYS1ig82tYWaiKIR2OWbHaJiWhBLhPeCaOa7NABp6WH5mSKcqWmegB7pGF+gNh8cgxU7b0oTVRN4wR74vCzml4nDhRR+ge3z2QJFe43lwx1bt7fsTufZRpj9vVCLpPZ9vqUmLlkTFan375t++iyzj/lrZm6Rt636FClj9MO8z+sqdYl0pNYC4vjsuwUtFNsuGosu3NdPEnK1qPUvEvY1iPy68+alKZpQiDlAN8QyLgcYmvRgGvHmaYA+mckfdu3/HmmWQ2RginvEJg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TTtv8OIX8lHhM6H2pKbEDKro2qVdClFeMFci4DH/NEGO1jV+z04ouVvm9FmleP8L9SmDzbUwicE+Q2SEjFrGYm3BOFmMQ/61N5PnZ2dzP/cz33XMHp5UETaRYqFxgzMbwuJf3nTY9uo0DHQrOL+7jOvwNfeYaD5BSsf3QfjzLtg4yjqYEX79KzBGt8byWK6QeGkvK5mgtkAHaXfnMzBvztyWYqpUVSahCiiVmutlSvYqVrxOWZO+W1NTGZoa8vi9kFu9pcdTA0JwnOADtEpX1SLGcHcf/ndRb7FUfK8pgr7jb78R5C7muGFNc1CKUCKkGZCq30S77T8NmQAFaCQeppiQuc8L+WQIvSUCXo1kiGz2qZv1z7co2ucvhxJaxM3Ki7vN+ojOGzcL90ZnRM6Zcs6nDmo6/i4QjYqejvnDtBq4ASsFk9wpPZUgemKnN1kP
X-Exchange-RoutingPolicyChecked: 3to1sBdrgpHFsN9t0i1zo0QNzoNOKwEZQHNWdi/AWNsHldeNNDg4X4BwyaCcUomd3MnjFJv3XZzOZ9PxMynTwB1h5w3WQ9l953XPW60Z27RzU2UIVe0kPf3rSSaqqiDJREvDYdzBWH6C2IEpxb2QbaWv/6p8SQu48lOJVEkos7TW3NshGZKR92k0EZ6/lnOoNgEEEuZi/zzwAKE0jNziKpGWbM5WbeRLdeGwl9PNDYdovUC2xVHa+3yU4pTRFDTZE9yXhszFJMFTPTw25cq9Fz/NmhTsgkAQot8+qa/nw9u4ku4CKMQw/ZQRk8yVmWrRvCa+5cXZirZyZOwTr5p+9Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:14:29.5012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe371f3-7c67-4925-44d6-08df0d680f64
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997583
X-Proofpoint-GUID: zTf3ljfZ6GGkhx6z6LjrjihZhKsYsoj9
X-Authority-Analysis: v=2.4 cv=FvQ1OWrq c=1 sm=1 tr=0 ts=6a9f99b9 cx=c_pps
 a=v9d8l4VwGb/BX2RVr192eg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=gzyk6xmW-C9wgJ78c1wA:9
X-Proofpoint-ORIG-GUID: zTf3ljfZ6GGkhx6z6LjrjihZhKsYsoj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX/Y0hpWk8q7fI
 6nGRlD17A6CkNEOEvLquJf6itPOm9FZgNNNyCjDgdnCZEM7/kf8t0xCmsYgEGkWCLBsHOVA1t/h
 E+CDks8zoG5/HM3/uj9Xj64JT+Mg8w5T7CeRT8peu1yODJmFJrFMJMLZvJq9MiUQZgG1J6WIdjQ
 /z+90e+IQjtCqDS3gomCaGifJ/3U81mXskGgqN18El+bLwUGM1DZ/J562IiWNRxxSKvOO2o9IzV
 d6+FiuHCoPEeBxT6E84aQ4R9KwxfoSQcEI09pa8mEbX0s64VM1dYfk7ghyABcc9lgx1aEB28g8T
 9bBL8t7vBdCmhQHolZy5eudg8eApWbyHm1Tab75UcVviNWFYU60UBlr4p4UA+iW/Y5/mQNAPMcK
 xkigqFs/uK39/rcV0xF8Lq0MhljbmSjBtyLKHX3bM3k/sFEPZK/hqcckmOt8eEyv5s0MfDO5vnC
 b0BkM0ISj5YYRDcns7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX9f2Xrhz8l0Zp
 4KJFx3PPX9c/fj+Q/TMx4smTIaQCfpbk6ik00z1xTidMJgpS/v4fEGl1TmnGflbQrQ4fYHTjMfn
 9J5GAPFYn/SIMwlz6Mg0kUPq4b0Q4sI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080055
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

Currently, the PCI Controller is programmed in a '1 lane' configuration
unconditionally. As an improvement, fetch the 'num-lanes' property from the
device-tree and use the specified value. Fallback to the existing  '1 lane'
configuration in the absence of the 'num-lanes' device-tree property.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

No changes since v1.

 drivers/pci/pcie_dw_ti.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index 37c295fdd38..fb39132f7c1 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -58,6 +58,7 @@ struct pcie_dw_ti {
 	/* Must be first member of the struct */
 	struct pcie_dw dw;
 	void *app_base;
+	u32 num_lanes;
 };
 
 enum dw_pcie_device_mode {
@@ -278,6 +279,8 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 	if (device_is_compatible(dev, "ti,am654-pcie-rc"))
 		pcie_am654_set_mode(pci, DW_PCIE_RC_TYPE);
 
+	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
+
 	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		return -ENODEV;
@@ -332,6 +335,9 @@ static int pcie_dw_ti_of_to_plat(struct udevice *dev)
 	if ((fdt_addr_t)pcie->app_base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
+	/* Get the link-width (number of lanes) */
+	pcie->num_lanes = dev_read_u32_default(dev, "num-lanes", 1);
+
 	return 0;
 }
 
-- 
2.51.1

