Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5FBC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2601C86A28;
	Thu, 24 Aug 2023 21:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TTK5+45N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 374BB869D1; Thu, 24 Aug 2023 21:59:30 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EFD869A3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7927611c54bso6958339f.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907164; x=1693511964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dRNKAG+ICedD5GkHfVkHKDlvCN9CKgdt/cxdWmerQZY=;
 b=TTK5+45N2K/kOY5nQcKvSI7cYeCmn1NMmG+TLxGOuY+gAK4dcGU92nT3iVUUW6rvXJ
 KD5J6nE5+MEght9QDn2TYigSXLnjTNy6a0taPFpqWdVb6/9f/fcOYpa+EF7K7A3U+H67
 w6waZKh41maXKpXpVe6vfzo1CRL7KLMz5hheY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907164; x=1693511964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRNKAG+ICedD5GkHfVkHKDlvCN9CKgdt/cxdWmerQZY=;
 b=V0LMNuztiNyVgPHjZwumHfhNgxz6jxcdmj0UXRQHZp2en5QT5Q8sKXkPkysZ+tVWeM
 0mP2+gzqu30qw/WG0l+5bSCw3kLPeGZadIebwzvcNsFivYxQlNrdJYJwg7IjPzLLKSQi
 QCjLO0lnDfO+Ms3Pur7kxEnPZDnn+uX2a/C31GJNugZ233q4cqY9U7NjoGzDNHi1te+i
 btq4LhFXANSkc1mI/7OpP8foq0Zn4azozR0w2OgEntg8tUQ6zGM4sGQU39IrXxMqw++J
 4bgjFjlG8O/cR2VKgj0JNTA6UABp1dRfnRFGOeIcB7TBrAj2kmhXvF4xe5LIcMHf5oKL
 VVZw==
X-Gm-Message-State: AOJu0YwHRrfqvxW47spSu6iI1/05I+37tO+GNwSxvngeUckx8N+9wFVE
 R3G5BWKeEUSaJR0rD1rHEqiSRhkfZve+Df5LXeg=
X-Google-Smtp-Source: AGHT+IH3nVIW1Tg9bg+m3Tt7KLS1uYepJAstbgfTNx4/G4kfkJwyr451arlxRYhOXedRcO2Jg7eK9w==
X-Received: by 2002:a6b:db0a:0:b0:790:6629:b222 with SMTP id
 t10-20020a6bdb0a000000b007906629b222mr7175005ioc.5.1692907164435; 
 Thu, 24 Aug 2023 12:59:24 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Nikita Shubin <n.shubin@yadro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/19] Kconfig: Tidy up some options
Date: Thu, 24 Aug 2023 13:58:51 -0600
Message-ID: <20230824195917.1687886-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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


Simon Glass (19):
  lib: rational: Move the Kconfigs into the correct place
  Kconfig: Move API into general setup
  video: Hide the BMP options
  video: Move BMP options and code to video directory
  net: Move SYS_RX_ETH_BUFFER into the network menu
  FMU: Avoid showing an unselectable menu option
  test: Move POST under a renamed Testing section
  boot: Move fdt_support to boot/
  Move fdt_simplefb to boot/
  boot: Move some other fdt-fixup options to the same menu
  boot: Rename Android-boot text
  Kconfig: Create a menu for FIT
  Kconfig: Move SPL_FIT under FIT
  spl: Tidy up load address in spl_ram
  boot: Make standard boot a menu
  Kconfig: Move TEXT_BASE et al under general setup
  Make DISTRO_DEFAULTS as deprecated
  boot: Join FDT_FIXUP_PARTITIONS with related options
  boot: Join ARCH_FIXUP_FDT_MEMORY with related options

 Kconfig                         |  67 ++++++++++-
 boot/Kconfig                    | 202 +++++++++++++-------------------
 boot/Makefile                   |   4 +
 {common => boot}/fdt_simplefb.c |   0
 {common => boot}/fdt_support.c  |   0
 common/Kconfig                  |  20 ----
 common/Makefile                 |   4 -
 common/spl/spl_ram.c            |  19 ++-
 doc/develop/bootstd.rst         |  23 ++++
 drivers/video/Kconfig           |  11 ++
 drivers/video/Makefile          |   2 +
 {common => drivers/video}/bmp.c |   0
 include/net.h                   |   9 +-
 lib/Kconfig                     |  17 +--
 lib/fwu_updates/Kconfig         |   6 +-
 net/Kconfig                     |   4 +-
 test/Kconfig                    |  12 +-
 17 files changed, 220 insertions(+), 180 deletions(-)
 rename {common => boot}/fdt_simplefb.c (100%)
 rename {common => boot}/fdt_support.c (100%)
 rename {common => drivers/video}/bmp.c (100%)

-- 
2.42.0.rc1.204.g551eb34607-goog

