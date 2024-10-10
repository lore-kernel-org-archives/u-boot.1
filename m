Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D48CFC5F3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D458925B;
	Thu, 10 Oct 2024 20:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XWr1tIXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808CD89262; Thu, 10 Oct 2024 20:50:29 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605D3891D8
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e2903a48ef7so1159257276.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728586226; x=1729191026; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XaIGgjAhKHl4+ZlwYfMiAIPqs6Z0rtEq/GLjsrVaxUE=;
 b=XWr1tIXt0WDLBuuND4teGeak3DcmVKjGZ/+IG8AAtQTjUe56ZTqzpOSSHRGDr9cPBC
 ZNSkY5jSqKd5BNpN9/zVzX5TQkIraPqodTrA46yVvaEeTD11t6mURpiKR3LCfp+kDLKu
 T3WuP9dQV+avq8No6ojO9Ndz6bFeUJCyrPj/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728586226; x=1729191026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XaIGgjAhKHl4+ZlwYfMiAIPqs6Z0rtEq/GLjsrVaxUE=;
 b=vrN/NhUAqtmfHyxme0atzxB8CJ5YA+9QgO7u5RjGg2G0rfQnYeRZyUT+IjE/bCYq4D
 I3JokQvcOcOBKv0SMgl9RoGKKbOJEhM4C4TvMxGWve2nEMAP3HGoOgSr5/aZlSa8lyy1
 gGRS1bE6qYQx0duw3RlZ1++yNd9nLUb/Er5495k2J1GvIjcWWwM0qQ7GvC7sSEtWmC2i
 NdXWcG4L5ndi4Qe6L5vQsuD2ncJ63bwSZSiQLqwl02sSlhfk4Pp3m0OKaRiEMmcziXIn
 OCTfkrjbwmN60r+v4L+E86FAGmJogXPfFOC/ob2ooicbcRFNRDlHJ3iD5gc68Wk6Y0fU
 RiIA==
X-Gm-Message-State: AOJu0YwKwmNjV3XsArKsaGue6xG51tslN8bP8PFF29LqHLEPbHeIMmB5
 HAArfIfQvJ+UYQho1RKSOmTrlKXkyS+Wz8g8oXldcRdlCKgOE7qvbumq4guCQ8wYsCLJrgBPsrL
 p4U2bpQlALjG9LjC0amgdbxBi9/P/54cJPlGX
X-Google-Smtp-Source: AGHT+IFp1PxtUeAMTIqiYuesdzZH5eUzklHj6F0xafvSRtQHT845BeCtmcGXrlk1NSkl6Zo92PRJ7xvySJHAfntntGY=
X-Received: by 2002:a05:6902:2807:b0:e29:24c:1d82 with SMTP id
 3f1490d57ef6-e2916a165c3mr646180276.38.1728586226065; Thu, 10 Oct 2024
 11:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240104232542.322248-1-bmeng@tinylab.org>
In-Reply-To: <20240104232542.322248-1-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Oct 2024 12:50:15 -0600
Message-ID: <CAFLszTjTZ-o0Ohg6u-dmiU5P=M6dUmPLWmTjhY10J9WHLO7XTg@mail.gmail.com>
Subject: Re: [PATCH] doc: coreboot: Update stale graphics enabling instructions
To: Bin Meng <bmeng@tinylab.org>
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

On Thu, 4 Jan 2024 at 16:25, Bin Meng <bmeng@tinylab.org> wrote:
>
> From: Bin Meng <bmeng.cn@gmail.com>
>
> With latest coreboot (e.g.: v4.22.01), the instructions to enable
> graphics support has changed. Refresh the doc.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
>  doc/board/coreboot/coreboot.rst | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
> index f2c6452b5b..8408461617 100644
> --- a/doc/board/coreboot/coreboot.rst
> +++ b/doc/board/coreboot/coreboot.rst
> @@ -32,10 +32,9 @@ of _x86boot_start (in arch/x86/cpu/start.S).
>  If you want to use ELF as the coreboot payload, change U-Boot configuration to
>  use CONFIG_OF_EMBED instead of CONFIG_OF_SEPARATE.
>
> -To enable video you must enable these options in coreboot:
> +To enable video you must enable CONFIG_GENERIC_LINEAR_FRAMEBUFFER in coreboot:
>
> -   - Set framebuffer graphics resolution (1280x1024 32k-color (1:5:5))
> -   - Keep VESA framebuffer
> +   - Devices->Display->Framebuffer mode->Linear "high resolution" framebuffer
>
>  At present it seems that for Minnowboard Max, coreboot does not pass through
>  the video information correctly (it always says the resolution is 0x0). This
> @@ -184,9 +183,9 @@ boot as a coreboot payload, based on a known-good build of coreboot.
>
>  To update the `coreboot.rom` file which is used:
>
> -#. Build coreboot with `CONFIG_LINEAR_FRAMEBUFFER=y`. If using `make menuconfig`
> -   this is under
> -   `Devices ->Display->Framebuffer mode->Linear "high resolution" framebuffer`.
> +#. Build coreboot with `CONFIG_GENERIC_LINEAR_FRAMEBUFFER=y`. If using
> +  `make menuconfig`, this is under
> +  `Devices->Display->Framebuffer mode->Linear "high resolution" framebuffer`.
>
>  #. Compress the resulting `coreboot.rom`::
>
> --
> 2.34.1
>
