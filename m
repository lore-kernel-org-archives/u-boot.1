Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ADCC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 21:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9046680AE1;
	Fri, 28 Feb 2025 22:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YC3tdKpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DE1810ED; Fri, 28 Feb 2025 22:27:36 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D793809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 22:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e60c4e83cd3so299678276.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740778053; x=1741382853; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KLC29geMWqM22nffc5TJBypQohmnLrKf5EX7VkKTX3Y=;
 b=YC3tdKpCDhMJmfphoMKe4mprfw9xojVnjMTT3FbQklUYVxutrG3pEiyunuq0bH78e+
 9CVA6pwHBJzpVN79kFeFTMLpsUhMvgr3mRphZ9nnw3+ZiysT2xTXUDFrZwonHPGDQ0fU
 NSLHWApZ9sATJvZRFCfJghuznv8cZX8PurM7bDaVNzREfq2wDtZZKEH2X+BNVbVB9EAM
 IUTQEXAn6CbM0YBlgeDaMsljsGgpGassY2U+usFKXJHL8Nmw6pyNK5gebIZMeqhK0NYW
 zdNIpMwAnvZdMjBXjqeJK1vFg4wsK6f8ljBytN0BpZtdQZfCjF5tLdZaqFf+uYRyCoID
 pw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740778053; x=1741382853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KLC29geMWqM22nffc5TJBypQohmnLrKf5EX7VkKTX3Y=;
 b=BR9fPPS5X8KpMD2ZrzVnUtdLiu9D6qcXCNtsVeial43qnP2SP2B9qIsAF+GD1V2Z1x
 VpKGtPzQzbHOsUE0q7k+3mieKPJVtclhiQyUXBgbe6tbeVX/0CF3aVmBUq43YpUqt6Ro
 pcO4JdyhE77v/wR0A1nc4zLw07zi1opeoDSVnYrEwhDAeIIuyukhrcfE/PZYsaGG0RNw
 p5+81cC8SmBysE/7JIGLBVhEUfW8XxDKVwdjMBs/Dz6iI3Y0nwv8UnCpOaNv8iNjm4bB
 OKbp+ZeIWz7T+RE+yW6ap1OvcaMaQGDUUWOH6lxP7hLGsFc0D8ZtjD3AOclZYtVgy7ns
 cnXA==
X-Gm-Message-State: AOJu0YwGlYg5LyrbOFpFtJAhhIcg4bc6mfHHuYCRTw9mpSUbb0d7majP
 hblgO9eme9kVZdsxe841Fy4JaT/L/yC1uyBYkiveyeT5JdIddpazXtRF97FCLnhAFExA0ynwrcZ
 8wqXk20oBzUSNhCeL4hMemH/tUh+k42L1k+cCVA==
X-Gm-Gg: ASbGncu9xm+lqgHNyCpHSY/r8pzBxrd8s/LFxgEJjPYEtumOaop8NPCOvdHGiZQpg50
 AsGiIu1xrnRSgO9sr2+HmCafOJ1nK4/LTlLcvliAVZKu9AF6m17aOjDVOAQte+Tw2WisDMk2QNC
 dP1Xbk1RnrEr3Rqcjrcj8Zn2cppTRXZx0D4T+3l1c=
X-Google-Smtp-Source: AGHT+IHTelsTiontdqKsMMz8NbNKJddc6T+U9RcTCbevYaf53sEFM1i1ih/kB+1lOl2mGAd8QfEpOyv0vu2SVX1Tmpk=
X-Received: by 2002:a05:6902:2505:b0:e5b:1119:60d0 with SMTP id
 3f1490d57ef6-e60b2f040ccmr5801874276.34.1740778053076; Fri, 28 Feb 2025
 13:27:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <f9841a538eae301779e33c4dcf1d0ae126759909.1740672437.git.jerome.forissier@linaro.org>
In-Reply-To: <f9841a538eae301779e33c4dcf1d0ae126759909.1740672437.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 23:26:57 +0200
X-Gm-Features: AQ5f1Jq8zJ4hIwxoEfzlEbc9mZ3kPfaeU0_zCVocTebrZxXDbQP9Qolg6Hd-f38
Message-ID: <CAC_iWj+Msh-W5zfZPoJ4q5DVnw_F4xHGPR-RzeT95oSE0ozwtw@mail.gmail.com>
Subject: Re: [PATCH 2/5] lwip: tls: enforce checking of server certificates
 based on CA availability
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Javier Tia <javier.tia@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Goldschmidt <goldsimon@gmx.de>
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

Hi Jerome

++CC Simon for lwIP

On Thu, 27 Feb 2025 at 18:09, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Instead of relying on some build time configuration to determine if
> server certificates need to be checked against CA certificates, do it
> based on the availability of such certificates. If no CA is configured
> then no check can succeed; on the other hand if we have CA certs then
> we should not ignore them. It is always possible to remove the CA certs
> (via 'wget cacert 0 0') to force an HTTPS download that would fail
> certificate validation

This looks correct, but we should at some point send those to lwIP as
well instead of keeping them locally

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c        | 3 ++-
>  .../lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h     | 6 ------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> index 46421588fef..fa3d1d74fed 100644
> --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> @@ -786,6 +786,7 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
>    int ret;
>    struct altcp_tls_config *conf;
>    mbedtls_x509_crt *mem;
> +  int authmode = have_ca ? MBEDTLS_SSL_VERIFY_REQUIRED : MBEDTLS_SSL_VERIFY_NONE;
>
>    if (TCP_WND < MBEDTLS_SSL_IN_CONTENT_LEN || TCP_WND < MBEDTLS_SSL_OUT_CONTENT_LEN) {
>      LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG|LWIP_DBG_LEVEL_SERIOUS,
> @@ -840,7 +841,7 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
>      altcp_mbedtls_free_config(conf);
>      return NULL;
>    }
> -  mbedtls_ssl_conf_authmode(&conf->conf, ALTCP_MBEDTLS_AUTHMODE);
> +  mbedtls_ssl_conf_authmode(&conf->conf, authmode);
>
>    mbedtls_ssl_conf_rng(&conf->conf, mbedtls_ctr_drbg_random, &altcp_tls_entropy_rng->ctr_drbg);
>  #if ALTCP_MBEDTLS_LIB_DEBUG != LWIP_DBG_OFF
> diff --git a/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h b/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
> index e41301c061c..71aa5993935 100644
> --- a/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
> +++ b/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
> @@ -100,12 +100,6 @@
>  #define ALTCP_MBEDTLS_SESSION_TICKET_TIMEOUT_SECONDS  (60 * 60 * 24)
>  #endif
>
> -/** Certificate verification mode: MBEDTLS_SSL_VERIFY_NONE, MBEDTLS_SSL_VERIFY_OPTIONAL (default),
> - * MBEDTLS_SSL_VERIFY_REQUIRED (recommended)*/
> -#ifndef ALTCP_MBEDTLS_AUTHMODE
> -#define ALTCP_MBEDTLS_AUTHMODE                        MBEDTLS_SSL_VERIFY_OPTIONAL
> -#endif
> -
>  #endif /* LWIP_ALTCP */
>
>  #endif /* LWIP_HDR_ALTCP_TLS_OPTS_H */
> --
> 2.43.0
>
