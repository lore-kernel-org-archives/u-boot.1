Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514EDC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9701A87508;
	Tue, 19 Dec 2023 13:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="qxbpq602";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFE4875BF; Tue, 19 Dec 2023 13:27:50 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1869287252
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f71ca0c6-9e69-11ee-abd4-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f71ca0c6-9e69-11ee-abd4-005056999439;
 Tue, 19 Dec 2023 13:27:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=kJjneFQcupLRF6YLU/CRMr3P6NwuEEDmoeIb1LhhXb4=;
 b=qxbpq602vGvREkIvwHzy9iTeXO15pfC39/62AcGVdmjn9fTZ2uOrrhY+RWEleS9A4P1KialK9ymKc
 K3pbg1Ls2rUEOypdw+iHZZDsuCzMIfGaoi9FOqFlQhngJ478XnvPOJijP8IWAdzi7qYEdINeCZOoIc
 Ks85Xh6/iqHUrvYOUGFveN7qikKSSAqeMD/rXYrEEbh6n/WVQu68EQ9llvO7vQ6U6HG87v9RCQqf/0
 ER5p2p0G38Wxe19datuMIDBcIm8lHYZ/+5ReKdcZjFv5SJkPitaNXltoll1TA8AR00+s+k+zMUFDyQ
 v4M/HwrXv8WZQzif+udi0/dogppBE9A==
X-KPN-MID: 33|BcltURf44ZYFAVd9uzBGvc1+dQsfyF/5czrKlEuSSJGqbENV6j5YfGsoLoa9YIB
 DyTNztJYusAqEjwbpWZ4hAn7zxbSgXbvlld3s9TAp/zg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Bhe96a23eSumpgjjbJBLEt6O7nKRkyPFFjpBStmwCdTmEOPdNweXJyvzCMTaBzE
 ckk/sS3UNGVsAQMpCXeDlqQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 03e7de69-9e6a-11ee-acaa-00505699d6e5;
 Tue, 19 Dec 2023 13:27:47 +0100 (CET)
Date: Tue, 19 Dec 2023 13:27:46 +0100
Message-Id: <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Michael Walle <mwalle@kernel.org>
Cc: xypron.glpk@gmx.de, Abdellatif.ElKhlifi@arm.com,
 Drew.Reed@arm.com, ilias.apalodimas@linaro.org, nd@arm.com,
 sjg@chromium.org, u-boot@lists.denx.de, mwalle@kernel.org
In-Reply-To: <20231219101124.2847425-1-mwalle@kernel.org> (message from
 Michael Walle on Tue, 19 Dec 2023 11:11:24 +0100)
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
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

> From: Michael Walle <mwalle@kernel.org>
> Date: Tue, 19 Dec 2023 11:11:24 +0100
> 
> Hi Heinrich,

Hi Michael,

> > Any runtime device drivers for variable storage should not be in the
> > U-Boot runtime but live in the secure world (e.g. OP-TEE) FF-A is the
> > new ARM protocol for talking to the secure world and hence fits into
> > the picture.
> 
> What if I just want a simple embedded boot stack where I don't
> want any secure world and just want to be able to boot a COTS linux
> distribution via EFI?

That already works for many Linux distros.  As long as the distro
installs the appropriate BOOTxxx.EFI file you don't actually need to
set any EFI variables for the OS to boot.  It can't get any simpler
than that.  Of the main Linux distros it seems that only Debian
doesn't do this.  Someone should probably lobby Debian to do this as
well as it would mean that Debian would just work on an EBBR compliant
system.

Things get more complicated if you want to install multiple OSes.
Then having EFI variable support makes things a lot more
straightforward.

And of course EFI secure boot needs EFI variable support as well (with
proper support) for authenticated EFI variables.  But IMHO that no
longer falls into "simple embedded boot stack" territory.

> Assuming, that there might be a simple dedicated EEPROM to store the
> variables which is not exposed to linux, is that something which would
> be rejected by u-boot mainline now?

Not necessarily.  But such an approach will have limitations:

* Completely hiding the EEPROM from the OS may be hard.  Even if you
  have a dedicated SPI controller for the EEPROM things like the SPI
  bus clock or power domains may still be under OS control.

* It is not possible to properly implement authenticated variables for
  secure boot if the EEPROM and associated hardware is just removed
  from the device tree but still accessable to the OS.  An
  implementation that pretends the variables are "secure" will
  probably be rejected.

Cheers,

Mark
