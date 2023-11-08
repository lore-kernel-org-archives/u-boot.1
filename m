Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F662C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B23E87527;
	Wed,  8 Nov 2023 17:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WzfQAF72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C06C87585; Wed,  8 Nov 2023 17:21:05 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1718714A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40850b244beso53242095e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699460461; x=1700065261; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8/bqZqV4x34RC6eE54nhl+JBWkePnv26L8mF/1RZGyk=;
 b=WzfQAF728XjhOZqGD938mOgi3BNpMNCCqNQNfhFV8pTMk0nTPB6fb0gW+N5YrsGa/q
 9ZmXJbgcX2wRbIuw/y42FYgpH4Sh+rkQ+2e3WCbS9HGZnwVmcAAd/GcoQ/PvkW3okFL4
 D5grFeqYFOhTf03uVU3eSDTUi1VIyU/5XZ8UQNFimzCIQAHhP/SqvUsUrij0DPsLtOXi
 Vlp+/Qw/sirh0o68WXClKTOnxYyWZ8caqCOtwODTJ1EfHtwwzHlJx2rHeXEqqQZi3fOZ
 vHiP97Xh+5kqcdsRXmFxzwriG6NGiXdnQGkvy42046nuIl0yWIBaXdyMS0pKyom37/or
 B5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699460461; x=1700065261;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/bqZqV4x34RC6eE54nhl+JBWkePnv26L8mF/1RZGyk=;
 b=hCijfF0wDs1a7cGELugHt8nK4zr6lVsWwK9zxdXwZ3oomHdI8qSfEICChVF9iqvR3E
 6QjAHeurBaYuJArCSM0l/EfT7WjdOi0oSZPZpUArsOCH/W+QbHmG1/9keChn+SjMcr2u
 aa658WXT+uwokLPIGiWkfeykbKOWvRJ9aHaCCx9shzRrnP0EPrH+hGcUTnM/bE/THhc3
 Rvwouvaht0JjJY6T0PFuKXbwy91XRr7w6iaOdzht/aCPEocI2x/2Gbilh9TOjO21dur/
 aiZXeol9Ep+b/cJen40qFDkXb/34M9ylgF4H+oeBujtsQY28FoksHDIxm3DddNM1+Lcj
 1aRA==
X-Gm-Message-State: AOJu0YwDRUhTfYa1xxYUoEG0OHPiiyQjwLc4r2Gi6fiW1sVLqsdvx3Rm
 NxwoPGJaDMHTsJ+RiqfkH0Kh5A==
X-Google-Smtp-Source: AGHT+IGhS9nyTWEknJYjqGCbLxgV/UyZQXTcacvC1kfNiEaGfA7tPDNLKXYzLSeJ46gpDEBJFNi++w==
X-Received: by 2002:adf:ebcc:0:b0:317:6513:da7e with SMTP id
 v12-20020adfebcc000000b003176513da7emr1772048wrn.36.1699460461341; 
 Wed, 08 Nov 2023 08:21:01 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6607000000b0032db1d741a6sm5273660wru.99.2023.11.08.08.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:21:00 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/5] Qualcomm PMIC fixes
Date: Wed, 08 Nov 2023 16:20:52 +0000
Message-Id: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGS1S2UC/32NSwrCMBRFt1Le2Cf5YcSR+5AO8mv7QJM2KUUp2
 buxC3B0ORfuuTuUkCkUuHU75LBRoRQbiFMHbjJxDEi+MQgmJOfsglbh4tIL/YotZrNiMFJrxvz
 ghYS2m3MY6H04H33jicqa8ue42Piv/WfbODJkzlmrr4oLxe9Piianc8oj9LXWL0130m6zAAAA
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=+AjIVC9nRLjI7HevEyDN9D6THrlMaOwLoKgOcoQepA0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTvrdkXfRLe1C+8XxWm98frdsivzqA07wqFg2/r8gpij
 9w7VZbXUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZS18XwTzHgzHemNp7vdx/a
 u/rsY17oeLC0ROEVa/FL5evJwpOePmT4p8vWHiBsrz/FoZu/ItdGhPHo7ckzw540MLL5V4S9cde
 WBQA=
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

This series addresses some long-standing issues with the SPMI arb
driver, the PMIC, and the PMIC GPIO. It fixes compatibility with
upstream Linux devicetrees, and simplifies pwrkey/resin support by
rewriting the pon driver to be a button driver rather than a GPIO
driver.

Existing users are adjusted to use the new button driver in their
oard init code.

This series is based on the pinctrl [1] and clock [2] cleanup series.
There may be some DTS conflicts applying it standalone.

[1]: https://lore.kernel.org/u-boot/20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org/
[2]: https://lore.kernel.org/u-boot/20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org/

---
Changes in v2:
* Avoid using non-standard "label" and "linux,code" properties for
  buttons
* Add missing sdm845 DTS parts
* Put button driver in drivers/button
* Link to v1: https://lore.kernel.org/r/20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org

---
Caleb Connolly (5):
      gpio: qcom_pmic: fix silent dev_read_addr downcast
      gpio: qcom_pmic: rework pwrkey driver into a button driver
      gpio: qcom_pmic: fix support for upstream DT
      spmi: msm: fix register range names
      pmic: qcom: dont use dev_read_addr to get USID

 MAINTAINERS                                      |   1 +
 arch/arm/dts/dragonboard410c-uboot.dtsi          |  14 +-
 arch/arm/dts/dragonboard410c.dts                 |  22 ++-
 arch/arm/dts/dragonboard820c-uboot.dtsi          |  15 +--
 arch/arm/dts/dragonboard820c.dts                 |  23 +++-
 arch/arm/dts/dragonboard845c-uboot.dtsi          |  11 --
 arch/arm/dts/dragonboard845c.dts                 |   4 +
 arch/arm/dts/sdm845.dtsi                         |  25 +++-
 arch/arm/dts/starqltechn.dts                     |  20 +--
 arch/arm/mach-snapdragon/Kconfig                 |   3 +
 arch/arm/mach-snapdragon/init_sdm845.c           |  45 ++-----
 board/qualcomm/dragonboard410c/dragonboard410c.c |  31 ++---
 board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
 drivers/button/Kconfig                           |   9 ++
 drivers/button/Makefile                          |   1 +
 drivers/button/button-qcom-pmic.c                | 165 +++++++++++++++++++++++
 drivers/gpio/Kconfig                             |   3 +-
 drivers/gpio/qcom_pmic_gpio.c                    | 134 +++++-------------
 drivers/power/pmic/pmic_qcom.c                   |  13 +-
 drivers/spmi/spmi-msm.c                          |  46 +++----
 20 files changed, 335 insertions(+), 279 deletions(-)
---
base-commit: d1efa48e205960b15656eb0c13227110895f1cc9

// Caleb (they/them)

