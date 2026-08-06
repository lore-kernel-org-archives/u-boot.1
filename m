Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AFBC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FC2C4065D;
	Thu,  6 Aug 2026 13:17:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDB-LTHjdN5C; Thu,  6 Aug 2026 13:17:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32AD040606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786022268;
	bh=8gWsHo5qgCUtaavByYYB6tOCnHSX/TOTE0e3xrYZ4E0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GzTFQlLCFQgJf3eK47+JBUJ6ty+KbeBsvk8qb1oMpUCIwhn5GbFROfgaZQipCaAmA
	 zEgaMmuibuY2otmJykiu7Rj9I+/cGkH6VG4PPnjmQQFLdx3j5ixBSvfem1sFOYFSkL
	 NPGkGGYYU11BrfZF0oCY+MSBO0GscVApTHjIHn+8X0fOjXhajldsscGOOwbOaJV1tv
	 PpoJ97JvzK7N2He9M3qSTy5JkYFpYV+dy9kf7f/qyJWvr4omIOOCfG0DxMFlnE8irf
	 StA4wqQSJYCcSlnINY9dabMRXB91QaslHW3p+obPVeIvk8FVrjz5gKZbi5rt+1ysLa
	 2txWc30Y0NDzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32AD040606;
	Thu,  6 Aug 2026 13:17:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DA14218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23568607AB
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uq9UPd-mAau0 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:17:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B91F9605EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B91F9605EB
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B91F9605EB
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:17:43 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1859488f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022261; x=1786627061;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8gWsHo5qgCUtaavByYYB6tOCnHSX/TOTE0e3xrYZ4E0=;
 b=jPKFSpWghPs+mzl6ZBMIlTX/N12r2DK4sG4aW3joCvB1xvCehZr+BI7r1v4/aw2/eh
 02Otcfo1Gn97PxNBiPvtb/ftD0p25QR9fwbOXEarYLL46NnQDbpHX0eh9xta/vrnYzzF
 9+aImRKm10pviYikDcWjctgXWBa/ufelQlsD4ByHxSjpEjvZBMU2Njf4Hklt0Sah4+X/
 O8ylN39q4kCg3LVFlOve6YklS+LMR3q+7gT2Ypu/jIzPvS1olWGEUymssoEZIuuhGf5I
 t0Owjo6F+Zjbz7aX54L7boC/O55M+slDkO2RtI0w4Hu4fxhPebofm4uQWDluRpAe1YWJ
 n5yQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8ERV+U/2DBaypZ/Mjr1dhUsylyHB/4DOePourLC0uRyOUqBortLcU2+mVzccJdpi4MGVCcGI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YymdxKh0ubw88kQpdWRQdxa5PbiPyWy+CKoxuXbMCLDXNu2dsCY
 9uUCFvERdNMCXJlCwz+sYYzkXYtur1wAt/xjTmkRnVBovUgdxs2rEwk3qJJkEnTuUS4=
X-Gm-Gg: AR+sD11uqVOZfgUswHO/sRGaoPdMqdLimCLsramjmCHHD5nxMd1zkzY8smZ/nM4uo7u
 pwpVzjr0tZsPZN+j8w5IS5/BMTlOpnhBmG1jywcPtrhNpFRUr/lqhOs5GOKjtUQQoEz2WvpQSXr
 H4cxIr2tzf43/4xg5hkeJfS1c2ZZpVfQLZEoN+XnyvimaHPRDQdagspawhSFrOGTmvQMoS9qEW1
 2QhIsrhCdsQJ+awOXG/wL3R7dab7XHkGLi/4rgh+TH5Tv79OLidGlcNT83gal2foI3tDY1jjv68
 K54AG8jJNi9TF0z0oBAzGTHJHnh9L1LcxNIbiQTXLiUn/eaqeFLpr6rgzhnk1rVWHUqObslV7rK
 jJeJ26XB2Yi9zx/ypkWd4U+1H0TF9TZ5N5NPLdAXTQE6cbZKOVyTcmHKR10dSzLJfv3csHLOahA
 kjaKVn41xCgA6gJGcKBDi7aXMNr8EQFFrh9jLSCNYtcfVnGmpfvFTtgKJgA6IrkUDRrGGOwh3pf
 y+K5vS4HpWM/u+aZ7wuN/eeu/4GkQ==
X-Received: by 2002:adf:f345:0:b0:47f:8487:a686 with SMTP id
 ffacd0b85a97d-47fec6337cdmr18472931f8f.23.1786022261381; 
 Thu, 06 Aug 2026 06:17:41 -0700 (PDT)
Received: from [192.168.1.37] (p5b29ea13.dip0.t-ipconnect.de. [91.41.234.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b18086sm6645106f8f.22.2026.08.06.06.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 06:17:40 -0700 (PDT)
Message-ID: <35e30e68-7946-4a02-aee0-2a4ea3df4a58@linaro.org>
Date: Thu, 6 Aug 2026 15:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] CI: install python-cryptography for world build
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260720131325.37436-1-casey.connolly@linaro.org>
 <20260720143156.GZ749385@bill-the-cat>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260720143156.GZ749385@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786022261; x=1786627061;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8gWsHo5qgCUtaavByYYB6tOCnHSX/TOTE0e3xrYZ4E0=;
 b=NruV/74SpPgoACXlQXCy9CgIyNRYv2ZvHlr/UZoqCWINRp2PuFOnGbpXvY4idJT5x1
 wq8tsvSw8liMrmiQAHdvH54y9gVxBNi4cbARlXnAqYB47xn+2NvL/Ld6ux/POwIPdf8c
 oxJCshSmdx73ykzAQ3jGfuSTUQMJnoa/OX8805XgCNi3GRTUu3xEvqUs0CQi6wZY0I6L
 UWip/Qe2zhn3kU8JBieqRG64PTTGVZTTPIggPbKidVxtIW+FFSg4ItgeoMCZvYQIX89l
 LNeFhIo64oaMG+Y68UT6SohRhlzoWKB3FQPI0BBTRW9nuP1LiE/0fGY+1ScRgscGjAN3
 5DZA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NruV/74S
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 20/07/2026 16:31, Tom Rini wrote:
> On Mon, Jul 20, 2026 at 02:13:22PM +0100, Casey Connolly wrote:
> 
>> The mkmbn Python tool used for some Qualcomm platforms needs the
>> cryptography module, make sure it's installed so the world build can
>> succeed.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  .azure-pipelines.yml | 2 +-
>>  .gitlab-ci.yml       | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
>> index 4417ef4e5a50..562c5747c9d3 100644
>> --- a/.azure-pipelines.yml
>> +++ b/.azure-pipelines.yml
>> @@ -733,9 +733,9 @@ stages:
>>            python3 -m venv /tmp/venv
>>            . /tmp/venv/bin/activate
>>            pip install -r tools/binman/requirements.txt \
>>              -r tools/buildman/requirements.txt \
>> -            setuptools
>> +            setuptools cryptography
>>            if [[ "${BUILDMAN}" != "" ]]; then
>>                ret=0;
>>                tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRIDE} || ret=$?;
>>                if [[ $ret -ne 0 ]]; then
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 245e422d72fa..eb13fde82b86 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -153,9 +153,9 @@ build all platforms in a single job:
>>      - python3 -m venv /tmp/venv;
>>        . /tmp/venv/bin/activate;
>>        pip install -r tools/binman/requirements.txt
>>          -r tools/buildman/requirements.txt
>> -        setuptools
>> +        setuptools cryptography
>>      - ret=0;
>>        git config --global --add safe.directory "${CI_PROJECT_DIR}";
>>        ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
>>        if [[ $ret -ne 0 ]]; then
> 
> Ugh. This shows (a) the CI pipelines had another place that should have
> been installing scripts/dtc/pylibfdt/requirements.txt and (b) I don't
> know if we should make either boards/qualcomm/requirements.txt or try
> again with a top-level requirements.txt file. I believe before Heinrich
> disliked that I was including other requirements.txt files in it. I
> thought I had said something in reply, but it was a while ago.

I guess I'll add a qcom requirements.txt for now so we can get this
merged, we can also change things around later.
> 

-- 
// Casey (she/her)

