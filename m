Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B70C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D07987EDC;
	Mon, 27 May 2024 19:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LnxaNIQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDEA87E95; Mon, 27 May 2024 19:12:15 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D8487EAC
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-a5a89787ea4so203666b.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716829932; x=1717434732; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0vWOToQ3PY7hFx85VEcjRfuvo3nn42VmReOLcS+TMbo=;
 b=LnxaNIQCS09HefBjj4RuFG0tIK1zjc50kAhSHuqKnVoe1/YFpuSa3tz9UXnOZEwJuD
 HQfkzctYFHS7HJZMfmONs47xA8y69AtyGANiXscNY41BHBC41k92rk3+gewe1HSqHaKC
 yKWxHTZDky4tz2rDLn0yYau+IE7my8ReJenYPII/YubtidOAS9bawUTZbEnp0eUjub6d
 VukzQwumZ6/L/vrT2OXrWRh0TSm3bOSphv1NqgIfuYzkMp7c216ylRO/NxHviKKZ73jv
 Q42pSX7KlITxjAwGIo/MqsizsEyfhI0mrFkLkJlGnZmS40q/WqRexlUe+7nKdLBoinCs
 5ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829932; x=1717434732;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0vWOToQ3PY7hFx85VEcjRfuvo3nn42VmReOLcS+TMbo=;
 b=NGZkr4xKBGtfOqtMI7iOtnT7qRUMlLREf+Ua2jQsr7yILzfSBlTANKNTpoVx1drU+I
 SFx7HdCGVDX9Ix5Pj42epPXSGQROgxOiosKlKXJtl899+R6tQRx45Kk5ZwbVwNCewCOC
 9KBA6DTewKInufE+3ba4FEXLMegiAG5oEqLKwsLLowHNk9kivqq+bwCqN5EfX/LlBkdY
 0DsblW1CQKhpxgHaZf54/ls9T7/V+nOlL6bXAX9NgdRajCMq1ykAOwIM1bmm9H9CvRgU
 Ouu5uJH04l3IXLHAxGUsAIn8OMd6lhY/cqJPZ33d5T+8eBH27o6YQu84J6BXH4DCbDVZ
 wIew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDWhIYt7fZOdRmrjKIU0dNa5i2xGF4duPZ992smiv8jDE4+dNvRLD2IvmQXb6XG3J31Gqh1PN8usvzHT8r7cVtMKdldA==
X-Gm-Message-State: AOJu0YxnzctfUv+mkALMb1TobjRYrNywqJ7BV2hwymw8Q85XPREUGFMG
 Mr/C5j1bcrjb97nQ5Wvp/lUKPVQT8kAZb+yQN6ZXcUQSSo7HNi4yqdQNVhbB6GSD22I1E55jlF9
 an32cJPsU
X-Google-Smtp-Source: AGHT+IFxub5om4hx33xDo11NlylBOSkiSeNbXJZjx0wZFiv7NolC05qoTfjbWrYt3zSFfwr8z45WPg==
X-Received: by 2002:a17:906:6b1b:b0:a59:ee81:fd68 with SMTP id
 a640c23a62f3a-a626525cd08mr677526166b.71.1716829932533; 
 Mon, 27 May 2024 10:12:12 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda7cd3sm508009566b.216.2024.05.27.10.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:12:12 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/2] clk: add a stub clock driver
Date: Mon, 27 May 2024 19:12:06 +0200
Message-Id: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOa+VGYC/yXMQQ6CMBCF4auQWTumrUCtK+9hWFBaYCKhZoqNh
 nB3Cy7/l7xvheiZfIRbsQL7RJHCnEOdCujGdh48kssNSqhSVEqjLbGbnhiXt0VTm6s2uq0r30N
 +vNj39Dm0R5N7pLgE/h54kvv6d0opducwHFPyHDFJFFibS2Wd6oR28j7R3HI4Bx6g2bbtB+WGR
 TWrAAAA
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=tzr/btFjsjlWTHNl1T4eSbHqICTGwKx6Y56lIRXnMEw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVL7rf61idFu3FRgRECRgvVAi3M3ilEMn1eCsC
 vIyEWDf2TmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlS+6wAKCRAFgzErGV9k
 tp/eD/45C8d+ZzSFQx7Y1gfnrNbDh5rzVvv5+bjK0ydbbiQegA6+OP7lIHYWnt+I/AhKmBGEZvW
 JATpzeOHCSeKs9h+wJzrvi01aNLCzsUgrCDEDQgarzMfcMGNXhEwfI7UYHGhjCB9QgRdeJdUcK7
 tu4ts8zKQq05lxnvKqhAUg76P2eJu/B5UyD3MlxghVKRe49CUBHaXNpgLoj3pBtnoMpeRKPsOog
 WMzRN3QRalwUgh6YconPSzIQIDSuIVICyr54dxPsosBnHn2c8sth/KZiszm5arDCZzTeR3cMvR0
 oxsEw0IJ0wLo3wAqPHagLxd8HOWB/Cio3iTeepVbj1pWStHNURUDDoNjslsQDJ/CmZBPU63I2Sf
 P9wuFD58OOfxYJodNr0Rz/h6of/6DfcFaA7/4Mch5ueCnN2CO8qBe78tpYbq7/UBZB+kUOYXS63
 N53pv0olyZqGod5A/JdXteOa98ZU1i41memY+R6ECmzU0HimTxWHQRrIV3q1fB0Jh0WtOv9kiqr
 LC2k9x7r7SM7Cu7HhYsS3aOpy1jgjTwRcllZjJtwfLHMX8H1ViAD6TboUXEDjp63H+viKG9KMsy
 GbHaIzfUpLjj1BkjUPHh02Ivpnoybi1VRZtkUQB87VGeAlmNxHfFFW5Yy2SgBfm+idz+Ao7Ao++
 Z2HLdtRMLr8gwsg==
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

As U-Boot works to align itself with upstream devicetrees, there are
some common issues we start to run into, that of hardware blocks which
might be important for an OS like Linux, but which aren't useful in
U-Boot.

For example, the Resource Power Manager found on Qualcomm platforms
includes clock controllers and power domains which are only useful for
managing power consumption and enabling low power states.

As this is not at all relevant for U-Boot, we can safely ignore these
devices, but we don't have a good way to communicate that to U-Boot.

As an initial step, implement a "stub" clock driver which can be bound
to these devices so that drivers will work as expected. Make the
Qualcomm SM6115 RPMCC the first user of this, and enable the driver for
Qualcomm platforms.

To: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
To: Sean Anderson <seanga2@gmail.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io

Changes in v2:
- Take the other discussed approach of just implementing a stub driver.
- Link to v1: https://lore.kernel.org/r/20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org

---
Caleb Connolly (2):
      clk: add stub clock driver
      qcom_defconfig: enable stub clock

 configs/qcom_defconfig |  1 +
 drivers/clk/Kconfig    |  7 ++++++
 drivers/clk/Makefile   |  1 +
 drivers/clk/clk-stub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)
---
change-id: 20240527-b4-clk-stub-9698797a65ef
base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf

// Caleb (they/them)

