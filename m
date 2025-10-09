Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA36BCCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 09:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28DB58420C;
	Thu,  9 Oct 2025 11:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="nQMMIVn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEE884221; Thu,  9 Oct 2025 11:18:58 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FEB841F5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 11:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xph1s3iZ9JwE9jBXGFr3SKBcf3p8xzotltVDJTV90ohIfYdEi1qlVvkZ7mKRe36w+9O6gIiQ/7Jlf0iwLp6qFk9JKsy3PqVEQ2NRDEc2TjWD37d7cycuct4ZEe1TqLiUhV6no1FuAGG4LumCzBp/semCVxG6FpTdkbxiUWa2fuKDW+Lx/aOthCMJBPh5ixapDwX0rB1GUAslZ/vp8WRbNaHbe0CkW27PR2R3nl7OuK3DZDseJeL4CkgJ+k524Ft5D5zDCJ0tRy0G+7km/llN3vaYvlyb5bC6pXCBpnX1GQdAKkYWoPcvOsL4sPXn8XB1Ox4OLBQ3u4OfrB+8L+fHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE7yKg/eUl4cVkmTG1N1YqelmmQ6tcy+ane0Tci+MAo=;
 b=eMaglzu9Ax1PizFid6c5FwYAcmYWJpFCfMwGrpseC15+XOePUIgnJaA57qmD2yQe1hk7XnsU6/nbdGbiFhO2oPAHsScx5GBwU/XsAe15SAbxEHBKPnINGFnrfRlEz8yF4OewLksDTB0LsojGjk8eFNHSgtCGo7NBJduiiW+Zok0FmS3Wfb0T2spSxnTKgDBw5JP2U6ZqJLrPIyaC7vtoABj4DL8EmlbpkL6ufIap+vASCg6P4gSwI4Mc1MOb1x+cyASJyzrIhMrQNqCCNXx4EaAVbQbf1TWRFDVui9ZSj6rikebB2vaQz/31XHbaALbGGq2P6m8FhoaQB+dTB/9Q5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE7yKg/eUl4cVkmTG1N1YqelmmQ6tcy+ane0Tci+MAo=;
 b=nQMMIVn6fmp7063wZSyZImpVDEGkbmYd9h1/3HImB965ny0DO77XWvXEQx40DSDf5uxRdXecguf63H5Pq4Nvtmvc51BNpoyz4t4U5KTV+u8NN4jMbmgBflXPF+IwrCjIA3wcqeV0YJLOfmrkHOfTcYhYUKY7nj3K/bZXwUAfYRimJAJcuoZ3nsHYv5rx6MQVG29zrQEcUWIwTOXEdy0rWcx2wg4RaNIAvVEL0nESTRrKyTJbQZhWQWz47EetcjcxIDrS17M1UCwNRNyNAvr7IDZqWUe2OZdyTE2077q57jLfak87ZR94pAl6X1+7NYJnNYb1hPee+kFA+prBQrj4wQ==
Received: from PR1P264CA0125.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::12)
 by PARP264MB4956.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 09:18:52 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd:cafe::77) by PR1P264CA0125.outlook.office365.com
 (2603:10a6:102:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 09:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Thu, 9 Oct 2025 09:18:52 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 616C62018F;
 Thu,  9 Oct 2025 11:18:52 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org
Cc: u-boot@lists.denx.de,
	Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH] net: bootp: Prevent buffer overflow to avoid leaking the RAM
 content
Date: Thu,  9 Oct 2025 11:17:19 +0200
Message-ID: <20251009091719.187715-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PARP264MB4956:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d7282448-8904-4b2f-0be0-08de0714dd44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e9uQX3tFq0KmhAb5YwWjRK0m/Of9BSbIZnOaHGVis/Hh53GsXbX8ds/yaCZC?=
 =?us-ascii?Q?nrJvxQN0Blttz/Zci3+wLIltIoM1N98NMLdhulzTnshPv0vWDXK8H2RvpE5y?=
 =?us-ascii?Q?/llNtDl8JbrHhZtHesefuSLRAay8tYjv4LnI3psb/ioUq+A5t9gbA5M/E31c?=
 =?us-ascii?Q?2uUmt0RgGIb/zrcnDXVLFmd0leGUvqXKWnK6jB8ultq4BxjbbTdKI3mp6+c1?=
 =?us-ascii?Q?SvQwCaYTlLYdh5Z+x04ZCXqC7UL2w8AZmtDmgcwUeOxXEzqC0nDEZ1oaCf7M?=
 =?us-ascii?Q?3/66vSSt6OFAqxiuDxM+492VWjelcpDF/gxkC0Xf6lSxxRsvGiscgw2fQvii?=
 =?us-ascii?Q?LRd6Gs46g+u5a4AE9Vd6Fzezva0QhgYNrhCst4e+UGZFvwMHOWZOlWDAsThT?=
 =?us-ascii?Q?L+7F0SokmWBl84RbYbvzqwdbIgx4GLNWEVUEXPoKaereTEszDx5STD7VZd6h?=
 =?us-ascii?Q?GqdS9Wik42x0cgCmHIfMQOWXjf3MbCgx7p9RalcGFU4d5qJmADWVOtH7/iwT?=
 =?us-ascii?Q?RUsLKls4sLPRVBFnwhCCJIQ7hwo45cbih+9r9Z1NHtD4Z0tVZmb0OtCWAf5L?=
 =?us-ascii?Q?mY3XkUElYKLMexP/qZi6Tx2l8ocu3aaAH5v4d2KTTbPQJw/gsaQfAFm1wjom?=
 =?us-ascii?Q?9u8udnnmvxYp4C4I/5ZLaQpN4FbDFRaFH0EJQPXGakI5UKifRho2kregUQaz?=
 =?us-ascii?Q?j0yobZi+ZRiOywSAmTTtmuGuRDGFM/1ByBVgQAXPrXxSsNZpAxY7m3Zd2gI5?=
 =?us-ascii?Q?qUMuye0t8+xRzVq/x989eLQwG2ekuGYIcBb53BHh13bWDzAhxUkSxviNCp+Y?=
 =?us-ascii?Q?fR9cftdIHnLCbkoX3v/aEoGNhbzCNJvdybr6Ud2D4zLmhKIqf00pKG0LFDs2?=
 =?us-ascii?Q?EUS/WnfTFhOyJmCvZyY0Q/vzDk4vL1h1rXlALwlAjYXkpf+0EPdVTd5b+WVZ?=
 =?us-ascii?Q?EZbTcxpx1hyPrBkW10CdSxP4p99bi/VES2wlRsr2s5Zk2DrB3NfK/hCBQNzU?=
 =?us-ascii?Q?hSZF5qrlQfRS90BDsI1+SVx/PGqbGu0Z4sArJWoC3swGWAms0slV1iuZ8IzR?=
 =?us-ascii?Q?SUxkunId/aHKT30DiDvA7Oue/lEFe8fvYh4W56h3v/KSN1qCy5Ble6VfVBao?=
 =?us-ascii?Q?E7qnAoTlsYmpREXfPgDoyr5BsVqIIQMErWZ84dhZaLEGqeTtLO1+cjjnF966?=
 =?us-ascii?Q?XNOUZqUYF21fzLotQwupYHzWdTtbRbkIAkdkmzCg1ZkKv+zSmi4Sp0F0/0oy?=
 =?us-ascii?Q?6AATwkzoe7D+rKwg1EgCBsa4+hBnIVzUk2bq2DLMHtZw77Nq9ghkRVqlvZl3?=
 =?us-ascii?Q?8WNWTJvZB9YvTXRd3bN+xtjLHXu/VXoqYl9OM9fI+Zcl/CS2kusWAxdqXNaL?=
 =?us-ascii?Q?JlOSU/NViUMChBCI7WV90J7PM8wy/bPyVeOPOxrBw15QrB9r8mx9maM8OLN3?=
 =?us-ascii?Q?zHiEw/i/vA/6+6ICuGT6sEsj4mHKSiF8mNo5FOgTm+SUq9ohYrhgHO94imQO?=
 =?us-ascii?Q?l2rK3eD0YQIZO1D5g0Eb2UWPx3qTV3nk9gDLIYLURHDGP62XR6lklyg7rH1v?=
 =?us-ascii?Q?6vykVLpyMw5V9O5Hcwg=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:18:52.5693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7282448-8904-4b2f-0be0-08de0714dd44
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4956
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

From: Paul HENRYS <paul.henrys_ext@softathome.com>

CVE-2024-42040 describes a possible buffer overflow when calling
bootp_process_vendor() in bootp_handler() since the total length
of the packet is passed to bootp_process_vendor() without being
reduced to len-(offsetof(struct bootp_hdr,bp_vend)+4).

The packet length is also checked against its minimum size to avoid
reading data from struct bootp_hdr outside of the packet length.

From: Paul HENRYS <paul.henrys_ext@softathome.com>
Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 net/bootp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bootp.c b/net/bootp.c
index 19e7453daed..3ab00433bb8 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -379,6 +379,14 @@ static void bootp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	debug("got BOOTP packet (src=%d, dst=%d, len=%d want_len=%zu)\n",
 	      src, dest, len, sizeof(struct bootp_hdr));
 
+	/* Check the minimum size of a BOOTP packet is respected.
+	 * A BOOTP packet is between 300 bytes and 576 bytes big
+	 */
+	if (len < offsetof(struct bootp_hdr, bp_vend) + 64) {
+		printf("Error: got an invalid BOOTP packet (len=%u)\n", len);
+		return;
+	}
+
 	bp = (struct bootp_hdr *)pkt;
 
 	/* Filter out pkts we don't want */
@@ -396,7 +404,8 @@ static void bootp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 
 	/* Retrieve extended information (we must parse the vendor area) */
 	if (net_read_u32((u32 *)&bp->bp_vend[0]) == htonl(BOOTP_VENDOR_MAGIC))
-		bootp_process_vendor((uchar *)&bp->bp_vend[4], len);
+		bootp_process_vendor((uchar *)&bp->bp_vend[4], len -
+				     (offsetof(struct bootp_hdr, bp_vend) + 4));
 
 	net_set_timeout_handler(0, (thand_f *)0);
 	bootstage_mark_name(BOOTSTAGE_ID_BOOTP_STOP, "bootp_stop");
-- 
2.43.0

