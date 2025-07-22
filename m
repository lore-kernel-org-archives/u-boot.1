Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01E4C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 09:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F25383768;
	Tue, 22 Jul 2025 11:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="mFV70zB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C8283346; Tue, 22 Jul 2025 11:55:59 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46EC883346
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae6f8d3bcd4so959850666b.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1753178157; x=1753782957;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+mYX14J4VNc+QHQwP2szw2tlcJnWrsxaeweigSFSKd4=;
 b=mFV70zB6gqWW5MGCmJHard1SE7ksksdkMyXL9m7DkIZJw6RvaBftjPZEtHMLH0VxLF
 7z8XNTyy7qucklrWtfuc4NU7g1XEpHxEPqEot17lgTsQzQIlSSuLa6a/5FyymKBZhr0L
 gWrsvUMgEyvofxMUvuue9w4+W8nzhaxIR7WU24cuh0TRBW29QeHuqbbnnT0jguh2veGf
 BAltEmPcGRnVqiuLv4nUWleQ5OoCNHkOdfMb0fiE9QGTqfPz1ZJrLzFerXjB9K8u6SW5
 r/C3S1/mTrfgv+ib8TD1v3o/aA5HfskEd4XPA9VbE6CyZ+MYf5Igy0MSsBu/tjbv+kUZ
 YtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753178157; x=1753782957;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+mYX14J4VNc+QHQwP2szw2tlcJnWrsxaeweigSFSKd4=;
 b=GIVqKR3NxWb/aQiM0l5VWZzSSo1bcjDe9U8ZsYVJJixp/FTfFQhXRkAOBIh0Fi758/
 oWzc+5MH5+NBQpFwvL2vZnPI4uX575LpxdfPp483eC0L5ahWG+qWkko/cAYV1yBrIHa4
 WiLo/C9em60/Zg2qg0fEYPb1a4G9Re/ons6JaXgOfU6mwaLDEGizjSo89YmuO/4c9QCC
 k6JrsyucRw82h9Lz7oN01CZHnuBKYU2iws7lZASB17jCJbRbtj3otTav8LL9s/bpIkAd
 GTzT/k6fNKKMU7TqycqujeqogwZ98fOA6IQUMS7v4OIwDFviBwdbe5feh/krs/XEfnWv
 aGbQ==
X-Gm-Message-State: AOJu0Yxe8+VXZlmj54mu229tmZvVinCYutot9Kz/2WvEt+gHe8FqtS+e
 t/lRfqda89EK5qN0BlQ1LjOFOF4ko8YiKwQ3egrUX8e4TDEce1ZYIMPxSDJ8Daq1M+Q=
X-Gm-Gg: ASbGncv2A7KBgwJwR83OmXHB3ayfk5UaqwshXyjCpzwMkRfXxFiJaIrAzX9ae4/O3Xw
 7+c71ykoPUQYL5aUA21S/zt3AhRXaqckofAb/AvEeddOx3io6NMtdCwB8lAlQi4uzMOmeMoGZOX
 Pednbyzy7Efl0hr9Uh+2Tg5i938om3UATUTo8vP5kKGCe65ffyes0K0bA/MaeeMdKVpnA6M3emY
 HfTug2xTHrL0dyOcc6NI4xcfQ9ks+YIXu5Or4WKAuPuzqCdydFX4ug3/bAHmkL/OQzEX3Kf0W7G
 deqTD0YQjshnMLMmtQvIme9DB2TiCHUqxQjgaDwMEP7cu0SnBiDVnHeM2+I+NpEJ2E81MEz4MtD
 5OQ+7CpokuuY7wRxMxEfCs/TZKjn2v6dxmw==
X-Google-Smtp-Source: AGHT+IE9RFsKpeoYNzRMqeWkYQg0RI4Ndw6hQMntFHLykvVXGZT8xkjUtHmU8N21IfLPg+LJMrMGKQ==
X-Received: by 2002:a17:907:3c83:b0:ae3:bd92:e69b with SMTP id
 a640c23a62f3a-ae9c99814c7mr2558651766b.7.1753178156640; 
 Tue, 22 Jul 2025 02:55:56 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6c79c279sm834754866b.28.2025.07.22.02.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 02:55:56 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v4 0/5] Extend usb_onboard_hub driver to support Cypress
 HX3 hub family
Date: Tue, 22 Jul 2025 11:55:32 +0200
Message-Id: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRgf2gC/43N3wrCIBTH8VcJrzPUMzfrqveIGM4/6cVm6CaL2
 Ltn3QwiRpff34HPeaJkojcJnXZPFE32yYehRLXfIeXkcDPY69KIEcZJxTieUteGoQsy6tZNXas
 e92hSat0MmAmgRwGWGm1QEcrF+vmjX66lnU9jiI/Ps0zf639upphgUIpLUhPRKHsenZx6ORp1U
 KFHbzuz1eOs3vZY8SwIVlGupah+erB6NSXbHhSPgyWgOwWENt/esiwvDApWxmoBAAA=
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

This patch series extends the usb_onboard_hub driver to allow for
support of more types of onboard hub devices, and adds the Cypress
HX3 hub family.

First patch in the series updates the bind function, so that it no
longer uses hardcoded compatible strings.
Next patch simplifies the code, by removing unnecessary dm_gpio
function call.
Third patch updates the remove function, which allows the prevent
issues with usb devices reenumeration, in case of calling
"usb reset". Although the issue could still occur in case of invalid
initial state of reset gpio, it is minimized with no impact on main
usb_hub driver.
Fourth patch extends the driver with support for multiple power
supplies, the same way it is done in kernel driver.
Finally, last patch provides hub data and of_match table entries
for Cypress HX3

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma Haikou
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
Changes in v4:
- PATCH 4/5: Minor updates in for loop in usb_onboard_hub_power_off, as suggested by Quentin during review
- Link to v3: https://lore.kernel.org/r/20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com

Changes in v3:
- Rebased on top of latest master
- Updated usb_onboard_hub_power_off function to print error
  message in case regulator_set_enable_if_allowed call fails,
  as suggested by Quentin.
- Link to v2: https://lore.kernel.org/r/20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com

Changes in v2:
- Replaced the method for finding hub in bind function with
  uclass_find_device_by_ofnode, which seems more appropriate 
- Added new patch that removes unnecessary dm_gpio_free call
  in usb_onboard_hub_remove
- Create separate static method for disabling supply regulators
- Update error handling in probe function 
- Link to v1: https://lore.kernel.org/r/20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com

---
Lukasz Czechowski (5):
      usb: onboard-hub: Use the ofnode to check if the peer-hub was probed
      usb: onboard-hub: Use devm API do automatically free the reset GPIO
      usb: onboard-hub: Set the reset gpio pin before freeing
      usb: onboard-hub: Add support for multiple power supplies
      usb: onboard-hub: Add support for Cypress HX3 family

 common/usb_onboard_hub.c | 102 ++++++++++++++++++++++++++++++++++++-----------
 drivers/usb/Kconfig      |   1 +
 2 files changed, 80 insertions(+), 23 deletions(-)
---
base-commit: 5a8dd2e0c848135b5c96af291aa96e79acc923ec
change-id: 20250425-usb_onboard_hub_cypress_hx3-2831983f1ede

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

