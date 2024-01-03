Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58035C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 07:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F1D8773F;
	Wed,  3 Jan 2024 08:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fZln10r4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C02087745; Wed,  3 Jan 2024 08:06:42 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B60B8773F
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 08:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-46777099deeso426844137.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704265596; x=1704870396; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H9iZV2kIycubkmLu8d5N7ka3Gkkzpn2prTWz5v3x4AI=;
 b=fZln10r4q34HVB3YrMkuo/sFTfLLZKT4K53zQ60UrFsi+uSbkbXM/lRntR+M5ieMJU
 fIM+WnLpFmGJQ1gu4QWXbwGUEtMNet/FXIBBzX/XXrGvjs0ASHzBuWiHnWtElOuzh8YH
 W2OQDtVU8acTGkW6Sd2kuKDrXgnPN00BSSkjOE6xGpZJU12Z5dHbdxr9S1SF03OspH4u
 MOxTO7Hxfmr1bfmn2R55VhFQGhYoJOXXhu+PMeuFpijmob5ow2U3YTOVHh31JPo4LAo4
 krsPJ3H+EDECVfpFBrWdgtkZzm0P7sAL3vzSwSPH6RWH0Zg2ARIteprIQzTY+AGkhHuM
 y4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704265596; x=1704870396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H9iZV2kIycubkmLu8d5N7ka3Gkkzpn2prTWz5v3x4AI=;
 b=IV6ZMD7KACHFwFiWjJ/zUMFjoHcz6VIOhbEskjWpO/3wUxN7xwhSS6XynTi1UxESKn
 4iZMdE+dreEpJXyLdCYGZsgImjsef92yaL4fFig7cMOrju5q853lQC8wAiZpiz7nzdhn
 b93eCLE6RJd+wffrJxdDvumyUqf+WF/Nyd9uCtB+18eWuO4h00QAW3klrDTYq4ZDblZb
 MfkTfJZk4OqT7RLQwTsZtRkj+fEDnjKLc2d8hr0HGIbwpsHFiXemWO5oK8Yw0bnW9kGo
 JbcQVfeOEXnvuQBLwPcxdAehjKIfbNDLWrpMo0zYMI3K3rB6wG7Xyd58kJgAUBxvc54/
 DNOw==
X-Gm-Message-State: AOJu0Yws+5FWe0dxOBqAeRPmctMiZ9xgyyTlbdBHcmCWOiyqvvMoLgb9
 c9CldFi0BlDfZ8Itc4VL0FE35bFKzynFKGAp2XU9DXroGp0Rzg==
X-Google-Smtp-Source: AGHT+IGn+0QI9GuO8rpjzWKrXtA/t1PwArbspMNxFYdG5JXnmsgx1krhFOwzYhCtl6/Deh7/FpmcNmz6aYN78bYRtKE=
X-Received: by 2002:a05:6102:3d84:b0:467:2212:a42c with SMTP id
 h4-20020a0561023d8400b004672212a42cmr6835062vsv.26.1704265595932; Tue, 02 Jan
 2024 23:06:35 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
 <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat>
 <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
In-Reply-To: <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 3 Jan 2024 12:36:24 +0530
Message-ID: <CAFA6WYNS03gLmOoPb7tawkD__MJ7NW_iewg5w3hWvwnQu-iw0Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB
 builds
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

On Tue, 2 Jan 2024 at 21:07, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 2 Jan 2024 at 19:36, Simon Glass <sjg@chromium.org> wrote:
<snip>
>
> > 3. Adjust the build system to use the dts/ directory for .dts files
> > when OF_UPSTREAM is enabled
> >
> > Then it will be easy. People can enable OF_UPSTREAM for an SoC
> > (without changing DEFAULT_DEVICE_TREE)
>
> I am still not sure what we will gain via keeping DEFAULT_DEVICE_TREE
> the same. However, without a per vendor directory Makefile like:
> dts/arch/arm64/<vendor>/Makefile it won't be possible. But to do that
> we won't be able to softlink vendor directories from DT rebasing tree
> but rather have to softlink every board DTS file which is much more
> painful.

Even after this you have to tell <vendor> name via DEFAULT_DEVICE_TREE
because the DTB path is constructed via:

DEVICE_TREE ?= $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%)
ifeq ($(DEVICE_TREE),)
DEVICE_TREE := unset
endif

ifeq ($(CONFIG_OF_UPSTREAM),y)
ifeq ($(CONFIG_ARM64),y)
dt_dir := dts/arch/arm64
else
dt_dir := dts/arch/$(ARCH)
endif
else
dt_dir := arch/$(ARCH)/dts
endif

ifneq ($(EXT_DTB),)
DTB := $(EXT_DTB)
else
DTB := $(dt_dir)/$(DEVICE_TREE).dtb
endif

So with a move to Linux directory structure for dts directory,
DEFAULT_DEVICE_TREE have to specify <vendor>/<name> as DT filename.

-Sumit

>
> > and will get the same behaviour
> > as now, just with upstream .dts files. All the .dts files for an SoC
> > are built, as now, just as Linux does. We can continue cleaning up the
> > DT build rules as time permits.
>
> I will reiterate here, we can decide to add Makefile rules on a case
> by case basis. If there is a need (from packaging perspective or a
> particular SoC supports a generic U-Boot image) then we should be able
> to add them. The cleanup would be automatically part of the process as
> we switch SoCs to OF_UPSTREAM.
>
> -Sumit
>
> >
> > Regards,
> > Simon
> >
> > [1] http://patchwork.ozlabs.org/project/uboot/list/?series=388154
> > [2] https://git.pengutronix.de/cgit/barebox/tree/dts
