Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56C7CD342F
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 01:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6522686A27;
	Tue, 19 Sep 2023 03:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="z8nqNWkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0640C86915; Tue, 19 Sep 2023 03:05:10 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC0886A2F
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 03:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-986d8332f50so696550066b.0
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695085507; x=1695690307; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ttnrxQgzmssLaHoZOR05lIunilcWLfBDcr9+mRJtjVE=;
 b=z8nqNWklKGFlbtflUHY62850D/CWGkh62UA58gGOQabU/xMrbcvB5uWW8iDZFRWPh6
 K9J6ef7slRg1M54Z9CZNHc8Bpgpxh1HOx2aOflfViTlauy4N9hmkWkQZZEzM7fjK8MMK
 Ok2xAZUCc0bEWp3WHnVsLkVG+/1Z2DXizFBr+2A7WLy8h85dkIV/uyXkxxRQ5RtvVJ8y
 DVaC+RwuwgYK/EK2jrfELB6kTYwh306IopxyXzmGfOs6y9zA0hbDVo39ygvamjiPHtt4
 MQtZTlVrYBBvVD8ripV10mbU3kwt2+JvnYM4V+RUaiq9deZOK3IDo++TF/Jk4nqq7Nmu
 YSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695085507; x=1695690307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttnrxQgzmssLaHoZOR05lIunilcWLfBDcr9+mRJtjVE=;
 b=v2RdyoC/XQkg+Z7z5BMT5bFczRc4DX1EC8jZUmPqs+ZiD1rgKmeE32cu0uAudZfF25
 +6SKFsc7H+LX9PXExjgzO6cWaGvfsY7mk8q5ylS7QXetccTGbDORGhku7fWLpQj3zpoz
 h0jJ4Z+8qR7uqv9g+CQiJsWBP+F4PHJIW3MC7LxnZeqOBoSjOpEHkgbkc7tVYgoJUbOR
 8Luy8QavTQHZ7Ug8I3Qky2JToyGEZyxTS2tttnXoXSfqA2hbTmVWSMfXcTmXiFHaW3w3
 Biv4Lw9Tn9PLMDKiVleiUzJFutYw1JH98O+l8A4ERkfNujpX1MfTKCACaJ+AGV8wYvPl
 6hlg==
X-Gm-Message-State: AOJu0Yxjc0prYBcIFXxUTmCJkgu4p3IxJSh8GHVMnnlHLuo4yZfvg50U
 y/uYGc6wpXJZ6H2JMo48TuoIOYlVlZDrSov1oSagcg==
X-Google-Smtp-Source: AGHT+IH/WBlJW5+bDWgHpwuPECBaR4b0SucYV+7m7fnIO+GAFotSgKNSvEZykYAYjfKFzda0U74osfxfQWDqNpyrvUA=
X-Received: by 2002:a17:907:2724:b0:9a5:b8c1:8bfa with SMTP id
 d4-20020a170907272400b009a5b8c18bfamr8976067ejl.28.1695085506895; Mon, 18 Sep
 2023 18:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230916131812.4035430-1-ryan-uboot@lahfa.xyz>
In-Reply-To: <20230916131812.4035430-1-ryan-uboot@lahfa.xyz>
From: Simon Glass <sjg@google.com>
Date: Mon, 18 Sep 2023 19:04:52 -0600
Message-ID: <CAPnjgZ005NZsByHmvvdaMbF92A5EM+Wu+pLaOejaW7bXHeLA8g@mail.gmail.com>
Subject: Re: zboot: [PATCH] boot/pxe-utils: populate initrd_filesize for
 extlinux boot
To: ryan-uboot@lahfa.xyz
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
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

+Bin Meng since I think there is a similar patch applied to x86 already?


On Sat, 16 Sept 2023 at 07:31, Ryan Lahfa <ryan-uboot@lahfa.xyz> wrote:
>
> The reason for this is that initrd_filesize is constantly equal to zero
> or more specifically, potentially uninitialized memory.
>
> I believe this was introduced in
> 085cbdafca9c3d7bc2f27523a343f61db82f2ccb ("pxe: simplify label_boot()"),
> diff here:
>
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index b08aee9896..defbe465e4 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -532,11 +532,10 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
>                 }
>
>                 initrd_addr_str = env_get("ramdisk_addr_r");
> -               strcpy(initrd_filesize, simple_xtoa(size));
> -
> -               strncpy(initrd_str, initrd_addr_str, 18);
> -               strcat(initrd_str, ":");
> -               strncat(initrd_str, initrd_filesize, 9);
> +               size = snprintf(initrd_str, sizeof(initrd_str), "%s:%lx",
> +                               initrd_addr_str, size);
> +               if (size >= sizeof(initrd_str))
> +                       return 1;
>         }
>
>         if (get_relfile_envaddr(ctx, label->kernel, "kernel_addr_r",
>
> The initrd_filesize completely disappears.
>
> We re-copy the size information inside initrd_filesize, maybe, too
> naively, something may have to be done to reduce the overflow potential
> if it exist at all.
>
> pxe_utils.c |    2 ++
>  1 file changed, 2 insertions(+)
>
