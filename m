Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D68C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF3080C83;
	Tue, 10 Jun 2025 09:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p0SYA/x7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8256C82AC4; Tue, 10 Jun 2025 09:19:12 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D73B8070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e102eada9so44622587b3.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749539949; x=1750144749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0W0VzrnSXRo5zrYh0VkKrKdZ9S3DeoYZDeEzqIl2lUk=;
 b=p0SYA/x7S/da+JhuCXalcm+MM07aUbZbBdW66qWU05SO0+dmp8mvx4H0UzshWQMQ5L
 SB+cf8wkDWY4NajxxSiFptZ9c6WG667cdVEAkclVoYI/+HAWoK4gIr2ySz+fv01y88Af
 BxYymymULfsc+Fr8fz5T8IatGqC9Q/TJZNGCTElslV8vDETR2DBFFEg/TDcQbbrpCPgQ
 8iU3KCRnAxXDmgswo2rtkXp9sWU3wqTDuh19ucDbwCJDUiQxTS4ukfsnHuTldW0e5I4s
 gn5IEaRmusQzody1b+lo/kN3sU9SobipdX5YfuB/d3DY9WfX9tTVjYkDT2OOzHGsVRhz
 WtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749539949; x=1750144749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0W0VzrnSXRo5zrYh0VkKrKdZ9S3DeoYZDeEzqIl2lUk=;
 b=iBVexwBeSGqN1wdgLu9XmELzl2+6PUHmO8vVfJw783sk6SGmoet0V+8in90G00wKQo
 j7gjrdD9X4T6oOQ7FZ9hv9pyQQRtISsEuQB3s8ZKk8YwRhRTRw+oSDisvf47XJmWWaRE
 4eMGMTkWPY8QHj30bQxq/4ugLLH6C4yAvD2PlkXrURkTFjKm0BVGqsBbN+4eYEWJvdkr
 WYMbL7lSGN3idSA0ORYdCQFaDAKC5WVczw7WvvHbM0BduCtYOHVpgXmMM/7jl/lV5alg
 YuHawP+9iauAC5h76JppqGfrglTcnJFyxLNDFGncK9CIFdMBV9M3yO+FtycLqUbclHnt
 1yCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGGH/Js4+OuaPRytei3lQQXUd3n5ccDiMXPkkk4JPIFEmb0Ayf93WDpBIPsAZ8NNOUaxdBMvc=@lists.denx.de
X-Gm-Message-State: AOJu0YwT+Ntkd+hr6veKbn6DD9F0RCrOwgkhJrBVkHHnWMMB59L1F5fz
 rC5LQF2j/qz+tadzQkAB7jMcLdPqZwJY+92YNmrlsRikLN1l1w7cd4r+qseTydpH2bIDILQYRu4
 oJqaz40/NhiKbZqq9SeNmIcOi0NlHKCaglrKEP8q3Zg==
X-Gm-Gg: ASbGncsPhAtADRXkmm6SUpUHZuBdjRvLUyT668nzpgErqssh4pRvkRqdaJGPPCLHJ3u
 Rv5HarcmNfIBe7H5WjWTZ6wjDAshGH5mn2Dvn7JBilkgliSKIBsK3sq8ropRlKnntJ5s3x77hHk
 8a48YBZlJXqnm/8qMnskaI4eZWBIbfx1pdtwY8ZK7Cr+Q8
X-Google-Smtp-Source: AGHT+IFfrIxRPjELuDTZ+KJEdmXj8E0FK7JJLKKcSlZpth3Yr72Y2NaFLejVsNB3Eleh/8M/8Vl9okQvVy4KuLW8DHE=
X-Received: by 2002:a05:690c:4981:b0:70f:6ec6:62b2 with SMTP id
 00721157ae682-71136579904mr16808407b3.8.1749539948723; Tue, 10 Jun 2025
 00:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
 <20250608075428.32631-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250608075428.32631-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 10:18:32 +0300
X-Gm-Features: AX0GCFv8grWuB6JJH4JUmXdNqctzpKt00kEby-KCByqaM9EPJ8mNkfB2hsWNAIA
Message-ID: <CAC_iWjL1+0Lxq4PuZZ0+ozL9gMRO9OU7tujvrxQMSRR5dKgeDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sandbox: fix dram_init()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On Sun, 8 Jun 2025 at 10:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> dram_init() must not overwrite the value of gd->ram_buf set by
> setup_ram_buf() for main U-Boot or board_init_f() for SPL.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

I am not an expert in sandbox, but this looks ok
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> v2:
>         no change
> ---
>  board/sandbox/sandbox.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> index d97945e58fc..43f4edc39e9 100644
> --- a/board/sandbox/sandbox.c
> +++ b/board/sandbox/sandbox.c
> @@ -101,7 +101,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>
>  int dram_init(void)
>  {
> -       gd->ram_size = CFG_SYS_SDRAM_SIZE;
>         return 0;
>  }
>
> --
> 2.48.1
>
