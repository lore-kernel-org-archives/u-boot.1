Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE80CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FD8180B49;
	Mon, 28 Sep 2026 22:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ake4HeB51PO; Mon, 28 Sep 2026 22:59:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CE3B380AFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790636362;
	b=HYOJ1PH7CPrtUWJ2c15BgBgGBhw/wppu8fKFVUKJ7w4ZDtQ7k64v0WnmwK+F6AbVY9mj
	 ZLoA3yS7ZM5Yecy/qI3KXdRwgIswpXpvSX/UCiftHdR5a7TvAARDyocCDKLU9/atuQS9Z
	 RTZlHa8wiIAgHiWjta3UEh5vdha2YVmX/o1weieX07PJ4/n3nCu3Xu5ffR/xBTmQI2WJJ
	 WA0Qb58rF93yQaIy5137TP3tMlLOSw0rDXSc3uLXl5A4uALlo2gepZ3cs2qogqyYLAQ+L
	 EJVGYohy/ox+kaHYpOyZ3TQrpOzxgYgpMhV2rV6i00LzseT/1EWqlf5peUDic4fYIfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790636362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/ABovRiX8NMuTaeVLzCzU0BrTA70dfxHD0QEbxCyDNY=;
	b=LfhzYIusrMUS92RdT0ruq/EBcuiKJ+J/kAKcwY9ypoBDfJocaLNxQl0OeIXLaJhdwrEZ
	 D1yuCgukMCjFratArJOookzlaLDsIuliH5uIAD/3lvi/9IEs7Dw/oAAKrDaNLz9KPkGgM
	 Sxzl7uXPbsELUCqiwvz8F1MX63iyRXas6FR6za9cy2YMjOQU/RqiLmubQGLcw8XXPIm8Q
	 gbAHyKGs3vYFOmnCcb6HZwU168lxmudl94naTgC+eptW316GcKjpeitxX3fRW8Q/L+ywa
	 dowR7GpjLsf1kgCeRGgQFZUMPV97QjGKZ9a09S2SGdtKA+b6M+AQ/7iNoPz8UpB6i4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790636361;
	bh=/ABovRiX8NMuTaeVLzCzU0BrTA70dfxHD0QEbxCyDNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lol9AmNodVMe4WmZQOILyTzaV/jFvklUyFdIRo5P3/2XbhDx8Mg5LaA3s5ToSozEg
	 L7YSEviU1R4jbrtK+/1QG5iJg6SOAPzUDyEWFw+rBdzdXYb6io/n3IQvzPM7SPX2S0
	 zLrWDcnqtWvpEhJLwQnVtj8ggeQzXdIjvbAOhiTLn+jJoc2Haw6VpFxT9VUD6eADJh
	 h2UFuIli+rO0ZHYKafl4KdzgE0MJc6VmVKEMVvdPpmEtJ8Xob2SdN8ulWC/jOkWP4n
	 4yRNTHMq/jtAM86bNY+A3daKfSyokfELQsf1rwno+Xb/H0T5Cux4QOJ0npmdDTHtpP
	 g5Y9Fncc8uH5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE3B380AFB;
	Mon, 28 Sep 2026 22:59:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 798B661
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EDC860614
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYFXn_VRgHqJ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 99E07605E7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790636359;
 b=br/mASsy2ESLvxoQrf493caKpmtpnWm/+9zMzXHul+KXr6OWm6MPw4tFDGtQsHomFW1L
 CVuZdp2FbPKFifLGsYa2f5vLQRHNarjCtEIQ3Y1HFVWqp6InHAwqgSaWxyOXQd3wT4I9t
 IynM24TmyIrNwdW/0HoB6P0k7Mm+mcPm6gHjXCfDip0oeABZBkWciDI76q5e1+sY6ATyR
 7vk/OLC0xh1dllZ9sKC/vvv5NPlfo2my28ggxAcplZBzaz5EHCUm5MFMN4kWL4Hn3TdAn
 Ik2Z65qMEuXqKEOQWBwRWnojNqxQy8T1Tk9QjuVFf8yiSmRyvGMEMbZw/E/ohONurnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790636359;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=/ABovRiX8NMuTaeVLzCzU0BrTA70dfxHD0QEbxCyDNY=;
 b=UQK7UnWlHPOeJGNyfs390UlPoaze/j7JFhby5ajNKIV2NXF1wT/TSSyeSmblOld+wWBQ
 irmO7iwiKtCSfOc8dxIaU1/nb0IVUfWsvIIIAME+1Wz5thv++LqTIEQrtxINyqSNEgFd2
 EyK0ZGbaeGZwB7IsiXxBAPDGVisew0LBRnFraBlacj++sTXvfiIraHzVuhEwQJnrInKEL
 fEPvwJuJvS6dzIyOrMrm/6jEtvaw/Lp8kTp2I9CXrfF6fU7WbVsDZ+GZYXJVjm204c4uy
 Nf7q3qNBabXqq4K+TXae+XLY7scvzEh+dI3nshV5JkoJ25WyT59k3jOKUwrMEEbbmnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NGUntgRm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NGUntgRm
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99E07605E7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:59:18 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-8177a7fc354so1896383a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790636357; x=1791241157;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ABovRiX8NMuTaeVLzCzU0BrTA70dfxHD0QEbxCyDNY=;
 b=NGUntgRmFTUCu4/6yG1XRlUTJMcFd2l8yF8E0aIFdpNXOnQlr7x6lTYcQ/0YyYUKRP
 cnO/HsZorndknXpJRkmSIadE3v7rW6m+HkLXStegHsfCtyvMKAfcH33QNtt21YXXXjGs
 XMsTCVu+L20AoLG6TZAggIoJbQlNo6AA8Z85Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790636357; x=1791241157;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ABovRiX8NMuTaeVLzCzU0BrTA70dfxHD0QEbxCyDNY=;
 b=i+yId1T1nFNb3dbsFYBlcbPoyEX9HCLfYvlSLu+x3OBjfIOssaSbbkrQ5pzrh8hqFe
 EobIccH+ndIHTASf3FbU5zFqcxA0Nf/yikmDkukaKcN08EyTJ8+GLWguWzD2IM752nxO
 j+vLJpKxr13bzYyhF6o3Cm0eJOA3P3Wm06W2kPPzQ9VM9MdIifNHKnLMPAyWh+gz0GAo
 jaAu0wsxv5OGyYFt8mfsXyNbUnHpzpyxp3eglSxNfwMhYFamcYjZSr303kkMp9GNyt+A
 Ky1E5I3TlIpLi7vSRgoL/K7Mxn0AHo/qKLtZWGlk10+P3m433Jm2RI2v4GREVE9CHVqZ
 WLjQ==
X-Gm-Message-State: AFuF++lIjrrf5hNFYaC63Q4GxD+4vU5bhoDlgJItUe/yS7ZXk4pKYM1c
 jlpr/npt6255ib3fooVs/wCUMeiiWO7Q8QZZRTR3AtJ9TzMEsgJcu06+tH+7WvaHp7I=
X-Gm-Gg: AYBFou19mKVpqEtHT6Nt8l75UC/0Fo/Qn+TQxfRcssgJka6riwcl47GvgVqiipiyhtZ
 nOtjqBol5y2eEfDqA6l8kzvmLBld1MWVMYQzaUitnXhYHo24Ydl9hLNDw66/OBsGX4cud5ZP5/9
 Jq4ZWcSQgbRIM4auOj17ISdtGNiIraRUDvjMWpIFVWt3YKamXw7WhE5ZIXH9oX6ZFhG/4PMb5dr
 KKIqSR1oR748oZC5KTFpBVdVibQ5HAdX6rBXNiGZlajZaGoE+VLNPhSs1QJeUPoIiKXoeRnXIM+
 9bqG0+XqO6vZmRy2YzXg1sKOE8Bz0CwZFHbaUCYyOeNo0/3HGAlFed0r1c1jJL7TvIDyKhVZqtR
 tp7kIqhtIWRYm1/MonJmjka4AEKhfvgnbEbeYPtgLD96s14jqxZqWkmt2ZmfonOumOHkl4oYuvM
 p98zt1TYJ1GjJmnFPzknOtmgBAHO3NSCsnE9IOzxL6gIwjtOAy0vjbVESE64CIy6KUFoRFJ4Tox
 wHpMguTSsl6wnOq7qrVEPoJLwsmny6/8TGAylE2zXCH7NUGcYkDfBPhN2b7oWyRHRJ0hX3dm9JE
 lACjkz+zrU8gmL4am1vc+oKHs/WcZQ==
X-Received: by 2002:a05:6820:1907:b0:6b7:46e9:9712 with SMTP id
 006d021491bc7-6d44189df6fmr12210128eaf.66.1790636357102; 
 Mon, 28 Sep 2026 15:59:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d88358bb8dsm6098860eaf.14.2026.09.28.15.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:59:16 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:59:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [RFC PATCH 3/4] doc: usage: cmd: add httpd
Message-ID: <20260928225913.GX858934@bill-the-cat>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
 <20260928223532.482192-4-sochnev.v.74@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SMOAWQLvV85FE6G5"
Content-Disposition: inline
In-Reply-To: <20260928223532.482192-4-sochnev.v.74@gmail.com>
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


--SMOAWQLvV85FE6G5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 01:35:31AM +0300, Vitaliy Sochnev wrote:

> Document the httpd command, the environment variables it uses and sets,
> and its security implications.
>=20
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---
>  doc/usage/cmd/httpd.rst | 92 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 doc/usage/cmd/httpd.rst

I would prefer this folded with the patch that adds the command.

--=20
Tom

--SMOAWQLvV85FE6G5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrxPgAKCRAr4qD1Cr/k
Cv0PAQCChLQtIRDkgagUs8NKCLmoAl6mdBaEAdPny4nHbr0kvgD/ZxeeOXOwXS3N
QaQ+SF0EfpTx2htHF+nCifCsPV1b5gI=
=dzSo
-----END PGP SIGNATURE-----

--SMOAWQLvV85FE6G5--
