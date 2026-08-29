Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EAFC61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDA5F6060E;
	Sat, 29 Aug 2026 14:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJaGb18TELVw; Sat, 29 Aug 2026 14:34:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014094;
	bh=OyGHpIQMkxJfi4OwNOX//0MnwQiwcwdaCVGlu6cYd04=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DG/D85TEkiBduOgUSUbdh+XtH0+vqeHQgjfmy4vnnT/T0rv9efWF8CVHHfnhjEK02
	 QYWIzMlY5XEXqLGMXlhr2c9wJOHbLSQqaH/2mwoctCk2UlQKt+a+2tOqFja0z+qGq/
	 i0YvB7HB7stGzbWoB9ZPbeQfvt8mKkgcW6Jvmei7QejDYAJzg0BCpYzryJzuQfB/Zv
	 at9kocYwKYyAby4NxOYOFsgiXmyCKN/64vjDQ29YDPYg+NU+DbwMUMp+Hbko2Jr4te
	 ij2d5SQhbxxET4VH9iPM3NUhhmVxuGiG7EdkiZvj9DLjZdHWqC3R4W+R1CtJJsONk7
	 rC8iRv6QSlSeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D235660662;
	Sat, 29 Aug 2026 14:34:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 310A614F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1743F80E89
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBhHfvSYtQDF for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=S2ACIoJJ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=HEhL9mbZ
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19E9A80E93
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:45 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67TE056A095387;
 Sat, 29 Aug 2026 09:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=OyGHpIQMkxJfi4OwNOX//0MnwQiwcwdaCVGlu6cYd
 04=; b=S2ACIoJJrhupiaFoLyMY1hLiB6NNa6j18Du+eYQNfm+gEAQZZDrzyeEfE
 f0OHpmRh1cmGqtart4NaxQJ02ccEO58+kpwMoAaX21n+br9/msejGE7F15lDGryL
 jryJ74LYIHvQae1be9dr0EKUjpuEtLlzdIwJ7Rl7LxgvF/3ePrFrNXMx6vpZqtty
 CGBdkxcpzEGliqQyk5TuHnsVbYNrXtSriBs+dumkjpnaikKcnGeAQ027wbol8yVA
 UltaRH2mMMsPFyYUomdLc6Tl8aG8L/Quz4qFT2tV1c+pp8vO7QArYZD3+OMJRBtu
 /QiaOABz1CzzHCNk9ztDmoeMd78nQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gbqs7ssk2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gafRAgmzPr+L40i+xwu4rz6wHbv3uTIjsYBDsYLwLg/AAoKO9YApWiTmxwISnB8oRFTDdwv44yz7i5G3PREsB424ax3LZiQzIQcKy1RPcrMuuNIPkFYhdFT/irIVub5oH/JCWi2favMmqnIXpri7PxQmfYagt1dvZhXC5Ia4KBMpOcgtD761GwtxdTEIqhNsv3lp0YKfWA3+p/D4ASdIt4OCB9G1o+P7IpZYbw6jxoNZV1ePMEKMLBWLFM6j+aE/ngfEAQNZQVmRr/Zu75kapBKKtasYn25j9lUz8xvtbn+spNrHcweQ4zciaq6qDCeiwiAQnR+cdY32Hdp96cKmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyGHpIQMkxJfi4OwNOX//0MnwQiwcwdaCVGlu6cYd04=;
 b=laBKA4DBFoIlugebN8v076cZDDUwTDzVZ+qr2nqgv7Cq7WgCIvWAs68VEOC0msdHl0Pp7s30nU/UGAUX9EbngVoMxchTXnLxwXED6GTCkBVxO/hAihS6l8rt5oJe7u+UFkiYKTc8/ekJKrdHqAzkl6xWmvMYFoti+wS+ysruQbG5Zjb3wrvD0nq2Js/3GdwzsFYqz/9xV9b5/wdL/81GAr/wmC+FwB+6rCLbQEe0Qy+hFKDZk+4higO+FIqede9LxIydYtItWUpWa/fm+Dc6t7v/iHrNI2PWpjJ5VYFYVvh/YIF0Z8M8igaJYISv65SDRqZgzUSI3TSJ8rc7k4CruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyGHpIQMkxJfi4OwNOX//0MnwQiwcwdaCVGlu6cYd04=;
 b=HEhL9mbZgAqz8++UbJuRuo79CAr0/Py7I/DBXUy7dU+vQJJKyW3GiE7itHWnjGZf/xtOSdm9aA+7K33P/WtlpPAnGX+mZVgpL59LO934883zgkosd3Yq8xJ41igaI25B1mZvHNo+1U9w0gQf8iGamuEXEM6mT0eP7l/Y73NU0V8=
Received: from PH7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::23)
 by DM4PR10MB6255.namprd10.prod.outlook.com (2603:10b6:8:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.5; Sat, 29 Aug
 2026 14:34:39 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::18) by PH7P220CA0080.outlook.office365.com
 (2603:10b6:510:32c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Sat,
 29 Aug 2026 14:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Sat, 29 Aug 2026 14:34:37 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYOsY1551081;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:31 -0500
Subject: [PATCH 13/14] board: ti: j721s2: update MAINTAINERS entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-13-e4e03971e14c@ti.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|DM4PR10MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 948ba030-c2a4-4e9e-71e3-08df05daa74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YGnvhlJsJtL0E2vX+WlrLeIKIMXEcJQnBwds3o3s7TbKX2WgWhoDtaVfl6QXi0C84jmVZ8pzxOQ2jDCvx4ZP3IXV8bkaa6JDJ3TVnTubYOuv0aV5zDbFXnbbsQBWFyb3u2GUfZhIRUppCUpxR3OdBdtBMqNA1q0OihKc8F4PNDbCiS7t6EDNsBqGnQ63iyGIYIxk85zKaX6rcHvBvhiiIioMTjKmWV+XtD7a0y2hodU9AHJYfQngehbmSzj8j92WFhPqXKJPuRV0Tacgy+Y4jx+Ao7eozNECIZJkPjSV+OFkkMFAsLFTYb2Cl7BYstXsRoKTogIrSxIKjzOb9hI5i7JA2rUv6nC/hrcumgXgNvrNC5S5uXcRS3APSPo5oA/Nn+sY+3P+kAOAiT0I3kZ/02TLPDy6hUQoa1MaJD4SdFpSnMyzHcN3+l4F//gom2pHeUdD/2JHtuCXJRB6ZTAt4r8A9snLET3JjLB5QR9h6Opc6Cr6Tl9aS3kkWey0H44TnJyO0D5BKDn6x7laibVeXYEXLjok/vKRUsw5z2LiOXT1/2SVKsc2rlXCZf1i0JCYy9LyBE44oiEDNQM8z6V5gmjtwoqhmFo1zLDc65kmrn562wzLqWYp2fkpym6ACA6uLTXh7sUiBsy3fP0r/Jfmfs7djkvTYcRiCSyJoIJf77okCWJfvXIrn4cAICfoUtnhyRahIqxBXadypmkvXtGjbg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LecbXeyyqSrGAeEqnGkvJ2pTkKR6JH7Qp/eo2kVMd2RFKmRu++lGlXyuty6iC4NH8VZ2CR8JGYh+Hs1R7a2GdreZTvs778lVVVEUj0jnIvHPdU0CfH6PlyiwW25XXUkQp5xIM4dbr0qBqUaCPChCePcCQikDKZDDKeEtYs30aR1CTiJ8G5JuNws5UJ+SUNbomiot7XHkVO6rb20eKizXyXxnOQ36ICcAb/DS/Hi1UMoe3PoUJrL1XrM30yraU9JHa61gf0JEfcqQ4fgc6jV/HVLvkTDDi7B7uWZZ32gTCOJ4GoHVJST8MoAKrb0sF0goZtmTNZamu5ll5BYeQ3oyrtnL7JBqk26iQ1Fj7JazVxckttOj8Ym6mn7WevJkq8zcen+xgL3ONCcG6E4KK3ITXnAaZB/CbmCHbJt4pomWZ/YDJ9WxXCfGghN4Eqcw00z+
X-Exchange-RoutingPolicyChecked: O+DV8oOXMyxJbvucGQG0Ams3NkxJ8jSzQ7gC/xj5N0HhkQPuibKXHufrkw+eSDsF1QUo5ClwmUCYCrm+R66pT3STf6au6GqBGs9p5gI4AI52fd3sWpiNjgfWtdHUU8+BDKfSRSFWfouxUmawCODBRvmVuytvFcDK211B/aiIQaxRSfqP83tS/u3qjBOcFsT9bKuDUy0DcK0Jtg3cZ6IukF35gcgu2n2GeVRGttRuSU/P7o7LMN6WvqGgjepjamLp1lznDyJ1a8yPsqXbJVKP0wcmwqlwmCXNq0qSTdgh7pxi43MiNyDl6Sauo3nrLRSK5CEL6za3wz0vZDX816Jc8A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:37.6361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948ba030-c2a4-4e9e-71e3-08df05daa74c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6255
X-Proofpoint-ORIG-GUID: QV56_IjQ3G7eYppBW7K_FbsMJ2jPxvFC
X-Authority-Analysis: v=2.4 cv=Z7nc2nRA c=1 sm=1 tr=0 ts=6a92ee03 cx=c_pps
 a=A0DLv2vQdyrz0cYTEbm3ig==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=mHFtxCc1tEmMGyBQ6_4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX9FtBNuSGbJml
 CY3fp1HmfCCK7hRGXKbreiNv56pr2SIKglZyoT+BRmUrXQ3ikvlKH4JhwlB5W8/aYe9FjAe77Lc
 URkaqmawEQyehLIafLNHjgNhJxWx/AI=
X-Proofpoint-GUID: QV56_IjQ3G7eYppBW7K_FbsMJ2jPxvFC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX0aE6hglYp9oR
 8t+c0T6V8ycJlJtT1ndwvIWuJCFlNbTJE5ZXBSC/6D8C+EF7Rm8IDEqq8FJFOUNysclJphmg66t
 kHTExxpUTIOvzLDxj9FbpUDBevxFQp+hCI6aC/RFEKQTTutgmBTUklRThhEtdAtaO23vhY7R4OQ
 5G29uOKHnQfuDCoaYl54Ql/1EL7TB5dJy7IcCW2dFaCMOVDdTH3LmQjq+J9PzVkkPqL65ieOdkR
 XTc0LWkbDfPUll/tDPhSyq9uYA+9JRzMXL2f7JdVdA6BrRHB0DS3+RPi7DPagKtpWhUJ4dSkrVE
 8jtcNdIl6VgieMKH+6UeKMY7zTs9kq3BhpfraNWFFunA+/NwO1n30lHgV2rsOwIssNvnIkVQ3G6
 ofIZq6wV15An/6a9CpiLGywdhWOCyml8Ti/oSnAp1asnPTqtgapDjVjhs5NsKjFDLEbU+UQOQ9r
 UM+RPtvXaIgVWm2y7WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
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

There are missing files for TI's J721S2 based boards in their
MAINTAINERS entries. Add them.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/j721s2/MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
index 5bf5b59839c3..df940b9729fe 100644
--- a/board/ti/j721s2/MAINTAINERS
+++ b/board/ti/j721s2/MAINTAINERS
@@ -1,6 +1,7 @@
 J721S2XSOMXEVM BOARD
 M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
+F:	arch/arm/dts/k3-j721s2-binman.dtsi
 F:	arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
 F:	arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
 F:	arch/arm/dts/k3-j721s2-ddr.dtsi
@@ -16,9 +17,10 @@ F:	include/configs/j721s2_evm.h
 SK-AM68 BOARD
 M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
-F:	board/ti/j721s2
+F:	arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
 F:	arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
 F:	arch/arm/dts/k3-am68-sk-r5-base-board.dts
+F:	arch/arm/dts/k3-j721s2-binman.dtsi
 F:	arch/arm/dts/k3-j721s2-ddr.dtsi
 F:	arch/arm/dts/k3-j721s2-r5.dtsi
 F:	arch/arm/mach-k3/j721s2/

-- 
2.54.0

