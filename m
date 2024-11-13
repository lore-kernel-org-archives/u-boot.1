Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C14D597C8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 02:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DE088E3F;
	Wed, 13 Nov 2024 03:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VYUcbxaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82792894C9; Wed, 13 Nov 2024 03:40:36 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591B288CF1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 03:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460d1145cd8so48165601cf.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 18:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731465633; x=1732070433; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TW8KFaAjA/sx3sGXA7scqqO68RTTP3QlHMRWTbU4pC0=;
 b=VYUcbxaTrDgfe2zlNz7+yrByxlST7CwCO2C170cC6KirwVX+kQqQDyURB6qezFcIkW
 NFUmYWm/qme0CmUAGFHhg5VPrz7yYFmaFziw6TGwnDgJ01K4GqURe2lzAjiutwLrY0t9
 ndsCaAbaY58WfYJSd8vF1BRJuMjKBcGDLeX00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731465633; x=1732070433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW8KFaAjA/sx3sGXA7scqqO68RTTP3QlHMRWTbU4pC0=;
 b=k0WcTt53+g7YKyjVjQ/f1zgSd7g0/CP3frUGQMUSwbJyTvEkollDgc0ZL1w9Ev6rX4
 heUgkw+JUYa6TB1OJ5CqW8cxxy4cTwiFFGONwU6OahZlOnEpiewWULCxpa3msUgW4/yf
 DfIS4nu44b+KFEknTfMvlJaoFgJcrtQWX4Kn/6Rq2PUP8zhGNFxTAK3kc/keYa3CqpO5
 XIzyeuNOKJtHHb9k87D8/QpfHdpMnCWLdJUhcrwOyzVZ7pPidNpCM9g6JOt/p660g6fL
 E6eBc5jGHbeFDiovctziKh3tMHMQWNTKj4uaxWYYI7fIkbe1bGjniBHL8M8gRfFlBPcy
 2rkw==
X-Gm-Message-State: AOJu0YzcxFIvsmzqtR+qSZEgOn1g4kpO6OwWdk6HOYI8cAJKBGRaizZH
 UH4fp/qf3k/kG/Vt307hjxGmir/1Lz9pgS9tOMSwhplqoxbdnkh1fkF7qTO4Lbw=
X-Google-Smtp-Source: AGHT+IGoWb4UoQRP7FaDNmDQnIDX1kXRd597zoPQpPtSjeeUOylcIEkBdVCpFzideUORgjKd2l8RFg==
X-Received: by 2002:ac8:590f:0:b0:460:93b6:a4d1 with SMTP id
 d75a77b69052e-46309388200mr300893341cf.31.1731465633220; 
 Tue, 12 Nov 2024 18:40:33 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff47c162sm82829081cf.53.2024.11.12.18.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 18:40:32 -0800 (PST)
Date: Tue, 12 Nov 2024 20:40:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 8/9] buildman: Propose a format for extra boards
Message-ID: <20241113024029.GH3600562@bill-the-cat>
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SckQUPlNYCKr2fF1"
Content-Disposition: inline
In-Reply-To: <20241108152350.3686274-9-sjg@chromium.org>
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


--SckQUPlNYCKr2fF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 08:23:49AM -0700, Simon Glass wrote:

> It has become more common to use config fragments to extend or adjust
> the functionality of boards in U-Boot.
>=20
> Propose a format for how to deal with this. It is not implemented as
> yet.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I think that the first problem is that this patch series is an
inappropriate method and place to start the discussion.

I also think this gets things backwards as the common case is "make",
not "buildman". We need more defconfig's that are just base +
fragment(s) if they're important enough to be a combination that needs
to be tested and work. A board is not a time-expensive part of CI. A
pytest run is, a new job itself is.

--=20
Tom

--SckQUPlNYCKr2fF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0EZEACgkQFHw5/5Y0
tyzAlQv/dxm917U0jl1dmUgQbWgJblLW4+DflHwvAlVkiFdjPCokiEaEUo5vSjsW
p2ARPhfDsWvld137mgQgnwLyhTCb0kcbdLgCkKNtfvgWUGnoTGGeFBx8iMC7tksP
MTSeTCScL2OcZlm+WOfgFHIXvHG7eL9xeTO2iAhUMkWlmNn26M13ZyTBHtXPGI8m
vBg1khCzRrc5fQEFdqQ5IBUTlU4GkIpSm2TTpvHOxA2a7kmyJk0LyRXkx+dI2CG2
tjfLJpGvDG+5Ixw8NjXAQVfWmH8l1hc1Hz5Zh04dU6rYfHg/IvQeFy5hpqTR1c3d
1Laba7vCKzjbGKWwo+Jz7TfP4rxuWCwzZ5KAxMt5eIz0QrONGzwOgLmIU/TKpR7Q
9SCVZfcEgVlHfxu7ZK8wHz92HMcQVMFzSO7YZPsfZ5qbTF76qrVh2KxMtI9zK+qp
8VspJZao6QA0bS3pk+6uOPijVJUvsetmCYhpzsWGdo4rH5TcxlnUKHt+VXoWGKrY
1ytqDJaO
=GEHD
-----END PGP SIGNATURE-----

--SckQUPlNYCKr2fF1--
