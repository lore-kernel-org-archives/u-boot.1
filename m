Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F63C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:02:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58CCB80D16;
	Mon, 27 Jul 2026 09:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id opONg_8t1fsm; Mon, 27 Jul 2026 09:02:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DBA780CDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142977;
	bh=d2UMoQsUK2hfB3PbLvtje2V6tixhXGzgAtaaJndtAPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dzSRAy2fe+rudhwVxLQmWT9Ew5A4ul/O9HXeIiXloapWkm5odpUgHeWamFSm+yRNg
	 OwDwda87sRFgEtJ0Tnz9azv8VPaXBslaXm7qS+G9JMf6ctiMkgwtCKTkFHa867s3BQ
	 zquFvhMVFitPuCA4bYwDseFo0gsfJEZ7QLObml+YR3T4D0WJcRRAB9Ma9K/cWNnzqv
	 CiJ1Cb5xa8N+jOMnUS9yjGGM8rH50uuWGOvRjZ8HMUF5t+LtmtjdSrIawrC+SuxYbE
	 04uPMOPFytm/VoNcQjzBqVmI/hR/GM//bpB9y+TLP8sgAywy9kLIk2FW/kshnT8Bsx
	 kmWrOOjOcD1uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DBA780CDF;
	Mon, 27 Jul 2026 09:02:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A2A183B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9468B80D10
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9ys05mHd-uW for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:02:55 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6418980CBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6418980CBC
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6418980CBC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:02:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAAB884671; Mon, 27 Jul 2026 11:02:53 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704A982991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:02:51 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E33D643DBC;
 Mon, 27 Jul 2026 09:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C461F00A3A;
 Mon, 27 Jul 2026 09:02:48 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 16/75] usb: dwc3: import from kernel v4.13
In-Reply-To: <20260716134305.614278-17-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-17-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:02:47 +0200
Message-ID: <871pco6c08.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142969;
 bh=d2UMoQsUK2hfB3PbLvtje2V6tixhXGzgAtaaJndtAPg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=OLvSZmDyy6/fKxRm8b+12GXVfx8sEr31kxrYQeByghZhe8JX71pZccGzdkHo5yWqA
 9qUpWuJefdhFI6C4l+858fEeuhgReDZdn/6W6YGG5dxEuhbrdlupTkmxdKVSsVeFlk
 EF1jS0s5gQx4Oa6tZDcwy/EsKAChWvTfBHKkJGKZlM5SnR/BgqQd91SYxmqlF4UeCy
 2yOfccWPQAJJRZz6y74w+7BXZROHTPFwcuCPy7I3stmKVvOM/cxnmALQVpstS6r0rU
 LYEsPItJIApUyinKpt1gjPfAs/3qJVjAiAz31+FZk5gSx7dwZCQDvdJIS+4srK6tW/
 fuh9+6GaBmXUA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OLvSZmDy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="OLvSZmDy"; 
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
> Sync Linux kernel dwc3 changes from v4.12 to v4.13.
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
> List of commits: git log --oneline v4.12..v4.13
> Commits imported:
> 40d829fb2ec6 usb: dwc3: gadget: Correct ISOC DATA PIDs for short packets
> 4a71fcb8ac5f usb: dwc3: gadget: only unmap requests from DMA if mapped
> ee249b455494 usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq
> 541768b08a40 usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys
> de3ef1eb1cd0 PM / core: Drop run_wake flag from struct dev_pm_info
> ece7af5f787e usb: dwc3: exynos: Handle return value of clk_prepare_enable
> 46b780d46bcc usb: dwc3: gadget: increase readability of dwc3_gadget_init_endpoints()
> 958d1a4c40dd usb: dwc3: core: program PHY for proper DRD modes
> f54edb539c11 usb: dwc3: core: initialize ULPI before trying to get the PHY
> e0082698b689 usb: dwc3: ulpi: conditionally resume ULPI PHY
> 9b0a1f95c4b4 usb: dwc3: ep0: make sure wValue is 0 on GetStatus()
> 7d8d0639565f usb: dwc3: gadget: implement ->udc_set_speed()
> 94116f8126de ACPI: Switch to use generic guid_t in acpi_evaluate_dsm()
> af32423a2d86 usb: dwc3: trace: decode ctrl request
> 3587f36a125f usb: dwc3: debug: remove static char buffer from dwc3_decode_event()
> e42f09b85f20 usb: dwc3: trace: rely on __string() and __assign_str()
> dfc5e80578f2 usb: dwc3: gadget: slight cleanup to dwc3_process_event_entry()
> 436841d53dd7 usb: dwc3: debugfs: slightly improve output of trb_ring
> bfad65ee9be2 usb: dwc3: update documentation
> 04fb365c453e usb: dwc3: replace %p with %pK
> 65db7a0c9816 usb: dwc3: add disable u2mac linestate check quirk
> cdb55b39fab8 usb: dwc3: gadget: lazily map requests for DMA
> 202adafe5a6e usb: dwc3: gadget: don't WARN about lack of TRBs
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

