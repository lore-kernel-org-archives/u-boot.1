Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AB3C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 11:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32227882B7;
	Mon, 24 Jun 2024 13:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SKGeD7BO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D051882CE; Mon, 24 Jun 2024 13:41:10 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D7D88049
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 13:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d07673185so3865499a12.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719229267; x=1719834067; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0qllPqzf8xOqwT9eY6Y+ujZx1cVmcb2KPeYqsy4Xks=;
 b=SKGeD7BOJOslGU2p+fs3O4MwQMVf9i8n/4AhMo8yqI8LewNpFAcc6EgzOVHkz8E6HG
 9YtFYREwejYLV798n39hVDxVnJq9z1QE16n/cmdlWjjjoX/N0ED5rfFjwNFes8EmQXTY
 zwaDbd7d8P8ziN8nGfQABgZFwLR+KHZSUP924BobetI3pYuWayHBv4zM/S3zuql91SGy
 NJiQzcmUJAvhMo+I4e8VgTv7JxW11ro0oKxi0Q4fDr5MtWBrpx5IBazHr2D7cMotWTHV
 de4dbDHcBzHO4hSyzd80V5kmDuA0HGwFHSCArYo1o/hZAO347gF1cbpq17INfgDFHFb7
 waaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719229267; x=1719834067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0qllPqzf8xOqwT9eY6Y+ujZx1cVmcb2KPeYqsy4Xks=;
 b=tIqmFuumm6Ifmrbm04o9mEu5GINmtM5CPB5WKfGwFgreyU8fTgq8Tf0qUOTxheK+vx
 4ceSBLHs3q+KO4rppSbYjIrBPU9UmSBo7SGKQIoiy3MzQaozKZnjBt2pr3vlXPo51fU3
 pfc5Bz9GLHIGgCUfBLTfzgex5/63jxBdJ3xIWURWaIhSGKmFIJH9yAtTqPrEo2y7U5Xu
 wTSyEVlTDmnqz5mVp8zFJ2w7yn1W5SR8mbwCLzSg0kmk+WVtCioo/8KUteStyq5ZSQKr
 ncNqWOKiJE2mQPb2ZBgO+uqRbC9fujBWIo2vLLmDnDb6Zo5cZkHHZdB0uz4Yj4IyQklG
 GKRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/x7gIcas0tU9fmwnAqnTS0bU/fgWGR7hwi3MyAn1TgMfxMs8Vi+KU1lmfp+qIeAesNsJBy23lM1APrSaeKMTgyB74Qw==
X-Gm-Message-State: AOJu0YzksCuw3i03ln3VJyFdl/MDnfcAnyYpbt6zKIQ7gTyYQ4J7qRZ9
 7WhL7/DgW9+thmU5768oNwdVDivIlB73iG9dVE5heRwTb/9xh+WxPZzjVA5F3WH2g7uiLHwOADg
 4LQg=
X-Google-Smtp-Source: AGHT+IHYskkl7jkJ/FlSNNYFLJZ7jEME7i7NsKNnYOiWbmEiTPe4v6a7szr7hs8q2XkB0TBoNORnzQ==
X-Received: by 2002:a17:906:1982:b0:a6f:586b:6c2 with SMTP id
 a640c23a62f3a-a7242cdb417mr358055766b.60.1719229267118; 
 Mon, 24 Jun 2024 04:41:07 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::52af? ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fe7a10ed0sm273425766b.70.2024.06.24.04.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 04:41:06 -0700 (PDT)
Message-ID: <d6b9c6a2-235b-4f9f-8e88-9ba7a4f11f50@linaro.org>
Date: Mon, 24 Jun 2024 13:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: respect role-switch-default-mode
To: Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20240621021135.1600847-2-caleb.connolly@linaro.org>
 <be9fafa8-c3a1-4434-b344-caf32527460a@denx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <be9fafa8-c3a1-4434-b344-caf32527460a@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 24/06/2024 02:33, Marek Vasut wrote:
> On 6/21/24 4:11 AM, Caleb Connolly wrote:
>> * Factor out the common pattern of checking the dr_mode property on
>>    the usb node and it's parent
>> * Respect the usb-role-switch property, rather than requiring dr_mode be
>>    set
>> * Override OTG mode with the value in role-switch-default-mode
>>
>> The devicetree bindings don't dictate that dr_mode is a required
>> property, but the dwc3 driver would refuse to probe if it was unset
>> (this breaks the Qualcomm RB2 board which doesn't set it).
>>
>> Here, we update the driver to respect the other properties that can be
>> used to describe the controller, and more gracefully handle some of the
>> edge cases.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/dwc3/dwc3-generic.c | 56 +++++++++++++++++++++++++--------
>>   1 file changed, 43 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c 
>> b/drivers/usb/dwc3/dwc3-generic.c
>> index cbb5d61dfb0b..1cf8b90e8bbf 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -49,8 +49,46 @@ struct dwc3_generic_host_priv {
>>       struct dwc3_generic_priv gen_priv;
>>       struct udevice *vbus_supply;
>>   };
>> +/**
>> + * dwc3_get_preferred_dr_mode() - Get the preferred DR mode for the 
>> USB node
>> + *
>> + * Since we don't support dynamic role switching yet in dwc3, this is 
>> a slightly
>> + * opinionated wrapper around usb_get_dr_mode() which will respect the
>> + * role-switch-default-mode property if it is present and the dr_mode 
>> is OTG.
>> + *
>> + * @child: Node to get the DR mode for
>> + */
>> +static enum usb_dr_mode dwc3_get_preferred_dr_mode(ofnode node)
>> +{
>> +    enum usb_dr_mode mode;
>> +    bool is_role_switch = ofnode_has_property(node, "usb-role-switch");
> 
> The usb-role-switch DT property is not DWC3 specific, even in U-Boot it 
> is used by e.g. STM32MP15xx which is DWC2. This should be added to core 
> code.

I couldn't see an obvious way to add this desired behaviour without 
risking breaking some existing boards. Do you mean keep this as a new 
function but just move it to core code? Or update the existing 
get_dr_mode() function?
> 
> Also, it would be really good to sync the DWC3 driver with more up to 
> date Linux state, but that's out of the scope of this patch obviously.

Yes, I'm definitely feeling this. Last time I tried updating dwc3 as you 
suggested (reverting all patches since the Linux import, updating, 
re-applying)... But there have just been too many changes on the Linux 
side for this to work anymore, and too many arch specific dwc3 glue 
drivers which call into the core that might break.

I would love it if we could figure out some path forward here, even if 
that's just someone spending more than half a day on the porting effort :D

-- 
// Caleb (they/them)
