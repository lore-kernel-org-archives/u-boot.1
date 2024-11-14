Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7B0D637DF
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82114895CB;
	Thu, 14 Nov 2024 04:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="IRs2stw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73933895D5; Thu, 14 Nov 2024 04:37:05 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C91895C0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji7DlUZ3SiPBMqEhwtvcJ9vSnwRVt9qOLr1ogRoo6o/WeZLdragActolh/uL4jEVfK/zCgecTBPPG+K6kSGvN0PYKbG3kTLslSUEpjyhlto+OlkxdNI4nfH9mWEex1jiUwhSaOZ3aR7GupONGCPTMO7lU8ALh1lul3w68Gvjl1IQ5Kk0YWDuVI2RfMGxYD/q+nsiZgfXa0vpLw5VfJ2B+Fgxk7GF58MqWpjnBCGDHoUPsn4HX2njoCUWq6Xw+6H4hH90+oEW8d5/42Tbzc9yTrHV/xUff6ZPymLg+mh/5rtqvpnvOnErzxyR0qNiMkmM0dTw827yQl67t22E5sr8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=FIbBUoxRsLp5vaeui6lReFSq0Gk/reA7bVvltYv4MCbrUT/AwmuindINCNicqDhHVm3H5MN46CLa9n4ww2GUUvKzT3iSgP8jdQB8yh/H79qKrHNtaJIA6AjDsVw0txUzuL+c7nGNUNZQPsvqE/fYo/LCYPI3ISmmaVd5D6X4awy3+s1/Rs5x77uNbyyJzWN/3yrXl97+zQwft8OkPyTuYDe8RExAVZojVRpywHO9MSgsJErIRp2S4uRjbcUuX+dqd0Diaz38nhNmmjXzy1Lf8brut/6/LhJLjwSJ8D7ta2SLUJg/PkEoonN5qKUBnefX9//1JOq7sh/0QZpF4m5lYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62/Ol9X71yYtmZd4mikO6404dH2Sob+9cESn+PsecLY=;
 b=IRs2stw6wftJu4xA8Fgk7XHrg73pA0/h4itIeMbHgR6azHCH3+aavMMrADKcp0XEN038EmxykCfSyfs1aly9Q6hSBv/p7naE9GL/XtXjK5BGaAyInE+XdvSSMFodl8TYUit0ChetfTckEXV8enbgMpzsB4nKlZbtJgnNWP31otQd/QDKt9gd1upNRt1aqVUuUW0fMVWj5iG/Otpaes27SeuRJpkKimPdBrSf7lSbUVGl/yucqXx2dh1f8LFN+GTmNBhgAstxzOeJ9XxSaT6WT97Ynw6czGKCzxjBj+7JR/bGB5ihQdQVBHSk2oBsBSEtue1ZStOxGwYxIRXWX+KoMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 03:37:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:36:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v13 07/10] test/cmd/wget: fix the test
Date: Thu, 14 Nov 2024 06:36:40 +0300
Message-ID: <20241114033643.623355-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f10b17b-e382-4d07-b5cb-08dd045d98bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wznlARIoaMhIAHOZblglYHXtnX8SrZYmL0BeiVbtz9cawIj+CAkcubNmzZex?=
 =?us-ascii?Q?n32YT8a1LQ59hsakKyJ3gSjK0xSjJmwoJImAWytPuMIqJfRKhvPF2wy5LId4?=
 =?us-ascii?Q?JAH/uw9z5WAqYBsltQBIhLI9VYXcCJsmxRzxXS+B3cAdT8aE5NhQ5GbPVzap?=
 =?us-ascii?Q?OCgnpdHf/Bb4PNSRxCRY8bedKnX8k6Agyo7boCfyXsqubzgORp8Jr+PcSGgF?=
 =?us-ascii?Q?srgMOG1x8nm33Plg3m43pBE70u3swVdKZzCH6kUa5jtjAC7f9X0dL1tNryEs?=
 =?us-ascii?Q?uVQXdrdf5pG9FFIQUykjacT7WKk5pjMCKU+SVDBnS6HLvb46Y6RyteMABC/c?=
 =?us-ascii?Q?zw4oH6VAdxEjPIiLs59bJcQFO51B2FszpjXgBZH1y/PStjRMPj8wanY1Fk24?=
 =?us-ascii?Q?JpOOdQa287cBN4f+X4fSbuFisTkYi3VNu4y+lFO67eVFW2sA84UavBRgaZ1n?=
 =?us-ascii?Q?N2cCKUXjNQU7hxiE4QGxhpfXVqT7U6Hm0DqeirIs9mUhR62VyT2pcQNhcNkC?=
 =?us-ascii?Q?eYHaqPBy4jtArJS61lxqAArv5WngzuQpUkhXw/1QQSYp9VuAkGj4NKFadJUk?=
 =?us-ascii?Q?MBSKe5WBgPi2Qx1vucB8+X3kvzb8vOPOJqyK4ot+RqUjeKKALsTCoPJu0B06?=
 =?us-ascii?Q?Gq97sa2vVfrwMuvSqKrjl1uC/XTkzV4Mo+ncPvLsoRcFHj1LqOczNlDxfBii?=
 =?us-ascii?Q?DwSUKj5xXgn70i0t5B21rb2KPiYLsyNMDMx4frzG2xKxb0HBstFo0jKN9Dwx?=
 =?us-ascii?Q?96Jpy19BUmSt1tLsCUg84bZ1VuF0f9XReqfS3ry54CBq+nPpS+hCbBi0pADm?=
 =?us-ascii?Q?3w/hNSLHftcZCYuHpPvUAN7+nOFwH0exoTfQLQESZ1NgB6FQy7TSbfkFpBYA?=
 =?us-ascii?Q?TVeER6w57KaQIXIS3VN4ZEGXIVrOlR8DZM+MoxYxptU85VeFtQEPK5nBnJK4?=
 =?us-ascii?Q?4Zyt8IZlNBVAi/4Cu87EqvVGSkroXobFVI/NQQB3rog2sWSd3SxUUtEVM5a9?=
 =?us-ascii?Q?D1VohpxTMbNuNSWhagdvG7ZmT8x/ISHcPBxVFnidxL9i8sLwOpqwH8KJchvx?=
 =?us-ascii?Q?AUlmN1rmrth3Hsgb2UQHw0AZRZcsYC1BaAmMfxeVLvI9wrPX3UzbWVxC6Gj2?=
 =?us-ascii?Q?G2unilv1GK+jHl+we9QrNC9cO4Hu6lf4Qm3d5AB4OKhrtNiWyfxwHoKYygeO?=
 =?us-ascii?Q?fs2UHM+Aimmbjh9NNs0N4NMRJHEhYOP3GBjfyk5suMiyDGj84M2tScXHkLxJ?=
 =?us-ascii?Q?P3nOA+KZDtkXJkkM+SKi2MEJci+CpIfgixt2kRFjXguVyXdClCndyJBXfPfN?=
 =?us-ascii?Q?+PcvUpkUe2fjpq2aQQ/bXnHMglioxB4NRgkVoks+Ul69b24VS7kwEZDTL7Dg?=
 =?us-ascii?Q?NhFsbwA50j+N8wKeUcrbKlREXjkr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EyFBFS4F1Z1yodeiqsprzPA7XK8tr6fnHv7Drq8F4Kfcc+Jgc5m5CETbOk1d?=
 =?us-ascii?Q?w0TGqIHuLhXi18Htb9f3S6awMmsft7aAybfSS/GvzxZ+w+uM91fasTdSd9uJ?=
 =?us-ascii?Q?nzuWPnM1UIxKdy0bQjy4YDMTqrfLrxRyQbkrmezW5OAKXK2IU0UtG5TUXrjb?=
 =?us-ascii?Q?g5XI9kl6EQr1DLxb3A+dZJ1woDc1z6CHw4YxwDmOhkNF/8m9QjOqO8/l7UE3?=
 =?us-ascii?Q?HFvr9JQAWn99FIMWdM4r/CFqEKnMnLMDEcGubL2vfkLuwtoN32x6GrU+89JO?=
 =?us-ascii?Q?abF7Hf5HDdZyEeCotewQOSXJ/Ne9CLGCPv17f0HS5hHo4CGmuOXLt24klX01?=
 =?us-ascii?Q?b+4KdfUUa6LR5F5Z38JjRH4yrI+/d1B9FHBtowRE3yMkI5llios18H04431V?=
 =?us-ascii?Q?AYXroyCwyLjS6U/8YqyYkUtT4fVSo3yomhUASKdxhijmEbbESQ/i8Bb5MWnw?=
 =?us-ascii?Q?Z9gK9z38puQbbc0Thjkce2Z+56K4spk3hP9AcDAzNcKVz4IPMuB2XLI5FPxf?=
 =?us-ascii?Q?s2X+Ss9Cx41Gy+EHA5QfZyVhuTt25jA7CyfSetiO18ItigVqp67KdWo+SqvC?=
 =?us-ascii?Q?ejpSqmUtsUvF85JEsLDZmi3dGTVi6VY8x8w+aZC2WRfv471I8NsIDA/EkNgE?=
 =?us-ascii?Q?2h3PUOsFGcA/M+j+rI61/PHODJMalW8/PQcGu8PUVUeuwqc0WQfbuOIG6oAQ?=
 =?us-ascii?Q?sVzN8I4AzrNi36kipkRqMn9UB51N6YMoudJYqiDFXoRCqoiUQCjqntbprNK/?=
 =?us-ascii?Q?S9wqODCH2xGlzdK5rFoCUfh/Re559TSvV2yP4QopRY8doSl9GTFZDQNjv9/6?=
 =?us-ascii?Q?BTKUmh+ApuEC7G/j1BWeZlASiOnBJc+ZvZDa4rnrrMD2NkQnjM42czjBIGKQ?=
 =?us-ascii?Q?139mV+olFWKvb4XlRtZOLLxMTmZCfyy0pCwa0mflreU773+agHNNnD5djo6X?=
 =?us-ascii?Q?KnJjccsHjKkRBtM+ExAstOf5DiDIlJWMXyAmEoBhbggK7FkcHzUXJUp4Phv4?=
 =?us-ascii?Q?aCSJ8xjowc4kxN4703G3jYBfwXpIYuKtP88T2eIzjsYtF77fQGMDCCbntA6u?=
 =?us-ascii?Q?JB0CZ0ymoIu37SvCFsLuPS2vNdii3mFG+MHtJQQ3zQxQj8unbrwgTTdYXuHp?=
 =?us-ascii?Q?RdqsQB2PCcAwQoI47IN5n3JGNMz5F+JJo2woT8dxI/XkDRAlDWcR/dLpXBuU?=
 =?us-ascii?Q?mmcvx+M+0PlEO3ck2p8SDJ9tneT7pQdMVbOjCyNh5/1MZDrGgQRGZXfzsw9x?=
 =?us-ascii?Q?veQuGzifB0zZTdwGuC0tRFLUhbhCFcPN1sUZyJ+W3Gs7/Jop6AjzgQeh3CD9?=
 =?us-ascii?Q?/Qpon1iov7IRu8aedoxQS/qL9HWIh3RrPYuT25BTzbmZy1L+vGCuXMdxuhvo?=
 =?us-ascii?Q?eHy/RrbEJvnMOiGJ002ulvWMscOg4iwvu7jHiPvZbJ01BVEIUJt0ddqMjGWN?=
 =?us-ascii?Q?syGT+aIhSN1yvHLiqLaF8K4NueYzvugvR4GL1vMFYfXJFQ//429lbdMiIJYt?=
 =?us-ascii?Q?0AmRWQ1wuJFRdZ2/TntsS0ahpGdIPGyy1UFw6YL06IWg3eND74d5xtc2AYnP?=
 =?us-ascii?Q?uikBkzRt4p3Dgo5RxfPZusWQ+PT4dWfr9U0fwMJMbJzsBHqN+6/3+oRwYJs2?=
 =?us-ascii?Q?AZ9W+I8gYZaD63B7tZ5YCg4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f10b17b-e382-4d07-b5cb-08dd045d98bc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:36:59.8846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bbn9oSIwoxtlXFhYShZJfvSWKrrKVumjOgrNV4bPZQmCmHgjFh54bokPsui9NCWLYZ8pFkrtPs+8pSg1RJnSIfuWlcgxwQJoytpwyNFXvZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10338
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

