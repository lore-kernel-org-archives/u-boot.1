Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8664C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02DF80F4C;
	Tue, 18 Mar 2025 13:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742301075;
	bh=uLcSUdRYvnVsOFxiTSFMEA/sGZPIMdXUIe9s9d0TqNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eKy81rSNYZ5S0jCt4kN+nGG9hFVk6/cwQX0qsPURm+7r55nokmEi+2zwPTexZDmjd
	 zQQ3ujZFtrpNzYKAj2oBkkSo/IrBbomvX2LTRLCN23UQST+Hs3Z24/pCR0/dWPEYha
	 PQF1NyD5X9Y3Dek2dOg/AF9CO7ASE+a/NZjHqGp0kwTyYryKp1VXAOyQFSeD5EVsxe
	 Gvi+e7DYVAiwAuriWZqPVZDjYVZm2qKbDRcXdy6yQcrFx60nsfY5pXd4SFZnW0wrYZ
	 ZvjACG0qtaAWSsT5Bz5ch0dyToa6MXs394ICz/sLXRWyYJz9a7j2Pq9eBiM67EYZ5R
	 6Wk0mZJNintvQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097A981026; Tue, 18 Mar 2025 13:31:14 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E83F0800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 13:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eMnxyJR9"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8302B10382F1B; Tue, 18 Mar 2025 13:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742301070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=uLcSUdRYvnVsOFxiTSFMEA/sGZPIMdXUIe9s9d0TqNw=;
 b=eMnxyJR9H8NrA9qoqshmB99zcdrYI9gxshusuLHZbAjqV8KkkyNN0RWVmOO9dJITYuOVMb
 MmCX6PfsS6ijyZQqZ4dEx2tvDyNgib8zObKGm8AmifU+oqsHhTXDCfDt9TFh4/3Gn82dxg
 klBIgg6Qv3d9kdpmyG2qNwyDWUkF5oZqLs9Dnu5Ve/OFethNL2AGcAjRUeJvmBD4YKyMlF
 InNWKCKuHhVukE3T5Bp2Ze6j26knrJFTYtviVPR7l/LGRgthztFYPBTyk9NKN8xIo2N2K2
 lYekoKxpvCSCZvVqpkXLgvlgj8KF0W8jeVGDmRiFWEmcy1u9Zjkvlz0P3vw7pw==
Message-ID: <95cadc8b-2922-4bd2-8a0c-8ecdb5885bed@denx.de>
Date: Tue, 18 Mar 2025 13:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] dm: usb: move bus initialization into new static
 function usb_init_bus()
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Dragan Simic
 <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-11-jerome.forissier@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250318104659.1114340-11-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/18/25 11:46 AM, Jerome Forissier wrote:
> To prepare for the introduction of threads in the USB initialization
> sequence, move code out of usb_init() into a new helper function:
> usb_init_bus(). No functional change.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   drivers/usb/host/usb-uclass.c | 88 +++++++++++++++++++----------------
>   1 file changed, 48 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> index bfec303e7af..cc803241461 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -287,9 +287,55 @@ static int usb_probe_companion(struct udevice *bus)
>   	return 0;
>   }
>   
> +static int controllers_initialized;
I'm afraid this won't work, you will have to track the controllers in a 
list somehow, because it is possible to unbind DM devices even using the 
'unbind' command from U-Boot command line.

Also, why not simply track the controller state using DM in the first place?
