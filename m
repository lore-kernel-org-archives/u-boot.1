Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94E4E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F9648972C;
	Mon,  9 Dec 2024 17:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GlUMWQND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1A2889712; Mon,  9 Dec 2024 17:29:03 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4637B89490
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8418ecda128so200348839f.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761735; x=1734366535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pj2EEQBCnt79/hv0lP52EIOSEZqAN0np5MhJSOFmf28=;
 b=GlUMWQNDrojFb+L72z0RFZ63pN7S0/t1uwM5J4DrtKPLNJgwdYRIg8xjrdkRbE44PU
 B0nd8pOIWidDtx27UH8tugDYoGzCdLCQnDxZqduy4NGhJynSufajdPDEnMf9DjosHi6U
 ZpOp0cmeT3mlDuDqs+486L4XcfRGKRUPF/lD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761735; x=1734366535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pj2EEQBCnt79/hv0lP52EIOSEZqAN0np5MhJSOFmf28=;
 b=mLle9tn2UhaArnH4zbHn+sZtNPkyN2KUOU1kYI1GY6SxYWgER0NvJ3/i5jvQl9x2YK
 QlCCSyLjlpLKikR0qOFexOSf0aTz6lgo6aUpGC3sLEnCWcY929478CfkTp3nDzFyOSRi
 A6mlCuvr+8U2d1ZprUAqSML+KtUWEuBwToSlWgGBFFSzRaJXGgKzzOipK50i+TYbHUmQ
 hqcp/5nx81qYKtr92HIwaIGSVEYRgMreidTC6066tSsp4iX/Esjm5bB7Nxg4B6LRGBdr
 vKRO0HWKsnGLBAMxtDPJvaFhv2icKXcFyKoIlcOREbqaMMCmDvPZ3Qa10Tdrl98/kOJf
 kyMg==
X-Gm-Message-State: AOJu0Yw5L/wSy8c2CHxNUorvitmuzrBKwcmAaw1YnwFQks24CZtavn2k
 q7BlmCKrdKOt+A/Rsm/K1OBklNaBhRtrFo2v90cJHj+poavqT/7BypIr/Ent+F3In2xxjmebs88
 =
X-Gm-Gg: ASbGncvoRDhiMCNgWR5TFf13dFzcYRWgdgVs6ZgwxnYb8bZsCJxtmfqlZaPJ+nD3dxd
 4dinvEtyUSxIQpy92h8NQaHf2gRC3BUh/cYpIyWd8vfoiEzhL71AMZ+B9oDAsPhL/of8cNE2LPH
 3kFixDtUbMromU1EQvi2swTf4H6Qd2qcPVIgFNBPZGgifm9687s36UMGx331znUprPP90j6mKTn
 NAXDFM2Fb2JQ9yeQNlQerUbz9F77sXY4CLsL+QtUKZevf+rjj6QOXf1SPqCKDNLgTTXLrC93gji
 o9om+IjY19s=
X-Google-Smtp-Source: AGHT+IGP/zR7O0sLVbXzt33CChob6nDG8E+6WP4bNGGRjw00MgQRj4XLPnzdINeqv/ejqXgtS/7MEg==
X-Received: by 2002:a05:6602:15ca:b0:83a:b79c:66b6 with SMTP id
 ca18e2360f4ac-8447e1fdd82mr1671322139f.2.1733761735070; 
 Mon, 09 Dec 2024 08:28:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:28:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>, Wang Jie <dave.wang@rock-chips.com>
Subject: [PATCH 3/8] doc: test: Add docs and test for part_find
Date: Mon,  9 Dec 2024 09:27:56 -0700
Message-Id: <20241209162801.288363-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209162801.288363-1-sjg@chromium.org>
References: <20241209162801.288363-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add some documentation and a test for this new command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/usage/cmd/part_find.rst | 119 ++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst         |   1 +
 test/cmd/Makefile           |   1 +
 test/cmd/part_find.c        |  42 +++++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 doc/usage/cmd/part_find.rst
 create mode 100644 test/cmd/part_find.c

diff --git a/doc/usage/cmd/part_find.rst b/doc/usage/cmd/part_find.rst
new file mode 100644
index 00000000000..fd5bd6578d5
--- /dev/null
+++ b/doc/usage/cmd/part_find.rst
@@ -0,0 +1,119 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: part_find (command)
+
+part_find command
+=================
+
+Synopsis
+--------
+
+::
+
+    part_find <uuid>
+    part_find self
+
+Description
+-----------
+
+The `part_find` command is used to find a partition with a given type GUID. When
+it finds one, it sets the target_part environment variable to the corresponding
+``interface dev:part`` string.
+
+uuid
+    Universally Unique Identifier (UUID) to search, expressed as a string
+
+self
+    This is only permitted in the EFI app. It indicates that the required
+    partition is the one from which the app was started.
+
+Example
+-------
+
+This shows searching for an EFI system partition and looking at the files on
+that partition::
+
+    => host bind 1 mmc5.img
+    => part list host 0
+
+    Partition Map for host device 0  --   Partition Type: EFI
+
+    Part    Start LBA       End LBA         Name
+            Attributes
+            Type GUID
+            Partition GUID
+    1     0x0000202f      0x0000282e      ""
+            attrs:  0x0000000000000000
+            type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
+                    (data)
+            guid:   6b1e51e3-427c-9f45-a947-e467b7216356
+    2     0x0000002d      0x0000082c      ""
+            attrs:  0x0000000000000000
+            type:   fe3a2a5d-4f32-41a7-b725-accc3285a309
+                    (cros-kern)
+            guid:   dece619f-4876-e140-a6c9-8c208a0c9099
+    3     0x0000202e      0x0000202e      ""
+            attrs:  0x0000000000000000
+            type:   3cb8e202-3b7e-47dd-8a3c-7ff2a13cfcec
+                    (cros-root)
+            guid:   078cee87-a195-ae4c-a974-8ba3a3d783b3
+    4     0x0000082d      0x0000102c      ""
+            attrs:  0x0000000000000000
+            type:   fe3a2a5d-4f32-41a7-b725-accc3285a309
+                    (cros-kern)
+            guid:   08d2f20f-d941-fc43-96f6-948931289d71
+    5     0x0000202d      0x0000202d      ""
+            attrs:  0x0000000000000000
+            type:   3cb8e202-3b7e-47dd-8a3c-7ff2a13cfcec
+                    (cros-root)
+            guid:   0b23ba00-a11c-ed4e-8b49-5e8738899569
+    6     0x00000029      0x00000029      ""
+            attrs:  0x0000000000000000
+            type:   fe3a2a5d-4f32-41a7-b725-accc3285a309
+                    (cros-kern)
+            guid:   6d8158a8-f82d-0d4d-8983-a3ada4eb9b73
+    7     0x0000002a      0x0000002a      ""
+            attrs:  0x0000000000000000
+            type:   3cb8e202-3b7e-47dd-8a3c-7ff2a13cfcec
+                    (cros-root)
+            guid:   76e8f9b0-7db7-3844-8f18-21de93485211
+    8     0x0000102d      0x0000182c      ""
+            attrs:  0x0000000000000000
+            type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
+                    (data)
+            guid:   071dfd2d-173c-f64b-9474-3318665e1d24
+    9     0x0000002b      0x0000002b      ""
+            attrs:  0x0000000000000000
+            type:   2e0a753d-9e48-43b0-8337-b15192cb1b5e
+                    (cros-rsrv)
+            guid:   b9d078c3-bafa-cd48-b771-a0aaa18d5008
+    10     0x0000002c      0x0000002c      ""
+            attrs:  0x0000000000000000
+            type:   2e0a753d-9e48-43b0-8337-b15192cb1b5e
+                    (cros-rsrv)
+            guid:   7b0c0234-1a29-0c4f-bceb-40fae8f7b27c
+    11     0x00000028      0x00000028      ""
+            attrs:  0x0000000000000000
+            type:   cab6e88e-abf3-4102-a07a-d4bb9be3c1d3
+                    (cros-fw)
+            guid:   aced715d-cd1f-394a-9e3e-24b54a7b1472
+    12     0x0000182d      0x0000202c      ""
+            attrs:  0x0000000000000000
+            type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
+                    (system)
+            guid:   e1672afd-75ee-d74e-be95-8726b12b5e74
+    => part_find c12a7328-f81f-11d2-ba4b-00a0c93ec93b
+    => print target_part
+    target_part=host 0:c
+    => ls $target_part
+                EFI/
+
+    0 file(s), 1 dir(s)
+
+
+Return value
+------------
+
+The return value $? is set to 0 (true) if the command succeeds. If no partition
+could be found, the return value $? is set to 1 (false).
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 71970d5f2b3..64fb91bc5a6 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -95,6 +95,7 @@ Shell commands
    cmd/mtrr
    cmd/panic
    cmd/part
+   cmd/part_find
    cmd/pause
    cmd/pinmux
    cmd/printenv
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 583e7c2eec4..dfc49af7bf3 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_CMD_LOADM) += loadm.o
 obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
 obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
 obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
+obj-$(CONFIG_CMD_PART_FIND) += part_find.o
 ifdef CONFIG_CMD_PCI
 obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
 endif
diff --git a/test/cmd/part_find.c b/test/cmd/part_find.c
new file mode 100644
index 00000000000..1663d4a654f
--- /dev/null
+++ b/test/cmd/part_find.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for 'part_find' command
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <dm/test.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+/* Test 'part_find' command */
+static int cmd_test_part_find(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	ofnode root, node;
+
+	/* Enable the requested mmc node since we need a second bootflow */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, "mmc5");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	ut_assertok(device_probe(dev));
+
+	ut_assertok(env_set("target_part", NULL));
+	ut_assertok(run_command("part_find c12a7328-f81f-11d2-ba4b-00a0c93ec93b", 0));
+	ut_assert_console_end();
+	ut_asserteq_str("mmc 5:c", env_get("target_part"));
+
+	ut_asserteq(1, run_command("part_find invalid", 0));
+	ut_asserteq_str("mmc 5:c", env_get("target_part"));
+
+	ut_assert_console_end();
+
+	return 0;
+}
+CMD_TEST(cmd_test_part_find, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
-- 
2.34.1

