Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA571C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1102088379;
	Mon, 22 Apr 2024 11:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tkBuLIYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D1D883E5; Mon, 22 Apr 2024 11:55:14 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D128833C
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34b029296f5so917124f8f.2
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713779711; x=1714384511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XFpTGodeS7vCoh9+5Eewshpku+2yy1bE7yUKMPONsZM=;
 b=tkBuLIYNU8mvpGH1OW7H7xxYhwhi9eDo6oWgdTGLnTmzLkJS8+rvelvWAwypdDpDPR
 IIEMGbosMcBrNCgS7sEv8GsuTcsmJlOEsZ7aNvcB3kbMlZmaIt6CQaFsA5xvTXQZGsaX
 CKWFhQuxHzQJVrZMwtimjeh+7YKX/YIbhh4iDGwZt99L2utOdP0X2VCbPPIpLmCL6EiZ
 m+mxrtfMDTdlyFnhd+ZlPuE+p2+ojDpOWSo5WQn4npN7qcBjb9IrQhM0oR5YdqucJ5HK
 8KwHzNNP1GgPueiAMwB2C5IYWIvRn23ENTLgjUbInecO3Zhh7IquiQdMiXlXfy24sTOu
 aT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713779711; x=1714384511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XFpTGodeS7vCoh9+5Eewshpku+2yy1bE7yUKMPONsZM=;
 b=Yl9nPk2FyT807M3qXIp8zh5Ye85kLRaEy97HOxvCh2Bjljm8Qy1HkJ+XPOi6EX837q
 Z0ZwQb1T83RgLiSMnFsuScpMRQcXuS+kvy4gf6MzPbYBJvrfm0AenCZzgOXhwOmRfXKh
 h2AtatjQrE46UhL2OuOSKztKIZ+kSZsBa1J+/esyQ6a1ABk4PsSIVyTWq84DjN8CVPYB
 vzhw8hCrvx/AjikgrGwaQjYEElUXx1HcY7N8F146w72lo4roZ0IHDU2Vez5D2kf9sZl+
 6G7W7cCoJTrlQ876YXYk5NIp/JYDm7whLAoAVafcCRfWgU8jr5DBqt9H1eq9Yk0x0Z7A
 sUng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoN4LzTwS29s3zqwbJ5DtuCVzYLYeYL/epcSW84yR7J4xxF/KTNvYggAMmh18SYEPcb+AlsXltIPZXLn2wgL2Ybr12mg==
X-Gm-Message-State: AOJu0YwiTYcq860ncAijI0xiFGN7c4QNionGx4reJyZh9DOUbJOJTCbs
 O8gYE4ezLB5sk21CpSiib67Ldlfikp71mDLg/Fgqa9jCcqRHOsOlNWr2ewisCIsT9cNtga8C8Y4
 BAooWcaj8hCmbmxbDFe32a/H5nc6NJ4XljHS9Uw==
X-Google-Smtp-Source: AGHT+IFaWyfsACR4K8WX1bWRQZrZlyVWf3mD5TLC4NPXLXr/lJS+x5vtnIZRWnmTyymEJCY9M81VRhoQKlZEVhHqV94=
X-Received: by 2002:adf:db42:0:b0:34a:4227:e9e8 with SMTP id
 f2-20020adfdb42000000b0034a4227e9e8mr7525119wrj.47.1713779711516; Mon, 22 Apr
 2024 02:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240422091634.83909-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240422091634.83909-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Apr 2024 12:54:35 +0300
Message-ID: <CAC_iWjK4hZ_2DawqUbXH5A5qaBC7DbJKGYMPzJoS-N5N8fBDPA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: do not install dtb if bootmgr fails
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Mon, 22 Apr 2024 at 12:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If the UEFI boot manager fails, there is no point in installing the
> device-tree as a configuration table.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_bootmgr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c64cbe82402..2b0d3137338 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1209,15 +1209,15 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                 return CMD_RET_FAILURE;
>         }
>
> -       ret = efi_install_fdt(fdt);
> -       if (ret != EFI_SUCCESS)
> -               return ret;
> -
>         ret = efi_bootmgr_load(&handle, &load_options);
>         if (ret != EFI_SUCCESS) {
>                 log_notice("EFI boot manager: Cannot load any image\n");
>                 return ret;
>         }
>
> +       ret = efi_install_fdt(fdt);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
>         return do_bootefi_exec(handle, load_options);
>  }
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
