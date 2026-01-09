Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8F0D16810
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83EB8430A;
	Fri,  9 Jan 2026 12:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PLfjliaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F71842FC; Fri,  9 Jan 2026 12:32:58 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E57842FC
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso22940315ad.0
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958375; x=1768563175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p93SUb1SqGQPvlNcn68//sFAg/zn1n/V+jUQV6aMsUo=;
 b=PLfjliaM0IekRSRuacK/PfzFfJUWJzKS0NGrlDBJyIwPSIdzWwGISJYCgTNV0T7smD
 a1h/fGQF+rSAG2+FWbTRccRTO18vgEdA6T70f6pETXzTbeynFO3P5AdMTNHG2hlXTyRO
 UVQxFjzdb60MRynE3cuBMd3QZM/OkXm3KaOMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958375; x=1768563175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p93SUb1SqGQPvlNcn68//sFAg/zn1n/V+jUQV6aMsUo=;
 b=SQD/B48AvNCkGodx2V4TpTN9D4fIhmysvYRmwg4u9kvWLn71u7DBVek+cTrBGPFbFP
 s+sWOzUbjTXN9vJQolIh/55xueOtnHSsOc9AeHApGFp0Sccb813nbeU4eRxOKGug7MJr
 F/CKEV3b9W6z1UEk5KxOyqWX+eetUWu6+VbVZOdyEGkFdRVAcd/dUPTH+Bv0E2Kr3UbH
 QeRomZA1IEplJgRO3hY8Qfcd3GVjbB78g0LZfSeX3wk0GVEJzR3/Lgzi8zD7BLCtsrpS
 1/cZTY1tnLIz6mU1v6zunbLl4PWWPdOx1OP330TUNtvT7VjW7zfdt9ijrYkf+izVIfN9
 XTUA==
X-Gm-Message-State: AOJu0Yxlju3o2AcZFiXENxztGjt0mm3ngLAb/JR5AQxHBFiyEmqJUcQT
 Ro4sIrPAk6cD6LDi7HYg/5/Q9EzcHfaqlxd3KnMCcPJ5EUywciBTnKG/IYA97T/BjvGA4+P7nB1
 +eTHiaWUeQtmSEu/4neHQ+oPDf6VqEi0RcosqzoA9
X-Gm-Gg: AY/fxX75XpoUb1vnzqDUkUrpWsQv0nweRxTSIOyS/zzVxchqfEaB1OlnDNQrNjdxvWz
 aQS61/SnVMOkSRxGbIt083kvYms6aP/g4PGR5+C5YmuGX/DXqviomIE9lp0jBt+wHcwMpWrAGJW
 S88hQVYVO8EWK0Y7mwoFb/JWPe4IDI6pYRkRoMzhjy+2PUnwzQ1WjuzF+fVwHJFUR33MJzi79HT
 HKaZLSyAMbMydXdlbRfIuv/u/++4L8o6HcYgG9eqwN2NxqYMm/Q8JGjXfkdOw+4jjvDltQleKJP
 OAY1
X-Google-Smtp-Source: AGHT+IHng2pMQYWKcGIsjM/aoVciXKCkVp1gw0X2LHZnPyLyxqRQvJCQa/yb8Gklu4AiZFo7URMmqrgLcRrFNxI3yNo=
X-Received: by 2002:a17:902:d589:b0:2a1:3769:1d02 with SMTP id
 d9443c01a7336-2a3edb29302mr96765005ad.12.1767958374991; Fri, 09 Jan 2026
 03:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
 <20260108-topic-musb-probing-v2026-01-v2-1-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-1-2a47c6e0e73a@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:32:03 -0700
X-Gm-Features: AQt7F2p9TJHMWVwedLyKDs064ulRp94fa8eTwTFbS6EzhnmDTtYyx3j90bb3rvk
Message-ID: <CAFLszThs+VpJRhbbvG3gH5YbEN16BWDpsPF6wpcErRKbd6yoXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dm: core: lists_bind_fdt: Remove unused variable
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 8 Jan 2026 at 04:17, Markus Schneider-Pargmann (TI.com)
<msp@baylibre.com> wrote:
>
> 'result' is unused in this function, remove it.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/core/lists.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index c7be504b6fc69ec2870a6766eed35cb9eba46a97..52ba6c7bfa007b660b854de62c97ad3c1761f1a5 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -207,7 +207,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>         bool found = false;
>         const char *name, *compat_list, *compat;
>         int compat_length, i;
> -       int result = 0;
>         int ret = 0;
>
>         if (devp)
> @@ -283,9 +282,9 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>                 break;
>         }
>
> -       if (!found && !result && ret != -ENODEV)
> +       if (!found && ret != -ENODEV)
>                 log_debug("No match for node '%s'\n", name);
>
> -       return result;
> +       return 0;
>  }
>  #endif
>
> --
> 2.51.0
>
