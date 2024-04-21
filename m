Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E268C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 01:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413E8881FB;
	Sun, 21 Apr 2024 03:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F7YSuWtH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC98881A4; Sun, 21 Apr 2024 03:28:01 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03E7881A4
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 03:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78f02298dc6so274097985a.1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713662878; x=1714267678; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hOdCP/i44NcZrsuzuFj8x92dcKTIwTgbzv6k3lZx2J8=;
 b=F7YSuWtHJbDrKvVIMX68q1IPGm3zKcCZYeFHb2lL3VhG5/fFNZYXhi798vLF5u7KNz
 d0Qme2uydakD/T5fkAEqIGieR/oUmatVJjxyEmQcUdHOylYDNXmF3AZFUeQwgd0GUNW6
 1YcuSucEDItBRngIApIb/h2qcH9s7NDCRpSlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713662878; x=1714267678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOdCP/i44NcZrsuzuFj8x92dcKTIwTgbzv6k3lZx2J8=;
 b=oIQ7lbPojx8vrOkJB1hH0NK22vV8m7p3uumhKfLIobcM33oOEwdAAmpdZtAETqErpe
 Z7222W9N2YfEDJsnQwb7RfoRtZM1fIsfmWYsX129cinIELUPYpRYTBmAAE2Essaou+X2
 HmRlSwFGkdbnLyXEYILoY06bPNIH27P8bMS1++XQugh+Yb6/smX7G2gTHYqj1D9xIu6+
 0jZedd9BFaVOigO34/5PaIDI7Rro+R86thEYMBA+4FQVnZFDDaEAhFwjxNFE7jalqYDB
 djCbxMgQJkPFrleNKI2xAEGM62eeB9vLPdgvR3QzXZFsChReO0r1Ip0Kld1kOFD1C2FU
 q3Jw==
X-Gm-Message-State: AOJu0Yx/P328Ta1Ak5NF+vzVkEQbLoP5ICIPcBppd4XNet1xY4ibAzXJ
 3u5P9zAYvrWVpyq4/HcJIQQ43Dd/4de70Cz9eYvz1YuVmYEJaUFQARoXh1pho/A=
X-Google-Smtp-Source: AGHT+IEiPq0Tr8kbPOIMQahdFlbSdcZmd5Bf/wt4XgxZBPulReRfEMYMEg/x8Ov5fDS681dA9RyCqQ==
X-Received: by 2002:a05:620a:146a:b0:78e:cf14:f89a with SMTP id
 j10-20020a05620a146a00b0078ecf14f89amr9852119qkl.9.1713662877754; 
 Sat, 20 Apr 2024 18:27:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a165500b0078d679f6efesm2949153qko.16.2024.04.20.18.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 18:27:56 -0700 (PDT)
Date: Sat, 20 Apr 2024 19:27:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: Pull request efi-2024-07-rc1-3
Message-ID: <20240421012753.GQ1054907@bill-the-cat>
References: <f40c6e8f-3cb6-4c67-b386-764fadd6aee5@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XdsDHSAUOisLGfjI"
Content-Disposition: inline
In-Reply-To: <f40c6e8f-3cb6-4c67-b386-764fadd6aee5@gmx.de>
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


--XdsDHSAUOisLGfjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 12:09:37PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit af04f37a78c7e61597fb9ed6db2c8f8d7f8b0f=
92:
>=20
>   Merge tag 'u-boot-stm32-20240419' of
> https://source.denx.de/u-boot/custodians/u-boot-stm (2024-04-19 14:25:04
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-07-rc1-3
>=20
> for you to fetch changes up to 52c62acc349a0ec1ba26ae497913ad34ee3de733:
>=20
>   x86: all firmware tables must be paragraph aligned (2024-04-20
> 10:15:03 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20447
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--XdsDHSAUOisLGfjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYka5YACgkQFHw5/5Y0
tywDYwv/en+IxyhDY5jtrrviXgXlZjN4Sgb9QBa05O6qoLPEUSzqhzoBEz0trqDN
6Hm2bmO9Iaiv30HqO1SBVYaaGhe4RRczk+g0CQ2l0JdITmQp7mjdd/t+eECEtHpt
alG1Dun8nw4iKbo/uNoNnDVagiYy1QITyh15uJMi/OFAN6mPl6DbpB8UOHPKaH8h
V4/YlUyChcDzAbEZeTN2KVQbAUa6BpypjTkZdKhsNXmb6PJ9ualMgVdafLhFsHcO
TSvyaXC3gDiW0rrVokfEq13ydXFC6YF/UoL5WkcQBktt7iGI6byv1F7NcrZnOs/D
GK75kccfnTfYjztNS7Ens5N98mWKsN+ZbZMNrbEgBnKDb610cyUvksdiGX19cLkw
1+0AMG8RLRcX6COR7trmaKVqI+o4WqPpGGFi4Xcxyyb3mkNIS+25TKVwz0twxced
Xn/9r8l5Cff8Tn63MOfmMf3vQkGnbBUdFPwouzIW2P5B1a21jXWFsjD/vpkyImKd
cweA8rQm
=qbFo
-----END PGP SIGNATURE-----

--XdsDHSAUOisLGfjI--
