Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FD7CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F82F88149;
	Wed, 10 Apr 2024 19:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YPZoksps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898F488199; Wed, 10 Apr 2024 19:07:12 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED1286DEE
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e6f4ee104so3383543a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712768829; x=1713373629; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aQUb+FK6W/uKL+R1cxgB7/kHhipNmDzJ7arSoMHulF8=;
 b=YPZokspsQBcRyVXhPbJKOG58okyFuNrmFuFEKM7joqs6eLHtoLygpycjsd/FnfXUdP
 MijZwL1xzhad4noUs8UU9QxMNvQ2C01uLCCWU0eD14qv1AwuxuURNqI/De6TpJNLuRPG
 T/tLwoCZnHMjTaW3ltf8mN7ySnTrqtArQbtL/YAFIkITSFxSgQtjxEEcRKaBFTVyuC0f
 GLePPRYS/wNUMq6lukkqn93+H6qqagZzRq4RatxfiSEQ/EZH8IVlqvFCVT43/NbqoroM
 mNK1MTKIrCnluLyEG2n3MZTB06I/aerGssIhFotrclU0Vh/OWoNPJu1M6vuWAAgizMfv
 /SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712768829; x=1713373629;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQUb+FK6W/uKL+R1cxgB7/kHhipNmDzJ7arSoMHulF8=;
 b=GBKsELRJQjtG7XvMVkMbr3GTrM43ri8rbKxSnc7iNS8PvVBTPKBqirExOIa8FeRdRg
 g+jYMOJfzg1SkJ7JoKL2b8WlheAlNFWf4Uje3x9Cbh8GFI3/ByH0Gr5ZLLeZ2ZM3+NRE
 E1+htk/lJU4n0lrQgSUo1JyxUE0lSAga4H0jrXYlSX0U74d8JvXV7mQdbqw1qBDArPXs
 aKcQTzws32NsyeJGbfn4rWtYDrWt5PD0LMbbNDFmz64xI1BLiK2pTcH9+z9xlzzZIaes
 LLUq4Z1neh6Rhr2Kr//hT0qNRtcDVaX5dmXh6GCkLh5AbciIv2ruEknBz/5sIquDCtll
 ByZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK6LvDEXobOCowRiVD8KKn3TJUI6fNzRvIc/Mppy0Xcg5/LJ3KKWIY61LXDrgLGBORIaWPbLn8YHdqCQhSxqJKXPSeoQ==
X-Gm-Message-State: AOJu0YyuveNaPWIuMomCFRxpT9bNefXp9JiUBAeBtehSlknzYytwGJQ1
 eu+b6NG3jIzt93c22kl0xHkzax3LpSxMTdfvVuWQcOX0tW1hx3K7LjdIK2AYssc=
X-Google-Smtp-Source: AGHT+IFx5KQNNIZRhjSYoySJu7GalEE8b2ds982/L+cy8djrC4KNvX0d8U0gb9fO4wDi7eG8+XEXGQ==
X-Received: by 2002:a17:906:a0c7:b0:a51:e5ac:7b7 with SMTP id
 bh7-20020a170906a0c700b00a51e5ac07b7mr1864948ejb.71.1712768828935; 
 Wed, 10 Apr 2024 10:07:08 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 fw14-20020a170906c94e00b00a51def4861bsm3331881ejb.91.2024.04.10.10.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:07:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] dm: add support for stubbing optional devices
Date: Wed, 10 Apr 2024 19:06:56 +0200
Message-Id: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDHFmYC/x3MMQqAMAxA0auUzAZaaTt4FXGwGjVLlURFKN7d4
 viG/wsoCZNCZwoI3ay85wrXGJi2Ma+EPFdDa1tvvbOYPOp5JZyFbxJFN7kQQ0o2jhFqdQgt/Pz
 HfnjfDxaeKdhhAAAA
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3341;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XINuneVKbG+kZoRURRsdn3GenyKIhRi2tP9PSdZpE2w=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFsc7uteZYO0oPwiPHfsSsP7UtQ7r8gmbOx+nm
 5+242rjRhmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhbHOwAKCRAFgzErGV9k
 tlMuD/0ZXd4+g82fvcinj1XrCXWEGWR8P7VTlfp7OQKsXsgddrHIvk0+2VxM8CPq1EtsEkYg704
 fwNzLkOEUQLqY+VkqOCaWFjsKSx1G1Mo9fsj91NzVGpPvtrS6TzrW0oFT1B0Hfkmxlcj5kkxMiO
 sCGaIT67ZT2LHV5BpPFsK69zTf6zj5kddSpLcoQdkXx1RyVlXiNBllr6S/2rOVQka7T9sJyU4UA
 OtUnVfj6iIOjTDAJ8Fl7HQvkQlGKgmnnjZZvLMQqMthKZ6HmFKsC1/WqM0Ec9LUoY6R67vpzIz9
 35JIson5ejGHbccjfBg4Q6yIum/rI55H1lFS+xCsItm01AnfgQnk/PdQPmBxHNwEIAhQtN5KDZG
 caaBxxbxfSR6oHTjtacB7BexE1d1cx3xxIIDb6F990C15XWnk+q8W945tA0ApU7Y5TjGqBJbdj0
 Ou81PtlsktoT19zN1ninX/SxyclSL5dbZTQNwerrMkCPAiNJve1Dse5kFgjyAxR5ufTY+Z1K3bH
 ZxoB/mwBSq2U/gUO8GkGhHqrSTroD2snhwkg3Kq21zHT07XrsvPMz3k6fdPhSZWP6ImqZ+tuWy9
 +ZsDwcYjLJd4HSi8eINBL2utNkl38BXz4RxJ+XjniBbl4I8jBFex8RTJYCLd3oUsySWPm8PBiRu
 foxWGw9e/nMvUcg==
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

To offer an example: Qualcomm platforms feature a Resource Power Manager
(RPM(h)) co-processor, it can opportunistically ramp down rails and
clocks based on usage. This necessitates placing votes on these
resources for every peripheral that uses them, and as a result means
that many peripherals that we want to use in U-Boot contain references
to the RPMh clock controller. However, we don't actually need to do this
in the context of U-Boot, this is mostly something an OS would care
about.

With CONFIG_OF_LIVE it would be possible to dynamically remove such
references (we could for example add a "bootph-os" property to indicate
that the device should be ignored by U-Boot). However OF_LIVE is not
available on all boards, and is only available post-relocation. This
approach would also require adding a new DT property for every
arch/platform/board that we want to ignore.

We could instead try to handle this at the driver level, but this
becomes intractable when trying to scale across all of the drivers and
for all of the supported hardware generations. It also complicates thing
if we actually want/need to use this previously optional resource in the
future.

== The stub approach ==

The approach taken with this series is instead to allow for a stub
driver to be defined per-uclass, with the clock subsystem being the
first user. This stub driver is used as a fall back in the case where a
driver requests a device of a specific type (such as a clock controller)
and where no other driver binds to the node.

This solution allows us to immediately solve this issue for Qualcomm
platforms, and for any other architectures with similar issues. An
obvious next step is to do the same for optional power-domain
controllers.

Another benefit to this approach is that it is easy to introspect, the
stub drivers will show up in "dm tree". So the case of forgetting to
enable a driver will be much more obvious than if we tried to find the
clock, failed, and just did nothing.

== Future expansion ==

The exact scope of the stub driver (when it should match, how it should
behave) obviously depends heavily on the uclass, as such I think it
should be up to the subsystem maintainers.

An obvious next choice would be the power domain uclass. The current
architecture of U-Boot requires either disabling CONFIG_POWER_DOMAIN,
supporting every single power domain controller on your platform, or
adding DM_FLAG_DEFAULT_PD_CTRL_OFF to a bunch of drivers.

---
Caleb Connolly (2):
      dm: core: add support for fallback drivers
      clk: introduce a fallback stub driver

 drivers/clk/Makefile       |  1 +
 drivers/clk/clk-fallback.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-uclass.c   |  4 ++++
 drivers/core/Kconfig       | 20 ++++++++++++++++++++
 drivers/core/uclass.c      | 24 +++++++++++++++++++++++-
 include/dm/uclass.h        |  3 +++
 6 files changed, 90 insertions(+), 1 deletion(-)
---
change-id: 20240410-b4-stub-drivers-1c1565bb06a6
base-commit: 56c4a3aa2ed15b64eabd067a10be2091d28a5f2f

// Caleb (they/them)

