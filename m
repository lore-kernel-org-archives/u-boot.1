Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A5EC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 10:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BB4800C1;
	Thu, 12 Jun 2025 12:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DqKkc824";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC53382B70; Thu, 12 Jun 2025 12:36:54 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FD18004F
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 12:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so4425825e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749724612; x=1750329412; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aGakPzNgzNdUsGMKaLWarlLHOque1Td8zerB3ESg8CY=;
 b=DqKkc824eUxwdRohn5c1Qq8HuUuoo3Um+giqaMCTvWvVzD63fOh9ez2/CE40+vjl6x
 mcFcTUSXopfqtQyiau9iwYViNtZFduooekpBT9UYQvr4n5P2nm5TvDrTJ6c2AbyrBEOx
 z+/h+MdzjDO8k5NQJr+w9plHdNAeJ0Ri9t0x5JxVxyi4pXus878gDvvStN2Ypw7g5J57
 r/3fkPhYZA2udvEKqhoXLk+IymmuXg/eqiLHNRKx2VQnsnU1ixxif9e9wjC+roeQfGuc
 y5q//sc8l92UJ7dStcynuuoEAq1p6eOLH1KVcZzn3lS8EUNfKjuFssywe3JPxlvbtPLv
 Y0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749724612; x=1750329412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aGakPzNgzNdUsGMKaLWarlLHOque1Td8zerB3ESg8CY=;
 b=gLehTyAwWEZnIdGsUt/txpmzGt+ocwd/PKd++IWv+kMkMm4paL+GFrbH9p7o8qE27r
 v+K6N+XVVW9v3XchwGULjOYwd7wa/FvVV71zJxShCOP5OMEt3FNGFb0tqRCwq9mI0/yf
 RXVfM77rpwVlv4YpAS9+7SelZ6DFojE/ZAzvolVc/RzQJIyyynnA0L537UWkrmH4lNWG
 fmWCNnAznbBSUxRk2OCMYYTf4ZjMKtO3hWLBotBWcnRceC6ck7Fp8B3amsXGTzSSC/kF
 7CvkOXPw9xIwGl6CSmiF8ZYCybYRICfaOaFrqj+B7nhCc7FUqUaxh8snuvFIcHbNqBjt
 8t/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt5j+pEd3bqsunhwpianY95MX2+8/VYfxc9zDd+YiSisOra+tUId9R3fhRlQXKn5HgqKrJ7dg=@lists.denx.de
X-Gm-Message-State: AOJu0YwMU3wiM6jojj+QALWqEVsXsmrYz8gLVH1+Vq9LEssXCU7ECx3+
 nK5cNHPRk1oXv4JQIdQ2e/kJA8Q+ZVuD/8sA/tJWR1NEpCJ4HBSG1oChK6QeD8TetoUg3xhrTqa
 7nLB5
X-Gm-Gg: ASbGncsLn9xlbr8g4mFDjJs1rabgSTjrzr+pfOJ66lzlYZkO/GL7NGVeHr1kUP9NayU
 sboVOOY+fRJtLzZlSnm6MP2gdpPfRLu2sjyUvFAl525hAy4LMCpengxNjL0bW/6TZJHmWCbTS95
 JDfxcG9b7XwwEWLACAUMbQplquI8DeamHp/9FSnoDPHdx+jhxVEX9G14mG3Srbwy7n3G2Y059fU
 qWaXjGgbx3qsad4Z0ytFhXeNgABrzEK2ELmEg9vYTsfIDlGqshc7Z8OvDuvvA8XPVWN844SBgxI
 ZLWB9VK+0f7TlrM2GXBsRBJWmNw/5Ik2Kg6PfjAAUbDiY5lTuIJa06eLFyDSjNHCaA5qtZs16iy
 Zn1mgx3aTTLzFaPFMqOfvHL7A974al8CalvOr7A==
X-Google-Smtp-Source: AGHT+IHmtOvGO6vVeQmDhIcFKbYdEXx+nsmGDI61o9qbq2QCwkiNkLeHB3JpVMwpkXwrWwtTsm2MCw==
X-Received: by 2002:a5d:688c:0:b0:3a3:63d3:369a with SMTP id
 ffacd0b85a97d-3a55869cdf9mr4525440f8f.25.1749724612263; 
 Thu, 12 Jun 2025 03:36:52 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1405:203b:89a3:c77a?
 ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e2354fbsm16156475e9.15.2025.06.12.03.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 03:36:51 -0700 (PDT)
Message-ID: <1f37719f-0c5a-48af-bf9a-5508a6bea5e2@linaro.org>
Date: Thu, 12 Jun 2025 12:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dts/upstream: write fdtfile path to /chosen/fdtfile
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
 <20250610-b4-fdtfile-from-dt-v1-1-aec4df0fa53e@linaro.org>
 <8734c679xn.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <8734c679xn.fsf@bloch.sibelius.xs4all.nl>
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



On 6/11/25 14:13, Mark Kettenis wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>> Date: Tue, 10 Jun 2025 18:23:33 +0200
> 
> Hi Casey,
> 
>> Since we're using the upstream file structure, we know at build time
>> the path to each DTB that we build. These same paths are used relative
>> to some (maybe version specific) dtb directory on the boot partition
>> or ESP.
>>
>> By recording this path at build time and embedding it into the
>> devicetree, we can set the fdtfile environment variable with 100%
>> certainty that it is correct.
>>
>> Devicetree file names are already treated as stable kernel API upstream,
>> since they are used by OS loaders extensively.
> 
> But when something similar was suggested some time ago, the Linux
> kernel folks explicitly stated that the file names are ~*not*
> considered to be ABI.

They don't /want/ it to be ABI, but that ship has long since sailed as 
the filename is how the dtb is loaded. If this wasn't meant to be the 
case then "make dtbs_install" should mangle filenames somehow.

> 
> So I think this proposal should be discussed in a broader context,
> probably on the devicetree-spec@vger.kernel.org mailing list.

One could argue that since this property is added by the U-Boot build 
system during compilation, and only expected to be consumed by U-Boot 
itself, is could fall outside the purview here. But yeah... probably

.

> 
>> Embedding the path into the devicetree itself just simplifies the
>> process and allows U-Boot or the OS loader to select a devicetree of a
>> different version for the specific board that U-Boot is running on.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   scripts/Makefile.lib | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index e89a4a51b74ddccfd9f0a6463cdeded12eaa5235..1f95bda0597c14d2ee785eb8058d607a6c819a56 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -360,16 +360,31 @@ $(obj)/%.dtbo.S: $(obj)/%.dtbo
>>   ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
>>   DTC_FLAGS += -@
>>   endif
>>   
>> +ifeq ($(CONFIG_ARM64),y)
>> +dt_dir := dts/upstream/src/arm64
>> +else
>> +dt_dir := dts/upstream/src/$(ARCH)
>> +endif
>> +
>> +ifeq ($(CONFIG_OF_UPSTREAM),y)
>> +# Embed the upstream path to the DTB into it as /chosen/fdtfile. This property is used
>> +# at runtime to set the fdtfile variable
>> +dt_extra_snippet = / { chosen { fdtfile = "$(subst $(dt_dir)/,,$@)"; }; };
>> +else
>> +dt_extra_snippet =
>> +endif
>> +
>>   quiet_cmd_dtc = DTC     $@
>>   # Modified for U-Boot
>>   # Bring in any U-Boot-specific include at the end of the file
>>   # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_TREE_INCLUDES
>>   cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>>   	(cat $< > $(pre-tmp)); \
>>   	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
>>   	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
>> +	[[ -z "$(dt_extra_snippet)" ]] || echo '$(dt_extra_snippet)' >> $(pre-tmp); \
>>   	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>>   	$(DTC) -O dtb -o $@ -b 0 \
>>   		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
>>   		-d $(depfile).dtc.tmp $(dtc-tmp) || \
>>
>> -- 
>> 2.49.0
>>
>>

-- 
Casey (she/they)

