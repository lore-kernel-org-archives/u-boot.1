Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522DCC47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 09:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DEF87C31;
	Thu,  1 Feb 2024 10:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="uGid85eK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A590887C49; Thu,  1 Feb 2024 10:40:09 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF4487C40
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 10:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7d5c890c67fso352882241.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1706780406; x=1707385206;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Zppf+IFVS2YRfjoAZ8wJcCFvl4qp2OQRnCLFmjOr7g=;
 b=uGid85eKuJU+5SjuNVcKTecuaT9CBdWgvJDZIeGjBBiXlXf7Z+4GCq2nAps0BdsndV
 JwoKEURDeUqkea3Af3EbWWFkHqaLNEkabdvjw2wxR22fzorfHWgHHS9DAxXYHBzbOQm9
 ZRPR5KQctoSTpSK4MRdf97YozSFOsY4tor/1hL98fKVgOOIOHVj9cIZK1S6tb4DK6S+z
 +oPES4hdQPliUG4eIMvcQOvo9pW1KA2esyM5c5NX0caqpIXr/IFVMHiOdQx6tmZbqj9a
 bYbKjICVwCn4orh46GeSK96j1kuXvKcbO4CFv1Igc8Xby884SewQ25CTEzmGERXynqN9
 ByQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706780406; x=1707385206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Zppf+IFVS2YRfjoAZ8wJcCFvl4qp2OQRnCLFmjOr7g=;
 b=JGYYmIodnbt5C+g08gooQzvwsctgU57R9MTNxCAZAvys2jFgtncw0sEtsDtL/TPj17
 Tt9x4ymWC3310ABsv7IqZoFERyyGy1QiDxnOFEIc1i/v51hbPE7VrSM3iQhCCA5yqoEU
 HY1FdbD8i+yWeJMTyp4Sp9hIOMY8SNOd8yupgRAfw+3MrVOG/ziFj8FI99nf8qDoleVp
 iZVdNNcPJ3CSUCbPeLsfXl4UOwRP1aWVqRa6Cf3CZBpsrk90tdrDHLKFqiX1SqZ9QjQU
 VouYKTJBSgBYUumM5bXGgwLt985qJUs3heNLcI2p2hF88GZ4lkgTSdZw0sm3bPwFLPOQ
 gUuw==
X-Gm-Message-State: AOJu0Yyi2x5w/f/YkJeGxUeiLCZ/FWCE87ZwOms83njHMmXb4l5TTpCH
 Fu9MTQ8kUm5qrg71SQVusPbdJVqwbxCjOw7yutDuKT0jG+HgIY7VkSk7os1vbUq8hDuXDQTRnwU
 8YAAOmTOAjQY1WI/yFo8dnkNYPjsDGG8ihrCncg==
X-Google-Smtp-Source: AGHT+IEBhh7n3RqCS37fpVeHm4F7EOqwduL0GVPPOVE9a4ejbVLHmoBkLDP4Zz76+IBb5ZmQYpw0lY2LGJiJ0u5iv5k=
X-Received: by 2002:a05:6122:4449:b0:4b6:f582:2bac with SMTP id
 cy9-20020a056122444900b004b6f5822bacmr4083910vkb.16.1706780405928; Thu, 01
 Feb 2024 01:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
In-Reply-To: <20240130140123.445f368a@donnerap.manchester.arm.com>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 1 Feb 2024 09:39:54 +0000
Message-ID: <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: Andre Przywara <andre.przywara@arm.com>
Cc: marex@denx.de, bmeng.cn@gmail.com, clamor95@gmail.com, 
 Hector Martin <marcan@marcan.st>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

Hi Andre,

On Tue, Jan 30, 2024 at 2:01=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Sat,  9 Dec 2023 18:10:56 +0000
> Shantur Rathore <i@shantur.com> wrote:
>
> Hi,
>
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
>
> so this broke USB operation on some Allwinner boards. The ports still
> enumerate correctly, but no devices are detected. With mainline
> (containing this patch), and a USB stick connected:
> starting USB...
> Bus usb@5200000: USB EHCI 1.00
> Bus usb@5200400: USB OHCI 1.0
> scanning bus usb@5200000 for devices... 1 USB Device(s) found
> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
>
> With this patch here reverted:
> starting USB...
> Bus usb@5200000: USB EHCI 1.00
> Bus usb@5200400: USB OHCI 1.0
> scanning bus usb@5200000 for devices... 2 USB Device(s) found
> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>        scanning usb for storage devices... 1 Storage Device(s) found
>
> I have no clue why this happens, there is no discrete hub anywhere in thi=
s
> setup, so I guess the code runs for the root hub here?
> I am attaching a log with DEBUG enabled for common/usb_hub.c, for both
> cases.
>
> Any clues, debug suggestions, or even a fix are warmly welcome.
>

Which USB disk are you using? Is it a USB 2.0 disk ?
Can you try with any other USB disk to confirm?

Regards,
Shantur
