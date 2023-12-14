Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBC9C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 02:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DFE5879A8;
	Thu, 14 Dec 2023 03:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eSX7LkM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516B1879AB; Thu, 14 Dec 2023 03:06:19 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0087187993
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 03:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1ef2f5ed02so834841766b.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 18:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702519576; x=1703124376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CtoMsLbhpMz1f9bqez+C2xK+FAF/zL+8iACh4ZSDBOA=;
 b=eSX7LkM36D0xNKMYOgQb3p/l6j89hoTTc/PpbFKE4lNi5PNBpm5YtiH50urU0ejS7i
 45BKrktVFhxHP+g+NGeti9ssGVh018ab30hoya5547Q/a1EgZCAtSoodre/DU1Pd0wih
 /xZ/ffLosuVvT59C3cGc4IS5/1WF159Sj1oM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702519576; x=1703124376;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CtoMsLbhpMz1f9bqez+C2xK+FAF/zL+8iACh4ZSDBOA=;
 b=p2NCIUc45BjFwU+mVZh48rw8zjSmwbs28yfvBL3yEUXkfNo00m7+r9QGcyeWKpWkzT
 5759CNbk3s1vjGbvX0hhiTAGoNiFu3cVY9kBYgRZYZQuo1blRocQggN3mgF1M9Aq4Y6m
 iEH/b+/xc0TT0DuTIoebpfbsNamQs5Gj4Zbn7xQTo2gx2yn56VIjCJ9goHY/rm9xSVqM
 JJARhzxQEm+UJJyJ3glR5jMW3o7e7/hv4A09tSn9abHJZtdyWGKRddMKPauVHMF20p9P
 kOz5tKXi3ruZhIr42V8Y92Sn9tuukpZ8p4THE6vqvPYkeP981LAt3dYST2ARYZGUPV3C
 jQSQ==
X-Gm-Message-State: AOJu0YyPgFR5NEknDY986q9Fvmdl6eVzzMzT/9XnQDRd8oK1vZssPH7e
 100cY1secX8WY4wGDNUl5KLlHoNcGr0NiqJzh53uliL8qhJPRhZQkYIw2A==
X-Google-Smtp-Source: AGHT+IFa8JOaWcu/b1pTTQTPXV8iDSPc4nnYmYuvv70LYliydNlFtDW6onysvy/0e8le14vykeYelitUMmWROh1Rkb0=
X-Received: by 2002:a17:906:1091:b0:a18:bb79:9a0 with SMTP id
 u17-20020a170906109100b00a18bb7909a0mr3325303eju.58.1702519575841; Wed, 13
 Dec 2023 18:06:15 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 19:05:58 -0700
Message-ID: <CAPnjgZ0eNv0ZRp_gDb-r46qTJ=u_9B9AGMp3n9dA889U013d4A@mail.gmail.com>
Subject: How to boot Fedora 39
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Robinson <pbrobinson@gmail.com>
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

Hi,

I tried the instructions here with a rpi4:

https://docs.fedoraproject.org/en-US/quick-docs/raspberry-pi/#_installing_fedora_on_a_raspberry_pi_for_linux_users

xzcat Fedora-Workstation-39-1.5.aarch64.raw.xz | sudo dd
status=progress bs=4M of=/dev/sdb
16843096064 bytes (17 GB, 16 GiB) copied, 151 s, 112 MB/s
0+2051288 records in
0+2051288 records out
17179869184 bytes (17 GB, 16 GiB) copied, 152.023 s, 113 MB/s


Then booted:


U-Boot 2023.07 (Oct 25 2023 - 00:00:00 +0000)

DRAM:  992 MiB (effective 3.9 GiB)
RPI 4 Model B (0xc03111)
Core:  211 devices, 17 uclasses, devicetree: board
MMC:   mmcnr@7e300000: 1, mmc@7e340000: 0
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
In:    serial
Out:   vidconsole
Err:   vidconsole
Net:   eth0: ethernet@7d580000
PCIe BRCM: link up, 5.0 Gbps x1 (SSC)
starting USB...
Bus usb@7e980000: USB DWC2
Bus xhci_pci: Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
scanning bus usb@7e980000 for devices... 1 USB Device(s) found
scanning bus xhci_pci for devices... 3 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
Found EFI removable media binary efi/boot/bootaa64.efi
966711 bytes read in 105 ms (8.8 MiB/s)
Card did not respond to voltage select! : -110
No EFI system partition
No EFI system partition
Failed to persist EFI variables
Booting /efi\boot\bootaa64.efi
No EFI system partition
Failed to persist EFI variables
No EFI system partition
Failed to persist EFI variables
No EFI system partition
Failed to persist EFI variables
error: ../../grub-core/commands/search.c:315:no such device:
77e306d4-532a-4d8c-b023-5bde5c8689ac.



                                   GRUB version 2.06

   Minimal BASH-like line editing is supported. For the first word,
TAB lists
   possible command completions. Anywhere else TAB lists possible
device or file
   completions.


grub>


I looked at the partition list and don't see that GUID, but perhaps
U-Boot is missing some config?

U-Boot> part list mmc 0

Partition Map for MMC device 0  --   Partition Type: DOS

Part    Start Sector    Num Sectors     UUID            Type
  1     2048            1228800         7d51a49c-01     06 Boot
  2     1230848         2097152         7d51a49c-02     83
  3     3328000         30226432        7d51a49c-03     83
U-Boot>

Regards,
Simon
