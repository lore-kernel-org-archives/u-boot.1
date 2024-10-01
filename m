Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F1CE7D19
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543AA8919E;
	Tue,  1 Oct 2024 14:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FCSSED7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0411D891A2; Tue,  1 Oct 2024 14:04:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA88E890EE
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pp3g6Qokyqg2Yd5Z8Qytvu06crvHxhKBxs1nEWEQqC8FziumijLCaP08qFONrYmod4K/G8oHTkMP+kPImb6AtwZbH6HGBKbd4ramDIQNZqsaNZvikdOS6s2ZOBNNkQjzzK7B3sQ/NpMbZD6WXQX9hxcc/G9U2IAi1pgGLrwTQLar0IKihlMdMo+j7OZ6Y1wJrYObxre0ZAy32Ck7SaB1plQITVWtmRe5aydR8jhJ4jQFAF+hDKEORy7YyznBGQfb4218ZYbJtm9piQ4sCzhB45+PKCK/sxJIiyty8A06zV0b0qshQN3KrtDHaWLMUWpwYn9teFs2kxFi+A83l0D0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHFFxS5+RzW+2cytwCO4TQhYubjxJPFYHHJkTmbP4SI=;
 b=md+4/lHzCaz1lnGndoHPR+off/dveJUz6qhsDHNCLalF/19qrNcISbNtNIqYshwHRY9r/2uU9NwMJZZTPpKxP13tfZpfeSNWjxEYoyrsBQJIXj9CcI7KLQ5NdHjCmuFYogeMPBXLE1eviiMY3eP4ILEMqHNcffV4Gs3njSbP+LYlYqnhunw4QMIx03W4Lb8iKgkhkXztxJNJgV4Nalq2fdEuStK2pasBnNxd9/QHs9sOZfZwob7WNVFK+wDWwoDb7dESQVGaCX+HmU9jLgBi5Iv3FMWv0w1UjRqzTcGoqC84eYwCgvLe4RNXgsnwPpyeViwX9mPX/O343YEEMRphjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHFFxS5+RzW+2cytwCO4TQhYubjxJPFYHHJkTmbP4SI=;
 b=FCSSED7mk4+9MeIUkFMbIHWInrJuRuV3zJybnfGS2fLl6uH1Iujj3a6+BoBYqAwiRZ3mh9pwRKZwLLWNREFES05RSOcga+HDksPW5HkKhsEiD6KgaZlMPiFU9f4boeDS8qd1VSTtVdmo8Mz8Xm8uYCXi1UViuLxDhQ0U3GNrGA/JwrWgGaC/XVknNiDefenx2kYKcOrKaAKTGd2tpzHkqhWU95eiyO3dVufDSWsQI6jdX9hlTjLsY6sMZuXwuJt+KadsodogtqwGz3eHPxE5C15BYpPbq7SSWl+D3imrtXNkK++LiARiweXYwEM9vB3A8rb2DvMW/LgRSQmzUdOlfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 1 Oct
 2024 12:04:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 1 Oct 2024
 12:04:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH V2 2/5] mmc: fsl_esdhc_imx: Send 80 clocks before IDLE command
Date: Tue,  1 Oct 2024 21:07:54 +0800
Message-Id: <20241001130758.9810-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241001130758.9810-1-peng.fan@oss.nxp.com>
References: <20241001130758.9810-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 914dd747-ec37-495c-ddff-08dce2113320
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZzYZIjGB38kak+Zzzuxq7IKevqZAbdvv9uRUOy/H2O1RSBBENa/C4fFJgDKf?=
 =?us-ascii?Q?gg/oXZQiSggojgx0LYvL3OxI+R6eyfXPcDQPofORV8XPNeqVUQcI3Jw5JYz5?=
 =?us-ascii?Q?Baniai5cZ3WnN1pd6CNJoROtjb5ixOLvH6smM8K0QHIRj6WiyFwnxBJTcegx?=
 =?us-ascii?Q?JjvM169I24RGZnM0KqkoBKktu8ivYTv3qwCw49CNM3qhpjvJuGqo4V/IxTcv?=
 =?us-ascii?Q?QVd7KYHN4ZXnGwtdPxAMKwLS/39WCrMFp1sZh83IW4JS9FrIHmUnbd+CztjH?=
 =?us-ascii?Q?NY53P8RVIRApy1U7a9dJ0dwUmNLmNlrFhbA7Bv2uLWO6H2zIyMJOGPZ8ZeLq?=
 =?us-ascii?Q?Ah0c1XEdZDYunfqv3Xel0kz4VfIkYg5FpSjqROpBPM5NtNpqRwXuabD09F0m?=
 =?us-ascii?Q?OUGlLP++Da9Ca1vKgZYln/sKFwBVUtRsoEpkL11kARNxA4xA0elPK9TVHLlx?=
 =?us-ascii?Q?/ylGzIC/uiW2/ib4oLUE3/zoSFVtaZKnr3tg1mKjVpqd9FhdZ+ckSeKP6H3u?=
 =?us-ascii?Q?FyA8z5HurlUqDBIwXV9ruTRZwyLLoxb9bh2a+v3gTYmBfhRI8gQppSw+WUEa?=
 =?us-ascii?Q?nnZgF3hPziGO7G6h1DVHzZS8uE64OIi1pyoPFnCwLRaVI4+w2r7tx6pQcJkF?=
 =?us-ascii?Q?l3DywP9WQm8lQKiVpldMa1O+G+2apDYXnyeezW4HT4QM1KrEjjHYS/vo5C7s?=
 =?us-ascii?Q?FzZcBwufHJsw0Qdjioby1LA7lRvJqRnKVzQzis/BAOJt0t5PxmyeYo9gYEvE?=
 =?us-ascii?Q?qx1kAuWSQZ8oBQ7/mc1iqUcizOveljGT2FpQdTCDhfrxTsqWu2Q0ll19ufXZ?=
 =?us-ascii?Q?TGJHbgu6x5JXNYQRWLqmO48a3/YJ3h12Zvw2ea7cb7RyMa1rYXleczIyoe4v?=
 =?us-ascii?Q?CjlNlgPkv4BUF1uAkj6k1x6LvEx9LJDZPTpQ7rAydfd839/kZbm3SLoI8QgW?=
 =?us-ascii?Q?bV80hSDPbh1xjnUeHYl8EemQ3FCKQVqGW6YQrc2SeHOY2bcSbms0lKf5cCIv?=
 =?us-ascii?Q?bIMot1UAR4dbVFudkAbCc8vtAqYfFeDizwvHgtM/Bh/hdn3pqfi1Tk+SKa5w?=
 =?us-ascii?Q?hqpya/8uZ6hD7JXjYCRCf+Utu0NU5sfOHylHQ3QHbkRqX1JBZlmpgXPdgKdM?=
 =?us-ascii?Q?PobVBRn0n3dJYcIQgP/dU/l/0PT83iQdrKFDXVsVcTG/KZFnMBAOt0n2r+ZN?=
 =?us-ascii?Q?1kJi0yAv2t4gPk01vME4n4ueuPcLH7cO/TXxhwD7OOq8EVBcnAaeCP/lmRkj?=
 =?us-ascii?Q?PpZwfPjd/kPUADObo0STobKYOpi/opOLcn7vV33L5atZYbqYf9fxp9zgTpEH?=
 =?us-ascii?Q?KPZ/IBXDpHXJoh3VxT1kxQ+m51p5zHFHf7MJfN3d+nkHQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qw06Uf5CKTpHcYRBiJEyVZ12VoR8vGprcrOB8UYkRO7gNZl0S5fqbAzbTtc6?=
 =?us-ascii?Q?2Qe5Bg4wQwdD+Wt2YtkXxiQDrzTx9kRIlhTaNGHq+L2fUv+n9KQfrnHisz8U?=
 =?us-ascii?Q?NH2adl2YtIP4uAPFS/G8b9ytsUjGBgqC8LON/gcJhx9sA/2nTF4lpdNMakMQ?=
 =?us-ascii?Q?31OmqLCdI0yfvpaeNp8OhOtM8LpXhSwO4anxe/+no7COPF2IdEKPMP0wQQHL?=
 =?us-ascii?Q?1qr5gg9rJZyWq7/qThhAgGegHSfWxQOywXZbpMjhVJAEuwt3JcG6Gub2yaye?=
 =?us-ascii?Q?NJZ7ZgRPfUQ91DQd6vTIE2/FvBxF3ofprW4r0akq0DY1W2qaiTiUrdqbYfdn?=
 =?us-ascii?Q?X9NeL4ZErslBUDoKxY3NO5bAwggB0cqPFg8Gb3b3adtQZ78D30PrD0hL5KjB?=
 =?us-ascii?Q?twu3ueMDtZGtMHbyGj2YcZIMiG81mKy/Vbi1tOXc5FTtj/N75fJnTw16YlBF?=
 =?us-ascii?Q?/s62DHO62urxkBC0DhsOC88j3oyCEeRJgaUhku07Rchlmp4mW2CU4ze2NKNh?=
 =?us-ascii?Q?xcwRm+phf5/ow5DU0GOk+qSSdJDZX3BaRdaqXMAkgJVynJh3j8LWjVqwHtf7?=
 =?us-ascii?Q?TmcJ1yKg9A52vvOzN1mOJW45R1RAEBnSc8/T0DlCQTJuHgGyf+CgnRZoA08M?=
 =?us-ascii?Q?rhNJAvmW4RshT82OcCHGtJ2iElXPUzm85JRXCVZa+rQiVnGWjy/m2pDyeZ6b?=
 =?us-ascii?Q?SefnFWn8gt8OgzadUmndbKvCxektua2k/zS2fVo4fK6o7iC4ECIXvUW5iMW1?=
 =?us-ascii?Q?h512G0KPNevz6PwR1H0RqP+fjwM50UrFAOcGE5z5mdqfZOuv9vDdryNwo43w?=
 =?us-ascii?Q?yxxog+xFars9aviJzQgzbJye0e3QaKXzsuCMgbGDDvSa0YuWRp2QhCsNfBut?=
 =?us-ascii?Q?/eOTx9nhYIvUTcTK3SnG3qFOjuCyAl3lyZsk2pcFVcyumdQlBxSAQ8WIEWnd?=
 =?us-ascii?Q?sEtSo1zPRLWIQlgQNotCf9uEtldR2LF6uOt3ybDiLHqiNrR4qyvrCV3oev2F?=
 =?us-ascii?Q?/93i4ETltsWowMnxh3/UMWMoj+POHfd7wUAfSbwGijRzsMCr40n1euLwSVoL?=
 =?us-ascii?Q?EbywG/oIATq3f265AHN6+L8UHRX/NQAFERa1NvGn2n5vUHVa7AEJLIEsi2mJ?=
 =?us-ascii?Q?VqKMSIJuzZ4W3gsYHRBD8m+hX+gp4xXRIVYNDe/cEchYtDTsj/fHZeZeSmto?=
 =?us-ascii?Q?gOVB86d/dL2l/d2rFs7H9O393IP75oWAqsBXAkBMByRzDOp9X05vwBr9sDCb?=
 =?us-ascii?Q?5t6ZaQQQlzJdV3ovk80xJ2Ycg7IsmkJe+aPVADNFCBawosF2lKhar5isvus5?=
 =?us-ascii?Q?uFP2JJZw00jwnfg5Z5aLl1MYdTzKEoFKuwcWoovVJ+cQbR1fxepW0u7f0XjS?=
 =?us-ascii?Q?IfBIXZlGy3QQyKjD2oZiVAEQHxuGtDQnukAXgi7NsZQ/9huP/aOHPYrVqLlF?=
 =?us-ascii?Q?MV4+RtC3+7LMCA81PDlmopiZxr2tLN3P8o8KbuVruh4ti+dCEofCCcIskiBA?=
 =?us-ascii?Q?RanC8n5cRF4WBX6n+Xt5EN+NzRRjIxOXK3tVzeDcq17unYRSqASZd4w+pX3C?=
 =?us-ascii?Q?AgJNkj9OBEZeIkZLtwtOG3Ws55cKk/cDHzRQgYx0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914dd747-ec37-495c-ddff-08dce2113320
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:04:28.2374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBTq2lX4aDSWCRXKgr4dV/aifxcpXQ+Ys+tP/jU+vZgmvYh3HvECQAMXm1aEkyyhW8x8SBSCig60x1CQ/b6p2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
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

From: Ye Li <ye.li@nxp.com>

According to SD and MMC spec, 74 clocks must be sent to device after
power stable. This is need in reinit ops for DM MMC or init ops for
non-DM MMC after power cycle.

So set the INTIA to send 80 clocks in esdhc_init_common and move
its calling from probe to reinit.

However, on 8MQ EVK and 8QXP MEK with some brands of SD cards, sending
80 clocks may not work well.

The root cause is related with power up time.  According to spec, after
power stable, host shall supply at least 74 SD clocks to the SD card with
the maximum of 1ms. However, the power ram up time is related with the
characteristic of SD card. At the moment of sending 74 SD clocks, the
power probably not ram up to the operating level on the problematic
cards. Then cause the cards not ready.

This patch changes to send SD clock with 1ms duration to replace 80
SD clocks (0.2ms at 400Khz clock).
This way meets the spec requirement as well, and adds the margin for
power ram up time to be compatible with the problematic SD cards.
This is also aligned with implementation which has FORCE clock
always on.

Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/mmc/fsl_esdhc_imx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 0ced796ff49..e61c5d544ea 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1035,6 +1035,11 @@ static int esdhc_init_common(struct fsl_esdhc_priv *priv, struct mmc *mmc)
 	/* Set timout to the maximum value */
 	esdhc_clrsetbits32(&regs->sysctl, SYSCTL_TIMEOUT_MASK, 14 << 16);
 
+	/* max 1ms delay with clock on for initialization */
+	esdhc_setbits32(&regs->vendorspec, VENDORSPEC_FRC_SDCLK_ON);
+	udelay(1000);
+	esdhc_clrbits32(&regs->vendorspec, VENDORSPEC_FRC_SDCLK_ON);
+
 	return 0;
 }
 
@@ -1569,7 +1574,7 @@ static int fsl_esdhc_probe(struct udevice *dev)
 
 	upriv->mmc = mmc;
 
-	return esdhc_init_common(priv, mmc);
+	return 0;
 }
 
 static int fsl_esdhc_get_cd(struct udevice *dev)
@@ -1621,6 +1626,14 @@ static int fsl_esdhc_wait_dat0(struct udevice *dev, int state,
 	return esdhc_wait_dat0_common(priv, state, timeout_us);
 }
 
+static int fsl_esdhc_reinit(struct udevice *dev)
+{
+	struct fsl_esdhc_plat *plat = dev_get_plat(dev);
+	struct fsl_esdhc_priv *priv = dev_get_priv(dev);
+
+	return esdhc_init_common(priv, &plat->mmc);
+}
+
 static const struct dm_mmc_ops fsl_esdhc_ops = {
 	.get_cd		= fsl_esdhc_get_cd,
 	.send_cmd	= fsl_esdhc_send_cmd,
@@ -1632,6 +1645,7 @@ static const struct dm_mmc_ops fsl_esdhc_ops = {
 	.set_enhanced_strobe = fsl_esdhc_set_enhanced_strobe,
 #endif
 	.wait_dat0 = fsl_esdhc_wait_dat0,
+	.reinit = fsl_esdhc_reinit,
 };
 
 static struct esdhc_soc_data usdhc_imx7d_data = {
-- 
2.35.3

