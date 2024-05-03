Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E145C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89FEA87F6E;
	Sat,  4 May 2024 00:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F50GKwyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99BF8818B; Sat,  4 May 2024 00:21:01 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C87A3807EC
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c84bb69c6fso62030b6e.3
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774858; x=1715379658; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vy7MBYvs/U9h5xTwRTcJopYqRALAcwMNxYKW19grDOg=;
 b=F50GKwylD5q6V2uhW4QBX3mkwDYWP8sqTSrvQB6wDoiVO5ijdwEqf+kkO4juANfIVg
 KnB2ShB7G78ztiQcklUnAr0h/3tQmEayYS5BEssSkNtCK8xG02oEzW9WzfKBAxft8Sg+
 EnZdjXbPGEL88EizEnxZAzDE4MPpP/lDIJA0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774858; x=1715379658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vy7MBYvs/U9h5xTwRTcJopYqRALAcwMNxYKW19grDOg=;
 b=u6z8P0YxOafgSko9nvjIhoB/j2DZbDDunxpKNtO5y6PKVRcZ1QPe0hnnIvwE+uO1Lm
 rF/Bf7nKK/lJ4SMUDwWnVeNOs75xmKe2IhtKkC2WQFbZFdXZQvXu9+dSQZKQu0HwCgxO
 u/AbfkJStfJKDbRKxvKAiI35UPwZB91JVc8XZkPPJM5U6bdgCHOw2PCwLVkC5rNgP3d3
 XnKJtlVrPV69DWxjqioVmWXHlMdYnrU9PsC3MUdQJhhkIW5QytIJ4H1u8EwicsgTL7EV
 3IiQcErbggRWibFkDpDMZh8EoYTUa745Dq/Wbif1Dec9LAkVKp/Tm4q1STUTx9SyDgA2
 e3KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVisxpD0SHcsUe4hZ4xpnYPIhTzjTcwxSl7qKxIr7tw1mkRLtdWk8Bj7gdHeSenzfS6VLZnUmd/yy5C3ld5NIQzL6ESTw==
X-Gm-Message-State: AOJu0Yxxv4G/Uil6u9AWhABSK4GqdsKboC9SANrwXn7teLOdGBK1F/rZ
 nFQyikQcKDMUKzxdJuM/NtGhH3F+9nArslj6YZ4bhNcxU79cT7wvJk8IgejFrUM=
X-Google-Smtp-Source: AGHT+IFsoKyj8KJm4a47/lfht4qizwnqD/WJm5RNd7P5coahMgztD6rI+xleC4hPd0bzMn2G/HSw+A==
X-Received: by 2002:a05:6808:13d4:b0:3c8:6543:584b with SMTP id
 d20-20020a05680813d400b003c86543584bmr5667583oiw.54.1714774858532; 
 Fri, 03 May 2024 15:20:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a0cf68c000000b006a0d6240449sm1550866qvn.129.2024.05.03.15.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:20:57 -0700 (PDT)
Date: Fri, 3 May 2024 16:20:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] event: typo arguemnts
Message-ID: <20240503222054.GB2568172@bill-the-cat>
References: <20240419113746.73110-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FJTUrWXrcGLdqxj+"
Content-Disposition: inline
In-Reply-To: <20240419113746.73110-1-heinrich.schuchardt@canonical.com>
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


--FJTUrWXrcGLdqxj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 01:37:45PM +0200, Heinrich Schuchardt wrote:

> %s/arguemnts/arguments/
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--FJTUrWXrcGLdqxj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y0YACgkQFHw5/5Y0
tywDCAwAiciOPpO3y/Lt2NohbbC1w+CfD6JbqWjTCBZeSoufvRomsfn0bfjQlNoF
MaAfSaPYfqqTYGB2k+YbedZSp/BzPn7an3ZqQEIZHQyCQ33wSC+WiEJcXGUQphAJ
HmQRxnjWluoL2a4N+kj+EDRs6Ndjxae6CE3QiPpoQ63qqaxXHVbjvWgre7T2R2qm
hrKSksaEeYNNhveKlEn43WkfFNyKtXxCeAg9olkgN8O2XkgllgCyAGiSf2rSeIw3
8qSkjtHeXzD03qk3QlWs+NNtYaw6jzogOXkdt68KyVXp8PB1C6JKPVvCd/Cg55yO
9KEr2Gem/RXUHzaj3wLZInulwGWW9QR9QHjFDhU1PVUrZUhGqmermvulS4jv0dNf
aVDJYTclBEOGbp4fyeyELGd/YFvAmxkKs9O7TNFDbIdTk3QXyxD9dLw/tam8UBhd
42l1QGoJ7nbBOaXNEHWNneGEhN842wym59phOBAaCzgQNQoYW+oOIO//yxCTOm3B
UuVuj5JA
=OjZi
-----END PGP SIGNATURE-----

--FJTUrWXrcGLdqxj+--
