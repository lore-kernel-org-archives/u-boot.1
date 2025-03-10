Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B55C282EC
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 15:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92184811C1;
	Mon, 10 Mar 2025 16:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kP4QSOLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD6558144F; Mon, 10 Mar 2025 16:56:47 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9260D80FB9
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22403cbb47fso83863365ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741622204; x=1742227004; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCBkjQRTmyt+KSgAIpsArkKxbiAfIdbFAolfrJDRXS0=;
 b=kP4QSOLxdOr1FJHAkvAJlHGWuS/TRllqvgH5BagQYRCrip9kVFxCI6vBB90gYfnnb8
 FS25YOW5HIpmLYaJxtIntLu+HPaf54KIFFeK6iUAs0ODWk+F0g8u8hwxjctTfhBKhkI/
 P81qCe4cGudyeBd6zElHscCFqOTQtqHLADR7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741622204; x=1742227004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCBkjQRTmyt+KSgAIpsArkKxbiAfIdbFAolfrJDRXS0=;
 b=p4pnifRuvhISgwvX36bKFT6qh0/tyV50zR94Lxzes/Jwz/AZxIQF4ZUr47Dvs1UL4S
 Rfjk6oYodLfT0kF5yWYovoKUxjA5Jbtu2i93iQ4omxpqusyZm1gOLVzpwUnLUov2ruPU
 ksyYOipIha41mjSlpF8XKtjzgLrllQ4wCwp4T2vWpHxWoTXDuiALsWSodSjpiv5MnVDa
 PE7YFr6Z0CNDMGsdMZUDYUgg84FZTJcukH70y2X709/9adnzXd01Hqq292Nc0WijJlpE
 wY5bBsW70DQjU7yWyg7gkaDKap8dgOkgqbceE4C0q5rcG+5xAjTXXlOHlBt3n2AcV62n
 qHNg==
X-Gm-Message-State: AOJu0YzfN3W6X7MKZZ+w4GwIskv0D2vs8T77aSwD2rQCn4QO2YnDgmmF
 BoxzIMO3XWgLbU8ekNYeMaMzZhuAxf/sTa09RRZWGbGekkXVg2Mwrl159Z9FNPw=
X-Gm-Gg: ASbGnctfrag6TpS/sKZ77DoauQ+tEjcyxPM87+PVre+rfpM9l6yCqxYsqBjdCbvGBw3
 Six/vFuVFK5qaRwEMJuP1lOnIXVl/iCYJDNDuO6+7tQoyVdqGAi6nhpFHJd7TRbHefMmhuiD25s
 6X0GDiLcxoCrgLkyX+PdhFvj78IS8Gc9NSAUhR9XywyX3wXU1we8A2Wdub6FXucfegR+GId0WDt
 kJHsGavwn/u50CoJmFhmnqCgBEqygx3x/ksJrzeNUUgpXMSP147YzRnJKFM5icxOA0Hu4SvRoul
 rt4zZbvmagU8mkfVubnOpf+V7Jh0q+knN+hGUWNUkqYwIoP1LahbJkxf
X-Google-Smtp-Source: AGHT+IFrdhFRysAjO96foBJwKYu2f48SZdCCccxihSN3yeI0ZmVKKgt4gdmxSJf2WyOuhxXpXiS2NA==
X-Received: by 2002:a17:902:eb81:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-22428bd57fcmr221368545ad.39.1741622204082; 
 Mon, 10 Mar 2025 08:56:44 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e974fsm79983495ad.78.2025.03.10.08.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:56:43 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:56:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
Subject: Re: [RESEND PATCH 1/3] pci_auto: Downgrade prefetch if necessary
Message-ID: <20250310155641.GK2640854@bill-the-cat>
References: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
 <20250310143037.GB2640854@bill-the-cat>
 <CALNFmy2Za0PfEOogFoCXLJcqWhDXzdxVPDzLK_6vPukxmoCczw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="twAGJLgyGRQAh+DP"
Content-Disposition: inline
In-Reply-To: <CALNFmy2Za0PfEOogFoCXLJcqWhDXzdxVPDzLK_6vPukxmoCczw@mail.gmail.com>
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


--twAGJLgyGRQAh+DP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 04:44:27PM +0100, Patrick Rudolph wrote:
> Hi Tom,
> On Mon, Mar 10, 2025 at 3:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Mar 10, 2025 at 10:01:32AM +0100, Patrick Rudolph wrote:
> >
> > > Legacy PCI devices, like qemu's Bochs VGA device, are allowed to have
> > > prefetchable 32-bit BARs, while PCIe devices are not allowed to have
> > > 32-bit prefetchable BARs. Typically prefetchable BARs are 64-bit and
> > > typically the prefetch MMIO window is also 64-bit and placed above
> > > 4GiB, as it's the case on qemu sbsa-ref.
> > >
> > > Currently the U-Boot code assumes that prefetchable BARs are
> > > 64-bit BARs and always tries to assign them into the prefetch
> > > MMIO window.
> > >
> > > When a 32-bit BAR is marked as prefetch, but the prefetch area is
> > > not within the first 4GiB of the address space, then downgrade the
> > > BAR and place it in the non-prefetch MMIO window.
> > >
> > > For prefetch BARs there's no downside on being placed in non prefetch
> > > MMIO areas, besides the possible slower performance when a driver tri=
es
> > > to map it Write-Combine.
> > >
> > > TEST: Fixes pci_auto on QEMU sbsa-ref fails to autoconfigure BAR0.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Do we need this series for v2025.04 or v2025.07? Thanks!
> since this series only gets pre OS graphics working I'd say it's a
> cosmetic fix for v2025.07.

Thanks. The original series was on my TODO list for this week for -next,
so I'll take this sometime this week.

--=20
Tom

--twAGJLgyGRQAh+DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPC7kACgkQFHw5/5Y0
tyyz2gv9GClVbAlwFn7tbvHLwukqRFL3bpiGgtzIkHzZPFFIPe/vqlxSVsv0Y2ZD
LdUrVEAqoJ6B6YpnaOF2J+l5VwiYONuxxfky5EuTKia4sqSMuCczAjIQMJ3dIzea
snhLPy76PIF/gZHl5NreCT9vw/8rfnqNM8jlC7Lv3Cdnef2a+cliuwmDCgf7tc3C
hsS6PNgWkAn5DQwT+A/OESEMzR5R18QS+9yUFVV1pFlNQo1NNhMvrAAbB6yK1FAd
ZyFhHNdzlmna/Pj3msIWnJ/vryYdZrGQp+qeBxCCHMIHy1ro1kKOQcHRgkSuV5Uc
NBDgwJ1UZRttPl9N5eelY6RYl4hOkzgOPg/eHxzXv2cOQ4pEUJpe7epeJqF5a/bS
9lNnjUHQAQzzB+wje7RIJ2nzfW2vcjVycvUN6DbsUHRo77qNTqcXbjRD5ChgsGzY
kJQQ88yqvwVvEHIKYuX1J4U/lb1SC6KxHz7MCWTehtIcbH2rlhsPtU9DCZQjMGOG
gx7Docpt
=610u
-----END PGP SIGNATURE-----

--twAGJLgyGRQAh+DP--
