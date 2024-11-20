Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9D6D44171
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B399895D2;
	Wed, 20 Nov 2024 10:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UtesRkYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB18895E2; Wed, 20 Nov 2024 10:59:42 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744D1895BD
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38232c6311fso2968922f8f.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732096780; x=1732701580; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q1ViDFCGUfBpBeG/b2fOp+2CozjIazW+38/UQk8TlAA=;
 b=UtesRkYiZ7RJpTyfN9L53fu0LJtWx6ya7AfW7h0peyBaRrnijwLXu3EXGLEa+IHj3T
 FThMavk422PL703kesj2YXVqNzwUOxkhScONoLXtAXvy6kDv9rBtjMeA3JY7dSvckY17
 K3YGihwvJtH8xkiineWE3A48FOdGXieyy+V3I2gbE86qij3ArY9spYbZl07lpuDuRLOm
 Sv1P9XDc/aTiyUchlQVyGJuoDSiQho5CsO1iNPyUQTYp1DePlci6z8PloPuGVTc0Jj+9
 xsfopA6II+4sCMSRdPFBPoNTRjLYEzcF7Ttvul2p6v5zWV+PZuMkBHZ/Uf/vmyZ0opFy
 ySaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732096780; x=1732701580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1ViDFCGUfBpBeG/b2fOp+2CozjIazW+38/UQk8TlAA=;
 b=d/vI2xHCyQB9zuVkVJOMcK4OuHUasUYt6qBe1yGKsDrxmlL+ZYJ7h18ekRW5/z1V8W
 lqXwdAKzufvVJTD8+ZjGkKAsK/JVrI9tm1CArwAoH6LzO2qWxgPlfyS3uXdZ7HB5NCCj
 bK/nFjbvZRHORe2VY5fGv8YNYEpRgHjBzSBlVRXcxRN3Y5M0MhzTUoJgA96BQvjYWCqK
 zUndy+CvSLLoJQD5ED6gQpm8q7g5vz6pKR9odQllQz7AuVt88qkiZZHyCjWkQyKDEBH/
 Ov8kj2dp4eXbxQ9l0q+HXVT6kHoh7G3a+0D/jFjW7y84phcDaCDL4tr8E1TfBe3Mi96K
 n1vg==
X-Gm-Message-State: AOJu0Yy+SZ83uMlWWOwoYhY8YGrY4+9IdH8wAG2Xdm1u2k2K+nnhAa00
 WNrIynOM6mjy2U/NGeUyZqwIOXBKsOR1IJ4M4m/jHLVqqVEpCXRDLyryvzg+weU=
X-Google-Smtp-Source: AGHT+IEJFLt8LIm3wEjWPfvZrS4MR567xmt0W8LxZLB/hz6nEAL+mliOeUs8S3klB8yQFkJft/fMcA==
X-Received: by 2002:a05:6000:154e:b0:37d:4706:f728 with SMTP id
 ffacd0b85a97d-38254b203b8mr1615570f8f.50.1732096779871; 
 Wed, 20 Nov 2024 01:59:39 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309?
 ([2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254793404sm1691154f8f.0.2024.11.20.01.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 01:59:39 -0800 (PST)
Message-ID: <7398c2d7-7e50-4c6f-aed5-67ea7db4c656@linaro.org>
Date: Wed, 20 Nov 2024 09:59:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Select CONFIG_64BIT for sandbox64 and x86_64
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
References: <20241106124215.677519-1-andrew.goodbody@linaro.org>
 <20241113215337.GX3600562@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20241113215337.GX3600562@bill-the-cat>
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

On 13/11/2024 21:53, Tom Rini wrote:
> On Wed, Nov 06, 2024 at 12:42:13PM +0000, Andrew Goodbody wrote:
> 
>> Picking up a series from Dan Carpenter and applying requested
>> changes for v2.
>>
>> I had previously set CONFIG_64BIT for arm64.  This patchset does the
>> same thing for sandbox64 and x86_64.  (Mips and riscv were already
>> doing it).  This CONFIG option is used in the Makefile to determine
>> if it's a 32 or 64 bit system for the CHECKER.
>>
>> Makefile
>>    1052  # the checker needs the correct machine size
>>    1053  CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)
>>
>> Changes in v2:
>> Resubmitted by Andrew Goodbody with changes requested by reviewer
>>
>> Andrew Goodbody (2):
>>    sandbox: select CONFIG_64BIT for SANDBOX64
>>    x86: select CONFIG_64BIT for X86_64
>>
>>   arch/sandbox/Kconfig | 1 +
>>   arch/x86/Kconfig     | 1 +
>>   2 files changed, 2 insertions(+)
> 
> Unfortunately this leads to various CI failures:
> https://source.denx.de/u-boot/u-boot/-/pipelines/23345
> Azure would show them too, but I cancelled the pipeline to free up the
> queue. Please see
> https://docs.u-boot.org/en/latest/develop/ci_testing.html if needed for
> how to get Azure runs done. Also on a related note, can you please
> update test/lib/str.c to use CONFIG_64BIT and not CONFIG_PHYS_64BIT
> while you're doing these kind of corrections? Thanks!
> 

I am about to send v3 of this series. Passing CI run at
https://github.com/u-boot/u-boot/pull/696

Andrew
