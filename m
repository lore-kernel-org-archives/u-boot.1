Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5AFC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 10:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CC558114B;
	Wed, 29 Jul 2026 10:25:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ac1UhdRnYLzn; Wed, 29 Jul 2026 10:25:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7010881182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785320726;
	bh=BHU8CsS3rJENzXLtkXB4LXMXNheRHa651TEHjc0ZcR0=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a4n5ly5WSCy552Ri/MWEi+9xq3Hh7ygDFurBsGioYrBwH1Oe3DunRk0/jC40zZAd3
	 pcHNJ/tjpJYz616Oixg4ICWqaVGLtB3QccBg/Y6YEeKuIt0dDoIefDHnMyszoNG5Ts
	 p9hFMoUG9JuOL6yRyq31N3P/KAJEegM69JIftaqL0go7utcdDitHW3W80aYunzV3df
	 EUz1EpTbNwD/Z3HPnIDzq67fgoKjAHsl3LEXGwdeb9gyMa/WIzpt59uruUcBHdCIa/
	 hF39l49geY+eivYzSawyTS3qA2AwLLcEo6LC1SclWM0j9EcLKHvIGfo2Bl2d+5shQx
	 UZDK2vOXp8W7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7010881182;
	Wed, 29 Jul 2026 10:25:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F9B8350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 659A1401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:25:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NxGcahL_Egcg for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:25:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anshuld@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 76C6840156
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76C6840156
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76C6840156
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:25:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594398493F; Wed, 29 Jul 2026 12:25:21 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C173803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 12:25:17 +0200 (CEST)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66T7eD8x3522232;
 Wed, 29 Jul 2026 05:25:13 -0500
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fq41vur6s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 05:25:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwAi18wY4nsh0fc6qZAfXvp9/+K0sz8C3BLD1RuG6MRm3L9R1/u0i3HCOMEiJFisOrQMnTSKSxTaHYv9yzRxIKWsQjXjc+MIGWOdwepeoU3+aasncTV/90ZjfQH3poKbnSNwcgnEOfY28I/BwT51dCa+5DqJHcoEWN5pZ6pSYnH0QU9B17YndR2fDFIDEawbanebZT4xJHMIsdTzjHJ0UPs7y2EWvqmwECJgXkoMmU+5UBNA3z1YdOXmy0snQydBHWwHAgOgyq6H43Dnkf+FXiHZxMdeJKXywmlimJ8qx0FtUOsoRo9klLTYCTxaFVEGm5ZbyBbWGP8t5DRNFXB9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHU8CsS3rJENzXLtkXB4LXMXNheRHa651TEHjc0ZcR0=;
 b=HkLZ6l8l3ABODecNTpRATWtzcz2HGtQqe3JncYVoMu/aNFNxMpi0SU5eHcCVIEBrTYClBQXAxtgL0BO/wfIInhyaIqCN28klR1LOFV9yMBXMUks9QlQnkJ/DFharPn+VegzECYmNXeTePVGlah5CBgtWDBU4dpVcN9bVu9KRtqVyUDrKX1u4OJfqc6Q6Fx4iZt3pbI0DMdXb6fC9ZME4JCZ3la9UBq91OsqbECEjh/6z5PbNI2vMpvyzb3cU5ama0kGXXoFnCJ2vLvkj6pKf8PTLT3x3AbhryINmycGKYFHE3NMFFnT0fi/nRZsMBxGHlqn+QD/xEwFGW4bzzYpKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::18)
 by LV0PR10MB997637.namprd10.prod.outlook.com (2603:10b6:408:345::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Wed, 29 Jul
 2026 10:25:10 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52b:cafe::6) by MN0P223CA0029.outlook.office365.com
 (2603:10b6:208:52b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 10:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 10:25:08 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:25:04 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:25:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 05:25:04 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TAP3JE1099543;
 Wed, 29 Jul 2026 05:25:04 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 29 Jul 2026 15:54:57 +0530
Subject: [PATCH v3] fdt: Fix phandles not copying when using templates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WO0Q6CIBSGX8VxHQ1RUbvqPVpziMekKTAglnO+e
 2hb3dbO1f/v2/efBTmwEhw6JQuyEKSTWsWQHRIkBq5ugGUXM6KEMsJojVupJq4aD5MZuYfGRKo
 boRHazE0vn7guWCsyAXnVMRQ1xkKs94nL9Z3do72D8Jt3IwbpvLbz/kNIN+6PuZDieDXr64KnW
 VZVZy+PQk9o2wr0ayvJLzYabUzkJC0BBMm7j21d1xf03qU/LQEAAA==
X-Change-ID: 20260629-binman_template_phandle_copy_fix-956bc3ce48d6
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Moteen Shah
 <m-shah@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785320703; l=4883;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=TSj/K75tj8yLcfZUKafsFHxpYK63akXDJfDfJDJ1TC0=;
 b=vKsYDQiPwYVjFRJM/lDINUV78bC3EAPByqMMO9Y5iGoZCuFouI9TlbiGtBH6yBcXtIFJUNhl2
 mMxdWwFD2wjB9UN80ihB+itGiWmgURXXYjNq9t9kdiiYWR/3Ig+IgD8
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|LV0PR10MB997637:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2a7db2-86b4-43de-ddae-08deed5baa73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|13003099007|6133799003|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: IGE4p2wqIHbHZZa3GxJlpvEwoVC8OhFZH/LcZg5fq2qvDUfqHoWz/WTBotAbc1ZXCEyo8zCLaf7R+2LY7XBT+K08c2ByXNhkPFjIw69jkUOAKJicqOXXro4CSv2f78iuUXj0q/f5wTE5NV1cnhCTxok3V273BxI/Ry4ylibT/aYxdlC2A0heRbttFyK8vaEPQ+2NfSGOsWJWHPvWs9lcOIVIwB5sH6iTjHn6l8q10ld8T6ZNcq470FMdS9H3EcrusBf2Wt/IZmulk2AmggirglTITNRMPrdCpnuzd/IHVb5gaGQriwyP2lRnNlDO+Pey9BDFbZeQjTur+4codI0uxcPZXqdvXfu9zTRi0+hd1oQRi2IIcCFD4yPmnu8E4bfplECbg8TEUj10jFxamW2jySlFvzlhIIo97IkZfpHwO/49SXgibXf2l9g5JdHMiOpD8o93fp4mmkImS6eMHl/GV3Q64CwHVF2xC6VQsmrWN1FH2ko1rNRM9cnRLNj+nPWAMMHAg1Jgl1pjdkE2zaXd6QsSjk+d9ORIAyDltog6e0vZ1g3tlff74HLJqcVIrH1RCmAVnJmOOHGvphImQ0Ngvkb5fUpVxlpA/nC7DmA3VQ/xXLNz0EdnmPGUszsufTC67zDfwkHn7Tn1GK8y0j2GtQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(13003099007)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K59kM2C7W5sldwcOPunnReQCcwWknTTYQN5EFwLl9um+I4do1aSQASNFIqAqAuNPgUhHV75EckSX3WrUL0FJEJ7CpoXpKxgfvM2HVsV4LfLYu9LMc4Dyu0SaKUxGZ2tyFoVQYg4B6L1qPfJJ+iwrzcMY5qE9pwf+pxdQeyEdKCJ++9OW1hcjAiX+zsLW2us2opULFjWzO9r+lifLnRGKBD/EKuCChX+dwWgn2AsSOjBokORLg8hDtHuNF5GDve4skYLXlm8M2u5ftbBedIGcqU6XpsUqGs29Pd+AlbwA+SMaLggcoapa0MVq8LTAyjfL4jyyR5h2aVwgVeZmCHQ3D74RIhQ/ufrpeH68UxNrxOSv3UOx2FQbTmaLUlXjaHNGE2TdmXLUbJ7Nq4IXdBkD7rG5bmfm0T9y+PWEaYVyDTbQ4iALlh8ygMfLsFl6D1l2
X-Exchange-RoutingPolicyChecked: PC7I4XDkdCQVWfxmeNdN5eCOmCoGxooNF02fFdGtucDhvHUS2t3OoG+2pV4nubj6LZ6z1/ECSYmf4ilrxZAskScjdqUMeOLMovBETJmi3oddy/WZXJaMTeyz3vSlDXs06ufGFpzMn74fVTblCnX11kpIPDyPP0beIq4mQXExHE/9rl2buQ4plnwuuXmsbCdM1XxvaHrAQmPglZO/WY0B+kOFf6+SCMr4oiC5tjxoXh3Ar9t0+VqX7fnwgbgR/s/mbA0q0xjPjmitE+E8RiAZCO1lQf3bVVco7aFtNAs5j+GmMINGRpPmPvxSzYeY08HUmgKF0rsez8pD7w8qgxJamg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:25:08.9593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2a7db2-86b4-43de-ddae-08deed5baa73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997637
X-Authority-Analysis: v=2.4 cv=D/h37PRj c=1 sm=1 tr=0 ts=6a69d509 cx=c_pps
 a=LBR8CsJoUNkXwF8+XrmcNA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=bC-a23v3AAAA:8 a=sozttTNsAAAA:8
 a=ZWEnbyJajEXULzUB3ZgA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: HpywXx7PxE4psRunTM8881EWg0UzUXzw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfXxlBg3HitZOkP
 etUH4uoeJrDmD/M6CuB7l7PREJXNpz4t9fXC+u0dNc721ZFUI1tzaR/tjXgPliYyE7QPEKDUUbk
 IdxpsN/J82kTev8WCYU5qpslXL235Rk=
X-Proofpoint-ORIG-GUID: HpywXx7PxE4psRunTM8881EWg0UzUXzw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfX3xBy6+ufVDI2
 KW36c+8zro/khjY0Eo6dP6xU5+GWhigYdUKFv1WCahGuvIBDgilYQw5eHLCRUWuEwhKtIQA3cq0
 uxSlr0VaZGZzgsx01RPgkD9so9hr/kYcGlxIPA8/3w1ipN9F9nGvXLrT+uSBntME32x4pV6qEr3
 3ZnOoIgRtGokZCj83B4iADn+fzEIL9AXOaeLvi+kmooOBOkUJ7fkHYj2acsK4E+xtW1OiBWbVAz
 3fSDoZGaIZzk3h6MQq6mT03yEU9FPDHOTmAvjikytALnGJKlM+CPuphm0m3zQ8TYPcndgRBsVy2
 E4e25VUU2E1E4PVFigssleYyXxhqnAfHKEcGkyrXfxnn1vugtr3LB0t9/FUK5qEnuC4V9B5ojMy
 TvcpNKiuxQSflKR/ZKXCFrKKXli2MXIt4mPRntkY+r96avCPnMYb8DlJuss7HmPWxYLFFckKXSG
 VJUs3L17tIXqvKPPhJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290086
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=BHU8CsS3rJENz
 XLtkXB4LXMXNheRHa651TEHjc0ZcR0=; b=iTjBS4MRCsysFXmKYz11hyH3k79AB
 N8UeoBH4TU9qQDO2xtGxvsJzWVe1zDayFotmgRLgNufWsU6KSo3upXAnDC+kc2Tg
 0R/sDzvv/bnvU6v0AmjK9vWzsnGCFeucyRn3TbRhXHQh7W5XySVlE6h7j358XF3L
 zB2FBbhcvNUIS94dvqgicW1VUA4xQ47CHix+lQOayLeprTnmDKQUdIg6cO2GwNNZ
 hdiCO1Fxj+DCyjv7QhHi1DKpWQJWTob3Scnuj+Ap+lMAkkpYMpJDWX9U/biSCszk
 1Y3Y8QZho0MRjfGr2cbPVR/UU9dpe7II8E6xy+Di6SHG5xpDHpztX/IKw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHU8CsS3rJENzXLtkXB4LXMXNheRHa651TEHjc0ZcR0=;
 b=tA6ggiz0O8gVBaueXsNAYDjgEbSYVZU8ovM/wrrFWPXn7Uvx3iQ7feO2A242xJDi4WajqbF+V7AjD865uHSCBtdwc0TMSwc1I1z1NokdLCq88Wh8KER2YnRTu1MLj8v5ugqv3TAcEWap2g4Rir+M0uUjMRgGv/G38hp9GnbpevU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=iTjBS4MR; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=tA6ggiz0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anshuld@ti.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="iTjBS4MR"; 
 dkim=pass (1024-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="tA6ggiz0"; 
 dkim-atps=neutral
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

The phandles used inside a template are not copied to the node inserting
the template, leading to a missing phandle error.

The following example can be used to reproduce the issue:

&binman {
  some_template: template-0 {
    ti-secure-rom {
      content = <&some_data>;
      keyfile = "some_key";
    };
    some_data: blob-ext {
      optional;
    };
  };
  output-bin {
    insert-template = <&some_template>;
  };
};

With the error 'binman: Node '/binman/output-bin/ti-secure-rom': Cannot
find node for phandle 103' observed.

The test_copy_subnodes_from_phandles was also updated to verify the new
behavior of phandles being copied.

Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v3:
- Add the missing 'R/by' tag, that was missed on v2
- Reword commit message
- Fix test_copy_subnodes_from_phandles
- Refactor lines within 80 column length
- Link to v2: https://patch.msgid.link/20260709-binman_template_phandle_copy_fix-v2-1-6c4017eec04d@ti.com

Changes in v2:
- Add 'testTemplatePhandleCopy' binman test
- Change assignment in fdt.py from unused 'dst' to _
- Link to v1: https://patch.msgid.link/20260629-binman_template_phandle_copy_fix-v1-1-196f95a13388@ti.com
---
 tools/binman/ftest.py                           | 12 ++++++++++++
 tools/binman/test/fdt/template_phandle_copy.dts | 22 ++++++++++++++++++++++
 tools/dtoc/fdt.py                               |  2 +-
 tools/dtoc/test_fdt.py                          |  4 ++--
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac15..5e20b5c78056 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8552,5 +8552,17 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(len(subnode4.props), 0,
                         "subnode shouldn't have any properties")
 
+    def testTemplatePhandleCopy(self):
+        """Test if phandles are copied properly when inserting template"""
+        _, _, _, fname = self._DoReadFileDtb('fdt/template_phandle_copy.dts')
+        dtb = fdt.Fdt(fname)
+        dtb.Scan()
+        parent = dtb.GetNode("/binman/section@0/section@1")
+        child = parent.FindNode("section@2")
+        parent_phandle = fdt_util.fdt32_to_cpu(child.props["parent"].value)
+        child_phandle = fdt_util.fdt32_to_cpu(parent.props["child"].value)
+        self.assertEqual(parent, dtb.LookupPhandle(parent_phandle))
+        self.assertEqual(child, dtb.LookupPhandle(child_phandle))
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/fdt/template_phandle_copy.dts b/tools/binman/test/fdt/template_phandle_copy.dts
new file mode 100644
index 000000000000..5c6782372a48
--- /dev/null
+++ b/tools/binman/test/fdt/template_phandle_copy.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman: binman {
+		some_template: template {
+			parent: section@1 {
+				child = <&child>;
+				child: section@2 {
+					parent = <&parent>;
+				};
+			};
+		};
+
+		section@0 {
+			insert-template = <&some_template>;
+		};
+	};
+};
diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
index 991a36b98796..64123227d7bf 100644
--- a/tools/dtoc/fdt.py
+++ b/tools/dtoc/fdt.py
@@ -780,7 +780,7 @@ class Node:
             parent = self.GetFdt().LookupPhandle(phandle)
             tout.debug(f'adding template {parent.path} to node {self.path}')
             for node in parent.subnodes.__reversed__():
-                dst = self.copy_node(node)
+                self.copy_node(node, True)
 
             tout.debug(f'merge props from {parent.path} to {self.path}')
             self.merge_props(parent, False)
diff --git a/tools/dtoc/test_fdt.py b/tools/dtoc/test_fdt.py
index f141f931a949..a858da127bfb 100755
--- a/tools/dtoc/test_fdt.py
+++ b/tools/dtoc/test_fdt.py
@@ -426,10 +426,10 @@ class TestNode(unittest.TestCase):
              '/dest/second', '/dest/existing', '/dest/base'],
             [n.path for n in dst.subnodes])
 
-        # Make sure that the phandle for 'over' is not copied
+        # Make sure that the phandle for 'over' is copied
         over = dst.FindNode('over')
         tout.debug(f'keys: {over.props.keys()}')
-        self.assertNotIn('phandle', over.props.keys())
+        self.assertIn('phandle', over.props.keys())
 
         # Check the merged properties, first the base ones in '/dest'
         expect = {'bootph-all', 'compatible', 'stringarray', 'longbytearray',

---
base-commit: 63f6cc8ba618396cb9c0161bb5c6d217604ae1d0
change-id: 20260629-binman_template_phandle_copy_fix-956bc3ce48d6

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

