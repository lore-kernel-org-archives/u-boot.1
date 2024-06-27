Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715E5C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D32C88605;
	Thu, 27 Jun 2024 13:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1PiMXCWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A7588605; Thu, 27 Jun 2024 13:40:07 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E257885D4
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjLc564lKi+f4rcJwZLUQ5A9zkNN/r4/BdxTPhXsMFCGAlUceQ9/I24i2s/fbHeQ1qgtDPeKZDiSi7DsIsc6Gub9O664+QN8p0aeiMCUWVbffZTzjeyuw2wSzHebfPax8tol+XIZ4PS/ice2duc7+Kadsbik3fQcJC9p719RUNASCo4VEORpEVoBk3u7I+QeGFKoijslaefH3bp2RuECjrFUWeYnpDlr5qjsD1o4BqIDtWNuNVDhcKy8wOODeBk7qAo7GRfOvvFxkq3qdZWbZFMImKy0x1ur4ndPOqCCeAyIaQqNKL65seVHPIHwUl7KchhoHuuagjw7b77yAtWNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgBiX12vd1N27uJkxDfQ3F8Sdu73DZ7eumt1cC6V9LE=;
 b=fwkdKD/cF3f0hlzsH0isCKE/rF4QiIKZaYZNFzJJbugcYzgxu2b/z8YrhPQa1dICpDSMLkcNg8YTULFXmM4ajFy6STIbRXcuGTCol11gn9tu1hJHsfdpsEW8f8E82EzpyCY9NbmRcKmk6unoQFqwGdDrUlEgNyU+EyjounLo6BZBIAK8MQOC+u/8cwjM7Lyy7WOijBpQWfe/s9o9tVlt089RWpuRlDRzz5a6ZK22HBug1sUkV1HfPT4yvJb2/9oxDM9fCI6ETwP802RG5Q7wHFcZ6/lm2F3ef6pzFued1h19Fa/LSXZkCkHCdpCDIs7wNfszfx+Hr2KE73S7gi9dUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgBiX12vd1N27uJkxDfQ3F8Sdu73DZ7eumt1cC6V9LE=;
 b=1PiMXCWxeeH8Yf08QKzdY/X8g8D85L4OKEK+rW0MIlrtaUTjNCzS4swuJoBiwYQls0ZkwYgoIqh7//A4tYvCClN/TZSNvX0vEcCRBggrOc0+HsuEgCtcN1NzgNNPyf7TgGG8NyE1m0/skfpFzqw3Gsohbxha6Cu2qCkx4I8RvgslGqyFfkF59wGG8hT7H8TUfSiaVO9zWTCmNOhZDh//hn00GkJP/1zeToT+3SXwXuxTTCfrN1g8LOYzOFLdaOTn0kXzDP5BqPntleJkhDz7PzoiVHpiECMrmNw2PK0s0eazrsDFqBOqgKBi87jmf1fHMgrDcEPDA3Y1CTS3qMSP7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:40:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:40:01 +0000
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
Subject: [PATCH 10/12] net/tcp: simplify tcp header filling code
Date: Thu, 27 Jun 2024 14:39:37 +0300
Message-ID: <20240627113939.100620-10-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: dd315fe1-935a-460c-29dd-08dc969de17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HxpODs6RyXyHHe2zHZVKPyHGep0ajd0MBXOnju0lXowv4mV3oVNvBQ9+fmEg?=
 =?us-ascii?Q?T+k6rVsiEw+0ZzXhkZcNNxTivxAq71+VcD0PeRMC6Z6RFqV6KMdD17NZoSsY?=
 =?us-ascii?Q?NWza1yqK/CsAYKdH7014Gg/BzzJ5m5lLGaCs6rzVb4OT1nHcz/UlkAQ9wT4X?=
 =?us-ascii?Q?2xmhFN1Fp9bHgHWq6q8eeuX/30H3LRXWTK/bEHCHgr9JnKhS97IVJsMga0sz?=
 =?us-ascii?Q?5MuQKwOwTlXqaBLP3A9mtpvF2c+EwjxkmEAf+80qQ3xQNKOpMaQ08YXLmfDI?=
 =?us-ascii?Q?dhQLnic/ej+p8ogbKjBeyZEnwylPf3qMmvLw0+rx03iMBHMvXEd6RggxpOKi?=
 =?us-ascii?Q?W418IK3s4v9wWkU9BrOKWvB5oEuUcWrha9nMVy+xMni7lJJ444l2KXH7bG8k?=
 =?us-ascii?Q?SjmTv/38Kldn6NOi08v2o98bzjEAYW5EQguSwUV5RRWheB8rPVErRck2aSYJ?=
 =?us-ascii?Q?PXvvBaKX6G3H9f2EKBDM/TJcTS05y3SjlFY9USJvUhwWtqM65GUayLfqFVOA?=
 =?us-ascii?Q?cmYNVaslV+/4OrtuGQU8BsxDYMS1lWNIfxap3y30wblOy1z86nAW+/9kuvcP?=
 =?us-ascii?Q?+yy6quCIYA132B8Xorrd594gZdg/q2K5BmNvkppZukZ5IHdP1gJ26yN2PxFT?=
 =?us-ascii?Q?fw1hzQxdhiLd2FHmSv5d8ajCTzreyEJHW5F4+OzosUCtnbAYXxW4HWN0kG/b?=
 =?us-ascii?Q?Uvh4QD87pi9fG2MDUbJJbwJjFcTxUEtEXuaDS7DyvZbYjWD7FBclkeSLnVVA?=
 =?us-ascii?Q?PkxJjz8fVgVXa4bx1rN6+AwC2IfjR4TYzkdAriBS0+dcZLnMVmkXzv8F/D9A?=
 =?us-ascii?Q?emrAN2+m/Zn9yRXwg471HrFgRhNEyaRmFAcvQNwssHLkiHSC0/xfOmruqVKb?=
 =?us-ascii?Q?baSSpyT8BvdOvsAWpWYyLuWa6ltpjd1kd1ot1Sld0ecWhv9AuHzag9wv634k?=
 =?us-ascii?Q?XCl73ZZcFKA7b7om4YdyErFXgif1auA2pQEAu6yEpauYWvjoEOeKF1YAK8vv?=
 =?us-ascii?Q?9N1rd875BJhuDFjOOexQsND03d5574rHF8ejzYyRo1Za5RRn2lP7HvVFd0wr?=
 =?us-ascii?Q?nRkCx2ejwGUDSttCSRgEq9yWCjQEF3rbW173o4jbPSTUuML1aMR90vfxaX4A?=
 =?us-ascii?Q?J4g7zgUrIIapWQU+FjQ69SREGw/UocItng1JVbPQ8o9ZoWo5XPCaZ+Oa/cKV?=
 =?us-ascii?Q?pth8bsmbtjlliM3HCpLcDxY3u8Ibow7CMh33pdLpKmK3Vi1c9kPRnqdAMIOz?=
 =?us-ascii?Q?R5OF5XQHhKHQhcMPvplUc6OjZLiTHZrgbgKJb/Tvf6I9GRBKy6b/dZttRdAX?=
 =?us-ascii?Q?I7dcy36At9AzZzZ8JaVHAu+zQBJdMXS6passDh+MTnWg6MC6XnxKFkx9Kno6?=
 =?us-ascii?Q?xtwYa6lNBkJje8b3B3MhOqUcjcoRb1NKMy3kcMKXmD5KbKtyHgoqdUAugW/K?=
 =?us-ascii?Q?RpAnpDiLK6A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8nSrgDv45VC6tYWKLPNbIc0QEw0hN7Oe/4Ptg2tbchgEaEck7nMa2jZ5SfzV?=
 =?us-ascii?Q?G0AaH2GLzDioBhNa7k30+sZpNya8cPB2qCkUHTji9hbENI4Mln/a53DJ/gUS?=
 =?us-ascii?Q?j9Q0/HCMDnMQrxwQ/zel6TTbSAzj0mDYXQ1To4k7Rn8U8RJyJoZk2vKjJIq0?=
 =?us-ascii?Q?lTQR4ADoSIWi7Qrb6jIS2RLv9XUBgULBAmm1b863AcvN9WcymrRbsB/SNvoz?=
 =?us-ascii?Q?nRaioKuSLtSsTXdmr4uDC9l1vq1V4/lboKEDtmyt7uY0HFmOrOX8JYrdmnLA?=
 =?us-ascii?Q?0mbAzX3bOThyKLHh1Wmd4wkdNM0JAZtxC+Cv97/IAHCvpazKaSHoV9btmADJ?=
 =?us-ascii?Q?JNDpwoSmPtTuL8aQmJXs/605ms+kt2aNM5iEL07258KlOEiLVvglmx1q6LSd?=
 =?us-ascii?Q?/dn6XLlJTvPn8AEQ2AnyL0ebzQOMwIzrv1tKqYgeDUpL64vlLkcFx+IOXNJ4?=
 =?us-ascii?Q?ZQ6wjCs86lorHwTrLpenED98YLIs2E+uWCa8TZ8DtXxQk85E2Yt+qZT2APBv?=
 =?us-ascii?Q?i/0pDyDFTbsVlW6/jQLo+5TO5PmFGr1l6trDPsOhiy0+BXIyZ7p4KdmlN7o7?=
 =?us-ascii?Q?+7+5NyIa7b9iPMkXCTL0azauDqa6J7e10337yY9kgvtROb7GwBLuvYTrhiki?=
 =?us-ascii?Q?R7xbsohVvrzYeuxiRqigfWlWykW1qLT4DprnzHqIVCVRjXVwM6tCQ1NS3wme?=
 =?us-ascii?Q?qotX7tvmr6qwcW8dCRR3FzLgTyuamN+B8LzfR3Ag/DxRZ75ApSmL32wBAIWt?=
 =?us-ascii?Q?lGZTpSBPch6MbIZ9TlKm+ISiknqn3h7zjw6j2CStVEP2lxPi6kl5EboC6AQR?=
 =?us-ascii?Q?3Oo1Z6Sp/KUwUltm/SjN/Fki+UrdcZKswbRSOb/NjAYKgnt7O8pnDum3J2vP?=
 =?us-ascii?Q?oC1ak5s7/902YbtrhnRiLhaW538B9yTkenp4J6rZa594L+mW67lwysusIx3i?=
 =?us-ascii?Q?2ul62BpZrE27LVSt/LS30KAVLqjC1kagVcB6CgPyhgMbH5OoM10SwEh3l8pL?=
 =?us-ascii?Q?yVkKdZgolUTI2fRsS0GYE5blmBC4CwYYA83wSj6gkpujj/cvN4/HK5gjlzp3?=
 =?us-ascii?Q?9OJPvUKSf6mSPCtSrjunLxrCPVZg+czaeP0agwZdk9rJqONHyWgbofImWmfp?=
 =?us-ascii?Q?yFGgEgKYH/41Oana/VQa02lG1kUV69+cV3D3qylrdVSFB8WmB9DUCbkosJL6?=
 =?us-ascii?Q?aLY5MqAlC00Rci6alYtIJOFNdX+JKyOzS2EQqRkK4mhJWGS6GXZApRR1KEze?=
 =?us-ascii?Q?x3L4eOA02AxPVxhJvqjwrTlCsr/tGwKtArqHyMysEQf/6Ys13ZpF3KhbD/7M?=
 =?us-ascii?Q?RuSGP0r2psddZQC/hyrQUJe5kiYIdVgCdd7w+tTuka50ztgg8iDeSh1wz3V+?=
 =?us-ascii?Q?tLLmn+wojZpkOvOnX+u8vusd8OLhnpJ6lh3EXamWnwEyEporDwRkLiaXDKVY?=
 =?us-ascii?Q?+bbnQ+cWAnf1rlitzpnZcE5dlZVwkJzGG+lzlnCUzRlE9coXvDHDj33iN1c1?=
 =?us-ascii?Q?C5Mr8WSz+51FPexCmEtt3rLPsZNBFwsTwHZtJIDz7+M15U1sWCme63ovldvh?=
 =?us-ascii?Q?BhoKNRZWgnqGXk4TkjHuz2iz+nwF0t6YRm9ONj6HCECnxfQ1gbRqoJEXEvGt?=
 =?us-ascii?Q?GNFWOs+hZs61yAqopGIikLc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dd315fe1-935a-460c-29dd-08dc969de17d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:40:01.8398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQhhiz6mTK8o1i/0hB6LbS6yGmo97/TIE/jTMs/jeThQbl3/ZyyDp3pi90wvaIlnvEQI6z52ynb1lIPq1km2SBs2/1LS142+g69Tkosvp2c=
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 70 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index a5689a892b2..9fb80f9c2a8 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -528,10 +528,37 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
+const char *tcpflags_to_str(char tcpflags, char *buf, int size)
+{
+	int i = 0, len;
+	char *orig = buf;
+	const struct {
+		int		bit;
+		const char	*name;
+	} desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
+		    {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
+
+	*orig = '\0';
+	while (desc[i].name != NULL) {
+		len = strlen(desc[i].name);
+		if (size <= len + 1)
+			break;
+		if (buf != orig) {
+			*buf++ = ',';
+			size--;
+		}
+		strcpy(buf, desc[i].name);
+		buf += len;
+		size -= len;
+	}
+	return orig;
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
@@ -541,55 +568,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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
2.43.0

