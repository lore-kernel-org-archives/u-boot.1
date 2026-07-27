Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFA7C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 19:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56BF64072F;
	Mon, 27 Jul 2026 19:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2q-03XsoP14; Mon, 27 Jul 2026 19:55:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0A5F4071B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785182130;
	bh=FGekDa+drAhQeBO9Bj+mu4zWNw88utopCZSA0KgOLZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=efgDp24a5dDnU6zY9+28fPllVCHSgNViF+lEf4DJhQzx7ArYYIQin0p1al6UFCOud
	 YU5fv7v9v8TlqiTSY992B+HXiG6009NkAwft3g+cypGuPhHxLy/JWLD9CqhjV7t8dl
	 bUzclS/jDgoSbTROojg8J2v4YC7d518jj9/WLLB/1KcHt2oexeTJkCdEKOcOupvSPk
	 7eOBgOx9tjs61K3EDCFwjTuRwsQg21W1vSfb+JEHa7IWcrZuuYR2NYlDtyqHTHAQ72
	 TuFFliVL3vHAHIoNt6oXq/qSeCfXWP7uFmcYPFNw7mnwAVVOwks3RKgb2q8clWTYio
	 lhF0UmA8E3vGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0A5F4071B;
	Mon, 27 Jul 2026 19:55:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DCFC3A0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 479D480EE3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f2nLT44EOGv2 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 19:55:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4F48080EE0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F48080EE0
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F48080EE0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:27 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7eb64085c45so1436595a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785182127; x=1785786927;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FGekDa+drAhQeBO9Bj+mu4zWNw88utopCZSA0KgOLZQ=;
 b=XA89jKUkt48KiD63kJD4aWTpyfntdztoN3iuVCBvvo6gI5JftLOWqIDVzo7PV12kkj
 Q9xaI+SH2VlmqB8kbdhWZHDBG83iGz/EwTfdcXGz9acrTwcEx76KMAR4TZbrYSexeFPr
 YZQaXbKZab63tPPQMdGXNJl9ksuoKuvlq9MDr0Y6FOUNIz6ZdRML30qjbNHxtQaX6q1+
 9IrWdWEJuJGwW2Z4ymGrik7XhmMqx+vvuIi7CZBcjpUq9co+yt3ESWN9AyyHtC5/MJ9K
 xvdiWPLe8+1ntz/Yx7uhNyxtknEzAN+H6Rlpz5+0XyjLHzVu96f8MwzEX1CohVD/H+cH
 99SA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+gyXaWS9SEl5Qvbt3MMSRkYXMfAK5WTfQW9ZkKUQWQVPNDt8Oz91cvZAues2urh7SvejsYHY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxsCW3vhBlQgtakCo8A5Lg1wMpjPFw4wrkoaPF0Xw+f7g64w+8a
 9Af7DR7allLfhuc/Ux3YyuY2tCkob3JZ2/m2+H32aFPFNP5VArycGcbOsTdB5P2M1/E=
X-Gm-Gg: AR+sD11VVLyv4YZd+yS4QVeVuMd2PUOs/c31WqjZBcKEf3CC1iB+/b3vBFNGlc0G8+x
 2VlgoBPfFxKL84m0jLITmkyTQ5vb2VVykXpNzGFnASPLAYAvWj7q22h9gmgZ8HoQ1BVjmpf7r8z
 cn81X3OBFE8LBhG7BacESDqHJTD8lqqX4g97D11CDyLuYMU9oNW6hDRruMNa017YwA/5R/2Z5Jn
 Yv2ea+gb1CBd2zxa1n6xFADjGkedZadX2pGHNpk1o4IgU5eYgrbmdhotQUcjoXC53DzLDQ2Vi1L
 SeYp+cjFuNR5z9HdM8nTC6h/lQzRkXqY8K+zSCjjl/GqoE5vT8nxLCUpJ6BOghv0VJHmB63jaf9
 yHW0LdoYWui1L8XdCa++TjRIfdsgE5t2Jsm4TvIHgbE8LAHZXJkWsu2PgC8jbHYz2prtqkoNn4g
 6sIFEQ/RZh+uZfk3Pr4LywrdxEkafdSxHF9TF5zFeVKQTlKWyvMPnM+nNXi3RyZ4JuUV1Qk5KGb
 CjrKjMDji6P4WDNHywO4ZRIYG4=
X-Received: by 2002:a05:6820:a29c:10b0:6aa:fa5f:ec45 with SMTP id
 006d021491bc7-6aaffa26b20mr5154346eaf.3.1785182126944; 
 Mon, 27 Jul 2026 12:55:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aaf8e99ff5sm6218162eaf.0.2026.07.27.12.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:55:26 -0700 (PDT)
Date: Mon, 27 Jul 2026 13:55:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <leo.liang@sifive.com>
Cc: me@ziyao.cc, hfranco@baylibre.com, hal.feng@starfivetech.com,
 michal.simek@amd.com, fberder@outlook.fr,
 charles.perry@microchip.com, naveen.osdev@gmail.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [GIT PULL] u-boot-riscv/main
Message-ID: <20260727195523.GO749385@bill-the-cat>
References: <amcKeN3QurHxoqsp@lliang-1876.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="93PGB3NPFX/LKZh5"
Content-Disposition: inline
In-Reply-To: <amcKeN3QurHxoqsp@lliang-1876.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785182127; x=1785786927;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FGekDa+drAhQeBO9Bj+mu4zWNw88utopCZSA0KgOLZQ=;
 b=GBHJz7YO3RSvz7sJ5yJxtJIxwGlAhi0HkUincJkA5L01CVVSlbijKr6+PyYTDDkk+6
 palDgAaLviMuBiSRnC2gTTyTZKjHHQqMXZAg3yJeOAxzs2/UqjAj7yRO64v3qveNvW7f
 vFtLR4Cs5TwHHUAc9D+2kYRucfO5mEF5TQ48E=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GBHJz7YO
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--93PGB3NPFX/LKZh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 03:36:24PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit b635d43bca429500cb8ef20aa151cb5773b9a8=
a5:
>=20
>   Merge patch series "fs/squashfs: fix symlink load failure on large imag=
es" (2026-07-25 07:55:35 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@git.u-boot-project.org:u-boot/custodians/u-boot-riscv.git main

Hey, so can you please edit the .git/config file so that it has:
	url =3D https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git
	pushurl =3D git@git.u-boot-project.org:u-boot/custodians/u-boot-riscv.git

That'll let b4 pick this up as a pull request.

> for you to fetch changes up to c201051a9cd3a358cb67cbba9b1c5fa717cf1c40:
>=20
>   serial: sifive: remove busy-loops from getc and putc ops (2026-07-26 21=
:04:42 -0700)
>=20
> CI result shows no issue: https://git.u-boot-project.org/u-boot/custodian=
s/u-boot-riscv/-/pipelines/740

Applied to u-boot/main, thanks!

--=20
Tom

--93PGB3NPFX/LKZh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCame3pwAKCRAr4qD1Cr/k
CtYWAP45piF5VnEJ4P4V2L/u2tI0lJcYVD/HUuaVS4THYdL/qAD/Su6hMjj8DSq8
B20RG5Snq+GNZ/LxpQjYlMKGJnLJKgg=
=41VN
-----END PGP SIGNATURE-----

--93PGB3NPFX/LKZh5--
