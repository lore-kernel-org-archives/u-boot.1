Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EB3C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9642B880E8;
	Wed, 27 Mar 2024 15:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YL6hFKnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D256880DD; Wed, 27 Mar 2024 15:15:11 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8658808F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZu59Z7EWDr5O+zkuLUcUwTFqEgLEhq8Iuh8l0T6Rm+e4FO5fXV315FciJAg4pql5VeSF6HtAPGg65JitcNL3VI9lGAMeaEWU+XRCaIL2MarMmnQB5TIC1hKGJO3g1CGq4LxRaj7q5vwmHNI7eVHG16ThDZwe2Vxy/4FT0gfm7nMY6aIdVXPBNiCkBDoJ7CzHVGgYjFvAfZCNuIWAH8qpFwSZIFqORGPWBWCfuESvysmdI5Z1YRhuAADT2wGzqQzikAJSdZhYQ4u7uz2FWiymiJu0wQbxSa8YBqyEPSotab2qvfK/mm+Idzgjo7OG4CO7q2U9P2sWVwtxjdZZcOazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7pkwGtRKKsJnMUdDAOh1dob7MIHBxD6yRmifjusUU0=;
 b=WjW+aRCq6zOiFdCmh79nkQn5pXq+9M6nzt7cOzvKgm7RyVsVjyvJ+I3MF+oI3E0VLrhoawV6MAXoMJi9I0uccuKH9Ym4rnV+WDHHbVoHRrqx/T5CwZarMVGsvvUGagn+fQ5j06wXtMTvSzSEPU0GNhWcZnLc59lVFRBnxCrw3iNvsSOhGa5vUy5RaZduIR4X/yAel4Xuom5URLyZ9U8Jx+w8yCr7BysH3plp30/DUuVUP2DqocdSOmvKMWG3NPmxB6MBoZPgDvFWiKwMReTBgWRyCN5G/MQKbsyNxTVJK8lgOnX2JMLMJ9eJA0OlB6OHrLYO8nIc/lruGZX61NgG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7pkwGtRKKsJnMUdDAOh1dob7MIHBxD6yRmifjusUU0=;
 b=YL6hFKncLDejLVNvONHjnyPOaRy4d7UsjjKAUTWUcOIyIN0w5rXQfCIDFN0Nto/QEkyFymOZcemY0DUCYcURdO4ABHCjSk6WxuyWhB5RPyTEueICp5PeJtg7o+u/7VldUag0klOmiSrr3LQvc6rQRlUw8CkEXCc4X55N2NB9Z4k=
Received: from MN2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:208:15e::23)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 14:15:06 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::db) by MN2PR17CA0010.outlook.office365.com
 (2603:10b6:208:15e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 14:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 14:15:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 09:15:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/4] zlib: Rename write variable to wnext (window write index)
Date: Wed, 27 Mar 2024 15:14:51 +0100
Message-ID: <c870c4f94764400ad450b3babe493acb0b349c79.1711548887.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711548887.git.michal.simek@amd.com>
References: <cover.1711548887.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7677; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UmBaxxZ/AhGShWt2PzU6aVuOnaNRO2QcqFuv0rabsw4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQWzfs5dndfPtzJk1h0tC74YcSTyE752cJ7mGVMp4RO8
 AnOluXoiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPZu4Jhnjbb4dfWzcU/y3ds
 SPVeXub9/dYTLob5/qcsvSXa/Do8tgXdElFarL0vseQTAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: e00d15d1-9a74-4b4c-9574-08dc4e684d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIFx7EivammeFdV2DrPnR7sfL4hknh9e0iFCbQF4mWbxd9ZUnQkGtQNmeZ7AXAnd3AWCmelk4wLC+4ugiWnMrPgXJzJxqjK0bxqBgeOBNu78GyQBiU6thlj9Ipdy11kT7NLx4Osrz1vEqtzcJDicokMygR9QWlnkckW5SUnfRNHXGkt4OKCSWbNEAukBcZPdfnYU8XHDep6D9PqoZeGEHpkp9ndDp7qcqnVLDr9T8jTXOr7qmzb6lE1trIlS7rbE5E8Pp4mHraPunSwAIWCSi1tgwn7Qn1GNdsTbt+GWfudsgp1R6LkbO9CwvVgLR8Jrifgbiiv+1Efz2qq8CmsnKH2AUiym0+7HlejjkHcW4ByiAtpEkKdO+K6C38jhSHkMPjirOoLSl5okbHtwAQZfeCZFLm0ZL0OYgckUFShpBPVZyMxegiozK1wfh7LJfr4MURebc5mJqT7QIQTHaKBNJlVZrxuoEi5kfA7vgXW5zOPYhnxSObBNGxO9LG8OBC3B82FTgO1SgADQunNdKzz8T29PIhagHvqxlWHx1NwMt26j861o5u51QK2mx1pIcJuAeI/CdHZNc4jloiaOjtNnXtWLE5/HzKzH2TpZq/LRR0ivvCuQypdAduWFlE5P840aqxZrgI2nWv5mppS1834YElGsrEe4jxjfbX1kT2Dyb8m92hhZPuyM4joCAe0sFrhYkfflRT7mcVwDuSlD3MdWdCHhsSM5zSlO5UEcCyvlU82ZINF9nCwtccgu+PIxcIlj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:15:05.8680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e00d15d1-9a74-4b4c-9574-08dc4e684d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
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

There is no particular patch/description which described the reason for
this change but it was done as the part of zlib 1.2.3.5 release done by
zlib commit d004b047838a ("zlib 1.2.3.5"). It is preparation for followup
patch.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/zlib/inffast.c | 20 ++++++++++----------
 lib/zlib/inflate.c | 22 +++++++++++-----------
 lib/zlib/inflate.h |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index d61cf0e72af4..bdaa6d0dc51f 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -80,7 +80,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 #endif
     unsigned wsize;             /* window size or zero if not using window */
     unsigned whave;             /* valid bytes in the window */
-    unsigned write;             /* window write index */
+    unsigned wnext;             /* window write index */
     unsigned char FAR *window;  /* allocated sliding window, if wsize != 0 */
     unsigned long hold;         /* local strm->hold */
     unsigned bits;              /* local strm->bits */
@@ -115,7 +115,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 #endif
     wsize = state->wsize;
     whave = state->whave;
-    write = state->write;
+    wnext = state->wnext;
     window = state->window;
     hold = state->hold;
     bits = state->bits;
@@ -201,7 +201,7 @@ void inflate_fast(z_streamp strm, unsigned start)
                         break;
                     }
                     from = window - OFF;
-                    if (write == 0) {           /* very common case */
+                    if (wnext == 0) {           /* very common case */
                         from += wsize - op;
                         if (op < len) {         /* some from window */
                             len -= op;
@@ -211,17 +211,17 @@ void inflate_fast(z_streamp strm, unsigned start)
                             from = out - dist;  /* rest from output */
                         }
                     }
-                    else if (write < op) {      /* wrap around window */
-                        from += wsize + write - op;
-                        op -= write;
+                    else if (wnext < op) {      /* wrap around window */
+                        from += wsize + wnext - op;
+                        op -= wnext;
                         if (op < len) {         /* some from end of window */
                             len -= op;
                             do {
                                 PUP(out) = PUP(from);
                             } while (--op);
                             from = window - OFF;
-                            if (write < len) {  /* some from start of window */
-                                op = write;
+                            if (wnext < len) {  /* some from start of window */
+                                op = wnext;
                                 len -= op;
                                 do {
                                     PUP(out) = PUP(from);
@@ -231,7 +231,7 @@ void inflate_fast(z_streamp strm, unsigned start)
                         }
                     }
                     else {                      /* contiguous in window */
-                        from += write - op;
+                        from += wnext - op;
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
@@ -343,7 +343,7 @@ void inflate_fast(z_streamp strm, unsigned start)
    inflate_fast() speedups that turned out slower (on a PowerPC G3 750CXe):
    - Using bit fields for code structure
    - Different op definition to avoid & for extra bits (do & for table bits)
-   - Three separate decoding do-loops for direct, window, and write == 0
+   - Three separate decoding do-loops for direct, window, and wnext == 0
    - Special case for distance > 1 copies to do overlapped load and store copy
    - Explicit branch predictions (based on measured branch probabilities)
    - Deferring match copy and interspersed it with decoding subsequent codes
diff --git a/lib/zlib/inflate.c b/lib/zlib/inflate.c
index 8f767b7b9d2d..79c9e991aa33 100644
--- a/lib/zlib/inflate.c
+++ b/lib/zlib/inflate.c
@@ -21,7 +21,7 @@ int ZEXPORT inflateReset(z_streamp strm)
     state->head = Z_NULL;
     state->wsize = 0;
     state->whave = 0;
-    state->write = 0;
+    state->wnext = 0;
     state->hold = 0;
     state->bits = 0;
     state->lencode = state->distcode = state->next = state->codes;
@@ -115,7 +115,7 @@ local int updatewindow(z_streamp strm, unsigned out)
     /* if window not in use yet, initialize */
     if (state->wsize == 0) {
         state->wsize = 1U << state->wbits;
-        state->write = 0;
+        state->wnext = 0;
         state->whave = 0;
     }
 
@@ -123,22 +123,22 @@ local int updatewindow(z_streamp strm, unsigned out)
     copy = out - strm->avail_out;
     if (copy >= state->wsize) {
         zmemcpy(state->window, strm->next_out - state->wsize, state->wsize);
-        state->write = 0;
+        state->wnext = 0;
         state->whave = state->wsize;
     }
     else {
-        dist = state->wsize - state->write;
+        dist = state->wsize - state->wnext;
         if (dist > copy) dist = copy;
-        zmemcpy(state->window + state->write, strm->next_out - copy, dist);
+        zmemcpy(state->window + state->wnext, strm->next_out - copy, dist);
         copy -= dist;
         if (copy) {
             zmemcpy(state->window, strm->next_out - copy, copy);
-            state->write = copy;
+            state->wnext = copy;
             state->whave = state->wsize;
         }
         else {
-            state->write += dist;
-            if (state->write == state->wsize) state->write = 0;
+            state->wnext += dist;
+            if (state->wnext == state->wsize) state->wnext = 0;
             if (state->whave < state->wsize) state->whave += dist;
         }
     }
@@ -823,12 +823,12 @@ int ZEXPORT inflate(z_streamp strm, int flush)
             copy = out - left;
             if (state->offset > copy) {         /* copy from window */
                 copy = state->offset - copy;
-                if (copy > state->write) {
-                    copy -= state->write;
+                if (copy > state->wnext) {
+                    copy -= state->wnext;
                     from = state->window + (state->wsize - copy);
                 }
                 else
-                    from = state->window + (state->write - copy);
+                    from = state->window + (state->wnext - copy);
                 if (copy > state->length) copy = state->length;
             }
             else {                              /* copy from output */
diff --git a/lib/zlib/inflate.h b/lib/zlib/inflate.h
index 07bd3e78a7c7..2657d611cda3 100644
--- a/lib/zlib/inflate.h
+++ b/lib/zlib/inflate.h
@@ -88,7 +88,7 @@ struct inflate_state {
     unsigned wbits;             /* log base 2 of requested window size */
     unsigned wsize;             /* window size or zero if not using window */
     unsigned whave;             /* valid bytes in the window */
-    unsigned write;             /* window write index */
+    unsigned wnext;             /* window write index */
     unsigned char FAR *window;  /* allocated sliding window, if needed */
         /* bit accumulator */
     unsigned long hold;         /* input bit accumulator */
-- 
2.44.0

