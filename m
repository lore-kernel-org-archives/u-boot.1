Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09846D69119
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB4F897F3;
	Thu, 28 Nov 2024 16:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VNdVnQzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4318985C; Thu, 28 Nov 2024 16:37:18 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B31C89708
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ffc1009a06so14810771fa.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732808235; x=1733413035; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/0Zy3/GgINLKM6Y3J7LDoHXJMqFpAXVBbNX0MHZfozs=;
 b=VNdVnQzqH2bJeM5DVpce3j7qPF7WK/rTKquVeUxyfLQI05RhrdVO6moxFDOhpdD3B+
 z6SEzz4m17l65sQA3W2RyhDBNarHSV1qJV6O+vRi+XYI8ANsxuOhKR3rhhYQFLn2ecAb
 7wcUb2SfVubQTwyZOwnvlMJuCxmXWQtoHRXIcaImgYO7ox9g/TR3sG7xvJ9okreeVJ+3
 SbLAH/CWDPhjXq8ZERYVIn6ZV8mVkXV93Fg/7Iy89YmWza03Dy71Ksw3Lbm4YOGgkz7q
 n7mJx+X8IDrKn2el383vqlF8mN4hCx+1G5E7Tf/21cs6FyuI2sh0TA7sh545SK2M7LPf
 tY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808235; x=1733413035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/0Zy3/GgINLKM6Y3J7LDoHXJMqFpAXVBbNX0MHZfozs=;
 b=bgDFoAFSFMtdKQe738wAlyXWIUB6649hRFY6p73J2VTiv1DmMM0HRdTKtq4l3DTjRY
 NcyhRTsaepYIsaHBEBHM13bnj70C4mw6NfFKTSEINNtW2P8DNIQGif9RnuNnSNkVzrT2
 OSc73NIG+wRqH3y9dXwKs92OHKOUo5RYYkhOLI7fgPdgJLMZBKUskaljvLn67mI4y5um
 sAVaWtDuTfkgWDToehkbA9EeosFi3kA/W+bZUKOjh5j9VNgbnawWilYNNIhGkGuadMSp
 CmP8mjToa9MP/NPXCx8iqXkeNQL6H5qdslEVPKJMlU6W+M8Fv//wMEusl0mSkQDzPIYx
 gxJA==
X-Gm-Message-State: AOJu0YzwI56BLkHyoiYoDgbvmffwhI5efuJflQ+QiiT8AFg44uLbCZwY
 QyNB7/GpaWhMNSI5g1UTN4W02yB1QsiamR7UjF6OTIbD8nUwRoneTuFJQOZQ4zg=
X-Gm-Gg: ASbGncsi+OTZkhn3HUchfaZHO/BXjDlKHnMHkYWuniHovRCxjyp8HcEz/vIWWPxu5/g
 /0IzMgo6kCp2EEsBcjF535oGqhsVU3m3cBT99rZjHhNlgKZD/DGcSPzlAi/E1dZ/rKRhQi6Cb5R
 zufga6s2JAYucLsbyq9kZ6aUSraULR1LABRp/aEYdwYSyeWz5qF3lniYqn7Jbc7DrEvS08wXy46
 HhhoH0o8l3xbfEK1RKVaLy2Usa/CTu1gA1mLtteMa7+wH/w8VsftPodkCH6Terv8qsHxGg22wGs
 G6/n+dfRaKCCUplIlFcOUE96cE3lyQ==
X-Google-Smtp-Source: AGHT+IGY+rrW7C/Xas6C4Or3j3yY//HW/TABfk22Rq7b/FNoM7pNZPgv8F7cvGdP8Txm8ymd9fl/Fg==
X-Received: by 2002:a2e:ab0a:0:b0:2fb:5c84:929b with SMTP id
 38308e7fff4ca-2ffd60d2b4dmr68073271fa.36.1732808235203; 
 Thu, 28 Nov 2024 07:37:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:869b:f8c3:dc94:123a?
 ([2a01:e0a:3cb:7bb0:869b:f8c3:dc94:123a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59994e43dsm77231766b.177.2024.11.28.07.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 07:37:14 -0800 (PST)
Message-ID: <37f469bc-5610-401d-81c1-1e2a99ababdb@linaro.org>
Date: Thu, 28 Nov 2024 16:37:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] test/cmd/wget.c: move net_test_wget() to the cmd test
 suite
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
References: <20241115164514.2186763-1-jerome.forissier@linaro.org>
 <20241119155939.GA3493897@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241119155939.GA3493897@bill-the-cat>
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



On 11/19/24 16:59, Tom Rini wrote:
> On Fri, Nov 15, 2024 at 05:45:14PM +0100, Jerome Forissier wrote:
> 
>> Since net_test_wget() is testing a command and is in test/cmd it should
>> be in the 'cmd' test suite, not 'lib'.
>>
>> Saving and restoring the values of the environment variables that the
>> test manipulates is necessary to avoid a regression when running the
>> whole ut test suite. A minimal reproducer is:
>>
>>  $ ./u-boot -T -c "ut cmd net_test_wget; ut dm dm_test_eth_act" | \
>>      grep -E "(Test:|Failures:)"
>>
>> Reported-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  test/cmd/wget.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/test/cmd/wget.c b/test/cmd/wget.c
>> index fe26fee54c9..7570c065a10 100644
>> --- a/test/cmd/wget.c
>> +++ b/test/cmd/wget.c
>> @@ -19,7 +19,7 @@
>>  #include <dm/test.h>
>>  #include <dm/device-internal.h>
>>  #include <dm/uclass-internal.h>
>> -#include <test/lib.h>
>> +#include <test/cmd.h>
>>  #include <test/test.h>
>>  #include <test/ut.h>
>>  
>> @@ -206,6 +206,10 @@ static int sb_http_handler(struct udevice *dev, void *packet,
>>  
>>  static int net_test_wget(struct unit_test_state *uts)
>>  {
>> +	char *prev_ethact = env_get("ethact");
>> +	char *prev_ethrotate = env_get("ethrotate");
>> +	char *prev_loadaddr = env_get("loadaddr");
>> +
>>  	sandbox_eth_set_tx_handler(0, sb_http_handler);
>>  	sandbox_eth_set_priv(0, uts);
>>  
>> @@ -223,6 +227,10 @@ static int net_test_wget(struct unit_test_state *uts)
>>  	ut_assert_nextline("md5 for 00020000 ... 0002001f ==> 234af48e94b0085060249ecb5942ab57");
>>  	ut_assert_console_end();
>>  
>> +	env_set("ethact", prev_ethact);
>> +	env_set("ethrotate", prev_ethrotate);
>> +	env_set("loadaddr", prev_loadaddr);
>> +
>>  	return 0;
>>  }
>> -LIB_TEST(net_test_wget, UTF_CONSOLE);
>> +CMD_TEST(net_test_wget, UTF_CONSOLE);
> 
> I don't know why / how, but now this causes the "hash" unit test to
> fail, in both Azure and GitLab.

CI passed on https://github.com/u-boot/u-boot/pull/700. How do I reproduce
the problem?

Thanks,
-- 
Jerome
