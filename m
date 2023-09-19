Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE992CD5BD3
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6C486A84;
	Tue, 19 Sep 2023 17:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOf85Eg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8CA986A94; Tue, 19 Sep 2023 17:14:39 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B408864A7
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52c88a03f99so6736935a12.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695136476; x=1695741276; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OY/2HnIB276O/WTAh6rASsd+ItrhmOR4Q2+FFayEMlE=;
 b=YOf85Eg93P65/S0bQuQLqO0XbdMv2BvyIIhkniXMaFnD/oHu+k2yAf3jIbybLMoGLI
 TLOwAgdZHpXbFCy91KYuTw7J5B9j0eeiukkOiGTWEUhUG12FawB3fHV3xqYZAwdOgGOj
 2dcnHof2pMXo+tFr51e5fINuxYd8MaMRwULXN3hGbF0dMy63zGTY4W8aJ/S4F2quF9F5
 9NHwll1R4h8PAn/QwPm5eoCUYwKDU+IJrQTMxC3X13FTGy3iC7/MV+x+PhxAhhOxT44a
 2haclzsKfalbj9/Dzue9YtlG3up8X2Ag3+xzRcfS9GZt3TxnZqyT1P/qKHsXFF5AgjTD
 gYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136476; x=1695741276;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OY/2HnIB276O/WTAh6rASsd+ItrhmOR4Q2+FFayEMlE=;
 b=XLbVMQojx44wn8Zv59lCiblCiFCGYsYLtt1LXOgSOjmWyc76kO/cf3A3EFjRF2ZKNV
 iPySZ9CDYtVzor5B6IyvE72At4DVB+HD42N0ohHC7oHNfWDBTr3ljmjKYYTAKwbtVLUq
 DxMqCta4F8dY10odlQrQrmgzIEsCGepAlS0YaiPOvvPHHpZ3W/7Av5lLFVHRFS6uHrTa
 T+2jUba3422YzcavPdVXUnGuOy5lwP0jzwtXrcFpAfGLUN20YzRue+QbPSkxyOZ0FGbH
 TeWFsvOR7IO+EOQjDTBWmXbstmSyBejofLgK+/SnxuH7r2Yq+N/cq6ZEK5zZyO1zw0fK
 t5dw==
X-Gm-Message-State: AOJu0YzAMKLYQIFy/xEuDOkGYxd/uTDW6TltGQgY0k9gme4z9p2vDR44
 irPfBDqXfPhvuDOGcr6r+Gk=
X-Google-Smtp-Source: AGHT+IGeuoke7MEEPdTABJGmEFpidUZY4LquhvdqQs/mMUoLMVrBcSv+gXnHk20Dxil5mvMtv2RuPA==
X-Received: by 2002:a05:6402:f1b:b0:530:ccf7:37af with SMTP id
 i27-20020a0564020f1b00b00530ccf737afmr8664422eda.12.1695136475925; 
 Tue, 19 Sep 2023 08:14:35 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 by6-20020a0564021b0600b0052a198d8a4dsm7409444edb.52.2023.09.19.08.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 08:14:35 -0700 (PDT)
Message-ID: <d34d4de5-b9c4-648a-ba5f-cd6828194d78@gmail.com>
Date: Tue, 19 Sep 2023 17:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] rockchip: include: asm: fix entering download mode
 rk3066
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <183eaaad-ef37-22a2-f041-a32e499c7f88@gmail.com>
In-Reply-To: <183eaaad-ef37-22a2-f041-a32e499c7f88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

It looks as if all the TABs are gone.

Will resend.

Johan

On 9/19/23 16:57, Johan Jonker wrote:
> Keep track of the re-entries with help of the lr register.
> This binary can be re-used and called from various BROM functions.
> Only when it's called from the part that handles SPI, NAND or EMMC
> hardware it needs to early return to BROM ones.
> In download mode when it handles data on USB OTG and UART0
> this section must be skipped.
>
> Unlike newer Rockchip SoC models the rk3066 BROM code does not have built-in
> support to enter download mode on return to BROM. This binary must check
> the boot mode register for the BOOT_BROM_DOWNLOAD flag and reset if it's set.
> It then returns to BROM to the end of the function that reads boot blocks.
> From there the BROM code goes into a download mode and waits for data
> on USB OTG and UART0.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
