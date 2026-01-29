Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD1ED73E83
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 20:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992DE840CC;
	Thu, 29 Jan 2026 21:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kLfloiS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A1F840D8; Thu, 29 Jan 2026 21:13:48 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC7083FED
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 21:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E300460130;
 Thu, 29 Jan 2026 20:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4495EC19421;
 Thu, 29 Jan 2026 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769717624;
 bh=xN9r+r1i0Ks5+deCIUDVq3YT8d0Q1iaPgIFqyHnLGzw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kLfloiS3NPaRkZrGpsd/+IdyEtumDZDG8IWNjbp63tb7GxwP30IDbjfCbO7+ip+SW
 SMJH6dOBDcq6IOSEVb1okKP580tIDc1PNpK+2N98UGDgw8vd9Db2gq5kYTB0f3rlXo
 kA+6QcIPcUzYgMAGajNjPmah/56bRsTn5iPed2mHwMPPLHAOaAWXLa8FH/Pg/eZSuH
 eu1VPkBNHZZzkALVsu7iRldFouiWKH0U8Anh7fJHfoBdPII5sgmfbWX4ujQMtLQVGh
 TkpqDdjF3SkqkUD2IlXxEWcAqBBFAOD9bdEBQhlafg0obTHszoC/yRkK8vbDD49f1X
 8nygI5sCwVrwA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>, Lukasz
 Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: gadget: dwc2: Move dr_mode check from
 of_to_plat() to bind()
In-Reply-To: <20260129195207.2260264-1-jonas@kwiboo.se>
References: <20260129195207.2260264-1-jonas@kwiboo.se>
Date: Thu, 29 Jan 2026 21:13:42 +0100
Message-ID: <87fr7omb2h.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jonas,

Thank you for the patch.

On Thu, Jan 29, 2026 at 19:52, Jonas Karlman <jonas@kwiboo.se> wrote:

> Rockchip RK3288 and RK3506 contain two DWC2 USB controllers, typically
> one controller use dr_mode=otg and the other one use dr_mode=host.
>
> With USB_GADGET_DWC2_OTG, DM_USB_GADGET and USB_DWC2 enabled this result
> in the dwc2-udc-otg driver binding to both controllers, however only one
> will probe due to use of dr_mode=host on the other one.
>
> After the commit 6668b8e7cc68 ("dm: core: Support multiple drivers with
> same compatibles") it is possible to bind one controller to the
> dwc2-udc-otg driver and the other one to the dwc2_usb driver.
>
> Move the dr_mode check from of_to_plat() to bind() to allow dm core to
> bind the dwc2 host driver to dr_mode=host controllers.
>
> Before this:
>
>   => dm tree
>    ...
>    usb_gadget    0  [   ]   dwc2-udc-otg          |   |-- usb@ff740000
>    usb_gadget    1  [   ]   dwc2-udc-otg          |   |-- usb@ff780000
>
>   => usb start
>   starting USB...
>   No USB controllers found
>
> After this:
>
>   dwc2-udc-otg usb@ff780000: Invalid dr_mode 1
>
>   => dm tree
>    ...
>    usb_gadget    0  [   ]   dwc2-udc-otg          |   |-- usb@ff740000
>    usb           0  [   ]   dwc2_usb              |   |-- usb@ff780000
>
>   => usb start
>   starting USB...
>   USB DWC2
>   Bus usb@ff780000: 1 USB Device(s) found
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Marek, can I pick this up since it's gadget or do you want to take it?

> ---
> v2: Update dev_dbg message to include current dr_mode
> ---
>  drivers/usb/gadget/dwc2_udc_otg.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
