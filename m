Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B69DC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82FF8803A;
	Wed, 27 Mar 2024 13:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pVO511+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31468880B9; Wed, 27 Mar 2024 13:07:36 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2117F8802E
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6e67b5d6dd8so3653230a34.2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711541253; x=1712146053; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t2zVXoff3TLf3fXaKWGu3AGplvoVTJ4C8guKWeg/DDk=;
 b=pVO511+dyBijE1UGsdl2LF7LusptwbgLvha80BR+CscNGVUDFYXg2c4or+LS84/yaC
 0wee+PZhasYgzfq9/1HMj+ZEBOW6gigZg5F4YeS0ier1TTJmQPXe6aaEDnfa/EofJsQB
 rxKiMlgJxqBZ0lcuEZYO5QihDuFzkxUmfHQS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711541253; x=1712146053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2zVXoff3TLf3fXaKWGu3AGplvoVTJ4C8guKWeg/DDk=;
 b=pu314gj4s54nhFLYwgsoJXur1Kmj1j/S6XBAEXiANskkKltWhW0Oho40xvet7/fib5
 CEFJ2T5Sck7yhc6JFDaqP2D36G4le+EVPPJB9gjKTing8j8ATbDgpkXIWCFM1kY+rZXr
 o4MB029yxy+3J1kf/pNprq+BpVLBmncnMblsr34CBxUTR1I701cPjrNtVy0AVeZZkWAN
 2Tc2MpnLZtUjOj0WS4i7oPKaBbpMnB030qr1JGAS9J9IV7HkPBy0DjN9emlLK5rcJK/G
 ALFTNZBXxN4THHFcF9d8zIcZlbmuvTk6vFL09X0/tsu/GxOHz0dxWT1deVgJDlour9IX
 /F1Q==
X-Gm-Message-State: AOJu0Yy/KtphKp1ZB0ZDlX4TRLSgdUAHxvwqt7APlsupw9cfT4Sfk11v
 BviHgr3INuRpWpDYNOXcGLm8M+cJ0Rl7Mo1VFzDN78hnoeFQjDVgEme9R9D87bE=
X-Google-Smtp-Source: AGHT+IGQLGC7yEqZtoIiTuTYQNKBq5wwJyKP0mA8R1B7V7HlvNipTt2mO7lUipCjx1zYOTqkO08PiA==
X-Received: by 2002:a9d:6acc:0:b0:6e6:b306:34cd with SMTP id
 m12-20020a9d6acc000000b006e6b30634cdmr1035274otq.30.1711541252779; 
 Wed, 27 Mar 2024 05:07:32 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 im8-20020a056214246800b00696857c49afsm4026133qvb.67.2024.03.27.05.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 05:07:32 -0700 (PDT)
Date: Wed, 27 Mar 2024 08:07:29 -0400
From: Tom Rini <trini@konsulko.com>
To: wefu@redhat.com
Cc: u-boot@lists.denx.de, bmeng@tinylab.org, rick@andestech.com,
 dlan@gentoo.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 ypron.glpk@gmx.de, michal.simek@amd.com, randolph@andestech.com,
 seashell11234455@gmail.com, peterlin@andestech.com,
 samuel@sholland.org, wiagn233@outlook.com, jonas@kwiboo.se,
 seanga2@gmail.com, baruch@tkos.co.il, kever.yang@rock-chips.com,
 sjg@chromium.org, gilbsgilbert@gmail.com, ycliang@andestech.com,
 tekkamanninja@gmail.com, tekkamanninja@163.com
Subject: Re: [PATCH 0/6] riscv: adds T-Head C9xx basic and GMAC support.
Message-ID: <20240327120729.GG3442575@bill-the-cat>
References: <20240327080817.44501-1-wefu@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xUJYdK6PBmbklVMq"
Content-Disposition: inline
In-Reply-To: <20240327080817.44501-1-wefu@redhat.com>
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


--xUJYdK6PBmbklVMq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 04:07:21PM +0800, wefu@redhat.com wrote:

> From: Wei Fu <wefu@redhat.com>
>=20
> This patchset adds T-Head C9xx basic support in arch/riscv/,
> updates TH1520 Soc/Lichee Pi4A dts files for GMAC support.
> Also enable designware ethernet & realtek phy in default configs,
> and some boot env option for booting linux from Ethernet.=20
>=20
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-authored-by: Yixun Lan <dlan@gentoo.org>

It would be really good to see this moved over to using standard boot
and plain text environment instead of adding to the technical debt here,
thanks.

--=20
Tom

--xUJYdK6PBmbklVMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYEC/4ACgkQFHw5/5Y0
tyzs4Qv/f1Qu1poWhgG0TvtwGx43wVZYT31Jn8SQ/pJLq0gN9f4bWthraLWZ9vkg
uCsqh82qf6Oneh1Ycx6OadueCrvi4P7cfmbREc5S2ssr991VGhMiyY5sy8ZauoXf
ZU8h1Ctd75a9sJMBwvcKa1gdqmGYAIBQkeBl0BRFUhAUzlkIUlRuUMg/aWbRAzBy
3DuEo36Y3dwaUNV64SqYoHGeWd+VY4jWFjizAslHS6RA7W63Q4FvLFgEmHl/8xKL
BWBJLwjtPCz4xD7ifE1HgoiJU1GZAoeUjnTxl1D7NnTVQ0vJVG2NUuOZpVLlvNRf
0kK2NYiyNQypSBb9hYwnAKHF2+vp7CGCCsemObsdaupbs91LBvg2IyuxiC64h9Be
Y+I16j7CTbtnfg9A5vYYMjooJM+B7iAticjUa3COLVG14QKl4xKJJ6TIS4WrWIOw
6iAdNdn0cQfvTdofs92t3puUvDZ1AprroSG1icN/SBZGGk732xEIMMwyHPjun9Ec
mTd/EMSu
=1PGd
-----END PGP SIGNATURE-----

--xUJYdK6PBmbklVMq--
