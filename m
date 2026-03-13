Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB820106FD87
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 07:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 935F783F53;
	Fri, 13 Mar 2026 08:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oRqH8PHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295E983F86; Fri, 13 Mar 2026 08:15:02 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F029883DB6
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so2208789d50.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 00:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773386097; cv=none;
 d=google.com; s=arc-20240605;
 b=BPx1wBisdTUcbLnqG2F4LoaQHkMxVRHWXEmLkJHAxVzAzCK25bURbnSDUcWQtN31O7
 HcQv4PggK7TjOdKzvk2YCPQE9vyJhiG1HHeN/CdOCfQtKN42JxPB4/vLwZlW9y7QorD0
 c/Hodx5mrtcriFpn200KD78ximB5VJ29N+EvLkmIkUq5YRFSUVkYFqlnV7icYLixULnN
 4dm49HPCMTwNIyy8tLT1LVIrtB3RyN42wGASfzVNjcbQMwN+WrLjk0c0KCmYdL+IusAi
 g8zrgzmouZq+sivwUJHefRUA/v9L74wpSQk9NtxHnZ8f4wUdSoOoPZxNx4K034KfSxEI
 gcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=truOW1ivN7ggBsg7Ocsz1LqVHZG1wmeGCnjygW5oeG4=;
 fh=x9bXTO8xd2dgmqqxRQrZ35I7dUlPvx4vojC8FlwoSX4=;
 b=c3FMUxxpRjxCfMRiBoa7EKUwyPbcn60v5FVHDmHUiainizsfkbF22yUEUBif+hG67z
 PdPnO3le/bSeSgon0HqqRXaDpfQTAq3WOWi0vHxIL3IZdn9ok6chZdTT3cpePMz9HnUD
 XCxCxXlFlUIyH6/S8DuWKXiyiX5z3fG9G8gz4CVDyEtuBClZZMxjTLVTVK4F9zqR43V7
 17aTlDFADaJJvwgEEeYIl8jABAiLtc0DjysVGCk8gf0HVV/IOviinsWqWrPWOp7/cS/9
 lGmX3KEINinaRqojQTQ2y2Zbuzc94Zc1GUwt3Kos0QuphvTsYsO4BmxzlG0QCrewZdXy
 TsJQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773386097; x=1773990897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=truOW1ivN7ggBsg7Ocsz1LqVHZG1wmeGCnjygW5oeG4=;
 b=oRqH8PHUDz0oodRkUUyiaf1lrWc8PPf1xDotXWUXpPYqrC57gZDBKurECNy3ViRqQZ
 OOG8NYnmz0hI0t+h9SLBTF3+lselFFyBsX6ArCs5WJnaV+Z7cR99rdfaHc0ETVpGd0Qj
 hU2VqA1lUXueBjalWkCYxI3i1HX1H45Ep1LIqXz2vTt0bNrHaWQANwzvvlcCGI81c80I
 DAWT86B6r5bXb5EFZMvhFCt3/NNoRGNgbydSV8YRaUe9t9YDPgLCkfZu1G8jyCUFHPKA
 fdpTx9QEwQlVmWgsSOujn551Y6f48o4b6+PH1o9OHRn2epvg58Qj0zzLvCAd+1LnQcuW
 tG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773386097; x=1773990897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=truOW1ivN7ggBsg7Ocsz1LqVHZG1wmeGCnjygW5oeG4=;
 b=F0ZrXI/Pk7SSI6mWGx2hGI3F5zvyA1wthIUGG+nYmFdENaaE8cjJT2GQ0MQyp1fYMK
 muqGps4EAyMXxy64yCQoQwibO860C/vnyp3oKg6B4nV0Fu/rHqHPJJu43apjqSm2HHrw
 xv4DahqwOnmm6z7YWrVuX8Gq8YlF6d8r9yqHy1AgkjUYFFjSBrFPKTMWRuGxVcD0kXlk
 bPW9BDhy3UmBQvv4QsQY4rvGf/gPYafC3QcHOiSP9k10WEAlQ8c5r0MGdBNjwseO1pzb
 YDjK7DYGQ6aMaGmZ2o6fC3aeW7GP8keLec6f6iBxp5IZkVgWR2ohBj2bK0aoS6/jZuBp
 P7ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSVCmRejGSHnhlHKK1MyHkVlsSLDoG00u4YX89On6BXCUO9BXFi7SJ8BAPnLJXIH7ZRKof7R0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0wdJMu43uXRujEv+Fcs/wRbipqSA2Gs/QeiFlpGXDPWidg8Ww
 akhmhhg2MVrIT34dDwjPddwt3rUIXhtzfQGlYKg5N/D8iNsCPuOh7nCKuQuaZkK319sXAI2T5ko
 SiX7bZpL6xO/o+FYrW3mINRor8cpkb9cYSDJBelLQ6Q==
X-Gm-Gg: ATEYQzw4qgwujsbW7GuCBy4tbmnVdqEDYDI2SQS7ZWM0nElaBQvCEdwXGACpK8/3BI3
 ZbGNr+lQfqwh1SJ9Gse0qu5T/4U8hBD2qxrSA++HPLAKgxmRt+r9WL7Vd6kDQ3eAjD4omuO0coX
 ujL0odeUAwMjEIkJTyj5aTUx/IYA9kMI+IeGniIwcY6ljj58ca8pXie16TGweh12IIQJ6TGzkJQ
 c6gzeZ0fql789gLC0SXFwlVnXw/kO/cPkmIH40JNw6pWxJyIOezBj++Uexe9XuGQuXFFViRyiPs
 47vbBicwd8xTfslVunNJqpLy5c2gAS+d3ZnT9a5uaL+vgErD/62Ju6BNImQ6yLW8N4nwcjeOjkQ
 WClcPLyzxW4vOWm8gG0bPO/omHwWURTBmmcRY6OO+QNuPBrpWSYjDMU4ZOOxCRgpnZBwvC3OwBk
 Uk1hUss0uZL+e+NghPjIvqB416RYNyQIvUdi2ptVZOmWAKTFYmm7CTH7mWapnJFOq2HeUoBWPtU
 p1HbzjVE3gcBXj5JMG4o5E+OMzHeMjXY+j9/48ORjP9OqXS9jy8QFFwEJ5KuV1oUjGnBd9+z66v
 B6KEkg+GY2uAIVzVEA3OcsN/0e0GLaahTaztvjFQ3oaO
X-Received: by 2002:a53:ecde:0:b0:64c:acdd:f165 with SMTP id
 956f58d0204a3-64e6281abd7mr1715067d50.25.1773386096671; Fri, 13 Mar 2026
 00:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260311173033.10002-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260311173033.10002-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Mar 2026 09:14:20 +0200
X-Gm-Features: AaiRm51C59BtNDiwHU7iVUE34YPydjmEgr5vESi7smNv--LCfpBR4JWs6g8IXBI
Message-ID: <CAC_iWjLtu-WJsNgWA_GDECzo+VHP9jFjDLXo-1bR7AnbRSV3XQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: avoid buffer overrun in efi_var_restore()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Michal Simek <michal.simek@amd.com>, Shantur Rathore <i@shantur.com>,
 u-boot@lists.denx.de
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

On Wed, 11 Mar 2026 at 19:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The value of buf->length comes from outside U-Boot and may be incorrect.
> We must avoid to overrun our internal buffer for excessive values.
>
> If buf->length is shorter than the variable file header, the variable
> file is invalid.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_var_common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index 5ea1688dca3..c89a4fce4ff 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -497,6 +497,8 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
>         efi_status_t ret;
>
>         if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
> +           buf->length > EFI_VAR_BUF_SIZE ||
> +           buf->length < sizeof(struct efi_var_file) ||
>             buf->crc32 != crc32(0, (u8 *)buf->var,
>                                 buf->length - sizeof(struct efi_var_file))) {
>                 log_err("Invalid EFI variables file\n");
> --
> 2.53.0
>
