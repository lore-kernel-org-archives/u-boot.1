Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19427606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZxuUGsTq;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=E5mDVITP;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=GP6q8nAS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92FF4606EE;
	Mon, 26 Oct 2026 07:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cak_m9GRNx4N; Mon, 26 Oct 2026 07:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A587460645
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792999029;
	b=tMJb1cSiHERh/dN/78+fMdJwSkGrQxiOQtIC3blk6Lu11nEUt0M9+4OU8Sq4MOL9mB8L
	 CWOFaBd3hnKLNA8OLEtWOJ0xEa+pKk0Jgv7qlRuq3GvjSGIJzhcefLxAMe/1wYCZ3p1+t
	 enmHPWEygYaGWFSb15xLWIoxjWl736WJN4L5hM1JTWijOrl7QZFEYwQtteaLrmizkOsUe
	 qaKlWuYgDc7b5mj1hlrHbLwykT0Gf+7QPzL+8wMNrbPtDplIKSGdZI3XtH0+DfFlFSlyK
	 fzSqRO8a4x+CtQlLoMFRSI3Guv+xBbEMJfg6Rfi0c6fHMWCA3lGZHQi7vX3laBgzr7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792999029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KAyKvTSgNqOFFsCB7sdWLNhRPBTNEmM6plBYmry6Wrs=;
	b=cHuYny7O6za0jb4RL5mh1X7oHmtiuwZ9eigrNlEP9jF+P9dAMRMY1fGHq+l3Txzq89y9
	 wgH8upN79cCWcsOxanAxT+OwweJbUmOXkdLQQ96XOFPHpkPUfRuq9/eH/VRg1NDVYQJAd
	 JZB1B/N9D4fal3sdntGaEi8wvTDZuYChss+AxGgnG55Lf3cdnwDoTP8ZD7DROGSrivYfG
	 wCvOFI7SVHycJGK36yb8jKVdqXxKyKB/VuNzJ27T+92oEBjFVSW6D34rwG1N1QIEeGBy6
	 XlRutmKJFyOFLOXuIOvwzdJTe0WVK3tujodMq/8xRDyMigF2t3R3dYwVxuxBIv4rOtA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792999029;
	bh=KAyKvTSgNqOFFsCB7sdWLNhRPBTNEmM6plBYmry6Wrs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZxuUGsTqbc3/mW+79mONNX3XKV7e3rdpwdAHRtBHoFNfXLjMHC0iD/GkiPZpQzjfd
	 DmafXbxYs//6GQS2mzJtzLqtVK5gzKA7Ib0LdgU3o2TdZll9KQNtwwghSY70s4npgu
	 o6F3xPjqVZa5ggP7r7MYRx95mUC8/B0KpbEo0Fpu7UX9JtrmGeoFL7SCu9UjOeXTMq
	 i/X5cUxMHMJWH6xHBA059T9ZJsZ99rjcuRXzuv83pDGHK3CLcIl4WcHVQOkmbYZkAD
	 FRfK7j8cGZ4U5KzEOfL79/pfeNi0rAE6N5KybzFU5KcBayis8qMTYNI1jL2MvWZIyb
	 IWIsxcOPGE8yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A587460645;
	Mon, 26 Oct 2026 07:17:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D94FD334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB93D405F1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Go3awjPEI-k1 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:17:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E156A405E9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792999026;
 b=ju4U59gUdBWk0CsnT+bIMVB4du1MOVhcHzC/CGLr0c56tcjwKVHns2i5zza3tULYzKKQ
 3k8ppTPdiwzGimAk4ZMpT9/Q64UzNIvsbp4q4xGomWJRSbbo0GchmoI3r3UKH+rsQN6AN
 uX/MrQzJrsSDMJJioF0t7hewaK0fnFhAqPUVqJPnra+cFxWZEMAt63Hz5M/4n7kEBfWce
 zDhBcmPUedILmx9uwFAgggfYBU1j1xzdAHw8Vgf5ydggraG014HGq4+mL1837nKT1JwCm
 kla6O8qJnT45hnxVYYrRWjQHuk2PLp4ggVId/hPHupGFKwatJfGiDIxmyoRIykoMejQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792999026;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=KAyKvTSgNqOFFsCB7sdWLNhRPBTNEmM6plBYmry6Wrs=;
 b=qoJVPOgVMb4ASqvF9DipdclfGQ0WLtK1QmET2RBfFm0YqkjuWCKI+0sACzr1VilHGYEQ
 3f44kOSYz/Pjao12R+GdFsdqSS5XpqEW1eikzaWbB4DpadAT/gborky0GRENzphEJag0V
 akt25ge/xThSjLtdgKKenB/xVkvpdwPjQTyWAKaxmbszZo+FG4ZcQ+63uGhDJAA/XvKoT
 e9RhwdT0F16EJBirEsDN4n+CebDKUFlit88i1KeTA4rHk+QXvHfUnpNV9iA8sESbmhf0v
 Ku1/0VyfDPADeDEfnGcoexIVHS+uY/ZIpQpa624bB3Cuh3mLR8XnMtuElfvsoIATL4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=E5mDVITP; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=GP6q8nAS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-jain1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=E5mDVITP; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=GP6q8nAS
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E156A405E9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:05 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q2Mmah895892; Mon, 26 Oct 2026 02:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=KAyKvTSgNqOFFsCB7sdWLNhRPBTNEmM6plBYmry6W
 rs=; b=E5mDVITPshCBngaI6fFAGf1Pg98rlq9l9aPwvl4vaWmaw0ljQS76sbNjK
 QcaFRm1WEZRCQ52/Xgxyv5KdVcpMEfO8z3q7h7YwmC+XORT4pnM+kCZc0EhUoH+S
 IYzzrjpEhhRqxYxTqQoKaXFoA+ebktQsgirK1alpmVPhf0id/rHpSnDcytCZgdgq
 LB8o10hpyU2Tv3+nqwM/3PsfEcW77BJ+F0i3ClreBRhm+Ss3EnNDUNKn/AaTu0ov
 CE2zki6f+tZkNrO0GNhKH9+8U0jcLOoXav9INguStcgyxRQuGsR5U3UPMy6R9HMa
 rVHHtrUOoshCM/55dxw6OXlxtiU0g==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hhbtkccqs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 02:17:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5zExsZ+/eKtxGXCV8Yn6LtV+HNZvIXjIDnk+kZOR1UwtrV4kRfZ2M8g/8c6jKcuZYQn3udnwdunQaxsXV4bcGgA6NssQCBEyLvEW+jWVp9K8i4VO3pUVf47/Rie3AJTQaE4i13wTCmmDcf7EQw3u8bDfDpd3gzwZgSO/6t33Y4mlTVpibR2bOqlaGheCIdrlHfsD8gu6Kv9gSOG5TGY9DhVXW6Cibp9BSjRXHhIdUJWmR1SYkJBt20eGIeHtMJuOw0qo2T/rxIVjqJVF3NV7mduM/LbrD4guRla9nUP2kuyynyMug9eK7IXtv5NMsc+XD9UAIeGTyZzIiAMc+rF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAyKvTSgNqOFFsCB7sdWLNhRPBTNEmM6plBYmry6Wrs=;
 b=JCbq4b/WMoSl8t3z8xQck7aDIBtCFGFhGdml8xlVjctrQZIBKHgKlfMLzb3MF35U4X80W2JnvUDLZKAUcZ4U8UK7+X3kAfnttuiQr6g/l8yy2jnjJOHe+Ggci2Rk/08EJuxMZ1N9JXepKdS59MGV4lnO6xVQY7ua6O4EUQoLlvvPtDpkrzBSVpgNIA5ITOJWtzWMb+gz4iO5jb+GWzs0GcxldUO34AMBHcM10l8p4cJMU1M+TNUPhmeFs381eSlc7W3e/KHwdVhOSOm8woHJtc62sWRTncf0bRdTZzRwgq9dERnSgXT5xGCQ3qsqEL7EL3y8QRjCdfdHEB68HGHUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=nabladev.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAyKvTSgNqOFFsCB7sdWLNhRPBTNEmM6plBYmry6Wrs=;
 b=GP6q8nASIKAzCKemrSNAw+LdOaovDpl/nKrG1BIzCncek7clwxKolJFMn9kqzYM8HHecrADeYr37dPmUnk4Q7KRckfQx2E40NUGVhwPWPOsMdbkvcIoClEZVm7ERDo7O8fU0YULheeAm/NWtUktMGPpHiXrto2GcvW7SZRClgiQ=
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 07:17:00 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::54) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 26
 Oct 2026 07:17:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 07:17:00 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 02:16:47 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 02:16:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 26 Oct 2026 02:16:47 -0500
Received: from [127.0.1.1] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69Q7GgTS3511942;
 Mon, 26 Oct 2026 02:16:46 -0500
From: Swamil Jain <s-jain1@ti.com>
Date: Mon, 26 Oct 2026 12:46:35 +0530
Subject: [PATCH RFC 2/2] i2c: omap24xx: suppress NACK error log when
 I2C_M_IGNORE_NAK is set
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-rfc_i2c_nak_suppress-v1-2-bc01e8393b9a@ti.com>
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
In-Reply-To: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, "Swamil
 Jain" <s-jain1@ti.com>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010; i=s-jain1@ti.com;
 h=from:subject:message-id; bh=4gQ+sSQ2sI2wnR28bWPc8zdCO9cG++sae1iXeHplmao=;
 b=owEB7QES/pANAwAKAXQhhQx4u/uZAcsmYgBq3v5ZrA+HDaeTOi7zHHvNcXzwxVvPzSZmj4PIW
 hajW8K51MKJAbMEAAEKAB0WIQSX3grxmEgbaU60Blx0IYUMeLv7mQUCat7+WQAKCRB0IYUMeLv7
 mQLVDACcjFL+o+04Eq2NlDWqs9FPk35T2HaHrFAWCCrEhdjo8aYlzyjxQr2yuskiTwKRmGLD4KQ
 Qp5ACZvck6vAETHRIx/ruAd/Uuu6Vro0jW32GbCNi7tHw8mEu7bAIMv5yaoCB56Ibl3PkHFBEf4
 YG6VdwiB8uNNsOBwnIcwoKT6nVUPMdzjRY88ErueY0YHCJktrYmgXNXA+kt4pEIPVb3P1T+7Rnf
 jCnvYl8opt/B/oNsetI1qEcGEN0c++UOFn0yYecl9RAUi7PARLXrcIs7vgHgDNAfw3d21WaS7M+
 7OkZ8VXGXRGcKSMpg8CfavhNpjJi3FRx6YT5wKdBGpWUslsaHdh0F4oomiMghBpZdi3ThJ5G0aC
 BNKy4lY4BwJgP9XABEfJcmbkau/8XqnEsyfW3b+IVSI0Jw0wVH2Z3+VM58pZti+Tr3lA3sfVb0H
 7s6UpmroQ5bVhgLtDjWvdudahtqraAdT1Koduv9kPcR4c0fPRH2OG9O8I9s9nK1iBm60Y=
X-Developer-Key: i=s-jain1@ti.com; a=openpgp;
 fpr=97DE0AF198481B694EB4065C7421850C78BBFB99
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 77974f96-9be9-4ee5-5213-08df333120bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|22082099003|3023799007|56012099006|261022075727099003|261021121427099003|261021123027099003|10067099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 4HdLgxyLtLNRAMzPjZ/lRejXL9Ujqd1BqmkJWB7TAMvcAlLz02Q48MeOZFeujON5OrNa1MMyUkuo++0D6sTepwuy8rNKmubLGliNywlytZsNIs/BrollHYxMcz5bQWFeplrVctAWYvRTnD8U6qpT9imEiDYX63nyuHVsExfJVN0l4pmkEgkbZhejJxy9dewe8ItmqAhpnQwqhW2srNFVBFgSK/DuD0CoIFJI3e8yVS1JCObg8Y8DxnLAULCdP1Gdz9WO6mVE8lLjCdpVDnEIm6seJdU6AGZWgOzcKzclHF8qVQ8aDWtU3NtFPKM2nH+2irMeZR2irv/AEM/Olx5yLxt5OQn4XrUsKjTKheXffcfufyVHjprXfNCpW5q2SwXgRMEfEH4p/yY5NmbrovVFJml00PjSleQ3P6vHA/Aw3B+DqzBUKN7+hOCzpQoh2bSC8t+1xnXTVUtKnaZ0KD2+tiDbwHrUjHEsR997+pCQIjw7cQh99frEeMZ4+K0ho6qyB7sC1PaevPqw25B5BiGUruMngjyu1wYBUyrDT71jIgTjpn0GV+RVAD1XGNruC1YpqUxKM/iKC7m5m/hObvwYtE6a+2Lz8j0jqTVE0zZJcFZ+ZHbqs7rZ3oXH4M1JoxZ+dlOKVlhpKKn03k9uM1Y28umWTzEkvGS//B5N7xolq1BagtmExBJNSIBQkTuepPk31MDRIGx9e3O07o81SowvTA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GSBHgXZD2TqsEJ7n/+ZjjZ/HaobqQa2Eb62GvBeYe17IKUfRkkr9z6HYTfZzdWL+65KQzTplJk05hzvBdRl/lIQfQx/Mb+2mfGXdzpuCWuymluB6wAFTu0v2BsH6By9LQVR3SVRldBo4tkYLvqJOPTZGb9FLBxp7SiAdEm1kgPcHzfWsp3N9PlJSWp9is9MgMNTye6UTV4e2nvdvUokTceARjWzJvtSyyWtuAEj58b/zJPhdJ8+3pKOl54wUKB+M1Z7UKd+G0tr2MTPLGqQMiC6TJwyTYquO6NaCT2JUy58shDvIYFj8MndokiZoRHki2wqYe2t20ADiTBtPb5snBl6q/94jRnv3U9/7Qp213g1U2z8MZhIFA4c1OxJl949JYVwFxtVIXpXbHEjM3gS/LBLtTf3RIRBxVDEJF0IocllPJKRxhxoGAYdT/N9d/W1C
X-Exchange-RoutingPolicyChecked: 1sNenrxCaiofyqs+TbbaaC3tZXKl01aO3RcHqzRxQWTcwKoHc0OjealMjIWkmhJZ+PVEp8tbrzyN8hwV3AyFjy1MPvaPyi8LoicHiYIVAR702mrX5xQuex9cCppzYnliFgD1viYS6oVYt+e5ijEtdT9zmxrzXMt5tECylKh54I8Z8Gb35tnKFFiGFt/NrfvNzBNYm4kdR0uCJfcjmXoNnOzLNMsQjBLvpf/5m0wSpuFF3XKsLxNJObaJxeEcfiqmiptu4s08OA2cxDldn2u28g89AIpu7PCY9Fqlv0Wi+L9aLFZ7yglwYkzjQahO4gvcOWTdzMn56qfxP9QQ6tLGfQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 07:17:00.4362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77974f96-9be9-4ee5-5213-08df333120bc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX2rcwiT5+1lmZ
 zhd3j1VPdw6RHgWHejo37RNPnHRl2OOGPksOj//SCayLubVNUZUv6w21SY54qn2hTJqSa45svJJ
 qYDkCqgP4U85Fn3cBG2Av4IpP1iin10=
X-Authority-Analysis: v=2.4 cv=Ad4kjHXG c=1 sm=1 tr=0 ts=6adefe6f cx=c_pps
 a=0p5N1A/s2xr2YPsuh+j7dg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=2qJVik7N4u-b7hq3y9IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y8zvv3xszL35-87pbOEX8_xKkaILfcY9
X-Proofpoint-ORIG-GUID: Y8zvv3xszL35-87pbOEX8_xKkaILfcY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX7DUX+VBjIPvu
 tIW+MoRM0BgYs9V/obJgbVfymIPhRqrM7X9luPJX0yIvJFCR6bF7CpnOmUzoeltNt4iM+Xn0mfl
 8pFracGPSQ8vIVRmJxqLWaP5jTrOsmZnkmSpaWc405HvFADA2OUkMpp67D7+9MfJvlnmhFODpPn
 Pe5eBjgCoKcJLHiiyaO1sp3ZdfS8fuPto8QxVuxKfXFhiYc8jCuQEQCLru3iQL4ZmDN9nt/8577
 YgvOC6N3Was4jSxxt0P0Eo4pU5YIdPMF9f9RYTql7Ouh8MQ/uljjWsxvU6ANApoLRJ2Me1hZyOd
 6NA7dU1DS9jw/cFIBF2vAVQyXVtAJWRWkvy+Tf5llZ1LuGMApL6FO+AaQc8xpiTTzSqf0nyriX8
 bCZyjlmC5DNZQmSupd5qQBROp6cyOuIQOmqnzTnjwtyul1b4tVsAyb0KR0WZDEzwAMNc8N/CLpF
 eJjX3Jq9NJ+eOKk6b6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 phishscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260028
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some I2C transfers expect a NACK as a normal outcome. Add an ignore_nak
parameter to __omap24_i2c_xfer_msg() so the "error waiting for ACK"
message is only printed when the caller did not request
I2C_M_IGNORE_NAK, avoiding noisy error output during expected NACK
conditions.

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/i2c/omap24xx_i2c.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
index 2c6f8ea5901..666620ad30a 100644
--- a/drivers/i2c/omap24xx_i2c.c
+++ b/drivers/i2c/omap24xx_i2c.c
@@ -963,7 +963,8 @@ U_BOOT_I2C_ADAP_COMPLETE(omap24_4, omap24_i2c_init, omap24_i2c_probe,
 #else /* CONFIG_DM_I2C */
 
 static int __omap24_i2c_xfer_msg(void __iomem *i2c_base, int ip_rev, int waitdelay,
-				 uchar chip, uchar *buffer, int len, u16 i2c_con_reg)
+				 uchar chip, uchar *buffer, int len, u16 i2c_con_reg,
+				 bool ignore_nak)
 {
 	int i;
 	u16 status;
@@ -1009,10 +1010,12 @@ static int __omap24_i2c_xfer_msg(void __iomem *i2c_base, int ip_rev, int waitdel
 			goto xfer_exit;
 		}
 		if (status == 0 || (status & I2C_STAT_NACK)) {
-			i2c_error = -EREMOTEIO;
-			printf("%s: error waiting for ACK (status=0x%x)\n",
-			       __func__, status);
-			goto xfer_exit;
+			if (!(ignore_nak && (status & I2C_STAT_NACK))) {
+				i2c_error = -EREMOTEIO;
+				printf("%s: error waiting for ACK (status=0x%x)\n",
+				       __func__, status);
+				goto xfer_exit;
+			}
 		}
 		if (status & I2C_STAT_XRDY) {
 			/* Transmit data */
@@ -1092,7 +1095,8 @@ static int omap_i2c_xfer(struct udevice *bus, struct i2c_msg *msg, int nmsgs)
 
 		ret = __omap24_i2c_xfer_msg(priv->regs, priv->ip_rev, priv->waitdelay,
 					    msg->addr, msg->buf, msg->len,
-					    i2c_con_reg);
+					    i2c_con_reg,
+					    msg->flags & I2C_M_IGNORE_NAK);
 		if (ret) {
 			printf("%s: errored out at msg %d: %d\n", __func__, i, ret);
 			return ret;

-- 
2.34.1

