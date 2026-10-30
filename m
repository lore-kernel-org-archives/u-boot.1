Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AB606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E2NSJgPl;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KTLi7tVT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95FA481281;
	Fri, 30 Oct 2026 14:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EpqD_h1db0sw; Fri, 30 Oct 2026 14:24:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB5DE81285
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793370283;
	b=lh7/S6JL99iUsIXbKpojAQ01kZxjNEBm+xbsJRi5jhAc1CVDbp6fprDZroMt5L5npGig
	 xkDpO7obCsRKQZasii86Yt7pz+/Z4gS660lgnMVMgFNeTG6JMxRBSw/AjNd8rBfQzVHSf
	 Fi91wTj7q2B1I1q/xW/mAWT25g4DBF7oKi5vgjbo4iRcIDG5vY7G5cAJfNeNxiPKCiiLu
	 rvV2MQg3lI/yNnwqHB1eDmUuJwfK2k07OaPCpf8BDTM1c8jmJx4KmAnnSB0zLrI5WC7Ip
	 xm/rTjaAVV/7jgY9U1LQbnSYELNBs1d0l9FnJLWxp0uK4+o4PjSXcL8oVBv5MU7sr5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793370283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eDoJ2mU83YEzaec/t1LjTPCGf4bVAzXVCKIG4iuorF8=;
	b=BL/xrPQb7FPFy1nnfj6J4Q+2lVEgVIkd80wezbvVaufWZaBP63z1zblIsfwn5q4kcVrl
	 guR5ABcGdhYpcxDkoJpSYTxZz8XdYIkcQXxoY5oJvdjZg/qF/2T4y1XrmfKM6oTG8mPTl
	 CAP07tVYXVltyUhUYRaunj5rUO9RQLg/KLKyDg0jF1OzScS2C+V/D2qHcxGUgtyrQidCU
	 O9v1rsdg0YAZCQRvw+ciSpxBLUd4XnWNDdowGjmoHYGK/vuaCbj3VLQ0DgCjQcaGF/cf+
	 cSFuWSczmtyDoFHZiDA3MDH6YYOwq/6KSLAP2De1DuuG8weAIDl4PPR0IufzfiRlx3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793370283;
	bh=eDoJ2mU83YEzaec/t1LjTPCGf4bVAzXVCKIG4iuorF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E2NSJgPl0HWeeGE85vg1O60Ll9K6HtsUDS399poBDGVcgUb8Ct+Pg3wooiJlzn2ko
	 LVx88dmS1LMkWNnpBb2y9iq3qQA/yB7oPni/FceCVZvlzNVSleSF72VvFUdrEIeD0+
	 6gYh4xqp/YOKZ9EgKb4EYWJE3puKOFVZu7vg0TRBKEPDUj0piH61f2S8mvf4Qwo8yl
	 4aO0FZGr35Gepr+eLkRml2iXVHUBf96+DWXYEEbMqpE2u03hBwHcf3Aj/tz38wBrLd
	 flOXVqNZkMSnlznwBkXe/bcsFTeojuB03kiq+9aJdpAWcv3AmdWnUlWntgrr2VGIJ6
	 KId0JJki18uAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB5DE81285;
	Fri, 30 Oct 2026 14:24:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 83606235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68F04607B6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rqfBL0qdFfGS for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8451A60679
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793370281;
 b=q8TRmewgIEYvi1mZb1xLzx2aW6ay/FNpzKHTnrjXwyRIu3prrJnbikrea5q3mkXvQ24v
 JiGFDOQdFZM/IQHdExg21JQPcz58A3lZGsYjuSxUFB2M1+jW+2460AA/QwBPaYHGs02As
 QCY+1Q8juSDo2lO8lIPPM7caCh7UCmM6gvFANI/WqJ0bl8Df9HXFLGHHL7loPeU34m4u3
 HwGlU4zc8a67LsGlzXqxpg4cW1JWARvL8eS297BOhJsJztIJXxGhBS2qJ4XjG0yvgaZ+i
 CW2jft/7XV8bea8FfRhrx1N8Xahx45nzISU0vL1Ns5YSxQRxMvQIe5ZVYlHWe3aiVdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793370281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=eDoJ2mU83YEzaec/t1LjTPCGf4bVAzXVCKIG4iuorF8=;
 b=VcAppg9A0VKw47DhhJQaQaNSkMb+LCj+Yk2Nt3VNqjnw+Y2RDff2Sep7bP7RNus0ISHM
 X9oHcYifRE7qBLm/bf2f/v7wBpuLL8Q/LYToQmwS4n9nd29qasRp/bnueiMAbgpZMwU5+
 mmCiTs6uEveZcv9n24GpWbL0rvBD1a0S4wEH9CTaAHtICwoG0JffKzXIpWbGQ5CtOa7lF
 MYNbSeuP/Pfe+1yZt4xxqeZjwwbnCsOQDMidQ+CVXUxj1PIbsUChse5XcrEQ/Ov+Zayw4
 dkCqp/3V3ka0diGKbJ1Ty9i0nzpKosyVDqoRJljECjKum9ho3boeZaWUFFdeRTKB9HA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KTLi7tVT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::a;
 helo=mail-oa2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KTLi7tVT
Received: from mail-oa2-x0a.google.com (mail-oa2-x0a.google.com
 [IPv6:2607:f8b0:4864:30::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8451A60679
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:24:40 +0000 (UTC)
Received: by mail-oa2-x0a.google.com with SMTP id
 586e51a60fabf-4a76f0cce5eso46201fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793370280; x=1793975080;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eDoJ2mU83YEzaec/t1LjTPCGf4bVAzXVCKIG4iuorF8=;
 b=KTLi7tVTt20NHRXLcpxsC+4kKx3IZAndt3bIKJKOuO8XKqr4C029qbgHEGJdMuF9fP
 k9M6pUbQqbRDkiyBFBCPgQL2eAtClaI5jIYav6K+f98lDALTO9pr06unv9vTaPEGwuCi
 lK78J31O82H77AlrzhAcoIB6oVst+ua3+IDfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370280; x=1793975080;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eDoJ2mU83YEzaec/t1LjTPCGf4bVAzXVCKIG4iuorF8=;
 b=WQ1DbKMTXdiByFn60dPhuo/Am0jcvbxW/9JApP1PKv2EHunZlIh88owwqiujjGWNKN
 ynbZ1O12kzwienJ9e2tYsqHyOf8Q6AVB5Kv8rhp4ugR3cBxTAtrnhMyKwPKfjpA9B5Su
 ur2OMbLUHlKVab7jH4Ych4yR/RlIINmSg1dE/7RLke609WLitzqmhqsCERU+FwtXInLd
 qxyklS5pzMM7NON3kx5Fz2ac/S6H2woZXZ7gxlvytOHHG42DM5uec2LAKVDdwvGVpjL9
 pkw0Emx+mZ+2WVykX33GeBLeBpHyKRjRio7C+j/9KCRf7Wthrgo/kib4it8ITCHN2l0r
 N0Kg==
X-Gm-Message-State: AFq9FYKhPGs5mydB+Es9Fi0kHIn9x0Mkd3hHWlO3cJEs1DnTV0wsSZAE
 iospUTKcOkzEYZdCPVHiDb4/t0E3gD+1AznejCT5JOItNOfLO7T6J8NcW62bbARLucPC7mz8g9m
 ky0VUITAdU8a5iEc=
X-Gm-Gg: AYBFou1uO/mPS3+R7sM2HEqDAlm211vnFtsMfHkKifdmi6fKsU9mMdxF26FuoMXuz4v
 AsV9VslklJwxT0gMNzu1/OQTvE5NteMdo+1nUfpnZ8IAMf4ysal4CN9vc6478gmSsI5NOHxlmwy
 8PFmKQNV6ecIjdp8ap60WNTh3I8nFL+yHRivLn8lauVESpeAQrKZ6jgceWqszbFb5yhs6j8YDgN
 lNlq9XK+0iFqs+z1OEuOjcPv4tuXhjxKd2JyReQhrnwBSxEyVI8TN46icYgBLUEJzNT8dRBL1iH
 Q5ii4Bq60WzVWRGMcrevM/od2WN5f7l1FJtYC0h7iTkFstCcEbwUPjJ9XB9WD0QOkcytD9+meEo
 8weUPn34PBmmGPvGZ1mZlgEnRadKpxR8SORNB7SYjtzwCdjWDDYHSzY7XSW6OX8Tabx9BDFs1OD
 6agjXTl4oLK9HoutKP81YQoE42UsLwmu5czTXMadtOegBONKpXuZB5QjfmCFoZcEdeifvuf7DwO
 /wCnvkKfOVMmGbU1LmGGQjlvGyI20lb4nuRcFpsl3Gw/t1h3NAlADTepivRFBMpyMHHgQZ4BCAL
 nOOTcxZIHVKab4H786Lr7lhPoEaS6jRHafZmNQaszxUFcKznrwaY7u+YdzBxpyK0ZQWy8kkED7e
 b33QSsS7HXWgdgFtDh92CEs+Mk50wc7oYXkfgo53qIZ2hPabdJlPpp7EXTi9kcPk51cSLl/Q6oq
 7si/MKvNMRTXQvtiVbc70/6q+YOVZByDQ=
X-Received: by 2002:a05:6870:2f10:b0:49b:a2da:91e1 with SMTP id
 586e51a60fabf-4a9075fffcfmr1408989fac.9.1793370279723; 
 Fri, 30 Oct 2026 07:24:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a921a80881sm50000fac.17.2026.10.30.07.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:24:38 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:24:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/4] doc: arch/powerpc: add architecture documentation
Message-ID: <20261030142436.GK3011578@bill-the-cat>
References: <20261030020832.26572-1-brads@mainlining.org>
 <179332641005.29622.13964170083166836926.b4-ty@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kS0ACVHdxmIzCN5j"
Content-Disposition: inline
In-Reply-To: <179332641005.29622.13964170083166836926.b4-ty@mainlining.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--kS0ACVHdxmIzCN5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 02:14:08AM +0000, Bradley Morgan wrote:
> On Fri, 30 Oct 2026 02:08:27 +0000, Bradley Morgan wrote:
> > There is almost nothing in doc/arch/ for powerpc, so this adds a folder
> > like the x86 one, with four pages:
> >=20
> > - an overview: what the port is, the cpu families, the boards, how to
> >   build it, the config options people ask about
> >=20
> > - the mpc85xx boot images: the NOR, RAMBOOT and NAND layouts, and the
> >   CONFIG_SYS_MPC85XX_NO_RESETVEC and SPL/TPL knobs
> >=20
> > [...]
>=20
> Applied to next at u-boot-ppc, Thanks!
>=20
> [1/4] doc: arch/powerpc: add an overview
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commi=
t/e6a37f4dfeea
> [2/4] doc: arch/powerpc: document the mpc85xx boot images
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commi=
t/3287ff140823
> [3/4] doc: arch/powerpc: add a PBL guide
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commi=
t/b74d2c1efaac
> [4/4] doc: arch/powerpc: add a booting and porting guide
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commi=
t/0851db824add

For non-critical changes, please wait at least a few days. I'm hoping
that for the documentation stuff you're doing that Heinrich will have a
chance to look at them, for example.

--=20
Tom

--kS0ACVHdxmIzCN5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauSooAAKCRAr4qD1Cr/k
CjeeAP4jgxbxZIn/6f93yujAZfcLMRphoKW146wR2ZFQXcKdzgD+NINf3TiGyo8Y
ufg1ywHx9fzKRuAjzvzAlBjiK2JuXwM=
=MAUX
-----END PGP SIGNATURE-----

--kS0ACVHdxmIzCN5j--
