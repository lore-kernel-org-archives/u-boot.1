Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1601DC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 06:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1741387F95;
	Thu, 28 Mar 2024 07:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7282B8808F; Thu, 28 Mar 2024 07:24:42 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A425D87F65
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 07:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42S6OIgR031420;
 Thu, 28 Mar 2024 14:24:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 14:24:16 +0800
Date: Thu, 28 Mar 2024 14:24:14 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Aurelien Jarno <aurelien@aurel32.net>, Minda Chen
 <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 <u-boot@lists.denx.de>, Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
Message-ID: <ZgUNDpJnA4eUB2Sf@swlinux02>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
 <ZgBAFWBB0-213CfQ@aurel32.net>
 <5e0b3ac7-819a-4d34-abc9-083caef0b5cb@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e0b3ac7-819a-4d34-abc9-083caef0b5cb@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42S6OIgR031420
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

Hi Heinrich,

On Wed, Mar 27, 2024 at 12:03:01PM +0100, Heinrich Schuchardt wrote:
> [EXTERNAL MAIL]
> 
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
> Yes, the Mars board has
> 
>     cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> 
> while the VisionFive 2 has
> 
>    broken-cd;
> 
> We could add the cd-gpios to the VF2 dts and then set broken-cd in
> spl_fdt_fixup_*().
> 
> What I would really like to understand from the reviewers is if the
> approach with patching the device-tree is what we are targeting for.
> 
> Or should we try to keep the device-trees in sync with Linux, package
> all JH7110 device-trees into the FIT image and in SPL choose the
> device-tree from the fit image and only patch the memory size.
> 
> The device-tree for the Milk-V CM module differs a lot in GPIO routing.
> I am not sure that patching the VF2 device-tree is future proof.

I think we could patch the VF2 device-tree currently with this few differeces,
and create a new device tree for Milk-V Mars CM module if patching the VF2 device tree
is too much of an effort.

Does this sound reasonable ?
Do you have any preference over which scheme we should use ?

Best regards,
Leo

> 
> Best regards
> 
> Heinrich
> 
> 
> > 
> >  From the schematics, it also seems that the usb0 port is not in
> > peripheral mode, but in host mode. That said on the submitted kernel
> > device tree it seems simply disabled.
> > 
> > Aurelien
> > 
> > [1] https://lore.kernel.org/linux-kernel/20240131132600.4067-2-jszhang@kernel.org/T/
> > 
> 
