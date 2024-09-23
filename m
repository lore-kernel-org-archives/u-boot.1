Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B71CF9C6E
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 12:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC8F88D6B;
	Mon, 23 Sep 2024 14:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Nr2v/l77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145BE88D27; Mon, 23 Sep 2024 14:08:33 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A20D88D27
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 14:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHoNdclhRx28Hj8upu0lRWzQm1MCNUhqpE4AAUe8coFkty0rxRrVFYSXCUxAbiS981ZB4tqi+WV4brDAEh/D91+XnkMADni9oliSZanwO7+EKoYadRICMUKLq/84f8sj8EWWxTpdTSXvzXWzByAzG8idccTUHKBV3JgZ7pW11+TqJmJjPF1rBIhAhCAfTf6sgRjStTWwog8lMEtQLyX7dmuEKVeBgXViAfVbGq2DLBIKDGV+eBx8auKJJwG3bz/7k+2WRyvFmVBlalXQd4iKn4qjtRlg73R8oGAVsY12Z0KAm1vgx3GJ/UHg11r/kwEbfBuc85r+wtIt3s/lI8XuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goZzOSeWJEi+gEqYeOI2Lx0qU8xNITijRIgGBbteA1k=;
 b=l8E1UdemCGVTmC5+hnCQKQC4pyPSaWNzccOZSTbTh44iO675RzLQ2Ewi+VkcH21GXrdFjh7tDDnCmzwr9jDY6mZTTEZgrvpDqqg7x5UMs2xcirWfYaseO3D/M1Bj6m+dSCuwvHFKKjGsmNA+6f7vBxBHVEJyptbplvC6f9hdTx1rK/a4s6wk0erHbB5NGujU6gf49zSF0gUuvxtpVrydoSZL1CjsB93TjwH0qe1tFY/r4q5O4JQ0h8KDN2NazdCRRhgn81G9gax8YBxrzR/JHO/s2b/07Kw0pXZnko1qjN5mwZ55VAouvrG6eYJDqob7OqbWn5sJlFtVBJzrTxsBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goZzOSeWJEi+gEqYeOI2Lx0qU8xNITijRIgGBbteA1k=;
 b=Nr2v/l77109xIVS0kPVE2MS40wJpvkbAwuhZknXrA258aagk9fHKgs4MuFr+mzS27lob86YM8suFA+PrZiOQtUG7J4ogV/eDLlTIgQ9Bza1Cf4wyf0kH0p5R807uYOB+RbSq7g3OlOsx1qRPAlIXtNBVgzMH5A+oFXVrgLanfVNM7nLjCEVfYZE/aQIEJ/CA2gnCzr5IGqvIfdT4L3ouQnKNepdCJJw20H5ZgHXrc48JJVUjEQ/I+o3n8XV11p+13myxA0UB0mmd88kxMO4MWLSXM+EChA08mdaMA07azmK96elLTXTsCagtfF817NVoYf7V8Q6rE000c7lGvnTAmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7760.eurprd04.prod.outlook.com (2603:10a6:102:c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:08:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 23 Sep 2024
 12:08:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, jh80.chung@samsung.com,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Joy Zou <joy.zou@nxp.com>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] power: pmic: pca9450: Add missing newline
Date: Mon, 23 Sep 2024 21:11:33 +0800
Message-Id: <20240923131133.27546-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240923131133.27546-1-peng.fan@oss.nxp.com>
References: <20240923131133.27546-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: b288f3d7-83fd-40bf-e674-08dcdbc86d39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WT15CvxxZv4Dx0dGryaBTYzALeEZGcDHNNPX5udnYm2AeMFbpVh3WBPSA/Uo?=
 =?us-ascii?Q?MelMDyixhOyVRlwK87b16S8hieLEwHNhDakJn1XYFUiADjU0i7q36g+mV5dH?=
 =?us-ascii?Q?m1qy+RG/+SxQfYSfby8VK/338gvuqimV6xGPQirUL6xhNCwj9IERDOWuZUjZ?=
 =?us-ascii?Q?twgm/32yll32eWox2+sPp0xIN61HyelC3QaSp90mpFayH2/7o1y72OsdAA7M?=
 =?us-ascii?Q?6IxaXcTugD9FqOgg1FhRsqbENUzPR9YpBcXmdRijkfVRQEsBrUQitp2cMSi6?=
 =?us-ascii?Q?qG1BleyaXxbrZJSABono9iHZsJ05yritJQWYCdUMvKQVoauUumvtvzyA8YAN?=
 =?us-ascii?Q?Wl+YFDyyBpvnalrSkQXTeczTXTLUDW4QKYJCNHU/TLngaotF2/wKWAQlDxEo?=
 =?us-ascii?Q?YLzX6a9TZWEaHlmlpskCcjKArllMVDQ8bd+vFXcoRXDvqk8FnNYhXw7o3eM+?=
 =?us-ascii?Q?OdiMiHgBftmAaRgupTJcQbLK5W3p60oPQlWIYciEa5yrfjZpk/EJlAHLXuhf?=
 =?us-ascii?Q?tRe0spqP4PDqHRpKA+tfaO6xIgsQDcSBGY0toFcCHUAxL+FD8urI/wwZ9tIF?=
 =?us-ascii?Q?jAl3GxT+aF+qrb8XWgd3oEq/PRt7ROYZmQbXopH5Rme2Yxl+FHSrH3Fuqn9e?=
 =?us-ascii?Q?3JBCFbeQCluFfbpQKOl79a6fhCWMCzundXUa8JR8mzWyyz9Jr+ks6XTdKlNr?=
 =?us-ascii?Q?yK68aJh+RmKC5JX4fkS/JfcAalZYdwd5uugWCf3Qi0PUGG676FbrThqzXHjO?=
 =?us-ascii?Q?EbZdtX4LFlcXOxiMYRK+dYGrouuOTAXP6ce7O0hlGkAmiZi1uPWrq7GjELMw?=
 =?us-ascii?Q?NH0jJNtr+dJ+AutrEym0ZQB5UvVvNHgQOsuMievjb0V/sUDafjl2ELZWZHZm?=
 =?us-ascii?Q?XYOhrcvqseO7/qMT4XKUIpEc+pCRf1Aj0KZei+/+aEoxamG31g7OB6wcA0cO?=
 =?us-ascii?Q?A4+gnV4MnnUPtFkf+HGKR/GIhLS5nefzNt3h3x3RB6keKmnIkTWlLRR1iwYy?=
 =?us-ascii?Q?ernzuvJn9VOnSg3FJvJ0y3Y7/YoWm9QDD9N/2jhgg4VvlpqkMwQrTTe/TyNw?=
 =?us-ascii?Q?E+7J39dRzVvvbYbi4/uqdnxosK4rVq43NA5KU7rSvpeqZe5NRLZkpoBEGoCY?=
 =?us-ascii?Q?YwpUmTqJ5UQzHkuYx1Zh9pHh5JDVCG6uzPoVQiily3CDOhKPt8WuyajnsvOX?=
 =?us-ascii?Q?A1R//rCvvJGWoS4DytbpfCIwwnHTYXW9839PUIH3hBZ8FFHNgfJvNAXWLVAQ?=
 =?us-ascii?Q?Znh6ReJc+77lTtuGazIDkltOIhUL3Kl7fYGPxJhm0wPNeN+hbgV/ZhhKWctI?=
 =?us-ascii?Q?JP39HKpHyt2HfMxZ+K+9RSavruF7BfSDjmZxM/q8vWBTrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYTUaRqPClOaXAoar0oP0K0rmSU5l56hCI9TWknuwSv51SGL8eOX4zEqfZkC?=
 =?us-ascii?Q?YfcLKapzSc/puIjMawg3nrjb61PApr4zbREXcOJh+flEny/WMyT0TfEZxQUl?=
 =?us-ascii?Q?c9OIB5CgXuTCqyDTS4nl2RBNJ2e566OVK3/nANoCSVumZgJ+i2av9HISQi5U?=
 =?us-ascii?Q?OYzQLEryMNjIBYoKuyjA3HmlYVpQvZVfESqnmGFcM0eieb3RuGM/SQJw15EN?=
 =?us-ascii?Q?ccdmXvjNyyQg1EeAesAtkctWo8h6V12yiDtFNcNZEVqEnI3a3cL0BQMdquwS?=
 =?us-ascii?Q?vjfzXXzKdtjb8zH7Fz5i5EljuXdaVWobAisJnLY8Hgfncc1CKatpy/lRxjB4?=
 =?us-ascii?Q?ukxhxeaXcYa7RIYevYoG5jCD4isMe7wZArylBAjuab3wjSPKzrlN/e/oa1cq?=
 =?us-ascii?Q?WgPJf4n5tOWqVr0clrTzJeOz9XMb7r7vvhlhjDMtOr/MGKutkdr9z6lavc0C?=
 =?us-ascii?Q?/Kw0LtMp1h+K1fkAThwkjyRtIP3hP+5bTkpcEsoaMe7Y9+Pkuk+1IN7hTviY?=
 =?us-ascii?Q?NCBN7HhzIgEN/YssjwEanTqjHmdHMWmM5l3csVVfToJz42YG1VKEZD2hJfeB?=
 =?us-ascii?Q?GgKdo8vrQcPcmJigDe7TMUswRBwhjh/edU7XDuTEFznijbxhP3B46wK5HiWc?=
 =?us-ascii?Q?chV1UHKkY9Aa9YYgqC98iVqzfzftsRwanb4+nIRo5VwfVuWSrwQCDruCUwKm?=
 =?us-ascii?Q?tPtcz7XNSDz3I+/YWo0opxrPN9eFwx8v5r0NPg6llxsut98q+2r02QaGnMPp?=
 =?us-ascii?Q?kaqHC08L6tThCwBSQVn876luQaYgzLJChy3BVHQBFeLcLB9Ff2UKWwrX63RA?=
 =?us-ascii?Q?MVyACOP2of1milpfC0TqRrBDr6+hCsHP3NIE676825Kf/KXHmNJdXMojDvMF?=
 =?us-ascii?Q?f3Fd1/P1gaYvkc+Uo8J5E0C8FByevEr+e+o5zjMtWoVlFyHmIWIfGLxuicQK?=
 =?us-ascii?Q?Q7FjADESyU/Q3GU3ZWQTj+aSdznXLfM0C7/BFhos8/VPlbr2x9E/zCoDJJaG?=
 =?us-ascii?Q?hlqxEo5NePM2uHUDwxV68jGmYXrxB4HKJlYTKlhNxUwpf1GGhR9i8Q8x6W+2?=
 =?us-ascii?Q?uohCStkb6SxCJAYe9xqE4do/Y1O6Q4m+37nBhOz8o+phdW6e9hsQPq7PykDm?=
 =?us-ascii?Q?J5Lh7dj0nJze6Z/F2reQZu39DDhhb2CT47qPUf3fT3+F5E3bOtVZFxKesj7I?=
 =?us-ascii?Q?Y9STlikR6LghBW/5wNGYFox/YwnkQ47AgHoSx/7ZCZdEBhZ517elTf2LMdyM?=
 =?us-ascii?Q?j3CsSIGYcifw3xZT3ZtRrCHSeD7UFHWr96Drka01anI4tTwSSqOBoP8s0ueT?=
 =?us-ascii?Q?1A85uHYk6e7n2ZzuhrGPjeLEMWSG9IqtbhKs8FnglJ6zySNohXu/w848N66a?=
 =?us-ascii?Q?0MEG9lqzW8Ogqj7d4z6mWTSRaDrlUfAZfBU/Te/T1JgvnJheYiKO1rkX8KJl?=
 =?us-ascii?Q?ApLDLn2PsmFdUGKcEAlKwPJZZW9N4Zq/mslbDJy+/XXypnUHR7CMvUW2twgh?=
 =?us-ascii?Q?kazT17HJKgaPxExjbpf54l9vSx2zTj32RW1LW7EDlJxoBWNIEd/lAUHAyBzd?=
 =?us-ascii?Q?ZQC1kSgQdWRAK82Bm2zRAMhLbqoeHwHY/1jzCU72?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b288f3d7-83fd-40bf-e674-08dcdbc86d39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:08:25.6204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPe1IbZjHKhXbF+r07ijY3iDzpPLw36UjpjEWL+s5DbUTrLod1ojjFdD00hKTlvK5yP8RD3PQK4fg4uAjxC+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7760
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

From: Joy Zou <joy.zou@nxp.com>

Add newline character in log info end.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/pmic/pca9450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index 5025e2d338b..9d875f8bdbe 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -42,7 +42,7 @@ static int pca9450_write(struct udevice *dev, uint reg, const uint8_t *buff,
 			 int len)
 {
 	if (dm_i2c_write(dev, reg, buff, len)) {
-		pr_err("write error to device: %p register: %#x!", dev, reg);
+		pr_err("write error to device: %p register: %#x!\n", dev, reg);
 		return -EIO;
 	}
 
@@ -53,7 +53,7 @@ static int pca9450_read(struct udevice *dev, uint reg, uint8_t *buff,
 			int len)
 {
 	if (dm_i2c_read(dev, reg, buff, len)) {
-		pr_err("read error from device: %p register: %#x!", dev, reg);
+		pr_err("read error from device: %p register: %#x!\n", dev, reg);
 		return -EIO;
 	}
 
-- 
2.35.3

