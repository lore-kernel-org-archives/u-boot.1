Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A0A1061B0F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 15:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15ED283DBF;
	Mon, 30 Mar 2026 17:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pVeY6bgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFB183FD9; Mon, 30 Mar 2026 17:21:52 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1C883D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d91f82d819so4568509a34.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774884108; x=1775488908;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kbo7CR8HtF8bQs7ErDEgs5HJ5srCW6BztizVvohcnCg=;
 b=pVeY6bgmwnFKJowyBQlJXrZcos9vzhOHQbnHr2dM69+XEGwXEyGgZ/ok4azlmA9Mm6
 Lx4j8JMrRfmpfpF+jqNQWKWH5L3yOtu1eYU0la7NBtookznY4zUIdBhpSdLzwRacpCcb
 qhjSDX32r7+JsMUr7nJzQd2/2FIc1TDV8mjz6TX/1TBrveLq7rw5JxLm5xMr0iHy8hQR
 7dCCxeih9uYfpW1SJmlP36lo4zjZubZLz9LHW2iC5/64dc0mZyzqRGVDkECnUBSgY2hN
 K0muJoIzxnaCts/8RSQZhL2Sz1ll/So3mJtd70Sg+OCn5IUMTlGciu/Eq8pqlct6iesl
 woGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774884108; x=1775488908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kbo7CR8HtF8bQs7ErDEgs5HJ5srCW6BztizVvohcnCg=;
 b=Hqe6v0Vh6/ER8iXfB0SDb//h91sxe+lnWWTGc35eU+FAA9SV7Iwp/y72XZTwv/xL6F
 0BVIaMP/JkDbyyjSV//HOSORVj0OrhQh5Uz33WUajGdzZdN1z9qFYIiokwDDFYeS/2rN
 O/tHPSh3RKBvN+L9+5AqkiKLE2Kwjy56kwyMQCD7+KCHLyX4hOxSAGUWJlhHjgjG7U2V
 A2fyrxS80BkT5DlwhF0sbmr9LuoxFPWU7l2DaGNVFuFLu8hKkj9z8qolGcBQKwBrH9ON
 77Qd7fdxnk9wX88+T9GeMjpBzEJimKHsF3QJ41ai6uNk8wFzYZIbOwGTAOZrHWBon9Nr
 qceQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUckjYLA/ROM/j6ePyMKfK8UpUapwWYeXgd+AT51YJnVt3hJ9aYEh0IC76A49++97i/QloOkoA=@lists.denx.de
X-Gm-Message-State: AOJu0YxNWE3pfpesO3ejXvkpS9r+mpF020qMiEcpbmxqoHdafLBE59SB
 Zh29fiLoqcdCgFzWL8JmPEIGrs9h2rpFwo5u5h4u07C5cxz8oS0fDgqs6BiOv+9dJxA=
X-Gm-Gg: ATEYQzzJwoBDr8S6gzzwZWVGSvaRH8CJ2WbGglaCsQEkyH9w26YNQ11O+2eesLL076T
 NSWEkIPm8UQvxVdg99HJYjReL7g6g5qrMeI0KyC6ZNtnJcv1aea9EI0K0XIe9V4T9sGdZJgyIHw
 BbeK7Yxy4E1pV+9qRLb+9N0OZcG6ZdbT55RKHnpOWgJj0ySUYruNFRnZp0WJs7njFEzcuvcQRiz
 3TMlysA2iRs5a9julEl75iQDyBeTr9vzH707W2MCONDaS/5uCnYvt5eCsMC4nkGNjte8v+XFuDG
 +TLc1fkRH25T/HpeGxLxccl7Kp446oTNHlXqlsUUPsO/CLP/HHKzu+V9JJ3xx82VBhhKqd86klz
 LlaxKpcAxcOKkku9LMUHPDYjNX/WuycNkMwgoA++8pJcf2Ng1qhHoq6DeQir+eqKiBMiBKc3+UD
 MzgE6mNlkBDJGukHVzHkP58RNbyYBylObeeDmrkKNBYuN+BbCe1audQV1sxjqGU+DaYG49cSTdn
 A==
X-Received: by 2002:a05:6830:618a:b0:7d9:d54a:f872 with SMTP id
 46e09a7af769-7d9fadee948mr7381418a34.13.1774884108219; 
 Mon, 30 Mar 2026 08:21:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a67f:a092:38d7:379e?
 ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a7b54a4sm6111333a34.13.2026.03.30.08.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 08:21:47 -0700 (PDT)
Message-ID: <f407414b-1aa4-427a-8f78-d863a0e2cd3b@baylibre.com>
Date: Mon, 30 Mar 2026 10:21:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] pinctrl: mediatek: print bias info along with pinmux
To: Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
 <20260313-pinctrl-mtk-fix-mt8189-v1-3-607dd37fde37@baylibre.com>
 <CAEHHSvbnYRXEgO3SZpgFO6njwfbEx-ocSeB-izotqVyQBBx2dw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvbnYRXEgO3SZpgFO6njwfbEx-ocSeB-izotqVyQBBx2dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 3/30/26 9:51 AM, Julien Stephan wrote:
> Le ven. 13 mars 2026 à 22:56, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> Add functionality to be able to print pin bias settings along with the
>> pinmux setting.
>>
>> This can be useful to debug why pins might not be working correctly.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 96 ++++++++++++++++++++++++++-
>>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
>>  2 files changed, 98 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
>> index 1028b8a93f5..ef4acc946a8 100644
>> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
>> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
>> @@ -237,9 +237,39 @@ static int mtk_get_pin_io_type(struct udevice *dev, int pin,
>>         io_type->bias_set = priv->soc->io_type[io_n].bias_set;
>>         io_type->drive_set = priv->soc->io_type[io_n].drive_set;
>>         io_type->input_enable = priv->soc->io_type[io_n].input_enable;
>> +       io_type->get_pinconf = priv->soc->io_type[io_n].get_pinconf;
>>
>>         return 0;
>>  }
>> +
>> +static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
>> +{
>> +       struct mtk_io_type_desc io_type;
>> +       int err, pos = 0;
>> +
>> +       if (!mtk_get_pin_io_type(dev, pin, &io_type)) {
>> +               pos += snprintf(buf + pos, size - pos, " (%s)", io_type.name);
> 
> why += ? pos is initialized to 0.  Same why buf +pos? and  size - pos?
> 
>> +               if (pos >= size)
>> +                       return pos;
>> +
>> +               if (io_type.get_pinconf) {
>> +                       err = io_type.get_pinconf(dev, pin, buf + pos, size - pos);
>> +                       if (err < 0)
>> +                               return err;
>> +
>> +                       pos += err;
>> +                       if (pos >= size)
>> +                               return pos;
> 
> Can't this be removed?

The idea was to make it robust against future additions. Should be
fine to drop it.

> 
>> +               }
>> +       }
>> +
>> +       return pos;
>> +}

I will simplify it to:

static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
{
	struct mtk_io_type_desc io_type;
	int err, pos;

	/* If we fail to get the type, then we just don't add any more info. */
	if (mtk_get_pin_io_type(dev, pin, &io_type))
		return 0;

	pos = snprintf(buf, size, " (%s)", io_type.name);
	if (pos >= size)
		return pos;

	if (io_type.get_pinconf) {
		err = io_type.get_pinconf(dev, pin, buf + pos, size - pos);
		if (err < 0)
			return err;

		pos += err;
	}

	return pos;
}

