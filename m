Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E2BCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 15:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206FE844AE;
	Thu,  9 Oct 2025 17:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="pUqWZ+CF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D328455C; Thu,  9 Oct 2025 17:45:17 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A51B84461
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 17:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP+jYwdmW9WAgfIxTI/5DTbvl88igg/qewmZ04oYFHkWE9IzyAqUr6e9Kt8Sq3kYCHELMyVKd4Vx+ljYx1oGv+J9nhXcQ5tc2KlKaafdUfiAHsKdj5qumMHbJPgRoA/XNSsfT7RZBF7Ldf7O2gvSkAa2HBOvxR9mVzsI14YrIAZZixPURyQfHQwuU1Ua70W4nPKVyJ7fFcALAkfH9UcF18GtA/2/Q7uB1fZ20PL6yBgGwcnf1/DaC6+bmrn72icQGsqlmM8uTgmChMJoBkF2sK4nkI5MZ3q80wiuLef8dD/yequ44KGX5p4brCUjzsjHcpECvBhCnLLv9fQlwqL3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJOztuVz+1orPxhaCDjSbC1rumgOxFkh3j4PNeZ1xus=;
 b=QI4FV93nU6c/c9p4lkaC3IXzrDxxd5Lw75LweCy8dWg5u1rfCDdYh+QN93BexR/kAO0FNcd/YdDur2GvhEHBfZJfJCQDA1V+Bm2EFHP4YSPusBGnV5MbJtJpEXbOr+VYJzPBqhCwW57WzYikxELKDoCdFYp9kYZO4flH3vYlk71BUsBoRlXvhxgrEWUB6nflgJ4ehPoDxKjcR6fP8K5+cLM3l2q19ek5l60dDR1OIGYDC9fpTWHO6DofwNsD0DarFFucrE4oatC5tNORh1ZnUorewp765agJlu6mE2vyvaws16C2v/wUuJR3iIfYbyY+c0kyko6NvUBBn9fMI7FVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJOztuVz+1orPxhaCDjSbC1rumgOxFkh3j4PNeZ1xus=;
 b=pUqWZ+CFX7fXg4O/wdxjgzTTJB8CVjcgo928IBAzn7YBfXqxv6EA4ozzTFhdZy2CuLJWXF0u6ebjdYZyTXxfxAtsTzf1oC3NL9L7HyvrtpPmUYwrW/PLn2O/YVFMjXwjVgo9Tt85eHGmt6Rlc4PF50rFQRtsONzgbBur8p14Cds5Shw+yqjn5/IrhKOCpdRaGKItFWz2aSr7atnIll37/DrjMam2wGmubkrjRG+ekbVVsJnbnQw4pRkq1DxUW/9xDr9rA6l+HeKh/Mx/j7+MLrnZlFCiE/UTZD4K3/NaFR1FMcwwjcNrVHt8+oYnxm8PMuG6I8/0ScOZOO7/vkEdRg==
Received: from PR3P193CA0041.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::16)
 by PARP264MB5871.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 15:45:12 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:51:cafe::2) by PR3P193CA0041.outlook.office365.com
 (2603:10a6:102:51::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Thu,
 9 Oct 2025 15:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Thu, 9 Oct 2025 15:45:12 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2A0E1200CF;
 Thu,  9 Oct 2025 17:45:12 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 festevam@gmail.com
Cc: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2] net: bootp: Prevent buffer overflow to avoid leaking the
 RAM content
Date: Thu,  9 Oct 2025 17:43:28 +0200
Message-ID: <20251009154328.260391-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PARP264MB5871:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da07a277-78dc-48c9-5b9e-08de074ad57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?75r3K9A4Vnh0WVOG4sYlBh97DQbmKkzGEicpq9AgC0AmiupO/ZVDqO3oQdrQ?=
 =?us-ascii?Q?V3t1dBO+PfeFSIwOHmcZDwNSxGJ+o/lcS0n1lBOnmC4hc01BJzCffEWBgFD+?=
 =?us-ascii?Q?bKwLScm55TbYKqzYwM0oj8tOOLe4ajBnLAsGnESpX/807M661EGkXyWvrD1x?=
 =?us-ascii?Q?Jsd3MCi4urH3jf6OImlN0bH1QvRQJgecz4aGQcOtHK3h3U7Af/EzpR4xdxgE?=
 =?us-ascii?Q?mzWxGE3+dnBMCCbiUdP0A+bvCb7K+Hs/UyyDoFm1iWXOB/aBIQOlk87M9sbW?=
 =?us-ascii?Q?/LjWSCd9g7g5OfGr7Lv+h08qNJMXH+1hfvqdgihfPI00f246YCIk6GxvgowV?=
 =?us-ascii?Q?M0P5/9CW3Unolr7L7RVQZa1B89z/ZoPgOkxrIT7p30CHjClJ0tlHnsWNlayn?=
 =?us-ascii?Q?NZrQL/xgm4y5iTVCp30Xn9HrD5IueFkJ0PWpqcuLgMEX/LZVLwh2+EkvsQp3?=
 =?us-ascii?Q?ZAfW3oXxLJyCu5Qp/8Jjc/s8w8MHI3iGcDwJA53e47Ql+iHAxVAn5E1mhyct?=
 =?us-ascii?Q?Tk5IesEgoSwkcQOWbFey6LjAC48MtConRc1gauiKVn6i0PDYmAEFu61lWnl8?=
 =?us-ascii?Q?mT9CDQ3ggWjP4pxQo1xfAlTWCwNPwJqZIU90vxdZBYkkvFqKJSKTAw9RCcgP?=
 =?us-ascii?Q?139BEpC6ZQOW0E8N7LT/LHX/LDaEk0OzxfM98N6I7fNfIzXJxf8MVn3nuAuu?=
 =?us-ascii?Q?ntuH6p7ImoQm2eJIdRZyOOblkl501Lx15qyNDfOgwRX0EpBx1mfAmKVIaZUS?=
 =?us-ascii?Q?9Na/cpHsxu8qQK4l/+y+DPx0fY5YMH7F3PkSD/Td417stgnePTG9ZBq+i3do?=
 =?us-ascii?Q?1rjeGYaBlppnXyYYlsfW5Blxy/iTyxHfDTh27e0V1hjfAu7KmorI6nY4VcJz?=
 =?us-ascii?Q?J05H894ywMIqGo6GX02OcllpFe+Y+Uh/ZguxuL99PQfXv19tnQyKr9wZkVQ7?=
 =?us-ascii?Q?KAVcbZ+5C4M93QagKauGRJ3bYv4hoez3D7ygP0wqJPAXQEpSxbZCOYBSCyrq?=
 =?us-ascii?Q?XmvJoaWL/ac3zVFqCfPadEiqmGIDI47UyGAR8UW01KaPh2dPJb1GTaAlhIGr?=
 =?us-ascii?Q?m+S9V2Ar8O86W5UVHZwDb5vVnz98z9JqXOntxEa2cx+YqzipCwV/kI+NEmAb?=
 =?us-ascii?Q?hZeJEcfggutPJNwBwxXZDj7zHTwlBjFPy9g40hplclpHhBVAiR/Fk6BiJOcC?=
 =?us-ascii?Q?xYesAyFSAX2GjXRCrum4Q4IGdFzqMMYYxTuYUeV2blqncJzRZgV0QjD9B5c/?=
 =?us-ascii?Q?z7kNTkR2x9zKbUprdQB9UFJ4VZhvuO74TUZsPPyCm7wQUwNZkIU9NpHlQWL3?=
 =?us-ascii?Q?NPXKYSxz84kh7dQaU07789klZPFAG+Lea4mVS3UFKv8j9c4PunC5kzaWYg+a?=
 =?us-ascii?Q?/zi6Sebh93kjX/ZndystpuNqPIa84s9lHb5K9ktOE4l7tMGE3aN0xtoj3COz?=
 =?us-ascii?Q?0ZVDaRvX7+yt+qktcMrPqWBCJFAeYTAkt5996AdffutV7adopj4cglSIIYQK?=
 =?us-ascii?Q?LPyyDHpbyIZLz5U3mlZX4uOFe+OeOsfM6e379R5QwbFp8Cy+SmzmbdvJtHD7?=
 =?us-ascii?Q?OLBOONsDYVo2m8P1MdA=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:45:12.3508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da07a277-78dc-48c9-5b9e-08de074ad57e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5871
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

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
History:
v2:
- remove useless from
- add Signed-off for Philippe Reynes

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

