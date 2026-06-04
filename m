Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4F0CD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 07:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F05484878;
	Thu,  4 Jun 2026 09:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YybDtH+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B572848A9; Thu,  4 Jun 2026 09:37:40 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 161DC8485F
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 09:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so4149125e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780558657; x=1781163457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=981fWpuAbK2bvrnCZZVrwADu5/ky6PA26Iw6kXj799M=;
 b=YybDtH+2TtSEJg0zFd3Nb9905c06cqLq9MwgC1ct3Z1IaQEjUwYZdN3deLCBRYsfLN
 G98rzLSzYhJGGE8a9RkAR+Dm1rtJo5v7LFethUqvaW/qcwe1+B4tAcEYS8iJkfaljCDT
 UspFQVDk6ES95NX6vEGRa2f2fFt1CG4FocFslFvr++AQ7H/VDIloHObngodGCny8xWeH
 B67c+JrHII9HVisbkw+lrlOCJhYdd+o213DlSStKso8HuBXvbgx6cUzgHRROWs1gGafi
 3uyPq/QQl9UVAY5OHG+RaoWki7dOZKdQHI4suRSPYCO/ojC4aYWORplzG3nfjCQb5+FI
 tkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780558657; x=1781163457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=981fWpuAbK2bvrnCZZVrwADu5/ky6PA26Iw6kXj799M=;
 b=EWk3NmlOJtT6NIqfO7Ctrfd4YFFLmHEjeZdujO2EZYfW7DHHcrScMWdROTGr/ZOFri
 0L3RVlykecioriEwWag2/2BGLiLA7r1qPCE9rFh4j+h5YIRpOHV8iZDeuu0a+KuiEPhf
 hgF/endqJ/uf7SP/hOeGiWuBNWvORxH0YmnGsOCH/guqQPPtGe+ftX7vZk/EDaAeJ+NX
 QWBLOKhroNUwTuJ71xOxEzP2et+igOmClNKvNS7C6PC2/JBHQDmPkmoFT+IMdArUhMbX
 fgqnzzAMFiPjn18x/qz2npte1MDqZGpR9c2h4CDP9DkD+EfqEwp5+5C0RJFfz04Nmpum
 cyEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lJjyBaiu4uAtowWX6ciqVV0Dr96XybW/zwS7PSd0sH7vtIFHYmjCNcYDxmwdlmWY5Xq5XbF8=@lists.denx.de
X-Gm-Message-State: AOJu0Yys6ypTqhZ8bWK2gIO/imQ3+i6oq4M5agU3LPEIiSVFx+glzL8S
 D8Oiqb0w+kyQ1PHIylzT2oEJnCha5flfcgGNxcUvMY0gtD9PrhjkFVZDqP61HOYojFU=
X-Gm-Gg: Acq92OEzy7qEhT36J3IFvxoi2z535Z8B8FgE7itJL74gvkhVnmhc/dEwax1NDmj/bYr
 SvZ6kYN97aqY9ZvocoEdq3Sl+YR7SyXyXdsJca0B3S7wAun7P5MPM2rEPSbM9CW2tcr3H3SwW/w
 tUmV86UR+yrX8oB/C5PlMJsvnxcRBb5dr3iC2zhOVWMmExlnbkuqq8KQoeJcAI6VRvraVC7B5WU
 2qGVZd6XUtq1+DC3ypvPA+UNqTkyMW+70nAeS7UtuKxBzJcUXm5RwgCANQuDshZqJy5ewPIYfx7
 fC1PYMIIHDkSslxWu7RAlOghYDvbmtUsT765IO/nzt9ZBZGZjp8prZveDsPZsftnGSVsM4djJOc
 652MugswpxHi18TALFFZZBFwqaTbUqg0y/3RgSal1DK0Sa7FrWFJGICzUkCI3Bk7fPMniU4mqK+
 jrMrwrmYU1oGq48fBNQ/R0wDb7OTBoX4I2eDwykcXiGe6GW2hPqqZkRqm37X7xQBBs+3sLw7Ewh
 PPfHeIRxdSenoogCEzzUPfE1QXYVVoHaDM/eBQto/CeColwgmMyLLT5U2dO0cdIoFABz2k/YA1O
 8/26j7saDHYeLmmrazkNea4MOUDCpmiQeIZlkF+HDYAifoI1B9Y3TyBtfAYZxk7M+TQeFAEQhsO
 2wx4rmU8mISJDjvIMCtSiDrix4Xxs4zF6YTOls2SV19R/SzaT6xjZBm0YkPPsqcqVeQZXG/sLsl
 UeWfwH8FKq1wC9cHnV4KEbZ03Y+g/HCY2A4kyfUaoh5AdrMdRXDrSfgIHZoLwWop/aOLa4lgvtz
 zBjuN3o28rV7XL6dkLOeNtD+exj38i/ttkg
X-Received: by 2002:a05:600c:46ce:b0:490:abef:dae6 with SMTP id
 5b1f17b1804b1-490b5eb0aeemr101016065e9.19.1780558657535; 
 Thu, 04 Jun 2026 00:37:37 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm46436675e9.2.2026.06.04.00.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 00:37:37 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v5 2/7] common: move ram_base calculation to independent
 INITCALL()
Date: Thu,  4 Jun 2026 10:37:07 +0300
Message-ID: <20260604073719.48723-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
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

Currently, ram_base is calculated within setup_dest_addr().
However, upcoming patches that enable U-Boot relocation to the highest
DRAM bank require ram_base to be initialized earlier.

The default dram_init_banksize() definition relies on ram_base
to calculate the start of the first bank. But following patches
will move that function to execute immediately before setup_dest_addr().

So let's split the ram_base initialization in its own INITCALL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Michal Simek <michal.simek@amd.com> # Versal Gen 2 Vek385
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index f0d07cb6f593..ac4dbf89a2e4 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -328,6 +328,14 @@ __weak int arch_setup_dest_addr(void)
 	return 0;
 }
 
+static int setup_ram_base(void)
+{
+#ifdef CFG_SYS_SDRAM_BASE
+	gd->ram_base = CFG_SYS_SDRAM_BASE;
+#endif
+	return 0;
+}
+
 static int setup_dest_addr(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
@@ -347,9 +355,6 @@ static int setup_dest_addr(void)
 	 * get fixed.
 	 */
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-#ifdef CFG_SYS_SDRAM_BASE
-	gd->ram_base = CFG_SYS_SDRAM_BASE;
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
@@ -968,6 +973,7 @@ static void initcall_run_f(void)
 	 *  - monitor code
 	 *  - board info struct
 	 */
+	INITCALL(setup_ram_base);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.53.0

