Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278E1C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBBE82A65;
	Fri,  6 Jun 2025 16:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YGUst84M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C5382A8D; Fri,  6 Jun 2025 16:25:10 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCBEE800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4067b7d7e52so607326b6e.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749219906; x=1749824706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B42cbZ4QB8q4O2fqZti/XpRi8fngdKbrfsce0JXm98E=;
 b=YGUst84MoRzEbAq/BYovE4d6/6Djslke43v8K70GeTym2vGriKrNvLDEPD3sefB+2c
 Zn9k/2n0sSppZxxATOKW4s8tRpuMpxsRBajlPMcU0zdGvsKRwClbTZvDgaTXd4u0AJ9C
 xmkAcFnJghlcFf0jpPWJfGynJC534mu1IGFqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219906; x=1749824706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B42cbZ4QB8q4O2fqZti/XpRi8fngdKbrfsce0JXm98E=;
 b=Aa8W2+ivYOc6D25nGaJGNytXvB30gXe7H0VfNP0Dg5elHz6xTkeXj4hDN596ZAe2T7
 NPMQ3bZR46Z2yviCkwVq/vGex0nCMlp9WX32WHoWPoZct4Y5wGKBcu7QX+pet3tToXE3
 FYFXGzHDoG4rlBlrX2HpSX7vE4gRnhwgWzW6l53NTvJaa/OctL8dSuBszhLL/bZH+0jk
 /9VJGe2yRfyquw1juV5me6Q+Q3UBFdsnQM0aXTKFVqoU3IdW3ptj4kNU9eUIF7Zox8+5
 ZitKj8av8U5sAL+Ae7TZj+X0xMkE7oVnbUBrEfirv9LX/Esh5GHr7qmlMs50tvXvVnxs
 syMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV72jHeWNfTqKjOxt3DDtY1yIYlg8NaWPkGqYBW1P74UL/CwFQXleyrOJPehATgd56DnZ1b7uE=@lists.denx.de
X-Gm-Message-State: AOJu0YztqkwhjQaqW71eyQfEHZTmLDa9AQH5WHMBicYo6xTWc4tlNxto
 kI7Vkydj31rgn5RyIdt8vVx90GcPJPx1EJ9xCGQFpSfzWxpoiquYyAPIecUzeEaBg1Y=
X-Gm-Gg: ASbGnctY/J8FiFQNXiVGMMgzJXYi6C6EUPvQhzYvlqulfp/Ao8PHYQB01Jl6w4hAzFD
 0Dd3gT/NkHcsHLsKULX6hcIgeoNq+3j9plm/De492zHV88Zx1b8SHkLv6r2ltceMxjBoAdFg+LP
 W68uwwh7EX3FWBwNWiCWKxlIQzH2MBw/tSL4U6KH+I/VW4QQ8KYPri1w+KKtic0xWfAOYnewPev
 IRAXe8+aykC3hQHIhYVxuNHA3jI6UCjP7L80dTm9++Fx6gWJUg5D3fCmaONg45j30HL1NUJ3FTQ
 O7gWK2u8COlw1PkNLkZaxADlTLD0jAnmxS4FrSnd5uF9U7FofCaugPcVkRNUMMJ6tMVzMcKrGAG
 cPlwN5CZZDzaS
X-Google-Smtp-Source: AGHT+IGktLSbKySCx3uwzGmEP7BqE5gzAJkW/YcOh7mgmUei+2L8korxAlIWqbjUcufhej2eCgtt+g==
X-Received: by 2002:a05:6808:640e:b0:404:dad4:f95f with SMTP id
 5614622812f47-40905220eefmr2618401b6e.31.1749219906266; 
 Fri, 06 Jun 2025 07:25:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4090692dfffsm313462b6e.2.2025.06.06.07.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:25:05 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:25:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@redhat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v4 3/3] fastboot: integrate block flashing back-end
Message-ID: <20250606142503.GR1382132@bill-the-cat>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
 <20250522143958.GJ100073@bill-the-cat>
 <b83cfc3a-39e6-4710-a6ac-c24c878052cc@linaro.org>
 <20250605142126.GV1382132@bill-the-cat>
 <3d86cf5f-028c-4858-b292-5233b7194c60@linaro.org>
 <877c1ptjvp.fsf@kernel.org>
 <78f0a868-bc30-4a7b-817e-2e1618d46736@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XrNPX9gr/9svpDqa"
Content-Disposition: inline
In-Reply-To: <78f0a868-bc30-4a7b-817e-2e1618d46736@linaro.org>
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


--XrNPX9gr/9svpDqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 11:23:54AM +0200, Neil Armstrong wrote:
> On 06/06/2025 09:22, Mattijs Korpershoek wrote:
> > On jeu., juin 05, 2025 at 19:48, Neil Armstrong <neil.armstrong@linaro.=
org> wrote:
> >=20
> > > On 05/06/2025 16:21, Tom Rini wrote:
> > > > On Thu, Jun 05, 2025 at 10:16:54AM +0200, Neil Armstrong wrote:
> > > > > On 22/05/2025 16:39, Tom Rini wrote:
> > > > > > On Thu, May 22, 2025 at 02:37:07PM +0200, Neil Armstrong wrote:
> > > > > >=20
> > > > > > > From: Dmitrii Merkurev <dimorinny@google.com>
> > > > > > >=20
> > > > > > > 1. Get partition info/size
> > > > > > > 2. Erase partition
> > > > > > > 3. Flash partition
> > > > > > > 4. BCB
> > > > > > >=20
> > > > > > > Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> > > > > > > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > > > > > > Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > > > > > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > > > ---
> > > > > > >     drivers/fastboot/Kconfig      | 29 ++++++++++++++++++++++=
+++++++
> > > > > > >     drivers/fastboot/Makefile     |  1 +
> > > > > > >     drivers/fastboot/fb_command.c |  8 ++++++++
> > > > > > >     drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
> > > > > > >     drivers/fastboot/fb_getvar.c  |  8 +++++++-
> > > > > > >     5 files changed, 63 insertions(+), 5 deletions(-)
> > > > > >=20
> > > > > > I know this was posted before I replied with more feedback mome=
nts ago.
> > > > > >=20
> > > > > > [snip]
> > > > > > > @@ -193,6 +197,31 @@ config FASTBOOT_MMC_USER_NAME
> > > > > > >     	  defined here.
> > > > > > >     	  The default target name for erasing EMMC_USER is "mmc0=
".
> > > > > > > +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
> > > > > > > +	string "Define FASTBOOT block interface name"
> > > > > > > +	depends on FASTBOOT_FLASH_BLOCK
> > > > > > > +	default ""
> > > > > > > +	help
> > > > > > > +	  The fastboot "flash" and "erase" commands support operati=
ons
> > > > > > > +	  on any Block device, this should specify the block device=
 name
> > > > > > > +	  like ide, scsi, usb, sata, nvme, virtio, blkmap, mtd...
> > > > > > > +	  The mmc block device type can be used but most of the fea=
tures
> > > > > > > +	  available in the FASTBOOT_MMC will be missing.
> > > > > > > +	  Consider using FASTBOOT_MMC on a MMC block device until a=
ll
> > > > > > > +	  features are migrated.
> > > > > >=20
> > > > > > A default like "" in order to un-stick configs that are now her=
e and
> > > > > > enabling the option is wrong. If we're enabling new functionali=
ty for
> > > > > > platforms, it needs to be configured correctly. This leads to b=
uilding
> > > > > > code on platforms that won't be used on the platform so we've l=
ikely
> > > > > > added run-time bloat for no benefit.
> > > > >=20
> > > > > I agree but what's the solution ? I'll prefer having no default a=
s it was initially.
> > > >=20
> > > > No defaults is correct here, yes. It's just that the primary
> > > > dependencies need to be fixed so that platforms don't get stuck on =
the
> > > > prompt on features they won't actually use either.
> > > >=20
> > > > Seeing what boards get stuck, and then having an idea on what
> > > > dependencies trip them up is tricky. What I usually do in this
> > > > situation, to see what platform is stuck on the prompt is:
> > > > - In one terminal, fire off tools/qconfig -sC. Then wait for it to
> > > >     seemingly be stuck with just one or two platforms left to finish
> > > >     syncing.
> > > > - In another terminal, 'ps uxwwww | grep make' to see what the build
> > > >     directory of one of those stuck platforms is, then manually sav=
e off
> > > >     the .config file, begin investigation.
> > > >=20
> > > > That should provide what platform is asking this question and not h=
aving
> > > > a reasonable answer. Then it's a matter of seeing if it makes sense=
 for
> > > > this platform to be here and so just needs to be migrated to this
> > > > functionality or if it's here because of some dependency problem, f=
or
> > > > example what I was talking about in the previous part of this serie=
s.
> > > >=20
> > >=20
> > > Ok I can't reproduce the crash with the last version, somehow v4 fixe=
d it,
> > > and the changes I did still work:
> > > https://source.denx.de/u-boot/custodians/u-boot-ufs/-/pipelines/26523
> >=20
> > Hmm, maybe v4 "fixed" it because we have:
> >=20
> > default 0 for FASTBOOT_FLASH_BLOCK_DEVICE_ID
> >=20
> > If you drop that, do you still not reproduce? (note that we don't care
> > as much since we agreed upon using "default 0" for device id, but it's
> > odd that the build issue is no longer there.
>=20
> Yes confirmed I removed the "default 0" and it failed again.

So the question is where does it fail, and are those platforms which
want this feature (and a default of 0 is correct) or is this covering up
an error (platform doesn't want / use this, but now builds it anyways
and it's not configured correctly or usefully for the platform) ?

--=20
Tom

--XrNPX9gr/9svpDqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC+j8ACgkQFHw5/5Y0
tyznYwv4gaC1afYLxyyB/VC0RrFk3OrhkUWHXkMRAX9KkZeNrw2L9SnytX/nO3xy
99Lw/le9+HY0LvPA24Oaqaw1odynllGlknKWN+lifYeDsmfq8An0FfUj+SvmmKZQ
xHeJg9anulurvCnHefWlVe2JOn/8kshi8zt/KFguHlNJPGHxCq6+TgZzJn8DSrE6
CL7eHPeJzjKt05hN/Dq19xvu5a6TMtdpt387DId4dEcdhm+KKqRZq5yWRWLT0196
NOSDe648qwQszorYlPupzmbQIoEQpq+gSuM9AI0MUVU61b91rFJhp+n9vnRVHTGF
JRnLlHvUjBI5PaqRSMvgsBsorHbZL6uzNJ6C4siAPlvfXBMwjYwXWdz0gr52qdmy
S7POwW30fU9NLsJNLwWOWLr32BprdOQFNvQkt1RBwItJMsweCWDg1gfYUtsQxv7F
ENBIFXfnngLDZoDNJM5+uSOQvgi1HqjNMsHzWJkHPm6a4YU0D4jXESVxaukANRRC
KwWXvTM=
=34Kz
-----END PGP SIGNATURE-----

--XrNPX9gr/9svpDqa--
