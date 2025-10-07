Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3283CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 20:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D7D283995;
	Tue,  7 Oct 2025 22:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JEUQ1MYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A55839C7; Tue,  7 Oct 2025 22:13:43 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF0F83981
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 22:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7b3e2a51678so162233a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759868020; x=1760472820; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gaq6UfA20/C87LPq/HrXVrEb3t9qdsUve42SdbkUepU=;
 b=JEUQ1MYh70qw8X5OSX05ylPoW08PKI0Eb3CHqfi05lbfd6H6iPof2rpJc74XH0ytlY
 xLQr7cM+ByfJl8U+2MxMyQJtdk6vx8zva6qEGFtisKesbzRNUtVgpu87nJ8yNNxf0M+5
 BiBygj7OyZ9VW52q/gqHkIBK+6vuuabVi/5VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759868020; x=1760472820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gaq6UfA20/C87LPq/HrXVrEb3t9qdsUve42SdbkUepU=;
 b=ncBPkxXoBLQsiJzR0PE8Z2TffMYdSNxX4886Z8irBly64QbV0JdzfAD2Xdds3LVLS6
 lhANpfj4tb2c74r4MrR+1bGauQhIpX7/e5iqDWaJ8E7SwHekArqNswqepBwwFLvdDGSv
 aE4dA+FzT/LgX1Eh0qMyJc1lfEAmHYIXoVYq5ii6zLLSCk/gl473ohYopjgP8GMGC0W+
 F7pSDZ2DWfHB+Qzgo/z/sLM0Uf6hy52rHMWOSiRqd1ecv/VXMc58u1bNMUJC68cZvGs5
 nO9oOgQcguKmrMtlAW5K6Eug64wlrxUCQZwMlATZZrJELPAs4t/9nfXTwcU5HkudNs9I
 i4+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbWvhXJsQZvRiJAVn40w0z6LAJb3mRll0GuzpNCqDL18JcwTplfckeiehWK2dRw07yQhVh1r0=@lists.denx.de
X-Gm-Message-State: AOJu0YyHGZ9yWk9pvuBb4Usoi+qMvn9bWhJxhG7rqVjMUlsdq2VtVliB
 A23Ydfu1KLbUdkAyfHbHy7nxWCzJKgkbFe5jdeDGRdm72YLdSs6MeIey1VWwJwZtjnk=
X-Gm-Gg: ASbGncuS2NJcaefIUOLbj2hMFeWuA0OXCZfYAX9xNDwuBRdsoOIRDkJKXmrozMEOu92
 29TI10P2U/7Yi0ZfalqlHa4y6DSrwt5MkZluLVtnqlgcMBWlIDamDli0D9uotFfyo22gL0rLqCt
 MikTSuMqsr9s6Da+nQtlLhGp20X2EQZWSf/1DyCbX+TeOzIZuZLCF6p5lvzbD/8B4AUlmHWHF1L
 m4buu4xKKJxULlJph7+t7LQsFYJgbPX5JY+48x99gJKwFhYMk+SiogPoxRW3WOibuhKKaaVCmw3
 dhlefGBoo18MAJ1SPOMNFmmZFnJd8bBHhrfdGR+91LKZdSe4rsFo41oA4jU8kduC8M5WxQX0C+F
 Or4HC9HhPXCMxwU5mk9UJTXST+YBQTCucg0RaLAzVPtaKIIHWyVaQqOd9dc8FAYvZ66KshsJmWn
 3amY5DI10PWg==
X-Google-Smtp-Source: AGHT+IHesDkGwgXVVQGYKJxRJEmGK8/prxNl0UuafdR5bwwodLOlx/5FdFHiUlscAisJNT0eghgXvw==
X-Received: by 2002:a05:6830:838c:b0:756:a668:60 with SMTP id
 46e09a7af769-7c02af98b9emr2525213a34.17.1759868019717; 
 Tue, 07 Oct 2025 13:13:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf43028a04sm5140020a34.24.2025.10.07.13.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 13:13:38 -0700 (PDT)
Date: Tue, 7 Oct 2025 14:13:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
Message-ID: <20251007201336.GQ298503@bill-the-cat>
References: <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
 <20251006214428.GD298503@bill-the-cat>
 <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
 <20251006234240.GF298503@bill-the-cat>
 <20251007113213.75efa663@kmaincent-XPS-13-7390>
 <20251007141148.GJ298503@bill-the-cat>
 <20251007182938.368bf435@kmaincent-XPS-13-7390>
 <20251007164207.GL298503@bill-the-cat>
 <CAFLszThB=o9Wq1K4XP1K_Oj+6db2ZuzK8kLw7KyGqCVqDBX7Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j9TYHx9SCSeRm038"
Content-Disposition: inline
In-Reply-To: <CAFLszThB=o9Wq1K4XP1K_Oj+6db2ZuzK8kLw7KyGqCVqDBX7Gg@mail.gmail.com>
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


--j9TYHx9SCSeRm038
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 02:02:53PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Tue, 7 Oct 2025 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 07, 2025 at 06:29:38PM +0200, Kory Maincent wrote:
> > > On Tue, 7 Oct 2025 08:11:48 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Tue, Oct 07, 2025 at 11:32:13AM +0200, Kory Maincent wrote:
> > > > > On Mon, 6 Oct 2025 17:42:40 -0600
> > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > > On Mon, Oct 06, 2025 at 05:30:15PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 6 Oct 2025 at 15:44, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Mon, Oct 06, 2025 at 02:38:23PM -0600, Simon Glass wrote:
> > > > > > > > > Hi Kory,
> > > > > > > > >
> > > > > > > > > On Fri, 3 Oct 2025 at 10:34, Kory Maincent
> > > > > > > > > <kory.maincent@bootlin.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Migrate TI board cape detection from legacy extension s=
upport to
> > > > > > > > > > the new UCLASS-based extension board framework.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > > -int extension_board_scan(struct list_head *extension_l=
ist)
> > > > > > > > > > +static int ti_extension_board_scan(struct alist *exten=
sion_list)
> > > > > > > > > >  {
> > > > > > > > > >         unsigned char addr;
> > > > > > > > > >         int num_capes =3D 0;
> > > > > > > > > > @@ -31,7 +31,7 @@ int extension_board_scan(struct list_=
head
> > > > > > > > > > *extension_list) struct am335x_cape_eeprom_id eeprom_he=
ader;
> > > > > > > > > >                 char process_cape_part_number[17] =3D {=
'0'};
> > > > > > > > > >                 char process_cape_version[5] =3D {'0'};
> > > > > > > > > > -               struct extension *cape;
> > > > > > > > > > +               struct extension cape =3D {0}, *_cape;
> > > > > > > > > >                 struct udevice *dev;
> > > > > > > > > >                 u8 cursor =3D 0;
> > > > > > > > > >                 int ret, i;
> > > > > > > > > > @@ -78,22 +78,20 @@ int extension_board_scan(struct lis=
t_head
> > > > > > > > > > *extension_list)
> > > > > > > > >
> > > > > > > > > I suppose that a method called scan() could be added to t=
he uclass
> > > > > > > > > and implemented by this driver.
> > > > >
> > > > > I don't understand what do you mean by method? Is it different to=
 the
> > > > > UBOOT driver scan ops I have designed?
> > > > >
> > > > > > > > > >                 printf("BeagleBone Cape: %s (0x%x)\n",
> > > > > > > > > > eeprom_header.board_name, addr);
> > > > > > > > > >
> > > > > > > > > > -               cape =3D calloc(1, sizeof(struct extens=
ion));
> > > > > > > > > > -               if (!cape) {
> > > > > > > > > > -                       printf("Error in memory allocat=
ion\n");
> > > > > > > > > > -                       return num_capes;
> > > > > > > > > > -               }
> > > > > > > > > > -
> > > > > > > > > > -               snprintf(cape->overlay, sizeof(cape->ov=
erlay),
> > > > > > > > > > "%s-%s.dtbo",
> > > > > > > > > > +               snprintf(cape.overlay, sizeof(cape.over=
lay),
> > > > > > > > > > "%s-%s.dtbo", process_cape_part_number, process_cape_ve=
rsion);
> > > > > > > > > > -               strlcpy(cape->name, eeprom_header.board=
_name,
> > > > > > > > > > +               strlcpy(cape.name, eeprom_header.board_=
name,
> > > > > > > > > >                         sizeof(eeprom_header.board_name=
));
> > > > > > > > > > -               strlcpy(cape->version, process_cape_ver=
sion,
> > > > > > > > > > +               strlcpy(cape.version, process_cape_vers=
ion,
> > > > > > > > > >                         sizeof(process_cape_version));
> > > > > > > > > > -               strlcpy(cape->owner, eeprom_header.manu=
facturer,
> > > > > > > > > > +               strlcpy(cape.owner, eeprom_header.manuf=
acturer,
> > > > > > > > > >                         sizeof(eeprom_header.manufactur=
er) + 1);
> > > > > > > > > > -               list_add_tail(&cape->list, extension_li=
st);
> > > > > > > > > > +               _cape =3D alist_add(extension_list, cap=
e);
> > > > > > > > > > +               if (!_cape)
> > > > > > > > > > +                       return -ENOMEM;
> > > > > > > > > >                 num_capes++;
> > > > > > > > > >         }
> > > > > > > > > >         return num_capes;
> > > > > > > > > >  }
> > > > > > > > > > +
> > > > > > > > > > +U_BOOT_EXTENSION(cape, ti_extension_board_scan);
> > > > > > > > >
> > > > > > > > > Can the extension information go in the devicetree, so bo=
ards can
> > > > > > > > > select their scheme that way?
> > > > > > > >
> > > > > > > > Since we're scanning to see what extension boards are prese=
nt and so
> > > > > > > > what device tree overlays to apply, I don't think that can =
work?
> > > > > > >
> > > > > > > My understanding is that the scanning process is board-specif=
ic. For
> > > > > > > example we would not want the Beagle mechanism to be compiled=
 into
> > > > > > > rpi. The idea of scanning things in a board-specific way seem=
s like a
> > > > > > > driver to me. Note there is also the SYSINFO uclass which can=
 do
> > > > > > > similar things.
> > > > > > >
> > > > > > > The overlays being applied here are additions to what should =
already
> > > > > > > be a fairly complete devicetree.
> > > > > > >
> > > > > > > If this isn't possible, then where is the information known?
> > > > >
> > > > > Oh, so you would prefer to have something like the sysinfo driver=
s.
> > > > >
> > > > > > You're commenting on a patch to the TI specific code, that's on=
ly used
> > > > > > by TI SoC using platforms that opt-in to the externally defined=
 EEPROM
> > > > > > format for these "capes". Perhaps your feedback would make more=
 sense in
> > > > > > some other part of the patch series? But even then, I'm not sur=
e it
> > > > > > makes sense?
> > > > >
> > > > > I am ok to move the cape scan detection code to a standalone driv=
er with a
> > > > > devicetree compatible match. Just wondering what are the advantag=
es to use
> > > > > standalone drivers instead of having the code in the specific boa=
rd code as
> > > > > done in this series.
> > > >
> > > > I'm not sure there is an advantage. Especially since in theory we c=
ould
> > > > have more than one built in, and if ti_extension_board_scan(...) do=
esn't
> > > > find anything (because the EEPROM is missing/wrong) we could still =
then
> > > > call rpi_extension_board_scan(...) and look for that formatted type=
 of
> > > > EEPROM and then chipanddip_extension_board_scan(...) and look for t=
hat
> > > > and so forth. These extensions are nominally discoverable and so do=
n't
> > > > need device tree compatibles, was some of the point of all this I w=
ould
> > > > have sworn...
> > >
> > > I think, he means a driver for each type of custom extension board sc=
an
> > > functions (4 until now). The U-boot devicetree would be like this:
> > > extension_scan {
> > >       compatible =3D "bone-cape-scan";
> > > };
> > >
> > > We could avoid the build of several extension drivers using Kconfig c=
hoice
> > > symbol to select only one builtin.
> > >
> > > On my side I don't really have opinions, it is a matter of code desig=
n. For now
> > > I don't see real argument to tilt the balance except to do something =
like
> > > sysinfo. We need more arguments from Simon.
> >
> > Yes, and needing to go back to modifying the device trees seems a step
> > backwards here, and something that will be hard to argue for upstream.
>=20
> How do you define the mechanism to read the cape (etc.) information?

Well, a cape for the TI platforms has to have a properly formatted
EEPROM. I forget how the CHIP/DIP thing worked, but I believe it was
similar (since it originated in the same era). I also believe Pi is
similar as well.

> Presumably it is using a device which is already in the devicetree? So
> it is the actual extension mechanism that is not present, perhaps?
>=20
> How does Linux model extensions?

Last I knew it doesn't and much discussion was had to arrive at that
point a decade or so ago. I believe FPGA stuff has been allowed since
then, but physical extensions not, and it's a bootloader problem. Which
is why we've been solving it for a while (it was more ad-hoc before Kory
did the current implementation in 2021).

--=20
Tom

--j9TYHx9SCSeRm038
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOV0bAAKCRAr4qD1Cr/k
CmfBAQCg+mexoPGqk4gxof4bFwa+x8BhjWmJJewbY5OIsR2q7QEA1bZcGGbMC/Mc
OLsQIddHfrGND/PCKPHIBFEaeURyxgA=
=ZSQg
-----END PGP SIGNATURE-----

--j9TYHx9SCSeRm038--
