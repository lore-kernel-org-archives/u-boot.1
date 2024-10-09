Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA236CF044A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E95D891D5;
	Wed,  9 Oct 2024 12:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hmEe0ct1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066B8891CC; Wed,  9 Oct 2024 12:51:18 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229C4891C4
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRar/J5M/DLCnDlgy8dIFBXnU7ywb0ZySAmsQqIUxIuOh75ECJVkn+gzgDZjZxid7hthvh8gjbJaeP5j5iEyRBF/4G+HBkQtfOII+ZPF7nLlUC90OuocL5sk9n8dg01WNshSaWhQzW/nLkn+WCqF727f+Ebi/sP5ZAKnwb9z7eEsdTvM64ob8lbBb6Fby+biHRzgvtmJ3MxECNYXLaiE55ZFWVzDG0H4mBLM64QrjwbDA3uNKVyJ9fFRdhb3Tag9biqWe2bwOWWg+FMJHkiLvibsgA97NcDIqAc1MEJNPt6eiui/fLoeeKxpBwDnTuZqNKpRZWoQN7RiDDjlUh/PaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=xC2Q3LV09Fz7E47A9z77FyXtpP/oaheGA2npdB7QGhio6PsGRcsNPeQHSDX5SKzyPtZcfO1Y/dXaH2wHziZa4XaaWrCWyzyrqkjYe82LO9bWr1IPeN7bVGq2llCWF7c9cJ0rhAHXQBaeGNLTqqyM+0pxLrKTQykgsOHXmxRh2wlMuLVqgGX70WOvoVJAaI/qGtRX9XBTlUSwgAs9cMsnv3aqbL5OkULhkCglSyFWZFvKb4ZZVlTTFiNEaC7hrNKFvGuwClOZCwDxzws9oPcRFji2S/E4WnweQ6wFUp7vGoOULHM1CNjT46cQFzGqIpmM4yk/wHhRZWuzcctd5psDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=hmEe0ct1lGs4hodtGINfqCfZ4lIWDSU/K1u4OmWU/Bg8vghLXIAm4cCz56d1Ue4wPKHM6EOQlyJYBEL+uSTtY92mKF1LkKYQ3RMn7FLcVDNNJOhkgSQmP5KN/ptBvHGuT05+0p9x+CTVz1jt+phNPZEaRBNbbYAiev/yvlHm4FWbxH/ddcm7I8KD+rsaJ/ylJFj04ejJ8hDaXKiS4XQqvmdr6NKKp3aJBtx9un/kVLq+6ZPZBl2D09s5u2I/v7LN9rIea7ZFN26u2enQbq1RDLnHQfD/kgV2rUu2TAlFjHJ7UCyXGsqiCY2JShe3IKi3a0GSJwAGc4cY5gZWdQz2eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB10543.eurprd08.prod.outlook.com (2603:10a6:150:15b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 10:51:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:13 +0000
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
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 07/13] test/cmd/wget: fix the test
Date: Wed,  9 Oct 2024 13:50:48 +0300
Message-ID: <20241009105054.1879054-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e87632-c3b3-48f9-41b9-08dce8504adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HZ4YMYUp/2LNh2fNJ9RqAy0r2XGGYjkCT0dn929eTPVzSRSst04wlLJvolhm?=
 =?us-ascii?Q?7qt2dqunVPu2ca9IuT97IwisEs4Xg6BSOpJqeJQtzqy93tqBaISpLHm2zp8j?=
 =?us-ascii?Q?ke0raCYQgpIs+lhGEvSQzC28RrtQsosomZuZ84opmHnrfy1ZIiFz7w6RSQFB?=
 =?us-ascii?Q?utovnqURdE2MeI6r9hslmRQyFkXI3I1obavG24NNBqp3BIjlQ91FGIgha1ir?=
 =?us-ascii?Q?wxgNX8KIM44bFQuh6WgpbNUicp6ZrG/WsstkWBONLFKNHi0gFBPvMGI+PTo1?=
 =?us-ascii?Q?Zj9YQ3Euql3kAeDrIP9UE9jg1kt3eex6G8EcqLAp9tZMhCLBuK5Gaz0cgwNn?=
 =?us-ascii?Q?t5W5vfr7cO10sZh+rZzx16M8o7Kv5tTMhZYrzMJGmRoBlkPyzkG9ssXjIEsI?=
 =?us-ascii?Q?YsW14AbO4VTKf2ppbzxwE3Xj86IbKZ4BeYg+dqMbm1k78w77CgFSl5EVLdRx?=
 =?us-ascii?Q?TsBOBtjyEyBkCwPlfO0PBuxEDfPhppndtmr4DVxkHgxFL9gyixiTH/Uk6myo?=
 =?us-ascii?Q?vy8VSUO8xav2pYbQvAF3ri32LuPMmtn0ByfrZJca95bSO4WSeR1AUrtFqf9Y?=
 =?us-ascii?Q?xmWItmltZHScB2wWykM1P2LpmHJ6v9OY7Nq+TcaREza896NZv4Sh1qPg5/Qj?=
 =?us-ascii?Q?GXakCoBYUtfC7CYFkCHYgWY+jGGU5qoU9OHZq0EJuKgNN0Oew/VkkMgM7x/0?=
 =?us-ascii?Q?wO/HcArzklb2Ucdolaxcp+9xGr3lW8MEBgd0GBZ7QVx5dTLqWoDfc2u1xb8w?=
 =?us-ascii?Q?X6Q/NHQlKXZCwjubdqBdYtp6p0/JzN0mgMy8rWH7LULrxusYnT9kjNZhyhYj?=
 =?us-ascii?Q?Zc/X+q9CwDHSMqFPmk5WolgDWX48yDKDHupj1pnKTU/xhrK8+xgJLgMCYNUj?=
 =?us-ascii?Q?kb2cUFmLv6Grr9rFdfxCXEmc1MsNI099lxYOkRRLtoawc7icAjdzEzC/Nd3l?=
 =?us-ascii?Q?vrTLZRY/VtHhhT1SAUFgt3uskoF9S7nPDI3cXAM8eRw2p07cFivIL9E5leip?=
 =?us-ascii?Q?fMJ3Zs4Shq95swG6Lvma/oy4QRrDlQSHj+iT3OFhY32NjAoTHgLldw8gq5um?=
 =?us-ascii?Q?VvS0eFf7b3RAbeBvmAHTFXgLO89nBoDbcZVCPaeAO2JmfTKyTAEFMG36lSto?=
 =?us-ascii?Q?civB6e6+GUESggHRM5g2hHsHagBJ7qmoZYBl8o2D6XCPRKjPgVvP935jy3ou?=
 =?us-ascii?Q?2V0PZs4YKLdL1MOCQ8X4y6XznjmGMnfrxq77SxITh9C8mXWhRlSFiF6jDVjW?=
 =?us-ascii?Q?qtB3gMBdjVGHj35p/pjUuajsYkr7AQdgxfktxqnStr2Memfr6r3EOLqse0Tc?=
 =?us-ascii?Q?7ZQn7xFGaz6Ga/eACMDqShfnYHZhQPV/59jIPvAg69KjDaJrWUD4c5YGSUbj?=
 =?us-ascii?Q?SqPA3u8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wc2plpZyHQ4wZxsrttOBxdmxNMFecafxTdCjClw8wkprv46aLZyFYYSLVuoa?=
 =?us-ascii?Q?Vb/RH2CrLoBkhNkAMkbmHECgTpB74MIGn9x4E//LntfUMjso3ZGHqaqRloPI?=
 =?us-ascii?Q?e+y8BNAX4sk+GDXbMdoRuH8q/OY1QkqoIDgSFKfYFzgMs0aekC4kmWLRgDWF?=
 =?us-ascii?Q?Yks7I5fsaeCeKH/R/DzYsQXvpKTNaEiIUOtJMKGfuoDVkNUrhneVdAr4kYEj?=
 =?us-ascii?Q?bq9rlFU4OWAZE2qztI9Fz9VFO72v/hC77VHswc6oN4OjvSG/qDWX1v+e1x91?=
 =?us-ascii?Q?Qo6g89wxZKBTLdB9EQytdOf9fxQXVZCVOn4xai+auvfUpqXwIyICxTOOAQiN?=
 =?us-ascii?Q?LdmVe2BqirswUqgEs27AmnLfC0aFt9YsKV1lzlH1QAEs0BzSTLe+uItQdeQ4?=
 =?us-ascii?Q?2QnbRP0s3x5p4VyD9+lKWaBH7PQRnS1w+dbx5IiHtcgPGTb0Jd9SR4OlQKjr?=
 =?us-ascii?Q?sTisUV8UqeyM9oIC3Cz4hBgM0jywHwo1In6Czi3GIudX2ik2+2izoBY7Sjmx?=
 =?us-ascii?Q?OokhH2Zmg0ou9a/nhN0KPggTb9ebLxQ68t0niVPbx58LpUZqdTF2OmIGQ9cp?=
 =?us-ascii?Q?tmAMm1Dl5joBubh702xFMh8/DTWTj+bS88P7zy25+16wxIB6dRO0oelnJvNa?=
 =?us-ascii?Q?RLtB3nzGHyQAmWAM2nnMrCx/7pNReERWGZUWQVGCFfdiAOnKljnrD5hb8sY2?=
 =?us-ascii?Q?FYZwpdrc1lcLC8mxJ4tFCvILaEa4QyTtfVZmj2ONefRJLU1QDBtOsCxS4RYP?=
 =?us-ascii?Q?piP331+OEyWdexSAf/6uROqDmGiRecTcAKQHtVeEwWXf8PxwUM81tHJx/E6Y?=
 =?us-ascii?Q?UV7TSnoscp5iO4uNagt9BPzapGnaj5mT+znr4WfT9FrMZtfVuHXLEg7w47O9?=
 =?us-ascii?Q?quCf4MPElY9r6Zzv4YsjhxUq6cH2PGwzDLQDrmBKuIx2CVhndmy7vzfHTuGj?=
 =?us-ascii?Q?w/ioGer+hN5x66oxaVJ0odL07ToEaMhP76bmhvQ11m+1/e45phWfIpEpRsRr?=
 =?us-ascii?Q?ktrFWPrDyuevGZKckoW8c7MTHRdKef/ll3DPcO3PX+GSUcFg32NkWSRgs69H?=
 =?us-ascii?Q?whT5hhp+IG4eULCBPp2DD8D3FMAVjB3WpNV2rOO/Mr+fBdaYs8R0ncG8ySC1?=
 =?us-ascii?Q?J/sZ9EP647LxQrs8isPhiORtfdFPwSQdYsn1nRPczrWlRgk5mbpbJ+GveXox?=
 =?us-ascii?Q?n7FsxLJscu3P3PasXUNAqcMsaFmG44heTCkUsNzg0wW3p5bejLnoeRKD/Gxr?=
 =?us-ascii?Q?XkDAaGj4Dto9VBFMutgv40/YPs/tYXxMtoGHwz1HQeyDOgsbIfgTnyMynUZd?=
 =?us-ascii?Q?OXyH5v/Yjl5W4ydNIsmq3SrB95sYOvV9qZRZFmHVELyHZ1oh/UqgUvkDDJJG?=
 =?us-ascii?Q?2RI5q5MjtuGw5jqM278KxrSHeRCx+T/oJhTL4UlHYYR1XeO8AH3xky+x/kCc?=
 =?us-ascii?Q?mBpQTXVkh7G6snPIWgxA0RGACx7WJrRINpLQv4wINmsMx89TBou9UVe9K+3W?=
 =?us-ascii?Q?qJHunrlmhmHJeYfr3s+LnEgkKop/K1p1cOpCgDLoo1WTL/EFlPmWzpsd7TTK?=
 =?us-ascii?Q?QD3k5Z3xUxDN0yJwvAXlf1VZ07Wc8Ma+bhETxw9uIWP30cMtg/IyqMl9JHjt?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e87632-c3b3-48f9-41b9-08dce8504adc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:13.2321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFcQ+0acCmPD/1UtooGJFVfL6b0qdks9IeKXTOyyuoL2FmVBOgRiMXI2G/D50JSOdqh0mSn4jSy4M/JVOHlP9SR1Dx4BzYfwlR9cLPpA4F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10543
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
 * update to new tcp stack
 * fix zero values for ISS and IRS issue (see RFC 9293)

Previously this patch also fix incorrect values for tcp_ack & tcp_seq,
but the issue was fixed in
 * dbb6b5a: sandbox: fix wget test failure after fixing wget issue

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/eth.h |  4 +++
 test/cmd/wget.c                | 58 ++++++++++++++++------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

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
index fe26fee54c9..a90ca4fad8c 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -25,8 +25,7 @@
 
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)
-
-int net_set_ack_options(union tcp_build_pkt *b);
+#define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
 
 static int sb_arp_handler(struct udevice *dev, void *packet,
 			  unsigned int len)
@@ -64,12 +63,14 @@ static int sb_syn_handler(struct udevice *dev, void *packet,
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
@@ -104,13 +105,11 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	void *data;
 	int pkt_len;
 	int payload_len = 0;
+	u32 tcp_seq, tcp_ack;
+	int tcp_data_len;
 	const char *payload1 = "HTTP/1.1 200 OK\r\n"
 		"Content-Length: 30\r\n\r\n\r\n"
 		"<html><body>Hi</body></html>\r\n";
-	union tcp_build_pkt *b = (union tcp_build_pkt *)tcp;
-	const int recv_payload_len = len - net_set_ack_options(b) - IP_HDR_SIZE - ETHER_HDR_SIZE;
-	static int next_seq;
-	const int bottom_payload_len = 10;
 
 	/* Don't allow the buffer to overrun */
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -125,35 +124,32 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	tcp_send->tcp_dst = tcp->tcp_src;
 	data = (void *)tcp_send + IP_TCP_HDR_SIZE;
 
-	if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1 && recv_payload_len == 0) {
-		// ignore ACK for three-way handshaking
-		return 0;
-	} else if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1) {
-		// recv HTTP request message and reply top half data
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+	tcp_seq = ntohl(tcp->tcp_seq) - priv->irs;
+	tcp_ack = ntohl(tcp->tcp_ack) - priv->iss;
+	tcp_data_len = len - ETHER_HDR_SIZE - IP_HDR_SIZE - GET_TCP_HDR_LEN_IN_BYTES(tcp->tcp_hlen);
 
-		payload_len = strlen(payload1) - bottom_payload_len;
-		memcpy(data, payload1, payload_len);
-		tcp_send->tcp_flags = TCP_ACK;
+	if (tcp->tcp_flags & TCP_FIN)
+	    tcp_data_len++;
 
-		next_seq = ntohl(tcp_send->tcp_seq) + payload_len;
-	} else if (ntohl(tcp->tcp_ack) == next_seq) {
-		// reply bottom half data
-		const int top_payload_len = strlen(payload1) - bottom_payload_len;
+	tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
+	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + tcp_data_len);
 
-		tcp_send->tcp_seq = htonl(next_seq);
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+	if (tcp_seq == 1 && tcp_ack == 1) {
+		if (tcp_data_len == 0) {
+			/* no data, wait for GET request */
+			return -1;
+		}
 
-		payload_len = bottom_payload_len;
-		memcpy(data, payload1 + top_payload_len, payload_len);
+		/* reply to GET request */
+		payload_len = strlen(payload1);
+		memcpy(data, payload1, payload_len);
 		tcp_send->tcp_flags = TCP_ACK;
-	} else {
-		// close connection
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
@@ -214,6 +210,8 @@ static int net_test_wget(struct unit_test_state *uts)
 	env_set("loadaddr", "0x20000");
 	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
 	ut_assert_nextline("HTTP/1.1 200 OK");
+	ut_assert_nextline("Content-Length: 30");
+	ut_assert_nextline("");
 	ut_assert_nextline("Packets received 5, Transfer Successful");
 	ut_assert_nextline("Bytes transferred = 32 (20 hex)");
 
-- 
2.45.2

