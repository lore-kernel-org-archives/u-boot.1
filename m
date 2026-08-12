Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56617C5CFDB
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 21:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17BDD80FD8;
	Wed, 12 Aug 2026 21:13:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ryqf1JDzhk6n; Wed, 12 Aug 2026 21:13:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41FAF80FBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786569226;
	bh=UIiFtjVL4VpeUEFKptICQPpOVE438QaxovJLeAIuJiQ=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WFMPO56zEFUCHdFcX+TK7U0uet0TiuLZvUt044qW51X6zOur1bx+5oDTZf0M1L8+i
	 H/nq5c8fbMcjUAsuFSo7+/Feqmy8h8UtY5MehVYyMdrru0Rm/NQykEAa71QRuVwHbM
	 7ZnSUWY7pz0dhSP76LjouGY6qDOyuo1uptCe6nh0pLz1rrHk7WoYtacRWK3T11tuCl
	 ZROgkbHsMELsg/LaGXpFk3TXGFqrVxnsDIGNjLPm9NX5LM09Tw/tpRxv0Svy3VGooX
	 BV1U+QU5NtjE1KONISm6wawqkySDYON1RoGckItBrx5b2Vt4TPTafUUoWI9W7e5Pc5
	 zZUET8e9ROX0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41FAF80FBA;
	Wed, 12 Aug 2026 21:13:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CBD410E
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 130C4607A6
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MaI0HUXq4wFX for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 21:13:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C5F2560618
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5F2560618
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5F2560618
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:13:43 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK0Gkh862782; Wed, 12 Aug 2026 16:13:35 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g09c28eba-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 16:13:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk8taJT8vDXZIzMiqrKeAo0OmulShuZebgx4X3T39r4p/abTjtvMFHdUuY2zGxQ9/xxh5YHFg+PE00uG8mP3afcHN62qyDaCezCbPqNb3zThn1TeftsrA8t3WhOkBfZ6cKAzIjmqp9Wbh54kuB9qRELlnY15NDQFRxKqtgPiK9ip1TeioD0QEKJZH96Y+FsV65klNyP6LPm1/vNGWjOAZOki/GsSH75i1rdRJ1i4bStNa+m/+5v/lnK1Uh98L1F5mEVZMldTErdgTf10mW9JTVEQFhkaK5bIv7XUv2LEBhHFvL9GcGEszizQA9D4jjWKcCEp2fyU0EkB8KDoxAqAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIiFtjVL4VpeUEFKptICQPpOVE438QaxovJLeAIuJiQ=;
 b=mlBMzew8jdGnqKIE5vfDx6jWtQe3xTb8s35triCk1mRN5Yfaitc6/UESkaISO6khqke1ERtdHEfIVE6aiP/LMktPGqPQFLBl8blH5VIJi+AN4Vib4oTjXwMGkb+HTpkiiHA5kmAaPCoC1u4fsw7BWcLR1SDjNBDGh9SghL+roiB+VWf2InneZs05tOmvkM1YD182n7zjTnRmqxkSD2pq9Rq5wkbB8yfOxHvs0lNapY3OnUfogSU4GGbNnCLElm6X6f7na5SrWpLlFT6r+05TEosFpGgtMbks5Mv/uxGWxa41+PB4LpnKtOZXngYfWXZEN+W5FlflnBBwSaVBQ3SCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by LV3PR10MB8081.namprd10.prod.outlook.com (2603:10b6:408:286::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 21:13:32 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7a) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 21:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 12 Aug 2026 21:13:31 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:13:31 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:13:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 16:13:31 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67CLDUII3806284;
 Wed, 12 Aug 2026 16:13:31 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Aug 2026 16:13:30 -0500
Message-ID: <DKN9XH3S6N7S.RQ3QUR9VMS0S@ti.com>
CC: Joseph Guo <qijian.guo@nxp.com>, Emanuele Ghidoli
 <ghidoliemanuele@gmail.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v2 2/3] lmb: Return -EFAULT when freeing unallocated
 memory regions
From: Randolph Sapp <rs@ti.com>
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>, "Randolph
 Sapp" <rs@ti.com>, Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260811231650.3150771-1-jonas@kwiboo.se>
 <20260811231650.3150771-3-jonas@kwiboo.se>
In-Reply-To: <20260811231650.3150771-3-jonas@kwiboo.se>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|LV3PR10MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c7d3b7-8c80-4aed-0076-08def8b6901b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B0FDg0GUQngxeokxcLB4E8IxACL7qNR/aYbhbBryssZLF6KZ7RzPZdB6fIMo8dKfgBK0/1/r2ZMwqI+eRRAafy17lNf+suA8XBZdeFKKMoWZ2T/Qnudxa2JqI6Y1z6wqH18Rxye4Gl9AAncU932lqH596GXfsOaEWlbF9/VarDdXrlKoZU6nDVdSO6FcghQJsseSnq24THyO7RM3bhLjNlYMIQ7JoS/J2k6iUaU1fqWfYx+6oGKoupifxrR0cQ5t2USJC4spWez8T5Qyw/9X5gqW23dQu2GMFcWb71qiXgv3PPMJfP0OxQFGmgVO7pjCl2M3FEsgkvpa/n39IoAyVLfdEbD9uNyTC4hA/nD3e73VDypANzCfZe8GhrXOjs5sfuDxnOO8JeVZhPjSErG37N6CtrIDXvNerzRt7nJi68JvWRyEZEOLKFZ+4NchHZZrok8Zk3LTrf3NPR2nqytQfU5goopt1a697VKhHHRcp/i2PsOPb5MrU8BVJ6a7kd53KrdYl3gNga2p4vj7C7bRXxUoJGCo6uscFEDz60BzDcFqhSBq5uHdpECpscucImQpbiOz+EEvye+4hgn7jjub6PBFvnBQjAkbykxs/uebsYaz02mCnba6dd2oTMiWXI0faaFd+ALAexj7yiJpnWdRuMDccJVDiy1UBbwBF5EXJN6JBPOrCV5q+RcMYWzl2zI22tYSc4/I69VsN9/NUq9/aA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +PQ0R2wI/UKoFxsqEoVX/AOLiusdD3SAGicPWPbf8sKh/fYiOi+5FB84QwqIHRStcGSDsZF8GVYV8YdBjGJWnFEoyLd1fp35YTaehYUg8MB4ESs6SN8mFXT/ekXx6KBI8G7Z1XN19OSt1LnGsSDoa2mFtSBQgowFVFGAtEHnwrnBQrL9bxvxH/+WNfZGLltcIOrL/OkUqgdlQmrMoFVNy1ox5hgliahN8WWgEEvjZnonEiTPZA5OsQpoW6IYOlEtr7G7bkJMuzldQj+bhtI2/UlvSqz3PJveD2X5k2HVjdYel1ocSylsRqkJzbcbAlV4rHx2lTSosw7VsACb7Ox5nU33HeEMAN2j2Bic0KOhUzlTBR0Qnpwk5McpNI3V8GPq7AmCM2nG07g4zNb9Slz+7SMY//FGmEbu5GZ17cmP83DgdroylcQI/TgLPpvZ3yR6
X-Exchange-RoutingPolicyChecked: TBdW2gjpA/JTksTGsOg5B+uPBg9n82kWc0APykapMAmd5w5swPHrN0wPdWnw44PDAN/TgCfRfQCdcCtcl36AWOgfZGuEzvhH8j/KhtsnPB0EEEW4vMGcU5P+cRdRFCbnnetuffd/q0uRg/ZonrvsebSdgnh3blFfJs8kMrlz8QUXAgkXaipIul8Uwm4wu3WhHqorTKVa05qxLsCiuurOouCAY6XVuAVGFQLvkfROP7T+H8OheXo6P/snAvJ7RD1phOrfHfwERSQaSghNR2tRf8fGI2GxP9fqF9hmx9rQRcmRss5vXQug/zisoHqUDwQ4Y2l1x3EgVIf3QlWH7tINuw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:13:31.7240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c7d3b7-8c80-4aed-0076-08def8b6901b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8081
X-Proofpoint-GUID: _tj4oakiq1P5kEwReewMl2ILn_-X6YAP
X-Proofpoint-ORIG-GUID: _tj4oakiq1P5kEwReewMl2ILn_-X6YAP
X-Authority-Analysis: v=2.4 cv=PrCjqQM3 c=1 sm=1 tr=0 ts=6a7ce1ff cx=c_pps
 a=b4Rf/daEBCJdqA7qdazqbw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=PqL_RJajhC4ndKbi--AA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MCBTYWx0ZWRfXyxZURz7FfV7U
 wYls5WG7DHuoyfaoYIRBAXe+L5XaZ9K7oz0jASkvJu4epQru5HdB/cTScZCJbWokMMGThY27PCE
 zklSmVCCuuV5pBViHTwtdmibPM8us1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MCBTYWx0ZWRfX0doOpKxmURwz
 pXpDpaJ9kxr3/cXL/HaIPyidNxjWrHsmOw7JsPNqEXyoTIqcjlng7y5SeDDYnOAiSlby/VJ9bPB
 /BOlNAqZReDIPXkP5+9gsAffd29J7s+JVm0bhcWRxWtfX5T69oglxXOJ/AjbfF2Nug2DCd5g6Kk
 IjUSgFUQiZ1LJAj4/xqtL5KR7BYKs2i8I7G0ngjvgIOwurAdXDZiJD3D7eeTLLXjkQSGoMKEmSx
 z+J7e39wSVj0eumRttbuoCI9kL/4CgSbqrRGyvDO2xP5QGYLZ73Ir9Qsu2YpmCVVnITZ1r7bJxA
 3LmMCffXVjTG+OG4+8kcWEr+6WCTPr5YkOThi2XDD98vnBo/t/1CLr1/wqC4UccD2nrwCHrV/jB
 fEZ1enOHH6G6ijedC7CIQ+ueOUv47Nu+GdFx7AgvaltpQRjUjaZuugNs+wTeS2fdb3ksfK0Hkt0
 E1HHocT38wRP/g0T9tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120170
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=UIiFtjVL4VpeUEFKptICQPpOVE438QaxovJLeAIuJ
 iQ=; b=mrmpDGYpAd1p/79Ki1SyRaHA5qwb4SSgoLUpegRwMUxbP8x3yYimI4mtG
 o3Cv73s+1qw/aR7lGl0l7VNGPCJ2w/FsIVpuKo/w7qC9r0Fpe7F6eKjAxpL13G1j
 bTLfb/v7t2gWRdbwlheZjUrnEDe/MZUMbtazs5W2A1E1MnAXix5jjomTp0AjuQ6y
 akItBeeGhAR3DneUdrMGgJcotxf83djYAY/6pLK44w95iTkZPAHQ/UPdFHUYaeNN
 Tc6+UXjRSNkrDg4gA8/0U6OGkKLSdBvCA9Si6ODaNVvk+F6zxPvl2JNa6rh98Dpv
 4OEcOrIta0DF36/a0/TVLxT/AcIJw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIiFtjVL4VpeUEFKptICQPpOVE438QaxovJLeAIuJiQ=;
 b=ObWJYhZZoIEzV4kF6xjnEmPDND1lQrle4z08tehyKTAXEKuP2cT3ZE0plX9NMrVKpqvsLurYasiCiy/qeyodSQYowcDHiBsTOX9Cp9JIDXGUb50oeotsdehsni2yRL30dEsUcewyFXTALPwofqUsi5ukev4FsNbkwrYUy9iJedg=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=mrmpDGYp; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ObWJYhZZ
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

On Tue Aug 11, 2026 at 6:16 PM CDT, Jonas Karlman wrote:
> Make lmb_free() return -EFAULT when the requested memory region is not
> allocated, instead of the generic -1 error value.
>
> Document the updated error code in the public API comment and change the
> LMB unit test to check for the new -EFAULT errno value.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  include/lmb.h  | 2 ++
>  lib/lmb.c      | 2 +-
>  test/lib/lmb.c | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Randolph Sapp <rs@ti.com>
