Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A8ECD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2378184A29;
	Thu,  7 May 2026 10:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d1F4nWrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F05784A30; Thu,  7 May 2026 10:51:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E295F84903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A9D643AB1;
 Thu,  7 May 2026 08:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF8CC2BCB2;
 Thu,  7 May 2026 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778143904;
 bh=pRnUGM5oILMU19KppWZ34NALjmfMxAmvQHOZ5Dnt5zQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=d1F4nWrHstnbwRhrfTtMO+ubFR6TOH7qH+8ZRlgBQT4C9goPPUuifjk91dScMyRtP
 BdeXun4YsC4ieZuAwlq9Nr5j8oquV+YS0iM8d34eAwmh/klSOtq1bF3Xh17ZUMqLUJ
 fEN1B06eDDVHbItng+nj9uv+dazmtTTrPdz1avUcSTAVu7q9VQGOxyQhfTbX1jItnV
 TZP9PK7MdQm2vU5z3BLIX1O/5Jj9ZFamkWAnwSTxzyyzbioZw6Bhm79vVtx+1gRn6T
 eSraDkq3JHebMdq4FfZ9PON+gm6wcQ3pGbCVkfbapH86sBObG9mYatRqry0PKzXSTj
 WZDA6TeNCzysQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Gurumoorthy Santhakumar
 <gurumoorthy.santhakumar@oss.qualcomm.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Chris Morgan
 <macromorgan@hotmail.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, Casey Connolly <casey.connolly@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2] usb: dwc3: Fix crash on fastboot exit due to
 incorrect memory free
In-Reply-To: <20260507-usb-v2-1-3958b8732553@oss.qualcomm.com>
References: <20260507-usb-v2-1-3958b8732553@oss.qualcomm.com>
Date: Thu, 07 May 2026 10:51:41 +0200
Message-ID: <87fr43d2le.fsf@kernel.org>
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

On Thu, May 07, 2026 at 10:06, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

> The dwc3_free_one_event_buffer() function incorrectly called free()
> on event buffer structures allocated with devm_kzalloc(). This
> caused heap corruption and a synchronous abort when exiting
> fastboot mode via "fastboot continue".
>
> Device-managed memory is automatically freed when the device is
> removed, so manual deallocation causes the heap allocator to access
> corrupted metadata.
>
> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event buffer cleanup")
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Ah, and I missed a nitpick. Fixes should be part of the commit footer.
Same block as in the Signed-off-by:

See: https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> ---
> Changes in v2:
> - Added Fixes tag in commit description
> - Link to v1: https://lore.kernel.org/u-boot/20260506-usb-v1-1-e0f426bb1e42@oss.qualcomm.com/
> ---
>  drivers/usb/dwc3/core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 0dee14c8b59..be198041f08 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>  		struct dwc3_event_buffer *evt)
>  {
>  	dma_free_coherent(evt->buf);
> -	free(evt);
>  }
>  
>  /**
>
> ---
> base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
> change-id: 20260507-usb-34b404ff063a
>
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
