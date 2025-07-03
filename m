Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607CFC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 08:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04FA81FEE;
	Thu,  3 Jul 2025 10:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZzxJ6725";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD15B80194; Thu,  3 Jul 2025 10:38:47 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67B480194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 10:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4a97a67aa97so10058391cf.2
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751531924; x=1752136724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4zchUOVl07oV6m0LBhnMxKorL8V6xOxtrvklHnsQBDA=;
 b=ZzxJ6725q6teS4vYnyKwPPZcruy9RSkcKlnOgcTLy84Z4IUjAmVLFNvOKR0Imi2kAl
 ywICbmLTEUtLWqidTj8FGUXMiOIB0XYuR62NzHF+YsHw/dFLIF+5Ri8vn7Bp/q1SQrPl
 5XYn+ANiJpjmoS6VwRnGrd8BN5LUCJxgKnjbmvPZ/OF3eScbNQzZX6UcWbraTZkMB07u
 gCQdnfjaxaZqM+di2WX1uKD4ey9ckFJ8JJkFPGTAQHG6suiCcS/YSxZKZGCwjPHKjOHf
 EAVhshCBLMK4obLREe6XO5i2fNxalKiWavN9k2s/UFlsPUdHmQRy+NBD0qMYYMMbExWn
 DO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751531924; x=1752136724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zchUOVl07oV6m0LBhnMxKorL8V6xOxtrvklHnsQBDA=;
 b=Nwj+jZwM7tpewvptpvDHDWi+jTrxsljk9nkIUb6buYe0tONv3GOYWLe3+rSKFzlDl1
 8J3wOJz+3ynTfmqLcU+QpalcKv87+DP9C8fEJqqHC2BkYVi9NygD+t0lIopH0D9bu0ch
 p6pppDSCHM5ztUtbNckaOYK4c3ec/P2z/dpDWSl7My4kXSHBH3lo4DyfvfyE3dfijlcG
 Utpa8mvRb/IalEpjble3OjsvbF45Mv9TEL4kXJ6QkkDsDsDOUwUJtavHIlFbRYqecY2v
 79mVEPM/0mpspQmXLjE/HRX6AbSfzfvDbWI8E8Z4X21yZY7vLYVdKzPzr9Zd4vuxIIzp
 qPAA==
X-Gm-Message-State: AOJu0YypP67d8I69xWJArps2scaWiGQvax2hWaPmVPM7SxyQk5efqab7
 Iu1B99p80rZJCcWK9W2X2fVumCOgR6P+36ktmOUb1scS4Y2m93Il9EvWqdM8GkmK/qWD0jEwo0V
 EVjpqyVpFy6RQ54JwEmZBvqtxciwkkJmlyAbO2b9MxWToslqUIHui
X-Gm-Gg: ASbGncvzD7xEtqkTmz3bweMzJbOFGuDX1FC/kWEnXHEMkbNIZROT5+cwfJFUmfiWofn
 KqfcSQWjVwW4xhWzzfJWDogycPTOyXv5LrMLWXU+OLmmX6gy10YqIlRFlR7m+m5yvzKizmDQyjH
 kR3HRErzo7xSEFI4H9Od/YyKU8+2aGkbf1zlxWkXOdS8+G
X-Google-Smtp-Source: AGHT+IHIRB5ytkKPRpSAjK+urT7ekZt2vAoM4NyH64TowwjiS0IAKbV9fodDwe23psoEpRxbPL+JBShCOFk5seD2Zws=
X-Received: by 2002:a05:622a:d10:b0:4a6:e7f7:5742 with SMTP id
 d75a77b69052e-4a9871f98eamr47500211cf.33.1751531924525; Thu, 03 Jul 2025
 01:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250616094531.4158505-1-padmarao.begari@amd.com>
 <20250616094531.4158505-3-padmarao.begari@amd.com>
In-Reply-To: <20250616094531.4158505-3-padmarao.begari@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 3 Jul 2025 14:08:33 +0530
X-Gm-Features: Ac12FXzIf0tqjw4I31u8gNFB2eYk8Ty1-8xLTTvh_UsFdsNuLFFF775lUhwap9g
Message-ID: <CADg8p96OGTaLeD+dCpFhf-z6k_Kb9=y1XB+6N-mtAXKw+s+b8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] board: xilinx: update guid based on metadata
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com, 
 venkatesh.abbarapu@amd.com, ilias.apalodimas@linaro.org
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

On Mon, 16 Jun 2025 at 15:15, Padmarao Begari <padmarao.begari@amd.com> wrote:
>
> The generated GUID applies to all Xilinx platforms but is not
> specific to any individual board. For FWU multi bank update,
> use the image UUID (GUID) from the FWU metadata structure
> rather than embedding a generated GUID into the U-Boot build.
>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  board/xilinx/common/board.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 8ffe7429901..3d22149d429 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -712,3 +712,16 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  }
>
>  #endif
> +
> +#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
> +int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data)
> +{
> +       struct fwu_image_entry *img_entry = &data->fwu_images[0];
> +
> +       /* Copy image type GUID */
> +       memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);

As we had discussed this offline, this is not a robust thing to do as
the FWU metadata is not secure, whereas the U-Boot image might be
booted as part of a trusted boot chain. This should be highlighted at
least with a comment saying so.

-sughosh

> +
> +       return 0;
> +}
> +
> +#endif
> --
> 2.25.1
>
