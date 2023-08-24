Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1FCC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF06B8657C;
	Thu, 24 Aug 2023 17:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oqmGRYkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6125586672; Thu, 24 Aug 2023 17:47:31 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526618609B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BFC7A3F42A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692892047;
 bh=HDvuFotTw8dsig/1tbO8GMU97Y7f+VUFb7fu8HgG3OU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=oqmGRYkr3Ana6oTTWGbyR6N+ZlH29KaYky6li7wEfkcWsCOHis87dXhDSQ8YZfvBj
 pMueJWJF3Zy7w/45k4XhLRuULQlYgFPklxIlkxlD2tAcZgPSqwl+5P+TqcBmarpaaC
 lWcbwGqiIwjBVtGxiKEr75hXK19rW3pfC1q2g4licCzJUpmkDepUGqhVEL0BGn0zX7
 +UYHvIXREFT9FBoKtUTBzcIgqw6HMwzumcEDvd1ipb7ocMzvBYsrpvkbwsxCPbHtvA
 n7vZVciSNXYZwrQgaD9hF4Zd1InfVxiqqRPdIeBLcsuXMWvKaRXeqDj+giim4zKGAf
 PS6LqHcwA1jsg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fefea09bd0so19020285e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892047; x=1693496847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HDvuFotTw8dsig/1tbO8GMU97Y7f+VUFb7fu8HgG3OU=;
 b=heOZO1PELCc2EvmOqB7qAvmPN3DG4VWLx+L5i18WDE0K2Plx6L9ZZE2AeR6x7AYFYq
 58aNUcvbkdWqIoYF1A5Qyvl4PkTL9Udum+aFwTyCuzizGfCWY3bIOsAMLFlCc+FZ9UVj
 n4yxZ1vwJPq0b8BpKwa9VelpQhJrVHw6Md/YvHe/5O2cHpD57YC5PpDJz6URWNfwG88J
 6NNxJEikKVQSWmsdmvwKSErjPQD3SY3IyTof9Yc/R3AGsGUd4m7nxsz0a0aceYo/Npum
 CltmZldq8ARGQdD2Hh9XrXbfZVrNaNDe/fhyq0K41VG98xhLykzM+3C0FZMkFJUY+40C
 4PSA==
X-Gm-Message-State: AOJu0YwnYoPULEA4h4ik8aeNuNfZfG3+qzwDlmjMPJO9txQ9ovYehpt1
 p4y3tsYje++g98NjZEnjvBevcEhlYDAs20q5DXqUQxna/bizM+2/W7U52ho66RJCeh7KfKHPUcj
 sSpQX0rkES8IW0X7RZ8IcJM951sOBvXs=
X-Received: by 2002:a05:600c:2157:b0:3fe:89be:cd3 with SMTP id
 v23-20020a05600c215700b003fe89be0cd3mr13393248wml.22.1692892047372; 
 Thu, 24 Aug 2023 08:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2NOoKN06RgxcpW8lmPJcK81VeKIDJTWrquFcEYusiHvHs4mJv0MIXe8O5I9hqxgpg2SfTzg==
X-Received: by 2002:a05:600c:2157:b0:3fe:89be:cd3 with SMTP id
 v23-20020a05600c215700b003fe89be0cd3mr13393226wml.22.1692892046960; 
 Thu, 24 Aug 2023 08:47:26 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b00400268671c6sm3102077wmq.13.2023.08.24.08.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:47:26 -0700 (PDT)
Message-ID: <dafff1b7-fdf8-0578-64dc-82e15ca3f350@canonical.com>
Date: Thu, 24 Aug 2023 17:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/2] doc: sphinx: Add sphinx-prompt
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>
References: <20230824154036.3650607-1-nm@ti.com>
 <20230824154036.3650607-2-nm@ti.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230824154036.3650607-2-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 24.08.23 17:40, Nishanth Menon wrote:
> Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
> better rendered documentation, yet be able to copy paste without
> picking up the prompt from rendered documentation.
> 
> [1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Looks good to me.

> ---
> Version picked is the best that works with Sphinx 3.4.3
> 
>   doc/conf.py                 | 2 +-
>   doc/sphinx/requirements.txt | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/conf.py b/doc/conf.py
> index 00f241366477..5e2ff1c8f5e2 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -39,7 +39,7 @@ needs_sphinx = '2.4.4'
>   extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                 'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
>                 'maintainers_include', 'sphinx.ext.autosectionlabel',
> -              'kernel_abi', 'kernel_feat']
> +              'kernel_abi', 'kernel_feat', 'sphinx-prompt']

We copied our conf.py from kernel.org. Please, check if it can be added 
upstream.

/linux$ scripts/get_maintainer.pl Documentation/conf.py
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)
bpf@vger.kernel.org (open list:BPF [MISC])

Does the extension exist on their minimum Sphinx version (1.7) or at 
least on the 2.24 in Documentation/requirements.txt?

Best regards

Heinrich

>   
>   #
>   # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
> diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> index 4f411f78d030..6ccbe527ee79 100644
> --- a/doc/sphinx/requirements.txt
> +++ b/doc/sphinx/requirements.txt
> @@ -15,6 +15,7 @@ requests==2.31.0
>   six==1.16.0
>   snowballstemmer==2.2.0
>   Sphinx==3.4.3
> +sphinx-prompt==1.5.0
>   sphinx-rtd-theme==1.0.0
>   sphinxcontrib-applehelp==1.0.2
>   sphinxcontrib-devhelp==1.0.2

