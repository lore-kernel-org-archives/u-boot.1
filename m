Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DD7E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 256FD896AF;
	Wed,  4 Dec 2024 00:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iADMoDxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1142489699; Wed,  4 Dec 2024 00:01:12 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D95DD8969F
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/OPEsT32z6YHBmjuePKlmnxxVwFpshKYFTkOLA1S1u4fj1xFhKQu9rXYZkPt6T7bsp282qtI+o6hJpq+Dt9WZ8XMad9lOfE01zgaM+vqQafRthYm2WOBsedipjTPRXSZHvuOwvCjX7eckWghoFmjuG0aZRit34tnuZJQfarsZ8GB/u+bs6tJxbsG78yriy9uAPwCqtWNWIjRgF+e1FH3DV2sod+yHT3bYxMyTCrOSyAGfMpAhX+veksH4A5NFWP9x80HzoCNBGDT0niV8JWuQif2dcRiiwBfts8Bua8vND15U31Dk9+wYR0NjdZFuu78170ZV3ykoi4PuqewKSHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNIv8s2QnGUluHGGhLOwLOMZXuwM/nKUAQnf9g+lnnA=;
 b=Z4aQfuHVTqld3mkp/vB+t3mz8BvpqHteREK8piXVwmRMSXmdl5qmzRrrreLwryv9fnnIIDZ7ZSNq0qIn9IAvsGg5W9hdjpPDnfhIS1EefI7NXfn+m4wUbnWokGI9+hpGklF7voqS89kOfnsgqJyHO3td5qKc9abOo5GllVkrLLkgSAOO0hJZzfdIbqbbhHdbKyZ/nw/Ep5BotXccIgT8XZ4xDpaS7k2VgUcT4nfd77p2I/nlO2Md2kjdQcbbMMJChiQL9STI8BL8eIwwDTYP+KQ/+0hoPIDiQb1uJmKsV/JZ5nsCZoR+hlygESMUSUalVoEikcsPCfgMrm3WGsHx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNIv8s2QnGUluHGGhLOwLOMZXuwM/nKUAQnf9g+lnnA=;
 b=iADMoDxvqh7RojDa2z+gtDavEfkL63UmoeMF39pbyfZvcPqRecFRfV+aDEQu98zIIznMn5UuM9/5ne1HtBc0zSLA8JD0O6fVxdwei6WIQyUSbparU+4ZKM2ykqnEI7frOl6HyFkhjcuZ6LtqssYMSQ1lSzU63YHcK6bE8k/dBthDOhuVRTNNti612Ql7CLx9DqhKSEDaLvVP+cfNrGIu+1T6g7ccRRN2yfiUpE+4dAx1R4n1YGzj9JvYKo/xvlCxu0jx6qZW3icAgl9s912ESESrb+MnOIEtdVgkqz6VEhK0OjT5ifuUs8ywUM/cZTZs3sbs9TqcZv5K2LYPfUy/ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:01:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:01:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 08/10] net/tcp: simplify tcp header filling code
Date: Wed,  4 Dec 2024 02:00:47 +0300
Message-ID: <20241203230049.2677155-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: b6234cd4-ad6d-4482-7682-08dd13ee5f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ClA9xcn41qJORQTqMdzJd8kuouWXwf7PRk9Z8KKacxZPUcRQNlTNTUXFg3Ji?=
 =?us-ascii?Q?K0ZF8xkMZDV/ijT/KtVybMAO6ww9DZzojSevGV7TbVOMfZ/MDfokm+XrqtYr?=
 =?us-ascii?Q?BYVGqdzwcYPIEvsMkWWW1RKIPjoab8unZhZ29t1gnEmcmiuel0w+7XPya1Ki?=
 =?us-ascii?Q?aFnRYEU/vSxBSm2MOX9OoVnVYZ5KUTw2RTIvFueIDqcg3t46I6+QTSOJsQTQ?=
 =?us-ascii?Q?A6m+CEkbMOPKzbNOpCiHQO0yBfKPeie4M1c5Tlz9Bk07rZnuhUExwLmPldnd?=
 =?us-ascii?Q?u3FbsEbX3uLDarurnvmnLdT6HTPLytVBUiu8AhI8RyESlpzbIWAdKeOqwVSN?=
 =?us-ascii?Q?90zw4TOq2m/rjbB801blxIxe5C61Nuz+AsiMVLOBHTOKXf19KxM5NDPK3j17?=
 =?us-ascii?Q?j2TGxvbkhmDvhR/HquCu0vzQFl0eYoNf6rvt33Cb5a0uMRRvtQ+wDQKoZbnI?=
 =?us-ascii?Q?7nGCfZYjLc2ANfaF6Gm/BzSBsJif4Tm5RzwrrBRmuUH51vmW95oju78tpH/E?=
 =?us-ascii?Q?NRr6nOarHtuV9tSvlrMWv8EVNaG6Sb9fSD2oMNceTGjzFBDEGPE4gDFlzBXh?=
 =?us-ascii?Q?SiE/UF4rbo2fxLwH85IywA1QsHbWs+M0bRAPU4NER0NP3JOqvPVKv0nl3KxS?=
 =?us-ascii?Q?GKVNSUd3NpEMR5JNc1TplYxSKTUST3EZi4wFTm1yCimTRn8J13EZbTOlyWHX?=
 =?us-ascii?Q?FgggeF3qqit1hP1M/c296R28xMpRoYVFRVBwb1kj1vFbODkqi9pCnDmhIuUI?=
 =?us-ascii?Q?ZtktELjJXjGQmbKiM8CbEPJ+jKxepNUnZKzSuepw3weRt9KY7usp4HFGoar1?=
 =?us-ascii?Q?9cyiDQGS2TQLRI89TH1Zif8hUqd0ULMpcG83i+zdYvzDa2n9YwaIPMasJ4vd?=
 =?us-ascii?Q?T5g741ssFm3l3nt0zLN9vE1lCoEbUJMtKsxVn3OmqTXUx08q2H9B0dpvcmMX?=
 =?us-ascii?Q?IPP8/jMI7xK/+pRr8DiLPfaSdIt4XB+PhMCHwL22DBDX+HRZk978Cfs0z2kj?=
 =?us-ascii?Q?04H+2uK+q/OQDR/TWvvAKwrcxi/WPf248gjmIKsG75w832iLEyjwjPjuKvSI?=
 =?us-ascii?Q?TVlSChMdgMyvqnroAxVZxovsGqcRTQlGG9eTV5Ctb6fo6nIppuS8hUCO55J5?=
 =?us-ascii?Q?d0D0+0oXH3mmHqphFLUj5nbQJzGSJOP/0cuPICz/ReOrFN7Q9ZV1SxOHGEuF?=
 =?us-ascii?Q?iAUWie+6nWCI/ZhXb+nLQzMoaykQ6VYKiLAp5sTGze3gpZ4CmAfCYDobb+7Z?=
 =?us-ascii?Q?Yzkjxe/j1bmQUDYQqlo1yyG6qgANlJA5uQrxo/T8H0G4/Rb71ZTHmHbxHIS4?=
 =?us-ascii?Q?YsIG0nvcDq4d+FAxRowMQcl+lEEKyeUythQfBuRYkB33RV6ahPV1l2MbYA2Q?=
 =?us-ascii?Q?CeUURE7PVq8ZbER9G2p85Axn2IreSvgt1gEw+fsZv+HedbTuow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qg44BISpo/0hvo807JjZ2gnK7GVvhT4QHfxZHNmMv3MOyukyshM/EZHJjH1A?=
 =?us-ascii?Q?OrdsbDQtYckPZXi1YrWMsgvYLRem3JI8+USPIkbC/aqAHp66j11fjG00dioh?=
 =?us-ascii?Q?dw1N2JjYRJ/s3d4G0rsbLjdIXiKUgZbe1wB4P27BtoQxJ2aVlubEhxGMfh9i?=
 =?us-ascii?Q?mfzqksA6E7GbpuwBDyBJP5oew0hyNf0cgkY+hc793gjyHf017RD0cesKqEJw?=
 =?us-ascii?Q?hz5Cdp6ZMTWT6m2ifFVTRfqDZI5hlVnnr+hFZoCcCe2AvPa8g64UzRtI5fqF?=
 =?us-ascii?Q?T+qftdBTM3heSnQN3Wtxo/VU9Stsv5Tmbh7Wpd3HAwqlr6DAZJI8mGWv0SWj?=
 =?us-ascii?Q?W2YoCG5v7IX8mElmn3qLxi/81j3HfCz5TmlZkyb+jmD2bPUNpC2ep0qC+HnB?=
 =?us-ascii?Q?EIPR7HqdqQPCxOT9yLV+p5tlaCyRtlEFAVjABa4eMFlEA4MnkJb1HfsA/rVz?=
 =?us-ascii?Q?ZoVuoevk/4lCslgLSPNvclFIm1E5GmhL0lGPrjAczXq4YS31f0D+8SsehbkX?=
 =?us-ascii?Q?E0e/37gkz08ulWh+gl6YX0u7arn0GbwOP/ilPMz/p59xY+dPi2Jv9jldYsxB?=
 =?us-ascii?Q?iZT0/MkpbR6PBDrOkN0+fL7GhDXAw2w5U3nVbIgIU5D35paINlOt4C1Bsr4+?=
 =?us-ascii?Q?VGJgiI/D9ZLgWnU39pCe4anTvfqZsr/TNbHfZHM4B8MZGoGSr/I7nnRze7Yc?=
 =?us-ascii?Q?f07cfyRORSAHalo+AURCNJgepDCatYe75pyTM1vzqKOwWQLlhys0sM8VsnEx?=
 =?us-ascii?Q?Ai3F/xdZkcjbH6aQ8QcaxarPGDmnM6PpowD8fQCErmqmR0/ADzrPZ89Tv6tN?=
 =?us-ascii?Q?IXRbAig5HwkqpMxb4HMFCkMB3tYjh/aCiDujmO7X78CbSBz+FGX+UK4WaO0E?=
 =?us-ascii?Q?Y/SdbldYEI7G0zosWFzSfc2LhpwOcw5vaTAc0A7QXMh1XfzeUFhZ6hjaf9Rx?=
 =?us-ascii?Q?iWk15oVeVBAavm1QmSTXoqm6FEdDy1ubbgEWvsUbEZkJ96aeC4MJWGsauIun?=
 =?us-ascii?Q?8jXMY4zmlJFaGf5qse+Wb6kbIrKiJYbGaQRaQispkNoYQbQVA5gHGPedGHru?=
 =?us-ascii?Q?+n8D2XhW8n6o+p0G1KxasZmRqi1Zqq26ARhG8nYg1xtqQttLLw16U+bnhdF8?=
 =?us-ascii?Q?yQYhJ7Dd5iIkWZ81k0Wy97P4FodGbOi6Jw1IjJoCJYcdoeDe3INFisKGCUXM?=
 =?us-ascii?Q?A+sI9cf2GG2kMifmIlyEFgR1JpKWp6rAnJNmU8GUCh9u9kDaSsqY9kgHAPNM?=
 =?us-ascii?Q?QpUAReqG2DccMuSzWhjoAugsneQffW+m/XBZO8g6yIGiftPDr5vKvNv7m/6K?=
 =?us-ascii?Q?05w/+ALPO4aT0IxN+3WUYSFSOKOu0d/+lyhIrXlM6gxpzSZpk7mohVsLvDuI?=
 =?us-ascii?Q?qonPe8oIBdlxtgL1in2YY0L8fuGhvBmBi4AptmY7nTGE8VQ27CVZV0ne+Hdv?=
 =?us-ascii?Q?CzTK9fsZI86tJAcj4i05ncu4TPmV3SlGruUd2H6CUfNoQFFC/T6hi1ttAFen?=
 =?us-ascii?Q?6dxWVhGmSQw5IpqAcQIP8AiD2ECeCnk5V7GfPw6P+k0HSQ2YccV4Fqj5HwdI?=
 =?us-ascii?Q?VNjJPaq8VgiedNY86QA3BIFS7QqG6mvqg0UxnDBaxv8nfunbFyA5EJlBSFQo?=
 =?us-ascii?Q?ACOdgtZBAu5Ezv9SR9x0OxI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b6234cd4-ad6d-4482-7682-08dd13ee5f10
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:01:07.5950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+iRFXqgLyx4L0U7Svdbb13cFUaHgrLR8YGVdZx8trcHBITCqopJQY09aYkhQRdGoMVLUis7SBGxE0I9kBxYWbsWXZiZ/PZk5jjxMthlJ8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7611
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 66 +++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 3268989b3f9..637537e956e 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -563,10 +563,33 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
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
@@ -576,55 +599,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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

