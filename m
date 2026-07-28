Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98974C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 16:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F173540A32;
	Tue, 28 Jul 2026 16:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5NZYJ_0YvCH; Tue, 28 Jul 2026 16:37:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2656C40A28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785256627;
	bh=XSEIBFPq+c2YH7UM9qdq+fsS7wcJ0SPl1AcGCsVtDhE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IstC+vsyMyS877hanam37zf9icP+z2+yInxEd+RIrFLKlJ1IgGvU2QunI01tttkrI
	 PLmi8vkreMrKxHJteawzQNo2nk7YQKQhhiblQ6BtEwqofkaB6uaLAxNg9cgzpipcsz
	 1Iovbowd8Ntzq7Ge1OECG8FmjWWojy89RS3doeKaAccSW+JvHQI4ShM6pa7Kk+WGlS
	 lubLUdE7RTz13+25npXsBmHvrdj96B9hKuMP8OKjdeNEbk3i/iqC6XWXFFRtuocV3o
	 uRV1d0vNdhySj+YvAol1wDZetaf48qv3sJwZwZ7TAixRg0KV8sujeReynIet1IMZe4
	 pRj0e5pW3+39Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2656C40A28;
	Tue, 28 Jul 2026 16:37:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC1AB26C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C947940A28
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:37:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VH40GsRUxCPQ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 16:37:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BE85940A14
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE85940A14
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE85940A14
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:37:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 722688493F; Tue, 28 Jul 2026 18:37:02 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 318788404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 18:37:00 +0200 (CEST)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8143daf89c7so941157b3.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 09:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785256618; x=1785861418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSEIBFPq+c2YH7UM9qdq+fsS7wcJ0SPl1AcGCsVtDhE=;
 b=EC5T2hOWYq/vgNuizyg8XRx0y1irnSYRQBmF2gQqhHsKVBOniAG4FEk9IMkSV7R2rZ
 IP4JA3ugIlQzhGRIcIZgaIDg594Tueb5+YiltDoN1QGWj5nxRDPNO5crDHacRsV7ZU0B
 WYbiCNj0WIZns+41XruOAZbMIv+F9T0InZlGrTV14G1C2KC0ftuIQVJgh26syht7KF+S
 e1FOHOlcdCZrNWGOmwgA0s/bjBaaoyXK81N2w21IV1ylwJe8gMhpHYhgkdrgmhigwzTs
 +wrVZA11Zl7lbN1oovqqvlY4BivBNWogzJZsoTka0U96Je3V4lWbHxKzcwzshIaDB8+7
 Eo3Q==
X-Gm-Message-State: AOJu0YwipDfM2OAai7HVIYKOlRYj9O06ttBKxUO40NvXMIvuoj+hnNn8
 iebi/g8ZqILMqfTFmDqYg52zngqciths4w1KX2EtI9EeuZWyMyNUNK324bQvQ7Ba
X-Gm-Gg: AR+sD13Gzf0atD89SeNTpcoEoeinjtde2c9YYgadOXNV7W2tMzJZr/R2vSZW0vqwe9a
 x8txt4Ws0GgALJaDDn38k3BH3wnJx6AY1JcQ8BdEodnCYuZN86sSmdlLptTuh39HKajGlZVT2bS
 KXyTovjsTMO/tF7M6hulGsNHJxdciN2ajHFzimbLRrbJNRYbqgxCbvcxIp0iH0WSqtLalXA6iIl
 ayQ0BhnYM9xTDmUIiL22/agHhkhUgTP25oZKN1S02c4o8Dlt+jGxWTK0tGqEVdNT9G6o+5n9hWM
 fuMC/mnA1MmXDU5ubChQ8eIhNJ57iSNPbRrTV8QNesKEui8JlXVFf5ZGOHaVDzaZ80tWD+JxJOS
 SL/4jmtSLV16SPbkV1T/7/0mmyyqzBoZlzx2/cQcERvMXfd6lvNyqtJQdhXzTlPGTfS6nU1R0q9
 W2dBIfBHkjUBZ5DzwOrzlDNWat
X-Received: by 2002:a05:690c:4b0e:b0:81e:29f:2b3b with SMTP id
 00721157ae682-81f9936bb98mr15430427b3.38.1785256618261; 
 Tue, 28 Jul 2026 09:36:58 -0700 (PDT)
Received: from intel-VirtualBox.. ([187.15.122.127])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fa27985cbsm2298527b3.16.2026.07.28.09.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 09:36:57 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Brian Sune <briansune@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6] arm: socfpga: Improve handoff prepare on SoCFPGA
Date: Wed, 29 Jul 2026 00:36:13 +0800
Message-Id: <20260728163613.4278-1-briansune@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785256618; x=1785861418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XSEIBFPq+c2YH7UM9qdq+fsS7wcJ0SPl1AcGCsVtDhE=;
 b=BRHrd2YfrVQHhettrKtJK7ezN9w6JyeuyQiallGrQr/AHHvhggIlW7ryHf4V/C74J/
 ZExDAO94ysZaIQ+XbeVIuXY7T7qNAeznPafoSwhMbqptZWEm8GwzRApdkgVL3sUjA+Yq
 DvyZmhx9W23hBqolZ+Woludn+uxD6+dnY5WYrRkz2c8WPiGA7WnlMkprh7LaFS94FZt3
 /tJiChIRKLZegPFYjkI9ZxIrw8XpIKqWIB8axqhdE8PRTswTyXo4U3ZAZDG7nniusB/+
 6Wpx25ZfnzzmyJ6R+Qbp3qtNaMapGmIMh0GQKlcNoDCcFXcMRg0G8bbmBBLVZW5v22Bv
 27oQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BRHrd2Yf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=briansune@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRHrd2Yf"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Ensure qts folder header files are properly updated by isolating the
Python execution environment. This prevents partial or failed script
runs from corrupting the target directory.

Signed-off-by: Brian Sune <briansune@gmail.com>

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

---

Changes for v6:
- Clean HANDOFF_KEEP comments.
Changes for v5:
- Change HANDOFF_KEEP condition to if [ "$${HANDOFF_KEEP:-0}" != "0" ];
- Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
Changes for v4:
- Move trap 'rm -rf "$$TEMP_DIR"' EXIT; after temp folder create
- Change HANDOFF_KEEP condition to
  if [ -n "$${HANDOFF_KEEP+x}" ] && [ "$${HANDOFF_KEEP:-1}" != "0" ];
  HANDOFF_KEEP=0 from rename to discard old header files
Changes for v3:
- Implement a temp folder for Python script execution.
- Clean temp folder automatically despite execution failures.
- Gate the file replacement process on the successful exit of the Python scripts.
- Execute the replacement (with or without keep) only upon script
  success via the NEW HANDOFF_KEEP=xxx variable.
- Rename old files to .h.handoff_backup.<timestamp> when the keep option is selected.
Changes for v2:
- Add handoff Python script execution check
Changes for v1:
- Implement basic remove and replace header files
---
 arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
index 1ca1d33cb16..f341aaaea56 100644
--- a/arch/arm/mach-socfpga/config.mk
+++ b/arch/arm/mach-socfpga/config.mk
@@ -1,6 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Brian Sune <briansune@gmail.com>
+#
+# HANDOFF_PATH
+# ------------
+# Unset - Board path where qts locates and "hps_isw_handoff" should be placed.
+# Set   - Custom path points to "hps_isw_handoff" folder.
+#
+# HANDOFF_KEEP
+# ------------
+# Unset	- Clean header files.
+# Set	- HANDOFF_KEEP= , Clean header files.
+#	  HANDOFF_KEEP=0, Clean header files.
+#	  HANDOFF_KEEP=1, Backup header files and rename to ".h.handoff_backup.<timestamp>".
 
 ifeq ($(CONFIG_ARCH_SOCFPGA_CYCLONE5),y)
 archprepare: socfpga_g5_handoff_prepare
@@ -43,6 +55,27 @@ socfpga_g5_handoff_prepare:
 			exit 0; \
 		fi; \
 		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
-		echo "[INFO] Running BSP generator..."; \
-		python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
-		echo "[DONE] SoCFPGA QTS handoff conversion complete."
+		echo "[INFO] Try BSP generator..."; \
+		TEMP_DIR=$$(mktemp -dp "$$BOARD_DIR/"); \
+		trap 'rm -rf "$$TEMP_DIR"' EXIT; \
+		if python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$TEMP_DIR"; then \
+			if [ "$${HANDOFF_KEEP:-0}" != "0" ]; then \
+				echo "[INFO] Preserving old BSP files..."; \
+				TIMESTAMP=$$(date +%Y%m%d_%H%M%S); \
+				for f in "$$BOARD_DIR"/qts/*.h; do \
+					[ -e "$$f" ] || continue; \
+					echo "[INFO] $$f -> $${f%.h}.h.handoff_backup.$$TIMESTAMP"; \
+					mv "$$f" "$${f%.h}.h.handoff_backup.$$TIMESTAMP"; \
+				done; \
+			else \
+				echo "[INFO] Clean old BSP files..."; \
+				if ls "$$BOARD_DIR/qts"/*.h >/dev/null 2>&1; then \
+					rm "$$BOARD_DIR/qts"/*.h; \
+					echo "[INFO] Removed old BSP files..."; \
+				fi; \
+			fi; \
+			mv "$$TEMP_DIR"/*.h "$$BOARD_DIR"/qts; \
+			echo "[INFO] SoCFPGA QTS handoff conversion complete."; \
+		else \
+			echo "[WARN] BSP generator failed!"; \
+		fi;
-- 
2.34.1

