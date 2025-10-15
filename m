Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21312CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 19:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562158357F;
	Wed, 15 Oct 2025 21:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FlB5M80G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2592F835A2; Wed, 15 Oct 2025 21:04:53 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03ED9833F6
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 21:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-646f75551e7so2718707eaf.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760555090; x=1761159890; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FzSufdmNCYTYBYlKy0hVmjBxggxJLCX3QitTTxFPzM4=;
 b=FlB5M80GFwN8uotdmt6rOCeildNn6BNeMlBAl/0cKtsUbcl2m0pXNF2fyPEfKQ4Suq
 bN1Z+8ETuy4qIL5Ep0z1FhdxLx7nKbsSNS6fhBZKEu4/rT6lgo9v7WTnCt63OU/Jz5BZ
 BXZ3OeGiQ8j7fJ5t5qKDj6TPG005fycqbJ9hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760555090; x=1761159890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzSufdmNCYTYBYlKy0hVmjBxggxJLCX3QitTTxFPzM4=;
 b=oc0dQQhPJRAIAe3KhCEGVOOaCpjg0AkV7N3B46fCxyA3Z7ZZc/qGM01myI0YdviBF5
 QLYpGXHzFXTCHJE67aCdGdRhCfVIsHSIlJ8sG80BzMm7KIzClIola25Yj+ayWlQ9Quh6
 S/p7znqX2w2hLLBzfrx1jfR2Sk0oFZAriZjPltr5TDaQ00GtBlf+e7ETMe6a7hKv/4KP
 z+46B6CWlbZOFFTzwtIvVL0OIIZMh57ywxL/5q+bUGXqaJZqOTsroj5/ClQe56wWKWIK
 4hebX996H5FibEdQqMyZ7xl6gFRtPNSyvgPaPOXwxvUTuLWGDiKAkIo3fkpxIp3aKcx1
 8FZA==
X-Gm-Message-State: AOJu0YzeQs9xcDN0dtzZt3mRsRRM286SoR1FE5Fvw4ImW0ohTiRKV7Ex
 77tnXMYLCKm6ygJYADKuiKHKoElDIwdY4VcIXTXhcMUCSZTJjbw8vyuRTCaesahfc9Q=
X-Gm-Gg: ASbGncteC6nWdcN4bB0N/6mVO2MrQ12uFExQKWhrby9hRXLUpurJ8SkG1NfxdykVGTL
 cKR+Uzo89vD08M4/tj2/aOX6zQ9x6/dpuhfJ1OYlbUISIF9HYVhj+FaXpYca/EA3zHhnTufTB/p
 FJUZMiI6OC0ywT4hSOQ31rQZSO7EoOOzBr8AgjlHjoPTfAgV470+CrW5L2FbCQVDwk03lhnIaLf
 h7Uicow2uAEWxOxNb5chAQ/4rF9v9zFR14phl4oALPxV/UDFuIi5QidiKH06xDic4FirrsCbIXQ
 c5oVHTW7mexrYqCcg3WaZ1tAn3Poob+g5LfS2b2ubMZIYwlCderUk2XmPQ7aTI29BQp5bF+oJI0
 fWfyNj7ihDGjdA2KSYHJM8dfofKB4yHXDJqZ8sCy4qIlxNiPWPa9VZlOnjY9GRdAyATr9CBKbpn
 ONehXziaEtqOpf/kY=
X-Google-Smtp-Source: AGHT+IE3qonmSVo2WxZNAlvwP/SAikKWd75HFwNN7X8s/dYKDrzW3O9JjMXKnGiRucOIJI0q7BkFQw==
X-Received: by 2002:a05:6820:1891:b0:650:4ef2:e131 with SMTP id
 006d021491bc7-6504ef2e6admr1681528eaf.3.1760555089623; 
 Wed, 15 Oct 2025 12:04:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-650181577absm4143987eaf.9.2025.10.15.12.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 12:04:48 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:04:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v4 01/11] boot: Try all bootmeths on the final partition
Message-ID: <20251015190446.GS6113@bill-the-cat>
References: <20251015154423.908468-1-sjg@chromium.org>
 <20251015154423.908468-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QIhHfZquqLaoUayO"
Content-Disposition: inline
In-Reply-To: <20251015154423.908468-2-sjg@chromium.org>
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


--QIhHfZquqLaoUayO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 04:44:04PM +0100, Simon Glass wrote:

> At present, normally when one bootmeth fails on a partition, we move on
> and try the next bootmeth. However, this was not the case for the final
> partition due to a bug. Rework the logic so that all partitions are
> treated the same.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v4:
> - Reword the commit message as Tom suggested
>=20
>  boot/bootflow.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

I'm glad you reworded this, but it's frustrating you didn't also post
this stand alone (and presumably sooner) as was requested as it's a
stand alone fix.

--=20
Tom

--QIhHfZquqLaoUayO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO/wSwAKCRAr4qD1Cr/k
CvlRAP9kop83Z55ps4+KyFiaXGUB/agpXX76ynrPp1owVGQJyQEA6ekIhl4uMq9X
RmMxrSw++JUmi+uL+7hL57VGrPu5Cww=
=PR6s
-----END PGP SIGNATURE-----

--QIhHfZquqLaoUayO--
