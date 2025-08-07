Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCA3C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8121845CA;
	Thu,  7 Aug 2025 17:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YMupxS62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB4B845CC; Thu,  7 Aug 2025 17:04:15 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D6F845C9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b78127c5d1so656951f8f.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579053; x=1755183853; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+GaJXHc+qWRUCTvOcUP611Ro+7ECVodMGpLYcI0ocnY=;
 b=YMupxS62PyTSw1qvrST07tMUuSImTudo1gmPMTev0vtTvSd40A11osL0z8H56lIE+s
 tK3HLndmER3wDP2t4/GWFuiCf4nSunfYNevmtseN5mFG1W35px9e7rZtOe/zn1XwX9PY
 Ugjl1NovcP1WfVJWCwohNCLb1nLPCALdjEOOMWgkBE5cKY0xIHWM0mL0feCyN4K7Wy0w
 Fs7Og8PQPjQRHFQiQCnpMcv1R2p3whVplld8Hk0HZ3wf/UmYZ4QnxPbj/AmbdTdKPOqm
 5FvTqxeycoWCN4pC1cPhtYu62sQGlyJ7ux6Bkno6rLqBYdnyKB6nxUKXEB9xZ+TKuR61
 Zmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579053; x=1755183853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+GaJXHc+qWRUCTvOcUP611Ro+7ECVodMGpLYcI0ocnY=;
 b=d11G0LSmJQvc2JSfmKr4cRBfdhqOc5tdHwxwkgpqg4dXgZ6f/esqn3XbqxkIlum/hf
 5VwD7B43VrfMPGI3QHI1VO0YRe5GmU7OJrsz61+1bl8uRMvbmXDDbbtvDfgTAUAz+YEQ
 +SH7YUxB7FVXaNClTo3aGuXYql4h3e9P8enNiA46xf6mxGHeRQJcrh9J7UFiwspYd+Fr
 5hJhFvl/Oj9SZ+WhGiF0vH+xPoc0Q2y5AD47F5mLqQv2eWYt/eXZNH4xWjZWRwqvMwzD
 st9LtdAiFn+gb0fdVCV27z51x0V4IdveXx14jMsW9crSOsQ+2rfij6FragnB/sp1vbrL
 pBYw==
X-Gm-Message-State: AOJu0YzQsj1Guku/z0akrWvJg0zd1pEjF72Hk/0tNNEKtRiIe7E5sh8W
 EbPULHVFs9zr2IoGeDJId/ewVE64VO5/gjvPEzDwThtEOIOI3+D/EoNaGfsjPwFzcCA=
X-Gm-Gg: ASbGncvGR0gCqJrar3pI0pkXpiB0mH1aofP5GRxmVyy37Av5WauWQnQ0w2YWf9vhrJw
 w4vNfeJBpR/7k2up7sqlh7BPk9mxFeoDxZ/sJ8ICNyhuDgtcDxB45RxIVcby8pfujPFDkL29DKA
 ytp634widHyfI7oKqpsfFXJ4GMXPYB50SL2AwSCowyFnqq8TkTy4tF4PmXsPIhtYrOIrjF1dDQY
 MM2Tw4sqcL8QFsGSqeOaSIGbfVcyYnhUUfnGCutlzCZE9LytNuaLzblEDUlTIZYhC1cm8cgrDf/
 ENHY4916YCU/fkwzYiAuAbCcKA+M8AK9tPt78rn+pu7chB07jXW1pjLS1hwfGqqwU64BZxoBLh0
 ufhFKLWQ3N1XhHZhLJ2YM8kjx3riGHUoiXcK/20s+LwWnFfVGXCn9BNHnVM4G2+sMiMjZYTqWu3
 FHCQ==
X-Google-Smtp-Source: AGHT+IHlZP/bIhs8BVV0POApoq9NRZHA6GO8Pok9/QaGmXxz/n2Bq+6JLJe19irybtmOzSi+y1rafg==
X-Received: by 2002:a05:6000:22c5:b0:3b7:8cac:821b with SMTP id
 ffacd0b85a97d-3b8f41b3991mr5415288f8f.20.1754579052467; 
 Thu, 07 Aug 2025 08:04:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469582sm26573397f8f.52.2025.08.07.08.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:04:12 -0700 (PDT)
Message-ID: <c8cabd7f-ba9e-44bc-908b-057e70bf4e88@linaro.org>
Date: Thu, 7 Aug 2025 16:04:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: pfuze100: Ensure loop index is incremented
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
 <8d85b79f-ef92-450e-939d-9d8cb40da516@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <8d85b79f-ef92-450e-939d-9d8cb40da516@cherry.de>
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

On 14/07/2025 13:25, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 7/3/25 1:31 PM, Andrew Goodbody wrote:
>> The for loop in se_desc uses i as the loop index and also to cause the
>> loop to end if the passed in name is not found. However i is not
>> incremented which could cause the loop to continue indefinitely and
>> access out of bounds memory.
>> Add an increment of i to ensure that the loop terminates correctly in
>> the case where name is not found.
>>
>> This issue found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Is there anything else needed before this can be merged please?

Thanks,
Andrew
