Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72590C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA4B88AF7;
	Thu, 18 Jul 2024 10:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t7tRySiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8A2F88AF8; Thu, 18 Jul 2024 10:02:48 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F4288AE8
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3685a564bafso167485f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 01:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721289766; x=1721894566;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zXUgSNs2THpstekxLGrL4tV7Kul02xt6QkPiLbYGNvM=;
 b=t7tRySiRYwvEful+25JJVqqz9U7M93OcLhnKGfA7tUvlVXGR7+aPTL37tIzRSuR8Ow
 E8/naVGC8NpW6M2jkuNtL0w8meRSfqRO50ntzu1Est5wUb1tvUq0AXdPN573Ahhs2gHY
 UdR5KekiauXPwglCD9qyuDbgETuckYcEbiaCUYpq7C7bLBxQHax+1dHyI3HuUp3GBSi6
 WreZftvn44+OQjo2NXcowI238Nu9Jz4zUs1ZxcQnGulzixMqLjbJKbMrJ1qHD/aYv5Fu
 ekWcy9l61huMoEQTfVoeDesljK+dzRX9kHNYkUnSinGdBYZU8r9CKYYOH6F28Gv+6wA6
 q5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721289766; x=1721894566;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zXUgSNs2THpstekxLGrL4tV7Kul02xt6QkPiLbYGNvM=;
 b=izj1MT884t4pkMgxIOKJxDgOiSNc0SAxeDoU45uwz/b38WhqoS09E9rQgiaLnczEtK
 7ezbmhL9HjAbzFIbCbCD0P+z9nSVRmtFx965fK8yCjyHOuivySii4x0bgf5/quwbMH1I
 r9U04POWWBcAEgNU0jGJgUgv0IeiAnMCK6fg3J75F/yeVzEnAWRKqv+anY32BC5MWOVi
 BHRcOrMMV0AcI8XBXMbJMpsnGbNOr0TBsj3z4nITrVCro3iaAsoyjM5aU5KcjdHdGpu6
 DTpQ85NKiJK5xS0quVleQ3SAhNjvsPwGZ0252JGTwARIlQnQ8BSfjiAysVnKKuZJ+LNx
 HgIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu4drArVZhKcZpLSiX92n46b9b1QZKLPnA13uU5C9lfocEy9tq2QOgB1sIqhMzHYqyfZ0jM5tvTUQH5QDPW7RCUR/L7w==
X-Gm-Message-State: AOJu0YwKHW3HDwUqQaLMbhJjUW9vREcLcm3NnkVx7cuNnYndKUXxJFGe
 lRwJIWAVwM1NBu65thPcqvChJJ8BkTEHg4pg/qtVbno+It4RMkfVITBM20iCIAo=
X-Google-Smtp-Source: AGHT+IH+712boSteXv6YKajmIoqXJ4gvOnFl8axc5GyNLuGKYPTjl7+FJ4JQSz6CkMRUwcqdY7e8/w==
X-Received: by 2002:a05:6000:186:b0:368:3717:10c7 with SMTP id
 ffacd0b85a97d-36837171221mr2481537f8f.4.1721289765949; 
 Thu, 18 Jul 2024 01:02:45 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a635cdsm1284255e9.13.2024.07.18.01.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 01:02:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 02/21] sandbox: Fix a comment in os_find_u_boot()
In-Reply-To: <20240713070055.2172883-3-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-3-sjg@chromium.org>
Date: Thu, 18 Jul 2024 10:02:43 +0200
Message-ID: <87y15zktzw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On sam., juil. 13, 2024 at 08:00, Simon Glass <sjg@chromium.org> wrote:

> Fix a missing dot in a comment, since '..' is confusing.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  arch/sandbox/cpu/os.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
> index 6a8a5e7b89b..1491d00504d 100644
> --- a/arch/sandbox/cpu/os.c
> +++ b/arch/sandbox/cpu/os.c
> @@ -964,7 +964,7 @@ int os_find_u_boot(char *fname, int maxlen, bool use_img,
>  	p = strstr(fname, subdir);
>  	if (p) {
>  		if (*next_prefix)
> -			/* e.g. ".../tpl/u-boot-spl"  to "../spl/u-boot-spl" */
> +			/* e.g. ".../tpl/u-boot-spl"  to ".../spl/u-boot-spl" */
>  			memcpy(p + 1, next_prefix, strlen(next_prefix));
>  		else
>  			/* e.g. ".../spl/u-boot" to ".../u-boot" */
> -- 
> 2.34.1
