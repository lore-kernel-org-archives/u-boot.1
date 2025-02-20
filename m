Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA65C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16EF80FB1;
	Thu, 20 Feb 2025 22:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PxCSpJ9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702BD80F5F; Thu, 20 Feb 2025 14:56:15 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191928001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4398738217aso8338335e9.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059772; x=1740664572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDbbln0j0aifT9JntUADu1O4s2RC+5sjIApqn5zAwL8=;
 b=PxCSpJ9Hd2JPTPEC1Y2k6S/R4Mjd2XS2SqhoyQqfiCoZPaQO3ZlmGB462v/LHD7I/x
 xtUhrbuoGh6k7IvBZqahVsszTUpQTO3pJ/x5mR/AtRp1F5MaNpeM6QMZMdzAHAl+HQX1
 XBAgRG6oTDS919WbOJlEIYEF7bD4LPEUrgR9ptra/DTZjyT1fHqwbudq89K5guLqJlPb
 zo8gGgdE7qZb1PYqByka0tW09AW44v7L5Wkx+/NPMl73BAVpepWT9I3QyT4leqsEVOGu
 KJDUqoWJ31zmItFlls6aXOfaWShbZxo9ZNqEFbIsFkI3ckWhwSw6j27arF812zqrWJTG
 lfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059772; x=1740664572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDbbln0j0aifT9JntUADu1O4s2RC+5sjIApqn5zAwL8=;
 b=iRCGaqpv8z52tJCgnAbr5TRvuWNIelK1ZrdWoFGVcaXTSJufGbo7dydeJv1hEh9Qq8
 9WItFloYU2v3/mRk0Y6mnif2oxo5V2+XgDIvYHcr3Wcr8XfvJG/bwdJGxIYvy3VelUNW
 t804iN1M3Frq4rukRH2kklONG9XQroeTzx6sJKPGKniSAdZbEfWA2mU0NZnoem8Au1Cd
 3md9Ymunsjt0HXo3XtFfz6XmVxzgMLgM0S7/Ts5fyw9tV85nmyoI9DqQHScgNLvNmIRD
 cGtdr4SeYKqOkKwEkhXt+Nkn9Wj0SI89+6fJmsbqQjN7/wc7YmGUoICcdyhyHU/iVqyS
 rNLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrF1JC+5+hrIqehVvDY/LhQAo/kAiKWnr130knjOpe5eXZ9KGqQBeB+jSK9+cfXgsv/XGluZU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7Pmm6KypeN9ySJeihH3Hc5vapzBf0cHvSPE7E4K5Bj22OTWbj
 hy3BLifiJck2BmSZG/QBNB1HFqsVNawx4UhfpoJJN7BAU2NRs2L1l4ELrrGmvc8=
X-Gm-Gg: ASbGncsWOZPg64e/3KALUl7Wy10CoDKZdHqAVSw8pONFdEa1vyTgBJtfVY1OEy0WHjM
 s2pDDoE6/4gSjHM1BJrROuS8JuyVIwsrQznzZgJUa4lqi1YCSR5pxlQp7HR7t+3VnrExtLAJn1F
 bTR2izuJGFmTNtO27qj9qGbzP93YHXcqGKLLNkO82OGAiIY006V8N8jS7lFmFJTe5GWPB4lEytR
 Wo0UoTbaAJV9SRfpvuuQBwbOFAzTkikZzNwO+fcU3jsNMhBG+0JPtlrMrF23ddk8vS5zeEbSMsi
 pCa9djSzOXS5xS6p9cwWzkH5cCzRqU7xCFgvX1l/J6MH2SK9a7o0XyHrI6sDw4cHBVXEVg==
X-Google-Smtp-Source: AGHT+IEfSVmfwKCPpN7nTr57/IiMkAaOQ2dlnza7ZwZ/m/M2AeefDNcjFOkNkkV0DIif6Jhkd+seFA==
X-Received: by 2002:a05:600c:19ce:b0:439:331b:e34f with SMTP id
 5b1f17b1804b1-43999da3cffmr70659735e9.17.1740059770856; 
 Thu, 20 Feb 2025 05:56:10 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987088ecbsm111659865e9.31.2025.02.20.05.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:56:10 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 6/6] arm64: Enable RW,
 RX and RO mappings for the relocated binary
Date: Thu, 20 Feb 2025 15:54:43 +0200
Message-ID: <20250220135506.151894-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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

