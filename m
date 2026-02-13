Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDA7EF99C1
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DFF83AA9;
	Fri, 13 Feb 2026 18:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AjCay2KJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875B183CB5; Fri, 13 Feb 2026 18:53:39 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF2A83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8f992167dcso148921366b.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771005217; cv=none;
 d=google.com; s=arc-20240605;
 b=MPDw6jSY7U3LIonrTxhcBUMju5/k3F13iYfLg1gOIuTWbEdk+U6WTZCOm0RUxas/7h
 IniVwGOjaVOWf+fDigIJlBeuIrXm9FrkjtFQBYAPi5V4QSjbVCP7nTE/FTd0aWsoNa2b
 BpPdXT58GKyE1Vjl23HD2Tmoz8/R/+zHdrmYH4XAeh3kyazid6P3W90jqAylICESoyme
 BdMIMYadjwEOXSF/fmP1GB3SHy9wO+Xik6UsdyctopiPxJbqFo8cYDEpPQr1YG9VXEOX
 djhk7UTC7kbM5uMB28K1RW0akdejB1Eb4gBMgoRDidcVS7wgA1dWCo9X8NJLTLcq6hJC
 X7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3/U3O9ZhnT/LlXFSuowQPns4T1aRA/daIiCZ7KXz/1U=;
 fh=MeQdUOgQ9An1YOR2OwM9tgU5INTZJJBn2o+ZH9ZYpMU=;
 b=TyxmOSlhv34UgTjOTncTSnI9x7HApvZUvm5+KGh0s1VKGqP48RGSJhMXr7H5leb0pX
 3R1AJ/oAtXlFpAeBvJ4Aoz8i/bccXz++RT8tHgwjKmVI/BL/P7pHQ3QyAbX7H0a5K9Sv
 El/s/soaOU4a37JJ4gAxIE4bMSWOvuXhI6xDNGLrAVwPlp2tcUAdpjkDhjAEyiAx0/RE
 5cRXAXDzkOxYYIrF7eswmjewv5KMJETCSW1iVve+sq7w82HeJxwvYtTSz75OJLCYRaif
 pMzFcXomrHXjb3Z8xJE0OyL03oV2wiBBGqMcTj1th+g9gIZeoaeZ6el3eO7oBhMBgwP/
 Pl9g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771005217; x=1771610017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3/U3O9ZhnT/LlXFSuowQPns4T1aRA/daIiCZ7KXz/1U=;
 b=AjCay2KJiSRgEJVpdM0KOFRn3hCsNAKL/UmZ72yP4n+OkOLJg42XNZeSFhsiyqtGZJ
 zbXEfuKfUXZyOH02iZbAFUAKRYou1bAqUmUSRsbrrdorgPnLGTfBghh745Tmm0iuHZo9
 YqzdeX8YRa6WMKPhLBIJmj4qWeNFAiHNbq1pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005217; x=1771610017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/U3O9ZhnT/LlXFSuowQPns4T1aRA/daIiCZ7KXz/1U=;
 b=Xi/SMWBFmDJoO8gJKxCqtLWfSzTPyI2P/P1XRR383NSRIQQ7cStiHH+dxZGD3mRXaB
 AYT1J1BvAeQuPBRfDHevPnGdrsLeWTdMbmUsxvjYo7LvJnaAU3ZtbNRdC9HECuYN7QVy
 TWVsvYqo0leK0CP8WXW+4fQUuwqP7KRLvQha9vCYVRjgIiLiA2Yuj+zF3ejHGWRbGtXy
 /z7Fawuu2QTPAS8Pytn7YTZLPVX3pz2WImJSJAdj8yjl+7oPGsIGiGJb4nx131widvbn
 l/6IflQsd+uqrIqr9dd5g1dx5POvVVc+GFZN0EscuuQN+HexKcSxuK4njp3mxpA4UCFj
 MRjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyn4h61RBm9nDHuGGFtVnSRjuMD1Cgc1n4OvWzs64wxvllNNxihj+jb0QIvSzVE9AOVtE43nE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4nWeqFLi/MfA78KcW3IQUQEo66Rm8Kczvh0z7N2lh/BJ2gK1m
 dZIYG4SP22qiIPICl8vzeiPxFT1smjZkTKwepXFMxKaagNv21U4jwJAQZc1VhaCAPcPzF8HwvB9
 ZUCn50O4KTxegHoP8bFsOl/6xI6GMfpX++EbFuLgj
X-Gm-Gg: AZuq6aLsSkOk6Vws6SVINfrfJIaTyi31BmOtrIZn8Wpsv0jwrqtaJAyzCj9OFYh9OHy
 tvlr5I4f5z4Is5GICnXU/+DW2A2HGggyrtIPTIgs3lUOUGQcPaxUXhChZ1AdsU/Pvmvl8vCWwn7
 Zya0SyG3IlUowWXFg9Gpl+F81ELmcxiBju0ZZsE9nQV5u1OKuyN9K9M11MzDLZZRYRpU1DoD3CC
 bQWItn0A7eTm8AXYDlOrn54Lsm3Ag1qoNyGKIlKI3LsQ3Hvxg3zcObJl8VG9Sx8YMI/rtOQ69Aq
 I7nlEA==
X-Received: by 2002:a17:906:7312:b0:b87:39d:2bb4 with SMTP id
 a640c23a62f3a-b8fb456be7cmr149673466b.59.1771005217045; Fri, 13 Feb 2026
 09:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20260209125554.14700-1-pbrobinson@gmail.com>
 <92c43984-c2d6-4753-adc5-627e210936b8@suse.com>
In-Reply-To: <92c43984-c2d6-4753-adc5-627e210936b8@suse.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 10:53:22 -0700
X-Gm-Features: AZwV_QgfOnbaJ0s3dHdXRtcLXma-SVOigPUTRW4IuQBwMjuQJWm_EYWkhO5t5Zk
Message-ID: <CAFLszTgEJq4T4D5Rok2QS+AYZ7U5gdVZpX7-t8nG6h_bFFZVfQ@mail.gmail.com>
Subject: Re: [PATCH] rpi: pass the Video Core logs DT parameter through
To: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Peter,

On Thu, 12 Feb 2026 at 06:54, Matthias Brugger <mbrugger@suse.com> wrote:
>
>
>
> On 09/02/2026 13:55, Peter Robinson wrote:
> > Pass the VC logs DT parameter through to the kernel
> > device tree. This is used by the vclog tool and is
> > a useful debugging tool.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>
> Acked-by: Matthias Brugger <mbrugger@suse.com>
>
> > ---
> >   board/raspberrypi/rpi/rpi.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index f9b643555dd..7256d66a9a6 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -608,6 +608,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
> >       /* warnings from the firmware (if any) */
> >       copy_property(fdt, fw_fdt, "/chosen", "user-warnings");
> >
> > +     /* firmware logs - used by the vclog utility */
> > +     copy_property(fdt, fw_fdt, "/chosen", "log");
> > +
> >       /* address of the PHY device as provided by the firmware  */
> >       copy_property(fdt, fw_fdt, "ethernet0/mdio@e14/ethernet-phy@1", "reg");
> >
>

Is this property in the schema? It looks like something ad-hoc.

Regards,
Simon
