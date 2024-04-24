Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38858C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 13:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792C08874A;
	Wed, 24 Apr 2024 15:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s00JwrBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC8E8874A; Wed, 24 Apr 2024 15:25:13 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE7D588709
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 15:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d895138d0eso54396131fa.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713965110; x=1714569910;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vPjbd0lOGp227cV/e1bmJS+GK8ABEts9Hnffk99sKM0=;
 b=s00JwrBlnCdpUVVa+xTTCnK2S/+0MdnD6q0aWBvI4GDbZYYIGqr4szv5nMT2sA1fvw
 4E2/zjWXR0GKDNDyxWUISG/x3gtSCvE0zi84D61V+KFWOZOTWrtg6OoKAJKnoYXMDeM1
 aqD9kRXRV9h1CPn4LA3aUF4ijKkOwvYA4vqwhK/kc2D1+VIZaMpAgtsLeHuepysjj8yc
 AsWkfHS103x1rinM9FnV/ggV9qfINZvEzQPzyLcPOP8lRyqvrabxxB8PQbRIId+fELlB
 pbjh5pdp9uDcr7uas3/79LBFAt6t0JoS4rbxIvqcqx98GTu7ISrRqnLtJqTLA6XmX90a
 ZZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713965110; x=1714569910;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vPjbd0lOGp227cV/e1bmJS+GK8ABEts9Hnffk99sKM0=;
 b=Yb3wX5UXJFNy9+PB/wTaEAlW1LeMe9S4VzfMV6eTPdDe2aTx6oYlDqh97c2Rdzj2vN
 ysdGkj/uZ0ft3TGRD8r9gPJXEIJfyN3nU9brYvt9ptPZkxWjIbDmu1bgKBt7F5u46wLA
 IM8WEMCplszw8YLjoBsRE3NnyBup7ZcepMVpHO0ZfBrUAl3Rx2X6FV4M7lfH1ZthX0aC
 qMKsl/CSRgjnIDIvk1pi2rb35/CgSQv8u2zmzefgjdAxjNo8YzaYRDxT+Egh7NBZktPV
 5BZwlvz1CmeJwr+qtGmblY4wttjrkSXNXcjPT3f2f3dNhoEy/WhhNKIB/yOLZP7p4MFp
 0axQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYwM6JVWA2zU0WtTApJlOz95dzbWl3x9Ra8bTo4JLD1r0S4astknR36ltUz1Y7QdfBqQq+T74MyAJL9pvxa7Zlq76w3g==
X-Gm-Message-State: AOJu0YxWXOOsAjStI01F6JDGxp/RzQyZfkaNDIXtTS5ah7tp1fKcYnQb
 h4nhhfiJnV5hJPgOAThfIATVqf/xNBuC/DNqF9F33+5cF1xSXG4sclk2iHIdhMo=
X-Google-Smtp-Source: AGHT+IHoKWySvwUrka8cl4DcK0FQqAPDaJ1W1gTJ5z3FygjMvcbYOyGCLHn51g52K0ERyXD97OXfIA==
X-Received: by 2002:a2e:7018:0:b0:2d6:f69d:c74c with SMTP id
 l24-20020a2e7018000000b002d6f69dc74cmr1453158ljc.38.1713965109880; 
 Wed, 24 Apr 2024 06:25:09 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c4e9100b004182b87aaacsm23895921wmq.14.2024.04.24.06.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 06:25:09 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 trini@konsulko.com
Cc: rogerq@kernel.org, u-boot@lists.denx.de, pawell@cadence.com,
 peter.chen@kernel.org, srk@ti.com
Subject: Re: [PATCH v3] usb: cdns3: gadget.c: Set fast access bit
In-Reply-To: <62b2703f-13e4-4609-9fd6-552caa5bef91@denx.de>
References: <20240424073911.1943-1-r-gunasekaran@ti.com>
 <62b2703f-13e4-4609-9fd6-552caa5bef91@denx.de>
Date: Wed, 24 Apr 2024 15:25:07 +0200
Message-ID: <874jbq99l8.fsf@baylibre.com>
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

Hi Ravi,

Thank you for the patch.

On mer., avril 24, 2024 at 14:15, Marek Vasut <marex@denx.de> wrote:

> On 4/24/24 9:39 AM, Ravi Gunasekaran wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>> 
>> When the device port is in a low power state [U3/L2/Not Connected],
>> accesses to usb device registers may take a long time. This could lead to
>> potential core hang when the controller registers are accessed after the
>> port is disabled by setting DEVDS field. Setting the fast register access
>> bit ensures that the PHY clock is keeping up in active state.
>> 
>> Therefore, set fast access bit to ensure the accesses to device registers
>> are quick even in low power states.
>> 
>> commit b5148d946f45 ("usb: cdns3: gadget: set fast access bit") in the
>> upstream kernel is taken as reference.
>> 
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>> ---
>> Changes since v2:
>> ----------------
>> * Updated the commit description with reference to upstream kernel commit
>> * Picked up Marek's Reviewed-by tag from v2
>> 
>> Changes since v1:
>> -----------------
>> * Rebased to tip of -next
>> * Added Reviewed-by tag
>> 
>> v2: https://lore.kernel.org/all/20240423082420.32336-1-r-gunasekaran@ti.com/
>> v1: https://lore.kernel.org/u-boot/20230505121353.23486-1-r-gunasekaran@ti.com/
>> 
>>   drivers/usb/cdns3/gadget.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 7aa0c6b2be..d11175dc5b 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -2325,6 +2325,9 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
>>   	writel(USB_IEN_INIT, &regs->usb_ien);
>>   	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
>>   
>> +	/* Set the Fast access bit */
>> +	writel(PUSB_PWR_FST_REG_ACCESS, &priv_dev->regs->usb_pwr);
>> +
>>   	cdns3_configure_dmult(priv_dev, NULL);
>>   
>>   	cdns3_gadget_pullup(&priv_dev->gadget, 1);
>> @@ -2383,6 +2386,7 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>>   
>>   	/* disable interrupt for device */
>>   	writel(0, &priv_dev->regs->usb_ien);
>> +	writel(0, &priv_dev->regs->usb_pwr);
>>   	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
>>   
>>   	return ret;
>> 
>> base-commit: bc39e06778168a34bb4e0a34fbee4edbde4414d8
>
> Since this is gadget stuff, +CC Mattijs , that should go through their tree.
>
> Thanks!

Thank you Marek for CC'ing me, I missed this patch.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
