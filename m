Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7858FC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43444605E0;
	Mon, 27 Jul 2026 09:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Augbc_gppylF; Mon, 27 Jul 2026 09:10:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A0F16062C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143425;
	bh=NsBm1poOknzrKnVUoK4IZoGce4DxUsAysDl4eQv6SOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hL4bcS0h3nPueNjTKAk3fb0b2pfoV6KXEJq3lJSAJeZmnEV35PYrUT+U3V16Z65AR
	 dMbBPFgzhVwLfMVVo8BT4384JZIJqiQe6yu9wg2d8WPLUyGIk1zpyC2034ZFcMz6um
	 6lcg2u3zRI1uWxy5bG+Nqjq1+6W/TrJmGKzMIVfrM0ZU5RlB1LdUiZGoxow+NVAngZ
	 ZMB2VwdANvvbGQ6bFRSJuD03s76IAvqDTUNyFJX4hUsoUNjIJw0muoSnjeXTftQyvA
	 ImO8MskuCOmed08UZbpPB7jBSIcpPbGAhOu33/m+YaSjWmuRB90k+89Vzpc/qlq1v1
	 YZR/5erhzNpuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A0F16062C;
	Mon, 27 Jul 2026 09:10:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0162E357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBFC46062C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_Yj8TGWnfaN for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:10:21 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 60289605E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60289605E0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60289605E0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:10:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31B184671; Mon, 27 Jul 2026 11:10:19 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E8282991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:10:15 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D225408E8;
 Mon, 27 Jul 2026 09:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DDF1F000E9;
 Mon, 27 Jul 2026 09:10:13 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 20/75] usb: dwc3: import from kernel v4.17
In-Reply-To: <20260716134305.614278-21-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-21-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:10:11 +0200
Message-ID: <87o6fs4x3g.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143414;
 bh=NsBm1poOknzrKnVUoK4IZoGce4DxUsAysDl4eQv6SOg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=od6DuQ9Sbc9BmZu3/0O4XogC9nXPNMzXLEmlc2+wJ+uBiwZHfeLIbN4C9SgqrLyZi
 ZXJ05EDMlkXfSRJwxB6Ocu089llAasshRyIgVSpbN3s2hKGhwHkOl8yhaD5fpPGZ8P
 1RAUc6y5sGlS6+5g1VVXAFvEcjp3GxTZ7NQoBdZgP8XhKgmvmoX5fTfP9Hkq+W2Lia
 N/8Tkv1N9DV5NGiJh1iUzwdzxZKT4f+1A9ABNOomBc8Ig2DbR5yGQeZHywUxEbgdzJ
 ySuk0n6HQ7WEUa7BzzlP3rp5+USXrO2L0vzbSRvixq2WWVfz2utNyUrPYKIzK+W1n8
 dezOC9TKSP6ew==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=od6DuQ9S
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="od6DuQ9S"; 
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
> Sync Linux kernel dwc3 changes from v4.16 to v4.17.
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
> List of commits: git log --oneline v4.16..v4.17
> Commits imported:
> 96bd39df29c2 usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue
> 9cffd15de0c3 usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static
> c91815b59624 usb: dwc3: gadget: never call ->complete() from ->ep_queue()
> 7d11c3ac6669 usb: dwc3: core: Fix broken system suspend/resume on AM437x
> 2f3090c6a8f2 usb: dwc3: Check controller type before setting speed
> 80b776340c78 usb: dwc3: Dump LSP and BMU debug info
> 938a5ad1d305 usb: dwc3: Check for ESS TX/RX threshold config
> 6743e817a4de usb: dwc3: Add DWC_usb31 GTXTHRCFG reg fields
> 01b0e2cc7d89 usb: dwc3: gadget: Check IP revision for GRXTHRCFG
> 2fbc5bdc8fd1 usb: dwc3: Add DWC_usb31 GRXTHRCFG bit fields
> d548a61767fa usb: dwc3: Check IP revision for GTXFIFOSIZ
> 0cab8d26d6e5 usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields
> fab383333877 usb: dwc3: Add SoftReset PHY synchonization delay
> cabdf83dadfb usb: dwc3: pci: Properly cleanup resource
> de948a74ad6f usb: dwc3: Makefile: fix link error on randconfig
> 7642d8386ac7 usb: dwc3: ep0: remove redundant assignment
> 498f0478aba4 usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
> f09cc79b4b33 usb: dwc3: add dual role support using OTG block
> daaecc6541d0 usb: dwc3: prevent setting PRTCAP to OTG from debugfs
> 4cff75c7fe3d usb: dwc3: core.h: add some register definitions
> e8284db48f1f usb: dwc3: of-simple: add support for the Amlogic Meson GXL and AXG SoCs
> ff0a632f0875 usb: dwc3: of-simple: add support for shared and pulsed reset lines
> 6d5b53c1fd5c usb: dwc3: debugfs: Re-use DEFINE_SHOW_ATTRIBUTE() macro
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

