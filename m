Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0972DC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA164811E0;
	Thu, 27 Feb 2025 13:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yuT8Yl3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1083D810EA; Thu, 27 Feb 2025 13:16:05 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E00801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abb86beea8cso158627166b.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658562; x=1741263362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVfIOgHxpE9oah2uVOuIo9KhwUxCA9wrkpQ/cElJizo=;
 b=yuT8Yl3nz0C656ejHziEFOe8g3O+LwGUXAHFjV7PaxcBHql3saKsdmC1jC6zhnFZ/l
 EWXQcmDWjdp5ytv9KAcUyF9QbZoSzG9iCRyRVduZ8O5kzA58UsJ8Cz/FCRPKAFOdPrnB
 Sfx7NqsmRD2gjsZXG6XR3ULyUey9BmOlZlnyip4iOaJGR3ua9xXq54QWVtRxOkzLn14y
 lGfLFQTHaJBZw/sJ10/wBUzKM7k1xRVgKooWP8lZJ9EzmOrKal2hfqE4KyIYQEQ+ShRU
 b71qmtaQ2cbe52ugoDOUyq+FT9INnrrASXs6kmtWrsrXo2zGBjRkdUv8iAttB3/xybsK
 Z3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658562; x=1741263362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVfIOgHxpE9oah2uVOuIo9KhwUxCA9wrkpQ/cElJizo=;
 b=HP8Flx/AxON743/myKHTtVoBf5yyyoy2dSUKpX47SJ/08vOLlXKIG+hdbQIr+ze4E0
 ZPPGQS8bMB0NjXJWZyoIK8tR81Pqyc6Uh7oi52RJQy8sqbVrtCGkStdC+N0vTL0YHjmb
 8TTFNi4ttdLViDT5ZK2dZuUeRwNQXQxskAD6kbSXaoYY5H3RvoOMd+z9s4nAY3j1UFYj
 gAzPDb92B0yk5sRQhIxxQoKOh7wCiCC/9PR6jUwNzhND06eG4fte4dqGPGb8AuZDw6UO
 2p73KXES6TFp6qXpO74cS1B5X4qZzccBPO/Ac0iZP2ns7zKi8PTNVu8xHreEGDgo91wa
 u04g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLZTnHe+cMKk5MDDUimtHxce0ZyAIdHo8gVX8XP3Gw6jMZPNZbgF8bxXAOWX5SFH7PMS+Ln7U=@lists.denx.de
X-Gm-Message-State: AOJu0YxMQZxpmNXIjx2sjQKBykXTfeUFQrDQFqr+EEBvoCtaBDn1gogQ
 4IxF3P2IBQugIJW3Bg2iNkJEAOpsAkbF6zA4yB/lQMwIUN6zWNJldwwwZGzYZGg=
X-Gm-Gg: ASbGncvF2pkDJAmBUCz/i1Fm/zNmxCYlng0y1yuTX7oO1xmDua9sw5Tx+RT47nY0xpW
 3oLed0/XSyqnEe+zNXN5C5LWRGm4EgCEYIsgRwCOmWST0ldxe/e8eGSJ9Pr0jiNiDA0LQiXXT/x
 jpDNu64pvcfzq+PftCU9NmcT33hyvFm7MEhPkbWG/u6bBnJdHD32qKs2YIUKLLRrPoaYTMSYFuo
 X3TlfUvAUVrNJAHCPX846ZdpdsUsaa4NI/5bmThWgau3G2SgoZndtK5ecLUV9jo1rxLEw/7teaN
 +0LNB4xNn8ADSvpuUbqxJbi0jxtxSt162dAcKJLRUfFRoa3WEqWk9JBl/cv/OUuSiNY/FpPwKPX
 vCgBA
X-Google-Smtp-Source: AGHT+IFQ21K9hi95JhVyqLczuCRUbp76BeRPsFcNqP1zz4268qFmaz0xksaHKBemjgSFwb1vgTw88w==
X-Received: by 2002:a17:906:4c2:b0:abc:a1b:2781 with SMTP id
 a640c23a62f3a-abeeed0d62fmr882122066b.4.1740658562029; 
 Thu, 27 Feb 2025 04:16:02 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dc168sm114736566b.70.2025.02.27.04.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:16:01 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joshua Watt <jpewhacker@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v3 6/6] arm64: Enable RW,
 RX and RO mappings for the relocated binary
Date: Thu, 27 Feb 2025 14:14:56 +0200
Message-ID: <20250227121515.232996-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
References: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Feb 2025 13:56:54 +0100
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

Now that we have everything in place switch the page permissions for
.rodata, .text and .data just after we relocate everything in top of the
RAM.

Unfortunately we can't enable this by default, since we have examples of
U-Boot crashing due to invalid access. This usually happens because code
defines const variables that it later writes. So hide it behind a Kconfig
option until we sort it out.

It's worth noting that EFI runtime services are not covered by this
patch on purpose. Since the OS can call SetVirtualAddressMap which can
relocate runtime services, we need to set them to RX initially but remap
them as RWX right before ExitBootServices.

Link: https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
Link: https://lore.kernel.org/u-boot/20250130133646.2177194-1-andre.przywara@arm.com/
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/Kconfig   | 13 +++++++++++++
 common/board_r.c | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index 1d6de8badf75..edb857e4de7f 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -914,6 +914,19 @@ config STACKPROTECTOR
 	  Enable stack smash detection through compiler's stack-protector
 	  canary logic
 
+config MMU_PGPROT
+	bool "Enable RO, RW and RX mappings"
+	help
+	  U-Boot maps all pages as RWX. If selected pages will
+	  be marked as RO(.rodata), RX(.text), RW(.data) right after
+	  we relocate. Since code sections needs to be page aligned
+	  the final binary size will increase. The mappings can be dumped
+	  using the 'meminfo' command.
+
+	  Enabling this feature can expose bugs in U-Boot where we have
+	  code that violates read-only permissions for example. Use this
+	  feature with caution.
+
 config SPL_STACKPROTECTOR
 	bool "Stack Protector buffer overflow detection for SPL"
 	depends on STACKPROTECTOR && SPL
diff --git a/common/board_r.c b/common/board_r.c
index 179259b00de8..65111e2fc97a 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -170,7 +170,27 @@ static int initr_reloc_global_data(void)
 	efi_save_gd();
 
 	efi_runtime_relocate(gd->relocaddr, NULL);
+
 #endif
+	/*
+	 * We are done with all relocations change the permissions of the binary
+	 * NOTE: __start_rodata etc are defined in arm64 linker scripts and
+	 * sections.h. If you want to add support for your platform you need to
+	 * add the symbols on your linker script, otherwise they will point to
+	 * random addresses.
+	 *
+	 */
+	if (IS_ENABLED(CONFIG_MMU_PGPROT)) {
+		pgprot_set_attrs((phys_addr_t)(uintptr_t)(__start_rodata),
+				 (size_t)(uintptr_t)(__end_rodata - __start_rodata),
+				 MMU_ATTR_RO);
+		pgprot_set_attrs((phys_addr_t)(uintptr_t)(__start_data),
+				 (size_t)(uintptr_t)(__end_data - __start_data),
+				 MMU_ATTR_RW);
+		pgprot_set_attrs((phys_addr_t)(uintptr_t)(__text_start),
+				 (size_t)(uintptr_t)(__text_end - __text_start),
+				 MMU_ATTR_RX);
+	}
 
 	return 0;
 }
-- 
2.47.2

