Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3745C61CE8
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 12:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177438283E;
	Sun, 15 Jun 2025 14:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TLbzrkJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84C882B0F; Sun, 15 Jun 2025 14:15:03 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD8D81E06
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 14:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso7254875a12.2
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749989701; x=1750594501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BSgyQO4KnrgMph7O63oNhaVldO5P7AL1rXpbD7i0Uog=;
 b=TLbzrkJSNXyJ01ih8VYBVfVQEf+f0izybUyoECfVLIvnhrD61E/O9P07DKwvoerQ/R
 V/KHzzUrerTKito3mPYu6g+ptSZzCm//w/K3rNpuxGilf6kBWnPkFw2SECyxiZippp8N
 py8cp3n6tWqpQ1CGvMKr0bSd4dsQjGmWoHZ0zKVWqK9/QM5laHOY6W1HtoVmV+LgtInd
 IkL3Q/ko1ArreBnmYZ8V9C0eNipnOUwpp147xsva2t2I21VraFxH7Tg6BHezeyfhUlUG
 Vv82meE6MoR/XJFCgyfBB4j+aQaP7Bpytux19UuTFswhSANjMVA8gKo4nGmps16PIyJg
 pvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749989701; x=1750594501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSgyQO4KnrgMph7O63oNhaVldO5P7AL1rXpbD7i0Uog=;
 b=dIxFvSZyt0MXW3KOPpWb6d2CAnndMsPwknW2CJPLCL+Poi/S/pAY6hCpZDsWR0F3C0
 lR4pa3l72oZerN47JOr+Ow7vG4JPDq0s+xke5zx0aHTJaRMZMxfxvTjymGUR5V+4/qmc
 Rvi7uLtdmBAYxzGsTJmbfvIm1WsWhl5IFxr+RYtktet/dCXfbE2hkA8wNN8WIcjq+uBT
 IzIGdnQVpInF8N5x+kVAHrol2VNaAnvwhhTCbdGH6i2Pw/X8drMBTynAMuDbRfhRd2bn
 b/wzyYqcmgqMNMUGWGqWMmFgiN6u1aLS+Jhj4AHqnkKOu6nBT+NZyNOq725M69OjaLAM
 2FWg==
X-Gm-Message-State: AOJu0YwRdc8jyYmdEIEG57UthYfthrlExp+PI4YsEm1tYBHnqNwqGpy2
 yuhZLaW+riq3OlsNc2db92r+RN1qPdENfXY8r+q2sW0FynUy/7KhBgHBuVY6gxxuc6nReVXfqjx
 LDVlu7ip0esAfoVsiRgDidN6Eq+QAn74=
X-Gm-Gg: ASbGnctG8JJryJe8rxnHeMHrtJ9tu5LPMJp1y32M5TWD5JauzcD6Agix7KiB69jPM50
 DzP29oJjCALehTW00sbJT91nX3gtGWjmPrQOVHC809AYa5/Pp14v3C3maPxfgMDTedLprTW5gs9
 oMUJKDKRCRo76QF704knSEi1Dtac64aU0ARXhZpAOJjnFhBbIsLsdYDNIpzfZiVjHlJDbMtUFvB
 Jlp
X-Google-Smtp-Source: AGHT+IHaQz1nR5dxsnGcpyvsy7mMWRhUBYkJvYjozm6nNJeyVU12P9kZB4QxhX9Zd/XYOmDyvuvlE+CXL2yAqXzAlm0=
X-Received: by 2002:a17:907:1c9e:b0:ad5:112:48e4 with SMTP id
 a640c23a62f3a-adfad3a24a6mr558647466b.18.1749989700306; Sun, 15 Jun 2025
 05:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250211135829.3467088-1-fiona.klute@gmx.de>
 <CALeDE9Oumn2xO0MPq+L5rsv5NEAjL=XM8zRNA38uV+MbqkVrzw@mail.gmail.com>
 <8b8386f2-7a85-499d-956a-11a22b3cb10c@gmx.de>
In-Reply-To: <8b8386f2-7a85-499d-956a-11a22b3cb10c@gmx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 15 Jun 2025 13:14:49 +0100
X-Gm-Features: AX0GCFv_pTkWbPxETs2kNyJY09qi8Gg-PrjEyITKepU-gXmZydt4KbFQzQAlaoI
Message-ID: <CALeDE9ONxe=MUdt77eMxgEhj0SV1t8vMmQht4pQrc=_eMdfQGA@mail.gmail.com>
Subject: Re: [RFC] Raspberry Pi: copy /system/linux, {serial,
 revision} from firmware
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Fiona,

> do you have any comments? My main concern is if creating a temporary
> overlay is the right approach here, or if there's better way to create
> the /system node if needed.

Apologies, I looked at this originally and my thought then was it
needed more thought and then it slipped through the cracks.

Off the top of my head I have a few concerns. I will have another look
at this but to provide some initial feedback.

Firstly there's no bindings upstream [1] that I can see for a root
system node so it's completely RPi specific and doesn't adhere to
anything. I don't really want to be adding this to the kernel DT in
this mode if it's not really verifiable.

I also wonder what the value is if we end up copying large amounts of
the FW DT into the other DT, why not just use the firmware DT instead?

In the terms of the RPi kernel, again I think for that you'd be better
of just passing through the FW DT as they should both match in that
case, for the upstream kernel this won't make any difference. We
already have the rev details in the model, we should look and see if
there's a standard way way to pass HW rev/serial number through in
device tree.

In terms of userspace I think getting it that way in the example is
broken, as it was in /proc/cpuinfo which was why it never made it to
aarch64. but I'm not sure what details are being used there and why
they matter for RGB LEDs.

Overall I am not currently convinced this is something we currently want.

Peter

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings

> Best regards,
> Fiona
>
> Am 15.02.25 um 14:01 schrieb Peter Robinson:
> > Hi Fiona,
> >
> > I'll review and test this the coming week and provide feedback.
> >
> > On Tue, 11 Feb 2025 at 13:58, Fiona Klute <fiona.klute@gmx.de> wrote:
> >
> >> Both the Raspberry Pi downstream kernel [1] and some userspace tools
> >> [2] use the revision property to identify the board, and the latter
> >> fails if it is absent. The firmware creates the /system node, so we
> >> need to do the same.
> >>
> >> [1]
> >> https://github.com/raspberrypi/linux/blob/0f292fbb6346b05766152902076895558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
> >> [2]
> >> https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ede5aaa388180da/rpihw.c#L579
> >>
> >> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> >> Cc: Matthias Brugger <mbrugger@suse.com>
> >> Cc: Peter Robinson <pbrobinson@gmail.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> ---
> >> I'm sending this as RFC because I'm not sure if creating a temporary
> >> overlay is the best approach here, advice on a better way to create the
> >> /system node if needed is very much welcome. I know I'll need to add
> >> more error checks, I'll do that after I know I have the right approach.
> >>
> >>   board/raspberrypi/rpi/rpi.c | 37 +++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 37 insertions(+)
> >>
> >> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> >> index aa39afa338a..647716127c7 100644
> >> --- a/board/raspberrypi/rpi/rpi.c
> >> +++ b/board/raspberrypi/rpi/rpi.c
> >> @@ -550,6 +550,41 @@ int copy_property(void *dst, void *src, char *path,
> >> char *property)
> >>          return fdt_setprop(dst, dst_offset, property, prop, len);
> >>   }
> >>
> >> +int copy_system_node(void *fdt, void *fw_fdt)
> >> +{
> >> +       const fdt32_t *prop;
> >> +       char fdto[2048];
> >> +       int src_offset;
> >> +       int len;
> >> +
> >> +       src_offset = fdt_path_offset(fw_fdt, "/system");
> >> +       if (src_offset < 0)
> >> +               return -1;
> >> +
> >> +       fdt_create(fdto, sizeof(fdto));
> >> +       fdt_finish_reservemap(fdto);
> >> +       fdt_begin_node(fdto, "");
> >> +       fdt_begin_node(fdto, "fragment");
> >> +       fdt_property_string(fdto, "target-path", "/");
> >> +       fdt_begin_node(fdto, "__overlay__");
> >> +       fdt_begin_node(fdto, "system");
> >> +
> >> +       prop = fdt_getprop(fw_fdt, src_offset, "linux,serial", &len);
> >> +       if (prop)
> >> +               fdt_property(fdto, "linux,serial", prop, len);
> >> +       prop = fdt_getprop(fw_fdt, src_offset, "linux,revision", &len);
> >> +       if (prop)
> >> +               fdt_property(fdto, "linux,revision", prop, len);
> >> +
> >> +       fdt_end_node(fdto);
> >> +       fdt_end_node(fdto);
> >> +       fdt_end_node(fdto);
> >> +       fdt_end_node(fdto);
> >> +       fdt_finish(fdto);
> >> +
> >> +       fdt_overlay_apply_verbose(fdt, fdto);
> >> +}
> >> +
> >>   /* Copy tweaks from the firmware dtb to the loaded dtb */
> >>   void  update_fdt_from_fw(void *fdt, void *fw_fdt)
> >>   {
> >> @@ -560,6 +595,8 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
> >>          /* The firmware provides a more precise model; so copy that */
> >>          copy_property(fdt, fw_fdt, "/", "model");
> >>
> >> +       copy_system_node(fdt, fw_fdt);
> >> +
> >>          /* memory reserve as suggested by the firmware */
> >>          copy_property(fdt, fw_fdt, "/", "memreserve");
> >>
> >> --
> >> 2.47.2
> >>
> >>
