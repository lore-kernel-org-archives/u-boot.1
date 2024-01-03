Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04111C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067D3875EB;
	Wed,  3 Jan 2024 11:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="K4OHSuB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A57987509; Wed,  3 Jan 2024 11:47:28 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A7986EEC
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNBeEYdrSpikr9HgrsO81P1dZWWeHCbomVfoHqW1K1XCGhaiFVe9O2SLqXOQIHHR2D84awwR4Rpod6CCTOwA67FJ9txevsJpmmGEPuKjbZyfApE6bxWlLed+kOyuFl5nFX7znK5YYm+5cy2CU8qQ84wQ8tokxiI1fohyNaU/AUsXM2Jzw+IbHZG3Oo/yRQGU1HF722E/bRM8KRDB4htZSoN0J+hwT/iS4epxEWqVioWLzDRh6091JkKiUj2E1RnroqrDvTe+P/0LBwB9ect1IOv/hkKxKbVSFn6j9ipQDJINNt8ESXeLYDHQPYCvWzksAm3JeMDQkCbtdhEpQp21HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axD2qOzY1Le0XMAAXpGbus7X5ltCBA+y43g/kJ3kUGY=;
 b=LCYGzHOA4ltL94BtrPxkyN+dRZARCxCpktFo1HjQZRotIiD2Z0M2NSjT6R+JGTPkJzQPg6NiCxZIlFYy33P56DokjmVMQMOk+29MKPPIaLASJ/DjZ1KWnHfn6E6BM01Lkyqk/hRWH+UQqVSFV2tJZs/0SBxHfVTRs/jj6H5JnjuI+vlU0KlM+zEC5QanklgLWnPngzdTiBs3hUsS4mmthh5NN4Mg3VNphPiAJUthGGLfjBK79xmscy9S24IkrvL6q39YXOL0KgLO9N4kgivOQOV+jRiYR4oY+LcKR1hOq2+XQnMQGDK8xeFeHnMqonnxsFl7Ua40fa8xmdaFGsGKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axD2qOzY1Le0XMAAXpGbus7X5ltCBA+y43g/kJ3kUGY=;
 b=K4OHSuB/ELqqct9rF7txg3ESu8Z/AkFW3J3sy+g/NL52tP16TROaN29uKTUoqBKb+QD0ACscbC3tZSSAbPNdMdaIq8rZQNfLfDyaoCJnljv8+6bEcXiWZ13rOJxURo2OdXLhCQvU847ra8n4m6fHhr02yQyij81vcYo1bBUVVBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:47:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:47:23 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 6/8] cmd/mem.c: fix wrong use of ifdef,
 drop pointless SUPPORT_64BIT_DATA macro
Date: Wed,  3 Jan 2024 11:47:08 +0100
Message-Id: <20240103104710.4185383-7-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
References: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 57568def-be3d-4176-e9d6-08dc0c495e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czBZ5jnwJsjbzhQD5R2XyJRGCyIqdULfmykx4lfd5ZdC411tbetlmmligsU8ev5406GXl/F7kt0vAW0vcY+dVaPaLJF+wo5uv1wPTApLWJiMjLsuuWHREhW0Blv9nL5AXYv1xDoKlj0TVHbbfODMGhMekr16HU5sqw8FAMAKdCTZXO9SPB9wVZjGYZ+0LsOZBeDyCpYyN/B76A6RMjmKFu6de/57Pg7R8OfSkkFTffPIp33sKSwjdQCmHmGllmhKKQQrNsu1HXnLqD/tf1G4N+B37ti5GRMvUuX7Gq6t1zIx5j4mwF2fGLhyiuAlpGgU8DLc6ao07vYwBbSKXx9nBe4nyIc3FuXNEHg2mDLZaKY0eUAXUyfjJ4PUzF7eKxiIjDDnkne/WU1fO4zcmRRTJn4LZBqa8JTD4HJ2ATIu0R++qLgKt9knP8TgqqPTTbxkZEtU413c7KxVI8HkgYi625CsDTw5aTsJU4IowG2/NfsBDDebZeny0AOfAi9WpwhncwqaUOiDiOhHuDNks3ZZtxBl+/drG9WLHC2yy8ybgzTgLR0C68JWe39nVDgQPFD5RMEYBGihmSCPRDfB4Vi+sduzTPwxfQAOf6BHrp1ReUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(26005)(2616005)(107886003)(66556008)(83380400001)(38100700002)(66946007)(36756003)(54906003)(6916009)(316002)(66476007)(6486002)(478600001)(86362001)(5660300002)(2906002)(44832011)(8676002)(8976002)(8936002)(4326008)(38350700005)(41300700001)(6666004)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTkKVkd/Oh2zpzlNcXSR22SuJ1WVudvwgwU5/UN2l56ibeuypCXeSq7EhsnW?=
 =?us-ascii?Q?W2zK/hIeWzwtiVALoy6bpPNnecWM9zAbdFA6sglStCXFudPCQAwd7tgj5sAd?=
 =?us-ascii?Q?jVT7EJKZEIyHmfDCuCKlGm/0DO6O8ffBDvRJ3vIAt0p44zvte0b9AjzImFO1?=
 =?us-ascii?Q?4UAyUCuUXaP4VZ+5jWuVtVlvMjTXs9DC5MRfq2k+FZ1cp+20K4pCIyeIXDss?=
 =?us-ascii?Q?RP3YF73pKn46qwD4OC3zoaR9JIys48ZcxSB866TZRWuJuprn0zPlL98cg6fz?=
 =?us-ascii?Q?jRL3vyeJgM45L61g37Imq9feTQrHhTu0qAcLEwvw3NGch+2SFVbPK84TGPZh?=
 =?us-ascii?Q?FTin9jhMVU+jGCyI2LjGEefOpFEsNHFh0ZcezrMbZRo892HMnZL9/8mraBdI?=
 =?us-ascii?Q?6oSnVOudtuqUuOksK5NNaYPkpca9jRfUnsfmjKfthijTYwgKUCUsiZ7vG+Gj?=
 =?us-ascii?Q?2ygiLic51ND5mQzU68PRtqnIbJFCzgA8bMg5oFhIpfAjsdADeXbHBa5pZNJG?=
 =?us-ascii?Q?IWnzp1NH6XaFgIvFsjnA80zioz8uaJz99479ZTz6zEWX+LCSAaHJqOgo/WHE?=
 =?us-ascii?Q?0xVXXl6x3TjWq19tzedidHZHkQZjwu3X+6IpRhYwwJI8geE8cn+1JFw67Yu9?=
 =?us-ascii?Q?6ckQzmFADRAaD54EAiIFC0ISSo35Z8vrsS6Zze33Hyyt66nvS6c038f4mc4E?=
 =?us-ascii?Q?Ooc177uWxjTwdIjjImk/FqAjcQE9fmxZkO1j1CQ0ypdaalizI7am5P41uqbK?=
 =?us-ascii?Q?g9UHv5pkhogUXJERxjLToBUrXoQQfsjp9HRjNDRqnYk4XuGd5wbvkwHOF2xj?=
 =?us-ascii?Q?7ocTEfOc0Ix2XXwbLsQCxJyhCajLr1gPwn6kXEudk/GHuOrQV9hTmJSqlbA+?=
 =?us-ascii?Q?EacknkSIFv9CiNAt4qVlUOAujtriMLxRKxgSCRwPF69x3TpfEbqphww6GyWh?=
 =?us-ascii?Q?Jxkjcm+nzrnNTnLCvsJiYablXdDJ690pyikF4N8OWg0JwwdRaPY3c/wWr+NG?=
 =?us-ascii?Q?o96o4+800lu396aOcORKr3Ax8SpGjOCbPe7wEp/A9fCs1DSRh8kTbnQYk0Qi?=
 =?us-ascii?Q?R3dDLln88DSNL6JVUtMuZOjbN/sJLB+H+ogweFLSIPIl+P0moLYqCvIyd/+E?=
 =?us-ascii?Q?1fnMFJ4D7PhBY2EQztpRcTUUKo/jynvaJTez+g7HR8yefSMJdTf/IrZEkPSd?=
 =?us-ascii?Q?Al7Ux/tqHtMpUIIoKs41+To9jKPDflmWSGE80WtWC8wT5n3zrxuqEOG6ZWjp?=
 =?us-ascii?Q?FyhUXnTc9+ofgnczBxzyADLjHuljPoJFCJ61aTYihxVS04dKqryeFNOk87Mg?=
 =?us-ascii?Q?IEOc8rzYuLSAjmjdbhENLjU2ijHBP6AFV8AevFo2yspkjdllZlj8QDP0djeV?=
 =?us-ascii?Q?+tneeP3is2frhXEndGO5IlP992OFmisxpameMQWqOaI+eH4189B/2XHKjtEt?=
 =?us-ascii?Q?G9bWo9+g4xokO4BGbPptl8x0UrBmvPjeDpBZ60P4dWIqsINE+3InL5/gk+8d?=
 =?us-ascii?Q?V7o9R0RyaoB3E8r0pz2bRcTBmhiE+07IPdACu0UrbzTAWmeKBOuRgMqvUXz0?=
 =?us-ascii?Q?7RI3LQ1/NcZmv1T5BJ/uwbr1CtKPFsm9hqTH1kplCSn8FKvMlihFD5j+eGUA?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 57568def-be3d-4176-e9d6-08dc0c495e27
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:23.2912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOju4DugCvn1jeitW2YVEyGZ7UbUMf+c87EflO++jrGEM1FSQWYQwQPASvE0BeotAut6HR2Vi8chKTSy9FXT7dDV73MkZm/gTmy3bHG0vzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7575
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

The macro MEM_SUPPORT_64BIT_DATA is always defined, as either 1 or 0,
so using "#ifdef MEM_SUPPORT_64BIT_DATA" doesn't do what one
expects.

This means that currently all 32 bit targets get compiled with the .q
suffix mentioned in the help text, while it doesn't actually work.

Use the proper "#if" instead.

There's really no point defining another similarly-named macro with
exactly the same value, so just use MEM_SUPPORT_64BIT_DATA throughout.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 cmd/mem.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/cmd/mem.c b/cmd/mem.c
index c696b92a274..768057e4d3f 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -35,11 +35,9 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /* Create a compile-time value */
-#ifdef MEM_SUPPORT_64BIT_DATA
-#define SUPPORT_64BIT_DATA 1
+#if MEM_SUPPORT_64BIT_DATA
 #define HELP_Q ", .q"
 #else
-#define SUPPORT_64BIT_DATA 0
 #define HELP_Q ""
 #endif
 
@@ -131,7 +129,7 @@ static int do_mem_nm(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_mem_mw(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
-	ulong writeval;  /* 64-bit if SUPPORT_64BIT_DATA */
+	ulong writeval;  /* 64-bit if MEM_SUPPORT_64BIT_DATA */
 	ulong	addr, count;
 	int	size;
 	void *buf, *start;
@@ -152,7 +150,7 @@ static int do_mem_mw(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Get the value to write.
 	*/
-	if (SUPPORT_64BIT_DATA)
+	if (MEM_SUPPORT_64BIT_DATA)
 		writeval = simple_strtoull(argv[2], NULL, 16);
 	else
 		writeval = hextoul(argv[2], NULL);
@@ -170,7 +168,7 @@ static int do_mem_mw(struct cmd_tbl *cmdtp, int flag, int argc,
 	while (count-- > 0) {
 		if (size == 4)
 			*((u32 *)buf) = (u32)writeval;
-		else if (SUPPORT_64BIT_DATA && size == 8)
+		else if (MEM_SUPPORT_64BIT_DATA && size == 8)
 			*((ulong *)buf) = writeval;
 		else if (size == 2)
 			*((u16 *)buf) = (u16)writeval;
@@ -248,7 +246,7 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
 	int     rcode = 0;
 	const char *type;
 	const void *buf1, *buf2, *base;
-	ulong word1, word2;  /* 64-bit if SUPPORT_64BIT_DATA */
+	ulong word1, word2;  /* 64-bit if MEM_SUPPORT_64BIT_DATA */
 
 	if (argc != 4)
 		return CMD_RET_USAGE;
@@ -276,7 +274,7 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
 		if (size == 4) {
 			word1 = *(u32 *)buf1;
 			word2 = *(u32 *)buf2;
-		} else if (SUPPORT_64BIT_DATA && size == 8) {
+		} else if (MEM_SUPPORT_64BIT_DATA && size == 8) {
 			word1 = *(ulong *)buf1;
 			word2 = *(ulong *)buf2;
 		} else if (size == 2) {
@@ -528,7 +526,7 @@ static int do_mem_loop(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	ulong	addr, length, i, bytes;
 	int	size;
-	volatile ulong *llp;  /* 64-bit if SUPPORT_64BIT_DATA */
+	volatile ulong *llp;  /* 64-bit if MEM_SUPPORT_64BIT_DATA */
 	volatile u32 *longp;
 	volatile u16 *shortp;
 	volatile u8 *cp;
@@ -559,7 +557,7 @@ static int do_mem_loop(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * If we have only one object, just run infinite loops.
 	 */
 	if (length == 1) {
-		if (SUPPORT_64BIT_DATA && size == 8) {
+		if (MEM_SUPPORT_64BIT_DATA && size == 8) {
 			llp = (ulong *)buf;
 			for (;;)
 				i = *llp;
@@ -579,7 +577,7 @@ static int do_mem_loop(struct cmd_tbl *cmdtp, int flag, int argc,
 			i = *cp;
 	}
 
-	if (SUPPORT_64BIT_DATA && size == 8) {
+	if (MEM_SUPPORT_64BIT_DATA && size == 8) {
 		for (;;) {
 			llp = (ulong *)buf;
 			i = length;
@@ -620,8 +618,8 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	ulong	addr, length, i, bytes;
 	int	size;
-	volatile ulong *llp;  /* 64-bit if SUPPORT_64BIT_DATA */
-	ulong	data;    /* 64-bit if SUPPORT_64BIT_DATA */
+	volatile ulong *llp;  /* 64-bit if MEM_SUPPORT_64BIT_DATA */
+	ulong	data;    /* 64-bit if MEM_SUPPORT_64BIT_DATA */
 	volatile u32 *longp;
 	volatile u16 *shortp;
 	volatile u8 *cp;
@@ -646,7 +644,7 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int flag, int argc,
 	length = hextoul(argv[2], NULL);
 
 	/* data to write */
-	if (SUPPORT_64BIT_DATA)
+	if (MEM_SUPPORT_64BIT_DATA)
 		data = simple_strtoull(argv[3], NULL, 16);
 	else
 		data = hextoul(argv[3], NULL);
@@ -658,7 +656,7 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * If we have only one object, just run infinite loops.
 	 */
 	if (length == 1) {
-		if (SUPPORT_64BIT_DATA && size == 8) {
+		if (MEM_SUPPORT_64BIT_DATA && size == 8) {
 			llp = (ulong *)buf;
 			for (;;)
 				*llp = data;
@@ -678,7 +676,7 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int flag, int argc,
 			*cp = data;
 	}
 
-	if (SUPPORT_64BIT_DATA && size == 8) {
+	if (MEM_SUPPORT_64BIT_DATA && size == 8) {
 		for (;;) {
 			llp = (ulong *)buf;
 			i = length;
@@ -1151,7 +1149,7 @@ mod_mem(struct cmd_tbl *cmdtp, int incrflag, int flag, int argc,
 	char *const argv[])
 {
 	ulong	addr;
-	ulong i;  /* 64-bit if SUPPORT_64BIT_DATA */
+	ulong i;  /* 64-bit if MEM_SUPPORT_64BIT_DATA */
 	int	nbytes, size;
 	void *ptr = NULL;
 
@@ -1186,7 +1184,7 @@ mod_mem(struct cmd_tbl *cmdtp, int incrflag, int flag, int argc,
 		printf("%08lx:", addr);
 		if (size == 4)
 			printf(" %08x", *((u32 *)ptr));
-		else if (SUPPORT_64BIT_DATA && size == 8)
+		else if (MEM_SUPPORT_64BIT_DATA && size == 8)
 			printf(" %0lx", *((ulong *)ptr));
 		else if (size == 2)
 			printf(" %04x", *((u16 *)ptr));
@@ -1211,7 +1209,7 @@ mod_mem(struct cmd_tbl *cmdtp, int incrflag, int flag, int argc,
 #endif
 		else {
 			char *endp;
-			if (SUPPORT_64BIT_DATA)
+			if (MEM_SUPPORT_64BIT_DATA)
 				i = simple_strtoull(console_buffer, &endp, 16);
 			else
 				i = hextoul(console_buffer, &endp);
@@ -1222,7 +1220,7 @@ mod_mem(struct cmd_tbl *cmdtp, int incrflag, int flag, int argc,
 				bootretry_reset_cmd_timeout();
 				if (size == 4)
 					*((u32 *)ptr) = i;
-				else if (SUPPORT_64BIT_DATA && size == 8)
+				else if (MEM_SUPPORT_64BIT_DATA && size == 8)
 					*((ulong *)ptr) = i;
 				else if (size == 2)
 					*((u16 *)ptr) = i;
-- 
2.40.1.1.g1c60b9335d

