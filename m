Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17980C55825
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D08C8729D;
	Wed, 15 Nov 2023 15:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="FRNVFfhH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F0D87253; Wed, 15 Nov 2023 15:50:27 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9AD87446
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 15:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso10396106a12.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700059818; x=1700664618;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aXs0yFSDcfmlYkbvmi0GWdT7l5MNEKaw2M8Z6Dgdhqc=;
 b=FRNVFfhHsCSKGCrkaungyUDh1o43G/FYD6A9u6bfw0bxyuGERjKANGy8rRYoV6DyF0
 nkOPQnOB09z/rhM7+sSvibGVO6RZ3qeOTcbFusBPXSWUaHth6Qq8/9XgkkbhYNOJHgr7
 Vn8B0w/t8u80SzkyVNLvNIIsuNR2v9WFhGdSZDk9quTfZkp+6pGZ/Pj76+MoeH9Lmlxf
 T1I4XdyQ030gVIRjBo9tQnzQPX8OjOfFoDwgSY8VoLKKczSf86V45z/Z/PbTI9PdA9gU
 NmqNAfu0OsegaBpPvx7zxjN+YOpGfOiv9C++L1zHR+zxQW+aJIZg1nirg8vMsyVlcVcs
 lndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700059818; x=1700664618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aXs0yFSDcfmlYkbvmi0GWdT7l5MNEKaw2M8Z6Dgdhqc=;
 b=VreGvBaxznHMTr8N0YVKPIMRHJX+h+S0ffH8ixm6GOEdxTIzQHkwsWPbupr2D/Ij5h
 JhMR3UfchhOYYf6B2sdsQq/CLZwltDidNvAbabZI6CogUBuBogF0WoCRhG1kB2byHerL
 Ld/GcbFW9hVPw0eISPaGa6MLclf/5Y1k7k9CglE3oHeuP8HUcehU/HMhs7ZD2jcwmU88
 QviCBnGWE9+0/zxFpdCNsMH65cOHolbef8y+MBYmsYyq2gGLMmClxpQoTUeKCBfhjEYm
 fBTxkTQXZ5UDpiKDi2K0KT63T1ouERKLsSkup+NTWELvyMS3avGrnhtoV4Q3c7F160CI
 WrOA==
X-Gm-Message-State: AOJu0Yw+pujQnx0pCSabu5apERxPxLKTMQ3ME4TtOooturebJNXpvn0o
 ngMxVRR9DMl+iPrlH3xsY3Tafq0ZafxbreXAcmbbOLPc
X-Google-Smtp-Source: AGHT+IEaYuElmHwhhGdozs09RRfUVYj+bIZlMNq2Pe4S2RJ68ctVs1OnPif+48QRbeejRBsW+EqrpQ==
X-Received: by 2002:a17:906:e28a:b0:9be:263b:e31e with SMTP id
 gg10-20020a170906e28a00b009be263be31emr9983835ejb.33.1700059817819; 
 Wed, 15 Nov 2023 06:50:17 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com.
 [209.85.208.43]) by smtp.gmail.com with ESMTPSA id
 o16-20020a170906359000b00989828a42e8sm7154448ejb.154.2023.11.15.06.50.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 06:50:17 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso10414383a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 06:50:17 -0800 (PST)
X-Received: by 2002:aa7:d5cd:0:b0:53b:9948:cc1f with SMTP id
 d13-20020aa7d5cd000000b0053b9948cc1fmr10390111eds.12.1700059816871; Wed, 15
 Nov 2023 06:50:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
In-Reply-To: <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 15 Nov 2023 14:50:05 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
Message-ID: <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

I did some testing on the USB 3.0 port and it seems like bootflow
causes something to happen to the USB.
It seems to be only reproducible on the USB3.0 port.

I am using an AMicro   AM8180 NVME to USB adapter on the USB3.0 port
of RockPro64.

Booting the Armbian installation using

=> fatload usb 0:1 ${kernel_addr_r} EFI/boot/bootaa64.efi
979672 bytes read in 6 ms (155.7 MiB/s)
=> bootefi ${kernel_addr_r}

works 100%, no issues with USB whatsoever.

Booting same with

=> setenv boot_targets usb
=> setenv bootmeths efi
=> bootflow  scan -lb
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
----------------
Scanning bootdev 'usb_mass_storage.lun0.bootdev':
  0  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo
efi/boot/bootaa64.efi
** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi

And I see issues with USB device not communicating properly like

[   50.182144] sd 0:0:0:0: [sda] tag#29 uas_eh_abort_handler 0 uas-tag
24 inflight: CMD OUT
[   50.182957] sd 0:0:0:0: [sda] tag#29 CDB: opcode=0x2a 2a 00 03 4e
e9 78 00 00 08 00
[   55.270116] xhci-hcd xhci-hcd.2.auto: xHCI host not responding to
stop endpoint command
[   55.284476] xhci-hcd xhci-hcd.2.auto: xHCI host controller not
responding, assume dead
[   55.285494] xhci-hcd xhci-hcd.2.auto: HC died; cleaning up

This is 100% reproducible.

Is bootflow doing something different to USB than normal fatload +
bootefi, I see internally it uses bootefi as well.

Kind regards,
Shantur
