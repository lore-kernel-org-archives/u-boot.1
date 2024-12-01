Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C692D49775
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF08C89100;
	Sun,  1 Dec 2024 16:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cn/ur23g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFAC88D36; Sun,  1 Dec 2024 16:07:27 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E0F289117
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53de7321675so3396312e87.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733065641; x=1733670441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uroS2Mj44zekrjS0PU1auY8DO0I4L37WHeauiMNV8tg=;
 b=Cn/ur23gn2n6s911GuLrUhfCTyKklqEci+Wqjl29tZVW/8svTWsby7To0Mwn6YoHl1
 ioS5gpXEwBMY+w5b8j2d/V9iDM2Whw88OkqL6OBXxCTqm0nAjONB38Jg0DhydB3IvJ0k
 JETL6QAktZBSXcq+JVOMvMryMjkR8Rq723gOSfz5VHlHqUFqAgu21gx4JCRScgCyexJD
 AIjL+FuYTuTBoWbcR1onuPBIOsE74XJw11oCchhxlm9qhFlkD2dIA1nEwd0oVtiOcTJk
 jIP49zve7Mvk+vQZs/3aSqBOXL9vm3TbbJ1jOP2PeqV17VVhywFa2rv1poMJ8pfHliN6
 LeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065641; x=1733670441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uroS2Mj44zekrjS0PU1auY8DO0I4L37WHeauiMNV8tg=;
 b=OpZnesnxDVQJ6dqD8CS7khQkN/c2YLj+QlG8BznLotJpBWWaFz2mY9hyc4qkhVvuN6
 iwNRFX4BCzT636QjxcwTkQeabJHm/sSa8RTXTO2fyN/tvL7mYAVX0Ur1AW0hoZt/NQHz
 3wseDEjEqS24ouU6AC7wfTNGOxvs21909vWEVm6r7XMMqDFtDh+ELB7XLM/HlbAUv+lK
 Pw3x64YCRe+0/j/mK6Rf4qnw+EsNtm5FgjnDtISQVAu7Xnjc5x8o4T4Ka09Y1vYKGrFf
 XByOrOVpEYRtxVCgyCGbrBINhXcPeCefwro9X4/uV11vMh9Tpr20Do2yZq4S5598xmIp
 6QoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvmyGsqvwZCnPobrJzJDC7BgaP0rtwhQW4XYzGW0VqQDu2ttQQSKXAVHKXSIz214FgZ290E3Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8HYbQKu0ItoYLU7GUAHp/YHGRTNnb1V8QxltpxXxQQP2T2Q1m
 UIp+wv4GH3Y4FyEVM9WJtMvMrqh4Nu844X7X0LedYF2UKvc9aBYw
X-Gm-Gg: ASbGncu5Pg9xzzKW3lu1MZC3rZTHmHU8e1RMTYlyEXyI0WI8PdgudFCq1eKCtGExVlb
 rBnXzb6j+ATbBptfgEU8h6RwKEUstO9V0n27cjpS2MdIAfmF3CFkp9rnK2AXZvh3ebIaSLmiN+z
 lb5R+veqcsOBb6xS2qXTKAPFVEhoVmuWPVUZqMaNVgHDPfbHiEjJXXMyMXrf3lQkCfOb+IcDoBp
 lyeOI/apwGHiOSTtCsFfi9XiwTIY7m8qhHCeCE8X2tGGTMC/8kQF9stWJRRdY4Drvg6UmLu
X-Google-Smtp-Source: AGHT+IEZyEi+LQtEzTT0NNPkN40v554GezBGv8olDw7QQCrV36x9KiZ1SAn0Vn4MLy+ZpLVtP3aGcA==
X-Received: by 2002:a05:6512:b9d:b0:53d:dc1c:60e4 with SMTP id
 2adb3069b0e04-53df00d112fmr9171770e87.21.1733065641127; 
 Sun, 01 Dec 2024 07:07:21 -0800 (PST)
Received: from wpc.. (host-93-124-60-94.dsl.sura.ru. [93.124.60.94])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53df646f1a7sm1101120e87.165.2024.12.01.07.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:07:20 -0800 (PST)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Add sdhci driver support for TH1520 SoC
Date: Sun,  1 Dec 2024 18:06:53 +0300
Message-ID: <20241201150704.44462-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Hi friends,

This patchset is a continuation of RFC
https://lore.kernel.org/u-boot/20240330175948.80931-1-bigunclemax@gmail.com/

It extends the previous version by adding sd and emmc nodes to lpi4a DT.
And enables required options in th1520_lpi4a_defconfig.

Also I did some testing of emmc on the lpi4a board and got
following results:

EMMC - 8Gb 8GTF4R (KLM8G1GETF-B041)
Sequential read\write of 1Gb with ADMA2

MB\s            READ    WRITE
------------------------------
MMC legacy      23      22
MMC_HS          23      22
MMC_HS_52       46      38
MMC_DDR_52      86      47
MMC_HS_200      176     48
MMC_HS_400      324     48
MMC_HS_400_ES   324     48

The results obtained are quite close to the values indicated
in the Samsung's datasheet*:

330MB\s - seq READ
50MB\s - seq WRITE

* Test Condition : Bus width x8, HS400, 512KB data transfer,
w/o file system overhead, measured on Samsung’s internal board.

Best regards,
Maksim

Maksim Kiselev (3):
  mmc: snps_sdhci: Add sdhci driver support for TH1520 SoC
  riscv: dts: t-head: Add sdhci and emmc nodes
  configs: th1520_lpi4a: enable mmc controller support

 arch/riscv/dts/th1520-lichee-module-4a.dtsi |  18 +
 arch/riscv/dts/th1520.dtsi                  |  34 ++
 configs/th1520_lpi4a_defconfig              |  11 +-
 drivers/mmc/Kconfig                         |  12 +
 drivers/mmc/Makefile                        |   1 +
 drivers/mmc/snps_sdhci.c                    | 494 ++++++++++++++++++++
 6 files changed, 569 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/snps_sdhci.c

-- 
2.45.2

