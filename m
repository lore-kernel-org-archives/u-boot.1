Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFA5C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9C084D80;
	Thu, 16 Jul 2026 10:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JW+Ib3kw";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dFOEyh2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 047B784D93; Thu, 16 Jul 2026 10:06:21 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA6B84D77
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66G7Fp3d1639528;
 Thu, 16 Jul 2026 03:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Zv5e1pFs3RES2vZ22pkCccYOaHmNXVCQ0dhQszh2X
 jg=; b=JW+Ib3kwRrrcABx/FclkKSsbt6CeKfOqoI3tbZC3hREqa2dYI344hU7UH
 Q3FXioFnF6QWnyR1q5a4wiph4nzKdhD4M7XAgnHx7cOgcbt8R/JoyxgLSF8vLLbg
 dPeE25NWYrC2edhDaXzarULIhscP37FBcMrHj8xVvncnBATuvXRLsi95A4kQTwZt
 fx6HqfBvFQ+YH24nvhkoU/JnF9pZ1FwJdhpwYbMDvvzMYTYvs2uU1n1H5APP/A5V
 Lm7EW2LrN3wgvLYnydIMgQKBZ7z57UxNkL54T+0vHsaUmYQAYvxbr79XjourJTrV
 j4HzbCnVkzsfnyBoS1cljWl7jZHag==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fep5s9n9f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 03:06:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBiQvlCTddVumqu1PGvilwS9AJ3dQ0FQIEyMdHEVshp74wVQhFjr615miJZ5fINWVtUy1KrVuACt5M+H5HPVWzfcwgr3Tau4bpLzHt18YOMdrl3L7LGc37L9CBrXy6HtZNaQV8E+OkwKOPB65kbUcos784jumOfEEiqRgLcXJ9TZbJeDaqaiES08QNauY+zuX1mm0fdoqLKMn0ToVJ98OwusYcnO6rDWnjBtymIniFt8L4Wi8+WXdv9/owsAQsgYvACXbGvdb/SGH6cSBGSqw1fiqdyhK2PM61SilGfZ0eSe3D/w8+3CfphIm8Fa0KGhoqyMAgGYOFSAFBES6FzO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zv5e1pFs3RES2vZ22pkCccYOaHmNXVCQ0dhQszh2Xjg=;
 b=eyHKlBxMVxE+JyLvtKY8iws4ZYdCtle4c+5aLnzECcUFm+UrskPixeXFyMN3VJqmljUQK4Qpcgy3cgLf+tZ9x3abbJz4DRA4JGRjKQ7CJESFEziVlVtf7BIro4gJgclke1VLg2hyOMEgdtmhyvUFYlnZ6krA6rlyvXJozXWcExU0I1sVekujYS7x9boxj7NHTaAzkQRwOG+/R11bbBvqTR21qmPjBG1Tx331WCPE1P2wevbtlAjxzlZkqxngEgr0tSu4VrHrlvJv91o6DEqQW27KJWVBu/1Xzv1YlvwPCRKvvS9YXR8grkrzPwXnNNXVMT/iOLJOibu8iJJ9ZP2FZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv5e1pFs3RES2vZ22pkCccYOaHmNXVCQ0dhQszh2Xjg=;
 b=dFOEyh2ok5qlByUulLgKkyqlMDy+NVXl97e/aWrC95vjHvMUeFMFOaV2VFCtYgJ3zqBqA5YP2rX7kkwyJqANkSDxdG9pOjb9alHGF0m4ta+T0iLkQBovM5f/bcMpsuyH4MC+713UKkjoFsID6HHTeLtvvfLJctJu5E4w7fQ8INU=
Received: from BN1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:408:e2::32)
 by PH0PR10MB5707.namprd10.prod.outlook.com (2603:10b6:510:149::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 08:06:12 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::60) by BN1PR13CA0027.outlook.office365.com
 (2603:10b6:408:e2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Thu, 16
 Jul 2026 08:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 08:06:11 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:05:59 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:05:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 03:05:59 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G85w61867819;
 Thu, 16 Jul 2026 03:05:59 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Bryan
 Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v3 2/4] configs: am62ax_evm_a53_ethboot: Enable config options
 required to enable Ethernet boot
Date: Thu, 16 Jul 2026 13:35:51 +0530
Message-ID: <20260716080553.2664147-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716080553.2664147-1-c-vankar@ti.com>
References: <20260716080553.2664147-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH0PR10MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4b5420-6311-47e3-31a9-08dee311195a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|13003099007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N8GCC9nBO71rklr+EHdJajWqqWu5bEyXO7t2paMw8p7KYtlYGsTBbfod6JxbPM4haghmQmzi+ZiBNfJUeTkAMnN65HA/UKH8y52mGV0kwhxw7gLQOxy/nwFUo7TzL7ITGpPj3HpsJicd7xQ3H+RvyO14HycryhuLnW0ZLsGg1wunCPMlWA5kCq1qPfvXAcyJLoaiuhCD/YyZZ2hiCORzL9hswJuzitfPP+kxbfjeOyys6VWyYaOZGfbgEIb2WeyGDkQ5BFYD5/9UK3H1JcnwooLadbgrMJYwfveUq3GZ3Z6LNcmxCvfSChaU0EFz+HaCPyB6nfJZSXM1ZvpwdyMH+Z4s+VsFKwb/3Ucte4lHpeGyHDfqciMruh0oKKy5jFve4eq5Eyu1sRHP15dP1JtwOtLr7EBOxEtxqxS3/+d+nf/Dn3tWTcv9vSlcm8WWcAXJLpE30OPiULUofd15MIGcfoIwRjSaiV2zKn6mCheAiB7YQZEBrrp2FOTdjGk2OzGtudwyRuSEbHujvXzOcOW2v6cpylMDuomv7KmXk+SvMP2+DW4aEzkru0jMtmCJES0ZlZhN7BkpFBZbOyA/ctCiDvyXG63eCJdYKbNq1IirSU0w7DwVfhRed/NAVzKAy0W87QwwCSKkdgmQ+ir7EifeZTpOjWiVW9ljvZ3+e+cn+jOwYAtjAUBWQDKu6MNxhZ13beHcSO38C49zWUQdQ0Zpzw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(13003099007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0DVy5dbC4/ziQCSQTfJFFikAtB+mv2/qOApgjvu6pizbqkISU6ITCQb2EMnU5EU4YMcctMjzpJwnPAKUJQ6sa63pxhpnFQI6+scz5JdPzCLLKDFF1Q4uhwbp/3kOcLOR/sYyZvCAzFAbCFSpZcByhW7zwcVPbb4U5Gs8dcyeCEpfL+OBHSFKJ1bTVX2H9f/FXmqBwMTTm5ASrXybf4xtUz8XjF2v2qGt3c2tlDGiJpB8KWjaB3L6sGjJjr+bJR8bsxBKzTc2ri4nXLB35zPaEvEW2yMtrwgAPBISsln8OY3pjH7XlUkTBCOdVtDHVuBRZFVA/Zus3hwyQELyq5IfMTi6ZM7tKWXz3GUtLuLiN+AoY2Zw+/JSr4lCej9NPskuUh2Q2u5lpxuo3E/TTFC6v6fv+VKS8p1v1F50gLQDEB0WIatav6zYJPLuJUdZW6pH
X-Exchange-RoutingPolicyChecked: OGpNiEt3485VSlS05yjou0sTKrAl8z8CAx0riZBLuFmGg/kELhFNi4iu4bY1bDCRyo8+ANYjJm80MYM/fvRj9ZM15GWzDdcrr/U04EA8ULjqWKXc6qbfbfeS3dMrNM6cYeGjbM9e6w+YdAbXlh/sv6bYzMSCrK0CTi31VUTvSNJliEf13DPVHLPen1kldc8ItOwYOg4Z+o8GU9awAP1N2T/7nohJ6j4wm9vrF5IgFz5SVHz9F/MWzviQiLvLvxYjEyftgrALLAZTF0E+QJFraSbnXMprdf2qW5B0zDCadyoDrGgk7RRdpo86ZUlYOaLlGg/IILIZ9WkAkdUIiAqYZA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:06:11.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4b5420-6311-47e3-31a9-08dee311195a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5707
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX2xID8kQFW3K3
 +cTq7oQkKOIH2FeAqync2S9TeZbH5kZP/wlGGuJqOHVaQR4TfFalmAeXcA0x4i1RuYTJjbHP2Bq
 zwfm+Xgy++WitEEKeLGVJTuaQw8YBGw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfXwCyE+rziKIky
 0B7mNMfluLpMz4D0J5t2OLVOJJY7xPoOb527GllDokgCWRwzjf+3hEodGyKkPI3u6mB+xjdbsqN
 Z5WD+1qMbJ3NDZ/+6xXhXcrXw8M6PmA0DzTBvN/Pg0vdvEGHBQhW46J0JHgTjjdqB6pMLbMySfE
 Se0r1iP+8JODgtHH+8cfZ/vetbqKBo2IZg5rbwbK49W2HSXsDMF+WMfno/XhrkFTw7Ck6eL5uyO
 hdUIUhOJAnF/bY0LAnvGrIfS6oxHjNWXUTm7xZvE/WoQah19nbm1/IEVigWmdICsGtogNbHgGp+
 VgDvW7cPwVZtiOroHhoVmp53cHfVe/JXQEtR3tE4+4z3+l6UFBxqiqhj6J9H8+Ym61JHsgaycp1
 SlWn/cB/M+h5PPirGXcVq68q5rBGazaUaF5oC4BlNSzZdpr2wpGOWnfkdMjEoT30FWZQsWSjCzH
 5Jig49mq6TTw4oM80EQ==
X-Authority-Analysis: v=2.4 cv=Zrjd7d7G c=1 sm=1 tr=0 ts=6a5890f7 cx=c_pps
 a=BRu7lVsKyHj15bVqb/Fc8Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=w0yU2sA7OMI97cdDRH4A:9
X-Proofpoint-GUID: dtS-MtDpakvJwKYZdYbU-KoafJvKScKB
X-Proofpoint-ORIG-GUID: dtS-MtDpakvJwKYZdYbU-KoafJvKScKB
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

Enable config options required to enable Ethernet boot on SK-AM62A-LP for
A53 SPL stage.

Acked-by: Andrew Davis <afd@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/all/20260710102229.2980029-3-c-vankar@ti.com/

Changes from v2 to v3:
-> Added "Reviewed-by" and "Tested-by" tags from Anshul Dalal.

 configs/am62ax_evm_a53_ethboot_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig

diff --git a/configs/am62ax_evm_a53_ethboot_defconfig b/configs/am62ax_evm_a53_ethboot_defconfig
new file mode 100644
index 00000000000..a3ac67feb85
--- /dev/null
+++ b/configs/am62ax_evm_a53_ethboot_defconfig
@@ -0,0 +1,10 @@
+#include <configs/am62ax_evm_a53_defconfig>
+
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot A53 SPL"
+CONFIG_SPL_SYSCON=y
-- 
2.34.1

