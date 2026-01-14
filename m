Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC77ED29FED
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 11:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153F280081;
	Wed, 14 Jan 2026 12:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kpIGmaJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A35480325; Wed, 14 Jan 2026 12:09:28 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0208003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 12:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9100C60052;
 Wed, 14 Jan 2026 11:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2756C4CEF7;
 Wed, 14 Jan 2026 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768388960;
 bh=Xxu1M94KTLKOfGwk3Pkfnk4abuIiDS7SgaO1BtBAVbE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kpIGmaJ3gQz3MvH33ia8sbs3YYs/59wAZzkGDOUdrLLg16UiMO+AERPfFeUnf+Jf/
 KRp0BsptlYN/Bc/242GNzTkbUc9NXMsKPDDxB3tS+OAnyzaVAmwx0iLG2s1qI+C5hF
 PTBZGNVb40MhKDF94paNntGwawh4JpvOrFyol94gWmkE8vYm/Tf6TVK7JKnL+pBu/M
 AM5uy73wW9KKVlRtqS3CRway6JFQmwScQdaLiicD81tu5BQe60VtM442c1TTfjeYDt
 eNrtCvPVOLPUuJZAitpQ8NGBA5atJaORBBZxOvdkUk85lDNV2orUXom6AUVau4fLkm
 7iHgcFrOJ2gSA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] usb: dwc3: gadget: Don't send unintended link state
 change
In-Reply-To: <20251223231311.1983423-2-macroalpha82@gmail.com>
References: <20251223231311.1983423-1-macroalpha82@gmail.com>
 <20251223231311.1983423-2-macroalpha82@gmail.com>
Date: Wed, 14 Jan 2026 12:09:17 +0100
Message-ID: <87jyxkfo2q.fsf@kernel.org>
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

Hi Chris,

Thank you for the patch and sorry for the review delay. I was on
vacation and a bit swamped when coming back.

On Tue, Dec 23, 2025 at 17:13, Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>
> DCTL.ULSTCHNGREQ is a write-only field. When doing a read-modify-write
> to DCTL, the driver must make sure that there's no unintended link state
> change request from whatever is read from DCTL.ULSTCHNGREQ. Set link
> state change to no-action when the driver writes to DCTL.
>
> Note that this patch was submitted upstream in Linux in 2020 [1],
> and I've confirmed I need it in U-Boot to enable gadget mode.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=5b738211fb59e114727381d07c647a77c0010996
>
> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/usb/dwc3/gadget.c | 20 +++++++++-----------
>  drivers/usb/dwc3/gadget.h | 14 ++++++++++++++
>  2 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2b01113d54c..24ae0c232f6 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -62,7 +62,7 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
>  		return -EINVAL;
>  	}
>  
> -	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> +	dwc3_gadget_dctl_write_safe(dwc, reg);
>  
>  	return 0;
>  }
> @@ -1396,7 +1396,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
>  static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>  {
>  	u32			reg;
> -	u32			timeout = 500;
> +	u32			timeout = 2000;

This change (timeout increase) is not part of patch you linked in [1]

Can you either drop this or move this to a separate patch, explaining
why it's needed?

>  
