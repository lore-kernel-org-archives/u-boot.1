Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0C2D44D62
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 13:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E6B88C75;
	Wed,  6 Nov 2024 14:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S0q7Cp4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E7488BBE; Wed,  6 Nov 2024 14:39:54 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C3DD88C75
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so52283765e9.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730900392; x=1731505192; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USOi9rT3NI/Kx8OTRORoKri3dIuUvurvScGC0MWQCxY=;
 b=S0q7Cp4nJe5QQCFSLWv3j6CFCoN1LhNLpMP6ArBafOfZllKugPAJKYefOcwjiQemu/
 B4/WYJpvxjOtRFPVeixZQLUgYhiJnciy8ymf+7RtnMHhn66RFJAZs7/cZt+2cB23BJBk
 sLCrKMLZIzwg2HBfr9lbkcbdYgZeh5rDGy6JF2G7kvHa26gHai40Z+je4Nd18V1x7GU3
 M9T4dR0u/ercZoJev2a0IDVfMnyHNapQwTYHxB+FO+aUYjZHXEhSv0vovw2tO22nc0nA
 zy736R3V1/ZZdtnjTcKs84MECALYjNNrhEMmXhxphogFtyoDGWdn5SfxVQJjix53IDWP
 lshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900392; x=1731505192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USOi9rT3NI/Kx8OTRORoKri3dIuUvurvScGC0MWQCxY=;
 b=mb0mcZ1T3q7N8PfMZDh2ynBJGABM0+zCpSZQ8yJUIxDq2QYpYM7sn2T1o7MD2OKa71
 RWiSkli4vRXlXyz6uxYntCOf8k4k7hI9Pu9saTa7HeAIEoWSEzoWYyzYLeNJsLz3vm4y
 0HqqYCjV/55ecWW6TkdNNL/a+A8XwUCEw3KCxnoZreQabJilhqIOCXUSGByw/YW9V/Cr
 2AP5wuqzzgjmkknxVjeJ6PbnXMhAI98Tjq0fUnkFCC26bCCuOfPAtMr5YjzMNzoquXeu
 iWdbCxjGgCw3pxH9BrCg8V5pyMRD1PieWvtknEGAHodcg6//v2GIz8ikm9a7Mr1a5PV4
 hF9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPbsOVMrCGR2wDE+AY/xpsIUYuFh/0hLL8L77A0CmE7eiZgQBjzcMaRBQwJVSbvI3tfAX6Vno=@lists.denx.de
X-Gm-Message-State: AOJu0YzpZ1snyamQ0npj4oovuHHmr15YtgnzquuM6/75cYnwcJgnJ6E2
 FTWmeuE+wFg1wfEFsj+kmkkZXX/kM+nafG5GLIPm5J6hjlq365IdgGfa1jtjrOQ=
X-Google-Smtp-Source: AGHT+IE5I2u/x5QPNP+BcwXxSJQloC5b98pElaVUnR+b9lqwvbQVujw2eeZLML6fmoj7fB1pzUWQzQ==
X-Received: by 2002:a5d:58d4:0:b0:37c:cca1:b1e3 with SMTP id
 ffacd0b85a97d-381b70f070amr19051935f8f.41.1730900391675; 
 Wed, 06 Nov 2024 05:39:51 -0800 (PST)
Received: from [172.20.141.182] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e61f9sm19147676f8f.58.2024.11.06.05.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 05:39:51 -0800 (PST)
Message-ID: <66c8e1a4-00e0-499c-9a2c-5fb83eb3e4e9@linaro.org>
Date: Wed, 6 Nov 2024 13:39:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] net: lwip: Add Support Server Name Indication
 support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Javier Tia <javier.tia@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241024112449.1362319-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 10/24/24 12:24, Ilias Apalodimas wrote:
> From: Javier Tia <javier.tia@linaro.org>
> 
> SNI, or Server Name Indication, is an addition to the TLS encryption
> protocol that enables a client device to specify the domain name it is
> trying to reach in the first step of the TLS handshake, preventing
> common name mismatch errors and not reaching to HTTPS server that
> enforce this condition. Since most of the websites require it nowadays
> add support for it.
> 
> It's worth noting that this is already sent to lwIP [0]
> 
> [0] https://github.com/lwip-tcpip/lwip/pull/47
> 
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 11 +++++++----
>  lib/lwip/lwip/src/include/lwip/altcp_tls.h           |  2 +-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> index ef19821b89e0..24b432966312 100644
> --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> @@ -106,6 +106,7 @@ struct altcp_tls_config {
>    u8_t pkey_count;
>    u8_t pkey_max;
>    mbedtls_x509_crt *ca;
> +  char host[256];
>  #if defined(MBEDTLS_SSL_CACHE_C) && ALTCP_MBEDTLS_USE_SESSION_CACHE
>    /** Inter-connection cache for fast connection startup */
>    struct mbedtls_ssl_cache_context cache;
> @@ -642,6 +643,7 @@ altcp_mbedtls_setup(void *conf, struct altcp_pcb *conn, struct altcp_pcb *inner_
>    /* tell mbedtls about our I/O functions */
>    mbedtls_ssl_set_bio(&state->ssl_context, conn, altcp_mbedtls_bio_send, altcp_mbedtls_bio_recv, NULL);
>  
> +  mbedtls_ssl_set_hostname(&state->ssl_context, config->host);
>    altcp_mbedtls_setup_callbacks(conn, inner_conn);
>    conn->inner_conn = inner_conn;
>    conn->fns = &altcp_mbedtls_functions;
> @@ -951,7 +953,7 @@ altcp_tls_create_config_server_privkey_cert(const u8_t *privkey, size_t privkey_
>  }
>  
>  static struct altcp_tls_config *
> -altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2wayauth)
> +altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2wayauth, char *host)
>  {
>    int ret;
>    struct altcp_tls_config *conf = altcp_tls_create_config(0, (is_2wayauth) ? 1 : 0, (is_2wayauth) ? 1 : 0, ca != NULL);
> @@ -973,13 +975,14 @@ altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2way
>  
>      mbedtls_ssl_conf_ca_chain(&conf->conf, conf->ca, NULL);
>    }
> +  memcpy(conf->host, host, sizeof(conf->host));

What if host is smaller than sizeof(conf->host)? Should be strncpy() IMHO.

>    return conf;
>  }
>  
>  struct altcp_tls_config *
> -altcp_tls_create_config_client(const u8_t *ca, size_t ca_len)
> +altcp_tls_create_config_client(const u8_t *ca, size_t ca_len, char *host)
>  {
> -  return altcp_tls_create_config_client_common(ca, ca_len, 0);
> +  return altcp_tls_create_config_client_common(ca, ca_len, 0, host);
>  }
>  
>  struct altcp_tls_config *
> @@ -995,7 +998,7 @@ altcp_tls_create_config_client_2wayauth(const u8_t *ca, size_t ca_len, const u8_
>      return NULL;
>    }
>  
> -  conf = altcp_tls_create_config_client_common(ca, ca_len, 1);
> +  conf = altcp_tls_create_config_client_common(ca, ca_len, 1, NULL);
>    if (conf == NULL) {
>      return NULL;
>    }
> diff --git a/lib/lwip/lwip/src/include/lwip/altcp_tls.h b/lib/lwip/lwip/src/include/lwip/altcp_tls.h
> index fcb784d89d70..fb0618234481 100644
> --- a/lib/lwip/lwip/src/include/lwip/altcp_tls.h
> +++ b/lib/lwip/lwip/src/include/lwip/altcp_tls.h
> @@ -92,7 +92,7 @@ struct altcp_tls_config *altcp_tls_create_config_server_privkey_cert(const u8_t
>  /** @ingroup altcp_tls
>   * Create an ALTCP_TLS client configuration handle
>   */
> -struct altcp_tls_config *altcp_tls_create_config_client(const u8_t *cert, size_t cert_len);
> +struct altcp_tls_config *altcp_tls_create_config_client(const u8_t *cert, size_t cert_len, char *host);
>  
>  /** @ingroup altcp_tls
>   * Create an ALTCP_TLS client configuration handle with two-way server/client authentication

With the above comment addressed:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
