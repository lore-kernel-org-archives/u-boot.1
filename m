Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7272DD3000E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54CE891CE;
	Fri, 18 Oct 2024 16:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D+2isLO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191BF891C8; Fri, 18 Oct 2024 16:08:23 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF029891B2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso1839787a91.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260491; x=1729865291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4l9en/QP3twgfIkeCNJ0d5j6r3n/UUY1CMHt5BYNR+k=;
 b=D+2isLO7GWejQaykFW8AERN3IoM0QtxSHDznyIx8i+A8NPXMilSblSzZZywwVtUtKy
 5/j5DENq8dYP7bjdq8L4++EetaGUT+g7sGidqlGswsQfoPiGhGUU4eT6l1J3q5KlU1bL
 n/0rpSv1X/UKQzFnZOMw/bFUjuBlHpXDTnXmPtPef85iy8zAZxaZdF1H8na35vhZbWs3
 D8vimnMe2CM4Qw2bik3YlifOjkySIZjPmuY5EiCpcmbBenHGeStrrsanc+kVFZtzqB/n
 H0WoroefTe7AMQIBEc1BO58eYSl+Qb+T2FVBiX14QvKtpnVkJiEc2kS2ZybyBKnKvDRw
 7Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260491; x=1729865291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4l9en/QP3twgfIkeCNJ0d5j6r3n/UUY1CMHt5BYNR+k=;
 b=ijq2RCPT/lCNuAKQ+R8yJjO0eKrpYBh5JBGaiT4zBlQGRS4YjCGVsIG3UtheTxfxsa
 +G2Cauh1Ih6BUrcXZ8OFk5Pg0Xou3lrJGJRv/8RfUnTt6cgDjwB5YMiBs18mSj72LO//
 eKK7olDp2/NOW+kV17pKZYL9DncriGhoKZNZ7rNZxhqz5V2VAM6+f6Yy+r81zjUaWGPz
 OvNN0vbeyM5kZ/vCf5dqPTsW7B5XA0kv92FGok+fBDYMWJ2SS6xLNLQ74cv3VKE8KNN+
 t8QAfH8HZaZGXoYP1S6arudnrVKNu074fA94tDaqDU8c9Yb9XY8ZO/yN27rALM+jnDsl
 SJ7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiUtWaCSRkZ2YfDZLgamzuqB4XixhXWp+fENwrL+CvAl7Lepue9bFQZWBDEhQ7shABY5jpZT0=@lists.denx.de
X-Gm-Message-State: AOJu0YwnDjyNCZLm3+TKHq/jdaWQkmmYQecXGSME2ryvNfzT5JRT6LpN
 9s4YhM+54mPfNS4d1V0w0hPVZwPenDL/nyzzQ0cavqzK62CyNGsiMawlLXUIdSQVpD2fVpYyF6X
 dvu1sSkr7EqP7mnAkPRoBEA3u1mVADehaT6ErVcHPb2b2E3W+iZY=
X-Google-Smtp-Source: AGHT+IEGqe4Yh53qthcxH9FmbNGFccvVGBFdCIW0OKKNs68sH4VwUx8yA3TqWFPSfQQ7HJV4I/hF+53pwCRQGKCZPO8=
X-Received: by 2002:a17:90b:881:b0:2e2:8f1b:371f with SMTP id
 98e67ed59e1d1-2e561a0124emr2735062a91.26.1729260491415; Fri, 18 Oct 2024
 07:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241018135112.3978130-2-caleb.connolly@linaro.org>
In-Reply-To: <20241018135112.3978130-2-caleb.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Oct 2024 17:07:35 +0300
Message-ID: <CAC_iWjKS+WkJxVszJjRXg9f-uz7=bgt+8z_cT81_s4H7F-XWeA@mail.gmail.com>
Subject: Re: [PATCH] lmb: notify when adjacent regions are added
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Thanks Caleb,

On Fri, 18 Oct 2024 at 16:53, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> lmb_add_region() returns a positive integer if the added regions causes
> existing regions to be coalesced. We still want to notify the EFI
> subsystem about these added regions though, so adjust lmb_add() to only
> bail on errors.
>
> This fixes EFI memory allocation on boards with adjacent memory banks as is the
> case on several Qualcomm boards like the RB3 Gen 2.
>
> Fixes: 2f6191526a13 (lmb: notify of any changes to the LMB memory map)
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: u-boot-qcom@groups.io
> ---
>  lib/lmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 78fe2d4de7c6..7e90f178763b 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -486,9 +486,9 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>         long ret;
>         struct alist *lmb_rgn_lst = &lmb.free_mem;
>
>         ret = lmb_add_region(lmb_rgn_lst, base, size);
> -       if (ret)
> +       if (ret < 0)
>                 return ret;
>
>         if (lmb_should_notify(LMB_NONE))
>                 return lmb_map_update_notify(base, size, MAP_OP_ADD);
> --
> 2.46.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
