Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C25E7718F
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC1D804E7;
	Sat, 28 Dec 2024 11:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kXzWzhwh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556BC80362; Sat, 28 Dec 2024 11:46:59 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CDCA8051F
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPOiWKMP6/eaNAtwsfAkBEVySN33euB2unFsDWjRMwleMJCKEm7xRir9t7rIEaHTjZ5HHUYvmVZuuSqPy6CzUDmFxYbQu81oHlTreu85RaDdSmM7jrQGeKDfWSpC0b8p5lO22+YF6mXWmgDeVilnOXsOQsIkNA1od4K7HkCS7EHhM21yOvnsnuWfoPm3YlttdPo9Ga23sN73WPlR6vmNjJHq0hyBaPy6Cwn/BJbruDw1odYjALgcvUZ+ZenX7mFm9AbaoryPODABgHCFEAl2XXD/dbbZz0ZDQhSCm7JgbUaWwo6YGvJl1YPIJ/L5mUsbhKpsnh/UX+5osgOqcIMOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCiuhRH9rEnOz06Gx1j3XBkMGWrTEPLH1CgsvrOiQVg=;
 b=sPsefHTwCFnPjW2ILnImjIub7zRw+kT2FoMkcLYG06aKHL6gwAcdbQCq6K0Jlb/i7jistNK2vr3vfu0SJdAgeMQwX9OBcBuqxt3XWo+R5+VewNw1kSPixxQ+OL7xo+ueMxCDw3qNSFhS0Vf0y8COT+UtIGlYZBMBIWk4i7DAeAOefc6jQM8VJ7bbYB5Q7UwM96Hj7kD06tlDvEVDJ1kfWbzHe+q6yZoyrMgyGdyEkjSIX5nCDLv78b4Y5o0YfKt3nUKYkDZFC2TulgN0MqD+WeU4ZMS5eOjROC+PIrJBwx5bi418MqkLiSMkirsZfFV/cOm//1fJ/wnCvNSrV4MKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCiuhRH9rEnOz06Gx1j3XBkMGWrTEPLH1CgsvrOiQVg=;
 b=kXzWzhwh6DIke8WR4836TMLqAnexvqIam2cqxibuBecVt7V02MyWNPbq4czkNfwgBsqayJAkdn3k3zLZxjRoPUsM/ISMu8PA7UG/i0hi6g7NM1MaAsJyjpBdsYXFpBPxu1gb+h6aSa0YPbKRdL4piq6WuctFdAiPquY7vIEEKII+pWzUao2zocaoFtu9GWmfzJrt0DLCtDLTnmFoGtb6LgbPIePLlKvkNB2ueQt5NUeVDrRqTCUmiViC/1dXPsy8Vp1aXmkalHgYzyaAulY2Fpbt99rfaP6wkVXT2lhVulW/GAmMis2v8xaX9oCNs8Ta7BzfLNBHt8jg3N2Zlmqhtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 05/11] net/tcp: rename ack_edge and seq_init to more
 common rcv_nxt and irs
Date: Sat, 28 Dec 2024 13:46:31 +0300
Message-ID: <20241228104637.4173913-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 04687f0c-df16-4fe5-da84-08dd272cf02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MZKaOv4NiQpMHVvxLqDBUpXBv599t7GC63VuAm73zr/7kM5iV0yiy9flaq64?=
 =?us-ascii?Q?FjDehU4mkJ1QeHKz0AbS8J5NvB6FwPNXYWeOA2p8zU/H2uexsTJkK4GXx3+Y?=
 =?us-ascii?Q?ghWn6tRodQiPevdmQJVSEpqtWGxl95EAC0d1k/olNeDTofzLZ1usF9K/WGDA?=
 =?us-ascii?Q?col0x46SzzLCKJTglrhp5sjb+IqjlcAoFSstosYvwvFpxhzxVOqEY18cov32?=
 =?us-ascii?Q?loCMnPEzNoZdhIkxHwvJawhTBTB2hyoKYG6Irddikz2qDIw2Q2+UCVaN3Lzp?=
 =?us-ascii?Q?8vKcK7U4V7yO9bgWkWGKUpBZD7utdNxc+zBmy0nb+fmB3TpTH1rfKJh1HsJv?=
 =?us-ascii?Q?7nucL+qGlI00nrslBJFcMOOW1YVpeT7zfv1IlJsEAV2x2RG+kVQGh7vN72VB?=
 =?us-ascii?Q?bs5G9Dg3OcBZA9eMay06SMlEH53xv1Jto7bhXiO+3qrDE+LzgY1r/lJceaiP?=
 =?us-ascii?Q?Ub2ikVwTMNBIRIxWWSdBk/dqg9lS1iXtnLF70slerXdQ4P5hJs15hqbl22oL?=
 =?us-ascii?Q?AyGuiWg/KpDw0UVK+VIbgbw0mBMTYyi97vmXL455cJ2cuEidWutHTssnxUnl?=
 =?us-ascii?Q?NEEXNHneQBu3xfv/tQa9Gn73Rc7D+E0KPxT/3l0R7n6ktyb5foZllFOTPwQS?=
 =?us-ascii?Q?zMz44ePyEaUlIygZ6dKZeDgwMb6FbGQjBCwMtiqH/MYchRnW8kiT94yUve3Y?=
 =?us-ascii?Q?K3nJfa3QSRdXpPrOqTZhcZJ0gGxrVfL7vuMv1WotaLM4sXlVLoXVfPX76wAq?=
 =?us-ascii?Q?1Ms/LIcxC8akbFiYNPnnIg7qsOxPSbD2Zxrc7A4zEzcOCbmiHORa3S1rWVUL?=
 =?us-ascii?Q?RGxo/UvMmQna1aKG1dsAkrPXDsiB0ikfpC7e5gpLM1CM5WHpBFtibEQrKcAk?=
 =?us-ascii?Q?06HOxN7fxjnISjeTaJ9zRx9UCiCma/YOv2nIhb6UbiIWrmMg6Fby6DLvQhms?=
 =?us-ascii?Q?YyHsVYxMptx4UU9YT6Djp6NorgVJE+jmii6DKCbr+t6IHO+JO8cf8DQkGYPg?=
 =?us-ascii?Q?zxK9eHuUe+4bi/2AKcj1sBds7icBIxvEHdbbJrU4ITm3/0ClfFBqS/tAnevx?=
 =?us-ascii?Q?HznL9ixy2NdcuvUC4nnthU6HEBbUL6AGhjjdMBBNAgII3ECW4ydxQC0mAJqg?=
 =?us-ascii?Q?rnGTrIkbb3CNEF70o9Q8h7iPqXFAaKqkntJgJG+t/4Tm0HEOPYyV8ipAN+VT?=
 =?us-ascii?Q?vfW2DbBupHNnagt0+9B79yU7uzjPNe8hLGDvMSf5JaNqSrjPpct4hD3QSM96?=
 =?us-ascii?Q?T4wT0Gq4LKzufpl3WXDEsRYPxEAk4m/RUzMBr/gyKbw2szVa0g/5Xl6i03h7?=
 =?us-ascii?Q?EaFG4Jq7eV0EnYtZJpfq2b4YaMKu77Cr5Z+HKCRn5Ew0xQywIPNX2pDU0xjA?=
 =?us-ascii?Q?TYRhOQ7NhUCeFOO3VTNOjjDCFsEHETGs14C1OdozmnQ9QNcFECjjC54FK0rg?=
 =?us-ascii?Q?uWhnz6YNBBlQDLle5AW+gLMsOfXYZL3x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDXBQ4vN0iBTM0n/z8jB2ztPO+xpyUWwAe0HbCo3xIdqGeDEp537tfk1EXUa?=
 =?us-ascii?Q?t1/5x/lFJABBxL8KAnC5+XB8P6V/MPMH3MAnIJtKt4XL1fZSczESjcDNMDF6?=
 =?us-ascii?Q?Dcx7Le7xucI2wAcZaP9+IbKrK7OTkLXqY6p7vpq9wt5Mf47V7zIPJ/ohr0to?=
 =?us-ascii?Q?I4EO0+KiyRQUIZE7iVdMB9IrJDui9h/UtAmq87lOePbVoPEFKG1hY7XAKJpJ?=
 =?us-ascii?Q?cLidIkK2wmfXOYukT6IXrHdjRh8USqkdZJQecdO5oXdr8dXvlnuq3PknfM+v?=
 =?us-ascii?Q?quzyT4qlxsbyRG2DKn3dKsitRtw6su0YfQlHYltq02orTLTY2mLxosBuRLEu?=
 =?us-ascii?Q?+q0MA+ACBb/6BSur5SPwwBKCi6B/rThqqkUlvFjCjh3skQb2aEQKxYbWSrl/?=
 =?us-ascii?Q?rmGF1Z/Gzv+pq3V9Kys2e/fUkEXMVmflaVxFtj+Gxzn5w99CXbzHc4YLB/xM?=
 =?us-ascii?Q?Hjca1HuNVBfViU81QsUse7KTD3Nh3VFNvyiRSfP5nxTJtmUb53CAnBCPz+5L?=
 =?us-ascii?Q?fxcomvmXj7Bzk1WZetf6C3IWhe1AoyeYltuzYtf8RiQ8DB6/BOoNFS7k2FxJ?=
 =?us-ascii?Q?EVTx2r1KQC4Lb41VaGQxZWbl6bWfCW/xtR7qHNoAcDhLVOk/v/iqZoK4pCL1?=
 =?us-ascii?Q?EryxnlvxAxztWPxwSvm1Pi/PyxQiMcyOzKd6OHeBUlpRuBFx8L64Zkh5ApjS?=
 =?us-ascii?Q?RvMciGL3BFkUOmVEpab/l3k+cAnnFgfiArfj4DfW60quTmtSWUZScl1gAVCr?=
 =?us-ascii?Q?J541kw3JekkeidUsYW4jxN/p2LMW+4ONIF+oBhHoqARzcp1g3JiP3JEhie1u?=
 =?us-ascii?Q?JV99uBU1F4yduAa2dEkvt4A+Ey5kGXEP0e+UlueFFNuQMY00c0xcyWuOI7Yq?=
 =?us-ascii?Q?a8W5bvhv1vdx1znfsziXOF3C0IkkCVemQyIgWEK/B/oBFrc7XrrI4FzG6DbY?=
 =?us-ascii?Q?U4+56QjZAJ7LvPME+Itx8NsyxI+oXiQ09aRvGUX27b7jWBqRGg7YovNgHdfh?=
 =?us-ascii?Q?rN2PLhXy7BPkNktrcysM7VjdD846htwuUmbB3xuClhB+VGZPb7vE3WO7Updg?=
 =?us-ascii?Q?u+8EZAQWiV3LK1/Sal6DjFmaDezmb/gaRNjvON80DDH4biAewmP9truzrd8v?=
 =?us-ascii?Q?Qvxse4xXoNx/LGfyQ2NaiisHTc1LrpvKfOy9y/0yxmaz63TvC017+7cKrOeO?=
 =?us-ascii?Q?Rl+CjESK4S8eiLHInhz1eCeJfMfQaNNJHIcoi1jQsrzemLVe4QW2xDrhhbpr?=
 =?us-ascii?Q?DS4zhInGeckJLsQMuAe5ijex+qWXm47MOeHJFudBHQPBOw5tJyS2pd+xD+6l?=
 =?us-ascii?Q?F8yDK3GqXwlJBBGJyGOQNcI0+Di5451nI9AjcF356Ryvu2D/8Pib5O7kIu43?=
 =?us-ascii?Q?rphcXGyWS3yBiaLZJ4kkrzRmphgorVS1yfOdkUTBkb14qIqKKC/6nEuyZ+qJ?=
 =?us-ascii?Q?tgQCQQkvUQyzRT30tYApaXByUbvnO15YOvDeuaS/p4aHbOn42qwoMq05uQgP?=
 =?us-ascii?Q?kpDqtMk/37VpGwylhWVLa6IYGCRDe+F3ntn7hiYV/cK3XAOkVjDzzEkzt/rt?=
 =?us-ascii?Q?4iUBNOMZ0lz24Skglgg5fL3ZohZgHW1K75VFMUEJ6ISLO/xlFy19hS7ZND8s?=
 =?us-ascii?Q?njsa3M0DjUk8LsPKUJQgOso=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 04687f0c-df16-4fe5-da84-08dd272cf02d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:51.9660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIFo0WImWxyG5ZbMkLFTG16lJ++h5L6Zx9mQ2gBzzrpfEtDy9ahZ+ay8spj7wVxtlcZK+GXL/WZzX+//bHg0OmVbYhuDMy1NiDfi91yT55w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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
index db708f0a2a5..7c713a5ca56 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -360,9 +360,9 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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
@@ -396,10 +396,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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
@@ -434,7 +434,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			tcp_seq_num = tcp->lost.hill[i].l;
 		}
 		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge(tcp);
+			tcp_update_rcv_nxt(tcp);
 			return;
 		}
 
@@ -463,12 +463,12 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
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
 
@@ -489,7 +489,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 	tcp->lost.hill[i].r = tcp_seq_num + len;
 	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge(tcp);
+	tcp_update_rcv_nxt(tcp);
 };
 
 /**
@@ -566,8 +566,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
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
@@ -583,8 +583,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
@@ -633,7 +633,7 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp->ack_edge++;
+			tcp->rcv_nxt++;
 			action = TCP_ACK | TCP_FIN;
 			tcp->state = TCP_FIN_WAIT_2;
 		}
@@ -748,7 +748,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->rcv_nxt, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -756,7 +756,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 */
 		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp->ack_edge);
+				    tcp_ack_num, tcp->rcv_nxt);
 	}
 }
 
-- 
2.45.2

