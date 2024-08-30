Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8E1CA0FFF
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3B188B55;
	Fri, 30 Aug 2024 17:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WgXbvTGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E754188BFB; Fri, 30 Aug 2024 17:13:36 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A2C88637
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c34c2a7dc7so3502266d6.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725030813; x=1725635613; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rivSUs8flp+4ot9x+6OdZocmrWOlS2oHqqtWxjQGN/I=;
 b=WgXbvTGuyidEqpdPJxvsthgH4vZhTijNVMXola2IP8sZ8ZvBbnucvBL3+YfC2XMlkG
 ntPBHOvF1PBEKu+qMOabysyiyNkItg27WkLsMXRfOBOaeTk6JNF1BVqYtCe7Hu/a5ybU
 1MxtPbSnuBgskHbYEpp6uz1qNtpJT18TcMbVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725030813; x=1725635613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rivSUs8flp+4ot9x+6OdZocmrWOlS2oHqqtWxjQGN/I=;
 b=szDfN289kLTP4/yz/nOg18UXQbm0SQFzRlf2WlK8hgHHEo8goJj5L905jTrnmDv+2H
 mU8iUM4Y4s2AxhfrOY2j9H8WH9qf2GXf0TitX7AOmmd0qoApMhCcgaQFMXYKN4AI5Y19
 Y4Jgs9J/MFd1U0Lu20rUhJh/RQepMIqYyZRGY2H6fuIDP0iSh6IJc4xRCxSA4WMBZ9nL
 BO6QRR+V+pyvqIeaRJILwgRkLSJAeclL0Pi14JHOrmACCz9tf0oRxYGRH8dFVzs3x2oX
 aArhqWhclLQgId8wdgu0npix2lA2/+nEEc9Fw43XPZbMgROyj/vjd/TtSd4ksViJwpqt
 4edQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMJ8nH/nazgM90uzmK4OrP7sMaKdAhSJIj9BdlbCqJ31Zr2Qf6iGHjoAJ7DTKNGrHu5cGQIEU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyr9edDxUwuvH+zCC3Tp78eR/R0Y7nS+NucgwTYlDQFhC7TA6EB
 YtF9NZO/SDoMZjcjKM1mGkpK27Rmi2dJFP5D1bkQy/8UvF3d3mgtU/P84nGSFSw=
X-Google-Smtp-Source: AGHT+IH+MOpEiKQvyEhLD28OkLrQ3Yq8KHsdQHjGr74/cGq1XMQvwxtiSUDo6qdBJM06ULn6vLeRsA==
X-Received: by 2002:a05:6214:534a:b0:6c1:5f1e:c6bc with SMTP id
 6a1803df08f44-6c33e6a7b5fmr74178056d6.47.1725030812601; 
 Fri, 30 Aug 2024 08:13:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340c41e4dsm15137666d6.63.2024.08.30.08.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:13:30 -0700 (PDT)
Date: Fri, 30 Aug 2024 09:13:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
Message-ID: <20240830151327.GU2479150@bill-the-cat>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
 <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
 <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
 <CAFLszTgzM-FT64AYTy6FXwUw3FQg-3MQ7x0TZc6xBhX5c+bXEg@mail.gmail.com>
 <20240829152052.GE2479150@bill-the-cat>
 <CAFLszTjqVsZ1owvpCaOer7U-k0ZvtDfLC9g+kFPW8gJJeQ1Ktw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JiXxU5zlHPVEnF7Y"
Content-Disposition: inline
In-Reply-To: <CAFLszTjqVsZ1owvpCaOer7U-k0ZvtDfLC9g+kFPW8gJJeQ1Ktw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--JiXxU5zlHPVEnF7Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 07:09:22PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 29 Aug 2024 at 09:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 09:02:38AM -0600, Simon Glass wrote:
> > > Hi Neil,
> > >
> > > On Thu, 29 Aug 2024 at 08:44, <neil.armstrong@linaro.org> wrote:
> > > >
> > > > On 29/08/2024 14:17, Simon Glass wrote:
> > > > > Hi Peter,
> > > > >
> > > > > On Thu, 29 Aug 2024 at 04:43, Peter Robinson <pbrobinson@gmail.co=
m> wrote:
> > > > >>
> > > > >> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wro=
te:
> > > > >>>
> > > > >>> Hi Peter,
> > > > >>>
> > > > >>> On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.=
com> wrote:
> > > > >>>>
> > > > >>>> Hi Simon,
> > > > >>>>
> > > > >>>>> With Labgrid we don't need to specify the various methods, ex=
cept for
> > > > >>>>> the console, which simply calls labgrid-client.
> > > > >>>>>
> > > > >>>>> This allows supporting any boards in your lab, without adding=
 per-board
> > > > >>>>> configuration to these hooks.
> > > > >>>>>
> > > > >>>>> Provide ellesmere files as an example.
> > > > >>>>
> > > > >>>> What's ellesmere?
> > > > >>>
> > > > >>> It is a lake but also the name of a computer.
> > > > >>>
> > > > >>>>
> > > > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >>>>> ---
> > > > >>>>>
> > > > >>>>> Changes in v4:
> > > > >>>>> - Support pytest fully with dual-build boards like Beagleplay
> > > > >>>>>
> > > > >>>>> Changes in v3:
> > > > >>>>> - Update scripts for latest version of Labgrid integration
> > > > >>>>> - Add poweroff.none and poweron.none
> > > > >>>>> - Provide -n flag when querying board info
> > > > >>>>> - Target the grpc version of Labgrid which is now in -master
> > > > >>>>> - Update README to cover the changes
> > > > >>>>>
> > > > >>>>> Changes in v2:
> > > > >>>>> - Make use of the common script (only) to set bin_dir
> > > > >>>>>
> > > > >>>>>   README.md                    | 50 +++++++++++++++++++++++++=
+++++++++++
> > > > >>>>
> > > > >>>> Maybe that should be in a separate labsgrid readme?
> > > > >>>
> > > > >>> My hope is that Labgrid becomes the normal way of running these=
 tests,
> > > > >>
> > > > >> Generally I agree with automated testing platforms, I think <ins=
ert
> > > > >> you're preferred platform here> makes sense, there's a bunch like
> > > > >> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there'=
s a
> > > > >> bunch more that I'm aware of.
> > > > >
> > > > > I am somewhat familiar with LAVA and I believe it can be used to =
test
> > > > > U-Boot, although I need to learn how. Looking at a test run [2] f=
or
> > > > > beaglebone black I see that it is using a recent kernel but the U=
-Boot
> > > > > seems to be older.
> > > > >
> > > > >>
> > > > >> Does it make sense, of course at some point in the future post t=
his
> > > > >> being merged, make sense to look at a general way of making it e=
asier
> > > > >> to plugin these sort of HW test platforms using this as a basis?=
 I ask
> > > > >> mostly because putting a bunch of my devices into some sort of
> > > > >> platform can auto test things and of course everyone has an opin=
ion to
> > > > >> which is the best one :-P
> > > > >
> > > > > Yes. I had heard from Tom that Labgrid is the new hotness for now.
> > > > > Having dug into it I believe it is a good solution, although it c=
an
> > > > > certainly be improved to handle scale better.
> > > > >
> > > > > Anyway, IMO the current test hooks are not a great solution, just
> > > > > because the configuration is spread all over the place and it rel=
ies
> > > > > on lots of little shell scripts. So I believe that the Labgrid
> > > > > integration is a closer to where we want to be with others that c=
ome
> > > > > along.
> > > >
> > > > I'd say all those scripts are actually here to ease integration wit=
h any
> > > > system, booting U-Boot and Linux are two different beasts.
> > >
> > > That's fine, go ahead and use the scripts. My point is that Labgrid
> > > doesn't need them and in fact it makes everything pretty painful if we
> > > try to use all of them.
> >
> > I guess I really need to clean-up and post my former co-workers scripts
> > as I strongly disagree with that statement.
>=20
> See some examples below. Bear in mind also that my goal has been to
> get my lab fully running, that includes interactive access to boards,
> as well as running tests. For that I have been using tbot (with
> integrated build and software-loading features). WIth Labgrid I have
> been able to replace most of the pytest scripts, tbot and Labman with
> Labgrid + 60 patches and some configuration files.

That's certainly good and useful progress. And I feel like one of the
lessons of this thread is that every lab ends up a bit different and so
there's just not going to be as much standardization as we'd all like.

> Let's look through the scripts:
>=20
> u-boot-test-common - new script
>=20
> u-boot-test-console - needed
>=20
> u-boot-test-flash - here's an example:
>=20
> . poweroff.${power_impl}
> sleep 0.1
> . flash.sdwire_common_mount
> . poweron.${power_impl}
>=20
> Here's another:
>=20
> # Handles the common SDwire mounting (caller does power control)
>=20
> mount_dir=3D/media/${mount_point}
>=20
> # Switch over to get USB card access
> sd-mux-ctrl --device-serial ${sdwire_serial} --ts
>=20
> complete=3Dfalse
> for i in {0..9}; do
>     if out=3D"$(mount UUID=3D${mount_uuid} 2>&1)"; then
>         complete=3Dtrue
>         break
>     fi
>     echo $out
>=20
>     # If it is already mounted, try to unmount it first. It may have been
>     # mounted by another user so we won't have the access we need. If thi=
s gives
>     # an error then we know we cannot continue
>     if [[ $out =3D=3D *"already mounted"* ]]; then
>         umount UUID=3D${mount_uuid}
>     fi
>     sleep 1
> done
> if [[ $complete =3D false ]]; then
>     echo "Failed to mount UUID ${mount_uuid} after 10 tries"
>     exit 1
> fi
>=20
> # Sanity check
> if ! mountpoint -q ${mount_dir}; then
>     echo "Mount ${mount_dir} not available after 'mount'"
>     exit 1
> fi
>=20
> # Perform the write, pass along as much environment as possible
> . writer.${flash_writer}
>=20
> complete=3Dfalse
> for i in {0..9}; do
>     if out=3D"$(umount ${mount_dir} 2>&1)"; then
>         complete=3Dtrue
>         break
>     fi
>     echo $out
>     sleep 1
> done
>=20
> if [[ $complete =3D false ]]; then
>     echo "Failed to umount UUID ${mount_uuid} after 10 tries"
>     exit 1
> fi
>=20
> # Sanity check
> if mountpoint -q ${mount_dir}; then
>     echo "Mount ${mount_dir} still available after 'umount'"
>     exit 1
> fi
>=20
> # Back to card access for the DUT
> sd-mux-ctrl --device-serial ${sdwire_serial} --dut
>=20
>=20
> Of course that assumes an SDwire which may not always be the case.

Or some other piece of hardware that sd-mux-ctrl supports, but yes.

> Abstracting all of this into shell scripts is just too painful.

Abstracting it to something else sounds even more painful however.

> Also I have found it to be error-prone.
>=20
> There is also bin/flash.sdwire_relay_mount:
>=20
> . poweroff.${power_impl}
>=20
> sleep 0.1
>=20
> . flash.sdwire_common_mount
>=20
> . poweron.${power_impl}

Yup. It's possible we could do some slightly nicer check/sleep loop but
it probably wouldn't really get us much.

> u-boot-test-getrole
> - New script

Which is for how you abstracted hardware from software configurations it
can run (for example, the Pi 4 case of rpi_4, rpi_4_32b and rpi_arm64
all being valid defconfigs).

> u-boot-test-power-off
> - This one fits with Labgrid quite well, but of course there may not
> actually be power control
>=20
> u-boot-test-power-on
> - This one also fits with Labgrid, but since serial output can come
> out as soon as it is called, jumping back into Labgrid later to bring
> up a console results in lots of missing output. Also there may not
> actually be power control

Right, but in both cases, poweron/poweroff.labgrid could just do:
labgrid-client power $state || true
if power isn't supported (which sounds odd, but, maybe makes sense in
some setup).

> u-boot-test-release
> - New script. Actually this isn't really needed, since I added
> automatic release to Labgrid. I was just worried that Labgrid might
> crash

What I saw in working on my scripts was that if you don't release you
can't acquire later and there's not an option for "you already have
acquired it". On my scripts, I should update the cleanup function to
release the current LG_PLACE.

> u-boot-test-reset
> - Unfortunately labgrid doesn't provide a reset option, although I'm
> sure it could be added. You still need to know whether to use power or
> reset or both, though, so again you have shell scripts with this stuff

Perhaps this is something to talk with upstream about, for the cases
where "reset" is not just another name for "power cycle" ? I know we
have scripts today for a number of cases but the only ones I wrote are
just power cycle (digital-loggers) or power cycle via USB (ykush, the
USB hubs that support per-port power control intentionally).

> reset.recovery_download - another thing I had to add, BTW
>=20
> . "${bin_dir}/recovery.${recovery_impl}"
>=20
> # USB enumeration delay
> for ((i =3D 0; i <=3D 100; i++)); do
>     if [ -e "${board_usb_dev}" ]; then
>         break
>     fi
>     sleep 0.1
> done
> if [ ! -e "${board_usb_dev}" ]; then
>     echo "Cannot find device ${board_usb_dev}"
>     exit 1
> fi
> sleep 1
>=20
> . "${bin_dir}/download.${download_impl}"
>=20
> or another case, this is Zynq which tries to wait a bit before calling
> picocom. It mostly works, but it loses output
>=20
> # Some boards have a UART built into them and it doesn't appear until the
> # board is powered on. An example is zynq_zybo. Try to handle this by wai=
ting
> # for the console and then continuing as soon as possible (so we don't mi=
ss
> # the U-Boot banner).
> if [ -n "${console_wait}" ]; then
>     for i in {0..99}; do
>         if [ -e "${console_dev}" ]; then
>             break
>         fi
>         sleep .1
>     done
>     if [ ! -e "${console_dev}" ]; then
>         echo "Console ${console_dev} not found"
>         exit 1
>     fi
> fi
>=20
> exec picocom -b "${console_baud}" "${console_dev}"
>=20
> So that's about a third of the reason why I don't think the scripts scale.

This is where I think looking at https://github.com/bootlin/snagboot
which Kevin Hillman pointed me at a while ago might come in handy,
instead.

> > The only "painful" part is
> > the shared pain, regardless of framework, for "put blob $X at location
> > $Y", which I believe you abstract out in to python?
>=20
> Sort-of. The Python knows how to handle all the different writing
> methods and is at [2], but it is entirely controlled by yaml[3] (the
> example_env.yaml). See the ti,am625 method for example and the 'play'
> board right at the bottom of the end file.
>=20
> I very much like the configuration files (although I hope one day
> Labgrid will allow the two files to be combined). It makes it easier
> to add a new board, since there is much less to think about. It really
> did take a long time to fiddle with all those hook scripts and I got
> tired of it.
>=20
> Regards,
> Simon
>=20
> [1] https://github.com/sjg20/u-boot/tree/lab6a/tools/labman
> [2] https://github.com/labgrid-project/labgrid/pull/1411/commits/c7ea0398=
7362af70bbbb94d14ff74c54a1ee5ed8#diff-e994502495dc8083c0b70ab20ace18fb5f852=
17805d01a54270a69c84ec31023R107
> [3] https://github.com/labgrid-project/labgrid/pull/1411/commits/6d3b4a0c=
fc7e35e0547dcd14065328df4b4b5e1f#diff-66f82743402c95b2eac8f9937c61c582bd0ac=
a2b35e841477d62122c811b7750R1187

Yeah, personally I don't care for that. I know I'm not going to convince
people and it's just one of those "goodness, I'm the old guy now"
things, but, no. It would be easier if you had comments for each SoC as
to what / why each of the magic values, but then shouldn't it be
abstracted more? Perhaps to a file per SoC, and at that point how is
this easier to follow than a commented shell script? But in sum, I'm
just cranky about yaml and I know your opinion is the opposite.

As an aside, please review the ti,am625 stuff with some TI folks, that's
both far too specific (you're going to need to add different am62 and
am64 and am69 and j7... and on and on cases) and I forget if there's
some work to have a slightly easier way to know what file to use going
on.

--=20
Tom

--JiXxU5zlHPVEnF7Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbR4ZAACgkQFHw5/5Y0
tyx7Wgv+KkyAFo8nGUCn7ErIP4n0VI2xrH9erqifln0vPwnKNtGh7Rqy36U9cCpm
5fUiOXL7amdVeGzlKeSbziLCz8Ydz2a8MloEyP0HOOYfYHmqdnZaKIaVI/LiGEVa
gi7/4a36qKfEcCAObeNJ0Ucjw+euaTk/kRKVRtEMX4YlGhTlGHBQlYp+NsMZ5cFN
ncGZ08OGcajD3vr0WiXq/S1sLy1mPkJOt75TFFGSwqwRDLD7+Iwxr80x8V7VjxK+
K3JXvNYrfCqLYyVjivUPSIVlITbDqUkiP2LAfC2XcyaczhzhGKAysQbS/FMnCiv8
mPauPYEAnF3FZUI96HtdUQ6ik7VSgw6eVdkQuatRB8+5J3DGQAtSDxL1Zerrc/w4
vjXCr5CXhkSrQPjp6FsaSdBVp3x6csi2UeARrJZijBIDYLnnupYL1FiKbdOm5Pmc
CsjmhUJZ7aMdE0XQECPT8w92azZgpIYs19bdBLFB/wlUfB/4/6MLH6ke4XzCLGhb
DCa6KKHr
=I0Og
-----END PGP SIGNATURE-----

--JiXxU5zlHPVEnF7Y--
