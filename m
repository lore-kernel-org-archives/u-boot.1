Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303D0C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 10:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D6182E26;
	Tue,  5 Aug 2025 12:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n1Pdpu5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78E1B8307F; Tue,  5 Aug 2025 12:15:46 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ED5B8144A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 12:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso20603555e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754388944; x=1754993744; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yZxMz5VDtOORukztCD1/TwF5qW3FlQiND+yXBG0Wwbc=;
 b=n1Pdpu5DFBKTF9KaB5VNAJ1CH/IBsEQ8n2tIecC7RRVLIwGzanClp1IsHp1L5Lgeuq
 /ziBnhSUSKcfCMQ+e6b98yEpahJJoKX8b1Gmzf1agKkjP/H06hlTd1wb4Fmeu5ijlPTY
 Pouf9fAdXOQXr9KihYhUonXYDCfHGQzEf9lxxuQ9h2n4KLFsZCx75AHcEG2TAMEmLTey
 8G4VdxCtWl2I5qRPRyriOkIy3uZrCUSSlL0OQshDiD+8pFJHH6Hik5GytxPB5DtF+Hek
 oqrgF1QfFZh0XEqWVCgh0079Ho29n8s5MMzu4FVbTGT+pmHxYKx47owjopevKhcJvlE0
 YA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754388944; x=1754993744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yZxMz5VDtOORukztCD1/TwF5qW3FlQiND+yXBG0Wwbc=;
 b=PPrDDzPjG5+ldWCP+bW1RoaBvk2l/24JQLpej9F8WIw8kSPUciV0juHOjmuQzBGIGc
 YCVeZA8q29uq1l5Mw7cgPXoRNtIfl9TNdWKOADaHIQnMoIEC8i2Gm0rLFa7Dz2CBAoTY
 dceLZ0GVEsmx+u70nSOIeu1Z7JPuqX8POEZf0dUGhVCWe9LIKJMG6/HurQv2Mf2rw519
 Z2h6rhdkPzOEAL5N8fZF3jsSw43V3Gb/lRjFznP8k+iPwzZznIlkyqO6kZbhf+g5xqFM
 Iz4Q8TM5qZWsT8IrEiB8zRidru+Mg7p+3m6rvgQBe7aXmvC5hiVrCUoeQhHdfAUyTWf2
 PSJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2AAwjVyh7e1+Oz/kkaPkUMD5cm0UyxGuMHgWsZJJ0g5vs9rCJmzYeMgXHSSZcGDP/FHsNs9M=@lists.denx.de
X-Gm-Message-State: AOJu0YyRw7glmabUjIbz5N3sb5ZEv3n6NDZYpQUl4B/BITRcwnwsd5i3
 D5/uLWpQuug7cuMEKojgVj1EPap6MNHXJg6twDt+1EyaWXL9WmOvrV66QbxiBs5+/GM=
X-Gm-Gg: ASbGncsYS0kvQsQ1A90pKItLL+6d1iImV69o3Hgyvp5yh3+xko2T0RJMJDsnNgPX/Gx
 u0KKlr5jQKbYIyKgfO2NoVMQhrZP5V/wvp8RLkCWbjILts5PeLxlO8tqY/uoj/NvMrUQGHKwdUZ
 NfC5mTq/1zshIslcVPSNMM1+/PVA//V5+DMp94hAxyNueAM+x6UnGqLuJC4C1aFybM7HO0XEFmM
 rhpSzqIE2OChS5r+il+eNryjNM3lSP5Mxx/Y9kYLm5P1lEXmf9tvOeUlo5A0tXUeXlPsLyZD5V1
 Hdt736EIa4e2ytOK7X59LOrOhxQ8rlDCA7xiOcWp5twb1Ig2Mo2s3qLjjvM7hLYme/vCO5wZsGy
 5jrwrNhvjpOmn6PSsICCKs0+0wrx2r/l2BAIsU1T78GCrZm+Rl9KaIQmaKNbnL8jh4zKCC6Xi8n
 a9zI/Np9PMK7mv
X-Google-Smtp-Source: AGHT+IHRA3hpuCj1Va3kXBHH7VSZeHp9FO/1kCC8/PQSxAc191ZcT+gJp30k4JK1dDyZorjAP94LVA==
X-Received: by 2002:a05:600c:3552:b0:458:bfe1:4a82 with SMTP id
 5b1f17b1804b1-458bfe14d61mr89880975e9.16.1754388943913; 
 Tue, 05 Aug 2025 03:15:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35?
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453333sm19325053f8f.45.2025.08.05.03.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 03:15:43 -0700 (PDT)
Message-ID: <4f1532e8-90c9-4f85-bc31-79fa62129536@linaro.org>
Date: Tue, 5 Aug 2025 11:15:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Smatch error report in drivers/misc/imx_ele/fuse.c
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <876b019c-4505-43cd-9247-3a63991e664c@linaro.org>
 <20250805034429.GA29103@nxa18884-linux.ap.freescale.net>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250805034429.GA29103@nxa18884-linux.ap.freescale.net>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 05/08/2025 04:44, Peng Fan wrote:
> On Tue, Jul 29, 2025 at 12:18:39PM +0100, Andrew Goodbody wrote:
>> Smatch reports the following error.
>>
>> drivers/misc/imx_ele/fuse.c:218 fuse_sense() error: buffer overflow 'data' 4
>> <= 7
>>
>> Looking at the code I can see that at line 198, word is checked to be less
>> than 8. Later at line 203 data is declared as a 4 element array. Then at line
>> 218 word is used to index into data which means a possible out of bounds
>> access if word >=4.
>>
>> There seems little point in increasing the array size of data as
>> ele_read_common_fuse will only ever read into the first 4 elements of the
>> array.
>>
>> So I am not sure what the correct fix is here. Is there any guarantee that
>> word will be < 4 in the case of word_index == 1? Or should this be an
>> additional check?
> 
> In ele_api_mapping_table, OTP_UNIQ_ID is already limited to 4 as max,
> so no issue.

Ah, that's good. Thanks for checking and explaining.

Andrew

> Thanks,
> Peng
> 
>>
>> Thanks,
>> Andrew

