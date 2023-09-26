Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65125E7E627
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 11:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D890586D5A;
	Tue, 26 Sep 2023 13:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RdtDIpDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6479B86C2D; Tue, 26 Sep 2023 13:37:47 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78E886C35
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50336768615so14714844e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695728263; x=1696333063; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tHfdStaCxgcCTLUHEA9xv82WjxY9DBMtP9lOeCCBa9Q=;
 b=RdtDIpDI7vuEKCGteB3Amm2cpRiWTzN+iuRo9TABkj3HDFxa0IZwaXLyQBt1n+Rq9e
 PG+SCms9jWzJDz6+etOXAAnbu6msEdAghscLcK05hFtosAJ5a+b5Wr1AYNWEWFLS1VZq
 /G2JlZSsyZosJjofh87sfRwJ04Pz4NK6kCD94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695728263; x=1696333063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tHfdStaCxgcCTLUHEA9xv82WjxY9DBMtP9lOeCCBa9Q=;
 b=vKqmJ807mHGKfFhxXfacL9yg8cUng72MhNf97ZhxFd3GKoy6fNrp0f29Cwws7plnK0
 /M8U4vNErLiR44G1oI0IKNUhn6VnQsbThm0Cj3S3QQ/lRm9/hUym7alkTtH8YgG29c+h
 qPkNBWOPxRRuKnKCNpW6QMbs3D1g3kooA7NdIOTN+peEZewse4jmUkMZO28dFABBVQFR
 qeTQJ3UNgnRftd3XXeV110x6zSE0Be1vTf0bQVuwiyWUUg29Xz5HIN0r4pgndgH4tVtn
 UaLJnSnizwWBTH00+lmioDsNvZBZGdksVknWzWfyWQ6xFtkIPINMvSK32LKeBjoTBlD2
 YHXw==
X-Gm-Message-State: AOJu0YzDf8KozBaQgzK/4tFubLXEkBhZiuLROad+cnnPZ2zgx8ovQDOg
 RLTvf68WafYUuB2WHYphzLeSCM/OWSlnfkMYlZ5pvyVQc4dl5tvY+Os=
X-Google-Smtp-Source: AGHT+IG8E+VnVAaKUZFrHCsMwHRnTnqHmy54P2KfH31P1nWP3fwe4p71cUvxXz6v/TD3Uu/zdV2a2U5Ampuq/ei+iTM=
X-Received: by 2002:a05:6512:ea1:b0:500:ce5f:7635 with SMTP id
 bi33-20020a0565120ea100b00500ce5f7635mr9683718lfb.54.1695728262899; Tue, 26
 Sep 2023 04:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
In-Reply-To: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Sep 2023 05:37:31 -0600
Message-ID: <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Tony,

On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Simon,
>
> Here is an observation during testing the bootflow command.
>
> If there is a SCSI bootflow, scanning for USB bootflow will remove that existing
> SCSI bootflow. To bring it back, I scanned for SCSI bootflow again, and it was
> back to normal. Perhaps there is some kind of indexing problem?

Yes that's right. The 'botflow scan' command is not additive. The
first thing it does is removing existing bootflows.

>
> Please see the log below after the break.
>
> All the best,
> Tony
>
> ===============
> <BEGIN LOG>
>
> U-Boot 2023.10-rc4-tld-1-00044-g9c21b2a350-dirty (Sep 18 2023 - 12:16:59 -0700)
> Thecus N2350
>
> <snip>
>
> N2350 > env def -a
> ## Resetting to default environment
>
> N2350 > bootflow scan scsi
> pcie0.0: Link down
> pcie1.0: Link down
> scanning bus for devices...
> SATA link 0 timeout.
> Target spinup took 0 ms.
> AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> flags: 64bit ncq led only pmp fbss pio slum part sxs
>   Device 0: (1:0) Vendor: ATA Prod.: ST750LX003-1AC15 Rev: SM12
>             Type: Hard Disk
>             Capacity: 715404.8 MB = 698.6 GB (1465149168 x 512)
> ** File not found /boot/boot.bmp **
>
> N2350 > bootflow l
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
> /boot/boot.scr
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (1 bootflow, 1 valid)
>
> N2350 > bootflow scan usb
> Bus usb@58000: USB EHCI 1.00
> Bus usb3@f0000: MVEBU XHCI INIT controller @ 0xf10f4000
> Register 2000120 NbrPorts 2
> Starting the controller
> USB XHCI 1.00
> Bus usb3@f8000: MVEBU XHCI INIT controller @ 0xf10fc000
> Register 2000120 NbrPorts 2
> Starting the controller
> USB XHCI 1.00
> scanning bus usb@58000 for devices... 1 USB Device(s) found
> scanning bus usb3@f0000 for devices... 1 USB Device(s) found
> scanning bus usb3@f8000 for devices... 2 USB Device(s) found
> ** File not found /boot/boot.bmp **
>
> N2350 > bootflow l
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
> /boot/boot.scr
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (1 bootflow, 1 valid)
>
> N2350 > bootflow scan scsi
> ** File not found /boot/boot.bmp **
> ** File not found /boot/boot.bmp **
>
> N2350 > bootflow l
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
> /boot/boot.scr
>   1  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
> /boot/boot.scr
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (2 bootflows, 2 valid)
>
> <END LOG>

Regards,
Simon
