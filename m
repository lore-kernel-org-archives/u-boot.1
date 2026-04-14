Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF6FED7B9D
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 10:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66A4839D5;
	Tue, 14 Apr 2026 12:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g09c4yF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61CBC841CD; Tue, 14 Apr 2026 12:35:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1E2838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 12:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fw0zQ59VNz9txr;
 Tue, 14 Apr 2026 12:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776162931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF4iXTMhRxEH0Q8xeFzyeQn1fBkambyxuE/i9VVcOxU=;
 b=g09c4yF7WthGeQEHPkFD+DTsThNy1AYTqXXjEjP3bcnib/TfZzIkBatnoTHI6pS8M8F6B9
 pqZkn9XdzNrDZ/n17bhjzpvPAXkMBWDjRCsW+HhMUH0++SvN7j+VytjBEpwopf3jGgUv68
 h2dThTqs1WtFI5OocJzyLqdRKoWDOENnGP7tVuWNw7Gy6rkEtvpK53Ed+/TIhCcyfQHsoZ
 83cd8Y1dF2JVm4Ek9RSdhTDdPjDVAwD+1m6Eku3mzfo+cLDJ9vZ9dd86MqdXSLaiKqrKtf
 0EfeetKj+3zX6ifY7M1uOllxB22dmQSzOUIVa1M+bSkilYp6tFJdqB8mO2KjWA==
Message-ID: <3f3a5163-7f59-4d02-8fe2-983cdd03b6cf@mailbox.org>
Date: Tue, 14 Apr 2026 08:11:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] usb: dwc3: core: fix memory leaks in event buffer
 cleanup
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 macromorgan@hotmail.com, casey.connolly@linaro.org,
 felipe.balbi@linux.intel.com, quic_varada@quicinc.com, u-boot@lists.denx.de
References: <20260414055013.2978223-1-gurumoorthy.santhakumar@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260414055013.2978223-1-gurumoorthy.santhakumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xsb6wxsgh7815thznarz1i5e4uo356ka
X-MBO-RS-ID: 8cc059e980cc04d6d7a
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

On 4/14/26 7:50 AM, Gurumoorthy Santhakumar wrote:

[...]

> +++ b/drivers/usb/dwc3/core.c
> @@ -206,6 +206,11 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>   		struct dwc3_event_buffer *evt)
>   {
>   	dma_free_coherent(evt->buf);
> +
> +	if (evt) {
> +		free(evt);

It is valid to call free(NULL) , the if (...) conditional is not needed 
here.

> +		evt = NULL;

Is this assignment needed ?

> +	}
>   }
>   
>   /**
> @@ -252,6 +257,11 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
>   		if (evt)
>   			dwc3_free_one_event_buffer(dwc, evt);
>   	}
> +
> +	if (dwc->ev_buffs) {
> +		free(dwc->ev_buffs);
> +		dwc->ev_buffs = NULL;
> +	}
Same two comments apply here.
