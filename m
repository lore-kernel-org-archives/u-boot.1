Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8101CAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2881681E13;
	Tue, 16 Sep 2025 20:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AYSKNqJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B785883236; Tue, 16 Sep 2025 20:57:50 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC4E800C1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-74a61973bedso5205651a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758049067; x=1758653867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eut7hUsvmLCqzkfFt51D8Y0E8FlOWsn4zVMOqmfry0k=;
 b=AYSKNqJK7/21xRD6R8rk6vB9OugEENfLW6vVBKXJtgdo3rJcWdy4AtvMvmxvHhihmW
 PmVnZK8cfT9jLY5pwxR1O4aPaRGyviMXZE3W/lckdrQdw1smaymZcLp4JTxFgaOT8XEW
 7z8CVd4hJDAnn4x+5eibejOoJMCoGkF85Ifjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758049067; x=1758653867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eut7hUsvmLCqzkfFt51D8Y0E8FlOWsn4zVMOqmfry0k=;
 b=QXWtESrFTKLoTHG3p9rSmpStoeWYFwam4ryrrO6K0IfMpe4PZ1RbFxqkU4KrordXzX
 E6jV4CA769SOxA9JyPydaGN/ZSAz0Q316zT0sdjsvwbXcbA4YMgMCa1212xkbJKW/8j2
 dxa7sLuVwgv448eSvw0LK6lGV30LILbXOfStGUgIpQ4QfqnrVL7EGZwhRXvRdZhoZQQS
 pFRxyz0ZBJ9BAZRt7t3WI8s0PFIHB+Fmu/ZXf5OMLZFNf1c+SUB5fjPxsswBW68vjWXe
 6iApXVX0vk4+D6sEmn5o1MieHMpt+Sxgcd+Kte6bRysDVvgVMBRk6/JnSmL4MsW4ek8t
 /WPQ==
X-Gm-Message-State: AOJu0Yynth1VNSluHdp58QKOgkZrTgKf/y+Lb8HXqHWQ37+9mM2RZUc4
 d9Px2WU1HDYLcOMYzyLFB97hToPwp9lXhn+8jgTM+oTVl+PWgKMA0mv5zeA04BxeDPM=
X-Gm-Gg: ASbGncuWMVfUIWkKHLEXn7uJ/L/u3wT3orEdld88LEmBKXduVgdbHavD3H/LekqW9Iw
 Vindb1dnwscTGzFbiBG4B2ru+QSdHYUKevjDL5BbzIV/t3guJuXx2LoQQ/QoKh+LMOj5QjXi/0J
 rY3+sdDvZfplLk9A7DHO8tUBCnA7x+Zn6ANVH+FWCsY/s465PS2KAf0Mvj1Mve8BPbe+R/NVEdS
 9X1NMGQFtZt3dZUO4+qlV4gqfKeze7Ku/dmP8YDhvZP9qRTm/THGAnUaDoivpBSRoIU3aJ3EMYr
 3f+c3L/HitYGYx/xQIy7/LnKaYXzkiH2x1aupjLledhNT9RTMiW6+RH63xRUoupCTifpZEuxkTk
 GiKvcxe5jKwOyOlwFBCvPOXmeo5v4Jh0zufTguKqvE/jwLUVs+LA3CPOe26OFyl4lkgw=
X-Google-Smtp-Source: AGHT+IEU911txnYbSIsqXps22XTzkAeT7VCFoPdkrVr+2et63B/GnadaxrmG9ymFKNaNDVvlLunoZQ==
X-Received: by 2002:a05:6808:10cf:b0:43d:2146:e537 with SMTP id
 5614622812f47-43d2146ecacmr5570817b6e.2.1758049067368; 
 Tue, 16 Sep 2025 11:57:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82aa3e3esm3435969b6e.23.2025.09.16.11.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:57:46 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:57:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: Gitlab CI slowdown
Message-ID: <20250916185744.GG124814@bill-the-cat>
References: <20250916174402.GV124814@bill-the-cat>
 <CAFLszThagMr7f8tbAfeKTHsFc204TJN+z-B-SxR5qNqnM15Nzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a7lYUUz9kO09oJ3K"
Content-Disposition: inline
In-Reply-To: <CAFLszThagMr7f8tbAfeKTHsFc204TJN+z-B-SxR5qNqnM15Nzg@mail.gmail.com>
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


--a7lYUUz9kO09oJ3K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:56:04PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 16 Sept 2025 at 11:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > Hey all,
> >
> > Currently, Gitlab CI runs are going to be extremely slow on the final
> > world build on arm64 hardware task. While we had previously had 3 fast
> > machines available here, one of them was decommissioned unexpectedly a
> > number of weeks ago and the other day the UPS another one was on died
> > unexpectedly. Currently this is expected to be restored in a few days.
> > Our third machine was disabled for a number of months due to some issue
> > with the machine itself that seems to have been resolved, however it
> > also allows for multiple concurrent jobs so it will be slow when two or
> > more pipelines try and world build at once. Thanks for your
> > understanding and patience.
>=20
> Is my one (alex) in this list? If so, can I change the config to
> resolve the concurrent issue?

Yes, alex is the one I was talking about there, thanks!

--=20
Tom

--a7lYUUz9kO09oJ3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmzKAAKCRAr4qD1Cr/k
CnaBAP0dyP8d5CzPoK5/Gv5IieIsDPxWkWK/sPY15dxg3nIhzwD/UB92oyt3rOCu
RUqDaWTaJcWAj66p8wNR02vI8SbvEwE=
=HVLI
-----END PGP SIGNATURE-----

--a7lYUUz9kO09oJ3K--
