Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A291C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 07:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02E887F58;
	Mon,  4 Mar 2024 08:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eOGASkTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D29D87F3B; Mon,  4 Mar 2024 08:04:08 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4410687F58
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 08:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412e66bc492so1112365e9.0
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 23:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709535839; x=1710140639; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i5vGTri1InLqJAiCHTDvS5uQy/bnbRvEWK7xU776830=;
 b=eOGASkTQuLQN9V4ly8fqpGrzOQ9rMli70UzDWybrWWBhswbshvloEa3A2eRpNlWCCZ
 WLF0eoZa4RM50ZFD1ulC1j+QdGA0nz301f8wPa4htHlsfOmH4Mk7bAlP6uo7AoOd8NcK
 4kXt3aq/jh383DX/gNIofAJOgADwEo0AlTi/BlkLYSQgbEucjLdbWGow0ZAu0Z022Yxe
 GVPik1F7LyWLps/t/o/uFwvpO2NBg2p7vCydNomkc/tJPS2Hx7SULvFl7x5aBqBwi35V
 ehMqVuldLGYgXDdQp6Jz/6cqRQ1HmGISZrAJzsaFA/f312Wa73oBRZA0xQT/GXc256xG
 oMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709535839; x=1710140639;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i5vGTri1InLqJAiCHTDvS5uQy/bnbRvEWK7xU776830=;
 b=nLmQX1Xj+xDKv4sbt1m2xJ5D+7/oYWJjrbPyBwmjvKFG5RimJ2SPsznyOUqqY0j87Q
 eJgccPi/qRfRVdmU966xjBKjcXi7DRdPbuJL6pI4OwngZiZYqnkZAGr4ziYvPt3zNfqo
 sXiWTwURXeqlPQ5Ysp28dmUj+7FPUMShMrmc1SEHS3NECn/fLHETikpnSe4tJ2nLiIVC
 TA57mDdDmHyCRelTr/lF57HhD3Rxbbi6um+BgmfikEHISutX0ThHkO/yolHQwX7H4Ptm
 QYOSBoVJzHnLpd282GR2M6sl+MFVnpLVr7LGI5X3/KG/OU3L/snbW8E0EAlp342p6GBd
 4/DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbqDcBy3oyzrQIQX+Yqcg0ckgVp0qR3eOvPoTGmtYXn8fZuVyXZ/ClVVmtcL+iP+x/rdZJnJkP5kW9qWLnoecX3DE9hA==
X-Gm-Message-State: AOJu0YwdyYaS4e9ar8Azv3f9cQQ26YIt4tOEQlLKSbBJAlKyFpGZfSp5
 eXkW8ZKZK5WWc3dsl08w5SRBr7nPx+qwbXozvlLmN2fC45JeyAQm9A/Apk2dhSw=
X-Google-Smtp-Source: AGHT+IEzk9BGs5qpIYkfIMWFblgUwOyd3tMdc4xXyqzhPzD+n96lxtJ4oxbNRtdbeOQeRuA8gllmMg==
X-Received: by 2002:a05:600c:1c89:b0:412:d0ab:a34a with SMTP id
 k9-20020a05600c1c8900b00412d0aba34amr4258049wms.31.1709535839129; 
 Sun, 03 Mar 2024 23:03:59 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 jr18-20020a05600c561200b004127057d6b9sm16487731wmb.35.2024.03.03.23.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:03:58 -0800 (PST)
Date: Mon, 4 Mar 2024 10:03:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bin Meng <bmeng@tinylab.org>, Sumit Garg <sumit.garg@linaro.org>,
 Fabio Estevam <festevam@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?us-ascii?B?PT9pc28tODg1OS0xP0I/UTNQemErRno/PQ==?= Bence
 <csokas.bence@prolan.hu>, 
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/2] arm64: Enable CONFIG_64BIT for static analysis
Message-ID: <1cb3255b-5ed7-443b-8a02-6e998126d417@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The makefiles currently pass -m32 to Smatch static checker when I'm
building on arm64.  Also the arch is set to "arm" and Smatch thinks
"arm" is 32 bits and "arm64" is 64 bits.  With this patchset we pass
-m64 and Smatch works correctly.

Changes since v1:
Break up the patch into two patches.

Dan Carpenter (2):
  Kconfig: move CONFIG_32/64BIT to arch/Kconfig
  ARM: Enable CONFIG_64BIT for static analysis

 arch/Kconfig       | 6 ++++++
 arch/arm/Kconfig   | 1 +
 arch/mips/Kconfig  | 6 ------
 arch/riscv/Kconfig | 6 ------
 4 files changed, 7 insertions(+), 12 deletions(-)

-- 
2.43.0

