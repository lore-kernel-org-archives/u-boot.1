Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF132C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4440A869D9;
	Tue, 15 Aug 2023 16:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ctbeX+96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8B5869AD; Tue, 15 Aug 2023 16:44:40 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483E4869E0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99bccc9ec02so773350066b.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692110677; x=1692715477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCDANBJc99vvymBCSQABpWJgXGo3JnJkoHcz41IutIw=;
 b=ctbeX+96jHF/yWy4JedWHmsrxLvzqmIRaV/7780nUAiH5pLulS6E9J+J4ZLR1bPicM
 ECo8abSeGySlx+S+HcjsFU+XIUAy+ZMQUVLaScySXMytKuh3pqC9r51flef2M3j0f+ob
 5qzCuFK2GqldNwvT2Q+ZHiS255qKyRr5ISqAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110677; x=1692715477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCDANBJc99vvymBCSQABpWJgXGo3JnJkoHcz41IutIw=;
 b=e6hn7J5qEWAnZOQJpXr2oW26EzxHbAfOWWqkCy0t/7TDUfGneBl8nX4w59ts/XsGHb
 0uj4KxD4El9uA291A0yxoQOfwDgYZpyxr7QYNuAYkYcR5U4Lt9S9EJv5DIQ+FEo3/OH9
 2IHOymh/8lL3ZwOunZ4dLSTh4kD7FUEpQnhWezcKTb0xBoeB3iOBfF+dL0PYW8w9nYVU
 MVdGSNm5gSdkgLIYC7f4Waq1Wxkdgqp+q3Dk2f1diorURMuQxemDES1aRQHHG6nLPNw9
 s0iPLjeIKQ7b4MeMxYp1H5oharsHr/goLlhYLRWQTN5VEL/Sy+xbTtIzRnlmuIG2R1//
 3p5g==
X-Gm-Message-State: AOJu0YwchP6uIyGsHRKWYuRT2bh7GJKDOpPiFDB2fqduXGO3kG8QO8mB
 XGioG4yDiWONcAZgVjz04+T4sKsxNoFbOUI8hlAcwQ==
X-Google-Smtp-Source: AGHT+IHKmgYU+6UKcjSHP0xcZraiRKvSKxj5ild4D6K3Li1IqGX5xvrNyD8588XsO5GnrZefSBY+x1t6udCcGNmjEqI=
X-Received: by 2002:a17:906:3ca9:b0:99c:6312:73ca with SMTP id
 b9-20020a1709063ca900b0099c631273camr9710354ejh.71.1692110676716; Tue, 15 Aug
 2023 07:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230815103259.17476-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230815103259.17476-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 08:44:25 -0600
Message-ID: <CAPnjgZ0BB90F4Zpq6AtyTPuME3XiJJYmYUOBhFCG9FujOq4wHw@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: add partition API to HTML documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Joshua Watt <jpewhacker@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 15 Aug 2023 at 04:32, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Convert comments in part.h to Sphinx style.
> * Create documentation page for the partition API.
> * Add the partition API page to the API index page.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/api/index.rst |   1 +
>  doc/api/part.rst  |   6 ++
>  include/part.h    | 210 ++++++++++++++++++++++++----------------------
>  3 files changed, 119 insertions(+), 98 deletions(-)
>  create mode 100644 doc/api/part.rst

Reviewed-by: Simon Glass <sjg@chromium.org>

Q below

>
> diff --git a/doc/api/index.rst b/doc/api/index.rst
> index a9338cfef9..3a80ae0635 100644
> --- a/doc/api/index.rst
> +++ b/doc/api/index.rst
> @@ -15,6 +15,7 @@ U-Boot API documentation
>     lmb
>     logging
>     nvmem
> +   part
>     pinctrl
>     rng
>     sandbox
> diff --git a/doc/api/part.rst b/doc/api/part.rst
> new file mode 100644
> index 0000000000..d1df1d8494
> --- /dev/null
> +++ b/doc/api/part.rst
> @@ -0,0 +1,6 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Partition API
> +=============
> +[..]

> +/**
> + * struct part_driver - partition driver
> + */
>  struct part_driver {
> +       /** @name:      partition name */
>         const char *name;
> +       /** @part_type: (MBR) partition type */
>         int part_type;
> -       const int max_entries;  /* maximum number of entries to search */
> -
> +       /** @max_entries:       maximum number of partition table entries */
> +       const int max_entries;
>         /**
> -        * get_info() - Get information about a partition
> +        * @get_info:           Get information about a partition

Are we not allowed the () at end? I much prefer brackets as they show
it is a function.

>          *
> -        * @dev_desc:   Block device descriptor
> -        * @part:       Partition number (1 = first)
> -        * @info:       Returns partition information
> +        * @get_info.dev_desc:  Block device descriptor
> +        * @get_info.part:      Partition number (1 = first)
> +        * @get_info.info:      Returns partition information
>          */
>         int (*get_info)(struct blk_desc *dev_desc, int part,
>                         struct disk_partition *info);
[..]

Regards,
Simon
