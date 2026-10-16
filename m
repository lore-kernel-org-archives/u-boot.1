Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BFCCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 18:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A23140B86;
	Fri, 16 Oct 2026 18:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5nlUjwYCbny; Fri, 16 Oct 2026 18:27:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E463E40BC0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792175222;
	b=KoduXTzO879Ds+IMPDYJIrSD+HdDU3sGTDaJPGQ6whPTnt20XDZA31PHpyqLczKSv1p0
	 RI8/nGyCKhLcXeYWueFHcI0QTsJA3oUJtpKJP+RV3UuFavJI/b1fCHNPHsUOAjdFSow2r
	 vnPRvNNgmOs9MH5MY0LRCS/U3iF4ytyxuLuverer9sE/cUZlzyBKr/p9KhkJ+9B4rohju
	 Vbf+qnSHvWC++6TqWz/3GViWIVBrHaLAaNWVougMkdX6xa8jldxSczLCYQJwyrtVIsuW/
	 SVyzuEYxsKZ+v1dDBDf6DVCSDNMO4qRMNE+AIfzfEDnETizAfjfeNLiregNY2CJtJMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792175222;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=H0hrqzbIfiIBMI2nhszhrkwrYztBLDGf5V3BRlrVN5E=;
	b=oe1DIlAglSFtJIy64XP/NDM/EVY9acN1iyTw04u32Wcv6iifiVvgPM225l2S9vgJyPb2
	 ZMEEmp3aToVBdTgYAhMajcPG4rlQDECAfah7QEV6Z6Ocq9pyQ2/Z7BnbOAC9vtsYXRerw
	 Htb+Sme7qKfG22tJ7pbOdOIl7tsgNL9QfiLk4/z0FXILI/qqgbjVlwTLc7eMQnSF0jCSR
	 fHDMKvW+L/1bRO2PVhVxshV0RbHNX7Ul2Y0bAiQ7+gSusBejmar3Eot3P+rcPb136kUSL
	 VNbEzNyNFmuYLHlPsui9+nU5cvsmAH5rGgy41Mps3mfk9FDzsOFMdsINSTBpFT69stg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792175222;
	bh=H0hrqzbIfiIBMI2nhszhrkwrYztBLDGf5V3BRlrVN5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jrK5uA4Xuh00j0Tciox0l7/MrUAT0VpAHx7GSWVSWVdv5htYm9EvW8uEPI/JU3pdZ
	 9qFKjqJa3GIB8d9G/f4E4hG2LaVfFm/drAbNHbZnjyDISvXZKkYaqn5B5ZisFhbq1D
	 uiqG5+Dlkf5e4DwIoi4B1wgRx0IL9zoY2O5d6g2pNrbQwInz+iXChY9TEMJCAOYo+X
	 VPeML4+eal8zECrYkmjHE/9liRws99cCWiAusybLIpG8srUkYWUG2eAX7yWH2zinZm
	 c6FLEOH3a3E7K7ZJVUq0sr27XAt8hu/Kx7kj/LydOpyZyc4KskmOG78pcVcm+B+e5Q
	 J4S8Qz5p9m94Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E463E40BC0;
	Fri, 16 Oct 2026 18:27:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EA32255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 18:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 305CD60B8C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 18:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VJOGWSVeO7e7 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 18:26:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59EA360AC3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792175219;
 b=F7HwiZ725YDodEoWcBBpIqd2WZoC/6/QOhKQkSlhoH8rHDL9FoISwQhJ6zTKGyBiTHL5
 kY57NYCa4yzRNI3JoiDmnrgDgx4d5+l3CcWMZRAjfwppG5jx+zh5eFEYWjufJXjY/+LK4
 AHmfymgpIRYZCHPQTcJXvXT2gUhYALn60mus+ggaxKqO8ig43H03fL63pnEZp/WP3epeh
 I4N0MsXAfPaYn3++re051QdNHsRVwGei0b9r/+1xRamtKYi+shdIpOmHOkP3eBzHmhz9P
 SWWkTGW+oVhpvqAmNk9mkfA20xNQRt9lWGJeyYg+IlXecv816lylTsPgCReiMLPcysQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792175219;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=H0hrqzbIfiIBMI2nhszhrkwrYztBLDGf5V3BRlrVN5E=;
 b=RqwB4Oyy6Asm96wWbbmlURmHQvOrMxn0TMtHMZnO8kjzVEAR0AOSiraDG/lheXfvzl1v
 BNvdZzD1R3xBuANxiED+ibub2OGzz+PhYGO4x1gLtrJLczacQR/wy+zjufxKTRyHdvSDs
 S1g2GkDbsOLVVTMALptCI3IYxrWDyssyoJbgDkbKiTQnexMsLZfex21gdzmzdXlq0PE9X
 EOCaG7kAuWotV6Jh2wZ0lnd83BXYKkqo7CF/kkKOSzsvQVbJVe3JDBbTW6mbSWfpUm5JS
 fQeYz3VcT3bigkbYePyZbLYS8pkb08nNtOube1qoloAkQbJHmRUY+HauLqQCly1efOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZQjAuiRS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZQjAuiRS
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59EA360AC3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 18:26:58 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4c5d8c7f326so136962b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792175217; x=1792780017;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H0hrqzbIfiIBMI2nhszhrkwrYztBLDGf5V3BRlrVN5E=;
 b=ZQjAuiRSvEMVyUXTnHnIN6hsxUhJyBi01ECKvQNfPaRKUZNV4ur/7STtiZ6ZoSYlmL
 unz89FuvSvkrRGo37sNnyb+JbjKgURGZO1BjSp6jMBEuTki23tUNokPtD+kYtbiosqgb
 P7sjNejQ/S64s1tsKC6mRi/gyQ3lJnn72gBoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175217; x=1792780017;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H0hrqzbIfiIBMI2nhszhrkwrYztBLDGf5V3BRlrVN5E=;
 b=CFNLRi0pzUIpm+kBj66KE7ArpMjY5huLOB0fYgOnJ/WUbzAzeRl1WRK2CR4zd/I47S
 V6/aaWm961U/Iix1OgTjI5DZQsTOFn7b2dHMyUMCJ4mutiUr3VMv1/tYyhPcoy7PTLOq
 u9QRaNj4Y6VZcmRSgw+vF8PqlzBVCRsqpFGlg9rGtbsjsME5hxw/FUPlWgNq1hQ409eS
 O5LQv4yNf/Kcuc9QjHxJkf/r/WcB1jGGkf9qapMiUtZkhzkOp5ndiRFtYKJBXIpT9Hi5
 RnI7GRHJfyioeHdOSTewVBFb5+FlLb0VZV3WBYLGs3kmseKEQB2WoWL06doDfvqhf53u
 iQLg==
X-Gm-Message-State: AFq9FYLgsxfdBjur5K/C9OGDgWze3uwSaD+12MQFWK72MFA9Ctt0Qbr7
 3/x6OtiXvHqCVMAB3rSDdLmQZCQ1f4txkVGTvpjCuhtBYEO9YZaR0cQwwMSmGz5ZA7Q=
X-Gm-Gg: AYBFou2346g1IQIiQYlo3H87N9jlNI02XUIgTrIK3PF3mMUI/FPNue2EHg6tX03Vrpw
 e7YluNsiqjvM1Ny6Q+JVcriW8n9SeQQb7G4+9jicK2WQ5L0mJ/RhGKE7pkGSc5FZQXCz4lIdgVB
 zgI3iwPRDGZA7FBBA+olQa8WFx/uVkUk8jhXG5l0lP3ddmQR1ftxuaCk/cBfByxt0SpKDCljn89
 5bI3mXuVQ7U8mXX4HpaSmtXTs898vRGNqIA0OvzTidKM30ihO3wFnLZIJj8Rnw4deNTaC3fR059
 erhjBnZHKErAVZlf4NQPUrqGMTjDycUJOLbCKcaeLaSAWYQsER3FFw7N0ZkHk5UftoQUexK7ZGR
 suJ1hv3GtEoEX6sNylv5a7VYMOiqwlkCsKLDwWSUBT8Ih/Djlt0JimBS7dsZ5R8DhosRDUpARUM
 jFyhbrx0/SRYIWFXeJlmdf8vDPf8+EQ1hk03N4XLSEJxwHbx7/BPyGXuMTf+VESwH7N+s91FW9r
 mLwDtJV/nD6V5iX7qm4o02IVGDn+r3cYqoMbmKBWiiJXuvfTucl4dxQgaWFJCp1TQ0yA3sjYhfi
 QdktdeJ3UpRXJV+6EOnrmDB85Tw48A==
X-Received: by 2002:a05:6808:1645:b0:4b2:8e1c:5920 with SMTP id
 5614622812f47-53cc3e3c727mr445759b6e.9.1792175217608; 
 Fri, 16 Oct 2026 11:26:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b6e425asm2333206fac.14.2026.10.16.11.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:26:57 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:26:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: u-boot@lists.u-boot-project.org, Vignesh R <vigneshr@ti.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>,
 Fabio Estevam <festevam@nabladev.com>, Eugen Hristev <ehristev@kernel.org>
Subject: Re: [PATCH v3 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Message-ID: <20261016182654.GA4035800@bill-the-cat>
References: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m+rvQJu7YYUudmm4"
Content-Disposition: inline
In-Reply-To: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
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


--m+rvQJu7YYUudmm4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:43:41AM +0900, Takahiro Kuwano wrote:

> The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> specific fixups. The spi-nor-ids.c has single large ID database. There
> are many #ifdef directives in those files and that negatively affects
> readability and maintainability.
>=20
> This series, as the first step of cleanup, move SFDP logic, IDs, and
> fixups to newly source files. Reworking, renaming, and reformating
> existing code is not a scope of this series and further cleanup will be
> taken place in follow-up patches.
>=20
> Here is the code size impact when applying this series.
> Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> manufcaturers are enabled.
>=20
> SPI-NOR:
>             text    data     bss     dec     hex filename
> BEFORE    720685   14084       0  734769   b3631 u-boot
> AFTER     721827   14156       0  735983   b3aef u-boot
> DELTA      +1142     +72
>=20
> TINY:
>             text    data     bss     dec     hex filename
> BEFORE     77399    3128     248   80775   13b87 spl/u-boot-spl
> AFTER      77589    3200     248   81037   13c8d spl/u-boot-spl
> DELTA       +190     +72

So this leads to imx28_btt3 and imx28_xea overflowing in CI on link.
Maybe it needs the tiny flag set? I think the rest of the growth is
reasonable enough, and boards can disable part vendors they don't need.

--=20
Tom

--m+rvQJu7YYUudmm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatJsYwAKCRAr4qD1Cr/k
Cpv0AP42f50JtWRJOkHLWmDitXqKcIWopBknczq+vLIc4IwRbgEAyvUdzubchAQH
ncmSAVrhvQeLLlB5WFxTeVBq5M0Cqwk=
=1fM2
-----END PGP SIGNATURE-----

--m+rvQJu7YYUudmm4--
