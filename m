Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637FBC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58C08083E;
	Wed,  5 Feb 2025 14:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IyS9Jx8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEADC80207; Wed,  5 Feb 2025 08:18:05 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2C4805D7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5da12292b67so10615138a12.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 23:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738739883; x=1739344683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTFj8kCpobqzxUeqd0ei2gZNtRRmeNcrYlKQhlxL0rs=;
 b=IyS9Jx8n4d4hoKeRf/6ZdRgTrYoZReo67xJcsQ9T1EeJWQASc1Xrpa/Bopmg/LMzi3
 fzH7kWeEj635jYE/AfnH0T11VfLNDHV26/OaUDK8wPkwYlG1kiTqy9hIYZ9ms3ygGy3p
 V6arYCqv98IQTJOiKBKPOUcTYLHXiKNIjztCDfI+6GIxCsR+gNa23Co/ybzUAxLMrRbS
 wRAn/1NW8i6YrTRYn3P6vOTNSoivC/ZbV9kNTOP+T+TBi8od38OpEj3j7qY4447oMksM
 DPcRGRUC4VYNgTD9W/xZ9VlfVBJb8JRT4HGG57fFNbab7SC0AxHEiDzMZwoF3L+DVua+
 eOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739883; x=1739344683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTFj8kCpobqzxUeqd0ei2gZNtRRmeNcrYlKQhlxL0rs=;
 b=wGMzXa5cECIL/LEAxYUNBO1GgY8n9PvlQns2CMupqeAFhVz9DLeNrIkeaL+j/V/kwN
 2HxrRPsDcu6HlioOO6pjxZ4iF6T/JPglPcWM27ahZ5Vz4DB0KppyZM/M3F83Mt7uqi/O
 l0jr4UKoFYtZolVMyklhj1kDgo4hzPMn5ne2IpCBrQ4B4In85liMi3Fk/ae3WKA2llbh
 JztVcw0xO/v7XmuJSW8WLHKAKYGFp79o4t/b+siw9HhyCpOl4zd+HUY57ZDf+xj3mF3W
 VUa3SO8M6y5Nn4W9zxZHqPmj8bFqw5Tbbbbd6oK82rjMftrjcT2DCkGMbH8tHo5AN2hL
 MaBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsysgqRW/zAP1LO9W4UgBpdxwh85cT9fQ6Y8LP+4W8heIsw4TRVdfq6cl2+ShXu5DFopk0Xqk=@lists.denx.de
X-Gm-Message-State: AOJu0YwH334TFIlr6SoNib0lCQhuv/+vrII/+v3IQDEx/guT9Yn3fEp4
 1Hd13P3MPwVYKv8DxD/SeRC7RrwONKHKN/mdtt3ERNT6/eED7VbPHhWJl6SvnZ4=
X-Gm-Gg: ASbGncs22NvetgR/88nMx2NuhC79o077U9HuvcEsZpcUqnopbuE2eUerZrVk8KtTpCc
 OVbdznDo8CKX2YJhmiUmWtyIpoet5Lxdcjv0Z1i2T63EvetSHhQwnjY3J886AfydcYEBkoUlkFY
 OJrb/wkrBNqbFqHrhUl+ikwJcbY38q0/N3c8JqVqperqp0Plz3+8J/XQWfjlAhcyQjw1TJHxi05
 50HX52+ZoOJlfyeu9n75l1GrcFyt2D5O5f4z3yfnLVb1Odhb7p1HIkBMaYdJTFnzDZF7DZpql2q
 J3JIehOoeaIPsIDU5j5XoMb/FoeMhFG84rvX9pHei2RsVna441ptUIAAdYZy4HCGlVi/
X-Google-Smtp-Source: AGHT+IF/myCobpHKY1GHQyzskO9gYb4ktq5a15z7HIm8e+3/54L9t0QxLGLKFdujbzOEfUwtQs3bbw==
X-Received: by 2002:a05:6402:13c8:b0:5dc:8f03:bb5b with SMTP id
 4fb4d7f45d1cf-5dcdb6f9ea1mr4899719a12.5.1738739882490; 
 Tue, 04 Feb 2025 23:18:02 -0800 (PST)
Received: from localhost.localdomain (ppp176092167070.access.hol.gr.
 [176.92.167.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcda28cbcesm1107191a12.43.2025.02.04.23.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 23:18:02 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 6/6] arm64: Enable RW,
 RX and RO mappings for the relocated binary
Date: Wed,  5 Feb 2025 09:16:50 +0200
Message-ID: <20250205071714.635518-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/Kconfig   | 13 +++++++++++++
 common/board_r.c | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index 7685914fa6fd..dbae7e062b0a 100644
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
+	  the final binary size will increase.
+	  The mapping can be dumped using the 'meminfo' command.
+	  We should make this default 'y' in the future, but currently
+	  we have code defining const variables that are later written.
+	  Enabling this will crash U-Boot if that code path runs, so keep
+	  it off by default until we fix invalid accesses.
+
 config SPL_STACKPROTECTOR
 	bool "Stack Protector buffer overflow detection for SPL"
 	depends on STACKPROTECTOR && SPL
diff --git a/common/board_r.c b/common/board_r.c
index 179259b00de8..c1e9aa46e3fa 100644
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
+				 (phys_addr_t)(uintptr_t)(__end_rodata - __start_rodata),
+				 MMU_ATTR_RO);
+		pgprot_set_attrs((phys_addr_t)(uintptr_t)(__start_data),
+				 (phys_addr_t)(uintptr_t)(__end_data - __start_data),
+				 MMU_ATTR_RW);
+		pgprot_set_attrs((phys_addr_t)(uintptr_t)(__text_start),
+				 (phys_addr_t)(uintptr_t)(__text_end - __text_start),
+				 MMU_ATTR_RX);
+	}
 
 	return 0;
 }
-- 
2.47.2

