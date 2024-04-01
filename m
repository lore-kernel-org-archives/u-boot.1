Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F4FCD128D
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 15:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4782882F0;
	Mon,  1 Apr 2024 17:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=aurel32.net header.i=@aurel32.net header.b="r2+EE3IS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A424F88087; Mon,  1 Apr 2024 17:28:49 +0200 (CEST)
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659278803E
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 17:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aurelien@aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=HbTZPIMn/Mc3ePmtfA4H/4k/bJQeHHD3qIKPaWpjWGE=; b=r2+EE3ISmnOISZoeUaiMMWTL9z
 ys5gFo9gN95BhnhmJklRibBsRaz9UxiD37qxTJlrdBqaotDdVsROFXhEpgzIcssvIBHZy7fCUNHur
 WXv6VJ582QfxmiC8GbCmd6sSRKYgCbhC6iH/Z8SbqmR756DQFpNpy9ag/pGTHpXY1o/CzkUMPeiDh
 KHc2k62c2PKZCo420Tu13kn9JVRtwGKh4kByqoSB06nz8v5umqTUbnWi7syJxkdhpQy97o9O1k/IG
 Un6audbEncChecDoEBZ4esuJvsp6mkVcx9SVZBapED5g6OO1iJ+HkYlI7gbmXWOvARlK2O1JJo3Pv
 o95CNEyw==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <aurelien@aurel32.net>) id 1rrJaH-00H7uW-0t;
 Mon, 01 Apr 2024 17:28:29 +0200
Date: Mon, 1 Apr 2024 17:28:28 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 E Shattow <lucent@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
Message-ID: <ZgrSnExL1iTg8nSC@aurel32.net>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
 <ZgBAFWBB0-213CfQ@aurel32.net>
 <b5af9050-aa50-4445-9de3-4e5f368621b7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5af9050-aa50-4445-9de3-4e5f368621b7@canonical.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

On 2024-03-28 17:01, Heinrich Schuchardt wrote:
> On 24.03.24 16:00, Aurelien Jarno wrote:
> > On 2024-03-21 19:11, Heinrich Schuchardt wrote:
> > > The differences between the Milk-V Mars board and the VisionFive 2 board
> > > are small enough that we can support both using the same U-Boot build.
> > > 
> > > * The model and compatible property are taken from proposed Linux patches.
> > > * The EEPROM is atmel,24c02 according to the vendor U-Boot.
> > > * The second Ethernet port is not available.
> > 
> >  From the device tree that have been submitted to the kernel [1] it seems
> > another difference is that there is a CD gpio for mmc1.
> 
> Thank you for reviewing.
> 
> On all of Milk-V Mars, VisionFive 2 1.2B, and 1.3A I see GPIO 41 level
> changing when removing or inserting an SD card using U-Boot command 'gpio
> status -a'. So this seems not to be Milk-V specific.
> 
> Could you, please, check.

This already have been answered by others, thanks.

> >  From the schematics, it also seems that the usb0 port is not in
> > peripheral mode, but in host mode. That said on the submitted kernel
> > device tree it seems simply disabled.
> 
> All three blue-colored USB 3.0 ports are able to read an SD-card in U-Boot.
> 
> The black port provides 5V but I could not make it work.
> 
> On the schema I found:
> 
> USB20: Do not support OTG mode and AVSS_USB0-AVSS_USB2 attached to ground.
> 
> Could you, please, specify which node in the device-tree you want to
> disable. I cannot see anything disabled for usb@10100000 and usb@0 in the
> kernel device-tree.

Disclaimer, I have no such board, but I remember people on IRC trying to
use the device tree from the VF2 on a Milk-V Mars and getting an error
with the USB being in a wrong mode.

The difference I have noticed is not a node but the dr_mode property:

&usb0 { 
        dr_mode = "peripheral";
        status = "okay";
};

This does not appear on the patches submitted on the Linux side for the MilkV
Mars.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
