Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7E8C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9066088582;
	Thu, 27 Jun 2024 13:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pa92WUdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE11D885CC; Thu, 27 Jun 2024 13:39:54 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033CC885D4
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd4BQ7eSG5QWof0xnonzaLCNcfKhaGa51AZIZ6KXC9tG4QGOOx4WvUs2CGI0wNT28VSwGVuAp70B+IbGhMCtzrCQARpNUpYfRx4tJ8p802GHzJx1iromKUmWb00sua4YS5Wf3LHMSQlIv80MD72A/r5QoO1pF5rNe/6wkOIKhwHOyJgSv25u/X8PvKjtwDIKO6dtwHJa055NjwMNPdEkc6+ErzCd6kFB+6SzKFu0i0yDm9wRWj+6OzqhCxdr+Lw0iHnu79ZCMybsFIogFsCJNNKZcfjHAkdBWue+oQSwjO/uO7dyTxbuymAVHJx12lzM7B9xYfwLUkJJ0HwkCJfu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9mixrsFSVSkB8hOUJO2kKNC/w62S8gMTBZbl/yLX8g=;
 b=UOaJU+8ZpM4iPB3Lxi8BjDu48eHCPfm3Y1MLUr1fvsXvWSuJbgBVneJfJA825XCLe9PdRHzdaBlIfIIJ4PUpa1JQv413RNxdNI2QvMGxGD/gsttqWIFR+y+RnkvhaB2GR7VyzLWp+Kv57Gpc6Is60VB6OZxWRchjKIseI/KtW8ZPmJWgnfXZgfNs/SuWrJN90P85M9dusc1MYQtL8+nUZtOo8NRhz9mEKZz9smp3CH2ciEN2YhQcrvj72m+/+5rStD3Y8FlC9aM8YQljRmtQFtSI5H6aNVdrbFaRaLMC775dkRiTtHIsGbU1lLDAQgyKTAhmC7c5j3KJGrW0mLX7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9mixrsFSVSkB8hOUJO2kKNC/w62S8gMTBZbl/yLX8g=;
 b=pa92WUdqnJalKKb2kLGK1aVndUhc55MsEyco+oGH2sQ5v6p72n2sfLwIhjkP27zJWHTQMChCX2EcRz214eH95Pnql2NyJCEEq10KKvSREe6wIx3wu4Vl/ab3U7vYcBOcoP7sutIM+B4FQ9bckSIYYocrDDHYT6p3ES1nYk98DWnSM4tX3lDcKr4hfGV56iUpt4sZ1FYeBlui+sfgrDdskh2uNk25FO2WVW1elpf1A3JBXBDn7y2IXjPrUpsc8HLEHYKsJPCgevXrjxQvuWumXhQpYTsay8GBL8LqItk05QFG02yk3PXHUlspfUEniBFXmS2pkXIFRq+8/zfVR8qqow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:39:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:39:48 +0000
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
Subject: [PATCH 02/12] net/tcp: fix selective acknowledge
Date: Thu, 27 Jun 2024 14:39:29 +0300
Message-ID: <20240627113939.100620-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a984a6d9-60fe-4cfb-bf13-08dc969dd9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?215HJ+47MBv6S3Xhn0q4vGo5ck9hRTWwtFuLkwb+M2lB+Q7U324pzo4ad6uk?=
 =?us-ascii?Q?+RhyKTokTq944/SxAoYVRodkWtbeeEZYlp9CQdpt1Vq9SiBsx6FyZriaxKcz?=
 =?us-ascii?Q?Ee79BzfhlQhHrl+dQDwsX10Rm394Om/Pk+PkClLxJM17Y/YeV/rKHQmwqgyT?=
 =?us-ascii?Q?8tuSoHlY79rlDcpHwl4BCoQyTRqJKTJqCtwZckgWSYz2OdWCWnHTnrj6iei8?=
 =?us-ascii?Q?Vd3cD+YYxag9QLSI5UKX9wlxAcEikBaGU5hoGdKgOust/OIHoqq7TCK3Yjpm?=
 =?us-ascii?Q?K9EfBZwLJ5WUu8sqeFgBJB5Zpxgc68AhQq0wuLd3FKQjOCUXOfrHbasTVQBB?=
 =?us-ascii?Q?rb6Ij77xUC4L4KVKM3zLwa/FiOrfVf3sYHJ9KDNxf0yWzjiAjT410do6hCPr?=
 =?us-ascii?Q?4n7OEH//9OGaFReup3YwYBT0BfK4BL4pXpX4rGTJgmH9W9mnd0nTwYU0zVVb?=
 =?us-ascii?Q?IzG/idUQfRMczeey5tzJeLmCox3Iikk4HLrZH9pGjiiA8Kl9Gj9PCdUKPtM+?=
 =?us-ascii?Q?aFIbuYCRbx5y+hNN4ShP3qIgcFi8T3YiwJY0hJxAucq0ktqON9u/eiUgi1JD?=
 =?us-ascii?Q?r/LIuKQt2Iz9cHEI1D6JcCEUkYKniYR8xYJALc4RdqO743j+sSxEFzuMy3ov?=
 =?us-ascii?Q?Am2nlEhhjvSdv+50UdrG9TOdvRGpruY9ephydCh2zsylvYlt5TDWhMyOUxJu?=
 =?us-ascii?Q?9zt3DGvgp3bbu61BrtLrXnqU1PK056QZE0VvfsGZgNXI6k55PWXtAMDp44jx?=
 =?us-ascii?Q?cpAjrYpjdX4fhf7qaaexdrCYd4/v02Csx27paRTDcw2SUcxpTaEw1knLXlVc?=
 =?us-ascii?Q?UnQz1h9qQW6Crk/rT0+TZDBwVHu4vDcfcDCpN87oiq90TeteDKrl9AAa6+8P?=
 =?us-ascii?Q?whvY15ZG/8RnYlUnb8w2FxEKXLlAjW9YHn4Ifb77Ymzxn+vDYjEsTTOzWDfh?=
 =?us-ascii?Q?Lm1B6vyzdxTrxMo7NuSVbS9UJjIFOG0v82oVv8JYlEug8SRBUWBoKl8q8zxm?=
 =?us-ascii?Q?1/W2h8a23P3XcaSQC8UB2rk4dsC4XsBC3gWzupq8Am7L50QoEDEgHTZsD3Jv?=
 =?us-ascii?Q?wfRfr8m8LzxfNs7VlqzK9hAndUIeue82MO9ZcJkN/yJ8rC4qP7i4Eon1rfTN?=
 =?us-ascii?Q?LZkvZzbkUMFhc0R1XbtgMbcgnLJ6AJKH5ouZAtBC4qMN1ijW3NuzBWz3xU9a?=
 =?us-ascii?Q?vP6vGULM7ZxrdhsKFkECaS8vy/LKb0Euz2OE4cF88N9EaHZqc+DqfxanZO0d?=
 =?us-ascii?Q?12uyCNGD2FchCKcntH1EkbD6XuZHre9ojzjJrHiPK4KiLstWUklLjM2APoPV?=
 =?us-ascii?Q?eC04ckhhtAmgffwzpWMtD5xxVf/gQbYboCdzxbEK1z7BPMwM52OTlcL19Hki?=
 =?us-ascii?Q?rPOpVf/t0NKoyCLfQdaWQDr7qcANENXB9iknBRN2mCU9UvxNQY8uiSJbV/0p?=
 =?us-ascii?Q?86zKjBbTtU4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2S8avPMH3KD64K52DyYDeV2wGczzX/ZnqbEnvn7D5X2QKhDdL6tfhX+EfdXr?=
 =?us-ascii?Q?S4W5cOGWpJc0qNh8oaE4ZTnszM8euEAQf8v6V6P2u9vPSu8yMBlSkfaiyBOw?=
 =?us-ascii?Q?I6M4hQgctX6Agx8LYkqjAJAIWwzlqKbAteBOOZRvf6xnu58tmqr4Vvf+woiU?=
 =?us-ascii?Q?ofSPNSOUckg33L5vfoeLMXqfmdkgc9mZndOLDOyApy4N6/rML9wPQ4Qkn1bN?=
 =?us-ascii?Q?pX9G099Bylj+DETDczXsvzlT9D9XFCXpWfUKvdBjp72HLA6QsEFR07YyuJkd?=
 =?us-ascii?Q?wa+qcamGrda90dxXSFs/Q/TksDoWJK51Q4VGxjdapM8kpTs7KOAZLlW4uuDl?=
 =?us-ascii?Q?bzLpgNZWXNTJn5MtHyflTKwBfo3XtoJE4x6ZcZnpkDvZIvMq6HRNZ6qWHpGu?=
 =?us-ascii?Q?GtY48l+VC+PyzMF/xIco6jnQRW5vehc3Xvy6UigBKhkFVIt1AkAOUytGbdhk?=
 =?us-ascii?Q?b/AJzR4aLuWAGXXyvlAbAUoluruehbSdg5rMtrHpGvw26knSgwkexEcQwpML?=
 =?us-ascii?Q?jEg9axcD5UH1okvD1jdmwNF959NnWGKNd9LeELVTIbGaLqzv0aylGAPL2F/9?=
 =?us-ascii?Q?6qcVSUjcjdpIfmdkFfgYxrwIb2g0i1Fr1H+JWCbFNpGS6e/Cy12n0nFWaCrl?=
 =?us-ascii?Q?7LU0ui4q9kLLXMfP3MKkaQaDqKXOWfFQVWBy+YyiBwhzxobiwrVtrSy0iZnC?=
 =?us-ascii?Q?gOicpL4S1aDaRAFWzXNqpljd6w4yuijqVmr/c2QwUGsJpN8RK3KDeX/Trazx?=
 =?us-ascii?Q?v6FkfdGhCu0/Doy8FOGxqS+6BVBEhRjVHKVdDzKyFiOqVqRp7nmJkc6dtslE?=
 =?us-ascii?Q?fvup49HYzbCt0Y4P48HneZTNfsfKnOg12humLTLUUwb2+wQZbR2rnMdWD++w?=
 =?us-ascii?Q?NgvH9rPbwDEYaobryAavRRB0gDzZyncjHAzyzESkUAX8WxijDM9RIk8kFQkN?=
 =?us-ascii?Q?eUMLEOVbNX+gs603olLeTW7s2OuuuEh0sUaQUpR5RkMTtf6gwQtntJsMwhdC?=
 =?us-ascii?Q?i1VaEkRyyUFFnIvY5LXcvSzM6mE3VhfJtBTXXEEAhq2xYXlJ+CIJaB4xKXHt?=
 =?us-ascii?Q?V/VKop7IfkIqHqfmWPrJU8+X1PwY72ZTODZ9cWyAFp2kC/mTUI7AgiRHSUJT?=
 =?us-ascii?Q?h3Q2VHk/lttZykwaFNflmStw2dZ7SHTSqQxhriiR06t0mlC397H+3JxPoozi?=
 =?us-ascii?Q?YVMZ2/m9s2DAjCSYLMiRpgJNXUYrH7ImPbpPOsccebwF8ynDWqiAHaRXMnPT?=
 =?us-ascii?Q?2RSaWRz2wJxu26WvnYkIxfy18W2DgaNtqPM5qA6KZ5PReiY2/rT2dqmVcVP2?=
 =?us-ascii?Q?ScAXduWqvMFjRmmn3+ZkmhEBXPm+SYxpkydNbNrLd2KBjQ6r+3/+oiGkyM1b?=
 =?us-ascii?Q?NYPK7DNIoCCG4IN2tSMpjViHW2bGMxn7X5bqrCc8zAv4IVso88N1M37T3mkB?=
 =?us-ascii?Q?2cdqyEHnXUdvkCnf5sAKR4PwG8QtsDUG3bddsRv5wlfBwNcc/N3tVzkBljdJ?=
 =?us-ascii?Q?W7QifI4VgI4dafYo9Y/c59uefh5qZYrljKda9kpERD5L6iveY9t6S0iWQu+Z?=
 =?us-ascii?Q?iHCPvpgIO6dDhvav6FSJHkG1/i6r19giM6BriOG0AStc1RbyQfzOCe3VGt35?=
 =?us-ascii?Q?3LfaiS4+jd+yY98nKCmpiWs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a984a6d9-60fe-4cfb-bf13-08dc969dd9b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:39:48.7970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8+EJq3CfvE7cEOkshZgnPFHKEh2Rq9fQApNRsBGM8lO2IOovrYdZkjqmqvT0AbFGLpOom21+Jub5ET/jbNzZc8FGPUlkoSoI/pe6PbyV6I=
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

Current code assume that all (except last) packets are of the same size.
This is definitely wrong. Replace SACK code with a new one, that does
not rely on this assumption. Also this code uses less memory.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 200 +++++++++++++++++++++++-------------------------------
 1 file changed, 86 insertions(+), 114 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index c9bcd364ee3..228e1e4872c 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -39,21 +39,6 @@ static u32 tcp_ack_edge;
 
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
@@ -70,6 +55,11 @@ static enum tcp_state current_tcp_state;
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
@@ -268,6 +258,7 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
 			action = TCP_FIN;
 			current_tcp_state = TCP_FIN_WAIT_1;
 		} else {
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_SENT;
 		}
 		break;
@@ -354,6 +345,20 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
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
@@ -361,106 +366,79 @@ int tcp_set_tcp_header(uchar *pkt, int dport, int sport, int payload_len,
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
@@ -510,7 +488,6 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 	u8 tcp_push = tcp_flags & TCP_PUSH;
 	u8 tcp_ack = tcp_flags & TCP_ACK;
 	u8 action = TCP_DATA;
-	int i;
 
 	/*
 	 * tcp_flags are examined to determine TX action in a given state
@@ -537,6 +514,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
 			action = TCP_SYN | TCP_ACK;
 			tcp_seq_init = tcp_seq_num;
 			tcp_ack_edge = tcp_seq_num + 1;
+			tcp_lost.len = TCP_OPT_LEN_2;
 			current_tcp_state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
 			action = TCP_DATA;
@@ -553,13 +531,7 @@ static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int payload_len)
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
2.43.0

