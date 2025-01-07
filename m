Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7F9E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B62FA805D5;
	Tue,  7 Jan 2025 10:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j8TOa2YE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8367B8036B; Tue,  7 Jan 2025 10:55:09 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0329801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43626213fffso94629475e9.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 01:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736243705; x=1736848505;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yLpV3ArsHhWotqjFSAutSsi6kUDrWzmo6cgLhMfmZyA=;
 b=j8TOa2YE3hG7VE1+SdAf0TIeP1jU+XjOV5IGX6+WohtK4wYRVyphN6jeYU9uQXPEog
 JKwznKz2Sk9aZ3aZ/W5QLHA6AUmHR5LZZUrCMmeLAOw34Q04aQh0fpEg/gyua3vFIXae
 X7l1xMQQf3WWpOjsYShFY94OgvAJYyK2iA79jqHK7OVHC5YP+QJlDkpOdW3iv83smb4x
 LteVIqlLX+gzyGDspfm8BntUU5wHjN2cP/RU61ATFHfhQlsdkPcZ72fU90fmrSGkiGIe
 qZg/Nw5tE1/3uHNyXe3D3yNK5LCipjKNZYWDvPieLhKez0REUiatfRRRSwlmlzFqZwCn
 XjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736243705; x=1736848505;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yLpV3ArsHhWotqjFSAutSsi6kUDrWzmo6cgLhMfmZyA=;
 b=cUBRWDHcYaZTIaTQhikhIUguAvMhekZqcYxSzegUbyDqR5fJZYyfTCkYEkahNclpFU
 5dqnAVdJcXnDmz7hiZmA5WQktv6I7pCN9txeHRApRKMIGeWUplnFC9PN+H2KCn5nV3do
 DtVIullc7r1SLaYadAldGeLZQ57kWv6Y27wY2QV9DJVUjghMXbuFOfO0ZsWvZfBbPcjb
 ZHwG9yA7tMsEibl1GFWLuyQ+bL4Fz9w7kUAG87Xu1m6IbDkuDjsBzRM51AAF1PqtaLOD
 7/HmTkBydBvqbChwdfaLKJdIAbHyLVfUEav4zt6PTE/PsGDFa14Jsnrdr46315wQ3vOQ
 ohjA==
X-Gm-Message-State: AOJu0Yz4geyuHG1Td/aI1aTBL/LNaycm+Oj3IbOoB7yPISSzHvaAO2kX
 4INdZNGbnLeotZnsbukB2xxDS3OyvRtNkWg/uJ6OtS6lvHJamKgxP8faeHevrDQ/4L+rzTwEHRK
 7
X-Gm-Gg: ASbGncvHJjfH3nank1Ix4Fqu478IewgryPc6VgBRHitWCackUiN5ETQjUN0lmiTlV02
 jCzGOzrVd+kIeG0dLOuh+lCs8e9T89JPEhEWx1bdoUHRRzMQRyE6UXvXvBwIS8c1THzb1e85XjT
 zvTjAf9iZdI8fXu0cDjhBlqoq2STsTe/wcT0xrnuRMsi27wBIcBleQItzKkQbLJqyy2kkNS51Ld
 GcnxJCyBfvnJFZ4G1L1uEt+tBnAiCgBNsmh1bpN42b9+mMgc53OHZu7OVKDlKh7jA==
X-Google-Smtp-Source: AGHT+IFkj8eR8da7Vn+Z8VLSc8IDaXSnAlu/2s76G70wlpA8COV+DozfRIt/4QhNXOSHtoSnShiodw==
X-Received: by 2002:a5d:6c6b:0:b0:38a:5d83:2110 with SMTP id
 ffacd0b85a97d-38a7913bd06mr1658063f8f.13.1736243705454; 
 Tue, 07 Jan 2025 01:55:05 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e43dsm50793114f8f.70.2025.01.07.01.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:55:04 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com,
 junhui.liu@pigmoral.tech
Subject: Re: [PATCH v3 6/8] usb: dwc2: Extract macro definitions to common
 header
In-Reply-To: <20250104-dwc2-dev-v3-6-d4b2bc1996e4@pigmoral.tech>
References: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
 <20250104-dwc2-dev-v3-6-d4b2bc1996e4@pigmoral.tech>
Date: Tue, 07 Jan 2025 10:55:04 +0100
Message-ID: <87h66bc5jb.fsf@baylibre.com>
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

Hi Junhui,

Thank you for the patch.

On sam., janv. 04, 2025 at 11:37, Junhui Liu <junhui.liu@pigmoral.tech> wrote:

> From: Kongyang Liu <seashell11234455@gmail.com>
>
> Some macros are shared between host and gadget code, causing duplicated
> definitions. Move DWC2 macro definitions from host and gadget code into a
> common header to reduce duplication.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/usb/common/dwc2_core.h         | 430 +++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/dwc2_udc_otg_regs.h | 160 +-----------
>  drivers/usb/host/dwc2.h                | 291 ----------------------
>  3 files changed, 431 insertions(+), 450 deletions(-)

[...]

>
>  #endif /* __DWC2_CORE_H_ */
> diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dwc2_udc_otg_regs.h
> index 6aec55970db682ef8a21fad0b47144a4a87a47ca..d27b2f6187ff35991bbbc05d97b6063117b082f0 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
> +++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h
> @@ -10,65 +10,7 @@
>  #ifndef __ASM_ARCH_REGS_USB_OTG_HS_H
>  #define __ASM_ARCH_REGS_USB_OTG_HS_H
>  
> -#include <linux/bitops.h>
> -
> -struct dwc2_usbotg_phy {
> -	u32 phypwr;
> -	u32 phyclk;
> -	u32 rstcon;
> -};

This structure definition gets removed but is still used
in drivers/usb/gadget/dwc2_udc_otg_phy.c. See otg_phy_init() for example.

Is that intentional ?

> -
> -/*===================================================================== */
> -/*definitions related to CSR setting */
> -

[...]

>
> -- 
> 2.47.1
