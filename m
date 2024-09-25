Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE10CF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15AF788CD0;
	Wed, 25 Sep 2024 03:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BHHSAZwh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A23C88BB2; Wed, 25 Sep 2024 03:41:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC80C88BBE
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWMVSsAaZwNhOE90oGD1FmODVR5pnaLum3xFovv7/NLK/nW3BSE/WW+zNi4ULe28OOixN6Tdag3dQf+M7TQPe5j6ojZV5U0DUZQRfGuvMuLCn9Th7dz2Ajbf5q1h9d8DhP2bWw5mTYFOkGiFia+7nAFbpE0WrksIixBf6jJ9AyruF1exDMpfw4E2GGzdT4xCisvldDUhdX0r41yrfBfh79bC+IaOe+dAcvZ7UhMkukUrvK1j4I4IhiyO8LQgRwW2zRQQ2fW5S5hJi8HcvHrrYgAFQFgcKQE8WEMiCMQ+YDOcwixN8frbWQT98o6BfGFIyvKAaLY8VNHm5k1+545y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyvxhXWrviJZtOFOZEFqwcZmjyBhsKNwF7Exenqg8GE=;
 b=Eg08vWBRwIitH63Rn44Xg5Jgbaeyr31umbd6Rik10bX4IsmcBfsUa4i4SLIMq9VgTyOdWXd6GS8ywJHAi0CXtTxZb1A4YXJWoYz9SACquIQp3veZI8rLfrnCp5XViVg+CSufT6CJtmFA1HTgU3ZPGV/xlS0yvB6FL28WNELhyQwUky4Fhzw2fECUX4ix6zY3KPK9IUbn8A8wOoQqpCB6eh5cDTN4kW0HanpIBPYxql1JO0zV5W4iB8kGBxZUVk7wyR+7SYulp8yQz9YueSHP9rHLkCk+0+kbrP444q0L36ql+S2yDQuaGIlI+YUsnJVctnXbGb9B6bO6gOccx7P7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyvxhXWrviJZtOFOZEFqwcZmjyBhsKNwF7Exenqg8GE=;
 b=BHHSAZwhBAWLPKCTyoQ9BCJN2vbx6xHRvDS2ucTDyu6HWL7vFvxhehwEqoLFW96uq96lxJdcV5vuJunc5PkmbQK36Wrt67YXouUWqFSeDNGCRZpLuGT+gKfLRZGLe4jJOZ1jL/Pa4oNGRX4z9xliCHH+f7cZWcbgjbyWq+tYaaXtqMoLaTPSmhz8zVw4Zb9NHdsNOdnMYFA9/Q/6eoiaAAbULJcjjpvO+rbWwR0amIE/DBZZSvROfLvMl/Rurj+N0wJuewCDJifI+jMSJHbemnI/axmylbMDadKH/VpbHXUfuNIiQkJ/CxeismGPrFfkL03snup7W5YuF9oofOUVbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v8 07/13] test/cmd/wget: fix the test
Date: Wed, 25 Sep 2024 04:40:52 +0300
Message-ID: <20240925014058.1679074-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c2ee08-3c94-4e32-ddcb-08dcdd0325f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WRxSKQG6Ncl2B6NxI/Q3i6xE8jOfXu0j/iSsv2TxPVHbUH3qEOc+JSlMyGq+?=
 =?us-ascii?Q?3wbU6dkZAmGTHYXfEBQTjxXRv+OObRybL9zOHdrMG9DQGXB9U9KsVzLwlk5+?=
 =?us-ascii?Q?ZIzy3n7mC1xeR6N37OwOBWjhhUMOz+fY9N1qmThV/jsfFQgtWpFR6b2viRgK?=
 =?us-ascii?Q?lMgmhXzcB1stKCbM7udae+/l/ie6FQyw+OIgScdIhX9nc2SkWSz6KUe+R/9P?=
 =?us-ascii?Q?ouaXgPsAVQfwuJUHKVAHkPmY0HMqDYn5Loc/f4vHb/mWLU8aafQIM6ajkywW?=
 =?us-ascii?Q?ydTyICH7Flf7qLp0x/+F8fsvzoqmYEnhdA4u5ay7iRZATbL1+HVZDlNhnNsp?=
 =?us-ascii?Q?gqtefjvm7OM+WME6xnfXyXrZOf5X6fcW1zNhjQKMNAd0sX2nZwknOoA3ZkTW?=
 =?us-ascii?Q?7eZ2VitEhuwDmocw2+2nPrC283B2LAW6V5rAH00HtY1pndCNbQAvZ6jsGqWV?=
 =?us-ascii?Q?aBm/87j7+RmfDnAE7z7LyFEK2hVQUGjC6pFBJ3zMHLgMzKLMPhPXU/Oq+ITD?=
 =?us-ascii?Q?lQecHlvBTu0jLqXiMgGnPiH67awUIhyi5s2ZZTjdNidSAz/Q9yTt9dM2b5ol?=
 =?us-ascii?Q?G59ETenEGg4Z1hrSTbEVWqt9+SAAVeWAd2RT+qqPuXiMuOT966wHfqLAA8oq?=
 =?us-ascii?Q?ZPh+aSKhC1hk65Z+q1vpHxrGO2HxnD+5VjK+P7JQtljudZKHOBxqQqoLoh5V?=
 =?us-ascii?Q?0HFf/g9v9Lng5ySX4TL2UkQXKEUt9mv/YOq6JWurZ6fDbQ7oNvGcbDUdRmm7?=
 =?us-ascii?Q?0F0qJkWRPNgxFZZ7WcaN2gulXBn2+QPBiPmt9VVsZRJ/1QdeBJ90VHdCFn/3?=
 =?us-ascii?Q?BOQ2/34KFXhWLGsOos5BoB1fpVNMghDKg340xEHWtcq6H6+PDQ4uYT+a5L0c?=
 =?us-ascii?Q?P3XvaxPKfQvmMBwnnlnvsS1qy2R6g3Ww9QSOq/LrbwjfrhhHjZYEIVIhfn9C?=
 =?us-ascii?Q?n1zthmpNDT1ZroC/Bxp9kqhIvF28qMfB5Y7xGFz68s8JBv/hdmxT+Lk3bIDW?=
 =?us-ascii?Q?tzoEvzgFwcCMNYXZ+6G7zVG6h0LzjfOvEDyEsdIImPHPFDR6SEH6ZqLOUUe0?=
 =?us-ascii?Q?QUVS5tDFX6DcxZwubrd42ROBeOeTTQLazcZSq5CkwDNxwZQLNgW+nevKHh3l?=
 =?us-ascii?Q?EhqpIoa060mpit76w9No7lRUZjyELrwl0xvwHpD8Ha+puqBoeQLp5AG2V40i?=
 =?us-ascii?Q?G0F+AFsrin7SPVUwle2l+M8h4iBuYJiCa/JE5SeLUjdYsVw3vZ6OaoeELuB2?=
 =?us-ascii?Q?yq2V80IJKQQ4fYGw/o3NbiMKrJQSuncC/9n3jwPnk/qrXxlp6DrAwEmAog2s?=
 =?us-ascii?Q?qgDs/LlvCQYYv1h1LxI4UwgWQYJclModzUembuM4CzUXV4SG4hi7G4C8PCyo?=
 =?us-ascii?Q?vLa+jd4umMXfdEKldC8N7I7qMozaeUdEzo8sn3Hxi8Kw+jC13xVswJTrreqq?=
 =?us-ascii?Q?OGxelzQQkGU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXnQYkqa2wAjWKJFBX4dXTq6ltzhyJmfoS9zgfX0Ny7VKvijTEhTJlv6/FYU?=
 =?us-ascii?Q?3ww7UbWAVRCdiAZMgSs5EmibyrXx1hZ4SbjLtDPTJkoYg0Sg0IIR2AvxhwdC?=
 =?us-ascii?Q?ggSB87kH3JTmcCK4THOVe2PjwZA7NHLeooG319C+mxVWKW6Mjqzs6G0vFvQb?=
 =?us-ascii?Q?xHeXDKGJdwbOUhMVnILPjCUYMisylIhssqaques+HNQ1WtpsXP1J2H/PzVBA?=
 =?us-ascii?Q?cvVQyuQBkZKZQry5vUkn0Z0RALqnCxeoYIGSB2Npr7WGGkH/GRRNr95l1Ehl?=
 =?us-ascii?Q?Mzr0gA+mFRaOmNFTX7zPzhe7qVE5+ytQ/Id4xA43bqLinEZdBLRlBkwucVYC?=
 =?us-ascii?Q?nq03Sw9aLGhf9epFTLRtel+8y+fp/532HuZTJAa4XIll7iU9TtqkMB+E8Dtd?=
 =?us-ascii?Q?Cz9/1VlC6KCVwC/oK7CihRdqKYZy1XhCWbgfXGdbTrg96cte02Z2vRlC6lpF?=
 =?us-ascii?Q?+3Iv6CJdaCHR88GkxiSCLx2ETTa6qKBfb0vAXSyIMtxps+maHde/Je6511T8?=
 =?us-ascii?Q?whMLIEo1Z57ftyMsF8v1j+OFhYxjy7mhcul5nBITIvRYEC7N5floDUGuF2Hb?=
 =?us-ascii?Q?3UVmWoOgqcictlCJM7gT0ANHEKKOZGyU3FfFH38Om3lmAwuxqidZRqatA4Ve?=
 =?us-ascii?Q?Sl+L4TRR0rCoQzGzK8zkwqWVVE6nA8ZKvCazavEb2U84Qb9VsWaDGzgJCokL?=
 =?us-ascii?Q?jYQdLKClzP9cN5kIsZOu+U4JMUhozDJmyUlYS14GAyntMRuyfrqm7mlUO9ex?=
 =?us-ascii?Q?YQr1qkuk1BeqItzhOyHVOlNUXLiFJ1kJWncWPE5/BKu22k9uQdzW8ncnOF0i?=
 =?us-ascii?Q?ubd+yHhTogMBngPeAPr5o0peaRDFLTb7X/EmqrKUPb72eAvSIrhXwlg0wdLY?=
 =?us-ascii?Q?JbLfttdfADnqIYpahY84H70I78qii3XKM10F9zRAr9jTy5Sc4ohAu6igKVnn?=
 =?us-ascii?Q?V7hpFknAmlLLdczFp9dXwbxswPy7qBH03Abqp2NDU+FIFGLjzvKlG57+lKyU?=
 =?us-ascii?Q?/j1HIpD0VklPC2X6eqFac14V5CFwggxTBj2Mz30sNQvrVR+POhyi45h5VmI0?=
 =?us-ascii?Q?xByIAUdCxN+gEW+T7BOSSjwbkn4t/YN6FgCkcI6vRxIxE8rSonyaK0eqNYlQ?=
 =?us-ascii?Q?4HmFyGi2FmKccjQtdj8O0emnC8Ge0AYBYheDKRWRi3kT+zuiQZLYba2zLura?=
 =?us-ascii?Q?PpNNDpJuu+yE3zyUNr/W8mCtIB7jaAwtJgwhSqq+UGbkpSnjmcCwJd4mkcuf?=
 =?us-ascii?Q?xYSjflOucipYXYyLs2yPq3O/wblzYFPWjd26Bl0FI8BsIOVQ2aKVnwmxoHr2?=
 =?us-ascii?Q?KXQ/Tbc909P0sRCwGtmehG3tPAQv+/IVS6lTi83OKIj5uHX+V+nnlcfY77X8?=
 =?us-ascii?Q?R28CYbd+ugcNpqLAT5u5oSG7+nW73YfmIkRQuAuOlu6PQP5cj92fqZNPfSTV?=
 =?us-ascii?Q?k5Zo18N0lp0RWIeFBWqmIe4t2KJqXs8V1k67Vt+tAHeeFVADM+TybMZfCPtZ?=
 =?us-ascii?Q?l40ZOIP8lAW4Kbxm+J0/deRASPj++P8wZEzTOsMc8HyyFs412uPK5HeS+yW8?=
 =?us-ascii?Q?yeHW47g2ro+SxjVL3W2Ob6yY/vTH0dZOPtvny8o6YPtqUdQdYt4RxFJZl97o?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c2ee08-3c94-4e32-ddcb-08dcdd0325f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:17.2913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWJ/hjxRBSUaYyr188V0if6vTDg9BxKrWI4VjFDGjvg63Gp6Li8Rql1aZ66Qp6uAWA8PdtvZSSMRABhG5adm4cBBx4HFtMdnWstsyr8BTQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5645
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

The wget test seriously broken:
 * Uses zero values for ISS and IRS values (see RFC 9293).
 * Writes incorrect values to Sequence and Acknowledgment numbers fields
   of tcp packets. In the real life such packets will break the tcp stream.
 * The test should fail (see above), but due to buggy old tcp implementation
   it passes.

This patch fix all bugs mentioned above, so the test passes with new
and better tcp implementation.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/eth.h |  4 +++
 test/cmd/wget.c                | 45 ++++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 13 deletions(-)

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
index 356a4dcd8fa..3e9a5f354fc 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -26,6 +26,8 @@
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)
 
+#define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
+
 static int sb_arp_handler(struct udevice *dev, void *packet,
 			  unsigned int len)
 {
@@ -62,12 +64,14 @@ static int sb_syn_handler(struct udevice *dev, void *packet,
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
@@ -102,6 +106,8 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	void *data;
 	int pkt_len;
 	int payload_len = 0;
+	u32 tcp_seq, tcp_ack;
+	int tcp_data_len;
 	const char *payload1 = "HTTP/1.1 200 OK\r\n"
 		"Content-Length: 30\r\n\r\n\r\n"
 		"<html><body>Hi</body></html>\r\n";
@@ -119,17 +125,32 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	tcp_send->tcp_dst = tcp->tcp_src;
 	data = (void *)tcp_send + IP_TCP_HDR_SIZE;
 
-	if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1) {
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
+	tcp_seq = ntohl(tcp->tcp_seq) - priv->irs;
+	tcp_ack = ntohl(tcp->tcp_ack) - priv->iss;
+	tcp_data_len = len - ETHER_HDR_SIZE - IP_HDR_SIZE - GET_TCP_HDR_LEN_IN_BYTES(tcp->tcp_hlen);
+
+	if (tcp->tcp_flags & TCP_FIN)
+	    tcp_data_len++;
+
+	tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
+	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + tcp_data_len);
+
+	if (tcp_seq == 1 && tcp_ack == 1) {
+		if (tcp_data_len == 0) {
+			/* no data, wait for GET request */
+			return -1;
+		}
+
+		/* reply to GET request */
 		payload_len = strlen(payload1);
 		memcpy(data, payload1, payload_len);
 		tcp_send->tcp_flags = TCP_ACK;
-	} else if (ntohl(tcp->tcp_seq) == 2) {
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
@@ -148,11 +169,9 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 			  pkt_len,
 			  IPPROTO_TCP);
 
-	if (ntohl(tcp->tcp_seq) == 1 || ntohl(tcp->tcp_seq) == 2) {
-		priv->recv_packet_length[priv->recv_packets] =
-			ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
-		++priv->recv_packets;
-	}
+	priv->recv_packet_length[priv->recv_packets] =
+		ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
+	++priv->recv_packets;
 
 	return 0;
 }
-- 
2.45.2

