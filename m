Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A11C5321C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B45AF4068F;
	Mon, 27 Jul 2026 09:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VyBdAD61BJff; Mon, 27 Jul 2026 09:00:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B72A740645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142813;
	bh=MAFcyr/lmfx28crsh63owkKD1Q/oTZWsicYfYAMjgqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZuFj6IrzWcfvS1pBILWh169uXGFOnZpwIfDDdafYisMMCnLNGmBINHJc//iJOyJch
	 jvNdSxaIYDrLhvaG5OJCMyk4rTS0yjc5feK900h314C27fxOTx2E+Ni9D6P1RRhZye
	 JtKz9Lu0tWgzA5keTKWkP42ntjLH57hEzHmtbF0BPTPuQ+IyORW1tIJ7FTbJkawEYu
	 H/YUNbU73I3kDD81isGS37hVecMfpWXZkCnRNr3aUGgem4kRb1xzd0zqEsFB5UHboK
	 pbjVbjt/Sj74uy90W59ZVNh+IWNL6Th+JLr6fOZ+qd61+fa4G8fx1ZISaFAISblxDt
	 ssmysjkNr9J5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B72A740645;
	Mon, 27 Jul 2026 09:00:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 793DD39E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B7CC60627
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJ0mo_9BUupB for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:00:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0B314605DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B314605DD
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B314605DD
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:00:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1F784671; Mon, 27 Jul 2026 11:00:09 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B77C282991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:00:06 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71984601DE;
 Mon, 27 Jul 2026 09:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A865A1F000E9;
 Mon, 27 Jul 2026 09:00:04 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 13/75] usb: dwc3: import from kernel v4.10
In-Reply-To: <20260716134305.614278-14-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-14-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:00:01 +0200
Message-ID: <87a4rc6c4u.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142805;
 bh=MAFcyr/lmfx28crsh63owkKD1Q/oTZWsicYfYAMjgqY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=MvNZ+Z2ZZ35U7EIXicXuxMJdtDRb4B+P7Nc8FCin8UG5oe28qcVpcNEf97IRfDWNC
 /Vjv5nA/rFTfiGPCfZm7pWm46yaxGufAOZ9lROrK4eN0+ygvt+vCeBqHHwXJrsTVQ1
 o3o3qWbK1nvyIMU8j9He19D0CkPKfiigUJ+4SMhV9oTKOCuhsx4U7WWcEwudLompL4
 e5a2brRpncPS6+o3iEDcNYiegO2HHVbotcBuw5NPJA3DmgG98FmROjbVu32oels3FH
 h8/jBNNf+wP7Gi+DaQOt7LfF6hHZZirfeird/Cu9FZQEmiErXt7Abe9/I0mPOj3JYP
 SUYznY+eYdu/A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=MvNZ+Z2Z
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="MvNZ+Z2Z"; 
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
> Sync Linux kernel dwc3 changes from v4.9 to v4.10.
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
> List of commits: git log --oneline v4.9..v4.10
> Commits imported:
> 8ae584d1951f usb: dwc3: exynos fix axius clock error path to do cleanup
> 9418ee15f718 usb: dwc3: gadget: Fix full speed mode
> 8f8983a56836 usb: dwc3: pci: add Intel Gemini Lake PCI ID
> 0eae2fde164c usb: dwc3: pci: Add "linux,sysdev_is_parent" property
> 12a7f17fac5b usb: dwc3: omap: fix race of pm runtime with irq handler in probe
> d7fd41c6dbcc usb: dwc3: skip interrupt when ep disabled
> 51c1685d9562 usb: dwc3: pci: Fix dr_mode misspelling
> e71d363d9c61 usb: dwc3: core: avoid Overflow events
> d62145929992 usb: dwc3: gadget: always unmap EP0 requests
> 19ec31230eb3 usb: dwc3: ep0: explicitly call dwc3_ep0_prepare_one_trb()
> 7931ec86c1b7 usb: dwc3: ep0: add dwc3_ep0_prepare_one_trb()
> 9165dabb2500 treewide: Fix printk() message errors
> 8c9f2de459c7 usb: dwc3: Do not set dma coherent mask
> d64ff406e51e usb: dwc3: use bus->sysdev for DMA configuration
> 1c404b51a05d usb: dwc3: ep0: avoid empty-body warning
> 36daf3aa399c usb: dwc3: pci: avoid build warning
> 28632b44d129 usb: dwc3: Workaround for irq mask issue
> cf40b86b6ef6 usb: dwc3: Implement interrupt moderation
> 65aca3205046 usb: dwc3: gadget: clear events in top-half handler
> ebbb2d59398f usb: dwc3: gadget: use evt->cache for processing events
> caefe6c7be47 usb: dwc3: gadget: use evt->length as we should
> d9fa4c63f766 usb: dwc3: core: add a event buffer cache
> a22f884b2665 usb: dwc3: core: remove dwc3_soft_reset()
> 7ac51a12ea11 usb: dwc3: Add a function to check properties
> a987a906e95c usb: dwc3: Add a check for the DWC_usb3 core
> 5fb6fdaf38f7 usb: dwc3: gadget: Fix dead code writing GCTL.RAMCLKSEL
> 39ebb05ca83d usb: dwc3: gadget: Remove descriptor arguments to ep_enable
> f2694a93e0df usb: dwc3: warn on once when no trbs
> 87aba10639b0 usb: dwc3: isoc clean DWC3_EP_PENDING_REQUEST flag
> e3aee48692ac usb: dwc3: fix post-increment
> ce3fc8b32994 usb: dwc3: clean TRB if STARTTRANSFER fail
> 8ab89da4c281 usb: dwc3: decrement queued_requests
> 5eb30cedced6 usb: dwc3: trace: purge dwc3_trace()
> 2870e5013e19 usb: dwc3: trace: add a tracepoint for ep enable/disable
> 9cecca75b5a0 usb: dwc3: pci: call _DSM for suspend/resume
> 0f817ae696b0 usb: dwc3: pci: add a private driver structure
> ff377ae47de5 usb: dwc3: gadget: always kick if num_pending_sgs > 0
> 7282c4ef0b66 usb: dwc3: gadget: stop touching HWO TRBs
> d86c5a676e5b usb: dwc3: gadget: always try to prepare on started_list first
> e62c5bc57367 usb: dwc3: gadget: tracking per-TRB remaining bytes
> 6cb2e4e3de10 usb: dwc3: gadget: cope with XferNotReady before usb_ep_queue()
> 76a638f8ac0d usb: dwc3: gadget: wait for End Transfer to complete
> 785c91f8ae4d usb: dwc3: cleanup with list_first_entry_or_null()
> bb0147364850 usb: dwc3: gadget: don't clear RUN/STOP when it's invalid to do so
> cf68923055cb usb: dwc3: gadget: purge dwc3_stop_active_transfers()
> c5ac6116db35 usb: dwc3: core: add dwc3_get_properties()
> 3b2733227f40 usb: dwc3: core: remove unnecessary alignment
> 941f918ecfa7 usb: dwc3: core: introduce dwc3_core_setup_global_control()
> 0759956f8ae7 usb: dwc3: core: introduce dwc3_core_is_valid()
> 0bb39ca1ad87 usb: dwc3: Add support for device L1 exit
> f9d2f9228cde usb: dwc3: remove unused struct member dwc3->mem
> 0a695d4c75ff usb: dwc3: gadget: never ever kill the machine
> c9508c8c50f9 usb: dwc3: gadget: only interrupt on short if short_not_ok is set
> 58f29034b4c4 usb: dwc3: gadget: CSP is only valid for OUT endpoints
> b9bd138e06b9 usb: dwc3: gadget: remove unused 'first_trb_index'
> 39e07ffb1c3d usb: dwc3: ep0: simplify dwc3_ep0_handle_feature()
> 6d729a55cc0f usb: dwc3: host: extract dwc3_host_get_irq()
> 6db3812e09db usb: dwc3: gadget: extract dwc3_gadget_get_irq()
> 4dd5a69e495b usb: dwc3: trace: add a proper tracepoint for reg accessors
> ba1773fb7de9 usb: dwc3: Kconfig: allow all glues to build if COMPILE_TEST
> 57b14da56227 usb: dwc3: don't compile dwc3_trace() unless CONFIG_FTRACE=y
> a97ea994605e usb: dwc3: gadget: offset Start Transfer latency for bulk EPs
> fa8d965d736b usb: dwc3: trace: pretty print high-bandwidth transfers too
> 43c96be1c46e usb: dwc3: trace: print out ep0state also from XferComplete
> cdd72ac20b4a usb: dwc3: debug: move dwc3_ep0_state_string() to debug.h
> 8566cd1adf29 usb: dwc3: gadget: remove redundant trace prints
> 45a2af2f2b5a usb: dwc3: debug: decode control endpoint phase too
> 799e9dc82968 usb: dwc3: gadget: conditionally disable Link State change events
> 15b8d9332b92 usb: dwc3: gadget: giveback request if we can't kick it
> 8897a761c371 usb: dwc3: gadget: make use of No Response Update Transfer
> 5999914f227b usb: dwc3: gadget: properly check ep cmd
> 6b9018d4c1e5 usb: dwc3: gadget: set PCM1 field of isochronous-first TRBs
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

