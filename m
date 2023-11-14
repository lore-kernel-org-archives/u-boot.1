Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D6C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 20:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E573186FC6;
	Tue, 14 Nov 2023 21:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="LbAj3ifT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D3586EFA; Tue, 14 Nov 2023 21:50:11 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B14D686FBC
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 21:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4ac45927974so2688207e0c.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699995001; x=1700599801;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvIHkkz+M+dEIkQ6sYiiQMZE1OxYCD1I4zs4yNpVJRI=;
 b=LbAj3ifT6UbbqHXJ/cRqaIBBI4c34cIEA7O+b7VkZYeEmx2zAf4HqP0/Cv6Lp5uu4C
 zohVbO6aflx/GUfAMvBrApr/DzvZNxSBSynm1JA19kCKn9d0pwKdmjJEtE1jr7E/BoYn
 YRk0VgRP3i3fIJ9tOhnAASf7+8AKjm6DvHFloT6+Tsfckf7Bjnk8D2t79BINTvE0meCw
 qTtuowj5ijVBwBi/+E6OxMxWL1BVPDxkKH1YIhKJ236OLjO3NjOE2/BP1/PWTjfpVLdt
 VVUv5BYSKZodyBfj77HyN/g5QLZdW/FRL78ydt/QG3OOb8C5SCwb/d1wRRvNxO6ZO0Ns
 SfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699995001; x=1700599801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvIHkkz+M+dEIkQ6sYiiQMZE1OxYCD1I4zs4yNpVJRI=;
 b=cimQ85nN4ORF1IHb27bP2iaeEONr06izeaf16SYNPQgt3rftWH5kV+r5/gMR5bctBI
 warRpyf550sOqchETV5fsy+UWIrzASAp2ihzF/j+larv2KHW289fRlHpDu5u3TT1uczo
 z0mtYLyYN88QTcM2UMZtif+Lw9Tk56+iHIYXWfaEweOBIKlV3UTjM/Qv5fhsgwvSrGeX
 DSwEc9S/2gR7+fxKo6eJhPy8nIC3Zgmn2Ev/EVsn6epUeiqBrpKwnlFS/10tr0lEwvp3
 YkIuJQhn3Ar+HhDMKyDOKN3nXAKa0wtT6g5C1CIcVnE7s7jlPOH1qRA+zD7keVrMj4yP
 aWzQ==
X-Gm-Message-State: AOJu0YwVk12vFby/W7MB2Sot4LRkaQqBN1HF9H6yh3+ZJ1TzKY3CzCl5
 y4uwH5XeQuTo7N5/SPEL6HZJnzJ06TqqRWd00csVObPNl5CGkXMu6uQ=
X-Google-Smtp-Source: AGHT+IE/Wr22pV109lWI7RdOdEYoJRNu8QBbW5/zDF6EuG/6hpwHObK1QXfqGz5ZSn5IqE7FYUiresjBveLbAtPPAek=
X-Received: by 2002:a1f:b204:0:b0:495:c464:a2fe with SMTP id
 b4-20020a1fb204000000b00495c464a2femr9396775vkf.2.1699995001110; Tue, 14 Nov
 2023 12:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
 <CABEcMwUxM9hPh1c=Q8THxkJUqzw7fT-bWsdeuJoyZ8vN6BaCkQ@mail.gmail.com>
In-Reply-To: <CABEcMwUxM9hPh1c=Q8THxkJUqzw7fT-bWsdeuJoyZ8vN6BaCkQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Tue, 14 Nov 2023 20:49:50 +0000
Message-ID: <CABEcMwWjHxNTE5wVkgaQXRBwt2WP-uE3qgRpNrqiXFCjHD2iZA@mail.gmail.com>
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, trini@konsulko.com, 
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com
Cc: marex@denx.de
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

+Patrice +Patrick from get_maintainer script

On Mon, Nov 13, 2023 at 1:28=E2=80=AFPM Shantur Rathore <i@shantur.com> wro=
te:
>
> +Simon +Trini
>
> On Fri, Nov 10, 2023 at 2:13=E2=80=AFPM Shantur Rathore <i@shantur.com> w=
rote:
> >
> > Currently when a hub is turned on, all the ports are powered on.
> > This works well for hubs which have individual power control.
> >
> > For the hubs without individual power control this has no effect.
> > Mostly in these scenarios the hub port is powered before the USB
> > controller is enabled, this can lead to some devices in unexpected
> > state.
> >
> > With this patch, we explicitly reset the port while powering up hub
> > This resets the port for hubs without port power control and has
> > no effect on hubs with port power control as the port is still off.
> >
> > Before this patch AMicro AM8180 based NVME to USB adapter won't be
> > detected as a USB3.0 Mass Storage device but with this it works as
> > expected.
> >
> > Tested working after this patch:
> > 1. AMicro AM8180 based NVME to USB Adapter
> > 2. Kingston DataTraveler 3.0
> > 3. GenesysLogic USB3.0 Hub
> >
> > The drives were tested while connected directly and via the hub.
> > ---
> >  common/usb_hub.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/usb_hub.c b/common/usb_hub.c
> > index 85c0822d8b..06fe436add 100644
> > --- a/common/usb_hub.c
> > +++ b/common/usb_hub.c
> > @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device=
 *hub)
> >
> >         debug("enabling power on all ports\n");
> >         for (i =3D 0; i < dev->maxchild; i++) {
> > +               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> > +               debug("Reset : port %d returns %lX\n", i + 1, dev->stat=
us);
> >                 usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
> > -               debug("port %d returns %lX\n", i + 1, dev->status);
> > +               debug("PowerOn : port %d returns %lX\n", i + 1, dev->st=
atus);
> >         }
> >
> >  #ifdef CONFIG_SANDBOX
> > --
> > 2.40.1
> >
