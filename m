Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E98CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E2384C81;
	Fri,  8 May 2026 10:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QzTNetVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99F284C7E; Fri,  8 May 2026 10:52:22 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B442D84C19
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so1543509f8f.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778230339; x=1778835139; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cySkP88TA/A2UzYD/RNT91GN8TWBJvePcKWTEuiqWl4=;
 b=QzTNetVaZrecxQ4dMY8gv45B0SqbWkNkGk680/vOWzWw1JDFLYcB7a30fqS44UgMBB
 0tkVJOSrX4IZY2uhxH4AvKETYAbsEk8xUipv1XMK+zVGpeh4Dl/2hW+ngHx/gtjAlTB6
 CoClpLeKm7sK+gu6kyfnHF37y8OUwXwyBbbFaJ74j65O6zxlgrMyZWSrmzVXuAoZ+uPj
 DOQ7WRMTjKmmn2YaG6pAtPcsq/v6cM5fpEQVIlWk6I9IGbWghEkTLAWjx00/B9H47riF
 XzXVNsGKp6sn70qLHdnnFayKKoirZwhbI7vuipDfNmwH3wlE99CjhEy0kXuk+AhJsvuh
 oHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778230339; x=1778835139;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cySkP88TA/A2UzYD/RNT91GN8TWBJvePcKWTEuiqWl4=;
 b=HVTYZCWrfmZTFHAvR7Hqsms6VWI87S8S2XyDkjow+ZL2S5TTfzwFHkJR7t/39q8FFc
 GexcQ7IGNsdurW7atWhQ2/583Q2mkGebew/OVUZgGmQvc9KeqCRGhYBrybIdKRfb3ruk
 KCzDm7QVS1GnWg2JrpeqQ7KnAFdo0yvBfC5K71WdDaAFextmSEaeHXvremt9AIezRfcG
 tikT0As+796jK6FZ3WwhLeHvF3qo48OZLSEkMSerFBNjnnW3J26Xkr7I8T88R7vrAge3
 VmyjIaM72a22klEzbAe7VsK1VkZrQE7BHg9g9RYBBxZ0S/kWNNIr37no728Ohe0IMuaE
 b+eg==
X-Gm-Message-State: AOJu0YxmfmsYAXmk+zgvbuke2L3+04XRBn7eEDkyZmrmoQCHm1mTQOkz
 BmFYV0Sop590spFCU5JEyRLuc2LlcqBEXVlMSw8BXn6yghl5hhrTqBGHcdlYgnGPu0W5VQ==
X-Gm-Gg: Acq92OEK+55/7FUK17aV7u5l2uvbDyRLGQqBmgXxwBRLZ2RSFI5OrWl9xJkmoG4XdFD
 rrHpfuyoVKUx5a4n68KpwZQQyrPiMpasRIHTVkvIBrvEL6ICZcumUrcd9WOBMynJVxK7Unbod3r
 +dzr/YB2dtG8J9S9QaKgsrd+Mhnk334eOrbTIvR7o0uYrWoMMw+kNPLHqnYnTJS4cpVzvtnCGpn
 HZw30rFE8Yj3jRXM5vlN6QidhGthssgBmmVJRCHKYQQGWaOFgXubcllEn7T4O+/PTv9w28tmiXo
 H2mcsr0osFSYePE3oVLEYRk9RJlJl8eawBNeQbyiaeL25vqmRmHpqac3d7cDx1c/JYNaH9XQizi
 qFXSgk8i4QROeB5dvPkhPQxBcLKGbjGsR0ywjgjDqVCV6Zwee35v8OQfmZH30kxMOrT0hH9t+xe
 RTlthwcEquN9Sz/QBAuDr4+PDRpZWZACcm7T/hfloqEvfcHgm7nLx87l0W4i6zobbYJ5xWinBkU
 LvV8bfUpVYanaKNy00wcnvgnxk=
X-Received: by 2002:a05:6000:4381:b0:441:247a:e98e with SMTP id
 ffacd0b85a97d-4515ce1c738mr18557953f8f.24.1778230338610; 
 Fri, 08 May 2026 01:52:18 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a5b65sm2676777f8f.8.2026.05.08.01.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 01:52:18 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Fri, 08 May 2026 10:52:09 +0200
Subject: [PATCH 1/4] board: toradex: verdin-am62p: update tifs-rm-cfg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-v1-update-rm-cfg-v1-1-ec9d033f8ec1@toradex.com>
References: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
In-Reply-To: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
To: u-boot@lists.denx.de, Sparsh Kumar <sparsh-kumar@ti.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bryan Brattlof <bb@ti.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

TI updated rm-cfg for v11.02.09 of the TIFS firmware. [1]

Refresh the tifs-rm-cfg.yaml as well, with version V12.00.00 of
k3-resource-partition, so that it remains in sync with rm-cfg.yaml.

rm-cfg.yaml was also updated with V12.00.00 of the tool and noted to
have no changes.

[1] commit a66704e9a18b ("board: toradex: verdin-am62p: rm-cfg: Update rm-cfg to reflect new resource reservation")

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 board/toradex/verdin-am62p/tifs-rm-cfg.yaml | 1476 ++++++++++++++-------------
 1 file changed, 762 insertions(+), 714 deletions(-)

diff --git a/board/toradex/verdin-am62p/tifs-rm-cfg.yaml b/board/toradex/verdin-am62p/tifs-rm-cfg.yaml
index 80269748057f..73efceafc754 100644
--- a/board/toradex/verdin-am62p/tifs-rm-cfg.yaml
+++ b/board/toradex/verdin-am62p/tifs-rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62P
 #
@@ -9,231 +9,231 @@
 tifs-rm-cfg:
     rm_boardcfg:
         rev:
-            boardcfg_abi_maj : 0x0
-            boardcfg_abi_min : 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
         host_cfg:
             subhdr:
                 magic: 0x4C41
-                size : 356
+                size: 356
             host_cfg_entries:
-                - #1
+                -  # 1
                     host_id: 12
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #2
+                -  # 2
                     host_id: 30
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #3
+                -  # 3
                     host_id: 36
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #4
+                -  # 4
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #5
+                -  # 5
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #6
+                -  # 6
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #7
+                -  # 7
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #8
+                -  # 8
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #9
+                -  # 9
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #10
+                -  # 10
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #11
+                -  # 11
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #12
+                -  # 12
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #13
+                -  # 13
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #14
+                -  # 14
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #15
+                -  # 15
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #16
+                -  # 16
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #17
+                -  # 17
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #18
+                -  # 18
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #19
+                -  # 19
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #20
+                -  # 20
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #21
+                -  # 21
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #22
+                -  # 22
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #23
+                -  # 23
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #24
+                -  # 24
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #25
+                -  # 25
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #26
+                -  # 26
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #27
+                -  # 27
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #28
+                -  # 28
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #29
+                -  # 29
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #30
+                -  # 30
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #31
+                -  # 31
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #32
+                -  # 32
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
@@ -244,684 +244,732 @@ tifs-rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 904
+            resasg_entries_size: 968
             reserved: 0
     resasg_entries:
         -
-                start_resource: 0
-                num_resource: 18
-                type: 1677
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1677
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 6
-                type: 1677
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 57
-                num_resource: 18
-                type: 1678
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 75
-                num_resource: 5
-                type: 1678
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 75
-                num_resource: 5
-                type: 1678
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 80
-                num_resource: 2
-                type: 1678
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 32
-                num_resource: 12
-                type: 1679
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 50
-                num_resource: 2
-                type: 1679
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 52
-                num_resource: 5
-                type: 1679
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1696
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1696
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 6
-                type: 1696
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1697
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 5
-                type: 1697
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 5
-                type: 1697
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 2
-                type: 1697
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 12
-                type: 1698
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1698
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 5
-                type: 1698
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5
-                num_resource: 35
-                type: 1802
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 35
-                type: 1802
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 35
-                type: 1802
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 168
-                num_resource: 8
-                type: 1802
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 29
-                type: 1807
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4608
-                num_resource: 99
-                type: 1808
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5120
-                num_resource: 24
-                type: 1809
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5632
-                num_resource: 51
-                type: 1810
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 6144
-                num_resource: 51
-                type: 1811
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8192
-                num_resource: 32
-                type: 1812
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8704
-                num_resource: 32
-                type: 1813
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9216
-                num_resource: 32
-                type: 1814
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9728
-                num_resource: 25
-                type: 1815
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10240
-                num_resource: 25
-                type: 1816
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10752
-                num_resource: 25
-                type: 1817
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11264
-                num_resource: 25
-                type: 1818
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11776
-                num_resource: 25
-                type: 1819
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 12288
-                num_resource: 25
-                type: 1820
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1936
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1936
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1936
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 32
-                type: 1937
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 32
-                type: 1937
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 51
-                num_resource: 32
-                type: 1937
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 51
-                num_resource: 32
-                type: 1937
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 83
-                num_resource: 8
-                type: 1938
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 91
-                num_resource: 8
-                type: 1939
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 99
-                num_resource: 10
-                type: 1942
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 112
-                num_resource: 3
-                type: 1942
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 115
-                num_resource: 3
-                type: 1942
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 6
-                type: 1943
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 6
-                type: 1943
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 124
-                num_resource: 10
-                type: 1943
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 124
-                num_resource: 10
-                type: 1943
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1944
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1945
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1946
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1947
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1955
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1955
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1955
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 4
-                type: 1956
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 4
-                type: 1956
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 4
-                type: 1956
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 4
-                type: 1956
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 27
-                num_resource: 1
-                type: 1957
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 28
-                num_resource: 1
-                type: 1958
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1961
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1961
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1961
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1962
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1962
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1962
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 6
-                type: 1964
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 6
-                type: 1964
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 25
-                num_resource: 10
-                type: 1964
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 25
-                num_resource: 10
-                type: 1964
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 1
-                type: 1965
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1966
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 21
-                num_resource: 1
-                type: 1967
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1968
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 1
-                type: 1969
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1970
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 1
-                type: 1971
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1972
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 2112
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 2122
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 6
-                type: 12750
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 6
-                type: 12769
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 8
-                type: 12810
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 3072
-                num_resource: 6
-                type: 12826
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 3584
-                num_resource: 6
-                type: 12827
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 6
-                type: 12828
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 1676
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1676
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1676
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 1676
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 75
+            num_resource: 5
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 75
+            num_resource: 5
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 5
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 1695
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1695
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1695
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 1695
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 5
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 5
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 5
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 35
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 35
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 35
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 25
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 25
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 25
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 25
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 25
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 25
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 32
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 32
+            type: 1937
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
+            type: 1937
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 6
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 6
+            type: 1943
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
+            type: 1943
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 4
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 4
+            type: 1956
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
+            type: 1956
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 6
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 6
+            type: 1964
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
+            type: 1964
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 6
+            type: 12826
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 6
+            type: 12827
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 6
+            type: 12828
+            host_id: 128
+            reserved: 0

-- 
2.43.0

