Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C109C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 08:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8466787811;
	Wed, 10 Jan 2024 09:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MhpoT+H6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB4868788D; Wed, 10 Jan 2024 09:54:15 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92D787811
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 09:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3366ddd1eddso3742366f8f.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 00:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704876852; x=1705481652; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wzn5rweXdw33KEIfOLTcUf03a2eISzLTVfCMtXzzRPI=;
 b=MhpoT+H61Web1QW2U91CtIRnvgOTPI3uJM0P9pfXAhqGJg/iiyFqBJNVxKll2Qt4TW
 H9CQtXGYYsGSlREAmVOARiHcRyKLrHfaeId6e3VykXL6BdyKq1q2m/hImalFKozI/d+z
 H5d1eKp8Ky/klekh7lY7NpZP3SGvJNUIqSvlNGt+XZbKutSSxmo1i2Sg64GrQuEZRSPH
 sO1FQDW50a1z5sfWojTNiC0WDKB/ovz1pU4dDffr4BNBa50K29OgH5+DDamttRN+nec5
 /i5R/hjaAKi2VPAhoDu5k+kWqn9yS0/dHPkqEz2ibDzqhYFbLd5WfMKDNLOpk7NcRs/i
 Bcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704876852; x=1705481652;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wzn5rweXdw33KEIfOLTcUf03a2eISzLTVfCMtXzzRPI=;
 b=QsOedf0Ztzb+JZNNGugun3d3SDQs7P086+HkWF3zmagce1B2s8V14GYU1J7RSushEA
 Q52//WVaX3lukkN4M9W/QxZMY4bYGGJrTQcIyI3TKQ+jGNP2lN/Bb+tvbCGc4gBHumpt
 MEPrnN5/SY3wE/cWpXDaBYMVEw/21JtboYqeUpHllLG05fCZHe7FIMwFmLwZRpbMCttr
 QoebY+Va8WuE5Ie9mgCqvGItH3gI7V0GVTeidjnUesvLsS7/GLOlK7cHfglYZXA7FJwq
 G11hp2F09BiFiejteW9ZdnePz5ygdnlFB3CXjBJwYPDdR2ilDxASVeu+t8MqRGOSFeMf
 VLyQ==
X-Gm-Message-State: AOJu0YzLgvRAQYEfRcELG5vEDbV1yD09vlqehPHHmvxMl+R13grSuKqT
 uWS/8Qnc07RM08HLiCXR+u21LusCUhZwlg==
X-Google-Smtp-Source: AGHT+IHnh3OyPMW+f7LXIywCO5WcyioYe8jwYPeXUb0A5t3sYsMiwfb7pFakvtG4tUUmusCuTNpUNA==
X-Received: by 2002:a05:6000:36a:b0:336:ca92:6298 with SMTP id
 f10-20020a056000036a00b00336ca926298mr166979wrf.117.1704876852103; 
 Wed, 10 Jan 2024 00:54:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5dee:51de:9349:2adf?
 ([2a01:e0a:982:cbb0:5dee:51de:9349:2adf])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a056000184b00b003377be178a5sm1232191wri.78.2024.01.10.00.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 00:54:11 -0800 (PST)
Message-ID: <4803d996-54cf-40de-8bcb-cb7e7eb0348a@linaro.org>
Date: Wed, 10 Jan 2024 09:54:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 02/17] video: dw_hdmi: Add Vendor PHY handling
Content-Language: en-US, fr
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Robin Murphy <robin.murphy@arm.com>,
 u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
 <20231218191114.129329-3-jagan@amarulasolutions.com>
 <fbdad616-21a0-4fe1-84b8-a5110ca2cd7d@linaro.org>
 <CAMty3ZDz2vyzxMSdvhXXZrh_J_PwFJxZ5bnQtpv8qZRAtB_b5w@mail.gmail.com>
 <CAMty3ZB9CBUAz9OdKpkirukwMSWtBGAMzL5ObJf4gsR6W7TCfw@mail.gmail.com>
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
Organization: Linaro Developer Services
In-Reply-To: <CAMty3ZB9CBUAz9OdKpkirukwMSWtBGAMzL5ObJf4gsR6W7TCfw@mail.gmail.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 09/01/2024 21:04, Jagan Teki wrote:
> Hi Neil,
> 
> On Tue, Dec 19, 2023 at 5:21 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>>
>> On Tue, Dec 19, 2023 at 2:34 PM Neil Armstrong
>> <neil.armstrong@linaro.org> wrote:
>>>
>>> On 18/12/2023 20:10, Jagan Teki wrote:
>>>> From: Jagan Teki <jagan@edgeble.ai>
>>>>
>>>> DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.
>>>>
>>>> Extend the vendor phy handling by adding platform phy hooks.
>>>>
>>>> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
>>>> ---
>>>> Changes for v2:
>>>> - fix meson cfg
>>>>
>>>>    drivers/video/dw_hdmi.c              | 29 +++++++++++++++++++++++++++-
>>>>    drivers/video/meson/meson_dw_hdmi.c  | 11 ++++++++++-
>>>>    drivers/video/rockchip/rk3399_hdmi.c |  8 +++++++-
>>>>    drivers/video/rockchip/rk_hdmi.c     |  2 +-
>>>>    drivers/video/sunxi/sunxi_dw_hdmi.c  | 11 ++++++++++-
>>>>    include/dw_hdmi.h                    | 14 +++++++++++++-
>>>>    6 files changed, 69 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
>>>> index c4fbb18294..ea12a09407 100644
>>>> --- a/drivers/video/dw_hdmi.c
>>>> +++ b/drivers/video/dw_hdmi.c
>>>> @@ -988,7 +988,7 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
>>>>
>>>>        hdmi_av_composer(hdmi, edid);
>>>>
>>>> -     ret = hdmi->phy_set(hdmi, edid->pixelclock.typ);
>>>> +     ret = hdmi->ops->phy_set(hdmi, edid->pixelclock.typ);
>>>>        if (ret)
>>>>                return ret;
>>>>
>>>> @@ -1009,10 +1009,37 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
>>>>        return 0;
>>>>    }
>>>>
>>>> +static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops = {
>>>> +     .phy_set = dw_hdmi_phy_cfg,
>>>> +};
>>>> +
>>>> +static void dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
>>>> +{
>>>> +     if (!hdmi->data)
>>>> +             return;
>>>> +
>>>> +     /* hook Synopsys PHYs ops */
>>>> +     if (!hdmi->data->phy_force_vendor) {
>>>> +             hdmi->ops = &dw_hdmi_synopsys_phy_ops;
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     /* Vendor HDMI PHYs must assign phy_ops in plat_data */
>>>> +     if (!hdmi->data->phy_ops) {
>>>> +             printf("Unsupported Vendor HDMI phy_ops\n");
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     /* hook Vendor HDMI PHYs ops */
>>>> +     hdmi->ops = hdmi->data->phy_ops;
>>>
>>> Sorry but I still don't understand why you need phy_force_vendor & phy_ops,
>>> this code clearly fails if you have phy_force_vendor=true && phy_ops=NULL,
>>> so drop phy_force_vendor and simply use phy_ops if != NULL, and since it's
>>> the only element of dw_hdmi_plat_data, drop dw_hdmi_plat_data and pass
>>> dw_hdmi_phy_ops directly in the dw_hdmi struct.
>>>
>>> So in dw_hdmi_detect_phy(), if hdmi->ops is NULL, set it to dw_hdmi_synopsys_phy_ops.
>>
>> Let me elaborate more.
>>
>> DW HDMI IP must have phy ops. It never be NULL. Either it uses
>> 1. Internal PHY via DW called them Synopsys PHYs ops - for example, rk3399
>> 2. Vendor PHY via vendor phy meson, sunxi, rk3328
>>
>> For case 1) phy_force_vendor is false so it uses dw_hdmi_synopsys_phy_ops
>> For case 2) phy_force_vendor is true so it uses dw_hdmi_plat_data phy ops
>>
>> dw_hdmi_detect_phy assigns internal phy ops first and then vendor phy
>> ops based on phy_force_vendor flag.
>>
>> If we remove dw_hdmi_plat_data how can we assign or differentiate two
>> types of phy ops hooks? can you explain?
> 
> Let me know if you have any comments on this. I'm sending V3 would
> probably hit in MW.

Sure, I understand your point, but there's a limited number of users and it can
be greatly simplified, no need to keep the current structure, there's no external
users of the driver.

Just set hdmi->ops with the vendor phy ops from the glue driver if needed,
or let it to NULL if the platform uses the synopsys PHY, it's as simple as that.
If hdmi->ops is NULL it would be replaced with dw_hdmi_synopsys_phy_ops in the
dw_hdmi_detect_phy() function.

Neil

> 
> Thanks,
> Jagan.

