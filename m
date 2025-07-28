Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFB0C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 11:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C49282D06;
	Mon, 28 Jul 2025 13:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o3mnJdD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E7582D06; Mon, 28 Jul 2025 13:25:13 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA6481E14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 13:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso31609415e9.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753701911; x=1754306711; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K482/APcpQ0SMplrQZmYaErTOy+nbgFiAA2Hy5EMS7A=;
 b=o3mnJdD74Uhc/9HmEAysVe9VcV0BrIZhY6HQWCWRg8fzSpg47kT3VckrD6pi6GSlPO
 Nph1l9mV1bjpEA3cY+3x6v6jAnnoMqjzlIVSWngyUog+Ifp516cmo7UZIS0qgomGmUkE
 5XYGKgCWqtVZjans5Phsm/F26hUE9wHw2MblJ1ByIfkC2C/nX2w/TNbf1bmsh0asRP30
 OY2Al6CvR9liwv7zjLGup/LK2ifGGm32rl2NZKx9SJzUhXC0CwGo/usG4T4VzPktgKAI
 9EO6wi19aZDWJcqMjT9Im2f3aPQcKR7RyrP68cECuGxRM1yfcXhypOD957cU91IYcyNU
 lVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753701911; x=1754306711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K482/APcpQ0SMplrQZmYaErTOy+nbgFiAA2Hy5EMS7A=;
 b=xGmO0lXNJN45GomeQdvmjWcQdSqulFB8KWziLE4vIC9Swvn5INvRbCIxvmZUX2yysP
 o/ZgT3gjon6tokNVMlVzsOJnjaPHcqEyDv0fcTd26xKiFvbKCnKcuCv2ldHSLYUeonQg
 Y3vl/5hQ6Khf+V2NQC9mmNlvADUNfe16RF6CWXoGFUS8U0flH43Rx829FBo9M9MDIzlx
 8942D2Mpgm6WyXNqUxDC88hL9j4XUDsNaUlz1LYS5odafDeQwYMHo6eEl0iKd4UXGRnP
 Tnko1jtkji/qsEY5mDqJJS2igfqjq85z5/lCZ7VPLRoT2ehhS0YwJgv8m6f7wynelxsd
 +lwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcTlgPpDlvo9hpf6S324oknTZtEacNE+enZpstap+kUGx17doQ/jUk1vd4G0iFbO6U4TN9SOA=@lists.denx.de
X-Gm-Message-State: AOJu0YxF+eM4D0a/54M5G+uhEbrL2LoSow+1JNHweiFmpMUw+yQV5CG/
 ks2in1qSR9khb5iGDFPTykHtIZ1h8rQ2K+vZR2T4u1PSVHT1Yj3iB9kDGg33OmFSb1LYai1BxZ3
 JBsf2
X-Gm-Gg: ASbGnctOCYNng6os2NpEVvmM13ZRIPApQBKIG3A7ao/ead2nzcURoFyU7UFkaVSrByW
 T5k7mNux3/R3U1yp0vaSBYEsurYmu0kJxMIoNRO58s0ruHpVUULVwiu2NFt8ano8Rh+pi9doKw6
 voLRdvz9R1RgPZS+rm2ekzNw++tjF6dM/Trt3gUX9zXQ4G6rJx9D2b73QRrTeAtNF/8b+3pKRWr
 9PDnApb4nKh0DigCVRVK614s/rlnydImRxvaYj2a4hBxNui+8TIIRwLVNuPGK8fQdE1L+ZQ1KXK
 AMLB/DxzqHuWE/W0He068JtacpLtAnBCzV14Y79+ztchoeQRVeboUTmrYx21wO879exmPImC/1a
 P4DAaa6qcV2xyJagFhoki6bFcQ+KKEFs1T07b9/Zm7gOVomGIMTHwkm2hvTB3xgbfcvGcBYbrNf
 0=
X-Google-Smtp-Source: AGHT+IFfahIXnkjBa/rLKTmgUE8UrcFBKQ+X38vkZASWHQNRz4cC+19ijA3QYVZ/DZVLro/7pr839w==
X-Received: by 2002:a05:600c:1da8:b0:456:1006:5415 with SMTP id
 5b1f17b1804b1-4587d83d695mr54841755e9.6.1753701910902; 
 Mon, 28 Jul 2025 04:25:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3?
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705ce781sm152236915e9.31.2025.07.28.04.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 04:25:10 -0700 (PDT)
Message-ID: <5bfc235e-d199-4afe-bc07-a03b27fa5f87@linaro.org>
Date: Mon, 28 Jul 2025 12:25:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Smatch report for drivers/fpga/socfpga_gen5.c
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <31ac4742-d516-4b5e-8f7d-6f8d23b77119@linaro.org>
 <48b253d1-1ae0-4fa8-910d-b6ade557a5a7@gmx.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <48b253d1-1ae0-4fa8-910d-b6ade557a5a7@gmx.de>
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

On 25/07/2025 13:22, Heinrich Schuchardt wrote:
> On 25.07.25 13:09, Andrew Goodbody wrote:
>> Smatch reports this issue
>>
>> drivers/fpga/socfpga_gen5.c:135 fpgamgr_program_poll_cd() warn: 
>> duplicate check 'reg & mask' (previous on line 129)
>>
>> Looking at the code I am not sure that it will work as intended. There 
>> are two if statements within the for loop that test for opposite 
>> conditions so could easily be combined into if..else with a single 
>> test. But also both if statements result in the for loop being exited, 
>> and one of them must be satisfied so the for loop can only ever be 
>> executed once. This surely must not be the intention. It is not clear 
>> to me whether the error test is wrong and should be changed to a 
>> different test or it should simply be removed. Could you take a look 
>> please?
>>
>> Thanks,
>> Andrew
> 
> As we have been running with a single iteration since 2017, probably the 
> for loop and the if statement relating to FPGA_TIMEOUT_CNT should be 
> removed.
> 
> Best regards
> 
> Heinrich

Thanks.

Patch coming.

Andrew
