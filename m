Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45846C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 21:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E28882B46;
	Sun,  6 Apr 2025 23:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K5+gYjBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB0882B77; Sun,  6 Apr 2025 23:11:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517C18004F
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 23:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so602356566b.0
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743973866; x=1744578666; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+8sonLjK4g2GmYiu03DE7GINQxkbquxLgZxW7jpekY=;
 b=K5+gYjBPO4zemRJL1Qv2wUyTelhx0vIlboP/rkSYjN8Uyh2dbi+71XxebkSiNyt2Su
 d7XBy1Vr6v9+YlNmajbpDEnYYLfx+gJ+M/qmM3cliJ23w48pfj5V5XZmKdIllPtPmlJ5
 rMYnaOJY3LxeoSqCrFLd0NeYeemKdk+nJqiHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743973866; x=1744578666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+8sonLjK4g2GmYiu03DE7GINQxkbquxLgZxW7jpekY=;
 b=rYXUvWTeWBXRQYN4JCVyd9oL1kQdG423Rodtj4Gg/wtPn8sKdedGyXXSPr0vAlfiXC
 kDk1nYnIanIrpQJ0Wde7jBrIxmx/mUq7A/5LFrh2CSjkbuOmnZZZPFszvzNSSnPBYHQs
 d1xa2m7VSVfo0JnocscwkeXR0Va+RbgDLwne4hA4FC3AQsqhVzhZxJOsjDH2Bp58hsgc
 GHfa8GpqKsR5vCDR7A7q1uxw6HTZjsV9SV1xEmQJGGc6ZeKk0ILZg7kXCxnv2KoSgxVk
 7v21JxQjhnLXHeGmO3URZuPJbT6w53+T4tVA8OAr1jivxt/W3T4vMnnvRL/Qrf066AFH
 f3/g==
X-Gm-Message-State: AOJu0YzXsRKXgaFsA84MuOhbaBThDuxUaDR74OvEsTwZEBoqaqv9d49H
 5/S8fX+05kIUdPNkkDhTndi83Sfbu6RzynGChlBDeZGlmGI3kJBgdzvvoTOqUvBUkai+B4JK8Kx
 lXVGJEwjbhyXQkz713OCZdQfgzvIRkDauzl01
X-Gm-Gg: ASbGncvKxJNJ3/URa5Ytjo/IRoG+tAxTOsFyDOh48NNlW6X3WouzWTFaLLXbuGO6Vv0
 sELr+DIdfNbFzB2nt+ead6kbChpAlwy5KXKA38zZEEFbxasOCpGRsXJlcOHn+d8d/FqkyKEiHLh
 FaSBoklOOm6y6GDI0L6WxXD9d9MVWr
X-Google-Smtp-Source: AGHT+IF4Z23Ys9C75nw6bUdv3sGDD4vRiq+DGLQygKgrmqnkf1QB8PTRu2IdAJQYEaI8+FwRd3mVjZHdED2vLWifQYw=
X-Received: by 2002:a17:907:72c3:b0:ac7:9acf:4ef with SMTP id
 a640c23a62f3a-ac7d6e9fe06mr838455666b.56.1743973865507; Sun, 06 Apr 2025
 14:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250405221308.498047-1-sjg@chromium.org>
 <33614601-f517-4031-b947-702d2bba7d69@kwiboo.se>
In-Reply-To: <33614601-f517-4031-b947-702d2bba7d69@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 09:10:49 +1200
X-Gm-Features: ATxdqUE_FN4o_5RjMRMkDHylpNnDbngSXbTk5vTs9Qcq2SD0hEpHcFzB2ZWbhtI
Message-ID: <CAFLszTg2x3OcCo51kg+Cp9veWQR4DRRr+WP-aoGRoQPPsfzmcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: designware: Disable DMA on removal
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 neil.armstrong@linaro.org, 
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, 6 Apr 2025 at 20:50, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-04-06 00:12, Simon Glass wrote:
> > At present, removing the device frees struct dw_eth_dev but does not
> > disable DMA. When DMA is active, packets can be received even if the
> > driver is not active.
> >
> > While it is possible that the memory used by the struct may remain
> > untouched after removal, any other allocation may reuse that memory
> > and result in DMA writing to random addresses.
> >
> > In most case U-Boot does this removal in announce_and_cleanup()
> > immediately before jumping to the OS. No further allocations are done
> > after that point.
> >
> > But with EFI_LOADER this function is not called before jumping to the
> > EFI app. U-Boot continues to run while GRUB starts and finishes, as wel=
l
> > as while Linux is starting up. During this time, devices cannot be
> > removed, as they are in use. U-Boot completes the removal when
> > efi_exit_boot_services() is called. It seems that this function does
> > more allocations after calling dm_remove_devices_active() although I
> > can't figure out where.
> >
> > Fix this by disabling DMA when the driver is removed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> > ---
> >
> >  drivers/net/designware.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> > index 07b0f49ef58..eebf14bd51a 100644
> > --- a/drivers/net/designware.c
> > +++ b/drivers/net/designware.c
> > @@ -809,6 +809,7 @@ static int designware_eth_remove(struct udevice *de=
v)
> >  {
> >       struct dw_eth_dev *priv =3D dev_get_priv(dev);
> >
> > +     _dw_eth_halt(priv);
>
> This should not really be needed, eth-uclass already call the stop() ops
> that in turn call _dw_eth_halt() from the eth-uclass pre_remove() ops.
>
> So ethernet should already have halted when remove() is called, calling
> it here will probably only hide any real issue.

Yes that seems right, thanks.

Regards,
Simon
