Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38876D78789
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 16:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C2D8968F;
	Thu, 21 Nov 2024 17:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Sgga76/K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1PZa+zu8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jJM95t6x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IC2zEG+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4F88916E; Thu, 21 Nov 2024 17:22:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42ACE89688
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 17:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 744C821208;
 Thu, 21 Nov 2024 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732206168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGotCMcXcl8aGVhF+/hdCOB5ajbuggm21CUlPGLSvo0=;
 b=Sgga76/KDeqOOh5JHjsltBWUsZPhcuFl9PrDE7fvQaR1l4+yGt2z0zp27yIHhdT4voZJ9J
 rCncemCy7C1Pg1KrkVu6WlZLZg55pmTaQApnTSKhCYTpnE7oVIdCgGzf0y2HlCkYcGP0OZ
 jkPH4OvFjZFg+Ibs/wFaGLSvOnixNFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732206168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGotCMcXcl8aGVhF+/hdCOB5ajbuggm21CUlPGLSvo0=;
 b=1PZa+zu8sGnvtcCQ1vufQaUmHbvEmJsZ1zywntDwTLMBC+JWc8aXJ7rQLD7/dzq6Dxp3px
 O/3izYweDNk7P3Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732206167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGotCMcXcl8aGVhF+/hdCOB5ajbuggm21CUlPGLSvo0=;
 b=jJM95t6xNFLxuG+m1+hNJ6zU3WNypIkXow/7UZ2VU860XUNNEkGRG/aQBf/gcump18jYCO
 /6+HVuaiY71B8xCAQT7/epBke3l8U7sFr383YhMt2RHHg56Y2Pm2Fo2jumqXhtLhtniTRP
 U1QhrE34EOHSWMnrEPyzFqTO7tbmVpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732206167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGotCMcXcl8aGVhF+/hdCOB5ajbuggm21CUlPGLSvo0=;
 b=IC2zEG+Hhf68DoiZdawAS20i5H2dQBUNVryn1Yz4iH+Gc1jJJbzrKt4vVgYh8iU/+NG2Rn
 Tre2sQIzYZE3E2DQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 6390E4A055F; Thu, 21 Nov 2024 17:22:47 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de,  E Shattow <lucent@gmail.com>,  Minda Chen
 <minda.chen@starfivetech.com>
Subject: Re: 2025.01-rc2 fails to boot on VisionFive2
In-Reply-To: <8d4e3685-8082-4b74-828f-05ccee5ac8e0@canonical.com> (Heinrich
 Schuchardt's message of "Thu, 21 Nov 2024 17:00:40 +0100")
References: <mvm8qtnv310.fsf@suse.de>
 <8d4e3685-8082-4b74-828f-05ccee5ac8e0@canonical.com>
Date: Thu, 21 Nov 2024 17:22:47 +0100
Message-ID: <mvmfrnko8tk.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.97 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_SPAM_SHORT(2.03)[0.676]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_NO_TLS_LAST(0.10)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.denx.de,gmail.com,starfivetech.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[0.199.110.176:email, opensuse.org:url,
 suse.de:mid, suse.de:email, 0.244.192.64:email, 0.152.150.128:email]
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

On Nov 21 2024, Heinrich Schuchardt wrote:

> On 13.11.24 11:31, Andreas Schwab wrote:
>> "Error reading cluster" is the new error.
>> U-Boot SPL 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
>> DDR version: dc2e84f0.
>> Trying to boot from MMC2
>> U-Boot 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
>> CPU:   sifive,u74-mc
>> Model: StarFive VisionFive 2 v1.2A
>> DRAM:  4 GiB
>> Core:  136 devices, 26 uclasses, devicetree: board
>> WDT:   Not starting watchdog@13070000
>> MMC:   mmc@16010000: 0, mmc@16020000: 1
>> Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>> *** Warning - bad CRC, using default environment
>> StarFive EEPROM format v2
>> --------EEPROM INFO--------
>> Vendor : StarFive Technology Co., Ltd.
>> Product full SN: VF7110A1-2249-D004E000-00000408
>> data version: 0x2
>> PCB revision: 0xa1
>> BOM revision: A
>> Ethernet MAC0 address: 6c:cf:39:00:16:8d
>> Ethernet MAC1 address: 6c:cf:39:00:16:8e
>> --------EEPROM INFO--------
>> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
>> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
>> In:    serial@10000000
>> Out:   serial@10000000
>> Err:   serial@10000000
>> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
>> starting USB...
>> Bus xhci_pci: Register 5000420 NbrPorts 5
>> Starting the controller
>> USB XHCI 1.00
>> scanning bus xhci_pci for devices... 2 USB Device(s) found
>>         scanning usb for storage devices... 0 Storage Device(s) found
>> Working FDT set to ff72ca10
>> Hit any key to stop autoboot:  0
>> Card did not respond to voltage select! : -110
>> ** Booting bootflow '<NULL>' with efi_mgr
>> Error reading cluster
>
> This is a message from the FAT file system driver.

The file system is ok when read after interrupting the boot.

StarFive # mmc dev 1
switch to partitions #0, OK
mmc1 is current device
StarFive # ls mmc 1:1
            EFI/
      304   ubootefi.var

1 file(s), 1 dir(s)

StarFive # ls mmc 1:1 EFI 
            ./
            ../
            BOOT/

0 file(s), 3 dir(s)

StarFive # ls mmc 1:1 EFI/BOOT
            ./
            ../
   167936   BOOTRISCV64.EFI
      164   grub.cfg

2 file(s), 2 dir(s)

But running boot will end with the above error, and mmc 1 no longer
works.

> Which image reproduces the problem?

I've built U-Boot here
<https://build.opensuse.org/project/show/home:Andreas_Schwab:riscv:u-boot>.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
