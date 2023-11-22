Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A1DC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 19:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F349A86FE8;
	Wed, 22 Nov 2023 20:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="kXLC2JVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F8E87616; Wed, 22 Nov 2023 20:25:20 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC7B86FBE
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 20:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so68912e87.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 11:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1700681117; x=1701285917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iCg3vgYgTpgRJOgbvVuspMmxU9xW5pGaPjsw3f5J61o=;
 b=kXLC2JVsct/Viq37wyuV+gIW2HVw2K+44Gw54esu3ORjNVXX9GNS6M6QOe41JdV+oG
 jRINEDY+0TPXYUBYaBjbxXTfItd4+9kMpZi8jXRWSqCYbg7jvkun/cyPRnoYthEplD9L
 2iWOndZX4EIs5R4Bn7qT9XOWd53UqyqFGOi/zJSW2HNfTIPALiFY1sWRMgnsHs7xFk0P
 yPoLiMzLEcQ1FkjbG92DAJDsrIN48LhUW/oSRV4OGJzp6V8TUrHr//E5eUWyHTEoZu90
 js+PqTmKHtad7GpP6h+uPzXLfepH3Ak9OlM6IdDyhIr9aA/7zzIaUSy/2yl3KRuBI1Ck
 wWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700681117; x=1701285917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iCg3vgYgTpgRJOgbvVuspMmxU9xW5pGaPjsw3f5J61o=;
 b=BqXflbHiRjovQmKGLeuKr5ZaY6J0DCVWdrrYJ1VqQsshPySmIjRM0z9HF2KF8aFFVB
 kITolQTZwhIwpLcXO1SuWKQ0il9XKSSFyImoOI9wdgLSfm8aNagKluvZcMj0E8Fwlo/A
 wZjb0edlxipThkvM3c3xQ0snsnD5WQgQqlNuhL9+iL7EzkTPbByZJsD/UYTd/2sxSyGf
 nzeGvR7BMAbUK7bxsPzJ2LIbOrabzEXoMsDs2/FSX/b6s0sqj5A3MzchZihEC8Or6QoK
 JhHnl2uLU+D+kndNuMbie31Tc2tatdURXWqaWwwt9cbgeT7TSThmP/QBmUXbu6obUa2U
 ztsA==
X-Gm-Message-State: AOJu0Ywvl3yi5LhOuSACA15sFCTT5HG9AgC1gUj6jgiV0fUOzwjPgxbL
 V00R2m4GChyVVX9M8mWQTK/hjw==
X-Google-Smtp-Source: AGHT+IFe3t4rMaAJfOcxZ/Y7UVFeh2F/PzcfQL+ZvJHGQXgqhwzLKmEMS2YdxpYEZzt8VLJ3BlUxDw==
X-Received: by 2002:ac2:4906:0:b0:509:11fa:a208 with SMTP id
 n6-20020ac24906000000b0050911faa208mr2576728lfi.43.1700681117071; 
 Wed, 22 Nov 2023 11:25:17 -0800 (PST)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 d32-20020a0565123d2000b0050aaa675555sm1355790lfv.255.2023.11.22.11.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 11:25:16 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Tom Rini <trini@konsulko.com>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v2 0/2] Conclusive WHLE-LS1046A support
Date: Wed, 22 Nov 2023 20:24:51 +0100
Message-ID: <20231122192453.1479031-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.1
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

Hi all,

this is v2 of the Conclusive WHLE-LS1046A support series.

Patch [1/2] remains unchanged.

Patch [2/2] features a major clean-up to configs/whle_ls1046a.h,
dropping unneeded/redundant defines, and moving some others to more
appropriate locations in board code. The environment settings have been
moved to plain text whle-ls1046a.env file, and distro_bootcmd macros
dropped in favor of BOOTSTD. A non-DM_ETH case has also been removed.

In Device Tree bindings, i2c-mux node has been relocated to the correct
parent and ext_i2c received an address correction.

Minor style clean-ups have been performed to eth.c and an incorrect
value of CONFIG_MTDPARTS_DEFAULT removed from defconfigs.

Artur Rojek (1):
  board: Add support for Conclusive WHLE-LS1046A

Jakub Klama (1):
  armv8: layerscape: Enable ext4 environment storage

 arch/arm/Kconfig                              |  19 ++
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |   5 +
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/fsl-ls1046a-whle.dts             | 208 +++++++++++++++++
 board/conclusive/whle-ls1046a/Kconfig         |  15 ++
 board/conclusive/whle-ls1046a/MAINTAINERS     |   9 +
 board/conclusive/whle-ls1046a/Makefile        |   7 +
 board/conclusive/whle-ls1046a/ddr.c           |  21 ++
 board/conclusive/whle-ls1046a/eth.c           |  65 ++++++
 board/conclusive/whle-ls1046a/whle-ls1046a.c  | 215 ++++++++++++++++++
 .../conclusive/whle-ls1046a/whle-ls1046a.env  |  13 ++
 configs/whle_ls1046a_emmc_defconfig           |  83 +++++++
 configs/whle_ls1046a_qspi_defconfig           |  84 +++++++
 include/configs/whle_ls1046a.h                |  47 ++++
 14 files changed, 792 insertions(+)
 create mode 100644 arch/arm/dts/fsl-ls1046a-whle.dts
 create mode 100644 board/conclusive/whle-ls1046a/Kconfig
 create mode 100644 board/conclusive/whle-ls1046a/MAINTAINERS
 create mode 100644 board/conclusive/whle-ls1046a/Makefile
 create mode 100644 board/conclusive/whle-ls1046a/ddr.c
 create mode 100644 board/conclusive/whle-ls1046a/eth.c
 create mode 100644 board/conclusive/whle-ls1046a/whle-ls1046a.c
 create mode 100644 board/conclusive/whle-ls1046a/whle-ls1046a.env
 create mode 100644 configs/whle_ls1046a_emmc_defconfig
 create mode 100644 configs/whle_ls1046a_qspi_defconfig
 create mode 100644 include/configs/whle_ls1046a.h

-- 
2.42.1

