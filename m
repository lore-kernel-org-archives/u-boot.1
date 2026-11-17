Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B56606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B866umyC;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5RvoPMQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92594608C4;
	Tue, 17 Nov 2026 12:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXSLVajfdhTA; Tue, 17 Nov 2026 12:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6A226086A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794918463;
	b=TkGOjroLlSj1YB6v11FvtXjrjZzI+8F1qImvXJktfbEFxpRTqVZXC3k4CpzA8tBdGIXe
	 IkD/qLtl4ADKX5XmgsQ2JE6AatoQ8oDSxn1SJ54zJypF1raCneUIE/grhOZdnQK0AJvLH
	 ET8dQ4UDr0pUjWuYyik964Mw7TAy19tbqAOFltiMD51cUcbbRrkHmumrXHpfVtwUCDagK
	 fl2gVW/ROzA5Ec8WfchLcL3Xw851rn4el4SzyzCDCy33vYFP4XAkxcakK5cAqmEgBOhiV
	 uaFjekL7TvlZwEoGjR+FhALeNDojK8B3kAPntO5aKLCIismxMt89jzXVKh9ON9iIM+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794918463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
	b=RxdePLJxnE+BoiEpOi4pCPMMwNH3xzBEzX/DPf6VebH+DmGrkbldnapoZscn6Nq15dsT
	 iW949jVYJq2lGHIl/rDnSL89ktfJeCPzdaTzDWEzBk/idALo1XOiYEQJUakM27uZmbt0F
	 ptO9igPpQRkrBBr0XYgNIOtZ+myh7RhFN191ISsuwNz65T/bja/oMhNARytCZuMWUQOyt
	 3iv+F2vu44iDSx0y0+hy2CW5iLo0/vpAzoyXdAtLi3aRoixFJjGHGW7rDqHlI8U2XWmLi
	 LqZqP2t21igGRxgVYObp7tmV3OYCl9gT35dDaEIhfDf1PCiFSfcC4bIPFo+nrZtO+2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5RvoPMQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794918463;
	bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B866umyC2o290HdZ3v8aRUowmprs0gzDrDO2gQE9ciCw3PU/4Pv8d0VVkwqAWq0gS
	 UUQRwys0ujJkCYgJRY39zaM0ktcHzl5ceShpfDnpF6pdKcETQbt1sN/hlwuUv5w1fE
	 1kHqAedhEjhQIpF/CTroa6E9yYMQm1vhlTRJU1qldp1kq83mO+ab7kfRkqnk5ATIXb
	 NRxb9DQ74N1qPAA3BvXS4PwkQmNk2d6NvfvwXV+qINxXQibmndZajEB4d9DQpVrVqj
	 +64U+RgvfQk6+sXqBcQ3qO1JCnubSfShNQHPIHhhAQES/Cy0xatZI+0iAMCjdvKL9m
	 jGiJe+MPwTVlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6A226086A;
	Tue, 17 Nov 2026 12:27:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2ADA3105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BB2960887
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oB4g-p_MxeXk for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:27:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 05ABD608B1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=o5RvoPMQ
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05ABD608B1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:37 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso602306f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794918456; x=1795523256;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
 b=o5RvoPMQXdH+FelxuNQkygmhLFLkLLZfNByhMxHdi+lN9VrUgsFd9W7XNOTSbgjxL9
 iAOICZluYabKTAQS9a2HrVZTC7CjlJXGw59AaCK5S2/e2rLLnSpgIPYmyRm0HgAeJIXi
 K4U0I2ld9sAXbTJecl/43p6YqtFA/whnPw2wtSmWXgwatgpMFVoVXfpXC3aTLBsLkW9M
 nT1o/X/VeXhHLtT/5q2iCUYhLHfYodPGKOgeSpa0Z6/xlhQvoewq6V0Pjt5ts+eBZs9r
 OzNxkJvw74x9y4Wlvpj3IhqGmyWg9OoPO6xLH80eCt+Ar4Tsh2gFm3BaAfgi4Zyydecz
 U1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918456; x=1795523256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
 b=2l7h5XmnbLdLNY3oAKnhAxk3e+z04S9oFB6lP1fbBwMU6cnUXrizKp0H1FeGEshCiu
 CaJ/FwNy1xv3t9AIcXOV+FWpL0J7/ZDzK0rcUGOXLYnpnAAvj9L5oQIuyG/MCt+RZbO3
 15laN0VMiKBU/xZjF+amBN40ccGhlN2OSTq7ljH/IC99az+rS2N7QkDW+fko1N+yd4bx
 dc1YCPzwv3F0OkNKfZFrQwC3YvnqvkJ435QnmmgrIF3IyRZivsDimF81TWrr1qM6q32h
 99yeL3EGCwAes5ANfH/ZUgrBiEhH3eVHoqkNB5cdLvUrwi8gcVvxY3/fropO7DEXJTNX
 EPsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErElTnTjjjdA0CV7yadfCittTOLyQd7nQnCFTS1+38d8UJn/DXlEokdDVIFh6/eIDAxt7fW2cOQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9kIAtfKr3TE7TKvdMQnRoL2X88AhwhnpDqRnbuoLuUkU4wTnE/
 HmjFVrPE9e4+ydnSE+Vgf7HmSYql0BOlgKxV3Yo1MKuiZy7h1ZT0q1cA
X-Gm-Gg: AZFdTZf53Awiv6lZ8y04MVJ1Ch6g96iXodQmtMFnWKUuWwakwmRsR7vEWxTpsqTs1Fd
 UwJ/VnzlpoQaOR3aCol4hlRNz0B++37U1hEK/BeU4nYPaBsxY1Qgvy5HF8tRt57K6OHBcMNLbR9
 7977aygkSQguLtQVk1ZSGwY89A0NGE6qV2ogMfGhNTAelJT4HTsqUdrPDyn5fKsnTuEHlh2ZCDn
 9bYOo3dYP9HMOkI4DR6P3lEqcJ78kKMDydVtSL9yHPXbamRmwr+99HuBjKe5zpkUs1NQZptaPj/
 TFyrCCL0vkL/u3OMcnF2/HpLKXOTm5n5ke6Jnteue/BYNBxcqkyQiWSisM7S31RrwMxjf6eg5Lh
 CM1sC41wNIIm18vCZ9JHdisJ28RVT3ih0Z8eLaqZfc2qiw/WfR5xwfJfJq7PM6KqVz6KnBvy3Io
 6zIwhS/6NG97pyz6JEcQrGim3HB7coAkQEu5DgB4l99OjhK7uYvgBTFm11f9m/mGHoMEXSANhU9
 +bj6nxuO1pwJ0CfaRcprHRoEy1YiGKkF+ROUrwMa4pzmtlmxJmE7OCDbNAOillnAzLWmecBp/h3
 ej6Q/E0YwtTG040W71/Sfeinu6RPSQMWgIQV5e12mxTp5R38j1U7eZH0JNhHEL6B3UYlyvjwFyE
 5qAHvJYbdDxh4W0LNYOyykrTCI/0rPJkWiDU=
X-Received: by 2002:a05:6000:29cb:b0:48e:127a:c914 with SMTP id
 ffacd0b85a97d-4a372b3119fmr4015527f8f.5.1794918455853; 
 Tue, 17 Nov 2026 04:27:35 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-92-103.ip49.fastwebnet.it.
 [93.34.92.103]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm5243151f8f.34.2026.11.17.04.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:27:35 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>,
 Vincent Jardin <vjardin@free.fr>, Martin Schwan <m.schwan@phytec.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v12 7/9] doc: dtbinding: Update documentation for Generic
 Firmware loader
Date: Tue, 17 Nov 2026 13:27:12 +0100
Message-ID: <20261117122715.7983-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117122715.7983-1-ansuelsmth@gmail.com>
References: <20261117122715.7983-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update documentation for Generic Firmware loader to YAML schema,
generalize it from FS specific and add new property and example
for FIP loader.

Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/device-tree-bindings/misc/fs_loader.txt  |  48 --------
 doc/device-tree-bindings/misc/fw_loader.yaml | 112 +++++++++++++++++++
 2 files changed, 112 insertions(+), 48 deletions(-)
 delete mode 100644 doc/device-tree-bindings/misc/fs_loader.txt
 create mode 100644 doc/device-tree-bindings/misc/fw_loader.yaml

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
deleted file mode 100644
index 542be4b25a0a..000000000000
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* File system firmware loader
-
-Required properties:
---------------------
-
-- compatible: should contain "u-boot,fs-loader"
-- phandlepart: which block storage device and partition the image loading from,
-	       this property is required for mmc, usb and sata. This is unsigned
-	       32-bit array. For example phandlepart=<&mmc_0 1>, meaning use
-	       that MMC0 node pointer, partition 1.
-- mdtpart: which partition of ubi the image loading from, this property is
-	   required for ubi and mounting.
-- ubivol: which volume of ubi the image loading from, this property is required
-	  for ubi and mounting.
-
-Example of storage device and partition search set for mmc, usb, sata and
-ubi in device tree source as shown in below:
-
-	Example of storage type and device partition search set for mmc, usb,
-	sata and ubi as shown in below:
-	Example for mmc:
-	fs_loader0: fs-loader@0 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&mmc_0 1>;
-	};
-
-	Example for usb:
-	fs_loader1: fs-loader@1 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&usb0 1>;
-	};
-
-	Example for sata:
-	fs_loader2: fs-loader@2 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&sata0 1>;
-	};
-
-	Example for ubi:
-	fs_loader3: fs-loader@3 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		mtdpart = "UBI",
-		ubivol = "ubi0";
-	};
diff --git a/doc/device-tree-bindings/misc/fw_loader.yaml b/doc/device-tree-bindings/misc/fw_loader.yaml
new file mode 100644
index 000000000000..9a767ff57469
--- /dev/null
+++ b/doc/device-tree-bindings/misc/fw_loader.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/fw_loader.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot Generic Firmware Loader
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Generic firmware loader for loading images from block storage devices
+  (MMC, USB, SATA) and UBI storage.
+
+  The fs-loader loads firmware images, while the fip-loader locates a
+  Firmware Image Package (FIP), optionally at a specified byte offset
+  within the selected partition.
+
+properties:
+  compatible:
+    enum:
+      - u-boot,fs-loader
+      - u-boot,fip-loader
+
+  phandlepart:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Specifies the block storage device and partition from which the
+      image is loaded. Required for MMC, USB, and SATA devices.
+
+      The first cell is a phandle to the storage device, and the second
+      cell is the partition number.
+
+  mtdpart:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the MTD partition from which the image is loaded.
+      Required for UBI devices.
+
+  ubivol:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the UBI volume from which the image is loaded.
+      Required when loading from a UBI device.
+
+  partoffset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Byte offset within the selected partition where the FIP header
+      is located.
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - phandlepart
+
+    properties:
+      mtdpart: false
+      ubivol: false
+
+  - required:
+      - mtdpart
+      - ubivol
+
+    properties:
+      phandlepart: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: u-boot,fs-loader
+    then:
+      properties:
+        partoffset: false
+
+additionalProperties: false
+
+examples:
+  - |
+    fw_loader0: fs-loader@0 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        phandlepart = <&mmc_0 1>;
+    };
+
+  - |
+    fw_loader3: fs-loader@3 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        mtdpart = "UBI";
+        ubivol = "ubi0";
+    };
+
+  - |
+    fw_loader4: fip-loader@4 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        phandlepart = <&mmc0 0>;
+        partoffset = <0x100>;
+    };
+
+  - |
+    fw_loader5: fip-loader@5 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        mtdpart = "ubi";
+        ubivol = "bl31";
+    };
-- 
2.55.0

