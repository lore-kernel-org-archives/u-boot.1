Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F538FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBF183FDB;
	Mon, 27 Apr 2026 12:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nvEmK1SI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE1583AA9; Mon, 27 Apr 2026 12:30:28 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC1B683693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso5911613f8f.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777285824; x=1777890624; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lgh+7/9XrgGsnECR2hNwMVLNQJUZwNkOXNqrDnZqczo=;
 b=nvEmK1SIHh+MwqTu5xKjcl73Om6HuwjeR4oSnk3+HK+O50TgarTlMH4x1zj+131BeT
 r/mFI8L+JFKDmW/bh6iQKYvmT+lhjNhaF7gwvk1k6JM3dkAJgvBogE/d3TRAuz8ebhgj
 FkDpohFoD8n1hmfo3Rmu6Rug458CPmT06KEmxERPSbKCPXjLIsHUGSftcQ2svzO4Q8Xc
 0Y5NQLgbuDbv84qJrVtMY/Y+7qvX73uxdFuJ04XaGsnxmENXvk8LjPSqeNgH01/0wYIt
 VUI15WKJNZMtBQaIGDY/qEKxlpucYEzrFmnW6JGQIsi9LQ0b2e+WxSeyyvF96V8R37YB
 oijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777285824; x=1777890624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lgh+7/9XrgGsnECR2hNwMVLNQJUZwNkOXNqrDnZqczo=;
 b=EnUdGJtZIZ+6hCrsVLEToY/DQPRGDInfgV/RiFZJ9++VTWFDqGP3DeSLX5nxbyVKNz
 83SRkGDuIqg2vXG3yT153XnMqowwYUBxAaygdnDjQRIi4Bb8VoWL5CoRuBCVigaxQjut
 K+Lr6QOuzsa6q97sv0+4pnjPs/xW6YbIdeYncMZ0bO+o6C21rUomxCK5/UhwpBZFaXl3
 LXnug/w90mi0Rp149lXbiiroS6nTDPYrkwEmGKI3ypDW6Z2wwKCM8i637q3WLdPIh2lo
 kCRy6LNLvMBiRO0UAARpfYhZXqOT/rcjyvPyGAllNEQe9m5HMgZw5CXEpfeRP7upF8X1
 wb5w==
X-Gm-Message-State: AOJu0YwfKVHuZbv1YSzyv37Ozh9/jhqPHxYPGsqY5XroGCHLwFGH3zXk
 BsHTaSsUxJjeynlIDgCbIRibSbbxBFPnvp9KR0qDnKaXjOYYxqgzdopggixiIsKdqWw=
X-Gm-Gg: AeBDies2d8xeRIjhs1D7OB7a6mJuw1Vt+fZzLeq7YalZavWhqglLQz3NLfiaeqlXAZu
 KXvMIPd+nO+Gl163hBxhk3xm/GfQHhXWJAuHK2WEvPX7ftDwTGQrjSX3xtilpvzT78fvQyy/mVs
 bPRVOba3eqfo/E432amVDSxeS8rTBtIWm4xVyDq+b7qubPmG6dJuPQRv/w37AMlRhkMXcAM2h8P
 99inEaYyEn0x2lE4tauJ34DDzOVZ7ftEhWvlU8CimGYw7qzhDESaX2cZr4zxDqf43lEvuzx6BKV
 U35qJxCNQdWwd8iA7xfzIeWtOKxhE4alNPw417hFkRNmg5mrN9OE5MSz/Ibu22UNUQd8iCXRYpZ
 +U1gyQlUgXQSboNwmCVlpO6pVla8+qgQxrMI4cNvwy6tdaOxBp5sES8J8GT6LrNkcjjmrq9hFU0
 F7p5WjmiDzs9yYovKojf5AAEh0QIDYxhVczIrxLhb8aRtwJe0yiK1Zs+7gbklVl9pnC8B8i+kVD
 cIH
X-Received: by 2002:a05:6000:2303:b0:43d:75a2:44a1 with SMTP id
 ffacd0b85a97d-43fe3e1527bmr65470098f8f.47.1777285824059; 
 Mon, 27 Apr 2026 03:30:24 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0f31sm80348216f8f.12.2026.04.27.03.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 03:30:23 -0700 (PDT)
Message-ID: <cd9e0278-2642-4a2f-9c56-f238bc0d1bac@linaro.org>
Date: Mon, 27 Apr 2026 12:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Please pull casey/qcom-main-13Apr2026
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, neil.armstrong@linaro.org,
 Ajit Singh <blfizzyy@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260419030602.2470577-1-casey.connolly@linaro.org>
 <20260419154026.GV41863@bill-the-cat> <ae8JX1O7PGJaFSX8@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <ae8JX1O7PGJaFSX8@sumit-xelite>
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



On 27/04/2026 08:59, Sumit Garg wrote:
> Hi Casey,
> 
> On Sun, Apr 19, 2026 at 09:40:26AM -0600, Tom Rini wrote:
>> On Sun, Apr 19, 2026 at 05:03:16AM +0200, Casey Connolly wrote:
>>
>>> Hi Tom,
>>>
>>> Various Qualcomm additions this cycle:
>>> * USB superspeed support for 1 platform
>>> * Initial support for the Milos platform and the Fairphone Gen 6 (chainloaded from ABL)
>>> * Improved support for booting with OP-TEE on supported platforms
>>> * Initial basic power domain support
>>>
>>> Notably there is a generic change to the device core, missing power
>>> domains will no longer cause a device to fail probe and instead will
>>> just print a warning. This shouldn't affect any existing platforms.
>>
>> Unfortunately I get a fail to build in CI:
>> https://source.denx.de/u-boot/u-boot/-/jobs/1428016
>> +(qcm6490) drivers/phy/qcom/phy-qcom-qmp-combo.c: In function 'qmp_combo_com_init':
>> +(qcm6490) drivers/phy/qcom/phy-qcom-qmp-combo.c:288:35: error: unused variable 'cfg' [-Werro
>> r=unused-variable]
>> +(qcm6490)   288 |         const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +(qcm6490)       |                                   ^~~
>> +(qcm6490) cc1: all warnings being treated as errors
>> +(qcm6490) make[4]: *** [scripts/Makefile.build:271: drivers/phy/qcom/phy-qcom-qmp-combo.o] E
>> rror 1
>> +(qcm6490) make[3]: *** [scripts/Makefile.build:492: drivers/phy/qcom] Error 2
>> +(qcm6490) make[2]: *** [scripts/Makefile.build:492: drivers/phy] Error 2
>> +(qcm6490) make[1]: *** [Makefile:2205: drivers] Error 2
> 
> Do you plan to re-send this PR with updated USB super speed patch-set
> from Balaji here [1] which should take care of this CI issue?

Tom: I'll fix the issue and send a rebased PR, I thought CI was passing
but I guess I missed that :/ apologies for not doing this last week I
was OOO.

v4 doesn't fix this warning, it also changes the fixup logic to use a
compatible match, im a bit confused by this change since we discussed
why that approach was preferable in the first place.

I'd like to understand how significant is the overhead of the old logic
to justify this.

I'm going to keep v3 since that's what I tested and we can discuss
dropping the logic if the overhead is too much.

> 
> Since the v2026.04-rc1 is going to be tagged today, we really don't want
> to miss this merge window again for all these pending features to be
> merged.

I appreciate that, you've been more than clear about your feelings on
this and I hope I've been clear enough about addressing it.

Kind regards,

> 
> [1] https://lore.kernel.org/all/20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com/
> 
> -Sumit

-- 
// Casey (she/her)

