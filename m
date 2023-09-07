Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547FCEC8750
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 19:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AEB18657B;
	Thu,  7 Sep 2023 21:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JPbFOu9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C755086682; Thu,  7 Sep 2023 21:23:34 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B000386487
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 21:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59231a1ca9eso13684517b3.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694114610; x=1694719410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+m17NMzwoToNbqe4xAGzQ7SfQ+a18rGjkEl841A/H7E=;
 b=JPbFOu9RvKpPsdzXS7RJiHVvTxxPDr0mAEM3Nr23A0Z4l71zJuY8UuBHgV26GgohJ8
 4Nna6ATviqsRvMJp9NVBZKOj/ETC9iF9lUrEhbih47jhYFSx4hN/JusEiwxKulMPddyv
 4NtOrEVOckguE5b7trh2+gPdT44SA7IbacTfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694114610; x=1694719410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+m17NMzwoToNbqe4xAGzQ7SfQ+a18rGjkEl841A/H7E=;
 b=MbC/lvYX6mpMKJv2D1zfGP4rQLDzKrRGDnoaToopcws7FUl7eOrEoVNzDkOdHITUPt
 E8NamgTBdFPmzTymZIjp3+j3yIc0Gkh0/V9HsGM+mqBsCFgoP4+RLttJ1nwlEnP/A7Rc
 adn3nYJ48TlNXG2x2i15MmISsc0TCSrHnoo0NPU9Ri8KttO1Mda/cbcQk4lU2uXSzqpg
 p10RqUGry8KWCwznuV12tQCOTeOzJz4PulibG1eHstQszh/z6z80LSn1kGux/pMylN/l
 4GTA+XKjOJmfrlMg/di2y1GKEMBobhnK1my+yAV5vreba0Vx181ItJa/iKa+1//lS/gY
 vQAg==
X-Gm-Message-State: AOJu0YykpKmgrZIIX9zkfAIwBClHTbOFSsc3HrDhplXbeSxlbR8otWV8
 cI85y/Gs1wFXi+oL+0YlZsOaVQ==
X-Google-Smtp-Source: AGHT+IF8kgh/WjINQukVCt7nUsGPlGmWDVww8wWj3jSsGh3p5YzQNbpvG+LnpQTT4DMtXDxs+tz+NQ==
X-Received: by 2002:a81:6588:0:b0:59b:1f6d:1958 with SMTP id
 z130-20020a816588000000b0059b1f6d1958mr545820ywb.46.1694114610427; 
 Thu, 07 Sep 2023 12:23:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 i143-20020a819195000000b00586b5b6347csm26027ywg.109.2023.09.07.12.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 12:23:29 -0700 (PDT)
Date: Thu, 7 Sep 2023 15:23:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, Michal Simek <monstr@monstr.eu>,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, goldsimon@gmx.de
Subject: Re: [PATCHv7 00/15] net/lwip: add lwip library for the network stack
Message-ID: <20230907192327.GY305624@bill-the-cat>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <CAHTX3dKEqFNMQf+-FSO7oZerT03fQb1Z1BYvN3-dfpmoPtZQFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zLTpSg6j2/QFtFHp"
Content-Disposition: inline
In-Reply-To: <CAHTX3dKEqFNMQf+-FSO7oZerT03fQb1Z1BYvN3-dfpmoPtZQFg@mail.gmail.com>
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


--zLTpSg6j2/QFtFHp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 05:21:18PM +0200, Michal Simek wrote:
> Hi,
>=20
> =FAt 22. 8. 2023 v 11:38 odes=EDlatel Maxim Uvarov <maxim.uvarov@linaro.o=
rg> napsal:
> >
> > Hello,
> >
> > I'm sending v7, with all v6 comments getting fixed. The only thing left=
 is a pointer
> > to timeout callback which 2 applications use. I will rework this timeout
> > in next v8. I started take a look at it, and want to fix this together
> > with background applications support in v8.
> >
> > changelog:
> >         v7: - more review fixes.
> >             - support of multiply eth devices, were "ethact" selects the
> >               active device.
> >         v6: - fixed review comments for v5 (thanks Ilias and Simon).
> >             - lwip is not under /net, so prior applying patch following
> >               commit is needed to create lwIP merge into U-Boot:
> >               git subtree add --prefix net/lwip/lwip-external https://g=
it.savannah.nongnu.org/git/lwip.git master --squash
>=20
> I think you should integrate it via .gitmodules as is done for example in=
 qemu.

I _think_ I am leaning towards subtree, but it sounds like we need to
make the initial build easier, perhaps some Makefile logic to see we
haven't added, and then do what's needed?

--=20
Tom

--zLTpSg6j2/QFtFHp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT6IywACgkQFHw5/5Y0
tyzbsgv/RWwAbhpw9cQlieF5IAQQP2c7W1Nymz4+SjQ5j/0Q74eiec/fm2luGfss
+X14UolYlFcqek3+gh7NCpmYgCnTzY1lM6GWMMlXdSgvMCT+zPbeqc5Nj26mBP1c
snfmAHINqXPIF51GHHp+vT8aJSbs1Nx8sU/z8Ot7BimS5GpHgmRpKF844suIdW9f
I2VpRvZecrzx2xJ447PI4j9ySoqBXvsIGqbFMA18fLm/6ubBng2x8swP9OGhdwZj
tUhJAmlWkd+a6LXOdjQcvftC6b/23PLja0MPbbwMN+dR8mZFm+PM3XswUdGd0dyu
Z2YRtPb4rEb6O2T+oanQnxtoUGdHkoNTnaSjraEZPlpydgw+lFYG7cPmcu+8PFEj
f1OptGa87NzYmrVi7K94oOqj8O/6LH5BoIKTo0Vrjy7PfoSHqV0gWgceneTm6Vdg
moE+CQ7xbaAc5a4reAxT+Io+BpXutQFNDxB/u60HhFZPX7rFZaDXJmwNBO0S+/+9
awrCPsAY
=qB/L
-----END PGP SIGNATURE-----

--zLTpSg6j2/QFtFHp--
