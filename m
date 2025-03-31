Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4525BC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C402819D2;
	Mon, 31 Mar 2025 14:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JPvkUZJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C903819D2; Mon, 31 Mar 2025 14:23:46 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29B88129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43948021a45so44626445e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743423823; x=1744028623; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uIuF8blQiFIaDkp9qeqia6EZdXlFUmsrMZ/sqynZfQQ=;
 b=JPvkUZJyTTlZwCTiWUGBeBy03y1toeQ0IgsO0etYJOW3HUbbgur1wzNvZNmjknaAuw
 TR9+2TuL/UDD19Z+jLr5ZTYx8m1cZCJwyYHzCC9IVO77lOOw2q1P4+/UJEXymiGq+8X2
 ZGzHkyDja4cjQ9RDT3sKuj6QNr0PRyyEtL7JcC2JAnHbjc2o4xmIs2/VZ7m2PohzO2pk
 iuJNHrJBPokeeA1F/iCPU5JnBMYwYVw6VaiuiIhu0OJUh9UsMebrDTyzQVn6lT1rOFZX
 u7LUL9To62uIgruD3AKrAjSAwl2+a5aBLyg/9zEBMBz1IgFnFQqoT59WifTGg3ek6yf3
 g9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743423823; x=1744028623;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uIuF8blQiFIaDkp9qeqia6EZdXlFUmsrMZ/sqynZfQQ=;
 b=tDG8Jd5rqfDFIT2qYEDKoj0YzdzD9AaCkWD5MYQIpiOvuxUl3EVkRAUXkr3Zx6O82v
 3rkNaUjn5BxIDYAHZCYxR8sLLOeuOkOGPZDvdpN/YDTbS7ShXLt6eRpPT/8cVvLSxK+Q
 fZII5+8tYPBj+DUVNNYVbynYcilb6eVpe6fhmmmRupmjnYvralmyMwlKL6Y768WmZwsS
 GVw5PEyipSp572Yi/QdnKvBLgE+kUXtstTooIVibIWEjzk2BPitfZNBdw1VpL2n/cwIL
 AZUZ/Wps/l8KCLbIad//4H813uQnhfaId45TvtweHJtqou6/D5pvdgaE/bxYBR6T3OhK
 hr6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlXL7uHYnLF41Gc6p9qaCqsxvIgBCUEjVSD2S0tFqf+hGceiMsh28elSj1jE0fPJ/h4XZwCjs=@lists.denx.de
X-Gm-Message-State: AOJu0YyWDSj8OD8KKMtyeqEJ/kZB56cVbKT/j0lPIZ/o4p+H7qJ/wdj1
 8GI7lbr0DFKThi93KLVcLeq+yvfEle0W9as7Z3tCR0NamvcD0CZ5N2mR7c3ynXg=
X-Gm-Gg: ASbGncuhhAtmtIuJt2UBr/Wr9DuvM3Wy4pfIO5w/jHEVbhLsbnjB6HwFhEbDLnpTU6x
 k5cmh+/zNCXayVrJTth9IQqXluQAqRWJd34+TuMJ0BCeUIvDzkgU+ExtxG8JI+L7iHXgSpSB4sC
 PxUhTOOV9dVoVkZK1JTJG5nojyA+Mu9Zg/bix/L7aLoDkfH2QQc3ZEhwtns4mczWGtTWXuJtIXI
 H9WRnUq3wag4MOyk1wWYp46cju7COeXQvUtU4teeSzpdyy1yEdGP/xT2P0oljKVmww87xxuUxy1
 VFy4S6kTwxXqTdF5jwXuyRhBcqMh65xcz25R8V+bhb7rhuY4+qa6qtCgHMdiHTc0sTenEJPGfOa
 uLroTc2okP7ny
X-Google-Smtp-Source: AGHT+IF9h+TRdq+0BuOjRUUukYGYcyFQw4cOmUylbErHZbDbVu52NTMgzioUvd89boXyvTlrOq/NIg==
X-Received: by 2002:a05:600c:190b:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-43db61d8305mr76209435e9.1.1743423823181; 
 Mon, 31 Mar 2025 05:23:43 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm11315562f8f.0.2025.03.31.05.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:23:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 0/6] Better smartphone support (Qualcomm)
Date: Mon, 31 Mar 2025 14:23:17 +0200
Message-Id: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWJ6mcC/23MSwrCMBSF4a3IHRvJq+3VkfsQByG5tgFNaiJBK
 d27acGB4vAc+P4JMiVPGQ6bCRIVn30MdejtBuxgQk/Mu7pBcqk5KsHuNt7YOMRAmdkO905oR23
 TQRVjoot/rrXTue7B50dMrzVexPL+7xTBOOPYCk3OIanmePXBpLiLqYclVOQHN1yJHywrRuWsQ
 zStwe4Lz/P8Bk+9/7nkAAAA
X-Change-ID: 20240831-qcom-phones-c789d14de657
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Danila Tikhonov <danila@jiaxyga.com>, 
 Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3481;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=4O1nRZO6S1Fi8oCGW/R4shlT6lQPXVnLmhINtGBr2Lo=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn6olMVS/Unh6+Tc/HMH/ucS9qGyNAX44Hh/mYk
 d6jWdUTk4mJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+qJTAAKCRAFgzErGV9k
 tgPJEACCSigTif7JHpA7LUbW0/E9H7DTT0ThsmR86o4KyG1su3LFze9D3J48bEcveG7IBw1kBRq
 ECyLhfa6yu3p9sDO6b0GApOtEXp0O/CKJ5tocJQqdZBbrVdodo85o9cQmjWYyXxa2/Ww52v/py0
 QwUanBNJ9aRDHFQSIQedAzMBGzElWVhvDRrGOqOXFhtdMX/pBR+C73u0CK134xOQ7eVK+By01g5
 CwHGGFMsfzpDB9hQ10FgUCKvQslW9ibwxEWYQK6D6VARXpMOhdJUB+Gj+Wy0djBL/WgJXX7YYfE
 lT4D72ZftQXlqWXXu47uirQ4zLuRZt6lQurQh3MQMc+A4tTw4a+6dGq8QSYDPerpzBTj1khnVDl
 nLXjA7H2XAvFLX00ohbYnI7waUD/JZ7czb12TzJC+tCYP1VdMl7TNXuSCTymdDURPWbfVK7wxCQ
 dnnnxIewGk7pfd6vWcX4sWnerSTavLuP1wr4RnY00Zh8lOi0kO52ftw6OJ7jYLl3QZ+5Y00+1nT
 D0QYZ43fghg86bAYhiFzO0Ad1bmSeamN6wGP1SrivlG/mOjCeQdEBdRWydabc7aaO0p3TT9fp7d
 Mou7EX4j8ulprYwrcuv899Na+XbQbilkH/3RBQ+YYjT47VWwX+OyQUQkV/RMpzba7XpMB6IllIZ
 Pyb+3RIT0MZf98g==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Improve support for running U-Boot on [Qualcomm] smartphones, with:

* A boot menu which can be entered by holding volume down during boot
* Hang on panic (so errors can be read on the display)
* Serial gadget which can be enabled by holding volume down or via
  boot menu

In its current form, U-Boot's boot menu is perfectly adequate, however
once an option is picked U-Boot will never return to the menu, always to
the CLI.

On a phone (with no keyboard), dropping to the CLI effectively makes the
device unusable until manually rebooted, since there is no way to run
any commands...

To rectify this, let's revive CONFIG_BOOT_RETRY for the hush parser and
add an option CONFIG_RETRY_BOOTCMD to run the contents of "bootcmd".
This provides for a flexible menu system which we can enter and exit.
See qcom-phone.env in patch 1 for more details.

Finally, provide some rough-ish documentation to describe how Qualcomm
phone support works and outline some debugging steps for when UART and
the framebuffer are unavailable.

---
Changes in v4
- Enable console recording and "fastboot oem console" support
- Clean up boot menu
- Simplify button_cmds usage, and use Volume Down instead of power
- Make button_get_by_label() case insensitive
- Use better button labels in the qcom-pmic button driver
- Enable the MMC fastboot backend by default since it can be used on
  older devices, or those with an sdcard slot.
- Document fastboot mode and log retrieval
- Link to v3: https://lore.kernel.org/u-boot/20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org
[v3 was accidentally sent as "v2" a second time]

Changes in v3:
- Minor wording/clarification improvements in docs
- Introduce CONFIG_RETRY_BOOTCMD rather than changing the default
  behaviour.
- Enable some more gadgets in the phone config fragment.
- Link to v2: https://lore.kernel.org/u-boot/20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org

Changes in v2:
- Fix CONFIG_BUTTON_REMAP_PHONE_KEYS name in qcom-phone.config
- Add Tom and Simon to CC
- Link to v1: https://lore.kernel.org/r/20240831-qcom-phones-v1-0-08614edd8e35@linaro.org

---
Caleb Connolly (6):
      board/qualcomm: introduce phone config
      cli_hush: support running bootcmd on boot retry
      bootretry: check for bootretry variable changes
      doc: board/qualcomm: describe phone support and bringup
      button: qcom-pmic: prettify and standardise button labels
      button: make button_get_by_label() case insensitive

 board/qualcomm/dragonboard410c/dragonboard410c.c |   2 +-
 board/qualcomm/dragonboard820c/dragonboard820c.c |   2 +-
 board/qualcomm/qcom-phone.config                 |  29 +++++
 board/qualcomm/qcom-phone.env                    |  47 ++++++++
 boot/Kconfig                                     |   7 ++
 boot/bootretry.c                                 |   2 +
 common/cli_hush.c                                |   6 +-
 common/cli_hush_upstream.c                       |   6 +-
 doc/board/qualcomm/board.rst                     |   5 +
 doc/board/qualcomm/index.rst                     |   1 +
 doc/board/qualcomm/phones.rst                    | 144 +++++++++++++++++++++++
 drivers/button/button-qcom-pmic.c                |   8 +-
 drivers/button/button-uclass.c                   |   2 +-
 13 files changed, 250 insertions(+), 11 deletions(-)
---
base-commit: 96f6ab64e1bc897d26649d15365f6d9970ccb1c0

Caleb Connolly <caleb.connolly@linaro.org>

