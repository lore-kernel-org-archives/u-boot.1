Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E24C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F0383242;
	Tue, 29 Jul 2025 18:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RKPS6BvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F4CA8320C; Tue, 29 Jul 2025 18:08:22 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1475882BA1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so2206915f8f.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805299; x=1754410099; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ixnRNmkaOZJHy7cGVwXSXBlNptgmGA3Gk3BNg9NfPhE=;
 b=RKPS6BvP1/XzhXsYHm+h4aaODTz55+sLP0aDVa4NH9Jup7vhAKq/VDBj7wiiLSLWic
 x6cMVus89V9cBQyO5IFPP5DnN9LpXf2MCgI4BGyKmb2MgWnhUnwg0hCJ+mgrLUGQdunI
 xOorMSGSlTmUEcgO0COk+Y7ER0fASR+wr9uU/Uq2vDHGirjzChqQhYL4YMyNv0doqlZ+
 sinc7cUzHJB9tFeb/xaST+XNjRIH1qssE73vtCfF6XZvuVim+ye3NoyDocEbMV/uADUa
 llhdzWbbuEigD+uQg4oqgxUlYurxbUPHAJvLcxMpYV8slJRLG0+QGAUi48GUKgMEr/Qd
 4Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805299; x=1754410099;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixnRNmkaOZJHy7cGVwXSXBlNptgmGA3Gk3BNg9NfPhE=;
 b=hkGvIrpBiAjDyLRfq0GFoT8kSCA7eihFbBScj6mBmyyka7ckpnDH5wBtrowP6MxUQh
 fUQHvy+kidyjgwjA5y4YisB8wgxmj9fX4vfdWAvUC6sIttDF57X+unCVWHFwnpdWI/5e
 LFjguuZndw7JP+V6Gv5XjCb1HYdHxjoxQXbY/umPamkS5O/uSwTrNSl1REeXyH7dZhKa
 7mdvPbx1+0/rppGJSww4g5v/tGtRl7dex6oXCCHWedVDt+/+HPCTpcJOT9NK6jG0IZXu
 X5rA4S3yIFjGpZQRdU3228KNzmuTKM16JCG5OiIA3KSACK6PfzcLnoP89mEo6SAm00di
 JGZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZKLBc7RtDXk3r84bJeodKibF3A6EdBZYgPW3Z6RXahkUZzlVZcPUbBLku2v8VNiF44oTdR8k=@lists.denx.de
X-Gm-Message-State: AOJu0YynBVanLWho/1NBTpEfpzLblDiX8n5DDAImJ9OIGTxK/+TVluxt
 yvErTrIObUO2yJNfbjSjedpjnzNYuYaYBoiOu8YAiBwjj/mXvd2GqU7pg3Oy+jb8Q7A=
X-Gm-Gg: ASbGncs3H7bYBvDow7449QsVBSMgFhlQ9Lq8vpz3KBAVQqvPIT/mchGWGCxGzavMo/h
 3048oIwi2xixE4Nm1erk2Knym4r5WMD5JjAV3Tg0lRAKlBVrINaU49R45GRcjXDyRXc+9VbLkx+
 w4y02pQOqEU4+Wi4ztLBhnK5thpjIf3ohRQCHcrlHkV8p6J6o0p4b90SN6zTlBGRi02zk0nDyiw
 qYxLb/IJJqIY3R5LnCjB5bId9dS/QGZJaT5VxLCP7nwrhlRFKodvZCn+y7d9P3GXufYuNcdegWz
 mOMSKhms5sWUreAtq9e8x+7IE8a8yLs7zUojTAvIIAHL4zRxuU7sxRKjPCMBmI2LrrsEPhh9+YL
 EmqLW2cXQpjstIR79eDUjS7DhiubriGY5m6OyKOHA4aDhmTssgmo7o6MMRZdJ4mm/YNzndopHF3
 DMz0xMaThWI34JqU7Y6oDX
X-Google-Smtp-Source: AGHT+IEksBBHbf513K5C4JXMZ6z7+wVl7QJf7QLXbnTwwd5vT+g2vlt696gPPYb+WhSKy2IzcGn8ew==
X-Received: by 2002:a05:6000:200f:b0:3b7:6827:eb24 with SMTP id
 ffacd0b85a97d-3b794ffd763mr180636f8f.35.1753805299361; 
 Tue, 29 Jul 2025 09:08:19 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:08:18 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:30 +0200
Subject: [PATCH v5 09/10] lib: expose unwind_stack() and call it from panic()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-9-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ZnZHgX98a7mBEpKdFem5orAAhy/9tBHHynyS4ucU5Sc=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHCTiPdfGrPGS1r825NT6hPaJFKRuxdugQDv
 JYl5OBy0tyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwgAKCRAFgzErGV9k
 tn/0D/9PViKd5VGIfOibLq3G/bUi67Zj0o802+t4/0ZqPgHcTITt+A1YaGnhhxcX88ctNjzjFtQ
 BWG8I/5j8KyFkKQ26NRSvdbyGBeUsD8uyIVcGU4iTW/HRKVjDKg8dhYt87kt+SJTnFufq4Mlp/d
 BkghG0kuctSYBQNMbg9NIkQslF8No9GOlfpHmnO90kNNOryPNF3ZSQeFqHA7P2+le8rpM6w4D42
 wMAIs6fRgWfbheIYl1UrAl8H7tTc4Exs61NUL21LtHIP19E3u53nSTaDMUvkX/xBCWwc5PVSiAk
 N6Tge+ejtFgyQx/iQIXMJ1DOH5+N5OaK/lqZHMuE0ptI911WgU/S5F87a/i+fikfi2tA/kuN2A9
 3MAqYQPvVAnthzM4vAPhrQlSyDrOTs5hZsNFgJ6vPFYuw/iXIaKbWzMAwjS5uj0xpZfJdQV8yTh
 Mt58izscHaxxzidYEofErTXq1G5dxWguihUjMaXnNSxpENsRq/inGqbhSr7FEjxW8i6/H6cpmhy
 5+iEyR7M1Ee1nKJGOxL5JgtxTl8l7vlcewkKS8dwb/2gom4a1irnCUgZH+qwv/qNyuISAY3zF3z
 pv2eMugBcCC4vfCQz7D5X6VDIvMIVo6LbHva4g/EZdfUF0LYNf0Krz7vnaYm0cVW0lfFuVQk7bq
 e8NCUH88x9ZxO9A==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

unwind_stack() will walk the callstack and show the symbol names
if available by using the architecture-specific framepointer
implementation.

When available, call unwind_stack() during a panic to give more
information about what caused the panic and help with debugging.

Adjust the interrupt handlers to call panic_str() to avoid duplicating
the backtrace.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/lib/interrupts_64.c | 4 ++--
 include/symbols.h            | 7 +++++++
 lib/panic.c                  | 7 +++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index 973ade4b3b2b649b76fa6b67742a247dbacf7ffa..949ae0f94168fd53036c1dff376b574808ebf9ea 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -228,9 +228,9 @@ static void except_msg(const char *msg, struct pt_regs *pt_regs)
 	show_regs(pt_regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
 		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	panic_str("Resetting CPU ...\n");
 }
 
 /*
  * do_bad_sync handles the impossible case in the Synchronous Abort vector.
@@ -279,9 +279,9 @@ void do_sync(struct pt_regs *pt_regs)
 	show_regs(pt_regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
 		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	panic_str("Resetting CPU ...\n");
 }
 
 /*
  * do_irq handles the Irq exception.
diff --git a/include/symbols.h b/include/symbols.h
index f91f249e7cc49e4bce338517b5d00624a05360d5..845f993060f042139df46bcc51a0180faadc35bc 100644
--- a/include/symbols.h
+++ b/include/symbols.h
@@ -21,4 +21,11 @@ static inline const char *symbol_lookup(unsigned long addr, unsigned long *symad
 	namebuf[3] = '\0';
 	return namebuf;
 }
 #endif
+
+#if CONFIG_IS_ENABLED(FRAMEPOINTER)
+/**
+ * unwind_stack - unwind the callstack and print a backtrace.
+ */
+void unwind_stack(void);
+#endif
diff --git a/lib/panic.c b/lib/panic.c
index 0f578b5b5131589d215f5f4b16b95d9c9f3e8ce3..6f8bd7cc1eef7e5d97ba925bef65cc46924b4418 100644
--- a/lib/panic.c
+++ b/lib/panic.c
@@ -14,8 +14,9 @@
 #include <command.h>
 #endif
 #include <linux/delay.h>
 #include <stdio.h>
+#include <symbols.h>
 
 static void panic_finish(void) __attribute__ ((noreturn));
 
 static void panic_finish(void)
@@ -44,8 +45,14 @@ void panic(const char *fmt, ...)
 	va_list args;
 	va_start(args, fmt);
 	vprintf(fmt, args);
 	va_end(args);
+
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER)) {
+		puts("\n");
+		unwind_stack();
+	}
+
 #endif
 	panic_finish();
 }
 

-- 
2.50.0

