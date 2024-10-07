Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5166CF8870
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61F988D97;
	Mon,  7 Oct 2024 22:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="igcFmjde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B582C88D4A; Mon,  7 Oct 2024 22:56:04 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F59C88618
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/0p5wLilByINFeZRQeDQlecCN8nG4iwVG6kBjyO/omMqMYDvZyOLUA39Rt9b9r9+Ege/G9Fmj5QosFInXCKXeS34kW5s3HUojY4yZs5ii0PETaLWG1AOKg5UdL6WLwy0wOWNtE7qrk7YfNtrwfpz4NEyHg2JG15v9pEANguyf2gcfT1kEVr9KR5kCSuLOB/t7VSMiSpV46WRrtGTH1u28RCUK/zB+tQj6ty+KRbRBUUpV59NN/3Ya2tL5ql9RsRcbWzzkPHeLEUsbEUpjSNBnFV+/z2+nhnkFEhfc66/LbmVl9O+5CL6yxy7cMIhpsMpRYq1ago46OOdOSVVkEZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ojSuyDkqSAezgM+ZRwYsie5vYL4/5jxFNtlaPhB9l0=;
 b=Eg28akKhG6F3Cyjdo+E2YpLWICdfCSFdL7ijVbSFk06i4jh9Wf3Xpw1AAHCCuVyZ+M1l16MQpmsjpuC27sJhbiuIWylEyvZlMesdDquneIR52lVedMDnRgX9r/FwMLMFFw/XUPKyJHtp4Lbn6lowYc57bb/fitVkUmrzq0MLERksDNWQtulhKSx2FU3d9+ohV4iNgpaIGtPngj1X61VOv+LYSCZhGB66MhX5+ZbzkNIfb3ZDafINiep0x6nhPZYI+XnXE214gWU970DYaTI4tgibn3evf9flKZYgyJpEIJVNMDXIuoOjLna9jvxRkDBfQBeC5EspUIdhwe2rCtsBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ojSuyDkqSAezgM+ZRwYsie5vYL4/5jxFNtlaPhB9l0=;
 b=igcFmjdeuQMTskt5Mmjgpeve6XwfMufAz7vj91YPwr/gx03jqCw1QbHQ3rqzAMNXG1GcKv78pofCnyKqAGYHhkcKT9ZhN+qWbUayTydM+771RGpZhmu/DS41gXHeFKF05Epgkpi0G37bTu8DYPFP03TBXCvQrWYmW2zk/mcvJVrCCnZSNd7ZT+DKiMdjFCTEvJVswBc6g2Oryu6/v4coaiQ4pmqzRWw+hssXn8aTo1dXgWpala2E3PsSRvKbb6UIjY7nWrrVPDo2/USgeZtqd/ormi8e1sAKp8Mjzj8kO8LkAwuTjnTC0KSm/h+jclaRcDNylI143Bo398JRpJ7+CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:56:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:56:00 +0000
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
Subject: [PATCH v10 04/13] net/tcp: add connection info to tcp_stream structure
Date: Mon,  7 Oct 2024 23:55:34 +0300
Message-ID: <20241007205543.1632499-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0cad9063-5798-418d-d05b-08dce71272d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S8uUMRbnNbhy0+06azS6vJne3YRmfkv2+e8EBrhz4DeT/LK3EwEqSkDGRsof?=
 =?us-ascii?Q?18cfAWzBkyOhHIaS1GsCIvLtzMjJpAy2WBA/C2FPOntGX6RDokfsNpN+wIkd?=
 =?us-ascii?Q?Rvh5DNqmQZ/3MGzWGqPmc8Kywpua3MtUyY0Tj1ZdmGPCSvMgT+ZxG4mZQFgh?=
 =?us-ascii?Q?lmeZLDM1YLATuWjiZ74NizVdn6GOZvqcJUsSA6/1Lyzh85cWJAG6bJTNK7Bm?=
 =?us-ascii?Q?cEsRLkhJBO++VgnteFEBf79enOu5EbZuPBunhTWAVm0DEVc/gtuH6MrKKijL?=
 =?us-ascii?Q?RObkKpkz6FK5T+PF8A0TjLTBQZKury+Pn2IEaIHeynA9i8xnwvLdzeilOmIM?=
 =?us-ascii?Q?3dhInbqLXi/uYURn1cRuDFX+e/CJyHGHltg9tC3f6uL5fbG/tqhuQF7CKZXl?=
 =?us-ascii?Q?+hY+fanFPRIUFl6P+nUqncNR3N1Jr2X4Al+1qd4H4QcIBa/0sbjl6/Xvf1ox?=
 =?us-ascii?Q?utnZGYHZwdl7lGtZP+JhhGBFtfkt6UY1bC+kkhpgKECiUbvyyqBMinrqODLu?=
 =?us-ascii?Q?IDg88AYoDHqaicaYNf2z93z/o2PhvAzrdilDqmfAtfR2plEYVzWlvUN683xi?=
 =?us-ascii?Q?PEfa/UOoxlamdTvMKM1QtyhwcX6AblkaACmS75aUzX1O4TNPRyUweSc2Hf9o?=
 =?us-ascii?Q?9kTyAEGN4YYRz+QKcEH4KGbOoV2kgyOvwbNCoohPpkhygZydGuE4pBtQdJRF?=
 =?us-ascii?Q?dbzvaL/xTfOM2w+NQ0tqahEshUqyKGRasHNknnRntL9YQZCwtIHdSsCb7/Tw?=
 =?us-ascii?Q?+faKuCcBj825MKZ3aiUfzKml08THXR3Y1IuTjPhu2yUo5ETuY3VpZT8SnL0W?=
 =?us-ascii?Q?+ARawXSIqU52pesodxSz3vvIzDJDMv2kyV6o7G3awtSzTFqwke5aEDZKt/Jz?=
 =?us-ascii?Q?M14Urs4BjBb/0RxsQYPEoF/lYBIzEm5LIaC/4uf7ZD3eC1LKnYpvNWxj2Ukd?=
 =?us-ascii?Q?S+1fkUOEgEgY1Ah27nohmaTwf9G/nju1wPRPWi2vQkVNJMGjHz9LFqorB1UU?=
 =?us-ascii?Q?oTtCA8zXD4gt58OfpSmEvXarxrk/50aVXkwkOorx+w+wSk4eexqiRr6WcXGL?=
 =?us-ascii?Q?4aB41+LH1mdb8EHW4z2TOWP+zY2PLZz05sEabDaE+fFTd2SdmYn9LDPQk/Fu?=
 =?us-ascii?Q?s3cvx+Y7oAaswUx9UtndkQQlmUjLHGejF4vYXnzrZ9vVhtBfI1Y/VORKqopD?=
 =?us-ascii?Q?LmSPYG7Ul70EYzUMBPAQ01ObwQQPmq+/SN3Nuw4t2YOxr+IOAhiyTAL0m02R?=
 =?us-ascii?Q?j7k00fPGtpFTekokbpje21dekxx0zJ0eTaC8yJKLOq58l9PzLxpjwG6MIS0K?=
 =?us-ascii?Q?dYTK3TvJyn5sxKEtiQbm0tiIRzIehXSbUu31fLqX4D51qw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c6h+N/JCfZPtDTWp0wisFUFI1SVENS/QdHk/GfoOwC10JNfcAD5orfgV04m9?=
 =?us-ascii?Q?U4avo9E55vzo3RPC7CmCGtnqnmsLiTWIwTEcn0gsjKMiyLnIdzNW18CPykaF?=
 =?us-ascii?Q?1AAhhmtBcs55A7emoe3bot6t+5MSdYu7AjVpUW9HXPSWDwtF8Oq1N4b54Z+p?=
 =?us-ascii?Q?c9YrOmmd84T4Lrw2LAd+4k1nH0oSjZoQGrUXIby4TuFjemEGO/lnkpAC8xwL?=
 =?us-ascii?Q?geBLamIBwfSy/HDS0jItE9HMMQgGMqhqAYJHz1xS5TI8Arzq4f15Ds0jnxNP?=
 =?us-ascii?Q?Io9Yxa7vXww25Z/l1kE1AmZBDhmm/c5XQ4E0WWZb6GNL3cnoiTGOxQRxpfw8?=
 =?us-ascii?Q?nY7mOy4vwsQClaK0p1Tn1E87gCfXajJ2FlnFEz47/d8A1dbAi7ZhrXolTdBe?=
 =?us-ascii?Q?sacIJrwTOt9F2BKShdCKw0jLfAXXj0FeRU5oquHgFY1U5Q1yWYEVfiIJkNur?=
 =?us-ascii?Q?uFrveVE7emCKMrhv0VPZMLdng4EzkB8mQQolyhFqveyLqrqJv3ldTAHwwzDI?=
 =?us-ascii?Q?9qz0CoFCNLx6g9LYd6BN0BJArJagfZ6WCjD7sO/L3/kgXTBdrA7q3ZE3Cf+F?=
 =?us-ascii?Q?xgV1QEzwkFK+vPi9Lw66SGWLDNcsdCz/w7udKGfL7aINj2L5vgEPWswN1EYK?=
 =?us-ascii?Q?QT/LvQIhWZ8MVvUdbk6qTHyNFpxt9bJQy0Y6/OBT7JQ4Z9+7Ysf8FMkxGS12?=
 =?us-ascii?Q?zpQOuZV7hBhiPQBJ7T0xeS0GrVhy/yj+/XoSuuWKITb5BacDuAVxkTi/V5g0?=
 =?us-ascii?Q?wqjJZ0C2T/0L+6BXqY6pyz07HLcYLH6W/sNyPgL5eZ0WEuCT9kXcNvge0LtP?=
 =?us-ascii?Q?XcHf+liFvFi82JfTOKeiRn7vB85WIeNwa+1AvMcLBvk3VbEgZLacaYJ9mm2B?=
 =?us-ascii?Q?EgRKDrBd0X37I2m+4N+KO+HgR7ibTuOudpbqw5/FZuLnfOGYvt8PAPSDhxfC?=
 =?us-ascii?Q?37iWjnrILFofFcFibaATiCRP32OzYW0Jt3OE5tf0sGrIkEjw1MRcVRosunH9?=
 =?us-ascii?Q?cpIHYt7PtU+5hcTdtCBaPm2jq+8RfDn/rxoE/SbCpBDZl8Hsfg1TOZ+8oZyI?=
 =?us-ascii?Q?0NtmaxUVvlk2NqDRdz5OWFjZmFiDLYFpNcvWd9uRQ1VOzot8LFhY2P5n6aer?=
 =?us-ascii?Q?xWZssx02N1gSauZBmvObU3Z0jPLN1N5MkQauZrErlEnnnTXLjTixMU/GDPa6?=
 =?us-ascii?Q?U+vJW0kz9rUhHtjEhkKzn+tQpQzAXvjGBTRngrSanG8MX2mr/kZ0DjiUr/Uq?=
 =?us-ascii?Q?axjeu8Xyr6S/rEudiUCNGnIeaTZTGaSr9MpkRNypTeTh1XDgBPqPsIhi0uDa?=
 =?us-ascii?Q?U/ts1Xo+jrlY7OoDsCeLuH33bouPiTualQo55E9lw8vf91TIyl8VUeTianov?=
 =?us-ascii?Q?SNliU9VJgFIREttjN9KIoxQxHNvZ750JPdPcWe7nVep4KLz6zkA7w4Zvu27y?=
 =?us-ascii?Q?Tnl6aVhrrvvoxHw0RCkxnf+3fyrt3icJrW0ndgVU7+cQhuG10ncBsUBQ5U8Y?=
 =?us-ascii?Q?21VsRINFSEdHl5gaRS7StgQtQ1WB3kPAe0zp/BCYLIvYPKvvxEeBQTwjd+ko?=
 =?us-ascii?Q?AllVrx8P6cqGcl4pLnDo1JAYm7Tzht7Kv8Rls9xRLFGbKBY9m4UK+q9YChuP?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cad9063-5798-418d-d05b-08dce71272d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:56:00.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYeSL8ZNZuICFDKETDKJsVsZJdxdQkaa2fMVBz/tcf8EuTabi0hRQcs0FVMt7EtDowJ/Hauj0UZS6hGlpy21oEWUa5dkdrY2qZdQCTiC8rI=
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

Changes:
 * Avoid use net_server_ip in tcp code, use tcp_stream data instead
 * Ignore packets from other connections if connection already created.
   This prevents us from connection break caused by other tcp stream.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net.h      |   5 +-
 include/net/tcp.h  |  57 +++++++++++++++++---
 net/fastboot_tcp.c |  50 +++++++++--------
 net/net.c          |  12 ++---
 net/tcp.c          | 131 ++++++++++++++++++++++++++++++++++-----------
 net/wget.c         |  52 +++++++-----------
 6 files changed, 204 insertions(+), 103 deletions(-)

diff --git a/include/net.h b/include/net.h
index bb2ae20f52a..b0ce13e0a9d 100644
--- a/include/net.h
+++ b/include/net.h
@@ -667,6 +667,7 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 /**
  * net_send_tcp_packet() - Transmit TCP packet.
  * @payload_len: length of payload
+ * @dhost: Destination host
  * @dport: Destination TCP port
  * @sport: Source TCP port
  * @action: TCP action to be performed
@@ -675,8 +676,8 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
  *
  * Return: 0 on success, other value on failure
  */
-int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
-			u32 tcp_seq_num, u32 tcp_ack_num);
+int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
+			int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport,
 			int sport, int payload_len);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 14aee64cb1c..f224d0cae2f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -279,6 +279,9 @@ enum tcp_state {
 
 /**
  * struct tcp_stream - TCP data stream structure
+ * @rhost:		Remote host, network byte order
+ * @rport:		Remote port, host byte order
+ * @lport:		Local port, host byte order
  *
  * @state:		TCP connection state
  *
@@ -291,6 +294,10 @@ enum tcp_state {
  * @lost:		Used for SACK
  */
 struct tcp_stream {
+	struct in_addr	rhost;
+	u16		rport;
+	u16		lport;
+
 	/* TCP connection state */
 	enum tcp_state	state;
 
@@ -305,16 +312,53 @@ struct tcp_stream {
 	struct tcp_sack_v lost;
 };
 
-struct tcp_stream *tcp_stream_get(void);
+void tcp_init(void);
+
+typedef int tcp_incoming_filter(struct in_addr rhost,
+				u16 rport, u16 sport);
+
+/*
+ * This function sets user callback used to accept/drop incoming
+ * connections. Callback should:
+ *  + Check TCP stream endpoint and make connection verdict
+ *    - return non-zero value to accept connection
+ *    - return zero to drop connection
+ *
+ * WARNING: If callback is NOT defined, all incoming connections
+ *          will be dropped.
+ */
+void tcp_set_incoming_filter(tcp_incoming_filter *filter);
+
+/*
+ * tcp_stream_get -- Get or create TCP stream
+ * @is_new:	if non-zero and no stream found, then create a new one
+ * @rhost:	Remote host, network byte order
+ * @rport:	Remote port, host byte order
+ * @lport:	Local port, host byte order
+ *
+ * Returns: TCP stream structure or NULL (if not found/created)
+ */
+struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
+				  u16 rport, u16 lport);
+
+/*
+ * tcp_stream_connect -- Create new TCP stream for remote connection.
+ * @rhost:	Remote host, network byte order
+ * @rport:	Remote port, host byte order
+ *
+ * Returns: TCP new stream structure or NULL (if not created).
+ *          Random local port will be used.
+ */
+struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport);
+
+enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp);
 
-enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp);
-void tcp_set_tcp_state(struct tcp_stream *tcp, enum tcp_state new_state);
-int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
-		       int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 
 /**
  * rxhand_tcp() - An incoming packet handler.
+ * @tcp: TCP stream
  * @pkt: pointer to the application packet
  * @dport: destination TCP port
  * @sip: source IP address
@@ -324,8 +368,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
  * @action: TCP action (SYN, ACK, FIN, etc)
  * @len: packet length
  */
-typedef void rxhand_tcp(uchar *pkt, u16 dport,
-			struct in_addr sip, u16 sport,
+typedef void rxhand_tcp(struct tcp_stream *tcp, uchar *pkt,
 			u32 tcp_seq_num, u32 tcp_ack_num,
 			u8 action, unsigned int len);
 void tcp_set_tcp_handler(rxhand_tcp *f);
diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index d1fccbc7238..4d34fdc5a45 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -8,14 +8,14 @@
 #include <net/fastboot_tcp.h>
 #include <net/tcp.h>
 
-static char command[FASTBOOT_COMMAND_LEN] = {0};
-static char response[FASTBOOT_RESPONSE_LEN] = {0};
+#define FASTBOOT_TCP_PORT	5554
+
+static char command[FASTBOOT_COMMAND_LEN];
+static char response[FASTBOOT_RESPONSE_LEN];
 
 static const unsigned short handshake_length = 4;
 static const uchar *handshake = "FB01";
 
-static u16 curr_sport;
-static u16 curr_dport;
 static u32 curr_tcp_seq_num;
 static u32 curr_tcp_ack_num;
 static unsigned int curr_request_len;
@@ -25,34 +25,37 @@ static enum fastboot_tcp_state {
 	FASTBOOT_DISCONNECTING
 } state = FASTBOOT_CLOSED;
 
-static void fastboot_tcp_answer(u8 action, unsigned int len)
+static void fastboot_tcp_answer(struct tcp_stream *tcp, u8 action,
+				unsigned int len)
 {
 	const u32 response_seq_num = curr_tcp_ack_num;
 	const u32 response_ack_num = curr_tcp_seq_num +
 		  (curr_request_len > 0 ? curr_request_len : 1);
 
-	net_send_tcp_packet(len, htons(curr_sport), htons(curr_dport),
+	net_send_tcp_packet(len, tcp->rhost, tcp->rport, tcp->lport,
 			    action, response_seq_num, response_ack_num);
 }
 
-static void fastboot_tcp_reset(void)
+static void fastboot_tcp_reset(struct tcp_stream *tcp)
 {
-	fastboot_tcp_answer(TCP_RST, 0);
+	fastboot_tcp_answer(tcp, TCP_RST, 0);
 	state = FASTBOOT_CLOSED;
 }
 
-static void fastboot_tcp_send_packet(u8 action, const uchar *data, unsigned int len)
+static void fastboot_tcp_send_packet(struct tcp_stream *tcp, u8 action,
+				     const uchar *data, unsigned int len)
 {
 	uchar *pkt = net_get_async_tx_pkt_buf();
 
 	memset(pkt, '\0', PKTSIZE);
 	pkt += net_eth_hdr_size() + IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
 	memcpy(pkt, data, len);
-	fastboot_tcp_answer(action, len);
+	fastboot_tcp_answer(tcp, action, len);
 	memset(pkt, '\0', PKTSIZE);
 }
 
-static void fastboot_tcp_send_message(const char *message, unsigned int len)
+static void fastboot_tcp_send_message(struct tcp_stream *tcp,
+				      const char *message, unsigned int len)
 {
 	__be64 len_be = __cpu_to_be64(len);
 	uchar *pkt = net_get_async_tx_pkt_buf();
@@ -63,12 +66,11 @@ static void fastboot_tcp_send_message(const char *message, unsigned int len)
 	memcpy(pkt, &len_be, 8);
 	pkt += 8;
 	memcpy(pkt, message, len);
-	fastboot_tcp_answer(TCP_ACK | TCP_PUSH, len + 8);
+	fastboot_tcp_answer(tcp, TCP_ACK | TCP_PUSH, len + 8);
 	memset(pkt, '\0', PKTSIZE);
 }
 
-static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
-				      struct in_addr sip, u16 sport,
+static void fastboot_tcp_handler_ipv4(struct tcp_stream *tcp, uchar *pkt,
 				      u32 tcp_seq_num, u32 tcp_ack_num,
 				      u8 action, unsigned int len)
 {
@@ -77,8 +79,6 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 	u8 tcp_fin = action & TCP_FIN;
 	u8 tcp_push = action & TCP_PUSH;
 
-	curr_sport = sport;
-	curr_dport = dport;
 	curr_tcp_seq_num = tcp_seq_num;
 	curr_tcp_ack_num = tcp_ack_num;
 	curr_request_len = len;
@@ -89,17 +89,17 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 			if (len != handshake_length ||
 			    strlen(pkt) != handshake_length ||
 			    memcmp(pkt, handshake, handshake_length) != 0) {
-				fastboot_tcp_reset();
+				fastboot_tcp_reset(tcp);
 				break;
 			}
-			fastboot_tcp_send_packet(TCP_ACK | TCP_PUSH,
+			fastboot_tcp_send_packet(tcp, TCP_ACK | TCP_PUSH,
 						 handshake, handshake_length);
 			state = FASTBOOT_CONNECTED;
 		}
 		break;
 	case FASTBOOT_CONNECTED:
 		if (tcp_fin) {
-			fastboot_tcp_answer(TCP_FIN | TCP_ACK, 0);
+			fastboot_tcp_answer(tcp, TCP_FIN | TCP_ACK, 0);
 			state = FASTBOOT_DISCONNECTING;
 			break;
 		}
@@ -111,12 +111,12 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 
 			// Only single packet messages are supported ATM
 			if (strlen(pkt) != command_size) {
-				fastboot_tcp_reset();
+				fastboot_tcp_reset(tcp);
 				break;
 			}
 			strlcpy(command, pkt, len + 1);
 			fastboot_command_id = fastboot_handle_command(command, response);
-			fastboot_tcp_send_message(response, strlen(response));
+			fastboot_tcp_send_message(tcp, response, strlen(response));
 			fastboot_handle_boot(fastboot_command_id,
 					     strncmp("OKAY", response, 4) == 0);
 		}
@@ -129,17 +129,21 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 
 	memset(command, 0, FASTBOOT_COMMAND_LEN);
 	memset(response, 0, FASTBOOT_RESPONSE_LEN);
-	curr_sport = 0;
-	curr_dport = 0;
 	curr_tcp_seq_num = 0;
 	curr_tcp_ack_num = 0;
 	curr_request_len = 0;
 }
 
+static int incoming_filter(struct in_addr rhost, u16 rport, u16 lport)
+{
+	return (lport == FASTBOOT_TCP_PORT);
+}
+
 void fastboot_tcp_start_server(void)
 {
 	printf("Using %s device\n", eth_get_name());
 	printf("Listening for fastboot command on tcp %pI4\n", &net_ip);
 
+	tcp_set_incoming_filter(incoming_filter);
 	tcp_set_tcp_handler(fastboot_tcp_handler_ipv4);
 }
diff --git a/net/net.c b/net/net.c
index 1bbf0556cef..c95a40f1a2b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -419,7 +419,7 @@ int net_init(void)
 		/* Only need to setup buffer pointers once. */
 		first_call = 0;
 		if (IS_ENABLED(CONFIG_PROT_TCP))
-			tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
+			tcp_init();
 	}
 
 	return net_init_loop();
@@ -904,10 +904,10 @@ int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 }
 
 #if defined(CONFIG_PROT_TCP)
-int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
-			u32 tcp_seq_num, u32 tcp_ack_num)
+int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
+			int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
-	return net_send_ip_packet(net_server_ethaddr, net_server_ip, dport,
+	return net_send_ip_packet(net_server_ethaddr, dhost, dport,
 				  sport, payload_len, IPPROTO_TCP, action,
 				  tcp_seq_num, tcp_ack_num);
 }
@@ -949,12 +949,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 		break;
 #if defined(CONFIG_PROT_TCP)
 	case IPPROTO_TCP:
-		tcp = tcp_stream_get();
+		tcp = tcp_stream_get(0, dest, dport, sport);
 		if (tcp == NULL)
 			return -EINVAL;
 
 		pkt_hdr_size = eth_hdr_size
-			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size, dport, sport,
+			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size,
 					     payload_len, action, tcp_seq_num,
 					     tcp_ack_num);
 		break;
diff --git a/net/tcp.c b/net/tcp.c
index 6646f171b83..0c32c5d7c92 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -26,6 +26,7 @@
 
 static int tcp_activity_count;
 static struct tcp_stream tcp_stream;
+static tcp_incoming_filter *incoming_filter;
 
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
@@ -40,40 +41,95 @@ static struct tcp_stream tcp_stream;
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
+#define RANDOM_PORT_START 1024
+#define RANDOM_PORT_RANGE 0x4000
+
+/**
+ * random_port() - make port a little random (1024-17407)
+ *
+ * Return: random port number from 1024 to 17407
+ *
+ * This keeps the math somewhat trivial to compute, and seems to work with
+ * all supported protocols/clients/servers
+ */
+static uint random_port(void)
+{
+	return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
+}
+
 static inline s32 tcp_seq_cmp(u32 a, u32 b)
 {
 	return (s32)(a - b);
 }
 
 /**
- * tcp_get_tcp_state() - get TCP stream state
+ * tcp_stream_get_state() - get TCP stream state
  * @tcp: tcp stream
  *
  * Return: TCP stream state
  */
-enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp)
+enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp)
 {
 	return tcp->state;
 }
 
 /**
- * tcp_set_tcp_state() - set TCP stream state
+ * tcp_stream_set_state() - set TCP stream state
  * @tcp: tcp stream
  * @new_state: new TCP state
  */
-void tcp_set_tcp_state(struct tcp_stream *tcp,
-		       enum tcp_state new_state)
+static void tcp_stream_set_state(struct tcp_stream *tcp,
+				 enum tcp_state new_state)
 {
 	tcp->state = new_state;
 }
 
-struct tcp_stream *tcp_stream_get(void)
+void tcp_init(void)
+{
+	incoming_filter = NULL;
+	tcp_stream.state = TCP_CLOSED;
+}
+
+void tcp_set_incoming_filter(tcp_incoming_filter *filter)
+{
+	incoming_filter = filter;
+}
+
+static struct tcp_stream *tcp_stream_add(struct in_addr rhost,
+					 u16 rport, u16 lport)
+{
+	struct tcp_stream *tcp = &tcp_stream;
+
+	if (tcp->state != TCP_CLOSED)
+		return NULL;
+
+	memset(tcp, 0, sizeof(struct tcp_stream));
+	tcp->rhost.s_addr = rhost.s_addr;
+	tcp->rport = rport;
+	tcp->lport = lport;
+	tcp->state = TCP_CLOSED;
+	tcp->lost.len = TCP_OPT_LEN_2;
+	return tcp;
+}
+
+struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
+				  u16 rport, u16 lport)
 {
-	return &tcp_stream;
+	struct tcp_stream *tcp = &tcp_stream;
+
+	if (tcp->rhost.s_addr == rhost.s_addr &&
+	    tcp->rport == rport &&
+	    tcp->lport == lport)
+		return tcp;
+
+	if (!is_new || !incoming_filter) ||
+	    !incoming_filter(rhost, rport, lport))
+		return NULL;
+
+	return tcp_stream_add(rhost, rport, lport);
 }
 
-static void dummy_handler(uchar *pkt, u16 dport,
-			  struct in_addr sip, u16 sport,
+static void dummy_handler(struct tcp_stream *tcp, uchar *pkt,
 			  u32 tcp_seq_num, u32 tcp_ack_num,
 			  u8 action, unsigned int len)
 {
@@ -222,8 +278,7 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
-int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
-		       int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
@@ -243,7 +298,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	case TCP_SYN:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num);
 		tcp_activity_count = 0;
 		net_set_syn_options(tcp, b);
@@ -264,13 +319,13 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 		b->ip.hdr.tcp_flags = action;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num,
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
 			   action);
 		break;
 	case TCP_FIN:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		payload_len = 0;
 		pkt_hdr_len = IP_TCP_HDR_SIZE;
 		tcp->state = TCP_FIN_WAIT_1;
@@ -279,7 +334,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		tcp->state = TCP_CLOSED;
 		break;
 	/* Notify connection closing */
@@ -290,7 +345,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num, action);
 		fallthrough;
 	default:
@@ -298,7 +353,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num, action);
 	}
 
@@ -308,8 +363,8 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	tcp->ack_edge = tcp_ack_num;
 	/* TCP Header */
 	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
-	b->ip.hdr.tcp_src = htons(sport);
-	b->ip.hdr.tcp_dst = htons(dport);
+	b->ip.hdr.tcp_src = htons(tcp->lport);
+	b->ip.hdr.tcp_dst = htons(tcp->rport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
 
 	/*
@@ -332,10 +387,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	b->ip.hdr.tcp_xsum = 0;
 	b->ip.hdr.tcp_ugr = 0;
 
-	b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, net_server_ip,
+	b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, tcp->rhost,
 						   tcp_len, pkt_len);
 
-	net_set_ip_header((uchar *)&b->ip, net_server_ip, net_ip,
+	net_set_ip_header((uchar *)&b->ip, tcp->rhost, net_ip,
 			  pkt_len, IPPROTO_TCP);
 
 	return pkt_hdr_len;
@@ -616,19 +671,26 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	u32 tcp_seq_num, tcp_ack_num;
 	int tcp_hdr_len, payload_len;
 	struct tcp_stream *tcp;
+	struct in_addr src;
 
 	/* Verify IP header */
 	debug_cond(DEBUG_DEV_PKT,
 		   "TCP RX in RX Sum (to=%pI4, from=%pI4, len=%d)\n",
 		   &b->ip.hdr.ip_src, &b->ip.hdr.ip_dst, pkt_len);
 
-	b->ip.hdr.ip_src = net_server_ip;
+	/*
+	 * src IP address will be destroyed by TCP checksum verification
+	 * algorithm (see tcp_set_pseudo_header()), so remember it before
+	 * it was garbaged.
+	 */
+	src.s_addr = b->ip.hdr.ip_src.s_addr;
+
 	b->ip.hdr.ip_dst = net_ip;
 	b->ip.hdr.ip_sum = 0;
 	if (tcp_rx_xsum != compute_ip_checksum(b, IP_HDR_SIZE)) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP RX IP xSum Error (%pI4, =%pI4, len=%d)\n",
-			   &net_ip, &net_server_ip, pkt_len);
+			   &net_ip, &src, pkt_len);
 		return;
 	}
 
@@ -640,12 +702,15 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 						 pkt_len)) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP RX TCP xSum Error (%pI4, %pI4, len=%d)\n",
-			   &net_ip, &net_server_ip, tcp_len);
+			   &net_ip, &src, tcp_len);
 		return;
 	}
 
-	tcp = tcp_stream_get();
-	if (tcp == NULL)
+	tcp = tcp_stream_get(b->ip.hdr.tcp_flags & TCP_SYN,
+			     src,
+			     ntohs(b->ip.hdr.tcp_src),
+			     ntohs(b->ip.hdr.tcp_dst));
+	if (!tcp)
 		return;
 
 	tcp_hdr_len = GET_TCP_HDR_LEN_IN_BYTES(b->ip.hdr.tcp_hlen);
@@ -676,9 +741,9 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 			   "TCP Notify (action=%x, Seq=%u,Ack=%u,Pay%d)\n",
 			   tcp_action, tcp_seq_num, tcp_ack_num, payload_len);
 
-		(*tcp_packet_handler) ((uchar *)b + pkt_len - payload_len, b->ip.hdr.tcp_dst,
-				       b->ip.hdr.ip_src, b->ip.hdr.tcp_src, tcp_seq_num,
-				       tcp_ack_num, tcp_action, payload_len);
+		(*tcp_packet_handler) (tcp, (uchar *)b + pkt_len - payload_len,
+				       tcp_seq_num, tcp_ack_num, tcp_action,
+				       payload_len);
 
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
@@ -689,9 +754,13 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
 		 * here to outgoing Seq & Ack sequence numbers
 		 */
-		net_send_tcp_packet(0, ntohs(b->ip.hdr.tcp_src),
-				    ntohs(b->ip.hdr.tcp_dst),
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
 				    tcp_ack_num, tcp->ack_edge);
 	}
 }
+
+struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport)
+{
+	return tcp_stream_add(rhost, rport, random_port());
+}
diff --git a/net/wget.c b/net/wget.c
index 99ffa90c494..9c68a9d43cc 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -28,9 +28,8 @@ static const char http_eom[] = "\r\n\r\n";
 static const char http_ok[] = "200";
 static const char content_len[] = "Content-Length";
 static const char linefeed[] = "\r\n";
-static struct in_addr web_server_ip;
-static int our_port;
 static int wget_timeout_count;
+struct tcp_stream *tcp;
 
 struct pkt_qd {
 	uchar *pkt;
@@ -110,22 +109,19 @@ static void wget_send_stored(void)
 	int len = retry_len;
 	unsigned int tcp_ack_num = retry_tcp_seq_num + (len == 0 ? 1 : len);
 	unsigned int tcp_seq_num = retry_tcp_ack_num;
-	unsigned int server_port;
 	uchar *ptr, *offset;
 
-	server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
-
 	switch (current_wget_state) {
 	case WGET_CLOSED:
 		debug_cond(DEBUG_WGET, "wget: send SYN\n");
 		current_wget_state = WGET_CONNECTING;
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 		packets = 0;
 		break;
 	case WGET_CONNECTING:
 		pkt_q_idx = 0;
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 
 		ptr = net_tx_packet + net_eth_hdr_size() +
@@ -140,14 +136,14 @@ static void wget_send_stored(void)
 
 		memcpy(offset, &bootfile3, strlen(bootfile3));
 		offset += strlen(bootfile3);
-		net_send_tcp_packet((offset - ptr), server_port, our_port,
+		net_send_tcp_packet((offset - ptr), tcp->rhost, tcp->rport, tcp->lport,
 				    TCP_PUSH, tcp_seq_num, tcp_ack_num);
 		current_wget_state = WGET_CONNECTED;
 		break;
 	case WGET_CONNECTED:
 	case WGET_TRANSFERRING:
 	case WGET_TRANSFERRED:
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 		break;
 	}
@@ -304,10 +300,8 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 
 /**
  * wget_handler() - TCP handler of wget
+ * @tcp: TCP stream
  * @pkt: pointer to the application packet
- * @dport: destination TCP port
- * @sip: source IP address
- * @sport: source TCP port
  * @tcp_seq_num: TCP sequential number
  * @tcp_ack_num: TCP acknowledgment number
  * @action: TCP action (SYN, ACK, FIN, etc)
@@ -316,13 +310,11 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
  * In the "application push" invocation, the TCP header with all
  * its information is pointed to by the packet pointer.
  */
-static void wget_handler(uchar *pkt, u16 dport,
-			 struct in_addr sip, u16 sport,
+static void wget_handler(struct tcp_stream *tcp, uchar *pkt,
 			 u32 tcp_seq_num, u32 tcp_ack_num,
 			 u8 action, unsigned int len)
 {
-	struct tcp_stream *tcp = tcp_stream_get();
-	enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
+	enum tcp_state wget_tcp_state = tcp_stream_get_state(tcp);
 
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	packets++;
@@ -409,26 +401,13 @@ static void wget_handler(uchar *pkt, u16 dport,
 	}
 }
 
-#define RANDOM_PORT_START 1024
-#define RANDOM_PORT_RANGE 0x4000
-
-/**
- * random_port() - make port a little random (1024-17407)
- *
- * Return: random port number from 1024 to 17407
- *
- * This keeps the math somewhat trivial to compute, and seems to work with
- * all supported protocols/clients/servers
- */
-static unsigned int random_port(void)
-{
-	return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
-}
-
 #define BLOCKSIZE 512
 
 void wget_start(void)
 {
+	struct in_addr web_server_ip;
+	unsigned int server_port;
+
 	image_url = strchr(net_boot_file_name, ':');
 	if (image_url > 0) {
 		web_server_ip = string_to_ip(net_boot_file_name);
@@ -472,8 +451,6 @@ void wget_start(void)
 	wget_timeout_count = 0;
 	current_wget_state = WGET_CLOSED;
 
-	our_port = random_port();
-
 	/*
 	 * Zero out server ether to force arp resolution in case
 	 * the server ip for the previous u-boot command, for example dns
@@ -482,6 +459,13 @@ void wget_start(void)
 
 	memset(net_server_ethaddr, 0, 6);
 
+	server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
+	tcp = tcp_stream_connect(web_server_ip, server_port);
+	if (tcp == NULL) {
+		net_set_state(NETLOOP_FAIL);
+		return;
+	}
+
 	wget_send(TCP_SYN, 0, 0, 0);
 }
 
-- 
2.45.2

