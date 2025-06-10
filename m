Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4891CC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB8682B07;
	Tue, 10 Jun 2025 18:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e6IRkpK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9870882B0E; Tue, 10 Jun 2025 18:05:02 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76988004F
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2e41064e247so3055285fac.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749571498; x=1750176298; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cd5YgHrDbS1eeelp/TocxnnKGRJqHNB7HhfdTfdDvuw=;
 b=e6IRkpK3BULfeSk+RTiyKyPXixit8xYjEtVBJCh1UfDvXRcwsro4EeX97Ijg/rWLIH
 Vt+8y8yPuhR52uahRVzNxWuGzyWhohJAo2p3OZSg3pqEzKpuukvZZEEav5IHRszMD6Sy
 mAUuzhhUdZEzMJ4MBBARO/iY9xShk+p9r2VqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749571498; x=1750176298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cd5YgHrDbS1eeelp/TocxnnKGRJqHNB7HhfdTfdDvuw=;
 b=QfPeJTynCehSJAXWHAy9X0cE1z0QSaCfTh7yqKrY+YbCSiPFbmG7573Q17JviODmgS
 8kZSOxCAgIqi5YEA738jfC4Zfg2mbxGZ/qhHvJ8JvYMJ4cgt2ARJ1ofw41UhloKi/oO3
 hkhRBxJo+YdlMI8RWAQD3TmkHpXL5GeukDjw/Npq2x1LRGe+8ve9rfWAdZwIqw2bXNs5
 XN+JoQ8IxQnyInruon8uIis3c6cawPyPkOwQF75po6Eg+Qvif9ciN+mJ5zAY45NS43dw
 lDxavp5mqrIrg0BLiT1ri9VaA9SqlibKntVQioUkDfv5XM1QRUAUp+mxA1/2TNH6DHkV
 4s3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcf88b9YKtDHqhb7fwJ7qFIkLcmF5fV4Ldibh52/jC8gVbJELUuq8GPHVGzzm5lBOwBFCoZk8=@lists.denx.de
X-Gm-Message-State: AOJu0YwzAKlpxbYmsIoM2CzTxGfweaW4zafM0UQQFaQdnBwxuLrJo8hB
 +Lk7UxUmGW7e4UTCa1TVUETLkncRliVwIurkXYI48HjRZtJBVj7oZdPThKAxP7NEyXU=
X-Gm-Gg: ASbGnctX23+84UQ/ZoHs4OGQeshqsEs7uZ7hT09XZ9UGOAqUgToZn3hYksarEjEpHS5
 +heN66DKmcLmACKNhN/oid3Nd2Zcw0B2XVCy7xd9DifEiJxy6FYEn19wXnxS7ZQ1Mhe3ymhafFI
 7gOm6RJFqSRgdBz+I6S1E7qfG7gxOccQng9kNyKDHF6ZJHlU7O67N9qcDmpEDTssJa/qFtcHkM7
 zcO2OkGQeSy8A8V+ggeENmSQJ7ETw9BBmGyVyUhsUMA/2hhtgPEd11j0QZgu1/Tv+A+9KdDSvrV
 d942WmrZKVMqnOLW4CDpbE6Bk4WXqXDlQZvTKIHiLsObbooIrzTvPJev3erbIZCO08fCkbua+Ze
 8neSVsjF+P8gEVAD/oLek+ySrQKZ1lLOivg==
X-Google-Smtp-Source: AGHT+IHrl1QcW7Yyb57ANmcLuHG2ZNlQOm/JHD9Lm4MUCdMY1sIq2TfewTRC22vOwgZ9OWaVr5atMw==
X-Received: by 2002:a05:6871:d113:b0:2c8:340d:1076 with SMTP id
 586e51a60fabf-2ea011e6f6bmr11170463fac.32.1749571498456; 
 Tue, 10 Jun 2025 09:04:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea70259b3csm620326fac.49.2025.06.10.09.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:04:57 -0700 (PDT)
Date: Tue, 10 Jun 2025 10:04:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/9] Support stm32h747-discovery board
Message-ID: <20250610160454.GE1382132@bill-the-cat>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
 <aEbgxo0WUDPd-S8Z@sumit-X1>
 <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
 <aEcAe80kh66cf0_c@sumit-X1> <20250609155019.GR1382132@bill-the-cat>
 <aEcGzCbZXajCthrh@sumit-X1> <20250609162239.GT1382132@bill-the-cat>
 <aEfyYd64P7txX7vS@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sUqbLRjEVSJfZEPm"
Content-Disposition: inline
In-Reply-To: <aEfyYd64P7txX7vS@sumit-X1>
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


--sUqbLRjEVSJfZEPm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 02:22:49PM +0530, Sumit Garg wrote:
> On Mon, Jun 09, 2025 at 10:22:39AM -0600, Tom Rini wrote:
> > On Mon, Jun 09, 2025 at 05:07:40PM +0100, Sumit Garg wrote:
> > > On Mon, Jun 09, 2025 at 09:50:19AM -0600, Tom Rini wrote:
> > > > On Mon, Jun 09, 2025 at 04:40:43PM +0100, Sumit Garg wrote:
> > > > > On Mon, Jun 09, 2025 at 03:46:27PM +0200, Dario Binacchi wrote:
> > > > > > Hi Sumit,
> > > > > >=20
> > > > > > On Mon, Jun 9, 2025 at 3:25=E2=80=AFPM Sumit Garg <sumit.garg@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > Hi Patrice,
> > > > > > >
> > > > > > > On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wro=
te:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 6/7/25 11:37, Dario Binacchi wrote:
> > > > > > > > > The series adds support for stm32h747-discovery board.
> > > > > > > > >
> > > > > > > > > Detailed information can be found at:
> > > > > > > > > https://www.st.com/en/evaluation-tools/stm32h747i-disco.h=
tml
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Dario Binacchi (9):
> > > > > > > > >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pin=
s phandles
> > > > > > > > >   dt-bindings: arm: stm32: add compatible for stm32h747i-=
disco board
> > > > > > > > >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UA=
RT{7,8}_CK
> > > > > > > > >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> > > > > > > > >   ARM: dts: stm32: add pin map for UART8 controller on st=
m32h743
> > > > > > > > >   ARM: dts: stm32: add an extra pin map for USART1 on stm=
32h743
> > > > > > > > >   ARM: dts: stm32: support STM32h747i-disco board
> > > > > > > > >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> > > > > > > > >   board: stm32: add stm32h747-discovery board support
> > > > > > > >
> > > > > > > >
> > > > > > > > Hi Dario
> > > > > > > >
> > > > > > > > For the whole series
> > > > > > > > Applied to u-boot-stm32/next
> > > > > > >
> > > > > > > Please give some time for other maintainers to review this pa=
tch-set.
> > > > > > > The dts/upstream patches in this series aren't clean cherry p=
ick from
> > > > > > > upstream.
> > > > > >=20
> > > > > > All the commits are already in the mainline Linux kernel, speci=
fically
> > > > > > in v6.16-rc1.
> > > > > > If you're referring to the fact that the patches can't be appli=
ed
> > > > > > cleanly, I believe it's
> > > > > > because the target path in the Linux kernel doesn't match the o=
ne in U-Boot.
> > > > > > In fact, the DTS files are located in two different relative pa=
ths.
> > > > >=20
> > > > > That's exactly why we have (refer here [1]):
> > > > >=20
> > > > > ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
> > > > >=20
> > > > > You should have waited v6.16-rc1 tag to be synced into
> > > > > devicetree-rebasing [2] for the cherry-picks to work. This way of
> > > > > manually patching dts/upstream is not allowed since it is going t=
o break
> > > > > DT syncs in one way or another.
> > > > >=20
> > > > > So I would suggest you to wait for v6.16-rc1 to land in DT rebasi=
ng tree
> > > > > and then send v2 with proper cherry picked patches.
> > > > >=20
> > > > > [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.=
html#resyncing-with-devicetree-rebasing
> > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/de=
vicetree-rebasing.git
> > > >=20
> > > > To be honest, I don't think this is a big deal. Git will be merging
> > > > based on content and not specific hashes. And in the case of confli=
cts I
> > > > just copy the file from the tag to our tree.
> > >=20
> > > The essential problem here to me is we are going to allow manual
> > > patching of dts/upstream tree given this example? How do we keep track
> > > if all that manual patching landed in Linux DT mainline? The cherry
> > > picks ensured that we always keep in sync with mainline.
> > >=20
> > > Lets take an example what if Git automatically resolved a merge confl=
ict
> > > for you with duplicated content or if manually patching a DTS file
> > > diverged from upstream and get unnoticed during DT syncs?
> > >=20
> > > IMHO, we should try to avoid manual patching of DT subtree otherwise =
it
> > > is hard to set a policy as to what level of manual patching is allowed
> > > or not.
> >=20
> > Part of the problem here is that from the standpoint of applying posted
> > patches there's no functional difference between what Dario did here and
> > what could be done once v6.16-rc1-dts is tagged (if it's not already).
> > It's essentially a "manual patch" either way.
>=20
> Nope, there is a difference here. The cherry-pick from DT rebasing
> allows the custodian to rather just cherry pick corresponding DT patches
> rather than applying patches posted on mailing list. I usually do that
> when reviewing dts/upstream patches if they can be cherry-picked cleanly
> or not. So there won't be manual patching in that process.
>=20
> ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>

Alright. I hadn't foreseen anyone doing that rather than "b4 {am,shazam}
msg-id" to grab the series.

> > We make it clear that
> > dts/upstream/ *only* gets changes that are in Linus' tree. If someone
> > tries to be sneaky and push something in that's not quite what's
> > upstream, it will get stomped on later and there's not going to be any
> > sympathy for the now broken platform.
>=20
> For us the upstream sync path is via DT rebasing tree only. It usually
> lags behind Linus' tree by maximum 1 week candence what I have noticed.
>=20
> >=20
> > Yes, we document saying to use the cherry-pick script, and that's what
> > people should do in general. But I don't think there's value in adding a
> > further delay between "in Linus' tree" and "in devicetree-rebasing". In
> > the linux kernel, there's thousands of people working on things and so
> > strict rules can be understandable (someone will be running a bot to
> > look for "(cherry pick from commit $hash)" and fail things where $hash
> > doesn't exist, makes sense). Here if the ST custodians are happy just
> > verifying the kernel commit, OK, that's fine. Or if they want to wait,
> > that's fine too. We can be a little relaxed and let custodians do what
> > they see as best.
>=20
> The reason we adopted OF_UPSTREAM was just to get rid of the manual DT
> patching and the syncs. So is it really that few days lag of DT rebasing
> tree which is again pushing us towards manual DT patching? I am just
> trying to understand the shortcomings that DT rebasing tree puts in
> front of us.

It's mainly that I want to be flexible. So long as we don't violate the
content rules (Linus' tree *only*) I don't want to hinder the people
eager to now upstream U-Boot support for purely process reasons (which
happens, E Shattow on IRC was asking how to at least locally point
dts/upstream at something else, at least for local testing).

--=20
Tom

--sUqbLRjEVSJfZEPm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhIV6MACgkQFHw5/5Y0
tyxc6QwAsrJKo5Mz+VMunabhOCX4He/5SMeRP2gXcsuHZjK1cPvnhrn/YS4J4Kz0
EhZWf2SmCgAx5Rhcr/GPc0QfjWmVo7byFrdB9vHqhT2rOJVLKHpCncGW/OOSBkp4
ZC0SDLNSqiX0dQopAHw8Y4XKlvKu2SM/mB4orHNKGhWhH9UBAnm1jQJ77A4kxsBN
nGAWUjBMF7WwFVuU95CxF2Sj0iOrgJrkSVPGHPZoNEbHGSUQ+Dwvsv80tvY8nQHx
UhEKRuuE/vTJyMSzBMt9DbB8XuRqZxz1jKiXt1mD52f9JWjZBZQ7AlNHGcX8bcBG
Y9st+YG7ucze6RfbwFobmcE+waPqEUOoqQA2Obx0xg8op5Fd+TVEFuBTP25EqxAB
6hmWhJtBCGdccQ+yhyJAozB1hqc+iB5DfQfIO3Wmr3QERGQB5XT0/qoqujFFzBsD
ooHeORJDhEbKjQ4p586kYL3r6W0B5GoGR9RQ2QuwQTf88yFjsdFOkOd7dVVihe9a
rgiK+0AL
=CS21
-----END PGP SIGNATURE-----

--sUqbLRjEVSJfZEPm--
