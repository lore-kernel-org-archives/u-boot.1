Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A089D0E6E8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 10:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF40388EEA;
	Mon, 21 Oct 2024 12:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z6rujN3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B8D88EEA; Mon, 21 Oct 2024 12:26:25 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8361288EC6
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 12:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so3205224a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729506382; x=1730111182; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HVgh/MyT/yo4SnWRz3KqU4FieuTt8anDV0nOR8TiuuQ=;
 b=z6rujN3MUH4TLhysr+hywAcfbNISMx330eokzOq6tVwwSJw0/IQe0bHuKwtW+0mw0P
 uB3Eku/+HMxdb67dXl/bD7KalY5m200WBAHaaUKjWHmrhdkOvASC0cgc9usBiA4ywTvQ
 dSHnB89QLGQ2CurcTQcZ0Mrmg6+WJW87PCL2w9/jd6JkHpcfUXgb+moctfnK0LZ5wY2f
 IPtMTadP8aklvlPsr5sykbWfA4ZsYI76FDsxHvM3CKv8haHghBtkjZ5z8sR1l0mK+vMo
 joBgnyUGC7sofurCv4OFJcIywdn2lJk1nBIZWRpr2a0lbzHuqXUTb+U/TtnDjHg8xprZ
 QjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729506382; x=1730111182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HVgh/MyT/yo4SnWRz3KqU4FieuTt8anDV0nOR8TiuuQ=;
 b=TpU7rtpKSV0l+sLrzMHtc1jAj1Xevu8WkakXw122MIz6Rkbw6lGi5vjbrBb0NSnjQd
 /M4zq90fA4RadO1r25/s4qMFBCzDfHc+lNs5iLGJRjG30ppBpv62ZsYv+lurtYI0r0TZ
 Yz2sn+czu/WQqfBXfy1qf/UU0IK2cquZWL53TpOhSwWJ1cpL7wPAiPQuuxptHWqAmMkg
 oPd1DGinsaJQAgAy6+ChnqysIF36H9xXVtIyss52A9KQ7CgIjWLeE39TxWWm+dbznhB4
 RKqTDorPOA5u/vBmTTT6si843X7EQjJykbmCYE4a9cKaamgIGxm9Xul8aPPpnfjIvZfq
 nKeQ==
X-Gm-Message-State: AOJu0YwzcTYhdS/r9EKW5zalpcSzQtBBCtmogf1JN69O1dJMb3GoAZni
 Dquma990QW5nfHjnzdz6JmaeI+nMINsqOYLmlSGesqW8Cq+VdsJGb3NQR55l+u1S5qO/30NvqAP
 26W1n3W6SS6NnfmsYvgrgvdolR01+shDSsTnMnA==
X-Google-Smtp-Source: AGHT+IHe7MPFZMd86x9Yy9hMaE+9VipZfZJpCOEA5W47Yi5XvY/76N2Uo9EMpvTkDMQZeMMTtK2NpMHdZ6IZDNdy58w=
X-Received: by 2002:a05:6a20:d74d:b0:1d6:fb1b:d07a with SMTP id
 adf61e73a8af0-1d92c56b8e2mr16010927637.31.1729506382049; Mon, 21 Oct 2024
 03:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241019152211.1014896-1-sjg@chromium.org>
 <20241019152211.1014896-24-sjg@chromium.org>
In-Reply-To: <20241019152211.1014896-24-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Oct 2024 13:25:45 +0300
Message-ID: <CAC_iWjJ2PGNkSW8QamfRyQXD-Az7g-_SswB8Nbv14KKkGfbYOg@mail.gmail.com>
Subject: Re: [PATCH v2 23/31] bootmeth_efi: Simplify reading files by using
 the common function
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
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

On Sat, 19 Oct 2024 at 18:22, Simon Glass <sjg@chromium.org> wrote:
>
> The efiload_read_file() does similar things to a common function, so
> update it to use that instead.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Change the tag to bootmeth_efi
>
>  boot/bootmeth_efi.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 2ad6d3b4ace..f3ddbe71405 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -110,19 +110,14 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
>  static int efiload_read_file(struct bootflow *bflow, ulong addr)
>  {
>         struct blk_desc *desc = NULL;
> -       loff_t bytes_read;
> +       ulong size;
>         int ret;
>
>         if (bflow->blk)
>                  desc = dev_get_uclass_plat(bflow->blk);
> -       ret = bootmeth_setup_fs(bflow, desc);
> -       if (ret)
> -               return log_msg_ret("set", ret);
>
> -       ret = fs_read(bflow->fname, addr, 0, bflow->size, &bytes_read);
> -       if (ret)
> -               return log_msg_ret("read", ret);
> -       bflow->buf = map_sysmem(addr, bflow->size);
> +       ret = bootmeth_common_read_file(bflow->method, bflow, bflow->fname,
> +                                       addr, &size);
>
>         set_efi_bootdev(desc, bflow);
>
> --
> 2.34.1
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
