Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B44C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFF3540623;
	Mon, 27 Jul 2026 08:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbqtDg_ii7pG; Mon, 27 Jul 2026 08:53:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E7CB405CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142404;
	bh=WrXt6blx8oQo6HckPRcas1LzM/NF3X8WTyj/mvWmk0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4dWOPlJKsCQb9Q9jkA9PNAIiiEkO1U8gpKczbJjrEbgXLxS2PTVhR3+sB1lKlwaj
	 mesZ6jieO/tyg5o0Bpj+e7b1XlpmlffX1vva6EBpHglerHyhJ7LuAOTGZZv6cCMTQ/
	 hyn7oq4CSvLMw/Q2lkKHQltBPYuGU1HxgZG82FF6NaguicBo5Rto6nQ06SDRQynD+6
	 ArYvpwgHFKTqPAruIgciBtGk/OgudnGxKd+jP89NcbELgTr8TEDj8ZQ7HitAmRVi0e
	 O5BV/jKFHmITV0X3sxdtNHT5kaUVW6RfItYf679pWOwfP8OZCBewp1jREthLTHOb2g
	 9paSMVASUwh5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E7CB405CD;
	Mon, 27 Jul 2026 08:53:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E07E345B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D140B80C0D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:53:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dHV_PCick4dn for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:53:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 98B1480BF0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98B1480BF0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98B1480BF0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:53:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 103F0846A3; Mon, 27 Jul 2026 10:53:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C42DA82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:53:17 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86FE24396E;
 Mon, 27 Jul 2026 08:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AE61F000E9;
 Mon, 27 Jul 2026 08:53:15 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 06/75] usb: dwc3: import from kernel v4.3
In-Reply-To: <20260716134305.614278-7-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-7-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:53:14 +0200
Message-ID: <87tspk6cg5.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142396;
 bh=WrXt6blx8oQo6HckPRcas1LzM/NF3X8WTyj/mvWmk0A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=NXCNZMamGCEW9cd9odsyAXOFRyH4mv+POARlet5DMlVgB+PigR/LvR1Qs2Xvi1eZW
 p7GLNqBSNSoSrtIHu74BdeuwVI7BkWlXLGk8Mu1PWCXpex8LR7jlqE09MfAP6u7TVU
 aDXBtun7BG09pvD0oEPYPcT2iJn71OWOCD6MC5c4f3i1M7StlhpS8A3yYbKge62+r6
 g7fd/YAfFUMH9/CoDzXFPRRhWS5CyUULrEvWo7WVt3vo3kdy+XEErBUqOuWLox5iuR
 NSnxL3ptPnSj8z13az3w026rfFqSydPDsArHuhQgfnYGKE8ukTfgwZGYg6ogrPBONW
 1Sof6izvdmycw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NXCNZMam
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="NXCNZMam"; 
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
> Sync Linux kernel dwc3 changes from v4.2 to v4.3.
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
> List of commits: git log --oneline v4.2..v4.3
> Commits imported:
> a66c275b3d5d usb: dwc3: gadget: Fix BUG in RT config
> e2ae0692bf6f usb: dwc3: omap: enable irqs lately
> a474d3b73ba7 usb: dwc3: gadget: add ep capabilities support
> c0bd5456a470 usb: dwc3: ep0: handle non maxpacket aligned transfers > 512
> 2abd9d5fa60f usb: dwc3: ep0: Add chained TRB support
> 368ca113ca0a usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API to take 'chain' parameter
> 8a3442205630 usb: dwc3: ep0: preparation for handling non maxpacket aligned transfers > 512
> 2e5464da4e7d usb: dwc3: ep0: use _roundup_ to calculate the transfer size
> b2fb5b1a0f50 usb: dwc3: ep0: Fix mem corruption on OUT transfers of more than 512 bytes
> aa7399744dd0 usb: dwc3: gadget: defer endpoint name change
> 7eaeac5c0e44 usb: dwc3: gadget: add a trace when disabling EPs
> d9972f470bcb usb: dwc3: core: remove unnecessary dev_warn()
> 2df033ca39b5 usb: dwc3: pci: make better use of gpiod API
> 5960387a2fb8 usb: dwc3: omap: Replace deprecated API of extcon
> 9fcfa463e17a usb: dwc3: drop CONFIG_USB_DWC3_DEBUG
> e746b06cc76a usb: dwc3: st: remove two unnecessary messages
> 2babd0d148a3 usb: dwc3: qcom: switch dev_dbg() to dev_info()
> 42f69a02e7ab usb: dwc3: exynos: switch dev_dbg() to dev_info()
> 9ff0fdca3b62 usb: dwc3: keystone: convert dev_dbg() to dev_err()
> e4f756675467 usb: dwc3: omap: drop dev_dbg() usage
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

