Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1019C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 19:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62E9D406D8;
	Tue,  4 Aug 2026 19:10:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eu1yJTQY5JCP; Tue,  4 Aug 2026 19:10:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74DB5405EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785870643;
	bh=sI5h4qmE/+aHV4JYwT7K1fWgtppWtuUGI306iNwwzwE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KsDx2EQ6DI38hdhofyTbvcbq0639HJE5jOulWVpCm1l8kMehNd41J1+Jzb5L/15LP
	 YG1V11bT+5n4exNxrBUgGtrnf85rrOsWX7krBGX9bWOTQ3WOG2V+gFNPs59tuvxuS4
	 07ZwAiiocH/GKIz115qtSrm9DOwj95XjfXa6eiyHFrtWjtY+p2cihjXl/aeSN/YP7d
	 nm/ZvJEjN6GkOg4KMNkdet+yJnhO7KHXn/vOoliIQGca9OYEIn/pTSd5VQbk299LLf
	 M/7E6dhTm3BR/ANBRNoYm6On9+Z57bQyvHRaWF+Z7twkRzRW14uRPeu2s1KRdyxf7T
	 ezqpn4Tccmn/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74DB5405EE;
	Tue,  4 Aug 2026 19:10:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D1B52BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F1D480CB0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ER25fjlxgWJz for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 19:10:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4A1CA80C45
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A1CA80C45
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A1CA80C45
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:10:39 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674J4VJp247418;
 Tue, 4 Aug 2026 14:10:33 -0500
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fubus4sy9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 14:10:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNXR6XUFK4yy/1w7w6PN/iHVn/uOai0q16y6emydP5BJodp8cVtbQfMpVE94EkLYiCBFNoWlE/IaGUe04P9HGFomY02FTVqMyWHkUmPWwKb3qfFs7mBYLVEEIRZ39oVp5XIYblLlxLklnGwqrBzw51mo55iWclmZVYvMmak3JXT7DGqjkFB0b+b2mVP8pHOdQ5p3AzFVI2SumiINuqpZ2cMEANc99FvI8nS/pv8XLHAOZE12oeKeQ/m4ptbh9HOCfI80kEHIVgm2CKf5bjDSEykFqtT+Nz70dnTKbn5msTWaHn9RDvjfGLo+pqr1NBFuBCW/9DpSmr9WQKiw2rdvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI5h4qmE/+aHV4JYwT7K1fWgtppWtuUGI306iNwwzwE=;
 b=cXknjMkhv/3t8cXPYmjVf1SPRK3kcu2x4RpQ6oE5yJrJsxbgJgdq0viSZquehs8+WRa0W4mKhbgRexKoqtF6XMTj7NYZGbSjfP7gYF/d7AHIkm+9VVVS7HrEL8NWzcW2R+p33v7I3Qs5aMGBf45Ye//7Hvf/ovjgK4bICLyJHvbwQfH4lH4UUWeOo8pyMMuJC/RFce3HAUTY1RckvmeYmUwVqT3tFCfzTUxn2nq5nOkfAHni+Hsh2bpQaepmeuIxjKhqHJFDBHSaxItftQ07Y/Y8WXJUn05KbHOdi0DF88P0xDYpz5DoVVDqyTFf6CNksLxuYQwoVQ/pvxUlp728aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from DS7PR07CA0008.namprd07.prod.outlook.com (2603:10b6:5:3af::21)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 19:10:30 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::70) by DS7PR07CA0008.outlook.office365.com
 (2603:10b6:5:3af::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 19:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 19:10:28 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 14:10:05 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 14:10:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 14:10:05 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674JA5jx770678;
 Tue, 4 Aug 2026 14:10:05 -0500
Date: Tue, 4 Aug 2026 14:10:05 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.u-boot-project.org>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Aristo Chen
 <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>, Andrew Davis
 <afd@ti.com>, Daniel Golle <daniel@makrotopia.org>, Johan Jonker
 <jbx6244@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH v3 08/11] configs: am62lx_evm: add initial defconfig
Message-ID: <20260804191005.abaobwafocliua5z@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-8-b4f4302b09b4@ti.com>
 <DKG52UI5DO80.3C8DJ6SO0PCJ@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DKG52UI5DO80.3C8DJ6SO0PCJ@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SJ0PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e72e3ab-7a81-4a8e-0301-08def25c0c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|13003099007|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yguLkhCys3HKRxilk41LA6K3hTkDj8G7gzie5S6WF+1fCNhyqpQnGCDU9AtjWKquboGy4f+vraVW5men52Icx6/goBMhsABfTju4s/r7Hbw31LoTbsJanevOGereid47XO/ZXvBRs2ur2uXxXp58AtnQtdVhVGr4NsIoIrpBoaOfqxfHHvF09nS8809b1aj2sGL2uMgLP0pnjVlFeDpp+cnYPGGtBv8+01UUWcwKfBtXScNTMiV+VoJfEHsJPEhKhGDEu08ibW06gacQCK6T0U6UaaMlz1/VcpM+mWMFqzoMixanWigRen+l2JASPDAKI8klOYJgld7IbvHGjE094IbUJLl1NQN81p+vFPZkfUOxVfkue9z0zbTPwWRV6xbIU3fwzZeOuQzrLdpAJMaApd+r/UMnLAWrT+/8pBFmNmIIjANTAUCpO+oNYlloo781qi3G518HXI94VuoSZmlOkrb3DHQnY7dgyDukQ8LhXOh+EsWVcLUtENcYEmBKtzo7vj5k00XsW+ZMMUTpuquwZfHWpEo5I7bezbH3ytMRPJEHcXNqhUspLwaTFyfNmNor7y39ZhiotzU/i16X+mR8grXXdEDdP/x9hxT/a4yI5Pl7BEyHF4Pn7Rnp9EG8rcYGPbQ9AgZRp83t3Zu4WC+vg1P2R3io9JTB+QqlIYBK4PbBFr5TlGjeeIDZj2Dw0jA45Gc9uMhh3h7y3XIluzoLng==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X/4dhi1Beo/gQbyLVfELFR9+mfhivzH+cv98wHLerjXkhUtM3YFP1HIil8kUc0H6ASSS+Kl0KAXAzzrGXKOrJ01KudMFh23mMOmXWkfs25dUNepPFZb8VciTo3BuTCYSBXx6s9NQo0IyXUMi8HWSFuS8cszVRlh3ZVXgSO1ArWh729lBt5tOaJcEdq1bBHYckehW/qeKHzGhr/tSf0Tzjwy414LxxVXdWnW+dXCGLVUqp5wZTera1EPMmCdt8uzbSZsnsX4DGinD0weGEdPPz/yqsrbYuU0gr/Swy4i6CwkpB6qtIfYbYgQscDpEvfEbH3a9H/1/0puvmGTXkhov4ZySI/8sDdbWbufKU8asm6qgEIIwuN7hKoC1f916TS0hdMe4oC9DSRkLDm+XOvWTs9H3u52J2ZASwzo1RPQwzOYj5iMqTG0PiXEbSRJrI9Vf
X-Exchange-RoutingPolicyChecked: PMjO+VizAGaH/Io/cseAfTa4t0XrXuzTk+3mlKICtqd6rjOVbAyod4DDUbD1bfffJUZQWfHiop9PK9kQzYcUHJYg1BD4hI9tHJhGWKFdmq1KUqpFzYF3oNvFnkfAI1Iq+4BIpb/pjhZKE3xHe5z8gMHB2p6uqGJcCQVBWo0+kV783dIi50aNhhbouZu2UwCA8KL6RpImI5bIkbG1dmS7qejclASnbDSST7YWWJQkEKcURmycdOVWSg1+5TGtwLyHb1Q36z3cuyFMEwZPnh1jKIoGAHexgKGmIVUj4FKyXI/WK70+GQZv9+i4TmCtksvSb6iK8rvWsRdpSOYy4jwzBg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:10:28.6859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e72e3ab-7a81-4a8e-0301-08def25c0c22
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Authority-Analysis: v=2.4 cv=RaagzVtv c=1 sm=1 tr=0 ts=6a723929 cx=c_pps
 a=5k1muW5XIJfqWNzrwyhXkQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=kFTfXmRLTbzspx9D2zoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ouV-NQ9SOHtWm7wvuU5nVeUDynTM0B5B
X-Proofpoint-GUID: ouV-NQ9SOHtWm7wvuU5nVeUDynTM0B5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1NSBTYWx0ZWRfX6JVMzDCFEAre
 ERepaZ4Fbw2ezxFcMLZ1wUhlos1tRt4ehorxYm7ExBD0uwNGSc57azdlqHk4ml+ijlULFkzr1xh
 iRB2mBE3+EV9BSifAJvICdbdgefJTIyPZoHePQIA2dPByn+vHiGwlFANl6B48glSHhVya3fwUBD
 sSVw033hUL6OcCADyPghEqu5pYxNu2h6aZU+My8+H5+sHvF8sFOijhtF87WVZcOTQsPeNm5Nzyb
 Cbn1XVdpVzhXo8oKIcWez995I2X7U8Ig7d12f+KW97WbVyPuA6LNo9c7x38yTNV/yahkMX0pzbq
 zAG0XTLAqBqwcwTDl0OD/ze4EGIjyo7xlE1gt0ArVkUYttxEbFGtwKHvGR7jh4vOUSUnCZ+IoiL
 SLpaQQ7nYXad2GFZUCpNaVmGyxZ/Z6sXzOmWgu3TIz/y4uhFKf9/ldabsRypo8NzvKMkC4NVvWl
 E68/78x8eIofWKr4ujA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1NSBTYWx0ZWRfXybnIOwfTNerG
 U5Bhj/Qgr80NViqvK4zj1JHT3HVYqA9ikZc8SD34DV68C6qox2fZD8z2bQRy/7lpS1dSm1W1cfb
 UZy/Qs6NTMpORDBcvqMx+H+vMi6Uiqk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040155
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=sI5h4qmE/+aHV4J
 YwT7K1fWgtppWtuUGI306iNwwzwE=; b=AiglUxz3eTkeUVxNHWIDhJdyOWQmVAR
 oL5E6XPdTmx3JlNHaB1FmDwdj/izlGeSn/BkXiXfHZpO1VctYbUiFXajSDPaxpIK
 voOSKMmU/n5PZBBUF6NBc+dTXoLtHQFITwkA5IxvqV3PH5rGg1A/ARzmi6ms4JNZ
 k24XaoLa980GfYrYkkgwuQZyevcllgODk7m54N07XZOp73haIj0pm9DJ0ZgAScfd
 nz302i/W9j98DffG1QEI6Tb/7+2ieYDf4bnxtSvtDxA4nPUnC4hce0ds8Q4DGSWF
 vMlBUQ6uw06QZ3iruJ1do71dzBBYQYmjFXg88ObgJIbowsqWBzynibg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI5h4qmE/+aHV4JYwT7K1fWgtppWtuUGI306iNwwzwE=;
 b=Ar9bexl+xs2yBFGGSBgPlQDd8dnvLKljZ57FQnKIPG0X42elPiMg6uaCPwWV1KBbgj1Xcm8O3W+tfgHWOIPn9JB3dez6FbyH6cDd3WHEMRKTtw9Ic8RKK4+MjGkuhdB4Fk/D8Pv6hx0I2BrIfeDFKrf2DWzvAHugxpyjSfNvdx4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AiglUxz3; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Ar9bexl+
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

On August  4, 2026 thus sayeth Anshul Dalal:
> On Tue Aug 4, 2026 at 5:39 AM IST, Bryan Brattlof wrote:
> > Add the initial minimum configuration needed to boot the AM62L3-SK
> > reference boards.
> >
> > Tested-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> > Changes in v2:
> > - removed options used for fit image signing
> > - Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
> > ---
> >  configs/am62lx_evm_defconfig | 139 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >
> > diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
> > new file mode 100644
> > index 000000000000..2db07b508c2a
> > --- /dev/null
> > +++ b/configs/am62lx_evm_defconfig
> > @@ -0,0 +1,139 @@
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_K3=y
> > +CONFIG_TEXT_BASE=0x84000000
> > +CONFIG_SYS_MALLOC_F_LEN=0x8000
> > +CONFIG_TI_COMMON_CMD_OPTIONS=y
> > +CONFIG_SPL_GPIO=y
> > +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> > +CONFIG_SOC_K3_AM62L3=y
> > +CONFIG_TARGET_AM62L3_EVM=y
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b80000
> > +CONFIG_SF_DEFAULT_SPEED=25000000
> > +CONFIG_DM_GPIO=y
> > +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62l3-evm"
> > +CONFIG_OF_LIBFDT_OVERLAY=y
> > +CONFIG_DM_RESET=y
> > +CONFIG_SPL_MMC=y
> > +CONFIG_SPL_SERIAL=y
> > +CONFIG_SPL_STACK_R_ADDR=0x85000000
> > +CONFIG_SPL_TEXT_BASE=0x82000000
> > +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> > +CONFIG_SPL_BSS_START_ADDR=0x82c80000
> > +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> > +CONFIG_SPL_STACK_R=y
> > +CONFIG_SYS_BOOTM_LEN=0x800000
> 
> Currently using the command 'spl export' throws a "Image too large:
> increase CONFIG_SYS_BOOTM_LEN" warning. Steps to reproduce:
> 
> => load mmc 1:2 $loadaddr boot/fitImage
> => spl export fdt $loadaddr
> 
> Is there any reason we are keeping it this low? I think the default of
> 0x8000000 should be fine for us.

Sure I can drop this.

~Bryan
