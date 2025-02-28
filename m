Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CB3C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 21:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1425B810F4;
	Fri, 28 Feb 2025 22:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c/0ok9Hk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBCC810F5; Fri, 28 Feb 2025 22:29:01 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FB1809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 22:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e60b81c29c5so564520276.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740778137; x=1741382937; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WS2N2TW7y48dNxB2jSfYm5VlmCPvJCWnsSC5KcVRxis=;
 b=c/0ok9HktAEj3AzlIso+SlDiGq8l2nHWWwcar7UQbUc1SMifqVt6W0JUzqHhi0I2t/
 26X94gBAz2sF5POyAPKq+q2Wwhw7DVNNU0tvUtCDIBZtRZHupGXEqAYsf7+EL5LXeFoi
 5EAovyfFRDk826BP9ok0MB1T9sPVae1379maHjBMNFJS0JOEjLbrtSao+b7X8ATVcQA0
 vWN8XXu3crjO1KlfHredJZ4yfakUUIfwuKUSd9jJyJpeSgzNnea8xrM5191UznzmoorA
 Ncipf+Ot4IH78zGuJz2Ywj5P5wI2I++m+wKqonwtq+COzt1vuxl+C+K7vEXBVVqpYCKs
 K5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740778137; x=1741382937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WS2N2TW7y48dNxB2jSfYm5VlmCPvJCWnsSC5KcVRxis=;
 b=tHd/fwoJthi8bw4XJVSnv72pju/cYqVRw3n9PPp8T50K9mb3bt7eXX2E2IcB7tA4C2
 TjKl2NpHZTAmUDOMoWOvMPAENbflgZIhcMRADWF7WTx7w46coKCoaKojNyge78jf10oO
 RYOlf08/Fyr8A1f1tY8apelAyJUZM1k0x+ripaGhTLUAOP84bjPBF3x94d+axswLP/Sf
 bBIzCjYbwI3aW2TPWTZFeRib8ylgAuPM8sojl3pcwCqg+M3o4ltNGC1Y1ImOLmP946uZ
 zitMHwFt/zHYD/jMTWnar+eZ4ranw8LShelcQ/zOCuoPkjJXdK8VxAhe6t1Kyfnbeg3s
 2DJg==
X-Gm-Message-State: AOJu0YzMi3C/awC2UOMbgt6Po76mz1yS0aa+/880E1U0ykseDhxMXT45
 rFr1dVittOj6SohWeIsvfw74uxc73U+M2nDBhdlAgnxX4rNUQzvaTPsCc5NjZHs0gs/SvY4/bnZ
 ftxZIJao3dRgmRXlcVtyrHDZmubp03ZhrEzesQw==
X-Gm-Gg: ASbGncslRjiW4kih6Vx9SAF/GXnfHDiHzl7MuvPUCfbdpHZ1Uz7v406JNbstesxzjEg
 I/s20ULB3uAIgbO619h6+VahqG0kMjCmypBCxEtt7B880hP09aWZ3ASvH/O46MmI92WXlDWGcC4
 o0FJ8hjLQIF5acH5hsLd/W56Zs66C1QT8TNb+D8MwYY6jBAXT0klqa2P4jcA==
X-Google-Smtp-Source: AGHT+IFMvnXm/3rmsLJGc5A+YtqDG49+tbxaCA3pnZ4cHnptqoL13a7buRHevLopTf3ypIVbESfbYyg1epq5rDaCYkg=
X-Received: by 2002:a05:6902:84a:b0:e5b:406f:3b02 with SMTP id
 3f1490d57ef6-e60b2398160mr6653288276.12.1740778137496; Fri, 28 Feb 2025
 13:28:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <13cea41b33f62ddbd606a926bd1f79ddff8569fb.1740672437.git.jerome.forissier@linaro.org>
In-Reply-To: <13cea41b33f62ddbd606a926bd1f79ddff8569fb.1740672437.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 23:28:21 +0200
X-Gm-Features: AQ5f1JrWfIrN_XjxUqkO4u23a64tAygoGQMw3Uqnv5K1TcoB-wIA6aqivoB8Ywc
Message-ID: <CAC_iWjJiB7m=DiwqFuC=VgXTCxWXE3H06Du7uaMCZe=GZZ5orA@mail.gmail.com>
Subject: Re: [PATCH 3/5] lwip: tls: warn when no CA exists amd log certificate
 validation errors
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Goldschmidt <goldsimon@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Javier Tia <javier.tia@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

+CC Simon again

Same comments. The patch is nice we should somehow get it in lwIP

On Thu, 27 Feb 2025 at 18:09, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Using HTTPS without root (CA) certificates is a security issue. Print a
> warning in this case. Also, when certificate verification fail, print
> an additional message because "HTTP client error 4" is not very
> informative (4 is HTTPC_RESULT_ERR_CLOSED).
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> index fa3d1d74fed..ef51a5ac168 100644
> --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> @@ -298,6 +298,9 @@ altcp_mbedtls_lower_recv_process(struct altcp_pcb *conn, altcp_mbedtls_state_t *
>      if (ret != 0) {
>        LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG, ("mbedtls_ssl_handshake failed: %d\n", ret));
>        /* handshake failed, connection has to be closed */
> +      if (ret == MBEDTLS_ERR_X509_CERT_VERIFY_FAILED) {
> +        printf("Certificate verification failed\n");
> +      }
>        if (conn->err) {
>          conn->err(conn->arg, ERR_CLSD);
>        }
> @@ -841,6 +844,9 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
>      altcp_mbedtls_free_config(conf);
>      return NULL;
>    }
> +  if (authmode == MBEDTLS_SSL_VERIFY_NONE) {
> +     printf("WARNING: no CA certificates, HTTPS connections not authenticated\n");
> +  }
>    mbedtls_ssl_conf_authmode(&conf->conf, authmode);
>
>    mbedtls_ssl_conf_rng(&conf->conf, mbedtls_ctr_drbg_random, &altcp_tls_entropy_rng->ctr_drbg);
> --
> 2.43.0
>
