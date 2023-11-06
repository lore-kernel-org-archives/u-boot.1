Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8DBC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 09:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B16786EBA;
	Mon,  6 Nov 2023 10:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aJp2+ICO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A23386F91; Mon,  6 Nov 2023 10:01:01 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F75986E81
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 10:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso643906366b.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699261256; x=1699866056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tqbBzzUcbqlPl4wuIBk/nEvRCt1fsH0e0T09a9fRJbc=;
 b=aJp2+ICO9s4kYVP9QMkH62NDmn/nsQKxSLdAvv1Adz2Qk88IYFVvuotCjiRKCzevHK
 Wt3eypsYXdQ/WyMXTm9rxLrmOztj9J9MmNfJ+tglJ13FwF4LtQLggB7soaPFqjIHoxYF
 IKWkY9eLETzo8X6L6pheEq8X6/qHUFJBXraXRXCyf/cpk1KMGn5N6wfmYzsuM5pqO01F
 KjNlZaZ7Rl+5yW//e9C228Sa7l6yBpaK53D+BfZD4SJMLc3f6djl33WDlFTKSHaO45jw
 AoLXkfMG/B6tphATlAKP2xzpSWzkKVqu5aEM4BeiwroMBHZNLxe5bBx/am9cxItDdalX
 /ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699261256; x=1699866056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tqbBzzUcbqlPl4wuIBk/nEvRCt1fsH0e0T09a9fRJbc=;
 b=g1cF7z7vZXMybVMWcwbNdqyRYb1Nfy+M/FLwJST+BeHM5kLi3/tB8tonup6hN6Jsz3
 O53f+gdo5hVr1snFKsCfF6N74Bp7A+pmXbu1ho4uysTmF/YdmahSrx4kM2WWmuCmvrx8
 ss4XB/agiFDd7KbVnUwbixy6I10P2Cede8gqtbIYCS1w2BkRGitF8Ag0M0/2jy5PfTSa
 Ym6BOqPNjrVc94pZa8TwIYiKMrA6jWf12C7kebvMVRjR9utlmQkJFwWG9j0kIF72RU3W
 Gvq7wTCRHPQwAg26DLAuF0KAU/ZO5D+/VCXxjngOd0VMkulA7AZo8++sPfwBR1BH9TNE
 v1Ug==
X-Gm-Message-State: AOJu0Yz92qQIEktY9jkKknXnYpNmP6Y0+GZsRtWGGGSoLqpI6UQ2enhD
 bGJueGYHZb8Hie7ayYz8POo=
X-Google-Smtp-Source: AGHT+IH/6J5JubkYJGIt6JpmjTJ/jRvxgEoSKO7Kp/cYpGHUNcVjAnJRXVCXhR9GUSI2TKgXKx12pg==
X-Received: by 2002:a17:907:36ca:b0:9d2:e2f6:45b2 with SMTP id
 bj10-20020a17090736ca00b009d2e2f645b2mr12442779ejc.71.1699261256531; 
 Mon, 06 Nov 2023 01:00:56 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 uz12-20020a170907118c00b0099bcd1fa5b0sm3870115ejb.192.2023.11.06.01.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 01:00:56 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/3] Implement GPIO cells for PALMAS and MAX77663 PMICs
Date: Mon,  6 Nov 2023 11:00:43 +0200
Message-Id: <20231106090046.258589-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This patchset adds support for gpio-uclass to work with pmic gpio childrens
properly and implements MAX77663 and PALMAS GPIO cells/children as a 
reference and to be further used in devices I am currently maintaining.

All drivers are tested on actual hardware and confirmed to work as
expected. MAX77663 GPIO cell is tested on wexler qc750 tegra 3 device
and PALMAS GPIO cell is tested on tegra note 7 tegra 4 device.

---
Changes from v1:
 - isolate PMIC GPIO cells parsing behind enabling DM_PMIC
---

Svyatoslav Ryhel (3):
  drivers: gpio-uclass: support PMIC GPIO children
  drivers: gpio: implement MAX77663 GPIO cell
  drivers: gpio: implement PALMAS GPIO cell

 drivers/gpio/Kconfig                |  16 +++
 drivers/gpio/Makefile               |   2 +
 drivers/gpio/gpio-uclass.c          |  19 +++
 drivers/gpio/max77663_gpio.c        | 178 ++++++++++++++++++++++++++++
 drivers/gpio/palmas_gpio.c          | 132 +++++++++++++++++++++
 drivers/power/pmic/max77663.c       |   9 ++
 drivers/power/pmic/palmas.c         |  10 +-
 include/dt-bindings/pmic/max77663.h |  18 +++
 include/power/max77663.h            |   1 +
 include/power/palmas.h              |  12 ++
 10 files changed, 396 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/max77663_gpio.c
 create mode 100644 drivers/gpio/palmas_gpio.c
 create mode 100644 include/dt-bindings/pmic/max77663.h

-- 
2.40.1

