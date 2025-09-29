Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2228CCAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 08:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0B1809A5;
	Mon, 29 Sep 2025 10:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K6ZF5eth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B5D8206E; Mon, 29 Sep 2025 10:47:01 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F282B808AF
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 10:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D97CA6234C;
 Mon, 29 Sep 2025 08:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC49C4CEF4;
 Mon, 29 Sep 2025 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759135617;
 bh=1PFscZ2OFFXFCm6EHIhxzfBqde/7BMU74X3ZYuTQtm8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=K6ZF5ethqfnnXKoOPBWBH0AFqRHZbHWNMpmkZWKPKQlTNQsZa9Tp9cjBIupO0QPnm
 YsOjIA4Y82FW04NFSWvxuZQ+PF/nkdLp3p4dWtnLGtOfXA9DTYl3bhK3Ty1U6s0TGl
 MjUGvuvhzsMojeC4OUjkzD/nhWTmpdDAhyAJUw2eoby5gPK6UL7WtxJPJ5SEE96eK0
 Vr93CrM4euBnhZPDSAUd+PRdkhj5AB9WCxLPG7Tqkt8C6Uh+0zSONZ1zeNNKwPkCtg
 Kwc6PMA55f9j3tNllP/3uYZiyma50nL6rifDcHhlsqqQEmwOUR/gfvOSdfJmWT8I5O
 xeDaQqtJpH8UQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX
 U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Peng Fan
 <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Adrian
 Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tim
 Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 5/6] usb: dwc3: gadget: Add delay after software writes
 DCTL in dwc3_gadget_run_stop()
In-Reply-To: <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com>
Date: Mon, 29 Sep 2025 10:46:55 +0200
Message-ID: <87a52dk5mo.fsf@kernel.org>
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

Hi Alice,

Thank you for the patch.

On Sun, Jul 20, 2025 at 06:13, "Alice Guo (OSS)" <alice.guo@oss.nxp.com> wrote:

> From: Alice Guo <alice.guo@nxp.com>
>
> When using NXP UUU to download flash.bin to i.MX95 19x19 evk board, it
> will get stuck in a loop at sdp_init() without this change.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

I see that a similar change exist in the Linux kernel:
https://lore.kernel.org/all/20220901193625.8727-4-quic_wcheng@quicinc.com/

Please mention this change in the commit message for v2.
See the following example:
https://lore.kernel.org/all/20250110-dwc2-dev-v4-7-987f4fd6f8b2@pigmoral.tech/

> ---
>  drivers/usb/dwc3/gadget.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2b01113d54c..6b2b25c7aa5 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1423,6 +1423,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>  	}
>  
>  	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> +	mdelay(2);

Can you elaborate on why 1ms is not enough?

>  
>  	do {
>  		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>
> -- 
> 2.43.0
