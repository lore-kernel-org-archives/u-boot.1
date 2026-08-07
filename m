Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49398C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4ACD60A43;
	Fri,  7 Aug 2026 13:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fnfmoaiMvWad; Fri,  7 Aug 2026 13:45:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E51A4608E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786110325;
	bh=jpkF7vMPc/a8OenP3OXV09oyFARv40ARyW9xLEcvfN0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDXFipkiFMKBjOBWYVXlRHfQfHM+oi7vFytL9WnaVd7I5zs3/FQptp5GESIhGhiMq
	 JwnkddF2Gsxe/MYgx71hI6Q7FDTvfFZdMhEtqA6VNt5lbLY3rX4OOcdIz1mgbMUuRy
	 8HjSot+j1QZGciKhB6VjQczoK1ioZBGW8PRVFBS6Qz633Jw7p7oxG5K291aYIOvIRT
	 4U1y01vM3EIn+kPy/xwLZNeP4i122Mo8HgWpersUUHygk6kwdyI+dR7vlpybK/lv8y
	 O872sk79yT05pCbcqTUSIjP1mTvNQxV6wWJGAOXbCJC/Z/wnoSAL4fA2tOs0DluSlf
	 jDEB4LM2A9OFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E51A4608E7;
	Fri,  7 Aug 2026 13:45:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24312D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 025F3608E7
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:45:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ag4TBWpHUFhC for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:45:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9EA24607E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EA24607E6
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9EA24607E6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:45:21 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677Cen303177167; Fri, 7 Aug 2026 08:45:19 -0500
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fweqbrk36-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 08:45:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7g11pqbKUDvk9i5szEquj9GFjtf67jFL158WaH/xgIKHoP5ITPnpG2dgG9/LCsYd9122BHdov4phcFP7GGoyW7lM02KLx3Yaygkus7CiVdraBRSuAks72CFK4nyWRZB2se9cOT70OUtyiqptgyCUmRrJT9K6nlZvhMTgNgqYYggBxm3KvULPl4LRoyCk9MzScdBajKH/FbQ3doCeXAQNDpIt2Hhuv2o1CXRIoOD4wKEBGHSJEhFqqh7V5ZO1a4PO3SRZpkOd4AQw9CtBQo83QXf1l9Gv22SPIDQ3Qd9Z6Lw3FZsrQvMVZtJi6bOexKBxxXuLnMjuOKWynvykMl1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpkF7vMPc/a8OenP3OXV09oyFARv40ARyW9xLEcvfN0=;
 b=cooDLrhDaJ2musGkBH4p1KmOtowf5stLqBhLD8cbNMd1JeN5CvVloMA1rnySBhF8Bd/56i9MJaBHKItqKP9F5051U8+85t4tcOMBSOWqgGtG8u+9HqmiYmfPkcOXPon134fF2qT7WwRQcM6MLC7UACWo3xoHLdMTk6JdHVtKscjfWqSBnPUFVHvUp/m2pSqtNuKz2g+YCeY27Ty6L15hUWqGiPJW0gxylfqYQ2U7hmEj+a14S1pzI+3mi7xeI9ewvMsrtNB4Tth8efUpSrsfjnvwbpghAsUcfysOtetSaf+h+ijPvEMYYSLSu2Cbiz8k2g2gIx6O2cV6NFfxnRwh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from DS7P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::14) by
 MW5PR10MB5827.namprd10.prod.outlook.com (2603:10b6:303:19c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 13:45:16 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:8:25e:cafe::90) by DS7P221CA0031.outlook.office365.com
 (2603:10b6:8:25e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 13:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 13:45:14 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 08:45:13 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 08:45:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 7 Aug 2026 08:45:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 677DjC1K1154940;
 Fri, 7 Aug 2026 08:45:12 -0500
Date: Fri, 7 Aug 2026 08:45:12 -0500
From: Bryan Brattlof <bb@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v4 08/11] configs: am62lx_evm: add initial defconfig
Message-ID: <20260807134512.ri7cmbidhvjcytej@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-8-01746157643d@ti.com>
 <CAFLszTj2jqcQG9P4nWWiXjJ-7cHko8WghVqCbBb-FExnH+gUFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAFLszTj2jqcQG9P4nWWiXjJ-7cHko8WghVqCbBb-FExnH+gUFw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|MW5PR10MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfed815-0338-457c-c78a-08def48a1c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uhGCroUoMkX3w0R4xSyOEW/83LCtJNac83YOYD81Y50l9M94HpysLzn5ZJO3+XgxlXXpdskKx9IEn6FlpNQYZlS5lKp8plHeJPMvxjUTBrwtVb8Nwh5N6kcwz5EDaa3auKNsfPIfzPWwuXNVZvbUUp86gQm68sEW16Ufmy8iiqHfhpjZyLxPUtAEQwFqpgRd6tL90nOH1qV18LtV5Aw3+47NKUQYnB/6a6JuleZW1p+XJrQqAj7YLvmeKJPsNcwPod6LUm4sB7hOs19e/Oia9oz7oxkPVZeCMsHIPopkR9tUOm/NPAwvSslZm7xaCJedD/lLZwwSv31tOYcPrsgl4Ln4XME5JBP/1xs/lwNmyQdkH/LY8i8LRDSFHxktirRPjkCnmGzzdCvOWyrZ3quRZmqPMB7FIVMzfeC6/EatZ75CePO/geTIcko9ZTo30XcuuW2LdtcyM4VWUciivRRgKQPKb+KdhFJGzeoadQ4VCQSXq+Wk0Zyod4TEB22JZPkha2Hwsg9XebxeOZ1zLfnbdIepeS1kPegUE5aqGTKn3uyml5PQOiLxcWLIYyFmfHDV8yEc26Gbnci6bYWF76JZC3XBRyQ43jybrHbC/pH4m6nwgPI/akj4etvSgx748nzcv+shzy6VWK/5b3ezS2oHTx7bL8OEw1IolVfHyhdqPK955FdlZrpJeIjKKegNUkCnF49tG2FLzHN+DwuYVMhFUQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dTUwxsRHJKiRSuEJF3NZVfD6rXyeeTCz3f+c+4WSISJq95x3BKANmJEVTuce0ALnaFk1zWWH30fC2cWbz7V8jJR7Dz9ABowwQv/POVM5ZdOJQwg4juKskH79CzMZ0PDGyks7yLvdtJ9/6DIcb6Q3aNWAAu7KNeiAx5/SVlVzm/6LcMs1LQfDGLUB1My9gnVzIhpscO4feFEenOUwRvvSOqXPCVtZoCYp95gZqi8++JDhOTgGLEZR/7U/qw8tACIaM33s1AsWj7+KHtIYh9f0CfZMYeyQtXt5ZX2LdGK7RIBMY+GLyLPg0wf5ixuFv/UyTW2zG9L9PGF2KZ+Bvfju+AS65c52W2EWmSkSx2q3QFpMZ03+pYzx7+fB9LzCz5Zaa1c/1L7z7SkCk+2i1RpjwOOv7DBZ2D19JXB9fXjPwWrQ364qO4JoQfVsMg3rXGus
X-Exchange-RoutingPolicyChecked: dka+dCIYYTFzW2pZGmKpM+pWyyhSCUdsbMEWcmOt5mfwXms5E+yHqxrQS/M40mja9xvh1b9NZp0Xc8fzUmICzJvSjizhc3y+yHrdLMsJqZYd5/ozDJi1cAsYsKO6Fz5tFl5u/QYfzO7/jurDaqxkUc853F3Lx3kF6EfthGwNg57kMBSjXy734H22PR4cShYVDOwmIOIHxRsKgPjXJtGSM05uBFdJkeLvPmWQsTUFDtm63v3/h+H6DxIOlMh6V+KAjt83r+Fw60xIlF5FwWKP+mxh5OTFwMy3wO8NwBcd1J/y4dlcp8ryJy+rRu/v/Qaudj17Ooakp8ypkzFLMvMZ0g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:45:14.8771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfed815-0338-457c-c78a-08def48a1c3b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwOCBTYWx0ZWRfX5J9Q00oTdJe3
 EfV0tY8vjYX6euCThaQAE9BC7y1li5RBVfo0DVxMvay6Tjwq6/tOFlOqYYZshPemH2HxDzRiZ3i
 CfS0PWHKJJ3WFm+DiGROdKH2gdwsIj8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwOCBTYWx0ZWRfX0HvUJTF5JhL7
 x3GFJ3UelKHGPsNciZRTJdjs9By2feh8I9LHcvlj5jJYIpso+7A8VYJtdKVTtssP6jkslrLv8qB
 DulWNaS5abf9i9VEqH8tE/Z/FcqlmRltIOlWQi9oz98htLUeUqIPq7nyNpzAaCgfOq6x4J/2UA/
 Pbod63COGzStDGIQxNAmAg6layc+sBL03kQ+XrWGj8g62DZgUaPiorJ7WmzFhn7qv26D1DTFPVj
 ImDam+74KwZgftF8okLgz7xZl/uirKnfsZW6aVFRMxfb55O0B2WcqWkNEaVoyWatKmmjxxQoDNT
 /PN7YNGS7aJ7GtTPslVoIxK/J520Y/M1OqC4Qy/VmfV49szXtFqdmacKUQy+SkfL56XHwoV+I0d
 jsSYC4cizlIz2cjhtQhqD8FwFc4zhFoBF+vs3qNADbfbYp03HFjo4zfU5VZ09kZvNhrWUiV3U2v
 q/p3VWh2qjNorx4JfXg==
X-Authority-Analysis: v=2.4 cv=bMYm5v+Z c=1 sm=1 tr=0 ts=6a75e16f cx=c_pps
 a=0joluOkswiQ4lQw5hT3+aQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=ap1EkQ_LMH9D8qkgfA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mN4c6OxSPZFmfwvLDOzUmDojHrS7RG7J
X-Proofpoint-ORIG-GUID: mN4c6OxSPZFmfwvLDOzUmDojHrS7RG7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070108
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=jpkF7vMPc/a8Oen
 P3OXV09oyFARv40ARyW9xLEcvfN0=; b=IvW342KqKn6VFTANIh1g6gHpkVeXK/s
 LaLbWC9FzCkWYpE/kocYKAichki4e5GpGLc66s2rpCA/+NbM/79NtPI8g5GW0Djk
 SmmrgiEHmIw5Had9jZ0Gtqf7J93ABZUfvWOSP10jqEnIOpF3EYk1K5L05t5HsLcH
 NL2skkVs+SgkXAqS0oPA1LFFMg8f3kYdhiwsy6kdqaOBdQA107GbMix9vlL32dA9
 QPjCoU7k8pf28a37raD4FkANzIyqMjKhjV4D8iCLWi/kbTPiYhm2ydtLIM1JIZLc
 QRSYRRFuSc2eJR2QK9DYJ1jINOkgv8waXs26TXXVDLXNn6XObABR0Bw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpkF7vMPc/a8OenP3OXV09oyFARv40ARyW9xLEcvfN0=;
 b=C1zLvCyT9931rOIwche0RTsjRG5+fZ5YsENb0X1HZ0EWCqEVuvBUXRKLtHBupL41taRYOQa+nhQ06Y3lD3FV3ZppYXF/X0IggCHIJ9jaiNwQs+g5e9jAKkNoNaKGm6cnithmiyvfIAQLYt0Ufw9m5AV6+SzXy4ePCBIwPb8Ufvs=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=IvW342Kq; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=C1zLvCyT
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On August  6, 2026 thus sayeth Simon Glass:
> Hi Bryan,
> 
> On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> > configs: am62lx_evm: add initial defconfig
> >
> > Add the initial minimum configuration needed to boot the AM62L3-SK
> > reference boards.
> 
> The commit message refers to AM62L3-SK but the defconfig is named
> am62lx_evm_defconfig and selects CONFIG_TARGET_AM62L3_EVM. Please make
> the naming consistent - either the board is an SK or an EVM, not both.

I'll fix the commit message.

> 
> >
> > Tested-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> >
> > configs/am62lx_evm_defconfig | 138 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> 
> > diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
> > @@ -0,0 +1,138 @@
> > +CONFIG_SPL_LOAD_FIT_ADDRESS=0x83000000
> > +CONFIG_BOOTSTD_FULL=y
> > +# CONFIG_BOARD_INIT is not set
> 
> Unlike the other AM62x A53 defconfigs there is no CONFIG_BOOTCOMMAND
> and no CONFIG_BOARD_LATE_INIT here, and the .env file added in patch 6
> also has no bootcmd. Just to check - is this intentional (relying
> entirely on the default bootstd behaviour), or an omission?

The downstream teams modify this for their needs[0]. The goal here is to 
support as many boot methods as possible and let meta-ti do whatever 
they want for the downstream fork.

[0] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2026.01&id=c754b0419ef89c20e0ffb5e1beb82b4606953b13

~Bryan
