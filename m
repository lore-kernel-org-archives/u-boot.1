Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AD9CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 12:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95AEF86B7E;
	Mon, 25 Sep 2023 14:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uo7dxaf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1962286406; Mon, 25 Sep 2023 14:12:15 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E8286B7E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 14:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3231d6504e1so2632864f8f.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695643932; x=1696248732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+4QRnxu8QkD7PF+RsGq8qejvzjvYCqJFqVbS+Bc7nv4=;
 b=uo7dxaf5XvAmMiVPruvOWsoGtfosqdQugC9STteVhIxvU56h+NTzU+EDmfLJTKY46m
 1USbuCdhTxB2Rb5FUp+hJALo4bK3xCtBduAS2G+tpZZLNAaBAjIdvuXlShKtK4uRTaFZ
 /c9pgYFNSZptM9Ta+3LvYhygqPZSnyHhIYO4UXyVfCKz/C89njC0QTTJFNv6WKbYP7cm
 6P+laKZW3pFG6gxvZFfVYdR7I8IybCbrFN+Su4pGvffHqNNd2c2v//3iJJr0P7yq/7eu
 a23okykfcpUEM2Ox16oaxeyU7z/5awZOmKFFtJIDyO5eUtDv054BEm77uNyI45CRk9AN
 9j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695643932; x=1696248732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4QRnxu8QkD7PF+RsGq8qejvzjvYCqJFqVbS+Bc7nv4=;
 b=BnI44v6cWhp45YHinl4QiC1XvX5bdZPAZ2C7iGpRRXV8WHVqf2Lkvg4aqlz0knwNzf
 9xzjOZribFdlcy9ieAquf2DRT3PzFM4kv5SQX9IVnHNQ1XNmt+YYJbZlgH8Zduzgg6z/
 +jO6EMMO59zM1B8+8ZvfziTIjURdAF3bLZIhDFSzwhv06SQEfql5FWOw22UE9pDAH4X8
 s4SPtvO7U1BI6/YQSo+YNC/5+7d+Qo+Y+ZD8FA12hQAqRAkkzP8ziUGNuOvvStshXDP9
 SOZYQqMEpVlkrN71Tll56JGN1i8pOPnCNFfsULLhsx/BIXpbTBkws0w5wuVQm+UOPZhx
 Paiw==
X-Gm-Message-State: AOJu0Yx7SJ9un0i2X9Y/toS6N4A/ni3y9j5fcD6S0vKZAciDM/+tQije
 hgJ+Lqi7KIZUs+H0jUCHprigXw==
X-Google-Smtp-Source: AGHT+IGJFV1t8s5s2ZMB/RWDwBDVGinQbeWpNZO6qpOAod53zU491G3fmHEKANJYlMGQc4sq7ofbcg==
X-Received: by 2002:a05:6000:10d:b0:320:1c6:628c with SMTP id
 o13-20020a056000010d00b0032001c6628cmr4780365wrx.65.1695643931776; 
 Mon, 25 Sep 2023 05:12:11 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a5d6849000000b0031989784d96sm11742137wrw.76.2023.09.25.05.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 05:12:11 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:12:09 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v4 7/8] doc: uefi: add HTTP Boot support
Message-ID: <ZRF5GbIuNg07OY7K@hera>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-8-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922071119.1439482-8-masahisa.kojima@linaro.org>
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

On Fri, Sep 22, 2023 at 04:11:18PM +0900, Masahisa Kojima wrote:
> This adds the description about HTTP Boot.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index a7a41f2fac..65eea89265 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -594,6 +594,36 @@ UEFI variables. Booting according to these variables is possible via::
>  As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
>  command 'efidebug' can be used to set the variables.
>
> +UEFI HTTP Boot
> +~~~~~~~~~~~~~~
> +
> +HTTP Boot provides the capability for system deployment and configuration
> +over the network. HTTP Boot can be activated by specifying::
> +
> +    CONFIG_CMD_DNS
> +    CONFIG_CMD_WGET
> +    CONFIG_BLKMAP
> +
> +Set up the load option specifying the target URI::
> +
> +    efidebug boot add -u 1 netinst http://foo/bar
> +
> +When this load option is selected as boot selection, resolve the
> +host ip address by dns, then download the file with wget.
> +If the downloaded file extension is .iso or .img file, efibootmgr tries to
> +mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> +If the downloaded file is PE-COFF image, load the downloaded file and
> +start it.
> +
> +There is a limitation that current implementation tries to resolve

Remove the 'There is a limitation that', use The current implementation ...

> +the IP address as a host name. If the uri is like "http://192.168.1.1/foobar",
> +the dns process tries to resolve the host "192.168.1.1" and it will
> +end up with "host not found".
> +
> +We need to preset the "httpserverip" environment variable to proceed the wget::
> +
> +    setenv httpserverip 192.168.1.1
> +
>  Executing the built in hello world application
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.34.1
>

Other than the nit above
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


