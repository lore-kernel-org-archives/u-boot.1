Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59421E7E34C
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 09:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4E8084099;
	Fri,  3 Apr 2026 11:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CCUQV72F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ADC2840D8; Fri,  3 Apr 2026 11:01:31 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B81A840B0
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 11:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso29851045e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775206889; x=1775811689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNpRiTRumzrfwtzL+vT/x9f1trxIcBJlD560q/MQccE=;
 b=CCUQV72FEvUi7xCQHSYCD/hok2tlIK4fmM8+X8Uc9Cuxs6ny06n8+VzbudP1PUkoSk
 HhoVoMxrIMfGWeN5xheQs9aCx1EeLZ+/WEziIiV6woI4e0Q9jKph1XcBzfDhTrHO1r3A
 fJniJ3AiqNGHa4kHCs2PuFKjOFezgcVUHytXnIdsIW1Kq262WuXGdWoaS88kVptADgYu
 mtonNTtQhW6uOGOA0Xiitipt0+PDVVS52WUV331IGc502FCD4xFgahelPC/TRIRBP0yn
 SYazBNEbXCf/0UcMWR1lh51LSIgiu//E0YQ6tsLwAlhSon3LjScwio6glRvFf9ExeD+5
 FMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775206889; x=1775811689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MNpRiTRumzrfwtzL+vT/x9f1trxIcBJlD560q/MQccE=;
 b=nuK4wTuHPWzpEmDn7igVk7b4ly5ZB8PTqKrZkmFQA2W22gmR1mcFgRkEqBFuhUw4W5
 /uKIk2iqP2mLG9wBcIu/aTSw6T7EfoZJrhQiwOz2HAWskrlNc/gzEABiAyb11A1JuIiH
 qTvKY0QFTk+331PkF1RVQrCK+v06rGxvmJhZVVJ6gFfgE+2+L4H8LqdqiZejdqJ05lqx
 DmVYKPXckdG46HxKDXL1SzR60eFvH+B2uIiEd3WgqgEKvXsRWOwx15LV9ZJb5gAv1HMV
 X7574e1tcg/GXefDE0sEAEzaP8yfR5ebNoQF3mBWS/CFLednTreV6XAF5sUyXEihQMvw
 L7Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDwh78SwjUrloQb9jxWYxTwH7/AFRGgOaH8hGuLDqGy+tgBUsFVL9cLvqaqpXXku0o3EbJH9A=@lists.denx.de
X-Gm-Message-State: AOJu0YxTOUH+wfeGPBK4bF+EiigIlTjSJxzmcFU45XJfpVItJMm8m4BW
 PSjrogOkEDAyHN0AukmIekBrZyH42b4n1Lyoj2dyFVfuGznPdo9rVCo+BPdZk+T5JrU=
X-Gm-Gg: ATEYQzzhCX4ITtEiY6/qMdfCT88rMOLi1q60QXXirIJYczWbXgA28qGxndI/o6XTXs7
 2apJrvvivCZBikUy5wuRgzO1TlGLNV/Vd76BFrw5dLMyA7t78LmJpZNA+9l7xhs07/YZaG9lFkN
 Xix9NGfi4imwMz3bgCyA9ZsoS4HBxMHMfNB91UPJo8JWclG+dXWILEL5gBzePFKbDKkxLB9wM1D
 2dDuDn3PxAy99AoNtZ0e6SdM5C+IAQXWPdCDUhexCeXvmahLPCkQ10KYtV5u9gEM1RUHhZTZwLD
 6D2PPN5LkzU+XtJ1Q/bFwizFoy5dfa58Qu5/z6QrJIzpyznAgFhYwilbSE9rXEWYyVK7xR205IB
 y1JK5eog/UHvQ5m/Ao+twQaS1ioGx/AvXn62AY+FUFe3kP7eIohWtShJmW+pOTtlcTGm7dC46Bt
 79Jt8h5hGsGqj8Zpppku2zUoCeQGS3JYCOthrPp8VsQB3gVN1c8tXQVZmcxiIl6Qs7PmwP0S18o
 AMWdEpeM//nCYArg+fJvuHtjEoEhKMnA28y0jRzCS3Lh7jpyHTZzS/eGHn1HKoz6Qth2zdLQ8Ss
 s0pFWkn6n9yFcbooYoDICKcgpiQwrkT7fJjdyTJE/yPbj4fdizPmuukuLHPgwAY54xDH8En7HC5
 sF05F56TNxrDvTXTJEyuR/ivnWD412DeqJta7lhLJLRqp7PADnPJWu2E24TuJaSsX0au+vvFqKj
 0+kgU3bLOg0rw7jcvmsHay16GbUBYBkONoWhgCc8u/sk7dC1vNx9XxQs1kBsDm
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-4889945f8c3mr34261375e9.3.1775206888450; 
 Fri, 03 Apr 2026 02:01:28 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e967badsm332528545e9.14.2026.04.03.02.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 02:01:28 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 4/4] common: Add an optionto relocate on ram top
Date: Fri,  3 Apr 2026 12:01:06 +0300
Message-ID: <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
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

It's worth noting that there are cases where we must not relocate
above the 4GiB boundary (64bit hardware with 32bit only capable
DMA). E.g This will break platforms, if the ethernet
controller cannot DMA above 4 GiB, and once U-Boot does
get relocated above 4 GiB, the packet buffer which is built
into the U-Boot binary is also relocated above 4 GiB.

A previous patch moves the bi_dram[] info from bd to gd and make
the memory bank information available early. So move the
dram_init_banksize() INITCALL before the relocation address calculation
and use it to derive the address.

Also add a Kconfig option and allow the common code to relocate U-Boot
to the top of the last discovered bank.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig          |  8 ++++++++
 common/board_f.c | 17 ++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index ce25ea24a60f..b25e7f25591d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -474,6 +474,14 @@ config SKIP_RELOCATE
 	  Skips relocation of U-Boot allowing for systems that have extremely
 	  limited RAM to run U-Boot.
 
+config RELOC_ADDR_TOP
+	bool "Relocate to the topmost memory address"
+	help
+	  When U-Boot relocates, it chooses the end of the first memory bank.
+	  Enable this if you have multiple banks and want U-Boot to relocate
+	  to the topmost memory address. This will use the information of the
+	  board memory banks configured with dram_init_banksize().
+
 endif # EXPERT
 
 config PHYS_64BIT
diff --git a/common/board_f.c b/common/board_f.c
index dd5518b60db4..2eab344037c8 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -339,6 +339,10 @@ static int setup_ram_base(void)
 
 static int setup_ram_config(void)
 {
+#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
+	int bank;
+	phys_size_t total_size = 0;
+#endif
 	debug("Monitor len: %08x\n", gd->mon_len);
 #if CONFIG_VAL(SYS_MEM_TOP_HIDE)
 	/*
@@ -353,8 +357,19 @@ static int setup_ram_config(void)
 	 */
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
 #endif
+#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		if (gd->ram_top <= gd->bi_dram[bank].start)
+			gd->ram_top = gd->bi_dram[bank].start +
+					gd->bi_dram[bank].size;
+		total_size += gd->bi_dram[bank].size;
+	}
+
+	gd->ram_size = total_size;
+#else
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+#endif
 
 	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
 	debug("Ram size: %08llX\n", (unsigned long long)gd->ram_size);
@@ -971,6 +986,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(dram_init_banksize);
 	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
@@ -999,7 +1015,6 @@ static void initcall_run_f(void)
 	INITCALL(reserve_bloblist);
 	INITCALL(reserve_arch);
 	INITCALL(reserve_stacks);
-	INITCALL(dram_init_banksize);
 	INITCALL(show_dram_config);
 	WATCHDOG_RESET();
 	INITCALL(setup_bdinfo);
-- 
2.53.0

