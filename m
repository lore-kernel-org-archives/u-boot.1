Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F6EE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919A189697;
	Wed,  4 Dec 2024 00:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="riHJpMpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F2B89686; Wed,  4 Dec 2024 00:01:10 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C523C89698
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j52+rKPx98/5a69o4+sA5DOLN82eXG9VqklSFBpXM64PMgVifKmyGTfoOHT/8mYaYloppS7+WfPPVveA+u7HHyn7BgMnehmJVkqMCzo1WpQMIMm2K9bMMHdV/leLNvx4FlaC2Z7BDVuO34k2LDu77goTrjBuFQT5MNKnpZrTSbYkyIINK1J0UmqAZ6PBgvJQIrV8vGgR9TH1vse179n8yI4V81pyPR6yyFEFyT+FGb9SBWJKtJyKrg3yz3QYgGVN4A+CSQCAi8HKJiO2BVHQkwco+3t2vI7YlfB+XFhP/o9wG6MT/+ZdzbpLxzr87VclI0mo6LAcZJvB4q6RjukafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spFLHTisYvBAXSg139a5zj99f0AtFoKELD/yDLhuOf8=;
 b=kKIEFvFzmoQq1VW76DAchF+e2JldiObLXCNZ7HvsOFQg3ttrS5Qgt1D86nKWq3JdUYAOhrEgmbPVjdXXqK4j/OpnkJwOFJ079W/4EIgg2ilr5y37+USNb2RgGXLk5CEVWnNRcvRMDVUomW8Hnd5ALhHovtNkLG3OkuxbCZ3HV8XpFxN7jxFXdtQnOjgUs9Rq+MS7W2xDawpGrF4pX0kHFu2JwQ8LPotwpgpbxbT6g/WoOO9DTNjk722M07iSMyt2tQwFa8fB7DoYIQAkVzkX3fHfH6Yet8H/dVQ4KoEk0GrmRUf9Q4s1gISgwdlfiMaYztMILn/Ql725kQbulTeabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spFLHTisYvBAXSg139a5zj99f0AtFoKELD/yDLhuOf8=;
 b=riHJpMpg/vdUsyMjtXgUX56fjWGqWa/A7k/uxAqn36Vf0yHOCfiAuSkZwtQgujJVmp117VynvEdW0bHsXmAOBPCdV1RP4jKmatPNysLPNCQoluAPLsjoDSz1MiNXv0jsQ7eK6OWdj5LlfQy8seqDVJscXG/lpjEIrej0yYuOTSoIkfzsuFwRz2PcdH4WHy5yFGaE8K6vwcvG7E4OkRXsM+q/IUBW/ahLmnf74NAfMVKd6ZTwmthuD4sHR0i2BwrHelP4OSggYUWhO14bPjbECKH+gdRr5LfYDlTG80RpqFpf+s37v6MUwxGMJ1hs1kJSybV9fIyiW5/cfPM9qlM8fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:01:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:01:06 +0000
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
Subject: [PATCH v14 07/10] test/cmd/wget: fix the test
Date: Wed,  4 Dec 2024 02:00:46 +0300
Message-ID: <20241203230049.2677155-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: f6da3254-bce8-4d35-97f3-08dd13ee5e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CjSiBglWUmsZjxa+2oMn5Poa7xvw4cNxWQfQ4Evmt8FBWXAcCtuvq/QtyoUe?=
 =?us-ascii?Q?rYBTD+SEGS1SUjd7qPiqkf7VfTbzYkjR23FcmHjx6x2yI28Wuh8du1cmQzBg?=
 =?us-ascii?Q?n5zCApFiBbQ/JdRLIO6kJiEWk09qRiebRDaYM9YS82OW14kw+9KIX+5HJIZQ?=
 =?us-ascii?Q?XQ4AaDugimpn8b79i4zYWyz6g9avQgID4rOWSCcsustqiYlT2Hni9jF+nS1W?=
 =?us-ascii?Q?ei2BrziI9b0OTnS2FyWiVB+Eg/BqXX5eP3HjGryleaJBGBgiWNQgUR14vS47?=
 =?us-ascii?Q?bRW1uC05MCp/oTqSaEwRm2RjN2l6SyTrsnACzqS5V5CBd6k1qO2/UUias/ec?=
 =?us-ascii?Q?Tbl52FCRdCLTZkSVUfMQhQ2/sWYZm0A+QT2GZNs79JBTaFqtjDF19hwm5Dhj?=
 =?us-ascii?Q?euVk6HKoKnUUKiqx6FkzEYL9gejw1aJeDtTv5X9gvkAXs07wyMfSW2UdCjzw?=
 =?us-ascii?Q?JoJ5d7XZpaVfXyYxIJmY9HgjJRTgo3g5ddfv9gJPb8qRORk718Ym1D2N3pfl?=
 =?us-ascii?Q?ByNmj7uKCKFKxv9izkx494FpW+5KxhWIxTQhcLupFQ7Oek5/9N/hAHysQ+o/?=
 =?us-ascii?Q?xPKmWrnyh68bBYwppxM4Nx91GpURxFMZl1OvtfuqTkBkpvgVph77wTveafPF?=
 =?us-ascii?Q?yRh1735jQt49wkMeapXYepXtFUkj9jq0LXTlSsP3CSYT/HCvL78wXk/W35SI?=
 =?us-ascii?Q?WmtgtITd35gSRpg4umdcfB95WN/pZ9IGcIEQTrSf1/ima24te3sGRjG35y1T?=
 =?us-ascii?Q?prxO7b0Xzj4gQ8rxz5IQR7ZsNpz3ktgmakIElZSiVavUTwaprGetvjWp78dr?=
 =?us-ascii?Q?9ftZnDuGczHQZqrAdsemOvauP6oHt1IqJfI/tHN2fwViudkiBlN8maYcdWrJ?=
 =?us-ascii?Q?GqeNW+B4WLefY9NW3u228Y24KoZi6QXzK7siWcIGDJr7CspnOicyS3UJ6OBj?=
 =?us-ascii?Q?JT/vSLBx5URAKRPXWHtjHhzX7Qbj/1sSIpLSVGEpOE1ObAAYUS46+4G/uSJT?=
 =?us-ascii?Q?GX407q6TjK6MSaJgEmNhEhD0V0W2WoFvh6dPI4L99VGz3gOufqo5jYl9mDW9?=
 =?us-ascii?Q?vzYrM5Dk3pHyV6Jccxg6JylZkdWrQvb7J9XgOCrJ6S/LaOP0Bmsz9gfEErzb?=
 =?us-ascii?Q?IeSq2mckTAaMade35biGpv2u6PcpP9ybbX052g6YvES/J9DjmNjkyuUbPJzV?=
 =?us-ascii?Q?dAmiGfD2UeP6kK8UQCn0TCroj1PEVSEOvCHBETTGBTEK+we3UMtWQnZDoq9/?=
 =?us-ascii?Q?BsuNHt9AT5LAWD/0aTmE8I9fnFbLj00SlfiiOLjcMuWL4LKkelZ8JenIBxbn?=
 =?us-ascii?Q?zlw4MD7B4QmStsbyjZelIUxrmg2/InnIkYumopuYb/Lo6rzdPkDAhEdyvilh?=
 =?us-ascii?Q?dorc6w2+uBNsSnsPQpOP9UNZ5wj5HnM7cBfqpVW8pKz+uaXns7t8qQyDeUBl?=
 =?us-ascii?Q?kh8Z7I1xZD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rq+SEgjcJCRulltpNBAJX/AfO1F7KwQo12n6xAyxRJTTvztvnExbN4kYn/PT?=
 =?us-ascii?Q?haW/7YlduTgggqrwJFngERsSJCuUrniL9Fb3ZRX8J87dVAaaUY03Hknh6nLU?=
 =?us-ascii?Q?FcbFzo1vvyZnrKPCrORrPZk6Arc43/rTYqI8y0KKGGEl1L90c0o5PH91ATgG?=
 =?us-ascii?Q?BtoyoRZm0xvF97a599zLY/DyRCbi/n9EDF0MXfe9nYxUfBxBdVF8AuY6Kd1m?=
 =?us-ascii?Q?vkzPRB5I1+QY44OfuYyBNnIP7lIlvCx/42GKryvWq3udPVZ93IDhmtK4rKM1?=
 =?us-ascii?Q?UbfU33vzwJV7ujjJ3l4FtJcr0szZMdbzSbp+42Uk6J05zK6e4PZrkBS9ZUEF?=
 =?us-ascii?Q?L62htXSnolqQyoVUg27cUhyA6k8CXevn8MvlAAdwMb+zHqyQDbfG+LnPDOxI?=
 =?us-ascii?Q?NNBiN/23y/ubJxJ3tCbN6RUGivsuEoJs1it++XVVox2BE9rularc+aksgyNb?=
 =?us-ascii?Q?lxNPq36MME0xSydoeZMrCD+g147JYt5edhnveB/dS+GUiD2eiwP0bhqcegY+?=
 =?us-ascii?Q?lcLybjTaDvIvMR0l3zKNQPVtLNp7os6D1XoF0/Mm0jZQJduXQz6ZYCnVZHFn?=
 =?us-ascii?Q?+JPZIgwkxxwjqAN3VQKxU05z15DHU8aTVl791SHCQRJHchU9tbxppTl1tPVf?=
 =?us-ascii?Q?FoE4CMKo0dlJgYKpJzeddw06+AKO62VPSppFMeBUx39PZCTUsc/TyNgPo1fm?=
 =?us-ascii?Q?gKoM7kl+BQV57z0dtgyUjEv7yyt/o4ZSQ2PY9dLqbKdiEBBGxpqxH9q3GSZ3?=
 =?us-ascii?Q?kJ+xNx77QQ+dX5XMu15GzZv4vhr/m4FEs6Ko/66gpCfn9ud2+3LTiCFhJUE+?=
 =?us-ascii?Q?iTCst5vM5lxJKru18i19CqmTVko+Sgnjxfb5W4g1mExSFh98OJyXsK/Oie9n?=
 =?us-ascii?Q?fIf3PH3YVhOwYWZQoY7enUBzUufv6yA1o3W9fWwvRu9V03GMpmCm070V3g2j?=
 =?us-ascii?Q?Hvgsuv8M0xg0rBESiDf1rHUOmmCtX29RVd6zVc66+X7TxWSeuakiUWWU0ON8?=
 =?us-ascii?Q?6IRRQt2BH5ZPTz80/mBzzEHmGMjsrnsQMRoYtkvIU7DfktzVRVbJx5wGuL/J?=
 =?us-ascii?Q?65mtWL755y0zjWLP38CmGd4nXsJUNXUlQRC1dPd2tQ0LBccIHDx7f7E8nQ5F?=
 =?us-ascii?Q?1BjBe28uBrm+OM7Ms4wExSw94gXJ/flaRrID6bXdPrQOgo5Cz94AQ8WpkUCh?=
 =?us-ascii?Q?NpD488znQoQa/WD1olzuQlnJ+cB8x1xrgeFe0osnhybBJkPej+VjTmpQ1vtR?=
 =?us-ascii?Q?F/7Zug1XDQ/W54sqk4LHNIN0yzeBMY/TFQHDlJiVSDuTNa6/y/y613uuBwab?=
 =?us-ascii?Q?A+YVKbrcjQSGVx+GL4kgMwq6rT4qYggodWEculIfQ6ZxBuyJFWwknSRJ1Fb+?=
 =?us-ascii?Q?LFFSI2ABmtOT1+f9B80YskopAF8vqi/vCjL5wZ3L3jq1ZWaa/szCgRDHyBHf?=
 =?us-ascii?Q?uat6cg1zM4Lk1IabFU5rviFpq7EdMMvyicE4k3FhSOla+z4uwiX0t0iaTVnJ?=
 =?us-ascii?Q?QW7LNDcZFxzHsEGC6mSpa6JxPromNKk3d9m1ZIbRbGq+cIMxCCdCJnChnqhO?=
 =?us-ascii?Q?scyJIj5bGem3Hk1R2ZuIH9lHiii8WXDtO2+G5ywxdQHSPrVmw4felE1YoOY3?=
 =?us-ascii?Q?dpXY33rrqeAz/UzUbItB6A4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f6da3254-bce8-4d35-97f3-08dd13ee5e5f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:01:06.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59NfRtPXYMHJOoyT44xIo1yqRW3voEugg7H6qxTfT2BP+fdIPqvJ8XIkZOkKfbxCHHMfFWQM4denXn+2ciY8g6/4lM/cF2SYmI16Kbpmrw0=
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
index 7570c065a10..c28aef0a2f1 100644
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
@@ -218,6 +214,8 @@ static int net_test_wget(struct unit_test_state *uts)
 	env_set("loadaddr", "0x20000");
 	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
 	ut_assert_nextline("HTTP/1.1 200 OK");
+	ut_assert_nextline("Content-Length: 30");
+	ut_assert_nextline_empty();
 	ut_assert_nextline("Packets received 5, Transfer Successful");
 	ut_assert_nextline("Bytes transferred = 32 (20 hex)");
 
-- 
2.45.2

