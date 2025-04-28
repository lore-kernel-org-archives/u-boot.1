Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F15C369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 583678144A;
	Mon, 28 Apr 2025 19:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="kUqT7oDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FC7822D7; Mon, 28 Apr 2025 10:37:57 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E820680EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso19010535e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745829474; x=1746434274;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mUUuO60kzmjUD+0PWfrWO3LPgTXbcVKyMbFJuyJSXYo=;
 b=kUqT7oDJNXHAmCRMM0f3Qs/T4fP6sgJnfenSFQaTzzJEEIuibxDAMcrmwp7wBMFXTs
 kkG/geS+QQQmKDvllN+xeMwT69Fk+zJoTJ8TxFPYxFrx5eVMAeZrFOAc//rxG+QvE+gi
 XeSSIc0MLdqVKEQ9W1yJuyyGuHESfZuxX1TILDG+Bs0C9FtX++SREloLFxbQhIfBTll/
 ar07MNbq9sp7JUsKAWW14TwLKRKQ7dm+6O7B9xAfBg20etkpkE62qlZVJ+EPVFQIPbAY
 YmWSgnsBqNJEwITI56l81IiBYO7kaDZZlh4mGPsgDgUEGKobQqoiNgl/BP/CfQcCUP9e
 QzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745829474; x=1746434274;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUUuO60kzmjUD+0PWfrWO3LPgTXbcVKyMbFJuyJSXYo=;
 b=avQU8sQZWF9sART2yrrmsXuPqxLVBcZmKG4lwsMzrZ00WtPWO4cAna8FiRRhYx3nWq
 5K+SHiOBN3OnGHtKP944Y4/RIbXSZGPUP05uRAtjMvPWnBIasPeF3PWAgtsBcqsbduYG
 Iyr4y/kLwQOT2lPJV1E6DcUJj3on5lesLjLrWgYGRTccargs64+Lw1d1dgU2xglpqEAk
 nQqacDmHLt3L9J8SH5PUeT9PmnRNf/ctBCJwoQclAtDIW4zjwrLbfrH+5GPEh743Wr8S
 5shKHBqLmsSU5iDSwVvia4ek0ig0h5/yHdQlwdQG5xUBuNfr7GSgHzKVRe4YO0TH/WbF
 PMgw==
X-Gm-Message-State: AOJu0YxVNssCmqV2muUy7OrmT02xDTtX10KgzCoWPPUuQ3YZwHPMbGnf
 5AJhcmhoQ9lw5SuZXXsG4VYHQvOlrMDOb6scjLViZ3VTeFUp6QZoKlXb7syGObY=
X-Gm-Gg: ASbGncvdfT/zHXMF8tSb0hd8hw2vnQA44XTYmImES34MvJZCOjKHdtLOKT6zjFsARD5
 AOmUZGk8grhbgsu4bOe+EXb1sJI1ncpO1pm1kBJR+P1Dlpl7CsEut/M3BrlvBmWoHVa2X3P3lcb
 shw314kabXObhYt5uaxsDQFn41uRT4SsUwuS2kYgAKbx5sSgzozX6y4Nqt0uhz6S9I1JFFBAr1x
 Fwxin53jVzKqD9IS+A3e4++Nq0QsOnC7bRPTGUYKytHDqbscA9VmVRAGGIp0weZH9wgP9HJtN7E
 xTUPRWwKxp1EwwIhlMSQFGtBf+nVyfdIqxaPKAU=
X-Google-Smtp-Source: AGHT+IFvcG2f9tjcriCzx6Zd3dr7+9j70R5NxczTxDPI4Sj+KqI3Ebu3IbrhxjHv1ZYGCEo3HSryNA==
X-Received: by 2002:a05:600c:19ce:b0:43c:fa0e:4713 with SMTP id
 5b1f17b1804b1-440a65d1616mr102681305e9.2.1745829473996; 
 Mon, 28 Apr 2025 01:37:53 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-440a52f89b2sm121139285e9.8.2025.04.28.01.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 01:37:53 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Subject: [PATCH v3 0/6] watchdog: at91sam9_wdt driver enhancement
Date: Mon, 28 Apr 2025 10:37:33 +0200
Message-Id: <20250428-wdt-v3-0-86f0c5d92c32@hifiphile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0+D2gC/1WOuwrCMBSGX0WyaiRNm2qdvAwuIoIionSI7Ulzx
 F5Ma6pI392azeWHD/7bh9RgEGoyG3yIAYs1lkUP/mhAEi2LDCimPRPOuGCBN6Ft2tBUhiJkiXf
 lYkp6Z2VA4cu1XOKelSlz2mgD0mVXi+H6/YDzViovCoqTXr3sMdzs1FLcAIWxh+2z3WfDdRZWr
 WAH/7aY5xLv48xpUua/EY11U5q3e2r5b+r/lOWU0SCK/CiFYOKDN9eosNJ4B1cRd133Bf/LQRb
 vAAAA
X-Change-ID: 20250417-wdt-da6560c1b258
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:16 +0200
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

Changes in v3:
- Merge relevant commits into one
- Match DT node with Linux
- Move default timeout from board dts to sam9x60.dtsi

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
Zixun LI (6):
      arm: at91: wdt: Remove at91_wdt struct
      arm: at91: wdt: Rename regval in priv data to mr
      watchdog: at91sam9_wdt: Rename priv to wdt
      watchdog: at91sam9_wdt: Add SAM9X60 support
      ARM: dts: sam9x60: Add watchdog DT node
      ARM: dts: at91: sam9x60-curiosity: Enable watchdog node

 arch/arm/dts/at91-sam9x60_curiosity.dts    |  4 +++
 arch/arm/dts/sam9x60.dtsi                  |  9 +++++
 arch/arm/mach-at91/include/mach/at91_wdt.h | 25 +++++++++-----
 arch/arm/mach-at91/spl.c                   |  4 +--
 drivers/watchdog/at91sam9_wdt.c            | 55 +++++++++++++++++++++---------
 5 files changed, 70 insertions(+), 27 deletions(-)
---
base-commit: 10f48365112b164bee6564033ab682747efcb483
change-id: 20250417-wdt-da6560c1b258

Best regards,
-- 
Zixun LI <admin@hifiphile.com>

