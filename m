Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DB1C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5582C80AE1;
	Mon, 10 Feb 2025 17:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rN81o+Kn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1706780B98; Mon, 10 Feb 2025 17:27:33 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C11F80548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43618283dedso45584955e9.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204849; x=1739809649; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hAUOOV7qojGv+Acdk5G3sRuiuLnxrfJVSLvGv1KBjHo=;
 b=rN81o+KnwN+i6Ef6rF0Yb/84HA4KZaToFtuGXYjIKf5b6h8JPCqtIsYCFkQYgZIeCw
 hf2E0sbo0vzK6+5iGnbNHT8lrlnQ2wipNRw/Yt1FrKFJAt7G2misHIMVfQ2eO7Dt795Y
 5uyytFsducouwNLcqk61VKAjjyyS6SiSYIZy2ytG5rYdo+Re6cmXCFQL+ok1P7wOa0Ku
 3Nf1OWrUdmwqmg+oI4d1tM+zqI1l+5XNGhMWRwDucue6z6DUVIbG8pWb4O6Mf76ygqCV
 xvvEKHByLzAuD3lq9hZmwqk95lJJ0x3PQFVCU34AjT9CDy8llfW9cnOax4mZbNDv0wDM
 hnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204849; x=1739809649;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hAUOOV7qojGv+Acdk5G3sRuiuLnxrfJVSLvGv1KBjHo=;
 b=F/fhNdXf+QEo/fF7h/rBsbTSGgIRvH8Fl4/CyN9E8Eoh5Lt3TManHGeIV+r8SDUKxc
 YC7SUTijRLFXt80YwJ4fIYeNEwdogRHWgFpxhzQ5A7ZmBOQjWf6hSEaCq5pftI+p+LhQ
 B5nQyyxl2X/FIdlvgjJvSuNCPSioSu9jw+ueDbw9GxpSkSkoOTdz4pHcv/HzPe++CSE3
 u9U4J7reeGKxsqMthZt0rLL6CiaP4o2MT8rVuuvp+DpjTcu4KBqykIsvzf4btO0b3FXQ
 abT8l6/or6lBo9ConM8SQGtKKO60VLvAxDs0yMWRoOvzqO9yq7O7AxtoBT78mbN0Pf70
 LJoA==
X-Gm-Message-State: AOJu0YyJ6j3eDSBnDc1hFSkRttxytBGm4AS0SpOZlymkUHtuhTOgbzgj
 hzVuTFKsGuNrSNfIvD3kpA2taV+gGOjL6esvppAOUET+//I5D5BxcVbl0rEgbZo=
X-Gm-Gg: ASbGncurWonat1mqcQxVL02UkPs3ryWJ8+HBFvtrjVbum1SydEDZZHxWDF5PjEldhKM
 X6ag5Np341qK4eRLIDPNcEcQI52iuua/rJ7x4Vsjm3JPIx01Q0FzNdrXOTA/vNzyYNUdIOXQQF9
 K8crAa4fdkQ0JxRZKyadTPa3pHheSgLkzltc3l7lDTKQ245hxdv24z9vfPEUGqYdMgFQbSsE7Rt
 q/Y62NlW6DSK7QqIrnTrto2HoUGMwAF7hZykk3aC3JcnCngzv1AeWL0x7i7mwUjNmxxrP3/UAnE
 nwP4M7ubfLy+1f8fN3hQ7a1pjET1wwY=
X-Google-Smtp-Source: AGHT+IG/AkVJnjbcUTa07HxQ3K2bnb/ISjCxE/hA9PTJNgpYsRVj1PMwwMfwm6QGtMUhNVl3qPUNXg==
X-Received: by 2002:a05:6000:dd0:b0:386:37f5:99e7 with SMTP id
 ffacd0b85a97d-38dc91133aamr10034813f8f.33.1739204849629; 
 Mon, 10 Feb 2025 08:27:29 -0800 (PST)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd6080926sm6648295f8f.83.2025.02.10.08.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:27:28 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 0/3] clk: add a stub clock driver
Date: Mon, 10 Feb 2025 16:27:24 +0000
Message-Id: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwoqmcC/2XOTQ6CMBCG4auYrq2Z/lHqynsYF0AHaCRgWmw0h
 LtbcEHQ5TfJ+2QmEtA7DOR8mIjH6IIb+jTk8UCqtugbpM6mTThwCYprWkpadXcaxmdJTWZybXS
 RKaxJKh4ea/datest7daFcfDvFY9suX4dyWBxVsN6F9EHGhkFmhmhSssr0JZdOtcXfjgNviELF
 vkG/D4SeYq5ASZypVBI8ReLLTZg9rFIMdZgBGglpFW7eJ7nDwvHA18lAQAA
X-Change-ID: 20240527-b4-clk-stub-9698797a65ef
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7QGjmv6McN7S6wMxiIVwsSd87yI19lctCJku3nbhZZI=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGeqKO+jjV1l74X1lhfanFtMQLyKemWT77GqWqm/WtaV+lYFE
 oh1BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmeqKO8ACgkQeTBFn7kwMhf+3QD/VOAe
 Rhih+bEi1WJi/02P4+0gAzrXa/l6nR8j3V04lDkBAKQeu8AXDEVdD2dRLddSuMO4i7WW6tMx2py
 JNwCJ6n80
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
to these devices so that drivers will work as expected. Add the
necessary compatibles for the rpmcc and rpmh-clk controllers on older
rpm (non-h) platforms and the sm8250/8550/8650 platforms.

This is necessary for certain peripherals to work on various platforms,
most notably the sdcard reader on SM8150 phones and the SM8250 RB5
development board.

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

Changes in v4:
- Add sm8150 compatible
- Link to v3: https://lore.kernel.org/r/20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org

Changes in v3:
- Add 8250/855/8650 rpmh clk stubs
- Link to v2: https://lore.kernel.org/r/20240527-b4-clk-stub-v2-0-29013855e343@linaro.org

Changes in v2:
- Take the other discussed approach of just implementing a stub driver.
- Link to v1: https://lore.kernel.org/r/20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org

---
Caleb Connolly (2):
      clk: add stub clock driver
      qcom_defconfig: enable stub clock

Julius Lehmann (1):
      clk: stub: add sm8150 compatible id

 configs/qcom_defconfig |  1 +
 drivers/clk/Kconfig    |  7 ++++++
 drivers/clk/Makefile   |  1 +
 drivers/clk/clk-stub.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)
---
base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2

Caleb Connolly <caleb.connolly@linaro.org>

