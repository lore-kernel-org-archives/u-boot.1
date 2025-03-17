Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEE0C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48778198F;
	Mon, 17 Mar 2025 14:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OzyM1+Zp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212BE8197D; Mon, 17 Mar 2025 14:50:51 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A96780F70
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so3785912f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219447; x=1742824247; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ioEcKxPeOjICE2PfQbJvZs5MsmQMoDhnob1CnUCmzYE=;
 b=OzyM1+ZprrSY6R+JJNDGcuVyfI5+JMEXFqLUMmy3beUVSrvyLQDaFxytW8hWGdcBd1
 /pKIsLpfMs+ScGfpUhembYYrUE//jBppHWRplu/1Sguft1bwiLNMa3KFvNGkom+f7Rdj
 ydSjtqtvh+axY9EU+ZhObECDKtrjYWDAYa4idpbBiQyqSz5IzRhY0a1ngHH9qGk7gQkc
 t2aal4v6k0xCt0gguKffuYvTImH7UDa7VmpsVAT5ZtM6m1Mu5TzBh7LriqaT1pr4GVSw
 NEcqcqr9dd7uUjfsBxOq7OpUa+eNkjJXSA7aylz8r1pN1lumAoZ9uZfBjKe9lrjlqAh9
 Z+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219447; x=1742824247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ioEcKxPeOjICE2PfQbJvZs5MsmQMoDhnob1CnUCmzYE=;
 b=vv4o2cSiQmhkHqMHVh8BxbaVt8s8XdQVViRGRlhpCI+dMBNTMj1y7DY0Q1HkW3B8Av
 vyKqjY5yJHDmtJkb/15htkDQMO2alENQLuWxf5ySkSeAQDPIvmOBPP/nY8pzSq5LsHLX
 cfZ1e7Mu9yciRhoO+QVaisz/lapjfcWSHkBs1dICSX8yRBdmZtY8OGlpSWZjxKng1HNF
 jhcvOS6VzrosKf1RaHEHfvs5LyUmgT9s9R7A3/XZpa1Xut4AGG/CvFrfmU6EI7uJQwVi
 wSuIYHxmGM4a6tqcBAU/9Q5HqHEds+fVhXWl3RSfO+tdgHeqbl+35HCwIadvFisbUtO9
 mmew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfupsTJa6PJe34MSM8l/ftNZqrlvjlXLLY1LE2UHdwDYpdj5RnUKttTuqINIVL+P88tlhPves=@lists.denx.de
X-Gm-Message-State: AOJu0YzGFpjGcLYzh9jxo6Gnb+32vU8A3Ghy+xWFUCpVtp5t4GmzPfwW
 azc73AEVmk7e8NiPOKllhVdxciKdvolScViZec4HzG5I9OCBR9CEwciNqwBp440Z7pqAiOzZ30h
 iXCE=
X-Gm-Gg: ASbGncvrrPLS7YDsaeHDcdFDvbrBhXt+zXNJxTSOaO4nmTdfdJBzrHB5dfkqz5OfKgm
 fF7BdGQGf1qoFV41wRBJkqngEDoHSpm4B7gZvhXgqDCyDRww61wGCfcqK7/rc6J4tBB5GgVYkpv
 GmSce+d+HOSdPIyYxXfnNSpsb8YQHW4YwlgMsf5FlQ/aKoucBlzamr25Z2QfH89JuMqKZokfg+/
 AY0Wh3mIwg7QrWEN2yH3nTsJEEE1rdo8GlxgsIcTuGnifRgWVdv4tmeqtO7Am+VFii2rzW33dB/
 +fx7A46luqudy3WL6Tqwk73dNndl2Zcyrscl9kG8lLBkb0eZ0zfht/pOJSFKJVRWRxumWbnYQES
 Q9bsUBopcQGH7IVsDqXTtXL4xj8D1+rYg60X2
X-Google-Smtp-Source: AGHT+IF/zAT2tYttsS8YfMWG7vYUGU0JSgLfjo/DOqcZvPAUgICraZqG9ThXuz5cDdx1qLK9wH8Stg==
X-Received: by 2002:a5d:6d08:0:b0:391:4940:45c3 with SMTP id
 ffacd0b85a97d-39720e3c9bcmr14194516f8f.54.1742219446769; 
 Mon, 17 Mar 2025 06:50:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9?
 ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318af0sm15125453f8f.73.2025.03.17.06.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 06:50:46 -0700 (PDT)
Message-ID: <0ea959fb-eaf5-4d90-a4b8-1298ac4d09d7@linaro.org>
Date: Mon, 17 Mar 2025 13:50:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] MSM8916: Bring secondary cores online with spin-table
To: Tom Rini <trini@konsulko.com>
Cc: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
 <b72d521f-6df5-4ab1-a00d-65ab7dc14ac6@linaro.org>
 <20250317134558.GM2640854@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250317134558.GM2640854@bill-the-cat>
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



On 3/17/25 13:45, Tom Rini wrote:
> On Mon, Mar 17, 2025 at 01:13:22PM +0000, Caleb Connolly wrote:
>> Hi Sam,
>>
>> Can you re-send this without all the prerequisite-patch-id tags? b4 is
>> desperately trying to apply ~140 patches from some old next branch to my
>> tree and tbh im not sure how to make it stop.
> 
> You can use --merge-base HEAD to override that I think. If not I think
> it's worth asking tools@kernel.org because that sounds like a bug to me.

I think Sam had a bunch of big series pulled in for some reason, the bug 
is listing them all as prerequisite patches imo
> 

-- 
Caleb (they/them)

