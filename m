Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA14CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 07:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE1684895;
	Thu,  4 Jun 2026 09:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iME46p0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11577848E2; Thu,  4 Jun 2026 09:37:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEDC8489D
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 09:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso4558945e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780558659; x=1781163459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R25wZyva9LfChnOjNMe8Tjuk8Tz3C++SIWoDQsrw6Gg=;
 b=iME46p0HRB/M0Iv6HQUiwFACmlc+YqyWQ/8RNT1omGfxE35S1O9iK1zg8acuDKiH5W
 v3sS+3LOuIrPtYDJmG6mZYadqpHxFA9Dnk6Wzg1C0HNVF29rSfnfk+2ICFC1c8uzWSH2
 Yd7jcQJ9p0KMVvvS2xGgzWUaBPg5L4etTfc8SeBx8uE7S8U4HPhqZXkq3lAxH7hDhZnM
 r6VSRwGGkZLQfG9xiVd5bmlVknxUAvFz7VyAcE3uAYC0HXBKOIY9v7ySj9dsLxes+t0w
 alBzL6qtJi3nUgutuBH8ye+fAHlYm01DedKTkc0sMmJU7VMNW0Ai8FFlivnYvt4hgeJS
 IWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780558659; x=1781163459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R25wZyva9LfChnOjNMe8Tjuk8Tz3C++SIWoDQsrw6Gg=;
 b=Y0bjt+86Qu/QVAX5M53z/MNjxTfKSNDTBrkqjAq9HoDiz3XBH9+DkfvbMrLixWnfvf
 g6yK63/SLsoxPMvf42BJ3/ApRnhxrAUkIC6eJuEn8nR4N+1b6yd7NH3of5QjCWSNy6nt
 F+czailMjJ8GjKyTggUEaw1BzVV0LctQGNrHYWKtZVOskRhFTB49uEi54X7y8fQqZCh5
 60JbYPEs9+jV0e4AtvOAqQjE79MI9mEeEYFFFJWmdw4FRlEkSNdtY+fdROb6/H5eG4U1
 siaNVSG44gaQOnTtth6E5bRi4FeZNoFYq6iERssnPKITVMiOkp7WDtHQEsbHfGRFTAl2
 0Lkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ949mh4umWRqitoNpKPWPAPcVs71zpViOsTPnifueziUbSScVUXahj5jtLDd5+CGAwMENGLoT8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxrbp/PIKTvKy0Fz4KFkOgitcv48OFD2WIhUGZg3qgDHGjzGORd
 TE5Nrw3/CW/cfGtq1A5GirDVGJs1Ffvb+SI/b9ZnaM5CQlsJRKxDCD//uL1kpkNGWEk=
X-Gm-Gg: Acq92OHnVGbMzpVcoG6MDGZUmla1H/IqQCs/ziOKFPUWOSoXV7l5lrWS6maaHezn1Se
 HXhT/Xu+lJ9Ra3FCtpjsWUyFkB4bLK4xefTbX/7jBhr/5M3ZO2nmzgyBB8+hrIykcDv5ogkmb1M
 aTpTPNo5xBezEwhA8vWZmWjouFsfWfeFurId76X9NDELbRC4ApcJ227rZWFHWcHsvKlSM3aAwBP
 28H/jjTL1H2sKsq5iWhOsop1kScggKQ9xDiVWbQXbknL6yA7ihEGG/J9Gw4XZ5miwkEJoRRecAM
 ARgiMR2eqcVrDTfXj7N1TjGGOOrIJ/V1i5DCEAO2DATKUHlubSi0dHtIrhaEv/HlFSsqI0jEOFN
 ldUClXdnKLOzHZCgKZlREEQPcZTpNe4Vw+N4Qm8BpbScrBNrLAQHjQ/4PXmXd26ewI3DzD5y8Rs
 VVFHvVi0F8Gi4R0ATAWT5hCslR0aR6vyVmCaiPvKV+5RhA8n0SzKqm3koO8kx7Syrhm8FGy6G4n
 Ab2sjDZMdY4qXHRVhWxYSfCJv3QEfHaiJOkaeVJD0UiHJIH9J/dCoRvJBeKJtbdE/zzafS3Ado8
 W7fPKtUBfR7VsLi/vaWHBv3uSKPiaQo5fnhRO8JSANh5crCShNXrqYHvytUicaU/1I7vi3aOmY6
 PttU23c3RWekQlLulPwoAQ9lI7FA/GXAAq2z7B10Mr5EZKH/kkvdOReZ4d2AvHYn9x3PAluZRjH
 WtF9sfqIL/6M88xroIf2oTlhEYUF84Ok+ydSOsVzWU4TXQZdJVRdVVeHRcanniuI6xXqBxCD7FT
 iOmR7N/NOKAm3HOJTmJaEEJpmz837GMcyCA+wKn9gswob4=
X-Received: by 2002:a05:600c:a0c:b0:490:bd66:e526 with SMTP id
 5b1f17b1804b1-490bd66e5femr30306495e9.32.1780558659422; 
 Thu, 04 Jun 2026 00:37:39 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm46436675e9.2.2026.06.04.00.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 00:37:38 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v5 3/7] common: Clean up setup_dest_addr()
Date: Thu,  4 Jun 2026 10:37:08 +0300
Message-ID: <20260604073719.48723-4-ilias.apalodimas@linaro.org>
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

