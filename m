Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C26BC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 04:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 364F080B97;
	Wed, 26 Aug 2026 04:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U7BzrNilt90O; Wed, 26 Aug 2026 04:31:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787718689;
	bh=Podb/enlQghmM/N+WysiWtA1Iq5FKhhygv7mn7yonYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQmDhZPR3LENfYxoMny/9ABjewQhbgg2tq+uz/1WbI8XKZWa+z0ah9ZwfiHv5jsBi
	 w9rRtLcCygmhmF0r1lhNAOJQCdO7bDjmQu3FvoWWZXN/EMkewgHSPyIYXRBVO7qH6h
	 SA72sVe9lAsoXG/r/cujt6RC1LUJtCj6lDrJUANKZHqjU0q9o6Bnuvo3yfJdhyuGnU
	 LZZ1VmQu96SWb+WVXxuK1v1W8/MrYrijVhLOHHQobTIYWZviWttFVa/VAfVayGiw0c
	 CEf6S8T+wFjAa1Q7lbiYQ4UfndTPGdnD4rPF25HdBSGpIgUimSwH4rgkIxlyVM7f/Y
	 PqYj0rVDjSTzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BC6680BB0;
	Wed, 26 Aug 2026 04:31:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14E8B334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 074AF60670
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EVlRK6k_Myap for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 02:53:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=lX0wXJjp
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 35044605E9
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHhsEsujqE3ulPUMmuW6ExyiB3eVTLmCowQWgxUOSuF98scwLJHH5uyU+brulBlfsBqvNqDLsAw+Sijw93gnG+uWrIzJV2tGCYWAwiNEPJkGFCBvPAksIOFC8iikwl/BJO5Heo5qDpxp4uGsfzd9sTWUP5JhJE48anUHXjU1MpmvfrJXMax/Y8miE8YBCUrrep2inPOLDcFSIjw6Lq7MCVy9DHN0QAgeSugAsERrGeyEHtmXIcaKbdblzS97niLEnK2AVMaAVmEnkecoimUc90svMCpbkyd1Tx2ES7Y1ltvTBfgagYbMlm/fkxUn9Y0ZeNeBNRaE57UD2KVS52UMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Podb/enlQghmM/N+WysiWtA1Iq5FKhhygv7mn7yonYY=;
 b=XJJ9ZET7DEifgEqY/0OOl97WIQIgeYFoVobscJ9vXSYUeN7jPhNgbwnK4UcBik7RgVk6/MPolILYiU3EogMWN0Mz2EMuuVnW7Q90B/o4e7NNzI430V2D0IrPSK134oh8fB2pFfHrtanQwc0UihzBq9mCBoB1Ze+ooCo04wbS/tYSq/1bO4cTvS29XaQ//xlRvHYjZXO2uIWMzrzQnP/coOjcABgVc7wMoiBLLp7EyMshNdNBwHm2XPlTJh42IBZF8mX0kkofX7axrBO04uMzX2BTQ9na6bbSNueYNTdNOvLyAspCDIrrZL3KjY7Mn9Yw9Vdv2klUVx9RDSoTthURbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Podb/enlQghmM/N+WysiWtA1Iq5FKhhygv7mn7yonYY=;
 b=lX0wXJjp0NmL9tXNDPEyTarHDn8L1oo2ZdcIcm4M1LcIHwLwHBXybn1gw0TKC/lkmQ4J27gdt1oHiok8cIgdZO1t5onCpJ0OQA0LKhFtrnIItwxZMwtf/C1Kkh8v3JHHpSm0/HQMYy0kOMo8pwdyldkTPzhamtiyGvBUoYte4M3VMkdA1vPgiuR7iH5nyJgerdx+ltLpPMwwI6Ee3yaGkldbk5sevWt4ZfFNMgpMkeTSj3+ZOmNA0O3h8wK9pkB0sXMbDqu8pwiuQce+Lokx7qfFzhv6viJB94713t3M8Fd2CuG4Fhya6T/jdVmTCUPOstlnmtGpe3b+pXI2wWnBnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ2PR03MB7167.namprd03.prod.outlook.com (2603:10b6:a03:4f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 02:53:22 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 02:53:22 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 3/4] mmc: sdhci-cadence6: configure PHY control register per
 speed mode
Date: Wed, 26 Aug 2026 10:53:02 +0800
Message-ID: <15e724cc7260e5f280ccced5b453b2978490df79.1787710268.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1787710268.git.tze.yee.ng@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ2PR03MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f2a7de-85bf-460d-95db-08df031d30b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: XsZpNpnIYJ8aaEsz7wJok9QLFdYkV9s62mgVTmcojfOrqOTwIYjZ4C3qvdd96/K+jJpTbMeMO5TBzQoO8R8uhY/eSGJ+7F3inxSK/ulNcaBY5MKtvZLwlusAn97lptlRg8ENhANcMTJ39QgbfAXvUUzeAFAC9L8QeN6VRrDLTdrhQaF3NQCCsGD25BbUgwXVBzoB+kzaUboSK4OZGbdlV1QoE+AkkqwcA9PR2yCcQhSYoo+C0xnaUalih4F3gjMOcH/JMKoVqmwcR/TkmYSOlYJOJt7ocKRAYKjOSlet0nz2LxXevP1Vq5asIxW1UjmlKGv/7nzG5ERra2R3InsnmbrRIPOV7FOrRk3XaEk2QuLRLTLvL8mGYT+GY0shKHQ1aP3PV5eNaRxgOpzVy4ASEZUkijk0NkwVRFy2/3TkRtrB7zbSxNemuCsl1QBDb4zu/2YiKpRjXUkyqGF0saFcvP6eifIvSjGcx3/KGWoQC1ntY/ib9t7kR9jfmBhMOwv/za5wgn5vsB+vR+ReKkMEU/Q39DQxgi4tJHrE5lNbPvkU1zG71PIzarkrbgTfjMl+9/68uWjkxWqmodNMnxGN+kY+ptWNBsLlkqt44rtfaeBu9pNiuXOyZSlxFGEx2muqjnYqIvJR7EtE8ACr19w1r+KTeoiybD2J2pfd4VZ8FKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JezCaE4aFDzkV+1NCrCiilyvaGzOqIL73oC5lcxbnizlhk2yAnuZ7hb7dly?=
 =?us-ascii?Q?6VQvrWggBAQ/G/gsdDYK0gfJ8cWdXvfAbzh52lD9tHQXB7K1o+PwUvqoNuw5?=
 =?us-ascii?Q?4Drv2n6OLT4ihJYnh3N8Y5RjiTLirKspjk3O3XzC4lj1Rh+ShTh4cxnMN2WU?=
 =?us-ascii?Q?wlsr4GjBL5oUAAnYN8SpBC+h6mNAOg4QFLNJ6wnpfCjBJvMnVpYm97Gef2ro?=
 =?us-ascii?Q?2V7D/mRNCdDq3i13ZXjm2kBCIy68zUZIIMEl1hT5/OdDZCDO9cGsQSZ/Jr9E?=
 =?us-ascii?Q?9ZX0E5KyOvbvLJ2gEublJDR2NU1/PfWnaaoYu7h7OpJL0nlfYEGnBaEC5jAA?=
 =?us-ascii?Q?RqoIcinKQqgQ1rQ3puifgXxB2SvuegFqjoJzMx0vPxexxnWNzEL82mv1phbf?=
 =?us-ascii?Q?r+PITLkYuOuwQvBX/X0Wl8g0zd3zlN1uwC1ckF5nVO18keEFvWW8DqHILSmp?=
 =?us-ascii?Q?xW6n9bXAOOnRUUOlL4Rwy1SBt8Q+IW2ofPvFDJ6PoSStP5QUyyCE8GeQSCRy?=
 =?us-ascii?Q?i3+nIMkqpqNzAhok52jVXw4nVW7ZGT37jp9SGyRD/0+EH78rq/UEeaBnIjJv?=
 =?us-ascii?Q?ZuPdAgnYa0PfNrdFGMEL6Lm5Q69AW3FaKo34yF2z2oXLh0fZY1/mezHbLIip?=
 =?us-ascii?Q?b8h+TL1RodIuyIaHLGOxvdVw9HidCIKziJxGAB4xJzM8+7sOY233PJ7Kjfdf?=
 =?us-ascii?Q?cz2ydlRBSOwnGQWQhrZ6luYZAVGVDk6+Unf5/2uc1weec4mi4U30NI1Il/xy?=
 =?us-ascii?Q?Qp8cSSElkwbyOOj2zif0cXeSRMJdwY7nPx+r4RrB2rYa+o6UynWku7f+FjnG?=
 =?us-ascii?Q?M1qZh8gdYiXI/8dZbOxxwOEObJaKh6oEEfEDuWLZB4t1TnASZG1rrzqn9yRx?=
 =?us-ascii?Q?t/P0YSI+trReHJgfs6MyVzmM9bQfPe6sk8tWzrUzVJC9c8i4KHERG4X7ZU9M?=
 =?us-ascii?Q?Xgonrby8m1S6l5Dqdu6tED2fcjE4GfZrVl94J0/GDpU+XbqXFc6Gk7d5eNLP?=
 =?us-ascii?Q?++5qwzH7s5yDhLmfbwspMlcg+g85SJbxdX958cWLTnm8fRj4Qv+mmYR1W2q6?=
 =?us-ascii?Q?5drF4gV1SqzZVtorV0bKTYCMmDRU+LEVOTE6UUceZHvzN9PgrEkPwDa2oFql?=
 =?us-ascii?Q?bId9tmSlFcThln/t3W8O8j97OKHjggvkXPxK1dHQnhxnfN+KzrPwS24/gBIc?=
 =?us-ascii?Q?ISbuYDvdLIpJ3pzWNuT7NioPg2idmyUZov0q/NuUPvXAYkn+K0vscZfV82KZ?=
 =?us-ascii?Q?r+ub3f7TAGte6K1s7wlcxZYyq4uKYMs5y6mFNtzlRDGFjHBNpDdfTjH6TWwT?=
 =?us-ascii?Q?A7BNGD2+wJpFppQSID4E5krVNWcLsQiUhelRfyOcZyWfKUhVjFSk7yeuYeB4?=
 =?us-ascii?Q?pamLvyW9iaKU7fcZGAAKhhaVs0znjxSKO4hqEz9XQdpU5tCHFMn6Tzw+JiN3?=
 =?us-ascii?Q?RXiOKf/F3WcQ8Oq/rJKOljUjDH6BKvnC56Puy9mB7Kw3pXbr2/L2qwm4BkC2?=
 =?us-ascii?Q?9Rq8fWCPINt/CEHXJ+nco2l0v2M4bl5DDAdVL7VVl/XgR1/B+TxQOvkWx32G?=
 =?us-ascii?Q?DZ5nr3E0lFtwzcpZbHG0HozaIPAXus9uErXq7Kv7BxNs/gsukdIT+Amm4ruS?=
 =?us-ascii?Q?7MIvX+EwoazLrzwG6UBBW31zLuhtPo/9W+s5/bTtkzNZ/doX2hBY8EzEHFFN?=
 =?us-ascii?Q?uqNAu6kpzZmAfRdgCSMnU+PDYLmLlsBgz7t/fRmrBorPhDs1hF+kvlR650n1?=
 =?us-ascii?Q?9wNH02s0AQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f2a7de-85bf-460d-95db-08df031d30b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 02:53:21.9477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py6l+nmpgaGOP1jtzEkWJeigfswRFY//f9KpQDxlBLZsvlQOH60A8WED0TyYd0e7kaaQgd2kBWSQ8drlGxkjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7167
X-Mailman-Approved-At: Wed, 26 Aug 2026 04:31:20 +0000
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

From: Tze Yee Ng <tze.yee.ng@altera.com>

The PHY control register (0x2080) holds phony_dqs_timing (bits [9:4]),
which shifts the read-capture strobe relative to the data slices.

Extend the per-mode PHY configuration arrays with a "cdns,phy-ctrl-*"
entry (default 0x41F0) and program register 0x2080 during PHY
adjustment. This lets each speed mode - and each board via device tree -
select an appropriate value.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 7bd47b462a4..412433ea39c 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -59,6 +59,8 @@
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
 
+/* PHY control/status register */
+#define SDHCI_CDNS6_PHY_CTRL_REG	0x2080
 
 struct sdhci_cdns6_phy_cfg {
 	const char *property;
@@ -81,6 +83,7 @@ enum {
 	SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL,
 	SDHCI_CDNS6_PHY_CFG_DQ_TIMING,
 	SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL,
+	SDHCI_CDNS6_PHY_CFG_CTRL,
 	SDHCI_CDNS6_PHY_CFG_NUM,
 };
 
@@ -103,6 +106,7 @@ static const struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-sd-ds", 0x00800004, },
+	{ "cdns,phy-ctrl-sd-ds", 0x000041F0, },
 };
 
 static const struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
@@ -111,6 +115,7 @@ static const struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-sd-hs", 0x00800004, },
+	{ "cdns,phy-ctrl-sd-hs", 0x000041F0, },
 };
 
 static const struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
@@ -119,6 +124,7 @@ static const struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-emmc-sdr", 0x00800004, },
+	{ "cdns,phy-ctrl-emmc-sdr", 0x000041F0, },
 };
 
 static const struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
@@ -127,6 +133,7 @@ static const struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
 	{ "cdns,phy-dll-master-ctrl-emmc-ddr", 0x00800004, },
+	{ "cdns,phy-ctrl-emmc-ddr", 0x000041F0, },
 };
 
 static const struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
@@ -135,6 +142,7 @@ static const struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-emmc-hs200", 0x00000004, },
+	{ "cdns,phy-ctrl-emmc-hs200", 0x000041F0, },
 };
 
 static const struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
@@ -143,6 +151,7 @@ static const struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
 	{ "cdns,phy-dll-master-ctrl-emmc-hs400", 0x00000004, },
+	{ "cdns,phy-ctrl-emmc-hs400", 0x000041F0, },
 };
 
 static const struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
@@ -310,6 +319,9 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
 				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL].val);
+	/* Program PHY CTRL register */
+	sdhci_cdns6_write_phy_reg(plat, SDHCI_CDNS6_PHY_CTRL_REG,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_CTRL].val);
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
-- 
2.43.7

