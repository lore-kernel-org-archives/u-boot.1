Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAE3C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB1887D15;
	Fri, 19 Jan 2024 17:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="g721RVX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+1G4jxu6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g721RVX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+1G4jxu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CFAC87D16; Fri, 19 Jan 2024 17:29:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B09187D0F
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4B7C21ECE;
 Fri, 19 Jan 2024 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705681787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O89YD+yn+UiVwTbdSNQSf7sIVu3Ztn1JWoqYyQiQojc=;
 b=g721RVX4jnepy4v+9w+6MIH0WqDmEhCo0j0yeesOCay+jlxyo9mgwsxp5njFywaZLvQ1vS
 w0Ut1+ktx5hHe6KPvtvtxQU5TTEWadNO9EP5+OoBiqAuDfDs2gZE30QDMhIM8QRNITZUmO
 3aJinIvdlaAafBTnF93IOg/MiLg9JQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705681787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O89YD+yn+UiVwTbdSNQSf7sIVu3Ztn1JWoqYyQiQojc=;
 b=+1G4jxu6LAJQ7RXxvD2GJXqFW/ACTzVmw0SAdTr1s8fMR8HWR8qOryzD3qbE2BmT5iqI4E
 DFVhIhajpn48esAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705681787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O89YD+yn+UiVwTbdSNQSf7sIVu3Ztn1JWoqYyQiQojc=;
 b=g721RVX4jnepy4v+9w+6MIH0WqDmEhCo0j0yeesOCay+jlxyo9mgwsxp5njFywaZLvQ1vS
 w0Ut1+ktx5hHe6KPvtvtxQU5TTEWadNO9EP5+OoBiqAuDfDs2gZE30QDMhIM8QRNITZUmO
 3aJinIvdlaAafBTnF93IOg/MiLg9JQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705681787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O89YD+yn+UiVwTbdSNQSf7sIVu3Ztn1JWoqYyQiQojc=;
 b=+1G4jxu6LAJQ7RXxvD2GJXqFW/ACTzVmw0SAdTr1s8fMR8HWR8qOryzD3qbE2BmT5iqI4E
 DFVhIhajpn48esAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B474136F5;
 Fri, 19 Jan 2024 16:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5R2aH3ujqmU1WQAAD6G6ig
 (envelope-from <iivanov@suse.de>); Fri, 19 Jan 2024 16:29:47 +0000
Date: Fri, 19 Jan 2024 18:29:46 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Jens Maus <mail@jens-maus.de>
Cc: Stefan Wahren <wahrenst@gmx.net>, u-boot@lists.denx.de
Subject: Re: Re: [PATCH v4 0/6] rpi5: initial support
Message-ID: <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
References: <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
 <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
 <3FB75D28-9BF9-4518-8BF1-519C884516F7@jens-maus.de>
 <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
 <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tizfwqawjzs3ie4b"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[multipart/mixed,text/plain];
 HAS_ATTACHMENT(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 CTYPE_MIXED_BOGUS(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+,1:+,2:+];
 MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[gmx.net,lists.denx.de]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
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


--tizfwqawjzs3ie4b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 01-19 17:12, Jens Maus wrote:
> >> 
> >> On the HDMI port, right? But what about the serial UART output? 
> > 
> > Yes, I can see serial output from U-Boot. I am using one of these
> > simple USB<->UART cables. You can see serial output when you boot
> > with RPiOS, when you use "Raspberry Pi Debug Probe”, right?
> 
> Yes, when booting up RPiOS I can first see the same serial debug output regarding the rpi boot loader until the same „NOTICE: BL31: …“ lines. Then RPiOS comes up and in the end I get an interactive serial console login "raspberrypi login:“ prompt on the RaspberryPi Debug Probe connection to that special UART port on the rpi5 pcb.
> 

Yeah, I don't know why I asked even though I saw those messages in your log.

> So you say with your own u-boot.bin you see serial U-Boot output after that „NOTICE: BL31: …“ lines? On that special UART port on the rpi5 or on the UART on the GPIO header?
> 

Yes :-) See attached log file.

Regards,
Ivan


--tizfwqawjzs3ie4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="RPi-u-boot.log"

RPi: BOOTSYS release VERSION:30de0ba5 DATE: 2023/10/30 TIME: 16:45:10
BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=1698684310 serial 3c533ede boardrev c04170 stc 815886
AON_RESET: 00000003 PM_RSTS 00001000
RP1_BOOT chip ID: 0x20001927
PM_RSTS: 0x00001000
part 00000000 reset_info 00000000
PMIC reset-event 00000000 rtc 00000000 alarm 00000000 enabled 0
uSD voltage 3.3V
Initialising SDRAM 'Samsung' 16Gb x2 total-size: 32 Gbit 4267
DDR 4267 1 0 32 152
RP1_BOOT chip ID: 0x20001927

RP1_BOOT chip ID: 0x20001927
RP1_BOOT: fw size 25968
PCI2 init
PCI2 reset
PCIe scan 00001de4:00000001
RP1_CHIP_INFO 20001927

RPi: BOOTLOADER release VERSION:30de0ba5 DATE: 2023/10/30 TIME: 16:45:10
BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=1698684310 serial 3c533ede boardrev c04170 stc 3726990
AON_RESET: 00000003 PM_RSTS 00001000
usb_pd_init status 1
Boot mode: SD (01) order f4
SD HOST: 200000000 CTL0: 0x00800000 BUS: 400000 Hz actual: 390625 HZ div: 512 (256) status: 0x1fff0000 delay: 276
SD HOST: 200000000 CTL0: 0x00800f00 BUS: 400000 Hz actual: 390625 HZ div: 512 (256) status: 0x1fff0000 delay: 276
OCR c0ff8000 [118]
CID: 00035344534e33324780fa570bda0169
CSD: 400e00325b590000edb07f800a400000
SD: bus-width: 4 spec: 2 SCR: 0x02358483 0x00000000
SD HOST: 200000000 CTL0: 0x00800f04 BUS: 50000000 Hz actual: 50000000 HZ div: 4 (2) status: 0x1fff0000 delay: 2
MBR: 0x00002000,  131072 type: 0x0c
MBR: 0x00022000, 1024000 type: 0x82
MBR: 0x0011c000,10321887 type: 0x83
MBR: 0x00000000,       0 type: 0x00
Trying partition: 0
type: 16 lba: 8192 'mkfs.fat' '  V       ^ ' clusters 32695 (4)
rsc 4 fat-sectors 128 root dir cluster 1 sectors 32 entries 512
FAT16 clusters 32695
[sdcard] autoboot.txt not found
Trying partition: 0
type: 16 lba: 8192 'mkfs.fat' '  V       ^ ' clusters 32695 (4)
rsc 4 fat-sectors 128 root dir cluster 1 sectors 32 entries 512
FAT16 clusters 32695
Read config.txt bytes     3046 hnd 0x123c
Read ubootconfig.txt bytes       35 hnd 0x468
[sdcard] extraconfig.txt not found
[sdcard] pieeprom.upd not found
usb_max_current_enable default 0 max-current 900
Read bcm2712-rpi-5-b.dtb bytes    79357 hnd 0x139f
dt-match: compatible: raspberrypi,5-model-b match: brcm,bcm2712
dt-match: compatible: brcm,bcm2712 match: brcm,bcm2712
PM_RSTS 00001000
Selecting USB low current limit

NOTICE:  BL31: v2.6(release):v2.6-239-g2a9ede0bd
NOTICE:  BL31: Built : 14:26:57, Jun 22 2023


U-Boot 2024.01-00778-ga7376eff69-dirty (Jan 19 2024 - 07:17:48 +0200)

DRAM:  fdtdec_setup_memory_banksize: DRAM Bank #0: start = 0x0, size = 0x3fc00000
fdtdec_setup_memory_banksize: DRAM Bank #1: start = 0x40000000, size = 0xc0000000
1020 MiB (effective 4 GiB)
mbox: Header response code invalid
RPI 5 Model B (0xc04170)
Core:  22 devices, 12 uclasses, devicetree: board
MMC:   mmc@fff000: 0, mmc@1100000: 1
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
mbox: Header response code invalid
bcm2835: Could not query MAC address
Net:   No ethernet found.
starting USB...
No working controllers found
Hit any key to stop autoboot:  0
U-Boot>
--tizfwqawjzs3ie4b--
