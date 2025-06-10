Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E43C677C4
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7675D82B95;
	Tue, 10 Jun 2025 18:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X9ug944V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFE882B7C; Tue, 10 Jun 2025 18:51:14 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C0A82B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so13937f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749574272; x=1750179072; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R07d3BWYU7QKCmGhkuDopSe+ODwFOPbvdO4IDOpcEek=;
 b=X9ug944VXUdSxC4BTJxW4chD1XDbPNWVArCXlimJAxk3hwQdlJa6T73T/h+JHIv4jR
 4O2FY0cQVkOjvw2fBhdxjo28yA2aju5/3eS4tcdUa+k+H23yeTfGaqq0fHbSEs8ARLti
 WMZh7BCvg5HpS6FNmPXWiWwmoU02snblO9T4qKISAjge9fs+9JBqgGvjY+paBfEsnzhY
 HwavWqcJy3yKKgcU1QGuBpeJWwLN+t9vpodt/UGic7K3yuzvWUo/49/6V3TtzCFDHd/q
 xVqCpRpfrV/AmT9yrKNWXZX+5frVI7mXcCfe0hSJ+o7dfPNvEpzrOdl1WJP4ew7yjvkv
 yH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749574272; x=1750179072;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R07d3BWYU7QKCmGhkuDopSe+ODwFOPbvdO4IDOpcEek=;
 b=iQ9gB0lwGtnUJiEjgPWv50FKNgs0Jal2aq1emS6QODPODqX5/960Fgw6ZCI7BsCuHy
 NzTnWkkTleyc0LLMKv8GWrdiCv6IwAJwReN24dSRavOHepM0ARw6QZn2okxuNH1CP1ly
 8kvER/puC1neJtJXuzy//lnN/Qth0VX3L/MsKw7FWGG5BjOhVqi2IWiuK4hyyevnt6g0
 aPI+boUMKeAPvmsJLiY9whMnKmNh7t/qWk62fZXW9URlhL7d3rWYPLuYA1UCDIwyr4H8
 j6Ned3vmQtQu580yLaUnCLX8WLagVRiXkM9dqoQo9GXQ95TyMT+emTxxwtuWnqd6mi1w
 rhXw==
X-Gm-Message-State: AOJu0YyKFAYOH0hYgSeETAk58QC3lQRWFQPP66VuDFo/+4qmU6kP//kY
 VWHtK/0cs20asK68JZStVS9PKPLz+vT9alRTHIv8Y7E/g9atveYrYwmJB+heTMtOgL8=
X-Gm-Gg: ASbGnctuAkCZXiVT3rynzDhs5ICB+1z3Z5/MrpczStyK1iQBfgijx6+dalJ5W62rmlp
 kdLl1FOwKCFAHFYqb3YObJiIuKL4buxp0VceWJBPWZEgnPQ4zeW7RnZ7VdcQhAjf223UCGDLTel
 qVvN6pe2q1XLkenuLaOyxgSzu/7jZ92uTa5a7h+yvuEo7pTU1/lldGc+YzAq5Ay+Dwlnjx+JU8+
 NV59nlHUTh1bS/N6Lz+HvfblY01tw42e3k5CsK7SMXS3qGGCu/uu2FEDtVzcAFHvMOlkdxUbqvX
 v5aU7r5Qb3MGH9BGKRaq0bmB1CzHF9JEfu4307apHWQw7T+HX6N8k6VXxwUuUAQfPukT+P7B
X-Google-Smtp-Source: AGHT+IEeOS4L9BmyQAG3mOVgRSkrT8/6C84yI1NTsIyBylC3YhxvYOl7Y3E7JoBaJ4++zaJsRrbgoQ==
X-Received: by 2002:a5d:64e3:0:b0:3a5:25e2:6129 with SMTP id
 ffacd0b85a97d-3a55825a00amr84806f8f.21.1749574271790; 
 Tue, 10 Jun 2025 09:51:11 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452669ada25sm148665345e9.0.2025.06.10.09.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:51:11 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v2 0/3] Qualcomm: implement support for GENI firmware loading
Date: Tue, 10 Jun 2025 18:50:49 +0200
Message-Id: <20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGliSGgC/22PQW7DIBBFr2LNuhMBBplYUdR7VFkQGBxU26Tgu
 q0i372ESFEXXf7R/Pf0b5ApBcrQNzdItIYc4lyCeGnAXsw8EAZXMggmFGu5xIHmgGM0Dv0XMrJ
 GtsJLvbdQKtdEPnxX3NvpkRN9fBbq8jjCRDmbSu2bwxOabSc0wykmQjtG+55x5ciQjFNS6s62m
 l7HMJsUdzENx7vrbHJ5jtMUlr7Za6ZawZ13dIa7+RLyEtNP3bXyqv5/QvUo3XmhvNBc+D8eOG3
 b9gtR3KjyIwEAAA==
X-Change-ID: 20250314-geni-load-fw-0eca432f489c
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Gqll1A2cF+4+8EE/gxOWeIDvQhPjWL+CBzIAcoLztIU=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSGJ+nxmpYoP5wdTMxMdqGgXgXeZxvbfvoqw8m
 fl8TC0c00SJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaEhifgAKCRAFgzErGV9k
 toK7D/99MqoHgtCGrjDZ8wIZ5YYHnD5PuesJGiSRpaGeiEqen3ACbzLqRGm/D9TOI3E/dvfbOW/
 j+NHtbuHYo+d6+bdNTfViRtCVb8DUqX8A9ljsnq0vUaXWP7tBKUX08uqCA9jVwGxk/YZ/qs6Rxz
 +xFTOl1/VIw+TK2WoN3nVMkw5OEy+sbCFv43vd+JuSVrDNVvaQSVdAJPCkMHgVcHM8VhRxy6568
 kXGgcQGMU2i/3nEjr1ENNhvxAeaaCOu4FEAWvYGxOWYm34Ga55q0TZESL/7EIeyeTWc0G7JtH3Y
 H8JJlX/akBTgcczyY3YDNMsKApGytkCLyl7FoeaGS3dGAXnCIh974AGZLZizYc4EJiANBtD4Ebm
 zc9o96UbLQdk9NoDd/vM3PgKx6Btna+/67j4dIK4SNu4ghSSJx63cGuywQ20/jQ92jJQL2xLGgR
 iHVurfT1mRxQblWDKHPfSep3oct6w/4KFEebZD4+ObllvCt/aUT7a47rIQuWyViOlEKP+zKvhRp
 z3O3le4JuZ/vmHKK/MdPStVnPR0YETl7YyEaFVBO4kvbXyljjKS51BKU6jzUOTF/1jOOpZ+zM7E
 rgVQVKynejXT5F//NjVAJ5/ituslOAGABEUvo0m++46ZPO2uzTkmLHbdkRwnV+AL0h71KMZonR+
 dOxHbXDh7BMQG1Q==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

The GENI block on Qualcomm platforms contains many Serial Engines (SEs),
these are general purpose hardware blocks capable of implementing any
low speed protocol (UART, SPI, I2C, etc).

The protocol implementation is provided in the form of firmware which is
programmed in to the peripheral, typically by the EDK2 bootloader. Up
until now we have primarily been chainloading U-Boot, and therefore
haven't had to deal with this problem.

However, when running U-Boot as the primary bootloader it is necessary
to handle loading and writing the firmware.

Support for doing this in Linux is also in progress [1], this series is
largely based on that one, however the Linux patches expect the firmware
to be provided in /lib/firmware, and will only exist on newer kernels.

Since we may want to use peripheral (e.g. EEPROM) inside U-Boot it is
still useful to implement firmware loading in U-Boot.

The approach taken here is to bind all peripheral devices which don't
need firmware loading (e.g. the serial port), then wait until
EVT_LAST_STAGE_INIT to handle loading the firmware from storage and
probing the remaining peripherals. We forcefully probe them so that they
will trigger firmware loading and will be available to Linux.

For testing on the RB3 Gen 2 [2] is needed so that the i2c peripherals
can be probed.

[1]: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-1-quic_vdadhani@quicinc.com/
[2]: https://lore.kernel.org/u-boot/20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org/

---
Changes in v2:
- Use GENI_SE_INVALID_PROTO in geni_i2c instead of 0xff
- Fix typo
- Link to v1: https://lore.kernel.org/r/20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org

---
Casey Connolly (3):
      i2c: geni: fix error message wording in clk_disable
      misc: introduce Qcom GENI wrapper
      i2c: geni: load firmware if required

 arch/arm/Kconfig                 |   1 +
 drivers/i2c/geni_i2c.c           |  14 +-
 drivers/misc/Kconfig             |   9 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/qcom_geni.c         | 576 +++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_msm_geni.c |  13 -
 include/soc/qcom/geni-se.h       |  36 +++
 include/soc/qcom/qup-fw-load.h   | 178 ++++++++++++
 8 files changed, 811 insertions(+), 17 deletions(-)
---
base-commit: 9805321dfdeb5225fe5c5e0721abf49c0875637e
change-id: 20250314-geni-load-fw-0eca432f489c

Casey Connolly <casey.connolly@linaro.org>

