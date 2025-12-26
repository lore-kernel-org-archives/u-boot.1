Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFF0E8FDA7
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 18:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E638391B;
	Fri, 26 Dec 2025 19:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cjrCrR7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DD4839E2; Fri, 26 Dec 2025 19:07:46 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43C9838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 19:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c7660192b0so4931441a34.0
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 10:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766772463; x=1767377263; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LxiaLowmSJ7ok8qcal+ZswzX/Mxqu3S5gSCOhQLlCb0=;
 b=cjrCrR7pKu+pYWEL2SFC2OnjUNoGmGV2H7abf/qc5MqUT1ZHl35YIMnKVNotKA8E9q
 eIdqU1noCaJ853LKI6gVkRRUA51/5OoLaKpjzkjCgvJDRmz8eWVkbn7qg3Jjf8lGzyQ9
 TVOxOTNVE0Hd2xN1sMagr/Ad/lLeGoEbMMvuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766772463; x=1767377263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LxiaLowmSJ7ok8qcal+ZswzX/Mxqu3S5gSCOhQLlCb0=;
 b=SaLedJKeHLnYI4D77aVySpdrENtIzXrvsHE+tohTwxykvuD2lxliiUagzanYgvUPeY
 lIk+X57Ie1PqntzZSQlzZWGu6VdPi7UZ59ui/DnnFzZPKIfXJnJUr8wGAqUOhfe+VI6a
 ajkYsBcQ5SACUqPInnce5At0Rwzhp8xjISL+0hcmswNo+pGtBfXoqVx/mHVNSZ2JviVX
 WZZiChm52tLSu7Z6l64smQbiCkz3BTlaqzE9MmLyCs/Y8aEieovcIiZYOBlRA81YX3Yj
 BmiT4ERev7PoXtrhhrFFt54oyhXdBK04+Gt4FcEv69W1ur0qeH9C6dF8Z5qE6AHL5olY
 ngug==
X-Gm-Message-State: AOJu0Yxlu0cYfo0aps8dCEXN/Q2guBTovFDFD8OBJI1B70B/awIbp3G+
 PS1KeAYHYQvPznIIdQ/WGOFfRqFvjL4Pklr7MQ1Ieh+LqPnUNp9ZpbdOhEwut08YdZM=
X-Gm-Gg: AY/fxX76g21vY1QE9XndPbUof+LMBagxGAY6qtps4c0cHjKtXtl2DzRpekO7hfja2M4
 mcRFl5dj5w0kk3fAGrZJsR7OD/Gi9Vm2VliecM8qpMIMaHGanMgDHt3Ybb+rpFnqkn6hq9YKVEu
 90vET+vjnQIRNO8Bj8JbE+qQxZ1+oHkz7rchCeGI10H/CzfMG/ye3UCCt/e7JCiTjzceGZfviqL
 XDeu1bx7iRUEg32jMerVk3iPfYlF4wNinqsPshymMd95TYSDKmMXLebB95ppygN8PMe2shHYpPi
 2xVFEoTsTTTEEAJ+4paOBbOgGw+3Ij7beR0ldxdfJKVwGqLWNFaLv9nRuZdqZPEVYeRiVMrJb/2
 whUukXqRyEsiqVRRZHACrrIrQcUVV0iJe5gSX4AJjBOVS4c4FwSgG5/VLoi4yfIFmtsozkAun4V
 cvvRN8ZXi8JufgQZtxcWO+huSsyxMrKWshfC2lNKXECI/r5uZ/jw==
X-Google-Smtp-Source: AGHT+IH7sXLIRQMpMH2kNii6tfSXzpftm0y1O5rE36BxEGMcT3f52Ac4fAo8B/TxNYZaA3S2IwQkpQ==
X-Received: by 2002:a4a:ba12:0:b0:65d:30d:eafa with SMTP id
 006d021491bc7-65d0ea6f202mr6387657eaf.33.1766772463501; 
 Fri, 26 Dec 2025 10:07:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm13507601fac.0.2025.12.26.10.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 10:07:42 -0800 (PST)
Date: Fri, 26 Dec 2025 12:07:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
Message-ID: <20251226180740.GE710860@bill-the-cat>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
 <CAFLszTjyO9d+QzwC=9t-cJ1Kx9oNcNSD3f7T+11zWwD-PJeYag@mail.gmail.com>
 <20251226145347.GB710860@bill-the-cat>
 <CAFLszTg3RBxzLG_iom6ogCSFSxoK9=HMxnwtKXuC35K6J+LRPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6wpXtD7xvW3rUhjF"
Content-Disposition: inline
In-Reply-To: <CAFLszTg3RBxzLG_iom6ogCSFSxoK9=HMxnwtKXuC35K6J+LRPw@mail.gmail.com>
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


--6wpXtD7xvW3rUhjF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 10:44:16AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 26 Dec 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 24, 2025 at 09:23:59AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 19 Dec 2025 at 13:21, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > The devm alloc functions that we have may follow the Linux kernel m=
odel
> > > > where allocations are (almost always) automatically free()'d. Howev=
er,
> > > > quite often we don't enable, in full U-Boot, the corresponding auto=
matic
> > > > free. This in turn leads to memory leaks. Rather than manually trac=
king
> > > > allocations and implementing frees, rework things so that we follow
> > > > expectations now and enable the DEVRES functionality to manage free=
s.
> > > >
> > > > This turns DEVRES from a prompted symbol to a symbol that must be
> > > > select'd, and we now remove our non-managed alloc/free functions fr=
om
> > > > outside of xPL builds.
> > >
> > > Most of the time boards don't enable DM_DEVICE_REMOVE to save code
> > > size.
> >
> > I'm not talking about DM_DEVICE_REMOVE anywhere in this series.
>=20
> Without that, devres_release_all() is never called. How are you
> expecting things to be freed?
>=20
> >
> > > We certainly don't unbind devices. A memory leak implies some
> > > sort of problem, but if we are booting the OS, all the memory is
> > > 'freed' by that process.
> > >
> > > What problem are you solving here? It is missing from your commit.
> >
> > The problem being solved is stated in the commit message.
>=20
> Can you elaborate a bit? I see a vague reference to memory leaks, but
> you should explain the problem. Are you trying to free memory before
> booting an OS? Are you worried about devices being repeatedly probed
> and removed, thus causing a memory leak within U-Boot? It's just too
> unclear.
>=20
> Depending on what you are trying to achieve, we should perhaps make
> DEVRES depend on DM_DEVICE_REMOVE

I'm not sure why you're talking about what you're talking about, sorry.
The problem being solved is very plainly stated in the commit message,
which in sum is that we violate expectations on how these functions
normally work, and should stop doing that so that in turn people stop
posting driver-specific fixes.

--=20
Tom

--6wpXtD7xvW3rUhjF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU7O6QAKCRAr4qD1Cr/k
Cjj5AQDddQF9jaJl0csmuGU6xaigyGp3Fxn/vbWxoK2DOt7cIwD+ITHKK2JfZ7gJ
cc7Axc/78IXwtcM4ya2cQa057klzcQ4=
=+OU4
-----END PGP SIGNATURE-----

--6wpXtD7xvW3rUhjF--
