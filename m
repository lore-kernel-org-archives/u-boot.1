Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C182C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 09:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75823838D7;
	Mon, 20 Jul 2026 11:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zJ8+OUdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB15B83E76; Mon, 20 Jul 2026 11:28:52 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7037080517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47de008b020so2658602f8f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784539730; x=1785144530; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W1TPNEeal3Ev6dY3fugln9+PMLlyqkbL46/fS2t3I1s=;
 b=zJ8+OUdg54autGRdM9pL+CsiyOyUiQaFzgSe0u2f+3jLoSLTEQbMTjeCCfGhAvK6y/
 to8/sHjMttG6YRpXA/Jwm27d69ULKlcdN0LfqvPQmCH0F/ln0//ZuM6GZZ4w1wlkF5/d
 BpdgkS3uA0WsIG99Ws+OOSki3IWVr7KQaQakfZgK172mZJNWCZEFcmDINMRr3ZKwDLXN
 /2Fx6OfAmS6rgz2K/R83syFJpYJcktJvSfM6mYBL4CVBprcLFKajMn3ysljmPzcpP4Wf
 ktyCdDchMy60oHfzZ/1ozPfw8DqCN5rKdvKSRqwI++b7KNUBz/68I8ppPFtW6fz5XGgQ
 X6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784539730; x=1785144530;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W1TPNEeal3Ev6dY3fugln9+PMLlyqkbL46/fS2t3I1s=;
 b=ow8b5qjKhWhmX5I3tn9R7N18V4j13VBJ9gcfHtDYmKPOR+YobA0h6oHemUh78i7Wxa
 ufCRktRUpwoOzcCSKXSsR0ysK2/omCvp9wUbIGJw6g8rUZXvpCVTMdZlfU5JwGCk79nS
 M4tLxRjW1XNuoas2shrCblQZ00lqy521eniwWqSqcJqGp3OJA0+ubIuvQwsqKwz1iZ0C
 X2+7T0D6gJ05OvcWYBlG54QOEMX6kEcINWkO5jgdkudpXqc0bpQBOy5F5q/Hs6KZaMnS
 qTWTdjrz6CQ/XL3b+UQ0invAJDPxIEeqEglvTBB53a5oYyef9KN2RDK8LMvZD3VQG5QD
 RaqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWwf6Odro3d4iWWrfkWfjTZcDCUnVxTixKPttVrBhDefNdDKek+1g3r5I/s2e415ns/2c1VQI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4eKRLB9kM0fdgZSw4viqbu36vSUfOIZMRmjP9YeKLx27LEb+N
 xC1ZBy0Fg98GTMRq/sV09KSifuiWwvzw5Wvc2BFpSswQX+RDpgAsx4+0m60lnoi4uJE=
X-Gm-Gg: AfdE7ckoDjE34Ovr9elRSWLW2/eZ7OxfFYOMYlAlcagyguERVTXGI8QPxDoADBZdVYy
 xb6gqjemmOvbb0g0RzE1YRzE2mHnZJBTDJuB4T7sG4AJNZpBoZGOhoAx7TEQFkabs1JPGV4VX9k
 c5rP1t7T9qzR1/H7CgBeYv1cHd82JA0pVo24CCuZnykMCjlgIZSnovbSBctXKpLM207+X4mpc/s
 hvHgZRuQVe/IeBE/qOtmccMhNBEURWYvLixDf6WYFY8p7TDp8YB2ej9jmQWhZXAAMaCEE+k9ccA
 Gv8n4GIG/njCjCvHEK9Qra2rdD2yQG1n3e0S3lmEiyG9+w+g6u6Y2WGOymgo6LbGklM6lx3dzC1
 ka07MK3VLOk+PVJI1IxjLBpOO35nQjbwod9TKUHxFIRKi1oqnra0zEqNggwrBTsUmUlLehGdSwS
 /MvyNNdZkXUPwDEA+qEz5n5TW1OrmqMd/ikv0d14H/Xh9s9dPlbv7LavMRVw==
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
From: Neil Armstrong <neil.armstrong@linaro.org>
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

