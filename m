Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600D6C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3E28888E;
	Wed, 22 May 2024 19:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="lUuoW3R6";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgXH1qMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E918888B; Wed, 22 May 2024 19:08:06 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1231988856
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id D1DFF1C0017A;
 Wed, 22 May 2024 13:07:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 22 May 2024 13:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1716397679; x=1716484079; bh=te
 9upT+j+vvDr4Ne7BZhAqkufyPFiV3tgVvGbAdMEPU=; b=lUuoW3R6mrwNvE+oSU
 BOXuuu0WcseUM3XXwUe1eFLS1OWeHfL8pgDLgNpBuM1/BXxfycrtmlgXmC2Xx+G5
 5jYnJ8jYWoi3ZEhjPin4YykJKC7Q4TsPEiG+9LnTWqtx/J34dhtG6Pwgo5FxH9+7
 YN+K7Lb1BIxYXceIXCqt+qrbkIzYncqAb3Wg+alIIo4A8TYJ2phbWuLPOpvhOSvG
 jUjPaMmk57cce1372qH1/7EsdBNBiHFihnMD3dFmEtgo+AtG20Fah/o5bKl96P5g
 Pz7VxrGzWB5s3EE6wXHA+YNEK0z1iPMmQpbRi3tjfRBIJIEbvXZANdXrD9rMWz6Q
 aYSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1716397679; x=1716484079; bh=te9upT+j+vvDr
 4Ne7BZhAqkufyPFiV3tgVvGbAdMEPU=; b=pgXH1qMNtxfY1gJuhA2Ok51Nb2Ezg
 Vm2ZNK1G3mTCAVrmjc7cdNDHl3LipUtwoArKHLutxl0uaaQIW6aLX1a1Gp7R/CzZ
 ykcRwh1jUdL4g0GfyjTnN9VCOB7iWzkNGPqi5iJf8/aQXaSW1guDHORbGUijBUv3
 Sjpk1JfflyALfjkNSVvdmN9Pvo8Ob4c8RAShXU5C1DmmafbljnnwbchZSpIl8qPs
 qNLoPpmr5OVKJSiB2z2yRqVf6zECC0leuUofAtJnDs486MwKrJ6JS5UPEfigv6lG
 SMz76aU0rDLXZayKyVH2cLcZM5uzQpUWr0gMMcAN2ed+2KRjydNS7jG7Q==
X-ME-Sender: <xms:biZOZkrF0OWVSkaeFenFQ6xMdjfw62I_TFJRsrybNhAuIZhAEN_xiQ>
 <xme:biZOZqqYUr8j3Lyqb16N0OO1hrNF19zRg2O6X5tPEFnL_uts010-brnJ_qZO7Wqof
 ffZ8e4dltFJRu_HZ64>
X-ME-Received: <xmr:biZOZpMUbMuZn4op4LsBe5O0xSDbOF8Mwa1m6_qU7gpxcClUNvq9VoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepudeglefhudegveefveegvdejtdevfeffiedtudfgudeliefgjefh
 veeuudeiueeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorh
 hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:biZOZr5A6G3I6iSbqBfekWgiBngu6uuyV7o649g4XIsV84RPvwqesg>
 <xmx:biZOZj4JeiUSVFMbbBcefkjJW0kUMJN1BPlP-E0JohpIQCG7cTvX4w>
 <xmx:biZOZrg_UmNMCbYw369KIlEpqdTYm0PqIEQ8X2aQSkFOYU2RKcbvvw>
 <xmx:biZOZt4Cgu_TD42hTQWFBNd9dxEE-GICTTzOeaEXOt1HAJ0byQA7_A>
 <xmx:byZOZgsRgsxh1vsq_EZFRj9ZGc4Kan3ZFNFluYJK7w4OcqR44DCdNLrP>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:07:58 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 00/10] xtensa: Enable qemu-xtensa board
Date: Wed, 22 May 2024 18:07:56 +0100
Message-Id: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGwmTmYC/23MQQ7CIBRF0a00fywGCERx5D5MB4CflsSCBWzaN
 Oxd7Njhfck7O2RMHjPcuh0SLj77GFrwUwd21GFA4p+tgVMuqGSKzDh9yFowZE2kM0oaIy4CFbT
 HO6Hz66E9+tajzyWm7cAX9lv/OwsjlFydc9QaxixTd/fahqjL2cYJ+lrrF4dtBPioAAAA
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=E4XboVhaDh9+KTyPTzm6cJRHjvgsr5qI94POjqGEWtY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tTxRKTOhMnWXeYWst89P8KjOF0ndw7f4yYTNV7daX
 heSVZTsKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIk8fMnw3//B1iDe3ycT7I5M
 /ye4300+9u6uyomdaucLxeL0dX+HTmNk+PLcpI2jqihYnmlS8dujkh9Pb4r3mnbgdx7/y+VuE90
 TGAE=
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
Changes in v2:
- Fix noMMU memory mappings
- Addressing Max's comments in other patches
- Link to v1: https://lore.kernel.org/r/20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com

---
Jiaxun Yang (10):
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
 board/emulation/qemu-xtensa/Kconfig              |  42 ++++++++
 board/emulation/qemu-xtensa/MAINTAINERS          |   8 ++
 board/emulation/qemu-xtensa/Makefile             |   5 +
 board/emulation/qemu-xtensa/qemu-xtensa.c        |  60 ++++++++++++
 configs/qemu-xtensa-dc232b_defconfig             |  32 +++++++
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
 27 files changed, 778 insertions(+), 7 deletions(-)
---
base-commit: 3be9f399e911cfc437a37ac826441f1d96da1c9b
change-id: 20240519-qemu-xtensa-5fb95bb474e9

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

