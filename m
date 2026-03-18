Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1556103E190
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F3183F6D;
	Wed, 18 Mar 2026 15:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q+JzcBBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEF383FA3; Wed, 18 Mar 2026 15:57:29 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9BE83952
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-404254ffe8aso628770fac.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773845846; x=1774450646; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CY2hnsscBctaFGkE8MILLzbH5zKyPT5KreUQv4Z2tNI=;
 b=Q+JzcBBHl67uDl3cvBcpY5mT1KWFvaR2v5Uwi8WnxpdQTSQ3eEWi5YgoKtykjqJWdg
 mmh9lMKW/lhFruIWYEtYN9GSSR22iWYHcrQexsJBW2+nw2qirw0iXAKURRyo21GGVUVB
 B8kqZbF2ngpjLsLjj7s0mi4Fs6LRxf6lD47iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773845846; x=1774450646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CY2hnsscBctaFGkE8MILLzbH5zKyPT5KreUQv4Z2tNI=;
 b=DwWJIO6fSNTPiHEEKvbr5sqn7/jxFSSpNWbFzr/UTKwrb/PEUk6rVB+HLGJH0DRSbH
 vNgaLQ8vgGmnQ3vZbJA6QDlVhaY6No/Xo+COnA6j+DKeClvfULgPGtRm6X11hgGisTV9
 df8UNhZcI/3XI01mhjdo/hA297LxapLFtq86d5XArSeVdSWGVgThdK1d6do+zh+BE2QG
 ISuWYnU3ndOn7OPMSnNE/9JEG8zgjSCSksExSd/vbGaEUcLGp+QURlHyeu1YldurALqR
 GMg/CwrMZ0krmronNDOxjMP7SCnCyDFi49YLMl4JSnD/Hw4nuJdhuOIh0E5ghK4JZRph
 XxxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzQsFAD5eGxLlx6N5AUyd5EVNrnihWWJtlU9X7IsuXsc2XVriWqKu87JBRBtZKzJRWb5UblvA=@lists.denx.de
X-Gm-Message-State: AOJu0YwdztrtBBJVlhMEf1UJml2/OQQUBcf/tcDjvDnGJ6pmUDqIfX63
 WeqKP5Kz83q4KYcT9CRgE1Wh5zXnjfdvO0zj9diXoyBo2o3w5SduaZ+jYh+3r69yDdk=
X-Gm-Gg: ATEYQzwvShTDjhr9V8QpOYbT8BpGk5Xc+fQwjAlB76R04e5rVtAWh1AWW51KTgoWkiF
 RmOQPzUqvDqpjtBOsr0kkwtKPCXH3vP0GDgC4xiJEFXvzG/vXJOIXaE7r4rUP70nLC7sbrpVe/q
 NbQSfcHsmllkkrwtDFqrwpVMUl0mPYdPEPf3XUN1HbjlhzAL2CcFYHCI/cA4HOWMHlUJtMevtE2
 4AHLtFFNdLSlhTJqdWH1Dfx7pnI6IxbFt4gWsgHqIbj9OGnkI2xCdfl+gyReWZBhcZdZ2d2Ul2o
 ljSw5G8llWo0JsmJulM5pK6FeX72SWEAIcV4lhz6gwgqy4Avb/xMykRzAAW3TIh/QWTrmjDpI6m
 fdEgh+5b2y3bhvtcjYym48OylVixGzqEb+2OehEO2zt1yZss7AuYlXCB5FOxosZnIFyZxD4RvGR
 g5OXK2Rg2BBgk8SWHDYpcuX0lsVvTvNOQUqzZAjTquopu5IEul4aqzuqXez/pnY4oiD1xcSNZrt
 psoY/Dh9hnZQuqLWRm0IjNO/jou65SkOf3d6akzGTWfphAD
X-Received: by 2002:a05:6870:4409:b0:417:1037:76a0 with SMTP id
 586e51a60fabf-41bb0881ca7mr3878238fac.23.1773845845601; 
 Wed, 18 Mar 2026 07:57:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2c3111dsm2733191fac.12.2026.03.18.07.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:57:25 -0700 (PDT)
Date: Wed, 18 Mar 2026 08:57:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
Message-ID: <20260318145723.GL502704@bill-the-cat>
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
 <20260317134427.GU502704@bill-the-cat>
 <CALeDE9MVgs--ABnZZ4RJDOnTLM-+imKxG6iJBGmQFHHXivLMxw@mail.gmail.com>
 <20260318014701.GJ502704@bill-the-cat>
 <CALeDE9O=y6fGKd50eiW3Och7vQWKvj_DzuB9UeNLnvj0rqezmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5zzHdHWObabZI0+/"
Content-Disposition: inline
In-Reply-To: <CALeDE9O=y6fGKd50eiW3Och7vQWKvj_DzuB9UeNLnvj0rqezmg@mail.gmail.com>
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


--5zzHdHWObabZI0+/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 11:00:14AM +0000, Peter Robinson wrote:
> On Wed, 18 Mar 2026 at 01:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 17, 2026 at 04:08:22PM +0000, Peter Robinson wrote:
> > > On Tue, 17 Mar 2026 at 13:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Mar 17, 2026 at 08:42:39AM +0100, Heinrich Schuchardt wrote:
> > > > > Am 17. M=E4rz 2026 08:03:47 MEZ schrieb Ilias Apalodimas <ilias.a=
palodimas@linaro.org>:
> > > > > >Hi Tom,
> > > > > >
> > > > > >On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >>
> > > > > >> As exposed by "make randconfig", we have an issue with the dep=
endencies
> > > > > >> for EFI_HTTP_BOOT. As this is implemeneted by running commands=
 (as seen
> > > > > >> by what it selects) it must depend on CMDLINE as well.
> > > > > >>
> > > > > >> Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > >
> > > > > >In theory, you can configure UEFI with a set of prebuilt boot op=
tions.
> > > > > >If one of them is http(s) the device will boot even if CMDLINE i=
s not
> > > > > >selected. I am not against this patch, but we will remove the
> > > > > >possibility to build a firmware without cmdline that just boots =
to
> > > > > >whatever is was preconfigured
> > > > > >
> > > > > >Cheers
> > > > > >/Ilias
> > > > > >> ---
> > > > > >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > >> ---
> > > > > >>  lib/efi_loader/Kconfig | 1 +
> > > > > >>  1 file changed, 1 insertion(+)
> > > > > >>
> > > > > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > > >> index b5f81e0ff530..a9b2f813e1d5 100644
> > > > > >> --- a/lib/efi_loader/Kconfig
> > > > > >> +++ b/lib/efi_loader/Kconfig
> > > > > >> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> > > > > >>  config EFI_HTTP_BOOT
> > > > > >>         bool "EFI HTTP Boot support"
> > > > > >>         depends on NET || NET_LWIP
> > > > > >> +       depends on CMDLINE
> > > > > >>         select CMD_NET
> > > > > >>         select CMD_DHCP
> > > > > >>         select CMD_DNS
> > > > >
> > > > > Having to select commands here to get network is what needs to ch=
ange. The network commands and EFI_HTTP_BOOT both should depend on configur=
ation symbols for the protocol implementations.
> > > >
> > > > Yes. And this is about fixing missing dependencies, today.
> > > >
> > > > > @Tom: Do we have a target release when to finish the move to the =
LWIP stack?
> > > >
> > > > We do not. I'm not yet sure if all the various use cases of the leg=
acy
> > > > stack are fully supported now (I don't recall off-hand the NFS seri=
es
> > > > state right now for example).
> > >
> > > I did see NFS patches go through the list.
> >
> > I saw the NFS support as well shortly after hitting send, as part of a
> > randconfig build.
> >
> > > I think there's also likely some legacy usecases where non parity is
> > > likely fine too.
> >
> > Perhaps the question really is, for the distribution folks, what are the
> > use cases you know of where lwIP doesn't have support yet? That's the
> > first big hurdle towards, likely, saying EFI_LOADER implies NET_LWIP
> > maybe, since I know there's cases there lwIP is better for.
>=20
> I don't know of any problems or missing features, I turned in on by
> default in Fedora across all devices for Fedora 43 (The 2025.07
> builds) because I wanted UEFI HTTP boot and haven't had any bug
> reports, and I suspect the features like UEFI HTTP is more useful for
> most distros than loss of other features because a lot of vendors are
> moving away from legacy tech like BOOTP/TFTP because of lack of
> security and the fact most of those technologies are not usable on the
> Edge/outside of the data centre.
>=20
> I know of one device which has tight SPI flash space (Jetson p3450)
> which I need to look at closer to see what I can trim, but that's a
> side point on that device.

OK. I know the NFS for lwIP request came from somewhere and wasn't just
a fun side project. Pretty sure anyhow. So I wonder if there's other
things like that that someone knows of.

--=20
Tom

--5zzHdHWObabZI0+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabq9UgAKCRAr4qD1Cr/k
CrqvAP9XSBzy7YBCMkkqgaQyNJcX9tJJnhlebR1EJ1xFqyxipwEA5rO+ohAGC70+
N0MY5wtTtIZESo+r96Lt2qNihGgMcQQ=
=0l5U
-----END PGP SIGNATURE-----

--5zzHdHWObabZI0+/--
