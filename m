Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486B4EF48DF
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 08:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F4483015;
	Fri, 13 Feb 2026 09:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HTzl+39C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E2483AA9; Fri, 13 Feb 2026 09:38:00 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C862680FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64aedd812baso635634d50.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 00:37:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770971876; cv=none;
 d=google.com; s=arc-20240605;
 b=UIS/x6tWDP9gymavyYcsrFBRCFcF7DKl5dkgffzVRPrHXlhHoQxIcN870adWpqwrQ9
 Ibbz8NmETm2yVpOihBR2FnF4cBJ01bP+ztFGn9YfD8xf0HQgenNX/9LMWPx6xo0GCq4p
 6ATayEYKuHnvpkmLAAuAjrDnkXL0dkAUb6FjzdmQ4krxZlYdUiMzFjFX/84SAfPq/MZs
 cOrK3YL18xkG9R8NwsF3al9P3EJrwReiANBatM0T9SQUmkbFS4GQGWA6jrHEeqDjcrwq
 4eSNkzoK0imPALTvgZrYGmE7CTfdL1ksk/gbkud1qoqsJ5ccscN8N6lJ4Tv8uKl7YA0O
 UnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F63iXzlBOC+uFoyEo0wU69RWirib7gBeN0o/YmgUQxY=;
 fh=vyfbts51IeL9YqiXEXChvJnWUKQFbZdi8gERlNYTnqw=;
 b=R5gwWTfjzHlmLALDfxPtQ7IFuljPsk9ydxFS8OYBpwnENwwhSqzwQlDyZrCd4e2pvs
 To3SLfOyEAThRZ6m/ny1ltRpyUVIWOhGU3UXoPIdkF+IYHWq708qwZMIY7f6Z28N88CO
 yKHgB3SlVcuTw88/PS3qkSgJcy6/4klSH107cAxBcBiV1hBt5vwRk9tI/o/6NzS98Mcz
 C/juu70tSgK+g7fpt49eAGcXSILs0ysKVBuH+OXxAH1Rb4raopFWhtc7ipotLLUIZqrW
 mu5gJ3l80hciiHP3/SglHpaou7msk5d5rmCp5WiTAgV2T4OOLiOEZUEu2gObSmmj+NKT
 JA/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770971876; x=1771576676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F63iXzlBOC+uFoyEo0wU69RWirib7gBeN0o/YmgUQxY=;
 b=HTzl+39CSISlgFYUCchGlKQMxdPYRiXPg7+bwoUAaXGJ5XUUv8QSpwaAx0uD1g4TXn
 CWjeJxWibgOX4yLDiz0d+U6c/yAenz5c+I7+3jBDOeZOse72yVkA3Czqzf+F0+crQepC
 hE9DHuoM9dnp8pLoxktfzk+mviyxSyX+HH8geas5BuRmSyVDs/CQQKDNqWnySLeAyqM+
 A72q0bxZLfdHIi/95/b6kkJmxSINwikm3SLBBnWKnLEaiuG8hcDrFiygVkcrMO6xstB7
 kev9aHVwcsq/a21ByIFlD93ZHd3yaguAFZGV6CDGW31sji7A63Ojl4cbt0VQc80chTfF
 Qoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770971876; x=1771576676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F63iXzlBOC+uFoyEo0wU69RWirib7gBeN0o/YmgUQxY=;
 b=sthTumuNDyhR4v2vvkULb8RaxsKTqj9g1wCZ06fW6jSZN5vFm/iPPprvRvznGCMIPm
 KUpmJFs8vObazchRjo7NbVHO37/zkLuygS4MATLYl2Vi3ZsUFsLUUF8o8rZrnoOZrglS
 WX7+nl4C3WD8iWBAbxHyXnZS+LjBRKBQPM60eXfZbdfA/yZvLfUAIQi+Yi7EJpxP5CDV
 e8ZN+PBBvhQwxwzu/1C3wFp+NXbNdLz2rKodgH0knEDcTMwX3pUSzBcUBqb834QNSZlB
 IS1m2GqT8blMGJFX8BPUql4Xs2wOsGRRIQHZ3rE4TQEVNGMQ8ejFzPMB6LNX6hYIRloJ
 mSfQ==
X-Gm-Message-State: AOJu0YwVyRnqlU9lm94N1b/AqyjEMK7Gqt/SuxhkMfYv4rQKtFfLzKpr
 I0GRJx1ra7LCBkGLRczmt0+ctdybPtWEJY6CayFEO4kVkNdubBzUnyWgo9FzbtSFuTBEEEJNruw
 EpEjsEe0hiEYGwYX7Ysn9ApHqVJ6KqN1sKNJ95siqqA==
X-Gm-Gg: AZuq6aI3R5ChSUuhm395ldmi6z13xwh7AuaV1razHxMzoHKbzcrLHIstyC7T4UJgGQK
 udNg0HK61WfkTr5S5j/nEIr0HBmyc2wfRPzIybRitHhfDU8eESMgsj/2ExnnnhFArV1CUKn+ZOi
 ZRj5ONbTe2UBAlmBzvaNmGNLRqWy2kf2IG9tvr15y0VOACjJF8GnP4t1eZ7RiNstMqbANPMv/Lg
 VOQJkEErAqH/7bBgdMXMuQ8wTCgsIU/CvhJQJX4+lYC1cBL/j8cbWm6GE/rLA2D7BNswNM2PS5a
 GBbZR+Itb2E9sb2CKRjuCDwhyzMSHK8X0W4k9KrzWGtFdul2V/9Hg148y6x1f8CzXkIyHFgwKkk
 F+1Pgck8OH0ip/raaMFwOQ9Fh0EBhwVouFid0UkObtZdhIwcqSel7u3oMXINJZl0/Obnrcfsq3p
 mcwAcE93+cBHJP9Ufe9KjghlsTn0noeR+5YqpqhTu1FU/2XpMW+CACg69oueYBACJ7StYvFJSum
 g/ZOC9OPxbZ1yIzwBUS2djbUnD1lzMdlJ5vgoOxdcSFDQ0CkC5CZf+75YKdL7vrqJlu7aoBMEj9
 wrnZnJQx8mF114FbJCD/uw9MyaDH3bRaneABOwS5uOa/
X-Received: by 2002:a53:e20c:0:b0:649:612e:3f38 with SMTP id
 956f58d0204a3-64c19b86b6cmr469453d50.93.1770971876497; Fri, 13 Feb 2026
 00:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-2-javierm@redhat.com>
In-Reply-To: <20260212204511.619392-2-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 10:37:20 +0200
X-Gm-Features: AZwV_Qi-RzBKk-kMCcTywT_-XKgqNNfpy7ifKWNQv1h46Y5h26sUaklVVw5Gl2s
Message-ID: <CAC_iWjLuyS8Lz4qFpw8SyhF0RdNOw8xE9pEcaxGTvrnVV-v07A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] disk: part_dos: Move header to the main include
 directory
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, Tom Rini <trini@konsulko.com>
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

On Thu, 12 Feb 2026 at 22:45, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> There are two different struct definitions for MBR partition table
> entries: one in part_dos.h and a nearly identical one in part_efi.h.
>
> To enable future consolidation of these two structures, move part_dos.h
> to the main include directory. This makes it accessible from other parts
> of the codebase, such as part_efi.h, and is the first step toward removing
> the redundant definition.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v1)
>
>  disk/part_dos.c              | 2 +-
>  {disk => include}/part_dos.h | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename {disk => include}/part_dos.h (100%)
>
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 18dd35c9b98e..2545cc6bf5d2 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -19,7 +19,7 @@
>  #include <vsprintf.h>
>  #include <asm/unaligned.h>
>  #include <linux/compiler.h>
> -#include "part_dos.h"
> +#include <part_dos.h>
>  #include <part.h>
>
>  #define DOS_PART_DEFAULT_SECTOR 512
> diff --git a/disk/part_dos.h b/include/part_dos.h
> similarity index 100%
> rename from disk/part_dos.h
> rename to include/part_dos.h
> --
> 2.53.0
>
