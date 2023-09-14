Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB132EEAA41
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 13:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C84387049;
	Thu, 14 Sep 2023 15:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jPKwhz0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16B48703C; Thu, 14 Sep 2023 15:57:30 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E4E867C7
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 15:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-403004a96a4so10756415e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694699848; x=1695304648; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TIYJ1bdsZ2p4fnZKKdXgY7dHyPObSP1mbo+dpct9kPE=;
 b=jPKwhz0XDIUWWVXUxSuFp7wo4xD2sQgihMVNJ78+gESvrVLC6UNf4rIUdm4eQjLRsa
 a1nbHo03eGyhOOx6u+2z0sBtJ8PAH1Xq5mzlNgE2P2V0aZ7u5y7tpw3/RdC/lNN1QnUk
 CD4bfYEcrkChdmg1U2gPc2v/n2cAv3Mf7E8H9e6t0YzUmRYY7rYqX2Ou4kaFtxC5c7mk
 tYk7JWQjq0iVx5tGGngFI+28A4LMQxmI1qBFy2dL+5nkSFBqFqZ/s3SpK6r9RaHbLT3F
 TrDD3hHa2uluA7HRQ7PIZ821uFg+K2XQmaRyIsYgGGAuIrv9seDLhMjtpG4neM7XMyC4
 D43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694699848; x=1695304648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIYJ1bdsZ2p4fnZKKdXgY7dHyPObSP1mbo+dpct9kPE=;
 b=YviGguWSXgYu/2TyQhsuw1Wcxrkp7nkUgpBTtpd+aJd11iSb017hEZSwrN8Qcizw9j
 GLPJGbH8na6mc4N5ZhHlF3CDfSyc0rHq2JzuBpbpAquc1O8qBsVYQgO3yllXJi2HrdUS
 kP8HMzc2uKAEFmZ8pn+zm8/5wGr0cyZNb6bLDfo/1zxYWAwDWF4+g6Bk9/dqYNFUF+az
 oB86sOKZdxMUtjIPyPraSY1n2AGnnKwze//B6rNbapbhxcQMxM1L7a43rSwyREJToGOA
 A8a6MFkrbTh8rVVneJaMkpWPCdU+Tpgv2SGaQHpGtFKPEIRK6MtpsoxhAnmmOAsCrCWK
 Tqvg==
X-Gm-Message-State: AOJu0YymF2311sKwqlABFSqsSAGJMjN+c2Xt9UHNv2VEjhz9/f2Q5khi
 Voa7NiHWzlG34pL9jnbVvRulMQ==
X-Google-Smtp-Source: AGHT+IEUB6jgxd4bAoMd0Iulfw4Ddw2guHZRoDsi8cXwzwHxKrVg+rE7WQY+Rdi+Ga+LP679qbj2pQ==
X-Received: by 2002:a05:600c:747:b0:404:6ed7:e743 with SMTP id
 j7-20020a05600c074700b004046ed7e743mr1371036wmn.39.1694699848190; 
 Thu, 14 Sep 2023 06:57:28 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 16-20020a05600c029000b003fee8793911sm2038242wmk.44.2023.09.14.06.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 06:57:27 -0700 (PDT)
Date: Thu, 14 Sep 2023 16:57:25 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 6/6] doc: uefi: add HTTP Boot support
Message-ID: <ZQMRRQ4zOnKUU4WK@hera>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-7-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901102542.609239-7-masahisa.kojima@linaro.org>
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

On Fri, Sep 01, 2023 at 07:25:42PM +0900, Masahisa Kojima wrote:
> This adds the description about HTTP Boot.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index a7a41f2fac..fd87bb1edb 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -594,6 +594,27 @@ UEFI variables. Booting according to these variables is possible via::
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
> +host ip address by dhs, then download the file with wget.

 dhs -> dns
 what happens if it's an IP address?

> +If the downloaded file extension is .iso or .img file, efibootmgr tries to
> +mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> +If the downloaded file extension is .efi and file is PE-COFF image,
> +load the downloaded file and start it.
> +
>  Executing the built in hello world application
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.34.1
>

Thanks
/Ilias
