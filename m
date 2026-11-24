Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F8606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Dhcq10Bu;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=O2rmCUEZ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=IrIU5Vbc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 698C880DF7;
	Tue, 24 Nov 2026 07:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TkJ7I6aRwTXV; Tue, 24 Nov 2026 07:40:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B20480D81
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795506049;
	b=DxYV7g0GJzaqQpyrcDCUn8cMAEUZ/e6vDA69z0kjcuwRBOCnci/UrOhCAvuyca2dVP8O
	 bPmeWabQscow2VQlPxA5JO7iof7gNZ65pT9u7aXFF99CaPVN6/X7v69NwkQJuO0e1oO47
	 sD2LQhRLvu6W8I7ucKKZ0/dDHx1lzm3Gf3G2xnJFgL04v5Q/EE5u8cdxVEdvT2MmUA2a1
	 DVH+0TMPdmZSZKMXRzYbOvL2LldvrqUWKs0TOjGdM1f4qpqc9ZDtokSGiHpzvg+rw4qAF
	 PUTerdzYuEqnIeKGNXUaXZUVmY2nxMzfRGBgS32UyRG8w938sSBWR7OgTyERLwIXfzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795506049;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uJnN4gcXSuSf3EtMNgh+9FGskAWc3EG/OCEpzwBj1QM=;
	b=dEhYo3Nk1IDqquCTea8kbC7IeaqfcAj4Is+NsG1PM8B0XRDgUXLk/ztCbiYwbpU8c+8t
	 O6ZWEU6UGL6lp83SoK5sC0YxCU5+Yt+dbsuDymU/7sbYAvv6tQaUkwGydjuDXPh657iad
	 Nq8ksrHurhIq7PfqhI5iWOGP982p9ZGUUU7dTWABorsNCP5UQ1Y8hm+lyB9pckLL8ifiP
	 uEUy7eIQf6vy2x9+YiyR1ZKWRGNpX0teJBTtHNUvFDXp7kP4V0gtpkzLw+HuPrM1vX5gs
	 PtdPtP3ReByRldl6jWO0Y9xd69VXaiDW3K7kLLvihac9kOvHVmLYN5hIgn/lFkifUSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795506049;
	bh=uJnN4gcXSuSf3EtMNgh+9FGskAWc3EG/OCEpzwBj1QM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dhcq10Bu4GYN9aClLnzQRNSthwtiKKuXabnnW4+3WAhYQXqT6n/BZWHF4oshkrDUy
	 WaDwRJS7FiSJkKxNQZSgF2c443vG1OUwuC6LYbKJYPT3hSu57WBWS9aPA+IqXL0/VX
	 m2EknLJy0DRwp/UVWuIxWruzCvr3bzNeDS3+iJf9XkwlRwjldJ3AXsHp7rNCO2TOvH
	 07zlDuaN4AfFmEaqKucihEZaMXCl6bllDsK7xcleSApc/8BN4Mkgnurs4vS1QoWuxK
	 YSy7eihNECqtBExSAHc/YOmDgB7ICyZHpdvY4p8XcOTc9feoJOLP000TQ6Kz8iqJmf
	 7kmmYLuiS7tgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B20480D81;
	Tue, 24 Nov 2026 07:40:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EEFA260
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00C0340599
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOIOLZd9GtFr for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 07:40:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 022E040586
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=O2rmCUEZ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=IrIU5Vbc
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 022E040586
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:40:45 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AO2joJL1303064;
 Tue, 24 Nov 2026 01:40:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=uJnN4gcXSuSf3EtMNgh+9FGskAWc3EG/OCEpzwBj1
 QM=; b=O2rmCUEZaB9m+wgkGtF+fM/WxSlAtxRawrsF87QeGrgP+w65FfdxrAObI
 3aj3i9BhgpvDQ45eWjeyZvIXuVs/Dl11NAe4BjVZ8RQ5uBBypHf5uv38qe2bDap7
 cR2R5cf+debNQkLunr+NzsS9CPN03jitbQSCvS7c4Q2cS5VZHCODgRY5PZ1wZUS3
 E0W52Z5UscTFOa2J19EH3K84iKSQOO1VB/zYHaxTDZaQcQhgxdF4TgDLxNRfV+t9
 /Bn6vjyNwBIUxUZywV4XkAh1BNsMRXRmtwBPaTfAFkWSh54OeB75OKRBjVTG5rLR
 puchiv6RAFQxKvRGvY65H7ulhCRFg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j50h81ur6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 01:40:34 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJnN4gcXSuSf3EtMNgh+9FGskAWc3EG/OCEpzwBj1QM=;
 b=IrIU5Vbce2HZrkEAyfodbFvGsgiVrbi3MXiYUTOokofnBdXrBRChCN5sVPkmTlv+t/EbTcHRE/GQ1V1xlbjWZbR8ImLYAzGKv6YjLlvI3k17FAQFjPyrQwerisgGfkv7kmzffeXwAAHJl4vaZXF6WNiRNFwt96kEAH9HAZ/W9pk=
Received: from DS7P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::14) by
 DS4PR10MB143685.namprd10.prod.outlook.com (2603:10b6:8:4f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 07:40:32 +0000
Received: from DS4PEPF000001BF.namprd21.prod.outlook.com
 (2603:10b6:8:25b:cafe::8c) by DS7P221CA0005.outlook.office365.com
 (2603:10b6:8:25b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 07:40:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS4PEPF000001BF.mail.protection.outlook.com (10.167.23.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Tue, 24 Nov 2026 07:40:32 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 01:40:19 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 01:40:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 24 Nov 2026 01:40:19 -0600
Received: from [172.24.21.188] (lt5cg60819vj.dhcp.ti.com [172.24.21.188])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AO7eEHa172396;
 Tue, 24 Nov 2026 01:40:15 -0600
Message-ID: <8edb588e-5bba-4808-b50a-2831afa42978@ti.com>
Date: Tue, 24 Nov 2026 13:10:13 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers: power: add SPL_ config options for TPS65219
 and its regulators
To: Francesco Dolcini <francesco@dolcini.it>
CC: Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, "Peng
 Fan" <peng.fan@nxp.com>, Kumara Bhimeswararao Matsa
 <bhimesh.matsa@gmail.com>, <u-boot@lists.u-boot-project.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, Johan Jonker
 <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>,
 "Nishanth Menon" <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-kumar1@ti.com>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
 <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
 <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com>
 <20261124063622.GA5917@francesco-nb>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261124063622.GA5917@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BF:EE_|DS4PR10MB143685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8238e180-0c55-4f08-e6f7-08df49fe3868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|6133799003|18002099003|22082099003|261009223027099003|3023799007|13003099007|261021121427099003|261026140227099003|261022105027099003|261102123227099003|261026121527099003|261022075727099003|261028144727099003|56012099006|4143699003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info: gwODiMvhfoZkZe0wwu7teDJxW4Xgowo54NCYLEOr57h4dPUofjyugj+2AU3wLgDvtfyPRPWnBBW/nN5R3RP946HC51TEof5GbiotmweAdNKjJ+iFPGIb8b6oqnMGTAXVJHblcszRr2zr5vEZVIxSWQZFAW+twm4ZgdtJxUK7i7arlTNT4ydgrN7+qicI4kD276XxJwgsI7sfLAOcp5rfC41udVpQ82CtCORXDZjQ/piyPHNNVKFGpPD8H1VlsXglBwxaVTDWynstSCaZ1RyyXqbtyHgRjNONYp8ZifRsvrO9IgXCsEBbq5+jTVrvfSVTwFtYoZ/PZUXO9zUmddqajurhuPhNczEpMHfmQ/rVvB0A+jWD4ulA5vlsxWbfuokUMrA0ddS7KF+S2Ary6iLbjYPUqWrMM50pv4rBdPr7lY5eQpClHesENX8X3MBkrJIXdL/Wjw5T9tyJEpdSdgH8FLGBNYHkWs0zmo4m99udQMIQUiCd5SSsdYMT04edi1urGUGp9XLVSfAGBJShx9ymc/NDKz8VmrdPgLD6GJdag9xEn8I9vTh074wJc1M1gVwe6MRXlCqGDb6ANERv7KAxzW0eyC/8XwgYcDeYWz1IAIxChnKZQumKr5r0A+I7yJ9BH+PUrSabQrozRTLu98Uwsel1MIHsNsm0KJ+E+/Mu8ROjMxGvCvcs58N0DF2dqS6ci1TkXUCjqNi2y5y/7K4K7Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007)(13003099007)(261021121427099003)(261026140227099003)(261022105027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8OFCfGWpTjAZuytd/vrWjYi02dBIR+K+iTAHTpDreXNNuPN9i2Km53viGeBlbXeLN1oJtLbAqhPURfPVJAmyu4g0Yj0M4dpp0/WUUno6K2lQvO5+xOyQSD4KbQvIf573TuDrAHgY4vfmd1JeuQYaXkkSHvZPi0dUA9lHOCQ9K82poQuA1DZ4KB0ZmhggYsiDae3vAS7nUa8O78XIuw26it5gQg2yJ6OKKBM7jaFCMp6tC80ixpGwz+sItwppXuQbDkfl1nHgC89pHXOqdwoSiy+0a68deeJeEjtPMJnW3RcAnYqZG71RwCAkbOgZaAwahRXMkFbiA+n72492Ic0l/9YuFihV3NHuqBO1qhtJXhvZlT/wWYI9eRSAZPQsqm7OPhkN+wddXUS6T1X2XkSmfT0lNm5EBzIk0zP6w0AQFw1xg03Ap9dNY1weaFeBgdhX
X-Exchange-RoutingPolicyChecked: CRlpmMxgGPfqcwYDOiqFdSpmd5xt2fFWElt/sEoppo7Ydw207f4ggn/vT7N/nW0WBqhhOYMrwsFUW+Cx7WlZI515j2y/VXiOQxcsYKVskG05UIGbjFIY/Tt2zxGBySPAyalRyOQAI4yF78whKDRuFfgfUZ25lkG13lTJQK8wER59oe7abpOg0JQXq7niqNrMzVdn7tacgbitOgNxswMAyxizGmoygzi4ExovMWilQvo2m18oYr6OD3TWbTejxAwsg63++u5bPG3EoiFrSN/4Mp135u22eLw+SOWQEcsiRZgUPjie3VtQAme7lcyCQ4qzL0X94wpm3NbH719A9BXy6Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:40:32.5801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8238e180-0c55-4f08-e6f7-08df49fe3868
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001BF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB143685
X-Proofpoint-GUID: tKckYRCOjYiyWvX6hdLUC3JM6w77ONLi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX1MueQS1abTJ7
 OaxmGKfSq0QBbkDfYaXQBraCy0dvzTMnu8HrJU0AG3r/i799IrE3hND7stRSY0ZPWJsk86q/yVd
 TE2ptnzT8u6GL1ha5l+tUYVC2bBG67Cl00NW+Wi7c0Z+1j92gSvwJoARPm6PNxn2sHzrijlWG/x
 zaZk30w/CsXgh4wCe6da5Z65/2w5JmG4GY0I6abKQAEjDo1f0xrkK0RuTD8vZVO46Q5OrVc4uzG
 MR+b+qezqPkAdM03+ScP/q/arvBupyHyfKILBMNrCIYiL4c/cO7pglvk8Ylbe1BVrinalYXgFH4
 MBwXYbFsAc7FngOjsXUzFPiVwaT2DnmoevHP8NSiUnokrGygW1VC1wkfaKSB+phPbqoNlEexzYF
 IYWbuTFVtMqQs7VQs3jF63mEnc8203geHhLJuMIlyqyqALDoWdu8UgpOLMHk+pkx8xYZS5gqzxh
 jXWd4iHbUyapUzxWKbw==
X-Proofpoint-ORIG-GUID: tKckYRCOjYiyWvX6hdLUC3JM6w77ONLi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX2LTrk6lk9lsT
 DYVLqbMW42/BURwHmD/XMOXcSblOgo7jvVM9WCn8m/ZYrYP9k8evTXMgLCNuED4jR0pos2sCO/a
 156C36cq2yTpDgCDvwqyrpUhzPwZQaY=
X-Authority-Analysis: v=2.4 cv=WNTqzXsR c=1 sm=1 tr=0 ts=6b053f72 cx=c_pps
 a=wCygq6uL5kGpubmeL3zaNA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=ccWlRzxFeorHIXAEEnIA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240030
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/2026 12:06 PM, Francesco Dolcini wrote:
> On Tue, Nov 24, 2026 at 10:16:20AM +0530, Kumar, Udit wrote:
>> Hi Francesco,
>>
>> On 11/23/2026 3:41 AM, Francesco Valla wrote:
>>> The TPS65219 is a family of fixed-function PMICs for which the output
>>> configuration is determined by the part number. For this reason, usage
>>> during the SPL phase is unlikely.
>>>
>>> Add a SPL-specific option for the drivers of the TPS65219 itself and its
>>> regulators, to allow its exclusion during the SPL build. Since none of
>>> the supported platforms that have this PMIC onboard modifies its
>>> configuration during SPL, default it to N.
>>>
>>> This fixes boot hangs on the boards compiling this driver but that don't
>>> have the regulators sub-node marked as bootph-all; since commit
>>> 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
>>> this absence was leading to a silent boot failure.
>>>
>>> Tested on a BeagleY-AI; the PocketBeagle 2 has the same DT layout and
>>> the same configs, so it's affected as well.
>>>
>>> Fixes: 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
>>
>> Thanks for update,
>>
>> I see this PMIC is enabled for below boards,
>>
>> configs/am62_pocketbeagle2_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/am62x_beagleplay_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/am64x_evm_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/am67a_beagley_ai_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/verdin-am62_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/verdin-am62p_a53_defconfig:CONFIG_PMIC_TPS65219=y
>>
>>
>> I am wondering, if PMIC is really needed here,
>> Do you see possibility to mark PMIC as N in respective board ?
> 
> Verdin AM62 and AM62P are booting fine with
> U-Boot 2027.01-rc2+git.eb7af371cb8c (Nov 23 2026 - 15:22:38 +0000)
> 
> No bootph properties on the PMIC node, and I guess also not used on the
> SPL. We could save a little SPL size disabling it.
> 

For normal boot purpose, you don't need PMIC in SPL or A core u-boot,
unless there is specific need.

> Are you sure you need to enable the PMIC in the SPL? For what is needed?

Two purpose of PMIC in SPL/R5 for J7xx SOCs,

1) to set AVS voltage of CPU[0]

2) to detect return from SOC off mode under review series [1]


[0]
https://elixir.bootlin.com/u-boot/v2026.01/source/drivers/misc/k3_avs.c#L114


[1]
https://lore.kernel.org/all/20261118131807.135859-5-richard.genoud@bootlin.com/


> Setting the sdcard voltage to 1v8 (I do not know these two beagle
> boards) ?
> 
> Francesco

