Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD732EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 07:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D0A98422F;
	Tue, 22 Aug 2023 09:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NinTw86L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21E285991; Tue, 22 Aug 2023 09:40:50 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4CF805CB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c47ef365cso564060866b.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692690047; x=1693294847;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2u8AuwZfEvl8gSV2vH8t7UtlCGt64dWJqFk8PY/6NxU=;
 b=NinTw86LIWnwlE1ENF0DzudpSJd6+wf/vmKe9bVBIlofR1TMbkDOEcE7lO0UVZRU2W
 Z3hDYm4+sXVqlU7VkbIQ/g6BkrtMsciW+r4INdJCr7v93IO6ZSk27Je7R6Y8E6DmkAks
 xQiNeyiqEzXtfp0Xlyf3RK/V48ULtAFRtQaPOaO6bjTkC8TbPZOhB6OTOsiJZgG006Yp
 gT86zmqaIBKrXSa5cPZW6xuz1gksJILeDJcwOjZX9rSAsQSoFF7TKbSC2+VJEfJspLLY
 c11ltXeFFkqDV3e648/m4DuU9fnqok3ZMQ6JB1kvOd/oLVI1ZQMg8VflOFExPuQRKSJq
 QylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692690047; x=1693294847;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2u8AuwZfEvl8gSV2vH8t7UtlCGt64dWJqFk8PY/6NxU=;
 b=juvqJ5WQwINO6c4Su8WiTI7PjwaJb0u+juUSX15rIcNPu4fp4NCTDisy2S62XW2qh8
 2+xIPK8nyf+t7KQn+8398Sxuvm/3YAfeDdB33ueqk5pu35eeqN15/ixdPwYiuO1unSIo
 L1zLFFtPoDoRGEz2VkwzCiKYdQO47LTwT8AroJK4n6hRLPzmoF6E1Z4HG/2T5krXnk/j
 mxXr2A+CnFQY0HmojzfDAqtvTgLu+MsqwRkEKZx4UkcxELhRtm1kdArWuF1ES0VBx6dX
 KAQj+GBaXBccAZFEv/YVabl7SMqHy20akO0TZO1fCSFkMuWEaNOtrevD+lXMjVYaM5cm
 LqcA==
X-Gm-Message-State: AOJu0Yzgk3klI1j/Tqir0jdcr+Vj7cgdiTlIZshckDkQrMdcwxkKuYHY
 +YhkZaKUWnf88rXtVyq/RQg=
X-Google-Smtp-Source: AGHT+IHqjxdllXQnD3DJ6oaX6h15C3QzquCwfmqSxnAfX6DrvquUUsnRFZq3mH4G5SXPuLpkQLdrJQ==
X-Received: by 2002:a17:906:3089:b0:9a1:c216:c89c with SMTP id
 9-20020a170906308900b009a1c216c89cmr251495ejv.66.1692690046783; 
 Tue, 22 Aug 2023 00:40:46 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 bx8-20020a170906a1c800b0098e0a937a6asm7718385ejb.69.2023.08.22.00.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 00:40:46 -0700 (PDT)
Date: Tue, 22 Aug 2023 09:40:44 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
Message-ID: <ZORmfDblupZkjoh-@orome>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
 <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
 <20230818170447.GA1515023@bill-the-cat>
 <5DFCCFFB-D137-4530-8AF9-C72071842A60@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k5xEj+3NEZzCDXuo"
Content-Disposition: inline
In-Reply-To: <5DFCCFFB-D137-4530-8AF9-C72071842A60@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--k5xEj+3NEZzCDXuo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 08:16:29AM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 20:04:47 GMT+03:00, =
Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
> >On Fri, Aug 18, 2023 at 08:02:30PM +0300, Svyatoslav Ryhel wrote:
> >>=20
> >>=20
> >> 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 19:49:43 GMT+03:0=
0, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2=
(-=D0=BB=D0=B0):
> >> >On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
> >> >
> >> >> From: Thierry Reding <treding@nvidia.com>
> >> >>=20
> >> >> Hi Tom,
> >> >>=20
> >> >> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f=
2f3afe19:
> >> >>=20
> >> >>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023-0=
6-21 14:42:50 -0400)
> >> >>=20
> >> >> are available in the Git repository at:
> >> >>=20
> >> >>   git@source.denx.de:u-boot/custodians/u-boot-tegra.git tags/tegra-=
for-2023.10-rc1
> >> >
> >> >FYI, in your .git/config you can do:
> >> >	url =3D https://source.denx.de/u-boot/custodians/u-boot-tegra.git
> >> >	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-tegra.git
> >> >
> >> >And this part looks "nicer".  Not a big deal, just an FYI.
> >> >
> >> >> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430b5=
31ec:
> >> >>=20
> >> >>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +02=
00)
> >> >>=20
> >> >> This passes CI successfully:
> >> >>=20
> >> >>   https://source.denx.de/u-boot/custodians/u-boot-tegra/-/pipelines=
/17411
> >> >>=20
> >> >> Thanks,
> >> >> Thierry
> >> >>=20
> >> >> ----------------------------------------------------------------
> >> >> ARM: tegra: Changes for v2023.10-rc1
> >> >>=20
> >> >> This adds support for various new Tegra30 boards (ASUS, LG and HTC)=
 and
> >> >> has some other minor enhancements, such as enabling the poweroff co=
mmand
> >> >> on several Tegra210 and Tegra186 boards.
> >> >>=20
> >> >> ----------------------------------------------------------------
> >> >> Jonas Schw=C3=B6bel (1):
> >> >>       configs: tegra-common-post: make PXE and DHCP boot targets op=
tional
> >> >>=20
> >> >> Svyatoslav Ryhel (6):
> >> >>       configs: tegra-common-post: add GPIO keyboard as STDIN device
> >> >>       ARM: tegra: add SoC UID calculation function
> >> >>       board: asus: transformer: add ASUS Transformer T30 family sup=
port
> >> >>       board: asus: grouper: add Google Nexus 7 (2012) support
> >> >>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
> >> >>       board: htc: endeavoru: add One X support
> >> >>=20
> >> >> Thierry Reding (2):
> >> >>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jetson =
Nano
> >> >>       ARM: tegra: Enable poweroff command on Jetson TX2
> >> >>=20
> >> >> Tomasz Maciej Nowak (1):
> >> >>       ARM: dts: trimslice: sync SPI node with Linux dts
> >> >
> >> >Since I'm not sure if this is v8 or v9, given when v9 was posted, I've
> >> >applied this PR now, as I had said I wanted this in.  I do have two
> >> >requests for you Svyatoslav, however.  First, if there's changes that
> >> >are missing in master, please post those ASAP and we'll get them in, =
for
> >> >v2023.10.=20
> >>=20
> >> Patches Thierry applied are v8, while v9 has significant improvements.
> >
> >OK, I've updated patchwork to try and reflect this too.
> >
>=20
> Merged patches are not the most recent I have sent. How to fix this?

Usually once something has been merged it's difficult to back it out. So
unless Tom can (and is willing to) somehow redo the merge with the
newest patches, you're going to have to rebase what you have and send
out as follow-up patches.

That's one of the reasons why you shouldn't keep sending new versions of
patches once things have settled down and there haven't been any more
review comments on the list. The assumption is that when you send
patches out you think they are all done. They may still need to be
updated based on review comments and that's fine because there's
communication on the mailing list to indicate so. Once discussions have
stopped it is assumed that the patches are done. This doesn't
necessarily mean that they get picked up right away, because people
might be busy.

The prudent thing to do in such cases, in my experience, is to leave the
patches as-is and do any subsequent changes in follow-up patches. If you
quickly notice that there will need to be more changes, then let people
know as soon as possible, otherwise they may apply patches and run tests
on them, all of which will have to be redone if you repost a new version
later on.

In this particular case I was in the process of preparing the pull
request to Tom and didn't see v9 until I had sent out the PR.

Depending on who you're sending patches to the "point of no return"
could be a lot sooner. Once patches are applied to a custodian tree and
other patches have been applied on top, switching out new versions of
patches can become really messy. Once they hit the mainline it often
becomes impossible.

Thierry

--k5xEj+3NEZzCDXuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTkZnoACgkQ3SOs138+
s6Gd9hAApkCEONx6VxC+PYeHLF11adOPxTc27Qoj0cQspPZWZDwigD1CE+aNND5z
7IpdAalFFBPx5B9mdXagZ9zBy426o5F6r7dFyAysk5aeE/DamGR4bSLWGBKa0mIJ
GiPB+yXDgm9ZNfnZTDg2LAU6ZUqfksxG4WjZznD9VSC93Bk4OtD3GQmSpdmIdpPA
J8jW5H9crvf/D29OLrUnKHvteMUxUlJNWLw4n1unSiFs3nD52pPmTq+HMGe9NjDd
sDJ1mu+uGRKVDmRMj1SJ9Fb6KFqbYiCUmt68qisB9XaR7N31Djd4Bq/82B+VMo8H
ib8e+PGh7vlqvQ3Z88D9eRfvkXqLK2TBStrxom9UAx8IFercYrg6TLpDYLO+9x5g
NatwUMVU29B4k+G8njRvNKRaGXqj9RzSGRyHQNwdsYIcD+g0/NO98HDxU8gD7EE0
vSyAtAm1r+BIQkKHVXu98I1bss24exsH2/fohuIB3O1oh5B/ugRYPtsAY6oOclyw
waAwzTmLuhNMbvtXwbXJuohC6OdL4kh3qnjjg0p0A9KRGQAY0vI0xyv6cvkx/XIC
RRagdKbTDBtMdLq7Gh++CgCo+AeHCjqb97oPPq8mCUNnRuM6amasJjX7at2MsahC
o+6BHT0Xr/1B4ab6wNzgNQtV9Kaypd1+JwHqSNMkIGrlNSO+JqI=
=2c6J
-----END PGP SIGNATURE-----

--k5xEj+3NEZzCDXuo--
