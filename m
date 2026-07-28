Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55162C54EFC
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 251098114C;
	Tue, 28 Jul 2026 09:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tg4_vh8UUfWz; Tue, 28 Jul 2026 09:30:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5118A811DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785231013;
	bh=PjqTZpuE8fzHS9fGKYHX3kJwm62OvlThgqD7lc5PzBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=idmYwt7UpEA2EGdV/UVCJMOT+FphLRf2VdH5F0QPO7Utg1Vl4C4U6FEPy8YP5Rm2u
	 G5lmqDF/HM7cxotjZJuu3zQ9op8NF8M4k9CpuQ+bViheXTAXCP2miP2lJ4M3vzqsch
	 6X+oNuPmHErooPCJi9APfaHe1UGha59C9HeE3yx/xHI0ruG8Hyuzjqov/AQ5Senebj
	 xVC7WjG/xkg0Q14aQ7mgUGp+J8phBjOGVBT+HCnrjawvHQEK2Rwaa/Wr+QUYp3grLF
	 +iXypfnSxOuAIf5ciw5knNtWL6iV0uBEdkkgDFlTU90KwrowQcJNHWvTv/W84IWnl/
	 3itEMQgPqjxPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5118A811DB;
	Tue, 28 Jul 2026 09:30:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE5322E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4E0160820
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Emv3qquQrRMw for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:30:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C0C5A60735
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C0C5A60735
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0C5A60735
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:30:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1E1848BA; Tue, 28 Jul 2026 11:30:08 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DAD182991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:30:05 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08D764390C;
 Tue, 28 Jul 2026 09:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556E91F000E9;
 Tue, 28 Jul 2026 09:30:03 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 40/75] usb: dwc3: import from kernel v5.16
In-Reply-To: <20260716134305.614278-41-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-41-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:30:01 +0200
Message-ID: <87se531mxy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785231003;
 bh=PjqTZpuE8fzHS9fGKYHX3kJwm62OvlThgqD7lc5PzBw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=kbg33PLzTtyD57Nf4iUWbXul1iBpBveoSH/FT9ZdlAU4qgHzAv3O8mB7nvwTSTcI9
 FXvGQw6VBWDqxAWkyn5XzaVmOM97nUzxAYCdKiKTjIbqGWkTIlyxOJGz8asUgpKw8u
 nSstPZmBKQwPrMkIqxPE1CUQ5nV6YyAuC78L7YG39ecw7wyo8iaAEzeRaYWsX5FIvY
 R1NMed0d5JWo7D82UBYQ7FtCXTYqoD5s7OEbTuZTFvM3W+XBl6sIGIDPrwRNHdZzgy
 kbSOkejp7XQb1itFva5ZBaT2Hq7Se6BNja3yNdTKsHGyafKZ/MT8XSo7kvvlony8ax
 EcPZRhZs2kSZg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=kbg33PLz
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="kbg33PLz"; 
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
> Sync Linux kernel dwc3 changes from v5.15 to v5.16.
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
> List of commits: git log --oneline v5.15..v5.16
> Commits imported:
> 6a97cee39d8f Revert "usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default"
> 47ce45906ca9 usb: dwc3: leave default DMA for PCI devices
> 26288448120b usb: dwc3: gadget: Fix null pointer exception
> 63c4c320ccf7 usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer
> d74dc3e9f58c usb: dwc3: gadget: Ignore NoStream after End Transfer
> 250fdabec6ff usb: dwc3: core: Revise GHWPARAMS9 offset
> d1a4683747fe usb: dwc3: Align DWC3_EP_* flag macros
> 876a75cb520f usb: dwc3: gadget: Skip resizing EP's TX FIFO if already resized
> b851f7c7b8fd usb: dwc3: gadget: Change to dev_dbg() when queuing to inactive gadget/ep
> 2abc865706c9 usb: exynos: describe driver in KConfig
> 8217f07a5023 usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind
> 7bee31883889 usb: dwc3: reference clock period configuration
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

