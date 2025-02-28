Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DFDC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 21:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2260080AE1;
	Fri, 28 Feb 2025 22:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jI7sIqJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EAE810EB; Fri, 28 Feb 2025 22:25:24 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DA4809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 22:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3983426f80so2146343276.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740777921; x=1741382721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L7q71QmkDaP2qCrPorXGE5JPvF05joxXq5fy2G/nSzs=;
 b=jI7sIqJhVw/D00opJBLrcMczeZLrysluSkLX28RvYX8n3OO0cUn392ggNYL8EN02v0
 jQC5r12+TnNaNh1lfcL+JIJEqoUmrgVtY/NjjBsp1J/aTq/4CcqZXtxaph0JPsJH+2E3
 RfM3Bwc/I1rDzxMtVIimOxGVsMD2RiXUMxq8d+EP1dXw0WzMCzMoknOg1Bi8gNUrpVmL
 yE2SV2zocjAPmxsMSC9Lbq2QmVaFyKiFwCd5euhUWQA11kxbfkzyC53P/zI6AycIL32k
 5351rc1LwTx1RmSCDeEHCYzAsijX0UgLwgfn/st7Tr2AaEN/lkEaTCT04uqqkjqxAddc
 v9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740777921; x=1741382721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L7q71QmkDaP2qCrPorXGE5JPvF05joxXq5fy2G/nSzs=;
 b=UA+iwbU34nF68vsrVeiqxfGRSG3giSewgyqAIi4QGvH/1j160natpc9KVuwtpoNSz5
 L5+1ShHamg+SLwOIXJaIDf3YxWaEslBsVGlvu3PPY9M2UWeeTWWz+ImomiIbTtrGMFXG
 QSH9uuYQt2Tsz184JlO5kq3orqdKPm38vVWS8xIU5MG2BiynCcGwXp8tPsP4qzHoP1jU
 Sqq28G7aeg/FGA34iqhHpWDKouvyrBunKWL5G8R2PZygoPwa3jW5F2IfmlrX37r2X5Tq
 CaupiadJ6tPB1PES1p/TEIN4iXEgJQJ5lrwYkLH/oxxT4zScWNlROHpC56umrWnL2FOz
 ElaA==
X-Gm-Message-State: AOJu0YzxOzCuZOXx2MDTxx6qYM88dWI7mT6HTB583syjiv4+K21fDdfn
 CB/qTAjd4hdy634Qs6HJ6xy9UTaSe8j3a4BH0YzUYc2gVUwzX/WlhvgODaUyOM8d1t2JsvONZjy
 IV+zehVsC4/Eqe3Jk0ZX5LyunEARwt3UXt8FlmQ==
X-Gm-Gg: ASbGncsiPaGGDE4dcHtrIdQrKVZdvdqHGh7xQQe5HNWn6GHOCiQGnCsW5Ib2ZcAn4po
 tB9pFqHvPadoIFcjICmMa28LHAcpbbp4l7dRld8J+SG3VXoZ5kePD0H+ocJfZC3r6AUAL+n5fUN
 4sAMEzm0i89UPxqU4JTS5tiYOCAO8xQ644Vb9dkSc=
X-Google-Smtp-Source: AGHT+IEFPjHW6IduzIYkvkDaIKrxcsOsmvcmrEdM4njhqBNmmNNKePvDBCpYFbZKbBAM8iO7BpvrPGozYoBVAJNkvbw=
X-Received: by 2002:a05:6902:2501:b0:e5d:de80:e6bd with SMTP id
 3f1490d57ef6-e60b2f2db9fmr5555338276.34.1740777921427; Fri, 28 Feb 2025
 13:25:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <3a93751157801fe709d995eae1883f9e3219733c.1740672437.git.jerome.forissier@linaro.org>
In-Reply-To: <3a93751157801fe709d995eae1883f9e3219733c.1740672437.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 23:24:45 +0200
X-Gm-Features: AQ5f1Jps3tXs7p-UhbVpdhPbFsKBBjw5xzyn2pwa-88dtJoSlgtVvMZq2sOLy9Q
Message-ID: <CAC_iWjKuEyFCAeqFSv2u6iN9TFzsod7xZVG6EZeSgK88C78AkQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: lwip: extend wget to support CA (root)
 certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Adriano Cordova <adrianox@gmail.com>
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

>
> +config WGET_CACERT
> +       bool "wget cacert"
> +       depends on CMD_WGET
> +       depends on WGET_HTTPS
> +       help
> +         Adds the "cacert" sub-command to wget to provide root certificates
> +         to the HTTPS engine.
> +
> +config MBEDTLS_LIB_X509_PEM
> +       depends on WGET_CACERT
> +       bool "Support for PEM-encoded X509 certificates"
> +       help
> +         This option enables MbedTLS to parse PEM-encoded X509 certificates.
> +         When disabled, only DER format is accepted.
> +
>  endif  # if CMD_NET

I guess that's needed because most of the RootCAs you can download are in PEM?

[...]

>  }
>
> +#if defined CONFIG_WGET_HTTPS

you can do #if IS_ENABLED() here

> +static char *cacert;
> +size_t cacert_size;
> +#endif
> +
> +#if defined CONFIG_WGET_CACERT
> +static int set_cacert(char * const saddr, char * const ssz)
> +{
> +       mbedtls_x509_crt crt;
> +       ulong addr, sz;
> +       int ret;
> +
> +       if (cacert)
> +               free(cacert);
> +
> +       addr = hextoul(saddr, NULL);
> +       sz = hextoul(ssz, NULL);
> +       sz++; /* For the trailing '\0' in case of a text (PEM) file */
> +
> +       if (!addr) {
> +               cacert = NULL;

cacert is already allocated. Can't we just free it here if it's
supposed to be removed and reuse the memory otherwise, instead of
doing free/alloc on every command?

> +               cacert_size = 0;
> +               return CMD_RET_SUCCESS;
> +       }
> +
> +       cacert = malloc(sz);
> +       if (!cacert)
> +               return CMD_RET_FAILURE;
> +       cacert_size = sz;
> +
> +       memcpy(cacert, (void *)addr, sz - 1);
> +       cacert[sz] = '\0';
> +
> +       mbedtls_x509_crt_init(&crt);
> +       ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
> +       if (ret) {
> +               printf("Could not parse certificates (%d)\n", ret);
> +               free(cacert);
> +               cacert = NULL;
> +               cacert_size = 0;
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       return CMD_RET_SUCCESS;

[...]

Thanks
/Ilias
