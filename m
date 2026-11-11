Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h+4cyjtO;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mpm6Q9b/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2690D60AAC;
	Wed, 11 Nov 2026 06:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smzlJWGofVxK; Wed, 11 Nov 2026 06:21:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BC2C608C4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794378116;
	b=jvu+W0wvWUnzzjEN5j/6w/ofjMsWwp3Zad92OK4aG2GVt1voq7z0Xf36sgdgOUxGuYVd
	 ZFziLzE6ANEn0bKrr6vSM+LRQ6Jtw5bspSKI2Vmk6s2At6XymKe/ns6pSEEpxATI1a/Y9
	 t9GcRzwCyIumX9KE+DpcKTDLaTIZUmc2scJEk4W53wyfXbSnAJTfaKf+OPXTt0hIzKMi2
	 qIzmyqFRPgnaMz+MXgDvFC/F/mCNOVxVQ1iUUtaM2XARpMoIlqao+SXPKiuIvcNY/M3zI
	 3JjW2Az4LB6ydRVtZ+sVXkSwhcrXq/F0NXoRxuvG02qH6IyxwdwQsz2xib2Cf5JIJWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794378116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MKrxBFQrXd1y77unhruxIHh6gpaUGNu/N4o+PKr6W0Y=;
	b=cww6cs4zNLg3nHR2i3hcCVOxX2tDaG9554xKeYzk5Ka9OHUwRaCu92pPOLkrMbqmRaeZ
	 bO89aX1fjltz2F3CxZz/CNmIn5flYUuqgGaeSpcCGe7Ot/MVZnu2LeltkWaTQVIteFVqO
	 otPMQo4CcJPcE2VMJKzBOa/+WfkDXpZ9CAuH8GAGby7EfAQXPfug6+ovEmdXbVKplpwyV
	 tvMX/Pzvtc29SVbln8dvDAWEBTDmZ0GIYKEFw9jF6Mr/btkzozrAQXReam26m45wiGXtc
	 oDc53oMfM7gl+0lb8z2k0KXti/2+/O1d6oMvX26HVvlgE06nQFW39qU5vTOOGsYeZaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Mpm6Q9b/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794378116;
	bh=MKrxBFQrXd1y77unhruxIHh6gpaUGNu/N4o+PKr6W0Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h+4cyjtOSD5EzhIGlv45WMBTEkPCqug3TGbG9CzqtLe6H9XDQiyinEPzPxoo9IOxm
	 53Z5b/fF7x0oXPBC5PnTYKkogmpINM9V98fBIHK+oLAIc54hBa43IJMLk9Z+Wi+9sv
	 xrHBo4/g3BhST3N5sIi0Fe6HD/mmtWb39ZvxHs+mIuxGySgd3I3NBiwUxWc3Eab8JB
	 pYECiBeVpPt45+09hkglSZZrb22+J94OvWd2zmnjWbfAxeC024o6ItEme/iXBX4ld2
	 Yt4B/C/JCPKAOuO/Ndo3D6peZvZcVhgTIhlHaJggoKDpIs+9hof/gYW2ib4LyJsLTd
	 9hr19l/pSWNRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BC2C608C4;
	Wed, 11 Nov 2026 06:21:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3D8317CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0F71608C4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f21huLdM06Ww for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 06:21:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A93A6088E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Mpm6Q9b/
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A93A6088E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:21:53 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cdd89d84521so786190a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794378113; x=1794982913;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MKrxBFQrXd1y77unhruxIHh6gpaUGNu/N4o+PKr6W0Y=;
 b=Mpm6Q9b/y7Nmhe3I57g9lSDI6V9qr4ODTmEgNeUV3OSNltLMm3UnXbLS1jQhsk+Qqm
 zEhmartk2hd3/0qOeHjs7qsuU7Wq3X1+R19RUVjUEaBCk9O9KiZ1PL+zI7LURWY36r9n
 KA/OAH6yKpVK2AywsOqb60BimOn5LzCE7SL7wg/YljBFiTaGbl+DLgeNpcpKBWgMspMZ
 DlFSkbzz2s3D8+Tke1MedrwVmwuKTbWUTxno8L/tKxhAX4c3CCn1PK7hAkdugDCJHXc0
 KuIJORITAsZ99IaOqk0nNh2ulQHmGhTvflwrPUGTDlaRLtmWodKx8q9QfBvBn7gNvfH6
 actw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794378113; x=1794982913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MKrxBFQrXd1y77unhruxIHh6gpaUGNu/N4o+PKr6W0Y=;
 b=up8TQvuB2mxQ7qnWAYTA0TR64vUulyqRIDbLvzpFdaVjn9IFy5BEJWEJ23BTw9yfi8
 S/YBxgJ9bR7dMQ7phomGXpBAawsxd1cRkjZk3ISfgj0H2UayUTkzQ+YImnAAet/HFOAw
 llTblHPiEKdAwQXOVXlGaunqx6WsDacfibj3QXG3GJm6ItZECo7bm/4KDaby3dmGkii8
 d9XrO2hngI0laPi2+vF55CtUXPp/MCNhgBoVupDGxyM9MuC76AJzK6zwJrI56kSro2OG
 csFzaI4/DG8eTptG08qDv5trMpJkPpuAlCnaV8BWIcs2zCRSCkFkdnqWU0t3pJq08/Jg
 RJ3g==
X-Forwarded-Encrypted: i=1;
 AL+hErHdnXyrcNwTnfMSTrXJYJjwEjm0GjKAmM+eVU2jXasgeixirK8Gj3kMOoYWLW3J4RpQK2g2SGg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+/0lWxf3CFj2/nFAymLPPHjJ55pDMntDgOSdLkesexBoZi4W8g
 rpipFLtqX7nJ22JeF8LqhS8WNhV87+MumTJb8MKMf4tYnEjAAuiDpteW
X-Gm-Gg: AYBFou3Xo25W5ERqsNXs9m3ssRvIQbz1A6bHhDLkwYmzDSyH8qxZtndgPH/FJRk4U+s
 s97Mo4UgaV8J2tG5LCAeiGNiSq9WDUvhXQc8fTnbFiuZDvhV8m4ENi4MaGqezhGSqXwDYIecOd0
 TplERcstIuMvHZQ24wiKJTqDIPXO57Vf/1acax0XBsUwqo8VqLjTZhw+WFFwceQv58yLEPK4BdG
 uz9WuwIxqhcsfveAe2TZC/ZpmZSGFbBG4JeRBzBvS2ZryoKvn3P5IJRwY7xeZxvzAN9pyqSn4ok
 /issULSbWIfLL558GuZc3XzZgsKSlrSEfKfF754TTCO1O6OP1VPeGxHIaMhNGu1M9+wpcAS2SZB
 U12Cv/I+kYyFSetYsApvwqqKHnUtz/U5Ow9xWstlUvumQr8/BTFDuLHMU5+ABHA//j8zQEzBY+J
 t38DFKcLMZtVbjC5vvCe85a5/u/Efe4RmnVF9s23NQNQ7FaRX0cH8e6mOFGa+i4OFwSpIwhNgbn
 pd116zGNjqGFupYwtwkef2JCrrFk0yjqHCZ7WA56qLRlcs1uLkNIqtK6OamKsAN09MrGCfB+DLD
 zVV6ozOJcvqPi7Ainm8bYVEiQSRPJpRh5+Eed+uY5lIC+GfZY6M=
X-Received: by 2002:a17:90b:2252:b0:3b1:d40:2c4e with SMTP id
 98e67ed59e1d1-3b182d62b3cmr1187303a91.0.1794378113097; 
 Tue, 10 Nov 2026 22:21:53 -0800 (PST)
Received: from intel-VirtualBox.. ([187.15.122.198])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b186234c12sm1058395a91.10.2026.11.10.22.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:21:52 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Cc: Brian Sune <briansune@gmail.com>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v1] arm: zynq: Add missing handoff script to XSA flow
Date: Wed, 11 Nov 2026 14:21:28 +0800
Message-Id: <20261111062128.215998-1-briansune@gmail.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch adds XSA handoff for ZYNQ core modifications.

User now can place XSA file next to the board folder where auto
generated from Vivado build flow.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-zynq/config.mk | 97 ++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 arch/arm/mach-zynq/config.mk

diff --git a/arch/arm/mach-zynq/config.mk b/arch/arm/mach-zynq/config.mk
new file mode 100644
index 00000000000..2680db85d25
--- /dev/null
+++ b/arch/arm/mach-zynq/config.mk
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Brian Sune <briansune@gmail.com>
+#
+# HANDOFF_PATH
+# ------------
+# Unset - Board path where ###.xsa locates and "ps7_init_gpl.c" should be placed.
+# Set   - Custom path points to "###.xsa" file.
+#
+# HANDOFF_KEEP
+# ------------
+# Unset	- Clean ps7_init_gpl files.
+# Set	- HANDOFF_KEEP= , Clean ps7_init_gpl files.
+#	  HANDOFF_KEEP=0, Clean ps7_init_gpl files.
+#	  HANDOFF_KEEP=1, Backup header files and rename to "ps7_init_gpl.c.handoff_backup.<timestamp>".
+#
+# Version Log
+# -----------
+# Date - 2026/11
+# 1.0.0 - Initial Release XSA handoff for custom boards and existing boards
+
+ifeq ($(CONFIG_ARCH_ZYNQ),y)
+archprepare: zynq_handoff_prepare
+endif
+
+define COMMENT_C_FUNC
+	FILE_PATH="$(2)"; \
+	TEXT_MATCH=$$(printf '%s' "$(1)" | sed 's/(/\\(/g'); \
+	C_FUNC_HEAD=$$(awk "/$$TEXT_MATCH/ {{print NR; exit}}" "$$FILE_PATH"); \
+	if [ -n "$$C_FUNC_HEAD" ]; then \
+		C_FUNC_HEAD=$$((C_FUNC_HEAD - 1)); \
+		C_FUNC_TAIL=$$(awk -v start="$$C_FUNC_HEAD" '/^\}/ {if (NR > start) {print NR; exit}}' "$$FILE_PATH"); \
+	fi; \
+	if [ -n "$$C_FUNC_HEAD" ] && [ -n "$$C_FUNC_TAIL" ]; then \
+		sed -i "$$C_FUNC_HEAD,$$C_FUNC_TAIL s/^/\/\//" "$$FILE_PATH"; \
+		echo "[INFO] Commented out lines $$C_FUNC_HEAD and $$C_FUNC_TAIL."; \
+	fi
+endef
+
+zynq_handoff_prepare:
+	@set -- $$(awk -F'"' ' \
+		/^CONFIG_SYS_VENDOR=/ {v=$$2} \
+		/^CONFIG_DEFAULT_DEVICE_TREE=/ {b=$$2} \
+		END {print v, b}' .config); \
+		VENDOR=$$1; \
+		BOARD=$$2; \
+		if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
+			exit 0; \
+		fi; \
+		BOARD_DIR=$(srctree)/board/$$VENDOR/zynq/$$BOARD; \
+		if [ "$$HANDOFF_PATH" ]; then \
+			echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
+		else \
+			HANDOFF_PATH=$$BOARD_DIR; \
+			if [ ! -d "$$HANDOFF_PATH" ]; then \
+				exit 0; \
+			fi; \
+			echo "[INFO] Try auto-detected handoff XSA: $$HANDOFF_PATH"; \
+		fi; \
+		TEMP_DIR=$$(mktemp -dp "$$BOARD_DIR/"); \
+		trap 'rm -rf "$$TEMP_DIR"' EXIT; \
+		XSA_FILE=$$(ls $(srctree)/"$$HANDOFF_PATH"/*.xsa 2>/dev/null | head -n 1); \
+		if [ -z "$$XSA_FILE" ]; then \
+			exit 0; \
+		fi; \
+		echo "[INFO] XSA: $${XSA_FILE##*/}"; \
+		unzip -q -o "$$XSA_FILE" ps7_init_gpl.c -d "$$TEMP_DIR/"; \
+		if [ ! -f "$$TEMP_DIR/ps7_init_gpl.c" ]; then \
+			echo "[WARM] XSA unzip unsuccessful."; \
+			exit 0; \
+		fi; \
+				if [ "$${HANDOFF_KEEP:-0}" != "0" ]; then \
+			echo "[INFO] Preserving old GPL files..."; \
+			TIMESTAMP=$$(date +%Y%m%d_%H%M%S); \
+			for f in "$$BOARD_DIR"/*.c; do \
+				[ -e "$$f" ] || continue; \
+				echo "[INFO] $$f -> $${f%.c}.c.handoff_backup.$$TIMESTAMP"; \
+				mv "$$f" "$${f%.c}.c.handoff_backup.$$TIMESTAMP"; \
+			done; \
+		else \
+			echo "[INFO] Clean old GPL files..."; \
+			if ls "$$BOARD_DIR"/*.c >/dev/null 2>&1; then \
+				rm "$$BOARD_DIR"/*.c; \
+				echo "[INFO] Removed old GPL file..."; \
+			fi; \
+		fi; \
+		sed -i 's|#include "ps7_init_gpl.h"|#include <asm/arch/ps7_init_gpl.h>|g' "$$TEMP_DIR/ps7_init_gpl.c"; \
+		echo "[INFO] Masking GPL unused functions..."; \
+		FUNC_NAME="ps7_config(unsigned"; \
+		$(call COMMENT_C_FUNC,$$FUNC_NAME,$$TEMP_DIR/ps7_init_gpl.c); \
+		sed -i 's/^ps7_debug(/ps7_debug(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
+		sed -i 's/^ps7_post_config(/ps7_post_config(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
+		sed -i 's/^ps7_init(/ps7_init(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
+		sed -i "/For delay calculation using global timer/,\$$d" "$$TEMP_DIR/ps7_init_gpl.c"; \
+		sed -i "/int\nps7_config/,\$$d" "$$TEMP_DIR/ps7_init_gpl.c"; \
+		mv "$$TEMP_DIR"/*.c "$$BOARD_DIR"; \
+		echo "[INFO] Moved new GPL file.";
-- 
2.34.1

