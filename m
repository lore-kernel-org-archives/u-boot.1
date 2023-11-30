Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510BAC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC89F875FE;
	Thu, 30 Nov 2023 15:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YN4zgDjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D861875EE; Thu, 30 Nov 2023 15:35:20 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B71F87646
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59b5484fbe6so10685517b3.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701354915; x=1701959715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yuUiHg1gNEuQuIP0VDVxyBBvxGeO5GULNSt+cGVGPCc=;
 b=YN4zgDjyWf9u6YLZDVHAqkvsxRA9LZKd0TZCAhNCh1993ezTmK+I9L7KXdEZXHA90V
 c3wRYZzBpoxo8PNEYz8dxGzVkuV3liezYIICdSfOTanHfidkjZ3za3b/48C4zjGa5eUk
 irL351EHWvrDNDK15SLeTKQfmC7WfYESv7Yog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701354915; x=1701959715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuUiHg1gNEuQuIP0VDVxyBBvxGeO5GULNSt+cGVGPCc=;
 b=pffRF6hFu1NgM+HTdKk1Rm6JA1vOBcXPqQPwznGWZV4nP+tYUC3QAYAD8Q0xmAHjuK
 CAiL/mtowoVK7wQoXIzCcMAVvUkZ56o8OWRj2SoHo1grxsp1/9N1zvpn0ToJTBVCllhm
 jgQvZPsIEy0HCEdk239TTq8QXmQPWdW+OZfX6Rx0gUEkrQUAR/KUInR7osJhu3Rnf0H2
 PoO5vwn48s3XyAgNDSjp/BxIZ5Xs5iEXKJttsnPTURXEU/Q6Npgb0hzebVdH5CvcpNMj
 BKh+uSFeI8rdFi4SRCiI0+crEVvtUzlMBepLjCZ3qC5E6U0frbqx+oOTj/S6NlktFAfp
 tUzg==
X-Gm-Message-State: AOJu0YxdEZJIeL22N1Ic4brhMGh3hp7lRvWGe/uSd9b2Qqr2Z9fwXVgZ
 7XCqqRFAmcS1JW1XOe0Lt1CpTQ==
X-Google-Smtp-Source: AGHT+IGM7jfC2v0GCGON9ASO35Gnsvqme3rwTfoiB20evVs6NECd9skVProCtcFf++/ZlAH5Sk5Brw==
X-Received: by 2002:a05:690c:3107:b0:5d0:b3b3:a3c6 with SMTP id
 fb7-20020a05690c310700b005d0b3b3a3c6mr10704779ywb.39.1701354914804; 
 Thu, 30 Nov 2023 06:35:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-61c1-9eeb-7219-1742.res6.spectrum.com.
 [2603:6081:7b00:6400:61c1:9eeb:7219:1742])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a81c246000000b005845e6f9b50sm385703ywg.113.2023.11.30.06.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 06:35:14 -0800 (PST)
Date: Thu, 30 Nov 2023 09:35:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, neil.armstrong@linaro.org,
 Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Message-ID: <20231130143512.GQ2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CXccClC/ze6VCEzy"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
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


--CXccClC/ze6VCEzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 01:02:25PM +0530, Sumit Garg wrote:
> On Wed, 29 Nov 2023 at 22:06, Neil Armstrong <neil.armstrong@linaro.org> =
wrote:
> >
> > On 29/11/2023 16:34, Caleb Connolly wrote:
> > >
> > >
> > > On 23/11/2023 07:04, Sumit Garg wrote:
> > >> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.=
org> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On 22/11/2023 14:27, Tom Rini wrote:
> > >>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> > >>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> > >>>>>>
> > >>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> > >>>>>>> Hi Caleb,
> > >>>>>>>
> > >>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@li=
naro.org> wrote:
> > >>>>>> [snip]
> > >>>>>>>> =3D=3D DT loading =3D=3D
> > >>>>>>>>
> > >>>>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
> > >>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a se=
condary
> > >>>>>>>> bootloader, so we can instead rely on the first-stage bootload=
er to
> > >>>>>>>> populate some useful FDT properties for us (notably the /memor=
y node and
> > >>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined with =
the memory
> > >>>>>>>> map changes above, this let's us entirely avoid configuring th=
e memory
> > >>>>>>>> map explicitly.
> > >>>>>>>
> > >>>>>>> Since with this change, we don't need to embed FDT blob in the =
u-boot
> > >>>>>>> binary, so I was thinking if we really need to import DTs from =
Linux
> > >>>>>>> for different platforms and then play a catchup game?
> > >>>
> > >>> For now, yes.
> > >>
> > >> But why? Is there any value added by larger u-boot specific DT (most
> > >> of the nodes being unused by u-boot) than what currently u-boot
> > >> supports? The more important part is to get alignment with Linux DT
> > >> bindings. If you need to have memory/reserved-memory nodes in u-boot
> > >> DT for generalization purposes then you should import those particul=
ar
> > >> nodes only.
> > >
> > > I've been thinking about and hacking on this for the last week or so,
> > > sorry for the delayed reply here.
> > >
> > > The value is in preventing any of the existing bindings from regressi=
ng,
>=20
> That is actually best addressed in Linux by checking the DTS against
> yaml DT bindings. We don't have that testing available in u-boot and
> only depend on careful reviews.

I would absolutely love for someone to make another attempt at updating
our kbuild infrastucture so that we can run the validation targets.

--=20
Tom

--CXccClC/ze6VCEzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVonZkACgkQFHw5/5Y0
tywciAwAqjxh6ehUhBa7KChLUyCepKWcGv64Hvzj0jjMhVjkx82OsNTbmmJzx89i
3wJiFCHaP02/vany1+ajR3WoENKAfnvd8lNj5dtB07oB8cqrFhi0D51qq6bR4RxM
1u1z36fFI8Ic7OGqWU5o1FeFPBefSEReIiV+ijN1MTe+p/klvEBCQl72GZAM6Osl
PBMC6vXO9+HqhST5w/yP/JianAP//Bv6JO8vtUIzDVZ9lAocAx/UBTuXXCId7I9H
EGXJDquYTLuwTaPytpSn5fNKdtOCAmcDAI2NQWXOWgyXZWr/CGZ3msDINp+Q/hk2
32d5nYwkmwKe1s8kB6RicxyYFLUh7doMuQtkiWaSgCccRIyAZ42yVIPwK2du2ons
ZSBLRcU1a2ItN6ZSib/qS3CudQ540TA4ThZnDXy1SfRTxCs0MdPMGgxXk4+lNsU3
xmvrrAu1VEnZglrthTvCoS21DZRIiFBGpgjT/V3LzwhEWD8blVXErTM4h0UxWzYn
eTrcmpVw
=sh0D
-----END PGP SIGNATURE-----

--CXccClC/ze6VCEzy--
