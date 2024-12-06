Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928B2E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D49D89622;
	Fri,  6 Dec 2024 15:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DUnA2Ejd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1683F8962E; Fri,  6 Dec 2024 15:40:26 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B497789622
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6efa08f91c8so20724787b3.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 06:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733496022; x=1734100822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pL56+cwf8dvb5NZfKZH1mwALzdqPuosxYcW+q+o8V+w=;
 b=DUnA2EjdFnTkABLtwr/tceiUz4p3l1/lASWwUNOy18EYzonRMT2cRytdf1DSxLkTGn
 YTZy01WN7KgEhm5SMzlO1mkhBXWaY4QWXGvXU8PK0GaY/OklGXVjD238gqbnCYYMDCMV
 RZiUGJn6oFckvw1NMRwfSi1rmy8nS4JP4xIrt0F9SehfWaDH6jOPMnXUValLHxDJC0ee
 m+YSgtvXvOGLHyvMiIXNMAAn3qb9CNOihcMzUk7HTfd8AWLSLOHzeyW9kthP0NGDs4Bm
 AZ+R/Fcq8k24RsJlBRiLvQu7x+a6CGdbaOVWcnYK480DvQihUy82E2Zp8ifZgPXDdWuX
 f6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496022; x=1734100822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pL56+cwf8dvb5NZfKZH1mwALzdqPuosxYcW+q+o8V+w=;
 b=d78tiajEfw9fO1t0wo/lY8LLNsyh1IO75On62cyNC7CEIH5AWyIkfUJ/EKUIsMUgPx
 B1KDnxMBH0vCxA9OVzLuEhEMg+FybeQ2arcCcttSjM7ESbRpKOlJO18lTdEfb0bVhfci
 XElGFqSJ0nxJa3UdVniuSYDyISAL153kRjhlQXoeTsq1PElVLtIfDV90TEA1Azx9zwnT
 BaMY7KZ/5bsokjHKjTdxVNDXPSMyOWrsJyiXm5fWpAmuBJGfKO5Z7rJHHemG+jDw0upH
 kMFKmZQ9j+h+FX9IJ0oQ6TJWa92qpIONt5n2zQmUjwi8Ar0Hp/Qkr+Uid6qn1YPj1N9u
 2GHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfB0BsJJm3EAkcRunUyE4R4zYt8p/yUloxAngaoHDFgQvDln7Xlu88nzAI6lD7b5xRTIyQ6nA=@lists.denx.de
X-Gm-Message-State: AOJu0YyjsMciNnIxQTn6IkJYKyLVAjEAqXglS8Vt11yejN0CX3WEl8Z0
 s25j78LSzQ5OwG0c0ovYtdsagns2Drj0X2Z6cJm2O1PAKHXflsCzjAWto0uIuo7WuEJpY2ic6kh
 oYDjMklLSQI1Tmc+zAe2tIsLApNzMkufYKlfjVw==
X-Gm-Gg: ASbGnctGlpdV6sog0pnBRDNVL/TKBlsAJps788B8zItCUeHu/ZSZRiTKVfo+xdl00gJ
 oyzMsqX2EJ3dXZYMEb+07R+W+d7PuDeU=
X-Google-Smtp-Source: AGHT+IEQXBH0qxl/LqKSAjvvVGCjXbWHOnnJ7LoVCtsH5lbV0x1qwh4KNPcAwD09Zhysa4c+Oq/S5qs3MbzYkqtmwEE=
X-Received: by 2002:a05:690c:6e12:b0:6ef:5fee:1ca6 with SMTP id
 00721157ae682-6efe3c0c343mr39515807b3.18.1733496022571; Fri, 06 Dec 2024
 06:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
 <43c4500c-be1b-4def-bdec-cf1c5ee48e33@linaro.org>
In-Reply-To: <43c4500c-be1b-4def-bdec-cf1c5ee48e33@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Dec 2024 16:39:46 +0200
Message-ID: <CAC_iWjK2MM_aV6ChHSzOHcsF+PCxaTwaLHRFN-KtG2KKGjhp7g@mail.gmail.com>
Subject: Re: [PATCH] mbedtls: remove MBEDTLS_HAVE_TIME
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: xypron.glpk@gmx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
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

Hi Jerome,

On Fri, 6 Dec 2024 at 16:33, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 12/6/24 11:56, Ilias Apalodimas wrote:
> > When MbedTLS TLS features were added MBEDTLS_HAVE_TIME was defined as part
> > of enabling https:// support. However that pointed to the wrong function
> > which could crash if it received a NULL pointer.
> >
> > Looking closer that function is not really needed, as it only seems to
> > increase the RNG entropy by using 4b of the current time and date.
> > The reason that was enabled is that lwIP was unconditionally requiring it,
> > although it's configurable and can be turned off.
> >
> > Since lwIP doesn't use that field anywhere else, make it conditional and
> > disable it from our config.
> >
> > Fixes: commit a564f5094f62 ("mbedtls: Enable TLS 1.2 support")
> > Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 2 ++
> >  lib/mbedtls/mbedtls_def_config.h                     | 3 ---
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > index 6643b05ee94d..46421588fef8 100644
> > --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > @@ -692,7 +692,9 @@ altcp_tls_set_session(struct altcp_pcb *conn, struct altcp_tls_session *session)
> >    if (session && conn && conn->state) {
> >      altcp_mbedtls_state_t *state = (altcp_mbedtls_state_t *)conn->state;
> >      int ret = -1;
> > +#ifdef MBEDTLS_HAVE_TIME
> >      if (session->data.MBEDTLS_PRIVATE(start))
> > +#endif
>
> Should this part be sent upstream? Maybe as a followup patch in [1]?

Yes it should. I'll open a PR shortly


>
> [1] https://github.com/lwip-tcpip/lwip/pull/47
>
> >        ret = mbedtls_ssl_set_session(&state->ssl_context, &session->data);
> >      return ret < 0 ? ERR_VAL : ERR_OK;
> >    }
> > diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> > index d27f017d0847..1d2314e90e4d 100644
> > --- a/lib/mbedtls/mbedtls_def_config.h
> > +++ b/lib/mbedtls/mbedtls_def_config.h
> > @@ -92,9 +92,6 @@
> >
> >  /* Generic options */
> >  #define MBEDTLS_ENTROPY_HARDWARE_ALT
> > -#define MBEDTLS_HAVE_TIME
> > -#define MBEDTLS_PLATFORM_MS_TIME_ALT
> > -#define MBEDTLS_PLATFORM_TIME_MACRO rtc_mktime
> >  #define MBEDTLS_PLATFORM_C
> >  #define MBEDTLS_SSL_CLI_C
> >  #define MBEDTLS_SSL_TLS_C
>
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks
/Ilias
>
> Thanks,
> --
> Jerome
