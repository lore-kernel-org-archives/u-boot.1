Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCE5C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD334865A5;
	Thu, 24 Aug 2023 16:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H3XeDmxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9732986672; Thu, 24 Aug 2023 16:48:20 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9548077D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bcc187e0b5so66600671fa.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692888497; x=1693493297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RHWA1SJKu0dI6PLS8zYcuguRnKLlN6fUAgdyEuRSEzM=;
 b=H3XeDmxCkYWAXkjl9/miUeYTRuC5/rfgpQrFEB0blVVscv+1uDuySLOjbhOkMxz7rF
 UpR55V8LJp+TqJBvsKFZXCD9Sb0DPdoCRgfdFjBMvhvPV6PYzn1UAibEbEiougglS/Kh
 b9QFX9O1Q6TBfvphf9UiyERUwaZnQvRakiJxMIb0DcIVOqMFgwcqZwYVDt1SZlXqPDeA
 kAYTxxB3sWXqq7OD0EVlzVgs/AHkQKml9S2ojbSx5LJv1UjFD6JYdByXmSDxfekY53S8
 W33gj+fRy/+7vrM/2cEE+140dLhjZMeOv/o76WnZGpuJKfxeio35yC4Y4f/p/Dfg21lT
 vUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888497; x=1693493297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHWA1SJKu0dI6PLS8zYcuguRnKLlN6fUAgdyEuRSEzM=;
 b=XpyIWYcNnymB583usUDljOR32qdyzkbUonx1GYNkP6yJR2WlaYf0ZuPKqbCNg6dXe5
 R0JB0296UcjwjSfslaanl+amNj8E2Pkq/+iXPlRzTYmnL4jfmDBZuOIYPHGt1bu/qy46
 7+chPlSG5S6vh6JkAXq+fn9sNgmqjNSdCKEcm4gIjAdkwXV7YUDrSavn89TGegbB9zZz
 hbcxzF6pLtm5WkRGAVaEMSRwpDR3qWZ0CRHlu4z1/N3UlP5V4GX9JUpZmbmc/WyXWbSL
 0ZIrGyTTltEXAZ4xK6rB9LreLIDbOfo1L3zE5qT36OoqK1wkLA47/ikmFtnmkm8kjFxw
 zIaw==
X-Gm-Message-State: AOJu0YyGmIqUqQOGJEmHtebsCoNnk+GscR97NpUo8DHgZzjtD83/GPCN
 7o+oYnbIwnl7kU6D0IrnYMziZiPz+PCVRMm5PHZXCg==
X-Google-Smtp-Source: AGHT+IFbjRq3YEkXbYbV+e1IJFG9O5fKaGBrn7cMEz07NVG4ElqmJfYlZI8BPirq68g/J9KM7X/yjM2UpOkuEWjmkts=
X-Received: by 2002:a05:651c:224:b0:2bc:d7d6:258f with SMTP id
 z4-20020a05651c022400b002bcd7d6258fmr5178227ljn.35.1692888496703; Thu, 24 Aug
 2023 07:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230824142109.2401528-1-ilias.apalodimas@linaro.org>
 <CAPnjgZ0JZCrPOCUZDgL10zXdB+LQQtv2MXZPcpcxXDY+u8MhHw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0JZCrPOCUZDgL10zXdB+LQQtv2MXZPcpcxXDY+u8MhHw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Aug 2023 17:47:40 +0300
Message-ID: <CAC_iWjLWQhZrZkhK02dS=gQG7Z7y2-cQ6LtKnnrm3tur3J4KPA@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: delete handle from events when a protocol
 is uninstalled
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de
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

Hi Simon,

On Thu, 24 Aug 2023 at 17:41, Simon Glass <sjg@google.com> wrote:
>
> Hi Ilias,
>
> On Thu, 24 Aug 2023 at 08:21, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > When a notification event is registered for a protocol the handle of the
> > protocol is added in our event notification list.  When all the protocols
> > of the handle are uninstalled we delete the handle but we do not remove
> > it from the event notification list.
> >
> > Clean up the protocol removal functions and add a wrapper which
> > - Removes the to-be deleted handle from any lists it participates
> > - Remove the handle if no more protocols are present
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since v1:
> > - use the non safe list traversing macros on efi_register_notify_events since
> >   we don't delete anythig from that list
> > - Add a comment explaining the code that preserves the handle in case of a
> >   removal failure
> >
> >  lib/efi_loader/efi_boottime.c | 89 +++++++++++++++++++++++++----------
> >  1 file changed, 65 insertions(+), 24 deletions(-)
>
> Is there a test for this behaviour?

Not in -master.  I've sent it in the past [0].  But instead of merging
that series, we decided with Heinrich that a bigger cleanup was
needed.
So we had to do a bigger cleanup of protocol handling [1] [2]

[1] https://lore.kernel.org/u-boot/20230620061932.113292-1-ilias.apalodimas@linaro.org/
[2] https://lore.kernel.org/u-boot/a222ec75-32ef-9dce-0855-afde2702c618@gmx.de/

Once the last part gets merged, I'll rebase the test and send it over

Thanks
/Ilias
>
> Regards,
> Simon
