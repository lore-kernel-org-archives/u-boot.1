Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5484DCEACEE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C4A8929F;
	Tue,  1 Oct 2024 20:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UWoHv3RW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4396189292; Tue,  1 Oct 2024 20:21:29 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B78B89274
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDQcSpGjRkwss0808c40qciBmK9tJGQ/dAFQccn4iMHzxAnCyzOlR5N6WIE1+4FAlWnWSwe7w7qmCWgDxUP24rP0sZqdvbMriajFDWfej8EyaOs66R1yL0XviaGpz70TY/mfktengFcDiVtWxitmxOThDmVZ1vzGv+kUhcFw/75yY69eNLGcso4JQ7fzm1f28w4S7nBYaBOAOWdwPdY55mXY4gjZqXaBrl35qgCSg3oOXG98LMzXyDer6Vt3Hh0H5qO2Ta6+QJcSqneDWQUrYog1n23eb6pSaS6hRTmr+VmiFl8VnSran/oPS6y00m2zS7hHqySLAGai6YR4dL2/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=CPk4OPt/4iWZP8HPJ+79W/lTtMDXCqoUsynSjaZlPpQPyQWA+7ZU5C/jLr7F8iK1Es9AE5GS2HkpJmQwSra0FYyVZa6/S6wSd4jWsi+im1w8IWyZmS2bE0sAN19BUPq+/1X2gi3rcQdQgQ+PBWy0WgJMmXZ9I4gJxjs9sp8XndSecaKHwBKDwoc30F31dk2j4Nofcm8dOLNIcQaNyqb2qgHY1EzKo/N9+TvklqDNQH5VrYo1zr/Z14xJkPIDIJCx5GZV9zyQIbHJ+TqVv+4TXcTKtbPmhbP2No133cLaWn9471qTawda9zB8ihfppuh/3JOQnbXFgDCN24Dr1RDbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=UWoHv3RWj35jutgz6+xiiULgxGHjKrpD5ZzquZMFLel/ytSD7i/fTSMfuusx8Ypz6Q58O1Pb+IlMIumdK6ZhW5SRqjyXic6VrwLNJSuXA1rgDZg/yxGnM+OGbI74vjaUgjfVOUl2sD+ujLma9H7bk0p9UiaLuQKTHYdQjChIBjveEiDtsX1wmJTxpd161LcbfEGzihJN6Mf8qxrTD7TRDJ/Wi+XhHJLA5mtGiaTaETtQfKPSLacUpMaUqql4ScSPs9C5Fy/AMZysdjOURqg0o7iCpjypgUF2dOvnFrMiJp1yzms+jHg3vS7ERk8TRxqtkSn46J1/kS06TfTN/umMvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9153.eurprd08.prod.outlook.com (2603:10a6:10:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 18:21:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 07/13] test/cmd/wget: fix the test
Date: Tue,  1 Oct 2024 21:21:01 +0300
Message-ID: <20241001182107.907828-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 319458bc-8121-4849-5273-08dce245dc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3fNg4O9qtwRwANwzrCuE/2aCabSh9RkRTGxuk1cYXKBhA51HRPftjP+f3J2f?=
 =?us-ascii?Q?H+QdVp22Irv4BgPVbx6IEPPC3mApxkeamDcPAvEc/mcy44+ktsDMppU8T3hY?=
 =?us-ascii?Q?YTgCtEJ/Qq+G0LBImAZiBJPvMpSVl5KOZtH1VeqhwlE5ZeX/9bpdkrGilPIs?=
 =?us-ascii?Q?cDJTy3c+vJ+8jawil/2MJ3e18K7lKnf7VFjAXMf4Z8Si42cmBjhDPu2CZ6x7?=
 =?us-ascii?Q?OjvJpUC7vXf2K43NoouOLvhC6Pa11qsRQKe3fiHNkSfVM+ZyP8ME90UBqUpZ?=
 =?us-ascii?Q?VrslY5m7EtpiMlFm2Sxl4FUGe6uDjER/HXeSnMwz/lotwwLyUInqD1uIaV4V?=
 =?us-ascii?Q?GkcDLZ5vnqcaLGtwKQUnk2ehcJQDc96UCjbZ8vyKFPprBR1qpWEd34k3+Zv2?=
 =?us-ascii?Q?qBh9twXn8e7cuL/dMOfwePRocJChPSSiagJ8I6GRm+10vMYn2my0qc8GkN1M?=
 =?us-ascii?Q?X0jd2ZoZd3uHELFTuuECY/3FX5t8lHoYMQMtwzPvNCXR3C9QIZWsPb8u633X?=
 =?us-ascii?Q?yjdZZrmZWnIlox1+MO6XKxvG4wWT6OCcmE7VnpjGMLzaXcobiKEqfKlv8Eyk?=
 =?us-ascii?Q?0F8nhWqnJSe3idt4wPMOBBjSHi/yQydEh8+8bh+pZ+FYPxJ+NoB3QSeMMKCA?=
 =?us-ascii?Q?mQ38fyT/ruPRg8Vma2f3wbjh5c0VmftlQPDuA/OS+BwQHP3IdYig2p1MBmMM?=
 =?us-ascii?Q?DI4SeKjitRRHTD7nksRTdZGYAp8YAFRd1GJITyMU9qLKGRUcbr2T5+NiD6xz?=
 =?us-ascii?Q?WxFY1YLhqF2QKFlW9nYRcnHAzGKxJGKJwpysdXg+tcIFdErpJaLicbo5eQVD?=
 =?us-ascii?Q?UPa8Xwf6aESStpim3rMvUAeO8VcoEuD0oXSL26Fl5w+09v97ie/PZVhD+W0T?=
 =?us-ascii?Q?w80fOCAHG+ZZ62HDsEdJittfg7d3Mttn3PQkELilPQoAezQBX4yqZlm4QYf3?=
 =?us-ascii?Q?NUJ+fyXt76sZljtngHJ6BmORl7jpCKs7zk8DN7Sb/5pdeAryksoE1BPEDPc2?=
 =?us-ascii?Q?qthVhSVzyJUVJTmQSEMocxIQbwxY5AVL4SeNeGLurWpOpRgHJXTwRF/9qTmW?=
 =?us-ascii?Q?oVaEnXDBgGi4jm9TthuT8k4krT3vXM5pG3sYvQ9ubeyEz07G7sqP50BcIXau?=
 =?us-ascii?Q?xNfZ2oaSpfkHVb44yQL4ODre7csVZMrnkPrRTwIyc1QIOSNJ7felBbxpYred?=
 =?us-ascii?Q?waEDAiMRV11xfh6HSl/gCuC5TCT036lc98owF3gCR0y+XR1iE4GwpGF68c4G?=
 =?us-ascii?Q?1q6M/GPaXarKdCHznJb/hCb39Bv2gh1dGLESvCQqYAzV4937J0favE4kEEzt?=
 =?us-ascii?Q?HIxpzRlaiddui59G86cx9GS4bUE144hQWTZoJZ0eQsfsxAIDu87IDBXXHYaq?=
 =?us-ascii?Q?MfUfqFNtgBrwGmRREObBTYRQnM2MyAtfvM+hjpC7tn1ehbwfUsqHKtNWQDBo?=
 =?us-ascii?Q?DaB1mlBCdpI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n0xKnCjSQI4VPIK6E2O6w2dH6/a3R8DBABe+EBvrFIEXXq2jaIqy2HYWFoKj?=
 =?us-ascii?Q?VJg/w7iPo6vAAVItP9sGSnufb6Bv6F0dzCsMA9pB530n4u3ew6NrWl9aVeA/?=
 =?us-ascii?Q?Qw06ELf0m7lW8g9nGGbsJceVfsLluNGgLw46sEUSjYBk9XBTSydKGPGzgDvs?=
 =?us-ascii?Q?/Ddzgi3vD6tjW/dGuUIRmMwXFD8QsStTRVDuwJzShgbNMSs8og416EtMlRzw?=
 =?us-ascii?Q?sRXG0UhvbQSQEYnpOuv8zsSYLWjxkgY/4WD+T+Cb0rhM5louuW2nBMzdmace?=
 =?us-ascii?Q?nr9tGl9c7TdAeoJTFC+ymhOxHD2ML0s5ZwxrQODVj3SpHcPOdUmxRzBpKFO5?=
 =?us-ascii?Q?+5+GUAfNSlbFnwgH+GrMGDTwOdERme80qxFfaCIom0dVGLzQdIL5A642Xdif?=
 =?us-ascii?Q?b2jld1DEFUeEmVuSQjrzWdGqe1GCqlBTS2EZNGsA0FRk6w5y38anwnevwSg5?=
 =?us-ascii?Q?n7tNYo+VMfjDAQ+Ztoy0akG+bNOcpp02qkXfhNj7XFce/HzZl10HuR2Je8gB?=
 =?us-ascii?Q?A/8ItCyYaT37uyUC4wbmkbnT+vNoJAkvbYpwzFGvcw8eeRS3waZKG+CzYVbG?=
 =?us-ascii?Q?T0KMHCyOkOAg6fhRXbFbk8TJMwg+R86UkJhq9M69VzbOW3ogiVCNavPaMobV?=
 =?us-ascii?Q?8M2JrfaGdj5F+dtDhoyjQZZq525UMHxuBYrmKnJ4Bl18axGi/xQyU9ofFD31?=
 =?us-ascii?Q?41oGPkg5wo7rDS1k6PMFz2tfVaI3w9ZM/A+hgzyjXxyT29HMOurj6co1GObw?=
 =?us-ascii?Q?2TwZeWbHGdzgX9Kp1kE2bqftcoE+p+b+Bahq5eixXU+BRGQZMUAmPvfS6O+n?=
 =?us-ascii?Q?FYFYrqdMW1bF+MCdVpLjk8QsLskT+wqkFLY79iawGJ4Xc1uVsnob7VV4bVme?=
 =?us-ascii?Q?neDDVqYnto9mwvqyel8QkI3sqXI2L+zC2ud1PL99eVMP1Vmc6xQuLUvtytm4?=
 =?us-ascii?Q?j7l4wKFAstEjx38TAaS0+BTqeghnkL5BfGoUzRqZo+eq9Ja/GfWOHpzheH1u?=
 =?us-ascii?Q?+JsUrOR8njyhDudq58bTWEe43XGIF+5s3mQGJqjxDqgX1d9RtbUDZak3bcBP?=
 =?us-ascii?Q?IUrrgAX7jVq3QAlo5Oot9PRTwB+Q+mvPPnbWpmXwl08TNyWSqnMbHcYdTCro?=
 =?us-ascii?Q?EB7vHHoPHYxmsYN5IuSBOJxNG1yLRDXMV0LB6UeSkL4d1LLls3g8Fbob5w+f?=
 =?us-ascii?Q?sMZ8jdCosev2/u/q+0FjFHJiLVTf9sYAM3CQdmbvfh0kW8lT8H51KW1sKWY2?=
 =?us-ascii?Q?1Ze0et4sUbA8+nDQnBuB3KqKBI9mCnOe6VFQKbOBqeRYCuoB+1paf5I85jKe?=
 =?us-ascii?Q?lGRzT63+23VoW2T14mpn99p2wdjFYsIq9fvmmgbAlk3PsVSBV1dtnvKvggPL?=
 =?us-ascii?Q?5xJ13Mz47b3GXDA2BvY9TbNGuaOtow0eGvtddj//vFP3M7dAJR65DZVWXpYN?=
 =?us-ascii?Q?4m/3F7weEE7/OCzEqWfEFk7ECf1IF57fqGXOa2A7wp8ChhDZ/4X53ZY9FQ/T?=
 =?us-ascii?Q?9ZMDBOD/L9KLsvrCcJ8BfgiP3EvRHLVJI+hBK0NnN88uPNKoRUFwXn0DiP8e?=
 =?us-ascii?Q?U3WCmYNTaPHqFQGk4gxC5Qki3vhY3YxAFufKBUZ4LJszIput0JGXkVvdr0Xw?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 319458bc-8121-4849-5273-08dce245dc2d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:25.5904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzKCWxdb9ng2uHDBKAIIM9te38YgTIJj0m/i2eNfzRvmIj7K/AYxYGG2EG1kiya8aDmL7aicobN1ZJCI6WFFSQbM2uEAS137U2acXMXOxZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9153
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

Changes:
 * update to new tcp stack
 * fix zero values for ISS and IRS issue (see RFC 9293)

Previously this patch also fix incorrect values for tcp_ack & tcp_seq,
but the issue was fixed in
 * dbb6b5a: sandbox: fix wget test failure after fixing wget issue

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/eth.h |  4 +++
 test/cmd/wget.c                | 58 ++++++++++++++++------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

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
index fe26fee54c9..a90ca4fad8c 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -25,8 +25,7 @@
 
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)
-
-int net_set_ack_options(union tcp_build_pkt *b);
+#define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
 
 static int sb_arp_handler(struct udevice *dev, void *packet,
 			  unsigned int len)
@@ -64,12 +63,14 @@ static int sb_syn_handler(struct udevice *dev, void *packet,
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
@@ -104,13 +105,11 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	void *data;
 	int pkt_len;
 	int payload_len = 0;
+	u32 tcp_seq, tcp_ack;
+	int tcp_data_len;
 	const char *payload1 = "HTTP/1.1 200 OK\r\n"
 		"Content-Length: 30\r\n\r\n\r\n"
 		"<html><body>Hi</body></html>\r\n";
-	union tcp_build_pkt *b = (union tcp_build_pkt *)tcp;
-	const int recv_payload_len = len - net_set_ack_options(b) - IP_HDR_SIZE - ETHER_HDR_SIZE;
-	static int next_seq;
-	const int bottom_payload_len = 10;
 
 	/* Don't allow the buffer to overrun */
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -125,35 +124,32 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	tcp_send->tcp_dst = tcp->tcp_src;
 	data = (void *)tcp_send + IP_TCP_HDR_SIZE;
 
-	if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1 && recv_payload_len == 0) {
-		// ignore ACK for three-way handshaking
-		return 0;
-	} else if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1) {
-		// recv HTTP request message and reply top half data
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+	tcp_seq = ntohl(tcp->tcp_seq) - priv->irs;
+	tcp_ack = ntohl(tcp->tcp_ack) - priv->iss;
+	tcp_data_len = len - ETHER_HDR_SIZE - IP_HDR_SIZE - GET_TCP_HDR_LEN_IN_BYTES(tcp->tcp_hlen);
 
-		payload_len = strlen(payload1) - bottom_payload_len;
-		memcpy(data, payload1, payload_len);
-		tcp_send->tcp_flags = TCP_ACK;
+	if (tcp->tcp_flags & TCP_FIN)
+	    tcp_data_len++;
 
-		next_seq = ntohl(tcp_send->tcp_seq) + payload_len;
-	} else if (ntohl(tcp->tcp_ack) == next_seq) {
-		// reply bottom half data
-		const int top_payload_len = strlen(payload1) - bottom_payload_len;
+	tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
+	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + tcp_data_len);
 
-		tcp_send->tcp_seq = htonl(next_seq);
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+	if (tcp_seq == 1 && tcp_ack == 1) {
+		if (tcp_data_len == 0) {
+			/* no data, wait for GET request */
+			return -1;
+		}
 
-		payload_len = bottom_payload_len;
-		memcpy(data, payload1 + top_payload_len, payload_len);
+		/* reply to GET request */
+		payload_len = strlen(payload1);
+		memcpy(data, payload1, payload_len);
 		tcp_send->tcp_flags = TCP_ACK;
-	} else {
-		// close connection
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
@@ -214,6 +210,8 @@ static int net_test_wget(struct unit_test_state *uts)
 	env_set("loadaddr", "0x20000");
 	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
 	ut_assert_nextline("HTTP/1.1 200 OK");
+	ut_assert_nextline("Content-Length: 30");
+	ut_assert_nextline("");
 	ut_assert_nextline("Packets received 5, Transfer Successful");
 	ut_assert_nextline("Bytes transferred = 32 (20 hex)");
 
-- 
2.45.2

