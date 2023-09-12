Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E90EE3F0C
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 19:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFD986E1F;
	Tue, 12 Sep 2023 21:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FqqtGsHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510C486F63; Tue, 12 Sep 2023 21:27:09 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D43686E2D
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so10344226e87.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694546824; x=1695151624; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FC0Ais9AX2a85o4hH2ofgt8F2OM6mrN7ZLXJFAx0N2o=;
 b=FqqtGsHTQkxvnoJOUT0HThPgiMELyyWixZZCoYB8JIHHrqqkG6uyAqo58Djlb0FFSH
 sSXtmkOxMaObByhGtrPwz2H31ptRC0i0Psz+iYpzcxvDbSWIlIW5ehiq4fp4RPCN+SkJ
 mYC884cS33qTeXoJEa9nDIGnmq2HqlPqW7MuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694546824; x=1695151624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FC0Ais9AX2a85o4hH2ofgt8F2OM6mrN7ZLXJFAx0N2o=;
 b=JrOx8aAFFrrWO/C1dihLrjwV8t1O0otd5spX7PHXM8jEeKSfe+e4SEE8eGkTcX1Ttg
 7BFoW2lfJs0Y7xYEkcmAa5/eThx59owPabKfOdSuSRGaRcTFqSw1844BGHAHCJG2dnVc
 opL+uaXOsFDEQajOPeg6yri18EgsX+gpgy9WS9PbsjuBUFPcj0iv4hqA2308Z3Mtw3HT
 /wCYJDA79o4Yw1QjZ7tJvkAL6wif1hhoV2hmvHvCsTFGOj3Mp/V/2uk5DSK7Gl0RIahD
 uNUI4ij0RM2lHkGhenv6jTDkxRVcTYGKcX9tinwqt/sHEb7EiZxn3HD6+L9LzRW5BUZR
 FRZw==
X-Gm-Message-State: AOJu0YzJ9ed399V3yqfk+jl4lNDm8KV3i/pHKwgVgQduW+tVBbGItHZX
 Fhxi1RbvNmxqIjC02dOBsdDlt0r6JcRXe2oMiW9iQQ==
X-Google-Smtp-Source: AGHT+IGsFSHuz+VayndxwTc7TDQd3RGdWvy1k2qVVimI10lf2x6dwVBfL8Yrzjmvil7JntQGvj62T7dh+OJ64VcyWgw=
X-Received: by 2002:a19:ca14:0:b0:500:7fc7:852f with SMTP id
 a20-20020a19ca14000000b005007fc7852fmr326809lfg.39.1694546823534; Tue, 12 Sep
 2023 12:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694435541.git.michal.simek@amd.com>
 <734d41ddc4b5711fd93d3292d7049df3f11472e2.1694435541.git.michal.simek@amd.com>
In-Reply-To: <734d41ddc4b5711fd93d3292d7049df3f11472e2.1694435541.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 Sep 2023 13:26:47 -0600
Message-ID: <CAPnjgZ0bCzF+q8xpo0-pRBQrHMT50tV46f6369-Wjo4OJwm6Uw@mail.gmail.com>
Subject: Re: [PATCH 1/3] trace: Use 64bit variable for start and len
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Mon, 11 Sept 2023 at 06:32, Michal Simek <michal.simek@amd.com> wrote:
>
> tputq() requires variables to have 64bit width that's why make them 64bit
> to clean alignment requirement.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  tools/proftool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

I would have thought that 'unsigned long' is enough on a 64-bit
machines? Are you running on 32-bit?

>
> diff --git a/tools/proftool.c b/tools/proftool.c
> index 101bcb63334e..869a2a32c510 100644
> --- a/tools/proftool.c
> +++ b/tools/proftool.c
> @@ -1493,7 +1493,8 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
>  static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
>                            int *missing_countp, int *skip_countp)
>  {
> -       int start, ret, len;
> +       unsigned long long start, len;
> +       int ret;
>         FILE *fout = tw->fout;
>         char str[200];
>
> --
> 2.36.1
>

Regards,
Simon
