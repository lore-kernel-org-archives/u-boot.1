Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDB9CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 09:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6323E83965;
	Mon,  1 Sep 2025 11:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YNN1eUiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E53F839B1; Mon,  1 Sep 2025 11:31:47 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1277833AD
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 11:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-336d2b0ea8dso8605811fa.3
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756719104; x=1757323904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BQndhDFzkR+ZJ4RN5hG01xRWWM2B4Q6boAQBZveMD+Y=;
 b=YNN1eUiQ46x65VRovxPsc6jiwiWmhf5NCLhK6ElF2MXXdvAAzgZ95QNAfskOf0Eo/e
 verkBdKP2NfoCFEC4mwL+6McyunoKYsfAEWTiqU9VgFT+yZrE/O4bTqCZ5/vEN9XmoSg
 BQBxIU38mZ20IMtiiWqFG2rNjfH8rRM1SmQNFsOO848NXKHI7pMnobRM3Qnde6FvlzuT
 HlVdWg3A6ES3K5xvcg0Q0p6OeVGgQswv18AErTZfd7VWlfPBougRD2BDhZXDMN53Buj7
 BQdJ/elDKhRscjWtpxGh9dBMrYV1X/gqD7707wvAgAK9f9lfVdU4ESk8LlYVAHaub1N5
 eFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756719104; x=1757323904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQndhDFzkR+ZJ4RN5hG01xRWWM2B4Q6boAQBZveMD+Y=;
 b=dr7N5rpJ9Mxbmfz5jBK9k3cQsl4qQer0tUOpIXDNrmgPf7N06gkToLNpivPKZmfTTV
 4UJ2aAyueag6cCdiuXteWZo5cngUnp7+2GkCw4Xd65bcN+kFM26P8digiW+7OrQ3wRuR
 SyrQGqNIY1rYLOMPkriDyrE7id+X3O+UQ8SeYqIe5/46FE+v2tAahqfa1FvgpZrm62d6
 zFU1Iw8sC9X8WQbUBKuABLuS/pyJ3mBxJr0K/7Re6sH6mjYD8kZfXv2QnIdVNNSSHM/D
 XkehQu2pXmYwIYag4r0HS2HmCFDzvBPm8ORKCLj2MfsFGCh6C1ddGxgXZDHYXwmWGeO/
 +SrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8dWylcBnlRSpcXQQ8bOwUiQrrsVwwp9gQWygxBsamSBVnW8vWY363CxKC7ptYG6B0dqgdVic=@lists.denx.de
X-Gm-Message-State: AOJu0YwUuEC4lzmwOvCRpJzG9p+mrLIpj6nDA6gBs6K82G/MmyCS5h8M
 Jz8DgOX5ZSbuvJ3LYxMEJzxZR4xsQLlTVoWsQE0CF+HTgOECXQ4fBTqgJZWLV2NGHoFiQ3NK3NF
 RkahRdRaiCy95IkskVmONWsd6G+2C0gI=
X-Gm-Gg: ASbGnctrGOD0LVg2Jwcc40XKUoAUti4smv3N6LLa2u8SKkt4vROhyUEkWDZ8BAMhznz
 fTnQzx4eaJNmKnSl07637VE7VGWj5LxtONoxxn4Pmcqp7vDyMzCpTtN7PgeC5gvsQKt8qgIT4SA
 UQMeSGdjbM00ZNta4DSFO6j+7FjL0qKfHWr+uhAufB3PIr74sLhEq4N785aFi6beOwjrhLN9ZWi
 jZ+nUHolDofAXQjFZhFtTUjHi3FTBD9Yd93pQhuNk7hGDCnVS8=
X-Google-Smtp-Source: AGHT+IHTG5L6PwOl3rsgV2dY7cnMxig16eRuLW+QjpDwpzporcGoX1tfkLWWJf3K/dTCs+JBEzktyrEoFxfSAjPaKDE=
X-Received: by 2002:a2e:bc0a:0:b0:332:133b:1513 with SMTP id
 38308e7fff4ca-336cad0b021mr14339401fa.30.1756719103882; Mon, 01 Sep 2025
 02:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
In-Reply-To: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 1 Sep 2025 18:31:32 +0900
X-Gm-Features: Ac12FXwoBxmM3TA2VDF4b6qNvtV6BhPTkODUAT_C74C9zVhk1wFD4uaZCEMrWrk
Message-ID: <CALrBrZ3_UCv8EsGMUrkkBMk9WNVYBMSNKP0wqM5THp=43GM8FQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: exynos: fix origen description and align and add
 \n to pinmux msgs
To: Henrik Grimler <henrik@grimler.se>
Cc: Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2025=EB=85=84 8=EC=9B=94 23=EC=9D=BC (=ED=86=A0) 04:03, Henrik Grimler <hen=
rik@grimler.se>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Three patches to fix minor issues I happened to notice.
>
> Best regards,
> Henrik Grimler
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
> Henrik Grimler (3):
>       ARM: exynos: use correct exynos4210-origen SoC in Kconfig
>       ARM: exynos: pinmux: fix parentheses alignments
>       ARM: exynos: pinmux: add newlines to debug messages
>
>  arch/arm/mach-exynos/Kconfig  |  2 +-
>  arch/arm/mach-exynos/pinmux.c | 32 ++++++++++++++++----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> ---
> base-commit: 94e690c44a03959c39f0f5a44a9b89c851af3b60
> change-id: 20250822-exynos-origen-and-pinmux-debug-msg-16cae0a91ccf
>
> Best regards,
> --
> Henrik Grimler <henrik@grimler.se>
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.


>
