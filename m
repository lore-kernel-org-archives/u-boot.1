Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF4C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 14:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00A7580584;
	Wed,  4 Jun 2025 16:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="wB2q2tH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D0D81E72; Wed,  4 Jun 2025 16:10:17 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160918070C
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 16:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-32a63ff3bdfso56697411fa.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1749046214; x=1749651014;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PUGb1zK+ThkpFEVHlex6qRblXBh2QTdAJDi79j8L+Bw=;
 b=wB2q2tH4V5lX8YlTp931DRw6eSKnlU9pxeOBYnFYKOpuukS47tECz7vYRlVcaP1f/f
 9pBmT7OLKt/dFb59InK2hbzVkgktKxypLhPi/N8XqPUH439rKV7uAWvaBSyg9tyN62FC
 v0ULJ5qUpNhY0l6mrXVDVA4G9hxMpVvNrJFIbTUbqwN4/ep0B30nOpnehdH8JwDrbLsO
 jad9Tt/j++pgT7sikASrGMheMqorkytNAIqb/MAgaeaKQbvks8RGQqKIzHUC8evDrqq4
 HzrlBBP6SAkGrHeLnbyEGWLixfW8/WeA6VakdxvkWRFICI3ca61sae2dCOx0BePeXt8D
 xfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749046214; x=1749651014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PUGb1zK+ThkpFEVHlex6qRblXBh2QTdAJDi79j8L+Bw=;
 b=OgE6wVijW03oYSeeg2mS/+S6K+Y2IkoRAl7Q9DRbvBs44meC1JwABppYMvPChqB47b
 QMUKYltHypTm/HI8LDl+HDnPQaa68gT2Si0JVsxNCTZI8DOUDEx0z85fzJGagO8VE4VN
 M0z+Vuxvb/XobZNbwoIO2v0uyP9pr68oO1sMXq6qvcguOhRDvzhKIHbC0xlFKZK88o8K
 gM6yL/Awzb1RmUE1zeP1Mb0G14HZ9IiwOcBWzYiUJOpIynusmkuOsCuCD3WZRSlEKWyc
 yh2KOhmvhX1DiIukGnNoVN2eEvPsvTFIo0WF787WA0PhAYDUuCGDHvsTbLhgHgqeym8q
 GqUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDsX5psvi8tFtgNaFYH1x1fvOn3alZWSS3akOwMPU3MePadpoP9bHSIxFEh5OyebPnrBX5xEE=@lists.denx.de
X-Gm-Message-State: AOJu0YzeqFTpWL5M1nEghXV27erSNvN+B8U/q7WloOK7mWegoSfBqRuD
 z+HhwxUvdTyCaS5whQ73NmZU3P+Q5r5cjxzX5kZaijjZbxiqv45xymbhPAoo0z6oVeTCzVbw3Ua
 Pq4XSfqT8mnf9JXRBBdb5LuY0peLmkvBOIN7FWoDZ0w==
X-Gm-Gg: ASbGncs3MQblLBY8iZNw82A0wA0KpfYpBVczQqIQ4ya97gwsGhcQes/KWulsq3Omge+
 BhVQ+tso2ldD4KMUx8NF8lUdKJMXGx6PY/LcQTImelzxLAE0WB8AJYQkgBVxMnYwg+UlQI28ous
 ZBwPt54+Yz1h2W0gS0hvIER1kVMvbjY0K9
X-Google-Smtp-Source: AGHT+IE2Jlt+85e0sr9lnX+AZP3rLtakUz72ITGMoEJI0QwdgcDieWrEe3jJVHHxNndJnhXYKoCsT42kEvjETq7xSHE=
X-Received: by 2002:a2e:ad89:0:b0:32a:778d:be76 with SMTP id
 38308e7fff4ca-32ac7268bfbmr10163401fa.26.1749046213944; Wed, 04 Jun 2025
 07:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
 <87iklbuddu.fsf@kernel.org> <dd3a3cad-75df-43b7-862f-a51cacda3de6@linaro.org>
In-Reply-To: <dd3a3cad-75df-43b7-862f-a51cacda3de6@linaro.org>
From: Zixun LI <admin@hifiphile.com>
Date: Wed, 4 Jun 2025 16:10:06 +0200
X-Gm-Features: AX0GCFuYIeto-10NjSqw2ClHBXu4a2CKphmGP9lQFucKR0Ecm3SDDpLPKLxk6FU
Message-ID: <CA+GyqeaPEiwu7b3E-Gm+QMntGgcAVufAhy3jXZ4DzL9O9GANLw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Mihai Sain <mihai.sain@microchip.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 04 Jun 2025 16:49:31 +0200
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

Hi all,

The case has been reported with No.01589331.

In brief line high-impedance is not observed when both PULLD_DIS &
DETACH bits are 1:
- In unenumerated state (no cable attached) DP is still pulled up
- In enumerated state, disconnection is not detected by host [1] [2]
only by [3].

The test has been done in 3 ways on SAM9X60-Curiosity and AT91SAM9G25-EK boards:
- Modify UDPHS_CTRL on u-boot-at91 with mw command
- Modify UDPHS_CTRL on
linux4sam-poky-sam9x60_curiosity-headless-2024.10 with devmem2 utils
- On linux-mchp 6.6, comment out gadget_udc_start/stop in
soft_connect_store() of drivers/usb/gadget/udc/core.c,
leaving only gadget_connect/disconnect. Then run echo disconnect >
/sys/class/udc/500000.gadget/soft_connect

Host used:
1. AMD Ryzen 5800H native port, Linux 6.14
2. Intel i7-8750H native port, Windows 10
3. Genesys GL3523 hub attached to [1]

Zixun LI

On Jun 4, 2025, at 11:51, Eugen Hristev <eugen.hristev@linaro.org> wrote:
>
>
>
> On 6/4/25 11:20, Mattijs Korpershoek wrote:
>>
>>  Hi Zixun,
>>
>>  Thank you for the patch.
>>
>>  On Mon, Jun 02, 2025 at 17:45, Zixun LI <admin@hifiphile.com> wrote:
>>
>>  I'm surprised that checkpatch.pl does not catch this, but the subject
>>  (title) is too long (it should be less than 70 chars):
>>  https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit-message-conventions
>>
>>>
>>>  Contrary to the datasheet, setting both DETACH and PULLD_DIS bits to 1
>>>  does not always drive the DP and DM lines to high-impedance. This
>>>  prevents the host from reliably detecting a USB disconnect and subsequent
>>>  reconnect.
>>>
>>>  The symptom is that the first gadget command (e.g., dhcp) succeeds, while
>>>  subsequent commands (e.g., nfs) fail.
>>>
>>>  Disabling and re-enabling the controller entirely, instead of toggling the
>>>  PULLD_DIS bit, reliably generates a disconnect event.
>>>
>>>  The Linux driver works correctly because gadget_disconnect/gadget_connect
>>>  are always followed by gadget_udc_start/gadget_udc_stop. In U-Boot
>>>  pullup() is used solely.
>>>
>>>  This behavior has been observed on the SAM9X60-Curiosity and
>>>  AT91SAM9G25-EK boards and has been reported to Microchip.
>>
>>
>>  I'm not against this, but the driver supports multiple gadget
>>  families according to the compatible.
>>
>>  I'm wondering if this issue is reproduced on other atmel
>>  boards that are supported in U-Boot.
>>
>>  Eugen, have you noticed the above limitation on a different
>>  board family that you maintain?
>
>
> I have not seen this before, or don't remember about it.
>
> Adding Mihai from Microchip team to see if we can get more info, whether
> this is a general gadget thing or it's specific to these chipsets. If it
> was reported to Microchip it would be interesting to see the response.
>
> Eugen
>
>>
>>  If this issue is chip specific, I think we should test for compatible in
>>  usba_udc_pullup() to only use USBA_ENABLE/USBA_DISABLE for this
>>  particular compatible (microchip,sam9x60-udc).
>>
>>>
>>>
>>>  Signed-off-by: Zixun LI <admin@hifiphile.com>
>>>  ---
>>>   drivers/usb/gadget/atmel_usba_udc.c | 9 ++-------
>>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>>  diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
>>>  index f9326f0a7e7d913bcf201ba3e4aeca9a099e7be7..a38e70957402fb3ade3de611d73e29b990d00703 100644
>>>  --- a/drivers/usb/gadget/atmel_usba_udc.c
>>>  +++ b/drivers/usb/gadget/atmel_usba_udc.c
>>>  @@ -521,16 +521,11 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
>>>   static int usba_udc_pullup(struct usb_gadget *gadget, int is_on)
>>>   {
>>>    struct usba_udc *udc = to_usba_udc(gadget);
>>>  - u32 ctrl;
>>>  -
>>>  - ctrl = usba_readl(udc, CTRL);
>>>
>>>    if (is_on)
>>>  -  ctrl &= ~USBA_DETACH;
>>>  +  usba_writel(udc, CTRL, USBA_ENABLE_MASK);
>>
>>
>>  Could we add a comment in the function as well? Something similar to
>>  what's in the commit message:
>>
>>  /* Some chips don't reliably drive DP/DM lines to high impedance when
>>   * using the DETACH/PULLD_DIS bits.
>>   * To ensure a reliable disconnect, power cycle the controller instead
>>   */
>>
>>  Feel free to rephrase your preference.
>>
>>>
>>>    else
>>>  -  ctrl |= USBA_DETACH;
>>>  -
>>>  - usba_writel(udc, CTRL, ctrl);
>>>  +  usba_writel(udc, CTRL, USBA_DISABLE_MASK);
>>>
>>>    return 0;
>>>   }
>>>
>>>  ---
>>>  base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
>>>  change-id: 20250602-pullup-83c5540db5cd
>>>
>>>  Best regards,
>>>  --
>>>  Zixun LI <admin@hifiphile.com>
>
>
