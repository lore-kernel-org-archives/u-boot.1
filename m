Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395F5CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE2784879;
	Mon, 25 May 2026 17:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AOgqFiVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19777848A1; Mon, 25 May 2026 17:11:13 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3391A84862
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bd8f9725b30so1015543266b.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721871; cv=none;
 d=google.com; s=arc-20240605;
 b=jAln4eBMkPbXdcyA8k9Rk8bJ28JdlLQsM07z8CoZpdlypkeFfywTApQsa+NITZWk8Z
 TiHuTMqvpsl2rEEqLyMeuDoxU+ed3UBIQjyHzLBM3+WWJe7WOcJ1eo/XyKOKm49IcA7F
 Mob5gQp59fkpy9BZfsQlh65E1X3tyRrJAeQdpZMBxfs+bvcyVOOfOySQQKQ0JMPImG87
 Nn201EmYaZB6VjtiIJdrJOeceVTb22ES/6rJGntk2A9dvkSS2qKzMtroXotc1bmJEqSx
 OAhEjOBXeBDHzV3HzRguIIXIzjqGsRBPFeWwX1sl50MW5HeMViEdlOZ6PLGGff7LMP5f
 +GQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JNcffKOWm6iNYnCD0GLmBYWyfc594pVP1SXxADs5ghg=;
 fh=E8i5n10XNmew4pFsbezk1l8PWdZuCHzZSzlRhvS0fOM=;
 b=UupaeXU9UpP6V7vuTt9u2ys6bYZkojSg4oePPQQ5n2ZShSdNP7qRY6GYsqd2Upbbg+
 mXxsfVKR4hAQSG9CN0ZH1xJS3hvdMZzgaYh6SUY9xb5blzK6E0zubmGzFUnmaCmJGy05
 BDyac5ntlX2vVhA+xthUaS3R7sUTQl67Yt+dxjMY0z/rr8p4IZMaL6kK+ltVpXnSf2pR
 oMToZhXTApa2Eog1ttaaQiO44/LIbsNBcNE8vHigQS1ebsyjSKg6gpj7VeMn1qqpF+AE
 G5Bx6O8+lN1YL+zwrddlbXmMucJDsHNQhDyZDyafXntESWR9MvTC4IviBnPtkZh8AK4R
 Yxxw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721871; x=1780326671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JNcffKOWm6iNYnCD0GLmBYWyfc594pVP1SXxADs5ghg=;
 b=AOgqFiVmJVNTlHmiylVxGYvEvFuPzXK9n6qCUycJmaD1HFsVbYvoao2Nvz2P947nEM
 KmO1Pvwd5x83zipcfGiC94/LFYWQvCkF0FVqUCtM6W2nijdbYVwy+udAYQQE82C9c3x7
 dKBIiWv2PV7s0BgwK3an02Udvk8VSYovUpxAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721871; x=1780326671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNcffKOWm6iNYnCD0GLmBYWyfc594pVP1SXxADs5ghg=;
 b=smqsIICi7BpsCeAIQcFJrzEX2asxecBlGJPM+jG9fwRvRCYb/69Glti8YcLLLfYx3T
 yqWXU0srhPx5w979yVBxDoLXgbqoXfD6MAhf/hK1UJKKN79HCxjTjxwRVekMx8ePrYHw
 GikPey3zsfbJEhNtYig2nWVoVxUjYEUCjxsI2rnq4Pec7uHLXEOl9vsIWD6kOGSsydTQ
 GSh633X4Tt4Pu1JMY8C/GZMRsifj+vcKHCQ1NGUUxjE8Rt37LErw35SfklM+UHug+oUc
 qMKNHjCUkMvOuRTQCmEKhoXo/cqOZE5bpujAg5ZM62GkRgwVfS8Ubw7U5DfKwERB+hQC
 iufA==
X-Gm-Message-State: AOJu0Yw9jm6QQVwoxxqFYNos1MYEKaXzIyJIvScgjKh0Or5+BFEncMji
 m7vtxdInpJVP+MgfgRFfZb4mCJbwuJIrlWa7yAWbHywgwCVfW8if6hlQJ0pvzbhK2VWTXYEYvpD
 td7/6/ZPqzmwFCgRNngAsoa32X9aLl7MC84LN2sqjnyvMEI8wyxY=
X-Gm-Gg: Acq92OGIJJ4gtW24zT0Ea9xFfGYnFcmBL05lt5tEX7sKp0lqbfNgFpGXHl3wokdjRVJ
 UdcyAg/FRj0d1UYWNWjoeYktcBcEzOrpAfhBW8h5WL6uo7IOvkUOcGHFmxe1twVMTPXizQoLrok
 GjiwxbPwLRFVTDx8GU6DzWcGVv0IRU3lw+UjN9BnJ8fptPugTwCAJZZbtkmBEmGtz+o5EPyVtQQ
 tAT9F8DNO43z0u5Bz5uet2TVdfB2V78BRpA1VzXSBshQxeBUB+Jxx4MUIc94d85ahuNfSWRm1hG
 SJFDjRwFH5LCAY7Z
X-Received: by 2002:a17:906:7303:b0:bc4:b970:e47f with SMTP id
 a640c23a62f3a-bdd282a4831mr906402366b.9.1779721870645; Mon, 25 May 2026
 08:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:10:58 -0600
X-Gm-Features: AVHnY4JT35RF0IVyco2DXTR-iMdjlsOCXcGMnmpglSKah5L2d0-tNWHlNVR6Gbc
Message-ID: <CAFLszTiTvpa0mFwC3fLf6TQMc+xCyrUvpAav_sjoY-PgGiztnA@mail.gmail.com>
Subject: Re: [PATCH] tools: fit_common: fix memory leak in mmap_fdt error path
To: ant.v.moryakov@gmail.com
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

Hi Anton,

On 2026-05-21T19:13:58, Anton Moryakov <ant.v.moryakov@gmail.com> wrote:
> tools: fit_common: fix memory leak in mmap_fdt error path
>
> Static analysis reported that memory mapped by mmap() is not unmapped
> in the error path of mmap_fdt().
>
> If mmap() succeeds but a subsequent operation fails (fstat, ftruncate,
> fdt_check_header, or fdt_open_into), the function jumps to the err:
> label which closes the file descriptor but does not call munmap() on
> the mapped region, causing a memory leak.
>
> Fix: add munmap(ptr, sbuf->st_size) in the error path, guarded by
> ptr != MAP_FAILED to avoid unmapping an invalid pointer.
>
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
>
> tools/fit_common.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/tools/fit_common.c b/tools/fit_common.c
> @@ -123,6 +123,8 @@ err:
>               close(fd);
>       if (delete_on_error)
>               unlink(fname);
> +     if (ptr != MAP_FAILED)
> +             munmap(ptr, sbuf->st_size);
>
>       return -1;
>  }

Not quite: ptr is declared uninitialised at the top of mmap_fdt() and
is only assigned by the mmap() call on line 90. The earlier error
paths (open(), fstat(), ftruncate()) all goto err before ptr has been
written, so this new check reads an indeterminate value - undefined
behaviour, and may call munmap() on garbage.

Please initialise it at declaration:

   void *ptr = MAP_FAILED;

sbuf->st_size is only valid after fstat() has succeeded, but
MAP_FAILED as the sentinel covers that, since ptr only becomes
non-MAP_FAILED after fstat() and (optionally) ftruncate() have
populated sbuf->st_size.

BTW, since mmap_fdt() is only used by short-lived host tools (mkimage,
fit_info, fit_check_sign, etc) that exit shortly after, the kernel
reclaims the mapping anyway - this is a static-analysis cleanup rather
than a real leak. Worth mentioning in the commit message.

Regards,
Simon
