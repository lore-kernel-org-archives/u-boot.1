Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE35C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC61B80DB4;
	Mon, 21 Sep 2026 20:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2zd-oXrzH9pD; Mon, 21 Sep 2026 20:24:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 08A4880D85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790022282;
	b=EaGjm3GVN2izTi3tk42ez9yoTxljLkeBTb3jVdSW6AwPa+IRCdQrmsSCee0GnnoLpiJF
	 KznsJGCH5hkvij/Uqu1FHz4eqjM/Z+xbj65LCtNbjmgYla0m6dt/pQO6ana8Efw9qItlN
	 unnzV/mGGRnnjyOkolRNL7CDh7fIJ281MwXiT4e2wilGLHpfhxZMU3t0kH4CLJxSvoP78
	 XZmsy7WKlKWo+P39nbFTCp8kPAix4Zipu04C1FnRb1Tu1qdtxXMjyVhD4eukMUQybit7u
	 F/AKPM9p0BNvudyp0cUfL3C/BJj5G+CkmZFXsmczCkkLAWUOt17RQlQ3fYJHNq+yZZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790022282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6tLoxuZPhg/yuL/fuUju957rFyTW88ydTqMBcCFU5nA=;
	b=VHlly322KexrkRGA0BdPtS51MG+sEKkJkCeHqzymdzbJzutCVCAfJqRFeuq0Tl5Quu3l
	 38jWsQ7Pz2gBhV+QVvj7C9Dl3+yW9b7bMSeoEXmMBC8efjeEbVturn80M5AB7JwFuwxUO
	 gopXA8lzUvehboGz2AZEpsNaB/KIISDA8LdY+2owAfaymIrv+zITwA09mVQ2dsPuS/KMW
	 L77Q4MC0CpV5g4DFkCn4yFRYXi/ar6/ZoRl7D8u3fJafepTULrW3PoiLIr4m2apz6EbSh
	 /waT7jjSXRyo+ZfAlxzgylMirAUZ/dlsummEHpjbcAJwilU1lP0OUpVBXLrX0qCro0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790022282;
	bh=6tLoxuZPhg/yuL/fuUju957rFyTW88ydTqMBcCFU5nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KHbh46Phyu7cBW7Hl3GT1UL1EEvwl82bUVqbtuVO3GgyfT+3YGtaLrw+FDSGis7dW
	 iK/OZBnCDaj+YqsgIyiJa/rePekPdCq9zAjrguySo4MQiKNv3rCYchMSZe7qzBTDEz
	 0JotAswxPOqFK+WPIN/rCnHK+SQ1ulvpVEsJlksEUUBIzL1t3yIuHSErhPPAqOdZLD
	 pgSeIBlwSGjP79I2LYRHUu3OpVeZ6Oq2FE/Q0gnn1NgPWPZQMltIa1ZTXusiPUSCaR
	 9ORaiEqdZ8uQr0Q6CADuP5wDzdo/rpnI+Zol03fTes9czX3kUX/sXJ3HGjCGa7Kujd
	 QyIMkNdEtG6mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08A4880D85;
	Mon, 21 Sep 2026 20:24:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0CEA224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6DCE6064B
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:24:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZiPOMlmmYa3I for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:24:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1DDC960628
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790022280;
 b=b6W08I391+ZI+wa8X/X26MnlU42X9P9z0YqpmxNipjTDLf7Yi7JspziuYk+etYeVo+7o
 /SbfINn2RVoM7CXBk6Pb5/qRPnZ7gTAauiJxVgVMSdOM0R8u3KHjj6iQk6jJurYHPhC8l
 neYYFCi858wkwQ0O4zR5r/aEMicBFF3HCF+ktsCMPCy0FEk0vH6Jk4uO/T57VFKxlPPgb
 3UToTv/bYvWaKIpfVjX9V6vWRvzOf1KB+dw1rgI6xJl+wsCW2BY8YPvRKx4LrmSAmshyt
 ZdQdEm9USNKRLrVs3B2iDgpGsAITobt6zoWFK76Wsl/+ts25GbE3lwWEVJAvIarWXIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790022280;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=6tLoxuZPhg/yuL/fuUju957rFyTW88ydTqMBcCFU5nA=;
 b=e5B+tpfnroK+JREFNn5zv38gA8a0ecOccG6dQ+pKrnZnj5tWUkKtZmvGYBRmNJ6gbYVT
 33js/ePbdZWNJmAlUZu8aL07Yiph4x6uK7dgNsHfN6DNSQi5u4kjTqfCj4nTT8lM2b1XN
 1ss4JeciirbA9lytAGyJx4CMBhR68bil4R9DdSe65G67YRXvE8pl5Csmxa6C9gUqroMao
 SJyH2Bz3l4n5jOm1ac7snZyyXGsREskTk4EYqnDDNlHXtZPrm1Gor0eybr4XEdJSZ12AF
 TjlLL1nfxK8j3cYlLM5+YURGtqNkMg0d7rOq7ycrCqzc6vve8WNYWzDEAWCdmuhIWKA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="Y/HM5J/h"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y/HM5J/h
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DDC960628
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:24:39 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c206dc8b0dso2349823b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790022278; x=1790627078;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6tLoxuZPhg/yuL/fuUju957rFyTW88ydTqMBcCFU5nA=;
 b=Y/HM5J/h4oXYx26Msy2gPYUvDEgpQwxohx3CEAfzFPSg/LKl9TlEZLRh4DbamscOoO
 KcO/C2Pr6dkCoAeRXIRn02MriR9LcXFh53mUTK/NZCEAkn8QQywHFT7udMEzdwQhecfW
 PZEZGC6KnpK30+6LPf67CDXEaecuAwomZ4gok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790022278; x=1790627078;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6tLoxuZPhg/yuL/fuUju957rFyTW88ydTqMBcCFU5nA=;
 b=L2TmeIPjtsrAuplElfh0jJwllTV+GBfe+AXaDEUr15SEzUt5tQ0b9njHmrjwXM0EAL
 uS4v3LJJ0lIOhLqG+EFBKF4CEGiW4mgShP1n2YEU+Ec8cVjvGIkMrcgIarUxL1Dc1jhY
 b96S3QTCeWAx3D4+Ud7KJd5ckyp1nfDe1nTmGYmOx7UO1d3ROUbophJnLjnFQj7TjEi1
 YR/l+vW+Wn3dVicyBBlu1uxennInp3A+gTcfwdJeKW1mc3nuTlgk7762pD7rlaDf/JJe
 W0QqWow5TopfDco4DPcxfzAhJSVzSVW3TT5vlLGcwDiehOEJBY2u6AwuGVYVxK8FNRmK
 QqMA==
X-Gm-Message-State: AFuF++kzf3KFa9RWgeRKQhpRFqJzrTDBjYBXNKtCdmP3FApJvuE2TISt
 TWHinucQN8hN3eORqoxDHHvxbUC1+KCSy0qSBUF1AlOvNRVXSkrB4rjo51ya96YdC1U=
X-Gm-Gg: AYBFou36BVnXtICavNdm5La6Pnv5T27iesZ5o2zI4UuxNdKME20hVfyWxEErSiuhQD2
 czUus5uymkv6+aN3QZ0/2K3oAe8qzd/TtqwC8RF4vM86PMKsi8UKdSSn81iPCYjMHJ8/P5rze81
 SnTX6krVC7zNzyPC9kuKZPp6Pmd5sZnFyhGDbQ3kLVl1oLwBJLd7sCd5ChDFoY/E4Wxypv5XvDl
 sKwxlH992oV8mfvs3c7sYGiavodmToYQlZJnisNHxhw5kNf6ljPBcfy8KYKljTTokNq5xo/r0K4
 UeN4As7Ko8o5ZQQSxFL4mYMxih3xrJ4gD7NeMGLS9082cbDyB+YXHpY2eyJ/lSx3h6ZwFA+iIn8
 ZPeNdwFKQyOpibUkyLli+FVfg7LTflH00e/X4a8shQ2HEpChjoG/rbH2YZhkPZCK3sZ8HDsR6Jx
 E0fmaXrzwKtgKFyDsSEdevWDY2y0+o+TC1HJJSpoHUQn2dK8aaYx201zBkKbFpy4Hpoixb5OyED
 SiEjVczNlFArspNufRGuGEIOpsIPTr24oFEKufmz889Inp9SDh+JCIyYpvjevYkTbUO9khi40Pz
 APdCW8mdnGPpkZH3oWiu
X-Received: by 2002:a05:6808:c161:b0:4a4:866:c395 with SMTP id
 5614622812f47-4ccf6338c70mr12882200b6e.13.1790022278469; 
 Mon, 21 Sep 2026 13:24:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d420d0db4csm1108045b6e.2.2026.09.21.13.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:24:38 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:24:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Ayoub Zaki <ayoub.zaki@embetrix.com>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org,
 sjg@chromium.org, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com,
 dlechner@baylibre.com, hs@nabladev.com, xypron.glpk@gmx.de,
 heiko@sntech.de, raymondmaoca@gmail.com
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
Message-ID: <20260921202435.GC858934@bill-the-cat>
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
 <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W6UejeU7W5Ux5Kjv"
Content-Disposition: inline
In-Reply-To: <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
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


--W6UejeU7W5Ux5Kjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 07:42:56PM +0100, Ayoub Zaki wrote:
>=20
>=20
> On 9/18/26 18:53, Tom Rini wrote:
> > This is interesting and something that does have to be on our radar. My
> > first question is, should we not just update to a newer mbedtls release
> > and enable their SHA3-{256,384,512} supports, and anything else we need?
> > Then we tell people that need this that they need to move from legacy
> > crypto support to mbedtls (where we get to leverage a wider community
> > for security audit and response and so on). Thanks!
>=20
> Hi Tom,
> Thanks. I agree with the long-term maintenance benefits. ML-DSA
> requires SHAKE128 and SHAKE256 rather than just fixed-output SHA3.
> The TF-PSA-Crypto ML-DSA integration is marked experimental in the
> Mbed TLS 4.2 documentation.
> For this series I would prefer to retain the Linux kernel-based
> implementation with limited U-Boot adaptations. A migration to
> Mbed TLS could follow as its ML-DSA support matures.
> Would that be acceptable?

Well, a problem I see is that this is something that needs active
maintenance to stay in sync as we don't want to miss important fixes
here. In theory, we get that with mbedtls (even if we're behind atm...).

--=20
Tom

--W6UejeU7W5Ux5Kjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarGSgwAKCRAr4qD1Cr/k
CmuVAP9YwjAbVd2BHJkKXdrprh/mAqM7nkqxHwWtnMicxPE5sAEAp1HlQDU6f2b+
o0l5v5KzTzHRr7DddD+wsLGIPbaUAA8=
=TxbU
-----END PGP SIGNATURE-----

--W6UejeU7W5Ux5Kjv--
