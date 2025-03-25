Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B72C36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87FB580F70;
	Tue, 25 Mar 2025 03:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JjgZz1oC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7750F81026; Tue, 25 Mar 2025 03:01:25 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F8A80EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso83656995ad.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742868081; x=1743472881; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x+gRoxy6/wxgAxAVKG2ynDNtCGYfSlZVo6pCkL1GuxI=;
 b=JjgZz1oCc0zhYtD/g9wTRPbdVTpQoDS7emhgm+UtYWFMiRGIQNAK9QI5tvX0hf0dke
 wW6A+BiggGwW3AtdZKiBGSf96LKsDQnEvu87FKqJqOy5VYlJo50yd2r9BnZNnrHcTg3d
 yKD2+7oyNIhwceyVgumiLU3USU4Va1Qfn5aYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742868081; x=1743472881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+gRoxy6/wxgAxAVKG2ynDNtCGYfSlZVo6pCkL1GuxI=;
 b=qcAAaiWLuCZAiXL1iYnQl51iPg/4o8GFWAd23Z7M6NmGPqRxk97MGNUJwlWWvN+4Ds
 Q4BIVSbJQkdpvZWYsZjMkZZKoJNfWFQJnKPt+tvdguJCTnYS2yK6vM2sGrU7qniuv/De
 EuzIDPE1Lrv2leKvYCyuLBn7YJHyeBpw3CqaXGaluGqraU8JAojfMvLCEX0C6aLeG2SD
 zrrIcFMlGgmxwA0qWSKk35wH/emY7UxCzFMX+mO+0vN2y75K+gVTfM6RuASKN8jJ0LhC
 whE9fUWWz5bH8pJd7Fe+U/gWduJUde0eG4krDUdc/SsrrqDoZZ4uzN9ar7xXe3DXhqo3
 Nlgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNSat0T84vQ8QSZkif8DqZbV7UE3DfjRwk0E6Obb1gEBFDDzSVhhQsBneV4y2ufaGOs/tABo4=@lists.denx.de
X-Gm-Message-State: AOJu0YwdCpWCJtmdRvBOvxjK9nrSQX0cMKn49lvJqfT6tq6JMO4W9YS1
 scvDrFnZlkWdlj/iNmU+AHqhvhKrtLWDfFeW9NkZKzy9CXS6SKPUpIj7VOZsG0A=
X-Gm-Gg: ASbGnctLyRM3g3S8YNAJ/pjBH4VXibab9LsPhnn1Rjp/tHF8by71DfZeqvakwUltA56
 RzgNOmWQQf+0cFU7S9vNOkW89ncfnJb5UbmZCRfgA7cDH102FwxadL8HRqg34NNY5htf5reSA0x
 MFhWhzbP0XTOAjpfYu7RgVOHu3c0nJph2p/rV5A2k7MjOJUFtCoQKXkTS9c+Fc1OaieENS9Wkud
 WyrAenQlM2U9ftxvl5JMBrgTu8VoZfM2ofrhyeUn5mQYtloPg5uhFvx2wu3RknhRxNdp2tKpfAu
 NYNTCbx+SP9FOcO1qlv1Px6hyaYZnWKnyPRcbF48nx4=
X-Google-Smtp-Source: AGHT+IE8bQlIIAOlhnZsYMIyzNUlfnUvAE4lTtkLunxoaECNqShrTRRumY6pgU2X6zYlZyMa5rhY2g==
X-Received: by 2002:a17:902:f685:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-2278067c27dmr212003495ad.3.1742868081108; 
 Mon, 24 Mar 2025 19:01:21 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f1462sm78012575ad.210.2025.03.24.19.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:01:20 -0700 (PDT)
Date: Mon, 24 Mar 2025 20:01:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PULL] Please pull qcom-next-20250324
Message-ID: <20250325020117.GE93000@bill-the-cat>
References: <20250324181903.499245-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4tFGvQ2z6Cm5xilK"
Content-Disposition: inline
In-Reply-To: <20250324181903.499245-1-caleb.connolly@linaro.org>
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


--4tFGvQ2z6Cm5xilK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 07:18:12PM +0100, Caleb Connolly wrote:

> Take 2, this includes that build failure fix, sorry about that.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipeline=
s/25297
>=20
> The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee10=
77:
>=20
>   Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2=
025-03-15 08:19:31 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-ne=
xt-20250324
>=20
> for you to fetch changes up to dcb6a5e7651f4a6cebfad4389119407e2a852783:
>=20
>   mach-snapdragon: always select SYSRESET_PSCI for ARCH_SNAPDRAGON (2025-=
03-18 11:55:14 +0000)
>=20

I pulled the merge commit message out of v1 as that looked right. And
please note that b4 doesn't support the "git@.." protocol. Which on the
other hand is useful when I have more to say than just applied ;)

Applied to u-boot/next, thanks!

--=20
Tom

--4tFGvQ2z6Cm5xilK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfiDm0ACgkQFHw5/5Y0
tyy4iAv+MnNp84tGdXsb0TKphvrmQ6omQ1HNc6sq8HsOaYOaevO7RAQqaiGQTmWb
Znv6aUkssDpZgVSdblEnQ81icmk1pp9PRRTRsQLVVSrmNRJdekM8hP1BKOgy9XXd
xDleqz7KAv0jA6FUiLoV57pgGrh4tb74ryf1zouLgWviTj9Vo8drsV0p/ng6fNLp
Jm3qsTabkpJnJg2HWz71ZuNMwqvhmIy3SZ/lWfdevFvcorOo9pTjNVa2ugPK1yR2
FLTjogwTubBq3PHau+h8Fr2MJMrbDQXmkU57xLO63SLfXIL/Br9DW6WlPY08+M/K
VMC7Gu5MGgx7o1n0UuIBsCvSF58Oq/LEhZIg9ijcOYgf7TSM5dQ+g1o+3JsSZBF/
NYbptHFB6/2XuHwqMVY5wPE3YKxDLoExIUitjek6f5js8aMP02V7KPQTgGfg1xLP
/mRl0yLeQJdzNbPQoCGZLmzw9EYqcdchIDRnF66cgA96DBCfKENDgDHV4AP4Qsyl
FaIgGBxY
=yKk3
-----END PGP SIGNATURE-----

--4tFGvQ2z6Cm5xilK--
