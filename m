Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1FFE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 16:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7596A80137;
	Thu, 12 Dec 2024 17:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vGoeo1y8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63218801BD; Thu, 12 Dec 2024 17:31:31 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F4E80079
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 17:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361c705434so6110055e9.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 08:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734021089; x=1734625889; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6p1lJW2qwBto+PnNa143ZlL6/sugM4LCIXXSOUezaoA=;
 b=vGoeo1y8Q1KJAMDPGinbqgHL28dS7y63vqFbKHAQO/zaiNJBqOdLA/BncCRycU5ntR
 tGDz65GR1sUEDQxATLuUUcSKsfOQrG/V1JyXOSjlMrSZxl8pX2h2QKoW4QY2E2TWAVpz
 idJmXH9+PmaXgGuS1KGq9XGUG3Rf9DLxbcXb/90g7Nm/yqP/TP0uM2ucUOCWe8CZUbkU
 vpVTA5Xf9YwHLga/BbZ6/VnmybcfaJtKG7Krit7Dp05x/9plIFo2xv8K4PK1PHiNE4+v
 yxLReyybVG3MPlwAIoXyAzELbeSEjmozFCCIx5SzELOSOSM5Zp+QXAqhC1kmsavA/edL
 aPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734021089; x=1734625889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6p1lJW2qwBto+PnNa143ZlL6/sugM4LCIXXSOUezaoA=;
 b=lUV63/eIhPwMfkTBqEfn1btKyIknzzcQqAG2r9Etjq0+cNZJaN9+3lAj8PPZZ+GAqp
 YplQBIc0qUthxTJ6W36mGrSIPPGKGVEEpE9xJTdZ6hSKtnMp+fEz/YxcF6JVVrKJBC+B
 AjVakAFhT+vMdmBDkyM9i2gskKicmsomAzpKt+ELQuQzfTclxDDfCyb+D06prjL5XhB9
 Df6oUiob+NSkeUTY2yb/pCe7d99eupfACUucKtzRI4O2hZZwGM5DRDKdKUtI6h8xh+NT
 7tKWTU2DH017jR4wRii6eTBIkwJZ/5td1nL2wMmynD9WjqxmyZ7hPkxNCgOOfr6ldmpm
 BvHw==
X-Gm-Message-State: AOJu0Yxm9d6kQZdTXnFVskrkN+G9D0WqmUqNbm0JTxaFOjkuPlo4+onH
 SEg4HVNO+RMBWhlSskAfZ7bwKTYsb4YKhyoa/y3zj1qn54pNAq+9YXGmBhS1vtQ=
X-Gm-Gg: ASbGnctEDO1qb4RDFxjloXdoC3HLXMCZlpd0+fDIP/mu1fOrnAfGDTfepLP8nX86YiX
 9H6i+C+PbNoBNkivdNu+wjQ5RuG/GZJsrIGzj4vrFT8f6qiKNenfkOukc6YuTPbA9Jd9AmcQOgR
 AuI5xaERxyH5Z1/jwhZAqJU+dWqdj8mRtKKZzee8CJx17WlUQPspN6JsUmncDEn5HEOglkGnczl
 ZAiZLd1YeJ02FAdQg5LB1utyxt48RgH6SDvsuIoYy376KGz8dxwscUqIUu5hppwIXTv8balE0ir
 TWtSedgWDhw=
X-Google-Smtp-Source: AGHT+IF/RyIs/24l06pYuW0oYrQhHjnta4hZ8K4XM/vGYStD9i8USTAK8Umy+NsK8u4N1ZvzBeYo5Q==
X-Received: by 2002:a05:600c:4450:b0:436:1aa6:b8ee with SMTP id
 5b1f17b1804b1-4361c346a7emr67236745e9.2.1734021087073; 
 Thu, 12 Dec 2024 08:31:27 -0800 (PST)
Received: from hera (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362555334bsm21512365e9.1.2024.12.12.08.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:31:26 -0800 (PST)
Date: Thu, 12 Dec 2024 18:31:24 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] bloblist: Disable CONFIG_SPL_BLOBLIST_PRIOR_STAGE on
 some platforms
Message-ID: <Z1sP3FkqZ8Veaner@hera>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <20241212151142.1562825-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212151142.1562825-2-trini@konsulko.com>
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

On Thu, Dec 12, 2024 at 09:11:42AM -0600, Tom Rini wrote:
> A few platforms, notably chromebooks bob, coral and kevin, create the
> bloblist that will be used in SPL and are not provided one by a prior
> stage. They also define CONFIG_BLOBLIST_ADDR to be in DRAM and so we
> cannot scan the area until after DRAM init happens in SPL.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/chromebook_bob_defconfig   | 1 +
>  configs/chromebook_coral_defconfig | 1 +
>  configs/chromebook_kevin_defconfig | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index decac2e19352..e44775506682 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -38,6 +38,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_BLOBLIST=y
>  CONFIG_BLOBLIST_ADDR=0x100000
>  CONFIG_BLOBLIST_SIZE=0x1000
> +# CONFIG_SPL_BLOBLIST_PRIOR_STAGE is not set
>  CONFIG_SPL_MAX_SIZE=0x1e000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  CONFIG_HANDOFF=y
> diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
> index 0fb730497386..a5ef4fd2675e 100644
> --- a/configs/chromebook_coral_defconfig
> +++ b/configs/chromebook_coral_defconfig
> @@ -46,6 +46,7 @@ CONFIG_BLOBLIST=y
>  # CONFIG_TPL_BLOBLIST is not set
>  CONFIG_BLOBLIST_ADDR=0x100000
>  CONFIG_BLOBLIST_SIZE=0x30000
> +# CONFIG_SPL_BLOBLIST_PRIOR_STAGE is not set
>  CONFIG_SPL_NO_BSS_LIMIT=y
>  CONFIG_HANDOFF=y
>  CONFIG_SPL_SEPARATE_BSS=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 5bbea6c42a8b..27fcfe866ee1 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -39,6 +39,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_BLOBLIST=y
>  CONFIG_BLOBLIST_ADDR=0x100000
>  CONFIG_BLOBLIST_SIZE=0x1000
> +# CONFIG_SPL_BLOBLIST_PRIOR_STAGE is not set
>  CONFIG_SPL_MAX_SIZE=0x1e000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  CONFIG_HANDOFF=y
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

