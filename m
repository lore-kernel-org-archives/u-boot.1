Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EADC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 18:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E9B80EC0;
	Fri, 21 Feb 2025 19:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kCE3eYTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C405380F67; Fri, 21 Feb 2025 19:39:59 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84077807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 19:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so2203424276.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740163196; x=1740767996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4BQSkx+ViOE4UCO+TiUs0I0wQ7BYbO5Cn4nWOU9YBxk=;
 b=kCE3eYTfxzi+/Fg9EtrL6TLgmlD89ZOdtJcloviUG5aLNtWIqQrCK8AZhppOl68yMB
 r9plGAq5kBqGpaV4S4tUKMLBlOoqsPH/x5dyCvlfpdAgHelOXo7STwywoP5yczWlEUk+
 x47nxwiu06OkkZOohrRl0/dab8EImOKWra/jHcepGpa4d2YTB3p4rex7fYuBf9UBvsTA
 JiKKRkZ7OGwXe0BLAAro53vGbZrb3Fp/JYOdF75/3YMFd1Nu0B+ObGslb8hZxexG20Tj
 Do/YjpUs610wv90X7KHeXnF/UVCoSLh57roo2JrRWP8NW8ZIG17qJdyDUCYTHwD+wrcu
 60NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740163196; x=1740767996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4BQSkx+ViOE4UCO+TiUs0I0wQ7BYbO5Cn4nWOU9YBxk=;
 b=c1/NnQY3CL7aVKJ5uijiQztnxol4b2+cT3/9oeLjhWvgw1AP7gJWtcP8Fwv4rTG9Vo
 YcNc+6sYCxe6rqUYp1oDzxqMIgTUENIxlCw/0Wz3kTw0hmjCEdbErutb57e9xk+Jqx+s
 6eZcRCFZ5IQP11zkdhQ/O+D+hTrJRIExRWD/nN+iqoHwNNn4D74AsyWzBr1VQ1M8ZtgQ
 gmjkufBnTLOfNThBcSK19s5SnhXbQnYY/TQt5ZMgYT3ZE+9TSV8p7sAg5AwIcKzTQD8/
 NZvmWPuaMUXqeqhzB76/Bh1/cCcq/PLtX+pKn9Aiyg+2SuKI/AOD3LZRkJIrxuv05Ji6
 fgnQ==
X-Gm-Message-State: AOJu0YzyrD/8Tb0eyihj+senjzHOyf5zk+vOzqMqZ2OCIEUWbiM0X6s+
 aWMZwXpACQsQ7/hkj5uVCyPTc4ZfLfitirT195fCYs1noDvHCU3onJooeCPoGXuXjXaah0yTW00
 iCifp9FhdrOfY+Ju9TvonR9+A59LhGFteTgwS3g==
X-Gm-Gg: ASbGncvKw0Nr8IUIfrgZsMqj24i+voLeM7nLrDRJ/XP8lTn0aOmonbSoNZa0pv87QHZ
 u3WByI4Bc/ujKBJzeaH32kPSVMDwy6cTMZd2ZcWpmtuoE0WLxDVSx8pcFpnaDtaRB+ySSwqe4Ms
 RD5aJ+tatQ
X-Google-Smtp-Source: AGHT+IHS4iPRg0y98rwrHnQZaxhE0P/yvO5KLKipiY3uQ5UOSP5hus8bJ5rOQBCN67sHct8ZiiSHbZgOrynHr5FVJo0=
X-Received: by 2002:a05:6902:1025:b0:e5d:d917:3c2 with SMTP id
 3f1490d57ef6-e5e24609cb6mr3481621276.29.1740163196378; Fri, 21 Feb 2025
 10:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20250203105912.196654-1-sughosh.ganu@linaro.org>
 <20250203105912.196654-5-sughosh.ganu@linaro.org>
In-Reply-To: <20250203105912.196654-5-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Feb 2025 20:39:20 +0200
X-Gm-Features: AWEUYZmV3A1HmzxJPjTMM7m-wlTaQwzlXgMmUKZRH2MEj8JD-4WgXkyaPvTF9W8
Message-ID: <CAC_iWj+Xq7vNmMX4h1m5PJpCF+Svx7x-BPAUY54bNN+GYo8F=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] blkmap: store type of blkmap slice in
 corresponding structure
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Bin Meng <bmeng@tinylab.org>
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

Hi Tobias,

This looks ok to me, but OTOH I haven't been involved with blkmap too much.

On Mon, 3 Feb 2025 at 12:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add information about the type of blkmap slice in the corresponding
> slice structure. Put information in the blkmap slice structure to
> identify if it is associated with a memory or linear mapped
> device. Which can then be used to take specific action based on the
> type of the blkmap slice.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V3:
> * Add the map type to the blkmap slice instead of the entire blkmap
>   device
>
>  drivers/block/blkmap.c | 4 ++++
>  include/blkmap.h       | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index 34eed1380dc..4c71ec784e0 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -25,12 +25,14 @@ struct blkmap;
>   * @node: List node used to associate this slice with a blkmap
>   * @blknr: Start block number of the mapping
>   * @blkcnt: Number of blocks covered by this mapping
> + * @type: Type of blkmap slice
>   */
>  struct blkmap_slice {
>         struct list_head node;
>
>         lbaint_t blknr;
>         lbaint_t blkcnt;
> +       enum blkmap_slice_type type;
>
>         /**
>          * @read: - Read from slice
> @@ -169,6 +171,7 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>                 .slice = {
>                         .blknr = blknr,
>                         .blkcnt = blkcnt,
> +                       .type = BLKMAP_SLICE_LINEAR,
>
>                         .read = blkmap_linear_read,
>                         .write = blkmap_linear_write,
> @@ -248,6 +251,7 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>                 .slice = {
>                         .blknr = blknr,
>                         .blkcnt = blkcnt,
> +                       .type = BLKMAP_SLICE_MEM,
>
>                         .read = blkmap_mem_read,
>                         .write = blkmap_mem_write,
> diff --git a/include/blkmap.h b/include/blkmap.h
> index d53095437fa..c7b4bf13c4e 100644
> --- a/include/blkmap.h
> +++ b/include/blkmap.h
> @@ -9,6 +9,12 @@
>
>  #include <dm/lists.h>
>
> +/* Type of blkmap slice, Linear or Memory */
> +enum blkmap_slice_type {
> +       BLKMAP_SLICE_LINEAR = 1,
> +       BLKMAP_SLICE_MEM,
> +};
> +
>  /**
>   * struct blkmap - Block map
>   *
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
