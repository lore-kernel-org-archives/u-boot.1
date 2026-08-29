Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A782C61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FBBE6066D;
	Sat, 29 Aug 2026 14:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ez0ivkEo03JP; Sat, 29 Aug 2026 14:34:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014082;
	bh=xrDJ9GDqrkkRV9WTkfvAzvEzV5ebNZMt1hJDxifnQPo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AjPBK5xUt+QsopwQkCQIIWau62iO6CtRPbKccvDXmMBZ4g7gVmwHjDkcqw0ezbWPs
	 yfFrXBlfwhJEcTAMtjz20DDEmHhnaqxXzieaw6TVGpoY7rT6W8d2XinSdhcsrkEP++
	 Vpa7N/a0RxyhfZtyzToKAeMWpMapqezpecnnAeZ0VIB+aFBRy46fdwBuTAuz2TQiUW
	 kdwyrexT1m/o6PHpQXVKctTonsBBH2d1v5Ywgv8zuH+aHfg0XQoEvZVmAC4PzigzN7
	 9huaTM6xiGkdAzV8aOzsyVeCMu1ThwEbePJhJb0X6PQlN7/dnntLtBN5zjlB1fytQe
	 4Qz9bx+n0mcow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18C816066F;
	Sat, 29 Aug 2026 14:34:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 507DA3AD
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3604D80E8D
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5hGI2epbzTJD for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=R6TgmWPx; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=HDnPwr44
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6CD980E7E
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:34 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxgJQ269907; Sat, 29 Aug 2026 09:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xrDJ9GDqrkkRV9WTkfvAzvEzV5ebNZMt1hJDxifnQ
 Po=; b=R6TgmWPx31ODFFESfwHLJAEFE4MOr4LKLXHId+tg0nffKXOWchvoOjpBP
 DTA4XFObojoTJ+lsQ60h29s2BRivtq2EC7wDlJ8/XGSSLMKSzsekBgEwME7Wo6Zk
 xFmvDW45TWl5NV3aBY0/QcXF77/Roltr/mdmnidjRfnVGU4OXMbQqQHbaInVVVRN
 jDxmjhZEvs6BddPZM1Yar3XdY/FP7riJFm3hIbbzDOlFDNY6xrUaP25bmlrNh6fp
 MK5w73jCmwY5OndQygGepod8a0uufsFBGOtFea3cAg9mPjYeXgnrG+t1T7kRpAX9
 /IpDIure+HdEff141HCXBBtAWij8Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqn1hrtr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmoQpacQB3hW8ZjDqvIBOgFyaSoHPQqS1SyPOIP3H25pZVO2EjCLBVgkxQ5TkZtMmsiOf1Ihk7SQUe+AzUOD2dMArqnfHBExeYaxhNfK1KV+PAr0Fir3kOvJ8zYBOPYJSLizZCYzXSmUK0pNjkrwBFIyDAJR8vX4EtdCfSAZPyK2DCmnL4j3/V5ON/xtuE7WC8/VQ34+Vli8UJS6guGan16/rZjEX/suPz+3BpvUYgpGRQPJ42OFFWqqrIBRjDLj0+GDi0Bva0pYeEEBs9uEcXiIcXITT0Ei/Q4J2Cm2KqGkgprCCzQ9bTZ+djoZG6HcNEoR4JdY1ouzbyLpuTSEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrDJ9GDqrkkRV9WTkfvAzvEzV5ebNZMt1hJDxifnQPo=;
 b=h23HivYeDZhNFsosf0h9qBSkwVV1jb+zPyPI/pvkZCGOE7IIjcgfsuwHm6SmhZHK5DNzmcv1EdwrDVydaIYCqRgCa5mOZvD1sIzTqyXExq/BJuc+RHxTjvbL+b4DbMe88EpOyuuoXgjKnoD7fzJZribDAZmxAmQ1oNcYP387ayarGF5+9XTbe7vNbQ8K/Q+D1v0xCyCNsN+eW4spUA9G5ijd8fmL0Hxt8pWTWKjNTjmzmJ+itHwMMeeccyMOsEUf9JHK+lD3R1cnwPcXhGNod0Zto/d9DWC5LJUNgwf/zLPsbeB0LlQQGMppCD4rshjSAIbtWtfA9ADlr406MNP8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrDJ9GDqrkkRV9WTkfvAzvEzV5ebNZMt1hJDxifnQPo=;
 b=HDnPwr44psOaFZvFUXNxbOzf/btId+UE+aBz95yfEJJsiCZ3FdhksYxMXzkSjRpxS7nX6U98hoJ8eV4yppv+RYlQS7M6hddAxQwCuh7d+jCld3JSi3rA/wW0SviD6mW1aulVqQi4xKUT2assH+g650Ecr5Ap/WejRem4bS1YmtE=
Received: from SJ0PR05CA0061.namprd05.prod.outlook.com (2603:10b6:a03:332::6)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:29 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::5b) by SJ0PR05CA0061.outlook.office365.com
 (2603:10b6:a03:332::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Sat, 29
 Aug 2026 14:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:27 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYOhJ530325;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:25 -0500
Subject: [PATCH 07/14] board: ti: am62x: add files to MAINTAINERS entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-7-e4e03971e14c@ti.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b716bc9-11ad-4521-8097-08df05daa17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: pfMh8P3QCTq2hx2QMysxGj5oa3qXKvH1UezgrESi5RLLXsm/hPoZrqwYiNv2zP9aNQIaE9wRZ7jolflfJBU54hRx9ty0m1y9v3GD0x3b7SZpdqgw6224y1HVrZTXLsMA9eAWngm3dU0yPT+6GtPjXLVXAikRQEdNqkbPgoJNuhHcfNo+rNTgqAdL/Kj4Z47j3dIZIJvHaqWlzyDtVxgrXZvH50RQ7f50FsLNpKg+dHQpT6Y+mtYN38XAN+L9yWDhSNmdmywgVotQzK9rVGobVnxmtAyeHr1H+0JqJa9x4JOl3egozv/7Vlji9INaTr5CvPNvwAVQpPfSupdNbdNrZ6y2h1RgRfCymWkuAbP0HZvaqcCW1cMm+yTh7My0rRqT4ZC7gVsB6HPs1k0n3EGXvAwHgIn7UyZALJyLFsqcwOzl1GDBdjhLCztJWlIkCOoMC/JczBbq8BlyKeimm1mbp8/BNbwOGl2P2wYqD6yx0iK9QVRNIq8999B2JT1BQ2yXSfBqDpyUpIH1edkXvJqkwdzivX5FBcIgYCgrzYJC55Doyc/5td9xiko95xdTxuzSkJzVwwkJyjuCsUMLmdnRWSKW4w1TXxvmKglyKmi/J6gB11uvFpn9GG8S/bJTNozJgKyfozewYXvk+/4UcRTp7eNyVqDy+NP/fc7E2sCuzvNjsN439xz6iV193iqERd8/Nf1wIzbpJmrFlpSkg7IijQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qWv6O9uJ3k3xjNLU5OMkGhwSIh0F8cBZek1z6HVKBO4S59RuJG3r1+ElORycpzRJiJWrjogzNFgq4z6OUPAOhgn4VBDIzBGFg16S+obWuboHP4f9KllgrwDOaRPv0g5X6AgfC8GqHIwbKGvuXtZ6/Wj9xbgu+McUbXm4A+kR3XmQDR0Lg+SoOM+YM6UONj92MqIc8XYFSo6gEj6yAc1j+l5KpalC3fJb+KXMhUJeuh3HlCDid2vRRVG+dbu9BtCMA04U78583IpDL+xla8gqGORjuk4s0cqgIItVetlITd+L0rS3YhgT91yWGH/g2FuZiJtcAtSt7Kzm13Z+PR2rHLRvB9uZqqmPhIkMG4ad82lwItWjLe/AFCQcweZh+j9oS0UtHd5E6GWDaX3S5o1/hZvjHKb5CuPDGFxCzbyLNBB28vLf5hSAbEM6uZt23fKu
X-Exchange-RoutingPolicyChecked: wspJfhQSsspMFUNLjaLVKAj4aBpApcCMn3OJXwnoKbrf5YfbEDPIFLtO6HujFSnYnq/76hDpA7iW9QS7pTDhuLwqf6UpWvnf7Jb2ezXgNFyi2V02GiW6KGWAjKANJ2rNjasEGzMbDvVT/86PZydNmB4aKaLs65fBzQ7a4YAxJMUu7msNCBfhmxCPA/fI3h3f04x6ALKMq+USQECD/VWNNi4A0PpBVKjbup7Ry0esfNP66lE3kk/7ePMgpLLdG7eAyM3JTWubdiN9yVGNWXOCJ9WC7Jc+P0PwDPATbmN2+3BMXqnz7LrZ7OKLrfrrAGGHP/oik0Y4eC6rVawqg6p8/w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:27.9006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b716bc9-11ad-4521-8097-08df05daa17d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Authority-Analysis: v=2.4 cv=E9j9Y6dl c=1 sm=1 tr=0 ts=6a92edf9 cx=c_pps
 a=k0sZSnccHBAUCD1Alv6C+w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=kxfTTHqvEF9fgvVjft4A:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: lrYl3tL25L177oWcq3lnTBU-6XKrzX2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX33G4umtlaVVu
 SGQESgtjONoIG2/1ucu4M7o7ohdGZkMQC8J7ZvWweB7snBw17u1QhojAL60V6E6Syg9IY37+n/W
 DCY4jnx5M4hnNPk4jfB9yTBUGOV+o0i87e2QcpkKacOonHombhHfi10N85GUIdYO52G4db0imvp
 jSS/+81cthxumW+8yg1eQ83cMwrWhJOEHQPuXQBJzpNKBg11PTxPys6D6pnE770QA0G+8gWpa1j
 XyeDxbnJ5L8zkQ+hrESiy94zcIv0NIoLVabfaVHRCf8aCCerUxrZAhRFn6g5sbFtHLHtfZc5HnX
 b239pnFQe8HZ7k2ptWi8Lf8H6SrR6oaL1fYi6FqfQxsznS/qcBlDP3Lc/4wXNz/G+bSrRDkN2YZ
 pCkrvqWFNitBy2HbHfShEh1Ls51Jt15+Gz6VoNI62EF75kz4YV7KzjebMoi/AnA4DzAMqCKAnir
 RZR5qFD6pAQFcpP2D3A==
X-Proofpoint-ORIG-GUID: lrYl3tL25L177oWcq3lnTBU-6XKrzX2w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfXztVzhx8/sdCX
 yeSwrqSVgwPSdIGP1BlzexfB46Ibqk1vqHXazkcXy0ryOWo77mjmlQG//HJBOTJL0Qef9pU/q+t
 DEHRPX3vbnl/z9iRF7DwF4SdFD2SHfo=
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

There are some files for the AM62 based boards not claimed in the
MAINTAINERS file. Add them.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62x/MAINTAINERS | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
index 295f351364ee..43a7ff11edad 100644
--- a/board/ti/am62x/MAINTAINERS
+++ b/board/ti/am62x/MAINTAINERS
@@ -2,27 +2,73 @@ SK-AM62 BOARD
 M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
+F:	arch/arm/dts/k3-am62-ddr.dtsi
+F:	arch/arm/dts/k3-am625-r5-sk.dts
+F:	arch/arm/dts/k3-am625-r5.dtsi
+F:	arch/arm/dts/k3-am625-sk-binman.dtsi
+F:	arch/arm/dts/k3-am625-sk-u-boot.dtsi
+F:	arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
 F:	board/ti/am62x/
+F:	configs/am62x_a53_android.config
+F:	configs/am62x_a53_splashscreen.config
+F:	configs/am62x_a53_usbdfu.config
+F:	configs/am62x_a53_usbmsc.config
 F:	configs/am62x_evm_a53_defconfig
 F:	configs/am62x_evm_a53_ethboot_defconfig
+F:	configs/am62x_evm_prune_splashscreen.config
 F:	configs/am62x_evm_r5_defconfig
 F:	configs/am62x_evm_r5_ethboot_defconfig
+F:	configs/am62x_r5_usbdfu.config
+F:	configs/am62x_r5_usbmsc.config
+F:	doc/board/ti/am62x_sk.rst
+F:	doc/board/ti/img/boot_diagram_am62.svg
 F:	include/configs/am62x_evm.h
 
 SK-AM62-LP BOARD
 M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
+F:	arch/arm/dts/k3-am62-ddr.dtsi
+F:	arch/arm/dts/k3-am62-lp-sk-binman.dtsi
+F:	arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
+F:	arch/arm/dts/k3-am62-lp4-50-800-800.dtsi
+F:	arch/arm/dts/k3-am62-r5-lp-sk.dts
+F:	arch/arm/dts/k3-am625-r5.dtsi
+F:	arch/arm/dts/k3-am625-sk-binman.dtsi
 F:	board/ti/am62x/
+F:	configs/am62x_a53_android.config
+F:	configs/am62x_a53_splashscreen.config
+F:	configs/am62x_a53_usbdfu.config
+F:	configs/am62x_a53_usbmsc.config
+F:	configs/am62x_evm_prune_splashscreen.config
 F:	configs/am62x_lpsk_a53_defconfig
 F:	configs/am62x_lpsk_r5_defconfig
+F:	configs/am62x_r5_usbdfu.config
+F:	configs/am62x_r5_usbmsc.config
+F:	doc/board/ti/am62x_sk.rst
+F:	doc/board/ti/img/boot_diagram_am62.svg
 F:	include/configs/am62x_evm.h
 
 SK-AM62-SIP BOARD
 M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
+F:	arch/arm/dts/k3-am62-ddr.dtsi
+F:	arch/arm/dts/k3-am625-r5.dtsi
+F:	arch/arm/dts/k3-am625-sk-binman.dtsi
+F:	arch/arm/dts/k3-am6254atl-r5-sk.dts
+F:	arch/arm/dts/k3-am6254atl-sip-ddr-lp4-50-800.dtsi
+F:	arch/arm/dts/k3-am6254atl-sk-u-boot.dtsi
 F:	board/ti/am62x/
 F:	configs/am6254atl_evm_a53_defconfig
 F:	configs/am6254atl_evm_r5_defconfig
+F:	configs/am62x_a53_android.config
+F:	configs/am62x_a53_splashscreen.config
+F:	configs/am62x_a53_usbdfu.config
+F:	configs/am62x_a53_usbmsc.config
+F:	configs/am62x_evm_prune_splashscreen.config
+F:	configs/am62x_r5_usbdfu.config
+F:	configs/am62x_r5_usbmsc.config
+F:	doc/board/ti/am62x_sk.rst
+F:	doc/board/ti/img/boot_diagram_am62.svg
 F:	include/configs/am62x_evm.h

-- 
2.54.0

