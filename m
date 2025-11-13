Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20779CD98D5
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE5484014;
	Thu, 13 Nov 2025 20:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R4EnkW64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CAAB84019; Thu, 13 Nov 2025 20:38:23 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC88884013
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c707e11e01so1266564a34.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763062699; x=1763667499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pD7w7fpz7YnCodrRxcr/FY86de48wB0yB8WRgsrzVz8=;
 b=R4EnkW64pNcaz/MufcUj9dLCUow2yoKxsWO87JZ8rsRYlyHK0Bw9qvo4ys5KQaPYlz
 ciWWeAp215U7G1JFUNNsRYrAadZudKE89pBRcescSe2gsIupxxshhFuWW48LYHPbAmr1
 +/qO899iO5hj/vGO3B9OGzb1miu2KpdfEeEHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062699; x=1763667499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pD7w7fpz7YnCodrRxcr/FY86de48wB0yB8WRgsrzVz8=;
 b=Tk2thbnEWrRSSOkygDnruLoWdLocDIX+QiuzsP4TDzJHG1EjXsXodUuYiNA9kL1rDz
 ppawCRj+IoYg7SObiE94dumxrdSZL8Uv5rLCos4GcTGH7UCRQ5GMC5uPp83nvPOinZ67
 tmrh7at8lcldCum5tm3MFsO3VJs7NgcB08QBOCkJAwmFhMqxkf6SgEHarelyQQrT4d/d
 xYMBy4PzqKqlFQjghFQpQRxQ0BJ6iRM+YxfwhRCDD5uOw9wZXZJ6A3trwFKY5s/D/C/0
 d9e8WvCOwfza9S2dd/XYe+rzTkl2UuO88j0dlJgvOQAJIE/lXmwRCg8djeIIl2tYlb9I
 UFYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc+p09duRqIH9tkdTNjky6tcglxyAHyF+9lZ+6eTLFTgdAiCRRF6MLdQJUSVFGZus/6H//vHw=@lists.denx.de
X-Gm-Message-State: AOJu0YxGHp8Yom0ma+uP0nzokrxYykL/iPK+Nuq+r9CNTNFQnnUWxcnh
 /+FEqdvlfdN5GPDR2mC/pazZYoS45t3K5yn2swkBu9uJDZCFdPIK98Y1mdXsdMn9gEc=
X-Gm-Gg: ASbGncsQSdN02VmKOzY8WcDMrT910NeWBydWNNS438ZTD6f3qaosI2OzQ5TMe+wH7ia
 ziSf/v2dsVQH72zgQ8nDOpeH/586118VUKwdstQEDRGQgzs54Bk5nCVsUiqWlDGTONHkKVOtnYR
 FSlI+DAKHTsGoVunZ+7oPrmYqKdbTRvJarl8FcmJsxVUIgkBohLYoy1kJSFr5IH+XiyrBqaNhgT
 NzvQD2/I4PYfBDsbXN0wjUAivtbCHh1WhMGxv3fAaMgFNSY4vaPvq+d/vJsSDeF6Zpww73AEkk5
 0+Q1Xf70fmdr4PHAgqYpYTtowVsOzp7NUbiHoqnm8gbs3tsRs/IVIxqGPDDtuJlNCviwm/F+T/H
 dPSPfPtVK+Vyg/Oq3VMCvNwIQw+q1M8C6oSSFf5lnSRvHunCV1v4otEzQRRe484uPvbXi7aFzGw
 lWbhFQOW360cVVKu7yfvpbOGHEzOA+Y2w3XLYnoas=
X-Google-Smtp-Source: AGHT+IGDU6HUZe/httaE5Jyh1mYyOIESsskTxu2i9r//sFpUK6UN062MmP4tmZUK7XWBzYQJ9gTojA==
X-Received: by 2002:a05:6830:40c4:b0:7c7:3416:ff89 with SMTP id
 46e09a7af769-7c744619017mr395650a34.36.1763062699544; 
 Thu, 13 Nov 2025 11:38:19 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a29cc67sm1721990a34.12.2025.11.13.11.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 11:38:19 -0800 (PST)
Date: Thu, 13 Nov 2025 13:38:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
Message-ID: <20251113193816.GP6688@bill-the-cat>
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dX0Q+Asg2MENfVzZ"
Content-Disposition: inline
In-Reply-To: <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
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


--dX0Q+Asg2MENfVzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:33:24PM -0700, Simon Glass wrote:
> Hi Marek,
>=20
> On Tue, 11 Nov 2025 at 18:17, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> >
> > Newer versions of libfdt strictly check whether the FDT blob
> > passed to them is at 8-byte aligned offset, if it is not, then
> > the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> > android_image_print_dtb_contents() passed FDT directly mapped
> > from abootimg to libfdt, and this FDT is not always aligned to
> > 8-byte offset. Specifically, the FDTs are somewhat packed in
> > the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
> > long, then the next FDT blob ends up at 0xfd offset, which is
> > not 8-byte aligned.
> >
> > Fix this by first extracting the header into 8-byte aligned buffer,
> > checking only the header for validity, and then by copying the
> > entire FDT into newly allocated 8-byte aligned buffer. While this
> > is not efficient, it is the correct way to handle DTs, which must
> > be at 8-byte aligned offsets. Mitigate the inefficiency for the
> > common case by checking whether the DT might be 8-byte aligned and
> > if it is, map it directly.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Aaron Kling <webgeek1234@gmail.com>
> > Cc: Eddie Kovsky <ekovsky@redhat.com>
> > Cc: George Chan <gchan9527@gmail.com>
> > Cc: Julien Masson <jmasson@baylibre.com>
> > Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > Cc: Nicolas Belin <nbelin@baylibre.com>
> > Cc: Sam Day <me@samcday.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
> > ---
> >  boot/image-android.c | 46 +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> >
>=20
> OK, we need to adjust mkimage etc. to handle this. Until then I think
> we should have a way to disable the 8-byte-alignment check as it seems
> to have an enormous blast radius :-)

We can't. We really can't. Passing misaligned device trees results in,
and has already resulted in for years:
- Silent Linux crashes
- When Linux doesn't crash so many of the read functions go wrong the
  result is incomprehensible.

It's something that has and continues to waste untold engineering time.
The only reason it's not worse is that we've killed off *most* of the
platforms that disabled device tree relocation and that's how
misalignment happens downstream most often.

--=20
Tom

--dX0Q+Asg2MENfVzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRYzpQAKCRAr4qD1Cr/k
CrFbAP4x4+TIL8dGpjAU+HwIzggpqq0pZKueQ1B8b7BTlsH+lwD/SAJBh6Vg6y+b
acBWNSk751dL1gGZA8m4ZTlObWTIwwQ=
=W9cC
-----END PGP SIGNATURE-----

--dX0Q+Asg2MENfVzZ--
