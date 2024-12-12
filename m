Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4184AE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9043D800A5;
	Thu, 12 Dec 2024 23:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TxBYF0JZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C266801B0; Thu, 12 Dec 2024 23:45:59 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678E680092
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6e34339d41bso9826517b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734043556; x=1734648356; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znfYpBOqx+g/RQQi8O4UXm+86iFkJmEC75vYpLsnnWw=;
 b=TxBYF0JZz88XtmZiSE7iW6Yxu1sNxNHKy7sWSYZ7NPiII9WIzRufIwpAa2ocODHD69
 JFB4V6X4IpgMmv7qNrU0bIPohy+UGN8LsyAv3jVa7Ic5pPFo6jKNcbiIV4XlfvpJGdn7
 hp6TZQAau0dimGRSpdmgXgi2XBF5QUcwCz23bIbMd8omuvOaDEHIZ5B5M3DPtrtuEzMC
 cgSrqZQErRVI00lNynPnkIFJwhB0lJMfsJFWN/416fzHTl69LNpe2S6YWWZ7PsBxqCys
 C07qXcUjXs8sXzMvXqXgzBbQvtabX8mG7EpntkEWKwh1HYY77nxFAtPLkqw96u1FCg5j
 wG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734043556; x=1734648356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znfYpBOqx+g/RQQi8O4UXm+86iFkJmEC75vYpLsnnWw=;
 b=VB594HkqnR/yaAH5X6YXdQe1FULr411++kJ3WUP2r8zdfJmj/TsEHk1KujIxNyDXJR
 ZWlFJh6U8g+jUpyZ4ytt2oUrimC5flryo9rYXPp+/GTRjsIgc54OimqGSn4qnsfZsTgD
 nTMCmG2fTmStHItfvy+yh7x3hIYK1hf98UxObdgpvEKeWIqo2gnJao5uxwZbBh34w+yX
 y0ndClHN+9BZ9o+pMYyOBjzdxRx5Po+jBh6cAICtWPGeOBk7W3exrpi3fAIgtafrbEGZ
 GiBOnXIvx+h3P7xCB1c4XX0TwsLcWq/pSk/mvbiAboQnFcKqXad0tLw0mM8Jhe5j0hae
 dfqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtiMTKz97zX2e4nj7eONldSqs/XQ5WA8e9Ti1oEMcoU0RRrU9eOH+VB/FfAei4jzyv7NxHf/c=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfzwnd+ejQCn3lSBhC6LqDAx7oKQMixNyOp/3qpr22OnXbXpkl
 tSuz10g3UhoMl2Dopez9/4Nz5TZhe8qcu13O3lXGpGXeltcvQ3p3sTZlqE4ksS1FoMN2+dvlymy
 0Xq4HvFvvP/Rf/2KNShq6jJPAukkFWF5SR4Yamw==
X-Gm-Gg: ASbGncvq+iT4BDErnblvSLL9pi48HWbRi7JgwD4AWtocvYq1pKbGm9kJ+r4sP8C/4YN
 vvcS41HU8bmWrH3NdgfMLAcUcLVp5H7brITAs9g==
X-Google-Smtp-Source: AGHT+IFD6qOKXn/yAoVuj0STPBwalj/3i0xfSsydfcdxpDZxFRNwFwzeT9ndrEtSZ5io9EtuB1IWBABy0vRhbA/IEQI=
X-Received: by 2002:a05:690c:6301:b0:6ef:6035:828e with SMTP id
 00721157ae682-6f279b9bbb3mr5243487b3.35.1734043556253; Thu, 12 Dec 2024
 14:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-9-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-9-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 16:45:45 -0600
Message-ID: <CAPLW+4kfC2gPB-Yw0bbzXm1s_nj_BA7VnG7UWDs1bnEYafOvQQ@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] lmb: Rename _lmb_alloc_addr() to
 lmb_alloc_addr_flags()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Nam Cao <namcao@linutronix.de>, 
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
> lmb_alloc_addr_flags() is a wrapper for _lmb_alloc_addr() and it's the
> only function using it. Rename _lmb_alloc_addr() to lmb_alloc_addr_flags(=
)
> and remove the wrapper.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  include/lmb.h | 2 +-
>  lib/lmb.c     | 7 +------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index d481972a6686..76fb82b197a9 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -123,7 +123,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong al=
ign, phys_addr_t max_addr,
>   *
>   * Return: Base address on success, 0 on error.
>   */
> -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flag=
s);
> +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags=
);
>
>  /**
>   * lmb_is_reserved_flags() - Test if address is in reserved region with =
flag
> diff --git a/lib/lmb.c b/lib/lmb.c
> index bdaaa634abd1..7ca44591e1d7 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -748,7 +748,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong al=
ign, phys_addr_t max_addr,
>         return alloc;
>  }
>
> -static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u=
32 flags)
> +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags=
)
>  {
>         long rgn;
>         struct lmb_region *lmb_memory =3D lmb.available_mem.data;
> @@ -772,11 +772,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base,=
 phys_size_t size, u32 flags
>         return 0;
>  }
>
> -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flag=
s)
> -{
> -       return _lmb_alloc_addr(base, size, flags);
> -}
> -
>  /* Return number of bytes from a given address that are free */
>  phys_size_t lmb_get_free_size(phys_addr_t addr)
>  {
> --
> 2.45.2
>
