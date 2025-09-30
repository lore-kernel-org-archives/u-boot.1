Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05FCCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 07:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA8C83045;
	Tue, 30 Sep 2025 09:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TNOdIt4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D2D83071; Tue, 30 Sep 2025 09:47:30 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC15828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2404B62796;
 Tue, 30 Sep 2025 07:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA34C4CEF0;
 Tue, 30 Sep 2025 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759218446;
 bh=TjOoIDHJrUdzg5DlIM1wAjTOwJwecU/Am8+bcx7L9XI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TNOdIt4/wzJ+krUjN7yxujotbyMfkwC1VrwxG4gcLViiN6Hsfl+c9yFO6t/1y3RKF
 3y3BFuxPL9NQ/eMEw1l/1MdY0vcjkYPHhP1dVQ2RKuLJaUMmukGUuSjaG9AH19pSCz
 JAAwSXaLkOLMC/TW/DpihJfoMwE2Q5J1RH7Zz/h6e+nieAhFEhXit7o6oMdYxEwJIq
 2cazEc577BVuUyvx4iVRX2Hx9/nNXhu1fyALPDpK/0eWgSC5rVyiJabwyeDOtouNMI
 ZbnzMiAQc07KrWO7j/kflPBSNRd5I5uUCjakAdiykgMYcYg0U5MTR081fY4dR+7u9F
 TnWD3z1ViXsqQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal
 <anshuld@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH RESEND] usb: dwc3: Remove redundant test
In-Reply-To: <20250929-dwc3_ep0-v1-1-1d5c58933bde@linaro.org>
References: <20250929-dwc3_ep0-v1-1-1d5c58933bde@linaro.org>
Date: Tue, 30 Sep 2025 09:47:24 +0200
Message-ID: <87wm5gidpv.fsf@kernel.org>
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

Hi Andrew,

Thank you for the patch.

On Mon, Sep 29, 2025 at 10:11, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> In dwc3_ep0_complete_data there is a test for 'r' being null and the
> code will return at that point if so. After that point 'r' is guaranteed
> to not be null and testing for that is redundant. Remove the test for
> 'r' being non-null.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/ep0.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index c656cbe25ce6fad9ca1ef07aba131d30018db19d..680756532f0db16f7e6598df19f71bf2ab410820 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -799,10 +799,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
>  	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
>  	if (status == DWC3_TRBSTS_SETUP_PENDING) {
>  		dev_dbg(dwc->dev, "Setup Pending received");
> -
> -		if (r)
> -			dwc3_gadget_giveback(ep0, r, -ECONNRESET);
> -
> +		dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>  		return;
>  	}
>  
>
> ---
> base-commit: 44c4919e9dd6c162b237633ba689441eca9a149c
> change-id: 20250925-dwc3_ep0-47c99180480d
>
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
