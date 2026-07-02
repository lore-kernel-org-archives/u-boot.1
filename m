Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8FAC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 06:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211F384C51;
	Thu,  2 Jul 2026 08:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RfcdqEeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4B784C54; Thu,  2 Jul 2026 08:55:26 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E574584C39
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 08:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c9dbd00f1dso9473425ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782975322; x=1783580122; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24DGDVS+CS2gYcRkZle2N3Iw/0fKYP9Yfssmt/KDYng=;
 b=RfcdqEeO9Ac8cv+3vWhDp/WBwGQpb+voEJiSNax6mBYDu2E3MdcSv3XlIILoDWd5O8
 BGZgeNJ9oAo0IttU11Z8GCmMFBr4ycJEcoDjUeXePKGbRxcS3fKVIuQ9EK0HdBIZl5Gx
 RA7RnYFxLQRetKBpvxbJxYO3azxPT3qzYPK8JrYDdI0sOwoWQCFPC4pRejGxacohb57F
 8mD/iVVcCCR8V631bX7TBmmmjhb8Q+Wwnwa4G3pF/2WeKAoN45eo6StG5uonEJWkqGBY
 5ww7ogQ1ALBgudAPfp2ahAbntCqyZqX/xWJnNv7D8oxSrUmaqjWwbDM3Z2AFEHRmywH+
 fxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782975322; x=1783580122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=24DGDVS+CS2gYcRkZle2N3Iw/0fKYP9Yfssmt/KDYng=;
 b=YtqBed5UXueB3mdERpVfkTlCVB9z/hj9z73TVJH8kblkoau+1XI7HSr2r+9PKMT6aE
 V+o+76vH+Jr+nSls/RzI8eMeeXQX2jgV8wqcpSppgKa2IuiSwJ56LnrUaNj/pBZYyWTH
 Q16Bro7F1p3ibFfYsg/p7yilYM7B2WYJXNxOCCtFL+ABmcpcVjbzM5/fhPhbm/md1Yi6
 XHg4FFQwOQp56Q04OMkZKhZavAbDd/dHcG4MhNjI4ZsV7Xgcxjm4t9Jx2npk529V/d5L
 OXyT/KJA8YExyGNAAr7gC535+lNWX8CeBPULhM8e4YhxdNxfGUr8E6okF+XQjR9+1U8B
 Ps7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RprIlCk4Ld1G33f9hpe3wmy5hk/7EFj3zoPJjGu514IWDimKCOciKmbPplRyrV06wD7lQh3p2I=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1OuSPoL7JCb77Ewq2GZEN5M+CeEpuudRj5Oav23a7XiTcz+En
 VkzNW8zJ1OzMHo+s2F2Avgtdwe/GDb+ev+8UQdSIAFOFQo0Sc7Ktg4FT
X-Gm-Gg: AfdE7cmeXuAV+wxhMXy2KpMhfjR87/aRtCLDaRLLUGmu7ltuWWPUiJe02oip9Z4GL8E
 uxj+3bsGUa6r12eYT3FFqRs1iFS/ANuO8oCElYlm8sVzH5lDxd2OU5/YirQQ0Qga9JV5aC1DRkr
 rvBstE5COPZw23WjPpi8k8p74uNXtpKON09IjGjoB6zotHP6TM2RUaA2/lHChbFBmEt19NNmNJn
 3wvd9Wt68Qk2SyY09jr7p54+PFla932KHG4HRXOQBRBJqUlfuDFEi9NSvtDPiBXy2q+tTiUFV4h
 /cUYkUMNK+Xv6FX8jojwEJRw0OVSCTEklNPRkOG/9W3q4MGxT5GvUav4iGv34iK/98tE2gV97bv
 gSukSjrNww3ig+nIv3kb9Q7VbxzFgWcDZ0OI37s++Y0uNfcygLZRYHiHTK8zuPEM=
X-Received: by 2002:a17:902:fc43:b0:2ca:64d3:f0da with SMTP id
 d9443c01a7336-2ca7e86784bmr53889365ad.32.1782975322045; 
 Wed, 01 Jul 2026 23:55:22 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2607:f130:0:13b::3a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a919f90sm8943095ad.35.2026.07.01.23.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 23:55:21 -0700 (PDT)
Message-ID: <8eb88c7e-e71b-41e6-bfc8-d0fcd3a2bb84@gmail.com>
Date: Thu, 2 Jul 2026 14:55:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: boot_mode: fix download key detection
To: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260610030154.173455-1-cnsztl@gmail.com>
 <d3e58ad8-24b5-4de9-a01b-adfd4825fe75@kwiboo.se>
 <9da8802a-55ff-4797-b748-6963b8cc36a3@gmail.com>
 <d1471aa7-dc32-45f6-93d0-e55fb278945b@cherry.de>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <d1471aa7-dc32-45f6-93d0-e55fb278945b@cherry.de>
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

Hi Quentin,

On 2026/6/26 19:52, Quentin Schulz wrote:
> Hi Tianling, Jonas,
> 
> On 6/11/26 9:45 AM, Tianling Shen wrote:
>> Hi Jonas,
>>
>> On 2026/6/10 21:25, Jonas Karlman wrote:
>>> Hi Tianling,
>>>
>>> On 6/10/2026 5:01 AM, Tianling Shen wrote:
>>>> rockchip_dnl_key_pressed() looks for the ADC device by checking
>>>> whether the device name starts with "saradc".
>>>>
>>>> On RK3328, RK3576, RK3588 etc., the SARADC node is named "adc@...",
>>>> so the device name no longer has the "saradc" prefix. As a result,
>>>> U-Boot fails to find the SARADC device and does not sample the
>>>> download key state.
>>>>
>>>> Do not rely on the DT node name. Match the bound Rockchip SARADC
>>>> driver instead, which works for both "saradc@..." and "adc@..."
>>>> node names.
>>>>
>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>> ---
>>>>   arch/arm/mach-rockchip/boot_mode.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach- 
>>>> rockchip/boot_mode.c
>>>> index 55e9456668ae..363fad523cbd 100644
>>>> --- a/arch/arm/mach-rockchip/boot_mode.c
>>>> +++ b/arch/arm/mach-rockchip/boot_mode.c
>>>> @@ -51,7 +51,7 @@ __weak int rockchip_dnl_key_pressed(void)
>>>>       ret = -ENODEV;
>>>>       uclass_foreach_dev(dev, uc) {
>>>> -        if (!strncmp(dev->name, "saradc", 6)) {
>>>> +        if (!strcmp(dev->driver->name, "rockchip_saradc")) {
>>>
>>> The adc channel used below may not fit all boards/SoCs, so this change
>>> may have unintended consequences.
>>>
>>> I have previously avoided "fixing"/enable this code path for RK35xx
>>> because the download key selection should really be improved when this
>>> is fixed/expanded to more boards/SoCs.
>>>
>>> E.g. maybe add support to declare a recovery button in u-boot,config
>>> node and use UCLASS_BUTTON to check if such button was pressed or
>>> something similar?
>>
>> Yes this is much better than evaluating raw ADC values, but BUTTON is 
>> not available in SPL so we cannot have this functionality in SPL 
>> (though this idea was already rejected :P).
>>
> 
> I'm sorry my memory is failing me, do you have a link maybe to that 
> discussion?

Please refer 
https://lore.kernel.org/u-boot/fd15b6e4-5525-4ce5-a145-ceb47d44c40e@rock-chips.com/

> 
>> I have made an initial version that use UCLASS_BUTTON:
>>
>> ```
>> __weak int rockchip_dnl_key_pressed(void)
>> {
>> #if CONFIG_IS_ENABLED(BUTTON)
>>      const char *path;
>>      struct udevice *button;
>>      ofnode node;
>>      int ret;
>>
>>      path = ofnode_options_read_str("recovery-key");
>>      if (!path)
>>          path = ofnode_conf_read_str("u-boot,recovery-key");
>>      if (!path)
>>          return false;
>>
>>      if (path[0] == '/')
>>          node = ofnode_path(path);
>>      else
>>          node = ofnode_get_aliases_node(path);
>>
>>      if (!ofnode_valid(node)) {
>>          pr_err("%s: invalid recovery key '%s'\n", __func__, path);
>>          return false;
>>      }
>>
>>      ret = uclass_get_device_by_ofnode(UCLASS_BUTTON, node, &button);
>>      if (ret) {
>>          pr_err("%s: recovery key is not a button: %d\n", __func__, ret);
>>          return false;
>>      }
>>
>>      ret = button_get_state(button);
>>      if (ret < 0) {
>>          pr_err("%s: failed to read recovery key: %d\n", __func__, ret);
>>          return false;
>>      }
>>
>>      return ret == BUTTON_ON;
>> #else
>>      return false;
>> #endif
>> }
>> ```
>>
>> ... so it can be configured in u-boot.dtsi like this:
>> ```
>> / {
>>      options {
>>          u-boot {
>>              recovery-key = "/keys-1/button-recovery";
> 
> This should absolutely be a phandle and not a path.

This prop also works with phandle. However most dts from upstream kernel 
does not have aliases for button, I have no idea how to refer them by 
phandle without modifying original copy.

> 
>>          };
>>      };
>> };
>> ```
>>
>> I have tested this on my DshanPi A1 board and it seems to work okay.
>>
>> Is this an acceptable way to configure recovery key? I'm also wondering 
> 
> It could be. Typically, when a new property makes it to the device tree, 
> it must be documented in the binding. Here it would be part of a u- 
> boot,config node, but I couldn't find a binding in U-Boot, Linux kernel 
> or the Device Tree spec, so I don't know what we're supposed to do here. 
> The button itself will need to be part of the Linux kernel upstream DTS, 
> the difficult part will be which event code it needs to return and will 
> be board-specific.

So recovery-key prop is added to detect if that button is pressed only. 
We don't care the event code.

> 
>> if it's necessary to keep compatibility with old 
>> adc_channel_single_shot implementation.
>>
> 
> Not necessarily, but we absolutely need all boards using this old 
> mechanism to be supported by the new mechanism, which may be difficult 
> since we don't necessarily have access to their schematics.

I'm not sure how many users are there. This code has been broken for a 
long time. I can see a few boards implement their own download key 
detection by similar (old) code.

> 
> I think we can maybe compromise for now on a Kconfig symbol for the 
> channel to use? What do you think? We would still need to check the 
> schematics of all boards that exercise this path and check if fixing the 
> condition won't cause side effects (because it now is reading the ADC 
> channel while it wasn't before due to the typo). The other option is to 
> explicitly disable it for all devices that could never meet the 
> condition with the typo (so even at SoC level since SARADC is an SoC- 
> specific IP) such that it can only be enabled if someone tests it on 
> their board.

Honestly I don't want to "improve" this old path if we decide to use the 
new config prop. KEY_DOWN_MAX_VAL=30 is also too strict for some boards 
(for example the ADC value on DshanPi A1 can be up to 45~47 when the 
button is pressed).

Thanks,
Tianling.

> 
> Cheers,
> Quentin

