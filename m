Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B9FC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6406284B45;
	Wed,  1 Jul 2026 09:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SIC+iidN";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H68GJzFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F5E84B51; Wed,  1 Jul 2026 09:51:00 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F50184B20
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6612uJPf2210141;
 Wed, 1 Jul 2026 02:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=jL2nfoAEWXDddul5QsI0wAve/lsP2RjH419nnzCdl
 yM=; b=SIC+iidN842X5pQKRXI1Na9GIPOUo+KdfqEE+aXF/WtGk2RilT6cTpA16
 YiZN+NeISddsAS8Mdy9U+36sfUDUQhmHTw/iy4TiI9Jf0ZuOwAfYzt/c7T/Mxqj1
 E/oBZ8nozGwIOc4CjR5SHdnjHl+xTyQ5aJ6QgnN1lcfkvk4Ow+VxDoJ6A5aGwXWb
 7bxJVkzwIW2PrPGmmxW12V+5EAMC+XRXXpqRS7zkp5yL0Rq0cU/I4tNUWsHk3S0b
 2dp8bfWRjiDSdyZ7yWx8+5AIo9PwezBlbniQVayorhyyHszD9x1NFbAO3+8FXHeP
 QCIJgwpz6f9SIy3zK2H+SJm+CTjJg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f4cqjeb7x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 02:50:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jof3VZjTcYyIclQRSbC+Ruwh/4WGd+iU1bMDm4Mo05t5m3s4kzgZwZ0mfdmX3EMZxP0sfx0cGfLGiAnFmqUS9GzWGpI0kqzGZM5IEYYaAHu6sYROtaHlIU8WGyuNR0U+aGW6JEYQmLJLlvF3gDMsq/qV7Hs/xtFabXl1s1DEL2eiIQE6HMILz/xtU/VB3ICx3HPisV5VDa49NpEh2F68TY7NyXL6ggd0N4ERZl1hlehxqKsi7zoOk8QbcJOCfg75zAqXHzI+62JqJ/AW0Bkn8L58PzSzZZNNerf+CLoTRQrolWDuOC6X8KJvt+XKnKTsxIjiEprb1Urw81e22bHxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL2nfoAEWXDddul5QsI0wAve/lsP2RjH419nnzCdlyM=;
 b=mMYSnHzPvhIXROenrKxjBKhNwnv45AyiS1vAwQUNmogymf4rHvr9JwmGBMJOV9UDK7v2liT9NzhTPPxCFD+nuMFFer7n1xnS3OLIZDwikHXkJiqb4sWU9PWLubXWJ0+uJOsGtXOIcIEn5jufyMYaLZEplp/rDjgbvoPOvPpTyZPtgoaxTVXc8gGQ1Bc1xzRnLq1oOATSdIoedk05VfYU16hAcT/gNjuAsGkbad1LmMh86OLy74FxdH5WCtwptcLoOzp2W0h4Im8zZuDqo2g43nCN21S9KdHRaKzMKnZSJ9oAZ/TcfNykNlK1McdRkbbwuetKD/gaqH3KehJP924vnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL2nfoAEWXDddul5QsI0wAve/lsP2RjH419nnzCdlyM=;
 b=H68GJzFfBWKaTy+GaSJg7EOaT3+CitO9GhK6vOuLKNN/L0DEfmmajP+zGcvyHTCPG+vcBKTIyC2TOJ8L5M4d62Puhx5Qsd0IaU/Y/0urN7lUaDgEAfoaErcSFEFOtOsrDoVove38iQWTYYfFzDU+45RoYv5ujzMl8xpbjfUAq4c=
Received: from DS7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::30) by
 PH3PPF539203119.namprd10.prod.outlook.com (2603:10b6:518:1::79e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:50:52 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::51) by DS7P222CA0002.outlook.office365.com
 (2603:10b6:8:2e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:50:49 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:38 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 02:50:37 -0500
Received: from localhost (ula0502350.dhcp.ti.com [10.24.52.241])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6617oahB304878;
 Wed, 1 Jul 2026 02:50:37 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <msp@baylibre.com>, <v-singh1@ti.com>, <anshuld@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <joao.goncalves@toradex.com>, <bb@ti.com>,
 <n-francis@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 4/4] arm: mach-k3: Add DM reserved memory fixup
Date: Wed, 1 Jul 2026 13:20:21 +0530
Message-ID: <20260701075021.3626094-5-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701075021.3626094-1-p-bhagat@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|PH3PPF539203119:EE_
X-MS-Office365-Filtering-Correlation-Id: 943cf997-3d27-44a5-095e-08ded745781a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Cnt7echJd+aDBolOD3wKirM1YtHtNLUJuZX769I9UJKDJ2Aem53iN8w5zzDWpJ05vxGkhqL2j3R0voP0SyVmPKBCn++SbwjbpljanSKHyvpctexqCwY1ckgIMrJ4dC+AJ7teo5uYFI2tXzuqKnHNxESIviehsbOeAAu/ZUdZQJfDiuazIpbTX7PlBySp/5YX23iToKeZovo2qN/I001h2K07AHC8klGGrv82y1QC5HUseyTFRCi1PRTKDitzp7rGmz6M+YraVg1B5AiDH1ER8ru3gR/61xR6x/1DtmWJ/9C8avzUAc/NzTXIUMPwvBezC6LqKdJjcKzz/x5bY5EYMF3KxT7TDsz/ZiawSW6Jo9T/eaTGC26mDBR5PltpEvqBys/VYVvgfTv2dBYYwBac7AcNjQa5fcUDIYjgKxrmLAqF41kw7LP4ko59tb5grwAShNd60Hf8VK1yI16ZJ3WBaCRlbdwtrdhWiL8+uN5XQ1Jie9OTGc+ni6VCk1pWDQYinBXzO2DB2XTwzZtu6IbN5VZoZ4P148bFblYEX8cXvovGGh6LVAsId7/RXcZqT8v6trgw/Wi70sMrcSGA4ymX+d8OTpqDtv1q/aCyanAesZXd4z/jK/FDf1X1P4spdsh5UAhJ5uXna/QGQ6obdqF0E++m2F0vi+AEJXZgL80/Ps72hr4ZHJDUZEHkOUScidesLHZiuYK7UP33IWX093h6Og==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wqIy6HRdliyMEVXK0f77/Jbn21rgycChHfEuhf6ZjXeziYndh7X7s+/6IAYiB/AvZvhdn/DAqrDPoTLHJlK3PvOzPVa/eHf8qDQENysvadP9KC2SMfFgKmdRtE8ZmS5LVzHe1cd53YjlA4rSOVqGoOuGKjmzKT9VGheQe7Xybu9/daHxcR7WIsIaJCP5aynOtNz996iiKzQIONx05d7+ukXA0i3iS0cFcPsQAcF8YwDdrxpmhEPenzkhPs7LLL8+AdqM2nIt6ipgBSHOyjVpOzRI3imlP+B9wmYiWpd6O2SWGSgzQU83YrBMbt6bbxC+Csiyyt/sT/5t9Mtox1WKbE0sqYiZwVIIUZRZaATyBjlod8pN1pjYdHroMIaPHE5cr/r+K1pnjqXrBedUASeo70QkbwsAlbHczkm7bx+6hEglJGNXwZWWREO/4oinvEch
X-Exchange-RoutingPolicyChecked: g/x4sHkBXZC/tohIM1X4vIPRrZMC9CW9qYi2Gtb+MVE/WEdybJ3MAYV11w98URBhhBbOPqGekZVk0Dl6iRf8yFSvz9dJX2sSfyFoHCHFNoYhFX7txF2aOSct6v3XfSQBK5eXK+FzksrPbvDlvpSPhpV8u8VRuKwIdp1YqEisQcuK2oRGuUZIlNip4GwB8E+sVL2/icmji5fCg/KrQeSizEWnLKUUA3lQICVZ/s6d8EUqQw4cVtt/2BePMqUgyQlQTnl1fLGv8LqADQ07Ap60FqKNmQeaRGUWq/mtJznCxzpMKk6aplJ0QTNhNZrgLCXNxLxHSNiWZxKUrXu0SPoQSw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:50:49.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943cf997-3d27-44a5-095e-08ded745781a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF539203119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfX2oXoP0sVaYt9
 yIDfT/M/fgzDVgjfo8YBfX7FRiC7OWcsgcFTF7tryENuJj1XrHw2U840lcMjEiv4Sd5KivijH+3
 jlkJl5lyYpaqzF/RKcF4fiWRcdGlfkzMRMZLvQlNAJHrTxk1w3gQvLA5BjLBJ2+ttWEYckSq/HS
 wz0ZIcLfFUfYO8MI672MPY4J3XyrByLeL+HpgySuKUExh6fa7rUQNxL+gOEsjsGf3QyUvqFNAEG
 svAM73vWj9+d06UYcZ1upvQsZGHCxiA2o3OBOai/V5g5pGiCX2iQFr/h1dv39ky35Fl+01CBu1W
 tgCHqBhU/ytZVQqV2RxHDszFSSCaUezG4UXoT6QAWc7UQFKq0T/s+3bbjTvk7IS6kHA6L9y3cd4
 AFRE2777p5vOGd5gVFi0pSGLC3fcbIwSqxnZeZ9GY/g8EU4CoOYnlLmXiYTSV8uoNagarqsn87p
 zI6c0cQBynCvZWLl1uQ==
X-Proofpoint-GUID: vUNyVdZBLpwr4vSn8QO26xq7Ls-l9NCX
X-Proofpoint-ORIG-GUID: vUNyVdZBLpwr4vSn8QO26xq7Ls-l9NCX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfXz3GG/fo3jOsw
 EN0ntdvzMpFKlkn9VeVH7TenAcqz1qputFXwA+WOOA7akPHJ+Jo1d+EW+54L8NV/d0IWGIYxKbE
 cUM369BXHPK/68F8771kw2g1cKybA4g=
X-Authority-Analysis: v=2.4 cv=M5N97Sws c=1 sm=1 tr=0 ts=6a44c6df cx=c_pps
 a=zi9RuwRnjJAIHZVcFFhnlA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=b7lhhEDViOGuk7U6onMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010079
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

Add support for fixing up DM firmware reserved memory in the kernel
device tree for K3 SoCs that use separate DM firmware.

The fixup uses the CONFIG_K3_DM_FW_RESERVED_ADDR and
CONFIG_K3_DM_FW_RESERVED_SIZE Kconfig options to update the
reserved-memory node with the correct DM firmware carveout.

Note that the fixup needs DM reserved memory node is to be renamed in
dts. Example memory@9c900000 → dm@9c900000

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/common_fdt.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 4b833f5fabe..18f30e9d052 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -160,9 +160,23 @@ int fdt_fixup_reserved(void *blob)
 	if (ret)
 		return ret;
 
-	return fdt_fixup_reserved_memory(blob, "optee",
-					 CONFIG_K3_OPTEE_LOAD_ADDR,
-					 CONFIG_K3_OPTEE_RESERVED_SIZE);
+	ret = fdt_fixup_reserved_memory(blob, "optee",
+					CONFIG_K3_OPTEE_LOAD_ADDR,
+					CONFIG_K3_OPTEE_RESERVED_SIZE);
+
+	if (ret)
+		return ret;
+
+#if defined(CONFIG_K3_DM_FW_RESERVED_ADDR) && defined(CONFIG_K3_DM_FW_RESERVED_SIZE)
+	ret = fdt_fixup_reserved_memory(blob, "dm",
+					CONFIG_K3_DM_FW_RESERVED_ADDR,
+					CONFIG_K3_DM_FW_RESERVED_SIZE);
+
+	if (ret)
+		return ret;
+#endif
+
+	return 0;
 }
 
 static int fdt_fixup_critical_trips(void *blob, int zoneoffset, int maxc)
-- 
2.34.1

