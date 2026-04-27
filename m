Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D9DFF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A6384307;
	Mon, 27 Apr 2026 12:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WYO7LwWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F441841D7; Mon, 27 Apr 2026 12:09:01 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09668839D9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-38ddd8d3b7fso76311431fa.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777284538; x=1777889338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBh4vrw9rwot667Wy6pXs4MP3GKFRJdIycISONOrycI=;
 b=WYO7LwWfJhp9+VEc1rmyhakHPaWDuv0f8OQUeQVRwQQYP2cfcOdHEbpLM1RgIra6Nx
 2d4Y0/BdjFGjkfcz1bpH4YapxG+bKHiOHCEXK23m60yPkZ2zDbN3j2L+CAON4jzqep5D
 UWwHqcHzHPoBuyxMki/91nwo8Od2wU17nQlnH0ztLrPtbosc0eNpY7FLnTeIFyF9n7hK
 ArIW9Cnqa5XzhJ8qjUy5do5ryndEa7GBVbSoL2+E4URVLlYeshBSO4JyqWLnEGVS0jMW
 KoMw7yTl7Xip9DHOr+KKU9MYp3rIXz+EzNulJmyDEzJ9iVawOv50/NDtP53kozGHbmqa
 UUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284538; x=1777889338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IBh4vrw9rwot667Wy6pXs4MP3GKFRJdIycISONOrycI=;
 b=gFfiP2rJihsOOVoLlKM2YfGF6dTcyKsrFylWBNZv9/+WRwjnJRG7RwDRtc6eXK+WCz
 /xtr1nS3TyGNL5dv5L7LsSyycTomTD0MttkKsUvcWH0XTmNXb3C4XhEFwWXigPHgJOaY
 yI+Weg9hFz5V1DYzg9CEdBqSouQKpLCC6MUsrvtxqiM2OyI0v9hVWZYMORHTw2bjb2vE
 LetzAxik12E4RyHVPupuZyp44oSmXyfE5kN+XZzhNGGl9rQ2y8SA4rzE8vmkRSeEtfSh
 BXUo4QxKMGch8thl6GEuup9mtq1pMKBsv1WeGKipmDs1qRTONnUFRxOdLZBxZo1qm5y4
 KrrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oyYc3G9u0Oaz16Ykf8FlEt0t0Wj3UzfLzxqiPz+vJ3g9IY0iETUl9Tf3f3eSiblA4i6aQMiI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw24+ZKJIsGIa6eCfJhMoFpSxIIWd/+YWgeNEUcHy4hehoa+cki
 +irzK0/mbxBDNPoOjhaAR+sM4WAZiYFJTzp9UMlPZbEpff/7uZaThc5T6KzPKJiDkZA=
X-Gm-Gg: AeBDiesyVY2LbajUESAEvuqWoSZhV51Z0OgVzRTvF/oi7AYappCGjZRhT0LWkhIjvow
 GBBEzRlveX+faDUbJn/F2Du1Ih0l5mmOX1zRVqHq65ZXvgLao7I+jOiKUIkW4Teg5AQZ81jUlTp
 SuccBM9cEMepXjc/FwieRKpI5wS2t43Y1Q4kn4mTZHOhA3yYBUBSE+e+iNYInhSEIpHx2aXYI5h
 uL5UrEi5AbbO1gbmEhjC+Y5M3QF1YgCADbGwRxYA/wcZeQGHtwqvyBLM1NKHF2yR0eEsCXwbU9T
 ENXAwOUyLXWbz5nAtb6Vt9iXTGaEA3TQtivr1pK+klPeCk5XKGP/BxstMRzn6D+n9b6llRK6mtP
 ByOiBjz1grL8pkpt0ThCCVEnhsrYv3P3xVQ+XpnArWB7J3QmxqY7/CmsezXHXjCsL3Vz1cdGp9E
 79ntWMffThClBWDpALn2HBITlpWnZXratQa9SbcnCn5bTuvi5AvU9jnN8X9rqs4ztZF2OTeuBOl
 bRE8Gk7Cz1W7BOjOorr2Ci6YyLXzAfECccwjzIADw60Ne6JOETJIr6hXtT30oLdXKdJC6Pc+hIf
 Vcpot/8WfhzijaiZ161Z0NdEBw2m9Z8l/6ZPKWwhPzEk4Qc3/tgWPyzeEUyKGl+7+zk++3ruaYw
 cfvksvEGHUl7R3yDhKnJMuOrSa8bpCOgkBC9i6Vf0tzjWEVTh5P2fgKP/2af8kA86XRIrsxLPaP
 1I3pGKkptBSAuMOEyJFSl65WjPXY+bEPypo2GZCM3vJ4JX3OjTCE7p8D91xQ7OFf3EcBy/CCAC0
 wjUnjCyOg6e277MMY8r6hoybAyrSaIssgyZ5M3m9JymdwY=
X-Received: by 2002:a05:651c:418c:b0:38d:e977:554a with SMTP id
 38308e7fff4ca-38ec7b09541mr111520901fa.24.1777284538222; 
 Mon, 27 Apr 2026 03:08:58 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0b88sm68554791fa.27.2026.04.27.03.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:08:57 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3 6/6] common: Add an option to relocate on ram top
Date: Mon, 27 Apr 2026 13:08:27 +0300
Message-ID: <20260427100832.581887-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
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

Right now we only relocate u-boot to the top of the first
memory bank unless the board specific code overwrites it.
This is problematic when loading big binaries as it
fragments the contiguous memory space for no apparent reason.

On certain platforms, it is currently not possible to relocate U-Boot
above the 32bit boundary, due to various dependencies on content located
below the 32bit boundary. One such example is ethernet, where the packet
buffer built into U-Boot binary is placed below the 32bit boundary and
allows loading of data via ethernet even above 32bit boundary due to
memory copy from the packet buffer to the destination location.

A previous patch moves the bi_dram[] info from bd to gd and make
the memory bank information available early. So move the
dram_init_banksize() INITCALL before the relocation address calculation
and use it to derive the address.

Also add a Kconfig option and allow the common code to relocate U-Boot
to the top of the last discovered bank.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig          | 12 ++++++++++++
 common/board_f.c | 32 ++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/Kconfig b/Kconfig
index d1a042a11658..522eedf726ef 100644
--- a/Kconfig
+++ b/Kconfig
@@ -503,6 +503,18 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
 	  Offset of the read-write memory which contains data, from read-only
 	  memory which contains executable text.

+config RELOC_ADDR_TOP
+	bool "Relocate to the topmost memory address"
+	depends on EXPERT
+	help
+	  When U-Boot relocates, it chooses the end of the first memory bank.
+	  Enable this if you have multiple banks and want U-Boot to relocate
+	  to the topmost memory address. This will use the information of the
+	  board memory banks configured with dram_init_banksize() to calculate
+	  the relocation address.
+	  Use this if you are certain all of the devices can access memory
+	  above the 32bit boundary.
+
 endif # EXPERT

 config PHYS_64BIT
diff --git a/common/board_f.c b/common/board_f.c
index f58061026f8f..c88f4d2f97a5 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -31,6 +31,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <memtop.h>
 #include <os.h>
 #include <post.h>
 #include <relocate.h>
@@ -339,7 +340,28 @@ static int setup_ram_base(void)
 static int setup_ram_config(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
-#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
+
+	if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
+		int bank;
+		phys_size_t total_size = 0;
+		phys_addr_t top;
+
+		for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+			if (gd->ram_top <= gd->dram[bank].start)
+				gd->ram_top = gd->dram[bank].start +
+						gd->dram[bank].size;
+			total_size += gd->dram[bank].size;
+		}
+		gd->ram_size = total_size;
+
+		top = get_mem_top(gd->ram_base, gd->ram_size, 0, (void *)gd->fdt_blob);
+		if (top)
+			gd->ram_top = top;
+
+	} else {
+		gd->ram_top = gd->ram_base + get_effective_memsize();
+		gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+	}
 	/*
 	 * Subtract specified amount of memory to hide so that it won't
 	 * get "touched" at all by U-Boot. By fixing up gd->ram_size
@@ -350,10 +372,8 @@ static int setup_ram_config(void)
 	 * memory size from the SDRAM controller setup will have to
 	 * get fixed.
 	 */
-	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-	gd->ram_top = gd->ram_base + get_effective_memsize();
-	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+	if (CONFIG_IS_ENABLED(SYS_MEM_TOP_HIDE))
+		gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;

 	debug("Ram top: %08llx\n", (unsigned long long)gd->ram_top);
 	debug("Ram size: %08llx\n", (unsigned long long)gd->ram_size);
@@ -979,6 +999,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(dram_init_banksize);
 	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
@@ -1007,7 +1028,6 @@ static void initcall_run_f(void)
 	INITCALL(reserve_bloblist);
 	INITCALL(reserve_arch);
 	INITCALL(reserve_stacks);
-	INITCALL(dram_init_banksize);
 	INITCALL(show_dram_config);
 	WATCHDOG_RESET();
 	INITCALL(setup_bdinfo);
--
2.53.0

