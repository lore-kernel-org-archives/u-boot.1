Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5641C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AFE280AAB;
	Mon, 27 Jul 2026 09:14:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9rvI1h_tHB9I; Mon, 27 Jul 2026 09:14:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B9D0809F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143668;
	bh=JlDe7Q6WeO42J/d386W/PUPTKvmxxPhepY26LAXEvow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kaeI7JVJ9XQt6qV2Zc3d9SkwX8M5/0wP4XKrrB6cpgaQ7AKGWz2KWxHaytRbZFfvi
	 Ty3ocLDkVZC6Mhk6uRqv+NUqPYx1kkhhCvOPuHusCcYRlw3qPm8ukMHmJw5sl5oEfG
	 VmD/PB7TwDN8XYMXymLpt4X8Hsf08/Xz4ye0PI35WAHYaFFENSMFA21gHl5RFdD+3F
	 wN4PUf6pkwwrdE2GOMlwNnaLYOnPICTPkdBu0egFmHUvuiYYG7m5ItN270f0n06Sw9
	 ssomGvZCoBoozn2Bs9Ct0L18FBRsnxXxr+E82QROFcFg+cI5wW84SUnNxl45VcOBXe
	 R5N9n/KE3FjLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B9D0809F8;
	Mon, 27 Jul 2026 09:14:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CCE5357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83519400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ottYsI5ZMfH1 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:14:25 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4438F4005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4438F4005F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4438F4005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:14:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA52284671; Mon, 27 Jul 2026 11:14:23 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A1BD82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:14:21 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 915D860A65;
 Mon, 27 Jul 2026 09:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980911F000E9;
 Mon, 27 Jul 2026 09:14:19 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 24/75] usb: dwc3: import from kernel v5.0
In-Reply-To: <20260716134305.614278-25-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-25-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:14:17 +0200
Message-ID: <87bjbs4wwm.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143660;
 bh=JlDe7Q6WeO42J/d386W/PUPTKvmxxPhepY26LAXEvow=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=n7mxdyvD/IuD4GUN/Z7UA7GX8sHpYCf4lcsTz+2FYgqoiungtxjsXjhkXorSjy44P
 j1Kfhzn4TQEK1lbv6Z0N1lGUWHF1HYf52wu5AuB8oc3C9g40InaauwlZfxELaqOn0N
 R3BExtVXZTOfP07C8w5IsTKZUQ01aSEjbRPwySenKoD+wD0LEhJGdmKiyMIzTQ5EBb
 EzafHtVK3BGU8jEstNbtGZTnujE0oVuiO9JgsBRZ/JCV9OKBgW1MLYqW+ISroz4ERC
 gyLwIowPpbLG7q9/HufZoBWgp4wamfPFzFAFbTLJ6TmRhbxWgZXjDWpDra1uyb/gdH
 r/e6H+ySjDV5g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=n7mxdyvD
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="n7mxdyvD"; 
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
> Sync Linux kernel dwc3 changes from v4.20 to v5.0.
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
> List of commits: git log --oneline v4.20..v5.0
> Commits imported:
> 512e6fb589bc usb: dwc3: exynos: Fix error handling of clk_prepare_enable
> 1e19cdc80602 usb: dwc3: gadget: Handle 0 xfer length for OUT EP
> 88b1bb1f3b88 usb: dwc3: gadget: Fix the uninitialized link_state when udc starts
> bd6742249b9c usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup
> 01c10880d242 usb: dwc3: gadget: synchronize_irq dwc irq in suspend
> b6061b1e566d PCI: Move Synopsys HAPS platform device IDs
> 244add8ebfb2 usb: dwc3: gadget: Disable CSP for stream OUT ep
> 3004cfd62049 Revert "usb: dwc3: pci: Use devm functions to get the phy GPIOs"
> 54d48183d21e usb: dwc3: trace: add missing break statement to make compiler happy
> 6abfa0f5bb7c usb: dwc3: gadget: Report isoc transfer frame number
> b7a4fbe2300a usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
> 26d62b4d10ad usb: dwc3: don't issue no-op trb for stream capable endpoints
> a7351807bd8b usb: dwc3: update stream id in depcmd
> d53701067f04 usb: dwc3: gadget: check if dep->frame_number is still valid
> 3451f6affaef usb: dwc3: gadget: remove unnecessary dev_info()
> 1517265228b4 usb: dwc3: trace: log ep commands in hex
> 25abad6a0584 usb: dwc3: gadget: return errors from __dwc3_gadget_start_isoc()
> fec9095bdef4 usb: dwc3: gadget: remove wait_end_transfer
> d4f1afe5e896 usb: dwc3: gadget: move requests to cancelled_list
> d5443bbf5fc8 usb: dwc3: gadget: introduce cancelled_list
> 7746a8dfb3f9 usb: dwc3: gadget: extract dwc3_gadget_ep_skip_trbs()
> c3acd5901414 usb: dwc3: gadget: use num_trbs when skipping TRBs on ->dequeue()
> 09fe1f8d7e2f usb: dwc3: gadget: track number of TRBs per request
> 1a22ec643580 usb: dwc3: gadget: combine unaligned and zero flags
> d92021f66063 usb: dwc3: Add workaround for isoc start transfer failure
> 475d8e0197f1 usb: dwc3: Track DWC_usb31 VERSIONTYPE
> 89a9cc47513e usb: dwc3: Set default mode for DWC_usb3 v3.30a and higher
> 268784ba14a7 usb: dwc3: drd: Add support for DR detection through extcon
> 85383756ae34 usb: dwc3: drd: Switch to device property for 'extcon' handling
> 408d3ba006af usb: dwc3: don't log probe deferrals; but do log other error codes
> 022a0208c0ff usb: dwc3: Support option to disable USB2 LPM
> eafeacf11964 usb: dwc3: Set GUSB2PHYCFG.ENBLSLPM
> d102444cac15 usb: dwc3: debugfs: Print/set link state for peripheral mode
> 0d36dede4578 usb: dwc3: debugfs: Properly print/set link state for HS
> 62ba09d6bb63 usb: dwc3: debugfs: Dump internal LSP and ep registers
> 0f874f79dc81 usb: dwc3: debugfs: Print eps Tx/RxFIFO in bytes
> 2c85a1817e4b usb: dwc3: debugfs: Properly name Tx/RxFIFO
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

