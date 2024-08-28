Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9BBC636E5
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 17:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305F9885A0;
	Wed, 28 Aug 2024 19:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WPq/gtBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D388862E; Wed, 28 Aug 2024 19:06:43 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5958841E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 19:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf6721aae5so35782066d6.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724864799; x=1725469599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PdchJK3idfmVZIwbsSydS21PMv3QVDa+PrgUcKuPVJU=;
 b=WPq/gtBw2LR/pcutZL7QH22gy/SqKhHEdFpih7m+droiCguYA8jifRzShJV+VmBR67
 VzsCmIiXCa2SgQKvdGGtDNXCXqQClfl1Wxo2NATnvAmGfcySek6gGmrm0RnGoQcFr5GG
 QGGM4IFJ/9KHjorrYEstj0ib4DopKTRUsPMUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724864799; x=1725469599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PdchJK3idfmVZIwbsSydS21PMv3QVDa+PrgUcKuPVJU=;
 b=VtaIIv/Q6bp7ITAXKufjc+bkt+DG7s7fKfY2gphWs3Aue4JxRKSj82YOnljmFK0frQ
 IDE867+Woi/9zKkzDxEZgxcdmcV5o4kdPDvcPTpJ91ChbC33aMVhTWnGoc+sbqGmHSaM
 R4/Ji/18RHlcoEnyO5Ke2mZp5Ax6fmR1JaGjmtWhNli0fCaKGCyZyJ5gAvcbTVph862E
 GYESUa8xsshO6F6EDX62KVHU9oZLzvO1owa5WZfE1m/L3yUNjaboqIcYHY6kDUyJ2vVp
 q0Mcz9OSks5oAUwfVdcFpYsis72ucVqT82bq7R381G9PyInB4tygpCPjai1DuOwL3o3z
 kbXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDCQZsTkJXEDzF0wdsoioWj8R1FJoc/rX04Pqno6HGJ4a0/yOPwczSYOyUwItRDAyn2rpDYww=@lists.denx.de
X-Gm-Message-State: AOJu0YyLUQgdZ6JBrlwJGEPAM00XFvwwWs7z7j3ER4IjLwR1qGe5fcKp
 dAQdfFYSJk5kmWhP0uWy4o3r8CEhBjM3QQ+WzomY3o4G+ow8u+xzZkFlZ9+9FRTBgn3/4WJjj1Y
 aN1O6zp4YhfLCDnZFlDIJX6YN7j/FIp8z4YLU7mhCPr3pZ/w=
X-Google-Smtp-Source: AGHT+IF2fXaP+V8We5uzv2mqn25bojPhAmmM5CAUT+MO970x1lfjpdGm+tGLBF/niFw0g98UHoMrCuG4zPWCKjPX39o=
X-Received: by 2002:a05:6214:5882:b0:6c1:76c6:b673 with SMTP id
 6a1803df08f44-6c33e617151mr1595166d6.22.1724864798957; Wed, 28 Aug 2024
 10:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-3-jonas@kwiboo.se>
 <CAFLszTha39GkRsZA1r91YpLdKJDiRfDmAzWsMTuByDtPC0YvGQ@mail.gmail.com>
 <CAFLszThNN-rfPtAYKSHtGTEUwuxFgz01A-yJMXRYtwX3WiA-Kg@mail.gmail.com>
 <0329ee07-3f99-4daf-8960-1e934ff753de@kwiboo.se>
In-Reply-To: <0329ee07-3f99-4daf-8960-1e934ff753de@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Aug 2024 11:06:28 -0600
Message-ID: <CAFLszTgGhy+nY7MGDi19ZeB7ptstmXFwWG4NRUECtdjqPfMZSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] bootstage: Do not sort records
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jonas,

On Wed, 28 Aug 2024 at 10:15, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-08-28 18:01, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Tue, 6 Aug 2024 at 15:50, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Jonas,
> >>
> >> On Sat, 3 Aug 2024 at 06:42, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>
> >>> The timer counter on Rockchip SoCs may be reset in TF-A, this may cause
> >>> the bootstage records to be printed out of order and with an incorrect
> >>> elapsed time.
> >>
> >> Eek can we just fix TF-A? That seems like a bug.
>
> TF-A is vendor blob, so we have no control of it.

Can we replace it, or is it one of the ones that has not been released?

Can you file a bug with the vendor?

>
> >>
> >>>
> >>> Fix this by not sorting the bootstage records.
> >>>
> >>> Before on a Radxa ZERO 3W (RK3566) board:
> >>>
> >>>   => bootstage report
> >>>   Timer summary in microseconds (12 records):
> >>>          Mark    Elapsed  Stage
> >>>             0          0  reset
> >>>         7,436      7,436  board_init_f
> >>>       164,826    157,390  SPL
> >>>       375,392    210,566  end phase
> >>>       423,909     48,517  board_init_r
> >>>       472,973     49,064  eth_common_init
> >>>       476,848      3,875  main_loop
> >>>       477,003        155  cli_loop
> >>>
> >>>   Accumulated time:
> >>>                    7,181  of_live
> >>>                   14,739  dm_spl
> >>>                   15,029  dm_r
> >>>                  315,150  dm_f
> >>>
> >>> With this the records can be printed in chronological order when the
> >>> counter is reset and SPL and board_init_r records show correct elapsed
> >>> time.
> >>>
> >>>   => bootstage report
> >>>   Timer summary in microseconds (12 records):
> >>>          Mark    Elapsed  Stage
> >>>             0          0  reset
> >>>       164,437    164,437  SPL
> >>>       375,023    210,586  end phase
> >>>         7,437      7,437  board_init_f
> >>>       424,390    416,953  board_init_r
> >>>       473,515     49,125  eth_common_init
> >>>       477,402      3,887  main_loop
> >>>       477,571        169  cli_loop
> >>>
> >>>   Accumulated time:
> >>>                   14,734  dm_spl
> >>>                  315,646  dm_f
> >>>                    7,339  of_live
> >>>                   14,977  dm_r
> >>>
> >>> For the tested board external TPL and BROM take ~164 ms to initialize
> >>> DRAM and load SPL, SPL take ~210ms to load images from FIT and U-Boot
> >>> proper take ~477ms to reach cli prompt.
> >>>
> >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>> ---
> >>>  common/bootstage.c | 12 ++----------
> >>>  1 file changed, 2 insertions(+), 10 deletions(-)
> >>>
> >
> > To put this more strongly, this breaks the timing output on other boards.
>
> Please elaborate, I cannot understand why not sorting would break output
> on other boards, are other boards adding records out of order?
>
> Do you have an example of how this change break other boards?

Oh sure. The original reason was that the array was ordered by ID.
That was changed in [1], which I forgot about.

The other bit is for coreboot (or potentially other prior phases) we
receive timestamps as a block and add them into U-Boot. We want these
to appear in the correct order with respect to the ones already adding
to U-Boot.

Sadly coreboot uses its own toolchain and I seem to have deleted it,
but once it finishes building the world I will give it a try.

>
> >
> > At the very least, this should be Kconfig option just enabled for
> > boards with a broken ATF.
>
> I can add a Kconfig option, but would like to understand why other/any
> board would need to sort the records in the first place.

OK.

Regards,
Simon

[1] 03ecac31498 bootstage: Use rec_count as the array index
