Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E3DCE8D53
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 07:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F2F87FA7;
	Thu, 19 Sep 2024 09:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WinO/beH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4398187FA7; Thu, 19 Sep 2024 09:02:40 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022D387F7D
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d8b679d7f2so459004a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726729356; x=1727334156; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J7naa0ppV6sif++dqGAlS0E4xKqw16kqETNFPxerVMQ=;
 b=WinO/beHVXa1c2UaANmEQjdk+MFXUM1ncHm9qlSTBimsXCGLc3ZTWuK/pjp8+VzrvU
 yb1HCd4R+TMo9VksjPQo9Wxt9MYK6gVerpoKaIFf0aaBZOUSx2IsZjvzlBCNbjICBCrq
 x66W5txNarcw6gcrY2Obqxopw1mIuWcgoxBQI1HKoml8+9meCe4wOe9PuE8mTxcM9+xM
 5U8043vEYcqWjQhYygnZSilM4VZp4FgHG97Y5mviXnqKk253SmgjkAbxg75b8NjfjBhI
 BZR1CPC3PqKX2Ob4rnvVF80zZc0/TstkRgQhR160DGgFBB+Z3QNxxKvr4JZJxL29NsGF
 Ylug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726729356; x=1727334156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J7naa0ppV6sif++dqGAlS0E4xKqw16kqETNFPxerVMQ=;
 b=piTMxYtDp4C36gsR41WfAOhoEVlBUCvk/XuxVcahEOXRkLs5A8keWcPpHeLBtJSv7n
 /grPI1FJ9di2rfEL15X2cmz85kk24iYbGIfxpZx96uYylFhhtKwhn+kz78ISK2qgk6zI
 hRP0n4pEmQ2JSYLaWFnCmzaAfOV667Dd60bCDHs3RTJGC+4wWMzRiKmuq9NF01M/r44i
 2AOnLs7kEb+JVBbrzFLt8IMsJAvP9xQKDnGrCFYWC9riMJJZthAAANXFrgKBAvKpTB6r
 KxEqrT0CDIWkGeaC0qXPhH3Y13N2TOp10soMqrtWaoI/xVFGjSJCJ+SbH7B44AT5inDh
 fWIw==
X-Gm-Message-State: AOJu0YzxipgVuX/MEz/9l8K4yI4WJLAJ8naG7I/u8TefJNnfBq5uhiTN
 NHy9fcfdVKCxZQEkg7J97NV56upXCS/Q5CR7e8yO61jL3tQoltxh2onLtH9NFXzxtr3xyQauZVa
 it80k+t1UkpC3lvBMBZym6JyBeYhcL5Tq3cON/Q==
X-Google-Smtp-Source: AGHT+IFM/pB6bcoDuuzi8x45UKIrsVXn48OlierQfcvxW84mzydInCBe/5543wKMJC7Mpc60burcrJNuXHnOPFiAna0=
X-Received: by 2002:a17:90a:f2c9:b0:2da:6a4d:53a6 with SMTP id
 98e67ed59e1d1-2db9ffb3672mr31535524a91.19.1726729356562; Thu, 19 Sep 2024
 00:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240918215134.21110-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918215134.21110-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 10:01:59 +0300
Message-ID: <CAC_iWjKOHu+mjMz_RENzksFsermvJpSfa=HdYccSRDjGanPFTg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct efi_set_variable_int() description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Thu, 19 Sept 2024 at 00:51, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The name used in the function description must match the function.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_variable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 223bb9a4a5b..4065cf45eca 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -38,7 +38,7 @@ efi_status_t efi_get_variable_int(const u16 *variable_name,
>                                   void *data, u64 *timep);
>
>  /**
> - * efi_set_variable() - set value of a UEFI variable
> + * efi_set_variable_int() - set value of a UEFI variable
>   *
>   * @variable_name:     name of the variable
>   * @vendor:            vendor GUID
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
