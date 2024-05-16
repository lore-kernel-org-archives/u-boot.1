Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E1FC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 07:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E2538811C;
	Thu, 16 May 2024 09:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Fb428O3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E68487FED; Thu, 16 May 2024 09:53:34 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B62958704E
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 09:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTzleAu3wiv/h2FpeL3udI91yQ5xanY5y9q1k8LC9f3PQm5vJm47r13YD55Sds1HAMLePyRzXXWFXZsN5COHtr2oLkBjfR+1y19++y03kKsgkp/JuHR/bkj/GT0Y6Zh0dkL3mzDF8VZbbuGBjpbJN3RXahtvI2I0OmUGtXLUILBCzQHWZ+KVix+ur5HoiFysPoLqysZW3y/dJhdYfjwL5OgcTHdE17/OsINA13hjdLMjBeh6xYNjDsWNedOKcRW7xFkpAAS77JXyw69mTtTQWipUk3GINJ70mJtmnP9g+ApsmO45WZnjwgRAW3Kd23gmv5z5jTqU5yBNwU3TqwzUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYIuJg/vHiMjFlOiAxTJu7frBw13pK5j60xPvyl9ky4=;
 b=OneoWqIqBTV3snfVAotBbbVAk84bzRz5mUredHkvCVf+vLlQsRoLiS5G2opFCv6d0mHEhZQ1lqomCZH9l2SGScDjMDFWPXINH47rBfjkwMrpixuD37Gs+fIyBqMvUPccajs8uKnLs/hWZmMpPMn3AmDAEYBYPHaERUtSrXYXBi8ewqW3aKMV5cr1eeZeyPQ2R82+ybsS4XulbtrCPicME1CEaaaaQhmoJvPSsHjYthszp8Wnj3GVnoGPP14pkOfDH+Qb0oin3qYhXmzdansabYKVhyzFMSczuGRItwGVcMp5noDLRcesp9oAqkWQs9VQcs1BLtj6W6FwTaVxkV4R8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYIuJg/vHiMjFlOiAxTJu7frBw13pK5j60xPvyl9ky4=;
 b=Fb428O3JtserL/7bEiz1olRY5vb5Qa4JqUkk5GoMyczM8Ki6kZoUbOa95kGN/eaSMYGPaLpkBOFi+npG6AAR7v9BNAKYfwA/YYs8Rk6Cv+NRaeH7+btoug1CMzONlPcr+iJJ/q5YRISMJ4PR0m5BfqYYC5sGn+sF4ARuhjWU0M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 07:53:28 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 07:53:28 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 3/3] cyclic: make clients embed a struct cyclic_info in
 their own data structure
Date: Thu, 16 May 2024 09:53:14 +0200
Message-Id: <20240516075314.1548051-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
References: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 547f7a4d-36aa-4613-2a6d-08dc757d45cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FViYtGdGPJ9uySHx+wv7x+SaadSi0s43UH4R441Z+puV5Cr7flOqLpN3adTT?=
 =?us-ascii?Q?533QToWep0pk9nLp6oniJZ5r0IJ08MCkC9vWdUnw6LuhcWRf8Ov8UHFipA3i?=
 =?us-ascii?Q?1MwvnVzUQwg+/A9lQWOaiWiq0okWFpB0RYQ/lotI35cUa58uxQ3Fln282/8U?=
 =?us-ascii?Q?HGd2YURvxDrR19TMGMDQk5omY2OypdOY+ng3BZYLxFGJAUOV6aei3TFNlVe9?=
 =?us-ascii?Q?4KLd2HKBZRJP2DH5R1tUHtFUEPt+S8UzOBbmWbnDkR9c/yJqnun6MKsA3ciz?=
 =?us-ascii?Q?tF9ceg9e4TqOazmue4Um0IPpvp8RQNXmIqhW6+obSdAPIntD50T8YAitUmSW?=
 =?us-ascii?Q?YlJJ9LNI8MbW+SKR8WC6pEmd22DQRoDVBlVJ9kLykgQgJgZiiyZki60IAebq?=
 =?us-ascii?Q?jbXpy/XhWjO03EpQav0hJh/qiuSF2NfE9NSwFxHJlA7oZL4B3VoXHCqFMBam?=
 =?us-ascii?Q?wCLwLtfmJ+xYh4GIyL9E52nS2yXAzBB+iwHz7swJBa696gbAnmoXg7RDP9FW?=
 =?us-ascii?Q?e6TBdbMY7WpN+xHic7c40CdtqGyjBOaTO/K7wFfy8c6cPZOAGZJT2DT2/FFs?=
 =?us-ascii?Q?L8cclXB0IomllpIKf2fXfPZvM/Cg7l2VLqOmlFaF77UogPtUtAxNQOt5Q31K?=
 =?us-ascii?Q?jeeIdQd1t+3d3PdF1coGmoZo8r40HR4TurydsuEWy36TL8pgWKFH9yWB4/WH?=
 =?us-ascii?Q?ecvG71Ki0gW4OKy3BPog1PEIA/JsR//SWTYYx4BsbMsAG/UxDnw4zCpQzAky?=
 =?us-ascii?Q?bswjI+VE1m0hbaZ1ruLyac6heGk9wcmWt8GORy472DMQYXuPCPnnCxD6LEtM?=
 =?us-ascii?Q?cQ8bwwFbm//XkCHDqJJMlhypglHn/MsbSTZcF9qGGUtobGmXBJhQp82VWbzZ?=
 =?us-ascii?Q?SsUaCrS+LcIWUBm/r4/sPK3xlSISlpMpkEHfYyMug5XxeWwgtvQBu96GvAE8?=
 =?us-ascii?Q?J3DJFoQ88DQxkfD6d4M0CldSWbNUO8GSoi6+QtZ7fU7QDUNRlZNOGe+dEJei?=
 =?us-ascii?Q?ND7UhfHu9IA2swaW5CXbvipp7TpQUCG3JyU39pifWQIkxhdhzmFXq7VuSI1V?=
 =?us-ascii?Q?Xh/slmDGhIkjZikojFKsGgwQWRaMiCBfTZVhhG4i8cJMjQActbsdSmRG7ZlO?=
 =?us-ascii?Q?1LtaHHP9WfheF+HlAvsQpq3lYS8v8l1kDvWTQbTqpd8fM+05JpmKIpVtUkp5?=
 =?us-ascii?Q?mcJv5STKtG0pqiRN6EUQFZUdAiUz5chJ7JIMmz24OcF3xB613xduAOLfZRF1?=
 =?us-ascii?Q?qJzQCopYsPFxbonl78M+BWQJU618+9vZREGIA4j9OA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7zwhkQTvkcp0SRH+F9SWuxyM/1eVglYGjvJOagictEU71zRnAZePiCTG08dg?=
 =?us-ascii?Q?Vwe6Io5tILmvXlmqFTH3lmfTB9wkqCXiCpPOd9RhzKYDRclWf56qKQCdGJ9U?=
 =?us-ascii?Q?ie/Rs+9GtPEGk6sHNYuZl/8/X8hmyAwT+OmVX9aVpDUdeBXaPYslWoccB+sp?=
 =?us-ascii?Q?cFLcbYikvV0crX7pzpAJsn7LeNYB0vOe+Aj5sIVOrOKj5YxZ0gdVRZidUN6c?=
 =?us-ascii?Q?WEb8RwRKc7kzkDjKfvak/4QCDkRyteLEhFvbhGr1oo9XsyXUdkQhXdz0+tT6?=
 =?us-ascii?Q?3mcre0r4xxe40QZokc87Rz0yPfRK5ES9g8R7v0hseoMSNIomI3UtDNZPKi4z?=
 =?us-ascii?Q?M/cp1x0duXAdpGdznA6+zo8lk956Tou15SeHz4jWxnPVoLYdpDtKCSI6MUdb?=
 =?us-ascii?Q?n5zjOU4DAUQFdrBUjzkasrGfKj1BT7KamqaCJBVxord83zJ5PTiEBRPGH/Ck?=
 =?us-ascii?Q?h1MqpATFoZmYIi3kARJuwJbqwFB0HW+4MB0Fy/Bvu1/ujRzBGdyRKaWMCOis?=
 =?us-ascii?Q?AZFPvSB4RG1+DLa4yR/aDevzUcmRPt+YK3BYCvOFh4DREoQMqfmd3p0J2KyB?=
 =?us-ascii?Q?gdOJFKVfuZVUK0S7PC6dX5QSALEZIYCDaaoqSfMel4UCjxHdzMx7+x9v/MIK?=
 =?us-ascii?Q?0TsdtanXX6Xwz5Yq8aiOx9TXwNfkFYYptzFWBVErwGejOdO0Z0ajacJxPyDp?=
 =?us-ascii?Q?oj2RAwwNBLusmewxSQNLkMOnLZlkn9BbqT3xUUpmfRGLec2Bn77eJgvYC9Tx?=
 =?us-ascii?Q?EW3eRgfHohsfy9of8LjFTBPsy/Ivj6U96AaW3+fIDG0jM0fmsIDTNYQbzMI7?=
 =?us-ascii?Q?/m1Ol7wHlC5Z60uWLGJMJarX7nFZOr+Np4N/0LXzjDRd6OFmvIp8URUZWRkQ?=
 =?us-ascii?Q?gfTjlXknLwTkBpV39nBK5CR7Jq7BUXZfll6aNC6zV9aaYB6PvLeoTNPZHMHb?=
 =?us-ascii?Q?j/kblLUorvR++QNW/5OHAyZwUsd/tnHjPkVkJw+314/tohHa6InGh8naHAT0?=
 =?us-ascii?Q?tHdCT7FK7x5dbejkuYoQ9gzviIYH1K2fpVzF1j2YS4fNrTu9jfC4xQpoUvbE?=
 =?us-ascii?Q?/GEY8l7729tXMo1u8FNq6+qyRQ+O3u284PhHgJW+fWCLfAzNhRb4m//lAsop?=
 =?us-ascii?Q?V4lzOlw4JllYOmG9M2U4SwYZE77HZTGw1I0zOBD7L0G1xChV6iavybVmlscs?=
 =?us-ascii?Q?pIDEPmc/V5MnyxPcWWahxVNT5MWhqJWXn4VybSDPUAyFEbs75f2lrpjZ2wa7?=
 =?us-ascii?Q?bfEVgeJAWBO6PsZG2PKX0WAz3BPu236j7f2IzPy0d91NPdSZnEG8HmubeVtO?=
 =?us-ascii?Q?os85MSF3P2gDrYQ1Fd5IzvQM4YTD9uZxKzudh7NdRIh2qhoRmP+z6qyOSgT3?=
 =?us-ascii?Q?LugQ9FNrBQg3knZShbp3YhLJ3BDcFqKDdmruf8Bqk4LkU3GWOi//p4SWT2k1?=
 =?us-ascii?Q?SKkXtUbPirgDI+kqbPABeJmoHsRL9QpXE1zTQBeLewZr30nPsJPLP6QKYh5i?=
 =?us-ascii?Q?6Bud+QBrB/lNx15U9g2AkuN2JnvYckcHf4FE0z6lgdPIzbD7lbCFofoH54tj?=
 =?us-ascii?Q?85GnjUnLnB4dqQJO0n2JyJj5Ka8BVxuo9AA7uVHX4Gh8mAbthBPs0kkItaMY?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 547f7a4d-36aa-4613-2a6d-08dc757d45cf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 07:53:28.3882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gC//07QRYAFImTjuxFvP6A4plAP6JTUwPsAfWgiOnVEr+5aF9R8H6bGRhncPuTxje76StkiMgiSr9p1w+iSrEMo21w5svW5RgGcyVVS1jIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6752
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

There are of course not a whole lot of examples in-tree yet, but
before they appear, let's make this API change: Instead of separately
allocating a 'struct cyclic_info', make the users embed such an
instance in their own structure, and make the convention that the
callback simply receives the 'struct cyclic_info *', from which the
clients can get their own data using the container_of() macro.

This has a number of advantages.

First, it means cyclic_register() simply cannot fail, simplifying the
code. The necessary storage will simply be allocated automatically
when the client's own structure is allocated (often via
uclass_priv_auto or similar).

Second, code for which CONFIG_CYCLIC is just an option can more easily
be written without #ifdefs, if we just provide an empty struct
cyclic_info {}. For example, the nested CONFIG_IS_ENABLED()s in
https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
are mostly due to the existence of the 'struct cyclic_info *' member
being guarded by #ifdef CONFIG_CYCLIC.

And we do probably want to avoid the extra memory overhead of that
member when !CONFIG_CYCLIC. But that is automatic if, instead of a
'struct cyclic_info *', one simply embeds a 'struct cyclic_info',
which will have size 0 when !CONFIG_CYCLIC. Also, the no-op
cyclic_register() function can just unconditionally be called, and the
compiler will see that (1) the callback is referenced, so not emit a
warning for a maybe-unused function and (2) see that it can actually
never be reached, so not emit any code for it.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 board/Marvell/octeon_nic23/board.c |  9 +++++---
 cmd/cyclic.c                       | 12 +++++------
 common/cyclic.c                    | 22 +++++--------------
 doc/develop/cyclic.rst             | 26 ++++++++++++++---------
 drivers/watchdog/wdt-uclass.c      | 33 +++++++++++++----------------
 include/cyclic.h                   | 34 +++++++++++++++---------------
 6 files changed, 64 insertions(+), 72 deletions(-)

diff --git a/board/Marvell/octeon_nic23/board.c b/board/Marvell/octeon_nic23/board.c
index bc9332cb74a..74b9c741b7b 100644
--- a/board/Marvell/octeon_nic23/board.c
+++ b/board/Marvell/octeon_nic23/board.c
@@ -357,10 +357,13 @@ int board_late_init(void)
 	board_configure_qlms();
 
 	/* Register cyclic function for PCIe FLR fixup */
-	cyclic = cyclic_register(octeon_board_restore_pf, 100,
-				 "pcie_flr_fix", NULL);
-	if (!cyclic)
+	cyclic = calloc(1, sizeof(*cyclic));
+	if (cyclic) {
+		cyclic_register(cyclic, octeon_board_restore_pf, 100,
+				"pcie_flr_fix");
+	} else {
 		printf("Registering of cyclic function failed\n");
+	}
 
 	return 0;
 }
diff --git a/cmd/cyclic.c b/cmd/cyclic.c
index 40e966de9aa..339dd4a7bce 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -15,14 +15,16 @@
 #include <time.h>
 #include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
 
 struct cyclic_demo_info {
+	struct cyclic_info cyclic;
 	uint delay_us;
 };
 
-static void cyclic_demo(void *ctx)
+static void cyclic_demo(struct cyclic_info *c)
 {
-	struct cyclic_demo_info *info = ctx;
+	struct cyclic_demo_info *info = container_of(c, struct cyclic_demo_info, cyclic);
 
 	/* Just a small dummy delay here */
 	udelay(info->delay_us);
@@ -32,7 +34,6 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
 	struct cyclic_demo_info *info;
-	struct cyclic_info *cyclic;
 	uint time_ms;
 
 	if (argc < 3)
@@ -48,10 +49,7 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 	info->delay_us = simple_strtoul(argv[2], NULL, 0);
 
 	/* Register demo cyclic function */
-	cyclic = cyclic_register(cyclic_demo, time_ms * 1000, "cyclic_demo",
-				 info);
-	if (!cyclic)
-		printf("Registering of cyclic_demo failed\n");
+	cyclic_register(&info->cyclic, cyclic_demo, time_ms * 1000, "cyclic_demo");
 
 	printf("Registered function \"%s\" to be executed all %dms\n",
 	       "cyclic_demo", time_ms);
diff --git a/common/cyclic.c b/common/cyclic.c
index c62e7fa7d19..ec38fad6775 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -26,34 +26,22 @@ struct hlist_head *cyclic_get_list(void)
 	return (struct hlist_head *)&gd->cyclic_list;
 }
 
-struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
-				    const char *name, void *ctx)
+void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+		     uint64_t delay_us, const char *name)
 {
-	struct cyclic_info *cyclic;
-
-	cyclic = calloc(1, sizeof(struct cyclic_info));
-	if (!cyclic) {
-		pr_debug("Memory allocation error\n");
-		return NULL;
-	}
+	memset(cyclic, 0, sizeof(*cyclic));
 
 	/* Store values in struct */
 	cyclic->func = func;
-	cyclic->ctx = ctx;
 	cyclic->name = name;
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = timer_get_us();
 	hlist_add_head(&cyclic->list, cyclic_get_list());
-
-	return cyclic;
 }
 
-int cyclic_unregister(struct cyclic_info *cyclic)
+void cyclic_unregister(struct cyclic_info *cyclic)
 {
 	hlist_del(&cyclic->list);
-	free(cyclic);
-
-	return 0;
 }
 
 void cyclic_run(void)
@@ -76,7 +64,7 @@ void cyclic_run(void)
 		if (time_after_eq64(now, cyclic->next_call)) {
 			/* Call cyclic function and account it's cpu-time */
 			cyclic->next_call = now + cyclic->delay_us;
-			cyclic->func(cyclic->ctx);
+			cyclic->func(cyclic);
 			cyclic->run_cnt++;
 			cpu_time = timer_get_us() - now;
 			cyclic->cpu_time_us += cpu_time;
diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
index 67831496a70..893c269099a 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -19,20 +19,26 @@ Registering a cyclic function
 
 To register a cyclic function, use something like this::
 
-    static void cyclic_demo(void *ctx)
+    struct donkey {
+        struct cyclic_info cyclic;
+        void (*say)(const char *s);
+    };
+
+    static void cyclic_demo(struct cyclic_info *c)
     {
-        /* Just a small dummy delay here */
-        udelay(10);
+        struct donkey *donkey = container_of(c, struct donkey, cyclic);
+
+        donkey->say("Are we there yet?");
     }
-    
-    int board_init(void)
+
+    int donkey_init(void)
     {
-        struct cyclic_info *cyclic;
-        
+        struct donkey *donkey;
+
+        /* Initialize donkey ... */
+
         /* Register demo cyclic function */
-        cyclic = cyclic_register(cyclic_demo, 10 * 1000, "cyclic_demo", NULL);
-        if (!cyclic)
-        printf("Registering of cyclic_demo failed\n");
+        cyclic_register(&donkey->cyclic, cyclic_demo, 10 * 1000, "cyclic_demo");
         
         return 0;
     }
diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 12850016c93..e2e7f9ab84b 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -17,12 +17,15 @@
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/kernel.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 #define WATCHDOG_TIMEOUT_SECS	(CONFIG_WATCHDOG_TIMEOUT_MSECS / 1000)
 
 struct wdt_priv {
+	/* The udevice owning this wdt_priv. */
+	struct udevice *dev;
 	/* Timeout, in seconds, to configure this device to. */
 	u32 timeout;
 	/*
@@ -40,18 +43,17 @@ struct wdt_priv {
 	/* autostart */
 	bool autostart;
 
-	struct cyclic_info *cyclic;
+	struct cyclic_info cyclic;
 };
 
-static void wdt_cyclic(void *ctx)
+static void wdt_cyclic(struct cyclic_info *c)
 {
-	struct udevice *dev = ctx;
-	struct wdt_priv *priv;
+	struct wdt_priv *priv = container_of(c, struct wdt_priv, cyclic);
+	struct udevice *dev = priv->dev;
 
 	if (!device_active(dev))
 		return;
 
-	priv = dev_get_uclass_priv(dev);
 	if (!priv->running)
 		return;
 
@@ -124,20 +126,14 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		memset(str, 0, 16);
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
 			if (priv->running)
-				cyclic_unregister(priv->cyclic);
+				cyclic_unregister(&priv->cyclic);
 
 			/* Register the watchdog driver as a cyclic function */
-			priv->cyclic = cyclic_register(wdt_cyclic,
-						       priv->reset_period * 1000,
-						       dev->name, dev);
-			if (!priv->cyclic) {
-				printf("cyclic_register for %s failed\n",
-				       dev->name);
-				return -ENODEV;
-			} else {
-				snprintf(str, 16, "every %ldms",
-					 priv->reset_period);
-			}
+			cyclic_register(&priv->cyclic, wdt_cyclic,
+					priv->reset_period * 1000,
+					dev->name);
+
+			snprintf(str, 16, "every %ldms", priv->reset_period);
 		}
 
 		priv->running = true;
@@ -162,7 +158,7 @@ int wdt_stop(struct udevice *dev)
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 
 		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
-			cyclic_unregister(priv->cyclic);
+			cyclic_unregister(&priv->cyclic);
 
 		priv->running = false;
 	}
@@ -262,6 +258,7 @@ static int wdt_pre_probe(struct udevice *dev)
 			autostart = true;
 	}
 	priv = dev_get_uclass_priv(dev);
+	priv->dev = dev;
 	priv->timeout = timeout;
 	priv->reset_period = reset_period;
 	priv->autostart = autostart;
diff --git a/include/cyclic.h b/include/cyclic.h
index 38946216fb8..dc0749ba03d 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -18,7 +18,6 @@
  * struct cyclic_info - Information about cyclic execution function
  *
  * @func: Function to call periodically
- * @ctx: Context pointer to get passed to this function
  * @name: Name of the cyclic function, e.g. shown in the commands
  * @delay_ns: Delay is ns after which this function shall get executed
  * @start_time_us: Start time in us, when this function started its execution
@@ -29,8 +28,7 @@
  * @already_warned: Flag that we've warned about exceeding CPU time usage
  */
 struct cyclic_info {
-	void (*func)(void *ctx);
-	void *ctx;
+	void (*func)(struct cyclic_info *c);
 	const char *name;
 	uint64_t delay_us;
 	uint64_t start_time_us;
@@ -42,28 +40,30 @@ struct cyclic_info {
 };
 
 /** Function type for cyclic functions */
-typedef void (*cyclic_func_t)(void *ctx);
+typedef void (*cyclic_func_t)(struct cyclic_info *c);
 
 #if defined(CONFIG_CYCLIC)
 /**
  * cyclic_register - Register a new cyclic function
  *
+ * @cyclic: Cyclic info structure
  * @func: Function to call periodically
  * @delay_us: Delay is us after which this function shall get executed
  * @name: Cyclic function name/id
- * @ctx: Context to pass to the function
- * @return: pointer to cyclic_struct if OK, NULL on error
+ *
+ * The function @func will be called with @cyclic as its
+ * argument. @cyclic will usually be embedded in some device-specific
+ * structure, which the callback can retrieve using container_of().
  */
-struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
-				    const char *name, void *ctx);
+void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+		     uint64_t delay_us, const char *name);
 
 /**
  * cyclic_unregister - Unregister a cyclic function
  *
  * @cyclic: Pointer to cyclic_struct of the function that shall be removed
- * @return: 0 if OK, -ve on error
  */
-int cyclic_unregister(struct cyclic_info *cyclic);
+void cyclic_unregister(struct cyclic_info *cyclic);
 
 /**
  * cyclic_unregister_all() - Clean up cyclic functions
@@ -97,17 +97,17 @@ void cyclic_run(void);
  */
 void schedule(void);
 #else
-static inline struct cyclic_info *cyclic_register(cyclic_func_t func,
-						  uint64_t delay_us,
-						  const char *name,
-						  void *ctx)
+
+struct cyclic_info {
+};
+
+static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+				   uint64_t delay_us, const char *name)
 {
-	return NULL;
 }
 
-static inline int cyclic_unregister(struct cyclic_info *cyclic)
+static inline void cyclic_unregister(struct cyclic_info *cyclic)
 {
-	return 0;
 }
 
 static inline void cyclic_run(void)
-- 
2.40.1.1.g1c60b9335d

