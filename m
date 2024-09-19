Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1179BCE8D52
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 07:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B610890DA;
	Thu, 19 Sep 2024 09:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bzeY6Ikr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8AB4890C9; Thu, 19 Sep 2024 09:05:50 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD478890E0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-719858156f4so384973b3a.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726729547; x=1727334347; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JhZiKwZGAheMnMutBgisLOnW671qa6vZu7bkh2hEZ/I=;
 b=bzeY6Ikrl2aHmduvjt5KLYCA2rK2j4LEYcFqKXkDxl+Zq1CjolYSfzn5y6saP2uJPh
 DduUZolYmOofAutWoL2RYqudtPD1lbQG13pwTyYnoZmcLsT+5Z7PR5vZeFszp9cNihFE
 ZMnxJr66RQhRayYpKomOI9XJMrKeSFZcZozx1xWx8gPJMSbDK6wii4u9X3MLxuzmrHzx
 JrfZdxrYMtu5qaZU3Z/Xzt5mydFM9hoV4JFkpwhBdre0PF57xFSNCdQAVm0Cp9898E0z
 NQ4IoWWDloFi5yT1rgs6AXpAbUDx2jVAUy84Zw0+X4bTW2d5kAOj8II9pNTW0zz9/e7t
 eF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726729547; x=1727334347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JhZiKwZGAheMnMutBgisLOnW671qa6vZu7bkh2hEZ/I=;
 b=maIv9QDp8G7dcExjifQlBgxhvVbyGdWqdkjHzRt8fN1RhxHbDie1I/3FRn41SLLLxl
 Uv02bMlzIgF/RsAHQTY6JiBSXfU9l4U39VK860RoXXdWwiLkn5bpdRrt+XkIrdMLIbiv
 YivaslCY5p8to3PfLYRebyvtiwpaaF/AyWjJ0MZm7b4RBhw90eneE4HHAoi9k70Eai9Z
 PcSGvfIbXxI+4xk2wd+7xPnlu8x6PP4HrQWWCm072QQUjUCp3ENragKD577/XDo9NOjx
 knt75189G+CCQv9KkYBnnm2V4wYR4eoAlRUAg7EC2SjMHTSJ7OOKGUJLVpK7jrFeDgKX
 mkMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMgRAGTHNq9qd6HZlPqFIlKzbWC3IjB0ZPjJZbTJq92eYMkj5t6QSsJC8AuQuR8huqbqNc3G4=@lists.denx.de
X-Gm-Message-State: AOJu0YxWMq0aqUlyHmAohTE/5urpfCtpfXQDbn0FnylOV2MijZbFlRNF
 sfEYDbAR2jsiEHyZuuoKevfSYsCTQ1rMuhlDN2KVGLESHSMeeIiMF83OJysa4hVzh3Khd/Qxqnh
 m0VqhgCzRpb9l/q1Wx+7vg4IEiryk/i2yujkVoA==
X-Google-Smtp-Source: AGHT+IG6sH5x4I29ItkYNdm/Mya/xjAtn3d8QAoe6eiKSEk7hDpzAo/mi1Jt6cnnS+GNqeJHjkOvFxdxCsrMFf68bWU=
X-Received: by 2002:aa7:8883:0:b0:714:340c:b9ee with SMTP id
 d2e1a72fcca58-7192605a08emr36257194b3a.1.1726729546966; Thu, 19 Sep 2024
 00:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240918213934.19875-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918213934.19875-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 10:05:11 +0300
Message-ID: <CAC_iWj+2C8LUuorb6L7cEhBLGNUQLJzMaKgDmw8P2pDsLCWJaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] lmb: add missing LMB_NOOVERWRITE description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Thu, 19 Sept 2024 at 00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Without a LMB_NOOVERWRITE building the HTML documentation leads to a
> warning which should be treated as an error.
>
> Fixes: 5e9553cc72b8 ("lmb: allow for resizing lmb regions")
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/lmb.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index fc2daaa7bfc..8ed5ac0a4fc 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -18,6 +18,7 @@
>   * enum lmb_flags - definition of memory region attributes
>   * @LMB_NONE: no special request
>   * @LMB_NOMAP: don't add to mmu configuration
> + * @LMB_NOOVERWRITE: region cannot be resized

I think the description is 'can't be overwritten. Sughosh?

Also, I'd drop the Fixes tag for non code issues.

Thanks
/Ilias
>   */
>  enum lmb_flags {
>         LMB_NONE                = 0,
> --
> 2.45.2
>
