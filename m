Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC24C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5051D88137;
	Tue, 18 Jun 2024 15:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="mpD8X5h2";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="EE7yaTqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 332C987CDA; Tue, 18 Jun 2024 15:56:26 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96A18786C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id 2B6AA18000CC;
 Tue, 18 Jun 2024 09:56:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 18 Jun 2024 09:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1718718977; x=1718805377; bh=1O
 N7kH3hVQN9MypXoYOZY2kh/y2dAFyeI76DvaJxoxY=; b=mpD8X5h28GCSxVafr5
 jqDeFUF28Y4nhhO6s+qjCm7OPxHA/kRGZjtP96GaAkPRO8uGH5xAn+Se7pUYD+bx
 8JNanklzR3Lkd+J7n5KlzEUo4bXMmpN+Pmvl1D7gVP6rIyRllsWvCL1IoePNFaJm
 cH1/8TXEzw5tZA7tGlxt4T45xMi6ZI9BXt2u26QCJpMXxbUI5/enN0n85xv/mnTP
 bIRiMwraP4bU4CpojxJamT1fAQVg+jvCpsejoyV+hmSaXXfdz73GbIIE1SwWCiV/
 jH0Hl+6j07NHKquxAvnijl83XobEI5IRhY0IlY5cy4Rdp6eF/4pGaPfChjSMjsjZ
 1j+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1718718977; x=1718805377; bh=1ON7kH3hVQN9M
 ypXoYOZY2kh/y2dAFyeI76DvaJxoxY=; b=EE7yaTqFUTdi9xZsCiKv7vs9ZB+V6
 WbwoD0PKMoE0rmnJxEZ0X2UOIFwdcP5tKkESGgpEEleKMpkVATuopBl5b5AJ+GUr
 zp9ZxiV0rwrV0sUCuSkcHC/2Qb36s8bBs+3yiXiydC2c/FzPEIaLAf/4emSZkSCq
 7b7cYgxJWTV4vbVy1/oVPxNGvjHyiLXCWj4H/mh1e55bBwOje6/1f5cQepfE/Jny
 WeIko+s1Yni1FyoH6XzJf0sVlk22mhCy5ksfn7FoHJzb22YgrQ5e4o8w+mvL62gj
 bGAupCSSbH5JrUtYyOVR9zZpcMAUnB55oBglhf5Jitk7wSOVvorZULv0A==
X-ME-Sender: <xms:AZJxZoIaNytEBWoBgkySDzfq1libRlCXcHVQq74vPLKe4SFrUVwZEg>
 <xme:AZJxZoIxFVwEOd-BvXYs-4qjxYSU_ABZg0TwermTzkcpk_FWDMplpDZ5dUTqQ5A2T
 -MkFFTgB5qZNRsVUwI>
X-ME-Received: <xmr:AZJxZos4uZad3ohJtLTjF3QIA3lCyim-gL3EvFax3ePngiBgSUB5p2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepudeglefhudegveefveegvdejtdevfeffiedtudfgudeliefgjefh
 veeuudeiueeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorh
 hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:AZJxZlZhsYSyyof6RdwmoLXrU7459HdpxkleAW5VJhvONL9GkkPdkw>
 <xmx:AZJxZvZ5hWjec6CbdTWN-9Va7d7eopLz-a-GPhFBZnjWqueQFEBylQ>
 <xmx:AZJxZhCOFrAk0oDQZ1ROimtIcP0shKs34_atgNEwWk47ZnmohlrGjA>
 <xmx:AZJxZlZumobwN4zmfQc2Fs1MxT0pKRqXM2e1JokXdVgKWmAg2BZkpA>
 <xmx:AZJxZkMkiNVYepSbZxWIJ1KvfCjppVqCFBZ7s71v8mIl7pBFvIHoNGsO>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:16 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 00/12] xtensa: Enable qemu-xtensa board
Date: Tue, 18 Jun 2024 14:56:00 +0100
Message-Id: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPCRcWYC/23MQQ6CMBCF4auQWVvTjiVYV97DuKB1Ck2EaosNh
 HB3CytJXL6XfP8MkYKjCJdihkDJRef7PE6HAkxb9w0x98gbkKPkpVDsTd2HjQP1sWal1arUWla
 SFGTxCmTduNVu97xbFwcfpi2exPr+7yTBODtba7nRQhihrvY5Nb4ejsZ3sJYS/mjEvcasudS2I
 olacL3Xy7J8AQ2RKwTmAAAA
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3750;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=OqiIU+QqzOTNOuvPOEgt08zrGkqGLERsinBomMvYP7U=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYzfmNk2vPuy1iUtRETjc7ThlGTdyXW3Mv5LVXyY8
 9M2Mle0o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACby5TUjw/xn98/Pt58gU+My
 4dlB0xB1cb3toTm6n9aL75UyWnhNvJiR4e+iFOngJYdUk0xNe7JzuPp2lO7bmvp/r42DUdSTS9k
 n+QE=
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

This series enabled qemu-xtensa board.

For dc232b CPU it needs to be built with toolchain[1].

This is a side product of me investigating architectures
physical address != virtual address in U-Boot. Now we can
get it covered under CI and regular tests.

VirtIO devices are not working as expected, due to U-Boot's
assumption on VA == PA everywhere, I'm going to get this fixed
later.

My Xtensa knowledge is pretty limited, Xtensa people please
feel free to point out if I got anything wrong.

Thanks
[1]: https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc232b-elf.tar.gz

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v3:
- Wire up CI
- Switch to dc233c CPU, which does not have PA != VA issue, to get CI
  pass first.
- Link to v2: https://lore.kernel.org/r/20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com

Changes in v2:
- Fix noMMU memory mappings
- Addressing Max's comments in other patches
- Link to v1: https://lore.kernel.org/r/20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com

---
Jiaxun Yang (12):
      xtensa: Move dram_init to xtfpga board file
      xtensa: Correct define of _end symbol
      xtensa: Implement phys virt conversion for PTP_MMU
      xtensa: Define PLATFORM_ELFFLAGS
      xtensa: Bring in semihosting headers and config options
      drivers: serial: Add xtensa semihosting driver
      drivers: cpu: Add xtensa CPU driver
      dts/upsteam: Add Makefile for xtensa
      board: emulation: New board qemu-xtensa
      doc: New documentation for qemu-xtensa
      ci: Wire up qemu_xtensa_dc233c
      [NFC]: CI Changes

 .azure-pipelines.yml                             |   5 +-
 .gitlab-ci.yml                                   |   6 ++
 arch/xtensa/Kconfig                              |  32 +++++++
 arch/xtensa/config.mk                            |   6 ++
 arch/xtensa/cpu/cpu.c                            |   5 -
 arch/xtensa/cpu/u-boot.lds                       |   2 +
 arch/xtensa/dts/virt-u-boot.dtsi                 |  17 ++++
 arch/xtensa/include/asm/addrspace.h              |   2 +
 arch/xtensa/include/asm/io.h                     |  32 +++++++
 arch/xtensa/include/asm/ldscript.h               |   1 -
 arch/xtensa/include/asm/platform/simcall-gdbio.h |  34 +++++++
 arch/xtensa/include/asm/platform/simcall-iss.h   |  73 ++++++++++++++
 arch/xtensa/include/asm/platform/simcall.h       | 110 +++++++++++++++++++++
 board/cadence/xtfpga/xtfpga.c                    |   5 +
 board/emulation/qemu-xtensa/Kconfig              |  43 +++++++++
 board/emulation/qemu-xtensa/MAINTAINERS          |   8 ++
 board/emulation/qemu-xtensa/Makefile             |   5 +
 board/emulation/qemu-xtensa/qemu-xtensa.c        |  60 ++++++++++++
 configs/qemu-xtensa-dc233c_defconfig             |  32 +++++++
 doc/board/emulation/index.rst                    |   1 +
 doc/board/emulation/qemu-xtensa.rst              |  33 +++++++
 drivers/cpu/Kconfig                              |   6 ++
 drivers/cpu/Makefile                             |   1 +
 drivers/cpu/xtensa_cpu.c                         | 117 +++++++++++++++++++++++
 drivers/serial/Kconfig                           |  18 +++-
 drivers/serial/Makefile                          |   1 +
 drivers/serial/serial_xtensa_semihosting.c       |  92 ++++++++++++++++++
 dts/upstream/src/xtensa/Makefile                 |  14 +++
 include/configs/qemu-xtensa.h                    |  36 +++++++
 29 files changed, 789 insertions(+), 8 deletions(-)
---
base-commit: 3be9f399e911cfc437a37ac826441f1d96da1c9b
change-id: 20240519-qemu-xtensa-5fb95bb474e9

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

