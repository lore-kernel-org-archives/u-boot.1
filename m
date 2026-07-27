Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBE9C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67BF840539;
	Mon, 27 Jul 2026 08:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1nKc2Jdr2NK; Mon, 27 Jul 2026 08:58:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 475A2405DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142701;
	bh=+XXEHbDDiRH2j4k3Sa0cQKhw41O2SCOdnROeFaHSibI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q1XbXkOaBwSU/+GSz+ccqK/8AR4jpk1gigZyc0Tq4x2c3qJkJVj/kuEx0IAW1CmWe
	 KjtunODJ5BJsZY+3Z1wfWRriWMGyiLOgtROo3lmc6yM/DOBsWlOSoxbX7VEdnhpl59
	 naRbIzM+ZNABRq6xFddpsxNnbni4hjlg8zlBaAScec9FYo0PMjfSct9OL5CZph4MKc
	 xY73skJZDX9JL6m5HrocqLWqtk48HReEUgxnJxMyFJb7BDDRAKwjoz0pSwvr5T9DJe
	 NxYL1znkzqNUZb9taSGSkJKtQCMSB/0/MSzcbM3mzBq+D0EDBw+qzGGzttR/Bd656e
	 hz5DgqSw6SxJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 475A2405DC;
	Mon, 27 Jul 2026 08:58:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F31C45B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 917C54005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EC7-HHXB1D61 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:58:18 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 013D6400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 013D6400D8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 013D6400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:58:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529C084671; Mon, 27 Jul 2026 10:58:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3A982991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:58:13 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 819D84122A;
 Mon, 27 Jul 2026 08:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F31F000E9;
 Mon, 27 Jul 2026 08:58:11 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 11/75] usb: dwc3: import from kernel v4.8
In-Reply-To: <20260716134305.614278-12-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-12-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:58:09 +0200
Message-ID: <87fr146c7y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142692;
 bh=+XXEHbDDiRH2j4k3Sa0cQKhw41O2SCOdnROeFaHSibI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=TCl3XlasEkDOu3/nhJJSFMFy5wobxeTeTyM31rcOqNYmfFYQFnJvP53NXoYnYQ/XC
 fg0iRXA18HLieN4T+C1naUPGZj7FFHiiAkm5XbLlN958MJTcFpxZfjPigzr3cq5Fiw
 9d5Ky58lWzUvnJxe1VgHZWauXd5k2z96EfF26zRZWJI1Ki6guI+k8HZ+rFGXTCm9mU
 11+bhgcwZ0TIA3j4JwchVjV0NOIESpC6JNmMH1lQ2p5EeAnRtamIomaz2odrm1iTzR
 zJiPr1prmXYH4Fxh7Q4fdkqh+iSuiF3d7FjrROzmeSsty5bbL5xHR8K7utdYFSp+YM
 EzQ/M5StzPuBA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=TCl3Xlas
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="TCl3Xlas"; 
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
> Sync Linux kernel dwc3 changes from v4.7 to v4.8.
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
> List of commits: git log --oneline v4.7..v4.8
> Commits imported:
> 696118c016dd usb: dwc3: pci: fix build warning on !PM_SLEEP
> 9d7aba7786b6 Revert "usb: dwc3: gadget: always decrement by 1"
> 6f8245b4e37c usb: dwc3: gadget: always decrement by 1
> 696fe69d7e63 usb: dwc3: debug: fix ep name on trace output
> d6011f6fc21b usb: dwc3: gadget: don't rely on jiffies while holding spinlock
> b74c2d875baa usb: dwc3: core: allow device to runtime_suspend several times
> f6c274e11e3b usb: dwc3: pci: runtime_resume child device
> a0ad85ae866f usb: dwc3: gadget: stop processing on HWO set
> 79d17482a409 usb: dwc3: don't set last bit for ISOC endpoints
> 4c4f106c032f usb: dwc3: fix missing platform_set_drvdata() in dwc3_of_simple_probe()
> 4491ed5042f0 usb: dwc3: pci: add Intel Kabylake PCI ID
> 7c705dfe2ebe usb: dwc3: gadget: always cleanup all TRBs
> e5b36ae2f851 usb: dwc3: gadget: fix for short pkts during chained xfers
> c7de57347183 usb: dwc3: gadget: increment request->actual once
> 322832f2f19e usb: dwc3: host: Fix broken XHCI host
> 95b57df45062 usb: dwc3: host: use build-in property instead of platform data
> 72704f876f50 dwc3: gadget: Implement the suspend entry event handler
> 9522def40065 usb: dwc3: core: cleanup IRQ resources
> da1410be21bf usb: dwc3: gadget: Add the suspend state checking when stopping gadget
> 0e146028eebf usb: dwc3: gadget: issue ENDTRANSFER conditional on resource_index
> 328082376aea usb: dwc3: fix runtime PM in error path
> b6d4e16e8313 usb: dwc3: gadget: simplify run_stop() break condition
> f2df679b6c55 usb: dwc3: gadget: avoid while(1) in run_stop()
> d807bdd02845 usb: dwc3: gadget: remove udelay() from run_stop()
> 5f82279a0c76 usb: dwc3: core: fixup dr_mode fallback selection
> e6fe66fe08cd usb: dwc3: pci: add dr-mode for Intel dwc3
> 21e64bf20df5 usb: dwc3: gadget: rename 'ignore' argument to 'modify'
> d6dc2e76a860 usb: dwc3: gadget: decrement trbs_left for each sg entry
> ba62c09d5cc2 usb: dwc3: gadget: start Bulk endpoints more frequently
> 13fa2e69b1dd usb: dwc3: gadget: disable XFER_NOT_READY
> 55a0237f8f47 usb: dwc3: gadget: use allocated/queued reqs for LST bit
> 69450c4dc164 usb: dwc3: gadget: halt and stop based HWO bit
> 68d34c8a744d usb: dwc3: gadget: keep track of allocated and queued reqs
> b6b1c6db4c7f usb: dwc3: gadget: update transfer needs transfer resource
> d18e65470a4d usb: dwc3: remove handling of platform data
> cf48305de0c6 usb: dwc3: pci: use build-in properties instead of platform data
> 60cfb37ac9bc usb: dwc3: remove trailing newline from dwc3_trace
> d2728fb3e01f usb: dwc3: omap: Pass VBUS and ID events transparently
> 9ab330bf4dfd usb: dwc3: omap: Don't set POWERPRESENT
> 12da8eae208d usb: dwc3: omap: Mark the interrupt handler as shared
> 3f586c92d877 usb: dwc3: omap: use request_threaded_irq()
> 475c8beb35e1 usb: dwc3: add DWC3_GUCTL1 reg for debug
> e77c561432bc usb: dwc3: Fix DWC3_USB31_REVISION_110A definition
> 2da9ad761e70 usb: dwc3: Use the correct speed macros for DSTS/DCFG
> 3de2685f0c39 usb: dwc3: gadget: Fix truncated cast issue
> 361572b5f7a9 usb: dwc3: gadget: Handle TRB index 0 when full or empty
> 7d0a038b130c usb: dwc3: gadget: Account for link TRB in TRBs left
> 32db3d9437b6 usb: dwc3: gadget: Account for max size in TRB space
> 89bc856e5a74 usb: dwc3: gadget: Don't prepare TRBs if no space
> 0d25744ad107 usb: dwc3: gadget: Initialize the TRB ring
> dca0119c3ab6 usb: dwc3: gadget: Simplify skipping of link TRBs
> 96bedb637a1e usb: dwc3: Endianness issue on dwc3_log_ctrl
> d07fa665c79d usb: dwc3: gadget: Fix usage of bitwise operator
> 501058edebf9 usb: dwc3: ep0: Use the correct type for SET_SEL data
> 958b9fa7f8cf usb: dwc3: ep0: Fix endianness of wIndex passed to dwc3_wIndex_to_dep
> 71f7e7027028 usb: dwc3: gadget: improve gcmd trace
> 88811f7b722c usb: dwc3: gadget: remove udelay() from generic cmd
> 0fe886cdb07a usb: dwc3: gadget: single return point on generic commands
> 0933df159c5c usb: dwc3: trace: print ep cmd status with a single trace
> f6bb225bb3ca usb: dwc3: gadget: loop while (timeout)
> ba1598410eff usb: dwc3: gadget: fix trace output when command fails
> f75cacc468ed usb: dwc3: trace: fully decode IRQ events
> 7ab373aadbd0 usb: dwc3: gadget: no more tracking endpoint type with its name
> 22f2c619a116 usb: dwc3: trace: pretty-print TRB's ctrl field
> 74674cbf858f usb: dwc3: gadget: add a per-endpoint request queue lock
> e9af9229098d usb: dwc3: pci: add Power Management dummy hooks
> fc8bb91bc83e usb: dwc3: implement runtime PM
> 4cb4221764ef usb: dwc3: gadget: fix for possible endpoint disable race
> 9cad39fe4e4a usb: dwc3: fix for the isoc transfer EP_BUSY flag
> ab2a92e7a608 usb: dwc3: gadget: only resume USB2 PHY in <=HIGHSPEED
> 3f308d17d7ab usb: dwc3: gadget: hold gadget IRQ in dwc->irq_gadget
> 51f5d49ad6f0 usb: dwc3: core: simplify suspend/resume operations
> c499ff71ff2a usb: dwc3: core: re-factor init and exit paths
> bcdb3272e889 usb: dwc3: core: move fladj to dwc3 structure
> 2eb8801650b3 usb: dwc3: gadget: add a pointer to endpoint registers
> 2cd4718d0bbe usb: dwc3: gadget: pass dep as argument to endpoint command
> 4e99472bc10b usb: dwc3: gadget: initialize NUMP based on RxFIFO Size
> 5ee85d890f8d usb: dwc3: gadget: split __dwc3_gadget_kick_transfer()
> 6b74289937f6 usb: dwc3: gadget: return 0 if we try to Wakeup in superspeed
> b43bba96b903 usb: dwc3: gadget: remove udelay(1) when sending ep cmds
> 6aff48329595 usb: dwc3: gadget: rely on sg_is_last() and list_is_last()
> 4fae2e3e1515 usb: dwc3: gadget: simplify __dwc3_gadget_kick_transfer()
> c4233573f6ee usb: dwc3: gadget: prepare TRBs on update transfers too
> 7f370ed0cfe9 usb: dwc3: core: get rid of DWC3_PM_OPS macro
> 9f8a67b65a49 usb: dwc3: gadget: fix gadget suspend/resume
> d7be295243bb usb: dwc3: gadget: re-factor ->udc_start and ->udc_stop
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

