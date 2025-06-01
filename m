Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772F6C54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 21:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA84882991;
	Sun,  1 Jun 2025 23:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Pv6DQSoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B07829E7; Sun,  1 Jun 2025 23:11:54 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70208296B
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 23:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 095833F2B7
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 21:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1748812312;
 bh=FtUY4QIUMrQtv6TlmRV93AQsyVycW2NRlOPV8f+KKj4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Pv6DQSoHAi8U95r8YdSadiqZza3dtw+TkBvJtDhn/7puLY8qpBKxM4NninVewwMZb
 SsTEYcNrjEQPW3uER7Gdkns/82K80NFXNhLtPKgxjfHdTHBa9ht/XpNkUEKfF0+IhX
 3wpJqyB9SMK5eJP3t0fbu++fGt7yBukgrJnJHV91cdCQA8y5FmdE7gvQ3+JYXntam+
 /BGdlssDtjfZnuj0BYZK+HX9PIn6NLUKZe3a5Gpv8xu6/CAy6O64mrGmtSdWaFh+2y
 uQlmnT1+AxxN2d3XcDSpmESxmlrYUWlKvBAmPy5I4GB7h6bEXAa5MoFMB6pHuR9dba
 bjphTzWRU1UZA==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so18720975e9.2
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 14:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748812311; x=1749417111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FtUY4QIUMrQtv6TlmRV93AQsyVycW2NRlOPV8f+KKj4=;
 b=QtSmsls8dXFnspH7os0U0Ye4faGtkSuoxo/cPbJUViA+YGErRJPWXN6FOn6ylEvaSY
 mYotg+RWSuiWS2sfMr1Vd4HXT1KelhytFaE5p6MWDcQrTwBQKVGMSK7Dqie0uwVWz7SW
 sAO29I0XvspFDgKjdmzdKmsVpiC/7OT9ojYeTVfe7L/6NoqVcFouSaMqu7qzJA3RatYi
 rON5kuJ0IrGlqPjG0VVNearW+dck+Z0TPUJEa80rMxUSJ/LMQvVzmj5GFTPxWEdBYdli
 crqn3ZPvF9T2D1s1ATJmCHksULbhXKj5IeW6Jnv3J1JRF2t1YI4kGYyXGjbR22T0ieYb
 b39Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKEMu5l2D7i5pect8sbVv57K60MszWHgaGl6o89Oy5+MRhVg0sMfuw5Sy2NpaVCTjk41tm5kA=@lists.denx.de
X-Gm-Message-State: AOJu0YyytzgjiwdiqwY1dYXWgBsVbsinyMlmvCdsKcAOGfm4BiqIqjSQ
 y0aJazUoSch1T9KjYdOwT7kUwAKThUiYaXlh5JuC6e4JjmUTTTvckRVyaW4iTv8S4dNK+CJ8GyM
 pu53c3ESgBRhz9ZUFMYuZErBe2Ycp/Y7YtsGU+NkC2S9SAOSn5nxY/xE7rkqEJsDkrtBdbaE=
X-Gm-Gg: ASbGncuDIk6x59PPr9VUHi2KD0TMG+fnl8rlzvLuwqwMpEz5Vjee+SRqtWWd6okVPou
 2XWyiKiSnfodjmJ4Hf2Ek+8l8ws/A1rOHqaast1FAyHIufTboGqU399ObjQSroUaMKDrR2ksHqg
 qotbBNCJzca0mX8N5LmB9usbRKQe9ZLd76mujBTCGoYzGYp4JpPaglFjDJ7Rlqm1i+ZM0fCWbjD
 /vtWiCParBwhXCly0+3FR2biwaUUFc/xf6giS0aUxvJY7yujUvy2IZm+dFMVJSzH93mLKcXDSaf
 7cLyQbia41H1ZVnhFJSslLpJarjFzVU3w5nVo1R0V9g7qw/h2U88za3enX3sIBqimRFSaiJH9dx
 rKKJn3wkY
X-Received: by 2002:a05:6000:288c:b0:3a4:dd02:f724 with SMTP id
 ffacd0b85a97d-3a4f7a9d48amr8908249f8f.43.1748812311422; 
 Sun, 01 Jun 2025 14:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj1J5ZYWq0Rwy1Vz5P+g9HC2sTGsfKSsWtDGFzH6VS/eWLQFhgp3FKqQSQBnwbnAxTqd6ACg==
X-Received: by 2002:a05:6000:288c:b0:3a4:dd02:f724 with SMTP id
 ffacd0b85a97d-3a4f7a9d48amr8908237f8f.43.1748812311087; 
 Sun, 01 Jun 2025 14:11:51 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f194sm98081555e9.4.2025.06.01.14.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 14:11:50 -0700 (PDT)
Message-ID: <9ca14319-fce0-4b4e-9bf8-bb247c00380c@canonical.com>
Date: Sun, 1 Jun 2025 23:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] net: lwip: enable IP_FRAG and IP_REASSEMBLY
To: Tim Harvey <tharvey@gateworks.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <20250530153826.1057407-2-tharvey@gateworks.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250530153826.1057407-2-tharvey@gateworks.com>
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

On 5/30/25 17:38, Tim Harvey wrote:
> Enable IP_FRAG and IP_REASSEMBLY to allow packets larger than MTU.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

In future, please, address your patches to the email address 
xypron.glpk@gmx.de as indicated by get_maintainers.pl.

Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
> v2:
>   - added tags
> ---
>   lib/lwip/u-boot/lwipopts.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
> index edac74ff7a21..1818a445dc5e 100644
> --- a/lib/lwip/u-boot/lwipopts.h
> +++ b/lib/lwip/u-boot/lwipopts.h
> @@ -72,8 +72,8 @@
>   
>   #define IP_FORWARD                      0
>   #define IP_OPTIONS_ALLOWED              1
> -#define IP_REASSEMBLY                   0
> -#define IP_FRAG                         0
> +#define IP_REASSEMBLY                   1
> +#define IP_FRAG                         1
>   #define IP_REASS_MAXAGE                 3
>   #define IP_REASS_MAX_PBUFS              4
>   #define IP_FRAG_USES_STATIC_BUF         0

