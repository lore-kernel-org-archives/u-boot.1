Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2563C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 20:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECB988BDF;
	Wed,  7 Aug 2024 22:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UMmSDJCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E9988BE6; Wed,  7 Aug 2024 22:52:15 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580F088113
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 22:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b7a36f26f3so11925996d6.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723063932; x=1723668732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zK+M8Yji5KJ5bW8iXOV6dRaQkW8S+R3YlJqzGJpJ08E=;
 b=UMmSDJCjL0UXVaSNA6eQJgo0p0/7CxcjuVAGNfrfrYZcDOTdnI0cWab9W8LlnZlS4E
 fzzEVjuqo03XKIgq+pHm7zxG2ijzs6HBiYhS/403WnBBxg+J1PlqsTYXYev4dEoRi13Q
 LXPc/a0b7CP9LpC/bD0baoTl4/UjiB0b2rM+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723063932; x=1723668732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zK+M8Yji5KJ5bW8iXOV6dRaQkW8S+R3YlJqzGJpJ08E=;
 b=GwUjQFTyDMJQp7cqw+AXD1BP6d84g0YKFqUNpy05sg66MnFZnNQzdxPxc1PMCHzMR7
 uGDOyzNtMpuWNlwru8yaf/QI9mpGsy4oVlH2+rjHv9HSoAHCgoYChOquv03p/ea1BIUl
 KzFrN5Eh3YsOWx/P9sCw82rdc2QVH/qKLhqQi70m654XBtE4xQUP2gvyzV+VeK955ZYS
 5FOEoawmnm7odov8byUUW1JQA8nedimIfE3zR9Y4j56tG+yzGXTm1Uew/mh9XxkHE4dO
 b/uvo6hnCskm5yK1dHS9S7JSiqbWlz8PivbPL7pMaMIuyUueC+YZ8xnXejEPPu3H2aY0
 uFWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd+1cNtRQib3pBKCEQYHTHv1cNRBgkQNnFA1NWUw1yOyMvRHaNpIk5WtABcGNWV6wcqvn5L3X+UMq8BOuqweVFjnJBtw==
X-Gm-Message-State: AOJu0Yxyc1K5AgKne7wykPYFPetKY4nB7s/k74eB8QwefHMWMDYWFwIk
 Pr7z4HYRl5vb/frjLqvHaiiKOn9NuC989HpPGHRIextet107KR6IqOOujqb0c7Dil2evEtu2qod
 Gy37m7coZ77YqeObbpnfVpq+N3RVNP9C6WYlx
X-Google-Smtp-Source: AGHT+IF+u+kbiVZSe348Na2tm3RKxwDYBZuCgsmE51DG9hgucCwQHd1NTdqHKBUuELiViZdEx2d3a0mYwZ+tFH5JY3M=
X-Received: by 2002:a05:6214:2e43:b0:6bb:9935:8eb9 with SMTP id
 6a1803df08f44-6bbbbdc3f06mr66541356d6.2.1723063932228; Wed, 07 Aug 2024
 13:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjw=WEQsPdxoxjdZ980Vq4wvb1tuvFnevOiVBZNARGGJA@mail.gmail.com>
 <dde17dfb-bf49-4b79-906a-54127c6f0e87@canonical.com>
In-Reply-To: <dde17dfb-bf49-4b79-906a-54127c6f0e87@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 14:52:01 -0600
Message-ID: <CAFLszThdWBVC0aR1kTO0-DGCFAUuq5dqaH2qYxME4jZV++b-yA@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: set correct block device name in
 set_efi_bootdev()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Wed, 7 Aug 2024 at 08:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 07.08.24 16:36, Simon Glass wrote:
> > On Tue, 6 Aug 2024 at 18:13, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> For SATA devices the class name is 'ahci' but the block device name is
> >> 'sata'.
> >>
> >> Use function blk_get_uclass_name() to retrieve the correct string.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   boot/bootmeth_efi.c | 7 +++----
> >>   1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Hmm I suppose I need to do another round to try to get rid of
> > blk_desc->uclass_id
>
> efi_set_bootdev() should take a udevice in future.
>
> We are converting to string and later back to device before we create a
> device-path. This makes little sense.

Yes indeed. I've added it to my list.

Regards,
Simon
