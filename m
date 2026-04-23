Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625ADFF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D603D843B8;
	Sat, 25 Apr 2026 22:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kBVqZyJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1639084314; Sat, 25 Apr 2026 20:26:17 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 673AE84486
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b941762394aso1209535966b.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777141574; x=1777746374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z2W0NtqRYdAnm2T0HOW9NVmAlwA4XiLSxiWKhv+m5hY=;
 b=kBVqZyJg1V7MfydB0wo0KWpukw5FQrpSFGdWesweW5n9mHCPF0zAe9RywjbIRg9XKh
 nBf8JeOnH9VxyjCiEVrl1nbK/kDQjo0KGXpgrmEJuK3qBwgCHtAP7f6D12la/QKqpUgG
 Ml3IzTHPSDTNrLHLI9cY1xdwVgiDWFNswRlsyNVELB787xomq6NSN5Ss1ulr+8mW47WF
 3pe7xvRwUAKp1Ku9oif99eWVe27eMVsTYvIMDfuAK5NyMxB5WQNfNOMvwTPFACDrtzAN
 MOwxROc4AKKfQsTZ6imwUZLAJJYvNNA/ItBxXt9b7MtvyW0QsOeudwZh0hqoIHi/HRZ/
 LxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777141574; x=1777746374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2W0NtqRYdAnm2T0HOW9NVmAlwA4XiLSxiWKhv+m5hY=;
 b=DuKXlAodi4RxyzqnYDQuFclk9917niHl7vcUUWOqnrnofCKCga2BdJLlCgR4ToaGbC
 1/KeGi/OW2nuTlVYQVSSlCXnDOisyG0W5ZAgR0DfJLqnGUO/yj4ALChfP0GZdmYCS5fw
 zrCFbSJNpT0UHedK8eqANZxULouox+fBIMx4VNEsRzlG8AELnMqLju6W9SpyrOaIi8GO
 MxUKZ2hAIGPjE8iCcnmsik2YmpZMCqi2BB93yY0wJTxyZeTkM2Ag2DdzmBKDzv0KSBwA
 JuFaxpzh2ng+yQT8F1fNnBTYeSqNqdMW1q6lhMofbUNU5aZJKr2NzGSTUtMouaRCrb2i
 cxWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pRjYmYouzGk+na/xLOLpUrwJ3fOgvFL6g6ZtVGabn2mdRCXcrj9pc2K1N+M/ptsZ43MQikSE=@lists.denx.de
X-Gm-Message-State: AOJu0YzGlQYnMMcHrJwlbqLbxN8gAw1vApquSR0Sf3emo+sCJXQ5aBAM
 yYy8IfD/gt3eaq8KqbUnwi2ECEdscaQmfklqIn3Kkqvyht9QxiSVMAMsYdRrJA==
X-Gm-Gg: AeBDiev9jc+08KIfvVrRqQmrlKMC0zLrzpbnp4Q6k0QdQJLvHneIK/r56FtSN1D+IA4
 yyUMjsRQ349vuLs+sLiJ8meILYwnu1W39VyUYJ2dLaonb/X5f+VN94/VLbE5pKPSJAoZjxZlDFk
 Vhwo3YsSqe3pX9F61UA0h685fBsQd3XhgIpl+oBZBba/jxjSIK5G7fHT56yvBRdljyEQYq0PtlG
 CAi+dhbsOBmMIZYyJzaizJXxsy9sbxtmDC4bLBebj1mGueenLby5DOi6GkqCnXIb69dYmKFtsM0
 sQWexNpcoch0RZalZ8PmNbSUwPf+YFCeCIFxaYbTtLvZUmjpOdKnwxC9qLcI9tc3ZV3KLJYwfhh
 YXZ/cQIDMlUJSbHb6Efv5/gxqhvxbo8eLFpLkcDK02MWqOdB6jh+wILvIuc0r2D57tIAS8k+1N0
 er5Dc4RYqnZheq3QhSZPCHUk+Eoak5+QJeDfqXd6GR3rl0kN8nvuIUuiC7itNB/g==
X-Received: by 2002:a05:600c:4ec6:b0:489:1f98:71e3 with SMTP id
 5b1f17b1804b1-4891f987487mr234720645e9.28.1776949423245; 
 Thu, 23 Apr 2026 06:03:43 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm549381425e9.2.2026.04.23.06.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:03:42 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v5 0/3] usb: gadget: rcar: Add RZ/G2L support and lifecycle
 fixes
Date: Thu, 23 Apr 2026 15:03:20 +0200
Message-Id: <20260423130323.32533-1-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

This series adds support for the Renesas RZ/G2L (R9A07G044) USBHS
controller. During development, several lifecycle and resource 
management issues were identified and addressed to satisfy RZ/G2L 
hardware requirements and prevent resource leaks across the driver.

The series is split into three logical parts to ensure bisectability:
1. A bugfix for the gadget deletion sequence during driver remove.
2. The addition of reset controller infrastructure and proper 
   clock/reset teardown logic.
3. The RZ/G2L specific hardware parameters, SYSCFG logic, and 
   compatible strings.

Changes in v5:
- Simplified usbhs_probe() signature to only take struct udevice *dev,
  deriving private data internally as requested.
- Fixed resource leak in usbhs_udc_otg_probe() error paths by adding 
  reset_assert_bulk() to the teardown sequence.
- Standardized resource management by ensuring the probe error path 
  perfectly mirrors the removal path.

Changes in v4:
- Split the monolithic patch into a 3-patch series as requested.
- Added usb_del_gadget_udc() to fix resource leak on driver remove.
- Implemented bulk reset controller support (required for RZ/G2L).
- Improved error handling in probe() to ensure clocks are disabled 
  if reset initialization or deassertion fails.
- Moved reset and clock handles to private data to ensure persistence.
- Reorganized hunks to ensure each patch in the series compiles 
  independently (bisectability).


Michele Bisogno (3):
  usb: gadget: rcar: Fix gadget registration lifecycle in remove
  usb: gadget: rcar: Add support for reset controller
  usb: gadget: rcar: Add support for RZ/G2L (R9A07G044)

 drivers/usb/gadget/rcar/common.c      | 58 +++++++++++++++++++++++----
 drivers/usb/gadget/rcar/renesas_usb.h |  1 +
 2 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.34.1

