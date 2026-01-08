Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422B6D1D461
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE04B841B8;
	Thu,  8 Jan 2026 15:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OIbzQO1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6878425A; Thu,  8 Jan 2026 15:42:48 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DAAE841B1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so1669888f8f.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767883365; x=1768488165;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8WG0oUEr1Is5i+F3zQR1mlvZq0OURCNvgp2l9d9oUbA=;
 b=OIbzQO1U7Pg4rt1Aop6r7Z5wMMj86kljb6EDrVlAgxBdLM0GBgJ00kHEbLBcvugsDl
 TOHjR+5tdVsappOSBSlocUH5eYw6hs9lkbx863SyLXe00E3mbIPeYT/Sd3+JQfQAWppN
 59lE4G6RT7HpVgUoicxe0hiTF6cggRgt69b5YzJvlwzIhpTZlmR8bkFBmWFtZ531jmXW
 7WKHoV0TbnhqDUuqSAjpFBkq6oaO6g+jKPp4HXG5V4nXEAye56aZMt5Rl+jLAvl+FC39
 E1DbfGK2ZkE/kKQumB4dyZxFyGxbIRav6iO81ZmNhirsHJ12uw+PJH4jPQs+ZdrRWtrV
 gVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883365; x=1768488165;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WG0oUEr1Is5i+F3zQR1mlvZq0OURCNvgp2l9d9oUbA=;
 b=WJb9TVv6oQsktoQIGZGrarPcsYt61jGZyQpoVSh8+kFkZPLAlQsAW63F191jj3SNxz
 fSaesOZxZoS4U4Mzpom5JZZpX5EqRI2231KZu5SSQwgzr8i2midFrm9uwpzKR7t/6sbL
 lKhEDXHZz2ExECbIpzGX4gGY9lHi3LHW9RUJouWGnXSZhGUhcEW5DV29/xrTTi11wfSE
 gU12si8ZPI8iL7MerEkDELARb1MKGj5mi4+qs+7UfwaIMxN4A/9D5Rg/83HYjgR2ujB1
 cCitmR5vVB9PCqOqy+LkiRyZ0Edr7oSUhcE61vt+Lwc00Wnc6PhL+M8rDT0i2ZumO5Sg
 ly6A==
X-Gm-Message-State: AOJu0Yy4NY6+FJfP0kEHpRV6pfHHYIgqyjW+EHcwxRu1b+eLirIoHVbP
 VtAtQfN8giYvzj0DEWXrEbzC0XMtuB9lnAgYieql5px3H2P/LYpzY+el4dtS1mtuk0g=
X-Gm-Gg: AY/fxX7DrDeZBpZEUMzhxWf4bIr+75k2q2d3YfBhZ769ELzPSLXhB9yYnqSry+Hd6Ls
 74hAerfkdXcdCqLKLGK2KqTr1teLdQyvhXO9bUt8iSfRxIFTAQYwEZpNLF26aiEXzbSBuebLCT2
 M2AZWTVjaMGU6xsWDJrFjQ0LGpBUYb3zMiJ3JtmHj5rmdE6rnJKxKByjfJY7eYS890CpQJmxeBW
 XHpZW6U61sNswWHUXULSXyPCiOff9G/Tt5o1/hBRB/cCKavrDI9esCXXtKu6bV/Nv/kzYXS02F/
 duOWsZuwccd12Dz+85gngg8gmSEtJcaTKkmvgAziJZYSLVb7r2TUFiZbQ0uVEX/trEXUuLxlvIc
 oR+Az7Celpo9ZTE0gIezfytWVLUTMygNNrI9j7ePOuzN+ZcTO8MXUUB+WjpQA7BsB0RXz9HVXoV
 ccaLamDaDAUzNhY3NP5tchCa1vhpWNEiQQWBr3Y9dnqogxuulRXRkoq8PLBAwcByKRSvr6nr/LO
 7y0qBJw
X-Google-Smtp-Source: AGHT+IGGB5yjChO8nRVY0zcn2C5wATkjmuvQdc3I+nw5+4NOj/O/hDvGWcQ1cmOmwb0YSntpfh/Qhw==
X-Received: by 2002:a05:6000:2689:b0:431:a50:6e9e with SMTP id
 ffacd0b85a97d-432c374fcefmr8121093f8f.38.1767883364553; 
 Thu, 08 Jan 2026 06:42:44 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm17431760f8f.13.2026.01.08.06.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:42:44 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/3] Fix compilation issue on regulator_common file
Date: Thu, 08 Jan 2026 15:42:46 +0100
Message-Id: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGbCX2kC/4WNzQ6CMBCEX4X07JptSf078R6GQ1sX2AQpaRUlh
 Hd3Jd49fpOZbxaVKTFldSkWlWjizHEQMLtChc4NLQHfhJVBY7XBM4zxRQkStc/ePWKCht8Q4n1
 kQdmCNaXxWB5sOHolljGRVLaHay3ccZbZvB1O+pv+3Br/uicNCMGeGtSEzoay8m7u2SfaS03V6
 7p+AN5FxJHRAAAA
X-Change-ID: 20251209-power-regulator-fix-compilation-5232b0365c7b
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
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

Hello,

If CONFIG_DM_GPIO is not enabled, compilation of
drivers/power/regulator/regulator_common.c  fails with the following
errors:

aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_of_to_plat':
<...>/u-boot/drivers/power/regulator/regulator_common.c:30: undefined reference to `gpio_request_by_name'
aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_get_enable':
<...>/u-boot/drivers/power/regulator/regulator_common.c:57: undefined reference to `dm_gpio_get_value'
aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_set_enable':
<...>/u-boot/drivers/power/regulator/regulator_common.c:92: undefined reference to `dm_gpio_set_value'
make: *** [Makefile:2029: u-boot] Error 139

Since the enable gpio is optional we can conditionally skip these calls.

While at it, use dm_gpio_is_valid() helper function in
regulator_common_get_enable, and remove a debug message that checkpatch
--strict complains about:

  WARNING: Unnecessary ftrace-like logging - prefer using ftrace

The 2 fixes are done before the compilation issue fix in order to easily
cherry-pick them if needed

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Picked up review tag
- Use CONFIG_IS_ENABLED instead of IS_ENABLED
- Link to v1: https://lore.kernel.org/r/20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com

---
Julien Stephan (3):
      power: regulator: common: remove unnecessary debug trace
      power: regulator: common: use dm_gpio_is_valid helper
      power: regulator: common: fix compilation issue

 drivers/power/regulator/regulator_common.c | 89 +++++++++++++++---------------
 1 file changed, 45 insertions(+), 44 deletions(-)
---
base-commit: 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6
change-id: 20251209-power-regulator-fix-compilation-5232b0365c7b

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

