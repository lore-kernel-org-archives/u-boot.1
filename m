Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C39EC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FFB48788C;
	Tue, 26 Dec 2023 10:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m6SrMsES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30067878C8; Tue, 26 Dec 2023 10:47:19 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1CC28781A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d9bba6d773so843116b3a.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584035; x=1704188835; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHl5gwxpnjV6Cqeki5wF7B8gImPR71mbVOWn4UU+pGw=;
 b=m6SrMsESljSyGlIUlyCYRaVitXcNf1HcAkKfX3DmqRTTNxn6xdsf5hqtTr1SnvTZSv
 9zjqZbksz0mXfbVIBHChI076aOwPF9rHdhyHrf2CAs6QNVq14xAD5jMae/kdVOtCyQRp
 n54tE1v3DqxwrcQzm3MunwveyOTvCbEP/5/+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584035; x=1704188835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHl5gwxpnjV6Cqeki5wF7B8gImPR71mbVOWn4UU+pGw=;
 b=d94ZS0NqWp3wkECjtdGd3UHWboSHyHafWLQkbVOBDALvPJL/o+IAGFZLarVQxHlh8f
 BkHKFf4pYmunnHTjzwE9fqhwtV5l9mRDadVX2iyXEsTNkhWZeR39tFelC1x792TDvXXQ
 q+J/yXC6cPzgOeVY6MdMCUzF15+lb4HmmD+pwKPknWYOrAbsdkAYHAi55vztxrJNODzF
 TStxlmXOV96GHNQEPP1TWKjS07Y5hCv8ymUiepxU32p6tTqvSHkn+eB0AciTiuqMm9Vq
 a77epzFwOHpdbmjw4kZ/eTqh9PKbDSRGE/ET9836jayX5UyUhi7AZsfH0XjKCFG0lgNx
 IVpw==
X-Gm-Message-State: AOJu0YyjSDAo1W8TxsRfL+vcHJif8Xr9hlVad4eeIYe/KNGUsAtHTq8I
 ekH0VwBTwaekBywZjxUUrwAZ/OystgzPVRXale/ZGfbGufYR
X-Google-Smtp-Source: AGHT+IFru82QhQvLWtiR0hGsYVaJrEwO3FPqZ9Vw8sxcBFGVEALCCSE7yD+SGB88DRPbRw4k5ENAtf57n3nPSXsYlwE=
X-Received: by 2002:a05:6a00:11e2:b0:6d9:bc74:542a with SMTP id
 a34-20020a056a0011e200b006d9bc74542amr2227146pfu.58.1703584035259; Tue, 26
 Dec 2023 01:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20231219115741.3681175-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20231219115741.3681175-1-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:00 +0000
Message-ID: <CAFLszThGpG9Na6zsLGyiFF4Xm0uCwm8+Vg39RoNYfkHMBM8Pcw@mail.gmail.com>
Subject: Re: [PATCH] cmd/mem.c: use memmove in do_mem_cp()
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Tue, Dec 19, 2023 at 11:57=E2=80=AFAM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> There's no 'mv' shell command for handling overlapping src and dst
> regions, and there's no point introducing one, when we can just make
> the existing 'cp' command DTRT in all cases. memmove() should at most
> be a few instructions more then memcpy() (to detect the appropriate
> direction to do the copy), which is of course completely in the noise
> with all the string processing that a shell command does.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  cmd/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Is there any size growth? I assume not.

>
> diff --git a/cmd/mem.c b/cmd/mem.c
> index 66c2d36a148..c696b92a274 100644
> --- a/cmd/mem.c
> +++ b/cmd/mem.c
> @@ -361,7 +361,7 @@ static int do_mem_cp(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>         }
>  #endif
>
> -       memcpy(dst, src, count * size);
> +       memmove(dst, src, count * size);
>
>         unmap_sysmem(src);
>         unmap_sysmem(dst);
> --
> 2.40.1.1.g1c60b9335d
>

Would you like to add to doc/usage/cmd/ and test/cmd as well?

Regards,
Simon
