Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30889C982E3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 856EB8389A;
	Fri, 16 Jan 2026 18:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sbx11QBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F50B83942; Fri, 16 Jan 2026 18:49:35 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF94D8389A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b872cf905d3so384893366b.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768585772; x=1769190572; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2m5OQ0mLImfRXxKFEPWFA2fq3Y5+8rIg8Kqk002lhQA=;
 b=Sbx11QBMpuH8iGU8L/Br9PBEf18ybgBs4jteNSlyEfHdy+1o0xEhokCgm9eGcuEQvw
 aRaJ32AA8Z7liq1TfFW9GHzGwg5y3RxZGBLYK8v25On51u5qIfDmxRhYGhKKDAZ8ZXTH
 LPseQiqHjDPmE3B2KO5cjCPluJxYIt+Kj8r+BRcXpGzgg22UlhfRxteDUJk89IA9CG/P
 tp/PvPbrc2nHCoNehZNlaBKkZH4LLGyvqn0MsWYbKzhzHRhIy3PGT8KhcF4ZUdcGJufP
 0c77k7iMGye6AEsst4MeV2KgIGRBi8KbHbPJuHgh4q0j1chqhmHEaT1JiVFPoIx5/Ilg
 YhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768585772; x=1769190572;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2m5OQ0mLImfRXxKFEPWFA2fq3Y5+8rIg8Kqk002lhQA=;
 b=fLsgtJKCtVkTXkwNnwsqfLKNfG+blmqNQCPJIrdYtHJexZF6PoX0h4j2Jy7PdbiTqB
 PK/STgtgnVsX2XzSneVsGPfKuqxNezfOImsCUAWaeBPx8OHU0tH6el6c90ExeIQTMvBu
 8QaUHBizUmDq3ABqCYd452VT0qe7yr7rUkMEY58PNkd8PqSZC1eLGpEryYYESpghOeq6
 Jx/GU7WNV2KSa8fa0tnHqE1CN/C71BomtyKfg035EotrCCXgxU/eb3UJix2FFPkt1oA/
 r1If96ACYt4XXglflYo7K+F1+uieLMJrS/oJlP69HpJ3a//8enRC9rMFCsH2lkHgM8Kj
 rOMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkSmY4d4vRNQf7JZUBDrYJ/CGczSNOiSmYcMX634L9aA+9TiaApzmn2G9/Z2hTwryIAptpLyA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo+ZNNpT+j7F3WxsSJQEHITC7V/S2TgSoyRMtfxxIy5WcAZU4d
 7+HoIigDda59pNLxwWjkPIZU7rCJowhjlCZVLi/OBqRfYl3QUqXdcb0EN1A631DV6Jo=
X-Gm-Gg: AY/fxX7F1naWJ2IimSk7KdkCHsxa2nv6BiZmcgKgUS/EZDENzcYczRoJ84kwOtVEN/c
 5WILGj9+M36JYCefk+dXhlcxX7djXfREW8syISde5C/AqaGf159X7XvW0ee5eL+LGFSU55uvQHI
 Y3jF4oMfOtVtJuaRhtJ4KwZYkekPYXkUMze4DF1Q3gcyw/EsdS/jaPEiR+NygAJkdRLIW0z+qQK
 XXUcpZg4DSCPjAlIgUz8XLXwOm0GWRBqMEhXEs9x43395E8YMiY8ytgZIHiIR/hawVkMxrHp2do
 G0OMqdjEkNyrVh89JLs9r9wBxFgESE1mN+LsK4q4kTHT8EjkFUfH6ImTnZfR5RRZThB65aHjc8D
 UlFnj2aNQI/dfwEHqjmW1sf6FhmTKsn8WLe7eNOKf2Fdcx1Cps0s29YsuPUQt2dIKhyAWg2pAPh
 AbjkI1GoJRlyJkN6JsdM7Zu4ok60eX6o0AktQX+7td5MVuol/EO9eY
X-Received: by 2002:a17:907:98a:b0:b80:fa9:674 with SMTP id
 a640c23a62f3a-b8796b953demr300994766b.54.1768585772170; 
 Fri, 16 Jan 2026 09:49:32 -0800 (PST)
Received: from [192.168.1.160] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452bce411sm2968318a12.7.2026.01.16.09.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 09:49:31 -0800 (PST)
Message-ID: <a8d1210c-565b-487d-9262-702980e45949@linaro.org>
Date: Fri, 16 Jan 2026 18:49:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: Enable FUA bit and remove per-write SYNC_CACHE
 operations
To: Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, quic_varada@quicinc.com, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
 <20260116155735.GA4063961@bill-the-cat>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260116155735.GA4063961@bill-the-cat>
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

On 1/16/26 16:57, Tom Rini wrote:
> On Mon, Jan 05, 2026 at 10:55:26AM +0530, Balaji Selvanathan wrote:
> 
>> Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
>> ensure writes bypass the device's volatile cache and go directly to
>> non-volatile storage. This provides write-through behavior without
>> requiring explicit cache flushes after each write operation.
>>
>> Remove the SYNC_CACHE command that was being issued after every
>> scsi_write() call, as it is redundant when FUA is enabled and was
>> causing system hangs during large sparse image flashing operations.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> This introduces failure to build on xilinx_zynqmp_virt and others:
> drivers/scsi/scsi.c:85:13: error: 'scsi_setup_sync_cache' defined but not used [-Werror=unused-function]

Balaji,

The patch introducing explicit SYNC_CACHE made quite a few more changes, 
I would recommend including a full revert of that in your patch (and 
properly referencing the commit in question!).

Kind regards,
- Casey

> 

