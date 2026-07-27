Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542B3C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D66280C46;
	Mon, 27 Jul 2026 09:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sGFKUZy7onDP; Mon, 27 Jul 2026 09:20:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A77C80C16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785144008;
	bh=tebfmSktClDGR7tj+UZlx3QW3UJyzpl9kOu/a1nHFLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w5VIKM07UCI6FhMT3iEVbxJB4ZfqsK3J2i85f3xVXjnB+/5NLJghUy/dVSdVZlxK1
	 ZudY+8NP64aJzNStVoJmInbvesEk5YtD7Zn7wancKsGjZvluEJWxnUeubyiU8QBk+F
	 czIW8LfY4vtlmaa6SWPR0kVhHtdWacjD2Wdi5yXGVsBG+LCAyW6MOTVTFmRX3I9Dvw
	 r508J6xvKuEiZKDW33Z07k9szu1ziKTTUx2VYFqEyIBMeihR98U0KGw3S2MV+fON2L
	 +Ty8NtPThZJh1La74XOl7tXDyrwiJWAK0JnStkuAz7LEnFInCVuoaqUzj68q1vk9yk
	 NlXeOhkdl4Qdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A77C80C16;
	Mon, 27 Jul 2026 09:20:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 25AA92E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C2FF40636
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeAIPT6xTvrm for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:20:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D01BA4057C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D01BA4057C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D01BA4057C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:20:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A0084671; Mon, 27 Jul 2026 11:20:05 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF8182991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:20:02 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C3F9601ED;
 Mon, 27 Jul 2026 09:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41561F000E9;
 Mon, 27 Jul 2026 09:19:59 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 26/75] usb: dwc3: import from kernel v5.2
In-Reply-To: <20260716134305.614278-27-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-27-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:19:57 +0200
Message-ID: <875x204wn6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785144000;
 bh=tebfmSktClDGR7tj+UZlx3QW3UJyzpl9kOu/a1nHFLU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=LxXtJJPrWrd0vBre2jCjh7sRExgBpem+EyJqj8O1j5j/cJmrtLJdd5pLnKjmOPHuw
 x7ZX8XSZwv71vsublqmmBgWsVuFrOmNph54egv12gYLCFzMzbKSPZ69OvBmVxLeLTC
 kfoesXoLvOcdKSnt6v91sERNQ/V1EbS8ImMTEwL+lFjuOaZkyjdFEk5iDoo9yH55el
 vorCRzWgOBNVGLCFtX4VxCcpZJT/XjOSP3M7V4b1o+KBfYhSrszkJgMrsUDXquULI5
 YV4EEiSTnhSUoiIs2004JEf3/K/jzORskLUJCf2uBxounqCL52qYwd+6pdKgApxVzr
 0OmoAh9oER36w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=LxXtJJPr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="LxXtJJPr"; 
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
> Sync Linux kernel dwc3 changes from v5.1 to v5.2.
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
> List of commits: git log --oneline v5.1..v5.2
> Commits imported:
> 2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRATA
> 8d791929b2fb usb: dwc3: Fix default lpm_nyet_threshold value
> dd24f9b604d3 usb: dwc3: debug: Print GET_STATUS(device) tracepoint
> b873e2d0ea1e usb: dwc3: Do core validation early on probe
> c729969b2b69 usb: dwc3: gadget: Set lpm_capable
> 41a91c606e7d usb: dwc3: move synchronize_irq() out of the spinlock protected block
> 75ecb9dd56a7 usb: dwc3: Free resource immediately after use
> c0c61471ef86 usb: dwc3: of-simple: Convert to bulk clk API
> c99993376f72 usb: dwc3: Add Amlogic G12A DWC3 glue
> 67130830ce42 usb: dwc3: Allow building USB_DWC3_QCOM without EXTCON

> f06ddb53096b BackMerge v5.1-rc5 into drm-next

I don't think this commit belongs in the list. Looking at the diff in
linux, it only seems to touch dwc3-pci.c which we have skipped according
to the commit message.

> f31d5c24fb2e reset: Add acquired flag to of_reset_control_array_get()

Same for this one, since it touches drivers/usb/dwc3/dwc3-of-simple.c
which we have skipped (as it's unused).

Can we update the commit message please?

Thanks,
Mattijs

