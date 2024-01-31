Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C43C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 13:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A0887B5D;
	Wed, 31 Jan 2024 14:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03307862DA; Wed, 31 Jan 2024 13:42:26 +0100 (CET)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D19087BC4
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from [192.168.1.204] (ti0116a430-2090.bb.online.no [85.165.3.49])
 (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 40VCgMuP029691
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:42:22 +0100
Message-ID: <6d8547c4-df1e-4325-8181-5d970bbc055d@opensuse.org>
Date: Wed, 31 Jan 2024 13:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Jonas Kvinge <jonaski@opensuse.org>
Subject: TPM setup on a RPI Compute Module 4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass (eclipse.jkvinge.net: 85.165.3.49 is whitelisted)
 receiver=eclipse.jkvinge.net; client-ip=85.165.3.49; helo=[192.168.1.204];
 envelope-from=jonaski@opensuse.org;
 x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with
 libspf2-1.2.10; 
X-Mailman-Approved-At: Wed, 31 Jan 2024 14:38:57 +0100
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

I have a CM4 with a sourcekit io board and a pi3g lets trust TPM. It's 
running Raspberry Pi OS Bookworm.

tpm2_pcrread shows zeros for all pcr's. My understanding is that the tpm 
needs to be setup on boot so the pcr values are populated.

So how can I best fill in the values for the TPM?

I've tried to build a custom u-boot with the boot.scr following the 
instructions on
https://github.com/joholl/rpi4-uboot-tpm/blob/ad31306ce2f2d52f0572385bfc8bac33cb1f1f68/README.md#setting-up-and-configuring

tpm2 init
tpm2 start TPM2_SU_CLEAR
mmc read $loadaddr 0x800 0x80000
hash sha256 $loadaddr *0x10000000
tpm2 pcr_extend 4 0x10000000
setenv kernel_comp_addr_r 0x0A000000
setenv kernel_comp_size 8194604
fdt addr ${fdt_addr} && fdt get value bootargs /chosen bootargs
fatload mmc 0:1 ${kernel_addr_r} kernel8.img
booti ${kernel_addr_r} - ${fdt_addr}

To create the image I use:

./tools/mkimage -A arm64 -T script -C none -n "Boot script" -d boot.scr 
boot.scr.uimg

However, when I use the "mmc read" command, the kernel no longer boots, 
it goes into an infinite reboot.

I've also tried building u-boot with CONFIG_MEASURED_BOOT according 
https://docs.u-boot.org/en/latest/usage/measured_boot.html
But then all the pcr's from 0-7 have the identical sha256 values, how come?

Jonas

