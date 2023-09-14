Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53742EEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962DF87070;
	Thu, 14 Sep 2023 18:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mAoIlXMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D6A86E5D; Thu, 14 Sep 2023 18:56:32 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABAF87062
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34df2a961a0so4063245ab.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710587; x=1695315387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JJyVRpIx3AX018vKeLsYwX8BJ0VfnJXaVE+WDB9oJew=;
 b=mAoIlXMG2qR6nwIHBmH8bjkhJZr7TxfSPtUhqkP4SocWd50FO5tF57ebVRHH9Ox7rU
 dDDfyYHNHALYbuG6pjedn83cBvoS/HESmEk3TTJ7OZPBffW7sFje+rZo4AxmlY3pI95t
 rYWbUeihNAmToCKpN6kW+k4DacslCAQxZIUm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710587; x=1695315387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJyVRpIx3AX018vKeLsYwX8BJ0VfnJXaVE+WDB9oJew=;
 b=mw4jUmFPJn5zRFQffcDm046FX22RnJHmucdpQeg1lwCDHlnBvmq2XDRY2iljJBwjnb
 oqR3WM9j5zxVVpGJGZf3bOlOh82gsn5IfOpQos4C1EJ+vJTTj/u5vnZrF3irla19t8Q4
 He84mFX05HW6Vt+yq7x+kognndrXXVcOcxvsmHTWAXnL4Iuk/vcv38a1O7nWRI8tLq0I
 xOTeh+FWFDQKlwpILhmS0Na2oNRfgIi9Y0MIh+P9VFDG+zAeFk1CWeRjS1S6mLs1lRLn
 3GRJ72xjwz0OVDNZI4wB7TEfpAGe7yLxdYSwoICNUOZzWCy+ePYj+aoDVZoS9sHr6fSh
 QTjw==
X-Gm-Message-State: AOJu0YwS0rrz4ztt3E3bwv4sqYWkip6vlr0eIbRnJCD8DRV6/92aYDFU
 IAodx5ItsL7LESXP+2MyBt6BVel+eG4cP0NwYGw=
X-Google-Smtp-Source: AGHT+IGIjj5bGCYF3yG9E5m+YSPmYxtLDumNEDhvnpPbolZ7KcDZSMzRs9ARyZkf9rkAXoPf06gMYQ==
X-Received: by 2002:a05:6e02:190f:b0:345:df7f:efc4 with SMTP id
 w15-20020a056e02190f00b00345df7fefc4mr6724620ilu.27.1694710587130; 
 Thu, 14 Sep 2023 09:56:27 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Harald Seiler <hws@denx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Nikita Shubin <n.shubin@yadro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCH v5 00/21] Kconfig: Tidy up some options
Date: Thu, 14 Sep 2023 10:55:38 -0600
Message-ID: <20230914165615.1058529-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
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

The view from 'make menuconfig' is confusing in places. This series aims
to improve the top-level menu and also the boot menu.

It also groups FDT-fixup options tegether, at least the ones I could fine.

Finally this series marks the distro scripts as deprecated, so people have
a pointer to standard boot.

Changes in v5:
- Add back the Makefile condition, for efi-app builds

Changes in v4:
- Just move these options to driver/video for later consideration
- Allow TIMESTAMP without FIT
- Add new patch to drop SPL/TPL_RAM_SUPPORT option for SPL_LOAD_FIT_ADDRESS
- Add new patch to make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT

Changes in v3:
- Drop comment about an update/ directory
- Drop extra newline and quote
- Add new patch to drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS
- Drop patch 'Move SYS_RX_ETH_BUFFER into the network menu'
- Drop patch 'video: Move BMP options and code to video directory'

Changes in v2:
- Add new patch to move bmp code to drivers/video
- Fix FMU typo in the subject
- Drop now-unnecessary depends on FWU_MULTI_BANK_UPDATE
- Mention in the DISTRO_DEFAULTS option that it is script-based
- Expand and rewrite the commit message
- Use the word 'Mark' instead of 'Make' to improve the English

Simon Glass (21):
  lib: rational: Move the Kconfigs into the correct place
  Kconfig: Move API into general setup
  video: Move bmp code to drivers/video
  video: Move the BMP options
  FWU: Avoid showing an unselectable menu option
  test: Move POST under a renamed Testing section
  boot: Move fdt_support to boot/
  Move fdt_simplefb to boot/
  boot: Move some other fdt-fixup options to the same menu
  boot: Rename Android-boot text
  Kconfig: Create a menu for FIT
  spl: Tidy up load address in spl_ram
  spl: Drop SPL/TPL_RAM_SUPPORT option for SPL_LOAD_FIT_ADDRESS
  Kconfig: Move SPL_FIT under FIT
  boot: Make standard boot a menu
  Kconfig: Move TEXT_BASE et al under general setup
  Mark DISTRO_DEFAULTS as deprecated
  Make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT
  boot: Join FDT_FIXUP_PARTITIONS with related options
  boot: Drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS
  boot: Join ARCH_FIXUP_FDT_MEMORY with related options

 Kconfig                         |  67 +++++++++-
 boot/Kconfig                    | 222 +++++++++++++-------------------
 boot/Makefile                   |   4 +
 {common => boot}/fdt_simplefb.c |   0
 {common => boot}/fdt_support.c  |   0
 common/Kconfig                  |  20 ---
 common/Makefile                 |   4 -
 common/spl/spl_ram.c            |  19 ++-
 doc/develop/bootstd.rst         |  23 ++++
 drivers/video/Kconfig           |  16 +++
 drivers/video/Makefile          |   1 +
 {common => drivers/video}/bmp.c |   0
 lib/Kconfig                     |  17 +--
 lib/fwu_updates/Kconfig         |   9 +-
 test/Kconfig                    |  12 +-
 15 files changed, 225 insertions(+), 189 deletions(-)
 rename {common => boot}/fdt_simplefb.c (100%)
 rename {common => boot}/fdt_support.c (100%)
 rename {common => drivers/video}/bmp.c (100%)

-- 
2.42.0.459.ge4e396fd5e-goog

