Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28D4C61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D95A60838;
	Sat, 29 Aug 2026 14:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQGl1oQCTIWb; Sat, 29 Aug 2026 14:34:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014087;
	bh=xI4cYpa83bHI7L9lcPkG14G9ZFARs6FRT56YYyxm6Jw=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l3pW+HWBxI3VW0bSOCIm29n6vAbrUF4vH5BWf4dljMriyYzG20Ecn9WweCOcq4Yzl
	 pbcmHdjSqkV+8L7d7JzMlFeypC0e9QSr2QSzSab2FNXnoVPHQOIh4p168C629/WH1N
	 nD5V9djHNadOky7DU8gc8oaE8pxVjMCO4v2ziV4lWPlouvlaZ1JZuh04tpCq1mlX4v
	 +hxSVlW4U1s7btMaPRNCEjshDKGTLos/PYhq7JijPy2S+9EjwVoS2S1DKfX0MQ0ZUI
	 qaFSmZbjdm0ijGLMAL+X+mpaqCHpzX42uYb6RK8L8ohZWYWXHUxU519FLHVVIPyEc3
	 6d6LKH3rrgsmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 627A460705;
	Sat, 29 Aug 2026 14:34:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37926465
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2999D40098
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Iwf4_3Fio56 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=aGFtzDBW; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=aegujlhV
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18DD640052
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:37 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67TDxqhe3258775;
 Sat, 29 Aug 2026 09:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=xI4cYpa83bHI7
 L9lcPkG14G9ZFARs6FRT56YYyxm6Jw=; b=aGFtzDBW3zVznNhZsuOCsIM73n+l4
 paL/DeqMQuDoZ7QBuoB/wCAr5cLfPR6BxLHF9SO6MxvBzoLPREmkr30dU2+bnzPo
 /AvePKQtUChKKZ21bHNKUJdTBsA0LOxFbPbANEN5kuOkc02/dj7LHiPvNoTsBw56
 TUZVhUpRF1BXz0mlel+IX0+VL1E9SmT3MsDiAnWn6h79kXFbAye1VN3879QQMVlJ
 Oaqtl+urlt8gfXb1coNbCkLV8np+TORuB6QNqm1eG5Ory5B4qEUU5U3Yld6/74/3
 X6SwDuZBPSoKI1GBpvh2Tm/10O5YHaDXypUp3PBgjj2BErGXmlSX3VfnA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gbqmmhqta-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xL2pz60lIWZ80kj0RC8CDcrkdcfnoEWUcE1ITZ4E40x6TB3ahKISPo7/3CnyUC708iYGJF6m1QEiW67YRUe0C66CJMzIN19jxdYdE62RPVZGn/OnxhReqLY6x6yQnsbvga6cyRK+V6uO7uLN04le817W844/Iun/FoMLBvIoWLlvmJxl4xoGSAFOaYw8/PEggfimF5x9nzTvJOQ6PFp7bRrLCz6QkjcbxZ+hWiE7/MU7e/E8D//xirEb/FE/zekCXNrSlPbj0hnGrX5vjoGn+JOV/v0nn1MsGn47YaSp9Uk9E8ENacBtj70DwQ4Hp7sncR9l3Bv1o3R29y/KyWyPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI4cYpa83bHI7L9lcPkG14G9ZFARs6FRT56YYyxm6Jw=;
 b=XsuNpCAopzIFr+BtZ6jRMswUd7EzLVii0heYtIaBUN06/4AJMq2/cgf5PVeLqwieNrYWv8W4vU60wr7Syq+kWu815rFGO+K41fzdZ7GpGr6rv5XufS0V853h0hUHr1+f9M/kUV8oTq+W5mqmNIFGRE/5Og6oMsxdhP1K3lAm5LlecnlN7AWWfATYFhOzNLKgD/ERuAbm8vvdglPr2Yq9e9JVwf1mojgYP3OuwSCFrLBGJR2v6WtEQBobGeLlOtnsYqRuNidP0Etf9IgnAw60lL5RI+/dU3+rn2R6eTG/1+n6co5PDF1nNbKfUkvh+XVvPFOs7AJfL96SC9biKyCQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI4cYpa83bHI7L9lcPkG14G9ZFARs6FRT56YYyxm6Jw=;
 b=aegujlhVPpVECmGL5DJ7lLYNuRt00NmsamdMfXoIu8QVMKp9TG12aniE+2lAi2lltoyYRibfUHdN527+QxEpD4gvH39meOfdiToGMNZfcxoVllQLHvZhhF1mqBMYV9d2Y+TTmwvKrdndXsALgQ9BYSoh2Bo+3vAGdmPTbvlSS2k=
Received: from PH7P220CA0075.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::11)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:32 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::7) by PH7P220CA0075.outlook.office365.com
 (2603:10b6:510:32c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Sat,
 29 Aug 2026 14:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Sat, 29 Aug 2026 14:34:31 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:23 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYNs8530309;
 Sat, 29 Aug 2026 09:34:23 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 00/14] board: ti: update and correct files MAINTAINERS entries
Date: Sat, 29 Aug 2026 09:34:18 -0500
Message-ID: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOrtkmoC/yWM0QpAQBBFf0XzbItVu/gVeVgMRlnaQUr+3eDWf
 Tjdzr2AMRAylNEFAQ9iWrxAGkfQjs4PqKgTBp1ok+TaqNmR36QYVE8nsrL9m8Iam2Ug2hrwG8S
 q6p95byZst/cH7vsBtHXnGHQAAAA=
X-Change-ID: 20260826-maintainer-fixes-7fffff976733
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|SA2PR10MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa5ccef-da12-4dd0-51fd-08df05daa36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: QD3sL2pUUbx21MLO8cVm+hjEWAsGEJvZRbXb28xUsD0Am/OTZ0bc3H7+QuwN8Jz5MO8BrUf1O5x9s9g1bkdKRaYARi71s5g5GL4ZPTeZw1AdK1ncXuYoL1EEypua0HnKpHQGXMplZOje7u/ZVdnVQOMOKJCnkxXXODPHf/GxVGsZSTECKYCi7snlWWxw9AMFs5gjKQZR2nh9Y2QW8KaWam3CHWRR0NCVqm2aEML06uZrEEMnfx3fJaLupcGF9nnFlq40NInvwJIAkr9aMqGvhsiRHIJYghDJIkhJW5qIkP8xj8Oayapa3ClEBmMU7RoAu0cUiR4swKBK/yVn0nW5e/UzXJQZKX36QzmbIjCaDsDOdCr5DKgqIbhAm7j4new5MEfTWYNxriwOhMZgYuY/kYmBtMbGuwPw1e2ODqTfBfLc+iiG4/QpaN7QZJqHEGuNzV0uyuHa6wCy2RCRqdQbylR2To4hdiLdrQQmY/ui3FXrV/rcuIF2EuNHF3htjshZA+nEj4j3HHOmQqBLf/XBC2wM+aJxpAikQMP304GkUWbXlLOJ81i/rvqO6y33ZfX4R2wgWAY/rFazzFEH/aiu5sVLy/epVoQQeEEXIbx2Y8SqLCMfUUMqFRoWu014Vw6DdkE2siQKfSIXwBAUz80APqoawonV87fDucsizI31WUwStqd5Bgr4FS2Z2F1yB+Jl/yRA9eDmVHuSt3tOGPj37g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fc59UD/HGP69zSQWFuFFEbCRYEmq4e8ai+R+UT6DRt10lpss/fPcU6LUsiWwrnd2Z72mK/CkCyPoZD4yuwiccxXTzb22O/jUWObn8PqeOWLVTJ2VAp9FuRoOavWuDyFczoVO2oFJQnyMANsbr05QbN+vRRrkCigHZBrQk3CW1FoTnflpNZGo1Zihjs3IAL1ujXKkMYwyXYMidM3xWzyUIvU3qbLzXNGomTvX06vsvY8TEyDADOUIdYmj2hC/jnKs6sFe3cHV3FJxmpm8wFnxlr8dKZvq/mVpHnBN6XlhH6uIXW1xHI5M+2UVHYe3Cconfntbo73oMGAIfgI+9b73RdUgzhVWL0RmeXa9Zg8VdrZJLKe1HhXcZugf7pSeqMZm4cVKI8D71NdkQeGp/nGe4FajpqDTqYYIf9PMPKoGT26syQuN4NETHyUL1JDkw0nT
X-Exchange-RoutingPolicyChecked: RuBSDEMyK1bm/tJy/6zmaKEV1opHWzNlUXxwxVrqMpWqM1z2e4RichpHgtBDUcrEF+yulpYrGy4AoDUH1GQnvBH1WCOsEi8t8iq+0iRy4h3pyirPE5kLpe+QkBwebIOWJD9XsaqWOmA5kkLtjYxH5de/MnDww9juWbIyrn0SUbXytNti4kZY7V51jX1EOecn4/OX6gnHHQqlSTl26IU5U6Z1wiO6r4IK9y4lVHZYUIYE+yY93p21u5noUr2YQwwiydRIMle1XnZ6EPLy67M+oEf6sBqIN7qkA5aBo8hO2WGpMu31G0+xpYRfgko9IniEWxTH73acUVy/9vC63Y5WbA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:31.1362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa5ccef-da12-4dd0-51fd-08df05daa36b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfXxF+vMNec67+S
 oqLg6/a8uBhmOf5G+K8QAZy1rWQR5PiBdlQNxSrGZLrq5rtYL7YQm8XYeUbzxrqidgboPx0TRKo
 nXhPt1SWcvhfPHcxuU5xejgWD+v/xMIhku1cbb/6KPXJlNe7AQhlMfdq40BiLr/GNfBZNyZRekW
 VYFvhHxXizd/DRqQMc0wKD5QORZNAIFeIsG5hOJipaSaCIZGOrDDT8qe5xnByFlro3kO8cyFw5Q
 JkmXU8uDc1Gj+hNSqVJ/UiJlQwnHiGcOTkBgQmBs18pdVFy+7c+c8FwAsm8OFIVYqzjx8fNSWNp
 ldApmMbdoUuZZ1JIKM4cd7uLXO0c7UwNgGa1kRZMVVx4vEKSovPW/XLerVSJuQzg4tMnTOAAKjG
 V7DQoaPmZVIWMNPLnC57bm+7mDDljuaKyNkMCusc+72cljmXCfzoqYw8cOEtOCarq4fMnFBKucQ
 ltkibKmSsqCRDKopSUw==
X-Authority-Analysis: v=2.4 cv=YNuvDxGx c=1 sm=1 tr=0 ts=6a92edfc cx=c_pps
 a=IDmSThB3jRGgE2uwFnJQpQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=7azecc-EVuwfASv3EUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX5GvG7TQWvx+D
 PkQ4M0ftSVJP6otYB91JeWzE7UtunIoPZw1XbqOdbt8B9Fb65nbOojkARCzVuJb2h8hcQnxG5xd
 n0wfNDUrQ+NptoCSsTnmYtgYMBd4uPU=
X-Proofpoint-ORIG-GUID: fq93plm-pDLxtza-5Cc4zEAMZnr2OD91
X-Proofpoint-GUID: fq93plm-pDLxtza-5Cc4zEAMZnr2OD91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290125
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

Hello Everyone!

While updating the check_maintainers_files.sh it was noticed many of the 
MAINTAINERS entries in board/ti/ are out of date[0].

So this series aims as trying to update all entries by splitting each 
board into their own block, sorting the F: entries, correcting any file 
names, and finally adding any missing files I noticed.

Happy Hacking
~Bryan

[0] https://lore.kernel.org/all/cover.1787555916.git.michal.simek@amd.com/

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (14):
      board: ti: sort file entries in MAINTAINERS files
      board: ti: correct names in MAINTAINERS file
      board: ti: am62x: split board variants into separate maintainer entries
      board: ti: am64x: split the EVM and SK board entries
      board: ti: j721e: split boards into separate maintainer entries
      board: ti: j721s2: split boards into separate maintainer entries
      board: ti: am62x: add files to MAINTAINERS entries
      board: ti: am62ax: update MAINTAINERS entries
      board: ti: am62dx: update MAINTAINERS entries
      board: ti: am62px: update MAINTAINERS entries
      board: ti: j7200: update MAINTAINERS entries
      board: ti: j721e: update MAINTAINERS entries
      board: ti: j721s2: update MAINTAINERS entries
      board: ti: j722s: update the MAINTAINERS entry

 board/ti/am62ax/MAINTAINERS | 20 ++++++++++---
 board/ti/am62dx/MAINTAINERS | 17 +++++++++--
 board/ti/am62px/MAINTAINERS | 20 ++++++++++---
 board/ti/am62x/MAINTAINERS  | 72 +++++++++++++++++++++++++++++++++++++++++----
 board/ti/am64x/MAINTAINERS  | 15 ++++++++--
 board/ti/am65x/MAINTAINERS  |  2 +-
 board/ti/j7200/MAINTAINERS  | 14 ++++++---
 board/ti/j721e/MAINTAINERS  | 32 ++++++++++++++++----
 board/ti/j721s2/MAINTAINERS | 41 +++++++++++++++++---------
 board/ti/j722s/MAINTAINERS  | 15 +++++++---
 board/ti/j784s4/MAINTAINERS | 40 ++++++++++++++-----------
 11 files changed, 223 insertions(+), 65 deletions(-)
---
base-commit: 67a095a6896828056e4a1a0ba0e9bb20f5595c59
change-id: 20260826-maintainer-fixes-7fffff976733

Best regards,
--  
Bryan Brattlof <bb@ti.com>

