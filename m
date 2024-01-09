Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07B4C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 05:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23FDF87754;
	Tue,  9 Jan 2024 06:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b1iyg/Sc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0264877D3; Tue,  9 Jan 2024 06:09:04 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A143987754
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 06:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6dde2b84139so163979a34.2
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 21:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704776939; x=1705381739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mms3BAEVl3p07ppv3W8+q853INrtQ1XzDvXKNxchagM=;
 b=b1iyg/ScubQzL8EOlWx/PMtVq+x/MoSvS6Tzoo7HrqGepvjeOnQ4Bu8BI8hG/ApeS9
 muaQcIHYPE7yaZc0C3oYxQ3dEOoUIcK6M3HwBJzZh2DEmB6NkW7lNN9QYKZrHC477if5
 JQw6bxIvfUbAynQ3Wvvx6RVcoHd7O5IKX3CxoWR4sAdXvRnucP3kg+EbTfAp8vJ4GAef
 +Ko0SMHJbRC7tJh1qCKaR5y9HU9Pvjvt1pbWSQRZXq5GAXFxEzSnP7CW+IKAY9G1Pvai
 I8PDmlVniDLarj1J9n0HuCvDh9nGeoOLjjGi5jQ2Khvo7K44gS3zf0ZtNCidS0Dk4Qij
 CjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704776939; x=1705381739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mms3BAEVl3p07ppv3W8+q853INrtQ1XzDvXKNxchagM=;
 b=cswJK4az3RXoFIjB2xwrQNtaVEKyqfe4r3x6eFemwTyGe2Ne0RQN6uzo7befEKJIuy
 czCF00rWm0orICUlLA2SsVQRgF0WUrhwyZ7L0nUDrqM+r+q5Q6nm5BB218YpZ+kTS0iY
 hQsjRtgLlzpi6FaN0Y8/RF6GRoHWjDxOYB1I8Do1GHokBfn8JaNwWa1f7qPl+zVd2tnH
 zHDRevvcoLjGo8OO/NPTMsBgUuNugK7lGnPljkKO2uOJ1vqKR4jlPrMDzyufpCNvSQnF
 ioPzFGD5epahwZBjLKx7fbkHp4ztq3bG5SEEK3xd909QqFopKTr6FkQlmNXgukMFcRCr
 57ew==
X-Gm-Message-State: AOJu0Yxrvu1GAy6RnibJhTNYjpa0DkQ33l0DRKTR5O6d797fn6KYQBA8
 xcG7cN1Cv2s0WEhAQXJJG+OE+kews8oZAMnf6P1j9wxSoECmQg==
X-Google-Smtp-Source: AGHT+IGHnH0QzjHeQrV4B3qFkX8/sYv913QDnYOFZmaTTHU0AJUWD0DFpr3X2/0HchKY1xZ7evhqSy2r2ICqYFtwMcY=
X-Received: by 2002:a05:6830:4787:b0:6da:3409:fd90 with SMTP id
 df7-20020a056830478700b006da3409fd90mr3014641otb.62.1704776939291; Mon, 08
 Jan 2024 21:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-4-sumit.garg@linaro.org>
 <20240105204137.pdzgacapwpgpualp@bryanbrattlof.com>
 <CAFA6WYMoEcg+niaf+3+a29c9Fon5LrJQ9E5X7YtWyjEX_1RKDA@mail.gmail.com>
 <20240109015419.f6lwlhkudqy7uvly@bryanbrattlof.com>
In-Reply-To: <20240109015419.f6lwlhkudqy7uvly@bryanbrattlof.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 9 Jan 2024 10:38:48 +0530
Message-ID: <CAFA6WYM5P_8OaFuOMGwqCFFBwGwAui_uyVPX+gPFDsKFT_eePA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
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

On Tue, 9 Jan 2024 at 07:24, Bryan Brattlof <bb@ti.com> wrote:
>
> On January  8, 2024 thus sayeth Sumit Garg:
> > Hi Bryan,
> >
> > On Sat, 6 Jan 2024 at 02:12, Bryan Brattlof <bb@ti.com> wrote:
> > >
> > > Hi Sumit!
> > >
> > > On December 28, 2023 thus sayeth Sumit Garg:
> > > > Allow u-boot to build DTB from a different directory tree such that
> > > > *-u-boot.dtsi files can be included from a common location. Currently
> > > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > > location.
> > > >
> > > > This is needed for platform owners to start building DTB files from
> > > > devicetree-rebasing directory but still being able to include
> > > > *-u-boot.dtsi files.
> > > >
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > >
> > > ...
> > >
> > > >
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index 27b9437027c..09330421856 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > >
> > > ...
> > >
> > > >  # Uncomment for debugging
> > > > @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
> > > >  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
> > > >                $(UBOOTINCLUDE)                                         \
> > > >                -I$(dir $<)                                             \
> > > > +              -I$(u_boot_dtsi_loc)                                     \
> > > >                -I$(srctree)/arch/$(ARCH)/dts/include                   \
> > > >                -I$(srctree)/include                                    \
> > > >                -D__ASSEMBLY__                                          \
> > > > @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> > > >         echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> > > >       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> > > >       $(DTC) -O dtb -o $@ -b 0 \
> > > > -             -i $(dir $<) $(DTC_FLAGS) \
> > > > +             -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
> > > >               -d $(depfile).dtc.tmp $(dtc-tmp) || \
> > > >               (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
> > > >               ; \
> > >
> > > One of the issues I see with having a separate OF_UPSTREAM and U-Boot dt
> > > directory is when we have U-Boot board files that use dtsi files in the
> > > OF_UPSTREAM folder.
> > >
> > > For example our reference boards uses the primary bootloader's dtb (eg:
> > > k3-am62a7-r5-sk.dts) which #includes the k3-am62a7-sk.dts that will be
> > > found in the OF_UPSTREAM directory and modifies it to give it the
> > > perspective of the micro-controller it will be running on during boot.
> >
> > Thanks for bringing this up. I have been playing with the idea to
> > reuse DT includes from upstream.
> >
> > >
> > > What do you think if we have both paths included regardless if
> > > OF_UPSTREAM is selected or not? IDK if this will break anyone else
> >
> > Sure, we should be able to do that if we maintain the correct order of
> > include paths as per following patch [1]. If this works for you let me
> > know and I will include it for v4.
> >
>
> This works beautifully.
>
> I did have to hack around to get Makefile.spl working but this is headed
> in the right direction for me :)

Thanks for testing. I hope I can take that as a tested-by tag for this patch.

-Sumit

>
> Thank you
> ~Bryan
