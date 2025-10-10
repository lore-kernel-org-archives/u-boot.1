Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E579CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6776983F7B;
	Fri, 10 Oct 2025 16:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LAddjThp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA99D84286; Fri, 10 Oct 2025 16:18:15 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB1D83F4D
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7afbcf24c83so615343a34.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760105892; x=1760710692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cWJ+BcltGcg4W9fy59YrBBqc76vXxh3d4ma93/khjDs=;
 b=LAddjThp54m2xKcWnQCzf2Fv+gFYwZTwJeQNfB4zYfyryeODQpYKNvO0XarjTonNPh
 dM22xGQBsh83vIk6gfnNf1HmTo5IQxCjOuNHz7dbz7BsVlHIllAagmlMGKc4PogoaAxS
 CgGF51bQLxS5OEe/DQDTfKAizmlgjiEp2tK50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760105892; x=1760710692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWJ+BcltGcg4W9fy59YrBBqc76vXxh3d4ma93/khjDs=;
 b=YXb4oAHFmlgpCkLHBKo2gmldXYYCORGLgnL6T4HR9V1aM5vQdUonGew4HxoUBH8DJL
 RTHoHmuIp3bnWOVDnTOCvd+29TCqCQLhNMwkNYLndUTpIBuMVjuYWO45Q3GsSwKIxZT/
 pK42k9X3NkxsjhE4GYl0PpDNw6xv+wXTVb0fkpZnXKO08JkWxqHSsnnZaekedQtATZ+J
 tT2M0VD9hHlMy5K2VpvzoH7xgdC3mCbLfcgsfU34cmXWin/6+YJIRkLxdIrvL0lsYCbU
 c5nd50fH0QfMK++O+iTJs732SIWgpVh4gP5Pv1JwoKeNIu1uvT1lxmfb/4hEEPxHhN9N
 MvRA==
X-Gm-Message-State: AOJu0YxbPzn0UEJeQHqnMziP7s9Acko51sngvN3zFLD5l7guKt8PyJ9v
 KzE061U78O7UEfwqCLIOAMWNdsEVWYfFBhDTNaY0xiTub4MVkBTwDSWGsMJ/wHROgks=
X-Gm-Gg: ASbGncvQwLltaVup3AJ0N0SkEh8q1xqQDq7tR/b5shuHsvc4zAI8d7ieRVAFmsY+38/
 EDWncLrbJIYpvwj22v+BHw8ncSPxPRWBD2PDnJw+H1ZDhFyX6yPMtgR3vdwoWQh2BOELjW6MRdd
 BcdO1FchlmTbPiNaZm3FooIDqFblGZByCSgO+Gp5GglkCVBLa886F4OB8+Ht9k0ON+tKTv/PgEs
 dvaDArFCNDA6RFqM9V70006ZO8dJmhf8Qs1JMIpUduAKzhU6mJtHekxGZqaEyDgkU55futEdq3+
 aQDp1S7oNIXA1u5Ejo7LaNyjskWnpEFi5Bqu0EfVVm9iMBZSTy6WWsHREEj6pnRSM+1aoQLQh4l
 TNl21ahxNHVnKx2lNrIP1AZG4dWoxUbFDCn174V38CdZjzOyRy1/li1PMdXbkEeW9IRgyqwKf/U
 DnVp9D
X-Google-Smtp-Source: AGHT+IEmfQIhNrzoPG9UCLfoXqrb8emWOZMqvZS6SUcuGW6JNQvtiCo17ZH1fW2/tqfZA/e6lN58mA==
X-Received: by 2002:a05:6830:8388:b0:7af:a0ac:d56 with SMTP id
 46e09a7af769-7c0df79b17cmr6105968a34.22.1760105892413; 
 Fri, 10 Oct 2025 07:18:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f9067d80sm865870a34.11.2025.10.10.07.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:18:11 -0700 (PDT)
Date: Fri, 10 Oct 2025 08:18:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH RFH DO NOT APPLY] test/py: Update to pytest 8.0.2
Message-ID: <20251010141809.GX298503@bill-the-cat>
References: <20251010134330.1094378-1-trini@konsulko.com>
 <20251010134410.1094470-1-trini@konsulko.com>
 <d407b3a6-3945-416f-95fa-160da63ca8fb@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ntdbpe9GkLUk6jn"
Content-Disposition: inline
In-Reply-To: <d407b3a6-3945-416f-95fa-160da63ca8fb@gmx.de>
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


--9ntdbpe9GkLUk6jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 03:47:14PM +0200, Heinrich Schuchardt wrote:
> On 10/10/25 15:44, Tom Rini wrote:
> > This is not intended to apply directly as currently it leads to the
> > sandbox.py (and sandbox build with clang) tests failing as the efi
> > selftest now has 4 failures when before it had zero.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Why wouldn't we try to move to the current release 8.4.2?

My first move was to 8.4.2, which had this failure. I jumped back to
7.4.5 which doesn't (so that we can move forward with newer labgrid
support). I then started slowly incrementing to see when the failure was
introduced (as it can be helpful to look at the upstream changelogs to
have an idea why our tests now fail) and luckily it seems to be in the
8.0.x range.

--=20
Tom

--9ntdbpe9GkLUk6jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOkVnQAKCRAr4qD1Cr/k
Ci8wAQD9EyNaLa7DZvPq7NtGNC2cS81S249sZZnHQ0/KPN632wEA7X7UVMXPoJ6n
Lx64tgDlg15+iI7GPvgqLSjB7U50/g0=
=pw/t
-----END PGP SIGNATURE-----

--9ntdbpe9GkLUk6jn--
