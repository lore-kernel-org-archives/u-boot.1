Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9982E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E38C8027E;
	Wed, 11 Dec 2024 16:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oPhmD44c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B34802E6; Wed, 11 Dec 2024 16:15:34 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E53F80212
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e398484b60bso5536341276.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733930131; x=1734534931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZBIZl46X6ck4ubJ+1d/eyW5ljfZDsrPlzvu+cpwh14=;
 b=oPhmD44cHSZZBh+otdCm4B/BTFvyeemcxMYuX8MYXzD79NJoB+8dJl0++Wj30quw0E
 +fLkByQhj4aGsPoWXZdCyPrBinnw5VGIvR5BB9ajyNxL8jtz6v3X1HZ0kBAc1xZSOYzs
 Pn45r7z9Jxi/UyGd4DGRwh9FWAI+ow6373Nci9f7HPH9YV/kaHMWv+99MK1GiXMdJ0Wy
 34/cdDYtlnJv6sFqsTaJc6VklflH0uX6bzQtWq+AnQyf7UiM647Qt6SscUFIGKZskN7v
 DMOaPHUat4PjNUc0jQ21cSk4fAS0kBpR/R0Kc8gOy74RRHy6n6Lx0+80Z5smURcMXihL
 OtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930131; x=1734534931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ZBIZl46X6ck4ubJ+1d/eyW5ljfZDsrPlzvu+cpwh14=;
 b=CEPeY9fj2odObDtMzDbaxiX7ZDIL/jnyrGpfUkDyE5hN2i1JcHe+1FTLHfplXGlFxX
 AIOHoexhKqPW3RNS/HwTgrRr/GmLbG7ffpxkd+bjnDyyeTiDR7c9SsrpKbUu0a7hTjls
 nce8rzQN2aoZ/vGdPl+KvVXLiPRUdicKsC8rB2JBNis5B2axSnS2skuC7JKP4i2IS86H
 fhqEXynRgQCS9Y/21QLVvYddIT/H/4AGTBZVPeAEUKyOHjU9DGKUjEQmOqB3vGNL8Tm+
 rp8xaor+Ka6Aq31sOYA6Ea5x5xUNskvo8GIzrck2hTXc1qC5a+3o84UVLQ3VS1AywyOd
 YRmA==
X-Gm-Message-State: AOJu0YxCOGi0Pmj9tdjLFqVej8LbE21EQWe8OkoQvRz9b7pvAASsV39B
 bojM8sYN0bbsu4Sdkn2w58VrlqgcFVIQ9/JQV+Pa/a8Duqk97RcvQ2817Gsbri6r/mZKhzb1gVe
 Fi1j0MCEbjRutt+SnZT+ldB4TfhAYvIhffkIJEyUIm5U8mNad
X-Gm-Gg: ASbGncuLByxS4zl1qThq5JZvV+/QB7C7xKKkU0peOlj2zvBUJvIwaee1QKHJA4lfIis
 37JPtU7JB1VZ3xFEJcKHQ8Og6r+v6GMfaDkc=
X-Google-Smtp-Source: AGHT+IHetybf5irhSAy8LMOFLA3OrPUNEAoPDdBuaysyOpVICHnNjYo3z7W9cDd4ip9hrpuSR8an8mbL0vscyoPIiw8=
X-Received: by 2002:a05:6902:1247:b0:e39:92ec:b5f6 with SMTP id
 3f1490d57ef6-e3ca053c0b7mr185871276.41.1733930130941; Wed, 11 Dec 2024
 07:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-13-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-13-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 17:14:55 +0200
Message-ID: <CAC_iWjKt36c6KK7Sv0H8U5zP_i8Wys8v9UDdLxQ-Menh5Bm4pg@mail.gmail.com>
Subject: Re: [PATCH v5 12/23] efi_loader: Avoid assigning desc in
 efi_mem_carve_out()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Rather than assigning desc and then changing two fields, assign all four
> fields, for clarity.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 4c0fd0c5dca..f3aaa0e9288 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -268,9 +268,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>         newmap = calloc(1, sizeof(*newmap));
>         if (!newmap)
>                 return EFI_CARVE_OUT_OF_RESOURCES;
> -       newmap->desc = map->desc;
> +       newmap->desc.type = map->desc.type;
>         newmap->desc.physical_start = carve_start;

virtual start needs to be assigned if you want to do that as well. But
what we have is fine really

Thanks
/Ilias
>         newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
> +       newmap->desc.attribute = map->desc.attribute;
>         /* Insert before current entry (descending address order) */
>         list_add_tail(&newmap->link, &map->link);
>
> --
> 2.34.1
>
