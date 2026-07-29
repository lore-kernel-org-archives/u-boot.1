Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD7CC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB84760BAB;
	Wed, 29 Jul 2026 12:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dO8k8E8rRrdL; Wed, 29 Jul 2026 12:29:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6198E60B39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328144;
	bh=3vEpGicm0jK4GiRjxVeZW8k/2NVOa5KyX1JHUJDJNlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xrcj/dZB+z0i3BVpzQrOuMxjReW/Awl8J14kN3TorC65bkERB/6aCZBBOmg10GsUw
	 BcBq3lXp6hxBiAUE8PtEY0PeEhS9sePV9nXXhAZGWD3fUuwehpiLtt6lkHNis+HRk4
	 +xAcgAnjxynGTKK7/M1r08mBlq1lw678ZgAK4VgSE1UEUIbMjl5XJ6Se5ebfdntsRe
	 H5s4W4/YBQ46bm0m6ITDROrzydqv7XaR1WHmAfR0iXKLm4/8NRGjTlXMpP6WJYuwdZ
	 kgaEGsR1iGs2LSd4JdND6Sz3F4nNxmles1JIY1WvO9mRWHno/cU0vG1D8rHMSaqeME
	 xwjM7vDRK16jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6198E60B39;
	Wed, 29 Jul 2026 12:29:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8811350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1C2E605CE
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_SYJUctFeUF for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:30:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=miladh1539@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E1BE66076C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1BE66076C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1BE66076C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:30:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 394148493F; Wed, 29 Jul 2026 12:29:59 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4290F803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 12:29:56 +0200 (CEST)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84861fc51f5so438140b3a.1
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 03:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785320994; cv=none;
 d=google.com; s=arc-20260327;
 b=jqmbb9yboCj9MvxVULUSq1hIOI/1rGyRqHRP01mTrHKISZJZjZwnJDFUYlk4zyCTDw
 MjDkFac1unBcQRoNT73di1NL3wo9zlAhnl38LCTkqGVbtR9GYoYGGyzEFmQOed/Tvg1b
 kvn8/RffOe/WhOeAgm+V9mMWZpK2kGWAr3l97gpiVcY61nEMvxzR0EucT5X+8xK8Ngdp
 20HOU0cjjtbrQQfFIuMe9UyP96HzM8fdjf0NwRROdId09yTDVnyRTsVIfckKnxeYdXL/
 f3tMo5TQv5n6iz88m/mJibS8iFc40UwB0nLv8BePw9ySMByQKsLQ5AvlXHJhEMCSFvCg
 uY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1xydfTIaWySGeJelWDOZ4wWWwpvRDgPwId2Ds0YQJD8=;
 fh=kNz/JUajTuSXKm5cFbGksBnQYHE1oBLrJyg1ywfkPuw=;
 b=lY0X/7MYYBLYNBnyd4NS6rf9ESXZZH3MwDlTpphGcuDu9/rxmqNyqQjvPJg7lQjqWc
 atFSRIhZ92kpqW/rHgm1XPm32PV0mWAzpJxmMZBNHQDgBa2awHLLn7rMMa8gCEJZLYV7
 KDPQEif4Uqtln1cKwMSA+HZn8iAn8cbkzkAR7u1Xmludei/unMELGU8NFDF/el40rgMe
 IVEqC1u1SOGo6hO2BdiDOSU/sQtlh3Rc03yj6erR1OFM81SQIkIkmg1IwsyOyj5cHh3L
 NLm0z8pc9SdKlqnu3lmKzBM5M71pfJnt5l/XcYmpHezgCY7Tr+39SB7of4BFWYUhoHvT
 NFLA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785320994; x=1785925794;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1xydfTIaWySGeJelWDOZ4wWWwpvRDgPwId2Ds0YQJD8=;
 b=mgaU0f3YTmsnGm9T1FRvJVjuFb8ysmUrw7vrGtwYvDgmRCG2G816+O/Sm51UL1Zq47
 QamvPxW0SpPLy/PSWgRwod4ZIXqu51vvtM1VHL/f9zV/AQZo+9lmePdHSxfV0q2MeOOm
 2408j3/Ji7uCoxSkoloqIZh0p9UT+jtQphZI2GpqF5ZbXIMZ6OwbpZu9kppWru2nKqnE
 OKp+blvUv8nE+h7VvfNXTTGsUOkH0WUknFQRfRtr0tdfBstAYnHo028lr/q7vRASPMJd
 +YN7gSUTdhFRDsbaK0KULr2OkSurzFkUebTXcQxpA1WVzi0iSGodAISvARIX26cCYPl0
 Gkhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqD1vwWr1pp5CYA//tC70UjbcxKKUNYN3Vm9P1EbdYs8SB1r05BtIW8rFh1g9zSQpQllDbjaHk=@lists.denx.de
X-Gm-Message-State: AOJu0YziS34WAWJVuJ85L02YyWoqcnJ8A85Gwtdxk0R3ut/6eNGUWu/h
 PL13DeQfKGcVKkRA+CWqynjp6eZ+mZVI53aSHozyEe8/oMi+K+Nuv2faQ14bsQyNe7lg/8N98CU
 FIfXZf2QT3h4HoRI1/4sqIKG8KPKjpRD0HfnR
X-Gm-Gg: AR+sD10Z+PzXztJvOLVqvFbGyibH2Qda7aR22I6Tc5BSjMKk1Kjy0jcXyca9jZC6pWs
 EMy1QQyYL7kGy4esMz1eAfuMULGEGyddXvUN3Vd0mVa155SrEanQez4CeggdDd7IBgZ8M1O9hPE
 rqLN2eFLR5yHxBGSKEQLYSaPWc8bX9vMCKV3nBatfcut2i3v888eY8qBsEwWotc+qcF7XpGqrzs
 B2VXaq7bjLjxcjkGX8yT7qGhdlyPILLiXjYtneH3Rq+5kEExqXsYIN1zplTGwGREDK6jF3uc3L2
 yWlWrerdF5ytpZsV5WvVXM+LodaprsBgxP9TqMFxwQw5t8lrV+R6M24fRCOdK+u2b6ywvpNvRRQ
 =
X-Received: by 2002:a05:6a00:9083:b0:848:5b1e:aec2 with SMTP id
 d2e1a72fcca58-84e93359aaemr6275849b3a.54.1785320994212; Wed, 29 Jul 2026
 03:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
 <7ec9c425-53c5-41a2-95e7-f185e8d340c5@conchuod.ie> <amnKW1qbQeux5UCD@pie>
In-Reply-To: <amnKW1qbQeux5UCD@pie>
From: Milad <miladh1539@gmail.com>
Date: Wed, 29 Jul 2026 12:29:44 +0200
X-Gm-Features: AUfX_mzl_dWLaQBzOq3Y1ZGpduegbr6S2zs6RGZvX00FZILf5XEfjEg5WftWcvQ
Message-ID: <CA+H9utx=zwAis2+_g=-2FU2N06KVu-M4p22uJ9xHik5zADMOaA@mail.gmail.com>
Subject: Re: VisionFive 2 eMMC boot issues.
To: Yao Zi <me@ziyao.cc>
Cc: Conor Dooley <mail@conchuod.ie>, u-boot@lists.denx.de,
 minda.chen@starfivetech.com, 
 rick@andestech.com, yunhui.liang@starfivetech.com
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:59 +0000
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785320994; x=1785925794; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1xydfTIaWySGeJelWDOZ4wWWwpvRDgPwId2Ds0YQJD8=;
 b=Cy025ZSIeU2R6ZYhF8/0Jl6C9sb5Ghd6mH14sclRto1hAsQqMwpUtwI2lgkd0qbAIL
 VGlH8OcuO2v8B9SGICGlmpb8JA0rKuArDZDRAa4lpWhIOS+qfFRopOXfzUU9vVLzHEJy
 g2pUjFtP4/IQj8MIueSb1afycD5wvLxxSU6MmnJYE98prj00Z1TLZE5yEHzqw1O9H7yy
 JFl36gQ6/EoL9CfZkauSLzrQR7IPepCqR4dEQCSd52gWgTAZKmZmNiL4eKk+7YsmfiMv
 VdVJJKGHihAuEd2lCf1QjrYd8ghZPLDTCg6DIG6AfsVKP1kqDxo6v0TjaqI3g0HPRw2q
 +2fw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Cy025ZSI
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=miladh1539@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cy025ZSI"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Thanks to both for the replies.

I built and tested both v2025.10 and v2026.01 on my board (VisionFive 2,
v1.3B, 8GiB), and can confirm both boot the SD card correctly, no cluster
read failure, straight into GRUB and Debian on both. Only v2026.07 fails
for me.

So the regression window looks to be somewhere between v2026.01 and
v2026.07. Full serial logs for both below.

Given the earlier note that this happens in the main U-Boot shell rather
than at SPL stage, I've held off testing the devicetree/pinctrl patch,
since it sounds like that may not be the relevant fix here let me know if
you still think it's worth trying. I'd be happy to look more into it or try
some patches.

--- v2025.10 log ---
U-Boot SPL 2025.10 (Jul 28 2026 - 19:21:15 +0200)
DDR version: dc2e84f0.
Trying to boot from SPI


U-Boot 2025.10 (Jul 28 2026 - 19:21:15 +0200)

CPU: sifive,u74-mc
Model: StarFive VisionFive 2 v1.3B
DRAM: 8 GiB
Core: 159 devices, 29 uclasses, devicetree: board
WDT: Not starting watchdog@13070000
MMC: mmc@16010000: 0, mmc@16020000: 1
Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size
256 Bytes, erase size 4 KiB, total 16 MiB
OK
StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : StarFive Technology Co., Ltd.
Product full SN: VF7110B1-2318-D008E000-18005137
data version: 0x2
PCB revision: 0xb2
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:ba:b0
Ethernet MAC1 address: 6c:cf:39:00:ba:b1
--------EEPROM INFO--------

starfive_7110_pcie pcie@940000000: Starfive PCIe bus probed.
starfive_7110_pcie pcie@9c0000000: Starfive PCIe bus probed.
In: serial@10000000
Out: serial@10000000
Err: serial@10000000
Net: eth0: ethernet@16030000, eth1: ethernet@16040000
starting USB...
Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
Bus xhci_pci: 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Working FDT set to ff71c720
Hit any key to stop autoboot: 0
Card did not respond to voltage select! : -110
** Booting bootflow '<NULL>' with efi_mgr
Booting: Label: mmc 1 Device path:
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6f00000000000000)/SD(1)/SD(1)
...
Loading Linux 6.12.96+deb13-riscv64 ...
Loading initial ramdisk ...
/dev/mmcblk1p2: recovering journal
/dev/mmcblk1p2: clean, 33993/861568 files, 371273/3443456 blocks
Debian GNU/Linux 13 visionfive-2 ttyS0
visionfive-2 login:

--- v2026.01 log ---
U-Boot SPL 2026.01 (Jul 29 2026 - 12:11:02 +0200)
DDR version: dc2e84f0.
Trying to boot from SPI


U-Boot 2026.01 (Jul 29 2026 - 12:11:02 +0200)

CPU: sifive,u74-mc
Model: StarFive VisionFive 2 v1.3B
DRAM: 8 GiB
Core: 158 devices, 29 uclasses, devicetree: board
WDT: Not starting watchdog@13070000
MMC: mmc@16010000: 0, mmc@16020000: 1
Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size
256 Bytes, erase size 4 KiB, total 16 MiB
OK
StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : StarFive Technology Co., Ltd.
Product full SN: VF7110B1-2318-D008E000-18005137
data version: 0x2
PCB revision: 0xb2
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:ba:b0
Ethernet MAC1 address: 6c:cf:39:00:ba:b1
--------EEPROM INFO--------

In: serial@10000000
Out: serial@10000000
Err: serial@10000000
Net: eth0: ethernet@16030000, eth1: ethernet@16040000
starting USB...
Starting the controller
USB XHCI 1.00
Bus xhci_pci: 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Working FDT set to ff71cd40
Hit any key to stop autoboot: 0
Card did not respond to voltage select! : -110
** Booting bootflow '<NULL>' with efi_mgr
Booting: Label: mmc 1 Device path:
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7000000000000000)/SD(1)/SD(1)
...
Loading Linux 6.12.96+deb13-riscv64 ...
Loading initial ramdisk ...
/dev/mmcblk1p2: clean, 33991/861568 files, 371273/3443456 blocks
Debian GNU/Linux 13 visionfive-2 ttyS0
visionfive-2 login:

Thanks for looking into this.
Milad H.


On Wed, 29 Jul 2026, 11:39 Yao Zi, <me@ziyao.cc> wrote:

> On Tue, Jul 28, 2026 at 07:02:02PM +0100, Conor Dooley wrote:
> > On 28/07/2026 15:42, Milad wrote:
> > > Hello everyone,
> > >
> > > Little reminder on this thread regarding my VisionFive 2 MMC boot
> issue.
> > >
> > > Archive link:
> > >
> https://lists.u-boot-project.org/pipermail/u-boot/2026-July/624724.html
> > >
> > > Just following up to see if anyone has had a chance to look at the
> details
> > > in my original message on the link.
> > >
> > > Thanks!
> >
> > I don't think you CCed anyone that cares about the platform on that
> > patch so that's probably the problem there.
> >
> > Is this the same issue that Ilya attempted to fix in the upstream version
> > of the devicetree for this platform?
> > https://lore.kernel.org/all/20260306171939.84568-1-k0tran@altlinux.org/
>
> Quoting logs in the link,
>
> > SD card (mmc1) fails to initialize in U-Boot. Full serial output:
> >
> > Card did not respond to voltage select! : -110
> > ** Booting bootflow '<NULL>' with efi_mgr
> > Loading Boot0000 'usb 0' failed
> > Error reading cluster
> > Loading Boot0001 'mmc 1' failed
> > EFI boot manager: Cannot load any image
> > Boot failed (err=-14)
> > Card did not respond to voltage select! : -110
> > Card did not respond to voltage select! : -110
> > Card did not respond to voltage select! : -110
> > Card did not respond to voltage select! : -110
>
> The problem happens in U-Boot shell instead of SPL stage, so it probably
> has nothing to do with the bootph-pre-ram change. Even if the pinctrl
> isn't available at SPL stage, it should still be picked by the proper
> U-Boot.
>
> > My subsequent PR for that lead to issues and it never got applied.
> >
> https://lore.kernel.org/soc/4dd4ffe6-307a-442b-ae99-50c88d4e5b84@freeshell.de/
> >
> > This happened back in March, and I just have not had the time nor
> > inclination to actually sort it out, and nobody else has stepped up.
> >
> > I think I will just pick that one patch back up again and resubmit
> > it for this cycle. After all, it doesn't change the configuration, just
> > the point at which the configuration should be done.
> >
> > If you could let me know if that patch helps, then it would be another
> > argument for actually (finally) getting it merged.
> >
> > Thanks,
> > Conor.
>
> Best regards,
> Yao Zi
>
