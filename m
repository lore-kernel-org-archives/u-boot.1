Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71D5C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B351406C7;
	Mon, 24 Aug 2026 08:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2jbiSQy6p1u; Mon, 24 Aug 2026 08:59:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561977;
	bh=lFH8l0q2XmGse21dt4rcFL/ddb1Z3iZEdLVc+AgXKYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oGmS1yCzmwUotzECDHyQxis7njRoXCMcYSIX0vJtl9p+z/kz01OrFVGzq8NUEsDkV
	 CMRGHONnCugJsS9PEl+6J0Z4N8ji3TpPc7ed6aJSLUIGPWt9Jeb6w1do4tdZJBTax+
	 zux79uNPjUVsJnXeubp2u9wjJKpb2QVohoe7/6aeEKnhGT2aHuKtMw4EuIPpgNs3zq
	 O/vWPh8lNMXt2O+WggLmi68ej60ZSBuUsEW+9ffpg/81HlPzCBFmL0ju3uNjqSDKZa
	 zkjaVufc96WfSZMtR1HnkK/GVw1OhChOo2pW0NQzrjC/a+bEr4JuE53V1X+jks8Jl0
	 oQyUtG9F54lJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23ACB40693;
	Mon, 24 Aug 2026 08:59:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C55DC336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B73C6400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GtAn0nFWIH_Z for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:59:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YUfM1cTJ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02FB64005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:59:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6E0E601DE;
 Mon, 24 Aug 2026 08:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEC71F00A3D;
 Mon, 24 Aug 2026 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787561972;
 bh=lFH8l0q2XmGse21dt4rcFL/ddb1Z3iZEdLVc+AgXKYo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=YUfM1cTJvPvG2hEj0YoLkeCFBEnetKFBU3yjUBAlScKWSCO3DzswWr1TYW2hOZzAm
 6eh61iBFo7n+eer8qTT27TUD3IZKYLgqmtidK24TpcfkIyZAx18iWq8Ylg72vIdAb/
 Hf0ZtaPfNJMCvU8pLioqX+hBAjhLeLsWNsuppvuuLuPqVPG03pe215T6qnEZfih+tI
 cXKQ9IvS7og29dAsxlmnaqqfICPsn17Y2RyqL7LeC1nPn2EZgVhRg+OP42PStAJPWY
 hjhmz0G0Lif9fxo6BRueDwKXmzY3Tud5VaZ6qHE7+Uh2MyHmTKcRUpeuwc/8MiZS/r
 ECdB/iEcQDbng==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, michal.simek@amd.com,
 alchark@flipper.net, jerome.forissier@arm.com, Jens Wiklander
 <jens.wiklander@linaro.org>, Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski
 <lukma@denx.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 33/87] usb: dwc3: import from kernel v5.8
In-Reply-To: <20260821084829.2070426-34-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-34-anders.roxell@linaro.org>
Date: Mon, 24 Aug 2026 10:59:29 +0200
Message-ID: <87bjaropvy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Anders,

Thank you for the patch.

On Fri, Aug 21, 2026 at 10:47, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v5.7 to v5.8.
>
> The following files are preserved across the import:
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
> List of commits: git log --oneline v5.7..v5.8
> Commits imported:
> 63c7bb299fc9 usb: dwc3: gadget: Check for prepared TRBs
> 1c0e69ae1b9f usb: dwc3: Increase timeout for CmdAct cleared by device controller
> b10e1c253577 usb: dwc3: gadget: Use SET_EP_PRIME for NoStream
> 140ca4cfea8a usb: dwc3: gadget: Handle stream transfers
> aefe3d232b66 usb: dwc3: gadget: Don't prepare beyond a transfer
> e0d19563eb6c usb: dwc3: gadget: Wait for transfer completion
> 3eaecd0c2333 usb: dwc3: gadget: Handle XferComplete for streams
> 548f8b316563 usb: dwc3: gadget: Enable XferComplete event
> 2e6e9e4b2ed7 usb: dwc3: gadget: Refactor TRB completion handler
> b6842d4938c3 usb: dwc3: gadget: Check for in-progress END_TRANSFER
> 4244ba02edb8 usb: dwc3: Get MDWIDTH for DWC_usb32
> 9af21dd6faeb usb: dwc3: Add support for DWC_usb32 IP
> d9feef974e0d usb: dwc3: gadget: Continue to process pending requests
> f7ac582effc6 usb: dwc3: gadget: WARN on no-resource status
> 36f05d36b035 usb: dwc3: gadget: Issue END_TRANSFER to retry isoc transfer
> 9bc3395c2496 usb: dwc3: gadget: Store resource index of start cmd
> 8d99087c2db8 usb: dwc3: gadget: Properly handle failed kick_transfer
> 8bb14308a869 usb: dwc3: core: Use role-switch default dr_mode
> fcd2def66392 usb: dwc3: gadget: Refactor dwc3_gadget_ep_dequeue
> 8411993e79df usb: dwc3: gadget: Remove unnecessary checks
> a7027ca69d82 usb: dwc3: gadget: Give back staled requests
> cb11ea56f37a usb: dwc3: gadget: Properly handle ClearFeature(halt)
> c2cd3452d5f8 usb: dwc3: support continuous runtime PM with dual role
> b33f69f56352 USB: dwc3: Use the correct style for SPDX License Identifier
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

