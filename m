Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34546CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 09:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48B6836D1;
	Tue,  4 Nov 2025 10:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UaCfgq3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930D0838CE; Tue,  4 Nov 2025 10:44:37 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791FE82A9E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 10:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so43173025e9.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 01:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762249475; x=1762854275; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qqKHXq3dW/NFn5sZO21vjUVJKR+NKMCLYWWKROqiNa8=;
 b=UaCfgq3I9sJ7fvMqP7w2UA+Lg4+USwqtFcwaAd8hFMoM8jYJIeodMVeg6fzmaPq6/v
 u67W5KNjoicx1YHRsFDtC4ivS4Z1v1SB5IzhT2YDZqSjJqAcyCJam0RtH9oNpkTQn8Qp
 ffZQjyF5iR5O8emlo4eHAWNzpaeR4sI8IbtIgo/YnFAOp5jL6sr3+PP43NEQveb30QYV
 TyxeMORjcLDtC6evrz7GhxENo9HMS+F20NghxZi/+aLDBgghgVto1B4r3gBuQ6RHYgPD
 JY0vqInbxCmqtcgHLrsGn5DWGvA6AcGKg7FUWsz+cJmv9fZH5Hwq5/U0lQdZZeenChtB
 oEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762249475; x=1762854275;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qqKHXq3dW/NFn5sZO21vjUVJKR+NKMCLYWWKROqiNa8=;
 b=r+I2BFvmcmuaGq3r4+PSoYxVdGzsFoXv4mRZdgManJoOMkfPhIKWQS/Xm6X0hyeJbY
 ovTbFuifXGXMCKw2NNbx19a3updhXDpYXti++K1z7yXzIxMZBIbZdMGGaX3PqSpZyveS
 lg/peMvdIUluwX669WFXQzrIeZDk8HOYB90sy/U8ZUgS2lgjRkqBwy1ggyuyprYnY/B6
 HEz4jQxk/NhgYuK1Ylk31sGGi7aQ6u7w5qIb46nIIErgWAB6OEQ39cWTPxEK5mGv5ErT
 AWNvNhra8t0MP0p62aGceOGhd/aOwrPofTsiKpbY9hke83WniRHlbLivDjycj7Wg8r51
 EchQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULR9q+c2Fy3kRtYKHhrCCfpetCj3ln7jYtjAYnLA4VTfNBj9EjEBjR+bk5EFNvRaVmPeYeZdY=@lists.denx.de
X-Gm-Message-State: AOJu0YwexDRXaUSTdqK2Dq3NB2/n6WCQLooriPAd7PmuFzYJZmpi6grc
 qvLlOeBGfITpnKULqDonxk8hooCtXUQufr5f4V6D8vZBIWMzuoBvpR2RuF5EErzkxeQ=
X-Gm-Gg: ASbGncvJX6OJiRjDh6U4pKS13N0gf3nw064Y2matMO+B00VqBTlh/W1JX1NbG7lKWNV
 7b4jijac9dMmib3boo33IbzPZUbQyhQ6ZMjXjgXMKwNIWS4HuPGx+I4YHWAtZc+frKujSJ6lNPV
 O+d8lNozqTdxAxKaGFOuzVEUUKR5XhbF/tXbtTWQVSl3fW4GUjaqrJMQW2xrzV8d4au53wx7Mis
 EGva9cI6qihVuOcR6xiYbyuw8U++l31jox6XGNV4eNcoHPDc8fc2sdPlWzoKI9UcsDcdboc4Nhm
 dw/mckc6QMEDAMj0PKtlJ3tsGNUgVODcar3HcH5H3CCZ9mu0Lm2CzA0q6zHK4e7HR5U2OUKPeCM
 nQ04bF+uk8ya0VygTxBGao1+7vR6/FAlrC+akUpYsvuT6E6xsrWALwHgGG1D72Q67403UL15gZd
 p/3u0BO4ifxZ18R/nmR0pmskoUDjBLcih5mw==
X-Google-Smtp-Source: AGHT+IFEMdY0iKcQ0rqRwsqK77rfYnTtMsSy3XaUNNVIuJT+8L4AaPPWWOMuRJb+PmHHe9Nl6QWhpQ==
X-Received: by 2002:a05:600c:3b0f:b0:46e:4a60:ea2c with SMTP id
 5b1f17b1804b1-477308a897dmr142422025e9.37.1762249474747; 
 Tue, 04 Nov 2025 01:44:34 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775598c2c9sm28043605e9.8.2025.11.04.01.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 01:44:33 -0800 (PST)
Message-ID: <2e387aeb-2ba2-4b72-aa91-0815cd06f831@linaro.org>
Date: Tue, 4 Nov 2025 10:44:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 3/4] mach-snapdragon: fixup power-domains
To: Casey Connolly <casey.connolly@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
 <20251027113312.3815169-4-aswinm@qti.qualcomm.com>
 <ea83aa0d-9db8-4a7a-8b4e-bf32c9aa4ffc@linaro.org>
 <3af79816-26e0-4403-988f-29858bf569d3@oss.qualcomm.com>
 <caea13ec-4b90-4a7e-85f7-023e42365a7a@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <caea13ec-4b90-4a7e-85f7-023e42365a7a@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/3/25 13:31, Casey Connolly wrote:
> 
> 
> On 10/31/25 11:12, Aswin Murugan wrote:
>>
>> On 10/28/2025 6:32 PM, neil.armstrong@linaro.org wrote:
>>> On 10/27/25 12:33, Aswin Murugan wrote:
>>>> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>>>
>>>> RPMH power domain properties were initially removed from the
>>>> device tree due to the absence of driver support. Since RPMH
>>>> power domain driver is added now, the fixups are removed.
>>>>
>>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>>> ---
>>>> v5:
>>>> - No changes to this patch in v5
>>>>
>>>> v4:
>>>> - Reverted the inclusion of qcom-rpmpd.h header in pervious versions.
>>>>
>>>> v3:
>>>> - Removed OF_LIVE_SA8775P config, since there is no SA8775P specific fixups are done
>>>>
>>>> v2:
>>>> - Removed the power domain fixups, since the power domains are handled in qcom-rpmhpd driver
>>>> ---
>>>>   arch/arm/mach-snapdragon/of_fixup.c | 31 -----------------------------
>>>>   1 file changed, 31 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach- snapdragon/of_fixup.c
>>>> index eec2c0c757e..93c16821e54 100644
>>>> --- a/arch/arm/mach-snapdragon/of_fixup.c
>>>> +++ b/arch/arm/mach-snapdragon/of_fixup.c
>>>> @@ -116,36 +116,6 @@ static void fixup_usb_nodes(struct device_node *root)
>>>>       }
>>>>   }
>>>>   -/* Remove all references to the rpmhpd device */
>>>> -static void fixup_power_domains(struct device_node *root)
>>>> -{
>>>> -    struct device_node *pd = NULL, *np = NULL;
>>>> -    struct property *prop;
>>>> -    const __be32 *val;
>>>> -
>>>> -    /* All Qualcomm platforms name the rpm(h)pd "power-controller" */
>>>> -    for_each_of_allnodes_from(root, pd) {
>>>> -        if (pd->name && !strcmp("power-controller", pd->name))
>>>> -            break;
>>>> -    }
>>>> -
>>>> -    /* Sanity check that this is indeed a power domain controller */
>>>> -    if (!of_find_property(pd, "#power-domain-cells", NULL)) {
>>>> -        log_err("Found power-controller but it doesn't have #power- domain-cells\n");
>>>> -        return;
>>>> -    }
>>>> -
>>>> -    /* Remove all references to the power domain controller */
>>>> -    for_each_of_allnodes_from(root, np) {
>>>> -        if (!(prop = of_find_property(np, "power-domains", NULL)))
>>>> -            continue;
>>>> -
>>>> -        val = prop->value;
>>>> -        if (val[0] == cpu_to_fdt32(pd->phandle))
>>>> -            of_remove_property(np, prop);
>>>> -    }
>>>> -}
>>>> -
>>>>   #define time_call(func, ...) \
>>>>       do { \
>>>>           u64 start = timer_get_us(); \
>>>> @@ -158,7 +128,6 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>>>>       struct device_node *root = event->data.of_live_built.root;
>>>>         time_call(fixup_usb_nodes, root);
>>>> -    time_call(fixup_power_domains, root);
>>>
>>> I think the fixup should be removed only if QCOM_POWER_DOMAIN is enabled, no ?
>>>
>>> Neil
> 
> Hi Aswin,
> 
>>>
>>> In line with the previous review comment in thread Re: [PATCH v1 0/4] Added QCOM RPMH Power Domain Driver - Casey Connolly <https:// lore.kernel.org/u-boot/5afbdafa-a0f9-4146- b64e-8869f68bc7f8@linaro.org/#t>, which recommended the complete removal of the fixup code, we have removed it accordingly, also the QCOM_POWER_DOMAIN config is enabled by default in qcom_defconfig
>>> Please let us know if you would like any further changes or adjustments.
> 
> Yes ideally the fixup code would be removed, but we support platforms like msm8916 (apq8064) which use rpm (no H) which are not supported by your series.
> 
> So I think the fixup code needs to stay, and we likely need some kind of runtime check (best I can think of right now is checking if the compatible string ends in "rpmpd" or "pmhpd" and only doing the fixups for non-rpmh platforms).

I think the proper fix would be to just bail out when no power-domain device is found in dev_power_domain_ctrl(),

=======================><=============================
diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index d9fa8ad4bd2..61f693c41bc 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -184,6 +184,8 @@ static int dev_power_domain_ctrl(struct udevice *dev, bool on)
                                             "#power-domain-cells", 0);
         for (i = 0; i < count; i++) {
                 ret = power_domain_get_by_index(dev, &pd, i);
+               if (ret == -ENODEV)
+                       return 0;
                 if (ret)
                         return ret;
                 if (on)
========================><================================

Probably a warning could help aswell for debugging.

Neil



> 
> Sorry if this wasn't communicated very clearly, hopefully it makes sense now(?).
> 
> Ideally we'd be able to have ARCH_SNAPDRAGON select the rpmh pd driver, but since it isn't needed on some platforms it doesn't make much sense to do that I guess.
> 
> Kind regards,
> Casey (she/they)
> 
>>>
>>> Thanks,
>>> Aswin
>>>
>>>>         return 0;
>>>>   }
>>>
> 


