Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C15E81A62
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 19:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E30F869F1;
	Fri, 22 Sep 2023 21:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="huMiOxtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D78869F6; Fri, 22 Sep 2023 21:35:38 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E8B86996
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 21:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5334f9a56f6so2545210a12.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695411336; x=1696016136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=isBBGGCKpduQ5FkRVuU0y1GQu+sK0xOtxNTWqVV23LI=;
 b=huMiOxtgEZEb4l1KFGq3c9IT2gXps1SG5fH6MEUu6xU6AvxMHxiaEFHhFDFebzMGBr
 TG+oMklufUIvNWe19OegQofSHlnltpwNiy9RXFhm8Iqv6UHpSp5PdeEMU+NWk2KF+2Iz
 G7/SNv/73oZjD8yNGLygriXtMvW+ZnnIWwVF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695411336; x=1696016136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=isBBGGCKpduQ5FkRVuU0y1GQu+sK0xOtxNTWqVV23LI=;
 b=jyPoxFJtyE4HANaw/PIO2kXAuGNznMfx4x2TrsRJGu4rfFn3yaKZ+UdwIxwyCeVEFH
 qzNcc+WhVMKkR+zPFptwL0fo3KSV9Qn0PCfT2yBKPTQcgSjO5h5Ii17as6b4xtsCxSNR
 s9tR3WZlsL4reVotMcp6k1q/ga8zaMHBcBHnut1vbcSYKdjRBqKTv+SvZJY1KupSemps
 HKFkp+ls8ywjG3w8ZJqWO+siEiNKRcRbQCUhKlbuMcoCCQNvwFdTIQU5fcKyP8dl74Eh
 K0IUubxpiVnbPp1Cu24jE/YmqdtpWUQhbHBsaYFx+Gc546URDds6CJuB7uPqCrTdC9JX
 8Xug==
X-Gm-Message-State: AOJu0YwnVo08cCU0shjCIHse2UgGUVXd7rurMg49G9xXRaZ34advabvk
 5ICg0uqFwZCSl2KCtbw+o3HikEIxSHQbRPxqvEuAKA==
X-Google-Smtp-Source: AGHT+IHQOUzdhvWMotL16z7Ig4AHCwphBkf6kKjzl1g3FZBnmTD23+LLZhi4Mw64ypFlFFv6B3BJR2oy72IDzo0yBCI=
X-Received: by 2002:a05:6402:5148:b0:52f:2a38:1f3 with SMTP id
 n8-20020a056402514800b0052f2a3801f3mr427913edd.2.1695411336195; Fri, 22 Sep
 2023 12:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
 <CAPnjgZ2W_2d-xhdKPbatR4L3BjE08ZEH4SdBSi6YVDWqs7Swmw@mail.gmail.com>
 <41a5e281-9dcd-9720-380a-ea59566d7dc1@ti.com>
 <CAPnjgZ34hW-61MNEORQU8xofBaoBu_piau4rKd2hdTJgFbSZnA@mail.gmail.com>
 <eaf56065-9f9e-70b4-e901-3e6dc2934cd1@ti.com>
 <CAPnjgZ1vkKq5yc7mq44nN063miJWx0JKztaXLMwFuUbJLtvEEA@mail.gmail.com>
 <a5d0e5dd-f907-09f9-474d-39b361479042@ti.com>
In-Reply-To: <a5d0e5dd-f907-09f9-474d-39b361479042@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 13:35:19 -0600
Message-ID: <CAPnjgZ28Shudbz2-=Wh3tyi+o7gnfnzixcEyD8FwUvNG-w3HyA@mail.gmail.com>
Subject: Re: [Question] TI's u-boot.img is built twice
To: Andrew Davis <afd@ti.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Nishanth Menon <nm@ti.com>, srk@ti.com, n-francis@ti.com, s-vadapalli@ti.com, 
 m-chawdhry@ti.com
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

Hi Andrew,

On Fri, 22 Sept 2023 at 12:44, Andrew Davis <afd@ti.com> wrote:
>
> On 9/22/23 1:29 PM, Simon Glass wrote:
> > Hi Andrew,
> >
> > On Fri, 22 Sept 2023 at 12:14, Andrew Davis <afd@ti.com> wrote:
> >>
> >> On 9/22/23 11:40 AM, Simon Glass wrote:
> >>> Hi Andrew,
> >>>
> >>> On Fri, 22 Sept 2023 at 10:35, Andrew Davis <afd@ti.com> wrote:
> >>>>
> >>>> On 9/22/23 10:01 AM, Simon Glass wrote:
> >>>>> Hi Masahiro,
> >>>>>
> >>>>> On Thu, 21 Sept 2023 at 09:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >>>>>>
> >>>>>> Hi.
> >>>>>>
> >>>>>> Since the TI platform migrated to binman,
> >>>>>> u-boot.img is built twice.
> >>>>>>
> >>>>>> It is created by "mkimage -E",
> >>>>>> then overwritten by binman.
> >>>>>>
> >>>>>>
> >>>>>> So, the data are embedded in the FIT structure
> >>>>>> instead of being appended.
> >>>>>>
> >>>>>> Is this intentional?
> >>>>>>
> >>>>>> To me, it looks weird.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> To confirm it, apply the following hack.
> >>>>>>
> >>>>>> Since u-boot.img is overwritten by binman,
> >>>>>> copy it to u-boot.img.backup.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> diff --git a/Makefile b/Makefile
> >>>>>> index 87f9fc786e..4cffa8a061 100644
> >>>>>> --- a/Makefile
> >>>>>> +++ b/Makefile
> >>>>>> @@ -1112,6 +1112,7 @@ endef
> >>>>>>     # Timestamp file to make sure that binman always runs
> >>>>>>     .binman_stamp: $(INPUTS-y) FORCE
> >>>>>>     ifeq ($(CONFIG_BINMAN),y)
> >>>>>> +       cp u-boot.img u-boot.img.backup
> >>>>>>            $(call if_changed,binman)
> >>>>>>     endif
> >>>>>>            @touch $@
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Then, build it for the main core.
> >>>>>>
> >>>>>>
> >>>>>> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
> >>>>>>       am64x_evm_a53_defconfig all
> >>>>>>       TEE=~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
> >>>>>>       BL31=~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
> >>>>>>       BINMAN_INDIRS=~/ref/ti-linux-firmware
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Compare the two files.
> >>>>>> Run fdtdump to see what happened to them.
> >>>>>>
> >>>>>>
> >>>>>> $ diff -u u-boot.img  u-boot.img.backup
> >>>>>> Binary files u-boot.img and u-boot.img.backup differ
> >>>>>>
> >>>>>>
> >>>>>> $ fdtdump u-boot.img
> >>>>>>        => u-boot and dt are embedded.
> >>>>>>
> >>>>>> $ fdtdump u-boot.img.backup
> >>>>>>        => u-boot and dt are appended after the
> >>>>>>           FIT structure
> >>>>>
> >>>>> That seems like a bug to me...at some point we might consider building
> >>>>> u-boot.img with Binman, but for now it is built by the Makefile.
> >>>>>
> >>>>
> >>>> This is not true for K3 as we now use Binman for u-boot.img generation
> >>>> (we need this as we have a signing step injected at this point).
> >>>
> >>> No, no.
> >>>
> >>> You must not mess with the outputs of Makefile - create a new file
> >>> with what you need, e.g. u-boot-ti.img
> >>>
> >>> While we could use Binman to produce the .img we are quite a way from
> >>> doing that as not that many boards have been converted to binman.
> >>>
> >>
> >> Too late, we already use Binman to generate u-boot.img on K3, why
> >> would we want to go back to using Makefile?
> >
> > I don't mean that, I mean give it another name. The u-boot.img file is
> > intended to be a certain format, and it seems this is being changed.
> >
>
> Well we need u-boot.img, and it needs to be called that, and
> it needs to be the one generated by Binman (the one generated by
> Makefile can only boot on GP devices, but not HS-SE).
>
> The format produced by Makefile and Binman will be identical after
> we fix Binman to put the data at the end. At which point why not
> drop the Makefile made one?

I think you understand my concern, which is really around overwriting
an existing file with Binman. So long as you can resolve that in a
deterministic way (i.e. Kconfig) then I am happy.

Regards,
Simon

>
> Andrew
>
> > Really, this is a problem with binman, as it should have refused to
> > creating u-boot.img...?
> >
> >>
> >> Let's go with what you suggest below and add a Kconfig that can
> >> be used for boards that have already switched to binman that disables
> >> the Makefile generator for u-boot.img.
> >>
> >> Once all boards have switched to Binman, then we could refactor
> >> the implementations into something more common.
> >
> > That seems OK to me.
> >
> > Regards,
> > Simon
> >
> >>
> >> Andrew
> >>
> >>>>
> >>>> So as Masahiro suggested in the other branch of this thread, we need
> >>>> to disable the Makefile generation of u-boot.img for K3.
> >>>>
> >>>> Neha,
> >>>>
> >>>> Can you take this action? I assume you can add it as part of your
> >>>> work in making the data external again, which would make the u-boot.img
> >>>> identical to before and hence Makefile version could be disabled at
> >>>> the same time/series.
> >>>
> >>> If you are suggesting that we slowly migrate boards away from
> >>> generating the .img using Makefile...perhaps that makes sense? I'm not
> >>> really sure. But in that case we need another Kconfig option.
> >>>
> >>> Regards,
> >>> Simon
