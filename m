Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C30C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D82800CF;
	Tue, 11 Feb 2025 09:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VK6ArZtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E14B805D7; Tue, 11 Feb 2025 09:02:12 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2E5800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38dc1dfd9f2so3406429f8f.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 00:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739260929; x=1739865729;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0WHl9br8SOJxDiuFZPC4zGWiGcF/8o7g/+2DpMJhvI=;
 b=VK6ArZtFaSy3+42GmxqytVmHf9EDkfmNOdjmWK//wL8V23MyRr+ytbNcwFnR4cwwse
 mNGAs91XyIODjlrvrL5iVK9xf3CRqHDthCwIXmzr38QwAMrZbzbYAQzae0X+6s/iZycS
 P+d/hN58PQZP8cmPE3o50As5XnQw2aGKQaoA+1av3YgzkoAs1rep0RKm589Ly9NvJqpd
 uNbalfwLI2eqnM0Qt9ib1sn3n1JmhygCZllaGHSQ4fgpj4qOnWfd5zAIpmGjyzcmCjHO
 tskXSg+4k0Ch30jxKEIizEOkggDrSY8Ix9Nw3GOfh1BEq+tac+z7MLuMsK+RzMDQ69lY
 8wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739260929; x=1739865729;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0WHl9br8SOJxDiuFZPC4zGWiGcF/8o7g/+2DpMJhvI=;
 b=JBESIbswhPf1FPtjg+jo0o156wF6pmEtTFjAD17wnP+K2odSkvWVHbxaPeLSHi6kFR
 qHfR5wWeAmGy9uv2Sk3KkmTPiMxWBAWrZs/1UQe8q4p/G5XkSEJv/BKXo9ij4bif1J1C
 bo4X+nq6DLN2IP9sGb+HQkpgGWsELuNr9zM9LUJxzm23v8ZKnELRwNyR9wbSjeR+g/U6
 HzifKyfLYfKT3vWovV/irX2hyBAD+cYBATDbQjnO2EGx2EZk8wy6dwemqh/rl5qKPTGM
 M7JspqW1841cZF2dyHYW3KYJHLvao1S7FyfXS1vi5BvFNBNEvuNAwvxhHH19j9Hj7qIb
 WJXA==
X-Gm-Message-State: AOJu0YxcTzhyfVQmBVK8xQtnCVeI5AOMF7j8OeAZURrUv5N4ElIRg2cD
 FoWJVevp3n/cKJX1q5O/cNa3VEBUvG6jzQ/BBVvmm8NtJttzLUHhmbZnydadkXo=
X-Gm-Gg: ASbGncujHJ9L8AKf4z3oe9EE3k6mju+Pqb2NGR3VVktHtz/vwqR1+DW2HoFfbGbh99g
 /O55LIcktvrmlBLNDooj1ezLzkisAXXSQw3oiEWXpqptxLx9SpFcKgLsdPY5eCfNGlQUr1RGUF/
 RV/VTdaGcy/CWUwv8nx6wFhX/n6wxCzNP1tQShJM3OekSXV5SPY05UTo2qbwHSO4lpyi4isdEQH
 cJq8hjNCuiUJ6JMwvcH4IQ7duLoZzs+dI1Q7DTlZo/crgMhb6Su4g9Qh7FrhS3vHqs/qULQvrfi
 h9zsmtVI2FirsZKSy+r92sQsQz8Eo8M=
X-Google-Smtp-Source: AGHT+IFY00R9GgLXfV8ym9GIt98Vh5wf3oLlsYf9DJiaKombPnQOiWDbvtxAPPqk2nEKa1xi7yrWag==
X-Received: by 2002:a5d:47c3:0:b0:38d:e166:8dc2 with SMTP id
 ffacd0b85a97d-38de1669178mr5426586f8f.16.1739260928717; 
 Tue, 11 Feb 2025 00:02:08 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd44c5e3dsm8738543f8f.62.2025.02.11.00.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 00:02:08 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <othacehe@gnu.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250130163547.512990-1-patrice.chotard@foss.st.com>
References: <20250130163547.512990-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH v5 0/9] Restore USB and add UMS support for STiH407-B2260
Message-Id: <173926092753.170899.3777057855491672069.b4-ty@baylibre.com>
Date: Tue, 11 Feb 2025 09:02:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319
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

Hi,

On Thu, 30 Jan 2025 17:35:38 +0100, Patrice Chotard wrote:
> This series is :
>  _ restoring USB on STiH410-B2260 which hasn't been
>    tested since a while.
>  _ migrating STi DWC3 glue from proprietary driver to
>    dwc3-generic driver.
>  _ adding UMS support for STiH410-B2260.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/9] ARM: dts: sti: Add fixed clock for ehci and ohci nodes in stih410-b2260.dtsi
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/3810cd52cbf42727ebe22cf2a7929045d5ab01fd
[2/9] configs: stih410-b2260: Enable DM_REGULATOR flag
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/0f688eb0d69e2f8f65532908d8575113b4bd3427
[3/9] usb: dwc3: Remove dwc3 glue driver support for STi
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/15cd35cb3f1a128f1f4da8a3e5b8d93316125330
[4/9] usb: dwc3-generic: Reorder include
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9de4b7e0a4c93128f28b19ad8a3a82421275418f
[5/9] usb: dwc3-generic: Add STih407 support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/23542078ec9a49cfb35cc00a6715106afbf65627
[6/9] configs: stih410-b2260: Enable USB_DWC3_GENERIC and USB_DWC3_STI flags
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/08fec26a67643fac05e2a076d19c54bca6f6e427
[7/9] configs: stih410-b2260: Enable DM_USB_GADGET flag
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d0ff527f6237a78fb289b02e5dab63a23478565b
[8/9] board: stih410-b2260: Remove board_usb_init/cleanup()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/0b96214cb32ebc54e92442a96eb9dc1e1f7e9175
[9/9] configs: stih410-b2260: Enable CMD_USB_MASS_STORAGE flag
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4096d28ec80f982454ef0dc7d42a4d4eaead5d56

--
Mattijs
