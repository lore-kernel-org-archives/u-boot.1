Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A803CD54BE
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 20:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BA886C5D;
	Mon, 25 Sep 2023 22:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gq9Oc8Wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2826386C1D; Mon, 25 Sep 2023 22:02:24 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F30486A51
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 22:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so2003804e87.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695672141; x=1696276941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V/3SXMkwPu0cvcZdBkfZ5jyozfH6LHx6yRZCokE657A=;
 b=gq9Oc8Wbg0CDYhzTS2s/d6L9t1lQDFhIoopPifH3sO174VUZX1iVnPzD7vcIarF8zC
 zjI9+ZU1vvU1USWEqEQ3EUSm1rXK42kxiQK7gJoJlZCQXHmA18BWOYW73FG6WzwrDihh
 Tjw9xFPwlGbGYWC3C+dDvNPkELsZJNIUEoxJZcwUsATBUpdDryEXLA3rdENo3gpTce/L
 lTsXoZoK2rLFXjzqItq+l4aIRngzgx8iYlbLntmg4nQxNHaeP36zQt0fa3HVdDT9YtOZ
 4qOtSrHaI5m6rCi5LL1ME9hCLQEN1AWRMoJi0e5Kc3Q0fpmeVWiOlkGitZDqWGImtKcO
 87+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695672141; x=1696276941;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V/3SXMkwPu0cvcZdBkfZ5jyozfH6LHx6yRZCokE657A=;
 b=esY6yhLu7nq55CDpDOR1TQaUOgZQLnVbcdA61ja24Glw9WbEQ7U11ApLZBMx5XJDrV
 56prKsb8T/qdjQivigeTJcJkPTQbGeRWHWgoXnytWVUnXbaOf+2HUJqOKoK0+T9lQz81
 64DXdDmjnFBl3YxyLRgi4kEdgnIFFLZw1v45nPec8bTXrna/wmxXaMqWpTPiKm0kaCgY
 sX+KRgBu41aYfed+nksodmVzkWLusxuvC8zbzGrjO41rotdpoTFNdVFHCu5nqQ4BhzqV
 ECDTJjCOwm56TSHybRWZ3eTTUIk9D1Vd+M4HeljzsVILSNKBlkRQ/a4GDzTiYk/akGcu
 XGzA==
X-Gm-Message-State: AOJu0YxPfwK/wa4KDC3ggBW36z882jzktZtYIFKW/BiFMRtJDtj7arnW
 8SvR7LfmITsWuIGbsxQXiPSP/KZx3/pPhKBXReM=
X-Google-Smtp-Source: AGHT+IHqkvDHlbcxqTmiF19yRl07lYmqLChrLrKpXw2o2fCOjJ7L0miO6010Se9eCkp5Ritj0y4LdAAhjYPQl2Tu1NI=
X-Received: by 2002:a19:9141:0:b0:503:1aae:eca0 with SMTP id
 y1-20020a199141000000b005031aaeeca0mr5485143lfj.44.1695672141260; Mon, 25 Sep
 2023 13:02:21 -0700 (PDT)
MIME-Version: 1.0
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 25 Sep 2023 13:02:09 -0700
Message-ID: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
Subject: bootstd: Scanning for USB bootflow will remove existing SCSI bootflow
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

Here is an observation during testing the bootflow command.

If there is a SCSI bootflow, scanning for USB bootflow will remove that existing
SCSI bootflow. To bring it back, I scanned for SCSI bootflow again, and it was
back to normal. Perhaps there is some kind of indexing problem?

Please see the log below after the break.

All the best,
Tony

===============
<BEGIN LOG>

U-Boot 2023.10-rc4-tld-1-00044-g9c21b2a350-dirty (Sep 18 2023 - 12:16:59 -0700)
Thecus N2350

<snip>

N2350 > env def -a
## Resetting to default environment

N2350 > bootflow scan scsi
pcie0.0: Link down
pcie1.0: Link down
scanning bus for devices...
SATA link 0 timeout.
Target spinup took 0 ms.
AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
flags: 64bit ncq led only pmp fbss pio slum part sxs
  Device 0: (1:0) Vendor: ATA Prod.: ST750LX003-1AC15 Rev: SM12
            Type: Hard Disk
            Capacity: 715404.8 MB = 698.6 GB (1465149168 x 512)
** File not found /boot/boot.bmp **

N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(1 bootflow, 1 valid)

N2350 > bootflow scan usb
Bus usb@58000: USB EHCI 1.00
Bus usb3@f0000: MVEBU XHCI INIT controller @ 0xf10f4000
Register 2000120 NbrPorts 2
Starting the controller
USB XHCI 1.00
Bus usb3@f8000: MVEBU XHCI INIT controller @ 0xf10fc000
Register 2000120 NbrPorts 2
Starting the controller
USB XHCI 1.00
scanning bus usb@58000 for devices... 1 USB Device(s) found
scanning bus usb3@f0000 for devices... 1 USB Device(s) found
scanning bus usb3@f8000 for devices... 2 USB Device(s) found
** File not found /boot/boot.bmp **

N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(1 bootflow, 1 valid)

N2350 > bootflow scan scsi
** File not found /boot/boot.bmp **
** File not found /boot/boot.bmp **

N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
/boot/boot.scr
  1  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(2 bootflows, 2 valid)

<END LOG>
