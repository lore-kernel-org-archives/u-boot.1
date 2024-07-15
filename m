Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B93C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 19:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE9088855;
	Mon, 15 Jul 2024 21:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+K87aVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D148881C; Mon, 15 Jul 2024 21:05:40 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879C48881F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 21:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70445bb3811so2177128a34.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721070337; x=1721675137; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BMRVoRXQtHtMcg2qSoKKAenSITogZdBKvG3wbboI/qY=;
 b=g+K87aVZVPDRZLQ9PSWBxubmBlkOG1pdxOJfdilgpEER12E0c36Sh71Zqi2CxWc4K2
 EfXEkdDtRHQLJdlilKt+yKf/ORkdicg+llznjHrsNktbY4FdItwQLR3stS86uyVO8Ivq
 XoWAzsZbdLiNf/yZmHbn9GHUuseSS2TwBLABg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721070337; x=1721675137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMRVoRXQtHtMcg2qSoKKAenSITogZdBKvG3wbboI/qY=;
 b=NAgKugy7SYqToNfm6xiDaZr5nO/BQdGDakHHvmWZ0XrIxyjeNiGimu1nyE2giltoW3
 H0z4sR7qgycBQEvuTveMYNfeOY6bnY6MzpLmS8FhnZwrJZT0tx4+vLvUBYmXUb9zTDg4
 L++QDbTjaEs4g8X5VGQzahKX9SSWyD83RaderMiOFegl8fS9wFxAJaPYACn4zg3ASglc
 3bXNj9rTH6wVOn9lUtSVSPKjIgOhFkkpCh42eUr5WTsW8Wt1Jl4pNC+DgPIn9iFLNrUd
 hqon63kuLLLI5gwlMZjdvDZSPg05sFGSYXX4Z6KvHeKYoVDZ4DXBU+hZLX/SlvlytUep
 WE/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuuiFOU8Ytsrln9EwieFPpAP2yI053P2V5GhBTFc7BimB52R/m8WOVak5BYqVA4YAoVgktSvekA5Pf3lqcdJrsCNS9HA==
X-Gm-Message-State: AOJu0YyS8lePteYqnVX0ejE1cpCvFhPtUirQQ0k59tYPfqGpNoHcRbU1
 mNQthjxvWK+CxxEIExKtGfVC7eLKflthSuze2lt+qMAJyMRJqbB5FiX++zWgB/Q=
X-Google-Smtp-Source: AGHT+IH99HDlot0cQ6gEm+ODIfX1yK1vBPo8zNLFCYSYvCKLTOS/ATC5EWe2+5PPRUc5PlOs9o1zKg==
X-Received: by 2002:a05:6830:390d:b0:704:4bf6:e190 with SMTP id
 46e09a7af769-708d83bac71mr509877a34.36.1721070337123; 
 Mon, 15 Jul 2024 12:05:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0c516d0sm1052049a34.12.2024.07.15.12.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 12:05:36 -0700 (PDT)
Date: Mon, 15 Jul 2024 13:05:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
Message-ID: <20240715190534.GA561963@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-42-sughosh.ganu@linaro.org>
 <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
 <CADg8p97fwAvebfrANXwWc7At78wU59XXymTFWCvuaFHMGj+9zg@mail.gmail.com>
 <CAFLszTiAHSgkGjV6PWOu2nisKc678rpxBvQKuOZeisqCmeAXSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="11Nqsmi5MQnR6/4n"
Content-Disposition: inline
In-Reply-To: <CAFLszTiAHSgkGjV6PWOu2nisKc678rpxBvQKuOZeisqCmeAXSA@mail.gmail.com>
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


--11Nqsmi5MQnR6/4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:39:32PM +0100, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Mon, 15 Jul 2024 at 10:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > hi Simon,
> >
> > On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> w=
rote:
> > > >
> > > > There are events that would be used to notify other interested modu=
les
> > > > of any changes in available and occupied memory. This would happen
> > > > when a module allocates or reserves memory, or frees up memory. The=
se
> > > > changes in memory map should be notified to other interested modules
> > > > so that the allocated memory does not get overwritten. Add an event
> > > > handler in the EFI memory module to update the EFI memory map
> > > > accordingly when such changes happen. As a consequence, any subsequ=
ent
> > > > memory request would honour the updated memory map and only availab=
le
> > > > memory would be allocated from.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1:
> > > > * Handle the addition of memory to the LMB memory map.
> > > > * Pass the overlap_only_ram parameter to the efi_add_memory_map_pg()
> > > >   based on the type of operation.
> > > >
> > > >  lib/efi_loader/Kconfig      |  1 +
> > > >  lib/efi_loader/efi_memory.c | 34 ++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 35 insertions(+)
> > > >
> > >
> > > This is getting complicated and I don't believe it is needed.
> > >
> > > EFI should not be allocating memory 'in free space' until it starts
> > > up. For the very few (if any) cases where it does, it can do an lmb
> > > allocation.
> >
> > EFI memory module is not allocating memory at all now. This patch is
> > adding an event handler for updating the EFI memory map, whenever the
> > LMB memory map changes. All the EFI allocations are now being routed
> > through the LMB API's.
>=20
> OK
>=20
> >
> > >
> > > As to the lmb allocations themselves, EFI can simply call look through
> > > the lmb list and call efi_add_memory_map_pg() for each entry, when it
> > > is ready to boot. There is no need to do it earlier.
> >
> > So in this case, I believe that rather than adding code in multiple
> > places where the EFI memory module would have to get the LMB map and
> > then update it's own, I think it is easier to update the EFI memory
> > map as and when the LMB map gets updated. Else, we have a scenario
> > where the EFI memory map would have to be updated as part of the EFI
> > memory map dump function, as well as before the EFI boot. Any new code
> > that would be subsequently introduced that might have a similar
> > requirement would then be needed to keep this point in mind(to get the
> > memory map from LMB).
>=20
> That doesn't hold water in my eyes. I actually like the idea of the
> EFI memory map being set up before booting. It should be done in a
> single function called from one place, just before booting. Well, I
> suppose it could be called from the memory-map-dump function too. But
> it should be pretty simple...just add some pre-defined things and then
> add the lmb records. You can even write a unit test for it.
>=20
> >
> > This is not an OS file-system kind of an operation where performance
> > is critical, nor is this event(LMB memory map update) going to happen
> > very frequently. So I believe that it would be better to keep the EFI
> > memory map updated along with the LMB one.
>=20
> I really don't like that idea at all. One table is enough for use by
> U-Boot. The EFI one is needed for booting. Keeping them in sync as
> U-Boot is running is not necessary, just invites bugs and makes the
> whole thing harder to test.

Doesn't that ignore the issue of EFI being re-entrant to us? Or no,
because you're suggesting we only update the EFI map before entering the
EFI loader, not strictly "booting the OS"? In which case, maybe that
does end up being both cleaner and smaller? I'm not sure.

--=20
Tom

--11Nqsmi5MQnR6/4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVcvoACgkQFHw5/5Y0
tyw78Av9E1st6Qx9B0iP3mNi1fJ89wtf5uBWM+od2ZYVamaDSAkzEeonvmzDn8YG
wnxmIkJuvtjX0+RuHIR6xrBmn+ZXVp+7R9ADcemTSOESGNQABVog7G+05HZxw3oN
D9QtMromtKdrWjbF3IKZ3JFLEIS7i9dG2fYH+fGe+/qVuy1TisuKcpKCuGgkPRJb
uH1AFnEkB8KO6iKu+93h9teOuSxIIYanRVPuZXO3AWKvyXphRRG2l9wfGTlz5hwL
y2WcccSm1svcDhp0PWExNgJooMexqFuRoa445lE/2O1wxW1Gfh64HFw/bBirfMGZ
v+qtus/E0JhXdb5TLGaDeWdEi+DZGml6mpWJHfbVPvNqNSDfvNNMZtt6I53o+zru
LZTNV0Kg8Y3qZf67PX1jUtQ7oEdHKsLEFl+ENnUUBsCeXcPLiltCloz/ALpWvF1i
KC8l+5jTN2OTh1sPST9pCCTBC+HZDkvg0zF7KhQM0246nFswmcrHyR01tm0ILH/s
EzsOVMFs
=aoRk
-----END PGP SIGNATURE-----

--11Nqsmi5MQnR6/4n--
