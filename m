Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F052CCD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8304D8498E;
	Tue,  9 Jun 2026 21:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="agEpPpUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD168498F; Tue,  9 Jun 2026 21:01:53 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C88684942
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e709dd1ab2so1852973a34.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781031710; x=1781636510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S8VDmELQJC9m7Ohy1BZ58F7WUNBSq079PZRbO4zfGlY=;
 b=agEpPpUQ7sU2Fp1buTpufpnANxTOoGw4MwSNZdCLseomaqxhcFpWeW7E4oKBgpcWvK
 d76ImaaopOW6M9Vr5kilxQVCB21nKDZq6yG1mtT6UzQtIAIaFGgNx1tHC1t8Dn4WU7uC
 HRdHFlrLFmXnZ43g5n4OzpkGL9zw8bl2x5ZUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031710; x=1781636510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8VDmELQJC9m7Ohy1BZ58F7WUNBSq079PZRbO4zfGlY=;
 b=DB5ncFrkJe2l5kZAn/iSIL3hAUIbiyEMDytnJbkqds3g0Dko2fJmDtMEQ07muTA7Wn
 8L9Je1PlOjjqL4U4l55xIlojGTXJxa7cpL/PeCdkSErquA0BEUaMV8PYkXW9aLyii+lc
 zBRlEciTCzHtyn5U1H1f7QGAFBIAzoLd8D2RsxRWSxdTu5fr4TGgkUNDsXtVonfdqkjY
 lgY3t1FQ2IwhQwqA2ZVhO6zzTYxwcKIr9iktFWIyz+3guvCRrl+en7NYXn+XxhBePGOU
 ikfK+Q4rXmM6ettox+wEyaes3jExnnSJfHY/9M51g0uDX4/vwm4Zm7DZbgd8e/8vNBuh
 jphA==
X-Gm-Message-State: AOJu0YyCA4ef+NuzymAmvrtDj63Tu4n1jRnt5QreLs3Z1GrheMXEpaGK
 zewiAtQen3tiMUYH99AzJUw5F1lsOm+K5Kctm5jBEjwQKZpDGMqAi9mqk06aaw9g0KQKFEZSbcN
 WVVoyX6o=
X-Gm-Gg: Acq92OHA78IYGHQ0GEPvGUxMTXVeyzxUtFuv56gMO0OkVlrr3cYV+bYXKmo/uI7Yovj
 CO6SkGRYAI24Y/YCzz2Fn7Ih7ahQczRcBgefRmErHwYR7di+DTizWY4b8aK3XkSGV0zTxPTsOxi
 l2L20mZv9RStLx23I/U0IylNSSz5/936FgvMmgaLGeiuIdjtUpZ3BX5Bw4672rgzfcHx5qTVNrQ
 6IcENvvA80s23IHFZ/LyBzKkTKxb4nUkoV3zuNb1+YMQZV+BbvA59JtyDuCBIWtfq3Pw/LVsG+C
 ZxlLJEhRjFJbcIckoqcsAQZXCvFmSuihlamkvQASuvsP/jDbdweG0A/jSSn8X7ieAISjvF7RMzx
 W8fdI83u2PPM8jIXFMG/WyvBeDc6yJ2mHjMqhUJ3+jZVoPekFMpj4iHsWtM1IgPNxbNf/kvwWoc
 t9BtHwepxhE8hvB2zrp1yQnsCH2eNNWPFZtFI/fzuycyo/J/v5cYK88ShHzxABOFC+lO6nqKsSE
 g7TmSgq3UX5h9M+pfoBsS0rz6woN36XzN2ohMgDmsOH2bUAoXE9jeZb5gjTSg==
X-Received: by 2002:a05:6820:4cc9:b0:69e:4246:e6d7 with SMTP id
 006d021491bc7-69e68c709a9mr11608161eaf.45.1781031709920; 
 Tue, 09 Jun 2026 12:01:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e462413fesm12244285eaf.6.2026.06.09.12.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:01:49 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:01:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 5/8] Kconfig: misc: add empty line
Message-ID: <20260609190145.GY382693@bill-the-cat>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
 <c56873d6-36fe-48ac-84ea-8f31d174ed82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hdRqip0FAGfMf/Fz"
Content-Disposition: inline
In-Reply-To: <c56873d6-36fe-48ac-84ea-8f31d174ed82@gmail.com>
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


--hdRqip0FAGfMf/Fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:25:43AM +0200, Johan Jonker wrote:

> Restyle by adding an empty line between configs.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hdRqip0FAGfMf/Fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaihjGQAKCRAr4qD1Cr/k
CldOAP9UAZB4tNyG/eVxXH1fAnzSQ6vD35Sh0hDYvQE/3wUP5gD+MydcGYZsyiIx
2T+XhE1MccvwB14wLj/E/biVf+G9Bgs=
=utoW
-----END PGP SIGNATURE-----

--hdRqip0FAGfMf/Fz--
