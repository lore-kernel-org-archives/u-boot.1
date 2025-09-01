Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F245CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 09:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0FA83965;
	Mon,  1 Sep 2025 11:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H3IVD4E7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8054483977; Mon,  1 Sep 2025 11:29:17 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4A6833AD
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 11:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-336c2194a65so15729591fa.2
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756718955; x=1757323755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r30i74moFDbqFvKQYbMiE0j6/eOJ4ax4VlbuMCUDTj8=;
 b=H3IVD4E7Ca2duEvDaBIIZxOemFOHhyV6vospCEqal8bVt4DqtgHtaBZNPxEw6Jn1cQ
 I7Mti2FicfsaXvVgnmAqRolpIx0eVxZwFYbDeElNGRXHXoEJxRuvDbsCJiRwfct2ihR1
 s+Q6bKCONeJg4qbvQrr5NEwG22DcRsO17PvvUIzpSQu9r0g0Cn44B571A+yzoxajlCTk
 IeOxfxX4YyWTdZn0dBwkM1H5NRDEOkQUb3aLchpaT6wDIDOvuJkIUKia1Skyu9fvCvEE
 T3PwdILiU0fNZWkXt6er52bV0SiakNoBUUGMS8p1xQRLQ/Yw5uyoxfjhtmsUhl28ubjE
 9etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756718955; x=1757323755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r30i74moFDbqFvKQYbMiE0j6/eOJ4ax4VlbuMCUDTj8=;
 b=u20IwEy7dSvMus0U/rlDZ9z4sJXvvltog7VSysZxQz0pKdmp+RbNSpOx5/d6G8GvUT
 AGM9K5jqRlaxWpW4ghCbfwmq2pMG0WOiXwkIsubqE+Z2shL7wWNXGJE38wNm63ChJLgD
 /ym9+tUg4aMGkPjoU8nEumTcF405AhLJ/JGa3xLepab2TMg/SxPssOnbTy5qC06NUdT6
 56f3EW5SK6kJiXKaSHJqDDJ96P5Mf5T2njox0GSIfNNSrPZeSRQphfQa1zZIO/QgUDEw
 fmSZD5uhyVh+HMGMCzTUeMAMqPc7+n7jBeZiLoQu1E6ZL4FksjojB6bYd14fqDCiql5D
 452Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEtHCBmcleP+JLmUixpZGfKrLxxbJxWk4kSyApTjVZ0bdmW75kVFiY/jOVmXJDupSVcyqc0W0=@lists.denx.de
X-Gm-Message-State: AOJu0YylVWOhzF+DNeix/c6zGuWgVqc9CsNVU1mBFP5rwoDTIBtiW7fP
 +DWMiFLf5g+vQ1266JQ8B+vy+pZZ4ZJ33nLlmCfxg792QXSkfkSfM9mtn2OCGAENxHR0QxUBWyA
 FIMdlKQYuVt/V9lxBUa9Jtxl+dynL27Y=
X-Gm-Gg: ASbGncsNdoURs8mxd5n78WqfNJ8XPva+pNUywelEHm7zQgM88RrsalwfcHrC6fWVSdn
 jA0vRoufCh/lIHsMmx4bO3+HIyQbVL3F3REqGM2jzCOhiV5Tl0/o41zIr48MENOfl9e2keQzZLp
 EXqVzMXvQuZEtbiDJY35TnSXy91ENDhpBgs2h5Hu6ycvHzHNQ26SL4hmrSkLpZ3KiAFbPsdsfcw
 i05+lM5pK1BGHMBDWS+t7rn7MiPF8cDv7bsCLnG
X-Google-Smtp-Source: AGHT+IE834s+nduu+MvXwLw67tbcDR0Y/Qpj2GLS0AmJo6vT8SOFHzJHqLxxH2EtFybnQAcHsW8EWHWkMCUvRnReatQ=
X-Received: by 2002:a2e:a590:0:b0:336:e32f:7a4d with SMTP id
 38308e7fff4ca-336e32f8084mr10814071fa.5.1756718953913; Mon, 01 Sep 2025
 02:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250723-clk_exynos-v1-1-fcedf6be444b@linaro.org>
 <da609352-e4de-4958-a257-66eb76d801ee@linaro.org>
In-Reply-To: <da609352-e4de-4958-a257-66eb76d801ee@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 1 Sep 2025 18:29:01 +0900
X-Gm-Features: Ac12FXx28Qt1Htz6ne2mIb7vbmwDL9mfyRVjoi2E_hWsnwmf0gJ1HbOI9FGOJp4
Message-ID: <CALrBrZ30j0k72ZnSR=wgQYMg5_BxET=xDpd74oT5rGO3h0WytQ@mail.gmail.com>
Subject: Re: [PATCH] clk: exynos: Fix always true test
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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


2025=EB=85=84 8=EC=9B=94 8=EC=9D=BC (=EA=B8=88) 00:28, Andrew Goodbody <and=
rew.goodbody@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On 23/07/2025 17:04, Andrew Goodbody wrote:
> > In exynos7420_peric1_get_rate the variable ret is declared as an
> > 'unsigned int' but is then used to receive the return value of
> > clk_get_by_index which returns an int. The value of ret is then tested
> > for being less than 0 which will always fail for an unsigned variable.
> > Fix this by declaring ret as an 'int' so that the test for the error
> > condition is valid.
> >
> > This issue was found by Smatch.
> >
> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> >   drivers/clk/exynos/clk-exynos7420.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/exynos/clk-exynos7420.c
> b/drivers/clk/exynos/clk-exynos7420.c
> > index 3aa751bf4e4..7de4e688f03 100644
> > --- a/drivers/clk/exynos/clk-exynos7420.c
> > +++ b/drivers/clk/exynos/clk-exynos7420.c
> > @@ -192,7 +192,7 @@ static int exynos7420_clk_top0_probe(struct udevice
> *dev)
> >   static ulong exynos7420_peric1_get_rate(struct clk *clk)
> >   {
> >       struct clk in_clk;
> > -     unsigned int ret;
> > +     int ret;
> >       unsigned long freq =3D 0;
> >
> >       switch (clk->id) {
> >
> > ---
> > base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> > change-id: 20250723-clk_exynos-b8ac6765f510
> >
> > Best regards,
>
> Are there any comments on this patch please?


applied to u-boot-samsung.

Thanks.
Minkyu Kang.


>
> Thanks,
> Andrew
>
