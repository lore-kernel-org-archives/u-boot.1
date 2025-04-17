Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5729CC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E304D82FD4;
	Thu, 17 Apr 2025 14:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="vQXu4I47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28B283010; Thu, 17 Apr 2025 11:10:07 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6B282F8C
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso3927625e9.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881004; x=1745485804;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0mKDohGfOnGwoII0dGivYtFdozVo6o3/fT4VNfMCaS8=;
 b=vQXu4I47AiR4iK/ktAeMhRgEIcBE9OgAlbx3x7Bg2+RNIB96tfaWGIgOC7Mqgz3rSJ
 Xba6euxC0SXlRRtaKKaUlpOzhmQyPsBQjd1neLp3oF5X01hW9LDIayk/B6J+uMftu1LT
 SVSdeOkeQNe/N+wpYEUgTZlxmczATygk71I4TMmHuzSDpJtJfHr0ierkymaSSg3t572J
 hM5IcHoKObkMEkEVQ0q3CxL4U0KnPuFk2ng0EtHXDuOt3wdmXu/nv90KbkDgR+h7ApRL
 1iVSxfQhxyIpfPRY72qlfY5X75oHCsOjWGXSdwySqzsPowIkQ74sqQNj+mo9681HgfLy
 UeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881004; x=1745485804;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0mKDohGfOnGwoII0dGivYtFdozVo6o3/fT4VNfMCaS8=;
 b=Tt3+Ij1Dya86y/JICmgSdY9mjFYgl3psUWROLLZrdlqi9B89sTRfYLsK7zahGjoCHA
 1UdCj0kN0Y3bEy0IER/0v2V9lzQRlRTuTus/43CNh6lcy67nxAFd17yTu2ElwWKgqwDF
 mu30ZvyLZnLualSgdiUgZa54+yDNKoL0sHNPS7aVoxEw93gzX70WW7ohsqX73U9xdcUn
 ekqiVs6TjojzPU16UkhAohW9LNYjt4qqHT4j5fOLs4nSdWKrEglGiycP2KB2mL4u3+QL
 LrpjGbiFbjgC3WPVyGvzfn/a1M1mUCLzl6RfJj6qeH6LTkiEAdt/TTLQUTruSrePBwDC
 fvsA==
X-Gm-Message-State: AOJu0YyLN1jGs700WWPDlSwaHom7GtKmIdr6oMAcrvhwljQQQVInaAW7
 TtiAEP94phFLjbSlSr7R72oEARcPFa/zWd4/lfAdZWkkDPikQRFm7oP3hTQpOxhlGzM7uZ5m1Xs
 X
X-Gm-Gg: ASbGnctVqZpLRrn/SUs3rsxzrJ1In5EVsngz3YajGAYm7Zfd6Zzg5txCSpfNGeFyqbi
 3mTQYMnZmoCMXmlTFBXoTsLvixZhFnN+WIpHdy8TYApdK3YCcPFAMM9o7w7UuvkdXKfOnF3GWWZ
 4ADNRQTlgyjMGn+m/33LTQ2OHpYTCUmsYhfaaCyd8FMd8DDZ+TPixj0S8TibQuC2K2a3tqZbNPG
 TU7bJre9qJNdfrA5lGTFVEo6MjFnB2WiYu5ChI028OsddssyiVBEAz461euOHnguUB+uZfGlTzI
 gMhhi1gF3JLekVq5uc/r+J0KZcsbx0IG+HXoyt8=
X-Google-Smtp-Source: AGHT+IH2XO1YJNirU/6SyiC9Ryh7OIgaHPFkn8HocQ8AVp1sGfIZBtaWEYOATTUYpaMc55dhP6/rmg==
X-Received: by 2002:a05:600c:ccc:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-4405d5bf846mr48971325e9.0.1744881004087; 
 Thu, 17 Apr 2025 02:10:04 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:03 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Subject: [PATCH v2 0/8] watchdog: at91sam9_wdt driver enhancement
Date: Thu, 17 Apr 2025 11:09:47 +0200
Message-Id: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvFAGgC/x3MXQuCMBgF4L8Su7XFXG59XGVeeBMSJBFFF0vfz
 Ul+NE0N8b83vDnwwDlnRA0YDQ3aL0ZkoNONrkoLulygJBOlAqxTa0QJZcRzN7hPW5wKzjhJ3Bd
 lW2SbtQGph/nl8bSWpipwmxkQ8zbwnfD3gXskpLvzylsWDN2Vn87yyHLQzHRx9O0vygkVr3tG4
 nXuHwqh3ys1Z1IVaJr+bzXlpaoAAAA=
X-Change-ID: 20250417-wdt-da6560c1b258
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 17 Apr 2025 14:34:54 +0200
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

This patch series includes some code refactor and adds new device support
for at91sam9_wdt driver.

Instead of add a new driver like Linux kernel, at91sam9_wdt driver is
extended as new watchdog variant is similar to existing one, especially
for the function subset used by u-boot.

1. Remove typedef struct and rename variables for readability.

2. Add SAMA5D4 compatible, it has the same watchdog as SAM9260 except a
new lockout feature is added. Currently this feature is unimplemented.

3. SAM9X60, SAM9X7 and SAMA7 series have a new watchdog variant, some
bitfields bof MR register shifted their position, a new register is added
for timer value.

4. Add DT node to SAM9X60-Currently board

It has been tested on SAM9X60-Currently board:
- Start & stop
- Set timeout from DT node
- Reset kick in with a while(1) loop

Changes in v2:
- Fix SPL build

Zixun LI (7):
  arm: at91: wdt: Remove unused at91_wdt struct
  arm: at91: wdt: Rename regval in priv data to mr
  watchdog: at91sam9_wdt: Rename priv to wdt
  arm: at91: wdt: Add SAM9X60 register definition
  watchdog: at91sam9_wdt: Add SAM9X60 support
  ARM: dts: sam9x60: Add watchdog DT node.
  ARM: dts: at91: sam9x60-curiosity: Enable watchdog node

 arch/arm/dts/at91-sam9x60_curiosity.dts    |  5 ++
 arch/arm/dts/sam9x60.dtsi                  |  7 +++
 arch/arm/mach-at91/include/mach/at91_wdt.h | 25 ++++++----
 drivers/watchdog/at91sam9_wdt.c            | 55 +++++++++++++++-------
 4 files changed, 68 insertions(+), 24 deletions(-)

--
2.49.0

---
Zixun LI (8):
      arm: at91: remove at91_wdt struct in spl
      arm: at91: wdt: Remove unused at91_wdt struct
      arm: at91: wdt: Rename regval in priv data to mr
      watchdog: at91sam9_wdt: Rename priv to wdt
      arm: at91: wdt: Add SAM9X60 register definition
      watchdog: at91sam9_wdt: Add SAM9X60 support
      ARM: dts: sam9x60: Add watchdog DT node.
      ARM: dts: at91: sam9x60-curiosity: Enable watchdog node

 arch/arm/dts/at91-sam9x60_curiosity.dts    |  5 +++
 arch/arm/dts/sam9x60.dtsi                  |  7 ++++
 arch/arm/mach-at91/include/mach/at91_wdt.h | 25 +++++++++-----
 arch/arm/mach-at91/spl.c                   |  4 +--
 drivers/watchdog/at91sam9_wdt.c            | 55 +++++++++++++++++++++---------
 5 files changed, 69 insertions(+), 27 deletions(-)
---
base-commit: 5b4ae0f3f040908602c80908c3023b5454883d4a
change-id: 20250417-wdt-da6560c1b258

Best regards,
-- 
Zixun LI <admin@hifiphile.com>

