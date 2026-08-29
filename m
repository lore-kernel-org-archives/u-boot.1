Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B34C61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA44580EB6;
	Sat, 29 Aug 2026 14:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vUlw3HrSXJst; Sat, 29 Aug 2026 14:34:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014086;
	bh=h1dkbltggsBHSeD7wNF+pdOnfvlVHrwFeAnTGslsRI4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NJNYjplpRUQMzQl7yBbkfPWnOMnZtwRq2XhRwa8o3i1BP4loeyQtDQK0V934cACYj
	 I43kd7NI7TLPHv9Xkfb20Aurx4bVlWOFEKAUtA5BLNUVpxXsr8IyBq+UJLmsigJ0Uf
	 jKzYi4UjmEXEZD/Kilor15461Q+RDNgiox+eB47+h3WdsNNMqwOe0mBcvux2Yn716a
	 S7R4STBUz0jCwEVh4d6gr2h4zhGUs/4WXH1uuweZx1kkK7Ht26QnQIjPERxMfAIR+F
	 ge784tXIUHzwv2jCLifc9grQCEat4zdJhz3Pzxu4bSVMCnlvU0jMCxsDvMTrZ9Gjgh
	 GoXfz8H1NVnEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CE1980E93;
	Sat, 29 Aug 2026 14:34:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73230127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 599E680E7C
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZZ4jLpVyqwR for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Sqk7l4xi; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=UPgVoPFS
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6DC180E7B
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:34 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxglO269823; Sat, 29 Aug 2026 09:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=h1dkbltggsBHSeD7wNF+pdOnfvlVHrwFeAnTGslsR
 I4=; b=Sqk7l4xifVEARKJfKKX2erW9Dd76pO7EXjqZPJvGz1BUe4XuOYv9iDew1
 e0CLiJDi0/pWFd6RAtVC6rEtJui8EvskZTnFKYYHFdPL0JRPKIaQCuYYDA8dmk1J
 oXPVINwN7Dv+OLoZ5xZpazMuM/HKh7htA7AGYVEMnpzyaniJ3BdtMihSr6Dtz0Na
 MLC8JQR+kzhLVq7Jrsx6rL0yQNoEcCaF2Nt5Xg5uBkUdRmwVNbkhJJhziw8FTDXR
 yLHUYaf6N53bSinQ+Q4fobLB11q1J67BRoJuXl485RtINfej5CnRpmQuUEW6bYPr
 suVXv5FaAtLv+cGicsIjmUUIEOfVA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqn1hrtn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGAcFh7GZsP0+u+n5NDxZS1x+IDtUqDS/r5mXDnCXtovkwth41cZVbM2rmqwdtTffxGBpmUpIp5UqPPVv1F77y5temSkeHJWshEZ3b/U98a5iTsexqZweDg5lJhxnwNRv03oOogjMJE+4R8tw4lFoNb8taBRSdFY9jSdn25z48J7gkNZr6duzjifgw2/LtVdAd3cFprBDCMviJcWfCEql3ipkUOoRLLdT2E53zqs2JInV9BHhRK+zj3xI4vQBxoIL3Ywnca444UB2agcxUblZ2vmpjlF1PuHFZHi8sZrubMlNP0rYI9Kt2xRVkOER5v3/Vc3cWUlTLpmgr+059DS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1dkbltggsBHSeD7wNF+pdOnfvlVHrwFeAnTGslsRI4=;
 b=TKcDRC9VsCRg2sp2TGNOpfZIZ5Pj2cVOW/cIVQQXxuMIeBsAHnME4VFetELsJ3vYPaCdJKZTquQ+JfnybyouHXMWhvN+hu5RxWLgKO6i7Yl+Js1ArYwBLGSfwcP/9LBsRCswycQoClAe0W80HP8lm3rDWEYi/4e49nbJNQpOw1vJzwk4cNsdw+AuckgMMu9StLOVrISKa0VKEgVWdCQ42xPwmyEqAO/tTE1yVoykOkHEbUmtMEXGtyKlFPPn9OH9HDqIXOwwV73cD2mqRdXsYhFzuYBDmB+lZ/YZaXaBIhOqP5jMQHvd08tTulARFdA3mlQK6EiUV5H56y8jSLaKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1dkbltggsBHSeD7wNF+pdOnfvlVHrwFeAnTGslsRI4=;
 b=UPgVoPFSegBW8KR9v+P3Ytacqr8zdWo/SvxnX5m8Ebk9AM9GsZq9nQR1XF551Q5tuZAlwvS6Tra3hW+ejIKklPxlfSoz8gmn24yeVgBDmMPTnXdBQqC6jG4u6LYJL3u4sSVvZ80MHkce0E2kx1rGGSkYzMBgIWUhgr8GlJZrDjY=
Received: from SJ0PR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:332::22)
 by SJ2PR10MB7859.namprd10.prod.outlook.com (2603:10b6:a03:56e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:30 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::11) by SJ0PR05CA0077.outlook.office365.com
 (2603:10b6:a03:332::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Sat, 29
 Aug 2026 14:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:30 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYOvh1551084;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:32 -0500
Subject: [PATCH 14/14] board: ti: j722s: update the MAINTAINERS entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-14-e4e03971e14c@ti.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SJ2PR10MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce70735-cbd3-43b8-bd0d-08df05daa302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: N9QpXjqqJEpyoZbqj6tsuW/4x00tN3eJv9J2VTOyhAQynAPGtSSgZyed8QprIN6SONLmKxExc9yHH8O0+J4ood3I/YvMxSYp0zxID/IMhvT9CDDlt6DCOkGa5DltpXvyZMfhuxmLXBdc6Rv3Ky6s4+/J7bL0Xlbf10zavuCNDODfwRg4NTSoSxWZDvzGtJ559u+pUK4o9D0WqSe7CvwXDbHwwgMkndNH8RFrmuHuZIbXvo6eSrP+ZmV6G1iSzupHVsLrKSzUP1girijZtGIXCb75IZt88IeaXEYRv7105U2BKqjhB5BcQH8tNSUqQqhJnDXlH7abHGvgdC/w129CiCX2JdfsjSH379x+OOTzelpBny0o03KpBCzlZE5/kE/Vaqnedd1qaQPkVz7ozWcFn5XNkJ+ZkxLaTaUaYvu8CqJF/1SLSkxj6p40zdl25oPRy4fi0rxMOZIEYtT2HAabLqFzaZWvGBAGbpQqoY+05EgdECwlLiomupkJP9kY+HI0EHSA0Jx/JquLZVdu7GunV9nKeOLMXKpowZB35Ju3FzCYR3/uapu5tiaHMwjBL5lr0I7KNAEciAOlbdoVv+xE11ZKGRI/T1+0j6V8s4l+Xj4bWDozgRPqpAXiA75LF+V4CoFjJeU6o7BWv6uos2JUiXC3v8dbQW1FXP5VA0DMf2bXv/mgbkURAtImIvgOCQzyXZE58lhpmSdm1V+Cj4PiYg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pSgdl2mTe4GuMtwEW6XhJ8I2H63V09j0XI7bUWstpQp2V+7j8R9Utmw6m0kEFRQ43aTgJeQZf5/PLocjjamrhG9pUG5J4QKIloDLTCV9W+gHFtUedwJ0CL+Ff2nWu3Kl/wQbD9Y0OrBQfEOiZ6YCn3vAcTy/GwHN8CEUT79tXLbrSt/QuVIhC/Or+v0iFTZ1w7T5RnjxZwuE5/r4XggShmZrFDr8UYJZN0QFPklhZ5ONAnh+r6zO6iIvogYFfbk69jxyB+2qtNDvcPKkLYIO9x//fYk24Au/6t99UoE2U/X9r4djhhZLpBiIpH/qGMfV95lwu9DgynjcRUQEH5QNyy4jyA8zcb7mSjkJymJZIigaJcVcy0xQV5LO6j1OWRzGaejacMzDv0Sh3skVBCFrvOh8aIMurYVNSr3AiwEmvUS0mxZ/VODAZALUUmGpE9tB
X-Exchange-RoutingPolicyChecked: BXuHxM9L3xnYd/Ah9H+nOLtXFTdSYgwGxu8l9Uby2Tcxx0r6/ZFxMCyn2ir5h96mUGNsuPPWnOlW+cUkSdTAch+fmQYZsip8S6gp1y0nliBCYud+n8zXqrfBOFzwxTWvAj0CrZVDjyfx/E6DtLqVzpab2BZ5NrdW63xxPdrh+UD0M+WC6OyCjItYNdN1e3PuMm/JghWmEM6QN4cCvOtxd/bj6hxg6yvqkOFm2yiVBqeJ+HqRzDAljiV2emU+xucNxwoyrn8SDqFyLhwuAlZJvWSwHYSQ57aWVXYpciA7Wunrh1frnmC7JFCUhweyNwZW9AobJVxqAYcfO/CNCJh7Iw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:30.4382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce70735-cbd3-43b8-bd0d-08df05daa302
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7859
X-Authority-Analysis: v=2.4 cv=E9j9Y6dl c=1 sm=1 tr=0 ts=6a92edf9 cx=c_pps
 a=f30+ahQCdjj2/zPB7vFTLg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=9kM-Z_Fh1eAbYq6ml_wA:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: pFRI6II7XJ9OM_m-2XqA70lMdqatJVLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfXz1PQOIliGp6O
 S1sq0r3VvvBs09BhpnOq3hnCRMPvkced8qC/SxfMZxLj7KD1MJuNagd+GPkc6ur+lBfC4cpxR9p
 FyCTeIYuQVgE6yIBdhqVuXiaCiANoqMGFM7sh+0dfcxBca17W+byyzcwZTV5EvZ8Neb/V88GPUF
 V/cIVUBJkiruwkx6HtiA3AVVIbQL0ZjgsKT4Z1XDtk7ZS0vfu8HIsSUqW75X06MKZ5uloX1ywC9
 VUhrWAWoWyuqcEpX4XbHT2aKSvi6V18qiVlQcX0Rsl40AD2XYUbMPyE+r/wfO9aNrErRCw49GKn
 Lzw5kzwRiHdk7JyIq8ipcemxaMO9uGxjAsP5r16EWZxIPCpiAkFFZg8b0HIZklIRZV2K9iStAhW
 4msT+oArkzCA1uOwO3z9fXORlBvR853vgDSe2bH7zZzillnMlSxSyo+PKUR/6qrCmPwEFnzQnZz
 H6iNcX72p74aUKm4viQ==
X-Proofpoint-ORIG-GUID: pFRI6II7XJ9OM_m-2XqA70lMdqatJVLy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX/Z5YW4xHhXjM
 oPevpta4rwE9Ds+7X6l+XF69On1gnFjx1/hlsY68tQJsWhtuS3Jm6kw8N+ZZ6fvoWLdpw3UUu5p
 6BvndNvG0k7nYafx2EmAlYhZUz5GbQo=
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

There are missing files for TI's J722S-EVM board in its MAINTAINERS
entry. Add the missing files.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/j722s/MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/ti/j722s/MAINTAINERS b/board/ti/j722s/MAINTAINERS
index be1bcb74c5f3..1f6ba4199b42 100644
--- a/board/ti/j722s/MAINTAINERS
+++ b/board/ti/j722s/MAINTAINERS
@@ -3,9 +3,16 @@ M:	Vaishnav Achath <vaishnav.a@ti.com>
 M:	Jayesh Choudhary <j-choudhary@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
+F:	arch/arm/dts/k3-j722s-binman.dtsi
+F:	arch/arm/dts/k3-j722s-ddr-lp4-50-3733.dtsi
+F:	arch/arm/dts/k3-j722s-ddr-lp4-50-4000.dtsi
+F:	arch/arm/dts/k3-j722s-evm-u-boot.dtsi
+F:	arch/arm/dts/k3-j722s-r5-evm.dts
+F:	arch/arm/dts/k3-j722s-r5.dtsi
 F:	board/ti/j722s/
 F:	configs/j722s_evm_a53_defconfig
 F:	configs/j722s_evm_a53_ethboot_defconfig
 F:	configs/j722s_evm_r5_defconfig
 F:	configs/j722s_evm_r5_ethboot_defconfig
+F:	doc/board/ti/j722s_evm.rst
 F:	include/configs/j722s_evm.h

-- 
2.54.0

