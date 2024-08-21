Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AEFC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 05:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC8C88AF2;
	Wed, 21 Aug 2024 07:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vbG2IUfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8E888ABE; Wed, 21 Aug 2024 07:29:57 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312A888AF2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-429ec9f2155so44656675e9.2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 22:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724218194; x=1724822994; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D51lF/mLWweCn5phRg8Oz31rhgbG9ACBtdfEp0orsTE=;
 b=vbG2IUfA7wTMg+OLi1tAcpsBUBcUejvQ02Po9CLoq+WKtBpLlLQscibUYQcboUDMqR
 hNwodNG/dwGmSqL/Kn5cn0DTOva0VwtWWcbVSjzq1eF8Bo8XS6Gjy2q8O9zb07Yc8EFE
 9OVgpxyAVZc5ICU2B5c04kp1aMUbN26gl/ysSPcVSMOoUYkNJkyvSfPXHGkxFwqCn1OU
 YD5ZbiUJbjob8O7kwt1usHict9GbezP3uZQrY0lHA7VgL9TbicNinYJ8ZBO4J9Po3Lal
 ZOHna3sUgoGoJEv/RQWrTekdXcPG0fuomHmD3RNctHuxgCjOel0puaSwNjoJAAfCoCtY
 gIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724218194; x=1724822994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D51lF/mLWweCn5phRg8Oz31rhgbG9ACBtdfEp0orsTE=;
 b=aCNkP8VPTwyIEIpfMI167QK60/9vm96AATEFLTGI3C2Jbt7bKseCtc9nv5Z9S2jMXJ
 XrSVkaw5qpPLSjF9rloC7FQN/EcHN/dGnhXINIbbtHu5/AVUq+VkZlPEFPe2eAkAR+pK
 pmlhSUJLdTe33WAHpL0AlC9MfQZjX3+a6nsMxWkH6yAQyirBLdfMbBxD7y7RipefxLBm
 xhqYKpSCh6IZBZgEZk2YZB0R1Yv+my/6ydeSuJ7/8GhSr8MfvCUlMkMJzDNjhtLiYe76
 RvZ8zNqZlyqKNtOuXiTjWK3PNXRGpHZfz2yUh84VZLLom6TqpyEl4W+V6Gzw8yTpqiR/
 IRzA==
X-Gm-Message-State: AOJu0YwkgPiW58v/XtXAIJT6UiSszyklY9w98VVJ008vYdxMFzlUbuSn
 aWOtDK06ZvjxTZEFUUrSIyLGJTN5w8gyhc+/XHvYEpfmjtw6QMVno1JIZpvBFoPA542kkVpUv3A
 kqmkrA9VGWsoOtDvwePPJfdvOW6YmH9J2ZKd1rg==
X-Google-Smtp-Source: AGHT+IHVoTnLv8U5yZkkc3gpXTa8Y/rqDVvL/TYYcjwDJvQ9ocEjz/9EqWQYfEY4l2LUIayv2lCWb3VblmiN+rko9po=
X-Received: by 2002:adf:ec44:0:b0:371:88b9:256d with SMTP id
 ffacd0b85a97d-372fd586c98mr801851f8f.6.1724218194286; Tue, 20 Aug 2024
 22:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-15-sughosh.ganu@linaro.org>
 <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
 <CADg8p95k_0CtqD5x8_jjW31YoPOoiLSvDU-M_JtcBU_+V-4hEg@mail.gmail.com>
 <CAFLszTji1FcHNitO+mKJ+uh-Kr5N33ZZjqZJx1Uaianj35Q4vQ@mail.gmail.com>
In-Reply-To: <CAFLszTji1FcHNitO+mKJ+uh-Kr5N33ZZjqZJx1Uaianj35Q4vQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 21 Aug 2024 10:59:43 +0530
Message-ID: <CADg8p94QuMpjP3fU0Rz7Y2gzpM=93RdxFxLM7c7DkpRtnkVL0A@mail.gmail.com>
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

On Wed, 21 Aug 2024 at 07:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 20 Aug 2024 at 02:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 16 Aug 2024 at 02:04, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Introduce a function lmb_add_memory() to add available memory to the
> > > > LMB memory map. Call this function during board init once the LMB data
> > > > structures have been initialised.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1:
> > > > * Call the lmb_add_memory() from lmb_init() instead of
> > > >   lmb_mem_regions_init().
> > > >
> > > >
> > > >  include/lmb.h | 10 ++++++++++
> > > >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 52 insertions(+)
> > > >
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > But this should not be weak.
> >
> > This is being made weak, as there would be lmb_add_memory()
> > definitions added for powerpc and x86 arch's in the EFI part of my
> > patches. Moreover, the lmb_add_memory() function would be called even
> > in the SPL stage when LMB is enabled for that stage. So I am not sure
> > how do we get around this. You can check the relevant branch [1] on my
> > github to check for the specific commits [2][3] that I am referring
> > to. Thanks.
>
> This is really strange.
>
> The e820 is different on each x86 board. I'm not sure we want that in
> the lmb. What is the purpose of that? It is somewhat circular in most
> cases, since U-Boot sets it up itself. Where it comes from coreboot,
> it looks like we are mirroring it in the EFI memory map. I'm not sure
> I understand all this very well.

Yes, me neither. And I want to keep the behaviour same as before the
patches. You would know that the function efi_add_known_memory() gets
the memory map from a function install_e820_map() which includes
conventional memory, which is the ram memory. And I am basically now
doing this as part of the lmb_add_memory() function instead. Are you
sure that we can do away with this function, and instead use the
ram_base and ram_top values from the global data structure instead? I
believe you have boards which exercise this code? So it will be great
if you can test this if I remove the function for the e820 module.

>
> For fsl, perhaps copy the #ifdef and handle arch.resv_ram in your code?

This is for adding ram to the lmb memory map, but yes, I can check by
putting an ifdef in the function. Although the function might look
ugly and hackish. Thanks.

-sughosh

>
> [..]
> Regards,
> Simon
>
>
> > [1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_v3
> > [2] - https://github.com/u-boot/u-boot/commit/077ced7aaa6d495b1b87b324fb1c60658c203ce1
> > [3] - https://github.com/u-boot/u-boot/commit/d0fa3a89865b796f3bbebffebbe4f7b5b048c140
> >
