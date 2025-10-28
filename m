Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9BFCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 15:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BCA9836C8;
	Tue, 28 Oct 2025 16:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iA7xWOET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8190182E34; Tue, 28 Oct 2025 16:10:22 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD2080422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4770e7062b5so20486955e9.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761664219; x=1762269019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e0uLDvhnRCy4O50PX5dh/FX3PhkFOuqHj4dkwIIH3uo=;
 b=iA7xWOETdEpOOF+A65PaVkBp6EcIpeN0OvkipyoANcJOS5BGY4uiw0LbH22zMulYgg
 USnxe2rojlw5lJF7uQMf3WYpScOWIs3IDU2cBr1CJ85WlLP7j79QQ87zJNyZ7hfqFIG1
 g9zL7Hy4ox/GpbpKzsTIRtaJcxJVW1MPuhL8VolKt6Z75EK+x3W1yVoqO5kgIln+LyPm
 nccockVevrBuCrquUatZwjw1kuIWprgH7CaqbRX2uphb6j5jumJIv5386u76EV4COCR5
 Q8zKQtlAJEbqf04ym9CUZJMZfBBYD/B3XptcIuJN5Jurlm0vhIHyxJsBpugwKCkD93/w
 D2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761664219; x=1762269019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e0uLDvhnRCy4O50PX5dh/FX3PhkFOuqHj4dkwIIH3uo=;
 b=TAFKrZo/OrroJ+wr0GLa23Ks8Hi3FLOgRBnhDEz7MFJ0sqs9z4dE0yF3aEch7gxjIq
 QzDNEa2DnEoWz1TBnGiTMEswxwqeMSYZ0ktmOzOKw/xUn0pMbsf5VAjbJPsM2clCD1u+
 4Jp5SQ8QNT14lYId2R0631peJhMsYHCDk5+be66y7AS6yBJYfcE75ovT9iqkoOA/HVLd
 XgHw4XWpCj/HspOqIO0AFY/HGA7Mzq29b1+tInzf+qiXG7btW3DFoJc6odfIE4rNZsU7
 1ULTbODGBXBShZPKdU7eedqJLpnRZNdBrMs5m2diNRtOOChkYvvk2VhiMyFVwKgtHjEO
 9V2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnBxLvZphbw23RospwbNRs8s9mrheqXYW7CtBpzcKxvsxDYO1RkHzmQLkxIetRxXaHpiFeYWc=@lists.denx.de
X-Gm-Message-State: AOJu0YxxheH/rmhFhOAeiXTCt6waqj3dcZ38e3z1ppm8SxLESbyHYgTo
 qHwJl8OiN158FglHlRs5k9qB8zcZkbr+ZWr+3cp5Wl7qKLV+SP7JlfmI
X-Gm-Gg: ASbGncu2gzunPhljKy4LGwWTe4i6BxcqGBfbDfRaTcPZ9r2KkUSXrChXle1Bu/OtM/c
 ditHOxZsp22DPbU+abI2fKls7AOcl2zRbltkCoHdoeJA9y8eqFeRiL3ZsT1pww4FRIjAFNW+eoy
 AhWKaH5GTGkHPtYeGnYlUO0zN/9RB+vpinVveg8O2DyVs9fsNcN5Z4xO8FjdiLSP0kPuD7WY4h5
 w7m6GS+ZnzXoBtcFJis7KOhNpZf2667wVr0HS0Q6SmDMPH2Jr6UqqbX6oZTc31bsn/vHn/HdTGQ
 h3wlR1YU/KhlHhZq/j/NQXU8xG8NTo9Zk2Fq8rvqsdYNDOVKDQ6uJ5g/OlrSDYepWyaVmIWse74
 nv0WiMroWiYPyDFyaPq98Fz+HV4msiTOE4hRbGtkDdRPZvVO0MPd5IUBkO0+XYD011Qnz7dJ+Tq
 gVEC0A43yHghLNPngoSKEEIbROZz8=
X-Google-Smtp-Source: AGHT+IGd6P8XGYcHIe89hFdKJTMFyuxQioOeAyBdUTttGSz2U7OudYSizh7O3k0UY6Smlh5TqsWGJw==
X-Received: by 2002:a05:600c:470b:b0:46e:32a5:bd8d with SMTP id
 5b1f17b1804b1-47717df9dc0mr38969895e9.3.1761664219113; 
 Tue, 28 Oct 2025 08:10:19 -0700 (PDT)
Received: from vitor-nb (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4783b8sm201193315e9.15.2025.10.28.08.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:10:17 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 ivitro@gmail.com
Subject: [PATCH v1] toradex: verdin-am62: sync rm-cfg with SDK 11.01.05.03
 baseline
Date: Tue, 28 Oct 2025 15:10:11 +0000
Message-ID: <20251028151012.126588-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Oct 2025 16:37:10 +0100
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

From: Vitor Soares <vitor.soares@toradex.com>

Update the resource management configuration (rm-cfg.yaml) to align
with the default configuration provided in TI's AM62xx Processor SDK
Linux version 11.01.05.03, generated using the K3 Resource Partitioning
Tool.

This matches the configuration from board/ti/am62x/rm-cfg.yaml and the
notable change is the sharing of MCU GPIO interrupts between DM R5 and
A53 cores, and reservation of an additional virtual interrupt and event
for TIFS usage.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/verdin-am62/rm-cfg.yaml | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/board/toradex/verdin-am62/rm-cfg.yaml b/board/toradex/verdin-am62/rm-cfg.yaml
index e4221f82f924..ea5f2423cf3d 100644
--- a/board/toradex/verdin-am62/rm-cfg.yaml
+++ b/board/toradex/verdin-am62/rm-cfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
-# Resource management configuration for AM62
+# Resource management configuration for AM62X
 #
 
 ---
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 960
+            resasg_entries_size: 976
             reserved: 0
     resasg_entries:
         -
@@ -285,10 +285,22 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 4
+            num_resource: 2
             type: 320
             host_id: 12
             reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
         -
             start_resource: 4
             num_resource: 4
@@ -501,13 +513,13 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 35
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 36
             reserved: 0
@@ -543,7 +555,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 627
+            num_resource: 626
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.51.0

