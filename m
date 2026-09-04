Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE30C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6B3A60BDB;
	Fri,  4 Sep 2026 12:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PaXmL88rdsNh; Fri,  4 Sep 2026 12:03:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7321960BF2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788523387;
	b=OTnwo5Tf/Ln68esMuTJiU4wTZRrQJSSB9Y7dAWBaQocTApgveUDmi1OwCiqE7I4HvSJB
	 25ha4ZbOiB/Ni71dLXN84gN1U3TDE7yHQ9RNuuwEae7kGUplvPGVn0/L8rclrUpgKa0dF
	 F7Oj/RyrkOPOZmF0HB3Ef7c1ZKoo4XFXTCam2tN0n6jMxHzJLMVZgXyEJvcEza+exQGLD
	 tJpoWd6+1V+jr5UMN7OXO10upb6ASkD+IGNZvJRzWspTPrGZ/aPlso8kv0OHj80bTQGAh
	 EQzTgh/qNZXZOMr8puU3s+KKj9QLlKvyQkK9Xbg64QS3ec7dCb99tkwGHlVRrA6y33A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788523387;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GY08HMdC7ooA2kUd+T26FqKGYL8eAjJ99zU8/3is9LY=;
	b=bmCficiQhH5cIvvZcZTEqMJQawqHzTmNwtTKiw/38hbbQZV4YlqO4lTXCIpDgUo3I/Vb
	 8JmH1Px3IRQzd9W3KWZsOxKqThxyplFLcw6z0J6OD4st2MECqhdCmleMyLNDiP04wMAle
	 jL8fJq73axN8ucvVCm6XAUv00X/hVbXZi2JLCRx8p1LHy7s/Wq2eESlLdIwXejU0ZACxI
	 YGmgS1uNu7FqHOwLa+ynVp6g41+EwHNPhPPZ2V2KdGpksvndPAb5YpSBb8OlSWol/PDN/
	 JX8rMtGCcStD9HwcTyCttHYVCUL8tQQDJB6ua9OS534uEzDUFm1pKpo5tYYQMA0n/RA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788523387;
	bh=GY08HMdC7ooA2kUd+T26FqKGYL8eAjJ99zU8/3is9LY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROLIVL/fwE52CBlZBvfaLxXZI3CSW0NBHdld9y0wXvDzrVKVHx904rK039jVMCO2A
	 Hp651tnUnVt3Ei50P1nqOeuQxyhg+cWzrEwlIc6wLjRVpSFnkaobl9+W7/Nb4ln5Io
	 nQ5LQUL/l19FYoNazonZs+ylMn60y6rstC7TxTFHopfatZEgTn+ECAZXfnyY+IL6Z7
	 32KCYNwV0LGBL8cdufD71SvljhxifHlzpEbmt+TSrdKie4D9TZRO/6GMyPcLMoakVJ
	 K3AH56wHGa2uOXIUqo90h8kWJDPXZPvuJlJfhijVzrb4CHG5LtwAYZcQVsvasm2B6c
	 QLEQ3oPYKwkFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7321960BF2;
	Fri,  4 Sep 2026 12:03:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FBC877F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 360274031A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w1Kn_o11VPJL for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E5F4140080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788523385;
 b=WUoMW3JkkrjAZKwMxsj7btwhiFLqcZNGuz3mmgInYH0elhztxYBKPKWLMIMlw/4KZEIO
 JA+x+Ibf+ziZED/ONmDNamjQwfgRKCbRdfWCMY1yhVbTjF1lqw+iaYFytQD6yh/AykWru
 tZw72IdsABfPtHjpqVrQIUIy8bTpXf1QK6QzBAKHkpGnM2Ast/5Ca929IearE5Ct4Zx4E
 6yvNRE6DlWT4Z/m3UgeRKTVGtf3niBahycaGEM7mgl2FMt58XORqIn61xbqPQS2ZQR+v2
 Z5P9V1kCAof2wXkAnazhdgFTt7w8q/qofMXpE8HOcmeGeNs3imaaSQl4dLefvRnr/SQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788523385;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=GY08HMdC7ooA2kUd+T26FqKGYL8eAjJ99zU8/3is9LY=;
 b=ohV1SvQc8tvF0yVOMDLMOu4QkCizLmdjXc9fr+nny/UrzPEsEvj0EEyc+VuAjWeSwfwt
 gebBoVFhjnXJHXFkGs05W47ORCAVA6hEzMvE8/QUvcx1fQTvAjQEQxGoC6YKhuYpia5pv
 h/0roLLFFSMRTzpsW+dNrZzvm1IdR6xdiH/rwJ5y+RNxFFeo+/yQqXDmjNTwHLFtKLiJ7
 t8EvKnN+391CacZMrX3IVGO/mGwoOItieyMsjFiLWDOOr3BgC+lOslqAxxW/gZn3f1jJk
 zba5YFa4n3nSN9K6BX75Z3tVZmMwAYe1aXwhMs7bdPeGiMci+zyzcROx6CYgN99BfTw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=QFlKCaVs; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=UiRHKOTl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QFlKCaVs; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=UiRHKOTl
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5F4140080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:04 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AHoCf3238091; Fri, 4 Sep 2026 07:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=GY08HMdC7ooA2kUd+T26FqKGYL8eAjJ99zU8/3is9
 LY=; b=QFlKCaVsdk+/7zip2DDd5sCGlnTDeNGrUaH1hcZ6bCmaw3uyKpnK9N86Y
 nD+dBCXBiKhowtCt3ds/prCE+bjm+IP6asWpvairFXGUw9js71mBb3jL+G4LDSpR
 DLYQcjd05MwZwzV+GV+rHnYyn9HBTKFe0fL56VgOVzq4SN6rCHT3weBLSo6RljR2
 DgtmT1V1nnR2XhRAzyWRtJA9N+gQdhFP2Fu/cXj3DPjGo9yCgLi6JJwc5yse1X20
 PCUGNjirnxSV7MtOIanj4zf7qb7bb0ixdEYilBSOeDGZA09g8iYPsuNtaTt4YunO
 4ALl0q4rbRTQcTFqHoHfrF9OwH6zg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfu6w8sx9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 04 Sep 2026 07:03:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUlKXEoLnWVgAiNtoXq75lV49LDCfM5CzMDbAEt4F7+NKYVxcfqUfjC5JeAh3z4deLljfbXC72OlKElUEsxoQOjoarOuH+4SLiYGHwiLci9oYybgfr5Vy+vXFJfJQ1DBei4c0hHPiiYOE6KZv2nzDKeYfELPU/hbV/ZVfqVHiy6Oqrgq/tL80af3Gxvk4irqBaRBHeDxe6efLhyiCHYDtl3VytsCy07+TrCwHzaduw21APLHtcTFLvxE6+jPfPRrHUXItz8yADsjqUVBgVtgNLu62BdsyoeQvKDNKokKd8TR2v4wi3kzrYeociCnZGAWTqWw5qFTT4m/w5/kansewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY08HMdC7ooA2kUd+T26FqKGYL8eAjJ99zU8/3is9LY=;
 b=N8gvT/doT/R5mcN5AARtcKOo9g+Abwyzghi/kJFfJ2LWZlMjh5ANjZZKnuKEvdL+rK8YExuiUtTZHLs8sQXitgQBQWIf3OBQ9Hxoa1k6rYz+uahNNgcJl0KF9I0mLku8LWFw0+fTfDm1vzapk2ZOL4n3WxhQs2Iw0v9+AxJQpJIa8JCvlQfNWI5yZGqlJfGnlo6eJS+HYhoBEABYoFrudhck+z9fe9i8FqI7PqURri0t6eeyD/WtIv7qRifz5mIvOUgV5JxFUiySo1+Wl5HUvpByPtzuFzKyiLJr2YdvQo5RvZOuga7L4cd6t7nKV3mRlAWI2wxV0st719tu5HEfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY08HMdC7ooA2kUd+T26FqKGYL8eAjJ99zU8/3is9LY=;
 b=UiRHKOTlDCaNsKJzMlQzm9/DAoOT16alE2QX8ShBvfFXbUGYYaPJs3TNTmzzBX7vtG97dAFJRDRj+FYN2+Hitcrb3xK3FQG5p5zjbEapdl/F7FIdJLR4BO2VhWH1ieltdsAO/GVIcoYcHNz+l8P9XG7Bhyo8HfwzLaz+i1uX4dY=
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by CH3PR10MB6904.namprd10.prod.outlook.com (2603:10b6:610:145::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 12:02:55 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::7a) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 12:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 12:02:54 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:40 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 07:02:40 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684C2NcL3456269;
 Fri, 4 Sep 2026 07:02:38 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 6/7] arm: dts: k3-am654: add bootph-all to gpio@38 for
 daughtercard detection
Date: Fri, 4 Sep 2026 17:35:55 +0530
Message-ID: <20260904120604.3612484-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904120604.3612484-1-s-vadapalli@ti.com>
References: <20260904120604.3612484-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH3PR10MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: db718763-3048-4ba1-0e96-08df0a7c73ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|18002099003|56012099006|22082099003|10063799003;
X-Microsoft-Antispam-Message-Info: 27vdok/5sgXKFNYdzWBBqzkLd22Xg6vUU4t6VRdWRtdoUQ/HY2I82Q/L+3ayOt4cltuT7/79TbReiIyjf3bLEctxCfU7EF+enSPiAKZCtWQpfGxlF42MwGcm/+ccxzpLQWMWOAPG52/9NsLoHV7JlzLMRyU8DAaYUy5K9YxJ8uGWQpZoNHuZsvOQ5d5ebyhpqTuyVoJKPaKtkRKQiKzkTakdZJQSFN/7jKptYoyGpS3TwDXmkSQlmEj0ctRAhFAmU1w49DwEKSawdEse00SpnmYBMSNnvQWN8fErSdwjaIPL7C1cxwpeNrswq50vup3GOva8P/sclqzttCs9LlWPu/x02LnPPnY60+O5ti5E0KAWQ95NJy/hqnmdRDSQF8br8KSD9GytVrmKFrskL7xFHObEz3OyUrNZLdzlDx+ujpCw/UEr0qkFZ4o/ImjsitHAaWPX23a53Ebq5+W8o4HuuKzEMZI1h+N9uaeIvl87fM/ZsgC3KshbVXNxPb8mIyp1H4HdyLyhDEdQqMt/2pVFZXkdlZsjysz67rKmp/YjPzhBWxxubQkn2UiG1Zinv+sG9vMn64eqi++p2JbwNxU1nf6SxFmJmScmw7EvQE6q4eMkxaVuOb5gDRrUr20OD65hvVLwWx2LTFXnItBQurtBs7k2PrDCmhjLHo6XSqIY9YuHuEhuQpvUuT4u8iQsXcpQ5I9V4+Aa8u/YmTI9IfA36Q==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(18002099003)(56012099006)(22082099003)(10063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /+JLw2cW35gEhjl2ofuAUJCx3if43K+WwkNgXxTn+wIGHEwKBCPifYx2rsk4sNVUpngGb1ncV/a2wy+PCithd2hA054L+M4ofBzOqPlw0rTMAB/BWr2ZUIuZchegHZ/y1rPH16o7DL3HqyRwtytq5bbLzzsG5MILRftWMtgSV3I010S6gnp1ehAPZEWr9GhKPHHHFXQrsv3mmXV3qZOqSUstB9kBhNYCB9O2CNEAFoMMweVPF/tpRO3fzwZHIxyPLyGQLfgC2kXsLxPH7ScXqY3hhDv3IN5l7DXQAxpKQSZLJGGPqA0W3vYDvoAUHvX8ATZIsIvCjwpZcPWNo56hqs2kXxACv/JCuW+YsEOgmk17VYb9s+eof7nXpn9PickujO9TB+PaMfFFoP70xgxXCVR5JJN3U9dH25+bnCAW5r5RXfdvfFTQIxklyeGOigqL
X-Exchange-RoutingPolicyChecked: r7cLvIvqy4Tw5rUuq/JWV2XtjjC8XN2t9ZqXoaWlAY3o3Ri4kgUTpggSPQ++evhMNGqvIl8aAtjR6+BDvjcV1CFXrkU3p10mq/3g3Cl4RKrKP2m/oPyBC5Y13YygETGMnEp72RnaQYB+atTGzOE5StMC/0CAulhfbntmd74WOOMDIQ4Zehh6VpEDS7bW7K3BN6RbQurTZtpjaz/C06/owgD23qH9OEPIePU/yzLPsHxToWV/TVZcmdzEVvKlCc3GV4+ImmINJHDmisfIFLFeNAeXAZEuz2yVqkqSj2snpAGoYVq3SNSIZcC5YB7KpmAuDfNkTPvbLwE4zVFCH/c11Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:02:54.4062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db718763-3048-4ba1-0e96-08df0a7c73ed
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6904
X-Authority-Analysis: v=2.4 cv=XLoAjwhE c=1 sm=1 tr=0 ts=6a9ab375 cx=c_pps
 a=WaebrhBVOVZn7IYqRlctMQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=VsGSjbAOC_8i-f7ynrYA:9
X-Proofpoint-ORIG-GUID: slRI-n9XSP3y6pRvR7UTwLsz50u7YLYt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX9D+6v0Btae3R
 X8ONQ1vqjsZWPhv0Hzyg+yiDwZDQEqj1/HMHNKjhGESVW1oAOES1nu7RRSLSV2I3un5jDJCM1bC
 /NmTvKj8EnVLysOwhO8DoeFKh0IMuA36hsz118+6MIlQZdPp0YFGicE+Dw9MO7TmVW5hmDkTHe6
 3LMwGTwJZXWvPROVSfuSrTLvWC1RCTy4mioIxmDLukn4MkdHIau9klFwWRn9Ojh0kKcT+XrEFlw
 AuZcSqWRu7wPN8b8kV1D1aMWyHtPMIpvTw5i3UY/AJOj+tJaD4UnjMyRfJ3xWAua+OmPtz1CuUG
 G9zLp9o2zp87FlSg8kv8WFiJX3hGcuWb+4QGpcFX8zA2b3cyIDrRdMxRlCt20EO7pV0TJnKhI9Y
 Jwq+80c9a+dIuWhPGB8v+yDzXbGFrQJhlo59g806eRoawBKXq1XG6sYXAPftCLwTV7JNcriqz2/
 OyZpVH8/fsOfsjrGwSw==
X-Proofpoint-GUID: slRI-n9XSP3y6pRvR7UTwLsz50u7YLYt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX8BQ86A4e+gJu
 Dr2jycmj0HDuiJow0SRRKHTAL7KkqwuotT9vjGkTbmVjPyDw3NxgZ25Azz037Wv0v0B0OBJ0fJ8
 EtU364FazimAdYTZ45xfk6o1a8tz/G0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040107
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

