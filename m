Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4E6C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB72587507;
	Thu,  9 Nov 2023 22:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FOlnlq7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3175587507; Thu,  9 Nov 2023 22:40:54 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D9E8724E
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-da41acaea52so1428567276.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699566050; x=1700170850; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4MtJTeeMrMR+7oovoaor2arbRrQD3QYcYqCIJKrYFMo=;
 b=FOlnlq7JD9Icc4PfehIiZaIDlHDzF7lwgIzJQGIVHGEGywveBcsklXuNir/B2L6WMb
 t6+ewvw4Q+JRZm2ycj6N9YUuo5wAqGmq91cTSoDTl/jeBjjVPRfYwKif8eNcqci2RECF
 i+n+oS5ZIf1PuZ+l+RfknkPK+WOI9T1EiADPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699566050; x=1700170850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MtJTeeMrMR+7oovoaor2arbRrQD3QYcYqCIJKrYFMo=;
 b=DzfFqaqFIX2xuhDgb1N0Qc6BmEmbX5r11jQIEhz4kArqA2plQKXXLEmFvJqowEeWIF
 r9tGry9VhHWk465ot6KwVLhq48YTLQyZJgCTF3gysrLqlqDYUdgpFHzlw5gGdRwUS2/z
 JQ4W7suHTXF1Pq3eV+PnRx3pN6c3rbPorOPSOg8V2t5ePRjqhIzKCABIVhcDKOOkZs+N
 0zedb9IOI6gOUP7DQ4qsF+Su2fMGRoDEfrCmyZ4K+/48sQBBTdRA2yunJKvBJqFNdbxi
 Jife1Wr6//UvdzZW9e0lpHK78uGEKu1IHubFq3+QhY9h/Bpjj850TOlfvAvnJ1X6kHCP
 j0YA==
X-Gm-Message-State: AOJu0YxhuwiFJZcLl3ggExAGEGUqIu0qIrrgByY0nc+75h15bbwkcwoj
 x0W+BgnpTbdBytIku5rHHg0XdA==
X-Google-Smtp-Source: AGHT+IHLQ06nqFAiL8hffQLMLS23fbb8dOzZBVFGJovnwcBL35VSA/frqq+Did2ZQqchWl8tDnKkuA==
X-Received: by 2002:a25:da95:0:b0:da0:514a:8f42 with SMTP id
 n143-20020a25da95000000b00da0514a8f42mr7221421ybf.32.1699566050110; 
 Thu, 09 Nov 2023 13:40:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 f10-20020ac8134a000000b004108d49f391sm2273656qtj.48.2023.11.09.13.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:40:49 -0800 (PST)
Date: Thu, 9 Nov 2023 16:40:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Sean Edmond <seanedmond@linux.microsoft.com>,
 joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
Message-ID: <20231109214047.GQ6601@bill-the-cat>
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
 <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
 <2ed00b42-66f9-4cca-a1a0-ee594840f0d1@linux.microsoft.com>
 <30e83c4b-32be-4e85-aee8-e8b87224a487@gmx.de>
 <b058f5a6-52e2-4e0c-a193-30e884b2463a@linux.microsoft.com>
 <20231108002342.GE6601@bill-the-cat>
 <CALeDE9NBpwUXcuURx-JKsRNS4C+6OBTz8Nfi76kRY_3ZSays7g@mail.gmail.com>
 <20231109210440.GJ6601@bill-the-cat>
 <44F1509A-E73F-4DE5-8885-17025FCD5E18@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IqleX0Cz7ErV0Exn"
Content-Disposition: inline
In-Reply-To: <44F1509A-E73F-4DE5-8885-17025FCD5E18@gmx.de>
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


--IqleX0Cz7ErV0Exn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 02:35:40PM -0700, Heinrich Schuchardt wrote:
>=20
>=20
> Am 9. November 2023 14:04:40 GMT-07:00 schrieb Tom Rini <trini@konsulko.c=
om>:
> >On Wed, Nov 08, 2023 at 12:24:24PM +0000, Peter Robinson wrote:
> >> > > > > > > Allow dhcp server pass pxe config file full path by using =
option 209
> >> > > > > > >
> >> > > > > > > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> >> > > > > > > ---
> >> > > > > > >   cmd/Kconfig |  4 ++++
> >> > > > > > >   cmd/pxe.c   | 10 ++++++++++
> >> > > > > > >   net/bootp.c | 21 +++++++++++++++++++++
> >> > > > > > >   3 files changed, 35 insertions(+)
> >> > > > > > >
> >> > > > > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> > > > > > > index 5bc0a92d57..adbb1a6187 100644
> >> > > > > > > --- a/cmd/Kconfig
> >> > > > > > > +++ b/cmd/Kconfig
> >> > > > > > > @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
> >> > > > > > >       default 0x15 if ARM
> >> > > > > > >       default 0x0 if X86
> >> > > > > > >
> >> > > > > > > +config BOOTP_PXE_DHCP_OPTION
> >> > > > > > > +    bool "Request & store 'pxe_configfile' from BOOTP/DHC=
P server"
> >> > > > > > > +    depends on BOOTP_PXE
> >> > > > > >
> >> > > > > > Why should this be disabled by default?
> >> > > > > >
> >> > > > > > Do we really want a separate config variable?
> >> > > > > >
> >> > > > > I expect most won't use this option to get the file path (they=
'll use
> >> > > > > the default paths as per the PXE specification).  It makes mor=
e sense
> >> > > > > for me to keep it optional, like many of the other options?
> >> > > >
> >> > > > RFC 5701 seems to require this option. Hence we should make it d=
efault
> >> > > > yes. Boards that have a build size issue can opt out.
> >> > >
> >> > > The PXELINUX specification
> >> > > (https://wiki.syslinux.org/wiki/index.php?title=3DPXELINUX) doesn'=
t state that
> >> > > option 209 is required. In the abense of option 209, PXELINUX will=
 try the
> >> > > following default configuration files (this example is provided on=
 the wiki
> >> > > link):
> >> > >  /mybootdir/pxelinux.cfg/b8945908-d6a6-41a9-611d-74a6ab80b83d
> >> > >  /mybootdir/pxelinux.cfg/01-88-99-aa-bb-cc-dd
> >> > >  /mybootdir/pxelinux.cfg/C0A8025B
> >> > >  /mybootdir/pxelinux.cfg/C0A8025
> >> > >  /mybootdir/pxelinux.cfg/C0A802
> >> > >  /mybootdir/pxelinux.cfg/C0A80
> >> > >  /mybootdir/pxelinux.cfg/C0A8
> >> > >  /mybootdir/pxelinux.cfg/C0A
> >> > >  /mybootdir/pxelinux.cfg/C0
> >> > >  /mybootdir/pxelinux.cfg/C
> >> > >  /mybootdir/pxelinux.cfg/default
> >> > >
> >> > > If 209 is requested/provided it tries the provided "config file" b=
efore the
> >> > > default paths.  RFC 5071 should be seen as an extension for PXELIN=
UX (not a
> >> > > requirement).  RFC 5071 only states "The Config File Option MUST b=
e supplied
> >> > > by the DHCP server if it appears on the Parameter Request List".
> >> >
> >> > We also want to be careful about overall size growth on common optio=
ns,
> >> > even if someone can opt-out. Those are usually last-ditch stop-gaps =
and
> >> > it's better to make sure we really need functionality X/Y/Z by defau=
lt,
> >> > for everyone. Especially with all of the work going on to make HTTP(=
s)
> >> > based network installs a viable option, how much more do we want to
> >> > change the PXE case, for everyone. I'm personally somewhat looking f=
or
> >> > the use case to be well defined for a "this must be default". Network
> >> > provisioning is a thing, yes, but for whom/what, and in turn how bro=
adly
> >> > do we need this to be in the vast majority of our boards (since it w=
ould
> >> > come in via BOOT*DEFAULTS or DISTRO_DEFAULTS).
> >>=20
> >> If PXE is being enabled I think it's useful in that it means the PXE
> >> client can be largely stateless because it can all be provided by
> >> central netowork configs as opposed to either hard wiring it into
> >> firmware or someone having to manually set them. This is likely also
> >> useful from the PoV less reasons to have a shell if it can be dealt
> >> with in code.
> >>=20
> >> From the PoV of defaults, with or without HTTP boot, I suspect it
> >> probably makes sense to review whether PXE as a whole is enabled by
> >> default. That said a number of silicon vendors are actually actively
> >> removing PXE from their reference FW in favour of HTTP Boot due to
> >> security and a number of other reasons (easier for firewalls,
> >> caching/CDN, edge use cases outside of the data centre).
> >
> >I guess I don't understand how frequent a use case PXE boot is, on the
> >types of platforms U-Boot is usually found on. Clearly, some people and
> >usecases use it. But I also think part of why it's default enabled
> >within the "distro" frameworks is because initially we didn't have
> >"parse extlinux.conf" entirely split from "do pxeboot" as the conf file
> >parsing started there. I guess just something to evaluate down the road,
> >and perhaps make it a regular thing to evaluate defaults and provide
> >some notice when we might disable features.
> >
>=20
> For security reason it is preferable to disable PXE boot if it is not rea=
lly needed. So default no would make sense.

We can evaluate things and make sure everyone knows when changes are
coming, for the future. We've been enabling it by default for years and
"for security" isn't a great reason. It's one of the last targets tried
and I would argue if there's malicious actors on your network serving up
bootable payloads to random devices, there's bigger problems afoot.

--=20
Tom

--IqleX0Cz7ErV0Exn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNUd8ACgkQFHw5/5Y0
tyyyXAv/V3Yb9Anp5b9/PaKUDguwPcAixIraoDnopvfFnE6xRlHFZKWhnGfzP29n
NZ2gJR979CMRIADqxdBFv1D0iiRSHqlXCMiIgsOXIRgwce+tTePXOBE5QZbLGWDU
P/CPkrvEkOoeaRZk2Fn+yWhP/kLKtRjbBzdrKpuRWgqMlKXbMGijbjjAA1r4D2+S
s1BbDfi+c93C2Efp8hmCgpHM8Nl/QgnvHYUFse1lYHhxtPQapcZpTO5N8Jwc/JSn
qZPDH1PBOnj0/NdIELDn9gLt8v9j2/3qeSFs8yfLsSSdD4gbr9VZScXngsfagztW
8rejLDI3l7AJM3Q+xzPgObN3QR617qnRSvmNyubPUr21JTajPWPRatXWuXOoWOOw
dcWpOcX3uR+hVSZtsE6EosOeWGmNUZTo33W/DkxE+9I0t9gw3tE5CYnI9oTkheQO
ERsL0/yUKet/THq6GbhkcikXnG1dOL+GaK/q+Xavl84jgMorS+IPPBIVS3Wfr9bW
ndnHCUlv
=niaY
-----END PGP SIGNATURE-----

--IqleX0Cz7ErV0Exn--
