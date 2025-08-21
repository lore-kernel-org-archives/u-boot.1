Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3804CA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 23:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B49780548;
	Fri, 22 Aug 2025 01:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YOgBuN0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D9E80548; Fri, 22 Aug 2025 01:55:03 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3ED8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 01:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-61d99c87d32so746703eaf.1
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755820499; x=1756425299; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CKeDefxJZ24YLKDBeueunUExg/8vaXjYXd+AtnPbKLA=;
 b=YOgBuN0kjhy2ybl+o6KnW7JgBTE6fPEQUmgaYxlULhqx2+kaDe4V49zaSXQnGhpPVc
 pxScnZBSkJM2tiycIgNwONzdks7ICTfCShVBnkiIBw/fvtcR10prdg38IKet5Ryiwq8a
 2HeFU5GFdXDMKaKHWn+YA+vD/exqWfGi7wL84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755820499; x=1756425299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKeDefxJZ24YLKDBeueunUExg/8vaXjYXd+AtnPbKLA=;
 b=AMAERMT66s1v/nSnw3syewoBa4cHCdm+TRd/Coyy/eQQEHOvYXuk4Mx/NK0X2P/+2o
 4lWjvyeeJwPMwMfetEZMTwKwaMAu4IHJxVzNlfVX2nwP5WvUrWYGcViEqiHHWapUel+A
 RLqAlSiEIq89GSqWVlU3YUAxl1v1fJwxJWt6k7ZYiHU+6rAQluNlADDxBN8JHp9hhZmS
 0aIcQXyHssCE3BgROCh+rPOMVUvq9bw1AoECt2asoP5d2G51NCH1UFtrm93smisIoEMb
 lbLYCuILprqujQgaY6sM4kTJ96ElO8IDYoQZa/E0OdIA/cJ1gI3+T16/rGAb+2MVVYL5
 hRSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJVDQW1xcbxyCTKZMI8K4Csqa3ur8Zs5lrtnhI4F/R0fByDM9/Vm0XEqlnLbM664hQN6kvBoU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2+StCbd3Pcv6shEo6beii9/m3IW5uNImMUu5aFkNAdTcThKQI
 yvYex4r+aKQc8CPUgfyZ0iDpHj1yFv9JnesmIpv8fuxaqADYhK1WiSAL63fxYNSvABg=
X-Gm-Gg: ASbGncvolS7GFpeIfOZEiz5Pl4ox48SRpWXFPBco5hNjVCstDXQrZiGk+JD2UXBE9o9
 nUKlHUbyqJzpO2+ct4BufhmzPKEEoU6i+yRvioZy0H1DkYgdg0V16+vezsUGhMFT7zXqaiSn7W5
 nn4aNtGcmLy0iZqegheQkvJahzIahTUbly0D9UL67vBhEuYt6N85AFGm7W/53YvDjEH+/dnQ+3y
 qyIF+jBQAcOvB4ILq9f/cIeHra+W7zu26W5F7qA37ViGk4E7dvMAEsDDOsnCmyI8N9+tZddMGui
 LHz4TCzjmlZto5IRk1Jajnr852xqEwmIZ2kru08e7pvvc6ivwOfC/E2Aw9r3vThgwkyXOl55dDj
 m2yg2eMvfo4MMAfmq0KKGG7SnHTYYLGdtlI0pC0PsA2rO7iRwi5PiD+fG
X-Google-Smtp-Source: AGHT+IFilb3NQ2wQD8r4tNwgHB56S7jlVR66CfoVIR/l0oIhjC7YQIsR1EELNrkuxgmeV1/IL+RZOQ==
X-Received: by 2002:a05:6808:11cf:b0:435:12e5:d79a with SMTP id
 5614622812f47-4378518edd1mr664131b6e.5.1755820499568; 
 Thu, 21 Aug 2025 16:54:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab87a84csm5447798fac.7.2025.08.21.16.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 16:54:58 -0700 (PDT)
Date: Thu, 21 Aug 2025 17:54:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] ddr: marvell: a38x: Fix unsigned issues
Message-ID: <20250821235456.GN124814@bill-the-cat>
References: <20250728-a38x_ddr-v1-1-4102aa87697c@linaro.org>
 <fc2eb511-430e-406a-a9fc-b47e6eb9812f@mailbox.org>
 <0d13343e-654a-417f-9f99-e33a5bc36301@mailbox.org>
 <CAJaLiFyNmTQQr-bN_aj4bPCL-4Zb+rakQ7RGiGfvkFupKG3fvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BW455cSsgC5qH0Lq"
Content-Disposition: inline
In-Reply-To: <CAJaLiFyNmTQQr-bN_aj4bPCL-4Zb+rakQ7RGiGfvkFupKG3fvA@mail.gmail.com>
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


--BW455cSsgC5qH0Lq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 04:43:29PM -0700, Tony Dinh wrote:

> Hi Tom and Stefan,
>=20
> It looks like we have some problem with ./scripts/get_maintainer.pl. I
> was the author for the Marvell A38x DDR4 port (Commit 54a08c4), but
> curiously I did not receive patch email from Andrew. So I ran the
> script,

To explain, there's a time-limit on how far git history is considered,
and so your last change to the file in question pushed you off of the
list of recipients. To answer a possible follow-up question from you,
I've gotten complaints from contributors previously about being cc'd on
patches for something they did a long time ago. The answer is that you
need an entry in the MAINTAINERS file somewhere to match on a given file
patterns to always be considered for a patch. I *think* MAINTAINERS
files in drivers/ would work with get_maintainers.pl and we just don't
have any yet.

--=20
Tom

--BW455cSsgC5qH0Lq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKexzAAKCRAr4qD1Cr/k
CmtyAPsHh0tLapI4KRjQsJ4nAkVgBn9+N8DAg7XzjLvZHo0oIQEAioFVZmNx/Q8Y
jCz0ZxUDvCV55TLSHN5VILGdWIuE6Qw=
=Jjfv
-----END PGP SIGNATURE-----

--BW455cSsgC5qH0Lq--
