Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA521C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AEB84D89;
	Thu, 16 Jul 2026 10:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SGycDz6I";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RfWdnkjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32FA84CE4; Thu, 16 Jul 2026 10:06:15 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9575A84AC5
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66G7G3Zg1640130;
 Thu, 16 Jul 2026 03:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=SUkrngsfC1O8m/bJ+00mvL9YqUV9/6M8RytA87DgR
 9U=; b=SGycDz6IEMfzuoGufnaRUzmrti8E4FOT7xVX6H7sriqDS6et2cyN/dfD2
 hiVDc1yE22IZ4lVWxpIFPoN8pT100KZf0yYC4CzSjcPrQYUuoHwadAvqmX3o44UP
 aKCJAPl0VMLzQZQmdmjKwFFr6wbcZWiycBKn8/lSLQNdJU96gCrJGQZac+Mojsml
 yZCO/Zy4iCXFbLudMBeBjXjtsV3JH5b2Be2ZIxuzlbr6Q5E/MFHkyEJOzffmr3wL
 mTP4xRldyIJ2DnB3Ww6IdYWEpN0WuXk0kKWJQpWdraw7lj/mFmS11Vby1wB3ICSu
 IQ/GwRnxb5++wek/bm7dIHr/GQdCQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fep5s9n91-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 03:06:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfymvheORSwT19DFkyeJ2w3hmNgXeFzI630hORpZhL5WcXObTayQjl+503R1HShQ2C0xMT6ISXJZpkhAINoLDF6QpP2Ohd1DDHyscZuWMhivNAr78514f6vHwxh89ISGRnsy1+VmDjdG54mVrmuGIJsA0Hi1UPaWM9sFh5kSWjGpTlkzJi/OaO6a6rDBIqYx1cal/nt6VKP5s+cJi7tQr1zvnD5oBhZX7FPIn2o/cD0i7eCs8/crCM4Qkc+AhAFH1ch/ZMf2lV0ftCnaszsZQ1NWAYF/xu3+Wpdl6Bn9dNGrct+BaWfqoKkWBnWnGAhM81MD/Q7WwuVbCL0HvxfHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUkrngsfC1O8m/bJ+00mvL9YqUV9/6M8RytA87DgR9U=;
 b=uXBxXQkdCPgeMdcccbhi256zW3C8oE/0ozepGXiBcRlP2fJ07o1ROYaScSrOW6lAFhRawMYTZUD5lupc9uMpR49I4iICcho06J8thyY4UtlAbJLGCCiSPS9dcwLjAscG7KrUsiDlcGIRqQInqXWsLhVAR81kBjJUQLcYgLFpuvpFfGk7JwCuJZQQpDfTrwlmYq+1g2glu+5UnJeXxHRwADUiUxQqkxVZo0Ku/7sn459dRx7FrlTOeTlKNIwS7NSdeMG7tiY7aGSh8Sl0ZcxHGUxTCqWIp7Y0xUQZn4lDpDnZDn9R5nUfc40Qv4Hz/KLIBpEW0+rzG/kjNDeVZcCTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUkrngsfC1O8m/bJ+00mvL9YqUV9/6M8RytA87DgR9U=;
 b=RfWdnkjz7l7zochWZl8q5ovxOjj3YHMTF6vQiDlHbe/zomOaZdoba48PEydkisSFk4hI0d7CLguSYJv6wxhDJ/iFDsC0WgwIrFQiKmgRZa1d+D7/JrnSp4FtucK7HO26TAwbkmnKKfQAgSjuUSvgoklhwa6THEKTklaupJJ9JTI=
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by SAWPR10MB997814.namprd10.prod.outlook.com (2603:10b6:806:4e2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Thu, 16 Jul
 2026 08:06:07 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::24) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 08:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 08:06:06 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:06:01 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:06:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 03:06:01 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G860pT867859;
 Thu, 16 Jul 2026 03:06:01 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Bryan
 Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v3 3/4] arm: dts: k3-am62a7-sk-u-boot: Enable DM services for
 main_pktdma
Date: Thu, 16 Jul 2026 13:35:52 +0530
Message-ID: <20260716080553.2664147-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716080553.2664147-1-c-vankar@ti.com>
References: <20260716080553.2664147-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|SAWPR10MB997814:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d245e0-6602-4f6b-aa9d-08dee31116d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|13003099007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 79nOprz1cDF5u3iYyTDTrbiWrD5M6fLGJp5LlNCZ+DBBsjQt7L/jN4z2vsmjmdI47imPPZDoZXMyRuTTNlwAO+EoTqqE8mPg6QrXx70Tn3fRCYAtoynp9xyK7bVUbFbgZFJPvv+zyDxfUxtLqSIFSQFLyxB/1WxDiitI9HsCuKZUd6Iz45csSqoNfVs9N3Gspc9JHOiAypQ6OIaUGVm1m4ytRBeImkOLAgvEN+tHPg9Fdx1EBRJMO8bI0AB45SC8g78ax/zzX3IZL+Bnvqn6PSjzN/IbVJ01kTCVVyV9Nus5G+quoAgITGvdJhZmRr/eMbBFUui2fRyrQ8Dt6h9zrIkuR9db0UJISq4MrYpMa3sgfxuqRj1BtV09YtpyrVEpDIKQNWhVvCATfVqa3Kn0flTkV8tldG12Q/Bx+GDPGlbsgonoCNOjBKhSW/gmnX3PWu/MwecospxN+0Aq9+1M5XIW4Cu+XCMuPzaME/X55j6mmmD8osBSoEZwdHWEZS1GSwbjs1IHTZRQgBVbTfCmLvW2Xj1QlA76a9Jcnmm8uHVuO0hXiJg5MokoVUDeIiGf/FcXW5BBT9YnjtZ2zdATXzCu0KB+tM9S6ITlZHMFCs5aq0MtdLe8srvNiCBiiGCARwNWQC18JmNAseS25rou6f+d3qsrmV+U7/RR0X9CBHf6C6u0vR5hddeYaPubkihKs1Qec8niKqOrYnEdshNC4Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 93CVl08EgLf0uOzb72Y2M2XWgxSLpO8PakMcip1QnwustNUWRKZHeYVMtjmaOBouklWceDAfcRvrB7L+bo5bHKJj5dArx565cWt9FafjVOBkum/s2L9TmXoJw/fWjyOkYpUk1pr6zE76/X6w21ot/GdR9Lcop/vdVneSk09ZW11+oX/kiLac5ROGjLwMauduRjRy+WrqLOBsHh1YSeAZrpqnvXI5U88Rb3XmYYeCJ3FLKf8YnAHzkdh5D7DCaYt64i+VHGeTbYs17NlzfhMljFvKFFwEaV4Z3MDGZ8c/xwQqu3rkX3kM8nKkG9pgwRwZXy/Nq8OYCqNAL10aNFCuB4xbS9t8VsWYQQa2fpHJMHlZ5AB07GAq58u8r8+pPmW+lL6dbFL83PuBe893+rzGC5eHYTWcOl2xAPNNt80rkiMlkCQFhlAr/BaW4mQdxske
X-Exchange-RoutingPolicyChecked: QPPwOVsHZjbT7nypcNR+kv0JKdu5zrLqu4mB4xRZk76YvdMNvqaS+E3rKMv/dluAniaXaS/Sk7dgr9UWafbEzPylHM8e3rKJE9V+qtcREofy8izITFVHYC2wjmgoey6WI6pqPsVzxTtjpRyLIwE228HMnswlJqIeKuyrUOkkYB6bBWWkjzYTBbFDh77vloXxQMMAvUkn34yYpBTacBbfH0hlZjOIMZrw+Ib7kK+V65AldXwnnzjBFEkhwgHqb0LVBus+Jx1wEOr8jSet9l5qEw+F4jiBCyp5IXx3Yn+KTH59z2No+WcDOTUWAWA441EvGDOzlFgx+uOP26nG+jU3dA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:06:06.8965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d245e0-6602-4f6b-aa9d-08dee31116d5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997814
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX60WEHvBGGRoR
 wNq2YHW2nBf8hNTJUXLf4Lc1MmoWNflHJx2dpFcOnT1CdDw0fVH2UzLyHVULTq+dWtHo6zqjhfn
 FYK2sl5uy7BdwPRTuGRBYfDoYO/tpY0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX7k50L5oSKLTR
 Gk5w6fYH6KLDebzruynk1NCdkJGrhzJ0GsD4IQaAvSdS/88FryKT3r1ue3KGCep+0rWOnKDfQCp
 hoaUwlZbHh/CTKWlYaAPrJzmr5+K1tmKTW2GmPsffbVmg9+irqQ6JEA07leVCVQDqZxvr7bMFsr
 LKIEYUTiNOXKeDQSYFAC5KISBVSXDOTl/M8l8cLQ9MNdM33FLFQWQJmk6rxrc8m/ETeFx1thxbL
 dIfwX2YvmivTNkOMl49OYqInbEyrab0iwuvR3/PJK4d0Cjl0trLpL4L0l4/NL075VfpkJc7/FoM
 glnr7pk6Ns6DqF/FWiFMAVRQApiAJ58OjF+qwr1iI/VAvvS2xZDRQjduXJLZ1KAwnCr5E/JWPye
 9awqE3E4IT2zXJSsgRoT+vnM3G7+gl458lGZSMaRO+ZwyesV5PmgJqHzu62C3QQCAKHql9qNIdO
 scKfRuB1jATbK9BIggQ==
X-Authority-Analysis: v=2.4 cv=Zrjd7d7G c=1 sm=1 tr=0 ts=6a5890f1 cx=c_pps
 a=9H9ADJ10uJ0pYmVeXPB43g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=YO_aYvK3wjRMhJiY6QEA:9
X-Proofpoint-GUID: TPznhR9yLNN1vyWTRf7EHOyFFRkpAPok
X-Proofpoint-ORIG-GUID: TPznhR9yLNN1vyWTRf7EHOyFFRkpAPok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160081
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

Enable DM services for main_pktdma during R5 SPL stage.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/all/20260710102229.2980029-4-c-vankar@ti.com/

Changes from v2 to v3:
-> Added "Tested-by" tags from Anshul Dalal.
-> Removed "bootph-all" tag from "main_pktdma".

 arch/arm/dts/k3-am62a7-r5-sk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
index 4570ff6edbf..6ea640856b4 100644
--- a/arch/arm/dts/k3-am62a7-r5-sk.dts
+++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
@@ -42,3 +42,7 @@
 	status = "okay";
 	bootph-pre-ram;
 };
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+};
-- 
2.34.1

