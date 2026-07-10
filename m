Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1404DC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90AEA84A0A;
	Fri, 10 Jul 2026 12:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eiCUH6jw";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="isBRTRA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6862F84A30; Fri, 10 Jul 2026 12:22:47 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE9B8496E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A83tgR3354977; Fri, 10 Jul 2026 05:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xxpgr5Bq434SD6xQux3ZAbtNBjJVR2atI6yx/iyBV
 0E=; b=eiCUH6jw08qCgHKlibAcbpc7/MZ3cxrn77aomTEc7eUq4IS6sldVkSATP
 PcZUd+uRdFztL1IgXmYOtmkb2vMYL6X/UcyTpU67JCYhBPdmYzYdkcvMoPo2Wg0T
 p5YGKRsI/dovfTdxcyPdWkMnVgDPyEg4ZTMylbwz5rLMCmbtfVru3w+sIxAx8JbB
 O7iQDZKNxhTrN+sw/zZ3ESOMQVcJ9KGF0DML3oK94JS5D2W5+7pVcr9WjTsiWgnZ
 SRZQz5qU3RvqEQ85pe1lue7L7AALN8uLf+4CeAW667CJiyYdNuKcbx6OFexFax29
 K/+wtc+Z7/3dv7x1EGGPDv67pYcQQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4faskvhn0y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 05:22:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYP4Nj6wl/4MMQLGjoTWL3y3nFhukGJuRzKW0wE/l8dKrP0+ioItYPN9USzlPXjCZf9+2/YIRvEgVPpTdieUrIFnyFPjnXbnyjEbk8Mgl/O7MAY66egxgrlyy/UZdkCKSafxDdIj7DE8ywFOBmkbHATYmilKKSd+d9IO/FgDJwzCHQxaddHo0oE7IgR0Mpw7ePRQ/zKv59CpOoLS+4a3naVRmQ3GacJ4jMriUxplUtZdECwEDfcbXGBZI/sHI9KVLkeMUSrmgl9+LXqJC0OTFfYDOnK6itooFHoyz6OqO0IusHVwC74a44xkCWbZ7m8W4ra21F7MtO1QN0BMXAbFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxpgr5Bq434SD6xQux3ZAbtNBjJVR2atI6yx/iyBV0E=;
 b=xbdO/0t2GOvMIfxkbejqUKOWzm4i9i4HJa1FGzpfn5kB2LGv4D3aKxsWS3y/ep/AGNPv6ZFegpI3pMw1hEPzDmSFOcrD7m8Hy0/WTn2eh0EGSllymjJ3yR3yVLpg9EdR9mmDFvWgVfbiDT58aDRYm3h3wHmJClAFtQ5A7ZZPogox+1z+ZCl0Naph/pS9aJxI5nDZCxA8vFFK82CY8pHbxako6WtVMAvlOuA8VMjpB8tz8nI02m8ylXss/1GYDKSrIx2TsXCoXjBIckqlXh+V+Pkov+OgmEs3icGFrzo+bVn1bgSZC4jZ/TDexv7uelL4hs9QbyDZ0Vm0y6EiLldnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxpgr5Bq434SD6xQux3ZAbtNBjJVR2atI6yx/iyBV0E=;
 b=isBRTRA092eVMOX6HL/FqL1yCJZyAerQDD1Imozzz7A9XQOAhPMDGdO51uL0SRghf48tMk9EIAYwRMSIRjrzuQk/uEVxNroq7cU5Ib5YJRfmqHvrjV0Wp4dPUU87XlWql6xJ0EWjoDRbbiB/UrNPA20l6bTKzfSqcoYXs5SgsEU=
Received: from SJ0PR05CA0201.namprd05.prod.outlook.com (2603:10b6:a03:330::26)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 10:22:37 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::4) by SJ0PR05CA0201.outlook.office365.com
 (2603:10b6:a03:330::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Fri, 10
 Jul 2026 10:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 10:22:35 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 05:22:34 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 05:22:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 10 Jul 2026 05:22:34 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66AAMWMt2871412;
 Fri, 10 Jul 2026 05:22:33 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 1/3] configs: am62ax_evm_r5_ethboot: Enable config options
 required for Ethernet boot
Date: Fri, 10 Jul 2026 15:52:27 +0530
Message-ID: <20260710102229.2980029-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710102229.2980029-1-c-vankar@ti.com>
References: <20260710102229.2980029-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|BY5PR10MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5f32ae-5424-4042-4406-08dede6d2942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: GLtF2GrvYmNEBHRy9xXWZbR+AchsIPaICtkvzv+ct5ME76HJNU4TKWiyCYbNSmn3n3G3puYjK0JCby8v3CNbu5rG8vTnKOQrtPmr2hkEDrH8D+yl6dzlTVhEgRqP/cjc7LnDIX7Ktf1DB3+b+TmaXqg5/GI2rljKO6Wne/h0zjqMAcQoC2y2hbLWd/IclQK3iA2dNG7NI8eQTzmrTCgVTUKBV3M+NFqfizmDkAe2xPEFS+zZbpJdrzboXXSBw1x/jkjKQjxybOw9ZY6WTng7y2tuCTXYOIqRhdInmfGn3KEYZTb1FrU9ldGm9qB3xTE9umDT6/xGBfvYajbkpXwhzZYazE6cYFQ+QM1CDNP8QF4fAipftTM1F3zH+Bxi7Z1pJaUOInvRjAp6XBqKsWou0amA4oPGWthMzFoIU4P/DOczS6DNAVHed1fFZjh2+qu93n8jteormMc4lxPuzX7C0yAFzdX9RXJdDfjK4Zw9zYms0hMhqk6Ar+1PSi1i+wyBmvQ+6vwYm6cX5hGje7uY7jTxi36Ttg/PtFMUBV2zLttz7mCFstqcnL+c9b6/nzOCDwshyC6rcEMupYoZqHjlszRzEnSoiivtcaFo/+pDsW28ci0hEV4T2bsz2wO7FdKlBdBX4fJGOZWdtinoAWUttIjY2xiQefHWf7tT+hg1b/vbHEZx0wIyEnz/C77JFdVjVIYHl62DSjcN/h1SRYMuZg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l7XPbqhzeI/qlLxFbv/Uwc5BrNtkd+Zp+ZPQzi0e1a7EUIJrh+WrczMk5dBfYl7FTMxIvb1HnO0ubLgX0pWJv1hqEo7UZnnNxyr/toxQliA3qsfZVidN6AleZBx3W5k60lv/9aSGO92YSorlsg9nUcYv8ph1Caz8j9aIsIzHNOL7viSoxIV4iJzdbPQnehb2YWQAvotsOHIVpGxyswBRSP6C+9HetNNaPVAwT/Pr/SUuPfnITjVOrpqglz5lyybP4Yg6WnyhUaybnNvoMVOK3n3Wpay36Kx9HnfoaWQHdwV3dRQN5fadgZ+6vbXtP99d20NDam7HvyTYx7++i0sllioqVsc1D7WWZkz3CIblGZYE32GUBF0m+hhRct2ajZbfanolQTakH8slx9YKUxsQToUnGrpTN+CpV00AHJ8dCTfxWoocsLqrPrniHthlW0Yw
X-Exchange-RoutingPolicyChecked: Vr3PUWHnpaI9isFjbRFevqoLR+tbeShHICvjwW0xGAFuSHYumfcAPwXG8BkJNW0xNIg35FYG0gdiskuZP/dbRjRaIjdBiwEd6KlnrZsWzjbvm0M/g8YRQyt3AZYiEXklmKpdbBz4aMY6DmaHC3yVMjwaHw4IcYa+TjYhfurnraBuGf0f8lUyHB6bKHgwCZI3Gc9sGHR4P7FGVyjtdhi8961ZOl9kTgK2PwbNX2sExnIfDanwj+XHcs7ZrLbfRwTLsO9X7BePhBnKYNydl3GrCcAQKCEoAfHGe7XPzq1YM4ZO7M+HN3PFojivQ9c73rWebwx/+H5f72k1bYo8Jod/aQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:22:35.6816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5f32ae-5424-4042-4406-08dede6d2942
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-ORIG-GUID: YPI8_y15YVIpssYJk7s4yz8tKCHACLTL
X-Authority-Analysis: v=2.4 cv=AeOB2XXG c=1 sm=1 tr=0 ts=6a50c7f0 cx=c_pps
 a=/dw4gKU6pt/qT5+OabM4uA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=6gXgvFinXvgF73ZXjisA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwMSBTYWx0ZWRfX1F7dwvxDlD+2
 h9a9hYG4oTCt3PdvzSik8mdnCt3+4kCcCtRtzkwCiQqpNXYFySrUQUBCkeJGjfKCsizmfDBwZEH
 yxJNyTp9YemELlk3HgRpUHi4tXtOn6A=
X-Proofpoint-GUID: YPI8_y15YVIpssYJk7s4yz8tKCHACLTL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwMSBTYWx0ZWRfXxoF4AQ14Mn1H
 xa3rPm9keWXCrOe7rq5KFsnm0bhbWcygEdgtjphm6pg4e4XcjNdB1ZAZ4iD3mXSF8iIkkv66rO3
 xi6duDWj5FVwbAITF+I1igb4z8QUeflL6xkFdF60mUgDbIq+yAeKCfB4Qkb061apunUosTkPTCT
 kS1Oy82oAsBRNgHcjZ9FH3pPtrC2cZpXLcGWFAlIhu5Nad89bmo3ZGPG/6puqn8Q2A0VOW7MViv
 ykjhvkARaXTvg3XZRt7XgJZe3nPXxMXNKUC2rsk2wDzzV2YXjX5/UV/zWPIfMx31X44kMGJXiSl
 L0sZ3S4o9yeu2iVX/qrEuw1QIvEzYIg9Im4DJpbBBb/IpoxMYrfDl9DdtuohOQ0PuNZn8VPWQuT
 Vsjxdnp9az8Mfq7h8dypommbgvVA4oKYzRI/ebYyiJ/5xWG+E+ncpWRKezUwuXsXOwpGNhCFH6K
 gAtLG6UGvsbInw2G9HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100101
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

The R5 SPL SRAM size is limited and cannot accommodate both MMC boot and
Ethernet boot config options simultaneously. Add a dedicated defconfig
that enables the Ethernet boot on SK-AM62A-LP for R5 SPL stage.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/all/20260702081251.2691159-2-c-vankar@ti.com/

Changes from v1 to v2:
-> Removed the duplicate config options.
-> Updated commit message for [PATCH 1/3].

 configs/am62ax_evm_r5_ethboot_defconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig

diff --git a/configs/am62ax_evm_r5_ethboot_defconfig b/configs/am62ax_evm_r5_ethboot_defconfig
new file mode 100644
index 00000000000..2986feef29a
--- /dev/null
+++ b/configs/am62ax_evm_r5_ethboot_defconfig
@@ -0,0 +1,22 @@
+#include <configs/am62ax_evm_r5_defconfig>
+
+# CONFIG_NO_NET is not set
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_MMC=n
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_NET=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot R5 SPL"
+CONFIG_CMD_DHCP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_DM_I2C=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.34.1

