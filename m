Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB93C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 13:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A81678209C;
	Tue, 15 Apr 2025 15:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fb4M8zU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A9F82AF4; Tue, 15 Apr 2025 15:36:58 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3ADF810F4
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 15:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so39586055e9.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744724215; x=1745329015; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YsNuSyec7jdXM8C0OT1Z7BlmcFgFpsMV6lUQ9PrZ5xs=;
 b=Fb4M8zU2mQudZiwqbj4kwbs02uC9Ce97ZPjVDdjGq/twiDZDIauSabwoYZh0KzBwW7
 M2LCPZqpg/j762k1iVSF1105XfXPValW44A3C6egX5rM7xNwQae1gYH8unoHrVFCKke/
 15xfNHIGF/kyPNH+fHy9In8KP5y1OniFjtGKW5s1ivmx81U7s3puiR4Oh86CbY0vIg7h
 AHp5tCFk5otv9PGlKfwp+N23p90lyIqFKgO5LlG3QNzYz/yN9bKbQWg2re9ev35GZhDm
 Y9oA9ir4k84oK1ZOegltezvS4iTtJqv0vxTOG/B2ij2MUg1WaJCmJFGVoj6+hVudnVjU
 YvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744724215; x=1745329015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YsNuSyec7jdXM8C0OT1Z7BlmcFgFpsMV6lUQ9PrZ5xs=;
 b=icmxMvuzZ2omThn74JVd1A0IkmNG5nOadm79N9Zc9VV8eJjckT4NDHDJ56wayLEuAF
 7pNosucnEN4rKPtuSJ8YGjpv+N1Fbn323wh0jSk0wA2NfRV4EaI2O8HsTBdPvt5m4yO5
 nmfwBQvy3VbbQR7NxDDfucB8IIFp0sVTIx2v/sEGbBKir69cnvHWz3/haULnoEBM5pmE
 aP/HuwgJHQmWPkDgvZxzUosHrQSpWPSsOo59Fvd9BFf2HhRqSn6jWFfWLuDOFiJj3ies
 s/6rDlEn92DoaS4d0qbxD0D0ho7XhV/cqF7kvVq0nK00oMsQIODNd3f8CicAvwAj/iBq
 1q5w==
X-Gm-Message-State: AOJu0YzM+eRzzRZxWnpjTWQcBewXo5dFB+9L023WufeH4Tna8B97l+Vq
 AX71PGmyjy7C5dAaqGzi2GwH9niVLvf2rZM00eYDG7AsowQjRFLIwBP5pD76in9ul6xiUkEDwwn
 KNtQ=
X-Gm-Gg: ASbGncuw6uYkFPBa1qrRmOKe418HYB1Wj0eNxARgPJwxwAJeBadd9FLHxhDxUO3aUvf
 nRm3SB1aQX05XtxsuPySY3dr4X6P/ftf5uI/MkFsPhQjSaIyQ1ZEtsjFTh42i72RXMsdpFXwgfA
 6WIXWEwSATHL16wTatc4MbyZfdT/XhMfo732xXrY/ZjiigICtjzr39N3NyuArssyfNlpsLWS4F3
 Zir+FZ2G8gDJBu0sjcFoU9iNXPI5Vsd2iArAwh8pql/XsALLbYBRFYISmoIjJNI2PJzBjAyCA2l
 ZIql+Vh1Xzh7VHmqKbJycr6uBmoQRjBG8ntPXBNiqAjMUxbNPM0=
X-Google-Smtp-Source: AGHT+IE5CkLAnGAzzfK2IA9VcO/guI+5Do+feO/wyTQCBv8TJWPW/a4+xzo+XW3pgGwg3FHk42RMQA==
X-Received: by 2002:a05:600c:5107:b0:43d:585f:ebf5 with SMTP id
 5b1f17b1804b1-43f3a925f4dmr133828815e9.1.1744724215392; 
 Tue, 15 Apr 2025 06:36:55 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9640a9sm14374888f8f.10.2025.04.15.06.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 06:36:55 -0700 (PDT)
Message-ID: <8f1d8b98-6eff-4986-acad-f4eb7da87446@linaro.org>
Date: Tue, 15 Apr 2025 15:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] Uthreads
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
 <20250411202910.GA141451@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250411202910.GA141451@bill-the-cat>
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

Hi Tom,

On 4/11/25 22:29, Tom Rini wrote:
> On Mon, Mar 31, 2025 at 02:30:54PM +0200, Jerome Forissier wrote:
> 
>> This series introduces threads and uses them for two things:
>> - Improve the performance of the USB bus scanning code (scan multiple
>> busses simultaneously),
>> - Implement background jobs in the shell via two new commands: 'spawn'
>> and 'wait'.
>>
>> The threading framework is called 'uthread' and is inspired from the
>> barebox threads [2]. setjmp() and longjmp() are used to save and
>> restore contexts, as well as a non-standard extension called initjmp().
>> This new function is added in several patches, one for each
>> architecture that supports HAVE_SETJMP. A new symbol is defined:
>> HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
>> scheduling, are added to the lib suite.
>>
>> The schedule() and udelay() function are updated to become thread
>> re-scheduling points, and mutex objects are introduced. With that the
>> USB stack initialization is modified to benefit from concurrency when
>> UTHREAD is enabled, where uthreads are used in usb_init() to initialize
>> and scan multiple busses at the same time. The code was tested on arm64
>> and arm QEMU with 4 simulated XHCI buses and some devices. On this
>> platform the USB scan takes 2.2 s instead of 5.6 s. Tested on i.MX93 EVK
>> with two USB hubs, one ethernet adapter and one webcam on each, "usb
>> start" takes 2.4 s instead of 4.6 s.
>>
>> Finally, the spawn and wait commands are introduced, allowing the use of
>> threads from the shell. Tested on the i.MX93 EVK with a spinning HDD
>> connected to USB1 and the network connected to ENET1. The USB plus DHCP
>> init sequence "spawn usb start; spawn dhcp; wait" takes 4.5 seconds
>> instead of 8 seconds for "usb start; dhcp".
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=446674
>> [2] https://github.com/barebox/barebox/blob/master/common/bthread.c
> 
> So, we're nearly there. But there's some CI problems. First, CI isn't
> testing this because nothing enables UTHREADS.

Thanks for looking into this.

I do have a TESTING patch [0] that enables this for various QEMU plaforms
(arm, arm64, riscv32, riscv64) and for sandbox64. Please refer to the
following CI pipeline [1].

[0] https://source.denx.de/u-boot/custodians/u-boot-net/-/commit/8460f6abefff
[1] https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25706

> I don't know if we should
> enable it by default on qemu_arm64 for example or not.

Good question. Perhaps we could have a separate defconfig for the somewhat
experimental stuff?

> But for testing,
> I added this to .gitlab-ci.yml (and something similar would work for
> Azure):
> qemu_arm64_uthread test.py:
>   variables:
>     TEST_PY_BD: "qemu_arm64"
>     TEST_PY_TEST_SPEC: "not sleep"
>     OVERRIDE: "-a CONFIG_UTHREAD=y -a CONFIG_CMD_SPAWN=y -a CONFIG_UNIT_TEST=y"
>   <<: *buildman_and_testpy_dfn
> 
> This however leads first to unrelated tests failing:
> https://source.denx.de/u-boot/u-boot/-/jobs/1099921

Unrelated indeed. It turns out UNIT_TEST=y on qemu_arm64 is broken in master.
I just posted a fix [2].

[2] https://lists.denx.de/pipermail/u-boot/2025-April/586897.html

> And I didn't see if the new tests ran either.

It seems you need to enable CMD_TIME too. In my testing patch I added -v
(verbose) to the test.py command so that we can clearly see that
lib_initjmp [3], lib_uthread [4] and lib_uthread_mutex [5] are run in CI.

[3] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1103031#L457
[4] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1103031#L504
[5] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1103031#L505

Thanks,
-- 
Jerome
