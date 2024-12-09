Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF65CE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79ED189351;
	Mon,  9 Dec 2024 17:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cXV5fd9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E06F89367; Mon,  9 Dec 2024 17:15:01 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F20E89351
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ffa8df8850so47751101fa.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733760899; x=1734365699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XikVbWxLN0AD96MTjrKo/RVXTVcrqHxBvPGbRHPPDWY=;
 b=cXV5fd9FpONop/2G4ujnDW3ycpNpCPRUxAA9v8EAsaINKd/EVD0gRECHsCVoPiBEyQ
 h9cNgxX1oug9x+3+W4q0Qs20IOEAZfzJETt5v8snvoOOi4nAGJeLKFV/YPXuZlAziz1Y
 P2klWeU3FPqXU5w0HLv+SKKPga2OhE0HdRq/ujOhTxlwVDiCS4TOK53sBp0dLtGLo8Fx
 VEhQdXWrS2DSVb8sg2Qn3ELF2UWxCGjqhZZd39GIr++gay334VCRGsF47glb+Hy4lmx8
 X0yJjVL+nVXHisPidfE45nCkGGHOOnGkXY66pf/pP0ARP7PMi1r3IYXU2CNv1+p9k6yA
 jBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760899; x=1734365699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XikVbWxLN0AD96MTjrKo/RVXTVcrqHxBvPGbRHPPDWY=;
 b=CIEVXg7mhliQxdhunkJ3BR8nYYfcLh+rBF7SttYipEk43l6MBpAtAHP2PTnpn8bjL3
 Tx04t4YV/+hLABUBGBktDMDR2thuDxWQYWQw/VKPSxRxVs1N2J+kSgOyhCdFR3B58G2Y
 tIXyUxMrS7WWTeQFK11C8iaL9MS4txKKDhcXNTp/id1ZBwK7DbRXDCUAP0zqZD17sVII
 Z//h8fuSUQ6khIi1Oel52MXD93ZGzGTOenVx/CF4eSe2w5+ipS0dC9j0zV359bV/41We
 KbGc2F0ENmEz1H7lbEEVRJrY9jxnud/1Lg9TTrAxPw6gQFkJQ3DmZMWCaDfFpy3t6x5f
 66Tg==
X-Gm-Message-State: AOJu0Yx2Z9FBpdAfPoek830K3nrvwuxSzxB1fGk2TGNcrUB7ZtQEBvEf
 O7kdi/DiaVEYz/TkllsDiLkHdPAa5miM9ZMVy+fRea3OsRXWTuTH
X-Gm-Gg: ASbGnctcR7UQzBp9GainL/e4htD5F3JDykWkX2fZeSYhwGy2bW790uEZAxlaMnvyxqm
 CDuw2U0s749cKRvax/AZ0ijuWxrdSnypIDyIsIZ5MP0nZyBRf6PboL39EMsHAoz+EjuaHeyek3c
 BNbQPnRNu5gNmvBDERgp8oFlXHRMqB7l3qhEFBnZWb9mzXSWbiiAMZzvuXEeID15v5g6DnLoxia
 Ygj1zpIwyVri6EQuc1QrQSGV2AvGxwd+IK6Tv3QuA==
X-Google-Smtp-Source: AGHT+IFZD4j+ejCq9x+QGhbcMW21iCzVTp4tUKnJ0QNkhVWLcOTcnWesaPc+nXb138z01ZOpNxpxgA==
X-Received: by 2002:a05:651c:996:b0:302:3003:97e with SMTP id
 38308e7fff4ca-30230030ce6mr3966291fa.30.1733760898644; 
 Mon, 09 Dec 2024 08:14:58 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3021a02d90bsm5940971fa.80.2024.12.09.08.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:14:57 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, Heiko Schocher <hs@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Restore original GPIO uclass logic
Date: Mon,  9 Dec 2024 18:14:31 +0200
Message-ID: <20241209161434.6563-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Move PMIC GPIO child handling into PMIC's driver by bounding
GPIO driver to parent node. Remove gpio-uclass workaround.

Svyatoslav Ryhel (3):
  Revert "drivers: gpio-uclass: support PMIC GPIO children"
  pmic: max77663: bind children to parent node
  pmic: palmas: bind sysreset to parent node

 drivers/gpio/gpio-uclass.c    | 20 --------------------
 drivers/power/pmic/max77663.c |  9 +++++----
 drivers/power/pmic/palmas.c   |  5 +++--
 3 files changed, 8 insertions(+), 26 deletions(-)

-- 
2.43.0

