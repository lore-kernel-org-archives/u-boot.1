Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAE4D3EE6B
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 14:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55DD7839DF;
	Thu, 22 Jan 2026 15:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="f8ftQwIY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D528397D; Thu, 22 Jan 2026 15:44:03 +0100 (CET)
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com
 [136.143.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F218397D
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1769093026; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TSvDeQhjEzKjg7KeB6sekD/EUC4NMP0wpZvz142/EzceX6kfkP24B7zh8jvBCp9WuPTSmYERejhYEPvQi8b/KvblZG4wELbZTdo8zlB7Io34lILRloP8Uy8M+NOKca7Tso75ciqFB2VGavWWVU3xs9Arf7fECIkj2hMnwWhAJsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769093026;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AbMVSg1M2JptVbZ3/CxE3xZokZM2vJ5AT85bxJjzzGQ=; 
 b=ZKIfj/rKR92ZlXwEMCVMle66qMexn+VoeivUDo+jdGapwDGwSkbsGExUsL05qDLFQehC2S5uWCHI8PfSFcek8JfNCcShTo5Ejsr3b0JAI4+BnP+B8gRJ5R/NePM1aEm1ryHKY2Snwn2PcMmHMpxcSn2NWx8SVKGv8dCw0Yo8LIg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769093026; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=AbMVSg1M2JptVbZ3/CxE3xZokZM2vJ5AT85bxJjzzGQ=;
 b=f8ftQwIYrJv6yrJQDrIB9dhuoj0WrIiaBIXg8O58e4Qe1q1SKn7NP2T6qrIof/Hb
 1qX42c90yzXwAdGa4sdX5sKxxTZb9dKjgJpqWZx9qlFaghsfdnJoOiBwy7bmhz6b5UZ
 7ObcndkieoiLo4rQZF90Uu+3Ngs7EHF6Blbo8mH4=
Received: by mx.zohomail.com with SMTPS id 1769093023630263.2303800352968;
 Thu, 22 Jan 2026 06:43:43 -0800 (PST)
Date: Thu, 22 Jan 2026 14:43:29 +0000
From: Yao Zi <me@ziyao.cc>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com,
 Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 14/17] spacemit: k1: Add DDR firmware support to SPL
Message-ID: <aXI3kc8t9bPRmnkM@pie>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-15-raymondmaoca@gmail.com>
 <aWyryi4ZPNgNIejE@pie>
 <CAMDkj5yGNxL0Hkw5k0Kae=SjPb51Bu9T0M60Dpaj5OVckN3R1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMDkj5yGNxL0Hkw5k0Kae=SjPb51Bu9T0M60Dpaj5OVckN3R1g@mail.gmail.com>
X-ZohoMailClient: External
X-ZohoMail-Owner: <aXI3kc8t9bPRmnkM@pie>+zmo_0_me@ziyao.cc
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

On Wed, Jan 21, 2026 at 06:24:01PM -0500, Raymond Mao wrote:
> Hi Yao Zi,
> 
> On Mon, Jan 19, 2026 at 4:41 AM Yao Zi <me@ziyao.cc> wrote:
> 
> > (My mail provider complains about the huge list of recipients, so I
> > reduced it a little.)
> >
> > On Sat, Jan 17, 2026 at 02:01:48PM -0500, Raymond Mao wrote:
> > > From: Raymond Mao <raymond.mao@riscstar.com>
> > >
> > > Include DDR initialization firmware in the SPL image. The firmware
> > > path can be specified via the DDR_FW_FILE environment variable. If
> > > the firmware is not found, an empty placeholder file is created to
> > > allow the build to proceed without DDR initialization support.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > ---
> > >  arch/riscv/dts/k1-spl.dts      |  34 ++++++++++++++++++++++++++++++++-
> > >  board/spacemit/k1/Kconfig      |   8 ++++++++
> > >  board/spacemit/k1/Makefile     |  19 ++++++++++++++++++
> > >  board/spacemit/k1/spl.c        |  30 +++++++++++++++++++++++++++++
> > >  include/configs/k1.h           |   3 +++
> > >  lib/vendor/spacemit/ddr_fw.bin | Bin 0 -> 19416 bytes
> >
> > It's unusual to ship binary firmware in U-Boot repository. Please place
> > the firmware somewhere else, and give a clear instruction in the
> > board/architecture documentation explaining how to obtain/build it.
> >
> > >  6 files changed, 93 insertions(+), 1 deletion(-)
> > >  create mode 100644 lib/vendor/spacemit/ddr_fw.bin
> >
> > ...
> >
> > > diff --git a/board/spacemit/k1/Kconfig b/board/spacemit/k1/Kconfig
> > > index 9f9c806d00d..a5fa788f660 100644
> > > --- a/board/spacemit/k1/Kconfig
> > > +++ b/board/spacemit/k1/Kconfig
> > > @@ -15,6 +15,14 @@ config SYS_CONFIG_NAME
> > >  config TEXT_BASE
> > >       default 0x00200000
> > >
> > > +config SPL_DDR_FIRMWARE_OFFSET
> > > +     hex "DDR firmware offset in SPL image"
> > > +     depends on SPL
> > > +     default 0x20000
> > > +     help
> > > +       Offset where DDR firmware should be placed in the SPL
> > > +       image.
> > > +
> > >  config SPL_OPENSBI_LOAD_ADDR
> > >       default 0x00000000
> > >
> > > diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
> > > index 7bce47bac8c..ebe6e55867c 100644
> > > --- a/board/spacemit/k1/Makefile
> > > +++ b/board/spacemit/k1/Makefile
> > > @@ -5,3 +5,22 @@
> > >
> > >  obj-y := board.o
> > >  obj-$(CONFIG_SPL_BUILD) += spl.o
> > > +
> > > +DDR_FW_SRC ?= $(DDR_FW_FILE)
> > > +FW_TARGET = $(srctree)/lib/vendor/spacemit/ddr_fw.bin
> > > +
> > > +DDR_FW_HEADER = $(objtree)/include/generated/ddr_fw_info.h
> > > +
> > > +$(obj)/spl.o: $(DDR_FW_HEADER)
> > > +
> > > +$(DDR_FW_HEADER): $(FW_TARGET)
> > > +     @echo "/* DDR firmware info - $$(date) */" > $@
> > > +     @if [ -f "$(FW_TARGET)" ]; then \
> > > +             SIZE=$$(stat -c%s "$(FW_TARGET)" 2>/dev/null || echo 0); \
> > > +     else \
> > > +             SIZE=0; \
> > > +     fi; \
> > > +     echo "#define DDR_FW_FILE_SIZE  $$SIZE" >> $@
> > > +     @echo "/* Note: Update ADDR if binman layout changes */" >> $@
> > > +
> > > +clean-files += $(FW_TARGET) $(DDR_FW_HEADER)
> >
> > Please make use of existing binman[1] facibilities to avoid the extra
> > Kconfig and Makefile pieces. binman_sym() could be used for obtaining
> > both size and offset of a binman entry.
> >
> > It doesn't work at all in SPL. I checked the binman symbol table
> that was totally empty.

I've tried commit fd871fc6bb49 ("pinctrl: mediatek: mt8365: add PUPD
registers") with th1520_lpi4a_defconfig, and
drivers/ram/thead/th1520_ddr.c, which makes use of binman_sym(), does
work.

This suggests binman facilities do work on RISC-V, at least after the
last time when I fixed it[1]. Are you testing on a U-Boot version
earlier than v2025.07? Otherwise there's likely something (configuration
or code) wrong on your side.

btw, every first line of your replied paragraphs has the wrong level of
quotes, which is a little confusing.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/20250416162533.1396-1-ziyao@disroot.org/
