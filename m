Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760E0CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 01:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFEE86CE8;
	Thu, 12 Oct 2023 03:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="epa1Hl0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB8E86D02; Thu, 12 Oct 2023 03:48:15 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8098071F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35749fd39b6so1730495ab.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075289; x=1697680089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iEj4NjVa2EYRNAZXNowvTEZlv3swa4dILZZBmFHE38U=;
 b=epa1Hl0AMdxPegFvWP1z1j0tuIM9gT5v5RI1CPjEwMpJAccdn9T6KVEW3BoSWUKCk5
 TydVWP3JMY0vjVSNURuk//PWOtM/xu+I32Sg9+KvgfZ7jxYFhyegP9ogC7yUn1JXWwoe
 GPL8FQ1D4StJ4HjR+uS5puQd4WYTxqUC9IeFtcjXbw5usTR1tLuRnjnuIqZht0yTL2Mx
 DpXSbvwv/4dYUYZHlsqR658I1bzqeAngbw0W80d0Qa0C2g2DG3Q75ShWnDT87xo2g2Kq
 qgFyi02w3QNL3+DrzL9ZlGvbm0fbZtmUQ1czRCboWdogF0BTtSX2AOxWt9usHZcPL1Qt
 Lk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075289; x=1697680089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iEj4NjVa2EYRNAZXNowvTEZlv3swa4dILZZBmFHE38U=;
 b=tSjNcr9lvDeZX6T2ntlD5flfk4W63c32MM5b/HSl2E5z0UMXvrrA03gYcQF0t0Be4P
 slznFd9iF0IRcsw+ICrkAxZx8DPp8tsg7w44xQTiAyzOpReJKMdjVU6Y7bvGZsOriqJ2
 mgLIXkzy/1rTQTO+tdPqF9sP9upwBwyteEECJNiVYnOIPO3xGm2gSyVnGBYEiw2eK9dc
 mGyIN4d2Ns8YGly+Wo05D+KPECsPJI7a7d2gORgVLvv36c6oUCtmPGXciXt8lSkrCnoF
 DVD/d2m2rR904JOxYYFHK9A0yvumloBfvrnaqRwtkbndt8K2g7+/cSA4VgGsRHRKLQRW
 yUOA==
X-Gm-Message-State: AOJu0YxU544Nlzpx1zT0WZkidr+mBktCCSv1MiaYrBOgJpAOa6g/pwGf
 arnkm3ijALJcrW77Tl8cp/ZAmzAqG2qo4Q==
X-Google-Smtp-Source: AGHT+IEp6JI/b6U6R82AsGMrT6STQt3TPWGSG2vF64dxtrjFoYETyUQXdOK/MSPi1HB02pBnClOZkQ==
X-Received: by 2002:a05:6e02:541:b0:34f:41ba:7c87 with SMTP id
 i1-20020a056e02054100b0034f41ba7c87mr21729078ils.4.1697075289497; 
 Wed, 11 Oct 2023 18:48:09 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9691:dae3:83ae:38dd])
 by smtp.gmail.com with ESMTPSA id
 gn6-20020a0566382c0600b0043a1fe337b9sm3676422jab.170.2023.10.11.18.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 18:48:09 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v4 0/4] Allwinner R528/T113s PSCI
Date: Wed, 11 Oct 2023 19:47:52 -0600
Message-ID: <20231012014756.2573473-1-CFSworks@gmail.com>
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

This is the third, and hopefully final, version of my patchset for PSCI support
on R528/T113-s3. This one, as always, depends on Andre Przywara's T113s support
series (v2), available on the list and also located on a Git branch at:
https://source.denx.de/u-boot/custodians/u-boot-sunxi.git t113s-v2

NOTE THAT THIS ALSO depends on the following commit on master:
3d5e52bd97 ("ARM: psci: move GIC address override to Kconfig")

For testing: I can confirm that patch 2/4 results in no change to machine code
whatsoever on any supported target. Patch 1/4 results in a minor machine code
change on R40 only. Patch 3/4 will likely require testing on each of the 4
"special case" sunxi targets (sun6i, sun7i, R40, H3) to ensure that register
offsets are kept consistent. Patch 4/4 needs testing on R528 only.

Warm regards,
Sam

Changes v3->v4:
- The GIC base address override is done through Kconfig, instead of in
  sunxi-common.h

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

Sam Edwards (4):
  sunxi: psci: clean away preprocessor macros
  sunxi: psci: refactor register access to separate functions
  sunxi: psci: stop modeling register layout with C structs
  sunxi: psci: implement PSCI on R528

 arch/arm/cpu/armv7/Kconfig               |   3 +-
 arch/arm/cpu/armv7/sunxi/psci.c          | 185 ++++++++++++++---------
 arch/arm/include/asm/arch-sunxi/cpucfg.h |  67 --------
 arch/arm/mach-sunxi/Kconfig              |   4 +
 4 files changed, 121 insertions(+), 138 deletions(-)
 delete mode 100644 arch/arm/include/asm/arch-sunxi/cpucfg.h

-- 
2.41.0

