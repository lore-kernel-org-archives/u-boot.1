Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9469DC4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B91187A88;
	Tue, 31 Oct 2023 18:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eFKyyCl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF1C87A88; Tue, 31 Oct 2023 18:45:54 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EAC87A5E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66fbcaf03c6so29505176d6.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774351; x=1699379151; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iWLo65o4JVnjBF9q1jLKha9tcjN/09kEiLPRs89wDHM=;
 b=eFKyyCl8W3873xE87gw2SeZlMGgJoZd31P901tLhNvsQWfKqvlbgkZdJR0d8KI5ska
 V37amXDvt5W5i0ai5lFwOOKNMMAXPkPTBYd0I6gZySzkwUnAlre8mQ7Qq5/XiTmfVOLG
 i1SNOkBlysXZbtT2n8G4hR2H+T+ve75PHlj/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774351; x=1699379151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWLo65o4JVnjBF9q1jLKha9tcjN/09kEiLPRs89wDHM=;
 b=jYgE/bPx8K/XHI0y2xEfnQlil0EF+2yvwxnyto/4W14w7inHYSOgW4qVM5jVwNMbyM
 HmMvc+J/HoBuv13VoAOaip5ZBx3vpBPEdPFLmZWHt5I0qjWmgzugPgczlZlmooIH9xTU
 WWSv77rFh4rmW6XPfiycuT0gDXVra00DZPhvJCqmVNjt1AaxnpN8iS3NZSS/rg9lJ2Xh
 pQL+zO5IU6ROh40vCIOK55Ao9TWyPxSOfDketIV2w1hAsMhuAcY04cqHEzu4AT5BcGDm
 zu0QWGoJk/21dG8ey37QpA9eahK4LL6Ji+tXr5WHfrvs4BHNBa5GWQtVWwhWf1kfZQ8F
 oIbg==
X-Gm-Message-State: AOJu0YxyEF8uDKtRf95cGACi3o9uJ4us/yFAbW1s9ZQMmot6E3LfEd6z
 Kv1Tm+T+r6C+uflH3O0mZBR8XQ==
X-Google-Smtp-Source: AGHT+IERZQjDbJ4tFtPmO5mvv4aMqXSObjwDa8VnMc6eg59VISOuWlI6Rm9KBatBWSzl7nsYgBlN3Q==
X-Received: by 2002:a05:6214:21ca:b0:65b:765:254 with SMTP id
 d10-20020a05621421ca00b0065b07650254mr16152662qvh.4.1698774350917; 
 Tue, 31 Oct 2023 10:45:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 w10-20020a0cef8a000000b0066d0621bb67sm711032qvr.114.2023.10.31.10.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:45:50 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:45:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 3/4] board: nuvuton: arbel: Fix incorrect ram size
Message-ID: <20231031174548.GQ496310@bill-the-cat>
References: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
 <20231023070225.3142578-4-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SPwnlZgZbLwS6E1Z"
Content-Disposition: inline
In-Reply-To: <20231023070225.3142578-4-JJLIU0@nuvoton.com>
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


--SPwnlZgZbLwS6E1Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 03:02:24PM +0800, Jim Liu wrote:

> 1. Fix incorrect ram size of 4GB dram with ECC enabled
> 2. Fix wrong place to set dram bank size
>    - The dram bank size should be set in dram_init_banksize
>    - Dram_init should not access gd->bd because the board info
>      struct is not reserved yet.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
>=20
> Changes for v2:
>    - add commit message
> Changes for v3:
>    - no change
> Changes for v4:
>    - Add Fix wrong place to set dram bank size

Applied to u-boot/master, thanks!

--=20
Tom

--SPwnlZgZbLwS6E1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPUwACgkQFHw5/5Y0
tyzAOgwAo1awAtdNSepvq2qgksFpT456W+kCuSxRhsMe+LFMMNRLgxENqSZCm3lT
DrkpZ48PfQ6WgPQmDVAEAwOrhY7A8MU4p1qtOB7mJK4U1G46znsegmMIsuKXyAN1
Q5fHcKfi5r7a5tVVBG5AZxL3eIJbpCCCLsUi5rYxGesOxXCLUJVSGRkFaNZ/5aqe
wNv0dXA8Pn3pJhl0qNQe34vUo3RsL4Bgu4DFUqKrgHaMgvpUw+vyD9bvOCOPmR4w
fpmVWdo/LHTwEjdY3xR008LCgnQwpfcFoefaIetM9+x660HtdzfSbS+WRni4ZU9r
4jAaLYvV4/J1kUERjXcNcEZCxoztnoGsaOWtkGVsWHKRjmCr0+pLGo7ToqXhtTnD
vRSYkF0Op8GYOzjv1Qp/TDJgW2Tr3rc7+u6A78SQzWYqHhrKHugv+aOwZK4QMj9Q
hEEdWf3jH2NILg1HCwnKxSibZRZuTPvFjriIH/RtvekrPZlygtnMJuPRcBxime0o
wfg2B6rq
=G03U
-----END PGP SIGNATURE-----

--SPwnlZgZbLwS6E1Z--
