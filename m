Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BA9FA1FED
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 20:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E74F5843D6;
	Wed, 22 Apr 2026 22:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQTmAFgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 324E5842FC; Wed, 22 Apr 2026 19:00:39 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7124A8426E
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48374014a77so74530325e9.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776877233; x=1777482033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oPk1m0aPg8j+UwoQ4iP5hk3aV7aPv5RHhl+hkDv/ScA=;
 b=hQTmAFgWsUeVrLq2Rb1yRymuKQ8xkIYC0rXkMTOGPQaOtg2mgHTLmtAzZ+iCsCg+rp
 YUVX4s+6/Ws3F4T4d2TgRGvIZXgHN7MZDAAom210xj34RjdosSGZ7TI2xUbkMxi8+XsN
 yTSPqAKKG8BcxmYb41mKmQ/z0yFT3Ixkyh+JDdKqaAhG54wd9B9en2eWkiLf9iiZ+mEE
 F9hs7l2xPu+CvqSG+r+QJ4w1Mc2GcOZ2oeNR1xTmSVFQZ5anO6dafwufeFE0h+2yUriG
 YuFXTDPT8IL5AkPO1fYPm/4xsqhonIeE3qXO5sW6WRl2shIc2POYj+0gytU+VBtwu/tP
 aMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877233; x=1777482033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPk1m0aPg8j+UwoQ4iP5hk3aV7aPv5RHhl+hkDv/ScA=;
 b=ALnqaKiDbcRWBCASCQ3/re24Uvaac/WKKAimtjnx8FYqX/DxdWbYoeVZGLPXJOazEt
 ochXczZSvfjbE+dKQsPcV/T3d7cBa9Qkv9WN55NfYwcqrBtkgdxPDFtXRzc1bb2/xhlx
 3YhbffLp3ufk4Nljgus00B4dwQMtDXpiQo87YQ6oqlbNm78+itW4Zo/MZZOkH5oJVF3H
 8RrpoZq9VWKKnSDE2RsJnHbUm+yrE7ETwLXD7DjAlrsSEXe31cwmgpgnnHjE4eYuiRER
 uym0hmzJa6mt5qtmmvfT3OyoD2mlOzsv0jAWcvibpEkwfTq9LagZoeRpZRvXbo7qyeIE
 wLJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GkPW1fr2uVfBDqnmhBxcDUEZxqqfX1IwY6bwzKYT4c5e3dMspgjMXiBWKvSlPsMdIrIzgJEk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzbs954lr5Nk3pPW+Q219VCcI0ErA+CoIOGdVkNJVojHaUFb7cR
 +s+m3HlJGYzTQK8yySsZjcsmPPBG2QlDOjxmGzsn1DLf8ZKPyWzjuyvS
X-Gm-Gg: AeBDiesM6EHsPTg1CNOctL+0/U5/nYoWy8JSn0lY/qvfjrGjecRIfI1TVq6MvcwvLpQ
 uScjrLqSo4cpXedYuTk65Jrb6+aq2oOOOC8KcrUsrYxmqVluQXxiTSZVPftD/9W5GAeQ2eaLjeY
 va0GVmv6JgfksxO1MtFL5rXTNQgyWaBehprs4exmozCxpWM3B95DyO4xK91IEbl0JPg4fagfcOS
 jQjjWaeDF1SuoKXFSmR6YPiG8LAspzhPKoj0CjT7wdskIFzX+M/WEKISqaDoBqU/rbHwVv0a1RU
 Rmi7vQv8I1ww8i+hcqmVNzra3MIfTEskHeVX9zx9LbaoPA5U0KATZ9PZFglJ1fu+WADntyOriHr
 LKtUXjkHkFPOpiTLkzgWhbxzyeNiOqwtj2rXaNpGN69B/1UZFeWtzYFKj4b6SMEhb8Ls+QOKdOq
 DPjOImN1dyfsEZ9M1vQUU2ZFA99JyjVqOHyEdzzEjeVlKq15WWAYI=
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-488fb78ea6fmr335840615e9.29.1776877232553; 
 Wed, 22 Apr 2026 10:00:32 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm453725165e9.1.2026.04.22.10.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:00:31 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v4 0/3] usb: gadget: rcar: Add RZ/G2L support and lifecycle
 fixes
Date: Wed, 22 Apr 2026 18:59:35 +0200
Message-Id: <20260422165938.35925-1-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 22:21:26 +0200
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

 drivers/usb/gadget/rcar/common.c      | 53 ++++++++++++++++++++++++---
 drivers/usb/gadget/rcar/renesas_usb.h |  1 +
 2 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.34.1

