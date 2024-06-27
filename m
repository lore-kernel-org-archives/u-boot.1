Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C46C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B95885EB;
	Thu, 27 Jun 2024 13:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cE15/gwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13C6885E4; Thu, 27 Jun 2024 13:39:56 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF26E885CC
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdmwHCdnv/qbznSi89u1DMEFPCG+BDJqBMOk3ljU95HaxhOJIUS5Bzb7S0g159v6Tmt1NPDc2030NtwfHJzJvmWaYT4TNYinn3iEKj/tDH9s0AYeQa9Nx/djUUjrUKiuF+yfv4OVPwAy/8LYaUX3O2YZqrprrFZMut1ILFdGdf9zGeGwPTYynv9xXfIv8kkY/5f4KIb1nOZeciQTaduxuJvUcj/QK+xYL2AXeXn1V4sjrZu5um5SR8HCKqdEbariKYKvTeqiP5r7IyD6OQKmPhPYDm3nqxXdKRn6BN/i9LYlinmlka2Kwm6joBkgxjPvZmTu2ittJv2kcm71HyXDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asRGgHwwsKyhCAK379dkHSEB5KmXCq0/XVkvSNT1vfk=;
 b=KdVbq6CTWBJxwfgnkFJG3hKPVOPYC87VRs13mCw2VK3Rbwx+KCNQ9wRFW6F9LleSGVeeyiTL68fpyQoU1vc9YLcomV6ocQukaZsUqeIrufdwAg2Tgt432QdsNjbY85VIUOmjEGnTxWLDVAd1dn9hF719buM9/edfzmmXzkQRPtKNC/D45LQzfSWDlxq6ngJD+NtZdKKLpfLRyNE6zjtH4Qod/hWMdcTPFNzn5RuKeHbg8oMytCXJKyM/IOLHGJbtOPs63KylYJkUX9fWTpmn3+pfXcixa0uG3aF2mcOCR6iNhokksXYOAWoeIi2ai6zBXABI76+N5X/gAuoXnJ9EfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asRGgHwwsKyhCAK379dkHSEB5KmXCq0/XVkvSNT1vfk=;
 b=cE15/gwyysYqpttLBJPVDC45IPzD1M4K5iwgQr46DzxY1TfVJDhhDGN8bXsraubX7gjM7Kp1ixBGj0bUAzx9q9LVUP55IXscm5DdY7sYuxtlwutHi26GiI6rK+8f+euiFYlElz6bF8CAxL43Kl5u4lq4Ar3j3UOPcC4F2DeWpcRvZpSeiZuVP9QJJe74ZmV+62oXrLTPe6okL+hGwu+uMZ2W09oOoWoYT1E+23De0kn8FAwwz7di4hQZNCIMHJGNTZcasSVTjDHyRf2Rbtq1lNfTQVqYtvR8HoCKPvgIpKkFeomv5cMR7owgvyRAzf/wz624WcfUAIFx8bYXsp1eoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:39:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:39:53 +0000
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
Subject: [PATCH 05/12] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Thu, 27 Jun 2024 14:39:32 +0300
Message-ID: <20240627113939.100620-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7b0bd18e-21d4-413c-a271-08dc969ddc8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ei7m+FD0ovZVlOPijqsA1Hk2TjO9faFRMR1/JL0NuUN6WqP/rdQSljtkydV0?=
 =?us-ascii?Q?xlzKrYfWsh05eVacxhPmXsU9R31Z9A88iYRXMjK1g/mbhhsfAxZNtWkPc7J3?=
 =?us-ascii?Q?ESSjcoGW0kvkBQP8dMD3aLyVEFlSknMNJm9A62K/+WEliuzxi3yOWTsMmGmP?=
 =?us-ascii?Q?MLlbR/Vv/N0BIoZco3JNdDZD1+RLmVoFZeHOua7debIFx862rzUV0frebw6p?=
 =?us-ascii?Q?LlBqp5j+a9xCVarhclfdAYykpbc/Zv3hbg2zyHRN0MRKNKO5oEtX2a0QoKWD?=
 =?us-ascii?Q?5kvTA7pjDv6Le693R1dkmg18AUz1pxUkUCfc1hvYGBUe9VfxD3TYRl5FTKJ1?=
 =?us-ascii?Q?eLh8EkKeth6wPPPp470C7Vc7pYOkHewTzaASqe38v+pOV4U8ab+hDWlVX4TN?=
 =?us-ascii?Q?WUJCie/NlWQ+fPoDOJwr5MFZsT4khpAvac7rxCr16ANaU09l1DFcHxgcPhJt?=
 =?us-ascii?Q?u6PWBZBFSo/UeDVC/W8g7W3GsomRUScl46LLs+27xruD9QjYqiz+MWlfj243?=
 =?us-ascii?Q?kkm2I8ps69OFL3K4iJ3LRBS0klVMlWkKbEVF6hzQxkj37QkzuAdttlLHJBAQ?=
 =?us-ascii?Q?zK5qbD/tDQrs71CHbOQBLPeht+I5z7oPZqeZASi0+16ZfklmUtB/TXlbWa2A?=
 =?us-ascii?Q?IRqIHSiMmIzff0wvNCPHB+durPQjb4796AXscS2CqPQBK6tudKDLFbYVMYLt?=
 =?us-ascii?Q?9qjh5gzsjB2HaZU3Nil170X9lmLUlDunjbLaDo08F85w0RkP9Mth5KTv0WEn?=
 =?us-ascii?Q?0HBmc4rcWZM7k/8ma6mZ5Rd7upcXZQclv+DziYHS1M+0s6eeS+OvDre3nAv2?=
 =?us-ascii?Q?kPmS88zeglq2OBb12QaRHviyh4M16bOJ02CH5UW1ximI8neoD9cZ4Yd+A6Db?=
 =?us-ascii?Q?8amJXX8nSQ/r0CMWs0YzUwYDn8oylesrFr/Vt6szHXkJxl6JiAWMDMnrKh7a?=
 =?us-ascii?Q?TTHp5jeBmSLgiOhDMYbkSAiFJesFH2bXkItDyi4o3PVHHGV88/iFDarQI5kt?=
 =?us-ascii?Q?PDxGCjEqFYxg1LXc1TKw0QaN9j8KysG/NhoJggizw1MlH96Q1B2+V65+BHm/?=
 =?us-ascii?Q?gLjtrEaj80enB2cLwLNfeSHDoTDoVO3R55ub0iE4HgDVaA0VXajr5fgiKhRz?=
 =?us-ascii?Q?yAqKKVLu44FSoresg/hq1Rfo/D18Tj2WeQAw7Ty11NzKY3E3W6ccqQUnFQRx?=
 =?us-ascii?Q?qTIzS/wvTYXFp0dnZ5F0S2KVevWn3iarRmm3lkkjn22K+LpPM/Sm6NWAkKb3?=
 =?us-ascii?Q?+MMk+pCbjshAdxpHnm4sISMnvulGiPZwTxfy+nz++IFXzucY4QlkZZpgWDsc?=
 =?us-ascii?Q?Q/T+IDqKTjBDEMd/0+BgO2LYFNdaoK8SrA77oUrSyHP+wK05PctWeYJo8xCQ?=
 =?us-ascii?Q?cdX4Az4Es9eSTOip+ssPD1n50JvZnIG/sSh2d+p1G7fh/4uGdHTbztnBTZCG?=
 =?us-ascii?Q?YJHvr68Gvww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92xTV0+XwhXCStrrojdOZ6FGq5+XVMFEoF7dEe0CT3EMAAQWsTqYs9MlZXk8?=
 =?us-ascii?Q?t5H9qvshm5HWEbhZKbi0ifW6lJiPyuyk1iKkRIs7W9R4WanYdjfe3CwsPvaV?=
 =?us-ascii?Q?V/3LcskBb1g9OzzaPrsYI0tPY4CqHMmz1DO45zTLiA2NPi2UOcamLSv4f5+D?=
 =?us-ascii?Q?j/aXCqRgbGVrw9BSBUW7reZ/xOoJKSu7HalWgPWVzoByfrChHMZiFcM/jOys?=
 =?us-ascii?Q?hCIOfYNeblWZS2d1FytN8oQCseFKbvMS8JNvt26w2PHJJGDV8d4w9LQeAb8w?=
 =?us-ascii?Q?Kiib1yJOcZYL0rXZSdNnG9CZpDKHvkrSp3J2Nyw+GfcZy7a+rGYuRWMJrsyC?=
 =?us-ascii?Q?Pn8rW7pkq07PjFY9k7+5mj1PXbkdTYb84ITUQ46UKbhhakxwveUxX7ODibE5?=
 =?us-ascii?Q?ExHwAeu/nC79o7CWVwtINUe9J99WzNszhuVSB+qrfLP6pye6B08N/mKFeIWQ?=
 =?us-ascii?Q?uqqqd26GRiW0DYGO3J+7RuB8hLjzntsoFgmIjXZIthiIkWfjdsXuBKs5sSmg?=
 =?us-ascii?Q?WxU+vNs6UOfN9nCxe0F7ld/wB6fLfh7KNYQdXZvPt7LldROZQBv7Wm5qvK6a?=
 =?us-ascii?Q?dJk8+d7KgyhlIHD3w2ZixEDGoj4G5YO/FxpJ1rnZqD9DHjZRiwOEKHDs1RCx?=
 =?us-ascii?Q?cjMI27Ko249pc3Fe5nVeqOZLb2ZkZPovnOJvk5S31WKocDoBJ7yg2RJ3v/nV?=
 =?us-ascii?Q?G8AekKIxOHa/HaE6AZ8KhtdUR9pOJiSVvde00/PPkkXMvvNCACtLkXR+3cPn?=
 =?us-ascii?Q?qeYsS8eALAgVj/RHgTkxqkF9hoeCEwGSAJhLM84j8Y5oIdkh4TAlmgz31IVa?=
 =?us-ascii?Q?TOq0iA7FK7/aksrLTfJSuIKE6IICLFlqEmyc05nwb4sX7qjRtrEwqF+3vLTj?=
 =?us-ascii?Q?pVag3EZ87IYA6stf5SfePtKvBL6OZkElpsVgZNDA18oXzcOXjsPEr7RmPaEF?=
 =?us-ascii?Q?FinbpJksAwzwgoVVwV3xOQ58Z9ZMTW+/LK6Q/hShh6NctLND4LbeJu+jHFKF?=
 =?us-ascii?Q?u5NxrMK/19DVQcixNZkRs4H2WW3zIQ074Kjm9yjstOwWa9HFwQ3OB0McS90Q?=
 =?us-ascii?Q?WXa6zBkFcf528jiDMBMaNXbFs73v+Pgxdvdx2fENoOgEhYJ0bfWLQagz4ddo?=
 =?us-ascii?Q?9+k5PjbSyHHGsPdkWK8xku97354DZLEmzVUKKi/2c7Zp0fNoRc7vvI20vdSo?=
 =?us-ascii?Q?Tiw3FIFWgZIs9xcBoX+gFNKEkvZRoZv0Hkc2VFHgRh0R4K9K2IuIKQLCZP7+?=
 =?us-ascii?Q?/3EFjA4lC3pvW1csBeiqTqNjL6fHJQr8eGkpkubtJ68MnxLUBvygNxTyzIih?=
 =?us-ascii?Q?+upi6lhSiolpLqq0jTNNVvoZ2McxSV9boHh9Trk8IzvoRYy1lxnEgxMy/ARr?=
 =?us-ascii?Q?8e6t4VEHB5FLinKIgDnn2mtWNV2VOs3oTi7ZPZuo0kEBvAi7j0lr17idKN+T?=
 =?us-ascii?Q?rxXfNqQjGH3s7KwlkVPnOU7tTMA27i9a/M/DevQhqAkaGMlAK+5r3W6vYys7?=
 =?us-ascii?Q?+jZMbcTZc8lLXndM8A1nVhAQTdzR0oQP05peFND4wQn8CDDTL1chtf8FgpAc?=
 =?us-ascii?Q?z9onTTTIeie00a6J7o4E9GKVJsm3lwEyyU7QJY6+wlwYOFUyeIHg/YqJQpN9?=
 =?us-ascii?Q?uXNRog/kBG1P+Nms3bFdVNY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0bd18e-21d4-413c-a271-08dc969ddc8e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:39:53.5583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W5c6Ay6bpGPPWr60uZM4tQ9ZcREb2V2mFNa8Rf17gtDYNdG4t5QaEjJh2qad09invQKSlBVoBwPytCK8SnCW+7CkHFZpFUyc+YUUvmqR5w=
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

Use the names from RFC 9293

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 include/net/tcp.h |  8 ++++----
 net/tcp.c         | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f224d0cae2f..0694af9d5b1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -285,8 +285,8 @@ enum tcp_state {
  *
  * @state:		TCP connection state
  *
- * @seq_init:		Initial receive sequence number
- * @ack_edge:		Receive next
+ * @irs:		Initial receive sequence number
+ * @rcv_nxt:		Receive next
  *
  * @loc_timestamp:	Local timestamp
  * @rmt_timestamp:	Remote timestamp
@@ -301,8 +301,8 @@ struct tcp_stream {
 	/* TCP connection state */
 	enum tcp_state	state;
 
-	u32		seq_init;
-	u32		ack_edge;
+	u32		irs;
+	u32		rcv_nxt;
 
 	/* TCP option timestamp */
 	u32		loc_timestamp;
diff --git a/net/tcp.c b/net/tcp.c
index efa12c9e8d3..2a0dcc4e771 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -361,9 +361,9 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	pkt_len	= pkt_hdr_len + payload_len;
 	tcp_len	= pkt_len - IP_HDR_SIZE;
 
-	tcp->ack_edge = tcp_ack_num;
+	tcp->rcv_nxt = tcp_ack_num;
 	/* TCP Header */
-	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
+	b->ip.hdr.tcp_ack = htonl(tcp->rcv_nxt);
 	b->ip.hdr.tcp_src = htons(tcp->lport);
 	b->ip.hdr.tcp_dst = htons(tcp->rport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
@@ -397,10 +397,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	return pkt_hdr_len;
 }
 
-static void tcp_update_ack_edge(struct tcp_stream *tcp)
+static void tcp_update_rcv_nxt(struct tcp_stream *tcp)
 {
-	if (tcp_seq_cmp(tcp->ack_edge, tcp->lost.hill[0].l) >= 0) {
-		tcp->ack_edge = tcp->lost.hill[0].r;
+	if (tcp_seq_cmp(tcp->rcv_nxt, tcp->lost.hill[0].l) >= 0) {
+		tcp->rcv_nxt = tcp->lost.hill[0].r;
 
 		memmove(&tcp->lost.hill[0], &tcp->lost.hill[1],
 			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
@@ -435,7 +435,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			tcp_seq_num = tcp->lost.hill[i].l;
 		}
 		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge(tcp);
+			tcp_update_rcv_nxt(tcp);
 			return;
 		}
 
@@ -464,12 +464,12 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			}
 		}
 
-		tcp_update_ack_edge(tcp);
+		tcp_update_rcv_nxt(tcp);
 		return;
 	}
 
 	if (i == TCP_SACK_HILLS) {
-		tcp_update_ack_edge(tcp);
+		tcp_update_rcv_nxt(tcp);
 		return;
 	}
 
@@ -490,7 +490,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 	tcp->lost.hill[i].r = tcp_seq_num + len;
 	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge(tcp);
+	tcp_update_rcv_nxt(tcp);
 };
 
 /**
@@ -567,8 +567,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 		debug_cond(DEBUG_INT_STATE, "TCP CLOSED %x\n", tcp_flags);
 		if (tcp_syn) {
 			action = TCP_SYN | TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->lost.len = TCP_OPT_LEN_2;
 			tcp->state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
@@ -584,8 +584,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
@@ -634,7 +634,7 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp->ack_edge++;
+			tcp->rcv_nxt++;
 			action = TCP_ACK | TCP_FIN;
 			tcp->state = TCP_FIN_WAIT_2;
 		}
@@ -749,7 +749,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->rcv_nxt, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -757,7 +757,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 */
 		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp->ack_edge);
+				    tcp_ack_num, tcp->rcv_nxt);
 	}
 }
 
-- 
2.43.0

