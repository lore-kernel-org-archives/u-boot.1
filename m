Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1638C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37EF4887C0;
	Wed, 22 May 2024 08:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SMY5cv6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6FB87F4B; Wed, 22 May 2024 08:17:16 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71E1087F4B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-354e0d4db6cso69112f8f.0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716358634; x=1716963434; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LT263b4wbEa1/5PGPf7NwDCWrlO18vhvtgW325P/eU4=;
 b=SMY5cv6pJDzIP7xxUIYVzCykb7b2XbWmMN4+TOqlTHkwWAw5DEZbtqbZ5nnizI+gBZ
 IpoB59cggpjPgtdoQZ8wvU8QUeBRnh9VtLjzKvje5dsZGrsIzoZT5we2D5r4f/na1UE/
 dSkPfHDMCkq4p8mfmpPVsZsaNSEXuEXzrPq2nsFIiPsBWNSd81dNV8Gqwtfv67Gog2uy
 IS+62mSjw8CIbdgYKMBveH0atBYayVfqpa5QAjaqeec06S9JUM8e92dTx8qBIcc1QJCT
 YEX4+7kLL6pAb+9lntF6+DhHs+heoSJJOw9tVJQaLtqrFzAx20Yo2Wb/ggVDjRRA7VWW
 UNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716358634; x=1716963434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LT263b4wbEa1/5PGPf7NwDCWrlO18vhvtgW325P/eU4=;
 b=dPZb/hivnN68FkLAg+FaZHVjY9ANfDqC8IbrsromJrV914CRFtsdB7XmigblfDbeDK
 nXIhjKr8mXHnzoIRTMEdvCuHvGwU3tjIMTRBAlOcD+nl914sb9Dqq1AJ1PE3QgJbZxaF
 dw3pBdXhuMKPgdNndXMgWcisnA1FrsdWAeYM6iNw8793neMn1E05FFizgPiRiDd1Mf59
 blsLzUIrdJXUo+OgG1XDvDh1BL6tOOIm3SxDiuVEVvkEilmmgnhAtcq5io2wEfPF9Ffa
 YmH+8TdpdttgI3C8yHos91Ez1/2xfJ/+08E8YuZYocXkzgBA6sfP6xkahAVNzDki4dWM
 CfuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiYZnyx5qr/AyTmWX5MmPrYCH+uO6lAbUIFpY8puktwLsSh24eBnzGmv9mHf+wcgOSdk1Ac9DI60fFZjwvTK1JHMp0ig==
X-Gm-Message-State: AOJu0YzjwnnPLwMrtxRZuwo2nrHeTrRxC6CbQVuoOSKp4QLKmTi8KLRS
 rSB+xBqBif8sJDaAezmnz0hZoBFgv/DqgBvC8VxQaYkUNRNsVcwLBetXhJ+O9qw=
X-Google-Smtp-Source: AGHT+IGCUvoKhTzTuzSeYQ2TJ3IjM8gvw0OCNaXsO//xkd7dWAwZxQZ5Wu2FWI0p5lgHO6iX+DD3Eg==
X-Received: by 2002:a5d:5e04:0:b0:354:dd6a:a5cd with SMTP id
 ffacd0b85a97d-354dd6aa67cmr521716f8f.33.1716358633963; 
 Tue, 21 May 2024 23:17:13 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354cc15c56dsm5377726f8f.80.2024.05.21.23.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 23:17:13 -0700 (PDT)
Date: Wed, 22 May 2024 09:17:11 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC 09/14] efi_loader: do not install dtb if bootmgr fails
Message-ID: <Zk2N5-lqV1y7lZVv@hera>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-10-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426141321.232236-10-heinrich.schuchardt@canonical.com>
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

On Fri, Apr 26, 2024 at 04:13:16PM +0200, Heinrich Schuchardt wrote:
> If the UEFI boot manager fails there is no point in installing the
> device-tree as a configuration table.
>
> Unload image if device-tree cannot be installed.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_bootmgr.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c64cbe82402..d924810a94b 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1209,15 +1209,21 @@ efi_status_t efi_bootmgr_run(void *fdt)
>  		return CMD_RET_FAILURE;
>  	}
>
> -	ret = efi_install_fdt(fdt);
> -	if (ret != EFI_SUCCESS)
> -		return ret;
> -
>  	ret = efi_bootmgr_load(&handle, &load_options);
>  	if (ret != EFI_SUCCESS) {
>  		log_notice("EFI boot manager: Cannot load any image\n");
>  		return ret;
>  	}
>
> +	ret = efi_install_fdt(fdt);
> +	if (ret != EFI_SUCCESS) {
> +		if (EFI_CALL(efi_unload_image(*handle)) == EFI_SUCCESS)
> +			free(load_options);
> +		else
> +			log_err("Unloading image failed\n");
> +
> +		return ret;
> +	}
> +
>  	return do_bootefi_exec(handle, load_options);
>  }
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

