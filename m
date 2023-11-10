Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC68C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 06:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F65876B2;
	Fri, 10 Nov 2023 07:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OLQOsCCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531D687703; Fri, 10 Nov 2023 07:58:11 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F20D8721A
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 07:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507cee17b00so2169726e87.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 22:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699599487; x=1700204287; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BEUNk77dnpppN7L2Jn8X8Q2BZHnWbKvaIh72b12VnwQ=;
 b=OLQOsCCsdkLZX4MsTRV23EOHZowzPe0DT9QPylzwOTnVnFCX1lrM4Omvp33SYbQm4R
 NJJR/a+7KMAr7crrAgyxz1UmnRiETqn7XmI7C6XAUNNF3UF7wHI2UspZ0DNXncCnKkq7
 S8SEFaepWnrY7PxxTLu1OHlC3tRN9/wauUlK0yiyHctW1FaHt3DqkdpS5C4pat23TruK
 NaQ0rHFa1YXczuX8NTjx7+RBLxD93sX9RlsxQ8jgN2Qd+VfiVsCDK0RHjKrZU0UEGuDt
 9vTSfz4G8SG92dNGA1GyoreqAySy9SSy3aKUBcjnxNYQxEV9ifNYXXlYOufgt3yWB3AS
 XHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699599487; x=1700204287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BEUNk77dnpppN7L2Jn8X8Q2BZHnWbKvaIh72b12VnwQ=;
 b=duBrNCIfL/x8BCvSnC4iN9qLwNqcRlUVa8pcDexMtClulyty1x5ui1g73aAwzt5E8K
 UxL+vlLa0XL7g4OwGZYatmMEXA9d511OUKhNnv4lOoS8I0zJnsLiYCJqWJu5OhdvbIFS
 2aflhVD0WTPbeiWj48uGcOntvKxRruSlJCqxu5cCniZRAuAZESYUl5ZN4ZjkVJuWiKqT
 X7N7xSgkb3LX7B700xm3U2mETCTY0ZNO6475/9OUwwDdBOP1LqWz1lgXI9l0H0NYQzmA
 nXNGv+MukDmqw9ekwpWw96cw3lCgpwDfd1EoLQ4T5OmVxBE2+I6UFZ9F2Dj3yqnRWfjB
 Efeg==
X-Gm-Message-State: AOJu0YybkYDQFgJhvUqMb2wGHbCXHJmyn6C3c/Can82AGgR9lHYQTI0a
 93re4P7eyJ1tEnbQg8wh+h4u3nmYPQDKxGHLhjeIng==
X-Google-Smtp-Source: AGHT+IG/VFTykaFH1X7psWoRG4882g7vJ5Jq3BeJ/PfbSkdDlRX72AgwjXzDCvvHnGBtbNruGxhbaO7ruahOgwawkuE=
X-Received: by 2002:a05:6512:374c:b0:507:ad92:18d1 with SMTP id
 a12-20020a056512374c00b00507ad9218d1mr2756911lfs.68.1699599487575; Thu, 09
 Nov 2023 22:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
 <20231110042542.3797301-10-masahisa.kojima@linaro.org>
In-Reply-To: <20231110042542.3797301-10-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Nov 2023 08:57:31 +0200
Message-ID: <CAC_iWjKOfqFMb+-FXqTNjAzf2nggqmhyiDbWhDjHx9FQbp=PjQ@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] doc: uefi: add HTTP Boot support
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

On Fri, 10 Nov 2023 at 06:27, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This adds the description about HTTP Boot.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index fb16ac743a..ca9a573669 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -642,6 +642,36 @@ UEFI variables. Booting according to these variables is possible via::
>  As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
>  command 'efidebug' can be used to set the variables.
>
> +UEFI HTTP Boot
> +~~~~~~~~~~~~~~
> +
> +HTTP Boot provides the capability for system deployment and configuration
> +over the network. HTTP Boot can be activated by specifying::
> +

Since we changed depends on to select this needs to change to
CONFIG_EFI_HTTP_BOOT which in turn will enable ...
Again, I can fix that on merge

Thanks
/Ilias
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
> +The current implementation tries to resolve the IP address as a host name.
> +If the uri is like "http://192.168.1.1/foobar",
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
