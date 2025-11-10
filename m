Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFFDCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 11:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96643839A5;
	Mon, 10 Nov 2025 12:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nzSR0ch2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310A883A1A; Mon, 10 Nov 2025 12:54:11 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E88983980
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-640f2c9ccbdso190382d50.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762775648; x=1763380448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mf0tr5H1AZccA0s3e63OAz+iu9T1FeRqzE9wOyflAMk=;
 b=nzSR0ch2Lsqp7Wx4Zdf4vNy1hZ+eilRt1NVcVEVRmPO6dYkO3S13J2JB/2a5pWSf7l
 2E4x5CsfmyTDc9E1iMFfKrnBwTvgsbu31F5cSqlQd0gvSWkFq9DDA6C47239OV9PcjrJ
 q4SWvU3Y4ZA9sczjG6YW69Rh5Q1D5BagOYRZHThMNhoH2kj2vqWkrkFXzFISK6mxIMMd
 rJ5uyiH3Hyde4N4Mi+fe1v9QTc8qGk+yxUkWwiyxI7+uAOEsH58D3svyqg5XCbXtmXXM
 l7Qh9+AquHjz8k3IuD9CUKRqKBiFYgw0g4lm3DHYHBGaqX7SeLIJA9chzYSfi0zA32Ni
 lwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762775648; x=1763380448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf0tr5H1AZccA0s3e63OAz+iu9T1FeRqzE9wOyflAMk=;
 b=dkfJtXhMkxOkyFmYgmoD9dFxQn7QHH/DfEa9BVoRGFFGvs8zYMnUPl9GvwM8jDaXXG
 BAUHcOEn0c87DxwsMp+hGV0+hK2h9jNGhjA5dy8oZszIHZRp1o50Rolkr/U9moUTZS1G
 EpG73DVB8o+tmgNFSTgg9hBoVTpmGvwAasGKccmkWYOH4u4GRz7Nx2dq9Or5AAO3OxsR
 jjUTVwOJqlN8Rv+QwgRa6Wcfl92bT7kTGLxB7LgEviTDl+cW7gR1syZ0PH0M02DNIGRi
 MDFfsKipeJh5w5tc6KWwIu62tGDzMhorkfIGfT9+aTW+X1pZDS7yLb+SGIzHS2T0MuLg
 myvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ82p6XLz9YqANqGY3ncX7KcxMPy3nRsDTSiMewjgLSoWWEBcvc/gRjpI8CxbcMujzAQCJBj8=@lists.denx.de
X-Gm-Message-State: AOJu0YyTt7HQRnEvOGzMVZ1LhchyLWHsfiDJ1dZvMvA9tL6Gk+RTGoU2
 asfxCdc0L43bD3T6IHF4FGVoX+u9lomN4wwrfLQMLnGr5Ta969x7+h4+b5kA8ja3yxWtEO5+s6d
 JgCMBzFg8ToNQzeuXitPfLdooa8pR3w+7Z/umcmieiIwxLlOSQvun2sA=
X-Gm-Gg: ASbGncsUEq+43z9gkFs7UhRgTZbkGYYV1yFzJDROwfhLi8hRE7HZ4WNPGKENO8wbA2o
 NCaiI5kgsdNSs3PBvI/nL4WK347cq74l0xpWTR6M7vdwe5Klz233wlWZVGUSfXAZKcU8TMxSkv2
 7CjXwJm1MF6XdWBM4mxTgbuZHGUpW2bWLLAxkNKmyG6iBjdnJ0NJ+aXlyRIwaSZl6pJR+MQKIda
 JuYS8O5EKiG8ESQSjB3bYBmX6a4cEezYvvwra687DBOgJI5ZlaAJMxUrov94S/5gQruXCvPGNBk
 hanHPw6z7QJgzou8v2ZnQEvLKtgDahWtV4Dch8OwCFJTX9L+9LA=
X-Google-Smtp-Source: AGHT+IFT4aZ15wyhngPbOL2aScORrLFHgUBaoMies80CUtIAMF0vYYltbzD1KR33w/d6OkvQMDy1qDh3ISACIIrNRcg=
X-Received: by 2002:a05:690e:d41:b0:63f:b2ca:80e1 with SMTP id
 956f58d0204a3-640d443863emr6313427d50.0.1762775647971; Mon, 10 Nov 2025
 03:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20251104110240.62368-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104110240.62368-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Nov 2025 13:53:32 +0200
X-Gm-Features: AWmQ_bnGjTud6yu4CZ-awCjnCfmClJoH0ZxRdy96DFgvpd6EpJQLMr-5uGuffPU
Message-ID: <CAC_iWjKKX9H+ZEPWMMcL3m54yHRE4tV_ph9DQ7V_SNy+ZqP2Tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct struct efi_priv description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
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

On Tue, 4 Nov 2025 at 13:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add a missing colon ':' to match Sphinx style.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  include/efi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/efi.h b/include/efi.h
> index 66725b876f9..b98871fedad 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -454,7 +454,7 @@ static inline struct efi_mem_desc *efi_get_next_mem_desc(
>   * @memmap_key: Key returned from get_memory_map()
>   * @memmap_desc: List of memory-map records
>   * @memmap_alloc: Amount of memory allocated for memory map list
> - * @memmap_size Size of memory-map list in bytes
> + * @memmap_size: Size of memory-map list in bytes
>   * @memmap_desc_size: Size of an individual memory-map record, in bytes
>   * @memmap_version: Memory-map version
>   *
> --
> 2.51.0
>
