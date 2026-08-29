Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ABBC61DE1
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11BA06066C;
	Sat, 29 Aug 2026 14:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dXPv86cNIMp5; Sat, 29 Aug 2026 14:34:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014092;
	bh=FM3l6In2prk1uphzBzhmZgzXkhoaqayPDjaGZFS+R/A=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ByQZ18HCTkXjw61TzOsm9Zi4uRUY+mP3YVmvQzeGHY89C4VfdWvSAtVQ0MJLkcL2V
	 N4XixBQundXBFtXqhjIcLBYWTIZEqx3ghdr/rCV8KbnTF7x0pqcBuf4TW/QV8teRoj
	 /sZNQH51QaGVsXeVr2wCPgP7FiiMYgQiPcQz5Q043UNEB/V/B/JAsrlLPphTEssY5e
	 M7co5kqZLXjPkzPalZSlkGZBnxZXYBGE3ZzmxzBDHTOHHk5CR++2IuhfXK/VrrlrTg
	 mnPy1rKtP4u/bmlmIsjUp76C1UTy97wHgItFrGsj8crJovcknuL6Nd8J9dBI2bcyUu
	 KBVcJ7ejMA+TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4714960854;
	Sat, 29 Aug 2026 14:34:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0A6D3AD
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE37E60690
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujh1gSDaXZB6 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=MmlhGE2r; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Uk78G4Fs
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B683A60629
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:41 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxod14097388; Sat, 29 Aug 2026 09:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=FM3l6In2prk1uphzBzhmZgzXkhoaqayPDjaGZFS+R
 /A=; b=MmlhGE2rLayk0OZlWZ5I4Y7W/vCuKcSjgXAXmvnGKxz9AwiqoMFEDRZ7d
 VGXQ4rpJ5LZVGYOeNaOt6lbdXxxGXhcHMWrjGf/ZGpT7PqRBp2QQCxoz83pYy7EO
 knhp1qocbV1MdJnchANKtCTX6of65/3l6KoYjtb2B7S8g8vIX2CF2uABRnFC/Ul4
 XAx2WKyxIdU70IHiVobOVkyCnS5++L6vvtpWtw47+FwtFlZel9A9X0Ql8PbO376/
 5/rintoX3TizooZoLkZVgRv4zUqbCmsRfnjgJJv4qPv7e2Cdn21YpiRWlfdTmvKx
 Il2s5T1ekg2kgWUDAm2RLX6UcW9Hg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqr29rx1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koygNqOYw/vwnkTRz2sXeI7lQFt1+eErqx9KnM5eTGrfXPg5QhSV/Ytga8JX6jQ9bLnb3lsavIQ+tMM/FReDqqV+8OyB0hGY4bh9OzjkDt7JYf4aBPSVXKs8FmJrrazdQaj+yMMXLJLK2p7mN2TBZD0FpiRW+XLgYv4VqAR9U84I6SocxJBlX+tX2PDiqPsBvYnbdjfn1SFkhI87JW4CuHEpf4+0ieWB+wjOlYi3s59d0dH1GSj3po3REKxSPu1RqGtBbCnZOSblEsya3QYQtrN75q0knkZTX6AGOq3joyWXqWsR9kPawrgxOjfZtMlAF2NSV7id+LVHMxEhR/38fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM3l6In2prk1uphzBzhmZgzXkhoaqayPDjaGZFS+R/A=;
 b=Pxiv0L9HJ/zwTYDry+ZJ5aLa9zs5AjMUEIrSC9AiLwd7LC7MeDdLgxglFYlKIBqsbSaclfaKpbPmttExg9LtguBz7FW2KGpjMa7ub4kWFRPhRvTudOSQZF3rbrDPWrJxEO9Hyc5oukYbfdWVXh5I6hUvfU/ef1Q6gvoFaYXcTIJtEDzuVLIZdLI48XUBO70+GXeW9zH/2FckTRKgb9MDmpXbr+q5zyexkoxA3ZEw3BlnLcNb5yMU6/Wp9V1uONu28xOde3JKIkfRoLEGh8/TYvawoG5xOSfr/7vPUezs3WN83IdoSeHmmYfg/DV1TcN0y3ueEiAX/wNHBljj8x8aXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM3l6In2prk1uphzBzhmZgzXkhoaqayPDjaGZFS+R/A=;
 b=Uk78G4FsWhOmXFhsCu11P5qhUhKvudWva2Nvk1q7OtA15o3BcBuSzf/ryTZGMLS1HqxIOID4gMLbkKjidgeK6NV4WRhlU7X7pVDLy3bZJ1mxL3LqUaWx6z9xQ6QVLPDt1owbupb4Jfo2auNmqTDPVhPj0aLNbTJqiJX929U03cA=
Received: from PH7P220CA0062.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::28)
 by DS4PPFF0E76365E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d57)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:35 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::2f) by PH7P220CA0062.outlook.office365.com
 (2603:10b6:510:32c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Sat,
 29 Aug 2026 14:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Sat, 29 Aug 2026 14:34:33 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYOgF1551078;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:30 -0500
Subject: [PATCH 12/14] board: ti: j721e: update MAINTAINERS entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-12-e4e03971e14c@ti.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|DS4PPFF0E76365E:EE_
X-MS-Office365-Filtering-Correlation-Id: 479df9ff-6a9d-4ab4-46e4-08df05daa4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: ZwHCWR7ZFuXZK3Y8iNV8mBM5om/y2+XwtGSLlbU9kP16kH8KdVqAa78VdUojyUMLU0M/aIaFFKQ5qg7yVA0BnJ8Cs2C8zVDSjUB9Ry06usYF7G0+Ilk8gvC7Z/jQbljI/XdG36tuT0mdXeRd6oV+mWtuNtgriAU7DqWJ5nli7tAqFQxSv8J8Tr4EIw+Qhjvie4+FpJ7Lrb+9FF3mBl6Qh348H02dinRlYnnIzfx4wDl0yfMTnFH59YU54ZyxafpJOE1aM9Xy37kGurZdXtbHqzmTwAU/+49efWQ0L3ThRLQLl05PczVEPqTOHgZOFiHiiux2UxNCHtuWKCMHHruVwzZDSdQh4lnVsKOR6PWjGlcT80Aj81Nt6CE295lDdpUrEo1ops115ti8fvVohrpQpcOw4pxsHBtZAhv9+ynLhMS56cvk0LiVQ30z1OPkEkXU4yBF3nHqyRHs9IzvyWwZkl5CwCYt6V+W0isVEd9Jnu3zvCKMjbLAZ5MmcGGuAA15Y/sfWALgOa37ngJ+e0gNbslTj+NCfnQrEK2EGaUHc/Tg6CMRL2mc6ot1JOAHI26fwKn8NXpQRa9pntChUk9NCgY5CRQRYFyh6wfvkyE6qG/fqG/85Ba8ZsNm4jXCZ7n7i3Kvrjd3uM8goRJnBnKZYDW3njiO5u0t6PxUGY4NjdoplLgqlGXQaEhc1l5Ihd/6eCz2YSHK9fYz8Amlnnr2hA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hzrPqUXLjWkTQnIpTv7IgRSX4WXZeozTJd84gx4gyqrhigyIPehDpez6TDwdxyFd5OPNEw7G/StoeJUKUwqRz0kbbXvlc6s+8MI+SF7ZACBK8U+B5GwW2qoy+mftli80toajZF0M2vfi3B9RFpok6trpcupvRheR5mObA5MQlwS4u3+BUiYulwYGXaisKkw3zHz/2Y13wGAJo7jg3enRY/frkT/fuEityXjLhmVQbqqw21jMcBbMbuwczEjXnyLj/fHCpHwwqlIuq2K7gXWWqzP8enGQVkisQol5GpmrQZ+EQ7nAP9aYz1wD466YXVskGnnSLTwSXgCrR5aKqkbKh4eoX2b7EDoOneND0U703yLBzMgUSHE+oz3Ew4e5UF6OQW6FcAMS5pfCzDj/WoLJSc2B848bpH5iq/XWdu5K9K1gtiaHslbClW4NgT8b+sln
X-Exchange-RoutingPolicyChecked: ofpd+Yo848jQELX6NCUfEUy3+c71+sLv5MD93LTIc88MiM7rzEZ3fMvTxoY4NfKssSubqrCgi24CqXtc1Z0tWGLNDtXhcrF2LtZ5sejh+RExVnHI3abR//RFPDTcQy0mpO9SSWHh4yhy7TIdrWKw623A2f5bV0fV6PAc8jPlmQeWaDtjn45pCxLF3Lw4KKjo4t2UDaDTm6jyDf/4DMpfLwahW9BHzFo7eoWSlxM6IwIgVm8FxxNI+XnnMAb/b2lIROXmcZ/p+bjkM5Qruzf8+6yboLtf7BTe3eQw1c+OLJuy4IskSwOK6GZ5vh45GxfG88us4jjwopmVl9IPvrjftg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:33.2447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479df9ff-6a9d-4ab4-46e4-08df05daa4ad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF0E76365E
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX3iryDX9jTNyM
 CnBvCskIEL/KgcRPVZQXSDT1G+tCYCgUqemDn+NAHCaekroXFjrs/LnrRY6+BQs887EsTFz/sOj
 I4OVhLaq9/MTEefTXThcL/yVJd41q4o=
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a92ee00 cx=c_pps
 a=mGKQszq4vdWEHw2ByKFqMg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=k-42gJp3AAAA:8
 a=Ys_V2xytZ_7azGoMSG4A:9 a=QEXdDO2ut3YA:10 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: rPvIwgKNV2aRd3qFsfqVLMCvycR0pFfk
X-Proofpoint-ORIG-GUID: rPvIwgKNV2aRd3qFsfqVLMCvycR0pFfk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX9OMr69axy7co
 D0257i9BjRB1To8CRckxo3qWA4Lv0NfgOWaapjagCEoZC+o4qhNO+bw9i1EKcIlKLhGkk/EL15s
 O8Cr1rk2qpO6px+LwqqYp9LQvn01gmuZEtSQSo4j6Muc0HQCE+BspU0pVkf0cHjHsA9qiuEYqdK
 lRaxZ3yIwzh9o4kR8x6h+LPGBqozx2CBU+XmOsrCQbcaUcy7UaWyejd9JKq1+2HgUzjdOIzuXqa
 iJZLILKurgveUnXaCbVYDCS8hVOH17nHGo9hG7W+KVMF9KBc5glnd5uIC8bazcJktXk8vQIdnJw
 VJlRFnrDR2rvjGu81O0j2wWbQSMSkYxbu8m9a8czE+kLHqv8bk+lPLmLf/zMV5PLrWQhZmTfn+l
 r07n9jopPERHNjhXir3ZV0/NI/UN7ZQXZ8Z+JNupsOuZZF0RFU7ZMdI85u/HUkS0K9dM2TQnEmD
 uE2QbX2UHfKP+hbbTkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290126
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

There are some files the J721E-EVM and J721E-SK boards depend on and are
not claimed in the MAINTAINERS file. Add them

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/j721e/MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/board/ti/j721e/MAINTAINERS b/board/ti/j721e/MAINTAINERS
index 71a7d3c57312..0afb68d351d6 100644
--- a/board/ti/j721e/MAINTAINERS
+++ b/board/ti/j721e/MAINTAINERS
@@ -1,15 +1,31 @@
 J721EXSOMXEVM BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
+F:	arch/arm/dts/k3-j721e-binman.dtsi
+F:	arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+F:	arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi
+F:	arch/arm/dts/k3-j721e-ddr.dtsi
+F:	arch/arm/dts/k3-j721e-r5-common-proc-board.dts
+F:	arch/arm/dts/k3-j721e-r5.dtsi
 F:	board/ti/j721e/
 F:	configs/j721e_evm_a72_defconfig
 F:	configs/j721e_evm_r5_defconfig
+F:	doc/board/ti/img/boot_diagram_j721e.svg
+F:	doc/board/ti/j721e_evm.rst
 F:	include/configs/j721e_evm.h
 
 SK-TDA4VM BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
+F:	arch/arm/dts/k3-j721e-binman.dtsi
+F:	arch/arm/dts/k3-j721e-ddr-sk-lp4-4266.dtsi
+F:	arch/arm/dts/k3-j721e-ddr.dtsi
+F:	arch/arm/dts/k3-j721e-r5-sk.dts
+F:	arch/arm/dts/k3-j721e-r5.dtsi
+F:	arch/arm/dts/k3-j721e-sk-u-boot.dtsi
 F:	board/ti/j721e/
 F:	configs/j721e_sk_a72_defconfig
 F:	configs/j721e_sk_r5_defconfig
+F:	doc/board/ti/img/boot_diagram_j721e.svg
+F:	doc/board/ti/j721e_evm.rst
 F:	include/configs/j721e_evm.h

-- 
2.54.0

