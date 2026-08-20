Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AFEC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADB7F80F66;
	Thu, 20 Aug 2026 18:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzDK04VAO5UW; Thu, 20 Aug 2026 18:56:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787252189;
	bh=PQuZ/OoZGeJ702ThsRHLQ9JxHB1mWszalQLNz+NJqw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fMol0RPfgD9uf6NAcPLdYdxkmhlxtomQr9SKcuGMO1//1vQYd9mt/D2I+j9OSvyy6
	 W/a6ui9TYSfApHi5Lu7OlU+0Qkq1qv+IPcxTYiQ/vN5iKV3QpcsP+KZ6Z/etUD34/n
	 PiV4A9psK/8auLxQg5Feny/hNwc7WWxXD0P5+U6e274C+LuZIg28U+5kpMbBHuNMQV
	 /lA8vp1X+KSDIHgiD9PfGzCJGobRsfziCSZ+1J6Bpo3toRwCgqxPeRIFJuiHbFi6aa
	 HdYaIfuznEW8rvoPIMCUWPiWX5B9TOSRID86BhxirngUxI6W0s6yCbCMRUSSX1rduX
	 4u2rWg7wLdNdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAE5780BB2;
	Thu, 20 Aug 2026 18:56:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B63A54B8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9793A80BB2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:56:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qr3C3H6iC7GH for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:56:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::2;
 helo=mail-oi2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=BwXsHCry
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE5F680B83
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:56:26 +0000 (UTC)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4a49b13b745so68290b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787252185; x=1787856985;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PQuZ/OoZGeJ702ThsRHLQ9JxHB1mWszalQLNz+NJqw4=;
 b=BwXsHCrycCMCgk1t8+oTbLZHYZ4+Rq03spRnBaM8+DdycYWGnT5BYgiUfJmYp6r5I5
 34uEixXFU/R7xfUvJkzEGUjkjCb3bFqj9EKqaJwY6ZO6MhyyT4EiyarviH1a+PwNdDA5
 3oCUWYeywFLd8PVrtDe5wn9+2aqjbqncCJaYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252185; x=1787856985;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PQuZ/OoZGeJ702ThsRHLQ9JxHB1mWszalQLNz+NJqw4=;
 b=mHSJeFM19sHhNAyhKC5zFMq8WaB5XXWt1XWbU9GePTcqJydV84XfHnuM9A09p7dMvm
 AZHj8e968w1U9jUHlfZFMVVxcsdg3xRs/xORbXqs+WAh1yX2OYoc3zxhMf3QL3jIpDJn
 Dd4dOmqci5EgIQ8fyls/Y7TfJszcEZo7ZOZOWSjyP9hvyJqtGFb1m+HR0qzo2oxix802
 omWf5vYIlRvq9Ej5JkBOABDo3VicEibzbJ9tTOJgJdrlMrQxPRXLx+02pvxb4XNwst/7
 VTUcJiU3hLrQLIT4RyHrynWc5aFYuZscemdkUKwdjcRN/D7z1EpEYB+cGRJ9m3M3x5dO
 oxdQ==
X-Gm-Message-State: AOJu0YzJZbCu/tOsMTVZh5RzyVY9rEpH+a1UG9O+4Z3BIAKaE0SMHqfW
 FOoWzBgQ6IIqTi0NlWaOaTpy3zfbQYwfjvMuShWwdL8+C4Kk2n10PIybPwsRCTWs9tWDC9FNsdd
 FVgXl4UqQSJ/B8A8=
X-Gm-Gg: AR+sD11vjLt5tIUgBFzjXpj+FW+5De+ounh2lXawkPImtERLz0uvCO6e/auUrRvj7K3
 CdWj1rSZTpJ+v3pjZjATjBktQVnvTN/qWITgz30yBmSWX+l6LGJqEOlHZmDudrQX3nNomBwSK88
 905ZPSIihlQHUUU1/BsKiaM9L3IK1lRXNPIeZkXIki7LN+suOdExWpGES6l/uJYFijUKsGqmsji
 kmoZ0kC1IlAShB/psMKOfrZFmpqXwdhhgUpNCFWEm59pM+yr0plI2b+ZGHpWoB4rG0IB9ndnJWd
 RMea+yYUMQYAGTdNYaVzkfHCLtfbnQSbD/5alrHOGbpWLbffgrcMgqSfIYzLiDjDyY5rbjOUZjW
 uAMPY/o6WJ4nJsxHElhDOj8ekh6wE/LkfaJhGY5wW06N6QSGE7h4dpKG0Op92bUSb298QPCD194
 Y+wMNs7R5kq1IYC/F+u9+HQMl3G5fMnbYUa/0jq2PWxTcBv0KaV/xw7yrePLRunNuKiQTbvGueh
 a9d8Cn6+eaRk5Jf+/fk1tPKhEobozlYiPHA95EMyDaWGMSGyXkcN+S0YBIDWfz8iZC+mXys2F06
 gWZROBfhUQ==
X-Received: by 2002:a05:6808:179a:b0:4b2:8d7b:41b8 with SMTP id
 5614622812f47-4b2ef430673mr131552b6e.18.1787252185235; 
 Thu, 20 Aug 2026 11:56:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d6ce0cb6sm2343094b6e.12.2026.08.20.11.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:56:23 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:56:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PULL] u-boot-sh/main
Message-ID: <20260820185621.GJ523975@bill-the-cat>
References: <20260819111522.9235-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6UL8nph3Ky1BMH3+"
Content-Disposition: inline
In-Reply-To: <20260819111522.9235-1-marek.vasut+renesas@mailbox.org>
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


--6UL8nph3Ky1BMH3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 01:13:05PM +0200, Marek Vasut wrote:

> R-Car Gen4
> - PCIe driver fixes and switch to generic firmware loader
> - Bootloader update and switch to distro boot command
> - DT removal of duplicate nodes which are in Linux DTs node
> R-Car Gen5
> - RSIP CM33 remoteproc driver clean up and pending updates
>=20
> The following changes since commit 527115ef6783cec49e5610c523c124b3990113=
61:
>=20
>   pylibfdt: Replace removed SWIG Python 2 compatibility macros (2026-08-1=
3 10:12:41 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main
>=20
> for you to fetch changes up to a8097d2dbdb33a8b9185d20ce30712493a83b6df:
>=20
>   arm64: dts: renesas: r8a779g3: Drop set VDDQ18_25_AVB voltage on Retron=
ix R-Car V4H Sparrow Hawk EVTB1 (2026-08-15 00:55:43 +0200)
>=20

Applied to u-boot/main, thanks!

--=20
Tom

--6UL8nph3Ky1BMH3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaodN0gAKCRAr4qD1Cr/k
CqMyAP9wCacWGvqAhKOuFfgicy7r+NedXk+kK0Iks0XyCVka1QEAgpR6H4CuC9ig
ZjiyEsT0zJQ1bx5Ejuq2MeoUXhcjfAw=
=/st7
-----END PGP SIGNATURE-----

--6UL8nph3Ky1BMH3+--
