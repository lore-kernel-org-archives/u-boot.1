Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F58CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57579846E1;
	Fri, 15 May 2026 15:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f00fM3Dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B86846CE; Fri, 15 May 2026 15:53:07 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4588846CA
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso81707685e9.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778853184; x=1779457984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R25wZyva9LfChnOjNMe8Tjuk8Tz3C++SIWoDQsrw6Gg=;
 b=f00fM3Dy9RaojvYBdhUEmhckk5pEbilJR7JA2U5f4EjjV2BrPwYplApdI+bG0u7v/K
 p995cAMPlYXxC6Egbh8rsWWsuOMVffpeo+LUldQjmS8lAZYKUv9obG3dbB+9lLjafwez
 7ves1uBNkbwgXxUUBIiaR8/FR7Cb5i9S9z9HggYO+FFAp+dCILxyGZ7X9Y6XILiSb8RP
 /4u6CZGQUTBTWSMvBdTYO7ie19sIksOnMXPEptxRQNQ6un9PJzufCJ/oV/11hw6J1+yz
 4wGq/5b4dxLGGiwPMnsPuDc/bHyrJ81GauL4860jMtuihSH+2qSzptOx5Qa5BOlzoQ4S
 IWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853184; x=1779457984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R25wZyva9LfChnOjNMe8Tjuk8Tz3C++SIWoDQsrw6Gg=;
 b=f2V/R9yh6Wjcte2GNUdGJ0FLgL0wo05LPjwO9qfjXejURIDocX+OOPjSZPNlNpNbLT
 nBpemQR7wPB2HZIcz8GKxvp7HTztEkxZ17ExiDgnHm2qpNSwV46cfwo2NtyWpCmXN6bu
 lJeUB4t6hjfJvjg8MHfHtxd7QkBWeY74+XeWGn9wZHOzsWvo7Nh6Edh0XIlDZ0ssAr4K
 l8R39qSw971v/kRgDCzJksbi7P/UznpY3foV1cQFeiFfENUiOELMzV8swoYeAy7/UT3L
 V+JP6rRd0mNyvRMj/m28yI6wZ06JTvluWSqsgcFcWNd5vHQbo7FlfhEpvzjaJayYIjRF
 EUZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZmSe/cNvtLsTSgo9f1puzOMvN91HuBjBtWxxBnb5q/CLHm3bw02tp8UyCGRasNrHJGXcC3/M=@lists.denx.de
X-Gm-Message-State: AOJu0Yxi9MAOgGy/n2fQ1UY2eD7sTkfgifcX9i8nbjmSQpCQQ5iXezWK
 Pm5Sdh8JsHG50HZsKj3/Rd3b/ZfvZcTnN/zSkuhuR0Y4L3SoLnDkRFU+c1teR47+kEg=
X-Gm-Gg: Acq92OG7m3jr0dwow1vemMtwAmqH0i7RVETUCdfknhT+Qvy1MfE56FlnEZpLF0E54Yy
 Spp1I2Xat85vm2eLAJlknSaWBZck4wYFBkwV+gCGNCDSu58DwcsqRhmcerA3MQYl3r4BnYQ/7mC
 EXQ592TEd6NUBC9VnEsyAtnBKPQRa+N5QByLpaGoLqquvVuf2LOk+3MEiI/n4PsokpuK90rI98p
 y6ncaF2fB382edwV+kw204X9r5cwTU6su9dXHAURSl3vWENt9Th9dNjTRuyRvjWUB9qVt/chN0I
 T6+vDi5yrkslgKucHAMx9isSxF60SWZxnh2ZEGv9uC6NuswRFRKyi6/7L/qju3jN9LkFxcVyBAo
 3OpmK/vGgmVlzSM8qGr64wTJ9QtjIsWnkz7bZVy1ZpPDPgHl+/5776dTpNINpUXAmfjoRVH6Sk6
 pdOASBU/F6vcZ6I2b4t054QLp6jN6v/+85v2b+bNuSs7ioR6FHsP9wRTCz1lRkEPkt44CV7KXgw
 VzVs+JJE481GsI74VAbI78I1Ty5riYtuTsYvaRE3h6LF1BiWQOkxMa9CiaHaqYjGXCw62Ia/7KO
 7W+MA2p0H/3R8uaW6fq+2pudmGXbUyY46MiiYYr4iPq05apzmf++YrSZPp/vRh7Raw2SWT2Ci4h
 O8o5HqPWFDZOmccUMsr4W1oGmdPyDkg5A10U4vu4RYnS98S33DPiPCo+8c5z+QwHE7sYEzkTUfE
 9PX/FMwkhXgYNyaolZNWx6MB6ER//aXi127KDlhArox84vCH7VUtaedTfkoNOdwPu1AZWeZf28R
 +IY5khtVJF06Zu0nCG1IA9us4SLktxPQNKAIlk=
X-Received: by 2002:a05:600c:3b28:b0:48f:d835:e0e1 with SMTP id
 5b1f17b1804b1-48fe632678amr56559125e9.20.1778853184273; 
 Fri, 15 May 2026 06:53:04 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm65854525e9.6.2026.05.15.06.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:53:03 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v4 3/6] common: Clean up setup_dest_addr()
Date: Fri, 15 May 2026 16:52:24 +0300
Message-ID: <20260515135245.45067-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
References: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
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

Right now the function does
- Re-adjust the ram_size based on Kconfig options
- Set ram_top
- Set the relocation address

It also does not set the ram_size in case ram_top grew
from it's initial value. But ram_top and ram_size should
always be changed together.

So let's make things a bit cleaner and move the ram calculations
in their own INITCALL

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Michal Simek <michal.simek@amd.com> # Versal Gen 2 Vek385
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index ac4dbf89a2e4..f58061026f8f 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -336,13 +336,9 @@ static int setup_ram_base(void)
 	return 0;
 }
 
-static int setup_dest_addr(void)
+static int setup_ram_config(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
-	/*
-	 * Ram is setup, size stored in gd !!
-	 */
-	debug("Ram size: %08llX\n", (unsigned long long)gd->ram_size);
 #if CONFIG_VAL(SYS_MEM_TOP_HIDE)
 	/*
 	 * Subtract specified amount of memory to hide so that it won't
@@ -358,8 +354,17 @@ static int setup_dest_addr(void)
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+
+	debug("Ram top: %08llx\n", (unsigned long long)gd->ram_top);
+	debug("Ram size: %08llx\n", (unsigned long long)gd->ram_size);
+
+	return 0;
+}
+
+static int setup_dest_addr(void)
+{
 	gd->relocaddr = gd->ram_top;
-	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
+	debug("Reloc addr: %08llX\n", (unsigned long long)gd->relocaddr);
 
 	return arch_setup_dest_addr();
 }
@@ -974,6 +979,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.53.0

