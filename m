Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF519C44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A3584EF7;
	Thu, 16 Jul 2026 18:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aj6P8Lyf";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b+ph3Yc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7110283E76; Thu, 16 Jul 2026 16:38:09 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1065980517
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-liu@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDM0iv3919357
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 09:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=H3whta5L/KtUH
 kaopy/hnJ1MwDcCu5HCCGZNdAefxnk=; b=aj6P8LyfFarDkYH1qxt3kCbvWMfBC
 QPKq+akDY9/Axw3fSnqPQOXWAQZnkNJTw47JcJvd4DcQHX/7I6vXDtAs1ys31vZ/
 6fD7quTejdjIzVcNr4tfV1d+MoiFwstV+rchjqGiG0mH6Td+kD0YcNQHqjE+OHpZ
 sZGyIazk053NG5xYnR6J2NbvoM3AVKnYrzf2jQ9mOYF+gPNVT1Fw07S26F8MN4Mb
 71OyLAmR/hbs02ZgosGKUAVdc1WTe8Re1Onp39IP4Wh99UK8fctNWSbW3XRGu6Xc
 0HeICWlLiw6tlDX/4xw9Tp0CwuNdeGS9RsZc5tMKbWhkmyLUQ+C4B0KqA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fe9jb8c5b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 09:38:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxVF2D861EG0jwdTbUdt0KF7fSLrl5gUO9urS7n8eiPzsXLtQuy2/NM5YqV30JLfRQ77Ga3JmLI+0ncsuP89nRZpqD93Hq79Rb+k+4d1SaL02rnxyrDBd0MQPsp2h6a65syyp51i64mn/0C4HzIROoSAsGGqirNGHL64XZYtys5le52k/hrpfCRARAC9n9SO8leL/WX3L7kCGe6uCY5Zj9bk/WTpvj6PDIXT7mLcfXT0xEBjHlJJhYu6UD5n8vW4Q1vFZz9Tl8hZikxRfVkDxAaI6t6oL2U48ehki5dX/jg8kNR3mtivKRPSipYcQ/MDo4X4L2+sQqq3NdZm40BFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3whta5L/KtUHkaopy/hnJ1MwDcCu5HCCGZNdAefxnk=;
 b=nrxkb2aZ7OCCeRLqUi+5G0RnmEQ221KS01ln9PKSdIQAp4tJTkAeIVEv8Vu2VUc8NSQvQa4TpMphrblxB5EAZTXP2vFOPsoQ+olNI3DMxqy2M6yWl62IWN8Hqj04IG2yLcNLRFUwg6xSPnTT4zY20rCGLnbY4Qsd5e6PVQTK/cz66P59SSmh4qxr7aXlu7p3vIqhOoTlIQEcjmhW2hxjidpVtwHilMfG83To6La22MhF6sYhXup7XEcGIY1rgk9+SkvXLjLOzsfM8SAwiSso2OOpKCgoitNxM7F1BPHJhE1ACCCwph3fELDVVuePBKRYqDQ+HqTxeAT5+CEpgQT+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3whta5L/KtUHkaopy/hnJ1MwDcCu5HCCGZNdAefxnk=;
 b=b+ph3Yc8oxXu3QIZva+rZ3xKNix8Jy0hiJXyc6EjbkMSdQNSvnVQfFBdZOa3cuP91Y7o4mEDBEiB+8CPclvEVhd79xG0bxhWJeSZZ89WKjqK8m/SQ55Y8R3EbN//ATbxO4UqisVwlu51dmf38Xx28jMC2ec2AbkkZ4A4XQHEMdU=
Received: from IA4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::7)
 by SA2PR10MB4523.namprd10.prod.outlook.com (2603:10b6:806:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 14:38:02 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::83) by IA4P221CA0003.outlook.office365.com
 (2603:10b6:208:559::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 14:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 14:38:01 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 09:37:51 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 09:37:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 09:37:51 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66GEbpQT964033;
 Thu, 16 Jul 2026 09:37:51 -0500
From: Bin Liu <b-liu@ti.com>
To: <u-boot@lists.denx.de>
CC: Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, "Bin
 Liu" <b-liu@ti.com>
Subject: [PATCH] Kconfig: ram: select FDT_64BIT for K3_INLINE_ECC
Date: Thu, 16 Jul 2026 09:37:51 -0500
Message-ID: <20260716143751.1680929-1-b-liu@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA2PR10MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 9972f727-37a9-429f-d215-08dee347d6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: SCwhOU4nbq4vuBOvTJnU4HQUOSOsQpIdxJPY3CmO6IPLPUxI13Ay3egfcUPycIQfdbMFZgUkH2Wa2iUqqULGvytWKDywMSx6AXognBoRStlol8jFO2CKmit0ULeEupDihRdAfHptYEWAsVosegHIFPVg+XLkeVUs9ukvbdH/SHbe3OyyD+pw4DakEfMYZnjkIOKf5srFzqUiYkEaVaEHgOoJP+jJJmQpjMwLhunabxl4LgIyowGhn7YlZrqLJeuRnCmLt4Ip4sX9Xscs4u7YPKQCP1PULY1WUkGZW5C2mdTw6C5dust3gg6Z+L1X8OIpeC/V7AlVYB+YgnfpllLMT4YJQDrtlgjvbyJtGqeA6DEeg9ocPRD9GbUmLEWjz/+DcU6A20CpNcV59zwK6V6PWn1LHksgwk0AQfYYT+UN8dWjX1VkFMd+V9eu2Z04N4wEOLstGlLSIBF9mAUjSfUGFu/tzwX0zfMyO+B4neFX/vZQIipVLSGEn5c0Gn2OPsM65vo0c3hItmxuUY2qMDCijZ1LbOPiSv6V6sqZ1q0yHz1XdvhtOUSYOHMnMmDMrOJvgTG3wG8cLaX4oSFxhdzJlEisuIRu3GM7iyXDdhOnaBSkvnCeuYPihru8N3Y1MdfWRYJeCWXnqI647PoHKdmtF8QdwgIzucF/2CUzP70ItDagpWtgksim76ikR73UqGaaayIdlbJ9omADi6+asrygyg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oPV/oBbnEQf34av1CYYd1fQEDdrWDaSF3nBYp1IR9G1Foxnyrl1pdDO9D8xcLI7huZ9gDk7qEsZy0nLOOxaKUTYWn83mphnTaAgX7Er+rw4tOPDgWEtH/y3tcVgWO6x9/O9Ako38qs3b4+5g41KvV97kp67+Bd/neboGYaYJ3ISRByzwj+N4rthJXAoUnWjUi3lHrSdOJ44lvLHK8WKMxtKgHWzia3q1Nd6zzT/y+OCz+sdtG1kpCER9MiibQtH9T02ncuTnhcas7Ev0C90QwVFe8nDhutGbMZBCQbSCxccOfLcgS2yI6t88aCtrhykqBd563VqKhRfeRnGaTxKsBbXSKToRtCN/Ojs2kjX+dp9F8o2D+eA6QWyCLoTWPr91XBPjPkMGTAhcyXw7Dc98bu4dnn8xrukBpmaOI9Tq2nzQm+jJCy40paSuuqEVoiRA
X-Exchange-RoutingPolicyChecked: jsdpJAlFcOScVHvia2f+LvEzpbfKLprewG6nvv+HV/Uu1pZk+I9YAGg6ephM9lobdtQPrpiCxAJ69u4COhZzGD+WoHAgjtcPe6SDxDPnsCNNng8/jzZmy3N9/pCB3TvBisLT+gy9ZVrSoqRRgCpDXYUlHal8smkyc4uk+txkjWOcOl8MPv32FDDBPn0tmqMTbetkJieFUqx3GECHCn48RnF5nr++vSp30lZeDiYiP4wms6pQHWoXzy24EYUnM7wE/onM63/AtfLGMxOujkfRxylc9y4fqYDJJzJQ9z3oMO3xFzvcjo98IMPnyAlatOIuDqFfcyOjQ9rLUBHQVb00OA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 14:38:01.7984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9972f727-37a9-429f-d215-08dee347d6cd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4523
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfX6sVEGCc/WuKO
 eLctn2x8ShU/DIpvG0EfYjnzVoMOudWIeAkmPycT5qAxK1ofQmCpvw43xF8UZyqsrsyom6QdwR/
 +tfsx1rxbv9Fiat+ZpWOocG/L3cApWLn3VoFfDvc0Bc0Vn0hHue+jW1fzsbd0j/ImvzrUT+JOm2
 MLodwCSBE4Qj3B5f4RnHjaTYq+uEikYhUNDJuAIn3fX8bzVAS4/5z58TZpcN8JxU6onPv0Temh9
 zeAfYQee/caB/NBHZgkQiK9BB7rn25C71PCMutPaV5m4gJBtcwKWZOJYNkGeGwBE/0PCdjcDE2h
 DDJ73NaQforkjswPDr2GKG08SQls0gtE5f6PthrFb4mNW5ubtFYwIcC6tGX/pZnzpxEHOyY5i10
 2V/TRBp+5ngLtC9CZM6txSjtCwl1Nv0HStS1m8aJLYVlr+6igNEsT9z5mlNAxcFRqcD5ftBhnAa
 FM9yHEJdu2Dq8OUBSlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfX2NjDDXWR4awh
 k8YwIDHrXTiayHuBXUCdqAQXxh5JfZEELHLkl/8cGosnqzRRGCbbx82saulkAORFCCWUvx+RUb9
 H32+LIVnCQ/nHnKKRoKMxdy4eJ263hc=
X-Proofpoint-GUID: tB-4RLbAZtavFGaSTg5d3Y1CSF0cIn2a
X-Authority-Analysis: v=2.4 cv=ROqD2Yi+ c=1 sm=1 tr=0 ts=6a58eccc cx=c_pps
 a=zZIwMYV7Wou7+0JapvgM9A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=TVC0h2x7VzoiGxZbXj4A:9
X-Proofpoint-ORIG-GUID: tB-4RLbAZtavFGaSTg5d3Y1CSF0cIn2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160150
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:12 +0200
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

Commit f43f71012254 ("ram: k3-ddrss: Add support for a partial inline
ECC region") uses ofnode_get_addr_size() to read memory address and
size from devicetree using type fdt_addr_t and fdt_size_t.  However
these data types are 32bit if CONFIG_FDT_64BIT is not defined on ARMv7
build.

So enable CONFIG_FDT_64BIT to retrieve correct 64bit memory address and
size from devicetree.

Signed-off-by: Bin Liu <b-liu@ti.com>
---
 drivers/ram/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index cfbfa1252d0e..acd6d9cfd6a9 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -121,6 +121,7 @@ config IMXRT_SDRAM
 config K3_INLINE_ECC
 	bool "Enable TI Inline ECC support"
 	depends on K3_DDRSS
+	select FDT_64BIT
 	help
 	  Enable Inline ECC support on K3 platforms. 1/9th of the SDRAM space
 	  is used for ECC storage and the rest 8/9th is available for system
-- 
2.34.1

