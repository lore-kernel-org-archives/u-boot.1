Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348FDC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C6F88CD1;
	Mon,  2 Sep 2024 00:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GspDLWS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F35A88CD1; Mon,  2 Sep 2024 00:27:43 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636A6889FC
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-82a24dec9cbso92144539f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229660; x=1725834460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2xtvYljJuLkQgEFznRhEotF9Go4A9O7oyXz+jCoGUM0=;
 b=GspDLWS6anx/29Z1ROVOgdAz1g7wSYPEi7jcJm+yah64gcq+btTilK1M0JIEf+i4kt
 BrWIaMdNwFQ0am3rntt7e3s5NniWV+YV3e94TNE87AqRTMk8LstHoOdwoUksCgusPzoa
 A07qNBBWjQ1/wiCWkqBWNZTK1E0sJy8PRzLtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229660; x=1725834460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2xtvYljJuLkQgEFznRhEotF9Go4A9O7oyXz+jCoGUM0=;
 b=vp8agVZeCE3lB/IZACEKvFSCactEq7rznaFXM9t3NPeBYdReZaYwXncNCeJmrE2+vL
 p6HU/c02o9Mf23yF3ezOCzjV3a4uRhaw4qcnlxOV+izR+LrDzcfgUYwn9ROgG3UgPPww
 0ypXHFIFEDmy5m1xnsXDAtNXOCNQuhZbCGv2kZwY7CjiEIk99/PNyM5oDNSw2FAWED57
 EMPTe0X4bn2QY72IVZ4UDuyaaGvMAJwSQwsprWvW04fZuuaY1WUb2MKoOIfzSX1z+tow
 DY/RcRdr36hQ/GvGSvwFOniTfed4D0oYSnkb2zSH7ZRqq5QEfUXkn0E+kMJaEdF2wBvD
 yL1w==
X-Gm-Message-State: AOJu0YwqjCIIg/7Rd3qBvdzOwwjx9+NA4M89Fkz5OGxdQS450IRk0Z0w
 Kn7+x9gAQcg0LwfoQeXt8IFnmsYog8U1OaL6ll8l5ce5MWFeSUg4D9GqABUgaPDGnbCzb+cGpFo
 =
X-Google-Smtp-Source: AGHT+IHS+T8XB+2NnAm9aTa9NxkU8I2s3mV4oOUvh3taBGWfEkWHo3pT9N21gwku678+MyVbKTOvyA==
X-Received: by 2002:a5e:980f:0:b0:82a:13f0:800d with SMTP id
 ca18e2360f4ac-82a13f080afmr767229639f.5.1725229659839; 
 Sun, 01 Sep 2024 15:27:39 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e17bb4sm1866981173.82.2024.09.01.15.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v3 0/8] bootstd: sunxi: Migrate to standard boot
Date: Sun,  1 Sep 2024 16:27:26 -0600
Message-Id: <20240901222734.462334-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This series attempts to migrate all sunxi boards to use standard boot,
along with a text environment.

Changes in v3:
- Drop wip (work-in-progress) comment in commit
- Fix 'supressed' typo
- Use backquotes to highlight DEFAULT_DEVICE_TREE

Changes in v2:
- Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
- Put the FEL bootmeth before all other global bootmeths
- Convert the other DISTRO_DEFAULTS in the Kconfig too
- Keep BOOTCMD_SUNXI_COMPAT
- Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled

Simon Glass (8):
  blk: Make functions available unconditionally
  bootstd: Avoid calling unavailable block functions
  bootstd: Avoid depending on BLK
  sunxi: Add a bootmeth for FEL
  sunxi: Move to bootstd
  sunxi: Drop old distro boot variables
  env: Provide a work-around for unquoting fdtfile
  sunxi: Move to text environment

 Makefile                                      |   1 +
 arch/arm/Kconfig                              |  10 +-
 board/sunxi/sunxi.env                         | 152 +++++++++++
 boot/Kconfig                                  |  16 +-
 boot/Makefile                                 |   1 +
 boot/bootdev-uclass.c                         |   3 +
 boot/bootmeth_fel.c                           |  81 ++++++
 .../gardena-smart-gateway-mt7688_defconfig    |   1 +
 doc/usage/environment.rst                     |  12 +
 include/blk.h                                 |   9 +-
 include/configs/sunxi-common.h                | 238 ------------------
 11 files changed, 278 insertions(+), 246 deletions(-)
 create mode 100644 board/sunxi/sunxi.env
 create mode 100644 boot/bootmeth_fel.c

-- 
2.34.1

