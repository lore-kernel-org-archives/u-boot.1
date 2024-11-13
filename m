Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0482FD462A1
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B659A89515;
	Wed, 13 Nov 2024 14:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EjDKUB69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07817895A2; Wed, 13 Nov 2024 14:40:08 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCEE89586
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9ed49edd41so1173949266b.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731505205; x=1732110005; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U+KXeoicaCnRN+X6r0bUJwmyBnoBs82d3iAXMTRG6PY=;
 b=EjDKUB69oFA0DMzb2Pem2MkMOEjkIsvmnkRW3Xpan6YZXTDWgAafb91D+El13zSIKW
 ZCIj+YCsKywLmI6ZrOiZ5X5Qcoen7avwV9KfQ1yr3EYZhDcBkc0t7XRetMBjDfIf39vk
 yreRFLDZH7yF5WZiJns7TtrY88bUa+Ch23kEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731505205; x=1732110005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+KXeoicaCnRN+X6r0bUJwmyBnoBs82d3iAXMTRG6PY=;
 b=vnTjO/vgl+4BNX2ePE/ROJq1Qf5Nfm9SOE9nnpuVocrNa7DkavzlAuh3eLkJSZ/7JM
 fTIxNcdhpG/5JLZxL8qF4rAt9WF01aG8nKmv3tlKvfgCazZGm+fEFyKLBRhPb7PrNkLR
 hLX9vK7ZSI/rBDobPQdB7SfChY53IusD9P9mlUqGXffYJgz/LlG1KCnj9ut4wHrCPdQI
 r+a/LzKDV/5x+qpZ+0amWdn5HtgO5zglCmuuh9DrJUIo78WPP2eSlpElBrnfNqEJT1d/
 v7bR+avkSIa6ryow3+UUET4sfcTMI17NHkZhBXS7P4T5YyUsVssiMmK4FYk67SEkLe2i
 TBqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYXg6K+CYpaCQP0u3j5Ny02efq6KSfYE5bgTIvwVzE+/4BI5sCcb4ilYZxFa4P0dtbLlYW/EQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyONa7kc75tV9YBsYUdYbICfy1dQFop+gWCsMJyKmRmANQeVhDL
 ZGDBNukSM/EvoC4BRdXnhqxfp6jmFVrivmH0dZpYaBwApYTvdIxdGt84dVQqcif18WheWrb2+2x
 BzB1YcdniMlVQXQzEfCTRb/+yh5xBbHtvbWsy
X-Google-Smtp-Source: AGHT+IGzu5dgfcJwY6af+x/6jCbxSEY/7v8xGHioR4wI0Dh6ynid8x6NNvdyRBPYfwZzXC7fZcDVwTAnpFlT/E+iUdA=
X-Received: by 2002:a17:907:2d0a:b0:a99:5601:7dc1 with SMTP id
 a640c23a62f3a-a9ef001e747mr1997556866b.49.1731505205191; Wed, 13 Nov 2024
 05:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20241113044956.1836896-1-caleb.connolly@linaro.org>
In-Reply-To: <20241113044956.1836896-1-caleb.connolly@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 06:39:52 -0700
Message-ID: <CAFLszThqyYf6wYm1k8fB7bAdrz2h993pGFhXs1VV=oL=oOM-xg@mail.gmail.com>
Subject: Re: [PATCH] fs: fat: allow FS and device to have mismatching sector
 sizes
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Alexander Dahl <ada@thorsis.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Caleb,

On Tue, 12 Nov 2024 at 21:50, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The Qualcomm Robotics RB1 and RB2 boards feature MMC storage provisioned
> with a 4k sector size GPT, with factory partitions formatted with
> filesystems using 512 byte sector sizes.
>
> Whilst certainly unusual, and really not ideal, this appears to work
> fine in practise. So demote this failure condition to a debug log.
>

Can you please take a look at [1] - this patch was not applied, but I
hit a similar problem.

> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  fs/fat/fat.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index e2570e816768..a84ca301cad1 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -645,13 +645,12 @@ static int get_fs_info(fsdata *mydata)
>         mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
>
>         mydata->sect_size = get_unaligned_le16(bs.sector_size);
>         mydata->clust_size = bs.cluster_size;
> -       if (mydata->sect_size != cur_part_info.blksz) {
> -               log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
> +       if (mydata->sect_size != cur_part_info.blksz)
> +               log_debug("FAT sector size mismatch (fs=%u, dev=%lu)\n",
>                         mydata->sect_size, cur_part_info.blksz);
> -               return -1;
> -       }
> +
>         if (mydata->clust_size == 0) {
>                 log_err("FAT cluster size not set\n");
>                 return -1;
>         }
> --
> 2.47.0
>

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230730111516.v2.1.Ia13846500fab3d5a1d5573db11a040d233994fa6@changeid/
