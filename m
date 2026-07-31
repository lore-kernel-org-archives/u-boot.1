Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B2AC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABE0160B5C;
	Fri, 31 Jul 2026 17:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfEEjfAn0rqW; Fri, 31 Jul 2026 17:19:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 629D360B54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518352;
	bh=79E4R5fKEzaMEze55t3YSb4LyKNnO9CJIIUBC9AJGrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QXWH+7R6QvJI+Rhiqsvi2nLctyv5aeoic+EcOoX0YYjhbertId7q3il1gcD/i4+AZ
	 supLAoo6FqlU0u2A3agfdWUr0H53Q1errFuCrhsGetjUr10bzmmTNRBtfxVVvIQMFB
	 RBbmLcBPNvnBggolfUvxwMFBSsGrkxo7zlJEC1fSdS8iEBKmiTryE7ZJZXZ2p5EzMd
	 14IL11HKBAJoVURxLDzrp/vhYTLFS2gQ/aeKudUfbpli/Ln5q0Aa7rOlO6NeEoxgkv
	 2/Uk5/KOuKMczC1kCmyulb2fEn3OJeeQrdXh+wsjio5ZsX3Ohi4DVj2wsY+E1BTNDr
	 j+uspIAuYnBIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 629D360B54;
	Fri, 31 Jul 2026 17:19:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45A0E27B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BEE160657
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:38:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jjO_dXgSDXiG for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:38:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=miladh1539@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C5A3F60612
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5A3F60612
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5A3F60612
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:38:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6CDC84A0F; Fri, 31 Jul 2026 18:38:53 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151FC80117
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 18:38:51 +0200 (CEST)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso1361859b3a.1
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 09:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785515929; cv=none;
 d=google.com; s=arc-20260327;
 b=QpWaRadvUq2FmXBV73fs8/GWyA9h7ZLhc6HNWJ/a4QvLH4eDhtn6XyFx/00MnuwW9R
 a/bEkrIY2+ofF61xgaTG4CUOMSrCIqXCF5cb/Ov5ga87NcahYabs7YTGUXcJHOEy//n+
 CbJONnLTzI6sIN5PqLTcdluDVFIbOUwjLFqrwClOhjrObSUbyCdTrZClCj+jRSzubqtw
 fxQekd0GZrfAOjDvDbrq3KLsOlpnubWiccn4UVmeOGhOSXRVDtl7Q3bd1nJpFHS87Zzi
 JEs2gTj1TafIeOBQk3aa72zNE19lco+u149bB906TY+qfepxNUaaJX1A/PWVeRjR43hL
 cZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RH7w7OrQ7s+Wz4OxScWN38HN15nIvSA1pX4ykkX855g=;
 fh=uQD47IRGyx+OI7MDLNCpWQ5nYOQBdQ4B03KT53OoooU=;
 b=pt/XkN4YLXy+ASJrV3FEwvtrItBWe7pL/AFv7hFNybJJDl6KaQNbJxCvpwA+9+aE0A
 uc6IrGOiYX3yxFYCGTqPmdof+Y0kr3pF9w0eEmurH35otlHgT5fXgV9JIa72M4MrnGeW
 N2BihYu4iPvIoYKRtCuzkFgri6c/hzsqUASLzCW1gRL66M3xsOAMJXvwH0LzWAopHpMx
 1rBAGoDhTLcLhPjW7y5EeKwwQtpSx974gTHEP+1S7D9XxEK5xa2WSLYEqqO1KfTfxfs/
 iaLFAPV1DvgwUZJiJr2lobRDSE6cp5KANOZOlrTjhKDmvSOvTSjCiF52PpzP6e+f28hd
 UijQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515929; x=1786120729;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RH7w7OrQ7s+Wz4OxScWN38HN15nIvSA1pX4ykkX855g=;
 b=UrkZoGA/kFL0wnXtS0oi71M500OTxhvlNmyEuLlePXaCT8T4q7z+0B3/3r4Z1t/NBt
 Y0agkIPC7CoS6+jHHi1/XahwRUFLbbLKD6YGsLwMZkDObmoL2J7gNpPrrhUjZi5xX2nd
 EHeUBF+N0MpU1OZY4gSJ4cwNQrVpuQztq4CAhIdmpoLaJKpukZ2lJ3FGairmhTLy0cqJ
 iktqP48j23dsd2UVkraqkPp5YaL2T4jlQqrz0IVk+SeCEMCKD8sYOiRMkUzB1d8kmrrw
 tcbBoYkqYWgdaHfftDkJpiMuiPYiCuJ1/pbMFATzQN/S9I9pA3VLPCkKHwPvw0aLp0f9
 Rs1g==
X-Gm-Message-State: AOJu0YxIVcrLjBc72eI8ID4YUAE1QbfVSFlyeH08uIRcvqRBuZfdu7KK
 aRoOZqjMmNyTx1i2EXYTPatyjtfU52QYq/q7MbBFZ9IUZ+FtDP5yqhql1T+j1YK10vxJBZpc0q0
 06Xz5rKFqFfJSNwWVSbd57Inre5peoqkiqA==
X-Gm-Gg: AR+sD10CgzsT2s5A0VufNn/aXe40GxRgcc2FEsUiFjyO8X1V0wXqV14qJI55G0x/VT7
 LkmxkkWWhmu2GvxoeAmYDFI2Eu3j0RCHS+uWvZVtQubAkFiWG2kmyz6+6AMWAfFVu9BrmjWupy9
 jeEZk+jp1EHEmr0XSBX5zPz4ZJhsnJ0AlHhcJV4OeG72PSOuvsYcMY2+Pibx/ccFx2INz2lVb8H
 /OnS6UeXjZBS5DZoky3nKTSTfMJyNJDlZX+i10CcE2pcYEgOA8Vl3A2Bva615sAz91C8UoW/THp
 5NJ1/RBvYuOvdJNv6Qicl192YQ5qPP+6IoUEanjo28oOIWc3X5YGoZ3N/9qwCAgi1UuRpqZMsZM
 =
X-Received: by 2002:a05:6a00:2343:b0:848:7e85:f208 with SMTP id
 d2e1a72fcca58-84ee4954d26mr312270b3a.37.1785515928929; Fri, 31 Jul 2026
 09:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
 <amjYiTYHlkwQF1RU@pie>
In-Reply-To: <amjYiTYHlkwQF1RU@pie>
From: Milad <miladh1539@gmail.com>
Date: Fri, 31 Jul 2026 18:38:38 +0200
X-Gm-Features: AUfX_mw8TR8KQMCdeJvUOCDVVidOFOQMU3lmTNSFM2cAHnoCw_hBo5kUyNSftCk
Message-ID: <CA+H9uty9YsK8DUF+e=94xOXvOSYmPs_r9_pvuQwmWsrP_Qzynw@mail.gmail.com>
Subject: Re: VisionFive 2 eMMC boot issues.
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de, minda.chen@starfivetech.com, rick@andestech.com
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:19:11 +0000
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785515929; x=1786120729; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RH7w7OrQ7s+Wz4OxScWN38HN15nIvSA1pX4ykkX855g=;
 b=JP4F95Ym/SetziQIk1wi17UHMKl7dAztzlEzHCokxiGGl6QpEjJ2B8Ffszy56HN0pe
 Tw8qIGUQkjoUpCyKaab18jwPEFl5b33BIzel5K7ECmMf5HizZmsPGAXbNnIUW18CR8iB
 XAKIx8WN6Fd2z0HseaxiYm1wsD60GcBQlro6tCnqQHEIdrx5+hDj9WzTIhvNZ+S062UN
 xnre0M2h3F1Jk3Hqfer136z33M+LXGFbAU0D8k0phFiOJ4uCVI3rxW5gqIWfw7oC5iW4
 B166mtXi/GUh0b0uK5L36rUUedikYgliBtXghS52Fs4PiH9Sm3dmjl0J9HsZStn+0x8S
 4VEg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JP4F95Ym
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=miladh1539@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JP4F95Ym"; 
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

Quick update, i also tested v2026.04 as well, and it also boots the SD card
correctly with the same clean pattern as v2025.10/v2026.01, straight
through to GRUB and Debian, no cluster read errors. Log below.

So the regression is most likely somewhere between v2026.04 and v2026.07.

Also worth mentioning, someone else in a community also reported having the
exact same errors on v2026.07 (SD/EFI boot failure), and mentioned v2026.04
worked for them too which is why i tried it so this isn't isolated to my
board specifically.

--- v2026.04 log ---
U-Boot SPL 2026.04 (Jul 31 2026 - 18:19:25 +0200)
DDR version: dc2e84f0.
Trying to boot from SPI


U-Boot 2026.04 (Jul 31 2026 - 18:19:25 +0200)

CPU: sifive,u74-mc
Model: StarFive VisionFive 2 v1.3B
DRAM: 8 GiB
Core: 159 devices, 30 uclasses, devicetree: board
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
USB XHCI 1.00
Bus xhci_pci: 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Working FDT set to ff6fab80
Hit any key to stop autoboot: 0
Card did not respond to voltage select! : -110
** Booting bootflow '<NULL>' with efi_mgr
Booting: Label: mmc 1 Device path:
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7200000000000000)/SD(1)/SD(1)
...
Loading Linux 6.12.96+deb13-riscv64 ...
Loading initial ramdisk ...
/dev/mmcblk1p2: clean, 61400/7364608 files, 4698361/29427968 blocks
Debian GNU/Linux 13 visionfive-2 ttyS0
visionfive-2 login:

Happy to keep looking into it this if useful, please let me know if there's
a specific commit or intermediate version i might need to test.


On Tue, 28 Jul 2026, 18:28 Yao Zi, <me@ziyao.cc> wrote:

> On Tue, Jul 28, 2026 at 04:42:03PM +0200, Milad wrote:
> > Hello everyone,
> >
> > Little reminder on this thread regarding my VisionFive 2 MMC boot issue.
> >
> > Archive link:
> > https://lists.u-boot-project.org/pipermail/u-boot/2026-July/624724.html
>
> The last time I tried upstream U-Boot with SD cards is about v2025.10 -
> v2026.01 and it works fine on my side. Could you try these two versions,
> too, so we know whether it's a new regression or just a bug yet to be
> discovered?
>
> Thanks,
> Yao Zi
>
> > Just following up to see if anyone has had a chance to look at the
> details
> > in my original message on the link.
> >
> > Thanks!
>
