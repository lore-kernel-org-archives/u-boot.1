Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E8FC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 15:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E64A82998;
	Mon,  9 Jun 2025 17:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rrwdmzrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B8E82AA7; Mon,  9 Jun 2025 17:50:27 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2570A826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 17:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4034118aeb7so1046382b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749484224; x=1750089024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ2T59jEh3FY4rKWQ3N7iyBew40TzAqkUAuq+ZPiqhg=;
 b=Rrwdmzrv2zu5JO6vLMkP2tP5gG7SlGJj7g7+ouuKXhqKlY2E3yOjNN3QiHua8gkaIg
 Rp8w3hk7kJShNww47sIkrooVuwlQ2ld2oUBA8I/uCQY9IhAIQfXFZs1ca2cRThe09Uhw
 cbppWb6r6tDGHeMpYaqajuUCitmEONwO7+xXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749484224; x=1750089024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQ2T59jEh3FY4rKWQ3N7iyBew40TzAqkUAuq+ZPiqhg=;
 b=VwVfNgw0hqEu0oyoNlgdepTxVYT9epr+cVsILHpeLCvT6vyCbLwFFx3wnX9F5jfyaK
 0m2OH0gacBaVZUz5CpfwM6eLan8W8ileUT3jl5t+r14IxEgNtD/Nfbo7gqG0pe8T7QwA
 iknJ/Iw3+RzVXBmi3x59Mvv/9JAFhMUpvtNmS6Z6gHbqTRENufmLD7EhTUueBcTnwfmJ
 FvDx1pH++NBvRDmyntrx1fGaX6GZAuJzPBjj8QACs6YPE1RJqTOlqQMvauR5momwtYwa
 z1eheKwhKinIcQGyUWaZDK+xGrThC5ZW0ecab0EaspaMb/IW/fVUjkh3roSBhwE8lRZM
 WFwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxhUW/TNfYPWQRjxqDQnF8brvdcQ7pxuaSrptJiiKuHn0+dLJh71nXZh9Ef0RI/xEJeg8YB1c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1qhNTVjcwz9cs6HDVvQHB5t8yxNYswDH/xGhxE0p+swT5kJP4
 1LWWZ7FxyqfafCVlOiBC+kTfCa1XhHsinYYZDZ0lAeshH9gUWVN8bzvP46qiL4oh5WswL+PwLMl
 xFgZEjKQ=
X-Gm-Gg: ASbGncuLvGd3Vc8UXHzKbCUr5hqdbw4FZaE+24EioL46gh2RXBWLwG8Gtlm8FLzN58K
 7IjvdSha+Zl9bWiIYwOIvX3Rgn5zvMou6xowWkDxQevdZTlyNUFSsSRwF6G5u84FWTpHLGhbfY3
 klFPbqoObqB/LY2rolcktcaeWTudJ4Ko74PNAHPCg15psxa5IUqBmVpOhwid8k0uBv2k345WXZV
 gdJZc86nf+f4aqn4A9OXpGU40AHRa+YYlUcCZ97x5rOkaCjWaTFIQEmrMftjMC+9TB+q/g4CZ3y
 nOL0lj+GHQmFv0HCOhHvjsPU/3Nb8crrnEKN+f1u7tCpxtoxrIveCFHEqZjL0GRXQf8EMPtsNR1
 JFk5W/3PfMGnrTwkCxNVK40Y=
X-Google-Smtp-Source: AGHT+IHMJe10cNXdXis98uD/mhK6q/pKBttMlUJeH29yJkLVrCPeqN/2glF5UkYDn312fwxNf0X0+A==
X-Received: by 2002:a05:6808:2804:b0:406:3a0c:1801 with SMTP id
 5614622812f47-409051faa7bmr7909118b6e.20.1749484223749; 
 Mon, 09 Jun 2025 08:50:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069f5c80sm1869049b6e.31.2025.06.09.08.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:50:22 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:50:19 -0600
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
Message-ID: <20250609155019.GR1382132@bill-the-cat>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
 <aEbgxo0WUDPd-S8Z@sumit-X1>
 <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
 <aEcAe80kh66cf0_c@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kgMtOV1OLw/tHJl9"
Content-Disposition: inline
In-Reply-To: <aEcAe80kh66cf0_c@sumit-X1>
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


--kgMtOV1OLw/tHJl9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 04:40:43PM +0100, Sumit Garg wrote:
> On Mon, Jun 09, 2025 at 03:46:27PM +0200, Dario Binacchi wrote:
> > Hi Sumit,
> >=20
> > On Mon, Jun 9, 2025 at 3:25=E2=80=AFPM Sumit Garg <sumit.garg@kernel.or=
g> wrote:
> > >
> > > Hi Patrice,
> > >
> > > On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
> > > >
> > > >
> > > > On 6/7/25 11:37, Dario Binacchi wrote:
> > > > > The series adds support for stm32h747-discovery board.
> > > > >
> > > > > Detailed information can be found at:
> > > > > https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> > > > >
> > > > >
> > > > > Dario Binacchi (9):
> > > > >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandl=
es
> > > > >   dt-bindings: arm: stm32: add compatible for stm32h747i-disco bo=
ard
> > > > >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_=
CK
> > > > >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> > > > >   ARM: dts: stm32: add pin map for UART8 controller on stm32h743
> > > > >   ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
> > > > >   ARM: dts: stm32: support STM32h747i-disco board
> > > > >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> > > > >   board: stm32: add stm32h747-discovery board support
> > > >
> > > >
> > > > Hi Dario
> > > >
> > > > For the whole series
> > > > Applied to u-boot-stm32/next
> > >
> > > Please give some time for other maintainers to review this patch-set.
> > > The dts/upstream patches in this series aren't clean cherry pick from
> > > upstream.
> >=20
> > All the commits are already in the mainline Linux kernel, specifically
> > in v6.16-rc1.
> > If you're referring to the fact that the patches can't be applied
> > cleanly, I believe it's
> > because the target path in the Linux kernel doesn't match the one in U-=
Boot.
> > In fact, the DTS files are located in two different relative paths.
>=20
> That's exactly why we have (refer here [1]):
>=20
> ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
>=20
> You should have waited v6.16-rc1 tag to be synced into
> devicetree-rebasing [2] for the cherry-picks to work. This way of
> manually patching dts/upstream is not allowed since it is going to break
> DT syncs in one way or another.
>=20
> So I would suggest you to wait for v6.16-rc1 to land in DT rebasing tree
> and then send v2 with proper cherry picked patches.
>=20
> [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#res=
yncing-with-devicetree-rebasing
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree=
-rebasing.git

To be honest, I don't think this is a big deal. Git will be merging
based on content and not specific hashes. And in the case of conflicts I
just copy the file from the tag to our tree.

--=20
Tom

--kgMtOV1OLw/tHJl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhHArMACgkQFHw5/5Y0
tyz3+wv+PkV/p4+PEflB8lFyxxgIPmzv8TbHXpn0C6Mf1FtbCnCI9ZHijpMtv6tB
cY+V3Oo/8/iM00EJQ845xRTbfyRyJkCrKcepzyAyZudj6A/qRSrE8VvCYmMkVrLv
2d7l12ahO7QIUnbd7MsLNBX6fWrKCJXn6yNfAgTio5te07rsoAfwRvx8DhCPzPNr
Zmacq6pKNfKcR3uawatdVylvHel5pkzZtM4mIKjrdR9jCQFnFwJUDc2i+CuGUXhj
fYSyBh1g0464BVyluHyxCllJc5awdZA6+8g8+dxxPV7B2WOfOYG6gTYirwgbtIT5
qx+lGf5iSTUQPIW0PjrRoD/YkjjmaX3GEdXhg004FdMIRe604veJsb3jWpyaYkpQ
B3+lQ9+WOCX2ESPyghNAWBfCQ9yQ5o4uPpIe3g3Xb+UYQzjEkIk3dRKltlOCPL5/
q3ZRF0X+0p6gtasPMV/N2aEMDcSsm+8HVBZ97gaezTr2YTHk0wXzFEKSnO+AcB5s
emo+isvl
=0LBQ
-----END PGP SIGNATURE-----

--kgMtOV1OLw/tHJl9--
