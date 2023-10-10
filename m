Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF86CD8CA2
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04A5869DD;
	Tue, 10 Oct 2023 16:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WaGs+W5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F143A86604; Tue, 10 Oct 2023 16:58:30 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B0E86BD0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ad810be221so974806466b.2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696949899; x=1697554699; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fyKYTc4gzP7DJI3Xpoem3eNbp5cG2JrIq6af4Giyg+M=;
 b=WaGs+W5X46HVWq9Lr7wn6dU6rIZ/MgV+nUlMdZ+wOeyWdNY0UG44EtKcZCgS84U98Q
 O+bEoSk39r0GvlMz4czDAhGkQ/FpTfE4fWDov3DD1jdzj4fjjKoEOno58CbfUzto17gT
 sxvhalWmbvMbGoPFAF47euf20AN9Z5LecyQsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949899; x=1697554699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyKYTc4gzP7DJI3Xpoem3eNbp5cG2JrIq6af4Giyg+M=;
 b=kNxy4QeWGrUiVt3Wo4UYriuDZ25muRQeX1CLa02XKdNhRrCFhEntsNVUSMmrKIoSBA
 cKTZM+yUffhc5tpAMWe9+bPu5aOkabccpTMSri17pZcty7OzKhXWaDHEMR7VNaH10Yhj
 HzB8iqUqRxbmFi01VNCCJPcWBxRcVMlTisLK4lsEPjxAZzppza26si4xzVMK2rl3JpHW
 m9cAxrG8TU8ZMYnDZN8psLCFKRzYsoksA9ai0oWNoiCGUKtN0ywc2eGNe+i7l4x/ulx8
 llYLc8n0q6ev+JiP5GdEWHAWR2eEj+zQHaKjtxtQzKmx9AdjJtklCfYtw6bmY11dFcUi
 e65A==
X-Gm-Message-State: AOJu0YzDVpXGUg9LpYp8Yir4yGUqSFLwtVQYnFYlt7Toy4dYze/iak1N
 dCkA/PLgWMMAdCEhYxZVE2rHY0CcAp6pLzwE4rp1Og==
X-Google-Smtp-Source: AGHT+IHF/KvkSsN0zsOMIu1ohdNaeEZEeWJ3GQnO4N1B8VRBVWn+SH7eXQM9VAGsddDsq3wmdpSmSYJXoy7vLVgl5vE=
X-Received: by 2002:a17:906:18b1:b0:9ba:a38:531e with SMTP id
 c17-20020a17090618b100b009ba0a38531emr7930882ejf.52.1696949899555; Tue, 10
 Oct 2023 07:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
 <CALeDE9MADwXU_gExvQZJnxKYDk1C1YLiZyL1jhe9-Um1hQA=6Q@mail.gmail.com>
 <CAPnjgZ2L7Rfbuj6aN3oQqOPPxywraDaL1AM6xyQiNB8T6PFPGg@mail.gmail.com>
 <CALeDE9OJpP8P-8Wk=Jt=Ju2Q8MQoLVDOjvY8HBMF6JZP3pitVg@mail.gmail.com>
 <CAPnjgZ2FGkx+v3rn24D0rdNQE3AnmJhM-=e8uzbXw7u1-J_zSg@mail.gmail.com>
In-Reply-To: <CAPnjgZ2FGkx+v3rn24D0rdNQE3AnmJhM-=e8uzbXw7u1-J_zSg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Oct 2023 08:58:09 -0600
Message-ID: <CAPnjgZ0HCt6G-hgaxHp7=5VN35iknFGXsbqatVrjLZtDc91HyQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sun, 8 Oct 2023 at 14:20, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Sun, 8 Oct 2023 at 12:02, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > > > So with more testing of 2023.10 in Fedora we found a regression
where
> > > > the display dies when the vc4 module loads in the kernel. With
further
> > > > debug it was found that it was due to the new U-Boot and with
> > > > bisecting it myself I have found this series is the cause of the
> > > > regression.
> > > >
> > > > The testing I have done is with recent RPi firmware, U-Boot 2023.10
> > > > and kernel 6.5.x, but also seen with 6.4.x, with a minimal text only
> > > > image. I can also reproduce it by using the F-38 GA image, no
updates
> > > > and purely just changing the U-Boot component. I've done my testing
on
> > > > the RPi4.
> > > >
> > > > Let me know if you need more information, I believe you have a RPi
you
> > > > can test with.
> > >
> > > Thanks for the report. Which rpi should I test with? I take it that
> > > vc4 is a kernel module? Do you have the error message?
> >
> > Well I've been testing on the RPi4 (as I mentioned above), there's no
> > direct error message that's directly linked but the screen goes blank
> > and turns off, even on a text only install, and yes, on the rpi4 the
> > vc4 kernel module deals with driving the HDMI and other output
> > interfaces (whereas the v3d is the driver for the render unit), and on
> > rpi3 and older vc4 also runs the 3D render module too.
>
> OK I have an rpi4, but I don't get that far:
>
> >>>
> U-Boot 2023.10-00111-g7d1e5aacdb4 (Oct 08 2023 - 14:14:10 -0600)
>
> DRAM:  948 MiB (effective 3.9 GiB)
> RPI 4 Model B (0xc03111)
> Core:  205 devices, 16 uclasses, devicetree: board
> MMC:   mmcnr@7e300000: 1, mmc@7e340000: 0
> Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Net:   eth0: ethernet@7d580000
> PCIe BRCM: link up, 5.0 Gbps x1 (SSC)
> starting USB...
> Bus xhci_pci: Register 5000420 NbrPorts 5
> Starting the controller
> USB XHCI 1.00
> scanning bus xhci_pci for devices... 3 USB Device(s) found
>        scanning usb for storage devices... 1 Storage Device(s) found
> Hit any key to stop autoboot:  0
> U-Boot> bootfl scan
> Card did not respond to voltage select! : -110
> ** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_2' with efi
> Card did not respond to voltage select! : -110
> Failed to load EFI variables
> ERROR: invalid device tree
> Boot failed (err=-22)
> <<<
>
> Do you know what that might be? I ask because it seems that you are
> actually able to boot.
>
> I'll keep looking.

This was apparently a corrupted uSD card as I tried again and it booted.

Regards,
Simon
