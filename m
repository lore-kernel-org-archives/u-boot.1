Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39076C44507
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 10:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAEAF84DC3;
	Fri, 17 Jul 2026 12:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="azYnEAwQ";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RsSklBDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFB8084DCA; Fri, 17 Jul 2026 12:43:11 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1518284DBB
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 12:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HAQvr82239563; Fri, 17 Jul 2026 05:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=9bN+0uiJo8s91
 BZwQCf9zmGHyYeSDmVGzl5yTkHlZ7c=; b=azYnEAwQ49Ovliy+ds/QvU2ON4Ezp
 kETyp5CQbwbMbv8M72m/FmRilRg6z3wErM7jk0jcQC89o8MgFvAUMyx+LGdlOgoo
 qiEf5reIRRty/E52L0nZ1bjlOySfah3G+UqRpstHCXYM6ENp21W7swSkcmSsy6OS
 XuC2dR0QV+O17mzKMr79GjsJlCykNlk+hh2jIEgoyfMHQQ/AUnZKvjdlbOxhSUA3
 QO1VVvW/I2c2Rvnt2iSXO7hOiSebhWIoQwChTM4zDMNfmfr/uRcnyVmODPGiiT8o
 bepFi0mONcuY530o+FGJe1CppuRTgzzC0f4kHXnES1+QZwKGPSFRMYpWA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff2ccw0tf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 05:43:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDDfa0FrkpMRcc3ZzMzpRnNdhxzkGMTeJrh3qZ9QBxdeTNDa+v0tlC6Xm3oTmD95OlFWFEBya1wZMo+hcSE3qfIE4BVa2tpwTxoBauIpgqvbxvZNqMh7dx6pRF+5I0QOkiesAoZH0O/UHb/CouggYZ7M0knoo6zvthySxJgRuCrxRtgWSdTLoGhXW9uDBgotE1U0o9hJZgyuODnUzEVpbwPiEZEUZcEGll8GWLqASG6EjUjoeknQ87XvOP3AKq5i2F1Np/FwvvxAWn5EnhTJ56X2NRGOL4syv1QaS24XYzQoV/EzWB6VLiFZcV+J/4CiKpcftcahX+pIi2aYUZpF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bN+0uiJo8s91BZwQCf9zmGHyYeSDmVGzl5yTkHlZ7c=;
 b=eKLXahSVDRnR+eLpv7ajtizJTDEtz4T+Pi/WCP4oAOGaq+xM2O+he91pEOAGH9IuE8TJ5KXIsZk0b7mFvMeye1GKj3iSTNW0Wb4GAIjuVwN0WJYThKnInjQKzgFZ2suSEX3QyOpO6l+A8S/1vYJQA8IiaOA6asFIa4h5SXgS6qLHZZDw1VGCNh9OnP8DHP12ABMWxt/rc+XzcvF3CovGtQwVa3/NpVNMAZFWb14Ur2mV+i1YaIqIMHtjUAL69UtI7nS1iyQMs1S51GjG/f8QU1O2RO1NkC2R/zZ67+5cvDuyNZ1Jy7uXr72N2UPw9iqNVDj2ZlJvJdiws6w+EWIAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bN+0uiJo8s91BZwQCf9zmGHyYeSDmVGzl5yTkHlZ7c=;
 b=RsSklBDTYMdt+XnIGI3UgtHS+YR4L6sHhNPbN2xjpyKK5sj7B5/aIStn4PJnmG/joYYUZGAhWYAas+Ou3xdCje9r4G6VGhTzwv6cLTNEe77hkPDHJHELLW/BDGPFLiwCJT8VhSvb9X/5AjrkH1W0OvkZ6ZM8fju8qPeYCVKB+pY=
Received: from SN6PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:805:106::13) by SN7PR10MB6332.namprd10.prod.outlook.com
 (2603:10b6:806:270::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 10:42:59 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::6c) by SN6PR2101CA0003.outlook.office365.com
 (2603:10b6:805:106::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5 via Frontend Transport; Fri, 17
 Jul 2026 10:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:42:59 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:42:58 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:42:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 05:42:58 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HAgv0N3617334;
 Fri, 17 Jul 2026 05:42:58 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 0/2] Refactor binman nodes for boot binaries for TI AM625
 into templates
Date: Fri, 17 Jul 2026 16:12:51 +0530
Message-ID: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Nz3Wzj+KTMvNzEvPii1LTE5JL8Il0DC0MzQ9O0xKSk1EQloMYCoEx
 mBdjQ6FgIv7g0KSs1uQRkklJtLQD1NOgjdgAAAA==
X-Change-ID: 20260717-k3_binman_refactor-081615fabbea
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Aristo Chen
 <aristo.chen@canonical.com>, Suhaas Joshi <s-joshi@ti.com>, Bryan Brattlof
 <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Sparsh Kumar <sparsh-kumar@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784284977; l=1722;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=n6K4TJxV45Eyv/MS5TRhbwo4Jq6JhuZStNhZZuyEVhM=;
 b=cDAQNkWi8W2KNVBuMMjQIXMpfm6787o/9nGcRWMonY7IYqKeZ+iEAucfXlItNL3Eebn2r9Sys
 4acMuEOpEejCmo1OL4iN9M4z9/22Fj7N9a7ofRalE5P4Jo8ePPFoPJY
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SN7PR10MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c86272-329b-4d2d-8ee6-08dee3f02b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 54/HrGWXdRDUDevRRls4pn/QcvY7NrGNNLn66r2y16K0+Ji3MkZwqHdaBTWQ0Ua5ANTIei3JaVCbfcK41nMOBFYbnuudvEMxfaincc+ED/sY9h9y9qfoVn3zi1/3hyJkk7msdalM5dXRb82FM+1RL9XpUQcF74yNzaTkitnDPgyo/58RqnM2zANLZlG/Db56xVjgCOBFymTfXCLOrq3VagQsfsAGYBFb3yTmKryCxuXrInX6L+evQT7+wYC8QAf12bvRmtfNKBP5qddqkae/DUdKEnS+KsOog5fcVBGaEIX52TcGbZC3iB4OQAP8IHot2EzcwKLQfNhoZpeIZjHXVETn5aYP4Ngr34mHrFkh6tjeL8O+9JNLcQZ4eDXbBSuUMQneTb4lVqjlCp3nhYpDRV3igDsmnvxlsY9U0Usjna4T7n3z6/f+dGs4J0iBx9Zg/wlBBKqHspA+nK+FKLkBs81AcZkB9jyVr/Ln9YDhCfc/65qJnvAtaZVwbqlspdnWZ5ln4DJZ7cMjgEy3SNS2xL3Wk8nozFHUtl0dJMCV+aJ8IPSdDCcYQiQiCUCjnMDFBRxP9N8WHsqIozRKtJJSXIdXPdiUvlYpZhmXMNPnc/nw/Dg+6zi1o+YSjJUwo0aKBsePFyC/S7FoolHuqHjkpeK+vsvIx41IAMKATPHmOD5kJ+IA9g7N2d9IyVaecW/XwN7AXUb6+pLr1T0YYafqDw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jQoeaqLMjRcG6X2BV2qyIMNg6wjK5dyKnJKetC2CAw6eypX49y4+jEhzfW6py12V2jN6RnF7Ndbu4vUhNj2rhvuxXlkkDu+XAT/JVLECEVqNQIg5f4fEQSFPDRrYhbNLk6UXlqz0nbAgcsUqxZhEMOxYgbfbhozvjU2ZUSOUTwuLasSQZglP3hqY1Qb1fSbZ8738B+rx3GUlAvK6tvU/lwuAHibHOMAevLMd7/O3iYGF3eGcJqCtaEnessgkjGqRDnTpqNStZKmJENsJobpVNMHQn+n3jvzkQfv3xNR6W9I2XoGtRG6Sgl46y245i8S9oN8Rx3DYoeG27fwVDE0UoNGYc0o//RJo5jM1KyhCqU9IoQR/5r7ct8qKQLuCbE0/u8RPpByOMuWR671vIci3NBNOz0rHmAWasS6MZ/k1xZPUXgLv5JpB6SBlvRTtxZMK
X-Exchange-RoutingPolicyChecked: CYWQxU6KuaUV/jynCgalxcnAnJu4+/RnKnfMFMVsok0fFZDyM4UfBk+/QvoW/7qAeedqqc266eSIZXr6LOAq+yg1u/lG8eXNxAPzplF/2L/KQ4SVBOfunQU2QPKX7dDrcpAv9HpO/6ko7cqNy3MdnyphBe4QZi+LWjwkbPLqE41f5fhaAxoaKb7yvyvw29qrjxFIVUJP+s2lwAaY7DG0oO8ISd16kX19vsaJ3U0LmzAzpoTVtXmWyQAOx627RmwwOPWqYWV/9v48B1f3+0SWQ5R1UcRxrgVCa8jxkV/65R9pegv5fmQfQNvJGYwo9nGNwkk4TM5x8jmJFQDZmEljWg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:42:59.1663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c86272-329b-4d2d-8ee6-08dee3f02b5d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6332
X-Authority-Analysis: v=2.4 cv=NtvhtcdJ c=1 sm=1 tr=0 ts=6a5a0736 cx=c_pps
 a=FnNH6Hr+id3EzXqhVuY+iw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=dsBQDNjR4xsAJqLJe2YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jMtK62Du86ilEJDeqQh5U5HgGLDb8N0z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX1vHTaXRQIWqu
 hhqqb9PbuORo4kXe8QZkCKPpjQOnRrYQncm+WFJiCdkV1+W/nZMWd8GP5kuaMpmjpU6E5vkq/59
 JFZoFMbilKjs86c5ZPdSE1s4k+zEkWsHVljzHepCK90qZihw3nWMgeQ7VpztitNMTRWRyXpmLMH
 1NgzFOBPSoTOrGcsHAlWyAsfOFQ0ww02YPqQDlllpBsKGHoHGeivlyb+P/fbdvtS9hH+fiqTpoc
 zuEbKyRo5vf6gOisdHCFWIODigaJsiKwxfqcKdJ5jNGtINCJWcPnHzutoEqx0YDaX0F9qRbhDLL
 MUcugZpkxtqLB5MNPWQsD45RHAAmQJOQTRkzABaOZg6HwUHN20AlUGZ902GoR/wyuGb0Cw7iNUJ
 T/a1apSObDtFCE+td/Y0FXsdtKzjHqFO+F3LYtChqrr8nIz0WbvHRgDTgQM7rhdaE08br+LulDM
 BTMLTBZMaYuDltMb15w==
X-Proofpoint-GUID: jMtK62Du86ilEJDeqQh5U5HgGLDb8N0z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX+Tkypa/UzAON
 K7FS7BSkGsHMiHOVLKveI962pnRGgoRfOaStIxqFjonO5mDb9NtNJJSE3Om9ZPjO7RFc5jUxMXN
 DgnOHiMK3/FEeDTEfkvO17nY06yfdVc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170107
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi all,

This patch series seeks to help in reuse by moving currently duplicated
entries for tiboot3.bin and tispl.bin into a generic SoC wide DTSI
(k3-am625-binman.dtsi).

This dtsi in-turn gets included by all AM625 based boards which can
insert the templates from k3-am625-binman.dtsi.

The newly added templates are as follows:
  tiboot3_am625_hs
  tiboot3_am625_hs_fs
  tiboot3_am625_gp
  ti_falcon_am625
  ti_spl_unsigned_am625
  ti_spl_am625

The series has been boot tested on beagleplay and AM62x EVM but the
following affected boards have only been build tested:
  - phycore_am62x
  - verdin-am62

To verify no regressions, I compared the final 'u-boot.dtb.out' for both
the R5 and A53 build using dtx_diff script from linux source.

Depends on: https://lore.kernel.org/u-boot/20260709-binman_template_phandle_copy_fix-v2-1-6c4017eec04d@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Anshul Dalal (2):
      arm: dts: k3-am625: add template for tiboot3.bin
      arm: dts: k3-am625: add template for tispl.bin

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |  94 +----
 arch/arm/dts/k3-am625-binman.dtsi                 | 363 ++++++++++++++++++
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 357 +-----------------
 arch/arm/dts/k3-am625-r5-beagleplay.dts           |  33 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi              | 430 +++-------------------
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 301 +--------------
 6 files changed, 419 insertions(+), 1159 deletions(-)
---
base-commit: 2262ee62cd2fb5ee728b215361143cd174f3f310
change-id: 20260717-k3_binman_refactor-081615fabbea

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

