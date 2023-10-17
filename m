Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC64CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F6A86BA1;
	Tue, 17 Oct 2023 16:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lv85E/Cs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B0C86BA1; Tue, 17 Oct 2023 16:16:19 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6159286380
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7dd65052aso78114327b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697552175; x=1698156975; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bmH4wkFU4zTHE5sO5AX0WHjSnRGA1oWrcdGikc1Ch/Y=;
 b=Lv85E/Cslrrj3uZaEa821S2/3ngY2zGP8wT0AgsSZ78O+PYojZLRlnX6o9RNoIgEDz
 H44CWt1DThJinRzvsg+yOK9xwEIm+hQCi9d+hCllTX0xJtWLU2fNuOVfK9RxEGCwHKoo
 bIVXMICed6fezFXRg1ilPHO0pnblivG12pQ1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697552175; x=1698156975;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmH4wkFU4zTHE5sO5AX0WHjSnRGA1oWrcdGikc1Ch/Y=;
 b=LEVAHEDtRvQKSSlHl0Q7RYMN+YBCuCBm1brxmbyVe+Kplw4OMC++xRYf/xDw8tAbKT
 VHvnf56l3rclNIJMAnK1HN5lVJyYmzjKNy2rKgEDn/mipizsME8CSlGJ5XztkFaRv/bL
 VJk8wc9//C7teWhs8b0FHtK59+mFA1Yz92ScuB54l/D5VpFpMZLmueob37AdGKpRPC4R
 F7rmrB1UohjHMEte5TkcXJoPf9xSeNKKqW8t3guzCYWwujWHLe+5ao6dMqMsc8kOGIYJ
 n5Ax2MQrnTN2aF/Pu/kcWkg+oSwtXdrk7FlJQTKwO78PjZAZG4OvkO16i+mm6c527B24
 p3pw==
X-Gm-Message-State: AOJu0YyKvjmT+/kOCklNDyKSsjhrjHb5eDgxiTfT0LNe5gaQc74jLlLy
 ha9xqzqt+WicFChBdPf7g7E/sw==
X-Google-Smtp-Source: AGHT+IFAJhmUen4jiuUei1q3aagSU2tMVZJI8jE7zac5WdW0c89SuzdihheVKsFvHlZKsbcyUD+7XQ==
X-Received: by 2002:a0d:f701:0:b0:5a7:b481:4dd2 with SMTP id
 h1-20020a0df701000000b005a7b4814dd2mr2388656ywf.47.1697552175142; 
 Tue, 17 Oct 2023 07:16:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 n69-20020a0dcb48000000b0059f8120ee4dsm649790ywd.30.2023.10.17.07.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:16:14 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:16:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Michal Simek <michal.simek@amd.com>, Da Xue <da@lessconfused.com>,
 Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint
 issues
Message-ID: <20231017141612.GE3119521@bill-the-cat>
References: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
 <2016c1bc-dfe0-416e-a910-75e6cf25036c@denx.de>
 <CACdvmAju3wDL0yCJtVdEf47u+L5R3AvRpcuJ+ruKFXDTcQ-TBw@mail.gmail.com>
 <20231013151540.GJ3119521@bill-the-cat>
 <041b37d4-777a-4c02-b8fd-9985c2cfa938@amd.com>
 <20231016193052.GF3119521@bill-the-cat>
 <e8501850-b440-4e2c-a120-875924f59453@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i0PnDn+i+HjNnMh3"
Content-Disposition: inline
In-Reply-To: <e8501850-b440-4e2c-a120-875924f59453@collabora.com>
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


--i0PnDn+i+HjNnMh3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 03:48:37PM +0300, Eugen Hristev wrote:
> On 10/16/23 22:30, Tom Rini wrote:
> > On Mon, Oct 16, 2023 at 08:34:16AM +0200, Michal Simek wrote:
> > >=20
> > >=20
> > > On 10/13/23 17:15, Tom Rini wrote:
> > > > On Fri, Oct 13, 2023 at 11:11:04AM -0400, Da Xue wrote:
> > > > > On Fri, Oct 13, 2023 at 7:47=E2=80=AFAM Marek Vasut <marex@denx.d=
e> wrote:
> > > > > >=20
> > > > > > On 10/13/23 06:53, Venkatesh Yadav Abbarapu wrote:
> > > > > > > The xhci host controller driver trying to queue the URB's and=
 it is
> > > > > > > getting halted at the endpoint, thereby hitting the BUG_ON's.
> > > > > > > Mostly these kind of random issues are seen on faulty boards.
> > > > > > > Removing these BUG_ON's from the U-Boot xhci code, as in Linu=
x kernel
> > > > > > > xhci code BUG_ON/BUG's are removed entirely.
> > > > > > > Please also note, that BUG_ON() is not recommended any more i=
n the Linux
> > > > > > > kernel.
> > > > > > > Similar issue has been observed on TI AM437x board and they c=
reated a patch
> > > > > > > in Linux kernel as below
> > > > > > > https://patches.linaro.org/project/linux-usb/patch/1390250711=
-25840-1-git-send-email-balbi@ti.com/
> > > > > > >=20
> > > > > > > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@a=
md.com>
> > > > > >=20
> > > > > > I already explained to Xilinx how to sync the driver with Linux=
 and why
> > > > > > this is needed to move forward, multiple times, and even provid=
ed a
> > > > > > script which does most of the work automatically, since it is b=
asically
> > > > > > automated process. Xilinx did not even bother to test the scrip=
t and
> > > > > > provide any feedback.
> > > > > >=20
> > > > > > Until that happens, this patch is rejected.
> > > > >=20
> > > > > This patch also causes all of the USB devices on certain platform=
s to
> > > > > not be detected:
> > > > >=20
> > > > > scanning bus usb@c9000000 for devices... Device not responding to=
 set address.
> > > > >=20
> > > > >         USB device not accepting new address (error=3D80000000)
> > > >=20
> > > > Yes, we are stuck at the impasse where the custodian is asking for
> > > > someone to try and do the re-sync, and everyone else will assist wi=
th
> > > > testing on other platforms, but the re-sync hasn't happened.  Can we
> > > > please get someone from AMD to attempt the re-sync?
> > >=20
> > > I would like to say that we have someone to do it. But I simply don't=
 have
> > > that person.
> >=20
> > That is the big problem we face, yes.  Eugen, I think you said you were
> > going to try and find time to do a re-sync, did you end up getting any?
> >=20
>=20
>=20
> Hi Tom,
>=20
> Unfortunately at the moment I am working on a different project, so I do =
not
> see any perspective to do this in the near future, although I would like =
to
> do it and to help.
> It may be the case that a company investing into an engineer to work on t=
his
> would be the only way.
>=20
> In any case, do you think Marek would accept doing this incrementally , e=
=2Eg.
> now the driver is synced with 3.10, it would be easier to increment to 4.1
> as a first step ?

Incremental updates feels like it might be less of a daunting path to
me, so I'd be agreeable.  Marek?

--=20
Tom

--i0PnDn+i+HjNnMh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUulywACgkQFHw5/5Y0
tyyF1wwAgH96NO+GBiYJ5xH8rE8sCRYX8XG6QzeL+QA2HzexMPgfnBLy3DhWeDhc
CByclS39sLLq1pNgG2KuPOxGhi4iGHSrt30G90fY6ss0QJtogtj9tKk/JAOmO3W1
gSFtU3Jjq3SL2/w3/LsxTWlcScJX3tgo5P+CkMB4xBlyX6qogwQkSRl/vn8pP03Q
2eGFD0qZlI15TuBCxvDwA2oCJIhEj1ohjWL2FmpRDzPQvvg2VIX5fR5w1yjOE5pj
2IG/Tnl9IR6f+mpLETPwhx2zpX0NETm3i0JUKeyPTZ8XVF2QdcMtTKmaKYyD6hz0
u54fTKkg4ij6RLqie0Q0o+/nA/8Rxoeu02hnFPHi7OdjL2KT0JeCXkrhwdOSp/kD
tv+tOFGK8Ru08VFOuqp5CPqpm4Sve0mMWZTDaruOZZlItFVdRPIz+kSbt/pMHay8
SEMs77jBrXeGZvRr1JOThA4fQH26UV9vxjjHBLJlqr87CBr/0VIG7RVIycdjeVR2
2KQW6P6B
=QU1a
-----END PGP SIGNATURE-----

--i0PnDn+i+HjNnMh3--
