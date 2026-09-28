Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81FFCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 20:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C9B26064A;
	Mon, 28 Sep 2026 20:11:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeUzc60H15fU; Mon, 28 Sep 2026 20:11:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E6CFE60616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790626281;
	b=Bi4R6W2MHXerjxLDX4uDxIa7NJBeHt5bX3M5pyKeNUIlNSJsTdZ3BggpNhtTUEsyvfEW
	 5R8V93SKC2kv22M7dsGi8SzCwnI4SGsNTT2fYUSxWxjaJpK43r8GnKROgx8h/VYAJYYPc
	 LT1Ip0EVM3BEJEEkNwUP8EScFIxPbcmY9h8zurbTA9ol06+6tQ5JCMbz6Rfmi8f8kvAVC
	 9wGkiZpLEtBLuzdHNYg/DyFlwmx5oyqLYr4DlTdEAxMCDtSuL4FI111UkhTkS++wHsEif
	 m9eUcwWYSCoVfWw/TfAGYOwWb5cjszMcb3qcHmXZJnEY1yb1Ptni/bWwSLzYHYI786Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790626281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AemQv55jxyU1wmlyqQnSFlT4mmtXYFZtBHSS16b+Tms=;
	b=Vskkl8dcCvDg6Pm7UIVu5uWw6IHnRfkrnn9xrqiMcl+FYJ2Thg5UF5FtJacn4OgBBObQ
	 AY6zU4lPsR2vPI+yLNqPt+2ThnuAqJpxXDeiePXBAoTwtNVCzC0YDEdbJNqs2uoKTaUkq
	 Fmq8hzihO45F8L/bgDpnamuPRegLBnMY+a3rEARJ1XrlonAuQPGRx4pROlUIJyKtHUEfY
	 IZX0LpODAg9794C4JhRejK7fYzSnW3DCf4mZdzc3ubeW+JFsSRjlkBRxjI8szvVEAY3qv
	 c9n0Adf0z4zErRAMvJzqJE38JgYs4soXC1zVHvxItGAO1gYtvFH4J4DAFB1/LJ69N4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790626281;
	bh=AemQv55jxyU1wmlyqQnSFlT4mmtXYFZtBHSS16b+Tms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hcam/AGor/+V2Jx4QuwZYjc73n0fhezUL0WSRmlxVDr/BgvR3lqdqYCU/FcxdBMGP
	 m8FW0kPlYq/Jn4sx4Ef9EFkbKPocG9rVLjsIqL0b5nXWT4TQqny0qGj2/Jo3Nyrxlr
	 qdflQUy7zAbTFFF2r5MPfQ2i0dzTtitTCrRU2ccFhKsSot++W4zfBLdSIbe3qwIceh
	 TqQBaKCXJviOSOUUpcDEp+t6jQfR2yfg4xAwOLenPvu9AEfvjijsXjZuL4g1wLM1eo
	 XTHZThwZHzTR8pYRffHv+3CgW3fzURwpqZqgZ5rX/jSW2DAaTYyIqtWl8QFu9P8gfY
	 8qxH//xlAToWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6CFE60616;
	Mon, 28 Sep 2026 20:11:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13A8C147
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1128580AC8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t2AJRenjWUbg for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 20:11:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3479B80AA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790626278;
 b=bw66bwMM6RQyg2qN1bhgTin/CycguvmDmRYv8plyGeIwZ4QzJe0pWGamkZRHkFunUa2E
 7zOU+INW8jsP/WEhTiNDqSwazoiv43jAmF5JWXcaqzmczw9q0DTy3AZoyEdomY2UBW/2q
 kq7cIVPxGMoi4gV6ZW6Lw4X4V26wVwjpZ+zKQ29o3Dk6up+CDzdiR/RcRMEbw3WF9QiF0
 S+peOK/3FrGj79yDQFiWvFraeFYkcfRDNZl8yNlYASdHigeDM9hw0+BQD/dUG7AjsULYU
 v3MzIY+7SyvZA0D9/MCe5LeY0iY27Vk2sRHQSOxSf5FcPBS/lVVRvJhsAWRrF3fSQ2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790626278;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=AemQv55jxyU1wmlyqQnSFlT4mmtXYFZtBHSS16b+Tms=;
 b=FgXs1jxu+veiYiArU94bPqVPF1sQj3Bh0rddXw/cYyji0sa3APBzpjIWYA+sjbiHa/+N
 Iqb3+6oDzHLY6u1UVb+e/zSlgKPGuyE5iWt8mNPKNV+j9y+tMLpNtzA0viPFm7bunaMVv
 EPMZGizalOhi2Xc+i8LaqNAXztiVJK5s2d5DsAhwruPo2gbeA3H7ySmx2UR9/XXP80sVL
 yGC3Ok6xiwAjIDdaadB4+k6+DR16r/eNPUnlfFTY+FY3AnMRiyW7OMB7RHI4p5ANYkA9m
 QyNuNcBxOHfj3ZQCscDfDtV1AgoJjaNuFu/ZRewSFPDzXhOSoJkoKh6oTo9JDTNEw8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=auT9O9+k; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=auT9O9+k
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3479B80AA6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:11:17 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6c72bd8a017so2125443eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790626277; x=1791231077;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AemQv55jxyU1wmlyqQnSFlT4mmtXYFZtBHSS16b+Tms=;
 b=auT9O9+kdoqRXKSkVCRpP+cyGVAAPWSo9d7UJONLoqNrVcycqjzkSuJmbosx0yJB33
 gdnt28BUIqehosse3EcOGrsMjYF75b5iLFim92RyIkx2UK40GxOYFVIdhF/PEl99HK7Q
 9WpZFG/JWpVpBXP/fpedpPGZ8MHE2fcetacZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790626277; x=1791231077;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AemQv55jxyU1wmlyqQnSFlT4mmtXYFZtBHSS16b+Tms=;
 b=eiaNsvE+LP6h7Jwm4JYkCoZfz+XSoXjLXhpubGk2sAjYhbcKyzWIIVimUGE5NaK2Xl
 Af+uPx24PpZOaudAPPgH04zKpUxByvrhFHGr68ivwF9K7hxMzA0gjIGHNafF+X4RFvCK
 H7chQi3YWnsdtacU5OZ6D/YQLaRGX3wI13tqXqzoGZD3+LfA32OCDuggHgD357VJ6OlC
 qY7m/x1PC6kQsin1Ah7KpxZ1BzbwkrI4dLF7z/T+apcd8IRPwKx9eFiA8rzp8vntZMZV
 kN3yTh+KfJ/ehSi4+38xFiLgT5B5kcCAp1/cuKKWVPb+M7Rv7yuMO8MOni36TQt/Lr0I
 97hQ==
X-Gm-Message-State: AFuF++lEZlJyat79UfdrgIwzW2j0SCYqzVBISC5yJO2IT+BSOtlKjHkh
 7f+pf3+WKqPLvG2C4Yhl/tHujs8emdqd7NtN+mYkbCDfN3yDYxFDdA16QhLv8M8WwTs=
X-Gm-Gg: AYBFou0NKgeN2ysdH7pzgGjXW3JAM9qH0NEKwvGR/22BozyEWD0MxfTqMC9khQnpCht
 yIZkA0rrK68dfPovTkID+XbhYY6BoNWoHO5SrN7sEz2bkTxjvbMpXvPgfXdrKpo/YF7kVRmNldG
 brooePcEo+KrxAFFXWeHQfLcB+lRf5VAs5K0d7/kXgqxVpb+quKF0HLBfMObKevUUanhoJnQd+G
 dUxdmBC20EOddcOleA5nq1PVLXb7KE6WjF3pc9OIAzbGpbLcYDX0zK+G4h3AEhZA85hcyAEHSjd
 0ijKB4DJVML89ygea90yhSFQFgQ1a12NS0LF3IicVYr+wx+uiAUJaJbJSd7yGEpWDFrylGYi4Nf
 +ruJzGZhD/HoOKZ93Qiq7lufDqKmobTvJC4rXZCqVUsSLaaNTGmmi5Go1ObCbvDvL9ExbhHDvU9
 0xipu0vJQ0kQq5k/GHpHNRN2cMyQBtl3RLcymyq1oXiwwFrAuwcm6kpZ6c6wBTipCr21tOE8JBY
 KyZfCFJ1L+8sq4EclH9ZYtyCv8y2BYg4sWtizFbOaQSy11IV1ZK/QnnEa5i6Msnr9csOLK3xyQL
 GVJS9ovyrf9Ie0p1OXA=
X-Received: by 2002:a05:6820:1c8c:b0:6b1:a8b3:3b43 with SMTP id
 006d021491bc7-6d43f2c5a68mr12056025eaf.24.1790626276741; 
 Mon, 28 Sep 2026 13:11:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4933094a74asm10657950fac.0.2026.09.28.13.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 13:11:15 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:11:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH next 07/13] powerpc: mpc85xx: Allow LTO
Message-ID: <20260928201112.GQ858934@bill-the-cat>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-8-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6fuzld6LZ0WqCy0j"
Content-Disposition: inline
In-Reply-To: <20260928110434.70686-8-pepe.schlehofer@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--6fuzld6LZ0WqCy0j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 01:04:28PM +0200, Josef Schlehofer wrote:

> Select ARCH_SUPPORTS_LTO from MPC85xx, so that boards can set
> CONFIG_LTO=3Dy, and name mpc85xx next to ARM in doc/build/gcc.rst. This
> does not turn LTO on for any board by itself.
>=20
> Only mpc85xx is covered: it is the PowerPC family whose linker scripts
> discard the LTO keep-syms sections, and the one that was built and
> booted with LTO.
>=20
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Marek Beh=FAn <kabel@kernel.org>
> Cc: Priyanka Jain <priyanka.jain@nxp.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6fuzld6LZ0WqCy0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrJ3AAKCRAr4qD1Cr/k
Cml4AQDzAKaoZsasE5tZycEm8iyOakXm2fAAEgC+BNbtPBLCkQEA4Mvtx8dK+OIx
ARZfXq8B9hp15CkvBFvxYMN9+D3yogU=
=kPPe
-----END PGP SIGNATURE-----

--6fuzld6LZ0WqCy0j--
