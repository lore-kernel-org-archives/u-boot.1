Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A294C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D990A84A29;
	Fri, 10 Jul 2026 12:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hM+powMX";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PdMPoCoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80618496E; Fri, 10 Jul 2026 12:22:47 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A07584A0A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66A83sb32275364;
 Fri, 10 Jul 2026 05:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=HNJGz2x1p3K2HYCqMD/G4qBnrScvqkU1/E2hMY0tQ
 XM=; b=hM+powMXoQGh/Yh5S9CI5MJdqXf4gwy+qtk5TIZ/udpuIV5Qdy9MFDI78
 o2LUBg4gU1CgaVKeT75DlPu+JMxcp7HtnYS+K/DQgx18ifrgLYTHH0P+aZg5Q8uy
 w69/xRwXLjX0p65Uv8v+eLplRqPQyi/6rgSQPmEviPDpa/+AP+fSPTjae3ge+kRs
 YSe1/Qf4qflToAgoHcJsGIHopaJUWJEiE+4s4Sedxvv5xTcR4gpGAb+czZsPgQZ/
 ESFeJcqpgU7afTjI1m1JjzjMKVAM7q7TFvKZpt2D7XCwQMU+DyM1p/nOzKbMg00V
 cWcOCsKVXBcJ+PAcIL2zYGVgWRpJg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fadx0ns8m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 05:22:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI1CK1iWY/RIwywxE9FUP3FCzYTbamlBOvceldAPURVU+SVTVvZHazxGt2HcuKPq+yWx/PEqz67AaXzUGhfZgnD1osi7XgCrhuAqgVqOaInAP5h3OWf778k/3O9B9Y6+9/IMrgoTaq6/pmCgdX5QjYLU9mZL6M2sLsaHVUV9IzvmLP/aeL/VbXBOMid9TqNpXxqXS9vaOJROgcNPE9JgBr9nZAg8iVBbgKBx6znO6fevyp7jJ1P1RqL2121Nvn3ldnRR8AAKyYVfYppjejMYvRlpWvdGc9ziAlcELuiWviLyEUOLEYSNuEq7nRLYjUOTyYzi3vviP6Bz1Rlfp7uISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNJGz2x1p3K2HYCqMD/G4qBnrScvqkU1/E2hMY0tQXM=;
 b=WtKSwn8nOwaHG1zg+IXwoJ3xWAiKMw9/3e0L5iL1fzNvDLamxPP5jUU8M0Fsa0j8HGy9sghlnKooKcxV9cT4WSBT/25iaqduJXa8cjRHfpakMr5vNJA0oYpONRUwnvszzP6IppwFs0VNfoQOhG5zIZdG7ap8lOAWJzV0q47wWATf1HPoon19ILPWNyfCh2p4efgxjl5X4eYXU9MiQv8+Qt/lmk+CjIL/3lxhdM8/3SrF+cwzZU6rWQkmIGMNkl/aBemcWHksFln4fFHVWtjtyx04HJQypFANdAk/MSnC/xeuRkldwtHOeoaJc8+bQxXGsYOStC/8mJ0DfoIEi8rr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNJGz2x1p3K2HYCqMD/G4qBnrScvqkU1/E2hMY0tQXM=;
 b=PdMPoCoK+yndqBDbSEqKjyqarDiEJe/CY6WbHb0DWCD1lvaL0ip+xdEXX4cChFN1VFVtDn6sGfFimav+LYHcH+N33hga7n+kYHIYjOiPbc5DxKoTVpsM6AAQU27FDSZpajyZGRwj8gRoxnk4JWyKbj2viOmu31hCbWEFoWp4OFc=
Received: from BN9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::27)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 10:22:37 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::20) by BN9P223CA0022.outlook.office365.com
 (2603:10b6:408:10b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 10:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 10:22:36 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 05:22:36 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 05:22:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 10 Jul 2026 05:22:35 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66AAMY0d2871460;
 Fri, 10 Jul 2026 05:22:35 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 2/3] configs: am62ax_evm_a53_ethboot: Enable config options
 required to enable Ethernet boot
Date: Fri, 10 Jul 2026 15:52:28 +0530
Message-ID: <20260710102229.2980029-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710102229.2980029-1-c-vankar@ti.com>
References: <20260710102229.2980029-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8c61ea-62c2-4355-6a9c-08dede6d29d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|13003099007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: OAiC1EI997gLNU9kHBdfF17xusakHVWgUrW6bSxK8SFZGjh6q8399mkZ/omDB8b19amQxbZ98mB0wTcopkFz2u8BbcVmLnkzOhm+CfE9SffvKB66wmC+HDijXLYC47nMFvJGqu3dSZQruROpjYnkNfmNKx5yo5+W//9W3biBEvHKaQsiXE609fhOb4JcnXfVgXUj+Hdd/9Av+jue5ZsDDgya1FlKzi4oSdaWEvfmLtDYqsAS2dmRpVq/Grvbxl+u9JgpLVnBXgwQRmqa3j0xlWQCCo6KRvh/rb4jAC393QVJrmxcDjIwGKXbd3c+TrCYELjHzBJnMLTO6Z5MjhsjBt2GEmb/fFSeLBxA5zfUeHqRdM2qiHAF59zX0CsllLoNTLcQB3+jqYpUH85XlcxngZ1iDvF0e4SZ6eQ8ZNI0yQbwBueAhAPtoMtzg3MovM3qY6/9Asn5ywrDwheJc2Tpab/a9qJdQIVYsAJHHTptmYgFH+B9EwrFShEwXQ7yatVI7aEiarpjQJ/Jxwm60yF13pp6XykFb+5YgQ/fAjlSy7U6pQPvKRAFCHLZoI+ErNnE4a/yMtIdO7xLKEZJkG4hLm+C3Ek8Hdu1SvwyivCNW3+tajRKws4Km0PMvNcgm8ydJMRkpgKpWtzmxHswY/joyJ5DvmUjpHtNieyGjAqoUKoP0jAqI+gGcHgKNkKPFubkyvjU1oadB2lsgZkPz5EU/g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MPJdiVrV+an0xSr15xmOHjdoVSL+ahhRT5XHKQ4wbLMglBhSyh5pjuUvpj9C1ypZkxkm/3p7/RZnDTM8/RHGuT7ANS05Ea4QCTH3oDPqhsvUIKj52T4Mc6F7rG/WP3c1VVi4fS4rspgYttr8MmBZwi89J50RyBfC6yZWwxpdU+u47xr2OlvwbaT+Z+owzG792JuXnJAI0OTeJ3RmY4XznsnkuAD77NPbCHDUd/ZsCjxGoCRL2It8STS76lbw1sti+Btkaln5ylDb2JY3GLz76stfDd8N4/0FwMJkDYQcfDNmT5HSXUjikNnb5QLiBjXEfmf9RgHdYapXfpjsmBwb18fvrPoJrPZ+8MQtCmP9sMmBaROSZlqsAJO1o+Ogt1BX55MDdQcM24zoKT2cTcnLuoD145P7KQEx7K5io6qRIfQWmkua59rJeNtxSAiWon7p
X-Exchange-RoutingPolicyChecked: AhzNW/DKbwmyOeCtMjdWwi6zLfvnriAZ8sN++JrOqrMwkmAm4ERP8UJP24g1wv1llFLOG0RqDw1ov303KghAL/Ns+F94ePgEo1NelG5Z8TDgpCQKpLdM9fyyFW7kAxAePo/1NjViOqN+RL3q/IX+3K9GS1aMIShOCKyvOWFVYXJAdl7unWm0EIvmzLodEbqaijdmxYgz9p64IJDo7k9zyf6wUuYEuDNOJ8z4NSUP/14Ft2NowhhLXdS/zCUcL5UNfB/LbP1i1LmeUMyUcUym8ycgExV5j47XKxnnhO4+tjeDtZbWQLtsrecm1TZNPb8j1xjrsJoY6vP9O1LPoyT/YQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:22:36.6406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8c61ea-62c2-4355-6a9c-08dede6d29d1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-GUID: CPAa9hPwU8WTs7FFcpYlQCjsb0rfDJPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwMSBTYWx0ZWRfX2jdwbbHx24yl
 T5ra5OVYF1W6r8k1LzT2HTrhEMr5wvP3Mk9xndZp9R874t4hh7lXR59YLbItVG00B22CDoxvdrY
 jglfb8xLOOopG8g14iTyIMnByt+yvRccZdj7d7m2XNUyeB/d3hl5xdJ6EzROKmbHyJLcVgkFuRY
 iiAavLbcALSZZzpcscrHcSaAR1mzQp/DA0txmYSgHVVnRqUszHv4LsLitQB+ArwFc4Bu4RpnF7R
 6pmbm0KFosKwaHKov41b+tSnl7qsXbusTe0nJjw+btBGhJCBOWK4Cn3QG2hvu7yxW4Y3jidzyPw
 gypHs7i+QeblKZt5t84Wu/vBLnJawQdt8ahclce/Mk1aKRXF5tTDz3DI4c8vQc454jC1swoBrA8
 1j9PSwN3KwNtOieKAhdenKub2jDf1U4/h+xUOMkt+E3pHssOd9sNxGU0HHAgb6N92KgjL01lVY2
 sENmunZHjmuIh9qT/gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwMSBTYWx0ZWRfX8toA/2zmQmxG
 Kd7VHq/Camm1hb2WUCUQ8TubiwA8ZyzcxSqa9zHIC8BhwtvLqZS94E76EsoYAGnD4LMDtO+XWyv
 7hFnnbDq75Bb9+g0MFhuXr7iNySD2C4=
X-Proofpoint-ORIG-GUID: CPAa9hPwU8WTs7FFcpYlQCjsb0rfDJPO
X-Authority-Analysis: v=2.4 cv=A+pc+aWG c=1 sm=1 tr=0 ts=6a50c7f1 cx=c_pps
 a=Nwoz+Mp4en+GxkTyGjE1QQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=F4D9Bdh0olWHN1wwOtAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100101
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
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/all/20260702081251.2691159-3-c-vankar@ti.com/

Changes from v1 to v2:
-> Removed the duplicate config options.

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

