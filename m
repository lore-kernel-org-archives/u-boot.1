Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612ABC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23CA440426;
	Mon, 27 Jul 2026 09:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEbhNVfZc9xM; Mon, 27 Jul 2026 09:11:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 555AE40540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143496;
	bh=nkPwI+TcYx0Wmcj+/+e9109RS5Rr9O2aL7SlXVTEPPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JL2Dzw5d7V5DPfXoWsd5ZZaV7Q9CDeqOCZNautlRwy5ZtWLbGk34etu4USzi/jwde
	 2WbAGR/h7gi7E1svPXjenen/9oiqAgyH43lOa0542x9V+QovS6K/jIF1qme20yCrQ9
	 1FSTTARSVT/l1OUmqAVoEDeLzhsinMLQeEZO29RQL2JhaFUEqBxkJjv06w4hZHGAI+
	 iGo6gKqF2jN33uEcVWXdRafI7DxaNN1lXcMeDg145qtnasdfm81PAI7QCjHDRcQZdV
	 5dBi2G/9yvb8QyWWEwEu/0MbePjKL/0wBQ4tlEb/2AF202yHw0O6wc4Z7mUTDmBFS/
	 sUad2LyVNFL8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 555AE40540;
	Mon, 27 Jul 2026 09:11:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D43742A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3946E40540
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:11:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0U3Xm8nZ9wCA for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:11:33 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E4D8B40426
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4D8B40426
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4D8B40426
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:11:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B6F84671; Mon, 27 Jul 2026 11:11:31 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B7982991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:11:28 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84598601DE;
 Mon, 27 Jul 2026 09:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897281F000E9;
 Mon, 27 Jul 2026 09:11:26 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 21/75] usb: dwc3: import from kernel v4.18
In-Reply-To: <20260716134305.614278-22-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-22-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:11:24 +0200
Message-ID: <87ldaw4x1f.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143487;
 bh=nkPwI+TcYx0Wmcj+/+e9109RS5Rr9O2aL7SlXVTEPPM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=SwEswsHR73PRf23Sn13iN2bof/lkA+YMwUdbBBr1R5sSxYfc7HR5skcNBMSGNFuxL
 72Zi41W8YIa8CRXwwxePBasOxtRcyOV0hDzd8u+ETqBn7LCKkLLjRFBzBf2IyBRoZj
 6yiVoG+IjjOmC3rEeDPzD4tx6M/9wJ7G6lzNI720LI8fQsxbHiQvucc1oL7pDSra1Y
 xQuKT0XbEOhwNIkRpH2kUorzxUmvqcMNSdI+I+kWLIj7p/wT+Fl1ohzbpeelniSrVC
 U+/A7L47smRj9soyBaNIsMEuc7n0omvhruG6X9dc1TpoJxs5M5+PvYqKokS6vzstO4
 fQQxdQV7XQpsw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SwEswsHR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SwEswsHR"; 
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
> Sync Linux kernel dwc3 changes from v4.17 to v4.18.
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
> List of commits: git log --oneline v4.17..v4.18
> Commits imported:
> 9566a7c72f4f usb: dwc3: gadget: remove redundant variable maxpacket
> 9925e6ebe5c2 usb: dwc3: qcom: mark PM functions as __maybe_unused
> 93ef2dc0c4f7 usb: dwc3: Fix error return code in dwc3_qcom_probe()
> 615277779f41 usb: dwc3: Only call clk_bulk_get() on devicetree instantiated devices
> 896e518883f1 usb: dwc3: of-simple: fix use-after-free on remove
> 00908693c481 usb: dwc3: pci: add support for Intel IceLake
> 535c8dc5c480 USB: dwc3: no need to check return value of debugfs_create functions
> 3bea1cfcff11 usb: dwc3: Remove DEBUG define from Qualcomm DWC3 glue driver
> 05645366f389 usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue
> 691025107eb7 usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static
> edbbfe19444e usb: dwc3: dwc3_get_extcon() can be static
> 31a2f5a7e136 usb: dwc3: gadget: init req->{direction,epnum} from alloc_request()
> d7ca7e1896b2 usb: dwc3: gadget: initialize transfer index from send_gadget_ep_cmd()
> 4439661d64f5 usb: dwc3: gadget: assign resource_index inside get_transfer_index()
> f62afb4929a8 usb: dwc3: gadget: always start isochronous aligned to dep->interval
> d513320f1fd0 usb: dwc3: gadget: don't issue End Transfer if we have started reqs
> e1d542f712e1 usb: dwc3: debug: decode uFrame from event too
> 42626919efab usb: dwc3: gadget: move dwc3_calc_trbs_left() in place of prototype
> 20d1d43fa09a usb: dwc3: gadget: move set_xfer_resource() in place of prototype
> b07c2db83f92 usb: dwc3: gadget: remove a few more dwc arguments
> a2d23f08038e usb: dwc3: gadget: combine modify & restore into single argument
> 8f1c99cd24b0 usb: dwc3: gadget: refactor dwc3_gadget_init_endpoints()
> f38e35dd84e2 usb: dwc3: gadget: split dwc3_gadget_ep_cleanup_completed_requests()
> 6d9d22dac114 usb: dwc3: gadget: get rid of the length variable
> fee73e6144d8 usb: dwc3: gadget: reduce scope of ret variable
> 6afbdb57732b usb: dwc3: gadget: one declaration per line
> e0c42ce590fe usb: dwc3: gadget: simplify IOC handling
> d80fe1b6e34d usb: dwc3: gadget: simplify short packet event
> b27972b508d1 usb: dwc3: trace: print out event status too
> 8b3b7b66c0e6 usb: dwc3: gadget: simplify unaligned and zlp handling
> cf35fc336e66 usb: dwc3: gadget: remove unnecessary 'chain' variable
> 021595963a3c usb: dwc3: gadget: remove PENDING handling from cleanup_completed
> d36929538f8b usb: dwc3: gadget: split scatterlist and linear handlers
> d5044a04b529 usb: dwc3: gadget: simplify isoc case on cleanup_completed_requests
> fe990cea8ed5 usb: dwc3: gadget: simplify queueing of isoc transfers
> 4d588a145b3e usb: dwc3: gadget: remove duplicated missed isoc handling
> 6d8a019614f3 usb: dwc3: gadget: check for Missed Isoc from event status
> 58f0218a271d usb: dwc3: gadget: remove unnecessary 'ioc' variable
> 12a3a4ada816 usb: dwc3: gadget: make cleanup_completed_requests() return nothing
> 5f2e7975f0df usb: dwc3: gadget: remove DWC3_EP_BUSY flag
> 1912cbc60f44 usb: dwc3: gadget: start removing BUSY flag
> ee3638b897b9 usb: dwc3: gadget: update dep->frame_number from XferInprogress too
> 5828cada9908 usb: dwc3: gadget: always use frame number from XferNotReady
> 8f608e8ab628 usb: dwc3: gadget: remove unnecessary 'dwc' parameter
> 320338651d33 usb: dwc3: gadget: move handler closer to calling site
> ed27442e5093 usb: dwc3: gadget: rename dwc3_gadget_start_isoc()
> a24a6ab1493a usb: dwc3: gadget: remove some pointless checks
> 0bd0f6d201eb usb: dwc3: gadget: remove allocated/queued request tracking
> 66f5dd5a0379 usb: dwc3: gadget: rename done_trbs and done_reqs
> a861282f5037 usb: dwc3: gadget: don't kick transfer all the time
> fbea935accf4 usb: dwc3: gadget: rename dwc3_endpoint_transfer_complete()
> 742a4fff5f29 usb: dwc3: gadget: XferComplete only for EP0
> 38408464aa76 usb: dwc3: gadget: XferNotReady is Isoc-only
> 52fcc0bead0f usb: dwc3: gadget: pre-issue Start Transfer for Interrupt EPs too
> c96e6725db9d usb: dwc3: gadget: Correct the logic for queuing sgs
> a31e63b608ff usb: dwc3: gadget: Correct handling of scattergather lists
> 5f0b74e54890 USB: dwc3: get extcon device by OF graph bindings
> fe8abf332b8f usb: dwc3: support clocks and resets for DWC3 core
> 44feb8e6ea2d usb: dwc3: use local copy of resource to fix-up register offset
> bcb128777af5 usb: dwc3: core: Suspend PHYs on runtime suspend in host mode
> a4333c3a6ba9 usb: dwc3: Add Qualcomm DWC3 glue driver
> e362098f0e12 usb: dwc3: of-simple: Add compatible for Allwinner H6 platform
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

