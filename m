Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C312CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B204E846CA;
	Fri, 15 May 2026 15:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hQggVqnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E407B846C1; Fri, 15 May 2026 15:53:04 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5963A846C1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so7562835e9.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778853181; x=1779457981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=981fWpuAbK2bvrnCZZVrwADu5/ky6PA26Iw6kXj799M=;
 b=hQggVqnITIhpHhO22XXnpZH2rw6+g8YkrWtIEtpFwrkZ5uw1ecvyCwHKBQ9w/64Ug9
 615so0BNCXGTA+hVw9JH6mwlfgT88LXLNSslasNV2YAfw6J/QHmIo3zSeyenHP1U9sx8
 wsFLa3zbtFkFEuCvyR2eeymOyjWrJmT21ZXrmH1e0Q6HL3MEuu71kqp8olhkRbMykXFr
 OekE5miY4xSrTQT74AqTXncksKrIbVcVRvd1Sqb7AxeE3K065cDvBwcf0s3MylOsh1oi
 9IO2TWwFGSvO1bXUzV6V2pkcKrVkVwyxkzAs59hA37PJm1Fy7B3OQcADz59GIWvYhoig
 ZABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853181; x=1779457981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=981fWpuAbK2bvrnCZZVrwADu5/ky6PA26Iw6kXj799M=;
 b=SFmSinWy0mnAF4nIPi44bUB9ia3Do/yfRU5rV2VRxopUyU2cVjW0BJ8foFfB2i1cjG
 Fx9oUirxnjJJyCAQYqcICYW2WYU9r/gCpb+We0wXIg+di9hqACu7zpBZ3tsyPrtcgzzg
 xKlDnVodMrH2pdc5C9EdHKBnAJD4HYFmYR9tsH2V11YxJi4OKqwA8jpg3RWobX1/DHp2
 yGm9q/scNIr85UK0q7aiTo/DgnikZVq+KTfsW0YV/s1dO6B9qBUX0+hPpGUAlg6pCK24
 B8N/Nh/iNuaRDXtOITISZbdKCnWfqrYR5BOoHpS63CCpMnCbVG8d2mKOstCsWm2GAfsq
 UOXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oXqCwZUwP5NY6kaFjPj8E56OqDp94xOkFtrnq9TylqeceugLPDm4sdS8yIW0KHAY3nNRB7E0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6tyGK8s+/utTpeR03WdeRgUJilgt3MHA3AjfnbVu3ErLGtfSs
 HBDsSgZW3iTBGyWGAeCPd/rKXqOQLKi9I2J2m/X7vqwIimoDQVnpEDiz8REZrNzmVAF8CsicC36
 PZnvKQpI=
X-Gm-Gg: Acq92OFbAotwRgClCQeTl92J5YUp/Hnq49zMFw/qHYZE/SSXIAUk0owp8ePqyvm7jYO
 WQRLUUhVdpZlkYKp/hbHMCfOFL0bVSGViXu4B5627A7WnMuaPuRPqqpQMS2NdcYofvfC2W7JUay
 EZNBF+YghWYuN5ryGeFgkTQRseJ9shsiGhpxbMvb5Q0hFmOm5rRD9FmcZ/oLG046W3tTd84C3xQ
 ml/WJbfc1efi/EeLzAyVxgfMdr649umiEGbLsRxZ2EW+xd3gC3ed2kW2GtkRgFa8niUawEYjPl7
 /Cpra4LMNU2RV9Q7U957WfTa76uxzeokNEOYTHI7CjiYv4XiMZ+I6dd2UZLALuerZTiOQIl1nWV
 giueTwjzJpgkXqxGu/7/lHRxm3/TcwqozqYKC7gEpALtAoT5cmKweCUOhSZO6iNfxohj2VZpFJW
 di1beUdZfUHzFKg5M4c/7YYfTm2cFx88B+XUS7Ibf6Hg+coFpBBCHl3E9qmdJBy9K6Wa7qyhR4y
 SJCGotx9pvRD6nZZTrcLQ7F5K4DKlBxMHK0zEhna+Hm1S5n+82b2dKe5PvpHkONHKbPYnpG2Zri
 heEiQ1DFQF/FnZHg/kx+TqY+bvUDa2LkqaT+KlnQhrFphr8zlIBoF1dFdTsLCDZ5AYlHFcUzgLF
 llj+B9bK94njMsGWG2/bPDKjrtQ6q+iYc6EXqpy+0s1uT188yXZPT0WY7ztxwwue0MFZNJRCWwJ
 mumSuNWdp9FxmqeJbetz/iujj0FlKFuKWALq5tXUxMQ/rCW1z/ImHWdCwv+RYf/msR7Hu/jpLh/
 RF1o8HSsFr9mjft3MRV+VUi/KGR
X-Received: by 2002:a05:600c:8485:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48fe537fb6fmr47874765e9.9.1778853180820; 
 Fri, 15 May 2026 06:53:00 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm65854525e9.6.2026.05.15.06.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:53:00 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v4 2/6] common: move ram_base calculation to independent
 INITCALL()
Date: Fri, 15 May 2026 16:52:23 +0300
Message-ID: <20260515135245.45067-3-ilias.apalodimas@linaro.org>
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

