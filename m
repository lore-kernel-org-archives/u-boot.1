Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB31C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 22:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442EF87067;
	Sat,  4 Nov 2023 23:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YTXYHz12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2898703A; Sat,  4 Nov 2023 23:58:06 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D376087034
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 23:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9dd5879a126so232116966b.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699138680; x=1699743480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iSynca1gQPDDohdwk0wNYs+TtVnbonJLHV7iSF5+pIM=;
 b=YTXYHz12cW4KlXyOhQHeGUGjXLKSc5VITVj/7qhPjRDUOM3ghRewhOOtMKPoAy/g5H
 pYbwyOqwE8mnUMRKIvA16qG0GnHz67vyejm9f0E/IxlTANuGgmY+rh2Fdx+ZWe0vShnJ
 t4o7W+xYeETpBI9qIVRCki9vJxaNgYHo3XUR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699138680; x=1699743480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iSynca1gQPDDohdwk0wNYs+TtVnbonJLHV7iSF5+pIM=;
 b=aeaYPHLhlzs5VR5eZzdiqxeMqIY1+Iv4OHbm59LN1/CGq2F92Vz0t+Q4buMSjIUaVe
 wj2KrqXJlU/lCv4uMA6X6voq/q6ZPA+JykBd/gRKWzdgplokytf3u6wTnBlfs9i+DonC
 Ic1AyPVkgaO334A0szS5xEiusLaRF1/cm6rWUyEAlCtUNrz25yyyg6okQFFttqCZVDvo
 LIKBRxvVRpy1OyBdirb+bhGz4JtkHDIXgqEEJVlzemregAOjdr3pKKtEetp16d2n5RmN
 1/T3ZzcS5Zp8X/wnRl4bqtViix6S7WaeUeDfSjqAEb6OETNx+X5gJHLqLu/zRpynQBjZ
 FUlg==
X-Gm-Message-State: AOJu0Yy5Nyt8nPDoWMSrv5ydwGuWAPaX3Pfq7PEiS4MU18HuywMvYoyJ
 Ig+xGFBIeZFkC2BBDwejt/T6Rwd3ZVaqX7p0nKHAjA==
X-Google-Smtp-Source: AGHT+IFLzZlgfgbgIVA43Q+GdmUee9OXA0avbLevJQZY77PWj+0IWtMbzAS83TnU/3kJRAq92TAKzdWQAL16L/RaeBQ=
X-Received: by 2002:a17:906:da87:b0:9dd:bfe4:21cb with SMTP id
 xh7-20020a170906da8700b009ddbfe421cbmr3602528ejb.5.1699138679682; Sat, 04 Nov
 2023 15:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231104184716.13743-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3st2CHJeSVkZGL-N7fDQqebK9VD0vodsXaz+Er96sB1g@mail.gmail.com>
 <ab1b51cb-3d7b-4e65-b28f-e42e6a0c70cb@canonical.com>
In-Reply-To: <ab1b51cb-3d7b-4e65-b28f-e42e6a0c70cb@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 22:57:39 +0000
Message-ID: <CAPnjgZ2fbA1ySUnz=df7+U5bVNSF78aB7-hSN=k4E2C9QrZHRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dm: fix misleading messages
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 4 Nov 2023 at 20:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/4/23 21:45, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 4 Nov 2023 at 18:47, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> When no RNG device exists for a driver referenced via U_BOOT_DRVINFO() we
> >> get messages like:
> >>
> >>      No match for driver 'arm-rndr'
> >>      Some drivers were not found
> >>
> >> This is misleading as it is not the driver that was not found, it is the
> >> device that is not found. Correct the messages.
> >>
> >> Reported-by: Andre Przywara <andre.przywara@arm.com>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   drivers/core/lists.c | 2 +-
> >>   drivers/core/root.c  | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> >> index 8034a8f48d..e39d3acc97 100644
> >> --- a/drivers/core/lists.c
> >> +++ b/drivers/core/lists.c
> >> @@ -97,7 +97,7 @@ static int bind_drivers_pass(struct udevice *parent, bool pre_reloc_only)
> >>                          if (CONFIG_IS_ENABLED(OF_PLATDATA))
> >>                                  drt->dev = dev;
> >>                  } else if (ret != -EPERM) {
> >> -                       dm_warn("No match for driver '%s'\n", entry->name);
> >> +                       dm_warn("No device for driver '%s'\n", entry->name);
> >
> > This should be "No match for driver_info"
> >
> > It is not a device
> >
> >>                          if (!result || ret != -ENOENT)
> >>                                  result = ret;
> >>                  }
> >> diff --git a/drivers/core/root.c b/drivers/core/root.c
> >> index d4ae652bcf..29c918eb73 100644
> >> --- a/drivers/core/root.c
> >> +++ b/drivers/core/root.c
> >> @@ -167,7 +167,7 @@ int dm_scan_plat(bool pre_reloc_only)
> >>
> >>          ret = lists_bind_drivers(DM_ROOT_NON_CONST, pre_reloc_only);
> >>          if (ret == -ENOENT) {
> >> -               dm_warn("Some drivers were not found\n");
> >> +               dm_warn("Some devices were not found\n");
> >
> > Some driver_infos were not found
>
> This suggestion does not match the case that Andre and I were discussing in
>
> https://lore.kernel.org/u-boot/1ad4bd2c-e667-42b6-b637-8816a6c60d94@canonical.com/T/#m13fbf9011d74f713080284fb9963c90646d527fb
>
> U_BOOT_DRVINFO(cpu_arm_rndr) is triggering the arm-rndr driver's bind
> method. The bind method returns -ENOENT if there is no matching device.
>
> Neither the driver U_BOOT_DRIVER(arm_rndr) nor the driver info
> U_BOOT_DRVINFO(cpu_arm_rndr) is missing. It is the non-existence of a
> matching device that triggers the messages.

There are various errors which can be returned.

Then perhaps for that specific -ENOENT code you could indicate that
the device was matched but refused to bind? We just need to avoid
confusing language, although of course what is there is confusing too.

As mentioned to Andrew, we should not be using DRVINFO records outside SPL.


>
> Best regards
>
> Heinrich
>
> >
> > They are not devices
> >
> >>                  ret = 0;
> >>          }
> >>
> >> --
> >> 2.40.1
> >>
> >
> > Also please add a Fixes tag, I think for this:
> >
> > 20e442ab2df dm: Rename U_BOOT_DEVICE() to U_BOOT_DRVINFO()
> >
> > Regards,
> > Simon
>
