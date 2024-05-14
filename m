Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B309C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE5187530;
	Tue, 14 May 2024 15:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vNFh5u74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B112980245; Tue, 14 May 2024 15:06:00 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3718187530
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04e2so34152325e9.3
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715691955; x=1716296755;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6igzO4X4KS1q5MMbDDohBFmBgZG5f/jrRYSWsjM4fAc=;
 b=vNFh5u749jEOZKEa8GUv29oPy30IYIdmiPHJ0hDMlaVevmticex3vjjhUsH5l9ng9e
 a0Vf0joVWJJLhL8hTVCWduRMZRJZjog9X1Mk4Vtz7JB/4Qs+LW9lf7JyI9b0HEFs9bCx
 NFgj0Vj40Y+5ZoaHiXtCdUCDlGAhGWhQjK0maH7ZadwUj5fnXhuY5AnjLy16RcsYu6tM
 n5pOnKnq3fnC6sYcwW+h6oLhG6HrCOnam/ibPAvNutPb68jJKhfzQ4+/Ly9EXpG2Nv9K
 kk7dttlwd5ww31kGilWqcN/xYy8eRNLZCe5x5pXqe4P4PuNSF4clM5BCIhDdJmk3kw/6
 Dfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715691955; x=1716296755;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6igzO4X4KS1q5MMbDDohBFmBgZG5f/jrRYSWsjM4fAc=;
 b=Va8sT0Ey9PrQdkWK6l+3T1hgcLod5ONd2UkhiFhFQt9nSWORWt/YBbo1E3/ivZcMBH
 hatx5h6zPtYaDHFRWyDYdwrR6brJSl/qQNDKZ18VbkgRSWj0io1ivS0PK+bzGZK2UclV
 /OVnXaOFF3jx1ONCPjWfXF9eC526Llfwxhjl/cstY4E32NFhZu5SSVd35S/3X+yJQ+Z4
 v/2dxjf8JZHusWt0upriPk2MNHmjWPAZxobgPur59TaR1kvxB6MFIW6ewmlC+l21RP6y
 VgcegPj6ZgCk7cPO5ROxjUxGFRT8zPgdkEfF0uyriEamu4klUdBaWhq3rsYjIUv8hQfm
 4vFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVSdIwxynRW8iqeubt8gRiMYy0EdLfEwTPMUWbHwF2DECgsph4mMh+jMv8zUVYujtPQeB8ypAj/Z2VN1zLEyvY4pamAw==
X-Gm-Message-State: AOJu0Yyl4JW3ST8Eh4zSoDcUFqPVPQ5xC9uz7k4v/qWSkJAfySU3wJRp
 LsIsOqn0Rb6vx6jvg+p09rHGhibyir5B79yN6baqV3QdvtVOnya8CBbIjK1wPfo=
X-Google-Smtp-Source: AGHT+IEBCahP2CLtYoie4sfUfjhLFgT2fzf4U/vxJAwiKtIUqOcCYWU8cPjwWWO7dqLAZoTeW04Yrg==
X-Received: by 2002:a05:600c:444c:b0:41c:83aa:18b7 with SMTP id
 5b1f17b1804b1-41fead6d1c8mr88129635e9.33.1715691955637; 
 Tue, 14 May 2024 06:05:55 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f882086f0sm229763725e9.42.2024.05.14.06.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 06:05:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Marek Vasut <marex@denx.de>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Nishanth Menon <nm@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 6/6] usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for
 End Transfer
In-Reply-To: <20240412202611.3565052-7-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
 <20240412202611.3565052-7-alexander.sverdlin@siemens.com>
Date: Tue, 14 May 2024 15:05:54 +0200
Message-ID: <87o7984k7h.fsf@baylibre.com>
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

Hi Alexander,

Thank you for the patch.

On ven., avril 12, 2024 at 22:26, "A. Sverdlin" <alexander.sverdlin@siemens.com> wrote:

> From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>
> Upstream Linux commit 3aa07f72894d.
>
> If there's a disconnection while operating in eSS, there may be a delay
> in VBUS drop response from the connector. In that case, the internal
> link state may drop to operate in usb2 speed while the controller thinks
> the VBUS is still high. The driver must make sure to disable
> GUSB2PHYCFG.SUSPHY when sending endpoint command while in usb2 speed.
> The End Transfer command may be called, and only that command needs to
> go through at this point. Let's keep it simple and unconditionally
> disable GUSB2PHYCFG.SUSPHY whenever we issue the command.
>
> This scenario is not seen in real hardware. In a rare case, our
> prototype type-c controller/interface may have a slow response
> triggerring this issue.
>
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Link: https://lore.kernel.org/r/5651117207803c26e2f22ddf4e5ce9e865dcf7c7.1668045468.git.Thinh.Nguyen@synopsys.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

I've dropped Greg from the cc list as I understand by [1] that he
prefers to not receives responses on this.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

[1] https://lore.kernel.org/r/all/2024041354-exciting-suggest-b896@gregkh/

> ---
>  drivers/usb/dwc3/gadget.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index c14d7870b9461..debfd4d6781db 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -316,7 +316,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  	 *
>  	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
>  	 */
> -	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
> +	if (dwc->gadget.speed <= USB_SPEED_HIGH ||
> +	    DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER) {
>  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>  		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
>  			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
> -- 
> 2.44.0
