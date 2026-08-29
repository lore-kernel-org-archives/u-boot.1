Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343C3C61DE1
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C308F6060C;
	Sat, 29 Aug 2026 14:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TIdm3LDkCZO2; Sat, 29 Aug 2026 14:34:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014076;
	bh=xQ0OYodhw0bixnTw1KifX/ke2CtTdun86rj5UgvqVaE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jSXT8eZ91EdfSDz2ddY2ClOrph1VyBMbeQR68xBonQvGTOcFQJiGBZxZcpC1T96cv
	 voj5PdMouMA3H+SAtcOe9lh9eCojg9v2jorS28lVHyDXaz5jatCK5QPWV9+JvG1FpH
	 iyfh43F2FYbrmZQV+nvxXPvSx/7qleAWQhZTdZ/POvKjT53aNHuqUweqVzERaFnU7f
	 ZGX3X5dd8rxdtjgTV1xR+JVL+SDjAf5QllQnMYuFvnSxPOiviDTpTQjWCrLrNM7H5J
	 wZ23xY6M0Vq5OB7GtaBYSXmE4qnNe2TWPTyokdiQpZ9PTVcaR44goT/pP3vleLnAFb
	 5eqBNeytIsQLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DC146060E;
	Sat, 29 Aug 2026 14:34:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61E5C118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47E3A80E75
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzqwsGc-Dr0C for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ASVZ91Os; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Wg3UtPt6
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CB4C80E6F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:30 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67TDxXpJ094321;
 Sat, 29 Aug 2026 09:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xQ0OYodhw0bixnTw1KifX/ke2CtTdun86rj5UgvqV
 aE=; b=ASVZ91OsqhGnR3uIsTm3d/fnwrOz1DoA1faBLai0d9pZQcsm1CvdFGCsA
 ZnaJ6ieVf5GcyX88DJdPbsmhZcjDUZBIrFV7QFpf2oyXOSJWYcYGjv14xzeQZO8J
 mV1eL6SgMW1Em7Wj0Gq0BTShsdF+VI+vtCqjgyhjaYayUirXX8z21aFXBELnojZr
 1T8U/6pcI1r0J/OBn4AlSp3ExDEb7/la9pcssnpNq6eRMZmX0fltD1Ca5mUTeN3A
 Czgi0/zLNPXwDIGC5ufxx+JvJF+qwgJIT6dgqGMxJixUWOF7XmrV24qhx79vcaJp
 0FtoeXDXMR/iq8bHkL9fOgPbuWXAw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gbqs7ssh8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHSfF37Fnr3BtgeyGNN3Q7GmGx/ClCzlgT1MBd6bLT23ua/0V165K4qBU/agZFWhQgLP2ndOBuA61UUZeS/r45WvZAsPQ0ODGs+Oh2oT0fs8DbUyHlqH4ZKsW8uY9qs/K05Ks2bIvOInojqIP00L7yK0Q7fPetWJZGq8dkowPyR/qEKz712MY8X6FCy8IfLA4/i2mBfxj4xMizqxeq0z+w7CnRppC3hIGmZ6DHLarjsOmoqNb2DeNe+BtmqvJdy1CBdGuclHyCE3oz7s+3c6uY+07TExtPR0bs6MrKXHZkD8y/L4cI0CVe29t0qpNp+kjk141SWTJTlD+FQTFnTWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ0OYodhw0bixnTw1KifX/ke2CtTdun86rj5UgvqVaE=;
 b=pEjN2tvY0mvioEuitK6Qs8CzMLHdOlnH60R2iqmAk9Y52Y6LgL8j8GkZesdYunwvidb4zn859o0WxYev0OGlOuGingDpW/WOBhjeC+cffSN0633OaGb0EmuO5r8ITT7Jy9OmzXDIkzDCBYEOoPTdp6G4uIOa8D4kZUon3eRF7lyY2H8JFKVXljKB96ymvlc3Hz3KQ42kKeE/93pCR8Sez5LwvrJPCkHDuwKERQ6EejVfMxlDy+q8O31RKQtRWZ8q38KEkqeEf9mNYr01K9yCNFzH6sGn1XEQwVwuw/jRYs5ngH2gL5wPSF/pJ9ut0EApRqHPY0lI3vEEcmpHr5NlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ0OYodhw0bixnTw1KifX/ke2CtTdun86rj5UgvqVaE=;
 b=Wg3UtPt6sq+1hk0QHBpjOIWKVMv0e9/m5MpcKAyL4vHW7WwOhO+eEGjLCxKH3c+G7PHgmM3DlIa/j9QcUeikw3CjXonFteJF3McfpO0HvoBwAZTEv+vW4wEPHhHhf/VRjtio9177lg9Vl9rijBaHb8WVFhjFVvhF5riQYNO11uI=
Received: from SJ0PR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:332::7)
 by MN6PR10MB8119.namprd10.prod.outlook.com (2603:10b6:208:4f8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:27 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332::4) by SJ0PR05CA0062.outlook.office365.com
 (2603:10b6:a03:332::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.5 via Frontend Transport; Sat, 29
 Aug 2026 14:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:26 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYNcM530321;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:23 -0500
Subject: [PATCH 05/14] board: ti: j721e: split boards into separate
 maintainer entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-5-e4e03971e14c@ti.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|MN6PR10MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ee09b8-c7c6-418a-f252-08df05daa0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DNVoTeGOT9ual3zUs9QpU2/8IQd40fA6iRH0tuv5swEdC0xfmYZX+2GAo0rW2rVzu3/UK22TESB67tkgox4YpxW05FmSeu4YPsQluqCr5RLtJbet5dXtnbpSDlVEl0XnSc2rJOPUNQvF709tnb9JJC1gm535/2DNtfIRYIFBhXoPFGAVpWhbFOgqNQPtS0TqFWzoowvGwoYiDGQ5IuLp4Mv6kAktQ0sSlHbiURuj/Y41WU0MbUybUz9BHZB/BEaMcFj5dGbK33RBiXhwOnMvUiffVhAExwAoU67CX/wnDc3eC3isnxjOtIJL7szDVTySWqMh/aunORjurHpIq6iekq7wT1oChfNWdqu97F0q5lRgtsUguCdH3DY8GjQh7bPtePCozvir9lsm8UIEx0GFoaVlh2KZlKEw1XuQTUoq0wZTtws5B3dk0OcUIXjzBBb/1cALMOv4wg9LdLSRPWmuHDP1q8urw6lczPxQbiWma2UtUHmAKAFhvLs1YsCqnvHx7Saqx2GBqGlyH1ussgiHm8GBj1A91db2GDB3Q2W84iLhdUya+VAjMYKRNz8RlKmjGbw1Im7W56bObCwLEUs0muNu3/sLzBQnPU67yg2EQemFtXqd7OKUULMq4VSZyeDUP/0abzNi7PwAEVEaNyy1457hW2pZpxUUoxfPgzIDmffB/77TmNqHkQwjaY19EHNrKzmXGyRSb7DEvn9pV/gfDw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fzJ/k+g8nL56RorIwHmknQxPvsLB01BQU3g5JDVf+Rw8NpwPSHvxE6XbFVv0Wz72s9uROxGW9FakMD45V4eu83xiBAFK4yi7dKq65/++9CGZt1E16aAH8WHLRc2DDHqPiop9lCS8I9LNTgk5eK23DZz2H0Qw+Vtz6I3re8WLN1mcHGwAW2oLvYzFA8QUeZqUYmi/3HX6S368ynXNDt4C+VwxNRlBFIs0Uh/bqcyeFUJR4ZFsQ4S+NrX6SI6foDPoRHgHB2vR2b5/hxp8QbhzID+2BDWbcxIIrC2t+/iF0VFyyLJZx4KAxbqtSq9lJ6Dq1mD4tb1AhCnyCBQ+1PMdgd5vZmXfdRzNDUPDanM0Jfh7WNqSS/DXwmB/AGfuPVpDbTGh+OhnHMVZbiiwQXLB6tufHY19ZhFmtDMAdXdkR6TlSym0O4yhmQrXBs7p+4Hg
X-Exchange-RoutingPolicyChecked: fi+B5mceOi6z7K5RbMB8CxZzvuxOzcFYM53gTYedO7U8DDS0U853NfbDQpw7U1zc9Hwul1spVgMHFmvfQqMtG0oxcbUzqourYDSp38uQpOyaV4LnX6ND+SoFow8DMjhwvIrgFInbG9h73Jt/Q09txGdeqHLv2j/Bpxo7a9niZOaKSlGIuPyE6lJ51xpaY5UWxxznFjG+aMJX9+tVmVTNoggzFT8N0hrofPpesdYd4HLGYtUAdByWT5aGGpBWRYXdCy3xAmqsou/2jrKWsjDSL2yUkr/Vw99wKH+056pWKObhtq4eUn86IocTGi3fEpen2MFCqEnrxYf6agOhh2pDzw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:26.7787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ee09b8-c7c6-418a-f252-08df05daa0d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8119
X-Proofpoint-ORIG-GUID: _plhhS6B3k2JKAzQe7ouIsdD3K0O9y5I
X-Authority-Analysis: v=2.4 cv=Z7nc2nRA c=1 sm=1 tr=0 ts=6a92edf5 cx=c_pps
 a=1s4lD5itHyb3CJ4oxNoLhg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=Zsv9kqMK8xwa9FFQTQMA:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX/vcfDnsiwBFv
 3fJB1aozdyM1BXZCrQyRD1217Cn06+Nl9Sp1wS6ud8gtB3pJ3qId4CL4WGHTgq3+O9QVlEB2Va6
 l4v3U2hpG0eMk2MCjg9cb2QhPdUvYPw=
X-Proofpoint-GUID: _plhhS6B3k2JKAzQe7ouIsdD3K0O9y5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX6nAckUvNECbC
 FdgpbEMDotmHXj4sVxQpMziqhiL2wFMGqb0pxJNAIr0l/gxGK7uM15dCkoRHun4zRVFHteerksf
 hYp3LgCRwV7c2XxOIt+S74Pdq7HNNOkKG+mx8e4K5JfE7/6/dg6C2WcQGeIVfq+Kj7lj9ajSVRs
 PulrRFMxClsV7wv+ss6cqIkmvtdMVw1sX7PR3PSCGtJLqKvqHsFE+G278hdLxwBFkNBA2e8UToi
 xHZZnS3QUcY8plcq+9w/yKtTCPjGQlNxvZ0FCsITqUeXd2dfHuDI1oXDmdUuDNenJHg/gGtKZ/S
 dvSP1ugFA/C48XvIeme2YkHJQkszR3y1FEN6FkVuUI8Ls+CbsoeivfW08YC8UDgDIuUu8WEo2kw
 GzeBHngTX9e1acELSJDTPVh6sfWUVxkFBU2iv8BxBfNrmllKPpS5vgfeKp+tLWRwq4uPQMQquw0
 05xGkIEDEcc0cVnu9dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
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

There are two board variants based upon the J721E SoC, The SK-TDA4VM and
the J721EXSOMXEVM. Split their MAINTAINERS entries so we can better
track which files are needed for each board.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/j721e/MAINTAINERS | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/board/ti/j721e/MAINTAINERS b/board/ti/j721e/MAINTAINERS
index 031f51b762e4..71a7d3c57312 100644
--- a/board/ti/j721e/MAINTAINERS
+++ b/board/ti/j721e/MAINTAINERS
@@ -1,9 +1,15 @@
 J721EXSOMXEVM BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
-F:	board/ti/j721e
+F:	board/ti/j721e/
 F:	configs/j721e_evm_a72_defconfig
 F:	configs/j721e_evm_r5_defconfig
+F:	include/configs/j721e_evm.h
+
+SK-TDA4VM BOARD
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/j721e/
 F:	configs/j721e_sk_a72_defconfig
 F:	configs/j721e_sk_r5_defconfig
 F:	include/configs/j721e_evm.h

-- 
2.54.0

