Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E40FC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2866886CC;
	Thu, 29 Aug 2024 16:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lje7O4bN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74AB3888C1; Thu, 29 Aug 2024 16:34:30 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C27388481
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42bac9469e8so6582775e9.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724942067; x=1725546867; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=mOOvz5Hhlzvfm6mwAb8xt0DKJumZRJhbJ+WXfh788sU=;
 b=lje7O4bNNNIVKvq/nDJD+RzGCmXfC4zrAJjo+kJ2NWU3R0l6nJXlrsy0ey7Ep0ZZT0
 R5rbYnn+RGocOsLjmO4tFxE1QkoyYVXeE1yjl3P9vEA9YTbS4xA3i7Hjf9bFKEUGSaaI
 aijZ8OQQfYwKndwuR406P1zZd0pu82XrRHRzPMGyC8dgTpxWaNcxZhzhFc/Yf2q5cGeA
 2RpyqI8OAyzQCuqDv5JvJ6udX2yL8h151NrQ0fUR3klJ/srxpcCrxDe6oE4ZC4oM5djb
 LSvW5JiAz9MO0kVfRIqtxrVuMnJN+QiTOkQc6KJiXYWHWnTkn4W8o51e+tBGKAv7n83s
 JbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724942067; x=1725546867;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mOOvz5Hhlzvfm6mwAb8xt0DKJumZRJhbJ+WXfh788sU=;
 b=qhD0Yq8VCDzS+8iqpMIlU/jN/XWpTbRNd88yaOqNUC+YvYN+5T9A0EANCQJpIeGQ+p
 E3pmUvgl28vEJ018hD3KBrjDmnFTXS7Dl8fguoKU0fP3J0PHaA1dcVln+6qvW+kziwzi
 5ORzQGbqk21kvTfEOvAiAFc3v/LxAclLwPSCBxUjuJ+x4DuIp3C60EVH0OO2QIaR+bEB
 +Kv3HEy3Tryetr/6nfGD2kc7H1a9o/sLV/0LWB8nZld9hoggLQL7CyTcokvU8oyt+yAp
 wxO7jV0XuaAlGqjY9Pr4dA7LvPNB3XFw0cWj6pkpxESrUOvG3lK0HE6ROoekYkIgYTgM
 70ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa0kKVOimzrIiYupmKk6fnyIokXUzBvUz4vPmxlSnKe5BS53gmiHrBccolfQQ8Eh0bl3U90vM=@lists.denx.de
X-Gm-Message-State: AOJu0YwnUFl5w2b6CFFk4rm31rDkhj5bYccIolxy5j7uPXZnkCaOA7ym
 CfWxHFVuS39oqU9Sf9VFUenHUEJjQGQeyPb4XW68u+VWjiR5BxDgGDBCt9mSZYUbIxePLMgITf3
 g
X-Google-Smtp-Source: AGHT+IHqqcPMqB/fVIPgDRMxJuC8d4wXiKNIZAOQhZ9RgJh2yg5qMpf2tvLtjPOMZ4S4PhjMqjPneQ==
X-Received: by 2002:adf:fb4f:0:b0:368:3717:10aa with SMTP id
 ffacd0b85a97d-3749b531f0dmr1984426f8f.11.1724942066894; 
 Thu, 29 Aug 2024 07:34:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915?
 ([2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6399db8sm53458985e9.11.2024.08.29.07.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 07:34:26 -0700 (PDT)
Message-ID: <7e649530-02c5-4615-a141-d28dbd7285ce@linaro.org>
Date: Thu, 29 Aug 2024 16:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/20] test: Allow signaling that U-Boot is ready
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-2-sjg@chromium.org>
 <904f71d4-b2b4-428b-bb2f-31fe6d916135@linaro.org>
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
In-Reply-To: <904f71d4-b2b4-428b-bb2f-31fe6d916135@linaro.org>
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

On 29/08/2024 16:22, neil.armstrong@linaro.org wrote:
> On 29/08/2024 00:08, Simon Glass wrote:
>> When Labgrid is used, it can get U-Boot ready for running tests. It
>> prints a message when it has done so.
>>
>> Add logic to detect this message and accept it.
> 
> So labgrid can boot and wait for `board_type & board_identity` itself right ?

Sorry bad copy paste, I was meaning `Hit any key to stop autoboot: `

> 
> It's cool, but if the boots fails for a reason, what would happen ?
> Having the U-Boot pytest to parse the U-Boot boot log makes sure we can identify crash
> and report them in the pytest log.
> 
> And this adds a labgrid-only string to parse, which could potentially
> collide with pre-uboot or whatever log when not using labgrid.
> 
> Neil
> 
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> (no changes since v1)
>>
>>   test/py/u_boot_console_base.py | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
>> index 76a550d45a1..882d04cd1e9 100644
>> --- a/test/py/u_boot_console_base.py
>> +++ b/test/py/u_boot_console_base.py
>> @@ -22,6 +22,7 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
>>   pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
>>   pattern_error_notification = re.compile('## Error: ')
>>   pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
>> +pattern_ready_prompt = re.compile('U-Boot is ready')
>>   PAT_ID = 0
>>   PAT_RE = 1
>> @@ -196,15 +197,15 @@ class ConsoleBase(object):
>>                                       self.bad_pattern_ids[m - 1])
>>               self.u_boot_version_string = self.p.after
>>               while True:
>> -                m = self.p.expect([self.prompt_compiled,
>> +                m = self.p.expect([self.prompt_compiled, pattern_ready_prompt,
>>                       pattern_stop_autoboot_prompt] + self.bad_patterns)
>> -                if m == 0:
>> +                if m == 0 or m == 1:
>>                       break
>> -                if m == 1:
>> +                if m == 2:
>>                       self.p.send(' ')
>>                       continue
>>                   raise Exception('Bad pattern found on console: ' +
>> -                                self.bad_pattern_ids[m - 2])
>> +                                self.bad_pattern_ids[m - 3])
>>           except Exception as ex:
>>               self.log.error(str(ex))
> 

