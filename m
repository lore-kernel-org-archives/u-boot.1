Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF830C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 12:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 354B982B66;
	Wed, 30 Apr 2025 14:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="w3DDis6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DFD82B11; Wed, 30 Apr 2025 10:33:44 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629FD8216C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
 :Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tF7w6GhdoisoFCrFMTeUwSzQCP3sgd7ftJ5IMlny+dc=; b=w3DDis6XxDZDK4Sc03Tbh6IGgA
 nMpOmwMAb0tqRGw04aCEIT7gvinI8+YZkByclQ5jPoYcRaVl5uWOxMyPzFPkSV9m8uyo3y26oqjfe
 AyzpV6VE1r/EIXYnJqGZm6QBa40F3Ars/RZ7cwzBItNFVCMvzmymMBwYsEGqn6ZoBeFQ3nDxbS3jX
 ELToJJmUIMMLmBHfYnfvcCUBnJNdo7+v/7CLwB5Ota72LGjj8/j5ALWTnjYMEXqHF2z/eJDq2tN34
 J00Y0nsG+vA3XbWe4hPI77DQTPvKaByy5aQZb6UhLsNYTI/IAqSTNUaS7c1T1/FqZqB9/Tiw2iKHC
 Ksl7Imgg==;
Received: from [178.38.100.64] (helo=[10.10.1.154])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uA2sq-003Xki-67; Wed, 30 Apr 2025 09:33:36 +0100
Message-ID: <952cffa1c1925f050b2fcefa539a23d389b6fb74.camel@codethink.co.uk>
Subject: Re: [SPAM][REGRESSION] [PATCH v6 0/3] Static initcalls
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Weijie Gao <weijie.gao@mediatek.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini	
 <trini@konsulko.com>, Stefan Roese <sr@denx.de>, Andre Przywara	
 <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, Sam Protsenko	
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Patrick
 Rudolph	 <patrick.rudolph@9elements.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  Caleb Connolly
 <caleb.connolly@linaro.org>
Date: Wed, 30 Apr 2025 10:33:34 +0200
In-Reply-To: <8212e069cefe4e2d24118469b8945dcf6e8c2266.camel@mediatek.com>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <18d1c97d9a420c40181352bf1445e2772d784d9a.camel@codethink.co.uk>
 <8212e069cefe4e2d24118469b8945dcf6e8c2266.camel@mediatek.com>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 (by Flathub.org) 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 30 Apr 2025 14:19:14 +0200
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

Hi Weijie

On Wed, 2025-04-30 at 15:11 +0800, Weijie Gao wrote:
> Hi Marcel,
>=20
> This regression is also found with mtk_eth driver and I've sent a patch
> to fix it:
>=20
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20250429020424.48795-1-w=
eijie.gao@mediatek.com/
>=20
> This patch should also fix the regression on rtl8169 driver

Yes, indeed. Thanks for spotting and fixing this :)

> BRs
>=20
> Weijie
>=20
> On Tue, 2025-04-29 at 23:52 +0200, Marcel Ziswiler wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > Hi Jerome
> >=20
> > On Fri, 2025-04-04 at 15:50 +0200, Jerome Forissier wrote:
> > > This series replaces the dynamic initcalls (with function pointers)
> > > with
> > > static calls, and gets rid of initcall_run_list(), init_sequence_f,
> > > init_sequence_f_r and init_sequence_r. This makes the code simpler
> > > and the
> > > binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and
> > > -510
> > > bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> > >=20
> > > Execution time doesn't seem to change noticeably. There is no
> > > impact on
> > > the SPL.
> > >=20
> > > The inline assembly fixes, although they look unrelated, are
> > > triggered
> > > on some platforms with LTO enabled. For example:
> > > kirkwood_defconfig.
> > >=20
> > > CI:=20
> > > https://urldefense.com/v3/__https://source.denx.de/u-boot/custodians/=
u-boot-net/-/pipelines/25514__;!!CTRNKA9wMg0ARbw!h0Wu3dmAIj7GcAAl7DMcs-OyDv=
xKbcP6QQh7EuYYFMB-6OkCPTOUSbqHhuFZWzgImuvWUmPQMzSAwU-I9YiHvwbrcTzq_ymldg$
> >=20
> > This series seems to cause a regression on rock5b. E.g. on today's
> > master:
> >=20
> > =3D> pci enum
> > =3D> setenv ipaddr 192.168.10.2
> > =3D> ping 192.168.10.1
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > No ethernet found.
> > failed to initialize card: -12
> > failed to initialize card: -12
> > ping failed; host 192.168.10.1 is not alive
> >=20
> > Seems the rtl8169 driver runs out of memory trying to allocate
> > descriptors?
> >=20
> > If I revert this series on top of today's master:
> >=20
> > =3D> pci enum
> > =3D> setenv ipaddr 192.168.10.2
> > =3D> ping 192.168.10.1
> >=20
> > Warning: eth_rtl8169 MAC addresses don't match:
> > Address in DT is=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:e0:4c:68:01:5a
> > Address in environment is=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fe:b1:db:=
60:25:69
> > Using eth_rtl8169 device
> > host 192.168.10.1 is alive
> >=20
> > I just completed the bisection and will now look into what exactly
> > could be going on.
> >=20
> > Any insights are much appreciated.
> >=20
> > Thanks!
> >=20
> > > Changes in v6:
> > > - Rebase on next branch
> > >=20
> > > Changes in v5:
> > > - Fix mistake in initcall_run_r():
> > > CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
> > > should have been !CONFIG_IS_ENABLED(...). As a result, several CI
> > > tests
> > > were failing. (Tom R.)
> > > - Restore fixes in test/py/tests/test_trace.py and
> > > arch/sh/lib/board.c
> > > which had unexpectedly disappeared from v4 and caused CI errors.
> > > - Fix CI error caused by wrong conditionals on the fix_fdt() call:
> > > =C2=A0 tools/buildman/buildman -o /tmp -seP powerpc
> > > =C2=A0 [...]
> > > =C2=A0 common/board_f.c:752:12: error: 'fix_fdt' defined but not used=
 [-
> > > Werror=3Dunused-function]
> > > - Add "arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is
> > > not set"
> > > to fix a build error with LTO detecting mcr/mrc instructions
> > > emitted in
> > > Thumb mode on a CPU that doesn't support it:
> > > =C2=A0 make sheevaplug_defconfig
> > > =C2=A0 make -j$(nproc) CROSS_COMPILE=3D"ccache arm-linux-gnueabi-"
> > > =C2=A0 [...]
> > > =C2=A0=C2=A0=C2=A0 LTO=C2=A0=C2=A0=C2=A0=C2=A0 u-boot
> > > =C2=A0 {standard input}: Assembler messages:
> > > =C2=A0 {standard input}:9241: Error: selected processor does not supp=
ort
> > > `mcr p15,1,r0,c15,c11,0' in Thumb mode
> > > =C2=A0 {standard input}:19196: Error: selected processor does not
> > > support `mrc p15,1,r3,c15,c1,0' in Thumb mode
> > > =C2=A0 {standard input}:19223: Error: selected processor does not
> > > support `mcr p15,1,r3,c15,c1,0' in Thumb mode
> > > =C2=A0 {standard input}:19241: Error: selected processor does not
> > > support `mrc p15,1,r3,c15,c1,0' in Thumb mode
> > > =C2=A0 {standard input}:19268: Error: selected processor does not
> > > support `mcr p15,1,r3,c15,c1,0' in Thumb mode
> > > =C2=A0 {standard input}:19286: Error: selected processor does not
> > > support `mrc p15,1,r3,c15,c1,0' in Thumb mode
> > > =C2=A0 {standard input}:19321: Error: selected processor does not
> > > support `mcr p15,1,r3,c15,c1,0' in Thumb mode
> > > =C2=A0 {standard input}:19341: Error: selected processor does not
> > > support `mrc p15,0,r3,c1,c0,0' in Thumb mode
> > > =C2=A0 {standard input}:19372: Error: selected processor does not
> > > support `mcr p15,0,r3,c1,c0,0' in Thumb mode
> > > =C2=A0 make[1]: *** [/tmp/ccu1wZWX.mk:11:
> > > /tmp/ccIab81n.ltrans3.ltrans.o] Error 1
> > >=20
> > > Changes in v4:
> > > - Fold all changes to board_init_*() into a single patch
> > > - Use '#if CONFIG_IS_ENABLED(FOO) INITCALL(init_foo) #endif'
> > > instead of
> > > 'CONFIG_IS_ENABLED(FOO, (INITCALL(init_foo);));' (Caleb C., Simon
> > > G.).
> > > As a consequence, drop Michal's patch ("common: board: Simplify
> > > array
> > > with function pointers with CONFIG_IS_ENABLED").
> > > - Rebase on next
> > >=20
> > > Changes in v3:
> > > - Use printf() rather than debug() to report initcall failures
> > > (Quentin S.)
> > > - initcall_run_f(): replace one erroneous call to WATCHDOG_INIT()
> > > with
> > > WATCHDOG_RESET() (Ilias A.)
> > > - Fix relocate_code() in arch/sh/lib/board.c to address CI failures
> > > with
> > > r2dplus (
> > > https://urldefense.com/v3/__https://lists.denx.de/pipermail/u-boot/20=
25-January/576213.html__;!!CTRNKA9wMg0ARbw!h0Wu3dmAIj7GcAAl7DMcs-OyDvxKbcP6=
QQh7EuYYFMB-6OkCPTOUSbqHhuFZWzgImuvWUmPQMzSAwU-I9YiHvwbrcTyRLPlZiw$
> > > =C2=A0)
> > > (Tom R.)
> > > - Add comments to initcall_run_f() and initcall_run_r() (Simon G.)
> > >=20
> > > Changes in v2:
> > > - INTICALL() and INITCALL_EVT() now call hang() immediately on
> > > error
> > > - Fixed typo: s/intcall_run_f_r/initcall_run_f_r/
> > >=20
> > >=20
> > > Jerome Forissier (3):
> > > =C2=A0 arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not =
set
> > > =C2=A0 common: board: make initcalls static
> > > =C2=A0 initcall: remove initcall_run_list()
> > >=20
> > > =C2=A0arch/arm/include/asm/system.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +-
> > > =C2=A0arch/arm/lib/cache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> > > =C2=A0arch/arm/mach-kirkwood/include/mach/cpu.h |=C2=A0=C2=A0 9 +-
> > > =C2=A0arch/sh/lib/board.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +-
> > > =C2=A0common/board_f.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 223 +++++++++---------
> > > -
> > > =C2=A0common/board_r.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 247 +++++++++++-------
> > > ----
> > > =C2=A0include/initcall.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 45 ++--
> > > =C2=A0lib/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> > > =C2=A0lib/initcall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 102 ---------
> > > =C2=A0test/py/tests/test_trace.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> > > =C2=A010 files changed, 295 insertions(+), 376 deletions(-)
> > > =C2=A0delete mode 100644 lib/initcall.c

Cheers

Marcel
