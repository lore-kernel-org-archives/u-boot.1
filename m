Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6690DC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D7088619;
	Thu, 27 Jun 2024 13:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="umR9HI8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A147488606; Thu, 27 Jun 2024 13:40:08 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC288862F
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSJzyRr0z/yJIhN5QQ27Aov2sj5C6RH2jkgpgwHkDwe2AwbExJV1r+hA3CDL+4l9hTNhZDtQqEMMcFqDTeOlx6l7OkAZjPqnH8ZTeNcy9QrlEfq0HoMDJC+9SxzWHnbADkBZ9xr+uYQX8yg/Hop9RO8icuocZxUoY3DpY+IEb1c0S3RAUF8QBLJ5py75ccOS/tB5mEM3fUnkZXnASNaYj71LxDgp21NF6zN9bMyrmglNzsEySOC0KLrotZY4HV7obPagfAqPIE90STJ0ZAwwaW/g4LGdLf29+yzW3LfssGTiVJtZ32H8zbbxv7aVOsCEN/6EyulaLGZjI+PHjVBAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJjX4LAK58l18HhWvO89L0+m/AcdOoRU+H9cMqw6C+o=;
 b=OgA0PEk7VPo+xUEkaVM657OQdi3cy4huPrZR3h7UuflxMGCRzdWHbeYpksoeZF9/mfybEp8uTqQ6cDvOtgyBdLpW4+icc1ov0PdpUaAIiwLZCiwmfbrvvLUFdqDUaIUddSPkYwU4f46Pxl97Mb3siTg2wibGpOjv+gQVcukzei2DlHNipsyaqsBxbd2VMfLa3XABuvddwRzbNEKEtThdqx9jzzLvjO8V8CbzQxxf7nUChyzEVnvpUe+ZW+jNlCFtJQnYk4uJGIBRE4xScknCc4zt51zcT0rSDH661t1Hfv9xCrUw6sUgE1g0X8OQ9J0J6/v5rkzG0siA5SwS5z6VSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJjX4LAK58l18HhWvO89L0+m/AcdOoRU+H9cMqw6C+o=;
 b=umR9HI8Bdk2Uzz48ka99aw0WKeEDMAsK5oU1H4pMNca8CuXRGMTFp/DoJSeHjJiXEm/4G3qy+MtLqqSetjbxmZfCOD3O0SFcF0I44jGzq0CiI2mCjmU0IvBFV2TAXxLKtPfchnuTepptkleRN6qOXz9kM8uJU24SAi3t+Cs2Y6l+ZBkLgpXOeScPDpWeWwShXaWYYZ9qYpSZ4rQhVa9qUQkr6ShyvRP1BxgtF/wvc32QKQnYjDxqL+cylM0jDCcRa9tTzgAt14PMhSMEFdzG16LOKpsLEDepI29x/OunFiI/20E+GU3fhZCOZhCsw4AJcf7gHD/27HSPNa8EOU8F0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:40:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:40:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH 11/12] net/tcp: add support of multiple tcp connections
Date: Thu, 27 Jun 2024 14:39:38 +0300
Message-ID: <20240627113939.100620-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BB3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10427:EE_
X-MS-Office365-Filtering-Correlation-Id: f0482997-6e98-43da-80eb-08dc969de26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eqPUNs4TmQm43zXmCEje5anfbGaN0krrYilgivOJue9vTkAZsd6L/3E+7B9o?=
 =?us-ascii?Q?kl9kof5/AAK/tgFwC+yAHaUJTrafsVsptjosNw4vCBC8u8M85UmwcKjYXhpD?=
 =?us-ascii?Q?5aaP5hKTQBRNERiBrWlI/pYaO7YAeaok4yMQTXAEKusLxzobMbNMZIFmZr3y?=
 =?us-ascii?Q?27vfPFgBR+jpOgpapIed66dmd7TVRLP9N9h0rIw25JIh1O8xvLU0q9MmTnFL?=
 =?us-ascii?Q?p2ftzODx4powWRCbD1pCO6jOhG2yflBu/f1zPDYg0WCOiP0bPQpmsyAlDUag?=
 =?us-ascii?Q?5N31OckHprMqmzPvpNd3C90dUD23JEH3ZE7QoNL0nvWL8JRHzGNoAuHKSU5g?=
 =?us-ascii?Q?erRXpPiPAmlxHQU3UJKZeoFGXcDb++BG8zysQTqN00NOI2cgPw7cdImJi2cW?=
 =?us-ascii?Q?G2p6rixfMt6BA/H9ABK2gQrJyQNgQiWhOKrWpZP4bhlKj3isBRbmirb9xPzU?=
 =?us-ascii?Q?UvCNIzFWySo6QrNKzuwh23UgxQFCJ7qfJk6O1v9eMhjCrvmlS4j0976KFlfY?=
 =?us-ascii?Q?K1zo2VA9NPlhyovJn7ctv0qH4CgCp585Qbpjxq3ASvID+FuchpsubAdERyYy?=
 =?us-ascii?Q?5qN9Q3TRyTOkXKtazt2oytk+soXiSzG9TFYo9/srq4nluYbvYkUuD9ms7JdP?=
 =?us-ascii?Q?OENBe/C2PjoNsuDRgqUk5k4lxraaR7RajFUcZpdI7M/KB4E0RcQdnQQ9+sso?=
 =?us-ascii?Q?FDGbra70kLgP8N439Bxo75WmtNudfQE2oX20wmesBKd/C+SV5sV+1QouEEmQ?=
 =?us-ascii?Q?ina3stUEb1uBfds+7q1M6MuDrU7OnB9yo7cAU9JCtBfsf9Dic7Jpmspz9wS7?=
 =?us-ascii?Q?6Kjk9NO9pzEOMqiaGKh5WP/Etsn2DIyb2TBXl47ELF1e7Le4diL9tGR9/8LB?=
 =?us-ascii?Q?Vf+cOcW40K/bs/8m4V5vzFk+NYerSe9FiOh8kCuYsWrWGZABDo4/boLhf7p2?=
 =?us-ascii?Q?mY1Kl27H8oBTdyqPZEmb4PWicBHvKNQVeyjFKnZaQZo3iZsSqmiqmckS4MdL?=
 =?us-ascii?Q?zdlLzsYoX2L+RLyi/Sx8Z3oNGiWbZr3XpJflB0anKyOUmeYBVfox7AMagPtq?=
 =?us-ascii?Q?rvjjuxtG5JSO7cz1XMrh4hQAaLM5IlLIYW+Rk1n1J7zo5x4IIn7fDhCsYa40?=
 =?us-ascii?Q?9RrTgBFa9I7gjq5tCN6EQ9/sOPLdzCKcXabtRRgjRA2KrOauausCzcwAb0+8?=
 =?us-ascii?Q?6Syy7VfBFAte89UbEqhf5hpkVIBmITUu3bgQ76aU1vAJL5bCU+pmKTNJZ9B6?=
 =?us-ascii?Q?WvrhaWc0sUszc0ct4xaQmLQR166jDOjCPg4SDzqUU+fV0qdXjwYywhY8ew05?=
 =?us-ascii?Q?tDUYRZtC5jeFaL7efOWL43ogoezCxUN3PuvozbbgECpf4rVgO7ObZQ117bOU?=
 =?us-ascii?Q?ugmJfZWGtrqEJek/GVV6rUGYKHEU9z8DJbGJIhu4VEcrQUYPbwaDeaB/3Fs0?=
 =?us-ascii?Q?bCouNKtc91A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g+1rm24O4HWlLAaGKyMQ1/5UcOUznOHMlfuDLVuV9S3b3ljEaZSLyXr0NPAX?=
 =?us-ascii?Q?Z/uh15WsO13L59WNs2LFRzOE5cIzO6UANuZ46mQmHHXdZZHqoTCgeqg8zK0C?=
 =?us-ascii?Q?Uq58/q8LPjAzdRyyB8AD+eQj+j1TLiz80/QpgKHjiDjzxwGPMCidb8T9xNoP?=
 =?us-ascii?Q?065KXigAy1hN+7WmWqgYIOHq1iNwINrLHko/AspZnS73GI2IpCO45mCWbJCK?=
 =?us-ascii?Q?IGbi8I3FJ++j8XyNBmbDaM/2rJz+95+vMoKrAqj1jj2Ejf3SI9rX//+koBtK?=
 =?us-ascii?Q?hAdrfCN8mro65PKuFmQ/+PTIfpwKlM6YSk5Ajvcl8fxvHMCm6npRT2uKG0E/?=
 =?us-ascii?Q?M0hPeZgoDzSFMFAuBQfvP6yJgZH5SC5cEv8Aa7ymGzwj8Rn0Fix0uaYuYjRm?=
 =?us-ascii?Q?fEk0lhum80EbZoGkyMC59CmDb1yid3t3/DEML6wpc8SsqQjza5evRcQZJAQl?=
 =?us-ascii?Q?6p1KfheGdKUFHgTyMLtbVxeQgfZCYVx8tXkRft7yMyEeaARWjuwn97ndQVFn?=
 =?us-ascii?Q?SRpA432SjS/kuYuqHPkCD7cPDZ62mUTxPGIvH1C9yL1JdMfr7nV5e62J0Ofo?=
 =?us-ascii?Q?dobJqswmb+uX8tkOhtj+f9WCNoAguFilyOVoSUIJqDKGkpLNpTa1Pd2tJ7W1?=
 =?us-ascii?Q?kw9uhA7hHjMnLxlUsfFg24WEaTup6Is01AykoFgII+9H4/u79iQNjo4Y5Esx?=
 =?us-ascii?Q?C+KUsrNHdanbdWtgNTdmDHp32SPfSiVMw2759dzloUFpOVWwuuOiwXTwxcRb?=
 =?us-ascii?Q?PF92WjglOZzvFvOXtz0tfifze3QPYaysZY26ym6cvFAIQmDfiN0tgYyOQnY3?=
 =?us-ascii?Q?jc9a8nuX0W/S8aqVYtvrct9nqNc1CN4paRePHq4ooMpG1FZuOzb/wVF4nWC/?=
 =?us-ascii?Q?9RU5/dooRHJGFBbffRatVr0wbR78lSfEIW+XaL2fh5EWAU+TPEk4ESKuWeg/?=
 =?us-ascii?Q?ROaSf0fqCgLg1ujrlsPz+Hn0uuhxwqzesamcA/47MpX+1VC6Nl3NxLCxon2R?=
 =?us-ascii?Q?plkBiVMA8abg+6FEWugP4mkfDmajcaLtr7eMsufSPZQOjzpau86jFjbO6dOC?=
 =?us-ascii?Q?qXL82bwBzeCi61Qj+X9gzfAU4VWFhyboZkmb/GhPRjC6ZVIeITYQtDAB12Nf?=
 =?us-ascii?Q?j7QOsoHZXbHHKpuVdwbmnASYDleqoxRRIB5Z0QJN1wXeayArqkX81DuYQwdR?=
 =?us-ascii?Q?CTuy/mL49oOd92LSRFW5JwjNMckvHTZlC3GTzcUnXWynZmlL5mk2Hb4Syp85?=
 =?us-ascii?Q?K7slULq9ATigGIsompSYrsQ45WaFPhYHmsqJgtWUO1XQk13QoosTHEaIk4BK?=
 =?us-ascii?Q?oBJ2gcuzyf1L3xV9YdoIZlw+5Mg8AX9ZG9yR6Ju/62pCmnmW+OYozjSNZdcg?=
 =?us-ascii?Q?NpLIrNhdm7EQNf7H+MEsq3sL66UI8+42Dg4zhhz5GqVCYEt6o4yG5EoAmWm4?=
 =?us-ascii?Q?CPhVNtNFeQi30NkLsI4gumXDym2AAVJA4eEFm9ppn11ZRy1iSVddTjbHznRy?=
 =?us-ascii?Q?2ajsM4jCG2mCpTLSkjxtS9+W50T3dkhMPUwcp66S4yYUJ3kHjTUuFk/d9e7V?=
 =?us-ascii?Q?FtH2fDa/GIbE1V1s82ZniZjDCv7wikVhAE8aag6v8g2bc7W7+ehl65EQuXtr?=
 =?us-ascii?Q?RDgNj4/y8OieJdQj0hljhQo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f0482997-6e98-43da-80eb-08dc969de26f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:40:03.4281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hf9ty+ag2mQIA1RFiRnqAm2SheP4haodgAtXnhmnZVaHVmygfxX2tBHmE15kzBeB/cWnD4oTIQLA9boYYe7VD4ymHPjxlH3Zx4l7hstxRSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10427
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

As we don't support ARP table in U-Boot, these
connections must come from the same host.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/Kconfig        | 10 ++++++++
 net/fastboot_tcp.c | 12 +++++++++
 net/httpd.c        | 20 ++++++++++++++-
 net/netcat.c       |  7 +++++
 net/tcp.c          | 64 ++++++++++++++++++++++++++++++----------------
 net/wget.c         |  7 +++++
 6 files changed, 97 insertions(+), 23 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 424c5f0dae8..e46d519f507 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -257,6 +257,16 @@ config HTTPD_COMMON
 	    * object will be stored to a memory area specified in
 	      image_load_addr variable
 
+config PROT_TCP_MAX_CONNS
+	int "Maximum number of TCP connections"
+	depends on PROT_TCP
+	default 1
+	help
+	  In some cases (like httpd support) it may be desirable
+	  to support more than one TCP connection at the time.
+	  As we don't support ARP table, these connections MUST
+	  comes from a single host.
+
 config IPV6
 	bool "IPv6 support"
 	help
diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index 30eacca8d1e..dfa02709393 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -19,6 +19,12 @@ static char txbuf[sizeof(u64) + FASTBOOT_RESPONSE_LEN + 1];
 
 static u32 data_read;
 static u32 tx_last_offs, tx_last_len;
+static int connections;
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	connections = 0;
+}
 
 static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 {
@@ -96,10 +102,16 @@ static int tcp_stream_on_create(struct tcp_stream *tcp)
 	if (tcp->lport != FASTBOOT_TCP_PORT)
 		return 0;
 
+	if (connections > 0)
+		return 0;
+
+	connections++;
+
 	data_read = 0;
 	tx_last_offs = 0;
 	tx_last_len = 0;
 
+	tcp->on_closed = tcp_stream_on_closed;
 	tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
 	tcp->rx = tcp_stream_rx;
 	tcp->tx = tcp_stream_tx;
diff --git a/net/httpd.c b/net/httpd.c
index 31c10843a44..ad13b155912 100644
--- a/net/httpd.c
+++ b/net/httpd.c
@@ -85,6 +85,8 @@ static struct http_reply options_reply = {
 
 static int stop_server;
 static int tsize_num_hash;
+static int connections;
+static struct httpd_priv *post_id;
 
 static struct httpd_config *cfg;
 
@@ -109,6 +111,12 @@ static void tcp_stream_on_closed(struct tcp_stream *tcp)
 {
 	struct httpd_priv *priv = tcp->priv;
 
+	connections--;
+	if (tcp->priv == post_id) {
+		/* forget completed POST */
+		post_id = NULL;
+	}
+
 	if ((priv->req_state != ST_REQ_DONE) &&
 	    (priv->req_state >= ST_REQ_MPFILE)) {
 		printf("\nHTTPD: transfer was terminated\n");
@@ -119,7 +127,7 @@ static void tcp_stream_on_closed(struct tcp_stream *tcp)
 
 	free(tcp->priv);
 
-	if (stop_server)
+	if (stop_server && (connections == 0))
 		net_set_state(cfg->on_stop != NULL ?
 			      cfg->on_stop() :
 			      NETLOOP_SUCCESS);
@@ -334,6 +342,11 @@ static enum httpd_req_check http_parse_line(struct httpd_priv *priv, char *line)
 			/* expect: "\r\n--${boundary}--\r\n", so strlen() + 8 */
 			priv->post_flen -= strlen(priv->post_boundary) + 8;
 
+			if (post_id != NULL) {
+				/* do not allow multiple POST requests */
+				return HTTPD_BAD_REQ;
+			}
+
 			if (cfg->pre_post != NULL) {
 				post.addr     = NULL;
 				post.name     = priv->post_name;
@@ -345,6 +358,8 @@ static enum httpd_req_check http_parse_line(struct httpd_priv *priv, char *line)
 					return ret;
 			}
 
+			post_id = priv;
+
 			tsize_num_hash = 0;
 			printf("File: %s, %u bytes\n", priv->post_fname, priv->post_flen);
 			printf("Loading: ");
@@ -660,6 +675,7 @@ static int tcp_stream_on_create(struct tcp_stream *tcp)
 	if (priv == NULL)
 		return 0;
 
+	connections++;
 	memset(priv, 0, sizeof(struct httpd_priv));
 	priv->tcp = tcp;
 
@@ -688,6 +704,8 @@ void httpd_start(void)
 		net_set_state(NETLOOP_FAIL);
 		return;
 	}
+	post_id = NULL;
+	connections = 0;
 	stop_server = 0;
 	memset(net_server_ethaddr, 0, 6);
 	tcp_stream_set_on_create_handler(tcp_stream_on_create);
diff --git a/net/netcat.c b/net/netcat.c
index ea225c68c87..cfd39fafb61 100644
--- a/net/netcat.c
+++ b/net/netcat.c
@@ -23,6 +23,7 @@ static int			listen;
 static int			reading;
 static unsigned int		packets;
 static enum net_loop_state	netcat_loop_state;
+static int			connections;
 
 static void show_block_marker(void)
 {
@@ -34,6 +35,8 @@ static void show_block_marker(void)
 
 static void tcp_stream_on_closed(struct tcp_stream *tcp)
 {
+	connections = 0;
+
 	if (tcp->status != TCP_ERR_OK)
 		netcat_loop_state = NETLOOP_FAIL;
 
@@ -101,6 +104,10 @@ static int tcp_stream_on_create(struct tcp_stream *tcp)
 			return 0;
 	}
 
+	if (connections > 0)
+		return 0;
+
+	connections++;
 	netcat_loop_state = NETLOOP_FAIL;
 	net_boot_file_size = 0;
 	packets = 0;
diff --git a/net/tcp.c b/net/tcp.c
index 9fb80f9c2a8..c0045e32198 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -25,6 +25,7 @@
 #include <net.h>
 #include <net/tcp.h>
 
+#define TCP_STREAM_MAX		(CONFIG_PROT_TCP_MAX_CONNS)
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
@@ -34,7 +35,7 @@
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
 
-static struct tcp_stream tcp_stream;
+static struct tcp_stream tcp_streams[TCP_STREAM_MAX];
 
 static int (*tcp_stream_on_create)(struct tcp_stream *tcp);
 
@@ -155,17 +156,24 @@ static void tcp_stream_destroy(struct tcp_stream *tcp)
 void tcp_init(void)
 {
 	static int initialized;
-	struct tcp_stream *tcp = &tcp_stream;
+	struct tcp_stream *tcp;
+	int i;
 
 	tcp_stream_on_create = NULL;
 	if (!initialized) {
 		initialized = 1;
-		memset(tcp, 0, sizeof(struct tcp_stream));
+		for (i = 0; i < TCP_STREAM_MAX; i++) {
+			tcp = &tcp_streams[i];
+			memset(tcp, 0, sizeof(struct tcp_stream));
+		}
 	}
 
-	tcp_stream_set_state(tcp, TCP_CLOSED);
-	tcp_stream_set_status(tcp, TCP_ERR_RST);
-	tcp_stream_destroy(tcp);
+	for (i = 0; i < TCP_STREAM_MAX; i++) {
+		tcp = &tcp_streams[i];
+		tcp_stream_set_state(tcp, TCP_CLOSED);
+		tcp_stream_set_status(tcp, TCP_ERR_RST);
+		tcp_stream_destroy(tcp);
+	}
 }
 
 void tcp_stream_set_on_create_handler(int (*on_create)(struct tcp_stream *))
@@ -176,28 +184,40 @@ void tcp_stream_set_on_create_handler(int (*on_create)(struct tcp_stream *))
 static struct tcp_stream *tcp_stream_add(struct in_addr rhost,
 					 u16 rport, u16 lport)
 {
-	struct tcp_stream *tcp = &tcp_stream;
+	int i;
+	struct tcp_stream *tcp;
 
-	if ((tcp_stream_on_create == NULL) ||
-	    (tcp->state != TCP_CLOSED))
+	if (tcp_stream_on_create == NULL)
 		return NULL;
 
-	tcp_stream_init(tcp, rhost, rport, lport);
-	if (!tcp_stream_on_create(tcp))
-		return NULL;
+	for (i = 0; i < TCP_STREAM_MAX; i++) {
+		tcp = &tcp_streams[i];
+		if (tcp->state != TCP_CLOSED)
+			continue;
 
-	return tcp;
+		tcp_stream_init(tcp, rhost, rport, lport);
+		if (!tcp_stream_on_create(tcp))
+			return NULL;
+
+		return tcp;
+	}
+	return NULL;
 }
 
 struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
 				  u16 rport, u16 lport)
 {
-	struct tcp_stream *tcp = &tcp_stream;
+	int i;
+	struct tcp_stream *tcp;
 
-	if ((tcp->rhost.s_addr == rhost.s_addr) &&
-	    (tcp->rport == rport) &&
-	    (tcp->lport == lport))
-		return tcp;
+	for (i = 0; i < TCP_STREAM_MAX; i++) {
+		tcp = &tcp_streams[i];
+
+		if ((tcp->rhost.s_addr == rhost.s_addr) &&
+		    (tcp->rport == rport) &&
+		    (tcp->lport == lport))
+			return tcp;
+	}
 
 	return is_new ? tcp_stream_add(rhost, rport, lport) : NULL;
 }
@@ -390,12 +410,12 @@ static void tcp_stream_poll(struct tcp_stream *tcp, ulong time)
 
 void tcp_streams_poll(void)
 {
-	ulong			time;
-	struct tcp_stream	*tcp;
+	int	i;
+	ulong	time;
 
 	time = get_timer(0);
-	tcp = &tcp_stream;
-	tcp_stream_poll(tcp, time);
+	for (i = 0; i < TCP_STREAM_MAX; i++)
+		tcp_stream_poll(&tcp_streams[i], time);
 }
 
 /**
diff --git a/net/wget.c b/net/wget.c
index c91ca0bbc90..500cb58d777 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -41,6 +41,7 @@ static int wget_tsize_num_hash;
 
 static char *image_url;
 static enum net_loop_state wget_loop_state;
+static int connections;
 
 static ulong wget_load_size;
 
@@ -119,6 +120,8 @@ static void show_block_marker(void)
 
 static void tcp_stream_on_closed(struct tcp_stream *tcp)
 {
+	connections = 0;
+
 	if (tcp->status != TCP_ERR_OK)
 		wget_loop_state = NETLOOP_FAIL;
 
@@ -223,6 +226,10 @@ static int tcp_stream_on_create(struct tcp_stream *tcp)
 	    (tcp->rport != server_port))
 		return 0;
 
+	if (connections > 0)
+		return 0;
+
+	connections++;
 	tcp->max_retry_count = WGET_RETRY_COUNT;
 	tcp->initial_timeout = WGET_TIMEOUT;
 	tcp->on_closed = tcp_stream_on_closed;
-- 
2.43.0

