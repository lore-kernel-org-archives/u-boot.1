Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4A0CA0FE4
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 00:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D35C86682;
	Fri,  1 Sep 2023 02:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SQDv6RCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 925F3865A2; Fri,  1 Sep 2023 02:15:39 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D23866BB
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 02:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so2717353e87.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 17:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693527336; x=1694132136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WonZxcv1vTHhpBOx7kmNn2Xb9D00e84T1xH6B9U3gec=;
 b=SQDv6RCuZn8JCRjARy1EnDVpm0lXUzTZ/4zIj8CmSUaynFb/iRSPExu6yE88o/nODT
 8wZQXaAvb7OHi+M5VhLDWVGmkq0d2V1wyc51jhF76NDL8b8yTJ7lKNF+LuHq68JuaXNG
 oCEg+s8KFxUS+BLbJVMG3qp1dfbjK2j2t+zSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693527336; x=1694132136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WonZxcv1vTHhpBOx7kmNn2Xb9D00e84T1xH6B9U3gec=;
 b=MNPc+GEGjAWRxWT7VHgljUpdQO3MjWqoV1j4+9HvP7JH4eS9rgX89fHBfOY/MQAEqK
 giTTHwPmB8LSTKVAv6wl23rNwgmvqx7mphcKyoPkmIPehs5jDCWWS3YUz/0NwiB5hK1M
 98vvVn+IcQ4jUhqSN5kI3/25GvH3G6R8V54SjxpzNUsJrsXX44xwskpdGggDsJqOM6ym
 a3iKm8z/gMEBkBW3w2hWyOa94wUhb5GOZEfrnjLt1Gglo262dR1tRVkDP+g5zzZ1F7C5
 MO80osZZcHkUaWHQravYem0cmKBl+yT/EdlSEEJ2hX8Ec6Dw/XHyK+uTRW93qqX9j+AC
 wvYQ==
X-Gm-Message-State: AOJu0Yzg0V1Pc8mrJtg8LEohc6bUxRqx8DHzjIyUX8+RQU1czLaPByFe
 nWoYdh/JDB0+VdeTmf9kT8HuVsB4NP4xNWYWlvrWQw==
X-Google-Smtp-Source: AGHT+IHMoQw0PHhnxyDxMeKrSbVtlwjT8RrEBR59jOgWvQpfbqt7zmLXdvHajrBE7JVV4k00ycubKQT5HW6KlqSSjSM=
X-Received: by 2002:a19:e006:0:b0:4fe:4f8:8e75 with SMTP id
 x6-20020a19e006000000b004fe04f88e75mr425208lfg.68.1693527335720; Thu, 31 Aug
 2023 17:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
In-Reply-To: <20230823151400.GK3953269@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 18:15:19 -0600
Message-ID: <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
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

Hi Tom,

On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
>
> > When lmb runs out of space in its internal tables, it gives errors on
> > every fs load operation. This is horribly confusing, as the poor user
> > tries different memory regions one at a time.
> >
> > Use the updated API to check the error code and print a helpful message.
> > Also, allow the operation to proceed.
> >
> > Update the tests accordingly.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> > +     if (ret == -E2BIG) {
> > +             log_warning("Reservation tables exhausted: see CONFIG_LMB_USE_MAX_REGIONS\n");
> > +             return 0;
> > +     }
>
> This isn't the right option.  Everyone has CONFIG_LMB_USE_MAX_REGIONS
> set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
>
> But it sounds like what you've found and fixed is an underlying problem
> as to why 16 regions isn't enough in some common cases now?  So we could

I don't think I have fixed anything. But I'll send v2 and perhaps it
will be clearer what is going on here.

> possibly avoid the string size growth here and have a comment that also
> matches up with the help under LMB_MAX_REGIONS?

I don't know, sorry. The size of struct(lmb) on 64-bit sandbox is
about 400 bytes. There seems to be a lot of code to save not much
memory.

Regards,
Simom
