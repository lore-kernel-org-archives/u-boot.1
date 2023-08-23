Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB385EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B54860CA;
	Wed, 23 Aug 2023 15:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="lBXYkkQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F23864AD; Wed, 23 Aug 2023 15:36:17 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98336807F9
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-500913779f5so2401049e87.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692797775; x=1693402575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VmrIxyJ6vdnpaSRdYdbtvjt0ZiOfJl8ZHdtXfYtG8Kw=;
 b=lBXYkkQ3H3C6ndcHaFk2BsuaZ6RxSMVcVPwbtyL5+XSPHAe4XYaoNfmy7WZa7lIyES
 q06yaLQy2q+Xqnk+cJHT6gBkGiPZQnTFCLUNPM8brsDvCRgl9N6YLC1ykITGs0C307Tr
 jHPv9wV4vRhJUROQK4r2V0EW8o+OU1JZ87qr43Uuka6WVBP9zC+btqZAVwkYS5aHSH4D
 eWAHOKY5fjne3c7gY8z1deJZybTuIv1Ypw1cTfcSHnMc71hdhFPzZUzS7lQ3CVzDL7mt
 uKDn4nohT+XeIZsqG1g92dm0ZWHh1G/zXlubTOt9yBvgevJpMW4eo3nyJTCrvW7Iqug9
 hA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692797775; x=1693402575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VmrIxyJ6vdnpaSRdYdbtvjt0ZiOfJl8ZHdtXfYtG8Kw=;
 b=ZpfryCWh8V5/xFPrE2vO4B+oAJQFv8pe92ha9gDoB6lfZoQLu1hg4+NZ/CgCwLhLXU
 Bx8eCnhLyTMuV1nu8GxQqcmvX94HkUVb037TFIf+0ynD1hXJF8QmkTgpk0WV8v4njzIV
 tCVb+MfxkDjRTNkks7uekafPEjy2eni4wiWmiUpUUQoW9jWo6eI4YJKHVDyzGxLvDXnv
 S2vAQgf1Ub3VdyCcjwuBnYkX+kR233I2gaAYujmktW+lDQ1KnDdrGj45o3k4x2XZG2H2
 CTU/HN6uI/c0dlvCJmbXlZLbSDWoLjfFP6iagcFseXa8rvJoQt8QRDc1PX9gLUfQE/5S
 3MCg==
X-Gm-Message-State: AOJu0YyYAvze+TvEVwwow2CdqQqkwNGgtcsyOX4JG0QqGK+cpMSZBuK4
 E008BpXc/IkKya2XkUMxGYF/XjvqrRQUA1aGgRVGEg==
X-Google-Smtp-Source: AGHT+IHVH5UUOgl/QxkkdvkYVQTuPxKITRbKesN/FaLGdr/FukVt+9hXHnhYfS4+tuWJBZDekRmMc4lido1LfJMIUpQ=
X-Received: by 2002:a05:6512:312b:b0:4fd:c884:51fc with SMTP id
 p11-20020a056512312b00b004fdc88451fcmr8035269lfd.58.1692797774587; Wed, 23
 Aug 2023 06:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051103.2427590-1-chanho61.park@samsung.com>
 <CGME20230818052645epcas2p48c419f6e6318ddadb425749319fbc3b8@epcas2p4.samsung.com>
 <20230818051103.2427590-2-chanho61.park@samsung.com>
 <13e08d65-8c3b-4804-8e16-4399076e45dc@rucky.eu>
In-Reply-To: <13e08d65-8c3b-4804-8e16-4399076e45dc@rucky.eu>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 07:36:02 -0600
Message-ID: <CAPnjgZ1YjaKO34=TiRjDWj5mb9_qAeXdjkQUiCXRbBnSNkCifQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dm: event: add EVT_DM_POST_INIT_R event type
To: Roland Ruckerbauer <roland@rucky.eu>
Cc: Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
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

On Mon, 21 Aug 2023 at 21:47, Roland Ruckerbauer <roland@rucky.eu> wrote:
>
> Tested on visionfive2 board, it works. Thanks for taking a look into this.
>
> On 18.08.23 07:11, Chanho Park wrote:
> > This patch introduces EVT_DM_POST_INIT_R event type for handling hooks
> > after relocation.
> >
> > Fixes: 55171aedda88 ("dm: Emit the arch_cpu_init_dm() even only before relocation")
> > Suggested-by: Simon Glass <sjg@chromium.org>
> > Cc: Bin Meng <bmeng.cn@gmail.com>
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
>
> Tested-by: Roland Ruckerbauer <mail@ruabmbua.dev>
>
> > ---
> >   drivers/core/root.c | 6 ++++--
> >   include/event.h     | 1 +
> >   2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/core/root.c b/drivers/core/root.c
> > index 6775fb0b6575..79d871ab291a 100644
> > --- a/drivers/core/root.c
> > +++ b/drivers/core/root.c
> > @@ -436,8 +436,10 @@ int dm_init_and_scan(bool pre_reloc_only)
> >                       return ret;
> >               }
> >       }
> > -     if (CONFIG_IS_ENABLED(DM_EVENT) && !(gd->flags & GD_FLG_RELOC)) {
> > -             ret = event_notify_null(EVT_DM_POST_INIT_F);
> > +     if (CONFIG_IS_ENABLED(DM_EVENT)) {
> > +             ret = event_notify_null(gd->flags & GD_FLG_RELOC ?
> > +                                     EVT_DM_POST_INIT_R :
> > +                                     EVT_DM_POST_INIT_F);
> >               if (ret)
> >                       return log_msg_ret("ev", ret);
> >       }
> > diff --git a/include/event.h b/include/event.h
> > index daf44bf8a83b..bb38ba98e73b 100644
> > --- a/include/event.h
> > +++ b/include/event.h
> > @@ -24,6 +24,7 @@ enum event_t {
> >
> >       /* Events related to driver model */
> >       EVT_DM_POST_INIT_F,
> > +     EVT_DM_POST_INIT_R,
> >       EVT_DM_PRE_PROBE,
> >       EVT_DM_POST_PROBE,
> >       EVT_DM_PRE_REMOVE,

Applied to u-boot-dm, thanks!
