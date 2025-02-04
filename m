Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9CEC0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 08:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A58C80137;
	Tue,  4 Feb 2025 09:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S4aue3YJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A1F2801BE; Tue,  4 Feb 2025 09:46:55 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511D8800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 09:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so4789813276.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 00:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738658812; x=1739263612; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MAi4J07pFUHZTDRJV1S19oc2lgHoJPZzdruzJQgrFqY=;
 b=S4aue3YJodx2K3MJhrteiMCmwZ70Pe6TrdqNHRWnT8WNOWF0viwyF4+B4RO8OLnrDK
 f+wTKlMO9AYrobhd6fs+a8jlIH6HzXczoYw4oGDexTN/k0xeKIx37tkIw24yjaXzxMvx
 lg0x5sqdWQwajrmcpRFO8dBJdrRRxuZcRs2UsL7vhs+WTdLe7QQuBTdQsgbUX6gBoCj4
 GacAz4oBPQ6h/La68ybFM/+FcE3Mq3ltieT+ZSvMXl4HVPPmq1ijLcfI8F2xTwr2lndi
 vC/ADqtA7VNjU8FPPgiHmTrzemFVzL1B4aL+8ePri9bLPHBCdtnfMKU36ed72E4d9zMy
 24QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738658812; x=1739263612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MAi4J07pFUHZTDRJV1S19oc2lgHoJPZzdruzJQgrFqY=;
 b=H1mSrQIYDgx8k3EhDRgt3b1CoDsCpVTtwDZalZhNhRhgirobZM5GEKppVvGfUoAPA9
 JljA0I4R7RSro5AoqDKvIvmnptJy5CFy1EC8EuNNNFJQnP4VcZN8im8vLCqMFrwPw8pG
 nwSHosOvYXGkTli5ibP9aYTRNtXQaTa4D5vhaylE+J1n9r9F4wpgdSsDlQy7WVRMdqqY
 QLiK2qpRentEKUru8NSVFDA6mMe/BQN83tu2MZahthgH6WfyCyE8Aq0ztLXsTU4N+wnR
 +/EzH7l2qtzDFoyaW9b1VLeO+T80mX9Xf+B4WTsUpapvh25/898iGwYvhX+sTLxigLlt
 LQXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvybyRs7NMsnMB6E8PmoTFzXzHLLTEbmTqQ/TbYd3rapsK0nYx8chYpfVSPQKtTHf4Qn9KDV4=@lists.denx.de
X-Gm-Message-State: AOJu0YzFBDdOZ/+QR8ibAGV/dEAeyaT4d3eC43ZcrRhZ1H+Bky6zNgOM
 q4g30fOYobNAwXrzvK7uCf9Zvxn7/1mR57Sal6I7P8zoieUWb1c4Zx/8YV7ua9doQOMmx05vC0J
 myHUpmxMTOpeZJPXikJwQ1srzOxzLq5EKUIgXcg==
X-Gm-Gg: ASbGncvvsNxDp/X+ph/MtWuvydJxcshvJ59vZ99XwhE7uJ0UDCubqlO2Au8YQanhoYT
 diN8qA9RnvgfkHtPKcpnYtDULxMClS6NLhrkD9/0ivmgIikFYtTuiyDYLU1MGOAW6j4PhMKN9
X-Google-Smtp-Source: AGHT+IGynP9QFKSXdJ4nw7ZYmCvHV1UeNhfrGSkop5KaQ+5xbRU7m3iOBlYautpYtHsjva7iT1wWTVt6OUdbzIRY8h4=
X-Received: by 2002:a05:6902:2490:b0:e58:118d:67e6 with SMTP id
 3f1490d57ef6-e58a4cfd0c8mr17795923276.48.1738658812233; Tue, 04 Feb 2025
 00:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
 <20250203091203.47590-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250203091203.47590-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 10:46:16 +0200
X-Gm-Features: AWEUYZl9oPepMkmtAgfQna1hN7waDcZVBBX9aNn5VZxUans_CnGtn8U-5N22kDs
Message-ID: <CAC_iWjKxLKQbqYqPfJap-iqYsv4yUpRAdBq0c4od_h7N_HAgQA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] net: use strnstr() for lwip_strnstr()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>,
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

On Mon, 3 Feb 2025 at 11:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Using strstr() instead of strnstr() creates a security concern.
>
> Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> v3:
>         no change
> v2:
>         no change
> ---
>  lib/lwip/u-boot/arch/cc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
> index de138846358..6104c296f6f 100644
> --- a/lib/lwip/u-boot/arch/cc.h
> +++ b/lib/lwip/u-boot/arch/cc.h
> @@ -34,7 +34,7 @@
>                x, __LINE__, __FILE__); } while (0)
>
>  #define atoi(str) (int)dectoul(str, NULL)
> -#define lwip_strnstr(a, b, c)  strstr(a, b)
> +#define lwip_strnstr(a, b, c)  strnstr(a, b, c)
>
>  #define LWIP_ERR_T int
>  #define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
