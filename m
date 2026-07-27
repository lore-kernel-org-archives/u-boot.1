Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D717C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACFA680D1F;
	Mon, 27 Jul 2026 09:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SS5qJrm4of3; Mon, 27 Jul 2026 09:24:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57D9D80C4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785144244;
	bh=fclnDS+5MVVFwcsdBwJqxnS2qAWjOm0mgO7LbeJ/QkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WjyA9u/QXE6SekBox8MWSg/pRD/OrXRMNGwqGOwpfI3WpP3y7RbX0wjuSgM+sjeGa
	 whQJRiOUkr4m7L9oUGwJbgRMItOmU+bg6yTw+Vt2lXRMvsRVXwZa0gd4nDn3hW19wV
	 AY6JfAP3MsmBhZ1dKo7IPswyPyiFCn8ml/AadLKb8YhKqvfcVH3zHgBUi5cTpYtlny
	 gwdZwNg09j0rYtefefDVPo2GjVnGQoLhb/y4yNJVyy9nsIzqOa6UcFPp7a1BKXcJY3
	 UTbLhXMivmh9h+Lntz0n1ESCcClnZ4qk4Fe54ZkvBgmIrgSbUEsFzhz7h8QpWHgMQv
	 Ok93dRKhOyb8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57D9D80C4E;
	Mon, 27 Jul 2026 09:24:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA3A126C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC08640109
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3WoL686bIEd for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:24:02 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 977F640106
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 977F640106
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 977F640106
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:24:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092B884671; Mon, 27 Jul 2026 11:24:00 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B82182991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:23:56 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40743601EC;
 Mon, 27 Jul 2026 09:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401211F000E9;
 Mon, 27 Jul 2026 09:23:54 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 28/75] usb: dwc3: import from kernel v5.4
In-Reply-To: <20260716134305.614278-29-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-29-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:23:52 +0200
Message-ID: <87zezc3hw7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785144235;
 bh=fclnDS+5MVVFwcsdBwJqxnS2qAWjOm0mgO7LbeJ/QkI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Tqf1Z5e9z9aBJYYBB1X/B8oIPKE89ihqK4pe3VtCAiexZdTQyPjBDeKAZH2+Zfk5L
 8EsOgohUfYCk39h8J2Qo+ittmuuS5/OOJsUizmTVOLTOESvHRFJGKLt8pU734j7EV/
 rhZPSWY0s1rJJTecRsMUiQ6PHxKieSb03rN/ogyDc2xhSDcM3VJYEbHEASbTxoxGBa
 Cy66+tOtRYdLmWUWs8f47R/53PIz/jM+/KFnuXmRLMKv5vWfmOsBhbQwWBr8tBcRKC
 k3LO5MazvwiMX2QBvP0a9Ias5XCle4pKUCgBcTBAurfzx16uG+lC0CUw7e8QDwENGr
 uB72hkEi0p58Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Tqf1Z5e9
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tqf1Z5e9"; 
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
> Sync Linux kernel dwc3 changes from v5.3 to v5.4.
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
> List of commits: git log --oneline v5.3..v5.4
> Commits imported:
> d8eca64eec71 usb: dwc3: gadget: fix race when disabling ep with cancelled xfers
> a7d9874c6f3f usb: dwc3: remove the call trace of USBx_GFLADJ
> 9bbfceea12a8 usb: dwc3: pci: prevent memory leak in dwc3_pci_probe
> a51bab592fbb usb: dwc3: select CONFIG_REGMAP_MMIO
> d819f6584c20 usb: dwc3: Remove dev_err() on platform_get_irq() failure
> f146b40ba1f0 usb: dwc3: Switch to platform_get_irq_byname_optional()
> a0a465569b45 usb: dwc3: remove generic PHY calibrate() calls
> 17b63704ec7c usb: dwc3: gadget: Workaround Mirosoft's BESL check
> 91f255a26bce usb: common: Separated decoding functions from dwc3 driver.
> 54fb5ba647f8 usb: dwc3: gadget: Set BESL config parameter
> 16fe4f304015 usb: dwc3: Separate field holding multiple properties
> 1cf084d161f4 usb: dwc3: meson-g12a: fix suspend resume regulator unbalanced disables
> bceb418b65b9 usb: dwc3: st: Add of_dev_put() in probe function
> e36721b90144 usb: dwc3: st: Add of_node_put() before return in probe function
> c09b73cfac2a usb: dwc3: don't set gadget->is_otg flag
> 240b65dc1e89 usb: dwc3: Use clk_bulk_prepare_enable()
> 03bf32bbb607 usb: dwc3: Use devres to get clocks
> 3cd703f483d1 usb: dwc3: remove generic PHYs forwarding for XHCI device
> 4749e0e61241 usb: dwc3: Update soft-reset wait polling rate
> b2a3974253d3 usb: dwc3: omap: squash include/linux/platform_data/dwc3-omap.h
> a6e5e6794a53 usb: dwc3: Switch to use device_property_count_u32()
> 5b76f6a0b0f8 usb: dwc3: keystone: use devm_platform_ioremap_resource() to simplify code
> 58dd0bad2554 usb: dwc3: omap: use devm_platform_ioremap_resource() to simplify code
> c6e4999cd930 usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code
> d3523b631403 usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code
> b33f37064b74 usb: Remove dev_err() usage after platform_get_irq()
> 41b57327b270 usb: dwc3: Switch to use device_property_count_u32()
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
