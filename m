Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318F0C54FB9
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897D087285;
	Wed, 15 Nov 2023 16:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DWjBDlz4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E60587285; Wed, 15 Nov 2023 16:51:09 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AC787284
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5c08c47c055so58049647b3.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700063462; x=1700668262; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVsFYG96rarhBjHMn65LtLRorYAFtl42y3lpmq1CsX8=;
 b=DWjBDlz4D4E+4NX0iQDmCYi4evRLBhhx0dcd/NbtC/4pz/pIPGfejJzNSZSK5/ftQ1
 yn/VTeTft4aMAjVOl58MxdfGZ+cRzNwQj73UdW3KVLx9XVLSuOn7a3yx9mQK/S23/6Aq
 PrF6dvqUSwi/eRsZ8D7DFsV3OkP4I+/VQYw60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700063462; x=1700668262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVsFYG96rarhBjHMn65LtLRorYAFtl42y3lpmq1CsX8=;
 b=C4I4BlAumaAInMTjnqlMK1b04UOzAjB74F+m8FTjtVrfJ+W6A9o1qvPS1BxGhoJNxm
 VfrFDeIjRI+X0/Q53VQL+d3j+kbe/U6mjV/adEQySFu3MhazbYAe8mlH0fR+JhJ6VfHd
 gNjxYmvB3pIWmM9LzqkDskhUjNuPtu+7sSUlz9yq4Ajg39grtH5hSNPVaW+PFFXTvB0g
 eYGrNPnCPpffjQ6yDbozpEJdXRRRyqB/oQ4HuURcPGr6bMq11S0Peti+fIIn9tx61afK
 Ink8A1CW21CAWC7b7UiuzHHxNXeeB6PrOfJIVX3afezuEv8VrnmNrArYWPyWHUMh8Vgd
 2zUg==
X-Gm-Message-State: AOJu0YyxE3tsKqzQYBUhB52I6MZZHjxGJnSVlbb3Ktgn0zajB+R7k2Wi
 I+op/yS8wzGrqO3STI2FS4Z6/L0J/Qb2jboYj0DYLA==
X-Google-Smtp-Source: AGHT+IHgg9X9OJnd6QTGCtnhhOEWArRSCxN6O5HuOOPt6hHeHJazssdVn2dtAskXaABX7wrlfkyon1ki7vgwc0NBi4Q=
X-Received: by 2002:a81:5dc4:0:b0:5a7:ba09:52c7 with SMTP id
 r187-20020a815dc4000000b005a7ba0952c7mr12839845ywb.11.1700063462099; Wed, 15
 Nov 2023 07:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
 <CAPnjgZ3wEzHNqzpsF1zU6U4WBAm=oMYEzRRR-UuqDEwXB24rLw@mail.gmail.com>
 <43EF5E14-0AE3-456A-B9D4-67B8F4405555@gmx.de>
In-Reply-To: <43EF5E14-0AE3-456A-B9D4-67B8F4405555@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 08:50:46 -0700
Message-ID: <CAPnjgZ2t-wF=nGWtdEgWRtUrzFyERnoGwqF8urJjNgEP2b4Qrw@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
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

Hi Heinrich,

On Sun, 12 Nov 2023 at 16:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
>
>
> Am 12. November 2023 22:20:50 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Sun, 12 Nov 2023 at 13:32, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >>
> >>
> >>
> >> Am 12. November 2023 21:02:42 MEZ schrieb Simon Glass <sjg@chromium.or=
g>:
> >> >When a USB device is unbound, it causes any bootflows attached to it =
to
> >> >be removed, via a call to bootdev_clear_bootflows() from
> >> >bootdev_pre_unbind(). This obviously makes it impossible to boot the
> >> >bootflow.
> >> >
> >> >However, when booting a bootflow that relies on USB, usb_stop() is
> >> >called, which unbinds the device. For EFI, this happens in
> >> >efi_exit_boot_services() which means that the bootflow disappears
> >> >before it is finished with.
> >>
> >> After ExitBootServices() no driver of U-Boot can be used as the operat=
ing system is in charge.
> >>
> >> Any bootflow inside U-Boot is terminated by definition when reaching E=
xitBootServices.
> >>
> >> >
> >> >There is no need to unbind all the USB devices just to quiesce them.
> >> >Add a new usb_pause() call which removes them but leaves them bound.
> >>
> >> As U-Boot must not access any device after ExitBootServices() it is un=
clear to me what you want to achieve.
> >
> >I can't remember exactly what is needed from the bootflow, but
> >something is. Perhaps the kernel, or the cmdline, or fdt? It would
> >have been better if I had mentioned this explicitly,  But then this
> >patch has been sitting around for ages...
> >
> >In any case, the intent of exit-boot-services is not to free all the
> >memory used, since some of it may have been used to hold data that the
> >app continues to use.
>
> The EFI application reads the memory map and receives an ID which it pass=
es to ExitBootServiced() after this point any memory not marked as EFI runt=
ime can be used by the EFI app. This includes the memory that harbors the U=
-Boot USB drivers. Therefore no drivers can be used here.
>
> Starting the EFI app via StartImage() must  terminate any running U-Boot =
"boot flow".
>
> After ExitBootServices() the EFI application cannot return to U-Boot exce=
pt for SetVirtualAdressMspsetting which relocates the EFI runtime.
>
> Bootflows and U-Boot drivers have no meaning after ExitBootServices().
>
>
>
> >
> >Also there is U-Boot code between when the devices are unbound and
> >when U-Boot actually exits back to the app.
> >
> >This hang was 100% repeatable on brya (an x86 Chromebook) and it took
> >quite a while to find.
>
> We need a better understanding of the problem that you experience to find=
 an adequate solution. Why does removing all devices lead to hanging the sy=
stem?

Are you able to test this? With your better knowledge of EFI you might
be able to figure out something else that is going on. But in my case
it causes some memory to be freed (perhaps the memory holding the EFI
app?), which is then overwritten by something else being malloc()'d,
so the boot hangs. It is hard to see what is going on after the app
starts.

This patch was sent almost two months ago and fixes a real bug. The
first few versions attracted no comment now it is being blocked
because you don't understand how it fixes anything.

I can get the hardware up again and try this but it will take a while.

Even without the hang, this still fixes a bug. We should be using
device_remove() to quiesce devices. There is no need to unbind them.

BTW another patch that suffered a similar fate was [1]. I just applied
it based on a review from Bin.

[..]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20231001191444.v3.1.I9=
f7f373d00947c704aeae0088dfedd8df07fab60@changeid/
