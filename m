Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF093C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 16:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E46B82D34;
	Fri, 13 Jun 2025 18:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mws0F84z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E0DB82D39; Fri, 13 Jun 2025 18:53:35 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177BF82CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 18:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4530921461aso20991885e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749833612; x=1750438412; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aUVH2KLgfvQyG43jE8akSdBZsv9qYxAkFLDwaCFjdSA=;
 b=Mws0F84z3TGWcTx2uoLyGP3m60T0FZScBcPVipjRdH02okB994b1laPGiS6uWBSAQN
 okGj5/fDOn0RMddI8dYFJkvWw86KT3QjJ2qQiJ03+zzKV/uIBmvaMbsNPnU/HgkOo7UG
 P4mr4tRCQpc7vHMKv3+JNfXQvo3C4b9MRHC3o9GFgMzZcPvPTN3znC2wCeZHa3Di+fPa
 Uu2dOP+avUgdTzBVtX/GzdXpFKbz5ZA0eC4yL2VcTlxmWF+fpFj8j1d5314BX+iji3PG
 Xgkwz1fZbivnnItTGaAiiyuP0nHX7GIyWCHzsic+66wnM0c0JpZh1BEiAwKMzIa0Fm1O
 knrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749833612; x=1750438412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUVH2KLgfvQyG43jE8akSdBZsv9qYxAkFLDwaCFjdSA=;
 b=N/KaWViXtI6aKgfpW6mY0RxLsO/SjaxHlSFbBi3Me8IC/Wp4SaMgD/IzZc6Rv4a3lW
 aF0ZZewWm7wJurmpsv2Fg2LOUm+2SwRbo/RZPH3YF9JnKoHWU00JaiqoHdIBt/PsNLXf
 +1da4g8cj+j/OzCP3AtjgFOMxHeK2ICgdLelvxqmiZi75cTwrNludUPGfp6yTK0pfRoL
 9hjeZ6vpTkaYPF4pWAkHZMQ8duR5tCTBt8rWpCf+zVkgX+fBKxsa2pcQ27PSymToc5ei
 oRbIfcObwldM8CqqY8Ohokt4QrntiNUnVu93uKxFbo4YsBfBFjDfi3eR6QjOLLDtEET2
 7uSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkiIzI+bwF5Jif9AMqF130j5DPZPUbRjAPJd3kVtJ0GI5mgRgDpD7iNbTTyWNvzgVyWf75wv4=@lists.denx.de
X-Gm-Message-State: AOJu0YxLhm0IUIkG9pfZfqBW0tN1Y5JbVvxIiQsKuNw9SuItlE2l8ZBI
 9D1dJWNfz4fJjjZpuKe6MxwrCuf0mlTJTSZ+iyB/s13+OgP/i7KsAr5aX5loHK5sjgE=
X-Gm-Gg: ASbGncvKly8uRPPtS6xah+h25jxZINbZU12ME/iL9JIfq50/5Bt0VuqGPEDYAnpF2uU
 UMMO9+A381D/AHJ6eH4pbdebM7kYAd/PERcqZubLryjnS1M83RMyUS4E3NIvK1S8Xbx0P9451Kr
 XJB7n1o1rhnZE9Vy8UDvWTHR714vycBYLOVlTv1usytt8J2OVx+XM5zhlVlL8s7a+l7f5rbPhB/
 DfVlk8uIeN6YC5ZejzwyhVTAajq3x9XCQa0cWWM7Ljw5kU7GYH+dFIYAFefX9w3Wb/WRc0y7TC2
 uJ2x0tReVMmgHeWzSElDau9cBbtOnC6U+CBbSGJaMlgSf2/HsVB4QpnyEZfGrEn/S3+W10zmyCT
 gWXcwZo1kJbr45T+5ERD4Cx6sy/13nYpGL6GU
X-Google-Smtp-Source: AGHT+IGtc2ppuRAfm5fICFn07cX9y3NzDNuaBtpDFK7PlIK537L2+xO5LQOdOk6r0KTghdU9n4N1mQ==
X-Received: by 2002:a05:6000:4006:b0:3a0:7d27:f076 with SMTP id
 ffacd0b85a97d-3a572367967mr598709f8f.2.1749833612328; 
 Fri, 13 Jun 2025 09:53:32 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:19e6:b5d7:f8b4:a927?
 ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54e71sm2839849f8f.1.2025.06.13.09.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 09:53:31 -0700 (PDT)
Message-ID: <d6688abb-e187-43e1-be34-d92c3c44f499@linaro.org>
Date: Fri, 13 Jun 2025 18:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Qualcomm: teach the build system to emit signed
 ELF images
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
 <20250612171847.GQ1382132@bill-the-cat>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250612171847.GQ1382132@bill-the-cat>
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



On 6/12/25 19:18, Tom Rini wrote:
> On Thu, Jun 12, 2025 at 04:16:36PM +0200, Casey Connolly wrote:
> 
>> With several new Qualcomm platforms appearing on the mailing list, all
>> of which build U-Boot as an ELF, sign it, and then flash it to some
>> partition on the board, we're getting a lot of defconfigs which just
>> contain a debug UART and a TEXT_BASE address. This leads to needless
>> rebuilds in CI of effectively the same image, and needless duplication
>> of build instructions.
>>
>> To address this, let's introduce a new tool "mkmbn.py", this is based
>> on the existing qtestsign[1] tool but is (currently) hardcoded to
>> only handle the Dragonwing and IPQ boards which use MBN header v6.
>> Additionally, the tool contains a lookup table that maps from a boards
>> DT compatible property to the load address it needs. Since it's highly
>> unusual for different boards using the same SoC to have different load
>> addresses, generic platform matching is also done (e.g. "qcom,qcm6490").
>>
>> With this tool in place, we teach binman to use it and introduce
>> a qcom-binman.dts file to describe the image. The tool will emit a
>> u-boot.mbn file for supported platforms, for unsupported platforms the
>> u-boot MBN etype in binman will print a notice explaining that no mbn
>> file is built and to look at tools/qcom/mkmbn/mkmbn.py
>>
>> Finally, the defconfigs are cleaned up by moving the debug UART
>> definitions to config fragments (since it doesn't make sense to have
>> them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
>> the qcs9100_defconfig is removed entirely since the same binary can
>> be created with just make arguments. This platform entirely lacked
>> documentation to begin with, which should be addressed by future
>> patches.
>>
>> The Qualcomm documentation is also cleaned up, a new "signing" page
>> is added to briefly cover the what and why of MBN signing, and board
>> specific pages are updated to explain the new build process.
>>
>> These patches have been tested on the RB3 Gen 2, but additional
>> testing for other platforms would be super useful.
>>
>> [1]: https://github.com/msm8916-mainline/qtestsign
> 
> Thanks for switching this all over to binman. My big question is, is
> there binman documentation that you wished was clearer, or that should
> be written to make this easier for the next SoC / architecture that
> needs to come along and add to binman?

I think the goal of binman overall is good, having a single framework 
for building complicated firmware images is awesome and I appreciate the 
goal of cleaning up the makefiles.

That said, I think for our case at least, if the U-Boot build system had 
a nice way for us to write some rules in 
arch/arm/mach-snapdragon/Makefile to do everything (in a self-contained 
way) it would be a much clearer and simpler solution, not requiring 
folks to go and learn how this huge and quite complicated python tool 
works in order to debug or add features to mkmbn.py.

I also think using devicetree for configuration is a really strange 
choice. YAML would have been much better, faster, cleaner, and more 
readable. It's also entirely possible (trivial?) to convert DT to YAML 
and vice versa, so whatever needs there are to pass this config into 
U-Boot at runtime could be met this way instead (though I firmly believe 
that having the entire binman config be available at runtime is a huge 
layering violation, and we should have a better approach to make 
available whatever /specific/ properties need to be passed in, but 
that's just my opinion having not looked at this in detail).

Practically speaking, I'm not sure what I'd suggest here, it's easy to 
advocate for doing something entirely new and I think I'd need to have a 
deeper understanding of binman to make any concrete suggestions.

Kind regards,

-- 
Casey (she/they)

