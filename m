Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3965C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 08:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4CB58729D;
	Thu, 16 Nov 2023 09:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f+JVLVWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35CF871D0; Thu, 16 Nov 2023 09:43:27 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8E18746E
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 09:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vicooodin@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5af6c445e9eso5994827b3.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 00:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700124196; x=1700728996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S6++XDzYd/6LGL3CcuWREPghNHtNvPUxaQn1gQU1QD0=;
 b=f+JVLVWpVQ7D1+n7Es/X+hS9WWZYLQSQtN3VLU02bdoLWxKiu1NixbJgwB6es1BfV6
 sKzntc1Bdj2FdZXGdUw8aD6q/jvy17/L47VEnuybSlTumYEpWWhhVzi4qSZPNENnQQKt
 xp/WnhoArhj0tomocO5LMTfJapBT0QPxHr8Jni1+tVWfpClPHXCjF6h3flIAtBXktfi2
 FDyqUVn2lDzXLQv0zCuFYGdliN1v/fPvH39cK/64R+L2WVdyRDkcY22lABExsIV0NNGO
 uLFg3yiZF4ZjM+TrWxn8JQMF/TzDCzYMc+YZb6rQyutwy+eaoX1kZ+C2DWU3W28xvrXb
 sRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700124196; x=1700728996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S6++XDzYd/6LGL3CcuWREPghNHtNvPUxaQn1gQU1QD0=;
 b=OaOu5X4LS4qi4IjJW040DWc8PXvV9bJ78aw5uRROWFdCubNSTlmhzey7xKUV9Usbag
 pRpGtipFKSPKSmibitZm3jEfG7Gm1P0hpfyX/JCyjdY8HYKcAdKn6s+mZj75TDdFpk+s
 NThFPeLH4bI6AcX44XJfy3aKOtcNXDtHjh1Y8J1f6YBUIAoMEhSX9GYRSXTctWt/qJm4
 UTXyvdLZbAYHMoxjQfa4sH8H/ZDOX3EQMOrbfy1boGgEYxKflJWwqJDv7IxOiqGhqSfx
 2U/cg2DkO5aGQ5kpoh744N5Mq0tkNPpfdQrL4Q5418/nrRMn9k+EWdNQ3spyNvND8Az6
 SZHA==
X-Gm-Message-State: AOJu0Yy6N7EVwOGmQL/Zr8IPACE0M7Nq3fTrXcjtgIx4eWa/eLlrOEL0
 TRk5lvjHUuZ0GX2KFR/fc9/ixzvbrJLTpZYHlck=
X-Google-Smtp-Source: AGHT+IGFXqpVPynbGWCwGpHSILQKHqLtgxjeiL8/RYKaBKWIoa1P8c9/y8CiYS4ZiG9hlSDF8fWf4usK1zOyrp37OFA=
X-Received: by 2002:a25:6951:0:b0:da3:ab41:2fc8 with SMTP id
 e78-20020a256951000000b00da3ab412fc8mr14289743ybc.16.1700124195867; Thu, 16
 Nov 2023 00:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20231115015345.490313-1-takahiro.akashi@linaro.org>
In-Reply-To: <20231115015345.490313-1-takahiro.akashi@linaro.org>
From: Nastya Vicodin <vicooodin@gmail.com>
Date: Thu, 16 Nov 2023 08:43:03 +0100
Message-ID: <CAFdZxxk1WTYcE60outVPAPatpcqT_7msj_wEgEzcTdHoSU8kdg@mail.gmail.com>
Subject: Re: [PATCH] xen: pvblock: fix the maximum io size in one operation
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: oleksandr_andrushchenko@epam.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Reviewed-by <Anastasiia Lukianenko vicooodin@gmail.com>

Regards,
Anastasiia

On Wed, Nov 15, 2023 at 2:53=E2=80=AFAM AKASHI Takahiro <takahiro.akashi@li=
naro.org>
wrote:

> The current implementation may cause BUG_ON() in blkfront_aio()
>         BUG_ON(n > BLKIF_MAX_SEGMENTS_PER_REQUEST);
>
> In pvblock_iop(), a read/write operation will be split into smaller
> chunks of data so that the size in one access (aio_nbytes) is limited
> to, at the maximum,
>         BLKIF_MAX_SEGMENTS_PER_REQUEST * PAGE_SIZE
>
> But this works only if when the *buffer* passed in to pvblock_io()
> is page-aligned. If not, the given data region may stand across
> (BLKIF_MAX_SEGMENTS_PER_REQUEST + 1) pages. See the logic in
> blkfront_aio():
>         start =3D (uintptr_t)aiocbp->aio_buf & PAGE_MASK;
>         end =3D ((uintptr_t)aiocbp->aio_buf + aiocbp->aio_nbytes +
>                PAGE_SIZE - 1) & PAGE_MASK;
> Then this will lead to BUG_ON() above.
>
> This can be fixed by decreasing the maximum size of aio_nbytes.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Fixes: commit 3a739cc6c948 ("xen: pvblock: Implement front-back protocol
> and do IO")
> ---
>  drivers/xen/pvblock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/xen/pvblock.c b/drivers/xen/pvblock.c
> index 4ad548d599d5..1df04e239ad0 100644
> --- a/drivers/xen/pvblock.c
> +++ b/drivers/xen/pvblock.c
> @@ -632,7 +632,8 @@ static ulong pvblock_iop(struct udevice *udev,
> lbaint_t blknr,
>                         memcpy(blk_dev->bounce_buffer, buffer,
> desc->blksz);
>
>                 aiocb.aio_nbytes =3D unaligned ? desc->blksz :
> -                       min((size_t)(BLKIF_MAX_SEGMENTS_PER_REQUEST *
> PAGE_SIZE),
> +                       min((size_t)((BLKIF_MAX_SEGMENTS_PER_REQUEST - 1)
> +                                       * PAGE_SIZE),
>                             (size_t)(blocks_todo * desc->blksz));
>
>                 blkfront_io(&aiocb, write);
> --
> 2.34.1
>
>
