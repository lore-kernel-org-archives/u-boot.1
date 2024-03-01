Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21613C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 04:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 576068810B;
	Fri,  1 Mar 2024 05:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ficAL/fI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CC1F87D60; Fri,  1 Mar 2024 05:14:29 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62AD4876D3
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 05:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jassisinghbrar@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a3d484a58f6so267778366b.3
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 20:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709266467; x=1709871267; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouzgym3O4TdUyfKh8W+8rnAW4dZi75m434Knu1kaygs=;
 b=ficAL/fI8+YyH0C2+xh2l1r9iF4P9t/8EQeZdCKCQEiqSEYRSiojqZNTLGQvwp8uPL
 iJpzkyplPqhtH0cnFBBdjq9neoPtF6A7Qqdh75r5rRs9/PUebbu2kKVSq0UIXV6MhCx/
 1gf+SoFuZsjAZUuSwisRnUamgc+cwGmiFpA4hnnqKKFYNSVrb0rRNSt01MQ1ScRlbSKd
 6XCb/bFQj/5nuu5bVEMbTFBl6Xw7BmCbpOJo4SjaGtcoDin6CpYXSFYqhb6IUNWzhqnn
 A3FhXAAMj/hZ4yC4a32je0knLka6KSZdNd+P39eUiof9NF6Wnynda9qtgJm5hiXFh1ie
 oNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709266467; x=1709871267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouzgym3O4TdUyfKh8W+8rnAW4dZi75m434Knu1kaygs=;
 b=Hny4QdOAiWYkPmdjnW/ImyJBbOPVWz9w+CaL418oP4/fe4t0JQbD6s7OUCDz2g8VPF
 FIahhq+4LxuwMxVkFROCz0QObWcgvf68Ob5aMTk/dUs3aDFHoVDz4iCtjcW41Zrod8g/
 TrD/o3nBbjE/hUXWpMR5nYMN7YgZJ/D0mj6X+2Tr+JcslW+VaCzj4FXC7D7YS8aRbTe8
 3YrovTY8nYJ03T53miuqNA7bj9u9CRc5qKnlmst6udP9DgoWOwFVD9GlEzNrVHyoaVtE
 x7jGXw9puNf1LEREnHbAxGRfEDO7TbHzXj/2Cki6n5AQ9ZjhvH5BS0nYdV/xeUAoyuB/
 ai7g==
X-Gm-Message-State: AOJu0YwCFkwk+Ybu57ngiDIHTdb73+PEXe/4RZMbJ/3KImA6by6bHx6s
 XTHaveoeOhmoXRp0ZPI477qMsiBqF19Sa+keT71xX49gMOD7ucBSfMQ9zDPzUh41l0c+Xa8gvHT
 TmBjsUkBDz5VXOzA7NnhLsfEKj/eAI2cR
X-Google-Smtp-Source: AGHT+IG+WaxfSXpTgdKTZD99LrmBlBK7Gbm932ZIyZMVAzU5/XWijaOZJL3w2VIBB/RNP1GVQr3OiG2yaAUeGj7L29Q=
X-Received: by 2002:a17:906:b78c:b0:a44:44e0:868f with SMTP id
 dt12-20020a170906b78c00b00a4444e0868fmr380822ejb.11.1709266466650; Thu, 29
 Feb 2024 20:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20240301003731.2308083-1-kojima.masahisa@socionext.com>
In-Reply-To: <20240301003731.2308083-1-kojima.masahisa@socionext.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 29 Feb 2024 22:14:08 -0600
Message-ID: <CABb+yY1Ty3G3MMe9J387adcWwCPpktvURJxmT4c=8Tp9yX-FiA@mail.gmail.com>
Subject: Re: [PATCH] board: synquacer: developerbox: add myself as
 co-maintainer
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: u-boot@lists.denx.de, Jassi Brar <jaswinder.singh@linaro.org>, 
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

On Thu, Feb 29, 2024 at 6:37=E2=80=AFPM Masahisa Kojima
<kojima.masahisa@socionext.com> wrote:
>
> Add myself as co-maintainer for SynQuacer Developerbox,
> as I'm currently working on it.
>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> ---
>  board/socionext/developerbox/MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/board/socionext/developerbox/MAINTAINERS b/board/socionext/d=
eveloperbox/MAINTAINERS
> index c6d4f2749d..d772bc3b4c 100644
> --- a/board/socionext/developerbox/MAINTAINERS
> +++ b/board/socionext/developerbox/MAINTAINERS
> @@ -1,5 +1,6 @@
>  DEVELOPER BOX
>  M:     Jassi Brar <jaswinder.singh@linaro.org>
> +M:     Masahisa Kojima <kojima.masahisa@socionext.com>
>  S:     Maintained
>  F:     arch/arm/dts/synquacer-*
>  F:     board/socionext/developerbox/*
>
Considering that I no longer have a Developerbox, maybe remove me as a
maintainer too.

Thanks,
Jassi
