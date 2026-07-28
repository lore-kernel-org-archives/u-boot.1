Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640DC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81D06811DB;
	Tue, 28 Jul 2026 12:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_-e4mvD82wI; Tue, 28 Jul 2026 12:10:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51EEE81237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785240626;
	bh=ISiyRjOWcO/R0PbhJ6to4Y6W3f35Msvw0AvYIBvcl3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KOko9PSFBAILFKQn5Vp0VfA227Npk1MXbswpad+fBMlu1La9x6sHZClym1tQnbmI/
	 bn/CNbGh9FYAgOgHKXq6V789AoVVk3p2NfoCwRB5X1/OoQUCp1thC9XHWSNI3/GzIC
	 7xH9en1eD3/wmEtOVdK8rETKjwLEUmDvTIY/uIePEdEMPUdIQj5k8wK2y2kgqOfOAe
	 62Gsn0jOiEF4kZ/ZSYcWXNO586aAaZc3QBjJZd93GgHbiHV6x4YuYDCbdWGjxBsnGV
	 es7QONg3gVc3npYnrXXSG/QDz9XjyVbLGZSacMYcnDPoSsd4DQ9Y22CEUGa4FlBP+v
	 qnC25TVtGWbSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51EEE81237;
	Tue, 28 Jul 2026 12:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A5A0490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D4E9400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:10:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uR8rg8py6Xmv for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:10:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4DAC64030C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DAC64030C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DAC64030C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:10:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64FD8494B; Tue, 28 Jul 2026 14:10:22 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B9F82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 14:10:20 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 882D060AA1;
 Tue, 28 Jul 2026 12:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79971F000E9;
 Tue, 28 Jul 2026 12:10:18 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 46/75] usb: dwc3: import from kernel v6.2
In-Reply-To: <20260716134305.614278-47-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-47-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 14:10:16 +0200
Message-ID: <878q6v1fiv.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785240619;
 bh=ISiyRjOWcO/R0PbhJ6to4Y6W3f35Msvw0AvYIBvcl3c=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=oXkmDFLWV1lrfUSDbsb9BOF+UQLENEx7pPK+xAEs9A7Xd3+QW9xgIH8Ron3L/d0N3
 5pVTv2KzT65iAhODM/id85SABVr+jvoF78HzHPSCqsusqOxiPEZntj3TKJbr3h/4+K
 6jgVJWM7hkpOtExsqs1TtYwCq/+4wJgLbTXTELCoNhtgKA2nDny7f95A/CsG1s5RTE
 nhaUtZZaKEPes2U0G+PUeYjMN+m/LxyJZ11Y74qxtLkx0enZaA9F+2BYJGkNs28tDf
 4Lx1vgkSgAe/DzteGTrLWFY41H2a0zqFIWHbj5V+Evg5tPXi+aQYIH0suqIphWx/Xh
 ijMrqrFg75UnA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oXkmDFLW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="oXkmDFLW"; 
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
> Sync Linux kernel dwc3 changes from v6.1 to v6.2.
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
> List of commits: git log --oneline v6.1..v6.2
> Commits imported:
> eb320f76e31d usb: dwc3: qcom: enable vbus override when in OTG dr-mode
> 7d80dbd708c1 usb: dwc3: fix extcon dependency
> c4e3ef568539 usb: dwc3: gadget: Ignore End Transfer delay on teardown
> e498a0444324 usb: dwc3: xilinx: include linux/gpio/consumer.h
> 63130462c919 usb: dwc3: core: defer probe on ulpi_read_id timeout
> 97a48da1619b usb: dwc3: qcom: Fix memory leak in dwc3_qcom_interconnect_init
> 62c73bfea048 usb: dwc3: Fix race between dwc3_set_mode and __dwc3_set_mode
> f05f80f217bf usb: dwc3: pci: Update PCIe device ID for USB3 controller on CPU sub-system for Raptor Lake
> 3205054dc6fe usb: dwc3: improve the config dependency of USB_DWC3_XILINX
> 049142335613 usb: dwc3: gadget: Reduce TRB IOC settings

Please drop irrelevant commits from the changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

