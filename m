Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2E7D3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 22:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B3883B63;
	Sun, 28 Dec 2025 23:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DW9zflcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3093F83B6C; Sun, 28 Dec 2025 23:38:33 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D389683B0B
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 23:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so6591240b3a.1
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 14:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766961509; x=1767566309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3nQsExmKACGkFcnMtC5fEdqtKJpM/XZBDG/bAHXg590=;
 b=DW9zflcq0Z2131/4KRxQwGElJmWB2MOr+VDgsnxmW2EVYT3Vb1TFUoCpRASxSO2XlS
 INWjHToFbCTV4tAqwSIuaiM8o1GrnbFKTDz/72a5xAT+EAzJXXpy2PxYqF75fkO4DK4k
 E8xjUqLOqTr7CRritNRekXokPA4HDt/e/0zGs7x2fUr1LlOAo5OlpEIi68dLmjHduFIw
 EPY8a1N7FlSkwKLx/VNV8D1KSHktGylvTXxkWazTjpe3Y5qD+fCyQKeEXJ+G8gYiBCxx
 x9lmOQ4NLp/fKwT3F9LR1+WE3O/lL2jXBCc0CE8+zEavL2OO72WRnROGWI4UMSAwzCH4
 lZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961509; x=1767566309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nQsExmKACGkFcnMtC5fEdqtKJpM/XZBDG/bAHXg590=;
 b=GSV9QLeypg+eQZO64zaxncs6lHc91v0ii5ykQg+aZHdReyPrvWPf5S7r7aa8xWOxfs
 Y8IujAHt5e8RBkx5JkFAZpA751Qoncx6OEOaG5PirPmgdqyB0tn8NHUaf47q72EqtWw7
 GlycFr30pC7im2ob0jDQ5+M8dt2TJs0DyLdzUK2/xhLyPL+oL++plHN7PuttQnJsZh4O
 AW4KaDexz73H28B3RV0QlmuLpJfJ/y5vN8YwiYCzhxagdE/WHr0y6ODL8SSDmCGEdYmW
 Pr39HnnFapWuuqF346Bei5ezDYhuNgOJeNJGquM6+HEW1eRJz3REmyHvL199ZZq2BPQw
 delg==
X-Gm-Message-State: AOJu0Yze08OJypycwbyxL34Wtouuoa7C3Zm927G1o+Dz5zt1hFMo5TtU
 NqIVZE2k2uWm1PJhMFODXVR+wqCl3k12xWYD4sMTcbZcglDo9VbTEzETl+DhTJIG
X-Gm-Gg: AY/fxX5XNrzxbz1HlGLUdETOf6+XB6azHhscmH+jERjej5WJ+WYMCGIVWlynasXLaEu
 IP0wiFKP9sHU0UeMbqbytvFiPCOXAhqZlNC4DjyQZsaJtIGihI6QCelCWAl8EEO4ICcQiLOZmpz
 OgpRbMkI17lGWWtMMjcn0dgJjN380lnvTxgPmee7RHED8rYG7FL7O13Ljs39FDIfJjTyPCA9wZT
 v0rJPGqe+h4WSZsalEOXXCwVFp7OTAO3qgXyj2As/z9gOoZh9Ff8fRNZZyquvj7apNi1BME6HAZ
 gqWpqifMpsQ1tDafTaO20sJbkBWuloJmZcTNaEQAcZMaOaRKLmtFKaoszfTfDMO22wAZOOAc0bZ
 /NAir3lSmKRHdKqFeOuBHgkYWBuJy0VctaKLjaQ//CGKP40xYpeYY9QNZfQvrbKBr3KVLSzGlAy
 UvJXLVhPP8OG+xTJ0rT1il5Fta4a8JMwCyr5sRp69t+xp5
X-Google-Smtp-Source: AGHT+IHXb9ahvlkBMxnfTAwcsaIihFsoR1Ujfqj26IS0D+S52Z3LFAMZidNn81zs4yXLaq2VJnGReg==
X-Received: by 2002:a05:6a21:e082:b0:366:1e42:630 with SMTP id
 adf61e73a8af0-376a75f5bc8mr24845307637.1.1766961509005; 
 Sun, 28 Dec 2025 14:38:29 -0800 (PST)
Received: from intel-VirtualBox.. ([185.213.82.236])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c7263a3sm23499331a12.32.2025.12.28.14.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 14:38:28 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>
Subject: [PATCH v1 0/3] Add CoreCourse socfpga Board
Date: Mon, 29 Dec 2025 06:38:18 +0800
Message-Id: <20251228223821.22260-1-briansune@gmail.com>
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

This is a patch series for CoreCourse Board support.

New boards are:
AC501
AC550

Both boards used Altera GEN5 SoCFPGA Cyclone V

Brian Sune (3):
  Add CoreCourse socfpga Board
  Add CoreCourse socfpga Board
  Add CoreCourse socfpga Board

 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  86 +++
 arch/arm/dts/socfpga_cyclone5_ac550soc.dts    | 132 ++++
 .../dts/socfpga_cyclone_ac501soc-u-boot.dtsi  |  44 ++
 .../dts/socfpga_cyclone_ac550soc-u-boot.dtsi  |  44 ++
 arch/arm/mach-socfpga/Kconfig                 |  14 +
 board/corecourse/ac501soc/MAINTAINERS         |   6 +
 board/corecourse/ac501soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
 board/corecourse/ac501soc/qts/pinmux_config.h | 222 ++++++
 board/corecourse/ac501soc/qts/pll_config.h    |  86 +++
 board/corecourse/ac501soc/qts/sdram_config.h  | 349 +++++++++
 board/corecourse/ac550soc/MAINTAINERS         |   6 +
 board/corecourse/ac550soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
 board/corecourse/ac550soc/qts/pinmux_config.h | 222 ++++++
 board/corecourse/ac550soc/qts/pll_config.h    |  86 +++
 board/corecourse/ac550soc/qts/sdram_config.h  | 349 +++++++++
 configs/socfpga_ac501soc_defconfig            |  85 +++
 configs/socfpga_ac550soc_defconfig            |  85 +++
 include/configs/socfpga_ac501soc.h            |  16 +
 include/configs/socfpga_ac550soc.h            |  16 +
 20 files changed, 3178 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_cyclone_ac550soc-u-boot.dtsi
 create mode 100644 board/corecourse/ac501soc/MAINTAINERS
 create mode 100644 board/corecourse/ac501soc/qts/iocsr_config.h
 create mode 100644 board/corecourse/ac501soc/qts/pinmux_config.h
 create mode 100644 board/corecourse/ac501soc/qts/pll_config.h
 create mode 100644 board/corecourse/ac501soc/qts/sdram_config.h
 create mode 100644 board/corecourse/ac550soc/MAINTAINERS
 create mode 100644 board/corecourse/ac550soc/qts/iocsr_config.h
 create mode 100644 board/corecourse/ac550soc/qts/pinmux_config.h
 create mode 100644 board/corecourse/ac550soc/qts/pll_config.h
 create mode 100644 board/corecourse/ac550soc/qts/sdram_config.h
 create mode 100644 configs/socfpga_ac501soc_defconfig
 create mode 100644 configs/socfpga_ac550soc_defconfig
 create mode 100644 include/configs/socfpga_ac501soc.h
 create mode 100644 include/configs/socfpga_ac550soc.h

-- 
2.34.1

