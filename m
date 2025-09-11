Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11123CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFC2833ED;
	Thu, 11 Sep 2025 19:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j7UB7o9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477A2833EC; Thu, 11 Sep 2025 19:23:20 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A03883390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-74526ca7a46so379961a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757611397; x=1758216197; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SUMwuFL5ZZSpIUqldiacQ1nqPKVH/YtOsEQG7WX2AAA=;
 b=j7UB7o9WzyM/yHFoxiKPkHLx0ZJrnpCOnE65V1m87juOdR4e+P7XLZZWQBdNeDVEf5
 TscWQaLX7mtsVnRqiIUL7tS0ipobyukr7UQgzhg2CDmeUn+EyUUygiIqJJGiiFxinQj3
 BteW8hdoKiO5KhULmg6qDbFZcjbtnxDdaF5Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611397; x=1758216197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUMwuFL5ZZSpIUqldiacQ1nqPKVH/YtOsEQG7WX2AAA=;
 b=qMewxuIQqRR4yo8FaI0NMKq4CeRE44kIYj+nLMG32TN13Gs839g+pqORAcf2Jq7tIk
 NC8UzeAyUDNHjC5gejWfWoqbOvC1rNAyOW9O3rEhlrMduS98OwIcSv06CxCQcy/RxeA9
 VdIf34RcPfcpO7rH1hb7oNZ3e0bGdAOiBJi49uyWcfswNlSplHtZZQCFNlmWnUlb9z7p
 vqj3vbnAjJ16fy+sUQ4T1rzfVd8WPVeyuPGeW+ijAile8P8AZujaDHfcll2dgTvgoStB
 eFZyxv+8kogjKg470+0xfpr+9jA9iGvzPwteG+KqBGfuASRz+oBHXPCwzHoBL96sJyQN
 FpoQ==
X-Gm-Message-State: AOJu0Yyp1BLwXPctrGpgAXvldSfzWydzjOjuF9cyMALXcZwZUczf/NGe
 +BZgQD1t38F+X9bFBo+N2ifDxgpGUh1H4ZOeeqdiKKb8UNqZgt43Leca8m+E2M6BiOQ=
X-Gm-Gg: ASbGncshSRzJeyQUzYVKkS26mDtWQ0dOPUZMoJyiaD6UMFeyh10s9jkDEqEHPVo659a
 WihJ4dlgHJMwKwtfVD/doeATfRAyCnX8O4k9TR14bAmC6Qy95cDkCdivxlf3QemtGx1c4TKdoUl
 0s/WLIVfnQA/ckj5tzCbCK702lDoJNgOYroPNBfccG9L1bLgwys0TAyfmK/Q630JNH1h4AxRETi
 hfHx8sBYSveBEcOPAp6GX28g7VLe3xC+bAzZA3T2I3j8jxe6BKocHSai9rXkCeH+QwVfBmEYOt/
 IKT4zOLHNyqaD0Am+EkynIfZb9UFifAYQVVnJTo3F5I6VHzxwIIFQbJqE2+C+PumH82/O+K/wM1
 tarXDBB8VfMeRwkSQkp7bdBWJtB24M2V2pjXl6+BXXQOckvlx4iLB5eWZFMimaQ/q69k=
X-Google-Smtp-Source: AGHT+IF13WJWqLZ3y4+wrnwTJcOwNK06YmhnXXZL7hhXiHZjkBRBCc0I1EMcIH+gRYKLS5S5tT/msw==
X-Received: by 2002:a05:6808:7006:b0:438:430b:3dcc with SMTP id
 5614622812f47-43b8d9afa92mr11927b6e.26.1757611396790; 
 Thu, 11 Sep 2025 10:23:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b8292288bsm329540b6e.8.2025.09.11.10.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:23:15 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:23:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 14/17] spl: falcon: prevent loading args file in
 secure os boot
Message-ID: <20250911172313.GT124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-15-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wW5M2HQJm2lAbGa2"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-15-anshuld@ti.com>
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


--wW5M2HQJm2lAbGa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:44:10PM +0530, Anshul Dalal wrote:

> The expected payload for the SPL in secure falcon mode is a fitImage
> that contains the kernel image and the DT. This removes the need to load
> an additional args file, which exposes an additional attack vector since
> it can not be verified.
>=20
> Therefore this patch disables loading of the arg file when
> SPL_OS_BOOT_SECURE is set.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  common/spl/Kconfig         | 18 +++++++++++-------

I don't quite like how we're handling the "ARGS" part of this problem,
and I think we need to clean that up first (which also means splitting
this series up a bit). We should make having an "ARGS" CONFIG for any of
the locations be optional as even non-secure use cases make use of FIT
quite often. Then we make the "ARGS" options depend on
!SPL_OS_BOOT_SECURE being set.

So the first series here would be the patches that make us consistently
load kernel and then args as the first step. The second step in that
series would be making args optional. The third step would be some of
the related cleanups you're doing. The second series would be
introducing SPL_OS_BOOT_SECURE and related. Thanks!

--=20
Tom

--wW5M2HQJm2lAbGa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMFgQAKCRAr4qD1Cr/k
CqhGAP0YPy+TgrjRYBYrt9Gfr9+NoPrEUTByt8E3Vt0pdWUB7wEA09JDo4pn8fRN
WoYjmN0fpQh/9G7YlhkEwVmmP12jVQo=
=/v3h
-----END PGP SIGNATURE-----

--wW5M2HQJm2lAbGa2--
