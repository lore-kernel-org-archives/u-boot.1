Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C49C54EFC
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E076840919;
	Tue, 28 Jul 2026 09:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEE68u1xsOsw; Tue, 28 Jul 2026 09:17:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1B3F408D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785230265;
	bh=DBk8CM1u8REQ1WMimcYLIOHZu4scbcpYNYXGQ+25vxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RUnFkI59hYIrfrMpULd6+R2BhutbRo/7ZfRLW/po10+E0Pl+no9j8r4lLNYhaRJDI
	 ZsbFglCUrGRYTadEgWMs8yp+ig3MiChAV7XYOUHfvtsJbz1eMACH9UdiBiwbt6bisd
	 U7MlycE0eAuTVFnN/xWt170UYPQWT6MM+ERTe0qMp1QlHkRKIE3xm7VAoS4dpQ+iKq
	 C5cFSambZLdoO9gbB72Fq5ViFtNdTGkYQFewfapSOr7deAuxbqQ8IzClBOfKoULFXg
	 jhoQ1Tx8foVlzqefYKvcWTA1sx6FPdSqMDji0QZm4Wj+7nTHxgRW3cVTvcggWKjAEk
	 XzxYruA0e3Pzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1B3F408D5;
	Tue, 28 Jul 2026 09:17:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46C0C2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E1D58131C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OwRXiRERA6Ig for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:17:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 10E158131A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10E158131A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10E158131A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:17:42 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B0A784873; Tue, 28 Jul 2026 11:17:39 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD4982991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:17:37 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86E3B41402;
 Tue, 28 Jul 2026 09:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE39B1F000E9;
 Tue, 28 Jul 2026 09:17:34 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 34/75] usb: dwc3: import from kernel v5.10
In-Reply-To: <20260716134305.614278-35-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-35-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:17:32 +0200
Message-ID: <87a4rb3237.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785230255;
 bh=DBk8CM1u8REQ1WMimcYLIOHZu4scbcpYNYXGQ+25vxU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=f2EOj6dmqEcrnxG74NY26JrYM8feUE+6kqhJxYAFWH1MVO0MHA5pbWBjq2OtxkCbX
 /73u+W+/xAJDpJFDZF1lmVW1zNT5/azoXgk5oBj1erbO1CbyzZRwyDuf4JzIooFP+D
 c74dbz1lIe1uG2I7vUqkS2bFSh+t6/lfp325r/daJVISOg4/FIoXAPb87putjDmouL
 AOFZ+CtP6phxzvtkhi2PPshBUjz43IVnyQPqnC6SsL2buQzco7uD4rk49vLxuMzMdw
 xHtnxVqI0fyz8ll2wMt177q8qFX3DRrA/T+roIqHZmBIAoqXe1Cweew2dpCrplpPQe
 Rgq6pftA/IbOA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=f2EOj6dm
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="f2EOj6dm"; 
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
> Sync Linux kernel dwc3 changes from v5.9 to v5.10.
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
> List of commits: git log --oneline v5.9..v5.10
> Commits imported:
> cbdc0f54560f usb: fix kernel-doc markups
> fa27e2f6c5e6 usb: dwc3: ep0: Fix delay status handling
> 1384ab4fee12 usb: dwc3: pci: add support for the Intel Alder Lake-S
> e2c53515b2a6 usb: dwc3: of-simple: Add compatible string for Intel Keem Bay platform
> e0a93d98f488 usb: dwc3: gadget: Support up to max stream id
> 2338484d14f3 usb: dwc3: gadget: Return early if no TRB update
> 346a15cdf652 usb: dwc3: gadget: Keep TRBs in request order
> 8dbbe48c7a99 usb: dwc3: gadget: Revise setting IOC when no TRB left
> f9cc581badb1 usb: dwc3: gadget: Look ahead when setting IOC
> d72ecc08dee4 usb: dwc3: gadget: Allow restarting a transfer
> ae7e86108b12 usb: dwc3: Stop active transfers before halting the controller
> f580170f135a usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc
> 7f2958d9ad58 usb: dwc3: gadget: Rename misleading function names
> cb1b3997b636 usb: dwc3: gadget: Refactor preparing last TRBs
> 30892cba5596 usb: dwc3: gadget: Set IOC if not enough for extra TRBs
> 490410b2e73c usb: dwc3: gadget: Check for number of TRBs prepared
> 13111fcb0d64 usb: dwc3: gadget: Return the number of prepared TRBs
> 66706077dc89 usb: dwc3: ep0: Fix ZLP for OUT ep0 requests
> a2841f41d07f usb: dwc3: gadget: Improve TRB ZLP setup
> 2b80357b773c usb: dwc3: gadget: Refactor preparing extra TRB
> 690e5c2dc29f usb: dwc3: gadget: Reclaim extra TRBs after request completion
> ca3df3468eec usb: dwc3: gadget: Check MPS of the request length
> 8266b08ed90c usb: dwc3: gadget: Refactor ep command completion
> 5bde3f020a15 usb: dwc3: debugfs: do not queue work if try to change mode on non-drd
> 03c1fd622f72 usb: dwc3: core: add phy cleanup for probe error handling
> 266d0493900a usb: dwc3: core: don't trigger runtime pm when remove driver
> e81a7018d93a usb: dwc3: allocate gadget structure dynamically
> a609ce2a1336 usb: dwc3: pci: Allow Elkhart Lake to utilize DSM method for PM functionality
> 65f3d449f438 usb: dwc-meson-g12a: Add support for USB on AXG SoCs
> dc336b19e82d usb: dwc3: core: do not queue work if dr_mode is not USB_DR_MODE_OTG
> e319bd62292c usb: dwc3: gadget: fix checkpatch warnings
> 87b923a2e059 usb: dwc3: core: fix checkpatch warnings
> 9ae0eb455b91 usb: dwc3: debugfs: fix checkpatch warnings
> 993ffc5b32d2 usb: dwc3: qcom: fix checkpatch warnings
> c64b475b8488 usb: dwc3: ep0: fix checkpatch warnings
> 035cbca1360a usb: dwc3: debug: fix checkpatch warning
> 159fdf295c67 usb: dwc3: trace: fix checkpatch warnings
> 2a499b452952 usb: dwc3: ulpi: fix checkpatch warning
> e5ee93d42b3f usb: dwc3: meson: fix checkpatch errors and warnings
> 27c7ab0fdd0b usb: dwc3: debug: fix sparse warning
> a793cf81ad0c usb: dwc3: meson: fix coccinelle WARNING
> bea46b981515 usb: dwc3: qcom: Add interconnect support in dwc3 driver
> e518bdd9f02c usb: dwc3: core: Print warning on unsupported speed
> b574ce3ee459 usb: dwc3: core: Properly default unspecified speed
> b68d9251561f usb: dwc3: simple: add support for Hikey 970
> d97c78a1908e usb: dwc3: gadget: END_TRANSFER before CLEAR_STALL command
> c503672abe13 usb: dwc3: gadget: Resume pending requests after CLEAR_STALL
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

