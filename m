Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A66CAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF6498206E;
	Thu, 25 Sep 2025 16:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AYJw8h/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5660A82998; Thu, 25 Sep 2025 16:21:22 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3648580107
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-74ed00220f6so426312a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758810079; x=1759414879; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UUDiZxGzSfcYDtcVTAk3hG0lu1bXVruTlHNln8JEqdo=;
 b=AYJw8h/X4MhAAtIF9mG/lrwq5t73umxE8lRBwk+SdD3Jz+XQGLESvG5MISXv4LSH9q
 TKiHS8g779ojl2u93bOYTi2IJV/hgk/Cxwti/lPktNEvJ9uv0dUofJD7pXIUo37RaESZ
 iPLzccNqrgt1l2RlAV5mEgwllAvJ1EtCwweqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758810079; x=1759414879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUDiZxGzSfcYDtcVTAk3hG0lu1bXVruTlHNln8JEqdo=;
 b=v8WN7RmdfJYGvz5KUSq++r/3ey21m5M7U9vqUPaGW8YPZXHlETZknTiKDOBWGoSZlZ
 3KgfoX6nzBYjESCOuzQ/whrRspz7jFNujCHmGgp4R/bxUjGXeYfK57N0oXU53Ft+9L6A
 qugMbRSjIM+3w9AEowa4CDs4u9EpwWC1IdBtCuU+cLjQItYNX3hy2sGNUSgk7CFKqa9t
 l0emrxCGAx4vlJ4maWYO1OHCZGNcDYktAGOKgPdwnct2NEso6kGgkvj+aFJz190WR3To
 swY4fWIRQTu3X7Gh5PjJeE8kjkHGgwjo8IXdzD10//qImrTkTaJVoGjHj9q9JLdJDjaX
 DFgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUsovAEiUGOLguaVwfSvovZaaZ334HS67hGjsWil8G1n8pKIqwBwYPK7+haMjEs66liuxOg5M=@lists.denx.de
X-Gm-Message-State: AOJu0YwaMuwAipR3v9rXfQNsGCEFq5HmcOiLeXss0Ms07QD/E9UrkZXu
 2Hc97Nvt14tFP1yb61725yQnAMUVY4/fIrX0eUxXtNLxbEOumzaECoo8o+hIfEyPbkE=
X-Gm-Gg: ASbGncv6Pa3fz/iKcXDdy1CiZIxiSAgjka3ExC0pztfjHxqM/K8mXvRKJunkxCi8o4G
 YYkSfoXZhcPtLXhG9ZpMom//uiO+g11SByHi3EC6uhKr4zfY0WTD22+Hu6KxNJeFY75d1UkO37S
 2iurn8SGh47048mP6BoPb9pkVfVSS2htXbKXbUKcs9aJVh9fdQvGJIR48blOl4vvSgMlta6AyEY
 oc1E7PjaVnThG7q59XntlKFZSVNkqBL9adQPav0gHHhkSG+cSqJmDphjTPM30kY42uEIt6Q4Qf0
 Z5b1Fjx89UaplK2KmtjJH+hwHbX7s5ZlLmzkLkPK+c7HiupnTw4c52m3dpnl4zpMkLr3KwP4UOL
 HzyLdOhcSHMUimVN9Cn/DAG9kz/b3MbwATSV/dKdu7cHzeTA6tas+YnHm
X-Google-Smtp-Source: AGHT+IFWzs4VhXgqIFGpGOy0zPh5BbWVzTl3eTqN5nWoeYj281Y9TWZg90V3oV3YFc57tlkchiCVgw==
X-Received: by 2002:a05:6808:3a0f:b0:439:8e9:637c with SMTP id
 5614622812f47-43f4cf5adbamr1542241b6e.25.1758810078825; 
 Thu, 25 Sep 2025 07:21:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363b2ad67d5sm583438fac.24.2025.09.25.07.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 07:21:18 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:21:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Carlos =?iso-8859-1?Q?L=F3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] Revert "tools: mkimage: detect overlapping load regions
 in FIT configurations"
Message-ID: <20250925142115.GN197373@bill-the-cat>
References: <20250925134212.59709-1-marek.vasut+renesas@mailbox.org>
 <20250925140802.GL197373@bill-the-cat>
 <7fdf6e61-0b05-4ee3-96bd-abf9aa7ed737@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aVt48+A+Zt83OPyH"
Content-Disposition: inline
In-Reply-To: <7fdf6e61-0b05-4ee3-96bd-abf9aa7ed737@mailbox.org>
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


--aVt48+A+Zt83OPyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 04:13:52PM +0200, Marek Vasut wrote:
> On 9/25/25 4:08 PM, Tom Rini wrote:
> > On Thu, Sep 25, 2025 at 03:41:43PM +0200, Marek Vasut wrote:
> >=20
> > > This reverts commit 588094f2c8ec9a4f7d2dcda11ffae8db8462149c.
> > >=20
> > > This introduces warnings on valid fitImages which do not set load
> > > address for fdt-1 DT node. This is valid, because DT can be loaded
> > > to suitable location as determined by the fitImage loader.
> > >=20
> > > Warning: not able to get `load` of node 'fdt-1'
> > >=20
> > > Furthermore, do not add C++ style comments into C code.
> > >=20
> > > Either send a fix or apply this revert.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >=20
> > Sorry you hit this during the window before I reverted the series.
> Just keeping my bootloader up to date ... :)

I do in fact appreciate that I pushed the series my afternoon and woke
up to (well, I saw the first revert request before going to bed, but
it's the next branch and not hours before a release :)) several problem
reports. Prompt testing and reporting really is great.

--=20
Tom

--aVt48+A+Zt83OPyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNVP2wAKCRAr4qD1Cr/k
CpxqAP9l+KpCm07A3st03SKTXt/iOnxDHR1XdpllG0fJs7xNEQEAkEm3axgMwcPt
H745cwEW/Mavi2/KPcm0sGhMVSdX9Q4=
=DxcK
-----END PGP SIGNATURE-----

--aVt48+A+Zt83OPyH--
