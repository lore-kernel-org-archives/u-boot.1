Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C623D358E7
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37CC83B85;
	Thu, 29 Jan 2026 10:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aA+F9p4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505C283A8E; Thu, 29 Jan 2026 10:06:47 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A620583A8E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 86F4B60125;
 Thu, 29 Jan 2026 09:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAF4C4CEF7;
 Thu, 29 Jan 2026 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769677602;
 bh=XY3NaQD2Ryux7QQVBUM84mzCVbYB2BLRUIlnmq2RINs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=aA+F9p4Blih71sgkqt99MOwxxjkwY1+ZTL8uXwfTF9xCHJCzH8mhYWBefuy1FQdrn
 f6l8MzLmLqsU8eO7voaJwfsPbilkBjWD2XKlCMTiw/UfrdAlltfB0zrt+pp8BFe5XC
 fWj91n/qY8ME8OrrvG3aPXMk6O0TOdCCePl/9xQj/EyfT8j4zvI5WGCaOaIu/65zjF
 2V1FDM6Kbch0NGuU7Y5WkZ5EbwqXga0jRkRlxLoh3rYDSTzRYDiXX0Jwu+8A/deJq/
 yNEPPNLd3EucvTSUIKegik7hT7t2vmWt1Svrx9L3sWd3dQPS3KtZoemP88z4UXxXHc
 K+KLtIQmT0A5A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com
Subject: Re: [PATCH V2 3/4] usb: dwc3: gadget: Don't send unintended link
 state change
In-Reply-To: <20260115230135.183158-4-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-4-macroalpha82@gmail.com>
Date: Thu, 29 Jan 2026 10:06:39 +0100
Message-ID: <87ecn8okio.fsf@kernel.org>
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

Thank you for the patch.

On Thu, Jan 15, 2026 at 17:01, Chris Morgan <macroalpha82@gmail.com> wrote:

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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/gadget.c | 16 +++++++---------
>  drivers/usb/dwc3/gadget.h | 14 ++++++++++++++
>  2 files changed, 21 insertions(+), 9 deletions(-)
>
