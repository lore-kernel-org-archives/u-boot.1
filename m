Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1D2C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FAA188489;
	Fri, 17 May 2024 18:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="jwqKytyD";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="FXWeXSSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0130881C5; Fri, 17 May 2024 18:33:01 +0200 (CEST)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07F688231
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id BBE1E11400CF;
 Fri, 17 May 2024 12:32:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 12:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715963577; x=1716049977; bh=F4
 lqn1vomJtK0MRoR7tPoscv/FkppsIQbsRw2yalp/Y=; b=jwqKytyDPn4968MryW
 M1zXCg30YWIVWNF1/e5bzZZueFIE4lVqiR6c98XkcrTA/6FTYKXWihC/p171rnLM
 CNySlfjsb7275UeF7A0xbTfPqkIL0iQyq0YkFiO9NX/0d1w06XHKXUShQuoiyK4R
 PbS21iCdHTr/KNdMNGJcRK/CIkT+3CdY26C5kO/49yx30KFXOcB6TAkdRf+Hx3pg
 sO9aBSSsUQVSvSkPA84wgdivWvoaVnO1ljZ/v2/cv6YjeeFMZOAZE3NGd99BYxQx
 kGgrbyMZ6GkiBw5zz+NPQ6ArrURO8SA1WbB9hDOTxOOKON6i2BBlma4mEjyBtbUL
 1x7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715963577; x=1716049977; bh=F4lqn1vomJtK0
 MRoR7tPoscv/FkppsIQbsRw2yalp/Y=; b=FXWeXSSB3kcZC6t4WE6vHaxD5cEzI
 xPPwj5/AJy7LZGIFAVsbgMllK0QYRY7y2Wavqcw/otQ6DVsntD/YL/8DOOJmNA6V
 Dsh0D1ZDa0grtO9ARiZNS7xFcIsw52k06LomqKtXedgxS67Wk/xDRoFzb5bP2MEy
 HuNIpc6i5XLI3WnvryKDyHSzA+eP9loZSp/gFYtAhJlgfDWq108+dzu5PFN7Crs1
 UOou/FoVetf80F2UODf4BLyW4/twJ81x3mPs6VhonJh8eTe0FLPqKM5BnRzKg3QP
 WMdtvX0CLRloW7a8IWBnoQu1Vp5XHBUTT24Ypd/ZSfrF5qOXyM0H6hiSQ==
X-ME-Sender: <xms:uYZHZtvSVGdnrE5yx3P8wZQrZqu7sGGm0CwcTQt3wx6jTGWzoOa1Sw>
 <xme:uYZHZmelaMjoUP3vxNVodZa6p1EIzIoku5smdIyGuAIvLxzpePYUwfUAJrjsQZJtG
 TNTxO2B4uvajOI9VKM>
X-ME-Received: <xmr:uYZHZgxPfR0Qc9cH-Z4b05e7pbrlzrd5YD9me-wX7Vxk8-EdWz84Vak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhephffufffkgggtgffvvefo
 sehtjeertdertdejnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrd
 ihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepheejvedutefh
 gfdvvdevueetieejffegtdejueegkeehleefhfelueeutefhtdehnecuffhomhgrihhnpe
 hgihhthhhusgdrtghomhdpkhhunhhluhhnthgvtghhrdgtohhmrdgtnhdpshhouhhrtggv
 fhhorhhgvgdrnhgvthdpvhgvnhhtohihrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomh
X-ME-Proxy: <xmx:uYZHZkPcUq8eAceEazrTfT4Ih8RPZ9lilIBq0EuQIchi_jYqlKZPuA>
 <xmx:uYZHZt--M3zi8M_0eYqFnnR4vfRJLlhzAVhiuN0QhHwEfZV5Ox1N9Q>
 <xmx:uYZHZkU7_zdQDMzw7_qotOTjEw0lnr6aLOOE8Y8lUPDcGXpFKHhxig>
 <xmx:uYZHZufLJRNuMRrhHEZKaJkmAi_Yuk2Bv1TZ1G9k1DdPcRijPwAWDg>
 <xmx:uYZHZtyk2Dwe5nYiMrn1B4sJX8L-dWg2gvnI3GsWgUvd-CM4KhStTSV->
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 12:32:56 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/7] MIPS: Enable EFI support
Date: Fri, 17 May 2024 17:32:51 +0100
Message-Id: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALOGR2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0Nz3dzMgmLd1LRM3WTLRMPEFAtDy2SjFCWg8oIioGgF2Kjo2NpaAAX
 GzHZaAAAA
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3267;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=IZmwzvmHoSS6StgQZCuCD4AJar9toORS9+SVZ3OsLZE=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3th2reLddP/hb6ZjSniXiRasD5tg31+zTP14uY/v0l
 vpMxmmxHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRoBxGhodc9f7rskLaHWwD
 avf4xaf7L7fR0rzfsSqt4q0n7/llcQx/ZZ6Z/NH7FeBSbn16WeiBPxa1VYcXMS4713v/fQWnVNZ
 fXgA=
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

This series enabled EFI support to MIPS platform.

Although MIPS is not defined by UEFI specification, there are
quite a few firmware implementations available, including
MIPS-EFI[1] for Loongson-2F, Lemote's proprietary EDK2 implementation
on Loongson-3[2], Kunlun firmware for Loongson-3[3], efiffy[4]
for MIPS Creator CI20 and another mystery EDK implementation shipped
with some Creator CI20 board.  

Available applications including gnu-efi, Loongson's GRUB fork[5],
Ventoy[6].

My implementation in U-Boot is aiming to follow conventions made
by other implementations for architecture stuff and remain
compliance with spec for general aspects.

bootefi hello and selftest passed on both 32 and 64 bit system,
gnu-efi, grub and ventoy are tested on mips64el with my pending
platform works. mips32el efi executable from efiffy is tested
as well.

Please review.
Thanks

[1]: https://github.com/kontais/EFI-MIPS
[2]: https://github.com/loongson-community/firmware-nonfree
[3]: http://www.kunluntech.com.cn/klbiosxl
[4]: https://sourceforge.net/projects/efify/
[5]: https://github.com/loongson-community/grub
[6]: https://www.ventoy.net/en/index.html

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (7):
      MIPS: Implement setjmp
      efi: Allow runtime relocate to be disabled
      Makefile.lib: Preserve .rodata section for EFI file
      Makefile.lib: Enforce EFI CFLAGS/AFLAGS
      MIPS: Add smbios_start to arch_global_data
      MIPS: Define MIPS EFI related bits everywhere
      MIPS: Implement EFI supporting stuff

 Makefile                                          |   3 +
 arch/mips/config.mk                               |   9 +
 arch/mips/include/asm/global_data.h               |   3 +
 arch/mips/include/asm/setjmp.h                    |  36 ++++
 arch/mips/lib/Makefile                            |  15 ++
 arch/mips/lib/crt0_mips_efi.S                     | 239 ++++++++++++++++++++++
 arch/mips/lib/elf_mips_efi.lds                    | 113 ++++++++++
 arch/mips/lib/reloc_mips_efi.c                    |  99 +++++++++
 arch/mips/lib/setjmp32.S                          |  51 +++++
 arch/mips/lib/setjmp64.S                          |  56 +++++
 include/asm-generic/pe.h                          |   5 +
 include/config_distro_bootcmd.h                   |   6 +
 include/efi_default_filename.h                    |   8 +
 include/efi_loader.h                              |  26 ++-
 include/elf.h                                     |   8 +
 lib/efi_loader/Kconfig                            |  12 +-
 lib/efi_loader/efi_image_loader.c                 |  18 ++
 lib/efi_loader/efi_memory.c                       |  14 +-
 lib/efi_loader/efi_runtime.c                      |  11 +-
 lib/efi_loader/efi_var_mem.c                      |   6 +-
 lib/efi_selftest/Makefile                         |   2 +-
 lib/efi_selftest/efi_selftest_miniapp_exception.c |   2 +
 scripts/Makefile.lib                              |  10 +-
 23 files changed, 734 insertions(+), 18 deletions(-)
---
base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
change-id: 20240517-mips-efi-c9a1ad819c2d

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

