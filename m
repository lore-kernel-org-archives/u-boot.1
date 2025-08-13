Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC47CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 11:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336A883236;
	Wed, 13 Aug 2025 13:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="dOZUvYhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA5B8338D; Wed, 13 Aug 2025 13:16:17 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365F182ADA
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sputnik@on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 s=protonmail3; t=1755083773; x=1755342973;
 bh=K1eofIrc4hWKRshWPcLPjJJqolGlzIhNLypFBHBkTrg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dOZUvYhn9zED3KcqZyi61WbE/4BVWq5SZmELvVCEU6eQYHK8+Lv8h3KNjY3oW1pBh
 XQHE8VSiV2pajsWaEBet2MOSQ5NST+p0PkZdN5tJu3/Lsz6VDqP+S+i/uT9/wOO1fg
 U7kRWFQlsCkAVYyrbFOgQ95PVTuTotE1yRI5xkHcWtx9lpIQnL6sv7Iwz1qBJmErG8
 54V9sZS2zpq2cki7nj525w5ck2feEuGVS56WC5KaeuK+cio62aa3+bIdMYx7UdYwoj
 V6wvKxOy67nNHsjCjhsyLkq3+XTM9uswiTH+mU1kZgkEfu0ieaQTPPGPLUdpOTYd2A
 iIU+OxAKrTakQ==
Date: Wed, 13 Aug 2025 11:16:09 +0000
To: Leo Liang <ycliang@andestech.com>
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, rick@andestech.com,
 heinrich.schuchardt@canonical.com, ben.dooks@codethink.co.uk,
 jamie.gibbons@microchip.com, michal.simek@amd.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <uJi-tonJnS-rzzWk93UNmq_US0NLjQsxtmcyv7P-18bETLOaqQX28xSPPDbohOwyUPGbRKqfscsqd1-L1pXS6saFXdmMMIu62cVeWPddF94=@on-the-web.ch>
In-Reply-To: <aJw3OPPRV8ZZosNR@swlinux02>
References: <aJr1oclCSUMcK3bb@swlinux02>
 <20250812152224.GT124814@bill-the-cat> <aJw3OPPRV8ZZosNR@swlinux02>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 4e56d3abd26c46f1a1350608c23c180f340e5106
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------efce03c002d31744fcb5011dc4bf8660898734b110a847d38e42454f625198c2";
 charset=utf-8
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------efce03c002d31744fcb5011dc4bf8660898734b110a847d38e42454f625198c2
Content-Type: multipart/mixed;boundary=---------------------105dd0a8260b56fea63e573f6972cdec

-----------------------105dd0a8260b56fea63e573f6972cdec
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Wednesday, August 13th, 2025 at 8:58 AM, Leo Liang <ycliang@andestech.c=
om> wrote:

> On Tue, Aug 12, 2025 at 09:22:24AM -0600, Tom Rini wrote:
> =


> > [EXTERNAL MAIL]
> =


> > Date: Tue, 12 Aug 2025 09:22:24 -0600
> > From: Tom Rini trini@konsulko.com
> > To: Leo Liang ycliang@andestech.com
> > Cc: u-boot@lists.denx.de, rick@andestech.com,
> > heinrich.schuchardt@canonical.com, ben.dooks@codethink.co.uk,
> > jamie.gibbons@microchip.com, sputnik@on-the-web.ch, michal.simek@amd.c=
om
> > Subject: Re: [GIT PULL] u-boot-riscv/master
> > =


> > On Tue, Aug 12, 2025 at 04:04:49PM +0800, Leo Liang wrote:
> > =


> > > Hi Tom,
> > > =


> > > The following changes since commit acfacf452441d0a659e3afbd55fd6061a=
a17e647:
> > > =


> > > Prepare v2025.10-rc2 (2025-08-11 13:47:46 -0600)
> > > =


> > > are available in the Git repository at:
> > > =


> > > https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> > > =


> > > for you to fetch changes up to bddcd6bcba081aaaaafe30d1b8f9f3c83f069=
bde:
> > > =


> > > starfive: fix return code of `mac write_eeprom` (2025-08-12 15:34:39=
 +0800)
> > > =


> > > CI result shows no issue: https://source.denx.de/u-boot/custodians/u=
-boot-riscv/-/pipelines/27348
> > > ----------------------------------------------------------------
> > > - Board: mbv: Prepare MBV for CI
> > > - Board: MPFS Icicle Kit cleanup
> > > - Board: Add Andes Voyager board support
> > > - RISCV: Update SYS_BOOTM_LEN to commonly used value
> > > - starfive: fix return code of `mac write_eeprom`
> > =


> > So, there's a few problems here. First, checkpatch.pl finds spacing an=
d
> > spelling issues, which I would normally just fixup in place. But secon=
d,
> > voyager_spl doesn't build:
> > riscv64: + voyager_spl
> > +(voyager_spl) In file included from include/linux/printk.h:4,
> > +(voyager_spl) from include/linux/kernel.h:5,
> > +(voyager_spl) from include/linux/libfdt_env.h:13,
> > +(voyager_spl) from include/linux/libfdt.h:6,
> > +(voyager_spl) from include/fdtdec.h:17,
> > +(voyager_spl) from include/dm/ofnode.h:11,
> > +(voyager_spl) from include/dm/device.h:13,
> > +(voyager_spl) from include/dm.h:13,
> > +(voyager_spl) from common/spl/spl.c:13:
> > +(voyager_spl) common/spl/spl.c: In function 'spl_set_header_raw_uboot=
':
> > +(voyager_spl) common/spl/spl.c:281:27: error: format '%x' expects arg=
ument of type 'unsigned int', but argument 2 has type 'long int' [-Werror=3D=
format=3D]
> > +(voyager_spl) 281 | log_debug("Default load addr %x (u_boot_pos=3D%lx=
)\n",
> > +(voyager_spl) | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +(voyager_spl) include/log.h:234:24: note: in definition of macro 'log=
'
> > +(voyager_spl) 234 | printf(_fmt, ##_args); \
> > +(voyager_spl) | ^~~~
> > +(voyager_spl) common/spl/spl.c:281:17: note: in expansion of macro 'l=
og_debug'
> > +(voyager_spl) | ^~~~~~~~~
> > +(voyager_spl) common/spl/spl.c:281:47: note: format string is defined=
 here
> > +(voyager_spl) | ~^
> > +(voyager_spl) | |
> > +(voyager_spl) | unsigned int
> > +(voyager_spl) | %lx
> > +(voyager_spl) cc1: all warnings being treated as errors
> > +(voyager_spl) make[3]: *** [scripts/Makefile.build:296: spl/common/sp=
l/spl.o] Error 1
> > +(voyager_spl) make[2]: *** [scripts/Makefile.xpl:547: spl/common/spl]=
 Error 2
> > +(voyager_spl) make[1]: *** [Makefile:2358: spl/u-boot-spl] Error 2
> > +(voyager_spl) make: *** [Makefile:198: sub-make] Error 2
> > =


> > Please fix and re-submit, thanks.
> =


> =


> Hi Tom,
> =


> Sorry! I will fix these and re-submit ASAP.
> =


> Best regards,
> Leo

Hi Leo,

As you'll resubmit, may I propose two little cleanups ?

You merged my change to the default SYS_BOOTM_LEN, so this config for both=
 configs/microchip_mpfs_icicle_defconfig and configs/voyager_spl_defconfig=
 could be removed as it corresponds to the now default one.

For the Icicle board, the config has been unnecessarily re-added in the `c=
onfigs: microchip_mpfs_icicle: enable CONFIG_OF_BOARD_SETUP` commit.

For the Voyager board it is a new board that I didn't address in my patch =
as it was not yet merged.

This way the defconfigs stay minimal and clean.

Thanks and best regards,

Martin
-----------------------105dd0a8260b56fea63e573f6972cdec--

--------efce03c002d31744fcb5011dc4bf8660898734b110a847d38e42454f625198c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmicc+sJkIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfDxZY3gtW8xrXByuWcgOMa3vCofe71vO+3Rxte
q0k84BYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAACr7wD/c8/wsosTIzLgFfn9
eM/aKy1ve3CMYX6jMbjjF60XOmYBAPkADsa44b7Okgd7xVEJpaYkbrMvVZuM
OXbH4s83EvwB
=InYH
-----END PGP SIGNATURE-----


--------efce03c002d31744fcb5011dc4bf8660898734b110a847d38e42454f625198c2--

