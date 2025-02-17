Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3935C021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 09:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBDDB80F5C;
	Mon, 17 Feb 2025 10:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sHdgNFCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1442D80F60; Mon, 17 Feb 2025 10:48:32 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A299C80F56
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f32c1c787so1566819f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739785709; x=1740390509; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v2woK1ePFwPSKi50BluvqXZAfv+rdA/BLzcRq7ZYerM=;
 b=sHdgNFCIdOlsI0s++excnjZF/AarHgOTC17pFNXsdUJbt5y6HLe5DBAblaZMB6SlgO
 3RX+cyON864TOo7wSEBRcFazuytdlIagsrLgmRlJZezAIgXMYH7ek6AtiNbwebyXc4zZ
 V/eF48AHG5sX2m7htr8C1NL8OI2tu4mgY4fkT/RMAV51YMAWPOnOs+irgWnB1yZR1zb4
 EjfVTakZzAA+Bmvtm9jyHTcTaEslN5uHTF9NQqTqAB5iCBsMM61Utp05191wx6VZZx5k
 jDXvVCd5RfParJeOHjYaHyBhzzv9hw48voNORLB+u8lyeN3/290bymU3JSFICsbvoDUt
 hEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739785709; x=1740390509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2woK1ePFwPSKi50BluvqXZAfv+rdA/BLzcRq7ZYerM=;
 b=lVedd4sHxNhQ5LMHjQ+iMjyT3a9BQmzOacgKHuq9U6CBVSuQ6mLjqYVsx5/tGJ8rCc
 JLUbuQ9HDBuCDW1qLPbqtT4XEqYhOg3GHorWGu7kDjGpvNu/rhQgT+XeYOi4jXMX3E/N
 BE0dBxhbFv50SrNufu6gaarXtQ4a9uM0xFb6KfSXrMiEfUvw60X8ajl+Km6LsKhen9on
 BYgnlOiUJUptVhPns0hRLavI9bGmHcC3n+XeOmB3dNa8AerZ+0a3ABBOV2rBVTCf9uNk
 nS5n2SdQl5L0In6q++tP2gzcAEl0mjVuFSrok8NwE8C2iFwGFtBbRXKddjaeuaqfgizm
 Fk+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7dGXXBoFa+vn7mABRvY5Dvpuh/yEmekENZbdwNR4pstIs+y00CvleFrcbarJf7odj/Gzu7VM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw09DZX2nclE//6V+FJGlV/9//AvDW7D8Yjua9triQAkNozcPa7
 Pe8InHz6eTFLOT7q/5/2QIn3/Ap0mgBxzBGpTxcUmvUrclVRtdHm4F1y+/GXAQI=
X-Gm-Gg: ASbGnctcFVqcNxm8J6nVbLIW6dQqsfMN3t/vkBzT5Ho11YUuLvIf19/yRp1YZ3lcDUi
 YI2p2TtWV89NgW5rDjgieYaO88ql8znc9cgZUewO1l8gIDJ38W8eAPHz4ASsDJIwaMhaGGW1IBy
 nhrHz8TSn96P2zNLfHia3FiRGDcQuNScmpglZs22xPHL/Von/WVDGqCkjIGUNBAN1lr0+3nmwor
 3aT1+4N9ZE3BxZz0qNxVN8c6Le6j/GNrEPRRVoks/oxeakJ0r7gmBjEnluFxdFMALuUlEaxr+N2
 IviOEwXodTyAOcHzKgu4XzYB25Lj/JR/zu50SFIkw9VVfjsBBR1XlR9A1sJdgGT5Fjy/TVw=
X-Google-Smtp-Source: AGHT+IG2ya1Z4cUix6FW+F2o8pHeJiUTUJ8AXpvjGOuG2CmkAfZbV71i+eNFCwY7k3SFzmsTu6gFcQ==
X-Received: by 2002:a05:6000:381:b0:38f:22f1:de7d with SMTP id
 ffacd0b85a97d-38f33f4a965mr8692671f8f.39.1739785708217; 
 Mon, 17 Feb 2025 01:48:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d3ab:98e5:89c8:6d18?
 ([2a01:e0a:3cb:7bb0:d3ab:98e5:89c8:6d18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd2csm12066914f8f.30.2025.02.17.01.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 01:48:27 -0800 (PST)
Message-ID: <8927c5b3-8742-4678-afc5-6bbe6fc0fdc0@linaro.org>
Date: Mon, 17 Feb 2025 10:48:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/10] uthread: add cooperative multi-tasking interface
To: Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Raymond Mao
 <raymond.mao@linaro.org>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-7-jerome.forissier@linaro.org>
 <Z6-KtxZxp2JfsSMP@pie.lan>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <Z6-KtxZxp2JfsSMP@pie.lan>
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



On 2/14/25 19:25, Yao Zi wrote:
> On Fri, Feb 14, 2025 at 03:00:21PM +0100, Jerome Forissier wrote:
>> Add an new internal API called uthread (Kconfig symbol: UTHREAD) which
>> provides cooperative multi-tasking. The goal is to be able to improve
>> the performance of some parts of U-Boot by overlapping lengthy
>> operations. Each uthread has its own stack allocated on the heap. The
>> default stack size is defined by the UTHREAD_STACK_SIZE symbol and is
>> used when uthread_create() is passed zero for the stack_sz argument.
>>
>> The implementation is based on context-switching via initjmp()/setjmp()/
>> longjmp() and is inspired from barebox threads [1].
>>
>> [1] https://github.com/barebox/barebox/blob/master/common/bthread.c
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  include/uthread.h |  31 ++++++++++++++
>>  lib/Kconfig       |  19 ++++++++
>>  lib/Makefile      |   2 +
>>  lib/uthread.c     | 107 ++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 159 insertions(+)
>>  create mode 100644 include/uthread.h
>>  create mode 100644 lib/uthread.c
>>
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 1a683dea670..c3416bbd0be 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -1255,6 +1255,25 @@ config PHANDLE_CHECK_SEQ
>>  	  enable this config option to distinguish them using
>>  	  phandles in fdtdec_get_alias_seq() function.
>>  
>> +config UTHREAD
>> +	bool "Enable thread support"
>> +	depends on HAVE_INITJMP
>> +	help
>> +	  Implement a simple form of cooperative multi-tasking based on
>> +	  context-switching via initjmp(), setjmp() and longjmp(). The
>> +	  uthread_ interface enables the main thread of execution to create
>> +	  one or more secondary threads and schedule them until they all have
>> +	  returned. At any point a thread may suspend its execution and
>> +	  schedule another thread, which allows for the efficient multiplexing
>> +	  of leghthy operations.
>> +
>> +config UTHREAD_STACK_SIZE
>> +	int "Default uthread stack size"
>> +	depends on UTHREAD
>> +	default 32168
> 
> Why choose 32168? It's even not a power of two. Typo for 32768?

It is indeed a typo which I will fix in v2. 32 KiB is quite arbitrary and this
value is used only when the stack_sz argument to uthread_create() is zero
(hence the wording "default stack size"). I believe it is large enough for
most needs, and not too large to not exhaust the heap when a few threads are
created.

> 
>> +	help
>> +	  The default stask size for uthreads. Each uthread has its own stack.
>> +
>>  endmenu
>>  
>>  source "lib/fwu_updates/Kconfig"
> 
> Thanks,
> Yao Zi

Thanks,
-- 
Jerome
