Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6532BCF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A9388B58;
	Sat, 21 Sep 2024 05:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QusjNweJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0386888581; Sat, 21 Sep 2024 05:44:19 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82197889ED
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djT7vI+1EaimhDeaaU80ym08/kgN48oQHjXOqVVGVjED51NGhcqCUPoIeh+ezZTKRkegQ1TLdK3QmXsM+wyp3OkIdxbfikiU6P/fsQUt+OAq407hPEjFnCLN5RiyqKtQHkPZu/rhXgHZoqEGMraVAtGKyahCdK2m0wHjo/G0ol5L3wmdGgyUH72ETiOCrCe32Xa+g3JB4VqjBUvy8LQ56HzZiorHJAAycqjxZDvKaBZySqt62dBhYdVHCgpQQ5RDQPpzrvPCJbidUvYodWNapUHsMoMyT40SuP6tG1RWpIAtVR6MazU5D6gx0yudSdP6oXMfadQIItsAPbNYHvurGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ra4koE7FMt8V4lStDoTUBZocdcVuScdpfOigsSqTww=;
 b=ms1fvUBPYMxOcaVFFd72GuSbhZmcEP5hLm4qVwIC8dhW1d3QJDxRPyhQABmM07DoFXTAAeC5YKYpingoFnBCl2SfmemFSjdF42pXwqMmLvfbkphW6RRZfNOHTmBjRzoJu1YPl5PEK75NlskGnx+Db2ZfDyR4A6E97piCGbP7cDHzw09hhsbb0tQ7hpTxELPtngnR2Z8MLz8ZGv/ulIaNzNHeU/Mpm6XH8MZVNmlXo7faIOWMfcpjdalgiAu6owSz3oC4tFT+zkhtGtkpyyoMKt6D+COd/b0tZX5eMe902/Et1ZOgaogVxbar6sNEIKeE0I6n8ZBuImHToBVq4TvhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ra4koE7FMt8V4lStDoTUBZocdcVuScdpfOigsSqTww=;
 b=QusjNweJ5POS0cMmD/mQdg75DNr/tbWa/npUK6zK+MCd1DGK8IopJHcVLbftZ2Da9m6smiHZpyGnXxVuQDaniR+Q7lGtEOnrZX5u2sgKJ7i87taBbWzv6WXAb4lYy8DSaPhbJmHXd7r7RghR0mpw7sKhOVrKPGrXziUOv840YRI7VlCD0MHewxx/TCRaI6jo+c1rB/pS3rVw7oWogfgueHD3gPxYXwPL4LixYgAy68Yxs4D5oVohsEiYzcQ+wZvgKeE/K/ueMqLPB7nJtCVLlifhKGAQfIn3BnB6jhWgyH7DBRu8JQN9PbJnu4nhm19u9lphFqdo8ALNEgos1gILhg==
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
 03:44:13 +0000
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
Subject: [PATCH v7 08/13] net/tcp: simplify tcp header filling code
Date: Sat, 21 Sep 2024 06:43:48 +0300
Message-ID: <20240921034353.1298452-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 9f9e4873-a657-46f4-a0be-08dcd9efa8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J9fLf3wuMpk1yUM7ISSP9jVb0wtBW58jAg3HjH+NqGTWFQjIFqbNXQVUgRYG?=
 =?us-ascii?Q?mRUjMRJ+kw0VpA3xRtqJaIM/RegYLM0PLzJjgusXXbufcxeeWID/0hWUGtPG?=
 =?us-ascii?Q?80cn3haIZTau03MjblNwrtBAd29x9wq+WR9YhhoOrEjCTMgiIDjEKlgmHDvV?=
 =?us-ascii?Q?RZ60rO7LzMesBxDOWRD8QaCviBKfOHafH2nBHfjH5fY6drlbWcjI24u/6va3?=
 =?us-ascii?Q?qEkjPCw7yTwMzYukqD6phVlOSez25puEDEplwuIkWp57r7PilDRUplNp0i9X?=
 =?us-ascii?Q?nFVkE0Mi3f5hf3oqWSlW9+FVh5/mNZBN61raxs98BXlH+WGodOt+ENs61Hpd?=
 =?us-ascii?Q?STAYLQPwxM4lrcU0jpqZUr1USPN8hF6Pav30CJ8aSEPGWNC9IqtSE8YF3XGM?=
 =?us-ascii?Q?SeAb8B+KAfFUJ8pc+j/QiKsOXb92eAf1Zwh0p/piQvWYx4t1Tpfaw8gRPHK5?=
 =?us-ascii?Q?feP/k1CN379jPFqHrgFD+1c+EvBgor2/7HdblWyhYBBY9Ag1YOkbef95Ynxm?=
 =?us-ascii?Q?CwySOL8LdHCBuazrxMvZC2iV8bXfPVZMI8tbrnrRaXdfc+u3sVekJq7HWTDo?=
 =?us-ascii?Q?FwvQAkrVXuc5KZ9teiISoeiE/MO/68xejT2RZ0gSJ44HYFZbu2uoiicIU5av?=
 =?us-ascii?Q?Vqlyok4AvmFJ9HftRLMMqi0uJ3KAG323nkCASd8sRThM23kWUtKCA81t1m1h?=
 =?us-ascii?Q?AmE9jLHlBm0lf++8O70FHekpm59+zsTXzlc2/IAi/nl2cy2uSSYGXqU0hgmW?=
 =?us-ascii?Q?EmPw0Z+wPz9pyx1SiwFAmLkeeuVMIoAVroSFq7TyrjSzqUhvM0lK1tmy8/GS?=
 =?us-ascii?Q?T4blmZOKKqRZ05ha+G1YsgFoWet5WAQDTCO88TYonHgWceC9EhUFv9JlGCY7?=
 =?us-ascii?Q?Mw4SQ9SjM2dBa8yaucg6yCAe+i+9bdp2YRCjpEzO+JpxuqkxCr0NydfAvTjh?=
 =?us-ascii?Q?pmDS3w5RAIaVBdcBGTGqQQb3UA0HoLgZvoNUGmO+sts44f7/WYTYa89XMeL7?=
 =?us-ascii?Q?zVcZ0+M2P9qwBFe1a9Cxc5kx4OKZrBRn3acPBEvj1lxXbvVulszugni9feuK?=
 =?us-ascii?Q?holjwiQrg7bwotqUi6dP6g80O4H+XW4jiSIbYpsHpYbo0VWVGPkMx5tPCYO8?=
 =?us-ascii?Q?noWBWveDgsE+VPwd7bkXB0s3QDeRBENQZfp6YH2IKhVIoqH0bdrPq/YV37rT?=
 =?us-ascii?Q?UeyrWYOGVqywtHyEIUWgOnBoctSd+lNhQzLyyzN8/LlhN/VH+ZvSVVC1CmlW?=
 =?us-ascii?Q?WIhUc+lb6rkz8G3pH66FR+lBUHf9b9z5jMpym3Ozg5u4gPcKXYL3fmuUDc7n?=
 =?us-ascii?Q?xwtPwt6/of3FFNRhHMbVp12gYp0f7c8/bWw17TW+ixhwyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YludcZPvhDWMToOuvV452DQOK+FyTHXylzFFU+dXSTmUEeO/IzecDNj8aaXY?=
 =?us-ascii?Q?rMsmp4oSArc1hHK6hi9xIBB5LhLi0cgT+ZKxgz4XxPfWtgKlrtEJXi6wuR/R?=
 =?us-ascii?Q?ieCbI6Qe9g5QWTVRAqvScdeAJ+dIfgO5uo9nIrLfGQWHERgb9u4tsV7gQ6Ip?=
 =?us-ascii?Q?9lTqzGoGZGBAU01Yl7HMPgkj7XGIy0iMJHL39eBAmU5dl2kthmHxHXbAuDsU?=
 =?us-ascii?Q?LOysbzeWcS7pbqtlVvCaeFe5lhFksS8AmX7Ib1VOtVWoCyKeJN0mhgub/79t?=
 =?us-ascii?Q?9VK3qpl2JuU4pBfoqStC2U1wq10fcv97ncT2DvP5Bch4dLB6XY5sBBf3VbF1?=
 =?us-ascii?Q?VEajyxrScUDcuDQ0XQjlKnEYhOxqHw7wLOVNahf0KS+c8xcCzVbjAFjPZngq?=
 =?us-ascii?Q?lxr4saJgqAFyhAa8gNQfR2H+QdMvcUtsahzlnBx1nuUgSswcVn+HSFTJpyiE?=
 =?us-ascii?Q?vijlswHlWLRh9YPAxDuVwC9r5/SVuVPWSuleULDVHVrkMSumavJAZ+np6nye?=
 =?us-ascii?Q?6Io7eJcIqdJgbYXuA54LfdHOrRNzUMmbzte5uxVWdKXQq1HnCG7wKMYXCgOp?=
 =?us-ascii?Q?unob42owzNXSWiwJoVuiGNfZqC95qOEaEoEZ2NZFoH7zXhpRpB/1qjJGKD05?=
 =?us-ascii?Q?U186A5Gli05bu5VzcT/Yuu+hfffwz5aYatLU37EppGoRhZbczak8TleTwF2U?=
 =?us-ascii?Q?DN7kgQCUJywrgZs+fTu6vtxrup58+38LnZ2TPn9/Oxtoa9A3P5oF7ROhJy/Z?=
 =?us-ascii?Q?Fp8/m83FIQFW2I+t56joIMrpr9pc6cuZ4PGMIktr8B3YymJMp5T/IygHvnBf?=
 =?us-ascii?Q?XTp7R28CsnR0Lij1LCbRPQUpwwUd9Z24mOPxBKXcPSaxf54r4MhKMsW4QcPO?=
 =?us-ascii?Q?ElclD21n1QiR5Dc2jbRzeJNQoU5QuxqxEQiG+2fGVeDj/xav/YhUMajd0b1K?=
 =?us-ascii?Q?7WVL+I6GVUiHX44B0vrLP2dcNh6VCCK+f3Ck/e2DT/eQoQwXyAR+vql/qstJ?=
 =?us-ascii?Q?Mj6OcocOQ9CS7roZRHcacetVSPaytKwD03lSswgKT91drSC6499SyL47b9Sa?=
 =?us-ascii?Q?QQdQl6y2Pnx2U7RBZgVpxZnnVD756hU1fAcoOaHcQVXFsBYRZ16TVD/HlULa?=
 =?us-ascii?Q?tMjHLXCr3R+L5q/QOTjQHYngurjrS0nfC3wz6/ndgnJX6kOfbGtIXuiTkACm?=
 =?us-ascii?Q?7OgyAl3uIF5a3TiNsuwqWX2qzrbraq7DYPHBwceqkUpyUC58Qo61EP+zYoIU?=
 =?us-ascii?Q?aaAMAfab5Gxp+l6/R//bW8uYa6QL4hDO5yZ1Ge7wVPF85d9zMs593byS3AT4?=
 =?us-ascii?Q?KqZYLdn1zQKx7lt1THrbApTzxgVZ74RYIHA2jw+4NRZ/XxmgvBFzuieQophW?=
 =?us-ascii?Q?2pY1VNpmXu5YYKgwI0sTH1yYlFTCUi7rmJPdNBn1HOqhAryq1DkQISgHjJ6G?=
 =?us-ascii?Q?PQE843TiCfTDNJGpeMx6BQCQq5Gs/cfo0I+Tx9XnR625xJb4Bn6Cehn/vhsK?=
 =?us-ascii?Q?klnYjwlq2ENYLIF/yKVfXNrzdmcutES/YIv+wTjjluHkioKZfiScTsm3z8bZ?=
 =?us-ascii?Q?3YdMcajks3iua6MhS+YryFoR0foSgCHq0YQgRF8qQOZaVinFM6brAmXbu2iy?=
 =?us-ascii?Q?oRnuxLw/4iGWXosIo3po6Ms=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9e4873-a657-46f4-a0be-08dcd9efa8d3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:13.3950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/1BSWG9lyMNE5EVKSHFsRsTTWXn68X0/NzElyt5aYcc7jfrib7O1+BlTOuH7z9iZIV5j6dL2oQ5eFzpld4ziF07I41fsPaqhZ5Z/VxeTkg=
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

This patch:
 * remove useless code,
 * use a special function for pretty printing of tcp flags,
 * simplify the code

The behavior should not be changed.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 66 +++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 07c57d3ea8b..647454fc064 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -537,10 +537,33 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
+const char *tcpflags_to_str(char tcpflags, char *buf, int size)
+{
+	int i;
+	static const struct {
+		int		bit;
+		const char	*name;
+	} desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
+		    {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}};
+
+	*buf = '\0';
+	for (i = 0; i < ARRAY_SIZE(desc); i++) {
+		if (!(tcpflags & desc[i].bit))
+			continue;
+
+		if (*buf)
+			strlcat(buf, ",", size);
+		strlcat(buf, desc[i].name, size);
+	}
+
+	return buf;
+}
+
 int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
+	char buf[24];
 	int pkt_hdr_len;
 	int pkt_len;
 	int tcp_len;
@@ -550,55 +573,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	 *         4 bits reserved options
 	 */
 	b->ip.hdr.tcp_flags = action;
-	pkt_hdr_len = IP_TCP_HDR_SIZE;
 	b->ip.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 
 	switch (action) {
 	case TCP_SYN:
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num);
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		net_set_syn_options(tcp, b);
 		pkt_hdr_len = IP_TCP_O_SIZE;
 		break;
-	case TCP_SYN | TCP_ACK:
-	case TCP_ACK:
-		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
-		b->ip.hdr.tcp_flags = action;
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
-			   action);
-		break;
-	case TCP_FIN:
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
-		payload_len = 0;
-		pkt_hdr_len = IP_TCP_HDR_SIZE;
-		break;
 	case TCP_RST | TCP_ACK:
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
 			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
+		pkt_hdr_len = IP_TCP_HDR_SIZE;
 		break;
-	/* Notify connection closing */
-	case (TCP_FIN | TCP_ACK):
-	case (TCP_FIN | TCP_ACK | TCP_PUSH):
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num, action);
-		fallthrough;
 	default:
 		pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
-		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &tcp->rhost, &net_ip,
-			   tcp_seq_num, tcp_ack_num, action);
+			   "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
+			   tcpflags_to_str(action, buf, sizeof(buf)),
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
+		break;
 	}
 
 	pkt_len	= pkt_hdr_len + payload_len;
-- 
2.45.2

