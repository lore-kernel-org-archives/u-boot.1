Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE40CC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3077888936;
	Fri, 23 Aug 2024 22:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b55IoWqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9044988C15; Fri, 23 Aug 2024 22:47:44 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68F388C13
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-45327512c3eso13479171cf.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446060; x=1725050860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y9PT3dyggftlSGvZbMiCqGQ85BY0LfbhmVObUV6qypg=;
 b=b55IoWqeyROf+SnpNpiCB2ANWHxcrNyfVEqVkowh+LNHCGjtWrMhHTNXzmN8QpXKXK
 7OBdP43ETRuvr6z6Ys4bcBdUFryrKotifBW5HYRuJNXg4RkGAiToao9lzZIapke9gUUy
 FF6ws1nf6cEAOhC++dcHSksKT8Fkr+XsWqbg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446060; x=1725050860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y9PT3dyggftlSGvZbMiCqGQ85BY0LfbhmVObUV6qypg=;
 b=dbpuL6kGrlWWj4wh9W0j1D+RniBOeQtyGvnlGqTtSsd2rmQ6ths8vr9YVVLv17YuUG
 GEzOF4Vvnb5NMaQHTyONDIq4huRxYZFhFuEqIOS/Rx0j30O9ZL2bBIVRIBkjdRIxiuBo
 1jRkTBjAUGjhqHHtAIthaGpdklrZmfyI2q/Ltn2yOkP0Ue9KeRfYmNt14SkEdV/kr83C
 sEk/qK7kdPTZc1WpA4Xu1lgwyszX5BU1Sh/NG1ibFA4r4SnQ3Myrx1oyQsFvB5XNbRR3
 slcwaZVvKRUsNfb8h9PBGbEIO/lvJSORmhxv4lmPPtVdfkq5G6auZc7c0lLgj6URngM2
 K6Yw==
X-Gm-Message-State: AOJu0YxUPNoWRvWxLzrXVhwZ0khmIyXDtqr1lQmad2NWbLcTt49bwZk7
 dWaahUZ8WKjUvv9KUy1NgEqYhljx1WPObR1DSLVsbzYEzwzfSt9O9ELA6T0jJMpeANR5yPuXYCv
 2TrCg1b/vREjyjKiV4hY9NZDuF96HKbdC0ugt
X-Google-Smtp-Source: AGHT+IGEcNbPBohp+NlxTIH0nR+3X92stN//eZVsbRh9FQ5kPVtveLNNjLRodvapOZ1ZizFz9JElsZ7CPIr2VAg1B04=
X-Received: by 2002:a05:6214:5d06:b0:6c1:6b00:600 with SMTP id
 6a1803df08f44-6c16df10391mr35348906d6.35.1724446060632; Fri, 23 Aug 2024
 13:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821105839.2870293-2-sughosh.ganu@linaro.org>
In-Reply-To: <20240821105839.2870293-2-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:47:30 -0600
Message-ID: <CAFLszTj0LGWAcrC9DYXnMdOSfTFJfK--oWMvLbJB713v+M1esw@mail.gmail.com>
Subject: Re: [PATCH v3 01/27] alist: add a helper to check if the list is full
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

Hi Sughosh,

On Wed, 21 Aug 2024 at 04:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a helper function to check if the alist is full. This can then be
> used to extend the alist.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>
>  include/alist.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

I would still rather add an alist_insert() function, but we can clean
that up later.

>
> diff --git a/include/alist.h b/include/alist.h
> index 586a1efa5c..68d268f01a 100644
> --- a/include/alist.h
> +++ b/include/alist.h
> @@ -82,6 +82,17 @@ static inline bool alist_err(struct alist *lst)
>         return lst->flags & ALISTF_FAIL;
>  }
>
> +/**
> + * alist_full() - Check if the alist is full
> + *
> + * @lst: List to check
> + * Return: true if full, false otherwise
> + */
> +static inline bool alist_full(struct alist *lst)
> +{
> +       return lst->count == lst->alloc;
> +}
> +
>  /**
>   * alist_get_ptr() - Get the value of a pointer
>   *
> --
> 2.34.1
>

Regards,
Simon
