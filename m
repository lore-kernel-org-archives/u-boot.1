Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795EFC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4927E80A9F;
	Mon, 27 Jul 2026 08:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BSepfJcjmSmV; Mon, 27 Jul 2026 08:59:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FDF580A53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142760;
	bh=dsT9FFkPivXB23vasggJ0wtWK4zrruVzzYwkC5cjxVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKzzvLPdVumgRPg9aG62yVF5d2sCQfiZ83lHCtk2tK98RR/0tL0alxXEH9vsAmAs8
	 5ssyL7RkPr8t+K3/nVXL1a7vZ00WVXdKtMz4JKm3QPC50wxoUbwJK2h3rmfZRf1b0A
	 qHI3Kn5HN5CplGj1IMxbVNjOzLE1Ix/NJH47MOeoTV6lZiBNEA/aIZ6m7eJ+kzuS8i
	 xftv78PwRIY4aBDViGsZ0C4/+/j7zt0hDHxnbpY1cT1lyZUisDPMhhcxyW7gvFXmF7
	 xg6ZVMpQaddI37aHcjFYv55PwSg90AT2N0MBShzFq9uPxws9dr+HI1Cbgru4WJqUK/
	 Xcnrs3vAcjnVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FDF580A53;
	Mon, 27 Jul 2026 08:59:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64DC7490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AE8B80868
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWOHgsjTaGaV for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:59:17 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0DD7D80BD3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DD7D80BD3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DD7D80BD3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:59:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0421A84671; Mon, 27 Jul 2026 10:59:15 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D2382991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:59:12 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 185FD4333C;
 Mon, 27 Jul 2026 08:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1911F000E9;
 Mon, 27 Jul 2026 08:59:10 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 12/75] usb: dwc3: import from kernel v4.9
In-Reply-To: <20260716134305.614278-13-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-13-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:59:01 +0200
Message-ID: <87cxw86c6i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142751;
 bh=dsT9FFkPivXB23vasggJ0wtWK4zrruVzzYwkC5cjxVo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=C3/rcBcwHZWSafIa1mTRft49tInJoQ5DQYGz7VsaY2qqAHbH50+BiKUkGgkqsjPsc
 9mvVoxNutz8EHRIwvC4eWajbZfltuzyGdEinaWQB2jPbhxgsDv1AJX72vmNy/XSiCG
 FU0zngCdYnV5GTR7HHzAGy2TuIdrafiAmWP9/Pxsn2yeQNq9T5JvDGagC7WRamfQnY
 mZQOlZjG1y0aTyvCKbcHU1FDYWCxxoGkZ50LJI6h5ec41M2y9anqlcqo9dB7ecr8qe
 Jo8Ltm886foYoG9Xr4f6WAQxeOrGT6vh3iIaN87w9VgGoGKNwWcmt9v/97iDbmQzmL
 qZXeBeXzZM2mA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=C3/rcBcw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="C3/rcBcw"; 
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
> Sync Linux kernel dwc3 changes from v4.8 to v4.9.
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
> List of commits: git log --oneline v4.8..v4.9
> Commits imported:
> 4accb8a1ee7d usb: dwc3: st: add missing <linux/pinctrl/consumer.h> include
> 9b9d7cdd0a20 usb: dwc3: Fix error handling for core init
> 51fbc7c06c89 usb: dwc3: Fix size used in dma_free_coherent()
> d889c23ce4e3 usb: dwc3: gadget: never pre-start Isochronous endpoints
> a9c3ca5fae6b usb: dwc3: gadget: properly account queued requests
> b281dc630b41 usb: dwc3: of-simple: add compatible for Cavium
> 26c9cac402c4 usb: dwc3: of-simple: allow glues without clocks
> 8d53e6267594 usb: dwc3: of-simple: Fix warning during unbind
> 5e6c88d28ccb usb: dwc3: fix Clear Stall EP command failure
> d6e10bf2ba47 usb: dwc3: avoid -Wmaybe-uninitialized warning
> 9d6173e125d9 usb: dwc3: Fix dr_mode validation
> 073c47aca7b7 usb: dwc3: ulpi: make dwc3_ulpi_ops constant
> e6f74849784c usb: ulpi: rename operations {read|write}_dev to simply {read|write}
> b7cf1dc3414d usb: dwc3: ulpi: use new api
> 594e121f2568 usb: dwc3: gadget: stop kicking if we run out of space
> 7ae7df4982af usb: dwc3: gadget: abolish trbs_left
> 06281d460fc5 usb: dwc3: Add ENDXFER command polling
> 512e47572f7d usb: dwc3: Add revision numbers for the USB 3.0 IP
> 00af62330c39 usb: dwc3: core: Move the mode setting to the right place
> f652191be3f6 usb: dwc3: of-simple: add compatible for rockchip rk3399
> 00fe081dc3a3 usb: dwc3: add dis_del_phy_power_chg_quirk
> 32f2ed864dd5 usb: dwc3: make usb2 phy utmi interface configurable
> 16199f338939 usb: dwc3: add dis_u2_freeclk_exists_quirk
> dc55c67e9c95 usb: dwc3: gadget: improve increment request->actual
> f99f53f24d87 usb: dwc3: gadget: remove condition that never happens
> 1f512119a08c usb: dwc3: gadget: add remaining sg entries to ring
> 2c78c0295fd8 usb: dwc3: gadget: interrupt on ring full too
> 0b3e4af3c740 usb: dwc3: gadget: add sg and num_pending_sgs to dwc3_request
> 31162af447d7 usb: dwc3: gadget: avoid while (1) loop on completion
> 08a36b543803 usb: dwc3: gadget: simplify __dwc3_gadget_ep_queue()
> 45438a0cd9c2 usb: dwc3: gadget: simplify dwc3_ep_prev_trb()
> 737f1ae2556a usb: dwc3: gadget: increment dequeue pointer on completion
> 4bc48c974708 usb: dwc3: gadget: retire LST bit completely
> a26a142275c6 usb: remove redundant dependency on USB_SUPPORT
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


