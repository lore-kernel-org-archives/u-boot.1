Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0869C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D00E80243;
	Mon,  3 Feb 2025 21:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gno+hIyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074A280243; Mon,  3 Feb 2025 21:10:02 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE02C80079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46788c32a69so63011001cf.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613399; x=1739218199; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n/evLLNgW4uRWYa0EQGc3o1TEZMRXvHN/lvHcQvSW2w=;
 b=gno+hIyFqaSFisMCzR8W7Gob8vaidCAdyWjp9H7usFbFhZFfYaJmVlcBZCbhnjOLi1
 7V0lmfMS2kKnJNnVvHsGvIwdAJVUQh+9QDxOhYDjbbm4e95pSpbaJ19iFYxS5yCndiJq
 xb1tpDgu+Gf+NH2bZldioK82K77ECqX+CmDu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613399; x=1739218199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/evLLNgW4uRWYa0EQGc3o1TEZMRXvHN/lvHcQvSW2w=;
 b=DkwH8J67igtM/Qda73XqTXQYD4N/nJjXhvW5UT7LNv0vZEVUypQKBt0ArF3Zlcd9vJ
 f/7PpOcGYrTKrWHEZw11o1QjjPXx76K5MxZUvTGJSrsZRDFW7KC6ASR4ObHmfq1I53C7
 glJDcVx8cIQ2kCaECBscm7dOxRwoiz9C5Q9EG/wfVJr8HNDHGufpHBTZ0sJZn1M392W6
 HQGq2VYl74cO7gEUML1nKCde6WHjDRvIlmhmJVMPW0HctySuQeEmrRgmQwS+4Echsm/A
 84kM8pNAofRYltHlgdTYgB9Dc+yBkfeaf7E6wn4jVKt/EZ7mcOSLa4bSKaAHsLCXqnVh
 eNaA==
X-Gm-Message-State: AOJu0Yx4OvwrMQqnINv2BsOSVCDAyU9megXKSPCEOWmqmVcTg+myyWu+
 nTjlhRyy3oCc6tEB2NBD1c+kvddHcC3HKJvsrmEjvdSoj4f1QhdzlgshTJqY0jTJzxHncZ/Ajhl
 u
X-Gm-Gg: ASbGnct9W3EItqTBT7wxzcXZBCddebkRsQ71vbfK+fXtEem6pfSIBv7G6kmypvfM4/S
 zWUcUDqEoa1oP5SQ5Q2Pk9inIEZaZzen08O4hOE6m1Izf/YWdJOFIHEPpw4oTDPgb+gpjs7XL60
 4qg5Ro+mCH0QMdU+EG4ix+63sjqinKByb4tQb1V8m8PB7WsSCiP6fYYV9ZEDrVLZ0u7iLTI1xQP
 r0kjdxRFP2H8/3fFaZnMl5WqeSBQIJBZVgUtFRAIvobyFq7shtNmN7DTxefUX2BBzEyz327ZeC8
 LzV/0gR5YTWnFdI=
X-Google-Smtp-Source: AGHT+IGaidfVkIAUyvEfvB5Aby2D/Fw+YcaQDVglYKOWoaLRove1YdYlpZKNup1qSm0A8zvYrY+t/Q==
X-Received: by 2002:a05:622a:181a:b0:466:954e:a89f with SMTP id
 d75a77b69052e-46fd0aa275dmr378525901cf.14.1738613398671; 
 Mon, 03 Feb 2025 12:09:58 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0a74dcsm52033251cf.3.2025.02.03.12.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:09:57 -0800 (PST)
Date: Mon, 3 Feb 2025 14:09:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 24/32] efi: arm: Drop startup code from the app
Message-ID: <20250203200954.GN1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-25-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DCy04I10fm8oWuL5"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-25-sjg@chromium.org>
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


--DCy04I10fm8oWuL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:17AM -0700, Simon Glass wrote:

> The EFI app uses different startup and relocation code and the existing
> code uses symbols not present in the app. Drop it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DCy04I10fm8oWuL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIpIACgkQFHw5/5Y0
tywkVAwAsYsRXA82bn1XPO35my7XcwWfJ1uhCqeNd/l75dQ2qktJnrb8VT8khiws
UpuMt4fOVqcNhXLcMpCRrQcz01uJc2GV6n/ttRKUavBcWVtH0HfxuhQeHvaXEiID
DD7bXiuSsUseFZ8aQHAk+e/aajiYCEGqDzswpokp14aV/3FxcjGK4wNa70e77Lla
fW1RWgfq21rB+FVi+Fql/Fee0vpvzZZ3kwAufwgKCwn6RpXIbApKH1Gm8trrE5lh
KqEuqiSyyFH8n+Xbsa/+VIv6d84Kxj7zLtsbph5zscV0hfiCSRxu7CZE4gTx2NfC
U3nX4Ul0iV+wEyOCUvV24xnRgs76/lxVZzX4fpjV+yJs41MV1Gt3LvSpW2lYrtGO
3zAKdCzClO49ZitZ1GZo/XsE/Tz2Osw2Z+6u0sKXu0iv4/nq6Czfx9CkHL24d+RH
xtuEdkFjju7KgLGdkpF0iW1IM9zc8Kf7JKm//fhKBQe7vcRnDp4hybYAZj4WsaP+
R1JMctwb
=dqAg
-----END PGP SIGNATURE-----

--DCy04I10fm8oWuL5--
