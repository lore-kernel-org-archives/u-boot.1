Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD7CC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B48EB8852B;
	Fri, 17 May 2024 20:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="gNn23Nhx";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oy+/JouU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A449088542; Fri, 17 May 2024 20:14:57 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD3088518
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id A4D4B11401C5;
 Fri, 17 May 2024 14:14:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 17 May 2024 14:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715969692; x=1716056092; bh=0k
 QsIx4pnW377hv3fdMhsFWRt4o8ssG9YGJGLClY6/c=; b=gNn23NhxPQ7Rk+TnNi
 DzdMMWa+TjeLQcJC+DV90jJPfuqKiCuXymX5PF22J94JBJ3YnXnwd7rBwW7pIKDe
 aCq7bL8iBf90WQi5xwuMBtXNJVJxSMOC/JYpDmKl2h4CAlVUIQga4/KGvfLcY5le
 l3R8Xmlhg5Jobte0SGAlLej5/QxNzLfuUQ9klkgqDUBY037ZZvFdYbLQe0O5B8Ns
 lo3q5q3HuuFoL2g7qgTqX8NUsI8aAQoOv52b3PRv41SYxTg+Ysb+ri9d1y0kfLsQ
 2UV6/CYHsq6e/sIlPlSbaDXngzioEWQ4c8QoXsJa7IgAZeh0/reoNrpjqubz5E4t
 VlPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715969692; x=1716056092; bh=0kQsIx4pnW377
 hv3fdMhsFWRt4o8ssG9YGJGLClY6/c=; b=Oy+/JouU9y5XG6WlCURvefmLgQ2x2
 jZC3vZlLBkHwpeaf7rRhVeiM6bK39xhy1L0ooe94AkiDg21cRbEkBm45Mu2fsuvi
 xtrCWSg1KUOa2AIZdnuuscx5moB/d80+rNygTMnEY+QPSFRasrW9B5NFWPNh8AJs
 ArEHzxWPn5aTLbKawoSML39YYqrHtm/YZd7/jctkGCJadcMKxN1Em+sD0EDRVemy
 O/NiW5LpR+LYwrCx4ThLDfqgmsUbZqB5nIPks5+xdt0Bq9ZPovGyWipHzNjqTDfu
 9ijNGmJJJzbm6GG4JAScCwX08Ywlr+j79qYmXUdjel5D0lHvkI9Qu1kiw==
X-ME-Sender: <xms:nJ5HZgIcF7VbPEl2upVMwtgxSIlozJ2PbKviNDi6L5Wsnwrt_GTl7w>
 <xme:nJ5HZgLVzrPZZ4pXlABF30jmzSTw7sycIkFC4Vf1Y3Wb4g5giFPB8tFYh_L7tTAH8
 nBLh0xZsKowMJjHK4A>
X-ME-Received: <xmr:nJ5HZgvWqHPOkQG8HidcNY1_aAwKX06O6NDyy36TN-Ha-CJcl9OThqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
 kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:nJ5HZtZwOBDsuJNgTk2pPVJeDFZSsYi0n9S3IcrfXs8XvlouKJrFWw>
 <xmx:nJ5HZnYT9HK3kJPmEtf5yleQpvUi291Cnud3K8dXgR_khBGeQlvZvQ>
 <xmx:nJ5HZpDpFgHAdSIzqpErHJqB9-gNIQ9qSAyLe0yX8B633os-eyxJlA>
 <xmx:nJ5HZtZj9q9pz6Dooa9BX3zzXQJg-g5PjQDcISToIBzismm0VStiqA>
 <xmx:nJ5HZlCAeohCTeQx-1yyo3T7vyMalD7jnS3DyG_RbGdEg99fgfXfQ1tW>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:14:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 00/12] MIPS: Boston: Various enhancements
Date: Fri, 17 May 2024 19:14:48 +0100
Message-Id: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJieR2YC/22NTQ6CMBhEr0K6tqZ/FHDlPYwL2n6FJkpJSxoJ4
 e4WFkaiy5nMe7OgCMFBRJdiQQGSi84POfBTgXTfDh1gZ3JGjDBBSsqx8nHyAxYlWAlGM9pYlMd
 jAOteu+h2z7l3eRbm3Zvo1v4oEsUEK0IYCKU5KHm1j7nz7XTW/rk5/wK21Y1seC1oBQdge03s+
 0l+QJbBqspUTYihxhzBdV3f6KLRzggBAAA=
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=T+x9y81YijoL4X34geQKg9LfpM1AO0cXQCWHNbPwm+Y=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebNnuB70WvP3AwefzqVNqq8fLk6eyMxk0DXxUV9qQ
 pC4gfDbjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiI7y1GhnX7HhzMvjOZYasz
 45V3vzZ6qDU5Hpy9+vGrq6steQ8aHz/P8D+/Zn40g2RHxA0+4TU/ItwN18f+zrFPTzt50e7HnIz
 FHmwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Hi all,

This is a huge series which promoted MIPS/Boston target into a
usable state, with fixes to drivers and general framework issues
I found in this process.

I also converted the target to OF_UPSTREAM.

This target is covered by QEMU, to test on QEMU:
```
make boston64r6el_defconfig
make
qemu-system-mips64el -M boston -cpu I6500 -bios ./u-boot.bin -nographic
```

This is my first u-boot contribution, please kindly advise if you
have any comments.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v3:
- Slight change in clk_boston probe order (Jonas)
- Link to v2: https://lore.kernel.org/r/20240516-boston-v2-0-77938800d1dd@flygoat.com

Changes in v2:
- Drop "[PATCH 09/13] syscon: Probe device first in syscon_get_regmap"
  in flavour of fixing the driver device life cycle (Jonas)
- Link to v1: https://lore.kernel.org/r/20240513-boston-v1-0-fac96938417e@flygoat.com

---
Jiaxun Yang (12):
      pci: xilinx: Handle size of ecam region properly
      pci: auto: Reduce bridge mem alignment boundary for boston
      pci: Enable PCI_MAP_SYSTEM_MEMORY when ARCH_MAP_SYSMEM is not set
      ahci: DMA addressing fixes
      ahci: dwc_ahsata: Generalize the driver
      MIPS: Provide dummy acpi_table.h
      MIPS: boston: Imply various options
      MIPS: boston: Provide default env vars
      clk: boston: Allow to get regmap from parent device
      dts/upstream: Add Makefile for MIPS
      MIPS: boston: Migrate to OF_UPSTREAM
      mailmap: Update email for Paul Burton

 .mailmap                           |   3 +-
 arch/mips/Kconfig                  |  28 +++++
 arch/mips/dts/Makefile             |   1 -
 arch/mips/dts/boston-u-boot.dtsi   |  10 ++
 arch/mips/dts/img,boston.dts       | 222 -------------------------------------
 arch/mips/include/asm/acpi_table.h |  10 ++
 board/imgtec/boston/Kconfig        |   4 +
 board/imgtec/boston/MAINTAINERS    |   3 +-
 board/imgtec/boston/boston.env     |   9 ++
 board/imgtec/malta/MAINTAINERS     |   2 +-
 configs/boston32r2_defconfig       |   2 +-
 configs/boston32r2el_defconfig     |   2 +-
 configs/boston32r6_defconfig       |   2 +-
 configs/boston32r6el_defconfig     |   2 +-
 configs/boston64r2_defconfig       |   2 +-
 configs/boston64r2el_defconfig     |   2 +-
 configs/boston64r6_defconfig       |   2 +-
 configs/boston64r6el_defconfig     |   2 +-
 drivers/ata/ahci.c                 |  34 +++---
 drivers/ata/dwc_ahsata.c           |  82 +++++++++-----
 drivers/ata/dwc_ahsata_priv.h      |   2 -
 drivers/clk/clk_boston.c           |  19 ++--
 drivers/pci/Kconfig                |  10 ++
 drivers/pci/pci_auto.c             |  16 +--
 drivers/pci/pcie_xilinx.c          |  53 ++++++---
 dts/upstream/src/mips/Makefile     |  14 +++
 include/ahci.h                     |   4 +-
 27 files changed, 232 insertions(+), 310 deletions(-)
---
base-commit: c8ffd1356d42223cbb8c86280a083cc3c93e6426
change-id: 20240513-boston-45ef6edc219f

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

