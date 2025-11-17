Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFA5CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 17:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D756783C02;
	Mon, 17 Nov 2025 18:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V83wydDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D095B83C04; Mon, 17 Nov 2025 18:04:35 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3A0B83BFE
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 18:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso559721466b.3
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763399073; x=1764003873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aAS8LuphrYusWP0XrFRtLq/j5Fi48MzkOkS7B1IKwRg=;
 b=V83wydDXREh0PYl4LYZeptOrqDwUtrBxADJ9qnV2lUJ3RHd/Qi/j3JmfT7tMln5mfl
 ovh5MJ8VY9wHTezul+k9WsX+xY+sKfucw4YWHwHZv1Izjdnd2tJYdp9wcp4/K+oH7Odm
 29ixO2jfXcSOlCFjTQ/rYuXam9OkaIHfO7oFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399073; x=1764003873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAS8LuphrYusWP0XrFRtLq/j5Fi48MzkOkS7B1IKwRg=;
 b=OaaagwINAd96fpSqI+LpeEa7giUroT13U+6LDlWj7OML1V98S6FI46nZAsDA9sYKJo
 HfYnc1zAf6wHRmaWFNUKoTQwOSmZkVZhajDiUVBtZSOuk+0D9LURflqKpLgDQVlzp3nm
 ouZMtuzBqn510ukmgBq1giXNTbzgJVHz6UNcZHm4haXd+4U56r+uXxLx5iy9KIUwNvYx
 rrZW9zOQcUT++l/ojT4WVQ27+D/uvVmsATCoK2Xv0b1cN0/g2PXoyg0ORbmswB5mzBGe
 tsB45XpByeezZFIzLvuVrMgaZZVy1bfAmjGfd8uUTJie/vVXNjid35r/lFbzI+peGoFF
 XwHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVct70fRaznf9IHjaweTQNQveqNNQrIDc2HnYXZMl+G9aIJTRgP1DkxEAKzNwr0HB7wmHz04pY=@lists.denx.de
X-Gm-Message-State: AOJu0YwgPdO1I/TDwjTKkhzHODU4a1lOrNoqGzoNbeIy6iLLmpulPpFj
 Q4DFelEQw9ahpi3ddAgFTZOTTkxP3L+9cnW6nE2sHBW07GjwIt6CO7AOyl/N7Ao/e/Td1nzteYu
 rflnWMsG/+nu2MGO4ZiuFVuKfBXlWzYhvD426iBuj
X-Gm-Gg: ASbGncuGi3Ce2qJbi/3jRP3wvkrkX6M6tMXbO3xTfEWGW/A7i9BZaQxjtiJlayxkJdu
 MIEW0b1zeRpWQaOZIKb0Hzy0ktIx5GaLxNTO+BSNeJ3i3V6M6uoUIvsem1IGTUcjSLHWqeMG7bE
 hG8EbyDMLpJddsiCFyi3QiNZASAbVjcrGw15HqL/JX5nBZDshkUm0cFr16pYnVnCsFALjz3GPhg
 7jkj5Dfdcb0qJBajxxUSjLOd+cbh5QJ00QEITIs5ENWEh4uzHEc1UjG35m0e4sT9nqAow==
X-Google-Smtp-Source: AGHT+IGg+WsdjLsKKqo4F6ZMyzf1kYV87FXMzJO+59MRvsr1S4lEWtLicJnimk20DZQI+tMRUB6nLHlYX9kLX8hUuNw=
X-Received: by 2002:a17:907:3f0a:b0:b6d:2c75:3c57 with SMTP id
 a640c23a62f3a-b736793d1c3mr1313938666b.39.1763399073302; Mon, 17 Nov 2025
 09:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
 <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
 <CAFLszThNLoS7j0pe_8G93dHtX91j331DCBiUgWpUPXi4Oi2-9w@mail.gmail.com>
 <c5300029-9bab-4a06-b426-ccc443d0928c@mailbox.org>
In-Reply-To: <c5300029-9bab-4a06-b426-ccc443d0928c@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Nov 2025 10:04:20 -0700
X-Gm-Features: AWmQ_bk1eG68FGbG0dhAwlpk0fg88z-eiGLzsvF3I64xc8o7f2FJP-InNVMqVnQ
Message-ID: <CAFLszTiV2jTWcWU+27QxX82Ap9YnhZNTK1sXrFvF_e53ydc5_g@mail.gmail.com>
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

Hi Marek,

On Sat, 15 Nov 2025 at 17:20, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/13/25 11:46 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >>> The problem should be fixed higher up, in its callers, etc. For one
> >>> thing, the caller knows whether it is a DT or not, so putting this
> >>> logic here is messy. See boot_get_fdt_fit()
> >>
> >> This is triggered by a fitImage with DT embedded in that fitImage as
> >> non-external-data. That DT is at 4-byte aligned address, so how can the
> >> caller deal with it ? The caller gets a fitImage, which itself is at
> >> 8-byte aligned address, but the DT in it is not at 8-byte aligned
> >> address, so that DT has to be relocated somehow and that happens here.
> >
> > OK, but don't put the code in here...see boot_get_fdt_fit(). But even
> > then, why does it matter where the FDT is?
>
> The FDT has to be at 8-byte aligned offset.
>
> > We are going to use
> > fdt_openinto() at some point and put it elsewhere, right, so we can do
> > pre-boot fixups?
>
> Look at the fit load code, cca. 10 lines below, it checks the FDT for
> validity using fdt_check_header() . At that point, the FDT must be at
> 8-byte aligned address already:
>
> 2294         } else if (load_op != FIT_LOAD_IGNORED && image_type ==
> IH_TYPE_FLATDT &&
> 2295                    ((uintptr_t)buf & 7)) {
> 2296                 loadbuf = memalign(8, len);
> 2297                 load = map_to_sysmem(loadbuf);
> 2298                 memcpy(loadbuf, buf, len);
>
> ...
>
> 2309         /* verify that image data is a proper FDT blob */
> 2310         if (load_op != FIT_LOAD_IGNORED && image_type ==
> IH_TYPE_FLATDT &&
> 2311             fdt_check_header(loadbuf)) { <----------------- this
> 2312                 puts("Subimage data is not a FDT\n");
> 2313                 return -ENOEXEC;
> 2314         }
>
> > Perhaps we should deprecate FITs with internal data, too?
> We cannot break compatibility and stop supporting old fitImage, so this
> is irrelevant here.

OK, so please create a function which can detect an FDT header without
it being aligned, like the other code you wrote. Then it will be safe
to call that here, even if unaligned.

Regards,
Simon
