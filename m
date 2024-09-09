Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192FAECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D0AD88E5E;
	Tue, 10 Sep 2024 00:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DrlbjRvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1CE88E7D; Tue, 10 Sep 2024 00:27:46 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9023388E8C
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrKMrv/dnnB9bCtWEtiNdCCFLIosKFSAHhoqOND/X/A0lj2F73v2tdXuwXMY8T2ed1ViuwfZluTumGWLV1UZaI7O8CoUoKgPKJjmQSLAMnteRnXHlhezruMOqtqOfB9MBvqAU0NNwk4fGEYu3sNV77RKCO6Vzm3dUXejTKzFXdXE/Opnyh5nJM1kDFF2n4LhSvR3++ENG9ZzlmJ1w1c1wRpoC/wkwXVAZdUiELv93NMT8EcfTLLP/NG5KyGzMDPZA214QJws+QpzObX4rNipuwcHkAbtOmUp7AbziKi0v/u0zruJisNSzkHJClRYRlveBlD0/3F/KOr/5DvYILXSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14Vmr5zmk1cTTJ3JEai1pGMQviXVFAkora9Xn0fPIgg=;
 b=Ns5//0CnxTCyEXdQXfbRH5zy6RcBSDZvtRw9VR1RwvsqAqtgJvXNX58oimRELK7dcuO6HSy2lIsVhC5COizrUsC35fptfKRV6rSuxtCzWQJMQvJ9gU6NzK0+8k2hfJrLha70hSusDganVGW10wkpiy9+TSu3W668NIgsxYVJxYfAIaKy9mHI4Uc8F17G5yv6JPcmppC900hWn0dgyGyn8p98VRIMHCSs7/Vd8J++PpvJwjLYByrO2zOP+1rseoR/v35gK30E569/iQh9yk/PddXn5FPmZcF6NAJe4TijpjS4qlbjQ1ateZYzJGrN+eKKc/8UTuuvRnv3AVGGKR18aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14Vmr5zmk1cTTJ3JEai1pGMQviXVFAkora9Xn0fPIgg=;
 b=DrlbjRvqA16U39LlNVLcSikzspuT/xdE+AQg9qTCdgCHIULFFoCDOJmmmBrVkS3KDGJWk7DlNaSKkzkjcXUq6vGIbr3qxYgHxvm56nLsD/dJA0kuYHd8c60nyjcx+K7R5nhnNzpodSAsE10BAm2TuzXYk4xPFeEXVoH2r1b0EdDqtMo/2crG+Q8SVJca998qsQYxg8VJhsjJzxEYcP7t7fZ913Vd2TXzy9Yg4hEpXUKkdeK0WM29qMqutI0AC+sf0nX7jqHTFku7Yd9BMv959hT0HgTL9epChiDkaLegoiyFPrdDEpjeSeTJpGZpx3AgsiPuGB8I3tZ4WwMBZFRGTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v6 07/12] test/cmd/wget: fix the test
Date: Tue, 10 Sep 2024 01:27:15 +0300
Message-ID: <20240909222720.2563118-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: c79ee2b7-ae10-4806-06af-08dcd11e9cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Z74lZcfBy/dEuip+imC8kNEUh91x0tP/QumDkqJScI1CF33Mg/VKFyrn8et?=
 =?us-ascii?Q?NpF/33DtUXTPkWpO8I5o6HelUHqVTtcyxPhaMR1o0L9ua/GKBuArhmub6qsY?=
 =?us-ascii?Q?AhDREDXVEz3v408IqZ+qgxs9viKqbLjzMZtG3j1FTVcNO5PxxeTU687Nk9NV?=
 =?us-ascii?Q?Z+ya+AIDuqY+0/Cldi4cXJMkM2ISkRzrVrcUh+l2iUWbf86vN0zeCunNBJZQ?=
 =?us-ascii?Q?Sbgc/5p0WOk8e3yeHMxNu0+JvTlOZx2F3bADtwRiosHxXOSd3y1yHm0DYunL?=
 =?us-ascii?Q?p6wjp7O13dRLkZRTKm1brDttQcR9L4sPpZO5Eg0E7RhkvcRoTEltDHVlCSmM?=
 =?us-ascii?Q?ryf+/VJMhgXsqT5Zqdyho5uCy6o2y8bayL2fSJuV7sEl0QQ0c5c59xExw0hc?=
 =?us-ascii?Q?gCpR4hEdg/tCpHk1Rxogj+9dW+eMjphvaVr7vPSxKOC6kKk0pKj0JYkhX+gg?=
 =?us-ascii?Q?iFwH0wipU5q2c47VRoM8UXRVYIG1xnVPEH8f5M/9tExQFfCwINy9iBY1gXjy?=
 =?us-ascii?Q?I3aFDhBQfCyZc0ZJiNCCZrpGlu09Cb9GXxoUIyWJVtkj6qfpMCQPyxSeClZI?=
 =?us-ascii?Q?EOJHv8PNzjwN9QHBWSSMzXkSCA0cJrDQyMR1UsrsQUiD/0blNmJO3AmoI2+v?=
 =?us-ascii?Q?jkrlnHG7LrLBFvaiSOT7H1hEf+Auyyjbx/gr3+ponhmPzAn4K6WDCnUvXe1S?=
 =?us-ascii?Q?VwTe6yQ3bY/1W8At5ycezJ5LxUbNCrBe9bwwH+nymMlhYFHm7kpWKx7nN7DL?=
 =?us-ascii?Q?KkZ5G7MMnDnwC3VdwO4jZ9w/zz9weciQZJDV+uRGlhULqgYwX9hOJ56H503T?=
 =?us-ascii?Q?xWTgdkx2KconIv9ChbHkJvqOPZK92mShWOTNdc91TCy4ZkMySoUl8yl91whm?=
 =?us-ascii?Q?8lzth4tSSNCF3n5RTV85y4j6PcEqtrvoBTkZAMutgPs3Xfh/f2Hva55ovbQY?=
 =?us-ascii?Q?caCyzvfecZsfNgBbnle5sejAoZJuRFy4jy/OOJ6ed9V+XC1lp4yB8gvUCAbx?=
 =?us-ascii?Q?U2C/WT2PwN7wwyNG1XRbEGTxc8ba8qlZcAW7YgxlBR9bGHLzXZc/O8GLQAyi?=
 =?us-ascii?Q?3/A1SF/a+23dzLiHD97xHumxqGEV1HTRXEtG02XEkNwZ/3FLdPgqQJQBF8Q7?=
 =?us-ascii?Q?VBdyOmJEjE4FeR/rGIO+V/N1/VHgneLzKcMfGbOf2HCui4+zZMDe4QlZWUej?=
 =?us-ascii?Q?kdywzCEGZmlGmXqGEEsDim/IpQ7jWgsK7XKRFGn36ElNiMbD1Ho/e+IvbRMD?=
 =?us-ascii?Q?6beLs1woQ9oQwgbUMz+WLRVW0TwoHSwPmUT3PPjtdOI6ZP/f63oie2yyJs5O?=
 =?us-ascii?Q?fxUIWdVm1GQ0SwfzltLmF+hyhOvH+F8boF00BOtdTPpj//4UssPcZAXpH4Pa?=
 =?us-ascii?Q?UBq2MKUtR4xStyhPJqR2+2UrQJk5dt8ndWsx7bjPcDgN7VAH0r0V/eDcLW16?=
 =?us-ascii?Q?5p684OgSUb4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k0/yFczuYC7HFKYCA5C7g4QMREkFz2YROiY1V0wCAmNFj7UM/8hIyv+6BhME?=
 =?us-ascii?Q?omv8ziRtHqwjNSdHN00HZTLJWWTnKcFJLiYm1tKGzRQPaAy7bCAVjcibmw4R?=
 =?us-ascii?Q?Naeea17oi5OW9FP4e4KS3Uw+smHFscTLEW00sOaOsJSlSzRjdVJIfEypu993?=
 =?us-ascii?Q?HiqtxyAvIQuNQBJNWtHg7Z9DTxx3h+4qcn8Vo45YzeqgHLiV4n0tyWudXxKr?=
 =?us-ascii?Q?4ooE8RNIfj9lYjS0WVzWiAVlsBHU301mS4clfcErtYi+cpUlegsh+wrr6LyD?=
 =?us-ascii?Q?drQ4fYI/S1xZ8ohzTegMQ7KS6FvIEXqh4X4iA2MJx4PrQIzeAmFcqMh8THHB?=
 =?us-ascii?Q?5QnyJdemuWqdOMR+GsfNXv5MAKkGjl6Homz7XJlOefMNX4hOqDRajlecavAQ?=
 =?us-ascii?Q?DJvmE0Y2N3tEn5gLcwMMYKnsxNwq32pQ1yW+bCbPK8Rz3TDzyEt8J2LwLxrj?=
 =?us-ascii?Q?HpIQQ+9dlE2x9nPqycHJ4EH+wSjhpKRkM3O8hjPORW8rxtTTZiL8g4MrCuSO?=
 =?us-ascii?Q?dKRz4aQOkx+zK0DBjfVdB9e/CmanVzTVH/LRXrhWBRbsh+o9UlsxG1yGZzhi?=
 =?us-ascii?Q?fvAv9LYOUtOAN50XVuE7rYrE9V9fcQKeiR6XVcQjDE+2sXzIje0gNsHhs0/H?=
 =?us-ascii?Q?XJPP+LkvEiKDMvHC0XlSKZ4zAc71zSJjsre1TKr4LADNpnb+sEPdne7vf5oF?=
 =?us-ascii?Q?btjesB4/HolcUdUNDayA/mXZjnZvajiyx1eM7VG8aopr+MuqHqXKC1+OVR5o?=
 =?us-ascii?Q?6nHfib6xzpdxn2kTPJWY5oHTn5Ut/cHnkywO0I47SgNKNJFb/ZjyKyawYvZ6?=
 =?us-ascii?Q?xa44xxppcO6Kd6aZIxrbax/dqKSgrHMOf0JvXXbLjjepmgzyygMEl/pfw9pr?=
 =?us-ascii?Q?GlTgrhU5MKDh5wd8+6eKwLwXoUVkkGD0+NuSu3jDHat7oMOs+udNFrdcDseA?=
 =?us-ascii?Q?WYn/w/cr4jszeOOmI8pZ4GnJvaXk4Z8uYd6zPamu+aLaCP+Csgz0xyCrn6Tm?=
 =?us-ascii?Q?MC0eXl+a4dBb+rvdM3BjxegJRnMXFKE602+qj7K5dwy0KMxRWobW94CA/6Mx?=
 =?us-ascii?Q?fu9AZ5COWcwnY2SuzWk0qBQmdj9rdjoyjCwI+gEE7d2+a2ZlcCklecvnErT4?=
 =?us-ascii?Q?7wfDDTYHxAF9e/8QBoivLaGSKC0CNBVABphPH9EAIZAEeIfuaNVjYa6nNgvF?=
 =?us-ascii?Q?iecFslJuvD4/AcMCgFw7yT1pyCdhaEsAJbB0Z4h3bsH3JdAjQplNRb7KFWQg?=
 =?us-ascii?Q?2OBq3kCNzg4v8ZQhDulDWFDLJ6eWNQpcp+JT5GU/68SSSu+0EC9pu4cQo2IA?=
 =?us-ascii?Q?Pcf2HAryVZyfuVtMpR20ILNlYtf5AMmENHZUWlF6ffVkirbCmpsGPs5Bq7QR?=
 =?us-ascii?Q?o+0fnk/B6zsSYq4a8Y4eg8LWR5fCGD43Ib+ZQa/5JIEyEFfDfi2buAkIckoL?=
 =?us-ascii?Q?hGKuX3m6+DSY3EI1cq80+0PanK3UBrMG86ZtZWQqnPvysSolANcGltfvj9GB?=
 =?us-ascii?Q?I9oFTffaqWwguXxLDnBVdbRwN+4lptcBEmj5j7eIKudyd57SrnXzuUz6M1Io?=
 =?us-ascii?Q?SjxT1wPuewwoJO3rYqakylCgOr+HAIxcEom4iuRxZcccUG+jSpEg2Bc3Yo9D?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c79ee2b7-ae10-4806-06af-08dcd11e9cda
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:39.1814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olwSt6HRlm4E5AV9HGxxJVd8ggxSKrQ78IDXQ7tbomfxTlCWBs7U8EMp70sDX1LNthap9gEBL/hLL9Ldmc9sbevTP8vXtB1i02dapdL1pEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8722
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

