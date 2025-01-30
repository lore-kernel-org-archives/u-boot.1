Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B716C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 07:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6EA8203B;
	Thu, 30 Jan 2025 08:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DyYAkigw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431958201E; Thu, 30 Jan 2025 08:21:41 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AA681F0D
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 08:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43635796b48so2290205e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738221699; x=1738826499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYut4AQRW/HlcPcpg6ffEWgueoLjAyxY6Wo9r/v5isE=;
 b=DyYAkigw4+zoT3dLcSVJQt4hGNiWwu7fQCT2wr58VyCDGeRVHNyDlh8u9FAUW84ZFB
 XLLW/pvisqU2jM/zbVrxzGYJhv+bTyPWctxthDAgQ9l/j5OcHFpS3s99l14oOSbIodFS
 C3zW5JdhFzRYruUBI0G4p0+IDJq7ot24Ley15natdy9LOS/yY+0YtT5yRuaQU2D/vrQQ
 vm15Y3zDAOZsK7KWFeAA/ch7/D4tV1mHSe7OUg9AKygBaABBKTTWL/ckw6YgTG4RCVwO
 W4ccu7DpD8HqTZKkGGT33xj232PEFXmDCFH7vGU+0HKY5aERjGlT9DLIGTRutcfIxORM
 0yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738221699; x=1738826499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TYut4AQRW/HlcPcpg6ffEWgueoLjAyxY6Wo9r/v5isE=;
 b=lNQza3Gs3A60i9roTkrhXi2LVqAaG5Sb7wJdkVdq7sH7NjdYGPBsupQzKNLLqujUdD
 9AAN8qP2ymlOsiQYIENV6gtxSrvnGbz5Og3c2ioRcmDUdGc3sqh8ruP0Adc2SP/2dW2Z
 04JMMIcqIkyYb40fNP+wSokVTDKcMKPqyVhMpo+MU8i97Bt+5OZPBVUA4ocepXDA1Prk
 kspbXQXoWBW+eHHDcXpQ+PaPM9ZJDREs8PlsNQZU5eKKuxU6Ul8wsBDzuKS067H64TFB
 Ouj/LZAMO9FDYt3DDANnEGoqmbY9Msdwfy4yXh7SLuOmcC1ydqfI7Ei2hgKIfVXz6vCr
 1McQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwSCXENWbNgXrkHYEqcmQ7fT5AVOw6tm/su0TWD2q357glzT+E1GmjxfGiy4Kl2xbHgrSMTlw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1XyZCDAiSre5/P8e5AgbQsZOwECE5mfeacaKfX1Saml9LyjIQ
 TSnDb6j/ZpeNGthdacWI3SXaGyfFNX3XirVhwj+TJpTFFpUfrfkDvSqlVf/Mba8=
X-Gm-Gg: ASbGncucaSFX9YhBPd+U/SUj7wAvMPCcT86ypU0WG20XHvYF2wnMltm/1/ewrd/D+n3
 /i/0zUtNrPKMznQn6y4yf0LCBtIyn4Dm+PF6ANA7Ar2gcq6MfRvFgX3CEBXK1ybPVVEFdh4tpEs
 zoB5gxvgm1s5kpOLUXVlKmu7dmF9wrVDwnGm8ldZcZbba/SfzFdTQnkjRWQsRxHh/gq8VWdPVnU
 /fUZ5q93soa6uGAjCJPOoGkECUZFd0ByFMUtxRSKZvKU4C0vt2JCS6Olzvd/7Ej5gL8FwqAaT3C
 rB9+dFZdP50dPTU0or3PEbQPlKVjNGRsC/Avl3zohTVaQmCkIA==
X-Google-Smtp-Source: AGHT+IGxzrXItzn+CZ6bNrTd5m2jb8vfgGD5tBMmuCABg11UHAh5wsASLfUcMoi95RXbqdKMm6u18Q==
X-Received: by 2002:a05:600c:1f8c:b0:434:ffb2:f9cf with SMTP id
 5b1f17b1804b1-438e1708a35mr15653435e9.14.1738221698884; 
 Wed, 29 Jan 2025 23:21:38 -0800 (PST)
Received: from hades.. (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df2asm48076345e9.29.2025.01.29.23.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 23:21:38 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: maz@kernel.org,
	trini@konsulko.com,
	CFSworks@gmail.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [RFC PATCH 4/4] arm64: Change mapping for data/rodata/text
Date: Thu, 30 Jan 2025 09:20:29 +0200
Message-ID: <20250130072100.27297-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
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

Now that we have everything in place switch the page permissions for
.rodata, .text and .data just after we relocate everything in top of the
RAM.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_r.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/board_r.c b/common/board_r.c
index 179259b00de8..38944f600fd6 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -170,6 +170,13 @@ static int initr_reloc_global_data(void)
 	efi_save_gd();
 
 	efi_runtime_relocate(gd->relocaddr, NULL);
+
+#if (IS_ENABLED(CONFIG_ARM64))
+	mmu_set_attrs((u64)(__start_rodata), (u64)(__end_rodata - __start_rodata), 1);
+	mmu_set_attrs((u64)(__start_data), (u64)(__end_data - __start_data), 3);
+	mmu_set_attrs((u64)(__text_start), (u64)(__text_end - __text_start), 2);
+#endif
+
 #endif
 
 	return 0;
-- 
2.43.0

