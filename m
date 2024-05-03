Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118C2C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 21:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63ADF884B3;
	Fri,  3 May 2024 23:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OGzxGxjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB1FA884C1; Fri,  3 May 2024 23:18:13 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D5C688416
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 23:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7906776e17aso3083485a.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714771090; x=1715375890; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h4F0mzQR8f3AaOSN1iOuGFfDOKdjhaOpb0XIuMV/O4k=;
 b=OGzxGxjFM4LC4qQTR6b5FgFPo3yv6rG+bX3cp9/ZtoWei4PA4d+rJCP4+LwPIwpaDU
 CKrSwDG2LpZc/jQG/jnrjv+57iU9Mg5fOZeSr6yCzO6y/z0y5amYOfKOINJ60d81u2cK
 4WCb/JyZxd/ob04bF8rF3+zL4J+FuIdhWLlEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714771090; x=1715375890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4F0mzQR8f3AaOSN1iOuGFfDOKdjhaOpb0XIuMV/O4k=;
 b=gPJbpsyAvOVz8vTxbFSidIwtLmaW8ZoU+3R3Z8qW8WLZY5es8yjnl3SviVPOB29xYr
 k782P5f6suQSbj3fwVobmgTbzfNwoDCQGGlX5gpYwjvX9eWAc7NdBfV5/FOhvBF5zG5v
 CbR7rNI/AWtTcSLljy6KPGSFNHIFcwgRfh4OeGJ9nOW8UdxUm0FPJYK7lDSAUi+yPwzr
 Sy5iSsYJRcVufOWGBYwqPD6t1fSyM/TUL9yAaYRCQW3PiitW67QErhAfMpyksq2T1gKR
 d0i+RqOjKbLRozsZFF/xUvXW+qEFSI/RV5SOmI5LjVsSf/FTGm6XKFxhx88m4+MY9nG0
 Kz2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9fy32IIo54fgMm5dcmqmTUr/26uMaIcdWe7S7/j5b09/ihYSTCrfKLMkHi43LBffjkTelxd/Iwaehl5C6HPhzAbeI+w==
X-Gm-Message-State: AOJu0Yz5SyXnZcZyEE9CDFnPXGJb+OT4tX3b+DJhmAb8NCO9HB6PfWmv
 U9UlXB13mloHw9oVkqPYjVoZ74tlIsF0WU3JKpEtAkotDiTV+UjWA+8z/6xXuxs=
X-Google-Smtp-Source: AGHT+IFrJfayukj3SswVtqcltsbeC6TP8BLTRM9Wkmqz8mU4nz22Xk9w5mvg2b5gIwAq2M+++isX4Q==
X-Received: by 2002:a05:620a:95b:b0:78e:ba1b:822b with SMTP id
 w27-20020a05620a095b00b0078eba1b822bmr4266753qkw.56.1714771090200; 
 Fri, 03 May 2024 14:18:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 m4-20020ae9f204000000b0078a54c25ea6sm1547284qkg.56.2024.05.03.14.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 14:18:09 -0700 (PDT)
Date: Fri, 3 May 2024 15:18:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] dm: core: add support for fallback drivers
Message-ID: <20240503211806.GZ1054907@bill-the-cat>
References: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
 <20240410-b4-stub-drivers-v1-1-6935bd2c07d1@linaro.org>
 <1EFAA3ED-7C3B-43DA-AA0A-FC520FF16290@gmx.de>
 <20240410194452.GG2493117@bill-the-cat>
 <61d7423a-5240-c746-b724-4d51b7d5ad74@gmail.com>
 <e7ccadfb-6ba8-4106-be0a-9fffcf2067e2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gjOiKYnheYb0LH7V"
Content-Disposition: inline
In-Reply-To: <e7ccadfb-6ba8-4106-be0a-9fffcf2067e2@linaro.org>
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


--gjOiKYnheYb0LH7V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 05:53:11PM +0200, Caleb Connolly wrote:
> Hi all,
>=20
> Sorry for the slow follow-up.
>=20
> On 11/04/2024 04:37, Sean Anderson wrote:
> > On 4/10/24 15:44, Tom Rini wrote:
> > > On Wed, Apr 10, 2024 at 07:27:17PM +0200, Heinrich Schuchardt wrote:
> > > >=20
> > > >=20
> > > > Am 10. April 2024 19:06:57 MESZ schrieb Caleb Connolly
> > > > <caleb.connolly@linaro.org>:
> > > > > Introduce support for a uclass to provide a fallback/stub driver =
which
> > > > > can be used when no device is found for a given node. This might =
be
> > > > > useful for handling non-essential clock controllers like the RPMh=
 on
> > > > > Qualcomm platforms, or during early bringup to get UART output be=
fore a
> > > > > real clock driver has been created.
> > > > >=20
> > > > > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > > > ---
> > > > > drivers/core/Kconfig=A0 | 10 ++++++++++
> > > > > drivers/core/uclass.c | 24 +++++++++++++++++++++++-
> > > > > include/dm/uclass.h=A0=A0 |=A0 3 +++
> > > > > 3 files changed, 36 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> > > > > index 1081d61fcf01..09075b9b7a15 100644
> > > > > --- a/drivers/core/Kconfig
> > > > > +++ b/drivers/core/Kconfig
> > > > > @@ -466,5 +466,15 @@ config BOUNCE_BUFFER
> > > > >=20
> > > > > =A0=A0=A0=A0=A0 A second possible use of bounce buffers is their =
ability to
> > > > > =A0=A0=A0=A0=A0 provide aligned buffers for DMA operations.
> > > > >=20
> > > > > +menuconfig FALLBACK_DRIVERS
> > > >=20
> > > > Wouldn't it be preferable to mark individual drivers as fallback
> > > > drivers in their declaration?
> > > >=20
> > > > This would allow alternative fallback drivers and would not
> > > > require any definitions at uclass level.
> > > >=20
> > > > Just by building a fallback driver you would enable the fallback
> > > > behavior for its uclass.
> > >=20
> > > I think some of this is addressed in the cover letter. My concern /
> > > questions come down to I think just a matter of naming. Both "fallbac=
k"
> > > and "stub" are used at times. As a concept, we have some areas where =
we
> > > need a no-op driver because whereas the DT describes a relationship in
> > > the hardware, here in U-Boot we can just accept things as configured.=
 To
> > > me "fallback" implies more functionality of the driver when it's real=
ly
> > > just a generic no-op driver to fill in the dependencies within the tr=
ee.
> > > Can we rename things a bit along those lines?
>=20
> Yes, will do. I originally used "stub" but then decided "fallback" was
> better, but I think you're right that stub is the right way to go here. A=
s I
> agree that "fallback" implies some kind of real implementation.
> > >=20
> >=20
> > I would rather just have a stub driver with compatibles for all clocks
> > we want
> > it to match. I think having a generic fallback driver could cause issues
> > in the
> > future if we need to switch over to using a real driver.
>=20
> I don't think either approach is significantly better from a developer
> perspective. With my patches if there a driver with a matching compatible
> available then you will NEVER bind the stub, even if probe fails on the r=
eal
> driver. With your proposal we'd have to remember to remove the compatible
> from the stub driver or risk the race condition when binding drivers.
>=20
> There is another subtle but important difference if we were to use a
> compatible list in the stub. It turns out that CONFIG_OF_LIVE affects the
> bind behaviour - U-Boot won't try to bind the children of a node with no
> driver when using the livetree. This is arguably more "correct", as usual=
ly
> child devices depend on their parent, so we save some cycles by not bindi=
ng
> unsupported devices.
>=20
> But, the RPM clock controller which I originally implemented this feature
> for is such a case, this is the DT (simplified for brevity):
>=20
> rpm: remoteproc {
>     compatible =3D "qcom,sm6115-rpm-proc", "qcom,rpm-proc";
>=20
>     glink-edge {
>         compatible =3D "qcom,glink-rpm";
>=20
>         rpm_requests: rpm-requests {
>             compatible =3D "qcom,rpm-sm6115";
>=20
>             rpmcc: clock-controller {
>                 compatible =3D "qcom,rpmcc-sm6115", "qcom,rpmcc";
>             };
>     };
> };
>=20
> With livetree (which we use on qcom) we would need to stub not just the
> rpmcc but also the rpm-requests, the glink bus, and the remoteproc (yeah
> these platforms are a bit silly, I know XD).
>=20
> However with the fallback solution as implemented in these patches, we
> totally sidestep this issue by directly binding the node on-demand,
> something we can only safely do for a stub driver as we don't need the
> parent devices.
>=20
> So I can either:
>=20
> 1) Make OF_LIVE behave like flattree and descend into all nodes (I don't
> know if this would cause any issues, but I think the livetree behaviour is
> more "correct" tbh).
> 2) Add stubs for all 3 of the parent nodes (and manually maintain a table=
 of
> compatibles for clock drivers we want to stub).
> 3) Stick with this approach of binding the stub as a last resort.
>=20
> Obviously I've already put the time into 3, and that would still be my
> preferred approach, but I'm open to other ideas.

I don't like option 1 either. But I don't see why option 2 is worrisome?
Yes, if adding a real driver for something we had stubbed out, we will
need to remove the compatible string for the stub. But that shouldn't
happen often? And we can put in a debug level or similar print so that
if someone is at the point of adding a new driver that had been stubbed
out and didn't remove the compatible stub to start with it should show
up pretty quick in looking at logs?

--=20
Tom

--gjOiKYnheYb0LH7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1VIcACgkQFHw5/5Y0
tyzDSwv/S25EZB4a34xP53N7Kqy7JQXXZcp/S7dOXWYAzciYAOjsF2tfszs27wbX
TuuBr3QvCcfIdhZj+7Ar5mkmiG065slCTKT2gjGYbgIRZ7GUAZhxU7VLXlzcVJEb
keoXfdlWKn3NjejarYY/P3x2a0zPvE4npM9K3hBFXCZII/be1iZltMHpwcvqiK7Y
Hu1YsMVZQAXcEGPjdUQz8A89eTGnc57aEtAHvShiOSk7R9doETqPhN105LXRJGvk
HjIcIzzI0DenbCE7pLLP4NG9xtf85gIznfZwhtIwpBltkOyuRNGHA3puU7fzLwOn
n0dv/sCrCujVMWFcMFMJNb76mZcNwl8ZxsMCuaCCdygSlY+df6xro/x2xUbHQqFF
vJHL/RaR8thWoV99bsf/kSxFMGAzn+1dbDOGS10M+Grvxbd1sp/0568Zd2pBHEv2
u7SaPFBekd+DTuOQ+Ek2v6gVHGA4ML1vah6fsbUZVukUJTv76vU8mhoy2RlXQ1aI
+UbJMK7B
=V7lN
-----END PGP SIGNATURE-----

--gjOiKYnheYb0LH7V--
