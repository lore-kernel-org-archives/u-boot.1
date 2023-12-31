Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B7C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64CF877F1;
	Sun, 31 Dec 2023 13:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SO5+I3ZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F00875FC; Sun, 31 Dec 2023 13:48:47 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7AF877F1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-680a06cc763so11373976d6.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026924; x=1704631724; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRPVvj681LlbEcMFTs+HImmM+sJnPAtqGjLarvMVfZ4=;
 b=SO5+I3ZAnEJxAjferjh7HjcKiN6ViSA3U17NNHUL2LyrzcMew/1V3Na/4JSOjeuKe/
 3p/kBe7AJZaQCAST00UIAnsGVsQyHuHLgvbyER1fOnsfSqefw4se+z5jJd8HgXHy7MkS
 lXBYyzv96FLUs0lJorxMmVHT+4tYB/AxCIMJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026924; x=1704631724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRPVvj681LlbEcMFTs+HImmM+sJnPAtqGjLarvMVfZ4=;
 b=Qh/SiNABtypWco62kXiP1Lh0RZ/HYUzQYHblB//QSpNPQudDEozYtcR8lcWHCrYkg8
 GR99wKoASgmEpXUH+ME1/ns0knk7KLaPof5ny33oZ6iEiwkuqyot/OVBBjbpLZ7kpkdY
 hnB6qGiSyw6WUTZ66rsUesiuJqUnPd3lFLPcXxATUwZNrelBXyQQYmCkgcL4mh1xyfbz
 ysLMhQJn/XyezqsYul0y1z6hcmRsRRuYT2yLGHZUNziSwyfIwuxQcv+Etpdf26wMKT6g
 ie0xbXqUK+EclZWzBnMo0rnmu/UD8As73VrbBiyYuv5kpKji3j8Rw/+XdPi3j/cZnx2t
 BIrA==
X-Gm-Message-State: AOJu0Yz08Ky+/+k49P6lbb2ntztJlpBbFIUOjwmfg+dkmzQS5I4cvhxg
 yog3sgDZVRHFxLkHWEGpMpjpq/XMfIaiB6n3nBiSWQgeScDZ
X-Google-Smtp-Source: AGHT+IF02kF+0y0PAqdoHula0XsGteS87zGnln9YG93dWkQtpCu82xmlUMsrqyJR8YhQ1wFMK3Sekci+x5l5Lzo0Oko=
X-Received: by 2002:a05:6214:519c:b0:67a:a721:d77c with SMTP id
 kl28-20020a056214519c00b0067aa721d77cmr24634503qvb.98.1704026924047; Sun, 31
 Dec 2023 04:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
 <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
 <20231005163645.GS8465@bill-the-cat>
 <20231005171010.zvza7uqyn4mcgp5g@handsaw>
 <20231005171614.yiatmyczip2jnmf4@surround>
 <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
 <20231106055351.f2fny5ys6avi5qnk@ula0497581>
 <20231106153159.GH496310@bill-the-cat>
 <736c04ab-9c48-4957-b242-fcbde0ace68b@ti.com>
 <CAPnjgZ1JTcybX9sRFQtddcwefLum6_+ynQSWbQ=4NVdO6eAxhg@mail.gmail.com>
 <7df59596-ac84-4e26-844f-3f3ad4bb0b7f@ti.com>
 <CAPnjgZ06tDBGko7RxO_ec1hKYqOhfhY9D7FdPiaVcDxaomeUDA@mail.gmail.com>
In-Reply-To: <CAPnjgZ06tDBGko7RxO_ec1hKYqOhfhY9D7FdPiaVcDxaomeUDA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:48:33 -0700
Message-ID: <CAFLszTiNruYVsRjAaKdtpvjuK3YfQN92DDArRofUOnWo-1jXUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
To: Andrew Davis <afd@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Nishanth Menon <nm@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, vigneshr@ti.com, jonas@kwiboo.se, srk@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Wed, Nov 29, 2023 at 7:48=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Andrew,
>
> On Mon, 6 Nov 2023 at 11:05, Andrew Davis <afd@ti.com> wrote:
> >
> > On 11/6/23 11:47 AM, Simon Glass wrote:
> > > Hi Andrew,
> > >
> > > On Mon, 6 Nov 2023 at 10:27, Andrew Davis <afd@ti.com> wrote:
> > >>
> > >> On 11/6/23 9:31 AM, Tom Rini wrote:
> > >>> On Mon, Nov 06, 2023 at 11:23:51AM +0530, Manorit Chawdhry wrote:
> > >>>> Hi Simon,
> > >>>>
> > >>>> On 11:22-20231005, Simon Glass wrote:
> > >>>>> Hi Nishanth,
> > >>>>>
> > >>>>> On Thu, 5 Oct 2023 at 11:16, Nishanth Menon <nm@ti.com> wrote:
> > >>>>>>
> > >>>>>> On 12:10-20231005, Nishanth Menon wrote:
> > >>>>>>> On 12:36-20231005, Tom Rini wrote:
> > >>>>>>>> On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
> > >>>>>>>>> On 10/4/23 8:54 AM, Nishanth Menon wrote:
> > >>>>>>>>>> On 08:48-20231004, Andrew Davis wrote:
> > >>>>>>>>>>> On 10/4/23 8:23 AM, Roger Quadros wrote:
> > >>>>>>>>>>>> ti_mmc is not a valid boot_target for standard boot flow s=
o
> > >>>>>>>>>>>
> > >>>>>>>>>>> Is there some way to make it into a valid boot_target? Othe=
rwise
> > >>>>>>>>>>> how do we use uEnv.txt files, or boot from FIT images with =
overlays?
> > >>>>>>>>>>
> > >>>>>>>>>> envboot takes care of uEnv.txt file (see
> > >>>>>>>>>> https://lore.kernel.org/all/20231004132324.44198-3-rogerq@ke=
rnel.org/)
> > >>>>>>>>>>
> > >>>>>>>>>> Early remote proc loading and FIT image is a question for st=
dboot itself.
> > >>>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> If stdboot is missing these features then we shouldn't switch=
 until it
> > >>>>>>>>> has them. I'm all for switching to this, but only if it is co=
mplete.
> > >>>>>>>>
> > >>>>>>>> Depends on what you mean?  Did you mean an option to run scrip=
ts
> > >>>>>>>> (exists) or an option to do what TI needs done, via
> > >>>>>>>> boot/bootmeth_something.c ?  If the latter, someone from TI ne=
eds to
> > >>>>>>>> figure out what that should be and do (but plumbing-wise every=
thing it
> > >>>>>>>> needs should exist).
> > >>>>>>>
> > >>>>>>> Andrew is generalizing here (on the wrong patch though).
> > >>>>>>>
> > >>>>>>> On am62x platforms, there is nothing regressing with this serie=
s. The
> > >>>>>>> challenge is early remote_proc loading which is done for J7* pl=
atforms.
> > >>>>>>>
> > >>>>>>> How that is initiated as part of bootmethods is something of a =
gap.
> > >>>>>>>
> > >>>>>>> The other gap has been support for uEnv.txt -> which we can wor=
karound
> > >>>>>>> at the moment by using CONFIG_BOOTCOMMAND=3D"run envboot; bootf=
low scan
> > >>>>>>> -lb" in defconfig (This series from Roger already does that - h=
ence I am
> > >>>>>>> saying that Andrew is complaining on the wrong series).
> > >>>>>>>
> > >>>>>>> Ideally, we should just have CONFIG_BOOTCOMMAND=3D"bootflow sca=
n -lb" and
> > >>>>>>> uEnv.txt remoteproc loads and the various standard bootmethods =
should
> > >>>>>>> "just work".
> > >>>>>>
> > >>>>>>
> > >>>>>> I forgot to add: FIT image authenticated boot flow. That is real=
ly what
> > >>>>>> ti_mmc distroboot method was trying to solve.
> > >>>>>>
> > >>>>>> Maybe Simon or someone know how the stdboot flow handles authent=
icated
> > >>>>>> kernel image and dtb boot flow with FIT image?
> > >>>>>
> > >>>>> Yes you can use FIT configuration verification and things should =
work as normal.
> > >>>>>
> > >>>>
> > >>>> Could you give any reference documentation for this?
> > >>>
> > >>> I suspect you should start with doc/usage/fit/beaglebone_vboot.rst
> > >>>
> > >>
> > >>   From that doc:
> > >>
> > >> ```
> > >> Boot the board using the commands below::
> > >>
> > >>       setenv bootargs console=3DttyO0,115200n8 quiet root=3D/dev/mmc=
blk0p2 ro rootfstype=3Dext4 rootwait
> > >>       ext2load mmc 0:2 82000000 /boot/image.fit
> > >>       bootm 82000000
> > >> ```
> > >>
> > >> This is very much not stdboot :( This doc has some good and current =
info on building
> > >> a secure FIT image, but much of it is showing its age. Stdboot is st=
ill missing
> > >>
> > >>    * ability to limit boot mode search to only one image (FIT)
> > >
> > > What does this mean? Can you please be more specific or give an examp=
le?
> > >
> >
> > Sure, for instance with secure boot we only want to search for FIT imag=
es
> > and if for each media this fails we do not want to fall back to other
> > image types or boot modes (like UART boot or net boot which would bypas=
s
> > the signature checks).
>
> We could have something like:
>
> bootstd {
>    image-types =3D "fit", "uimage";
> }
>
> to limit the supported types.
>
> >
> > Something similar is needed for searching for EFI compatible boot acros=
s
> > each enabled boot media first, before trying other methods on each medi=
a.
> > Basically breadth-first search on each media type not depth-first.
>
> How about:
>
> bootstd {
>    scan-order =3D "bootmeth,bootdev";   // instead of default "bootdev,bo=
otmeth";
> };
>
>
> >
> > >>    * fetching and applying FIT overlay/config strings
> > >
> > > Re overlays, is this the 'extension' command? What are config strings=
?
> > >
> >
> > When we have DT overlays in our FIT image, we build a string to pass to
> > bootm to apply all the selected overlays[0]. If there is now another
> > mechanism for this please let me know (building this string today is me=
ssy).
> >
> > https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/ti_co=
mmon.env?ref_type=3Dheads#L18
>
> My proposal for this is to implement extensions in FIT. This would
> have a new extensions nodes, so you can specify what extensions are
> available for each FIT configuration.
>
> configurations {
>    conf-1 {
>       compatible =3D ...
>       extensions =3D "ext1", "ext-2";
>    };
>
> extensions {
>    ext-1 {
>       fdto =3D "fdt-1";   // fdt overlay for this 'cape'
>       compatible =3D "vendor,combined-device1";
>       extensions =3D "ext3";
>    };
>
>    ext-2 {
>       fdto =3D "fdto-2";   // fdt overlay for this 'cape'
>       compatible =3D "vendor,device2";
>    };
>
>    ext-3 {
>       fdto =3D "fdto-3";
>       compatible =3D "vendor,device3";
>    };
>
> So FIT configurations now have a list of supported extensions. The
> extensions are hierarchical so that you can have ext1 which can
> optionally have ext-2 as well. This allows boards which share a lot of
> 'capes' to be specified only ones.
>
> Extensions actually present are declared by a sysinfo driver for the
> board, with new methods:
>
> get_compat() - determine the compatible strings for the current platform
> get_ext() - get a list of compatible strings for extensions which are
> actually present
>
> The extension compatible strings are used to select the correct things
> from the FIT, apply the overlays and produce the final DT.
>
> >
> > >>    * remote proc loading
> > >
> > > What command can do this?
> > >
> >
> > https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/ti_co=
mmon.env?ref_type=3Dheads#L28
>
> This could be a new property in bootstd:
>
> bootstd: {
>    probe-before =3D <&phandle of remoteproc>, ...
> };
>
> >
> > >>    * uEnv.txt processing
> > >
> > > What command can do this?
> > >
> >
> > run envboot;
> >
> > https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/mmc.e=
nv?ref_type=3Dheads#L20
>
> This could be a new bootmeth which looks for uenv.txt on available
> devices. It might be better to put the env in a FIT or something with
> a checksum.
>
> >
> > >>
> > >> Last two can be solved by adding to CONFIG_BOOTCOMMAND before callin=
g `bootflow scan`
> > >> as suggested above. Until we figure out the first two I don't see us=
 ready to switch.
> > >
> > > I'm happy to help figure this out.
> > >
> >
> > Thanks, we are eager to standardize our boot flows and stdboot seems li=
ke the
> > right way forward, very happy to have your guidance on these last few i=
tems :)
>

I'm just checking whether there is any feedback on the above? I sent
the FIT part as a separate proposal.

Regards,
Simon
