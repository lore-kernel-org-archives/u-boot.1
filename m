Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8CDC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 02:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6886588A64;
	Wed, 21 Aug 2024 04:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MYdbu4dV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11128780E; Wed, 21 Aug 2024 04:11:49 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401C287BF4
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 04:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf7f4a1334so23623146d6.2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724206306; x=1724811106; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i6vQ+8J05qRGp0/3fL+Mu/R9i+Ie6w5zHzxSi9IiQys=;
 b=MYdbu4dVJQ6YdsQS03IBbQwvmaDjC9dzG0l9LCTWDQbOxU0U9c5timAgcOYnWRYjX8
 ZgOvU9UEkFpX0ahFbQyEVSpB8kIgKPuu85l77c17G2GBKnihI5Auv3FxahgBK8u1Ndaw
 1bMeOYPw1XG9dvJIYTe+ys6ta1+6XrwNfrHrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724206306; x=1724811106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6vQ+8J05qRGp0/3fL+Mu/R9i+Ie6w5zHzxSi9IiQys=;
 b=V1AteO1kQvIW3spgfxVjmYTIDa4v/+ZO098jXUf/q8yYRzKY0TZ8CFNTqAVXESlv9k
 qa5f4P4f9r+8M1v1BSe09qyJxf/E5VmHHgwdhyHEL5NgEQxwsZgsABl9vcbszog0GuI3
 XJEOSf3NRbtWaJpiQjbx1mvBi8C5alp1V9I3G7zkFhz9z5K7b/H8ztRrl/byJ+NFBhNj
 6H9eUmSmopbTaKrI4dh/k3jhxMHiai9w1QSh+ZjvM3nOiZprZuMJ00Kr/MX53ZJj94kE
 QyFYKYyG7oYg6sBXiH8nQ4m9dXX0dkgRw/XDrOek7G5x0PYyH+WWncoOOoE7J9ZrlClQ
 b5lQ==
X-Gm-Message-State: AOJu0YxMzDHgZfRNSTmPkg53GbUsqAPFnPfkP8L3rELHJrSZN11/J30Y
 IOluJW4c82Bmh2x5PPJsczCXzeZX7sW9PxU7i8SCXmmBO5LDXevnAo/4lr6yS9/TYTg57zp6/DX
 8fhsSdT3TJjzHA7qhqrf/bnD3cuHW2mamun1U
X-Google-Smtp-Source: AGHT+IGcLVAFSkJpb7fbxX8w3Oac2UdMgA0yD9/89m3V/yZLc8KYIvQnv+gcxj55O7DhsCr0wR1Dhcrg3SHuDyoqMkM=
X-Received: by 2002:a05:6214:3f84:b0:6bf:aa56:78a1 with SMTP id
 6a1803df08f44-6c155df3e2amr11874766d6.41.1724206306114; Tue, 20 Aug 2024
 19:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-15-sughosh.ganu@linaro.org>
 <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
 <CADg8p95k_0CtqD5x8_jjW31YoPOoiLSvDU-M_JtcBU_+V-4hEg@mail.gmail.com>
In-Reply-To: <CADg8p95k_0CtqD5x8_jjW31YoPOoiLSvDU-M_JtcBU_+V-4hEg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Aug 2024 20:11:35 -0600
Message-ID: <CAFLszTji1FcHNitO+mKJ+uh-Kr5N33ZZjqZJx1Uaianj35Q4vQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/32] lmb: introduce a function to add memory to the
 lmb memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Tue, 20 Aug 2024 at 02:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 16 Aug 2024 at 02:04, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Introduce a function lmb_add_memory() to add available memory to the
> > > LMB memory map. Call this function during board init once the LMB data
> > > structures have been initialised.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1:
> > > * Call the lmb_add_memory() from lmb_init() instead of
> > >   lmb_mem_regions_init().
> > >
> > >
> > >  include/lmb.h | 10 ++++++++++
> > >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 52 insertions(+)
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > But this should not be weak.
>
> This is being made weak, as there would be lmb_add_memory()
> definitions added for powerpc and x86 arch's in the EFI part of my
> patches. Moreover, the lmb_add_memory() function would be called even
> in the SPL stage when LMB is enabled for that stage. So I am not sure
> how do we get around this. You can check the relevant branch [1] on my
> github to check for the specific commits [2][3] that I am referring
> to. Thanks.

This is really strange.

The e820 is different on each x86 board. I'm not sure we want that in
the lmb. What is the purpose of that? It is somewhat circular in most
cases, since U-Boot sets it up itself. Where it comes from coreboot,
it looks like we are mirroring it in the EFI memory map. I'm not sure
I understand all this very well.

For fsl, perhaps copy the #ifdef and handle arch.resv_ram in your code?

[..]
Regards,
Simon


> [1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_v3
> [2] - https://github.com/u-boot/u-boot/commit/077ced7aaa6d495b1b87b324fb1c60658c203ce1
> [3] - https://github.com/u-boot/u-boot/commit/d0fa3a89865b796f3bbebffebbe4f7b5b048c140
>
