Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96D1CE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 09:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5779889189;
	Tue,  1 Oct 2024 11:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iDukCf7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B9AF8914D; Tue,  1 Oct 2024 11:01:52 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC8B89174
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 11:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5389917ef34so6040620e87.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727773304; x=1728378104;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hdS5sBp7EdFS1tZlbphIgO5jfojQ504tZQ8RE8eB3Pc=;
 b=iDukCf7ebx1Dxw5FF2Af0IBZ58KqvSJFuaD5gWFnAPdKC8XT8rAEef7kwm5tCRjvou
 BIh9cDF8GH7OJQtzYcDMP0hmnLOgN4WZmSydOViCP0iBzuuGDGrx2pItxiQ1YWU06iQ6
 W1ZDq2VwH9wR0PZNw663gUZWebVN6I6RlQxCiD+nr4iNxN74nGYzPclNhMtkOG+2mdzt
 Lh7E/JR00LVnetv34+b7wjUvxeerHX4he8ycSfpVUYbrQq9fl5zoM+6TUPs4R4TwU4M2
 0TB4gfxkS1qsOlK/d+wANfOr0aB70scuseCQGyPYTqgP44C9iwmhQzSpO1Lju0eOqeSm
 0swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727773304; x=1728378104;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hdS5sBp7EdFS1tZlbphIgO5jfojQ504tZQ8RE8eB3Pc=;
 b=Vck979AuKeAWbU1s4Wmnxp7JyhOfCTs1KjN4by5tkmLfBLPV+wtnGrOPo1/YuPV4iX
 BWgIvOxzZqPaCBa6fNbYD40ccMWvCUGJsIv9queY1qGyeC6dCvKQc6W8LkVHzy8hBWys
 +kg1K45v7UiOFtUa44g7lX2aPyxUNTE/DrR+Q4Uu24VltKpl3OPRcDMDUn4Vd4nlOC1y
 RFQPLVbxNRv05mSWx6ethkLRRnatHrFZJ/gxQms5Pb3KMJWO+7Ln9GuoHuMSliv0YAmT
 hhxJz32fzkR1eUEkm5W8exM0OWUfUUFU4ZdjWjnTHitgPO9WnoY4SuMd4jj7WWI9GgAn
 ckbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/xr2JVaeEgeich+uKQXPo05ZZ1f4sxFV0xsHa/eWgCwgM/XxVHywF1NaHkUocVtSmM+EyeZM=@lists.denx.de
X-Gm-Message-State: AOJu0YyU6omrY2OFQVbxlnCy/CDgCpZBiv8E1IVqrjbDuw1MjL7j2Zy6
 NIzLaewCJQF9yNHBuRV2l/yncxgOwe47biJEdiXnmvY4ljvNATK8LpgHwbXiKEA=
X-Google-Smtp-Source: AGHT+IFupMAnX2AB2RSro7EzihhMB2xcA6CK/mfEYTJHj2RZEf55ZpnQeuVhts63wwLixVoRtDtpBA==
X-Received: by 2002:a05:6512:3d93:b0:536:a695:942c with SMTP id
 2adb3069b0e04-5389fc29ca0mr7888628e87.7.1727773304033; 
 Tue, 01 Oct 2024 02:01:44 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a54db9sm173906065e9.42.2024.10.01.02.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 02:01:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Lukasz Majewski
 <lukma@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies
In-Reply-To: <20240921092050.9260-1-heinrich.schuchardt@canonical.com>
References: <20240921092050.9260-1-heinrich.schuchardt@canonical.com>
Date: Tue, 01 Oct 2024 11:01:41 +0200
Message-ID: <87ikucci2y.fsf@baylibre.com>
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

Hi Heinrich,

Thank you for the patch.

On sam., sept. 21, 2024 at 11:20, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> CONFIG_USB_GADGET_DOWNLOAD depends on CONFIG_USB_GADGET.
> It is sufficient to depend on the prior.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  cmd/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 4ccb0cef390..02b2569e713 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1685,9 +1685,8 @@ config CMD_ROCKUSB
>  
>  config CMD_USB_MASS_STORAGE
>  	bool "UMS usb mass storage"
> -	depends on USB_GADGET_DOWNLOAD
> +	depends on BLK && USB_GADGET_DOWNLOAD
>  	select USB_FUNCTION_MASS_STORAGE
> -	depends on BLK && USB_GADGET
>  	help
>  	  Enables the command "ums" and the USB mass storage support to the
>  	  export a block device: U-Boot, the USB device, acts as a simple
> -- 
> 2.45.2
