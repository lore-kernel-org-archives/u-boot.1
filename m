Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FE1C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 429E080BE6;
	Mon, 27 Jul 2026 08:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fs0NE49IYHKD; Mon, 27 Jul 2026 08:44:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E65280BD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141885;
	bh=Gurx+0PTTYGq/F0qxlHB7QeAYhJpcvXi//DoSqOabNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PzJ4kWyj53UMzl/IVbfcSJOWVTTsEmgJqub+zME66wccD9ljFasItRN2TYA0b4z+i
	 bay2Vd4MUQ2gTfD749TStV3Pezc1a6q6y+2b2AuXOMACk/Syn918GPYbegEkBbvi7l
	 kyD/0h7d+NGmRRhcI6BacO2+qR90hh5hEcDR+4smR8EIMPTpPaEpzrtWItHzIcYKCH
	 DY+ZExhf5qFBNe2wdYzFd3wkd/UHFJr3I4O7Upa32z5xk/0Py4x0PU8bnT9gxEsC52
	 23/SKX/sbH0fpWmV9uQHZuquWFRXtwwseASQPapl82uVkvFPg2ef8R7qGxHbI6dzzA
	 EElEwx2kF2L5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E65280BD4;
	Mon, 27 Jul 2026 08:44:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48393490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A322400F3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S3xUbIFpT2H1 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:44:42 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0805B4005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0805B4005F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0805B4005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:44:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8DF84671; Mon, 27 Jul 2026 10:44:38 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF43982991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:44:32 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B7CD43D5A;
 Mon, 27 Jul 2026 08:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523A81F000E9;
 Mon, 27 Jul 2026 08:44:27 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 03/75] usb: dwc3: import from kernel v4.0
In-Reply-To: <20260716134305.614278-4-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-4-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:44:25 +0200
Message-ID: <877bmg7rfa.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785141868;
 bh=Gurx+0PTTYGq/F0qxlHB7QeAYhJpcvXi//DoSqOabNA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=omjxnnba2UZLoMMjD0lOwk8n/gDSWItr7eTD2y+Q4+uRu58NRo+IeTiaRs4FNgvqP
 stxT651pODbSkJivHLRz5KX2e0GfNzHcCcjqM+bBjsfdAHbVi76wHnBUOLFjhS1tKg
 hhsRKdWByGESpmnKllCbE+dC1vQMCtw6LA2w8utwQVXh8kb4OqLx3mSvGJA5gEqF1I
 fL9EKu+1F7E0m7XtY6G0ws7hlsKyH+aAC0a9PUP78R1W7thQz4tS678bkd+Xs6JMJ6
 CHkJZ0O2t8thJTsLPT6ukSlo466bNwcZWioyomnToiAKKMRCZux7BdG+S6NcuRnG7Y
 npR4c10eswefw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=omjxnnba
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="omjxnnba"; 
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

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:41, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v3.19 to v4.0.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v3.19..v4.0
> Commits imported:
> 96e5d31244c5 usb: dwc3: dwc3-omap: Fix disable IRQ
> bcdea50312b2 usb: dwc3: gadget: use common is_selfpowered
> 5c7b3b02de76 usb: dwc3: gadget: add missing spin_lock()
> 73815280a5af usb: dwc3: remove reliance on dev_vdbg()
> 6bac4ff0a522 usb: dwc3: trace: add trace logs for core and gadget
> e9f2aa871c73 usb: dwc3: gadget: WARN() in case of unknown IRQ
> 4cd8f6d05599 usb: dwc3: gadget: avoid variable shadowing
> 2cd9ddf77e0d usb: dwc3: pci: code cleanup
> 3b44ed90cdb2 usb: dwc3: pci: rely on default PM callbacks from PCI driver utility
> d3fdcc78b2d6 usb: dwc3: pci: remove registration of NOP PHYs
> 3cd0e29d5e28 usb: dwc3: Remove current_trb as it is unused
> 110381e11b5f usb: dwc3: gadget: Remove redundant check
> dc93b41a1561 usb: dwc3: Fixed a typo in comments
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

