Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904D4C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 17:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D70869F6;
	Wed, 16 Aug 2023 19:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjCAVdP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE03869F6; Wed, 16 Aug 2023 19:34:31 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2517A866D0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bee82fab5aso12267135ad.3
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692207266; x=1692812066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rLttHBSnbs3Ezul6zAcAmmXh/B0hjOdZT40lVe8FoW0=;
 b=ZjCAVdP78nGEFEgp1wRMZcqFsNtw3oDOzgYdwTuF76Aa1vIAfo7NfTHQFQWUc2Ne1y
 U14/bN68YR3/IXxw/O+C1ImmWvixaZfxMOooOrhvqXetkCtNVZNlklI78r/AuxYv7tcL
 FXTnhbb+yItEUl8u6E7RYa5OVlNyDGZJAMUSxQRdDxPvof0EeB2ZeWIEYpVsFdV+hiB3
 Rbko9vbk6PFbr3/X7vLu+2LoUtXvpeZmbVqcOpZEunG316tEr9rbB3bx3TqFt2w7zxZ4
 12kUA6hCuhxoJwHxbBrA+LeoNpL53R35xVrbg7oUZWTSsw/kTZre7h6fgTr9Z2rjMrxJ
 htSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692207266; x=1692812066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rLttHBSnbs3Ezul6zAcAmmXh/B0hjOdZT40lVe8FoW0=;
 b=CjL8EwWJ0bjV+8le+5You4wiLNaXU9PbR+tn8/oPei5yYX4ViacF9lpqWFBBSf+wy7
 uFbkIAaIbuaTN0/+79tXmDIjLSHmfTytsqjr2rCLIVd4OxYprCfU8ah0mvbeMSZBn7Oj
 Go6nvI82qrb03EbeQSznV8ebrhIurGW2SMR7mfjnGebsU1LsIjekxuPDvnpkVmBrD509
 vMwLWQYOTy3qPFzA6+dhtmOFw+gn6AQVzZ871SrJJfW94H+pw6QaJiMdUx1uVelCO1XC
 7W6wif/Fr7zMhwtFsLu5n5rb7Q3NyEG5LqXToYq6FD1NQ64iLHSw+5mol9ykxp+ZoSa2
 qD5w==
X-Gm-Message-State: AOJu0YwinBlKIoDHU9qWielzOOPBxPI3c9Nv8YUD68Rg8A+2NU7wXjzi
 4h6DWmPgPZEitQW8Onry3oSQLEzZgV/oKQ==
X-Google-Smtp-Source: AGHT+IETdtXCbWjHYE5+qvh+t35HYDiADTOp234YXgF748UF3P6BrQrl5s7Sq3PK4sh+4EXaI91wfw==
X-Received: by 2002:a17:903:228a:b0:1bb:3498:9caa with SMTP id
 b10-20020a170903228a00b001bb34989caamr3368027plh.58.1692207265972; 
 Wed, 16 Aug 2023 10:34:25 -0700 (PDT)
Received: from celestia.nettie.lan (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 z5-20020a1709028f8500b001b8a7e1b116sm13338631plo.191.2023.08.16.10.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 10:34:25 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 0/5] Allwinner R528/T113s PSCI
Date: Wed, 16 Aug 2023 10:34:15 -0700
Message-ID: <20230816173420.83232-1-CFSworks@gmail.com>
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

This is the second version of my patchset for supporting PSCI (i.e. second core
bringup) on R528/T113-s#, incorporating most of the feedback from Andre.

I do not expect the final two patches in this series to be winners yet. There's
still some back-and-forth going on to sync them up with an anticipated v2 of
Andre's patchset for R528 support (on which this work depends). My v2 is being
sent now mostly just to smoothen that.

However, the first 3 patches in this series ARE meant to be reviewed seriously:
the refactoring is totally independent of the R528 effort, and I see no reason
to wait for the R528 stuff to be nailed down to get started reviewing them.

Going forward, any more changes will most likely be form over function, so
aggressive testing of the whole 5-patch series -- on sunxis old and new -- is
nonetheless very valuable at this point. :)

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

Cheers,
Sam

Sam Edwards (5):
  sunxi: psci: clean away preprocessor macros
  sunxi: psci: refactor register access to separate functions
  sunxi: psci: stop modeling register layout with C structs
  sunxi: psci: implement PSCI on R528
  HACK: sunxi: psci: be compatible with v1 of R528 patchset

 arch/arm/cpu/armv7/sunxi/psci.c          | 195 +++++++++++++++--------
 arch/arm/include/asm/arch-sunxi/cpucfg.h |  67 --------
 arch/arm/mach-sunxi/Kconfig              |   2 +
 include/configs/sunxi-common.h           |   8 +
 4 files changed, 136 insertions(+), 136 deletions(-)
 delete mode 100644 arch/arm/include/asm/arch-sunxi/cpucfg.h

-- 
2.41.0

