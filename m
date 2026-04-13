Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EECF34C52
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0337484199;
	Mon, 13 Apr 2026 15:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IlSRMXug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BC78419E; Mon, 13 Apr 2026 15:22:22 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C868407D
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so48393115e9.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776086539; x=1776691339; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WTGAz2kdE63KmTATzRchWbrfz/3BTKGWMRmXbE+7rCI=;
 b=IlSRMXugUoQaJDPGlOgLRoegWKycO6MeGQdDYkzd6SHohnSCoq4Xr8CpVlxHPLpGZ5
 wnFWV5rwzhnaw3+ue0OYZAX4NknRvlhozWOHfEuChPDVD9SjF6ode5XUQSI3WyEIMkxN
 D/w/bLKQda+mkUK8650w08r/gIThvYIoraTJfHEw2tkg6pUUXCF6bUgtMiPXRx4Y18QM
 DM96UkCh+n9hK9wFwWVnXrDadcwxI3R4gqYOYxTkXYHXyAq3Ng/gfWVkgx80txQjlC45
 861XcgVwgPo/FyCrmm/t8MtiI1G/5uBvikxbMV3ltwKzipul1JksjbCy97qZXUFh9Y0S
 PVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776086539; x=1776691339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WTGAz2kdE63KmTATzRchWbrfz/3BTKGWMRmXbE+7rCI=;
 b=MBswGayDP/1Kqt7harubiLxeQBZn4OmiNiDfhMssoP3cey8vZDc0/SZiobwPGZeHaj
 jweaL90FtS4te0Pn/m/MfmmhrlS58rXdHi2bsldj7s+9rebzju0YuM9/rFY+r1h+THO3
 ql4a6mTTp94h9zvCbesDXcdLvYomvrn52mfY4ngMPoRWrgCbNzu3hejYe2weekPKDDEL
 kNVu/rcRUP+yimIVWo4rW+Vrmgfl0eIwxs12lKcFQrCHDsmkaSacg2lZZxhLKFUgrDE+
 h4wTQc8x4fNbwJJePFMax7jbggwNQiwmP9F7L99oqoFe8AUc5XxFENJP9OjNCqnUSZk1
 Pjeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XW3YPh1afTOZGAxM7kSPakDTTa25u6iwplDjrU2+nOTVQheYoqQEJCjTyuBhqC2TBRecHjgE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1KWeaRapP3WPlXG88QIl+FjB1gQPPZlV/6oTO67w1TxM5f1r3
 11fxJD8aQmlNCphfdkXiqGMna81U3y4JImzY0QzWnGNZ0B2jNWq9USn0zQo42Bngiho=
X-Gm-Gg: AeBDievbMWrTrkTyGBvXiz/9TnkT7uUJGf6vguGIUFTwteSRwNOP1HaR6E62h84NKG9
 GuK76T1kKeKPymo0BpDSzkIxM4NvuFO5E3V2+Vymq+BQXXT+cahPMtrk4jlEjYn+Z7umOGtzWnd
 6bwp1SQxpvrVulztftYBvTHQpe9kBKveNUh6crNHU7eOGQsJeCP4uq3Pvb+c9LgCnFlgKdgmLZ0
 Zcb+X9lErY1qLX1/2SAFt2Kc9dHv7ODVlr9wzwR9k1A5hSqCmI+tvwLqAeJUYoWctdoJrnnQsQ1
 Sb37BVDARWhdQIsdb7CvUHnmE8TaZVYjt+h4kDrWJKFAk1M+p1b9r2k6pHpb/kkn3sLiJdptV4a
 0m1vThKXrImqzx0KNtlPG8UFR+9olNtXq4IqADUQmJEeHjjGgGFa/a+raMy4Ij86xaEmKHFTz3K
 JNaIYjHjwD8y8klKisjh6Pk+TTiccpXJKcyCGPkS7vbbtb2G+bIUalO+tgq7i1ceDl8HNSs+fGb
 +pE
X-Received: by 2002:a05:600c:a411:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-488d67ec72cmr144823235e9.5.1776086538967; 
 Mon, 13 Apr 2026 06:22:18 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67ced32sm132822005e9.7.2026.04.13.06.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 06:22:18 -0700 (PDT)
Message-ID: <2abdf020-3181-43ac-9759-8e64df8b47df@linaro.org>
Date: Mon, 13 Apr 2026 15:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: cmd-db: Add optional support for device
 programmer flows
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com>
 <177608330028.1177412.9846637830549940803.b4-reply@b4>
 <adznF-hzUtiZ6QaV@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <adznF-hzUtiZ6QaV@sumit-xelite>
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



On 13/04/2026 14:52, Sumit Garg wrote:
> On Mon, Apr 13, 2026 at 02:28:20PM +0200, Casey Connolly wrote:
>> On 2026-04-09 21:15 +0530, Balaji Selvanathan wrote:
>>> Add QCOM_COMMAND_DB_OPTIONAL Kconfig option to allow the Command DB
>>> driver to bind successfully even when CMD DB data is missing or has
>>> an invalid magic number.
>>>
>>> This is required for device programmer flows where U-Boot runs
>>> without AOP (Always On Processor) being invoked. Since AOP is
>>> responsible for populating CMD DB data, device programmer scenarios
>>> lack valid CMD DB and would otherwise fail to boot.
>>>
>>> Normal boot flows should keep this disabled
>>> as they require valid CMD DB data populated by AOP.
>>
>> Presumably this is only used for development and isn't meant to be a supported setup right? In that
>> case how about just using a normal macro rather than a whole kconfig option, then you can just
>> build with make CCFLAGS=-DQCOM_CMD_DB_OPTIONAL=1 or something?
> 
> Looks like the commit message lacks to describe the motivation here.
> This patch is a preparatory step to allow U-Boot to be used as a device
> flashing/provisioning tool. In that environment, there isn't TZ or HYP
> stage running and U-Boot is expected to be launched in EL3.

Hmm I see, so we just rely on BROM to set up the necessary regulators
and deal with the error spam? How does the firehose loader handle this
(is it equivalent?).

Maybe it would be best to send this along with the rest of the code
necessary to enable that functionality, it would be good to get a better
idea of the architecture here.

Kind regards,

> 
>>
>> Kind regards,
>>
>>>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>>  drivers/soc/qcom/Kconfig  | 16 ++++++++++++++++
>>>  drivers/soc/qcom/cmd-db.c | 10 ++++++++++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index 8243805e46a..239d87e044f 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -18,6 +18,22 @@ config QCOM_COMMAND_DB
>>>  	  resource on a RPM-hardened platform must use this database to get
>>>  	  SoC specific identifier and information for the shared resources.
>>>  
>>> +config QCOM_COMMAND_DB_OPTIONAL
>>> +	bool "Allow operation without Command DB data"
>>> +	depends on QCOM_COMMAND_DB
>>> +	help
>>> +	  Allow the Command DB driver to bind successfully even when CMD DB
>>> +	  data is not populated or has an invalid magic number.
>>> +
>>> +	  This is useful for platforms where CMD DB is not populated by
>>> +
>>> +	  When enabled, missing CMD DB will generate warnings but allow boot
>>> +	  to continue. Consumer drivers must handle cmd_db API failures
>>> +	  gracefully by checking return values.
>>> +
>>> +	  If unsure, say N. Most production Qualcomm platforms require
>>> +	  valid CMD DB data.
>>> +
>>>  config QCOM_RPMH
>>>  	bool "Qualcomm RPMh support"
>>>  	depends on QCOM_COMMAND_DB
>>> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
>>> index d0a6047b8a6..b4682d811f7 100644
>>> --- a/drivers/soc/qcom/cmd-db.c
>>> +++ b/drivers/soc/qcom/cmd-db.c
>>> @@ -252,8 +252,18 @@ static int cmd_db_bind(struct udevice *dev)
>>>  
>>>  	cmd_db_header = base;
>>>  	if (!cmd_db_magic_matches(cmd_db_header)) {
>>> +#ifdef CONFIG_QCOM_COMMAND_DB_OPTIONAL
> 
> Switch to IS_ENABLED(QCOM_COMMAND_DB_OPTIONAL) check instead.
> 
>>> +		log_warning("%s: CMD DB magic not found (0x%02x%02x%02x%02x)\n",
>>> +			    __func__, cmd_db_header->magic[0], cmd_db_header->magic[1],
>>> +			    cmd_db_header->magic[2], cmd_db_header->magic[3]);
>>> +		log_warning("%s: CMD DB data unavailable, resource queries will fail\n",
>>> +			    __func__);
> 
> Convert these warning rather to log_debug() since this will be under
> special config check anyways.
> 
> -Sumit
> 
>>> +		cmd_db_header = NULL;
>>> +		return 0;
>>> +#else
>>>  		log_err("%s: Invalid Command DB Magic\n", __func__);
>>>  		return -EINVAL;
>>> +#endif
>>>  	}
>>>  
>>>  	return 0;
>>>
>>> ---
>>> base-commit: f0000b4a57e9edf8ff8454b9056d767466dff57f
>>> change-id: 20260409-cmddb-394afa003818
>>>
>>> Best regards,
>>> -- 
>>> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>>
>>>
>>>
>>
>>

-- 
// Casey (she/her)

