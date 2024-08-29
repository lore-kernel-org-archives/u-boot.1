Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E2C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE8788C0B;
	Thu, 29 Aug 2024 16:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U+5USJyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F3588BCD; Thu, 29 Aug 2024 16:44:34 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF7E889A7
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso6825445e9.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724942671; x=1725547471; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RJy5WnBzkWs9iLpxwbWJAnXTgoGcq+FbWhbWDxeQpbI=;
 b=U+5USJytmupH4VpwLnt4VzJh5t5j/NMHWwdF8F6IcXiq8lk036HZOkLWceyWXG4AAy
 Q116IjYxoOPw1ONTRvXGVdcxyl0fmwhO8mCWeCess/haEn8Us/yQi+LJWkhItRXq2tsF
 Baj2CFLbuNMi2DM9+sbqT5C6wpuodY5T0LLqb6cPvmViL0kxSMHH1pQ0+5LEOrDqTT9o
 2qk1V0ZisPwj/CLDiibUFktF7vg2c10nO+7SG44rbIjaikSA/NzTE9oUi40pwfGVbvtk
 R7uhjkBN4FcvM4oxUSBsy9m3a01TlLoOVD5DheOK0z3xYy2U4XlYJaQvWz8ZrySNUH+t
 lrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724942671; x=1725547471;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RJy5WnBzkWs9iLpxwbWJAnXTgoGcq+FbWhbWDxeQpbI=;
 b=j3ZDg100nteh/RMpIj+hAfaGe4A+gbtTAJyKu/120+K7zLdC4eYS5O4y2wfiMgLhJm
 OAyw9T9rEvFg5nLzKBfqZIrmKi4Qmlf6p/QlnQqNwHiibZIqetTa6OTbBi1NU2BT8+1A
 g/3XjJUNYrq4EZaAGSZDweKq0o68YWTbi2tO42HTcktUzt1O7vLEzQN/4VCTsEqQ8meU
 sx/zRAqtSjyHCGxWpGYqSB7hdCzdpWQajrp9heAymOwKnW9XR5E01iDVmu3OYUt3LJXo
 MGVVd9hckdPVCTjTnD45C4e2d+KFKdf5Ec3AWjQASzCbErLriXwaXn4Tt2TaPCrZrvV+
 TAwQ==
X-Gm-Message-State: AOJu0YzqEeFRjYjrzYQ8D2KbsfeQNqfXKpejU2oCag9TMSSpXlhasslN
 5h/L97tHpBsEram+fpT6WIAp6XZpbDx5UPcNw+YEVp6+nq14TZTnwRSgCWGdkY4=
X-Google-Smtp-Source: AGHT+IE4PpUekYYQegFHwUfz1rgVY7qEWj2k9vs9wAbo13L9hpTlXbdiU1f/J93JscZWIdPdpK8luQ==
X-Received: by 2002:a05:600c:3c88:b0:42b:ac94:692c with SMTP id
 5b1f17b1804b1-42bb0205b6amr28234745e9.0.1724942670591; 
 Thu, 29 Aug 2024 07:44:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915?
 ([2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb1ebsm19517435e9.3.2024.08.29.07.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 07:44:30 -0700 (PDT)
Message-ID: <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
Date: Thu, 29 Aug 2024 16:44:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
 <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
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
In-Reply-To: <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 29/08/2024 14:17, Simon Glass wrote:
> Hi Peter,
> 
> On Thu, 29 Aug 2024 at 04:43, Peter Robinson <pbrobinson@gmail.com> wrote:
>>
>> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> Hi Peter,
>>>
>>> On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>>> With Labgrid we don't need to specify the various methods, except for
>>>>> the console, which simply calls labgrid-client.
>>>>>
>>>>> This allows supporting any boards in your lab, without adding per-board
>>>>> configuration to these hooks.
>>>>>
>>>>> Provide ellesmere files as an example.
>>>>
>>>> What's ellesmere?
>>>
>>> It is a lake but also the name of a computer.
>>>
>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>> Changes in v4:
>>>>> - Support pytest fully with dual-build boards like Beagleplay
>>>>>
>>>>> Changes in v3:
>>>>> - Update scripts for latest version of Labgrid integration
>>>>> - Add poweroff.none and poweron.none
>>>>> - Provide -n flag when querying board info
>>>>> - Target the grpc version of Labgrid which is now in -master
>>>>> - Update README to cover the changes
>>>>>
>>>>> Changes in v2:
>>>>> - Make use of the common script (only) to set bin_dir
>>>>>
>>>>>   README.md                    | 50 ++++++++++++++++++++++++++++++++++++
>>>>
>>>> Maybe that should be in a separate labsgrid readme?
>>>
>>> My hope is that Labgrid becomes the normal way of running these tests,
>>
>> Generally I agree with automated testing platforms, I think <insert
>> you're preferred platform here> makes sense, there's a bunch like
>> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
>> bunch more that I'm aware of.
> 
> I am somewhat familiar with LAVA and I believe it can be used to test
> U-Boot, although I need to learn how. Looking at a test run [2] for
> beaglebone black I see that it is using a recent kernel but the U-Boot
> seems to be older.
> 
>>
>> Does it make sense, of course at some point in the future post this
>> being merged, make sense to look at a general way of making it easier
>> to plugin these sort of HW test platforms using this as a basis? I ask
>> mostly because putting a bunch of my devices into some sort of
>> platform can auto test things and of course everyone has an opinion to
>> which is the best one :-P
> 
> Yes. I had heard from Tom that Labgrid is the new hotness for now.
> Having dug into it I believe it is a good solution, although it can
> certainly be improved to handle scale better.
> 
> Anyway, IMO the current test hooks are not a great solution, just
> because the configuration is spread all over the place and it relies
> on lots of little shell scripts. So I believe that the Labgrid
> integration is a closer to where we want to be with others that come
> along.

I'd say all those scripts are actually here to ease integration with any
system, booting U-Boot and Linux are two different beasts.
Most of the time you need special jumpers enabled to setup vendor-specific
bootrom mode to reflash or ram-boot U-Boot.
So forcing us people to switch to Labgrid because it matches your boards
behavior is a little adventurous, and while we can add some enhancement
to the actual pytest and hooks, I'm against saying Labgrid should be the
golden CI system.

Neil

> 
> I would love for you to add a board into Labgrid and see how you go.
> 
>>
>> [1] https://validation.linaro.org/
>>
>>> so having it in the main place (and perhaps eventually removing the
>>> old way) is my goal.
>>>
>>>>
>>>>>   bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++
>>>>>   bin/ellesmere/common-labgrid | 46 +++++++++++++++++++++++++++++++++
>>>>>   bin/ellesmere/conf.all       | 24 +++++++++++++++++
>>>>>   bin/getrole.labgrid          | 25 ++++++++++++++++++
>>>>>   bin/release.labgrid          | 22 ++++++++++++++++
>>>>>   bin/release.none             | 22 ++++++++++++++++
>>>>>   bin/u-boot-test-getrole      | 38 +++++++++++++++++++++++++++
>>>>>   bin/u-boot-test-release      | 26 +++++++++++++++++++
>>>>>   9 files changed, 295 insertions(+)
>>>>>   create mode 100644 bin/console.labgrid
>>>>>   create mode 100755 bin/ellesmere/common-labgrid
>>>>>   create mode 100644 bin/ellesmere/conf.all
>>>>>   create mode 100644 bin/getrole.labgrid
>>>>>   create mode 100644 bin/release.labgrid
>>>>>   create mode 100644 bin/release.none
>>>>>   create mode 100755 bin/u-boot-test-getrole
>>>>>   create mode 100755 bin/u-boot-test-release
>>>>>
>>>
>>> [..]
>>>
>>> Regards,
>>> Simon
> 
> Regards,
> Simon
> 
> [2] https://validation.linaro.org/scheduler/job/4089871#results_482796468

