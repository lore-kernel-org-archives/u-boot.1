Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76295C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40A6660881;
	Tue, 28 Jul 2026 11:57:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EIxRjO0pOKIs; Tue, 28 Jul 2026 11:57:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 634E060817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239826;
	bh=ULkYgavP+jv13kZu8QAaiI/FUJJa7scRBpRxjenmYX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blNNE3GZlTRYFMs3jW3gi8wiX46xTaa1GgUSl96aWkrnoQ6nDEoEK5jBIxEAzMDAx
	 K5Dq5e1wINoqRdJmh1eHv1ZCfj4Dr8I9lJxuLZ9r3oxfBiN/tEekNAIp0bEA1+WiIA
	 Ed74n3SwMlDcuiaKrh14E3d1ezG5xaVhpO5EHxtKZI9c6p3uaWE9CBf1jDCLgf8H0H
	 0sCIivTo2xtyXXYOAq4189E/SqYIeYQe5Y7F4XW/Tmufeoember0JHNkT9/6Qw6Nid
	 f7bsTOH3+MTEpM81ItKcNCOjM8ibXYE26i1Oo6eVJ9R+K7RfeYYSMWKKBV2zd83saq
	 tXGNu5IBqyT1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 634E060817;
	Tue, 28 Jul 2026 11:57:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04A18357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA50881325
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QFjX2OIk-TRW for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:57:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 79080812DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79080812DC
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79080812DC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:57:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD368494B; Tue, 28 Jul 2026 13:57:01 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44E3882991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:56:59 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D341760A9B;
 Tue, 28 Jul 2026 11:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04E81F000E9;
 Tue, 28 Jul 2026 11:56:56 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 45/75] usb: dwc3: import from kernel v6.1
In-Reply-To: <20260716134305.614278-46-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-46-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 13:56:55 +0200
Message-ID: <87ecgn1g54.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785239817;
 bh=ULkYgavP+jv13kZu8QAaiI/FUJJa7scRBpRxjenmYX0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=KOkBmhvKjBFC0A5t/heARbWDFqFpb5kpIvK5+zcINUZr/8ZeObNFAx/5gRJpeXQdQ
 EcJd8HlApTJkK4ZfkgJQgfr3oIrFWmAfPQkt7HvyQAlZxfGDOoIfWMmXZur0lw2D0r
 yj/ASRTForyoECNGtDmSOCkwiJWxTyKIo4bJMrPIZAHIEHXeqnTDmNQ1VkDQeBmkX/
 YJnF1yR0ZVDZLZHKybyh5bmnSSlwzFB7Gv2hU24YCjRbtLiADuLrT9vk0ZKo4WzEp6
 7zGyCa1VvCaezjgGTvkS9Xsu7ITZaE+yeoWFD7gWU/MUEn8t5mjUS5iP5hRjrK1FMQ
 JXJkJinYtoAAQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KOkBmhvK
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="KOkBmhvK"; 
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

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v6.0 to v6.1.
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
> List of commits: git log --oneline v6.0..v6.1
> Commits imported:
> f90f5afd5083 usb: dwc3: gadget: Clear ep descriptor last
> e0481e5b3cc1 usb: dwc3: exynos: Fix remove() function
> 3aa07f72894d usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer
> d68cc25b7c7f usb: dwc3: Do not get extcon device when usb-role-switch is used
> 5c294de36e7f Revert "usb: dwc3: disable USB core PHY management"
> ffb9da4a04c6 usb: dwc3: gadget: Return -ESHUTDOWN on ep disable
> 308c316d16cb usb: dwc3: gadget: Don't set IMI for no_interrupt
> f78961f8380b usb: dwc3: gadget: Stop processing more requests on IMI
> 3f53c329b31d usb: dwc3: st: Rely on child's compatible instead of name
> 4db0fbb60136 usb: dwc3: gadget: Don't delay End Transfer on delayed_status
> d182c2e1bc92 usb: dwc3: Don't switch OTG -> peripheral if extcon is present
> 7a84e7353e23 Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
> 2adc960ce79d Revert "USB: fixup for merge issue with "usb: dwc3: Don't switch OTG -> peripheral if extcon is present""
> 2a735e4b5580 usb: dwc3: core: fix some leaks in probe
> 63d7f9810a38 usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error after resume bug
> a6fc2f1b0927 usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
> 93440d1fdf0a usb: dwc3: pci: Add PCIe device ID for USB3 controller on CPU sub-system for Alder Lake P
> ff2d2bee4750 usb: dwc3: pci: Update the macro names for USB PCIe device ID's for Alder Lake platforms
> d6edcdc1ef06 usb: dwc3: xilinx: fix usb3 non-wakeup source resume failure
> ec50e114385f usb: dwc3: xilinx: add power management ops support
> 875296ea8ff2 usb: dwc3: qcom: drop unneeded compatibles
> 76bff31c7fba usb: dwc3: gadget: Do not clear ep delayed stop flag during ep disable
> af870d93c706 usb: dwc3: Fix typos in gadget.c
> 8422b769fa46 usb: dwc3: gadget: Submit endxfer command if delayed during disconnect
> b353eb6dc285 usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer
> 461ee467507c usb: dwc3: Increase DWC3 controller halt timeout
> 5265397f9442 usb: dwc3: Remove DWC3 locking during gadget suspend/resume
> 2b2da6574e77 usb: dwc3: Avoid unmapping USB requests if endxfer is not complete
> dff981842a0b usb: dwc3: gadget: Continue handling EP0 xfercomplete events
> 9711c67de748 usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
> e1ee843488d5 usb: dwc3: gadget: Force sending delayed status during soft disconnect
> 359d5a85a758 usb: dwc3: Do not service EP0 and conndone events if soft disconnected
> d75807ab9569 usb: dwc3: qcom: clean up icc init
> b89bffa2efc9 usb: dwc3: qcom: only parse 'maximum-speed' once
> 808e8bff6fe4 usb: dwc3: trace: add Start of Frame Number to trace event
> 37a136aac3fe usb: dwc3: debug: show events parameters in hex
> b44c0e7fef51 usb: dwc3: gadget: conditionally remove requests

Please drop the irrelevant commits from the log here.
I see st, pci, xilinx, qcom and debug.

Maybe there are others.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

