Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028A3C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 940EA874D6;
	Thu, 16 Nov 2023 16:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NV0dZEmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE64874D6; Thu, 16 Nov 2023 16:44:58 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC6187465
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-66d122e0c85so4788046d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700149469; x=1700754269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=elLojakh5JRjVSobzlUZjptt8IXJCfe1zoe3KG9dnWc=;
 b=NV0dZEmnwFjIa4I5E/n3FLrbPtH9Dhvt8T/9o2tTco6LyrLQxvv8GfAPTdFYFLD9dO
 GoA6NxODdazejnCHE10+u8hASWUC35n/FNjArdkrfV1lB3AaVirq9fnIvFzl3n01A49R
 bJYvsSxjvlPdGvx0ljTT+M2wuHqsh16y7cq2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149469; x=1700754269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elLojakh5JRjVSobzlUZjptt8IXJCfe1zoe3KG9dnWc=;
 b=kv0ydcqPU8rkUY9J7ltZf3OZoWrKM4i0dh92LWszOOpQ9dFQM5tylNNNz0cWlOS5rr
 kahCa+NZz8dIQWkdCTkvet6fzVzx4pqa+Tc6nNnpIjNmh9BMfo2q3BPCycbvNPw7+DPo
 s+VcEtb6xI0XdAWpVzKLC0zN68Vu/qZ7sDieQNEmMsGoywZogxhjreCd5WE0Pvplkk26
 aMFag0KaP7sfBKyLSRJp16Kl9RF8PCSWk4N1Nwh5DpsaBar53lyceIOf85zd9j+2+gXQ
 Km6SUFImfDr0tb2oLrdFDxcrXHDCxqwSfJ0TO3bOMpQrDMGCEiQyK8G/yTR3ZMudPIw1
 X+IQ==
X-Gm-Message-State: AOJu0YwwpnvRpvFq9HCfA/x9SBwFvonYTASjGuKyRXlAspuL+FMWJatb
 7OQlbp1oV3UOn+WoZ1VRizn7Ng==
X-Google-Smtp-Source: AGHT+IG1SnokjL0u1EB5z0rCA8hRhNBvhE9brf6K0xAmbm6BheDyG1Kcbci0DYCMOu2dIkAVk1QbEg==
X-Received: by 2002:a05:6214:5813:b0:66d:5020:ef67 with SMTP id
 mk19-20020a056214581300b0066d5020ef67mr9952353qvb.36.1700149469288; 
 Thu, 16 Nov 2023 07:44:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 e9-20020ad450c9000000b0066cfadfb796sm1440344qvq.107.2023.11.16.07.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:44:28 -0800 (PST)
Date: Thu, 16 Nov 2023 10:44:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 03/32] mmc: env: Unify the U_BOOT_ENV_LOCATION
 conditions
Message-ID: <20231116154426.GP6601@bill-the-cat>
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3FS/sPfbguzP01fo"
Content-Disposition: inline
In-Reply-To: <20231116041043.362055-4-sjg@chromium.org>
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


--3FS/sPfbguzP01fo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:10:03PM -0700, Simon Glass wrote:

> The declaration of U_BOOT_ENV_LOCATION() uses a different #ifdef
> condition from the code it calls. Use the same condition to avoid a
> build warning if CONFIG_CMD_SAVEENV is disabled.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3FS/sPfbguzP01fo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWONoACgkQFHw5/5Y0
tywWxwv/TuRRazv4hSswG60/ZCWgvOfUoygdpY7E2RvXIrkOmkZe+P95p5FBv4Tb
EiP43lpnt3xadJi/QB3qKPesGMlWRrtkR/ksAaYCYOsBV/OdRgjdtKIc6mOWiJSI
taNCPsWlAMiis/3cWRyc61DZ9/LEqAt0R3tv9HIq+U5ZZHJ/msdnH1M/JQ8NJsqw
cWL5be8vTSCFZKzaV5oWwVghhIAIQhRjkHMwxpgV9+W53izMSjHmJ5lG578GGr5t
sL5L+Uhewit2L0mPgHdY3xwtTTaXWbwGh4RhkdxaoUpiA24+i3AbZQX3WnMqemGr
VBQ8qKMSbuMs8nRlqp70jaP00CdSksX9kmxJf047Hk/0hVnM1+nDAFFOjyY0vdBo
ZYkpxmM4M68GfwcZQThJfESOwZwvBwzPeVaScVUEDlj4Oe69BrU3z6G9HWe8BUQ+
oVQMMv8UGCEUv0jeiRsXzNgGrsQpIdInthVhccHctoLENZhaVOX4RoLojsqbzYUH
YvfuXtjM
=Ux/a
-----END PGP SIGNATURE-----

--3FS/sPfbguzP01fo--
