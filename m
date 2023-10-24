Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703DBC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CDC687997;
	Tue, 24 Oct 2023 20:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N0ZV5bHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A8187973; Tue, 24 Oct 2023 20:03:45 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E9A87988
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a8ada42c2aso47828817b3.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698170615; x=1698775415; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j1sBJQ/CjdJxGGKEsZFKeJrY0Q8cGjF7pIiWO0yUkHs=;
 b=N0ZV5bHkOXY2NiY1fZ/g/TweD1XlxFF48cjNIUsIM62cEztkQMv5iEdSOjfBDYKOUT
 pk1e2gZu1e7gGkyUA2QlArGJFejpbn2SZx4dftuX3MlzfoOY67lyh7rHVAJEFLnGIg5Q
 3o4yZCG0AK4DSm3FXGOQcZh68ZoyQ+F54ESr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170615; x=1698775415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1sBJQ/CjdJxGGKEsZFKeJrY0Q8cGjF7pIiWO0yUkHs=;
 b=jNBz04v+tCIcFpYnLjfFyo4BTr1DwVbLqYd32bg3uxNp1MyDK7X/K2Y4Lh+nwbnoLf
 KkCXde4Bm2WooNUMlAkMpbpi054JhONE9yFrOvFgIgKSrlJa9REU1AbaDCwM7SHcHdj7
 S/bTfGWmwValdy1Czudv9pfRUx4aIV7raD0awnqRTVBZTPQ7L6Dji/GtOjx7x7GwjOAY
 PerCg8OZ0/f8rjbnBlCwAuG4TMdLkOk4CnC9D+wtad4r46wllp9u86v9gOJWa4IN54IK
 kojMRk2CC20rUETef1/GKXOQTcCksmmL+n+ip6XLEOiWZd+aTv1c2/69p6jT02nU6C0v
 5BBg==
X-Gm-Message-State: AOJu0YyFe1dqu4cFPrR1Rj1i7z1ydKklosShEIXDPa8zQ7Y1XhFHjq0s
 4qcFhB9+bj0B3gUgllS/eHzBHLe3pVQth3/znayzjw==
X-Google-Smtp-Source: AGHT+IG+r2yG3A1nQ/82FBcOdxNxbHCS8uY1+4XagoR0v9DtjJSxzAc3oUft+f7IQoEAPNOD3qcc5w==
X-Received: by 2002:a25:d310:0:b0:d9a:cd62:410c with SMTP id
 e16-20020a25d310000000b00d9acd62410cmr13800036ybf.4.1698170615405; 
 Tue, 24 Oct 2023 11:03:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 185-20020a2501c2000000b00d746487d6f7sm3749939ybb.35.2023.10.24.11.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:03:35 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:03:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20231024
Message-ID: <20231024180333.GA496310@bill-the-cat>
References: <20231024091223.2193416-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2y6bH/c/1sfWEHjR"
Content-Disposition: inline
In-Reply-To: <20231024091223.2193416-1-kever.yang@rock-chips.com>
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


--2y6bH/c/1sfWEHjR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 05:12:23PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add Board: rk3588 NanoPC-T6, Orange Pi 5, Orange Pi 5 Plus;
> - clk driver fix for rk3568 and rk3588;
> - rkmtd cmd support for rockchip nand device;
> - dts update and sync from linux;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18275
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 9a3a58396b78b1f9d0c14580dc03f81d29207d=
d2:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2023-10-=
20 12:54:33 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20231024
>=20
> for you to fetch changes up to d039b1b551e8dbb2c309d35bb19b7866caa4dcc1:
>=20
>   rockchip: configs: sandbox: enable rkmtd command (2023-10-24 15:55:17 +=
0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--2y6bH/c/1sfWEHjR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4BvUACgkQFHw5/5Y0
tywMcwv/Xf+U+b1TeNHZB94wmHfSQG/jL3AWWWrzGvylhHp4DqIYUyGd7vX0rQ4W
rljSXceLVBUWym4DzO+FgZbZyai2mKLmSL0/SxVNOFgUP1d+1Ddpqc3VjR8OB1PO
GVO3K3x5jgn4CYcswOGytzX00aMvrh+OTBKhc9KC0BXF1U1oEgDDp+s1LN/UajSS
gPXNnu6ak7pgDzqvoJ8YCmU+iKWHLnwEU2DuaLp9MhVOh/xKM2Ex0kRtIeF/4uDB
qDufBtutHgbfAgvMKMdxuRwS2gpx/raCeGGOib8Edf8IYF5Oh+qShTNi7Uza/y45
zLzIkH+xR1GsHlxzXPMwF+HgZJ9h8AVLraVQbwFdW8ptfPv9fJZ8mtsamomiq+yM
+rF52KDMwr9Bn6fBPyJ72K4RWjcA8TVB19ZfyktqM5CGcvqfHVgtKGOygoAQ90UH
qiZnSUrwHR7M6pAP8GLLaD6xegjT4uxPg3jtE56dDskXWcHIShF4qkBXVjJrlVAq
W9iDxoif
=NCXI
-----END PGP SIGNATURE-----

--2y6bH/c/1sfWEHjR--
