Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310F8C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 06:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F80A8187B;
	Tue, 28 Jan 2025 07:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gh/llCDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9699481875; Tue, 28 Jan 2025 07:53:47 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EEB81875
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 07:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so7530940276.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 22:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738047224; x=1738652024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9LZejaVnZzx+zrtZq+WztkYXPpH53coDvidGHjWhb4Y=;
 b=Gh/llCDmdY9QJAuNKuFh2qtYt45r0KvDivyrg/qhP1Q+qo/7GTDsM8SWMJEAwZHLCz
 uqUG8e9gFJnnZTfm6nlg03fTSFozxx7Y3dUkylDT8tVRcdZAxTxafKIyASnLW6rM6y65
 FYxFhN1xI6Gh0xlWe/aFGGhMoX4FF/dS//cxR+7vZuCKeQnIDz4LqzI7RDtPx5OJCrGj
 BzY/PCi4hF+q6S0J2OPdDUZYM/93ZBq8dfRmorVccePwPNrBz/OJIefmOAd5WQmZBp5g
 chhG8H/e8EB11k2y2N4TG0MqbKFYtkowtdYA8ZCBPWFWhMaFs3YTbATp+jlrivjOsgsz
 r9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738047224; x=1738652024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LZejaVnZzx+zrtZq+WztkYXPpH53coDvidGHjWhb4Y=;
 b=BFKWA/rgeggdB6JLNGiVIhwumJFE/4rzW9KozmGWEzrckOWd4LF7NAcOG9JhTyTwIR
 rpF1Sluj+xocTQqqAPMw9lwO3qyjTgGUHL6CwfdoR8RaaI/2moqOuJ+Xu9hUWUNIHkxJ
 45oS1v3X+nOM5c0TANbTXGf+BI2CnnS7qbJ1D5x0y3bMkeTQ9bdVa7PWalNnF/Ui/9F3
 JRh0sZyNEyASXrYT9S+diIaWjYvHwdjHHJpkLUnG7MiggNYdlDLI09ORDl1qNQxnXlOR
 kvquWLiRHsKEHxCJT0R00kPmn8AVesWKlIgCoOtMhxGm8tMXPDWlsKRP+C9vlD9DZ8rp
 8eqQ==
X-Gm-Message-State: AOJu0Yzg2sh5zxdiBcDb5CWgtDj+E5BB6SBn90gXduvN1WO6xCyzHOKz
 vbUQzLneaOlVjpsvrtZFQA4ehjK6+7vR7ObVPlXY9MrCypoK+bLmJSotsBSTTpI6kGjgBgIyXFw
 bJFpipTTufEZsGRRLUBU57/9fDF2AdvAqSot6bg==
X-Gm-Gg: ASbGncvYrjd9ulxkd1lHSONjjHHh4AG2P6zMJF4Rqg/vcwU5DLZceY79NXExgNPzH6H
 q1BsbKwe9UXJsxnLHv6K7zkmmivTWRFa774ihje+5VatWco0Rn+il2th6VrtJFixrgoYxlmfz
X-Google-Smtp-Source: AGHT+IH0X6BElHSyQBD/E4M4IfYa/08vb5GpOJPNsgnfD9DrcH7n7fmL6erb0QivI+trKfImskX0sBCx2nPtlqtyclo=
X-Received: by 2002:a05:6902:1792:b0:e58:12d0:5d93 with SMTP id
 3f1490d57ef6-e5812d05e6cmr18507873276.34.1738047224244; Mon, 27 Jan 2025
 22:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20250127145855.645845-1-raymond.mao@linaro.org>
 <20250127145855.645845-6-raymond.mao@linaro.org>
In-Reply-To: <20250127145855.645845-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Jan 2025 08:53:08 +0200
X-Gm-Features: AWEUYZnU7PfJcwEtD5Jnef9jSHibhkX2uVOHDgj0DKF2gmHciEnkydAQUYF62AA
Message-ID: <CAC_iWj+E5H3ENN3qpqB5v=z=d+TNsPG5SWCBNgX9yBzu+d0SfA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] tpm: PCR allocate during PCR extend to disable the
 unsupported algorithms
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Mon, 27 Jan 2025 at 16:59, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> During PCR extend process, if any unsupported algorithms are active,
> try to use PCR allocate to inactivate them.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> changes in v2
> - None.
> changes in v3
> - None.
>
>  lib/tpm-v2.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index aa02a9e961..9ca7933c09 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -344,7 +344,10 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
>
>         if (!tpm2_check_active_banks(dev)) {
>                 log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
> -               return -EINVAL;
> +
> +               ret = tpm2_pcr_allocate(dev, 0);
> +               if (ret)
> +                       return -EINVAL;
>         }
>         /*
>          * Fill the command structure starting from the first buffer:
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
