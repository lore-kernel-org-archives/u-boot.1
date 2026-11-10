Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4F2606A211
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NdHE1RVs;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CmTr6cof
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B56D811DB;
	Tue, 10 Nov 2026 16:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZ1aP1cDOJfO; Tue, 10 Nov 2026 16:36:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA7C08118B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794328563;
	b=Ln52YkPHCgkUxjQnDiLdgE918DgJHP0zJE9CIlnP+Lpe2E/EDnO2XpidoaZAx+4HwuQX
	 q7xkZHrGke3fHJMB2mApVbE6vbA71WbTywbnn1LhN8WBzjyJQP1li9cvhrVolK93of0bE
	 R4R0nV/e5/sB23udafVaxmXZaDLYwtQ94ueuZ/U8z0lKIQM5OxPiXhykfHh4ZHseephe5
	 oR+yxEOgN9ncfI4J8A6y9DxRFAuImgq0gYEPXbIKNI2An/vwIhd3FMub6xTR/JWz9/FpB
	 bMAWskStjhEvhU2F+EH3Mj//O8p7foYnLcFsscIyTkihv7eQ+miLWs8XChe4MFK6Ndw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794328563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PSz8oMiTMKoPWf0MnMGOxtHfFoXSPfsGfRnZXlfwIpM=;
	b=JFayVuV4sk7Q9uwLTdMrZ8+R9SaeUhNTzxWD5Wa6idtWU+yAdmTD8Z8gqxU3vJo/gozh
	 ZcgxnQ8Bi/8SKPKVelRNdcYrDKMnP1K2xNxWrYbEjG7W85X+1jk9dkXwTXfa131fRh7it
	 VwJi7dCKBZ1y31W9XgDtKRGVQC5kAvj5MkEa+/hxGL5FA5ieXRsWs0Nq5Wi/HpzixVqCU
	 LFW2br6Xjc4trd3Nsf9xVxfu4fsAbyINxIzE2Fizb3elGMrbE6qq6zCdK5x/9bkekQV/2
	 e30gS7XufOMOF3o/t9aW02JA/WVncdpYxU3P6jH19SoucQgc4h4Vetlr43mhD2JcgfA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794328563;
	bh=PSz8oMiTMKoPWf0MnMGOxtHfFoXSPfsGfRnZXlfwIpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NdHE1RVsfwEnLGcZYyTlge2K4WhtG7qgDF4aC1rMjOpsNqCBlzhizcd02mPadupvq
	 677GfKxTxgsYoKILdyBLcG9NFZLc/r+u9swy1VcDqdq1pJ0XWr/ZFLg8lQ3UOvp3Xa
	 cj2wm2+35IMu4k6vubH88DqcL2OGuYvzgpFHCVXSmDgTDErn5ZLsJ1Ss8C9t7qo6ua
	 Bd0O2zjMGaJN3PJE4uQlfrqrHeg87pRa/LcV9QS6CFyyuzjxserlJq5ycMLkcheM1K
	 uLm8L459diO0DSSkUHjiQqC7Km3R9gBjOQQhK5c4uBchgxWGsB5WRfSSoFYLiDfD5S
	 0NByDNnRn/hSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA7C08118B;
	Tue, 10 Nov 2026 16:36:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D1039D1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02B514088F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1DIXpo310FrF for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 16:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9AB4440882
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::9;
 helo=mail-wm2-x09.google.com; envelope-from=andrew.goodbody@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=CmTr6cof
Received: from mail-wm2-x09.google.com (mail-wm2-x09.google.com
 [IPv6:2a00:1450:4864:31::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AB4440882
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:35:59 +0000 (UTC)
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-4ae596853deso6026575e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794328558; x=1794933358;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PSz8oMiTMKoPWf0MnMGOxtHfFoXSPfsGfRnZXlfwIpM=;
 b=CmTr6cofCHKjLYNoba7FFZoITQGLRrQ1sk4orOB/dHV/dyFTZ9bWbzX/ksSwk4GxJo
 BnWcKi8ooFtX5Y4rkvfwKTMYqVsQ4B6WERERlYavk31N3IYWeZa/HaJ0K3oFqO63VEOb
 cl6P44tNR+3smE7da6yLDds22ZmcBbZAIbhNllH9Yma76+qgHUwrJJ7FiFMvk4yEMXi3
 XrOTkxa5LT2qlztEwoFreGx7nCRy1pJWS2F+VxReGNYS/xrJNxphRGLoVNRkqwO6O2k1
 EKJyfk+OmcdMl2z2rHeYkLr0J+JKBHVo8TE9Y70eJEU7QDD/FfubmGSO+W2AZYpdnljL
 /C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794328558; x=1794933358;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PSz8oMiTMKoPWf0MnMGOxtHfFoXSPfsGfRnZXlfwIpM=;
 b=qs9hNmhdzI/TUeQFRhx0lRNAK4Fn7iiAZjnGokOctO0gHGTXzwPI02ppr/605E1GoT
 TmXjSdnYKHxv6Iz1NnxalOWgUZJlrf0X8JhszIRYTZ/ZprjKS7xKGXFEGaaxL9zDlH3C
 Pi+7goZbhco2iOd6gj9Kueamux9N3YbzC5Bl10yyLfMmvwmcHEFoUJWii24PmaVffri/
 p74AOZGXAdXV3s7EWLVHa9IpYmu/gYBDbBHoMap/74hjk8QnQa8D+GN/HLTvnhjGLN8a
 3rgm54MrG/Oe22w5hZxst7lPmXvbAANey1nUy7kTEnsPClaoS65EASKZMPamPjiQnj0u
 3weA==
X-Forwarded-Encrypted: i=1;
 AL+hErHntyr4UwpuGsreeq9oYmZR2dFeWwG7Wh8K35VqB3G6Z2Fh6W4FpaZcaDztUqjoJF6zg5dkE7k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ijQ+flQTVAOpU+J2ACtiHcECwIWx6X3gpb+E1llfZxJ23Zhqo
 UqnxRfIjfsCCzEeDZccRYi81fCargAEGShtOMgZ5B7cdJiuACeAtZ0dHAZBjO+yEu34=
X-Gm-Gg: AYBFou0Uk7zZkzhh0cSGQ2uxNPEph1RBryMjmBdcFmYz5xyLuJSN/RVYK2xnaLB7Grn
 nxjpXG/B99gSoLTnCf6IWFU5AhfyqMFf1+P1kZDCeBLzByH1FQN47qlOPAPR0236YkkwwVr2DKh
 Avz7deidvkmUdi1JUyiO/GPG7OXmVS2cxtHFc+/7Ywddojm9zbAcAXzOpJxk7bUA1pE7DZKLpPg
 XFHQn4e9NWpcbcXkf2ooD6n8wC1Csd+0T5tx1J/saEg8lTclRXlinBfusQd22kM6y3zCwnS7+W6
 tXQXKgBqJgKnLykCHXccceVuX2n4QLi4fNfpT/6knC7Bw7polIITORc4s90+iOTI21c6zy/KTxU
 ZpebR3iMrpppuge1cCiQIHKV5wGNddSje4mIpsxrTxquNbMjWh21/kcL2KddF4OLTLAd+xI51hL
 YFeKAcoNtJitswpt1+YyEaDwXpzcyRAasCU7LOA4dpBOxPqC+F2u8nA9V422Hip1LkhdaaXJ0zt
 e9qLVY1zQ/NbLfdmJaPdmm9Cbv8NiVRj0y7XFgMMZ5meHr+pz+c6sVOdHY9SDXXKt4j/EcpgtpK
 z97Lf6Ux8z+5BOrcOKhFlHwjqEinrwMCkEP6aUCwe06tACy6DkmPKVELIFqGFYaPGctDfD81d3T
 YmDjq
X-Received: by 2002:a05:600c:190f:b0:4a6:30c3:1114 with SMTP id
 5b1f17b1804b1-4ba0233c53fmr53571935e9.12.1794328557891; 
 Tue, 10 Nov 2026 08:35:57 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:e384:fd63:c1b:f384?
 ([2a0a:ef40:e16:1f01:e384:fd63:c1b:f384])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233f95dsm49160565e9.1.2026.11.10.08.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 08:35:57 -0800 (PST)
Message-ID: <c9813d55-f3a3-4477-b276-e6a6c9f9f192@linaro.org>
Date: Tue, 10 Nov 2026 16:35:56 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] test: Build mkeficapsule in tree used by tests
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-8-1c76e0b68f29@linaro.org>
 <f2624c53-50ec-442b-a783-b0c669108a68@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <f2624c53-50ec-442b-a783-b0c669108a68@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 14:49, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>> Since the commit to only build mkeficapsule when needed rather than by
>> default, the build tree build-sandbox_spl no longer contains the built
>> version of mkeficapsule and this can lead a test failure. Add the
>> config line to the defconfig so that mkeficapsule is built and the tests
>> will now work. 'make savedefconfig' was used to generate the new
>> defconfig file.
>>
> 
> This sounds like this is the incorrect way to fix the issue. The proper 
> fix is probably to gate the test on the presence of 
> CONFIG_TOOLS_MKEFICAPSULE in the config.
> 
> @pytest.mark.buildconfigspec('tools_mkeficapsule')
> 
> is likely the required fix before the test?
> 
> At the same time, we want to make sure this gets tested, so if nothing 
> actually runs this test anymore, we should indeed add it to sandbox_spl 
> (or any other defconfig that is used for testing), but in a separate 
> patch, that justifies this addition not by saying we unbreak a test, but 
> that we actually run a test.
> 
> Cheers,
> Quentin

The test is run from the script test/run at line 82 [1]. As this is not 
a pytest your suggestion is not possible. I should probably have 
mentioned it was a binman test in the commit message.

The test is run for both 'make qcheck' and also 'make tcheck'. The 
sandbox_defconfig board is the only sandbox board that currently builds 
mkeficapsule but this board is not built for 'make tcheck'.

The binman tests are run pointing at the sandbox_spl_defconfig build 
tree as that is built for both 'make qcheck' and also 'make tcheck'.

So the simple, easy fixes available are either 1. Switch the binman test 
to use sandbox_defconfig build tree which means adding that build into 
the run of 'make tcheck' and so taking longer to run. 2. The fix I 
propose which is to just add the build of mkeficapsule to 
sandbox_spl_defconfig.

At the moment 'make tcheck' runs the test but it fails and it fails with 
an obscure message if it picks up the system mkeficapsule that does not 
support the right options.

Andrew

1. 
https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/test/run?ref_type=heads#L82
