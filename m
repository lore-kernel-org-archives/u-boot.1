Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35494C46CA0
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 11:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D29C870F4;
	Wed,  6 Dec 2023 12:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="j6op5ogI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833B086564; Wed,  6 Dec 2023 12:00:49 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3C1871CE
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 12:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: ad7a8131-9426-11ee-b94e-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id ad7a8131-9426-11ee-b94e-005056992ed3;
 Wed, 06 Dec 2023 12:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=BKsAGQHqX0jNzBLo/s/ChcEJwIrrVljQxK7l/PxtxXI=;
 b=j6op5ogIrFGYriD2Tr6rYQDlv7jxTZjYli+PKD7zbeDsUyMLrC285wUgAOd/AJpJzhzWoxMHR2IRy
 ZAJAkUKTIlci+yXmqd7isr3tJquO6Jx9WoJJmHPab98LdqGQDNYXx8zBxz4PSb8nwnntT9qFjUXv/F
 055OQisimMWZpgbg9Ktm9JlexZBWOTls0aCUVdk6cBUlgVX3DwtGRfwou+YUXrxRLKeAWNPWdTJBhU
 A7b+eWbkZmPPelEytOvhSoavrFVlMaUWBdcDR7lSCj5+XkN0fuO6L/ZfZZ1zKnkFsILHVwlNcI581J
 86iWEZsw8TGGKjBqClQcdoA51n2REMQ==
X-KPN-MID: 33|3LzirT3PwL09pab59NmtGzEhtl2R2FGEJUYXYMEMDCDjHeENMit6C878/rKX6cB
 qidpOHiJBeZrCXjDZ3MrJpx8nBMqGizhrGBvIssqKsnc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3pEvlZ/Vjw1QUbB0hJyoNsMNYg/fik6cmrggwob5G2gIVEPSNTsfaKXtaXRlKAg
 v+sjAIlAmXOxYl5AVqzGBOw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id aff01122-9426-11ee-acaa-00505699d6e5;
 Wed, 06 Dec 2023 12:00:38 +0100 (CET)
Date: Wed, 06 Dec 2023 12:00:37 +0100
Message-Id: <87a5qn8uju.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com,
 dsankouski@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, rayagonda.kokatanur@broadcom.com,
 lukma@denx.de, seanga2@gmail.com,
 jorge.ramirez.ortiz@gmail.com, stephan@gerhold.net,
 marex@denx.de, u-boot@lists.denx.de, sjg@chromium.org
In-Reply-To: <CAC_iWjKKjVQrt==U-CesqFq+xOCe736-kczaiA_cD-z=BEN+Sw@mail.gmail.com>
 (message from Ilias Apalodimas on Wed, 6 Dec 2023 12:31:15 +0200)
Subject: Re: [PATCH 00/21] Qualcomm generic board support
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAC_iWjKKjVQrt==U-CesqFq+xOCe736-kczaiA_cD-z=BEN+Sw@mail.gmail.com>
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

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Date: Wed, 6 Dec 2023 12:31:15 +0200
> 
> Hi Caleb,
> 
> Late to the party, but I'll respond to as much as I can
> 
> On Tue, 21 Nov 2023 at 19:09, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >
> > Historically, Qualcomm boards in U-Boot have all had their own
> > board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> > own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> > devicetree with little/no compatibility with upstream DT.
> >
> > This series makes a few final prepatory changes, and then replaces
> > almost all of the board specific code with generic alternatives. The end
> > result is that all Qualcomm boards both current and future (with the
> > exception of the db410c and db820c) can be supported by a single U-Boot
> > binary by just providing the correct DT. New boards can be added without
> > introducing any addition mach/ or board/ code or config options.
> >
> > Due to the nature of this change, the patch ("mach-snapdragon:
> > generalise board support") has become pretty big, I tried a few
> > different ways to represent this in git history, but the other methods
> > (e.g. adding a stub "generic" target and removing it again) were more
> > confusing and made for much messier git history. The current patch is
> > mostly atomic, but requires regenerating the config.
> >
> > The QCS404 EVB board had some code to enable the USB VBUS regulator,
> > this is dropped in favour of a adding a new vbus-supply property to the
> > dwc3-generic driver. This will also be used by the dragonboard845c in a
> > future patch. This handles the common case of a board requiring some
> > regulator be enabled for USB host mode.
> >
> > A more detailed description of the changes is below.
> >
> > == Memory map ==
> >
> > The memory map was historically hardcoded into U-Boot, this meant that
> > U-Boot had to be built for a specific variant of a device. This is
> > changed to instead read the memory map from the DT /memory node.
> >
> > Additionally, most boards mapped addresss 0x0 as valid, as a result if a
> > null pointer access happens then it will cause a bus stall (and board
> > hang). This is fixed so that null pointer accesses will now correctly
> > throw an exception.
> >
> > == DT loading ==
> >
> > Previously, boards used the FDT blob embedded into U-Boot (via
> > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > bootloader, so we can instead rely on the first-stage bootloader to
> > populate some useful FDT properties for us (notably the /memory node and
> > KASLR seed)
> 
> Note that the kaslr-seed is not so useful when booting with EFI.  The
> kernel's EFI-stub ignores that and instead tries to randomize the
> physical placement of the kernel if it finds an EFI_RNG protocol.

OpenBSD will use it though.  And other OSes might as well.

> >  and fetch the DTB that it provides. Combined with the memory
> > map changes above, this let's us entirely avoid configuring the memory
> > map explicitly.
