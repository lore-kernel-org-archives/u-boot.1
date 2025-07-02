Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38255C77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 20:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1976382E08;
	Wed,  2 Jul 2025 22:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5252882ADA; Wed,  2 Jul 2025 19:13:45 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD3181FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 19:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7d20f799fe9so782585585a.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 10:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751476421; x=1752081221;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sCLOxVCqesDm2qpma1f1hAvdZOu1QKpwGUn6TuTV7T0=;
 b=dJDGtM6WaXiqx1BVeCo8NzZFQ0F+8kmNcY0cLTFsf4i/bJfXrpVRvO7VO0Ht35+OgE
 EAh/9T9gm209tqatuW51Ilq61MrN02MouZvo+kyX6DjEB0jtP6/faEun67d3ngzpDi9d
 ifHQ5cgmoKIQHxHtESkZ3mYKPjEBvW7HxvGR0zeNOhrN8MYhl72rnAAyA0aMBXvD1btG
 lrMWgGKK9xorZrncE0FQXQEP+M59mBYLVo+GDUtDaXem9RS54625J0ISMIoA9mUigl8K
 L5nRFKrr6+I4SQ6hoJHvL/Eg/fIxmOoKSvELG7P/EkN5GgBR449Bsy+4k6wrW7u+lrTB
 dKDA==
X-Gm-Message-State: AOJu0YxXauZKMJWBa/2aR2g15RN+W7zuIA1rJhmj6m83lrWC1BhFkxMt
 1x9Tx6bqT8jIyJHHwx4qerh82HWAALG8NDyOXBVijrsAsqxFZ2+reZvp6DXO8y/q
X-Gm-Gg: ASbGncvSyXOUIZVgNwf1UOU38tipMmPx+4yb7L6xNCa/s3t4BT9oyREAnVqDxa/+umt
 2nLyYvR0mjOC+uPnUv+YA4COlRDhhUt0MYboVkj7gAXK/ZrwcvhDrtxuLf+BF+kJw089euXToLU
 ycjLXJ9syo8xKII2bIuqJ5CF8AhcGfqBcbpb+zssr7Sfgh95CQ3yZ886KtLJnKkWc6w/dlFimyw
 M6yFNIFKlUd4CjMdmm+JQ+X0zp9E8ahNNOHnoetRh8wJr5B2ulvdW3/0zSpn3Pgx9BUafSfVrSy
 1j1YUXryK1MiFeNIR04ZKuNaYsupvJmUc4Ht5D6oHvX9AXNzs+b4SlXNFeo7mOinmpuBJIH6zt3
 KvfOHRt9qHkGN
X-Google-Smtp-Source: AGHT+IFgL6Du9Xaunh577Wtvydi60XFGcPi59ktkotZNaH4Kmv0+Mo7v0gmt1a9BRwOvtZhKZ8ijzA==
X-Received: by 2002:ad4:5fcf:0:b0:6fa:a4ed:cce5 with SMTP id
 6a1803df08f44-702b1c1ddfamr48968336d6.44.1751476421533; 
 Wed, 02 Jul 2025 10:13:41 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44313926asm966749885a.22.2025.07.02.10.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 10:13:41 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, Magnus Damm <damm@opensource.se>,
 marek.vasut+renesas@mailbox.org, geert+renesas@glider.be
Date: Wed, 02 Jul 2025 19:13:38 +0200
Message-Id: <175147641895.69121.4718662283609078812.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v2 0/2] Initial r7s72100 Genmai board support
X-Mailman-Approved-At: Wed, 02 Jul 2025 22:17:46 +0200
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

Initial r7s72100 Genmai board support (V2)

[PATCH v2 1/2] ARM: renesas: Put common r7s72100 code in board/renesas/common
[PATCH v2 2/2] ARM: renesas: Add support for the r7s72100 Genmai board

These two patches for U-Boot aim at adding initial support for the
Genmai board which is based on the r7s72100 (RZ/A1H) SoC from Renesas.

The first patch takes SoC specific code from the GR-Peach board and
breaks it out into the board/renesas/common directory so it can be
easily shared between GR-Peach and Genmai.

The second patch adds board specific details for the Genmai board.

There is nothing out of the ordinary with this board or this board code,
however please note that the external SDRAM (hooked up to CS2/CS3) to the
r7s72100 on the Genmai board remains unconfigured at this point. Because of
this the U-Boot Genmai board code is instead making use of the 10 MiB on-chip
RAM available in the r7s72100 SoC. The upstream DT for the Genmai board is
however describing the external SDRAM memory banks as expected from a Linux
point of view, and to "make it work" the memory bank configuration in U-Boot
today is not using DT to describe the memories.

Once SDRAM configuration code gets added as an incremental patch the memory
configuration code can be easily switched over to use DT by adjusting the
number of memory banks in the defconfig and updating the dram_*() functions.

Thanks to Chris Brandt for the older out of tree board code, Marek Vasut
for the upstream GR-Peach board code, the pinctrl-rza1.c driver and a bunch
of fixes and changes that have been rolled into these patches.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to u-boot git cbb5672790d400e9ec6e9fceaf89ece2660c0117 (origin/next)
  and
 https://patchwork.ozlabs.org/project/uboot/list/?series=463012
 https://patchwork.ozlabs.org/project/uboot/list/?series=463013

 arch/arm/dts/Makefile                     |    1 
 arch/arm/dts/r7s72100-genmai-u-boot.dtsi  |   32 ++++++++
 arch/arm/mach-renesas/Kconfig.rza1        |    4 +
 board/renesas/common/Makefile             |    8 ++
 board/renesas/common/rza1-common.c        |   27 +++++++
 board/renesas/common/rza1-lowlevel_init.S |  106 +++++++++++++++++++++++++++++
 board/renesas/genmai/Kconfig              |   12 +++
 board/renesas/genmai/MAINTAINERS          |    5 +
 board/renesas/genmai/Makefile             |    7 +
 board/renesas/genmai/genmai.c             |   49 +++++++++++++
 board/renesas/grpeach/Makefile            |    1 
 board/renesas/grpeach/grpeach.c           |   22 ------
 board/renesas/grpeach/lowlevel_init.S     |  106 -----------------------------
 configs/genmai_defconfig                  |   17 ++++
 include/configs/genmai.h                  |   15 ++++
 15 files changed, 283 insertions(+), 129 deletions(-)
