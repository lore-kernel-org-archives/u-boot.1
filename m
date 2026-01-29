Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF95D358E5
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 08:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297A783B64;
	Thu, 29 Jan 2026 09:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VY/iTGah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B620C83BB1; Thu, 29 Jan 2026 09:49:33 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAD28003E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E31BD44184;
 Thu, 29 Jan 2026 08:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508E7C4CEF7;
 Thu, 29 Jan 2026 08:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769676569;
 bh=3+Az30oEqC8DL7fhaC7dlwDOhtU3ecnyOnVOyjdDZ+4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VY/iTGahtE2Kk1JHDU3+UGzFcYsby8U4NlBLtQ6LRcgDTn4mBo5XHAFJdzwFE6Hkd
 vbBwZJLp5uiJQhQcOMhymVNQNRzEZnj4mwF7bDyBHU1KuFD7XMYg7NqABQb+WDbR0k
 6S9xAtTFEUsRfxPozkHb3GgubislMEf/kPXWQeAchcd02fpn2zz9C0S8GI8rqiT1pm
 zrA6ecaqwMoXvSuyok9VnNjg78YCy09HgZDVEDXCblU0dfKuF2i3F6Q2w6bRiNIH7f
 fuXUeApBEFmYBcM5d0E221DGogC8eN0RlbfNN1yc+ohaTVH478x0N8a2Ys2JVmXQq2
 NGyVyN45ZLn+g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com
Subject: Re: [PATCH V2 1/4] usb: dwc3: core: Add ip and version_type support
 from Linux
In-Reply-To: <20260115230135.183158-2-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-2-macroalpha82@gmail.com>
Date: Thu, 29 Jan 2026 09:49:27 +0100
Message-ID: <87jyx0olbc.fsf@kernel.org>
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
> Add support for the ip and version_type fields from the Linux
> version of the dwc3 driver. Included in this is support for a
> few additional macros in the header from Linux as well.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/core.c | 26 ++++++++++++++----
>  drivers/usb/dwc3/core.h | 60 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 5 deletions(-)
>
