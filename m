Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61525C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E551080214;
	Thu, 16 Jan 2025 10:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fj3V0X19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BCD0806FB; Thu, 16 Jan 2025 10:36:49 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4EA80283
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso10982635e9.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737020206; x=1737625006;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x5/k3yHKfjMFxz0uz8PMO0P5pnqQVgULUySMJc7pFZ8=;
 b=Fj3V0X19ViyxbdZNYl8Ap8c8hu6wtoKupKcPkCDn8hRlbJRR6nAw0E34W95Qcz5fuG
 z3Poj4PXlDtfo7KZiidqceUrqxI7BA2F1OvLddM593r0yAJDgqIUgQe7br5k91PBjm/z
 9MdO7j618sgp8m4hxPdGIKegkAsYgYmInEQ/YJRoh8p8GZKpYKBxxRThHdGIlPeHKb4Y
 qvjvnKS4UYB/BEfAwDIqlBU2exgVKUGaHz7RKGP/2wxFRLxmj27aT4W1y2mbh7bCUh3M
 QPGF7AFMLvRBQyB11+Dbrd0NRYcYb4zmV1sSIjmTGayiya9TkFQ+uy7nicMNRze7rYL+
 gcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737020206; x=1737625006;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5/k3yHKfjMFxz0uz8PMO0P5pnqQVgULUySMJc7pFZ8=;
 b=Ps5ckfRokBng3o9ogbGb4C3IgzwL4E7U9/e/UAyoA7DWFA/+Ej68XWb55b7e+AoofT
 4JPlHJ/0jbJvy1Tfat+zEGS6XY/ilNUEy0D4k5XuwhkJpBGyGUoSbA2xJFPXTl9dyooK
 RJgrHWMSLcRLPE/0ADhE9QWhw7ivdaFQCMc7M/97DxvVjxrH67GogeAGSLkMlAV1NN6m
 fXylsJXr4uY47/XnnXtNnn+ZVNXvEdkZrvlf15JP7DNPrzGMdrc4Cus/c8RXYUVMroqf
 jMny4kzNFtLrFFllAZDUVLChSMaQkrmeepB6q+QfrUoAU2HKtl4lSHK5nQyj8pIbyZDs
 /Zkg==
X-Gm-Message-State: AOJu0YyfBAPlGyAFAEEtxuFZ7WMSNUyNL8WkhSs+zXYJ8dD+IM9dVS3w
 qascA9QjPy2fLDLLrH6QTjbnhJ4DWDRKAcQNbXHVOMOoJ0RIideWjuPrEIPHL1s=
X-Gm-Gg: ASbGncuhaFiAoED+XC2SE8nfAsaM/fkdsQGW/lyUraxc9vyWywK/nKxIZPn0H/Eixrj
 lN31xV3wRQhQtp+D/4eo263dZSVkTV6FQkodkLVtiPvYgqJx+pb40fujF+XQrJS1r56iXvkGY8t
 RJnFsVSMhSjwU2riJi0/nAjwCJ+G6XttAnSUlzCZ5kSd2IsuYAwUTO54YLg+td6D29YLLWQNH0o
 qmTRokHhAeux+oKTLFs713UfuCxFYTKgKo9TVfTWI2QI9UuqpqW4FZCf+g0HL4IJg==
X-Google-Smtp-Source: AGHT+IEr+TAgkTZwWllngP4wj59KwWTSckOAzq0WjRbMI4dOXQk3Ggo9YZQYAWj4Y1X0FDC+R2qgkw==
X-Received: by 2002:a7b:cc06:0:b0:437:c453:ff19 with SMTP id
 5b1f17b1804b1-437c6b4707cmr53777735e9.14.1737020206290; 
 Thu, 16 Jan 2025 01:36:46 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37ce18sm20424162f8f.14.2025.01.16.01.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:36:45 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, trini@konsulko.com, marex@denx.de,
 bmeng.cn@gmail.com, jonas@kwiboo.se
Cc: u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH] usb: xhci-dwc3: Bail out if "dr_mode" is "peripheral"
In-Reply-To: <ceb060fa-d430-458d-b711-508a4bd34d48@kernel.org>
References: <20241206110424.897283-1-s-vadapalli@ti.com>
 <ceb060fa-d430-458d-b711-508a4bd34d48@kernel.org>
Date: Thu, 16 Jan 2025 10:36:45 +0100
Message-ID: <87cygn85hu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Siddharth,

On lun., d=C3=A9c. 09, 2024 at 15:20, Roger Quadros <rogerq@kernel.org> wro=
te:

> Hi Siddharth,
>
> On 06/12/2024 13:04, Siddharth Vadapalli wrote:
>> Since the compatible "snps,dwc3" can be specified in the device-tree for
>> the Designware USB Controller configured for not only Host and OTG modes
>> of operation, but also for Peripheral mode of operation, bail out if
>> "dr_mode" is "peripheral".
>>=20
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>=20
>> Hello,
>>=20
>> This patch is based on commit
>> 448add55297 Merge branch 'master' of https://source.denx.de/u-boot/custo=
dians/u-boot-pmic
>> of the master branch of U-Boot.
>>=20
>> Regards,
>> Siddharth.
>>=20
>>  drivers/usb/host/xhci-dwc3.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
>> index e3e0ceff43e..7b1311503fe 100644
>> --- a/drivers/usb/host/xhci-dwc3.c
>> +++ b/drivers/usb/host/xhci-dwc3.c
>> @@ -208,6 +208,9 @@ static int xhci_dwc3_probe(struct udevice *dev)
>>  	writel(reg, &dwc3_reg->g_usb2phycfg[0]);
>>=20=20
>>  	dr_mode =3D usb_get_dr_mode(dev_ofnode(dev));
>> +	if (dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)
>> +		return -ENODEV;
>> +
>>  	if (dr_mode =3D=3D USB_DR_MODE_OTG &&
>>  	    dev_read_bool(dev, "usb-role-switch")) {
>>  		dr_mode =3D usb_get_role_switch_default_mode(dev_ofnode(dev));
>
> Although this proposal was suggested in [1] and later clarified in
> [2] I will summarize the discussion here.
>
> This patch fix is not sufficient for all cases as the xhci-dwc3.c
> driver will still be probed if dr_mode is OTG or HOST along with
> other platform drivers if enabled in config.
>
> The only current solution is not not enable CONFIG_USB_XHCI_DWC3
> together with another platform driver config (e.g. CONFIG_USB_DWC3_GENERI=
C)
> if snps,dwc3 should not be managed by xhci-dwc3.c.

Given Roger's explanation, should we simply drop this, or is any other
action expected from the U-Boot maintainers?

Thanks,
Mattijs

>
> [1] - https://lore.kernel.org/all/unf757pwgah5ylkcfdumtdo5zs2ny3nxct5u26t=
6up7aldqim2@mxhhtb53gw4x/
> [2] - https://lore.kernel.org/all/a9c458f8-68e5-448b-9977-e7bf37b00d35@ke=
rnel.org/
>
> --=20
> cheers,
> -roger
