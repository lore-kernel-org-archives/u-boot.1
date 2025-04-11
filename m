Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A61C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ADBD83EDC;
	Fri, 11 Apr 2025 10:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hQuBwuRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BFCB83F62; Fri, 11 Apr 2025 10:10:38 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5DC83F5D
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJqBZS6pzOL9E53uu/xpa5i+2h0GgJIqhCKj1nZLiLxhIh8oY+VPpztWMD1C+XkQFGn708Bl2g4RYUr1GShbUkwdVhjwI2QB1Tc9sCleBENe/MrOydQ8ayRHGb8iIyBj5hsWAd3nFhhp38tN4uWR24C5JaAbcZeSSd1wONCPvoMFgyq2rJCenjbvYh7iDkIxyncv+rI7F5FR0ySQEKT6avKDItyiS3x1IU5VBZkvnMPtJNBQVsoD8b8WdWr/09HexCHBG3sZ8+GTMSig7RQBPWzw9OR6AVl37BIFi9wqiwnTkBhmgmFgOaI8yJa8nTKhyoH8tl5HSNR6U2ISWhXz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdwBNC8co8SuMLD5YC6mE09SuYQiU3qZXz1mQLptYHw=;
 b=iTcehMIT+q4qi0cWmbqDM/NU9XbBgK1n4K2dk3F4UKcVTzFQnMt+6+por8Fdndu6Ce+1XuBdqGo//d+TkKHDu86hBscqLrkehq7YzOTjew045GusB+j5bZz/fmaiAQJIsA192ZWBaTuoT1ioyx3Tv6lyBG2rmnvJq6yu4YJKTlTrUljzFEXrPlT2IAShlrkg6T8hsYHeJ+ahRESfCCNsU8ThaArC7Q5TZWDgSs7gZkmfpUhDTuj20vScZ2erJEap6bZ0+sd7B1NcCvsw4gh/QALVSFZ7RxMT3OVFydRxA4XluDWzCwZCQFUYcojExgZxvGkCvlFmAsSUQIrxX2QvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdwBNC8co8SuMLD5YC6mE09SuYQiU3qZXz1mQLptYHw=;
 b=hQuBwuREFbS7j6TQyIgvVVsGKxqV8ODB0W+kgURMNLXNzNqkwPFcVgkexmeAFwXdUfxYQGthINZLGKsBNonicafhaePCz9+RTXt/Kn60KgQ8bLW1CB79VElkH3GksKs1DcN4y0pfbV8twr8mdvP3jiXWDdHM1/icGkhy9S9MwqVk1sA/Hmki40YiwGOjoDhSsWAMWpojWo7tg/GXVqSoXsQhl2nSoWiIA5QYh06+PlunIxVcJ2+yqwUPkQN+DZ0Aod2zPISXfm4Tq9FPmny5jUNuUTKk+z/rKwrleMBlcLSjOLF7Is1bJ0zo4EJOIiiGHwI00S54MaZ/HEYSM77t7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:10:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:10:32 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 07/20] clk: scmi: check the clock state/parent/rate control
 permissions
Date: Fri, 11 Apr 2025 16:06:50 +0800
Message-ID: <20250411080707.602371-8-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 6638b7e6-f005-469a-80cb-08dd78d05468
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3/bIhikdtOY+ILQnn+GsH+1jfELvxqSNKG6ks0cfflR2MTxcPlWknTpHdXVh?=
 =?us-ascii?Q?cytFqBCd45QtD/hh+cSZ7VRuXGYTZHnneSsIwsdbRWu9hmNwTTE0P7F0tJlJ?=
 =?us-ascii?Q?n7ZUMOlk3bd+KA9VQw8I5YdHyAWZYZvTAggP35hHoB7AGkq5Cdyiwt+HY8jW?=
 =?us-ascii?Q?7a2FZ5N+vLrCp85fT3FmdGEa1hRn8Ta7xpAjjClK5p8zyO32ZgdmdUmGzdZv?=
 =?us-ascii?Q?5C01IXl0afMjvS17sQhJJizRaTEMjQ3T7q7+6gdmnzJ+lR+fFP8C+XRYbzAC?=
 =?us-ascii?Q?exslFPZgwvCH7Ysnig4eJs4L3we/rYzyKWbruLihrF3VVVzR6k4YEbwMSi2e?=
 =?us-ascii?Q?g+ef3R9OZR++BZp+gOu2EgTwKlQnQUFG/oknewY6VhuGe7KiJkAg9/gVFm6a?=
 =?us-ascii?Q?Xaud/wax7t7q9IQqJAUJbNTWBbtcH2o0tndvk1sJpNIrwK0mUmxeJkiFiDjP?=
 =?us-ascii?Q?1XsFjsBYCDWDmzHQjhxqkfPF8TT6TIc2+M51hXHvR4P2P9lUL1Ygtal0wvDD?=
 =?us-ascii?Q?f9nxJRKYY93jLPQGWtMWB6WwwiSOvyISTfJHltgb18EmjSwzZQl8uaA0DZ2n?=
 =?us-ascii?Q?kARQKO8DWxc3h/bShpcVHLG1gDYnwfJlVyBUv5HojzfrmZjx2/K0ufBE0BHh?=
 =?us-ascii?Q?LEf8Fffv76TBZPLX5GqHWjkKHZeeVjviW9as7+BSKq62nIYTPNQBddF7z8Pu?=
 =?us-ascii?Q?+BYuFvV8re1PsLCgqhykLCvZ9K/FuQeNOP++PSOn7EY1QCLTtPH60wzL65Zv?=
 =?us-ascii?Q?JOUg0/UgxiYCXDDmu+yH2Wodl/3MubUTFeh0LqtJTecjAo6bzIPOReq0iMyv?=
 =?us-ascii?Q?rsU0F/jy/59RAsrDR0G9tdwbOTO7WEXB+EbziRU9XmrHOlhUh1lorIi17t1b?=
 =?us-ascii?Q?jUlsuHcN04zwl6UoYg8wAurBwkoyHMqCF/htI3Cz3SgyRAP4+Tj+zuOZhI11?=
 =?us-ascii?Q?Sya9TVUlslelvbF1BDqEzolVaC1b4+Gc1OtJ9CB/lkoOM3lxDJgxb2nz8hdz?=
 =?us-ascii?Q?/9ktxRPpZK0Bnr7xeCfZIcqt7Frei07+xOaFPwpw23COfNw/3+IeP/ZYLQIm?=
 =?us-ascii?Q?hMdu8e9VIpLpv0+XjRemRA+xhuoWx5vp5+Iv2Hpv4OcGqB1D1zxQqdJhkwrX?=
 =?us-ascii?Q?0wlGKAy3pZEBZgFazqq0B1iOMQM6iqdAYfYrs4Z9FnHtaRQ+EAmlowfM8QsE?=
 =?us-ascii?Q?8elidZQSB5D/eL90DtaEuszRYj1E5rQgmh0whm1udv4EznnQTXmAXm5MwqXX?=
 =?us-ascii?Q?1xpbBu8y5QDQHFCXdMzgbX1R/yfizxwXmsXEfCmyc/x2kaVxS+am45eIzvxm?=
 =?us-ascii?Q?0F7GYWR/NfmcadCX44DlLvQNszc2/NvTi4E3WkiiPEA3wKZ/glcjQkUizwsl?=
 =?us-ascii?Q?S2LdFJ1A3cHsnu28//oPWO/0U0uGCGuoazmaxRnZxoCNoSxVpkfuACXa/Y9Q?=
 =?us-ascii?Q?tcdSnjKnN7/0Eu3p3uFaob+UXgdPj0nSSE8MSRWvB1KWe4Je+x+how=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvMsKr9ykXF0h3uNlNkNz+eiR8MImNXPzBIEFZMxTnugVeh/nK7AJqX062g3?=
 =?us-ascii?Q?nm3N5rOlRZM2vEzpQ+T7yokvRJFGw6OZ33u6gyAUt7FBZ1i+dndfjv3wIZd+?=
 =?us-ascii?Q?gWDOqaWnuGdqQodiBX3/NGsndbfV7dpTXcoa83A09bEzRUmyGb1YXT53+TyF?=
 =?us-ascii?Q?8qpisCO0scKkwWrUZxOXgdDqlAA7GU2x87nQ1d+JK3U7YtHH0us+yGSWeqd/?=
 =?us-ascii?Q?NT+kD3bD+krip3z/Bj6Po/qC6sv1bZSvLRRAwwcrgAb4KMWRPb6YQwPA9o3a?=
 =?us-ascii?Q?+O/BQjwMNIkpX9PWmbh8Po263tDMd/9JGzaxuCVJlQKcLa1j/pe7CLNTxXOi?=
 =?us-ascii?Q?8HmqGnyEwa9Qk58mV6BkxpCxXe/KGzMmTIHaW7sdNDUUnjksudz+316b2+qJ?=
 =?us-ascii?Q?VqU/zj2qmy9BXDJYPopMOQxJEGPpP86wSmWLeUj0w7W0G+U3fptiTKJrHepQ?=
 =?us-ascii?Q?3LCMCQvdl2qzXs0MBnwmonHtK9wBoJYXt59wjaHhG8PazM3gB4Mka6GPfMde?=
 =?us-ascii?Q?uAurYGmnW4HcnMieaUiQLdB1vASQ4sN5mFUmg0/1y7kFnby2904V+mdgYbP2?=
 =?us-ascii?Q?R0f+NPdxc266GH/CJjodknHJPTOOrDh+gWRZADt+y+ZSHDczhX/kggqbPlZx?=
 =?us-ascii?Q?0nreeghws97Ji8SedUx2zCcJioisUbP1EOVzn5QH2q6A3Qt4o9ssPHEuUUVO?=
 =?us-ascii?Q?y+JKL+y6RahqMPHvbKxKOkTqw6NGmDjzY+adcvLfjqU53o9RQUBzvVDMWalD?=
 =?us-ascii?Q?VVGOLLXHfwjna3W7dZnaznzYa3OCWMn8hjDfznPJWHLOpe0iLexbWXFt4WWi?=
 =?us-ascii?Q?SyNDL8jSr1CQQX3zJwd7908o8s1XWaD3N9HwJDumnlv+zArvrejDcozKUTIW?=
 =?us-ascii?Q?9gYmsMqjH0inTdFh/Txs7Wvwkgg3tbGoUxWXK/CEj1NBbgArxCivo0RW3flR?=
 =?us-ascii?Q?XQmtZeb6w/bDUDHC1P0lUKBmnTM2UwpQHgrt0D4RvzwRw0jVPfFbT/95BQZ9?=
 =?us-ascii?Q?nCVHlXhrhdPMl/0bg0nTk6N2l4GGfCuPMQSt4+hp4x1LDd/hzK6xVS22gORe?=
 =?us-ascii?Q?hNn6AQnxxebBKHBnrzCiN2u6apRy7TtFwZzI+iPnEkCG9okI5kHkyoGfvs3b?=
 =?us-ascii?Q?eNzSyY7fDHR87bN42sSok0R2JVogGhGbKhpTuGVT2yoeFJkmPBZGiyYkWJN7?=
 =?us-ascii?Q?LNzek3OLa7TIYOcRQbYEeFvTadf1ufiOniZgO/fXuMrgQ5Y5fgaVkqifyNAt?=
 =?us-ascii?Q?XFkB8EAMBPe2E5X05wO9WO9ZDecFbEP1XEf/WlhmBKkwjvRbWF7SGjSC5Z3C?=
 =?us-ascii?Q?LSsUl1648lYzdG8jcvFSs6MdYaGf4NjH+5XrKWweP81V3mUyMPw7WgXCAyKd?=
 =?us-ascii?Q?4yvp+fsiEvbFhs9AeCiodAmPEU5D86fUkf3AeZoSP7EQw976d9a5bxCaeei2?=
 =?us-ascii?Q?TvngQZ2lgILV5qHqJIQSM5tXDrO/HXWQpi+KLeSJwK4WGk8+yhCYv3Cb0aqX?=
 =?us-ascii?Q?u5Rd7jJFMQc5nIw7W46QyC6UKY3KoObu/tagWb0tBSg5EYLew7Oo2FkTDoOH?=
 =?us-ascii?Q?oYkEzNKk5kIuCY+gIOC5P/RhwQAvJtBc2dOrVYcO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6638b7e6-f005-469a-80cb-08dd78d05468
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:32.5573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzegE/V6h1kp3Ky6kQgtJj46YZfrnvLseVPgHck2t76F8BDDdODjPGxAkphOacXTvJ0YAS/lsCV5GGUthORhMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

From: Alice Guo <alice.guo@nxp.com>

Clock driver based on SCMI clock management protocol in Linux checks
clock state, parent and rate control permissions. To be consistent with
the kernel driver, add this check here. CLOCK_GET_PERMISSIONS is from
ARM System Control and Management Interface Platform Design Document 3.2.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 178 ++++++++++++++++++++++++++++++++++++---
 include/scmi_protocols.h |  24 ++++++
 2 files changed, 190 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index af5e8679003..af69850cdd8 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -13,6 +13,54 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+struct scmi_clock_priv {
+	u32 version;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	struct scmi_clock_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	struct scmi_clk_get_permissions_in in = {
+		.clock_id = clkid,
+	};
+	struct scmi_clk_get_permissions_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+
+	if (priv->version < CLOCK_PROTOCOL_VERSION_3_0) {
+		log_debug("%s: SCMI clock management protocol version is less than 3.0.\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol permissions failed\n", __func__);
+		return ret;
+	}
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0) {
+		log_debug("%s: the status code of getting permissions: %d\n", __func__, ret);
+		return ret;
+	}
+
+	*perm = out.permissions;
+	return 0;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -33,7 +81,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -54,6 +103,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -79,12 +129,48 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 1);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 1);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 1);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be enabled by the agent.\n", __func__);
+	return 0;
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 0);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 0);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 0);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be disabled by the agent.\n", __func__);
+	return 0;
 }
 
 static ulong scmi_clk_get_rate(struct clk *clk)
@@ -109,7 +195,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -134,9 +220,33 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return __scmi_clk_set_rate(clk, rate);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+		return __scmi_clk_set_rate(clk, rate);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock rate cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
+	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	size_t num_clocks, i;
 	int ret;
 
@@ -155,31 +265,51 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &priv->version);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol version failed\n", __func__);
+		return ret;
+	}
+
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -198,6 +328,29 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return -ENOTSUPP;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+		return __scmi_clk_set_parent(clk, parent);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock's parent cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
@@ -211,6 +364,7 @@ U_BOOT_DRIVER(scmi_clock) = {
 	.id = UCLASS_CLK,
 	.ops = &scmi_clk_ops,
 	.probe = scmi_clk_probe,
+	.priv_auto = sizeof(struct scmi_clock_priv),
 };
 
 static struct scmi_proto_match match[] = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 342a65ae7f4..519b906b4ce 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,6 +731,7 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
@@ -738,6 +739,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
 	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF,
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */
-- 
2.43.0

