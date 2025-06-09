Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4AAC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 16:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0B9882998;
	Mon,  9 Jun 2025 18:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a1PDQ5Vx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244E282998; Mon,  9 Jun 2025 18:22:47 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 729B0826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 18:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso2813555fac.3
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749486163; x=1750090963; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/HDH5EqaoG2G/SeODK6F9H/o24tlGfFInDKDDAqDRnw=;
 b=a1PDQ5Vx1F+U7HP4k+MvGINV2axlnOGMR9uIFgggqVMDhzqItAop1IqYcHGZLWMulY
 UzJtEKLpsuV3SZuJ9VpyqsvhUh/49tgcOTS4R7AR6hfj+1IzjDTJ6+OANCTRX3a2nl2x
 YuviGunTiKJh8ZMtmwAaQbiVHei4jQOht12t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749486163; x=1750090963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HDH5EqaoG2G/SeODK6F9H/o24tlGfFInDKDDAqDRnw=;
 b=fe0XhAsrDTZVWs5+xCBugEqgQOrRWA0vXCAnE+Hf1FOKOFFkMV8zDuYf6JOm7jGt/c
 Sp2Wv7UlTaXLdeTChoawEZMsxLyg4mI+Aqvjl3AT2+dNAWvx2yc7RhuQtvZBtKzhdcNE
 ukY2jridlBLiWIc6lJujTfAKHRObWfFbNk5TOjCGtQZFYGUUS0oQ0Zjvv3YCkJwtnX1k
 P/46axv98YJTKRAzaHTBwWNGm65jnMefo+ckvobVBE6l1TvTYgXRr9rifKBfO4apRQkz
 y49KZLCfSWTiy+eH9kiP2JQTrLebzhGHbjSJTTU4Lhk4go3ifwlHbA0D/4WlLuRepbQc
 pzdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHuLXyEAxsTRqwVNsXabO3F2Ut30KT+DHHimCP8ipkgvniivwOo9WjPLJhbO7YQsbjdHOdKKU=@lists.denx.de
X-Gm-Message-State: AOJu0YxveGGZ2m01hpr3iyU/hfMq1QVRvCWZknp1dtfc+iSN3K/F3LfV
 mdSLusHx7CByWT8ZNwpU//voHduwdgrK+PFBrvwCZFfIFetJuw67615TDz9HIpNn8SY=
X-Gm-Gg: ASbGncsMTr4OW7ifgazd139XCQJkvv2uUkuYBEO8831zRW8Fyq8f9BoetG7SgHdqZ8I
 e768Trt0wm9r4my41OeI/pQIjA6thBTiWDLr0gP3VUL7Fk3iIQbVcEi1/FbgR6/VQiSsBqAgq2G
 btZvQRRD6UgTw1btD6OraxnCTTocFU6Lln04Y+fG7xW1Rg4/6iQepbr3b8H++ukJcBcPfLoOUXV
 qh+Euoxb1GTrGrPsnrjRDuQSKGcGWUaHuU/JQ0ujH4vEbHiKgQ/yYg95V7dPj6K3GrKDfVmseVp
 tfkprxc0A0Gr2vIz+eJgwqQW7pMbtu2p+Z04qcULjUCHWGuFZZkWrCq2UacJa+nKZ00NW8Kbala
 Wc5vEk0aSB7kp
X-Google-Smtp-Source: AGHT+IGmcPgvaeafR4gDWPsdNmoJ3kkB3Pe9rmlI6BjAT/Yj1FLakMcekfw7bqllLknOyjTbPT3gdw==
X-Received: by 2002:a05:6871:d101:b0:2d8:957a:5163 with SMTP id
 586e51a60fabf-2ea00817781mr8829799fac.10.1749486162990; 
 Mon, 09 Jun 2025 09:22:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea642a55b1sm329923fac.7.2025.06.09.09.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:22:42 -0700 (PDT)
Date: Mon, 9 Jun 2025 10:22:39 -0600
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
Message-ID: <20250609162239.GT1382132@bill-the-cat>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
 <aEbgxo0WUDPd-S8Z@sumit-X1>
 <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
 <aEcAe80kh66cf0_c@sumit-X1> <20250609155019.GR1382132@bill-the-cat>
 <aEcGzCbZXajCthrh@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O5az6EqOTJVqen05"
Content-Disposition: inline
In-Reply-To: <aEcGzCbZXajCthrh@sumit-X1>
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


--O5az6EqOTJVqen05
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 05:07:40PM +0100, Sumit Garg wrote:
> On Mon, Jun 09, 2025 at 09:50:19AM -0600, Tom Rini wrote:
> > On Mon, Jun 09, 2025 at 04:40:43PM +0100, Sumit Garg wrote:
> > > On Mon, Jun 09, 2025 at 03:46:27PM +0200, Dario Binacchi wrote:
> > > > Hi Sumit,
> > > >=20
> > > > On Mon, Jun 9, 2025 at 3:25=E2=80=AFPM Sumit Garg <sumit.garg@kerne=
l.org> wrote:
> > > > >
> > > > > Hi Patrice,
> > > > >
> > > > > On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
> > > > > >
> > > > > >
> > > > > > On 6/7/25 11:37, Dario Binacchi wrote:
> > > > > > > The series adds support for stm32h747-discovery board.
> > > > > > >
> > > > > > > Detailed information can be found at:
> > > > > > > https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> > > > > > >
> > > > > > >
> > > > > > > Dario Binacchi (9):
> > > > > > >   ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins ph=
andles
> > > > > > >   dt-bindings: arm: stm32: add compatible for stm32h747i-disc=
o board
> > > > > > >   dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7=
,8}_CK
> > > > > > >   ARM: dts: stm32: add uart8 node for stm32h743 MCU
> > > > > > >   ARM: dts: stm32: add pin map for UART8 controller on stm32h=
743
> > > > > > >   ARM: dts: stm32: add an extra pin map for USART1 on stm32h7=
43
> > > > > > >   ARM: dts: stm32: support STM32h747i-disco board
> > > > > > >   ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
> > > > > > >   board: stm32: add stm32h747-discovery board support
> > > > > >
> > > > > >
> > > > > > Hi Dario
> > > > > >
> > > > > > For the whole series
> > > > > > Applied to u-boot-stm32/next
> > > > >
> > > > > Please give some time for other maintainers to review this patch-=
set.
> > > > > The dts/upstream patches in this series aren't clean cherry pick =
=66rom
> > > > > upstream.
> > > >=20
> > > > All the commits are already in the mainline Linux kernel, specifica=
lly
> > > > in v6.16-rc1.
> > > > If you're referring to the fact that the patches can't be applied
> > > > cleanly, I believe it's
> > > > because the target path in the Linux kernel doesn't match the one i=
n U-Boot.
> > > > In fact, the DTS files are located in two different relative paths.
> > >=20
> > > That's exactly why we have (refer here [1]):
> > >=20
> > > ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
> > >=20
> > > You should have waited v6.16-rc1 tag to be synced into
> > > devicetree-rebasing [2] for the cherry-picks to work. This way of
> > > manually patching dts/upstream is not allowed since it is going to br=
eak
> > > DT syncs in one way or another.
> > >=20
> > > So I would suggest you to wait for v6.16-rc1 to land in DT rebasing t=
ree
> > > and then send v2 with proper cherry picked patches.
> > >=20
> > > [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html=
#resyncing-with-devicetree-rebasing
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/device=
tree-rebasing.git
> >=20
> > To be honest, I don't think this is a big deal. Git will be merging
> > based on content and not specific hashes. And in the case of conflicts I
> > just copy the file from the tag to our tree.
>=20
> The essential problem here to me is we are going to allow manual
> patching of dts/upstream tree given this example? How do we keep track
> if all that manual patching landed in Linux DT mainline? The cherry
> picks ensured that we always keep in sync with mainline.
>=20
> Lets take an example what if Git automatically resolved a merge conflict
> for you with duplicated content or if manually patching a DTS file
> diverged from upstream and get unnoticed during DT syncs?
>=20
> IMHO, we should try to avoid manual patching of DT subtree otherwise it
> is hard to set a policy as to what level of manual patching is allowed
> or not.

Part of the problem here is that from the standpoint of applying posted
patches there's no functional difference between what Dario did here and
what could be done once v6.16-rc1-dts is tagged (if it's not already).
It's essentially a "manual patch" either way. We make it clear that
dts/upstream/ *only* gets changes that are in Linus' tree. If someone
tries to be sneaky and push something in that's not quite what's
upstream, it will get stomped on later and there's not going to be any
sympathy for the now broken platform.

Yes, we document saying to use the cherry-pick script, and that's what
people should do in general. But I don't think there's value in adding a
further delay between "in Linus' tree" and "in devicetree-rebasing". In
the linux kernel, there's thousands of people working on things and so
strict rules can be understandable (someone will be running a bot to
look for "(cherry pick from commit $hash)" and fail things where $hash
doesn't exist, makes sense). Here if the ST custodians are happy just
verifying the kernel commit, OK, that's fine. Or if they want to wait,
that's fine too. We can be a little relaxed and let custodians do what
they see as best.

--=20
Tom

--O5az6EqOTJVqen05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhHCksACgkQFHw5/5Y0
tywD1gwAo7WR+HUndyQw3xkLZTkSqBGtuUl223Tp/5yvx9jT/tsJ+iAnkzMTvSky
iFfbNkr8g76UyXIg9AXfVlp0yOhJCRZ4YnN2UiPVzGAFeghYFNiIVvqGutY6ih+C
U/XHgcIj3lGgBPHnr1y+BECtBexI3WWrytRAcUFvG0F3TjT9ETGuOPsPjrElqw1e
VB7phj0VFuIdwLicVsexZ8hI5fSYs/RO1KRyC9gx/Zznn3taiMPkFUhDEeahWMET
axv3ERP9nI6eFzXojon/ZFHrk11QKGTf0vSsPjYb/QBCCCTkmExqnGu/Wwohj6o4
KS4z4wmtPmEWzMpyro3Al5pEVNnWxHmAaRo++ARS79dw7brcy7hg/imrWT3H6U1o
qvPrc31KXucAE5SdSpAnbW8csOaagQZpHyIVrs4XU5pbqXcle+N0qT/zdGmbErVb
bRjvLuHuY635+UEJbioRjYhj8WU1kO4O/zpvTDf8lyMn5Uc4ovhEhXp129/Ql2Pu
8Wx+mcgy
=Mzi/
-----END PGP SIGNATURE-----

--O5az6EqOTJVqen05--
