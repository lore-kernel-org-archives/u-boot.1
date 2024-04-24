Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBD8C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 15:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D958881D;
	Wed, 24 Apr 2024 17:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lg9Ug4Du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FD8788831; Wed, 24 Apr 2024 17:05:57 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B37D887A8
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 17:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a589eca7f39so70648066b.3
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713971153; x=1714575953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2vGca0rhQEXy49NmrOgx+osKftLyREgctKnqqTvwB8w=;
 b=lg9Ug4Du0UnBXLJeq8+vY+08Gr77bM9rt6PSYZ0y0CbV3C4crhUeP6eEBnIN3sYYFc
 h+TvnnsGBgLd5YoD84Qlw5HnNPEcPU+0hY62cm2m7CkPpZzGRKy3SK1R5zRgkGE1+O6l
 vaG22kR4oKL4W7SmtpLe/3TERfHr+E5X6+2A1L1B5xgJHyyVsle0KO0CRQYaa6CLrbm2
 B+k4CqWJn+QuM770PKQWN/vj1HgUfWxPZm6Ko+SrtlCwVQ376dHaDYSBPo4XbdEwmEfA
 YRjlb7ZnaWqk/SffyA7CodqiLX/7+0H1OGC7nj9wwl1uoIlUyX/BCaD+/+Ewbv58Tlfx
 C5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713971153; x=1714575953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2vGca0rhQEXy49NmrOgx+osKftLyREgctKnqqTvwB8w=;
 b=I3Ywa129e1Y5xkLfjnwG1kIEXMTptf5NZlhchpEEej5sKpXBzX4di7HEE5J3HrQ+a7
 uH800PIG6UZnvKeFC0DaXxB4jIkXQKGsgzrcr2j7WwWVGaE4u00n4rrwikv91N1MlKgl
 SNSb9c5tNeCkofpHou1OWtxvm0nxpatrh5/Dq4SJNdxP81j+aT7r2a9sI5IZLSNf4aMa
 4alE2vDKuYPaeDyl7iau+oNasFGQdeBLVRo+L2kXyKCMbZfRl1EPuzWH0Ey7rdNHfcEM
 Wx4v2oigidBhukwZjff6NpLD68vQ0qEZykuBrMHmYhQwga+zyxHoc5T9bei4EotQQucN
 +gng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFMGYtDbqFwLVE15ZJ1j2iQw8zWjwve/q3R41UtrzlkIZ3mFia4CCixpbf30fKDypM8/8lxebyiR0Kv2xwmyjiceCqnQ==
X-Gm-Message-State: AOJu0YxyI9GFnMLavo7RGzoxMsHfnfBn3CsKSfGiiIIFWTDfWHAu/p47
 pAhf09Oa498UxjUQVjulsnw9386e5EXOqasfiFozVMmtd95rGSpBAdlsb+F3gRTeqgFolmil1CE
 9lzfZxX8F+kmMIdv8XczojMlAK/BmGBdMjRCC2g==
X-Google-Smtp-Source: AGHT+IFAJEBhNit/2ye3tA5lCgxfp8lozzdPTnX+re69HQHHcJ8w1hmLYsUv/22G3YeR4UGYwQQOfFPDfVm4hSo+xmM=
X-Received: by 2002:a17:906:6a25:b0:a55:8c0b:bc00 with SMTP id
 qw37-20020a1709066a2500b00a558c0bbc00mr2065534ejc.62.1713971152843; Wed, 24
 Apr 2024 08:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240419205701.163821-1-j-humphreys@ti.com>
 <20240419205701.163821-2-j-humphreys@ti.com>
In-Reply-To: <20240419205701.163821-2-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Apr 2024 18:05:16 +0300
Message-ID: <CAC_iWj+THdzrCf856WZyj_kqtavBDrjH4txo58DFw04BCgUYGQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] doc: uefi: capsules: Start Capsule Update
 porting section
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
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

Thanks, Jonathan

We also plan on adding a Kconfig option that will autogenerate GUIDs
for such cases, but this is useful

On Fri, 19 Apr 2024 at 23:57, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
> Created a capsule update porting section in the documentation that outlines the
> steps a board developer must do when porting from an existing reference board
> implementation.
>
> In particular, added a big warning that new capsule GUID's need to be defined.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  doc/develop/uefi/uefi.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 0389b269c01..36ac75278fa 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -631,6 +631,18 @@ where version.dtso looks like::
>  The properties of image-type-id and image-index must match the value
>  defined in the efi_fw_image array as image_type_id and image_index.
>
> +Porting Capsule Updates to new boards
> +*************************************
> +
> +It is important, when using a reference board as a starting point for a custom
> +board, that certain steps are taken to properly support Capsule Updates.
> +
> +Capsule GUIDs need to be unique for each firmware and board. >That is, if two
> +firmwares are built from the same source but result in different binaries
> +because they are built for different boards, they should have different GUIDs.
> +Therefore it is important when creating support for a new board, new GUIDs are
> +defined in the board's header file.  *DO NOT* reuse capsule GUIDs.
> +
>  Executing the boot manager
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
