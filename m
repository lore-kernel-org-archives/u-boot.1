Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C066BC83F17
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 00:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FA183744;
	Sat, 19 Jul 2025 02:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="5p51/EIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C9B83710; Sat, 19 Jul 2025 02:57:47 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A33834B6
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 02:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsJZ5G7svgeJq++/cKDV3MdqbOfRuJ2TJqFoMfoEoTr8clFSEY90JR+KLWtPutHWvFrmVGpuU4+h2A0n2zwp+4+ifxSh0yNw4DWLuoUjslChuCoY5rR2dIWAivc9BrurIivpyYBpdst8M0idsrq01NSxgS/Gx8d4GH21rK2M9/eZEFTPoEJx0Vs3KoKTmvRFCsM4hhCH1Y9jeUwNE0JjaNiIlzU3x8TTe1yMPXjdOGwsXxmJ9arYZ27aPZu6xgFeW4n3gsS+MFNCFuFXQv4Lh+8B+n2YBqLVY0n/+gnM8hY1bOxKBaMkAqiGkrsdKcj/3xUnyv9gEbILc+Xy+nrPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te29der2uZ7ASf3xYOVGlxxMzjlyXIy13B+dyF6kZ+k=;
 b=Fm2qVIdfXmVTgYOAgOnhI4F63C48VTs2h0dUkBs5TG5z5Qft2FThh9p7AYO0ChiU9YXhavzDvJkgdX6sV6n9Y3iIu+6bYWCpg+LGvk1r4o0C3kgUnIY3VFjpAdXO/pEx/mm7xvEUQAt7L5cLaisR7SrEqYQkfEHc4jZCE0BlrRbXTX8ctlt4hgG6ptLxWOFfJoOPM0xTj9FEb4YzXu32iFpwoOobTsh+bpnTE/c+bpfRcrbkmT+39tryg/OjgvdH6OYfrej3BepcVBZAPITiyiYqzn3mbixPxXtvPN5XYpARWEzIbs7urixJk/6AlgkIuC/37QnwQ9wegNTXRh/sgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te29der2uZ7ASf3xYOVGlxxMzjlyXIy13B+dyF6kZ+k=;
 b=5p51/EIBtcWXf5DlbJqN6MoCs22YfYukbmtcnl3JLOP10pct64+JHM7UXXZY++0Ai5RtUXBYPU7qEVM653oYxEk8Gu014UcTURmSDTmw/A2l7YSFdz9avdr21yDkY/RbDXjNmogkeZn0XBeWfyMxQX4cV54wAD/YfxKktb3OQ/cMmF3A67r5wsFv+wO0HS2OxtTFJ+vT5i5rnEzbLzKg+0mq9YruGxlLFSVmeyxwhK/OLXWT/pKpPzgxnkINfJkpTYyFxWheDWB+NbWZsu6uhORKoez/fDs27oHjrkwADw8DfeDXY3tzxWALfdeWnciNzuSYxNUZ1M0c5bDcCUqgVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Sat, 19 Jul
 2025 00:57:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 00:57:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 4/7] drivers/clk/airoha: add support for airoha en7523 SoC
 family
Date: Sat, 19 Jul 2025 03:57:14 +0300
Message-ID: <20250719005717.113842-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a9e724-897d-48d4-4bc6-08ddc65f44a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8nwG0DqzPnTHf8kTlq5/v5WzCkNw8+u7iwmAfARoabCjR36V38WGwVdzw+T5?=
 =?us-ascii?Q?AjljXjrvuOyHNknUYyMZSpiKW7N9l6jNyfeqlheAO7ymPw9dhuvFVyKjpUP4?=
 =?us-ascii?Q?diBzycanqU+u3+kDWXN42kPIxb4AzvdfEsd7wewdFaHSNeYQblNbsS8CDKU4?=
 =?us-ascii?Q?I7pAGm6O0DIV94b71ZnUegqZ/YOqgV7HJz0QY/z73nRBO+NnBdCIHm4Pya9q?=
 =?us-ascii?Q?2J6f8/zbcJqpekdqL3dbXlXWt7WmBRDAaKZ+yP20AjPRTffIhphdMtpvUdvJ?=
 =?us-ascii?Q?kR6uFrzaEh/LOCEFiKQshklWx6Dz4OP5arEpWKml+Lu9ofy3CAKHFctFr8zF?=
 =?us-ascii?Q?FpCYh9VeHSqZbfDSLGYHoGh1sFlfECSTnfy5Varpfi50DSJtBWX3SRFb4YF/?=
 =?us-ascii?Q?T6ROiXA7Pjfp09Fh0ghivShKOG3ipmYMOXvGp0kizIwmo9E+SYrkREAcAsVf?=
 =?us-ascii?Q?Cd5krciYTkYaaOvt3ulLhmyaLh85om6TA19UaXgHQqCX8ApQh7d8Caa4/ux2?=
 =?us-ascii?Q?NNS9HUY1/nb19DPbyG/jFF8rm9tqLtX7oV/g7ElRmK+6hV3ZR9yCqm3WBuzi?=
 =?us-ascii?Q?qvlHt0O5nEKXeaRqKppSjG7kSdULHNYg5tZYjeZRJYLcZTf1xFyAWObcqsXO?=
 =?us-ascii?Q?EXdqnpq2lDa99ZVpsmATWHKcfgju+SoCWUf7oAOkcjosRmhU46nTgEkSieu0?=
 =?us-ascii?Q?KsYuOyEUvmGdN2/kcZHXUHrVWr7akI1oCyvc5JsX89nYfYTaiBj2PXX7w2Sd?=
 =?us-ascii?Q?ruEcVYy8mee1ephCKZYacRpJkYIOQHo9A6Z5P+4ZPYmpI0iasz4rjCFzgwQr?=
 =?us-ascii?Q?roygTYwcHR14hLqM1dLpQSvXKqFYr97zFYx1OFjlzq3rv4NkvCGhDF480e+Z?=
 =?us-ascii?Q?2s0rmTkToR5YIWWXMaN3ZOK8lNg3P//D7We33FL7hI0+uksfTUQJldeqzwNA?=
 =?us-ascii?Q?AOWUMIjca2tPcbIge49tq2e/nOi9xxvwn8kPmwMa0cWr4LrnWpVb51PfxnJa?=
 =?us-ascii?Q?KskNRrzKaOgazh0K6zO7XYf9/ZSiDI4XMI/bQu/M5+Ij6gJq2Bn/O5wXOhDd?=
 =?us-ascii?Q?LR4F/8sfnhz4cmf4tzGkK7oJSVf87UZ/h10Z5DFqEy4QfLJKCs+m9lR8LR/8?=
 =?us-ascii?Q?xoz52T9tKRThTnUb7lOQCmYBalRRpi2WNJjr8fZOGxTQTY07QZ/7kscr02eE?=
 =?us-ascii?Q?6R6rsHJNbFlb3amMbSClommU3C3uzfPIzyNBRZ6NfwRUebk/8530jI1G0w1w?=
 =?us-ascii?Q?r6SGDq6JRYX1BkCQsnWWTeaeGEUZIsR84vGas3vxFtaOsfO38De7GQHcQleM?=
 =?us-ascii?Q?AoGpbX0BKiDjp2XLSjhWvc+N1UHKZuTo464A17RDL4kuOjUfkoVQ1j+/our4?=
 =?us-ascii?Q?/5RdDdz0jEl9xICRWLTeFaVPu5wCvuOECxgqkIaO7K3mbh92ePhy6jD89T9P?=
 =?us-ascii?Q?oXddsNOQXSiUo50oqKKAqF8+xQRz8F9C+8Z4A8YedrLVpYI/Be/HnD9wrrDU?=
 =?us-ascii?Q?yacWobrYTZNxPUo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z6i6zKHWhAms7kGs3lAZu/CmyttgEpSi62r8VN3PNcD4/6ti0xIcNxYW1e2L?=
 =?us-ascii?Q?zc1tYdi7ZyjmBPAiGnWkByDVVqcKkFyRUdiY4yt5aNAyt4G2skDNEQXZS9Sw?=
 =?us-ascii?Q?hhxEIaYcweRAg19Nx55poSOE+J4Dug7d3MUF6jBt4fgUpclE90yAbd3POAtY?=
 =?us-ascii?Q?zOpbIIa3bW7MCz4u/rp6qFz6sYWr3MBjY1YSVXuQhjU5KKUjGATDSCfJu0Rc?=
 =?us-ascii?Q?Vl+094g410kVoHE2lYD/l34ZkBRGaPiZH0qbJ58nvYgvlix2lfBboQmzqal6?=
 =?us-ascii?Q?KNr6QYefEB2Dqf0GFjwbwE4UqbOz2Otx27Uaz5kjgByW9s5fx6sGFl+WXGqm?=
 =?us-ascii?Q?T2moEJb6tAaRCm/LVzHGXN4518kT3osSWnceCZ5qvC/t/qDqCSNfS8Ep5hTO?=
 =?us-ascii?Q?ORos+niUKbosEzahrI7XtGc35vEfOVLHlfHXo1qFUiRsE22i2+MvUPU1xNZM?=
 =?us-ascii?Q?1OLv5nmPKyTsv4ASi7cP6ItMe43tDXi/wDNuvQzTnejDuKdDsxkIbKJupkc4?=
 =?us-ascii?Q?8AuQEYJsGVJjcBckQrmDzaFwicnCmWKTZ/AlELi4U6dxkG/1+/ok5j7SyeEm?=
 =?us-ascii?Q?oxHTzNKLhFCKDTmwsI1qxQ0QqTHDWj46rfJmic/dDfg+NpmnWaIh7+nqstre?=
 =?us-ascii?Q?nIscJlTCUrwLm+BGMUoqIYdWPqRT8muwGG9oXwKa821bfYIrWiDttRZp7kGf?=
 =?us-ascii?Q?f2OByUJKUKHEZlSWcJGyR+yLzJRbd6JXzMiK9KJmj9ctVPVLunXeImbEiQzD?=
 =?us-ascii?Q?DTubw/HxuwcfXn0ZL2Lgdd33Sdb74Ogz09WGFwuYjnTqYUXbJlY1Sk1crxxM?=
 =?us-ascii?Q?mqEtm6iGsGf+I3d37ob5Lz56BdqNu4X1y7P+koXV0mi6P24twxjMoWzMyjxD?=
 =?us-ascii?Q?qEZTHnMhtWxoOSRGBJ1i0Kk10nYd6x6B4hVHNetgIl8JAxl2CiLu0PthWqLC?=
 =?us-ascii?Q?PXM7A5mD1LsQiS0WIn/nbZYJyPthdkUOE3G5SAZjTG8OZIUnQUOPp1ck8n9i?=
 =?us-ascii?Q?iDvXAsgnzfH7K7oAg8K1ZPltzNIoE0d+avy5bJKaD3fi72IeXx+bJewZCN+L?=
 =?us-ascii?Q?5ndK4Mki5NSWvYArAw51P3iUqJrF4YhXhsi3B07d/GTPcCTAJStdNu78ZkB0?=
 =?us-ascii?Q?wpPDWVD8r+aVIApv9ymNMsBosi3XIpc9YlqazZ0BkHsZ2f95HrYl+TF5Na/V?=
 =?us-ascii?Q?Iu0p1C9b6o5RVagqjss53jEUJh/tYBXX6DmuvCtmQGBqez55Q8U19qRIUHWj?=
 =?us-ascii?Q?S4JEh/yo0PzdGGgghCWEH7oj+kfMhnVDxCc1VEtPggfvQO29GevByri/rcRd?=
 =?us-ascii?Q?GU+C5ZDFxibJpiR7zfyhfnM2DrOdsJ4d2CWrfnyYAt8g0xJj4lUoGxXi3mUZ?=
 =?us-ascii?Q?tW/PcbrJfFG1J4zSM37zib/6vrme5xAplAsSVK5w4keGCOAcn7lZquQcBxle?=
 =?us-ascii?Q?3+HUbezGPuCmc1fvVaSzKucY+ShPeNwkzBxkLLmEkrlRYg5D+joC51eYXxpG?=
 =?us-ascii?Q?nyjoaGnVevhRcmn//9uB2rTnGYawVeOUj3CIg1SMO+49zC00oO0bVw17ZEAY?=
 =?us-ascii?Q?lFnFIscI9y/HvNlE9fyTZuIkauWPUaGSHgpABlwKIfwQMmomcDHMY46sP7MJ?=
 =?us-ascii?Q?EwM5l8AMbLOGZx8QLB9Irbw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a9e724-897d-48d4-4bc6-08ddc65f44a9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:57:43.4905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GfmxbkIDDNBeLN6sAkeiEXNZCqQNhdC5PVV5aoY5GFv9yRerbj/QyHiGnmV+9puldVhLt9ES7VPErIOvsqPpr4rIzUiVxUkJefij9lanHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
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

This adds clock driver for airoha en7523/en7529/en7562 SoCs. The code
is based on corresponding linux driver.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/clk/airoha/clk-airoha.c | 126 +++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 1b2c4c98de5..308eb978a1f 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -26,6 +26,7 @@
 #define REG_SPI_CLK_DIV_SEL		0x1c4
 #define REG_SPI_CLK_FREQ_SEL		0x1c8
 #define REG_NPU_CLK_DIV_SEL		0x1fc
+#define REG_CRYPTO_CLKSRC		0x200
 
 #define REG_NP_SCU_PCIC			0x88
 #define REG_NP_SCU_SSTR			0x9c
@@ -33,6 +34,7 @@
 #define REG_PCIE_XSI1_SEL_MASK		GENMASK(12, 11)
 #define REG_CRYPTO_CLKSRC2		0x20c
 
+#define EN7523_MAX_CLKS			8
 #define EN7581_MAX_CLKS			9
 
 struct airoha_clk_desc {
@@ -63,17 +65,123 @@ struct airoha_clk_priv {
 struct airoha_clk_soc_data {
 	u32 num_clocks;
 	const struct airoha_clk_desc *descs;
+	const char *ofnode_name;
 };
 
 static const u32 gsw_base[] = { 400000000, 500000000 };
+static const u32 emi_base[] = { 333000000, 400000000 };
+static const u32 bus_base[] = { 500000000, 540000000 };
 static const u32 slic_base[] = { 100000000, 3125000 };
-
+static const u32 npu_base[] = { 333000000, 400000000, 500000000 };
+/* EN7581 */
 static const u32 emi7581_base[] = { 540000000, 480000000, 400000000, 300000000 };
 static const u32 bus7581_base[] = { 600000000, 540000000 };
 static const u32 npu7581_base[] = { 800000000, 750000000, 720000000, 600000000 };
 static const u32 crypto_base[] = { 540000000, 480000000 };
 static const u32 emmc7581_base[] = { 200000000, 150000000 };
 
+static const struct airoha_clk_desc en7523_base_clks[EN7523_MAX_CLKS] = {
+	[EN7523_CLK_GSW] = {
+		.id = EN7523_CLK_GSW,
+		.name = "gsw",
+
+		.base_reg = REG_GSW_CLK_DIV_SEL,
+		.base_bits = 1,
+		.base_shift = 8,
+		.base_values = gsw_base,
+		.n_base_values = ARRAY_SIZE(gsw_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_EMI] = {
+		.id = EN7523_CLK_EMI,
+		.name = "emi",
+
+		.base_reg = REG_EMI_CLK_DIV_SEL,
+		.base_bits = 1,
+		.base_shift = 8,
+		.base_values = emi_base,
+		.n_base_values = ARRAY_SIZE(emi_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_BUS] = {
+		.id = EN7523_CLK_BUS,
+		.name = "bus",
+
+		.base_reg = REG_BUS_CLK_DIV_SEL,
+		.base_bits = 1,
+		.base_shift = 8,
+		.base_values = bus_base,
+		.n_base_values = ARRAY_SIZE(bus_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_SLIC] = {
+		.id = EN7523_CLK_SLIC,
+		.name = "slic",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = slic_base,
+		.n_base_values = ARRAY_SIZE(slic_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 24,
+		.div_val0 = 20,
+		.div_step = 2,
+	},
+	[EN7523_CLK_SPI] = {
+		.id = EN7523_CLK_SPI,
+		.name = "spi",
+
+		.base_reg = REG_SPI_CLK_DIV_SEL,
+
+		.base_value = 400000000,
+
+		.div_bits = 5,
+		.div_shift = 8,
+		.div_val0 = 40,
+		.div_step = 2,
+	},
+	[EN7523_CLK_NPU] = {
+		.id = EN7523_CLK_NPU,
+		.name = "npu",
+
+		.base_reg = REG_NPU_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = npu_base,
+		.n_base_values = ARRAY_SIZE(npu_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_CRYPTO] = {
+		.id = EN7523_CLK_CRYPTO,
+		.name = "crypto",
+
+		.base_reg = REG_CRYPTO_CLKSRC,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = emi_base,
+		.n_base_values = ARRAY_SIZE(emi_base),
+	}
+};
+
 static const struct airoha_clk_desc en7581_base_clks[EN7581_MAX_CLKS] = {
 	[EN7523_CLK_GSW] = {
 		.id = EN7523_CLK_GSW,
@@ -402,8 +510,10 @@ static int airoha_clk_probe(struct udevice *dev)
 	struct airoha_clk_priv *priv = dev_get_priv(dev);
 	ofnode chip_scu_node;
 
+	priv->data = (struct airoha_clk_soc_data *)dev_get_driver_data(dev);
+
 	chip_scu_node = ofnode_by_compatible(ofnode_null(),
-					     "airoha,en7581-chip-scu");
+					     priv->data->ofnode_name);
 	if (!ofnode_valid(chip_scu_node))
 		return -EINVAL;
 
@@ -411,8 +521,6 @@ static int airoha_clk_probe(struct udevice *dev)
 	if (IS_ERR(priv->chip_scu_map))
 		return PTR_ERR(priv->chip_scu_map);
 
-	priv->data = (void *)dev_get_driver_data(dev);
-
 	return 0;
 }
 
@@ -431,12 +539,22 @@ static int airoha_clk_bind(struct udevice *dev)
 	return ret;
 }
 
+static const struct airoha_clk_soc_data en7523_data = {
+	.num_clocks = ARRAY_SIZE(en7523_base_clks),
+	.descs = en7523_base_clks,
+	.ofnode_name = "airoha,en7523-chip-scu",
+};
+
 static const struct airoha_clk_soc_data en7581_data = {
 	.num_clocks = ARRAY_SIZE(en7581_base_clks),
 	.descs = en7581_base_clks,
+	.ofnode_name = "airoha,en7581-chip-scu",
 };
 
 static const struct udevice_id airoha_clk_ids[] = {
+	{ .compatible = "airoha,en7523-scu",
+	  .data = (ulong)&en7523_data,
+	},
 	{ .compatible = "airoha,en7581-scu",
 	  .data = (ulong)&en7581_data,
 	},
-- 
2.47.2

