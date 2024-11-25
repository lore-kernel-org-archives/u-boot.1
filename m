Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B54D3B7CC
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 03:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AD2899C0;
	Mon, 25 Nov 2024 04:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nYw5HBka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C54789622; Mon, 25 Nov 2024 04:01:35 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B0D89574
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 04:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4668c8e757dso4497431cf.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 19:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732503691; x=1733108491; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cz1y4aHFaiU47x8fQ42+IMWlyhEYKQVTvrLeW0Af1tk=;
 b=nYw5HBka7dZ2sYoOWaAmG8d+Qq6oyQ58f5TcLKX1tzjWD2T+7ZUUJbQINg/kl5MzJA
 NXbscS8IFYNuFugYLv9ujWqmSBe7slHZYKnWwEWujK47YN0VF+tM4z9HOgFjlNprFumL
 UfBubDE75a4ffTFYgN3jNM9j2G5ughpBI2ZWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732503691; x=1733108491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cz1y4aHFaiU47x8fQ42+IMWlyhEYKQVTvrLeW0Af1tk=;
 b=KmTwgeixX9owRBHe6QuBJTykGmuk74D4dr3sfdCpUZzOng92dKf1AROOC2yi5e4+3n
 b2FLrQvW4kkjidc31c8uAsq9LyA9OMvsXNBqF2u6TfdRjZJVyyuCOWYUxZDjzO0BXUEf
 QI1mJqxMU4F0k2ioqIhYiCeJZZV8Dxq4ILz3uvO1uqbmPO/5S1KaxM2l4b17Ts+/TxP1
 He09yrGidFLRN5HExtiZaOGp1RwVJ0cpgXPbfphJXbuzL2hqTYkpBGjanry7sBICIZEI
 vvhSRVwIVj90gAy/8by/CVjH8a3lWmNBC9tiddi1jih0weTuXsK3f0dYUdOQGkFh4xGO
 pHiw==
X-Gm-Message-State: AOJu0YwEadj3n3QxNV9FDe6BVqe/k++WMFZYNGfV63tLvWc86OND2o8a
 rha/q4antfSgktUqHZca4RdHY/0gI4O0r3uSGtMjhPeA8Dq1lFD1G9GyPqrDza1++KT7jaxGheN
 PPrY=
X-Gm-Gg: ASbGncs+fXTJE1Ygd+kZF1pCRGPpSZEG8nmA7ov9qhWVy/H69bbxc8oLjUxud6HEkZO
 uH1HdWe8xCjdkstP6Zs+23O2QijUdqYV3zMjinPh14kchggE6OPTpNkFEcdvZGSgbrK8Ya7yr8J
 lDYHLThpkrnxiWlScuYa2qrJVA6opfYlgEhhhhnmxz7YqYk0G1a30j5ZWDioW+SDjo1HMGhl/9Q
 d/LyHGwM44n+wywm60d/YT4SXfZ17QFDgv4IHLvOeD1nbDLIQ==
X-Google-Smtp-Source: AGHT+IE0IXL1ZZjmMPPot8bVwDpOJnB7EwfxH65z/f1PUZnEpWWBcGqAt/B5Vrr3ZhV5+7ch7Vy1bQ==
X-Received: by 2002:a05:622a:590f:b0:463:6bc4:2a23 with SMTP id
 d75a77b69052e-4653d3e24ecmr194935441cf.0.1732503691301; 
 Sun, 24 Nov 2024 19:01:31 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46698d02e2fsm1697581cf.18.2024.11.24.19.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 19:01:30 -0800 (PST)
Date: Sun, 24 Nov 2024 21:01:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>
Subject: Re: u-boot mailing list issues
Message-ID: <20241125030127.GH3600562@bill-the-cat>
References: <CAFOYHZAJA52O9NiKtHxSRdaP=Yu_4FG36VReai=gSyWhHZG_=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H62a3xtZiDjmhUmL"
Content-Disposition: inline
In-Reply-To: <CAFOYHZAJA52O9NiKtHxSRdaP=Yu_4FG36VReai=gSyWhHZG_=g@mail.gmail.com>
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


--H62a3xtZiDjmhUmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 03:04:05PM +1300, Chris Packham wrote:

> Hi,
>=20
> I've noticed a few odd things on the u-boot mailing list lately.
>=20
> A couple of weeks ago I seemed to stop getting new messages. At first
> I thought this was just gmail deciding to helpfully file messages away
> for me but they didn't appear anywhere (even in spam). Then I thought
> maybe I'd been unsubscribed (there were a couple of automated messages
> around the time the problems started for me that I'd just ignored).
> But when I went to re-subscribe I got a message saying I was already
> subscribed. Recently I tried again and this time I was re-subscribed
> successfully. Just now I got a "Your message to U-Boot awaits
> moderator approval" after I replied to a thread.
>=20
> Is there something going on with the list or have I just managed to
> get things into a confused state.

The problem (largely) is unfortunately on Google's side and as far as I
know we can't do anything about it. Once again everyone using gmail (or
I believe Google domains) was bounced, and I think it's the second time
this year that happened. I'm not entirely sure if we can easily
re-configure mailman to not add the moderate flag when someone posts
while not subscribed, then subscribes. It's just a one time thing and I
do clear the flag whenever I see it pop up.

--=20
Tom

--H62a3xtZiDjmhUmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdD6IMACgkQFHw5/5Y0
tyyD2wv/UTkoQ4xc8NH2YsWRg7On9FtS4zW0uev2Bworp7KmcC+pcIKedSafmqeC
Q0WSKayhp9EcUBcT1RShJjwoIDuA53rAEE3b0ZwA27l6uLKFJzuvlNHTQo/wY4Np
kuGKF1+I7OPEsxMMZZMvV4icvIJYSBB/B294mDmfCCSWoz9BUeZv+muC3vnjeO9l
QDAxSDmd9xgO4ymYrxTBB75tu00zK95ybYDc42zBMIiOXoQTR4wZp0JZNhBLs6BH
Snt413LLz4SJScGg9YzQyXQJn5xvRdG+9GYfP7tiCEje6G+INn3Lm488FW2I/pu8
G7Y6jL1DvXP+qNZ5/+zPYtTlOY/T8CflNymMHOdJe4fobw/UZm+yQQN9gPITm7oS
CxycJJR9VxOKUJLnwfXeL/QFItfMvuitN1HMPGpMfYCnPd87W3o/HNaR4xuZiZ5d
bRcyNp6T+4PWNLM5BchCAABnaUy76AB28wwd3P9rdeZJ9jPvm4tgF4kYGTs2Ndcu
wJsRF2QJ
=XcxS
-----END PGP SIGNATURE-----

--H62a3xtZiDjmhUmL--
