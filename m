Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E5C282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 11:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5930801DE;
	Sun,  9 Mar 2025 12:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q7fRjfpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F3B80FDE; Sun,  9 Mar 2025 12:35:30 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F02080107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 12:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so2474787276.0
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 04:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741520127; x=1742124927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U78Csx1mgCb6cZzWXwr5Ll04V+b/1dyJfuvjpTrmVKo=;
 b=q7fRjfpQegEa8Y9afMCY5d85ecmiDmHWYSAE/J4Pij9y4PAcsW3v1VkXAY9gU0UqSi
 BgOlp5bE1ZmgUy0glFnLGfSIBKc3gf/7S1Ltn0PkSI3TPDUXEDJ+x22heielVw/U31PI
 oQqEaaBW8g1HQQjqNuwbrasVaFowybSVpII1mjQTQvxii0v7DfLxcZRJulCVN0a95nYg
 V8Xg/4F3WXu21KYyvatx3TIUFBOd0tNZLd+9iM0QvvF7QW/khmEliWB/Kr+GBwEE/b7T
 ynMsaNWTSEgPvjq87loW/TDoNXtmZbZKHgK7feS4bhtLCIhfO+t7wtqHf4cPVIh7Yi0B
 Asfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741520127; x=1742124927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U78Csx1mgCb6cZzWXwr5Ll04V+b/1dyJfuvjpTrmVKo=;
 b=EMjl0gWWtfIkXmYzepkrBkUkq8V9I2T3+T+4JA7ZjkcOklXVT4Q/pJs9McZZm+kFVC
 RpK0iMiUYDvUpGiAnUTgsxbUGNVvQkPCFy0+Ulzf+XXCyfWOaKL89AyRNNr46TWYL0cw
 kk93pgMjtjHD9VWzcZz0NmSAxOesRf8VQAsTEjDf1pwO35bLkDGoEKHVIaFeS4+C0Lmx
 H4tJREOg7gbsdecfeMVCp36MkBe2JEUptuGZ/UotsDt6j+duEXpff7hWSk4ytpjSTbD4
 DN0H7LS6A/BOOHpFuQgGgw2kLscQLbCM4yONORCsg2vCfBarDdD9q3TY1TLpvd2bItRq
 5ZXA==
X-Gm-Message-State: AOJu0YyKfI9S4zgzZ0cEkphTZhcqnrriziFQPZPPZ1OWtt/wPgv4MOqJ
 1TTlD/s8mYCNZSAiQ8jxIVbY6eZVbGyNGjqYVodHCQywUsxJ/oIVtoCRObubMHM3DQvF+7NOc+3
 WNxP9coR1aDZ1QjUZSOwtoqCFbS9upVm3A2u3Og==
X-Gm-Gg: ASbGncudHUarOkZZH8WeSqoCz71pxV22hy/nekAKFgrm0mWoZ6mnoc3mpiOqhPaa0Kz
 c9EgDZK1rLlxQrslo8ffYogoGI1XQqkiLGWKfxXBkN3CeIxiO+hTk66NC2c38RFV1UZrzaXe1yB
 FWaYYSBq93QHiSECtRP2TjD6mGNoI=
X-Google-Smtp-Source: AGHT+IEltuoYEdjshNTHwg+aUKl3Xj2tqCn/I+MnwR7fHWSNklkaM9LWH7GxH7QMXGzn/mU/NqjzpnXwrq4wgWqg/Pw=
X-Received: by 2002:a05:6902:18d0:b0:e60:ac7a:996a with SMTP id
 3f1490d57ef6-e635c162dafmr11928838276.20.1741520126924; Sun, 09 Mar 2025
 04:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-6-jerome.forissier@linaro.org>
In-Reply-To: <20250305142650.2966738-6-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 13:34:51 +0200
X-Gm-Features: AQ5f1JqbeId9CuKibuIo84Is4ZLMFNX-IJm7kkiEkSN1ZgMDdBGhJi_ziY6yZ9I
Message-ID: <CAC_iWjJ0Pwx0H2HcecuiwRCiV2ZpdihNaVAX70cG6U++ZoDzrQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] doc: cmd: wget: document cacert subcommand
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Wed, 5 Mar 2025 at 16:27, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Document the 'wget cacert' subcommand which allows to configure root
> (CA) certificates for HTTPS.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  doc/usage/cmd/wget.rst | 82 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 2 deletions(-)
>
> diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
> index 48bedf1e845..cc82e495a29 100644
> --- a/doc/usage/cmd/wget.rst
> +++ b/doc/usage/cmd/wget.rst
> @@ -12,7 +12,9 @@ Synopsis
>  ::
>
>      wget [address] [host:]path
> -    wget [address] url          # lwIP only
> +    wget [address] url                  # lwIP only
> +    wget cacert none|optional|required  # lwIP only
> +    wget cacert <address> <size>        # lwIP only
>
>
>  Description
> @@ -54,6 +56,32 @@ address
>  url
>      HTTP or HTTPS URL, that is: http[s]://<host>[:<port>]/<path>.
>
> +The cacert (stands for 'Certification Authority certificates') subcommand is
> +used to provide root certificates for the purpose of HTTPS authentication. It
> +also allows to enable or disable authentication.
> +
> +wget cacert <address> <size>
> +
> +address
> +    memory address of the root certificates in X509 DER format
> +
> +size
> +    the size of the root certificates
> +
> +wget cacert none|optional|required
> +
> +none
> +    certificate verification is disabled. HTTPS is used without any server
> +    authentication (unsafe)
> +optional
> +    certificate verification is enabled provided root certificates have been
> +    provided via wget cacert <addr> <size> or wget cacert builtin. Otherwise
> +    HTTPS is used without any server authentication (unsafe).
> +required
> +    certificate verification is mandatory. If no root certificates have been
> +    configured, HTTPS transfers will fail.
> +
> +
>  Examples
>  --------
>
> @@ -97,11 +125,61 @@ In the example the following steps are executed:
>     1694892032 bytes transferred in 492181 ms (3.3 MiB/s)
>     Bytes transferred = 1694892032 (65060000 hex)
>
> +Here is an example showing how to configure built-in root certificates as
> +well as providing some at run time. In this example it is assumed that
> +CONFIG_WGET_BUILTIN_CACERT_PATH=DigiCertTLSRSA4096RootG5.crt downloaded from
> +https://cacerts.digicert.com/DigiCertTLSRSA4096RootG5.crt.
> +
> +::
> +
> +   # Make sure IP is configured
> +   => dhcp
> +   # When built-in certificates are configured, authentication is mandatory
> +   # (i.e., "wget cacert required"). Use a test server...
> +   => wget https://digicert-tls-rsa4096-root-g5.chain-demos.digicert.com/
> +   1864 bytes transferred in 1 ms (1.8 MiB/s)
> +   Bytes transferred = 1864 (748 hex)
> +   # Another server not signed against Digicert will fail
> +   => wget https://www.google.com/
> +   Certificate verification failed
> +
> +   HTTP client error 4
> +   # Disable authentication to allow the command to proceed anyways
> +   => wget cacert none
> +   => wget https://www.google.com/
> +   WARNING: no CA certificates, HTTPS connections not authenticated
> +   16683 bytes transferred in 15 ms (1.1 MiB/s)
> +   Bytes transferred = 16683 (412b hex)
> +   # Force verification but unregister the CA certificates
> +   => wget cacert required
> +   => wget cacert 0 0
> +   # Unsurprisingly, download fails
> +   => wget https://digicert-tls-rsa4096-root-g5.chain-demos.digicert.com/
> +   Error: cacert authentication mode is 'required' but no CA certificates given
> +   # Get the same certificates as above from the network
> +   => wget cacert none
> +   => wget https://cacerts.digicert.com/DigiCertTLSRSA4096RootG5.crt
> +   WARNING: no CA certificates, HTTPS connections not authenticated
> +   1386 bytes transferred in 1 ms (1.3 MiB/s)
> +   Bytes transferred = 1386 (56a hex)
> +   # Register them and force authentication
> +   => wget cacert $fileaddr $filesize
> +   => wget cacert required
> +   # Authentication is operational again
> +   => wget https://digicert-tls-rsa4096-root-g5.chain-demos.digicert.com/
> +   1864 bytes transferred in 1 ms (1.8 MiB/s)
> +   Bytes transferred = 1864 (748 hex)
> +   # The builtin certificates can be restored at any time
> +   => wget cacert builtin
> +
>  Configuration
>  -------------
>
>  The command is only available if CONFIG_CMD_WGET=y.
> -To enable lwIP support set CONFIG_NET_LWIP=y.
> +To enable lwIP support set CONFIG_NET_LWIP=y. In this case, root certificates
> +support can be enabled via CONFIG_WGET_BUILTIN_CACERT=y
> +CONFIG_WGET_BUILTIN_CACERT_PATH=<some path> (for built-in certificates) and/or
> +CONFIG_WGET_CACERT=y (for the wget cacert command).
>
>  TCP Selective Acknowledgments in the legacy network stack can be enabled via
>  CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
> --
> 2.43.0
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
