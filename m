Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E215FC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37B1787957;
	Tue, 16 Jan 2024 18:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LaTrAj1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B1286F67; Tue, 16 Jan 2024 18:14:07 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2FF8799C
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78313f4d149so1055092585a.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705425244; x=1706030044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2D+BvdmU2DjcrLZOdBtVVBvcDv0qgTvV6MhTm95zxlo=;
 b=LaTrAj1QhHE5ySlap3Ziv81KV4JCG6yiS1oJIa0j63ACMTFnmVciaDFbba8hO/A5wA
 2PBLrpN8Ljec5G8oIiPh9cI/pybWjcNRGcz/SetrU2hZJQhjPJTwWVVt+5s74YvSW2V2
 gsbz9Dnv4ZICowqxnTt/7X0xB+w9GVXWSLSc7lAbtyP8fUqO1dM1iGI/9RZggfSYRJqK
 OBYdBOHBbhXST+fpYEq/KWXjykX8EFlHurSTZGdYr4RuqwE6Q7/e4shIbRj+PZhKLSIF
 qqAJjGJ+W0Gs06i6XHsBm46MuGxTV2auqTRtVX+zIx6TTDKDJt0RBXCBkvXwT6j894W/
 ffag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425244; x=1706030044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2D+BvdmU2DjcrLZOdBtVVBvcDv0qgTvV6MhTm95zxlo=;
 b=pdqyD+60OQdyOCz0TybI6KQ6VKUj48ZDT7ywvRh132vQP1JC/eJyDEmF8P4wCwNNyI
 W3s8yYlrCorYQGHnNgOBF3QvGGNg13sbs+D2TxuOn/WcKVuMjV1lSKHgAQHtJXEJRQI2
 ia8EfPz6RqY1wvYrPQMQPpKTXL2kLqIB8qFT+Kofr+u/trvC4ALlNpctDGSktznb8fcz
 XPUOVqQF4iVjVwUrs0F3DT0oENZBoS6S79a/yik5wE47vXakyRa0775hs3dZfA1aJUMk
 pgdcBQjlkAkoiJEa1eGHzE55jvJNAisu7X6glZesZtaB4skGadOBpawnSt0C44pOBrpm
 uYcw==
X-Gm-Message-State: AOJu0YzSTp29Lo2xO8MfHISlXEjOOYcQfpP4S8RvOBxXd8jm0lCjO0/m
 3w2FwAHR/RP5mxEQHO4WrFSUHuVRXsbgRHmCFBvHxnc3/nQ=
X-Google-Smtp-Source: AGHT+IFiqHigpC/de6AOTxJvtLFn2ChfzyReFgz+JbSDicui5cSJhcn9Zlhq7N8X9SmvUiGtTv4/bg==
X-Received: by 2002:a05:620a:1116:b0:783:4590:d2d9 with SMTP id
 o22-20020a05620a111600b007834590d2d9mr8833576qkk.45.1705425243809; 
 Tue, 16 Jan 2024 09:14:03 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 bp43-20020a05622a1bab00b00427e0e9c22dsm4988291qtb.54.2024.01.16.09.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:14:03 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andrew Davis <afd@ti.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v6 0/7] Handoff bloblist from previous boot stage
Date: Tue, 16 Jan 2024 09:13:45 -0800
Message-Id: <20240116171356.376801-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch set adds/adapts a few bloblist APIs and implements Arm arch
custom function to retrieve the bloblist (aka. Transfer List) from
previous loader via boot arguments when BLOBLIST option is enabled and
all boot arguments are compliant to the register conventions defined
in the Firmware Handoff spec v0.9.

If an arch wishes to have different behaviors for loading bloblist
from the previous boot stage, it is required to implement the custom
function xferlist_from_boot_arg().

V5:
Drop [PATCH v4 8/9] fdt: update the document and Kconfig description.
V6:
Drop [PATCH v5 8/8] fdt: get FDT from bloblist.

Raymond Mao (7):
  bloblist: add API to check the register conventions
  bloblist: check bloblist with specified buffer size
  bloblist: refactor of bloblist_reloc()
  arm: armv7: save boot arguments
  arm: armv8: save boot arguments
  arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader

 arch/arm/Kconfig             |  1 -
 arch/arm/cpu/armv7/start.S   | 19 ++++++++
 arch/arm/cpu/armv8/start.S   | 14 ++++++
 arch/arm/lib/Makefile        |  2 +
 arch/arm/lib/xferlist.c      | 27 ++++++++++++
 arch/arm/lib/xferlist.h      | 19 ++++++++
 common/bloblist.c            | 85 +++++++++++++++++++++++++++---------
 common/board_f.c             |  9 ++--
 configs/qemu_arm64_defconfig |  3 ++
 include/bloblist.h           | 47 ++++++++++++++++----
 test/bloblist.c              |  8 ++--
 11 files changed, 193 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/lib/xferlist.c
 create mode 100644 arch/arm/lib/xferlist.h

-- 
2.25.1

