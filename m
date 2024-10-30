Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C5ED6B6DA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 20:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7456689261;
	Wed, 30 Oct 2024 21:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="lrgv/hcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648C789261; Wed, 30 Oct 2024 21:59:56 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BD888B9F
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 21:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3SZ4iZwcKBlA4690BHxy66y3w.u64C-t66B30ABA.vw5F.vw@flex--moritzf.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6ea527764c3so6295437b3.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730321993; x=1730926793; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+Knw04ZX28aKOcnoJDeVFN77/+A+z51UiHmDCottsH8=;
 b=lrgv/hcw8zKCI7FjGyh0Qbn0CFAgmQYKAHpW4HXHG0SGLNXr+gpXT8/t/b8FenQ/so
 3DB+jpCevACtiw9N3VvmCYV66PdZ/uNWYQoIWLXC+4/0ed9WonwtPTsZxpjVuWGfmkoE
 4poBQ6WktKk+nkckXQv7CR2Exc+/L12fJrvwIkgiP/PxX/qvMXhhjjzJD/ekceUaJyfu
 N0vNhfh0XkJCfLIYEwZ8tLcRRNSW8Ga1VXYWEFa918WkKM749b2WJxVeyXIox6D9wBbj
 VBPB1EQZ+S14vdcHkpqAymZkZ+HltS+PRDyOAeQaNo4s2rwJkeE5Ux4jGCd40cnRiw+1
 yZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730321993; x=1730926793;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Knw04ZX28aKOcnoJDeVFN77/+A+z51UiHmDCottsH8=;
 b=oxTJuws5iLN4FKvP/hX436zwd49xOZ4wwySdaQnirBAr+rAp6qBcurCSiapaBkMtGa
 tOZ+cwRqFVQ6Kexifth3ICTgnYgIY2nHKCWcRl/XET18JRq0xGYeu0JNqoGGurFR2FOZ
 qC+hm95Whs0VEaaIEeUzqgp63NXkZ9UKqnkIS7/u1dx8KB0cWFyV4RgFiaqzatSDAY7Y
 7h+eGkf1uF5KKgOGqWQ61xs8N2sYTibcOTrS36YMtTj26MJF5eh9HBsRBM9XxQI+C4jz
 Hv9l7ZK9oH6ZrAar4LCtgUPqvl/XXwuLJBlK4rwCse4xM5MgLDn6OnvqKE9kyTjAGjgk
 /BYw==
X-Gm-Message-State: AOJu0YxzLFyJ9OLASpQbb9lMpmIsnqTrpmsZhut2Y+s1sWmd4gNgiAW7
 4ai/j3VCVkYQsGimyCJwYBBE9bH9lEnBKujWZpLw+70oQ8tVaq1/9+GfN+1yXBlJXgxn3Rjg08P
 CNi7CNg==
X-Google-Smtp-Source: AGHT+IHkPjc/GHqPFrBCW9hMK6ZD1/Eiet5CiGcXdkECPByxFoINwE5h4QAjMWCEeJeK8/IjksDNeYeWhuEi
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:13f:f0c:ac12:c151])
 (user=moritzf job=sendgmr) by 2002:a81:be02:0:b0:6a9:3d52:79e9 with SMTP id
 00721157ae682-6ea3b94f7famr1020277b3.4.1730321993209; Wed, 30 Oct 2024
 13:59:53 -0700 (PDT)
Date: Wed, 30 Oct 2024 20:59:52 +0000
In-Reply-To: <CAC_iWj+h5yeBkHENBzPuVYeQYjESrpidzrOtvrJiEO9ezm_jZg@mail.gmail.com>
Mime-Version: 1.0
References: <20241030201608.1247488-1-moritzf@google.com>
 <CAC_iWj+h5yeBkHENBzPuVYeQYjESrpidzrOtvrJiEO9ezm_jZg@mail.gmail.com>
Message-ID: <roctkvcajrh75xiixe4qfzjk4mtbf6vzzw4pwjgltrpbj5morr@56oiirwrhvzu>
Subject: Re: [PATCH] lib: efi_loader: Fix efi_dp_from_mem() call
From: Moritz Fischer <moritzf@google.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, trini@konsulko.com, 
 pwildt@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
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

On Wed, Oct 30, 2024 at 10:28:40PM GMT, Ilias Apalodimas wrote:
> Hi Moritz

> Thanks for the patch

> On Wed, 30 Oct 2024 at 22:16, Moritz Fischer <moritzf@google.com> wrote:
> >
> > The function expects an end address but is being called with
> > an size instead.
> >
> > Fixes: 6422820ac3 ("efi_loader: split unrelated code from  
> efi_bootmgr.c")
> > Signed-off-by: Moritz Fischer <moritzf@google.com>
> > ---
> >  lib/efi_loader/efi_bootbin.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index a87006b3c0..798bcd6eee 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -137,7 +137,8 @@ efi_status_t efi_run_image(void *source_buffer,  
> efi_uintn_t source_size)
> >                  */
> >                 file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> >                                             (uintptr_t)source_buffer,
> > -                                           source_size);
> > +                                           (uintptr_t)source_buffer +
> > +                                           (size_t)source_size);

> Yes, the change is correct, but we don't need the cast.

> With that changed
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Ack. Will send a v2.


> >                 /*
> >                  * Make sure that device for device_path exist
> >                  * in load_image(). Otherwise, shell and grub will fail.
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >

Thanks,
Moritz
