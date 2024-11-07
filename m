Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F56D5AE7C
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27E8E89232;
	Thu,  7 Nov 2024 10:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dP4wQ2mD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3D28923B; Thu,  7 Nov 2024 10:46:34 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B3389231
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7f3e30a43f1so579232a12.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730972791; x=1731577591; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bQTz3Zb0u6qYyqSSW4WxRp1niD4x6dg+2mfaJwRDvpc=;
 b=dP4wQ2mDW1YNJDDvEyqW1sM5IeyrdgtNGlrFOK5v+O+7SsjChv54x/9FH9FQvK/y7+
 DlQHTNsjXMHR5mWB4yXdni+E5weF8hyX5ztvfI6UylP3CaMeqla1Hl5GltM3BoRlKALO
 MsFy9lGvq3tTglTcQIjC7DmdkpKkfVrPyiQZp8bJ6O49wxsim2KbNaQCukPLLHR7scEd
 ZuMNhrSSmtYQ7BrA81MgzBN+/8q8CDtXenKUSpjAmqXJe+Pf9RAP0bW9Kf49uddX20iQ
 /9b1BfLR6lzU0A/auOi5SBpBmNe/xH+452+bvsD5d4n4Gst2ts+qybUNh9uHPRmhTHH3
 aYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730972791; x=1731577591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bQTz3Zb0u6qYyqSSW4WxRp1niD4x6dg+2mfaJwRDvpc=;
 b=qo6bw/Jqy08EGuEu/nu44nxN38ohQBtDN1ZMwcZbpS54O2PEi4tlh1E5QLSAC9epnQ
 CLiD3kPqZoZs5S9ZCn+nGTu9ByT0iYzwcfhwtr9EA/XVMWv129vgtxHgJYBwKPafedwg
 MtbXOj0S0JsrJtdxdQz77re8P0iI1t8QQ5rNs4kHI7tL7KR8M8S5A5LHSrpQbfBmAk6V
 0Ac3pTOtvOnBIYrMLSCa2uA1jQSj8QNJvQOXlMtikKY635FwWv9dOBFuN5Wtep9e3r2k
 XCmPbGnDo5baJq3txhspUwyJOxyjsx2JGinQX5TUCXmBhHsKQc1zK9eMbsGiuxnFR0Pv
 JTXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvWWraEALgpXit/JL7veqItUln+XQaj/GBxycaU5yE+eyVVrhORk43a7tUYFxFT/K/1HDH4Hk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb4ye5lUswJjaIHMkbMv1O+FwzN7oyQar6r3vBd7n+32F6l/t8
 cJfAVSeVqlZ1Iz5K+yln6+1b9kPx/zjZBOoaQTRGlENK7GgiJ38A82u+vXnshqRiM1Dvr1BTZUi
 imIMrnmoxs5kufgltpLEXu1BoQGoSq45hQtPWWA==
X-Google-Smtp-Source: AGHT+IHm08dnzm+DSTigdbMwqh3GlIlDvliLYWT8qlnjQchnTLGsvb5lRUZfKy2uNkXNqPiZYEOK4FRuvkWKz24rUnY=
X-Received: by 2002:a05:6a20:7290:b0:1db:eb91:56d6 with SMTP id
 adf61e73a8af0-1dbeb91576cmr16159748637.40.1730972791092; Thu, 07 Nov 2024
 01:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:45:54 +0000
Message-ID: <CAC_iWjLdYM-TaLUa8pJiv-8FCjw3mr+cB_8L3NrepTKKcqcPsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] lib: provide function hextoull()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
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

On Sun, 3 Nov 2024 at 22:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We often convert hexadecimal strings to hextoull(). Provide a wrapper
> function to simple_strtoull() that does not require specifying the radix.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  include/vsprintf.h | 13 +++++++++++++
>  lib/strto.c        |  5 +++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/vsprintf.h b/include/vsprintf.h
> index fe951471426..9da6ce7cc4d 100644
> --- a/include/vsprintf.h
> +++ b/include/vsprintf.h
> @@ -44,6 +44,19 @@ ulong simple_strtoul(const char *cp, char **endp, unsigned int base);
>   */
>  unsigned long hextoul(const char *cp, char **endp);
>
> +/**
> + * hex_strtoull - convert a string in hex to an unsigned long long
> + *
> + * @cp: The string to be converted
> + * @endp: Updated to point to the first character not converted
> + * Return: value decoded from string (0 if invalid)
> + *
> + * Converts a hex string to an unsigned long long. If there are invalid
> + * characters at the end these are ignored. In the worst case, if all characters
> + * are invalid, 0 is returned
> + */
> +unsigned long long hextoull(const char *cp, char **endp);
> +
>  /**
>   * dec_strtoul - convert a string in decimal to an unsigned long
>   *
> diff --git a/lib/strto.c b/lib/strto.c
> index f83ac67c666..206d1e91847 100644
> --- a/lib/strto.c
> +++ b/lib/strto.c
> @@ -78,6 +78,11 @@ ulong hextoul(const char *cp, char **endp)
>         return simple_strtoul(cp, endp, 16);
>  }
>
> +unsigned long long hextoull(const char *cp, char **endp)
> +{
> +       return simple_strtoull(cp, endp, 16);
> +}
> +
>  ulong dectoul(const char *cp, char **endp)
>  {
>         return simple_strtoul(cp, endp, 10);
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
