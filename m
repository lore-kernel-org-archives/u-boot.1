Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E86CAC5AC
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 02:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE567833E9;
	Wed, 24 Sep 2025 04:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KNEssOAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A651833ED; Wed, 24 Sep 2025 04:11:55 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD83E80107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHUUwpfdP5Txy4VOJbHTsBjTF8PhpvRJFpd0wA1M3CYPzorXbAWYhhXF84iqTBoE2vg0if/Z+nr93w1sXIj/fOiCSv8wi56MBpo85Ay7CNS6S53nXaTWBwH7A2S8L6fU4FwWkexJj5n5A4bk8hd5Vl9BimhgSBL6+z7SOarGFsqNLEjDgX3KNdfiA0EDiRbR4p2pWSdlq7wT9BAQRwfb2cldO9yY1RqnVYNnfJJA8rX84Bdj6gklrpm2aDcH53SVgvzYLgR5Yi5ew8mgkfvgxuePLaY/2E1I3ip4nKd4zaPyEfvVzBvR+COZJEl94FD7Pumb+siYGhNSdiU4wgni8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PpAk0ucK5/cHVTy06nE7XgzHxA57LjwT4xswbfuJGU=;
 b=ny2uCwB6IbTl56OE/Mt9OjjTyajDYKyAoDFejr6kP1UlTP6urDj7OKGNTf5ISRAH4h1PWH6yx7uuTj2XKJ+HYU0C8lDHgL+YHyoL6WDgaIFr2re/NXNrfFA8e4n2CBgf8gjPJMJISWiE6brl7jQK5b0L9MSwkfA4XnfXdofD9hjhkjleEsWaf9Y/XUYSJ5d2LiLKZ7FVYCLS9IVBqESaCfxZYeJcEmR7xeOE3RX9s9iF0DRbhs01EtWv1WYu/3zsdiw1px1wr0TKByEp2U8NtxLHl4cQeqUv+zwLYX24myXRMtKw6MU3LThsWYD2VFbS4tYys+qu92yXybndBnHz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PpAk0ucK5/cHVTy06nE7XgzHxA57LjwT4xswbfuJGU=;
 b=KNEssOALbb0Ew08oZuns4MLfEQTqTDXw+XfIRtb+cWIydGMNAvy5KOIGM7Usg3Nt8ThYfXSe0USGY8CYS4m3/1GqzKAyPSGF88NUGpHm2WzEFjlp46/YjGJXqwurh+k9cF/h3JROQbv337yIJ8FOxlaRL4g06fhkkLSHUA+nun9QmtgiHu+7y5AbspPZFQUXh0okls0JnVFH2NH3+88LA1WyFMRUZS3kn9p8G4DF2nYt83Ok9Aq3A26M7AQ6owc0PZzKq3umm1dIG5zHSqNl242iq2TlNXNoTPQcJzGedhumouGLuw+4WFhaciAxol6igOrnyPe4vTu9K5wytfK8GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 02:11:50 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 02:11:50 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH v2 1/4] spi: nxp_fspi: Use second last LUT entry for AHB read
Date: Wed, 24 Sep 2025 10:11:24 +0800
Message-Id: <20250924021127.2866184-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: acd8397a-1eaa-4cd8-89d0-08ddfb0fb879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E0Kit5V/pEQiW9+whba4Tib/huku6nVXmgJiDOdXJaYsybonlWAEoIuYrG7M?=
 =?us-ascii?Q?Rr9P10B3uVhzJhPeD8RzuSiU2QbiDHmUcfROPbFrEzm38UZemlz/3xBZNa6a?=
 =?us-ascii?Q?chbBb1omz3te77HhKP/CuzKgyiC4Y18AnZgLiw+vo+3Dpn91pvUgzo+PYiLq?=
 =?us-ascii?Q?GV1fZZ1xeBuJAraZ79u+WS0HuzZ/s0r/o0l79gIZfQFbW/OMSVxW+lMVbMv9?=
 =?us-ascii?Q?cSDXNFDpNM3BhZsyW+mIm7yuHSQUUyX+YM030kW8x6WfeKh8bdnuCg6N+TK/?=
 =?us-ascii?Q?NPWx8obH6m6eSGMa0Va+wBX/MFrhXWQnR9fcqJQVv6b/5H3+A2X4dIeHnTu3?=
 =?us-ascii?Q?gFG9MLS9G0bASV2jRzw6K49xd8t+8oDIKLYJh73oZ5O4khcgSwMHi853Pydo?=
 =?us-ascii?Q?Gc2GAIILYUlLjCvETG6ckvPpbrdDSJRhglvUiT5TLzXcP0ihloXtY14lqe7a?=
 =?us-ascii?Q?sUxOUAZYuKR8f6e6AptHc76K8ignuW3k5hAk12e+MivixPBwI9s7JBN5Uy/3?=
 =?us-ascii?Q?1/WCYMDZ87H8/TBrC/lkYBax9xCHInE325b0iUiyvlSPvh9X6ieGk8xvpry8?=
 =?us-ascii?Q?7uLastJuOIH+tkCM7RNfksBVe0fh1fd6MTAWRWOlnIWFqaUBDmHESUsI9WZb?=
 =?us-ascii?Q?BrRSuh9VOpbDIu1vX9Bj+m50mee/D2zVzbwED9F5l3EBYIoPu9yMk1Q1gchL?=
 =?us-ascii?Q?uXgajwoOYBbz3Q9lPiFqKyCYgPJccSG3b3mAwDpa94U2WR2rTbVckVIme5D2?=
 =?us-ascii?Q?mc7QFDsCkFKTEMsV1G2jaj6x+P38PEOk+S4GZ8cgG/bUcB3QzQFI22NENRBM?=
 =?us-ascii?Q?vUI0sTMhNh1eJfzX4GwwMBMSdjOCGmq7AehOdovP6gDrNjTSj+QtjFEYIN4y?=
 =?us-ascii?Q?/iSf7LMA8FYM4PH5PWtFUpT4keWUhcwAvkMiHXRXO9tSimrZVbxkIzjzF7oJ?=
 =?us-ascii?Q?mj5CVe1U8hgoO/xEkGMzgJG4a7Atshra16chxcxaoazCKdaHnVJz28KdQ9QO?=
 =?us-ascii?Q?/sGCJrnT5L3vtBFwaFnmOdAI6QWlB7+0uugPZwtMkVAnBcAwsPgJPNUrUfGz?=
 =?us-ascii?Q?baJ8op01jaQ04VWWKMAH90XIYsgwmwn54aqIfTzQohlIsLPa0jSlWDAmmpSQ?=
 =?us-ascii?Q?WlPzTmY4Uz9Br4gedZdhg+cxfWzl7mhr0ewQyik2XDwlbzA0jXRgnrVjHxns?=
 =?us-ascii?Q?h4VGcHiM5MLOPiENHSWvTQB2tUoxQO4NbLteuUuOutoieOKt5r5FX22eTfkv?=
 =?us-ascii?Q?2VwpvaWV3yRHIXV6Z7BXW1LjtWbWNdRYW03j78qOCsz+SZU8epuezpsJyxZy?=
 =?us-ascii?Q?FO/RV7qgoahjb7jHZyiHwM5vmbCzdOEAD7A5o60VCNiZJX4d/S4Y42y45zZw?=
 =?us-ascii?Q?hWD25jk3WsPsrP8ulU0q0A13jd0FZXMdO5oL3jznKtJtlkp1CNCwv1KdZtAt?=
 =?us-ascii?Q?4wZrg3ev3LTUAf3OiKI+icf3+/ieTJd5EAUzoWZhxt8aqkJPDFi+AEKFLegY?=
 =?us-ascii?Q?SQkvbLFVHmWKRSE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cxHcNHiLcpM4Qw/OIYf8kLIHJkjQLkOGR8VOGETVf+2V4s55iRjJW0Z+33qs?=
 =?us-ascii?Q?Roh33Dlpw01/109g/jWrLBFgRZtJOpnj7f6AJGG7znOT3NCxVjzmbiAkzVoS?=
 =?us-ascii?Q?ndmeMeyB9QQZnBRmwZWQmcBwMqWKwywqeg7sYEbeONEh0Hrx8Mai3uuKc3dX?=
 =?us-ascii?Q?cG0Noxdz1qo7AlVba5XCMgJ+enA7gDkGXceGMfi21odEBvFmKtLYBELphEot?=
 =?us-ascii?Q?1rr5qlsrS56qXsbRHzGGWGOQLldYxIjcXyxCF/C878/iBq9fZTUUgkfOKH3L?=
 =?us-ascii?Q?7KR4/GZjdOdHVT793yHMwF6Snn9WiACR+3zNVfBsmdqN1ARDU9PycI3JAw2K?=
 =?us-ascii?Q?DJDG0tKmMWusyufqv0Nj1ODLAXMTKbCEYUHvkwVvuyB0P71UP0u3AfetmdJh?=
 =?us-ascii?Q?H18ejJVmH7J1WF/4OUouRWsDFaxccCTKW9/WNdm53UBX6K67VrjGxeWrXbvz?=
 =?us-ascii?Q?pStWm628aeeMwHjlS6adTyWhptTGgEEvc629yvwSV5fpubhs0sAYyh6VBTme?=
 =?us-ascii?Q?gBv/0YTHnZTiabqmjuJL1DMmpXOLAFKdcOl/bzx6000vImb4SlWkNZWIVg7Q?=
 =?us-ascii?Q?WvgLHu/Holum/qnlKJF1kPoEYgIcvSv5c/1HWu6llYI23NagsMZP+WZYUaLM?=
 =?us-ascii?Q?ZH5k/eeolZwSzNAdnHRfEMjzVlcY+/gtskrPD4oEkHjWHZZan7MThinLrOpT?=
 =?us-ascii?Q?GJz6iQWmkK/JyaIkS7aJVpocrftBB5EJBZ41Ny2I3Q1WTCmrQghd+bzHY6nC?=
 =?us-ascii?Q?Rjzp5JPnB4dUfccvMRJgFdBlnVrt6r7uwSQYAQ1S5oCqnk3D0HHfWhNVoP5A?=
 =?us-ascii?Q?Mb46eeOtjXz9SW1ByzLQcFmGSfYuZA/Na30C2oclS+5kOsvF3aumZBAFni8d?=
 =?us-ascii?Q?nyu86cyIbKXyKaKX5T3MIqEkjZ1P0iZPweGeDoXjZWQkp2248PGzg98FD56w?=
 =?us-ascii?Q?TTN7OOs9G/tekpZQe8YpzCOvayFh9yrMlUTxq2brsa/mtnI14mIMpl0J3vQx?=
 =?us-ascii?Q?+ezPnqFpJ70ULH/FykZgoxlf7FCybP7rnRE5FvyaKO9PG++g81OroK3sm6DE?=
 =?us-ascii?Q?+TK72CRmQXsUkz6XnrhKj33CRH3w0p/lKuIygJP5HlUKrJO2fqAoiLLoStxV?=
 =?us-ascii?Q?oAx87Kyn6PfUgFeAPdAmGREQXUxiC2E9rUQN+GPTxS7I3hgf2FMjBTxNTrji?=
 =?us-ascii?Q?01s9oS4Unj14bE53AocSTxy1J/LJOrUbR1jo500sYYf2KLiQXsZ/FFZB0igK?=
 =?us-ascii?Q?P11bMP4e2oVoetPogh/l82UGsz9jA01mpXQ0Pt06F+F7PoFOWnh/ypAb8L3M?=
 =?us-ascii?Q?m/MO1j3l9Wy9xbf60oOeNem2OEzR67Oje7O98qE5KiXwTjeOGlCfI+wPmsco?=
 =?us-ascii?Q?6r3Fs+TOW1Y+pt3ri03caeg0XOh0B3iXSRDibyS6IEpIGtyCBRuBcxaEMH8F?=
 =?us-ascii?Q?G9KWVQYXz51Dzt5pYJFLTJAYTnMw79vvXkGPj0AEqcutm+ygehlZN7Qksl0Y?=
 =?us-ascii?Q?+MBmTMTy7+1BqRfT1ZV4GkyYfCBSt6k91aHcB+Zlkgq0X+KzS8L+fjuJIvu1?=
 =?us-ascii?Q?ol7a4aYmVbzuOfEgcD4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd8397a-1eaa-4cd8-89d0-08ddfb0fb879
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 02:11:50.0243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65Tu4UPdKjyMVRjcwEGZWAqxXvanBlzhYbLBkG6mqD9u5Xhe1ey4TT+whr25KTG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459
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

Use a dedicated LUT (second last) for AHB read command, so we can
directly read from the AHB memory-mapped address and booting M core
for XIP on Flexspi NOR.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/spi/nxp_fspi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 6d97b8eefc9..2f9abdc7795 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -539,6 +539,15 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 		fspi_writel(f, lutval[i], base + target_lut_reg);
 	}
 
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN &&
+	    op->addr.nbytes) {
+		lut_offset = (f->devtype_data->lut_num - 2) * 4 * 4;
+		for (i = 0; i < ARRAY_SIZE(lutval); i++) {
+			target_lut_reg = FSPI_LUT_BASE + lut_offset + i * 4;
+			fspi_writel(f, lutval[i], base + target_lut_reg);
+		}
+	}
+
 	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x], size: 0x%08x\n",
 		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
 
@@ -943,9 +952,10 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	/*
 	 * The driver only uses one single LUT entry, that is updated on
 	 * each call of exec_op(). Index 0 is preset at boot with a basic
-	 * read operation, so let's use the last entry.
+	 * read operation, last entry is used for dynamic lut, the second
+	 * last entry is used for AHB read.
 	 */
-	seqid_lut = f->devtype_data->lut_num - 1;
+	seqid_lut = f->devtype_data->lut_num - 2;
 	/* AHB Read - Set lut sequence ID for all CS. */
 	fspi_writel(f, seqid_lut, base + FSPI_FLSHA1CR2);
 	fspi_writel(f, seqid_lut, base + FSPI_FLSHA2CR2);
-- 
2.37.1

