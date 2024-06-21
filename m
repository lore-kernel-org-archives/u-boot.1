Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5583C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB8688579;
	Fri, 21 Jun 2024 16:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gCNyBl7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773AE8853F; Fri, 21 Jun 2024 16:58:09 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6598D88578
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4403bb543a4so10624071cf.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981886; x=1719586686; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=waNIjeRa3fZhyWO/+Tzbw9sK7ZtUEB+Z8e2cI7GKCx8=;
 b=gCNyBl7v3RVfErzHuZEWmTq0CKI/PbMg7S0BtgrAEq7aKl+ziwtRCc5Onvosp39Qy2
 3hMTlkiTLiVvkNWnPvv2tx+FTegYajNJGKYrxca/NlBcxtierYY95kXMqAPn2K1eEOBo
 MxzLO9xt3thHX/WCODQ2mSuEBEFmawFJyVnjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981886; x=1719586686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=waNIjeRa3fZhyWO/+Tzbw9sK7ZtUEB+Z8e2cI7GKCx8=;
 b=qBAuiAwKCIysQbQB3XlfuqGtufmyacJwM7UnNj0NChU/6EHft2zC6kJPH6WeDqEQsQ
 sX1FU/9P+Zm+shk8VZFAg7Pp+s5GqvKtundoOKBhU1RIeYuA7Aq8AnXUxwCc06jpo2YU
 d0jPducri63xnIsdN9j5iRuZffz/OJ3ymnZAqyhnJ4mnj+HhOt2dkGcrb9EP9UG5Qx4c
 +gZsmkaULtinwhIGxA9q5egkoeySHDYBxeUXw/crEOn5dRzfsWpL6Ums13lR/hTsMmRs
 thwr6OxP39ow9TsnSWkO6y3ZqlJnUEK/nw0vfZiZ/ffALMEGCceA3CSaJSXYcwCsPsf+
 vGhw==
X-Gm-Message-State: AOJu0YweGUZeW+puEP5Ld1Jz66rbgn4ilVt0kyXondSJ6j4aZhqeroMB
 qjbnD6R8X5QpTl6h0odBS/nx+SP/sO6Xq6wYcJJrAFyxi3JLAjPVmqIMjA1Hlye+f5HdPunuKhX
 4yuV1WaVVSfrjlDztrbfZpNUo9JPJCe/js3iZ
X-Google-Smtp-Source: AGHT+IFFtzwJB0YFFgEtb6fZAqEONqF3C+HQekBFzSdaubFHu/lwI2d+9SyX08aI2HpXP136+UAtoN3AzP7LqbpZ3rI=
X-Received: by 2002:a0c:df8a:0:b0:6b0:732f:b92b with SMTP id
 6a1803df08f44-6b501df83cemr88716316d6.12.1718981886269; Fri, 21 Jun 2024
 07:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240621074720.203001-1-ada@thorsis.com>
 <20240621074720.203001-3-ada@thorsis.com>
In-Reply-To: <20240621074720.203001-3-ada@thorsis.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:55 -0600
Message-ID: <CAFLszTikOqmnipVCgBxNHCJASTBS0-bKDu09EYq7zrGc90GTbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: develop: testing: Fix reference to test writing
 section
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Fri, 21 Jun 2024 at 01:47, Alexander Dahl <ada@thorsis.com> wrote:
>
> Fixes: fc3283314539 ("doc: Explain briefly how to write new tests")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  doc/develop/testing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Please do always add a commit message


>
> diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
> index 056bdfd2b69..9114d11ad26 100644
> --- a/doc/develop/testing.rst
> +++ b/doc/develop/testing.rst
> @@ -123,7 +123,7 @@ or is covered sparingly. So here are some suggestions:
>    is much easier to add onto a test - writing a new large test can seem
>    daunting to most contributors.
>
> -See doc:`tests_writing` for how to write tests.
> +See :doc:`tests_writing` for how to write tests.
>
>
>  Future work
> --
> 2.39.2
>
