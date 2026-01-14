Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6223D31A2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3368480325;
	Wed, 14 Jan 2026 10:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e4+Nkhdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C35883942; Wed, 14 Jan 2026 09:34:37 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB355830A0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-652fdd043f9so3340334a12.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768379674; x=1768984474;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ibgk4U2TPOm0nFXT2J7TrMF5RDxFcRr3DBOKzJlQHcc=;
 b=e4+NkhdmXvA9kMjohOwqCu3zhOR3KvAyJgmuf1l+OLX0U+LbZQw2Im5+vFnQ5mEzsG
 aJmYSB+BUkW6vh6dHFiXOSQTSrPkI0619v7iIYoynDUjPmYC+hYdlxRbVe7bEsrPvmff
 mDG+EpI0z1wEyFV72V+vXIdApwleQihayMmELalcCBPpLxZUSanCvF/egKolKuvhwOtA
 P8G0DxuatodO2dg94YH4f/rlcnqKLFKYhLAgPHZ3cs3tXTZOtxbgoj6HzrtYMb2Ewf1n
 Ob5Y7KtyGm/RI0MtizkHyclcX3etObVJfFRaAYeuIqMvtYDDcwgGYwJZEhJiZs18u3PO
 tE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379674; x=1768984474;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibgk4U2TPOm0nFXT2J7TrMF5RDxFcRr3DBOKzJlQHcc=;
 b=ug+VyYrV6VsLoQ4ivqeG//GOBsrmrbHZzylC3ukjcR8g869i9Vih9F9AP7bZPwOxww
 0qDTLZXxaiyACyCUy1gdALT2pVux+MR6UJlh8yiSf8qZJrLtemTCotEvspeS5dgUBbDu
 wxmDTrXAHlx6E/X+1jmpg1He+ZnKz1ihjCEdghWL6TUse8XluWf6OSR3Ara5OfAlPAgo
 dzxW3hYRU7XjsJBZmhZdaviULElRi93wanNVj7Eu4mRQd0Cl0e0u1Cjr99EMZxKYMob9
 MyddPnleBrBf4wZob7jknz8wgbVDm4Bok5EpLYTKnc3Y2xipnUX5VT1Z9350WD/VMKeu
 F4HQ==
X-Gm-Message-State: AOJu0YxGc6atSYPMciIllb2VDCSn+HfYvSnjBZcytfkaiOcHAYxR4WVS
 GMaetFdIoO3FIBpxIdu2OlydRzomrRzF3Wr/u8uhamgDEHsdMxAURy+hqYY83T6zcfk=
X-Gm-Gg: AY/fxX5uleYcY4LXKibzzvJTrvzcXihoFyd5ThlO7CEDscQheXylZeN00yIkfAE+Otq
 DghAFzLhGdSmJW/Cgnz+AohOjQHuiN78QdhN0j1EmCSMunMV/T25RTyZ01X6uF7jbxbXIWJUewN
 afzpuX1+sYb3rxKcn4ON0e3PgMLqPxF74ztGVr3PWHZ/w0cA01mFeM99fAsDg5ljmcHSRl26qan
 /IeBwMR+V0nGU9KKth4siuWZ0v/edTOcGc9w3ck2weoWVtFfAW7QhazJvFabiHHz39aSBNeylI6
 vNhyFQyiGKULP2cu6pmgRZYPKidSka6EKqR+Ct6nHmroAgvmN2P4vQaLiZyJdos3dZEnTiNEyd2
 rG1VQmgiSKq9ndN//5KyeHVDyeaXlmGl3W7aE9Jl68eYgmPvNFG0B7mMfPcg0WOb9FZ6p2MS7pi
 YrvE6VFNse
X-Received: by 2002:a17:907:9694:b0:b87:115:a714 with SMTP id
 a640c23a62f3a-b876787b1e6mr87449866b.30.1768379674218; 
 Wed, 14 Jan 2026 00:34:34 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b871081b04bsm932438466b.53.2026.01.14.00.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:34:33 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v3 0/6] dm: core: Support same compatible in host/gadget
 musb drivers
Date: Wed, 14 Jan 2026 09:33:47 +0100
Message-Id: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtUZ2kC/33NQQqDMBCF4auUrDslk2iUrnqP0oWJUQeqkcSGi
 nj3RsFNFy7/N/DNwoL1ZAO7XxbmbaRAbkghrxdmumpoLVCdmgkuckSRw+RGMtB/gobRO01DCzE
 dFXAElJlsmqbEQmmWhNHbhr67/nyl7ihMzs/7s4jberjq1I0IHJJblyYrC5T8oav5Tdrbm3E92
 +goDk5x5OU5JxInqqwwynJbyOqPW9f1B4MgSkEYAQAA
X-Change-ID: 20251125-topic-musb-probing-v2026-01-1343fff8176b
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=msp@baylibre.com;
 h=from:subject:message-id; bh=K2XKkPU1tL6HcJ8qriRcQaHTBjP4pSEqyDo7FBUPK/E=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz0kC9r0z2rpm95EnygyDu0ff/n+98+bvJh8Fo3Y5lR5
 q6tGR8EO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi02QZ/ucWRh7xSP/Q927n
 v/Drl/bunO+8csPC7PLDy9915ylW9k9hZGhX83eYG/j4+80N+fOTP6wXN6//+VRQ+L+v+5crm/e
 H7+IAAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 14 Jan 2026 10:17:21 +0100
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

musb currently uses a wrapper driver that binds on the parent device of
the actual musb devices to manage the differentiation between gadget and
host modes. However in the upstream devicetree this parent devicetree
node can not be used to match the wrapper driver.

To be able to probe the musb devices in host/gadget mode directly, this
series introduces support for returning -ENODEV in bind functions
resulting in iterating the remaining drivers potentially binding to
other drivers that match the compatible.

It also changes the address parsing of musb-ctrl to be able to parse
relative addresses.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v3:
- Add short paragraph about performance implications to the commit
  message
- Add a new line in the test
- Link to v2: https://lore.kernel.org/r/20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com

Changes in v2:
- Added a few patches to remove nearly unused variables
- Changed the inner loop in lists_bind_fdt to support set drv and not
  set entry->of_match.
- Cleanup the loop a bit more
- Link to v1: https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (6):
      dm: core: lists_bind_fdt: Remove unused variable
      dm: core: lists_bind_fdt: Replace found variable
      dm: core: Support multiple drivers with same compatibles
      test: dm: Add compatible multimatch test
      usb: musb-new: Relative ctrl_mod address parsing
      usb: musb-new: Add compatibles for ti,musb-am33xx

 arch/sandbox/dts/test.dts      |  4 +++
 drivers/core/lists.c           | 73 +++++++++++++++++++++---------------------
 drivers/usb/musb-new/ti-musb.c | 36 ++++++++++++++++++++-
 test/dm/core.c                 | 15 +++++++++
 test/dm/test-driver.c          | 26 +++++++++++++++
 5 files changed, 116 insertions(+), 38 deletions(-)
---
base-commit: 127a42c7257a6ffbbd1575ed1cbaa8f5408a44b3
change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

