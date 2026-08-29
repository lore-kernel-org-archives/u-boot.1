Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBC3C61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 637D860644;
	Sat, 29 Aug 2026 14:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4BVUMMP8vfB; Sat, 29 Aug 2026 14:34:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014077;
	bh=fCX2TIeIC48H7t0uiNzeVM1BzvLdl8LQt0DrcuYKI74=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p2P895bNHtNhSBV1V7HT8pCcww2+OwR/ArSzr+/DTl//hwvX3+X1iDda8V89fgl18
	 MzCm1OwY7E6JG/NpDjdHr9nY9eIliG7yS2y4/7GDkgeHMiX2RK1JQGFPHEXe4yzwbk
	 P2n9HaLoPE6BY8mcB9P7WKrkau7XDegZDHcQRd9O42zinS6XiVjv80e6cQFr1X1wsG
	 CiBe6YLTot0ntEU8TBh33SgRgMEPeccKN2RcZdMb6303NwHCOyoS5qb/5/HTxlznLI
	 DUo1CW8fcJwz4tu6HyKJVjmVoNqw2XQRQwt8pX3zxz3GkOtYXiMtDU2AyBZ8gZEnYd
	 bbcnP3tkUt+QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F3A860631;
	Sat, 29 Aug 2026 14:34:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 113CA14F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0331240730
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLphQdXUrKAv for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MUISe8Ms; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=oj1aLOFi
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 351034072F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:31 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxgD5269822; Sat, 29 Aug 2026 09:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fCX2TIeIC48H7t0uiNzeVM1BzvLdl8LQt0DrcuYKI
 74=; b=MUISe8MsiyCEaaRj2H7/P0c/OB0hQxYV+QToIRIbXcHqHC2KaXjdUkHLp
 cxvty8dh14TRnMVNFgY9q+ZtweukIMHlJXm/wSkwBzFyY/engQ3poIEWGF1r75DV
 FauEm8yHKPWwHC5nzNrIZaKz6a524lPasIXUP6zQcOlLk+ti7gYD805kfT4uPRTh
 1vzkXrKAGrVcr1WxkOA1Y39ZCTWDNq1P4QzbyLD98v00SzUD/npDLFKYvgeo4tRI
 uwFZqkeIEBmWvdJq3o+xY7ra3wDs99RdnAwIGF8FQX7Q3QEmF+uTp7wTTZvq8MIs
 wjA7T4riQnykZtevsNFCbD21loSZQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqn1hrtb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBaI8NSJIGkKDdPVRvHAwb/S2EWBWVymJhQW4DHnTDSzdSUme5wvcC1J8bIerp2tAxw2bSSZcuA8LHV/EcoaKBLlAToTm5A2I1qt3YnBdGHeRb9681L3ojI3WxKJkTDJs7/Jjk+GJQr3g20c0J+kGnomI1a8F9YpF75s6xDtC41Jkt4LSrPxaJFqagHqEXE2oFsifkW8HPbx0NTczJJx+YLu0gos5nlbMyU4zAvwMdIQ728iDfQZb57Jqn2kxv5ub8J+eD1/TLMAlFhcFSaGXEF9Ey6SmCA4Jds0jBm7IPsxrqMZowPuGRGQv//OZxBpeHvs0lROqA3lKNB/SZkR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCX2TIeIC48H7t0uiNzeVM1BzvLdl8LQt0DrcuYKI74=;
 b=KYJsMOWFwCpBB3Scm7G95OX0OcG/nT19kuSPgVmxE2cW7J6zuviWb02pjfrhgCHACbpmJPv2FYuwEUz1TAR5ZFOnLsuh5Hw+zo0wVndhS6fDXRjlknuyOB4eoXhfNsj20iTb0X+CGd+TmwfRtMW3uK9inhvjX5ptkynh512x7ZtEH0sIPMI/67HA1T6PvThy33ALhv1d6LXjhphoHg/CZeqJmgEk5wYrFOS0Pd2CvW6Yu6lF7z3NtZziAxGgvf2Kpuxm6CkTKhoZqPBJeLlzdp8eNgF5TxwHAcautWTIDfaO8+ej6vgH+mz4PcmY4Ap/iw5jTBqR9DAd2yY+Jj4PdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCX2TIeIC48H7t0uiNzeVM1BzvLdl8LQt0DrcuYKI74=;
 b=oj1aLOFii4m++CZCFR0V9piYpAR4BJ6LizFWl12BNjuBrECkgBN7Qu9Fmk3HfuMJp6gbGHt29wD/XaeJieKfb/tN0xXTnlUFoGTtoeODu4RpS7sI41iTizvgZjVp/dSsR3r2hTp23J+m9I+In78tx7zUX05sRNYKTi3H6uwAN98=
Received: from CH2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:610:5a::32)
 by DM6PR10MB4377.namprd10.prod.outlook.com (2603:10b6:5:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:28 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::3e) by CH2PR08CA0022.outlook.office365.com
 (2603:10b6:610:5a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Sat,
 29 Aug 2026 14:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Sat, 29 Aug 2026 14:34:27 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYOoh1551075;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:29 -0500
Subject: [PATCH 11/14] board: ti: j7200: update MAINTAINERS entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-11-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DM6PR10MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: e081ee94-8255-410e-f5a0-08df05daa0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: P+meFLBcxe95iLnSOvSnXDTxWg3cR7R0V0AhH4N34T9hZjciPwDRVLy0NHVeE0IIgZ5WlSomxtvpKtOHjUQT1v9QjyTQCaflzP7WjWb5izZnSKs7uXAwQrHo/T/CUIJoAC7wCDDLilfkZGU8ILEhx9lZIfhLTM0UMuc+TlJvL9Y489FEJLoinUkbsk06Xu8f0113g7DOUUTJ5Nn82mvk4p9u/O2ebBXExmlC0vUb+CbhZ26+bCF0lu3mzJ+aXFcM12DCGwBvVvpyPnKQbvQQYtdpJQkQ7DKJRF6Sd+ZjVZQTIfrYo/sgy5UJD6rvRp3UfmEUj72DKJyGzTf6C2I0EMJK/rYENB4MlCYLtrqj3YFl7FLkgmBiHEp3JrR21LpeALzCF1CiQDti7R2KV2tTFJnfvZPCEHvxw8Q/KkU0cLD9zI+3HrsxojcWCZSY732p9yi04Ko3OzJIvbjQbivZ3KapsL9G35OySk6wNt2nK8YGEXiGONAlLjpHnK8KOc9vw9FenYfA0Db4IpyvNOHrr6wdkcQ7ul+h/hAV3/Ha2WYe/qsMdqjiVLfRaOT3pTmdrJF9ouQPQZiZ5mtQceKonNf7cbD9rnhR13/uWqNSBcccDT49l4ZZL5puSJs1TwybQBllX7i3UazKIn0zz2sEHuVxwiG1snrfCeeC9ZZgBlA8DwOR7XZoMZsoLNhN3PmtKodomw7aqnI6mwSbI2BWCw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q4m15UmftQLBathfVHS1p4MgEzEzYDZsl9AqgsYoAhScrookkJGJFPpoqwwf+NK3A91Dk70GvaCEEXj54E+SSC7X+FqpmC/TlipphVWAg3WAOyii6UGRAeURd079Novqvio6MPHUrSFh7TbqaKeV9uAbFNOTk0BGRLTK0A3PHvuWwJVTUP4dOo6lDRFKwkyeWDy2aIkZzDgTjWwnc+zRGqngq5lwqQwVn4L5Ay0Oe4oxsGkFIN1L5egi1CXP1tTk23UTNrzD5A7itF8RH+zcvKOxIZbpOz5mg6uXY6UhCXrKdgwaxZ76+JLkdv97Dj6mVHarLdFBRcxcIme/Zp9MQdQ0vi6XT4PbUATR/cP3+gTdjrd/CIYE8/pRQW1ozWdsTLDBRvBfLTuelp0TmpbmPuKSX9bUCg1y0iGMqnBohuZcCj5Mih5T2MoqDyK4c7ZM
X-Exchange-RoutingPolicyChecked: TeQD0JO0uyeneRFTXxMJ3P1CKnzDBtfkVvGI6uR5pK7fKEa6fUgf+E+JE8g7/SqIUwn5EU91Ti5v8JRBJ0qb7V5mZvv+AqLKJBXvIJTZZqt27c7v7XOYEUwVF7PsOVDjiknmWGT4D0DOMDvoRD5II+a8EU7m4lWBjJ4d5ySqbFR24omXSsAcTfUgrYjsXMJbnjRGHjOMkBbBfIteOIkjxwHOqbECCOyW9LTGg7tlsc6oqjIBxCJ+Udj3HUvuyctlTNwg4dJ1nLZlSxpVZaif4StIN0cCMQK5pHFkGdXmYf65CdKYAUvCNOsNcM59DZDqMVUXQcb9LehrQSqxj+bFoQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:27.0044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e081ee94-8255-410e-f5a0-08df05daa0f0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Authority-Analysis: v=2.4 cv=E9j9Y6dl c=1 sm=1 tr=0 ts=6a92edf6 cx=c_pps
 a=RIETLMKpmuDvoeNDRfR8HA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=_IVWGf1E3kI7B_81zJkA:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: YtmhbdHB8m5ijUc1fF9pIee23FauGXv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX9MDBLx4ZZHMg
 5Bn2ETRj0zDCuCQip111NiY9IVV+aBDrecv/dZRET6anxWMmOeYoJ/YElZtBByRR9YylknatpbT
 psmdfK/i2iK1xZ2SedLa5u8xDTD72rl26W5H1zmJAVIdTNL3YJazwIhv+8vKYyCSqtM5Iynh0eu
 oUzTd9zotpXmY9e9fbpIW4XCWL9FvbKBfQGM3C477UtObWrcZMS5KgVxiAD2l3i0hcQWtVwNnSj
 YZ+C6mI6s3lUyA3iEI5yKy3cGA0+or4NIPld+iqrQuUcZHPuA+1Jj1/Fw15xt4SxhZuTBGLRCwq
 1G9xKCsvM9Wv47nhOnPQlbMRPwFuP/rPtMXSRqhoq/4TZqOOqJ/LDPpZLctFTbM6OENAn+OAisX
 LdquSiko9SE7fu+SWy6nX9s1c1sQm4N36n6bWik+zLfWPUafjqk0MPweaqKuxFd4g4cHK5joON3
 m2W7Lu8DHLQWm8i7eyw==
X-Proofpoint-ORIG-GUID: YtmhbdHB8m5ijUc1fF9pIee23FauGXv2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfXyX9bw66jaa5b
 8aR12vPJMko9Y9EPFiurKUyKB0GVqjdW4j2Ul1ApQXtP5id28O2Iou98Y+omONrVqztVX8ySncO
 xGafMT5hTjaZCNcIkxj9d7c2HtRL8LI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290125
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

There are some files the J7200-EVM board depends on not claimed in the
MAINTAINERS file. Add them.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/j7200/MAINTAINERS | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/board/ti/j7200/MAINTAINERS b/board/ti/j7200/MAINTAINERS
index 86badfb2384f..d259192040a0 100644
--- a/board/ti/j7200/MAINTAINERS
+++ b/board/ti/j7200/MAINTAINERS
@@ -1,7 +1,13 @@
 J7200XSOMXEVM BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
-F:	board/ti/j7200
+F:	arch/arm/dts/k3-j7200-binman.dtsi
+F:	arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
+F:	arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
+F:	arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+F:	arch/arm/dts/k3-j7200-r5.dtsi
+F:	board/ti/j7200/
 F:	configs/j7200_evm_a72_defconfig
 F:	configs/j7200_evm_r5_defconfig
-F:	include/configs/j7200_evm.h
+F:	configs/j7200_evm_r5_defconfig
+F:	include/configs/j721e_evm.h

-- 
2.54.0

