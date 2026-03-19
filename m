Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282B51090229
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 13:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9113483F2E;
	Thu, 19 Mar 2026 14:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hiGyfDeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6BDC83F8A; Thu, 19 Mar 2026 14:48:16 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A535383DC9
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-466f00535cfso477348b6e.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773928093; x=1774532893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hvrkfYodLxD2BiOTVU20kvC1V6yNyp4kd5DhvvPy9PY=;
 b=hiGyfDeYg3Y/qscfRHz+r9Lwsujho5oZ0WUBnCCSrDGoJ4w+U9jLUvKFSa8UHmEeeH
 SRqc685kSD1/I53zQxqkJE4HvDoYaAXMzaXJUCMLQLA7WxwEejxW5+Xi+XOR3+KZzxMb
 jf02nVtJFoHzaEAXeckaT8squT0LuGew/MPW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928093; x=1774532893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvrkfYodLxD2BiOTVU20kvC1V6yNyp4kd5DhvvPy9PY=;
 b=pcFHJa60AWtbDxXQOmccnDrRvGxYVpSURfKSXbA7kLJYM+axuBlE0NTHfKbAcKnsK+
 lcDZ80Dqq8Sgj3ppTWmEXU/sU4KSiv/mTCi51/clPhJ9dPtLQJ0+P4VgFBNpQFecLUSJ
 ZZNUw9d0VFFupAex42rHNeNLbS+GoDrVvDy/33397j65tB+iOE/js76g9B+UsOYMkDjf
 vbBwoHwu1VNUc2VeJeHAKQy5yunQ6K28FeWFwZdbV7qN1ZFHb7g9NVHVq9FTmzOBaoeK
 4FgbeA0vbTrQGqnB2XLCZhI0u61sjrBYrvrwTrfs4DwYAWAYzkloPRyFrzt0YzKarJ3n
 +zCw==
X-Gm-Message-State: AOJu0Yxy6XHh3PGHoJb6dwgNNnZaNzRws/9lDVqGOoBerWyG9jF6Xwby
 kH1D5NmnUk70UYAdB0A2Camyw9hFG1EcNxjBZg3lMqHD1Mn0tF+XOF69TZylU38lQx+TJl40iZn
 5YB1qJCM=
X-Gm-Gg: ATEYQzztna86KdtVKOwiAim0vKLF6tBT1Z+AhBrYT6SdPjI/QDICqR8mhMIm24euON7
 5jt3YNivklf6UeIAiewXpwD5obUVJwkQ904Badb7MQRMRAmVUxInYXoTu7v5vxdIAtKmm0JTX8q
 yd6GBJ4o1LExg1jboP0VY5Ozf82SEpVKbuULUuNbcFHRqFNMuaXur3Rw33XEkvptc497GE1rFs3
 yFs5+0bXdL4qVrB43nHuW2+am1FZf7jRmINEyf38NbdWIDhv6hoHQq9p1M3hOGUab9Vwz/2NLXS
 2RPfVpK2q2GXq40jTpDLS0ljlYZOZzroMnaC1BSR8waopAkxI5zZ1wdGoJzTgeKkGdOx6hPamcp
 jW8w505zzvPUy2ivm4qbbZBOON7V5El/moDw6Z2iu3cqjQLGQSjTsq5eml6D3e0jFxXAFnwFLIL
 bPB7Smc7G8NqrXHAfi2G4vWdJy7BEar4/swTOMQdpnmXDcou/VGxN0hfADJbhbdZdzkUT4xStZD
 y2Hcs/I/GP1H1RbHz99O/D/n6h+9TBs5DGsois04CsLE6Qs
X-Received: by 2002:a05:6808:6b89:b0:45f:59e:1e06 with SMTP id
 5614622812f47-467ba10a4b8mr3693235b6e.4.1773928093249; 
 Thu, 19 Mar 2026 06:48:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467bab032cdsm3747147b6e.18.2026.03.19.06.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:48:12 -0700 (PDT)
Date: Thu, 19 Mar 2026 07:48:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule
 tool build
Message-ID: <20260319134809.GR502704@bill-the-cat>
References: <20260319112717.7805-1-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8BhUICQ6KxSDM8GB"
Content-Disposition: inline
In-Reply-To: <20260319112717.7805-1-boon.khai.ng@altera.com>
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


--8BhUICQ6KxSDM8GB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 07:27:17PM +0800, Boon Khai Ng wrote:

> mkeficapsule tool will be built by default if EFI_LOADER is set due to
> external changes for U-Boot v2024.10 commit b7a625b1ce49 ("tools: Build
> mkeficapsule tool by default if EFI_LOADER is set")
>=20
> This will cause compilation error on all our SoCFPGA devices, hence we wi=
ll
> be disabling this config for now as we do not utilize this tool.

Why / how is this failing to compile?

--=20
Tom

--8BhUICQ6KxSDM8GB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabv+mQAKCRAr4qD1Cr/k
CrayAQCRGNoAkctuPgsJFS9FpHz5IMAoZbghDVNOVr3Pc6BVxgD/TMOSR+GENlX3
ydNy+FeqQO6H0qShbnrboiDF5InfLAo=
=/SKF
-----END PGP SIGNATURE-----

--8BhUICQ6KxSDM8GB--
