Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B38C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 20:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9084288361;
	Mon, 27 May 2024 22:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WC/ezXYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718FD8837D; Mon, 27 May 2024 22:18:07 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551AB88361
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 22:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43e3ba01083so683191cf.0
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716841084; x=1717445884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c7Onq0QEP+GUg6zsBuDfacd0+4rfyFmLttCOIdF42Jc=;
 b=WC/ezXYLb/FHhlM0dsX7dYc4F2gxeMFKEmJsRRK79GPLNIPYb6n+EroJTJjJfEYwi+
 n6Ur2kgB/ckl7E3hohDTe3tnfv8SaHkRbvlX6mQgmCOe+JvbZnU7SBwZ8fyj6nDG64CF
 BifC2nnCBWifyHNt5kP67/bCilbMM/GRGnlPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716841084; x=1717445884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7Onq0QEP+GUg6zsBuDfacd0+4rfyFmLttCOIdF42Jc=;
 b=fa/YJqBGYGr1figwVu3MeEHsouAwFzc8uaFA9TTF2WvbgcQzYpJrOb+t0wkBbCAjkv
 /sNSu9ZYrGDRF6CRV19e8vHLgCbcrNqEzZhZkiGiINmbFVk0xrAPtIUDMjK+RfjkUn/p
 Wbr30mfMSQUHxIFaY1kRn/sCbmjXiNqVO8khli10WmiIOuhmHbP8Mk8P2U4QsPaa4w9F
 V14Ibrbsb3TRPNorSTw8/MRjqGEl2YA8U/LyhPbG7hCRlnC2imJ4BU4Q+e+Ry30vq+nB
 tZfxlxx5kRWbnzA5tGjZngJV6CN7FNncqNzQIN5Zacf7UoYj3xTvuYIxnOonOIQ6MFR3
 u9Wg==
X-Gm-Message-State: AOJu0Yw7LHXEructZcOWRM3EY1Frzt+WkwgliNTRzecAe5XGFwybBui5
 jifGHMyT8UvTwBexr6b3EePmUVeSwhCdpGbHLXe17v0OtApcfTZNT0aWSyCFcLg=
X-Google-Smtp-Source: AGHT+IGZh2UdtcZoawsNEi66HyplhcHILwAbDQTGVCGZmxQy23MyDgjN596VrIBR3jEkz7LznTnVMw==
X-Received: by 2002:ac8:5701:0:b0:437:7a3f:d392 with SMTP id
 d75a77b69052e-43fb0e70af1mr118204341cf.46.1716841084102; 
 Mon, 27 May 2024 13:18:04 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb16b97b5sm36583801cf.18.2024.05.27.13.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 13:18:03 -0700 (PDT)
Date: Mon, 27 May 2024 14:17:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>
Subject: Re: [PATCH v3 0/7] add ArmSoM Sige7 Rk3588 board
Message-ID: <20240527201758.GK2568172@bill-the-cat>
References: <20240527170214.283988-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CHPvGVoPehjXtIb+"
Content-Disposition: inline
In-Reply-To: <20240527170214.283988-1-liujianfeng1994@gmail.com>
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


--CHPvGVoPehjXtIb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 01:02:07AM +0800, Jianfeng Liu wrote:

> Devicetree of ArmSoM Sige7 is merged to kernel v6.10-rc1 with USBDP and
> GPU nodes. So I use update-dts-subtree.sh to pick related commits of
> rk3588s.dtsi, and then pick the commit of ArmSoM Sige7's devicetree.
> I also did run command:
> ./dts/update-dts-subtree.sh pull v6.10-rc1-dts
> based on my work but there is a merge conflict of file:
> dts/upstream/Bindings/Makefile
> I think this should not be related to my work.

Yes, I took a quick look at the conflict is unrelated to your series
here and also with a quick local apply then resync to v6.10-rc1
everything else works as expected from my point of view.

--=20
Tom

--CHPvGVoPehjXtIb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZU6nMACgkQFHw5/5Y0
tywn9wv+KhNmzol5zE6/tfXSwVb4H3y0NiH16xzyZ9yyN35+tGv6hz8y8XvGRQ52
azWFEx8tS7/j6EF43CVZ9SgVmhxvL/AiWlNoXo9YfgnFTMRUC3BeAb9L/51P1eJT
OOLTESCCOO77rffQUxZc6aQI/Litbk0txxzsxS6/q3kvljSgx8Lmwi1K+Rl1CqiE
X7cCRGu4VSIv8oubBRIH1E1s+6I/8j708yenEqzo4R/qsJ2nd2NF1p2OL0LSOAcY
8kqt5xcfJuCjxfHtv7U5euOPO3f/uXdhQZ2tA+mdhYOfcbaM++foxES1Ev364ntp
rGINYZzXiJceYdYjZceci54bpq+dbp5YnSEdjlqFEN1vuPPiGwH9PORmw5LAZE4O
WfThnx9qPUEP+QOjXKQikZU+/fpy8VmeMSc6lJLe4uTWTsooFBg+t9dEeiWXu/eX
lXV3udqGQHlWeZamyZ02GuLsJ880fvXgJBWZ/QHGg+4VuelGPPaAXWdsucP1fpy5
MjkSViIa
=3Qtu
-----END PGP SIGNATURE-----

--CHPvGVoPehjXtIb+--
