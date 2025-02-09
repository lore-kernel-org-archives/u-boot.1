Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34BBC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F3980AE5;
	Sun,  9 Feb 2025 22:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZIGYHMwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12FFB80BAA; Sun,  9 Feb 2025 17:39:44 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F2780B9E
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e5b296611d1so3666877276.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739119181; x=1739723981; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p53yA7XwunMw7HoSXuW1xQPXRz6uG9pF4myzUMpTMwU=;
 b=ZIGYHMwEqWLd6jp4MBWpWFnSSTCZ3d11opGPxJymostjfpRbuKPcqk/sRyNjknGQxn
 pcON4+psXiiE/6h/YDprdzuY5FEGbvffnIBvhVC3UNJEvaXYyq3W+5R29SHBbByF+X+S
 pz28rveEvO60F3ubZARWJiM9dcU8AKXFtnWA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739119181; x=1739723981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p53yA7XwunMw7HoSXuW1xQPXRz6uG9pF4myzUMpTMwU=;
 b=NbOb8eW8B5xJswtlJ/PVl1bH0la2udmCbcjaPZ/+Xxkx+7K8NL5OLxZmqYGOGhhrOs
 1YClzAB44byGIgYuNkjwlpT6GdUk+rh6de3I62lmqYYd9s/avBA69U02d9whc7Uj2LZ2
 2qHlVfTgUQ2V1sGjnKCFHYuRWVW1U1X45Wow8Q5x2kahOsT9CX7nHoJImD7KZueo/8tV
 n1ZF1zTSQvlOYP8wzdI96eFDGdCYfhZlQx21KOcFqCgPTNl+Rp8mQ5x6dD/oIb9rdw8M
 6klbZRq6KCd78wVYFc6c8AFRQx+VrqgMgCQdV9sddLIem1WS6kvJQi8q22LvhXq5IsOY
 orIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/9pdelLaAam/bzttOXqmgLLn3rAp4zl3/eRB9dcg29dEy3lLLCZVGX47AwwJYbas/kA5sZA4=@lists.denx.de
X-Gm-Message-State: AOJu0YzY7dn/MopglGd9c/c8xPCfLBa1Z47p7MR15PVnN6lChOl6Znt1
 X83FNFhqyGcaU5vMoHKwbSepousmKy2lEMnysKftGRM3mKbhMGChZGQaQ1q6WCg=
X-Gm-Gg: ASbGncu7deuLTt/YAXpF5xW3ddUeHk0qjcuIBDh1yWDBLVVzbgAz4N3SO9DBhPsPF97
 HzXddtJoFfzpWS5hYDfHyv7r1M+Dd5mDiizL5gfeQl/5aUaJi4xT8F5SaN1SIKh7zjnfStF64Un
 8zSpzO0+VgQEooVyCfZ9O3WaU89wSNmVenZpCbsREBWqkI3ZQUi7BmgvvdAap8NMahNPv1YO8Ab
 vgK+vdJ1CceM79YwJQFVFIaqm2V12W1R95ItljvVStZBvGoD2STPxwFeFCx/a4APYIiLjdxwr/7
 qxINnYLdbMyEQDQ=
X-Google-Smtp-Source: AGHT+IEUaq4bcYsCT9iR4Rv7cVnCt6FWLYgeJQxvB5iq5ALaMtdRMMCr1KaBJvm517PjewMKgJlKTw==
X-Received: by 2002:a05:6902:1ac3:b0:e57:3a14:a22a with SMTP id
 3f1490d57ef6-e5b46c7d745mr8358431276.19.1739119180720; 
 Sun, 09 Feb 2025 08:39:40 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a45d7f1sm2020588276.40.2025.02.09.08.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:39:39 -0800 (PST)
Date: Sun, 9 Feb 2025 10:39:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefan Roese <sr@denx.de>, Alex Shumsky <alexthreed@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
Message-ID: <20250209163934.GM1233568@bill-the-cat>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
 <CAC_iWjJ7tiTyqq1CXupHMWpfBLSFTu3oEpE798C5N61-zVNo9A@mail.gmail.com>
 <CAFLszTiPkL=V_fAFThccQH-Q3Sj7XuUWJW=DJX2O9yqDF8AVhA@mail.gmail.com>
 <CAC_iWjJDNPWTVLXZS3_G42Tn4+m_nZtr+4XTJb-SKZ55UbCudQ@mail.gmail.com>
 <CAFLszTiys=22YpObG33wPWoGDfogtSLNk7MsKHxb2ecGmncHYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5urxE4u1Om9vttuG"
Content-Disposition: inline
In-Reply-To: <CAFLszTiys=22YpObG33wPWoGDfogtSLNk7MsKHxb2ecGmncHYg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 09 Feb 2025 22:36:48 +0100
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


--5urxE4u1Om9vttuG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 08:47:47AM -0700, Simon Glass wrote:

[snip]
> Perhaps make EFI_LOADER select CPU, or depend on CPU? If that's the
> way you want to go, I'd be happy to do a precursor series to deal with
> the fallout.

I'm not sure what EFI_LOADER has to do with the generic security feature
of enforcing permissions on pages. That's something we want everywhere
that can enable it as it's a good defensive security measure and also
catches code bugs.

--=20
Tom

--5urxE4u1Om9vttuG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo2kYACgkQFHw5/5Y0
tyxquwv8CITM8AAaq4FrBiNWYcYQweGDlSwvzFVqlxVBTXFu8sjMk07SbmBxwGJY
0dY3HdFf2B1GAsG/mqGLPNhLXGAjYSDSqfAFvHf3Lu9uuLFFCvg0TIAEQf274LNZ
oAcYFn0HnufwBWNWOwdxqwaMb2j0CCDF+wEi8yUIk8Oxng/OzM2w+9VkW7CwXMAL
vQSquHEvGeLASCQBZyWB4KR0V5F/lbrK8EcQVqFIVqhMPZqC+o/NsYnTBNAEIuQO
uCR9/5etqfBGlXa8Z9knhnDdz2nWengnoUovhR03er74SUOJKfo9HRJSngKzxgRj
3aWMt5ATTOLzoikimf2KcUjSVVZzg05YkrncFDFcqtPJia32BWav47fmHZHTi+ls
XhgNVJ274BhS91HbUUat0lAbapxjFCet8Zkw8hf1sBM3iw3t2EBJR7MuvjWtpW7r
3jmemv/pIA1Kh15xfkA2GvVdPHokE5O/xNbj55FB9azRYISD2mJCsHTQN2LDRGHt
wmQcSPUg
=INEt
-----END PGP SIGNATURE-----

--5urxE4u1Om9vttuG--
