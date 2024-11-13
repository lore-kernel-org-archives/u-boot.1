Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0435D41C3F
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2941788DFA;
	Wed, 13 Nov 2024 14:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uQamIo2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CE48916C; Wed, 13 Nov 2024 14:09:01 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AAAD88CEC
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so1264939a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731503339; x=1732108139; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OhwnWXDFGoiHG0lWV9k0y9zubA6BPinpV1D4t4jISsQ=;
 b=uQamIo2rQ+C4epnkCaizjUUxgYHivq6qW2EiBomP85BB8XdVEpYZCqK1vA3PE1m5Dr
 nSYos7V7XniXSyoNmG50U94mRsYWJ61NEdCsURK5ZNxrcZRRWWs8BX8Qh+yp7h6cqJql
 tU222h80WdjntXafkilHVuknziUcskMXtTenLWy0GUM8t92VMm6J90cqNZxqfaK7QksU
 0plAY49KKa8Ho2qkm5ItMyWI+xWk+2weswbCuGmUpuMk37HYLj4R9+qJWL3f2nn8pMVz
 0N2zjbUfvYhrXgomi00L82/XzR+iU949ak9ZaiW5QCJ8gbMRC4MV/HUk4rgMog1SC0LJ
 asEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731503339; x=1732108139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhwnWXDFGoiHG0lWV9k0y9zubA6BPinpV1D4t4jISsQ=;
 b=WZVJ3bJwqtYGf97QpVmiBDymX3+CLG+DPQNHhUD2VMT31u6YZvmDElIcaqcRmFcALQ
 xUgT3JrNqa/F5yLidzEOiOMrWdCyiK8JrLNU6P/rUVTB33MP1nniUG7uhu06znTWFAaD
 2njLMv7RQG250gn1+y9e1t8k8fwdaRzsWqpJQ/fgCsWX77w9adYcdujd6p55GbP3xip+
 6Aqd3PZYJA6DgK9xhbVQVXJBPW0W4/x9PoXCEiEz0O0SBgJLvhO2OUWD9SXrXUQaE4pa
 eMvVU2CJqafvka3MPlF22cLi9U39SmQi152vTBi1Kqi425qCVmK+LhgPqWAJ8okGOX1A
 WpNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBSCe0du1Y21pgsNqPqHCOcvMFm2r74dCfxEzd5CUQG31uekDWe4V7yfNuYzdACHKYtM5QNeU=@lists.denx.de
X-Gm-Message-State: AOJu0YxKQGQDOOC6UJsy2XM+WDB+Znc9K2uBXKL7Z0Zg2VL2XbaxNXju
 4SE45HrU5TMakYPauf7MO9HuhL+iD9TQbVIG2fzA+26nk1DcLlVZb8ENz3ASn0w=
X-Google-Smtp-Source: AGHT+IG7bs4KaQ9Y+zNL3h5djjYX7G1/kKUV+XpDBkxTi2bAO5CsMsmR++WtJ3EXUS8tRaS8mOF4Fw==
X-Received: by 2002:a05:6402:d05:b0:5cf:84c:b7bf with SMTP id
 4fb4d7f45d1cf-5cf0a50d208mr18209413a12.15.1731503338812; 
 Wed, 13 Nov 2024 05:08:58 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c4f0bdsm7118634a12.56.2024.11.13.05.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 05:08:57 -0800 (PST)
Message-ID: <19f15ca1-5354-4ee5-9ea1-dc94d6905afc@linaro.org>
Date: Wed, 13 Nov 2024 14:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
 <50f69678f0fbb74aecc2e2aeb5f4dc6b@manjaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <50f69678f0fbb74aecc2e2aeb5f4dc6b@manjaro.org>
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



On 13/11/2024 10:48, Dragan Simic wrote:
> Hello Caleb,
> 
> Thanks for the patch.  Please, see a comment below.
> 
> On 2024-11-13 06:30, Caleb Connolly wrote:
>> It may be the case that MMC support is enabled even though the board
>> we're booting on doesn't have any MMC devices. Move the print over to
>> the print_mmc_devices() function where we can only print it if we
>> actually have MMC devices.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  common/board_r.c         | 1 -
>>  drivers/mmc/mmc-uclass.c | 4 +++-
>>  drivers/mmc/mmc_legacy.c | 5 +++++
>>  3 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/board_r.c b/common/board_r.c
>> index 62228a723e12..232a8fd19f03 100644
>> --- a/common/board_r.c
>> +++ b/common/board_r.c
>> @@ -384,9 +384,8 @@ static int initr_onenand(void)
>>
>>  #ifdef CONFIG_MMC
>>  static int initr_mmc(void)
>>  {
>> -    puts("MMC:   ");
>>      mmc_initialize(gd->bd);
>>      return 0;
>>  }
>>  #endif
>> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
>> index c8db4f811c2f..56fe29249c36 100644
>> --- a/drivers/mmc/mmc-uclass.c
>> +++ b/drivers/mmc/mmc-uclass.c
>> @@ -384,9 +384,11 @@ void print_mmc_devices(char separator)
>>           dev;
>>           uclass_next_device(&dev), first = false) {
>>          struct mmc *m = mmc_get_mmc_dev(dev);
>>
>> -        if (!first) {
>> +        if (first) {
>> +            printf("MMC:  ");
>> +        } else {
>>              printf("%c", separator);
>>              if (separator != '\n')
>>                  puts(" ");
>>          }
>> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
>> index 8f8ba34be717..f4a049a4a4d4 100644
>> --- a/drivers/mmc/mmc_legacy.c
>> +++ b/drivers/mmc/mmc_legacy.c
>> @@ -98,8 +98,9 @@ void print_mmc_devices(char separator)
>>  {
>>      struct mmc *m;
>>      struct list_head *entry;
>>      char *mmc_type;
>> +    bool first = true;
>>
>>      list_for_each(entry, &mmc_devices) {
>>          m = list_entry(entry, struct mmc, link);
>>
>> @@ -107,8 +108,12 @@ void print_mmc_devices(char separator)
>>              mmc_type = IS_SD(m) ? "SD" : "eMMC";
>>          else
>>              mmc_type = NULL;
>>
>> +        if (first) {
>> +            printf("MMC:  ");
>> +            first = false;
>> +        }
> 
> Can't we simply check for "entry == &mmc_devices->next" here and
> avoid the introduction of "first"?

That would be clever, yeah I can do this in v2.

I hvaen't found a way to test mmc_legacy thus far, does anyone know how
I could?


> 
>>          printf("%s: %d", m->cfg->name, m->block_dev.devnum);
>>          if (mmc_type)
>>              printf(" (%s)", mmc_type);

-- 
// Caleb (they/them)

