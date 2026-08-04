Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716BFC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35A7A60722;
	Tue,  4 Aug 2026 00:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yrestk7PezxN; Tue,  4 Aug 2026 00:10:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18E0D606ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802230;
	bh=owo1xXVDefeQMPinfUsXMvcgrDd09LogQt/z/NDUjX4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BBDkoYzi+KsZDxUqDWECVKIwyY1gIX5UrKN5MyojfpTJWXsqnXNlAkv1x7tBu/ReW
	 IYOY4EUZKzhMZ6mOEBybnSA55MHZhJVUL/i0GSGrpRC8yeouclZG8iH/BfepJtJ2Bp
	 nx4cuq/v1bPIVOEnajB1VPD0N6eV3MbpH8exZG/sH6SktFt9cnL2JhoCQPKiASLBPB
	 o0CvtosAgjO5Br+ovM09fEJMyK/leTFVeHeC9edl1HISd4L+Kqoi6bcWNzf49A5NMr
	 qu1HRqeCky5OwT0ufF0pnDqj5rFWGv5kDVWGYbD5ivC4ycBVlJ63q7HKL0tJ+Y7HCo
	 uPKgaWfCO9BNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18E0D606ED;
	Tue,  4 Aug 2026 00:10:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AFAFF218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A16D580BE9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7xeCH5SQKeIg for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 88A5180C0F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88A5180C0F
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88A5180C0F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:26 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673JjGhW779501; Mon, 3 Aug 2026 19:10:22 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0anbun-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:10:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX2HYkdYJMqT/ULOAdW+dbkOkzfLjhPESK2IMo0BWy6WKMD8iYfm8qeOQEJabSe4pMCyANLXKGXxIfTzhrxEPPvvjkgzl7LHl25m1DXCb8FTG13/x0wAsrbhc249dZI7xqlPrOw2OTbWK0UPv6db4PvY/Y8HPNznlbNDc/3QsAc8iGZnpn4ZKCPEud2Dd/Ylol66HQ6gMqR8qjpIxbDjv8goa2dRLy0Jj7/K919tQx+gvXvOloldMtPf92JbeVOG7z5mtLpiKAvD25rHFUdzolid+uRdRkAFDeDnah4jI5oFIyboTbxfDDLR7bNaTnJ/OFhi95pgBzbS4iRleQwSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owo1xXVDefeQMPinfUsXMvcgrDd09LogQt/z/NDUjX4=;
 b=ISRMVrRaOhIsB4yixZkrTpWUt+RKPRPv+RzA9WbHFwo+47ScPoMC462M6qRMbtwvwOAVfngaR228yC2NBl/SOETWLNrdNtb3KNIjL97ShvoLiD6b2qK81wLZpShi7MjtGryW2lTisBwaGWONNIoAJxoV8+7rUlAAv1wSUMFxtMd5Xv48ig97Grgqwg7w/O5SrbzYZhF/sa8nw74hkd/9MCCw7n6F5ILymVCvfVozoD8tEAkskj3IGywdfjAVOxYHgLQUu5YmYW1lMFB22/0BPjO/WdspFZFmD3T/iHYRlQO77RNnRzBwf1IEvYgu8/bjRWDSPxf9tKvR6lFrsPvyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from CH2PR12CA0004.namprd12.prod.outlook.com (2603:10b6:610:57::14)
 by LV8PR10MB7821.namprd10.prod.outlook.com (2603:10b6:408:1e6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 00:10:19 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::13) by CH2PR12CA0004.outlook.office365.com
 (2603:10b6:610:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Tue, 4
 Aug 2026 00:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:10:18 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:51 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:50 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409pJA3381221;
 Mon, 3 Aug 2026 19:09:51 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:32 -0500
Subject: [PATCH v3 07/11] arm: dts: k3-am62lx: Add binman support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-7-b4f4302b09b4@ti.com>
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=7374; i=bb@ti.com;
 h=from:subject:message-id; bh=2eKlbvc+xggRR5VJwP1o+oLoymct6z7WVIlP2pmE6lE=;
 b=owNCWmg5MUFZJlNZcl02LQAAaf///v//tnv6X/y/msnXerfn2uc/Z7x3fXv570//t5vU3P+wA
 RmYIeoGgAaaAA9QA9QADQ9QA0AAAABoA0AaDRkAZAADIZD1B6m1HqD1PT0KGUDQGgNNGmgNqNAZ
 A00AAaaDEND1AAGCYmIY1A0YTQZDTQ0A00yZA0AyNAGSGNJ6hgmho00GmQAyaaGQ0ANDQyAA0A0
 yZGRoMgxNAAMhpk0GgyaAAAMBw++YPQMUfFUSMQPFw5AvbThYEYWCk9KFGgORyHpDHs1SgJqwl5
 groHy/YG/wssIj25/dhIUhIVQ0DoEa1bTfxwabN5c8xsg/ugWcgvFth4Bkr71MzdE3miZdp0zrB
 hutsH0LqgJoCzzg9VbSAHDoyXmye/YuMqY9JkTlwe0EA4BBzbndfcLQVYHNClSJV4EC5hDcmoQ8
 qRpZDN667uDbAUF0/1xtu+fkQ/D5I3uiuePlrjLeyh9uCS+iXRNBz/OnIuOYmba5cvMUmqhtAsH
 QQlEDXRQowqaJD77dWtMCWB2Cxg/Tyfqeb7jKbj/iIV3AXNQx5MoW/CEmVf8nDeGMwVtMSL/w97
 moDBzrKoCxnosj7ohwtpSCOAIjAUA4JFbOR/cVMALEW8+QINeu3bo1C2G3I6AwQJWoh0pq85Ida
 uqP/F3JFOFCQcl02LQ=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|LV8PR10MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf945b8-fbc5-4089-ee07-08def1bcc4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|13003099007|6133799003|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E+uX2DcBVj2ErU6cZ55cqAStVRvlRH8Tty4SmtOb4Tn+v43YeVfjkBK1CAFe4pHcg4Gq4izexd1970xnrUxqNb2YUEssPViYhmqmyrAkL4/frCDxhm70SysKAZ1tr1RZqI72xiUwujNDS/MUMoiKH2ut6q3nhWNU0lBPEgt0mfh3n2vwLHxq1d9r3O1poEIktES+83stG8hUdHRDoxRSkMhw4ZLE9Brfqus/mLmMab7bJCeL2ZRZplpPpC3HZQKscX9n5jVSLl+SYT8LwMdrUMjBtWLYmCiOlyA8jDU5TiLRcVLoGS8W/63KSMzRd/7tnfpiceBQruRabafMn5kYB0pJY0CG0kmnN/tghpzzhQjt0DdnyddvxnWbBzAFfu9TxMDjAKeowP3vRMNHz7JMsQ5lH72mecyo/R53YYqGO8OHYaGCzFAkEmBJbrf+YOKEY5cVRQaNqU8QyjZ/8Qyyy1p2vVm26iToLjl3SijOTjPwquMZPWGbIbko7lLBnXWoDa1X3iD+B7lM8FD1T2BjfVi16GKPFC5sUfmhpVCGa6cAk8YeI4FTbjqfFt0XsjP1xFdno1IN1RZv/RR+Vh8jGPiesFYAZCqnjVW9Ici02f/v+ccqWnSzFWaBEBoT02g3avs6KvDbvHPswidiG/vwPQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(13003099007)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MqfUkoTVUicoZeFy453FwcW1WoWui5yd+Y5I5xSWFmX3xcqhaUpAFagI4eNeBxnd4C4OD7ZaeSNijBMHLrRjMHCMdbNFEMGHrdampD4hR34xwY+KoUAS2uIto5XtMkJvIaktWrKtnJaQsKXhgQmzNJlem3AQjrIo63/0+ts5yhRF/AQhly6Mp56LLZXd/Sw6lcoH0wEEvQ3kmgttEn1QlNhufiEpwj20F7JWoppi8QrC+IoOnKV2w9fAQBQ67Nr69I376ZV8rUqI+PWFcELz0EZ1vtF93LcqYGbZcYkGgVGxLgSPSO+TgOJ2cEtcxwUDWNgsMuWSenpi75t56w/nI8WIDnB4n8qNkXm1QROEbFUzNbaLXdjJQeYboLbPlCYUfmRsnSDo6VF1CmsDE9ahEFyTSjSCnM81xMjdCN+RtGsIoFXNhDsjeG2SpMIfbszo
X-Exchange-RoutingPolicyChecked: VFrlELiPGb29IjqhTezlfz/Q/G/DjzL9AYvk27nzb7/ZViWfmztGBs0D2NxBl2CBWKko4ZSjOtAVLH0KUHgA126/YWwcKuywuFZ7NLYkcfoB3HoaBlaO6w69yCJCTL5UqWvCoO5tcGUCy31ZmGuThQhNRtiALsOJoYobqzMvhnokK7lyjFA1fQCJgj4v1YtOho2GSieu6GY2wLODtVGEE82duv3HjZxVY0pRUwNYp6BTkj8hI6djeudzO/9eThNydNDTtrtiVckxZ4ZSaW+MBrCygmOj7aa636XlRf3IEaJ7aegipzB88RyZnrJriN9H6lHJ4P01L/Kdnr9ar1neaw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:10:18.7846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf945b8-fbc5-4089-ee07-08def1bcc4aa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7821
X-Proofpoint-GUID: kyCa3-TJvXSY21_kacBJUEhf3RMKEeDT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX5at+4vjOEjrt
 bPz2w8TKUwdz7jKi6fJaPHaMNGtsjat3iml8oWuakMZ5GWCSE0ydek96Y+oDjO617q9fEmgwDso
 h/dNgL4m+3CnCbmHATXgAvCIOEBagsw=
X-Authority-Analysis: v=2.4 cv=EpniaycA c=1 sm=1 tr=0 ts=6a712dee cx=c_pps
 a=+4AL93Ollhzyglb1kYk7Zw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=6G3Wt455AjdQPmq9yuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kyCa3-TJvXSY21_kacBJUEhf3RMKEeDT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfXyloQy6AZ69Bl
 BZsJscxpmJ71xMU54VkbUcfYokMfvIlo+/rMpm8ZUlHPpU6g7IuvHJueSGj6x5SgwkdbczoLrox
 qZwShVInm/nBdFEywSsGL27Yi7UlVzxU9NjXt1Arx3k0t/wIe1fBQ3k24EufTU7jlQ6g9Ykk5My
 xnt5qXBgTIy/YhA4+thLWc+AY5tvsofi3R2GNwp9T4yVK/7KeO7fJKJu65iWAS+x/nkNmOj83wn
 0coyKmnSWvuTAHz568QhFgCd7vNhcRgwu4fO/TXFBrQX4pEwDKmQPIKE1OOkmNqr1EOYyh5ZgWP
 n9De0cM9TLsKUTpYEHKukHy9mTETbsJafohSrkk5wINu47auaK4Hd+DaKQcJqOKWup5+PtkbU82
 KmQTFDdnNRkKr1h+/9L/lkcfJ9OSZ7y+iRvjofiYm7mMHS55uXGCGWUq42JT2QYFLM0UWI+5zVz
 JCytNHpGyLRFLBH81OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=owo1xXVDefeQMPinfUsXMvcgrDd09LogQt/z/NDUj
 X4=; b=VhkI/WwcI3VTu5JTH9C+y0mOfj9AEYQ8WOMXy9Chljegiv3MrHqKMWtCD
 riH0NYFx/Rh4jextf9oXEKrYIq9/bXYtcJMKZe37sAaU0fwb4Yrmk5XkE+H1PHnr
 sf4gNluexCCXBxLexd32LxTIAXQdXmzwzPM3WMQXuobW0iukZd/Oc85pVKGTkn4F
 bjfhpedn7Hvwzel5ZuMuLqMa7wsEmlqS9mRES/hgFAYBgNMpiDBn8fdXFe2UwFiz
 fVpp19X6lY/tnMFtP1WmTvj3F1peBBe7Mv0Pdz7PiwvRiQvMtT7HQ8I7n2R+Sm6+
 lwiZKWtJZ7bDIuRWcHGr0sehyQ6Qg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owo1xXVDefeQMPinfUsXMvcgrDd09LogQt/z/NDUjX4=;
 b=uVqwTDyMwXw/tc8LtpLygiFu+DEGMYZVkkJ1TN3eD9XTKATzS2EippfD8IdDnCYfd2o2ciFw05dZak/MWFGq6HbyF2MpdDncYS6qux9+Y+8vKt7SfF7vVerx16ii4jihXDG1+4okLdKbKPN/b3sjeT3feCGJlIUtwEEw+DHMhLE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=VhkI/Wwc; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uVqwTDyM
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

From: Vignesh Raghavendra <vigneshr@ti.com>

Add the initial configuration to build the boot binaries for the AM62L
family of devices

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- Removed bootph from scmi{} node
- Removed signatures from u-boot fit image
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
---
 arch/arm/dts/k3-am62l3-evm-binman.dtsi | 218 +++++++++++++++++++++++++++++++++
 arch/arm/dts/k3-am62l3-evm-u-boot.dtsi |  12 ++
 arch/arm/mach-k3/Kconfig               |  21 ++++
 3 files changed, 251 insertions(+)

diff --git a/arch/arm/dts/k3-am62l3-evm-binman.dtsi b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
new file mode 100644
index 000000000000..3f7e2097e521
--- /dev/null
+++ b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only or MIT
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&binman {
+	custMpk {
+		filename = "custMpk.pem";
+
+		custmpk_pem: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.pem";
+		};
+	};
+
+	custMpk-crt {
+		filename = "custMpk.crt";
+
+		custmpk_crt: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.crt";
+		};
+	};
+
+	custMpk-key {
+		filename = "custMpk.key";
+
+		custmpk_key: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.key";
+		};
+	};
+
+	board-cfg {
+		filename = "board-cfg.bin";
+
+		bcfg_yaml: ti-board-config {
+			config = "board-cfg.yaml";
+			schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+		};
+	};
+
+	sec-cfg {
+		filename = "sec-cfg.bin";
+
+		sec_yaml: ti-board-config {
+			config = "sec-cfg.yaml";
+			schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+		};
+	};
+
+	combined-tifs-cfg {
+		filename = "combined-tifs-cfg.bin";
+
+		ti-board-config {
+			bcfg_yaml_tifs: board-cfg {
+				config = "board-cfg.yaml";
+				schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+			};
+
+			sec_yaml_tifs: sec-cfg {
+				config = "sec-cfg.yaml";
+				schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+			};
+		};
+	};
+
+	tiboot3.bin {
+		filename = "tiboot3.bin";
+
+		ti-secure-rom {
+			content = <&bl1>, <&tifs_enc>, <&tifs_data>, <&tifs_cert>;
+			combined;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&bl1>;
+			content-sysfw = <&tifs_enc>;
+			content-sysfw-data = <&tifs_data>;
+			content-sysfw-inner-cert = <&tifs_cert>;
+			load = <0x70800000>;
+			load-sysfw = <CONFIG_K3_TIFS_LOAD_ADDR>;
+			load-sysfw-data = <CONFIG_K3_TIFS_DATA_LOAD_ADDR>;
+			core-opts = <160>;
+		};
+
+		bl1: atf-bl1 {
+		};
+
+		tifs_enc: tifs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-enc.bin";
+			type = "blob-ext";
+		};
+
+		tifs_data: sysfw-data.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		tifs_cert: tifs-cert.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-cert.bin";
+			type = "blob-ext";
+		};
+	};
+
+	tispl.bin {
+		filename = "tispl.bin";
+
+		ti-secure-rom {
+			content = <&atf>, <&tifs_enc2>, <&tifs_data2>,
+				  <&tifs_cert2>, <&tee>, <&spl>;
+			combined;
+			sysfw-inner-cert;
+			dm-data;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&atf>;
+			content-tee = <&tee>;
+			content-sysfw = <&tifs_enc2>;
+			content-sysfw-data = <&tifs_data2>;
+			content-sysfw-inner-cert = <&tifs_cert2>;
+			content-dm-data = <&spl>;
+			load = <CONFIG_K3_ATF_LOAD_ADDR>;
+			load-sysfw = <CONFIG_K3_TIFS_LOAD_ADDR>;
+			load-sysfw-data = <CONFIG_K3_TIFS_DATA_LOAD_ADDR>;
+			load-dm-data = <CONFIG_SPL_TEXT_BASE>;
+			load-tee = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+		};
+
+		atf: atf-bl31 {
+		};
+
+		tifs_enc2: tifs-enc2.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-enc.bin";
+			type = "blob-ext";
+		};
+
+		tifs_data2: sysfw-data2.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		tifs_cert2: tifs-cert2.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-cert.bin";
+			type = "blob-ext";
+		};
+
+		tee: tee-os {
+		};
+
+		spl: section {
+			u-boot-spl-nodtb {
+			};
+
+			u-boot-spl-pubkey-dtb {
+				algo = "sha512,rsa4096";
+				required = "conf";
+				key-name-hint = "custMpk";
+			};
+		};
+	};
+
+	u-boot.img {
+		filename = "u-boot.img";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "U-Boot fitImage for AM62Lx SK";
+
+			images {
+				uboot {
+					description = "U-Boot for AM62Lx SK";
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+
+					blob {
+						filename = "u-boot-nodtb.bin";
+					};
+
+					hash {
+						algo = "sha512";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am62lx-evm";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					u-boot-dtb {
+					};
+
+					hash {
+						algo = "sha512";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62lx-evm";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi b/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi
new file mode 100644
index 000000000000..d48b478b89c4
--- /dev/null
+++ b/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am62l3-evm-binman.dtsi"
+
+/ {
+	aliases {
+		mmc1 = &sdhci1;
+	};
+};
diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 8249fc97bc93..02f82364777d 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -129,6 +129,26 @@ config K3_EARLY_CONS_IDX
 	  Use this option to set the index of the serial device to be used
 	  for the early console during SPL execution.
 
+config K3_TIFS_LOAD_ADDR
+	hex "Load address of TI's Foundational Security (TIFS) firmware"
+	default 0x40000
+	help
+	  The load address for TI's Foundation Security firmware. This value is
+	  used to build the x509 certificate to tell boot ROM where to place the
+	  TIFS firmware in memory.
+
+	  Unless you know what you're doing. Do not change this value.
+
+config K3_TIFS_DATA_LOAD_ADDR
+	hex "Load address of TIFS configuration data"
+	default 0x6c000
+	help
+	  The load address for TI's Foundation Security configuration data. This
+	  value is used to build the x509 certificate to tell ROM where to place
+	  the TIFS firmware.
+
+	  Unless you know what you're doing. Do not change this value.
+
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
 	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S || SOC_K3_AM62L3)
@@ -149,6 +169,7 @@ config K3_ATF_RESERVED_SIZE
 
 config K3_OPTEE_LOAD_ADDR
 	hex "Load address of OPTEE image"
+	default 0x80200000 if SOC_K3_AM62L3
 	default 0x9e800000
 	help
 	  The load address for the OPTEE image. This value defaults to 0x9e800000

-- 
2.54.0

