Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395A9C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1826A8749B;
	Wed, 15 Nov 2023 23:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J4kAZNLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E6DB8749C; Wed, 15 Nov 2023 23:38:18 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EC78704F
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a81ab75f21so1455897b3.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087895; x=1700692695; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7xJgXwSAioo2iLQvApP93a2CeJePiOKR2mkmOcckWbc=;
 b=J4kAZNLng6PiIwJ1tKs/ynpIjOHZuvNgkxoZuJKpI9lg0+YFK87Y16SUM19EvLC3YK
 U9IpFBsMEEKMAlIFfW0zpvRJoxlOJUEYoMyLA1Qs1X72t1uurl/dnN1+MSN0Txyyd2Wb
 PciC/N5uJh/My7iOg7nuDhdeDEVVSL4SPRS/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087895; x=1700692695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xJgXwSAioo2iLQvApP93a2CeJePiOKR2mkmOcckWbc=;
 b=w30T8GeqqGHzlGkM08nq8z8EHfVuqzbYAqa1W9d/D/W8GiUUfYNeu4APchf/AEuRJe
 7udd2wfSYREX3A2GFcnfoCzHrFXfi+gdbw0ERoomB5fVHltdK7bHuQSFLnRFDCQ2GVn8
 fH8J7+V0A3ioBufypPnwGYUCBhV/6nmKQ04m+m8BI9N8FjqSmzABEY5xVcwjiWpwSAF8
 8fIwbhWq+18/CDHii8nKc5IyufwcFNvuWIsztKDVdLXTJor1qvxSas0ZgMK3RsFcqbgv
 QtlAT7m6r3RRfJBqf6gb/3Q5wsInFAV9nYTYckS2h7y9blva0lcLy6XTvsA3v8GfTa4m
 k+hw==
X-Gm-Message-State: AOJu0YxZNqaLc7MInlJ6bf47WplS6cNfW5HrDoUtl4JHE/yATw0p9qBg
 8GXk3bXY6aHpnCYZd3E9aLO3/ppVmyhoxvSOzyN2Ww==
X-Google-Smtp-Source: AGHT+IEzSqeZhr62jaWMFtNthSs8kxuuQeeuqe5zTSshAx1Y3RrtLiaWOAZqSXhVEEWYUOVXnhP4wg==
X-Received: by 2002:a0d:cb55:0:b0:5a7:be23:6a7c with SMTP id
 n82-20020a0dcb55000000b005a7be236a7cmr16523810ywd.6.1700087895204; 
 Wed, 15 Nov 2023 14:38:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 pp6-20020a056214138600b0067095b0c473sm886887qvb.11.2023.11.15.14.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:38:14 -0800 (PST)
Date: Wed, 15 Nov 2023 17:38:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 29/29] bootm: Reduce arguments to bootm_find_other()
Message-ID: <20231115223812.GG6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-30-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TrwXSPI9YEoDt1S0"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-30-sjg@chromium.org>
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


--TrwXSPI9YEoDt1S0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:14PM -0700, Simon Glass wrote:

> Rather than passing the full list of command arguments, pass only those
> which are needed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TrwXSPI9YEoDt1S0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSFQACgkQFHw5/5Y0
tyxutgwAqbWhdOT9P3l6EqwoDG0HRGrcGoK29qVFxS0pgsm1zOGX0HlpkHqR+K7g
Exx0Q/CeUBZQ3zQXzfkBXWrdqxgEy25XnrxbP6CUZJWAuxYBokv8+k9BedPMQpYh
0kUBqL7ddtnl2fcG1MO+utAFtonXHeyzevM7SW+/qohUFUM5vl6w09oLNaS23tye
K513YhLgwP/d4cTjbthXaaotjxqwWO8eMk+REzp3/J4VQXjjf4mqr+QWEuCYtg6z
b72JM3x+So5cGi//17XJ3CsGQZTk+e8LrWw9lY9n68yVbUoY52+0lihNV2jhggw9
30r92PRicd+z+oNh+D+pYOpLUViQW8SN1NCAte4wD0VinxMFANdjB8xz5kOhLLsd
y673kLptPnZ8Ln8k4qEGzIOxZrV63yuvCC3Pgq/4yT6y46e1rRCVdEtXC9aGCBIM
WmO8JdW4YQrNdBjXITO/IXYOFEyHttjfiD2tk+G13QTOIatU+ZrpIGot5/Adwv5g
9dJ0H3FT
=2nEA
-----END PGP SIGNATURE-----

--TrwXSPI9YEoDt1S0--
