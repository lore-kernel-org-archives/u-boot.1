Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0E4C5516F
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 08:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3057040832;
	Sat,  1 Aug 2026 08:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sj4OtSJIVhgv; Sat,  1 Aug 2026 08:30:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11A4D4082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785573038;
	bh=6FnhVKXktNTAczhaSZFyVA/yAjI5f6UOfFdrR0xlSFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OAV1AewDtC1FcaSgxdcb+oGepdDrFHbWN6YxFeCtIdI/9CK3zqfzdAf4HdCjUg6j4
	 UM5eX5Sdc+FkVJ4/52L4qGwqoPlYWwqt6zk1G2sUusj2G8jN3uhjtAK4j+r4Ncydmv
	 3mSagY1sE7oTLOflhRGVevmiMZ4Vl4aS9YmVFMGOzo1XYJLdXhUO8y0eCGWnf7ySup
	 S6PYsgAirq0ofEEKobI17xmep0n/EroLU8SFSXINXpfHity818KMWbHTccRnB9lfIW
	 3wFgvOujEoavqnfj/JmJqz6QO7FTqfof3O8rmyJCdzCS7JFeB9iinawZNSQHpcZcpa
	 ip7TDsg+Ki+gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11A4D4082B;
	Sat,  1 Aug 2026 08:30:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A28D03A6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 08:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9483C80DEB
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 08:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32UdWC0VncRY for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 08:30:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1B3B180D6F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B3B180D6F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B3B180D6F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 08:30:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2A4F844F6; Sat,  1 Aug 2026 10:30:31 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE67B80117
 for <u-boot@lists.denx.de>; Sat,  1 Aug 2026 10:30:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; t=1785573022; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=anLKigkJXxBQIzAnjhy2vpAxhzegsPSXWA9iux203EZgYLV1SxgC1WL++rroxFPExAoBZyWlcT5jquyr9HVR9EMCt+1hVjiudhV8P7UBVhhRBMW959si0GP/Vq4UNMMeCPpk1Nw4KVcsV/9nNrDnEK0B4hwNbB1AZ7PSeqtX9RQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785573022;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6FnhVKXktNTAczhaSZFyVA/yAjI5f6UOfFdrR0xlSFM=; 
 b=N6cFW/5Syb75+diwU/Hb+ax269tqnUI4BZW+n8H/iUyUULiir9kQboas4DGCro2yVafRkIKad+f9uOVZ5RqquF6FBicBo7M51mNnuMW3+yrZG5JB/5GYlb2BwFPefOdk5o27xX/1X7ej18qFw4M6ASgdO2Dy/OE03E35Ct7z+Hg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785573020824884.5543580029071;
 Sat, 1 Aug 2026 01:30:20 -0700 (PDT)
Date: Sat, 1 Aug 2026 08:30:10 +0000
From: Yao Zi <me@ziyao.cc>
To: Milad <miladh1539@gmail.com>, Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de, minda.chen@starfivetech.com, rick@andestech.com
Subject: Re: VisionFive 2 eMMC boot issues.
Message-ID: <am2ukr9PzNtDUrp2@pie>
References: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
 <amjYiTYHlkwQF1RU@pie>
 <CA+H9uty9YsK8DUF+e=94xOXvOSYmPs_r9_pvuQwmWsrP_Qzynw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+H9uty9YsK8DUF+e=94xOXvOSYmPs_r9_pvuQwmWsrP_Qzynw@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.551.17
X-ZohoMailClient: External
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785573022; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=6FnhVKXktNTAczhaSZFyVA/yAjI5f6UOfFdrR0xlSFM=;
 b=p7JOhFkCjUnQxJVALAQqUUat7NfHW8YEr6wgzC6b7uM/jOUmNtrlgLg0dkYx0IjE
 B0NcbbCHaJ9K7uBd0xz6CqBFHAZL4eJqOoBw1pf7fweQeSmlAEjJ71heXgkF4BKbgq0
 zj6z4Q0pc3JyHPJm9BKPvibwlPtJEJlidYLG9fJc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=p7JOhFkC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=me@ziyao.cc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="p7JOhFkC"; 
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

On Fri, Jul 31, 2026 at 06:38:38PM +0200, Milad wrote:
> Quick update, i also tested v2026.04 as well, and it also boots the SD card
> correctly with the same clean pattern as v2025.10/v2026.01, straight
> through to GRUB and Debian, no cluster read errors. Log below.
> 
> So the regression is most likely somewhere between v2026.04 and v2026.07.

Thanks for the information. I'll take a look later this day.

Best regards,
Yao Zi

> Also worth mentioning, someone else in a community also reported having the
> exact same errors on v2026.07 (SD/EFI boot failure), and mentioned v2026.04
> worked for them too which is why i tried it so this isn't isolated to my
> board specifically.
> 
> --- v2026.04 log ---
> U-Boot SPL 2026.04 (Jul 31 2026 - 18:19:25 +0200)
> DDR version: dc2e84f0.
> Trying to boot from SPI
> 
> 
> U-Boot 2026.04 (Jul 31 2026 - 18:19:25 +0200)
> 
> CPU: sifive,u74-mc
> Model: StarFive VisionFive 2 v1.3B
> DRAM: 8 GiB
> Core: 159 devices, 30 uclasses, devicetree: board
> WDT: Not starting watchdog@13070000
> MMC: mmc@16010000: 0, mmc@16020000: 1
> Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size
> 256 Bytes, erase size 4 KiB, total 16 MiB
> OK
> StarFive EEPROM format v2
> 
> --------EEPROM INFO--------
> Vendor : StarFive Technology Co., Ltd.
> Product full SN: VF7110B1-2318-D008E000-18005137
> data version: 0x2
> PCB revision: 0xb2
> BOM revision: A
> Ethernet MAC0 address: 6c:cf:39:00:ba:b0
> Ethernet MAC1 address: 6c:cf:39:00:ba:b1
> --------EEPROM INFO--------
> 
> In: serial@10000000
> Out: serial@10000000
> Err: serial@10000000
> Net: eth0: ethernet@16030000, eth1: ethernet@16040000
> starting USB...
> USB XHCI 1.00
> Bus xhci_pci: 2 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Working FDT set to ff6fab80
> Hit any key to stop autoboot: 0
> Card did not respond to voltage select! : -110
> ** Booting bootflow '<NULL>' with efi_mgr
> Booting: Label: mmc 1 Device path:
> /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7200000000000000)/SD(1)/SD(1)
> ...
> Loading Linux 6.12.96+deb13-riscv64 ...
> Loading initial ramdisk ...
> /dev/mmcblk1p2: clean, 61400/7364608 files, 4698361/29427968 blocks
> Debian GNU/Linux 13 visionfive-2 ttyS0
> visionfive-2 login:
> 
> Happy to keep looking into it this if useful, please let me know if there's
> a specific commit or intermediate version i might need to test.
> 
> 
> On Tue, 28 Jul 2026, 18:28 Yao Zi, <me@ziyao.cc> wrote:
> 
> > On Tue, Jul 28, 2026 at 04:42:03PM +0200, Milad wrote:
> > > Hello everyone,
> > >
> > > Little reminder on this thread regarding my VisionFive 2 MMC boot issue.
> > >
> > > Archive link:
> > > https://lists.u-boot-project.org/pipermail/u-boot/2026-July/624724.html
> >
> > The last time I tried upstream U-Boot with SD cards is about v2025.10 -
> > v2026.01 and it works fine on my side. Could you try these two versions,
> > too, so we know whether it's a new regression or just a bug yet to be
> > discovered?
> >
> > Thanks,
> > Yao Zi
> >
> > > Just following up to see if anyone has had a chance to look at the
> > details
> > > in my original message on the link.
> > >
> > > Thanks!
> >
