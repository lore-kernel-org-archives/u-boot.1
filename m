Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D5DE71D55
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 18:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F9B87081;
	Sat, 30 Sep 2023 20:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FHHrmr4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E932487082; Sat, 30 Sep 2023 20:34:34 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C908634D
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 20:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79fe87cd74eso232633739f.3
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696098871; x=1696703671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HtFo5VFJn84d26rjpHM6piD9VsGof2u4/gm5NRIc8No=;
 b=FHHrmr4aIF8kto17gh65eHrrutGFgJUipm5upnf3zEqOlCTggQ/thIJvVikWZ4jonb
 9EvmQUojdq9s6C1spHYgDNI2sPe/kAgClyoO4b8qI7W4Kr97FYzJekU6mAR9XAjSAzNO
 xU50+oX1yjEgLcBNP/Sus8vtEVjxCavn/djHF0kKoj+FayC3T8BbZDjS3+q8s9WFbkye
 NpiyZd6J8zmsMtX0lD0Y/RZcikpM6mAfhiHsFGUFgBWmFPr7SNK2mGpwdDNtNNRlba/s
 QbyTV/mZqrBuPPvZ6O/G+nh+bQ4QxCkcsp5leQSf4P3eXL1tV3MDiNWJrhIg/qOvyesf
 yCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696098871; x=1696703671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HtFo5VFJn84d26rjpHM6piD9VsGof2u4/gm5NRIc8No=;
 b=OmHbSsFUIySHszmIdCVds8dNKju//14MwSuSvY+7vEacAto/4bh2TsANOms8+eCYu7
 E4HZIeUDC8E9c/QCv2n39RjTORV9YlqFi+M9bfFmqu8UQwARwAJ156R82bqxFZ/9E7+a
 1jjA/nrYlAaJOJoALAFiTJajU/zTNTDb3hUhq8/TaxpYhvu+fIeVSKnf3S6I2K8FSJat
 1f2SQdQqCfCNjbSpm42j7tqPmds/ul3kpeIZv/KXkvj7Xs5L5mV1pHB+I+FIsV6NM21I
 bf5SsnNN5Sa7t2YBwjFwFp9wWCIxla12gCaOB0biN+njR5U8L6H1VgBekOXPYX4AUHFj
 SMxg==
X-Gm-Message-State: AOJu0YwMfSxgwSZm6/RrllQ8ldjbCX9RNfvWccFdc1lrCcaA4VlIXDoa
 R24am21gBI7/9b9sPoILslFiO4hnGBb7Yw==
X-Google-Smtp-Source: AGHT+IEBsSLpAVd4yIQLPNk1Fl/Th8bq2hBXAPtGW1w08khUa1vN+B+7Ucgdh3XyFvECYCSXCym86w==
X-Received: by 2002:a6b:dc10:0:b0:790:9728:4014 with SMTP id
 s16-20020a6bdc10000000b0079097284014mr8388144ioc.11.1696098870784; 
 Sat, 30 Sep 2023 11:34:30 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:adc8:be74:9e0d:a666])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a056638030500b0043a1fe337b9sm5999140jap.170.2023.09.30.11.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 11:34:30 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v3 0/4] Allwinner R528/T113s PSCI
Date: Sat, 30 Sep 2023 12:34:20 -0600
Message-ID: <20230930183424.806520-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Hi list,

This is the third version of my patchset for supporting PSCI on
R528/T113-s3. It is meant to be applied atop Andre Przywara's T113s support
series (v2). For convenience, the latter exists in a Git branch at:
https://source.denx.de/u-boot/custodians/u-boot-sunxi.git t113s-v2

It's looking like we're very close to finished here. The only "controversy"
that I expect is that patch 4/4 defines CFG_ARM_GIC_BASE_ADDRESS in
sunxi-common.h. There has previously been discussion about moving this to
Kconfig. I agree that this is a good change in principle, but I don't have the
available cycles to look into adding another Kconfig symbol (and cleaning up
Arndale, the other target which uses this) and so have opted to defer that
cleanup for another day.

For testing: I can confirm that patch 2/4 results in no change to machine code
whatsoever on any supported target. Patch 1/4 results in a minor machine code
change on R40 only. Patch 3/4 will likely require testing on each of the 4
"special case" sunxi targets (sun6i, sun7i, R40, H3) to ensure that register
offsets are kept consistent. Patch 4/4 needs testing on R528 only.

Changes v2->v3:
- Fix missing `cpu=0;` for the sun7i power management case.
- Make sunxi_cpu_power_off() a static function, per feedback on v2.
- Kevin Amadiva of MEC electronics got in touch with me off-list, reported
  success bringing up CPU1 of a T113 with this patchset, and kindly provided
  me with a Tested-by tag for patch 4/4.
- Remove a comment about R40/R528 being special, per feedback on v2.
- Simplify an if statement, per feedback on v2.
- Add missing 'select' directives to the R528 Kconfig, per feedback on v2.

Changes v1->v2:
- Power clamp is now adjusted ONLY on sun{6,7}i, H3, R40. The previous version
  was mistakenly doing this EXCEPT on those machines.
- Flattened sunxi_power_switch() into sunxi_cpu_set_power() for simplicity's
  sake.
- Moved the "power clamp is not NULL" conditional into sunxi_cpu_set_power().
- Removed unnecessary H6 special-case, since H6 is actually ARM64.
- Renamed SUNXI_CPUX_BASE to SUNXI_CPUCFG_BASE, to mirror expected changes in
  Andre's v2 of the R528 series (we decided against using a new name for this
  block).
- Removed sunxi_cpucfg_reg struct, and stopped using the PRCM struct in psci.c.

Happy Saturday all,
Sam

Sam Edwards (4):
  sunxi: psci: clean away preprocessor macros
  sunxi: psci: refactor register access to separate functions
  sunxi: psci: stop modeling register layout with C structs
  sunxi: psci: implement PSCI on R528

 arch/arm/cpu/armv7/sunxi/psci.c          | 185 ++++++++++++++---------
 arch/arm/include/asm/arch-sunxi/cpucfg.h |  67 --------
 arch/arm/mach-sunxi/Kconfig              |   4 +
 include/configs/sunxi-common.h           |   8 +
 4 files changed, 127 insertions(+), 137 deletions(-)
 delete mode 100644 arch/arm/include/asm/arch-sunxi/cpucfg.h

-- 
2.41.0

