Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1DAC54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C9187EF5;
	Tue, 26 Mar 2024 21:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rskshhz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5310C87EF5; Tue, 26 Mar 2024 21:49:53 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED8287EF5
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5a1b6800ba8so2121464eaf.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711486190; x=1712090990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UZQDCUBuM998o9Hgc0WYdxlJY1mKvzibddMP01MeaIk=;
 b=Rskshhz75Yo0kOHL2DmFiQn+veTPGdHPYvcbbkUFI9piYn1j3WDYPMnurpGo2ZT5Sb
 mOEcZSuf8EJGuLVovGo6Zc48iVL0fcG2bfBAZbpwto4OUvPO5Lsgz6J3h/H1Hv9zuwTz
 lEHzuS14M6c5gW3e3Q95b1ikDrQhPcgLqKxkA/mHBuXZ/gHorTZoEk4NDgdXwlspCyZv
 +Qg1wq+2H2K89TohJjHtWMhbK3dzNUWBx0BVrL7GhgPldEBkVTDs4a2Fe3k3xuY0swDT
 zWUYLf6qebEI+Ee1WQ6QpOEiQD1PQT9IEM//X8UMvnmIIe/FT9JVm/PTD4l3yx8bsp/u
 RHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711486190; x=1712090990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZQDCUBuM998o9Hgc0WYdxlJY1mKvzibddMP01MeaIk=;
 b=l78h6d5pT1iYvSBhUhelnkAWTfCoRxEX4xkYIpuIpbruiWDompnV3ULLpeJw8jdIs4
 1v33hLvkT9VR471fn3n3vA98Wn3hR9z2tHw6T6koO3Ni8aQkebUqoDoQtftWo5dxBnAc
 gmLjXBBu8Y+fwg84v1aZXzNuYKcIxWM22g8EzAN0iqsqHO2Kv2CTLOAXBRfkwO+CPyai
 DJulW7YYKbeyqjH2JFAC2lUrz7NC1lK+9yxXV0g12yq+rLYP53vCvlxdZqBu5ug5JMK0
 fzzlHUafmRxHyEfhJXeKHKaJfQZ9BXMfzHvRrrFJcOi92NX/0VaSRMR8yWcv+Z/ssAHA
 MoSw==
X-Gm-Message-State: AOJu0YzGbOxsS1K9ynrZKK9rc4WnF82MFRoLIWi59nlWGtjntnJu3MZ4
 wzKCykqNJytYd3Xs96FW/SopKANFkIKJQ+zy2EPYNnY1Op2ULKDhDaTSqhwf
X-Google-Smtp-Source: AGHT+IEOCxRCDxrC60L5VzrYoEE++h/1ZvRknwGPRsMZiej0Py9zn5cSVYemE6yQTDhCujIubPZY3g==
X-Received: by 2002:a05:6820:2111:b0:5a1:b571:4871 with SMTP id
 cd17-20020a056820211100b005a1b5714871mr1097289oob.5.1711486189827; 
 Tue, 26 Mar 2024 13:49:49 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bw20-20020a056820021400b005a5554a076esm1037399oob.10.2024.03.26.13.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 13:49:49 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, cym@rock-chips.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/2] Use ATAGs for RK3588 For RAM Info
Date: Tue, 26 Mar 2024 15:49:42 -0500
Message-Id: <20240326204944.1572667-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Chris Morgan <macromorgan@hotmail.com>

Use the ATAG info provided by the Rockchip binary TPL to identify
RAM banks.

This is needed because there are specific addresses that should not
be written to for all RK3588 based devices with >=16GB of RAM, writing
to these addresses immediately results in a crash.

Chris Morgan (2):
  rockchip: rk3588: Add support for ATAG parsing
  rockchip: rk3588: Add Support for RAM Defines from ATAGs

 arch/arm/include/asm/arch-rockchip/atags.h | 222 +++++++++++++++++++++
 arch/arm/mach-rockchip/Makefile            |   1 +
 arch/arm/mach-rockchip/atags.c             |  99 +++++++++
 arch/arm/mach-rockchip/sdram.c             |  58 ++++++
 4 files changed, 380 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rockchip/atags.h
 create mode 100644 arch/arm/mach-rockchip/atags.c

-- 
2.34.1

