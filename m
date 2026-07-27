Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B2EC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F366880AAA;
	Mon, 27 Jul 2026 09:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDPDbL7cLQbQ; Mon, 27 Jul 2026 09:09:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 604B780A84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143365;
	bh=OrtMMPLDGb9liokmDb7EenAntkd3oY+2xTqAHdpZk1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8UrO8eUq0q2ciFsm/alElepfuLi2ag/NWnkFgVQZJZgrBpp3NJO0W6HWFFu06KBr
	 mFmiiU3XVDiOtA6aPy75CktG7uWHUuoHilLXlHR2o9PPkAeBVfDMXnKG3okfDYQde4
	 b0ZFnjxZdiAkaEvbrPupltcK8ugpK79Xhr/ItLex3h6eoFGMCj2yO/VNwSZUJAa4rw
	 2UhH516R6YqsnWsOEwdTRWYXJqvpZkgkJ0qXn/i3syUPX7RF8IJKoN9j6snUWVpJZy
	 1C+yJBmMgUGvcykf9zapuKRcIvSzZf87ZqRyqb9H9/WybI2h7uhD1uNrqfmOZOgL4D
	 VMd4p1TUm08tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 604B780A84;
	Mon, 27 Jul 2026 09:09:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B83A39E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D93E400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a232WJV5RUPt for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:09:23 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E2DEB4005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2DEB4005F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2DEB4005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:09:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D447D84671; Mon, 27 Jul 2026 11:09:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FD082991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:09:18 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B9F3401A5;
 Mon, 27 Jul 2026 09:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990C41F000E9;
 Mon, 27 Jul 2026 09:09:16 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 19/75] usb: dwc3: import from kernel v4.16
In-Reply-To: <20260716134305.614278-20-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-20-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:09:14 +0200
Message-ID: <87qzko4x51.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143357;
 bh=OrtMMPLDGb9liokmDb7EenAntkd3oY+2xTqAHdpZk1c=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=U6144wiWFSKUT0wh4uCWJyuQeBujBCddFK1noLizqpHnEqRS+UKuKeG9kMOeN3nvI
 rgiq2AIh5VV1yFnJlzKOzT/UBQzZG1XQrJvm/6E2CXSDi0/lYjTv7paaytj4qCi5SN
 cI4R7oe4fbO23vOj5xjZHkwT+3BnhKtQMXJ6PNH7gFnMOiHLFw8HMo93L/5aIITvD6
 VBeo0GbB/VbP81MRmjmlbnJvdJe9tdfXmq2pQQtI6QtWlt0nzuYwwPm3L+Kbkjd+uW
 MEuInxhvmF8uygsb5NfKuNh3j8l76xYzYX+MwxZIKN8Ha+ici/g+5byaGjBS4px3lT
 YCQBgbKh3blww==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=U6144wiW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="U6144wiW"; 
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
> Sync Linux kernel dwc3 changes from v4.15 to v4.16.
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
> List of commits: git log --oneline v4.15..v4.16
> Commits imported:
> 084a804e0120 usb: dwc3: Fix lock-up on ID change during system suspend/resume
> 98112041bcca usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume
> b16ea8b9492e usb: dwc3: Fix GDBGFIFOSPACE_TYPE values
> c49f63055e25 usb: dwc3: omap: don't miss events during suspend/resume
> c4a5153e87fd usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode
> 00b42170c86f usb: dwc3: Undo PHY init if soft reset fails
> f035d139ffec usb: dwc3: ep0: Reset TRB counter for ep0 IN
> 6180026341e8 usb: dwc3: gadget: Set maxpacket size for ep0 IN
> bff52352e0cc usb: dwc3: of-simple: fix oops by unbalanced clk disable call
> d8c80bb3b55b phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800
> 42bf02ec6e42 usb: dwc3: Allow disabling of metastability workaround
> 204ec1af6257 usb: dwc3: Make sparse a bit happier
> 19e0b203bfbd usb: dwc3: ep0: use gadget->isoch_delay for isoch_delay value
> 0c5d2954f690 usb: dwc3: debug: decode a few more features
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

