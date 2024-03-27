Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5217EC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FBA880BE;
	Wed, 27 Mar 2024 15:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U35cq5xN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA926880BB; Wed, 27 Mar 2024 15:15:08 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FEC8808F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkbGLhvTT264e8IM+aYhB4hM/KCBwJ/hGbwnKdhFihUAgePajpcQdkbZRibakiUu7iynwoBahdcFB714+NudxXhe6AT5YHscBmnzbcelQ6by1vOGd3hvdVGBc6fDINiJmjMdz+GojhMi30ZLzeXURDKVe63iMY6jfZ3TcjsJr4et6SgWocwmcKj7x4UmHqf4WDsT/SZXksC+i78qOwlxv1u9K1NB2LoOwJKXvMbJeuYhXg4zWB/oyMmnu68iUglAXUf2wstMbLk1nJaQXhG+UgEt+bg0Mp2wM4r6i8aPy60kpmxSEsoFVsWE03B7cbC+zF3R3rOcOxnL/4a7MHLJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/sgJmlncKuQQ2zy8AqySWQEZOgKugWBrboqyJxAzdg=;
 b=g40ajSj34x1yOpXPX1u0rgG3m1cQ3k4Y1SJEkR5yQVa+WC4LlJdJS9fcVZonQQV7no5bAlj1j+8u6D7fB/GYA5OCuhELX0cQX9PrFHKBhy5nHqGLMqhmbUMdCP/f4SgSCjsq6OmDTnVmYZ7MRVuSYv3Z975qhlDZasnBHnIQpxstgxgpfgyB4gC07uKMHbucI0YtOUu6I/kGwF5XsSp8yBW4fDd0bkJcu9lfiO205Paz2usqw9Gy0AiKNe/PP4rSwi1lGauAInfUnSH9ajgoUBpvPK+WfJpPHmZpuVTgVHg9/SZ7cfxo+BILfaaLQX2MFnKB7NosW51c5UC14F63OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/sgJmlncKuQQ2zy8AqySWQEZOgKugWBrboqyJxAzdg=;
 b=U35cq5xNlzIBh26yhU9KMiRDK4xZr+d+DtDJRLWonFqYyftXYoYRvtAOYnFueP2c+XACqA+tTLmjLViqkHu+2uvSRK5WIKk6iPZ3IQPVj+BOR8+eftlHPQ57LM7axzPpnksCQbkpYVX26IGiySvfPLVi6qw7ENAWpfIF6hqYHtk=
Received: from BLAPR03CA0070.namprd03.prod.outlook.com (2603:10b6:208:329::15)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 14:15:03 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::d8) by BLAPR03CA0070.outlook.office365.com
 (2603:10b6:208:329::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 14:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 14:15:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 09:15:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] zlib: Rename this variable to here (current decoding
 table entry)
Date: Wed, 27 Mar 2024 15:14:50 +0100
Message-ID: <37b3beb34aeb6b1f03ced7509fe3d7262d2406ce.1711548887.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711548887.git.michal.simek@amd.com>
References: <cover.1711548887.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4097; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=s5l0xEKW1Der3W2q3r/EGYHLFEQLRl1FJ9uOSLN8Ry0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQWzXt9KQVP1xm5RXF0L1PbuI594hPZjfte5iyMFFI7K
 CupHne2I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkPophDh+j6qw5wnd0bn+z
 ePzx74Wt9aIb7jHMd+8/EsLKteDcrWIppxD5cz05Udu9AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da3e1ba-303c-4399-aeab-08dc4e684ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/JC0i1hwrbLZNDD4FKu0p2WuWCVkuHa6JGMXRaWvcJmPiK8n37OgqEw79HsPJBUHvTPfqyfmQlK/k1z6xNrfoaSriYhyLHCZtIqrh67rlAJrqvTSthSM+8uopVnpjfCBz++9eeCmLRWYEijILfvs6grQycdZfDf2oXdL9A4p6zT+W23faZDqFdsITKuFz6igGPW8qFmYSL8kxuaPOwtHlK81n4XqGN4ywTckErR1LKjCBtZyP+li4wpKbPR1lgC9MNvKqGCM/gj8OoDk8UNXTdVmlaJESWe+RgKJHR+98dtijxVyGTwZXTQjvWDWOAKb6cpcAwsBriffPbdwKDnOLjb+s243fWqcbYE4fQITVj9NKFNqxqZ8k1IQc0VYs3rJ6NPPcHkcFnyikU48bNPxf5hPc7Ouipm6lM2LcruBZQTRbe9tRHqleJU15cXzeGWEmfp5F+b88nIYK9uhHZs+M7Ay+CsfFP5ERapPA38oFSFFH44RDbF3dAikljHGuYq3LixfbkqXkjVzhnisGUf/Cm1jodb/WkCAKbAApKz7z1wGrZM584imle4jZtk4HliF52DLQ2Qsz50FGKPPPygwANxZ/wjbo682CBnV8PPfJsEgxek0JoGEYIn8NkTy/Q79JkwkJocHBqcmQV8hmRLLyh+/AtPKwPSILtT2dFo5YADfhFffILfD39n9IGxDtdEuxbFA81da31fOcBHlI2XMj5ql9mOYUsWgwN9KawFGwjFMUVH8y5ixW3slh3aLKz/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:15:03.1817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da3e1ba-303c-4399-aeab-08dc4e684ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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
zlib commit 639be997883d ("zlib 1.2.3.3") It is preparation for followup
patch.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/zlib/inffast.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index e3c7f3b892bb..d61cf0e72af4 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -88,7 +88,7 @@ void inflate_fast(z_streamp strm, unsigned start)
     code const FAR *dcode;      /* local strm->distcode */
     unsigned lmask;             /* mask for first level of length codes */
     unsigned dmask;             /* mask for first level of distance codes */
-    code this;                  /* retrieved table entry */
+    code here;                  /* retrieved table entry */
     unsigned op;                /* code bits, operation, extra bits, or */
                                 /*  window position, window bytes to copy */
     unsigned len;               /* match length, unused bytes */
@@ -133,20 +133,20 @@ void inflate_fast(z_streamp strm, unsigned start)
             hold += (unsigned long)(PUP(in)) << bits;
             bits += 8;
         }
-        this = lcode[hold & lmask];
+        here = lcode[hold & lmask];
       dolen:
-        op = (unsigned)(this.bits);
+        op = (unsigned)(here.bits);
         hold >>= op;
         bits -= op;
-        op = (unsigned)(this.op);
+        op = (unsigned)(here.op);
         if (op == 0) {                          /* literal */
-            Tracevv((stderr, this.val >= 0x20 && this.val < 0x7f ?
+            Tracevv((stderr, here.val >= 0x20 && here.val < 0x7f ?
                     "inflate:         literal '%c'\n" :
-                    "inflate:         literal 0x%02x\n", this.val));
-            PUP(out) = (unsigned char)(this.val);
+                    "inflate:         literal 0x%02x\n", here.val));
+            PUP(out) = (unsigned char)(here.val);
         }
         else if (op & 16) {                     /* length base */
-            len = (unsigned)(this.val);
+            len = (unsigned)(here.val);
             op &= 15;                           /* number of extra bits */
             if (op) {
                 if (bits < op) {
@@ -164,14 +164,14 @@ void inflate_fast(z_streamp strm, unsigned start)
                 hold += (unsigned long)(PUP(in)) << bits;
                 bits += 8;
             }
-            this = dcode[hold & dmask];
+            here = dcode[hold & dmask];
           dodist:
-            op = (unsigned)(this.bits);
+            op = (unsigned)(here.bits);
             hold >>= op;
             bits -= op;
-            op = (unsigned)(this.op);
+            op = (unsigned)(here.op);
             if (op & 16) {                      /* distance base */
-                dist = (unsigned)(this.val);
+                dist = (unsigned)(here.val);
                 op &= 15;                       /* number of extra bits */
                 if (bits < op) {
                     hold += (unsigned long)(PUP(in)) << bits;
@@ -297,7 +297,7 @@ void inflate_fast(z_streamp strm, unsigned start)
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
-                this = dcode[this.val + (hold & ((1U << op) - 1))];
+                here = dcode[here.val + (hold & ((1U << op) - 1))];
                 goto dodist;
             }
             else {
@@ -307,7 +307,7 @@ void inflate_fast(z_streamp strm, unsigned start)
             }
         }
         else if ((op & 64) == 0) {              /* 2nd level length code */
-            this = lcode[this.val + (hold & ((1U << op) - 1))];
+            here = lcode[here.val + (hold & ((1U << op) - 1))];
             goto dolen;
         }
         else if (op & 32) {                     /* end-of-block */
-- 
2.44.0

