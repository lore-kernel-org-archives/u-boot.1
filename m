Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0567C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 10:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1528683A2B;
	Fri,  1 Aug 2025 12:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G0FESh/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91AB483A35; Fri,  1 Aug 2025 12:40:07 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F6383612
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 12:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b7834f2e72so1254209f8f.2
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754044754; x=1754649554; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LYzp0X/Lxkw/uBsGb2sxIi00jcrFv/9fFhZrhBGB2qo=;
 b=G0FESh/GebBFkx5LUXC+dcWnFkhFBHxwpnmGaDurgwM4NNUqaMmKs3CDzbqO1MugBI
 73XRXqZt/da43mHy923u4T866iUy6By0+aAD3YVO+lO7rZQyVFOYKzPwjBL+ZFXwlPGB
 tIvJrRiLnkt0RYldILeuebixfLt87cWQAhiZpJfrio3kaOh56GvLNHNO6gOyHq+6k0OR
 KBhUaEbZgFnJlYh1Pm16v9kUtJxjDeIescwFkyiZ6KQFivnN6GzPv5gmGlkQQb+4Xoxw
 +GbZec4ecfSHovdT7fe8pf56rGIKjdskaz8Tl80r33U/KzpP8ftwMD7HsD5GaSIhPdcd
 F5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754044754; x=1754649554;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LYzp0X/Lxkw/uBsGb2sxIi00jcrFv/9fFhZrhBGB2qo=;
 b=sFSD6U/ReZ3v7nnoDnYgER2RfKR8tq4z0AH/n1gvpTDwzJIYt7D1EwuuXdtDidfzwF
 zrx06LYubt/mpUSDP/5cbPRQH1eA2jbZdtLaRkCgrzdwOG1b3kM2F79J38q3T33h3Nb8
 aLn0Vp+0StvUfd62lAqP2wwjKc1V2kKCcCfj9YXD5KjBnDesldXpFeM+72SIKsSu7Ekb
 mYCo9KgLXpOure/HV8PfBM/Paq/Pk6+W8ZwGsyFJrh3vzVEs8eZG5SVqRI77GtH429CQ
 xHQxcism28H4Yn9cGU/NEmRLjk71lH55j50rkNbzTqhjA/8Ini0WjCaTPk5H0646J2Mz
 gVMQ==
X-Gm-Message-State: AOJu0YxfUbav13HjAoMUCVs5EL2mL17K/rhiYwlxkWO3XnKl9HhKoR0l
 UdvAZTRj+KnKkY+equ+Q3dYk9tMDnYhkKa3bd2RRGxSE8X5XtO5TKcTPMEBZy5LpRtqu5Wq6ZxC
 9zdG5gs4=
X-Gm-Gg: ASbGnctmA70SfpS/eXQnpsWoW/HT1RYDvHtP7Yhy22OOgt21wvIV6/KL656tI5n7s1J
 k9Cu3BXuiZLgPBK/H1buDSs5eEWaIeWh2fMQe0RriSCouPr5PYxogL7dBObQwf2UsTQMsAsYwc9
 VMJAVgd+AD9yyC2JY0kk6uydm22smUisIIuU5n5QdCp1SUtkWYWOrCoYr2vHr8X4jrbPb8eVXjy
 aDNgpW7YsldiQ7vXBF0vquCEUhd3lFXeeZ6aSPz2kCMe9fY8iFmjYwUm5sx8zl2wiOP5kQeWJqH
 G9e+yMqE0M6sCR4hG7CLnCX8cTBwZBbBzWM77gsKPZJ4OoN/Ym2gqx3gLvvkZ8LmOSziV0Wjyte
 kevYN/vMHjwp9DuEkACfXGnSyr9pnQ2qMSoSzC88bDSD3C8sZnulG5+witJJ4Rw==
X-Google-Smtp-Source: AGHT+IFGbbU2o/kRtNbc0Vchg4h5/buxYfBKam2WXuRe3BLdk5OX4ieXzudL9gsgUaiTpHCA1U1PAA==
X-Received: by 2002:a05:6000:2c09:b0:3b7:890f:64bf with SMTP id
 ffacd0b85a97d-3b794ffdacfmr8507149f8f.51.1754044753731; 
 Fri, 01 Aug 2025 03:39:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edf5638sm59830275e9.4.2025.08.01.03.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 03:39:13 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] mtd: rawnand: Fix some Smatch reports
Date: Fri, 01 Aug 2025 11:39:12 +0100
Message-Id: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCZjGgC/x2NywrCQAwAf6Xk7MI+EFd/RaRku9Hm0ChJ0ULpv
 3frcRiGWcFImQxu3QpKXzZ+S4Nw6mAYUV7kuDaG6OPZZx/cNNdeUGqv+Ivukq7J55hTCRlaU9D
 IFUUZxqOa0GbSQ3yUnrz8R/fHtu0QuikMeAAAAA==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported some errors with memory being leaked on error paths and
also error paths lacking an error code to be returned.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      mtd: nand: pxa3xx: Free memory on error
      mtd: rawnand: stm32_fmc2: Ensure to return error code
      mtd: nand: sunxi: Free allocated memory on errors

 drivers/mtd/nand/raw/pxa3xx_nand.c     |  1 +
 drivers/mtd/nand/raw/stm32_fmc2_nand.c |  6 +++---
 drivers/mtd/nand/raw/sunxi_nand.c      | 17 +++++++++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)
---
base-commit: f5e968a28e7cdc2c4365f5a382e02f074ee03fac
change-id: 20250801-mtd_nand_raw2-739308283b18

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

