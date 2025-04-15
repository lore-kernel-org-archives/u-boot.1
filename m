Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47060C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 14:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6418294C;
	Tue, 15 Apr 2025 16:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tE0Faq3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA25A82A8C; Tue, 15 Apr 2025 16:12:33 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09F88214D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 16:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3feaedb4d2cso3204509b6e.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744726350; x=1745331150; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pwHTOqupr+lUuDECVu4Q6Rm76JYmgQDCBClEIbVgckk=;
 b=tE0Faq3Lgc9tS9MseCrbUYs07xetpE39uzNwC7jUiRLKHjuCheHKI9bQcs5jNaR4B2
 9AbFyDdMUroOgQIutNqzCXPGT9pv4KtQ60uP8QYGe879Kdtin3DT2np1bYVMwHjMCMr4
 0kJTMGKZd3736c9McieVALoizf3q/PxMN4C3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744726350; x=1745331150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwHTOqupr+lUuDECVu4Q6Rm76JYmgQDCBClEIbVgckk=;
 b=R3qRHC2dV5VoyE32O808yE8L9BHdhxMGuvWaOBKQNoWKVumNIxXQV0T/oC9zj9An3a
 NL+eEngsmxWhANI6RGdyyX9M18q715qNW1TFrOsWMa48TaSSN19yG+8Jk42FN4Magqjd
 axUWl9JXW+JUbSv0KZARDkWvhHjEa3+Rimp7YP7ggBhWTKG2CxvEjhb5gsLPz82xaT86
 6yZluG3N7N6UoCbppR9KPuTES50ct9x7HsJxs4gEekqHgTajTthQSX4AVSRVJa+tZ6WP
 K9AkIStEUYHwRaHOFo9XLWLjJL09I0OGVgd4Fgl7mgEHXzpK8QbJqx+mMG0nrYmo3YW2
 Gs2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmqvBIbisLAd8IM9FqH963CwgstD3z1UQeaAaUHNtEcLNw3B/UPTYZNK5KWE/M3Xe9XLTBi9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyvzOUY1RLm1nuPCfylbO7Pw3txCt5G8WgKMrcSOKDDB3L54Vni
 4pZ5nP/2AlObP1mbxNyF7OtRlgr3fvVsOAeo9r5D1zc5gVrvqFpC4usx0EQWulU=
X-Gm-Gg: ASbGncuoes9YjV9WEqSvFcVtFtyuiLYmHpAhhNih1rEC40p23OfoHr9W+bkemNgiLJE
 G4s5NWks4C4u5ln1gs9suEm79rrZBR4afTlfi1aKGCHOAagXuguuWYTSILlyEwaGqfQ/nyVUkMo
 tXwuowzh+QKrwGJUFpfi61Hy3uFr9+Hkot5rI3gYtpZNNjmqz0FUs5Ybf72HT7r4BB9CmwLGSbj
 CitvgZsJCc3NfANToOPxNmo7CWft5K14/Zzx+C0blcu0IXRMOs4S/9+GxVCsNqqJD3ZxmHWhZaf
 8sha1TQjYxNV2uEGE9D3YQHeYhdEWvdkGjZYs949rbnb+C6Q9GHf4FCZpFsQu3HmiufP9JoOeop
 M5Q==
X-Google-Smtp-Source: AGHT+IHn2rTim2BAbQJ9Ofn17TXOcADb0fx4pVjxRcesD3Of6yg0VVyO1Mlhyi8BxnHnOdHCTuPRGw==
X-Received: by 2002:a05:6808:2448:b0:3f6:7efe:d4be with SMTP id
 5614622812f47-4008505c482mr10119628b6e.16.1744726350224; 
 Tue, 15 Apr 2025 07:12:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f536ef9sm2314524eaf.19.2025.04.15.07.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 07:12:29 -0700 (PDT)
Date: Tue, 15 Apr 2025 08:12:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
Message-ID: <20250415141226.GJ5495@bill-the-cat>
References: <20250405190711.365419-1-sjg@chromium.org>
 <20250414225307.GH5495@bill-the-cat>
 <CAC_iWjKUBp1dUkGVts7aCcJEFNrE95Lu9ApmpPR5itCaWanJRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VuvAeceyNTAuGSFG"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKUBp1dUkGVts7aCcJEFNrE95Lu9ApmpPR5itCaWanJRQ@mail.gmail.com>
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


--VuvAeceyNTAuGSFG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:22:50AM +0300, Ilias Apalodimas wrote:
> Hi Tom
>=20
> Thanks for roping me in.

You were cc'd on the original, fwiw.

>=20
> On Tue, 15 Apr 2025 at 01:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Apr 06, 2025 at 07:07:04AM +1200, Simon Glass wrote:
> >
> > > At present it is impossible to change the qemu_arm64 defconfig to
> > > obtain a devicetree from the U-Boot build.
> > >
> > > This is necessary for FIT validation, for example, where the signature
> > > node must be compiled into U-Boot.
>=20
> I'll repeat once more, that using the DT to store whatever random data
> you invent makes little sense.
> No one is obliged to follow internal U-Boot ABIs. Instead, it would
> make much more sense to store the data in the U-Boot binary somewhere
> and retrieve them. On top of that we now have proper memory
> permissions at least for arm64 and you can place certificates in
> .rodata.

I don't see the high level difference really between blob with a
signature attached somewhere being good (signed EFI files where the
signature isn't an external file) vs blob with a signature attached
somewhere being bad (what Simon is doing with FIT here). So as long as
we can drop the antagonism (and don't break other use cases) I'm fine
with letting this alternate way of securing a system proceed.

--=20
Tom

--VuvAeceyNTAuGSFG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf+aUoACgkQFHw5/5Y0
tyx6pAwAt7Cg7wSZyBjlKGObICgusKSpZcHgLaeRLVpbszRzAJIuzElFAhwdYzk8
2kc/Bqz2lv1PT9DFhvJI9nHf1eQUhOR5dxxzVlWZsCwMHv7QO/asKi8Qb7s6YOjF
SdtmpnLcSEoYKsn5kUfSkYX+9Xw+An9Cv93QB3BZzj6EXo/at+3JAtKHhPFkY/f/
Za2lUPG8hwi5btJSVnmBE4jGWyzyPq7LbtFeB5bADY+z5293uy6VQ8k/0SKQ8e9u
XPnpo2cRVAhAihBx2qRmddhMhZedn1apfETHRDs6LWvtCIyMZP9SJWZ5xcxM8DYC
zCuXu1Rj2Q2aw+TXbKyo0D5iTaGlk0NW/ZZxuZTZ7/DiQ7p3NBopzGRyvYn+atsQ
r1T+iTym/kN0eZ0Me/97SmqRAHSMAtTEo9HQN0Y64iFiwZLBEuiX+t0IigB9mM/0
htRiZCmLu0ziXOR4RiKmijcSeZlT93svC/D6G0KPkPkArIv4Dw+8kZ/EUVfLgDWu
ANHvzzsp
=ecR9
-----END PGP SIGNATURE-----

--VuvAeceyNTAuGSFG--
