Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7A6D2E9E4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D044288FAF;
	Mon, 11 Nov 2024 13:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gs5kT5y9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EDE89384; Mon, 11 Nov 2024 13:50:49 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08A388C4C
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so3570590a91.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 04:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731329445; x=1731934245; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Raa9LNkI8fI78govywrooahw3L/UAtHCKuqOGmkrGa4=;
 b=Gs5kT5y9xAHMBPYQVBKGFa594gwt7MMZ6vfmkYVXk3WIqRjnRNMvfyycJmx4Lna994
 4JFWBTcYF8yA5rGheJCEP5CElkmRWXEmKVUcb3qEmMnNraPNoutjgnaelCVQHbsDNHm7
 1MZUF6DrycnmZqdcXtuacyUJI4SUqxcCCW4P53Fg6AhJqCBJq6kNZVJz+a4UMhG9z13z
 kjFfz5sPa7l7cricBprru878cMBpKzFv/kOBGvN/AdbtcjppFQljT86btPtuBprACxjR
 60C4Z7nFMgO7IbpQgSuFqqPi6Drh2vldOcqJAav8HmPtbar8+x6aXYuhdBgfwQgGJ239
 7muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731329445; x=1731934245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Raa9LNkI8fI78govywrooahw3L/UAtHCKuqOGmkrGa4=;
 b=WehkqJ4DBxbhZUOvFGbtbDKVLbrTDoqp881bIp9n0iGfLcONQ7fTegha3bCw7zU/zy
 VseMQIec72XudnmWS4BZ9KfcH2NGhynDu6MZb+B2ZgsYICd2C8qVP7sfGSB6v7rYZR9v
 9YwanL/FFjyvX5XomNGv0/xAChWWsozvRmM0B/7+rmCAQ3nZ/aYTv2beGaU8OkjhfEwT
 ewCVPzDdm2tCArlxEXCKo7CKuGeWtDuI5oaMNFxZ+OX//PKuL+XjMqJwcDRZc816j8XN
 EiHBA9Nf26Y8rH0c045E4Q4lZhpgrH5sXRbjFa+8ULziVdyA4CJRUIpErpfx/KwiE2Tb
 IJZw==
X-Gm-Message-State: AOJu0YyyJOFHQz00yXO8Idl18SWHqAG9eIEizQ+G8ktWHgjAN/erfg5o
 fLnZfUnWTnk4ffI0HrMpVJF2w5P2d0QbRcDCLQqfWxc0LKcqSDXIaRCo9oZ/mRQlh5HDyCE1ZEp
 3ZVr97LWAfLEzRkGY6dMihmmzvMRPClNGhFr55miPD8b3NMSM1AU=
X-Google-Smtp-Source: AGHT+IEfkORh5PXYfJNDeA57wrGtZxMI/VuK6FgohfgIAduSk0VFkYamg7V7wVksC8VhMEe5O/qs6aBVfeV23b5Q3nU=
X-Received: by 2002:a17:90b:1810:b0:2e2:cd5e:7eef with SMTP id
 98e67ed59e1d1-2e9b1773411mr17401396a91.27.1731329445412; Mon, 11 Nov 2024
 04:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20241105102524.10387-1-jerome.forissier@linaro.org>
In-Reply-To: <20241105102524.10387-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 14:50:09 +0200
Message-ID: <CAC_iWj+t8Qm6rzqT53SxjdSZJcYyBrFHwGv1VH1LLwGTga3SHQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: describe NET, NO_NET, LWIP_DEBUG and LWIP_ASSERT
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Marek Vasut <marex@denx.de>, John Keeping <jkeeping@inmusicbrands.com>, 
 Hiago De Franco <hiago.franco@toradex.com>
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

On Tue, 5 Nov 2024 at 12:25, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Some Kconfig symbols introduced in commit 8cb330355bd5 ("net: introduce
> alternative implementation as net/lwip/") need a full description. The
> NET symbol needs one, too.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  Kconfig          | 5 +++++
>  net/lwip/Kconfig | 7 +++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/Kconfig b/Kconfig
> index eb55f2511d9..6305e5eaad1 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -765,10 +765,15 @@ choice
>
>  config NO_NET
>         bool "No networking support"
> +       help
> +         Do not include networking support
>
>  config NET
>         bool "Legacy U-Boot networking stack"
>         imply NETDEVICES
> +       help
> +         Include networking support with U-Boot's own implementation of the
> +         TCP/IP protocol stack.

s/ own/internal/

>
>  config NET_LWIP
>         bool "Use lwIP for networking stack"
> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> index 8a67de4cf33..5ecff9ae07f 100644
> --- a/net/lwip/Kconfig
> +++ b/net/lwip/Kconfig
> @@ -6,9 +6,16 @@ if NET_LWIP
>
>  config LWIP_DEBUG
>         bool "Enable debug traces in the lwIP library"
> +       help
> +         Prints messages to the console regarding network packets that go in
> +          and out of the lwIP library.

library

>
>  config LWIP_ASSERT
>         bool "Enable assertions in the lwIP library"
> +       help
> +         Compiles additional error checking code into the lwIP library. These
> +         checks are related to conditions that should not happen in typical
> +         use, but may be helpful to debug new features.
>
>  config PROT_DHCP_LWIP
>         bool
> --
> 2.40.1
>

Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
