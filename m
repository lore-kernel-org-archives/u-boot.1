Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B17E92FF9
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 08:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F1E86CCE;
	Fri,  6 Oct 2023 10:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iH3wJagT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A763886D30; Fri,  6 Oct 2023 10:37:50 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F00868BB
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 10:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id F2B48B8272A;
 Fri,  6 Oct 2023 08:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CC7C433C7;
 Fri,  6 Oct 2023 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696581467;
 bh=FgJYm01/N7btQ6Qz+G8RgkTRmDSNcZ+Y3gfxNpLK3Tg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iH3wJagTAe22K+Ho9b7VGPb4l4lwixmsS4OrGinVrtNjm56X8TWlcag3S4Pe0akve
 GMwvi2ADg93Sb0+A/dIQFcv+QWfjRof7It7afH70n+Zc/SHU1tNrI8cv4O0YPv/S5Y
 vfBrwcAP5o2I7/khzmM5esD2aO+XNle5mqK0pUMIRf+SGmzDAOaPpS8Al/gmwrbsB8
 LNJVySamIQ6vTUofquyw5J+5/NzthSkN0pXcO0zTj3QY1SMC3Xom7VwBa2rWa2uFN2
 QBLgX31TpeS0lfMQ116AnrP4EKQ3wHQqMVZq+YCz5kpLXJLsze3Rqin2tnaPlq8BEr
 QcqJ5gPkLtD/A==
MIME-Version: 1.0
Date: Fri, 06 Oct 2023 10:37:41 +0200
From: Michael Walle <mwalle@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: miquel.raynal@bootlin.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 ptyadav@amazon.de, rafal@milecki.pl, richard@nod.at, robh+dt@kernel.org,
 robh@kernel.org, trini@konsulko.com, u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
In-Reply-To: <CAPnjgZ2PnKD5m0EgTdEAf-gcK3wuBZvWw_AO2iehb1dmfdoz3A@mail.gmail.com>
References: <20231004093620.2b1d6917@xps-13>
 <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
 <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
 <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
 <a581ef73fa09c6ffeb83a1c1780053bd@kernel.org>
 <CAPnjgZ2PnKD5m0EgTdEAf-gcK3wuBZvWw_AO2iehb1dmfdoz3A@mail.gmail.com>
Message-ID: <27d37d4c7cf353d99737a1e7a450f9f7@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

>> I'm still not sure why that compatible is needed. Also I'd need to
>> change
>> the label which might break user space apps looking for that specific
>> name.
>> 
>> Also, our board might have u-boot/spl or u-boot/spl/bl31/bl32, right 
>> now
>> that's something which depends on an u-boot configuration variable,
>> which
>> then enables or disables binman nodes in the -u-boot.dtsi. So in linux
>> we only have that "bootloader" partition, but there might be either
>> u-boot+spl or u-boot+spl+bl31+bl32.
>> 
>> Honestly, I'm really not sure this should go into a device tree.
> 
> I think we might be getting a bit ahead of ourselves here. I thought
> that the decision was that the label should indicate the contents.
> If you have multiple things in a partition then it would become a
> 'section' in Binman's terminology. Either the label programmatically
> describes what is inside or it doesn't. We can't have it both ways.
> What do you suggest?

As Rob pointed out earlier, it's just a user-facing string. I'm a bit
reluctant to use it programatically.
Taking my example again, the string "bootloader" is sufficient for a
user. He doesn't care if it's u-boot with spl or u-boot with tfa, or
even coreboot. It just says, "in this partition is the bootloader".
If you have an "bootloader" image you can flash it there.

If it has a label "u-boot" and I want to switch to coreboot, will
it have to change to "coreboot"? I really don't think this is practical,
you are really putting software configuration into the device tree.

> At present it seems you have the image described in two places - one
> is the binman node and the other is the partitions node. I would like
> to unify these.

And I'm not sure that will work for all the corner cases :/

If you keep the binman section seperate from the flash partition
definition you don't have any of these problems, although there is
some redundancy:
  - you only have compatible = "binman", "fixed-partition", no further
    compatibles are required
  - you don't have any conflicts with the current partition descriptions
  - you could even use the labels, because binman is the (only?) user

But of course you need to find a place where to put your node.

> What does user space do with the partition labels?

I'm not sure. Also I'm not sure if it really matters, I just wanted to
point out, that you'll force users to change it.

-michael

>> >> What if a board uses eMMC to store the firmware binaries? Will that
>> >> then
>> >> be a subnode to the eMMC device?
>> >
>> > I thought there was a way to link the partition nodes and the device
>> > using a property, without having the partition info as a subnode of
>> > the device. But I may have imagined it as I cannot find it now. So
>> > yes, it will be a subnode of the eMMC device.
>> 
>> Not sure if that will fly.
> 
> I can't find it anyway. There is somelike like that in
> simple-framebuffer with the 'display' property.
> 
> Regards,
> SImon
