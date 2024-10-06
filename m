Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFBBCFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 09:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177A9885B3;
	Sun,  6 Oct 2024 11:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="guT8eOwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779BD88D08; Sun,  6 Oct 2024 11:53:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6C7885B3
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K66i7yn8o0hBSQ9+cV8QjTwio58jENNf0RPvR+K5Vs+NBssOrHNpfhqMGJMWuAMMaxhtQC2WQXfUlwr1P+1vqUfwGnvumw1+12gdyF8CoOXTzj73q24ez01/lwKhkvL+EpR6ByrvA3hFNj3ZOvlicd1d5ervrWJItzO1GUgqf0Y6uBj8YXh55m3vONhlhDl7F6M6q9lnzOwDa5e+XB5v6ZJmO5KM/2fFidfp33COrMABQQ5+C9uV5qa8tZNX5L9gz8Cq2Sa0JFcExZ2BxncAW8WFjD/HGFlA3ZnyZfJB8eUtHVmbiL1G2ueRLncEGzmjkNxbiFC9NpKOl8ZXy/46Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDGZPyOSkmrnxGg1yru/hRd0Q375oq2PZD8urHm37QE=;
 b=vys2WnUmeVzz7nZkpeZ1Ex3XuEfl4fxQmw3YCx/zVmrIAUVeH6QSFDKYPTdyj3r2KU2AJcnyobxLX08bGuadhoP1ssDIgfzS+wSZu3s/CZuUCdL2ailQk11wJs5172+oOzvHZfhDq6I/qnFKZInXOOCEHm/2bs87cQoIb9nXRQjVlTgHH1TuslH7HfB6dQSftM770ruWb/g5ZMBb8MdJLWgdiKtKwzczv473Epy0PhRODeBnD3o5as8wAKJZSFebJGMZhCdpeCcww+m2xCCos5IMdL0jREWCs9iiQ+g1atAei9XFWDR+wr/TiAydmlkPpj/lYDW+JAmGpfJmpqFHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDGZPyOSkmrnxGg1yru/hRd0Q375oq2PZD8urHm37QE=;
 b=guT8eOwVxLQzK3YJuW0yEjWaqqJu/T614PC0iTSnHjjuMgEVp9lTBOCJyTvPXhHONy8wLmJY8V5czdbtnBEoA+n/rILBNqhoO4gOTtvd9JwPKDClNchcUXiJAOrlvkDUmjhz4YuWGyinqjxIU5phhNkuLWWP6rgMCFHlUVM9PQ3ljLDk3KChprpbz+AU4FjGdQQI3y6g4nBD4St20BV/FvEimk85wv1XGjqbO/+OnLmZMdDuZYMzQF5woBiykj1Q458tkRnWhOQkbEZyzNLu8W23nsNJMKZa0kd5wfaW9Ri3f3qUTjgfdcyPMNGxSsR6klU0SEJ6wVMaZpB0H3SMrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 09:53:23 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:53:23 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, judge.packham@gmail.com,
 alice.guo@nxp.com, xypron.glpk@gmx.de, ye.li@nxp.com, peng.fan@nxp.com,
 festevam@gmail.com, marex@denx.de
Subject: [PATCH v1] arm: global_data: add scmi pointer
Date: Sun,  6 Oct 2024 17:52:28 +0800
Message-Id: <20241006095228.2800776-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9eeb2b-dd68-4179-270c-08dce5ecb736
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NqtnfVg0tbxbAWcpTrH2Hvfa/OAuYj9TXsg31qwZ0oWHRSPNQwPe9ZIbIH72?=
 =?us-ascii?Q?nYNTq37dvuIaD0d6ahS8tFXv1mAI3vlR7cIFVwHg4u5CJU2lwd92RQLgnlfU?=
 =?us-ascii?Q?vcJvTinrn/suobLRaLAnjCOrRS6TkWQv7y3FfiPLGB7jUlKj6fujXMDxkiwe?=
 =?us-ascii?Q?SVbdIkmLE0hqpuX+DsFhdZHQ//XK+ISarbEumgIV+X/XTrcygXZexQco/n1k?=
 =?us-ascii?Q?OD8Fd4aus5J+Ngr1aon8J9TcN9briNaiiW3Zzy+B8QR0AZGxpb/DUv197fnM?=
 =?us-ascii?Q?p2sHXMraQ+I0zDhjF6pHlixBCUGm/ceohi/yAKpn6J5HC8zRwjEYkO9z7cuc?=
 =?us-ascii?Q?HRoH1csToDnzR16UjyxzedY6I8ls2bdgo8Ctsb+GdjRtGorGB/J21uPaOLjs?=
 =?us-ascii?Q?lxRzDhXDpxgf35ZpeJfuraRbXKqPFJjnqxNqD8av5Bh7AiRGkQgL0HqhangO?=
 =?us-ascii?Q?RstDi3sfCJrZU1KLkfpry6kOYn2XM4mQSAcTyx+y83dS9sbJVA21u+oRkbi1?=
 =?us-ascii?Q?9YMGRnCWX5SNaox/oK85uS67W6MtXbmSy/4mnAWOYLb+CYB1TaVQhMwITOFc?=
 =?us-ascii?Q?vYgFGe90l5VLv9dD6dHVcJt8Y7jKhmDytRhu5+PHImk2yPof6TWVoygqftoo?=
 =?us-ascii?Q?3L4jgJ6pOELvN4EY5YaxzkStAAVSJEPZPp3wWJMwTovWZIZe+zPJEUPgMf/M?=
 =?us-ascii?Q?6Dks5Fmf/J+ijQg6+3Hp4AfRR5Ac/6sVDcaw9uf7mm67US9LFiYpX33RaCzW?=
 =?us-ascii?Q?+uEVXO95DcXFlLqR2toFF2ZrbeW407/dkL+uQCp7KqFgQxPEhK77Fvccd8Ik?=
 =?us-ascii?Q?kVBNq+GCmodzdFTNUAOVSe97HmGm8Ubj1jM1ZfGv1ZwdPNRRcDZ2ot71y3qG?=
 =?us-ascii?Q?6S2Q8L/U6DwAG5v38EgjLRewI8bCXOQWjUaIfJdzF/kBP60Bg4ZKdD7AFdRK?=
 =?us-ascii?Q?FQLwSXeuTNUssaXT9ZDa98s2doG6cGpQxfPv4SatboMiVrgUEyMlOWDAJitr?=
 =?us-ascii?Q?PHzRzvxMFX762TCF1kFRI6A3qBrgAYNXPNNF0+b65sT0EWyLD206fyAQNeoe?=
 =?us-ascii?Q?dLZrpuAjijMvXyMBZGvS4N6y9Y2f5Nx2r+mHuk6WEx6Zk080YiqnkDPfXv6a?=
 =?us-ascii?Q?0shVtYLkUr7J5fVSiQD27CDyWP0Whm23dy7Wb00lDSU9mQ4lf8O3pAhzv5/V?=
 =?us-ascii?Q?3qdk0H2FDPFOiR/sdxzpYRmYimRDo3R9f3nzKbiiFMn16N2enmuI67TQ80eG?=
 =?us-ascii?Q?6MsS3NKP8SV1aJZT5xh+qv98gUVGLxrLEBNJbvNaI3KBw+Gyk8y1wit2j1d8?=
 =?us-ascii?Q?OlUvB6t1N9F6/j0S9vcXzeRvdcxgAk8ch/7ohPLwwVqJqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsQFymkOu7J/lzVIHrB5XpAsPAicHdML1hYORmphO1J5bGeOPchrO8B5NWcu?=
 =?us-ascii?Q?Cm+p7Z1MbkTKT3kHizAPl/KGxJbP4oUOvF/DVE3AhNb+GgaFl+8E39CK/eB/?=
 =?us-ascii?Q?GPo23sORCdILZXDX2PfkLwESWhKadBvEsgXD+3xb/rlfaGuC6zXLRwySN2uV?=
 =?us-ascii?Q?3/E6bJm25wY0SeiMPD/9cjxcmANMPoshovY2h8/Bi202S+5qHEOtlWI+zqU3?=
 =?us-ascii?Q?4qkVY7S9SdIvabKcs1suDGwo12cL9opT/d9X18+rg0xD6/r6XxlwRpoCp3MH?=
 =?us-ascii?Q?IvyDdTBc6c1nYkvQ3dmZpW1W0eb0irX6IS3qpjwAAGINYbl499HMh9CxCjsS?=
 =?us-ascii?Q?TU2M07yEkYZBMVF38f+vPWkHjSDrvWl8f35bYN/GPwRy34kqVKeYqAgri7S6?=
 =?us-ascii?Q?Ctd0tyv77fY1bcVz60hk+tfn0fgTkPIpJXtTr/y0UQsRO5BOMsYkpE+VT53b?=
 =?us-ascii?Q?7OGjMFDspdmMvFG29gaZjLedea1iNR8rF7bQ7RXvQZBV3WsvubvlXgWo09xY?=
 =?us-ascii?Q?FhJqShJsJsHdW8CwiIyV9KcEFmspKfC/KzIxVk6OcHXiDQ9cLVmYVEHW3c9F?=
 =?us-ascii?Q?aSTk/R7RqarfCi85AHmwJ+ePGIY6Fm9jtTShwuOaQUpnAqxYyMgeunLk+kQ8?=
 =?us-ascii?Q?EKmEfPfNjgA4EsQud+fzYziR+FlZk3QkCGg5WnIYIHoyr/GCBgXT4QECWClQ?=
 =?us-ascii?Q?FxfPqo0HSfQNKGQvqsoys2AlcQFaVXy/PhOgcaC7A4nmmkv7Agwqz2evPehC?=
 =?us-ascii?Q?Wlc+IX7EOu4izH/uWIsUGObG1Aq8jgbM1COlDRiF+JtKVwTJ9WR96pr5zwEy?=
 =?us-ascii?Q?pYSXqV2hTaVVNZri/cze4mO6ac3Xj0gpV40Fec9GaFtOD/Ru7QdlygkXL1ov?=
 =?us-ascii?Q?yjPpfooYO4UTAfzSQ6qqg8Crm0eP0z9AKFS7kY7OkSHHTporw0N0Sg/j5Cez?=
 =?us-ascii?Q?oBFZD4G8VFHeoj2vqcvb8ts0YnofP5FsyQ42dhbI7Kamf51Akf1ErpyOGu+M?=
 =?us-ascii?Q?gGC4z1SBW2ITEELYby48Ya4ELw5KqAsMneqTgajW+UA0HImAI7YSEK+ZX/Cq?=
 =?us-ascii?Q?bXOM07pDDJoG0ZxmKZd64wTShS7WbqYOQfjhmsCOi2Cs5Ow/nzMB0xQdcT7u?=
 =?us-ascii?Q?mM9+6BIUIbDXmxjniL/uZez+oFn6ocPZGuMOocVU6idGMVzV9GMH+vfdlWJq?=
 =?us-ascii?Q?VDTSpuRBv0VYZy3AXGoEXDd+TRj9LRVbWVVIEtru/VTgCEw0xO0njWq8o1Rg?=
 =?us-ascii?Q?8gjJZsm7WMm00HieDZRvNsgjDbPq5GZ4/qrgCFHs0z0+41ug+G+BubzJgyD6?=
 =?us-ascii?Q?q7hXOVF4mlrf5u34s6y4xkQZCmgyhz8FTmYwJ1Ad+7smajkQYMufDs3BRiJ0?=
 =?us-ascii?Q?h+sDgQ4wKQe/T7vqsevwCu63D00EKLIJoTpsyxaT49lW/wwWyTbHfMTLyXPA?=
 =?us-ascii?Q?TkOqCwTVZGVqQRCuO9dT13StaVcqNjBy9/6ElNCjMFT9/f00CjNJ1DEWLEHW?=
 =?us-ascii?Q?qgNOqLfPUMIi2evlv8JEIVv3hGfaxysbERmAnNCoAEy4BhEZVb1848DKkBQM?=
 =?us-ascii?Q?RgGLGE3jSSo3SY5P4ptMs04p8NzHrM/ZKHml/m7w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9eeb2b-dd68-4179-270c-08dce5ecb736
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:53:23.1776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uvdq4nUEv9NolD7xTS60nmPXceHwKIA8mZMIPGtmrRTr/4nUikSN0yOMZjPAoePpeF27segMjysyvFi9pEvGlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769
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

From: Peng Fan <peng.fan@nxp.com>

Add scmi device and channel pointer for i.MX9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/global_data.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 45401d5e3c..d04359f167 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -108,6 +108,9 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+#if defined(CONFIG_SCMI_FIRMWARE) && defined(CONFIG_IMX9)
+	struct udevice *scmi_dev;
+#endif
 };
 
 #include <asm-generic/global_data.h>
-- 
2.34.1

