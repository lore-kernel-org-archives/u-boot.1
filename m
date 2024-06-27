Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255D9C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C99288256;
	Thu, 27 Jun 2024 11:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="mSLoIh7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204198826B; Thu, 27 Jun 2024 11:38:38 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C6288247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9014ae4f1=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1719481115; x=1751017115;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vaBt68P0Gwd8y1sBJIYcCydsrELXU1vZA+zSDa5sr0s=;
 b=mSLoIh7Zm9rFp6hUiF5FPm8Mx4PsiECqkmo7sSXFA721X89D9ltOebY5
 NEdZZ8lenBV0ys6hHtG2JbSMPIt0JX+h/2uIXHQG9EqcK1Ocu2nCuJ2K9
 TCHRCgvNAKc/LlNXhuu5vLaboXGcBy4L9T4PKivjpa6BDp9kPFloR6bg2
 DVy/xUDZZ6TJgEgFP7IecxebCrhcHgTAofJOlZAkf9wOuc8teqKVdvmcK
 SDfDAergO310C1OwHDkpVEOZUpHtXYQNFnP/AlS6jtBb67vOL/Mgsnin6
 jHNGbFvHEWzM8oVs6udJY2LlvmJFQtgPgXLHllDj5mUSO0N52RNl11bOk g==;
X-CSE-ConnectionGUID: cdskC7CYTqeJjMsUY3THYA==
X-CSE-MsgGUID: sHCh4/qETX+I/PR8qHNbYg==
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
 d="asc'?scan'208";a="28572258"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jun 2024 02:38:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Jun 2024 02:38:26 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 27 Jun 2024 02:38:24 -0700
Date: Thu, 27 Jun 2024 10:38:08 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>, <conor@kernel.org>,
 Ivan Griffin <ivan.griffin@microchip.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
Message-ID: <20240627-endnote-cacti-5c8ae6251234@wendy>
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
 <20240625143421.GR38804@bill-the-cat>
 <CAFLszTipm2MB9L8tubRxh_cF-BOXciBo5ypnjomm5rTj_F4fAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wJ+sTpcVOadmVx7A"
Content-Disposition: inline
In-Reply-To: <CAFLszTipm2MB9L8tubRxh_cF-BOXciBo5ypnjomm5rTj_F4fAQ@mail.gmail.com>
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

--wJ+sTpcVOadmVx7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 09:36:49AM +0100, Simon Glass wrote:
>=20
> On Tue, 25 Jun 2024 at 15:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 10:08:06AM +0100, Conor Dooley wrote:
> >
> > > The firmware on the Icicle is capable of providing a devicetree in a1=
 to
> > > U-Boot, but until now the devicetree has been packaged in a "payload"=
 [1]
> > > alongside U-Boot (or other bootloaders/RTOSes) and appended to the im=
age.
> > > The address of this appended devicetree is placed in a1 by the firmwa=
re.
> > > This meant that the mechanism used by OF_SEPARATE to locate the
> > > devicetree at the end of the image would pick up the one provided by =
the
> > > firmware when u-boot-nodtb.bin was in the payload and U-Boot's device=
tree
> > > when u-boot.bin was.
> > >
> > > The firmware is now going to be capable of providing a minimal device=
tree
> > > (quite cut down due to severe space constraints), but this devicetree=
 is
> > > linked into the firmware that runs out of the L2 rather than at the e=
nd
> > > of the U-Boot image. Implement board_fdt_blob_setup() so that this
> > > devicetree can be optionally used, and the devicetree provided in the
> > > "payload" can be used without relying on "happening" to implement the
> > > same strategy as OF_SEPARATE expects in combination with
> > > u-boot-nodtb.bin. Unlike other RISC-V boards, the firmware provided
> > > devicetree is only used when OF_BOARD is set, so that the almost
> > > certainly more complete devicetree in U-Boot will be used unless
> > > explicitly requested otherwise.
> > >
> > > Link: https://github.com/polarfire-soc/hart-software-services/blob/ma=
ster/tools/hss-payload-generator/README.md [1]
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > > CC: Ivan Griffin <ivan.griffin@microchip.com>
> > > CC: Padmarao Begari <padmarao.begari@microchip.com>
> > > CC: Cyril Jean <cyril.jean@microchip.com>
> > > CC: Tom Rini <trini@konsulko.com>
> > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > CC: u-boot@lists.denx.de
> > > ---
> > >  board/microchip/mpfs_icicle/mpfs_icicle.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microc=
hip/mpfs_icicle/mpfs_icicle.c
> > > index 4d7d843dfa3..2c1f7175f0e 100644
> > > --- a/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > +++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > @@ -9,6 +9,7 @@
> > >  #include <init.h>
> > >  #include <asm/global_data.h>
> > >  #include <asm/io.h>
> > > +#include <asm/sections.h>
> > >
> > >  DECLARE_GLOBAL_DATA_PTR;
> > >
> > > @@ -50,6 +51,24 @@ static void read_device_serial_number(u8 *response=
, u8 response_size)
> > >               response_buf[idx] =3D readb(MPFS_SYS_SERVICE_MAILBOX + =
idx);
> > >  }
> > >
> > > +void *board_fdt_blob_setup(int *err)
> > > +{
> > > +     *err =3D 0;
> > > +     /*
> > > +      * The devicetree provided by the previous stage is very minima=
l due to
> > > +      * severe space constraints. The firmware performs no fixups et=
c.
> > > +      * U-Boot, if providing a devicetree, almost certainly has a be=
tter
> > > +      * more complete one than the firmware so that provided by the =
firmware
> > > +      * is ignored for OF_SEPARATE.
> > > +      */
> > > +     if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > > +             if (gd->arch.firmware_fdt_addr)
> > > +                     return (ulong *)(uintptr_t)gd->arch.firmware_fd=
t_addr;
> > > +     }
> > > +
> > > +     return (ulong *)_end;
> > > +}
> > > +
> > >  int board_init(void)
> > >  {
> > >       /* For now nothing to do here. */
> >
> > I'm adding in Simon and Ilias as this touches on one of those frequent
> > topics about how device trees can/should be passed along to us.
>=20
> The only thing I can think of is implementing bloblist in  the a1 (?)
> firmware, then passing the DT in that.

a1 is the register that is used on riscv to pass the dtb, I think the
corresponding thing on arm64 is x0.

Re-reading the firware handoff spec, it's difficult to see what benefits
it actually provides us when we only ever have a single dtb which the
firmware does not interact with/use.
We are super space constrained in the firmware even carving out 4.5 KiB
for a devicetree blob is a stretch and requires disabling other features
and ripping out anything in the DT not required for U-Boot to load the OS.
Even the ~1 KiB mentioned in bloblist.h for handling a bloblist would be a
challenge.

I think the only way a bloblist could work is if it was created at build
time and linked into the firmware, since the on-disk format seems pretty
minimal. Is there tooling for generating a bloblist at build time that I
could use to check whether or not a bloblist is viable?=20
I'd also have to investigate how that would interact with OpenSBI, since
it's integrated into the firmware and involved with loading U-Boot.

> It seems that you still need to be able to turn that on and off in
> U-Boot though. So far we have not agreed the mechanism to do that, I
> have the same problem, with a pending patch here[1]

It seems your patch is trying to do some runtime determination of
whether to examine the bloblist or not, but the ?existing? build-time
check for BLOBLIST being enabled would work equally well/poorly as the
OF_BOARD check the code I am adding. I'm not even really sure what runtime
option could be used here here to check if the passed dtb/bloblist was to
be used. U-Boot only runs here as supervisor mode U-Boot proper and always
has a more complete devicetree. Whether to use the one passed to U-Boot
just depends on what the person with the board wants to do - which, given
this is an FPGA, could be vary significantly.

Cheers,
Conor.

--wJ+sTpcVOadmVx7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn0zAAAKCRB4tDGHoIJi
0ixKAP9MXVRniLY5GYkxmH/mZFjGxtZVlPPHfctW8MAmMUMIPAD/aSlYmVKSNNKe
CbpAxeL5aVE3dRHTKshORkDgQKQhlQ8=
=2QfF
-----END PGP SIGNATURE-----

--wJ+sTpcVOadmVx7A--
