Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C66C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11D38210D;
	Mon,  5 May 2025 15:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OsXlNC0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7867C82757; Mon,  5 May 2025 15:45:48 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3239E820F6
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73044329768so3402984a34.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746452745; x=1747057545; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zkioIZu8nDGLq8bwI5+paihiCrcTPPhACBvwaf6p+So=;
 b=OsXlNC0/pjcmzWUjyLlgMqhe6u7pPTh3MAy+KLewjedxoyKfiZhbO9v+pnvQ6d9TAR
 UGPdo/pN1O7JQfgqHan4dH2S7ASDuREhxhwQ0C/sxAM+2GPWv9UYF3lZ5RqHk05dqkMV
 g46QVOl6ooq9LL+t2r2Dbj3DL/o7gyv4gCB2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746452745; x=1747057545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkioIZu8nDGLq8bwI5+paihiCrcTPPhACBvwaf6p+So=;
 b=Mc3EENyioNu6szgFW22TLVx2gt4Z5lr98ti53qAmbxowgEq6D2YoJAs9y1nfA9WaIE
 xBR/HTkzwqk989BDug2m/zvgQCukJwA/fzrOnD9l6O9Nv/W2sEdMJ5lt+mgmDCHQVNkr
 LI4QunEgBSxYdCgzMuM+APU7Y+sHBpumiWwIaN7q1dh76MwecgP3C377yF9OVkOYeoIZ
 jhHqhlFl/n7lEgfT3unR3MlkBINNLkOos9EjXPcmxGYvUb3Jno0O47N0HTyRLj4PNAS0
 doZZ8VHx9l8pf6WFYUCZ57uoCejs9WlhrIlcpwy1Y83MZKshAQOxzJo2q0u/dEUqr7FA
 +5ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCW93uvZXtJDJUjL8VsUpRP/Oa7htIbrHc73edpX6GPk7Azf+VocksMl5yaCRd8cI8daHAN3y4I=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3wedZBSKoCri9Scc/KwCJvw6+om6GOL1MVIzbrzr/QQBAm7+k
 FoexjG6+9jIIiXD+2CB+XWZDAJtGTp3zsmVqfafrprzQLUUC/CEaHCIlPyqRuJsul69WM3PSF46
 LaHI=
X-Gm-Gg: ASbGncugfiFpL4oaR9vEWTAPTh+JIoRZZpngIqJuNopJpfK26mquxDa4LESFeF0pt/x
 aqz/Wj7JKU0oJ2VL3QwAicUs287t13VM/auMAP76TZhfqN8q2Ri8m7HpKWrw+bSyYkpgXwV4B9t
 lthTEKMA99dyDVjftjwHSNN9kt1v3Kpqjr23zJ1enkwVkhlLnEFQWFrij+g49m8VrMV2w74Kx9B
 YmZ4zjNKjxfqM3iKtsmQIRXapz6GFEWLblBzgJpG1+Tzj0vj6si+lObQuMmORAOJYM4OqxI/mET
 wexLRBtiFUULaS6p15grmOqzZLGc/9ZKWWprj7EB/H5HS8WryPh43kwn+U3nMcbNkICcbAgQkP6
 nsg==
X-Google-Smtp-Source: AGHT+IGV7vf56BBPAeefAOLogrSEPpq9uV72b2X+3lL4OAErfLO0pmFmtiC5vsDC6F4WOcUQkMFO5g==
X-Received: by 2002:a05:6830:4803:b0:72b:940a:a7c9 with SMTP id
 46e09a7af769-731eae95dcamr3601358a34.27.1746452744811; 
 Mon, 05 May 2025 06:45:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d35051b5sm1496909a34.59.2025.05.05.06.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 06:45:44 -0700 (PDT)
Date: Mon, 5 May 2025 07:45:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250505134542.GH1261075@bill-the-cat>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <0e3e24ac-a4a2-4b44-8c13-d47a655ce7ee@linaro.org>
 <CAFLszThha_WkVyCVxwm1dqvbFaiyxw+khuuyfZKgnoVkHJk-eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zC26kCeggQxkwwCU"
Content-Disposition: inline
In-Reply-To: <CAFLszThha_WkVyCVxwm1dqvbFaiyxw+khuuyfZKgnoVkHJk-eA@mail.gmail.com>
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


--zC26kCeggQxkwwCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 02:58:06PM +0200, Simon Glass wrote:
> Hi Neil,
>=20
> On Mon, 5 May 2025 at 09:06, <neil.armstrong@linaro.org> wrote:
> >
> > Hi,
> >
> > On 02/05/2025 04:50, Simon Glass wrote:
> > > During a recent discussion with Heinrich we discussed why the hooks a=
re
> > > kept in a separate repo.
> > >
> > > The amount of code is small, a tenth of the size of the recently added
> > > lwip, just by way of example. Testing is a critical part of U-Boot and
> > > one of the things that distinguishes it from firmware projects that h=
ave
> > > not kept up in this area. By having the tests somewhere else, we are
> > > signalling that it is unusual, or difficult, or optional.
> > >
> > > The hooks mechanism also needs something of an update to take account=
 of
> > > real boards in 2025. That will be much easier to undertake if the code
> > > that test/py talks to is in the same repo.
> > >
> > > This series brings the hook files in as first-class citizens of U-Boo=
t.
> >
> > So this will definitely remove the ability to have test hooks out of the
> > U-boot tree ?
>=20
> No, not at all. I think Tom had the same thought, but I'm not sure where =
it
> is coming from. You can of course put the hooks wherever you like, since
> you have to specify the path for them anyway.
>=20
> >This is a major regression, and I do not want my test hooks
> > to be in the main u-boot tree for plenty of reasons, the main reasons is
> > that I need flexibility to handle my lab boards and I can't wait multip=
le
> > weeks to have the hooks fixed in the main tree.
> >
> > This could be enhanced, but I agree with Tom, it's a bad idea to merge
> > them in the main tree.
>=20
> Are there any other reasons, beside the misunderstanding here?

I don't think there's a misunderstanding here. If I follow what you're
saying, you want the hooks to primarily exist in the main source tree.
Yes, of course someone could maintain them out of tree instead. But
that's adding pain to that set of users. And I'm not sure what the
benefit is to anyone else to move them in-tree. We're making the project
CI path a tiny bit easier (but for what is also a small case) at the
expense of all of the other cases.

If we must save two steps in the case of testing new changes for CI, we
could add the u-boot-test-hooks repository as another git subtree. This
would make it easy to test new CI changes at the expense of making it
more costly (a git subtree resync) when we want to update the hooks
repository.

--=20
Tom

--zC26kCeggQxkwwCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYwQYACgkQFHw5/5Y0
tyxLCgwAmwA9O5undR3x/yb8crcP4lt7GNtdibgY54TDaqCFNmmo8oGeSqaX4hSZ
Rzy1HjA0MY1Fy2zwEV4S2KX/VRy3w5sEmt1o/CHz9+NSKu7HbUF4SvI/4taR2wk+
+UDQBxs7fLlvLfbl5Q96uYOhhpFTLYlUS7KU7h314e92m7yBfmQ2SJG9IUroJIPF
pG7IqY1Z7JIORREBJWNku3o0xr5ekwMMpy3K5pFZtZHjH4cK/CL/xi2LHiNj/XlU
x/ypZSGRH8M3u/WbDBVuBVfWbgwtkhu5vaR04ARaYAMZFu/wohGYGvhXJ8NvlFJw
OSqdk8z8QjOEa8qJune7DQmGDnl+PrM8vfueoL0HjvKRPUwMzgv1TGD2LxEf2XAb
D5cVjlupU6So2K8UDbBvhc+ESiV95XZ9Ra2tOnqu92uyKHVkkEWwdWPiQI6aNOHa
pWbtBGKzMh0WBhAIKmRhUWJejIa1i/3yeTFTybZHx7i1sEqpIpFtf2Z6pAYVwCd/
OABhdn/2
=uVj6
-----END PGP SIGNATURE-----

--zC26kCeggQxkwwCU--
