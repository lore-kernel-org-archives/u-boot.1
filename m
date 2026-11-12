Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P9vk2YqB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s+3L2vms
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86ADD811B6;
	Thu, 12 Nov 2026 06:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5bfMPXQS2Ex; Thu, 12 Nov 2026 06:17:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B61AB811C1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794464238;
	b=q6IPXpx+GO39cWCihJy07/vyofD22+MJoMrXfzneKm6+Fayp/wxzWNKf+p7oUIAPrUow
	 3MEMjVOM0FY8WWBbw6vMsvTeckr0XVTUimSF/W7jjSiUY5gxDGBvEsFE74oFecK+G0q6E
	 wOlaNKgzyK2zSCttngX2XEQ355WZswtjghR7BuOBZlFSVMyZT4IhVLlR+mNwbtNpzmMpB
	 SVECEzANgQOzlg0FuiVGmjW2t34hg1f5DWXplYt20TiVU6ScDihAft6Q4IKQRFFHi7/Jo
	 6QSpyB6mhpVFWiONPL3LjsjhN66kBb7mVLL9AZnHOAv9xh/Eb7vKaJOL14NJuAKkDlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794464238;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zWLP7bou/owjUsZW65DpD9aWxCsewWOEwK2u9x82k9k=;
	b=HvnUdkHlDmep109Fef3lrFWrD/KxPgv785WpD8C/CXbJDRAY0D7VK6xqxS5Gsk4ezjNV
	 3pM6K3NUCVyQEPx8zXnPKn+WwwjqUIRFOGBqjRPXkKueij98cd7qw+MEQpugWWNH99jFi
	 cIKhLW6/nenjnmCGsPYxfdfc6MN2VQLeI+ZNawO9z03/RcYyFyV7QgeBAuRizTOLyubuN
	 nAOw7EgQGrFuTpW9O7rodrbLkbywayVrVGBragoUo42IkfVe/UoE4bh38KTeK/yl0d9QE
	 BUz6VVwPvOFfVaZupco6wy2sYbPP1Ci1h4DC0aGTpxAsI6yM4uIbQX+lZXFQ5/3wkLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794464238;
	bh=zWLP7bou/owjUsZW65DpD9aWxCsewWOEwK2u9x82k9k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P9vk2YqBsxb0t3Y75b9TmHzEAudcsR9qWJ0yTBjc+odfZ1axPhkgQO/vBDAOIHJSZ
	 psmH2VJfn7KVkFTo3hRrbveOef1ZOASWIfDDKItHeX0wQTNkQwmG5bTlBN73x0ILu/
	 5mpG9rXnMsFyms1Ms8djVDKomk/NrTA7pcmz2DXqPtNkOeUKQ9FPAHiiRxoPxYR3+3
	 RcgTPR3xc6Z3YgXDdoNkA4EHH4RohowkJ0PInl34cbaK+VKxX5Rx4jfhzdCGxsm/yL
	 i5i/2EFJGeryYFxRVC0Apl48w1AkBuNQNUI2ghY4PdawMZZGgywafmkU6ksexaqtg+
	 klpUlJou34Gsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B61AB811C1;
	Thu, 12 Nov 2026 06:17:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 686212FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DB0A40624
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvC2AwhwRynx for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8186C4060F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=s+3L2vms
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8186C4060F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:17:15 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso1989310a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794464235; x=1795069035;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zWLP7bou/owjUsZW65DpD9aWxCsewWOEwK2u9x82k9k=;
 b=s+3L2vmscykIIlP8IJ+gFH0KX3LnTI+Psq1i/6OWT+DfmurBKn2mNNQzMo/AJsNsCf
 Vo69NkphsciWvw684+K/y11VqTVHMebizUdl4zI9cqSwd2uxtOqfqrbEQOUFEsngfds8
 +6Gm5BKpyPS3ViT5bPRDvLKMLdVljf3D2T2cruO/spxd3YoMEIWTDXFND0Boi6TX0zSM
 jS8XCr+hexWTvI2FDsWe3OyJSVP1yCHM+clFAbR7WPtsv7329LqTlullsfSLrNE5zh0M
 1nSSK9o1j6MTkGzGeUnD/WaoouO+9fr/rzrhs3fh0DSi3Casz1mOtXgBxvX/Liv4HSSf
 waQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794464235; x=1795069035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zWLP7bou/owjUsZW65DpD9aWxCsewWOEwK2u9x82k9k=;
 b=KJ2Lc5TjJlVX6i5TEVyfWB+An1i/h8bIpMcAB9c9JIpNsnoTjemeKROSmq8je37VIi
 XKXbb4xkDD1gGaRWBikAUIzpn0duqwKStmp4szhPtVSKCT53CF+cwhvq2l/y4xKiM/TX
 c6BIJwaAxSY9aivLviS/L5ssqQosnFRpFjTeViXtqPmYuzaOi5AZuQ4KJvv9DBrWXmQT
 jdQUPFLHba2nhgKZgpNr9bzQLyVH7uKk2L8nfOqw+s7AjuSg57nNS9vFzscwiQpGpJgK
 FD7j2kvXv/dpGsX2oEvErnp+2Ou4lSlj5KjLfxwtkzuAAUAiTVzjXYjfhzQGK6kcz+N9
 7uhw==
X-Forwarded-Encrypted: i=1;
 AL+hErFBABKD6G9H3W2yx+KqnK3al2guvPt2gU1y5S6az4bdGR6D7gV+0bwCLWBBpcjAv+PpWdtg/oI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+SmEZ0KkSCi4yK7cTU4O93Dl7sqIUTt4qzYOuLYClmBq2PV0ri
 AOHg5x6JezJM7ZhdLrf8jqmZozhvNfFE8T/lCJfPSxmEpbbrXg0KsU5G
X-Gm-Gg: AYBFou1Nid800t2e9Qb3gOsc351oGW2cb8SGWJ9Nh2XXiOZ3QysHTO+exnqlM6RgrDD
 kHBlIkSa1uxomy+hdv9qIoyRjngLuLIyJyO60Da49DxFd0oZp5HTOr7symY3bBcyFjVMX9oUyOr
 EFeATUehFDpdVVyWBopTFCr+QRlcBYoNfmXJKJBNeXwMkp8RSWaI+tfwDq+mWhBHmdjUmhLr8pF
 h166rt0ZHB02sC7Ufz42WuqKsKA2SdMoJ37dNGtAuyv7+VCU+RkwlG3mcBL26oldPrNihw1JCiT
 mCRUT00+zICiFHfenOlTRZFvpcjo8gFK3J4z/zD11mEcBQersg3UdvEA9uJh3D2wnQMNoV9BY8G
 oDCIaJ4ITSlpivLdY9nCPbAm53t/o/JQokxQFc5rvgoUA1pKzsQfPzi4irZn26y2di12VO54+xY
 +5EO2V5rF9dbsa8cNZCJqKcNJK5pmWzNvwcj8bqOuAdGM8RHmf6Gp86Ci20prNKWFUDWRUaqh9p
 6cAXTXuKgLXGjlxSaB9f/DKrSMVLpep+0ftuEpoQKC9kXc73QdR6rqRZLy1tj/m+v1WlduRT0Fe
 yjoWFpMf9aGdsQbQ/0fG/yPMEkWbQr6NxSowNzg+bwhGsTxr2HQ=
X-Received: by 2002:a17:90b:3c44:b0:3b0:97b8:d6bc with SMTP id
 98e67ed59e1d1-3b182ec221dmr4246807a91.16.1794464235207; 
 Wed, 11 Nov 2026 22:17:15 -0800 (PST)
Received: from intel-VirtualBox.. ([187.15.122.183])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0f6e0sm2865803a91.9.2026.11.11.22.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 22:17:14 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Cc: Brian Sune <briansune@gmail.com>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v2] arm: zynq: Add missing handoff script to XSA flow
Date: Thu, 12 Nov 2026 14:17:04 +0800
Message-Id: <20261112061704.357241-1-briansune@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds XSA handoff for ZYNQ core modifications.

User now can place XSA file next to the board folder where auto
generated from Vivado build flow.

Signed-off-by: Brian Sune <briansune@gmail.com>

Changes for v2:
- Add HANDOFF_EXEC gate script run or not
---
 arch/arm/mach-zynq/config.mk | 108 +++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 arch/arm/mach-zynq/config.mk

diff --git a/arch/arm/mach-zynq/config.mk b/arch/arm/mach-zynq/config.mk
new file mode 100644
index 00000000000..126369b3792
--- /dev/null
+++ b/arch/arm/mach-zynq/config.mk
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Brian Sune <briansune@gmail.com>
+#
+# HANDOFF_EXEC
+# ------------
+# Unset	- skip handoff XSA preparation.
+# Set	- HANDOFF_EXEC= , skip handoff update operation.
+#	  HANDOFF_EXEC=0, skip handoff update operation.
+#	  HANDOFF_EXEC=1, do handoff update operation.
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
+# 1.0.1 - Add HANDOFF_EXEC to gate: immediately escape on HANDOFF_EXEC =/= 1
+#
+
+ifeq ($(CONFIG_ARCH_ZYNQ),y)
+ifeq ($(HANDOFF_EXEC),1)
+archprepare: zynq_handoff_prepare
+endif
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
+		if [ "$${HANDOFF_KEEP:-0}" != "0" ]; then \
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

