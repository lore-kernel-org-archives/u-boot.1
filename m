Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE88C02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 10:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1D2801B0;
	Thu, 16 Jan 2025 11:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u9AdWi19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A77F8033D; Thu, 16 Jan 2025 11:28:28 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE9180040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso11342275e9.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737023305; x=1737628105;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pAbEYJaHBlQrr0Akem3vZ8/CQ7ImIU0CpU/UgEk2MEE=;
 b=u9AdWi19LuZ9ifoEOAW/Lued8oGlXlObWkATr323/6leRRLgAaj1VovkFcHVt2t1CW
 DKVtQOgpZKQdx1ODD0EfvtN/6fDYq7YAi48lYqXLn/3GQev/UcRu6HiV5y3oWda+3BKK
 aXOPYS6G0YjUOosQ5vzNquTw310YUlGODwqc6mY2OJteTD5BAdRXZSABFugvfaXkl3ra
 JrnS+bgGwlWQQaffjzvnZNJ0Ww6eTKqfooYcnN0ED6qzQCpfuFfkB2fXN8WJpVUUM7Vg
 0IYmwTY41CHTB5xT6p5pAcdPqnecNr7YSozIVpNtj71i5AHvOhjK5JrVp/G1KiDQ7uCv
 j1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737023305; x=1737628105;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAbEYJaHBlQrr0Akem3vZ8/CQ7ImIU0CpU/UgEk2MEE=;
 b=W0MrU2qlvH8RLxPTR+uarbGzzD05GyAxl+D5V0NOctMHiM/zhwgupZciC+epRUdxXP
 kZb9N8BFhrQFunNlF/DDUcE6RH6rEQBqjTXtG80iA9USTcL+pMyFBmicX7RyrG8QLXGF
 YNQRhp0V7eLRtUEF4YIJYT+bQuSZuMf5Qs/yAQVwLOkE4TuEhJzoSo4UA9xFdLMsBU6O
 +mND9CLI9Av+rvyFmlpf0BNjlbejqN5DlYHI6BxmV6EVIR76bhzvfKZEKLjeADQtSZ95
 8xCETu+BsWx2oeNtOB1duSFXzZiKdyFHF2vLttm4xWLJ5z5bmZAiNj28939R4v9j0Kpr
 gvmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3jIKoNK1eTLbbKgdsZ4jMaMYk7vr3w++Vb2UC6nxTMmnRJXLuAtWYGNxaEpxp6y2dvtRQGVA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywcwkm94d9H6kDVFWMBrPZoFRnbGJaJG73xPUq2nh+74NMlyYQx
 vtgR+TUHbvY1OdU5BBQbRXWnbnnm/wui8XifAWBUOIsWZxnWq6QQxjK8lVWQfKY=
X-Gm-Gg: ASbGncvCKqAoocJVgPUhBgHyoyVOcHDwutPgVXBXbk67PPVozwt2+RwRLEr97KZuYkb
 oIheBBPlXPqv0DEucsOLNEDxN5LVhI7HdZTURN6QxOIxMHlRuD+ePBM0E70Q1aW6bqHWT/lakqN
 WQSkiXkr/Ye3MlxOo0/NlplR3jlDFLzA5TNjM/+b+L0AFBlH+hTsn+/oHkuOa0qCLYtajOF4Mil
 4p9AVZMpd2CD43kPcoq3N3IP5Y4hSQfR8Uuqut4uEOguIcOZ/PMMyLSt0K1lXPaow==
X-Google-Smtp-Source: AGHT+IGgJW603lzqW2SqiAjLVNegSB9ZeAIOBM/vRB0QBawa9ACRA6vu5mYOp5c1JgD/KQpC2TB7kQ==
X-Received: by 2002:a05:600c:4f54:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-437c6aecbf0mr54157095e9.1.1737023305402; 
 Thu, 16 Jan 2025 02:28:25 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7527fd1sm54953905e9.31.2025.01.16.02.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 02:28:25 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, trini@konsulko.com, marex@denx.de,
 bmeng.cn@gmail.com, jonas@kwiboo.se, u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH] usb: xhci-dwc3: Bail out if "dr_mode" is "peripheral"
In-Reply-To: <mjtlqk7ddt7mjxu62vl3fpizhu5djemaodlpuprh2dp2kfukwh@y4vyhmxfbdxm>
References: <20241206110424.897283-1-s-vadapalli@ti.com>
 <ceb060fa-d430-458d-b711-508a4bd34d48@kernel.org>
 <87cygn85hu.fsf@baylibre.com>
 <mjtlqk7ddt7mjxu62vl3fpizhu5djemaodlpuprh2dp2kfukwh@y4vyhmxfbdxm>
Date: Thu, 16 Jan 2025 11:28:24 +0100
Message-ID: <87v7uf6ojb.fsf@baylibre.com>
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

On jeu., janv. 16, 2025 at 15:48, Siddharth Vadapalli <s-vadapalli@ti.com> =
wrote:

> On Thu, Jan 16, 2025 at 10:36:45AM +0100, Mattijs Korpershoek wrote:
>> Hi Siddharth,
>
> Hello Mattijs,
>
>>=20
>> On lun., d=C3=A9c. 09, 2024 at 15:20, Roger Quadros <rogerq@kernel.org> =
wrote:
>>=20
>> > Hi Siddharth,
>> >
>> > On 06/12/2024 13:04, Siddharth Vadapalli wrote:
>
> [...]
>
>> >> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc=
3.c
>> >> index e3e0ceff43e..7b1311503fe 100644
>> >> --- a/drivers/usb/host/xhci-dwc3.c
>> >> +++ b/drivers/usb/host/xhci-dwc3.c
>> >> @@ -208,6 +208,9 @@ static int xhci_dwc3_probe(struct udevice *dev)
>> >>  	writel(reg, &dwc3_reg->g_usb2phycfg[0]);
>> >>=20=20
>> >>  	dr_mode =3D usb_get_dr_mode(dev_ofnode(dev));
>> >> +	if (dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)
>> >> +		return -ENODEV;
>> >> +
>> >>  	if (dr_mode =3D=3D USB_DR_MODE_OTG &&
>> >>  	    dev_read_bool(dev, "usb-role-switch")) {
>> >>  		dr_mode =3D usb_get_role_switch_default_mode(dev_ofnode(dev));
>> >
>> > Although this proposal was suggested in [1] and later clarified in
>> > [2] I will summarize the discussion here.
>> >
>> > This patch fix is not sufficient for all cases as the xhci-dwc3.c
>> > driver will still be probed if dr_mode is OTG or HOST along with
>> > other platform drivers if enabled in config.
>> >
>> > The only current solution is not not enable CONFIG_USB_XHCI_DWC3
>> > together with another platform driver config (e.g. CONFIG_USB_DWC3_GEN=
ERIC)
>> > if snps,dwc3 should not be managed by xhci-dwc3.c.
>>=20
>> Given Roger's explanation, should we simply drop this, or is any other
>> action expected from the U-Boot maintainers?
>
> This patch could be dropped. Roger's suggestion is to fix this issue by
> updating the platform configs wherein CONFIG_USB_XHCI_DWC3 should be
> disabled on platforms that have "dr_mode" set to "peripheral".

Thank you for confirming.

I've marked as "Handled elsewhere" on patchwork:
https://patchwork.ozlabs.org/project/uboot/patch/20241206110424.897283-1-s-=
vadapalli@ti.com/

>
> Regards,
> Siddharth.
