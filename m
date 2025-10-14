Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0432CCCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F01238206E;
	Tue, 14 Oct 2025 13:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dkHo6SbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26D5C830E4; Tue, 14 Oct 2025 13:19:08 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404D4802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oiv9tt5p1xM5l4uZlMLl0b8YI70dA4/izTxeHZYOwRvYt2MwiR2WZPa1oFacXf7IGH13/DqoDrNugcsTi2zC0DB3mU9RWGno4JyszgcgwoQdwI0cDpS1JKqrgN7sF84wGObUtApFyj3VmkhX6Ss9FHvGOikS6qpdfK4GgjHMHfjsIgKnxRobwK7tf7Jujxw0aW4qcK6NM6dRBR/dJAoK4rwM1zMx/JUOnJEkjbycV294DY+vEGdx2Bu6cdIQ5KnDYo0aqwC3jWCXc6mmg32XdgYV4uMhFIZUYRGuHCafhjYZxpNhjUbhUsJzALxGhDy3vYTJVAVGDLbZM0mD8vRh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr0ic8v3U8aPlOfHelfgjF0+GL9sZ9mJAxjjhOPnY+g=;
 b=wdSXI1LfzsA+HVlutuQ4qoGYxfRxrnfqj5HViB2YbATWhrwnLCFl4NjYHX+bvvcklPgsb6wOC/0CMGDVWWA3TcdnGCJbCJU5orKwkQ/l59UQ8/On1JCLdSRhCh2VYrJvUvIH7uVGDZw+ybma6XOF/nU7yaO6E/sBIqlxB6fnZS4U007lpzGfhFtc+HxkCE8JeSfEMrDeSgPXMh8sW92ApZLTw5OPlSZGx2WLWI08Q5XH528n0vDJ7MTcC8ZL+5VPDoqO46ssr2PstIPtVxtIvkWlRYF/Dlz1tBn8LaCcfmv9XfhyaTGMkkCVv4hQyNSLZf8dYO0A87OnhyYbe7ttgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr0ic8v3U8aPlOfHelfgjF0+GL9sZ9mJAxjjhOPnY+g=;
 b=dkHo6SbGjuSd8glF8eoF2Z/Q6DG7iZEvldyqPDh0jnjcwIqBBI5nIBxGt27AJEBGRYDBYrMBIop3R+rYjxheuoTZLaKyxw3XXi5qDJIo39Gqj1mPvWFBTALkGSTdbhu0wDz4NO9A4a/u5bpDgSPbuhYSGhTfhi779mja70x78MOd957wBVFRRhnQOMEO5TgU1zInWoH/CaR6EBW33sVSkmP2ViYXo5rA1PlmxN3zNqRHz/PxAyOF+zPkTfM91urjftXVLXrXbKuUMkyZ+UIC791jRykam1p73ynzOiyzzLMQKDObEaHLbv6rlnRQrj276tSsdeAzoa9lUkQN1CN36Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 11:19:04 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 11:19:04 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, trini@konsulko.com,
 sbabic@nabladev.com, festevam@gmail.com, jagan@amarulasolutions.com
Cc: ye.li@nxp.com, alice.guo@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
 sjg@chromium.org, mkorpershoek@kernel.org, marek.vasut@mailbox.org
Subject: [PATCH v1 2/4] misc: ele_api: Add support for XSPI SET GMID command
Date: Tue, 14 Oct 2025 19:17:54 +0800
Message-ID: <20251014111756.446456-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014111756.446456-1-alice.guo@oss.nxp.com>
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 40598dce-45e1-4ada-1267-08de0b137b66
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VYETJ6PyxMOiziqhRa/ATe7M/2yyGC7WnlnNywbSlGjXPj20JHfWaDWxQn08?=
 =?us-ascii?Q?HvUQ4PVg5Gt+Sv/hrEGxrmpcIDTQhrVcKy7zpFGWZIRrp1vJkMGrpCtpNQ4E?=
 =?us-ascii?Q?RWD7pPuoQJXruvPo4KBjsjWKK8MRTH/kr9QDdsWMMR1Y3bFrCAgPsS141xyG?=
 =?us-ascii?Q?hLvjunYyzJ3QzQdv+J30gHSwe26eFQhXQCqtoj4Qc/0rbQu9P7mEKuRPBEQj?=
 =?us-ascii?Q?oheW8bl7JKaUpynsKN/0n0BLbEMTIJuHUPUEAXB0Fy6fvHZVvC6uExrXPiQp?=
 =?us-ascii?Q?cpyAHC7P1zvphy34uWuA+F+mJNtuwSbKL5wWrB6ZyRVS7GQCE3i36h1TUe5V?=
 =?us-ascii?Q?/h8EIwVYQFWfTEyeOFQ5J7K9LESi+oI5UurV0opKXsotuuVbduMXbMV0iOQx?=
 =?us-ascii?Q?sKVojV5ZlCtx04SoihgHOqSTgZS9gKRiQ78Y3S76VlGDF0u9iTdCAX4LG4Tm?=
 =?us-ascii?Q?rWuo6uP+dB3noyo71iODlzCCLuvCOhljtbyepTFCGjH0UMDQ9R1RZWw1D45W?=
 =?us-ascii?Q?vQe1y4zIHMn0h2dknwNEJy/BTCtMaKNCT2qSeYJf08QmJaLUU5Tzm5jKgUW9?=
 =?us-ascii?Q?igFv1VazBczzVJWWITui1dMkjnCIcqb4XtQBJelZ7DcSHxS+NFb6NEJ0B3UI?=
 =?us-ascii?Q?hBF7StzcW773KoQ914oBznikjHacrduCQZxiorxob5Y4gMW9niItgWiDiFzT?=
 =?us-ascii?Q?hs4hPUz+zeC3ViDC7T5Enwk3mBnauzPBwEzBynIdO+fydInIG3FJDm2qikKL?=
 =?us-ascii?Q?yzybd212KXiFXDtwVTG4anhYR0dx2HodMT8xCrJYF3bpAMmmY9svfKyQ2ebC?=
 =?us-ascii?Q?i+ieBZTaT+ohbNRrAaE52Iq5ugf4o0IEm5d2iQpzN7mGpSjeiuTpgpgWxluc?=
 =?us-ascii?Q?V9fEz1lA8WVApQD5roTeo0F5HDe6ZHQlrKOdVsf+ncJHrLIdT6mVbDUMXvEX?=
 =?us-ascii?Q?lkoyF+aZILAjygKnc1WmrOPAAgN2HgMmD8MWwmvy3F1+CItbSJxRwrJWLMCC?=
 =?us-ascii?Q?HzM6BKt7UI+5BxLR7LkkjEJ6NlNQxmZ2IEuuDbNmZlCu1DBgXs9gTtCc7Z05?=
 =?us-ascii?Q?rNpvn2Vj9WP8XB5dKQ0fpc0aUTVUoy6Ii/JrnDZnztzCqX9f1ISvLL4gN4bG?=
 =?us-ascii?Q?/x7P3IG1SO3pWUiZ45C2FD+49EsjZnhdpOi/OBsiMmVIoZqeae2rLYlTQCvd?=
 =?us-ascii?Q?L+Hfko1/s6HsGcr1nmK3OkpWwZDtZ47IKudaVxPgoD+F48Fm3Hu2lajxRTfe?=
 =?us-ascii?Q?uOvTmHXMkFQhkTCruQ4KZLOTxFq830Lfrd7J0GFEBD8omlqr5z1EDMp6Xsyl?=
 =?us-ascii?Q?ZgGTLx8rawebVqzGrBVGvvwSDl2lplAxgflLCHD4hTPsuGEepIWgfbe6dd0P?=
 =?us-ascii?Q?YyYVWWiGVgKWieDUen1WR6HQTAlS6amntKlJgr7usNbtCN2sZTaEjUMEdXOu?=
 =?us-ascii?Q?Xr6OqftAcIG+Yn6PwFYlp0ZxADxrOfHmTz3TKtc1ghqMSLrA4Fy7hdbFCrDI?=
 =?us-ascii?Q?ojphuPdy36K8Kcm/c5m1wFKUhNNdeu9SfU/l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZgF3AlNPLeQOdclKlDs2EwVzxv10neoa1cTJk2aWWa0w5D23kHkdrkjLJYN2?=
 =?us-ascii?Q?L2D0mywCWflUlfOl8ZYgPugwOzgAVRqqNlymGRmw3b1NN8X1/+tvRV6Uuv06?=
 =?us-ascii?Q?zH3y7jQ8MSC1PKObkDLz+DkikZvfb/jRCVlQEoIgca1cLHdhHcom4717/TLr?=
 =?us-ascii?Q?acGw0eLyxbHN8/dVz8gl87vho9GupdXvbOu11jULoDh+GTogCxzfujmqxVZq?=
 =?us-ascii?Q?vcS/1a28gRG69CtVL6Qput6+3WlR7O5+wJUQqO1ehDk7up5+MmcFrtOOcf9X?=
 =?us-ascii?Q?QwyT+2Ik2jhyEI/C231zTriOStautHdAuVFoOyCR7GmKZH4IJ5qLY/rNTkfH?=
 =?us-ascii?Q?8Tk6eI0XOzxfXs3lDV64jfIzxptxnWHrdn/RzowwACgKHdOvskDpJgIGdXKx?=
 =?us-ascii?Q?gmTSxHujveQyPDlN9ekd1Q5tp7nwqc+SOJksF0x2sl6ruq4F1TsYy54e/w3Y?=
 =?us-ascii?Q?b+noFcJNGAElzMIeu8bdhwqaVt8zIds0cpfDT5nhLeoG88syr/DTv77hAPYv?=
 =?us-ascii?Q?BmU9aqbpVHvUo60EV6Ej57d4E0auSGHurSb5RGf0I2kJmsxC7VaQQjvLFR0B?=
 =?us-ascii?Q?cwRilpmWi35s2yQUKtMPXZfhx14b5r5nev4aS7d155F7grYF0XOgbwP8sS7Q?=
 =?us-ascii?Q?iv2Y21j6BhI+pD56OzMFL5p+BZMcr8DaAMn2uM6qbva5VmCiaosUioKZ3IzW?=
 =?us-ascii?Q?ATznMq/9GkeEp1sPoI7DJ69zo3Za6t8/Vffv6LGN/KS1YMuQhwbyM3RHRU34?=
 =?us-ascii?Q?WjqDtqOwqbdtFmSIs5bp0AJFFcXYKYIwABvLKQSd3UslEEqC7Q76lB6zbElH?=
 =?us-ascii?Q?Ve7u72qy/1box79EpFQqJVidv+C9GPdqiKMZJMOe4gw2WU8ce/21Wnj7vbpf?=
 =?us-ascii?Q?yKNfth6tfDWjaX6S1h3rhPm3bwSfR9t0G6dCqqaqRLru28X0ys1SzRXbSxC3?=
 =?us-ascii?Q?k7f0BuOSGte7uXtdHAYoFMjPKYiWUX/LK+XiCChKMYgmsOWpj25gIoGUodu4?=
 =?us-ascii?Q?/UEdzUH0rOt1Oht3Eb3jJBs+v3BTPyDiSq51Rcd4MZT2SfMqXuQZwNtHLGrn?=
 =?us-ascii?Q?CubVEKTClam9NTzV0DHvqeAyH4FmCaRSqy0at6JV6n4ASJX+0w/PtaEuW/1f?=
 =?us-ascii?Q?6yAedyOwBZNoNuZWEINIhb0HmIXhZEoNWZakgh91xnQFAzeo6upE1H1Cp/uL?=
 =?us-ascii?Q?B7UidbCYlAEtkaRnpwiArU/LhUVvSlEApGv4nU1vUC5JYVASJ0Hzz+KOk9lH?=
 =?us-ascii?Q?BFENULCMKDaXLlAnmUN3EmhUIe9eyIqAHZfHB+vcuKktHq83GWqzcxM/3gxF?=
 =?us-ascii?Q?kOy9hvfgHwGkAKPpPTdBHEG9smv2XA0d26B9xTAhn5hvpLQDDHeBG6bTvesO?=
 =?us-ascii?Q?qgHNXkhQlDtgCYyWeNiAlIC3uIsbOaof5aaeYQi7H+ZLsSqJko17ShohRPy9?=
 =?us-ascii?Q?CB6qUMv20l2CaFOjTbBBjCVUrLFAX1gMjBtPMyEzsyIQzxpkBivgzxWoTeSl?=
 =?us-ascii?Q?oWMo9XlbfqmtH16OKS/j3auF5iOIVTXmcF3KaPpRupG3DGBpFchc+efqBpWx?=
 =?us-ascii?Q?sLYV7Z35dAODCIXkz3FTAEDnI/uy4uhpWOiiK/B5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40598dce-45e1-4ada-1267-08de0b137b66
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:19:04.0373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmClF7FKp1IzHC7kmQw38lUQdL2UJOPELGWtbw2g6LOS7pyJnQUc+DMaSDFt4qYqSFqMwiPVKlsDs3d1W72DTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128
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

The XSPI SET GMID command is used to assign GMID ownership to the
requester, allowing access to protected XSPI control registers. This API
must be called in SPL if XSPI GMID-protected settings need to be
modified. Otherwise, XSPI configuration depends on the previous GMID
owner to provide the correct settings.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  2 ++
 drivers/misc/imx_ele/ele_api.c          | 28 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index 64b243dcaaa..09511a7e0d5 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -47,6 +47,7 @@
 #define ELE_ATTEST_REQ (0xDB)
 #define ELE_RELEASE_PATCH_REQ (0xDC)
 #define ELE_OTP_SEQ_SWITH_REQ (0xDD)
+#define ELE_SET_GMID_REQ (0xE4)
 #define ELE_WRITE_SHADOW_REQ (0xF2)
 #define ELE_READ_SHADOW_REQ (0xF3)
 
@@ -160,4 +161,5 @@ int ele_return_lifecycle_update(ulong signed_msg_blk, u32 *response);
 int ele_start_rng(void);
 int ele_write_shadow_fuse(u32 fuse_id, u32 fuse_val, u32 *response);
 int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response);
+int ele_set_gmid(u32 *response);
 #endif
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index 661f70cf870..e194091fa9d 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -794,3 +794,31 @@ int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_outp
 
 	return ret;
 }
+
+int ele_set_gmid(u32 *response)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg = {};
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 1;
+	msg.command = ELE_SET_GMID_REQ;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+
+	if (response)
+		*response = msg.data[0];
+
+	return ret;
+}
-- 
2.43.0

