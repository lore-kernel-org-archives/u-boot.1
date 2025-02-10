Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D49C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 22:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDE180A55;
	Mon, 10 Feb 2025 23:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HQ1AO/uQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5326780548; Mon, 10 Feb 2025 22:17:47 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF6C803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 22:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f77b9e0a34so36398837b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739222264; x=1739827064; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=03vK+DucvAgEX7x9mnXCTArIlEu+ByL/FqgjTevKlXU=;
 b=HQ1AO/uQlcRXyrEGzIrp2W2QbxirSSjcj8phzPT6skhEfXptgsh4pb/X4NB8hvvbT1
 0TQQPftTd9rnzn3kPkPp5ibr6OLy5GPzQqCNMv+vjcxOrssWtG7vf81mjIf/dbiA5noO
 7Gcpp6VqqkZdCMS3LmQKXx+/ywSpu7He8sd6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739222264; x=1739827064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03vK+DucvAgEX7x9mnXCTArIlEu+ByL/FqgjTevKlXU=;
 b=gNJbqBdA8KCx9u92PJSoVqnjxN/cXMlZgb9ZvRdfOiZDj1WEeSGPn0g4qe10zho3rL
 efK4kJr5RQcNNkS9kz6bcxCJUw4UTRXY4g5FWqmDV6m2gMy+zIoqNK94yYJEVtMbZfH8
 YN1KPs3HRcOMmJNuLYv/nlGbDgfxl0LCuGGNtxnLygo/jo0pnG96GG2RfYqjgM0vAEwO
 Uq5HBYTTmTvO4xcvCJUEBTdWa3szuTvGXv5V1wjeYQ4iizoUAB2QFaN+6H7PhNCmvEnk
 BxATRrjqyARPrJkxvWGBj7GFbCksktv5JLQ/1/VsEei7g7TlNA2a0ZIAppCP/yjeKnHx
 B3qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5b03mwhmK6YBBJAxbj86PV1HPDoHudvgaptdJLhskmlqYfGSQESAZSh1M27BMeqKl6YU4KhE=@lists.denx.de
X-Gm-Message-State: AOJu0YxN7cR+OWHMLVOrafrbPbTR5eI6XM76Vz/A03Cr8MtfdXj2I1Xe
 Px+HmFEE0YJ6YiZ1D8D6DHIVbDK3Mj3MbbpA/F36Fg8KNNlmoq796FrMqClzMmQ=
X-Gm-Gg: ASbGncsIPGcQc0TXZCwzQvBG1JdBLY3k4LKuM8lqGHgvTQHgTPGTQgDZ/2SrBzRSZGn
 JdCRRWh3Mc8bYMA8WIDVxFe7AICJSU6xPJxDeUzlzobGUOqmjz1hWyTb3AvAKHPuh3DoOFuBdvb
 5ie6uKhgK2Ah1+FExLWRhC8CzjrfdzFVIZ6vg1tEA6dW8nlh/+fQfOD0z87Xn2bLRLEyGh9GKtu
 a7Su/k2rldQqGB4n/wdRmcSYtCWHPwcCrZifqcAhcH6KnrXxZ9klTwpxhdDuXlwJmiYp8gOFn3C
 HNnrRn3csCKpjT0=
X-Google-Smtp-Source: AGHT+IHQf/DmxMr+hZrNCT3WnKeUVMWInPm0lNNhcF4gjcOlh4I05ZBlXTPsVKIbo+nEvZ9kQ0IE6g==
X-Received: by 2002:a05:690c:6013:b0:6f9:a062:2a06 with SMTP id
 00721157ae682-6f9b2844369mr122760617b3.8.1739222263511; 
 Mon, 10 Feb 2025 13:17:43 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f9a000f516sm18227397b3.119.2025.02.10.13.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 13:17:42 -0800 (PST)
Date: Mon, 10 Feb 2025 15:17:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Lukasz Majewski <lukma@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: (subset) [PATCH 0/8] Reverts and fixes for board failures
Message-ID: <20250210211738.GQ1233568@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <173921993557.2921783.3890127949068603825.b4-ty@konsulko.com>
 <CAC_iWjJ-Ue13-WP6LqAH7dh9Wcc-76siM_0hgsZ3WaRQvzfH8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZKHx0xX19pCXcyME"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJ-Ue13-WP6LqAH7dh9Wcc-76siM_0hgsZ3WaRQvzfH8w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 10 Feb 2025 23:29:01 +0100
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


--ZKHx0xX19pCXcyME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 09:03:58PM +0000, Ilias Apalodimas wrote:
> On Mon, 10 Feb 2025 at 20:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, 01 Dec 2024 07:42:28 -0700, Simon Glass wrote:
> >
> > > This series collects together a set of reverts and fixes to get most =
of
> > > the boards in the sjg lab running again.
> > >
> > > Unfortunately three of them have developed a failure which requires m=
ore
> > > diagnosis, as it may just be a hardware failure.
> > >
> > > For coral, the TPM tests fail, but the board is working, so this can =
be
> > > dealt with separately.
>=20
> Which TPM tests fail? Can you point me to them? Any idea if they are
> related to drivers or the APIs?

With what I just now pushed, you can click on the coral board in the
gitlab UI on a pipeline for it to run and you can see the results
yourself. As a for reference:
https://source.denx.de/u-boot/u-boot/-/jobs/1018091

--=20
Tom

--ZKHx0xX19pCXcyME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqbMUACgkQFHw5/5Y0
tyzEWgv/ffiD4PPUOa+1JjbcK9OlCU7J8VIfHcQ61TzCIJyj/ZZdyL2bZubkO/cY
fbVr9O/XG2Y/Fscntb0Lahvmamux9c+hiY/1t4mEesWxb3fRNikgBjEdZIPHEvYu
g+FRCTLkicX3Mnsk/fKRmSyG6NhRCAHxcQhcjPuWIp9srpIhSmd2WbayJxcCgNr0
gTyABcI+uFmuIyst67UfIaPYXDA4cFMUf0MeYmdmgRLaaHtDOMh/egk7Rgcvrz5c
njL9FkakkpeQrCeXGxFWwqJrmDlFueR70135PG5SMUcatVVo+lBmPKlw5wGWFZBm
8G+ZJJ0ZgJTPGIlWmii6P2pXocYDV/hhMNRj/nPCAevN43Ew8Nq87dfYpQldPip5
7UUDRSXWdp2Co9RkKgxlDRQuhLoAWWQTLLOWNU2jqCle1KrtFGVQSlFlvw58Y8E5
tJHnf+Tjacag1sUFOe5rbHw5dF/8rUEUj76nt50jQCGZEMJ/hDQrXcsTgp8pyQPg
C5ZAdZmV
=nFbO
-----END PGP SIGNATURE-----

--ZKHx0xX19pCXcyME--
