Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD841C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 13:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E7D87147;
	Sun, 29 Oct 2023 14:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iYSMYb7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F09E87148; Sun, 29 Oct 2023 14:08:14 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3E687068
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 14:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so6099156a12.0
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698584892; x=1699189692;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3RXAdakbc6xDwo4J9bOtlUjF4ZrRrewsgA3Exvn6GQ=;
 b=iYSMYb7e2RauuphGMb/qxlriibAnd+heErPfIYDfbMHETKNXcWlj1liCEbLMpV758L
 MwB9fUvBlWdSWPstUKJPR+rmlhLbdRgqonF6D6Q2K2nLMmEu1tTMccdjULuE+YP9ApY8
 HT/qRhiNWGTySw3FMqNs5IPs38ZRKLeJ2KS7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698584892; x=1699189692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3RXAdakbc6xDwo4J9bOtlUjF4ZrRrewsgA3Exvn6GQ=;
 b=M3jTagj3FuoGhAfBApM1Nl+arjsSaLbPNpJ57S7fext/7kxg9d2KjTWQ/Bygfyl4qT
 f0zgF0WsbtIA462Y5JjdqQwjKVq80X1s2u5E3uhEp42yqq67Ar6OoNvm8ogEx14LGgkP
 k0uYD7w9FborUtf5+yfKWanOpQvZsA9dNESPXCde8xrKC/NgAC2UUmEMVKgRRCimP4Dk
 1YB0aZwLcQX/p2N3nrRfN6dt0LAs5iFX2KULgxS/7SFIp740EH7h7W+lrEUB+Uc2URA0
 sR/n9tgR0Qv1JQUIA0hZhR8HsFmK6QvAJ4NHDrm3HQSg/eWrN1nAOQzApKQCyIAUGUVe
 PJkw==
X-Gm-Message-State: AOJu0YwdQf+99gRU3ZJjCmdmH4w0bRhxP8oXTosvNDuBPrMQv2Pg/x1J
 xjBpwRKR1mAGr5+5tuOAHhDYQHNsAZgDNmzeEaHPhQ==
X-Google-Smtp-Source: AGHT+IEQsTAWWqYktkImpenU2+alps/J1qh0dp0HuK7FaUJ4H8zaS9n0M2wo+VGyxOsEoegMkb0LzrHpQ8Hd9tZxZXU=
X-Received: by 2002:a05:6402:27cb:b0:53d:af00:1682 with SMTP id
 c11-20020a05640227cb00b0053daf001682mr5657866ede.40.1698584892212; Sun, 29
 Oct 2023 06:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <20231029034845.1169614-5-seanga2@gmail.com>
In-Reply-To: <20231029034845.1169614-5-seanga2@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 29 Oct 2023 14:08:00 +0100
Message-ID: <CAOf5uwn8maN5y=_yp9Hyu45iLgrTQL3JC=-yadn-+5+LkHpntw@mail.gmail.com>
Subject: Re: [PATCH 04/15] nand: spl_loaders: Only read enough pages to load
 the image
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

On Sun, Oct 29, 2023 at 4:48=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> All other implementations of nand_spl_load_image only read as many pages =
as
> are necessary to load the image. However, nand_spl_loaders.c loads the fu=
ll
> block. Align it with other load functions so that it is easier to
> determine how large of a load buffer we need.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/mtd/nand/raw/nand_spl_loaders.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/nand_spl_loaders.c b/drivers/mtd/nand/r=
aw/nand_spl_loaders.c
> index 8848cb27db9..f071b5b57f5 100644
> --- a/drivers/mtd/nand/raw/nand_spl_loaders.c
> +++ b/drivers/mtd/nand/raw/nand_spl_loaders.c
> @@ -12,8 +12,11 @@ int nand_spl_load_image(uint32_t offs, unsigned int si=
ze, void *dst)
>         while (block <=3D lastblock) {
>                 if (!nand_is_bad_block(block)) {
>                         /* Skip bad blocks */
> -                       while (page < SYS_NAND_PAGE_COUNT) {
> +                       while (size && page < SYS_NAND_PAGE_COUNT) {
>                                 nand_read_page(block, page, dst);
> +
> +                               size -=3D min(size, CONFIG_SYS_NAND_PAGE_=
SIZE -
> +                                                 page_offset);
>                                 /*
>                                  * When offs is not aligned to page addre=
ss the
>                                  * extra offset is copied to dst as well.=
 Copy
> --
> 2.37.1
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
