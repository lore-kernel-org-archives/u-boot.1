Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384F6C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF32A82E25;
	Mon, 26 May 2025 20:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s5kJtVwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05AF082E35; Mon, 26 May 2025 20:15:22 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525F682D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-605fda00c30so1056931eaf.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748283318; x=1748888118; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RmKkMBDycCKpFBpnDIP1iYgZAZOpkeduu9tXU8dFXXI=;
 b=s5kJtVwC4IDoEUTp1iX4iqrQUUP+7Ed3L3OphLvTEhjrEhIKKkjMNJYwMtgh6NJ9RE
 RjFMSPSS1BbHvpriZSWqLH55sPt4P7YBu420+zOCY+wdwad9oERsSYrBRrA6PQ6EZz6F
 bClAeuyBbRuO0veZfgj2ab0BhNZBkzC9YvWdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748283318; x=1748888118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmKkMBDycCKpFBpnDIP1iYgZAZOpkeduu9tXU8dFXXI=;
 b=nEIGGdNFcQVjyDInZIbeLOGDN8gYe0KBBBsq1DEhd0fQ1VPpdw3qKm3tLf0yfwnFGI
 bN5lYhRNYXuzME6041l34sAPz+M0VD33bAhHuovQsFSUGXoPg2bD3c5Q80TEHRpS12Ds
 MgJiJhARJ5v42FnHNnitZGsZXovcnVvWHzCKX0hZPacWMwPJnJGyAsUwCZfxR0l6MSW0
 vpPy9dPWdStjsputYPyZtJlB2bcK0ySLP/E0Q9J5NrXWMPLmmdRJKsUH6axgO1JnqMsM
 xImr26hBPTPImJdomQpVzUJeq0Nr1OymifbCJAiuEr3em6Chp8zRcDNLlikCOuwhqkK4
 d+8Q==
X-Gm-Message-State: AOJu0Yyo1YMobbfxtnDOe55NJelPDBMhU5RCuYysjR058eGpckK/KVPm
 Snvxnk3y7x7Dw0TRFNKR/mGCdRmuLAfWoKEB0KXxtPCz+EjchEwBBIlJQdJJS63+eGPDzBPh0W5
 RmXIeG/M=
X-Gm-Gg: ASbGncuG4fS9pI1JEjFfi3wZHdAjumpkqADOw0TT4hHBfSnU+UeKi+Q+ukNdGQ8RQMU
 W1aPoGZ291pp5jyVlrfGyMAaN+w4jkncwz/9+oIEKtrJIbb3W2t4oAfW0GWMDWRwEgQM6ZbICER
 QY0COAtTW1Vy8CSY8ZoZgwsHoDd4rObav7UUCo81fEUdmxQL1VrTc3Q6NioKy7F/XUoTQqfd3dL
 HuATUyQPfANTr9k22khDmwMPpLFT/O0+rVpm/zgH7w5dopuSTKX0LgSYyaDzvcJ0w0ybQ93oQsa
 uHq/mX37KjwUmvDhehWcwV1qJeR/klmd8yYjrkLoUyKOCWDw5HvuAeN5TFfHjAoIXHC4MWigPo8
 o/JDBEvRbZyYu
X-Google-Smtp-Source: AGHT+IF4/AdGcKVj5XnqaVdtKc16lt/sAa2qzMjqTK7z+Fqx91HUXCNorhhwSOB2toi478+mOJC7GQ==
X-Received: by 2002:a05:6820:270c:b0:60b:c7bf:5ff4 with SMTP id
 006d021491bc7-60bc7bf6141mr721204eaf.2.1748283317863; 
 Mon, 26 May 2025 11:15:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f5f847sm4592496eaf.24.2025.05.26.11.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 11:15:16 -0700 (PDT)
Date: Mon, 26 May 2025 12:15:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Xu Zhang <423756212@qq.com>
Subject: Re: [PATCH v4 09/22] passage: arm: Accept a passage from the
 previous phase
Message-ID: <20250526181514.GZ100073@bill-the-cat>
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510154214.v4.9.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
 <20250514215821.GD603748@bill-the-cat>
 <CAFLszTg2vMEVSR--ksh9cVRHBQWxzC++Nf83iDq7utUwku8Hrg@mail.gmail.com>
 <20250515205413.GD100073@bill-the-cat>
 <CAFLszTgHg6VfuJbTwdbkfAu4s-ZG0EpZ+6W5i13vC5iu=c+16w@mail.gmail.com>
 <20250524145313.GP100073@bill-the-cat>
 <CAFLszTh0+8eDAwu7AxcZ28W_sSEGPGSKufh9PY9ZDr=U-F-a1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UikPMPCTfOM8GloD"
Content-Disposition: inline
In-Reply-To: <CAFLszTh0+8eDAwu7AxcZ28W_sSEGPGSKufh9PY9ZDr=U-F-a1Q@mail.gmail.com>
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


--UikPMPCTfOM8GloD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 04:29:05PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 24 May 2025 at 15:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 24, 2025 at 03:31:08PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 15 May 2025 at 21:54, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, May 15, 2025 at 09:26:42PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 14 May 2025 at 23:58, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, May 10, 2025 at 03:42:07PM +0200, Simon Glass wrote:
> > > > > >
> > > > > > > Accept a bloblist and control devicetree from a previous phas=
e in
> > > > > > > registers 0 to 3, as documented in the Firmware Handoff
> > > > > > > specification[1].
> > > > > > >
> > > > > > > Note that there is currently a weak function called save_boot=
_params()
> > > > > > > which happens to save the same registers as are needed for th=
is
> > > > > > > protocol. But it seems better to implement this feature as a =
first-class
> > > > > > > citizen, if for no other reason than that many boards have th=
eir own
> > > > > > > version of save_boot_params() which may not happen to save th=
e required
> > > > > > > registers. A weak function is not a good basis for an API.
> > > > > > >
> > > > > > > [1] https://firmwarehandoff.github.io/firmware_handoff/main/i=
ndex.html
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > > While some efforts were made to encourage Intel to adopt this
> > > > > > > specification, this has not yet been successful. However I do=
 intend to
> > > > > > > use my proposed x86 handoff in U-Boot, once this series is in.
> > > > > > >
> > > > > > > Changes in v4:
> > > > > > > - Update commit message to indicate this can only be for ARM =
at present
> > > > > > > - Update commit message to mention why save_boot_params() is =
not used
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Add support for aarch64 also
> > > > > > > - Update registers to match the Firmware Handoff protocol
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Use three registers instead of two for the entry
> > > > > > >
> > > > > > >  arch/arm/cpu/armv7/start.S | 10 +++++++++-
> > > > > > >  arch/arm/cpu/armv8/start.S | 12 ++++++++++++
> > > > > > >  arch/arm/lib/crt0.S        |  6 ++++++
> > > > > > >  arch/arm/lib/crt0_64.S     |  6 ++++++
> > > > > > >  4 files changed, 33 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > This is what makes me think you aren't actually working on my f=
eedback
> > > > > > about taking what we have in-tree, now, rather than just forwar=
d porting
> > > > > > your old series and deleting the current code.
> > > > >
> > > > > Well, yes, I sent this v3 series because I had thought you were
> > > > > willing to allow me to maintain bloblist. I certainly appreciate =
the
> > > > > work in this area, though.
> > > > >
> > > > > >
> > > > > > We have save_boot_params doing exactly what it should today, in=
cluding
> > > > > > saving off a standard passage and making what was saved availab=
le later,
> > > > > > in an intentional fashion. If, hypothetically, Pi needs to over=
ride
> > > > > > save_boot_param because a future new-firmware-blob does standar=
d passage
> > > > > > but at run time we want to support both, that's a good thing.
> > > > > >
> > > > > > With commit ea3348ebc215 ('Merge patch series "Handoff bloblist=
 from
> > > > > > previous boot stage"') we already implement the specification i=
n [1]. It
> > > > > > is not a "which happens to". It is intentional.
> > > > > >
> > > > > > I guess the overall challenge here is that you want to do thing=
s which
> > > > > > are a superset of the firmware handoff spec itself?
> > > > >
> > > > > Yes,, much of this series relates to putting some structure into
> > > > > things which are passed via standard passage, including validatio=
n.
> > > > >
> > > > > I actually don't understand why you would be keen on using
> > > > > save_boot_params(), a weak function, used for board-specific feat=
ures,
> > > > > to implement standard passage. We should build standard passage i=
n as
> > > > > a first-class citizen. I certainly don't want to try to implement
> > > > > things that way on x86.
> > > >
> > > > You seem to have misunderstood a lot of things and perhaps need to =
go
> > > > and re-read the feedback. Nothing about a weak function implies less
> > > > than "first class" and "maintain the code" does not equate "delete =
and
> > > > replace functional code with the same thing, but I wrote it". And i=
f you
> > > > aren't going to do that, please don't bother posting a v4 either la=
ter
> > > > this week. I feel like I'm having zero progress with you taking my
> > > > feedback on anything at this point.
> > >
> > > Are you completely set on the idea of a weak function here?
> >
> > Am I completely set on following the general architecture and design we
> > have and not making needless changes? Again, you seem to have either
> > misread not not understood feedback and are intent on doing what you
> > want anyhow.
>=20
> The save_boot_params() mechanism is ARM-only and is not suitable for
> standard passage, IMO...
>=20
> So can you just tell me whether you are willing to have the registers
> saved in global_data early in startup, in assembly code? I want that
> before progressing with standard passage on x86. I don't need to say
> yes. I just need a clear answer, so I can decide which path to take.

I already replied in another thread that fine, we can try your idea. But
I'm going to note here that trying to write to global data before it
exists seems like a bad idea. Something is only "ARM-only" by virtue of
being in assembly because it's too early to be able to use a C function.

--=20
Tom

--UikPMPCTfOM8GloD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg0r7IACgkQFHw5/5Y0
tyw5EAv/XlVbJOYbxqUS4djKBPUaU2gRjhqfZE3aNSx+WfuZciiR2NFC+hDPRkoi
0iIF1Ju5Anufm8uBBVTNMyHJFiyrGcaY4QqVhqO7SOFQyTzkY9aIbDvCltttabMK
7EeTV5bwQ2PAhYvhyECXQcwzCBBrXQ3AYuo8+sclOX9i8E6LmEYiT0za9WsW0bdh
qr/TvBs9I42+MWSnRpaQk/s3TSp2zA0zt/zkLjcfLJiGSsHtBOoNoAspjNUpzB9B
V5dWJ3Jbe5IHfILeQelaGFhmu710HZoIFttMpcqDuZ5IZeat20r2XFk9qBSE0EIf
jBTrJBLVsrDcoug5sCZDe9oVNjzA16o/Ql0syedUOowaRnS7GhBuYkuOXd8hpRjE
z0IfUQkfrH36pESAbKbu2CVbbcMGsUajTERNTTksUjvWbiltEqmSezdRWLaEt0+n
8YFw2OqmGCQhK8CLqcK3se+za+nCFDF5z6B5lJFoLz8bEwr1qF4X9rMX1sWshFOr
RrZhW3Q5
=23QD
-----END PGP SIGNATURE-----

--UikPMPCTfOM8GloD--
