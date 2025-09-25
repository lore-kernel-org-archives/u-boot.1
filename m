Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85CCAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 13:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A4980107;
	Thu, 25 Sep 2025 15:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TREENJsQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 917FE809A5; Thu, 25 Sep 2025 15:56:09 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0598004F
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cXZxd4MBlz9tKg;
 Thu, 25 Sep 2025 15:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758808565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzezK+1OMcK5qWC8IPNuRXrZDp78GOiWFOVmaa84xH8=;
 b=TREENJsQskEpwvA80iQoSH56VTH75WSI0nhhXl/kyvnFy0kmf5BSDKbU5CR62v8/0Levu5
 aE2T3/Ji8fsdbfXCsw4uzmKCtGNZ3W6sfVnhL18jJ6aUMZMIBIHZYcl9et4DpiNdDE+P7r
 /jm3aObxx/s2pC745/LQwi2JpFtMOofPAaDgaJbS9m8EnypKZRrNggn6NubUYyJba3jN5H
 aRvG4WsiOt2rgPkXjU6AN1vYVOUnltpTGkwhefaj1dOvcrsAFFPTsvlqplK9n8Vm2VkEC4
 7y628LMH2Rnlto09W4np9pBNxxXd4xjsaSpddktwxJG928Mbfqs2sB90Wkl08A==
Message-ID: <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
Date: Thu, 25 Sep 2025 15:56:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: r4qrw5j3i1g51dmrnnughcupmzzonwei
X-MBO-RS-ID: 0a91d3df761df669ad9
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

On 9/25/25 3:20 PM, Andrew Goodbody wrote:
> In dwc3_ep0_complete_data there is a test for 'r' being null and the
> code will return at that point if so. After that point 'r' is guaranteed
> to not be null and testing for that is redundant. Remove the test for
> 'r' being non-null.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/usb/dwc3/ep0.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index c656cbe25ce..680756532f0 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -799,10 +799,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
>   	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
>   	if (status == DWC3_TRBSTS_SETUP_PENDING) {
>   		dev_dbg(dwc->dev, "Setup Pending received");
> -
> -		if (r)
> -			dwc3_gadget_giveback(ep0, r, -ECONNRESET);
> -
> +		dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>   		return;
>   	}
>   
Please use ./scripts/get_maintainer.pl to get full CC list and CC all 
relevant parties.

-- 
Best regards,
Marek Vasut

