Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E99C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 10:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D55C88B3F;
	Wed, 21 Aug 2024 12:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zK+hPIQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A854788C04; Wed, 21 Aug 2024 12:07:12 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F9688B3F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 12:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso1086502a12.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724234830; x=1724839630; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KTgoL8xF+LrXLtlVYjsWDsMPYhCcBSZ8zR+0oV4GmYw=;
 b=zK+hPIQHJI4eZTbBAL4oxX3SfblyIlN5ijHkpY1rBbHYYLk1Fd+Dd1cYRGGux822S6
 iAAyjOK57v9SXJiY9doZ2errKFPv8E3AH2nz6xjqwTbHX0Tili+V8iUeBqfBnbbHvGW6
 O1MSm72LmGPCnJ+QiPz4gXQVkhVlfUrK9oDHcAdv8XaAePCuhu042aSoqOqfnaN/LLnB
 +eLO7VkviAY+nfWwBp50AGLDFhrX3d9PWLtM7X0XluKQLaQNqehKlzghvDIByTbevACQ
 NJ+deQy8IpNs0CPpII4cxJVEqShSiH/JG1mKG0yE0mOMx6xmTk8yobs2E3I7a8XWrIoa
 WAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724234830; x=1724839630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KTgoL8xF+LrXLtlVYjsWDsMPYhCcBSZ8zR+0oV4GmYw=;
 b=GS3XlN88BEFbeaI5uGeOX7hyx7a4ZIaC3qDmkXW8bNR1SoaLbbJtOipfmLk6a+vT+1
 /rmy7AFwY/WEzshV4oIhj0kjVVtjntj3e9fMuY1Unepthz8NBgyirNN7EAnKiRV/QqEk
 5mdIdmdOdiiauuZ5bIk6/NdFFySvwBTM61nX479/A9BcZmwMKsyx7nj4rhgfoR3K6P3Y
 PuUfE24e1A4jtzD/0UxfP6TvydgibU/ODPfB140fJZEBgMmG1vs3kbATCwD5Dtw/OrV7
 kLD1C1MPJGZ7KNwBpudHswaP3Zjydbfgwncs9EfdNf4CdQnof/mlbiRNREOWn7NWUH2m
 QTUQ==
X-Gm-Message-State: AOJu0Yzt1O/CWVKiU388oGy+SNVyw7qMZXgwHoK14GPLG2O3d1+BZC5V
 UaZW5eDdbvUgVZhEgeaM4AJPRoQuG1yhp+GrMV8yk4V9u4iunk6GOTCBnGOYyYeLxTLuqJbvDEM
 0OOt4/OmXofxrE1j6HwP5m/+OJjAXvQJR4bznkA==
X-Google-Smtp-Source: AGHT+IFCFXwXVYcbds65RM9QQhNOnbFvJ8O8Asjax5++y5vcutnDPls2Ct3wFaNRV/HzBkma2RtKMwyL6zxwA7n3b/U=
X-Received: by 2002:a05:6402:35cc:b0:5be:c2c8:8631 with SMTP id
 4fb4d7f45d1cf-5bf1e6e5c1amr1766052a12.8.1724234829512; Wed, 21 Aug 2024
 03:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-15-sughosh.ganu@linaro.org>
 <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
 <CADg8p95k_0CtqD5x8_jjW31YoPOoiLSvDU-M_JtcBU_+V-4hEg@mail.gmail.com>
 <CAFLszTji1FcHNitO+mKJ+uh-Kr5N33ZZjqZJx1Uaianj35Q4vQ@mail.gmail.com>
 <CADg8p94QuMpjP3fU0Rz7Y2gzpM=93RdxFxLM7c7DkpRtnkVL0A@mail.gmail.com>
In-Reply-To: <CADg8p94QuMpjP3fU0Rz7Y2gzpM=93RdxFxLM7c7DkpRtnkVL0A@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 21 Aug 2024 15:36:58 +0530
Message-ID: <CADg8p96EOOBQUjW86W7qdAVuXoJ5vqSi8eAxunW8R6KyRGpiaQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/32] lmb: introduce a function to add memory to the
 lmb memory map
To: Simon Glass <sjg@chromium.org>
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

On Wed, 21 Aug 2024 at 10:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 21 Aug 2024 at 07:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Tue, 20 Aug 2024 at 02:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 16 Aug 2024 at 02:04, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Introduce a function lmb_add_memory() to add available memory to the
> > > > > LMB memory map. Call this function during board init once the LMB data
> > > > > structures have been initialised.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V1:
> > > > > * Call the lmb_add_memory() from lmb_init() instead of
> > > > >   lmb_mem_regions_init().
> > > > >
> > > > >
> > > > >  include/lmb.h | 10 ++++++++++
> > > > >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 52 insertions(+)
> > > > >
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > But this should not be weak.
> > >
> > > This is being made weak, as there would be lmb_add_memory()
> > > definitions added for powerpc and x86 arch's in the EFI part of my
> > > patches. Moreover, the lmb_add_memory() function would be called even
> > > in the SPL stage when LMB is enabled for that stage. So I am not sure
> > > how do we get around this. You can check the relevant branch [1] on my
> > > github to check for the specific commits [2][3] that I am referring
> > > to. Thanks.
> >
> > This is really strange.
> >
> > The e820 is different on each x86 board. I'm not sure we want that in
> > the lmb. What is the purpose of that? It is somewhat circular in most
> > cases, since U-Boot sets it up itself. Where it comes from coreboot,
> > it looks like we are mirroring it in the EFI memory map. I'm not sure
> > I understand all this very well.
>
> Yes, me neither. And I want to keep the behaviour same as before the
> patches. You would know that the function efi_add_known_memory() gets
> the memory map from a function install_e820_map() which includes
> conventional memory, which is the ram memory. And I am basically now
> doing this as part of the lmb_add_memory() function instead. Are you
> sure that we can do away with this function, and instead use the
> ram_base and ram_top values from the global data structure instead? I
> believe you have boards which exercise this code? So it will be great
> if you can test this if I remove the function for the e820 module.
>
> >
> > For fsl, perhaps copy the #ifdef and handle arch.resv_ram in your code?
>
> This is for adding ram to the lmb memory map, but yes, I can check by
> putting an ifdef in the function. Although the function might look
> ugly and hackish. Thanks.

I have taken an alternative approach to this, whereby boards/archs can
still define their own memory map addition without using the weak
attribute. Please check the relevant branch [1] on my github, and
these commits [2][3][4] specifically. Thanks.

-sughosh

[1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_noweak_v3
[2] - https://github.com/u-boot/u-boot/commit/0b5dbaf07a3615230b9df06296e40267e838f459
[3] - https://github.com/u-boot/u-boot/commit/916a36dcb5cc66d801067924607fd94d8bad2162
[4] - https://github.com/u-boot/u-boot/commit/9da75a20e9a6af00cfaac71f09e4a1f89f10a804



>
> -sughosh
>
> >
> > [..]
> > Regards,
> > Simon
> >
> >
> > > [1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_v3
> > > [2] - https://github.com/u-boot/u-boot/commit/077ced7aaa6d495b1b87b324fb1c60658c203ce1
> > > [3] - https://github.com/u-boot/u-boot/commit/d0fa3a89865b796f3bbebffebbe4f7b5b048c140
> > >
