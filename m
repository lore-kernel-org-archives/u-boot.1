Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60D8C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 16:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C6287561;
	Tue, 23 Jan 2024 17:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MpsxZN1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B311887CA1; Tue, 23 Jan 2024 17:23:21 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEBF80785
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 17:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a28ab7ae504so372888866b.3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706026999; x=1706631799; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+fcueGHlUwrOivPQmZpPyRfalGKDkUF5tieFtPbpnuo=;
 b=MpsxZN1aCas8ifWYO3lyFJO1ugb1AZxg+cHsKd2wcXcam4OGOlXM7Jp2vYV5OqlJKF
 s6j3p+pdh7IShXpgKgJl3MB0JH8QvF0fncBxpDDsVCAi0tF8j2irbip7SBhppDUwq1kb
 uxEbc4aJhZwHRIxKmsVDStEZrAJQM7Yo/3OLR9NZ8mVB6mf0K+qN+vI6i+xpusQZwfNG
 X6MAkGodGGXf3Rm9Z6pK2+TnV42xVvRf2FNv3sot90RLEnWj1cVufjR7WBxSdvKWbkga
 RYUWkppraCvE6DYgRdbeKfOwp1sRAYj+q3UucGg5FLuUDz60ERLdVGS2UZe26Nfu9DGJ
 4/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706026999; x=1706631799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fcueGHlUwrOivPQmZpPyRfalGKDkUF5tieFtPbpnuo=;
 b=vp7d1YLP5doXz7QMHas1TfS32/R+cIKRoY3gTZg9lY/Pvb98Oq3RQRfjNaaHrzu5e5
 /ew295Sqg9+aA2v7IqWWwIKhzME+1U+WqyJWCfMLupmx3jeTwQb0iMQiQQs1mFN6tpA+
 FPX6a6uOebUi1Q71SrgNXmgEDZLcajGj7q6kfWvyA95Xj1u+BEsC53pPpQRRZN9oXjGb
 RNneZWmzGIA3lZsUqPZdWeF/XEK8AHGj4DtOBKuY++J+yeEpzfP8wjZ/fOXD0gjH4ZEt
 Yz3HcNZWAPaP3b6CSrm8V4miri2fGLXMA4Hid6t5YPYTAT7hALnfgwa6CyD3tyinAM+B
 MB7w==
X-Gm-Message-State: AOJu0Yy3dj+eH9lTCooBEP7+7BAnnM/D99XGBrivr2GxBu01bNz0T65H
 wXFWUfPL9x0/zETYtLsKtYkk7i6l/T9MrFxiVNbVpuGkglY/dH0BYy9p0/ar+jr0Zmm46wKHIVT
 L
X-Google-Smtp-Source: AGHT+IGmGPOWW347ybHAn55ZBVoew/jkJuzTcqmnBc0zuVI/x7j61v0mHwiiawXLSEhYPk2CBUxbsg==
X-Received: by 2002:a17:906:a1d6:b0:a26:84d8:9411 with SMTP id
 bx22-20020a170906a1d600b00a2684d89411mr60780ejb.128.1706026999146; 
 Tue, 23 Jan 2024 08:23:19 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 vq9-20020a170907a4c900b00a2ca97242d5sm13626242ejc.120.2024.01.23.08.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 08:23:18 -0800 (PST)
Date: Tue, 23 Jan 2024 18:23:16 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, y@hera
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: Re: [PATCH 2/4] doc: Document capsule generation through a config file
Message-ID: <Za_n9JVSFxnj7Mo_@hera>
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-3-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121070028.2614095-3-sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Tue, Nov 21, 2023 at 12:30:26PM +0530, Sughosh Ganu wrote:
> The UEFI capsule can now be generate by specifying the capsule
> parameters through a config file. Additionally, the capsules can be
> generated as part of u-boot build, through binman. Highlight these
> changes in the documentation.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 70 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index fb16ac743a..b9a9ed5491 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -318,6 +318,76 @@ Run the following command
>        --guid <image GUID> \
>        <capsule_file_name>
>
> +Alternatively, the capsules can be generated through a config
> +file. When generating the capsules through a config file, the Kconfig
> +symbol CONFIG_EFI_CAPSULE_CFG_FILE is to be used for specifying the
> +path to the config file.

This sounds a bit weird. The tool is compiled and used by distros. How are
they supposed to use the config file?

Briefly looking at the patches, we use those config options on testing.
Can't we add a flag in the tool itself that can be used for normal use
cases and limit those Kconfig flags in our testing only?  Or alternatively
the paths for the config files can be hardcoded for sandbox and we get rid
of the config options entirely?

Thanks
/Ilias
> +
> +The config file describes the parameters that are used for generating
> +one or more capsules. The parameters for a given capsule file are
> +specified within curly braces, in the form of "key:value" pairs. All
> +the parameters that are currently supported by the mkeficapsule tool
> +can be specified through the config file.
> +
> +The following are some example payload parameters specified through
> +the config file.
> +
> +.. code-block:: none
> +
> +	{
> +	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
> +	    hardware-instance: 0
> +	    monotonic-count: 1
> +	    payload: u-boot.bin
> +	    image-index: 1
> +	    fw-version: 2
> +	    private-key: /path/to/priv/key
> +	    pub-key-cert: /path/to/pub/key
> +	    capsule: u-boot.capsule
> +	}
> +	{
> +	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> +	    hardware-instance: 0
> +	    payload: u-boot.itb
> +	    image-index: 2
> +	    fw-version: 7
> +	    oemflags: 0x8000
> +	    capsule: fit.capsule
> +	}
> +	{
> +	    capsule-type: accept
> +	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> +	    capsule: accept.capsule
> +	}
> +	{
> +	    capsule-type: revert
> +	    capsule: revert.capsule
> +	}
> +
> +The following are the keys that specify the capsule parameters
> +
> +..code-block:: none
> +
> +    image-guid: Image GUID
> +    image-index: Image index value
> +    fw-version: Image version
> +    private-key: Path to the private key file used for capsule signing
> +    pub-key-cert: Path to the public key crt file used for capsule signing
> +    payload: Path to the capsule payload file
> +    capsule: Path to the output capsule file that is generated
> +    hardware-instance: Hardware Instance value
> +    monotonic-count: Monotonic count value
> +    capsule-type: Specifies capsule type. normal(default), accept or revert
> +    oemflags: 16bit Oemflags value to be used(populated in capsule header)
> +
> +When generating capsules through a config file, the command would look
> +like
> +
> +.. code-block:: console
> +
> +    $ mkeficapsule --cfg-file </path/to/the/config/file>
> +
> +
>  Capsule with firmware version
>  *****************************
>
> --
> 2.34.1
>
