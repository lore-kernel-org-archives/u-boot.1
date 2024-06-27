Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EC6C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 20:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B8A880C5;
	Thu, 27 Jun 2024 22:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FmL0BFml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D74881EC; Thu, 27 Jun 2024 22:28:00 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C244F88027
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 22:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4DFBECE2E48;
 Thu, 27 Jun 2024 20:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD229C2BBFC;
 Thu, 27 Jun 2024 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719520074;
 bh=tumAnGE8uPCdarypspnFtTFyzzp6f0mj9h97p967D/E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FmL0BFmlwrWohZZ5xdmPOLF44OQ8nIVcxGc97E37uTsdig9AEEC+dbF+xo8j/m4sI
 KBS9yghHy4JsM/k0jKloQjVMjdPJhGdhKPwyB19uSjqskNel0Ohvt4fi/taBhWf+KN
 XRUDHTDRSfZ8BSK8ZELcrEc86q2DQ2vG7fYCd8to3aNAGHe9TXKFivSJV4hIQcqyct
 6vJMaeisDRq/9lXZlh8oJmDAb0ez0tdtD379V9nGyHeEez+wu0RNFo8kDV4kse0Lsu
 vBEEXdLnQ44DE6jLVXQDjbelB5J1ZD8rtD1wL/xGMLFVPWAsPfpRH9jmfDwRgDYhPY
 4zA2qhJvbuk8w==
Date: Thu, 27 Jun 2024 21:27:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Ivan Griffin <ivan.griffin@microchip.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
Message-ID: <20240627-prowess-train-e37fe71c1310@spud>
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
 <20240625143421.GR38804@bill-the-cat>
 <CAFLszTipm2MB9L8tubRxh_cF-BOXciBo5ypnjomm5rTj_F4fAQ@mail.gmail.com>
 <20240627-endnote-cacti-5c8ae6251234@wendy>
 <CAFLszTj3uSd8UOvmg5M2x1EOnidocRYxiBg0SeG8-eCfm1huRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="emIxNAIx/jEPT3Ez"
Content-Disposition: inline
In-Reply-To: <CAFLszTj3uSd8UOvmg5M2x1EOnidocRYxiBg0SeG8-eCfm1huRQ@mail.gmail.com>
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


--emIxNAIx/jEPT3Ez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:50:33AM +0100, Simon Glass wrote:
> On Thu, 27 Jun 2024 at 10:38, Conor Dooley <conor.dooley@microchip.com> w=
rote:
> > On Thu, Jun 27, 2024 at 09:36:49AM +0100, Simon Glass wrote:
> > > On Tue, 25 Jun 2024 at 15:34, Tom Rini <trini@konsulko.com> wrote:
> > > > On Tue, Jun 25, 2024 at 10:08:06AM +0100, Conor Dooley wrote:
> > > > > The firmware on the Icicle is capable of providing a devicetree i=
n a1 to
> > > > > U-Boot, but until now the devicetree has been packaged in a "payl=
oad" [1]
> > > > > alongside U-Boot (or other bootloaders/RTOSes) and appended to th=
e image.
> > > > > The address of this appended devicetree is placed in a1 by the fi=
rmware.
> > > > > This meant that the mechanism used by OF_SEPARATE to locate the
> > > > > devicetree at the end of the image would pick up the one provided=
 by the
> > > > > firmware when u-boot-nodtb.bin was in the payload and U-Boot's de=
vicetree
> > > > > when u-boot.bin was.
> > > > >
> > > > > The firmware is now going to be capable of providing a minimal de=
vicetree
> > > > > (quite cut down due to severe space constraints), but this device=
tree is
> > > > > linked into the firmware that runs out of the L2 rather than at t=
he end
> > > > > of the U-Boot image. Implement board_fdt_blob_setup() so that this
> > > > > devicetree can be optionally used, and the devicetree provided in=
 the
> > > > > "payload" can be used without relying on "happening" to implement=
 the
> > > > > same strategy as OF_SEPARATE expects in combination with
> > > > > u-boot-nodtb.bin. Unlike other RISC-V boards, the firmware provid=
ed
> > > > > devicetree is only used when OF_BOARD is set, so that the almost
> > > > > certainly more complete devicetree in U-Boot will be used unless
> > > > > explicitly requested otherwise.
> > > > >
> > > > > Link: https://github.com/polarfire-soc/hart-software-services/blo=
b/master/tools/hss-payload-generator/README.md [1]
> > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > ---
> > > > > CC: Ivan Griffin <ivan.griffin@microchip.com>
> > > > > CC: Padmarao Begari <padmarao.begari@microchip.com>
> > > > > CC: Cyril Jean <cyril.jean@microchip.com>
> > > > > CC: Tom Rini <trini@konsulko.com>
> > > > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > > > CC: u-boot@lists.denx.de
> > > > > ---
> > > > >  board/microchip/mpfs_icicle/mpfs_icicle.c | 19 +++++++++++++++++=
++
> > > > >  1 file changed, 19 insertions(+)
> > > > >
> > > > > diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/mi=
crochip/mpfs_icicle/mpfs_icicle.c
> > > > > index 4d7d843dfa3..2c1f7175f0e 100644
> > > > > --- a/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > > > +++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > > > @@ -9,6 +9,7 @@
> > > > >  #include <init.h>
> > > > >  #include <asm/global_data.h>
> > > > >  #include <asm/io.h>
> > > > > +#include <asm/sections.h>
> > > > >
> > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > >
> > > > > @@ -50,6 +51,24 @@ static void read_device_serial_number(u8 *resp=
onse, u8 response_size)
> > > > >               response_buf[idx] =3D readb(MPFS_SYS_SERVICE_MAILBO=
X + idx);
> > > > >  }
> > > > >
> > > > > +void *board_fdt_blob_setup(int *err)
> > > > > +{
> > > > > +     *err =3D 0;
> > > > > +     /*
> > > > > +      * The devicetree provided by the previous stage is very mi=
nimal due to
> > > > > +      * severe space constraints. The firmware performs no fixup=
s etc.
> > > > > +      * U-Boot, if providing a devicetree, almost certainly has =
a better
> > > > > +      * more complete one than the firmware so that provided by =
the firmware
> > > > > +      * is ignored for OF_SEPARATE.
> > > > > +      */
> > > > > +     if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > > > > +             if (gd->arch.firmware_fdt_addr)
> > > > > +                     return (ulong *)(uintptr_t)gd->arch.firmwar=
e_fdt_addr;
> > > > > +     }
> > > > > +
> > > > > +     return (ulong *)_end;
> > > > > +}
> > > > > +
> > > > >  int board_init(void)
> > > > >  {
> > > > >       /* For now nothing to do here. */
> > > >
> > > > I'm adding in Simon and Ilias as this touches on one of those frequ=
ent
> > > > topics about how device trees can/should be passed along to us.
> > >
> > > The only thing I can think of is implementing bloblist in  the a1 (?)
> > > firmware, then passing the DT in that.
> >
> > a1 is the register that is used on riscv to pass the dtb, I think the
> > corresponding thing on arm64 is x0.
> >
> > Re-reading the firware handoff spec, it's difficult to see what benefits
> > it actually provides us when we only ever have a single dtb which the
> > firmware does not interact with/use.
> > We are super space constrained in the firmware even carving out 4.5 KiB
> > for a devicetree blob is a stretch and requires disabling other features
> > and ripping out anything in the DT not required for U-Boot to load the =
OS.
> > Even the ~1 KiB mentioned in bloblist.h for handling a bloblist would b=
e a
> > challenge.
> >
> > I think the only way a bloblist could work is if it was created at build
> > time and linked into the firmware, since the on-disk format seems pretty
> > minimal. Is there tooling for generating a bloblist at build time that I
> > could use to check whether or not a bloblist is viable?
> > I'd also have to investigate how that would interact with OpenSBI, since
> > it's integrated into the firmware and involved with loading U-Boot.
>=20
> There is not such a tool, but it would be easy enough to write. If you
> think that would help, I could give it a try.

I mean I could also just do it myself, I just wanted to know if it
existed, since that'd make investigating this pretty straightforward to
do.

Either way, the firmware already is capable of doing this with a
devicetree blob, so I figure even if we manage to get bloblist stuff
going, there's little harm in supporting what's already there?

> The confusing thing for me is that the 'firmware' is very
> constrained...but are you saying that U-Boot is not?

Correct. The firmware is in eNVM with a size limit of 128 KiB, but it
can load U-Boot from mmc or flash etc.

> Why pass U-Boot the DT?

Primarily to allow using a generic image to be used across multiple
boards, using the compatible in the devicetree to determine what the
boot the OS with. Another idea that was floated was using vendor SBI
extension to request the information - but I felt that using DT was
better than conjuring up something specific to us.

> Perhaps you could explain the boot sequence so I can
> understand it better?

Ivan, correct me if I go off the rails here please... The firmware is
stored in eNVM on the FPGA, the FPGA's "system controller" sets the
reset vector for the CPUs to the location of the firmware. (There are
some other boot modes, but they all work similarly). The firmware
then decompresses itself into the L2 and runs primarily on hart 0,
which is a "monitor core", supporting fewer ISA extensions etc than the
4 cores on which user applications/OSes run on.

The firmware then loads a "payload" from a storage device, that contains
the next stage (or next stages if not running in SMP). The "payload" also
describes the privilege levels for the next stage(s) and the locations
in memory to load the next stage(s) to. OpenSBI is built into the firmware,
although we can't actually fit the whole libsbi library that it provides.
The firmware loads the next stage to whatever location has been provided
to it in the "payload". For U-Boot, we're always running in S-Mode, so
OpenSBI is used run the application once it has been loaded into memory
and to provide the SBI ecall interface etc.

I hope that makes some sense, it probably doesn't...

There's some info on how the payloads configurations are constructed in
the firmware repo here:
https://github.com/polarfire-soc/hart-software-services/tree/master/tools/h=
ss-payload-generator

> > > It seems that you still need to be able to turn that on and off in
> > > U-Boot though. So far we have not agreed the mechanism to do that, I
> > > have the same problem, with a pending patch here[1]
> >
> > It seems your patch is trying to do some runtime determination of
> > whether to examine the bloblist or not, but the ?existing? build-time
> > check for BLOBLIST being enabled would work equally well/poorly as the
> > OF_BOARD check the code I am adding. I'm not even really sure what runt=
ime
> > option could be used here here to check if the passed dtb/bloblist was =
to
> > be used. U-Boot only runs here as supervisor mode U-Boot proper and alw=
ays
> > has a more complete devicetree. Whether to use the one passed to U-Boot
> > just depends on what the person with the board wants to do - which, giv=
en
> > this is an FPGA, could be vary significantly.
>=20
> OK...so does this platform use SPL?

No :)

Thanks,
Conor.

--emIxNAIx/jEPT3Ez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn3LRgAKCRB4tDGHoIJi
0p+UAP4mku4S54Hnh1ufUgruZ0ZTXiqTHZWAXfFv7BYGJ/7BXAD/V+enAISYpahO
s++Nb8F3igYWXn+AU++C+AGfW+EJQQ0=
=CC8h
-----END PGP SIGNATURE-----

--emIxNAIx/jEPT3Ez--
