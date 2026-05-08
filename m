Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624DCCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC2684D11;
	Fri,  8 May 2026 17:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BmAPar4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191C184CFD; Fri,  8 May 2026 17:28:20 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD51B84D11
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bba0dde4f43so316078766b.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254097; cv=none;
 d=google.com; s=arc-20240605;
 b=fKQ6kNYGwFHnk6aJJvPTyl4ZfbrJQ50RQTsSVtLGqFD6C6/YsePWXayIU71qKYdaNa
 wK3tIku4rLCmO94J6EZJ92EIgZ4G5N6je2xnTu7Q0ZyJ+7RJo89K+gMPOjzyFsc9sVDe
 5n9dyb8sRGztxYOHP2GPtioPPQjNp4jSQ64PZR0aDvC2L7psh3d4PV3huNkHtqEb7z3l
 mNb0BFmHv7vj7S9mTHtqOrZEFhceCeKljh0e7GupslAiItvnrkJWO0ZVbi8tPz4O8PCp
 41NwaG0bqdxXB0WnQ8LItJ7/1CcG18jm/MUAnIY7tetHhNQMZG0rlMJBIzYpCPZ6sP9c
 g5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zLotw6EesGHGhp3wBQurpXhfZdRyqj92FpVD14IBYzU=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=GHvM9Obrf8MfOEVArTZhje9PIgEM6Qyv6X42Osea8ieC0b6/XK1gKoJklCTz52rPfC
 HepYSyvs7P/vf0OfRnkh94jt5u7mTBDr5sUhasoFy3XoCp5oz3HBBhD56+P2NYAiPBeN
 gsjwBmHnDgbhith4UJ7hIbNtNGOPeedw73xQ8wFIcTPX5WPlYlmbygatxNVjwOUw8xno
 QBLCj7gzAID7ynYTge0sNRMhnDbeE4vhRdrxIOeUraRdcvY4tSixwjf5uem2v1vY4oV3
 vvrQKwk9cpG0Few/A5SjPy8sh9TLo7HkYb8BwMovmupEUQ/Kt5yMP0qaqRQ631jA3/LV
 6NSg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254097; x=1778858897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zLotw6EesGHGhp3wBQurpXhfZdRyqj92FpVD14IBYzU=;
 b=BmAPar4a6BNEfcqBsWY7ORqSc9YCKBdJAEOwHbswUTF8inqew2nbBfPMDw67SLAlI3
 od8xUFVpaYxYb/5LKFyGSz/JTlQJrgsCvpqfaPqOjUotaNYnWyh5MvO41aVBsbRSYIAi
 KwC68KyOg8/dlUaXNx01CLXAOvSdvUlTlPEQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254097; x=1778858897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLotw6EesGHGhp3wBQurpXhfZdRyqj92FpVD14IBYzU=;
 b=rS9y91RXpMVoZ3/QYJ3+b5NCbuTHBu3gciePEtogJFb7bjiAHHXsTGikG3Qm3/tRY/
 DIG/sslRYWcKnmLaHGZc9aFSljg8N8vHOfZ2yBuMuVaYK+fKClnkqtFmtr6Det9xHzXG
 JpZnTGZDFqssdg97P2Fs5gOxC18gR8DgAF0KzrB4yIDdOIzfzXknaxtewQe3xAHsbSiB
 7cgR9GAmdC5jux1fw+ebBfO+FB70cXossv2maSbbQE7x5968VZFqWDQmE4OBweOHNl0v
 PcYmcpDIVj8DP4BE3vm3xVKf66CuiU9aKluVf3Svc6vr+uGDf1OaGJsB0vAIxTPFMj6m
 avWA==
X-Gm-Message-State: AOJu0YwiQtawQ9+XTgoBwnEYmRDxxKPSvsryASUT8p/BR2h2PwDCb8En
 gHdvNRIcQiBVlLvabhIM8KUOblhjOBq8/lrIKtUOoeCMb3NQ8rOIvBwI6oH3iVcvhXIsaimJpp9
 Ssuxc4yTzg4ThrJrXNGXUHkV5kVBIyGOLqXlwB4fI
X-Gm-Gg: AeBDietawP4wAGmS8PPDw5jMUIBAC9QqS5GxgmQ9rAXEiy2nY3UmLFsiuvXP4H4rNTJ
 Z7R1OwO2mk3v6dMfA9ZQ+zbZnTb+KIDWl3XmQXNCteR2Qfmsls+3I47m7lX0m7n1QDDQtaQuvFL
 X1lb7w49JO1JZO+5fFjIrHclY0f3c9H1/y/vch7s8StbIoeqAVwL1RLDqQOIBCWK4rQn+TqLJX0
 VbMSvKzmLpOqyRWlBgA2iW5jqDch6dpQK9N9xHg1AOPkeEP10Uo1HU0BL71xIruf0U540DtdEAa
 uFEfttirHrLjIQrZ
X-Received: by 2002:a17:907:86ac:b0:ba4:8288:b464 with SMTP id
 a640c23a62f3a-bcaa9f6122dmr204256366b.6.1778254097070; Fri, 08 May 2026
 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-12-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-12-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:28 -0600
X-Gm-Features: AVHnY4LtkcY-hGtsXLcxD5QuKOWSESkmkGC2GJyLQgwYopUJP_FfgM0emeO3-ZU
Message-ID: <CAFLszTjxnH-Uh93nJ4quT5937m=NKJKNB=svApUfpPmJmjGgEA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/64] usb: dwc3: import from kernel v4.8
To: jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v4.8
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
> c318a821b982 Merge 4.7-rc6 into usb-next
> 322832f2f19e usb: dwc3: host: Fix broken XHCI host
> 215db9481814 Merge tag 'usb-for-v4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
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
> bc71c2df45e5 Merge 4.7-rc4 into usb-next
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
>
> drivers/usb/dwc3/core.c          | 389 +++++++++--------
>  drivers/usb/dwc3/core.h          |  59 ++-
>  drivers/usb/dwc3/debug.h         | 140 +++++-
>  drivers/usb/dwc3/ep0.c           |  26 +-
>  drivers/usb/dwc3/gadget.c        | 923 ++++++++++++++++++++++-----------------
>  drivers/usb/dwc3/gadget.h        |   4 +-
>  drivers/usb/dwc3/io.h            |   7 +-
>  drivers/usb/dwc3/platform_data.h |  53 ---
>  8 files changed, 926 insertions(+), 675 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
