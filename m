Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE91D3E2DE
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 08:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C91368907D;
	Tue, 29 Oct 2024 09:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dmv/dTvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E939C890D1; Tue, 29 Oct 2024 09:00:49 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B21188DEF
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cd76c513cso47013485ad.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730188846; x=1730793646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qXy+lNEtrc8AcOb6MwaM6rgZJR9Gq9uMl3UWB4oK+FQ=;
 b=dmv/dTvHFt8Mw+xki3JfwPAK/E32m0tA29cOFmS8T/7BtrCsCD37lyNQE1nqjac3ZP
 9ZbbLolJsLAtUJNmGeCbxnskuhcWed9jH7WAwMgeP0fbT/LvT7MdTbdQJ6zyArIVyutG
 0qTqLp4n38eoueGGHgHads2lVYyals6TFLM8k0ho02yNOSEfDw3mxPaJs2MVq82jgROJ
 nRnylM9fwdhAD83hxYrlbN+IOA4mStr9SOk0koT3/cuGFAo/xb0Yx2YW6+UCPrXzLFYL
 GDiiQzFXHJ1UynWSaDQZYYOl0YLCP+CjUD9JAphduRAz6nNfcWpXyz2icmVWZEpGTjzG
 dd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730188846; x=1730793646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qXy+lNEtrc8AcOb6MwaM6rgZJR9Gq9uMl3UWB4oK+FQ=;
 b=SWpqp7DbCHczNp+AFGBFwQGdvVjCuCo6CqrTKo4QtWV57x/c34Qoph5k+qE8gt6ceQ
 7oBqFGsKa2Nl1jcjkNzEE4RRnQFgWKSJqv6bxisXiPXYXaGXnjbHX+YGUs34IziLtiQB
 k9kg5E0j+BLGnngi2dnLyr1yhxbOIG+7PFgS926sZRu/JI/SJhy6n6nqDVSiCIakhz4R
 ldaYhx0iNLETiErCYbQ22Onz9ErMlMwtiaTtwPXcgsi8+bEvLdtmg6L52poSz369JhrX
 7sAWQtnanXLP7NLQFNXYlQyicrcpPo6F4aqwjQ5Pxzg21UthYjy+EGgbTBv+wzLIeQWM
 i7aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/8YLlFVXFTCksBtFZquHgScAmTtRqfgE8OjlMCBkWcj17uTyB4wUxztEfEUNogMa+0y3yaRg=@lists.denx.de
X-Gm-Message-State: AOJu0YxJD22rhyUJFBbQsDsyduaMFyx3BLyiSnbPVZgAnTRjC5+E4mBJ
 mD9PHc5rBbpKV+j82DuukvZqO83hZHgcciN7Fx7Eq5UVLsngBl4AEe9nJ00dvZp3/VQ9hug5D+x
 Hex8gq0iITbSdqW2lCg2Qcjz0NFZtB1wbYJBkuA==
X-Google-Smtp-Source: AGHT+IGkksb/SOe/eTDCWd7uHMbArROcM/ejlWS1Hx8NhJc6PGrHnJsBnPtHIHeU3nb3LSJyS7Mj64x9MkI/BaAQnrU=
X-Received: by 2002:a05:6a21:2d89:b0:1d9:a94:8d90 with SMTP id
 adf61e73a8af0-1d9a8473c36mr13130112637.27.1730188846103; Tue, 29 Oct 2024
 01:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241024104625.1340355-1-ilias.apalodimas@linaro.org>
 <06be7096-2e06-44d6-ba00-55ea578121d8@gmx.de>
In-Reply-To: <06be7096-2e06-44d6-ba00-55ea578121d8@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 10:00:09 +0200
Message-ID: <CAC_iWjJdsJLT6arwynmVx5_fTeOr6rZkp8+AdA1rx_zG6Jandw@mail.gmail.com>
Subject: Re: [PATCH] lmb: Correctly unmap memory after notifications
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Heinrich

On Mon, 28 Oct 2024 at 08:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/24/24 12:46, Ilias Apalodimas wrote:
> > We never unmap the memory used to update the EFI memory map after
> > notifications
> >
> > Fixes: commit 2f6191526a13 ("lmb: notify of any changes to the LMB memory map")
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/lmb.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 890e2cbfdf6b..38c6e1d5ba8d 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -65,6 +65,7 @@ static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
> >                       status & ~EFI_ERROR_MASK);
> >               return -1;
> >       }
> > +     unmap_sysmem((void *)(uintptr_t)efi_addr);
>
> If PCI memory was ever mapped via pci_map_physmem(), I don't think that
> we want to unmap it here.

Ok, so looking at it again, not calling unmap_sysmem() here won't
break anything, so I guess we can drop this patch.

>
> Why do we map the memory in this notification function first hand?

Because the memory was added as such in efi_allocate_pages(). So for
sandbox we need to find the correct virtual memory that was added.

> Can't
> we use len = 0 when calling map_sysmem()?

We are using len = 0. But I am not following up on how could this
help. All you will get is a warning for sanbox if a pci device mapped
more that 0.

Thanks
/Ilias

>
> I guess we have to critically review all map_sysmem() calls.
>
> Best regards
>
> Heinrich
>
> >
> >       return 0;
> >   }
>
