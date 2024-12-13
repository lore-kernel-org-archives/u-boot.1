Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AA5E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 09:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C554880104;
	Fri, 13 Dec 2024 10:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GyJAXRSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F448010E; Fri, 13 Dec 2024 10:54:28 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9CE800DF
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 10:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d27243ba8bso2833106a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734083665; x=1734688465; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c7RuCPfQLufu1JGxTZMO1ZnBMQR8cV66I/9RpP9N1rE=;
 b=GyJAXRSIeJIUEXW/FhTrJFlpXPsn7DGtG1HcRN96oqXXGw1DbGhZYCZvnIoFKVefcI
 GlfeKC6VXlDOYQBLqE1Wxz1MZXycNW4hN/rkRKVBNF1ogIJtY9rP/Jxs18l432FpRIOZ
 DflTcug99QHmXtWDlmc6YvyfipmBKluqVD+UjOGYKl8SQ5jd3+UK0Osx50SB/CY8q+QH
 62vaxaDvrfm7QjU7TQ+PxZw2CoreSipccyNWIZ9IPGWgTOYnIi0zFlNOJgCgkxv4XUwB
 EWSuhBC9jgJMvO592B8jixf0QfUKtbPh+eDPOssEHO4ebcepNXV8mO8ha73R6c7oZSxw
 uo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734083665; x=1734688465;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c7RuCPfQLufu1JGxTZMO1ZnBMQR8cV66I/9RpP9N1rE=;
 b=rL1NA204rG51soq0jIkxyehE80AFXEvg8hB1M/H518jhwff1iNRSAl+kBas3TYNqnA
 h1VgmcQ54enzwKuNVx0K3AVHn7RcC0SWjidiTUAjHbBr7hWvkso0cboQWTzB/niuF9Z4
 W33Mip2M1u+3gavb9nHsoU0Z9XAJe9EmQwzz0x79MTAQE7bNLhn35Eb0q8tpxsQdJaEV
 R9v5wlfc13688JcE8dETfKUV/h06MofDFsF6mXixOubeev3fsJU9PF3NbNpCYNC5aIWw
 IIulDU3FsddCZoVwUsW54zwVcbY4XG6awBN1yXcKBe2H/iNxviosuXpBNrmcsMdM/+w8
 vi5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfqiEtsIFiv/6svEWbKgh6NE2Zdfuxa3AvEQwdsNqwoXd4qE9U3JLU17EtiE4ObZw8OPghvQU=@lists.denx.de
X-Gm-Message-State: AOJu0YxrpAQ5GWzDFW7Kwc9QDSzkd1edoRitk4w5GtnWNE5IpUPmx/4N
 h14+PdI8DxxPFTq54W70Bo2M47f91zCQPwVFU8Vni1pX3wK4ZtGZb1S6rS/mQVUPd9YLjwQ1Pob
 96TyTZyYbijXhjEdH6k4M3IsyOUbjgA7ivU3b/w==
X-Gm-Gg: ASbGncvGL2tMxMwLwXvXqVxuX9RcpfF++K4yWKIeZ8M9G7rAyeoQbBlskcDk/q3MNXc
 uWpeMlK3/5OU7u7uXoJo71hFLnFDXexC0gLpTFA==
X-Google-Smtp-Source: AGHT+IGY2qBIxdBMO3kARI8vvPR/14kwZtb0/KjQ7qq8YS+KD2+34fzaTEczMT8W/i2PLiZc6GUZj4nFobpZqLVN3X4=
X-Received: by 2002:a05:6402:354b:b0:5d0:e826:f10a with SMTP id
 4fb4d7f45d1cf-5d63c2e528bmr1618199a12.6.1734083664397; Fri, 13 Dec 2024
 01:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
 <20241212191822.GK1505244@bill-the-cat>
 <CADg8p94h9rdV+gLxuhmNTi7yWhdDjOy32SpJwGSugTovtq39Rw@mail.gmail.com>
 <5d2c7448-11a7-436e-b04b-4e510b440e26@foss.st.com>
In-Reply-To: <5d2c7448-11a7-436e-b04b-4e510b440e26@foss.st.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 13 Dec 2024 15:24:13 +0530
Message-ID: <CADg8p955sefs1kZiyMAwp6N7=w13VCidFoK1Lv5NbLH-katvoQ@mail.gmail.com>
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 E Shattow <lucent@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

On Fri, 13 Dec 2024 at 14:44, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 12/12/24 20:50, Sughosh Ganu wrote:
> > On Fri, 13 Dec 2024 at 00:48, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Wed, Dec 11, 2024 at 05:18:28PM +0100, Patrice CHOTARD wrote:
> >>
> >>>
> >>>
> >>> On 12/7/24 16:57, Tom Rini wrote:
> >>>> On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
> >>>>
> >>>>> There are platforms which set the value of ram_top based on certain
> >>>>> restrictions that the platform might have in accessing memory above
> >>>>> ram_top, even when the memory region is in the same DRAM bank. So,
> >>>>> even though the LMB allocator works as expected, when trying to
> >>>>> allocate memory above ram_top, prohibit this by marking all memory
> >>>>> above ram_top as reserved, even if the said memory region is from the
> >>>>> same bank.
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Applied to u-boot/master, thanks!
> >>>>
> >>> Hello
> >>>
> >>> This patch is breaking the boot on STM32MP135F-DK.
> >>>
> >>> On this platform, we got an area above gd->ram_top,
> >>> this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().
> >>>
> >>> Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
> >>> this area is no more tagged as LMB_NOMAP, because it's previously been
> >>> tagged with LMB_NOOVERWRITE in lmb_add_memory().
> >>>
> >>> By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.
> >>>
> >>> I suggest to revert this patch.
> >>
> >> Hi Patrice. Can you please re-test current top of tree? I believe Sam's
> >> series should resolve this problem as well. Thanks!
> >
> > Tom, that won't happen. This is a separate issue from what is being
> > fixed by Sam's series.
>
> Hi All
>
> I confirm, Sam's series didn't help here as Sughosh said.
>
> >
> > Patrice, please let me know if the hang is being fixed by the change
> > that I had suggested earlier in this thread. For some reason I don't
> > see a hang on the DK2 board despite the board having a similar memory
> > map of memory being reserved for the op-tee image above ram_top with
> > no-map property.
>
> On my side i didn't see the issue on STM32MP157C-DK2 board, but
> i got it systematically on STM2MP135F-DK.
>
> Your suggested patch is fixing the hang observed, i will send a patch.

Patrice, thanks much for testing and confirming the fix. I suspect
that the cpu's being used on the two boards might be different. Looks
like one implementation is speculatively prefetching data from the
op-tee memory region while other is not, which might explain why this
is not seen on all ST boards. Just a hunch though :)

-sughosh

>
> Thanks all ;-)
>
> Patrice
>
>
> >
> > -sughosh
> >
> >>
> >> --
> >> Tom
