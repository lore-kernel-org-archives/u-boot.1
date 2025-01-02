Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA68CE77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 14:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C540A8007D;
	Thu,  2 Jan 2025 15:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F3l6mK0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961E880196; Thu,  2 Jan 2025 15:45:09 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 196128001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 15:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6eeff1fdfso882242185a.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 06:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735829106; x=1736433906; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=thQcQfPIbf6mR9azBin5PFWvRMhYUlxJZhVPc+Hn8wI=;
 b=F3l6mK0l70Wf6EeCoLXNdfI1zmfRQPLwjfoqU7hEdeCgzk2rUEiqNiPyN1oVatpveQ
 El3WW1uXE1FqU3w2PELXDN3FiBRs0cmq3M7X8wRjbyTJmxiqzgZfmtyuV9x9IKWp6ibl
 T91OjbpF7FAfio4EvTWQxkasijzo5iJWCjvLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735829106; x=1736433906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thQcQfPIbf6mR9azBin5PFWvRMhYUlxJZhVPc+Hn8wI=;
 b=s51l0vgbjYtB9gUAcysW63FhrpH1YhrvmiqbDlhV0CGHYUZTjJw/e4RM9XikZzy2ds
 QFU3GcjX99qBrgWAmiYK4T2MC+ekpnQokpCJyshQzvnGXOkyyccn93jdVSYV7/14mDsW
 Uw288rOBGifBhuUhBgotty9llnWdhte779iCw/XTEvZmSeaydPNS/6y2nY58Md9YjW73
 yj9WAYs8WIijggIXyaILBoe4B/D/yYjxSs88BuraNRA+WstIQbvRyzUGoXKT9dUl59Fk
 +4BnWuabn8GKZ4m10EBAPD0MmT2aVsbvGt5SarS63gc6JRQi380G0Kz4FbmJZvTwP467
 gABQ==
X-Gm-Message-State: AOJu0YyY6iZY1Ed27eOAfPPV7Nb70h944siL/Uv7EoVSzAai2drhN++e
 +dI0Uwm32ZilKxaXeOfJMs7u0kRdTriju8Kk4Z7n3XHKT2dvLXsQAO6EplTnfr4=
X-Gm-Gg: ASbGncvKTNELme+KnKwRG9Ek5CHKKlkJ/QZ1Jotnacukay5sCy8ISXjkdFPWdAaI22D
 gs6lsgGlbIWZVYTKfNgD0fWVewAVYK/j7hDRyJeKmRrs3t81jXEfzSM7go1DfPrnysw9zzskKeH
 K9E/Eq1AheUf8TT3dLTnedErwmHccjyeewBfGHwaQepjOjA29/RC0cAZBmGEZCttzjGSphGjsio
 PG9Ebz8Ch9RnXDueV8PlNagkvfghN/FbAJV4evkDFxVszlmoqfoVROxKw==
X-Google-Smtp-Source: AGHT+IF3ZjYepx/vE5T2jMTX4jAnfVl5v32yyu5g3pn3sRmVHXZbbm/TVx+g6tKCstjCsPur0TWc7g==
X-Received: by 2002:a05:620a:2804:b0:7b3:577b:6d9c with SMTP id
 af79cd13be357-7b9ba7eab3bmr7681346785a.38.1735829105902; 
 Thu, 02 Jan 2025 06:45:05 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb1788fsm137140351cf.54.2025.01.02.06.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 06:45:05 -0800 (PST)
Date: Thu, 2 Jan 2025 08:45:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] bloblist: Drop BSD license
Message-ID: <20250102144502.GM3476@bill-the-cat>
References: <20250101195817.995321-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XFdXx4vuM0b4y31I"
Content-Disposition: inline
In-Reply-To: <20250101195817.995321-1-sjg@chromium.org>
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


--XFdXx4vuM0b4y31I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 08:58:15AM +1300, Simon Glass wrote:

> Linaro has decided to write their own version of bloblist from scratch,
> so there is no point in having a non-GPL license on this file. Change
> it, to better fit with the U-Boot project.

Nit: I'd prefer to word this more neutrally, "TF-A has created a BSD-3
licensed version of bloblist support, so there is no point...".

> Signed-off-by: Simon Glass <sjg@chromium.org>
> Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215

But, once we get everyone else that touched it since commit 6c9e3d1fc085
("bloblist: Relicense to allow BSD-3-Clause") I'm fine with it.

Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XFdXx4vuM0b4y31I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd2pm4ACgkQFHw5/5Y0
tyze8AwAtjYRllGESBKO9LEZtgY9nsRRe0lRiphTpOnWvx/wgmN144kndzvGlJq5
bbLmjp+xbvqnIRxju6cYOZgbZ7ZUF5rwT9LyYVwFjdnxaY79hPEcKj6vpd5glm+p
aN47/DQXA4y8nHNOYwX69uXIbE1Xle9PgL475tl76kXXOJoDjXXP/oYDpNu2AczR
h05ktUmrP97lPi7ktbhzxOg2Y9+4TJPc4zDf+DdZrs690hWNDsIyYVz5Suo8TuRM
/oTgEEBu/WIb+d2UxqYCUYdC9KQrVZ8jm1dBPLa7G+b5HiX7L63r+6Zs0MpzV6NW
GwLYItdRmRVtMd2osLAvPPSsfUFBio4lchxfvTl5AJxC98/I9MMf/n6U0sWWRujl
7yDfxXeG9AA3qXX9UP5H6Ige2CKw4gkgwWNpAangCOhk0QyUxpMc8IbWUa7uNJV0
3IIgibJXttSfbhB/657EDZAt6s1R0hCS+CrxAdBD41snrtQMoMWAadZhtWgbIoMd
fMe+yuTi
=aMO+
-----END PGP SIGNATURE-----

--XFdXx4vuM0b4y31I--
