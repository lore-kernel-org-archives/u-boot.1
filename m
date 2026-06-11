Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942B1CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 07:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39BD80087;
	Thu, 11 Jun 2026 09:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XO2tWx2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1024839A8; Thu, 11 Jun 2026 09:45:28 +0200 (CEST)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8796380086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 09:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-307d0405e07so4216368eec.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 00:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781163925; x=1781768725; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXbbKb1yWmcbt+ZSuJsyAdO9ndqlZDb8bITIp24Zju0=;
 b=XO2tWx2dcEFsOjtEn6VdvJiCxaI11AnRlav1YhLzhYbVDmV8KbxFtRWtMNqGyjRwxN
 LLuoMnPk6g9WGE9Xge4RJJfzfCQtzzso8/hHJKh8QuiDR5mAsIBW9UKK9qHo3j3SAgQT
 6NIbUsxA7vrVJsskfLnz8yDqMxE3ns9NaFgoSdybsxuACtT059146XPZsDKV2ErMOJPS
 a6mAMC14Y4+pe6os9ktte2160H+LTGJ2Lsk3g9/e2yn5Nzm0Y/gYzjkAIhc/pSx0ENxn
 +3xPgi9yuggsDMNGy/RwyduEw1uLmMcNwN8GEhD3+a40i96Xe0J9zqcQl57grH4NV7bo
 I5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781163925; x=1781768725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rXbbKb1yWmcbt+ZSuJsyAdO9ndqlZDb8bITIp24Zju0=;
 b=TuYitA1OQDUbBgEjf5ct3wqwhXwy2pHn+eSWsvgmkjwC4vdhH+DxeDw6n9wMt00M+v
 8M/4V9YTQ6s+zy69t0xt0VllqaoWXLy+y5yNMYundJNXlpoZufzVg0ZZ6t9Ab1CusUZy
 0bvT83I1zBgcgVnSKPYX1JmaEOmHGpMShK8kD86KtvQ5P75RyeR7yIMX9Y098NwZmWvQ
 xACsat+Suof2x0ifRgSUxhB7MOhGIxH3z9xFPMQw3uxpXglWhShJKKoDSQXMSpjzz0wk
 Ztx5/HaPgHhIVAbssiX9MYEr/ZlFn3StPNbZMssDoy6e9vMg/e9upW3vb6akdC69VcMz
 nyLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FKbSwxXvp4ufhdnpYO52dXgD7ykqwN5BsTrfnlry9eTKMUo/bHaK+nrKLtr/3fvWP1KuBzzM=@lists.denx.de
X-Gm-Message-State: AOJu0YxY948BsKLO7J0yW2Mo1q0TcXg40pohFrxWWhOj+TmxSJiOcgBp
 kjA6JK0irQ3mN27T7o2Y0CMbw5kjZR0IQWsZpD0fZYYezPummrVoSIH7
X-Gm-Gg: Acq92OEwpdei4e1Xv8V08Pl8o1AsLwV9JI24GB4Vj5wBvnMAepDp/4hGdEYEC0F336v
 JiTu3aoWvdqMkEsoLX7/1upc2JJscYq4zJ+8EdQ/uUhKN1Nw6u+qCgF5MowrbaWj2OwPOIcOUCx
 ILuEe/nrfRbWOw1t3MAKcfT4p9LsQaSpv8jK/JjUQJ76UQVyD2rwrYJUuS0nxGSbmYBYhgOXqeG
 SOeoDpVKzTo9lFaMoc5+FABC+lm/Wy1q9rmKhYPZTJhGDhBEiLU6w4rAgARjA1FlsYIcUiDXGjd
 XykXxOaQE3cvLAImqIxpP2/u73tqhRhLcrrrK2q/MGbsu5IVFDDhjOl0/IhGekkSZjYd0Gl3fR8
 blSazvyydmsThQSuJ2Jff8x+cgaN+ENxQLKCTksIEJlIjKIi/rbxnQyWQlfUvcNj+fa7Ksxb7I3
 kF3/CmTixZnKJ5UaackQg=
X-Received: by 2002:a05:7301:9c83:b0:304:de94:1c55 with SMTP id
 5a478bee46e88-30804cce904mr1559120eec.35.1781163924657; 
 Thu, 11 Jun 2026 00:45:24 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2607:f130:0:13b::3a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee13a5sm1519975eec.28.2026.06.11.00.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 00:45:24 -0700 (PDT)
Message-ID: <9da8802a-55ff-4797-b748-6963b8cc36a3@gmail.com>
Date: Thu, 11 Jun 2026 15:45:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: boot_mode: fix download key detection
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260610030154.173455-1-cnsztl@gmail.com>
 <d3e58ad8-24b5-4de9-a01b-adfd4825fe75@kwiboo.se>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <d3e58ad8-24b5-4de9-a01b-adfd4825fe75@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Jonas,

On 2026/6/10 21:25, Jonas Karlman wrote:
> Hi Tianling,
> 
> On 6/10/2026 5:01 AM, Tianling Shen wrote:
>> rockchip_dnl_key_pressed() looks for the ADC device by checking
>> whether the device name starts with "saradc".
>>
>> On RK3328, RK3576, RK3588 etc., the SARADC node is named "adc@...",
>> so the device name no longer has the "saradc" prefix. As a result,
>> U-Boot fails to find the SARADC device and does not sample the
>> download key state.
>>
>> Do not rely on the DT node name. Match the bound Rockchip SARADC
>> driver instead, which works for both "saradc@..." and "adc@..."
>> node names.
>>
>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> ---
>>   arch/arm/mach-rockchip/boot_mode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
>> index 55e9456668ae..363fad523cbd 100644
>> --- a/arch/arm/mach-rockchip/boot_mode.c
>> +++ b/arch/arm/mach-rockchip/boot_mode.c
>> @@ -51,7 +51,7 @@ __weak int rockchip_dnl_key_pressed(void)
>>   
>>   	ret = -ENODEV;
>>   	uclass_foreach_dev(dev, uc) {
>> -		if (!strncmp(dev->name, "saradc", 6)) {
>> +		if (!strcmp(dev->driver->name, "rockchip_saradc")) {
> 
> The adc channel used below may not fit all boards/SoCs, so this change
> may have unintended consequences.
> 
> I have previously avoided "fixing"/enable this code path for RK35xx
> because the download key selection should really be improved when this
> is fixed/expanded to more boards/SoCs.
> 
> E.g. maybe add support to declare a recovery button in u-boot,config
> node and use UCLASS_BUTTON to check if such button was pressed or
> something similar?

Yes this is much better than evaluating raw ADC values, but BUTTON is 
not available in SPL so we cannot have this functionality in SPL (though 
this idea was already rejected :P).

I have made an initial version that use UCLASS_BUTTON:

```
__weak int rockchip_dnl_key_pressed(void)
{
#if CONFIG_IS_ENABLED(BUTTON)
	const char *path;
	struct udevice *button;
	ofnode node;
	int ret;

	path = ofnode_options_read_str("recovery-key");
	if (!path)
		path = ofnode_conf_read_str("u-boot,recovery-key");
	if (!path)
		return false;

	if (path[0] == '/')
		node = ofnode_path(path);
	else
		node = ofnode_get_aliases_node(path);

	if (!ofnode_valid(node)) {
		pr_err("%s: invalid recovery key '%s'\n", __func__, path);
		return false;
	}

	ret = uclass_get_device_by_ofnode(UCLASS_BUTTON, node, &button);
	if (ret) {
		pr_err("%s: recovery key is not a button: %d\n", __func__, ret);
		return false;
	}

	ret = button_get_state(button);
	if (ret < 0) {
		pr_err("%s: failed to read recovery key: %d\n", __func__, ret);
		return false;
	}

	return ret == BUTTON_ON;
#else
	return false;
#endif
}
```

... so it can be configured in u-boot.dtsi like this:
```
/ {
	options {
		u-boot {
			recovery-key = "/keys-1/button-recovery";
		};
	};
};
```

I have tested this on my DshanPi A1 board and it seems to work okay.

Is this an acceptable way to configure recovery key? I'm also wondering 
if it's necessary to keep compatibility with old adc_channel_single_shot 
implementation.

Thanks,
Tianling.

> 
> Regards,
> Jonas
> 
>>   			ret = adc_channel_single_shot(dev->name, 1, &val);
>>   			break;
>>   		}
> 

