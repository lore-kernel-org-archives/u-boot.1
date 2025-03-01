Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2602C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 12:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30D281273;
	Sun,  2 Mar 2025 13:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a/4NE2Uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C66810FE; Sat,  1 Mar 2025 17:50:25 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD966810F5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 17:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abf3d64849dso187172966b.3
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740847822; x=1741452622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLFwgs8kGiVjfoAIHjqNJqXkP8HfxTfQNt1hDxUtJiQ=;
 b=a/4NE2Uu/jWHo9hJ0rKFvgXmVPy4mOq/a1G5g3iSYFFzWzI0mHvmKSkLxJpn8Q7zpj
 21ak64OEGmFBJ2PT8EQbL2ksRQekdMwbrRDjNv0Lehg1bWlq1cjdLT8nE/1qjFLzNuQL
 R9XI3fNAkR2Gr1/QKUPLOf7jLjKevPq/QSIyGsq8bWWQ+wNMYADRVWoeY2KmKJpi6Dlg
 /gIKFcXu+fTymeKKwbzDbFS+148szG0Oicg7NDspUdfW1Dr280fMc2DW1fj1sjoS/KX/
 RvdBmq+rZtQG9a4e7XH/VxB9NadUM5Wh07vy/yBR2V+rnXntVhaK8eqX8xdPFszXY1pr
 dFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740847822; x=1741452622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLFwgs8kGiVjfoAIHjqNJqXkP8HfxTfQNt1hDxUtJiQ=;
 b=tUEM5b8it+ZAMy4vSvQM1KJJsGxgS+k/ZgK5d9B7rKbZH/6nsBD2tZn5LRrEhakrFO
 kCD9gMCfbyZvv5J0so75SJMZtGQ/nGgv7MWAzByrp01pFD1/TyDTf4yfNBqtSvSc8aw8
 vjBA2fqswccxWen6gKWLYgltRd4E86bd0w3KFQU0MV1TavAMw5u/YSaWhTZtvapvc+Ay
 zS/oW4/ZY/6tvDQqs8cCbeMQTZUbOUzl13c9ga+W1YV6/eR/tvrM4GksfvHo/MD2O2v/
 wyFaKeeK9uBlCYgbSuYUrnJlMDkP+i9zQCD7QtSd5csGScPuuUmTwir41C2JkCdLLn3U
 mCOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT9dAhixCLl+Kq8T1t6ccillyV+W7qCWW+KRnpefGEVsN9acdTQXCxbvyFqUhU6/WcVjyaOhg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4sev66B79x3aCwi9p03NC4lPhAOXdVGV7YUHP8x6C5c4yyjFG
 UNOiUpLpEPa+VJuHFCWBcHtO72oxANKf3mB/K+k2YLCTRIGm0CXsEIJa2k1DGT4=
X-Gm-Gg: ASbGnctcq9CV+GJQ+aCtsJXqceONUBvcjTfknuKUECtTxQX+tKU5tjIdghyhOw0pT2N
 zBXquJzlDpmUn55UTOSv+F5d4JtzeNxf60QGt3/wiAhOgTeNSgKxuorIl7un1cPV6ykCj2CnTnm
 gOjPrM0TP3vlTwv0KlUdkQCil3zKKBGUlRlqCI9HKzH6a48U4zy78xN07EnPp+CnpQd3x+o8tfR
 MiwkklzBpF6JUYK3NYsyruqu2ujMLmDq4Q9SIlj5kCEDmGGpet51C37rsmFw7FgrBomDVrOXIv3
 r9KIpGz/ClfjYfFAANqn5WBNf14Pg8hWe4MAkdNEFkCm2sujDPXEKNl0x1aQD0KmdIrraHkscLa
 jBNuWYkXu3joBwnyCbX0QaSI=
X-Google-Smtp-Source: AGHT+IE9dAnoe5oMgfYgE27dFHTofP9psF7BSI1xSiar52MycBnnAvqoEbqTd6eXjP1yZj+SqoW1sg==
X-Received: by 2002:a05:6402:51d4:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5e4d6ac58e5mr17230363a12.2.1740847822071; 
 Sat, 01 Mar 2025 08:50:22 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb5927sm4257231a12.53.2025.03.01.08.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 08:50:20 -0800 (PST)
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
 Marc Zyngier <maz@kernel.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v4 6/6] arm64: Enable RW,
 RX and RO mappings for the relocated binary
Date: Sat,  1 Mar 2025 18:49:04 +0200
Message-ID: <20250301164922.397441-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
References: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Mar 2025 13:40:23 +0100
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
index 7685914fa6fd..d23e845ee471 100644
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

