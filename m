Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E05EE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D6EE87061;
	Mon, 21 Aug 2023 20:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SuFbwGzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBABA87060; Mon, 21 Aug 2023 20:02:55 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A897687047
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34cacab5e34so4096605ab.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692640971; x=1693245771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfhGWQLobKgWsMuweTKDotxtPEgMiW0frCVlWnHWO+o=;
 b=SuFbwGzBQd6dncU9Qd6igCgwTyiZNwlOvoBON/+gDyxTM8mI8/HStow62YfpXU+/aM
 2HwZffOy7ZWiPldHBROekVhyWUtZmlg55PvIR8TybrXh6D/8HUo0zoDD2aa6HXg5t8vv
 FzDkvcA1BN7WxYhFnCIIOcj/Y2rc8/FJZAj/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692640971; x=1693245771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfhGWQLobKgWsMuweTKDotxtPEgMiW0frCVlWnHWO+o=;
 b=dl0S0/cn9N9+m7PDneuXdSHAFeOeSp2yJWu8NrO/YnOgWFdb6Iuxcg0wvcxWg2cQCe
 3py17Lga3FiVwR86olRmUzs3CocuHxdU9MroEOogw+ao8p/kcLefhQfUtCPhRsqXNQAF
 7hQk6kTLZ6bKIE3bbLOV1kVqWmVRuufXAcFi9wWKuuEtM+BxZvRr37LfUv1u5Bs/tnKw
 w072JR8HyMYtdZqMZpCX+OCeeICP95DzJX2yzpcCHtTLI3J2t2R+rcXGPvXCDDRhcJY8
 4eoOkxtbMH6UvxGUB4tyJyjhsm8p2hJS82E0aUYJVhqNk4h7G3Muc8+qhMBAh+Rv5gnN
 5Bew==
X-Gm-Message-State: AOJu0YxUXCKZF/HoMBfl4rvOsFHws+SagGgHql6lucpwzNR9R0d6Gi0P
 tT3TNgdy8YYJT17exG9v/cRmNg==
X-Google-Smtp-Source: AGHT+IElWU6dSagVaMArdUWj/kycSgihKiuVnYe8/x4SdolnqJdLSIzeYJxGEia+OYZ01HZqa3bJSw==
X-Received: by 2002:a5d:8d05:0:b0:791:7e14:4347 with SMTP id
 p5-20020a5d8d05000000b007917e144347mr8322642ioj.13.1692640971299; 
 Mon, 21 Aug 2023 11:02:51 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9102:8976:7620:5093])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a5ec745000000b007791e286fdbsm2583924iop.21.2023.08.21.11.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:02:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Rob Herring <robh@kernel.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/3] schemas: Add firmware node schema
Date: Mon, 21 Aug 2023 12:01:16 -0600
Message-ID: <20230821180220.2724080-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230821180220.2724080-1-sjg@chromium.org>
References: <20230821180220.2724080-1-sjg@chromium.org>
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

Add a motivation and purpose for this new proposed node.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 dtschema/schemas/firmware.yaml | 83 ++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 dtschema/schemas/firmware.yaml

diff --git a/dtschema/schemas/firmware.yaml b/dtschema/schemas/firmware.yaml
new file mode 100644
index 0000000..4439a70
--- /dev/null
+++ b/dtschema/schemas/firmware.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-clause
+# Copyright 2023 Google LLC
+#
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /firmware Node
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  The '/firmware' node does not represent a real device, but serves as a place
+  for recording information about the main firmware used on the device, such as
+  a map of its contents. This is used by the Operating System (OS), user space
+  programs and possibly other firmware components. Data in the '/firmware' node
+  does not itself represent the hardware.
+
+  Properties in this node should be common to (and used by) at least two
+  firmware projects, such as U-Boot and TF-A. Project-specific subnodes can be
+  used for properties which are specific to a single project.
+
+  Purpose of '/firmware' node
+  ---------------------------
+
+  Firmware has traditionally been fairly opaque to the OS, with the OS taking
+  no interest in its contents, version, layout or how it might be updated. This
+  is less than ideal, since firmware is an important part of the system and
+  visibility into its operation is every bit as important as visbility into the
+  OS and user-space programs within the system.
+
+  The traditional approach has been to let firmware deal with firmware, and the
+  OS deal with everything else. Updating firmware has been handled by firmware.
+  For example, the UEFI spec defines a way for the OS to post a 'capsule' which
+  is discovered next time the system boots, permitting firmware updates. But
+  firmware updates in firmware are highly problematic. They require a reboot
+  and a sometimes-lengthy wait with a strange-looking interface unfamiliar
+  to most users. It seems better to make the update as transparent as possible
+  to the user. As an example of that, ChromeOS has full knowledge of the
+  firmware version and layout, updates it in the background from user space and
+  instantly selects the new firmware when the user reboots or logs out.
+
+  A common objection to considering the system holistically is that some parts
+  of the system are inaccessible to the OS, such as a secure enclave. However
+  this does not preclude providing visibility into what is present in that
+  enclave. Firmware-version information is still useful. Firmware updates are
+  still needed and can still be initiated from user space.
+
+  Another objection is that firmware should provide an interface to the OS,
+  while keeping its structure private. This thinking is largely driven by
+  extrapolating from how firmware has been handled in the 'BIOS' days.
+  It should be considered a degenerate case rather than the norm. As complexity
+  increases, it creates an artificial boundary between two pieces of the whole.
+  Mechanisms then need to be invented to cross this unnecessary chasm. An
+  example of this is Intel's Dynamic Platform and Thermal Framework (DPTF),
+  which consists of user-space, OS and firmware components all working towards
+  a shared goal. We need a standard description of these cross-system pieces.
+
+  In order to 'teach the OS about firmware', we need a place to put this
+  information. That is the purpose of this node.
+
+  In an Open Source world the entire model of firmware needs to adjust to be
+  more open, more visible and managed just like any other part of the system.
+  The major goal is to standardise how firmware is presented to the OS and user
+  space, so that common utilities can be used to manage the entire system,
+  including the firmware. For example, fwupd can look in this node for
+  information on how to update the firmware, similar to how VBE works. [1]
+  It is likely that other purposes will come to light over time.
+
+  [1] https://github.com/fwupd/fwupd/tree/main/plugins/vbe
+
+properties:
+  $nodename:
+    const: firmware
+
+  "#address-cells": true
+  "#size-cells": true
+
+additionalProperties:
+  type: object
-- 
2.42.0.rc1.204.g551eb34607-goog

