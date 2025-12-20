Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2036E6689E
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 08:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D29883642;
	Sat, 20 Dec 2025 09:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TuEnRnsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 472A1803F5; Sat, 20 Dec 2025 09:43:11 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14DC880050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 09:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-bd1ce1b35e7so1493550a12.0
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 00:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766220187; x=1766824987;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQlB9+wbCzQBjpz4i13BmkUNKbxv/gBLZlg7TdAPTWE=;
 b=TuEnRnsfZaObDx+X+RVzEF77QmBY70cZdKoq6OKtHxcS6LtOvqm3o86PFCbxbKT/1b
 c+nSKl62BgUg8C18gNPe5ugjJL/w2ccaRDdevKdS6kSPVZMatzYTtDexa9Tkp5xkbp+w
 ib3JPze2u3V4VhjV+LwQb1NzJbroq1wlDIfyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766220187; x=1766824987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQlB9+wbCzQBjpz4i13BmkUNKbxv/gBLZlg7TdAPTWE=;
 b=WPnTdf8owY2HjufXHWEfa1T62uNE9+ZWPvvdGuJ2ZbpDNKCfRRmqf/qeAFI6zSmSJ8
 zz62LlqvJBK4CsV6zC4d/aDH63pHsPYafDfO6iVo4d0y0a87dTXcdKkG5JdhRJTfMFAE
 BvOa9yqQyEk6Mj91r38VO+sGwhUe7Aa0AGzTbaxwpQRuElA4YyXofOBrze5OGvim9lpt
 nMYCsYHcaf8wRmEqPeDfSVIK1BQ+c+rDEZakwT21i+QnNS0AesI5iVU+mdY0UgsQIyyx
 q2Lim+lJZAcUKDG5usI7x71zKKgHyphS2mVO3td1nGAq3UT0Ubl9Xh8Srd1wVxTVq8Mq
 oisA==
X-Gm-Message-State: AOJu0YwgVTG0QERkag/KG06umgbRMLpxm340TgBTV5/b8KAgkXGFfQeD
 /9dbzbRj98nj3B4UCwNDrDC6lij6WXBUrjX/uv3owfIm5hYb3MOD7E9j1R2LcIS+hwrUJjLhs/R
 KWWd8bpAm0oUS2G5GcvuDNXS38DmXjsYRQU/4JupNrA==
X-Gm-Gg: AY/fxX7UWlVisTYBWjCuAf9hIsHKeXiEdNWXJJNYmon5/U/P0HV+vMxS/pf6KhNCSwk
 KLY8Wm/a2cuvGJGN+BbPrl3YeD7CcAok1pc5p38smfgBkytvY5gmcU1lRayMDH7szoBbXvRa69e
 oiDY9bN2WEn+/4GMLFRLSJf20+tcZCCgT7+DeX4OFPzysua63UyZLeu3+1ryOzKroLfkZ6LkE7k
 HNdZTJahQyYhFru4A/YY4CaC18Vrx94axERo3cy1mly0rvpOY3BGQD2o6NBs2h4JmpNJX+0EUJZ
 AO8XJjB3hiesC7AV3mR8i9/53Q==
X-Google-Smtp-Source: AGHT+IHpJuNvcspjhudcKroi4w4CZnZQg0LamS+ZoDBP522o96gRJPsk9O7SwRC6WFPAQUaNHdN0OZWD86WeefDyc8A=
X-Received: by 2002:a05:7301:1983:b0:2ab:9b40:fc78 with SMTP id
 5a478bee46e88-2b05ec3dcefmr7221798eec.20.1766220187412; Sat, 20 Dec 2025
 00:43:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765892031.git.peter.suti@streamunlimited.com>
 <d34e03afc6c5bba074bae1684ca1f74159735210.1765892031.git.peter.suti@streamunlimited.com>
In-Reply-To: <d34e03afc6c5bba074bae1684ca1f74159735210.1765892031.git.peter.suti@streamunlimited.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 20 Dec 2025 09:42:55 +0100
X-Gm-Features: AQt7F2rPBvgObY2E-jwZ_uqWgMUsADw1WT9Xxx_M4ccqFjuMBeSLvBkETCtl-gU
Message-ID: <CAOf5uwmZEeQv5uLGOsdFbaJacA-SJV+696VgF7354=-+y=CA0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: mtd: fix default length calculation when offset
 is specified
To: Peter Suti <peter.suti@streamunlimited.com>
Cc: u-boot@lists.denx.de,
 =?UTF-8?Q?Radek_Dost=C3=A1l?= <radek.dostal@streamunlimited.com>, 
 Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

HI

On Tue, Dec 16, 2025 at 2:41=E2=80=AFPM Peter Suti
<peter.suti@streamunlimited.com> wrote:
>
> When the 'mtd read' command is issued with an offset but no size (argc=3D=
1),
> the length defaults to the full partition size ('mtd->size').
>
> This calculation is incorrect because reading 'mtd->size' bytes starting
> from a non-zero offset results in a read request that extends past the
> end of the partition. This causes the MTD layer to return error -22
> (EINVAL).
>
> Fix the default length calculation to be 'mtd->size - offset' so that
> reads starting from an offset effectively read "to the end of the
> partition" rather than attempting to read out of bounds.
>
> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> [add {} for better readability]
> Signed-off-by: Radek Dost=C3=A1l <radek.dostal@streamunlimited.com>
> ---
>  cmd/mtd.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 1d1845bce44..9f6e3226c15 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -519,7 +519,15 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>                 goto out_put_mtd;
>         }
>
> -       default_len =3D dump ? mtd->writesize : mtd->size;
> +       if (dump) {
> +               default_len =3D mtd->writesize;
> +       } else {
> +               if (start_off < mtd->size)
> +                       default_len =3D mtd->size - start_off;
> +               else
> +                       default_len =3D 0;

Should it fail if the requested offset is bigger than mtd->size

Michael

> +       }
> +
>         len =3D argc > 1 ? hextoul(argv[1], NULL) : default_len;
>         if (!mtd_is_aligned_with_min_io_size(mtd, len)) {
>                 len =3D round_up(len, mtd->writesize);
> --
> 2.43.0
>


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
