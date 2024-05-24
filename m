Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC7BC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 15:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8A28882C;
	Fri, 24 May 2024 17:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ztij80qG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D4B88859; Fri, 24 May 2024 17:06:08 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D98CD886E3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 17:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-43fb387d9d0so3594291cf.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716563165; x=1717167965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hkYmf3SMW8Po9SkcOqmv4JGMLoA9PfxmYj7T2qMxryE=;
 b=Ztij80qGk5MwmSWBbHf42RdaruPtFNT5V/cd487xzJmIDjO5VWQZaEBvfMyiuCzuYP
 gdD7pSa4MkJz8r+0svBL8uHVI5RsjLZp/RPjP/lEyKkYTN2eYFUTJJiIoHexWUQlxchx
 Q4WIUAEnV3IDRNTv5nT4/C+yxNpAue0I11WlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716563165; x=1717167965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkYmf3SMW8Po9SkcOqmv4JGMLoA9PfxmYj7T2qMxryE=;
 b=FX6rl5heTHmWDLU2swlUjar7n+mCWJ8zrjAw+PTVtAUxqkpAaHkoxilt8gD8jWFBTn
 VbIVSV6F7T7EwuRiA6CNAc0f2iOKwOIXWKQ5u9ShKzcZfucl9H2xqCWbUoJyYgrqbyFf
 WhcHecAw1mY1J/31RiUbdkUca3z5Ktw3SCUyb76V4c1MlmpFc9azm3cxu08rL9JiEsvz
 MWJV3QMZ8d1dSrKTx0GzNzwqcKwlzqgIg1DQE5/uFJyEPCQe8XyKg9Op3Rupz8SlPrXL
 8s9st/PjKXZizPpfFdnSTEcN+sekPM7bchxjX9qv7LpwqcySo7OarGNy8hUEnwGTqY+g
 qe/A==
X-Gm-Message-State: AOJu0Ywli25W2b/R77ccphRQNGHNYMN0wBdOdK/M0TzvDs9iLnuJQ6ni
 oN4z1CKfyNgQ5Utj0zbXGoXloB5HHTJDlCMbzKMrJvMrOsKpzuOd/ds02fUMOiw=
X-Google-Smtp-Source: AGHT+IFAcxuNS6u+TtvbeX5vIkgxSweETHunlec6VDgOCQcf0pr5/4spxyEisaPBOjcqwjJEBz1F8w==
X-Received: by 2002:a05:6214:568b:b0:6ab:926c:75ef with SMTP id
 6a1803df08f44-6abcc9e6c3fmr20583976d6.29.1716563164219; 
 Fri, 24 May 2024 08:06:04 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad5e5dac1bsm4240846d6.3.2024.05.24.08.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 08:06:03 -0700 (PDT)
Date: Fri, 24 May 2024 09:06:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH 02/15] net-lwip: import lwIP library under lib/lwip
Message-ID: <20240524150600.GY2568172@bill-the-cat>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <3b93c2b7f753633fb27864a2667d022848b2ff28.1716393035.git.jerome.forissier@linaro.org>
 <20240523150239.GN2568172@bill-the-cat>
 <60c3fcd8-0944-4fd3-8a28-eba6728438b8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xi0oj1b5L9muhsSD"
Content-Disposition: inline
In-Reply-To: <60c3fcd8-0944-4fd3-8a28-eba6728438b8@linaro.org>
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


--xi0oj1b5L9muhsSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 04:55:15PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 5/23/24 17:02, Tom Rini wrote:
> > On Wed, May 22, 2024 at 06:00:02PM +0200, Jerome Forissier wrote:
> >=20
> >> Import the Lightweight IP (lwIP) library as lib/lwip. The code is built
> >> when CONFIG_NET_LWIP=3Dy.
> >>
> >> The lwIP code was imported with the following commands:
> >>
> >>  (cd /tmp && git clone https://git.savannah.gnu.org/git/lwip.git -b ST=
ABLE-2_2_0_RELEASE)
> >>  mkdir -p lib/lwip
> >>  cp -R /tmp/lwip/src/{api,core,include} lib/lwip/
> >>  mkdir -p lib/lwip/netif && cp /tmp/lwip/src/netif/ethernet.c lib/lwip=
/netif/
> >>  mkdir -p lib/lwip/apps/tftp && cp /tmp/lwip/src/apps/tftp/tftp.c lib/=
lwip/apps/tftp/
> >>  mkdir -p lib/lwip/apps/http && cp /tmp/lwip/src/apps/http/http_client=
=2Ec lib/lwip/apps/http/
> >>
> >> The list of object files added to lib/liwip/Makefile was given by:
> >>
> >>  (cd lib/lwip && find . -name \*.c | sort | sed 's@\./@\t@' | sed 's/\=
=2Ec$/.o \\/') >>lib/liwip/Makefile
> >>
> >> These files are adaptation layers written specially for U-Boot:
> >>
> >>   lib/lwip/u-boot/arch/cc.h
> >>   lib/lwip/u-boot/arch/sys_arch.h (empty)
> >>   lib/lwip/u-boot/limits.h (empty)
> >>   lib/lwip/u-boot/lwipopts.h
> >>
> >> They were initially contributed by Maxim in a previous RFC patch serie=
s.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
> >> Cc: Maxim Uvarov <muvarov@gmail.com>
> >=20
> > As I believe I've said before, this needs to be a subtree moving
> > forward.
> >=20
>=20
> Done in upcoming v2. TBH I don't quite like it because (1) it introduces =
a merge
> commit, (2) interactive rebase becomes difficult (I had to pass --rebase-=
merges
> or the rebase will fail), and (3) I found no way to record the command I
> used in the patch description. FYI the command was:
>  git subtree add --squash --prefix lib/lwip/lwip \
>     https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE

Thanks. It does make things differently challenging on the initial merge
but there's dts/update-dts-subtree.sh as an example script on how to
make subsequent updates easier. And then in the cover letter we just say
a pre-req is to do the above to get the initial import of the code.

--=20
Tom

--xi0oj1b5L9muhsSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZQrNUACgkQFHw5/5Y0
tyzncQv/eo/viPw88yyHxHZavWTXQw1nZadMsIWOkjRKbAZ84B57coxMfZHF47TQ
XQM+Hoh4LyOI3kcyIQcIpvGZBZEfdc93AXqkytU7Ee8Ti/zlj4W5OpnOXG3ggLlo
DVUFc6k+if5BOcgw5t5dd8Kv5STGPOSTx0uyyx+WmEoOiD9A0/42+qS1NXNal9I9
4qEyPn9eRMtsp8HrvsAoiXax0nBDuv1Rap4sb3TgCphVqLc/ArOqkAwUqkkNqTzz
m9zmUFQarhbQkX4aPyrBqrIqQw41GHjQ4klA5E4Pnut8DZvTv7hXzAlTPu+qMgWL
4/gqjxKJxgZYNKxC2hb3txEgX1BdusRTtyc3I0doXJoXv44JvkrDUDhwwRlcz812
0t/4tWOa/PcRZ7ufXlXWSTKiJZq1UfQ37iWIdRozKuN/eb5VMbYggMFFM/K+Betm
ZQ9jYjJV/GJn/7oUfXgU/LzLnVq3v4qNKnb+ZTySv8/QKvG/2VaG6RkaOvTgKUrw
0DbRd0kq
=4LIm
-----END PGP SIGNATURE-----

--xi0oj1b5L9muhsSD--
