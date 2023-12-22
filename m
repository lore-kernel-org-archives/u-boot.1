Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957F8C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A75887650;
	Fri, 22 Dec 2023 16:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lgCPNJxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D097A87579; Fri, 22 Dec 2023 16:55:59 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF0287650
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a234938c7f3so219902666b.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703260556; x=1703865356; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e1p7NHqzDMwkhzWPi8Y7J5bLsMJJa8aIi4Bd9y8MtRc=;
 b=lgCPNJxOSJCqWmXrg5m7B8rhkqNeRAPkRIN/bEjUl96ILwzjzxBW60FRJW5yJHGEbf
 N6/vQ0Zlg0S2jlricr3jyXbbtY9ViEuL/8JsdAuyP6T7XcAam8g7KtJ58CJiT0TGUeoQ
 4ctnFxngm2+46bVGiqeu9PQmhNKLWhVhZiFdFv9ehiX62XDhr94LmR1c0Ri5SGhBYOgF
 3BOH6DrlBUA+8rChg8B9Ww89zZnGMDHkc8+1HxZgoXNPAeUc1UofiodTX+QSmeOJx8Zm
 txK5zYz/y5OTvcUijbK9uqlp2Bfd1YuzZzbKU7i+QR1nJJMVd0wyhFwAoJRDcSrxZmfQ
 y20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703260556; x=1703865356;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e1p7NHqzDMwkhzWPi8Y7J5bLsMJJa8aIi4Bd9y8MtRc=;
 b=RFY3rhRxc7ejWDb4VvRH9DFCV3SGrW46GzOZYpho57kgiNjEVQLOWbOicI5apKHjvc
 /5CM4OSRoSsiAocfWVe4IIg+EGDDgG181iEs7qXa4fFe0z5vVy/komdhEKuyJW2BPXwY
 aKSW6j7QD+UIOJneZWdnEzSzLuKyLSf93+/A8BEZqnfwweeWA5ZwhhxBms9DlrhbPftW
 mjysok6kiZ3Qz2m14YUS6XL7lyhKT1/37CHyEA7m+fw6zgMDQrAN2/5GXrti/rOI9oi9
 wO0nknjK8VeUM0um1y+gIYin4jG2ueU0fZPBiZB5XRZFsauxvs/HSC5SaKSBlpmTUfPo
 mTtA==
X-Gm-Message-State: AOJu0YyYMZX2bLSfP6WqjMw01HjA8F4fathuapmBRKaps01Xi0IOLpew
 o7Hfhfju4yIoOdarYn3U0yFF6Z7GEAk63g==
X-Google-Smtp-Source: AGHT+IFCiifGEShPlOmCbXPY/4nhseFXIuPB/ZNWk+C3QxzmBZH5vaAOo8P8mprrUxTbMgPt/z9T/A==
X-Received: by 2002:a17:906:1c0d:b0:a1f:7fbb:7f92 with SMTP id
 k13-20020a1709061c0d00b00a1f7fbb7f92mr830742ejg.117.1703260556659; 
 Fri, 22 Dec 2023 07:55:56 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
 by smtp.gmail.com with ESMTPSA id
 rh9-20020a17090720e900b00a269e87ad84sm2162877ejb.189.2023.12.22.07.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 07:55:56 -0800 (PST)
Message-ID: <d91437da-137c-411f-adce-8bd5d1069a41@linaro.org>
Date: Fri, 22 Dec 2023 16:55:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within
 U-Boot
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
 <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
 <20231222154614.GA2652760@bill-the-cat>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231222154614.GA2652760@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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

On 22/12/2023 16:46, Tom Rini wrote:
> On Fri, Dec 22, 2023 at 04:38:01PM +0100, Krzysztof Kozlowski wrote:
>> On 22/12/2023 14:43, Sumit Garg wrote:
>>> On Fri, 22 Dec 2023 at 13:48, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 22/12/2023 07:12, Sumit Garg wrote:
>>>>> Changes in v2:
>>>>> --------------
>>>>> - Patch #1: excluded gitab CI config check and added commit description.
>>>>> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
>>>>> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
>>>>> - Patch #5: s/U-boot/U-Boot/
>>>>> - Patch #6 and #7: Picked up review tags
>>>>>
>>>>> Prerequisite
>>>>> ------------
>>>>>
>>>>> This patch series requires devicetree-rebasing git repo to be added as a
>>>>> subtree to the main U-Boot repo via:
>>>>>
>>>>> $ git subtree add --prefix devicetree-rebasing \
>>>>>       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>>>>       v6.6-dts --squash
>>>>>
>>>>> Background
>>>>> ----------
>>>>>
>>>>> This effort started while I was reviewing patch series corresponding to
>>>>> Qcom platforms [1] which was about to import modified devicetree source
>>>>> files from Linux kernel. I suppose keeping devicetree files sync with
>>>>> Linux kernel without any DT bindings schema validation has been a pain
>>>>> for U-Boot SoC/platform maintainers. There has been past discussions
>>>>> about a single DT repo but that hasn't come up and Linux kernel remained
>>>>> the place where DT source files as well as bindings are placed and
>>>>> maintained.
>>>>
>>>> Thanks for doing this.
>>>>
>>>> I really suggest to store information that kernel DTS is directly
>>>> re-used, thus DTS backward and forward compatibility matters, also in
>>>> Linux kernel sources. The point is that sub-arch maintainers should be
>>>> aware of it. I don't think that as DT maintainers we can efficiently
>>>> keep an eye on it. Maybe create a subsystem profile and include it to
>>>> maintainer entries of such affected platforms?
>>>>
>>>
>>> From U-Boot point of view, currently we have the config option:
>>> "CONFIG_OF_UPSTREAM=y" per platform which means directly re-use of
>>> kernel DTS. So U-Boot sub-arch maintainers should be aware of
>>> platforms which get converted to re-use kernel DTS.
>>
>> I was speaking about kernel.
>>
>>>
>>> I suppose we have to relay information to kernel sub-arch maintainers
>>> who aren't the same as maintaining U-Boot counterparts. How about
>>> adding U-Boot ML to CC for whichever DT change gets submitted in the
>>
>> And every other project? Just setup lei filters.
>>
>>> kernel? Otherwise adding U-Boot sub-arch maintainers as reviewers for
>>> corresponding kernel DT changes works too if that's acceptable.
>>
>> You just entirely ignored my proposal without addressing it... ok let it
>> be. No, CC-ing U-boot maintainers changes nothing because as I said, I
>> want kernel maintainers and contributors to be aware.
> 
> Maybe an underlying question is, what kernel maintainers aren't aware,
> but should have been already? Then we can figure out how to address

None of them is aware.

> that. For example, with your Samsung hat on you weren't aware that
> exynos 4/5/7 DTS files are cared about by U-Boot, but are now aware.

Hm, I am still not aware of this. I mean, you wrote it above, but it is
the first time I see using directly usptream DTS for U-Boot on Samsung
platforms.

Did anyone test it actually? I certainly did not. I think this patchset
did not remove U-Boot-tree Samsung DTS, did it?

Best regards,
Krzysztof

