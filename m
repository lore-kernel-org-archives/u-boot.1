Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EA2CD3442
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 19:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D885583CEB;
	Wed, 12 Nov 2025 20:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="d/CJG3g4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4B183D03; Wed, 12 Nov 2025 20:06:20 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 713D683A94
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 20:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3669ca3dso14596f8f.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 11:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762974378; x=1763579178; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AG2ulzOLbWO8bazu2drslbPTDF7jeqwpyubZ+ez97ic=;
 b=d/CJG3g4Uv/tAwPYTzNqnL9f8p79alIiMYxyQHnpge/wzZKxP4nszR/1juqQX9XWMA
 q5ASmRPdcBZZ2YFTirrfKlfkHwrO3r2EOJXJztB9zUpu5fbNCkWxPonKGHz9owhJZZkb
 uJtKUBpt9/o51CSBT/oeUBB9Auw7ndybHWqs/xwfV1EsqQxOkphKjJHaV/RSWrn2/ykB
 35JE9KvpdsFOzG9zQaSdV0ix3otikgRxZGs+xY2JE3gKwJICJayKzsTnkfFsniF6Ib53
 oZsI8dwPZtYs7yNJzp6z3A1BmGRuvXzfSBT+bm7yT0F0VexPhjl66cQRuQjgwxcsrh0g
 /oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762974378; x=1763579178;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AG2ulzOLbWO8bazu2drslbPTDF7jeqwpyubZ+ez97ic=;
 b=IltC1hO36siEWJ98vIxsLXOSQfZSAEba4kcnK3uVzyCxWQ3JwJa7w6V7yKROf/w1WR
 LFVZSmLE4eIiag9Tj5PfmZ2ZSx0lpC4f2GdCDhh0JQUz0Z7AgR22YAzfMCNuuKP1Bxyp
 Ax92A/DrOuiGViH2ggfgXsBW8LPPoyZzcUmYgC2n1xekfF7vNBqcQ0p0YEXW0Fq7KuKi
 AWOUEo+erwinhYOfuDx+Nbr/rXZX18/5WTUkauTjSMkRHasEDOhlyZUOML4AtWUT3Uqu
 ZSEV11rTRY4rsaFYolxfHkxLtdb74WS7Wd+n19qAsabl1IwKcktwQurpePrd+ncvXebf
 a/hA==
X-Gm-Message-State: AOJu0YxQrEjBoiLtsv49XaL9mCIaLDp48eKF+7efy0pCDo0PO9AJu4UE
 ERgM83cwh8HjtOCapmj8bi8gClTsgJBNwGs2j7cbfHNKxd4dVR1/fQXFhXBUSxku8Ic=
X-Gm-Gg: ASbGncsYWI4n1cdvxR70s0ype6wrtnIAeJwc0Zq3GOQ8iZHkF5l6sYan3QYUmXKYbHS
 bQIpFNJ7LlKbOMO0B+4ZExVztE9lJkDPRYAev/5ZeAfPTtdjc5pkMa7zWNnULw2hzHkh7kXZ/bm
 TexrNyNgJyX50HSWMxVVVieIwt/aYa8wWVbgi0BzWOa2GVp5C6wt6tDkG/EbvPGbUVLBgXx5r61
 HU0BbfqXSxI3uIkFSP9g5QadqneEIqIgED7I4lEumTrtSj4w9RIbyRX6UfDPZee8wQDAPO/ysxo
 Kud51yyuznV7kXrvAV3i0i54C/rDyaJhJyYE4xrZN1TPaPR57YEZThsEjbdbRJB9cCcMknBRgUr
 AfgJWeSPQYsunyFEjVwvqjoaU3K1VX7vgqfzak6e/frY9OPgee5nB68u+wMRmpRNbxYiXt0bOr1
 1AZmkTpTHaQsNqRZAZVGnMfzmTAHlL4wk6Tef0
X-Google-Smtp-Source: AGHT+IHRct+r4hX/rEx2vHYzuVRHkOxDodahBQmSj5wXTVFp9zQFC+2/FC+d7xPpnV9OjS0kho7r7A==
X-Received: by 2002:a5d:5d10:0:b0:427:6a3:e72f with SMTP id
 ffacd0b85a97d-42b4bdb001dmr3326522f8f.34.1762974377723; 
 Wed, 12 Nov 2025 11:06:17 -0800 (PST)
Received: from [192.168.0.29] (89.140.93.122.static.user.ono.com.
 [89.140.93.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b35ad7c16sm22872370f8f.15.2025.11.12.11.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 11:06:17 -0800 (PST)
Message-ID: <f46e987a-c1b9-45f2-9086-0a0584c9b130@suse.com>
Date: Wed, 12 Nov 2025 20:06:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: bcm283x: Add GPIO pull-up/down control for
 BCM2835 and BCM2711
To: Cibil Pankiras <cibil.pankiras@egym.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20251110112426.534118-1-cibil.pankiras@egym.com>
 <b637c777-d4aa-47ad-baf8-1f825dd379b8@suse.com>
 <CAK3EG+mu-Q05KiusOhe16vYPGHopWPGi_o1_8kzQbHDGWQyb-A@mail.gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <CAK3EG+mu-Q05KiusOhe16vYPGHopWPGi_o1_8kzQbHDGWQyb-A@mail.gmail.com>
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



On 11/11/2025 22:17, Cibil Pankiras wrote:
> Hi Matthias,
> 
> On Mon, Nov 10, 2025 at 4:42 PM Matthias Brugger <mbrugger@suse.com> wrote:
>>
>>
>>
>> On 10/11/2025 12:24, Cibil Pankiras wrote:
>>> This patch adds support for configuring GPIO pull-up and pull-down
>>> resistors in the BCM283x pinctrl driver. It implements the brcm,pull
>>> device tree property to control pin bias settings.
>>>
>>> The implementation follows the hardware-specific pull control
>>> mechanisms:
>>> - BCM2835: two-step GPPUD register sequence
>>> - BCM2711: direct per-pin control registers
>>>
>>> This enables device tree configurations to specify pull-up, pull-down,
>>> or no bias for individual GPIO pins.
>>>
>>> Tested on Raspberry Pi boards with both BCM2835 and BCM2711 SoCs.
>>>
>>> Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
>>> ---
>>>    arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
>>>    drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 102 ++++++++++++++++++++-
>>>    2 files changed, 109 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-bcm283x/include/mach/gpio.h b/arch/arm/mach-bcm283x/include/mach/gpio.h
>>> index 4aeb48eeb20..c54414a012c 100644
>>> --- a/arch/arm/mach-bcm283x/include/mach/gpio.h
>>> +++ b/arch/arm/mach-bcm283x/include/mach/gpio.h
>>> @@ -26,6 +26,16 @@
>>>    #define BCM2835_GPIO_FSEL_BANK(gpio)        (gpio / 10)
>>>    #define BCM2835_GPIO_FSEL_SHIFT(gpio)       ((gpio % 10) * 3)
>>>
>>> +/* BCM2835 GPIO Pull-up/down register offsets */
>>> +#define BCM2835_GPPUD                37
>>> +#define BCM2835_GPPUDCLK0    38
>>> +
>>> +/* BCM2711 GPIO Pull-up/down control */
>>> +#define BCM2711_GPPUD_CNTRL_REG0     57
>>> +#define BCM2711_PUD_REG_OFFSET(gpio) ((gpio) / 16)
>>> +#define BCM2711_PUD_REG_SHIFT(gpio)  (((gpio) % 16) * 2)
>>> +#define BCM2711_PUD_2711_MASK                0x3
>>> +
>>>    struct bcm2835_gpio_regs {
>>>        u32 gpfsel[6];
>>>        u32 reserved1;
>>> diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
>>> index cf9350c151e..c588015905d 100644
>>> --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
>>> +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
>>> @@ -21,6 +21,8 @@
>>>    #include <asm/system.h>
>>>    #include <asm/io.h>
>>>    #include <asm/gpio.h>
>>> +#include <dt-bindings/pinctrl/bcm2835.h>
>>> +#include <linux/delay.h>
>>>
>>>    struct bcm283x_pinctrl_priv {
>>>        u32 *base_reg;
>>> @@ -54,7 +56,66 @@ static int bcm2835_gpio_get_func_id(struct udevice *dev, unsigned int gpio)
>>>    }
>>>
>>>    /*
>>> - * bcm283x_pinctrl_set_state: configure pin functions.
>>> + * bcm2835_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2835
>>> + * @dev: the pinctrl device
>>> + * @gpio: the GPIO pin number
>>> + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD_UP)
>>> + */
>>> +static void bcm2835_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pull)
>>> +{
>>> +     struct bcm283x_pinctrl_priv *priv = dev_get_priv(dev);
>>> +     u32 bank = BCM2835_GPPUDCLK0 + BCM2835_GPIO_COMMON_BANK(gpio);
>>> +     u32 bit = BCM2835_GPIO_COMMON_SHIFT(gpio);
>>> +
>>> +     /* Set required control signal */
>>> +     writel(pull & 0x3, &priv->base_reg[BCM2835_GPPUD]);
>>> +     udelay(1);
>>> +
>>> +     /* Clock the control signal into the GPIO pads */
>>> +     writel(1 << bit, &priv->base_reg[bank]);
>>> +     udelay(1);
>>> +
>>> +     /* Remove the control signal and clock */
>>> +     writel(0, &priv->base_reg[BCM2835_GPPUD]);
>>> +     writel(0, &priv->base_reg[bank]);
>>> +}
>>> +
>>> +/*
>>> + * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
>>> + * @dev: the pinctrl device
>>> + * @gpio: the GPIO pin number
>>> + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD_UP)
>>> + */
>>> +static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pull)
>>> +{
>>> +     struct bcm283x_pinctrl_priv *priv = dev_get_priv(dev);
>>> +     u32 reg_offset;
>>> +     u32 bit_shift;
>>> +     u32 pull_bits;
>>> +
>>> +     /* Findout which GPIO_PUP_PDN_CNTRL register to use */
>>> +     reg_offset = BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSET(gpio);
>>> +
>>> +     /* Findout the bit position */
>>> +     bit_shift = BCM2711_PUD_REG_SHIFT(gpio);
>>> +
>>> +     /* Update the 2-bit field for this GPIO */
>>> +     pull_bits = pull & BCM2711_PUD_2711_MASK;
>>> +     clrsetbits_le32(&priv->base_reg[reg_offset],
>>> +                     BCM2711_PUD_2711_MASK << bit_shift,
>>> +                     pull_bits << bit_shift);
>>> +}
>>> +
>>> +static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pull)
>>> +{
>>> +     if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
>>> +             bcm2835_gpio_set_pull(dev, gpio, pull);
>>> +     else
>>> +             bcm2711_gpio_set_pull(dev, gpio, pull);
>>> +}
>>> +
>>> +/*
>>> + * bcm283x_pinctrl_set_state: configure pin functions and pull states.
>>>     * @dev: the pinctrl device to be configured.
>>>     * @config: the state to be configured.
>>>     * @return: 0 in success
>>> @@ -62,8 +123,9 @@ static int bcm2835_gpio_get_func_id(struct udevice *dev, unsigned int gpio)
>>>    int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>>>    {
>>>        u32 pin_arr[MAX_PINS_PER_BANK];
>>> +     u32 pull_arr[MAX_PINS_PER_BANK];
>>>        int function;
>>> -     int i, len, pin_count = 0;
>>> +     int i, len, pin_count = 0, pull_len = 0, pull_count = 0;
>>>
>>>        if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
>>>            len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_arr,
>>> @@ -82,8 +144,42 @@ int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>>>                return -EINVAL;
>>>        }
>>>
>>> -     for (i = 0; i < pin_count; i++)
>>> +     /* Check if brcm,pull property exists */
>>> +     if (dev_read_prop(config, "brcm,pull", &pull_len) && pull_len > 0) {
>>> +             if (pull_len & 0x3) {
>>
>> We should check for arbitrary values, so check should be, pull_len > 0x2
> 
> In the current version of the patch, I validate each element in
> pull_arr[] as follows:
>      for (i = 0; i < pull_count; i++) {
>          if (pull_arr[i] > 2) {
>              debug("Invalid pull value %d for pin %d in pinconfig %s\n",
>                    pull_arr[i], pin_arr[i], config->name);
>              return -EINVAL;
> 
> Could you please clarify? Did you mean to replace the alignment check
> `if (pull_len & 0x3)` with `pull_len > 0x2` ?
> 

I think I miss some basic understanding here. Please help me with that. From
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.yaml?h=v6.18-rc5#n88
<snip>
         brcm,pull:
           description: >
             Legacy pull setting for the pins (0=none, 1=pull-down, 2=pull-up).
           $ref: /schemas/types.yaml#/definitions/uint32-array
           maximum: 2
</snip>

So if I understand correctly you are reading the number of bytes in brcm,pull, 
which should be either one or two u32 values. But you error out only if the 
pull_len is 0x3. How is that? My gut feeling tells me it should be either 0x2 or 
0x4 everything else is an invalid DTB. But as I said I think I miss some 
fundamental understanding here. Can you please elaborate.

By the way, I suppose we implement the deprecated binding because the RPi FW 
still uses this, correct?

Regards,
Matthias
