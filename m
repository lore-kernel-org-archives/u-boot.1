Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B44CF886D
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 196AC88D5B;
	Mon,  7 Oct 2024 22:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="e3Hbkrp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6801C88D47; Mon,  7 Oct 2024 22:56:01 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5948688D15
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0CzmkZA3ZUHBuygkyG8lkCNbbAodM/CKTLReqOBcMf7zKYT36w99kLAUESN1YHAHuGagR13O5AaH/eyGT5ghrf8cIvOOWmqWqnx0qRGiQ2E7c6qH8OE0RVmHbI38rE+VYLiI60VcR5Buw/+Dti+fmIQCQRiM4RtlMyxmH3oY96uEom98qqU50DKUdFRWeDcmwTxf91pEkSBx3uSNp1Q3XRDcGi3qzZ/zhJ5Ou812WhwM0p7TR2mGMVnhOPDcgmlIV2K0H6nzhVvU/sCqQ1rFPvYZs6fYxqfUXn3d02gnqCB/uHTk3QBEsFxxMz0Su49SBbFTbMwnO5jODYBFR6Ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=qZm0CayZWXVbVXJpRbCC/g+sBqoFUN43G5rqgQARfB0j+38sSu+SOw8Pr0DxUefcUaYzSBquIG6LrFzQlrB41aEeAQvevhN/yGlVDeyRKiL4GBhWqde9XhAlXuUZVKme19Lfi54VbUSD5i8xGDagCmYI/HmADY/ipy69P3Ksk5Pq0gxqwvllgm20nF83K7KYYA5fRPogdO08VUhsEozCKuBPooajdKrE5fJBmmjNS7cWm4cZvDt9bXGFdw2uR7+vgXDgLvkmChzx/ZKB2Z+j+Zr6E59qeSK8DCCZpvbOdhl+SlQp7ZeE1TaTWkf1MXqlDLhwl+MNfScmBKdUmfYW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJdq+jM1FJcu+qcheP0L7cOWIJ0srHW56AvYyehGWw=;
 b=e3Hbkrp4KHeMDsaU/JtjIurpBC6NnnJsUWv4Ud6zmAEsfSg7TQalMitM69avgCANxWXzeDV7XdQH/hihZkM2lrkjad+0iytBl9U75Xm3sXegpGA5mvDeJ1HWZYBua/zLePUe348MbGtmsS51qLlnRjTW8ER3EJUC/kx/Rhj3Ot9QbF4ci6lYXbkp8Kwba2CBp9iDz5oJ2tWw9lRXOJp6nlUmwVtQ5N5dM2a4zTxpjGhxF10zlCMvkw+pHYALNuiTPsP67cgUYAXGVkDdN95DpV7nDEbz5w3A4qwNuM90ULLgjnMERupluy73OvGJ9XPcaG1fIXRLGpIiQsS8LXDORw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:55:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:55:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v10 02/13] net/tcp: fix selective acknowledge
Date: Mon,  7 Oct 2024 23:55:32 +0300
Message-ID: <20241007205543.1632499-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7000cd-c9c8-402c-473a-08dce712709d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d90YMPU6cQtn8klTeSzb9jKiYh/MwHBYmiqsIe1tgzkUop4hH0O8z7u+B9By?=
 =?us-ascii?Q?BJDY1awk2QaFmdSWWFFec+q6eklRTqo40TsTjTfjPMBj9xHDGmT1Z4IbRLOm?=
 =?us-ascii?Q?MqHc/Zfn1z9jVEvv4/FSsT+PAiAXYEq6qhUf/z00XkgC87HVf17Rqmbamsye?=
 =?us-ascii?Q?vukgyHBS/fvU8S2eEu4Mx19vznKmLIeS5/ZPWbD/PJBy444J/CGoCB4MaLaJ?=
 =?us-ascii?Q?j2q6R0Hu7XxbXGHg2D59TsoSVgAjdXVmOwWm4Fg+//F1BsSxLWTzhuWJOG6U?=
 =?us-ascii?Q?PqfVa20cYZNT5Dvw9IA8hYw1jZwjyDPQS5vgWItyTd+T31BJt4uDtW0nq5yB?=
 =?us-ascii?Q?8M/e0fSGtmVvnfUQmzjhXPNYQCzMCczgP4Nwok/U8RM+Lley+rSo1y5u2z5G?=
 =?us-ascii?Q?BTqchD/xFzdEAnmiaBVYBjbRySagqRlq74E9IQfOM2M38725EyuW4HrtjL2/?=
 =?us-ascii?Q?Z4ebG1b+PZQ0AfO5GM9GcWYzxqMbvz6Ka/5fYty2UzPEtNFcmOoDYyzs0I4s?=
 =?us-ascii?Q?zByxxkiuRYCtWzFug7RoRDS94F8CN4aU2o474IEp9NEyhzVDKNXry50vMrvU?=
 =?us-ascii?Q?AMFV9txOLXlDjubs4kMxWgZspewTTq1xFUYUY8NE2KsXa2/jWWML15+XqYwe?=
 =?us-ascii?Q?J1x9Be0iwzg1bMdEaR1x90XJIbieem7egcBJ6YTM1cRrw9Ku1JDHtO0hkZ3U?=
 =?us-ascii?Q?RBoIEA5C5T8zqEkrZwIsblsb/5mZdlXnoy99vdf1GZlCCffD1uCo2dMIlCYQ?=
 =?us-ascii?Q?/m17EChen+p7JTNXOwDsQXfBD4WH/wNEWnnV/ZEzsK8jm7Y7Pj/SpQH8ks8u?=
 =?us-ascii?Q?R3k/dcWTTv2DZAVcZE1o/LdSuodcrLIj9u7r59l7uQklil8YupQFOE8EU52u?=
 =?us-ascii?Q?FNEHqwoMij1J3sEKPfSd9Hjx1ogEJ36CxC6bi0u0g/YIOjx4ft1+uped87KB?=
 =?us-ascii?Q?xqXJ0DrtNu2ya6Ik1AaU8bTdveXqMAhochGiywwDOayCQhvzcAcih/G2qYpA?=
 =?us-ascii?Q?SWNJU8sFiq6lVJLhLDGw0rOHaH3eOAtVhfYVcJG8Vm3S8J+w5q+1zyVF1sTQ?=
 =?us-ascii?Q?9chDGmqdFiA6bdqRW+kN12pR5Fb4st2F0NNnS4dOF2jiUzzkNUPt8B/VDJKs?=
 =?us-ascii?Q?GvJqaVrYZX9ZkK+dhm4VOiMRCBoLU0O7sHig8YnwMdOvw46EmdsfsutHbOAt?=
 =?us-ascii?Q?Tttfp7hyU+5cZND7WD/Vc3Ye1E5o8i8LnPdgSoLFmhsuDDl9v60ztoNCuEJT?=
 =?us-ascii?Q?74Ik3qtNdP/WG9y7EngFyjpbEPzn8sMSxHXJcAGuQEW3ttjTKcuTp3ao7udd?=
 =?us-ascii?Q?bnyI1W5EPIjLH0LQgTTMgQq9yZ2tf63K9xCoOYHcMMlkn9Tly7tutqXW3i9y?=
 =?us-ascii?Q?os8goQM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ozVX6UQRAAqV2sE3eGGSAh7WO3FHqANeWe3ZqHJSR6YmJFE43nsDDx6MeHKZ?=
 =?us-ascii?Q?fDvk9O4gPOWBDH0jNylC8elCtmHARAsWGRZBRmHCocL44K2SYuu0h26VPM0Z?=
 =?us-ascii?Q?wTaw4naKjFMmGe7xeDVPR4uvg92t0gkS6DV0QWkeDwpnWgPDUyTNqDDpyXik?=
 =?us-ascii?Q?KHPSf/rTFgvUSdnKXj6AeUDCtdl9GdQc5uM8FWSh+BCiS6IlhoQYGO3fHyFk?=
 =?us-ascii?Q?7TQjZd56EG/ubb9wsfTfWb5TMzisfTjmWzOBHQIk39yfDa6Y5mgEh6wB1TCT?=
 =?us-ascii?Q?gVGwLDirJL3kjGLIU09ZLXXnVfXOsW1TgR++zbAzz42ndFigsDeGBnIi5r9f?=
 =?us-ascii?Q?r4AGzK7niMjYClZPggp/fkOV46Bk5JNgfQ+cl31Cg+BVJhDCTce/mSKWfCx2?=
 =?us-ascii?Q?JIcmUpQ0TY/mCyIfnRxQ6izBAJxKl1MgWuWNbMRwbwypKD5zRdHk6DLjIGni?=
 =?us-ascii?Q?aRqRNZty97SxPZGz6+wEuika7/sSnJfgszXhiwCXc9KguqyHg6xLRsK/zSZv?=
 =?us-ascii?Q?hdSGtYViLisCcGkkpZrKaatU/BVeF8L4gOzhmX7Xw+6uouFQ040jwJ122NRE?=
 =?us-ascii?Q?NbEe4CC9qVpQvYtU3+VlPOtGm4qB8GwYeLZydI8mRbDRhSeMZl14Iz+gY/vs?=
 =?us-ascii?Q?Bg4MhTC4Spph0/BjagIeE6LXU9suCGDkq8W/QC5QYiTrIYzSW59f+TozKsq5?=
 =?us-ascii?Q?JRM61xXUQwCUwLCibi9gG30iEYvw4ECrpUn+u+hXRsmT3XvgyVdCN3Om4g6f?=
 =?us-ascii?Q?sYA4jUsitkjK2a0rOq9LBi9Pqguz0zovNvO8gZp9Tb6QOh7enUeTSqdlDu+6?=
 =?us-ascii?Q?P/LKeEDmerWz9dqgBiEa5QTw8nMhuVZ33/9T02g28//oiCxbLD7I+mU9q3JS?=
 =?us-ascii?Q?MN+XSWArbxLuqFM+2kVWNwk19VVnenUbFFF5OYxY8ft8qWc7FoXeCSyH9yYt?=
 =?us-ascii?Q?UUw5M7D3ymc7rXDX07XHVPisSz+8rVOJMMuE1VJqdWXkZoj1/g8lwj0dbDXz?=
 =?us-ascii?Q?UULJ3i013aUKbU9MqIZrd1gYaE2jon8SenhDxj2I2YJin2a9Hv5GbWlWFrc5?=
 =?us-ascii?Q?nnHGiJZn5Vayw6E50dRVqzBbnekm7bksVMhq4irjHO7R/vkATfVIEX8bcKTi?=
 =?us-ascii?Q?LNcaWuIcaUX+CGVopkF7yKT0B/gT8DM70hL2I6vYZuftCXJ+RY+2mnDbCzgA?=
 =?us-ascii?Q?FdA24Z1ofzp1t7TdRNg0wiVM3S/0KZ85bgb8QXYrC/DQUMa8APMBkuW2E7WY?=
 =?us-ascii?Q?O7JoszKEnKX1I0vBlWViM+aAM5RbAJbcY16W9HX5cdNNaBADYLSVOH3q8NM+?=
 =?us-ascii?Q?ltLKckjHLUMgZ16gCUHYbfKkRCVVc7GG829aAWtHsuCdT/w14iM4VkeM6q7S?=
 =?us-ascii?Q?pVPYtE3u2+fhhWGDan5Uts48YN+c8zZRSra+g5cPSYXs3q9rRKTZTHSFCme/?=
 =?us-ascii?Q?beGY5bGTG/o0J0z45n9HOWRMmGEIoyaFmTkng9CgaZobhM1oUN5OxMnG/t4x?=
 =?us-ascii?Q?w/EdR2OmIBTwQc9dYFYFay7pS6aoXZ4YZS4i23Lr/aF4+sPQxtLgdVilSNwO?=
 =?us-ascii?Q?YnHCNXRZcVhj0S8ThexrZMon7Odw41bAB3PamrtLrI0/Z54tqiJvvjXKdUey?=
 =?us-ascii?Q?+X7Zok0h1LNDE76wS1UutQU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7000cd-c9c8-402c-473a-08dce712709d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:55:56.6045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IHCcdG8swrzeNUUv1YtTKwcWlXlt/vAFC5ZaRq2exN5Np2QHUzRx524qGmME/L4hUA5qEwWFDZYqeWPkoMy19sOiF4tLaiphvYAV/7gq0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7644
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

Current code assume that all (except last) packets are of the same size.
This is definitely wrong. Replace SACK code with a new one, that does
not rely on this assumption. Also this code uses less memory.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 200 +++++++++++++++++++++++-------------------------------
 1 file changed, 86 insertions(+), 114 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 3e3118de450..724536cb352 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -38,21 +38,6 @@ static u32 tcp_ack_edge;
 
 static int tcp_activity_count;
 
-/*
- * Search for TCP_SACK and review the comments before the code section
- * TCP_SACK is the number of packets at the front of the stream
- */
-
-enum pkt_state {PKT, NOPKT};
-struct sack_r {
-	struct sack_edges se;
-	enum pkt_state st;
-};
-
-static struct sack_r edge_a[TCP_SACK];
-static unsigned int sack_idx;
-static unsigned int prev_len;
-
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
  * Add 3 to length round up, rounded, then divided into the
@@ -69,6 +54,11 @@ static enum tcp_state current_tcp_state;
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
+static inline s32 tcp_seq_cmp(u32 a, u32 b)
+{
+	return (s32)(a - b);
+}
+
 /**
  * tcp_get_tcp_state() - get current TCP state
  *
@@ -267,6 +257,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			action = TCP_FIN;
 			current_tcp_state = TCP_FIN_WAIT_1;
 		} else {
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_SENT;
 		}
 		break;
@@ -353,6 +344,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 	return pkt_hdr_len;
 }
 
+static void tcp_update_ack_edge(void)
+{
+	if (tcp_seq_cmp(tcp_ack_edge, tcp_lost.hill[0].l) >= 0) {
+		tcp_ack_edge = tcp_lost.hill[0].r;
+
+		memmove(&tcp_lost.hill[0], &tcp_lost.hill[1],
+			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
+
+		tcp_lost.len -= TCP_OPT_LEN_8;
+		tcp_lost.hill[TCP_SACK_HILLS - 1].l = TCP_O_NOP;
+		tcp_lost.hill[TCP_SACK_HILLS - 1].r = TCP_O_NOP;
+	}
+}
+
 /**
  * tcp_hole() - Selective Acknowledgment (Essential for fast stream transfer)
  * @tcp_seq_num: TCP sequence start number
@@ -360,106 +365,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
  */
 void tcp_hole(u32 tcp_seq_num, u32 len)
 {
-	u32 idx_sack, sack_in;
-	u32 sack_end = TCP_SACK - 1;
-	u32 hill = 0;
-	enum pkt_state expect = PKT;
-	u32 seq = tcp_seq_num - tcp_seq_init;
-	u32 hol_l = tcp_ack_edge - tcp_seq_init;
-	u32 hol_r = 0;
-
-	/* Place new seq number in correct place in receive array */
-	if (prev_len == 0)
-		prev_len = len;
-
-	idx_sack = sack_idx + ((tcp_seq_num - tcp_ack_edge) / prev_len);
-	if (idx_sack < TCP_SACK) {
-		edge_a[idx_sack].se.l = tcp_seq_num;
-		edge_a[idx_sack].se.r = tcp_seq_num + len;
-		edge_a[idx_sack].st = PKT;
+	int i, j, cnt, cnt_move;
 
-		/*
-		 * The fin (last) packet is not the same length as data
-		 * packets, and if it's length is recorded and used for
-		 *  array index calculation, calculation breaks.
-		 */
-		if (prev_len < len)
-			prev_len = len;
-	}
+	cnt = (tcp_lost.len - TCP_OPT_LEN_2) / TCP_OPT_LEN_8;
+	for (i = 0; i < cnt; i++) {
+		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num) < 0)
+			continue;
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num + len) > 0)
+			break;
 
-	debug_cond(DEBUG_DEV_PKT,
-		   "TCP 1 seq %d, edg %d, len %d, sack_idx %d, sack_end %d\n",
-		    seq, hol_l, len, sack_idx, sack_end);
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) > 0)
+			tcp_lost.hill[i].l = tcp_seq_num;
+		if (tcp_seq_cmp(tcp_lost.hill[i].l, tcp_seq_num) < 0) {
+			len += tcp_seq_num - tcp_lost.hill[i].l;
+			tcp_seq_num = tcp_lost.hill[i].l;
+		}
+		if (tcp_seq_cmp(tcp_lost.hill[i].r, tcp_seq_num + len) >= 0) {
+			tcp_update_ack_edge();
+			return;
+		}
 
-	/* Right edge of contiguous stream, is the left edge of first hill */
-	hol_l = tcp_seq_num - tcp_seq_init;
-	hol_r = hol_l + len;
+		/* check overlapping with next hills */
+		cnt_move = 0;
+		tcp_lost.hill[i].r = tcp_seq_num + len;
+		for (j = i + 1; j < cnt; j++) {
+			if (tcp_seq_cmp(tcp_lost.hill[j].l, tcp_lost.hill[i].r) > 0)
+				break;
 
-	if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-		tcp_lost.len = TCP_OPT_LEN_2;
+			tcp_lost.hill[i].r = tcp_lost.hill[j].r;
+			cnt_move++;
+		}
 
-	debug_cond(DEBUG_DEV_PKT,
-		   "TCP 1 in %d, seq %d, pkt_l %d, pkt_r %d, sack_idx %d, sack_end %d\n",
-		   idx_sack, seq, hol_l, hol_r, sack_idx, sack_end);
-
-	for (sack_in = sack_idx; sack_in < sack_end && hill < TCP_SACK_HILLS;
-	     sack_in++)  {
-		switch (expect) {
-		case NOPKT:
-			switch (edge_a[sack_in].st) {
-			case NOPKT:
-				debug_cond(DEBUG_INT_STATE, "N");
-				break;
-			case PKT:
-				debug_cond(DEBUG_INT_STATE, "n");
-				if (IS_ENABLED(CONFIG_PROT_TCP_SACK)) {
-					tcp_lost.hill[hill].l =
-						edge_a[sack_in].se.l;
-					tcp_lost.hill[hill].r =
-						edge_a[sack_in].se.r;
-				}
-				expect = PKT;
-				break;
-			}
-			break;
-		case PKT:
-			switch (edge_a[sack_in].st) {
-			case NOPKT:
-				debug_cond(DEBUG_INT_STATE, "p");
-				if (sack_in > sack_idx &&
-				    hill < TCP_SACK_HILLS) {
-					hill++;
-					if (IS_ENABLED(CONFIG_PROT_TCP_SACK))
-						tcp_lost.len += TCP_OPT_LEN_8;
-				}
-				expect = NOPKT;
-				break;
-			case PKT:
-				debug_cond(DEBUG_INT_STATE, "P");
-
-				if (tcp_ack_edge == edge_a[sack_in].se.l) {
-					tcp_ack_edge = edge_a[sack_in].se.r;
-					edge_a[sack_in].st = NOPKT;
-					sack_idx++;
-				} else {
-					if (IS_ENABLED(CONFIG_PROT_TCP_SACK) &&
-					    hill < TCP_SACK_HILLS)
-						tcp_lost.hill[hill].r =
-							edge_a[sack_in].se.r;
-				if (IS_ENABLED(CONFIG_PROT_TCP_SACK) &&
-				    sack_in == sack_end - 1)
-					tcp_lost.hill[hill].r =
-						edge_a[sack_in].se.r;
-				}
-				break;
+		if (cnt_move > 0) {
+			if (cnt > i + cnt_move + 1)
+				memmove(&tcp_lost.hill[i + 1],
+					&tcp_lost.hill[i + cnt_move + 1],
+					cnt_move * sizeof(struct sack_edges));
+
+			cnt -= cnt_move;
+			tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+			for (j = cnt; j < TCP_SACK_HILLS; j++) {
+				tcp_lost.hill[j].l = TCP_O_NOP;
+				tcp_lost.hill[j].r = TCP_O_NOP;
 			}
-			break;
 		}
+
+		tcp_update_ack_edge();
+		return;
 	}
-	debug_cond(DEBUG_INT_STATE, "\n");
-	if (!IS_ENABLED(CONFIG_PROT_TCP_SACK) || tcp_lost.len <= TCP_OPT_LEN_2)
-		sack_idx = 0;
-}
+
+	if (i == TCP_SACK_HILLS) {
+		tcp_update_ack_edge();
+		return;
+	}
+
+	if (cnt < TCP_SACK_HILLS) {
+		cnt_move = cnt - i;
+		cnt++;
+	} else {
+		cnt = TCP_SACK_HILLS;
+		cnt_move = TCP_SACK_HILLS - i;
+	}
+
+	if (cnt_move > 0)
+		memmove(&tcp_lost.hill[i + 1],
+			&tcp_lost.hill[i],
+			cnt_move * sizeof(struct sack_edges));
+
+	tcp_lost.hill[i].l = tcp_seq_num;
+	tcp_lost.hill[i].r = tcp_seq_num + len;
+	tcp_lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
+
+	tcp_update_ack_edge();
+};
 
 /**
  * tcp_parse_options() - parsing TCP options
@@ -509,7 +487,6 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	u8 tcp_push = tcp_flags & TCP_PUSH;
 	u8 tcp_ack = tcp_flags & TCP_ACK;
 	u8 action = TCP_DATA;
-	int i;
 
 	/*
 	 * tcp_flags are examined to determine TX action in a given state
@@ -536,6 +513,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action = TCP_SYN | TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
@@ -552,13 +530,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action |= TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
-			sack_idx = 0;
-			edge_a[sack_idx].se.l = tcp_ack_edge;
-			edge_a[sack_idx].se.r = tcp_ack_edge;
-			prev_len = 0;
 			current_tcp_state = TCP_ESTABLISHED;
-			for (i = 0; i < TCP_SACK; i++)
-				edge_a[i].st = NOPKT;
 
 			if (tcp_syn && tcp_ack)
 				action |= TCP_PUSH;
-- 
2.45.2

