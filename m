Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4E9D5E377
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA8E88D90;
	Sat,  9 Nov 2024 18:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g0LtZPHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930338909F; Sat,  9 Nov 2024 18:08:35 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F31C88C0F
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cd76c513cso28969255ad.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731172111; x=1731776911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xdKYjsa5AX4T/X6TxJE8qePYoPyOvk+ctXjCKB737cs=;
 b=g0LtZPHRUffqg92z6k1uzhsPJ2inaQrzcdWiXtvnp4cNB81BCsBL/Ev4RNDvVeBHHD
 aOmwL0dH/uw9MqzAQDJU3MwH46FQvx/cGO7dTZM7YBDiZnUWzbFAlFgp3pNpLMz3/GL8
 GE0otdy6QFerD3OcgvlFXJNrKcQZ/XWnQIy8WJ6/znB6ZvDNhWn98pRDmvzxGA4DMYS9
 sHlL8l272lgnA2lPGyDAHjITiQ8+OESNIWTkt/1VE5Q95hlL8XLWq2N1jGL8ey1CEl2S
 E+dRzpu5HqpF1v5mCw6F17BZIYtADt/bbydVf8nkshK23CxybQzTSaoC9pS5sLFpiq31
 qU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731172111; x=1731776911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xdKYjsa5AX4T/X6TxJE8qePYoPyOvk+ctXjCKB737cs=;
 b=IhnSFRVm4FSfMnr4TPWuVV1p8h+lyguGLek62WR/SkJ+1cGw5AFNyJz74U2yf8Nifq
 DdO92F2VCNWYfgVRY4Hs5pwl0AFuTU6D3Jl2FdmnR0Ac3trpR5MPyOkl08v61Rn7YM+7
 i1KfDDyAmtm1yY+Mc33Vk1nJ2HOedYpQUxa3CivNVu/EuCCPnfOXvlDGnpe/KltxDiXX
 8MPprsdeWIPBJm7QKdMUwGNrXNKpz2YEufhbDMPNEsztzgCHi+ufqK4AvdUx68UbHPkI
 qgztFNwbMQ/0QC1cbhiWuX4wOQNqyd8Zn8X2yd+ip6cg/jDW6i/fpITiEcCfd0f8sBIu
 9hKA==
X-Gm-Message-State: AOJu0Yx7kLf90Cfj+d7h4odCaWCNhMSuToPS8SHLUqk4XcuTOfzEB+9R
 GysgpM83zSh5TLAkqLSq9NJLV2h++6ohYR4uymlnXLBWM2UVGg25DIKLgg==
X-Google-Smtp-Source: AGHT+IG7rqDKe8MIvkritPuUFGIvGT2iCYC90//L5pkHILHs2AK8nfX8Cmsxm/ZsWWwYPs8oHfO5qg==
X-Received: by 2002:a17:902:ea01:b0:20c:d5d9:95dc with SMTP id
 d9443c01a7336-211835d91b8mr93040635ad.40.1731172111494; 
 Sat, 09 Nov 2024 09:08:31 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ef5f:7b36:c2f1:9678])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc7f94sm48600765ad.17.2024.11.09.09.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 09:08:30 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20241109
Date: Sat,  9 Nov 2024 14:08:26 -0300
Message-Id: <20241109170826.1995522-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit a7a96a37cbd875994bc8d25adb0536bf00e4a30e:

  Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2024-11-06 10:44:33 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241105

for you to fetch changes up to 28958998f6301bc4a247a9057a623f997ee78c11:

  arm: mach-imx: imx8m: re-use SNVS init routine (2024-11-09 08:55:04 -0300)

u-boot-imx-master-20241105
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23262

- Improve imx9 boot medium autodection.
- Add possibility to skip DCD on i.MX8.
- Switch to using upstream DT on DH i.MX6 DHCOM.
- Add support for i.MX6DL DHCOM SoM on PDK2 carrier board.
- Handle FIELD_RETURN on i.MX HAB.
----------------------------------------------------------------
Benjamin Szőke (1):
      imx9: Improve boot mode autodetection

Heiko Schocher (1):
      tools: imx8image: add possibility to skip dcd

Ian Ray (2):
      arm: mach-imx: move snvs module
      arm: mach-imx: imx8m: re-use SNVS init routine

Marek Vasut (2):
      ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM on PDK2 carrier board
      ARM: dts: imx: Switch to using upstream DT on DH i.MX6 DHCOM

Paul Geurts (2):
      imx: hab: rename imx_sec_config_fuse_t to imx_fuse
      imx: hab: Make imx_hab_is_enabled dependent on FIELD_RETURN

 arch/arm/dts/Makefile                              |  6 +----
 arch/arm/dts/imx6dl-dhcom-pdk2.dts                 | 15 -----------
 arch/arm/dts/imx6dl-dhcom-picoitx.dts              | 20 ---------------
 arch/arm/dts/imx6q-dhcom-pdk2.dts                  | 25 ------------------
 arch/arm/dts/imx6s-dhcom-drc02.dts                 | 30 ----------------------
 arch/arm/include/asm/mach-imx/hab.h                |  5 ++--
 arch/arm/mach-imx/Makefile                         |  2 ++
 arch/arm/mach-imx/hab.c                            | 30 ++++++++++++++++++----
 arch/arm/mach-imx/imx8m/soc.c                      | 11 +++++++-
 arch/arm/mach-imx/imx9/soc.c                       | 12 ++++++---
 arch/arm/mach-imx/mx6/soc.c                        |  7 ++++-
 arch/arm/mach-imx/mx7/Makefile                     |  2 +-
 arch/arm/mach-imx/mx7/soc.c                        |  7 ++++-
 arch/arm/mach-imx/mx7ulp/soc.c                     |  7 ++++-
 arch/arm/mach-imx/{mx7 => }/snvs.c                 |  0
 arch/arm/mach-imx/snvs.h                           |  6 +++++
 board/freescale/imx93_evk/imx93_evk.c              |  2 +-
 configs/dh_imx6_defconfig                          |  5 ++--
 dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts | 20 +++++++++++++++
 include/configs/imx93_evk.h                        |  8 +++++-
 include/imx8image.h                                |  1 +
 tools/imx8image.c                                  |  7 ++++-
 22 files changed, 113 insertions(+), 115 deletions(-)
 delete mode 100644 arch/arm/dts/imx6dl-dhcom-pdk2.dts
 delete mode 100644 arch/arm/dts/imx6dl-dhcom-picoitx.dts
 delete mode 100644 arch/arm/dts/imx6q-dhcom-pdk2.dts
 delete mode 100644 arch/arm/dts/imx6s-dhcom-drc02.dts
 rename arch/arm/mach-imx/{mx7 => }/snvs.c (100%)
 create mode 100644 arch/arm/mach-imx/snvs.h
 create mode 100644 dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts
