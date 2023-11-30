Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13192C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F294C87632;
	Thu, 30 Nov 2023 03:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BVddVUHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E27EA86C47; Thu, 30 Nov 2023 03:45:54 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D2D98715C
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9fffa4c4f43so55539966b.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312350; x=1701917150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EuF3JrvZi+FZoOTQuYUu5HFx8INO4MdQD11iTRUjlbg=;
 b=BVddVUHQpYzmcRclYbt2ixYFw/DWuZBzUborSYpRXgK0ZibEbazZaFvD23tEjIFbtc
 8EOy3ZSCfdroAZA0bywT+JOlAUcDDn6nekJKrNgDBYe81b0sbtWM5lJqph0jrot00Pdu
 x0ghgfFVRhEgOzotFg8d1sA8sHJeI+KNT3CdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312350; x=1701917150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EuF3JrvZi+FZoOTQuYUu5HFx8INO4MdQD11iTRUjlbg=;
 b=KiNbcS5rYU6cew8lKeRLCQ8on83j1VbONogSHjhU/xSgg0/sSBUpZXDfLlKVsjSGZV
 TEdeS1qtgj4nnw/8QSLMODh0pFlmjhcRUllJme7TrW+o5FQzuUd/7mXhlX3tQgHxXI3P
 HNzOK8rDdnOgwGtwTqP93ovFS01KJTsRY4tVNtspLutZglJAFjbvQW8qYTE8t+tgq/of
 f2QveCM8tCSlxgAUhupDjvt6Zh62Ca9TLjROWCJFL3HI8GeUQUH3tZBx9/Nlcfs6Cf7P
 TRp57k5j10DeBy/5xXiwDa7PT/PtLNQ09kuoqnkY7G00B4ODpUzATMeshpmH7CqYoaWz
 oE8w==
X-Gm-Message-State: AOJu0Yw2UToHHwRfSp5jBZ+2CsseDwgsQBok1j1wGQcby0S6TBvjFAYS
 5Ojx1rYMBS8GkFuMSBhH0X+AD6VubvOjub4wUqb6Gg==
X-Google-Smtp-Source: AGHT+IGMCn9m3UjeL7/nRrdTBcUz+b52LwJKnV6U7bN2/K07lh8FY9yAfUscg6OsS3ANUQNFaAokWb8W9tjyN2dD5Xw=
X-Received: by 2002:a17:907:2da9:b0:9fe:38b7:4278 with SMTP id
 gt41-20020a1709072da900b009fe38b74278mr19898303ejc.16.1701312349886; Wed, 29
 Nov 2023 18:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-9-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-9-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:34 -0700
Message-ID: <CAPnjgZ2gWQm_bNDqWviVBpDy8da9RsQDUcLHBdw=FM76O9eYkQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] display_options: Clean up headers
To: Tom Rini <trini@konsulko.com>
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

On Wed, 22 Nov 2023 at 06:14, Tom Rini <trini@konsulko.com> wrote:
>
> In include/display_options.h we cannot include ourself, but do need
> <linux/types.h> directly. Then in lib/display_options.c we further clean
> the list to remove common.h.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  include/display_options.h | 3 ++-
>  lib/display_options.c     | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
