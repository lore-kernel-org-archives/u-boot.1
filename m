Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71274CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C5488582;
	Sat, 21 Sep 2024 05:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NPwhwwr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9327588995; Sat, 21 Sep 2024 05:44:12 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FDC58870D
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLTsX98BTybor/TrHfV9uZWmf5D8+qxctNjoGnLYn8Ngr/v1Rqn342ft3B2BST436mLMPB6t2fKjZ3UK61wEtIxWqZQNhAIN2t8/eSdrsRIgXgceSKrTNEiTLfW+jQb/16yhuJrHfa5qaXmFQKs960SMVkj3Dtcz0XYl7X4mP4+miTdTC93FHLdAzgT9kMQCzCfbxd1PJSR/DqBilI1KQIVGG1Pf7WeY924DMmAcvynPM4Fqj2DLQv+UlY6MhJuZOVEO3Z8Y06zzNzADAw2YQF1YcR3/6HTbvDmQ0e/wzLdelzhuT2VfjeSCQWgUnLs8R94qpPlEnRLVhHpA8Q9Avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWzGTpR38lDfJGHf19A3hY4ITndBFti+Z0yj+Gz4HoI=;
 b=RYEmyweO+dJvEnyjfjp+fzhyqclICyaCpA1Yu5fAi8MuycSg8yWE8HlLu262PahKG4Yxft88pj1NVh5st2eBJdeRqm4De9TKuL96ZEG4FQbldJUvEVadoFQIqiRjf10ZFY16kiQVyMZr6J735XjA8cpmr3xTwsuuXe6VCcte0A+/KUzQRmbtmQHa9yZLhct9DMVFtM8CH7fLf8RiS3jTkxH+sksRWpWYIBFAVM92yaHAZzxkizXz4ErZIkW3UN0/QhRPIKpX0ix+sqS0pZ4gTrsNDEm6ZlpIznnKQY4SKRwNFgLnimJuowvtHbOEA8XE3kiXTJseWYC2+NDqBVal/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWzGTpR38lDfJGHf19A3hY4ITndBFti+Z0yj+Gz4HoI=;
 b=NPwhwwr4WzcjJ9Y7oAcqiO5FClYuMOMtTb21PbxkqHa1svEKsabGvrjc2FkLxF5j7iT1IrAUSQPn4D/6LhQbzlTafYBR31x9hUSMvO3jgoLJlp+AYwcLK97sEVLmgqywBRsOmkwI0nbFVkWL4ePhdzYOGYLVvdBaywj0nPkUAnSZ/U1gMtJjJbow051Tf7hpRv6NYRLl+mNl7nx0sNdevThL189epT1S8m1d7t9Pp7t6VfoUT3TzpgmM9FzTqQXwC6aptR3u2wqeJ+GbjommbVNKdGjA2P03p6kmkKdJqZpoMBLZ/ZmCMkUN1DJL+RSPTHRERgvi/Uge+W3rIRseew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:06 +0000
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
Subject: [PATCH v7 03/13] net/tcp: put connection specific data into a
 tcp_stream structure
Date: Sat, 21 Sep 2024 06:43:43 +0300
Message-ID: <20240921034353.1298452-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 38dedd00-f53a-4c8a-790b-08dcd9efa497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/0IlLXIkX8IhiOy96KpCYD3jDcuD9TxJOD0xLgPc/ZgPZ3Aebe2UvkiGH3tu?=
 =?us-ascii?Q?bqJP7VBdWsInOgr1vJutLSkCGoqpLlQySIy9OQxjfQFX1nmmsXdX+lgdn0Kj?=
 =?us-ascii?Q?nzibvrMMx2YfcJySHRPcji7RuRKbT9lmFi+tsL3cmoFsxiOKzVFmOTGg8SCr?=
 =?us-ascii?Q?YrdBFdUOS4bnyg8AVFrN1hJuORUxWTdUbOKD8pQjwW4T+itXxFmo9wUhFGwC?=
 =?us-ascii?Q?o4M8Ts8eTTfb4XOqtATBFa7AUW7iGk/8XJAmuGqkWJWQr6g35Xl8SHtnq5jL?=
 =?us-ascii?Q?4o4wMCYPU1rWSuz1Lt+cDEh/imXBLD9u9TOjpyM2SOeOLZcnVmtexwJEJ2RE?=
 =?us-ascii?Q?sQOG/sJaoR04E5yH5MlqIlv/fTLyGzVBTrvpNSb3ZOKMmx6SboYaZpVhmnXA?=
 =?us-ascii?Q?JbNEo6DU6cfAX3H+efWUQpgy7Ec0KiJDGjcJSt191OEbcKewzRKITGO2ivKM?=
 =?us-ascii?Q?5KQ4ZT0KsTfUVJS0jbNciU/x79VFDhj2ivv0gy6+uL5YpXdQUlb9bLKTDaQq?=
 =?us-ascii?Q?XUaayPph2xPRr6Xt251HWT2HX53QyXYM/iIrje6I9Xl+mVc388rPT8O4ipDP?=
 =?us-ascii?Q?eNMPFwb7AWDuxKR/yfDugJfgBbRVZCo87p00koqJsQhtb3PsPXpp8hlZI2Hp?=
 =?us-ascii?Q?BLzaC9d4OBkyz85V+MqvMMib7vWMd8Ge3GzQQVU7FnvlsVoVKtFqfCzt76Zg?=
 =?us-ascii?Q?RUoPpfuMhJKqbp3i0WFDmT1IxJC/49d2KFPQzELs3K+vAOpIiWphC64vEGaS?=
 =?us-ascii?Q?FN2T+Mn/LxJ0Ix1RS0BnYCh882kpwsZjmOzEJmzyEOeWF+eb4hTv1vPEOQpO?=
 =?us-ascii?Q?5RvAzemi3ClR/kGicBZ0Uj1Cdl65VI0o0Uu3Xa1cV53N3B76g4Z1T4Gg4Fx0?=
 =?us-ascii?Q?THtFA178MY2h/R3spc5orYIXVtRmbqEGnL7I+w5OmNCKs1IpAuOHLljWyulh?=
 =?us-ascii?Q?3R661rTH2A7QteUSc9/ELsq/6pnuEaIDCCUUyWWEGELbfJRicM7DgHncKeKn?=
 =?us-ascii?Q?NKXapzrtkKvtyOdgfvX/wMUAnqQZreycJ0o5Hf3r3qs/XyGrYubNgpjzMdSi?=
 =?us-ascii?Q?1/gDPuH1hx09vedBk0EH7bbpkX8nbRkfgyM2hfJ+VzG44Yhfq1AF2RH5nKJO?=
 =?us-ascii?Q?YRnyVpVaV36WMthm7BRRmvKKRDOS1XoIhEregHgT9vwSXtZi0f8/SJU8d9E/?=
 =?us-ascii?Q?YdDFavOXNB3Ax3zHhd0fSvFR4QRPDzFQhvhXLb64C85bbLndYyDML2WCtYrD?=
 =?us-ascii?Q?MO91pGG51vP8L9O7rSqmk0gg/iMy6btReKtGihXSFTnkMSA183Z1j1fRyMxQ?=
 =?us-ascii?Q?HgLbxmsPhj9DePNFRQ3Gl+hhm9q/msQ7CsM1lri5cYrXFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W0UBTzD7xXxs4tZ2G5y6zPrNiAQPP/TmI7crYBNt+UXxv2VbVOzxCQCKy2Ke?=
 =?us-ascii?Q?Mvu2VqMyCaTurQ7Cs9PIVBNt+bUbFY0AM8tl+9b6jj5h8gLSpzfwGYX5T79F?=
 =?us-ascii?Q?hDpO9GeowBYnhWHz8i7ceO45D/4DsMnlX/OWGDCg0Bsmq8O3k++2OGGBbM1P?=
 =?us-ascii?Q?vAquuWxuYgoxwfikOsAEut+WfGG0QTbjiCKhIKIkLcc91r7b0h4Ak9zaPsee?=
 =?us-ascii?Q?8l/G5Uk+kGpQloiy5Ywj5JF3LcKbc46D6/6WWWMSlTLMx8Yb2x5Ryp2EAB9A?=
 =?us-ascii?Q?NjskRHzJlnQW1bmIdOLuUwMoX6+rbe06qurt8u4gtB/EF7ot4fW2u3v3gqIg?=
 =?us-ascii?Q?q8NXvp7zmjWfPDY0s21VjOobznK36lIpJ5lizkp8lz+SqXmAsaysz1qShKHW?=
 =?us-ascii?Q?k4YOgdq5Ywd3nYTY7s4En7+WeQcYefUAS0QL9VG3QTFhZ9y42mzUCnpenjYG?=
 =?us-ascii?Q?jfm1UhoBdY0iArcesoVa2M+PIsMUE3bYiD/GPbEzsrjz8sR32n00C6ZuYOGM?=
 =?us-ascii?Q?jKOL6TijfO+EeK4FEj/ZHAs0NqBLS3V+BAz4njwezm1TcPh6M/MkW/syR6gH?=
 =?us-ascii?Q?AS9H0SCDuMyvswuSiqENb0eKa2w5mIa6e6uFnwR1shUDKVnwvUaAxVO0rWwj?=
 =?us-ascii?Q?wf/XnMECOY5nj6STofMjulZEbY7K/uTVxKvp8JhGYekYx/DtpQRf9qiiV8PH?=
 =?us-ascii?Q?K0WG+PAnBOnwz3NDwJkFV4WIrHmAKZRvtFneKIhpLnpqvGgC8S31qRWQrdO/?=
 =?us-ascii?Q?f0cBNL2v8iY7XCVwoJnzIGGTeL5HDeJ5sTTJnT/r/R2HqgYhIJl2KkXaLNlW?=
 =?us-ascii?Q?RuVjUYgM73xAUSZpRL375KiDnLjiySxsFfWW08raTLlZL9xUv3SXdwr4RJbR?=
 =?us-ascii?Q?rKQogtw7FzSYBjijmsu+nac75CjfmOPnw9FBvuBarFiZn6ZvvL2VMhljGPTj?=
 =?us-ascii?Q?i4yUSm4Mwp0vZBvZZd7ZPCxBCyRx6PdZqXXsQymcJ2UDHWkkuUBmOL+2GMPl?=
 =?us-ascii?Q?llyoTwXarjaJZAY0bioBqFt4rcpo9lm+8zBRAJhGGfFD0fVbW6J2pdHBC/1I?=
 =?us-ascii?Q?2q2xwU/aMWsT+TyVQXKe8SdUjcOIQQeV4zxZmqEVIuZnski/o13A0a38A05w?=
 =?us-ascii?Q?Y1qPHGufv2szEv7jcFsO/h1WTRRErwEUD/6QRRp23I9l4Ne+tmUEkqVZ2WMV?=
 =?us-ascii?Q?2ZWivCypH2QqN+epBpU4yWNjj2YKNx9h5H9WWgiN6P/1YdaO6PB0QlvkWEIG?=
 =?us-ascii?Q?C0A1/5rbC/XY4bVVBB4yAW4bpcRUokLcujmCS6SyOkYchGnP+ufHrk1t3nnk?=
 =?us-ascii?Q?qJywAUB+2+ss0Z/RfNXZODnvcUcJPDzhC1RKi9eRWrRUw48kHQsMAHF8o/mR?=
 =?us-ascii?Q?fGoYYyBx1hb0pHXd5cDHD8sCFgAKR5ZCgxHESFCNfl44MRuHjFshiOVL5cMW?=
 =?us-ascii?Q?V0+X6iQK0A77Q1W0ui5I4OpRBVu/FT3iTtbqMmSX/aSxqHQpVjQbmmZ+brFs?=
 =?us-ascii?Q?1K3BuWeTATSIdrbQhPMGJFW5sqd2QawiBJ+xpln0nGSyrDCyzQ/x9FBDBW0t?=
 =?us-ascii?Q?ebnBWnuXufcUyumkVGLLIoxaojd2PQ8WkpsUnA0WxaT0fqAK0CHMUhy+BPKX?=
 =?us-ascii?Q?bmFVXN2VlZtw05d6W7b8kyw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dedd00-f53a-4c8a-790b-08dcd9efa497
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:06.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQEMRueoC+vCfVXuVPbVPGQYispLXRLSHrZ4oiUp/cIuk6hBoeimyrrnKkRTKB2FyoNqoDiYOBZQ6fzDBaVTIkxQ7ExFhwzF1tlnms7HUhQ=
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

no functional changes

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net/tcp.h |  37 +++++++-
 net/net.c         |  11 ++-
 net/tcp.c         | 231 +++++++++++++++++++++++-----------------------
 net/wget.c        |   3 +-
 4 files changed, 163 insertions(+), 119 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c29d4ce24a7..14aee64cb1c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -277,9 +277,40 @@ enum tcp_state {
 	TCP_FIN_WAIT_2
 };
 
-enum tcp_state tcp_get_tcp_state(void);
-void tcp_set_tcp_state(enum tcp_state new_state);
-int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
+/**
+ * struct tcp_stream - TCP data stream structure
+ *
+ * @state:		TCP connection state
+ *
+ * @seq_init:		Initial receive sequence number
+ * @ack_edge:		Receive next
+ *
+ * @loc_timestamp:	Local timestamp
+ * @rmt_timestamp:	Remote timestamp
+ *
+ * @lost:		Used for SACK
+ */
+struct tcp_stream {
+	/* TCP connection state */
+	enum tcp_state	state;
+
+	u32		seq_init;
+	u32		ack_edge;
+
+	/* TCP option timestamp */
+	u32		loc_timestamp;
+	u32		rmt_timestamp;
+
+	/* TCP sliding window control used to request re-TX */
+	struct tcp_sack_v lost;
+};
+
+struct tcp_stream *tcp_stream_get(void);
+
+enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp);
+void tcp_set_tcp_state(struct tcp_stream *tcp, enum tcp_state new_state);
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
+		       int sport, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 
 /**
diff --git a/net/net.c b/net/net.c
index d9bc9df643f..6c5ee7e0925 100644
--- a/net/net.c
+++ b/net/net.c
@@ -414,7 +414,7 @@ int net_init(void)
 		/* Only need to setup buffer pointers once. */
 		first_call = 0;
 		if (IS_ENABLED(CONFIG_PROT_TCP))
-			tcp_set_tcp_state(TCP_CLOSED);
+			tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
 	}
 
 	return net_init_loop();
@@ -915,6 +915,9 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 	uchar *pkt;
 	int eth_hdr_size;
 	int pkt_hdr_size;
+#if defined(CONFIG_PROT_TCP)
+	struct tcp_stream *tcp;
+#endif
 
 	/* make sure the net_tx_packet is initialized (net_init() was called) */
 	assert(net_tx_packet != NULL);
@@ -941,8 +944,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 		break;
 #if defined(CONFIG_PROT_TCP)
 	case IPPROTO_TCP:
+		tcp = tcp_stream_get();
+		if (tcp == NULL)
+			return -EINVAL;
+
 		pkt_hdr_size = eth_hdr_size
-			+ tcp_set_tcp_header(pkt + eth_hdr_size, dport, sport,
+			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size, dport, sport,
 					     payload_len, action, tcp_seq_num,
 					     tcp_ack_num);
 		break;
diff --git a/net/tcp.c b/net/tcp.c
index 724536cb352..6646f171b83 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -24,19 +24,8 @@
 #include <net.h>
 #include <net/tcp.h>
 
-/*
- * TCP sliding window  control used by us to request re-TX
- */
-static struct tcp_sack_v tcp_lost;
-
-/* TCP option timestamp */
-static u32 loc_timestamp;
-static u32 rmt_timestamp;
-
-static u32 tcp_seq_init;
-static u32 tcp_ack_edge;
-
 static int tcp_activity_count;
+static struct tcp_stream tcp_stream;
 
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
@@ -48,9 +37,6 @@ static int tcp_activity_count;
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
 
-/* TCP connection state */
-static enum tcp_state current_tcp_state;
-
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
@@ -60,22 +46,30 @@ static inline s32 tcp_seq_cmp(u32 a, u32 b)
 }
 
 /**
- * tcp_get_tcp_state() - get current TCP state
+ * tcp_get_tcp_state() - get TCP stream state
+ * @tcp: tcp stream
  *
- * Return: Current TCP state
+ * Return: TCP stream state
  */
-enum tcp_state tcp_get_tcp_state(void)
+enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp)
 {
-	return current_tcp_state;
+	return tcp->state;
 }
 
 /**
- * tcp_set_tcp_state() - set current TCP state
+ * tcp_set_tcp_state() - set TCP stream state
+ * @tcp: tcp stream
  * @new_state: new TCP state
  */
-void tcp_set_tcp_state(enum tcp_state new_state)
+void tcp_set_tcp_state(struct tcp_stream *tcp,
+		       enum tcp_state new_state)
 {
-	current_tcp_state = new_state;
+	tcp->state = new_state;
+}
+
+struct tcp_stream *tcp_stream_get(void)
+{
+	return &tcp_stream;
 }
 
 static void dummy_handler(uchar *pkt, u16 dport,
@@ -138,29 +132,30 @@ u16 tcp_set_pseudo_header(uchar *pkt, struct in_addr src, struct in_addr dest,
 
 /**
  * net_set_ack_options() - set TCP options in acknowledge packets
+ * @tcp: tcp stream
  * @b: the packet
  *
  * Return: TCP header length
  */
-int net_set_ack_options(union tcp_build_pkt *b)
+int net_set_ack_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 {
 	b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 
 	b->sack.t_opt.kind = TCP_O_TS;
 	b->sack.t_opt.len = TCP_OPT_LEN_A;
-	b->sack.t_opt.t_snd = htons(loc_timestamp);
-	b->sack.t_opt.t_rcv = rmt_timestamp;
+	b->sack.t_opt.t_snd = htons(tcp->loc_timestamp);
+	b->sack.t_opt.t_rcv = tcp->rmt_timestamp;
 	b->sack.sack_v.kind = TCP_1_NOP;
 	b->sack.sack_v.len = 0;
 
 	if (IS_ENABLED(CONFIG_PROT_TCP_SACK)) {
-		if (tcp_lost.len > TCP_OPT_LEN_2) {
+		if (tcp->lost.len > TCP_OPT_LEN_2) {
 			debug_cond(DEBUG_DEV_PKT, "TCP ack opt lost.len %x\n",
-				   tcp_lost.len);
-			b->sack.sack_v.len = tcp_lost.len;
+				   tcp->lost.len);
+			b->sack.sack_v.len = tcp->lost.len;
 			b->sack.sack_v.kind = TCP_V_SACK;
-			b->sack.sack_v.hill[0].l = htonl(tcp_lost.hill[0].l);
-			b->sack.sack_v.hill[0].r = htonl(tcp_lost.hill[0].r);
+			b->sack.sack_v.hill[0].l = htonl(tcp->lost.hill[0].l);
+			b->sack.sack_v.hill[0].r = htonl(tcp->lost.hill[0].r);
 
 			/*
 			 * These SACK structures are initialized with NOPs to
@@ -168,17 +163,17 @@ int net_set_ack_options(union tcp_build_pkt *b)
 			 * SACK structures used for both header padding and
 			 * internally.
 			 */
-			b->sack.sack_v.hill[1].l = htonl(tcp_lost.hill[1].l);
-			b->sack.sack_v.hill[1].r = htonl(tcp_lost.hill[1].r);
-			b->sack.sack_v.hill[2].l = htonl(tcp_lost.hill[2].l);
-			b->sack.sack_v.hill[2].r = htonl(tcp_lost.hill[2].r);
+			b->sack.sack_v.hill[1].l = htonl(tcp->lost.hill[1].l);
+			b->sack.sack_v.hill[1].r = htonl(tcp->lost.hill[1].r);
+			b->sack.sack_v.hill[2].l = htonl(tcp->lost.hill[2].l);
+			b->sack.sack_v.hill[2].r = htonl(tcp->lost.hill[2].r);
 			b->sack.sack_v.hill[3].l = TCP_O_NOP;
 			b->sack.sack_v.hill[3].r = TCP_O_NOP;
 		}
 
 		b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(ROUND_TCPHDR_LEN(TCP_HDR_SIZE +
 										 TCP_TSOPT_SIZE +
-										 tcp_lost.len));
+										 tcp->lost.len));
 	} else {
 		b->sack.sack_v.kind = 0;
 		b->sack.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(ROUND_TCPHDR_LEN(TCP_HDR_SIZE +
@@ -194,13 +189,14 @@ int net_set_ack_options(union tcp_build_pkt *b)
 }
 
 /**
- * net_set_ack_options() - set TCP options in SYN packets
+ * net_set_syn_options() - set TCP options in SYN packets
+ * @tcp: tcp stream
  * @b: the packet
  */
-void net_set_syn_options(union tcp_build_pkt *b)
+void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 {
 	if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-		tcp_lost.len = 0;
+		tcp->lost.len = 0;
 
 	b->ip.hdr.tcp_hlen = 0xa0;
 
@@ -219,14 +215,15 @@ void net_set_syn_options(union tcp_build_pkt *b)
 	}
 	b->ip.t_opt.kind = TCP_O_TS;
 	b->ip.t_opt.len = TCP_OPT_LEN_A;
-	loc_timestamp = get_ticks();
-	rmt_timestamp = 0;
+	tcp->loc_timestamp = get_ticks();
+	tcp->rmt_timestamp = 0;
 	b->ip.t_opt.t_snd = 0;
 	b->ip.t_opt.t_rcv = 0;
 	b->ip.end = TCP_O_END;
 }
 
-int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
+		       int sport, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
@@ -249,21 +246,21 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   &net_server_ip, &net_ip,
 			   tcp_seq_num, tcp_ack_num);
 		tcp_activity_count = 0;
-		net_set_syn_options(b);
+		net_set_syn_options(tcp, b);
 		tcp_seq_num = 0;
 		tcp_ack_num = 0;
 		pkt_hdr_len = IP_TCP_O_SIZE;
-		if (current_tcp_state == TCP_SYN_SENT) {  /* Too many SYNs */
+		if (tcp->state == TCP_SYN_SENT) {  /* Too many SYNs */
 			action = TCP_FIN;
-			current_tcp_state = TCP_FIN_WAIT_1;
+			tcp->state = TCP_FIN_WAIT_1;
 		} else {
-			tcp_lost.len = TCP_OPT_LEN_2;
-			current_tcp_state = TCP_SYN_SENT;
+			tcp->lost.len = TCP_OPT_LEN_2;
+			tcp->state = TCP_SYN_SENT;
 		}
 		break;
 	case TCP_SYN | TCP_ACK:
 	case TCP_ACK:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(b);
+		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
 		b->ip.hdr.tcp_flags = action;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -276,20 +273,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
 		payload_len = 0;
 		pkt_hdr_len = IP_TCP_HDR_SIZE;
-		current_tcp_state = TCP_FIN_WAIT_1;
+		tcp->state = TCP_FIN_WAIT_1;
 		break;
 	case TCP_RST | TCP_ACK:
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
 			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
-		current_tcp_state = TCP_CLOSED;
+		tcp->state = TCP_CLOSED;
 		break;
 	/* Notify connection closing */
 	case (TCP_FIN | TCP_ACK):
 	case (TCP_FIN | TCP_ACK | TCP_PUSH):
-		if (current_tcp_state == TCP_CLOSE_WAIT)
-			current_tcp_state = TCP_CLOSING;
+		if (tcp->state == TCP_CLOSE_WAIT)
+			tcp->state = TCP_CLOSING;
 
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -297,7 +294,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			   tcp_seq_num, tcp_ack_num, action);
 		fallthrough;
 	default:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(b);
+		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
 		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
@@ -308,9 +305,9 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	pkt_len	= pkt_hdr_len + payload_len;
 	tcp_len	= pkt_len - IP_HDR_SIZE;
 
-	tcp_ack_edge = tcp_ack_num;
+	tcp->ack_edge = tcp_ack_num;
 	/* TCP Header */
-	b->ip.hdr.tcp_ack = htonl(tcp_ack_edge);
+	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
 	b->ip.hdr.tcp_src = htons(sport);
 	b->ip.hdr.tcp_dst = htons(dport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
@@ -344,78 +341,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	return pkt_hdr_len;
 }
 
-static void tcp_update_ack_edge(void)
+static void tcp_update_ack_edge(struct tcp_stream *tcp)
 {
-	if (tcp_seq_cmp(tcp_ack_edge, tcp_lost.hill[0].l) >= 0) {
-		tcp_ack_edge = tcp_lost.hill[0].r;
+	if (tcp_seq_cmp(tcp->ack_edge, tcp->lost.hill[0].l) >= 0) {
+		tcp->ack_edge = tcp->lost.hill[0].r;
 
-		memmove(&tcp_lost.hill[0], &tcp_lost.hill[1],
+		memmove(&tcp->lost.hill[0], &tcp->lost.hill[1],
 			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
 
-		tcp_lost.len -= TCP_OPT_LEN_8;
-		tcp_lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
-		tcp_lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
+		tcp->lost.len -= TCP_OPT_LEN_8;
+		tcp->lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
+		tcp->lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
 	}
 }
 
 /**
  * tcp_hole() - Selective Acknowledgment (Essential for fast stream transfer)
+ * @tcp: tcp stream
  * @tcp_seq_num: TCP sequence start number
  * @len: the length of sequence numbers
  */
-void tcp_hole(u32 tcp_seq_num, u32 len)
+void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 {
 	int i, j, cnt, cnt_move;
 
-	cnt = (tcp_lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
+	cnt = (tcp->lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
 	for (i = 0; i < cnt; i++) {
-		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num) < 0)
+		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num) < 0)
 			continue;
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num + len) > 0)
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num + len) > 0)
 			break;
 
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) > 0)
-			tcp_lost.hill[i].l = tcp_seq_num;
-		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) < 0) {
-			len += tcp_seq_num - tcp_lost.hill[i].l;
-			tcp_seq_num = tcp_lost.hill[i].l;
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num) > 0)
+			tcp->lost.hill[i].l = tcp_seq_num;
+		if (tcp_seq_cmp(tcp->lost.hill[i].l, tcp_seq_num) < 0) {
+			len += tcp_seq_num - tcp->lost.hill[i].l;
+			tcp_seq_num = tcp->lost.hill[i].l;
 		}
-		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge();
+		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
+			tcp_update_ack_edge(tcp);
 			return;
 		}
 
 		/* check overlapping with next hills */
 		cnt_move = 0;
-		tcp_lost.hill[i].r = tcp_seq_num + len;
+		tcp->lost.hill[i].r = tcp_seq_num + len;
 		for (j = i + 1; j < cnt; j++) {
-			if (tcp_seq_cmp(tcp_lost.hill[j].l, tcp_lost.hill[i].r) > 0)
+			if (tcp_seq_cmp(tcp->lost.hill[j].l, tcp->lost.hill[i].r) > 0)
 				break;
 
-			tcp_lost.hill[i].r = tcp_lost.hill[j].r;
+			tcp->lost.hill[i].r = tcp->lost.hill[j].r;
 			cnt_move++;
 		}
 
 		if (cnt_move > 0) {
 			if (cnt > i + cnt_move + 1)
-				memmove(&tcp_lost.hill[i + 1],
-					&tcp_lost.hill[i + cnt_move + 1],
+				memmove(&tcp->lost.hill[i + 1],
+					&tcp->lost.hill[i + cnt_move + 1],
 					cnt_move * sizeof(struct sack_edges));
 
 			cnt -= cnt_move;
-			tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+			tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 			for (j = cnt; j < TCP_SACK_HILLS; j++) {
-				tcp_lost.hill[j].l = TCP_O_NOP;
-				tcp_lost.hill[j].r = TCP_O_NOP;
+				tcp->lost.hill[j].l = TCP_O_NOP;
+				tcp->lost.hill[j].r = TCP_O_NOP;
 			}
 		}
 
-		tcp_update_ack_edge();
+		tcp_update_ack_edge(tcp);
 		return;
 	}
 
 	if (i == TCP_SACK_HILLS) {
-		tcp_update_ack_edge();
+		tcp_update_ack_edge(tcp);
 		return;
 	}
 
@@ -428,23 +426,24 @@ void tcp_hole(u32 tcp_seq_num, u32 len)
 	}
 
 	if (cnt_move > 0)
-		memmove(&tcp_lost.hill[i + 1],
-			&tcp_lost.hill[i],
+		memmove(&tcp->lost.hill[i + 1],
+			&tcp->lost.hill[i],
 			cnt_move * sizeof(struct sack_edges));
 
-	tcp_lost.hill[i].l = tcp_seq_num;
-	tcp_lost.hill[i].r = tcp_seq_num + len;
-	tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+	tcp->lost.hill[i].l = tcp_seq_num;
+	tcp->lost.hill[i].r = tcp_seq_num + len;
+	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge();
+	tcp_update_ack_edge(tcp);
 };
 
 /**
  * tcp_parse_options() - parsing TCP options
+ * @tcp: tcp stream
  * @o: pointer to the option field.
  * @o_len: length of the option field.
  */
-void tcp_parse_options(uchar *o, int o_len)
+void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
 {
 	struct tcp_t_opt  *tsopt;
 	uchar *p = o;
@@ -467,7 +466,7 @@ void tcp_parse_options(uchar *o, int o_len)
 			break;
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
-			rmt_timestamp = tsopt->t_snd;
+			tcp->rmt_timestamp = tsopt->t_snd;
 			break;
 		}
 
@@ -479,7 +478,8 @@ void tcp_parse_options(uchar *o, int o_len)
 	}
 }
 
-static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
+static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
+			    u32 tcp_seq_num, int payload_len)
 {
 	u8 tcp_fin = tcp_flags & TCP_FIN;
 	u8 tcp_syn = tcp_flags & TCP_SYN;
@@ -500,21 +500,21 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	debug_cond(DEBUG_INT_STATE, "TCP STATE ENTRY %x\n", action);
 	if (tcp_rst) {
 		action = TCP_DATA;
-		current_tcp_state = TCP_CLOSED;
+		tcp->state = TCP_CLOSED;
 		net_set_state(NETLOOP_FAIL);
 		debug_cond(DEBUG_INT_STATE, "TCP Reset %x\n", tcp_flags);
 		return TCP_RST;
 	}
 
-	switch  (current_tcp_state) {
+	switch  (tcp->state) {
 	case TCP_CLOSED:
 		debug_cond(DEBUG_INT_STATE, "TCP CLOSED %x\n", tcp_flags);
 		if (tcp_syn) {
 			action = TCP_SYN | TCP_ACK;
-			tcp_seq_init = tcp_seq_num;
-			tcp_ack_edge = tcp_seq_num + 1;
-			tcp_lost.len = TCP_OPT_LEN_2;
-			current_tcp_state = TCP_SYN_RECEIVED;
+			tcp->seq_init = tcp_seq_num;
+			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->lost.len = TCP_OPT_LEN_2;
+			tcp->state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
 		}
@@ -525,12 +525,12 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			   tcp_flags, tcp_seq_num);
 		if (tcp_fin) {
 			action = action | TCP_PUSH;
-			current_tcp_state = TCP_CLOSE_WAIT;
+			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp_seq_init = tcp_seq_num;
-			tcp_ack_edge = tcp_seq_num + 1;
-			current_tcp_state = TCP_ESTABLISHED;
+			tcp->seq_init = tcp_seq_num;
+			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
 				action |= TCP_PUSH;
@@ -541,15 +541,15 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	case TCP_ESTABLISHED:
 		debug_cond(DEBUG_INT_STATE, "TCP_ESTABLISHED %x\n", tcp_flags);
 		if (payload_len > 0) {
-			tcp_hole(tcp_seq_num, payload_len);
+			tcp_hole(tcp, tcp_seq_num, payload_len);
 			tcp_fin = TCP_DATA;  /* cause standalone FIN */
 		}
 
 		if ((tcp_fin) &&
 		    (!IS_ENABLED(CONFIG_PROT_TCP_SACK) ||
-		     tcp_lost.len <= TCP_OPT_LEN_2)) {
+		     tcp->lost.len <= TCP_OPT_LEN_2)) {
 			action = action | TCP_FIN | TCP_PUSH | TCP_ACK;
-			current_tcp_state = TCP_CLOSE_WAIT;
+			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack) {
 			action = TCP_DATA;
 		}
@@ -567,7 +567,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_2 (%x)\n", tcp_flags);
 		if (tcp_ack) {
 			action = TCP_PUSH | TCP_ACK;
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 			puts("\n");
 		} else if (tcp_syn) {
 			action = TCP_DATA;
@@ -578,20 +578,20 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp_ack_edge++;
+			tcp->ack_edge++;
 			action = TCP_ACK | TCP_FIN;
-			current_tcp_state = TCP_FIN_WAIT_2;
+			tcp->state = TCP_FIN_WAIT_2;
 		}
 		if (tcp_syn)
 			action = TCP_RST;
 		if (tcp_ack)
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 		break;
 	case TCP_CLOSING:
 		debug_cond(DEBUG_INT_STATE, "TCP_CLOSING (%x)\n", tcp_flags);
 		if (tcp_ack) {
 			action = TCP_PUSH;
-			current_tcp_state = TCP_CLOSED;
+			tcp->state = TCP_CLOSED;
 			puts("\n");
 		} else if (tcp_syn) {
 			action = TCP_RST;
@@ -615,6 +615,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	u8  tcp_action = TCP_DATA;
 	u32 tcp_seq_num, tcp_ack_num;
 	int tcp_hdr_len, payload_len;
+	struct tcp_stream *tcp;
 
 	/* Verify IP header */
 	debug_cond(DEBUG_DEV_PKT,
@@ -643,11 +644,15 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		return;
 	}
 
+	tcp = tcp_stream_get();
+	if (tcp == NULL)
+		return;
+
 	tcp_hdr_len = GET_TCP_HDR_LEN_IN_BYTES(b->ip.hdr.tcp_hlen);
 	payload_len = tcp_len - tcp_hdr_len;
 
 	if (tcp_hdr_len > TCP_HDR_SIZE)
-		tcp_parse_options((uchar *)b + IP_TCP_HDR_SIZE,
+		tcp_parse_options(tcp, (uchar *)b + IP_TCP_HDR_SIZE,
 				  tcp_hdr_len - TCP_HDR_SIZE);
 	/*
 	 * Incoming sequence and ack numbers are server's view of the numbers.
@@ -657,7 +662,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	tcp_ack_num = ntohl(b->ip.hdr.tcp_ack);
 
 	/* Packets are not ordered. Send to app as received. */
-	tcp_action = tcp_state_machine(b->ip.hdr.tcp_flags,
+	tcp_action = tcp_state_machine(tcp, b->ip.hdr.tcp_flags,
 				       tcp_seq_num, payload_len);
 
 	tcp_activity_count++;
@@ -678,7 +683,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp_ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -687,6 +692,6 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		net_send_tcp_packet(0, ntohs(b->ip.hdr.tcp_src),
 				    ntohs(b->ip.hdr.tcp_dst),
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp_ack_edge);
+				    tcp_ack_num, tcp->ack_edge);
 	}
 }
diff --git a/net/wget.c b/net/wget.c
index f1dd7abeff6..c0a80597bfe 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -356,7 +356,8 @@ static void wget_handler(uchar *pkt, u16 dport,
 			 u32 tcp_seq_num, u32 tcp_ack_num,
 			 u8 action, unsigned int len)
 {
-	enum tcp_state wget_tcp_state = tcp_get_tcp_state();
+	struct tcp_stream *tcp = tcp_stream_get();
+	enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
 
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	packets++;
-- 
2.45.2

