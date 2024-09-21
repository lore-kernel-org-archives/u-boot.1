Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEFECF9C6E
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 513B688B1A;
	Sat, 21 Sep 2024 05:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OFPaRQ1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AC4887D1; Sat, 21 Sep 2024 05:44:16 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF953889C5
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfcBaE1TXLLyLvuejpRO9tQmeRi0auFH3EcTMpNTdGnyIFHV+Qsriwj7jFtBpKZy/IMezFiZ0c++ewiRgy/dTEveZA/oQ+nvmv3asCjacDt5UcpdcbM448meDSK2ybhFZNiKp/Lx2PHU3Uk+9yysP2xW+rwwmIjcB/ZZNwrSARgh62x7Ve3CMiiD44f9gd8QIUjwj2fVILobOXDc9xfmL81BMkLFmXIX5khTaBLjvsv6PB5HAx0o6tToAzG3q3sZg/QjZV5HEgG2/VruS/gqUP13/vbjMekq9lBDPwDH3Ufx6U0C9qIcHThCpweHfPSW5b83tUbDIBzi3micuC6Wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyvxhXWrviJZtOFOZEFqwcZmjyBhsKNwF7Exenqg8GE=;
 b=EbXT/IOSsOhSuTh01rREcT9tLpqdOAatXg77c7fIK9OgtqF4JiPbHLbdkk+Me3JhnhiMFlhdso5hxNZBhHqZgYGotFrLkyQHmNTVb9sEpIyiSUjUTE7dxYgGh7YPvfcjaEeE8mBWN0ih0d3qD3UZwRtFQtePAnODFkfLlCFpulcm/idAK584AcuYRTgMSgCdoU1xO9pnr1ohcDslwcl49evYdrmljLcX8z3YvcacH/S15cP7s7fRc0dcn/+9VpHhBU3MjZre13iuL0fKrgm0o7UZmXINOOnHUF7LAHM/Cj02aPBeJQyflyru0g4Szpo+1IFwqLBiOcKJCOmgBC4hSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyvxhXWrviJZtOFOZEFqwcZmjyBhsKNwF7Exenqg8GE=;
 b=OFPaRQ1DRGTgId2QMfICO8iyJ6W/XL0EysNK0l6oS8HWCdLqydDPtu8z7UAsyxdZpqMQ0MF2NzBE53FDJboavt7fSk7WMBYzMppVC4ke3XMJ/rKbh+F6gxZtX+E/I76ViUvuvpywTPt1MQPF5Aev/AbUO4MsY64nKEkAemBoHqWmFIREXrKulyE3i9IBheCn6umndoaPHitetX9+j7ka8RbCeNeou2aMrnSdQsT6r/38WIe40n2pKnCj3lB4xS9DJsnD6XrAudpB7NRQqdKD1fSza3kF+PwYppklme0N7sVL64MXquqXlnlnBp/vess481+vjFsY/gJ+99UbbY0T0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH v7 07/13] test/cmd/wget: fix the test
Date: Sat, 21 Sep 2024 06:43:47 +0300
Message-ID: <20240921034353.1298452-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004595.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::440) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: e893033c-836e-4cb5-0331-08dcd9efa7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q1857N4tql0bXSOP+gD2qUIY4O0Mj9FtCYKypHtfhKCDWxTaxkYHUUf7sZDW?=
 =?us-ascii?Q?BI//PPX0um9zjlaWQiysus8sgtLC3VM6FYnZFDPblGlaqOb7MorFZkhCDVec?=
 =?us-ascii?Q?x/UhAazO159uhRTLYMg4MIDNJkCALYnDghrrciroEKr7tfCAHyzyoMq5u5IX?=
 =?us-ascii?Q?GtaDv6ROSNo2oy3O5l8+MJ10wEbZenaBvXvLDnKQ1Ap1acLr8ot135y7Z14/?=
 =?us-ascii?Q?WapFeigyDGSXBZc+z7qE6/QrrTXWHeKzg2yPvBXsauwhmUEoUmVNsDlm5foD?=
 =?us-ascii?Q?+hj7GC3JDvASNrXfEae32PPHf09T7RTfd3mbVxSqkW4seLkxVnbce8WLbi7B?=
 =?us-ascii?Q?hiSp7Ig3uF6tdmC8oEwtclE8v0jdSC31IefxhnshtAbDw4QKWFgWqrjk6uOm?=
 =?us-ascii?Q?GgmvESbAJVTUWl++PSQ6KqBXPyyL3NKqPbou8ReMaWakrfNCsb5w8scMEx16?=
 =?us-ascii?Q?tP6eQkzRwF8Eu6bgqaZkVMMRofks1Caz0s3fd2R8O6PId5XgkspbmynDrUDc?=
 =?us-ascii?Q?M1pMZImdVrn2chmfL3UuGtaqX9+tc0BD09XE4f+OGNAnPMfxqHOKAE8i65ul?=
 =?us-ascii?Q?l1LLYV9KdGysxNHtNPRf/3XCGl5LvTboRQZgv63Fugc6EfchDWrTErbshfyW?=
 =?us-ascii?Q?KDgTOCrakMoc2K6x53Y0637p4UGpqHaRbVjAIAxHzoKg523gbjWDm+rw7zPa?=
 =?us-ascii?Q?1/fMO+y0GRxHOsxv+zScrO8KmhNH7uOa1NP8p65fW7Kja8nIPmncj34Mdui5?=
 =?us-ascii?Q?SDHQqb4FguZD/p9Bko6YT/j/jSpJSaXO3S0ADpNCktGAvyiEkZ3z5rjoBYhu?=
 =?us-ascii?Q?YHtfCGaFg5byxT+1oDm2Z4pXxXMDrzLPTCSodkFHRdNI9s8uU3bvtzMfqmlx?=
 =?us-ascii?Q?4bHh5NR6vM68IcToNfF2ZT2pOOw5DZmJoVakrWLo8jCXaYoN2R4Yg0Xbdvdl?=
 =?us-ascii?Q?BrGX5qBBTHn9emgcDyvO9w/si2NJT3jiWwQoePYRITzP+c+Ab1O5y7mfU6yQ?=
 =?us-ascii?Q?6zuaCEXLvrVbIznN7/G2qsHXRu3FKnRod8qS0hBzPB5Pj1MBlq1dCkfEpxou?=
 =?us-ascii?Q?DMYLCmx0YAn5OEwdfk1SKfV2vT4zDgjbLsfyYPILqzrNDOHii9lBm+lutY0T?=
 =?us-ascii?Q?0DNnt/PTyvqtzyPLFZL7Bqg0mZg6RhGxQCmpG7EN+tE01qmo7jZygydJMFea?=
 =?us-ascii?Q?CWsd7XDqphSzDgEKwTVKMeuzbkmIYcpDOU1a5TdNWvbx5MLRGM7NW4N3cQCY?=
 =?us-ascii?Q?x0DnxTzrkNpjdYrknPUzuJZjddUEGkSqjr6vN7UzN9OtM5X3BVUX+tYoMXxM?=
 =?us-ascii?Q?9kM+knufH3GL9HPzt//fHUUJsnO2eRc7mJCXj/jrXT/GSLnZjxrzcpR7CIZn?=
 =?us-ascii?Q?fdcgJW8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NM1EhPWmyU1m6ppmyVascfYOuPLWhrqcxUZqqc/c6tZwX5Q+fV+cemabxc2E?=
 =?us-ascii?Q?ffiLBIfbeoUCXquRJt+FxkylaeAaa9LRAUtyHbOeI5We7DarLwRfbZ7YT2Tt?=
 =?us-ascii?Q?9tc03zuYnjrS80tLv4mosGQawp+HEVWBN9gCL0PM+YC0E9cX+OygAe45GS0W?=
 =?us-ascii?Q?A9moJVNuH6diELQSFuH7QIP+ZTDfpDYcQBnSgK9gK0Gx9BuL5N3SacXQzPTn?=
 =?us-ascii?Q?dfQZNSDQvXDka+1ey0L0Iuq21vpmV01Nvh3f60tV89W7oBN5r9oEVSLh+ns/?=
 =?us-ascii?Q?IYYbqWgqaEoSN7gM53EBoYe/u1GSZRqfxhG/39Fz90qLGJ2zsrWjv6O3kb3I?=
 =?us-ascii?Q?vvuHcE2OeIsOmpyKdnWZy1Q4Dz1Tzbeo6NH0O1aI4xZZPdHJFIC8o8Xpy8k4?=
 =?us-ascii?Q?XSq2M6pqedxezOSJQfdLuaD0x7FhDW0H6zCzxyxeRKU1vykOp16WTTMIaz3p?=
 =?us-ascii?Q?BRmSx5fpVafmuyjmK72xQIOwkCumlNQ7bjEdmovU7wWnQRBM3uN/8Xfni9xp?=
 =?us-ascii?Q?+qB2fHk9FdjGoVFrgavkwipa7LL9sym+NMOSig+8A4Zy0fcYjG7cPDCf7BBk?=
 =?us-ascii?Q?xxcxz7DbUy/yXp0pIdXBA+vqzj7XB2ihr7uj2NSAijepL7LYAvi7Qgbb6hW2?=
 =?us-ascii?Q?K0lsuWBV+fvh7IEQENxxvujmmp/goe9NeEZOlyG33RrKU04jpYjhv2uneIrY?=
 =?us-ascii?Q?dbiluoEzz+leNd7IZkbv5/8QRvYndcUVtjYBxNpKs1GnJXOLM8glBkSZ24oK?=
 =?us-ascii?Q?sRCWohdSalCcCeRJGpgRR15VgNCtjlA7FLMPWI/B4HLlwR6ijz2U/uwT/hXu?=
 =?us-ascii?Q?xW1CCQU8Vdl0CIQGbbuJDrnjhi0guBkP5cx+baAvRxB7TNOQhZzmALuunFF2?=
 =?us-ascii?Q?cXVYy40o7T9C3X8GIHlDYgNDWWdX4yWLM1BJxqBAph8TncT/tCe0ImGCbHcx?=
 =?us-ascii?Q?/NPqvbkKf30r+ZUtYFpZivcX6epS2RJSZyszCpEE9nzPh/EBfActd0jAPK1y?=
 =?us-ascii?Q?4FJmywIuIom4KXX5KZZpv4XU1PWF339Bs4miyEgrgzktoR2Xi3jBrcMf2dzq?=
 =?us-ascii?Q?Vd7j5lvJz/v6kQUxlIBP5JpvVN92XZ8rLBqQN+0SmJmSmJwS/x5P5CFNjciB?=
 =?us-ascii?Q?zpXrKNziGENK59JxEDHswCA9efsdYW83oMY36hLou4oI8tHEqtqJnptmLCmp?=
 =?us-ascii?Q?3mbwbe0ozCnMouYim7B8ZEpMP4wHYNoCUx9ebjtve58bWxZil6hcVNTSGQcm?=
 =?us-ascii?Q?E5F4fyVyytUFXTY//3wjuGQ5KcjYQAREhist9gtc7AB/OFl9VyTCu8cEZ5Dg?=
 =?us-ascii?Q?17cbX1A63BF7ghOjxJp9BIqwx7virdFjcweRL89bogVFhU+Xfj/T93n3454V?=
 =?us-ascii?Q?P1bLIC/aVT1a3zY0RxJBDtyIVZfn7w7FqS0wCUvhYcyriN4NjbM375Y1o3Cg?=
 =?us-ascii?Q?ObD8QYsui6J9yBIiLLBdD8qNLlhFoUtsymrhcOGgGZoROPgvjVR3lC/u9Xn3?=
 =?us-ascii?Q?HVxkobjCUEUw08VXMrOl+Hurkr/9AqF0W7F4uWK92s3rgTCuHL16CaebgWPb?=
 =?us-ascii?Q?y2+vF24gpeEOi6pL+OebIAZzx7ZA91z745qPpRfTtPFBLmCGHNOrI/qEq1Ee?=
 =?us-ascii?Q?s0rS1S1eR/IRiS6eFnRKzHE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e893033c-836e-4cb5-0331-08dcd9efa7fe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:11.9977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk1nTY/e59i/HfY2h+NGfsNC2yuF7EvD5FOpcnApcJGLLXbw30eAtSu6WCp80Bd5FQv8BE4KvGqbe9glEmzjO72F18qm8b5/YnvPYfc3WCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9418
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

The wget test seriously broken:
 * Uses zero values for ISS and IRS values (see RFC 9293).
 * Writes incorrect values to Sequence and Acknowledgment numbers fields
   of tcp packets. In the real life such packets will break the tcp stream.
 * The test should fail (see above), but due to buggy old tcp implementation
   it passes.

This patch fix all bugs mentioned above, so the test passes with new
and better tcp implementation.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/eth.h |  4 +++
 test/cmd/wget.c                | 45 ++++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/sandbox/include/asm/eth.h b/arch/sandbox/include/asm/eth.h
index f042a5f3b92..083a7371a3f 100644
--- a/arch/sandbox/include/asm/eth.h
+++ b/arch/sandbox/include/asm/eth.h
@@ -77,6 +77,8 @@ typedef int sandbox_eth_tx_hand_f(struct udevice *dev, void *pkt,
  * fake_host_hwaddr - MAC address of mocked machine
  * fake_host_ipaddr - IP address of mocked machine
  * disabled - Will not respond
+ * irs - tcp initial receive sequence
+ * iss - tcp initial send sequence
  * recv_packet_buffer - buffers of the packet returned as received
  * recv_packet_length - lengths of the packet returned as received
  * recv_packets - number of packets returned
@@ -87,6 +89,8 @@ struct eth_sandbox_priv {
 	uchar fake_host_hwaddr[ARP_HLEN];
 	struct in_addr fake_host_ipaddr;
 	bool disabled;
+	u32 irs;
+	u32 iss;
 	uchar * recv_packet_buffer[PKTBUFSRX];
 	int recv_packet_length[PKTBUFSRX];
 	int recv_packets;
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 356a4dcd8fa..3e9a5f354fc 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -26,6 +26,8 @@
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)
 
+#define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
+
 static int sb_arp_handler(struct udevice *dev, void *packet,
 			  unsigned int len)
 {
@@ -62,12 +64,14 @@ static int sb_syn_handler(struct udevice *dev, void *packet,
 	eth_send = (void *)priv->recv_packet_buffer[priv->recv_packets];
 	memcpy(eth_send->et_dest, eth->et_src, ARP_HLEN);
 	memcpy(eth_send->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	priv->irs = ntohl(tcp->tcp_seq);
+	priv->iss = ~priv->irs; /* just to differ from irs */
 	eth_send->et_protlen = htons(PROT_IP);
 	tcp_send = (void *)eth_send + ETHER_HDR_SIZE;
 	tcp_send->tcp_src = tcp->tcp_dst;
 	tcp_send->tcp_dst = tcp->tcp_src;
-	tcp_send->tcp_seq = htonl(0);
-	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
+	tcp_send->tcp_seq = htonl(priv->iss);
+	tcp_send->tcp_ack = htonl(priv->irs + 1);
 	tcp_send->tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 	tcp_send->tcp_flags = TCP_SYN | TCP_ACK;
 	tcp_send->tcp_win = htons(PKTBUFSRX * TCP_MSS >> TCP_SCALE);
@@ -102,6 +106,8 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	void *data;
 	int pkt_len;
 	int payload_len = 0;
+	u32 tcp_seq, tcp_ack;
+	int tcp_data_len;
 	const char *payload1 = "HTTP/1.1 200 OK\r\n"
 		"Content-Length: 30\r\n\r\n\r\n"
 		"<html><body>Hi</body></html>\r\n";
@@ -119,17 +125,32 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	tcp_send->tcp_dst = tcp->tcp_src;
 	data = (void *)tcp_send + IP_TCP_HDR_SIZE;
 
-	if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1) {
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
+	tcp_seq = ntohl(tcp->tcp_seq) - priv->irs;
+	tcp_ack = ntohl(tcp->tcp_ack) - priv->iss;
+	tcp_data_len = len - ETHER_HDR_SIZE - IP_HDR_SIZE - GET_TCP_HDR_LEN_IN_BYTES(tcp->tcp_hlen);
+
+	if (tcp->tcp_flags & TCP_FIN)
+	    tcp_data_len++;
+
+	tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
+	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + tcp_data_len);
+
+	if (tcp_seq == 1 && tcp_ack == 1) {
+		if (tcp_data_len == 0) {
+			/* no data, wait for GET request */
+			return -1;
+		}
+
+		/* reply to GET request */
 		payload_len = strlen(payload1);
 		memcpy(data, payload1, payload_len);
 		tcp_send->tcp_flags = TCP_ACK;
-	} else if (ntohl(tcp->tcp_seq) == 2) {
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
+	} else if (tcp_ack == 1 + strlen(payload1)) {
 		payload_len = 0;
 		tcp_send->tcp_flags = TCP_ACK | TCP_FIN;
+	} else if (tcp_ack == 2 + strlen(payload1)) {
+		payload_len = 0;
+		tcp_send->tcp_flags = TCP_ACK;
 	}
 
 	tcp_send->tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
@@ -148,11 +169,9 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 			  pkt_len,
 			  IPPROTO_TCP);
 
-	if (ntohl(tcp->tcp_seq) == 1 || ntohl(tcp->tcp_seq) == 2) {
-		priv->recv_packet_length[priv->recv_packets] =
-			ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
-		++priv->recv_packets;
-	}
+	priv->recv_packet_length[priv->recv_packets] =
+		ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
+	++priv->recv_packets;
 
 	return 0;
 }
-- 
2.45.2

