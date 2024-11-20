Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0B6D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 446F78968D;
	Wed, 20 Nov 2024 14:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ei7hOASP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B67F8967D; Wed, 20 Nov 2024 14:48:28 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D98895F2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so61936911fa.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110505; x=1732715305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSFjDTd7cqN+RZ1c3cazt8nJnMqqJvOM3/qXXsl5Lm8=;
 b=Ei7hOASPedI79YQ2SCu3PFHyTnm4NwEG6RdM25ofHn0FdhNcB7vsvNTcSkdl0zSFMo
 HNxoNfxhe0973hBZECik0D1+Hy5Ubr4hBdh6MnfEKZgn9JK+8isfFMg9IqzHM+YMKXA8
 7eKPT9SmHDJ/XsUBlV6nxBZjaMPQzOqNQyl24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110505; x=1732715305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSFjDTd7cqN+RZ1c3cazt8nJnMqqJvOM3/qXXsl5Lm8=;
 b=AQhHXOxWNLn98qH1h/sO4UDvXqTTWt/ZfwYTr9LJmiT28/fCT7a/TNiHWWs7uSQJqQ
 UBM28Z78NRcGcXP8M/9e/hDpITEfdlqhb9ZwqDVjp9aCExHixbD97dsFw1YbwykwBPr2
 B1ZwPZgQSYGaGzNN5XdYOKvY8L+t3N/hJooJILG3Y9aWpC/TqB+JMr/G4wQ3Q0DYE30P
 Ov3npT6pfCsQ2amUd4Mt06Ry/+2Y7cl36rK9KRMQUBeqiKktuOJAsIxUKz1jA9zrOkXL
 KcN4H6/FlYrH4Vwuvn1OQCbVZT9Zhjz6QwwjxbiLeRAr0AjJQjAs9VASlXW1Gj/XgWNn
 Oddw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjQ6OM4v6bUSvILXRzd0ycMqMEsUu1xOfgqMSTClo+jOy8wdssMA0VCRyE9CrTbfMPNA1jvxI=@lists.denx.de
X-Gm-Message-State: AOJu0YyURyeDN+V2FctbrmlnZOaOMKW1JFEkz9luFzD/1N6EFXQ368o7
 F91zBCWmx/iyeQVAZjGBdqsdSeuJepEgGAolFboEewugbXnF0hxn2xWvqKhHXdaekIWATbXfu6A
 s09VvwR3R+e4rg6qrbvNePR648T8Xw7nALgkf
X-Google-Smtp-Source: AGHT+IF5zlvVn/9SX3EiUtjMhq2jVJl8qIvAHTtIkrpkv/I6bwVpaSotQpFW/wcDtFNDZdajtpyY4WeUQHQ10exfHS8=
X-Received: by 2002:a2e:b88b:0:b0:2ff:5c17:d57d with SMTP id
 38308e7fff4ca-2ff8db15e63mr30706441fa.2.1732110505303; Wed, 20 Nov 2024
 05:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241110115054.2555-4-ansuelsmth@gmail.com>
In-Reply-To: <20241110115054.2555-4-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:48:11 -0700
Message-ID: <CAFLszTiu30PqPWR+Auw+BcDSk23JTG1WDTf_hyDNLYXwfu_4JQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dm: core: implement ofnode/tree_parse_phandle()
 helper
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
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

On Sun, 10 Nov 2024 at 04:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement ofnode/tree_parse_phandle() helper as an equivalent of
> of_parse_phandle to handle simple single value phandle.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/core/ofnode.c | 58 +++++++++++++++++++++++++++++++++++++++++++
>  include/dm/ofnode.h   | 26 +++++++++++++++++++
>  2 files changed, 84 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
