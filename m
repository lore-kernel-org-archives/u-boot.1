Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2335A1088E58
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 01:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588E6838FA;
	Thu, 19 Mar 2026 02:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eyvCqR4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEDA83952; Thu, 19 Mar 2026 02:41:08 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852DF836D3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 02:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d7deaf61bfso45630a34.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 18:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773884464; x=1774489264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lwjo9UdnF2MNKcisRQJHiwyEQcrWdpnQPbLQFhynSRc=;
 b=eyvCqR4mNawTClT1XwrRFCIifucrgyyZWAvQzfneL4KGE3MPh0Y9WxVFNmyReWjMR7
 /aAxVICyWOr62F1Cqi1sZm2fXnC/gWS3HMS+l6Ki/fFIxtQnCnt++HES4j6KF3rnRkkA
 TrOETRpZhJoLYzKxTBD1XYmmyfGzyZR4l+EfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773884464; x=1774489264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwjo9UdnF2MNKcisRQJHiwyEQcrWdpnQPbLQFhynSRc=;
 b=pT9x8mh6Jn8X185Al/ECpTWKYlT29kFbJxRvtzZUMyNTZVGoJojvnoqVon8mc0iX7m
 YtOwpHuBCUuFvIf7PBPV0k2+6YRSodJvSbC7zHnrQTOujt/v/QE8esQ/dvW926qSXinL
 JZ44SdPlqBX7oTtLlXvZqabWBQ/2r+lDggjFvRtvjx+jl0oR4NUtwMCKoo0xa7B5MOuO
 MdPHuk0J/mmJCKioFP7T52u/A/Fb68MiSSqmXkdc4Uu6MkWPaT/E1LQq1PrNwJdlddnu
 DPEGpAvI/335L3YXp5Ud6cDedPxPCbpqS1kIqZY9PMpYId76HYBXK3oBF7K+z8oSwFRF
 sxfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuYjKDwn89DzFp/Y2s/NxBwXdFlu73OYVVrbtTh7eRBUd/Gt2x6+/mPHL9pRxkRfq9fngoHjs=@lists.denx.de
X-Gm-Message-State: AOJu0YxM4B/hz2A8MYjhEiEkgYpooKVM1VkiR+RKw4yNjY9x/Fi1fv/W
 DF72KKB4ahSlgCC43i2USw9tmrUA4ghkRzivLnIuUg5VyTYAZ42PBR9jAfAHSdTSZYs=
X-Gm-Gg: ATEYQzw06h5MeEKRQ5bpQiwP9UkB5dGzOcH8TQ2kQLZ7jMtS75kH7RJ/lgI8O8yYB07
 Xd8uRyO/1ca9geosUGmpCakkkZrbDDclUClVGx3fuWBBCZRZjsvUVKBqW/OM89CFlaOYC/RynLy
 sXMeemU6EhndLZDw5I38F54raZj30Zhaoc87yqFM52ok/jB0vxRNBEl+DB4/kIwfsAtCu1Q95sg
 WGk9IbQNtEM2x6C+9WVIIQ+IyrcBUAQJQ69yIMRDT5JYdyb3NULJ5jcJqOgPV3F8uZKCTEDhuUa
 zBDcvyeKhcrCM5MEvJA2I9c+QAElnQZTEJwr1+CnqD+6myOqbnqWXEADLSZeUpcoEsAHDOMW79I
 4mnSX+IOg3KF9l8RfJy2pkMkXUx02N8GQzaBLAgCtynKF2eDnRNPasconS80iG3GLhT2lZD9eTz
 tMAmrTYEKVokYcjKwURE2BZlXMzRZ1nrRmvVqX7hkr/94vENp11v0za8y+XP7NR121jtEjJzv7W
 2FolNEraVzrxqcjO9NdnNUB2FtkBwhFPIoE9M+ePqrBOdYl
X-Received: by 2002:a05:6830:6a89:b0:7d7:d1f0:300e with SMTP id
 46e09a7af769-7d7d1f030d9mr2551122a34.24.1773884464001; 
 Wed, 18 Mar 2026 18:41:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9bbf132sm3357862a34.25.2026.03.18.18.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 18:41:03 -0700 (PDT)
Date: Wed, 18 Mar 2026 19:41:00 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
Message-ID: <20260319014100.GN502704@bill-the-cat>
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
 <20260317134427.GU502704@bill-the-cat>
 <CALeDE9MVgs--ABnZZ4RJDOnTLM-+imKxG6iJBGmQFHHXivLMxw@mail.gmail.com>
 <20260318014701.GJ502704@bill-the-cat>
 <CALeDE9O=y6fGKd50eiW3Och7vQWKvj_DzuB9UeNLnvj0rqezmg@mail.gmail.com>
 <20260318145723.GL502704@bill-the-cat>
 <24f7f483-b02e-46dc-ad87-bc033324d277@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0tXCmrcs/OIr5fyG"
Content-Disposition: inline
In-Reply-To: <24f7f483-b02e-46dc-ad87-bc033324d277@freeshell.de>
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


--0tXCmrcs/OIr5fyG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 06:18:26PM -0700, E Shattow wrote:
>=20
> On 3/18/26 07:57, Tom Rini wrote:
> > On Wed, Mar 18, 2026 at 11:00:14AM +0000, Peter Robinson wrote:
> >> On Wed, 18 Mar 2026 at 01:47, Tom Rini <trini@konsulko.com> wrote:
> >>>
> >>> On Tue, Mar 17, 2026 at 04:08:22PM +0000, Peter Robinson wrote:
> >>>> On Tue, 17 Mar 2026 at 13:51, Tom Rini <trini@konsulko.com> wrote:
> >>>>>
> >>>>> On Tue, Mar 17, 2026 at 08:42:39AM +0100, Heinrich Schuchardt wrote:
> >>>>>> Am 17. M=E4rz 2026 08:03:47 MEZ schrieb Ilias Apalodimas <ilias.ap=
alodimas@linaro.org>:
> >>>>>>> Hi Tom,
> >>>>>>>
> >>>>>>> On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>>>
> >>>>>>>> As exposed by "make randconfig", we have an issue with the depen=
dencies
> >>>>>>>> for EFI_HTTP_BOOT. As this is implemeneted by running commands (=
as seen
> >>>>>>>> by what it selects) it must depend on CMDLINE as well.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>>>>>>
> >>>>>>> In theory, you can configure UEFI with a set of prebuilt boot opt=
ions.
> >>>>>>> If one of them is http(s) the device will boot even if CMDLINE is=
 not
> >>>>>>> selected. I am not against this patch, but we will remove the
> >>>>>>> possibility to build a firmware without cmdline that just boots to
> >>>>>>> whatever is was preconfigured
> >>>>>>>
> >>>>>>> Cheers
> >>>>>>> /Ilias
> >>>>>>>> ---
> >>>>>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>>>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>>>>>> ---
> >>>>>>>>  lib/efi_loader/Kconfig | 1 +
> >>>>>>>>  1 file changed, 1 insertion(+)
> >>>>>>>>
> >>>>>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>>>>>>> index b5f81e0ff530..a9b2f813e1d5 100644
> >>>>>>>> --- a/lib/efi_loader/Kconfig
> >>>>>>>> +++ b/lib/efi_loader/Kconfig
> >>>>>>>> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> >>>>>>>>  config EFI_HTTP_BOOT
> >>>>>>>>         bool "EFI HTTP Boot support"
> >>>>>>>>         depends on NET || NET_LWIP
> >>>>>>>> +       depends on CMDLINE
> >>>>>>>>         select CMD_NET
> >>>>>>>>         select CMD_DHCP
> >>>>>>>>         select CMD_DNS
> >>>>>>
> >>>>>> Having to select commands here to get network is what needs to cha=
nge. The network commands and EFI_HTTP_BOOT both should depend on configura=
tion symbols for the protocol implementations.
> >>>>>
> >>>>> Yes. And this is about fixing missing dependencies, today.
> >>>>>
> >>>>>> @Tom: Do we have a target release when to finish the move to the L=
WIP stack?
> >>>>>
> >>>>> We do not. I'm not yet sure if all the various use cases of the leg=
acy
> >>>>> stack are fully supported now (I don't recall off-hand the NFS seri=
es
> >>>>> state right now for example).
> >>>>
> >>>> I did see NFS patches go through the list.
> >>>
> >>> I saw the NFS support as well shortly after hitting send, as part of a
> >>> randconfig build.
> >>>
> >>>> I think there's also likely some legacy usecases where non parity is
> >>>> likely fine too.
> >>>
> >>> Perhaps the question really is, for the distribution folks, what are =
the
> >>> use cases you know of where lwIP doesn't have support yet? That's the
> >>> first big hurdle towards, likely, saying EFI_LOADER implies NET_LWIP
> >>> maybe, since I know there's cases there lwIP is better for.
> >>
> >> I don't know of any problems or missing features, I turned in on by
> >> default in Fedora across all devices for Fedora 43 (The 2025.07
> >> builds) because I wanted UEFI HTTP boot and haven't had any bug
> >> reports, and I suspect the features like UEFI HTTP is more useful for
> >> most distros than loss of other features because a lot of vendors are
> >> moving away from legacy tech like BOOTP/TFTP because of lack of
> >> security and the fact most of those technologies are not usable on the
> >> Edge/outside of the data centre.
> >>
> >> I know of one device which has tight SPI flash space (Jetson p3450)
> >> which I need to look at closer to see what I can trim, but that's a
> >> side point on that device.
> >=20
> > OK. I know the NFS for lwIP request came from somewhere and wasn't just
> > a fun side project. Pretty sure anyhow. So I wonder if there's other
> > things like that that someone knows of.
> >=20
>=20
> The ability to push data from memory to a remote file is missing from
> LwIP (no tftpput). I have suggested previously that an simple U-Boot
> HTTP server configured to respond with data from a memory address and
> range, and/or to serve files from a filesystem, would be interesting
> although not exactly replacing the functionality missing from the lack
> of tftpput.

Oh yeah. And since lwIP already has tftpget, I would hope adding "put"
isn't too much work.

--=20
Tom

--0tXCmrcs/OIr5fyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabtUKAAKCRAr4qD1Cr/k
Ci2yAQCuemqhLT/DRDbXFfbG3g0vUqRq5CuHRq7q0zCuQ1ZPkQEAyIiiFnSSUWHe
5KL8NsD+AQ93Dp5i96D36vLFhfUX8QI=
=dE6+
-----END PGP SIGNATURE-----

--0tXCmrcs/OIr5fyG--
