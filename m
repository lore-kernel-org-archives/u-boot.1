Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B65CCF9C6F
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 08:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF4688CFB;
	Mon, 23 Sep 2024 10:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="bncGgyZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D52988CBF; Mon, 23 Sep 2024 10:21:15 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4956888B2
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 10:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-378c16a4d3eso4404163f8f.1
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1727079672; x=1727684472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TDFti6ZyCt9ehIQVDfWU0Bj4mG6mcXVOeyEg9yCQDSk=;
 b=bncGgyZZATma0gP//FVYz1zlOUK2ugDcuw9L8ZEsSFVq5XOKpl+6Ew+MQgMLIhItn7
 EjJGfcved5uKmBjWEuKLcoyk6RJmcR0n4c748ID+Yl+mpqTy7dV+C5S2YJ5VSTLiVFFh
 DLgv0kODdeDoGup/VwyYaIqqSvSpX+U5lPzto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727079672; x=1727684472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TDFti6ZyCt9ehIQVDfWU0Bj4mG6mcXVOeyEg9yCQDSk=;
 b=AyvcDsq5bSiCIObkSFIkD96u2jdiyAYUkbzeWucpKRyefOb+g7+jxEpFJl1BaSRf9V
 bjle5GRrf/vpldarXLGVvY3XoZXCRo5gaRHOHlGOS2+vzL9krDCsjpiigtws0jPh9ziJ
 9uJj6wL3XEuEqkNNPBGlyDYRXghdSG+YFT0t90dO0zmNhP45XKLpKnA5Aerj598hgp8b
 3VjQMHe8aZ/mTbd2h7HvArKL9NF9UYi5e36AK1mXuZXdXcWOnfJjN5CadyzRy0g/Kqtu
 h2WRAT0Zyf6cNDWOe/5pSpij7WXAA5l71XKd1uDL656rMVaPhACoEdPuc0CL6UVECYJ2
 VvAQ==
X-Gm-Message-State: AOJu0Yysd1olww9xzVOe51PL89K+gCTax0NKqkvRTMk1TtJrGeOaE2eM
 ykOt1UumBbq0Z4XPgbJz8ZUPJzeF6YiRWFZi0mHDxQlb+A/TjZTApQpb5xjP5MbHhcZSYdK7gfz
 Q
X-Google-Smtp-Source: AGHT+IHLFK7eunLTfSgv2UFxos5ZVdxPix2B12CQQN6z1GioxWBn8bqcOnTtKxV7dTJKm6fP3Jnkkw==
X-Received: by 2002:a5d:6089:0:b0:374:c64d:536a with SMTP id
 ffacd0b85a97d-37a422c66f0mr9648265f8f.27.1727079672063; 
 Mon, 23 Sep 2024 01:21:12 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78052e4sm23674922f8f.102.2024.09.23.01.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 01:21:11 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Alexey.Brodkin@synopsys.com,
	Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 0/1] add KSZ9896 switch support with spi interface
Date: Mon, 23 Sep 2024 10:21:06 +0200
Message-ID: <20240923082107.16797-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
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

Hello,

We are using a custom board where an ethernet switch device KSZ9896 is
available. This family of devices can use several types of serial bus
as management interface: mdio, i2c or SPI. Due to board design
constraints and because we initially planned to use this device only
from Linux, the SPI bus was used.

Luckily we are using a recent enough u-boot release where KSZ9477
driver is available... but only for the i2c interface. Indeed, unlike
the kernel driver, the KSZ9477 driver doesn't use the regmap API to
access the underlying bus since the regmap API is limited to direct
memory access [1].

As a workaround, we duplicated the existing code to a new driver
(KSZ9896_SPI) where all i2c related calls were replaced by SPI.

So far so good, we are able to use the KSZ9896 ethernet switch using
SPI bus as the management interface on top of u-boot 2024.10-rc5
(and after fixing issues with the ethernet controller driver with
fixed-link). dhcp and ping commands are working using one of the lan
interface (lan1).

In order to upstream the KSZ9896 with SPI interface support and avoid
any code duplication or #if#else... it seems u-boot needs regmap with
(i2c, SPI, ...) bus support as explained in the first attempt [2]
back in 2018.

Is there any pending patch series about regmap I could use to test
with the KSZ9896 SPI driver?

[1] https://source.denx.de/u-boot/u-boot/-/blob/v2024.10-rc5/drivers/core/Kconfig?ref_type=tags#L188
[2] https://lists.denx.de/pipermail/u-boot/2018-May/329392.html

Best regards,
Romain

Romain Naour (1):
  net: ksz9477: add KSZ9896 switch support

 drivers/net/ksz9477.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.45.0

