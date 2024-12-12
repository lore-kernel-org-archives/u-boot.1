Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76114E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F585801BD;
	Thu, 12 Dec 2024 23:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sk0oqV+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75087801BE; Thu, 12 Dec 2024 23:34:36 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31839801B0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6eff8289d0eso12307617b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734042873; x=1734647673; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zP2WjrrQxfDVlDyIqTFdwoqzzVyoaV0B8J184sQTSt0=;
 b=sk0oqV+uqd/OOQjasSvqxXfVtI/uSu5ksPguS+reFg200h9RtZbmyTFMzNWQTeNTjw
 MDPWnOPv7VBxFSkn22SJORIp4dkT/v5nFQhpuX01u6RBmxlpQslhUAK4D7Ns4bKYxbSm
 ps0m8QdEjlymMDi6MWvkS30W7aX9rfqGeATEAM8uvqZlonj8f4EZOtfaOxwrWiIlQqGB
 SZ7okwtAUzNtH7bD47XgYfGotiyiPlW+LPRwtnnPA4/q0LKAU7FlFXH8Vuy5UjA6sGu/
 5Mezc7botzPZf4meWD7MHVADKsfDAnqK1oUFir81EoRZD6tudbC5JWXRui52dCt6Pubw
 OeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734042873; x=1734647673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zP2WjrrQxfDVlDyIqTFdwoqzzVyoaV0B8J184sQTSt0=;
 b=CcXfZ5b9ezRSE+Qpk5lXen2wBP84LxrpeLJRAkp/2AD8ObRnPH1ZpbezeVOr0PgBIe
 5Ty9eWKr8EgKogYK1hLDeiqly2EfV1F8msuCcenecx5ybsSleV/3Jvn3pVhXfP+WE62U
 pn+Q78c3gQDaJyycup8St5pj5q9JO8ps5ZALfw+cS7exP0EyQFrUZZ1T1RBWivZ+p7x7
 p3MdeLe5oxH/+TO2fQN1CrEi/xKfvYuqfr3Cc8NUTipbNwxaVgHh9Bb4rHtxeGvfj8fG
 Hy2i8U1y2uPTSKERsdsrrL84E11Vrx3Tl4bRumvq6uw5XXrQksXrLJlivGNpW0ny4dJt
 1dzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYxhYsgBA8fCosLCHFDTNP/UHS4WpVSkyXgRpTVpL1fcYne41y5uRoGqQMPMN0GXesWG7cLqc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6S1tk+w+oZ5BchEmdtg8sB62QaGhbyHQAcjG0IDUkHWes1Lw/
 r9qQTzCwP2WRGMCK8g+bMsEq2FE+37oF1wqvd06nJTy3DTD8e8eh8CQlFHpTLiaGEhW5uwSyKBG
 ol72KM5icl/TOw9M2gcriZq2UQe/B/K3aougvxg==
X-Gm-Gg: ASbGncvrjg2JGtYGR3an4Htpw5fV1hd0177HpSVGf4vpR85JxXZQOPlBrPK2SdtA/O+
 8RHOp20MrQGv5eCORDST9JL9nItQZjSqvayG8Sw==
X-Google-Smtp-Source: AGHT+IHPHLYmCtIjBPQvkYCo9tztr/GmCmhiI57G8RhlE3ANBB3g4746Vs0CUW/BMFf96cldYkUzG0mh6j8bqvnkKYA=
X-Received: by 2002:a05:690c:f88:b0:6ef:a227:c082 with SMTP id
 00721157ae682-6f279b01c10mr4268667b3.14.1734042873024; Thu, 12 Dec 2024
 14:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-7-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-7-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 16:34:22 -0600
Message-ID: <CAPLW+4=9EfzWwYE_X+-AnZUwky6+MOF4V73BsqOaoMcMS+EGmQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] lmb: Remove lmb_alloc_addr_flags()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Wed, Dec 11, 2024 at 4:55=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> lmb_alloc_addr() is just calling lmb_alloc_addr_flags() with LMB_NONE
> There's not much we gain from this abstraction, so let's remove the
> latter, add a flags argument to lmb_alloc_addr() and make the code a
> bit easier to follow.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  fs/fs.c                     |  2 +-
>  include/lmb.h               | 10 ++++------
>  lib/efi_loader/efi_memory.c |  2 +-
>  lib/lmb.c                   | 15 ++-------------
>  test/lib/lmb.c              | 34 +++++++++++++++++-----------------
>  5 files changed, 25 insertions(+), 38 deletions(-)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 21a23efd932d..99ddcc5e37be 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -554,7 +554,7 @@ static int fs_read_lmb_check(const char *filename, ul=
ong addr, loff_t offset,
>
>         lmb_dump_all();
>
> -       if (lmb_alloc_addr(addr, read_len) =3D=3D addr)
> +       if (lmb_alloc_addr(addr, read_len, LMB_NONE) =3D=3D addr)
>                 return 0;
>
>         log_err("** Reading file would overwrite reserved memory **\n");
> diff --git a/include/lmb.h b/include/lmb.h
> index 3db35992df8d..5e59915340b7 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -92,7 +92,6 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u3=
2 flags);
>
>  phys_addr_t lmb_alloc(phys_size_t size, ulong align);
>  phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t ma=
x_addr);
> -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
>  phys_size_t lmb_get_free_size(phys_addr_t addr);
>
>  /**
> @@ -113,8 +112,8 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ul=
ong align,
>                                  phys_addr_t max_addr, uint flags);
>
>  /**
> - * lmb_alloc_addr_flags() - Allocate specified memory address with speci=
fied
> - *                         attributes
> + * lmb_alloc_addr() - Allocate specified memory address with specified a=
ttributes

One character over 80 limit trips my OCD :/ Any chance you can move
"attributes" to the next line? It's ok to break the line in kernel-doc
function briefs.

> + *
>   * @base: Base Address requested
>   * @size: Size of the region requested
>   * @flags: Memory region attributes to be set
> @@ -125,8 +124,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ul=
ong align,
>   *
>   * Return: Base address on success, 0 on error.
>   */
> -phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> -                                uint flags);
> +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flag=
s);

Can we keep u32 for flags everywhere, for consistency?

With above nitpicks addressed, feel free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

[snip]
