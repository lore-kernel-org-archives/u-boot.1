Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06C6CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 11:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5555D405DE;
	Tue, 29 Sep 2026 11:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lD3xcfmpQh4u; Tue, 29 Sep 2026 11:03:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73C2A405D7
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790679835;
	b=MMWVC37iBVN6j01vPZdlRkIVIGkkzZqYecXlZdmvX+dwRorX0sw/VbHNfrbwVLrv6HOb
	 RvMrEY5JvUXNgXl6M4A68tmaiD8y5bk31rklgpBmoOaltxv480gWqXvRG1D2SRgP3XhDJ
	 Kg/0ys/EAT6KUBuB0No9+ypW5M54HzYYTO/ybIiTG8rn35vHe5K8ujFyTX0ja6lM/5V76
	 2NqwhaBH++UYtxBjvK2CvGyRwoTMVehnsVCsiT26utw88q7wfkvUt+x63tyelpabmJE59
	 xrvM1tMteFkeWKX4roLWEX4aophEPMV0T5DDyHNKL0pSYBzVL6n3B6UyQvuqaCu9k+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790679835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=hvuuuEajJvWte+W/h62kL47Tfqc7P1HTVmPTZvXGkqo=;
	b=NrrYaHDiYnK1d3VXK7heblzKBSm/tbYqJGgIurJJTox/EokYi0LzxM1EqNSI1mDSQ1/a
	 VUxginHW2B7BXsMvXK67AtXYaglwXDkCRMYQmKuwXkfOqGFPhc7iam28rZetzrRIL7rRB
	 smB0gOctLnoyKtHECwZW4V3yy3/hBZQ0wCbtWsf5XY9Z0YJlLX28qFBdgMxu81CeEJDQr
	 +kEh09fda6qi01pzbxATZJjxHrIMJR4P5oflY/7HFuuEIVd/3/ttasd/Zra/3vPTPi4p9
	 0DLLsfkBBsNru3GBkzywK6e2aEbRAlJlJHc1Mc8dCoY4H/QmpOA9F1VRGVRSrnrzVsA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790679835;
	bh=hvuuuEajJvWte+W/h62kL47Tfqc7P1HTVmPTZvXGkqo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cWK1MPuOxTI313WIVKCKwuGuNfDFRB5NTHCzLlrXBYxLO7s+3u3EH1pnBmUNxGntO
	 oVZUYtoSa5hroVbm1Pl8Uf8BGKXRfegyofddRXT3eCk+iTobgRSfDepz5kg1iu6hIt
	 Jx4BLDPrh1IhghsPD0gYiXal08Zj81rL+bqgLz4MPGYhVQzZgtwKZh2gEUiiXaALh4
	 4HBr1EcMc4iXbuZmJghcSZqQRQ/fjVQXM4gO/QzjYDSXUHt3nucS85kgzbHo3kCnd1
	 Sl2970MjuqbRNJMET7UTjHSNB/ECsUrT2m2JWdmidytXRmQWKkdZzeiSEOxVaObuC6
	 TmfWDKAF3/liA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73C2A405D7;
	Tue, 29 Sep 2026 11:03:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B8BB2D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E30280DDC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6oPZcSXVUvt for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 11:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3AFFB80D5E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790679833;
 b=swXPxK4SIG4XuuSfcNgcVljS87hLvT/+zrme12YiAdiVQgs95VSa0FfOm6Q8ofHLS1qz
 B88loMtuCOonvu/S9Qw7/Bc6B+k2eaRdFk/iZJ5Zo0uIrNEpPJDcRXcSxj9dA43KaqQ+j
 43+k0dowILqIK/fjcDu4oTwXE1B2c8XqlrVkx304q4NiHxGUJKcXzaqWAqOrs1wehk1Xr
 ShXlwcn4fiCCnXwJppTO1DWt4g/EAREKZ6wfPM/mbm7gRMPPSbdG3R92+0nBWhuHUv4Ny
 MwO8p+Mwmp4vmqvFhkReUZdIWLKkOhTzmDqArieY3WDGWmCsDkBDEliHA8waThIjo/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790679833;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 bh=hvuuuEajJvWte+W/h62kL47Tfqc7P1HTVmPTZvXGkqo=;
 b=qKJhPcfof0jmeAU1rlKEs6H83riKwKdpvYIExZWQbQj4VgGnrU9LkL9iYP3V+lRB8p8D
 d+2S+YTlNjCCD97MCsuQCIddio7sMkklYUZO22NcshdgMKec6+HvlTY5DcQOQn+CWq/6o
 ICvSd9DgnmYZ5E52NrP8RwBbHgd46ve5DgSI13xxEoRczluCgoYJn77rb3kQATEKPjWf7
 3jng3c0nUAzQH9Y44I+PI0OeKkESn20romaZW3a0s54Fqq9m25v+lRHyT94zH9ZQwSXqj
 hokyXDWhlWMwJ19oaKGGjIyNu/EmeVpfVfjROdqKnO9FGJoQTJ+ju/Uq1LYgb33DNOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ctOUR37w; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ctOUR37w
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AFFB80D5E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2siVZi/qkextX/gwFcedDRXz9BCzwvowQoGFuAlNxrbkVWfK/qXOKQb4xtTYKEiusdXg4qEtXrgTCtt16NngWu2goeSAOlKLzIE0RwzL/QGuSrL8GUN5kuUV3w20sS3Qa81fDWNeYecH9cW6ADzjsdc8oChJMGs4qBUjd8RbbNPepqSUVD9TtPnxmI7QkN+AiC35jg6qDXlT9pVOL+wy5qaZ64CSrSaSeLYcblcZqZPNbM4Ah+xx9Mr/D2exXrTc71lVc/eePt/BmWmtHXXr7q2IjV25JI/9Tnq4CepJQCGZYVuZWoNURis0sBvT5xG1zkD44tn0v7c4FunXOMiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvuuuEajJvWte+W/h62kL47Tfqc7P1HTVmPTZvXGkqo=;
 b=t7U1ubd+kApYcagSHRKGfvnN5hlTcHNhASLnUXZL3qKdCWd486NPbWVYfNIMAN5VGImlv2zzzuVrfjBJdAYaxKFTB6zP6/XvuJoBmtupYaYUE3UFqGk4iFg1Sb+tOMHUG7Jms6xbZATcIGpqsHAMpJFsO60V1OEDxmBZX5u2t3BNMHY6W4hM4AAVi+QD1DHFpgnhvRHX9vk5nSVByrO1fVaU4wx+G7VBJz2zxpbDNwTECtmNhbPy1Y+/VnTkdhL9/dJVEK7ewS/V5M0XOaXDWGRF5j2q19akS0HhdEUnjR0D7SYolaJ3yBkVgLS5dre2m6xD7OjpoLxrkgvQs8tM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvuuuEajJvWte+W/h62kL47Tfqc7P1HTVmPTZvXGkqo=;
 b=ctOUR37wDeKJN69DAfyYvSSr0JdcMQozllYHR2IJ55SFUJzElOpy8StbMrrxUJFpSTOaidHzm9Xtqq6e4d50KiKoIB5v0smQKel60PX/edUb3uD/YJt9bBHtAkpg9P4TwqHjXk+Y64jAyyRvfQ/YVvQy/10LXWj4F/9uUBGyICw=
Received: from PH7PR10CA0010.namprd10.prod.outlook.com (2603:10b6:510:23d::19)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 11:03:45 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::42) by PH7PR10CA0010.outlook.office365.com
 (2603:10b6:510:23d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 11:03:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 11:03:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 06:03:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 06:03:38 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 29 Sep 2026 06:03:35 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, <ilias.apalodimas@linaro.org>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v2 1/2] scripts: pass dtc cpp flags via a GCC response file
Date: Tue, 29 Sep 2026 16:32:53 +0530
Message-ID: <20260929110315.2879640-2-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
References: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5abe34-b898-456e-9b2f-08df1e195379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dpjbuhb5sr4ehz23jaUCnW2Bo3BQUl7rbExlm78wO9yIJeuOE5QjDyuY16XD+5otTdjJnJUha2ALjrTq6Uny/hhmOLwOj5pjuB9aYTHSpESnV57TL+n25b3sbkeXOb9dGBTflPEAMk0WW4p9VBgYeB8+X9Odm7h5xnE4xnKqj5ykXPbzaHWUUupUzC+LmEBXJrjJ/JmVVms7ib+IjVtb6ehTjMFSkqa4tid/gkYHciQKcu4/vmJ9V2w+fXLSr80YzeGgpyPRxoT1TC5NIKmw/JcAhnLchKQiNIpabvc1yh6KSq3z2CKRM0mc14dOuGNWMWdPD1R0zWd84zE0L/K9Hoxojdyyn9RsL3vOdSr6/fG58RULUbbkF12tF64gnC/9Vijdpf7+LSsyYX3Z6O92ppa5vYrJ2GI8cH58OWXb2RLhft+51jqLqMa3rHVVVv2fSvXCRw2gopTYYMLkZrF+a72F3gBuINz9e4f3MSE0VMG27wbQxEkOjnh2WPOTwQeQaqRnk4eYQc5X/N5cfMwvkAa4gpKUzFgI8hSUoHzOPpyxtpvqxnC3tM3MvOCNQv1trisZxtIuCnrMdGjTIHKP+dIgRai2MkXt1lKy01ASGcTrMvcVtVbe9upYLH/Jdt5dwYs0DaWLXix0rtAhBuSQ6HmyaBTDr8YmnoSA/f5DsXwEvx5OGHzIPqsGOj4d6B5rKXSjZ0TfcF0Urj3eZ1cPNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QZLp4pxw383xcTqF9GW3jlDh5FMwZxmabgKt9HO+hKK5WYTRUlGxogAEgowc4k8OxAlKE5xp5zszefkhEVem0l2PCtH7Ny6hmp1RRW30HK023GSCH3cLcq8/6z4xrgl5xubX56wFxji/xn6/ViHO9cQduuTsiVSbb7GZ511X7YUVi3rTpGRnxN/2IM1Q2Kyp/N4Mz0iFO+LsFVI460iCfWCm/tj5pwqwK0PXeYv/LXFYMA5J0+AprVThbH7NQyuIKRduVpesuyNRr2IEkMuwaIfQByrpYvE3zBd10t8jlKIzwGLvkleHKS0YzYfmcCZCqS95jaLPV8xNuokLR9IsAlV4woI5zjAeYb1KQ04r1gm0Re48hI8h6k5YG5EQ/coSeH5IKyV3anxJPFs4nqgsT8IngouI3hTHvOiC6eO+jsEUSj/M3LqCoL+B43kkYkXp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 11:03:43.2388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5abe34-b898-456e-9b2f-08df1e195379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
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

cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
path) in the HOSTCC command. With a long $(srctree) that command is
too large for /bin/sh -c and Make fails with "Argument list too
long" while building a .dtb.

Write the flags to a per-target .dtc.flags.tmp file and pass @file to
HOSTCC/CPP so the shell command stays short.

This change requires GNU Make >= 4.0, since $(file ...) is not
supported by Make 3.x.

Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with CONFIG_OF_UPSTREAM")
Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 scripts/Makefile.lib | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 122c8e78204..af0875ac52f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -448,7 +448,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
 	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
-	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
+	$(file >$(dtc-flags-tmp),$(dtc_cpp_flags) -I$(obj)) \
+	$(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
@@ -477,6 +478,7 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FOR
 
 pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
+dtc-flags-tmp = $(subst $(comma),_,$(dot-target).dtc.flags.tmp)
 
 # DTCO
 # ---------------------------------------------------------------------------
@@ -486,7 +488,8 @@ quiet_cmd_dtco = DTCO    $@
 # No generation of assembly file either
 # Modified for U-Boot
 cmd_dtco = mkdir -p $(dir ${dtc-tmp}) ; \
-	$(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+	$(file >$(dtc-flags-tmp),$(dtc_cpp_flags)) \
+	$(CPP) @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -@ -O dtb -o $@ -b 0 \
 		-i $(dir $<) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
-- 
2.43.7

