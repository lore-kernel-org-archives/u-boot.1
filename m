Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57D2CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 007CC836D1;
	Thu, 30 Oct 2025 13:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ikHEvUXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11018836D3; Thu, 30 Oct 2025 13:04:46 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D200A83642
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5CCD51091AA; Thu, 30 Oct 2025 13:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761825881;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=M61dnIYL1tUAkH+K+AzBMwIdarskHDlwJr27nl6621Q=;
 b=ikHEvUXg+tW5g9b2+Ug9OqRVwmhW6ZGqx2CLKmQxnqwX6Q8o4FQKeMJieuYL0VlBQV5iHD
 tx+WDe021LFYuto1bJ4v/znJ/H0r//sMx0dpJtsVtcXgayhdnI3gw4ypsD20EFGDhk4oXe
 vgOtrprDyEiPHdqV2i7A13efcE6LV0k9h1Tvh14v9U/rqUNpXZOVDQF1nqML8Twd4+eXz9
 v4lGcdJavo80HtmcPlWKVJksTTgT/Z0SirXfaxyXH5n65tydia2OTuvPn/WfYJtrFnFs7D
 uKV86tKhpqX6arbJtga28j8LvIqJDFdtjb2/yeorfYzNR+IaNHUvxv/pDGqfKg==
Message-ID: <49a5b59c-47a9-1f88-a731-fa90856e27e6@nabladev.com>
Date: Thu, 30 Oct 2025 13:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: rcar_i2c: Add R-Car Gen5 support
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Minh Le <minh.le.aj@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251027163826.11785-1-marek.vasut+renesas@mailbox.org>
 <52939ad9-ef5a-14c4-003b-892b9794c9c8@nabladev.com>
 <3e6cd3f4-c49e-4cad-8b0a-c8ab65251f02@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <3e6cd3f4-c49e-4cad-8b0a-c8ab65251f02@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Marek,

applied to u-boot-i2c.git

Thanks!

bye,
Heiko

On 28.10.25 15:30, Marek Vasut wrote:
> On 10/28/25 6:25 AM, Heiko Schocher wrote:
> 
> Hello Heiko,
> 
>>> diff --git a/drivers/i2c/rcar_i2c.c b/drivers/i2c/rcar_i2c.c
>>> index 3bd5108fd23..9562119bb5b 100644
>>> --- a/drivers/i2c/rcar_i2c.c
>>> +++ b/drivers/i2c/rcar_i2c.c
>>> @@ -368,6 +368,7 @@ static const struct udevice_id rcar_i2c_ids[] = {
>>>       { .compatible = "renesas,rcar-gen2-i2c", .data = RCAR_I2C_TYPE_GEN2 },
>>>       { .compatible = "renesas,rcar-gen3-i2c", .data = RCAR_I2C_TYPE_GEN3 },
>>>       { .compatible = "renesas,rcar-gen4-i2c", .data = RCAR_I2C_TYPE_GEN3 },
>>> +    { .compatible = "renesas,rcar-gen5-i2c", .data = RCAR_I2C_TYPE_GEN3 },
>>>       { }
>>>   };
>>
>> .. I cannot find this new compatible node in U-Boot
>>
>> $ grep -lr "renesas,rcar-gen5-i2c" doc/device-tree-bindings/
>> $ grep -lr "renesas,rcar-gen5-i2c" dts/upstream/
>> $
>>
>> nor in current (v6.18-rc3) linux tree... is there already a patch
>> for linux, which introduces it? But is seems trivial to me, so I
>> am fine with it.
> The SoC and board support was sent separately in
> 
> [PATCH 2/3] arm64: dts: renesas: Add Renesas R-Car X5H R8A78000 SoC DTs
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20251027172219.30437-2-marek.vasut+renesas@mailbox.org/ 
> 
> 
> Linux kernel patches are being prepared, I don't think they are posted yet.

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
