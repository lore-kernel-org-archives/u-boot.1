Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5CBC44525
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 09:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97B89405CC;
	Mon, 20 Jul 2026 09:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mu2K3nW88qn4; Mon, 20 Jul 2026 09:28:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 876C7405B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784539734;
	bh=W1TPNEeal3Ev6dY3fugln9+PMLlyqkbL46/fS2t3I1s=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=szzWPSs+9aBf73dr7EmxATIPl8BJ0aI+DbVJIRiPIcDjHhZI94IpxfyuM2qe7EmJZ
	 i3G2mgkqtBrgPN5jHOi/9kKHMUDuhVhpDmaTzB8TczKerE5KZF3RJxZn6IW/g36Xls
	 frEXCoBAX5wLFrofbLRGCXKkkDtKUV/siYP7AYmW3R4MgtCtjrEX8AjBoQz4PIeLAp
	 2si8qRYNW7DUr04XnHy+3zHtdWfFrU9QLid6Qt+FnspZzmWgwB7Dy4tHD3QI6A2SLM
	 BvYf26RTJGARvTVOMvQXaHDB1Vw3DtFZEWJcpQY9MV+8lranC7o5JBXpUIAtYLnROq
	 qAJM+WPVVc0gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 876C7405B6;
	Mon, 20 Jul 2026 09:28:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 83106206
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 09:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60EE94004C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 09:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8Xz2SoiS6kD for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 09:28:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 37B6A40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37B6A40025
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37B6A40025
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 09:28:51 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47de008b020so2658603f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 02:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784539730; x=1785144530;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W1TPNEeal3Ev6dY3fugln9+PMLlyqkbL46/fS2t3I1s=;
 b=lBXRK0yO0O5BqF1T2a48H1oQJUy8ED44z0YAeOJsFm9QJZBjvSHx+p5IRR860Ys4mY
 WxyccnIs0BgLLSPDfHlDQ54U3cU5B98DcgkvHQhsOCix74Ekucn+qI5GkKY0VfKap+mN
 ABnRYdUWWagIYBxucomyUpyXGFDzkqw1rywxq06nk5pP3HsfariAX9DzjW/GLSHSPFC4
 Vmj9LekfqF6elVuhU/66BdtVl4gpdl4FqO3ugFv+4hgqRzO6HX0hXFhZfEQC9qCw5Hou
 CE+zJJc4vIrkDekY/uWXEbMhszi5njLC4dMB/uow/OW2rPlsJ38B7Y565d2L3Gra2r1s
 5MMQ==
X-Gm-Message-State: AOJu0Yzw5US6Xdtq7worqMgjINALR2N6no/tgS+aadwIdX385zRvY0Tj
 qa6V0gYkr+n+/xm167U5gj32NICSClAa4kDfnTqa4XOmq2QFFhKK5izCIsttcxkj5X4=
X-Gm-Gg: AfdE7cn6kdHnaoHGn39VMOcvFfiO+/MPSzZhtfinNIcJesKQ6h97F1uZuIwLqejYLel
 3Hh4bIflFkOcQhRURTM/jiw7V9FMMglmMSLRLnP2/i7NcrHEMGeC2dpk3nzkRLB25KI6MGAP/62
 wGDV3YVQvSybflphRNIbErnkyztFsLC4S9Wv18VdY4XewBnY3OCgsa2pwiOOykD69puvui4b3T/
 7E9Dwh4mEmAMxoUWpMCpTtts76CSurTYdGiL51dEuLGmvd8noVdVpH+wWK8P05aG9k6ny3hZrvU
 O7z/gJiEadKf6UkKyx8sg24ac4AtWyFgoV7rxiTPLedh2MGE/wvN9Fj99gZNcSb5GSJ+FwqCiR5
 DnUuTuTxFvDoxEdlJl8P2UjllvUHMv3wY8iRTVoW91hCSWI4oyQPNSDS5bwBBfas0a4KXpgzN/X
 /UzcsxE7IT0k3zmvHq2sSVlh8WdysbvY/eGhRIxWJNnV3/u5fR3amV36dI7Q==
X-Received: by 2002:a05:6000:178d:b0:474:bbbb:bf17 with SMTP id
 ffacd0b85a97d-47f62378c4bmr13591003f8f.0.1784539729653; 
 Mon, 20 Jul 2026 02:28:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6048:6804:bc89:a6b1?
 ([2a01:e0a:106d:1080:6048:6804:bc89:a6b1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed244asm27110706f8f.20.2026.07.20.02.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 02:28:49 -0700 (PDT)
Message-ID: <f68d14bb-515d-42af-bdc1-e6e17c2951d9@linaro.org>
Date: Mon, 20 Jul 2026 11:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] tools/patman: Migrate mailing-list to
 lists.u-boot-project.org
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>,
 David Lechner <dlechner@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
 <20260720-osuosl-ml-switch-v4-1-20ec1c334dd2@linaro.org>
 <CALeDE9OJ2xxq=2KNSPkvMHSgNOsOZ6KjkZGoUDZ-SjS+i0-qpg@mail.gmail.com>
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
In-Reply-To: <CALeDE9OJ2xxq=2KNSPkvMHSgNOsOZ6KjkZGoUDZ-SjS+i0-qpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784539730; x=1785144530;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W1TPNEeal3Ev6dY3fugln9+PMLlyqkbL46/fS2t3I1s=;
 b=FCCJ7Sk4zVzYVeLlLIxZ+uL1ysSeb6KIRB8/Fv7k9sqpr6zl+wLX9V0teEMNeA9YZZ
 hR7lfgpo86NnbBNjKeQ6QXN4mqEaPzz4WIUInKQmm50f3ttcysfVGGfFDxVgo9hVxdrG
 fcDPJCJXixhHP/9goHs8li2wmGhgbag/GQO6qlgQTYnzu4SLzjWN49X2f73H6dhYqiL9
 okbel8v25Uo4jsr9LBILfcbC2eaj5ZRD3DPqMQVI4/iSTzHPhYqrAIjvTQQiOxj3uJ1u
 /PjDnPtZTwyhko8Hiwju1niTWMjWapB051ejHYyGgU+a8ICjtp+u/3+YCbI/QzL9JYfJ
 HSmQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FCCJ7Sk4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>
Message-ID: <20260720092848.JEygYOxlYibrkOIzuiZICvwEHKtjnZIdSBKHG_cq9W4@z>

On 7/20/26 10:33, Peter Robinson wrote:
> On Mon, 20 Jul 2026 at 09:23, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
>> domain, so update all references of the list.denx.de to the new
>> domain in the patman code.
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>> ---
>>   tools/patman/settings.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/patman/settings.py b/tools/patman/settings.py
>> index 17229e0d823..fe65b1d3fb7 100644
>> --- a/tools/patman/settings.py
>> +++ b/tools/patman/settings.py
>> @@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
>>   def ReadGitAliases(fname):
>>       """Read a git alias file. This is in the form used by git:
>>
>> -    alias uboot  u-boot@lists.denx.de
>> +    alias uboot  u-boot@lists.u-boot-project.org
>>       alias wd     Wolfgang Denk <wd@denx.de>
> 
> Sadly I don't believe that alias is needed any more so should likely
> be dropped too.

I guess we can do a cleanup of all the legacy stuff after the migration

Neil

> 
> Peter
> 
>>       Args:
>>
>> --
>> 2.34.1
>>

