Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2E1D41C2E
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 10:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC42889544;
	Wed, 13 Nov 2024 11:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="hOedei6Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c3N0ZWW7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hOedei6Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c3N0ZWW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B647989554; Wed, 13 Nov 2024 11:31:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0398894B1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 11:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2C4C5211B5
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731493867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=5EgOdJfd4Rqz2Ht2LMEGa8H+l+LDY571N2/57HTnk7Q=;
 b=hOedei6ZDHOwlwNHn3B8JGt2pOeb/GV84qvXyUA7mApxzhjm0YQIqD/cRVXyZFjgMVbW5D
 6QJLq1Pcl9nlN31PSnxWaJ/ysQCij1hc9qh2xGOprKeUTUrnGhc3DHxU1y1KGRZSZGmAeC
 n3kwpqZ91bxLKQ5jN1H+prcxzwbkWmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731493867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=5EgOdJfd4Rqz2Ht2LMEGa8H+l+LDY571N2/57HTnk7Q=;
 b=c3N0ZWW7A2PnoFLBl0JOrryg0CV+GM4Run2d83kNvMKw6jsef3wfIBLzws/7WK5OnukUi6
 j8YwKr6tvV8lSUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731493867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=5EgOdJfd4Rqz2Ht2LMEGa8H+l+LDY571N2/57HTnk7Q=;
 b=hOedei6ZDHOwlwNHn3B8JGt2pOeb/GV84qvXyUA7mApxzhjm0YQIqD/cRVXyZFjgMVbW5D
 6QJLq1Pcl9nlN31PSnxWaJ/ysQCij1hc9qh2xGOprKeUTUrnGhc3DHxU1y1KGRZSZGmAeC
 n3kwpqZ91bxLKQ5jN1H+prcxzwbkWmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731493867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=5EgOdJfd4Rqz2Ht2LMEGa8H+l+LDY571N2/57HTnk7Q=;
 b=c3N0ZWW7A2PnoFLBl0JOrryg0CV+GM4Run2d83kNvMKw6jsef3wfIBLzws/7WK5OnukUi6
 j8YwKr6tvV8lSUCg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 1D01C4A0555; Wed, 13 Nov 2024 11:31:07 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: u-boot@lists.denx.de
Subject: 2025.01-rc2 fails to boot on VisionFive2
Date: Wed, 13 Nov 2024 11:31:07 +0100
Message-ID: <mvm8qtnv310.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.15 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.15)[-0.753]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_NONE(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

"Error reading cluster" is the new error.

U-Boot SPL 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
DDR version: dc2e84f0.
Trying to boot from MMC2


U-Boot 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)

CPU:   sifive,u74-mc
Model: StarFive VisionFive 2 v1.2A
DRAM:  4 GiB
Core:  136 devices, 26 uclasses, devicetree: board
WDT:   Not starting watchdog@13070000
MMC:   mmc@16010000: 0, mmc@16020000: 1
Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
*** Warning - bad CRC, using default environment

StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : StarFive Technology Co., Ltd.
Product full SN: VF7110A1-2249-D004E000-00000408
data version: 0x2
PCB revision: 0xa1
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:16:8d
Ethernet MAC1 address: 6c:cf:39:00:16:8e
--------EEPROM INFO--------

starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
starting USB...
Bus xhci_pci: Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
scanning bus xhci_pci for devices... 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Working FDT set to ff72ca10
Hit any key to stop autoboot:  0 
Card did not respond to voltage select! : -110
** Booting bootflow '<NULL>' with efi_mgr
Error reading cluster
Loading Boot0000 'mmc 1' failed
EFI boot manager: Cannot load any image
Boot failed (err=-14)
Card did not respond to voltage select! : -110

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
