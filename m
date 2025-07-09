Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF45BC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 11:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE5A883443;
	Wed,  9 Jul 2025 13:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B/yARroK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2CE83447; Wed,  9 Jul 2025 13:48:38 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A9F8343B
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 13:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso3072154f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752061715; x=1752666515; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLMdIfD6Q5fekNVCsN/ea6fmvr/3Gxsu7OrHKugYLWI=;
 b=B/yARroKhaSrmhmVmWLNDzN8XGLTeOlXbNHCuJDuUFl/6dKWtOvChrLoDcFzMOabFm
 QIjuGjGtqA9XFO+Qp4IkUnUygLCyA6UcXb3n4xbBBu/+018NNR8Qq9nQlTN+CfU+JbrD
 4MP8ZJoRDqB36fMwaqYSHe29WltSIFU4VYwyg2aFswo1FnvYCuljJgQaABUmZu5X5XZN
 L5r2vLCJEjds9UApV2E7pudFRiil1zWiFRyGEpmnPxLKbBF7dzHD84FgcBmicVsb1hI+
 m4jFtPKcioXrUL6sBSf7bPyMWgqPNkbtvgEE7jIGl6gdBK8FR2U7m83Z+hI28EaZNLKT
 2SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752061715; x=1752666515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wLMdIfD6Q5fekNVCsN/ea6fmvr/3Gxsu7OrHKugYLWI=;
 b=Vrwa1nBJKW5uVECXJZ7GiyWkcc5yxRfime7hAXbEnUoxKMHfZkijUXvjSePP1qvbNQ
 h+b/jtfF/hz4sz41i3pH+EEm5QKT2mw2lPjRkQfZ53WG/5Uym7utzP66haE213YZr2da
 5EOBSHPySc7TKXd9ynni6AdGn/Tn9hdZVrH0unmKKbi/MBTRDxgE+k9f8r9hSD7cS4oU
 cJDp4FmYeWgVXM6Bw6Z+Bi0hk/ogRfVrHNRSPf9KC51d19WYnSDPdr8t9ZOnnnkMQVAB
 rnT3rG2Wttopx2ZinXFi0BfEWq4b4NWl4FH4xHlda5C1DRT+5NvM1Ab6jeeNfF9O3H2u
 tcdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlKaRzXapGvKIh/UPQ3AhZwa2O/2rQxTr0hbd8/oKVTeZjcvxOeAVApfz8kKYdHrV29ie6tIA=@lists.denx.de
X-Gm-Message-State: AOJu0YxaDj+AQeQWYMJopkiYXWvrbKjiixDrv4Jz7/EzffDtrUqeebd5
 qJXAPW3sKTlWBPUAiW/xnhEA6oiZh5+S+6DdeF38d95vlON68hrRIgN7T7ZWas0zfPg=
X-Gm-Gg: ASbGncuQQw8l5J62i2QzS+hBiQxp+fXEmOt86uPLR2B+CDKd8j2fxu+zoOdgj8KCKVk
 uCv7GRy/nTA281tfRt1chImM3bz0STxCwfEyd1YphcK9tOzUVI6L+Eby8eKELTzzzUPjlDCYKwT
 5VCuACzuvTk6owH+6vihi3rxQd7i1neAxi2XtAoKp0i6Ot8VWVu1+jRRaSn72OzaV+tegRqG5ed
 gFUzv8FPw3kN236cx7ycaGL6mtiLtH4bRyQGnzWib5CDHFHpo7pjWAeLCEu5pUrkxz0Q0WWGhDk
 e/QNFpz6kIBH8/96lKFvXW4A597rF1pjzGhMsD5//fPdpuJ525l+OltK4lad29IYFAJ6h0xwuJC
 AGxIZ3TH4h7uAAyMNdCMDkeMeNmC3k/ocDdV4fWx4PVmFykyHVA==
X-Google-Smtp-Source: AGHT+IHTT83/7lZrZVeIEI3xkZspA/EVzK/oIISly+p6nhiCltewMp4isgUEan1QrQnWYybxm2FiVw==
X-Received: by 2002:a05:6000:178f:b0:3a5:25e0:1851 with SMTP id
 ffacd0b85a97d-3b5e44e3f6amr1762502f8f.7.1752061715376; 
 Wed, 09 Jul 2025 04:48:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:7978:74ac:133f:8950?
 ([2a0a:ef40:e07:801:7978:74ac:133f:8950])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b470caa1a2sm15349880f8f.42.2025.07.09.04.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:48:34 -0700 (PDT)
Message-ID: <ffe50b06-1819-4925-b283-a9d4e68b2e5a@linaro.org>
Date: Wed, 9 Jul 2025 12:48:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: Ensure method_flags is initialised before use
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250627-bootflow_fix-v1-1-f1039b2962d6@linaro.org>
 <20250709001445.GA1724532@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250709001445.GA1724532@bill-the-cat>
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

On 09/07/2025 01:14, Tom Rini wrote:
> On Fri, Jun 27, 2025 at 11:09:36AM +0100, Andrew Goodbody wrote:
> 
>> The local variable method_flags is only assigned to in some of the
>> code paths leaving it possibly uninitialised at first use.
>> Initialise method_flags at declaration to ensure that it cannot be
>> used uninitialised. Also remove now redundant assignments.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   boot/bootflow.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/boot/bootflow.c b/boot/bootflow.c
>> index 4054a966af8..d60e9df6a9d 100644
>> --- a/boot/bootflow.c
>> +++ b/boot/bootflow.c
>> @@ -245,7 +245,7 @@ static int iter_incr(struct bootflow_iter *iter)
>>   	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
>>   		ret = -ENOENT;
>>   	} else {
>> -		int method_flags;
>> +		int method_flags = 0;
>>   
>>   		ret = 0;
>>   		dev = iter->dev;
>> @@ -264,7 +264,6 @@ static int iter_incr(struct bootflow_iter *iter)
>>   		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
>>   			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
>>   			log_debug("next in single\n");
>> -			method_flags = 0;
>>   			do {
>>   				/*
>>   				 * Move to the next bootdev child of this media
>> @@ -306,7 +305,6 @@ static int iter_incr(struct bootflow_iter *iter)
>>   				}
>>   			} else {
>>   				ret = bootdev_next_prio(iter, &dev);
>> -				method_flags = 0;
>>   			}
>>   		}
>>   		log_debug("ret=%d, dev=%p %s\n", ret, dev,
> 
> This leads to failures in CI:
> https://source.denx.de/u-boot/u-boot/-/jobs/1195854

The code was relying on the uninitialised method_flags having 
BOOTFLOW_METHF_SINGLE_UCLASS set in it. This was a hard to track down 
bug just waiting to happen. V2 on its way.

Andrew
