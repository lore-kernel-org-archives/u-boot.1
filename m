Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E90ECD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA14F846A1;
	Thu,  7 May 2026 10:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a0Q7rq9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C00B8470B; Thu,  7 May 2026 10:45:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312C08468B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 976FF40860;
 Thu,  7 May 2026 08:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D285AC2BCB2;
 Thu,  7 May 2026 08:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778143511;
 bh=gpAkEfSp0iy4g/827BLnOWP6B2hwwL8qtZDHwK4QB68=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=a0Q7rq9JnnMCRWfkITvHYTEZMeqOEVf9NZhDj+TuPZkFsagXvCoNJ2Z1WNMqxWL5n
 WAQiQ9X3QpYaou4u0fwr5lVNVVGuZnyYeANXeyGqImHZxMRisnfkBDmTIGNW0FaV61
 t8YBXiU4WTrpaHSYqPVW2wdWZkk5J7lkF93943HKJMrR3W8D4kzwHB0F2CvKSVPLpQ
 snsaDQ28PtMLgymfHefXMR9o98uzqx97PkVdRg4To1vSqM8XuCtIlJrOF/0B+jWlep
 NJXY4ZKHWDatQMMTzUKpGwZv53cx8uQ54YAwSjnWx1PjPmQry8rtl8TFOWPrqmrOFd
 slb79YDQJcOvA==
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
Date: Thu, 07 May 2026 10:45:08 +0200
Message-ID: <87ik8zd2wb.fsf@kernel.org>
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

Hi Balaji,

Thank you for the patch.

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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Marek, I'm assuming you will pick this up.
If you want me to take it instead, let me know.

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
