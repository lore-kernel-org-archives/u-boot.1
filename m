Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46874C2BA2B
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 22:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B141380422;
	Sun, 17 Sep 2023 00:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="haAnIFuT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04A9B854BD; Sun, 17 Sep 2023 00:38:09 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C75803AE
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 00:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7f0a60a159so2912520276.0
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694903885; x=1695508685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BHpK1t1wqN9n2CAVJYx9pE3WbrPYCTT93la2R8kS/Rk=;
 b=haAnIFuT5vyq08YSVUU3iWZtLxtYImXYyslPPOGK+u5Li76u88YvIIdJf2c05UgD3/
 Zj0aOufLJCK3Ihu2r1n/9BYBCo7eSLfT6BxueHIYhe3otOb2DAGz+sHzPLB2sTK9lUTf
 Qxhe9NmDGT15y+DJoiem0DFkBZlJZizPwbpRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694903885; x=1695508685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHpK1t1wqN9n2CAVJYx9pE3WbrPYCTT93la2R8kS/Rk=;
 b=R6pJVuNYcmxH2BKJnHEtWrEiZP45mvwb8gUQLt6fpQOtbZkbPPEGqvdIsgVlRZe6tZ
 h7vqEJ41cOwFuhhil1xENylVb/n6hOEXENJUE/rKSnbC5EewzPX6cGtbW1133d7Pjm6G
 jM+Taz4M6lN1Z99VyOP7oAAQBXTCDC4TlT0HsXK/u9efDqr7QJ72aTohu/Kg0cpdRnvJ
 5GI5Wq2LWNw4n2CXheW10d3Ii9X+zo2w9zHbGJb3Xsrkf6c52s2EqQVtmWLXeypzs6uM
 wJttKEJiXFpUlqJ9Svjkb0TzOzaWfPxIpEVBZ6P4AcU61SKHRPFUrFlVSLOQKu3A3HYJ
 +3Cg==
X-Gm-Message-State: AOJu0Yw78v9IqJxDN2Ym6cBPuRa+GT6pC2cmnxiAI7w+rkXfwzuyQjPL
 te9BPM5g7E5jQs7FgJsNRXa+Gg==
X-Google-Smtp-Source: AGHT+IEiuGzhvuP/4BJq1Xu0K515tG4vn5vmArjt/4YnOcw2AtLBGG4r5u2rPP9S9N7giYWCpz7D8g==
X-Received: by 2002:a25:d883:0:b0:c39:9e09:2c71 with SMTP id
 p125-20020a25d883000000b00c399e092c71mr5413716ybg.41.1694903885563; 
 Sat, 16 Sep 2023 15:38:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7b8e-9e18-0a32-e8bf.res6.spectrum.com.
 [2603:6081:7b00:6400:7b8e:9e18:a32:e8bf])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a259249000000b00d43697c429esm1384297ybo.50.2023.09.16.15.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:38:04 -0700 (PDT)
Date: Sat, 16 Sep 2023 18:38:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-usb/next
Message-ID: <20230916223803.GI305624@bill-the-cat>
References: <20230916101618.5191-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ako/50k5KZkLTmMY"
Content-Disposition: inline
In-Reply-To: <20230916101618.5191-1-marex@denx.de>
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


--ako/50k5KZkLTmMY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 12:16:18PM +0200, Marek Vasut wrote:

> The following changes since commit 2fe4b54556ea6271237b35de68dc458bfceab9=
4c:
>=20
>   Merge branch '2023-09-14-remove-NEEDS_MANUAL_RELOC' into next (2023-09-=
14 16:23:49 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git next
>=20
> for you to fetch changes up to 2caf974b5fac69a1b778e64503f2c107a8d7c3a3:
>=20
>   board: usb: Replace legacy usb_gadget_handle_interrupts() (2023-09-15 2=
3:38:02 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--ako/50k5KZkLTmMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUGLkUACgkQFHw5/5Y0
tyyNwwv/VxbdzY7inl7HJg79vO5v5rvBoyM4lmiKBC87+SIG0wYD77eljlKGeXN8
YoEEYRHEqtma/K3C9ss1TFQqjmaO5tgKnbkVvHmBkS/2HvWC2nm6U8EIcnSVojWC
4E2S7X0wED/K+6qXUjKscBf7wWPAEW6m4+YYHdriwrHR8v2vNFMWA02BZRf26tk6
/+24I/2CfGu+fooIYo5iOdBuxs8jBnfjLCVaknaxZzi8lqSeauygxaZRDFMfdywf
hbkpGlkYt54nlIy7L1pli/KxjxEasHbPnVVo8MF3yf/TL8k4iLuD96ojGnCwAg8n
zrprfh6AKyArJ07afY2Kr79Y2o2plo7B6xjomVd4hE9Vp2uaa4X00q6FlYNmlujf
ra9AhUTOz+/IU86MSgrpr7s4VK7US0PiEcDko0TDNhskorWN7zIRRUTEjB6QDWmx
XQXBRRHcDlUCxku0kW59YNsimS5R6skk4JuqKP15DEQdKpbLCndLCVdFSEa8A3K+
s9ku3Dqb
=lZ4S
-----END PGP SIGNATURE-----

--ako/50k5KZkLTmMY--
