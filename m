Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E99FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D608421D;
	Mon, 27 Apr 2026 12:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SWgAcmUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E918407D; Mon, 27 Apr 2026 12:08:59 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A0A80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3870778358aso79620011fa.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777284536; x=1777889336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R25wZyva9LfChnOjNMe8Tjuk8Tz3C++SIWoDQsrw6Gg=;
 b=SWgAcmUGL5Zi1E1fiKfuYV2+O+omIW+Ut1hyDKriJfN9WoBHwVU47T1mTsD/7D6RYj
 dw8cTDqDoZ93Vp9t60OU588MSDhQH75SIK5KM3h0RawZx6gRvWImZMaY9evTfRZRZcXw
 wrjr1yNSCLeuObb9bbEnrxFS8ZnrccEnKPEdD2GsR0MmjcEAjZPYSZQLUZ+IMQSwfHqZ
 Um+qSnLamrr1ozF6kHTq57PDx8ZsBQ1sf+oDNa+ySafMuYzYvVn+11xtdd+kzM+Oz/2y
 RGTCj0RiQvULX2lCE1ZtHdF3ZG25jz7b5j09/kzrSBVbUDUV9+pg1CRbFYS2yMtQV0bN
 g6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284536; x=1777889336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R25wZyva9LfChnOjNMe8Tjuk8Tz3C++SIWoDQsrw6Gg=;
 b=LKJivlhcePLLIkwPhiiRni3fCmAbaIxPoxQkV7P04eJXsXqZ/0N8mVkMBXSqHEOVz/
 kunp5tTFLad6UgyxaPSX/8tqQA7mzI/+HtiCjzW2L2yfdKNBW9sdX36YnopTL/MJWr/U
 Ot+IVKG/502NGZjfEl3fwaz7KV0UscXp1kpgH3aIZto1VeLvo77WuSNFN9jxE9YTje7m
 dcfIcGgTqv9iLxxzE/0LdFw5KcTvTgv5XDKplO8dt0hUtQJ1N7+qhoVRguesZeNqMsD2
 GfO6tX5AKzxyx5ZdMy6oegQlUA/OJyTr6+DAVt/PnlIX8x9EhU/Zx4GjmSyG0JMDAoMR
 zjXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wPJw+cezM6fJBAKp/lPd2rvn/fUzSsMdujECf+Y9yWGaChwSzlS06BjbhzvBzyYzriiCH9vA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/N7HXssSRpreNCOZ9NcVOihphQn08pa/14GF3OrAct5DPvz//
 c9xVgzD9hpFi+QmDtHFLSQ55ADgkJHS2PruPz4ouTc+rRoCN1GrOm2LeUMfBzzUPC1I=
X-Gm-Gg: AeBDieuYbTWKb7F+XKoWlyNlI9VEC9u61cxQjT5Y4vvY3NQv9wONgalBTbOOPreu0ac
 bAKkApjQDBepBz244AqkVfSdpm/7kwfCRwB672y4IhNHoEroj1QNR+0iGfPP0cPNDZGDInqFS+v
 RKp4hXKmcdzRNQlurkFBd4Y+NvZcA8auXHyGbBqwB1CqtaobA/h6O+XDXEPBHfgLIKF0R2MLaav
 2+YBGB2HNgUSJ2FiJ4dbfrCcwkemiC4wn0ywIpklMYk2hz3OzNnbLH8NZBf7hGIX+TzQ1AKd61o
 22tDExhn4rtQ2WPqi1+apzkY0Ugt7ERPImbtxUkr+4+crzrtOVplXYjgeXc9SYTvpD9wtTE4AZF
 NRrgZ7NnlPrto58IyEt9jMK93tln+H0XUsN02z/3DJ2V8ns6YJUy85e+r/b9P2JqYYO2LD7Uwfd
 fuqFG4RgppbNzZcclRUST7wpHRe2ifSBxxiSjjdqkMq60MwHmQF8MFKeqgmhrMtWIczsOeZBv5W
 D0qB32W6AfEVP+iofvMf4aVbW7jsJOiTDDRQq60TfWtZtqgOWDBBpSg1B/AZE3CL6KAUjLKeNA0
 mfqJj881Zd5nGivKeQGF30+nKsLDNSNFc1Zmr4NWsqewTdiT++leWiUF0B+8DGe04K10OqVmQSz
 nhpZd6/B/XoBzbaswiYlJxmUznsY5X39Q9mkHSjxTzqxD4mYbnZ4n0tGO3sS1x6WeQGRxGR6HMd
 0iord2kaFdtKN+Ni3TjT3tSLpWSyXnXZgcxKQY69/rXedtmKfjYT8GhdFOtO3vgdGr/vaQZGEaS
 docyFM9M2hMBCDD+ObqlNUBP9Z0rl4N0+D+
X-Received: by 2002:a05:651c:1a0c:b0:38e:26bf:e5f3 with SMTP id
 38308e7fff4ca-38ec7818e74mr140368781fa.8.1777284536144; 
 Mon, 27 Apr 2026 03:08:56 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0b88sm68554791fa.27.2026.04.27.03.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:08:55 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v3 5/6] common: Clean up setup_dest_addr()
Date: Mon, 27 Apr 2026 13:08:26 +0300
Message-ID: <20260427100832.581887-6-ilias.apalodimas@linaro.org>
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

